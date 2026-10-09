# AutoCAD API answers for the testing effort (10 Oct 2026, 05:05)

For: desk plan/03. From: the AutoCAD API decompilation chat. Sources: the decompiled AutoCAD 2027 wrapper
(`C:\Tools\AcadDecomp\2027\`, read-only, never in a repo) and **18 headless REDO tests measured tonight** in the
AutoCAD 2027 core console (`C:\Tools\AcadProbe\runs\20261010-044632\`). Core console only: the full AutoCAD window
and a real drawing switch were NOT tested (the console has one drawing). Witness branch read at
`origin/claude/tooling01-witness-recorder`.

---

## 1. Why the witness recorder logged no object events: its own lookup drops every event (proven)

1. The subscription is fine. `Database.ObjectAppended/ObjectModified/ObjectErased` (`acdbmgd Database.cs:7156`)
   store the handler in `CMgdDatabaseEventImpl.GetOrCreateEventImpl(nativeDb)`, kept per NATIVE drawing by
   `DatabaseMapManager`, so subscribing through any `Document.Database` wrapper works and survives that wrapper
   being collected. No lock is needed; LISP and U are not filtered out in the managed layer.
2. The raise site builds a **brand-new wrapper for every event**: `CDatabaseReactorImpl.il_objectAppended`
   (`acdbmgd -Module-.cs:158738`) does `Database sender = Database.Create(m_db, autoDelete: false);
   handler(sender, e);`. The same applies to ObjectModified and ObjectErased.
3. `WitnessPlugin.LogForDatabase` (`WitnessPlugin.cs:145`) compares
   `ReferenceEquals(kv.Key.Database, sender)`. `Document.Database` also returns a new wrapper per call (measured,
   test G1: three reads of one drawing gave three different .NET objects). So ReferenceEquals is ALWAYS false,
   `log` is null, and `ObjectLine` returns silently. Every object event is dropped.
4. **Exact fix** (one line). Wrapper `==` and `Equals` compare the native drawing (measured true in G1):

```csharp
private WitnessLog? LogForDatabase(object? sender)
{
    if (!(sender is Database db)) return null;
    foreach (var kv in _logs)
        if (kv.Key.Database == db) return kv.Value;      // was ReferenceEquals: never true, new wrapper per event
    return null;
}
```

   Optional extra safety: read the database from the object instead (`e.DBObject.Database == kv.Key.Database`).
   Same trap anywhere in CE or tools: never `ReferenceEquals` two Database or Document-derived wrappers.

## 2. Where REDO lives, and does a document switch touch it in the managed layer

1. **The managed layer keeps no undo or redo state.** The only managed calls into AutoCAD's undo machinery are:
   `Database.UndoRecording` / `Database.DisableUndoRecording`, `DBObject.DisableUndoRecording`,
   `Autodesk.AutoCAD.Internal.Utils.SetUndoMark / WriteUndoBoundary / DisableUndoRecording`,
   `Internal.CoreUtils.SetUndoRequiresRegen`, `Internal.ViewUtil.GsLensLength` (setter writes the view into the
   undo controller), and the in-place text editor's undo markers.
2. **Nothing in `Document`, `DocumentCollection`, `MdiActiveDocument`, `DocumentActivated`,
   `DocumentBecameCurrent` or the view-switch code (AcWindows DocumentSwitch) calls any of those.** Whatever clears
   REDO on a drawing switch happens inside native AutoCAD or in code that runs a command (see 3).
3. A quick read of CE's own switch handlers (`CompoundEditModeService.OnDocumentActivated`,
   `CivilHelpHost.OnDocumentActivated`, `InspectorPaletteService.OnDocumentActivated`, on master 650c0c19) found no
   command started directly from the switch. Not traced exhaustively: Idle handlers that run after a switch were
   not followed.

## 3. What kills REDO (MEASURED: CIRCLE, U, action, REDO; 18 runs)

**REDO survived only with nothing in between, or a bare LISP expression `(princ)`.** Every one of these gave
"Nothing to redo":
1. **any command at all, even one that does nothing**: a CE-style `[CommandMethod]` with an empty body, and a
   `CommandFlags.Session` command with an empty body;
2. built-in `ZOOM _E`, `REGEN`, `SETVAR CLAYER 0` (same value);
3. inside a command: `StartTransaction` + read + `Commit`; open ForWrite with no change + `Commit`;
   `StartOpenCloseTransaction` + read + `Commit`; a same-value write + `Commit`; a write then `Abort`;
   `Editor.Regen()`; `Editor.SetCurrentView(same view)`; `SetSystemVariable` on a drawing variable (CLAYER) or a
   registry variable (OSMODE) with the same value; `LockDocument()` + dispose in a session command.
   These ran INSIDE a command, so the command itself already killed REDO: the list does not prove that each call
   alone does.
4. `Internal.Utils.SetUndoMark` crashed the core console (acmgd is desktop-only): not testable headless.

**So for the Cecil guard: the question is not "did CE write?" but "did ANY command run between U and REDO?"**
Look for: `SendStringToExecute`, `Editor.Command/CommandAsync`, `DocumentCollection.ExecuteInCommandContextAsync`,
`acedPostCommand`, ribbon or palette buttons that send a command, and anything on Idle or DocumentActivated that
does one of those. Transparent commands typed with `'` and mouse-wheel zoom in the full AutoCAD window were not
tested and may differ.

**Decisive next test (full AutoCAD, needs the driver or Codex; not done):** in a vanilla AutoCAD 2027 with CE
NOT loaded, draw a circle, `U`, switch to another open drawing and back with Ctrl+Tab, then `REDO`. If that alone
says "Nothing to redo", the lost REDO is AutoCAD's own behaviour and not a CE bug. Repeat with CE loaded only if
vanilla keeps REDO.

---

# Round 2 (06:30 questions, BUG-558 with a CD pipe), answered 06:40

## R2-1. What writes VIEWBACKSTATUS

1. **Nothing in the managed layer.** No `.cs` file in the decompiled acdbmgd, acmgd, accoremgd, AcWindows or
   AdWindows (2027) mentions VIEWBACKSTATUS, and the ObjectARX 2027 help has no page for it. It is set inside
   native AutoCAD only. By its documented meaning (whether ZOOM Previous is available) it moves when the
   previous-view list changes; what pushes that list on a drawing switch is native and NOT established here.
2. The only managed call found that writes a view into AutoCAD's undo controller is
   `Autodesk.AutoCAD.Internal.ViewUtil.GsLensLength` (setter → `acgsWriteViewToUndoController`). CE does not use it.
3. Managed calls that change the current view: `Editor.SetCurrentView`, `Editor.UpdateTiledViewportsFromDatabase`,
   COM `ZoomExtents/ZoomWindow/ZoomCenter`, the ZOOM/PAN/VIEW commands. Whether each pushes the previous-view
   list is native; R2-2 measures the REDO side.

## R2-2. Does a view change with no command kill REDO

Measuring now in the core console with plugin code called from LISP (no command starts):
`SetCurrentView` (same and different view), `Editor.Regen`, `UpdateScreen`, `SetImpliedSelection`,
`LockDocument` Write and Read, read transaction, same-value write, `SetSystemVariable`. Queued behind the
driver's AutoCAD lock (held until about 07:50); results will be appended here. Caveat: the core console has
no graphics window, so a view change there may not behave like the full AutoCAD window.

## R2-3. CE code that can run when the Civil drawing becomes current again (master 650c0c19)

**Runs by itself on DocumentActivated (no click):**
1. `LinkService.cs:1085` `OnDocumentActivated` → `RegisterDocument`: bounded init, reuses the cache, no view,
   no lock found.
2. `InspectorPaletteService.cs:428` → Idle once: `AttachToDocument`, `EvaluateAutoShow` (by drawing NAME, and
   off when `WorkshopInspectorEnabled`, the default), `RefreshInspector`, `ScheduleContributorSync`. No zoom in
   that path (zooms at `:913/:935/:2487/:2597` are button-driven).
3. `PitBlockMigrationService.cs:~55` → Idle once → `LockDocument()` WRITE (`:104`), `Migrate`, maybe
   `Editor.Regen` (`:110`). Once per database only (`_migratedDatabases`), so not on a repeat switch.
4. `CompoundEditModeService.cs:103` → `AttachToDocument` only.
5. `CivilHelpHost.cs:790` → `Attach` + `ContextChanged` (reads context; `ExecuteInCommandContextAsync` at
   `:729` and `CommandAsync("MR")` at `:737` are help-button paths).
6. `ThemeCommandRefreshService.cs:25`, `WorkspaceMenuInstallerService.cs:21` (menu install only when the
   version or path changed), `CeContextualTabController` attach (`SetImpliedSelection` at `:278` is
   selection-driven).
7. `PipeObjectUpgradeOnOpenService.cs` Idle: only for a drawing still pending since DocumentCreated, so not
   on a repeat switch.

**Runs on Idle when something was left pending by the CD pipe (worth checking in the witness timing):**
8. `LinkService.Reactors.cs` deferred work (`TryRebuildCachesDeferred`, `ApplyPendingLinkUpdates`): takes a
   WRITE lock when callouts need registering (`:1769`). U1 says a Write lock outside a command is its own
   nameless Undo step. It acts on its own (Civil) document.
9. `CeZoomHighlightService` fade: `OnIdleFade` → `ClearHighlightNow` → `MdiActiveDocument.Editor.UpdateScreen()`
   (`:312`). Note it uses whichever drawing is CURRENT when Idle fires, which may be the Structural one after
   the switch. Only if a zoom-highlight was started (CEFIND, schedule row, Inspector "Connected pipe",
   Design Check), not by CD itself.

**View changes in CE (none automatic on a switch, by reading):** `CdCommand.cs:703` (CD AutoZoom, inside the
CD command, before your U); `DrawingService.ApplyZoomWindowWorld` → `SetCurrentView` (`:717`) callers:
CEFIND, Pit Schedule, Inspector buttons, Hub navigation, Project QA, Detention view-model; `GoBack` buttons.
No `ZoomExtents`, `ViewportTableRecord` or `UpdateTiledViewports` use found in Drainage, Manager or Shared.

**Read, not run. Not traced:** Structural module handlers (struc-d1-prep), and what native AutoCAD itself does
on activation. Suggestion for the witness: log `doc.CommandInProgress` and `Application.DocumentManager.IsApplicationContext`
with each VIEWBACKSTATUS line, plus Idle handlers entered (a counter per CE handler), to pin which one runs.
