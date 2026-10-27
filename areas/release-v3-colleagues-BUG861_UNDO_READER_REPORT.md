# BUG-861: what CE does on U itself, and a second set of diagnostic switches (Tue 27 Oct 2026)

Written Tue 27 Oct 2026 about 14:55 Melbourne (PC clock) by the Team Opus job "FIND WHAT CE DOES ON THE U (UNDO) ITSELF THAT CAN LOSE REDO (BUG-861), AND BUILD DIAGNOSTIC SWITCHES FOR IT". Built and unit-tested by me; **not independently reviewed**; nobody has opened it in AutoCAD. BUG-861 is **not** marked FIXED. I did not edit `DESK_LOG.md` or `BUG_CARPARK.md`.

## ANSWER FIRST

**Most likely cause: not CE's code at all.** The best reading is that AutoCAD loses REDO on its own when the first real mouse click of a session lands after a U. That reading is not proven. Every piece of CE that reacts to a click was already switched off, and REDO was still lost. CE's log is word-for-word the same in the failing round and in the rounds that pass. No CE code reacts to a click on a plain line by changing the drawing.

## FOR TIM

1. **Mistakes of mine first:**
   1. I used the wrong name for one AutoCAD event field. The first build failed and cost about 2 minutes.
   2. My first test run had 9 red tests. I had forgotten that two older test files count the diagnostic switches exactly (15). I updated them to expect the four new ones and the run went green.
   3. I started from the newest release line, C-72 (`claude/rel-20261026w`), not C-71. The brief allowed that. C-72 contains all of C-71, but the installed 3.0.81 is C-71, so the robot needs a new install with this change before it can use it.
2. **What is most likely losing REDO:** something outside CE's own code, probably AutoCAD's own handling of the first click of a session. Why I think so:
   1. With all 14 click switches off, REDO was still lost every time (4 of 4 on a pit, 2 of 2 on a plain line).
   2. In those sessions, the CE log for the failing first click matches the passing second and third clicks line for line.
   3. The work CE does on every U (re-reading its pit and pipe record and rebuilding its position memory) also runs in the rounds that keep REDO. On its own it cannot be the cause.
   4. Structural and Manager have no click handlers at all. The shared library's click handler is not switched on.
3. **The suspects, ranked:**
   1. **AutoCAD itself, or a non-CE add-in or LISP**, doing something on the first click (a system setting, a lock or a hidden command). The new "gap watch" switch will show this directly.
   2. **Civil's work at the end of every U**: it re-reads CE's pit and pipe record and rebuilds its position memory. It is safe on paper (read only) and runs the same in passing rounds, but it is the only CE work certain to run in that gap. It now has three switches.
   3. **Structural's work at the end of every U and at idle** (beam links, foundation check, auto-save tracking). It also runs in the passing rounds. A Civil switch cannot turn it off; the robot needs a session with Structural not loaded.
   4. **Manager's once-only menu set-up at idle.** It runs once per session, but at start-up, before any U. Low.
   5. **The Inspector refreshing when the drawing is re-activated.** Ruled out: the log shows no re-activation in the failing round.
4. **The new switches, PR #1829 (draft):** https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1829. All four are off by default, so your drawings behave exactly as before.
   1. `disableUndoProjectReload`: at the end of U, CE does not re-read its pit and pipe record.
   2. `disableUndoCacheRebuild`: at the end of U, CE does not rebuild its position memory.
   3. `disableUndoEndWork`: at the end of U, Civil's linking does nothing at all.
   4. `watchUndoGap`: changes nothing, only writes to the log. Between U and the next command it logs every system setting change, every drawing lock and every command, whether CE or AutoCAD did it.
5. **No fix this time.** No suspect is clearly guilty, so I built no fix branch (step 3 of the brief).
6. **Robot procedure:** below, under "Robot procedure". Run the gap watch first. It is the most likely to name the cause in one run.
7. **Nothing for you to test or decide now.** Moving the Structural and Manager add-ins aside for a control run needs your yes; it is item 4 of the robot procedure and comes last.

---

## Technical detail (nothing here needs Tim)

### 1. Where things stand

1. **Base:** `origin/claude/rel-20261026w` = `c4c1e15d` (the C-72 finalizer). It contains `claude/rel-20261026v` = `a2408a96` (Civil 3.0.81, C-71); I checked that with `merge-base --is-ancestor`. The brief allowed `w` if it existed.
2. **Branch:** `fb/bug861-diag2`, one commit, `1790777a`, pushed. Draft PR **#1829** against `claude/rel-20261026w`.
3. **Not done:** no fix branch (`fb/bug861-fix2` was not created) and no deploy.
4. **Private worktree:** `C:\ce-fx\u861`, removed at the end. Scratch files are in `C:\ce-fx\u861s` (run script, logs, PR text).

### 2. Evidence read (from the 27 Oct bisect logs)

1. **Session k01b** (Civil 3.0.81, `disableAllSelectionWork`), full CE log `%APPDATA%\CE_CVL_SUITE\logs\CE_CVL_SUITE.log`, 12:16:50 to 12:19:35:
   1. **Control round, passes.** U at 12:16:50, REDO at 12:16:54. At the U: `[ProjectData] Loaded schema version '2.2'`, `Project data reloaded after Undo/Redo: pits=11, pipes=49`, then three cache scans and `[PERF] LinkService.RebuildRuntimeCaches: 41.2 ms trigger=undo/redo`.
   2. **Round 1, fails.** U at 12:17:10 (the same four lines). Click at 12:17:13: `[CivilGripProbe] callback-cache-miss type=BlockReference handle=109D56`, the `[REDO-DIAG] selection event` summary, and `skipped SelectionObserver`. REDO at 12:17:28 (selection cleared, then the same U-end lines; "Nothing to redo").
   3. **Round 2, passes.** U at 12:17:45. Click at 12:17:48: **the same three lines**. REDO at 12:18:03, then the write watch lists the redone objects.
   4. **Round 3, passes.** Same pattern again.
   5. **Result:** no `[REDO] write after U` line and no `[REDO] drawing activated` line in round 1's gap. Diagnostics logging was OFF in these sessions, so CE's debug-level lines (including `[PickProbe]`) were not written.
2. **Structural log for the same minutes** (`%APPDATA%\TIM_CE_CADTOOLS\logs\ce_struc_structured_20261027.log`): only PERF summary lines (BeamLink, FoundationMonitor, AutoSave), and nothing between 12:17:10 and 12:17:41. The Manager log has no line on 27 Oct after 09:10.

### 3. Every candidate found (file, when it runs, can it write or touch the undo history)

**Civil (Modules/Drainage), at the end of U / UNDO / REDO / MREDO:**

1. **`LinkService.Reactors.cs` U branch** of the command-end handler, about lines 867 to 921 (line numbers shift by a few in the PR).
   1. In order, it runs `PostUndoWriteWatch.UndoFinished`, clears memory (dirty handles, pipe fingerprints, route signatures, erase notes), then `ProjectDataService.ReloadAfterDrawingHistoryChange` (`ProjectDataService.Persistence.cs:1207`), then `RebuildRuntimeCaches(db, state, "undo/redo", lightReads: true)` (`LinkService.Cache.cs:863`).
   2. **When:** at every U end, including the control round and the passing rounds.
   3. **Can it write:** no. The record read goes through `TryLoadFromDrawingLight`, the scans use open-close reads, memory is replaced, and the queued save is cancelled. `ScheduleLinkService.InvalidateScheduleCellIndex` is memory only.
   4. **Retry path:** if the read fails, `ScheduleHistoryReloadRetry` (Persistence.cs about 1145) does one Idle retry, also a light read. It did not run in the logged sessions (no warning line).
2. **`CivilProjectQaAutomaticService.MarkAffected`** (memory only), **`CivilOwnershipHighlightService.OnCommandStateChanged`** (through the switched `ScheduleRefresh`), **`PitScheduleXrefWatcherAutoCadAdapter.PublishFinishedCommand`** (guarded), and **`AdminTelemetryService`, `CommandOutcomeLogService`, `CivilJobTimeService`** (files only). None writes to the drawing.

**Civil, on the click or at Idle after it, NOT in the 14:**

3. **`PipeAttachmentActionGripOverrule.GetGripPoints`** (BlockReference and MText, no filter). Runs on every pit click (the `callback-cache-miss` line). It does a memory lookup and `GetSystemVariable("REFEDITNAME")` (a read). It does not run for a Line.
4. **`PitCoverTextFlipGripOverrule`** (MText, custom filter): open-close reads only. **`PipePlanGripOverrule`, `PipeDrawableOverrule`, `PipeOsnapOverrule`** (Polyline, XData filter): no transaction. The compound overrules are never registered (`if (false)`), and the slab adapter is off (`StartupEnabled = false`).
5. **`InspectorPaletteService.OnDocumentActivated`.** It runs only when the drawing is re-activated. Inside the redo window it reads through open-close transactions. Ruled out by the log.
6. **LinkService Idle processing** (`OnApplicationIdlePostSave`, `TryRebuildCachesDeferred`, `RunIdleCacheRefresh`): guarded by `RedoWindowGuard`, read lock, open-close reads.
7. **Not guarded, but only after another action:**
   1. `DrawingBackupService` Idle: only after a save.
   2. `CeZoomHighlightService.OnIdleFade` (`UpdateScreen`): only after a palette zoom.
   3. `DrawingCheckPaletteService` Idle: only during a Drawing Check.
   4. Grip-click Idle commands (`PitCoverTextFlipGripOverrule.OnIdle`, `PipeAttachmentActionRequestQueue`): only after a grip click.
   5. The job timer: files and the status bar only.

**Structural (Modules/Structural):**

8. **`BeamLinkService.Reactors.cs`.**
   1. **Hooks:** ObjectModified and ObjectErased queue Lines and Polylines as possible beams; `OnCommandEnded` runs `ProcessPendingWork` at **every command end, U included**.
   2. **Writes:** if beam linking is on, `ProcessErases`, `ProcessMoves` and `ProcessClones` can start `TransactionManager.StartTransaction` and commit. The 1 Oct measurement (`RedoWindowGuard.cs` header) says that loses REDO.
   3. **Why it can't be the whole cause:** it would run the same at every U, and the control round and rounds 2 and 3 keep REDO. So on this drawing it either does not reach a transaction or does not matter.
   4. **Not verified:** I did not check whether `beams.linkingEnabled` is on in the robot's Structural settings.
9. **`FoundationMonitor.cs`:** objects touched by U are queued, and an Idle drain (24 per tick) runs `FoundationService.OnDriverEntityPossiblyModified`, an open-close read. For a non-foundation line it returns without writing.
10. **`DrawingAutoSaveService.cs`:** it tracks changes. At Idle it can take a write lock and `SaveAs`, but only 15 s after the last change **and** a whole interval (minutes) after it, so not in an 18 s gap. A save would log "saved", and none was logged.
11. **Status bar, MainPalette Idle, ribbon builders, theme handlers, telemetry:** UI, files, or open-close reads only. Structural has **no** selection, pointer or lock handler and **no** overrule.

**Manager (Modules/Manager):**

12. **`CeSuiteManagerMenuService`**, one Idle try per session: `UnloadPartialMenu` / `LoadPartialMenu` / `ReloadAllMenus` and a guarded `SetSystemVariable("MENUBAR", 1)`. It runs once, at start-up, before any U.
13. **`CeUnifiedRibbonService`:** WPF only (it can be re-armed by the release poll every 60 s). **`CommandOutcomeLogService`:** logging only. Manager has **no** selection handler and **no** overrule.

**CE_SHARED:**

14. **`CeContextualTabController`:** has its own ImpliedSelectionChanged hook (`SelectImplied` / `SetImpliedSelection`), but the only caller registers it with `hostDrivesSelection: true` (`StandaloneCivilRibbonService.cs:166`). So it never subscribes, and its `ApplySelection` goes through Civil's switched `RibbonContextTab`. Its Idle watchdog is armed only while a CE tab is up. CE_SHARED is unchanged.

### 4. Ranking reasoning (the first lines of this report give the answer)

The failing click and the passing clicks run identical CE code, as far as the log and the code show. The only difference between round 1 and rounds 2 and 3 is that round 1 is the first real click of the session.

No CE handler found has a "first click only" path that touches the drawing. The once-per-drawing Inspector pieces (first scan, first-pick log) were already switched off.

That leaves:

1. **Something AutoCAD does once.** I cannot state what AutoCAD does inside itself (rule 12.5).
2. **A transaction somewhere.** No AutoCAD .NET notification exists for a transaction (I checked the `acdbmgd.dll` metadata: no `TransactionStarted` event), so neither the old watch nor the new one can see one.
3. **A non-CE add-in or LISP.**

The gap watch separates these for system variables, locks and commands. The U-end switches clear Civil's own U work. The add-in-off control clears Structural and Manager.

### 5. What was built (PR #1829)

1. **`Models/DiagSettings.cs`:** four new keys under `diag.redo`, each `= false` with "Default: off.": `disableUndoProjectReload`, `disableUndoCacheRebuild`, `disableUndoEndWork`, `watchUndoGap`.
2. **`Services/RedoDiagSwitches.cs`:**
   1. New enum `RedoDiagUndoComponent { UndoProjectReload, UndoCacheRebuild, UndoEndWork }`, with `KeyOf`, `IsDisabled`, `IsDisabledIn` and `Skip` overloads.
   2. `WatchUndoGapOn()`.
   3. `disableAllSelectionWork` does not reach the new pieces.
   4. Every skip line is `[REDO-DIAG] skipped <Piece> (diag.redo.<key>) at LinkService.OnCommandEnded (<U|UNDO|REDO|MREDO> end)`, written at every U, not once per session.
3. **`Services/LinkService.Reactors.cs`:**
   1. The `UndoEndWork` check sits right after `PostUndoWriteWatch.UndoFinished` and `state.IsSuspended = false`, so linking is never left suspended, and it returns.
   2. The `UndoProjectReload` check sits in the same condition as the re-read, so a skipped re-read prints no warning.
   3. The `UndoCacheRebuild` check sits directly before the rebuild.
4. **New `Services/RedoGapWatch.cs`:**
   1. **Hooks:** only when the key is on at start-up (and not in the core console), it hooks `Application.SystemVariableChanged` and `DocumentManager.DocumentLockModeChanged`.
   2. **Window:** it logs only while `PostUndoWriteWatch.IsOpen`, from the end of U / UNDO / REDO until the next non-undo command starts.
   3. **Command starts:** `PostUndoWriteWatch.CommandStarting` tells it about each command start (REDO included) before the window closes.
   4. **Line format:** `[REDO-DIAG] gap: <kind>: <detail>, <s> s after <U> ended; <CE code: A < B | no CE code on the stack (AutoCAD itself, a native add-in or LISP)>`, at most 40 lines per gap plus one cap line.
   5. **It changes nothing:** a source test pins that the file has no transaction, no system variable get or set, no lock, no regen, no command and no Editor or Database use, and only two subscriptions.
5. **`Services/PostUndoWriteWatch.cs`:** new `UndoCommand` and `UndoFinishedUtc` read-outs, plus the two memory-only calls into the gap watch.
6. **`PluginInitialization.cs`:** starts the watch after `RedoWindowGuard` (real AutoCAD only) and stops it at shutdown.
7. **Tests:**
   1. New `Bug861Diag2SwitchesTests`, **25 tests, all pass**:
      1. Every key loads OFF from an empty or older file through both start-up reads, and nothing is skipped or logged.
      2. A typed key turns on only itself.
      3. Each skip logs one line naming its key and place, once per U.
      4. `disableAllSelectionWork` leaves them alone, and unreadable settings behave normally.
      5. Source checks place each switch in the U branch and ask each switch exactly once.
      6. Gap watch: off hooks and logs nothing; on, it logs command starts until the gap closes, says whether CE code was on the stack, is capped per gap, and only listens.
   2. `Bug861DiagSwitchesTests`, `C70NewSwitchDefaultsTests`, `C71NewSwitchDefaultsTests` and `C72NewSwitchDefaultsTests` now expect 15 + 4 keys (the fifteen unchanged, all 19 OFF).
8. **Build and test results** (each command used `-p:SkipDevBundle=true -nr:false --disable-build-servers`, the C-62 AutoCAD refs and the shared build lock, run Below Normal):
   1. **Focused Civil net10:** 504 total, 501 passed, 3 skipped, 0 failed. Before the C71/C72 count update it was 9 failed, all of them that count.
   2. **Full Civil net10:** **20,681 total, 20,649 passed, 32 skipped, 0 failed**, 22 min 31 s (slow because acad.exe and other jobs' dotnet were running). Nothing failed, so the lone PDF re-run was not needed. I did not check whether the PDF page test ran or was among the 32 skipped.
   3. **net48:** `CE_CVL_SUITE.csproj` builds with 0 errors, and `CE_CVL_SUITE.Tests.csproj` builds with 0 errors.
   4. **When:** builds ran 14:10 to 14:52, inside the 2:00 to 3:00pm window.
   5. **Not run:** Manager and Structural suites (unchanged), and the net48 test run.

### 6. Robot procedure

1. **The build has to be installed first.** PR #1829 must be in an installed Civil (the desk assembles and installs it; I deployed nothing). At start-up, check the Civil version line in the CE log. With `watchUndoGap` on, check for the line `[REDO-DIAG] gap watch on (diag.redo.watchUndoGap): ...`.
2. **How to set a key:** use the runner's settings guard, header line `SETTING CD_Settings.json diag.redo.<key> true`, applied before AutoCAD starts and restored by hash afterwards. CE reads the settings file only at start-up.
3. **How to make the cases:** copy `R08x_1_exact` (pit click) and `R08x_5_plain_line_first` (plain line click) as before, adding one `SETTING` line and a title suffix.
   1. **Names:** `R08x_diag_<key>` and `R08x_L_<key>`, all under 40 characters. For example `R08x_diag_watchUndoGap` (22) and `R08x_diag_disableUndoProjectReload` (34).
   2. **One case per session.** The `-Only` filter matches by substring, so make sure no two names contain each other.
4. **Step 1, the gap watch (`watchUndoGap` = true alone).** Run both cases, 2 fresh sessions each, at least 3 minutes apart. REDO is expected to be lost as in the baseline, because the watch changes nothing.
   1. **Find the gap lines.** From the CE log, cut every `[REDO-DIAG] gap:` line between round 1's U time and its REDO time, and the same for round 2 (the case records the click and REDO times).
   2. **A line in round 1 only, with "CE code: ...":** that CE piece is the culprit. Report the line.
   3. **A line in round 1 only, with "no CE code on the stack":** for example a system variable change or a write lock at the click time. AutoCAD or a non-CE add-in or LISP did it, and the line names what.
   4. **The same lines in both rounds:** the cause is something no notification shows (most likely a transaction). Go to step 2.
5. **Step 2, all of Civil's U-end work (`disableUndoEndWork` = true).** Two sessions per case.
   1. **What to check in the log:** a `[REDO-DIAG] skipped UndoEndWork (diag.redo.disableUndoEndWork) at LinkService.OnCommandEnded (U end)` line at every U, and NO `Project data reloaded after Undo/Redo` line.
   2. **Round 1 keeps REDO in all sessions:** Civil's U-end work is involved. Then run `disableUndoProjectReload` alone and `disableUndoCacheRebuild` alone, 2 sessions per case each, to split it.
   3. **Still lost:** Civil's U-end work is cleared.
   4. **Watch afterwards:** with any U-end key on, CE's memory may not match the drawing until the next CE command. The case only draws and undoes a line, so that is harmless here. Never leave a key on.
6. **Step 3, the control the bisect already proposed (needs Tim's yes).** Run the same two cases with the Structural and Manager add-ins not loaded, then with every CE add-in off.
   1. **REDO kept with Structural and Manager off:** look at Structural's U-end beam-link work (technical item 8) first.
   2. **Still lost with all CE off:** it is AutoCAD's own behaviour with the robot's first real click. Re-aim the case (REDO after the second click, which always passed).
7. **What counts:** one passing session proves nothing; the 3.0.81 baseline passed 1 time in 5. Count a key as "keeps REDO" only at 2 of 2 per case or better, and repeat once more before naming a cause.

### 7. Housekeeping

1. **Not touched:** AutoCAD, Codex and accoreconsole were not started by me (an acad.exe from another job was running during the builds). Nothing was deployed. No settings file, installed bundle or ProgramData was touched. CE_SHARED is unchanged.
2. **Branches and PRs:** no PR was closed, retargeted or merged, no branch was deleted, and nothing was force-pushed.
3. **Commits:** the commit message names BUG-861. Staged by file name, no `git add -A`. The leak-scan hook passed on the first push.
4. **Read-only reading:** two read-only reader agents (Opus) read Structural/Manager and the rest of Civil; I checked their key claims in the code myself (`BeamLinkService.Reactors.cs`, `FoundationMonitor.cs`, `DrawingAutoSaveService.cs`, `CeContextualTabController.cs`, the grip overrule).
5. **Worktree:** `C:\ce-fx\u861` is removed at the end. The scratch folder `C:\ce-fx\u861s` (run script, logs, PR text) is left for the desk; it holds nothing private.

## Summary (under 100 words)

No CE code explains the lost REDO. The failing first click and the passing clicks run identical CE work, and nothing in Civil, Structural, Manager or CE_SHARED changes the drawing on a plain-line click. AutoCAD's own first-click handling is the leading suspect, unproven. I built draft PR #1829 with four `diag.redo` keys, all off by default: three skip Civil's work at the end of U, and one only logs every system-setting change, lock and command between U and REDO. Tests: full Civil net10 0 failed, net48 compiles. No fix branch. Untested in AutoCAD.
