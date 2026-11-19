One-job release | Part 6 of 9: Pit schedule | Built 2, Checked 2, Installed 0, Accepted 0 (of 9)  
Now: The plug-in cannot place a pit schedule on the drawing, and its preview can put a held level against the wrong inlet.

**Findings.** 32 survived a disprove pass. A further 18 are marked **not yet disproved**. Figures below come from the reviewed bench or source unless a drawing run is expressly named. D-288 records the planning chat’s working decisions.

1. **The drafter cannot put the schedule on the drawing.** Neither SCH nor SCHEDULE opens the new tool. OK ends at the preview. There is no pick point, no office grid of ordinary lines and text, and no placed schedule to grow downwards or refresh when a pit or pipe changes.  
   ruling not built · **survived disprove pass** · D-109, D-114, D-233 · [Commands.cs:7](<C:/CE_CIVIL/src/CeCivil.Acad/Commands.cs:7>) · [Disprove pass line 64](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:64>) · [Disprove pass line 14](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:14>)

2. **A held level can move to a different inlet.** P4’s pipe inlet was held at 6.66 m. Removing that pipe put 6.66 m against the remaining downpipe, whose level was 5.32 m. In the reverse case the downpipe kept its hold in the count, but its row reverted to 5.32 m and the hold became inaccessible.  
   unsafe edit · **survived disprove pass** · D-103, D-113, D-288 (DQ-100) · [ScheduleModel.cs:433](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:433>) · [Disprove pass line 12](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:12>) · [Disprove pass line 14](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:14>)

3. **Selecting one pit can change another pit’s inlet.** A separate pit named P4b and P4’s second inlet get the same row name internally. Selecting the separate pit and entering a level changed P4’s downpipe. Two referenced drawings each containing P1 are a further untested case.  
   unsafe edit · **survived disprove pass** · D-103, D-185, OC-13.4 · [ScheduleModel.cs:370](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:370>) · [Disprove pass line 16](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:16>) · [Disprove pass line 12](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:12>)

4. **A missing downpipe level can get a green “Suits”.** Removing the downpipe’s arriving level from an otherwise complete example left its required cell blank. The band still said “17 rows, 0 need you”. The incoming diameter has the same missing-value setting. Each required unknown belongs on the sheet as TBC.  
   wrong figure · **survived disprove pass** · D-178, D-286 rule 24, D-288 (DQ-086) · [schedule.csv:36](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/windows/schedule.csv:36>) · [Disprove pass line 18](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:18>) · [Disprove pass line 24](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:24>)

5. **A refused cover leaves the old depth looking valid.** Entering letters for P5’s cover left 0.57 m on display. On a complete example “Suits” and OK remained available. Selecting another cell cleared the refusal. The bad entry needs “Wrong” and the dependent depth needs “Cannot check yet”.  
   wrong figure · **survived disprove pass** · D-219, D-286 rules 14 and 24, D-288 (DQ-099), brief 3.3 · [ScheduleModel.cs:773](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:773>) · [Disprove pass line 24](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:24>)

6. **Impossible diameters and depths reach the preview.** The schedule accepted a −50 mm outlet diameter. Cover at 5.00 m over an outlet at 5.35 m gave a depth of −0.35 m and only “Needs a look”. Both are Wrong under the dimension rule.  
   wrong figure · **survived disprove pass** · D-288 (DQ-099) · [ScheduleModel.cs:563](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:563>) · [Disprove pass line 20](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:20>)

7. **A disconnected pipe can have letters for its diameter.** After P5’s outlet was disconnected, its diameter box accepted and displayed “abc”. Removing the pipe also removed the check that the diameter must be a number.  
   wrong figure · **survived disprove pass** · D-286 rule 24, D-288 (DQ-099), brief 3.4 · [ScheduleModel.cs:181](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:181>) · [Disprove pass line 22](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:22>)

8. **A held estimate loses its APPROX. mark.** The council inlet read “APPROX. 4.95”. Closing the padlock changed the preview to “4.95” although the source still said the level was assumed.  
   wrong figure · **survived disprove pass** · D-103, D-177, D-248 · [ScheduleModel.cs:261](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:261>) · [Disprove pass line 28](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:28>)

9. **The depth is worked out from rounded levels.** Cover 5.624 m less outlet 5.356 m is 0.268 m, which displays as 0.27 m. The schedule stores 5.62 m and 5.36 m first and shows 0.26 m. The job’s 5 mm tolerance governs checks.  
   wrong figure · **survived disprove pass** · D-103, D-321 (check tolerance), standing brief 3.3 (rounding) · [ScheduleModel.cs:568](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:568>) · [Disprove pass line 16](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:16>)

10. **A pipe that rises towards the outlet gets only an amber warning.** The pictured pipe leaves P4 at 5.28 m and arrives at P3 at a held 5.30 m. Its 20 mm rise appears as an ordinary difference from the pit value. The schedule gives no red Wrong warning for the reversed fall.  
   wrong figure · **not yet disproved** · D-286 rule 14, D-318, D-321 · [ScheduleModel.cs:719](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:719>) · [Review line 30](<C:/CE_WORK/codex_test/findings/screen_schedule.md:30>)

11. **A level below zero can escape the datum warning.** A source level of −0.20 m missed the warning on the level and its dependent depth. A typed −0.004 m became 0.00 before the check. The older preview can also omit the outline when a negative hold matches its source. A level below zero calls for an amber datum check.  
   wrong figure · **survived disprove pass** · D-288 (DQ-098) · [ScheduleModel.cs:190](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:190>) · [Disprove pass line 18](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:18>) · [Disprove pass line 26](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:26>)

12. **A refused edit can silently release the last good hold.** In the older preview’s edit sequence, 6.05 m was held over 5.92 m. Returning directly to the box and entering invalid text restored 5.92 m and opened the padlock. Reselecting the cell first preserved the hold. The two sequences were checked in the model.  
   unsafe edit · **survived disprove pass** · D-103, D-288 (DQ-100) · [SchedulePart.cs:261](<C:/CE_CIVIL/src/CeCivil.Window/Parts/SchedulePart.cs:261>) · [Disprove pass line 36](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:36>)

13. **The lid wording can disagree with the pit.** The bench review found a junction pit set to Grated while the schedule wording said “Class C Solid Lid”. The schedule takes the kind from its own row. Separately, changing a drawn block to solid was shown to leave “Grated” in the pit record.  
   wrong figure · **not yet disproved** · D-257 · [LidRule.cs:18](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/LidRule.cs:18>) · [Review line 38](<C:/CE_WORK/codex_test/deep_Bench.md:38>) · [Review line 36](<C:/CE_WORK/codex_test/findings/rulings_PIT_SCHEDULE.md:36>)

14. **Lid wording can ignore the council’s specified class.** The schedule uses the shared lid-class choice. If the office choice is D and the council specifies C, that choice still returns D. The reported case concerns which source governs the wording.  
   wrong figure · **not yet disproved** · D-240, D-242, D-243 · [OfficeChoices.cs:65](<C:/CE_CIVIL/src/CeCivil.Brain/Things/OfficeChoices.cs:65>) · [Review line 93](<C:/CE_WORK/codex_test/findings/rulings_LEVELS_AND_STANDARDS.md:93>)

15. **A kerb outlet or spare connection can be called a council pit.** The preview labels every connection “Council pit”, even one with no arriving pipe. The drafter can also untick the connected council pit and lose both of its inlet rows. The ruled row belongs to the existing council pit actually connected to.  
   ruling not built · **not yet disproved** · D-110 · [schedule.csv:43](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/windows/schedule.csv:43>) · [Review line 34](<C:/CE_WORK/codex_test/findings/rulings_OUTLET_AND_LPD.md:34>) · [Review line 14](<C:/CE_WORK/codex_test/findings/rulings_PIT_SCHEDULE.md:14>)

16. **Retyping the drawn pit number leaves the schedule’s source under the old number.** Changing the tag from P3 to P7 updates the text but leaves P3 on the pit record. A later refresh cannot get the new number from that record. The related pipe name can also retain the old number.  
   ruling not built · **survived disprove pass** · D-185 · [EndOfCommand.cs:127](<C:/CE_CIVIL/src/CeCivil.Hands/EndOfCommand.cs:127>) · [Disprove pass line 34](<C:/CE_WORK/codex_test/findings/disproved_rulings_EDITING_AND_GRIPS.md:34>) · [Disprove pass line 42](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md:42>)

17. **A second incoming pipe can have a value but no working override.** The council pit’s second pipe showed a 4.95 m invert, with the entry box and padlock disabled. Its diameter can have the same problem. A second downpipe has somewhere to save its override and is covered by a different test.  
   ruling not built · **survived disprove pass** · D-103, D-113 · [ScheduleModel.cs:435](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:435>) · [Disprove pass line 28](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:28>) · [Disprove pass line 30](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:30>)

18. **Typing a downpipe level over the schedule does not fill in the source.** The schedule can show a typed 5.40 m, yet the downpipe’s own arriving level remains missing. The supplied example starts with the source level already filled. The drafter has no field on the inlet to record that level once for both.  
   ruling not built · **not yet disproved** · D-171, D-288 (DQ-086) · [ScheduleModel.cs:574](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:574>) · [Review line 32](<C:/CE_WORK/codex_test/findings/rulings_INLETS.md:32>)

19. **A plastic pit lacks its own “In the schedule” tick.** The preview can include or exclude each sample plastic pit. The drawing’s Pit window has no matching choice to save when the drafter places the pit. The choice should start ticked and follow that pit.  
   ruling not built · **not yet disproved** · D-076, D-110 · [pit.csv:53](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/windows/pit.csv:53>) · [Review line 74](<C:/CE_WORK/codex_test/findings/rulings_PIT.md:74>) · [Review line 16](<C:/CE_WORK/codex_test/findings/rulings_PIT_SCHEDULE.md:16>)

20. **An assumption on a schedule connection can escape the Unfinished list.** A downpipe’s assumed arriving level of 4.95 m stayed on its schedule row, but the assumption list returned no entry. The disprove pass independently confirmed the omission for facts saved on connections, using a 20 mm inlet drop.  
   ruling not built · **survived disprove pass** · D-177, D-311 · [Network.cs:435](<C:/CE_CIVIL/src/CeCivil.Brain/Things/Network.cs:435>) · [Disprove pass line 36](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Brain_Things_Network_cs.md:36>) · [Review line 81](<C:/CE_WORK/codex_test/deep_Brain.md:81>)

21. **The standing-note reminder is missing.** The schedule knows when an estimate prints as APPROX., but the Unfinished list never asks the drafter to place the office’s one standing note. On a sheet with two estimates, one reminder is needed.  
   ruling not built · **survived disprove pass** · D-177, D-248, D-311 · [ScheduleModel.cs:274](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:274>) · [Disprove pass line 16](<C:/CE_WORK/codex_test/findings/disproved_rulings_FOUNDATION.md:16>)

22. **The sheet can show too many decimal places or a thousands comma.** A source invert held at 5.555 m was reported as “5.555” in the preview. A 1200 mm diameter can appear as “1,200”. The office sheet shows inverts to two places and omits thousands commas.  
   wrong figure · **not yet disproved** · D-154, D-282 (DQ-067) · [ScheduleModel.cs:503](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:503>) · [Review line 25](<C:/CE_WORK/codex_test/findings/rulings_LABELS_AND_TEXT.md:25>) · [Review line 85](<C:/CE_WORK/codex_test/findings/rulings_LABELS_AND_TEXT.md:85>)

23. **The schedule example starts the outlet at P0.** The opening example and its test require “P0 to P11”. Correcting the example to start at P1 would currently fail a test. This establishes the fault in the example and test.  
   wrong figure · **survived disprove pass** · D-075, D-183, D-288 (DQ-085) · [ScheduleWindowTests.cs:60](<C:/CE_CIVIL/bench/CeCivil.Bench.Tests/ScheduleWindowTests.cs:60>) · [Disprove pass line 52](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:52>)

24. **The schedule can reverse the outlet-first order.** The preview defaults to outlet first, but “Upstream first” reverses the pits. DQ-085 records outlet-first flow order as the planning chat’s working decision.  
   ruling not built · **not yet disproved** · D-288 (DQ-085) · [schedule.csv:193](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/windows/schedule.csv:193>) · [Review line 38](<C:/CE_WORK/codex_test/findings/rulings_PIT_SCHEDULE.md:38>)

25. **No drawing run proves the schedule survives a real edit, undo and reopen.** The 50-step Part 6 plan records zero test runs. The unproved cases include layer locks, external references, reference edits, Cancel, erase and one undo, saved holds after reopening, and matching plots with the plug-in loaded and unloaded. OC-13 also requires inserting a pit, refreshing twice, renumbering, two referenced P1s and preserving “2/375”.  
   missing test · **survived disprove pass** · D-095, D-103, D-109, D-185, D-221, D-338 · [OBSTACLE_COURSE.md:313](<C:/CE_PLAN/zero/stage6/OBSTACLE_COURSE.md:313>) · [Disprove pass line 64](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:64>) · [Disprove pass line 30](<C:/CE_WORK/codex_test/findings/disproved_rulings_EDITING_AND_GRIPS.md:30>) · [Test plan line 302](<C:/CE_WORK/codex_test/findings/testplan_p6.md:302>)

26. **A green test can bless a missing level or a mark on the wrong pit.** The band test takes its expected count from the same calculation as the window. All 19 assertions passed with the required downpipe level missing. Other checks accept TBC anywhere, an absent or misplaced warning ring, or a held count without the correct padlock. Putting “P4b” in P7’s remarks made a wrong row pass.  
   missing test · **survived disprove pass** · D-103, D-113, D-178, D-286 rule 31 · [StyleCheckTankSchedule.cs:269](<C:/CE_CIVIL/bench/CeCivil.Bench/StyleCheckTankSchedule.cs:269>) · [Disprove pass line 54](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:54>) · [Disprove pass line 56](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:56>) · [Disprove pass line 58](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:58>)

27. **The review found only a partial issued-sheet comparison.** The filed comparison covers the office headings, notes and extra inlet row. The review did not find a comparison covering the remaining inherited behaviour, including continuation, grade wording, order and keeping typed-over cells with the right pit.  
   missing test · **not yet disproved** · D-095, D-103, D-113 · [PARTS_BIN_REPORT.md:169](<C:/CE_PLAN/zero/stage3/PARTS_BIN_REPORT.md:169>) · [Review line 34](<C:/CE_WORK/codex_test/findings/rulings_PIT_SCHEDULE.md:34>)

28. **An active mismatch can disappear from the warnings.** With other pits missing lids, entering “abc” on P5 hid the warning that its held 5.30 m still differed from the pipe’s 5.37 m. In another case the band recognised the mismatch but said “0 need you”, and the first step said “Nothing needs you”.  
   screen rule · **survived disprove pass** · D-103, D-182, D-286 rule 26 · [StdTable.cs:375](<C:/CE_CIVIL/src/CeCivil.Window/Parts/Std/StdTable.cs:375>) · [Disprove pass line 32](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:32>) · [Disprove pass line 36](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:36>)

29. **The warning band loses the pairing between pits and missing figures.** P1–P4 lacked lid remarks and P5 lacked cover and depth. The band grouped all pit names ahead of all field names, so the drafter could not tell which figure belonged to P5. It also used TBC in the window, where missing values should read “Not known”.  
   screen rule · **survived disprove pass** · D-178, D-286 rule 24 · [StdTable.cs:371](<C:/CE_CIVIL/src/CeCivil.Window/Parts/Std/StdTable.cs:371>) · [Disprove pass line 34](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:34>)

30. **Warnings can run off the bottom of the window.** With two held levels on each of 12 pits, 15 of 25 warning lines fell below an window 864 units high. Only the sheet on the left scrolls. The drafter cannot reach the remaining warnings on the right.  
   screen rule · **survived disprove pass** · D-193, D-286 rule 12, D-288 (DQ-088) · [StdTable.cs:489](<C:/CE_CIVIL/src/CeCivil.Window/Parts/Std/StdTable.cs:489>) · [Disprove pass line 42](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:42>)

31. **Figures and remarks can spill into the next column.** “APPROX. 5.00” measured 84 units across in a 70-unit invert column. A line of 21 wide letters measured 275 units in 178 available for remarks. The preview can put text under the neighbouring heading.  
   screen rule · **survived disprove pass** · D-113, D-177, D-286 rule 25 · [ScheduleModel.cs:813](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:813>) · [Disprove pass line 40](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:40>) · [Disprove pass line 40](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:40>)

32. **Holding a cell can interrupt the redraw on a decimal-comma computer.** When Windows used a decimal comma, drawing the padlock raised an error after the edit had been held. The approved window could show the new band with the previous sheet and details. Australian decimal-point formatting passed the same check.  
   ruling not built · **survived disprove pass** · D-103, D-286 rules 23 and 25 · [StdTable.cs:200](<C:/CE_CIVIL/src/CeCivil.Window/Parts/Std/StdTable.cs:200>) · [Disprove pass line 44](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:44>) · [Disprove pass line 46](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:46>)

33. **A narrow 48-row preview shrinks past its minimum.** With job data supplied, the older preview scaled the sheet to 0.612 of its size at a width of 548 units. The working minimum is 0.8. The approved table at its tested width reached its last row at 0.917.  
   screen rule · **survived disprove pass** · D-288 (DQ-088) · [SchedulePart.cs:86](<C:/CE_CIVIL/src/CeCivil.Window/Parts/SchedulePart.cs:86>) · [Disprove pass line 38](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:38>) · [Disprove pass line 60](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:60>)

34. **A long schedule can redraw too slowly for typing.** Seven warmed redraws of the older 48-row preview took 151–458 ms, with a median of 276 ms. Each exceeded the 100 ms limit. These timings were measured off screen.  
   screen rule · **survived disprove pass** · D-288 (DQ-089 to DQ-091) · [SchedulePart.cs:147](<C:/CE_CIVIL/src/CeCivil.Window/Parts/SchedulePart.cs:147>) · [Disprove pass line 50](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:50>)

35. **The padlock offers to hold a missing value and does nothing.** A missing lid remark or arriving level had an enabled padlock. Clicking it left the lock open with no explanation. The box can still accept an actual value from the drafter.  
   screen rule · **survived disprove pass** · D-103, D-286 rule 23 · [ViewModels.cs:351](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ViewModels.cs:351>) · [Disprove pass line 30](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:30>) · [Disprove pass line 34](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:34>)

36. **The name read out for a cell can contradict the sheet.** The cell visibly says “APPROX. 5.18” or “TBC”, but its accessible name gives only “5.18” or “blank”. The click checks can also read this shorter name and miss the lost qualifier.  
   screen rule · **survived disprove pass** · D-177, D-178, D-286 rule 24 · [StdTable.cs:208](<C:/CE_CIVIL/src/CeCivil.Window/Parts/Std/StdTable.cs:208>) · [Disprove pass line 46](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:46>) · [Disprove pass line 44](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:44>)

37. **The older preview marks an ordinary edit like a datum warning.** Changing a positive level from 5.20 m to 5.30 m gives it the same amber outline as a below-datum warning. The approved table uses grey for this ordinary difference. The older layout also shows the internal heading “Bench preview” when supplied with job data.  
   screen rule · **survived disprove pass** · D-286 rules 13, 14 and 29, D-295, D-309 · [SchedulePart.cs:162](<C:/CE_CIVIL/src/CeCivil.Window/Parts/SchedulePart.cs:162>) · [Disprove pass line 42](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:42>)

38. **Selecting a schedule row cannot highlight its pit on the real plan.** The preview selects the cell, but there is no link that lights up the corresponding pit on the drawing. Applying the real-drawing highlight to the schedule is the planning chat’s reading of Tim’s decision.  
   ruling not built · **not yet disproved** · D-301 (planning interpretation), D-309 · [StdTable.cs:210](<C:/CE_CIVIL/src/CeCivil.Window/Parts/Std/StdTable.cs:210>) · [Review line 26](<C:/CE_WORK/codex_test/findings/rulings_PIT_SCHEDULE.md:26>)

39. **The main style check opens a different schedule layout from the job-data path.** The main style check exercises the approved table. Supplying job data selects the older tall layout, so a failure in its selection or padlock can pass that check. A separate test compares opening figures and never follows an edit into the same job’s schedule.  
   missing test · **survived disprove pass** · D-103, D-171, D-309 · [WindowSpec.cs:153](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/WindowSpec.cs:153>) · [Disprove pass line 52](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:52>) · [Disprove pass line 46](<C:/CE_WORK/codex_test/findings/disproved_rulings_FIRST_RELEASE.md:46>)

40. **The scroll and focus checks can pass without showing what the drafter sees.** The long-row test measures content height, the focus script saves a picture without checking the focus ring, and another check counts files rather than queued redraws. On the 230-character remark, one suite allows scrolling while the general check flags it. The 112-character example passed both.  
   missing test · **survived disprove pass** · D-113, D-114, D-286 rule 31, D-288 (DQ-088) · [ScheduleWindowTests.cs:553](<C:/CE_CIVIL/bench/CeCivil.Bench.Tests/ScheduleWindowTests.cs:553>) · [Disprove pass line 56](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:56>) · [Disprove pass line 60](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:60>) · [Disprove pass line 58](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_WindowFrame_cs.md:58>)

41. **Two saved click checks look for the wrong controls.** One expects an identifier on “Pit says” that the current table never supplies. The other expects “Needs a look” on the explanation line, while the words are on a separate tag. Neither script proves the intended warning.  
   missing test · **survived disprove pass** · D-286 rule 31, D-288 (DQ-098) · [fix_schedule.txt:3](<C:/CE_CIVIL/bench/clicks/fix_schedule.txt:3>) · [Disprove pass line 62](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:62>)

42. **There is no measured placement and review budget.** The proposal covers picks, clicks and typed fields, but gives no measured scroll count for reviewing 48 rows. No complete placement-and-undo run records the effort. The numerical budget is still a proposal.  
   missing test · **not yet disproved** · D-286 rule 18, D-328 · [BUDGETS_PROPOSAL.md:175](<C:/CE_PLAN/zero/design/BUDGETS_PROPOSAL.md:175>) · [Review line 38](<C:/CE_WORK/codex_test/findings/screen_schedule.md:38>)

43. **The long preview loses the selected pit and its sheet position.** On the 48-row example the side panel still names P3 after both P3 and the column headings are off screen. There is no overview showing the selection or where the schedule sits on the sheet.  
   screen rule · **not yet disproved** · D-286 rule 25, D-309 · [StdTable.cs:535](<C:/CE_CIVIL/src/CeCivil.Window/Parts/Std/StdTable.cs:535>) · [Review line 52](<C:/CE_WORK/codex_test/findings/screen_schedule.md:52>)

44. **The selected field name is cut short.** At the smaller desktop size the label for P4’s second inlet ends part-way through “Inlet invert level”. The two fixed-width columns also leave spare space unused on the larger screen.  
   screen rule · **not yet disproved** · D-193, D-286 rules 4 and 6 · [StdTable.cs:419](<C:/CE_CIVIL/src/CeCivil.Window/Parts/Std/StdTable.cs:419>) · [Review line 14](<C:/CE_WORK/codex_test/findings/screen_schedule.md:14>)

45. **The selected level and the depth are hard to check.** The held level, pit level and difference are spread across the card, while “Changed” is always in the key. A 20 mm difference has no visual comparison. A displayed depth of 6.75 m has no working beside it to show 5.75 − (−1.00) = 6.75 m.  
   screen rule · **not yet disproved** · D-286 rules 8, 9, 11 and 26, D-295 · [StdTable.cs:417](<C:/CE_CIVIL/src/CeCivil.Window/Parts/Std/StdTable.cs:417>) · [Review line 18](<C:/CE_WORK/codex_test/findings/screen_schedule.md:18>) · [Review line 20](<C:/CE_WORK/codex_test/findings/screen_schedule.md:20>) · [Review line 54](<C:/CE_WORK/codex_test/findings/screen_schedule.md:54>)

46. **The row total competes with the number needing attention.** The status band gives both numbers the same emphasis. On the 48-row example “0 need you” is as prominent as the row count even while the window warns that the schedule may not fit.  
   screen rule · **not yet disproved** · D-286 rule 7, D-295 · [StdTable.cs:367](<C:/CE_CIVIL/src/CeCivil.Window/Parts/Std/StdTable.cs:367>) · [Review line 16](<C:/CE_WORK/codex_test/findings/screen_schedule.md:16>)

47. **Small text and thin marks are hard to read.** The approved long preview can shrink its 12-unit notes to 11. In the saved reduced view the two amber cell outlines nearly disappeared. The selection, warning and key also use different corner sizes and the grid draws its own padlock.  
   screen rule · **not yet disproved** · D-286 rules 10, 12 and 27, D-295 · [StdTable.cs:191](<C:/CE_CIVIL/src/CeCivil.Window/Parts/Std/StdTable.cs:191>) · [Review line 22](<C:/CE_WORK/codex_test/findings/screen_schedule.md:22>) · [Review line 26](<C:/CE_WORK/codex_test/findings/screen_schedule.md:26>) · [Review line 56](<C:/CE_WORK/codex_test/findings/screen_schedule.md:56>)

48. **A fixed tick looks like a choice.** “Numbered pits (12)” is drawn beside the working council-pit tick. It cannot be changed, although the two controls look alike.  
   screen rule · **not yet disproved** · D-286 rule 23 · [schedule.csv:195](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/windows/schedule.csv:195>) · [Review line 48](<C:/CE_WORK/codex_test/findings/screen_schedule.md:48>)

49. **Incomplete preview wording can hide what a mark means.** With a caption removed from test data, the older preview still drew an amber swatch without a word. The approved table also opened when the caption explaining its compressed row spacing was absent. The supplied office data contains the captions.  
   screen rule · **survived disprove pass** · D-286 rules 13, 25 and 29 · [WindowSpec.cs:188](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/WindowSpec.cs:188>) · [Disprove pass line 48](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:48>) · [Disprove pass line 48](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:48>)

50. **The cell editor can show internal wording.** The inlet-level field uses the formal heading without a plain explanation. In the supplied example the no-level message even includes “D-040”. The office column headings themselves are prescribed.  
   screen rule · **not yet disproved** · D-113, D-286 rule 29 · [schedule.csv:36](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/windows/schedule.csv:36>) · [Review line 60](<C:/CE_WORK/codex_test/findings/screen_schedule.md:60>)

---

**Evidence checked.** 119 files as at 7:54 pm Melbourne time on 19 November 2026. This includes 108 files under `findings` (35 disprove passes), 6 files under `sweep_*` and 5 top-level `deep_*.md` reports. Source locations refer to local main `2ce8070`.

**Two claims resolved.** A missing cover and its dependent depth do print TBC in the preview. The faulty blank is on the incoming leg. Selecting a cell and using its separate padlock releases a known hold in one click, as approved. [Disprove pass line 38](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Brain_Things_Network_cs.md:38>) · [ScheduleModel.cs:33](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:33>) · [Disprove pass line 70](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdTable_cs.md:70>)

**Open ruling.** The council pit’s outlet dash can be replaced with a level. D-103 allows cell overrides, but the review found no decision about this particular dash. It is outside the finding counts. [Disprove pass line 32](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_SchedulePart_cs.md:32>)

**This review.** One findings file written. Product tests, AutoCAD runs and installations in this review: 0 each. Model requested: `gpt-6.2-astra`. The session identifies Codex on GPT-6 without exposing the exact variant.
