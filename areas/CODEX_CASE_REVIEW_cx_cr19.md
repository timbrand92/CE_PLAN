# Runner case review, cx_cr19: R38, R39 and R39b (Codex independent review, Mon 26 Oct 2026)

Written Mon 26 Oct 2026, about 18:00 Melbourne, by Codex (GPT-6). I read the rules, acceptance decision, both complete model reviews, prior sections, cases, variants, cards, bugs, installed DLL versions and recorded evidence. I ran no AutoCAD, runner, case, build or test, took no lock and changed no settings, ledger, run report or bug entry. Only this report and the three permitted review files are written.

## FOR TIM

1. **None of these three cases is accepted on the installed Civil 3.0.79 yet.** Each needs two passing AutoCAD sessions on that build. All three retain acceptance for their stated scope on the older Civil 3.0.78.
2. **The old results are useful.** P3's schedule shows levels 17.30 and 17.25 found near P3 on the plan. CD accepts a line you drew, refuses a second pipe over an existing CE pipe, and keeps curved or closed source lines with a warning.
3. **No bug may be newly labelled fixed on 3.0.79 from this review.** BUG-697 and BUG-684 have evidence on 3.0.78. BUG-376 remains unproved: finding two nearby levels does not prove that the schedule recovers a missing level from the correct pipe end.
4. **No everyday-tool total increases.** These checks do not prove schedule sorting, Excel export or Esc at CD's third point. For example, a correct P3 row could still sit in a wrongly sorted schedule.
5. **Nothing needs your decision now.** This review does not approve pipe sizing, grades or the choice to use straight chords for a curved route. Those engineering decisions remain yours.

---

## ANSWER FIRST

1. **Counts, one primary verdict per case on the installed build:**
   1. **CLAUDE-ACCEPTED-READY: 0 on installed Civil 3.0.79.**
   2. **NEEDS RUNS: 3.** R38, R39 and R39b each have zero current-hash PASS sessions on 3.0.79; each needs two more distinct sessions on that build.
   3. **NEEDS BROKEN VARIANT: 0. NEEDS STRONGER ASSERTION: 0. PARTIAL: 0. NEEDS CODEX LOOK: 0. FAIL = real fault: 0.** These counts concern the bounded claims below, not the whole Pit Schedule or whole CD feature.
   4. **Historical text verdicts: CLAUDE-ACCEPTED-READY: 3 on Civil 3.0.78+d8840a09.** The brief expressly allows this older-build judgement and matching review files. This is a separate historical count, not three extra cases. R38 is only the explicitly narrowed P3 level guard; R39 and R39b jointly cover BUG-697, and R39b covers BUG-684 as written.

2. **Installed build, read directly at 17:57 Melbourne:**
   1. **Civil:** Legacy, Modern and Net8 each read ProductVersion 3.0.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa. Contents creation: 26 Oct 2026 16:57:58.752 +11:00.
   2. **Manager:** Legacy, Modern and Net8 each read 1.1.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa. Contents creation: 26 Oct 2026 16:57:59.828 +11:00.
   3. **Structural:** Legacy, Modern and Net8 each read 1.0.124+3a3caac5db7687f1b5d1a6e09571976c52b2b05a. Contents creation: 25 Oct 2026 17:41:13.577 +11:00.
   4. **Paths:** all nine DLLs are under C:\Users\TimothyBrand\AppData\Roaming\Autodesk\ApplicationPlugins, in the respective CE_CVL_SUITE.bundle, CE_SUITE_MANAGER.bundle and CE_STRUC_SUITE.bundle, Contents\Win64\<lane>.
   5. **Build comparison:** the latest counted pair carries the exact ledger build string "civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09". Civil and Manager differ from the installed versions; Structural matches. The full 3.0.78 ProductVersion in the JSON headers matches the backup DLL I read, not the current DLL.

3. **Install boundaries, verified from retained Contents folders and DLLs, Melbourne time:**
   1. **3.0.75:** Civil Contents created 25 Oct 03:33:02.026; Manager 03:33:02.891. Retained backup CE_CVL_SUITE_PRE_2c805a39_20261025-204100.backup holds 3.0.75+2c805a39733ea4649b4273f1f425a37cda463046. Next Civil/Manager install: 25 Oct 20:42:01.593 / 20:42:02.444.
   2. **3.0.77:** those latter creation times belong to the retained 0d885094 backup; its Civil DLL reads 3.0.77+0d8850949cb764e4b3af36f99276b74312584ce5. Next install: 26 Oct 05:41:30.579 / 05:41:31.142.
   3. **3.0.78:** those latter creation times belong to the retained d8840a09 backup; its Civil DLL reads 3.0.78+d8840a0920f97fedc3b94f98e56eb5a4eb6b663e. Next install: 26 Oct 16:57:58.752 / 16:57:59.828, now 3.0.79.
   4. **No counted run straddles an install.** All relevant 3.0.75 report spans are 25 Oct 05:26:21 to 13:29:41; all 3.0.77 spans are 21:21:42 to 22:38:25; all 3.0.78 spans are 26 Oct 11:05:44 to 12:06:06. All relevant ledger "at" times lie inside those windows. The 3.0.75 rows also precede Structural's 25 Oct 17:41 install. Folder creation is the on-disk installation marker; the desk's 17:02 entry independently records the 3.0.79 install as 16:58.

4. **Ledger and hashes, read row by row (602-row array at 17:57; relevant counts rechecked at 17:58):**
   1. **R38:** current hash 2A94934EBE91; six PASS rows in six sessions: two on 3.0.75, two on 3.0.77, two on 3.0.78. No current-hash FAIL. Three old-hash PASS rows (29174FB95553) are excluded.
   2. **R39:** current hash 0FBBAD9920F0; six PASS rows in six sessions: two on each of those builds. No current-hash FAIL. Three old-hash PASS rows (9235FDE253D9) are excluded.
   3. **R39b:** current hash CD1A7B6CAE9A; seven PASS rows in seven sessions: three on 3.0.75, two on 3.0.77, two on 3.0.78. No current-hash FAIL.
   4. **Every historical pair is within one identical full build string.** No pair combines builds or repeats one session. No row for any of these three current texts is on 3.0.79. The 07:10 leads' counts of 4, 4 and 5 are now stale, not evidence of a fault.
   5. **Review hashes:** all three existing Opus review files matched the case hashes before replacement. No stale review hash was found. All eight case/variant files were independently hashed with Get-FileHash -Algorithm SHA256; full values appear below.
   6. **SETUP:** none of the three cases or five variants contains a SETUP directive. Their steps are inline; there is no referenced setup file to hash. The latest report headers also say zero shared setups. Fixture and settings fingerprints are report evidence, not independent rehashes by this reviewer.

5. **Every counted pair, with full session identifiers and ledger "at" times:**
   1. **R38, 3.0.75:** RUN-20261025-1108-C3.0.75-b3x1-s1 (25 Oct 11:20:36) and RUN-20261025-1303-C3.0.75-b3x2-s1 (13:19:02).
   2. **R39, 3.0.75:** RUN-20261025-1121-C3.0.75-b3y1-s1 (25 Oct 11:49:14) and RUN-20261025-1319-C3.0.75-b3y2a-s1 (13:29:41).
   3. **R39b, 3.0.75:** RUN-20261025-0643-C3.0.75-pA5-s1 (25 Oct 06:55:11) and RUN-20261025-0730-C3.0.75-pB5-s1 (07:41:54). Extra PASS: RUN-20261025-0538-C3.0.75-p3b3b1-s1 (05:46:05).
   4. **R38, 3.0.77:** RUN-20261025-2121-C3.0.77-g77a5-s1 (25 Oct 21:30:03) and RUN-20261025-2224-C3.0.77-g77b5-s1 (22:32:48).
   5. **R39 and R39b, 3.0.77:** each passed in RUN-20261025-2130-C3.0.77-g77a6-s1 (25 Oct 21:36:20) and RUN-20261025-2232-C3.0.77-g77b6-s1 (22:38:25).
   6. **R38, 3.0.78, the pair used for this review file:** RUN-20261026-1105-C3.0.78-g78a4-s1 (26 Oct 11:10:52) and RUN-20261026-1156-C3.0.78-g78b4-s1 (12:02:09). Whole-run spans: 11:05:44-11:10:52 and 11:56:12-12:02:09.
   7. **R39 and R39b, 3.0.78, the pair used for their review files:** each passed in RUN-20261026-1110-C3.0.78-g78a5-s1 (26 Oct 11:15:11) and RUN-20261026-1202-C3.0.78-g78b5-s1 (12:06:06). Whole-run spans: 11:10:58-11:15:11 and 12:02:10-12:06:06.
   8. **Session evidence:** the four 3.0.78 reports identify separate starts, AutoCAD 2027, clean ends and zero settings fingerprint differences. I read their assertion results, rather than relying on their ACCEPTED-READY headings.

6. **Reds, all on current variant hashes, result FAIL, correct variant_of, from_check true:**
   1. **R38_BROKEN, 316CB69C4EC3:** RUN-20261025-1108-C3.0.75-b3x1, at 11:20:36. Both checks fail because 17.99 is absent from P3's schedule row and plan text. A weaker flipped red, despite its header calling it a true red.
   2. **R38_NEAR_BROKEN, 2047763BFEE3:** same run/time. The search 10 m south of P3 returns an empty handle string; matches $in_near "^[0-9A-F]+$" fails. A true changed-input red for the proximity check.
   3. **R39_BROKEN, 966E9D6D4FD7:** RUN-20261025-1121-C3.0.75-b3y1, at 11:49:14. The point misses the line; no New Pipe window, and "Nothing Selected" is present. Both checks fail. A true changed-input red.
   4. **R39_SECOND_BROKEN, 62F2C0411E3E:** same run/time. not-contains $cd2 "already a CE pipe" fails because that message is present. A weaker flipped red, not a second true red.
   5. **R39b_BROKEN, 735548E03CFD:** RUN-20261025-0538-C3.0.75-p3b3b1, at 05:46:05. Removing the arc produces zero curved-side warning lines and zero remaining source objects; both checks fail. A true changed-input red.
   6. **Nature of the evidence:** these are assertion failures, with no case error in the inspected JSON, not crashes, timeouts or E_FAIL. They prove the named checks discriminate; they are not runs of the original unfixed plugin. Supplemental ledger reds exist, but the five rows above are sufficient and their JSON/Markdown failure lines were read.

7. **Daily tools and the gap plan: zero whole items from this brief, on the installed build or any build.**
   1. **D04 / gap-plan section 2 item 4, UX-PIPE-03:** not counted. R39/R39b use Existing line; they do not drive Esc at the third point or its contrast run (card lines 178-199).
   2. **D21 / section 2 item 21, UX-SCHED-06:** not counted. R38 does not create P8-P10 or compare natural order/groups (card lines 610-633).
   3. **D23 / section 2 item 23, UX-SCHED-02:** not counted. R38 does not export Excel, inspect the Checking sheet or compare its contents (card lines 664-686).
   4. **Section 3 item 7, "CDSYNC keeps the schedule":** not counted. R38 opens the schedule once; it does not run CDSYNC or compare every row before and after it. No C-number card is claimed by these three case PLAN_ITEM lines.
   5. **Scope of the count:** this is the contribution of these three cases only. I have not recounted the other cases or adopted an earlier overall 8-of-40 figure.

8. **Bugs that may be written "FIXED (Claude-accepted, Civil 3.0.79+d3f9c5df, 26 Oct 2026)": none.**
   1. **BUG-697:** not on 3.0.79 yet; R39 and R39b each need two current-build sessions. Historical wording supported: "FIXED (Claude-accepted, Civil 3.0.78+d8840a09, 26 Oct 2026): R39 and R39b, g78a5-s1 and g78b5-s1; open and closed drawn lines accepted, existing CE pipe refused without a duplicate; current-hash reds R39_BROKEN, R39_SECOND_BROKEN (flipped) and R39b_BROKEN on 3.0.75. Not re-proved on installed 3.0.79."
   2. **BUG-684:** not on 3.0.79 yet; R39b needs two current-build sessions. Historical wording supported: "FIXED (Claude-accepted, Civil 3.0.78+d8840a09, 26 Oct 2026): R39b, g78a5-s1 and g78b5-s1; curved and closed source lines kept with the stated warnings; current-hash true red R39b_BROKEN p3b3b1 on 3.0.75. Exact pipe geometry and engineering suitability not accepted; not re-proved on installed 3.0.79."
   3. **BUG-376:** not proved on any build by R38. BUG_CARPARK lines 3752-3756 require the correct pipe-end text fallback, including the 18.10 example and an unknown-value explanation. R38 deliberately dropped that claim.
   4. **D6:** suggested wording only. No entry was edited, closed or deleted.

## How I applied the four conditions

1. **Nothing needing a visual judgement:** accepted scope uses drawing text, object counts, retained handles, command messages, window presence and a file hash. No window layout, label placement or preview is accepted.
2. **Two sessions on one build:** satisfied historically on 3.0.78; unsatisfied on installed 3.0.79. The brief's older-build exception is explicitly applied in every new review file.
3. **Red before green:** current-hash changed-input variants and weaker flipped variants are separated above.
4. **Card or bug comparison and whole coverage:** line-by-line mapping follows. R38's accepted unit is its deliberately narrowed guard, not a daily-tool card or bug. R39 requires R39b for BUG-697's closed-line example.

## The cases

1. **R38: Pit Schedule P3 level guard. Verdict: NEEDS RUNS on installed 3.0.79; CLAUDE-ACCEPTED-READY for the exact current text's narrow guard on older 3.0.78. Hash 2A94934EBE91.**
   1. **Asks met:** B3 item 10 asked to tie levels to P3 and either check 18.10 or drop BUG-376. Case lines 30-43 and 63-66 find the two levels within 2500 mm; lines 4, 9 and 15 drop the bug claim. B3FIX item 18 accepted this narrowed scope; its optional handle separation remains undone.
   2. **Comparison:** PLAN_ITEM line 4 and limits 15-17 define the guard. Lines 59-60 pin P3, FROM P4, 17.30, 17.25 and 18.88 within one row; lines 61-64 read matching nearby plan texts. Lines 68-70 check Close and the file on disk. On both 3.0.78 passes the handles are 1155B6 and 1101B8, with unchanged drawing-file hash.
   3. **Whole-item boundary:** BUG-376 lines 3754-3756 concern different inlet evidence and fallback behaviour, not merely matching nearby numbers. D21 assertions at 627-630 and D23 at 680-683 are not exercised. The proximity check is not a mapping from each text to a particular pipe end.
   4. **Unasserted numbers:** EXPECTED line 13 names two 450 mm diameters, but no ASSERT pins them. The dump contains both 450 values; the case would still pass with wrong diameters. They are excluded from this narrow level acceptance. It also does not assert the 900 x 900 size or 1.63 depth mentioned in its header.
   5. **Exact optional strengthening:** to claim both diameters, replace line 60 with matches $psd "name.:.Pit P3.,.id(?:(?!name.:.Pit ).)*?name.:.P4.,.id(?:(?!name.:.Pit ).)*?name.:.450.,.id(?:(?!name.:.Pit ).)*?name.:.17\.30.,.id(?:(?!name.:.Pit ).)*?name.:.450.,.id(?:(?!name.:.Pit ).)*?name.:.17\.25.,.id(?:(?!name.:.Pit ).)*?name.:.18\.88.,.id". After that edit, obtain new-hash passes and a flipped diameter red.
   6. **Exact optional uniqueness fix:** line 36 becomes set $in_near "{$inh0}|{$inh5}|{$inh10}", line 43 becomes set $out_near "{$outh0}|{$outh5}|{$outh10}", and the corresponding ASSERT patterns become "^\|*[0-9A-F]+\|*$". At present two handles in different chunks can concatenate into one valid-looking hex string. This does not invalidate the actual recorded single handles or the bounded claim that those levels exist nearby.
   7. **Exact remaining action for the current verdict:** no case line is required for the narrow guard. Desk instruction: "After the installation is stable, run unchanged R38 in two separate AutoCAD sessions on Civil 3.0.79+d3f9c5df; record its exact current hash in each PASS row." Zero such sessions exist; two more are required.
   8. **Codex look:** schedule appearance remains outside this acceptance (the case routes it to R25). Neither its "changes nothing" title nor copy-unchanged proves unchanged in-memory DBMOD; the accepted no-change claim is the file on disk.

2. **R39: CD uses an open line I drew, and refuses an existing CE pipe. Verdict: NEEDS RUNS on installed 3.0.79; CLAUDE-ACCEPTED-READY on older 3.0.78, with R39b for the whole BUG-697. Hash 0FBBAD9920F0.**
   1. **Asks met:** B3 item 11's expected message is now line 55; its second CD/E route is lines 44-49 and assertions 58-61; its anchored grade pattern is line 57. All are present and pass in both reviewed 3.0.78 sessions.
   2. **Against BUG-697 lines 11554-11556:** lines 20-27 create and pick a plain open three-point polyline; 52-55 require New Pipe and the intended route message without false refusal. Lines 29-42 and 56-57, 62-63 require one pipe, the label and typed levels. Lines 44-49, 58-61 then require the genuine existing-pipe refusal once, no New Pipe and still one pipe.
   3. **Recorded result:** both runs read "225 DIA. UPVC PIPE AT 1 IN 101", IL 18.000 / 17.900 and one pipe after the second attempt. R39b supplies the closed-rectangle example, with its own warning and new pipe. BUG-697 is fully covered jointly, not by R39 alone.
   4. **Reds:** the missed pick is a true red; the second refusal check's red flips the expectation. B3FIX case item 19's phrase "Two true reds" is wrong; its own conditions section correctly calls the second one flipped.
   5. **Exact remaining action:** no case line needs adding for BUG-697. Desk instruction: "After the installation is stable, run unchanged R39 and R39b in two separate AutoCAD sessions on Civil 3.0.79+d3f9c5df; record each current hash." R39 needs two more passing sessions; do not combine a 3.0.78 pass with a 3.0.79 pass.
   6. **Limits and Codex look:** exact route vertices are not compared (case line 16), and source-line replacement is recorded only. The New Pipe layout, plan label appearance and engineering suitability of the chosen levels/grade are not accepted.

3. **R39b: CD warns and keeps curved and closed source lines. Verdict: NEEDS RUNS on installed 3.0.79; CLAUDE-ACCEPTED-READY for BUG-684 as written on older 3.0.78. Hash CD1A7B6CAE9A.**
   1. **Asks met:** B3 item 12 required the warnings and retained original polylines; no later R39b strengthening request appeared in the matching RUNNER_CASE_REVIEW sections. Both full warnings remain asserted.
   2. **Against BUG-684 lines 2436-2440:** line 19 draws an arc segment; lines 23-37 retain its original handle and check the pipe. Line 39 draws a closed four-corner line; lines 43-57 repeat the check. Assertions 60-65 pin both warnings, both retained sources and pipe counts one then two.
   3. **Source evidence:** both 3.0.78 records identify arc source 11C559 and closed source 11C591 as AcDbPolyline on BLOCKS, distinct from CE pipes 11C55A and 11C592. This is read evidence, not an assumption that a surviving handle must still be a source line.
   4. **Small point:** the ASSERTs count those source handles; their object types are recorded, not explicitly asserted. Optional strengthening after line 36: select $arc_after "object~^AcDbPolyline$" -> $arc_kept, then ASSERT count $arc_kept = 1. After line 56, use select $cl_after "object~^AcDbPolyline$" -> $cl_kept, then ASSERT count $cl_kept = 1. These additions require new-hash runs.
   5. **BUG-697 contribution:** the closed line reaches Start Pipe and adds the second CE pipe; the record reads "Using the drawn line (4 points) as the pipe route." The case's formal PROVES_BUGS remains BUG-684; this observed route supplies BUG-697's closed-line evidence without relabelling the case.
   6. **Exact remaining action:** no case line is required for BUG-684's warning-and-keep contract. Desk instruction: "After the installation is stable, run unchanged R39b in two separate AutoCAD sessions on Civil 3.0.79+d3f9c5df; record its exact current hash." Two more passing sessions are required.
   7. **Engineering and Codex look:** the bug explicitly permits warning instead of refusal. This does not accept the chord length, grade calculation or precise drawn geometry; the case says these are unmeasured. Any decision to forbid curved routes needs Tim's word. Window and drawing appearance remain unreviewed.

## Things the desk should know first (RULES 6.2)

1. **The brief's installed-build expectation is stale.** Civil/Manager 3.0.79/1.1.79 are installed, not 3.0.78/1.1.78. Two 3.0.78 passes now exist for each case, but they predate the new install.
2. **BUG-697's status note is incomplete.** Line 11560 says the genuine CE-pipe refusal is a separate check. It is already exercised by R39 lines 44-61 and passed in both inspected 3.0.78 sessions. Do not leave the desk believing that half was never checked.
3. **BUG-684's note about that refusal is not its own expected contract.** BUG-684 asks for warnings/refusal and retained source lines; the already-a-pipe distinction belongs to BUG-697 and is covered by R39.
4. **R38 is not a BUG-376 fix.** Its claim was deliberately removed, and its current text says so. Reading 18.10's x positions is record-only, not a check that 18.10 reaches the right schedule cell.
5. **"True red" needs care.** R38_BROKEN changes an expected level; R39_SECOND_BROKEN changes an expected message. Their case text or earlier summary must not turn them into original-bug reproductions.
6. **Hash gate verified by reading, not invoking:** Get-CaseIndependentReview requires a line beginning VERDICT CLAUDE-ACCEPTED-READY, a matching 64-character CASE_SHA256_REVIEWED and a REVIEWER not beginning builder. It does not validate the build written in the review text. The rest of acceptance must still establish same-build sessions.
7. **No setup loophole affects this batch.** The generic missing-setup-hash concern in the model reviews remains relevant to other cases; these eight files have no external SETUP dependency.
8. **Stale comments:** builder-filled "Opus review still needed" remains in all three case files. It has not changed their hashes and is not the acceptance gate. I left it untouched.

## What I read

1. **Rules and method:** C:\TimOS\RULES.md completely, including the 24 Oct amendment; ROUTER.md; decisions\2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md completely; both complete B3FIX and B3B model reviews; plan entry points START_HERE.md and MASTER_PLAN.md.
2. **Prior review search:** searched every areas\RUNNER_CASE_REVIEW_*.md for R38, R39 and R39b. Matches were in B3, B3FIX, B3B and B2FIX. Read the relevant case sections, counting statements, BUG-697 recommendation and the B2FIX Pit Schedule probe. B3FIX is the latest direct R38/R39 judgement; B3 remains the direct R39b judgement.
3. **Contracts:** BUG_CARPARK.md BUG-376 (3750-3758), BUG-684 (2434-2444), BUG-697 (11550-11560); daily cards D04, D21, D23; gap-plan section 2 and section 3 item 7; triage A1 S2, S3 and N4. No claimed C-number was present.
4. **Driver text only:** all three case files, five variants, existing reviews, R16 review format and Get-CaseIndependentReview source. No script was sourced or executed.
5. **Evidence:** every matching ledger row, JSON headers/session boundaries for the nineteen relevant runs; detailed JSON assertions and matching Markdown sections for g78a4, g78b4, g78a5, g78b5, b3x1, b3y1 and p3b3b1. Historical suffixes identify full run/session IDs above.
6. **Installation:** nine live DLL ProductVersions, three live Contents creation times, relevant retained Civil/Manager backup DLLs and Contents creation times, and the desk log install entries. The report does not treat the desk notes as a substitute for these reads.

## File hashes and review records

1. **R38_pit_schedule_il_cells_match_plan.case.txt:** 2A94934EBE9120078A8DCA0F475B79EB93232B1174A2077E75F0B53AC09375C5.
2. **R39_cd_existing_line_opens_new_pipe.case.txt:** 0FBBAD9920F082D026A825999C2F6412FE2CA8401BEB06045AD9EFB223A20945.
3. **R39b_cd_existing_arc_and_closed_line_kept.case.txt:** CD1A7B6CAE9AC3A4BE04E3E6DB9D4EE73E804F1E77F76107CC0A20635E04473A.
4. **variants\R38_broken.case.txt:** 316CB69C4EC3011607B3AE5C701415379B0A2ABF7051A3505598BF251E1805B1.
5. **variants\R38_near_broken.case.txt:** 2047763BFEE382E2747D92F181566E1BAA458985B3494754218BD4DECAD5F176.
6. **variants\R39_broken.case.txt:** 966E9D6D4FD75BF954644529658795998C232CBB4CECC0F5F20CB72A8077D9FB.
7. **variants\R39_second_broken.case.txt:** 62F2C0411E3E80DADE7B863A402179B4B91F70FF7740DE95E95FBE7C647E3D47.
8. **variants\R39b_broken.case.txt:** 735548E03CFDA1E02C4688CBF176699C28A56BD9DCC5CB1B82BED00E92844A62.
9. **Review records:** the three same-basename .review.txt files beside the main cases are replaced with six-line ASCII reviews for these exact hashes. They expressly name older 3.0.78 and the missing 3.0.79 sessions, including in DETAIL. No variant review is written.
10. **Report only in git:** C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr19.md is the only file this review stages and commits. Review records remain local. Other jobs' modified or untracked files are not staged. Undo of this review is limited to this report commit and the three review records; no product behaviour changed.

## What I did NOT check

1. **No execution:** no AutoCAD, runner, v2/v3 call, lock, settings guard, build, installation or test. No sub-agents.
2. **No look:** no screenshots, windows, preview, label position, printed output or real-job drawing was examined.
3. **No engineering acceptance:** no council values, Australian Standard compliance, sizing choices, chord suitability or calculated design result was approved.
4. **No current-build behaviour:** the installed 3.0.79 has no qualifying ledger sessions for these cases at the evidence cut-off.
5. **No wider case acceptance:** no claim about other daily cards, the rest of the 40 checks, other bugs, exact pipe vertices, saved/reopened pipe behaviour or older AutoCAD runtimes.
6. **No product-code audit:** installed DLL metadata was read, not the implementation. Settings and fixture integrity are taken from the recorded run fingerprints; I did not independently inspect their contents.

## Summary

None of R38, R39 or R39b is accepted on installed Civil 3.0.79; each needs two fresh passing sessions. All three retain narrow acceptance on older 3.0.78, recorded in matching review files. BUG-697 and BUG-684 have historical support only; BUG-376 remains unproved. No whole daily-tool item is added. R38's unasserted diameters and proximity limits are recorded; two weaker flipped reds are identified. No AutoCAD, build or test was run, and no bug or ledger was changed.
