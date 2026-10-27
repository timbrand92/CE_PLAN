# Opus independent case review B5: R04, R11, R13, R19, R14 (with R14h), R21, R26 on Civil 3.0.80 (Tue 27 Oct 2026)

Written Tue 27 Oct 2026, about 11:10 to 11:30 Melbourne (PC clock), by the Team Opus job "INDEPENDENT CASE REVIEW OF THE CASES THE ROBOT SAYS ARE READY ON CIVIL 3.0.80", standing in for Codex (at its weekly cap). Read-only on the product: no AutoCAD, no runner, no case, variant, runner, driver, ledger, settings, DESK_LOG.md or BUG_CARPARK.md edit. The only files written are this report and ten `.review.txt` files (listed at the end). Rule applied: the RULES.md acceptance amendment of 24 Oct ("Claude-accepted") and `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`. Checklist: the Codex asks in `CODEX_CASE_REVIEW_cx_cr01`, `cx_cr03`, `cx_cr04`, `cx_cr05`, `cx_cr06`. Shape: `RUNNER_CASE_REVIEW_B3FIX_2026-10-25.md` and `RUNNER_CASE_REVIEW_B3B_2026-10-25.md`.

## FOR TIM

1. **My own mistakes first: none that cost anything.** Two of my look-ups failed on the first try (wrong tool for the job) and I redid them. One review time I first wrote as 11:40; I corrected it to 11:20 before saving anything to the repo.
2. **All 7 cases are honest and passed properly on the installed build (Civil 3.0.80).** Each passed in two separate AutoCAD starts on exactly the same installed builds, and each deliberately broken twin failed every time, for the right reason. No case shows a CE fault.
3. **2 cases are ready as whole items, 5 are ready only for the part they check.**
   1. **Whole:** the water-level warning (CDTWL says the water must stay 150 mm below the lid, names C1, P1 and P7, and follows the setting when you raise it to 200 mm), and erasing a pit with one pipe (the pipe stays, the message is right, one U brings the pit back).
   2. **Part only:** CE never saves (CDREBUILD not tried yet), Edit Pipe cascade with U and REDO (the IL texts are checked, the stored levels are not), CDSYNC (the warning and the Pit Schedule rows are checked, CDREBUILD and the schedule header are not), CDCHECK totals, and the CDSURVEY refusal.
4. **Everyday tools newly whole on this build: none.** The pit-erase tool (D14) was already counted through its six-pipe case; this one adds the one-pipe message. The "CE never saves" tool (D18) and the "warn before CDSYNC and CDREBUILD" tool (D27) each still need CDREBUILD driven.
5. **One named check from the 40 is newly whole: "CDTWL freeboard".** May be written "Claude-accepted, Civil 3.0.80, 27 Oct 2026".
6. **No bug may be newly written FIXED.** None of these cases is tied to an open bug. BUG-698 (CDSYNC turned pipe sizes to 100) is already FIXED by Codex; it may carry a note that the check still passes on 3.0.80.
7. **Two things I found that the robot's report got wrong or left out.**
   1. The robot's report says no session saw a settings file change. One did: the first AutoCAD start after the new Structural build (6:29 this morning) rewrote Structural's own settings file. It is Structural's file, so the Civil result stands.
   2. Both freeboard settings in your file move the CDTWL warning, up and down, each on its own. What happens when the two disagree (one 100, one 200) has never been tried. Not a fault yet, just unknown.
8. **Nothing for you to decide or test.**

---

## ANSWER FIRST

1. **Counts (one main verdict per case; R14 and its three raised-setting cases R14h_dstd_200, R14h_pipekey_200, R14h_both_200 counted as one case, R14):**
   1. **CLAUDE-ACCEPTED-READY (whole claim): 2.** R14 (with all three R14h cases), R19.
   2. **PARTIAL (ready for the exact part named): 5.** R04, R11, R13, R21, R26.
   3. **NEEDS STRONGER ASSERTION: 0. NEEDS BROKEN VARIANT: 0. NEEDS CODEX LOOK: 0. NEEDS RUNS: 0. FAIL = real fault: 0.**
   4. **Review files written: 10.** R04, R11, R13, R14, R14h_dstd_200, R14h_pipekey_200, R14h_both_200, R19, R21, R26. Each names the exact current SHA-256 and, for the partial cases, the exact part in its VERDICT line. Five of them replace older not-ready files (R04, R11, R13, R14, R19); their old text is quoted in "Replaced review files" below.
2. **Daily-tool cards (D-numbers) that may now be written "FIXED (Claude-accepted, Civil 3.0.80, 27 Oct 2026)": none newly whole.**
   1. **D14 (erase a pit):** already whole through R19b (re-graded on 3.0.80 in g80a3 and g80b3r). R19 adds the one-pipe sentence; D14 stays counted, now with both branches.
   2. **D18 (CE never saves):** part only. Covered: file unchanged after PIT, CD, CDSYNC, CDRECOVERINVERTS and PITSCHEDULE, only `_PRE_C7_` files beside it (assertions 1 and 3). Missing: CDREBUILD and its two no-save sentences (assertion 2).
   3. **D27 (CDSYNC and CDREBUILD warn first):** part only. Covered: assertion 1 (the CDSYNC sentence before "CDSYNC complete", one completed outcome). Missing: the CDREBUILD half (assertions 2 and 3).
   4. **D26 (CDSL):** not touched. R26 is CDSURVEY, not CDSL.
3. **Named gap-plan checks (section 3 item 7):**
   1. **"CDTWL freeboard" (card C39): whole.** May be written "Claude-accepted, Civil 3.0.80, 27 Oct 2026". 150 mm is the regression baseline, not an engineering approval.
   2. **"Edit Pipe cascade with U and REDO" (C40): part.** Covered: the cascade line, the whole IL text set after the cascade, U restoring every IL text and the object count, REDO restoring the cascade texts. Missing: stored pipe levels, which text belongs to which pipe, the Recalculate box body, the STUB to X1 warning.
   3. **"CDSYNC keeps the schedule" (C42): part.** Covered: assertions 1 and 2 (12 pits and 50 pipes relinked, every row and cell equal before and after). Missing: assertion 3 (record the header count before and after, BUG-855) and the cascade preparation the card names.
4. **Bugs:** none newly FIXED. No case has a BUG or PROVES_BUGS line. BUG-698 (already "FIXED, Codex-accepted, Civil 3.0.64") may carry: "R13 regression still passes, Claude-accepted, Civil 3.0.80, 27 Oct 2026". Not proved here: BUG-777, BUG-871, BUG-1032 (R14); BUG-797, BUG-782 (R11); BUG-855 (R13); BUG-461, BUG-809 (R21); BUG-134, 142, 144, 699 to 709 (R26).
5. **Build and ledger checks (read myself):**
   1. **Installed now (11:15):** Civil `3.0.80+270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1`, Manager `1.1.80+270215aa...`, Structural `1.0.125+204dfad268caf967f3404d876648480a94efe1cd`, the same in the Legacy, Modern and Net8 folders. Bundle `Contents` created: Civil 26 Oct 23:37:38, Manager 23:37:39, Structural 27 Oct 06:23:15.
   2. **Hashes:** all 7 cases, the 3 R14h cases and all 12 twins hash today exactly as in the regrade report section 6. SETUP-P8 `7A241608EB59` and SETUP-R47 `0CB83BDF7853` are unchanged since Codex's reviews of 26 Oct (the gate does not bind them; noted in each review file).
   3. **Two PASS sessions on one identical build string, each its own AutoCAD start, no FAIL on 3.0.80:** R04 x80b3-s2 and x80c3-s2; R11 and R13 x80b1-s1 and x80c1-s1; R19 x80b2-s1 and x80c2-s1 (all four also passed in x80a* on Structural 1.0.124). R14 x80a4-s1 and x80b4-s1; R14h x80a5 and x80b5 (s1 dstd, s2 both, s3 pipekey); R21 and R26 x80a6-s1 and x80b6-s1. Every one of these is on `civil 3.0.80+270215aa / struc 1.0.125+204dfad2 / mgr 1.1.80+270215aa`.
   4. **Structural build per session:** x80a1, x80a2, x80a3 (05:22 to 06:22) on Structural 1.0.124; every run from x80a4 (06:27) on 1.0.125. Structural does not take part in any of these Civil cases, but because the R04, R11, R13 and R19 pairs are each on 1.0.125 throughout, the question does not arise.
   5. **Straddles:** none. The Civil install (23:37:38 Mon) is before every x80 run; the Structural install (06:23:15) falls between x80a3 (ended 06:22:08) and x80a4 (started 06:27).
   6. **Twins, each failing for the intended reason, in every run:** R04_SAVE_BROKEN only `copy-unchanged` (saved copy hashes 7B5023765A92, D430D0D5F5B3, FA2FECD5A077 vs 34BBE37C2EA4). R11_BROKEN checks 10 to 12 ("Nothing to redo", texts not back, count 1041). R13_BROKEN check 2 (flipped count). R13_ROWS_BROKEN checks 7 and 10 (a real erase of P8 changes the rows). R19_BROKEN check 4 (flipped wording). R19_NOU_BROKEN checks 9, 12, 13, 14 (no U, count 1039, totals differ). R14_DSTD_BROKEN and R14_PIPEKEY_BROKEN checks 1 to 4 (real setting 100, wording no longer 150). R14_BROKEN its one check (flipped). R21_BROKEN checks 1 to 3 (flipped). R26_BROKEN check 1 and R26_PICK_BROKEN check 3 (flipped).
6. **Codex asks, applied or not (my checklist):**
   1. **R04 (cx_cr01):** the case honestly states CDREBUILD is missing; PITSCHEDULE open and Close is in; the real save red exists. CDREBUILD itself is not added (its prompts are still unknown). The broad `_PRE_C7_.*\.dwg$` pattern is unchanged.
   2. **R11 (cx_cr03 item 1):** SETUP-R47 added; the scope correction for stored levels, ownership and the STUB warning is in NOT_AUTOMATED; the Recalculate box body could not be read (probe b5p1) and is answered by title only. Stored-value reads not added.
   3. **R13 (cx_cr03 item 3):** title and PLAN_ITEM narrowed; `equals $cnt2 $cnt0` added; the Pit Schedule is read before and after with every row and cell compared, plus a real-change twin. CDREBUILD and the header record not added.
   4. **R14 (cx_cr04 item 1):** comment line 1 corrected to "detention volume"; the two raised-setting cases added exactly as asked, plus a both-keys case; both keys in Tim's file read 150 (`pipe.detentionFreeboardMm` line 5, `designStandards.detentionFreeboardMm` line 375, file hash ACD64E79A33B).
   5. **R19 (cx_cr05 item 1):** PLAN_ITEM exactly as asked, `count $pipes8 = 1`, stale NOT_AUTOMATED line replaced, and a real no-U twin added with the CDCHECK totals read.
   6. **R21 (cx_cr05 item 2):** title, PLAN_ITEM and NOT_AUTOMATED exactly as asked; the totals line bound to each reply; the Esc sentence asserted in both Esc replies.
   7. **R26 (cx_cr06 item 3):** PLAN_ITEM exactly as asked; the wrong-pick sentence asserted; the second call bound to its own reply; a sentence twin added. The header comment and the builder's REVIEWED_AGAINST still say "D26 (survey half)", which the PLAN_ITEM correctly denies: fix at the next owned edit.
7. **Codex look needed:** none for what these cases claim. Anything about how the Edit Pipe, Cascade Preview or Pit Schedule windows look stays a separate Codex look (R25 and others), and is not claimed here.

## Things the desk should know first (RULES 6.2)

1. **The regrade report's line "the robot's own check saw no difference between the start and end of any of my sessions" is wrong for one session.** `RUN-20261027-0627-C3.0.80-x80a4-s1` (R14 and R14_BROKEN, 06:29:00 to 06:34:17) recorded `CE_STRUC_SUITE\CS_Settings.json : 0791B07EBCD9 -> B3B5A004B929`. The file's last-write time is 06:29:12, 12 s after that AutoCAD started, and it was the first AutoCAD start after Structural 1.0.125 was installed at 06:23:15. So it is Structural rewriting its own settings on first load, not the robot and not Civil. Its report item 10 does correctly say the file changed with the Structural install. The R14 result stands (R14 also passed in x80b4 with no difference).
2. **The runner's "expected" Structural fingerprint is stale.** Run headers print expected `2972CE70C514` while the file has read `0791B07EBCD9` (25 Oct) and now `B3B5A004B929`. Harmless to these cases; worth refreshing so a real change is not hidden in noise.
3. **The two freeboard keys behave oddly, and nobody knows the rule.** Setting either key alone to 100 makes the warning say 100; setting either alone to 200 makes it say 200. I read the guard's code comment: `settings-temp set` changes ONLY the named key, so this is CE's behaviour, not the robot writing both. What CE does when the keys disagree in opposite directions (one 100, one 200) has never been run. Not a fault established here. A diagnostic case with the keys at 100 and 200 would settle it.
4. **Many x80 runs were in Tim's AutoCAD hours** (x80b4 at 07:42 to x80c3 ending 10:35) with `CE_RUNNER_TIM_AWAY=1`. The regrade report says so. It does not change the evidence; it is a desk matter under RULES 1.8.
5. **Stale wording, no effect on what is proved:** R11's NOT_AUTOMATED says the IL set is compared by "handle and wording"; the checks compare wording only (Codex said the same). R26's comment says D26. Bundle both corrections with the next real edit, because any edit changes the hash and needs two new runs.

## The cases

1. **R04: CE never saves the drawing (D18, UX-STD-03). Verdict: PARTIAL, ready for the part. Hash 443604166CC0.**
   1. **Covered:** SETUP-P8 records the copy before PIT and CD; then CDSYNC ("relinked"), CDRECOVERINVERTS ("recovered"), PITSCHEDULE opened and closed by its Close button; the copy on disk keeps its SHA-256 and time and only `_PRE_C7_` files appear. D18 assertions 1 and 3.
   2. **Not covered:** CDREBUILD and its two sentences (D18 assertion 2). The pattern allows any file containing `_PRE_C7_`, not only `<copy>_PRE_C7_<time>.dwg`.
   3. **Runs:** PASS 6 of 6 in x80a3-s2, x80b3-s2, x80c3-s2. Red: R04_SAVE_BROKEN fails only check 4 in all three; the driver's own save changed the copy each time.
   4. **To make D18 whole:** probe CDREBUILD's prompts on a test copy, then add it between CDSYNC and CDRECOVERINVERTS with `history has "it does not save the drawing itself"` and `history has "It does not save the drawing."` (cx_cr01 item 1.4), mirrored in the twin; two new runs.
2. **R11: Edit Pipe cascade, U and REDO (C40, UX-LBL-02). Verdict: PARTIAL, ready for the part. Hash B40EBE88E6B6.**
   1. **Covered:** "[CDEDIT-CASCADE] Updated 4 pipes and 3 pits from P3 (IL 17.50). Min grade: 1:16."; the whole IL text set after the cascade pinned exactly (including IL 17.60 and IL 17.50, and the P8 pipe's IL 18.000 and IL 17.900); one U echoes CDEDIT and every IL text and the count (1040) return; after 12 s REDO says "Everything has been redone" and the texts and count return to the cascade state; no Cascade or Edit Pipe window left; one "Command outcome: CDEDIT completed".
   2. **Not covered:** stored pipe levels in CE's records, which text belongs to which pipe, the Recalculate box body (17.30 to 17.50), the STUB to X1 warning (not seen on 3.0.78 probe b5p1).
   3. **Runs:** PASS 19 of 19 in x80a1, x80b1, x80c1. Red: R11_BROKEN (a CIRCLE between U and REDO) fails checks 10 to 12 each time: "Nothing to redo", texts stay at the old set, count 1041. The U-restore checks have no red of their own; I accept that because they compare against the before-set read in the same run, which differs from the after-set in every run.
3. **R13: CDSYNC warns then relinks (D27 CDSYNC half, C42 rows). Verdict: PARTIAL, ready for the part. Hash BE176845E3D2.**
   1. **Covered:** the full sentence "[CE] CDSYNC will re-link every pit and pipe in this drawing to CE's records, from what is currently drawn. One U undoes it." comes before "CDSYNC complete. Pits relinked: 12, Pipes relinked: 50" in the same reply; object count unchanged (1040); every Pit Schedule row and cell (sizes, levels, covers) equal before and after; both schedule visits closed; the second U echoes CDSYNC and the count returns; one completed outcome.
   2. **Not covered:** CDREBUILD (D27 assertions 2 and 3); the header count before and after (C42 assertion 3, BUG-855); the cascade preparation C42 names; the U echo does not prove the relinks were undone (the case says so).
   3. **Runs:** PASS 18 of 18 in x80a1, x80b1, x80c1. Reds: R13_ROWS_BROKEN (P8 erased between the reads, a real change) fails checks 7 and 10; R13_BROKEN (11 and 49 expected) fails check 2; x80a2, x80b2, x80c2.
   4. **Small addition for C42 whole, besides the cascade preparation:** read the header line into `$header0` and `$header1` and `record` both (cx_cr03 item 3.6).
4. **R14: CDTWL freeboard 150 mm (C39), with R14h_dstd_200, R14h_pipekey_200, R14h_both_200. Verdict: CLAUDE-ACCEPTED-READY (C39 whole, plus the raised setting). Hashes R14 6B375F8D1219, R14h_dstd_200 75A91D22C754, R14h_pipekey_200 CCF6A4F7A293, R14h_both_200 DF7288A88698.**
   1. **Against C39:** assertion 1 (40 mm at C1, 150 mm wanted), assertion 2 (exactly two 110 mm lines, for P1 and P7 by name, each 150 mm, "That is enough."), assertion 3 (one completed outcome), plus CMDACTIVE 0 and no "New " window.
   2. **Raised setting:** each R14h case sets its key or keys to 200 through the settings guard (restored by hash; every x80a5 and x80b5 session ended with 0 fingerprint differences) and asserts C1, P1 and P7 each say "(200 mm is wanted)", idle, one outcome. These have no broken twin of their own; the same steps at 150 print "(150 mm is wanted)" in R14's own runs, so these checks demonstrably fail when the setting is not raised.
   3. **Runs:** R14 PASS 9 of 9 in x80a4-s1 and x80b4-s1; R14h each 6 of 6 in x80a5 and x80b5. Reds in both: R14_DSTD_BROKEN and R14_PIPEKEY_BROKEN (real setting 100) fail checks 1 to 4; R14_BROKEN (41 mm) fails.
   4. **Not covered, and not claimed:** BUG-777, BUG-871, BUG-1032; which key wins when the two disagree; the engineering value of 150 mm (Tim's word).
5. **R19: erase a one-pipe pit keeps the pipe, U restores (D14 one-pipe branch). Verdict: CLAUDE-ACCEPTED-READY. Hash BE503780EB3B.**
   1. **Against D14 for N = 1:** assertion 1, the whole sentence "[CE Civil] The pit was erased and the schedule is updated. 1 pipe now has an end that is Not connected yet. U restores everything."; assertion 2, the one pipe (exactly one found) still reads as a CE pipe after the erase; assertion 3, one U echoes ERASE, the pit is back (STORMWATER PIT) and the count returns 1039 to 1040. Plus the CDCHECK totals line ("218 objects, 189 connections: 184 Connected, 1 Possible, 4 Unresolved, 0 Not Connected, 0 Unknown.") equal before the erase and after U.
   2. **Limits:** done on new pit P8, not P3 (P3 with six pipes is R19b, already accepted); the totals line counts the whole drawing, not P8 alone.
   3. **Runs:** PASS 20 of 20 in x80a2, x80b2, x80c2. Reds: R19_NOU_BROKEN (a real missing U) fails checks 9, 12, 13, 14; R19_BROKEN (plural wording) fails check 4; x80a3, x80b3, x80c3.
6. **R21: CDCHECK totals baseline. Verdict: PARTIAL, ready for its narrow baseline. Hash 2462CD753D29.**
   1. **Covered:** All and Problems each print "[CE] CDCHECK: 212 objects, 184 connections: 179 Connected, 1 Possible, 4 Unresolved, 0 Not Connected" in their own reply (twice in total); each Esc says "Nothing in the drawing has been changed so far."; object count and file on disk unchanged; no CE window left.
   2. **Not covered (the case says so):** a full in-memory drawing comparison; BUG-461 action and failure routes; the Checks palette counts (BUG-809 item 1); D28.
   3. **Runs:** PASS 10 of 10 in x80a6 and x80b6. Red: R21_BROKEN (180 Connected) fails checks 1 to 3, a flipped red only. The file check has a real red in R04_SAVE_BROKEN (same check verb).
7. **R26: CDSURVEY refusal stores nothing. Verdict: PARTIAL, ready for its narrow part. Hash 2EC1D6D74E0F.**
   1. **Covered:** "Current survey: Survey: not loaded" and "Click on the survey XREF"; a pick on pit P3 refused with "[CE] Please click directly on the survey XREF block."; a second CDSURVEY still says not loaded; Esc says "CDSURVEY cancelled - nothing stored."; object count and file unchanged.
   2. **Not covered:** any real survey intake (no survey Xref fixture exists), V1's bugs, D26.
   3. **Runs:** PASS 11 of 11 in x80a6 and x80b6. Reds: R26_BROKEN check 1 and R26_PICK_BROKEN check 3 fail, both flipped wording; a real "something got stored" red is impossible without a survey Xref.

## Replaced review files (old text kept here)

1. **R04:** "VERDICT NEEDS BROKEN VARIANT ... Part only: CDREBUILD and PITSCHEDULE not covered", hash E7168D28488F, Opus, 24 Oct.
2. **R11:** "VERDICT NEEDS STRONGER ASSERTION (cascade values not checked ...) then NEEDS BROKEN VARIANT", hash BCDD8B109627, Opus, 24 Oct.
3. **R13:** "VERDICT PARTIAL (CDSYNC half of D27 only ...)", hash 29BECD31AC2B, Opus, 24 Oct.
4. **R14:** "VERDICT NEEDS STRONGER ASSERTION (assert the P1 and P7 110 mm lines by name; CMDACTIVE 0)", hash B4A90665D8A4, Opus, 24 Oct.
5. **R19:** "VERDICT PARTIAL (one-pipe pit only ...) then NEEDS BROKEN VARIANT", hash 0580CBBA8D3E, Opus, 24 Oct.
6. All five named old case texts; none was the current text, so none could pass the gate. The cases folder is not under git, so this list is the record.

## What I read

1. `C:\TimOS\RULES.md` (all, with amendments); `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`; the regrade report (all); the B5 fixes report (all); Codex reviews cx_cr01 (all), cx_cr03 (all), cx_cr04, cx_cr05 and cx_cr06 (every R04, R11, R13, R14, R19, R21, R26 section); the B3FIX and B3B review shape.
2. Cards D14, D18, D26, D27 (`DAILY_TOOLS_TEST_CASES_2026-10-23.md`) and C39, C40, C41, C42 (`TEST_CASES_DRAFT_22OCT.md`); BUG-698 and BUG-855 entries; bug headings for BUG-777, 782, 797, 809, 871, 1032.
3. All 7 case files, the 3 R14h files and all 12 twins in full (as diffs against their parent); SETUP-P8 and SETUP-R47 hashes and dates; the R16 review format; the gate `Get-CaseIndependentReview` in `case_runner.ps1`; the guard's `settings-temp set` description in `acad_driver_witness_v2.ps1`.
4. `runner-reports\ledger.json` (731 rows, working copy at 10:48) row by row for these cases from 26 Oct 13:00; every check line, session time and fingerprint note of the 17 x80 run JSON files; the installed DLL product versions and bundle creation times; Tim's CD_Settings.json freeboard keys (read only).

## What I did NOT check (RULES 5.9)

1. Nothing in AutoCAD, nothing on screen. No picture was looked at.
2. The 3.0.78 and 3.0.79 runs only as ledger rows; the verdicts rest on the 3.0.80 runs.
3. SETUP-P8 and SETUP-R47 bytes at run time: the gate binds only the case hash. Their files are unchanged since 24 Oct and Codex recorded the same hashes on 26 Oct; that is supporting evidence, not proof of the bytes each run used.
4. Whether the CDTWL figures, levels or grades are right as engineering: Tim's word.
5. R09, R22, R08, R24 and the 20 re-graded cases: not reviewed here.
6. I ran a copy of the gate's three checks against my ten files (all pass, one file per case found); I did not run the runner itself.

## Files written

1. This report.
2. Ten review files beside the cases in `C:\Lisp Files\_ACAD_DRIVER\cases\`: `R04_ce_never_saves.review.txt`, `R11_edit_pipe_cascade_u_redo.review.txt`, `R13_cdsync_warns_then_relinks.review.txt`, `R14_cdtwl_freeboard_150.review.txt`, `R14h_dstd_200.review.txt`, `R14h_pipekey_200.review.txt`, `R14h_both_200.review.txt`, `R19_erase_pit_keeps_pipes_u_restores.review.txt`, `R21_cdcheck_totals_add_up.review.txt`, `R26_cdsurvey_refusal_stores_nothing.review.txt`. Copies of the same ten are in `areas\runner-reports\reviews\`.
3. Scratch on this PC only: `C:\ce-fx\opus_b5rev\` (ledger query, run extract, review writer, gate check). Undo: delete the ten review files (the five old ones are quoted above) and revert this commit.

## Summary (under 100 words)

All seven cases passed twice on identical installed builds (Civil 3.0.80, Manager 1.1.80, Structural 1.0.125) with every twin failing for the right reason. R14 (CDTWL freeboard, plus the 200 mm raised setting) and R19 (one-pipe erase) are ready whole; R04, R11, R13, R21 and R26 are ready only for the part they check. Ten review files written. The "CDTWL freeboard" check is newly whole; no D-card newly whole; no bug newly FIXED. The regrade report missed one settings change (Structural's first start after its install). Freeboard key precedence is untested.
