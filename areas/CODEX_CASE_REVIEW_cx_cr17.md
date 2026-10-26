# Runner case review, cx_cr17: R28 and R31 (Codex independent review, Mon 26 Oct 2026)

Written Mon 26 Oct 2026, about 17:45 to 17:55 Melbourne, by Codex (GPT-6). I read the rules, acceptance decision, both model reviews, earlier sections for these cases, cards and bug entries, installed DLL versions, current case and variant hashes, ledger rows and recorded reports. This was a read-only review: no AutoCAD, runner, case, build, install or test was run; no bug status changed. Only this report and R28's local review note were written.

## FOR TIM

1. **Neither case is accepted on the installed Civil 3.0.79.** Both have two recorded passes on 3.0.78, but no pass on 3.0.79. Each needs two separate AutoCAD sessions on the installed build for the part it checks.
2. **R28 is ready as a narrow check on the older build.** Pick P3, open Profiles, then close it: the recorded check finds P3 and leaves the drawing count unchanged. It does not prove a long section's levels or appearance.
3. **R31 covers only part of BUG-205.** A pipe entered at 10.00 m and 11.00 m gets a question naming both levels; Esc leaves no extra objects. The case never chooses the direction and checks the resulting pipe.
4. **No bug may be newly written fixed, and no whole daily-tool item is added.** The real remaining work is current-build runs and the unanswered direction route. No engineering decision is being made here.

---

## ANSWER FIRST

1. **Counts: one main verdict per case, two cases.**
   1. **CLAUDE-ACCEPTED-READY: 0 on the installed build.** Separately, R28's exact current text is CLAUDE-ACCEPTED-READY for its explicitly limited start-and-close claim on older Civil 3.0.78, under the brief's older-build exception. Its review note says this plainly.
   2. **NEEDS RUNS: 1.** R28: zero current-build PASS sessions; two more on Civil 3.0.79+d3f9c5df, in separate starts. No case edit is required for that narrow claim.
   3. **PARTIAL (part only): 1.** R31: BUG-205's level-naming wording and the tested Esc/count behaviour; supporting evidence that 0.000 is recognised in the question. It also needs two current-build sessions for this part, and further coverage for either whole bug.
   4. **NEEDS BROKEN VARIANT: 0; NEEDS STRONGER ASSERTION: 0 as a main verdict; NEEDS CODEX LOOK: 0 as a main verdict; FAIL = real fault: 0.** The recorded raw arrow wording is a separate known fault, not a FAIL row for either case.
2. **Build checks: actual installation differs from the morning brief.** Read directly at 17:50 Melbourne, using each DLL's VersionInfo.ProductVersion; no DLL was loaded or executed.
   1. **Civil, all three lanes:** Legacy = `3.0.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa`; Modern = the same full string; Net8 = the same full string. Bundle `Contents` created 26 Oct 16:57:58.752 Melbourne.
   2. **Manager, all three lanes:** Legacy = `1.1.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa`; Modern = the same full string; Net8 = the same full string. Bundle `Contents` created 26 Oct 16:57:59.827.
   3. **Structural, all three lanes:** Legacy = `1.0.124+3a3caac5db7687f1b5d1a6e09571976c52b2b05a`; Modern = the same full string; Net8 = the same full string. Bundle `Contents` created 25 Oct 17:41:13.577.
   4. **Location:** all three bundles are under `C:\Users\TimothyBrand\AppData\Roaming\Autodesk\ApplicationPlugins`; DLLs are under each bundle's `Contents\Win64\Legacy`, `Modern` and `Net8` folders. These are installed-file versions, not a claim about any currently running AutoCAD process.
3. **Install boundaries checked from actual retained bundles.** Creation times are the available installation markers, not a claim to know the exact instant the last file was copied. Every counted session is well clear of each boundary.
   1. **Civil 3.0.75 / Manager 1.1.75:** full suffix `2c805a39733ea4649b4273f1f425a37cda463046`; retained `PRE_2c805a39_20261025-204100.backup` Contents created 25 Oct 03:33:02.025 / 03:33:02.891. Next Civil/Manager install: 25 Oct 20:42:01.593 / 20:42:02.444. The counted 3.0.75 sessions end by 15:20:35, also before Structural changed at 17:41:13.577.
   2. **Civil 3.0.77 / Manager 1.1.77:** full suffix `0d8850949cb764e4b3af36f99276b74312584ce5`; retained `PRE_0d885094_20261026-054029.backup` Contents created 25 Oct 20:42:01.593 / 20:42:02.444. Next install: 26 Oct 05:41:30.579 / 05:41:31.142.
   3. **Civil 3.0.78 / Manager 1.1.78:** full suffix `d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`; retained `PRE_d8840a09_20261026-165657.backup` Contents created 26 Oct 05:41:30.579 / 05:41:31.142. Next install: current 3.0.79 / 1.1.79 at 16:57:58.752 / 16:57:59.827.
   4. **Structural 1.0.123:** retained `PRE_4af3f37d_20261025-174012.backup` Contents created 24 Oct 12:42:11.855; all three DLLs read `1.0.123+4af3f37d7da3684c6d7179a65633aee40372c5a0`. Replaced by 1.0.124 on 25 Oct 17:41:13.577. No counted run crosses this change either.
4. **Hashes: computed myself with Get-FileHash -Algorithm SHA256.**
   1. **R28:** `7F29403F16E7605D4F7C05737A2427581935C688B007D359044F9BF2D3CBF852`.
   2. **R28_BROKEN:** `E8665FBDA33C1B1C3C9AF6B9E4C139C68EAC7254E158FCE204EF4CE37A78C076`.
   3. **R31:** `FF6655B93D19F628ECED9D159EE315CE1FA6905A9CEB845D24D33B2A7FFC3300`.
   4. **R31_BROKEN:** `E727EA612158573F625A702A4B2C028C88608DC786A007C8E985F015D86746C7`.
   5. **SETUP: none to hash.** Neither case nor either variant declares SETUP. The parser defaults to an empty setup and the inspected report cases also have empty setup fields. The shared-setup hash gap noted in earlier reviews does not apply to these four files.
   6. **Existing review notes:** both named the exact current case hash when read. R28's note is replaced with this review's narrower build statement; R31's existing matching note is left untouched because this review's main verdict is PARTIAL. No variant review file is touched.
5. **Ledger: 602 rows in the array at the evidence read; 21 rows concern these cases and variants.** Thirteen current-case PASS rows, two current-variant FAIL rows, and six obsolete-text rows. Every row counted below has the full matching current hash; there are no current-case FAIL rows on any recorded build, and no row for either case on Civil 3.0.79.
   1. **Build strings are compared as complete triples.** B75 = `civil 3.0.75+2c805a39 / struc 1.0.123+4af3f37d / mgr 1.1.75+2c805a39`; B77 = `civil 3.0.77+0d885094 / struc 1.0.124+3a3caac5 / mgr 1.1.77+0d885094`; B78 = `civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09`. The runner abbreviates DLL commit suffixes to eight characters; these agree with the full retained DLL versions. None equals installed B79.
   2. **R28, B75 pair:** `RUN-20261025-1508-C3.0.75-b3bd1-s1`, at 25 Oct 15:16:39; `RUN-20261025-1516-C3.0.75-b3bd2-s1`, at 15:20:35. Both PASS. Session start/end: 15:08:12-15:16:39 and 15:16:48-15:20:35.
   3. **R28, B77 pair:** `RUN-20261025-2118-C3.0.77-g77a4-s1`, at 25 Oct 21:21:38; `RUN-20261025-2221-C3.0.77-g77b4-s1`, at 22:24:15. Both PASS. Session start/end: 21:18:56-21:21:38 and 22:21:09-22:24:15.
   4. **R28, B78 pair:** `RUN-20261026-1103-C3.0.78-g78a3-s1`, at 26 Oct 11:05:39; `RUN-20261026-1153-C3.0.78-g78b3-s1`, at 11:56:09. Both PASS. Session start/end: 11:03:12-11:05:39 and 11:53:26-11:56:09. Six valid PASS sessions total: two each on B75, B77 and B78; zero B79.
   5. **R31, B75 pair:** `RUN-20261025-0607-C3.0.75-pA1-s1`, at 25 Oct 06:22:19; `RUN-20261025-0655-C3.0.75-pB1-s1`, at 07:09:54. Both PASS. Session start/end: 06:07:59-06:22:19 and 06:55:31-07:09:54. Extra matching PASS: `RUN-20261025-0446-C3.0.75-p3b3a6-s1`, at 04:55:32, session 04:46:25-04:55:32.
   6. **R31, B77 pair:** `RUN-20261025-2121-C3.0.77-g77a5-s1`, at 25 Oct 21:30:03; `RUN-20261025-2224-C3.0.77-g77b5-s1`, at 22:32:48. Both PASS. Session start/end: 21:21:44-21:30:03 and 22:24:21-22:32:48.
   7. **R31, B78 pair:** `RUN-20261026-1105-C3.0.78-g78a4-s1`, at 26 Oct 11:10:52; `RUN-20261026-1156-C3.0.78-g78b4-s1`, at 12:02:09. Both PASS. Session start/end: 11:05:45-11:10:52 and 11:56:13-12:02:09. Seven valid PASS sessions total: three B75, two B77, two B78; zero B79.
   8. **Separate starts and installation windows:** every listed session has a distinct ID, a clean recorded end and zero AutoCAD processes left according to its report. All starts, finishes and ledger at times fall inside the relevant install interval. I did not infer two sessions from two cases within one start.
   9. **Excluded older text:** R28 PASS rows n2 and n5 on 24 Oct use `0F760B331F7F...`; b2d2 and b2d3 on 25 Oct use `3A778E5F30F1...`. R28_BROKEN rows n2 and b2d2 use `9CC70A0B373F...` and `928917E7AF5A...`. All six count for nothing in this review.
6. **Reds: two, both genuine input changes, neither a flipped expectation.**
   1. **R28_BROKEN:** b3bd1, same B75 session as item 5.2, at 25 Oct 15:16:39; variant_of R28, result FAIL, from_check true, current variant hash. Checks 2, 3 and 4 fail: pick `52200,-26800` is refused with `Select a CE pit block.`, no Profiles window and no P3 field. Count remains 1034 and file hash unchanged. No crash or tool error is being counted as the red.
   2. **R31_BROKEN:** p3b3a6, B75, at 25 Oct 04:55:32; variant_of R31, result FAIL, from_check true, current variant hash. Levels 11.00 then 10.00 produce no direction question or cancellation sentence; count becomes 1039 instead of 1034. All three assertions fail for the intended reason.
   3. **Limit:** neither current variant has a recorded red on B77, B78 or B79. The brief permits the matching deliberately broken variant evidence from the older build; this does not manufacture current-build PASS sessions.
7. **Whole daily-tool cards and gap-plan items accepted by this review: zero on the installed build; zero on any build.** This is this two-case contribution, not a recount of unrelated cases.
   1. **C41 / quick MOVE:** no contribution. C41 is moving a pit, linked labels, no new window and one U. R28 does not MOVE a pit at all. The brief's C41 neighbour label must not become a C41 acceptance claim.
   2. **D01 / PIT and CD continuation:** no contribution. R31 neither places a pit nor checks the continuation, retained objects, U and outcome-log requirements of D01.
   3. **D04 / Esc at CD's third point:** no contribution. R31 sends the final Enter, opens New Pipe and cancels later at the direction question. D04 requires Esc before that window opens, the cancellation outcome and the contrast pipe's two vertices.
   4. **Q1 CDPROFILE start and N1 direction wording:** these are not whole items in section 3 item 7 of the gap plan. Starting Profiles is not the drawn long section; asking a direction question is not the complete direction feature.
8. **Bugs that may be written "FIXED (Claude-accepted, Civil 3.0.79+d3f9c5df, 26 Oct 2026)": none.** No FIXED wording is authorised by this review. Never close or delete an entry (D6).
   1. **BUG-205: not yet.** The question names levels, but choosing Use level direction, the saved flow and the absence of an uphill warning are not checked. Suggested desk wording: "R31 proves the level-naming wording and tested Esc route only on Civil 3.0.78, g78a4-s1 and g78b4-s1, current hash FF6655B93D19; true red R31_BROKEN on Civil 3.0.75. Direction after the choice remains unproved; no 3.0.79 run. Status stays OPEN."
   2. **BUG-686: not yet.** The zero-level question runs, but no arrow is drawn after choosing the direction. Its expected behaviour is an arrow following known levels, including 0.00.
   3. **BUG-682: not claimed and not proved.** Cancellation in open space does not exercise restoration of an existing polyline, moved or upsized pit, twin barrels or schedule row.
   4. **Q1 bugs:** BUG-542, BUG-599, BUG-757, BUG-758, BUG-759, BUG-761, BUG-762, BUG-763, BUG-768 and BUG-769 remain outside R28's explicit claim. No profile is placed and no datum, grade, depth, cover or row value is checked.
   5. **BUG-389 family:** the full R31 records still contain raw `\U+2192` on B78. This confirms the earlier wording observation only; I did not execute its CDCHECK route or establish its state on B79.

## How I applied the four conditions

1. **Nothing seen on screen:** the limited checks use control text, command history, counts and file hashes. They cannot accept appearance. A finished profile, its preview and label placement still need a Codex look.
2. **Two separate sessions on one build:** met historically on B75, B77 and B78 for both current case texts. Not met on installed B79. Historical pairs are never combined across build strings.
3. **Red before green:** met by the two current-hash variants on B75, each from an intended failed check. Their limits are stated above.
4. **Compared with the card or bug and full coverage:** R28 covers its explicitly limited start-and-close claim, with no whole Q1 claim. R31 covers only part of BUG-205, so its main verdict is PARTIAL under this brief's whole-item rule.

## The cases

1. **R28: CDPROFILE start (Q1; not C41).** Verdict: **NEEDS RUNS** on installed Civil 3.0.79; **CLAUDE-ACCEPTED-READY** for its narrow text claim on older Civil 3.0.78 only. Hash **7F29403F16E7**. Review note replaced under the explicit older-build exception.
   1. **Asks met:** B2 item 19 required an accepted pick; B2FIX item 3 required reading P3. Case lines 19-23 zoom, pick and dump Profiles; assertions 30-33 require the start prompt, no refusal, the window title and P3 immediately after the instruction text. B3B item 3 accepted these exact lines. Both B78 reports match P3, not just a window title.
   2. **Against the stated claim, line by line:** line 12's prompt maps to 30; accepted pick to 31; Profiles window to 32; title line 3's P3 to 33; no window left to 34; unchanged count to 35; unchanged disk file to 36. Both reports read 1034 before and after and equal fixture hashes. Lines 37-40 are records, not extra assertions.
   3. **Against the source item:** triage A1 Q1 is review and drawn long-section values. Lines 11 and 14 explicitly exclude those values and bugs. C41 assertions 1-3 require MOVE, linked positions and U; none is present. This case is useful as the first step only and earns no whole-card credit.
   4. **Exact remaining action:** no runner line needs adding for the current narrow claim. Run the unchanged hash in two separate starts on `civil 3.0.79+d3f9c5df / struc 1.0.124+3a3caac5 / mgr 1.1.79+d3f9c5df`, after the install. This review ran neither. If the installed build changes again, target the then-installed triple.
   5. **Small points for the next edit:** line 15 is false now: the start pit is read. Replace it with `NOT_AUTOMATED Only the start pit text is read; route choices, preview, placement, updates and drawn profile values are not checked.` Line 1 overstates the old view explanation: the B2FIX review said the previous view was not read. Correcting either comment changes the hash and requires new evidence.
   6. **Optional stronger check:** replace line 33 with `matches $pd "name.:.Choose a start pit and route\. Preview before placing or updating the profile\..[^{]*\},\{.type.:.Text.,.name.:.P3.,"` and copy it to the variant. The current pattern also permits P30; the recorded field is P3. A further variant selecting a different verified pit would distinguish a selected pit from a constant P3 default; no such red exists.
   7. **Codex look / engineering:** Profiles layout, preview and drawn long section need a look. Design datum choices and engineering values need Tim's word where judgement is involved. Neither is accepted here.
2. **R31: uphill direction question and Esc (N1; BUG-205 wording part).** Verdict: **PARTIAL (part only: level-naming wording, the tested Esc/count route, and the falling-level control)**. Hash **FF6655B93D19**. No review file written; the existing matching older note is preserved.
   1. **Asks met:** B3 item 1 required both named levels, the choices, the 0.00 route, Esc and a falling-level control. Lines 20-30 drive 10.00/11.00; 31-39 drive 0.00/0.50; 40-50 drive 11.00/10.00. Assertions 52-57 read the warning and questions, 58-60 require two cancellations and unchanged counts, 62 requires exactly two direction questions, 63-64 require one placed control pipe. Lines 61 and 65 check windows; 66 checks the file.
   2. **Recorded evidence:** both B78 runs show 1034 before and after each cancellation, two direction questions, one control pipe, no final CE window and unchanged disk hash. The full questions name the reverse direction correctly in both records. Fifteen actual checks and four record-only lines make the report's 19 entries; they are not 19 independent checks.
   3. **Against BUG-205, line by line:** its Expected requires downhill flow after UseLevelDirection, no uphill warning, and actual levels in the question. R31 lines 53-57 address only the last requirement. Its steps 27 and 37 press Esc instead of choosing direction. There is no assertion of the resulting upstream/downstream record or arrow after that choice. PROVES_BUGS line 9 honestly limits its claim; it is not evidence that the whole bug is fixed.
   4. **Against BUG-686 and BUG-682:** zero is typed at line 32 and read in assertions 56-57, but the zero-level pipe is cancelled. BUG-686 requires the arrow, not merely the question. BUG-682 requires all pre-existing side effects restored; equal object counts in empty space do not prove unchanged existing geometry or schedule data.
   5. **Against D01 and D04:** all D01 assertions and D04's prompt stage, outcome line and two-vertex check remain outside this route. Calling them neighbours is accurate; counting either whole card would be wrong.
   6. **Exact lines to strengthen the existing wording part:** after line 57 add `contains $e1 "Open end at point 1 (IL 10.000). Is this correct?"` and `contains $e2 "Open end at point 1 (IL 0.000). Is this correct?"`. The current assertions stop before the final end of the proposed reversed direction. Its text is recorded at lines 67-68 but is not asserted. These additions cannot establish what the choice draws.
   7. **Exact scope line to add:** `NOT_AUTOMATED BUG-205 flow after UseLevelDirection and BUG-686 zero-level arrow are not proved; two fresh sessions on the installed build are also required for the wording and Esc part.` After any edit, old-hash passes count for nothing; run the new text twice on the installed build and update its broken twin as needed.
   8. **Whole-bug route still required:** after Start Pipe, answer UseLevelDirection, then read the created pipe's end levels, saved direction, arrow and warnings. Repeat with 0.00/0.50. The source case says this prompt answer is unsupported; I have not verified a safe existing runner verb for it and will not invent an executable line. The runner owner must supply that route before whole-bug acceptance, followed by two passes and an intended red.
   9. **Current-build gap and look:** zero B79 sessions; two more are needed even for unchanged wording/Esc scope. Window appearance and arrow placement still require a Codex look if claimed. Whether a drainage design is suitable remains Tim's engineering judgement.

## Things the desk should know first (RULES 6.2)

1. **The 07:10 installation lead is stale now.** Civil 3.0.78 was replaced by 3.0.79 at about 16:58. The morning case counts are also stale: current hashes now have six R28 and seven R31 PASS sessions, including two each on 3.0.78. None is on 3.0.79.
2. **C41 is the quick MOVE card, not a CDPROFILE card.** R28's actual PLAN_ITEM names Q1. Do not convert the brief's neighbour label into accepted C41 coverage.
3. **R31's earlier READY wording is narrower than a whole-feature verdict.** B3 and the existing note explicitly said the BUG-205 wording half only and did not authorise FIXED. This report applies the brief's PARTIAL label to that fact; it does not allege the earlier reviewer claimed the whole bug.
4. **The runner gate does not measure coverage.** Get-CaseIndependentReview, lines 116-126, checks the verdict prefix, case hash and non-builder REVIEWER line. It does not interpret a partial-coverage disclaimer. R31's old note still passes that local review gate; a printed ACCEPTED-READY must not be promoted to whole BUG-205 acceptance.
5. **Both BUG fields are empty.** R31 puts its limited bug claim in PROVES_BUGS. The reports describe red enforcement for a bug case; I independently checked both actual reds rather than relying on the printed status.
6. **A recorded settings difference is not a during-run change.** The B78 session reports start with Structural settings fingerprint `0791B07EBCD9`, differing from expected `2972CE70C514`, and record the same fingerprint at the end. This review does not claim the start matched the expected fixture; it does not affect the Civil checks assessed here.
7. **Count and file equality have limits.** Neither establishes byte-identical in-memory entities; an equal count could hide replacement objects. Neither case claims full restoration of existing-pit side effects. Do not widen the no-extra-objects evidence to BUG-682.

## For the runner owner (not case faults, listed so they are not lost)

1. **Keep the build and scope next to acceptance.** An older matching review file remains valid as a text review but supplies no new-build PASS sessions and no missing feature coverage.
2. **Prompt answering needs a verified route for R31's missing half.** Do not turn a read-only review into permission to type an unverified answer into AutoCAD. No route was run here.

## What I read

1. **Rules and plan:** `C:\TimOS\RULES.md` in full, including the acceptance amendment; `C:\TimOS\ROUTER.md`; the 24 Oct acceptance decision in full; the product start/map material; gap plan section 2 and section 3 item 7; triage A1 Q1 and N1.
2. **Independent reviews:** B3FIX and B3B in full for method and shape. Searched every `C:\CE_PLAN\areas\RUNNER_CASE_REVIEW_*.md` for R28 and R31. Read the relevant B2 item 19, B2FIX item 3 and related notes, B3 item 1 and related notes, and the B3FIX/B3B references. No later matching review was found in that filename family.
3. **Contracts:** C41 in `TEST_CASES_DRAFT_22OCT.md`; D01 and D04 in `DAILY_TOOLS_TEST_CASES_2026-10-23.md`; BUG-205, BUG-686, BUG-682 and BUG-389 entries in `BUG_CARPARK.md`. Q1's ten bugs are explicitly excluded by R28 and were not re-reviewed individually.
4. **Runner evidence:** both entire cases and both entire variants; existing R28/R31 notes; R16 note as format; Get-CaseIndependentReview and setup parser lines. No runner script was invoked or imported.
5. **Rows and reports:** the ledger array filtered row by row for both cases and variants; JSON case hashes, session starts/ends and outcomes for p3b3a6, pA1, pB1, b3bd1, b3bd2, g77a4, g77a5, g77b4, g77b5, g78a3, g78a4, g78b3 and g78b4. Detailed assertions of both B78 pairs and both B75 reds; corresponding Markdown case sections for those six reports.
6. **Files and installation:** nine live DLL ProductVersions, three live Contents creation times, retained Civil and Manager installations for B75/B77/B78 and retained Structural 1.0.123. Case and variant hashes were computed directly, not copied from notes.

## What I did NOT check

1. **No execution:** no AutoCAD, runner, case, lock, settings guard, build, install, code test or sub-agent. No fresh PASS or FAIL was produced.
2. **No visual judgement:** no screenshots or actual windows were examined. No profile was placed and no direction answer was chosen.
3. **No implementation audit:** installed source behaviour and Autodesk internals were not inferred. Old probes were not rerun; their explanation is attributed to earlier reviews.
4. **No engineering acceptance:** council values, design rules and sizing suitability need Tim's word. This report grants none.
5. **No unrelated acceptance recount:** other cases and the ten excluded Q1 bug routes were not independently judged. Settings state was read from reports, not checked live.

## Files written

1. **Report:** `C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr17.md`. Only this path is staged, committed and pushed; other desk changes are left alone.
2. **Local note:** `C:\Lisp Files\_ACAD_DRIVER\cases\R28_cdprofile_start.review.txt`, six ASCII lines, explicitly historical B78 evidence. Read back and matched to a fresh case hash. It is outside the plan repository and is not pushed.
3. **Preserved:** R31's existing note and all variant notes. No case, variant, setup, ledger, report from a run, settings file, bug register, desk log or queue was edited.

## Summary

Neither case is accepted on installed Civil 3.0.79. R28's narrow start-and-close text is ready on older 3.0.78; it needs two current-build sessions. R31 is part only: the question names levels and Esc cancels, but choosing the direction and the resulting arrow remain unproved. It also needs two current-build sessions. Both current variants have genuine recorded reds on 3.0.75. No whole daily-tool item or bug gains acceptance. R28's local note is updated; R31's is preserved. No AutoCAD or test was run.
