# Opus independent case review B6: R12 R33 R36 R37b R34sn R34a R40 and the real-fault cases, on Civil 3.0.84 (Wed 28 Oct 2026)

Written Wed 28 Oct 2026, 14:50 to about 15:05 Melbourne (PC clock read with `date`), by the Team Opus job "INDEPENDENT CASE REVIEW OF THE CODEX-ASK CASES" (desk plan/03). Read-only on the product: no AutoCAD, no runner, no case, variant, runner, driver, ledger, desk log, bug carpark or settings edit. I wrote five review slips and this report, nothing else.

## FOR TIM

1. **Mistakes of mine first.** My first try at fingerprinting the case files used a Windows program from the wrong command window and did nothing; I redid it the right way at once (cost: one minute, no harm). I also replaced the old 24 Oct review slip for the quick MOVE case (it was for an older text and said "not ready"); a copy of the old slip is kept in `C:\ce_rc_scratch\opusb6\`.
2. **Five cases are now Claude-accepted for a named part, on Civil 3.0.84.** Quick MOVE (R12), locked pit text layers (R33), floor waste in open space (R36), perimeter drain text (R37b), plain COPY of a pit (R34a). Each passed in two separate AutoCAD starts on 3.0.84 and has a twin that fails for the right reason.
3. **No new everyday-tool card becomes whole today.** Card D15 (copying a pit) was already accepted whole this morning on Civil 3.0.83 (case N16, B2 review). On today's 3.0.84 the new case R34a proves all of D15 except one check: that the copy gets the next FREE number. It read P8 every time, which is the first free number on the test drawing, but R34a only checks "not P3". It is stronger than N16 in one way: after U it compares every object, not just the count. Either run N16 twice on 3.0.84, or add one "reads P8" line to R34a and run it twice. Then D15 is whole on 3.0.84.
4. **One bug may now be written fixed in full:** BUG-460 (PIT with a pit text layer locked is refused before anything goes in, both layers). Write it "FIXED (Claude-accepted, Civil 3.0.84, 28 Oct 2026)".
5. **Four bugs may be written fixed for a part only** (the entry stays open):
   1. **BUG-236 perimeter drain text:** move, erase and copy only. Text height from Settings and renumbering are not tested.
   2. **BUG-672 copying a pit with the cover-text layer locked:** what gets copied is right. The message is still wrong (see 6.4).
   3. **BUG-262 locked-item messages:** only the "Pit schedule cell for P3 ... layer 25TEXT is locked" line and its "what to do" sentence.
   4. **BUG-132 and BUG-102 floor waste:** CDFW in open space only. CDSOURCE is not tested.
6. **Four faults are now proven real, with strong evidence** (the cases are right, CE is wrong; I also found the place in CE where each comes from):
   1. **BUG-665 ROTATE Copy:** a ROTATE Copy of a pit gets a new pit but no number label and no cover text, even with the Settings tick on. CE's own copy step skips any copy that is turned, by design, and still says "numbered as new". With the tick off (today's default) SCALE Copy is missing them too.
   2. **BUG-1222 Edit Pipe arrow:** flip a pipe's levels and Save, then Save again (or change only the size): the arrow turns back and points uphill against its own IL texts.
   3. **BUG-1223 floor waste at an inspection opening:** at all four openings CE says "A nearby pipe's Civil record changed while you picked" when nothing changed, and places nothing.
   4. **BUG-672 message:** CE always prints "got their own number but no label or cover text" when anything was skipped, even though the label WAS drawn.
7. **Not ready, and why:**
   1. **COPY and SCALE Copy numbers (R34sn):** it checks each copy is "not P3", but not that the two copies differ from each other. Two pits sharing one number is exactly the kind of fault BUG-665 is about.
   2. **CDCHECKDWG (R40):** needs a Codex look at its results window. Its "no file beside the drawing" check has never been seen to fail. Card D28 also contradicts BUG-606 about where the report goes, and that needs a decision first.
8. **One question for you, already on the list:** whether a floor waste may be placed at an inspection opening, or CE should refuse with a plain reason (BUG-1223). Either answer, the current message is wrong.

---

## ANSWER FIRST (for the desk and the next reviewer)

1. **Counts, one main verdict per case.**
   1. **CLAUDE-ACCEPTED-READY for a named part: 5:** R12, R33, R36, R37b, R34a. Review slips written next to each case and copied to `areas\runner-reports\reviews\`.
   2. **CLAUDE-ACCEPTED-READY whole: 0.**
   3. **NEEDS STRONGER ASSERTION: 1:** R34sn (exact line in The cases item 6).
   4. **NEEDS CODEX LOOK: 1:** R40. It also needs a red for its folder check (runner work) and a desk ruling on D28 line 817 against BUG-606.
   5. **NEEDS BROKEN VARIANT, NEEDS RUNS: 0** as main verdicts.
   6. **REAL FAULT confirmed (case right, CE wrong): 9 cases, 4 bugs.** R32 and R32b (BUG-1222); R34, R34s, R34so (BUG-665); R36e, R36e_p2, R36e_p3, R36e_p4 (BUG-1223); R33m (BUG-672 message half).
2. **Daily-tool cards and gap-plan items that may be written "FIXED (Claude-accepted, Civil 3.0.84, 28 Oct 2026)":**
   1. **D15 (UX-EDIT-02), PART on 3.0.84:** assertion 1 whole (the full Check levels sentence), assertion 3 whole (one U brings back the same 1034 objects by handle), assertion 2 except "free" (copy number is not P3; P3 keeps its label before, after the COPY and after the U). Evidence R34a 1A7904894EE6. D15 is already whole on Civil 3.0.83 by N16 (068633409A51, Opus B2 review, U by count); builds are never combined, so 3.0.84 whole needs N16 twice on 3.0.84 or the P8 line in R34a (The cases item 5).
   2. **Gap plan 3.7 quick MOVE / card C41, PART:** C41 assertions 2 and 3 whole (no CE window; one U restores pit, label, cover text and six IL texts to 0.001 mm, same objects) and "labels go with the pit" (not left behind). Not assertion 1's 0.001 mm pit displacement or its placement rules. Evidence R12 58A9ACD407FB. C41 is not a D-card.
   3. **D07, D28: no credit.** R36 and R37b are D07 neighbours only; R40 is not accepted.
   4. **Effect on "14 of 40 everyday tools Claude-accepted":** no new whole card. D15 was already counted from N16 on 3.0.83; on 3.0.84 it is part-accepted by R34a.
3. **Bugs:**
   1. **BUG-460: FIXED (Claude-accepted, Civil 3.0.84, 28 Oct 2026), whole as written** (R33 EC16A6B2B6C2): PIT refused before placing with STORMWATER PIT LABEL locked and with 25TEXT locked, layer named, object count unchanged. True red R33_BROKEN.
   2. **Part only, entry stays OPEN, write the part in the wording:** BUG-236 (move, erase, copy text; R37b 7DC161EA7A8A); BUG-672 behaviour half (R33); BUG-262 named P3 schedule-cell line and its recovery sentence (R33); BUG-132 and BUG-102 CDFW open-space portion (R36 68100FB1BBAB).
   3. **Strong evidence of a real fault on 3.0.84:** BUG-665, BUG-1222, BUG-1223, BUG-672 message half (detail in Real-fault cases).
4. **Hashes, sessions and reds checked by me, not taken from the builder's report.** I hashed every case and twin with Get-FileHash at 14:52 and every hash equals the builder's list. I read every ledger row for these cases dated 28 Oct and the failing checks in the b6a2, b6a3, b6b2 and b6b3 run JSON. Each READY case has two PASS rows on `civil 3.0.84+94f521cc / struc 1.0.125+204dfad2 / mgr 1.1.84+94f521cc` from two different runs (each run starts its own AutoCAD), no FAIL on that build, and none of the void rows the builder lists. b6b1-s2 and b6b1-s3 are excluded (labelled 3.0.83, ran on 3.0.84).
5. **Gate check.** I ran the gate's own review check (`Get-CaseIndependentReview`, read from case_runner.ps1, run offline against the files) for the five slips and for neighbours. R12, R33, R36, R37b and R34a read ok with the matching hash. R34, R34sn, R33m and R12_NOU_BROKEN read "no review", so no slip leaks onto a twin or a neighbouring case.
6. **Two things the case owner must fix (not done by me, read-only job):**
   1. **R34s_OFF_BROKEN has a stray second VARIANT_OF line** (header line 19 begins `VARIANT_OF R34s). R34so shows whether ...`, a broken copy of other text). The last VARIANT_OF wins, so its ledger rows carry that garbled text as variant_of, and the gate will never count it as R34s's red. Delete that line (it changes the twin's hash; re-run it).
   2. **The b6b1-s3 PASS row of R34sn is labelled 3.0.83** but ran on 3.0.84. Nobody may count it as a 3.0.83 pass.

## How I applied the four conditions

1. **Nothing seen on screen:** every accepted part is a drawing value, a count, a handle list, a command-line line or a file hash. Positions of labels, overlaps and window looks are excluded everywhere.
2. **Two sessions, one build:** 3.0.84 only; the 3.0.83 passes are context, never added in.
3. **Red before green:** for each accepted part I name the twin and say whether it is a real-action red (something left out or done wrongly) or a flipped expectation (a wrong value expected). A flipped red only proves the check can fail.
4. **Whole coverage:** every READY verdict names its part. The slip's VERDICT line carries the part, as the R16 slip does.

## The cases (ready candidates)

1. **R12 quick MOVE (C41, W1-02). Verdict: CLAUDE-ACCEPTED-READY for PART.** Hash 58A9ACD407FB. PASS 61/61 in b6a2-s1 (13:11) and b6a3-s1 (14:19).
   1. **Codex asks met:** the four movements (1155B6, 116A3C, 116BE4, 116A0E) are now asserted at 2000 +- 150 (cx_cr21 2.4); the unrounded x and y of pit, label, cover text and all six IL texts are compared before and after U to 0.001 (cx_cr21 2.7); the no-MOVE twin exists (cx_cr21 2.5); stale claim text corrected.
   2. **Reds, read in the run JSON:** R12_NOMOVE_BROKEN fails the eight movement checks at 0 (real action); R12_NOU_BROKEN fails the eight return checks at 1894 to 2000 (real action); R12_WIN_BROKEN fails only the window check because About CE Suite is open (real action). All three in both 3.0.84 sessions.
   3. **(a) start-of-token check:** `matches $pit1 "insertion\W+53777\.7\d*,-23569\.8"` reads only the start of the y value, so the pit's displacement is pinned to about 0.1 mm, not the card's 0.001. The raw reading shows exactly -23569.87543006733 against -25569.87543006733 before, so CE did move it exactly 2000, but the check does not hold it. The return after U IS held to 0.001 by the field reads.
   4. **(c) the +-150 window:** the label and cover text move exactly 2000.0; the IL texts move 1894.2, 1899.4, 1925.7, 1988.0, 1990.3 and 1999.1, so CE re-places them rather than carrying them rigidly. The window is wide because the placement rule is recorded nowhere, not because CE is loose. NOMOVE_BROKEN pins the "left behind" side (0 fails). Nothing pins a part-way move (for example 1000) except the window itself, and `dist` measures distance, not direction.
   5. **(b) drawing accidents:** the fixed points and handles are the fixture's own, which is normal; the counts 4 and 2 of IL texts within 4000 mm are fixture facts and are checked as "the same objects" (handle lists), which is right.
   6. **Exact lines for C41 assertion 1 (not done):** after `ent-read 109D56 -> $pit1` add `ms-new 0 -> $zm`, `select $zm "handle=109D56" -> $pm`, `field $pm x -> $pit_x1`, `field $pm y -> $pit_y1`; ASSERT `number $pit_x1 = $pit_x0 +- 0.001` and `number $pit_y1 = -23569.8754300673 +- 0.001` (the runner has no arithmetic; the starting y is fixed by the fixture). The placement rule for linked texts must be recorded by the desk before any whole claim.
   7. **Not covered:** pipe ends, the pipe P3 to P2 label line "no clear spot ... left where it is" (recorded only), the label look.
2. **R33 locked pit text layers. Verdict: CLAUDE-ACCEPTED-READY for PART.** Hash EC16A6B2B6C2. PASS 31/31 in b6a2-s1 (13:14) and b6a3-s1 (14:22).
   1. **(e) the exact part:** BUG-460 whole as written (both PIT refusals: layer named, nothing placed, count unchanged; the recovery sentence asserted for the label layer, the 25TEXT refusal by `history has`); BUG-672 behaviour half (one pit on STORMWATER PIT, one PIT LABEL on STORMWATER PIT LABEL reading a number other than P3, no CL text, 25TEXT named, count back after one U); BUG-262 for the P3 schedule-cell line and the recovery sentence Codex asked for (cx_cr21 1.6, now asserted).
   2. **Reds:** R33_BROKEN (no lock) fails both PIT checks: real action. R33_NUM_BROKEN expects P3 and reads P8: flipped. The copy-behaviour and schedule-message parts have only the flipped red; I accept them because the checks are exact sentences and counts that the fault states named in the bugs would break.
   3. **(d) number:** the copy reads P8, checked only as "not P3". Not claimed as the next free number.
   4. **Not covered:** the BUG-672 message half (R33m, real fault), U by handle (count only), the other BUG-262 branches, Edit Pit on locked layers (BUG-459, BUG-565), looks.
3. **R36 floor waste in open space. Verdict: CLAUDE-ACCEPTED-READY for PART.** Hash 68100FB1BBAB. PASS 21/21 in b6a2-s1 (13:18) and b6a3-s1 (14:26).
   1. **Codex asks met (cx_cr21 4.4 to 4.6):** PROVES_BUGS line exactly as asked; layer DOWNPIPES, text exactly FW (a field read, not a start-of-text match), text layer GUIDELINES and the U echo CDFW asserted; CDSOURCE prompt discovery done by a probe (first prompt recorded; no CDSOURCE case written, rightly, because later answers are unknown).
   2. **Reds:** R36_BROKEN (Esc instead of a point) fails placement and count: real action. R36_AGI_BROKEN expects 5 AGI blocks: flipped.
   3. **(b):** "AGI is on 4 blocks" is a fixture fact, but it is the deliberate condition of BUG-132 (duplicate source tags), so asserting it is right.
   4. **Not covered:** CDSOURCE, BUG-102's original drawing, the floor waste's position, openings and pipe ends (R36e), BUG-650, looks.
4. **R37b perimeter drain text. Verdict: CLAUDE-ACCEPTED-READY for PART.** Hash 7DC161EA7A8A. PASS 21/21 in b6a2-s1 (13:20) and b6a3-s1 (14:28).
   1. **Codex asks met (cx_cr22 1.3 and 1.7):** all six asked lines are present (start y -79925, one drain line, x unchanged after MOVE, copy x equals PD1 x, surviving PD2 keeps x and y); PROVES_BUGS line as asked.
   2. **(f):** the text height and renumbering are stated as NOT proved in PROVES_BUGS and NOT_AUTOMATED. Correct.
   3. **Reds:** R37b_BROKEN (no MOVE, no ERASE) and R37b_SIDE_BROKEN (MOVE 500 sideways, x 151500 against 151000) are real-action reds; R37b_COPY_BROKEN (expects "PD1 | PD1", the bug's own symptom) is flipped.
   4. **Not covered:** height (needs a runner `text_height` read), renumbering (no route), an independent read of the drain record, whether the polyline itself was erased (only the text is counted; the text going proves the ERASE ran), looks.
5. **R34a plain COPY of a pit (D15). Verdict: CLAUDE-ACCEPTED-READY for PART of D15.** Hash 1A7904894EE6. PASS 18/18 in b6b2-s1 (13:29) and b6b3-s1 (14:04).
   1. **Codex asks met (cx_cr22 5.3 and 5.4):** every asked line is present, including the full Check levels sentence, P3 read three times, `number $c0 = 1034` and the three 500-object handle chunks before and after U. The U echo reads "COPY" (recorded).
   2. **Red:** R34a_NOU_BROKEN (U left out) fails the count (1037) and the third handle chunk: real action.
   3. **(d) not P3 versus right number:** "not P3" proves a different number, not a free one. D15 assertion 2 asks for "a new free P number". The copy read P8 in all three sessions, and P8 is this drawing's first free number by two independent routes (SETUP-P8 and N05: a brand-new pit on DRV1_B1 is P8). **Exact line for whole D15:** ASSERT `matches $cpl "text.:.P8.,.insertion"`, plus a real-action twin `R34a_TAKEN_BROKEN` that runs SETUP-P8 first (so P8 is taken) and keeps the P8 check, which must then fail. Then two sessions on one build.
   4. **Not covered:** the copy's levels, the schedule cells, looks.
6. **R34sn COPY and SCALE Copy numbers, tick ON. Verdict: NEEDS STRONGER ASSERTION.** Hash ECAFF15219AF. PASS 7/7 in b6b2-s3 and b6b3-s3 (14:13). No slip written.
   1. **(d):** both checks are "not P3". The COPY read P8 and the SCALE Copy P12 in every run, but nothing stops both copies carrying the same number, which is the BUG-665 symptom family ("two pits show the same number"). Its only red (R34sn_BROKEN) flips the COPY check; the SCALE check has no red.
   2. **Exact lines:** ASSERT `matches $cpl "text.:.P8.,.insertion"` and `matches $scl "text.:.P(?!3.,)(?!8.,)[0-9]+.,.insertion"`. For the SCALE red, R34s_OFF_BROKEN is the natural one once its stray VARIANT_OF line is removed (ANSWER FIRST 6.1).
   3. **Note for the look:** the SCALE Copy sits on top of P3 (it is scaled about P3's own insertion point), and its label lands within 0.02 mm of P3's label. That is a picture question, not a number question.
7. **R40 CDCHECKDWG. Verdict: NEEDS CODEX LOOK (and a folder-check red, and a desk ruling).** Hash D24E373852FC. PASS 16/16 in b6a2-s1 and b6a3-s1. No slip written (KIND look: the gate never counts it without a look).
   1. **What it proves today:** four CE lines, exactly one summary line, the window opens and Close closes it, no new file beside the drawing, drawing hash unchanged, the report path is under TIM_CE_CADTOOLS.
   2. **Why not ready:** the folder check (`folder-new-only`) has never failed in any run, so the "no report beside the drawing" half of BUG-606 has no red; R40_BROKEN only flips the path text. The window needs a Codex look. Card D28 line 817 (report beside the drawing) contradicts BUG-606 (approved destination): the desk must reconcile before any whole claim. Line order, the unsaved-changes note and report-against-window count need runner verbs that do not exist.

## Real-fault cases (EXPECT-FAIL): is each failing check a genuine CE fault?

1. **R32 and R32b, BUG-1222. Genuine.** R32 fails only #13 and #14 (both arrows back to rotation 0.0 after the second plain Save) while #15 onwards show the IL texts still on the typed sides (17.900 and 0.00 west, 18.000 and 0.50 east), so the arrow points from low to high against its own texts. R32b fails only #10 (arrow A back to 0.0 after a diameter-only Save) while pipe B, never flipped, keeps its arrow. Seen in b6b1-s1 (3.0.83), b6b2-s1 and b6b3-s1 (3.0.84). The check reads the start of the rotation (`3\.14` for pi), which is enough. Source at 94f521cc: `PipeEditCommand.Update.cs` lines 952 to 981 turn an existing arrow by `ArrowTurnForSave` from the saved flow and pit order (BUG-260); I did not find the exact line that loses the flip and do not claim a root cause. Real-action reds: R32_BROKEN (levels not reversed) and R32b_BROKEN (pipe B left at 225).
2. **R34 (tick OFF, today's default), BUG-665. Genuine reproduction in the default setup.** ROTATE Copy and SCALE Copy get no label and no cover text, and only one "numbered as new" line appears instead of three. Source: `ExternalMutationCommandPolicy.cs` lines 87 to 106 keep ROTATE and SCALE as move-only commands unless `linking.cleanUpGripRotateScaleCopies` is on (OFF by default). So this is BUG-665 exactly as filed, left in place by a deliberate default. Whether the office default should be ON is Tim's decision (Monday question 8). Real-action red R34_NOCOPY_BROKEN.
3. **R34s and R34so (tick ON), BUG-665. Genuine, strong.** Only the ROTATE Copy label and cover checks fail (count 0); the new pit exists, sits at 58777.7,-30569.9 for R34so, and CE prints "1 pit copied and numbered as new. Check levels ...". Source: `LinkService.CloneRegeneration.cs` lines 220 to 226 say "Only pure translations (same rotation) are handled; a mirrored or rotated copy is left for the editor", and `ClonePitAttachmentsByDisplacement` returns 0 when the copy's rotation differs from the original's. So a turned copy never gets its label or cover text, and CE says nothing about it. This is against BUG-665's expected behaviour ("the copy gets the same clean-up a COPY gets ... own labels").
4. **R36e, R36e_p2, R36e_p3, R36e_p4, BUG-1223. Genuine for the false message; placement checks wait for Tim.** Each fails #1 (no "Floor waste placed."), #2 ("Civil record changed" present), #5 and #6 (no block, no FW text), on 3.0.83 and 3.0.84 at all four openings. CDFW and its point are typed in one string, so no other command ran: the "changed while you picked" sentence is false (#2 is the fault). #1, #5 and #6 assume placement, which BUG-1223 leaves as Tim's call (place, or refuse with a plain reason). Source: `SourcePlacementService.cs` lines 248 to 270 re-read the landing index once when it differs from the preview; the refusal text is `LinkService.SourceLanding.cs` line 372.
5. **R33m, BUG-672 message half. Genuine, strong.** Only #11 fails: the reply contains "no label" while the PIT LABEL with its own number IS drawn. Source: `CloneCleanupMessages.cs` line 139 prints the fixed sentence "copied pit(s) got their own number but no label or cover text" whenever any annotation is skipped, while `LinkService.CloneRegeneration.cs` (BUG-672 rule) still copies the annotations on open layers. The sentence is therefore wrong every time only the cover text is skipped.
6. **May they carry a review.txt under the gate?** The gate (`Resolve-CaseAcceptance`) returns FAIL for any non-PASS result before it looks at the slip, so a slip on a failing case can never make it count now. Even so, I wrote none: a slip says "ready", and these cases are not.
   1. **R32, R32b, R34s, R34so, R33m:** the case texts are right against their bug entries. Each may get a slip once the fix is installed and it passes twice on one build. Its own 3.0.84 FAIL rows then serve as the earlier-build red. For R34s the twin's VARIANT_OF must be repaired first.
   2. **R34:** better left without a slip. It pins the default-OFF route, and its pass depends on Tim's decision about the office default.
   3. **R36e family:** no slip until Tim records "place" or "refuse". If CE is fixed to refuse plainly, #1, #5 and #6 would fail a correct fix.

## What I read

1. `C:\TimOS\RULES.md` (start and the acceptance amendments at the end), `decisions\2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`, the builder's `release-v3-colleagues-ROBOT_REMAINING_ASKS_28OCT.md` in full, Codex `cx_cr21` in full and `cx_cr22` sections for R37b, R34, R34s, R34so, R34sn, R40, and the R16 slip.
2. All seven ready-candidate cases in full, R33m's header, R34sn_BROKEN and R34s_OFF_BROKEN headers; the gate code `Get-CaseIndependentReview` and `Resolve-CaseAcceptance`, the `field`, `dist`, `matches` and `number` handlers in `case_runner_lib.ps1`.
3. Card C41 and card D15; BUG-460, 672, 262, 132, 102, 236, 665, 1222, 1223, 606 in `BUG_CARPARK.md`.
4. `ledger.json` rows for these cases dated 28 Oct; run JSON b6a2, b6a3, b6b2, b6b3 (all assertions of R12, R34a, R34sn, R34so; every failing check of every case).
5. Source at the installed commit 94f521cc (branch origin/claude/rel-20261026y) by `git show` and `git grep` only.

## Not checked, said plainly

1. **I did not read the RUNNER_B3/B4 fix reports or the earlier Opus B2 and N27 reviews line by line.** I searched each for these seven cases and read the matching items, plus the opening and verdicts of B2 and N27 for method (that is how I found N16 already covers D15 on 3.0.83). The latest asks for these cases are in Codex cx_cr21 and cx_cr22, which I read in full for these cases.
2. **I did not open any picture, run anything, or read the CE logs of the runs.**
3. **I did not verify the claim that b6b1-s2 and b6b1-s3 ran on 3.0.84** beyond the builder's install log times; I simply excluded those rows.

## Files written

1. Review slips (format of the R16 slip, REVIEWER Opus-Team-B6-review), in `C:\Lisp Files\_ACAD_DRIVER\cases\` and copied to `C:\CE_PLAN\areas\runner-reports\reviews\`: `R12_quick_move_opens_no_window.review.txt` (replaces the 24 Oct slip for the older text), `R33_locked_pit_text_layers_pit_and_copy.review.txt`, `R36_cdfw_places_with_duplicate_agi_tags.review.txt`, `R37b_perimeter_pd1_text_follows_move_erase.review.txt`, `R34a_plain_copy_original_kept_u_restores.review.txt` (R34a's case sits in `cases\variants\`; the gate looks in both folders).
2. This report. Scratch read-only scripts in `C:\ce_rc_scratch\opusb6\` (ledger and run readers, gate check).

## Summary

Five cases are Claude-accepted for named parts on Civil 3.0.84: quick MOVE, locked pit text layers, floor waste in open space, perimeter drain text and plain pit COPY. BUG-460 may be written fixed in full. BUG-236, 672, 262, 132 and 102 may be written fixed for parts only. No new whole everyday-tool card. D15 stays whole on 3.0.83 only (N16); on 3.0.84 R34a needs one "P8" check. R34sn needs a different-numbers check. R40 needs a Codex look. Four faults are proven real, and their source is found: BUG-665 ROTATE Copy, BUG-1222 arrow, BUG-1223 floor waste, BUG-672 message.
