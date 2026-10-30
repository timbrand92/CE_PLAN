# Opus independent review: P01, P02 and the revised N36, plus triage of the K-series (Fri 30 Oct 2026)

Written Fri 30 Oct 2026, 12:01 to about 12:15 Melbourne (PC clock read with `date`), by the Team Opus job CE_ACAD / robot / review / 32. Read-only on the product: no AutoCAD, no runner, no driver, no build. I wrote one review slip (N36) and this report, nothing else. No case was edited.

## ANSWER FIRST

### FOR TIM

1. **P01, label goes to the leg you click (BUG-1194): NOT READY YET.** It passed 3 times in 3 AutoCAD starts. Its "switched-off" twin has never been run, so we have not yet seen the test go red when the fix is off.
2. **P02, pasted downpipe and the original's label (BUG-1140): NEEDS FIX.** It passed 3 times, but its twin has never run. The test also never checks that the pasted copy actually moved, so it could pass for the wrong reason. One small addition is listed below.
3. **N36, downpipe speed (BUG-1228): READY, for the DP part.** DP now places in about 8 to 9 s on the test drawing, against 31 s with the fix switched off. The new limits (3 s, 20 s) held comfortably and the twin failed exactly where predicted. Slip written.
4. **K01, typed level kept (BUG-025): case fault.** A 1 m pipe makes CE ask its "Grade mismatch" question, which the robot is not allowed to answer. Make the pipe 1.9 m.
5. **K02, "MIN." on a one-level label (BUG-027): case fault now, and probably a real fault behind it.** The robot could not find the "second level" tick box. From the code, the label still reads "1 IN 100 MIN." when it should not; not yet seen in a run.
6. **K03, IL text above a nearly level pipe (BUG-021): case fault.** The same wrong name for the "second level" tick box. No pipe was drawn.
7. **K04, pit squared after a turned UCS (BUG-035): case fault.** The same tick box name, plus one missing Esc at the PIT step.
8. **K05, Set my own grade on a 4-point route (BUG-041): case fault.** The same tick box name.
9. **K06, Edit Pipe moves IL text below (BUG-078): case fault.** The same tick box name.
10. **K07, 2 decimals on the Proposed line (BUG-070): case fault, which the robot saw as "AutoCAD busy".** PIT needs three Esc presses, not two.
11. **K08, Set my own grade after a type switch (BUG-187): case fault.** The button is called "Cancel without saving", not "Cancel".
12. **Bottom line:** no K result says anything about the product yet. Every red stopped before its first real check. Nothing here needs you in AutoCAD.

---

## How I checked

1. **Method:** as `OPUS_CASE_REVIEW_C76_PROOFS_30OCT.md`. I read each case and twin, the `.pre_review30` diff for N36, the bug entries, the runner .md and .json, and CE's own log `%APPDATA%\CE_CVL_SUITE\logs\CE_CVL_SUITE.log` for every N36 timing line. The gate rules come from `case_runner.ps1` lines 116 to 126.
2. **Source:** `origin/claude/rel-20261029a` = `5888ee757244` (Civil 3.0.86), `git show` and `git grep` only.
3. **Hashes (SHA-256 on disk at 12:02, equal to the `file_sha256` in every run named):**
   1. P01 `6F7B249A8154...`, twin `3397202B3CD3...`.
   2. P02 `0F5D48A216B1...`, twin `CB980017340D...`.
   3. N36 `38739F737AA298EB13AA1D14F997289E24FA772BD2C6B73E31EB94435E646DF8`, twin `71A34B705BEE...`.
4. **K-series:** a helper agent (Opus, read-only) read the five K runs, the K case files and the source. I spot-checked its two main claims myself (below).

## P01, CDTEXTSEG puts the label on the clicked leg (BUG-1194). NEEDS FIX (evidence only, no text change needed to accept). No slip.

1. **Runs:** PASS in RUN-20261030-0944-C3.0.86-aD1-s1, RUN-20261030-1003-C3.0.86-p29a-s1 and RUN-20261030-1041-C3.0.86-bD1-s1, three AutoCAD starts. All 12 checks passed each time. The values were identical each time:
   1. After the click on the short leg, the label x was 169,762.5 (limit above 168,500).
   2. After the click on the long leg 1 m from the bend, the label x was 160,000 (limit below 166,000).
   3. "Pipe text moved." appeared twice.
2. **No red.** P01_BROKEN has never run. No report, no ledger row and no pack log names it. `C:\ce-fx\p29\start2.out` (the second pack start, 10:16) is empty, and `start1.err` shows a path-with-space error ("The argument 'C:\Lisp' is not recognized"). The gate needs a recorded FAIL on an earlier build or on a broken variant, and the fix is older than any robot run (3.0.75). So the case cannot be accepted until the twin runs.
3. **Source says the twin should go red:** `PipeTextSegmentChooser.NearestSegmentToPick` (lines 147 to 179) uses the old midpoint rule when `linking.pipeTextFollowsClickedLeg` is off. The click at 169000,-96000 is 1,118 mm from the short leg's midpoint and 9,000 mm from the long leg's, so OFF gives the short leg and fails check 9. That comes from reading the code; it has not been seen.
4. **Header claim that is wrong, not a block:** the header says the second click "proves a MOVE back to the long leg, not a label that never moved". It does not. Each CDTEXTSEG first auto-places the label on the clearest leg (`PipeTextPlacementService.cs` line 33, "Pipe text auto-placed on the clearest segment"). The label x after CD was already 160,000, the same as after the second click. Check 7 (the first click honoured) and the twin still make the case sound. Fix the wording at the next edit.
5. **Stale lines:** line 1 "NOT RUN YET"; line 2 "installed commit 09126560 (Civil 3.0.85)".
6. **Next step:** run P01_BROKEN once on 3.0.86. It must fail on check 9 only (x2 about 169,762), with checks 1 to 8 passing. Then a reviewer writes the slip for this same hash (the text does not need to change).
7. **Scope when accepted:** PART of BUG-1194. Only CDTEXTSEG on a two-leg pipe without pits is covered; the CD and Edit Pipe "move arrow AND text" prompt and arrow placing are not.

## P02, a pasted downpipe leaves the original's label alone (BUG-1140, MOVE half). NEEDS FIX. No slip.

1. **Runs:** PASS in the same three starts (aD1, p29a, bD1). Each time the copy's MOVE left the original label at 0 mm, the original block at 0 mm, and the original's own MOVE took its label 2,000 mm. The paste added one object only (handle 11C598, the block): the copy has no label of its own.
2. **No red.** P02_BROKEN has never run, as for P01. The case's own header says that if the twin passes, P02 proves nothing about BUG-1140, because the carpark marks the MOVE trigger "UNSURE". So this one matters more than P01's.
3. **Gap in the checks (a false-pass route):** nothing checks that the pasted copy actually moved. If the pick-first or the MOVE on the copy did nothing, $d1 would still be 0 and the case would pass. The recorded MOVE text ("1 found", "0,3000") suggests it moved, but no check holds it. Add (case file `drafts_pilot_29oct\P02_pasted_downpipe_leaves_original_label.case.txt`):
   1. After line 63 (`field $dpB handle -> $hB`): `  field $dpB x -> $bx0` and `  field $dpB y -> $by0`.
   2. After line 73 (`dist $dpA1 ...`): `  select $n3 "handle~^{$hB}$" -> $dpB1` and `  dist $dpB1 "{$bx0},{$by0}" -> $db1`.
   3. In ASSERT, before line 90 (`number $d1 < 1`): `  number $db1 = 3000 +- 1`.
   4. The same three additions in the twin, so its checks before the intended red still prove the route.
4. **Source:** `LinkService.SourceLinkedObjectIsOwn` (`LinkService.PitOwnership.cs` lines 215 to 250) returns "accept" at once when `linking.sourceLabelOwnerCheck` is off, default on (`UserSettings.cs` line 617). Whether COPYCLIP and PASTECLIP carry the original label's handle into the copy is not something the code tells me. Only the twin run can.
5. **Stale lines:** line 1 "NOT RUN YET"; line 3 "installed commit 09126560 (Civil 3.0.85)".
6. **Next step:** make the edit, then two runs of P02 in separate starts and one run of the twin. The twin must fail on `$d1 < 1` (about 3,000 mm) and `$d2` (about 5,000 mm), with the paste and count checks passing. If the twin passes, record it as a finding: the MOVE trigger is not real, and BUG-1140 falls back to the CDREPAIR half (a Codex look).

## N36 revised, a downpipe places under budget (BUG-1228). CLAUDE-ACCEPTED-READY for PART. Slip written.

1. **The three changes asked in the C-76 review are in, exactly:**
   1. Line 46 is the new count check, `objects read in full` under 10,000.
   2. Line 47 is the read limit of 3,000 ms.
   3. Line 48 is the DP limit of 20,000 ms.
   4. The twin has the same check lines (its diff with the case is header text only).
   5. The log prints the count without a thousands comma ("objects read in full 2068,"), so the count pattern reads it correctly.
2. **Passing runs, every timing line from CE's own log:**
   1. **aN36-s1 (09:39):** landing reads 1146, 976, 989 and 824 ms, change read 451 ms, DP completed 9,158 ms.
   2. **bN36-s1 (10:40):** landing reads 1193, 893, 933 and 767 ms, change read 386 ms, DP completed 7,773 ms.
   3. **Both runs:** 2,068 to 2,072 objects read in full.
   4. **Margins:** the slowest read is 2.5 times under its limit and the slowest DP 2.2 times under. The flake that failed the old text (1,617 ms against 1,500) now has plenty of room.
3. **Twin, aN36-s2 (separate start, switch OFF):** landing reads 6278, 5365, 5698 and 5024 ms, change read 5107 ms, DP 30,974 ms, 194,392 to 194,768 read in full. It FAILED checks 7, 8, 9, 10 and 11. Those are the on/off wording, the count, the read time and the DP time: exactly the five reds the C-76 reviewer predicted. Checks 1 to 6 passed, so the red is the switch, not the route.
4. **Gate:** two passes in two starts, no FAIL on this hash (the a80D FAIL was the old text, `98209E97...`), a broken-variant FAIL, and now the slip.
5. **Why PART:** BUG-1228 also covers PIT ("pit command takes a while"), and the case's own notes leave out OF, CDFW and a DP dropped on a pipe end. Tim's target is "a second or two". The robot's 7.8 to 9.2 s includes its own wait at the next DP prompt, so this proves "much faster", not "a second or two".
6. **Stale prose, no check affected:** header line 9 and EXPECTED line 22 still say 1,500 ms and 10,000 ms. The twin's lines 3 and 19 say the same. Fix at the next edit; the edit changes the hash and needs new runs and a new slip.

## K-series triage (K01 to K08, folder drafts_carpark_29oct)

**Runs:** aD2 (K01 to K03), aD3 (K04 to K06) and aD4 (K07, K08) in the first start; bD2 (K01 to K05) and bD3 (K06 to K08) in the second. aD5 and bD4 hold no K case. Each case stopped at the same step in both starts. No ASSERT line ran in any K case, and no K twin ran.

**The common fault (K02 to K06, and K01's reset pipe).** The cases switch the second level on or off by the id `C2.SecondInvertEnabled`. On 3.0.86 the robot cannot find it. Both reports say: "no control named or with id 'C2.SecondInvertEnabled' in window 'New Pipe'".
1. **Why:** `PipeOnePageLayout.ReplaceToggleWithTick` (lines 83, 84 and 271 to 284) hides the old toggle and puts in a new tick box. The tick does not get the old id. Its screen name is "Set second end level" ("Set first end level" for the first end). I read this code myself.
2. **Fix in every case:** replace `"C2.SecondInvertEnabled"` with `"Set second end level"`, keeping the on/off value. That the robot finds the tick by that name has not been tried.

1. **K01, BUG-025 (typed 1.10 drawn as 1.11). (ii) case fault, seen as (iii) a block.**
   1. **File and hash:** `K01_typed_invert_kept_when_other_end_worked_out.case.txt`, `6f52143cebb9`.
   2. **Runs:** BLOCKED in aD2 and bD2 at step 30 (line 58, `esc-prompt`): "the AutoCAD main window is disabled: a window is open in front of it". The driver log shows "Creative Engineering | Grade mismatch".
   3. **What a drafter sees:** a 1 m pipe on "Set my own 1 in 100" with "I know one end". CE keeps its 20 mm minimum drop, so the true grade is about 1 in 50. CE then asks "Keep 1 IN 100 / Use 1 IN 50" (more than 10 % off, `CdCommand.cs` line 589). That is designed behaviour; the case wrongly expected no question.
   4. **Fix (the helper's figures):** make pipe B 1.9 m, about 5 % off, so no question.
      1. Line 48: `151000,-100000` becomes `151900,-100000`.
      2. Line 80: `near=151000,-100000,450` becomes `near=151900,-100000,450`.
      3. Line 23 (EXPECTED): 151000 becomes 151900.
      4. Line 66 (the reset pipe): the tick name as above.
      5. Twin: the same changes at lines 41, 73 and 59.
2. **K02, BUG-027 ("MIN." on a one-level label). (ii) case fault now; (i) real fault expected once fixed.**
   1. **File and hash:** `K02_one_level_label_has_no_min_suffix.case.txt`, `2069dbe0f2f2`.
   2. **Runs:** FAIL in aD2 and bD2 at step 13 (line 40), on the tick name.
   3. **What a drafter sees (from the code, not run):** a pipe with only the first level typed, AutoCalc off, gets the label "... AT 1 IN 100 MIN.". `CdCommand.Grade.cs` lines 212 to 221 at 5888ee75 still return `configured + " MIN."`. BUG-027 says Standard grade must never carry the suffix. The helper found the same code on the newest train `rel-20261030a`, and no later commit names BUG-027, so this is not a "fix in a later build" case.
   4. **Fix:** line 40 and line 57, the tick name. Then a FAIL at line 69 (`not-contains $lt "MIN."`) would be the real fault.
3. **K03, BUG-021 (IL text "Above" lands below a nearly level pipe). (ii) case fault.**
   1. **File and hash:** `K03_il_text_above_on_a_nearly_level_pipe.case.txt`, `c738d1551ecd`.
   2. **Runs:** FAIL in aD2 and bD2 at step 11 (line 34), on the tick name. No pipe was drawn.
   3. **Fix:** line 34; twin line 31.
4. **K04, BUG-035 (pit turned by a rotated UCS after CD). (ii) case fault.**
   1. **File and hash:** `K04_rotated_ucs_pit_after_cd_stays_square.case.txt`, `4d96aa74551d`.
   2. **Runs:** FAIL in aD3 and bD2 at step 14 (line 38), on the tick name.
   3. **Fix:**
      1. Line 38; twin line 33.
      2. Add `esc-prompt -> $pit_e3` after line 52 (twin after line 47). PIT needs three Esc presses (label point, cover text, next pit), as K07 showed, so it would stop there next.
5. **K05, BUG-041 (Set my own grade on a four-point route). (ii) case fault.**
   1. **File and hash:** `K05_custom_grade_four_point_route.case.txt`, `ce1720449b2f`.
   2. **Runs:** FAIL in aD3 and bD2 at step 10 (line 34), on the tick name.
   3. **Fix:** line 34; twin line 30. The 10 m route from 18.000 to 17.900 is exactly 1 in 100, so no Grade mismatch question.
6. **K06, BUG-078 (Edit Pipe will not move the IL text below). (ii) case fault.**
   1. **File and hash:** `K06_edit_pipe_moves_il_text_below.case.txt`, `eacd1cfb3194`.
   2. **Runs:** FAIL in aD3 and bD3 at step 11 (line 39), on the tick name.
   3. **Fix:** line 39; twin line 31. Not checked: whether `C2.FirstInvertIsAbove` resolves in the Edit Pipe window.
7. **K07, BUG-070 (Proposed line shows 3 decimals). (ii) case fault, seen as (iii) "AutoCAD busy".**
   1. **File and hash:** `K07_proposed_strip_two_decimals.case.txt`, `9e11748dde3e`.
   2. **Runs:** BLOCKED in aD4 and bD3 at step 13 (line 37 `wait`): "AutoCAD still busy after 30 s". The command line still read "[CE] Pit placed. Pick the next pit, or press Esc to stop."
   3. **Fix:**
      1. Add `  esc-prompt -> $pit_e3` after line 36 (twin after line 32).
      2. Line 42: `"Cancel"` becomes `"Cancel without saving"` (twin line 38).
   4. **Wording check:** the "Proposed: ... US / DS" text exists in this build (`CdViewModel.GradeSuggestion.cs` lines 251 and 263).
8. **K08, BUG-187 (Set my own grade lost after switching pipe type). (ii) case fault.**
   1. **File and hash:** `K08_set_my_own_grade_survives_type_switches.case.txt`, `410e373fc824`.
   2. **Runs:** BLOCKED in aD4 and bD3 at step 20 (line 43): "no button 'Cancel' that is on the v3 press list was found in a window matching /New Pipe/".
   3. **Why:** the button's screen name is "Cancel without saving". The runner's own tidy-up pressed it by that name, and N30 uses it.
   4. **Fix:** line 43 becomes `ui-press "New Pipe" "Cancel without saving" -> $cancel`; twin line 41 the same.

**Remembered New Pipe values (the hazard in the triage plan):** no reset pipe ran. `CD_RecentValues.json` (saved 11:42) still holds the 29 Oct values (the helper read the file), so nothing needs putting back by hand.

**Category (iv), fix not in 3.0.86:** none. No K red reached a check, so none can be put down to a missing fix.

## What I did NOT verify (RULES 5.9)

1. **No AutoCAD, nothing run.** None of the proposed edits (P02 lines, K tick name, K01 1.9 m, extra Esc) has been through the runner's parser or the robot.
2. **P01 and P02 twins:** never run. The P01 red is predicted from source only, and P02's red cannot be predicted from source.
3. **K line numbers and fixes:** from the helper's reading of the case files. I personally checked only the common fault: the tick name in source, and the "no control" and "no button 'Cancel'" text in aD2 and bD3. I did not open the K case files myself.
4. **K02's real fault** is from the code at `CdCommand.Grade.cs`, not from a drawn label.
5. **Why the second pack start (p29b) produced nothing:** I saw only the empty `start2.out` and the `start1.err` path error. I did not read the pack script.
6. **Ledger:** I did not open `ledger.json` rows. Gate behaviour is from `case_runner.ps1` lines 116 to 126.

## Files written

1. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_c76_29oct\N36_dp_time_under_budget.review.txt` (CASE_SHA256_REVIEWED 38739F737AA2...). It sits in the drafts folder, so the gate sees it only when the case and slip move into `cases\` together.
2. This report. Scratch folder `C:\ce_rc_scratch\opusk32\` (empty).

## Summary

N36 is ready for its DP part: reads under 1.2 s, DP 7.8 to 9.2 s, and the twin red on the five predicted checks. Slip written. P01 and P02 pass in three starts, but their twins never ran. P02 also needs one check that the copy moved. All eight K reds are case faults: mostly an old tick-box name, plus a 1 m pipe that triggers Grade mismatch, a missing third Esc and a wrong Cancel name. No K result tests the product yet.
