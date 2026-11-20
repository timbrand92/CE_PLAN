# Verdict: team/exact-rounding at 9d4d69e (one shared rounding routine)

**Verdict: HOLD. Both halves hold it. Eight blockers: each is a figure that prints wrong, or a check that passes or fails on a rounded figure, on a branch whose whole claim is that this can no longer happen. First verdict on this branch: fix round one of two follows.** Written Fri 20 Nov 2026, about 8:45 pm. Checked on the bench only.

**Who checked (both finished).** Compile gate by the check room: the whole solution builds, the AutoCAD plug-in project included. Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\rnd_honest_REPORT.md` (HOLD, two blockers; went through every rounding place in `src` and `bench`). Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\rnd_adv_REPORT.md`, proofs in `rnd_adv_proofs\` (nine reproduced on the pretend drawing through the Pit, Pipe and Run tools). Graded here: where the two overlap they agree.

## 1. Counts seen

Eleven projects build, no warnings, no errors; the whole suite passes (the builder's counts match). 33 files changed against main at 6d27628. The changed older test is RIGHT: `BendTests` now expects 6.115 (the first straight is the long side of 4775 by 3820 mm, 6.115 to a tenth of a millimetre, printing 6.12): both halves agree it follows D-341. The night check data still says 6.11 (`src/CeCivil.Acad/night/bend_night.csv:28`): bring it into line in the same round.

## 2. Blockers

1. **A worked invert is still checked at its printed two places** (D-350 built the opposite way). `src/CeCivil.Brain/data/printed_figures.csv` lists the four inverts and `Fact.cs:54` hands the rounded figure to every "exact" sum and check. A 297 mm cover passes "Suits" with the tolerance at 0; a 300.4 mm cover is refused as 3 mm short; a 297 mm cover is refused with the tolerance at 5 mm. The branch's own older test `SweepTwoTests` M2 still asserts the withdrawn behaviour and passes. Take the four inverts out of that list; M2 expects "3 mm short" (D-350 is the ruling that changes it). Found by both halves.
2. **The fact and the routine print different figures for one value.** `Fact.cs:246` rounds a worked figure straight to its step; the routine takes it to a tenth of a millimetre first (D-341 item 1). A worked invert of 5.00495 shows 5.00 in the window and on the plan where the routine, and the branch's own test, say 5.01. One rule, and a test that goes through a worked fact.
3. **The fall is rounded before the worked grade is printed.** A 20.000 m pipe from 10.000 to 9.901 is 1 in 202; the label reads "1 IN 200" (the label divides by the displayed 0.10 fall: `sums.csv:10`, `PipeToolWindow.cs:117`). A 0.123 m pipe falling 0.001 loses its grade altogether (D-406 item 2).
4. **Rounding builds up down a run.** Ten 1.000 m pipes at 1 in 30 from 10.005 with a 0.020 drop across each pit: the one-step sum is 9.49; the solver returns 9.53 and calls it exact; the first arrival already reads 9.98 for 9.97. A four-pipe run drew "Arrives IL 9.83" where the sum gives 9.81 (`Fact.cs:246`, `RunModel.cs:85`, `RunPreview.cs:282`). D-350, D-383 items 8 and 9, D-393 item 3.
5. **A saved cover level of 1,000 m or more is lost on an ordinary edit.** 1000.005 is written into the pit's note as "1,000.005"; reopening shows "Not known"; pressing OK with nothing changed removes the cover from the pit (`ToolWindow.cs:56, 143`). D-421 names exactly this case. (Drawing content lost.)
6. **The Pit preview and the drawing print different cover levels.** At 5.755 the preview shows "CL 5.76"; the drawing gets "CL 5.755" and the schedule's cover cell 5.755 (`PreviewPane.cs:234`, `PitTool.cs:341`, `ScheduleModel.cs:503`). D-421 item 2: two places, half up, wherever printed; three places never on the plan.
7. **A 3 mm disagreement between a worked and a typed level is not found with the tolerance at 0;** a 7 mm one is reported as a 0.01 break between two rounded figures. The clash test and the long-section break both start from rounded ends (`Solver.cs:159`, `RunModel.cs:243`, `WindowModel.cs:1998`), though the hand-over says breaks are decided on exact figures.
8. **A new fault this branch brings in:** a measured length a hair under the half (1.0049499996 m falling 0.010) is first rounded to nine places, which lifts it onto the half, then kept as 1.0050: the label reads "1 IN 101" where main, and D-341, give 100 (`Rounding.cs:30`, `PipeTool.cs:221`).

## 3. To fix in the same round

1. **The shortfall words lose their millimetres:** with 288 mm of cover the check rightly says Wrong but reads "Short by 0.01 ... cover 0.29, needs 0.30"; D-406 item 7 and D-426 item 1: "Short by 12 mm ... cover 288 mm, needs 300 mm." (`checks.csv:37, 42`). The words are the cover job's; the figures handed to them must be exact.
2. **The source test cannot keep "round only at print":** it catches a plain Math.Round and misses decimal.Round, an integer cast after scaling, the approved routine called inside a sum, and format-then-parse; it skips every data file (where blocker 1 lives) and the whole `acad` folder. Say plainly what it guards; the behaviour tests carry the rest.
3. **The worked grade box** shows 200 and "1 in 200, flatter than 1 in 200" where D-424 (DRAFT) wants 200.04 in the box; a typed 66.7 shows as 66.70 and a typed 83.0 prints 83 (D-154, D-424).
4. **Not named in the hand-over:** the job window's slab figure changed from round-half-to-even to half up (112.5 now shows 113): right under the half-up rule, but say it.
5. **Two points within 0.1 mm are kept as two bends** (5000.00 and 5000.05 on one line; `PipeTool.cs:317` tests to a millionth). D-341 item 2 treats them as one point. Not rounding as such: fix here or name the job that owns it.

## 4. For the control room (no ruling found)

1. **A typed 12.6:** keep "12.6" in the window's box and print 12.60 on every sheet figure (recommended; settles D-154 against D-421 item 2); a typed 12.605 today reaches the sheet at three places.
2. **A real long-section break smaller than 5 mm** prints "out by 0.00": show millimetres when it is beyond the job tolerance, and a within-tolerance state when it is not (recommended)?
3. **A worked grade steeper than 1 in 1** (0.20 m fall over 0.08 m: 1 in 0.4) shows "Not known" and no grade on the label: allow "1 IN 0.4" as the one exception to the whole number (recommended)?

## 5. What held up

Every rounding place in `src` and `bench` was gone through: routed through the one routine, or rightly left (pixels, areas, timing, codes); half up holds for positive and negative levels; the worked grades 94.5, 94.6, 95.4, 199.96 and 200.04 print 95, 95, 95, 200, 200; a flat pipe does not divide by zero; nothing older broke.

## 6. Owed in AutoCAD

The real cover text, grade and invert texts on a test copy against the window and the plotted sheet (5.755 for the pit; 20.000 m falling 0.099 for the pipe); the bend at 6.115 working and 6.12 printed; a retyped invert label setting the level. Nothing is run on Tim's PC under D-420.

## 7. A note on the two branches waiting for this one

A6 and the Pit window are to merge this branch and route through it. Until blockers 1, 2 and 4 are closed they would inherit them; the Pit window's own blocker "5.755 less 5.18 printed 0.58" is this page's blocker 6 from the other side.

## 8. Ruled since (control room, 8:40 pm, D-432)

1. **A typed "12.6" stays "12.6" in the window's box and prints "12.60" on every sheet figure.**
2. **The long section is not Stage 1:** the small-break wording is noted, not built now.
3. **DRAFT:** a worked grade steeper than 1 in 1 prints "1 IN 0.4", with one decimal, as the one exception; never "Not known".
4. **Order:** neither A6 nor the Pit window takes the rounding routine in until it has the check room's MERGE; they wait on it for their own rounding blockers.


---

# Second verdict: team/exact-rounding at 4331b19 (fix round one)

**Verdict: HOLD, on six blockers; fix round two (the last) follows.** Written Sat 21 Nov 2026, about 12:27 am. Checked on the bench only.

**Who checked, and how they split.** Honest: one Claude helper on Sonnet (D-434): `C:\CE_WORK\check\reports\rnd2_honest_REPORT.md`: MERGE (it replayed the earlier cases and ran no new probes of its own). Adversarial: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\rnd2_adv_REPORT.md`, proofs in `rnd2_adv_proofs\`: HOLD; all 90 earlier probe records replayed, then new routes tried. The eight original blockers: four CLOSED (worked inverts checked exact; the fact and the routine agree; no fall rounded before the grade; the 3 mm clash found), four only PARTLY, because the same fault survives on another route (the Run window, the schedule, the lid wording). Each blocker below is a wrong figure on a sheet or a figure lost from the drawing, reproduced on the pretend drawing.

## 9. Blockers

1. **The Run window rounds before it subtracts:** from 10.005, one 1 m pipe at 1 in 30 falls 0.0333; the "Falls and drops" row reads 0.04, and four pipes with three 0.020 drops read 0.20 where the sum is 0.1933 (the preview rightly says "Arrives IL 9.81"). D-393 item 3, D-395.
2. **The lid wording drops the step irons the depth check asks for:** cover 6.0049 over outlet 5.0000 is 1.0049 deep; the Pit check asks for step irons, but the Pit's lid description and the schedule's printed lid remark both leave out "With Step Irons" (at 1.005 both include it): two callers decide the same thing differently.
3. **A Run OK makes a high cover unreadable on its next open:** a cover of 1000.005 placed through Pit reads correctly in Run; OK with nothing changed writes "1,000.005" and the next open shows the ground level unknown (D-421).
4. **An unchanged Run edit rewrites a typed grade label:** Pipe writes "1 IN 83.0"; open the pipe in Run and press OK: the drawing reads "1 IN 83" while the saved grade stays 83.0 (D-154, D-424).
5. **The boundary case of the first verdict survives on one route:** a measured length of 1.004949999999996 m falling 0.010 is 1 in 100.49, printed "1 IN 100"; the Pipe tool still drew "1 IN 101" (D-341, D-380).
6. **Typing the same cover back into the schedule changes a printed depth:** cover 5.755 over outlet 5.184 prints 0.57 (0.571); retype the identical 5.755 in the schedule: it stores 5.76 and prints 0.58.

## 10. To fix in the same round

The shortfall sentence at zero tolerance can read "Short by 0 mm ... cover 300 mm, needs 300 mm" for a real 0.47 mm shortfall (and "Short by 1 mm" at 299.5): see question 1; the bend's night check compares the fixture's raw 6.11498 with the two-place 6.12 (`BendChecks.cs:191`): compare at the same precision; the source test catches three of six seeded early roundings (a scaled integer cast, the shared printer used inside a sum, and a held format then parse escape it): say plainly what it guards; the cover sum still subtracts the nominal size alone (302 mm where D-426 item 2's draft gives 297): this belongs to the cover job, mark it.

## 11. For the control room (no ruling found)

1. **A sub-millimetre shortfall:** "Short by less than 1 mm" when rounding a real failure would print zero, with the cover figures to enough places to show it (recommended)?
2. **A worked grade steeper than 1 in 0.05:** one more decimal where D-432's single place would print "1 IN 0.0" and lose the grade (0.049 prints "1 IN 0.05"), recommended; at 0.94 the label reads "1 IN 0.9" while the flatness message says "1 in 1": say which.

## 12. Order (D-432)

A6 and the Pit window still may not take the routine in; the Pit window's own depth sum (D-436) waits on this branch's MERGE for its printed figures.

## 13. Ruled since (control room, about 12:31 am)

1. **DRAFT:** "Short by less than 1 mm" (reachable only when the tolerance is under 1 mm); never "Short by 0 mm".
2. **DRAFT:** a worked grade steeper than 1 in 1 prints with as many decimals as show two significant figures ("1 IN 0.4", "1 IN 0.05"); never "1 IN 0.0".
3. **For the LAST round:** the same fault surviving in the Run window, the schedule and the lid wording means the root is not single yet. The round must end with a source test that NO code outside the one routine rounds or formats a level, depth, fall, grade or shortfall, listing every caller. If it is held again it goes to a design page (D-346), and A6 and the Pit window stay waiting.
