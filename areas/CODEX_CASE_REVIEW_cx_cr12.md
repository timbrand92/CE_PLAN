# Runner case review, cx_cr12: R01, R02 and R02b against D01 and D03 (Codex independent review, Mon 26 Oct 2026)

Written Mon 26 Oct 2026, about 17:43 Melbourne, by Codex (GPT-6). Read the rules, decision, earlier reviews, cards, bugs, case and setup text, installed DLL versions, ledger rows and saved run reports. Nothing run in AutoCAD; no runner, case, variant, build, installation, test, lock or settings guard invoked. Only this report is written; no bug status or existing review file is changed.

## FOR TIM

1. **None of these three cases is ready for whole-item acceptance from this review.** R01 and R02 need stronger checks; R02b proves only the pipe-ending-on-a-pit part. The report gives the exact additions for the case owner.
2. **The installed Civil version is now 3.0.79, not the morning brief's 3.0.78.** All three cases passed twice on 3.0.78 today, but none has a recorded pass on 3.0.79. Each needs two separate starts on the installed build after its checks are settled.
3. **No bug may be newly written fixed.** The recorded pipes join P8 and the repeated placement works. However, a Pit Schedule level of 18.09 could pass R02 when the job requires 18.000; that check needs tightening.
4. **The old 1 in 54 label is explained by the robot's short pipe.** Its stored view was out of date. This review finds no recorded CE failure in the current three case texts and asks for no engineering decision.

---

## ANSWER FIRST

1. **Counts: one main verdict per case, three cases.** CLAUDE-ACCEPTED-READY: 0. NEEDS STRONGER ASSERTION: 2 (R01, R02). PARTIAL (part only): 1 (R02b, typed incoming pipe joins P8). NEEDS BROKEN VARIANT: 0. NEEDS CODEX LOOK: 0 for the numerical claims. FAIL = real fault: 0. NEEDS RUNS as the sole main verdict: 0; all three additionally lack two sessions on installed Civil 3.0.79.
2. **Installed build, read directly from all nine DLLs.** Under `C:\Users\TimothyBrand\AppData\Roaming\Autodesk\ApplicationPlugins`, the Legacy, Modern and Net8 lanes each give the following identical ProductVersion within their product:
   1. **Civil:** `3.0.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa`. `CE_CVL_SUITE.bundle\Contents` created 26 Oct 16:57:58.
   2. **Manager:** `1.1.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa`. `CE_SUITE_MANAGER.bundle\Contents` created 26 Oct 16:57:59.
   3. **Structural:** `1.0.124+3a3caac5db7687f1b5d1a6e09571976c52b2b05a`. `CE_STRUC_SUITE.bundle\Contents` created 25 Oct 17:41:13.
   4. **Build comparison:** the latest relevant ledger string is `civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09`. Civil and Manager differ from installed. The short commit suffixes match the full ProductVersions in the saved report headers. All times here are Melbourne, AEDT, UTC+11.
3. **Install boundaries checked from retained bundle folders, not assumed from the brief.** These are filesystem install markers, not a claim to have watched installation finish. The previous Civil backups contain the corresponding DLL ProductVersions. Every counted report starts and finishes safely inside the relevant interval:
   1. **3.0.74 / Manager 1.1.74:** Civil Contents created 24 Oct 17:19:58; Manager 17:19:59. Next Civil replacement backup is dated 25 Oct 03:32:00; 3.0.75 Contents created 03:33:02.
   2. **3.0.75 / Manager 1.1.75:** 25 Oct 03:33:02; next Civil replacement starts at the backup marker 20:41:00, with 3.0.77 Contents created 20:42:01. Structural changes earlier, from 1.0.123 to 1.0.124 at the 17:40:12 backup / 17:41:13 Contents markers. All counted 3.0.75 rows finish by 16:10:53, before either change.
   3. **3.0.77 / Manager 1.1.77:** 25 Oct 20:42:01 to the 26 Oct 05:40:29 replacement marker. 3.0.78 Civil Contents created 05:41:30 and Manager 05:41:31.
   4. **3.0.78 / Manager 1.1.78:** 26 Oct 05:41:31 to the next replacement marker, 16:56:57. Current Civil and Manager Contents were created 16:57:58 and 16:57:59. The four relevant 3.0.78 reports run between 11:15:12 and 12:24:03; none straddles installation.
4. **Ledger accounting, read row by row from the 602-row array.** R01 has 8 current-hash PASS rows in 8 sessions: two each on 3.0.74, 3.0.75, 3.0.77 and 3.0.78. R02 has 6 in 6 sessions: two each on 3.0.75, 3.0.77 and 3.0.78. R02b has the same six-session distribution. There are zero current-hash FAIL rows for these three parent cases, and zero rows for them on 3.0.79. Excluded older-text rows: R01 3, R02 10, R02b 0. Older passes and older failures count for nothing here.
5. **Every same-build pair, with full session identifiers and ledger `at` times.** These are valid historical PASS pairs, not a claim that incomplete checks prove whole cards:
   1. **R01, 3.0.74:** `RUN-20261025-0119-C3.0.74-hdnA1-s1` (25 Oct 01:34:19) and `RUN-20261025-0238-C3.0.74-hdnB1-s1` (02:51:04).
   2. **R01, 3.0.75:** `RUN-20261025-1520-C3.0.75-b3bh1-s1` (25 Oct 15:38:07) and `RUN-20261025-1556-C3.0.75-b3bh3-s1` (16:10:53).
   3. **R01, 3.0.77:** `RUN-20261025-2149-C3.0.77-g77a8-s1` (25 Oct 22:02:07) and `RUN-20261025-2252-C3.0.77-g77b8-s1` (23:05:55).
   4. **R01, 3.0.78:** `RUN-20261026-1122-C3.0.78-g78a7-s1` (26 Oct 11:30:57) and `RUN-20261026-1215-C3.0.78-g78b7-s1` (12:24:03).
   5. **R02 and R02b, 3.0.75, each:** `RUN-20261025-1121-C3.0.75-b3y1-s1` (25 Oct 11:49:14) and `RUN-20261025-1329-C3.0.75-b3y2b-s1` (13:48:55).
   6. **R02 and R02b, 3.0.77, each:** `RUN-20261025-2136-C3.0.77-g77a7-s1` (25 Oct 21:49:41) and `RUN-20261025-2238-C3.0.77-g77b7-s1` (22:52:26).
   7. **R02 and R02b, 3.0.78, each:** `RUN-20261026-1115-C3.0.78-g78a6-s1` (26 Oct 11:22:13) and `RUN-20261026-1206-C3.0.78-g78b6-s1` (12:15:09).
6. **Reds: all current variant hashes, `variant_of` names the right parent, result FAIL and `from_check: true`.** These are saved check failures, not crashes:
   1. **R01_BROKEN:** `RUN-20261025-0151-C3.0.74-hdnA2v-s1`, at 25 Oct 02:05:46. Sixteen of 27 entries fail, including two placements expected versus one actual. It substitutes SETUP-P8, so the second pick never happens. This is a weaker simulated missing-placement red (called a flipped-by-setup red in HARDEN), not an actual broken CE build and not merely an expected word changed.
   2. **R02_BROKEN:** hdnA2v above; `RUN-20261025-1121-C3.0.75-b3y1-s1` at 11:49:14; `RUN-20261025-1329-C3.0.75-b3y2b-s1` at 13:48:55. Each has one pipe, but x is 152000 instead of 150225 mm and the flow is Open end -> Open end. The three intended checks fail. True changed-landing red; it never opens the Pit Schedule.
   3. **R02b_BROKEN:** `RUN-20261025-1329-C3.0.75-b3y2b-s1` at 13:48:55 and `RUN-20261025-1439-C3.0.75-b3x3-s1` at 14:47:33. One new pipe exists; the `Flow: Open end -> P8` check fails. The endpoint is 2 m short. The start IL also changes from 18.100 to 18.090 to avoid the grade question; that cannot create a P8 join. Its BLOCKED attempt in b3y1 is not a red and is not a ledger FAIL.
7. **Whole daily-tool / gap-plan items accepted by this review: 0 on installed 3.0.79; 0 on any build.** This is this brief's scope, not a global recount of all 40:
   1. **D01 / UX-STD-01b, gap plan section 2 item 1 and section 3 item 7:** placement, Esc and last-pipe Undo have historical proof, but the outcome multiplicity required by D01 assertion 4 is not enforced. No whole-item acceptance until item 1 below is resolved.
   2. **D03 / UX-PIPE-02, gap plan section 2 item 3 and section 3 item 7:** the two directions have historical join evidence, but R02's schedule check admits the wrong number. R02b alone is only the incoming-pipe part. No whole-item acceptance until item 2 below is resolved and both cases have current-build sessions.
8. **Bugs that may be written `FIXED (Claude-accepted, Civil 3.0.79, 26 Oct 2026)`: none.** No suggested FIXED wording is justified. BUG-862 remains open: R01 covers completed PIT/CD only, not empty cancellation, refusals or the downpipe command. BUG-560 remains open: the cases type the pit centre, whereas its entry explicitly says the fault concerns a mouse pick on the pit body. Never close or delete either entry (D6).

## How I applied the four conditions

1. **Nothing seen on screen:** the scoped placement counts, log words, flow lines, coordinates and schedule values can be reviewed without pictures. No window appearance or label position is accepted.
2. **Two passes in separate AutoCAD sessions on one build:** historical pairs exist as listed; none is on the installed build. A passing row is evidence only for its exact file hash and full build string.
3. **Red before green:** current variant hashes and intended failed checks are verified above. R02's new schedule checks have no corresponding schedule red in its existing twin.
4. **Compared with the card, and full coverage:** mapped line by line below. Historical READY wording does not override a missing assertion. Partial coverage counts only for the named part.

## The cases

1. **R01: PIT and CD keep placing until Esc (D01, UX-STD-01b; BUG-862 completed part).** Verdict: **NEEDS STRONGER ASSERTION.** Hash **99BC70E23675**. No review file written.
   1. **Asks met:** the first review's second-placement and exact-composition requests are present. SETUP-P8x2 lines 12-28 and 34-48 start each command once, place twice and end with Esc. R01 lines 47-62 check both prompts, two pits, two pipes, two arrows, four IL texts, six MTexts and no placement window left open.
   2. **D01 assertions 1-3:** card lines 117-119 map to case lines 47-68 and 73. The two-placement version deliberately leaves the first pipe after U. Both latest reports read 2 pits / 1 pipe / 1 arrow / 2 IL texts / 3 MTexts afterwards; U echoes CD. The old request is met for this adapted two-placement route.
   3. **D01 assertion 4 is not fully checked:** card line 120 requires an exact outcome count. Case lines 69-72 use `has` and `absent`, so one or several completed lines pass. The latest reports actually read TWO completed PIT lines and TWO completed CD lines. HARDEN acknowledged this changed per-placement behaviour; it did not add a count check. BUG-862 defines outcome words, not an exemption from checking multiplicity.
   4. **Exact additions after line 72, for the present two-placement route:** ASSERT `log civil count "Command outcome: PIT " = 2`; `log civil count "Command outcome: CD " = 2`; `log civil count "Command outcome: PIT completed" = 2`; `log civil count "Command outcome: CD completed" = 2`. Record explicitly in the case contract that D01's one-placement count is doubled here. If the desk retains the card literally, use a separate one-placement check with each count equal to 1. Do not silently say the current case enforces either count.
   5. **Red and runs:** add the same count checks to R01_BROKEN; its one-placement setup should fail them. This proposal is unrun. After editing, exactly two new PASS sessions are needed on Civil 3.0.79 with the new hash; all eight old passes would be stale for that text.
   6. **Setup and small points:** SETUP-P8x2's hash and modification time are unchanged from B3B. The case hash still does not bind it. Its comment promises a second 20 m pipe, but its blind clicks use the stored view from before the first pipe. This does not invalidate the second-placement count; it cannot prove that pipe's length or intended location.
   7. **Codex look / engineering limit:** pit labels, text sizes and appearance need a separate look. This review does not approve pipe grade choices or council requirements. BUG-862 is only part-covered even after these additions.
2. **R02: pipe starts on P8, including the Pit Schedule (D03 start half).** Verdict: **NEEDS STRONGER ASSERTION.** Hash **807FCF12EFBA**. No review file written.
   1. **Asks met:** HARDEN's schedule open/read/Close route is present in lines 30-35. D03 assertion 1 (card line 168) maps to case lines 37-39; assertion 4 (card line 171) maps to line 40. One pit and one pipe are checked at lines 41-43. The two latest passes show the expected flow once and exactly one free far-end line.
   2. **Geometry limitation stated honestly:** D03 assertion 2 (card line 169) asks for the first vertex inside the pit outline. Lines 25-27 and 45-46 read a bounding-box corner, not a vertex: 150225,-80112.5 mm. This is useful wall-position evidence for the straight typed route, supported by the flow line; it is not a direct topology or vertex read. The run's schedule calls this pit 450 x 450, not the older review's assumed 600 mm outline. The observed 225 mm wall offset fits 450 mm.
   3. **Blocking schedule gap:** D03 assertion 3 (card line 170) requires IL 18.000 and the pipe diameter. Case line 48's `18\.0+.` accepts a prefix of 18.09; line 49's `225.` can accept a prefix of 2250. The saved row really contains 225 and 18.000, but the assertions would not reject those wrong values. A 90 mm IL error matters on a drainage job. B3FIX called tightening optional; under this brief's whole-card rule it is required.
   4. **Exact replacements for lines 48-49:** ASSERT `matches $psd "name.:.Pit P8.,.id(?:(?!name.:.Pit ).)*?name.:.18\.000.,.id"`; `matches $psd "name.:.Pit P8.,.id(?:(?!name.:.Pit ).)*?name.:.225.,.id"`. The closing cell delimiter prevents a numeric prefix from satisfying the requirement. Keep the match bounded to P8. The recorded inlet cells are blank and these populated cells follow them in the outlet positions; preserve that fixture contract.
   5. **Exact red addition:** after R02_BROKEN's line 35, add the same PITSCHEDULE steps as R02 lines 30-35, then the `control`, two tightened `matches`, and `window-closed` assertions. Its pipe starts 2 m away, so the P8 outlet cells should not satisfy the joined-pipe requirements. Require a recorded check failure for those cells; the existing three red rows establish the join check only. No such run was done here.
   6. **Whole-card and runs:** R02 explicitly claims only the start half at line 4. R02b supplies the other direction, but does not repair this schedule assertion. After correction, two PASS sessions of the changed R02 are needed on Civil 3.0.79, with R02b also passed in two sessions on that build before counting D03 whole.
   7. **Small points and look:** line 17 saying the other end is not covered is stale as a suite statement; R02b exists. Any comment edit changes the case hash. BUG-560 is expressly excluded by line 18. Schedule layout and pipe/pit appearance need a separate Codex look; reading the cells is not that look.
3. **R02b: pipe ends on P8 (D03 other-end part).** Verdict: **PARTIAL (part only: a typed incoming pipe is recorded as joined to P8).** Hash **2EF087A67698**. No review file written.
   1. **Asks met:** the HARDEN twin exists. Case lines 19-25 draw from 130000,-80000 to 150000,-80000, with ILs 18.100 and 18.000, then Esc. Lines 32-35 assert the P8 flow line once, one new pipe, and its y coordinate. The genuine missed-pit variant fails the flow check.
   2. **What is only recorded:** line 40 records a box ending at x 149775 mm in both latest passes. No assertion checks that right edge. The y assertion alone also permits a pipe stopped 2 m short on the same horizontal row. The flow-line check is the discriminating join evidence; the box record is corroboration, not an enforced endpoint check.
   3. **Exact strengthening after line 35:** ASSERT `matches $b_pipes "bounding box \(130000, -80112\.5, 149775, -79887\.5\)"`. This uses the existing pipe `note` recorded in the reports and checks the complete box of this fixed straight fixture. It is not a general pipe endpoint reader. Add the corresponding `matches $b_pipes` assertion to R02b_BROKEN; its shorter box should fail. These proposed lines are unrun.
   4. **Why PARTIAL, despite earlier READY wording:** lines 4 and 16 expressly limit the claim to the other end. It does not check the starting-on-pit route or P8's schedule after this insertion. Under this brief a half-card is labelled PARTIAL. Do not count it as a third daily tool or as whole D03. To count whole D03, resolve R02 item 2.4-2.6 and keep the pair as one item; do not duplicate a full start-route test unnecessarily.
   5. **Runs and look:** zero passes on Civil 3.0.79; exactly two separate-session PASS rows are required there, using the current hash if unchanged or the new hash after the proposed addition. No picture is needed for the limited flow-line claim. Appearance and placement remain outside this review.

## Things the desk should know first (RULES 6.2)

1. **The 07:10 leads are now out of date.** Installed is 3.0.79. Current-hash PASS session totals are R01 8, R02 6 and R02b 6, with two each on 3.0.78. The morning totals of 6 / 4 / 4 and zero on 3.0.78 were historical, not today's final position.
2. **The earlier full-acceptance conclusions are too broad for the present brief.** R01 does not enforce D01's outcome count; R02's numeric pattern is permissive; R02b is a named half. This review withholds whole D01 and D03, while preserving the genuine historical passes. It does not find a new CE failure.
3. **All three existing review files still match their parent hashes.** R01's file says Civil 3.0.74; R02 and R02b say 3.0.75. They are not invalidated by a hash mismatch. I left them untouched as instructed. The runner can still rely on them; this report's changed judgement is not automatically enforced by its gate.
4. **The setup gap remains in the actual gate.** `Get-CaseIndependentReview`, runner lines 116-126, checks verdict, parent case hash and reviewer. The library reads a setup hash, and the pack hash includes setups, but the per-case ledger/review gate does not bind the setup hash. A pack header is not a case-specific setup attestation. File modification times support continuity but cannot cryptographically prove the old setup bytes.
5. **Other gate limits observed while reading:** `Resolve-CaseAcceptance` accepts missing hashes in legacy ledger rows, does not compare a red's hash with its current variant, and requires a red only when `BUG` is non-empty. These three cases have empty BUG headers. This review applied the brief's stricter manual hash/red rules.
6. **The 1 in 54 lead checks out, with a limit:** b3p4 records VIEWSIZE changing from 30000 to 8149.719 mm. b3p2 records the second pipe box starting at x 157425.799 and its IL texts at 157625.799 and 162599.200, plus ILs 17.800/17.700 and the 1 in 54 label. The scale change explains a roughly 5.4 m pipe. PRB_R01 was ultimately BLOCKED, so its successful early reads are diagnostic evidence only, never a PASS or red. No CE fault is established by that label.
7. **Gap-plan wording:** D03's own correction says pit outline plus 100 mm, not the gap plan's 75 mm pipe-to-pipe distance. D01 covers Esc; Enter-only termination is explicitly unproven in its card. Neither this report nor the old passes accepts engineering values or a broader Enter claim.

## Hashes read directly

1. **R01:** `99BC70E236751F8086E5542A7547A3C5431B56F16F31BC83BB62C8D3C5020108`.
2. **R02:** `807FCF12EFBACC09ED6E0D034FD6FE2BAD1DFA03EF8844B0C445579FCE6BEE12`.
3. **R02b:** `2EF087A676980300FF18ACA34886E6D122BE943D4ED241FFBBA57643468D8664`.
4. **R01_BROKEN:** `8D6A64A5E2DF6CFCD8B591454C52F7504C133DE7D9326F9394FDD03F74ECF641`.
5. **R02_BROKEN:** `CF4B9FCEC37A078F634702BA6E7463682F7373A5CB06240B4230281A90555A96`.
6. **R02b_BROKEN:** `71A7892E421100FDD54D06E64D31AD9E0157D2974AD0EA79340F04044277E677`.
7. **SETUP-P8:** `7A241608EB590525E0F1D37AB459F9D7116677D17AD6CD5C4C2D6C97FC496F03`; modified 23 Oct 20:05:31. Used by R02, R02b, R01_BROKEN and R02b_BROKEN; R02_BROKEN embeds its own steps.
8. **SETUP-P8x2:** `81152F70E47695E49504157147A864FB14761ED668A1B308903A7C18B2F4E3FE`; modified 24 Oct 23:17:29. Used by R01. Both setup hashes equal the earlier reviews' recorded prefixes. Every parent and red row counted above has the exact corresponding current 64-character hash.

## What I read

1. **Authority and method:** `C:\TimOS\RULES.md` in full, `ROUTER.md`, the 24 Oct Claude-accepted decision in full, B3FIX and B3B reviews in full, and the CE_PLAN start/map material relevant to this review. This is the independent case review for the release gap-plan daily-tool gate.
2. **Prior case requests:** searched R01, R02 and R02b across every `areas\RUNNER_CASE_REVIEW_*.md`. Read the first-review and HARDEN case sections, B3FIX/B3B cases and findings, and relevant mentions in R11_R20, B2, B2FIX and B3. No later matching RUNNER_CASE_REVIEW section superseded B3B's R01 or B3FIX's R02/R02b requests.
3. **Contracts:** D01 lines 100-123 and D03 lines 153-174, their shared setup and corrections in `DAILY_TOOLS_TEST_CASES_2026-10-23.md`; gap-plan section 2 items 1/3 and section 3 item 7; BUG-862 and BUG-560 entries in `BUG_CARPARK.md`. These cases claim D cards, no C card.
4. **Local evidence:** all three case files, all three matching variants, both setups, all existing review files and R16's six-line example; the review and acceptance functions and relevant text/hash handling in the runner/library, read as text only.
5. **Recorded runs:** JSON headers, sessions and relevant case entries for every run listed in ANSWER FIRST; detailed latest 3.0.78 checks and b3y2b/hdnA2v reds, with their Markdown report lines; b3p2 and b3p4 diagnostic reads. Ledger read as one array, joined to hashes I computed with Get-FileHash.
6. **Installation and delivery:** all nine live DLL ProductVersions and Contents creation times, relevant retained backup DLLs/folder dates, repository status and the leak-scan skill. The full pack hash is not reconstructed here: reports can stamp the full selected pack while an individual run contains only a subset.

## What I did NOT check

1. **Nothing executed:** no AutoCAD, runner, case, variant, offline case test, build, installation, settings guard, lock or sub-agent. Proposed lines have not been run or tested.
2. **No visual acceptance:** no screenshot, window layout, label position, preview or drawing appearance inspected. No engineering values approved.
3. **No whole-program claim:** no other case re-reviewed, no global 40-item recount, no current-build runtime result inferred from an older build. CE implementation source and historical raw AutoCAD logs were not audited.
4. **No protected-file changes:** no case, setup, variant, ledger, run report, settings, bug register, desk log or queue edited. Existing review files remain as read; no new review file is justified by these verdicts.

## Files written

1. **Report only:** `C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr12.md`. Commit and push are restricted to this named file. No draft PR is required by this read-only brief. Undo is a revert of this report's commit.

## Summary

R01 and R02 need stronger assertions; R02b proves only the incoming-pipe part of D03. No whole D01 or D03 is accepted by this review, and no bug may be newly written fixed. All three have two current-hash passes on Civil 3.0.78, but installed Civil is now 3.0.79 and has none. Exactly two current-build sessions per case remain after corrections. Existing review files are untouched. No AutoCAD, runner, build or test was run.