# BUG-372 fix report: CDCHECK prints a raw handle and CE's internal id on the command line (Thu 29 Oct 2026, about 10:20 Melbourne)

## ANSWER FIRST

**FOR TIM**

1. **A fix is built.** Draft PR **#1835** on the newest Civil line (3.0.85). Nothing installed, nothing merged.
2. **What went wrong, in drawing terms:** CDCHECK printed computer labels you can't use. A fall arrow line said "handle 1197BB". A pipe with no name showed as "CE-CIV-PIPE-6A33BA73-..." in the connection list.
3. **What changes for a drafter:** type CDCHECK. A pipe with no name now reads "An unnamed pipe flows to WT4: Unresolved". The fall arrow line reads "FALL arrow points away from the nearest grated pit P4 (off by 168°)". Named pits and pipes read exactly as before.
4. **Also fixed while there:** the open pipe end lines ("Pipe 150 (handle 2B)") had the same fault. They now read "Pipe 150: one end is not connected". The robot's drawing has no open pipe end, so R22 never saw that one.
5. **What stays:** the saved list file that CDCHECK writes still holds the handles and labels, so an engineer can trace an item.
6. **The switch:** `checks.cdcheckLinesShowNoInternalIds`. It ships ON. Set it to false in the settings file to get the old lines back.
7. **My own mistakes:** one small one, about 1 minute of machine time. My first focused run had 3 red tests. An older test checks the exact wording of the CDCHECK print lines, and I had changed those lines. I updated that test to the new lines. It still checks they go through the same plain-text step.
8. **Which robot case proves it:** **R22** should turn from FAIL to pass in two sessions: "handle " and "CE-CIV-PIPE-" no longer appear after CDCHECK.
9. **Status:** built and unit-tested only. Nobody has opened it in AutoCAD. BUG-372 stays OPEN.

---

## Detail

1. **Start point:** `claude/rel-20261026z` at `09126560f98acc4fd6ca4be298d087307a89a259` (Civil 3.0.85 / Manager 1.1.85, C-75), re-read with `git ls-remote origin` before branching.
2. **Evidence read:** BUG-372 in `BUG_CARPARK.md` (runs 31 to 33); case `R22_cdcheck_words_no_internal_ids.case.txt`; run reports RUN-20261029-0718-C3.0.85-aX9 and -0727-bX9 (and the 3.0.84 pair in `RUNNER_BUG1225_REGRADE_3_0_84_REPORT.md`). Check 2 found "[CE] Fall 1. FALL arrow, handle 1197BB, points away from the nearest grated pit P4 (off by 168°)..."; check 3 found "1. CE-CIV-PIPE-6A33BA73-044F-4489-AC73-78E75527B461 flows to WT4: Unresolved (not confirmed from the other side)". The recorded history shows 7 of the first 19 rows carry CE ids (unnamed pipes), one of them on both sides.
3. **Cause (confident), three places:**
   1. `Modules/Drainage/Services/FallArrowDirectionReviewService.cs` lines 44 to 48 (C-75): `AwayFinding.Message` builds ", handle {ArrowHandle}, points away ..."; `ToCdCheckOutputLines` (line 221) prints it, and `SpineCheckCommand` line 115 sends it to the command line.
   2. `Shared/CE.Spine/SpineConnectionListing.cs` lines 105 to 110 and 244 (`MarkOrKey`): a record with an empty mark prints its key. Since BUG-814 `CivilSpineProjector.PipeDisplayMark` (line 779) gives a pipe whose only mark was its handle an empty mark, so every unnamed pipe prints as its key. `Commands/SpineCheckCommand.cs` line 106 printed `row.Text` as it was.
   3. `Services/PipeEndReviewService.cs` line 342 (`PipeName`, "(handle X)"), printed at `SpineCheckCommand` line 118 and in the show-where line 324. Same fault, not hit by R22's drawing.
   4. Two smaller leaks in the same command, fixed the same way: the main outlet lines (`PitMarkOf`) print an unnamed pit's key, and the Connect/Disconnect confirmation fell back to the drawing handle.
4. **Fix:** new `Modules/Drainage/Rules/CdCheckLineWordingRule.cs` (`IsOn`, `IsNoName`, `UnnamedWords`, `Readable`, `RowText`, `WithoutHandles`). `SpineCheckCommand` reads the switch once per CDCHECK and uses it for the connection rows, the FALL arrow lines, the pipe end lines, the show-where item and pipe end lines, the main outlet lines and the Connect line. `FallArrowDirectionReviewService` gains `PlainMessage` and an optional `withoutHandles`; `PipeEndReviewService.ToCdCheckOutputLines` gains `withoutHandles` (uses the existing `PlainMessage`). The saved list calls stay without the new argument, so the file keeps handles and ids. CE.Spine, CE_SHARED, Structural and Manager unchanged.
5. **Switch:** `ChecksSettings.CdcheckLinesShowNoInternalIds` (`checks.cdcheckLinesShowNoInternalIds`, default true), declared and documented like `linking.reopenedDrawingLoadsItsOwnRecord` of #1830 (doc line ends "Default: on."). No Settings page row (like the C-62 to C-75 switches).
6. **REDO and protection:** wording only. Nothing new is read from or written to the drawing; no command, regen, view or system variable change.
7. **Tests:** new `Modules/Drainage.Tests/Commands/Bug372CdCheckNoInternalIdsTests.cs`, 29 tests, 29 passed on net10 and net48:
   1. The fault reproduced without AutoCAD: the robot's row rebuilt through the real `SpineConnectionListing.Build` (an unnamed pipe to WT4 that WT4 does not confirm) prints "CE-CIV-PIPE-..." with the switch OFF; the robot's FALL arrow line prints "handle 1197BB" with it OFF.
   2. With it ON: "An unnamed pipe flows to WT4: Unresolved (not confirmed from the other side)"; "Fall 1. FALL arrow points away from the nearest grated pit P4 (off by 168°)..."; pipe end lines without "(handle 2B)"; two unnamed pipes worded both sides; named rows (a lower-case name too) word for word as before; main outlet and Connect lines; every object kind's words; any CE id counts as no name.
   3. The saved list keeps "handle 1197BB". The switch loads ON through both start-up reads (empty file, empty checks group, group with other keys); typed false turns off only itself. Source guards on the command and the rule file.
   4. `CdCheckCommandLineArrowTests` (BUG-389 guard): its three expected call lines updated to the new text; it still checks every line goes through `CommandLineText.Plain`.
8. **Build and test evidence:** private worktree `C:\ce-fx\b372`; scratch `C:\ce-fx\j859`; Release; `-p:SkipDevBundle=true -nr:false --disable-build-servers`, the C-62 AutoCAD refs, `build.lock`, dotnet at Below Normal. Results:
   1. Focused run (Bug372, CdCheck, CdBranchEnds, FallArrow, Spine, Checks, C75NewSwitch, PipeEnd, Bug377, UserSettings): 1,151 total, 1,151 passed (first try 3 red, see FOR TIM item 7).
   2. **Civil net10 full suite: 20,835 total, 20,803 passed, 32 skipped, 0 failed.** (By coincidence the same total as the BUG-859 branch: each adds 29 tests to the same base.) The PDF page test did not fail.
   3. **Civil net48 compile: 0 errors.** The new class and the BUG-389 guard pass on net48 too (38 of 38).
   4. Never deployed; AutoCAD not touched; Tim's settings files and the installed bundle not touched.
9. **Commit and PR:** `96a7b65e` on `fb/bug372-cdcheck-no-raw-ids`; draft PR **#1835** against `claude/rel-20261026z`. REGRESSION_LOG.md entry added at the top.
10. **Not tested or not known (RULES 5.9):**
    1. Nothing driven in AutoCAD.
    2. "An unnamed pipe" does not say WHICH unnamed pipe; the drafter finds it with the row number at the show-where question (Items), which zooms to it and selects it, as before.
    3. Other commands (CDRULES, CDCHECKCURRENT, the move and stretch lines named in the bug's older runs) were not swept here; R22 covers CDCHECK only. The older "no clear spot ... (on "the block Drawing Border")" item of BUG-372 is not touched.
11. **For the robot after install:** run R22 in two separate sessions on the installed build. Right result: check 1 still finds "[CE] CDCHECK:", checks 2 to 6 pass. Retag R22 off EXPECT-FAIL only after two passing sessions and an independent review of its case.
