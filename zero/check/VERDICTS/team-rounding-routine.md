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
