# Opus pre-review AE: PR #1881 net diff (B-028, BUG-587, a Pit Schedule row grows for a long lid and remarks note)

Written Sunday 1 November 2026 by an independent read-only Opus reviewer for CE 05, at CE 00's request.
PR head checked: **72b032fa** (branch fb/bug587-schedule-row-height). It has moved since review P (30 Oct, head 2179b824).
Lines checked: claude/rel-20261102a at 3fbb9da5 (Civil 3.0.88) and the newer C-79a line claude/rel-20261106a at 37dc1e62.
Nothing was built, tested, installed or opened in AutoCAD by this review. I ran read-only `git fetch`, `git log`, `git diff`, `git merge-tree` and `gh pr view` only.

## FOR TIM

1. **Verdict: KEEP-WITH-NOTE. The real change is 10 files, not 189.** The other 179 are older work already on the release line. GitHub counts them only because the PR still points at an old starting branch.
2. **What it does on the drawing:** a pit whose lid and remarks note runs to three lines or more gets a row twice as tall (1500 instead of 750). The note sits in the middle, and white strips hide the line across the middle of that row. The rows below drop one row.
3. **The fault from the last review is fixed.** Turn the switch off and press Update placed schedule: the white strips go and the rows go back to 750. Before the fix, the bottom pit hung below the table frame.
4. **It goes onto the release line cleanly.** The only clash is the top of the change log, where both entries are kept. Nothing else on the newer line touches the Pit Schedule drawing code.
5. **It can ride C-79c as planned. Test class: area plus smoke** (your answer of 31 Oct, no full re-test). It needs the Pit Schedule robot case plus the start-up smoke.
6. **Still not seen by anyone in AutoCAD:** how AutoCAD really wraps the note, how the white strips look and plot to PDF, Undo, and save and reopen. BUG-587 stays OPEN.
7. **The switches and the five tuning figures are still in the settings file only.** You already decided they go on a new "Switches" Settings tab (decision 126). That tab is not built yet.
8. **Next step:** merge the PR branch as it stands into the C-79c line (it brings only its own 3 commits), then run robot case N35_sched_row2 and its "switch off" twin.

---

## DETAIL

### 1. What is really B-028, and what is base noise

1. **Why GitHub says 189 files:** the PR's base is still `claude/rel-20261026z` (09126560). The branch has 112 commits beyond it. `gh pr view 1881` lists only the first 100 of them, so the B-028 commits do not even appear in that list. `git log --first-parent` shows the branch's own line.
2. **The PR's own commits (only three):**
   - **2179b824** (30 Oct 21:18): B-028, the row growth itself. 10 files, 1,335 lines added, 44 removed.
   - **07df4f48** (30 Oct 22:21): B-028b, review P's finding A (switch-off recovery) and the wording fixes. 7 files, 186 added, 20 removed.
   - **72b032fa** (30 Oct 22:22): a normal merge of `origin/claude/rel-20261102a` at 7c6af57b into the branch. Its only conflict was REGRESSION_LOG.md, resolved by keeping both entries (checked with `git show --remerge-diff`; nothing else was hand-edited).
3. **The other 109 commits** are BUG-1095, BUG-859, BUG-372, BUG-090, BUG-1228, the GB-01 slices, the C-76, C-77 and C-78 finalisers and versions, BUG-1031, BUG-1255 and so on. Every one is already on the release line: 26z is an ancestor of 02a, and `git log 37dc1e62..72b032fa` lists only the three commits above.
4. **The 189 files split as:** 182 files that changed between 26z and 02a (base noise, all on the line), plus 7 files that only B-028 touches. Three files are in both groups (UserSettings.cs, PitScheduleViewModel.Schedule.cs, REGRESSION_LOG.md). In them, only the B-028 lines are new.
5. **The net change** (`git diff 7c6af57b 72b032fa`, where 7c6af57b is the merge base with the line), 10 files, 1,501 lines added, 44 removed:
   - **New:** `Modules/Drainage/Services/PitScheduleRowGrowth.cs` (371 lines, the line estimate, the slot plan, the settings readers, and `PitScheduleSwitchOffRecovery`).
   - **New:** `Modules/Drainage/ViewModels/PitScheduleViewModel.RowGrowth.cs` (341 lines, the row measure, the move threshold and the wipeout strips).
   - **Changed:** `PitScheduleViewModel.Schedule.cs` (99 lines; place and Update use the slot plan), `PitScheduleViewModel.NetworkRedesign.cs` (18), `Services/PitScheduleContinuationLayout.cs` (28), `Services/PitScheduleCellUpdatePlanner.cs` (9, the move threshold), `Models/PitScheduleCellUpdateModels.cs` (6, line spacing per cell), `Models/UserSettings.cs` (42, two switches and five figures in the `linking` group).
   - **Tests:** `Modules/Drainage.Tests/Services/Bug587PitScheduleRowGrowthTests.cs` (614 lines, 39 tests: 34 from B-028 and 5 from B-028b).
   - **Log:** `REGRESSION_LOG.md` (17 lines).
6. **About 920 lines of shipped code**, the rest tests and the log. CE_SHARED is untouched. No ribbon, loader, window or XAML file is touched.
7. **Note for the C-79b2 list:** its item 11 says #1919's `CdCommand.cs` and `CdCommand.Grade.cs` are "also touched by #1881". That is base noise only (BUG-857, already on the line). B-028 does not touch either file.

### 2. Can it go onto the C-79 line cleanly, and how

1. **Against 02a (3fbb9da5):** `git merge-tree` merges with no conflict at all. The only difference between 7c6af57b and 3fbb9da5 is the 3.0.88 version stamp, in four files B-028 does not touch.
2. **Against C-79a (37dc1e62, 57 commits beyond 02a):** one conflict, REGRESSION_LOG.md (top-of-file entries); keep both. `UserSettings.cs` merges by itself. The merged tree differs from C-79a in exactly the same 10 files (1,504 added, 44 removed).
3. **C-79a changes nothing B-028 relies on.** Between 02a and C-79a the only Pit Schedule file that changed is `PitScheduleXrefDiscoveryService.cs` (BUG-788, two Save As Xrefs). B-028 does not touch it, and the row layout does not read it.
4. **The C-79b1 and C-79b2 PRs:** I read the file list of all 36 PRs on those two lists with `gh`. Only #1937 touches a Pit Schedule file (`PitScheduleQaService.cs`, `PitScheduleStatusService.cs`), and B-028 changes neither. So no code clash is expected when it lands after b2. I did not run a merge of all of b1 and b2 together, because b2 is not assembled yet.
5. **History trap: none.** The train list says #1881 "cannot be merged as a branch". That is true only of a merge against its old 26z base. Every non-B-028 commit in its history is already in the line. So a plain merge of 72b032fa into the C-79c line brings only the three commits, and that keeps the B-028b fix and the log resolution intact.
6. **Recommended way:** merge the branch at 72b032fa into the C-79c line and resolve REGRESSION_LOG by keeping both. The other way is to cherry-pick 2179b824 then 07df4f48, which also conflicts only in REGRESSION_LOG. Either is clean. Retargeting the PR's base to the current line on GitHub would also make its file count read 10; that is optional and only changes what GitHub shows.

### 3. Review P's findings, and what changed since

1. **Finding A (switch off does not restore a grown schedule): FIXED in code by 07df4f48, not seen in AutoCAD.**
   - **What it does now:** with `scheduleRowGrowsForLongRemark` off, `ResolveLayoutReflowThreshold` (`PitScheduleViewModel.RowGrowth.cs`, about line 89) looks for strips this schedule owns. If it finds any, the move threshold is 300 for that one Update, so the cells go back to the plain 750 grid. `RebuildRowMasksInTransaction` (about line 190) no longer returns early when the switch is off: it erases the owned strips and draws none. A strip on a locked layer is left and one line says so (`PitScheduleSwitchOffRecovery.StripsLeftLockedNote`, `PitScheduleRowGrowth.cs` near the end). Both Update (`Schedule.cs` 1115) and redesign (`NetworkRedesign.cs` 269) pass the drawing in.
   - **Small gap left:** recovery only knows a schedule was grown if it still has its strips. If `scheduleDoubleRowHidesDivider` was off when it grew (no strips drawn), then turning growth off leaves the cells where they are. Low risk: both switches ship ON.
   - **Second small gap:** if the strips are on a locked layer when the switch goes off, the cells move back but the strips stay. They then hide real lines between two different pits. The command line says so; the drafter must unlock and press Update again.
2. **The line estimate (0.75 of the text height per character): unchanged.** Still 22 characters per line for the 4200-wide lid column. It still uses the drawing's current text style without knowing its font. Nothing on the line has changed this. The new `UserSettings.cs` comment now says plainly that the count is an estimate that depends on the text style, and that at the shipped figures a note of three lines or more goes straight to a double row. Review P's suggestion (let AutoCAD wrap the real text and read its height) is not done.
3. **Wipeout strips: unchanged.** The strips are on the schedule block's own layer, 50 high, stopping 20 short of each column line. They are moved to sit just above each sheet's master block. Review P's findings B (that draw-order move goes against XCLMTXT's own crash note), C (a strip can sit above older text on a continuation sheet) and G (the strip test checks CE's column list, not the real block lines) are untouched; the author says so. The WIPEOUTFRAME setting (strip outlines) is still unknown.
4. **Locked layers: still respected.** I searched the B-028b code again: nothing unlocks a layer. A locked layer means strips are not drawn or not erased, plus one command-line line. Review P's open point stays: the master block stretch on a locked layer may stop the whole Update. That step is older code, not verified in AutoCAD.
5. **Xrefs and REFEDIT: unchanged.** Strips are only created and erased in the current drawing's model space. Update still refuses while REFEDIT is open. The placement path still has no REFEDIT check of its own (older code, not new). C-79a's BUG-788 change is about reading Xref Pit Schedules, not drawing them, and does not change this.
6. **File-only switches: unchanged, but now decided.** Tim's decision 126 (V9 "9yes", 29 Oct answers file) puts every new switch and the five figures on a new Settings tab "Switches". On C-79a there is no such tab yet (`git grep` of the Civil XAML found none). Until it ships, the only way to turn the double row off on a job is to edit `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`.
7. **Wording (review P, section 8 item 3): fixed.** The "an existing schedule does not move" sentence is gone from the `UserSettings.cs` comment and the class comment. REGRESSION_LOG item 2 now says rows below a two-row row move and a nudge of 300 or more is reset (finding D recorded).
8. **One new note (finding H, low):** with the switch ON, a schedule that never grew still has a drafter's nudge reset if it moved a cell 300 or more up or down. The test `CellsSitOffThePlainGrid` (`RowGrowth.cs`, about line 109) treats any such cell as left over from an old double row and moves it back on Update. Before B-028, every hand-placed cell was kept exactly. REGRESSION_LOG item 2 still says "A schedule with no long note does not move on Update"; it should add "unless a cell was moved 300 or more by hand". This was already in 2179b824; review P did not spot it. Example: a drafter drags P5's level text down 400 to clear a leader; the next Update puts it back.
9. **Findings E and F** (the "draw closer" step never acts at shipped figures; tightened spacing is never undone) are unchanged and remain cosmetic.

### 4. Tests (from the author's report, not re-run here)

1. **Author's run on 72b032fa:** Bug587 tests "38 passed". I count 39 test methods in the file at 72b032fa (34 at 2179b824, plus 5). I could not tell which one the report left out; the desk should see that the focused run shows 39.
2. **Civil net10 full suite on the merged result:** 21,628 passed, 32 skipped, 1 failed, 21,661 total (the one failure was the Help window offline time-out, which passed 2 of 2 alone). net48: Drainage compiled, 0 errors; net48 tests not run.
3. **Not run on C-79a or later.** The train's own run is the proof on the real line.

### 5. Which train and which class

1. **Train: C-79c**, as CE 00 already placed it, after b2. Nothing in b1 or b2 needs it, and it needs nothing from them.
2. **Class: area plus smoke**, with the start-up smoke N91 always included (decision 147, confirmed by Tim's voice answer V1 on 31 Oct, and item 89 "as recommended"). Review P said FULL because new Settings values were then treated as FULL; Tim's answers since then retire that. UserSettings.cs is additive here (seven new `linking` values), the same as N91 covers on the other trains.
3. **The area cases:** N35_sched_row2 and the control N35_sched_row2_off as described in review P section 7, including the NEW steps: record text style and WIPEOUTFRAME; Update twice (still 10 strips); one U then a delayed REDO; QSAVE, reopen, Update; and the switch-off Update on a grown schedule, which is now expected to give rows 750 apart and 0 strips. I did not find N35_sched_row2 in the robot case folder; it may not be written yet.
4. **Old-build check:** N35_sched_row2 must FAIL on the installed build without B-028 (rows 750 apart, 0 strips).
5. **The Codex looks** (review P, Looks 1 to 5) still stand, especially Look 1 (the strips, the tick marks at column lines, WIPEOUTFRAME 1) and Look 4 (PDF plot of the grown row).

### 6. Could not verify

1. Anything in AutoCAD: wrapping, the look of the strips, plot, Undo and Redo, save and reopen, locked layer, REFEDIT, the switch-off recovery.
2. A merge with all of C-79b1 and C-79b2 at once; I checked file overlap only.
3. Whether robot case N35_sched_row2 exists anywhere other than the case folder I looked in.
4. The 38 against 39 test count.

### 7. Verdict

1. **KEEP-WITH-NOTE.** 10 real files, about 920 lines of shipped code. Review P's fix-before-install item (finding A) is done.
2. **Take it onto C-79c by merging 72b032fa** (only its three commits come across), keeping both entries at the top of REGRESSION_LOG.
3. **Wording note for the finaliser:** add finding H to REGRESSION_LOG item 2.
4. **Class: area plus smoke** (N35_sched_row2, its switch-off twin, N91).
5. **BUG-587 stays OPEN** until the robot case passes and a Codex look passes (rules 4.5 and 13.3).
