# Robot case fix-ups, STAGED not applied (Thu 29 Oct 2026, about 09:30 to 09:50 Melbourne)

Written by the Sonnet case-editing helper (CE 02 Robot and Codex Testing). Text editing and offline checks only. No AutoCAD started, no runner run, no live case, ledger, review slip, settings file or `CD_RecentValues.json` touched. Nothing committed or pushed.

## ANSWER FIRST

### FOR TIM

1. **Answer:** the whole edit pass is ready and sitting in `C:\ce-fx\c75fixups_staged\`. Nothing live has changed. 13 case files are edited and 1 new twin is added, in one pass, so one pair of fresh runs per case covers everything. All 14 read cleanly in the runner's offline checker (0 invalid). Nobody has run them in AutoCAD.
2. **What each edit does, in AutoCAD terms:**
   1. **ROTATE Copy of a pit (three cases):** each case now reads what the rotated copy's label actually says and checks it is not P3. A COPY should read P8, the next ROTATE Copy P11, a SCALE Copy P12.
   2. **Copy with layer 25TEXT locked:** the case now also checks that CE says "no cover text" (the sentence you will see is "1 copied pit(s) got their own number but no cover text: layer 25TEXT is locked ...").
   3. **Six cases that now pass** lose their old "expected to fail" tag: Edit Pipe second Save (R32), Edit Pipe size-only Save (R32b), the locked 25TEXT copy (R33m), and the three ROTATE Copy cases (R34, R34s, R34so). If one broke again tomorrow, the report would now show it as a real failure.
   4. **Two "switch OFF" twins:** the old one (R34s_OFF_BROKEN) now turns the new C-75 switch off as well, so it fails when it should. A new one (R34so_OFF_BROKEN) does the same for the ROTATE Copy about a point 5 m away.
   5. **Renumber (CDRENUMBER, N24):** three more checks: after "No" and after one U every one of the 11 plan labels is back as it was, and the X1 label is never touched.
3. **Cost, so you are not surprised:** editing a case changes its fingerprint, so the "accepted" status of R32, R32b, R33m, R34sn and N24 is withdrawn until each has two fresh passes and a fresh review slip. That was expected. The list of runs needed is in the detail section below (8 cases with 2 separate AutoCAD starts each, plus 6 twin or control runs), to be done in a free window (after 5:30 pm).
4. **What you need to do:** nothing. The floor-waste family (R36e) still waits for your ruling and was not touched, except that its switch-OFF control (C36e) got the one line that tells the gate it is a red for R36e.
5. **My mistakes first:**
   1. My first two attempts to run the offline checker failed because I typed the folder path wrongly in the shell. Nothing was checked and nothing was written. I redid it correctly in PowerShell.
   2. The job brief listed three edits as still to do (R34sn "different numbers", R34a "reads P8", R34s_OFF_BROKEN stray line). They were already applied at 02:33 by the first attempt. I confirmed that by hash and by diffing, and did not apply them twice.

---

## Detail (for the desk and the next runner chain)

### What I read first

1. `C:\TimOS\RULES.md`; the retry job `tester_run75b_b6_fixups_retry.txt` (edit list only); the B8 review "The cases" items 1 to 12; the B7 review item 2 for N24; every case, twin and control named below, in full; `case_runner.ps1` (validate, `Resolve-CaseAcceptance`) and `case_runner_lib.ps1` (header parser, `Test-CaseFile`, the `field`, `ent-read`, `select` steps and the `matches` and `contains` checks).
2. **First attempt's edits already in place (not re-applied):** R34sn (P8 and not-P8 lines), R34a (P8 line) and R34s_OFF_BROKEN (stray second VARIANT_OF line removed) changed at 02:33 and their live hashes equal the ones on the 3.0.85 ledger rows (F8A2788F0DEC, 62940EB2D771, 4E86F4E6AA55). The task-1 "two copies read different numbers" check is already there as `matches $scl "text.:.P(?!3.,)(?!8.,)[0-9]+.,.insertion"` in R34sn.

### Decisions I made, and why (so the reviewer can overrule)

1. **New checks are appended after the existing checks, never inserted before them**, so every existing check keeps its number (the B8 text quotes "checks 5, 6, 8, 10 and 11" for the controls; R33m "check 11" is still the `no label` check).
2. **A stopped step is not a red.** The gate (`from_check` in `case_runner.ps1`, line 406) counts a variant as a red only if it FAILS a check; a failure inside a STEP (text starts "step ") is not counted. If the ROTATE Copy has no label, `field` gives an empty handle and `ent-read` refuses ("ent-read needs a handle", `acad_driver_v3.ps1` line 1072), which would stop the case before any check ran. Consequences:
   1. **R34so_OFF_BROKEN does NOT copy the `ent-read` of the label.** It lists every plan label with `v3 ent-find ... -Part "STORMWATER PIT LABEL"` (the read N24 already uses, two passes on 3.0.85) and asserts `PIT_LABEL=P8` is present. With both switches off the copy gets no label, so P8 is absent and that check FAILS as a check. Its line, label-count and cover-count checks are word-for-word the R34so lines and fail the same way. If the reviewer would rather have a literal copy of R34so, say so: it would stop at the label read and the gate would not count it.
   2. **R34s_OFF_BROKEN is left with its old steps** (it never read the ROTATE label), only the one SETTING line is added, as you asked. Its extra checks therefore equal the old R34s checks, not the new P11 and P12 lines.
   3. **C34 (switch-OFF control of R34) was not regenerated.** Its steps do not contain the new label reads, so with both switches off it still fails in checks (labels 0, covers 0, one "numbered as new" line instead of three), which counts as a red. See decision 3.
3. **C34: I added `VARIANT_OF R34` (I did not leave it).** The B8 review allows leaving it if the R34 hash change made it a stale pair. It is a partial pair: C34 is a copy of the OLD R34 text, so it can prove the line, label and cover checks go red (the same lines are in the staged R34, unchanged and unrenumbered) but it cannot prove the three new P8, P11 and P12 checks go red. Those have no twin of their own in this pass. To prove them red the desk would need a twin that makes the copy read P3 (like R34sn_BROKEN); I did not build one because it was not on the edit list.
4. **Header text I changed besides the listed edits (words only, no check):** R34 NOT_AUTOMATED (the old "NUMBER is not read" line was false after the edit, replaced by the DERIVED note); R34s EXPECTED (shortened as B8 asks) and NOT_AUTOMATED, and the `record $ro_cover` caption; R34so EXPECTED (the line "the case is tagged EXPECT-FAIL BUG-665" would be false) and NOT_AUTOMATED; R34sn title, EXPECTED, NOT_AUTOMATED and one `record` caption; R33m comment (the "Expected to FAIL" sentence deleted, replaced by one sentence naming the 3.0.85 wording); N24 EXPECTED (adds X1 and the every-label sentence); R34s_OFF_BROKEN one new comment line. R32 and R32b: only the tag lines, their EXPECTED still mentions the 3.0.75 failure (left alone, not asked).
5. **DERIVED, as asked:** P8, P11 and P12 are the lowest free numbers on DRV1_B1 (P1 to P7, P9, P10 and C1 exist). Evidence for them: B8 and B7 (N24's label read and N29's schedule), R34a and R34sn passing with P8, and R34s reading P12 for its SCALE Copy in every 3.0.85 run. P11 for the ROTATE Copy after a COPY has NOT been read in any run (B8: "not found in any run record"); it is the reviewer's derivation. If the first runs read something else (for example P9 would mean the schedule's gap logic differs), the fault is the derivation, not CE, until checked against the card or code.

### Files, hashes and diffs

Hash = first 12 hex characters of SHA-256, upper case (as the runner and the reviews print them). "Live" is `C:\Lisp Files\_ACAD_DRIVER\cases\...`. I re-hashed every live file at the end: each still equals "before".

1. **N24** (`cases\`): before 323E733AB1AC, after 7F2B7FA6380D. 34 checks became 37.
2. **R32** (`cases\`): before B441549C8A69, after 4D0E972B30A0. 40 checks, unchanged.
3. **R32b** (`cases\`): before 047DC293DAD5, after 376E1339DCDE. 24 checks, unchanged.
4. **R34** (`cases\`): before 0537A7E7EE10, after 501FA33440EC. 21 checks became 27 (3 matches, 3 records), 32 steps became 38.
5. **R34s** (`cases\`): before 05D4BE8105FC, after 0E3BFB86FD9F. 26 checks became 29, 36 steps became 38.
6. **R34sn** (`cases\`): before F8A2788F0DEC, after 1D4831A6928F. Words only; 9 checks, 30 steps, unchanged.
7. **R34so** (`cases\`): before 82FDD260D756, after EE23DE4B4C4A. 11 checks became 13, 15 steps became 17.
8. **R33m** (`cases\variants\`): before F9DDB36AE114, after EC896953A560. 14 checks became 15.
9. **R34s_OFF_BROKEN** (`cases\variants\`): before 4E86F4E6AA55, after 80C7395910B5. 24 checks, unchanged.
10. **R34so_OFF_BROKEN** (`cases\variants\`, NEW): no before, after 457D71F074C4. 16 steps, 13 checks.
11. **C32** (`cases\controls\`, CRLF kept): before 92D29358DA73, after 51EB04625BB9. One line, `VARIANT_OF R32`.
12. **C33m** (`cases\controls\`, CRLF kept): before 6BA0CC743763, after 9DF1A38740AC. One line, `VARIANT_OF R33m`.
13. **C34** (`cases\controls\`, CRLF kept): before 4E34D5B89101, after 9167D25FDB10. One line, `VARIANT_OF R34`.
14. **C36e** (`cases\controls\`, CRLF kept): before 71BB3540DA97, after 895539A2D84B. One line, `VARIANT_OF R36e`.

Not edited, and why: **R34a** (already has the P8 line, 62940EB2D771 stays accepted), **R36e, R36e_p2, R36e_p3, R36e_p4** (wait for Tim's ruling), every other twin (R32_BROKEN, R32b_BROKEN, R34_NOCOPY_BROKEN, R34sn_BROKEN, R34a_NOU_BROKEN, N24_BROKEN: each keeps its `VARIANT_OF` line; N24_BROKEN does not carry the three new N24 lines, so those three have no twin of their own).

Unified diffs (live before to staged after; the controls are shown with line endings stripped; the new twin is shown against the staged R34so):

#### cases/N24_cdrenumber_plan_labels_one_by_one.case.txt
```diff
@@ -17,7 +17,7 @@
 BUG
 PROVES_BUGS
 REVIEWED_AGAINST
-EXPECTED On the untouched copy the plan labels read P1 to P7, P9, P10 and C1, and none reads P8. CDRENUMBER answered C1 then No prints 'Renumber cancelled - nothing changed.' and every label still reads what it read. CDRENUMBER answered C1 then Yes prints 'Renumbered 2 pit(s) downhill to uphill. One Undo restores the old numbers.'; the block that read P9 now reads P8, the block that read P10 now reads P9, no label reads P10 or a temporary id, and the blocks reading P1 to P7 and C1 are unchanged (109E08 still reads P3). One U echoes CDRENUMBER and the P9 and P10 blocks read P9 and P10 again; no label reads P8.
+EXPECTED On the untouched copy the plan labels read P1 to P7, P9, P10 and C1, and none reads P8. CDRENUMBER answered C1 then No prints 'Renumber cancelled - nothing changed.' and every label still reads what it read. CDRENUMBER answered C1 then Yes prints 'Renumbered 2 pit(s) downhill to uphill. One Undo restores the old numbers.'; the block that read P9 now reads P8, the block that read P10 now reads P9, no label reads P10 or a temporary id, and the blocks reading P1 to P7, C1 and X1 are unchanged (109E08 still reads P3). One U echoes CDRENUMBER and the P9 and P10 blocks read P9 and P10 again; no label reads P8. Added 29 Oct 2026 (Opus B7 review item 2): after No and after the U, EVERY plan label (all 11 blocks, handle by handle) reads exactly what it read before, and after Yes the X1 block is untouched.
 WHY_NOT_UNIT_TEST The network walk runs on the real drawing's pits and pipes and writes every plan label in one live command.
 NOT_AUTOMATED A TG mark is not in this fixture, so 'TG untouched' is not checked. Whether the numbering order is right as engineering is Tim's word.
 NOT_AUTOMATED DBMOD before and after the No answer is recorded, not judged (it is already 1 when the copy opens: N15).
@@ -69,6 +69,9 @@
   matches $ju "handle\W+([0-9A-F]{4,8})\W[^}]*PIT_LABEL=P9\W.*@@AFTER@@.*handle\W+\1\W[^}]*PIT_LABEL=P9\W"
   matches $ju "handle\W+([0-9A-F]{4,8})\W[^}]*PIT_LABEL=P10\W.*@@AFTER@@.*handle\W+\1\W[^}]*PIT_LABEL=P10\W"
   not-contains $lab2 "PIT_LABEL=P8"
+  matches $jn "\Whits\W+(\[.*?\}\])\}\}.*@@AFTER@@.*\Whits\W+\1\}\}"
+  matches $ju "\Whits\W+(\[.*?\}\])\}\}.*@@AFTER@@.*\Whits\W+\1\}\}"
+  matches $jy "handle\W+([0-9A-F]{4,8})\W[^}]*PIT_LABEL=X1\W.*@@AFTER@@.*handle\W+\1\W[^}]*PIT_LABEL=X1\W"
   record $m0 "DBMOD before CDRENUMBER No (not judged)"
   record $m1 "DBMOD after CDRENUMBER No (not judged; card D20 asks for it unchanged)"
   record $lab0 "FULL every plan label before (handle and PIT_LABEL)"
```

#### cases/R32_edit_pipe_reverse_levels_arrow_follows.case.txt
```diff
@@ -8,8 +8,7 @@
 ORDER 25
 PROVES_BUGS BUG-223 CDEDIT branch only; BUG-686 Edit Pipe zero-level branch only; BUG-1222 later plain Save regression. The CD branches are not covered. Detail: BUG-223 (CDEDIT on a pipe between two open ends, levels typed the other way round: the flow arrow follows the levels, the pipe is not left uphill without a plain warning); BUG-686 (the same with a level of exactly 0.00: the arrow follows the levels). BUG-261, BUG-292 and the size-only save are in R32b, not here.
 TIMEOUT 900
-BUG
-EXPECT-FAIL BUG-1222
+BUG BUG-1222
 REVIEWED_AGAINST builder-filled: Opus review still needed. Compared by the builder on 25 Oct 2026 with BUG-223 (steps: draw a pipe between two open ends, CDEDIT it, type the levels the other way round: not uphill without a plain warning) and BUG-686 (CD or Edit Pipe flow arrow, a level of exactly 0.00: the arrow follows the levels) as written in BUG_CARPARK.md.
 EXPECTED A new 20 m pipe with free ends and levels 18.000 / 17.900 has its flow arrow pointing from the first end to the second (arrow block rotation 0). CDEDIT with the levels typed 17.900 / 18.000 and Save prints "Pipe updated." and turns the arrow round (rotation about 3.1416: the pipe now falls from its second end), or says in plain words that the pipe flows uphill; it never ends uphill with no word. The same for a second pipe drawn 0.50 / 0.00 and edited to 0.00 / 0.50. The IL texts read the typed levels at the ends (IL 17.900 left and IL 18.000 right; IL 0.00 left and IL 0.50 right). No CE window is left open and the drawing file on disk is unchanged. Second, independent check (batch 3 review, 25 Oct): the left IL text (17.900 and 0.00) sits west of the pipe's middle (x below 160000) and the right one (18.000 and 0.50) east of it, and after a SECOND plain Edit Pipe save (nothing typed) the arrow is still turned round (rotation about 3.1416), so the first turn was a real change of direction, not only a redraw. On Civil 3.0.75 that last check is expected to FAIL: BUG-1222 (a later save turns the flipped arrow back).
 WHY_NOT_UNIT_TEST The levels, the arrow block and the IL texts are rewritten by the live Edit Pipe save into the real drawing.
```

#### cases/R32b_edit_pipe_size_only_keeps_arrow.case.txt
```diff
@@ -6,8 +6,7 @@
 FIXTURE DRV1_B1
 SLOT fresh
 ORDER 26
-BUG
-EXPECT-FAIL BUG-1222
+BUG BUG-1222
 PROVES_BUGS BUG-1222 size-only Save branch; the later plain Save branch is R32. BUG-260, BUG-261 and BUG-292 are related, not proved.
 TIMEOUT 900
 REVIEWED_AGAINST builder-filled: Opus review still needed. Compared by the builder on 25 Oct 2026 with BUG-292 (a downstream-first pipe could be reversed by a plain Save), BUG-261 (size-only save of a two-free-end pipe whose arrow follows the levels) and BUG-260 (arrow, labels and header disagree) as written in BUG_CARPARK.md. The reversed state is reached through Edit Pipe, not through the CD direction question as in BUG-261, the owner is BUG-1222 (filed 25 Oct 2026); BUG-260, BUG-261 and BUG-292 are related, not proved (BUG-261 starts through the CD direction question, BUG-292 concerns absent stored drawn-end levels, BUG-260 includes pits and the schedule).
```

#### cases/R34_copy_rotate_scale_pit_gets_own_number.case.txt
```diff
@@ -1,20 +1,19 @@
 # R34 = group M3 (COPY makes a real CE copy: new number, no twin, labels come with it) of BUG_REGISTER_TRIAGE_2026-10-24 (A1), daily card D15. Route read on 25 Oct 2026 (probe PRBD1, Civil 3.0.75): pick-first 109D56 then typed "_.COPY{NL}0,0{NL}0,-5000{NL}{NL}", "_.ROTATE{NL}53777.7,-25569.9{NL}C{NL}90{NL}" and "_.SCALE{NL}53777.7,-25569.9{NL}C{NL}1.5{NL}". A plain COPY printed "1 pit copied and numbered as new. Check levels: ..." and added the pit block and a PIT LABEL block; the ROTATE Copy and SCALE Copy each added ONLY a pit block (no PIT LABEL, no CE line).
 CASE R34
 TITLE COPY, ROTATE Copy and SCALE Copy of pit P3 each make a real CE pit: a CE line says it was numbered as new and the copy comes with its own PIT LABEL
-PLAN_ITEM BUG-665 reproduction only: COPY control and missing labels after ROTATE Copy and SCALE Copy with the switch OFF; D15 not proved
+PLAN_ITEM BUG-665 part: pit COPY, ROTATE Copy and SCALE Copy with shipped defaults (old Settings tick OFF, new switch linking.rotateScaleCopyLikeCopy ON); D15 is case R34a
 KIND deterministic
 FIXTURE DRV1_B1
 SLOT fresh
 SETTING CD_Settings.json linking.cleanUpGripRotateScaleCopies false
 ORDER 33
-BUG
-EXPECT-FAIL BUG-665
+BUG BUG-665
 PROVES_BUGS
 TIMEOUT 900
 REVIEWED_AGAINST builder-filled: Opus review still needed. Compared by the builder on 25 Oct 2026 with BUG-665 in BUG_CARPARK.md (Grip-Ctrl copy, ROTATE Copy and SCALE Copy of a pit or pipe: expected "the copy gets the same clean-up a COPY gets: new pit number, own labels, own record") and daily card D15 (COPY: "1 pit copied and numbered as new", new pit number, one U). The Grip-Ctrl copy of BUG-665 is not driven. BUG-210, BUG-288, BUG-666 and BUG-671 (other COPY faults of group M3) are not claimed.
 EXPECTED The plain COPY of pit P3 (the control) prints "1 pit copied and numbered as new." and adds one pit block (layer STORMWATER PIT) and one PIT LABEL block (layer STORMWATER PIT LABEL). ROTATE Copy by 90 degrees and SCALE Copy by 1.5 of the same pit must each give the same: a CE line saying one pit was copied and numbered as new, and one new PIT LABEL block beside the new pit block, so the copy has a number of its own and is not a twin of P3.
 WHY_NOT_UNIT_TEST The copy clean-up runs when AutoCAD ends the native COPY, ROTATE or SCALE command on the live drawing.
-NOT_AUTOMATED The new pit's NUMBER is not read (the PIT LABEL attribute is not exposed by the object read, and the Pit Schedule cells are not asserted): the case reads the CE line and the presence of the label block. The Grip-Ctrl copy of BUG-665 is not driven.
+NOT_AUTOMATED DERIVED (29 Oct 2026 fix-up, Opus B8 review item 1): the three label readings are taken from the first free numbers on this test drawing, not from a card line that guarantees them. The other pit numbers on DRV1_B1 are P1 to P7, P9, P10 and C1, so the first copy takes the one gap P8, the next copy takes the next free number P11 and the third P12 (R34s reads P12 for its SCALE Copy in every run; R34a reads P8 for a plain COPY). The Pit Schedule cells are not asserted. The Grip-Ctrl copy of BUG-665 is not driven.
 NOT_AUTOMATED If the rotated or scaled copy gets its label a few seconds after the command, the 8 second wait here would show it; a later label would not be seen.
 STEPS
   copy-info -> $copy0
@@ -28,6 +27,8 @@
   select $new_cp "name~^PIT BLOCK" -> $cp_pit
   select $new_cp "name~^PIT LABEL" -> $cp_label
   select $new_cp "text~^CL " -> $cp_cover
+  field $cp_label handle -> $hcp
+  ent-read {$hcp} -> $cpl
   pick-first "109D56"
   type "_.ROTATE{NL}53777.7,-25569.9{NL}C{NL}90{NL}" -Force -> $ro
   wait
@@ -38,6 +39,8 @@
   select $new_ro "name~^PIT BLOCK" -> $ro_pit
   select $new_ro "name~^PIT LABEL" -> $ro_label
   select $new_ro "text~^CL " -> $ro_cover
+  field $ro_label handle -> $hro
+  ent-read {$hro} -> $rol
   pick-first "109D56"
   type "_.SCALE{NL}53777.7,-25569.9{NL}C{NL}1.5{NL}" -Force -> $sc
   wait
@@ -48,6 +51,8 @@
   select $new_sc "name~^PIT BLOCK" -> $sc_pit
   select $new_sc "name~^PIT LABEL" -> $sc_label
   select $new_sc "text~^CL " -> $sc_cover
+  field $sc_label handle -> $hsc
+  ent-read {$hsc} -> $scl
   windows-snapshot -> $win_end
 ASSERT
   contains $cp "1 pit copied and numbered as new."
@@ -63,6 +68,12 @@
   count $sc_cover = 1
   not-contains $win_end "Creative Engineering"
   copy-unchanged $copy0
+  matches $cpl "text.:.P8.,.insertion"
+  matches $rol "text.:.P11.,.insertion"
+  matches $scl "text.:.P12.,.insertion"
+  record $cpl "FULL the COPY's PIT LABEL"
+  record $rol "FULL the ROTATE Copy's PIT LABEL"
+  record $scl "FULL the SCALE Copy's PIT LABEL"
   record $cp "FULL COPY (control)"
   record $new_cp "FULL objects the COPY added"
   record $ro "FULL ROTATE Copy"
```

#### cases/R34s_copy_rotate_scale_pit_switch_on.case.txt
```diff
@@ -1,20 +1,19 @@
 # R34s = the switched-ON twin of R34 (BUG-665). The batch 3 review of 25 Oct 2026 found that R34's failure is not a broken fix: the clean-up of ROTATE Copy and SCALE Copy sits behind the Settings tick linking.cleanUpGripRotateScaleCopies, which is OFF by default and absent from Tim's CD_Settings.json. R34s runs R34's route with that tick ON (set through the v2 settings guard before AutoCAD starts, put back by hash afterwards) to show whether the fix works when it is switched on. Grip Ctrl-drag is not driven.
 CASE R34s
 TITLE With the Settings tick "Clean up grip Ctrl-drag, ROTATE Copy and SCALE Copy like COPY" switched ON, ROTATE Copy and SCALE Copy of pit P3 each make a real CE pit: a CE line says it was numbered as new and the copy comes with its own PIT LABEL
-PLAN_ITEM BUG-665 part only: pit COPY, ROTATE Copy and SCALE Copy label creation with the switch ON; independent records, pipes, grip copies and whole D15 not proved
+PLAN_ITEM BUG-665 part only: pit COPY, ROTATE Copy and SCALE Copy label creation and label numbers with the old Settings tick ON; independent records, pipes, grip copies and whole D15 not proved
 KIND deterministic
 FIXTURE DRV1_B1
 SLOT fresh
 SETTING CD_Settings.json linking.cleanUpGripRotateScaleCopies true
 ORDER 34
 BUG BUG-665
-EXPECT-FAIL BUG-665
 PROVES_BUGS
 TIMEOUT 900
 REVIEWED_AGAINST
-EXPECTED With linking.cleanUpGripRotateScaleCopies true in CD_Settings.json when AutoCAD starts, the plain COPY of pit P3 prints "1 pit copied and numbered as new." and adds one pit block and one PIT LABEL block (as R34's control); ROTATE Copy by 90 degrees and SCALE Copy by 1.5 of the same pit must each give the same: a CE line saying one pit was copied and numbered as new, and one new PIT LABEL block beside the new pit block. The case also RECORDS (never judges) whether each copy gets a cover text ("CL ...") and what the PIT LABEL of each copy reads. Result of the first runs (b3v1, 25 Oct 2026, Civil 3.0.75, switch ON): the plain COPY and the SCALE Copy get a PIT LABEL, a cover text "CL 18.88" and the "numbered as new" line, but the ROTATE Copy about the pit's own centre gets the "numbered as new" line and a pit block and NO PIT LABEL and NO cover text, so this case FAILS on the rotate label check (tagged EXPECT-FAIL BUG-665). R34so shows whether a ROTATE Copy about a point elsewhere does better. If this ever passes in two sessions the ROTATE Copy / SCALE Copy half of BUG-665 works when the switch is on, and R34 (switch off) is its true red. The drawing file on disk is unchanged.
+EXPECTED With linking.cleanUpGripRotateScaleCopies true in CD_Settings.json when AutoCAD starts (and the shipped new switch linking.rotateScaleCopyLikeCopy ON), the plain COPY of pit P3 prints "1 pit copied and numbered as new." and adds one pit block and one PIT LABEL block (as R34's control); ROTATE Copy by 90 degrees and SCALE Copy by 1.5 of the same pit must each give the same: a CE line saying one pit was copied and numbered as new, one new PIT LABEL block beside the new pit block and one cover text (CL ...). The three PIT LABELs read P8 (COPY), P11 (ROTATE Copy) and P12 (SCALE Copy), the first free numbers on this drawing (DERIVED), never P3. History: on Civil 3.0.75 to 3.0.84 the ROTATE Copy about the pit's own centre got no PIT LABEL and no cover text (BUG-665); Civil 3.0.85 (C-75) fixes it. The drawing file on disk is unchanged.
 WHY_NOT_UNIT_TEST The copy clean-up runs when AutoCAD ends the native COPY, ROTATE or SCALE command on the live drawing, and the switch is read from the real settings file when AutoCAD starts.
-NOT_AUTOMATED Grip Ctrl-drag copy (the other half of BUG-665) is not driven. Whether the new pit NUMBER differs from P3 is read from the PIT LABEL block in R34sn, not here.
+NOT_AUTOMATED Grip Ctrl-drag copy (the other half of BUG-665) is not driven. DERIVED (29 Oct 2026 fix-up, Opus B8 review item 2): the exact labels P8 (COPY), P11 (ROTATE Copy) and P12 (SCALE Copy) are the first free numbers on this test drawing (the other pit numbers on DRV1_B1 are P1 to P7, P9, P10 and C1), not a card line that guarantees them; R34sn reads the COPY and SCALE Copy numbers in a case of their own.
 NOT_AUTOMATED The switch is set only for this case's AutoCAD session; Tim's file is restored by hash. Whether the office should switch the tick on is Tim's decision (Monday question 8).
 STEPS
   copy-info -> $copy0
@@ -40,6 +39,8 @@
   select $new_ro "name~^PIT BLOCK" -> $ro_pit
   select $new_ro "name~^PIT LABEL" -> $ro_label
   select $new_ro "text~^CL " -> $ro_cover
+  field $ro_label handle -> $hro
+  ent-read {$hro} -> $rol
   pick-first "109D56"
   type "_.SCALE{NL}53777.7,-25569.9{NL}C{NL}1.5{NL}" -Force -> $sc
   wait
@@ -69,9 +70,12 @@
   matches $scl "text.:.P(?!3.,)[0-9]+.,.insertion"
   not-contains $win_end "Creative Engineering"
   copy-unchanged $copy0
+  matches $rol "text.:.P11.,.insertion"
+  matches $scl "text.:.P12.,.insertion"
+  record $rol "FULL the ROTATE Copy's PIT LABEL"
   record $cpl "FULL the COPY's PIT LABEL"
   record $scl "FULL the SCALE Copy's PIT LABEL"
-  record $ro_cover "how many cover texts (CL) the ROTATE Copy added (0 while BUG-665 stands; the ROTATE label cannot be read while it is missing, so its number is not asserted here)"
+  record $ro_cover "how many cover texts (CL) the ROTATE Copy added (asserted to be 1 above)"
   record $cp "FULL COPY (control)"
   record $new_cp "FULL objects the COPY added"
   record $ro "FULL ROTATE Copy"
```

#### cases/R34sn_copy_rotate_scale_pit_number_switch_on.case.txt
```diff
@@ -1,6 +1,6 @@
 # R34sn = R34s's number half (BUG-665 with the switch ON, daily card D15 assertion 2): what each copy's PIT LABEL reads. Kept apart from R34s so that a copy with no label (switch not working) cannot hide R34s's counts. The label is read with ent-read like R33 and R35 (probe on 25 Oct 2026).
 CASE R34sn
-TITLE With the Settings tick "Clean up grip Ctrl-drag, ROTATE Copy and SCALE Copy like COPY" switched ON, the copies of pit P3 made by COPY and by SCALE Copy each carry a pit number of their own (not P3) (the ROTATE Copy adds no label to read: see R34s)
+TITLE With the Settings tick "Clean up grip Ctrl-drag, ROTATE Copy and SCALE Copy like COPY" switched ON, the copies of pit P3 made by COPY and by SCALE Copy each carry a pit number of their own (not P3) (the ROTATE Copy label number is read in R34, R34s and R34so)
 PLAN_ITEM BUG-665 part only: the COPY and SCALE Copy labels each read a P number other than P3, switch ON; D15 is case R34a
 KIND deterministic
 FIXTURE DRV1_B1
@@ -11,9 +11,9 @@
 PROVES_BUGS
 TIMEOUT 900
 REVIEWED_AGAINST
-EXPECTED With the tick ON when AutoCAD starts, the PIT LABEL of the COPY and of the SCALE Copy of pit P3 each reads a pit number that is not P3 (the ROTATE Copy label count is recorded, not judged). The drawing file on disk is unchanged.
+EXPECTED With the tick ON when AutoCAD starts, the PIT LABEL of the COPY and of the SCALE Copy of pit P3 each reads a pit number that is not P3 (the ROTATE Copy label count is recorded here, not judged; its number is read in R34, R34s and R34so). The drawing file on disk is unchanged.
 WHY_NOT_UNIT_TEST The number is given by the live COPY / ROTATE / SCALE clean-up and read back from the PIT LABEL block in the real drawing.
-NOT_AUTOMATED DERIVED (29 Oct 2026 fix-up, Opus B6 review item 6): the COPY label reading exactly P8 is taken from the first free number on this test drawing (the other pit numbers on DRV1_B1 are P1 to P7, P9 and P10 and C1, so P8 is the one gap), not from a card line that guarantees P8; the SCALE label is only checked to differ from P3 and from the COPY label (P8), so the two copies cannot share a number. The ROTATE Copy of pit P3 about its own centre (the route R34 uses) adds NO PIT LABEL even with the tick ON (run b3v1, 25 Oct 2026), so its number cannot be read: that is R34s's red, and the label count is only recorded here. Grip Ctrl-drag copy is not driven. Which number each copy should get (P12, P13, ...) is not asserted: only that it is a number of its own.
+NOT_AUTOMATED DERIVED (29 Oct 2026 fix-up, Opus B6 review item 6): the COPY label reading exactly P8 is taken from the first free number on this test drawing (the other pit numbers on DRV1_B1 are P1 to P7, P9 and P10 and C1, so P8 is the one gap), not from a card line that guarantees P8; the SCALE label is only checked to differ from P3 and from the COPY label (P8), so the two copies cannot share a number. The ROTATE Copy of pit P3 about its own centre (the route R34 uses) added NO PIT LABEL even with the tick ON on Civil 3.0.75 to 3.0.84 (run b3v1, 25 Oct 2026); since Civil 3.0.85 (C-75) it does, and its number is read and asserted in R34, R34s and R34so, so the label count is only recorded here. Grip Ctrl-drag copy is not driven. Which number each copy should get (P12, P13, ...) is not asserted: only that it is a number of its own.
 STEPS
   copy-info -> $copy0
   ms-count -> $c0
@@ -53,5 +53,5 @@
   not-contains $win_end "Creative Engineering"
   copy-unchanged $copy0
   record $cpl "FULL the COPY's PIT LABEL"
-  record $ro_label "how many PIT LABEL blocks the ROTATE Copy added (0 on 3.0.75: it is the fault R34s shows)"
+  record $ro_label "how many PIT LABEL blocks the ROTATE Copy added (recorded, not judged; 1 since Civil 3.0.85, 0 on 3.0.75 to 3.0.84)"
   record $scl "FULL the SCALE Copy's PIT LABEL"
```

#### cases/R34so_rotate_copy_pit_offset_switch_on.case.txt
```diff
@@ -8,13 +8,12 @@
 SETTING CD_Settings.json linking.cleanUpGripRotateScaleCopies true
 ORDER 36
 BUG BUG-665
-EXPECT-FAIL BUG-665
 PROVES_BUGS
 TIMEOUT 900
 REVIEWED_AGAINST
-EXPECTED (First result, b3v2 of 25 Oct 2026 on Civil 3.0.75: the copy gets the "numbered as new" line and a pit block but NO PIT LABEL and NO cover text, also when the copy lands 5 m away, so the missing label belongs to ROTATE Copy itself, not to a copy sitting on top of its original; the case is tagged EXPECT-FAIL BUG-665.) With the tick ON when AutoCAD starts, ROTATE Copy of P3 by 90 degrees about 58777.7,-25569.9 prints "1 pit copied and numbered as new." and adds one pit block, one PIT LABEL block and one cover text (CL ...) for the copy. The drawing file on disk is unchanged.
+EXPECTED (History: b3v2 of 25 Oct 2026 on Civil 3.0.75 to 3.0.84: the copy got the "numbered as new" line and a pit block but NO PIT LABEL and NO cover text, also when the copy landed 5 m away, so the missing label belonged to ROTATE Copy itself, not to a copy sitting on top of its original (BUG-665); Civil 3.0.85, C-75, fixes it.) With the tick ON when AutoCAD starts, ROTATE Copy of P3 by 90 degrees about 58777.7,-25569.9 prints "1 pit copied and numbered as new." and adds one pit block, one PIT LABEL block and one cover text (CL ...) for the copy, and the copy's PIT LABEL reads P8, not P3 (DERIVED: it is the first copy on the drawing, and P8 is the one free number among P1 to P7, P9, P10 and C1). The drawing file on disk is unchanged.
 WHY_NOT_UNIT_TEST The copy clean-up runs when AutoCAD ends the native ROTATE command on the live drawing, and the switch is read from the real settings file when AutoCAD starts.
-NOT_AUTOMATED Grip Ctrl-drag copy is not driven. The copy's number is not read here (R34sn reads the COPY and SCALE numbers).
+NOT_AUTOMATED Grip Ctrl-drag copy is not driven. DERIVED (29 Oct 2026 fix-up, Opus B8 review item 3): the copy's label reading exactly P8 is the first free number on this test drawing (the other pit numbers on DRV1_B1 are P1 to P7, P9, P10 and C1), not a card line that guarantees it. R34sn reads the COPY and SCALE Copy numbers.
 STEPS
   copy-info -> $copy0
   ms-count -> $c0
@@ -30,6 +29,8 @@
   field $ro_pit y -> $ry
   select $new_ro "name~^PIT LABEL" -> $ro_label
   select $new_ro "text~^CL " -> $ro_cover
+  field $ro_label handle -> $hro
+  ent-read {$hro} -> $rol
   windows-snapshot -> $win_end
 ASSERT
   contains $ro "1 pit copied and numbered as new."
@@ -40,6 +41,8 @@
   number $ry = -30569.9 +- 1
   not-contains $win_end "Creative Engineering"
   copy-unchanged $copy0
+  matches $rol "text.:.P8.,.insertion"
+  record $rol "FULL the ROTATE Copy's PIT LABEL"
   record $ro "FULL ROTATE Copy about a point 5 m away"
   record $roe "FULL after the wait"
   record $new_ro "FULL objects the ROTATE Copy added"
\ No newline at end of file
```

#### variants/R33m_copy_message_does_not_claim_no_label.case.txt
```diff
@@ -1,4 +1,4 @@
-# R33m (batch 6, 28 Oct 2026, Codex cx_cr08 item 3.5 and cx_cr21): the MESSAGE half of BUG-672, split out of R33. COPY of pit P3 with only the cover-text layer 25TEXT locked: CE copies the pit and draws its number label, so the reply must NOT say "no label". On Civil 3.0.75 to 3.0.78 the reply says "got their own number but no label or cover text", which is wrong. Expected to FAIL until the sentence is corrected.
+# R33m (batch 6, 28 Oct 2026, Codex cx_cr08 item 3.5 and cx_cr21): the MESSAGE half of BUG-672, split out of R33. COPY of pit P3 with only the cover-text layer 25TEXT locked: CE copies the pit and draws its number label, so the reply must NOT say "no label". On Civil 3.0.75 to 3.0.78 the reply said "got their own number but no label or cover text", which was wrong; Civil 3.0.85 says "got their own number but no cover text" (C-75, BUG-672).
 CASE R33m
 TITLE COPY of a pit with 25TEXT locked: the reply names layer 25TEXT and says what to do, and does not claim the copy has no label
 PLAN_ITEM Native protection rule: locked pit text layers (triage group L1); BUG-672 message half
@@ -7,7 +7,6 @@
 SLOT fresh
 ORDER 32
 BUG BUG-672
-EXPECT-FAIL BUG-672
 PROVES_BUGS BUG-672 message half only (the sentence about the skipped cover text); the copy behaviour half is R33
 TIMEOUT 600
 REVIEWED_AGAINST
@@ -50,6 +49,7 @@
   not-contains $win_end "Creative Engineering"
   copy-unchanged $copy0
   not-contains $cp1 "no label"
+  contains $cp1 "got their own number but no cover text"
   record $cp1 "FULL COPY with 25TEXT locked"
   record $cpl "FULL the copied pit's label"
   record $u1 "FULL what U echoed"
\ No newline at end of file
```

#### variants/R34s_off_broken.case.txt
```diff
@@ -1,4 +1,5 @@
 # R34s_OFF_BROKEN (batch 6, 28 Oct 2026, Codex cx_cr22 item 3.4): the formal OFF twin of R34s: the same steps and the same label, cover-text and number checks with linking.cleanUpGripRotateScaleCopies false, so the ROTATE Copy and SCALE Copy checks must FAIL.
+# 29 Oct 2026 fix-up (Opus B8 review item 4): since Civil 3.0.85 (C-75) the new switch linking.rotateScaleCopyLikeCopy (default ON) also makes ROTATE Copy and SCALE Copy copy, so this twin turns BOTH switches off; with only the old tick off it passed when it should fail.
 CASE R34s_OFF_BROKEN
 TITLE BROKEN VARIANT of R34s: the Settings tick is OFF, so ROTATE Copy and SCALE Copy get no clean-up (must FAIL)
 PLAN_ITEM red-before-green proof for R34s (the switch)
@@ -6,6 +7,7 @@
 FIXTURE DRV1_B1
 SLOT fresh
 SETTING CD_Settings.json linking.cleanUpGripRotateScaleCopies false
+SETTING CD_Settings.json linking.rotateScaleCopyLikeCopy false
 ORDER 97
 BUG
 EXPECT-FAIL BROKEN-VARIANT
```

#### controls/C32_edit_pipe_arrow_switch_off.case.txt
```diff
@@ -12,6 +12,7 @@
 TIMEOUT 900
 BUG
 EXPECT-FAIL BUG-1222
+VARIANT_OF R32
 REVIEWED_AGAINST builder-filled: Opus review still needed. Compared by the builder on 25 Oct 2026 with BUG-223 (steps: draw a pipe between two open ends, CDEDIT it, type the levels the other way round: not uphill without a plain warning) and BUG-686 (CD or Edit Pipe flow arrow, a level of exactly 0.00: the arrow follows the levels) as written in BUG_CARPARK.md.
 EXPECTED A new 20 m pipe with free ends and levels 18.000 / 17.900 has its flow arrow pointing from the first end to the second (arrow block rotation 0). CDEDIT with the levels typed 17.900 / 18.000 and Save prints "Pipe updated." and turns the arrow round (rotation about 3.1416: the pipe now falls from its second end), or says in plain words that the pipe flows uphill; it never ends uphill with no word. The same for a second pipe drawn 0.50 / 0.00 and edited to 0.00 / 0.50. The IL texts read the typed levels at the ends (IL 17.900 left and IL 18.000 right; IL 0.00 left and IL 0.50 right). No CE window is left open and the drawing file on disk is unchanged. Second, independent check (batch 3 review, 25 Oct): the left IL text (17.900 and 0.00) sits west of the pipe's middle (x below 160000) and the right one (18.000 and 0.50) east of it, and after a SECOND plain Edit Pipe save (nothing typed) the arrow is still turned round (rotation about 3.1416), so the first turn was a real change of direction, not only a redraw. On Civil 3.0.75 that last check is expected to FAIL: BUG-1222 (a later save turns the flipped arrow back).
 WHY_NOT_UNIT_TEST The levels, the arrow block and the IL texts are rewritten by the live Edit Pipe save into the real drawing.
```

#### controls/C33m_copy_message_switch_off.case.txt
```diff
@@ -10,6 +10,7 @@
 ORDER 9332
 BUG BUG-672
 EXPECT-FAIL BUG-672
+VARIANT_OF R33m
 PROVES_BUGS BUG-672 message half only (the sentence about the skipped cover text); the copy behaviour half is R33
 TIMEOUT 600
 REVIEWED_AGAINST
```

#### controls/C34_rotate_copy_switch_off.case.txt
```diff
@@ -11,6 +11,7 @@
 ORDER 9341
 BUG
 EXPECT-FAIL BUG-665
+VARIANT_OF R34
 PROVES_BUGS
 TIMEOUT 900
 REVIEWED_AGAINST builder-filled: Opus review still needed. Compared by the builder on 25 Oct 2026 with BUG-665 in BUG_CARPARK.md (Grip-Ctrl copy, ROTATE Copy and SCALE Copy of a pit or pipe: expected "the copy gets the same clean-up a COPY gets: new pit number, own labels, own record") and daily card D15 (COPY: "1 pit copied and numbered as new", new pit number, one U). The Grip-Ctrl copy of BUG-665 is not driven. BUG-210, BUG-288, BUG-666 and BUG-671 (other COPY faults of group M3) are not claimed.
```

#### controls/C36e_cdfw_opening_switch_off.case.txt
```diff
@@ -12,6 +12,7 @@
 TIMEOUT 600
 BUG
 EXPECT-FAIL BUG-1223
+VARIANT_OF R36e
 REVIEWED_AGAINST builder-filled: BUG-1223 in BUG_CARPARK.md; independent review required for the revised hash; BUG-147 is related only.
 EXPECTED CDFW with the point 51777.389,-46593.223 (inspection opening 108F55, on pipe ends) prints "Floor waste placed." and adds exactly one FLOOR WASTE block and one text FW; it does not print "A nearby pipe's Civil record changed", "rolled back" or "more than one source". The drawing file on disk is unchanged.
 WHY_NOT_UNIT_TEST The claim of a pipe end by a block runs against the real pits, pipes and tagged blocks of the live drawing.
```

#### variants/R34so_off_broken.case.txt (NEW FILE; diff against the staged R34so)
```diff
@@ -1,19 +1,22 @@
-# R34so = a probe-shaped twin of R34s (batch 3 fixes, 25 Oct 2026): ROTATE Copy of pit P3 about a base point 5 m EAST of the pit (58777.7,-25569.9) instead of the pit's own centre, with linking.cleanUpGripRotateScaleCopies ON. In R34s the ROTATE Copy about the pit's own centre added a pit block and the 'numbered as new' line but NO PIT LABEL and no cover text (a SCALE Copy about the same centre got both). This case shows whether the missing label belongs to ROTATE Copy itself or to a copy that lands on top of its original.
-CASE R34so
-TITLE With the Settings tick ON, a ROTATE Copy of pit P3 about a point 5 m away (so the copy lands elsewhere) comes with its own PIT LABEL and cover text
-PLAN_ITEM BUG-665 part only: ROTATE Copy of pit P3 about a pivot 5 m east with the switch ON; number, record, pipes, grip copies and D15 plain COPY/U not proved
+# R34so_OFF_BROKEN (29 Oct 2026 fix-up, Opus B8 review item 3): the formal OFF twin of R34so: the same ROTATE Copy of pit P3 about a point 5 m east, with BOTH copy switches turned OFF (the older tick linking.cleanUpGripRotateScaleCopies and the C-75 switch linking.rotateScaleCopyLikeCopy), so the copy gets no "numbered as new" line, no PIT LABEL and no cover text and the checks must FAIL. A copy with no PIT LABEL has nothing for ent-read to open (a step would stop before any check), so the number check here reads every plan label with ent-find and looks for P8, the number the ON case reads from the copy itself; with the switches off no label reads P8. The pit position checks stay (AutoCAD rotates the pit itself).
+CASE R34so_OFF_BROKEN
+TITLE BROKEN VARIANT of R34so: both copy switches are OFF, so the ROTATE Copy gets no CE line, no PIT LABEL, no cover text and no P8 (must FAIL)
+PLAN_ITEM red-before-green proof for R34so (the two switches)
 KIND deterministic
 FIXTURE DRV1_B1
 SLOT fresh
-SETTING CD_Settings.json linking.cleanUpGripRotateScaleCopies true
-ORDER 36
-BUG BUG-665
+SETTING CD_Settings.json linking.cleanUpGripRotateScaleCopies false
+SETTING CD_Settings.json linking.rotateScaleCopyLikeCopy false
+ORDER 99
+BUG
+EXPECT-FAIL BROKEN-VARIANT
+VARIANT_OF R34so
 PROVES_BUGS
 TIMEOUT 900
 REVIEWED_AGAINST
-EXPECTED (History: b3v2 of 25 Oct 2026 on Civil 3.0.75 to 3.0.84: the copy got the "numbered as new" line and a pit block but NO PIT LABEL and NO cover text, also when the copy landed 5 m away, so the missing label belonged to ROTATE Copy itself, not to a copy sitting on top of its original (BUG-665); Civil 3.0.85, C-75, fixes it.) With the tick ON when AutoCAD starts, ROTATE Copy of P3 by 90 degrees about 58777.7,-25569.9 prints "1 pit copied and numbered as new." and adds one pit block, one PIT LABEL block and one cover text (CL ...) for the copy, and the copy's PIT LABEL reads P8, not P3 (DERIVED: it is the first copy on the drawing, and P8 is the one free number among P1 to P7, P9, P10 and C1). The drawing file on disk is unchanged.
+EXPECTED This variant is wrong on purpose: with both switches OFF the ROTATE Copy of pit P3 about 58777.7,-25569.9 prints no "1 pit copied and numbered as new." line and adds a pit block but NO PIT LABEL and NO cover text, and no plan label reads P8, so the line, label, cover and P8 checks of R34so fail. The pit position checks still pass.
 WHY_NOT_UNIT_TEST The copy clean-up runs when AutoCAD ends the native ROTATE command on the live drawing, and the switch is read from the real settings file when AutoCAD starts.
-NOT_AUTOMATED Grip Ctrl-drag copy is not driven. DERIVED (29 Oct 2026 fix-up, Opus B8 review item 3): the copy's label reading exactly P8 is the first free number on this test drawing (the other pit numbers on DRV1_B1 are P1 to P7, P9, P10 and C1), not a card line that guarantees it. R34sn reads the COPY and SCALE Copy numbers.
+NOT_AUTOMATED The switches are set only for this case's AutoCAD session; Tim's file is restored by hash. Grip Ctrl-drag copy is not driven.
 STEPS
   copy-info -> $copy0
   ms-count -> $c0
@@ -29,8 +32,7 @@
   field $ro_pit y -> $ry
   select $new_ro "name~^PIT LABEL" -> $ro_label
   select $new_ro "text~^CL " -> $ro_cover
-  field $ro_label handle -> $hro
-  ent-read {$hro} -> $rol
+  v3 ent-find AcDbBlockReference -Part "STORMWATER PIT LABEL" -> $labs
   windows-snapshot -> $win_end
 ASSERT
   contains $ro "1 pit copied and numbered as new."
@@ -41,8 +43,8 @@
   number $ry = -30569.9 +- 1
   not-contains $win_end "Creative Engineering"
   copy-unchanged $copy0
-  matches $rol "text.:.P8.,.insertion"
-  record $rol "FULL the ROTATE Copy's PIT LABEL"
+  matches $labs "PIT_LABEL=P8\W"
+  record $labs "FULL every plan label after the ROTATE Copy (none should read P8)"
   record $ro "FULL ROTATE Copy about a point 5 m away"
   record $roe "FULL after the wait"
   record $new_ro "FULL objects the ROTATE Copy added"
\ No newline at end of file
```


### Validate result (offline)

1. **Safe to run, confirmed from the code first:** `case_runner.ps1 validate` calls only `Get-PackFiles`, `Read-CaseFile` and `Test-CaseFile` (file reads and `Test-Path` on the fixture master). The driver library is loaded in `-Library` mode (defines functions, compiles two small in-memory helper types, sets the process DPI mode). It takes no lock, starts no AutoCAD, writes no ledger. After the run `ledger.json` and the driver `transcripts` folder still show their 08:14 timestamps.
2. **Command (PowerShell), run once per staged folder:** `pwsh -NoProfile -File 'C:\Lisp Files\_ACAD_DRIVER\case_runner.ps1' validate 'C:\ce-fx\c75fixups_staged\cases'` (then `\variants`, then `\controls`).
3. **Result:** `cases`: 7 files, 0 invalid. `variants`: 3 files, 0 invalid. `controls`: 4 files, 0 invalid. The same check on the untouched copies in `_orig\` is also 0 invalid, which gives the "before" check and step counts quoted above.
4. **What validate proves:** the files parse, every variable is set before use, every verb is allowed. It does NOT prove a check passes or fails in AutoCAD.

### The apply step (NOT run; for the desk, when Tim has told it to, and only when no case run is going)

Run in PowerShell. Fourteen copies, staged to live. Each overwrites a live file with the same name except the last of the variants, which is new.

```
$S = 'C:\ce-fx\c75fixups_staged'
$L = 'C:\Lisp Files\_ACAD_DRIVER\cases'
Copy-Item "$S\cases\N24_cdrenumber_plan_labels_one_by_one.case.txt"            "$L\N24_cdrenumber_plan_labels_one_by_one.case.txt"
Copy-Item "$S\cases\R32_edit_pipe_reverse_levels_arrow_follows.case.txt"       "$L\R32_edit_pipe_reverse_levels_arrow_follows.case.txt"
Copy-Item "$S\cases\R32b_edit_pipe_size_only_keeps_arrow.case.txt"             "$L\R32b_edit_pipe_size_only_keeps_arrow.case.txt"
Copy-Item "$S\cases\R34_copy_rotate_scale_pit_gets_own_number.case.txt"        "$L\R34_copy_rotate_scale_pit_gets_own_number.case.txt"
Copy-Item "$S\cases\R34s_copy_rotate_scale_pit_switch_on.case.txt"             "$L\R34s_copy_rotate_scale_pit_switch_on.case.txt"
Copy-Item "$S\cases\R34sn_copy_rotate_scale_pit_number_switch_on.case.txt"     "$L\R34sn_copy_rotate_scale_pit_number_switch_on.case.txt"
Copy-Item "$S\cases\R34so_rotate_copy_pit_offset_switch_on.case.txt"           "$L\R34so_rotate_copy_pit_offset_switch_on.case.txt"
Copy-Item "$S\variants\R33m_copy_message_does_not_claim_no_label.case.txt"     "$L\variants\R33m_copy_message_does_not_claim_no_label.case.txt"
Copy-Item "$S\variants\R34s_off_broken.case.txt"                               "$L\variants\R34s_off_broken.case.txt"
Copy-Item "$S\variants\R34so_off_broken.case.txt"                              "$L\variants\R34so_off_broken.case.txt"
Copy-Item "$S\controls\C32_edit_pipe_arrow_switch_off.case.txt"                "$L\controls\C32_edit_pipe_arrow_switch_off.case.txt"
Copy-Item "$S\controls\C33m_copy_message_switch_off.case.txt"                  "$L\controls\C33m_copy_message_switch_off.case.txt"
Copy-Item "$S\controls\C34_rotate_copy_switch_off.case.txt"                    "$L\controls\C34_rotate_copy_switch_off.case.txt"
Copy-Item "$S\controls\C36e_cdfw_opening_switch_off.case.txt"                  "$L\controls\C36e_cdfw_opening_switch_off.case.txt"
```

1. **Check after copying:** hash each live file and compare with the "after" list above (first 12 characters). Then run `validate` on `C:\Lisp Files\_ACAD_DRIVER\cases` and its `variants` and `controls` folders.
2. **Undo in one action:** the untouched originals are in `C:\ce-fx\c75fixups_staged\_orig\` (same names, same three sub-folders; their hashes equal the "before" list). Copy them back over the live files and delete `variants\R34so_off_broken.case.txt`.
3. **Do not copy while a runner chain is going** (RULES 8.3): a case file is read when its run starts, and a hash change mid-chain would split a pair of runs.

### What the next runs must cover (one pair of fresh runs per case, one build)

1. **Civil build:** read the Civil DLL version live at the start and in every run header (3.0.85 as of the B8 review); a new install voids runs that straddle it.
2. **Eight main cases, two separate AutoCAD starts each:** N24, R32, R32b, R33m, R34, R34s, R34sn, R34so.
3. **Six twin or control runs, at least one start each (their hashes are new or changed, and the controls need a ledger row that carries the new `variant_of`):**
   1. R34s_OFF_BROKEN: must fail checks 5, 6, 8, 10 and 11 as C34 does.
   2. R34so_OFF_BROKEN (new): must fail the line, label, cover and P8 checks, and still pass the pit position checks.
   3. C34 (R34), C33m (R33m), C32 (R32), C36e (R36e): each must fail the same checks it failed in c1k1 to c1k4.
4. **Unchanged twins keep their existing red rows** (their `VARIANT_OF` lines already point at the case id, and a variant red counts whatever the main case's hash is): R32_BROKEN, R32b_BROKEN, R34_NOCOPY_BROKEN, R34sn_BROKEN, N24_BROKEN, R34a_NOU_BROKEN.
5. **Review slips that go stale at the apply** (they quote a hash that will no longer exist): R32, R32b, R33m, R34sn and N24. R34a's slip is unaffected. R34, R34s and R34so have no slip yet; they need one after the two passes.
6. **Settings:** R34, R34s, R34sn, R34so and their OFF twins set `CD_Settings.json` through the settings guard (restored by hash). R32, R32b, R33m and N24 set none. Which cases rewrite `CD_RecentValues.json` I did not check (N24's own header says its remembered values should not change).

### What I did NOT verify (RULES 5.9)

1. **Nothing was run in AutoCAD.** The offline check proves the files parse, nothing about results.
2. **P11 (the ROTATE Copy after a COPY) has never been read in any run.** P8 and P12 have (R34a, R34sn, R34s). If the first run reads another number, check the derivation before blaming CE.
3. **The three N24 patterns** were tested only in Python's regex engine against the recorded run text of n3d4 (every label back: matches; after-Yes read: refused; one label changed: refused; X1 unchanged: matches; X1 changed: refused). They were not run through the runner's own `matches` (.NET). The B7 reviewer tested them in PowerShell; the two engines agreed on those tests.
4. **The `ent-find` P8 check in R34so_OFF_BROKEN** is a new read in this exact case; the same `ent-find` call is in N24 (two 3.0.85 passes) but it has not been run here.
5. **That an empty handle stops the step** is read from `acad_driver_v3.ps1` line 1072 and `case_runner_lib.ps1` (`field` of an empty list gives an empty string), not seen happen.
6. **How the report counts a control that now carries `VARIANT_OF`:** read from `Resolve-CaseAcceptance` (lines 266 to 284), not seen in a report.
7. **Whether the live folder changes between now and the apply:** I hashed it at the end of this pass and it matched; another chat could still edit it.
8. **Not touched, by instruction:** ledger, review slips, runner and driver files, DESK_LOG, BUG_CARPARK, settings, `HOLD_ROBOT.flag`, product code. No scratch file outside `C:\ce-fx\c75fixups_staged\` (it also holds `_orig\`, `_diffs.txt`, `_head.md` and `_tail.md` made for this report).

## Summary (under 100 words)

Staged one edit pass in `C:\ce-fx\c75fixups_staged\`: 13 case files edited plus a new twin R34so_OFF_BROKEN, live files untouched. ROTATE Copy cases now read the copy's label (P8, P11, P12, marked DERIVED); R33m checks "no cover text"; six stale expected-fail tags removed; R34s_OFF_BROKEN turns the new switch off; four controls got VARIANT_OF; N24 gained three every-label checks. All 14 pass the offline checker. The apply is 14 copy commands, not run. Next: fresh double runs on 8 cases and 6 twins or controls.
