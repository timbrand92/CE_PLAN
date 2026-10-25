# Runner case review, cx_cr06: R24, R25 and R26 (Codex independent review, Mon 26 Oct 2026)

Written Mon 26 Oct 2026, about 08:00 to 08:15 Melbourne, by Codex (GPT-6). I read the rules, acceptance decision, both model reviews, earlier case findings, current cases and variants, cards, related bug entries, installed DLL versions, ledger rows and run reports. I ran no AutoCAD, runner, case, build or test; changed no case, setup, settings, ledger or bug entry; and used no subagents. This report is the only deliverable written.

## FOR TIM

1. **None of these three cases is ready to accept.** No daily-tool item or bug may be newly counted from this review, on Civil 3.0.78 or an older build. The installed Civil version is the one the desk expected.
2. **The metre-drawing check needs a proper starting drawing and a known pit size.** It changes the units after opening the drawing. A pit then spans 1900 drawing units, but that does not establish what happens in a drawing correctly prepared in metres.
3. **The Pit Schedule opens and closes in the old runs.** That does not prove P2 comes before P10, that Excel export works, or that the window is readable. Those are separate checks still needed.
4. **The survey check covers only an empty survey and cancellation.** It records the sentence rejecting a pit picked instead of a survey, but does not check that sentence. It never places a spot level or imports survey levels.
5. **The desk's claim that these cases were never independently reviewed is wrong.** Opus reviewed all three on 24 October. The same gaps remain. Any choice of a suitable engineering pit size still needs Tim's word; I have made no sizing decision.

---

## ANSWER FIRST

1. **Counts (one main verdict per case, three cases):** CLAUDE-ACCEPTED-READY: **0**; NEEDS BROKEN VARIANT: **0** as the main verdict; NEEDS STRONGER ASSERTION: **1**, R24; PARTIAL (part only): **1**, R26; NEEDS CODEX LOOK: **1**, R25; FAIL = real fault: **0** established; NEEDS RUNS: **0** as the main verdict. All three also lack two PASS sessions on the installed build. R24 also lacks a qualifying red.
2. **Build read directly from the live files:** every runtime lane was checked separately with Get-Item / VersionInfo. The following are ProductVersion strings, not document claims.
   1. **Civil:** Legacy, Modern and Net8 each read `3.0.78+d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`.
   2. **Manager:** Legacy, Modern and Net8 each read `1.1.78+d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`.
   3. **Structural:** Legacy, Modern and Net8 each read `1.0.124+3a3caac5db7687f1b5d1a6e09571976c52b2b05a`.
   4. **Live Contents creation times:** Civil 26 Oct 05:41:30; Manager 26 Oct 05:41:31; Structural 25 Oct 17:41:13. All times in this report are Melbourne AEDT, UTC+11. These are the installation boundaries evidenced by the bundle folders.
3. **Historical installation intervals checked on disk:** the Civil backup DLL versions and their Contents creation times identify 3.0.73+5467f705 at 24 Oct 11:35:55; 3.0.74+a15b414c at 24 Oct 17:19:58; 3.0.75+2c805a39 at 25 Oct 03:33:02; 3.0.77+0d885094 at 25 Oct 20:42:01; then current 3.0.78 at 26 Oct 05:41:30. The relevant 3.0.73 runs finish before 17:19:58 on 24 Oct, and the 3.0.74 runs finish before 03:33:02 on 25 Oct. None of the five relevant runs straddles either boundary.
4. **Ledger audit:** the array held 484 rows when read. Eleven concern these cases or their variants: six current base-case rows, three current variant FAIL rows, and two obsolete R25 PASS rows. The following is every relevant row, grouped only where identical facts are stated explicitly.
   1. **Build key A:** `civil 3.0.73+5467f705 / struc 1.0.123+4af3f37d / mgr 1.1.73+5467f705`. Build key B: `civil 3.0.74+a15b414c / struc 1.0.123+4af3f37d / mgr 1.1.74+a15b414c`. Neither equals the installed combination, which has Civil 3.0.78, Structural 1.0.124 and Manager 1.1.78.
   2. **n1, four rows:** run `RUN-20261024-1627-C3.0.73-n1`, session `RUN-20261024-1627-C3.0.73-n1-s1`, at 24 Oct 16:37:50, key A. R25 PASS has obsolete hash `3A604E2B72D6536A44F1E270630881363BDF5C2561CA0DBC9EE39E04D9D09A0A` and counts for nothing. R26 PASS has its current hash. R25_BROKEN and R26_BROKEN FAIL each have their current hash, correct variant_of, and from_check true.
   3. **n3, two rows:** run `RUN-20261024-1646-C3.0.73-n3`, sessions `RUN-20261024-1646-C3.0.73-n3-s1` and `RUN-20261024-1646-C3.0.73-n3-s2`, both rows at 24 Oct 16:57:19, key A. R24 FAIL in both, current hash, from_check true. No later row overturns either failure. The report contains R24_BROKEN BLOCKED, not a red; there is no R24_BROKEN ledger row.
   4. **n4, two rows:** run `RUN-20261024-1657-C3.0.73-n4`, session `RUN-20261024-1657-C3.0.73-n4-s1`, at 24 Oct 17:01:56, key A. R25 PASS has the same obsolete hash as n1, so excluded. R26 PASS has its current hash.
   5. **w1, two rows:** run `RUN-20261024-1745-C3.0.74-w1`, session `RUN-20261024-1745-C3.0.74-w1-s1`, at 24 Oct 17:54:05, key B. R25 PASS current hash. R25_BROKEN FAIL current hash, variant_of R25, from_check true.
   6. **w2, one row:** run `RUN-20261024-1754-C3.0.74-w2`, session `RUN-20261024-1754-C3.0.74-w2-s1`, at 24 Oct 17:58:58, key B. R25 PASS current hash.
   7. **Counted historical PASS pairs:** R25 w1-s1 plus w2-s1 on key B; R26 n1-s1 plus n4-s1 on key A, with the full identifiers above. Both pairs have distinct session_id values and no current-hash base-case FAIL on their respective build keys. These are evidence pairs, not acceptance awards.
   8. **Run intervals from JSON headers:** n1 16:27:44-16:37:50; n3 16:46:23-16:57:19; n4 16:57:20-17:01:56; w1 17:45:13-17:54:05; w2 17:54:06-17:58:58, all 24 Oct. The session records confirm separate starts. R24's two sessions are a main run and a fresh-session rerun within n3.
   9. **Installed-build deficit:** R24, R25 and R26 each have zero current-hash PASS sessions on Civil 3.0.78, so each needs **two further separate PASS sessions on the installed build**, after its other blockers are resolved. Merely repeating the existing incomplete text would not earn acceptance.
5. **SHA-256, computed with Get-FileHash -Algorithm SHA256:** all counted rows match the corresponding current file exactly. Case and variant files sit under `C:\Lisp Files\_ACAD_DRIVER\cases`, with variants in `variants`.
   1. **R24:** `1BECEC091BED9D1AC0A99509DA615B541FE096A186F81811854EBC5BD3587231`.
   2. **R24_broken:** `2AB1EF563FC9F164FDAABE3EFABF08DBFEE9FEA5FEBBB0784DD5BDF445FE7E30`.
   3. **R25:** `2DB8A06D260F73E46BAEC306CC6C652A77EB190D5C27E528D9C4DE433B39640D`.
   4. **R25_broken:** `9D5315C4F21C1903D881C3AFF9AAC32D1F868B4D73B8109BD009AEB5B0C8D66C`.
   5. **R26:** `03C9AE48C09787CDC5C3FEBE6FA266CD23A07A9E1EEB17BABDFBBF2440BA8581`.
   6. **R26_broken:** `11AC232E63E68598E6489BD4697B14EA7F3DBCD5B9421F00541510100A16C90F`.
   7. **SETUP files:** none referenced by any of these six files; JSON setup fields are empty. There is therefore no associated setup file to hash. The case hash covers the case text, not the drawing fixture or a future setup file. The review gate itself does not bind a setup hash.
6. **Reds:** R25_BROKEN fails check 1, expecting 26 rows while the window says 27, in n1 and w1. R26_BROKEN fails check 1, expecting Survey: loaded while the command says not loaded, in n1. These are weaker **flipped reds**, not altered CE behaviour. The remaining substantive checks pass on those twins. R24_BROKEN is blocked at esc-prompt because the driver could not give AutoCAD keyboard focus; no assertion failure, no qualifying red.
7. **Whole daily-tool items accepted from this batch ON THE INSTALLED BUILD: 0 of the gap plan's 40. On any build: 0.** This is the contribution of these three cases, not a recount of the whole suite.
   1. **D21 / gap item 21, UX-SCHED-06:** not accepted on either basis. R25 neither creates P8-P10 nor checks ordered rows and groups.
   2. **D23 / gap item 23, UX-SCHED-02:** not accepted on either basis. R25 never exports Excel or reads a workbook.
   3. **D26 / gap item 26, UX-SURV-03:** not accepted on either basis. R26 never runs CDSL; survey intake is only its prerequisite.
   4. **Other named checks in gap plan section 3 item 7:** none newly covered in full. R24 is not a daily-tool card, and changing INSUNITS is not the gap plan's separate import-units check either.
8. **Bugs that may be written "FIXED (Claude-accepted, Civil 3.0.78+d8840a09, 26 Oct 2026)": none.** Suggested desk wording: "R24-R26 independently reviewed, 26 Oct 2026: no new whole bug acceptance; fixture, coverage and window-look gaps remain. No passes on installed Civil 3.0.78." Never close or delete an entry (D6).
   1. **T1 not yet:** BUG-270, 271 (search/relink reaches); 293, 323 (Edit Pipe grade and length); 309 (schedule-edit grade); 317 (stored scaled-pit size); 328 (grade-locked inverts); 330, 331, 393 (multiple unit-sensitive routes). R24 performs none of those complete reproductions. A pit bounding box alone is not their expected behaviour.
   2. **S1 not yet:** BUG-385, 386, 408, 420, 463, 783, 791, 792, 1011 require cell edits, deletion, number validation, precision or Stop overriding. R25 edits no cell.
   3. **S2 not yet:** BUG-098, 376, 694, 780, 784, 786, 965 require identity comparison, actual inlet/outlet cells, breakline edits, merged inlet mapping, non-P names, changed row groups or refreshed twin sizes. R25 checks only that Pit P3 exists, not its values or order.
   4. **S3 not yet:** BUG-246, 779, 785, 807, 869 require protected-cell status, moving a placed table, depth refresh, rounding or pit-floor depth. R25 places and refreshes no table and reads no depth.
   5. **V1 not yet:** BUG-134, 142, 144, 699-709 require actual survey intake, approval, outliers, level parsing, units, geometry or source revision checks. R26 selects a non-Xref and cancels. None of those full bug routes runs.

## How I applied the four conditions

1. **Nothing seen on screen:** R24's eventual dimension check and R26's narrow refusal check can be numerical/text checks. R25 expressly claims readable window layout, so needs a Codex look. Engineering suitability of any chosen size is Tim's decision.
2. **Two sessions on one build:** historical pairs exist only for R25 and R26. No case has the pair on the installed build. R24's two standing historical failures remain failures, with cause unestablished.
3. **Red before green:** two flipped-red families exist; R24's twin is blocked. Passing unchanged-data checks on the flipped twins does not demonstrate that those checks detect real changes.
4. **Whole claimed feature:** none qualifies. The line-by-line comparisons and exact changes below govern the verdicts; no acceptance file is written for a subset concealed under a broader PLAN_ITEM.

## The cases

1. **R24: metre drawing pit size (triage T1). Verdict: NEEDS STRONGER ASSERTION. Hash 1BECEC091BED.** This includes an invalid starting condition, not just a missing comparison. No part is accepted, and the evidence does not justify FAIL = real fault.
   1. **Asks met:** none of the B2 review's central ask for a genuine metre fixture is met by this text. Lines 6 and 17 still select DRV15_METRE and set INSUNITS to 6 after opening it. I have not established that no suitable drawing exists anywhere on the PC today; the chosen case route is the finding.
   2. **Against T1 and its bugs:** lines 20-31 place and read one pit. Lines 33-35 check INSUNITS, one block and its bounding box. There is no CD, Edit Pipe, relink, schedule edit, stored size, search reach or grade-lock step. Compare triage line 51 and the T1 bug entries listed in ANSWER FIRST item 8.1. Full T1 coverage is absent.
   3. **Conflicting size claim:** TITLE line 3 says 900 mm / 0.9 drawing units; EXPECTED line 12 and assertion line 35 instead require a 1900 mm / 1.9-unit bounding box. Only C2.CoverLevel is set at line 21. No pit-size control is set or read. The expected size is therefore not tied to a chosen pit size. A 900 mm engineering selection and a block's overall extents need not be the same measurement.
   4. **What failed:** n3 checks 1 and 2 pass, check 3 fails in both sessions. The recorded block has xscale 1 and bbox [-800,-1030,1100,870], width and height 1900, at insertion [150,-80,0]. Its parts include hidden-layer geometry. This proves the measured extents of that block, not a verified visible 900 mm pit outline or a fault on a properly prepared metre drawing.
   5. **Exact header replacement:** `PLAN_ITEM Metre fixture PIT placement and measured dimensions only; not whole triage T1`. Replace the title with `TITLE PIT in a verified metre fixture has the selected pit dimensions in drawing units`. Do not retain the unverified 900 mm claim.
   6. **Exact step change:** remove `v3 setvar INSUNITS 6`; retain `getvar INSUNITS -> $iu` as the first step and `equals $iu "6"` in ASSERT. The runner owner must first supply a registered drawing genuinely saved in metres before CE opens it. Do not just remove the line and reuse an unverified master.
   7. **Exact evidence lines to add:** after opening New Pit, `ui-dump "New Pit" -> $pit_size_before`; in ASSERT, `record $pit_size_before "Selected pit type and dimensions before placement"`. This is evidence collection only. The owner must identify the actual size control, set/read a known size and assert its corresponding measured geometry; no control identifier or engineering number is invented here.
   8. **Then:** replace the bounding-box-only expectation with a check tied to that selected type and dimension. Prove the corrected check fails on an intentionally mis-scaled twin, then obtain two PASS sessions on Civil 3.0.78. Tim's word is needed if a suitable engineering size or design rule is being chosen; arithmetic conversion alone is not a design approval.
   9. **Codex look:** unnecessary for a properly bounded numerical size check; required if the claim includes the visible symbol or text layout. No look performed here. R24_BROKEN's guard refusal is not a substitute for a red.
2. **R25: Pit Schedule reads and closes (claims S1-S3, D21 and D23). Verdict: NEEDS CODEX LOOK. Hash 2DB8A06D260F.** Its numerical/text portion is narrow historical evidence only; it covers no whole claimed card or bug.
   1. **Asks met:** B2 already recognised that opening, reading and closing work. Current lines 20-27 still do exactly that; nothing resolves B2's D21/D23 mismatch. In w1 and w2 all nine reported checks pass, including the record-only ninth check.
   2. **Against D21 lines 617-630:** R25 places no P8, P9 or P10, extracts no ordered row list, checks no P10 position and no LPD/OG/P/CP group order. Its line 17 admits the gap. A 27-row heading and a Pit P3 control can pass in a wrongly sorted window.
   3. **Against D23 lines 674-683:** no Export Excel, save dialog, nonempty file, Checking sheet, headers, plain FIELD wording, window-to-workbook pit comparison or DBMOD check. The unchanged DWG file in line 36 is not the export contract.
   4. **Against its own window claim:** lines 6-7 require Source, Rows, Changes and Placement, legible grid headings, unclipped edges and an accessible Close button. ASSERT lines 31-32 check only Rows and Placement. `picture-ok $pic` verifies an image was produced, not its readability. The narrow close route is evidenced; appearance remains unjudged.
   5. **Exact replacements/additions:** `PLAN_ITEM Pit Schedule opens, shows the row-count header and Pit P3, and closes; window look only; no D21 D23 or S1 S2 S3 acceptance`. Replace TITLE with `TITLE The Pit Schedule shows 27 rows and Pit P3, and closes with Close`. Add `control $psd "Source" exists` and `control $psd "Changes" exists` to ASSERT.
   6. **Exact look instruction to add:** `RIGHT_LOOKS_LIKE Read Source, Rows, Changes and Placement; inspect PIT No., PIT SIZE, IL (Inlet), IL (Outlet), COVER and PIT DEPTH; all text and the Close button are readable and clear of the right and bottom edges.` A Codex reviewer must actually inspect the picture; the line does not grant acceptance.
   7. **Whole-card route:** keep D21 and D23 separate: execute D21 steps 1-5 and all active assertions 1-3, and D23 steps 1-4 with all four assertions. They require placement/order and export support absent from R25. No single extra R25 assertion can cover either whole card.
   8. **Runs and red:** w1/w2 on 3.0.74, flipped 26-versus-27 red in w1 and n1. Two further PASS sessions on Civil 3.0.78 after edits, plus the actual window look, are required. No engineering values are endorsed. No review.txt is earned by these old passes.
3. **R26: CDSURVEY refusal stores nothing (claims V1 and D26 survey half). Verdict: PARTIAL (part only: empty-survey prompts, cancellation, unchanged object count and unchanged DWG file). Hash 03C9AE48C097.** No whole item counts; even the headline refusal assertion remains incomplete.
   1. **Asks met:** the B2 instruction to assert the rejection sentence is still missing. In n1/n4, record lines show `[CE] Please click directly on the survey XREF block.`; no ASSERT checks it. Lines 26-27 only check the initial status and request to pick an Xref.
   2. **Against V1:** triage line 46 asks for actual synthetic survey intake in millimetre and metre hosts, retained levels, outlier handling and refusal storage safety. Lines 18-23 only pick a pit and cancel twice. No Xref, approval, transform, level parser, outlier or source revision is exercised. The V1 bug entries in ANSWER FIRST item 8.5 remain unproved.
   3. **Against D26 lines 743-766:** the command is CDSL, not CDSURVEY. Required checks are existing survey level before the proposed-level prompt, no proposed default, placement of 18.600 on 25DIMS, blank placement, and refusal of 18600 without a new block. R26 runs none of those steps. "D26 survey half" is an incorrect claim, not partial D26 acceptance.
   4. **Exact replacements/additions:** `PLAN_ITEM CDSURVEY wrong-pick refusal and Esc with no survey loaded; V1 part only; not D26`. Add `contains $s1 "[CE] Please click directly on the survey XREF block."` in ASSERT, exactly as B2 asked.
   5. **Strengthen the second invocation directly:** add `contains $s3 "Current survey: Survey: not loaded"` and `contains $s3_e "CDSURVEY cancelled - nothing stored."`. These bind the checks to the second call rather than relying only on aggregate history. Keep the existing count and file-hash checks.
   6. **Limit on "stores nothing":** no survey being reported after the second call is useful evidence. Model-space count 1034 and an unchanged file on disk do not themselves prove every in-memory CE record remained untouched. If that broader guarantee is intended, the owner must add a before/after stored-survey record read and a twin that actually changes it; that reader is not present in this case.
   7. **Runs and red:** current text passed in n1-s1 and n4-s1 on 3.0.73. The n1 flipped red proves the initial loaded/not-loaded text check can fail; the wrong-pick sentence and actual storage mutation have not gone red. After narrowing and strengthening the text, obtain two PASS sessions on Civil 3.0.78 and a red exercising the claimed refusal. Full V1 and D26 still need their own complete cases.
   8. **Codex look:** none for the narrow command-line refusal; any future survey result window must be judged separately. Survey engineering interpretations and design choices require Tim's word.

## Things the desk should know first (RULES 6.2)

1. **The review-history lead is false:** `RUNNER_CASE_REVIEW_B2_2026-10-24.md`, The cases items 15-17, already reviews R24-R26 independently. Later B2FIX explicitly excludes them from re-review; B3FIX/B3B do not supersede those verdicts. I searched every `RUNNER_CASE_REVIEW_*.md` for each ID.
2. **R24's title and expectation disagree:** 0.9 versus 1.9 units, without a size being set or read. Its failures remain real recorded test failures, but their cause is not established as a CE defect. The B2 label "not a valid test yet" is represented here by the permitted verdict NEEDS STRONGER ASSERTION, including the fixture prerequisite.
3. **The triage-to-card labels are misleading:** S1-S3 are not proved by opening a schedule; V1 is not a D26 survey half. D26 is spot-level placement. The case comments partly admit this but their PLAN_ITEM lines still claim the groups/cards.
4. **No PROVES_BUGS line exists in any of these three cases; each BUG line is empty.** Their broad references are in PLAN_ITEM, comments and NOT_AUTOMATED text. Do not turn them into bug-fix credits.
5. **The current-hash counts in the 07:10 leads agree with the rows:** R24 two FAIL, no PASS; R25 two PASS; R26 two PASS, all on older builds. There is no current-build evidence hidden behind an old PASS label.
6. **No associated review files were present.** None is written by this review, and none is deleted. The gate requires a line-start ready verdict, matching case SHA-256 and a REVIEWER not beginning builder; builder-filled REVIEWED_AGAINST cannot authorise acceptance. The gate does not establish whole-card coverage by itself.

## What I read

1. **Rules and method:** complete RULES.md and ROUTER.md; the 24 Oct acceptance decision; complete B3FIX and B3B model reviews; Get-CaseIndependentReview and relevant parser/ledger lines read as text; the six-line R16 review-file example. START_HERE and MASTER_PLAN entry sections identify the CE plan and area.
2. **Previous reviews:** ID searches across every RUNNER_CASE_REVIEW_*.md, the B2 R24-R26 sections and related counts/notes, and cross-references in B2FIX, HARDEN and B3B. No later section resolves the B2 gaps for these files.
3. **Contracts:** D21, D23, D26 in DAILY_TOOLS_TEST_CASES_2026-10-23.md; triage T1, S1-S3 and V1; gap plan section 2 and section 3 item 7; complete BUG_CARPARK entries for all IDs listed in ANSWER FIRST item 8. No C-number card is claimed by these cases.
4. **Evidence:** complete three cases and three variants; their SHA-256 values; all eleven relevant ledger rows; JSON case/assertion/session data and relevant Markdown sections for n1, n3, n4, w1 and w2, with full run names above; live Civil, Manager and Structural DLL ProductVersions in all three lanes and Contents timestamps; historical Civil backup versions/timestamps.

## What I did NOT check

1. **No execution:** no AutoCAD opened or controlled; no runner, case, driver, lock, settings guard, build, install or test invoked. PowerShell was used only for reading evidence, hashing, writing this report and the authorised Git steps.
2. **No visual acceptance:** no R25 picture or live window judged. No pit outline or label position inspected. The saved picture checks are reported evidence only.
3. **No engineering approval:** no council value, standard-derived size, suitable pit size, depth rule or survey interpretation approved. No new fixture authored and no survey imported.
4. **Evidence limits:** no fresh DWG interrogation, no exhaustive PC-wide fixture search, no installed source-code audit, no independent raw CE log investigation and no re-review of other cases. Settings unchanged claims are not independently re-tested here.

## Files written

1. **Report only:** `C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr06.md`. Commit and push are scoped to this report by name; unrelated working files are outside this review.
2. **Review files:** zero. No case meets CLAUDE-ACCEPTED-READY for its current hash.

## Summary

Zero cases, whole daily-tool items or bugs gain acceptance. R24 needs a verified metre fixture and a size-linked check; its old failures do not establish a CE fault. R25 needs a window look and does not prove order or export. R26 is part only, still misses the rejection assertion and is not D26. Historical passes are on Civil 3.0.73/3.0.74; none is on installed 3.0.78. No review files were written and no test was run.
