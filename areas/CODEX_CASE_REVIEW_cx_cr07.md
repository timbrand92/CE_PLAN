# Runner case review, cx_cr07: R27, R29 and R30 (Codex independent review, Mon 26 Oct 2026)

Written 26 Oct 2026, about 17:32 Melbourne. I read the rules and acceptance decision, both model reviews in full, the review gate, current cases and variants, earlier review sections, their triage entries and related bugs, installed DLL versions and ledger evidence. This is the desk plan/03 independent case review: no AutoCAD, runner, case, build, install or test was run; no sub-agents were used. Only this report is written and submitted to the plan repository.

## FOR TIM

1. **None of these three cases is ready to count.** R27, R29 and R30 all NEEDS CODEX LOOK. The older robot runs show their windows opened and closed; they do not show that a drafter can read every field and button.
2. **No bug may be written fixed from this review.** Opening LandXML and closing it without choosing a file does not prove that importing a consultant's pipes keeps their levels or protects pipes drawn by hand.
3. **Today's installed Civil is 3.0.79, with Manager 1.1.79.** Each case has two passes on 3.0.74 and none on 3.0.79. Each needs two separate sessions on today's build, plus its window look.
4. **The desk's earlier-review note is wrong.** Opus reviewed all three on 24 October and reached the same window-look verdict. R30 still claims an update-window check which it never performs. Manager administrator work stays parked.

---

## ANSWER FIRST

1. **Counts (one main verdict per case; three cases):** CLAUDE-ACCEPTED-READY: 0. NEEDS BROKEN VARIANT: 0. NEEDS STRONGER ASSERTION: 0. PARTIAL (part only): 0. NEEDS CODEX LOOK: 3 (R27, R29, R30). FAIL = real fault: 0. NEEDS RUNS: 0 as a main verdict; all three additionally lack both required sessions on the installed build. Wording/assertion gaps are detailed below. None qualifies for the older-build READY exception because each requires a look.
2. **Installed ProductVersions, read directly at 17:28 Melbourne:** Legacy, Modern and Net8 were read separately for each product; all three lanes agree within each product.
   1. **Civil:** `3.0.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa` in all three DLLs. Live bundle `Contents` created **26 Oct 16:57:58**.
   2. **Manager:** `1.1.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa` in all three DLLs. `Contents` created **26 Oct 16:57:59**.
   3. **Structural:** `1.0.124+3a3caac5db7687f1b5d1a6e09571976c52b2b05a` in all three DLLs. `Contents` created **25 Oct 17:41:13**.
   4. **Install boundaries:** I also read backup DLL ProductVersions and preserved `Contents` creation times, rather than taking the brief's times on trust. Civil/Manager 3.0.73/1.1.73: **24 Oct 11:35:55/56**; 3.0.74/1.1.74: **24 Oct 17:19:58/59**; 3.0.75/1.1.75: **25 Oct 03:33:02/02**; 3.0.77/1.1.77: **25 Oct 20:42:01/02**; 3.0.78/1.1.78: **26 Oct 05:41:30/31**; then the live 3.0.79/1.1.79 times above. Structural 1.0.123's backup reads **24 Oct 12:42:11**, replaced by 1.0.124 at **25 Oct 17:41:13**. These are filesystem install markers, not a claim to have watched installation finish.
3. **Ledger, row by row:** `ledger.json` contained **599 rows** at the first read. Exactly **22** concern these cases or their variants: **11 current-hash rows** and **11 stale rows excluded**. Each original has exactly two current-hash PASS rows and zero current-hash FAIL rows, all on the same historical build key. There are zero current-hash rows on 3.0.78 or the installed 3.0.79.
   1. **The counted historical pair for R27:** `RUN-20261024-1745-C3.0.74-w1-s1` and `RUN-20261024-1754-C3.0.74-w2-s1`.
   2. **The counted historical pair for R29:** `RUN-20261024-1745-C3.0.74-w1-s1` and `RUN-20261024-1754-C3.0.74-w2-s1`.
   3. **The counted historical pair for R30:** `RUN-20261024-1745-C3.0.74-w1-s1` and `RUN-20261024-1754-C3.0.74-w2-s1`.
   4. **Exact historical key:** `civil 3.0.74+a15b414c / struc 1.0.123+4af3f37d / mgr 1.1.74+a15b414c`. It does **not** equal the installed key `civil 3.0.79+d3f9c5df / struc 1.0.124+3a3caac5 / mgr 1.1.79+d3f9c5df`.
   5. **Times and separate starts:** w1 session **24 Oct 17:45:14-17:54:05**, w2 **17:54:07-17:58:58**. The ledger `at` fields are respectively **17:54:05** and **17:58:58** for each case. Both whole runs fall after the 3.0.74 pair's install and before 3.0.75, and inside Structural 1.0.123's interval. Neither straddles an install. The JSON reports record separate sessions and a clean end; no standing original-case FAIL exists on these current hashes.
   6. **Excluded original rows:** R27 has five stale rows (including two FAILs); R29 and R30 each have two stale PASS rows. They prove nothing about today's text. The older R27 and R30 broken variants each have one stale FAIL row, also excluded.
4. **Current hashes, taken with Get-FileHash -Algorithm SHA256:** each counted ledger hash equals its corresponding file. None of the three cases or variants declares `SETUP`; no associated setup file is therefore part of this review. DRV1_B1 is a fixture, not a SETUP file. Both reports say zero shared setups. The runner's case-only review hash still does not bind an external SETUP if one is added later.
   1. **R27:** `FF8E8F549086A44B13393622577C2F0B55A9DB22C87D0261741271CC439C6EBC`.
   2. **R27_BROKEN:** `B1D6221A7232F0F435934204945955F88C256D7E88C7FE76EBE22653B091023D`.
   3. **R29:** `6978F830B59BB80E259771586FD8255D0A6F203947761781F42A28872653356F`.
   4. **R29_BROKEN:** `4A78C845348AA509E9E497EDD8026B1B179C7A1429263AB8CAA66DF215DF54FD`.
   5. **R30:** `47F342FDCE52BF058C1C2175E077DC6AEC3C46B0279FEAF6FADBC0B94F6A33F6`.
   6. **R30_BROKEN:** `8D21BECD0AAE940E0C1A22B83971D122737C5A1183B03BA2FF57D2F43D239561`.
5. **Reds:** all five current-hash variant FAIL rows have `from_check: true`. All are weaker **flipped reds**, not broken behaviour. I read the failed checks in JSON and Markdown reports.
   1. **R27_BROKEN:** h4, **24 Oct 17:37:44**, and w1, **17:54:05**, on 3.0.74. Check 1 expects "of 7 things" while CE says "of 6 things". Both runs are wholly inside the 3.0.74 interval.
   2. **R29_BROKEN:** n2, **24 Oct 16:46:22**, on `civil 3.0.73+5467f705 / struc 1.0.123+4af3f37d / mgr 1.1.73+5467f705`, and w1 on 3.0.74. Check 2 expects "One pipe was drawn" while CE says "Nothing was drawn". n2 ran **16:37:51-16:46:22**, inside the 3.0.73 interval and before the 17:19 install.
   3. **R30_BROKEN:** w1 on 3.0.74, **24 Oct 17:54:05**. Check 3 expects "Update Manager" while the actual title is "Drawing Standards Manager". This deliberately wrong expectation is not a request to open an updater.
   4. **Limits:** the count, file-unchanged and closing checks still pass on the broken twins. These reds prove rejection of the flipped text only; they do not prove detection of a changed drawing, damaged window layout or unintended save. No crash, timeout or E_FAIL is counted as a red.
6. **Daily-tool cards and whole gap-plan items accepted by this batch:** **0 on the installed build; 0 on any build.** No D-number is claimed by these cases. D1 here is a triage group, not daily card D01. None covers a whole item in gap plan section 3 item 7. In particular, R30's alleged "Manager update window" is absent from that list. This is a scoped contribution, not a recount of other cases' acceptance.
7. **Bugs that may be written "FIXED (Claude-accepted, Civil 3.0.79, 26 Oct 2026)": none.** All three have an empty BUG header and no PROVES_BUGS line; their line 13 explicitly disclaims proof of the triage group's bugs. No fixed wording is justified. Never close or delete an entry (D6).
   1. **D1 bugs not yet:** BUG-259, BUG-506, BUG-508 to BUG-511, BUG-515, BUG-1004. No setup confirmation, saved design, outlet retention, calculation summary, rainfall comparison or changed-design check is driven. Suggested desk wording: "Not proved by R27: window opening only; design behaviour and engineering acceptance remain outstanding."
   2. **X1 bugs not yet:** BUG-512, BUG-513, BUG-602 to BUG-605, BUG-721, BUG-722, BUG-732, BUG-876 to BUG-878. No file is chosen or read, no import applied, replaced or undone. Suggested wording: "Not proved by R29: closing an empty import window does not exercise the import fault."
   3. **MG1 bugs not yet:** BUG-481, BUG-482, BUG-484, BUG-488 to BUG-490, BUG-828, BUG-847, BUG-853, BUG-1017. No relevant support, health, ribbon, menu, identity or active-command route is driven. Suggested wording: "Not proved by R30: CDMANAGER opens Drawing Standards Manager only. Administrator routes remain parked."

## How I applied the four conditions

1. **Nothing seen on screen:** not met for any whole case. Each is `KIND look` and explicitly requires readable, unclipped controls. `picture-ok` checks that a saved picture exists, is not blank and is not recorded as a duplicate; it does not judge the window.
2. **Two passes in separate AutoCAD sessions on one build:** met historically on 3.0.74, not on the installed 3.0.79. Exactly two further passing sessions per case are needed on the installed key, after any text corrections; changed comments also change the hash.
3. **Red before green:** matching flipped reds exist for all three, as item 5 above. None removes the need for visual judgement or full feature coverage.
4. **Compared with the card or bug, and full coverage:** compared line by line below. These cases cite triage groups rather than C/D cards. Their own exclusions correctly admit that the groups' full features are not tested. Engineering values, council rules and sizing choices still need Tim's word.

## The cases

1. **R27: CDDESIGN opening (triage D1, start of route only).** Verdict: **NEEDS CODEX LOOK.** Hash **FF8E8F549086**. No review file.
   1. **Asks met:** B2 item 18 already required a look, with no design-number acceptance. The current case retains that split. The two passes and flipped red exist on 3.0.74; the look remains outstanding in this review.
   2. **Line comparison:** case lines 4, 13 and 16 against triage line 56 and BUG-259 expected line 5139, BUG-506 entry 10017, BUG-508 to BUG-511 entries 10037-10061, BUG-515 entry 10097 and BUG-1004 expected line 13399: none of their substantive design routes occurs in steps 18-25. Lines 29-32 assert four tab names; line 33 asserts Start-page words, but no assertion names the Start tab or proves it is selected. Line 28 checks only the suffix "of 6 things", not the numerical value or correctness of the count.
   3. **What the runs show:** w1 and w2 each report "1 of 6 things", five tab names in the text dump, the two required sentences, and Cancel succeeding. Ten checks plus one record line pass per run. File hash stays `34BBE37C2EA4...`; this does not prove that nothing changed in drawing memory or in every CE file.
   4. **Exact lines for the desk:** add ASSERT `control $dd "Start" exists`. Replace TITLE with `TITLE CDDESIGN opens its Start page and closes without saving the drawing file`. Retain `KIND look` and both RIGHT_LOOKS_LIKE lines. Add `RIGHT_LOOKS_LIKE Start is visibly selected; the job fields and source rows are readable, with no clipped text or overlapping controls.` These lines do not themselves supply the look.
   5. **The Codex look:** judge the selected tab, job/source rows, clipping and readable text in the real-window evidence. No design figure is approved by this case. The earlier 2-versus-1 observation is a lead, not a diagnosed fault; both counted runs say 1. After the wording/assertion edit: two sessions on Civil 3.0.79, plus the look. Do not pin a new readiness count without establishing what the drawing actually contains.
2. **R29: LandXML opening and closing without a source (triage X1).** Verdict: **NEEDS CODEX LOOK.** Hash **6978F830B59B**. No review file.
   1. **Asks met:** B2 item 20 required a look and said import itself was not driven. That remains true. The case's line 16 admits the excluded import routes.
   2. **Line comparison:** lines 4, 13 and 16 against triage line 48 and the X1 bug entries: BUG-603 steps/expected at 10915-10918 require Read source before Apply; BUG-605 at 10938-10947 requires actual level retention; BUG-721/722/732 require replacement or clash handling. Steps 18-27 choose no file. Lines 31-34 cover the cancellation message, equal object counts, closed window and unchanged disk file only. BUG-512/513/602/604/876/877/878 likewise require a source read or import, absent here.
   3. **What the runs show:** six checks plus one record line pass per run. Model space is 1034 before and after; file hash remains equal. The close record says **Close succeeded**, after Cancel was not found. "CDIMPORTLANDXML cancelled. Nothing was drawn." is the resulting command message, not proof that a Cancel button was pressed. The mere word "LandXML" at line 30 can match the window title.
   4. **Exact lines for the desk:** replace step 23 with `ui-press "LandXML import" "Close" -> $xc`, then add ASSERT `window-closed $xc`; replace line 35 with `record $xc "FULL what pressing Close reported"`. Replace TITLE with `TITLE CDIMPORTLANDXML opens and Close leaves the object count and drawing file unchanged`. Add ASSERT `control $xd "Close" exists`. Keep the command-line cancellation assertion and `KIND look`.
   5. **The Codex look:** file-choice control and Close must be visible, readable and clear of overlaps and window edges. No import preview, provenance, pipe level or protection of existing work is covered. Two further sessions are needed on Civil 3.0.79 after edits; a look is still required. Equal counts alone cannot detect replacing one object with another or changing an existing object's level.
3. **R30: CDMANAGER opens Drawing Standards Manager, not the Manager update window.** Verdict: **NEEDS CODEX LOOK.** Hash **47F342FDCE52**. No review file.
   1. **Asks met:** historical passes and a flipped red exist. B2 item 21's corrections are **not met**: line 4 still claims the gap-plan update window, and line 14 still says installed versions are named without a check reading them. Line 13 contradicts that broader scope by admitting the update window is not driven.
   2. **Line comparison:** lines 1, 4, 13-16 against triage MG1 line 49, the ten MG1 bugs and gap-plan section 3 item 7: steps 18-27 only open, read, photograph and close Drawing Standards Manager. No support zip, health report, ribbon click, menu setting or identity record is tested. The distinct C48 card at TEST_CASES_DRAFT lines 1044-1061 calls **CEMANAGER**, Status/Module/Updates/Help pages, reopen-size comparison, DBMOD and settings checks; R30 does none of these and cannot inherit C48 acceptance.
   3. **What the runs show:** the dump lists Draw Order, Layer Colours and Labels & Dimensions. Four checks plus three record lines pass per run. The successful close is **Close**, and the disk file is unchanged. No check reads installed version text; no model-space count or DBMOD comparison supports the title's broad "changes nothing".
   4. **Exact replacements for the desk:** `PLAN_ITEM Drawing Standards Manager opening only; no MG1 bug, C48 or gap-plan acceptance claimed`. `TITLE CDMANAGER opens Drawing Standards Manager and closes without saving the drawing file`. `EXPECTED Drawing Standards Manager opens; Close leaves the drawing file on disk unchanged and no CE window open.` Apply the corresponding scope correction to the broken twin's description too, then rehash both.
   5. **Exact steps to add:** replace step 24 with `ui-press "Drawing Standards Manager" "Close" -> $mc`; add ASSERT `window-closed $mc`; replace line 33 with `record $mc "FULL what pressing Close reported"`. Add `NOT_AUTOMATED Manager administrator and update actions remain parked; this case opens and closes Drawing Standards Manager only.` Do not add administrator, repair, update, support or health actions to fill the MG1 gap.
   6. **The Codex look:** readable headings/buttons, clipping, overlaps and the reported duplicate Draw Order layer rows. B2 attributes the duplicate-row observation to the builder; I have not looked at its picture and do not promote that lead to a real-fault verdict. Two further sessions on Civil 3.0.79/Manager 1.1.79 are also required after corrections.

## Things the desk should know first (RULES 6.2)

1. **"Never independently reviewed" is false for all three.** `RUNNER_CASE_REVIEW_B2_2026-10-24.md`, case items 18, 20 and 21, reviewed each. Searching every `RUNNER_CASE_REVIEW_*.md` found no later substantive reassessment of these three; later exclusion lists do not reverse B2.
2. **3.0.78 is no longer installed.** The morning brief was a lead; the live DLLs now say 3.0.79. Its three hash prefixes, two historical passes each, zero 3.0.78 passes and absence of review files are confirmed.
3. **The Manager update claim is still wrong.** The gap plan excludes the update button from the pilot and has no such item among its 40 checks; the daily-card document also explicitly says no Manager window case is in its 30. R30 is not C48, either.
4. **A saved picture is not an accepted window.** A successful file-hash check also does not prove an unchanged drawing in memory. R27's "without writing anything" and R29/R30's broad "changes nothing" need the narrower wording above unless additional behaviour is actually measured.
5. **Stale builder comments are not review evidence.** All three line 13 notes still say Opus review is needed despite B2. R30's opening comment calls it a discovery draft. Do not tidy comments independently of the next case edit: even a comment changes the reviewed hash.

## For the runner owner (not case faults, listed so they are not lost)

1. **Review gate read, not executed:** `Get-CaseIndependentReview` requires a line-start READY verdict, a 64-character reviewed hash matching the supplied case hash, and a REVIEWER line not starting with builder. Builder-filled REVIEWED_AGAINST alone does not qualify. I read the six-line R16 example.
2. **Limits visible in the gate:** its hash comparison is conditional on a nonempty supplied hash, and it searches both the case directory and variants directory, taking the first matching candidate. It does not itself bind SETUP content or build identity. This review used independent current-file hashes and exact ledger build keys instead. None of these cases declares a SETUP.

## What I read

1. **Authority and method:** RULES.md in full, ROUTER.md, the 24 October acceptance decision, START_HERE and MASTER_PLAN, B3FIX and B3B reviews in full, B2's relevant case/count/finding sections, and every search match for R27/R29/R30 in the review collection.
2. **Contracts:** BUG_REGISTER_TRIAGE groups D1/X1/MG1; the full 30 related bug entries listed above; C48; C/D-card searches; gap-plan sections 1b, 2 and 3 item 7. The bug references establish exclusions, not completed bug coverage.
3. **Evidence:** all six current case/variant files, their hashes and absence of associated review files; runner review-gate and relevant assertion vocabulary; R16 review format; all 22 relevant ledger rows; scoped checks and timings in w1, w2, h4 and n2 JSON/Markdown reports; all nine live DLL ProductVersions, live Contents times and relevant backup versions/times.

## What I did NOT check

1. **No execution:** no AutoCAD, runner, case, driver call, lock, settings guard, build, install or test. No sub-agents. No settings, ledger, run report, case, variant, setup, bug register, desk log or queue was edited.
2. **No visual acceptance:** no screenshot was opened or judged. The old pictures are evidence awaiting a look, not a current-build PASS. I did not prove any layout fault or review other themes, display scales or AutoCAD runtime years.
3. **No engineering acceptance:** no design calculations, council values, sizing decisions or import result was judged. No Manager administrator work was performed or authorised by this report.
4. **No fresh runtime verification:** stored session/fixture/settings observations come from the reports; I did not rehash the fixture or live settings, inspect internal drawing records, or read plugin implementation code. No other cases were re-reviewed.

## Files written

1. **Report only:** `C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr07.md`. No review.txt is justified or written. None existed for these three cases at inspection; no review file was deleted or changed. Only this report is staged and committed by name; other jobs' changes remain untouched.

## Summary

None of R27, R29 or R30 is Claude-accepted-ready. All need a window look and two sessions on installed Civil 3.0.79, after the stated corrections. Each has two current-text passes on 3.0.74 and a flipped red. No whole daily-tool item or bug may be accepted from them. All three were already independently reviewed on 24 October. R30's update-window and version claims remain wrong; Manager administrator work stays parked. Only this report is written.