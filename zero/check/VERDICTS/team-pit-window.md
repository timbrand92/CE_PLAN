# Verdict: team/pit-window at 9dbf9d6 (the Pit window with pit levels, from PIT_WINDOW.md 522db21 and PIT_LEVELS.md 7f265eb)

**Verdict: HOLD (first round). Both halves hold it.** Written Sat 21 Nov 2026, about 6:56 pm. Both halves ran on Codex with the D-441 filter, because this branch does not hold 1e1534a:
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\pwb_honest_REPORT.md`.
- **Adversarial half:** gpt-6.2-astra. Report: `pwb_adv_REPORT.md`, with proofs in `pwb_adv_proofs\`.

**The build:** neither half could compile CeCivil.Acad this time; package restore failed, though Brain, Hands and Window built. The build room reports 0 errors. The honest half's full suite comparison and its one-by-one read of the 70 restatements did not finish, so the next round must cover both.

**What holds:**
- The depth answer and all five size captions fit at both approved sizes.
- The fullest laptop state's sums are right.
- The arithmetic the rulings set checks out.

## Blockers

1. **Retyping a level writes to drawings Stage 1 refuses** (honest half).
   - **The case:** in a drawing set to metres, and in one set to centimetres, changing an owned cover from 6.50 to 7.77 m and a pipe invert from 5.12 to 5.25 m updated both saved records.
   - **The cause:** the command-end path (`Commands.cs:229`, `EndOfCommand.cs:71, 122, 128`) wraps the drawing in a millimetre view and then writes at `EndOfCommand.cs:334, 357` with no refusal on the drawing's own units.
   - **The ruling:** D-403 items 2 and 3 say "nothing is drawn and nothing in the drawing is changed, seen or unseen"; PIT_LEVELS section 4 requires the units check before writing.
2. **A worked cover can be held** (adversarial half).
   - **In the schedule:** the padlock treats a worked source as a typed override (`ScheduleModel.cs:597`). A worked 9.875 m, locked, kept printing 9.88 after a measured 10.025 replaced it.
   - **In Run:** a changed 9.875 m cover marked worked out was stored and drawn as CL 9.88 (`RunTool.cs:465`, `PitTool.cs:359`).
   - **How it was reached:** both by feeding figures into the tools directly; an ordinary window was not shown producing them. Ruling: D-436 (no worked cover or depth is held).
3. **The drawing-units notice is cut off at both approved sizes** (adversarial half). With two in and one out, units unset, a refused number, a Renumber notice and both checks active, only 8 of its 16 units show. Five joined and four arriving do the same. The fixed 120-unit card is at `StdSteps.cs:74, 872`. Rulings: D-346, D-386, PIT_WINDOW sections 1.3 to 1.5.
4. **The preview promises two different printed figures** (adversarial half). For a cover of 5.754 and a depth of 0.508, the sheet preview shows 5.75 and 0.51. But the change list promises "5.754", and Step 3 calls 0.508 the printed depth; at a typed 5.755 it fails the branch's own printed 5.76 check. Files: `pit.csv:82-83`, `WindowModel.cs:634`, `StdSteps.cs:1271`. Rulings: D-432, PIT_LEVELS section 5.
5. **Renumber understates its count and compares too little** (both halves). Picking P7 on P7 to P9 while a separate edit changes P8 to P3 saves three number changes, but the preview says two. The count is taken before the separate edit is added (`PitTool.cs:1226-1235`). The OK comparison (`PitTool.cs:25`, `PitCommand.cs:122`) covers number assignments only, without owned labels or other edits. Rulings: PIT_WINDOW sections 2.1 and 2.2.
6. **The source gates accept the required wrong builds** (both halves).
   - **One number reader:** a second `long.TryParse` in the tag writer (`PitTool.cs:219`), and a planted reader in the destination scan (`PitTool.cs:181`), both pass `PitNumberSourceTests.cs:48`. A compiled wrong build produced two identical pit tags.
   - **The rounding binding probes:** a forwarded or nested ref write, a struct field, an indexed element and a captured decimal just before the printer at `PitTool.cs:635` all pass `RoundingSourceTests.cs:184, 248-272`, so CL 5.755 can print 5.75.

   Rulings: D-439 item 7, PIT_WINDOW section 3.4, and the rounding routine's MERGE ruling.
7. **A restatement drops a protection** (adversarial half). Main's `Scalability_NoProgramLogicNamesAKindOrAFact` rejects a planted `part.Fact(nameof(depth))`, but its replacement (`LibraryTests.cs:432`) passes it. No ruling named makes the old protection wrong (D-443 restatement rule).

## Follow-ups
1. **Varies:** the multiple-pit "Varies" state has no edit route in this build. That is in the builder's own account, and the full combined layout coverage stays open.
2. **The Pipe-start control:** it stays skipped under D-410, waiting on A6.

**Next:** round 1 of 2. Each blocker comes over as a failing test first. The 70 restatements are read one by one, with a full build and comparison on the real tip.


---

# Second verdict: team/pit-window at 0f156b4 (fix round 1 of 2)

**Verdict: HOLD. Both halves hold it. The next round is the last.** Written Sat 21 Nov 2026, about 8:30 pm. Both halves ran on Codex with every outside-input variable unset:
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\pwb2_honest_REPORT.md`.
- **Adversarial half:** gpt-6.2-astra. Report: `pwb2_adv_REPORT.md`, with proofs in `pwb2_adv_proofs\`.

**The main-line control is clean.**
- **The counts:** main 711042e has 2,511 passes. On the tip, 2,410 pass under the same name, 9 use the same method with the checkout path in their data, and 92 pass under a changed name. No main pass fails or is skipped.
- **The controls:** 96 named controls pass, against main's 95; the one failure and the one skip are the same on both.
- **Not repeated:** neither half could compile the whole solution this time, for lack of the package.

**Closed:**
- **Units:** level retypes in metres and cm drawings write nothing (6.50 to 7.77 and 5.12 to 5.25 replayed), while the mm controls still write.
- **Worked covers:** the schedule follows a measured 10.025, and Run refuses a worked 9.875.
- **The units notice:** it is whole in all six layouts.
- **Printed figures:** the change list and Step 3 use the shared printer (CL 5.75, IL 5.25, depth 0.51; CL 1000.13, depth 0.63).
- **Renumber:** it counts after adding the separate edit, and compares numbers, geometry, tags and protection.
- **Source probes:** the original two parser plants and all four rounding binding probes fail as they must.
- **The scalability refusal:** it is restored.

## Blockers

1. **The Pipe window loses its top preview** (both halves). The change carried over from 9dbf9d6.
   - **What changed:** on main, the Pipe drawing preview spans the top strip (1,486 units). On the tip it is a blank left panel with placeholder text.
   - **The cause:** `WindowSpec.cs:171-177` puts `pipe.csv` on the steps layout, but `pipe.csv` still says `wide`. The steps gate at `StdSteps.cs:51` then drops the strip.
   - **Ruling:** D-313 and the approved Pipe layout.
2. **"Number on plan" is cut off at both approved sizes** (adversarial half). The caption needs 101.33 units and gets 96 at 1000 by 620, and 97 at 1240 by 780. The fixed checkbox column is at `StdSteps.cs:251`. The layout check (`AcadWindowHostTests.cs:188`) tests shortened text with trimming, so it misses this. Rulings: D-346, D-386, PIT_WINDOW section 1.5.
3. **The number gate still misses a second reader** (both halves).
   - **A short.TryParse:** one added at `PitTool.cs:254` compiled. The second pit's record kept P7007, but its visible tag read P1 beside the first P1, and all three number-source tests passed. The checker knows a fixed list of type spellings (`PitNumberSourceTests.cs:63`).
   - **A long.TryParse:** one added inside the shared `DrawingNumber` helper (`PitTool.cs:149-159, 223-225, 245`) also passes. The guard reads the bodies of five named methods only (lines 27-41, 63-66).
   - **Ruling:** PIT_WINDOW section 3.4 (follow the routes through helpers).
4. **Three restatements still drop coverage** (D-443 rule).
   - **Case 21 (honest half):** it drops the exact check protecting the surviving "What else changes" rows (`StepsWindowTests.cs:234-247`).
   - **Case 87 (honest half):** it swaps metre Long-section coverage for an unset drawing (`Entry47Tests.cs:359`). D-403 justifies refusing Pit writes there, not losing the Long-section control. A different setup is needed.
   - **The Hands scalability exemption (adversarial half):** `ScalabilityTests.cs:43` exempts the exact refusal sentence in `PitNumber.cs:22`. That sentence can come from the wording data instead, and no ruling authorises the exemption.

**Also needed before the merge:** this tip is based on main 711042e. Main is now 03119b1 (with privacy-path2), so the next round must bring main in again.

**Next:** the LAST round, with each blocker as a failing test first, then the full build and comparison against main 03119b1.


---

# Final verdict: team/pit-window at 4b42c43 (the LAST round)

**Verdict: HOLD, final. Both halves hold it. Under D-346 it goes to the control room with this open list.** Written Sat 21 Nov 2026, about 10:34 pm. Both halves ran on Codex with every outside-input variable unset:
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\pwb3_honest_REPORT.md`, evidence in `pwb3_honest_evidence\`.
- **Adversarial half:** gpt-6.2-astra. Report: `pwb3_adv_REPORT.md`, with proofs in `pwb3_adv_proofs\`.

The first launch of both halves died at about 9:30 pm, when the Codex shell returned nothing. Both were relaunched and ran clean.

**The main-line control is clean.**
- **Every main pass accounted for:** all 2,541 of main 03119b1's passes pass on the tip: 2,443 by the same identity, 82 renamed with matching data, 7 by equal inputs, and 9 checkout-path fixture groups.
- **Load failures:** three that failed under load passed alone; the timing test fails under load on both revisions.
- **Controls:** 94 of 96 named controls pass on both. C4_control fails on both, and the pipe-start control is skipped on both (D-410).
- **The merge of main is sound:** of the 58 paths main changed, 46 match byte for byte. The other 12 are the log and overlapping tests, with main's checked reads kept. The checked read-and-write support, the privacy guard, the night scripts and the click runner all match main. All 52 privacy guard cases and the 4 release-input cases pass.

**Closed:**
- **The Pipe top preview strip:** it is restored (D-313).
- **"Number on plan":** it fits at both sizes, and the layout check now catches it.
- **The number guard:** it follows helpers and catches the short and long parsers.
- **The restatements:** cases 21 and 87 and the scalability exemption are back to their old expectations.
- **Everything closed earlier:** it stays closed (units refusal, worked covers, units notice, printed figures, Renumber count, rounding probes).

## Open list (one page)

1. **The filled Pipe window hides a warning the drafter needs, at both approved sizes** (both halves).
   - **The case:** a 225 mm pipe at 1 in 75 with an upstream invert of 10.40. The lower cover warning, the grey reason the upstream cover check could not run, shows 0 of its 48 units at both 1000 by 620 and 1240 by 780, with nothing to scroll. The drafter can still press OK.
   - **Also cut off:** at 1240 by 780, only 15 of 24 units of the worked downstream-invert row show. A two-ended pipe with conflicting held levels also hides a separate 70 mm discrepancy at both sizes.
   - **Where:** `StdSteps.cs:1099, 1113-1115`.
   - **Rulings:** D-346, D-393 item 4, D-398 item 3. The builder had flagged this case itself.
2. **The number guard still passes one parser form** (adversarial half). One added line in the tag writer read the digits through a regular-expression capture, parsed them and cast the result. The record stayed P7007, the tag read P1 beside another P1, and all five number-source tests passed. The product code today has no such line (PIT_WINDOW section 3.4).

**Recommended for the control room:**
1. **Item 1:** one bounded edit; it is a drafter-facing cut-off at both approved sizes.
2. **Item 2:** a BINDING PROBE on every later build that writes a pit number, as for the rounding and settings probes. Each round has closed every named parser, and reaching this one needs someone to write new code.
