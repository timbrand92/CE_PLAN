# B-034 BUG-1097: the 300 mm minimum head now uses the head left after pipe losses (Fri 30 Oct 2026, 01:20 Melbourne)

## FOR TIM

1. **Draft PR #1859** (B-034, BUG-1097), branch `fb/bug1097-head-after-losses`, against `claude/rel-20261026z`. It follows your ruling "the head left after losses, because that's the real head at that point". PR #1772 is untouched and still open.
2. **What you will see in CDCALC, Charged System tab:** the yellow warning now compares the 300 mm with the head you type MINUS the pipe losses. It names both figures so you can check it.
3. **Worked example (the tab's starting figures: 100 m2 roof, C 0.9, 150 mm pipe 48.5 m, K 2.95, 100 mm downpipe).** Pipe losses come to 216.5 mm (143.8 mm friction + 72.7 mm fittings).
   1. Type Available head 0.50 m. Before: no warning (500 mm is over 300). Now: "Head left after pipe losses 283.5 mm (available head 500 mm less 216.5 mm of losses) is under the 300 mm minimum for a charged system (R-13)."
   2. Type 0.60 m. Before and now: no warning (383.5 mm left).
   3. Type 0.25 m. Before: "Available head 250 mm is under the 300 mm minimum". Now: "Head left after pipe losses 33.5 mm (available head 250 mm less 216.5 mm...)".
4. **If the losses cannot be worked out** (for example you clear the pipe diameter) it says "Head left after pipe losses is Unknown (an input is missing), so the typed head N mm was compared with the 300 mm minimum" and compares the typed head. Never a quiet zero.
5. **Still only a warning.** It never blocks. The 300 mm still comes from Settings (Design standards, charged minimum head), nothing hard-coded.
6. **What does NOT change:** CDRULES (it only prints "R-13 charged minimum head: 300 mm"), CDDESIGN and CDCHECK show no head check today, and nothing on the drawing changes. The check lives only in the Charged System tab.
7. **Switch:** `detention.chargedMinHeadUsesHeadAfterLosses`, ON by default. OFF gives exactly the old typed-head check. It is not on the Settings page (the #1772 switch is not either). Set it in the settings file before AutoCAD starts.
8. **Nothing for you to decide.** Please do not install on this alone; it is a draft and needs the robot case below.

---

## Mistakes of my own (first)

1. **Lost about four hours waiting for a build slot.** Two other sessions' test runs kept the single build slot busy from 20:10 to 00:41. Nothing was spoiled; just slow. I also left two copies of my own waiting script running for a while; I stopped the extra one by its own pid.
2. **My first worked example was wrong.** I estimated 16 mm of losses by hand; the tab computes 216.5 mm. The first test run caught it (3 failed), and the examples and tests above now use the real figures.
3. A hand-typed wait script ran my first test step after the 3-hour limit would have passed; I fixed it to refuse to build without a free slot before the second try.

## What is NOT proven

1. **Not driven in AutoCAD.** Only unit tests. Whether the warning wording fits the tab's warning box without clipping is unseen.
2. **Settings page:** no tick box exists for either BUG-1097 switch; a drafter cannot turn it off without editing the settings file.
3. **Pit cover/clearance:** QUESTIONS item 20b described the check "at a pit"; the code has no such use of the 300 mm. The only check is the Charged System tab, which is what I changed. If Tim meant a pit check, that is a separate piece of work.
4. The new default-pin is in my own test fixture (both start-up reads); the next train finalizer should add it to its defaults test.

## Robot case that proves it (proposed): N31_charged_head (switch-off control C31_charged_head_off)

1. **N31_charged_head:** start AutoCAD with the settings file untouched (switch ON by default). Type `CDCALC`, open the Charged System tab, set Available head to `0.5` (leave the other fields at their starting figures). Read the warning list. PASS when it contains the line starting "Head left after pipe losses 283.5 mm (available head 500 mm less 216.5 mm of losses)". Then type `0.6`: PASS when no line containing "(R-13)" is shown.
2. **C31_charged_head_off (control):** before launch set `detention.chargedMinHeadUsesHeadAfterLosses` to false (the guard is read at AutoCAD start). Same steps with `0.5`: PASS when there is NO line containing "(R-13)"; with `0.25` the line reads "Available head 250 mm is under the 300 mm minimum for a charged system (R-13)."
3. If the robot cannot read the tab's warning box, a Codex look is needed for the wording; the figures themselves are proven by the unit tests.

## Technical detail

1. **Cause / entry point (confirmed on origin/claude/rel-20261026z, Civil 3.0.85):** the check from #1772 is `ChargedSystemCalcViewModel.MinimumHeadWarning` (`Modules/Drainage/ViewModels/ChargedSystemCalcViewModel.cs`, about lines 231 and 243), called from `Recalculate()` with the typed head only. The loss total (`total`, friction plus fittings) was already worked out in the same method for Qmax. The 24 Oct entry's lines moved: `UserSettings.cs:1980` is now about 2303 (`ChargedMinHeadMm`) and 2548 (`ChargedMinHeadWarning`); `RulebookValues.cs:245` is now 86 and 262; `RulebookEngine.cs:44` unchanged; `RulesCommand.cs:252` prints the value.
2. **Change:** `MinimumHeadWarning` takes the loss (null = Unknown) and the switch. ON: left = typed head less total loss, compared with the Settings minimum; null loss gives the Unknown note and the typed head. OFF: the #1772 code path and wording exactly.
3. **Files:** `Modules/Drainage/Models/UserSettings.cs` (`DetentionSettings.ChargedMinHeadUsesHeadAfterLosses`, JSON `chargedMinHeadUsesHeadAfterLosses`, "Default: on."), `Modules/Drainage/ViewModels/ChargedSystemCalcViewModel.cs`, `Modules/Drainage.Tests/ViewModels/Bug1097ChargedMinimumHeadTests.cs` (old typed-head tests now turn the new switch off; new fixture `Bug1097HeadAfterLossesTests`, 21 tests in the file), `REGRESSION_LOG.md`. CE_SHARED not touched.
4. **Results:** focused 21 of 21 pass; full Civil net10 suite 0 failed, 20788 passed, 32 skipped (one run, the PDF page tests skipped as usual); net48 compile 0 errors. All Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, below-normal priority, one build at a time. Never deployed.
5. **Switch tests:** default ON through `DeserializeSettings` and `DeserializeSettingsTolerant` for `{}` and a #1772-shaped file; typed false is kept by both and turns off only itself; OFF gives the old answer over a grid of heads; the office minimum from Settings is used (200 and 1000 mm cases); losses larger than the head give a negative left figure and still warn only.
6. **Housekeeping:** worktree `C:\ce-fx\c78g` (an untracked 0-byte placeholder arx under `Modules/Shared.Transform.Native2027/bin` was needed to build); bin/obj cleaned at the end with `git clean -fdXq` inside it.
7. BUG-1097 stays OPEN. Nothing closed, retargeted or merged.
