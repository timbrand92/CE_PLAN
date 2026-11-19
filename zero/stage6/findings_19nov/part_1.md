One-job release | Part 1 of 9: Drawing safety (copy, move, erase, undo) | Built 2, Checked 2, Installed 0, Accepted 0 (of 9)  
Now: Moving one pit can change a protected pipe, and erasing a pit can leave its lettering on the sheet and hide a disconnected pipe end.

**Review result.** 40 findings survived a disprove pass. A further 11 are marked **not yet disproved** and excluded from that count. The file and line references are for the reviewed main line, `2ce8070`. Each entry links to the evidence for its stated result.

1. **Moving a pit can change protected drawing work.** The follower moves pipe ends and lettering before it checks their layer lock, external reference or active reference edit. In each of the three bench cases the protected end moved 1,000 mm. A pit resize and an outlet placement can reach the same unprotected neighbours.  
   D-216 (OC-19) · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/EndOfCommand.cs:270` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:452` · `src/CeCivil.Hands/EditGuard.cs:28`. [Command-end check, line 12](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L12) · [Pipe-end check, line 14](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L14) · [Legal-point check, line 8](../disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md#L8)

2. **A failed command can leave half the edit on the drawing.** When the second pipe refused a move, the first stayed 1,000 mm from its starting point. A failed second label erase left the first label missing. Recovery can also leave a trimmed end, a lost join or a changed pit size and still tell the drafter the drawing was restored.  
   D-216 (OC-07 and OC-27), D-256 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/EndOfCommand.cs:275` · `src/CeCivil.Acad/AcadDrawing.cs:148` · `src/CeCivil.Hands/Pit/PitTool.cs:619` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:487`. [Command-end check, lines 10, 64](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L10) · [Pit edit check, line 32](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md#L32) · [Pipe-end check, line 18](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L18)

3. **The original can move, rename or erase the drafter’s separate copy.** A pit tag copied alone moved 500 mm with its original pit. Switching off a pipe label erased the separate copy. A copied legal-point tag also followed its marker. A separately copied outlet symbol can follow by the same one-sided link. The owner never has to confirm which part belongs to it, and the required plain-copy notice is missing.  
   D-340 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/Joins/JoinStore.cs:56` · `src/CeCivil.Hands/EndOfCommand.cs:138` · `src/CeCivil.Hands/Notes/HiddenNotes.cs:142` · `src/CeCivil.Hands/Pipe/PipeTool.cs:192`. [Command-end check, line 32](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L32) · [Pipe edit check, line 16](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L16) · [Legal-point check, line 24](../disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md#L24) · [First-release check, line 8](../disproved_rulings_FIRST_RELEASE.md#L8) · [Decision check, line 8](../disproved_rulings_D298_D344.md#L8)

4. **Moving one pit can alter a pipe at another pit.** The search checks every pit when any one pit changes. Moving one pit trimmed and joined a loose end 50 m away beside an untouched pit. Placing a legal point changed a pipe 30 m from the selected end.  
   D-176, D-216 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/Pipe/PipeEnds.cs:266` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:281` · `src/CeCivil.Hands/Outlet/LpdTool.cs:209`. [Command-end check, line 16](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L16) · [Legal-point check, line 6](../disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md#L6)

5. **A dead link can move ordinary linework.** A plain line with an old join but no CE ownership note moved 700 mm and acquired a new position record. A pipe fragment with only its name left could also be trimmed, joined and marked as current. The fragment case depends on what survives the explosion.  
   D-199, D-216, D-340 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/Joins/JoinStore.cs:119` · `src/CeCivil.Hands/EndOfCommand.cs:183` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:296`. [Command-end check, line 14](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L14) · [Pipe-end check, line 44](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L44)

6. **Erasing a pit or a main pipe can leave a false connection.** Erasing a pit left its tag and cover text on the drawing. Its pipe stayed marked as joined, disappeared from the loose-end list and would not join a replacement pit at the same spot. Erasing a main pipe also left its branch marked as connected. The outlet picker can offer the wrong end when the former pit still occupies the other end in its records.  
   D-221, D-176, D-237 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/EndOfCommand.cs:89` · `src/CeCivil.Hands/Joins/Unfinished.cs:60` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:325` · `src/CeCivil.Hands/Pipe/PipeTool.cs:544`. [Command-end check, line 18](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L18) · [Pipe edit check, line 82](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L82) · [Legal-point check, line 20](../disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md#L20)

7. **A copied pipe can still belong to the original pits.** Copying a pipe directly on top of itself left an inherited join. Moving the original pit moved the copied end 800 mm. Resizing the original could move both pipes, and resizing the copy alone could be refused because its inherited ends rebuilt the original pipe name.  
   D-340 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/Joins/JoinStore.cs:56` · `src/CeCivil.Hands/EndOfCommand.cs:202` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:389` · `src/CeCivil.Hands/Pipe/PipeTool.cs:458`. [Command-end check, line 34](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L34) · [Pipe-end check, line 40](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L40) · [Pipe edit check, line 64](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L64)

8. **Two tags in an older drawing can both claim one pit.** Both tags can follow the pit. When the drafter turns its tag off, the last tag read can be erased. The drawing has no Unfinished entry asking which tag is genuine. Tim ruled that both must remain until the drafter chooses.  
   D-340 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/Pit/PitTool.cs:148` · `src/CeCivil.Hands/EndOfCommand.cs:138` · `src/CeCivil.Hands/Joins/Unfinished.cs:43`. [Command-end check, line 32](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L32) · [Pit edit check, line 24](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md#L24)

9. **A copied level can lose its link to the source pit.** A copied level is recorded as “Assumed” without the source pit’s name. If P4 inherits P3’s cover, the drafter cannot trace it back to P3 from the saved source.  
   D-179 · ruling not built · **not yet disproved**  
   `src/CeCivil.Hands/Notes/HiddenNotes.cs:147`. [Editing review, line 24](../rulings_EDITING_AND_GRIPS.md#L24)

10. **A copied pit can show the old number and a cover that looks confirmed.** The new pit was P4 in its drawing record, but its tag still read P3 and its cover read “CL 5.75” without “APPROX.”. A pipe joining the copy could also be named for P3. The geometry can therefore point to P4 while the sheet and pipe name point the drafter to P3.  
   D-177, D-179, D-262 · wrong figure · **survived disprove pass**  
   `src/CeCivil.Hands/Notes/HiddenNotes.cs:139` · `src/CeCivil.Hands/Notes/HiddenNotes.cs:147` · `src/CeCivil.Hands/EndOfCommand.cs:338` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:348`. [Command-end check, lines 28, 30](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L28) · [Pit edit check, line 14](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md#L14)

11. **Accepting a copied invert can make it look confirmed.** The reported Pit window replaces the copied invert’s assumed source with “Given”. Pipe can similarly replace the upstream source with “Chosen”. Pressing OK can save the new source without the drafter confirming the copied level.  
   D-074, D-179 · wrong figure · **not yet disproved**  
   `bench/CeCivil.Bench.Core/WindowSpec.cs:338` · `src/CeCivil.Hands/Pit/PitTool.cs:562`. [Assumed-values review, line 4](../rulings_MANAGER.md#L4)

12. **Copies of a removed pit can both keep its number.** When two copies of one erased P3 arrive together, both can be treated as its replacement. Both keep P3 and bypass the step that marks copied levels assumed. The normal single-replacement case does not reveal this.  
   D-179, D-262 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/EndOfCommand.cs:103` · `src/CeCivil.Hands/EndOfCommand.cs:108` · `src/CeCivil.Hands/Notes/HiddenNotes.cs:143`. [Command-end check, line 36](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L36)

13. **Pasting an older pit can preserve its source identity.** Older position records carry no drawing identity. When the new drawing assigns the same local object number, the pasted P3 can stay P3 with no assumed-cover warning. A separately tested older pit already called “not yet named” could be copied without receiving any pit number.  
   D-179, D-262 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/Notes/Stamp.cs:49` · `src/CeCivil.Hands/Notes/Stamp.cs:56` · `src/CeCivil.Hands/Notes/HiddenNotes.cs:139`. [Command-end check, lines 38, 40](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L38)

14. **The first paste into an empty drawing can go unnoticed.** When a blank drawing opens, the watcher starts only if CE’s registration already exists. If clipboard paste is its first CE operation, the drawing can miss the event that gives the pit its own number. The review traced this sequence in the code.  
   D-262, D-340 · unsafe edit · **not yet disproved**  
   `src/CeCivil.Acad/Commands.cs:135` · `src/CeCivil.Acad/CopyChecks.cs:131`. [Night review, line 20](../../deep_Night.md#L20)

15. **Two pits can pull the same end, or a former pit can still move it.** When two recorded joins claim one pipe start, the last pit processed can win while both claims remain. In a separate bench case, removing the join after the move was prepared still let the now-loose end move 400 mm. The ordinary command prepares and applies the move consecutively.  
   D-176, D-340 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/Joins/JoinStore.cs:52` · `src/CeCivil.Hands/EndOfCommand.cs:204` · `src/CeCivil.Hands/EndOfCommand.cs:275` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:453`. [Command-end check, lines 80, 82](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L80) · [Pipe-end check, line 56](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L56)

16. **A recovery can rewrite another tool’s drawing information.** Recovery treats every record name starting with the office prefix as its own. If another tool used that prefix and stored values the reader skips, putting a failed edit back could lose those values. The sweep found the code path. It did not find an actual collision.  
   D-216 (OC-27) · unsafe edit · **not yet disproved**  
   `src/CeCivil.Hands/Names.cs:14` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:440` · `src/CeCivil.Acad/AcadDrawing.cs:209`. [Protection sweep, line 13](../../sweep_guard/FINDINGS.md#L13)

17. **A failed attachment can leave an ordinary object marked as CE’s.** The writer gave an existing object a pit identity before it checked all the supplied figure names. On a refused name, the object remained marked as a pit without its facts or position record. That makes later ownership checks unreliable.  
   D-199, D-216 (OC-27) · unsafe edit · **not yet disproved**  
   `src/CeCivil.Hands/Notes/HiddenNotes.cs:47` · `src/CeCivil.Hands/Notes/HiddenNotes.cs:61`. [First sweep, line 57](../../sweep_1/FINDINGS.md#L57)

18. **A damaged or newer drawing part can be treated as safe to edit.** A line carrying only a pit name accepted a 5.75 m cover. A pipe with a newer record version and missing facts accepted an edit that rewrote those facts. The damage check can recognise missing information, but the edit route can proceed before it runs.  
   D-216 (OC-27), D-199 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/Pit/PitTool.cs:139` · `src/CeCivil.Hands/Pipe/PipeTool.cs:183` · `src/CeCivil.Hands/Notes/HiddenNotes.cs:71`. [Pit edit check, line 60](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md#L60) · [Pipe edit check, line 20](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L20)

19. **A prepared edit can change the wrong drawing or a newly locked part.** The bench reused an edit in a second drawing with matching local object numbers. It renamed that drawing’s pit or erased its label. In the original drawing a pit locked after preparation could still be edited. The normal window applies its edit immediately to the same drawing.  
   D-216 (OC-19), D-340 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/Pit/PitTool.cs:543` · `src/CeCivil.Hands/Pipe/PipeTool.cs:649` · `src/CeCivil.Hands/Pipe/PipeTool.cs:737`. [Pit edit check, line 92](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md#L92) · [Pipe edit check, line 40](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L40)

20. **Some reference protections report clear without checking.** With no existing target, a new object skips the reference-edit check. A failed enquiry about reference editing is treated as clear. If a line or text inside an external reference reaches the writer, it can miss the reference because it never checks who owns that object. The nested selection route has not been seen in AutoCAD.  
   D-216 (OC-19) · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/EditGuard.cs:30` · `src/CeCivil.Acad/AcadDrawing.cs:372` · `src/CeCivil.Acad/AcadDrawing.cs:378`. [Pipe edit check, lines 24, 28](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L24)

21. **An invalid layer name can redirect the edit to layer 0.** The writer can substitute layer 0 when it refuses a layer name. The protection check covered the requested layer. An existing object can therefore move onto a shared layer that the check never examined.  
   D-216 (OC-19) · unsafe edit · **not yet disproved**  
   `src/CeCivil.Acad/AcadDrawing.cs:331` · `src/CeCivil.Acad/AcadDrawing.cs:121`. [Protection sweep, line 12](../../sweep_guard/FINDINGS.md#L12)

22. **Dragging a pipe end can erase a held fall.** Sliding a pipe end along the same pit removed the 50 mm drop across the pit and its “Given” source. Replacing the join kept only the end and position. A drafter can change the design level relationship by moving a point on the plan.  
   D-086, D-176 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/Pipe/PipeEnds.cs:314` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:490` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:498`. [Pipe-end check, line 12](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L12)

23. **A dragged end can stay with the wrong pit or miss the main pipe.** Dragging an end from P1 straight onto P2 can break the first join and skip the second. If P1 moved earlier while following was off, the end can reach P2 and still claim P1. A branch dragged onto the middle of a pipe can likewise stay loose.  
   D-176, D-237, D-270 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/Pipe/PipeEnds.cs:317` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:321` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:259`. [Pipe-end check, lines 36, 66, 52](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L36)

24. **A pipe can be marked joined where it misses the wall.** Dragging a joined end inside a 450 mm pit left it 125 mm inside the inner wall. A pipe running through the wall thickness without crossing the inner wall could also gain a join. When a pit grew, one end joined at the old wall and another resize could push an end past the last bend, reversing the segment.  
   D-034, D-102, D-256, D-270 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/Pipe/PipeEnds.cs:310` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:343` · `src/CeCivil.Hands/EndOfCommand.cs:217` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:417`. [Pipe-end check, lines 20, 24, 26, 34](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L20)

25. **Dragging onto a real pit can miss its drawn outline.** A drop 500 mm along the long side of a 1,200 × 900 mm pit stayed loose. Another check rejected a valid outer corner before testing the rectangle. A scaled pit could accept a join and then refuse to move that end on resize, and different horizontal and vertical scales can put the calculated wall in the wrong place.  
   D-256, D-270, D-272 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/Pipe/PipeEnds.cs:183` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:230` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:406` · `src/CeCivil.Acad/AcadDrawing.cs:108`. [Pipe-end check, lines 22, 32, 62, 64](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L22)

26. **A closed pipe can be reshaped and given a false end.** The join search treated a vertex of a closed loop as a free end. It moved that vertex to the pit wall and recorded a join. The polyline was still closed, so there was no pipe end at that location.  
   D-176, D-216 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/Pipe/PipeEnds.cs:290` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:343`. [Command-end check, line 56](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L56) · [Pipe-end check, line 46](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L46)

27. **Moving pits can leave the wrong measured length in the drawing.** After a 1 m pit move, a 9.00 m pipe still held 10.00 m. After both walls changed, a 9.10 m pipe held 9.33 m. Trimming also left an existing detention length label at 2.90 m on a 2.78 m pipe. Reopening Pipe can remeasure the line while the stored figure or existing label remains stale.  
   D-171, D-256, D-277 (planning call on measured length) · wrong figure · **survived disprove pass**  
   `src/CeCivil.Hands/EndOfCommand.cs:281` · `src/CeCivil.Hands/EndOfCommand.cs:327` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:493`. [Command-end check, line 20](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L20) · [Pipe-end check, lines 28, 30](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L28)

28. **A moved inspection opening can end up on a different bend.** Adding a vertex while the opening is also in the selection can leave its old bend number. Reversing a pipe with two bends can likewise send the opening to the other bend. Its stored place in the sequence no longer identifies the physical bend it belongs to.  
   D-189, D-340 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/EndOfCommand.cs:155` · `src/CeCivil.Hands/EndOfCommand.cs:180` · `src/CeCivil.Hands/Pipe/PipeTool.cs:157`. [Command-end check, line 54](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L54) · [Pipe edit check, line 164](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L164)

29. **Moving text or a symbol can change its height or shape.** The drawing writer puts a moved text anchor at elevation zero and writes a block’s horizontal scale to every axis. A sideways move can flatten elevated lettering or change a mirrored or unequally scaled symbol. This is a reading of the drawing writer. The effect on a native object awaits a drawing check.  
   D-181, D-199, D-216 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Acad/AcadDrawing.cs:104` · `src/CeCivil.Acad/AcadDrawing.cs:145` · `src/CeCivil.Acad/AcadDrawing.cs:306` · `src/CeCivil.Hands/EndOfCommand.cs:297`. [Command-end check, line 76](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L76) · [Pit edit check, line 58](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md#L58)

30. **A cancelled or undone command can still reach the ordinary move code.** Completed, failed and cancelled commands use the same handler. If affected objects remain in its list, it can apply another edit. The code path survived review. Whether AutoCAD supplies those objects during a particular Cancel, Undo or Redo remains open.  
   D-216 (OC-07 and OC-08) · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Acad/Commands.cs:193` · `src/CeCivil.Acad/Commands.cs:219` · `src/CeCivil.Hands/EndOfCommand.cs:66`. [Command-end check, line 70](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L70)

31. **A move can edit a drawing set to metres.** The end-of-command check moved an end from 0.100 m to 0.225 m and wrote a join in a simulated metre drawing. The one-job release is limited to millimetres. The recorded planning call is to explain the unit and leave the drawing alone.  
   D-344 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/EndOfCommand.cs:70` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:257`. [Command-end check, line 72](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L72) · [Pipe-end check, line 54](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L54)

32. **A packed block or array can be skipped without telling the drafter.** The watcher looks for CE markings on the outside object and normally scans only the top level. A plain enclosing block gives it no reliable route to the required one-time notice. Which objects a native associative array reports remains a live-test question.  
   D-340 · ruling not built · **survived disprove pass**  
   `src/CeCivil.Acad/Commands.cs:279` · `src/CeCivil.Acad/AcadDrawing.cs:165` · `src/CeCivil.Hands/EndOfCommand.cs:87`. [Command-end check, line 74](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L74)

33. **The drawing can lose the drafter’s wording or keep an obsolete name.** Retyping the P3 tag as P7 updated the text without renaming the pit. Even a Pit-window rename could leave an already joined pipe named for the old pit. A later pipe edit overwrote hand-written wording without the required warning or the choice to follow automatically again.  
   D-182, D-185 · ruling not built · **survived disprove pass**  
   `src/CeCivil.Hands/EndOfCommand.cs:336` · `src/CeCivil.Hands/Pit/PitTool.cs:561` · `src/CeCivil.Hands/Pipe/PipeTool.cs:500`. [Command-end check, lines 42, 44](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L42) · [Pit edit check, line 40](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md#L40)

34. **A pit move can leave its pipe description behind.** Moving one pit 1,000 mm sideways changed the attached pipe from horizontal to sloping. Its description along the pipe moved 0 mm and stayed horizontal. The reported case uses the ordinary pipe description.  
   D-216 (OC-09), D-256 · unsafe edit · **not yet disproved**  
   `src/CeCivil.Hands/EndOfCommand.cs:204` · `src/CeCivil.Hands/EndOfCommand.cs:281`. [Hands review, line 108](../../deep_Hands.md#L108)

35. **A stretch or turn can spoil hand-placed lettering.** Stretching just the pipe start moved a hand-positioned label 1,200 mm with it. A tag supplied already quarter-turned with its pit stayed sideways because the centre had not moved. Tim requires a hand-positioned pipe label to hold its place on a shape change and pit lettering to stay upright.  
   D-014, D-267 · unsafe edit · **survived disprove pass**  
   `src/CeCivil.Hands/EndOfCommand.cs:143`. [Command-end check, lines 46, 50](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L46)

36. **Pipe names can disagree with joins after a move.** Two loose pipes joining P1 in the same edit both received the same name. Another gained its second real connection and kept “P1 to free end” because the intended name was taken. A pipe can therefore be listed as loose at a connected end.  
   D-176, D-261 (planning call on pipe names) · ruling not built · **survived disprove pass**  
   `src/CeCivil.Hands/Pipe/PipeEnds.cs:349` · `src/CeCivil.Hands/Pipe/PipeEnds.cs:351`. [Pipe-end check, line 50](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L50)

37. **The drawn schedule row has no proved erase-and-restore route.** The schedule preview makes rows from its own pit list. The review found no drawing link that removes the erased pit’s row and restores its held remarks with the pit on one Undo.  
   D-221 · ruling not built · **not yet disproved**  
   `bench/CeCivil.Bench.Core/ScheduleModel.cs:370` · `src/CeCivil.Hands/EndOfCommand.cs:89`. [Schedule review, line 32](../rulings_PIT_SCHEDULE.md#L32)

38. **The closing message can claim work that did not happen.** A skipped pipe move could still be announced. A resize reported that ends followed even though one stayed where it was. Copying a pit with only its number tag can produce a message suggesting all its labels came across, without naming the missing cover text.  
   D-179, D-216 (OC-03), D-256 · ruling not built · **survived disprove pass**  
   `src/CeCivil.Hands/EndOfCommand.cs:248` · `src/CeCivil.Hands/EndOfCommand.cs:278` · `src/CeCivil.Acad/Commands.cs:228`. [Command-end check, lines 66, 68, 86](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L66)

39. **One Undo restoring the whole drawing edit is unproved on the reviewed revision.** The bench test named for one Undo stops after planning. The erase test starts after the pit is gone, has no labels and requires the dead joins to remain. Neither checks one native Undo and Redo restoring the pit, both pipe ends, its lettering and links. Earlier one-Undo trials covered particular operations on other revisions.  
   D-216 (OC-07), D-221, D-256 · missing test · **survived disprove pass**  
   `tests/CeCivil.Hands.Tests/EndOfCommandTests.cs:171` · `tests/CeCivil.Hands.Tests/EndOfCommandTests.cs:63` · `tests/CeCivil.Hands.Tests/Round39HandsTests.cs:197`. [Command-end check, lines 90, 92](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L90) · [Recording check, line 35](../disproved_deep_src_CeCivil_Hands_Golden_Golden_cs.md#L35)

40. **The finished pipe run lacks a native Undo and Redo check.** Undo during drafting removes the unfinished or most recently finished pipe. The run is then written as one command. The disprove pass did not exercise one native Undo removing the entire finished run and Redo restoring its joins.  
   D-237, D-324 · missing test · **survived disprove pass**  
   `src/CeCivil.Hands/Pipe/PipeRun.cs:133` · `src/CeCivil.Acad/PipeCommand.cs:101`. [Decision check, line 42](../disproved_rulings_D298_D344.md#L42)

41. **The copy checks can pass with the wrong number, levels or joins.** One replay passed with two P3s. Another still matched with the copied invert 500 mm low and the wrong grade. The night tests can accept no remaining copied cover, or zero end links, because they check only the items left. A wrong end or tag offset can also pass when the partner name is right. These are gaps in the tests. The ordinary copy in the separate bench check retained its grade and invert.  
   D-179, D-262, D-340 · missing test · **survived disprove pass**  
   `src/CeCivil.Hands/Golden/Golden.cs:253` · `src/CeCivil.Hands/Golden/Golden.cs:263` · `src/CeCivil.Acad/CopyChecks.cs:71` · `src/CeCivil.Acad/PipeChecks.cs:271`. [Recording check, lines 11, 13, 27](../disproved_deep_src_CeCivil_Hands_Golden_Golden_cs.md#L11) · [Command-end check, lines 94, 98](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L94)

42. **The complete copied run lacks a save-and-reopen check.** The main-line cases do not trace a complete numbered run, its labels, both ends and their original owners through clipboard paste or block export, insertion, save, close and reopen. Grip-copy, readable mirrored lettering, recovery of an erased copy and Save As retaining the figures are also missing from that evidence.  
   D-179, D-216 (OC-09), D-340 · missing test · **not yet disproved**  
   `src/CeCivil.Acad/CopyChecks.cs:131` · `src/CeCivil.Acad/CopyChecks.cs:141` · `acad/NIGHT_TEST.md:35`. [Gate sweep, line 20](../../sweep_gate/FINDINGS.md#L20)

43. **A whole-drawing copy lacks a check on carried-over figures.** When last week’s drawing becomes a new job, the tests cover a drawing identifier and individual copied pits. They do not prove that a carried-over council discharge is marked assumed until confirmed. A normal Save As of the same job has a different requirement to retain its figures.  
   D-191, D-216 (OC-09) · missing test · **survived disprove pass**  
   `src/CeCivil.Acad/Commands.cs:135` · `acad/NIGHT_TEST.md:35`. [Drawing and sheets check, line 44](../disproved_rulings_DRAWING_AND_SHEETS.md#L44)

44. **The array check bypasses the way the drafter makes copies.** The night check makes separate objects, hands their identifiers to the copy routine and checks their numbers. It skips the command watcher and the packed array or block. It could still pass if the watcher stopped listening or never told the drafter about nested parts.  
   D-216 (OC-09), D-340 · missing test · **survived disprove pass**  
   `src/CeCivil.Acad/CopyChecks.cs:118` · `src/CeCivil.Acad/Commands.cs:193`. [Command-end check, line 96](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L96)

45. **The move and recovery checks can pass with the wrong drawing.** One recording passed with the far end of a pipe 2 m short. A reconnection check accepted an end inside the pit because its recorded join agreed with the wrong point. The resize check omits the new wall position. Other checks permit only one write to fail, so a failed repair or missing first label escapes them.  
   D-216 (OC-27), D-256, D-270 · missing test · **survived disprove pass**  
   `src/CeCivil.Hands/Golden/Golden.cs:257` · `src/CeCivil.Acad/PipeChecks.cs:327` · `tests/CeCivil.Hands.Tests/Round39HandsTests.cs:206` · `tests/CeCivil.Hands.Tests/GapFourTests.cs:70`. [Recording check, line 23](../disproved_deep_src_CeCivil_Hands_Golden_Golden_cs.md#L23) · [Pipe-end check, lines 74, 82, 72](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L74)

46. **The safety tests can pass even when a protected object moves.** A replay moved a locked pit 500 mm and still matched. Separate tests exercise refusal on a directly selected object. This replay cannot clear a normal drawing move in which an unlocked pit has a protected neighbour.  
   D-216 (OC-19), D-199 · missing test · **survived disprove pass**  
   `src/CeCivil.Hands/Golden/Golden.cs:225` · `src/CeCivil.Hands/EndOfCommand.cs:270`. [Recording check, line 17](../disproved_deep_src_CeCivil_Hands_Golden_Golden_cs.md#L17) · [Command-end check, line 12](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L12)

47. **The cancellation check loses its starting drawing.** The night check records a new starting state after planning the edit. A change made during the first step is then counted as part of the starting drawing. It cannot prove that cancelling leaves the drawing alone or preserves the Undo list.  
   D-216 (OC-07 and OC-08) · missing test · **survived disprove pass**  
   `src/CeCivil.Acad/PipeChecks.cs:229` · `src/CeCivil.Acad/PipeChecks.cs:234`. [Pipe edit check, line 178](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L178)

48. **The tests disagree about what survives when a pipe is exploded.** An earlier typed explosion retained the pipe’s note. The later recording that exploded a pipe from code lost it. What a drafter’s typed explosion leaves behind on this main-line revision still needs a drawing check.  
   D-216, D-325 · missing test · **survived disprove pass**  
   `src/CeCivil.Acad/AcadHost.cs:46` · `acad/EXPLODE_GAP.md:7`. [Recording check, line 53](../disproved_deep_src_CeCivil_Hands_Golden_Golden_cs.md#L53)

49. **The check for an ordinary drawing move lacks a matched comparison.** The cited checks do not compare a complete move, stretch and grip operation on plain objects with the release loaded and unloaded. They also leave open what CE does when a colleague moves a pit with the plug-in absent and later reopens it.  
   D-199, D-216 (OC-21, OC-22 and OC-26) · missing test · **not yet disproved**  
   `src/CeCivil.Acad/Commands.cs:135` · `acad/NIGHT_TEST.md:257`. [Gate sweep, lines 44, 46, 54](../../sweep_gate/FINDINGS.md#L44)

50. **The speed check can pass a 500 ms pit move.** In a ten-move test, a final 500 ms move was recorded but the pass was judged on 2 ms against the draft 100 ms limit. A single slow move can therefore pass. The figure came from the timing test, not a drafter’s live drawing.  
   D-165, D-216 (OC-26) · missing test · **survived disprove pass**  
   `src/CeCivil.Hands/Speed/Timing.cs:53` · `tests/CeCivil.Hands.Tests/SpeedTests.cs:344`. [Gate evidence check, line 40](../disproved_rulings_HOW_WE_WORK.md#L40)

51. **A large copy lacks a measured one-Undo result.** The source sweep found a pit-move timing case, but no result on this revision for copying or arraying 200 pipes in seconds and reversing the entire operation with one Undo.  
   D-216 (OC-26) · missing test · **not yet disproved**  
   `acad/NIGHT_TEST.md:257`. [Gate sweep, line 54](../../sweep_gate/FINDINGS.md#L54)

---

**What the drawing tests established.** The rebuild passed 7 of 7 AutoCAD checks on how links behave when copying. Its earlier review had recorded four faults involving the first copy in an older drawing, a pipe name in an array, a repeated pit number on a second paste, and an older drawing’s separate tag being erased. The board records a recheck of the repairs. The separate night run that passed pit erasure used another revision. [Rebuild history, lines 459–460](../../../../CE_PLAN/zero/BOARD.md#L459) · [Erase evidence, line 18](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L18)

**Open rulings.** With P1 and P3 in use, the lowest free number is P2 and the next above the highest is P4. The rulings leave that choice open. They also leave open which pit wins when a dragged end is exactly as close to two pits. Neither question is counted as a defect. [Numbering check, line 110](../disproved_deep_src_CeCivil_Hands_Pit_PitTool_cs.md#L110) · [Pipe-end check, line 60](../disproved_deep_src_CeCivil_Hands_Pipe_PipeEnds_cs.md#L60)

**Review record.** Read 115 input files, including 32 disprove passes, all five top-level deep reviews and all six files in the sweep folders. Planned tests were used to identify what needs proof. This report was the only file written. This review ran zero product tests and zero AutoCAD sessions, and made no code change, build or installation. The board supplies the release counts. Codex prepared the report. The job names `gpt-6.2-astra`. The session does not independently identify the model variant.
