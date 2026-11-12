# Review: PR 2082 `claude/trust04-b1316-cdwt-window-tank` (BUG-1316, CDWT by its window keeps the library tank's details)

**Reviewer:** lane trust-review (fourteenth run). **Written:** 2026-11-13 07:23 PC clock. **Head reviewed:** `d2bf2395` (one commit on `cf059dcf`, the installed Civil 3.0.90, confirmed as its parent). Read only: no build, no test run, no AutoCAD.

---

# FOR TIM

1. **The fix itself is right:** a tank chosen from the list in the CDWT window now carries its make, size and lid into CE's record, exactly as a tank chosen at the command line always did; a size typed by hand still carries none.
2. **It quietly changes a number you rely on:** from now on a tank placed through the window from the office list, with a base level typed, is counted in the detention storage (top water level, orifice level, baffle wall), where today it is left out with "no rated capacity or no height recorded". That is how the command-line route already works and what item 66 intended, but it is your figure, and the pull request does not say so.
3. **The AutoCAD check it hands the robot is wrong:** the make and size line on the callout only appears with the Settings switch "add make and size to the tank callout" ON (it starts OFF), CDEDIT does not show make or size at all, and the lid shows nowhere. As written, the robot would report a failure on a working fix.

**Verdict: FIX FIRST** (words only, no code: list the detention effect for you, and correct the robot steps). Then GO for the robot on copies.

---

# Findings (file and line at `d2bf2395` unless stated)

1. **Correct, by reading.**
   1. `Dialogs/WaterTankDialog.xaml.cs:80` `ChosenLibraryTank => _viewModel.SelectedTank?.Entry`. `TotalLitres` (line 342) comes from the same `_selectedTank` when it is set, so the tank handed back can never have litres different from the ones used. Typing clears the choice (`TypedLitres` setter, line 328); choosing clears the typed text (line 278 and `OnViewModelChanged`, line 58). Above/underground switch rebuilds the list (line 438); the bound list then drops the old row, and `TotalLitres` and `ChosenLibraryTank` drop together.
   2. `Commands/WaterTankCommand.cs:93-94` and `:595`: the window route now fills `libraryChoice`; it reaches `BuildAndApply` (line 158) and the plan, the callout (`WaterTankCommand.Plan.cs:170-177`) and the record (`WaterTankCommand.Apply.cs:316`, `BuildTankFacts` 341-357), the same path the command-line route uses (line 131).
   3. Tagging an existing block (line 166): the window's tank comes along only when the window gave litres; otherwise the command-line question decides, as before.
   4. One U, Esc, locked layers, Xrefs, REFEDIT: untouched (no change to the transaction, prompts or checks). No new words on screen.
2. **Engineering figure changed, not listed (the reason for FIX FIRST).** `Rules/WaterTankFacts.cs:100-104` (installed): a tank record with no height is left out of the detention storage and named. With this change a window-placed library tank records `HeightMm`, `LengthMm`, `WidthMm` (`Apply.cs:351-355`), so `DetentionTwlService.cs:201` (`FindAllInBranch`) now counts it: orifice level, tank top level and its share of storage, which move the top water level and the baffle wall height. Tanks already placed keep their old record (no change until placed again). This is the designed behaviour (item 66, F2.3, and the command-line route already does it), so the DRAFT default is "count it", but the PR title, body and REGRESSION_LOG entry must say it is Tim's to confirm.
3. **Robot steps wrong (PR body item 5, REGRESSION_LOG item 4).**
   1. Callout make and size: `TankCalloutMakeSizeRule.cs:18` returns nothing unless `TankCalloutSettings.AddMakeAndSize` is true; its default is false (`Models/TankCalloutSettings.cs:13`). With today's settings the callout is identical before and after this change. The step must turn the switch ON on the copy first (and put it back), or check the record instead.
   2. "CDEDIT shows them": no window in the installed code displays a tank's make, library name, size or lid (search of all non-test `.cs` and `.xaml` for `Brand`, `LibraryName`, `TrafficableLid`, `.Tank`: only the record builder and the detention rule use them). The robot must read the stored record (`CE_CVL_SUITE_PROJECT`, `PROJECT_DATA`, the tank's `tank` block) or run the detention check (CDTWL) on a branch with a base level, before and after.
   3. "and lid": the bug's own step says "make, size and lid shown"; the lid is recorded (`trafficableLid`) but shown nowhere (`WaterTankFacts.Note`, which would print "TRAFFICABLE LID", has no caller). Say so in the step; showing it is a separate item if Tim wants it.
4. **Tests.** `Trust04B1316WindowTankTests.ATankChosenFromTheList_...` drives the real window and view model (good; no Settings write is reached because the test window has no plan blocks, so `RememberThisPairing` never runs). `Cdwt_CarriesTheWindowsTank_IntoPlacement` is a text search of the command file, so a wiring that compiles the same words but passes them nowhere would pass. Acceptable with a robot case; worth knowing.
5. **No PENDING_TESTS row** for 2082 yet (the TRUST-04 section ends at row 24 for older items). Add one with the corrected steps: switch ON for the callout half; stored record for make, size and lid; CDTWL on a detained branch with a base level, before and after, for the figure change.
6. **Merge note for the controller:** 2055 and 2057 also change `WaterTankCommand.cs` (Civil mark after placing; Esc at the callout, riser and dropper questions). Expect a text conflict; no behaviour clash seen.

# What I did not check

1. No build or test run; the lane's figures (253 of 253, broken twin 1 of 2 failing) not re-run.
2. The real window in AutoCAD (list behaviour when switching above/underground was read, not seen).
3. Whether CDTWL's figures with a window-placed tank are right in themselves (same code path as command-line tanks, not re-derived).
