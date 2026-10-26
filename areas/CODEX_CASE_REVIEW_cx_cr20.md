# Runner case review, cx_cr20: catch-all and daily-tool tally (Codex independent review, Mon 26 Oct 2026)

Written Mon 26 Oct 2026, about 18:10 Melbourne, by Codex (GPT-6). I read the rules and acceptance amendment first, the decision, both complete model reviews, the review gate, existing certificates, relevant prior reviews, cards, installed DLL metadata and recorded results. This is an evidence-only review: no AutoCAD, runner, case, build, test, installation, lock or settings guard was run. Only this report is written.

## FOR TIM

1. **None of my three extra cases is ready for acceptance.** They show the water-level warning asking for 200 mm, but each has only one pass on each of two different Civil versions and no broken twin of its own.

2. **The daily-tool total is zero on installed Civil 3.0.79 and five on older builds.** The plan actually names 38 checks, although it calls them 40. All nineteen neighbouring reviews are now present.

3. **The next useful job is two passes of the five already sound checks on 3.0.79.** That would cover invert texts, erasing a connected pit, keeping a selection, recovery totals and the named Tidy labels preview, if they pass.

4. **No bug may be newly called fixed on 3.0.79 from this review.** On a drainage plan, a warning saying 200 mm does not establish that 200 mm is the right design clearance. That decision remains yours.

---

## ANSWER FIRST

1. **Catch-all verdict counts, one primary verdict per file:** CLAUDE-ACCEPTED-READY 0; NEEDS BROKEN VARIANT 0; NEEDS STRONGER ASSERTION 0; PARTIAL 3; NEEDS CODEX LOOK 0; FAIL = real fault 0; NEEDS RUNS 0. The three PARTIAL cases also need their own broken variants and additional sessions; those are secondary findings, not extra cases. No review.txt is written.

2. **Scope found:** 52 top-level case files, all independently hashed with Get-FileHash -Algorithm SHA256. Forty-nine are assigned to cx_cr01-cx_cr19; the remaining three are R14h_dstd_200, R14h_both_200 and R14h_pipekey_200. Their prefix R14h is not in the exclusion list. All lack a review file. No other unassigned case was present. Eight assigned texts differ from their morning brief hashes; the requested one-line warnings appear below.

3. **Neighbouring reviews:** CODEX_CASE_REVIEW_cx_cr01.md through cx_cr19.md all exist at the final evidence read. cx_cr19 was absent on the initial pass and arrived at about 18:02; I included it and read its three new certificates. It contributes no whole daily item. No brief is now missing.

4. **Installed build, read directly in all three lanes:** Civil Legacy, Modern and Net8 each read ProductVersion 3.0.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa. Manager Legacy, Modern and Net8 each read 1.1.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa. Structural Legacy, Modern and Net8 each read 1.0.124+3a3caac5db7687f1b5d1a6e09571976c52b2b05a. These are nine DLL reads, not versions copied from a desk note.

5. **Bundle times:** under C:\Users\TimothyBrand\AppData\Roaming\Autodesk\ApplicationPlugins, Civil Contents was created 26 Oct 16:57:58.752; Manager Contents 26 Oct 16:57:59.827; Structural Contents 25 Oct 17:41:13.576. All times in this report are Melbourne daylight time, UTC+11. These are on-disk installation markers, not a claim about the exact last installer write.

6. **Build-key comparison:** the installed ledger key is "civil 3.0.79+d3f9c5df / struc 1.0.124+3a3caac5 / mgr 1.1.79+d3f9c5df". Its abbreviated revision prefixes agree with the DLL ProductVersions. The five accepted historical pairs instead carry "civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09". The two keys are different; their sessions cannot be combined.

7. **Ledger:** the complete JSON array contains 602 rows, unchanged at the final read. Only seven rows use the installed key: one R14 PASS, three R14 variant FAIL rows, and one PASS for each of my three probes. No normal case has two PASS sessions on 3.0.79. All six probe rows match their current hashes; none is a FAIL. Old-hash rows contribute nothing.

8. **Daily total under the requested B3B method:** 0 whole items on installed 3.0.79; 5 whole items on any build, all supported by pairs on 3.0.78. They are D12/R03, D14/R19b, D17/R20, Recover Inverts C38/R15, and Tidy labels names the pipe C37/R16 with its switch ON. The TALLY OF THE 40 section lists each of the 38 named items once. Codex visual PASS results are listed separately and are never called Claude-accepted.

9. **Bugs eligible for the wording "FIXED (Claude-accepted, Civil 3.0.79+d3f9c5df, 26 Oct 2026)": none.** My probes have empty BUG lines and no PROVES_BUGS claim. Historical bug acceptance in the other briefs is not current-build acceptance. Suggested desk wording: "Not re-proved on installed Civil 3.0.79; retain the historical evidence and obtain the required current-hash sessions." No bug entry was closed, deleted or edited (D6).

10. **Bugs not yet, for the consolidated desk reading:** BUG-863 (cx_cr14), BUG-384 (cx_cr16), BUG-697 and BUG-684 (cx_cr19) have historical support but lack their two installed-build sessions. BUG-376 is expressly not proved by R38. BUG-856 is only the switch-ON named-preview wording, not Apply or label-position acceptance. BUG-862 is not whole-feature accepted by R01/R05. The other briefs' PARTIAL, assertion, visual and historical fault findings remain limitations; this catch-all adds no new bug judgement.

## How I applied the four conditions

1. **Nothing needing a look:** command-line words, stored text, counts and retained selections can qualify without a visual judgement. A screenshot-shaped result, window presence, or recorded number does not prove layout, label position, preview correctness or an asserted numeric outcome.

2. **Two starts on one build:** I matched complete case hashes and full ledger build keys, required different session_id values, and read session boundaries in the selected JSON reports. A later FAIL on the current hash would remain standing unless a later report establishes a run fault. None exists on the 3.0.78 hashes of the five counted cases. There is no qualifying 3.0.79 pair.

3. **A discriminating red:** the counted variant must have today's hash, the right variant_of, FAIL and from_check true, with a failed intended assertion in its report. R15 has a weaker flipped red and is labelled as such. R19b_PIPE_BROKEN stopped with E_FAIL/from_check false and is not counted. R14's reds do not belong to the R14h probes.

4. **Whole card:** I used the named daily card's assertions and the eight explicitly named regression items, not a whole command family inferred from a small check. A later independent finding that the card is only partly covered overrides an old matching certificate for tally purposes. Matching text alone is necessary but insufficient.

5. **Review gate:** Get-CaseIndependentReview reads the adjacent .review.txt; it requires a line beginning VERDICT CLAUDE-ACCEPTED-READY, CASE_SHA256_REVIEWED equal to the case SHA-256, and a REVIEWER not beginning builder. I read this function, not executed it. It does not hash SETUP dependencies or decide whether the reviewer actually covered a whole card.

## Installation windows and counted evidence

1. **Retained Civil/Manager backups establish these boundaries:** 3.0.72+f7f7d551 was created 23 Oct 18:27:04.196 / 18:27:04.783; 3.0.73+5467f705 on 24 Oct 11:35:55.808 / 11:35:56.623; 3.0.74+a15b414c on 24 Oct 17:19:58.480 / 17:19:59.002; 3.0.75+2c805a39 on 25 Oct 03:33:02.025 / 03:33:02.890; 3.0.77+0d885094 on 25 Oct 20:42:01.593 / 20:42:02.444; 3.0.78+d8840a09 on 26 Oct 05:41:30.578 / 05:41:31.142; 3.0.79 at the current times above. I read retained DLL versions with those folder times. Each window ends at the next installation, not at midnight.

2. **Structural boundaries:** the retained .122 Contents dates from 23 Oct 12:27:54.131, .123 from 24 Oct 12:42:11.854, and installed .124 from 25 Oct 17:41:13.576. A Civil-only version is not enough to identify a full ledger build. All selected .75 red evidence predates the .124 installation.

3. **No selected run crosses an install:** the historical positive reports span 26 Oct 10:58:07 to 12:30:47, safely after both .78 installations and before .79. The older probe pack spans 15:36:16-15:45:14; the current pack spans 17:21:56-17:32:17. Their ledger at values are 15:45:14 and 17:32:17 respectively. Older selected red times and their windows follow below.

### Every counted positive pair

1. **R03, hash 4384D2D7B6B9:** RUN-20261026-1115-C3.0.78-g78a6-s1, session 2026-10-26 11:15:14 to 2026-10-26 11:22:13, ledger at 2026-10-26 11:22:13; RUN-20261026-1206-C3.0.78-g78b6-s1, session 2026-10-26 12:06:09 to 2026-10-26 12:15:09, ledger at 2026-10-26 12:15:09. Two distinct sessions, identical full build key, current hashes, no current-hash FAIL on that build. Matching independent review: CODEX_CASE_REVIEW_cx_cr13.md.

2. **R19b, hash 3536E3A4615D:** RUN-20261026-1103-C3.0.78-g78a3-s1, session 2026-10-26 11:03:12 to 2026-10-26 11:05:39, ledger at 2026-10-26 11:05:39; RUN-20261026-1153-C3.0.78-g78b3-s1, session 2026-10-26 11:53:26 to 2026-10-26 11:56:09, ledger at 2026-10-26 11:56:09. Two distinct sessions, identical full build key, current hashes, no current-hash FAIL on that build. Matching independent review: CODEX_CASE_REVIEW_cx_cr16.md.

3. **R20, hash 4CEA23828CEF:** RUN-20261026-1058-C3.0.78-g78a2-s1, session 2026-10-26 10:58:07 to 2026-10-26 11:03:05, ledger at 2026-10-26 11:03:05; RUN-20261026-1149-C3.0.78-g78b2-s1, session 2026-10-26 11:49:06 to 2026-10-26 11:53:17, ledger at 2026-10-26 11:53:17. Two distinct sessions, identical full build key, current hashes, no current-hash FAIL on that build. Matching independent review: CODEX_CASE_REVIEW_cx_cr16.md.

4. **R15, hash 6626D75574C6:** RUN-20261026-1130-C3.0.78-g78a8-s1, session 2026-10-26 11:31:00 to 2026-10-26 11:33:43, ledger at 2026-10-26 11:33:43; RUN-20261026-1224-C3.0.78-g78b8-s1, session 2026-10-26 12:24:06 to 2026-10-26 12:27:20, ledger at 2026-10-26 12:27:20. Two distinct sessions, identical full build key, current hashes, no current-hash FAIL on that build. Matching independent review: CODEX_CASE_REVIEW_cx_cr15.md.

5. **R16, hash 92E250C4F0FC:** RUN-20261026-1133-C3.0.78-g78a9-s1, session 2026-10-26 11:33:46 to 2026-10-26 11:37:16, ledger at 2026-10-26 11:37:17; RUN-20261026-1227-C3.0.78-g78b9-s1, session 2026-10-26 12:27:23 to 2026-10-26 12:30:47, ledger at 2026-10-26 12:30:47. Two distinct sessions, identical full build key, current hashes, no current-hash FAIL on that build. Matching independent review: CODEX_CASE_REVIEW_cx_cr15.md.

### Every counted red

1. **R03_BROKEN:** current hash 5306E08120E5, RUN-20261025-0151-C3.0.74-hdnA2v-s1, session 25 Oct 01:51:33-02:05:46; ledger at 02:05:46. Both invert texts are disabled; counts become zero rather than two/one/one, while the pipe remains. A true changed-input red. Inside .74's 24 Oct 17:19:59 to 25 Oct 03:33:02 window.

2. **R15_BROKEN:** current hash C287A88ED7BF, RUN-20261024-0639-C3.0.72-p3b1run1C-s1, session 24 Oct 06:39:50-06:48:45; ledger at 06:48:45. It expects 27 recovered where the command says 26. A weaker flipped red, not a run with recovery deliberately broken. Inside .72's 23 Oct 18:27:05 to 24 Oct 11:35:55 window.

3. **R16_OFF_BROKEN:** current hash 54B33C7AD833, RUN-20261024-1605-C3.0.73-f12-s1, session 24 Oct 16:05:09-16:10:16; ledger at 16:10:17. Turning Tidy labels OFF removes the expected preview and eight checks fail. A true setting-change red. After .73 and Structural .123 installation, before .74 at 17:19:58.

4. **R19b_COUNT_BROKEN:** current hash 519375085E7C, RUN-20261025-1508-C3.0.75-b3bd1-s1, session 25 Oct 15:08:12-15:16:39; ledger at 15:16:39. An extra erased IL text leaves 1030 objects rather than 1031; all six pipes remain. A true changed-drawing red for the count check. Inside .75/.123's 25 Oct 03:33:03 to 17:41:13 window. The E_FAIL pipe variant is excluded.

5. **R20_BROKEN:** current hash 3F7D66A63C6B, RUN-20261024-1204-C3.0.73-p3b2fixA2-s1, session 24 Oct 12:04:24-12:09:57; ledger at pack completion 12:12:41. It actually clears selection, so the expected one selected object is absent. A true changed-state red. After .73 installation, before Structural .123 at 12:42:11.

6. **Row verification:** each of those five rows has the named parent in variant_of, result FAIL, from_check true and the current variant hash. I read the corresponding JSON and Markdown check lines. Their historical build strings and installation windows qualify their reds; none supplies a second positive session on 3.0.79.

### Probe rows, not qualifying pairs

1. **R14h_dstd_200:** PASS, RUN-20261026-1536-C3.0.78-b5r1f-s1, ledger at 2026-10-26 15:45:14, civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09; PASS, RUN-20261026-1721-C3.0.79-b5r2f-s1, ledger at 2026-10-26 17:32:17, civil 3.0.79+d3f9c5df / struc 1.0.124+3a3caac5 / mgr 1.1.79+d3f9c5df. Both rows match today's case hash.

2. **R14h_both_200:** PASS, RUN-20261026-1536-C3.0.78-b5r1f-s2, ledger at 2026-10-26 15:45:14, civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09; PASS, RUN-20261026-1721-C3.0.79-b5r2f-s2, ledger at 2026-10-26 17:32:17, civil 3.0.79+d3f9c5df / struc 1.0.124+3a3caac5 / mgr 1.1.79+d3f9c5df. Both rows match today's case hash.

3. **R14h_pipekey_200:** PASS, RUN-20261026-1536-C3.0.78-b5r1f-s3, ledger at 2026-10-26 15:45:14, civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09; PASS, RUN-20261026-1721-C3.0.79-b5r2f-s3, ledger at 2026-10-26 17:32:17, civil 3.0.79+d3f9c5df / struc 1.0.124+3a3caac5 / mgr 1.1.79+d3f9c5df. Both rows match today's case hash.

4. **Separate starts:** in b5r1f the three sessions run 15:36:18-15:39:17, 15:39:17-15:42:16 and 15:42:16-15:45:14. In b5r2f they run 17:21:58-17:25:14, 17:25:14-17:28:29 and 17:28:29-17:32:17. Each JSON/Markdown report records the three 200 mm warning assertions, idle and one completed outcome as passed. The sixth reported check is record-only.

## The cases

1. **R14h_dstd_200: raised design-standard freeboard. Verdict: PARTIAL (part only: raised-setting CDTWL command-line warning). Hash 75A91D22C754.**

   **Asks met:** the requested 200 mm diagnostic in cx_cr04 items 1.4-1.5 now exists and has the two single-build passes listed above. Searching every RUNNER_CASE_REVIEW_*.md for R14h found no prior direct section. Related R14 sections in the R11_R20 and B2 reviews requested named pits and the raised-setting probe; those leads are now partly answered.

   **Line-by-line comparison:** C39 at TEST_CASES_DRAFT_22OCT.md lines 853-869 requires C37's setup context, the 10 cubic metre/18.70 m route, C1's 40 mm and P1/P7's 110 mm warnings with the 150 mm baseline, "That is enough.", and one completed outcome. Case lines 18-22 perform the route and read idle/window state; 24-26 assert the three named warning lines at 200 mm; 27-28 assert idle and one outcome. Line 29 records text only. The probe changes the baseline and omits the sufficiency assertion, so it does not cover whole C39.

   **Exact additions:** after SETTING at line 8 add `SETTING CD_Settings.json pipe.detentionFreeboardMm 150`. Replace PLAN_ITEM line 4 with `PLAN_ITEM CDTWL raised-freeboard wording diagnostic only; partial C39, not the 150 mm baseline card`. Under ASSERT add `history has "That is enough."` and `history count "Only 110 mm" = 2`. Those checks strengthen this diagnostic; they do not turn 200 mm into C39's required 150 mm baseline.

   **Missing red:** create a separate twin with `CASE R14h_dstd_200_BROKEN`, `VARIANT_OF R14h_dstd_200` and `EXPECT-FAIL BROKEN-VARIANT`; set both named freeboard keys to 150 and retain the 200 mm assertions. The intended failure is the wanted-freeboard wording. This is a proposed case for the owner, not an executed or written file. No current variant or red row exists for this CASE.

   **Runs still needed:** unchanged text needs one further PASS session on 3.0.79, plus its own intended red and scope repair; after any of the proposed text changes it needs two new-hash PASS sessions on 3.0.79. Its .78 pass cannot be paired with .79. The unpinned companion key and unrecorded active setting pair prevent a firm precedence claim.

   **Codex look and engineering:** no look is needed for this narrow wording check. A drawing or preview claim would need one. Neither 200 mm, 150 mm, 10 cubic metres nor 18.70 m is engineering-approved here.

2. **R14h_both_200: both freeboard settings raised. Verdict: PARTIAL (part only: raised-setting CDTWL command-line warning). Hash DF7288A88698.**

   **Asks met:** cx_cr04's both-keys diagnostic is implemented at lines 8-9. Both reports say 200 mm for C1, P1 and P7. Both settings are explicitly pinned, unlike the single-key files. It still has no own broken twin and only one PASS per build.

   **Line-by-line comparison:** the same C39 lines 853-869 apply. Case line 19 supplies the two answers; lines 25-27 check C1/P1/P7 at 200 mm; 28-29 check idle and one completion; line 30 merely records. C39's 150 mm baseline and "That is enough." assertion are absent. Both keys at the same value do not distinguish which key controls the outcome.

   **Exact additions:** replace PLAN_ITEM line 4 with `PLAN_ITEM CDTWL raised-freeboard wording diagnostic only; partial C39, not the 150 mm baseline card`. Under ASSERT add `history has "That is enough."` and `history count "Only 110 mm" = 2`. For its own red use `CASE R14h_both_200_BROKEN`, `VARIANT_OF R14h_both_200`, `EXPECT-FAIL BROKEN-VARIANT`, both SETTING values 150, and keep the 200 mm assertions.

   **Runs still needed:** one further unchanged PASS session on 3.0.79; two if the proposed edits are applied. A qualifying red is also required. No later FAIL was found. This is missing coverage/evidence, not FAIL = real fault.

   **Codex look and limits:** none for the words. The number records do not approve detention design, storage totals or window appearance. The NOT_AUTOMATED comment about the other key staying at 150 is generic; here both keys are expressly 200.

3. **R14h_pipekey_200: raised pipe freeboard setting. Verdict: PARTIAL (part only: raised-setting CDTWL command-line warning). Hash CCF6A4F7A293.**

   **Asks met:** the complementary single-key diagnostic requested by cx_cr04 is present at line 8. It produced the 200 mm words in both recorded runs. No R14h section exists in the earlier RUNNER_CASE_REVIEW files; related R14 advice was read, not treated as a certificate for this new file.

   **Line-by-line comparison:** against C39 lines 853-869, case lines 18-22 perform the route and state reads; 24-26 check the three 200 mm warnings; 27-28 check idle and completion. The 150 mm baseline and sufficiency assertion are not covered. The title's other-key-150 promise is not enforced by a SETTING line.

   **Exact additions:** after line 8 add `SETTING CD_Settings.json designStandards.detentionFreeboardMm 150`. Replace PLAN_ITEM line 4 with `PLAN_ITEM CDTWL raised-freeboard wording diagnostic only; partial C39, not the 150 mm baseline card`. Under ASSERT add `history has "That is enough."` and `history count "Only 110 mm" = 2`. Its red must use `CASE R14h_pipekey_200_BROKEN`, `VARIANT_OF R14h_pipekey_200`, `EXPECT-FAIL BROKEN-VARIANT`, both SETTING values 150, retaining the 200 mm assertions.

   **Runs still needed:** one further unchanged PASS on 3.0.79; two after an edit, with a current-hash intended red. No FAIL exists for this probe. R14_PIPEKEY_BROKEN has variant_of R14 and cannot serve as this case's red.

   **Codex look and limits:** no look for the warning text. The result alone does not establish the setting-precedence rule; record the effective pair immediately before launch before drawing that conclusion. Do not infer that either 200 mm or the chosen water level suits a real drainage design.

4. **Shared exact scope repair:** to accept the whole baseline C39, the owner must retain a separately reviewed 150 mm route with all three card assertions and C37's stated context. The three raised probes cannot substitute for it. SETUP-R47 moves P3 and creates P8 and a pipe, but omits C37's Tidy labels setup actions, obstruction move and zoom. Any deliberate reduction of that context needs an explicit card comparison and fresh evidence; it is not silently equivalent.

5. **Small common points:** windows-snapshot is read but $win_end is not asserted. If window closure is claimed, add `not-contains $win_end "New "` under ASSERT. The "FULL" record is visibly truncated in the reports, so it is not a complete command transcript. The available portion does contain "That is enough." and additional 180/160/150 mm warnings for P3/P4/P5; those are recorded, not judged by these cases. Session start/end settings fingerprints agree, but do not show both effective freeboard values while the command ran.

## TALLY OF THE 40

1. **How I counted:** gap-plan section 3 item 7 names eight items plus section 2's thirty daily cards: 8 + 30 = 38, not 40. PIT and CD remain their two named entries even though D01 also covers them. I did not invent the missing two or count a partial card as a whole. The release target remains the desk's stated 30; this report does not amend it.

2. **Installed and historical totals:** 0/38 named items on installed 3.0.79; 5/38 on any build under the requested runner/certificate rule. Against the plan's printed denominator these are 0/40 and 5/40, with two unspecified items. The other 33 named items are uncounted. All five historical items lack exactly two PASS sessions on the installed build; none has even one there.

3. **Whole coverage checks for the five:** D12 assertions at 384-403 are the two exact IL texts, unique counts and end positions, all checked by R03. D14 assertions at 432-455 are the message, six retained pipes and pit/count/ERASE echo after U, checked by R19b; reading restored links or schedule values is outside those assertions and is not accepted. D17 at 511-533 is the retained single/two-pipe selection and editor closure, checked by R20. C38 at 833-849 is the recorded recovery totals and completion, checked by R15, not whether new labels were drawn. C37 at 808-829 is named preview wording, summaries, obstruction identity and cancellation, checked by R16 with its switch ON, not Apply or actual label positioning.

### Each of the thirty daily cards

1. **D01 - Keep placing pits and pipes until Esc; R01:** not counted on any build. The whole card requires exactly one outcome per command; current checks do not enforce that (cx_cr12).

2. **D02 - Catch a pit within its outline plus 100 mm; R21:** not counted. Today's assigned case text has no matching independent acceptance certificate; see the stale-text warning.

3. **D03 - Join the only pit at a pipe end; R02/R02b:** not counted. The outgoing numeric assertions are loose and the incoming route covers only part of the whole card (cx_cr12).

4. **D04 - Esc at the third point draws nothing; R17:** not counted. The Enter contrast does not prove the straight pipe's two vertices and the required handle-set behaviour (cx_cr15). D1-04 is a separate visual PASS below.

5. **D05 - Recent diameter, material and invert buttons:** not counted. The required window look has no completed Codex PASS; D2-01 was not tested.

6. **D06 - Hide grade in ordinary pipe text:** not counted. No whole-card qualifying case and certificate were found; the D2 attempt was not tested.

7. **D07 - Place a downpipe and raingarden before a pipe:** not counted. The source-specific R36/R37/R37b checks do not cover both parts of this card; the visual attempt was DIFFERENT.

8. **D08 - Overflow and front overflow symbols/tags:** not counted under the runner tally. D7-02 has a Codex visual PASS, but no qualifying two-session case and matching certificate for this whole card.

9. **D09 - Pit number and CL cover label:** not counted. No whole-card acceptance covers the required label content and position; D2's look was not tested.

10. **D10 - Mid-pipe label wording and alignment; R18:** not counted. Rotation/alignment must be seen or measured; the reviewed case does not establish them (cx_cr04).

11. **D11 - Short-pipe label on a leader:** not counted. No completed whole-card visual/geometry evidence; D2's look was not tested.

12. **D12 - One IL text at each pipe end; R03:** accepted on 3.0.78, not installed 3.0.79. Pair, true red and matching certificate are listed above. Needs two .79 sessions.

13. **D13 - A hand-moved label stays put; R26:** not counted. Today's assigned text lacks matching whole-card acceptance; the E3 hand-label look was blocked.

14. **D14 - Erase a pit, keep its pipes and undo; R19b:** accepted for the card's assertions on 3.0.78, not installed 3.0.79. Pair, true count red and certificate are listed above. Needs two .79 sessions.

15. **D15 - Copy a real CE pit with a new number and Check levels:** not counted. The R34 variants' duplicate-number guards do not prove this whole COPY contract (cx_cr09-cx_cr10).

16. **D16 - Explode a pit and explain schedule removal; R22:** not counted. Today's assigned text has no matching whole-card certificate. D3-05's visual PASS uses PITSCHEDULE then EXPLODE undo steps, and is not automatically the card's single-U contract.

17. **D17 - Keep selection after CDEDIT; R20:** accepted on 3.0.78, not installed 3.0.79. Pair, true cleared-selection red and certificate are listed above. Needs two .79 sessions.

18. **D18 - CE never saves the drawing; R04:** not counted. CDREBUILD is missing from the card coverage (cx_cr01).

19. **D19 - Correct U names and CD route Undo:** not counted. D8-05 proves its named visual route and two echoes, not the card's every-CE-step claim.

20. **D20 - Renumber from the outlet up the main line; R24:** not counted. The reviewed fixture does not establish the required ordering route (cx_cr06); the visual read was blocked.

21. **D21 - Natural schedule order and groups; R25/R38:** not counted. Neither case compares the required natural order/groups; R38 is a narrow P3-level guard (cx_cr06/cx_cr19).

22. **D22 - Drawn schedule continues with headers:** not counted. The required drawing look is blocked: D6-03's button was disabled and E4-01's route could not proceed.

23. **D23 - Excel export with Checking sheet:** not counted under the runner tally. D5-03 is a Codex PASS for export and headers, without a whole-card qualifying two-session case/certificate.

24. **D24 - Office layers and unchanged current layer:** not counted. No qualifying whole-card case/certificate; D7's layer look was blocked.

25. **D25 - Existing and demolished layers:** not counted. The card marks it NOT BUILT and no qualifying evidence supersedes that; this review did not inspect implementation to assert today's installation status.

26. **D26 - Survey existing level and proposed level; R35:** not counted. R35's typed spot-level guard does not supply the stored-survey half (cx_cr18); D5-02 likewise covers typed/blank/refused input only.

27. **D27 - CDSYNC and CDREBUILD warn first; R13:** not counted. There is no matching whole-card acceptance of both commands on today's assigned text. D4-01/D4-02 visual PASS results are separate.

28. **D28 - One check summary and results window; R40:** not counted. The case does not prove the actual report, one-window count and ordering/appearance (cx_cr02).

29. **D29 - Honest sent/local feedback result:** not counted. E6-03 accepts the window and Cancel only; the Send report half is untested and remains with Tim.

30. **D30 - Selection brings its ribbon tab forward:** not counted. D8-04's look is FAIL; the observed return after Esc was Plug-ins rather than CE.

### The other eight named gap-plan items

1. **PIT - continuous placement; D01/R01:** not counted because the exactly-one PIT outcome assertion is missing.

2. **CD - continuous placement; D01/R01:** not counted because the exactly-one CD outcome assertion is missing.

3. **Edit Pipe cascade with U and REDO; R11:** not counted because today's assigned text lacks matching whole-item acceptance.

4. **Quick MOVE; R12:** not counted because the four movement distances are recorded without the necessary assertions (cx_cr03). D3-02 separately passes the visual movement route.

5. **CDSYNC keeps the schedule; R13:** not counted because today's assigned text lacks matching whole-item acceptance. D4-01 separately passes the observed row-count and named-cell look.

6. **CDTWL freeboard; C39/R14 and the three R14h probes:** not counted because there is no complete, current-hash reviewed baseline-and-diagnostic coverage. The three new probes are only the raised-setting part.

7. **Recover Inverts; C38/R15:** accepted on 3.0.78 for the whole recorded-totals card, not on 3.0.79. Needs two installed-build sessions. Red is explicitly weaker/flipped; redraw is not accepted.

8. **Tidy labels names the pipe; C37/R16:** accepted on 3.0.78 for the whole named-preview/cancellation card with switch ON, not on 3.0.79. Needs two installed-build sessions. This does not approve enabling the feature for Max or applying a move.

### One next step with the largest supported gain

1. **Have the authorised runner owner make two complete passes of unchanged R03, R15, R16, R19b and R20 on stable Civil 3.0.79.** Each case must have two separate AutoCAD starts, the current case hash and the same full build key, with no standing FAIL or intervening install. This one batch job could add five installed-build items without editing their case text. Existing reds and reviews must still match. I did not execute it.

## Codex looks already recorded, kept separate

1. **Method:** I read result lines in CODEX_VERIFY_D1 through D8 and E1 through E6 in C:\Lisp Files\_TEST_COPIES_20260923. Eleven top-level looks are marked PASS, all before 3.0.79. They are Codex-accepted only for the stated observed scope, not eleven whole daily cards and never Claude-accepted. No screenshot was newly judged in this review.

2. **D1-04, D04 visual part, Civil .72:** CODEX_VERIFY_D1_20261024_0607.md says Esc clears the third-point preview without a new window/object; Enter opens New Pipe and Cancel returns cleanly. It does not complete the placed-straight-pipe contrast.

3. **D3-02, quick MOVE, .75:** CODEX_VERIFY_D3_20261025_0457.md says P3 and labels move, connected pipes stretch, no edit/cascade window opens, and one U restores the visible items.

4. **D3-05, D16 visual part, .75:** the same report says the explode sentence names P3/six ends and the schedule loses P3. Restoration uses two U echoes, PITSCHEDULE then EXPLODE. Do not silently describe that as a one-U experiment.

5. **D4-01, CDSYNC schedule look and D27 part, .77:** CODEX_VERIFY_D4_20261026_0357.md says the warning precedes completion, 27 rows remain and four named P3 values match.

6. **D4-02, CDREBUILD warning/schedule look, .77:** the same report says warning first, explicit no-save final text, 27 rows and four P3 values unchanged. This is not a drawing-file hash test.

7. **D5-02, D26 typed-level part, .77:** CODEX_VERIFY_D5_20261026_0426.md says typed/blank spot levels are visible, 18600 is refused and Esc leaves no third symbol. Stored survey/existing level is outside that PASS.

8. **D5-03, D23 export look, .77:** the same report records an 11,780-byte workbook with Pit Schedule and Checking sheets and PIT No./FIELD/VALUE/SOURCE headings. This is the stated PASS scope, not proof of every exported pit/value.

9. **D7-02, D08 symbol/tag look, .78:** CODEX_VERIFY_D7_20261026_0553.md records identical symbols with readable OF and FO labels.

10. **D8-05, D19 route-Undo look, .78:** CODEX_VERIFY_D8_20261026_0623.md records the Undo sentence, stepped-back preview, cancellation and PIT/MOVE U echoes. It does not cover every CE command.

11. **E6-02, Manager versions, .78:** CODEX_VERIFY_E6_20261026_0913.md records agreement of all four version sources for each suite (BUG-219). This is outside the 38 named daily items.

12. **E6-03, D29 window and Cancel, .78:** the same report records readable tabs/buttons, the cancellation sentence and unchanged feedback folder. Send report and BUG-1215 remain untested.

### Look-only items and missing looks

1. **D05 recent buttons:** D2-01 NOT TESTED; no Codex PASS.

2. **D22 drawn schedule continuation:** D6-03 and E4-01 BLOCKED; no Codex PASS.

3. **D28 results window:** D8-02 DIFFERENT, not PASS; R40's narrow command-line check does not replace it.

4. **D29 feedback:** E6-03 PASS for window/Cancel only; no Send report acceptance.

5. **D30 contextual ribbon:** D8-04 FAIL, not accepted.

6. **Other visual limits:** D2's five looks were not tested. D6's looks were blocked. E1/E2/E4 were blocked by their prescribed route; E3 hand-label was blocked and Tidy labels DIFFERENT; E5 was NOT TESTED with duplicate saved screenshots, so supplies no new look. E6 About remains FAIL for clipped rows and its news route NOT TESTED. These are historical observations, not claims that those faults persist in installed .79.

## Assigned cases changed since the 07:10 briefs

1. **R09 (cx_cr02.txt):** reviewed text is stale, review again; brief AECC3CC7F889, current 8763A665A9C3.

2. **R11 (cx_cr03.txt):** reviewed text is stale, review again; brief BECE7698469D, current B40EBE88E6B6.

3. **R13 (cx_cr03.txt):** reviewed text is stale, review again; brief 9C67E0C3E882, current BE176845E3D2.

4. **R14 (cx_cr04.txt):** reviewed text is stale, review again; brief 0A5ED5AD8028, current 6B375F8D1219.

5. **R19 (cx_cr05.txt):** reviewed text is stale, review again; brief 2F504E120147, current BE503780EB3B.

6. **R21 (cx_cr05.txt):** reviewed text is stale, review again; brief 89B64B53A3FD, current 2462CD753D29.

7. **R22 (cx_cr05.txt):** reviewed text is stale, review again; brief BF70B18C4F7E, current 8C3D7C746AD4.

8. **R26 (cx_cr06.txt):** reviewed text is stale, review again; brief 03C9AE48C097, current 2EC1D6D74E0F.

## Things the desk should know first (RULES 6.2)

1. **The installed expectation is stale:** the brief's 3.0.78 was replaced by .79 at about 16:58. Earlier pairs remain historical; an ACCEPTED-READY header is not current-build proof.

2. **The old 8-of-40 is not the present count:** cx_cr12 finds D01/R01's outcome counts and D03/R02/R02b's numeric/route coverage insufficient; cx_cr15 finds D04/R17's contrast incomplete. Those three deductions leave five under the requested method, even where an old certificate still matches the file hash. The plan names 38 items.

3. **Raised probes now exist and have run:** any earlier statement that the three requested 200 mm diagnostics were absent is superseded by the six rows listed here. They are expected-PASS diagnostics, not broken variants. Each has one pass per build, not two on one build.

4. **A settings conclusion remains limited:** start/end fingerprint equality proves restoration as recorded, not which effective key combination CDTWL read. The single-key probe titles assume the other key remains 150 without pinning it. Both named pits and the 200 mm words were actually checked; setting precedence was not independently established.

5. **Setup is outside the certificate hash:** all probes depend on SETUP-R47. The gate hashes only the .case.txt. A future setup edit could leave a matching review certificate while changing the experiment. I hashed the current setup and report that limit; I did not modify the runner or ledger.

6. **Recorded is not asserted:** each probe's sixth check is only a record. R15's red flips 26 to 27, and R19b's E_FAIL twin is not an intended-check red. Neither should be described as a strong broken-product run. R16's old comment says its no-clear-spot count is recorded, but the current ASSERT does check it; I used the executable text.

7. **No assigned case was silently re-certified:** changed assigned cases receive only the warnings above. Existing mismatched certificates remain untouched. Unchanged certificates for partial daily items also remain untouched; the tally follows the newer independent review's scope finding.

## File hashes and review records

1. **Inventory method:** every top-level .case.txt was read with Get-FileHash, then rehashed before writing. The 52 hashes did not change between reads. Review status below means hash equality only, not whole-card acceptance. I also independently hashed all 62 variant files; none belongs to a new R14h CASE. Only the five variant hashes used by the tally are reproduced after the inventory.

### All top-level cases

1. **R01_pit_cd_until_esc.case.txt:** 99BC70E236751F8086E5542A7547A3C5431B56F16F31BC83BB62C8D3C5020108; review hash matches.

2. **R02_pipe_joins_pit.case.txt:** 807FCF12EFBACC09ED6E0D034FD6FE2BAD1DFA03EF8844B0C445579FCE6BEE12; review hash matches.

3. **R02b_pipe_ends_on_pit.case.txt:** 2EF087A676980300FF18ACA34886E6D122BE943D4ED241FFBBA57643468D8664; review hash matches.

4. **R03_one_il_text_each_end.case.txt:** 4384D2D7B6B9AF3206D270CC5399ECF8BB8B19F493383EBB380684A4AB36DB12; review hash matches.

5. **R04_ce_never_saves.case.txt:** 443604166CC0C57BCD3C01A377E05A9E1C55915E9EC404F889C6963139CBB056; review hash does not match or is absent.

6. **R05_outcome_line_completed.case.txt:** 4E5A615417F86FF76D51E0C9CA012835722D85CCCACE2E8A9029327DD69DDA8A; review hash matches.

7. **R06_about_ce_suite_versions.case.txt:** 6D94611EC40B3F53123A72CAE8FDF6A95170DA92FE30E15DB81B309D968B92FE; review hash does not match or is absent.

8. **R07_settings_window_cancel.case.txt:** 7D08DB109F80C46F3DC3A615F37452087F75FB02A6666C20E922A60DBE755BBB; review hash matches.

9. **R08_redo_after_pick_x5.case.txt:** 4A42C588E54945E41A22158134AD3FB04AFCBF78E336B3364F2ACAE62EC0201B; review hash matches.

10. **R09_dp1_double_click_edit_source.case.txt:** 8763A665A9C3EEFB8E04AFFED95632E407945453E05158982DB28F41872C9B74; review hash does not match or is absent.

11. **R10_cdcheckignore_switch_off.case.txt:** AB3377887B1DC0C1D7A270F8BF9A9947E2D32A5C1C614BE8DF39441F6CF282B2; review hash matches.

12. **R11_edit_pipe_cascade_u_redo.case.txt:** B40EBE88E6B68B7C9ABE8EEAE565FE2F999AC96915F9C8BD76F63FB286641BA5; review hash does not match or is absent.

13. **R12_quick_move_opens_no_window.case.txt:** 334263931AF1C4DB72CF146BC413B763A477158C4633091C8B833DAFD8825714; review hash does not match or is absent.

14. **R13_cdsync_warns_then_relinks.case.txt:** BE176845E3D259275AB308ADEACC2242D7AE06028E14C76DD59E92F60D545356; review hash does not match or is absent.

15. **R14_cdtwl_freeboard_150.case.txt:** 6B375F8D12195D3F936B521E0AF83190BD90AAB69DC19CB37E8A898570DB90C0; review hash does not match or is absent.

16. **R14h_both_200.case.txt:** DF7288A8869801D99C86FDA4FA46872D119FAECAE0C60F7F153810008E72DC51; review missing.

17. **R14h_dstd_200.case.txt:** 75A91D22C7542579B661A60D938481BD0E141D2837D276427CC8FCA759528A14; review missing.

18. **R14h_pipekey_200.case.txt:** CCF6A4F7A29385316A662548EB22EAF995510A833F852808E9037719825C523A; review missing.

19. **R15_recover_inverts_totals.case.txt:** 6626D75574C6B81E6147C1962A618154B354412D9C11E85E343B766480DE9B9D; review hash matches.

20. **R16_tidy_labels_names_the_pipe.case.txt:** 92E250C4F0FC2FA67B2142966ED845B2C62CFABB7E2483B30B46D3EA0A935218; review hash matches.

21. **R17_cd_esc_at_third_point.case.txt:** E252738D9455E7E90F0D12E8A301A92841D72532E1D6C024AEE67F0DE6F62F87; review hash matches.

22. **R18_pipe_label_text_and_place.case.txt:** 0D40A7012C730F4A669DF409A6DAA1FD746F917626493E3E42AC709CA0A5760C; review hash does not match or is absent.

23. **R19_erase_pit_keeps_pipes_u_restores.case.txt:** BE503780EB3BF585F48EA72A2147279E8D99A68D404041EDB3672C983230714E; review hash does not match or is absent.

24. **R19b_erase_pit_with_several_pipes.case.txt:** 3536E3A4615D3BAD4FC45895769C6E70CDAD640EE35D9CA7B71948947B4984B0; review hash matches.

25. **R20_cdedit_keeps_selection.case.txt:** 4CEA23828CEF576507C0B33CC7349C0AC4B277A4465A4EF04F98CDB1DF376CDE; review hash matches.

26. **R21_cdcheck_totals_add_up.case.txt:** 2462CD753D2920F4E412A964C10EBADA700362BD8E32C1766241BC260531B4AB; review missing.

27. **R22_cdcheck_words_no_internal_ids.case.txt:** 8C3D7C746AD46DE73F7F630E6D8233442651A1EF129C469276B85E7C0D8FC835; review missing.

28. **R23_locked_pipe_layer_cdedit_refuses.case.txt:** 47044D1E70E6536E8BC049CEC49362BD62D2A1C5A4EF0C4C6A614EC780AAD1A3; review hash matches.

29. **R24_metre_drawing_pit_size.case.txt:** 1BECEC091BED9D1AC0A99509DA615B541FE096A186F81811854EBC5BD3587231; review missing.

30. **R25_pit_schedule_reads_and_closes.case.txt:** 2DB8A06D260F73E46BAEC306CC6C652A77EB190D5C27E528D9C4DE433B39640D; review missing.

31. **R26_cdsurvey_refusal_stores_nothing.case.txt:** 2EC1D6D74E0F7E7A6BD4EA133B2A66E7FB8B590AEA4B2E50C29EECC49F4D2502; review missing.

32. **R27_cddesign_window_opens.case.txt:** FF8E8F549086A44B13393622577C2F0B55A9DB22C87D0261741271CC439C6EBC; review missing.

33. **R28_cdprofile_start.case.txt:** 7F29403F16E7605D4F7C05737A2427581935C688B007D359044F9BF2D3CBF852; review hash matches.

34. **R29_landxml_import_window_cancel.case.txt:** 6978F830B59BB80E259771586FD8255D0A6F203947761781F42A28872653356F; review missing.

35. **R30_manager_window_opens.case.txt:** 47F342FDCE52BF058C1C2175E077DC6AEC3C46B0279FEAF6FADBC0B94F6A33F6; review missing.

36. **R31_cd_uphill_levels_question_esc.case.txt:** FF6655B93D19F628ECED9D159EE315CE1FA6905A9CEB845D24D33B2A7FFC3300; review hash matches.

37. **R32_edit_pipe_reverse_levels_arrow_follows.case.txt:** 8C2029C145884D2FDA02B93C5745FFBC55F45E7599E6D882DEB8782609C304BA; review missing.

38. **R32b_edit_pipe_size_only_keeps_arrow.case.txt:** 2C55234B99509F748A290325825745155405F33FC049BB798B32F5D5FFEB7BC7; review missing.

39. **R33_locked_pit_text_layers_pit_and_copy.case.txt:** DDEAA7503ACD27BFAB98986B1447741EA1E142E2BB246924D935213510BC9B84; review missing.

40. **R34_copy_rotate_scale_pit_gets_own_number.case.txt:** D7E167D4495294EB3730A7AB097842256A19034AFB2CE77F024D6F6177F60C8B; review missing.

41. **R34s_copy_rotate_scale_pit_switch_on.case.txt:** 990D45639FF699B76C2D3ECF812986036F34E3DC8D4AFB08874B924D167AC589; review missing.

42. **R34sn_copy_rotate_scale_pit_number_switch_on.case.txt:** 24A6310A205CC86068A932882CA0DA26B22ED2F5B8CCA2FD3B225E788E24A414; review missing.

43. **R34so_rotate_copy_pit_offset_switch_on.case.txt:** 332F7F1E2BE2A285CF81FD106430974A2799F8A0D7DCC7AC48D40537B6FED317; review missing.

44. **R35_cdsl_typed_level_number_check.case.txt:** 81C7A36F125FE44F1AA2EDAA78131F478C55EA9C2CBEE4506CD04EB238273C07; review hash matches.

45. **R36_cdfw_places_with_duplicate_agi_tags.case.txt:** 4670716EF0F978ECC9FF67F85A3E0D113B9E5C0F80D0A4B2C81708C8EC990187; review missing.

46. **R36e_cdfw_at_pipe_end_claim.case.txt:** AB5BDFD21ACC9B8C2F27606F2D0631DF714F04FE86C79075D008EEF8E08F94CC; review missing.

47. **R37_cdperimeter_draws_pd1_tag.case.txt:** 60891583BAAC5F43963FD56348668D8F6BE15EF94D8EEF8AB754EDF43582F779; review hash matches.

48. **R37b_perimeter_pd1_text_follows_move_erase.case.txt:** AFAA3A7A7A17B46685DBA0E27CF258FD35E71E0C695B97EFEE27CAF49F82AA87; review missing.

49. **R38_pit_schedule_il_cells_match_plan.case.txt:** 2A94934EBE9120078A8DCA0F475B79EB93232B1174A2077E75F0B53AC09375C5; review hash matches.

50. **R39_cd_existing_line_opens_new_pipe.case.txt:** 0FBBAD9920F082D026A825999C2F6412FE2CA8401BEB06045AD9EFB223A20945; review hash matches.

51. **R39b_cd_existing_arc_and_closed_line_kept.case.txt:** CD1A7B6CAE9AC3A4BE04E3E6DB9D4EE73E804F1E77F76107CC0A20635E04473A; review hash matches.

52. **R40_cdcheckdwg_one_summary_line.case.txt:** CAB6A794E695C2634A548EF9BE7BB6929D784766D496829277D269F60B6F92C8; review missing.

### Counted variants and referenced setups

1. **R03_broken.case.txt:** 5306E08120E5914D14A3D5EBB5FBE577BFFCA72259B3DB372B8FAE384030CCC2.

2. **R15_broken.case.txt:** C287A88ED7BF72E3251384E872797A624307A3B580C3A3ED1371EF1F9CDF2AA5.

3. **R16_off_broken.case.txt:** 54B33C7AD833B85A5E51279763FEBDA4D1A666D35D7D485506ADD19DB278D651.

4. **R19b_count_broken.case.txt:** 519375085E7CC43CB4DCD3AFEFB2EDAB6F0CF61D55D9AC758EAAE8049388D8E6.

5. **R20_broken.case.txt:** 3F7D66A63C6B77F022A7162955BC9375B969AC6F788B9156AA10E6F468EF43E8.

6. **SETUP-R47.setup.txt:** 0CB83BDF78538F247ADEF2B37DF755B2370A2830F368C1D01E90BB211FD71C07. Required by all three own probes and R15/R16.

7. **SETUP-P8.setup.txt:** 7A241608EB590525E0F1D37AB459F9D7116677D17AD6CD5C4C2D6C97FC496F03. Required by R03.

8. **Other setup hashes read for the tally inventory:** SETUP-ISO1.setup.txt = 3F5233FDD5DF1698DA68EF0CE570A8B63A73D89477933D0A051152B41B126E20; SETUP-P8x2.setup.txt = 81152F70E47695E49504157147A864FB14761ED668A1B308903A7C18B2F4E3FE. These hashes do not create extra accepted items.

9. **Setup timing limit:** R47's last write is 24 Oct 11:52:43, P8's 23 Oct 20:05:31, ISO1's 24 Oct 11:47:42 and P8x2's 24 Oct 23:17:29. Historical R15's selected flipped red predates the present R47 setup text; its actual failed word is visible in its report, but it is not proof of an unchanged entire setup-plus-case package. The positive .78 pairs postdate these setup writes. The requested gate has no setup-hash binding.

## What I read

1. **Rules and method:** C:\TimOS\RULES.md, including its acceptance amendment; C:\TimOS\ROUTER.md; C:\CE_PLAN\decisions\2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md; complete RUNNER_CASE_REVIEW_B3FIX_2026-10-25.md and RUNNER_CASE_REVIEW_B3B_2026-10-25.md; Get-CaseIndependentReview in case_runner.ps1 and R16's six-line review example.

2. **Plans and cards:** START_HERE.md, RELEASE_9NOV_GAP_PLAN_2026-10-22.md including section 2 and section 3 item 7; DAILY_TOOLS_TEST_CASES_2026-10-23.md; relevant C37/C38/C39 sections of TEST_CASES_DRAFT_22OCT.md. No own case claims a BUG or PROVES_BUGS identifier requiring a separate bug verdict.

3. **Independent reviews:** all cx_cr01-cx_cr19 reports for their verdicts, scope, daily contributions and limitations; adjacent review files for all top-level cases. Searched every RUNNER_CASE_REVIEW_*.md for R14h: no direct section. Read the related R14 sections and cx_cr04's requested diagnostic lines. Compared all 49 assigned brief hash prefixes, resolving the two wildcard filenames to their actual files.

4. **Recorded evidence:** the complete 602-row ledger; selected five-case positive pairs, their five counted red JSON/Markdown reports, and both three-probe packs. Assertions and actual failure text were read, not inferred from PASS/FAIL headings. All D1-D8/E1-E6 look result lines were checked with their stated limitations.

5. **Installed files:** nine live DLL ProductVersions, three Contents creation times, retained Civil/Manager/Structural backup metadata, all 52 case hashes, 62 variant hashes and four setup hashes. Read the own cases and R47 setup in full, and the five counted positive cases and relevant variant texts.

## What I did NOT check

1. **No execution:** no AutoCAD opening, runner or case execution, v2/v3 call, test, build, install, lock, settings guard or sub-agent. No UI automation or fresh drawing was used.

2. **No new visual acceptance:** no window, picture, preview, label position, printed sheet or live drawing was judged. Existing Codex result lines are attributed above.

3. **No engineering approval:** no council criterion, Australian Standard compliance, design rule, sizing choice, storage requirement, grade or freeboard was approved. Those require Tim's judgement.

4. **No full source audit or fixture revalidation:** metadata and saved evidence were read. Fixture/settings hashes inside reports are recorded evidence, not my own fresh hashes of the fixtures/settings. Historical installation markers do not provide an installer transaction log.

5. **No bug closure:** neighbour-review bug conclusions are attributed, not newly certified by this catch-all. Historical visual FAILs and older-build runner FAILs are not asserted as present .79 faults without .79 evidence.

## Files written

1. **Report only:** C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr20.md. No review.txt qualifies for creation. No case, variant, setup, settings, ledger, run report, BUG_CARPARK, DESK_LOG or QUEUE was edited.

2. **Publication:** only this named report is staged and committed in C:\CE_PLAN. Other desk changes remain untouched. No worktree, product branch or PR is required for this read-only brief.

## Summary

The catch-all found three raised-freeboard probes: all PARTIAL, none ready, with one PASS on each of .78 and .79 and no own red. The plan names 38 checks, not 40. Five whole daily items qualify historically; none qualifies on installed Civil 3.0.79. Two new sessions of the five unchanged cases could add five current-build items. Eleven historical Codex look PASS results are listed separately. Eight assigned texts need review again. All nineteen neighbouring reviews are included. No AutoCAD, test or bug change was made.

