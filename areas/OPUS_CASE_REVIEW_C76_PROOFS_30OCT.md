# Opus independent case review: five C-76 proof cases on Civil 3.0.86 (Fri 30 Oct 2026)

Written Fri 30 Oct 2026, 07:24 to about 07:40 Melbourne (PC clock read with `date`), by the Team Opus job CE_ACAD / robot / review / 30. Read-only on the product: no AutoCAD, no runner, no driver, no build. I wrote four review slips and this report, nothing else.

## ANSWER FIRST

### FOR TIM

1. **R22, CDCHECK words (BUG-372): READY, for one part.**
   1. **What it proves:** type CDCHECK on the test drawing and every line names pipes in words, for example "An unnamed pipe flows to WT4". No line shows a code such as "handle 10A86B" or "CE-CIV-PIPE-6A33...".
   2. **Why only part:** your original BUG-372 was about lines after STRETCH and MOVE. Those are not tested here.
2. **N33, Pit Schedule order (card D21): READY, whole claim.**
   1. **What it proves:** add pits typed LPD, OG, CP10 and CP2. The Pit Schedule lists LPD, OG, P1 to P10, CP2, CP10, then C1.
   2. **CP10 is placed before CP2 on purpose.** A list in placing order would fail.
3. **R09s, double-click on a downpipe (BUG-859): READY, for one part.**
   1. **What it proves:** double-click the outer circle of a new DP1 downpipe. CE's own Edit source window opens with DP1 in the tag box. AutoCAD's attribute editor never appears.
   2. **Not covered:** the red centre, the DP text, the green label, and saving a changed tag with OK.
4. **N32, office layers (card D24): READY, for one part.**
   1. **What it proves:** place one pit and draw one pipe. All 8 new objects land on their own layers: pit on STORMWATER PIT, IL texts on 20TEXT, arrow on ARROW, and so on. Nothing lands on layer 0, and the current layer stays BLOCKS.
   2. **Not covered:** layer colours, other pipe types, and objects inside blocks.
5. **N36, downpipe speed (BUG-1228): NEEDS FIX. No slip written.**
   1. **The fix itself works.** DP now takes about 8 s on the test drawing instead of about 29 s.
   2. **The case's time limits are too tight.** Its very first run failed when nothing was wrong. One read took 1.6 s against a 1.5 s limit, and the whole DP took 11.3 s against 10 s.
   3. **The cure:** loosen the limits to 3 s and 20 s, and add one count check that cannot flake. Then run it twice more.
6. **Nothing here needs you in AutoCAD.** BUG-372 and BUG-859 stay open until you confirm them by hand.

---

## Per-case reasons (for the desk and the case owner)

### How I checked

1. **Read:** `C:\TimOS\RULES.md`; the B8 method report; the R14 slip (format); each case, every twin and the `.pre_review` diffs; BUG-372, BUG-859 and BUG-1228 in `BUG_CARPARK.md`; Codex review cx_cr25; `Get-CaseIndependentReview` and `Resolve-CaseAcceptance` in `case_runner.ps1`; the `matches` verb in `case_runner_lib.ps1` line 448 (no regex options, so `^` is the start of the text and `.` does not cross a newline).
2. **Runs:** every 3.0.86 runner report named in the brief (.md and .json), read with a scratch script in `C:\ce_rc_scratch\opusc76\`. The pack logs in `C:\ce-fx\c75regrade3\` are 500-byte summaries only. The .json cuts recorded text at 4,000 characters, so for N36 I read the full timing lines from CE's own log, `%APPDATA%\CE_CVL_SUITE\logs\CE_CVL_SUITE.log`, `.log.1` and `.log.2`.
3. **Hashes:** every case file hashed with SHA-256 at 07:31. Each equals the hash the runner recorded for its passing runs (listed per case below). Nothing changed while I worked.
4. **Source:** `origin/claude/rel-20261029a` resolves to `5888ee757244` ("Version: Civil 3.0.86 / Manager 1.1.86 (C-76)"). I used `git show` and `git grep` only. Every setting name in the five cases and their twins is exact, with the default stated below.
5. **Where the gate looks:** it reads `<id>_*.review.txt` only in `cases\` and `cases\variants\`. The R22 slip is in `cases\`. **The N32, N33 and R09s slips sit beside their cases in the drafts folders, as the brief asked, so the gate will not see them until case and slip move into `cases\` together.** The slip is bound to the case's SHA-256, so moving the file without editing it keeps it valid.

### Case 1: R22, CDCHECK lines show no internal ids (BUG-372, PR #1835). CLAUDE-ACCEPTED-READY for PART. Slip written.

1. **Hash:** `8C3D7C746AD46DE73F7F630E6D8233442651A1EF129C469276B85E7C0D8FC835`, the same in a80R22, b80R22, and the 3.0.85 runs aX9 and bX9.
2. **Runs:** PASS in RUN-20261029-1907-C3.0.86-a80R22-s1 and RUN-20261029-2018-C3.0.86-b80R22-s1, two AutoCAD starts. Each read 98 command-line lines, holding the CDCHECK summary "212 objects, 184 connections" and the numbered rows.
3. **Reds, both valid:**
   1. The same text FAILED on 3.0.85 (aX9, bX9).
   2. Twin R22_OFF_BROKEN (`checks.cdcheckLinesShowNoInternalIds false`) FAILED in a80D-s1 on exactly checks 2 and 3. It found 27 lines with "handle " (for example "FALL arrow, handle 1197BB") and 17 with "CE-CIV-PIPE-". Check 1 ("[CE] CDCHECK:") passed, so the red is the wording, not a broken route.
4. **Source:** the switch is `checks.cdcheckLinesShowNoInternalIds`, default true (`UserSettings.cs` line 3321). `SpineCheckCommand.cs` lines 104 to 122 pass it to the row text, the FALL-arrow lines and the pipe-end lines.
5. **Seen in the passing runs:** "1. An unnamed pipe flows to WT4: Unresolved (not confirmed from the other side)" and "[CE] Pipe end 19. Pipe 150: one end is not connected (the start)". The FALL-arrow line in words was not in the saved text; only the absence of "handle " is recorded for it.
6. **Why PART, not whole:**
   1. BUG-372 as filed is the STRETCH and MOVE line naming a handle or "the block Drawing Border". That is not driven.
   2. The Csv answer, the Checks palette (BUG-753, BUG-814) and the schedule footer (BUG-360) are not read. The case's own NOT_AUTOMATED line says so.
7. **Weak point, not a block:** checks 2 to 6 are all absence checks. A build that printed the summary and no rows would pass. Suggested lines, to add at the next edit (each seen verbatim in both passes):
   1. `history has "1. An unnamed pipe flows to WT4: Unresolved"`
   2. `history has "Pipe end 19. Pipe 150: one end is not connected (the start)"`
8. **Header:** `EXPECT-FAIL BUG-372` and the EXPECTED text ("MEANT to FAIL") are stale. As B8 found, a stale tag does not block a PASS. It would file a future regression as an "expected" failure. Remove both at the next edit. The edit changes the hash; the twin keeps the red (VARIANT_OF R22).

### Case 2: N33, Pit Schedule group order (card D21 assertion 3). CLAUDE-ACCEPTED-READY, the case's whole claim. Slip written.

1. **Hash:** `F013F647629341867AA9AE916DFC6E16AD9B517583BF010BFBF712A606B31F31` in a80K1 and b80K1. Twin `2A2F034EA688...`. The Codex review cx_cr25 read an earlier text (DC4CBDA88743). Both its asks are now in: the SETTING line in case and twin, and the two presence checks in the twin.
2. **Runs:** PASS in RUN-20261029-1912-C3.0.86-a80K1-s3 and RUN-20261029-2029-C3.0.86-b80K1-s2. All 11 checks passed in each, including 4 "Pit placed successfully." lines and 4 new pits.
3. **Red:** N33_BROKEN FAILED check 5 (CP2 above P1) in a80K1-s3. Checks 1 to 4 passed, including "Pit CP2= | CP2=CP2 |" and "Pit P1= | P1=P1 |" present. It ran on a fresh drawing copy.
4. **Can a wrong build pass?** Not that I can find.
   1. The positive chain names every primary row in order, from LPD to C1.
   2. The "Pit <name>= " prefix is the row's own first cell. The FROM cell, for example "P2=P2" in P1's row, cannot satisfy it.
   3. A placing-order list, a plain text sort and a CP-before-P order all fail check 4.
5. **Source:** `linking.pitScheduleNaturalOrder` defaults to false (`UserSettings.cs` line 886), so the case's SETTING false is the shipped default. `PitIdComparer.cs` groups exactly LPD, then OG, then P plus digits, then CP plus digits, then the rest. It has no change between 3.0.85 (09126560) and 3.0.86.
6. **Limits:**
   1. The red is a flipped expectation, not a wrongly ordered drawing. That is the accepted form, as for N29 and R34sn.
   2. Not covered: D21 assertions 1 and 2 (N29), assertion 4 (N34, switch ON), names such as LPD1 or OG2, and saved row order or filters.
   3. The header still says "NOT RUN YET": stale, changes no check.

### Case 3: R09s, double-click on the DP1 downpipe (BUG-859, PR #1834 plus 7e81ac51). CLAUDE-ACCEPTED-READY for PART. Slip written.

1. **Hash:** `22A1F00846EA4BFBA30452D44CC7D7273A7AA86CD563A33537A9D19B8910D339` in a80R09s (BLOCKED), b80R09s and b80X5a. The only change from `.pre_review` moves `windows-new` after the 10 s `ui-dump` wait. That is stricter, not looser.
2. **Runs:**
   1. PASS in RUN-20261029-2000-C3.0.86-b80R09s-s1 and RUN-20261030-0519-C3.0.86-b80X5a-s1: two AutoCAD starts, 10 of 10 checks.
   2. The double-click aim check says AutoCAD picked 11C55E, the DP1 block, both times. The new window list held only "Creative Engineering | Edit source". The tag box SourceEdit.Tag read DP1. The log line "EATTEDIT stopped before AutoCAD's attribute editor opened (BUG-859, ...); source DP1" was present.
   3. RUN-20261029-1811-C3.0.86-a80R09s was BLOCKED. AutoCAD refused COM calls for 60 s at the first step. That is not a result, and the gate does not count BLOCKED as a FAIL.
3. **Reds, all failing on checks, each with check 1 (Tag: DP1) passing:**
   1. **R09S_NEW_SWITCH_OFF_BROKEN** (`doubleClick.sourceStopsAttributeEditorFirst false`) FAILED checks 2, 4, 5 and 7 to 10 in RUN-20261030-0519-C3.0.86-b80X5a-s2. Check 3 passed, as its header predicts. close-windows met "Enhanced Attribute Editor" first, then "Creative Engineering | Edit source": exactly the 3.0.85 fault. The earlier a80C09n run was BLOCKED by the same busy-AutoCAD fault, not a result.
   2. **R09S_COMPOUND_OFF_BROKEN** (`options.compoundBehaviorEnabled false`) FAILED checks 2 to 5 and 7 to 10 in a80C09c-s1.
   3. **R09_OFF_BROKEN** FAILED in a80T09. It is VARIANT_OF R09, not R09s, so it supports the story but is not R09s's red.
4. **Source:**
   1. `doubleClick.sourceStopsAttributeEditorFirst` defaults to true (`DoubleClickSettings.cs` line 52; pinned by `C76NewSwitchDefaultsTests`).
   2. `doubleClick.sourceEditWindow` and `doubleClick.opensEditWindow` exist (lines 35 and 27). `options.compoundBehaviorEnabled` defaults to true (`CompoundBehaviorDefaults.Enabled`).
   3. The log text is in `DoubleClickAttributeEditorStopRule.cs` line 50, and "target registered; CDEDIT scheduled at Idle" in `CompoundEditModeService.cs` lines 491 and 973.
5. **Why PART:** BUG-859 expects a double-click "anywhere on the DP1 symbol" to open CE's window, and "OK with a changed tag writes it". This case drives the outer circle only, and closes with the title-bar Close. Still open: the red centre, the angled DP text, the green label (BUG-860), OK saving, and Undo.
6. **Weak check, not a block:** check 6 ("editor absent 10 s later") cannot see an editor opened before step 24, because close-windows closes it first. In both twins it passed although the editor had opened. Check 5 is the real guard, and it failed correctly. The header still says "NOT RUN YET": stale.

### Case 4: N32, every new object on its office layer (card D24 assertion 2). CLAUDE-ACCEPTED-READY for PART. Slip written.

1. **Hash:** `C2AD8DEB2229B0C6DD4B18D385840D24B644934170E55AE269C9BCDEA77302E2` in a80K1 (BLOCKED), b80K1 and b80X5b. Twin `1C2329B0493F...`. cx_cr25 read BB0D461CE2B8. Its wording change, the "CL 19.000" check and the twin's control line are now in.
2. **Runs:**
   1. PASS in RUN-20261029-2029-C3.0.86-b80K1-s1 and RUN-20261030-0546-C3.0.86-b80X5b-s1: 24 of 24 checks each, with both clicks landing (cursor read-back exact).
   2. a80K1-s1 was BLOCKED at the label click: "the stored view reading is 48 s old (limit 30)". That is a robot calibration limit, not a result. **Risk for later runs:** both passes clicked with a 45 to 53 s old view, so this limit can block again.
3. **Red (real action):** N32_BROKEN renames 20TEXT to CETWIN20TEXT in Settings. It FAILED check 3 with "CETWIN20TEXT | CETWIN20TEXT". Its CLAYER check, its IL count (2) and its control line `equals $ill "CETWIN20TEXT | CETWIN20TEXT"` all passed (a80K1-s2).
4. **Can a wrong build pass?** No, within its scope. The 7 category counts add up to 8, and `count $new = 8` is asserted, so no extra top-level object can escape a layer check. There are also explicit "none on 0" and "none on BLOCKS" checks.
5. **Source:** the layer names are unchanged from 3.0.85 to 3.0.86 in `LayerService.cs`, `PitCommand.cs`, `TextService.cs`, `ArrowService.cs` and `LayerNameRule.cs` (empty diff).
6. **Why PART:**
   1. D24's "never recolour an existing layer" is not built.
   2. Layer colours and linetypes, block contents, attribute layers, other pipe types and the five Esc endings (N28) are not read.
   3. It is one ordinary pipe and one labelled pit.

### Case 5: N36, a downpipe places under budget (BUG-1228, PR #1837). NEEDS FIX. No slip written.

1. **Hash:** `98209E977450D411BDE1101DCE9C4089B67D68DAD973FCF0F4EF349748641935` in a80D (FAIL), b80N36 (PASS) and b80X5a (PASS). Twin `27C84F954BD3...`.
2. **Every timing line on 3.0.86 for this route,** from CE's own log (every line, not the cut .json):
   1. **a80D-s2, switch ON, FAIL:** landing reads 1617, 1222, 1230 and 1082 ms; change read 490 ms; DP completed 11,303 ms.
   2. **b80N36-s1, switch ON, PASS:** 1068, 885, 968 and 815 ms; change read 448 ms; DP 8,122 ms.
   3. **b80X5a-s3, switch ON, PASS:** 1172, 887, 845 and 753 ms; change read 396 ms; DP 8,182 ms.
   4. **a80D-s3, twin, switch OFF:** 5509, 5244, 4971 and 4832 ms; change read 5210 ms; DP 28,902 ms.
   5. **Other DPs on 3.0.86 without the timing log** (the R09 family at 3000,3000): 7,230 to 10,349 ms. R09s in b80X5a took 10,349 ms, over the 10 s budget, on a passing build.
3. **The first-start FAIL, explained:**
   1. In a80D-s2 every read did exactly the same work as in the two passes. The object counts are identical in all three runs: 2,068 read in full, 188,139 passed over, 4,185 reused.
   2. All four landing reads were 25 to 50 % slower, evenly. That points to the PC being slower at that moment, not to a different code path.
   3. The session started 68 s after the previous one (R22_OFF_BROKEN at 18:55:47, N36 at 18:56:55). A slower PC is a likely cause; that part is not proven.
   4. So it was not a product fault. The product did the fixed amount of work. **The FAIL was the budget, not the fix.**
4. **Budgets are not sound for a case that must not flake:**
   1. **Reads:** switch ON ran from 753 to 1617 ms. 1 of 3 runs crossed 1500 ms.
   2. **DP:** switch ON ran from 7.2 to 11.3 s across 8 comparable runs (the 3 N36 runs and 5 R09-family runs), and 2 of 8 were over 10 s. The figure also includes the runner's own wait at the next DP prompt, which the case itself admits (line 26).
   3. **The broken side is far away:** at least 4832 ms per read and 28.9 s per DP (27.6 to 32.4 s on 3.0.85). A larger budget still fails the twin by a wide margin.
5. **Also a gate block:** the a80D FAIL row carries this exact hash. `Resolve-CaseAcceptance` refuses any case with a FAIL on record on the same build and hash, so this text can never be accepted on 3.0.86. An edit gives a new hash and a clean start.
6. **Exact changes (case file `drafts_c76_29oct\N36_dp_time_under_budget.case.txt`):**
   1. **Line 47, read budget 1,500 to 3,000 ms.** Replace with `matches $civ "(?s)^(?!.*(?:Source landing index|Source change) read in (?:[3-9][0-9]{3}|[1-9][0-9]{4,}) ms)"`. Margins: 1.9 times above the slowest pass, 1.6 times below the fastest broken read.
   2. **Line 48, DP budget 10 s to 20 s.** Replace with `matches $civ "Command outcome: DP completed (?:[0-9]{1,4}|1[0-9]{4}) ms"`. Margins: 1.8 times the slowest pass, 1.45 times under the broken 28.9 s.
   3. **Add after line 46, a check that cannot flake:** `matches $civ "(?s)^(?!.*objects read in full [1-9][0-9]{4,},)"`. That means every read reads fewer than 10,000 objects in full. Seen: 2,068 to 2,072 with the switch ON, and 194,392 to 194,768 OFF. This is the real proof that each object is read once. The two time checks then only guard against gross slowness.
   4. **Text:** change TITLE line 12 and EXPECTED line 23 to "under 3 s" and "under 20 s". Change header lines 9 and 10 to match, and delete line 26's re-run advice. Delete the stale "BUILD PENDING / NOT RUN YET" lines 1 and 2.
   5. **Twin:** make the same three check changes in `N36_dp_time_under_budget_BROKEN.case.txt` (lines 42 and 43, and the new line after 41). It should then fail checks 7 and 8 (on/off wording), the new count check, the read check (4832 ms or more) and the DP check (28.9 s).
   6. **Then:** two fresh N36 runs in separate AutoCAD starts, one twin run, and a fresh review of the new hash.
7. **What the runs already show (not a verdict):** the switch-ON DP placed in 8.1 to 11.3 s with every read reading about 1 % of the objects. The switch-OFF DP took 28.9 s. The fix works on the test drawing; only the case is not fit to accept it.

### Not verified, said plainly (RULES 5.9)

1. **No picture, no AutoCAD, nothing run.** I did not run the regexes I propose for N36, or the R22 additions, through the runner's parser. They were checked by reading against the logged text only.
2. **R22:** I did not see the FALL-arrow line in words in a passing run; the saved text was cut. Only its absence with "handle " is recorded.
3. **N36:** the cause of the slow a80D session is inferred from the timing and the identical counts. I did not read Windows load. Three DP outcomes on 3.0.86 are not comparable and I left them out: 15,616 ms at 21:06 and 9,119 ms at 01:09 (packs a80F1 and b80F1, a different case and route), and 26,722 ms at 06:49 today (a blank Drawing1 with nobody at the prompt; it includes waiting time).
4. **Card text:** I did not open the D21 or D24 card files themselves. Their scope comes from cx_cr25 and the case headers.
5. **Ledger:** I did not open `ledger.json`. Gate behaviour comes from reading `case_runner.ps1` lines 116 to 126 and 266 to 286.

## Files written

1. `C:\Lisp Files\_ACAD_DRIVER\cases\R22_cdcheck_words_no_internal_ids.review.txt`
2. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_29oct_b4\N33_schedule_groups_lpd_og_p_cp_then_rest.review.txt`
3. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_c76_29oct\R09s_dp1_double_click_stops_editor_first.review.txt`
4. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_29oct_b4\N32_every_new_object_on_its_office_layer.review.txt`
5. This report. Scratch read-only script and dumps: `C:\ce_rc_scratch\opusc76\`.

## Summary

Four READY verdicts, one NEEDS FIX. N33 is ready for its whole claim (D21 group order). R22 (CDCHECK part of BUG-372), R09s (outer circle of BUG-859) and N32 (D24 layers, one pipe and one pit) are ready for a named part. N36 needs looser time limits (3 s, 20 s) plus one count check, then new runs. Its first-run FAIL was a slow PC, not the product.
