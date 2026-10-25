# Codex independent case review cx_cr01: R04 and R06 (Mon 26 Oct 2026)

Written 26 Oct 2026, about 07:56 Melbourne, by Codex (GPT-6). I read RULES.md, the acceptance decision, both complete B3FIX and B3B model reviews, every R04/R06 section found across RUNNER_CASE_REVIEW_*.md, the cards, cases, variants, setup, review gate, installed DLL versions and ledger rows. I read the relevant saved run evidence; I did not open AutoCAD, run a case, build, install, test code or change any operational record. This report is the only file created.

## FOR TIM

1. **Neither of these two cases is ready to accept as a whole.** R04 is PARTIAL; R06 NEEDS CODEX LOOK. No bug may be newly written fixed from this review.
2. **The drawing-saving check still misses CDREBUILD.** The recorded pit, pipe, synchronise, recover-inverts and Pit Schedule steps leave the drawing file unchanged. That does not establish what happens when a drafter rebuilds a job.
3. **The About window's version numbers pass, but its lower rows are a separate problem.** The existing D8 look reports clipped AutoCAD and Runtime rows on today's build. A correct number hidden behind the bottom edge is not readable on a job.
4. **Each case has only one passing session on today's Civil 3.0.78.** A pass from yesterday's build cannot be its second pass. The desk needs the missing checks and fresh evidence; nothing here needs an engineering decision from you.

---

## ANSWER FIRST

1. **Counts, one main verdict per assigned case: 2 cases.** CLAUDE-ACCEPTED-READY: 0. NEEDS BROKEN VARIANT: 0. NEEDS STRONGER ASSERTION: 0 as a main verdict. PARTIAL: 1 (R04). NEEDS CODEX LOOK: 1 (R06). FAIL = real fault: 0 as a main case verdict. NEEDS RUNS: 0 as a main verdict. Both cases additionally lack a second current-build session; R06 also needs stronger AutoCAD/runtime assertions. The separately recorded D8 window fault is not a FAIL row of R06.
2. **Installed build, read directly from all nine DLLs.** Under each named bundle's Contents\Win64\Legacy, Modern and Net8, all three lanes agree:
   1. **Civil, CE_CVL_SUITE.dll:** `3.0.78+d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`.
   2. **Manager, CE_SUITE_MANAGER.dll:** `1.1.78+d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`.
   3. **Structural, CE_STRUC_SUITE.dll:** `1.0.124+3a3caac5db7687f1b5d1a6e09571976c52b2b05a`.
   4. **Contents creation times, Melbourne:** Civil 26 Oct 05:41:30; Manager 26 Oct 05:41:31; Structural 25 Oct 17:41:13. Paths are under `C:\Users\TimothyBrand\AppData\Roaming\Autodesk\ApplicationPlugins`.
   5. **Current ledger build key:** `civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09`. This is the runner's shortened representation of the directly read ProductVersions, not a literal full-string comparison. The b4c1 JSON header contains the full matching strings.
3. **Install windows, checked against the install logs and run times.** All times below are Melbourne. No counted row or its recorded run interval straddles an install.
   1. **Civil/Manager 3.0.75/1.1.75:** C-65 verified 25 Oct 03:33:13. The b3z1 run was 12:10:30-12:29:10 and b3z2 was 13:49:02-14:09:47 that day. Both precede the next composite-build change, Structural's replacement beginning at 17:41:13 (S-44 verified 17:41:28), and the Civil/Manager C-67 replacement verified at 20:42:11.
   2. **Civil/Manager 3.0.77/1.1.77:** C-67 verified 25 Oct 20:42:11. b4a2 ran 26 Oct 04:46:45-05:40:13; its rows are stamped 05:40:13, before the next bundle creation at 05:41:30. Its two AutoCAD sessions started 05:01:10 and 05:32:25 and finished before that replacement.
   3. **Civil/Manager 3.0.78/1.1.78:** C-68 verified 26 Oct 05:41:40. b4c1 ran 05:42:18-07:06:05; its rows are stamped 07:06:05. Its relevant sessions were s1 05:42:20-05:51:44 and s3 06:41:39-07:02:17. These are after installation. The directly read build remains 3.0.78 at this review; no subsequent replacement was observed.
4. **Current file hashes, computed with Get-FileHash -Algorithm SHA256.** The selected ledger rows equal these complete hashes:
   1. **R04:** `443604166CC0C57BCD3C01A377E05A9E1C55915E9EC404F889C6963139CBB056`.
   2. **R06:** `6D94611EC40B3F53123A72CAE8FDF6A95170DA92FE30E15DB81B309D968B92FE`.
   3. **R04_SAVE_BROKEN:** `CF906DD5B5FBFF6F389E4887BFAAD87E2218770347FA2ABF756FEB456DF2EF4C`.
   4. **R06_BROKEN:** `64832165EEB7172436BEDC4ED6FB09C51CDF00CF1698BDACAFFAE92E312D4E1A`.
   5. **SETUP-P8.setup.txt, used by R04 and its variant:** `7A241608EB590525E0F1D37AB459F9D7116677D17AD6CD5C4C2D6C97FC496F03`; created and last written 23 Oct 20:05:31, before these runs. R06 and its variant name no setup. The review gate checks the case hash, not the setup hash; this timestamp is supporting evidence, not a separately secured historical setup fingerprint.
5. **Ledger, read row by row from the 484-row array at review.** Only exact current hashes count. There is no current-hash FAIL for either main case on any build. Older R04 and R06 texts contribute nothing to the following counts.
   1. **R04: two PASS rows, but no qualifying pair.** `RUN-20261026-0446-C3.0.77-b4a2-s2`, at 26 Oct 05:40:13, is on civil 3.0.77+0d885094 / struc 1.0.124+3a3caac5 / mgr 1.1.77+0d885094. `RUN-20261026-0542-C3.0.78-b4c1-s3`, at 07:06:05, is on the current build key. One session on each build is not two on one build.
   2. **R06: four PASS rows.** The only same-build pair is `RUN-20261025-1210-C3.0.75-b3z1-s1` at 25 Oct 12:29:10 and `RUN-20261025-1349-C3.0.75-b3z2-s1` at 14:09:47, both civil 3.0.75+2c805a39 / struc 1.0.123+4af3f37d / mgr 1.1.75+2c805a39. This supports only the text subset described below, historically on 3.0.75.
   3. **R06's other sessions:** `RUN-20261026-0446-C3.0.77-b4a2-s1`, at 05:40:13, on the 3.0.77 composite key; `RUN-20261026-0542-C3.0.78-b4c1-s1`, at 07:06:05, on the current key. Neither has a second session on its build. Four across builds must not be reported as four on one build.
   4. **Runs required:** one more separate PASS session on the current composite build for each unchanged case would meet only the two-session condition. Neither becomes whole-item accepted through that alone. Applying the required case edits changes the hash: each revised case then needs two fresh PASS sessions on the installed build and appropriate red evidence.
6. **Reds, exact current variant hashes.** Each variant has four FAIL rows, all `from_check true`, with `variant_of` correctly naming R04 or R06. For each variant the sessions are b3z1-s1, b3z2-s1, b4a2-s1 and b4c1-s1, with the full run prefixes, times and composite builds in items 3 and 5. No crash, timeout or E_FAIL is being counted as a red.
   1. **R04_SAVE_BROKEN is a true red.** Only check 4, `copy-unchanged $copy0`, fails. Saved copy hashes versus baseline `34BBE37C2EA4` are b3z1 `DE9F338DD743`, b3z2 `AD15858C86AA`, b4a2 `95C1524BED34`, b4c1 `070D37883E7C`; the written time changes too. The relink, recover, Close and folder checks pass. The current-build save occurred at 05:51:18. This proves detection of a real driver save, not that CE itself misbehaved.
   2. **R06_BROKEN is a weaker flipped red.** Both checks fail in all four reports: the variant demands CONFLICT and Civil v9.9.9 while the healthy window shows neither. It changes expectations, not installed modules. It demonstrates that the Civil-version and CONFLICT comparisons can reject wrong expectations; it does not simulate a clipped window or exercise every other check's failure path.
7. **Whole daily-tool cards and gap-plan items accepted from this review ON THE INSTALLED BUILD: 0; on any build: 0.** This is a contribution from these two cases, not a recount of other reviewers' cases.
   1. **D18 / UX-STD-03 / gap-plan section 2 item 18, included in section 3 item 7:** not counted on any build. CDREBUILD is absent; today's R04 hash also has no same-build PASS pair.
   2. **C12 About CE Suite:** not a D-number and not one of section 3 item 7's daily-tool list. It is an additional pack requirement after section 2. No whole C12 acceptance on any build from R06; the three-suite version subset has historical 3.0.75 evidence only.
8. **Bugs that may be written "FIXED (Claude-accepted, Civil 3.0.78, 26 Oct 2026)": none.** R04's BUG and PROVES_BUGS are empty. R06's BUG is empty and it has no PROVES_BUGS line. No suggested FIXED entry is justified; never close or delete an entry (D6).
   1. **BUG-852:** C12 mentions it, but R06 runs with all three modules installed. It cannot establish the missing-module ribbon-button behaviour.
   2. **BUG-090:** clipping and exact source identity are not proven by R06. The existing D8 report records lower-row clipping on 3.0.78. It cannot be marked fixed here.
   3. **BUG-1087:** heading contrast requires a look. D8 says the heading was readable in its light window; that is not R06 evidence of both light and dark.
   4. **BUG-1086:** R06 has no previous drawing command followed by U. D8's unexpected COMMANDMACROSCLOSE echo is explicitly not proof of a clean undo stack. No acceptance here.

## How I applied the four conditions

1. **Nothing seen on screen:** R04's file checks qualify. R06's version values and closing can be read as text; C12's visibility, lower rows, heading and help cannot be accepted that way.
2. **Two sessions on one build:** R04 lacks a pair for its current text anywhere. R06 has a 3.0.75 pair only. Both lack a current-build pair.
3. **Red before green:** R04 has a real saved-copy red; R06 has a flipped red. Both have current-build red rows, but these do not supply a missing PASS session.
4. **Compared with the whole card:** the line-by-line comparisons below leave D18 incomplete and C12 dependent on visual evidence and stronger row checks. No engineering choice is being accepted.

## The cases

1. **R04: CE never saves the drawing (D18, UX-STD-03).** Verdict: **PARTIAL (part only: unchanged drawing file after PIT, CD, CDSYNC, CDRECOVERINVERTS and PITSCHEDULE, while the copy remains open).** Hash **443604166CC0**. This is supported behaviour, not an accepted current-hash subset yet: it lacks two sessions on the same build. No review file written.
   1. **Asks met:** the B3FIX item 3 true red still exists and fails for the right reason. PITSCHEDULE opens and closes (case lines 25-28; assertion line 34). The stale claim that no red is possible has been corrected in line 1.
   2. **Card comparison:** D18 lines 547 and 551 require before/after hash and written time. SETUP-P8 line 6 captures `$copy0` before PIT and CD; case line 35 checks both hash and time, as the implementation confirms. D18 line 553 permits no new file or only the copy's PRE_C7 backup; line 36 checks added filenames and the two current-hash passes actually report no additions. The broad backup pattern would also allow another filename containing `_PRE_C7_`; it is not a precise check of the copy-name prefix.
   3. **Still missing:** D18 step 2, line 548, names CDREBUILD; assertion 2, line 552, requires both no-save sentences. R04 has no CDREBUILD step or assertion. Its lines 1 and 18 explicitly admit that omission. The changed hash does not mean B3FIX's missing lines were added.
   4. **Exact additions for the case owner:** first record CDREBUILD's prompts on a test copy; their answers are not established by this review. Following D18's sequence, after CDSYNC and before CDRECOVERINVERTS add `type "CDREBUILD" -Force -TimeoutSec 120 -> $rb`, then the observed prompt answers, then `wait`. Add ASSERT `contains $rb "it does not save the drawing itself"` and `history has "It does not save the drawing."`. If the first sentence appears in a later prompt reply, bind that reply and check it as well; do not assume the first call contains the whole exchange. Add the same route and assertions to R04_SAVE_BROKEN before its final `save-copy`.
   5. **Required claim wording:** replace the relevant NOT_AUTOMATED line only when the route is proved. Until then retain the explicit limitation. After the route edit, obtain two fresh sessions of the new hash on Civil 3.0.78 (or the then-installed build), and a matching red. One additional run of today's text would establish its narrow subset only, not D18.
   6. **Limits:** the case tests whether these commands saved the file, not whether every recovered level or schedule value is correct. Its final read is before AutoCAD closes; the 24 Oct suggestion to check the file again after closing is not covered by R04's assertions. D18 itself asks for the read before END, so this is a limit on the broad title, not another invented card requirement. Nothing here needs a Codex picture.

2. **R06: About CE Suite (spec C12).** Verdict: **NEEDS CODEX LOOK.** Hash **6D94611EC40B**. The case can carry only the three suite release-number comparisons, absence of CONFLICT/Not loaded, and successful Close/idle text checks. That subset has two sessions on 3.0.75, one on 3.0.77 and one on 3.0.78. It cannot carry all of C12 alone. No review file written.
   1. **Asks met:** PLAN_ITEM now names C12 (line 4). The requested AutoCAD and .NET checks were added (lines 30-31), and the flipped red exists. The window capture and look note exist in b4c1. The example v3.0.70 in lines 12 and 14 is historical wording, not the comparison baseline.
   2. **C12 step 1 and assertion 2 (card lines 276, 281):** R06 lines 25-27 compare the three suite rows with the DLL-derived values. Current evidence is Civil v3.0.78, Structural v1.0.124 and Manager v1.1.78. Runner line 71 uses Get-CaseShortVersion: these are release numbers, not the full commit-bearing ProductVersions. It does not prove exact source/deployment identity requested by BUG-090.
   3. **C12 assertion 1 (line 280) is not fully asserted:** R06 line 30 searches any control for AutoCAD. All four PASS reports give `AutoCAD tools for Creative Engineering` as its successful match. Delete the actual AutoCAD version row and this assertion could still pass. Line 31 finds `.NET 10.0.12`, but does not require a Runtime label/value pair. C12 step 3 also asks for hover-help evidence; R06 neither hovers nor retains that tooltip.
   4. **Exact stronger assertions for this host:** add `control-next $about "AutoCAD" "26.0"`, `control-next $about "Runtime" ".NET 10.0.12"` and `control-text $about has "Hover over a version to see which file was loaded."`. The existing saved selftest1b About dump establishes those row labels, displayed AutoCAD format and help sentence; current session evidence reads AutoCAD `26.0s (LMS Tech)` and current R06 reads `.NET 10.0.12`. Re-read and compare host/runtime evidence when the host changes; these literals are not portable defaults. These additions do not prove tooltip contents or visibility. Retain actual loaded-file hover help in the separate look evidence; do not invent a hover runner verb.
   5. **C12 assertion 3 (line 282):** R06 lines 20-22 and 33-34 close the window and wait; b4c1's wait step reports idle and its final window list lacks About. Line 32 only checks that a picture exists, is nonblank and is not a duplicate. It cannot establish that text is readable. The lower rows, Close button placement, heading contrast and help remain the Codex look portion.
   6. **Exact look instruction to add to the handoff:** `On the installed build, read the whole About CE Suite window: all three suite versions, the complete AutoCAD and Runtime values, the heading and loaded-file help; then confirm Close leaves AutoCAD idle. Record clipping as FAIL, even when the text dump contains the hidden words.` The separate verifyE6_cur brief covers this area. This report does not execute that brief.
   7. **Existing adverse visual evidence:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_D8_20261026_0623.md`, item 6, reports D8-01 FAIL on Civil 3.0.78 / Manager 1.1.78: the three suite values readable, AutoCAD only top fragments, Runtime unreadable. This is a report I read, not a picture I judged. The carpark's citation says the report is under areas; that path is absent, but the local report above exists. A later successful look must resolve this finding; another text PASS cannot.
   8. **Runs and red limits:** one more current-build session would complete the unchanged text subset's pair only. After stronger assertions change the hash, two fresh PASS sessions are needed. Extend the flipped variant with wrong expectations for the new row checks, for example `control-next $about "AutoCAD" "0.0"` and `control-next $about "Runtime" ".NET 0.0.0"`; record their intended check failures. They remain flipped reds, not broken installed modules.

## Things the desk should know first (RULES 6.2)

1. **The old R04 review is obsolete.** It says no red and no PITSCHEDULE. Both now exist. It names hash E7168D28488F, not today's 443604166CC0. B3FIX's PARTIAL conclusion still applies because CDREBUILD remains absent.
2. **The old R06 review is obsolete in its detail.** It names C783FF31387F, not today's 6D94611EC40B; the relabelling, two word checks and red have been supplied. The NEEDS CODEX LOOK conclusion still holds, and the AutoCAD word check is weaker than its name suggests.
3. **B3FIX's R04 red evidence repeats the wrong saved hash for its second run.** b3z1 is DE9F338DD743; b3z2 is AD15858C86AA, not DE9F338DD743 again. Both really fail the same file-change assertion; the true-red conclusion is unchanged.
4. **D18's draft headline says its route is fully proven.** That is not whole-card acceptance by the current R04: CDREBUILD and its two sentences remain untested by this case. The old gap-plan statement that the acceptance rule awaits Tim is superseded by his 24 Oct decision.
5. **The 07:10 leads are confirmed for these hashes.** R04 has two PASS sessions across two builds; R06 has four across three builds. Neither has two on 3.0.78. No current-hash main-case FAIL was found.
6. **The setup hash gap remains.** Get-CaseIndependentReview checks an anchored READY verdict, exact case hash and non-builder REVIEWER line, but not SETUP-P8. Neither existing review file qualifies anyway. I leave both untouched, as instructed.
7. **The b4c1 s1 end warning is not an R06/R04 red.** The report says AutoCAD had gone and all four settings fingerprints matched; another holder had acquired the lock when end checks ran. The listed assertion failures, not that warning, are the variant reds. I did not inspect or acquire any lock.

## What I read

1. **Rules and plan:** `C:\TimOS\RULES.md`, `C:\TimOS\ROUTER.md`, the 24 Oct acceptance decision, START_HERE/MASTER_PLAN context, the gap plan section 2 item 18 and section 3 item 7, D18 and C12 in their named card documents.
2. **Review history:** complete `RUNNER_CASE_REVIEW_B3FIX_2026-10-25.md` and `RUNNER_CASE_REVIEW_B3B_2026-10-25.md`; every R04/R06 section found by searching all `RUNNER_CASE_REVIEW_*.md`, including `RUNNER_CASE_REVIEW_2026-10-24.md` and `RUNNER_CASE_REVIEW_HARDEN_2026-10-25.md`. These are the four matching files at review.
3. **Cases and gate:** both complete cases, both complete matching variants, SETUP-P8, existing R04/R06 review files, R16's six-line example, Get-CaseIndependentReview lines 115-125 and relevant assertion/version handlers. I read scripts as text only.
4. **Evidence:** ledger.json; b3z1, b3z2, b4a2 and b4c1 JSON and Markdown entries for these cases, checks, sessions and build headers; install logs C-65, C-67, C-68 and S-44; live bundle folder metadata and all nine DLL ProductVersions.
5. **Related About context:** BUG-852, BUG-090, BUG-1086 and BUG-1087 entries; b4c1 R06 look note; saved selftest1b About text dump for row selectors; D8 item 6 and its build context; the short verifyE6_cur handoff for scope only, not as an instruction to run.

## What I did NOT check

1. **No live work:** no AutoCAD launch or interaction, case/runner/driver invocation, lock, settings guard, build, install, code test or sub-agent.
2. **No visual acceptance:** I did not open or judge a picture. D8's visual result is attributed to its saved report. I did not carry out verifyE6_cur or inspect all scaling/theme combinations.
3. **No CE source audit or engineering acceptance:** no internal saving implementation, calculation, council value or sizing choice judged. No source commit identity was inferred from a displayed short version.
4. **No fresh settings, drawing or historical bundle verification:** run evidence supplies those historical observations. Live ProductVersions and folder metadata were read directly; historical install times come from their logs. No case outside R04/R06 was re-reviewed.

## Files written

1. **Report only:** `C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr01.md`. Only this path is authorised for staging, committing and pushing on CE_PLAN main. No review.txt created or replaced; no bug, ledger, case, setup, variant, settings, queue or desk log changed.

## Summary

1. **Zero whole cases accepted.** R04 remains PARTIAL: CDREBUILD and its two no-save sentences are absent, despite a valid saved-copy red. R06 NEEDS CODEX LOOK; its AutoCAD word check can match the heading, and D8 already reports clipped lower rows on 3.0.78. Each has one current-build PASS session. No bug may be newly written fixed. Both old review files remain untouched. The report gives exact additions and required sessions; nothing was run.