# Carpark close-as-done check, 2 Nov 2026 (read-only code read)

## FOR TIM

1. **Answer:** two of the five are already fixed in the installed Civil 3.0.89 (BUG-1229 and BUG-1215). Three are not fixed in 3.0.89 or in 3.0.90 (BUG-1217, BUG-1233, BUG-1230).
2. **BUG-1229 (grade 1 in 102):** ALREADY-FIXED-IN-3.0.89. The new level is rounded down, so the pipe is never flatter than the grade you chose, and the grade box keeps what you typed. Tests guard it. Still needs a robot or Codex look in real AutoCAD before the ledger can accept it.
3. **BUG-1215 (Feedback Help says "Save report"):** ALREADY-FIXED-IN-3.0.89. The Help page now describes "Send report" and the office-folder fallback. It is a wording fix, so a Codex look at the Help page is enough.
4. **BUG-1217 (Help invites input to Pump System and WSUD):** NOT-FIXED. The Help text still says to enter inputs and calculate on those tabs, on 3.0.89, 3.0.90 and 3.0.92. Nothing has been built for it.
5. **BUG-1233 (window silently switches Standard to "Set my own"):** NOT-FIXED. The BUG-1229 fix only stopped it rewriting a grade you chose yourself. A pipe on Standard still flips to "Set my own", and a test locks that in as "as before". CE 05 should not close this one.
6. **BUG-1230 (preview does not refresh after a change):** NOT-FIXED. It is on hold for the whole-functionality review and I found no code or test for it.
7. **Not proven:** nothing was built, tested or opened in AutoCAD. Every verdict is from reading code and git history. I did not edit BUG_CARPARK.md.
8. **Output path:** your order said `C:\CE_PLANreas\`, which looks like a missing backslash. I wrote to `C:\CE_PLAN\areas\` instead.

---

## What I checked against

1. **Fetched first:** `git fetch origin` ran at the start of this job.
2. **Installed line:** Civil 3.0.89 = commit 61fd6fbc (Sun 1 Nov 2026, "C-79a"). It is the head of `origin/claude/rel-20261106a`.
3. **Candidates:** rel-20261108a is cf059dcf (54 commits after 61fd6fbc). rel-20261110a is the b2 line. Both contain 61fd6fbc. The commits below are in 61fd6fbc, so they are in all of them (confirmed with `git merge-base --is-ancestor`).

## BUG-1229, ALREADY-FIXED-IN-3.0.89

1. **Commit:** 1f8e7d4a "Fix BUG-1229", merged as 679bf190 (PR #1838). Both are ancestors of 61fd6fbc.
2. **Where, at 61fd6fbc:**
   - `Modules/Drainage/Helpers/UpstreamDownstreamSuggest.cs` line 67 onward: `SuggestFromGradeNeverFlatter`.
   - `Modules/Drainage/Rules/SuggestedLevelGradeRule.cs` line 24: `DownstreamAtGradeOrSteeper` (rounds the level down).
   - `Modules/Drainage/ViewModels/CdViewModel.Inverts.cs` lines 783 to 830: uses the chosen grade as a minimum, no longer treats CE's own suggested level as your fall (line 870 area), and leaves a typed grade alone.
   - Setting `pipe.suggestedLevelNeverFlatterThanGrade`, `UserSettings.cs` line 1547, ships ON.
3. **Result in Tim's own example:** 9.2 m at 1 in 100 from 19.45 gives 19.35 (0.10 m fall), not 19.36 / 1 in 102.
4. **Test guard:** `Modules/Drainage.Tests/Commands/Bug1229SuggestedLevelNeverFlatterTests.cs`. It covers Tim's 9.2 m pipe typed one key at a time and pasted, the grade box keeping 100, a 20 m pipe, and the switch OFF giving the old 19.36 / 1 in 102.
5. **Look still needed:** yes. Robot or Codex in real AutoCAD, repeating Tim's 29 Oct steps (the BUG-1229 steps in the carpark). The tests prove the arithmetic and the window logic, not the drawing.
6. **Verdict: ALREADY-FIXED-IN-3.0.89.**

## BUG-1215, ALREADY-FIXED-IN-3.0.89

1. **Commit:** a3a472b2 "BUG-1215: Feedback Help describes the real Send report button", merged as 784640d5 (PR #1768). Both are ancestors of 61fd6fbc.
2. **Where:** `Modules/Drainage/Assets/Help/guide-content.js` line 100. It now says Send report saves a copy on this PC, tries the office folder in the same step, and falls back to this-PC-only with a command-line prompt to email the file.
3. **Test guard:** `Modules/Drainage.Tests/Services/FeedbackHelpWordingTests.cs` has three tests: no promise of a separate save step, names Send report and the fallback, and the dialog button is still called Send report.
4. **Look still needed:** a light one. Codex opens CDHELP, goes to the Feedback page and reads the text, then opens CDFEEDBACK and checks the button name. Wording only, no behaviour change.
5. **Verdict: ALREADY-FIXED-IN-3.0.89.**

## BUG-1217, NOT-FIXED

1. **Commit:** none found. I searched the log of all branches for 1217 and RD22-03 and found nothing.
2. **Evidence:** `guide-content.js` line 64 (the CDCALC row) still lists "Pump System" and "WSUD" among the Calculations tabs and says "enter the required inputs on the relevant tab, calculate". There is no "Older calculators" wording and no "read-only" note. This is the same on 61fd6fbc, rel-20261108a, rel-20261110a and rel-20261112a.
3. **Test guard:** none.
4. **Verdict: NOT-FIXED.** It is a small wording fix, but nobody has done it.

## BUG-1233, NOT-FIXED

1. **Commit:** none fixes it. The BUG-1229 fix (1f8e7d4a) touches the same step but only half-helps.
2. **Evidence:** `CdViewModel.Inverts.cs` lines 823 to 830 at 61fd6fbc (and the same on 3.0.90 and 3.0.92, now lines 852 to 859): `if (gradeRunN > 0 && !keepsChosenGrade)` then it sets `IsGradeCustom = true` and writes the table grade into the box. `keepsChosenGrade` is true only when you had already chosen "Set my own" with a grade. A pipe on Standard still flips to "Set my own" without asking, which is exactly Tim's complaint.
3. **Test guard:** the opposite. `Bug1229SuggestedLevelNeverFlatterTests.cs` line 272, `OnTheStandardGrade_TheWindowStillSwitchesToSetMyOwnWithTheTablesFigure_AsBefore`, locks the silent switch in. The tests do not check that Standard stays Standard.
4. **Edit Pipe:** the method returns early in edit mode (`_isEditMode`, line 772), so this path cannot be the cause in Edit Pipe. Whether Edit Pipe has its own version of the problem is CANNOT-TELL from this read. The carpark entry names both windows.
5. **Related work:** B-057 (#1873, merged in the 3.0.90 line) fixes the Grade mismatch window skipping CE's own level. It is a different thing and does not stop the switch.
6. **Verdict: NOT-FIXED.** Needs a design decision first: keep Standard and follow it, or ask in plain words before switching (Tim's expected behaviour).

## BUG-1230, NOT-FIXED

1. **Commit:** none. The carpark says ON HOLD for the whole-functionality review (Tim, 29 Oct).
2. **Evidence:** I searched `Modules` on rel-20261110a for BUG-1230 and found no code, test or comment. I did not trace the preview drawing code, so I cannot say what it does today.
3. **Test guard:** none found.
4. **Verdict: NOT-FIXED** (on hold by Tim's own order, so correct to leave OPEN).

## Skipped, and why

1. **BUG-1229 on rel-20261108a and later:** not re-read in full. The fix is in 61fd6fbc, and 3.0.90 and 3.0.92 still have the same logic (line positions only moved). I did not check whether a later commit changed the arithmetic.
2. **Structural line (rel-20261026s):** not read. All five bugs are Civil.
3. **Test results:** I did not run any test, so "tests exist" does not mean "tests pass". Nothing was built.
4. **Robot logs and PENDING_TESTS:** not checked for an existing robot PASS on 1229 or 1215. Only `areas\release-v3-colleagues-BUG1229_FIX_REPORT.md` exists by name. I did not open it.
5. **Preview code for BUG-1230:** not traced, because the entry is on hold.
