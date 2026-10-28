# Codex independent case review cx_cr26: R33, R33m, R36, R37b, R32 and R34sn (Thu 29 Oct 2026)

Read rules, cards/bugs, cases/twins, installed DLLs, fresh hashes, ledger and reports; judged independently, then compared Opus/staging. No AutoCAD, runner, driver, build, install, test, lock, guard or sub-agent. Only this report was written.

## FOR TIM

1. **All six cases prove parts, not whole claims.** Perimeter drain text follows MOVE/COPY, but Settings height and renumbering remain unchecked.
2. **One whole bug can carry today's Civil 3.0.85 build: BUG-460.** PIT refuses before drawing anything when either pit text layer is locked. This updates the existing 3.0.84 acceptance; it is not a newly discovered fix.
3. **R33m lacks a positive "no cover text" check.** Staging adds it; fresh runs remain.
4. **The arrow survives a second plain Save in two starts.** Other pipe-editing routes remain outside this case.
5. **No testing needed from you.** Whether a floor waste may occupy an existing opening remains your engineering decision.

---

## ANSWER FIRST

1. **Counts, one main verdict per case:** CLAUDE-ACCEPTED-READY **0**; PARTIAL (part only) **6**: R33, R33m, R36, R37b, R32, R34sn. NEEDS BROKEN VARIANT **0**; NEEDS STRONGER ASSERTION **0**; NEEDS CODEX LOOK **0**; FAIL = real fault **0**; NEEDS RUNS **0** as primary verdicts. R33m also needs a stronger assertion; R34sn lacks a SCALE red. Appearance is excluded.
2. **Counting rule:** Opus called these "CLAUDE-ACCEPTED-READY for PART"; this brief requires PARTIAL. I agree with the limited passing parts. BUG-460 is complete within R33; its other claims remain partial.
3. **Installed ProductVersions, read in Legacy, Modern and Net8:** all three Civil DLLs read `3.0.85+09126560f98acc4fd6ca4be298d087307a89a259`; all three Manager DLLs `1.1.85+09126560f98acc4fd6ca4be298d087307a89a259`; all three Structural DLLs `1.0.125+204dfad268caf967f3404d876648480a94efe1cd`.
4. **Contents creation times, Melbourne:** Civil 29 Oct 00:21:11.891617; Manager 29 Oct 00:21:12.6643014; Structural 27 Oct 06:23:15.428689. Civil/Manager 3.0.84 backups: 28 Oct 12:59:39.1633245 / 12:59:39.7468519, DLL suffix 94f521cc. The 3.0.83 backups: 27 Oct **19:40:43**, not 19:39, suffix 96455f13.
5. **Install windows:** backup names indicate replacement started 28 Oct 12:58:37 and 29 Oct 00:20:10. Conservatively, counted 3.0.84 runs fall after 28 Oct 12:59:39.746852 and before 29 Oct 00:20:10; counted 3.0.85 runs fall after 29 Oct 00:21:12.664301 and before this review's DLL read at about 10:18. No later install is evidenced. Every counted pack begins and finishes within its interval.
6. **Build comparison:** the ledger stamp `civil 3.0.85+09126560 / struc 1.0.125+204dfad2 / mgr 1.1.85+09126560` matches the versions and shortened commit suffixes of the installed DLLs. Run JSON headers contain the matching full ProductVersions.
7. **Current-text passing sessions, full ids and ledger times:**
   1. **R33/R37b:** `RUN-20261029-0519-C3.0.85-aX11-s1` and `RUN-20261029-0534-C3.0.85-bX11-s1`; ledger at 05:24:46 / 05:39:18. Packs 05:19:37-05:24:46 / 05:34:33-05:39:18. Two PASS rows each.
   2. **R36:** the same aX11/bX11 pair, plus `RUN-20261029-0244-C3.0.85-c1a1-s1` and `RUN-20261029-0325-C3.0.85-c1b1-s1`, at 02:56:15 / 03:37:18. Four PASS rows/four sessions.
   3. **R32:** `RUN-20261029-0244-C3.0.85-c1a1-s1` and `RUN-20261029-0325-C3.0.85-c1b1-s1`; packs 02:44:49-02:56:15 / 03:25:59-03:37:18; at each finish. Two PASS rows.
   4. **R33m:** `RUN-20261029-0259-C3.0.85-c1a2-s1` and `RUN-20261029-0340-C3.0.85-c1b2-s1`; packs 02:59:16-03:07:29 / 03:40:19-03:49:05; at each finish. Two PASS rows.
   5. **R34sn:** `RUN-20261029-0315-C3.0.85-c1a4-s1` and `RUN-20261029-0356-C3.0.85-c1b4-s1`; packs 03:15:05-03:17:51 / 03:56:56-03:59:57; at each finish. Also PASS `RUN-20261029-0233-C3.0.85-b6c1-s3`, at 02:39:40, pack 02:33:34-02:39:40. Three PASS rows.
   6. **Older pair, R33/R36/R37b:** `RUN-20261028-1310-C3.0.84-b6a2-s1` and `RUN-20261028-1418-C3.0.84-b6a3-s1`; packs 13:10:29-13:25:29 / 14:18:49-14:34:09, at each finish. Historical part evidence only.
8. **Hash/failure audit:** 1,385 ledger rows in the snapshot. Every counted row equals my fresh Get-FileHash SHA-256. No current-hash FAIL on 3.0.85 for these six. Old-text rows excluded: R32 5, R33 10, R33m 0, R36 9, R37b 8, R34sn 9. Current-text R32/R33m failures on 3.0.84 are historical, not standing current-build failures.
9. **Excluded install-straddling pack:** b6b1 began 28 Oct 12:42:58 and ended 13:06:53, across the 3.0.84 install. Rows say 3.0.83 at 13:06:53. Its first session ended 12:58:19; later sessions started 12:59:59 and 13:03:38. I count none of it under the brief's row-time rule.
10. **Live hashes, first 12 characters:** R33 `EC16A6B2B6C2`; R33m `F9DDB36AE114`; R36 `68100FB1BBAB`; R37b `7DC161EA7A8A`; R32 `B441549C8A69`; R34sn `F8A2788F0DEC`. R33m lives under cases/variants but has CASE R33m and no VARIANT_OF. None of these six or their reviewed broken twins references a SETUP; run setup fields are empty. There is no referenced setup to hash.
11. **Reds checked against current hashes and failing assertions:**
   1. **R33:** R33_BROKEN `696221D5C1BB`, no lock: missing refusal, count 1035 instead of 1034. R33_NUM_BROKEN `5085519BBD1C`, expects P3 while reading P8: **flipped red**. Both VARIANT_OF R33, FAIL/from_check true in b6a2/b6a3 on 3.0.84.
   2. **R36:** R36_BROKEN `6D5FBC221FFB`, Escape instead of placement: no placement line and zero blocks. R36_AGI_BROKEN `748A61AEEC08`, expects five AGI blocks instead of four: **flipped red**. Both VARIANT_OF R36, FAIL/from_check true in b6a2/b6a3.
   3. **R37b:** R37b_BROKEN `9F40F9896631`, no MOVE/ERASE: y -79925 instead of -78925 mm and PD1 remains. R37b_SIDE_BROKEN `ECFAE6A8B50F`: x 151500 instead of 151000 mm; other numeric checks pass. R37b_COPY_BROKEN `795EB9EF387F`: expects PD1 twice, receives PD1/PD2, **flipped red**. All VARIANT_OF R37b, FAIL/from_check true in b6a2/b6a3.
   4. **R32:** R32_BROKEN `9B522F1E929E`, reversal omitted: rotation 0 and unreversed IL texts fail both assertions in c1a2/c1b2 on 3.0.85; VARIANT_OF R32/from_check true. Exact main text also fails second-Save checks 13/14 in b6b2/b6b3 on 3.0.84, at 13:50:43 / 14:15:23 on 28 Oct.
   5. **R33m:** exact main text fails check 11, false "no label", in b6a2/b6a3 on 3.0.84: before-fix evidence under the acceptance decision. **No linked variant row exists.** C33m `6BA0CC743763` reproduces check 11 in `RUN-20261029-0413-C3.0.85-c1k2-s1`, 04:13:18-04:14:33, from_check true, but variant_of is empty. Supporting control evidence, not a formal variant red.
   6. **R34sn:** R34sn_BROKEN `F2CBD851707E` fails COPY's P3 expectation in b6c1-s3 on 3.0.85, VARIANT_OF R34sn/from_check true. **Flipped COPY red only; SCALE never executes in this twin.**
   7. **C32:** `92D29358DA73`, `RUN-20261029-0417-C3.0.85-c1k3-s1`, 04:17:36-04:22:59, fails checks 13/14 with rotation 0. Its empty variant_of means corroboration, not a formal variant red. No counted red is a crash, timeout or E_FAIL.
12. **Whole daily cards/gap items added: zero on the installed build; zero on any build.** D07 is DP/CDRG before pipes, not CDFW/perimeter drain. D15 needs ordinary COPY, original number, Check levels and exact U restoration. D17 needs selection restoration. The extra gap-plan Edit Pipe cascade with U/REDO is not a second plain Save. No global 40-item recount is inferred.
13. **Whole bug wording permitted, never close/delete the entry (D6):** "FIXED (Claude-accepted, Civil 3.0.85, 29 Oct 2026): BUG-460, R33 hash EC16A6B2B6C2, aX11-s1 and bX11-s1. PIT refuses before placing with STORMWATER PIT LABEL locked and with 25TEXT locked; layer named, object count unchanged. Current-hash R33_BROKEN supplies a real-action red on 3.0.84. Independently re-reviewed in CODEX_CASE_REVIEW_cx_cr26.md, case item 1." This upgrades existing 3.0.84 evidence.
14. **Whole bugs not established here:** BUG-672 positive missing-cover wording; BUG-262 other message branches; BUG-132/102 CDSOURCE and original fault conditions/diagnostics; BUG-236 renumbering/height; BUG-665 other copy routes and ownership; BUG-223/686 CD branches. R36 disclaims BUG-147/650. BUG-1222's size-only route belongs to R32b, outside this assignment: its existing status is neither revoked nor re-certified. Tim's recorded 29 Oct BUG-665/1222 confirmations remain separate, untouched facts.

## How I applied the four conditions

1. **Method:** compare current text with the whole claimed bug/card; match hashes and separate sessions inside install windows; inspect the actual failing twin checks; exclude appearance and engineering judgement. Parts stay parts, even with passing runs.

## The cases

1. **R33: locked pit text layers. Verdict: PARTIAL (part only: BUG-460 whole; BUG-672 cover-lock behaviour; BUG-262 P3 schedule-cell message/recovery). Hash EC16A6B2B6C2.**
   1. **Comparison:** BUG-460 lines 9633-9637 requires refusal before insertion. Case steps 21-30/53-61 and assertions 67-70/93-94 cover both locked layers. BUG-672 lines 2582-2592 requires open-layer pieces copied and skipped item named: steps 35-49, assertions 71-81/87 read pit, label, non-P3 number and absent CL text. BUG-262 lines 5095-5099 requires plain names/recovery: assertions 74-75 cover one P3 column.
   2. **Asks met:** copied label read, full reply recorded, named P3 column and recovery asserted. There are 21 actual assertions plus 10 records. U restores count 1034; original handles and stored records are not compared.
   3. **Missing whole coverage:** positive cover-text wording; BUG-262's locked pit/source message, copied foreign schedule cell and locked invert-text route. "Not P3" is not "next free"; equal counts are not exact Undo restoration.
   4. **Exact additions:** ASSERT `contains $cp1 "got their own number but no cover text"` and `not-contains $cp1 "no label"`, or use a newly proved R33m containing both. Other BUG-262 branches require their own route: first capture `record $reply "FULL skipped-item reply"`, then pin the actual pit/pipe, layer, column and recovery. Their replies/routes are not established here; an invented sentence is not an executable whole-bug test.
   5. **Opus:** AGREE with B6 item 2's scope and whole BUG-460. Its current-fault description of R33m is superseded by 3.0.85. Matching slip by **Opus-Team-B6-review** retained, still worded for historical 3.0.84; this report supplies the current pair. **Codex look:** label appearance/placement.

2. **R33m: locked 25TEXT copy message. Verdict: PARTIAL (part only: false "no label" removed; layer/recovery named; pit/number label retained). Hash F9DDB36AE114.**
   1. **Comparison:** BUG-672 lines 2582-2592; case 20-34 creates the cover-lock trigger; assertions 42-48 check pieces, layer/recovery and number; line 52 rejects "no label". No assertion requires the missing item to be named. Eleven assertions plus three records.
   2. **False-pass example:** "copied pit(s) got their own number; layer 25TEXT is locked ... Undo (U), unlock layer 25TEXT, then copy again" passes without naming cover text. Both real 3.0.85 reports correctly say "got their own number but no cover text"; recording it does not protect it.
   3. **Exact addition:** ASSERT `contains $cp1 "got their own number but no cover text"`. Retain the negative check; remove `EXPECT-FAIL BUG-672` and stale expected-failure comment together. With R33's layer checks this covers the filed cover-lock symptom's missing message. Broader coverage needs label-only/both-locked branches.
   4. **Staged result:** actual diff/hash confirms staged R33m `EC896953A560D8BA6F6DACA42152827C8369A69D988F6C4A3450AB034FD6C663` adds that positive assertion and removes the tag/comment. **It closes the assertion ask in text.** Zero ledger rows match it; two new PASS sessions are needed on Civil 3.0.85 if still installed.
   5. **Staged control gap:** C33m `9DF1A38740AC1BB7C7BE501C7D1FD2093E154A35D6F83626A4C1A87467FE4E1A` adds `VARIANT_OF R33m` but **not** the new positive assertion. Add `contains $cp1 "got their own number but no cover text"` there too; obtain a new current-hash FAIL/from_check row. Old main-text 3.0.84 failures cannot certify the edited hash. The old negative check should still fail, but the new positive check must also be exercised.
   6. **Opus:** AGREE with B8 item 8's limited part/missing assertion. Matching **Opus-Team-B8-review** slip retained, not whole BUG-672 acceptance. DISAGREE with the staged report's claim C33m tests the new line: it is absent. **Codex look:** label appearance.

3. **R36: CDFW in open space. Verdict: PARTIAL (part only: open-space placement with four AGI tags, U, Escape without placement). Hash 68100FB1BBAB.**
   1. **Comparison:** BUG-132 lines 9362-9372 and BUG-102 lines 9504-9512. Case 20 places at 150000,-98000; assertions 39-49 hold reply, AGI diagnostic, exact FW and layers. Steps 30-36/assertions 46/50-52 cover U/Escape by count/echo. BUG-132's referenced R2 entry additionally requires excluded-pipe diagnostics, retagging and CDSOURCE. BUG-102's original 12-pit/50-pipe and malformed decision-row condition is absent.
   2. **Asks met:** narrowed PROVES_BUGS, BUG-147 removed, AGI line, DOWNPIPES, GUIDELINES, exact FW and U echo asserted. Sixteen assertions/five records. No pit/pipe count or stored pit invert is read. Equal counts after Escape cannot disprove BUG-650's stored-level loss.
   3. **Exact next discovery steps:** `type "CDSOURCE" -Force -TimeoutSec 90 -> $source_start`, then `esc-prompt -> $source_cancel`, then `record $source_cancel "FULL CDSOURCE first prompt and cancellation"`. The prior probe already shows the source-type question; later placement answers are unproved. This discovery earns no placement credit. Once the complete route is captured, require the placed object and duplicate-owner diagnostic; for the deliberate excluded-pipe condition add `log civil has "left out of this placement"`. A separate post-retag case needs `log civil absent "left out of this placement"` over its own log interval.
   4. **Whole prerequisites:** recreate the original BUG-102 record fault in a synthetic 12-pit/50-pipe fixture and run CDFW/CDSOURCE; counts alone do not recreate it. Drive BUG-132's duplicate owner, exclusion and CDTAG routes. Exact unknown follow-on answers cannot honestly be supplied now. Optional point check: `dist $fwb "150000,-98000" -> $fw_dist`, ASSERT `number $fw_dist = 0 +- 0.5`.
   5. **Opus:** AGREE with B6 item 3's limited scope/no D07 credit. Matching **Opus-Team-B6-review** slip retained. Four current-build sessions support this part. **Codex look:** symbol/label appearance. Placement on an occupied opening needs Tim's ruling.

4. **R37b: perimeter drain text. Verdict: PARTIAL (part only: PD1 follows MOVE/ERASE; copied PD2 remains at its measured position). Hash 7DC161EA7A8A.**
   1. **Comparison:** BUG-236 lines 5640-5644. Case 20 creates PD1, 31-40 copies, 41-48 moves, 49-58 erases the original. Assertions 61-74 hold text counts/x/y. Renumbering and height from Settings, explicitly named by the bug, never run.
   2. **Asks met:** one polyline/start y asserted; MOVE keeps x; copy x equals original; surviving PD2 retains x/y. Main x 151000 mm; PD1 y -79925 then -78925 mm; PD2 y -76925 mm. Sixteen assertions/five records. SIDE_BROKEN fails x alone.
   3. **Missing:** changed Settings height, original-drain renumbering and independent record identity. "It has its own record" is a CE reply, not a record read. Original polyline disappearance is recorded but not asserted.
   4. **Exact additions:** after $after_erase add `select $after_erase "handle~^{$hline}$" -> $original_line_left`; ASSERT `count $original_line_left = 0`. Height header: `SETTING CD_Settings.json surface.drainTagTextHeightMm 300`. **After the runner owner adds numeric text_height**, use `ent-read {$htag} -> $pd_entity`, `field $pd_entity text_height -> $pd_height`, ASSERT `number $pd_height = 300 +- 0.001`. This is a prospective reader contract, not working current syntax: v3's MText branch at line 830 only reads text/insertion.
   5. **Renumber:** establish the supported drain command/control first; no route is recorded here. After changing original PD1 to PD3, re-read its text handle and ASSERT `matches $renumbered_tag "text.:.PD3.,"`, with copied PD2 unchanged. A twin omitting renumber must fail. Do not infer a drain route from the pit CDRENUMBER command. Independent record ownership also needs a supported record reader.
   6. **Opus:** AGREE with B6 item 4. Matching **Opus-Team-B6-review** slip retained. NOT_AUTOMATED line 16's "key is not known" is stale: line 15 names it. **Codex look:** text readability, placement and overlap; numeric displacement alone is accepted.

5. **R32: Edit Pipe second plain Save. Verdict: PARTIAL (part only: BUG-1222 plain-second-Save, BUG-223 CDEDIT reversal, BUG-686 Edit Pipe zero level). Hash B441549C8A69.**
   1. **Comparison:** BUG-223 lines 5728-5734; BUG-686 2412-2416; BUG-1222 16745-16759. Steps 20-61 create/reverse/save the 18.000/17.900 pipe; 62-102 repeat 0.50/0.00. Assertions 107-131 read arrows/IL sides after both saves. Prior IL reread ask is met. BUG-223 also names not-drawn-first CD; BUG-686 names CD; BUG-1222 as filed uses diameter-only Save.
   2. **Evidence:** second-Save rotations 3.141592653589793; west IL x 150200 mm, east IL x 169800 mm. Levels and arrow agree numerically. Twenty-seven assertions/thirteen records. Exact-text 3.0.84 checks 13/14 failed; these are historical faults, not current ones.
   3. **Exact missing size-only branch:** after reversal: `pick-first "{$hpA}"`; `type "CDEDIT" -Force -ExpectWindow "Edit Pipe" -TimeoutSec 120 -> $size_open`; `ui2-set "Edit Pipe" "C2.Diameter" "150"`; `ui-press "Edit Pipe" "Edit pipe, Save" -> $size_save`; `sleep 6`; `esc-prompt -> $size_reply`; `wait`; `ent-read {$haA} -> $size_arrow`. ASSERT `matches $size_arrow "rotation.:3\.14"`, `contains $size_reply "Pipe updated."`; re-read/assert both IL sides and the changed 150 diameter label. **R32b already owns this route**; review it rather than duplicate whole-bug credit.
   4. **Other gaps:** a separate zero-level CD case should use `ui2-set "New Pipe" "C2.FirstInvert" "0.00"` and `ui2-set "New Pipe" "C2.SecondInvert" "0.50"`, then read/assert the placed arrow and IL sides before editing. BUG-223's not-drawn-first route still needs prompt/control capture. D17 requires selection reads/multiple selection, absent here. Pipes on pits and Edit 2+ are also outside this part.
   5. **Staged result:** R32 `4D0E972B30A0D796E81049104F3AB8DB62D74C657D1E55BFC26D9E99EAC875F2` only replaces empty BUG plus EXPECT-FAIL with `BUG BUG-1222`. **Stale tag ask closed; no coverage added.** Zero matching ledger rows: two new PASS sessions after application. R32_BROKEN keeps its reversal red; staged C32's VARIANT_OF addition needs a new run for the second-Save red.
   6. **Opus:** AGREE with B8 item 9's scope/result. Matching **Opus-Team-B8-review** slip retained. **Codex look:** arrow/label appearance and editor preview; no source-cause claim.

6. **R34sn: COPY/SCALE Copy numbers. Verdict: PARTIAL (part only: COPY reads P8, SCALE reads neither P3 nor P8, old cleanup tick ON). Hash F8A2788F0DEC.**
   1. **Comparison:** BUG-665 lines 2668-2672. Steps 20-28 read COPY, 29-36 perform ROTATE but only record its label list, 37-46 read SCALE. Assertions 49-52 hold P8 and not-P3/not-P8. B6's different-copy-numbers ask is met. Records, schedules, pipes, grips and PITDELETE behaviour remain unread.
   2. **D15 lines 461-479:** this case changes a setting, does not assert Check levels, never re-reads the original and has no U. No whole D15. Recorded SCALE is P12, but its assertion accepts P1/P9 or any number except P3/P8 even if already occupied. P8 is fixture-derived, not a universal rule.
   3. **Opus qualification:** AGREE the two measured copy labels differ. DISAGREE with B8 item 5's stronger claim "the two copies and the original never share a number": the original is never read after copying. After each operation add `ent-read 109E08 -> $original_label`, ASSERT `matches $original_label "text.:.P3.,.insertion"`, using distinct variables for each read. A full label comparison is needed to establish that numbers are free.
   4. **Other gaps:** ROTATE's number is unread; schedule/record ownership, grip copies, pipes and PITDELETE are untested. Confirm the occupied numbers before asserting P11/P12; these are fixture-derived, not universal requirements.
   5. **SCALE red:** add a twin with `VARIANT_OF R34sn`, the real SCALE route/read, and deliberately flipped `matches $scl "text.:.P3.,.insertion"`. Obtain a FAIL/from_check row. Stronger free-number red: preoccupy the expected number and retain its assertion, once the allocation rule is established. Whole BUG-665 still needs grip/ROTATE/SCALE pits/pipes and independent ownership/deletion/movement safeguards.
   6. **Opus/staging:** matching **Opus-Team-B8-review** slip retained for its limited part. B6's older hash and nine old-text rows are excluded. Staged R34sn changes words only: it fixes stale "ROTATE adds no label", none of the remaining coverage/red gaps. A new ROTATE label object is recorded on 3.0.85; its number is unread. **Codex look:** SCALE about the original pit's insertion point can leave overlapping labels; distinct numbers do not prove legibility.

## Things the desk should know first (RULES 6.2)

1. **Six matching slips do not equal six whole acceptances.** The gate at case_runner.ps1 116-126 checks leading verdict words, hash and non-builder REVIEWER. It cannot interpret "for PART". I read it; did not execute it. All six slips match and were preserved.
2. **Staged C33m lacks the new positive assertion.** Adding VARIANT_OF does not add that check. The staged report's description is too strong.
3. **Reported check totals include records:** R33 31 = 21 assertions + 10 records; R33m 14 = 11+3; R36 21 = 16+5; R37b 21 = 16+5; R32 40 = 27+13; R34sn 9 = 6+3. These are runner totals, not that many independent tests.
4. **Stale words:** R33 describes the old false message; R33m/R32 retain expected-failure tags; R34sn says ROTATE adds no label; R37b says its height key is unknown. Editing even a comment changes the hash and requires fresh runs.
5. **b6b1 cannot be counted under this brief:** the pack straddles an install and all rows were stamped afterwards with the older build. Excluded throughout.
6. **Carpark wording conflict:** BUG-1222 now begins with Tim's 29 Oct confirmation but ends "Not Tim-confirmed in his own drawings". Do not overwrite his confirmation. This report edits neither that entry nor BUG-665's confirmation.

## What I read

1. **Authority:** RULES.md and both B3FIX/B3B model reviews in full; ROUTER, CE_PLAN start/map, acceptance decision, R16 slip, review gate.
2. **Prior reviews:** searched every RUNNER_CASE_REVIEW_*.md; only B3/B3FIX matched these ids, sections read. Opus B2/B7 had no relevant sections; B6/B8 compared after independent judgement.
3. **Claims:** the twelve bug entries identified above; referenced R2/R4 regression entries; D07/D15/D17; gap plan section 2 and section 3 item 7. No C-number claimed; draft C-card file searched.
4. **Evidence:** six cases/slips, nine twins, C32/C33m, staged diffs/control, staged report; fresh SHA-256, ledger rows, JSON/Markdown for every named counted run and control, b6b1 timing; nine DLL versions, Contents/backup times, MText reader. TimOS leak-scan instructions for publishing.

## What I did NOT check

1. **No execution or look:** no AutoCAD, runner, offline checker, driver, build, install, tests, guard, lock, sub-agents, drawing, window or preview. No engineering acceptance.
2. **No wider audit:** no live settings, fixture contents, stored records, production-fix cause or client drawings inspected. Fingerprints come from session reports. R32b/R34a/N-series and other cards were not re-reviewed.

## Files written

1. **Report only:** C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr26.md. All six existing Opus slips match and remain untouched. No case, variant, setup, ledger, run report, staged edit, settings, bug entry, DESK_LOG or QUEUE changed.
2. **Delivery:** this report alone is committed by name; merge/push use the existing leak-scan hook.

## Summary

All six cases have current-hash passes in separate sessions on Civil 3.0.85, but remain PARTIAL against their combined claims. BUG-460 alone is wholly supported here. No whole daily-tool item is added. R33m staging adds the missing cover-text check; its control still lacks it. R32 staging only fixes its stale tag. R34sn does not read the original's number or prove SCALE's number is free. Existing Opus slips remain untouched. No AutoCAD or tests were run.
