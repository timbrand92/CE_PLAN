# Runner case review, cx_cr10: R34sn, R34so and R36 (Codex independent review, Mon 26 Oct 2026)

Written Mon 26 Oct 2026, about 17:35 to 17:40 Melbourne, by Codex (GPT-6). I read the rules, acceptance decision, earlier reviews, cards, bugs, current case texts, installed DLL versions, installation records and ledger rows. I ran no AutoCAD command, runner, case, build, installer or test. Only this report is written; no case, variant, settings, ledger, bug or desk record is changed.

## FOR TIM

1. **None of these three cases is ready for whole-feature acceptance.** R34sn and R36 cover part only. R34so records a real fault on Civil 3.0.78: rotating a copied pit leaves it without its number label and cover-level text.
2. **Civil 3.0.79 is now installed.** The two passing sessions for R34sn and R36 are on 3.0.78. None of these three has a recorded run on 3.0.79, so today's installed result is unknown.
3. **No bug may be newly written fixed from this review.** For example, placing a floor waste in open space does not prove the same tool works at a pipe end, or that CDSOURCE works.
4. **The next work is specific.** Finish the plain COPY card, cover the missing source routes, and recheck the rotated copy. No engineering decision is made here; a decision about placing a floor waste on an inspection opening still belongs to Tim.

---

## ANSWER FIRST

1. **Counts, one main verdict per case:** CLAUDE-ACCEPTED-READY: **0**; NEEDS BROKEN VARIANT: **0**; NEEDS STRONGER ASSERTION: **0**; PARTIAL: **2** (R34sn, R36); NEEDS CODEX LOOK: **0**; FAIL = real fault: **1** (R34so, demonstrated on 3.0.75 and 3.0.78, not yet on 3.0.79); NEEDS RUNS: **0 as the main verdict**. All three also lack installed-build runs: each needs two passing sessions on 3.0.79 after its other blockers are addressed. Partial coverage cannot be repaired by more identical runs.
2. **Installed DLLs, read from disk at 17:35 Melbourne:**
   1. **Civil:** Legacy, Modern and Net8 each read `3.0.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa`.
   2. **Manager:** Legacy, Modern and Net8 each read `1.1.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa`.
   3. **Structural:** Legacy, Modern and Net8 each read `1.0.124+3a3caac5db7687f1b5d1a6e09571976c52b2b05a`.
   4. **Contents creation times:** Civil 26 Oct 16:57:58; Manager 26 Oct 16:57:59; Structural 25 Oct 17:41:13. Civil/Manager installation verified at 26 Oct 16:58:12; Structural at 25 Oct 17:41:28. Creation is the start of copying, not the completion of installation.
3. **Installation boundaries, checked against the actual install logs and preserved Contents folders:**
   1. **Civil 3.0.75:** Contents created 25 Oct 03:33:02, installation verified 03:33:13. The full ledger build with Structural 1.0.123 ceased at the Structural replacement starting 25 Oct 17:41:13. Civil itself remained 3.0.75 until 20:42:01; the C-67 log explicitly reads it as the previous version. No C-66 installation is assumed.
   2. **Civil 3.0.77:** installation started 25 Oct 20:42:01, verified 20:42:11; next replacement started 26 Oct 05:41:30.
   3. **Civil 3.0.78:** installation started 26 Oct 05:41:30, verified 05:41:40; next replacement started 26 Oct 16:57:58.
   4. **Civil 3.0.79:** verified 26 Oct 16:58:12; no later installation found in this review. Current build key is `civil 3.0.79+d3f9c5df / struc 1.0.124+3a3caac5 / mgr 1.1.79+d3f9c5df`.
   5. **No counted evidence straddles an installation.** b3v2 ran 25 Oct 12:58:41-13:03:05; b3v3 14:34:08-14:39:04; b3v4 14:47:35-14:49:15; b4a1 ran 26 Oct 03:45:02-03:56:12; b4c1 05:42:18-07:06:05; b4c2 07:06:38-08:05:50. Both whole-run intervals and ledger `at` times fall inside their build intervals.
4. **Ledger and hashes:** 602 ledger rows read, with every row for these case IDs and their variants examined. Current case hashes agree with the 07:10 leads; the counts have since changed. The complete current-hash main-case rows are listed below. Old hashes count for nothing.
   1. **R34sn:** four current-hash PASS rows, zero FAIL. Two separate sessions on 3.0.75 and two on 3.0.78. No row on 3.0.79.
   2. **R34so:** four current-hash FAIL rows, zero PASS. Two on 3.0.75 and two on 3.0.78, all `from_check=true`. No later row disproves the fault, and no row tests 3.0.79.
   3. **R36:** three current-hash PASS rows, zero FAIL. One on 3.0.77 and two on 3.0.78. No row on 3.0.79. The two 3.0.75 b3x passes cited in B3FIX have a different hash and cannot qualify today's text.
   4. **Shared setup:** none of these three cases or their three variants has a SETUP line. The parsed reports also show empty setup fields. There is therefore no applicable SETUP file to hash. A pack's shared setup for another case is not evidence that these cases use it.
   5. **Review gate:** `case_runner.ps1` lines 116-126 requires the verdict line, exact case SHA-256 and a REVIEWER that does not start with builder. It does not bind a setup hash or validate the review's build text. No review file exists for these three cases; none is created by this review.
5. **Reds, current variant hashes verified personally:**
   1. **R34sn_BROKEN:** `F2CBD851707E97B476346A1D4C02D56E8C6C2034792F9C910CA517D867666706`. b4c1-s4 and b4c2-s4 are FAIL, `variant_of=R34sn`, `from_check=true`. It expects P3 after ordinary COPY; the passing case reads P8. This is a weaker flipped red, and it does not exercise SCALE Copy.
   2. **R36_BROKEN:** `6D5FBC221FFB79E36C5F240026DC24CB087DE40D99439656C7BF819EAB0F5EA1`. b4c1-s3 and b4c2-s3 are FAIL, `variant_of=R36`, `from_check=true`: Esc gives no placement sentence and zero FLOOR WASTE blocks against one expected. This is a true behavioural red, not a crash or timeout.
   3. **R36_AGI_BROKEN:** `748A61AEEC08FA2D682BF27D9D77D75D6CFCAD4E43D5C2DD38DB7B5DDA86EC9E`. b4c1-s3 and b4c2-s3 are FAIL, `variant_of=R36`, `from_check=true`: expects five AGI blocks while CE reports four. This is a flipped red.
   4. **R34so:** no `R34so_*.case.txt` variant exists. Its own genuine failing checks provide before-fix evidence for this route, but are not a variant row.
6. **Daily tools and gap-plan whole items accepted by this batch ON THE INSTALLED BUILD: 0; on any build: 0.** This is the contribution of these three cases, not a recount of the other 37 checks.
   1. **D15 / UX-EDIT-02, gap plan section 2 item 15 within section 3 item 7:** not accepted on any build. R34sn covers only the copy-number part under an altered setting; R34so covers a failing ROTATE route.
   2. **D07 / UX-SRC-05, gap plan section 2 item 7:** not accepted by R36 on any build. D07 requires DP and CDRG on a blank drawing with no pipes. R36 runs CDFW on DRV1_B1. It is a neighbour, not coverage of D07.
7. **Bugs that may be written "FIXED (Claude-accepted, Civil 3.0.79, 26 Oct 2026)": none.** No such wording is justified. Never close or delete entries (D6).
   1. **BUG-665:** missing ROTATE label/cover text on 3.0.78, with other bug routes untested here; 3.0.79 unknown. Suggested evidence wording, status unchanged: "R34so current hash 332F7F1E2BE2, b4c1-s4 and b4c2-s4 on Civil 3.0.78: ROTATE Copy about a pivot 5 m east creates one pit but zero PIT LABEL blocks and zero cover texts, despite '1 pit copied and numbered as new.' No 3.0.79 result yet."
   2. **BUG-132:** CDFW open-space portion only. CDSOURCE, excluded-pipe diagnostics and retagging checks remain uncovered.
   3. **BUG-102:** no early refusal on this fixture's CDFW route; CDSOURCE and the original 12-pit/50-pipe failure conditions are not reproduced. The case itself says this fixture has 11 pits/49 pipes, but does not assert those quantities.
   4. **BUG-147:** correctly removed from R36's current claim. Endpoint ownership/readback evidence is absent. Its referenced regression entry also asks for CDSOURCE, excluded-pipe logs and the result after CDTAG; none is checked here.

## How I applied the four conditions

1. **Nothing seen on screen:** these assertions read object counts, attributes, command text and file hashes. Label position, legibility and preview appearance remain separate Codex looks; none was performed.
2. **Two passes on one build:** R34sn and R36 have pairs on 3.0.78, but no pair on installed 3.0.79. R34sn also has an older pair on 3.0.75. R34so has no passing pair.
3. **Red before green:** the qualifying variant evidence and its limits are in ANSWER FIRST item 5. Passing the cancellation red does not prove detection of every source ownership fault.
4. **Whole card or bug:** compared line by line below. Partial cases stay PARTIAL; I do not issue a whole-case review file for their useful subchecks.

## The cases

1. **R34sn: COPY and SCALE Copy numbers, tick ON.** Verdict: **PARTIAL (part only: each copied pit's label reads a P number other than P3).** Hash `24A6310A205C`. Full SHA-256: `24A6310A205CC86068A932882CA0DA26B22ED2F5B8CCA2FD3B225E788E24A414`.
   1. **Asks met:** case lines 26-28 and 44-46 read both label attributes; lines 49-50 assert a P number other than P3. Reports read P8 and P12. The file stays unchanged. B3FIX's requested plain COPY case R34a is still absent from the case directory.
   2. **Against D15:** card lines 463-469 require no setting change; case line 8 changes the grip/rotate/scale switch. Card assertion 1 (line 477), the complete Check levels sentence, is not asserted. Assertion 2 (line 478) is only half checked: the original still being P3 and a free number are not established. Assertion 3 (line 479), one U restoring the original objects, has no steps. BUG-665 lines 2668-2672 also cover grip copies, pipes, separate records, schedule ownership and destructive follow-up behaviour; none is established by reading two labels.
   3. **Exact lines for the missing D15 route:** make the separate R34a requested by B3FIX, `FIXTURE DRV1_B1`, `SLOT fresh`, with no SETTING line. Use the COPY portion only, then the following steps and assertions. Verify original label handle 109E08 belongs to P3 before relying on it; it is the label identified in B3B's R12 review.

      ```text
      STEPS
        ms-count -> $c0
        ent-read 109E08 -> $orig0
        pick-first "109D56"
        type "_.COPY{NL}0,0{NL}0,-5000{NL}{NL}" -Force -> $cp
        wait
        sleep 4
        ms-new $c0 -> $new_cp
        select $new_cp "name~^PIT LABEL" -> $cp_label
        field $cp_label handle -> $hcp
        ent-read {$hcp} -> $cpl
        ent-read 109E08 -> $orig1
        type "U" -Force -> $u
        wait
        ms-count -> $c2
        ent-read 109E08 -> $orig2
      ASSERT
        contains $cp "1 pit copied and numbered as new. Check levels: they came across from the originals (the Inspector shows which ones to confirm)."
        count $cp_label = 1
        matches $cpl "text.:.P(?!3.,)[0-9]+.,.insertion"
        matches $orig0 "text.:.P3.,.insertion"
        matches $orig1 "text.:.P3.,.insertion"
        matches $orig2 "text.:.P3.,.insertion"
        equals $c2 $c0
      ```

   4. **Limits of those lines:** they reproduce the earlier review's requested count-based U check. D15 literally asks for the original handle set to return and a free number, so also compare baseline/after-U handle sets and check the copied number against existing pit numbers. Do not silently call equal counts equal sets: losing one object and gaining another keeps the count unchanged. For this 1034-object fixture, add `ms-new 0 -> $h0a`, `ms-new 500 -> $h0b`, `ms-new 1000 -> $h0c` before COPY, then `field $h0a handle -All -> $ha0`, `field $h0b handle -All -> $hb0`, `field $h0c handle -All -> $hc0`. After U repeat with suffix 2 and ASSERT `equals $ha2 $ha0`, `equals $hb2 $hb0`, `equals $hc2 $hc0`, plus `number $c0 = 1034`. These three reads respect the 500-object cap and detect changed handles; order differences may fail conservatively. A general sorted-set comparison would be preferable for varying fixtures. Keep a COPY red, then add a SCALE-specific red if R34sn's separate SCALE claim is retained.
   5. **Runs and look:** two new passing sessions on installed 3.0.79 are needed after the new text is final. Its number reads need no picture; label placement and overlapping text still require a Codex look. No review file.
2. **R34so: ROTATE Copy about a pivot 5 m east, tick ON (BUG-665).** Verdict: **FAIL = real fault**, demonstrated on Civil 3.0.75 and 3.0.78; **3.0.79 untested**. Hash `332F7F1E2BE2`. Full SHA-256: `332F7F1E2BE2A285CF81FD106430974A2799F8A0D7DCC7AC48D40537B6FED317`.
   1. **Asks met:** lines 21-30 rotate the copy away from the original, collect the new pit, label and cover text separately; lines 33-36 check the message and all three counts. In both 3.0.78 sessions the message passes, pit count is 1, label count is 0 and cover-text count is 0. These are failed assertions, not tool errors. The recorded new block is at approximately 58777.675,-30569.874 mm.
   2. **Against the bug:** BUG-665 line 2672 requires own labels and record. Case lines 35-36 directly catch missing labels. It does not read the pit number or record, test the schedule, delete the copy, exercise pipe copies or grip Ctrl-drag. D15's ordinary COPY, unchanged original and U are also absent. Even a future green result covers this ROTATE portion only.
   3. **Exact action for the desk:** no replacement assertion can fix CE. Keep `count $ro_label = 1` and `count $ro_cover = 1` at lines 35-36 and retain `EXPECT-FAIL BUG-665` while this is the known failing route. Do not change either expected count to zero. After a CE fix, obtain two passing sessions on the then-installed build and retain these recorded genuine failures as before-fix evidence.
   4. **Optional location check:** after selecting `$ro_pit`, add `field $ro_pit x -> $rx` and `field $ro_pit y -> $ry`; ASSERT `number $rx = 58777.7 +- 1` and `number $ry = -30569.9 +- 1`. The pivot is 5 m from the original; a 90-degree turn moves the copy about 7.071 m from the original, not 5 m. This is geometry, not an engineering design choice.
   5. **Codex look:** future label position, cover-text placement and rotated preview need looking at. The current absence is already demonstrated by counts. No review file; two passing sessions on 3.0.79 are still owed for this route, but they would not alone accept all of BUG-665.
3. **R36: CDFW with four AGI blocks.** Verdict: **PARTIAL (part only: CDFW in open space, Undo by object count, and Esc placing nothing).** Hash `4670716EF0F9`. Full SHA-256: `4670716EF0F978ECC9FF67F85A3E0D113B9E5C0F80D0A4B2C81708C8EC990187`.
   1. **Asks met:** B3's duplicate-tag sentence is asserted at line 37; B3FIX's request to remove BUG-147 is met by current lines 4 and 9. The old reviewer wording at line 12 still mentions BUG-147; it is stale builder text and cannot satisfy the independent gate.
   2. **Against BUG-132 and BUG-102:** line 20 drives CDFW only. Lines 36-42 check successful placement, four AGI blocks mentioned, no refusal/rollback words, one floor-waste block and one FW-prefixed text. Lines 43-45 check count 1034 after U and after Esc, plus cancellation text. These correspond to the CDFW open-space portions of BUG_CARPARK lines 9364 and 9504-9506. CDSOURCE is explicitly undriven at case line 16. BUG-132's referenced regression entry additionally asks for excluded-pipe diagnostics, retagging a duplicate and trying again; these are absent.
   3. **The source problem is not fully recreated:** the report says `Nothing nearby`. The command-line AGI sentence proves CE noticed duplicates; it does not prove a pipe with duplicate endpoint ownership was excluded or correctly kept strict. BUG-102's 12-pit/50-pipe situation is not this stated 11-pit/49-pipe fixture. Neither count is checked by this case.
   4. **Exact claim correction:** replace the current line 9 with `PROVES_BUGS BUG-132 and BUG-102: CDFW open-space portion only on DRV1_B1; CDSOURCE, original failure conditions, endpoint ownership, excluded-pipe diagnostics and retagging are not proved`. This documents the actual scope; it does not make a whole bug accepted.
   5. **Exact assertion improvements:** after `$fwb` and `$fwt` are selected, add `field $fwb layer -> $fw_layer`, `field $fwt text -> $fw_text` and `field $fwt layer -> $text_layer`; ASSERT `equals $fw_layer "DOWNPIPES"`, `equals $fw_text "FW"` and `equals $text_layer "GUIDELINES"`. The present `text~^FW` accepts FW followed by other text; the promised layer is only recorded. After U add `contains $u1 "CDFW"` to turn the recorded undo name into a check. Count equality still does not prove stored levels or exact object identity.
   6. **Missing route, without invented prompts:** a separate CDSOURCE case must first record its real prompts, starting with `type "CDSOURCE" -Force -TimeoutSec 90 -> $source_start`, then `record $source_start "FULL CDSOURCE prompts"`. That is a discovery step, not a passing case. Complete its placement answers from that evidence, then assert placement, exact created objects and absence of the bug's refusal/rollback sentences. No verified CDSOURCE prompt sequence is present in this case or the reports read; I cannot honestly supply its unknown answers. For BUG-132 also pin the excluded-pipe diagnostic and the after-CDTAG result from an actual reproduction. Do not substitute a floor waste at an inspection opening without Tim's placement rule.
   7. **Runs and look:** the two 3.0.78 sessions support the stated portion only. Two sessions on 3.0.79 are needed after edits, with the true cancellation red retained and any new checks given appropriate failing variants. The visible symbol and text placement require a Codex look; stored pit invert preservation (BUG-650) is expressly not claimed. No review file.

## Current-hash ledger rows and counted pairs

1. **Build keys:** A = `civil 3.0.75+2c805a39 / struc 1.0.123+4af3f37d / mgr 1.1.75+2c805a39`; B = `civil 3.0.77+0d885094 / struc 1.0.124+3a3caac5 / mgr 1.1.77+0d885094`; C = `civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09`. None equals the installed build key.
2. **R34sn, pair A:** PASS `RUN-20261025-1258-C3.0.75-b3v2-s1`, at 25 Oct 13:03:05; PASS `RUN-20261025-1434-C3.0.75-b3v3-s2`, at 25 Oct 14:39:04. Both current hash, build A.
3. **R34sn, pair C:** PASS `RUN-20261026-0542-C3.0.78-b4c1-s4`, at 26 Oct 07:06:05; PASS `RUN-20261026-0706-C3.0.78-b4c2-s4`, at 26 Oct 08:05:50. Both current hash, build C.
4. **R34so, build A:** FAIL `RUN-20261025-1434-C3.0.75-b3v3-s2`, at 25 Oct 14:39:04; FAIL `RUN-20261025-1447-C3.0.75-b3v4-s1`, at 25 Oct 14:49:15. Both current hash, both from checks.
5. **R34so, build C:** FAIL `RUN-20261026-0542-C3.0.78-b4c1-s4`, at 26 Oct 07:06:05; FAIL `RUN-20261026-0706-C3.0.78-b4c2-s4`, at 26 Oct 08:05:50. Both current hash, both from checks; these are standing failures on C.
6. **R36, build B:** PASS `RUN-20261026-0345-C3.0.77-b4a1-s1`, at 26 Oct 03:56:12. One session only, not a pair.
7. **R36, pair C:** PASS `RUN-20261026-0542-C3.0.78-b4c1-s3`, at 26 Oct 07:06:05; PASS `RUN-20261026-0706-C3.0.78-b4c2-s3`, at 26 Oct 08:05:50. Both current hash. Do not combine the 3.0.77 pass with one 3.0.78 pass.
8. **Red session IDs:** the full b4c1-s3, b4c2-s3, b4c1-s4 and b4c2-s4 IDs above also identify the variants in ANSWER FIRST item 5. Their ledger `at` times are respectively 07:06:05 and 08:05:50, build C. Older b3v3/b3v4 COPY reds were also read; current acceptance is not inferred from their age.
9. **Excluded main-case rows:** R34sn has two older-text FAIL rows (`CF2EC128A977`); R34so two older-text FAIL rows (`A42D9139F980`); R36 two older-text FAIL rows (`0664D38347B1`) and four older-text PASS rows (two `DFE8FFF4848F`, two `BEA2DFF216B9`). None contributes to today's pass/fail totals. Current variant hashes still match their older red rows, which is a separate fact.

## Things the desk should know first (RULES 6.2)

1. **The brief's installed-build lead is stale:** Civil 3.0.79 / Manager 1.1.79 replaced 3.0.78 this afternoon. Calling these morning passes current-build acceptance would be wrong.
2. **The 07:10 row counts are stale:** R34sn now has four current-hash passes, R34so four current-hash failures, R36 three current-hash passes. Each gained the b4c2 result at 08:05:50. This adds a 3.0.78 pair for R34sn and R36, not 3.0.79 evidence.
3. **B3FIX's statement that R36 still claims BUG-147 is no longer true of the current claim lines.** The correction changed the hash, so its old b3x1/b3x2 pass pair cannot be recycled. The stale builder review sentence remains a wording issue.
4. **B3FIX's duplicate SETTING note does not describe today's R34sn:** there is one SETTING line, line 8. Its two label checks only exclude P3; they do not assert that the two copies differ from each other or from all other pits.
5. **The pivot distance and copy displacement differ:** a pivot 5 m east gives about 7.071 m displacement after 90 degrees. R34so's EXPECTED wording that the copy lands 5 m away is inaccurate; its command and observed coordinates are consistent.
6. **No pure run shortage is being mistaken for complete coverage.** Two more passes of the unchanged partial cases cannot accept D15, D07 or the whole source bugs. Conversely, R34so's older genuine fault is not asserted as a new observation on 3.0.79.

## For the runner owner (not case faults, listed so they are not lost)

1. **Bind shared setup to acceptance where one is used.** The gate still hashes only the case file. This does not affect these three cases, which have no setup.
2. **Literal object-set restoration needs an object-set read.** A count can miss replacement of one object with another. D15's card asks for H2 = H0; preserve that distinction when implementing the new route.
3. **Independent review and current-build evidence are separate.** The gate's reviewer check is textual, not proof of independence, and its verdict line does not itself compare builds. This report issues no acceptance marker.

## What I read

1. **Authority and method:** `C:\TimOS\RULES.md` completely, `C:\TimOS\ROUTER.md`, the 24 Oct acceptance decision, both B3FIX and B3B model reviews completely, `Get-CaseIndependentReview`, and the R16 review-file example. CE_PLAN start/map material established the release-review context; this brief governs the read-only scope.
2. **Prior asks:** searched every `C:\CE_PLAN\areas\RUNNER_CASE_REVIEW_*.md` for R34sn, R34so and R36. Relevant hits were in B3 and B3FIX; read their case sections and cross-references. B3B supplied the requested method and count shape, not a later verdict for these cases.
3. **Claims:** all three current case files and all three matching variant files, D15 and D07 in `DAILY_TOOLS_TEST_CASES_2026-10-23.md`, gap plan section 2 and section 3 item 7, BUG-665/147/132/102 in BUG_CARPARK, and the BUG-147/132 referenced regression entries. These cases claim no C-number card requiring a further C-card comparison.
4. **Evidence:** ledger.json row by row for the assigned IDs and variants; JSON assertions, session intervals and relevant Markdown check sections for b3v2, b3v3, b3v4, b4a1, b4c1 and b4c2. Each full run name is identified above; files are in `C:\CE_PLAN\areas\runner-reports\<run>.json` and `.md`.
5. **Installed state:** all nine suite DLL ProductVersions, three live Contents creation times, preserved older Contents creation times, `C:\ce_rc_scratch\install_c65_desk.log`, c67, c68, c69 and s44 installation logs, plus corresponding chain log/desk event evidence. Read installer scripts only to locate their logs; executed none.
6. **Delivery:** existing git status and hook configuration; `C:\TimOS\skills\leak-scan\SKILL.md`. Only this report is staged and committed by name. Other jobs' uncommitted files are left alone.

## What I did NOT check

1. **No execution:** no AutoCAD, runner, case, lock, settings guard, build, installation, test or sub-agent. This is an independent evidence review, not an independent AutoCAD pass.
2. **No visual acceptance:** no window, picture, preview, label position or plotted drawing inspected. No engineering values or design choices approved.
3. **No whole-suite recount:** other cases, reviews and accepted daily-tool totals are not revalidated. No bug entry is changed or marked fixed.
4. **No independent live settings verification:** setting behaviour and restoration evidence are from the recorded runs; no settings file was changed or guard invoked. No original drawing was opened.
5. **No source fix audit:** installed implementation was not inspected. The missing ROTATE text is observed in saved checks; its internal cause remains unproved here. Stored source/pit records and the original BUG-102 fixture were not inspected.

## Files written

1. **Report only:** `C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr10.md`. No `.review.txt` is warranted, created, replaced or deleted. No variant review file is touched.

## Summary

Zero cases are ready for whole-feature acceptance. R34sn and R36 remain partial; R34so records a real missing-label and missing-cover-text fault on 3.0.78. Civil 3.0.79 is now installed and has no recorded result for these cases. Two passing 3.0.78 sessions exist for each partial case, but cannot cover missing routes or count on 3.0.79. No whole daily-tool item or bug is newly accepted. Only this report is written; exact next checks and limits are recorded above.
