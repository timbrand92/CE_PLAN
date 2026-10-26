# Runner case review, cx_cr18: R35 and R37 (Codex independent review, Mon 26 Oct 2026)

Read RULES.md, the 24 Oct acceptance decision, both complete B3FIX and B3B model reviews, the review gate, the R16 example, earlier R35/R37 review sections, the cases and variants, their cards and bugs, installed DLL metadata and ledger/report evidence. Reviewed about 17:49-17:55 Melbourne. No AutoCAD, runner, case, build, install or test was run; no subagents. Only this report was written; existing review files and bug entries were left untouched.

## FOR TIM

1. **0 of these 2 cases are ready for whole-bug acceptance.** R35 needs a tighter check of the saved level. R37 covers only the words and drawing objects; someone still needs to see PD1 clearly on the plan.
2. **The installed Civil is now 3.0.79.** Both cases passed twice on 3.0.78 today, but neither has a recorded pass on 3.0.79. Each needs two new sessions after the required checks are settled.
3. **No bug may be newly written fixed from this review.** BUG-711 already carries acceptance on 3.0.75; the recorded levels are correct, but its check could also accept a comma where the decimal point belongs. For example, P18,600 could slip through while the command says P18.600.
4. **BUG-217 still needs a drawing look.** A PD1 text object exists in the records. That does not show whether the drafter can read it beside the perimeter drain, or whether repeated AG text still confuses it.

---

## ANSWER FIRST

1. **Counts, one main verdict per case:** CLAUDE-ACCEPTED-READY: 0; NEEDS STRONGER ASSERTION: 1 (R35); PARTIAL (part only): 1 (R37, prompt words and PD1 object existence). NEEDS BROKEN VARIANT: 0; NEEDS CODEX LOOK as the main verdict: 0; FAIL = real fault: 0; NEEDS RUNS as the main verdict: 0. Both also need two PASS sessions on installed Civil 3.0.79; R37's unproved visual part is NEEDS CODEX LOOK. These secondary requirements are not extra cases.
2. **Installed builds, read from the files, not the desk lead:**
   1. **Civil:** Legacy, Modern and Net8 each have ProductVersion `3.0.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa`. Live Contents creation: 26 Oct 2026 16:57:58 Melbourne.
   2. **Manager:** Legacy, Modern and Net8 each have ProductVersion `1.1.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa`. Live Contents creation: 26 Oct 2026 16:57:59.
   3. **Structural:** Legacy, Modern and Net8 each have ProductVersion `1.0.124+3a3caac5db7687f1b5d1a6e09571976c52b2b05a`. Live Contents creation: 25 Oct 2026 17:41:13.
   4. **Locations:** all under `C:\Users\TimothyBrand\AppData\Roaming\Autodesk\ApplicationPlugins`, in CE_CVL_SUITE.bundle, CE_SUITE_MANAGER.bundle and CE_STRUC_SUITE.bundle, respectively. DLLs are under Contents\Win64\Legacy, Modern and Net8. ProductVersion was read through VersionInfo for all nine files.
3. **Install windows, independently checked:** retained backup Contents creation times and their Modern DLL ProductVersions confirm Civil 3.0.75+2c805a39 at 25 Oct 03:33:02, 3.0.77+0d885094 at 25 Oct 20:42:01, and 3.0.78+d8840a09 at 26 Oct 05:41:30. Manager times are 03:33:02, 20:42:02 and 05:41:31. Current Civil/Manager times are item 2.
   1. **3.0.75 composite build window:** after 25 Oct 03:33:02 and before Structural changed at 17:41:13 (Civil itself next changed at 20:42:01). Structural 1.0.123+4af3f37d backup Contents creation is 24 Oct 12:42:11. Every relevant 3.0.75 session starts and finishes before either replacement.
   2. **3.0.77 window:** after 25 Oct 20:42:02 and before 26 Oct 05:41:30. All four relevant sessions fall inside it.
   3. **3.0.78 window:** after 26 Oct 05:41:31 and before 16:57:58. All four relevant sessions fall inside it. No counted session straddles an install.
   4. **Method limit:** folder creation is the available installation marker, not a measurement of the final copy operation. These runs are well clear of each boundary. Ledger hashes abbreviate the DLL commit suffix to eight characters; version and suffix agree with the backup DLLs, but none equals the current 3.0.79 build identity.
4. **Ledger checked row by row:** 602 rows at 17:54 Melbourne; 16 relevant rows: 14 PASS rows and 2 deliberately broken FAIL rows. Each case has seven separate PASS sessions: three on 3.0.75, two on 3.0.77, two on 3.0.78, zero on 3.0.79. No normal-case FAIL row, stale-hash row or additional variant row was found for these two IDs. Historical passes are evidence, not current acceptance.
5. **Current SHA-256 values, calculated with Get-FileHash:**
   1. **R35:** `81C7A36F125FE44F1AA2EDAA78131F478C55EA9C2CBEE4506CD04EB238273C07`.
   2. **R35_broken.case.txt:** `B9BA75FD32724F39FFD59BF10C153160EC9FA046C54FE2DC9D276B448EF3C307`.
   3. **R37:** `60891583BAAC5F43963FD56348668D8F6BE15EF94D8EEF8AB754EDF43582F779`.
   4. **R37_broken.case.txt:** `A0644C658C65273C2E6E10FAC1FAE6837449C1836A7A14B18F3ED3D466FEF02F`.
   5. **Equality and setups:** every relevant ledger row matches its current file. Both existing review hash lines also match. Neither case nor either variant has a SETUP line; the JSON setup fields are empty. There is therefore no referenced setup file to hash, rather than an assumed unchanged setup. Fixture DRV1_B1 is separate from the case hash; its drawing was not opened or rehashed here.
6. **Reds:** R35_BROKEN has one current-hash FAIL, `from_check=true`, in p3b3a1 on 3.0.75: no placement sentence and zero blocks against expected one. It is a weaker flipped red, not the "true red" its header claims. R37_BROKEN has one current-hash FAIL, `from_check=true`, in p3b3b3: cancellation leaves zero PD1 objects and no placement sentence. This is a real cancellation red, not a crash, timeout or E_FAIL. The second and third Esc captures explicitly show cancellation at Accept and nothing drawn.
7. **Whole daily-tool cards accepted from these cases on the installed build: 0. On any build under this review: 0.**
   1. **D26 / UX-SURV-03 / gap-plan section 2 item 26:** not accepted whole. R35 omits the linked-survey line and no-default prompt, and the Enter-for-blank placement. Its layer check is also weaker than D26 assertion 2.
   2. **D07 / UX-SRC-05 / gap-plan section 2 item 7:** not covered. That card places DP and CDRG on a blank drawing, then undoes the raingarden. R37 places CDPERIMETER on DRV1_B1; "neighbour" does not satisfy D07.
   3. **Gap-plan section 3 item 7:** contribution from this brief is 0 of the stated 40, on the installed build and on any build. No other case was recounted. The named eight checks plus thirty items total 38; retain the plan's denominator 40 pending the desk's reconciliation.
8. **Bugs that may be written FIXED (Claude-accepted, Civil 3.0.79, 26 Oct 2026): none.**
   1. **BUG-711:** already recorded FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026). Do not promote that historical wording to 3.0.79. Suggested desk note: "Independent review cx_cr18 found that R35's saved-level expressions do not require a literal decimal point. Recorded values on 3.0.78 are correct; tighten the checks and obtain two separate passes on Civil 3.0.79 before renewing acceptance. No CE regression demonstrated."
   2. **BUG-217:** remains OPEN; visible label and record agreement are not fully checked. Suggested desk note: "R37 proves perimeter-drain prompt words and creation of a PD1 text object on 3.0.78 in two sessions. Whole BUG-217 still needs a Codex look at the visible PD1 label and confirmation that the drain record has the same mark; no R37 pass is recorded on installed Civil 3.0.79."
   3. **D6:** neither entry was edited, closed or deleted. No unconditional FIXED wording is authorised by this report.

## How I applied the four conditions

1. **Nothing seen on screen:** R35's number checks need no look. R37's object and prompt checks need no look, but its bug's visible-label requirement does.
2. **Two separate sessions on one build:** the historical pairs below meet the session and install-window conditions. Zero sessions on installed Civil 3.0.79 for either current case hash.
3. **Red before green:** both current variants have check failures for the intended reason. R35's flipped refusal expectation does not exercise its five saved-level expressions.
4. **Card or bug comparison and full coverage:** R35 needs stronger saved-value assertions; R37 is only part of its bug. Neither supplies a whole D-card. No approval of council values, design rules, sizing choices or the office minimum grade is given; engineering judgement remains Tim's.

## The cases

1. **R35: CDSL typed level number check (BUG-711; D26 typed part).** Verdict: **NEEDS STRONGER ASSERTION.** Hash **81C7A36F125F**. No review file written.
   1. **Asks met:** BUG_CARPARK.md lines 2134-2138 name P18.6, 18,6, 18600 and 18.6m, acceptance of metres with optional P/RL, retry on bad input and P plus three decimals. Case steps 19-31 drive all these inputs plus RL18.6 and 18.600; lines 46-51 read five placed blocks; assertions 55-69 cover their messages, refusal, cancellation, counts and text patterns.
   2. **What the evidence actually shows:** all seven reports have 20 judged checks passing (record-only lines excluded). In the two 3.0.78 sessions the five LEVEL values are P18.600 and their layers are 25DIMS. The rejected 18600 point contains no spot block. The recorded reply asks for the proposed level again before Esc. No incorrect level is demonstrated.
   3. **Exact blocking weakness:** case lines 63-67 use `matches $e1 "text.:.P18.600.,.insertion"` and its four siblings. The runner uses `[regex]::Match` at case_runner_lib.ps1 line 448. The dot between 18 and 600 is a wildcard. These checks would accept P18,600 or P18x600 in the saved attribute while the separate command-line checks remain green. They also do not explicitly identify the LEVEL attribute. This undermines the exact normalised-number part of BUG-711, not merely presentation.
   4. **Exact replacement lines, in ASSERT:**

      ```text
      matches $e1 "tag.:.LEVEL.,.text.:.P18[.]600.,.insertion"
      matches $e2 "tag.:.LEVEL.,.text.:.P18[.]600.,.insertion"
      matches $e3 "tag.:.LEVEL.,.text.:.P18[.]600.,.insertion"
      matches $e5 "tag.:.LEVEL.,.text.:.P18[.]600.,.insertion"
      matches $e6 "tag.:.LEVEL.,.text.:.P18[.]600.,.insertion"
      ```

   5. **Retry and layer lines to add or replace at the same edit:** add `matches $s4e "Type it again.*Enter proposed spot level \(m\):"`; replace `not-contains $lay "0TEXT"` with `equals $lay "25DIMS | 25DIMS | 25DIMS | 25DIMS | 25DIMS"`. The existing reports contain both expected results. These are proposed edits only, not executed or validated by a run here.
   6. **After the edit:** new hash, two PASS sessions on Civil 3.0.79+d3f9c5df, then independent review. Exactly two more sessions are needed; the seven old-hash passes cannot count for edited text. Retain the refusal red as explicitly flipped; a saved-value corruption twin would give stronger evidence for the new expressions.
   7. **D26 comparison:** card lines 743-766: assertions 2 and 4 partly addressed; assertion 1's survey fixture and prompt, and assertion 3's blank placement, are absent. The earlier optional layer ask is still unmet. Correcting the lines above does not make all D26 accepted.
   8. **Codex look:** none for BUG-711's numeric claim. Spot-level appearance and other commands are outside this case. The case's builder-filled review comment is stale, but editing it would change the hash too.
2. **R37: CDPERIMETER draws the PD1 tag (BUG-217; D07 neighbour).** Verdict: **PARTIAL (part only: perimeter-drain prompt wording and existence of one PD1 text object on the drain's layer).** Hash **60891583BAAC**. No review file written.
   1. **Asks met:** BUG_CARPARK.md lines 6067-6075 require the drain's own PD1 tag, matching command and record, and a visible PD1 on the plan instead of confusing AG text and AGI prompts. Case line 19 follows the two-point, skip-outlet route with levels 18 and 17.9; lines 34-41 pin the command wording and reject the two AGI phrases. Lines 42-45 count one polyline and one PD1 text on AGI DRAIN.
   2. **Recorded result:** all seven reports have 16 judged checks passing. The 3.0.78 records contain polyline 11C559 and MText 11C55A, text PD1 at 151000,-79925, both AGI DRAIN. Count is 1036 after placement and 1034 after U; file unchanged. The count after U is not an identity check of both removed objects, so do not describe it as proof of every object's restoration.
   3. **Exact missing part:** the case itself says at line 15 that visibility, height, position and colour are not automated. The bug's test and confirmation explicitly require reading PD1 on the plan. The case also never reads the drain's CE record to compare its mark. No extra count assertion can replace that look.
   4. **Exact scope line to replace line 9:** `PROVES_BUGS BUG-217 (part only: perimeter-drain prompt wording and one PD1 text object on AGI DRAIN; visible label and drain-record agreement are not proved)`.
   5. **Exact companion look instruction for the desk:** "On a fresh copy, type CDPERIMETER; use two points 2000 mm apart; skip the outlet; enter 18 and 17.9; then Accept. Before U, capture the real plan and confirm a readable PD1 beside this drain, without clipping or overlap; record whether AG repeats along the line. Read the drain's CE mark and compare it with PD1 and the placement sentence." This is work for the authorised look lane, not a command run by this review.
   6. **Runs still needed:** zero on Civil 3.0.79; exactly two more PASS sessions on that build for the deterministic part, with the final reviewed hash. A changed scope line also invalidates older pass hashes. Whole BUG-217 needs the companion look and record comparison as well.
   7. **Engineering and scope limits:** 2 m with 0.1 m fall is 1 in 20, but the printed "office minimum 1:100" is observed wording, not my approval of a design rule. AGI DRAIN is the observed layer, not a new layer ruling. D07's DP/CDRG steps are absent. R37b and BUG-236 are separate and were not re-reviewed.

## Build and ledger detail: every relevant row

1. **Build keys:** A = `civil 3.0.75+2c805a39 / struc 1.0.123+4af3f37d / mgr 1.1.75+2c805a39`; B = `civil 3.0.77+0d885094 / struc 1.0.124+3a3caac5 / mgr 1.1.77+0d885094`; C = `civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09`. All times below are Melbourne. Every session ID is its full run name followed by `-s1`.
2. **R35, A, PASS:** RUN-20261025-0405-C3.0.75-p3b3a1; session 04:05:53-04:07:33; ledger at 25 Oct 04:07:33. R35_BROKEN in the same run/session is FAIL at the same ledger time, variant_of R35, from_check true.
3. **R37, A, PASS:** RUN-20261025-0550-C3.0.75-p3b3b3; session 05:50:23-05:52:10; ledger at 25 Oct 05:52:10. R37_BROKEN in the same run/session is FAIL at the same ledger time, variant_of R37, from_check true.
4. **R35, A, PASS pair:** RUN-20261025-0638-C3.0.75-pA3-s1 (06:38:08-06:40:27, at 06:40:27) and RUN-20261025-0720-C3.0.75-pB3-s1 (07:20:24-07:23:40, at 07:23:40), both 25 Oct.
5. **R37, A, PASS pair:** RUN-20261025-0640-C3.0.75-pA4-s1 (06:40:33-06:43:09, at 06:43:09) and RUN-20261025-0723-C3.0.75-pB4-s1 (07:23:47-07:30:07, at 07:30:07), both 25 Oct.
6. **R35, B, PASS pair:** RUN-20261025-2118-C3.0.77-g77a4-s1 (21:18:56-21:21:38, at 21:21:38) and RUN-20261025-2221-C3.0.77-g77b4-s1 (22:21:09-22:24:15, at 22:24:15), both 25 Oct.
7. **R37, B, PASS pair:** RUN-20261025-2121-C3.0.77-g77a5-s1 (21:21:44-21:30:03, at 21:30:03) and RUN-20261025-2224-C3.0.77-g77b5-s1 (22:24:21-22:32:48, at 22:32:48), both 25 Oct.
8. **R35, C, PASS pair:** RUN-20261026-1103-C3.0.78-g78a3-s1 (11:03:12-11:05:39, at 11:05:39) and RUN-20261026-1153-C3.0.78-g78b3-s1 (11:53:26-11:56:09, at 11:56:09), both 26 Oct.
9. **R37, C, PASS pair:** RUN-20261026-1105-C3.0.78-g78a4-s1 (11:05:45-11:10:52, at 11:10:52) and RUN-20261026-1156-C3.0.78-g78b4-s1 (11:56:13-12:02:09, at 12:02:09), both 26 Oct.
10. **Row interpretation:** all normal PASS rows have empty variant_of and from_check false. That does not disqualify a PASS; from_check true is required for the red. Session starts/finishes come from the JSON session records, and the at values from ledger rows. Reports are the matching .json and .md under areas\runner-reports. No extra session is inferred from multiple cases in one run.

## Things the desk should know first (RULES 6.2)

1. **The 07:10 leads are now stale:** there are seven PASS sessions per case, not five, including two on 3.0.78. Installed Civil is 3.0.79, Manager 1.1.79. The old hash prefixes remain correct.
2. **B3's R35 ready verdict missed the decimal wildcard.** Its records show correct saved values; its assertions do not enforce them precisely enough. This is a case weakness, not evidence that CE currently writes bad levels. The previously written BUG-711 status remains historical and was not edited.
3. **B3/B3FIX/B3B's R37 ready wording must not be counted as whole BUG-217.** B3 itself correctly reserved the visible label for a Codex look. This brief requires the main PARTIAL verdict for a part-only bug claim; the earlier label is not proof of the remaining part.
4. **Existing review files still pass the hash/reviewer portion of the gate.** Both retain Opus's 3.0.75 verdicts and today's hashes. They were neither replaced nor deleted because neither case is READY in this review. The later g77b and g78b reports print ACCEPTED-READY using that old approval. The runner does not discover this report's disagreement automatically.
5. **Gate scope:** Get-CaseIndependentReview checks the READY line, current case hash and non-builder REVIEWER. It does not compare the prose build, verify whole-bug coverage, or hash a setup. Both cases have an empty BUG line despite their PROVES_BUGS claims; I checked the reds independently rather than relying on the printed acceptance field.
6. **No assertion changes were made.** The report gives the desk exact edits. Even a comment-only case change creates a new hash and requires fresh qualifying passes. No review file was written for a variant.

## What I read

1. **Authority and plan:** C:\TimOS\RULES.md completely, ROUTER.md, the complete 24 Oct acceptance decision; START_HERE.md orientation; RELEASE_9NOV_GAP_PLAN_2026-10-22.md sections 2 and 3 item 7; DAILY_TOOLS_TEST_CASES_2026-10-23.md D07 and D26; BUG_CARPARK.md BUG-711 and BUG-217.
2. **Review history:** complete RUNNER_CASE_REVIEW_B3FIX_2026-10-25.md and RUNNER_CASE_REVIEW_B3B_2026-10-25.md. Searched every areas\RUNNER_CASE_REVIEW_*.md for R35 and R37. Relevant matches were B3, B2FIX, B3FIX and B3B; read their R35/R37 scope, count, red and acceptance passages. The newest matching B3B carries their earlier acceptance forward, with no new R35/R37 assertion request.
3. **Local case evidence:** both complete cases, both current variants, both existing review files, R16's six-line review format, case_runner.ps1 Get-CaseIndependentReview and adjacent fresh-copy/setup handling, and case_runner_lib.ps1 assertion implementation. No C-number is claimed by these cases, so no unrelated C-card was assigned.
4. **Build and runs:** all nine live DLL ProductVersions, Contents creation times, relevant retained backup metadata, the 602-row ledger filtered by exact case/variant family, and relevant case/session/check evidence in the fourteen matching JSON reports and their Markdown case/acceptance passages. File hashes were taken independently and normal-case hashes rechecked before writing.

## What I did NOT check

1. **Nothing run in AutoCAD:** no runner, driver, lock, settings guard, case, build, install, test or subagent. No fresh reproduction and no screenshot viewed or taken.
2. **Not inspected:** CE implementation code, drawing files, the drain's stored CE mark, live settings, engineering validity of the office minimum, other bugs or whole-product acceptance totals. Recorded file/settings results remain the runner's observations.
3. **No changes to evidence:** no case, variant, setup, ledger, run report, settings, BUG_CARPARK.md, DESK_LOG.md or QUEUE.md changed. Existing .review.txt files remain intact.

## Files written

1. **Report only:** C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr18.md. Commit and push are restricted to this named report; other jobs' staged and unstaged files are left alone. No new or replacement review file is warranted.

## Summary

0 of 2 cases are ready for whole-bug acceptance. R35 needs literal-decimal checks tied to LEVEL; its recorded values are correct. R37 is PARTIAL: prompt words and PD1 object existence pass, but visible label and record agreement remain unproved. Each has seven historical PASS sessions, including two on 3.0.78, and none on installed 3.0.79. Both need two new sessions on that build after any edits. No new fixed bug or whole daily-tool item is authorised. Existing review files remain untouched. Nothing was run.
