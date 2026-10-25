# Runner case review, cx_cr05: R19, R21 and R22 (Codex independent review, Mon 26 Oct 2026)

Written Mon 26 Oct 2026, about 08:06 Melbourne, by Codex (GPT-6). I read the rules, acceptance decision, both model reviews in full, earlier sections for these cases, the cards and bugs, the actual installed DLL versions, case and variant texts, setup, ledger rows and relevant JSON and Markdown run reports. I ran no AutoCAD, runner, case, driver, lock, settings guard, build or test; changed no bug or evidence file. This report is my only authored file. The brief's explicit read-only scope overrides its appended generic build instructions.

## FOR TIM

1. **0 of these 3 cases are ready on today's Civil 3.0.78.** R19 and R21 prove parts only. R22 found a real wording fault on the older Civil 3.0.73; nobody has recorded these three cases passing on today's build.
2. **The useful evidence is real but limited.** Erasing the new pit leaves its one pipe, and one U restores the pit. That does not check a junction pit with six pipes. The separate R19b case covers that route; this review adds no second credit for it.
3. **No bug may be written fixed from this batch.** CDCHECK printed pipe identifiers instead of useful names in both recorded R22 sessions. On a job, the drafter needs to find the pipe between two pits, not decipher an internal identifier.
4. **The desk's reading needs two corrections.** R21 and R22 already had an independent review on 24 October. Also, unchanged object count and unchanged saved file do not prove that nothing in the open drawing changed: a pipe level can change without adding an object.

---

## ANSWER FIRST

1. **Counts: one main verdict per case, three cases.**
   1. **CLAUDE-ACCEPTED-READY: 0.** No review files written, including under the brief's older-build exception.
   2. **PARTIAL (part only): 2.** R19: one-pipe erase message, pipe survival and pit/count restoration. R21: fixed CDCHECK totals line, unchanged model-space count and unchanged file on disk.
   3. **FAIL = real fault: 1.** R22, on Civil 3.0.73 only. Installed-build behaviour is unknown.
   4. **NEEDS BROKEN VARIANT: 0; NEEDS STRONGER ASSERTION: 0; NEEDS CODEX LOOK: 0; NEEDS RUNS: 0 as primary verdicts.** Assertion gaps and missing runs remain secondary requirements below. All three have zero PASS sessions on the installed build; each needs two passing sessions there after its coverage requirements are met. Runs alone cannot make a partial card whole.
2. **Installed build, read from files at about 08:03 Melbourne.** All nine DLLs were read through VersionInfo.ProductVersion; each product agrees across Legacy, Modern and Net8.
   1. **Civil, all three lanes:** `3.0.78+d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`.
   2. **Manager, all three lanes:** `1.1.78+d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`.
   3. **Structural, all three lanes:** `1.0.124+3a3caac5db7687f1b5d1a6e09571976c52b2b05a`.
   4. **Live Contents creation times:** Civil 26 Oct 05:41:30.579; Manager 26 Oct 05:41:31.142; Structural 25 Oct 17:41:13.577. These are filesystem install markers, not proof of which DLL any already-open AutoCAD loaded.
   5. **Historical install boundaries, checked against backup Contents creation times and DLL versions:** Civil 3.0.73, 24 Oct 11:35:55.809; Manager 1.1.73, 11:35:56.624; Structural 1.0.123, 12:42:11.855. Civil 3.0.74 arrived 24 Oct 17:19:58.481; 3.0.75 arrived 25 Oct 03:33:02.026; 3.0.77 arrived 25 Oct 20:42:01.593; 3.0.78 arrived 26 Oct 05:41:30.579. The desk's expected installed versions agree with disk.
   6. **Valid old-build evidence window:** the complete ledger build `civil 3.0.73+5467f705 / struc 1.0.123+4af3f37d / mgr 1.1.73+5467f705` is supported after 24 Oct 12:42:11.855 and before 17:19:58.481. Every pair and flipped red retained below began and ended inside that window, also before the 17:18:57 backup/removal marker. None is current-build evidence.
3. **Ledger: 484 rows at first read, 505 at the 08:06 final check; the same 15 relevant rows remained.** All rows naming these cases or their variants were inspected. Short run labels below refer to the full run names in What I read. Every row listed here has the current case or variant hash unless explicitly excluded.
   1. **R19, p3b2fixS2:** three rows at 24 Oct 13:07:06: s1 FAIL (`from_check true`), s2 PASS, then s2 FLAKY. Its stamped Structural version is 1.0.122. Pack start 12:41:09 preceded the Structural install at 12:42:11.855; sessions began 12:42:30 and 12:59:17. Exclude this pack from acceptance: its build stamp spans an install and is stale. FLAKY is a real ledger result, despite the brief describing only PASS/FAIL.
   2. **R19, p3b2fixS2b:** PASS at 13:21:03; session `RUN-20261024-1308-C3.0.73-p3b2fixS2b-s1`, 13:08:26 to 13:21:03.
   3. **R19, f3:** PASS at 15:00:09; session `RUN-20261024-1448-C3.0.73-f3-s1`, 14:48:36 to 15:00:09. This and S2b are the valid historical pair on the identical complete build string. No later R19 FAIL on that string.
   4. **R19_BROKEN, f9:** FAIL at 15:53:44, `from_check true`, `variant_of R19`; session `RUN-20261024-1542-C3.0.73-f9-s1`, 15:42:28 to 15:53:43. Only assertion 4 fails: no line contains the deliberately wrong plural phrase. This is a flipped red, not an erased pipe or broken Undo.
   5. **R21, n1:** PASS at 16:37:50; session `RUN-20261024-1627-C3.0.73-n1-s1`, 16:27:45 to 16:37:50.
   6. **R21_BROKEN, n1:** FAIL at 16:37:50 in that session, `from_check true`, `variant_of R21`. Assertion 1 finds zero copies of the line with 180 Connected instead of 179. Flipped red only.
   7. **R22, n1:** FAIL at 16:37:50 in that session, `from_check true`; assertions 1, 2 and 3 fail. This is the actual case, not a variant.
   8. **R21, n4:** PASS at 17:01:56; session `RUN-20261024-1657-C3.0.73-n4-s1`, 16:57:21 to 17:01:56. This and n1 are the valid historical pair on the identical complete build string. No FAIL for R21 on this hash.
   9. **R22, n4:** FAIL at 17:01:56 in that session, `from_check true`; the same three assertions fail. Two standing failures on Civil 3.0.73, zero passes on any build for this text. There is no R22 variant file or variant row. These two real-fault runs are historical red-before-fix evidence for the exact current case, not a manufactured red.
   10. **Excluded older R19 texts:** four PASS rows, run1C at 06:48:45 and run2C at 07:43:56 on hash `48427D5FB7DC...`; run3C at 08:19:14 and run4C at 08:45:53 on `0580CBBA8D3E...`. All on 24 Oct, Civil 3.0.72. None counts. Current R19 text has five rows total: three PASS sessions, one FAIL and one duplicate-session FLAKY summary; only two PASS sessions survive the install-boundary check.
   11. **R19's old FAIL is a runner-history fault, not demonstrated CE failure.** Its own check 10 records the exact erase sentence which history checks 3 and 4 said was absent from four lines. S2b records the command log changing file and successfully checks that same sentence. This directly supports the earlier review's diagnosis; a Structural version change alone would not discharge a Civil fault.
4. **Hashes taken with Get-FileHash -Algorithm SHA256.** Full values make this review reproducible; all counted rows equal the corresponding value.
   1. **R19:** `2F504E120147427C33ABB4AC951FA3381825B40BB02761815DDEEFD63ADEC4BA`.
   2. **R21:** `89B64B53A3FDE72E6CC6EFA30F202B8C6C65CA17C57296BD5877409D039D4691`.
   3. **R22:** `BF70B18C4F7E3540FE0635797A78998CCE3A64A519C5A269FA66A8A3D9D69A50`.
   4. **R19_broken:** `89A64694C251AD4B99CC4F19854756E014085A19CEE3565FF9E3F7237501C8AB`.
   5. **R21_broken:** `EAC859981A7DF167D2C1C4A1D80098306F62FB912BBA62866DF595E3D2B7E64C`.
   6. **SETUP-R47:** `0CB83BDF78538F247ADEF2B37DF755B2370A2830F368C1D01E90BB211FD71C07`; last written 24 Oct 11:52:43.105, before both valid R19 passes. It creates P8 and one pipe after moving P3 by 2000 mm. Neither R21 nor R22 has a SETUP line. The gate binds only the case hash, not this setup hash; the timestamp and recorded setup steps are supporting evidence, not a historical setup-hash attestation.
   7. **Existing review file:** R19 still names `0580CBBA8D3EFD6A04A952825358D0234234FA331EE26F7CA70628FF1A201477` and says PARTIAL. Both its verdict and hash prevent acceptance. Left untouched. R21 and R22 have no review files.
5. **Daily tools and gap-plan whole items contributed by this review: 0 on the installed build; 0 on any build.** This is a three-case contribution, not a recount of the whole suite.
   1. **D14 / section 2 item 14 / UX-EDIT-01:** R19 is the singular branch only. R19b was accepted separately in B3B; I do not re-audit its current files or runs, count it again, or transfer its result to R19.
   2. **D28 / section 2 item 28 / UX-IMP-02:** neither R21 nor R22 invokes CDCHECKDWG. No credit.
   3. **Checks palette:** neither case opens or compares it; it is not a separate named item in section 3 item 7's list. R21's label cannot create a new denominator item. The gap plan says 40, while its eight named tools plus 30 listed tools total 38; this review does not alter the denominator.
6. **Bugs eligible for `FIXED (Claude-accepted, Civil 3.0.78, 26 Oct 2026)`: none.** No such wording is authorised by these cases, and no entry was edited, closed or deleted (D6).
   1. **BUG-461 and BUG-809:** R21 does not drive the failure/action routes or compare the palette, respectively. BUG-809 also includes four other behaviours. No whole-bug proof.
   2. **BUG-372 and BUG-814:** R22 covers neither MOVE/STRETCH tidy wording nor CDTAG/CDFIXTAGS and the full Checks palette scope. Its CDCHECK handle failure is related evidence only.
   3. **BUG-360:** R22 reproduces its 14 October CDCHECK internal-ID extension on 3.0.73; other windows, schedule footer and Structural wording are untested.
   4. **BUG-389:** the literal arrow escape is absent, but no old pipe name containing that escape is established. Absence on this fixture is not proof of that bug's fix.
   5. **Suggested factual update, status stays OPEN:** "Independent Codex case review cx_cr05, 26 Oct 2026: R22 current hash BF70B18C4F7E reproduces raw handles and CE-CIV pipe/pit identifiers in CDCHECK All in n1 and n4 on Civil 3.0.73. No R22 run is recorded on installed Civil 3.0.78. This does not accept the other routes of BUG-360, BUG-372 or BUG-814, or prove BUG-389 fixed."

## How I applied the four conditions

1. **Nothing seen on screen:** these three narrow routes use counts, entity reads, command text and file hashes. No drawing appearance was accepted. Broader palette/window claims still need a Codex look; engineering values and design choices still need Tim's word.
2. **Two sessions on one build:** R19 and R21 have valid older-build pairs only. R22 has two failures. None has a current-build pair.
3. **Red before green:** R19 and R21 have current-hash flipped reds. R22 has current-hash real failures on 3.0.73. The original cases' surviving checks on flipped twins are not evidence that those checks detect an actual broken drawing operation.
4. **Whole card or bug:** comparison below leaves R19 and R21 partial. R22 exposes a real older-build fault and covers only a small part of its named bug families.

## The cases

1. **R19: erasing a one-pipe pit (D14, UX-EDIT-01). Verdict: PARTIAL (part only: singular erase message, one pipe survives, one U restores the pit and total count). Hash 2F504E120147.**
   1. **Asks met:** the first review's full sentence and exact 1039 count are now case lines 38 and 39. The requested flipped variant exists and fails. B2 already recognised these changes; the old review file did not acquire the new hash.
   2. **Line-by-line card comparison:** D14 lines 439 and 443-444 require P3 and its N pipe handles from the schedule; R19 lines 19-22 select new P8 and its setup pipe instead. D14 assertion 1 (line 449) is met for N=1 by case line 38; assertion 2 (450) by line 29/40; assertion 3 (451) by lines 30-33/41-43 for P8 instead of 109D56. In both valid passes, the pipe is 11C64F, the restored pit 11C5AB, counts 1040 -> 1039 -> 1040, and U echoes ERASE.
   3. **Exact reason it is not whole D14:** no several-pipe branch or schedule-derived N. Reconnection after U is also not read, but B3B correctly notes that D14's enumerated assertions do not separately demand that link read; it is a limit, not a new requirement invented here.
   4. **Exact desk edit to retain an honest small case:** `PLAN_ITEM UX-EDIT-01 / D14 singular-message branch only; whole-card several-pipe route is R19b`. Replace line 36 with `count $pipes8 = 1`. Replace the stale line 16 with `NOT_AUTOMATED The plural-pipe route and schedule-derived pipe count belong to R19b; pipe links after U are not read here.` These edits clarify and guard the part; they do not make it whole D14. No extra line in R19 substitutes for the separate R19b route.
   5. **Red weakness:** its wrong phrase starts `[CE Civil] 2 pipes...`, whereas the real whole message inserts `The pit was erased and the schedule is updated.` after that prefix. For a clean numeric flipped red, replace its assertion with `history has "2 pipes now have ends that are Not connected yet"`. The existing failure is still a flipped red, but confounds the number with the phrase location.
   6. **Runs and look:** two more PASS sessions on Civil 3.0.78, Manager 1.1.78, Structural 1.0.124 are needed for current-build evidence; any edited case needs its new hash in both. No Codex look needed for this narrow part. The case must remain PARTIAL against whole D14. No review file written.
2. **R21: CDCHECK totals (C1; BUG-461 and BUG-809 item 1 mentioned in REVIEWED_AGAINST; D28 called a neighbour). Verdict: PARTIAL (part only: fixed totals line, object count and saved-file preservation). Hash 89B64B53A3FD.**
   1. **Asks met:** no new ask was made after B2's item 12, which retained this as a regression baseline. Two passes and the 180-versus-179 flipped red are present. Case line 29 pins constants whose sum is 179 + 1 + 4 + 0 = 184; there is no variable arithmetic check or comparison against actual connections.
   2. **Line-by-line claim comparison:** case lines 19 and 23 call All and Problems; line 29 counts the same prefix twice across the whole case. Lines 31-32 check 1034 objects and the unchanged disk hash. BUG-461 line 9641 requires truthful wording after actions/failures, including CDRULES and a failed file save; none is driven. BUG-809 lines 791/793 require agreement with the palette; no palette read exists. D28 lines 806-817 require CDCHECKDWG, a results window, one summary and a report; none is driven.
   3. **The drawing-unchanged claim is too strong.** Moving an object or changing its stored levels would preserve model-space count and the unsaved file. B2's statement that the drawing is unchanged overstates what these assertions prove. Line 15 says the BUG-461 sentence is asserted; no assertion reads it. No PROVES_BUGS line exists in any of these three cases; do not infer one from their titles.
   4. **Exact desk edits for the honest baseline:** `TITLE CDCHECK All and Problems repeat the expected totals; object count and file on disk stay unchanged`; `PLAN_ITEM CDCHECK fixed-fixture totals baseline only; not D28, Checks palette acceptance or whole BUG-461/BUG-809`; `NOT_AUTOMATED No complete in-memory drawing comparison, action/failure route or palette-count comparison is made.`
   5. **Exact stronger checks:** add `contains $all1 "[CE] CDCHECK: 212 objects, 184 connections: 179 Connected, 1 Possible, 4 Unresolved, 0 Not Connected"` and the same line using `$prob1`, so two copies from one command cannot satisfy both routes. Add `contains $all_e "Nothing in the drawing has been changed so far."` and the same using `$prob_e` for the actual recorded wording. These are baseline checks only, not a BUG-461 fix proof.
   6. **Whole-bug gap is a new scenario, not one missing word.** BUG-461 needs action/failure paths with observed drawing-state changes; BUG-809 needs the actual palette and Possible-link totals on the same drawing. Do not invent palette control names or expected engineering values from this report. Two further PASS sessions on Civil 3.0.78 are required after any agreed rewrite, plus reds for new claims. Palette appearance would need a Codex look. No review file written.
3. **R22: CDCHECK words (W9; BUG-372, BUG-814, BUG-360, BUG-389). Verdict: FAIL = real fault on Civil 3.0.73; current build untested. Hash BF70B18C4F7E.**
   1. **Evidence:** n1 and n4 both fail case lines 22-24. Each finds 22 `(handle ` lines, 60 `CE-CIV-PIPE-` lines and 35 `CE-CIV-PIT-` lines. Example: `Pipe 450 (handle 109359): one end is not connected (the start).` These are command replies, not crashes or timeouts. Line 25 passes: no U+2192 in 97 history lines.
   2. **Line-by-line bug comparison:** BUG-360 line 3072 directly names CDCHECK's raw handles and long identifiers: lines 22-24 catch a real part of it. BUG-372 lines 3828/3832 name tidy/MOVE/STRETCH and CDCHECKS; R22 only calls CDCHECK. BUG-814 lines 705/707 cover four wording routes including the palette; those other routes are absent. BUG-389 line 3654 needs an old escaped pipe name; none is verified. Thus even a future PASS cannot close any whole named bug on this case alone.
   3. **Missed bad wording:** the run record also contains `FALL arrow, handle 1197BB, ...`; line 22 only checks `(handle ` and would miss that form if pipe messages were fixed. The title promises no escape code, but line 25 only checks one particular code.
   4. **Exact desk additions:** add `history has "[CE] CDCHECK:"` so silence is not success; replace line 22 with `history absent "handle "`; add `history absent "\U+"` if retaining the broad escape-code title. Keep the two CE-CIV absence checks. These strengthen the command-line part without claiming to inspect other windows.
   5. **Exact scope line:** `PLAN_ITEM BUG-360 CDCHECK command-line extension only; related handle wording in BUG-372/BUG-814; BUG-389 needs an old-name fixture`. The EXPECT-FAIL owner can then read `EXPECT-FAIL BUG-360`. Whole-bug coverage still requires separate routes; no runner line here can inspect an unvisited window.
   6. **Next evidence:** run the current build before claiming this fault remains installed. Two successful sessions on Civil 3.0.78 are needed after the fault and coverage gaps are resolved. The existing current-hash failures are valid historical reds; changing the case text means those rows no longer certify the exact new file. No separate broken variant exists. No Codex look is needed for command text, but the broader windows/palette require one. No review file written.

## Things the desk should know first (RULES 6.2)

1. **The 07:10 leads are wrong about review history:** B2, 24 Oct, items 12 and 13 already reviewed R21 and R22. No review file means no ready gate, not no independent review.
2. **R19's old fail cannot be dismissed merely because Structural changed.** The same report records the message which its history reader missed. Also, the pack started before the Structural installation and stamped the old build. Its PASS row is excluded here.
3. **R21's unchanged drawing is not proved.** Earlier B2 prose and the current case title are too broad; the evidence proves count and saved-file preservation only. Its NOT_AUTOMATED wording falsely says a sentence is asserted.
4. **R19's full sentence is already checked.** The old review file and NOT_AUTOMATED line describe the older text. Neither should cause the desk to repeat an already-applied assertion edit.
5. **R22's earlier request to run 3.0.74 remains unfulfilled in this ledger.** Its only current-hash rows are the two 3.0.73 failures. The next useful target is the actual installed 3.0.78, not the obsolete version.

## For the runner owner (not case faults, listed so they are not lost)

1. **Setup identity:** Get-CaseIndependentReview checks an anchored READY verdict, a 64-character case hash and a non-builder REVIEWER line. It checks neither setup hash nor the build written in the review file. A setup edit can change R19 without invalidating that case hash.
2. **Install identity:** p3b2fixS2 demonstrates why the build must be read after an install/lock wait. Its header says Structural 1.0.122 despite the first session starting after 1.0.123's install marker. No current acceptance rests on it here.
3. **Absence-only wording checks:** R22 needs a positive command-output check. R21's whole-case line count should be accompanied by assertions tied to each command response. The existing parser supports the proposed contains/history lines; no new runner syntax is assumed.

## What I read

1. **Rules and method:** `C:\TimOS\RULES.md`, `ROUTER.md`, the 24 Oct acceptance decision; complete B3FIX and B3B model reviews. Product start/map were consulted for scope; the explicit brief controls this review.
2. **Earlier review search:** searched every `C:\CE_PLAN\areas\RUNNER_CASE_REVIEW_*.md` for R19, R21 and R22. Relevant sections were R11_R20 item 9 and its shared-history warning, B2 items 9/12/13 and its R19 fail note, B2FIX's R19b/D14 boundary, and B3B's D14 explanation. No later case-specific acceptance was found in that search.
3. **Contracts:** D14 lines 432-454 and D28 lines 794-820 in `DAILY_TOOLS_TEST_CASES_2026-10-23.md`; gap plan section 2 and section 3 item 7; C1/W9 triage entries; complete BUG-461, BUG-809, BUG-372, BUG-814, BUG-360 and BUG-389 entries. No case claims a C-number card.
4. **Case evidence:** all three case files, R19 and R21 variants, SETUP-R47, existing R19 review, R16 format example, runner review gate and relevant text-check handlers. No R22 variant exists in the specified variants pattern.
5. **Ledger and reports:** `areas\runner-reports\ledger.json`; relevant case/check sections in both `.json` and `.md` for `RUN-20261024-1241-C3.0.73-p3b2fixS2`, `RUN-20261024-1308-C3.0.73-p3b2fixS2b`, `RUN-20261024-1448-C3.0.73-f3`, `RUN-20261024-1542-C3.0.73-f9`, `RUN-20261024-1627-C3.0.73-n1`, `RUN-20261024-1657-C3.0.73-n4`. JSON session dates and assertions were read directly, not inferred from report names.
6. **Installed evidence:** live Civil, Manager and Structural ProductVersion in all three runtime folders; live Contents creation times; historical Contents and matching DLL versions from the 5467f705, a15b414c, 2c805a39, 0d885094 and Structural 4af3f37d backups. Desk install-log entries were corroboration only.

## What I did NOT check

1. **No execution:** no AutoCAD, case runner, driver, lock, settings guard, build, install or test. No agents spawned. Reading evidence is not a new test pass.
2. **No visual acceptance:** no screenshot, window, preview, label position or drawing appearance was judged.
3. **No current behaviour:** these cases have no recorded 3.0.78 passes or failures. No engineering standard, council value, sizing choice or design decision was accepted.
4. **No whole-suite recount or sibling review:** R19b and other cases retain their separate evidence; their current hashes and runs were not re-reviewed. No settings files or underlying drawing files were opened, and no source-code fix was audited.
5. **Historical limitations:** setup hash is not bound by the gate; folder creation time is an installation marker, not a loaded-module observation. The report does not claim otherwise.

## Files written

1. **Report only:** `C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr05.md`. Only this named report is to be staged, committed and pushed. No review.txt is eligible; the old R19 file stays untouched. Undo for this work is a revert of the report-only commit.

## Summary

None of R19, R21 or R22 is ready on Civil 3.0.78. R19 proves the one-pipe branch only. R21 proves a fixed totals line, object count and unchanged saved file, not whole-drawing preservation or either named bug. R22 records real wording faults on 3.0.73; today's behaviour is unknown. No whole daily-tool item or bug fix is accepted, and no review file is written. Exact corrections and missing evidence are listed above. Nothing was run in AutoCAD.
