# Independent Opus review A: tonight's Max and Team draft PRs (23 Oct 2026, evening, Melbourne)

Reviewer: Opus 5.5 (claude-opus-5-5), independent of the builders. Base for every PR: `origin/claude/rel-20261023m` @ `f7f7d551` (C-62, Civil 3.0.72 / Manager 1.1.72), re-fetched about 20:55. I read the code, not the PR text. My own read-only worktrees were under `C:\ce-rv2` (removed at the end). Nothing deployed, AutoCAD not started, no PR or branch closed, deleted or pushed to, and Tim's settings and installed bundles not touched.

**Reports:** `MAX_BUILD_C_REPORT.md` and `FB_TEAM_BATCH1_REPORT.md` did NOT exist when I finished. Their PRs were already open, so I reviewed them from the code and the PR text: #1660 (Max C), #1659 (FB-02), #1663 (FB-04), #1671 (FB-05). No `fb/fb03`, `fb/fb06` or `fb/fb07` branch existed on GitHub.

## ANSWER FIRST

1. **Verdicts, 8 PRs:** MERGE 6, MERGE-WITH-FIXES 2, HOLD 0, REJECT 0. All 8 belong on train **C-63 (Civil/Manager)**.
2. **Top 3 faults:**
   1. **#1664 (pipe material) settles an engineering question without Tim.** A pipe with no recorded material is now sized with the Settings "unrecognised material" roughness (0.013, as rough as concrete) instead of smooth UPVC. That can step a design up a pipe size for every pipe with a blank material. It is a sound safe-side default and lives on the Settings page, but it is Tim's call (RULES 4.5). Merge it, and put the question on Monday's list; it cannot be Codex-accepted until he answers.
   2. **Every PR adds its entry at the top of `REGRESSION_LOG.md`, so all 8 clash there.** Only that file clashes: I merged all 8 together and every code file joined cleanly. The merger has to keep both entries each time, not pick one side.
   3. **Two new switches have no row on the Settings page:** #1658 ("keep an unreadable CE record") and #1659 ("a pit placed on a pipe moves its connection decisions"). Both start ON, which is right for a bug fix, but the settings-first rule wants a row. This is a Codex window-lane follow-up, not a reason to hold the PRs.
3. **Safe to merge today, in this order:** #1658, #1664 then #1669 (it sits on #1664), #1671, #1663, #1660, #1665, #1659. Each one is still "built and unit-tested"; none has been opened in AutoCAD.
4. **My one build:** all 8 merged into one tree, then the Civil net10 test project built and the affected test groups run. the merged Civil plugin compiled with 0 errors. Civil net10 tests: **19,635 total, 19,611 passed, 22 skipped, 2 failed**. My filter caught almost the whole suite. Both failures are in `SourceAtomicCoordinatorDependencyTests`, which reads the compiled Release code and expects its exact shape ("Release IL keeps preferEndpoint on the evaluation stack"); I built in Debug, so it differs. No PR touches those files (source landing / source atomic), so they are not a fault of tonight's PRs. The Release build was not re-run to prove this. Mistake, said plainly: the first attempt stopped before tests because a fresh worktree has no native `CE_TRANSFORM_2027.arx`. I added the same empty placeholder the main checkout uses, in my own worktree only, and finished that build, so it was one build in two runs. The C# had already compiled in the first run.

## Per PR

1. **#1658, BUG-971: a damaged CE record is never saved over (fb/max-971 @ f007893b). Verdict: MERGE. Train C-63.**
   1. **Cause real?** Yes. On the base, the normal load turned "the record is there but will not read" into "no record", and the save and every in-command record write (`WriteSnapshotInTransaction`, behind MOVE/STRETCH, Batch edit, CDREPAIR, CDAGI, strip drain, CDTANK, the calculation workspace, network edits, same-plan break, source landing, spine upgrade) then wrote a rebuilt record over it.
   2. **Does only what it says?** Yes. One memory-only gate (`RecordWriteHeldBecauseUnreadable`) is asked by all five methods that write the record. I searched every file in the plugin for writes to the record's key: those five are the only writers, and the new source-guard test fails if a sixth appears. A record is held only if it exists, has text, and the JSON fails to read. A read that throws earlier (an AutoCAD fault) does NOT hold it, so a passing glitch cannot freeze a drawing. An absent record or a closing drawing releases the hold.
   3. **Redo safety:** safe. The gate opens no transaction and writes nothing; it only removes writes. The close hook releases by pointer only. No new hook in the reviewed-hooks list.
   4. **Risks:** (a) a drawing whose record fails to read for a reason of OUR making (a field whose type changed between CE versions) is now frozen: every CE record write is skipped with one "Not saved to the CE record" line per kind. That is the intended warn-and-carry-on, but Codex should open one older 2.x drawing too. (b) No Settings row for `linking.keepUnreadableDrawingRecord` (fault 3). (c) The carpark asked for "keeps a copy" and a repair action; neither is built (the original simply stays in the drawing). Not blocking.
   5. **Not touched:** CE_SHARED, installer, signed-update gate. No hard block (it never throws).

2. **#1664, BUG-868: pipe material reaches network sizing (fb/max-868 @ b8c17aa1). Verdict: MERGE-WITH-FIXES (Tim's answer, not code). Train C-63.**
   1. **Cause real?** Yes. On the base, `NetworkDesignService` hard-coded `Material = "UPVC"` in both the sizing pass and the re-check pass, so RCP was sized at n 0.010 and capacity over-stated.
   2. **Does only what it says?** Yes. The material now goes from the record through CDRUNSOLVE (`ProposalApplyService.PlanBuilders`) and network redesign (projector, solver request, hash) into the sizer. Switch OFF returns "UPVC" exactly as before. Unknown or unlisted materials get `ManningsNNotRecognised` from Settings, and the record is never filled in. The material sentence is its own field. The CDRULES fingerprint skips the new switch through the fingerprint-only resolver (I checked: it does not stop the setting being saved). The Settings row, binding, reset and save are all wired.
   3. **Risks:** (a) **fault 1: needs Tim's word** on Unknown = rough. (b) The redesign hash now includes material, so any saved, not-yet-applied redesign preview goes stale once and has to be re-run (correct, but colleagues will see it once). (c) `ProposalChangeRow.HasMaterialDetails` still finds the material by matching "Material:" in the reason text, although the report says matching was removed. It only switches text wrapping on, so it is harmless. (d) It edits three windows (Settings, Advanced Settings, proposal preview), which is Codex's window lane; the edits are small and rendered pictures were checked.
   4. **Fix before Codex-accepted:** none in code. Record Tim's answer on Unknown roughness; if he picks "refuse" or "roughest", that is a follow-up PR.
   5. **Settings-first:** passed. Every roughness comes from Settings; no new hard-coded number.

3. **#1669, BUG-964: redesign pit level is the start of its outgoing pipe (fb/max-964 @ d361f797, stacked on #1664). Verdict: MERGE after #1664. Train C-63.**
   1. **Cause real?** Yes. Step 4 set a pit's level to the FAR end of its outgoing pipe, so the incoming pipe arrived only one junction drop above that, below the start of the outgoing pipe (the 170 mm drop in the carpark's A-B-C example).
   2. **Does only what it says?** Yes. It changes one line (`pitInvert = pipeUpstreamIL`), plus the matching output check and the comments. Four verified snapshot files move, as expected. I checked the other readers of a pit's solved level (fixed-pit conflict check, long section, preview projection, cover/depth). They all now get the physically correct (shallower) pit level, which is the intended change.
   3. **Risks:** a pit the designer has fixed is now compared with the start of its outgoing pipe, so a fixed pit that "passed" before may now report a conflict (more correct). The stack is clean: only one commit on top of #1664.

4. **#1665, wording: 6 findings (fb/max-wording-1 @ 4d4b9b9c). Verdict: MERGE-WITH-FIXES (one small follow-up). Train C-63.**
   1. **Real?** Yes. I checked each old string on the base: "Installed next start", "Updates ready to get", "Ready next start", "Update ready", "2 · Ready", "Sync Links", "Repair Center", "full-detail snapshot", "Show tag label on screen?", the CopyRot/MoveRot/CopyRotate lines, and "Preferences" on the Manager Civil tab.
   2. **Does only what it says?** Yes. Words only, no bindings or commands changed (CDSYNC and the stable AutomationIds kept). The new tests pin the new words.
   3. **Fix (small, can follow):** the ribbon/toolbar label still says "Repair Center" in `Modules/Drainage/Assets/Config/command-registry.json:351` and `ce_toolbar_layout.json:222`, so the ribbon and the window disagree in spelling. Change both to "Repair Centre" (check the ribbon label guard tests).
   4. **Wording check:** the top strip "Approved" counts modules with an approved update that has NOT been copied yet (`CanReviewPreparation`). Once copied it drops to 0 and "Copied, waiting" goes to 1, so a colleague may read "Approved 0" as "my approval was lost". Acceptable; consider "Approved, not copied" later.
   5. **Risks:** Manager and Civil source only; no CE_SHARED, installer or settings file. One known one-line clash with #1534 in `PluginManagerWindow.xaml` (#1534 is not in this train). "Then run the CE installer" is still shown (that fix lives in #1534).

5. **#1659, BUG-690 FB-02: a pit placed on a pipe moves the pipe's decisions to the half they sit on (fb/fb02-inline-split-decisions @ 62a8dea8). Verdict: MERGE. Train C-63.**
   1. **Cause real?** Yes. The inline split gave the second half its own identity but left every decision row naming the old pipe key, so the far-end decision, downpipes beyond the split and branches beyond it stayed with the first half.
   2. **Does only what it says?** Yes. One pure rule (`InlineSplitDecisionPolicy`), called once inside the split's own transaction, straight after the second half gets its identity. The first half keeps the old key, the far end goes to the second half, on-run rows beyond the split go across with their chainage reduced (converted to mm), and a branch goes across only if its nearer end measures beyond the split point. An unreadable ledger leaves the split as it was, with a log line. It never fails the split.
   3. **Redo safety:** safe. The write is inside the existing split transaction, so one U and REDO take the split and the decisions together. Nothing writes outside a command.
   4. **Risks:** (a) **Design rule 1 drift:** the tracked split (`SourceChangeDecisionPolicy.After`) REFUSES when a branch decision targets the pipe being split ("its transfer needs review"), while the inline split now moves it by geometry. Two behaviours for one idea; log it as a follow-up to make them one. (b) For each branch decision it scans all of model space, which is slow in very large drawings but only runs when such a row exists. (c) There is no Settings row for `linking.inlineSplitMovesDecisions`; the PR says the Settings window has no room (fault 3).

6. **#1663, BUG-373 FB-04: Edit Pipe, then Cancel, no longer marks the drawing changed (fb/fb04-edit-pipe-cancel @ 636e6c48). Verdict: MERGE. Train C-63.**
   1. **Cause real?** Yes, by the code: `EnsureDrawingDataCurrent` runs before the window opens and its catch-up record save reached the drawing straight away, so Cancel still left a change.
   2. **Does only what it says?** Yes. It reuses the existing BUG-290 hold (`HoldRecordWritesUntilAccepted`), the same one CDPROPAGATE and CDRUNSOLVE use, so it follows design rule 1. The hold is accepted before Save, before the older-pipe question (which writes its own step), and before Move arrow and Inspect. Every other exit (Cancel, Escape, early returns, errors) disposes the hold, restoring the record in memory and writing nothing. A second Accept or Dispose does nothing.
   3. **Redo safety:** better than before (fewer writes). The hold is memory only.
   4. **Risk:** a save that was already waiting before CDEDIT started is put back as waiting and still written at CDEDIT's end, so DBMOD can still move in that one case. That is old behaviour and right. The PR says so honestly: the cause was read from the code, not measured.

7. **#1671, BUG-817 FB-05: opening and closing the Pit Schedule leaves no Undo step (fb/fb05-pit-schedule-open-no-write @ 920e8995). Verdict: MERGE. Train C-63.**
   1. **Cause real?** Yes, both halves. `FlushPendingSave()` writes even when nothing is waiting (it sets a save waiting itself), and PITSCHEDULE was on the always-write-at-command-end list.
   2. **Does only what it says?** Yes. Close now writes only if a save is waiting for the drawing the window opened on (`IsSaveWaitingFor`, read-only), and writes it to THAT drawing. PITSCHEDULE leaves the list, so a real edit still writes at command end through the existing non-trigger path (`FlushProjectDataIfTriggerCommand`, which flushes when `IsSaveWaitingFor` is true). The window is modal inside the command, so the write stays in PITSCHEDULE's own Undo step. If the drawing is unknown, the old always-write stands.
   3. **Redo safety:** better (fewer writes).

8. **#1660, Max C, BUG-869 follow-up: step-iron note follows the real pit depth; a shared frame heading is not renamed (fb/max-c-pit-depth @ ca83afd0). Verdict: MERGE. Train C-63.**
   1. **Cause real?** Yes. F1: the step-iron test parsed the two-decimal depth text (904 mm reads 0.90, so it is not deeper than 900). F3: the heading was renamed inside the frame's block definition, which every schedule drawn from that frame shares.
   2. **Does only what it says?** Yes. The step-iron decision now uses the unrounded recorded levels, and the window takes the deeper of the cell and the recorded depth (a typed shallower depth cannot remove the note). The heading is renamed only if every reference to the frame definitions belongs to this schedule, its continuations, or blocks nested in that chain. Otherwise it is left as drawn, with one "[CE]" line and a log line (a warning, not a block).
   3. **Redo safety:** checked. The automatic refresh path still reads only the CE record (`GetPipeInvertAtPit` and `LowestInletInvertText` read record text, not the drawing), so no transaction is added after U. The heading check is read-only until it decides to rename, inside the existing placement/update transaction.
   4. **Risks:** the heading rename moved after `SynchronizeScheduleMastersInTransaction` on placement (it needs the continuation handles). That is fine because both are in the same transaction. Locked layers: unchanged (`ValidateWritableEntity` still runs before any rename).

## Merge-order notes

1. Code files merge cleanly in any order. I checked all 28 pairs and then built all 8 together. Shared files: `UserSettings.cs` (#1658 Linking, #1659 Linking at a different spot, #1664 DesignStandards) and `LinkService.cs` (#1658 close handler, #1671 the command list). All join cleanly.
2. `REGRESSION_LOG.md` clashes on every pair. Keep both entries each time.
3. #1669 needs #1664 first. #1665 has a one-line clash with #1534 (not in this train).
4. None touch CE_SHARED, the installer or the signed-update gate, so Civil and Manager stay byte-identical on CE_SHARED.

## What I did NOT check

1. Nothing was opened in AutoCAD. Every PR is built and unit-tested only; none is Codex-accepted or Tim-accepted.
2. I did not re-run each PR's "fails without the fix" test on its own base; I relied on the builders' red-first counts plus my reading of the code. My one build ran the merged tree only, net10 only, in Debug (so two Release-only IL guards could not pass).
3. net48 and net8 were not built by me. The Manager test project was not run (#1665's Manager tests rely on the builder's 938-test run).
4. I did not look at #1664's 18 window pictures or any Light-theme render.
5. I did not review #1534 (wording, 48 findings), #1576, #1537 or #1555. Those are superseded by or carried in the PRs above and stay open.
6. Team batch report and Max C report did not exist, so I could not check the builders' own claims against them (test counts above come from the PR text).
