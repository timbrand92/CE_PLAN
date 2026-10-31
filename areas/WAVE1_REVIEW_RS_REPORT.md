# Wave 1 paper review, job RS: writers S1, S2, S3, T1, T2 (Sat 31 Oct 2026)

Reviewer: Opus paper reviewer RS, brief `C:\CE_PLAN\desk_jobs\WAVE1_REVIEW_BRIEF.txt`. Read only: case files, writer reports, the bug carpark, the runner and driver scripts, and the code at commit 3fbb9da5 (Civil 3.0.88). Nothing was run except `validate` and `check_ids.ps1`. No case, setup, driver or settings file was edited. No slip written. Nothing committed.

## ANSWER FIRST

1. **Counts (18 case files, 9 bugs with a case):** READY TO RUN 16, FIX FIRST 0, NOT RUNNABLE 2 (W782 and its twin), NEEDS A CODEX LOOK 0 among the case files.
2. **The other 11 bugs have no case file:** 246, 312, 385, 573, 779, 783, 785, 786, 791, 744 and 746. The writers sent all 11 to a Codex look and I agree. Five covered bugs also keep a Codex half: 740, 741, 743, 780 and 784.
3. **Riskiest 1, W782 (BUG-782), NOT RUNNABLE:** line 86 types `UseLevelDirection` at CE's "Choose:" question, asked after Start Pipe. The robot cannot do that.
4. **Why W782 cannot run:** while a CE question waits, the driver refuses typed text (`acad_driver_witness_v2.ps1` line 956). Its `answer` step takes digits only (line 2210), and the runner has no answer step at all. Case R31 hit this exact question and had to end with Esc.
5. **What W782 would see:** BLOCKED at line 86, with CD still waiting. The twin stops at the same step, so it never reaches a check. Everything else in W782 is right: the levels re-derive to 18.38 kept and 18.15, and 18.28 / 18.25 on the old build.
6. **One way to repair W782 (needs a probe first):** draw C to B flat at 18.25 / 18.25 on Standard grade, so CE has nothing to ask. Then Edit Pipe changes only the B box to 18.38. The save should turn the flow to run B to C by levels, with only B marked as set by hand (section 2.9).
7. **Riskiest 2, W780 (BUG-780):** the robot has never started CD on a downpipe. If the pipe does not join DP1 or DP2, the FROM cell reads "Unknown" and the DPs check fails red for a route reason, not a CE one. Run N53 (drafts_next40_a_30oct) first.
8. **Riskiest 3, W740 (BUG-740):** the first robot run of CDSOURCE, and the first COPY of a source block on AutoCAD 2027. The words and numbers are right (ROOF DRAIN 1, 2, 3), but the route is new. A failure there means "read $s1 and $cp", not "CE wrong".
9. **Format checks:** `validate` printed 61 files checked, 0 invalid. `check_ids` said every control id is known. All 18 of my files are clean.
10. **Brief correction:** fact 4 says 'field' on an empty selection stops the case. It does not on the current runner: `case_runner_lib.ps1` line 349 returns an empty value and the step is OK. T1 found the same.
11. **S1 versus S3 on the drawn Pit Schedule:** S3 is right. DRV1_B1 does hold a drawn, linked schedule, because R33 passes with "Pit schedule cell for P3 (lid and remarks) not updated: its layer (25TEXT) is locked". That locked-layer cell is the BUG-246 condition, so BUG-246 may be closer to the robot than S1 says. Worth a wave 2 probe.
12. **Run order advice:** run N53 before W780. Run W743 before W743_BROKEN in a fresh AutoCAD start. CDTG remembers a typed cover level for the whole session against the same file path, so the twin's grate A will also read PCL 45.200. It still fails on a check, just two checks instead of one.

---

## 1. Checks run once at the start

1. **validate:** `case_runner.ps1 validate ...\drafts_wave1_31oct` printed "61 file(s) checked, 0 invalid". My files: W216 and twin, W713 and twin, W740 to W743 and twins, W780, W782, W784 and twins.
2. **check_ids:** `C:\ce-fx\c75regrade3\check_ids.ps1 -Folders drafts_wave1_31oct` printed "RESULT: every control id is known" (302 known ids, 61 files).
3. **Shared drawing fact:** README_CASES item 56 says the runner reopens a fresh session copy for every case. So drawing changes never leak between cases. Remembered values held in memory inside AutoCAD can still carry over: the CDTG cover level, and the trench width and class.

## 2. Per case

### 2.1 W216_cdfallsuggest_enter_finishes and W216_BROKEN (BUG-216): READY TO RUN, both

1. **Windows and prompts:** no CE window. The typed chain (line 24) ends at the command's own end, and esc-prompt (line 25) finds nothing to cancel. In the twin (line 21) the chain stops at "Next level", and esc-prompt cancels it. Nothing is left open.
2. **Enter count:** "CDFALLSUGGEST{NL}150000,-98000{NL}{NL}" plus the runner's one Enter gives four. That is the command, the point, a skip of the level (`FallSuggestCommand.cs` 186-192) and Enter at "Next level" (`BuildNextLevelPrompt`, AllowNone, 89-93).
3. **Words:** "CDFALLSUGGEST finished. 0 placed, 1 skipped." comes from line 75. "No level at this point" is `FallArrowGeometry.cs` 93. "Next level (0 placed, 1 skipped), or Enter to finish" is `FallSuggestPromptRules.cs` 9. A grated pit must exist or CE stops at line 54. DRV1_B1 has P4 (R22 note).
4. **Proves the bug:** without AllowNone, AutoCAD answers "Invalid point." and the count line is never in `$fs`, so line 30 fails. The twin's one change (no last Enter) leaves the count line outside the typed result, so it fails on line 30's check and does not stall.

### 2.2 W713_fallsuggest_skips_blank_spot_level and W713_BROKEN (BUG-713): READY TO RUN, both

1. **Windows and prompts:** the New Pit window is closed by "New pit, Continue placement" plus await-window-gone (lines 30-31), then three esc-prompt. CDSL asks one question and is done (`SpotLevelCommand.cs` 77-161, no carry-on). After Skip, CDFALLSUGGEST waits at "Next level". The first esc-prompt ends it ("finished" is written on Esc too, line 75) and the second finds nothing.
2. **Twin flow:** "Skip" is typed at the number question ("No spot level here"), so AutoCAD refuses it and asks again. Esc 1 cancels that, CE skips the point and the loop asks "Next level". Esc 2 ends it. No stall.
3. **Arithmetic:** the run is 2000 mm and the fall 19.020 - 19.000 = 0.020 m, so 2.000 / 0.020 = 100 and the label reads "1:100" (`BuildGradeText`, format "0.#"). The blank spot is 20 mm from the pick point and the good one 40 mm, both inside the 50 mm reach (line 37). The twin's good spot is 60 mm away, outside it.
4. **Proves the bug:** before commit 41d985c4 the reader kept the nearest spot even when it was blank. The blank one then failed to parse, so CE asked "No spot level here". Now blanks are skipped (`SpotLevelReader.cs` 60-61). The carpark's BUG-713 example is exactly this layout.
5. **Read-out checks:** the `ent-read` attribute order is tag, text, insertion (`acad_driver_v3.ps1` 826). So `LEVEL","text":"","insertion` matches line 61 when the LEVEL is empty, and the R35 pattern for P19.020 is proven. If the SPOT LEVEL block's default LEVEL is not empty, line 61 goes red and shows it plainly.
6. **Small risk:** `layer~PIT` (line 53) has not been used before. The pit block sits on "STORMWATER PIT" (R33, N-cases), so it matches.

### 2.3 W743_cdtg_blank_cover_level_is_unknown and W743_BROKEN (BUG-743, part): READY TO RUN, both

1. **Windows and prompts:** no CE window. Each chain ends complete. The runner's Enter answers "Select outlet pit or pipe (Enter to skip)" (`AgiCommand.cs` 218-225), and CDTG does not carry on. The prompt order is checked against `SourceBlockInsertCommands.cs` 159, 168, 201, 699, 733 and 763.
2. **Words and numbers:** the prompt "Cover Level (m AHD) or [Blank] <enter to skip>" is line 763. 45.2 is written "PCL 45.200 m AHD" (line 813, format 0.000). The callout sits at the start point plus 300 x 1.5 + 200 = 650 mm north (lines 681-683, 840), so near=x,-67350,400 is right. The block is "TRENCH GRATE" on layer "TRENCH GRATE" (BlockService 45, LayerService 158). The driver reads EffectiveName, so the dynamic block still matches.
3. **Proves the bug:** the Blank keyword only exists since 4b03ad1d (BUG-743 fix round). On an older build "Blank" gives "Requires numeric value" and line 57 fails.
4. **Twin note:** the cover memory is static for the whole AutoCAD session (line 33), keyed by file path plus drawing id. The runner reopens the same session copy. So when the twin runs after W743 in one session, grate A also gets 45.200 and the twin fails on lines 64 and 66, not only 66. It is still a check failure, never a stall.
5. **Run advice:** W743 itself must be the first case in its AutoCAD session to type a CDTG cover level. In this folder it is. On a rerun inside the same session, grate A would read 45.200 and fail falsely. The runner reruns a FAIL in a fresh session, so this is covered.

### 2.4 W742_cdtag_untagged_used_name_refused and W742_BROKEN (BUG-742): READY TO RUN, both

1. **Windows and prompts:** no window. The chain gives four Enters: command, pick, tag, then the runner's Enter answers "Show the tag label on the drawing?" (`SourceTagCommand.cs` 322-331). That question comes BEFORE the free-name check (351-359). esc-prompt finds nothing to cancel.
2. **Words:** "[CE] CDTAG: WT2 is already on another source. Choose a different number. Nothing was changed." comes from `SourceTagNameFreeRule.cs` 15-27. The switch is `linking.cdTagRefusesUsedNumberedName` (default true).
3. **Twin:** the switch OFF is the old route. CDTAG then tags P10 as WT2 ("[CE] Tagged WT2. ...", `SourceTagMessages.cs` 12-16), and the model space count rises. It fails on lines 33, 34 and 37, not on a step.

### 2.5 W741_cdfixtags_next_free_number and W741_BROKEN (BUG-741, WT half): READY TO RUN, both

1. **Windows and prompts:** no window. CDTAG twice, each closed by esc-prompt. "CDFIXTAGS{NL}No" plus Enter answers "Rename them now?" (`SourceTagRepairCommand.cs` 65-77) and gives "[CE] Nothing was renamed.".
2. **Arithmetic:** the family of WT1 is "WT" (`SourceFamilies.CategoryOf`). The highest WT in the drawing is 12, so the second block gets WT13. WT13 then counts as taken (`ProposeRepairs`, line 98), so the third gets WT14. The proposal line reads "  WT1 block at X .., Y .. -> WT13" (`ProposedRenameLine`). "(3 blocks)" comes from `Describe`.
3. **False-match check:** "Tagged WT1. 2 pipes ..." has a full stop after WT1, so lines 41-42 ("WT1 1", "WT1 2") cannot match it.
4. **Proves the bug:** the old code proposed "WT1 1" and "WT1 2", so lines 39-40 fail on the old build. The twin removes the WT1 pair and fails on the "Tagged WT1." count. The DRV1_B1 AGI four still give CDFIXTAGS its question, so nothing stalls. It is a behaviour twin: there is no switch for this fix.

### 2.6 W740_copy_roof_drain_keeps_whole_name and W740_BROKEN (BUG-740, CDSOURCE and COPY half): READY TO RUN, both (route risk, item 4)

1. **Windows and prompts:** CDSOURCE carries on to "Source type" after placing, and esc-prompt (line 25, line 42) ends it. The COPY chain (line 33) is the pattern R33 and R34 have passed with many times.
2. **Words and numbers:** the keyword RoofDrain gives "ROOF DRAIN" (`GenericSourceTypes.cs` Approved). The line "Source block placed. ID: ROOF DRAIN 1." comes from `SourceBlockGenericCommand.cs` 94. The copy's tag comes from `AllocateNextTag` with family "ROOF DRAIN" (`SourceFamilies.cs` 211-221), giving "ROOF DRAIN 2" (TagFor keeps the space). The copy's label is "ROOF DRAIN" or "ROOF DRAIN 2" depending on the numbering mode (`SourceNumbering.LabelFor`). The label is a DBText (`SourceTagService.cs` 639), so `text~` finds it. The second CDSOURCE then gives ROOF DRAIN 3.
3. **Proves the bug:** the old build took family "ROOF", so the copy's label read ROOF or ROOF1 (line 51 fails) and the next CDSOURCE gave ROOF DRAIN 2 again (lines 53-54 fail). The twin leaves out the COPY and fails on lines 49, 50, 53 and 54.
4. **Risk:** no robot case has driven CDSOURCE. COPY of a source block goes through `LinkService.SpineClones.cs` (157-180), which the robot has never reached on AutoCAD 2027. If the copy is not given its own number, lines 49-50 go red with the reason in `$cp` and `$new2`.

### 2.7 W784_from_column_keeps_c_pit_numbers and W784_BROKEN (BUG-784, window half): READY TO RUN, both

1. **Windows and prompts:** New Pit is closed three times by a press plus await-window-gone plus three esc. New Pipe is closed twice by Start Pipe plus await-window-gone. A Grade mismatch window is pressed Cancel only if it opened (it should not), then esc. The Pit Schedule is closed by Close plus await-window-gone. Nothing types into an open window.
2. **Arithmetic:** each pipe is 20.000 m centre to centre less 225 mm at each wall, so 19.550 m. The fall is 0.200, so 1 in 97.75: steeper than 1 in 100 and 2.25 % off it, so no Grade mismatch window. If CE pre-selects Set my own 1 in 100 (C78 item 7), 2.25 % is still under 10 %.
3. **P11 has no outlet:** both pipes arrive at 17.80 with the far end at 18.00. `SelectOutletPipe` (`PitScheduleBuilder.cs` 923-1000) finds no outlet by fall and no pipe starting at P11, so both stay inlets.
4. **FROM text:** "C5" and "C6" are kept by `KeepsPitNumberInFrom` (238-250), because "C" is not a source letter. With the switch OFF they become "C" and merge into "Cs" (282-330). The regexes on lines 103-106 stop at the next primary "Pit X=" row and let a comma-named second row through. That is right.
5. **Twin:** one change (SETTING false). It fails on lines 103, 104 and 106.

### 2.8 W780_schedule_row_below_merged_dps_keeps_own_pipe and W780_BROKEN (BUG-780): READY TO RUN, both (route risk, item 5)

1. **Windows and prompts:** the same window pattern as W784. DP carries on to "Pick the next DP", which ExpectPrompt waits for and esc-prompt ends (N36 pattern).
2. **Arithmetic:** DP to X is 10.770 m centre to centre less 0.225 = 10.545 m, fall 0.20, about 1 in 53. Y to X is 9.550 m, about 1 in 48. X to the open end is 9.775 m, about 1 in 98. All are on Standard grade (C2.IsGradeDefault on), so no window can open. At X the outlet is the X to open end pipe (18.21 at X is above 18.11 at its far end). The three arriving pipes are inlets.
3. **Rows:** the inlets ordered lowest first are DP1 18.31, DP2 18.31 and Y 18.53. The FROM labels are "DP", "DP" and P-number. They merge into "DPs" plus the Y row. With the switch ON the Y row takes source index 2 (`PitScheduleViewModel.Data.cs` 305-322): 225 and 18.53. With it OFF it takes position 1, DP2's pipe: 100 and 18.31. That is exactly the old fault, so the twin's one change fails lines 123-124.
4. **Words:** "Downpipe placed. Tag: DP1." is seen on DRV1_B1 in the ledger (H28) and N03/N04. W780 has its own SETTING group, so it is the first drawing of its AutoCAD start. BUG-1225 (DP after a reopen) is also fixed since 3.0.84.
5. **Risk:** CD started on a downpipe has never been driven (N53 is unrun). If the DP end does not join, `BuildInletFromDisplay` returns "Unknown" and the DPs check fails red. Run N53 first.

### 2.9 W782_cascade_keeps_hand_level_on_pipe_drawn_from_low_end and W782_BROKEN (BUG-782): NOT RUNNABLE, both

1. **The step that cannot work:** line 86, `type "UseLevelDirection" -Force -ExpectPrompt "Choose"`. CE asks "Choose: Use level direction [UseLevelDirection], Keep nominated direction [KeepNominatedDirection], or [Review] <Review>:" from inside CD after the New Pipe window closes (`CdCommand.cs` 266-275). AutoCAD then rejects the typed text, and the driver throws "BUSY: a CE command is waiting at a prompt ... Nothing was typed" (`acad_driver_witness_v2.ps1` 956). The only other route, `answer`, refuses letters (pattern `^[-0-9.,; ]*$`, line 2210), and the runner has no answer step (`case_runner_lib.ps1` 16-22). R31's header records the same: "A case cannot answer that question ... so it ends with Esc."
2. **No window route:** the New Pipe window has no control for the direction choice (no xaml binding; `CdViewModel.DrawFirst.cs`). Enter gives Review, which reopens the window.
3. **Everything after line 86 checks out:**
   1. New Pipe never marks levels as set by hand (no `InvertOverrideActive` write in CD).
   2. Edit Pipe marks only the box that changed (`PipeEditCommand.Update.cs` 1584-1597).
   3. Recalculate is asked only when the record's To text changes (1956-1958), so step 1 asks nothing.
   4. The cascade gives existing drop 18.40 - 18.38 = 0.02, planned up 18.30 - 0.02 = 18.28, planned down 18.28 - 0.13 = 18.15 (`InvertPropagation.cs` 378-427, 443).
   5. The fixed build keeps the upstream level: 18.38 / 18.15 (EffectiveUpstreamIL, 903-916). Min grade 9.55 / 0.23 = 1 in 41.5, shown "1:42" (not asserted).
   6. The old mapping pinned the downstream end: 18.28 / 18.25. So the twin's four changed checks (lines 150-153) are right.
   7. IL texts are made even with pipe text off (`CdCommand.cs` 681).
4. **Repair route to probe first (my suggestion, unproven):** replace lines 75-89 so that no direction question is asked:
   1. CD from C (170000,-70000) to B (160000,-70000), Standard grade, work-out off, first box 18.25 and second box 18.25. Equal levels prove no direction (`CdDrawFirstFlowService.cs` 69-81), so CE asks nothing. A flat typed pipe is allowed on Standard grade (brief fact 1).
   2. Lines 94-98 then change only the second box (the B end) from 18.25 to 18.38 and Save.
   3. The save resolves the flow by levels, so From = B. Only From is marked by hand (fromEdited = SecondInvertChangedByUser when the first box is not From, 1584-1585). The To text stays "18.25", so Recalculate is not asked.
   4. The state is then the same as the written case: drawn from C, B 18.38 typed by hand, C 18.25. Line 135's check becomes "18.25" for SecondInvert, and line 136's "but the entered levels indicate" check must be removed.
   5. **Probe this once** before rewriting. Whether Edit Pipe flips the flow on save with no question is read from the code, not seen.
5. **Other route:** a runner step that can send a keyword at a waiting CE prompt. That is a change to a pinned driver, so it needs Tim's word.

## 3. Bugs with no case (writers' routing checked)

1. **BUG-246 (S1):** agree, Codex look. Note item 11 of ANSWER FIRST: DRV1_B1's drawn schedule and R33's locked-layer cell may open a robot route through "Continue to Place / update". That button's state on 3.0.88 has not been read (S2 report section 5).
2. **BUG-312 (S1):** agree. It needs a cell edit plus a close and reopen.
3. **BUG-385 (S1):** agree. It needs a right-click "Stop overriding" and a second drawing. One Codex recheck is enough (W6-02, W7-03 earlier passes).
4. **BUG-573 (S1):** agree. It needs Place schedule, which is not on the press list.
5. **BUG-779, BUG-783 (S2):** agree. They need a typed cell edit and a context menu, and the drawn cells on DRV1_B1 are stale for every copy.
6. **BUG-785, BUG-786, BUG-791 (S3):** agree. They need the drawn table, a saved row order, or a cell edit plus a judgement of colour.
7. **BUG-744, BUG-746 (T2):** agree. The rename is refused on pit blocks (BUG-813), and the orphan record is invisible to the robot. BUG-746 fits a headless test better.

## 4. Codex halves still owed by covered bugs

1. **BUG-740:** the CDTAG Set route and the "Number sources" setting.
2. **BUG-741:** the "ROOF DRAIN 1" half (needs a prepared fixture).
3. **BUG-743:** Enter in a second drawing in the same AutoCAD.
4. **BUG-780 and BUG-784:** the drawn Pit Schedule table.
