One-job release | Part 2 of 9: Pit and Pipe through the gate | Built 2, Checked 2, Installed 0, Accepted 0 (of 9)  
Now: A pit edit can move a locked pipe, a cleared cover can still print RL 5.75 m, and rounding a pipe length can turn a failing grade into “Suits”.

**Evidence.** 101 merged findings survived a disprove pass. A further 31 entries are marked “not yet disproved” and are outside that count. The reports describe the reviewed main revision `2ce8070`. Each entry links to its numbered evidence.

**Release scope.** D-344 records Tim’s choice of millimetres for the first job. The planning chat’s stated behaviour for a metre drawing is a plain refusal before any edit. The older metre-support checks and D-341 remain parked.

1. **A pit edit can move a protected pipe.** Widening an unlocked pit from 450 to 900 mm moved a joined end on a locked layer in the simulator. New placements can skip the reference-edit check. The check for external references also misses the owner of ordinary linework. A live edit inside a nested reference remains unproved.  
   D-216 · unsafe edit · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:272`, `src/CeCivil.Acad/Commands.cs:225`, `src/CeCivil.Acad/AcadDrawing.cs:372`. [Pit drawing 8](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe ends 2](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md) · [Window frame 5, 6](../disproved_deep_src_CeCivil_Window_Parts_WindowFrame_cs.md)

2. **A cleared cover can still print its old level.** Removing RL 5.75 m left “CL 5.75” on the plan. A new pit with cover text selected and no level received no cover text at all. Both cases require “CL TBC”.  
   D-178 · wrong figure · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:246`, `src/CeCivil.Hands/Pit/PitTool.cs:245`. [Pit drawing 1](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pit sizes 3](../disproved_deep_src_CeCivil_Brain_Things_PitData_cs.md)

3. **Rounding the pipe length can change the grade verdict.** A measured 10.004 m run with 50 mm fall is 1 in 200.08. Pipe handed the check 10.00 m, which returned 1 in 200.00 and “Suits”.  
   D-277, D-321 · wrong figure · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeTool.cs:217`. [Pipe drawing 19](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

4. **The section can overstate pipe cover by the full slab thickness.** At surface RL 10.00 m and invert RL 9.40 m, the sketch showed 450 mm over a 150 mm pipe under a 125 mm slab. The available cover is 325 mm. With the slab thickness missing it still showed 450 mm.  
   D-146, D-293 · wrong figure · survived disprove pass · `src/CeCivil.Window/Parts/Std/StdPictures.cs:193`. [Window sketches 1](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md)

5. **A failed edit can leave half the change on the drawing and report that it was put back.** Failing the second label erase left the first label missing. Other trials left a loose pipe trimmed or its new diameter in place. The drawing writer also lacks the original segment widths needed to restore a hand-tapered pipe.  
   D-216 · unsafe edit · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:623`, `src/CeCivil.Hands/Pit/PitTool.cs:605`, `src/CeCivil.Hands/Pipe/PipeTool.cs:658`. [Pit drawing 10, 11](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe drawing 8, 9](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

6. **Turning a label off can erase the drafter’s separate copy.** With two texts claiming the same role, Pit or Pipe can act on the last one read. The copied text disappeared while the original remained.  
   D-340 · unsafe edit · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:148`, `src/CeCivil.Hands/Pipe/PipeTool.cs:192`. [Pit drawing 7](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe drawing 1](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

7. **Changing one pit can trim a pipe at another pit.** Editing only P1’s cover joined a loose pipe to untouched P8 and moved its end by 125 mm. The search includes ends outside the edit.  
   D-176, D-270 · unsafe edit · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:601`, `src/CeCivil.Hands/Pipe/PipeEnds.cs:249`. [Pit drawing 13](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe ends 14](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

8. **A refused entry can leave a green level and a numerical fall.** On an 8 m pipe, an invalid grade left “0.08 m fall” and a downstream invert marked “Suits”. In the sketch a negative diameter could even increase the cover. The affected answers should read “Cannot check yet”.  
   D-219, D-286 · wrong figure · survived disprove pass · `src/CeCivil.Window/Parts/Std/StdSteps.cs:931`, `bench/CeCivil.Bench.Core/WindowModel.cs:746`, `src/CeCivil.Window/Parts/Std/StdPictures.cs:182`. [Window working 1](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md) · [Input controls 2](../disproved_deep_src_CeCivil_Window_Parts_Std_StdInput_cs.md) · [Window sketches 2](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md)

9. **Saving or reopening Pipe can lose the conditions used to check it.** A saved 450 mm cover requirement and its source disappeared after an ordinary edit. A reopened Pipe calculation also used 5 mm after the preceding calculation had been set to 3 mm.  
   D-086, D-287, D-318, D-321 · wrong figure · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeTool.cs:527`, `src/CeCivil.Hands/Pipe/PipeTool.cs:56`. [Pipe drawing 12, 24](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

10. **A held pit drop can disappear between the drawing and the window.** A saved 50 mm inlet drop reopened as unknown with a free upstream end. Dragging the end along the same pit also removed the saved drop and its source. Pit then lacks the level needed for the incoming pipe.  
   D-084, D-086, D-141 · wrong figure · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:652`, `src/CeCivil.Hands/Joins/JoinStore.cs:60`, `src/CeCivil.Hands/Pipe/PipeEnds.cs:314`. [Pit drawing 5](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe drawing 23](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Pipe ends 1](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

11. **OK can discard the depth the drafter held.** With outlet RL 5.00 m and a held 0.80 m depth, Pit showed cover RL 5.80 m before OK. Reopening lost the depth hold and the worked cover.  
   D-086, D-171 · wrong figure · survived disprove pass · `bench/CeCivil.Bench.Core/ToolWindow.cs:136`. [Pit drawing 30](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md)

12. **Typing one level can release another without asking.** In Pipe, entering downstream RL 5.14 m changed the held upstream level from 5.28 to 5.22 m. In Pit, holding depth can release the cover the drafter entered.  
   D-078, D-086, D-286 · wrong figure · not yet disproved · `bench/CeCivil.Bench.Core/WindowModel.cs:736`, `bench/CeCivil.Bench.Core/WindowModel.cs:734`. [Pit screen 26](../screen_pit.md) · [Pipe screen 26](../screen_pipe.md)

13. **Opening the last pipe can lose the council invert.** The drawing joined the pipe to a legal point holding RL 5.00 m. The Pipe window turned that connection into a pit and lost the council figure.  
   D-086, D-176, D-338 · wrong figure · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeTool.cs:224`. [Pipe drawing 22](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

14. **Reopening a pipe can invent a held grade.** An 8 m pipe with just its two inverts held at 5.28 and 5.24 m works out at 1 in 200. Reopening added a third hold at the office 1 in 100 and created a clash.  
   D-086, D-129 · wrong figure · not yet disproved · `bench/CeCivil.Bench.Core/PipeToolWindow.cs:55`. [Levels review 4](../rulings_LONG_SECTION.md)

15. **Accepting a copied invert can remove its assumed status.** Pit can replace the copied level’s source with “Given” and Pipe can replace it with “Chosen”. Pressing OK can save that change without the drafter confirming the level.  
   D-074, D-179 · wrong figure · not yet disproved · `bench/CeCivil.Bench.Core/WindowSpec.cs:338`. [Assumed levels 1](../rulings_MANAGER.md)

16. **A moved pit can leave the old grade on its pipe label.** Extending an 8 m pipe to 10 m with the same 80 mm fall changes its grade from 1 in 100 to 1 in 125. The ends move, but the design check and wording can wait until the window reopens.  
   D-016 · wrong figure · not yet disproved · `src/CeCivil.Hands/EndOfCommand.cs:275`. [Levels review 5](../rulings_LONG_SECTION.md)

17. **Sound cover at both pits can hide shallow cover at a bend.** The drawing-to-window handoff has no intermediate ground or paving level. It cannot distinguish a route with 240 mm at the bend from one that meets a 300 mm requirement there.  
   D-146, D-330 · wrong figure · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeTool.cs:53`. [Pipe drawing 21](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

18. **The Pipe card can hide the end with the worst cover.** With 300 mm required at both ends, it showed the end 7 mm short and omitted the other end, which was 100 mm short. Reversing the order of the pipes should not change which deficiency the drafter sees.  
   D-286, D-321 · wrong figure · not yet disproved · `bench/CeCivil.Bench.Core/WindowModel.cs:1771`. [Bench review 7](../../deep_Bench.md)

19. **The first incoming pipe can set the pit level even when another arrives lower.** For arrivals at RL 5.30 and 5.25 m, the Pit window took 5.30 m when that pipe was read first. That starts the outlet calculation 50 mm high before the pit drop.  
   D-216 · wrong figure · not yet disproved · `src/CeCivil.Hands/Pit/PitTool.cs:646`. [Drawing review 1](../../deep_Hands.md)

20. **Resizing pits can leave an old pipe length in the record or on an existing length label.** Widening both end pits left 9.10 m between the walls but saved 9.33 m. The Pit window can also leave the length unknown when the pipe has no stored measurement.  
   D-256, D-268, D-277 · wrong figure · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:554`, `src/CeCivil.Hands/Pit/PitTool.cs:525`, `src/CeCivil.Hands/Pit/PitTool.cs:499`. [Pit drawing 3, 4](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe ends 9, 10](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

21. **A hand-curved or closed pipe can have the wrong length and ends.** A semicircle of 5 m radius measured 10.00 m instead of 15.71 m. A closed 3–4–5 m triangle measured 7 m instead of 12 m, and a closed line could still acquire a start connection.  
   D-216, D-277 · wrong figure · survived disprove pass · `src/CeCivil.Acad/AcadDrawing.cs:93`, `src/CeCivil.Hands/Pipe/PipeEnds.cs:290`. [Pipe drawing 20](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Pipe ends 18](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

22. **Changing only cover can flatten or distort a pit block.** The drawing writer sets elevation to zero and uses the X scale for every axis. For a block at Z = 100 mm it requests Z = 0 even though only its cover was edited. This was traced in code.  
   D-216 · unsafe edit · survived disprove pass · `src/CeCivil.Acad/AcadDrawing.cs:145`. [Pit drawing 22](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md)

23. **A branch can report the wrong connection.** A drawn branch stores the main pipe’s name and distance along it. After the main was erased the branch still counted as joined. Editing the branch could rename its junction “free end”. A loose end dragged onto the main did not join it.  
   D-081, D-176, D-237 · wrong figure · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeTool.cs:544`, `src/CeCivil.Hands/Pipe/PipeTool.cs:324`, `src/CeCivil.Hands/Pipe/PipeEnds.cs:259`. [Pipe drawing 17, 18](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Pipe ends 21](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

24. **An assumed level can print as confirmed.** After a copied pit was opened and accepted, its stored cover still said “Assumed” but the plan read “CL 5.75”. The preview can also lose “APPROX.” from an invert.  
   D-177, D-179 · wrong figure · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:245`, `src/CeCivil.Window/Parts/Std/StdPictures.cs:153`, `src/CeCivil.Window/Parts/PreviewPane.cs:234`. [Pit drawing 2](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Window sketches 4](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md) · [Drawing preview 5](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md)

25. **The millimetre release can still change a metre drawing.** Both tools accepted placement and the end-following code moved a pipe from 0.100 to 0.225 m. D-344 parks metre support. Its recorded release behaviour is a plain message and no drawing change.  
   D-344 · unsafe edit · survived disprove pass · `src/CeCivil.Hands/Units/DrawingUnits.cs:23`, `src/CeCivil.Hands/Units/DrawingUnits.cs:21`, `src/CeCivil.Hands/Pipe/PipeEnds.cs:257`. [Pit drawing 33](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe drawing 38](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Pipe ends 22](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

26. **A damaged or newer drawing record can be treated as a usable pit or pipe.** A line carrying only a pit identity accepted a cover change. A newer pipe with its figures missing accepted a diameter edit, and a partly marked pipe fragment could gain a join in the simulator.  
   D-216 · unsafe edit · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeTool.cs:183`, `src/CeCivil.Hands/Pit/PitTool.cs:139`, `src/CeCivil.Hands/EndOfCommand.cs:102`. [Pipe drawing 2](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Pit drawing 23](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe ends 17](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

27. **An old edit can act on the wrong drawing or overwrite a newer change.** Calling the writer with a prepared edit and matching object numbers in a second drawing renamed its pit or erased its label. A lock or new join added after planning could also be missed. Normal commands prepare and apply immediately.  
   D-216 · unsafe edit · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:31`, `src/CeCivil.Hands/Pipe/PipeTool.cs:59`, `src/CeCivil.Hands/Pipe/PipeEnds.cs:23`. [Pit drawing 38](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe drawing 7](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Pipe ends 23](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

28. **A pick on the sheet can be written into model space.** Pipe does not check drawing space or whether the drawing is read-only before building the edit. The destination is model space even when the point came from the sheet. The on-screen result needs a drawing test.  
   D-216 · unsafe edit · survived disprove pass · `src/CeCivil.Acad/PipeCommand.cs:44`. [Pipe drawing 5](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

29. **A rejected layer name can send the edit to layer 0.** The drawing writer substitutes layer 0 after the protection check has inspected the requested name. An existing object can therefore change layers even though the requested destination failed.  
   D-216 · unsafe edit · not yet disproved · `src/CeCivil.Acad/AcadDrawing.cs:331`. [Protection sweep 9](../../sweep_guard/FINDINGS.md)

30. **A pit placed halfway along a pipe leaves one unbroken pipe.** A pit placed midway along a 10 m run gained no join. There should be a pipe either side of the new pit with the affected ends and labels updated.  
   D-077 · ruling not built · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:601`. [Pit drawing 21](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md)

31. **A pipe can be joined at the wrong wall or run back on itself.** A joined end dragged into a 450 mm pit stopped 125 mm inside the inner wall. A loose end can be accepted without crossing that wall, and widening a pit can attach it to the old wall or push it past its last bend.  
   D-034, D-102, D-256, D-270 · unsafe edit · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeEnds.cs:310`, `src/CeCivil.Hands/Pipe/PipeEnds.cs:122`, `src/CeCivil.Hands/Pipe/PipeEnds.cs:112`. [Pipe ends 5, 7, 8, 12](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

32. **Pipe can miss the picked spot and the actual size of the pit.** A click 100 mm off-centre on the east face was moved to the centre of that face. Scaled and stretched blocks use incomplete wall dimensions, and the first distance check can reject a valid outer corner.  
   D-034, D-102, D-270 · unsafe edit · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeTool.cs:380`, `src/CeCivil.Hands/Pipe/PipeTool.cs:435`, `src/CeCivil.Hands/Pipe/PipeEnds.cs:208`. [Pipe drawing 14, 15](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Pipe ends 26, 27](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

33. **Dragging a pipe directly from one pit to the next can lose the connection.** The first drag can detach the old end without joining the new pit. In a separate trial after an earlier pit move, the end reached P2 while the drawing still recorded P1.  
   D-176, D-270 · unsafe edit · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeEnds.cs:319`, `src/CeCivil.Hands/Pipe/PipeEnds.cs:317`. [Pipe ends 13, 28](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

34. **An inspection opening can move to the wrong bend.** Reversing the order of a two-bend pipe moved the opening from the original first bend to the other bend. The follower uses its place in the list of corners.  
   D-189, D-340 · unsafe edit · survived disprove pass · `src/CeCivil.Hands/EndOfCommand.cs:160`. [Pipe drawing 37](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

35. **Twenty approved pit sizes cannot be entered, and a pipe can refuse their walls.** The size box accepted only five of the 25 approved width–length pairs. Both entering 1200 × 900 mm and starting a new route at that pit failed.  
   D-102, D-272 · ruling not built · survived disprove pass · `bench/CeCivil.Bench.Core/WindowModel.cs:1359`, `src/CeCivil.Hands/Pipe/PipeTool.cs:419`, `src/CeCivil.Hands/Pipe/PipeEnds.cs:176`. [Pit sizes 5](../disproved_deep_src_CeCivil_Brain_Things_PitData_cs.md) · [Pipe drawing 16](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Pipe ends 6](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

36. **An unsupported size can change the drawing before the drafter chooses.** A direct 700 × 700 mm resize used 600 × 600 mm and moved both pipe ends. Another direct request saved 750 × 750 mm against a 450 mm outline. The ordinary size box rejects these requests.  
   D-228, D-260, D-272 · unsafe edit · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:214`, `src/CeCivil.Hands/Pit/PitTool.cs:388`. [Pit drawing 17, 18](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pit sizes 6](../disproved_deep_src_CeCivil_Brain_Things_PitData_cs.md)

37. **The pit’s recorded kind can disagree with its lid, size or symbol.** A plastic pit stretched to 600 mm could remain marked plastic. Switching to solid could leave a grated lid and plastic cover text. Equivalent spellings of 350 × 350 mm could lose the plastic symbol or prefix. After a plastic pit, the regular preset could also place a 450 mm plastic stand-in.  
   D-224, D-228, D-257, D-323 · wrong figure · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:472`, `src/CeCivil.Brain/data/pit_blocks.csv:10`, `src/CeCivil.Hands/Pit/PitTool.cs:76`. [Pit drawing 25, 27, 28, 29](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pit sizes 7](../disproved_deep_src_CeCivil_Brain_Things_PitData_cs.md)

38. **A valid 1200 mm pipe diameter can be refused as missing.** The window sends the displayed “1,200” to a reader expecting an ungrouped number. Separately, malformed values supplied straight to the drawing writer can bypass the window’s checks.  
   D-079, D-080 · wrong figure · survived disprove pass · `bench/CeCivil.Bench.Core/PipeToolWindow.cs:111`. [Pipe drawing 25](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

39. **A high held level can disappear after OK.** A synthetic cover of RL 1001.25 m was saved with a thousands separator. Pit reopened it as unknown and unheld. Pipe uses the same display-and-read pattern.  
   D-086, D-286 · wrong figure · not yet disproved · `bench/CeCivil.Bench.Core/ToolWindow.cs:142`. [Window review 10](../../deep_Window.md)

40. **An unreadable block width can leave a believable old pit size.** With only the across dimension available, a 600 × 900 mm pit kept its previous footprint without a warning. Deliberately supplying non-finite widths also produced an unusable saved size.  
   D-228 · wrong figure · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:390`. [Pit drawing 26, 39](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md)

41. **The displayed working can print a false sum.** Pipe showed 5.28 − 0.09 = 5.194 m. Those printed figures give 5.190 m. With deliberately broken rows, the arithmetic checks also accepted a false division or a numeric result with no divisor.  
   D-219, D-295 · wrong figure · survived disprove pass · `src/CeCivil.Window/Parts/Std/StdSteps.cs:953`, `src/CeCivil.Window/Parts/Std/StdSteps.cs:961`, `src/CeCivil.Window/Parts/Std/StdSum.cs:141`. [Window working 2, 3, 4](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md)

42. **The Pit window can hide a required step-iron warning.** A 450 mm square pit at 7.10 m depth triggered three warnings. The card stopped at two, leaving the step irons off the screen.  
   D-136, D-149, D-286 · screen rule · survived disprove pass · `bench/CeCivil.Bench.Core/WindowModel.cs:1775`. [Window working 5](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md)

43. **The Pipe preview can put real levels on the wrong pits and invent a connection.** The title named P6 to P7, but the picture put their covers under P4 and P3. It also drew two pits and a downstream continuation for a loose pipe, using a fixed 8 m route and square pits.  
   D-064, D-162, D-167, D-176 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/PreviewPane.cs:307`, `src/CeCivil.Window/Parts/PreviewPane.cs:296`, `src/CeCivil.Acad/PipeCommand.cs:82`. [Drawing preview 1, 2, 8](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md)

44. **The downstream picture can flag a fault against an invented zero.** An arrival at RL −0.10 m with the outlet unknown was coloured amber. With both levels known the same 4 mm difference kept its warning at job tolerances of 1 mm and 5 mm.  
   D-219, D-318, D-321 · wrong figure · survived disprove pass · `src/CeCivil.Window/Parts/PreviewPane.cs:292`. [Drawing preview 4](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md)

45. **The Pit picture can show the wrong pipes at a junction.** A 100 mm incoming pipe and 225 mm outgoing pipe were drawn with the same description. A second inlet can vanish according to creation order, and another section draws two 150 mm pipes and both connection arrows even when the facts differ.  
   D-064, D-154, D-256, D-313 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/PreviewPane.cs:196`, `src/CeCivil.Hands/Pit/PitTool.cs:646`, `src/CeCivil.Window/Parts/Std/StdPictures.cs:98`. [Drawing preview 7](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md) · [Pit drawing 6](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Window sketches 11, 12](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md)

46. **The resize picture can promise movement the drawing will skip.** A 600 × 900 mm pit was shown with the wrong old outline. A missing size looks like 450 mm square, and movement rings can appear on unaffected ends while an extra branch is omitted.  
   D-064, D-256, D-260 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/PreviewPane.cs:211`, `src/CeCivil.Window/Parts/PreviewPane.cs:90`, `src/CeCivil.Window/Parts/PreviewPane.cs:239`. [Drawing preview 10, 11, 12](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md)

47. **An undecided pipe check can turn the main answer amber.** The check itself read “Cannot check yet” in grey, while the headline read “Needs a look”. The drafter sees a warning for an answer that cannot yet be calculated.  
   D-219 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/Std/StdSteps.cs:540`. [Window working 6](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md)

48. **The number on a copied pit can disagree with its new identity.** In the drawing test the new pit was P2 but its copied tag still displayed P1. A pipe attaching to that copy could also be named for P1.  
   D-179, D-185, D-262 · wrong figure · survived disprove pass · `src/CeCivil.Hands/Notes/HiddenNotes.cs:140`, `src/CeCivil.Hands/Pipe/PipeEnds.cs:348`. [Pit drawing 16](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe ends 19](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

49. **A copied pipe can refuse a later resize.** In the simulator, copying just the pipe left its original pit links. Editing the copy reconstructed the original name and then refused the resize because that name was already in use.  
   D-031, D-340 · ruling not built · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeTool.cs:458`. [Pipe drawing 13](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

50. **A pipe edit overwrites wording typed on the plan.** Changing the diameter replaced the drafter’s own description with the generated one. The text needs to stay in place until the drafter chooses to follow the pipe wording again.  
   D-182, D-290 · unsafe edit · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeTool.cs:511`. [Pipe drawing 11](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

51. **Stretching only one pipe end can move a hand-placed label.** With the far end stationary, a label moved 1200 mm with the first vertex as though the entire pipe had moved.  
   D-014, D-181, D-271 · unsafe edit · survived disprove pass · `src/CeCivil.Hands/Adapter/Primitives.cs:69`. [Drawing edits 18](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md)

52. **Flipping an existing pipe label can leave it on the original side.** The edit preserves its old position even when the side choice changes. The preview also draws moved pit and pipe labels back at fixed positions.  
   D-014, D-181, D-290 · ruling not built · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeTool.cs:508`, `src/CeCivil.Hands/Pit/PitTool.cs:253`. [Pipe drawing 36](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Drawing preview 14](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md)

53. **Changing diameter in Properties can leave the old size on the plan.** The native width edit does not refresh the generated pipe description. A label moved by hand can stay in the correct spot while still calling a 225 mm pipe “150”.  
   D-014, D-182, D-271 · wrong figure · not yet disproved · `src/CeCivil.Hands/EndOfCommand.cs:118`. [Pipe rulings 23](../rulings_PIPE.md)

54. **Incomplete pipe answers can leave an old diameter on the plan.** Supplying a 225 mm edit directly with the description missing widened the pipe but left its “150 DIA.” text in place. The normal window supplied the words in the reviewed case.  
   D-178, D-312 · wrong figure · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeTool.cs:500`. [Pipe drawing 35](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

55. **A button release alone can accept a drawing edit.** Sending just the release event to the off-screen Pipe OK control closed it with OK. Whether a physical drag ending over that button does the same in AutoCAD remains untested.  
   D-216, D-286 · unsafe edit · survived disprove pass · `src/CeCivil.Window/Parts/SmallParts.cs:32`. [Window frame 21](../disproved_deep_src_CeCivil_Window_Parts_WindowFrame_cs.md)

56. **A pit can report a clash when all three held figures agree.** The difference between RL 5.804 m and RL 5.300 m is exactly the held 0.504 m depth. Comparing a rounded result produced “Out by 0.00”.  
   D-125, D-216 · wrong figure · survived disprove pass · `src/CeCivil.Brain/Sums/Solver.cs:157`. [Level calculations 5](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md)

57. **The drawing writer can print letters as a cover level.** Supplying a non-numeric held cover directly produced “CL abc”. The normal Pit window kept its previous valid number when the same text was typed.  
   D-178, D-216 · wrong figure · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:328`. [Pit drawing 31](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md)

58. **Damaged size or text settings can produce plausible or unusable dimensions.** Removing a stretch name let 600 × 900 mm save as only 600. Substituting a radius could make an unapproved width pass. Malformed numeric values could reach wall size, tag height or offset. These were deliberately damaged inputs.  
   D-216, D-228, D-272 · wrong figure · survived disprove pass · `src/CeCivil.Brain/Things/PitData.cs:185`, `src/CeCivil.Brain/Things/PitData.cs:120`, `src/CeCivil.Brain/Things/PitData.cs:101`. [Pit sizes 12, 13, 14, 15](../disproved_deep_src_CeCivil_Brain_Things_PitData_cs.md)

59. **The sheet samples can show a bare level label.** With one invert missing and the other known, the sample showed a bare “IL” beside “IL 9.30”. The side section also disappeared at the known end. The equivalent Pit sample can leave bare “CL”.  
   D-177, D-178, D-236 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/Std/StdPictures.cs:219`, `src/CeCivil.Window/Parts/PreviewPane.cs:234`. [Window sketches 3](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md) · [Drawing preview 5](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md)

60. **The chosen pipe inverts cannot be written onto the plan.** The drawing form hides and clears its invert switch. The drafter cannot select the upstream, downstream or both labels, including a worked level that should print on OK without first being held.  
   D-236, D-265, D-322 · ruling not built · survived disprove pass · `src/CeCivil.Brain/data/tools.csv:132`. [Pipe drawing 32](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

61. **Pipe descriptions omit the grade or change its meaning.** Zero or one given invert does not add “MIN.” or offer its override. An unknown grade loses “TBC”, and a conflicting or Wrong grade loses the typed figure. Charged, suspended and detention pipes can print the ordinary description instead of their full office wording.  
   D-154, D-178, D-238, D-268, D-277, D-312 · ruling not built · survived disprove pass · `bench/CeCivil.Bench.Core/PipeToolWindow.cs:114`, `bench/CeCivil.Bench.Core/GradeLabel.cs:13`. [Pipe drawing 33, 34](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

62. **A twin detention pipe is drawn and recorded as one barrel.** A pair of 225 mm pipes gets one band, no barrel count and no twin description. Anything reading that pipe record sees only one barrel.  
   D-082, D-268 · ruling not built · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeTool.cs:59`. [Pipe drawing 30](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

63. **The two thin pipe edges are missing.** The drawing makes one diameter-wide band and never draws the separate lines along its edges. The preview can make the opposite mistake, drawing only two thin strokes without the wide band.  
   D-156, D-264 · ruling not built · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeTool.cs:484`, `src/CeCivil.Window/Parts/PreviewPane.cs:295`. [Pipe drawing 29](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Drawing preview 9](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md)

64. **The pit tag and labels do not have their office appearance.** The pit number lacks its circle, the pit and pipe text lack background masks, and a plastic pit’s prefix and cover print on one line. Linework can show through the text.  
   D-039, D-260, D-290 · ruling not built · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:260`, `src/CeCivil.Brain/data/tools.csv:409`, `src/CeCivil.Window/Parts/Std/StdPictures.cs:148`. [Pit drawing 20](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe drawing 31](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Window sketches 13](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md)

65. **The orifice pit has no office symbol at placement.** Selecting it produced a plain outline even with the detention state available in the office block. The two chambers required for the first real use are missing.  
   D-039, D-260, D-338 · ruling not built · survived disprove pass · `src/CeCivil.Brain/data/pit_blocks.csv:11`. [Pit drawing 19](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md)

66. **Pit cannot read an ordinary old office pit without the new hidden note.** A recognised old block was ignored on selection. For a marked old pit, protection also depends on the spelling and contents of the office block register.  
   D-228, D-261 · ruling not built · survived disprove pass · `src/CeCivil.Acad/PitCommand.cs:68`, `src/CeCivil.Brain/Things/PitData.cs:139`. [Pit drawing 24](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pit sizes 11](../disproved_deep_src_CeCivil_Brain_Things_PitData_cs.md)

67. **Pit numbers and pipe names can disagree with the plan.** Retyping P1 as P7 on its tag left P1 on the pit record. Renaming the pit in its window could leave an existing pipe named for P1. Case, spaces, simultaneous joins and the suffix limit can also produce duplicate or stale names.  
   D-075, D-176, D-185, D-261 · ruling not built · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:561`, `src/CeCivil.Hands/EndOfCommand.cs:128`, `src/CeCivil.Hands/Pit/PitTool.cs:127`. [Pit drawing 14, 15, 32](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe ends 20, 29](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

68. **The starting diameter can come from the wrong run.** A new isolated pipe can inherit a previous 375 mm pipe. Starting at another pit does not reliably take its connecting pipe’s size, and a fresh session can start without the office 100 mm diameter.  
   D-174, D-234, D-263 · ruling not built · survived disprove pass · `src/CeCivil.Acad/PipeCommand.cs:87`. [Pipe drawing 26](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

69. **A branch cannot begin on a main, and a qualifying bend can miss its inspection opening.** The drawing accepts a branch finishing on a main. A straight branch ending at a bend in that main did not get the opening offer.  
   D-081, D-189, D-237, D-263 · ruling not built · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeRun.cs:58`, `src/CeCivil.Hands/Pipe/PipeRun.cs:79`. [Pipe drawing 27, 28](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

70. **Last-used Pit choices are lost when AutoCAD restarts.** Kind, lid and label choices are held only while the session is open. The regular and plastic pit opening sizes have their own correct reset rule.  
   D-263, D-323 · ruling not built · survived disprove pass · `src/CeCivil.Acad/PitCommand.cs:36`. [Pit drawing 35](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md)

71. **A part on an off or frozen layer can stay invisible.** The real Pit and Pipe commands do not pass through the working offer to turn that layer on. A drafter can finish placing a pipe without seeing it.  
   D-320 · ruling not built · survived disprove pass · `src/CeCivil.Acad/PitCommand.cs:80`, `src/CeCivil.Hands/Pipe/PipeTool.cs:478`. [Pit drawing 36](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe drawing 6](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

72. **A new pit cannot be turned while placing it.** The drawing command asks for one point, hides the turn control and supplies no placement angle. The ordinary rotation tool only acts afterwards.  
   D-266, D-267 · ruling not built · survived disprove pass · `src/CeCivil.Acad/PitCommand.cs:60`. [Pit drawing 34](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md)

73. **The drawing commands open a different layout from the one checked on the bench.** The live Pipe form has a top strip on the old four cards. The three-step bench form reserves the left panel for placeholder text. Neither path proves the required Pipe strip and pictures beside the Pit and Pipe inputs together.  
   D-295, D-309, D-313 · screen rule · survived disprove pass · `bench/CeCivil.Bench.Core/WindowSpec.cs:153`, `src/CeCivil.Window/Parts/Std/StdSteps.cs:106`. [Window frame 12](../disproved_deep_src_CeCivil_Window_Parts_WindowFrame_cs.md) · [Window working 8](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md)

74. **The picture cannot locate the part on the real plan.** It shows build wording in place of a site locator and connected system. The separate trial could light up the real drawing, but the release commands do not call it.  
   D-167, D-286, D-301 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/PreviewPane.cs:55`, `src/CeCivil.Acad/PitCommand.cs:110`. [Drawing preview 19](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md) · [Later rulings 10](../disproved_rulings_D298_D344.md)

75. **The diameter picture can give missing or refused inputs a real-looking width.** An unknown diameter used the same outline as 150 mm. A valid typed 375 mm updated the label but selected no size in the comparison picture.  
   D-064, D-080, D-176, D-313 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/PreviewPane.cs:290`, `src/CeCivil.Window/Parts/Std/StdPictures.cs:209`, `src/CeCivil.Window/Parts/Std/StdPictures.cs:75`. [Drawing preview 3](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md) · [Window sketches 7, 14](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md)

76. **The Pipe section can misrepresent slope, scale and cover position.** Falls of 0.20 and 0.80 m produced the same slope line. Raising only the level datum nearly collapsed the pipe edges, and the cover arrow measured away from the end named by the figure.  
   D-064, D-313 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/Std/StdPictures.cs:165`, `src/CeCivil.Window/Parts/Std/StdPictures.cs:184`, `src/CeCivil.Window/Parts/Std/StdPictures.cs:187`. [Window sketches 8, 9, 10](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md)

77. **The Pit preview can show the wrong lid and ignore the cover-text switch.** The grate, solid cross and plastic cover wording in the picture can disagree with what the drawing writer will place.  
   D-039, D-162, D-228, D-260 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/PreviewPane.cs:215`. [Drawing preview 13](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md)

78. **The material padlock can offer an action it cannot perform.** Pressing it while the pipe followed the office list left the value, source and lock state unchanged. A reopened 150 mm pipe overridden to HDPE showed no UPVC SN8 office figure beside it.  
   D-150, D-239, D-286 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/Std/StdSteps.cs:397`, `src/CeCivil.Brain/data/material_by_size.csv:5`. [Window working 9](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md) · [Foundation rulings 7](../disproved_rulings_FOUNDATION.md)

79. **The changed detention tick gets no change mark.** Ticking “Holds detention water” on a pit saved the choice. The band still mentioned only depth and size, with no mark showing what had changed.  
   D-286 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/Std/StdSteps.cs:615`. [Window working 10](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md)

80. **A size list can show a different selection from the one it sends.** With the editor still focused in the off-screen check, choosing 600 × 600 mm left 450 × 450 mm visible. Two options could also share the same highlight. The usual mouse path clears focus first.  
   D-286, D-295 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/Std/StdInput.cs:185`, `src/CeCivil.Window/Parts/Std/StdInput.cs:197`. [Input controls 5, 6](../disproved_deep_src_CeCivil_Window_Parts_Std_StdInput_cs.md)

81. **A smaller drawing window can lose sketches, clip a warning or fail to lay out.** With only 240 units of height left for the Pit cards, the layout failed. At larger widths the bench kept the preview at the same width and gave the space to the cards.  
   D-151, D-286, D-313 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/Room.cs:15`, `src/CeCivil.Window/Parts/WindowFrame.cs:349`, `src/CeCivil.Window/Parts/Std/StdSteps.cs:48`. [Window frame 16, 17, 20](../disproved_deep_src_CeCivil_Window_Parts_WindowFrame_cs.md)

82. **A regional decimal comma can break a picture.** The same Pit and Pipe sketches rendered under the Australian number format and failed under a decimal-comma format. The dormant invert padlock also depends on that separator.  
   D-162, D-216 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/Std/StdPictures.cs:121`, `src/CeCivil.Window/Parts/PreviewPane.cs:333`. [Window sketches 17](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md) · [Drawing preview 16](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md)

83. **A bad picture setting can leave a blank pane.** An intentionally missing diameter lookup erased the last good picture before the redraw failed. A misspelt side-picture name produced an empty box. The shipped names passed this particular check.  
   D-162, D-216 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/PreviewPane.cs:165`, `src/CeCivil.Window/Parts/Std/StdPictures.cs:41`. [Drawing preview 20](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md) · [Window sketches 18](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md)

84. **Pit numbering cannot be put in outlet order.** The first pit drawn gets P1. There is no action to number upstream from the street outlet first, or to offer all three choices when adding a pit after issue. This does not depend on how gaps in the number sequence are filled.  
   D-075, D-183, D-184 · ruling not built · not yet disproved · `src/CeCivil.Acad/PitCommand.cs:78`. [Rulings sweep 6](../../sweep_rulings/FINDINGS.md)

85. **The drafter has to pick the route before seeing the window.** Pit finishes after one point instead of placing successive numbered pits. Pipe collects points before its window opens, so the drafter cannot see a pipe of the selected width on the cursor before committing the route.  
   D-186, D-234, D-266, D-267 · ruling not built · survived disprove pass · `src/CeCivil.Acad/PitCommand.cs:60`, `src/CeCivil.Hands/EndOfCommand.cs:143`. [Direction rulings 21](../disproved_rulings_DIRECTION.md) · [Editing rulings 17](../disproved_rulings_EDITING_AND_GRIPS.md)

86. **The promised editing actions are missing on placed parts.** The drafter cannot double-click a CE pipe for its editor, change CE grade in Properties, or use the dedicated grips to slide or flip the annotations. Ordinary block and line grips still work.  
   D-033, D-037, D-061, D-244, D-290 · ruling not built · survived disprove pass · `src/CeCivil.Acad/Commands.cs:46`, `src/CeCivil.Brain/data/tools.csv:117`. [Editing rulings 7, 2](../disproved_rulings_EDITING_AND_GRIPS.md)

87. **The flow arrow cannot be placed.** The drawing settings disable it, so selecting or editing a pipe cannot produce the arrow the drafter should be able to position.  
   D-037, D-082 · ruling not built · not yet disproved · `src/CeCivil.Brain/data/tools.csv:134`. [Rulings sweep 9](../../sweep_rulings/FINDINGS.md)

88. **An uphill run lacks the direction choice.** Click order sets the ends. An uphill pipe gets a warning without the proposed unsettled direction or the action to turn it round.  
   D-271 · ruling not built · not yet disproved · `src/CeCivil.Brain/data/checks.csv:21`. [Pipe rulings 42](../rulings_PIPE.md)

89. **Pit warns about depth without offering the next suitable size.** A 450 mm pit at 0.62 m exceeded its 0.60 m depth guide. The tool kept the chosen size but gave no offer to use the appropriate larger pit.  
   D-235, D-272 · ruling not built · survived disprove pass · `src/CeCivil.Brain/data/checks.csv:59`. [First-release rulings 20](../disproved_rulings_FIRST_RELEASE.md)

90. **The first-job Pit picker offers a deferred kind.** Selecting the silt pit passes a real choice to the drawing writer, which can place a stand-in even though the kind is parked.  
   D-104, D-338 · ruling not built · survived disprove pass · `bench/CeCivil.Bench.Core/windows/pit.csv:48`. [First-release rulings 7](../disproved_rulings_FIRST_RELEASE.md)

91. **An outline cannot be taken up when the office block becomes available.** A pit placed as a stand-in stays an outline. The drafter has no action to replace it with the now-available office symbol.  
   D-261 · ruling not built · not yet disproved · `src/CeCivil.Hands/Pit/PitTool.cs:190`. [Pit rulings 41](../rulings_PIT.md)

92. **A new detention pipe layer can lose its dash pattern.** If the drawing lacks the specified linetype, creation uses the default and warns. When creation succeeds with the correct pattern, the once-only notice that the layer was made is missing.  
   D-153, D-156, D-260 · ruling not built · survived disprove pass · `src/CeCivil.Acad/AcadDrawing.cs:342`. [Drawing and sheet rulings 10](../disproved_rulings_DRAWING_AND_SHEETS.md)

93. **The live Pit window cannot pick up a council lid-class override.** It starts without the job council and displays the office preset without identifying the driveway class as office practice. The reviewed list contained no sourced council class.  
   D-240, D-242, D-243, D-287 · wrong figure · not yet disproved · `bench/CeCivil.Bench.Core/WindowModel.cs:81`. [Pit rulings 32](../rulings_PIT.md)

94. **The grade input loses its unit.** The box can read simply “Grade 100”. The form specifies “1 in”, and that wording does not reach the field.  
   D-079, D-295 · screen rule · survived disprove pass · `bench/CeCivil.Bench.Core/windows/pipe.csv:46`. [Input controls 7](../disproved_deep_src_CeCivil_Window_Parts_Std_StdInput_cs.md)

95. **A real edit can vanish from “What else changes”.** Cover changed from 396 to 397 mm, but both values displayed as 0.40 m and the change list omitted it. Confirming an assumed figure at the same value also removed its qualification without a change entry.  
   D-086, D-176, D-177 · screen rule · survived disprove pass · `src/CeCivil.Brain/Things/Network.cs:398`. [Level calculations 15](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md)

96. **The main answer can draw attention away from the fault.** A refused pit size left two green passes for the previous size. A Pipe warning gave the largest type to 0.11 m of fall and buried the 10 mm outlet difference that needed attention.  
   D-286, D-295 · screen rule · not yet disproved · `src/CeCivil.Window/Parts/Std/StdSteps.cs:579`, `src/CeCivil.Window/Parts/Std/StdSteps.cs:578`. [Pit screen 7](../screen_pit.md) · [Pipe screen 7](../screen_pipe.md)

97. **A drafter can see a figure without its explanation beside it.** The Pipe example puts the note explaining fall under a different picture. In Pit, the note explains the size tally but leaves the depth working without its own explanation.  
   D-286, D-295 · screen rule · not yet disproved · `bench/CeCivil.Bench.Core/windows/pit.csv:56`, `src/CeCivil.Window/Parts/Std/StdSteps.cs:726`. [Pit screen 8](../screen_pit.md) · [Pipe screen 8](../screen_pipe.md)

98. **Related drawing controls can separate as the window widens.** On Pipe, the label tick sits at the far right and its arrow and invert options wrap to the far left below. The Pit size-list arrow also differs visibly in size from the neighbouring controls.  
   D-286, D-295 · screen rule · not yet disproved · `src/CeCivil.Window/Parts/Std/StdSteps.cs:198`, `src/CeCivil.Window/Themes/Approved.xaml:61`. [Pipe screen 27](../screen_pipe.md) · [Pit screen 27](../screen_pit.md)

99. **A stopped command can print an internal error with no next step.** Pit and Pipe send the exception name and raw message to the drafter. The text does not say which input or drawing object to correct.  
   D-216, D-286 · screen rule · not yet disproved · `src/CeCivil.Acad/PitCommand.cs:96`. [Gate sweep 2](../../sweep_gate/FINDINGS.md)

100. **The closing message can describe work that never happened.** Removing one target between planning two wall moves and applying them left two success lines available although only one pipe moved. This intervening removal was supplied in the test.  
   D-216 · ruling not built · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeEnds.cs:417`. [Pipe ends 24](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

101. **A drawing connection that cannot read block settings can suppress the frame warning.** When that capability was absent entirely, Pit stayed silent about the wipeout frame. The production AutoCAD connection supplies it. This is a gap for other callers.  
   D-224 · ruling not built · survived disprove pass · `src/CeCivil.Hands/Pit/PitTool.cs:298`. [Pit drawing 37](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md)

102. **Opening or plotting a drawing can miss a quiet notice.** An unmarked stormwater line gets no offer on opening to take it up. Plotting has no route to report the count of open joins and assumptions, even though the manual self-check can list open ends.  
   D-188, D-192 · ruling not built · survived disprove pass · `src/CeCivil.Acad/Commands.cs:124`. [Drawing and sheet rulings 11](../disproved_rulings_DRAWING_AND_SHEETS.md)

103. **An available office block definition can still give a stand-in.** With the definition in the drawing but no existing insertion to supply its visibility states, even an ordinary junction pit can become a plain outline.  
   D-039, D-228 · ruling not built · not yet disproved · `src/CeCivil.Hands/Pit/PitTool.cs:220`. [Pit rulings 2](../rulings_PIT.md)

104. **A detention pipe gets no legend entry.** The drawing writer can place it on its own blue layer but adds no legend row. The exact legend wording and printed pen width are still open.  
   D-083 · ruling not built · survived disprove pass · `src/CeCivil.Hands/Pipe/PipeTool.cs:678`. [Drawing and sheet rulings 10](../disproved_rulings_DRAWING_AND_SHEETS.md)

105. **An invert change can be marked on the wrong end.** When the otherwise hidden invert-label switch was enabled in memory, changing the upstream level drew the change mark at the downstream end.  
   D-064, D-167 · screen rule · survived disprove pass · `src/CeCivil.Window/Parts/PreviewPane.cs:340`. [Drawing preview 15](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md)

106. **The clash details can send the drafter to the wrong pits.** The red headline can correctly name P6 and P7 while the supporting list and change summary still name P4 and P3 from the sample drawing.  
   D-125 · screen rule · not yet disproved · `bench/CeCivil.Bench.Core/WindowModel.cs:1879`. [Levels review 11](../rulings_LONG_SECTION.md)

107. **Pit can omit the cover warning for an attached pipe.** The Pipe window lists its cover check. The checks shown when opening the pit where the cover is short do not include it.  
   D-140, D-321 · screen rule · not yet disproved · `bench/CeCivil.Bench.Core/windows/pit.csv:59`. [Levels and standards 10](../rulings_LEVELS_AND_STANDARDS.md)

108. **The Pipe window has no surface choice or local slab override.** A drafter cannot set the paved or unpaved crossing, or save a local slab thickness on that pipe. The selected surface and slab are needed to calculate its cover.  
   D-287, D-293, D-330 · ruling not built · not yet disproved · `bench/CeCivil.Bench.Core/windows/pipe.csv:26`, `src/CeCivil.Brain/data/tools.csv:109`. [Levels and standards 22, 24](../rulings_LEVELS_AND_STANDARDS.md)

109. **The Pit window lacks the schedule choice for a plastic pit.** The schedule preview has an inclusion tick, but the drafter placing the plastic pit cannot turn its row off in Pit.  
   D-076 · ruling not built · not yet disproved · `bench/CeCivil.Bench.Core/windows/pit.csv:53`. [Pit rulings 24](../rulings_PIT.md)

110. **The shared sheet formatter can return “unknown” for a missing level.** Supplying a missing pit cover with its correct office mark returned that literal word. The schedule’s own formatter returned “TBC”. This finding concerns the shared formatter.  
   D-178 · ruling not built · survived disprove pass · `src/CeCivil.Brain/Things/Network.cs:423`. [Level calculations 14](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md)

111. **The night block tests can pass without proving the required pit.** The real-block check excludes the orifice state and can inspect zero enabled kinds. Other cases award a pass for information only or expect opposite outcomes for a missing block. The old-block test missed a deliberately wrong size.  
   D-216, D-228, D-260 · missing test · survived disprove pass · `src/CeCivil.Acad/PitChecks.cs:495`, `src/CeCivil.Acad/PitChecks.cs:709`, `src/CeCivil.Acad/PitChecks.cs:114`. [Pit drawing 42, 43, 44](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pit sizes 16, 17](../disproved_deep_src_CeCivil_Brain_Things_PitData_cs.md)

112. **Tests of refused or failed edits can pass without exercising the failure.** One test named for a refusal only places a valid pit. The recovery tests usually let every repair succeed after the first failure, so they miss a second failed write and damage left behind.  
   D-216 · missing test · survived disprove pass · `tests/CeCivil.Hands.Tests/PitRollbackAndUnitsTests.cs:114`, `tests/CeCivil.Hands.Tests/PipeRollbackTests.cs:16`, `tests/CeCivil.Hands.Tests/GapFourTests.cs:70`. [Pit drawing 40](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe drawing 43](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Pipe ends 31](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

113. **The wall and bend tests can pass at the wrong coordinates.** One reconnection test checks the pipe name and join without measuring the final wall point. Other tests check a lookup or message only, or reuse the placement calculation as the expected answer.  
   D-102, D-216, D-256, D-270 · missing test · survived disprove pass · `tests/CeCivil.Hands.Tests/Round39HandsTests.cs:174`, `tests/CeCivil.Hands.Tests/PitBlock3Tests.cs:307`, `tests/CeCivil.Hands.Tests/GapFourTests.cs:94`. [Pipe ends 32, 33, 34, 36](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md) · [Pipe drawing 39](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md)

114. **The cancel and undo checks do not establish the drawing’s before-and-after state.** A cancellation test loses the original comparison. One undo test only prepares the edit. Neither establishes what one actual undo restores after committing a full run.  
   D-216, D-324 · missing test · survived disprove pass · `src/CeCivil.Acad/PipeChecks.cs:229`, `tests/CeCivil.Hands.Tests/EndOfCommandTests.cs:171`. [Pipe drawing 40](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Pipe ends 35](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md)

115. **The pipe wording tests can approve the wrong sheet.** One night case supplies the expected description before drawing it. Other tests expressly accept a label that omits an unknown or Wrong grade. They miss the route from typed figures to the plotted words.  
   D-178, D-216, D-238, D-268, D-277 · missing test · survived disprove pass · `src/CeCivil.Acad/PipeChecks.cs:63`, `bench/CeCivil.Bench.Tests/FourthPassTests.cs:73`. [Pipe drawing 42](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Window sketches 22](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md)

116. **The picture tests can pass with the right words in the wrong place.** They can count unrelated strokes, accept a blank or zero in the affected field, or find a figure elsewhere in the window. Tests for moving ends, slope, colour and a held depth do not all inspect the actual marks or values beside those inputs.  
   D-162, D-178, D-216, D-313 · missing test · survived disprove pass · `bench/CeCivil.Bench/StyleCheck.cs:758`, `tests/CeCivil.Hands.Tests/PitWindowFromDrawingTests.cs:223`, `bench/CeCivil.Bench/StyleCheck.cs:575`. [Drawing preview 21, 22](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md) · [Window sketches 20, 21](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md) · [Window working 13, 14](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md)

117. **The arithmetic tests can repeat the window’s own mistake.** One feeds displayed figures back through the same rounding routine. Another fails to cover the division correction. Neither independently rules out a false printed sum.  
   D-216, D-295 · missing test · survived disprove pass · `bench/CeCivil.Bench/StyleCheckTankSchedule.cs:93`. [Window working 12](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md)

118. **A passing input test does not establish that the drafter’s action worked.** A vanished grade list can escape discovery when other lists remain. Calling a commit or raising an isolated event also misses a broken Enter, focus change or model update.  
   D-079, D-216, D-286 · missing test · survived disprove pass · `bench/CeCivil.Bench/UiaCheck.cs:84`, `bench/CeCivil.Bench/StyleCheck.cs:153`. [Input controls 14, 15](../disproved_deep_src_CeCivil_Window_Parts_Std_StdInput_cs.md)

119. **The style check can pass on an older build.** It runs an executable already on disk. The disprove pass found that two source files used by that executable differed from the revision under review.  
   D-216, D-308 · missing test · survived disprove pass · `bench/CeCivil.Bench.Tests/StyleKitTests.cs:210`. [Window working 15](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md)

120. **The release has no matched plot with and without the plug-in.** Inspecting ordinary objects cannot prove identical printed masks, edge lines, text size or lineweights. The reviewed evidence also lacks the full saved-drawing, reopen and plot comparison on this build.  
   D-015, D-194, D-216 · missing test · survived disprove pass · `src/CeCivil.Hands/PlainView.cs:26`. [Drawing and sheet rulings 3](../disproved_rulings_DRAWING_AND_SHEETS.md)

121. **The three shared command names have no proven owner in the drawing session.** The saved check found competing registrations but did not establish which plug-in actually opened. The supervised ownership check remains outstanding.  
   D-251, D-258, D-325 · missing test · survived disprove pass · `acad/night_results/2026-11-19_pass11_0052/cewhose_latest.txt:4`. [First-release rulings 5](../disproved_rulings_FIRST_RELEASE.md)

122. **The drawing-to-sheet level test is incomplete.** Existing tests work out branched levels in memory. They do not carry a held grade, both incoming inverts and their drops through Pit and Pipe, save and reopen, then compare the labels with independent figures.  
   D-086, D-154, D-216 · missing test · not yet disproved · `src/CeCivil.Acad/PitCommand.cs:79`, `tests/CeCivil.Brain.Tests/BranchedTests.cs:109`. [Gate sweep 6, 11](../../sweep_gate/FINDINGS.md)

123. **Turned drawings and label clearance lack an end-to-end check.** A horizontal or vertical example does not prove readable labels across 24 bearings, or wall pickups under a turned coordinate system. The gate calls for these on the actual plotted drawing.  
   D-014, D-181, D-216, D-270 · missing test · not yet disproved · `tests/CeCivil.Hands.Tests/BendTests.cs:128`, `src/CeCivil.Acad/PitCommand.cs:71`. [Gate sweep 10, 16](../../sweep_gate/FINDINGS.md)

124. **The supported window sizes and drafting actions lack drawing-host evidence.** The saved desktop pictures do not establish 150% scaling, the drafting laptop, restored monitor position, or the number of picks, clicks and scrolls in an actual Pit or Pipe edit.  
   D-193, D-216, D-286, D-313 · missing test · not yet disproved · `src/CeCivil.Acad/PitCommand.cs:103`, `bench/CeCivil.Bench/BenchStates.cs:28`. [Gate sweep 17](../../sweep_gate/FINDINGS.md) · [Pit screen 18](../screen_pit.md) · [Pipe screen 18](../screen_pipe.md)

125. **Existing timings stop before the drafter sees a usable window.** Off-screen tests omit the live opening and repaint. Repeated recalculations also queue repeated layout work. The visible 300 ms opening and 100 ms redraw limits still lack release proof.  
   D-165, D-216 · missing test · survived disprove pass · `src/CeCivil.Acad/night/speed_night.csv:7`, `src/CeCivil.Window/Parts/WindowFrame.cs:375`. [Direction rulings 20](../disproved_rulings_DIRECTION.md) · [Window frame 18](../disproved_deep_src_CeCivil_Window_Parts_WindowFrame_cs.md)

126. **The gate lacks a round trip for drawing standards and shared settings.** There is no complete comparison of the figures and source after reopening with a changed office list, or of existing layers and settings after success, cancellation and a failed edit.  
   D-022, D-216 · missing test · not yet disproved · `tests/CeCivil.Brain.Tests/StandardsTests.cs:36`, `src/CeCivil.Acad/AcadDrawing.cs:346`. [Gate sweep 5, 20](../../sweep_gate/FINDINGS.md)

127. **The fault-report privacy check can miss identifying text in a test-folder path.** The test preserves paths beneath the work root. The supplied evidence does not prove that a complete report removes identifying folder names before sharing.  
   D-010, D-216 · missing test · not yet disproved · `tests/CeCivil.Hands.Tests/SharedThingsAndPrivacyTests.cs:66`. [Gate sweep 25](../../sweep_gate/FINDINGS.md)

128. **The protection tests do not prove each refusal leaves everything untouched.** Some cases supply the answer about a lock or reference directly to the simulator. The drawing evidence does not cover all affected labels, neighbouring ends, working spaces and a normal reference edit on the same release.  
   D-216 · missing test · not yet disproved · `src/CeCivil.Hands/EditGuard.cs:30`. [Gate sweep 19](../../sweep_gate/FINDINGS.md)

129. **The release lacks a plotted check of missing, assumed and true zero levels.** The gate asks for those cases, including negative levels, to survive saving and reopening. The window wording, the plan’s “TBC” or “APPROX.” and the corresponding printed note must all agree.  
   D-177, D-178, D-216 · missing test · not yet disproved · `src/CeCivil.Hands/Pit/PitTool.cs:246`. [Gate sweep 4](../../sweep_gate/FINDINGS.md)

130. **A passing units test requires the release to edit a metre drawing.** The Pit test expects three new drawing objects in metres. It cannot catch a breach of the millimetre-only release. The expected result is the explanation and an unchanged drawing.  
   D-216, D-344 · missing test · survived disprove pass · `tests/CeCivil.Hands.Tests/PitRollbackAndUnitsTests.cs:128`, `src/CeCivil.Hands/Units/DrawingUnits.cs:21`. [Pit drawing 33](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md) · [Pipe drawing 38](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md) · [Gate sweep 1](../../sweep_gate/FINDINGS.md)

131. **A standard drawing object has no comparative double-click test.** The saved evidence does not show that a CE pipe opens the CE window while an ordinary polyline still opens its normal editor in the same drawing.  
   D-061, D-216 · missing test · not yet disproved · `src/CeCivil.Acad/PitCommand.cs:57`. [Gate sweep 18](../../sweep_gate/FINDINGS.md)

132. **The drawing comparisons can pass with the wrong length, grade or invert.** Eight millimetre examples draw a 9.7 mm pipe but store 9.7 m. Another still matched after its far end moved 2 m. A copied pipe also matched after its invert and grade were changed.  
   D-154, D-179, D-216, D-256, D-344 · missing test · survived disprove pass · `tests/golden/save_current.json:53`, `tests/golden/pipe_pit_moved.json:64`, `tests/golden/run_pipe_copy_held.json:4`. [Drawing recordings 6, 7, 8, 1](../disproved_deep_src_CeCivil_Hands_Golden_Golden_cs.md)

---

**Review record.** Read 122 input files, including 35 disprove passes, the five root-level deep reviews, all six files in the sweep folders and 7 existing reports for other parts. The night test plans describe checks to run. The open choices about numbering gaps and equally near pits carry no defect count.

**This run.** Product tests run 0. AutoCAD sessions 0. Only this report was written. No drawings were opened and the release board was left as read. Codex reviewed the material under the job brief naming `gpt-6.2-astra`. The session did not expose a separate runtime model identifier.
