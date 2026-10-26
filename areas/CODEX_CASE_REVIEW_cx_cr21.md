# Runner case review, cx_cr21: R33, R12, R09, R36 and R36e (Codex independent review, Mon 26 Oct 2026)

Written Mon 26 Oct 2026, about 18:03 Melbourne (AEDT, UTC+11), by Codex (GPT-6). I read the rules, acceptance decision, both model reviews in full, B4 builder report in full, earlier case sections, current cases and variants, cards and bugs, installed DLL versions, installation boundaries and recorded results. This is a read-only review: no AutoCAD, runner, case, build, installation, test, lock or settings guard was run. Only this report is written; no case qualifies for a review file and no bug status is changed.

## FOR TIM

1. **0 of these 5 cases is ready.** Two cover part only, MOVE needs stronger checks, and the downpipe and inspection-opening cases record real faults on the previous build.
2. **Civil 3.0.79 is now installed.** All five have no recorded run on it. Earlier passes on 3.0.78 cannot be described as acceptance on today's installed build.
3. **MOVE still has a hole.** Four invert texts could stay behind when the pit moves 2 m and the case would pass. Their return after Undo is checked, but their movement is only recorded.
4. **No bug may be newly written fixed on the installed build.** On 3.0.78, a downpipe double-click still opens AutoCAD's attribute editor; placing a floor waste at an inspection opening gives the false "changed while you picked" refusal.
5. **The locked-layer checks prove useful parts.** PIT refuses before placing anything, but COPY still says there is no number label even though P8 exists. That wrong message remains outside the passing checks.
6. **One design question remains for Tim's existing decision queue.** Whether a floor waste may be placed at an inspection opening is not recorded. The case cannot choose that answer for you; the false refusal is a fault either way.

---

## ANSWER FIRST

1. **Counts: one main verdict per case, five cases.**
   1. **CLAUDE-ACCEPTED-READY: 0.**
   2. **NEEDS BROKEN VARIANT: 0** as a main verdict.
   3. **NEEDS STRONGER ASSERTION: 1**, R12.
   4. **PARTIAL (part only): 2**, R33's two PIT refusals/COPY behaviour/schedule-message branch, and R36's CDFW open-space placement/Undo count/Esc branch.
   5. **NEEDS CODEX LOOK: 0** as a main verdict; R09's whole C04 card additionally requires a look.
   6. **FAIL = real fault: 2**, R09 on 3.0.78 and R36e on 3.0.77/78. Neither is demonstrated failing on 3.0.79.
   7. **NEEDS RUNS: 0** as a main verdict. All five additionally need two passing sessions on installed Civil 3.0.79 after their substantive issues are addressed. More identical runs cannot repair incomplete coverage.

2. **Installed builds read directly, not taken from the brief.** Under C:\Users\TimothyBrand\AppData\Roaming\Autodesk\ApplicationPlugins, I read VersionInfo.ProductVersion from each product's main DLL in Legacy, Modern and Net8, nine DLLs in total.
   1. **Civil, all three:** 3.0.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa.
   2. **Manager, all three:** 1.1.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa.
   3. **Structural, all three:** 1.0.124+3a3caac5db7687f1b5d1a6e09571976c52b2b05a.
   4. **Contents creation times:** Civil 26 Oct 16:57:58.752; Manager 26 Oct 16:57:59.827; Structural 25 Oct 17:41:13.576.
   5. **Installed ledger key to require:** civil 3.0.79+d3f9c5df / struc 1.0.124+3a3caac5 / mgr 1.1.79+d3f9c5df. No relevant current-hash row has that key. The recorded .77/.78 keys match their preserved DLL versions, not today's DLLs.

3. **Installation boundaries checked from preserved Contents directories and their Modern DLL versions.** Folder names alone were not treated as evidence.
   1. **3.0.75 / 1.1.75, 2c805a39:** Civil 25 Oct 03:33:02.025; Manager 03:33:02.890. Replaced by .77 at the times below.
   2. **3.0.77 / 1.1.77, 0d885094:** Civil 25 Oct 20:42:01.593; Manager 20:42:02.444. Replaced by .78 on 26 Oct 05:41:30.578 / 05:41:31.142.
   3. **3.0.78 / 1.1.78, d8840a09:** Civil 26 Oct 05:41:30.578; Manager 05:41:31.142. Replaced by .79 at 16:57:58.752 / 16:57:59.827.
   4. **Boundary result:** every row used below, and its entire run, falls after installation and before replacement. None of these runs straddles an installation. Structural .124 was already installed throughout all five runs.

4. **Ledger snapshot: 602 rows, read as one JSON array, checked again at 18:03.** I computed each case and variant SHA-256 with Get-FileHash and matched rows individually. Full hashes are below.
   1. **R33, R12 and R36:** each has three current-hash PASS rows, zero current-hash FAIL rows: one .77 row and two .78 rows. The .77 row is not added to a .78 row to manufacture a pair.
   2. **R09:** zero current-hash PASS, two current-hash FAIL rows on .78, both from checks. Nine older-text rows are excluded.
   3. **R36e:** zero current-hash PASS, three current-hash FAIL rows: one .77 and two .78, all from checks. Three older-text rows are excluded.
   4. **Other excluded parent rows:** R33 seven; R12 fifteen; R36 six. They carry older hashes and contribute nothing to today's text.
   5. **No standing failure is explained away:** the current-text R09/R36e failures have no later row showing a run fault. A session marked PASS for clean completion does not turn its EXPECT-FAIL case into a passing case.
   6. **Setup:** none of these five cases or their eight variants declares SETUP; relevant report setup fields are empty. There is no applicable setup file to hash. Inline preparation is included in each case hash.

5. **Exact sessions and row times.** All dates here are 26 Oct 2026, Melbourne.
   1. **The .77 single row:** run RUN-20261026-0345-C3.0.77-b4a1, session RUN-20261026-0345-C3.0.77-b4a1-s1, row at 03:56:12. Run 03:45:02-03:56:12; session 03:45:04-03:56:12. R33/R12/R36 PASS; R36e FAIL. Build key: civil 3.0.77+0d885094 / struc 1.0.124+3a3caac5 / mgr 1.1.77+0d885094.
   2. **The .78 pair, first session:** run RUN-20261026-0542-C3.0.78-b4c1, session RUN-20261026-0542-C3.0.78-b4c1-s3, row at 07:06:05. Run 05:42:18-07:06:05; session 06:41:39-07:02:17.
   3. **The .78 pair, second session:** run RUN-20261026-0706-C3.0.78-b4c2, session RUN-20261026-0706-C3.0.78-b4c2-s3, row at 08:05:50. Run 07:06:38-08:05:50; session 07:30:55-07:53:32.
   4. **What that pair proves:** R33/R12/R36 PASS in both sessions, R36e FAIL in both. Both use civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09. These are matching-text pairs for the stated portions, not whole-feature acceptance.
   5. **R09 first failure:** RUN-20261026-1418-C3.0.78-b5r1b-s2, row at 15:03:37; session 14:26:32-14:34:35; run 14:18:59-15:03:37. OFF variant: RUN-20261026-1418-C3.0.78-b5r1b-s1, session 14:19:01-14:26:32, same row time.
   6. **R09 second failure:** RUN-20261026-1552-C3.0.78-b5r2a-s2, row at 16:07:46; session 16:00:15-16:07:46; run 15:52:42-16:07:46. OFF variant: RUN-20261026-1552-C3.0.78-b5r2a-s1, session 15:52:44-16:00:15. Both runs use the .78 key above. These are failures, never a passing pair.

6. **Reds, checked against current variant text and JSON/Markdown reports.** Cited rows have the correct variant_of, FAIL and from_check=true. None is a crash, timeout or E_FAIL.
   1. **R33_BROKEN:** b4a1-s1 and b4c1/b4c2-s3 fail both checks when the lock is omitted: no refusal and count 1035 rather than 1034. True red. R33_NUM_BROKEN in those sessions expects P3 while the copy reads P8: weaker flipped red.
   2. **R12_NOU_BROKEN:** those same three sessions fail all eight return checks: 1990.3, 1988, 2000, 2000, 1899.4, 1925.7, 1999.1 and 1894.2 mm instead of 0 +/- 0.5 mm. True omission-of-Undo red.
   3. **R12_WIN_BROKEN:** those same sessions fail only the window equality assertion because About CE Suite was deliberately opened. True red for the headline no-window check. R12_BROKEN is a supplementary flipped expectation of the old pit Y; its four historical matching FAIL rows are not needed or promoted into current-build evidence here.
   4. **R09_OFF_BROKEN:** both b5 sessions above fail the scheduled-CDEDIT log assertion, reading 97 new lines and finding none. R09 itself passes it in each corresponding ON session. True discriminating red for redirection scheduling; it does not make the positive window checks pass.
   5. **R36_BROKEN:** b4a1 and b4c1/b4c2 fail placement text and block count after deliberate Esc, zero blocks rather than one. True red. R36_AGI_BROKEN in those sessions expects five AGI blocks when CE reports four: flipped red.
   6. **R36e:** no variant file exists. Its own current-text failures are historical before-fix evidence, not a broken twin. Editing its faulty diagnostic assertion changes the hash, so those rows cannot silently qualify the revised text.

7. **Whole daily-tool cards and gap-plan checks accepted by this brief: 0 ON THE INSTALLED BUILD; 0 on any build.** This is this brief's contribution, not a recount of all other cases.
   1. **Quick MOVE, C41 / gap plan section 3 item 7:** not counted; four movement checks and the card's exact geometry/placement contract remain missing.
   2. **D15 / UX-EDIT-02 COPY:** not counted; R33 locks a layer and does not prove the original still reads P3, the full Check levels requirement or complete handle-set restoration.
   3. **D07 / UX-SRC-05:** not counted; the whole card requires DP and CDRG on a blank drawing with no pipes, plus raingarden Undo. R36/R36e run CDFW on a populated drawing. R09's preparatory DP placement does not supply the missing card.
   4. **C04:** not a whole accepted card; the initial editor is wrong and the required usable window capture is absent. No other whole item is added.

8. **Bugs that may be written "FIXED (Claude-accepted, Civil 3.0.79+d3f9c5df, 26 Oct 2026)": none.** No such status wording is justified here; no entry is closed or deleted (D6).
   1. **BUG-460:** both specified PIT refusal paths have complete deterministic evidence on .78, but no .79 passes. That useful historical finding is preserved; composite R33 remains PARTIAL.
   2. **BUG-672:** COPY behaviour only; the saved message still falsely says no label. **BUG-262:** only the named P3 schedule-cell branch; recovery and other branches are not fully asserted.
   3. **BUG-859:** two current-text real failures on .78; no .79 result; other symbol parts and changed-tag OK are absent.
   4. **BUG-132 and BUG-102:** CDFW open-space portion only. CDSOURCE, original failure conditions and referenced diagnostics/retagging checks are missing.
   5. **BUG-147:** correctly removed from R36's claim. R36e is BUG-1223, not proof of the duplicate-tag endpoint route.
   6. **BUG-1223:** false refusal reproduced on .77/.78; no .79 result; placement intent is Tim's decision.
   7. **Suggested evidence wording only:** "Reviewed 26 Oct 2026, cx_cr21: R33 proves the two BUG-460 refusals on Civil 3.0.78; BUG-672 message and BUG-262 remainder stay unproved. R09 reproduces BUG-859 twice on current case hash 8763A665A9C3 on .78; R36e reproduces BUG-1223 on .77/.78. No result for these cases on installed .79." This is not a FIXED declaration and was not applied to the carpark.

## How I applied the four conditions

1. **Nothing seen on screen:** values, counts, command replies and window presence support bounded deterministic findings. Window appearance, symbol/label positions and clipping remain Codex looks.
2. **Two separate sessions on one build:** three cases have .78 pairs; none has a .79 pair. Current-hash failures remain failures.
3. **Red before green:** relevant action variants fail intended checks; flipped expectations are identified separately. R09's ON/OFF log comparison now works.
4. **Whole coverage:** comparisons below leave no READY case. Engineering permission to place a floor waste at an inspection opening is not inferred from a case's expected sentence.

## The cases

1. **R33: locked pit text layers (BUG-460, BUG-672 behaviour half, BUG-262 schedule-message branch).** Verdict: **PARTIAL (part only: both PIT refusals, COPY number/omitted cover text, Undo count and named P3 schedule message)** on Civil .78. Hash **DDEAA7503ACD**. No review file.
   1. **Asks met:** B3FIX's correction is at case line 9: BUG-672 is explicitly behaviour half only and recognises the wrong "no label" sentence. Lines 45-46/86-88 read P8 and record the full reply. Latest cx_cr08 requests for R33m and schedule recovery remain unmet; no R33m file was found.
   2. **BUG-460, carpark line 9633:** case lines 21-30/67-70 cover locked STORMWATER PIT LABEL; lines 33/53-62/92-93 cover locked 25TEXT. Both .78 passes read count 1034 unchanged and the precise refusal. This covers the specified two paths; it does not assert all possible internal attribute-layer combinations.
   3. **BUG-672, carpark lines 2582-2592:** lines 35-49/71-86 prove one pit, one PIT LABEL reading P8, no CL text and two added objects, then count 1034 after U. The full reply says "no label or cover text". Expected behaviour requires copying open-layer objects AND correctly reporting the skipped one; the latter is false.
   4. **BUG-262, carpark lines 5095-5099:** line 74 pins P3, lid and remarks, and 25TEXT. It omits the recovery assertion and handle-only, foreign copied-cell and locked invert-text branches. A complete BUG-262 claim cannot follow.
   5. **Exact next lines:** in proposed R33m COPY-only case, keep copy-object/P8 checks, add header 'EXPECT-FAIL BUG-672', then ASSERT 'not-contains $cp1 "no label"', 'contains $cp1 "layer 25TEXT is locked"', and 'contains $cp1 "Undo (U), unlock layer 25TEXT, then copy again."'. The saved reply would fail the first; an actual future red must still be recorded.
   6. **Exact schedule recovery line:** after line 74 add 'contains $cp1 "The drawn pit schedule still shows the old values. Unlock the layer or finish the reference edit, then run PITEDIT on the pit or Update existing schedule in PITSCHEDULE."'. This strengthens the observed branch only. Keep other branches explicitly partial or give them separate cases.
   7. **Small points and runs:** line 15 leaves the already established wording fault to the desk; line 13 describes the faulty sentence as expected. Correct these at the next substantive edit. Two .79 PASS sessions are required on the resulting hash. An isolated BUG-460 case could earn whole-bug acceptance separately; this review does not create it.
   8. **Codex look:** label/circle appearance and position, and New Pit layout, were not judged. Object counts support refusal, not visual acceptance.

2. **R12: quick MOVE (C41, W1-02, gap-plan quick MOVE).** Verdict: **NEEDS STRONGER ASSERTION.** Hash **334263931AF1**. No review file.
   1. **B3B asks met:** lines 79-86 read four missing Undo positions; 89-92 assert zero within 0.5 mm. Label/cover move/return checks remain at 94-99. Both new reds work. Latest cx_cr03 movement/precision requests remain absent.
   2. **C41 comparison, card lines 904-910:** case 17-86 drives MOVE/U and reads positions; 110/113 compares windows; 89-92/122-123 checks all six IL returns. Assertion 1's documented per-handle placement rules are not supplied. Four movements at 93/102-104 remain record-only.
   3. **Exact hole:** if 116A0E stays still, it remains inside both 4000 mm searches, recorded movement is zero, and its after-U zero check passes. The same applies to 1155B6, 116A3C and 116BE4. A passing .78 record does not make the check catch that regression.
   4. **Exact next ASSERT lines:** 'number $mv_1155 = 2000 +- 150'; 'number $mv_116a3c = 2000 +- 150'; 'number $mv_116be4 = 2000 +- 150'; 'number $mv_116a0e = 2000 +- 150'. Saved values are 1899.4, 1925.7, 1999.1 and 1894.2 mm. These extend the existing regression tolerance; they do not approve direction/clearance. Documented placement rules still need supplying.
   5. **Red:** a separate variant should omit MOVE, collect the same four variables at unchanged positions and retain those assertions. Zero movement must fail. Keep NOU_BROKEN and WIN_BROKEN.
   6. **Precision:** C41 asks 0.001 drawing units for displacement/restoration; 'dist' rounds to 0.1 mm and allows 0.5 mm. Pit regexes match coordinate prefixes only. B2FIX's practical allowance does not prove the literal card tolerance.
   7. **Exact stronger read pattern:** before MOVE add 'field $lab0 x -> $lab_old_x' and 'field $lab0 y -> $lab_old_y'; after U add 'field $lab2 x -> $lab_back_x' and 'field $lab2 y -> $lab_back_y'; ASSERT 'number $lab_back_x = $lab_old_x +- 0.001' and 'number $lab_back_y = $lab_old_y +- 0.001'. Repeat with distinct variables for cover and all six IL handles, reading OLD values rather than rounded constants. Obtain equivalent unrounded pit coordinates for its 0,2000 displacement and restoration. These are proposed reads, not executed checks.
   8. **Claim, runs and look:** fix line 11's stale statement that only the pit is read. Current text now has two .78 passes, correcting cx_cr03's earlier one-pass snapshot, but zero .79 passes. After editing, two new .79 sessions and matching reds are required. Pipe ends remain unread; label appearance/overlap needs a Codex look.

3. **R09: double-click a new downpipe (BUG-859, C04).** Verdict: **FAIL = real fault**, twice on .78; installed .79 result unknown. Hash **8763A665A9C3**. No review file.
   1. **Asks met:** B3FIX's scheduled-CDEDIT check uses civilx at line 55; delayed snapshot/dump/Cancel is at 48-52/63-64. cx_cr02's settings are pinned at 13-14 and Cancel/OK existence at 59-60. Line 22 honestly excludes other symbol parts and changed-tag OK.
   2. **Evidence now present:** both current-text runs pass check 2, scheduling at 14:32:31.116 and 16:05:51.791. Checks 3-8 fail: opened is Enhanced Attribute Editor, Edit source is absent, its controls cannot be read and Cancel is not verified closed. Calibration succeeded. This is not the earlier wrong-log failure.
   3. **OFF red:** both variants fail check 2 after 97 new lines, while ON passes. Direct structured-log reads show OFF at 14:24:36.498 and 15:58:33.810. ON later logs starting CDEDIT at 14:32:56.226 and 16:06:14.727, about 25.1 and 22.9 seconds after scheduling.
   4. **Evidence limit:** saved delayed dumps are empty; delayed window lists show only AutoCAD. A log saying CDEDIT started is not proof a usable CE window was seen. I do not assert AutoCAD's internal cause or successful second-window display.
   5. **Card/bug comparison:** C04 lines 107-117 require settings, circle target, editor identity, DP1, Cancel/OK and usable capture. Case 24-46/54-61 attempts the deterministic route but fails; no capture exists. BUG-859 line 11649 also requires anywhere on the symbol and OK writing a changed tag; neither is driven.
   6. **Exact scope line:** 'PLAN_ITEM BUG-859 outer-circle opening and Cancel only; C04 deterministic checks attempted; whole BUG-859 and C04 look not proved'. Keep 'contains $opened "Edit source"' and 'not-contains $opened "Enhanced Attribute Editor"'; do not weaken the real failure.
   7. **Exact look additions after a successful first dump:** before Cancel add 'capture $es R09_edit_source -> $pic'; ASSERT 'picture-ok $pic'; use 'KIND look' and 'RIGHT_LOOKS_LIKE Edit source shows DP1; Tag, OK and Cancel are readable and not clipped or overlapped.'. Resolve the Tag control from the actual successful dump before replacing 'control $es "Tag" value "DP1"'; its name remains unknown.
   8. **Other parts:** current ent-part always selects the largest visible circle; its second argument is ignored. Writing red-centre or angled-text today would still select the circle. A verified component selector is needed before extra clicks, plus changed-tag OK with block read-back. Do not invent supported runner lines for missing capabilities.
   9. **Runs/look:** after CE fix and case completion, two .79 PASS sessions and matching OFF red are required. Whole C04 also needs a Codex look. Old E08D471171A9 review file is stale and untouched.

4. **R36: floor waste with four AGI blocks (BUG-132/BUG-102 CDFW portion).** Verdict: **PARTIAL (part only: CDFW in open space, Undo by count, Esc placing nothing)** on .78. Hash **4670716EF0F9**. No review file.
   1. **Asks met:** line 37 asserts duplicate-tag wording; lines 4/9 remove BUG-147 from the claim. Two .78 passes exist. Latest cx_cr10 layer/text/Undo and scope additions remain absent.
   2. **BUG-132 comparison:** carpark 9364-9368 and referenced REGRESSION_LOG require CDFW and CDSOURCE, excluded-pipe diagnostics and retagging/retry behaviour. Case line 20 runs CDFW only. Lines 36-45 prove placement, no refusal/rollback, one block/text, Undo count and Esc count. Full reply says Nothing nearby.
   3. **BUG-102, 9504-9510:** original 12-pit/50-pipe failure and missing-field reason are not recreated/asserted; this case describes an 11-pit/49-pipe fixture without asserting those counts. Success here is evidence for this CDFW path, not the whole bug.
   4. **Exact claim line:** 'PROVES_BUGS BUG-132 and BUG-102: CDFW open-space portion only on DRV1_B1; CDSOURCE, original failure conditions, endpoint ownership, excluded-pipe diagnostics and retagging are not proved'.
   5. **Exact additions:** after selecting $fwb/$fwt, add 'field $fwb layer -> $fw_layer', 'field $fwt text -> $fw_text', 'field $fwt layer -> $text_layer'; ASSERT 'equals $fw_layer "DOWNPIPES"', 'equals $fw_text "FW"', 'equals $text_layer "GUIDELINES"' and 'contains $u1 "CDFW"'. Current text~^FW permits extra text; layers and Undo command are recorded only.
   6. **Missing route:** start separate prompt discovery with 'type "CDSOURCE" -Force -TimeoutSec 90 -> $source_start', then 'record $source_start "FULL CDSOURCE prompts"'. Complete actual answers from recorded evidence. No verified prompt chain is supplied here, so unknown answers cannot honestly be specified. Add excluded-pipe and post-CDTAG checks after reproducing those conditions.
   7. **Limits/runs/look:** line 12 still mentions BUG-147 in stale builder-review text. Stored invert preservation (BUG-650) is explicitly excluded. Two new .79 sessions are needed after edits; more open-space passes alone cannot complete either bug. Symbol/text appearance is a Codex look.

5. **R36e: floor waste at an inspection opening (EXPECT-FAIL BUG-1223).** Verdict: **FAIL = real fault**, on .77/.78; installed .79 unknown. Hash **AB5BDFD21ACC**. No review file.
   1. **Asks met:** PLAN_ITEM line 4 and EXPECT-FAIL line 12 name BUG-1223. EXPECTED 14 no longer promises absent Undo. Requested diagnostic was added as an assertion, not a record; cx_cr11's correction remains undone.
   2. **Actual failures:** b4a1/b4c1/b4c2 each fail checks 2, 3, 6 and 7: no placement sentence, false Civil record changed refusal, zero floor-waste blocks and zero FW texts. No crash/timeout caused these. Diagnostic check 1 passes; .78 log times are 07:01:44.448 and 07:52:50.345.
   3. **BUG-1223 comparison, 16761-16771:** case 21 drives the first point; 32 rejects the faulty message. The bug permits joined placement OR justified plain refusal, subject to Tim's decision. Lines 31/35/36 insist on placement. Joining, repeat pick and three other openings are not checked.
   4. **Exact diagnostic correction:** remove ASSERT 30, 'log civil has "Landing index changed between preview and pick"'. After 'windows-snapshot -> $win_end', add STEPS 'log-read civil -> $fwlog'; add ASSERT 'record $fwlog "FULL CDFW diagnostic log"'. Keep 'not-contains $fw "Civil record changed"'. Existing assertion requires a symptom to persist and can reject a correct fix.
   5. **Exact ownership correction:** line 13 becomes 'REVIEWED_AGAINST builder-filled: BUG-1223 in BUG_CARPARK.md; independent review required for the revised hash; BUG-147 is related only.'. Current sentence saying no entry exists is false; opening comment is stale too.
   6. **Exact extra points, separate fresh-drawing twins:** 'type "CDFW{NL}51777.389,-30233.425" -Force -TimeoutSec 90 -> $fw'; 'type "CDFW{NL}55879.087,-30233.481" -Force -TimeoutSec 90 -> $fw'; 'type "CDFW{NL}80936.111,-30304.267" -Force -TimeoutSec 90 -> $fw'. Retain false-refusal assertion and record each reply. A controlled repeat at the first point must exclude an endless retry refusal; do not append points blindly after successful placement changes the prompt.
   7. **Decision-dependent check:** add 'NOT_AUTOMATED BUG-1223 placement or justified-refusal intent, joined placement, repeat pick and the other three opening points must be proved before whole-bug acceptance.'. After Tim's intent is recorded, require approved refusal and 'equals $c1 $c0', or verified joining plus block/text. No approved refusal sentence or connection-reader route is established here.
   8. **Runs/red/look:** after corrections, two passing .79 sessions on revised hash and a current-hash broken variant for the target assertion are needed. Old-text failures cannot be reused. Real mouse pick and symbol/label position remain untested; false command-line refusal needs no picture.

## Things the desk should know first (RULES 6.2)

1. **The brief's installed-build expectation is stale.** Civil/Manager .79 replaced .78 at 16:57. Historical .78 passes/faults must be dated as such.
2. **B4's "R09 has no valid run on its final text" is superseded.** Current R09 is 8763A665A9C3, not B4's E6C6A80BBB7D. Two current-text .78 failures and two current OFF reds now exist. cx_cr02's blocked/wrong-log snapshot is not today's result.
3. **B4's "quick MOVE is now complete" is too strong.** Undo additions/window red are real, but C41 still has four unasserted movements and weaker precision. cx_cr03's one-.78-pass count is outdated: there are now two.
4. **B4's suggestion that .77 plus .78 might be accepted together is not allowed.** Same complete build key and two distinct sessions are required. This review combines no builds.
5. **R33/R36 claim corrections are present.** Do not repeat that R33 still claims a correct message or R36 still proves BUG-147. Remaining scope is partial; stale builder-review comments need correction.
6. **R36e's log requirement is not record-only.** Its file and B4 acknowledge it will fail if the symptom disappears. That is a case defect, separate from CE's false refusal. BUG-1223 already exists; no duplicate is needed.
7. **Report totals include records.** R12's 43 successful entries include record-only values, which cannot fill missing assertions.
8. **Gate/old reviews:** Get-CaseIndependentReview requires anchored READY, matching 64-character hash and REVIEWER not starting with builder. It binds no SETUP contents. R09's E08D471171A9 and R12's BD2248161743 review hashes differ from current files; neither verdict is READY. Both remain untouched. No R33/R36/R36e review file exists; none is created.
9. **No current-build fault claim from silence:** .79 absence is Unknown, not PASS and not proof .78 faults persist. Desktop, runner and settings remain untouched.

## What I read

1. **Authority/method:** RULES.md completely first, ROUTER.md, 24 Oct acceptance decision, START_HERE/MASTER_PLAN context, B3FIX/B3B in full, B4 builder report in full. Work item: desk plan/03 independent case review cx_cr21.
2. **Earlier asks:** searched every RUNNER_CASE_REVIEW_*.md and CODEX_CASE_REVIEW_*.md for all five IDs. Relevant sections: initial 24 Oct, R11_R20, B2, HARDEN, B3, B2FIX, B3FIX, B3B; Codex cx_cr02, cx_cr03, cx_cr08, cx_cr10, cx_cr11. Latest asks are identified per case.
3. **Contracts:** C04/C41 in TEST_CASES_DRAFT_22OCT.md; D07/D15 in DAILY_TOOLS_TEST_CASES_2026-10-23.md; gap-plan section 2 and 3 item 7; BUG-460/672/262/859/132/102/147/1223 in BUG_CARPARK.md; BUG-132/147 referenced REGRESSION_LOG entries.
4. **Cases/runner:** all five current cases/eight variants; R09/R12 reviews and R16 format example; Get-CaseIndependentReview; civil/civilx mapping, dist, field, ent-part and log-read handlers. Text read only, never sourced/invoked.
5. **Evidence:** relevant ledger rows against computed hashes; parent/variant checks and session times in JSON/Markdown b4a1, b4c1, b4c2, b5r1b, b5r2a; direct structured-log lines for current R09 ON/OFF pairs.
6. **Builds:** nine live main DLL ProductVersions, three live Contents dates, preserved Civil/Manager DLL versions and Contents dates for .75/.77/.78. No installation performed.

## Hashes computed for this review

1. **R33:** DDEAA7503ACD27BFAB98986B1447741EA1E142E2BB246924D935213510BC9B84.
2. **R12:** 334263931AF1C4DB72CF146BC413B763A477158C4633091C8B833DAFD8825714.
3. **R09:** 8763A665A9C3EEFB8E04AFFED95632E407945453E05158982DB28F41872C9B74.
4. **R36:** 4670716EF0F978ECC9FF67F85A3E0D113B9E5C0F80D0A4B2C81708C8EC990187.
5. **R36e:** AB5BDFD21ACC9B8C2F27606F2D0631DF714F04FE86C79075D008EEF8E08F94CC.
6. **R33_BROKEN:** 696221D5C1BB76144B0F22EC6594B4CF360FCAC39AAE9EA8741E3EC5837ABF7D.
7. **R33_NUM_BROKEN:** 5085519BBD1C47EE7FDF904F062794191939AB423D607F60115BDFCFB353F081.
8. **R12_BROKEN:** BE0D5C18E2A4F303A082494E1EA44DEA88D61F6CA7E14E198735DB5FBA085072.
9. **R12_NOU_BROKEN:** D45A8DB6C0110DE2CE5655F93A8049BD1E75126B5F9959F842A0B7251F3073E3.
10. **R12_WIN_BROKEN:** 9A781115FF947414CA4EC2FC7F07625D22C7BA671980F2111F4719C4595F6ED0.
11. **R09_OFF_BROKEN:** 93283A5F52548E83CB8143F807F5990AC7EDDDD401409FB2DCD3A0D2905DFB92.
12. **R36_BROKEN:** 6D5FBC221FFB79E36C5F240026DC24CB087DE40D99439656C7BF819EAB0F5EA1.
13. **R36_AGI_BROKEN:** 748A61AEEC08FA2D682BF27D9D77D75D6CFCAD4E43D5C2DD38DB7B5DDA86EC9E.

## What I did NOT check

1. **No execution:** no AutoCAD, runner, case, driver call, lock, settings guard, build, installation or test. No sub-agents.
2. **No visual acceptance:** no drawing/window picture judged; no claim labels are well placed or a window is usable.
3. **No engineering/code diagnosis:** no council values, sizing or floor-waste placement rule approved; no claim about AutoCAD internals or proof of CE's internal root cause.
4. **No wider recount:** cases outside these five are not re-reviewed. Historical global totals are not carried forward. Settings/fixture fingerprints in reports are not fresh hashes of Tim's live settings/drawings.
5. **No protected changes:** no case, variant, setup, ledger, run report, setting, BUG_CARPARK, DESK_LOG or QUEUE edited; no bug marked fixed.

## Files written

1. **Report only:** C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr21.md. No review.txt qualifies, so none is created, replaced or deleted. Only this named report is staged, committed and pushed. Undo is a revert of its report commit.

## Summary

0 of 5 cases is ready. R33 and R36 cover parts only; R12 needs four movement assertions and the card's geometry contract. R09 now has two current-text failures on .78 with a working OFF log red. R36e reproduces BUG-1223 but wrongly requires its fault diagnostic. Installed Civil is .79; none has runs on it. No whole daily-tool item or current-build bug fix is added. Only this report is written; no review file or AutoCAD run.
