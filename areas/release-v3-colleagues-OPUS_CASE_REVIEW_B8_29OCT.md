# Opus independent case review B8: the C-75 bug-fix proofs (BUG-665, BUG-672, BUG-1222, BUG-1223) on Civil 3.0.85 (Thu 29 Oct 2026)

Written Thu 29 Oct 2026, 04:30 to about 04:45 Melbourne (PC clock read with `date`), by the Team Opus job "INDEPENDENT CASE REVIEW OF THE THREE C-75 BUG-FIX PROOFS" (desk plan/03). Read-only on the product: no AutoCAD, no runner, no case, variant, control, runner, driver, ledger, desk log, bug carpark or settings edit. I wrote five review slips and this report, nothing else.

## ANSWER FIRST

### FOR TIM

1. **Mistakes first.**
   1. **Mine:** none that cost anything. My first ledger read used a program that is not on this PC; I redid it straight away. I replaced the 28 Oct review slip for the plain COPY case, because its text has changed since; a copy of the old slip is kept in `C:\ce_rc_scratch\opusb8\old_slips\`.
   2. **In the job brief:** it asked which of cards D02, D20, D09, D13, D24 and D21 may be written fixed. **None of these cases touches those six cards.** They look carried over from the previous review job. The cards these cases do touch are D15 (copying a pit), and D17 and D07 as neighbours only.
2. **Counts, one verdict per case (20 cases looked at).**
   1. **Ready, whole claim: 2.** The Edit Pipe size-only Save (R32b) and plain COPY of a pit (R34a).
   2. **Ready for a named part: 3.** The Edit Pipe second plain Save (R32), the locked 25TEXT copy message (R33m), and the COPY and SCALE Copy numbers (R34sn).
   3. **Needs one stronger check: 3.** The three ROTATE Copy cases (R34, R34s, R34so). Nobody reads what the rotated copy's label actually says.
   4. **Needs its broken twin repaired: 1** (R34s_OFF_BROKEN). It passes when it should fail.
   5. **Needs your ruling, then a rewrite and new runs: 4.** The floor waste at the four inspection openings (R36e and its three twins).
   6. **Failing on purpose, and failing for the right reason: 7.** Three broken twins and four switch-OFF controls.
3. **Card that may be written "FIXED (Claude-accepted, Civil 3.0.85, 29 Oct 2026)":**
   1. **D15 (copying a pit), whole.** COPY a pit: the copy reads P8, the next free number on the test drawing; P3 keeps P3; the "Check levels" sentence appears; one U gives back exactly the same objects.
   2. **The 18 does not go up from this.** D15 was already counted from an earlier build.
4. **Bugs that may be written fixed.**
   1. **BUG-1222 (Edit Pipe arrow flips back), whole as filed:** "FIXED (Claude-accepted, Civil 3.0.85, 29 Oct 2026)". On a pipe with free ends, swap its levels and Save. Then Save again, or change only the size. The arrow keeps pointing from IL 18.000 down to IL 17.900. Pipes joined to pits, and Edit 2+ pipes, were not driven.
   2. **BUG-672 (copy with 25TEXT locked), part only:** CE no longer says "no label". It names layer 25TEXT and says how to recover. One check is still missing: that the line says "no cover text".
   3. **BUG-665 (ROTATE and SCALE Copy), part only:** a COPY gets P8, and a SCALE Copy gets a number of its own (P12). This holds with the older Settings tick ON.
   4. **Small parts, through the Edit Pipe case:** BUG-223 (Edit Pipe reversal) and BUG-686 (a level of exactly 0.00).
5. **Strong evidence that each fault was real and is now fixed, but no case proves it yet:**
   1. **BUG-665:** with today's settings, a ROTATE Copy or SCALE Copy of a pit now gets a label and a cover text, in both sessions. With the new switch OFF, they are missing again. What the rotated copy's label reads has never been checked. If it read P3, that would be the bug itself.
   2. **BUG-1223:** at all four openings the false "record changed" sentence is gone. The true one is there, for example "IO2 is already at this point, and a new source cannot sit on top of it." That is 4 openings in 2 sessions each, and the switch-OFF control brings the false sentence back. The cases still expect a floor waste to be placed, so they fail. **That is waiting on your ruling, not on CE.**
6. **What is missing, in plain steps (for the case owner, not you):**
   1. **ROTATE Copy cases:** add one label read to each of the three. P11 is expected after a COPY, or P8 when the ROTATE Copy is the first copy. Then two new runs.
   2. **R34s_OFF_BROKEN:** add the line that turns the new switch off. Then it fails again, as it should.
   3. **R33m:** add one check that the line says "no cover text".
   4. **Old "expected to fail" tags:** take them off six cases that now pass (R32, R32b, R33m, R34, R34s, R34so). Do it in the same edit as the checks above, so only one new pair of runs is needed.
7. **Your one open question (already on the list):** may a floor waste sit on top of an inspection opening? My recommendation is no, as the fix author said. Two drainage objects would claim the same pipe end.
   1. **"No":** the four cases are rewritten to expect the plain refusal, and can then be accepted.
   2. **"Yes":** that needs new work first.
8. **One new thing I noticed, not proven.** When a ROTATE Copy or SCALE Copy lands exactly on top of P3, CE prints six to nine lines saying P3's pit schedule cells were not updated. When the copy lands 5 m away, it prints none. It already happened on 3.0.84. The copy may be disturbing the original pit's own record. I recommend the desk adds it to the bug list; I am not allowed to edit it.

---

## Detail (for the desk and the case owner)

### How I checked

1. **Read in full:** `C:\TimOS\RULES.md` (start and the acceptance amendments); the regrade report Part 1; the three fix reports; the C-75 finalizer report; Opus B6; ROBOT_REMAINING_ASKS_28OCT; `decisions\2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`; the R16 slip; `case_runner.ps1` lines 116 to 126 (`Get-CaseIndependentReview`) and 266 to 284 (`Resolve-CaseAcceptance`); every case, twin and control below; BUG-665, BUG-672, BUG-1222 and BUG-1223 in `BUG_CARPARK.md`; cards D15, D17 and D07.
2. **Hashes:** every case file hashed now with SHA-256 (list in The cases). Every hash equals the hash on its 3.0.85 ledger rows. Three files changed on 29 Oct at 02:33, before the 3.0.85 runs: R34sn, R34a and R34s_OFF_BROKEN. I diffed each against `C:\ce_rc_scratch\b6fixups\orig\`. The originals hash to B6's values 1A7904894EE6, ECAFF15219AF and 72F8BE8BFA6B. Each changed only as the fix-up script says: the P8 lines and a note, and the stray VARIANT_OF line removed.
3. **Ledger:** all 1,301 rows read; every row for these cases on 3.0.84 and 3.0.85 listed. On 3.0.85 there is no FAIL row for any case I mark ready. Every PASS session is a separate AutoCAD start: each run's session record has its own drawing copy, `acad_left 0` and clean.
4. **What the gate needs:** an EXPECT-FAIL tag does NOT block acceptance of a PASS. `Resolve-CaseAcceptance` reads `known_fail` only on the not-PASS path. It also feeds the report counts, where a FAIL of a tagged case is counted as "FAIL that was expected". **So a stale tag is a regression hazard, not an acceptance block.** If R32 broke again tomorrow, the report would file it as a known failure. Earlier-build reds need the SAME case hash. Variant reds need `VARIANT_OF <case>` and a FAIL `from_check` row, whatever its hash.
5. **Gate check of my slips, offline** (the gate's own function, copied from `case_runner.ps1` into `C:\ce_rc_scratch\opusb8\gate_check.ps1`):
   1. **Read ok, with the matching hash:** R32, R32b, R33m, R34sn and R34a.
   2. **Read "no review", so no slip leaks onto them:** R32_BROKEN, R32b_BROKEN, R34, R34s, R34so, R34s_OFF_BROKEN, R34_NOCOPY_BROKEN and R36e.
6. **Source:** read on `origin/claude/rel-20261026z` at `09126560` (the installed 3.0.85 version commit), with `git show` and `git grep` only:
   1. **The four switches default to true:** `UserSettings.cs` lines 637, 838, 846 and 1335.
   2. **The copy message:** `CloneCleanupMessages.cs` line 170 builds "copied pit(s) got their own number but no " plus `MissingWords`.
   3. **The opening sentence:** `SourcePickPipeRecordRule.cs` line 54 has "<tag> is already at this point, and a new source cannot sit on top of it. Move clear of <tag> and pick again."
   4. **The arrow fix:** `PipeEditCommand.DataCollection.cs` takes the arrow reading at line 279 with the switch ON, and at line 447 only with it OFF.
   5. **The label of a turned copy:** `LinkService.CloneRegeneration.cs` copies it by displacement and says it is "renumbered by the existing clone-row step". The code expects the rotated copy's label to be renumbered. No run has read it.

### The cases

1. **R34 (shipped defaults: old tick OFF, new switch ON). NEEDS STRONGER ASSERTION (and retag).** Hash 0537A7E7EE10.
   1. **Runs:** PASS 21 of 21 in c1a3-s1 and c1b3-s1. The same text FAILED on 3.0.84 (b6b2-s2, b6b3-s2). Control C34 (both switches off) FAILS checks 5, 6, 8, 10 and 11 in c1k1, for the right reason: labels 0, covers 0, one "numbered as new" line instead of three. R34_NOCOPY_BROKEN still fails.
   2. **What it proves:** COPY, ROTATE Copy 90 and SCALE Copy 1.5 each add one pit block, one PIT LABEL block and one CL text, and CE says "numbered as new" three times.
   3. **What it does not prove:** no label is read, so no copy is shown to have a number of its own. A PIT LABEL block that reads "P3" is exactly BUG-665's headline ("two pits show the same number"). A count of 1 does not exclude it.
   4. **Exact lines to add.** STEPS: after `select $new_cp "name~^PIT LABEL" -> $cp_label` add `field $cp_label handle -> $hcp` and `ent-read {$hcp} -> $cpl`. After `select $new_ro "name~^PIT LABEL" -> $ro_label` add `field $ro_label handle -> $hro` and `ent-read {$hro} -> $rol`. After `select $new_sc "name~^PIT LABEL" -> $sc_label` add `field $sc_label handle -> $hsc` and `ent-read {$hsc} -> $scl`. ASSERT: `matches $cpl "text.:.P8.,.insertion"`, `matches $rol "text.:.P11.,.insertion"` and `matches $scl "text.:.P12.,.insertion"`. Mark them DERIVED: P1 to P7, P9, P10 and C1 exist, so the lowest free numbers are P8, then P11, then P12. R34s already read P12 for the SCALE Copy in every run.
   5. **Retag in the same edit:** delete `EXPECT-FAIL BUG-665`. Set `BUG BUG-665`. Replace the PLAN_ITEM "reproduction only ... with the switch OFF" with "BUG-665 part: pit COPY, ROTATE Copy and SCALE Copy with shipped defaults".
   6. **Red after the edit:** the 3.0.84 FAIL rows carry the old hash, so they will no longer count. Add `VARIANT_OF R34` to C34, or make C34 a twin `R34_SWITCHOFF_BROKEN` with that line, and run it once.
2. **R34s (old tick ON). NEEDS STRONGER ASSERTION (and retag).** Hash 05D4BE8105FC.
   1. **Runs:** PASS 26 of 26 in c1a4-s1 and c1b4-s1. The same text FAILED on 3.0.84 (ROTATE label 0, cover 0).
   2. **What it proves:** the COPY and SCALE Copy labels read a number other than P3 (P8 and P12 in the record). The ROTATE Copy now has a label block (handle 11C599 in c1a4) and a "CL 18.88" text.
   3. **What it does not prove:** the ROTATE label is never read.
   4. **Exact lines to add:** `field $ro_label handle -> $hro`, `ent-read {$hro} -> $rol`, ASSERT `matches $rol "text.:.P11.,.insertion"` and `matches $scl "text.:.P12.,.insertion"` (DERIVED as above).
   5. **Retag in the same edit:** delete `EXPECT-FAIL BUG-665`. The EXPECTED text still describes the 3.0.75 failure: shorten it.
   6. **Red after the edit:** R34s_OFF_BROKEN, once repaired (item 4).
3. **R34so (ROTATE Copy about a point 5 m east, tick ON). NEEDS STRONGER ASSERTION (and retag).** Hash 82FDD260D756.
   1. **Runs:** PASS 11 of 11 in c1a4-s1 and c1b4-s1. The same text FAILED on 3.0.84.
   2. **What it proves:** one pit at 58777.7,-30569.9 (AutoCAD's own rotation, correct), one PIT LABEL, one CL text, the "numbered as new" line, and no schedule complaint.
   3. **Exact lines to add:** `field $ro_label handle -> $hro`, `ent-read {$hro} -> $rol`, ASSERT `matches $rol "text.:.P8.,.insertion"` (the first copy on the drawing).
   4. **Retag in the same edit:** delete `EXPECT-FAIL BUG-665`.
   5. **Red after the edit:** a twin `R34so_OFF_BROKEN` with `linking.rotateScaleCopyLikeCopy false` and `linking.cleanUpGripRotateScaleCopies false`. It must fail the label, cover and P8 checks.
4. **R34s_OFF_BROKEN (twin of R34s). NEEDS BROKEN VARIANT (repair).** Hash 4E86F4E6AA55.
   1. **Runs:** PASS on 3.0.85 in b6c1-s2, c1a5-s1 and c1b5-s1, so it is not a red.
   2. **Why:** it turns off only the old tick, and the new switch still makes ROTATE Copy and SCALE Copy copy. Its VARIANT_OF line is now correct, after the 02:33 fix-up.
   3. **Exact line to add:** `SETTING CD_Settings.json linking.rotateScaleCopyLikeCopy false`, under the existing SETTING line. Then run it once; it must fail checks 5, 6, 8, 10 and 11, as C34 does.
5. **R34sn (COPY and SCALE Copy numbers, tick ON). CLAUDE-ACCEPTED-READY for PART. Slip written.** Hash F8A2788F0DEC.
   1. **Runs:** PASS in b6c1-s3, c1a4-s1 and c1b4-s1 (three AutoCAD starts). Red: R34sn_BROKEN (expects P3) FAILS in b6c1-s3. It is a flipped red: it shows the label read can fail.
   2. **The part:** the COPY reads P8, the drawing's only free gap. A count+1 or highest+1 rule would give P11, so P8 is a real "next free" answer, not an accident of the drawing. The SCALE Copy reads neither P3 nor P8 (P12 every run), so the two copies and the original never share a number.
   3. **Not covered:** the ROTATE number; that P12 is the RIGHT number (only "different" is held, and the SCALE check has no red of its own); the shipped-default route; schedule row and record; PITDELETE; pipes; grips.
   4. **Its note "the ROTATE Copy adds no label" is stale since 3.0.85.** It changes no check; fix it at the next edit.
6. **R34a (plain COPY, card D15). CLAUDE-ACCEPTED-READY, D15 whole. Slip written (replaces B6's).** Hash 62940EB2D771.
   1. **Runs:** PASS 19 of 19 in b6c1-s1, c1a2-s1 and c1b2-s1. Real-action red: R34a_NOU_BROKEN (no U) FAILS in b6c1-s1, count and handles.
   2. **The fix-up added what B6's slip asked for:** `matches $cpl "text.:.P8.,.insertion"`. With it, D15's three assertions are all held: the full Check levels sentence; a new free number, P8, with P3 kept before, after and after U; and one U gives back the same 1034 handles.
   3. **Recommended, not a block:** B6's report also suggested a twin that takes P8 first and must then fail.
   4. **Not covered:** a COPY that brings pipes along, the copy's levels, schedule cells, looks.
7. **R33 (BUG-672 behaviour half): not re-reviewed here.** B6's slip covers it on 3.0.84 only. R33m (item 8) shows the same behaviour again on 3.0.85: pit and label drawn, cover text left out.
8. **R33m. CLAUDE-ACCEPTED-READY for PART. Slip written.** Hash F9DDB36AE114.
   1. **Runs:** PASS 14 of 14 in c1a2-s1 and c1b2-s1. The same text FAILED check 11 on 3.0.84 (b6a2-s1, b6a3-s1). Control C33m FAILS check 11 in c1k2: the old "no label or cover text" came back.
   2. **The exact line seen on 3.0.85:** "[CE] 1 copied pit(s) got their own number but no cover text: layer 25TEXT is locked, and CE does not draw on it. Undo (U), unlock layer 25TEXT, then copy again."
   3. **The part:** the pit and its label are drawn on open layers and the label reads a number other than P3. No CL text is drawn. 25TEXT and the recovery sentence are named. "no label" is gone. U restores the count.
   4. **Why not whole:** BUG-672 asks CE to "report the one skipped". The case only rejects the false word. A line that named nothing would pass.
   5. **Exact line to add:** `contains $cp1 "got their own number but no cover text"`.
   6. **Retag in the same edit:** delete `EXPECT-FAIL BUG-672` and the comment's "Expected to FAIL until the sentence is corrected".
   7. **Red after the edit:** add `VARIANT_OF R33m` to C33m (it fails the new line and check 11 with its switch off), because the 3.0.84 rows will carry the old hash.
9. **R32 (Edit Pipe, second plain Save). CLAUDE-ACCEPTED-READY for PART. Slip written.** Hash B441549C8A69.
   1. **Runs:** PASS 40 of 40 in c1a1-s1 and c1b1-s1. The same text FAILED checks 13 and 14 on 3.0.84 (b6b2-s1, b6b3-s1). Control C32 FAILS checks 13 and 14 in c1k3, arrow rotation 0.0. R32_BROKEN fails.
   2. **The arrow direction checked against the drawing, not taken on trust:** the pipe is drawn west to east. After the edit the west end is IL 17.900 and the east end IL 18.000. Water runs west, so rotation 3.14 is the right answer.
   3. **The part:** BUG-1222's plain-second-Save branch on both free-ended pipes, the BUG-223 CDEDIT reversal and the BUG-686 zero-level pipe.
   4. **Not covered:** pipes on pits, Edit 2+, the CD branches.
   5. **Header:** `BUG` is empty and `EXPECT-FAIL BUG-1222` is stale. The slip is valid for this text. At the next edit, delete the tag and set `BUG BUG-1222`; R32_BROKEN (VARIANT_OF R32) keeps the red; one fresh pair and a new slip are needed.
10. **R32b (Edit Pipe, size-only Save). CLAUDE-ACCEPTED-READY for BUG-1222 as filed. Slip written.** Hash 047DC293DAD5.
    1. **Runs:** PASS 24 of 24 in c1a1-s1 and c1b1-s1. The same text FAILED check 10 on 3.0.84. R32b_BROKEN fails its two-label check.
    2. **It follows the bug's own "Steps to confirm" exactly.** The arrow stays at 3.14 after a diameter-only Save, with "Pipe updated." and no uphill warning. Both IL texts stay on their sides. Both labels read "150 DIA. UPVC PIPE AT 1 IN 200". The never-reversed pipe keeps rotation 0.
    3. **Header:** the same as R32 (empty BUG line, stale tag). R32b_BROKEN keeps the red after a retag.
11. **R36e, R36e_p2, R36e_p3, R36e_p4 (BUG-1223). NEEDS RETAG AND RE-RUN, after Tim's ruling.** Hashes F257C55D135C, F1F9F0FD3DCB, 9DBF33D1FD64 and 2DF642D424AA.
    1. **Runs:** FAIL in c1a1 or c1a2, and c1b1 or c1b2. Only checks 1, 5 and 6 fail (no "Floor waste placed.", no block, no FW text). Checks 2, 3 and 4 pass.
    2. **What CE said:** "[CE] IO1 is already at this point, and a new source cannot sit on top of it. Move clear of IO1 and pick again, or press Esc." It says IO2, IO3 and IO4 at the other three openings.
    3. **Control:** C36e FAILS check 2 in c1k4; the false sentence returned.
    4. **No case positively asserts the true sentence yet.**
    5. **If Tim says "no":** replace `contains $fw "Floor waste placed."`, `count $fwb = 1` and `count $fwt = 1` with `contains $fw "IO1 is already at this point, and a new source cannot sit on top of it."` (IO2, IO3 and IO4 in the twins), `count $fwb = 0` and `count $fwt = 0`. Keep the three not-contains checks. Delete `EXPECT-FAIL BUG-1223`, set `BUG BUG-1223`, and add `VARIANT_OF R36e` to C36e.
    6. **Still missing for the whole bug:** the free-pipe-end placement half (a floor waste or downpipe on a pipe end whose keys were never saved now places). No case covers it.
12. **Twins and controls: valid reds, no slip needed.** R34_NOCOPY_BROKEN (884F9C62EDF3), R32_BROKEN (9B522F1E929E), R32b_BROKEN (518A2AEA722E), and C34, C33m, C32 and C36e (4E34D5B89101, 6BA0CC743763, 92D29358DA73, 71BB3540DA97). Each fails on 3.0.85 for the reason its header gives. **The four controls have no VARIANT_OF line, so the gate does not count them as reds.** Under the rule they are honest switch-OFF reds; the slips above rest on the earlier-build FAIL rows of the same text, which the gate does count.

### Finding for the desk (not a verdict; RULES 12.4: what I think, not verified)

1. **A copy stacked on its original disturbs P3's schedule.** On 3.0.85, ROTATE Copy and SCALE Copy about P3's own centre (R34 and R34s) put the new pit exactly on P3 (53777.7,-25569.9). Its PIT LABEL lands about 0.05 mm from P3's label, and the copy prints six to nine lines "[CE] Pit schedule cell for P3 (inlet from / inlet pipe size / outlet pipe size) not updated: the pit or pipe it was placed for no longer matches this drawing's record.". R34so, whose copy lands 5 m away, prints none, and neither does the plain COPY. The SCALE Copy printed the same lines on 3.0.84 (b6b2), so this is not new in C-75. **My guess, not verified:** the stacked copy takes over P3's pipe ends or record. That is BUG-665's "own record" half. Suggest a carpark entry and a case that reads P3's schedule cells after a stacked copy. The overlapping labels are a picture question for a Codex look.

### Not checked, said plainly (RULES 5.9)

1. No picture opened, no CE log read, nothing run.
2. Part 2 of the regrade was ignored, as the brief said.
3. I did not re-derive the fixture's pit numbers myself. "P1 to P7, P9, P10 and C1" comes from the case notes and from the B7 review (N24's label read, N29's schedule).
4. The ROTATE Copy's label number: not found in any run record. `ms-new` does not show block attributes.

## Files written

1. **Review slips** (format of the R16 slip, REVIEWER Opus-Team-B8-review), in `C:\Lisp Files\_ACAD_DRIVER\cases\` and copied to `C:\CE_PLAN\areas\runner-reports\reviews\`:
   1. `R32_edit_pipe_reverse_levels_arrow_follows.review.txt`
   2. `R32b_edit_pipe_size_only_keeps_arrow.review.txt`
   3. `R33m_copy_message_does_not_claim_no_label.review.txt` (its case sits in `variants\`; the gate looks in both folders)
   4. `R34sn_copy_rotate_scale_pit_number_switch_on.review.txt`
   5. `R34a_plain_copy_original_kept_u_restores.review.txt` (replaces B6's slip for 1A7904894EE6)
2. **This report.**
3. **Scratch, read-only scripts:** `C:\ce_rc_scratch\opusb8\` (ledger rows, run records, gate check, old slip).

## Summary

Five slips written for 3.0.85. Ready whole: R32b (BUG-1222 as filed) and R34a (card D15). Ready for parts: R32 (second plain Save, BUG-223 and BUG-686 branches), R33m (BUG-672: no false "no label") and R34sn (COPY P8, SCALE its own number). The three ROTATE Copy cases need one label read each. R34s_OFF_BROKEN needs the new switch turned off. The four opening cases wait on Tim's ruling. None of D02, D20, D09, D13, D24 or D21 is touched. BUG-1222 may be written fixed as filed.
