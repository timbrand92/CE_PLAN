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
