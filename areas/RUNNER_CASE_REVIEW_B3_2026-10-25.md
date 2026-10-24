# Runner case review, batch 3: new daily-tool cases R31 to R40 (Opus independent review, Sun 25 Oct 2026)

Written Sun 25 Oct 2026, about 07:55 to 08:40 Melbourne (PC clock), by an independent Opus reviewer. Read-only: nothing run in AutoCAD, no runner, case, variant, settings, lock, run report or ledger file edited, no bug status changed, `BUG_CARPARK.md` and `DESK_LOG.md` not touched, nothing committed or pushed. The Team job tester_run57 was using the runner; I did not touch it. The only files written are this one and four `.review.txt` files (listed at the end). Rule applied: the RULES.md acceptance amendment of 24 Oct ("Claude-accepted") and `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`. Method and shape: `RUNNER_CASE_REVIEW_B2_2026-10-24.md` and `RUNNER_CASE_REVIEW_HARDEN_2026-10-25.md`.

## FOR TIM

1. **4 of the 13 new cases are ready to count as Claude-accepted, on today's build (Civil 3.0.75):** the CD direction question names both levels (R31), CDSL reads typed levels properly (R35), CDPERIMETER draws its PD1 tag and says "perimeter drain" (R37), and CD's "use a line I drew" keeps a curved or closed line and warns (R39b).
2. **2 bugs may now be written "FIXED (Claude-accepted)":** BUG-711 (CDSL typed level, "18600" refused) and BUG-684 (curved or closed line kept, with a warning).
3. **No daily-tool check (D-number) is added by this batch.** The running total stays 6 of 40, and **none of the 6 has passed on today's build yet**, so on Civil 3.0.75 the count is 0 of 40 until the earlier cases are re-run.
4. **Correction to the builder's report, plainly:** the ROTATE Copy / SCALE Copy fault (R34, BUG-665) is not a broken fix. The fix exists but sits behind a Settings tick "Clean up grip Ctrl-drag, ROTATE Copy and SCALE Copy like COPY", which is **off** for you and so for Max. With it off, a ROTATE Copy of a pit gives a second pit with no label and the same number. **One question for your Monday batch:** switch that tick on for the office? My recommendation: yes, after a robot pass with it on, because two pits with the same number go straight onto an issued drawing.
5. **One new bug should be filed (steps below the line):** after you flip a pipe's levels in Edit Pipe, a later save that only changes the size turns the flow arrow back uphill, with no warning.

---

**What I read:** the builder's report `release-v3-colleagues-RUNNER_PHASE3_BATCH3_REPORT.md` (all of it); both earlier reviews named above; RULES.md; the Claude-accepted decision; the 13 case files and the 11 broken variants; `R16_tidy_labels_names_the_pipe.review.txt` (format); `runner-reports\ledger.json` (265 rows) joined row by row to today's file hashes, which I took myself with Get-FileHash; the run reports pA1 to pA5 and pB1 to pB5 (every check line), plus the ledger-only rows of p3b3a1 to p3b3b8; the assertion code in `case_runner_lib.ps1` and `Get-CaseIndependentReview` in `case_runner.ps1`; cards D07, D15, D26, D28 and the gap plan's 40 checks (`RELEASE_9NOV_GAP_PLAN_2026-10-22.md` line 136); triage groups N1, K3, L1, M3, V2, R2, R3, S2, S3, N4, C1, C2, W2; bugs BUG-205, BUG-223, BUG-260, BUG-261, BUG-262, BUG-292, BUG-102, BUG-132, BUG-147, BUG-217, BUG-236, BUG-376, BUG-377, BUG-388, BUG-389, BUG-460, BUG-606, BUG-665, BUG-672, BUG-684, BUG-686, BUG-697, BUG-711 in `BUG_CARPARK.md`; CV7-12 in `04_REFERENCE\CARDS\CV-07_SURVEY_IMPORT.md`; `DRIVER_RUN17_2026-10-03.md` item C9; the installed source at commit `2c805a39` (one switch, see R34); the product version of every installed CE DLL.

## ANSWER FIRST

1. **Counts (one main verdict per case, 13 cases):**
   1. **CLAUDE-ACCEPTED-READY: 4.** R31 (BUG-205 wording half), R35 (BUG-711), R37 (BUG-217 without the look), R39b (BUG-684). All on **Civil 3.0.75**.
   2. **NEEDS BROKEN VARIANT: 0.**
   3. **NEEDS STRONGER ASSERTION: 5.** R32, R33, R36, R38, R39.
   4. **PARTIAL (part only): 1.** R37b (move and erase; not copy, not the text height).
   5. **NEEDS CODEX LOOK: 1.** R40 (a window case; its BUG-606 claim also has gaps).
   6. **FAIL = real fault: 2.** R32b (new bug, see item 5.1) and R34 (BUG-665, with its fix switched off, see item 5.2).
2. **Daily tools (D-numbers) that may now be counted Claude-accepted: none new.**
   1. **D26:** R35 covers the typed half only. The survey line (assertion 1) and the blank level by Enter (assertion 3) are not run.
   2. **D15:** R34 fails, and no case reads the copied pit's new number (assertion 2).
   3. **D28:** R40 is a look case, and it asserts the opposite of card step 4 (see R40).
   4. **D01, D04, D07, D17, D21, D23:** the cases that name them are "neighbours"; none runs the card's own steps.
3. **The 40 gap-plan checks:** no new one. **Total accepted: 6 of 40** (D01, D04, D12, D17, Recover Inverts, Tidy labels names the pipe). **On the current build Civil 3.0.75: 0 of 40.** I checked the ledger: R01, R03, R15, R16, R17 and R20 have no row at all on 3.0.75. Each needs two passes on 3.0.75 to stay current.
4. **Bugs that may be written "FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026)": 2.**
   1. **BUG-711** (R35): every example in the bug ("P18.6", "18,6", "18600", "18.6m") plus "RL18.6" and "18.600"; written as P18.600 in the block's LEVEL attribute; "18600" refused and asked again.
   2. **BUG-684** (R39b): a line with an arc and a closed line each give the plain warning, and the drawn line is still there afterwards as a plain polyline (I checked its object type, not only its handle).
   3. **Not yet, with the reason:** BUG-205 (only the wording half is proven; what "Use level direction" then draws is not run); BUG-217 (the visible PD1 tag needs a Codex look); BUG-223 and BUG-686 (see R32 and R32b); BUG-460, BUG-672, BUG-262 (R33 lines first); BUG-102, BUG-132, BUG-147 (R36 lines first, and CDSOURCE never runs); BUG-236 (part only); BUG-376 (R38 does not reproduce it); BUG-697 (R39 lines first); BUG-606 (the "approved report location" is not recorded anywhere, see R40); BUG-665 (switched off).
5. **The two real-fault cases, owner and bug id:**
   1. **R32b: file a NEW bug.** BUG-292 is not a proven match. Its text is a code-read about the Edit Pipe boxes filling in record order; R32b never reads the boxes, and nobody has seen BUG-292 happen. BUG-261's symptom is a false uphill warning, not a turned arrow. The closest in effect is **BUG-223** ("never silently uphill" on a two-open-end pipe in CDEDIT), so BUG-223 must stay OPEN. The new entry, in the five parts of RULES 13.1:
      1. **What was done:** fresh copy of DRV1_B1. CD from 150000,-90000 to 170000,-90000, Start levels 18.000 then 17.900, Start Pipe, Esc. CDEDIT that pipe, type the first level 17.900 and the second 18.000, Save ("Pipe updated.", the flow arrow turns round, correct). CDEDIT the same pipe again, change only the diameter to 150, Save.
      2. **Expected:** the arrow still points from the 18.000 end to the 17.900 end; arrow, IL texts and label agree; or CE says plainly that the pipe runs uphill.
      3. **What happened (Civil 3.0.75, runs pA2 and pB2, also p3b3a4):** "Pipe updated." and nothing else; the TIM_CVL_ARROW block went back to rotation 0, so it points at the 18.000 end (uphill); the IL texts were not changed; the label reads "150 DIA. UPVC PIPE AT 1 IN 200". A pipe that was never flipped keeps its arrow on the same size-only save.
      4. **Test that catches it:** runner case R32b (current text SHA-256 5AB5BA78EF60...). Retag it `EXPECT-FAIL BUG-<new>` at its next edit.
      5. **Steps to confirm a fix:** the same steps; after the size-only save the arrow still points from IL 18.000 to IL 17.900, in two runner sessions on one build.
      6. **Links to write in the entry:** BUG-223 (keep OPEN), BUG-292, BUG-261, BUG-260. Do not mark any of them duplicate until someone reads the installed code.
   2. **R34: BUG-665 is the right owner, but the fault is "switched off", not "fix broken".** In the installed source (`2c805a39`), `Services/ExternalMutationCommandPolicy.cs` lines 89 to 106 clean up ROTATE Copy and SCALE Copy only when `linking.cleanUpGripRotateScaleCopies` is on. `Models/UserSettings.cs` line 732 sets it **false** by default, and the key is not in Tim's `CD_Settings.json` (hash ACD64E79A33B, read today), so it is off. R34 therefore shows what Tim and Max get today, a real HIGH fault for them (a twin pit with no label and the same number), and says nothing about whether PR #1328 works. The desk should not write "the BUG-665 fix does not work". What to add is in item 5 of "The cases".
6. **Things the desk should know first:**
   1. **Builds are true.** Every case and variant run in the ledger for R31 to R40 is stamped Civil 3.0.75+2c805a39 / Structural 1.0.123 / Manager 1.1.75, and the earliest is 04:05 (p3b3a1). The live bundle's `Contents` folder was created at **03:33:02**, not "about 03:40" as the report says. The DLLs read 3.0.75+2c805a39 today in Legacy, Modern and Net8. Only one run straddled the install: the probe p3b3prbB2 (03:32 to 03:38, stamped 3.0.74). It is a probe, not a case, and no pass or fail rests on it. No install landed after 03:33 (no later folder creation; the latest ledger row is 07:41:54).
   2. **Hashes are true.** Every PASS and FAIL I count carries today's file hash. All 13 case hashes and 11 variant hashes in the report match Get-FileHash today.
   3. **Sessions:** each run held two to five cases in one AutoCAD (fresh drawing per case, same AutoCAD), not "each case in its own AutoCAD session" as report item 2 says. The rule needs two separate sessions per case, and that holds: run 1 (pA) and run 2 (pB) are separate AutoCADs.
   4. **Other report errors (RULES 6.2):**
      1. **"All 12 variants":** there are 11.
      2. **R40_BROKEN "both checks must FAIL":** its folder check PASSED in both runs (no new file appeared at all); only the history check failed.
      3. **R40's own REVIEWED_AGAINST** says the command "no longer prints wrote report"; the case asserts that line and it printed in every run.
      4. **R40's EXPECTED still holds a control character** (a backspace, byte 2402, where `logs\checkdwg` was): the sed damage the report says was repaired is not fully repaired. Cosmetic, but the memory rule is to scan C0 and C1 before a commit.
      5. **"C1" claimed for R40:** C1 is CDCHECK, not CDCHECKDWG. No C1 bug is proved.
      6. **BUG-223 and BUG-686 listed as writable FIXED:** not supported (R32).
   5. **Seen in passing, not judged by any case:**
      1. **IL text decimals follow what was typed.** Typed "11.00" gives "IL 11.00" (R31's control pipe); typed "18.000" gives "IL 18.000" (R32, R39); typed "0.50" gives "IL 0.50". The DRV1_B1 plan texts are two places ("IL 17.30"). One plan can mix 2 and 3 places. No bug entry found (grep). A Settings-first question for the desk.
      2. **CDPERIMETER prints its options twice:** "Perimeter drain pipe property [None/Charged/Suspended] <None> [None/Charged/Suspended] <None>:" (all R37 runs). Same kind as BUG-388 and the CDTIDYLABELS prompt in the batch 2 review. No entry found.
      3. **"Grade: 1:20 ? meets the office minimum":** the "?" may be how AutoCAD's log file stores a dash. Only a Codex look at the real command line can tell.
      4. **The raw text `\U+2192`** sits in the very sentence BUG-205's fix wrote ("... (IL 10.000) \U+2192 Open end at point 2 ..."). BUG-377 / BUG-389 family, still on 3.0.75. Attach R31's evidence to BUG-389.
      5. **COPY of P3 with 25TEXT locked** also lists the schedule cells of P5, P6 and P7 as "not updated". A drafter who copied one pit reads lines about three pits he did not touch. Not judged.

## How I applied the four conditions

1. **Nothing seen on screen.** Met for every check in R31, R32, R32b, R33, R34, R35, R36, R37b, R38 and R39b. R37's PD1 text exists as a drawing object, but whether a drafter can see it is a look. R40 is a look case.
2. **Two passes in separate AutoCAD sessions on one build** (ledger, current hashes, all Civil 3.0.75):
   1. **R31, R32:** p3b3a6 / p3b3a2, pA1, pB1.
   2. **R33:** p3b3a4, pA2, pB2. (Two FAILs at 04:34 are on an older text, 03268FE3.)
   3. **R35:** p3b3a1, pA3, pB3.
   4. **R36:** pA4, pB3 (two only; the two FAILs at 05:18 are on an older text, 0664D383).
   5. **R37:** p3b3b3, pA4, pB4. **R37b:** p3b3b4, pA4, pB4.
   6. **R38:** p3b3b8, pA5, pB4. **R39:** p3b3a9, pA5, pB4. **R39b:** p3b3b1, pA5, pB5.
   7. **R40:** pA5, pB5 on the current text (an older text passed in p3b3b8 and failed twice before).
   8. **R32b:** FAIL in p3b3a4, pA2, pB2. **R34:** FAIL in pA3, pB3, pB5.
3. **Red before green.** Every variant FAILED in the ledger on its current text. The true reds (a real switch, not a flipped word): R31_BROKEN (levels the drawn way), R32_BROKEN (no reversal), R33_BROKEN (no lock), R37_BROKEN (Esc at Accept), R37b_BROKEN (no move, no erase), R39_BROKEN (point off the line), R39b_BROKEN (no arc). Flipped expectations: R35_BROKEN (expects 18600 placed), R36_BROKEN (Esc but expects a placement), R38_BROKEN (expects 17.99), R40_BROKEN (history half only).
4. **Compared with the card or bug, and full coverage.** Line by line below.

## The cases

1. **R31: CD direction question names both levels (N1; BUG-205 wording half).** Verdict: **CLAUDE-ACCEPTED-READY** for "the direction question shows the real level of each end, so the two choices can be told apart", on Civil 3.0.75.
   1. **Asks met:** the question names IL 10.000 and IL 11.000 (and IL 0.000 / IL 0.500), so the old "Open end -> Open end" twice is gone; the choices line is pinned; Esc erases the pipe (object count 1034 before and after, twice); the levels that fall the drawn way ask nothing and place a pipe.
   2. **Red:** R31_BROKEN, a true red.
   3. **Not covered (the case says so):** what "Use level direction" then draws (BUG-205's first half), so BUG-205 is not FIXED. The CD route of BUG-686 (the arrow drawn for 0.00 then 0.50) is not drawn either; R31 only shows that 0.000 counts as a level in the direction check.
   4. **For BUG-389:** the `\U+2192` in the same sentence (item 6.5.4).
2. **R32: Edit Pipe flips the arrow (K3; claims BUG-223, BUG-686).** Verdict: **NEEDS STRONGER ASSERTION.**
   1. **Asks met:** both arrows turn from rotation 0 to 3.1416 on the reversing save, also with a 0.00 level.
   2. **The gap, a check that can pass while the bug is there:** BUG-223 says CDEDIT could keep the stored direction and leave a pipe silently uphill. R32b shows exactly that one save later: a size-only save of the same kind of pipe puts the arrow back to 0, silently. So the turned arrow in R32 may be a redraw while the stored direction is unchanged. R32 must survive a second save. **Lines to add**, after `ent-read {$haA} -> $arrowA1`:
      1. `pick-first "{$hpA}"`
      2. `type "CDEDIT" -Force -ExpectWindow "Edit Pipe" -TimeoutSec 120 -> $edA2`
      3. `ui-press "Edit Pipe" "Edit pipe, Save" -> $svA2`
      4. `sleep 6`, `esc-prompt -> $hA2`, `wait`, `ent-read {$haA} -> $arrowA2`
      5. ASSERT `matches $arrowA2 "rotation.:3\.14"`. The same four steps for pipe B, giving `$arrowB2`.
   3. **Also:** the IL check relies on creation order for "left" and "right". Add `field $ilA x -All -> $ilA_x` and `record $ilA_x "IL text x after the save"`, then pin which x holds 17.900.
   4. **Expectation:** on 3.0.75 the new lines will probably FAIL (that is R32b's fault). Then R32 becomes `EXPECT-FAIL BUG-<new>` until a fix. BUG-223 and BUG-686 stay OPEN.
3. **R32b: size-only save turns a flipped arrow back (K3).** Verdict: **FAIL = real fault**, three runs. Owner: a new bug (ANSWER FIRST item 5.1). Before the next run, add `ui-dump "Edit Pipe" -> $edC_dump` straight after `$edC` opens and `record $edC_dump "FULL Edit Pipe on the second open"`, so the next reader sees what the boxes and the "Flow:" header said. Also pin the IL ends by x, as in R32.
4. **R33: locked pit text layers, PIT and COPY (L1; BUG-460, BUG-672, BUG-262 half).** Verdict: **NEEDS STRONGER ASSERTION.**
   1. **Asks met:** BUG-460 in full: PIT refuses before the pit goes in with the label layer locked and again with the cover-text layer locked (count 1034 unchanged, exact sentence). COPY with 25TEXT locked: one pit block and one PIT LABEL block, no "CL" text, "layer 25TEXT is locked", the P3 schedule-cell sentence, one U back. A true red.
   2. **Gap 1, "the copy keeps its own pit number label" is not read.** A label block with no number, or with "P3", would pass. **Lines to add**, after `select $newcp "name~^PIT LABEL" -> $cp_label`:
      1. `field $cp_label handle -> $hcpl`
      2. `ent-read {$hcpl} -> $cpl`
      3. `record $cpl "FULL the copied pit's label"`
      4. ASSERT `matches $cpl "text.:.P(?!3.,)[0-9]+.,.insertion"` (a P number that is not P3). Probe first that the PIT LABEL number shows in `ent-read` the way the SPOT LEVEL attribute does in R35.
   3. **Gap 2, the sentence about the skipped cover text is not pinned.** EXPECTED says CE reports "no label or cover text", yet a label is drawn. If CE says "no label" while drawing one, the message is untrue. **Line:** `record $cp1 "FULL COPY with 25TEXT locked (whole)"` for one run, then `contains $cp1 "<that exact sentence>"`.
   4. **Then:** BUG-460 and BUG-672 may be written for these routes. BUG-262 stays part only (the handle-only line, the copied-cell line and the invert-text line are not run).
5. **R34: ROTATE Copy and SCALE Copy of a pit (M3; D15; BUG-665).** Verdict: **FAIL = real fault for Tim's and Max's setup**, three runs. The plain COPY control passes.
   1. **Why it fails:** the fix is switched off (ANSWER FIRST item 5.2). The failing checks: no PIT LABEL for the rotated and the scaled copy, and one "numbered as new" line instead of three.
   2. **Lines to add, a twin `R34s` (no EXPECT-FAIL):** R34's header with `SETTING CD_Settings.json linking.cleanUpGripRotateScaleCopies true` and R34's steps. Probe first that the SETTING verb can add a key that is missing from Tim's file (the harden review raised the same for R09). If R34s passes twice, BUG-665's ROTATE and SCALE half works when switched on, and R34 is its true red. Grip Ctrl-drag stays undriven.
   3. **For D15:** a short `R34a`: R34's COPY part only, plus the copy's label number read as in R33 item 4.2, plus one U and `equals` on the counts. That is D15's assertions 1 to 3.
   4. **Retag R34** at its next edit: `EXPECT-FAIL BUG-665` with a note "linking.cleanUpGripRotateScaleCopies off".
6. **R35: CDSL typed level (V2; D26 typed half; BUG-711).** Verdict: **CLAUDE-ACCEPTED-READY** for BUG-711, on Civil 3.0.75.
   1. **Asks met:** all four inputs from the bug plus RL18.6 and 18.600 each print "Spot level placed. Level: P18.600", and each placed SPOT LEVEL block's LEVEL attribute reads P18.600 (read from the block, not only the command line); no PP18 and no 18.6m; 18600 gets the exact refusal, is asked again, and Esc places nothing (`count $sp4 = 0`, five blocks in all).
   2. **Red:** R35_BROKEN, flipped (expects 18600 placed).
   3. **Weak spot, optional at the next edit:** `not-contains $lay "0TEXT"` proves little. Use `equals` on "25DIMS | 25DIMS | 25DIMS | 25DIMS | 25DIMS" (D26 assertion 2).
   4. **D26 not whole:** the survey line and the blank level by Enter are not run.
7. **R36: CDFW on a drawing with four AGI blocks (R3; BUG-147, BUG-132, BUG-102).** Verdict: **NEEDS STRONGER ASSERTION**, then part only.
   1. **Asks met:** "Floor waste placed.", no refusal or rollback words, one FLOOR WASTE block and one FW text, one U back, Esc places nothing.
   2. **Gap 1, the duplicate tag is not shown to be in play.** The absence checks would also pass if CE never looked at the AGI tags. CE prints the proof; assert it. **Line:** `contains $fw "[CE] The source name 'AGI' is on 4 blocks. Nothing was stopped by it."`
   3. **Gap 2, BUG-147's route is "via endpoint claims".** This floor waste says "Nothing nearby", so no endpoint is claimed. **Lines:** probe one open pipe end on DRV1_B1 that an AGI-tagged block claims; then `type "CDFW{NL}<that x,y>" -Force -TimeoutSec 90 -> $fw3`, `wait`, ASSERT `contains $fw3 "Floor waste placed."`, `not-contains $fw3 "Nothing nearby"`, `not-contains $fw3 "rolled back"`, `not-contains $fw3 "more than one source"`.
   4. **Still part only:** CDSOURCE (named in BUG-147 and BUG-132) is never run; BUG-650 is not claimed.
8. **R37: CDPERIMETER draws PD1 (R2; BUG-217).** Verdict: **CLAUDE-ACCEPTED-READY** for "the prompts say perimeter drain, never AGI vertex or AGI drain; one PD1 text is drawn on the drain's layer; one U takes both back", on Civil 3.0.75.
   1. **Asks met:** five prompt and result lines pinned; `history absent` on both old AGI phrases over the whole case log; one polyline and one PD1 MText on AGI DRAIN; object count 1036 then back to 1034.
   2. **Red:** R37_BROKEN, a true red.
   3. **Not covered, so BUG-217 is not yet FIXED:** BUG-217's own confirm step is visual ("the drain is labelled PD1 on the plan"). A Codex look at the plan is still needed, and it should also say whether the "AG" linetype text still repeats along the drain.
   4. **Pinned as found, not as a ruling:** the drain and its tag are on layer AGI DRAIN. If Tim wants perimeter drains on a layer of their own, those two lines change.
9. **R37b: PD1 text follows MOVE and ERASE (R2; BUG-236).** Verdict: **PARTIAL.** It counts for move and erase only.
   1. **Asks met:** MOVE of the drain alone ("1 found") moves the PD1 text by exactly 1000 (y -79925 to -78925); ERASE of the drain leaves no PD1. A true red.
   2. **Not covered:** COPY (BUG-236 says a copy shows a second PD1; no card says what the copy should show, so probe and record before asserting), renumbering, and the text height from Settings (an R-00 item: find the key, then a `SETTING` twin that reads the MText height with `ent-read`).
10. **R38: Pit Schedule row P3 against the plan (S2/S3; claims BUG-376).** Verdict: **NEEDS STRONGER ASSERTION.** It does not prove BUG-376 yet.
    1. **Asks met:** the row P3 reads FROM P4, 17.30, 17.25, 18.88 in order; both numbers occur as IL texts somewhere on the plan; Close closes; file unchanged.
    2. **Gap 1, the levels are not tied to P3.** The plan holds 45 IL texts; 17.30 and 17.25 could sit at other pits. **Lines:** `select $m0 "text~^IL 17\.30$" -> $in_txt`, `select $m0 "text~^IL 17\.25$" -> $out_txt`, `dist $in_txt "53777.7,-25569.9" -> $d_in`, `dist $out_txt "53777.7,-25569.9" -> $d_out`, ASSERT `number $d_in < 2500` and `number $d_out < 2500`. Probe first how `dist` behaves when the select finds more than one text.
    3. **Gap 2, BUG-376's own condition is not shown.** DRV17_B1 (the bug's drawing) is byte-identical to DRV1_B1 (both 34BBE37C2EA4, I hashed them). On Civil 3.0.26 the same row read "from WT10, DIA 150, IL blank", with IL 18.10 drawn at the P3 end of the IO8 to P3 pipe. On 3.0.75 the row lists P4 instead. The row has changed which inlet it shows; whether the IO8 pipe's 18.10 is now in the schedule is not read. **Line:** probe the dump for an "18.10" cell in P3's rows; if present, assert it; if not, rename the plan item to "P3 row guard" and drop the BUG-376 claim.
11. **R39: CD, E on a plain line (N4; BUG-697).** Verdict: **NEEDS STRONGER ASSERTION.**
    1. **Asks met:** New Pipe opens; no "already a CE pipe" anywhere; one CE pipe; label AT 1 IN 101; IL 18.000 and 17.900. A true red.
    2. **Gap 1, the bug's expected line is not asserted.** **Line:** `history has "[CE] Using the drawn line (3 points) as the pipe route."` (R39b's runs show CE prints it; probe R39 once).
    3. **Gap 2, the other half of the expected behaviour.** BUG-697 says "only a line that already is a CE pipe gets the 'already a CE pipe' message". A fix that removed the check would pass R39 and let CD build a second pipe on top of an existing one. **Lines:** after the first pipe, `type "CD{NL}E{NL}152500,-96000" -Force -TimeoutSec 60 -> $cd2`, `esc-prompt -> $cd2e`, `wait`, `ms-new $c0 -> $after2`, `select $after2 "object~^CeCvlPipeObject$" -> $pipe2`. Replace `history absent "already a CE pipe"` with `history count "already a CE pipe" = 1` and add `count $pipe2 = 1`. Keep `not-contains $cd "already a CE pipe"`.
    4. **Small:** anchor the label check, `matches $lab_text "AT 1 IN 10[01]$"` (today "1 IN 1000" would also match).
12. **R39b: CD, E on an arc line and a closed line (N4; BUG-684).** Verdict: **CLAUDE-ACCEPTED-READY** for BUG-684 as written, on Civil 3.0.75.
    1. **Asks met:** both warnings pinned word for word; both source lines are still there as AcDbPolyline on BLOCKS with their own handles, different from the two new CE pipes (checked in the records, so a source turned into the pipe in place could not pass); one pipe, then two.
    2. **Red:** R39b_BROKEN, a true red (no arc: no warning and the line is replaced).
    3. **Engineering note, not a blocker:** the pipe still runs on the chords, with the chord length and grade, and CE warns. BUG-684's expected allows "refused (or warned about)", and Tim's rule R-27 is warn rather than block. If Tim wants curved routes refused instead, that is his call.
13. **R40: CDCHECKDWG summary and window (D28; C2, W2; BUG-606 half).** Verdict: **NEEDS CODEX LOOK.** Two passes, pictures saved; no Codex look written.
    1. **Asks met (deterministic part):** four CE lines, one summary line, the window opens and Close closes it, nothing new beside the drawing, file hash unchanged, the report path is under %APPDATA%\TIM_CE_CADTOOLS\logs\checkdwg.
    2. **The folder check has never been red.** R40_BROKEN's folder line passed both times. The real proof that the report went elsewhere is the "wrote report: ...TIM_CE_CADTOOLS..." line, and its flip did go red. Acceptable, but say so in the case.
    3. **BUG-606 cannot be written FIXED from this.** CV7-12 says reports go "only to an approved CE/project report location". Nothing I found records that the CE logs folder under AppData is that location: Unknown. BUG-606 item 3 also wants the window to say where the report went (a Codex look), and its retest asks for a separate external DWG and 2024. **The desk owns the location question** (ask Tim if it is not recorded).
    4. **D28 card step 4 now contradicts CE and BUG-606** ("F1 minus F0 is exactly one ..._CDCHECKDWG_<stamp>.txt"). Update the card after the location question is settled.
    5. **Cosmetic at the next edit (changes the hash):** fix the stale REVIEWED_AGAINST sentence and the backspace character in EXPECTED; drop C1 from any claim.

## For the runner owner (not case faults, listed so they are not lost)

1. **`folder-new-only` passes when nothing new appears.** A broken variant built on it can only go red if a file appears; R40_BROKEN's folder line could never fail on this build.
2. **Record the switches a fix depends on.** R34 ran with its fix switched off and was read as a broken fix. Let a case header name a setting key to read and print (value from Tim's file, or "absent, default <x>") in the report.
3. **Scan case files for C0 and C1 characters before a run.** R40 carries a backspace.
4. **Report wording:** "N AutoCAD sessions" should say how many cases each session held.
5. **Still open from earlier reviews:** a red only for `BUG` cases, case-blind text checks, the build stamp read before the lock wait, the cut close-windows record.

## What I did NOT check

1. **I ran nothing.** No AutoCAD, no runner. Every result is read from the ledger and the run reports.
2. **I looked at no picture.** R40's two pictures and the look note are untouched by me.
3. **The installed code** was read only for the R34 switch. I did not find out why R32b's arrow turns back.
4. **Tim's four settings files:** I relied on each run's end-of-session fingerprints (all equal) and read CD_Settings.json's hash (ACD64E79A33B) myself.
5. **The probe runs (p3b3prb*)** and the AutoCAD command-line log files were not read; the AutoCAD log of the R33 run could not be found, so CE's whole COPY sentence is not known to me.
6. **Not re-reviewed:** R01 to R30.

## Files written

1. `C:\CE_PLAN\areas\RUNNER_CASE_REVIEW_B3_2026-10-25.md` (this file).
2. `C:\Lisp Files\_ACAD_DRIVER\cases\R31_cd_uphill_levels_question_esc.review.txt` (case hash FF6655B9...).
3. `C:\Lisp Files\_ACAD_DRIVER\cases\R35_cdsl_typed_level_number_check.review.txt` (case hash 81C7A36F...).
4. `C:\Lisp Files\_ACAD_DRIVER\cases\R37_cdperimeter_draws_pd1_tag.review.txt` (case hash 60891583...).
5. `C:\Lisp Files\_ACAD_DRIVER\cases\R39b_cd_existing_arc_and_closed_line_kept.review.txt` (case hash CD1A7B6C...).

No review file for any other case.

## Summary

Of 13 new cases, 4 are Claude-accepted-ready on Civil 3.0.75: R31, R35, R37 and R39b. BUG-711 and BUG-684 may be written "FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026)". R32, R33, R36, R38 and R39 need stronger checks (exact lines given); R37b is part only; R40 needs a Codex look. R32b is a real fault and needs a new bug. R34 is real for Tim's setup, but BUG-665's fix is switched off, not broken. No new D-number; 6 of 40 accepted, 0 of them on 3.0.75.
