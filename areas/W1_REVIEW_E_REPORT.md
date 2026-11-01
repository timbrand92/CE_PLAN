# Wave 1 batch case review E (14 cases) — Sun 1 Nov 2026

1. **Result:** 1 ACCEPT FULL, 12 ACCEPT PART, 1 NOT YET, 0 ALREADY. 13 slips written (no slip existed before); none for W244.
2. **NOT YET — W244:** its deciding check can never fail. The line `log civil absent "Pipe inverts updated: {$hp} from=17."` uses the AutoCAD handle (11C55B), but CE writes that log line with the pipe's CE identity (`{pipe.Id}`, ProjectDataService.Mutations.cs 1458 at 3fbb9da5; the run shows the identity `CE-CIV-PIPE-A114...`). No "Pipe inverts updated" line was written at all in 295 log lines, so the twin "fails" only because the line it asks for can never exist.
3. **Three weakest accepted cases:** W210 (its Edit Pit check is too weak to fail, and LEAVING is checked only in the twin), W267 (its "links back" check, `0 Not Connected`, cannot fail), and W278 / W285 / W324 together (each twin was BLOCKED, never FAILED).
4. **Hold on three slips:** W278, W285 and W324 are not Claude-accepted until their twin FAILs on a check. Each slip says this.
5. **Engineering note:** W654 accepts "warn and write the back-fall" in place of the bug's "block, or stop the walk". That follows BUG-1040 and rule R-27, so I did not raise it with Tim.
6. **Report file name:** the job named this file W1_REVIEW_E_REPORT.md; the brief's pattern was C78_REVIEW_E_REPORT.md. I followed the job.
7. **Time:** 17:53 to 18:00 by the PC clock, about 8 minutes. Read-only apart from the 13 slips and this report. I ran no AutoCAD, built nothing and committed nothing.
8. **Hashes:** all 14 case files hash to the sha256 on the list line.
9. **Wording source:** every asserted wording is in the source at 3fbb9da5, or was seen on both passing runs (some are split or interpolated in the source: "pipes selected", "Min grade", "CDEDIT-CASCADE: anchor=", "arrives at"). Nothing is UNSOURCED.

## Cases

1. **W210 — ACCEPT PART.**
   - **Proves:** after P8 is erased (188 / 183), a lone pit COPYed onto its spot links to the pipe end at once. CDCHECK straight after the COPY reads 189 / 184 again.
   - **Not proved:** that Edit Pit and the Pit Schedule agree, which is the bug's own Expected.
   - **Too weak:** `control-text $epit absent "no recorded connection"` also passed in the unlinked twin (tW01, check 12).
   - **Twin:** the twin asserts LEAVING but the case does not, so the twin differs by two lines. It still failed on the shared CDCHECK check (tW01, check 11), so the red stands.
   - **Fix to make it FULL:** add a positive Edit Pit row check (after confirming the word LEAVING in a dump) and the schedule cells.
2. **W216 — ACCEPT PART.**
   - **Proves:** Enter at "Next level (0 placed, 1 skipped)" ends CDFALLSUGGEST with the count line in the typed result, and no "Invalid point" appears.
   - **Not proved:** the Enter after an accepted arrow (the Codex route of 14 Oct).
   - **Twin:** FAILED on a check in cW06. Its tW01 run was BLOCKED by a driver guard.
3. **W223 — ACCEPT PART.**
   - **Proves:** the CDEDIT branch. The box names swap and the flow note appears before Save; there is no uphill line; the arrow turns; the reopen shows the same.
   - **Not proved:** the CD not-drawn-first branch and the "Flow:" line.
   - **Twin:** FAILED on the note and box-name checks (tW01).
4. **W244 — NOT YET.**
   - **Line to fix:** `log civil absent "Pipe inverts updated: {$hp} from=17."`. Replace it with a check that reads the stored direction after the CDSYNC, the W223 / W278 way:
     - `control-next $epd "Edit pipe, Set first end level" "Downstream"`
     - `control $epd "C2.FirstInvert" value` holding the low west level
     - or the record row
   - **Or:** use the pipe's CE identity, and first show that the relink writes that line at all.
   - **Twin to match:** W244_BROKEN must then break the behaviour, not turn a check round that can never pass.
   - **Already sanity-only:** the arrow and the IL 18.000 checks; the case says so itself.
5. **W248 — ACCEPT FULL.**
   - **Proves:** OOPS brings back the drain and the same PD1 text (same handle, words and position). Both [BUG-258] log lines are written, there is no protected-text line, and one U takes both away.
   - **Outside the bug, not driven:** the locked-layer / Xref branch.
   - **Twin:** REGEN in place of OOPS FAILED on the "back" counts (tW02).
6. **W261 — ACCEPT PART.**
   - **Proves:** a diameter-only save on a reversed two-open-end pipe gives no "flows uphill" line and no Design Warnings window. The direction, size and label are kept.
   - **Not proved:** CD's "Use level direction" route.
   - **Weak spot:** the deciding checks are absences, and the twin turns red only on the direction checks.
7. **W267 — ACCEPT PART.**
   - **Proves:** ERASE of P3 takes its 2 labels; OOPS brings them back (1037 to 1040 objects) with exactly one line.
   - **Too weak:** `matches $chk1 "Unresolved, 0 Not Connected, 0 Unknown\."` cannot fail. An erased pit drops out of the total and is never counted as Not Connected (W210 runs: 188 / 183 with 0 Not Connected). Use `contains $chk1 "218 objects, 189 connections: 184 Connected"` instead.
   - **Twin:** FAILED on the count (tW02). It only turns a number round.
8. **W278 — ACCEPT PART.**
   - **Proves:** a pipe turned round to flow into P8 stays that way through its Save and a later diameter-only Save. Edit Pipe reopens as Downstream / Upstream, and the Pit Schedule shows P8's INLET as 150 at 17.80 with blank outlet cells. This is a strong check.
   - **Not proved:** CDFIXPIPEENDS (Tim's step 3), U, and reopening the saved drawing.
   - **Twin:** BLOCKED (tW03, AutoCAD busy). No red is recorded yet.
9. **W285 — ACCEPT PART.**
   - **Proves:** OOPS brings back the pipe's label, 2 IL texts and arrow on their layers, says one line, and a later MOVE of P8 drags the pipe (the pit list is back).
   - **Not proved:** where the items sit; the pipe-with-pit branch (W325 covers that).
   - **Twin:** BLOCKED (tW03, driver guard). No red is recorded yet.
10. **W324 — ACCEPT PART.**
    - **Proves:** the older pipe P4 -> P3 is left out by name, the batch editor opens for the other pipe, there is no refusal line, and closing it changes nothing.
    - **Not proved:** Apply (not pressable by the driver) and the repair offer.
    - **Twin:** BLOCKED (tW03, AutoCAD busy). No red is recorded yet.
11. **W325 — ACCEPT PART.**
    - **Proves:** OOPS of pit + label + pipe says exactly one line naming both and "re-linked them"; the count is restored; one U takes the lot away.
    - **Not proved:** the look of the label, the far IL text and the arrow (Codex look).
    - **Twin:** FAILED on the line count (tW03).
12. **W652 — ACCEPT PART.**
    - **Proves:** the 50 mm drop at pit B is kept (IL 18.15 / 18.05, no 18.10). The blank-end pipe is skipped and named, with no level below zero.
    - **Not proved:** CDPROPAGATE; which text sits on which pipe end.
    - **Twins:** W652_BROKEN (switch off) is a real behavioural red. W653_BROKEN only turns the below-zero count round.
13. **W654 — ACCEPT PART.**
    - **Proves:** the kept hand-typed 18.06 against the written 17.95 is now named as running backwards, with the kept line, the Updated line, the log line and the texts.
    - **Not proved:** CDPROPAGATE with Enter = Keep; the preview wording.
    - **Twin:** a real red (50 mm lowering, the written levels still fall, no warning), tW04.
14. **W655 — ACCEPT PART.**
    - **Proves:** at a junction the outlet stays under the lower arriving pipe (17.88 / 17.78, no 18.05), and the warning names P82 -> P83.
    - **Not proved:** the warning inside the Cascade Preview (recorded only), CDPROPAGATE, batch Carry downstream, and two changed pipes at one junction.
    - **Twin:** switch off, a real red (tW04).
