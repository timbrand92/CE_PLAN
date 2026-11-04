# BUGFIX ff2015b: PR 2015 (CIVIL-OFF-1) fix-first commit (Melbourne, 5 Nov 2026)

## FOR TIM

1. **One extra commit is on the PR 2015 branch** (`claude/civil-off-1`, commit 71fa72ad, on top of 8041dfa5). No new PR, no force-push, no retarget. Built and unit-tested only. Nobody has opened it in AutoCAD.
2. **What you will see differently:** in a drawing marked Civil OFF, press U after a CDDISCIPLINE change and CE now follows the drawing. Before, CDDISCIPLINE to Civil then U left the drawing OFF but CE acting as if Civil was ON (CDSYNC would relink pits there). The other way round, CDDISCIPLINE to Off then U left CE refusing every command in a drawing that was no longer OFF.
3. **Grips:** in an OFF drawing, grip-dragging a CE pipe, a pipe attachment or a pit cover text now behaves exactly as plain AutoCAD. CE no longer flattens the height part of the drag there.
4. **Same switch as the PR:** `options.civilOffPerDrawing`, Default: on. Switch off: the OFF flag is never set, so nothing changes.
5. **My own mistakes:** the first scratch script died on a missing folder and a bad dotnet path (two wasted tries, no effect on the drawing or the code). I also deleted my scratch folder at the end, so the two AppData listings are summarised below rather than attached.
6. **NOT proven:** nothing was tried in AutoCAD. The U cases (OFF, ON, U gives OFF; ON, OFF, U gives ON; and the REDO versions) need a real drawing, so the unit tests only check the wiring in the source. Robot case to prove it: **CIVILOFF1_undo_flag** (not written yet). It would type `CDDISCIPLINE` then `Civil`, then `U`, then `CDSYNC`, and check the CE log has the line "Civil is OFF" (or CDSYNC says "Civil is OFF in this drawing" and "CDSYNC has not run"). The second case types `CDDISCIPLINE` then `Off`, then `U`, then `CDSYNC`, and checks CDSYNC runs. REDO twins use `REDO` after the `U`. Switch-off control: the same typing with `options.civilOffPerDrawing` false in the settings read at start-up (set before launch); CDDISCIPLINE then offers no Off, and the U line never appears.
7. **Not done on purpose:** ruling item 6 (the wording after OFF is turned back ON: the pit block swap runs at the next drawing switch while the message says "Nothing is caught up by itself"). The ruling called it a small, non-blocking point. Stack rebuild (2016, 2017, 2018 carrying this commit) and the combined read-only check are CE 01's next step, not this job's.

---

## Technical detail

1. **Ruling used:** `RULING_CODEX_VS_OPUS_SIX_PRS_05NOV.md`, block for PR 2015: re-read the OFF tag into memory at the gate and after U / UNDO / REDO / MREDO (open-close read); grips pass through while OFF; tests; stack rebuild afterwards. The brief's path had a doubled `C:\CE_PLAN\areas\` prefix; I used the real file.
2. **Fault confirmed on 8041dfa5 (file and line):** `LinkService.Cache.cs` `ApplyCivilOffTag` (about line 241) only runs from registration and from CE's own tag write/clear; `CivilOffCommandGate.cs` line 88 trusted `LinkService.IsCivilOff` (memory flag only). `PipePlanGripOverrule.IsApplicable` and the two other grip overrules had no OFF check.
3. **Changes (7 files, +83/-5):**
   1. `LinkService.Cache.cs`: new `RefreshCivilOffFromTag(Database)` reuses `ApplyCivilOffTag` (read via `DrawingDisciplineService.ReadExplicitTag`, which already uses `StartOpenCloseTransaction`). Writes nothing.
   2. `LinkService.Reactors.cs`: new `RefreshCivilOffAfterHistoryCommand`, called at the very top of `OnCommandEnded` beside the existing `ReloadDrawingOwnedKeysAfterHistoryCommand` (before any early return, so quiet/OFF drawings are covered). Only U, UNDO, REDO, MREDO act.
   3. `CivilOffCommandGate.cs`: the pure `ShouldRefuse` test now runs first (so only a CE command that could be refused pays for the read), then the tag is re-read, then the veto.
   4. `PipePlanGripOverrule.cs` (`IsApplicable`), `PipeAttachmentActionGripOverrule.cs` and `PitCoverTextFlipGripOverrule.cs` (`GetGripPoints`, after the native grips are obtained): return at once while `LinkService.IsCivilOff`.
   5. `CivilOff1Tests.cs`: the gate wiring test updated, plus `OffFlag_IsReReadFromTheDrawing_AtTheGate_AndAfterUndoRedo_WithAnOpenCloseReadOnly` and three grip source guards. The existing both-start-up-reads switch tests are unchanged and still pass.
   6. `REGRESSION_LOG.md`: item 8 added to the CIVIL-OFF-1 entry at the top.
4. **Behavioural U tests (ruling item 5.3):** not possible as unit tests (they need a live `Database`). Covered by source guards and the robot case above. Said plainly: this is weaker than the ruling asked for.
5. **Build and test:** `dotnet test Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj -f net10.0-windows --filter FullyQualifiedName~CivilOff1Tests` with SkipDevBundle, -nr:false, --disable-build-servers, -m:2: **45 passed, 0 failed (count not 0)**. The run also printed a TearDown note from `RealFolderGuardSetup`: inconclusive because an AutoCAD was running on this PC (not a test failure). net48 compile of `Modules/Drainage/CE_CVL_SUITE.csproj` (Release): **0 errors**. Manager tests not run. CE_SHARED untouched. Refs: net48 `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, net10 `C:\Program Files\Autodesk\AutoCAD 2027`; the 2026 and net8 ref folders named in the C62 report do not exist on this PC and were not needed.
6. **Isolation (rule 1):** CE_LOG_DIR_OVERRIDE, TEMP, TMP set to scratch under `C:\CE_WORK\scratch\ff2015b`. Real folders listed before and after (`TIM_CE_CADTOOLS` incl. CE_Admin\outbox and logs, `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS`): 36,996 files each time (name, size, last-write); the two listings were identical, no real file changed.
7. **Push:** one normal commit 71fa72ad ("CIVIL-OFF-1 Opus ruling fix ..."), fast-forward from 8041dfa5 to `origin/claude/civil-off-1`; leak scan clean. No PR touched, none opened.
8. **Disk:** C: free 63.9 GB before the build, about 64 GB after cleanup (no net change at this resolution). Worktree removed after `git clean -fdXq`; scratch removed.
9. **Skipped:** nothing in the 2015 block beyond the ruling item 6 wording point (above).
