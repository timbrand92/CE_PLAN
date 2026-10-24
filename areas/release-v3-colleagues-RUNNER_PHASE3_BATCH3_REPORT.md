# Test runner phase 3, batch 3 of 3: new daily-tool cases R31 to R40 (Sun 25 Oct 2026)

Written Sun 25 Oct 2026 about 07:50 Melbourne (PC clock) by the Team Sonnet job "TEST RUNNER PHASE 3, BATCH 3 OF 3". Job ran 03:21 to about 07:50, all outside Tim's AutoCAD hours (a Sunday). Real AutoCAD 2027 on test copies only: 44 runner runs, about 211 minutes of AutoCAD time (12 probe sessions and 32 case and variant runs), one session at a time under the shared lock as `Claude-driverv3`; Codex held the lock for about 20 minutes at 04:55 and 06:27. Nothing in `DESK_LOG.md` or `BUG_CARPARK.md` was edited. **Built and run by me. No case here has an independent review. Nothing is Tim-accepted and nothing is Claude-accepted yet.**

## ANSWER FIRST

1. **Cases chosen (priority change of 09:15 followed, not the D-list order).** From triage section A1 I took the next groups that no case R01 to R30 covers: **N1, K3, L1, M3, V2, R3, R2, S2/S3, N4, C1/D28**. Two groups needed a second case (K3 and N4), one (R2) too, so there are 13 case files: R31, R32, R32b, R33, R34, R35, R36, R37, R37b, R38, R39, R39b, R40. Built on Civil 3.0.75+2c805a39, Structural 1.0.123, Manager 1.1.75 (read from the DLLs; the installed build moved from 3.0.74 to 3.0.75 at about 03:40 when a desk install ran).
2. **Result: 11 PASS in both runs, 2 FAIL in both runs (real CE faults), 0 BLOCKED, 0 FLAKY.** Run 1 is sessions pA1 to pA5, run 2 is pB1 to pB5 (each case in its own AutoCAD session, the whole batch run twice). Every PASS case also has a deliberately broken variant that FAILS (all 12 variants recorded, same build).
3. **Per case (D card or group; run 1, run 2; the evidence line; the bug).**
   1. **R31 (N1, D01/D04 neighbour): PASS, PASS.** CD with levels 10.00 then 11.00 shows "Upstream invert is lower than downstream" in New Pipe; Start Pipe asks "Pipe was drawn Open end at point 1 (IL 10.000) ... but the entered levels indicate Open end at point 2 (IL 11.000) ..."; Esc gives "[CE] CD command cancelled." and 1034 objects before and after. The same with 0.00 then 0.50 (question names IL 0.000 and IL 0.500). Levels 11.00 then 10.00 ask nothing and place the pipe. Claims BUG-205 (the wording half only: the question names the real levels). Red: R31_broken FAIL.
   2. **R32 (K3, D17 neighbour): PASS, PASS.** A pipe between two free ends, levels 18.000 / 17.900, edited in Edit Pipe to 17.900 / 18.000: "Pipe updated.", the flow arrow block turns from rotation 0 to 3.1416, IL texts read 17.900 left and 18.000 right. Second pipe 0.50 / 0.00 edited to 0.00 / 0.50: arrow turns round too, texts IL 0.00 and IL 0.50. Claims BUG-223 and BUG-686. Red: R32_broken FAIL.
   3. **R32b (K3): FAIL, FAIL (real CE fault).** After that reversal, a second CDEDIT that changes ONLY the diameter to 150 and saves says "Pipe updated." but turns the arrow back to rotation 0.0 while the IL texts stay as typed, so the arrow points uphill against its own levels. The control (a pipe never reversed) keeps its arrow at 0.0 on the same save. Marked `EXPECT-FAIL BUG-292` (a plain Save reversing a downstream-first pipe); the match is close, not exact (see item 5.1).
   4. **R33 (L1, native protection): PASS, PASS.** With STORMWATER PIT LABEL locked, PIT plus Continue placement prints "[CE] Pit not inserted - layer 'STORMWATER PIT LABEL' is locked. Unlock the layer, then run PIT or PP again." and the object count stays 1034; the same for the cover-text layer 25TEXT. With 25TEXT locked, COPY of pit P3 prints "1 pit copied and numbered as new", adds exactly one pit block and one PIT LABEL block (no cover text), names layer 25TEXT as locked, and lists "Pit schedule cell for P3 (lid and remarks) not updated: its layer (25TEXT) is locked"; one U brings the count back. Claims BUG-460, BUG-672 and BUG-262 (the schedule-cell wording half only). Red: R33_broken FAIL (layer not locked).
   5. **R34 (M3, D15): FAIL, FAIL (real CE fault, third failure on a third run too).** Plain COPY of P3 (control) adds the pit, a PIT LABEL block and a cover text "CL 18.88" and prints "1 pit copied and numbered as new". ROTATE Copy (90) and SCALE Copy (1.5) of the same pit add ONLY a pit block (rotated one lies exactly on the original), no PIT LABEL, no cover text, and CE prints nothing (`history count "pit copied and numbered as new"` = 1, expected 3). Marked `EXPECT-FAIL BUG-665` (ROTATE Copy and SCALE Copy leave a twin; the Grip-Ctrl copy of that entry is not driven).
   6. **R35 (V2, D26 typed half): PASS, PASS.** CDSL with 18.6m, P18.6, RL18.6, 18,6 and 18.600 prints "Spot level placed. Level: P18.600" five times and the five SPOT LEVEL blocks (layer 25DIMS) each hold the attribute value P18.600; 18600 prints `[CE] "18600" is not a level in metres (for example 18.600)...` and asks again; Esc gives "CDSL command cancelled. Nothing was placed."; file unchanged. Claims BUG-711. Red: R35_broken FAIL.
   7. **R36 (R3, D07 neighbour): PASS, PASS.** CDFW at 150000,-98000 on the drawing that holds four blocks tagged AGI prints "Floor waste placed." (no "could not be verified", no "more than one source", no rollback) and adds one FLOOR WASTE block (DOWNPIPES) and one text FW; one U takes it back; a second CDFW with Esc says "CDFW cancelled - nothing was placed.". Claims BUG-147, BUG-132, BUG-102 (by the absence of their refusal lines). Red: R36_broken FAIL.
   8. **R37 (R2, D07 neighbour): PASS, PASS.** CDPERIMETER with levels 18 and 17.9: every prompt says perimeter drain, Preview "Grade: 1:20 ... meets the office minimum 1:100", "Perimeter drain PD1 placed", one polyline and one text PD1 on layer AGI DRAIN, one U takes both back. Claims BUG-217. Red: R37_broken FAIL (Esc at Accept).
   9. **R37b (R2): PASS, PASS.** A native MOVE of the drain by 0,1000 moves the PD1 text from y -79925 to -78925; ERASE of the drain leaves no PD1 text. Claims BUG-236 (move and erase only; COPY and the text height from Settings are not driven). Red: R37b_broken FAIL.
   10. **R38 (S2/S3, D21/D23 neighbour, read only): PASS, PASS.** The Pit Schedule row of pit P3 reads FROM P4, IL (Inlet) 17.30, IL (Outlet) 17.25, cover 18.88, and both levels are IL texts drawn on the plan; the window closes by its Close button; file unchanged. Claims BUG-376. Red: R38_broken FAIL.
   11. **R39 (N4, D04 neighbour): PASS, PASS.** CD, E, a typed point on a plain 3-point polyline (after zooming to it) opens New Pipe; Start Pipe makes one CE pipe, label "225 DIA. UPVC PIPE AT 1 IN 101", IL 18.000 / 17.900; no "already a CE pipe" line (the source polyline is replaced by the pipe). Claims BUG-697. Red: R39_broken FAIL (point off the line).
   12. **R39b (N4): PASS, PASS.** CD, E on a polyline with an arc: "[CE] That line has curved sides. The pipe runs straight between its corner points, so the drawn line has been kept for you to compare."; on a closed polyline: "[CE] That line is closed, so the pipe runs from its first corner to its last without the closing side, and the drawn line has been kept."; both source polylines are still in the drawing, two pipes exist. Claims BUG-684. Red: R39b_broken FAIL (no arc, no warning, line replaced).
   13. **R40 (C1/C2/W2, D28): PASS, PASS (a window case).** CDCHECKDWG with the empty answer prints three CE lines and, a few seconds later, a fourth "wrote report"; the summary line reads "73.9% layer recognition, 19 unrecognized layers, 91 QA findings, 1 schedule issue"; the results window opens, Close closes it; no file is added beside the test copy (0 new files besides AutoCAD lock and CE backup); the file hash is unchanged. Claims BUG-606 (the report-beside-the-drawing half only). Red: R40_broken FAIL. Window picture and look note saved (item 7).
4. **Acceptance by the rule (RULES 24 Oct amendment).**
   1. **ACCEPTED-READY: 0.** The runner prints ACCEPTED-READY only with an independent review file, and none exists for R31 to R40. Every `REVIEWED_AGAINST` line is builder-filled and says "builder-filled: Opus review still needed" (condition 3 not met).
   2. **PASS-UNREVIEWED: 11** (R31, R32, R33, R35, R36, R37, R37b, R38, R39, R39b, R40): two passing sessions on 3.0.75 (the ledger shows three for most, counting my first build run), a recorded FAIL on a broken variant, no FAIL or FLAKY on the final case text. R40 is also a look case and needs a Codex look before any "accepted".
   3. **FAIL (known): 2** (R32b, R34): reported with evidence; they cannot be accepted until CE changes.
   4. **Cases that cover only part of a bug or an item count for that part only** (condition 4); the part is written in each case's `PROVES_BUGS` line and in item 5.
5. **Bugs the desk may write as FIXED (Claude-accepted, 3.0.75, 25 Oct) only after the independent review of the case, and only for the part named:** BUG-205 (wording half), BUG-223, BUG-686 (both through Edit Pipe; the CD route of BUG-686 is not driven), BUG-460, BUG-672, BUG-262 (schedule-cell wording half), BUG-711, BUG-147, BUG-132, BUG-102 (all three by absence of the old refusal), BUG-217, BUG-236 (move and erase half), BUG-376, BUG-697, BUG-684, BUG-606 (half). **Not fixed on 3.0.75:** BUG-665 (R34 FAIL; ROTATE Copy and SCALE Copy) and the diameter-only save fault below.
   1. **R32b has no exact bug number.** BUG-292 ("a downstream-first pipe could be reversed by a plain Save") and BUG-260 (arrow, labels and header disagree) are the nearest. If the desk wants a new entry, the exact steps: copy DRV1_B1; CD from 150000,-90000 to 170000,-90000, levels 18.000 / 17.900, Start Pipe, Esc; CDEDIT that pipe, set the levels 17.900 / 18.000, Save (arrow turns round, correct); CDEDIT it again, change only the diameter to 150, Save: the arrow is back at its first direction while IL 17.900 is still on the left end and IL 18.000 on the right.
6. **Other things seen (not judged, no case fails on them).**
   1. **The direction question prints the arrow as the raw text `\U+2192`** ("... (IL 10.000) \U+2192 Open end at point 2 ..."). Same family as BUG-377 and BUG-389 (escaped arrow in a user-read line), still present on 3.0.75.
   2. **The CDPERIMETER preview line shows a question mark where a dash was meant:** "Grade: 1:20 ? meets the office minimum 1:100". No bug entry found by grep.
   3. **CDCHECKDWG now writes its report to the CE logs folder under %APPDATA% (TIM_CE_CADTOOLS, logs, checkdwg), not beside the drawing** (the daily card D28 still says beside the drawing). It prints "wrote report" a few seconds after the summary. My runs left 9 small report files there (names starting CLDV3, dated 25 Oct 05:55 to 07:40); they are CE's own logs, I did not delete them.
   4. **A U right after a cancelled CDFW echoes "CDFW" and changes nothing** (found in R36's first draft; the placed floor waste needed a U of its own first). Same family as BUG-178 (cancel leaving an empty undo step). R36 now does the U before the cancelled run.
   5. **CDSL accepts "18,6" and "RL18.6" as P18.600** (BUG-711's examples); good, recorded as asserted.
7. **Window case (R40) picture and look note.** Picture `C:\Lisp Files\_TEST_COPIES_20260923\pack_runs\case_RUN-20261025-0730-C3.0.75-pB5\pictures\R40_checkdwg_results.png`, 38887 bytes, SHA-256 82DBCF5DC240F4EF; run 1 picture (pA5, 38906 bytes, SHA-256 3EB2D3DB849D37740BEB141664DBA4035B3C7ADCE77897E7F68C771C733950BE). Codex look note `...\looks\R40.md`, 1204 bytes, SHA-256 C5574DD56BB08050D8BD3AFE0AC01EB2EBB992B095DF303A1AC0139657F01825 (run 2) and 551C18E0B58AAE6164E73FC49C58B060B981FB264C091A75B7BA581BDBC34BD7 (run 1). **I looked at the picture myself (not an acceptance):** title, one summary line, "Read-only: CDCHECKDWG never opens or changes the source drawing.", "111 findings" (91 + 19 + 1), a readable list and a visible Close button. No Codex look has been written. R38 reads the Pit Schedule as text only; its picture look is R25's.
8. **Runtime.** A two-case call took 2.5 to 15 minutes (3 minutes when the PC is quiet; R31 plus R32 took 14 minutes in both runs because each pipe case places, edits and waits). Longest session about 15 minutes. All sessions under 20 minutes.
9. **What is missing (RULES 5.9).**
   1. **No independent review of any case.** No `*.review.txt` was written.
   2. **Groups with no case yet or only a start:** K2 (batch editor: Apply is not on the press list), I1 (Edit Pit: Save is not on the press list), S1 (Pit Schedule cell edits), S4 (placement), T2 (metre fixture), R1 (source tags: CDFIXTAGS proposes "AGI 1", "AGI 2", "AGI 3" with a space, BUG-814 item 4, Tim to judge; ROOF DRAIN names have no route), R4, U1 and the rest of A1.
   3. **Answers to CE command-line questions after a window press cannot be typed** (the driver refuses typed text while a CE command waits): the CD direction question is driven only to Esc (R31).
   4. **Not driven:** BUG-261 and BUG-687 (Q-only save: the Q field is behind the More button, not on the press list), BUG-650 (Esc in CDFW and the stored pit invert records), BUG-459 and BUG-565 (Edit Pit with locked text layers), the Grip-Ctrl copy of BUG-665, COPY of a drain (BUG-236), the approved report location itself (BUG-606).
   5. **Every pass is on one build (3.0.75).** A fix that arrives in a later build needs its own two passes. I did not compare the code of 3.0.75 with the cases.
   6. **R32b and R34 fail for real**, so their "red" is the real fault, not a switch; their green side is the control inside the case (pipe B, the plain COPY).

## Things that went wrong (own them)

1. **First drafts failed on my own mistakes, none reached the ledger as a pass:** R33 asserted on the `esc-prompt` tail (a FAIL on 25 Oct 04:27, fixed); R36 pressed U after a cancelled CDFW (FAIL 05:18, fixed by reordering); R37 first ended without its last Enter and BLOCKED twice; R39 BLOCKED once for a missing Esc. All are in the ledger under their earlier text hashes, so a reviewer must read the ledger by case SHA-256.
2. **Four tool calls passed the 600 second limit and were moved to the background by the tool** (the lock was held by Codex or the case was long). I waited for each in the foreground with a polling loop and did not end my turn; no test was left unattended. One of them waited about 20 minutes for Codex.
3. **A bash `sed` mangled backslashes in two case files** (a path became control characters). Found and repaired with the Edit tool before any run used the line; R40 now avoids a backslash in its assertions.
4. **The R34 case was run a third time by mistake** inside the last group (pB5); harmless, listed in the ledger.
5. **Tim's four settings files** were back at their expected fingerprints at the end of the last run (07:42): CD_Settings.json ACD64E79A33B, TIM_CE_CADTOOLS CS_Settings.json 622A246F7D3B, CE_CVL_SUITE settings.json EFE307C4FC74, Structural CS_Settings.json 2972CE70C514. No acad.exe is running and the lock file is gone. No case in this batch changes a setting.

## What a developer needs to know (short)

1. **Routes proven on 3.0.75:** `CD{NL}p1{NL}p2{NL}` then New Pipe ids C2.FirstInvert, C2.SecondInvert, C2.Diameter, Start Pipe `New pipe, Start Pipe`; `CDEDIT` on a handle picked with pick-first; Edit Pipe Save `Edit pipe, Save`; `CDSL{NL}x,y{NL}level`; `CDFW{NL}x,y`; `CDPERIMETER{NL}{NL}x1,y1{NL}x2,y2{NL}{NL}{NL}18{NL}17.9{NL}`; `CD{NL}E{NL}x,y` after a zoom; `CDCHECKDWG{NL}` (window "Check consultant", Close).
2. **Read one object's own values with `ent-read {$handle}`** (insertion point, rotation, attributes). The flow arrow is a TIM_CVL_ARROW block on layer ARROW; rotation 0 = along the drawn direction, 3.1416 = turned round.
3. **The runner, v2, v3 and both allow-lists are untouched** (hashes in the file list). `cases\README_CASES.md` got a new section (batch 3, ten learnt traps).

## The file list (sizes and SHA-256; all under `C:\Lisp Files\_ACAD_DRIVER\`, which is not a git repository)

**CASES**

1. `cases\R31_cd_uphill_levels_question_esc.case.txt`: 5625 bytes, SHA-256 FF6655B93D19F628ECED9D159EE315CE1FA6905A9CEB845D24D33B2A7FFC3300
2. `cases\R32_edit_pipe_reverse_levels_arrow_follows.case.txt`: 5523 bytes, SHA-256 013C357508D7470764DB69FE136718D7BD0E7C10307931E80BD6745125B61DB6
3. `cases\R32b_edit_pipe_size_only_keeps_arrow.case.txt`: 5148 bytes, SHA-256 5AB5BA78EF609AFC5EEA05ADBCDD106F234D8EC1A4A31BA100C8E9A6D27F569F
4. `cases\R33_locked_pit_text_layers_pit_and_copy.case.txt`: 6280 bytes, SHA-256 3E98BA5677B30AE10BBE2CDA11C9CD791FCB9B56AB4BAB0F22D4BE7822898028
5. `cases\R34_copy_rotate_scale_pit_gets_own_number.case.txt`: 3894 bytes, SHA-256 D7E167D4495294EB3730A7AB097842256A19034AFB2CE77F024D6F6177F60C8B
6. `cases\R35_cdsl_typed_level_number_check.case.txt`: 4835 bytes, SHA-256 81C7A36F125FE44F1AA2EDAA78131F478C55EA9C2CBEE4506CD04EB238273C07
7. `cases\R36_cdfw_places_with_duplicate_agi_tags.case.txt`: 3613 bytes, SHA-256 DFE8FFF4848FC80A27D28161F20ACB0115289E4553C53354D0CE9384B80A2AE1
8. `cases\R37_cdperimeter_draws_pd1_tag.case.txt`: 3962 bytes, SHA-256 60891583BAAC5F43963FD56348668D8F6BE15EF94D8EEF8AB754EDF43582F779
9. `cases\R37b_perimeter_pd1_text_follows_move_erase.case.txt`: 2811 bytes, SHA-256 FDA76E61E816F95CD479146FF30407191F194B3CEED6FC0B19CD9D61F3367529
10. `cases\R38_pit_schedule_il_cells_match_plan.case.txt`: 3569 bytes, SHA-256 29174FB955537BDD379ADBAC0E3C13A9730DB26851438C29FCF7929FF1C3019F
11. `cases\R39_cd_existing_line_opens_new_pipe.case.txt`: 4068 bytes, SHA-256 9235FDE253D9D4BC81E915DE5A8A1DCA3E827F30F76EEAA82941976C5C56951F
12. `cases\R39b_cd_existing_arc_and_closed_line_kept.case.txt`: 4874 bytes, SHA-256 CD1A7B6CAE9AC3A4BE04E3E6DB9D4EE73E804F1E77F76107CC0A20635E04473A
13. `cases\R40_cdcheckdwg_one_summary_line.case.txt`: 4309 bytes, SHA-256 A196C24A45F9616C977FC16FD7702F75077777ACAFC02C4D56EEA9AAE828C8BC

**VARIANTS (all FAIL as they must)**

1. `cases\variants\R31_broken.case.txt`: 1452 bytes, SHA-256 E727EA612158573F625A702A4B2C028C88608DC786A007C8E985F015D86746C7
2. `cases\variants\R32_broken.case.txt`: 1433 bytes, SHA-256 9B522F1E929EB485F8790F05A36A279FF056F2B4F6275E5905D1D6F38B87DE99
3. `cases\variants\R33_broken.case.txt`: 1291 bytes, SHA-256 696221D5C1BB76144B0F22EC6594B4CF360FCAC39AAE9EA8741E3EC5837ABF7D
4. `cases\variants\R35_broken.case.txt`: 1053 bytes, SHA-256 B9BA75FD32724F39FFD59BF10C153160EC9FA046C54FE2DC9D276B448EF3C307
5. `cases\variants\R36_broken.case.txt`: 1040 bytes, SHA-256 6D5FBC221FFB79E36C5F240026DC24CB087DE40D99439656C7BF819EAB0F5EA1
6. `cases\variants\R37_broken.case.txt`: 1178 bytes, SHA-256 A0644C658C65273C2E6E10FAC1FAE6837449C1836A7A14B18F3ED3D466FEF02F
7. `cases\variants\R37b_broken.case.txt`: 1294 bytes, SHA-256 9F40F9896631D39756972B12F437DA5AA4964BBFDD8E00A8D42AEAA0A3984556
8. `cases\variants\R38_broken.case.txt`: 1404 bytes, SHA-256 316CB69C4EC3011607B3AE5C701415379B0A2ABF7051A3505598BF251E1805B1
9. `cases\variants\R39_broken.case.txt`: 1280 bytes, SHA-256 966E9D6D4FD75BF954644529658795998C232CBB4CECC0F5F20CB72A8077D9FB
10. `cases\variants\R39b_broken.case.txt`: 1785 bytes, SHA-256 735548E03CFDA1E02C4688CBF176699C28A56BD9DCC5CB1B82BED00E92844A62
11. `cases\variants\R40_broken.case.txt`: 1164 bytes, SHA-256 ED13B7439D68D00ACF6D5A78F0A32C06B3E05140DEB7A59203A8CBD9D8A849D7

R34 and R32b have no broken variant: they fail for real (their control is inside the case).

**DOCS CHANGED**

1. `cases\README_CASES.md`: 12519 bytes, SHA-256 3CBAF030A86E0388A6801C1AB2441769A464507A4ADFFE393FDEA3B62C58D33A (was 10414 bytes; new section "Added in phase 3 batch 3").

**UNCHANGED RUNNER AND DRIVER FILES (same as the start of the job)**

1. `case_runner.ps1` 48803 bytes, 7E3BC77F93F4FFC6D797E2FF19AE8775882C164646206FC75C4398BD9756603F
2. `case_runner_lib.ps1` 53962 bytes, 5AB2CBC1A5A0D54096BD4028F000D17C96B7C4E41430C3C0C11710F316C6EC63
3. `acad_driver_witness_v2.ps1` 373204 bytes, 120EE24D15B25DA9D60288FD88881A49FB5945DBE22F55B1DE00305FB154A8B9
4. `acad_driver_witness_v2.allowlist.json` 7260 bytes, 5B542F2145F48936BFE11463933DA60FF9539927AB9AA0EAFEFB0169A1AADDB3
5. `acad_driver_v3.ps1` 94981 bytes, 7CADBF80D5AAF459273021E34A4ACF88AC27CF4611D2F1F20E879B8B2A1B907B
6. `acad_driver_v3_session.ps1` 51941 bytes, 9A7B8D210C7F93B73486726D8925E1DF8675CBBF88D47D583CEF7BB77EA9D31E
7. `acad_driver_v3.allowlist.json` 3487 bytes, B8B4951312839CF54E14E8AF8A12E9354FE4AB0D55BCCCEBB7CF1B58FFE9662C
8. `acad_driver_v3_watchdog.ps1` 10832 bytes, 20EB2449248E900785A43ECA31368D75DD3245C857A42C0BB443BE9468B724A7

**Run evidence (in this repository, `areas\runner-reports\`):** run 1 `RUN-20261025-0607-C3.0.75-pA1`, `...0627...pA2`, `...0638...pA3`, `...0640...pA4`, `...0643...pA5`; run 2 `RUN-20261025-0655-C3.0.75-pB1`, `...0710...pB2`, `...0720...pB3`, `...0723...pB4`, `...0730...pB5`; development and variant runs tagged `p3b3a1` to `p3b3b8` (case drafts, variants), probe runs tagged `p3b3prb*` (not cases; routes), each as .md and .json, plus `ledger.json`. Probe cases and my reading scripts: `C:\ce_rc_scratch\p3b3\` (this PC only).

## Summary (under 100 words)

Thirteen new daily-tool cases (R31 to R40 with R32b, R37b, R39b) were written from triage A1 and run twice in separate sessions on Civil 3.0.75: 11 pass both times, each with a broken variant that fails. Two fail both times for real faults: ROTATE and SCALE Copy of a pit leave a label-less twin (BUG-665), and a diameter-only Edit Pipe save turns a reversed pipe's arrow back. They name 16 bugs for the desk, no case has an independent review yet, so none is ACCEPTED-READY. Nothing left running; settings restored.
