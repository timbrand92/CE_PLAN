# Opus review of the best unreviewed PRs, batch 3 (Sat 24 Oct 2026, about 05:04 to 05:20 Melbourne)

Headless job from desk plan/03 (Team, Opus 5.5). Input: `C:\CE_PLAN\areas\PR_PILE_TRIAGE_2026-10-24.md`, class E items 21 to 30, then class F plan-work items 6 to 12.

I read the code at each PR's exact head. All heads were fetched from GitHub at about 05:05 into my own copy (`C:\ce-tr\b3`) and checked against the live head on GitHub. I compared each one with the installed Civil 3.0.72 / Manager 1.1.72 line (`claude/rel-20261023m` @ f7f7d551) and with the assembled C-63 train (`claude/rel-20261024m` @ 28987b73), using in-memory trial merges. Read-only: nothing built, tested, merged, installed or pushed to a PR branch. AutoCAD and Codex were not started.

## ANSWER FIRST

1. **Counts (17 PRs reviewed):**
   1. **Class E, items 21 to 30:** MERGE 7, MERGE-WITH-FIXES 2, HOLD 1, REJECT 0.
   2. **Class F, items 6 to 12:** MERGE 3, MERGE-WITH-FIXES 1, HOLD 1, REJECT 2.

2. **Top faults found:**
   1. **#1423 (typed Pit Schedule figures follow their pit) is out of date with the installed code.** The rework does fix the 19 Oct HOLD points. But the branch dates from 18 Oct. Since then, the installed BUG-780 fix rewrote the exact line that picks a row's typed figures, and batch 2's #1629 (BUG-1022) also moves typed figures between pits. The two would fight over the same cover and depth values. It needs rebuilding on the live code, then another review.
   2. **#1070 (long section office layout) and #1192 (step-iron depth) are already done another way in the installed code.** The long section rows and the "longSection" Settings group were installed on 9 Oct. #1070 adds a second group with the same name, so it would not even build. The Pit Schedule, Edit Pit and pit advice already read the step-iron depth from Settings (`PitScheduleDepthRule`). #1192 would add a second copy of that rule. Do not merge either. Closing them is Tim's call.
   3. **#1657 (Manager update stage names) half-overlaps C-63.** C-63's #1665 already renamed the window labels to "Approved / Copied, waiting / Starts next time". #1657 uses "Copied waiting" without the comma and adds a test file with the same name as C-63's. What #1657 adds that C-63 does not have is still worth keeping: the status line and message boxes still promise the update "switches on the next time AutoCAD starts", when it actually still needs installing.
   4. **#1084 (short offcut warning) is the second PR for the same rule.** #707 (4 Oct) built `ShortOffcutRule` too, with the same class name. Only one can go in. Neither has anything that calls it.
   5. **Triage wording fix:** #1691 does not show anything new on screen. It gives the four version fields hidden names that automated checks use to find them. Nothing a drafter sees changes.

3. **Safe to merge today, into C-64 (after C-63, after the batch 1 and 2 lists), in this order:** #1601, #1607, #1616 (the three X-Civil import fixes), #1554, #1655, #1656, #1640. Then #1657 and #1691 once their small fixes are pushed. The plan-work PRs #1086, #1048 and #1037 are safe but are not pilot fixes: put them on a later plan train. #1039 joins them after its fix.

4. **Two things to know before the train is built:**
   1. **Every PR clashes on `REGRESSION_LOG.md`.** That is the usual end-of-file log clash, settled by keeping both entries.
   2. **#1640 adds one more Settings switch (`linking.xrefCompareChecksOldPosition`, ON) to the Linking group**, where batches 1 and 2 already add seven. Keep every switch when they clash. #1657 and #1691 both change `PluginManagerWindow.xaml`, and each clashes there with C-63. Merge #1657 first, then #1691.

5. **Rules checks across the batch:**
   1. **Redo (U then REDO):** nothing new writes between a U and its REDO. No PR adds an Idle, command-end or object-change hook. The only "Idle" in the batch is a window-drawing wait inside #1691's test. #1086 writes to the Settings file only when the New Pit window saves, and only with its switch ON.
   2. **Locked layers, Xrefs, REFEDIT:** no bypass. #1554 reads Xref status and paths only. #1607 and #1616 change where imported objects land. The X-Civil locked-layer "leave out" checks still run before each insert.
   3. **Switches:** the one new bug-fix switch (#1640) starts ON, has a "Default: on." line and has a test. #1655 reuses the existing ON switch for R-06, so turning it OFF now brings back the old R-06 and R-30 together. #1423's switch starts ON. Plan-work switches (#1086) start OFF, as plan work should.
   4. **CE_SHARED, installer, signed-update files:** none touched. No HOLD for that reason.
   5. **Hard-coded engineering values:** none new. #1640's 3 m "near" distance was already there. #1070's 2 m cap on pit-bottom depth is moot because #1070 is rejected.
   6. **Hard blocks:** none new. Every new line is a warning, a note or "not judged".
   7. **C-63 list:** #1657 overlaps C-63's #1665 (BUG-917 labels). No other bug here is already fixed in C-63. Only #1657, #1691 and #1423 clash with it in code.
   8. **Protected files (the Codex "must not edit" list):** the Codex PRs (#1657, #1691, #1554, #1656, #1655) touch none of them. #1086 (New Pit view model) and #1192 (Edit Pit command) are Claude PRs, where those files are allowed.

6. **One engineering question for Tim (work hours, not urgent):** BUG-904 asked for "a finer sweep near the peak, or a note". #1656 adds the note, but only when the shortest storm (5 minutes) gives the most storage. A peak that falls between two tested storms, say between 15 and 20 minutes, can still read 2 to 3% short with nothing said. **My recommendation:** take the note now, and park the finer sweep as its own item. Example: a 25 m³ tank could really need about 25.6 m³.

## One item per PR

### Class E, items 21 to 30

1. **#1657 BUG-917 (Manager): the update stages are named Approved, Copied waiting and Starts next time.** Head ae113f75.
   1. **Cause real?** Yes. The status line still says an approved or prepared update "switches on the next time AutoCAD starts". Copying it still leaves the install to do, as the message boxes themselves say ("Close AutoCAD, then finish the install"). The same stage had five different names.
   2. **Fix does only that?** Yes. It changes wording only, in three source files and the window. No actions, counts or Settings change.
   3. **Test fails without it?** Yes, as written: five source checks fail on the base. The builder ran **0 compiled tests**: the build lock was busy. The train's finalizer must run the Manager suite.
   4. **Clash with C-63:** C-63's #1665 (`4d4b9b9c`) already renamed the window labels to "Copied, waiting" and "Approved", and added `Bug917UpdateStageWordsTests.cs`. #1657 adds a file with the same name, so there are two clashing labels and one clashing test file.
   5. **Fixes (small):** (a) rebase onto C-63 and keep C-63's window labels, with the comma ("Copied, waiting"); (b) keep #1657's other changes: the status line, the two message boxes, the "Ready for next start" heading and the greyed-button reason. Use "Copied, waiting" there too, so every place matches; (c) put #1657's new test cases into C-63's test file instead of a second file of the same name.
   6. **Verdict: MERGE-WITH-FIXES. Train C-64.**

2. **#1691 BUG-961 (Manager): the running and installed version fields get stable hidden names.** Head b1c1ab64.
   1. **Cause real?** Yes. The four version and build fields on the Status page had no automation name, so an automated check could read the wrong one.
   2. **Fix does only that?** Yes. It adds four pairs of hidden names, plus a test-only way to open the window without hooking AutoCAD drawings. The normal way of opening the window still hooks them every time. Nothing on screen changes.
   3. **Test fails without it?** Yes. Two real-window cases found 0 named fields before and 1 after. The builder ran the full Manager suite: 918 run, 917 passed, 1 skipped, 0 failed. Both pictures were inspected.
   4. **Fixes (small):** (a) rebase onto C-63. The label next to it changed to "Starts next time", so the window clashes; (b) change the two hidden names "installed next start version/build" to "starts next time version/build" to match the label. The ID names (`Manager.Status.<plugin>.Installed.Version`) can stay.
   5. **Verdict: MERGE-WITH-FIXES. Train C-64, after #1657.**

3. **#1554 BUG-799 (Civil): an unloaded Xref shows SOURCE UNLOADED in the Pit Schedule, not SOURCE MISSING.** Head 7f4f8c39.
   1. **Cause real?** Yes. An unloaded Xref gives back only its saved path, often relative (`.\src.dwg`). The schedule worked that path out from AutoCAD's current folder, not from the drawing's own folder, so it never matched the linked source and said MISSING. Two differently named unloaded Xrefs at the same path were also merged into one row.
   2. **Fix does only that?** Yes. It works the path out from the host drawing's folder, never from the current folder, and groups unloaded rows by Xref name as well as path. A path is still never used as a drawing's identity. It writes nothing. I checked that the saved schedule record holds full paths (taken from a loaded Xref), so older schedules still match.
   3. **Test fails without it?** Yes. 7 of the new cases failed on the base. 43 of 43 focused tests passed on net48 and net10, and 8 window pictures were inspected. One existing test was changed on purpose: two missing Xrefs with different names now give two rows. That is the bug's own complaint.
   4. **Risk:** low. In a never-saved drawing, AutoCAD reports the template's path as the drawing path. A relative Xref would then still read MISSING, which is today's behaviour, not worse.
   5. **Verdict: MERGE. Train C-64.**

4. **#1656 BUG-904 (Civil): CDDESIGN warns when the shortest storm tried gives the most storage.** Head cb53d0f8.
   1. **Cause real?** Yes. The storm sweep starts at 5 minutes. When 5 minutes governs, the true peak may be shorter or between steps, and nothing said so. The longest-storm case already had a note (HUNT2-C-11). The shortest did not.
   2. **Fix does only that?** Yes. It adds one note line. The storage figures, storms and rainfall curve are unchanged. No switch, which is right for a note.
   3. **Test fails without it?** Yes, 3 of 6 failed on the base. The builder's full-suite run and the window pictures are marked PENDING.
   4. **Partial:** the "storage can be 2 to 3% short between steps" half of BUG-904 is not covered for a peak in the middle of the sweep. See the engineering question in the Answer First section. Keep BUG-904 open after this merges.
   5. **Verdict: MERGE. Train C-64.**

5. **#1655 BUG-906 (Civil): CDRULES R-30 leaves the storage grade unknown when the detention length is missing.** Head 52efb49b.
   1. **Cause real?** Yes. R-06 already says "not judged" for a pipe marked Detention with no detention length and no twin tick (often a downpipe with the button left on). R-30 still judged its grade against the council's storage grade.
   2. **Fix does only that?** Yes. R-30 now asks the same yes/no question as R-06 (`DetentionHasNoLengthToJudge`), and the answer tells the drafter to "enter the length or untick Detention". A real storage pipe or twin pipes are still checked.
   3. **Test fails without it?** Yes, from reading the tests: the three missing-length cases give Warn on the old code. Three older tests now record a detention length, so they still test a real storage pipe. The builder's run totals are PENDING.
   4. **Switch:** it reuses the existing ON switch `detention.detentionWithoutLengthNotDiameterChecked`, and adds the "Default: on." line. Turning it OFF now brings back both old checks together. That is acceptable, and it is written in the switch's note.
   5. **Verdict: MERGE. Train C-64.**

6. **#1640 BUG-992 (Civil): CDXREFCOMPARE also lists CE objects near a moved shape's old position.** Head c9e26aa5.
   1. **Cause real?** Yes. A moved roof or boundary kept only its new box, so a pit beside the old position was never named.
   2. **Fix does only that?** Yes. A moved shape now carries its old box as well. The "nearby objects" list checks both and names each object once, against whichever box is nearer. The "Areas moved" count and the background-changed notice are unchanged. New switch `linking.xrefCompareChecksOldPosition`, ON, with a "Default: on." line.
   3. **Test fails without it?** Yes. A RED commit stubbed the change and 2 of 5 failed. The full Civil net10 suite passed: 19,434 passed, 22 skipped, 0 failed.
   4. **Partial:** the bug's second half ("next time it forgets the old roof ever existed") is not touched. The saved previous copy is still replaced after each compare. The PR says so.
   5. **Verdict: MERGE. Train C-64.**

7. **#1601 BUG-1001 (Civil): X-Civil import gives two close pits their own labels.** Head 7e32a241.
   1. **Cause real?** Yes. The label-matching loop marked the pit as done before it checked whether the nearest text was already taken. A pit whose nearest label belonged to its neighbour lost its turn, and later got a made-up number (P11).
   2. **Fix does only that?** Yes. Four lines: it checks both first, then marks both. One label still goes to only one pit.
   3. **Test fails without it?** Yes, 1 of 2 failed on the base. 484 X-Civil tests pass.
   4. **Verdict: MERGE. Train C-64.**

8. **#1607 BUG-1000 (Civil): X-Civil import moves spot levels and FALL arrows with the pits and pipes.** Head 8adabfe6.
   1. **Cause real?** Yes. When the import shifts a far-away layout, the shift step moved pits, pipes, texts, AGI lines and source blocks, but was never given the spot-level and fall-arrow lists.
   2. **Fix does only that?** Yes. It passes both lists in and moves each one's position. I checked that the inserts later use exactly those positions, and that nothing else shifts them, so they are not moved twice. Each object has only one position to move. The second shift call (the LandXML path) has no spot or fall lists, so it is rightly unchanged.
   3. **Test fails without it?** Yes, 1 of 2 failed on the base. It uses the carpark's own numbers.
   4. **Verdict: MERGE. Train C-64.**

9. **#1616 BUG-1002 (Civil): X-Civil import keeps a rotated FALL arrow block's direction.** Head 74c69678.
   1. **Cause real?** Yes. The arrow's direction was read from the line inside the block definition, so it was never turned by the block's own rotation. The arrow's position was already transformed properly.
   2. **Fix does only that?** Yes. It adds the same block rotation the scanner already uses for pit and other blocks. That rotation is worked out from the same transforms that place the arrow's position, so it is not applied twice.
   3. **Test fails without it?** Yes, all 3 new cases failed on the base.
   4. **Gap:** a mirrored block is not handled, and the PR says so. The scan of a real DWG block was not run.
   5. **Verdict: MERGE. Train C-64.**

10. **#1423 BUG-787 (Civil): typed Pit Schedule figures follow their pit or inlet pipe.** Head da925637 (reworked after the 19 Oct HOLD, review-lane entry 1243).
    1. **Cause real?** Yes. Typed figures are saved under the row's pit, inlet pipe and outlet pipe together. Add a lower inlet, and the cover typed on the first row slides to the second row, where it is never drawn. Change the outlet pipe, and every typed figure on that pit is lost.
    2. **Did the rework fix the HOLD?** Yes, on its own branch. Pit figures (number, outlet, cover, depth, lid, remarks) now come to the pit's first row from any record of that pit. A row that is not the first row takes inlet figures only. Pit Size was dropped from the list, as asked.
    3. **Why HOLD now:** the branch is from 18 Oct. Against C-63 it clashes in `PitScheduleViewModel.Data.cs` at the exact line that picks a row's typed figures. The installed BUG-780 fix (`PitScheduleMergedRowOverrides.WithOldKeyRecord`) now lends an old-key record to the row below a merged row there. Batch 2's #1629 (BUG-1022) also moves typed records when a pit gets a new handle. The three need to be put together on purpose, not by hand in a train clash.
    4. **Second concern (LOW, from reading only):** after an outlet pipe change, the old record can stay in the drawing as a "lost source" record. If the drafter then clears the cover on the first row, the next rebuild may bring the old cover back from that record. A test should cover it.
    5. **What it needs:** rebuild on the C-63 head. Run BUG-780's lending first, then this matcher. Add tests for a merged row and for a re-found pit. Then a fresh Opus review.
    6. **Verdict: HOLD.**

### Class F, items 6 to 12

11. **#1086 UX-CMD-03 pit half (Civil): New Pit opens on the pit type and size last placed in this job.** Head dce41a1c.
    1. **Claim real?** Yes. This is queue item 23 (BUILD_QUEUE_V3). The pipe half (UX-RESUME-01) is already installed, and this uses the same job key.
    2. **Does only that?** Yes. Only type, X and Y size and the SPS radius are recalled. The cover level and labels are never recalled. "Remember last pit settings" still wins. Switch `options.resumeLastPitChoice`, empty = OFF, and nothing is written to Settings while it is OFF. The list keeps at most 40 jobs.
    3. **Test fails without it?** 7 tests are new with the new class, and there is no RED commit. The rule is simple and pure.
    4. **Risk:** low while OFF. Before it is turned ON it needs the workflow card (the review gate) and a Settings window row (Codex's).
    5. **Verdict: MERGE. Later plan train, not C-64.**

12. **#1084 UX-CR-05 (Civil): short offcut warning rule for pipe splits (engine only).** Head 9ee93c04.
    1. **Claim real?** Yes. Tim, 26 Sep: "Warn on short offcuts".
    2. **Problem:** #707 (open, 4 Oct, reviewed MERGE-WITH-FIXES then) already builds a `ShortOffcutRule` in the same folder with the same class name. Only one can go in. #1084 does fix #707's review point: an unknown length now gets its own line. But it still has #707's small display fault: a 0.996 m piece reads "1.00 m long, the minimum is 1.00 m". Nothing calls either rule, and no Settings key holds the minimum.
    3. **Verdict: HOLD.** Pick one of #707 and #1084 (Tim's call to close the other). Show the length in mm, or to 3 decimals. Wire it in when the split command card is done.

13. **#1070 Batch 6 card 6.7 (Civil): long section office layout rules (engine only).** Head bf8b1f49.
    1. **Claim real?** It was, on 10 Oct.
    2. **Problem:** the installed code got the real version on 9 Oct (`32afc0ee`). The "longSection" Settings group, `LongSectionSettings` with `officeLayout` and a Settings row list including INVERT DEPTH and DATUM LEVEL R.L. are all wired into the long section writer. #1070 adds a second `LongSectionSettings` class and a second "longSection" property. It will not build once the clash is settled.
    3. **Worth keeping:** the run title "LONGITUDINAL SECTION P1 - P6", the scale settings and the pit-bottom depth setting are not in the installed code. They should be a fresh small PR on the live code if Tim still wants them.
    4. **Verdict: REJECT.**

14. **#1048 UX-CR-08 class half (Civil): council minimum concrete pipe class, default and warning (engine only).** Head e500ef05.
    1. **Claim real?** Yes. Tim, 26 Sep: "Default from council + warn".
    2. **Does only that?** Yes. It adds two optional council-profile fields that are left out of the file when empty, so no shipped profile changes. A pure rule says "class not recorded" when the class is unknown, and never assumes Class 2. It only applies to concrete pipes and never blocks. Nothing calls it. No pipe record has a class field yet. No council values are filled in.
    3. **Test fails without it?** 8 of 9 failed against a stub.
    4. **Verdict: MERGE. Later plan train.** Real council minimums need their sources before they are entered. That is Tim's or the council file's job, not a guess.

15. **#1039 C4 B5 (Civil): pipe size check worded for the job mode (engine only).** Head deebc653.
    1. **Claim real?** Yes. The installed advisor says so itself: "From-markup wording is B5, not here".
    2. **Problem (small):** for Design-from-scratch jobs, #1039 types out its own Keep / Upsize / Unknown / No size works words. The installed `PipeFlowSizingAdvisorService.VerdictWords` already holds those words. Two places for one set of words breaks design rule 1.
    3. **Fix:** take the word from `VerdictWords` and build only the sentence around it, or limit #1039 to the From-markup words. Until a reader for "the size the supplied design states" exists, every From-markup pipe will say "Can't verify". That is honest, but it should be on the command card.
    4. **Verdict: MERGE-WITH-FIXES. Later plan train.**

16. **#1037 K-REQ-01 slices 2 and 3, plan half (Civil): which Pit Schedule cells CDPROFILE Apply would write.** Head 0cd5365a.
    1. **Claim real?** Yes. The card was approved on 25 Sep. The slice 1 preview it builds on is installed.
    2. **Does only that?** Yes. It works out a list of which cells would change, which typed cells are kept, and what is left and why. It writes nothing, so Cancel and Escape have nothing to undo. A schedule problem never stops the section.
    3. **Test fails without it?** 8 of 8 failed against a stub.
    4. **Verdict: MERGE. Later plan train.** The real write (section and cells in one Undo) still needs Tim's answer to card OPEN 2 and an AutoCAD proof.

17. **#1192 R-00 Civil 7/8: step-iron depth read from Settings.** Head c8d26ae9.
    1. **Claim real?** It was, on 10 Oct.
    2. **Problem:** the installed code already does it. `PitScheduleDepthRule.StepIronDepthMm` reads `stepIronMinDepthMm` (falls back to 900). The Pit Schedule remark, Smartify pit and Edit Pit already pass the Settings value to the pit advice. #1192 adds a second rule (`StepIronDepthRule`) for the same number and clashes in four files.
    3. **Verdict: REJECT** (superseded).

## What I did NOT check

1. **No build and no test run.** Each "test fails without it" above comes from the RED commits, the builders' reports and my own reading of the tests against the old code. Several Codex PRs (#1657, #1656, #1655) say their own compiled runs were PENDING or 0. The train finalizer must run the full suites.
2. **Trial merges only against C-63 (28987b73)**, not against batch 1 and batch 2's PRs or each other. #1423's clash with batch 2's #1629 comes from reading both, not from a merge.
3. **Nothing was driven in AutoCAD.** These parts are AutoCAD-only and unproven: the Xref status in a real drawing (#1554), the X-Civil block scan and the shifted placement (#1607, #1616), CDXREFCOMPARE on a real Xref (#1640), and the Manager window wording in both themes (#1657).
4. **#1423's "cleared cover comes back" concern** comes from reading the save and load code, not from running it.
5. **#1086:** I did not trace whether setting the pit type first resets any other New Pit field before the sizes are applied.
6. **Settings window rows** for the new switches are Codex's and were not looked at.
7. **Protected files:** I used the Codex "must not edit" list in `C:\Lisp Files\_CODEX_RUNNER\common.txt` (25 Sep). There is no newer list that I could find.
8. **Carpark status** was read from each entry's Status line (all OPEN). I did not edit the carpark, DESK_LOG or QUEUE.
