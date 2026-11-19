One-job release | Part 5 of 9: Legal point and the two end symbols | Built 2, Checked 2, Installed 0, Accepted 0 (of 9)  
Now: Placing a legal point can change a protected pipe or a pipe 30 m away, and neither approved end symbol is drawn on the main line.

**Review result.** 36 findings survived a disprove pass. Another 11 are marked “not yet disproved” and are outside that count. The examples come from the cited reviews of the main-line code at `2ce8070a`.

1. **Protected pipes and labels can change.** Placement checks the layers it will draw on, then joins or renames existing objects it never checked. In separate bench drawings a locked pipe, an externally referenced pipe and a pipe being edited in a reference all acquired a join. A locked label was renamed.  
   unsafe edit · D-216 · **survived** · [LpdTool.cs:166](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:166>) · [PipeEnds.cs:498](<C:/CE_CIVIL/src/CeCivil.Hands/Pipe/PipeEnds.cs:498>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:8>)

2. **Marking one outlet can alter a pipe 30 m away.** A loose end beside an untouched pit moved 25 mm to its wall. The drawn pipe then measured 9.775 m while its record still said 9.80 m. Placing the legal point triggered a search of every pit.  
   unsafe edit · D-270, D-274 · **survived** · [LpdTool.cs:209](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:209>) · [PipeEnds.cs:273](<C:/CE_CIVIL/src/CeCivil.Hands/Pipe/PipeEnds.cs:273>) · [PipeEnds.cs:493](<C:/CE_CIVIL/src/CeCivil.Hands/Pipe/PipeEnds.cs:493>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:6>)

3. **Storage can pass on a run with no route to the legal point.** A 10 m pipe between two isolated pits earned 0.71 m³ with no loose-end warning. In a separate check, ticking an isolated pit raised storage from 1.44 to 1.48 m³ and passed a 1.46 m³ requirement.  
   wrong figure · D-176, D-343 · **survived** · [sums.csv:69](<C:/CE_CIVIL/src/CeCivil.Brain/data/sums.csv:69>) · [sums.csv:66](<C:/CE_CIVIL/src/CeCivil.Brain/data/sums.csv:66>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Brain_Things_Network_cs.md:24>) · [evidence 2](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Brain_Sums_Evaluator_cs.md:6>)

4. **Head, orifice and discharge can pass without an outlet.** Two water levels and a permitted flow produced a head, an orifice size and a passing discharge on a site with no pit, pipe or outlet. The existing discharge test expects that pass.  
   wrong figure · D-176 · **survived** · [sums.csv:155](<C:/CE_CIVIL/src/CeCivil.Brain/data/sums.csv:155>) · [sums.csv:159](<C:/CE_CIVIL/src/CeCivil.Brain/data/sums.csv:159>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Brain_Sums_Evaluator_cs.md:14>)

5. **A failed placement can leave a broken join or a stray marker.** When both a write and its repair failed, a pipe kept its link to an erased marker. A separate failure left the marker behind. Both attempts told the drafter the new work had been erased.  
   unsafe edit · D-216 · **survived** · [LpdTool.cs:216](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:216>) · [PipeEnds.cs:487](<C:/CE_CIVIL/src/CeCivil.Hands/Pipe/PipeEnds.cs:487>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:26>)

6. **A pick on the sheet can write into the model.** The Point option passes the sheet coordinates to a model-space write. The command also lacks a drawing-wide check for read-only or reference-edit mode. What AutoCAD itself would refuse is unverified.  
   unsafe edit · D-216 · **survived** · [LpdCommand.cs:45](<C:/CE_CIVIL/src/CeCivil.Acad/LpdCommand.cs:45>) · [AcadDrawing.cs:75](<C:/CE_CIVIL/src/CeCivil.Acad/AcadDrawing.cs:75>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:10>)

7. **The council invert disappears when the last pipe is opened.** The Pipe window recreates the legal point as a pit. With a council invert of RL 5.00 m already on the drawing connection, the window ran no council-arrival check. A drafter can miss a pipe arriving too low.  
   wrong figure · D-018, D-321 · **survived** · [PipeToolWindow.cs:38](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/PipeToolWindow.cs:38>) · [PipeTool.cs:225](<C:/CE_CIVIL/src/CeCivil.Hands/Pipe/PipeTool.cs:225>) · [checks.csv:55](<C:/CE_CIVIL/src/CeCivil.Brain/data/checks.csv:55>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md:102>)

8. **The selected end can stay disconnected after the success message.** The picker offers a free start although the join accepts only the drawn downstream end. It also offers occupied ends and treats an erased partner as still attached. The command can report success while the selected pipe has no outlet.  
   unsafe edit · D-176, D-274 · **survived** · [LpdTool.cs:63](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:63>) · [tools.csv:250](<C:/CE_CIVIL/src/CeCivil.Brain/data/tools.csv:250>) · [PipeEnds.cs:325](<C:/CE_CIVIL/src/CeCivil.Hands/Pipe/PipeEnds.cs:325>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:12>) · [evidence 2](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:20>)

9. **A second system can join the outlet picked for the first.** Two downstream ends 70 mm apart both acquired the marker. An end 102 mm away stayed loose. Placement passes on the marker position and loses which pipe the drafter selected.  
   unsafe edit · D-183, D-274 · **survived** · [LpdTool.cs:209](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:209>) · [PipeEnds.cs:331](<C:/CE_CIVIL/src/CeCivil.Hands/Pipe/PipeEnds.cs:331>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:14>)

10. **A branch can acquire a second destination.** The picker treats a branch already joined to a main as having a loose end. It can add an outlet there while leaving the original junction in place.  
   unsafe edit · D-237, D-274 · **survived** · [LpdTool.cs:63](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:63>) · [PipeTool.cs:541](<C:/CE_CIVIL/src/CeCivil.Hands/Pipe/PipeTool.cs:541>) · [PipeEnds.cs:325](<C:/CE_CIVIL/src/CeCivil.Hands/Pipe/PipeEnds.cs:325>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:18>)

11. **A new pipe can stop short of the council line.** When the legal point is placed first, the next pipe stops at the near edge of its marker. A 10.00 m pipe drawn to the council line became 9.90 m, leaving a 100 mm gap on the plan.  
   wrong figure · D-275 · **survived** · [PipeTool.cs:295](<C:/CE_CIVIL/src/CeCivil.Hands/Pipe/PipeTool.cs:295>) · [PipeTool.cs:409](<C:/CE_CIVIL/src/CeCivil.Hands/Pipe/PipeTool.cs:409>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:16>)

12. **The drawing can lose the engineer’s fixed council level.** Placing the legal point saves its kind only. A level entered in Job does not set the council level or hold the arrival invert on that drawn connection. An engineer designing upstream from a fixed outlet cannot rely on the value carrying through.  
   ruling not built · D-017, D-018 · **not yet disproved** · [LpdTool.cs:168](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:168>) · [jobsettings.csv:46](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv:46>) · [sums.csv:34](<C:/CE_CIVIL/src/CeCivil.Brain/data/sums.csv:34>) · [evidence](<C:/CE_WORK/codex_test/findings/rulings_OUTLET_AND_LPD.md:32>)

13. **The existing council pit has no editable EX tag.** Placement uses the ordinary junction-pit block and warns that it needs marking as existing. The required symbol is one solid square with a cross and an editable EX-prefixed tag, such as EX SEP.  
   ruling not built · D-317, D-333 · **survived** · [LpdTool.cs:136](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:136>) · [tools.csv:275](<C:/CE_CIVIL/src/CeCivil.Brain/data/tools.csv:275>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:30>)

14. **The kerb outlet has no road-facing half circle.** The kerb choice records a stand-in and never asks which side is the road. With the marker layer set not to plot, the texts can print with no kerb symbol beside them.  
   ruling not built · D-317, D-334 · **survived** · [LpdTool.cs:140](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:140>) · [tools.csv:276](<C:/CE_CIVIL/src/CeCivil.Brain/data/tools.csv:276>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:32>)

15. **An entire run without an outlet can disappear from Unfinished.** Two pits joined by one pipe produced zero drawing-list entries. Each pipe end had a pit, so the missing outlet was overlooked. The window ranks failed checks first, and the review found no system strip that lights the affected end.  
   ruling not built · D-176, D-275, D-311 · **not yet disproved** · [Unfinished.cs:58](<C:/CE_CIVIL/src/CeCivil.Hands/Joins/Unfinished.cs:58>) · [UnfinishedList.cs:37](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/UnfinishedList.cs:37>) · [UnfinishedList.cs:117](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/UnfinishedList.cs:117>) · [evidence](<C:/CE_WORK/codex_test/findings/rulings_OUTLET_AND_LPD.md:28>) · [evidence 2](<C:/CE_WORK/codex_test/findings/rulings_OUTLET_AND_LPD.md:30>)

16. **A separately copied tag, label or symbol can still follow the original.** Moving the legal point 400 mm moved an independently copied tag 400 mm. Placing an outlet renamed a copied pipe label. A copied end symbol that keeps its old link is also picked up when the original outlet moves.  
   unsafe edit · D-340 · **survived** · [JoinStore.cs:56](<C:/CE_CIVIL/src/CeCivil.Hands/Joins/JoinStore.cs:56>) · [EndOfCommand.cs:138](<C:/CE_CIVIL/src/CeCivil.Hands/EndOfCommand.cs:138>) · [PipeTool.cs:188](<C:/CE_CIVIL/src/CeCivil.Hands/Pipe/PipeTool.cs:188>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:24>) · [evidence 2](<C:/CE_WORK/codex_test/findings/disproved_rulings_FIRST_RELEASE.md:8>)

17. **A closed pipe can be given an outlet.** A closed CE pipe with two or more vertices passes the picker. One vertex can then be treated as a free end and acquire a legal point.  
   unsafe edit · D-274 · **survived** · [LpdTool.cs:61](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:61>) · [JoinStore.cs:46](<C:/CE_CIVIL/src/CeCivil.Hands/Joins/JoinStore.cs:46>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:22>)

18. **Placing an outlet can add layers even when it draws nothing.** On an empty drawing the first marker failed and three new layers remained. Marker and text layers are created before the first circle and outside the repair step.  
   unsafe edit · D-216 · **survived** · [LpdTool.cs:180](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:180>) · [AcadDrawing.cs:360](<C:/CE_CIVIL/src/CeCivil.Acad/AcadDrawing.cs:360>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:28>)

19. **Moving the outlet can stretch its symbol or lower its text.** Moving an attached block writes its width scale into all three directions. Moving attached text writes its elevation back as zero. A stretched or mirrored outlet symbol can change shape, and elevated text can drop when it moves in plan. The native drawing effect remains unverified.  
   unsafe edit · D-199, D-216, D-274 · **survived** · [EndOfCommand.cs:297](<C:/CE_CIVIL/src/CeCivil.Hands/EndOfCommand.cs:297>) · [AcadDrawing.cs:104](<C:/CE_CIVIL/src/CeCivil.Acad/AcadDrawing.cs:104>) · [AcadDrawing.cs:145](<C:/CE_CIVIL/src/CeCivil.Acad/AcadDrawing.cs:145>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md:76>)

20. **An estimated council invert is missing from the plan.** The two LPD texts show the tag and the kind of end. Neither prints the required ‘APPROX. IL 4.95’ for an assumed invert. The schedule can show an estimate in its own column.  
   ruling not built · D-177 · **not yet disproved** · [LpdTool.cs:148](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:148>) · [tools.csv:117](<C:/CE_CIVIL/src/CeCivil.Brain/data/tools.csv:117>) · [evidence](<C:/CE_WORK/codex_test/findings/rulings_OUTLET_AND_LPD.md:40>)

21. **A confirmed council level can still read as assumed.** In the Job window, changing an assumed RL 4.95 m to a confirmed RL 4.98 m left it marked assumed. There is no control there for changing the source when the council letter arrives.  
   screen rule · D-177, D-310 · **survived** · [jobsettings.csv:46](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv:46>) · [WindowModel.cs:778](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/WindowModel.cs:778>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md:20>)

22. **The legal point can have neither a tag nor a note.** When the text scale is zero, placement warns and skips both texts. A connected council-pipe marker still reports success, and Unfinished has no reminder to add the missing text. A missing text offset or layer can cause the same omission.  
   ruling not built · D-274, D-311 · **survived** · [LpdTool.cs:157](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:157>) · [Unfinished.cs:62](<C:/CE_CIVIL/src/CeCivil.Hands/Joins/Unfinished.cs:62>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:40>)

23. **The screen-only circle can print on the issued plan.** Placement warns and continues if the existing marker layer is set to plot. A refused layer name in a damaged office list can also put the circle on layer 0, where it prints if that layer plots. No PDF was checked in the disprove pass.  
   ruling not built · D-275 · **survived** · [LpdTool.cs:112](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:112>) · [LpdTool.cs:181](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:181>) · [AcadDrawing.cs:323](<C:/CE_CIVIL/src/CeCivil.Acad/AcadDrawing.cs:323>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:34>)

24. **A kerb connection can appear in the schedule as a council pit.** The schedule uses the same ‘Council pit’ caption for every connection. A kerb, even without an arriving pipe, can therefore gain a council-pit row. D-110 calls for the existing council pit the system actually joins.  
   ruling not built · D-110, D-275 · **not yet disproved** · [ScheduleModel.cs:358](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:358>) · [schedule.csv:43](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/windows/schedule.csv:43>) · [evidence](<C:/CE_WORK/codex_test/findings/rulings_OUTLET_AND_LPD.md:34>)

25. **A private easement drain is labelled as a council pipe.** The combined choice prints ‘council pipe’ even when the destination is a private easement drain. Tim approved naming the end by kind. The exact replacement wording is open.  
   ruling not built · D-273, D-275 · **survived** · [tools.csv:272](<C:/CE_CIVIL/src/CeCivil.Brain/data/tools.csv:272>) · [LpdTool.cs:151](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:151>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:38>)

26. **Turning a rectangular council pit changes its size check.** At 1.20 m depth the recorded council condition passed for 600 × 900 mm. Entering the same dimensions as 900 × 600 mm made the check unavailable. The size lookup recognises only one order.  
   wrong figure · D-148, D-272 · **not yet disproved** · [sums.csv:164](<C:/CE_CIVIL/src/CeCivil.Brain/data/sums.csv:164>) · [checks.csv:150](<C:/CE_CIVIL/src/CeCivil.Brain/data/checks.csv:150>) · [evidence](<C:/CE_WORK/codex_test/deep_Brain.md:48>)

27. **A council-level failure omits the amount short.** At the usual 5 mm tolerance, RL 4.944 m against council RL 4.950 m correctly failed. The warning showed both levels but omitted the 6 mm shortfall. The wording test accepts that omission.  
   screen rule · D-318, D-321 · **survived** · [checks.csv:55](<C:/CE_CIVIL/src/CeCivil.Brain/data/checks.csv:55>) · [ChecksTests.cs:276](<C:/CE_CIVIL/tests/CeCivil.Brain.Tests/ChecksTests.cs:276>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md:30>)

28. **The last-pipe picture can warn about an acceptable or unknown level.** An arrival at RL 5.200 m and outlet at RL 5.204 m stayed amber at both 1 mm and 5 mm job tolerances. The picture also substitutes zero for a missing outlet level. It gives no reason for the colour.  
   screen rule · D-219, D-318, D-321 · **survived** · [PreviewPane.cs:293](<C:/CE_CIVIL/src/CeCivil.Window/Parts/PreviewPane.cs:293>) · [PreviewPane.cs:303](<C:/CE_CIVIL/src/CeCivil.Window/Parts/PreviewPane.cs:303>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md:16>)

29. **Placing the rear pit first can give it the street outlet’s number.** New pit numbers follow placement order. Placing the rear pit first can give it P1, and the drawing has no Renumber action to start from the street outlet and work upstream.  
   ruling not built · D-075, D-183 · **not yet disproved** · [PitTool.cs:119](<C:/CE_CIVIL/src/CeCivil.Hands/Pit/PitTool.cs:119>) · [evidence](<C:/CE_WORK/codex_test/findings/rulings_OUTLET_AND_LPD.md:36>)

30. **The tool can place a legal point in a metre drawing.** A bench placement succeeded with a 0.1 m marker radius. Tim chose millimetres for this job. Explaining the limit and leaving a metre drawing untouched is the planning chat’s recorded interpretation.  
   unsafe edit · D-344 · **survived** · [LpdTool.cs:104](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:104>) · [DrawingUnits.cs:23](<C:/CE_CIVIL/src/CeCivil.Hands/Units/DrawingUnits.cs:23>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:36>)

31. **A block can be recorded as the right symbol after its appearance fails to change.** If the block lists a required appearance but that setting is read-only, insertion warns and can retain the default. Placement records a completed symbol. The review did not establish that the office block has this fault.  
   ruling not built · D-216, D-333 · **survived** · [AcadDrawing.cs:454](<C:/CE_CIVIL/src/CeCivil.Acad/AcadDrawing.cs:454>) · [LpdTool.cs:195](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:195>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:48>)

32. **A hidden layer can conceal the outlet.** The layer check catches locks but does not offer to turn on an off or frozen marker or text layer. The tool can finish while the drafter cannot see what it placed.  
   screen rule · D-320 · **survived** · [LpdTool.cs:165](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:165>) · [HiddenLayers.cs:23](<C:/CE_CIVIL/src/CeCivil.Hands/HiddenLayers.cs:23>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:42>)

33. **The Job window omits two approved destinations.** LPD offers both ‘existing system on site’ and ‘soak on site’. The separate Job destination list offers neither, so those drawings cannot show the same destination in Job.  
   screen rule · D-273, D-275, D-310 · **not yet disproved** · [jobsettings.csv:45](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv:45>) · [tools.csv:270](<C:/CE_CIVIL/src/CeCivil.Brain/data/tools.csv:270>) · [evidence](<C:/CE_WORK/codex_test/findings/rulings_OUTLET_AND_LPD.md:22>)

34. **The Job window can present a provisional discharge as given.** The window offers no assumption choice for the destination or discharge. Typing a provisional 5.00 L/s over a given discharge can preserve its ‘given’ status while the office waits for council.  
   screen rule · D-030, D-074, D-310 · **not yet disproved** · [jobsettings.csv:44](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv:44>) · [WindowModel.cs:778](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/WindowModel.cs:778>) · [evidence](<C:/CE_WORK/codex_test/findings/rulings_OUTLET_AND_LPD.md:38>)

35. **Unfinished omits the reminder for the standing note.** When a connection level prints as approximate, the list can show the assumed figure but does not remind the drafter to place the one approved note on the sheet. D-248 settles its wording. Case 47 in the Part 5 test plan still calls the wording open.  
   ruling not built · D-177, D-248, D-311 · **not yet disproved** · [UnfinishedList.cs:44](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/UnfinishedList.cs:44>) · [ScheduleModel.cs:269](<C:/CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs:269>) · [testplan_p5.md:102](<C:/CE_WORK/codex_test/findings/testplan_p5.md:102>) · [evidence](<C:/CE_WORK/codex_test/findings/rulings_OUTLET_AND_LPD.md:42>)

36. **An unfinished outlet can go to plot without the open-item count.** The drawing self-check can list loose ends. The plot path does not call it to give the drafter the required one-line count before the sheet is issued.  
   ruling not built · D-188 · **survived** · [Commands.cs:89](<C:/CE_CIVIL/src/CeCivil.Acad/Commands.cs:89>) · [Commands.cs:221](<C:/CE_CIVIL/src/CeCivil.Acad/Commands.cs:221>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_rulings_DRAWING_AND_SHEETS.md:30>)

37. **The choice of end is made at a text prompt.** The drafter has to type the outlet kind without seeing the selected council-pit or kerb symbol. D-058 puts placement choices in a small window. The precise LPD window layout is still open.  
   screen rule · D-058, D-246, D-274 · **survived** · [LpdCommand.cs:68](<C:/CE_CIVIL/src/CeCivil.Acad/LpdCommand.cs:68>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_rulings_FIRST_RELEASE.md:42>)

38. **Reusing an old placement can duplicate an outlet or miss a new lock.** The placement checks the name and layers when prepared. Applying it again can write a duplicate name or miss a layer locked in the meantime. The ordinary typed command prepares a fresh placement each time.  
   unsafe edit · D-216, D-275 · **survived** · [LpdTool.cs:100](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:100>) · [LpdTool.cs:178](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:178>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:44>)

39. **A damaged marker size or position can pass the drawing check.** A supplied point with an undefined coordinate and a separate office-list radius of −1 mm were both approved for drawing. The supplied office radius is 100 mm. The review did not produce an invalid coordinate from an ordinary pick.  
   unsafe edit · D-216 · **survived** · [LpdTool.cs:113](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:113>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:46>)

40. **Crossing linework can show through the LPD text.** The tag and note are drawn without a background mask. D-260 records the planning call for masked drafting labels. Whether it also covers the separate note, and how either text looks on a plot, remain unverified.  
   ruling not built · D-039, D-260 · **survived** · [LpdTool.cs:161](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:161>) · [AcadDrawing.cs:60](<C:/CE_CIVIL/src/CeCivil.Acad/AcadDrawing.cs:60>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:50>)

41. **The marker appearance is entered twice.** The no-plot layer has its own office colour and linetype, but placement takes those values from a second list. Editing the layer standard alone can leave new markers using the old appearance.  
   ruling not built · D-013, D-275 · **survived** · [LpdTool.cs:181](<C:/CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs:181>) · [tools.csv:285](<C:/CE_CIVIL/src/CeCivil.Brain/data/tools.csv:285>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_rulings_DRAWING_AND_SHEETS.md:26>)

42. **Changing the office short name alone does not change LPD.** The office list holds the tool names, but the drawing command also registers them explicitly. Updating the list alone leaves the old short name registered. The present two names are already settled by D-274.  
   ruling not built · D-055, D-274 · **not yet disproved** · [LpdCommand.cs:22](<C:/CE_CIVIL/src/CeCivil.Acad/LpdCommand.cs:22>) · [tools.csv:268](<C:/CE_CIVIL/src/CeCivil.Brain/data/tools.csv:268>) · [evidence](<C:/CE_WORK/codex_test/findings/rulings_RIBBON_AND_NAMES.md:14>)

43. **The symbol checks can pass with both approved symbols missing.** The council test expects the ordinary block and warning. The kerb test expects no block. A ‘no pipe joined’ row can satisfy the stand-in checks, and the main-line drawing test does not check the kerb arc or its direction.  
   missing test · D-311, D-333, D-334 · **survived** · [UnfinishedTests.cs:303](<C:/CE_CIVIL/tests/CeCivil.Hands.Tests/UnfinishedTests.cs:303>) · [UnfinishedTests.cs:325](<C:/CE_CIVIL/tests/CeCivil.Hands.Tests/UnfinishedTests.cs:325>) · [PipeChecks.cs:350](<C:/CE_CIVIL/src/CeCivil.Acad/PipeChecks.cs:350>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:52>)

44. **The pick and protection tests stop before the drawing change.** The legal-point lock test protects only the destination layer. The external-reference tests use a pit. The picker test stops after offering the loose start, without checking whether placement connects that pipe.  
   missing test · D-216, D-274 · **survived** · [Entry42Tests.cs:179](<C:/CE_CIVIL/tests/CeCivil.Hands.Tests/Entry42Tests.cs:179>) · [Entry42Tests.cs:271](<C:/CE_CIVIL/tests/CeCivil.Hands.Tests/Entry42Tests.cs:271>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:58>)

45. **The recovery tests can pass with damage left behind.** Their comparison omits layers and they inject one failure at a time, so they miss a failed repair. The pipe-label check also passes when it finds zero labels to compare.  
   missing test · D-216 · **survived** · [ShouldFixTests.cs:18](<C:/CE_CIVIL/tests/CeCivil.Hands.Tests/ShouldFixTests.cs:18>) · [ShouldFixTests.cs:173](<C:/CE_CIVIL/tests/CeCivil.Hands.Tests/ShouldFixTests.cs:173>) · [ShouldFixTests.cs:194](<C:/CE_CIVIL/tests/CeCivil.Hands.Tests/ShouldFixTests.cs:194>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:56>)

46. **The refusal test takes its ‘before’ picture too early.** A successful kerb placement is made after the snapshot and before the refusal. Its objects alone satisfy the final assertion. The test cannot tell whether the refused placement added anything.  
   missing test · D-216, D-344 · **survived** · [UnfinishedTests.cs:369](<C:/CE_CIVIL/tests/CeCivil.Hands.Tests/UnfinishedTests.cs:369>) · [UnfinishedTests.cs:374](<C:/CE_CIVIL/tests/CeCivil.Hands.Tests/UnfinishedTests.cs:374>) · [evidence](<C:/CE_WORK/codex_test/findings/disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md:54>)

47. **The build still needs a drawing and plot check for this part.** The Part 5 plan records zero AutoCAD cases run. The supplied material does not establish an issued-scale plot of the approved pair, an edited EX tag after reopening, the road side on a skew kerb, or one undo restoring the whole placement. The plan describes a separate candidate build.  
   missing test · D-216, D-333, D-334 · **not yet disproved** · [testplan_p5.md:58](<C:/CE_WORK/codex_test/findings/testplan_p5.md:58>) · [testplan_p5.md:124](<C:/CE_WORK/codex_test/findings/testplan_p5.md:124>) · [evidence](<C:/CE_WORK/codex_test/findings/testplan_p5.md:124>)

---

**Review coverage.** 113 files read by 19 November 2026 at 7:48 pm AEDT across 70 findings and part reports, 32 disprove passes, 6 sweep files and 5 top-level deep reviews. Repeated reports are counted once. The 58 entries in the Part 5 test plan are proposed cases for a separate candidate.

**Verification.** This job checked the source and evidence references for all 47 entries. Product tests run here 0. AutoCAD sessions and plots 0. Only this report was written. The job brief specifies `gpt-6.2-astra`.
