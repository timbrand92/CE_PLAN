# Runner case review, cx_cr16: R19b, R20 and R23 (Codex independent review, Mon 26 Oct 2026)

Written Mon 26 Oct 2026, about 17:50 Melbourne (AEDT, UTC+11), by Codex (GPT-6). I read the rules, acceptance decision, earlier reviews, cards, bug entries, case and variant text, installed DLL versions and recorded results. No AutoCAD, runner, case, build or test was run; no case, setup, settings, ledger, run report or bug entry changed. Only this report and three permitted independent review files are written.

## FOR TIM

1. **None of these three cases is accepted on installed Civil 3.0.79 yet.** All three checks are sound and passed twice on Civil 3.0.78 this morning. Each needs two separate AutoCAD sessions on 3.0.79.

2. **The earlier results prove useful drawing work.** Erasing P3 leaves its six pipes and one U brings the pit back; CDEDIT returns the selected pipes; a locked pipe layer gets a clear refusal.

3. **No bug may gain a 3.0.79 fixed label from this review.** BUG-384's existing acceptance on 3.0.75 remains historical evidence, now supported on 3.0.78 too. Two locked pipes get a lock message instead of a misleading label-record message.

4. **The robot owner has the next action; nothing needs your testing.** Run each unchanged case twice on 3.0.79 in separate AutoCAD starts. I have not run them or looked at any window.

---

## ANSWER FIRST

1. **Counts: one main verdict per case, against the installed build.**
   1. **CLAUDE-ACCEPTED-READY: 0 on Civil 3.0.79.**
   2. **NEEDS RUNS: 3:** R19b, R20, R23; each has zero current-hash PASS sessions on the installed build and needs two more.
   3. **NEEDS BROKEN VARIANT: 0. NEEDS STRONGER ASSERTION: 0. PARTIAL: 0. NEEDS CODEX LOOK: 0. FAIL = real fault: 0.**
   4. **Older-build text verdict: CLAUDE-ACCEPTED-READY for all three on Civil 3.0.78.** This uses the brief's explicit older-build exception. Three review files are refreshed for their exact current hashes; their VERDICT and DETAIL lines say the passes are on the older build. These are not acceptances on 3.0.79.

2. **Installed DLLs, read directly at about 17:48 and checked again at 17:50.**
   1. **Civil:** Legacy, Modern and Net8 each read ProductVersion 3.0.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa.
   2. **Manager:** Legacy, Modern and Net8 each read 1.1.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa.
   3. **Structural:** Legacy, Modern and Net8 each read 1.0.124+3a3caac5db7687f1b5d1a6e09571976c52b2b05a.
   4. **Bundle Contents creation times:** Civil 26 Oct 16:57:58.752; Manager 26 Oct 16:57:59.827; Structural 25 Oct 17:41:13.576. All times in this report are Melbourne. The desk log records the Civil/Manager install as 16:58.
   5. **Actual installed ledger key:** civil 3.0.79+d3f9c5df / struc 1.0.124+3a3caac5 / mgr 1.1.79+d3f9c5df. None of the three cases has a row on it in the 602-row ledger snapshot.

3. **Install boundaries, checked against preserved bundle Contents folders and Modern DLL ProductVersions.**
   1. **Civil 3.0.73:** Contents created 24 Oct 11:35:55.808, version 3.0.73+5467f7053a2e9275cb450409c142ef9aa26dad53. Structural changed to 1.0.123 at 12:42:11.854. R20's red report runs 12:04:23 to 12:12:41, before that change.
   2. **Civil 3.0.74:** Contents created 24 Oct 17:19:58.480; next Civil install 25 Oct 03:33:02.025. R20's h3 and t1 ledger times, 17:33:59 and 17:42:09, fall inside that interval.
   3. **Civil 3.0.75:** Contents created 25 Oct 03:33:02.025, version 3.0.75+2c805a39733ea4649b4273f1f425a37cda463046. Next full-key change was Structural at 17:41:13.576; next Civil install was 20:42:01.593. The counted historical red reports b2d1 and b3bd1 run 07:58:16-08:03:51 and 15:08:10-15:16:39, before either change.
   4. **Civil 3.0.77:** Contents created 25 Oct 20:42:01.593, version 3.0.77+0d8850949cb764e4b3af36f99276b74312584ce5; next Civil install 26 Oct 05:41:30.578. Matching rows at 21:18:50, 21:21:38, 22:21:02 and 22:24:15 fall inside.
   5. **Civil 3.0.78:** preserved Civil Contents created 26 Oct 05:41:30.578 and Manager 05:41:31.142. DLLs read 3.0.78+d8840a0920f97fedc3b94f98e56eb5a4eb6b663e and 1.1.78+d8840a0920f97fedc3b94f98e56eb5a4eb6b663e. Replaced by 3.0.79 at about 16:58.
   6. **No counted run straddles an install.** The four 3.0.78 reports run between 10:58:05 and 11:56:09 on 26 Oct, well after the 05:41 install and before the 16:58 replacement. The three historical red reports also lie entirely inside their installation intervals.

4. **Every counted pair: full session IDs and ledger times, all on 26 Oct.**
   1. **R19b:** RUN-20261026-1103-C3.0.78-g78a3-s1, started 11:03:12, ledger at/finished 11:05:39; and RUN-20261026-1153-C3.0.78-g78b3-s1, started 11:53:26, at/finished 11:56:09.
   2. **R20:** RUN-20261026-1058-C3.0.78-g78a2-s1, started 10:58:07, at/finished 11:03:05; and RUN-20261026-1149-C3.0.78-g78b2-s1, started 11:49:06, at/finished 11:53:17.
   3. **R23:** the same g78a2-s1 and g78b2-s1 sessions as R20. Each pair consists of different AutoCAD starts, not repeated rows in one start.
   4. **Same full build string for all six PASS rows:** civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09. It matches the preserved 3.0.78 DLLs, not today's installed 3.0.79 DLLs.
   5. **Report checks:** matching case hashes, no shared setup, PASS for each case, clean session ends, fixture fingerprint 34BBE37C2EA4. JSON check lines and Markdown reports agree. R19b has 13 checks and 2 record-only lines; R20 has 7 checks and 5 records; R23 has 7 checks and 3 records. Records are not extra assertions.

5. **Ledger row audit, not an inferred count.**
   1. **R19b:** 6 current-hash PASS rows, 0 current-hash FAIL; two sessions each on 3.0.75, 3.0.77 and 3.0.78. Seven older-text PASS rows excluded.
   2. **R20:** 11 current-hash PASS rows, 0 current-hash FAIL. Two on 3.0.73 with Structural 1.0.122; one on 3.0.73 with Structural 1.0.123; two each on 3.0.74, 3.0.75, 3.0.77 and 3.0.78. Four older-text PASS rows excluded. The Structural versions give different build keys and are not pooled.
   3. **R23:** 6 current-hash PASS rows, 0 current-hash FAIL; two sessions each on 3.0.75, 3.0.77 and 3.0.78. Two older-text PASS rows excluded; the old-hash R23_BROKEN red is also excluded.
   4. **Historical inventory only:** the earlier pairs are not needed for this decision. The formally counted pairs are the 3.0.78 pairs in item 4. No current-hash standing FAIL was found on any build for these three cases.
   5. **No SETUP files apply.** None of the three cases or five variants has a SETUP directive. There is no setup file to hash for this brief. The general review-gate omission of setup hashes affects other cases.

6. **Reds: variant hashes checked against the actual rows and reports.**
   1. **R19b_COUNT_BROKEN:** RUN-20261025-1508-C3.0.75-b3bd1, session suffix -s1, at 25 Oct 15:16:39, FAIL, variant_of R19b, from_check true. Check 7 reads 1030 against 1031 after an extra text is really erased. All six pipe checks still pass. This is the valid true red.
   2. **R19b_BROKEN:** same run/session/time, FAIL, variant_of R19b, from_check true. Check 1 expects seven pipes while the sentence says six: a weaker flipped red. Another matching red exists in b2d2 at 08:07:20; it is not needed.
   3. **R19b_PIPE_BROKEN:** b3bd1, FAIL, current hash, but from_check false. Step 12, ent-read 109E23, stops with E_FAIL before assertions. It is NOT a qualifying red and is not counted.
   4. **R20_BROKEN:** RUN-20261024-1204-C3.0.73-p3b2fixA2-s1, ledger at 24 Oct 12:12:41, FAIL, variant_of R20, from_check true. The actual deselect produces "pick-first set: 0 object(s)" and check 1 fails. This session ended 12:09:57; the ledger time is the pack-end time.
   5. **R23_BROKEN:** RUN-20261025-0758-C3.0.75-b2d1-s1, at 25 Oct 08:03:51, FAIL, variant_of R23, from_check true. Omitting the lock opens Edit Pipe and Edit 2 Pipes; checks 1, 2, 3 and 5 fail for the intended reason.
   6. **Limits:** these reds are on older builds. I drove no pre-fix binary. No broken-variant result is being passed off as a product fault.

7. **Daily tools and gap-plan items: this three-case scope only.**
   1. **D14 / section 2 item 14, UX-EDIT-01:** whole D14 as written, supported on older 3.0.78 by R19b; not accepted on installed 3.0.79.
   2. **D17 / section 2 item 17, UX-STD-06:** whole D17 as written, supported on older 3.0.78 by R20; not accepted on installed 3.0.79.
   3. **Contribution to section 3 item 7:** 0 of the stated 40 on the installed build; 2 whole items on an older build. These are existing acceptances rechecked, not two new tools. R23 contributes no D-number or daily-tool item. This is not a whole-release recount.

8. **Bugs and suggested wording; no entries changed.**
   1. **May be written FIXED (Claude-accepted, Civil 3.0.79, 26 Oct 2026): none.** BUG-384 needs two current-hash sessions on 3.0.79 first.
   2. **BUG-384 has older-build support.** Suggested addition: "Rechecked, Claude-accepted on Civil 3.0.78, 26 Oct 2026: R23 g78a2-s1 and g78b2-s1; current-hash true red R23_BROKEN b2d1. CDEDIT refuses one and two pipes on the locked layer, names the lock, says nothing changed and CE will not unlock it. Civil 3.0.79 needs two fresh sessions." Preserve the existing 3.0.75 fixed history; never close or delete the entry (D6).
   3. **BUG-797 and BUG-254: not proved.** No level cascade, CDPROPAGATE, locked-pit record write or temporary unlock behaviour is exercised. BUG-862 outcome wording is not asserted. R19b's M2 family reference proves no numbered bug or OOPS.

## How I applied the four conditions

1. **Nothing needing a look:** selection handles, counts, entity reads, command-line wording and window presence do not require judging appearance. Window layout, label placement and previews are not accepted here.
2. **Two separate sessions:** satisfied on older Civil 3.0.78 only; missing on installed Civil 3.0.79.
3. **Red before green:** one genuine check-failing broken variant per case, with ages and exclusions stated above.
4. **Whole card or claimed bug:** compared line by line below. I accept D14 and D17 as their written assertions define them, and BUG-384's wording fault. This does not approve wider link restoration, all native protections or engineering values.

## The cases

1. **R19b: erasing P3 with six pipes (D14, UX-EDIT-01).** Verdict: **NEEDS RUNS** on installed Civil 3.0.79; **CLAUDE-ACCEPTED-READY** for D14 as written on older Civil 3.0.78. Hash **3536E3A4615D**.
   1. **Asks met:** B2FIX asked for all six reads and the count immediately after ERASE; case lines 22-28 and 37-44 now do both. B3B's acceptance is independently supported by the current reports.
   2. **D14 assertion 1, card lines 449-451:** case lines 34-35 pin the plural sentence and six. Driver run 20 item C1 independently records P3's main inlet, outlet and four smaller pipes, supporting N=6.
   3. **D14 assertion 2:** lines 23-28 read 10A98D, 109E23, 109ED4, 110179, 110136 and 10A901 after ERASE; lines 37-43 assert survival. Both reports read each as CeCvlPipeObject on STORMWATER PIPE. Line 44 asserts 1031 objects immediately after ERASE.
   4. **D14 assertion 3:** lines 29-32 perform one U and read the pit and count; lines 36, 46-47 require the count restored (1034), ERASE in the U echo and pit 109D56 on STORMWATER PIT.
   5. **Method and limits:** card steps 1-2 request a preflight pit read and live schedule count. R19b uses the fixed fixture and independently documented six. Following B3B, these establish the fixture; all three assertions are covered. Schedule cells and restored link records are not read. Do not broaden "D14 as written" into proof of every restored link.
   6. **Exact next line for the robot brief:** "On Civil 3.0.79+d3f9c5df with Structural 1.0.124+3a3caac5 and Manager 1.1.79+d3f9c5df, run unchanged R19b in two separate AutoCAD starts after the install; then check both current-hash PASS rows and any later FAIL." No case assertion needs adding for this verdict.
   7. **Small points:** line 12 understates the six reads; lines 1 and 14 retain the stale schedule-close limitation. Cosmetic edits change the hash and invalidate today's pass match. No Codex look is needed for the card's assertions.

2. **R20: CDEDIT leaves the selection (D17, UX-STD-06).** Verdict: **NEEDS RUNS** on installed Civil 3.0.79; **CLAUDE-ACCEPTED-READY** for D17 on older Civil 3.0.78. Hash **4CEA23828CEF**.
   1. **Asks met:** the original review wanted a broken selection and a check that Edit Pipe closed. R20_BROKEN actually clears the selection and fails; line 41 checks the first window closed. B2 and B2FIX accepted this text.
   2. **D17 step 1 and assertion 1, card lines 522 and 527:** case lines 20-25 select 10A98D, open Edit Pipe, press Save without changing a value and read the selection. Line 37 requires one selected object, 10A98D; both reports show exactly that.
   3. **D17 step 3 and assertion 2, card lines 524 and 528:** lines 17-19 find another real pipe, 1091A0 in both reports; lines 27-34 edit and close the two-pipe window. Lines 38-40 require two objects and both handles. The exact observed selection is 10A98D,1091A0.
   4. **D17 assertion 3, card line 529:** lines 41-43 check the first window closed, batch window opened and no CE window remains. Close-V3OpenWindows tries only Cancel without saving, Cancel or Close. Its captured record is cut before the successful button, but the allowed route and closed-window check support the card.
   5. **Limit:** card step 2 asks to record DBMOD; case line 15 admits omitting it. None of D17's three assertions requires unchanged DBMOD: this is a missing diagnostic, not missing selection coverage. Save side effects are unproved. Mixed-object refusals are excluded by card line 515.
   6. **Exact next line for the robot brief:** "On Civil 3.0.79+d3f9c5df with Structural 1.0.124+3a3caac5 and Manager 1.1.79+d3f9c5df, run unchanged R20 in two separate AutoCAD starts after the install; then check both current-hash PASS rows and any later FAIL." No assertion addition required.
   7. **Optional later:** replace close-windows with the step ui-press "Edit 2 Pipes" "Cancel" -> $closed2, then ASSERT window-closed $closed2, to name the successful button explicitly. New text needs new runs. Editor appearance remains outside this review.

3. **R23: locked pipe layer, CDEDIT refuses (BUG-384; triage L2).** Verdict: **NEEDS RUNS** on installed Civil 3.0.79; **CLAUDE-ACCEPTED-READY** for BUG-384 as written on older Civil 3.0.78. Hash **47044D1E70E6**.
   1. **Asks met:** B2 required the whole batch refusal, exclusion of "label records do not match" and BUG BUG-384. These are at lines 49, 50 and 11. B2FIX's accepted wording survives.
   2. **Against BUG-384, BUG_CARPARK line 3700:** the entry defines a wording-only fault at batch-editor open. Driver run 20 C6 confirms the lock caused the old refusal blaming labels. Lines 29-38 drive that refusal route, with an extra single-pipe control.
   3. **Every expected phrase:** lines 47 and 49 require the layer name, nothing changed and CE will not unlock it. Line 50 rejects the old blame. Lines 48, 51-52 require no editor; line 53 compares monitored IL text lists. Both reports pass all seven checks.
   4. **Boundary:** the whole BUG-384 wording fault is covered, not the whole native protection rule. Lock flags, hidden records, mixed locked/unlocked selections, locked pits, Xrefs and cascades are untested. A second refusal cannot exclude temporary unlocking/relocking. PROVES_BUGS claims only BUG-384, appropriately.
   5. **Exact next line for the robot brief:** "On Civil 3.0.79+d3f9c5df with Structural 1.0.124+3a3caac5 and Manager 1.1.79+d3f9c5df, run unchanged R23 in two separate AutoCAD starts after the install; then check both current-hash PASS rows and any later FAIL." No assertion addition required for BUG-384.
   6. **Cosmetic tightening later:** line 4 names BUG-797 although lines 12 and 15 exclude it. Suggested replacement: PLAN_ITEM Native protection rule: CDEDIT locked pipe layer refusal only (triage group L2); BUG-384 batch wording. The PROVES_BUGS claim already has the right limit. No Codex look is required for this wording bug.

## Things the desk should know first (RULES 6.2)

1. **The 07:10 lead is out of date now.** Installed Civil is 3.0.79. R19b/R20/R23 have 6/11/6 matching PASS rows, not 4/9/4; two more each arrived on 3.0.78 after the lead. This is later evidence, not proof the lead was wrong at 07:10.
2. **Earlier ready totals cannot carry onto a newer install.** B3B's eight on 3.0.75 was a dated claim. This review establishes only its two daily cards on 3.0.78 and zero on installed 3.0.79.
3. **R19b_PIPE_BROKEN is not a valid red.** Its header calls it a true red and the old review included "tool-error red" beside valid reds. The row says from_check false; the report says E_FAIL. The count variant supplies the valid red.
4. **Printed prose is not restored-link proof.** "U restores everything" is a checked command-line promise. R19b does not read restored link records; case line 15 and the refreshed review retain that limit.
5. **Independent review gate checked, not executed:** case_runner.ps1 lines 116-127 require a verdict at line start, matching case hash and non-builder REVIEWER. This function does not bind a review to the installed build or hash SETUP dependencies. Build and red eligibility were checked separately here.
6. **No engineering decision:** fixture counts and text are observations, not approval of pipe sizes, levels, council requirements or design rules. Those still need Tim's word.

## Hashes read now

1. **R19b:** 3536E3A4615D3BAD4FC45895769C6E70CDAD640EE35D9CA7B71948947B4984B0.
2. **R20:** 4CEA23828CEF576507C0B33CC7349C0AC4B277A4465A4EF04F98CDB1DF376CDE.
3. **R23:** 47044D1E70E6536E8BC049CEC49362BD62D2A1C5A4EF0C4C6A614EC780AAD1A3.
4. **R19b_BROKEN:** 4729BB887F19327CFAC1070A25B8B3BD6D9FFC7AB65E40E0A4B4D99116D65FD1.
5. **R19b_COUNT_BROKEN:** 519375085E7CC43CB4DCD3AFEFB2EDAB6F0CF61D55D9AC758EAAE8049388D8E6.
6. **R19b_PIPE_BROKEN:** 0B5739E993B435638680ACC586C419E0142A7FBCF65E3FFB60B71C4828BDA09F.
7. **R20_BROKEN:** 3F7D66A63C6B77F022A7162955BC9375B969AC6F788B9156AA10E6F468EF43E8.
8. **R23_BROKEN:** D24705FB81601486F674A624A45A90EC3EC959EC4C401F67D7E0CD8306B12198.
9. **Review match:** all three existing review hashes matched before replacement. Each refreshed file is read back and compared with a fresh Get-FileHash of its case. No case bytes changed.

## What I read

1. **Authority and method:** RULES.md in full, ROUTER.md, the 24 Oct acceptance decision, CE_PLAN start/map material, B3FIX and B3B reviews in full; Get-CaseIndependentReview and the R16 review-file example.
2. **History:** every RUNNER_CASE_REVIEW_*.md was searched for all three IDs. Matches were in R11_R20, B2, B2FIX, B3, B3FIX and B3B. Relevant per-case sections, asks, verdicts and summary references were read.
3. **Contracts:** DAILY_TOOLS_TEST_CASES_2026-10-23.md D14 lines 432-454 and D17 lines 511-532; RELEASE_9NOV_GAP_PLAN_2026-10-22.md sections 2 and 3 item 7; BUG_CARPARK entries BUG-384, BUG-797 and BUG-254; DRIVER_RUN20_2026-10-04.md C1 and C6. No C-number card is claimed.
4. **Case material:** three cases, five variants and three existing review files under C:\Lisp Files\_ACAD_DRIVER\cases; Close-V3OpenWindows in acad_driver_v3_session.ps1, text only.
5. **Ledger and reports:** matching rows from C:\CE_PLAN\areas\runner-reports\ledger.json, 602 rows in the snapshot. JSON and Markdown reports g78a2, g78b2, g78a3, g78b3, b3bd1, b2d1 and p3b2fixA2 for the identified checks/session metadata. Full run IDs are above.
6. **Installed files:** nine product DLLs beneath C:\Users\TimothyBrand\AppData\Roaming\Autodesk\ApplicationPlugins; live Contents times; preserved folders CE_CVL_SUITE_PRE_5467f705_20261024-171857.backup, PRE_a15b414c_20261025-033200.backup, PRE_2c805a39_20261025-204100.backup, PRE_0d885094_20261026-054029.backup and PRE_d8840a09_20261026-165657.backup; corresponding 3.0.78 Manager backup and Structural PRE_4af3f37d_20261025-174012.backup Contents. Relevant desk log install entries were read. No installed assembly was executed.

## What I did NOT check

1. **Nothing run:** no AutoCAD, runner, case, variant, v2 driver, lock, settings guard, build, installation or test execution.
2. **No pictures:** editor appearance, label positions and previews remain outside these claims.
3. **No hidden-state proof:** restored links/schedule updates, Save side effects, record integrity and temporary layer unlocking remain unproved.
4. **No live settings or drawing edited:** I relied on report evidence; did not inspect settings-file contents or open the fixture.
5. **No wider claim:** other cases, tools and bugs were not re-reviewed; no source-code correctness or engineering approval.
6. **No status entries edited:** BUG_CARPARK, DESK_LOG, QUEUE, ledger, reports, cases, variants and setups were untouched.

## Files written

1. **Report:** C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr16.md. Only this named report is staged, committed and pushed.
2. **R19b review:** C:\Lisp Files\_ACAD_DRIVER\cases\R19b_erase_pit_with_several_pipes.review.txt.
3. **R20 review:** C:\Lisp Files\_ACAD_DRIVER\cases\R20_cdedit_keeps_selection.review.txt.
4. **R23 review:** C:\Lisp Files\_ACAD_DRIVER\cases\R23_locked_pipe_layer_cdedit_refuses.review.txt.
5. **Scope and undo:** review files are local, not pushed. They record this independent judgement for unchanged hashes, explicitly limited to older Civil 3.0.78. Reverting the report commit does not alter cases or evidence.

## Summary

All three case texts are Claude-accepted-ready on older Civil 3.0.78. Installed Civil is 3.0.79: each case needs two fresh sessions there, so none counts on the installed build. D14 and D17 retain older-build acceptance; BUG-384 retains older-build wording proof. The pipe-erasure tool error is excluded as a red; the extra-erasure count variant supplies a valid red. Three exact-hash review files were refreshed with explicit build limits. Nothing was run and no bug entry changed.

