# Verdict: team/rounding-routine at af7bf24 (the ONE rounding routine, from design\ROUNDING.md 5a77b22)

**Verdict: HOLD (first round). Both halves hold it.** Written Sat 21 Nov 2026, about 6:46 am. Both halves ran on Codex under D-440, each in its own folder, and both left out the known privacy case:
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\rr_honest_REPORT.md`.
- **Adversarial half:** gpt-6.2-astra. Report: `rr_adv_REPORT.md`, with proofs in `rr_adv_proofs\`.

**What is right:**
- **The build:** the whole solution builds on the branch and on main, CeCivil.Acad included.
- **The main-line control:** no test that passes on main fails here. The only raw difference was a speed test, which passes alone on both.
- **The checked figures:** "CL 5.755" draws CL 5.76; the schedule prints 0.26; the earlier replays (the 200.004 and 200.04 grades, the 5.033 mm clash) behave as ruled.

## Blockers

1. **A wrong pipe grade at a measured boundary** (adversarial half).
   - **The case:** a 564.9499999999999 mm pipe with a 10 mm fall must measure 564.9 mm (D-341: a tenth of a millimetre first). That gives 1 in 56.49, labelled **1 IN 56**. The branch measured 565.0 mm and drew **1 IN 57**.
   - **The cause:** the double is converted to metres before the tenth-of-a-millimetre step, at `src/CeCivil.Brain/Facts/Rounding.cs:19`, called from `PipeTool.cs:225`. Rulings: D-341, D-380.
2. **A typed schedule depth replaces the worked one** (both halves). `bench/CeCivil.Bench.Core/windows/schedule.csv:40` gives the worked depth cell a typed holder, and `ScheduleModel.cs:265` and `:566-597` honour it.
   - **What goes wrong:** typing 0.99 printed 0.99 while the pit and the cell's source still worked 0.26. Locking a worked 0.57 and typing 9.875 printed 9.88.
   - **The ruling:** the schedule may work its own depth until Stage 2 (D-440 item 1), but never hold one (D-436, ROUNDING edit 7, design section 6).
   - **The fix:** remove the override route, and test that typing and the padlock both leave the depth following the allowed sum.
3. **A padlock is lost when the job reopens** (adversarial half).
   - **The case:** lock an inlet at 1000.005 m and change its source to 1000.025 m; before OK it prints 1000.01, correctly. Reopen the schedule in the same job and the lock is open, so it prints 1000.03. All eight sign, region and typed-or-measured cases lost the hold.
   - **Files:** `bench/CeCivil.Bench.Core/JobSession.cs:54` and `:115`, `ScheduleModel.cs:447`. Rulings: D-103, D-421, D-432, ROUNDING case 3.
4. **A padlock removes the assumption mark** (adversarial half). An assumed inlet at 4.945 printed APPROX. 4.95. Locked without typing, it printed 4.95, although its source was still assumed. File: `ScheduleModel.cs:596` and `:265`. Rulings: D-177, D-432, ROUNDING edit 6.
5. **The source test can still be dodged** (both halves). Each of these passed it:
   - **A truncated Pit label:** subtracting the decimal remainder just before the printer at `PitTool.cs:354` compiled and drew **CL 5.75** for 5.755. The page names this exact case.
   - **Other conversions:** a level or cover converted to `float` or `Convert.ToDouble`; a depth written as `top - bottom`; the remainder of a renamed integer; a level interpolated straight into a CL label in PowerShell.

   File: `tests/CeCivil.Brain.Tests/RoundingSourceTests.cs:17, 150-261, 333-348`. Rulings: D-439 item 7, ROUNDING cases 6 and 7. **The fix:** the test must follow the quantity to where it ends up, and keep an independent failing seed for each dodge.
6. **The pit-size depth check ignores the job tolerance** (honest half). `src/CeCivil.Brain/data/checks.csv:55-57` compares `depth > max_depth`, and `RoundingDrawingTests.cs:98-110` demands a warning for 0.6004 m against 0.6000 m. That 0.4 mm is inside the 5 mm default, and depths are checked exact against the tolerance (D-432 and the D-380 ruling, ROUNDING section 3). **The fix:** test the same case at 0 mm and at 5 mm.
   - **For the control room:** the office step-iron threshold (D-136) needs its own ruling if it is to stay a strict threshold.

## For the control room: a possible hard-limit breach
The builder's own Part B report (`C:\CE_WORK\scratch\codex_logs\ROUNDING_ROUTINE_PARTB_REPORT.md`, line 16) says its first comparison run opened the terms file in the restricted `C:\CE_DrawingIntelligence` folder. The final run isolated that case. The standing brief says an affected Codex run is thrown away. Neither check here read the file, and nothing from it is quoted in any report.

## Follow-ups
1. **Leftover scratch folder:** the adversarial half could not delete one scratch folder of its own; the automatic approval check blocked the deletion.

**Next:** the builder brings each of the six cases over as a failing test first, then fixes them, in round 1 of 2.

**Ruled since (control room, about 7:10 am):** a pit size's maximum depth is an office THRESHOLD, compared exact (D-441 draft). **Blocker 6 is WITHDRAWN.** Five blockers stand.

---

# Second verdict: d0d35bc (fix round 1 of 2)

**Verdict: HOLD. Both halves hold it. The next round is the last.** Written Sat 21 Nov 2026, about 9:12 am. Both halves ran on Codex under D-441, with the four outside-reading test classes excluded from every run:
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\rr2_honest_REPORT.md`.
- **Adversarial half:** gpt-6.2-astra. Report: `rr2_adv_REPORT.md`, with proofs in `rr2_adv_proofs\`.

The first launch of both halves (and of the settings store checks) died at about 8:07 to 8:24 am: Codex's command runner refused to start processes. Both were relaunched and ran clean.

**The main-line control is clean:**
- **No regressions:** of 4,338 matched tests, no test that passes on main fails here, and all 118 runnable accepted controls pass.
- **The build:** the honest half built the whole solution, CeCivil.Acad included; the adversarial half's build stopped at a missing AutoCAD package, though the other ten projects compiled.

**Closed:**
- the millimetre grade boundary (564.9499999999999 mm gives 1 IN 56; 564.95 mm gives 1 IN 57);
- the typed schedule depth (it can no longer be typed over or locked, and it follows the cover);
- a padlock surviving reopening (eight cases);
- a padlock keeping APPROX.;
- the direct source dodges named in the first verdict (51 of 63 planted changes were caught);
- every earlier replay (the grades at 200.004 and 200.04, the 5.033 mm clash, the 299.53 mm cover).

## Blockers

1. **The same pipe prints two grades in a metres drawing** (adversarial half).
   - **The case:** 0.56495 m in a metres drawing prints 1 in 56, against 1 in 57 for 564.95 mm. And 0.15494999999999998 m prints 1 in 16, where it should be 1 in 15.
   - **The cause:** the picked coordinate is multiplied by 1,000 as a double before the routine sees it, at `src/CeCivil.Hands/Units/DrawingUnits.cs:62`, called from `PipeTool.cs:335`. Rulings: D-217, D-341, D-380.
2. **The pit-size maximum now uses the job tolerance** (both halves). It was ruled the opposite way.
   - **The case:** a 450 by 450 mm pit has a 600 mm maximum. At 5 mm tolerance it now passes at 600.4 mm and at 605.0 mm, where main warns at both.
   - **The cause:** `checks.csv:56`. The test at `RoundingDrawingTests.cs:101` demands the wrong answer.
   - **The ruling:** office thresholds are compared exact, as the control room ruled at 7:10 am and D-441 has it in draft. Both tolerances must warn above 600; equality passes.
3. **The source test still lets a wrong sheet level through** (both halves).
   - **The honest case:** a helper that changes the level through a `ref` argument, with a compound remainder assignment, just before `PitTool.cs:354`, makes 5.755 and 5.7554 both print CL 5.75.
   - **The adversarial case:** keeping the level and its remainder in a tuple and subtracting makes 5.75496 print 5.75. All 400 focused tests passed on that wrong build.
   - **Other escapes:** in all, 12 of 63 planted changes passed, among them a whole data template. Changing an exception's destination or reason to unrelated text still passes too.

   The test at `RoundingSourceTests.cs:166-191` loses the quantity at ref arguments and tuple fields. Rulings: D-439 item 7, ROUNDING cases 6 and 7.

**Next:** the LAST round fixes these three, each with its failing test first. After that comes the D-346 hold. Proofs for the 12 escapes: `rr2_adv_proofs\audit-results.jsonl` and `supplement-audit.jsonl`.
