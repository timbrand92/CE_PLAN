# Opus re-check H2: PR #1873 (B-057b), Grade mismatch window skips only CE's own suggested level

Reviewer: Max Opus, read-only, Fri 30 Oct 2026 (Melbourne). Brief: `C:\CE_PLAN\desk_jobs\RECHECK_BRIEF_1873.txt`.
Reviewed: branch `fb/b057-mismatch-box-own-suggestion` at `2b0953fc` (B-057b on top of `75e3baab`, on `claude/rel-20261030a` at `f5dd72a0`, Civil 3.0.87 / C-77). Fetched read-only. Nothing built, no tests run, no AutoCAD opened, no repository file changed. Line numbers are at `2b0953fc`. Earlier review: `C:\CE_PLAN\areas\OPUS_PREREVIEW_H_1873_B057_30OCT.md`.

## FOR TIM

1. **Verdict: RE-CHECK OK WITH NOTE. Safe for the C-78 addendum.** Both holes I found earlier are closed in the code. Built and unit-tested by the author only. Nobody has opened it in AutoCAD.
2. **Hole 1 is closed:** 4.1 m pipe, upstream 19.45, CE fills 19.40 at 1 in 100, then you change the grade box to 200. At Draw, CE works out what it would give at 1 in 200 (19.42). The box says 19.40, so it is your level, and the window opens again (the pipe is really 1 in 82).
3. **Hole 2 is closed:** type 19.45, type your own 19.30, then retype the upstream as 19.50. CE carries your fall across to 19.35. At Draw, CE's own rule from 19.50 gives 19.45, not 19.35, so the window opens again (the pipe is really 1 in 27).
4. **"I know one end" ON:** skipping is right. CE throws your second box away at Draw and works the level out again from the grade you typed, always as steep or steeper. It can never come out flatter than your grade, and if it ever did, the window would still open. It does not check council minimums; it never did.
5. **One small loss, which I accept:** if you type exactly the level CE would have given (for example 19.87 on a 10 m pipe at 1 in 80), CE cannot tell it from its own, so no window, even if someone lowers the Settings percentage. The pipe is at most one 10 mm step steeper than your grade. Your PC uses the normal 10 per cent, so you see no change. Turning the switch off brings the old window back.
6. **NOT proven:** nothing tried in AutoCAD; I did not build or run the author's tests. The label still shows your typed grade (1 IN 100) on a pipe that is really steeper (1 in 82). That question is still yours, with CE 04.

---

## DETAIL

### 1. Do both holes close? (trace with the numbers)

1. **How the new check works.** `Modules/Drainage/Commands/CdCommand.Grade.cs` lines 258-266: with the switch on, the second level counts as CE's own when (a) "I know one end" was ON (`levelsWorkedOutAtDraw`), or (b) `MismatchBoxOwnSuggestionRule.SecondLevelIsWhatCeWouldWork` is true (`Modules/Drainage/Rules/MismatchBoxOwnSuggestionRule.cs` lines 25-33). (b) works the level out again at Draw with the same function the window uses (`SuggestedLevelGradeRule.DownstreamAtGradeOrSteeper`, `Rules/SuggestedLevelGradeRule.cs` lines 24-31). It uses the current upstream level, the Draw length (`distanceMm`) and the current typed grade (`typedN`), and allows a tolerance of a quarter of the Settings step, never more than 0.5 mm. Even then the window is skipped only if the pipe is as steep as or steeper than the typed grade (`SkipsQuestion`, rule lines 40-45). Anything else goes to the unchanged percentage test (Grade.cs lines 270-274). The call site is `Commands/CdCommand.cs` line 588: `levelsWorkedOutAtDraw: !effectiveSimplePipeOnly && vm.AutoCalcSecondInvert`. No remembered flag is used any more. `DownstreamBoxStillHoldsSuggestedLevel` is now used only by the BUG-1229 held-fall logic (`ViewModels/CdViewModel.Inverts.cs` line 869) and one test assertion.
2. **Hole 1 trace ("I know one end" OFF).** In the window, 4.1 m, Set my own 100, upstream 19.45. The suggestion gives floor(19.409 to 10 mm) = 19.40. Change the grade to 200: the setter does not recompute (pinned by the test at `B057MismatchBoxOwnSuggestionTests.cs` line 140). At Draw, with "I know one end" OFF, the box values are used as typed (CdCommand.cs lines 492-556 are skipped), so first = 19.45, second = 19.40, length 4100, typedN 200. The rule gives 19.45 - 0.0205 = 19.4295, floored to **19.42**. That differs from 19.40 by 20 mm (more than 0.5 mm), so the level is not CE's own. Ratio 4.1 / 0.05 = 82, which is 59 per cent off 200, so **the window opens**. Closed. Test: `Hole1_TheGradeChangedAfterTheSuggestion_StillOpensTheWindow` (line 135).
3. **Hole 2 trace ("I know one end" OFF).** Upstream 19.45, CE fills 19.40. Type 19.30, so `_secondInvertUserSet` becomes true. Retype the upstream as 19.50: the held-fall branch writes 19.35 (`Helpers/UpstreamDownstreamSuggest.cs` lines 64-65 and 102-110). At Draw the rule gives 19.50 - 0.041 = 19.459, floored to **19.45**. That differs from 19.35 by 100 mm, so the level is not CE's own. Ratio 4.1 / 0.15 = 27.3, which is 73 per cent off, so **the window opens**. Closed. Test: `Hole2_...` (line 147).
4. **The re-pick / length change route I could not verify last time is also closed.** The Draw now uses the Draw length, so a stale box level from an older length no longer matches.
5. **Robustness:**
   1. **Rounding (10 mm):** same function, same inputs, same Settings decimals. The window's suggestion uses `UpstreamDownstreamSuggest.LevelDecimals`, which is Settings `CalculatedDecimals` (lines 36-37); the Draw check uses `SettingsService.Current?.Inverts?.CalculatedDecimals ?? 2` (Grade.cs line 262). A 0.5 mm tolerance against a 10 mm step cannot mistake the next step for CE's own. An upstream typed to 3 places (19.455) gives the same 19.41 both times. Negative levels floor downwards (steeper) both times. Unit cases at test line 224 cover 2 and 4 decimals and grade 0.
   2. **Different length at Draw (safe side):** a same-plan break asks for the real length at Draw (CdCommand.cs lines 442-454) after the window used the drawn length. The levels then do not match, and the window opens as it did before B-057. That is safe, but the short-pipe nuisance comes back for same-plan breaks only. Not tested.
   3. **Recent level buttons (#1839):** irrelevant now. The check compares values at Draw, not how the level got into the box.
   4. **Edit Pipe:** the only product caller is `CdCommand.cs` line 586 (grep at `2b0953fc`). Edit Pipe never shows this window.
   5. **Undo / reopening the window:** the check is stateless. Nothing is stored in the window, the drawing or the pipe record. Each Draw works it out afresh.
   6. **Suggestion switch `pipe.suggestedLevelNeverFlatterThanGrade` OFF:** the window then rounds to the nearest 10 mm. Where that equals the floored level, the pipe is steeper and the window is skipped. Where it rounds up (flatter), it does not match and the percentage test applies, as before. Safe.

### 2. "I know one end" ON

1. **The second box is not used.** CdCommand.cs lines 492-556 recompute the worked-out end from `TryGetAutoCalcGrade` (Grade.cs lines 21-56). In Custom mode that is `CustomGrade`, the same text the mismatch check parses into `typedN` (Grade.cs line 244), so both use the same grade. Only `!lengthHeld` Draws reach the check (line 586), and the recompute runs in exactly those cases (line 492), so `levelsWorkedOutAtDraw` is true only when the levels really were just worked out.
2. **Never flatter.** `MathHelper.ApplyCalculatedInvertRule` (`Helpers/MathHelper.cs` lines 296-330) raises the drop to the minimum drop (line 315) and rounds it up (line 317), in both directions (upstream known or downstream known). So the real grade is always as steep as or steeper than the typed grade. If floating-point noise ever made it a hair flatter, `SkipsQuestion` would be false and the normal percentage test would run (rule line 45). Test: `IKnowOneEndOn_..._ButAFlatterOneStillAsks` (line 170).
3. **"Flatter than 1 in 100":** this window never compared against a council or AS/NZS 3500.3 minimum. It compares the typed grade with the levels only. If a drafter types 1 in 150, the recomputed pipe is about 1 in 150 or steeper, the window was quiet before and is quiet now, and the minimum-grade checks (CDRULES, design checks) are unchanged. **No new hidden case.**
4. **What it does hide, by design (already in the pre-review):** with "I know one end" ON and the switch ON, this window can effectively never open, because the Draw level is always as steep or steeper. Short pipes with the 20 mm minimum drop are the extreme: 1.0 m at 1 in 200 becomes 1 in 50 with the label "1 IN 200". This is the CE 04 label question, not a fault in this PR.

### 3. The side effect and the changed test

1. **The side effect:** a typed second level equal to the floored CE level counts as CE's own, so no window appears regardless of the Settings percentage. The size of the loss is bounded. With "I know one end" OFF the extra fall is less than one Settings step (10 mm), and it is always on the steep side. The levels, CDCALC and the Pit Schedule levels are unchanged; only the label grade is not questioned. That is the same trade B-057 makes for CE's own levels. **Harmless; a small label-honesty loss only for an office that lowers the percentage.** Tim's `C:\Users\TimothyBrand\AppData\Roaming\TIM_CE_CADTOOLS\CD_Settings.json` has no `achievedGradeNoteTolerancePercent` key, so the default of 10 applies. I read the file; I did not open the Settings page.
2. **The changed test is legitimate.** `GradeMismatchToleranceTests.ASmallerSettingsValue_AsksSooner` (line 54) uses first 20.00, second 19.87, 10 m, 1 in 80. CE's rule gives 20.00 - 0.125 = 19.875, floored to 19.87, so the level is CE's own and steeper (1 in 76.9), and the switch skips it before the percentage is read. The fixture tests the percentage, so turning the switch off in `[SetUp]` (lines 23-31) isolates what it tests. The other cases are unaffected: 19.887 is not CE's level, and the 0.13 m case at the 10 per cent default is quiet either way. **It does not hide a regression**, but it now leaves two things unpinned:
   1. A test pinning the side effect itself (switch ON, 3 per cent, 19.87: no window).
   2. A test proving that a lowered percentage still works with the switch ON for a level that is not CE's (for example 19.88 at 3 per cent: the window opens).

   **NOTE:** add both (a few lines each). Not blocking.
3. **Other callers checked:** `GradeAutoCalcTests` lines 64-105 and `Bug331MetreLengthTests` line 625 use levels that are not CE's floored level, or are flatter, so they are unaffected. C-78's `Bug857GradeMismatchBoxTests` line 33 (20 m, 18.00 to 17.90 against 1 in 100) is flatter, so the window still asks and that test is unaffected after the merge.

### 4. Switch and clashes

1. **Switch:** `pipe.mismatchBoxSkipsOwnSuggestion` (`Models/UserSettings.cs` lines 1451-1461), `= true`. The summary ends "Default: on.". A missing group reads ON (rule line 18). **OFF = exactly today:** with the switch off, the whole B-057 block is skipped (Grade.cs line 259) and the unchanged percentage test runs, with "I know one end" ON or OFF (test `SwitchOff_GivesTodaysWindows`, line 181).
2. **NOTE, wording out of date:** the `UserSettings.cs` summary (lines 1452-1458) still describes the B-057 version: "when the second level in the New Pipe window is still the level the window itself worked out" and "A level the drafter typed or edited still gets the 10 percent test". Both are no longer exactly true. It should say "equals CE's own rule worked out again at Draw, or I know one end is ON", plus the typed-equal exception. This is wording only, not behaviour. The rule file's own summary (lines 6-14) is correct.
3. **Clashes (read-only, old-form `git merge-tree <base> <ours> <theirs>`, prints only):**
   1. **`claude/rel-20261102a` (C-78, `91963bd0`):** `CdCommand.cs` merges **cleanly**. BUG-857 rewrites the body of the `if` (Cancel/Esc) and B-057b changes line 588 of its condition; the merged result holds both. `UserSettings.cs` merges cleanly. **`REGRESSION_LOG.md`**: a top-of-file conflict (`@@ -1,3 +1,4 @@`), both entries prepended. Keep both.
   2. **#1871 (`fb/bug1255-closedxml-autocad-2027`, `9a1f4e64`):** only the `REGRESSION_LOG.md` top-of-file conflict. `UserSettings.cs` merges cleanly.
   3. **#1868 (`fb/bug1091-redesign-reads-min-fall`, `38c3f825`, base `claude/gb01-slice1-falls`):** `REGRESSION_LOG.md` top, and **`UserSettings.cs` around line 1437** (end of `PipeSettings`, against `LargePipeRedesignReadsMinFall`). **That conflict is not caused by B-057:** the same merge from `f5dd72a0` without B-057 gives the identical 9-line conflict (BUG-1229 / C-77 against #1868's older base).
   4. **#1874 (`fb/bug1096-reuse-boxes`, `1b8b4af1`, base `claude/rel-20261026z`):** `REGRESSION_LOG.md` top, and `UserSettings.cs` around line 3013 (`RainwaterReuseBoxes` against the GB-01 retired detention-grade comment). **Not caused by B-057:** the same conflict appears without it.
   5. **#1875 (`fb/bug816-tidy-setting-row`, `1c270c45`, base `claude/rel-20261026z`):** only the `REGRESSION_LOG.md` top. The Settings-page files it touches merge cleanly.
   6. **Summary:** the only clash B-057b itself adds anywhere is the top-of-file `REGRESSION_LOG.md` one. Keep both entries.

### 5. NOT proven, and the AutoCAD scenarios

1. **Not proven:**
   1. Nothing has been run in AutoCAD.
   2. I did not build or run tests. The author's figures are the author's claims: full Civil net10 run 21,532 with 1 failure, then 112 focused tests passing with 0 failures, and net48 with 0 errors.
   3. "N33e and N33f fail before the fix" is from reading the code. I agree with it from my own trace of `75e3baab` in the pre-review, but nobody has run the old build.
   4. The same-plan-break real-length case (window comes back) is read from the code, not tested.
   5. The checks go through the window model and the check function. None of them runs the real Draw path, so a robot run is needed.
2. **Robot cases (CE 02), one drawing, two CE pits 4.1 m apart, 100 mm pipe, Set my own, settings read at start:**
   1. **N33a ("I know one end" ON):** upstream 19.45, grade 100, Draw. **Expected:** no window; downstream 19.40; label 1 IN 100.
   2. **N33b ("I know one end" OFF, upstream only, Custom 1 in 100):** type upstream 19.45, leave CE's 19.40, Draw. **Expected:** no window; 19.40; label 1 IN 100.
   3. **N33c (OFF, typed steeper):** upstream 19.45, type downstream 19.37, Draw. **Expected:** the window opens (about 1 in 51).
   4. **N33d (OFF, typed flatter):** downstream 19.43. **Expected:** the window opens (1 in 205).
   5. **N33e, hole 1 (OFF):** upstream 19.45 (CE gives 19.40), change the grade box to 200, Draw. **Expected:** the window opens, showing 200 typed and 82 actual.
   6. **N33f, hole 2 (OFF):** 19.45, type downstream 19.30, retype upstream 19.50 (CE writes 19.35), Draw. **Expected:** the window opens (about 1 in 27).
   7. **N33g (suggested addition, OFF):** upstream 19.45, grade 100, then retype the upstream as 19.60 (CE writes 19.55), Draw. **Expected:** no window. This shows that a plain re-type stays CE's own.
   8. **N33h (suggested addition, ON, hole-1 shape):** "I know one end" ON, upstream 19.45, grade 200, Draw. **Expected:** no window; downstream 19.42 (1 in 137); label 1 IN 200. This shows the ON route works from the current grade.
   9. **Twin N33s:** set `pipe.mismatchBoxSkipsOwnSuggestion` to false in CD_Settings.json before launch. **Expected:** N33a and N33b now open the window. Close it with "keep typed grade", or with Cancel if BUG-857 is in the payload, which places no pipe.
   10. **Evidence in every case:** the command line, the CE log line `CD AutoCalc: ... finalSecond=` for the "I know one end" ON cases, and the pipe's downstream level read back from the drawing.

### 6. Verdict

1. **RE-CHECK OK WITH NOTE. Safe for the C-78 addendum.** Both holes are closed by a stateless check at Draw, which also closes the re-pick and no-pit gaps from the pre-review. "I know one end" ON is handled correctly. OFF gives exactly today's behaviour. No drawing writes, nothing in CE_SHARED. The only new merge clash is the `REGRESSION_LOG.md` top.
2. **Notes (none blocking):**
   1. Bring the `UserSettings.cs` summary (lines 1452-1458) up to date.
   2. Add the two percentage tests with the switch ON (section 3, item 2).
   3. Run N33a to N33h and N33s.
   4. The label-grade question (typed versus real) stays open for Tim via CE 04.
