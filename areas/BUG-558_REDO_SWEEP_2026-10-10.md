# BUG-558 lead and REDO-breaker sweep (10 Oct 2026, decompile chat)

For: desk plan/03 → builders via NEXT_FIXES. Tim, 10 Oct: "all" (items 1, 2, 4). Read-only work plus headless
measurement; nothing in the plugin repo changed. Rules behind it: `ENGINEERING_RULEBOOK.md` guardrail 8 item 17
(what kills REDO, measured). Undo-safety check spec: `areas\UNDO_SAFETY_CHECK_SPEC_2026-10-10.md`.

## 1. BUG-558: strongest lead = the New Pipe window's live plan preview (hypothesis, not proven)

Facts that fit (desk runs 8 and 10): vanilla AutoCAD keeps REDO across a switch; with CE, REDO is lost only
AFTER a pipe was placed through the New Pipe window in that Civil drawing; a fresh Civil copy keeps REDO; the
witness shows 3 VIEWBACKSTATUS changes on EACH drawing at the lost switch.

What the code does (master 650c0c19):
1. The New Pipe window hosts `Controls/CdPlanPreviewControl.cs` (via `Dialogs/PipeOnePageLayout.cs`). While
   loaded, a 100 ms `DispatcherTimer` (`:69`) re-renders when dirty, on `MdiActiveDocument` (`:157`).
2. It takes the graphics manager with `document.GraphicsManager` (`BorrowedManager`, `:247`) and caches it per
   Document in a `ConditionalWeakTable` (`:31`). Decompiled `Document.GraphicsManager` (accoremgd
   `Document.cs:197`) returns `acgsGetGsManager(<the drawing window's own CView>)`: the LIVE graphics manager of
   that drawing window, not a private one.
3. `Controls/PlanAreaRenderer.cs:56-68` then calls `Manager.AcquireGraphicsKernel`,
   `manager.CreateAutoCADOffScreenDevice`, `CreateAutoCADModel`, `CreateView`, `view.SetView(...)`, `Update`,
   `GetSnapshot`, and disposes them in `finally`. So the New Pipe window builds and sets views inside the Civil
   drawing window's own graphics system. What that leaves behind natively is not readable (native code); a
   view set inside the drawing's graphics system is the kind of thing that moves VIEWBACKSTATUS, and a view change
   kills REDO (measured).
4. The window is modal (`DialogService.ShowDialog`), so its timer stops on close: the effect would be a
   leftover in that drawing's graphics state that fires on the next activation, not a live timer.
5. Edit-pipe (CDEDIT) dry-run preview additionally runs the real writer inside `StartTransaction` then Abort
   (`Commands/PipeEditCommand.cs:448-480`): a REDO killer while that window is open (not at switch time).

**Split test (full AutoCAD, driver; one session, same two copies as run 10):**
- A. In a fresh Civil copy, open the New Pipe window, let the plan preview draw, then CANCEL (no pipe). Then
  Structural: CIRCLE, U, switch to Civil and back, REDO. Lost → the preview is the cause, not the pipe.
- B. Place a pipe WITHOUT the window (typed CD path if one exists, or copy an existing CE pipe in with COPYCLIP
  from another copy), then the same switch test. Kept → confirms A.
- C. If A loses REDO: rebuild with the preview disabled (or rendering on a private off-screen manager instead of
  `document.GraphicsManager`) and repeat A.
Witness: add `GraphicsManager` borrow/release and `CdPlanPreviewControl` render count to the log.

## 2. Structural: ruled out on paper (branch claude/struc-d1-prep)

No Structural code changes the view, starts a command or a `StartTransaction` when a drawing becomes current, and
nothing in Structural reacts to Civil objects in another drawing. Six DocumentActivated handlers
(`CeToolsInitializer.cs:313`, `AdminTelemetryService.cs:299`, `DrawingAutoSaveService.cs:415`,
`RuntimeDiagnosticsService.cs:627`, `StatusBarIndicatorService.cs:35`, `MainPalette.xaml.cs:1773`) are logging,
status-bar or OpenClose reads. The only Structural `SetCurrentView` is `CeSheetsActiveDocViewGuard.cs:187`
(CESHEETS publish/update only).

Side finding (separate REDO risk, no switch needed): `BeamLinkService.Reactors.cs:244` `OnCommandEnded` →
`ProcessPendingWork` → `ProcessErases` (`BeamLinkService.CascadeErase.cs:29`) calls `StartTransaction()` after
ANY erase queued by `ObjectErased` (not type-filtered), which includes the U of a CIRCLE. Gated by
`IsLinkingEnabled()` (default reported false in an earlier audit, `UserSettings.cs:363`). If a user turns linking
on, every U in Structural loses REDO. Fix: skip when the ending command is U/UNDO/REDO, or OpenClose-only reads.
Also `StructuralGripEditQueue.cs:105` runs `CommandAsync` from Idle when a grip edit is queued (killer, gated).

## 3. Civil / Manager / Shared sweep (master 650c0c19; sites checked by hand marked ✔)

No `SetCurrentView`, `SetSystemVariable`, write or command start was found in any handler that fires after
U/REDO. The killers are **read-only `StartTransaction` calls** (measured: they kill REDO even with no command).
Almost all are reads, so the fix is usually one word: `StartOpenCloseTransaction`.

1. **U itself, every CE-owned Civil drawing, immediately (most important).** `LinkService.Reactors.cs:698-710` ✔:
   CommandEnded of U/UNDO/REDO → `ProjectDataService.ReloadAfterDrawingHistoryChange` →
   `TryLoadFromDrawing` → `StartTransaction` at `ProjectDataService.Persistence.cs:692` ✔, then
   `RebuildRuntimeCaches` → `StartTransaction` at `LinkService.Cache.cs:492` ✔, `:535` ✔, `:636` ✔. If the reload
   fails, `ScheduleHistoryReloadRetry` (`Persistence.cs:769-826`) repeats it on Idle. Gate: only
   `IsCeOwned != true` returns early. **MEASURED 07:08 (core console, CIRCLE, U, REDO with a CommandEnded(U) handler):** a read-only
   `StartTransaction` + Commit inside CommandEnded of U -> **"Nothing to redo"**; the same read with
   `StartOpenCloseTransaction` -> "Everything has been redone"; an empty handler -> redone. So this chain alone
   breaks REDO after every U in a CE-owned Civil drawing, and the one-word fix is proven to keep it.
   Fix: all four only read → `StartOpenCloseTransaction` (`Cache.cs:54` already does).
2. **Automatic Project QA, 3 s after U/REDO.** `CivilProjectQaAutomaticService.cs:272-281` ✔ marks affected on
   U/UNDO/REDO, a 3 s quiet timer hooks Idle, `AdvanceOnIdle` → `CreateSession` →
   `PitScheduleQaAdapterService.Capture` → `PitScheduleHostInstanceService.cs:94` ✔ `StartTransaction`, plus
   `PitScheduleXrefDiscoveryService.cs:214/:234`. A pause over 3 s before REDO is normal, so this is likely in
   practice. Fix: OpenClose reads, or skip capture while the last command was U/UNDO/REDO.
3. **Inspector refresh on selection change** (palette visible): `BlockService.cs:227` ✔ `StartTransaction` for
   every dynamic block (pits) inside `GetEffectiveBlockName`; reached from `RefreshCivilProperties`. Fix there
   covers every caller (also the speed finding).
4. **Drawing switch / open:** `CivilBackgroundXrefNoticeService.cs:68-93` → `CivilBackgroundXrefReader.cs:58`
   (`StartTransaction` per XREF, on EVERY activation, synchronously); `PitScheduleXrefWatcher` Idle after
   activation → `HostInstance:94`, which also re-arms QA; once-only: `PitBlockMigrationService` (`:239`, `:278`,
   writes), `LinkService.RegisterDocument`, `PipeObjectUpgradeOnOpenService` (rewrites pipes).
   **Relevant to BUG-558:** the XREF notice and watcher run on every switch. If the test drawings reference each
   other or anything as XREF, they start transactions on the drawing being activated.
5. **Queued project-data save at Idle:** `Persistence.cs:446-465` → `SaveToDrawing` (`:914`, transaction + write);
   not cancelled on the `KeepMemory` / `RetryWhenIdle` U branches (`:845-860`).
6. **Manager:** `CeSuiteManagerMenuService.cs:789` `SetSystemVariable("MENUBAR")` from DocumentActivated and Idle
   while the menu install keeps failing (repeats every activation).
7. **Click-started (lowest risk):** compound double-click edit mode (`CompoundEditModeService.cs:153/169/560-606`),
   grip actions (`PitCoverTextFlipGripOverrule.cs:165-186`, `PipeAttachmentActionRequestQueue.cs:236-265`), help
   (`CivilHelpHost.cs:729/737`), palette zooms (`CeZoomHighlightService.cs:157`, `DrawingCheckPaletteService.cs:361`),
   Inspector actions, ribbon `RibbonBuilder.cs:691`.

Clean: LinkService object reactors, pipe/pit overrules, hover/PointMonitors, contextual tab (OpenClose +
SetImpliedSelection), CE_SHARED, CE.Spine. Not read in full (grep clean): PipeAttachmentFlipGripOverrule,
PitBlockPreviewControl, VertexPickLiveFeedback, BlockGhostFollower, Manager CeUnifiedRibbonService.
Totals: Drainage 5 unprompted chains (~20 sites) + 6 click sites; Manager 1 + 1; Shared 0.

**Suggested fix order for builders:** item 1 (four lines), item 2, `BlockService.cs:227`, item 4 XREF reader and
watcher. Then the Cecil rule in `UNDO_SAFETY_CHECK_SPEC_2026-10-10.md` stops them coming back. Each fix is
"done" only when the driver's U → wait → switch → REDO routine says "Everything has been redone".

## 4. Reconciliation (07:35 question): why driver runs 3, 4, 6, 9 kept REDO

**Yes, there is a gate: `state.IsCeOwned`.** `LinkService.Reactors.cs:702` (`if (state.IsCeOwned != true) return;`)
skips the U-end reload/rebuild unless the drawing is CE-owned. The flag is set:
1. **At registration** (`LinkService.cs:1158-1174`, first activation/open): `true` only if the drawing's discipline
   is Civil (explicit NOD tag `CE_CVL_DISCIPLINE`, or a `CVL` token in the file name,
   `DrawingDisciplinePolicy.ParseFilenameDiscipline`) or it already holds a CE project record
   (`ProjectDataService.IsDrawingActive`: NOD `CE_CVL_SUITE_PROJECT`). Structural (tag or `STR` token) and
   ordinary untagged drawings with no project record start `false`.
2. **Mid-session, the moment a CE link writer runs** (`MarkDrawingAsCeOwned`, `LinkService.Cache.cs:194`):
   `WritePitLinkData` (`LinkService.Persistence.cs:790`), `WritePipeLinkData` (`:810`, i.e. placing a CD pipe),
   `LinkService.NetworkEdits.cs:274`, `LinkService.Spine.cs:183/540/579`. It never goes back to false in the session.

So an untagged test copy with no project record kept REDO after MOVE + U (runs 3, 4, 6, 9: not owned, the branch
returns at `:702`). After the first CD pipe it is owned, and from then on **every U in that drawing runs the four
read `StartTransaction`s and loses REDO**.

**Exposure:** every real Civil job drawing. They carry the `CVL` file-name token or tag, or a saved CE project
record, so they are owned from the moment they open, not just after a new pipe.

**Caution for BUG-558:** this chain acts on the drawing where U was typed (`OnCommandEnded` uses `sender`,
`Reactors.cs:466`). In BUG-558 the U is in the STRUCTURAL drawing, which is never CE-owned, so this chain does
NOT explain BUG-558. That bug still rests on the New Pipe plan-preview lead in §1 (split test A/B). Two separate
REDO bugs, then: (a) U in any owned Civil drawing (proven chain, fix = OpenClose); (b) BUG-558 across a switch
(lead, needs the split test).

## 5. CORRECTION and re-check on the release heads (08:05 question)

**Correction (mine):** §3 audited `master` 650c0c19. The installed Civil is **3.0.44 = `b7eed253` =
`origin/claude/rel-20261009o` head** (read from the bundle DLL ProductVersion, 10 Oct ~08:15), which is not on
master. On that head most §3 items are already fixed: U-end reload/rebuild use light (OpenClose) reads
(BUG-192 v2), and a per-drawing `RedoWindowGuard.DeferWhileRedoOpen` gates the Idle link refresh
(`LinkService.Reactors.cs:2330`), Automatic QA (`CivilProjectQaAutomaticService.cs:423`), XREF notice
(`CivilBackgroundXrefNoticeService.cs:88`), Inspector (`InspectorPaletteService.cs:386/556/745/1120`), pit-schedule
watcher (`PitScheduleXrefWatcherAutoCadAdapter.cs:109`), migration (`PitBlockMigrationService.cs:156`), pipe upgrade
(`PipeObjectUpgradeOnOpenService.cs:108`), grade marker (`GradeNoteMarker.cs:159`). Structural `rel-20261009p`
(2e0cf385) skips the U family in `BeamLinkService.Reactors.cs:320`.

**Still unguarded on the release heads:**
1. `BlockService.GetEffectiveBlockName` (`BlockService.cs:~266`): `StartTransaction` per dynamic block; safe only
   where its caller is guarded.
2. Manager `CeSuiteManagerMenuService.cs:797` `SetSystemVariable("MENUBAR", 1)` from DocumentActivated / Idle while
   the menu install keeps failing.
3. Click-started items of §3.7 (by design).

## 6. BUG-558 on the release head: the guard is PER DRAWING (lead, file and line)

`RedoWindowGuard` keys every window by the drawing where the U was typed (`RedoWindowGuard.cs:131` `KeyOf(database)`;
`IsOpen`/`DeferWhileRedoOpen` at `:96`/`:124`). Every background job asks only about ITS OWN drawing. In BUG-558 the
U is in the Structural drawing, so the Civil drawing's window is closed, and all pending Civil work runs the
moment the Civil drawing becomes current:
1. **What CD placement leaves pending:** `LinkService.Reactors.cs:860-864` sets
   `state.PendingCacheRebuildAndAttachments = true` and hooks Idle at every CE editor command end (CD included).
   The Idle handler (`Reactors.cs:2282`, `OnApplicationIdlePostSave`) loops over ALL documents, asks
   `DeferWhileRedoOpen(doc.Database)` (`:2330`, Civil = not open), then runs `TryRebuildCachesDeferred` only when
   that document is the ACTIVE one (`:2336`, `ReferenceEquals(doc, activeDoc)`). If the user leaves the Civil
   drawing before that Idle tick, the rebuild waits and fires on the next activation of the Civil drawing.
2. That rebuild calls `RunIdleCacheRefresh` → `RebuildRuntimeCaches(db, state, trigger, fallbackReason)`
   (`LinkService.Cache.cs`, `lightReads` defaults to false at `:860`) → full `StartTransaction` reads
   (`Cache.cs:535-537` etc.) under a Read lock, and a WRITE lock + registrations if callouts were queued
   (`Reactors.cs:2475-2490`).
3. The same per-drawing gap applies to Automatic QA (armed by CD, 3 s quiet timer, `:423` asks only the Civil
   drawing) and the XREF notice/watcher on activation.

**Not established:** whether a transaction or lock on the Civil drawing can destroy the Structural drawing's REDO
(cross-drawing; the core console has one drawing, so it cannot be measured headless). The run data fit it: lost
only after a CD pipe (pending work exists), kept with a fresh Civil copy (nothing pending), kept in vanilla.

**Cheapest decisive experiment (build + driver):** make the guard global for background work: defer when ANY
open drawing has its REDO window open (e.g. a `Registry.IsOpenAnywhere()` check inside `DeferWhileRedoOpen`), and
make the deferred rebuild pass `lightReads: true`. Re-run run 10. Kept → root cause confirmed and fixed in one
change. Still lost → the cause is outside these background jobs (then log which jobs ran at the switch).
