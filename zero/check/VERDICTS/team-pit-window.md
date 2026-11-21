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
