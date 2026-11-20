# Follow-ups: Part 3, cover and grade checks (and root cause C11)

## From the check of the C11 test list, codex/c11-tests at 11c6041, Fri 20 Nov 2026

Reports: `C:\CE_WORK\check\reports\c11-tests_honest_REPORT.md` and `c11-tests_adv_REPORT.md`; every case by name in `c11-tests_adv_proofs\case-ledger.md`. The reasons the list is held are in `VERDICTS\codex-c11-tests.md`. These are the lesser items.

1. **Source-text checks are weak alone** (`tests/CeCivil.Brain.Tests/AcceptanceC11SourceTests.cs:13, 48, 60`): they passed with the two stored numbers still there, the withdrawn file loaded under another name, local number formats still in use, and rounding in the check rows behind another name. Only four files are scanned. Pair each with a sum at a level the test has not seen.
2. **Two controls stay green with their sum broken:** the 5 mm council-arrival control (tolerance removed from the comparison) and the rounding-source control (Boyd's five-minute rounding and the hole floor removed). Add a council invert that is not a whole centimetre, either side of tolerance; test a freshly worked-out orifice either side of a whole millimetre.
3. **Loose "contains" checks:** P3_27 looks for "6 mm" and "4 mm" ("16 mm" passes); P8_42 needs only "over" and no zero ("Over by 999 l/s" passed). Match whole words and the amount.
4. **Printed rows:** the 8 m division test passes if the answer is always 0.08; the shortage test accepts its three rows anywhere. Add 12.00 divided by 100, a zero and a missing divisor, a surplus that turns into a shortage, and that the last row shown is the total.
5. **Tests that call private names** (P3_38: `StdSum.Adds`, `StdSteps.AddsWithinRounding`, `StdSteps.WorkedFigure`): they will break on a missing name, not a wrong figure. Point them at what is shown.
6. **The list of 28 older tests is short:** about 35 older assertions in roughly 15 files still expect metres with no unit ("Short by 0.05 at P4"); `FactTests.WorkedOutRoundingThroughFact` asserts the stored rounded copy the design removes. Each needs its ruling written beside the change.
7. **Several held figures:** the cheat could erase every clash for the fixture's own 0.504 m depth. Add a second clashing pair, reverse which end is higher, and assert the signed difference, the place, the source and the hold.
8. **One figure through every place:** no case follows one independently chosen figure through the window, the label, the reopened check and the printed working (schedule and Detention legs wait for Stage 2).
9. **Bad input, then repaired:** no C11 case enters a bad Stage 1 figure, sees Wrong and "Cannot check yet", then repairs it. Older tests cover the first half.
10. **P8_42 depends on the sums using 3.1416 for pi** (margin 0.00000002 L/s). Wording in the list writes "l/s"; Australian practice writes L/s. The printed-working tests set line wording no ruling gives ("Flow l/s", "= Head mm").
11. **Boyd's inputs (Stage 2):** add a case that picks a council garden figure, falls back to 0.35, then changes the discharge inputs with and without a typed hold (D-331, D-332).
12. **Design amendment 2's example pair is wrong against D-321** (15,399.9 and 15,400.1 mm both read 200.00 and both suit); the control room has acknowledged it; the tests follow D-321.
