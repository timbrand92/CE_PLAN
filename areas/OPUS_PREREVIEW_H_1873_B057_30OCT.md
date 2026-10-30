# Opus pre-review H: PR #1873 (B-057), Grade mismatch window skips the New Pipe window's own suggested level

Reviewer: Max Opus, read-only, Fri 30 Oct 2026 (Melbourne). Brief: `C:\CE_PLAN\desk_jobs\REVIEW_BRIEF_1873_B057.txt`.
Reviewed: branch `fb/b057-mismatch-box-own-suggestion` at `75e3baab` (one commit on `claude/rel-20261030a` at `f5dd72a0`, Civil 3.0.87 / C-77). Fetched read-only. Nothing built, nothing run, no AutoCAD opened. Line numbers below are at `75e3baab`.

## FOR TIM

1. **Verdict: KEEP-WITH-NOTE, but fix two small holes before it goes into the C-78 addendum.** The main fix is right: a 4.1 m pipe at "Set my own" 1 in 100, where CE worked out the second level (19.40), no longer throws the "Grade mismatch" window. Built and unit-tested by the author only. Nobody has opened it in AutoCAD.
2. **Hole 1, grade changed afterwards:** with "I know one end" OFF, type the upstream level 19.45 on a 4.1 m pipe at 1 in 100 (CE fills 19.40), then change the grade box to 200 and Draw. Today the window asks (the pipe is really 1 in 82). With this PR there is no window and the label reads 1 IN 200 on a pipe that falls at 1 in 82.
3. **Hole 2, a level you typed gets treated as CE's:** with "I know one end" OFF, type 19.45, then type your own downstream level 19.30 (1 in 27), then change the upstream to 19.50. CE carries your 0.15 m fall across (19.35), then counts that as its own suggestion. No window, and the label says 1 IN 100 on a 1 in 27 pipe.
4. **The fix for both is small:** at Draw, skip the window only when the second level equals what CE's rule gives from the current upstream level, length and grade, instead of "the box still shows what CE last wrote". Add two tests: hole 1 and hole 2 must still open the window.
5. **The label (still your call, already with CE 04):** when the window is skipped, the label shows the grade you typed (1 IN 100), not the real fall (1 in 82 at 4.1 m, 1 in 83 at 2.5 m). The Pit Schedule shows no note at draw time. A note appears only after someone types a level in the Pit Schedule for that pipe.
6. **Correction to the author's report:** with "I know one end" ON, this window already opened on 4.1 m pipes before C-77. The level CE works out at Draw has always rounded the fall up. C-77 caused it only with "I know one end" OFF. The fix covers both cases. The author's robot control step (type 19.37 by hand) must be run with "I know one end" OFF, because with it ON that box is locked and CE recalculates the level at Draw.

---

## DETAIL

### 1. Does the code do exactly what the brief says?

1. **The skip itself (correct as written).** `Modules/Drainage/Commands/CdCommand.Grade.cs` lines 255-259 return "no window" when `MismatchBoxOwnSuggestionRule.SkipsQuestion(...)` is true. That needs three things (`Modules/Drainage/Rules/MismatchBoxOwnSuggestionRule.cs` lines 23-28): the switch is on, the "own suggestion" flag is true, and the real run per metre of fall is no more than the typed one (as steep or steeper). A flatter pipe always goes on to the unchanged 10 per cent test (lines 263-267). This matches the brief: no window for CE's own rounded level when the grade is as steep or steeper, and the 10 per cent test for anything else.
2. **Where the flag comes from.** `CdCommand.cs` line 588 passes `vm.DownstreamBoxStillHoldsSuggestedLevel()`. `CdViewModel.Inverts.cs` lines 878-880 make that true when the second box's text exactly equals `_secondInvertCalculatedText`. That field is declared at line 79 and **set in one place only**, line 819, inside `TryApplyUpstreamDownstreamSuggestion` (lines 770-837). It runs whenever the first level changes in a new pipe with a known length. It is **never cleared**. "Stale" therefore means "the box still shows the text CE last wrote", whatever has changed since.
3. **The ways the flag can go stale, one at a time:**
   1. **The first level is edited afterwards:** the suggestion runs again (setter lines 700-716) and rewrites the second level and the flag together, so they stay in step. This is fine on its own. But see item 5 (a held fall).
   2. **The second level is edited:** any different text makes the flag false, so the 10 per cent test applies (correct). Text identical to CE's (for example, clearing the box and retyping "19.40") counts as CE's own. That is physically the same level, so it is harmless on its own. The author documents this.
   3. **A Recent level button (#1839):** `CdViewModel.Commands.cs` lines 171-188 write the FIRST level (or the known level when "I know one end" is on), which re-runs the suggestion. The second level and the flag stay in step. Fine.
   4. **The grade is changed after the levels (HOLE 1):** the `CustomGrade` setter (`CdViewModel.Grade.cs` lines 174-210) only refreshes the preview. It does not re-run the suggestion. The second box keeps the level worked out at the old grade, and the flag stays true. With "I know one end" OFF the Draw uses the box level as it is (`CdCommand.cs` lines 458-469; lines 492-556 run only when that option is ON). Worked example: 4.1 m, 19.45 to 19.40 suggested at 1 in 100, grade then changed to 200. The real grade is 1 in 82, so 82 is no more than 200 and the rule skips the window. Before the PR, 59 per cent off opened it. The label is the Custom grade verbatim, "1 IN 200" (`CdCommand.Grade.cs` lines 196-202). With "I know one end" ON this hole does not occur, because the Draw works the level out again from the current grade (`CdCommand.cs` lines 492-556).
   5. **A held fall turns a typed fall into "own suggestion" (HOLE 2):** after the drafter types a second level, `_secondInvertUserSet` goes true (line 731). On the next first-level edit, `ResolveHasEstablishedFall` returns true (lines 858-864), and `UpstreamDownstreamSuggest.SuggestDownstream` keeps the drafter's fall (`Helpers/UpstreamDownstreamSuggest.cs` lines 64-65 and 102-110). The suggestion writes that level and stamps it as CE's own (line 819). Because "Set my own" is chosen, the grade box is left as typed (lines 823-830, `keepsChosenGrade`). Worked example ("I know one end" OFF): 4.1 m at 1 in 100. Type 19.45 (CE gives 19.40), type 19.30 yourself, then retype the upstream as 19.50. CE writes 19.35 (0.15 m fall, 1 in 27) and the flag is true. Draw: no window, label "1 IN 100". Before the PR: window (73 per cent off). **The window is wrongly skipped for a fall the drafter typed.**
   6. **The grade mode is changed:** with Standard or Minimum, the check does not run at all (`IsCustomGradeEffective`, `CdCommand.Grade.cs` lines 66-77). When the suggestion runs on Standard, it switches the pipe to "Set my own" with the table figure (lines 823-830), so the check then runs and the skip applies. That is the intended win.
   7. **Edit Pipe:** the only caller of `TryDetectCustomGradeMismatch` is `CdCommand.cs` line 586. Edit Pipe never shows this window, and in edit mode the suggestion never runs (line 772), so the flag stays false there. No effect.
   8. **Undo:** the flag lives only inside the open window. Nothing is saved to the drawing or the pipe record. No effect.
   9. **Reopen the window:** each CD command makes a new window model (`CdCommand.cs` lines 93 and 121-124), so the flag starts empty. Within one command's loop the same model is reused, so the flag and the box move together. **Not verified:** whether a re-pick inside that loop changes the length without re-running the suggestion. If it does, a shorter re-pick would be a third stale route of the same kind as hole 1.
4. **Gaps where the window still fires on CE's own level (safe side, but partial):**
   1. **No pit at either end:** the suggestion runs only when the length is known. Draw-first sets the length only when an end resolves to a pit (`CdCommand.GradeSuggestion.cs` lines 119-131). With neither end on a pit, the flag stays false. With "I know one end" ON, the Draw still works out 19.40 and the window still opens. I have not run this. I read it from the code.
   2. **The suggestion strip's "Use" button:** this writes the second level through the ordinary setter (`CdViewModel.GradeSuggestion.cs` lines 458-463), so it counts as typed unless the text happens to match.
5. **"I know one end" ON uses a different level from the box.** At Draw, `CdCommand.cs` lines 492-556 recalculate the second level with `MathHelper.ApplyCalculatedInvertRule`, which rounds the fall UP (`Helpers/MathHelper.cs` lines 312-323, unchanged since well before C-77; #1838 did not touch `CdCommand.cs`, `MathHelper.cs` or `RulebookCalculations.cs`). The flag still comes from the box. For 4.1 m, 6.1 m and 2.5 m the two numbers are the same. Below the 20 mm minimum drop they differ (0.5 m at 1 in 100: box 19.44, Draw 19.43). Both are steeper than the grade, so the skip is still CE's own arithmetic. **This also means:** with "I know one end" ON, the 4.1 m window opened before C-77 too. The author's and the brief's "since C-77" is right only with "I know one end" OFF.
6. **No upper limit on "steeper".** A 1.0 m pipe at 1 in 200 with "I know one end" ON gets the 20 mm minimum drop: 1 in 50, four times steeper than the label, with no window. That is CE's own rule and is by design. It belongs in the CE 04 label question.
7. **Label and Pit Schedule today, for "typed 1 in 100, real 1 in 83" (2.5 m, 19.45 to 19.42):**
   1. **Label:** "1 IN 100", the Custom grade verbatim (`CdCommand.Grade.cs` lines 196-202). This is the same rule as answering "keep typed grade" in the old window.
   2. **Pit Schedule note:** nothing at draw time. The note is worked out only after a level is typed in the Pit Schedule for that pipe (`ViewModels/PitScheduleViewModel.Data.cs` lines 1938-1954). It would then read "LABEL GRADE 1 IN 100, LEVELS GIVE ABOUT 1 IN 83" (`Services/PitScheduleGradeNote.cs` lines 31-38 and 76-103; 20 per cent off is over the 10 per cent tolerance).
   3. **Grade lock (not proven, worth knowing):** a pipe held at "1 IN 100" whose length later changes is re-worked at 1 in 100 by `LinkService.ApplyGradeLockToInverts` (`Services/LinkService.Utilities.cs` lines 2064-2085). So a skipped 1 in 82 pipe can have its far level moved after a pit nudge. This already happens after "keep typed grade". The PR makes it more common. I did not trace the rounding of that path.

### 2. The switch

1. **ON by default:** `pipe.mismatchBoxSkipsOwnSuggestion`, `Models/UserSettings.cs` lines 1451-1461 (`= true`). A missing group also reads ON (`MismatchBoxOwnSuggestionRule.cs` line 16).
2. **Documented default:** the summary ends "Default: on.", which is what `NewSettingsKeys_NeedADocumentedDefault` looks for (`Drainage.Tests/Services/C60AuditSourcePinGuardTests.cs` lines 153-173). The author reports the full Civil run at 21,517 total and 0 failed. **I did not run it** (the brief forbids building).
3. **Settings page:** no row. It is absent from `SettingsValueCatalog.cs`, `AdvancedSettingsDialog.xaml` and `AdvancedSettingsViewModel.cs`. That is the same as the other C-77 `pipe.*` switches. The tolerance it works beside (`grade.achievedGradeNoteTolerancePercent`) is on the page. A behaviour switch rather than an engineering value, so I read this as consistent with the Settings-first rule as practised. Flag it only if Tim wants every switch on the page.
4. **What OFF restores:** exactly today's behaviour. With the switch off, `SkipsQuestion` is false and the code continues to the unchanged tolerance test. The only other product change is `DownstreamBoxStillHoldsSuggestedLevel` going from private to internal, which does not change behaviour. Tests: `SwitchOff_GivesTodaysWindows` (test file lines 125-135) and `TheSwitch_TypedFalse_TurnsOffOnlyItself` (lines 194-214).

### 3. Tests (`Drainage.Tests/Commands/B057MismatchBoxOwnSuggestionTests.cs`)

1. **Real numbers:** 4.1 m at 1 in 100 (19.40, 1 in 82), 6.1 m at 1 in 200 (19.41, 1 in 152.5) and 2.5 m at 1 in 100 (19.42, 1 in 83) are at lines 86-99. The 9.2 m quiet case is at lines 137-148. **Missing from the brief's list:** 3.1 m and 4.2 m at 1 in 100, and 4.1 m at 1 in 200. My own arithmetic (not run) for these, as old nearest-step rounding against the C-77 round-down:
   1. **3.1 m at 1 in 100:** old 19.42 (1 in 103, 3 per cent); new 19.41 (1 in 77.5, 22.5 per cent).
   2. **4.2 m at 1 in 100:** old 19.41 (1 in 105, 5 per cent); new 19.40 (1 in 84, 16 per cent).
   3. **4.1 m at 1 in 200:** old 19.43 (1 in 205, 2.5 per cent); new 19.42 (1 in 137, 32 per cent).

   All three would be skipped by the PR. Adding them would cost a line each.
2. **Old and new behaviour both asserted:** yes. Each worked example asserts the window opens with the flag not sent (the unchanged route) and stays shut with the flag. The switch-OFF test asserts today's windows for all three.
3. **A TYPED level of the same value:** **no such test, and the code cannot tell the difference.** `ATypedLevel18PercentOff_StillOpensTheWindow` (lines 101-112) types "19.400", which is different text for the same value. Typing the identical "19.40" counts as CE's own. The author says so, and it is harmless on its own (same level).
4. **Not tested:** hole 1 (grade changed after the suggestion) and hole 2 (held typed fall). The tests also call `TryDetectCustomGradeMismatch` with the box values. They do not go through the Draw's "I know one end" recalculation (`CdCommand.cs` lines 492-556). For these lengths the numbers coincide (checked by hand above).

### 4. Clashes with C-78 (`claude/rel-20261102a` at `91963bd0`) and BUG-1255

Checked with a read-only three-way `git merge-tree` (old form, prints only, writes nothing).

1. **`CdCommand.cs`:** BUG-857 (#1858, `c92db9ad`) rewrites the body of the same `if` (the window gets Cancel/Esc). B-057 changes the condition lines 586-588. **It merges cleanly** and the result combines both. The two fit together: when B-057 skips the window, there is no Cancel to offer.
2. **`UserSettings.cs`:** merges cleanly. C-78 adds `raingardenLabelWithoutNumber`, `pitCopyKeepsOriginalPipeEnds` and `grade.mismatchBoxCloseCancels` in other places.
3. **`CdViewModel*.cs`:** C-78 does not touch them.
4. **`REGRESSION_LOG.md`:** a top-of-file conflict, both entries prepended. Keep both. Trivial.
5. **BUG-1255 (`fb/bug1255-closedxml-autocad-2027` at `9a1f4e64`, same base):** only the same top-of-file `REGRESSION_LOG.md` conflict. Its `UserSettings.cs` changes (`excel`, `useAutoCadLoadedClosedXml`) merge cleanly.
6. **C-78 finalizer's `C78NewSwitchDefaultsTests`:** pins only the three C-78 switches. B-057 brings its own switch test. No clash expected. Not run.

### 5. What is NOT proven, and the AutoCAD scenario

1. **Not proven:**
   1. Nothing was run in AutoCAD. Nobody has seen the window's absence.
   2. I did not build or run tests. The author's 21,517 total / 0 failed and the net48 compile with 0 errors are the author's claims.
   3. The real window route (typing in the one-page window, the box text at Draw) is covered only through the window model.
   4. The two holes above come from reading the code, not from a run.
   5. The no-pit and re-pick gaps are not verified.
   6. The grade-lock re-work after a pit nudge is not traced.
2. **Robot scenario (CE 02), one drawing, settings read at start:**
   1. **N33a ("I know one end" ON):** New Pipe (CD), draw-first between two CE pits 4.1 m apart, 100 mm. "Set my own" 100, "I know one end" ON, upstream 19.45, Draw. **Expected:** no "Grade mismatch" window; label 1 IN 100; downstream level 19.40.
   2. **N33b ("I know one end" OFF, the actual C-77 route):** same pits, "I know one end" OFF, type upstream 19.45, leave the CE-filled 19.40, Draw. **Expected:** no window; 19.40; label 1 IN 100.
   3. **N33c, typed control ("I know one end" OFF):** type upstream 19.45, type the downstream yourself as 19.37 (about 1 in 51), Draw. **Expected:** the window opens. (With "I know one end" ON this box is locked and the Draw recalculates the level, so the author's control must be run with it OFF.)
   4. **N33d, flatter control (OFF):** type the downstream as 19.43 (1 in 205 against 100). **Expected:** the window opens.
   5. **N33e, hole 1 (OFF):** type upstream 19.45 (CE gives 19.40), change the grade box to 200, Draw. **Expected after the fix:** the window opens. **On this PR as it stands:** no window and the label reads 1 IN 200. This case should fail now and pass after the fix.
   6. **N33f, hole 2 (OFF):** type 19.45, type downstream 19.30, retype upstream 19.50 (CE writes 19.35), Draw. **Expected after the fix:** the window opens. **On this PR:** no window.
   7. **Twin N33s:** `pipe.mismatchBoxSkipsOwnSuggestion` false in CD_Settings.json before launching. N33a and N33b then open the window. Close it with "keep typed grade", or with Cancel once BUG-857 is in the payload, because that places no pipe.
3. **Note for N33a's twin:** on 3.0.86 the window would also have opened there, because the "I know one end" fall rounded up before C-77 too. So the twin proves the switch works, not the C-77 cause.

### 6. Verdict

1. **KEEP-WITH-NOTE.** The idea is right and well contained: one rule file, one optional argument, OFF gives exactly today's behaviour, no drawing writes, and nothing touches CE_SHARED. The common short-pipe case is fixed for both "I know one end" ON and OFF.
2. **Note, the fix to make first (small):** replace the "box still shows CE's last text" flag with a check made at Draw time. Skip only when (a) "I know one end" is ON (the Draw has just worked the level out from the current grade), or (b) the second level equals `SuggestedLevelGradeRule.DownstreamAtGradeOrSteeper(first level, current length, typed grade, Calculated decimals)` within 0.0005 m. In both cases the pipe must still be as steep or steeper. This closes holes 1 and 2, needs no flag to go stale, and also covers the no-pit case with "I know one end" ON. Add tests for holes 1 and 2, plus the 3.1 m, 4.2 m (1 in 100) and 4.1 m (1 in 200) cases.
3. **Safe for the C-78 addendum?** **Not as it stands.** It is safe after the small fix above and a green focused run. If the desk must ship it unchanged, ship it with the switch ON. Record holes 1 and 2 in BUG_CARPARK as known limits, because a steeper pipe with a wrong label and no question is a drafting-check (QA) miss, not a flow hazard. The CDCALC and Pit Schedule levels stay correct. Only the label grade is wrong.
4. **Open for Tim (via CE 04, already raised by the author):** when CE worked the level out, should the label show the real grade (1 IN 82) or the typed one (1 IN 100)? Not decided here.
