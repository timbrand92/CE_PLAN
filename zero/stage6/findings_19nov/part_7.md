One-job release | Part 7 of 9: Job window and Unfinished list | Built 2, Checked 2, Installed 0, Accepted 0 (of 9)  
Now: Neither window opens from the drawing, and the bench can show the wrong discharge or hide a known pipe-level clash.

**42 findings survived a disprove pass.** A further 13 are marked “not yet disproved” and are excluded from that count. The list follows the most serious consequence for the drafter first. The source lines are for main at `2ce8070`.

1. **Both windows are missing from the drawing.** The drafter can open the two examples on the bench. AutoCAD registers neither window. Its manual self-check prints some drawing items, but cannot open Job or the Unfinished panel for the current drawing.  
   **ruling not built** · D-310, D-311, D-338 · survived disprove pass. [Commands.cs:7](../../../../CE_CIVIL/src/CeCivil.Acad/Commands.cs#L7) · [Disprove pass, line 10](../disproved_rulings_FIRST_RELEASE.md#L10)

2. **The council name changes but its rules do not.** Selecting Monash left its 65 mm minimum orifice and 60% underground-storage minimum off the job. Selecting Bayside left garden runoff at 0.35. Giving the calculation Bayside directly produced 0.30.  
   **wrong figure** · D-310, D-327, D-331 · survived disprove pass. [WindowModel.cs:1321](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/WindowModel.cs#L1321) · [Disprove pass, line 13](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L13)

3. **Job saves the permitted discharge against the wrong method.** With OSD4W selected, entering 4.70 L/s changed Boyd’s discharge. The OSD4W discharge used in the design stayed unknown while Job counted it as supplied.  
   **wrong figure** · D-310, D-332 · survived disprove pass. [jobsettings.csv:44](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv#L44) · [sums.csv:110](../../../../CE_CIVIL/src/CeCivil.Brain/data/sums.csv#L110) · [Disprove pass, line 14](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L14)

4. **A rejected slab thickness still feeds pipe cover.** Starting at 125 mm and typing “12x” left 12 mm available to Pipe. Pasting the whole bad entry could leave 125 mm available. Confirming can put the retained number back in the box. The affected cover should read “Cannot check yet”.  
   **wrong figure** · D-288, D-293, D-310 · survived disprove pass. [JobSettings.cs:64](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/JobSettings.cs#L64) · [StdJob.cs:236](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L236) · [Disprove pass, line 15](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L15) · [Disprove pass, line 4](../disproved_deep_src_CeCivil_Window_Parts_Std_StdInput_cs.md#L4)

5. **Accepted Job figures do not reach the next tool.** After Job accepted 650 m², Detention opened at 600 m². A separately opened Pipe lost a 165 mm driveway slab. The windows read separate copies, so changing a fact in one can leave another showing the example job.  
   **wrong figure** · D-171, D-249, D-293, D-310, D-311 · survived disprove pass. [WindowModel.cs:81](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/WindowModel.cs#L81) · [PipeToolWindow.cs:73](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/PipeToolWindow.cs#L73) · [Disprove pass, line 19](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L19) · [Disprove pass, line 32](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md#L32) · [Disprove pass, line 19](../disproved_rulings_DETENTION.md#L19)

6. **A held level clash disappears from Unfinished.** On an 8 m pipe at 1 in 100, held inverts of RL 5.23 m and RL 5.10 m disagree by 50 mm. The pipe update named the clash. Opening Unfinished checked the same pipe again and dropped the clash after receiving “Suits”.  
   **wrong figure** · D-124, D-125, D-311 · survived disprove pass. [Network.cs:417](../../../../CE_CIVIL/src/CeCivil.Brain/Things/Network.cs#L417) · [UnfinishedList.cs:37](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/UnfinishedList.cs#L37) · [Disprove pass, line 21](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L21)

7. **A whole system can lack an outlet and raise no row.** Two pits joined by a pipe can each have a connection while neither drains to the legal point. The drawing check looks for individual loose ends. The panel has no first row for that system, so the drafter can miss the missing outlet entirely.  
   **ruling not built** · D-176, D-275, D-311 · survived disprove pass. [Unfinished.cs:58](../../../../CE_CIVIL/src/CeCivil.Hands/Joins/Unfinished.cs#L58) · [UnfinishedList.cs:37](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/UnfinishedList.cs#L37) · [Disprove pass, line 78](../disproved_rulings_FOUNDATION.md#L78) · [Review, line 92](../../deep_Hands.md#L92)

8. **An erased connection still looks joined.** After erasing a main pipe, its branch kept the saved junction and had no loose-end row. Erasing a pit can likewise leave a record that hides the newly free pipe end. The list trusts the old connection.  
   **wrong figure** · D-176, D-221, D-237, D-311 · survived disprove pass. [Unfinished.cs:60](../../../../CE_CIVIL/src/CeCivil.Hands/Joins/Unfinished.cs#L60) · [PipeTool.cs:544](../../../../CE_CIVIL/src/CeCivil.Hands/Pipe/PipeTool.cs#L544) · [Disprove pass, line 82](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L82) · [Disprove pass, line 18](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L18)

9. **Good first entries and a council override can disappear.** A first rainfall entry of 112 mm/h reverted to “Not known”. Entering a 4.70 L/s council override against a calculated 6.00 L/s also left 6.00 L/s in use. The edit only sticks on these rows when there is already a held value. The wider screen check reported 10 of 10 first entries lost, including area, storm and connection invert. That wider count is not yet disproved.  
   **wrong figure** · D-249, D-310, D-332 · survived disprove pass. [WindowModel.cs:776](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/WindowModel.cs#L776) · [StdJob.cs:193](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L193) · [Disprove pass, line 17](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L17) · [Review, line 48](../screen_jobsettings.md#L48)

10. **Clearing rainfall can leave an old figure looking valid.** Clearing 98.6 mm/h restored 98.6 when the drafter left the box. Job hid the explanation, then cleared its warning when House was selected, without anyone supplying new rainfall.  
   **wrong figure** · D-249, D-288, D-310 · survived disprove pass. [WindowModel.cs:804](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/WindowModel.cs#L804) · [StdJob.cs:194](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L194) · [Disprove pass, line 18](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L18)

11. **Job can say “Ready” while a figure is wrong.** With the other fields complete, 0 mm/h triggered a Wrong rainfall check but Job showed zero outstanding figures. A council consisting entirely of spaces also counted as supplied to Schedule.  
   **wrong figure** · D-286, D-288, D-310 · survived disprove pass. [StdJob.cs:66](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L66) · [JobSettings.cs:116](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/JobSettings.cs#L116) · [Disprove pass, line 12](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L12) · [Disprove pass, line 26](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L26)

12. **The engineer cannot set this job’s tolerance.** Job shows a note where the 5 mm setting belongs. When the calculation was set to 3 mm, reopening Pipe gave it 5 mm again. Cover of 246 mm against 250 mm passes at 5 mm and fails at 3 mm.  
   **ruling not built** · D-310, D-318, D-321 · survived disprove pass. [StdJob.cs:139](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L139) · [PipeToolWindow.cs:73](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/PipeToolWindow.cs#L73) · [Disprove pass, line 16](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L16) · [Disprove pass, line 110](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L110)

13. **Assumed figures can disappear from review.** A 20 mm inlet drop held as assumed on a join produced zero reminders. Rainfall explicitly marked assumed in Detention also produced zero reminders in a separately opened Unfinished window. The join collector skips joins, and the second window opens its own example.  
   **ruling not built** · D-177, D-218, D-249, D-311 · survived disprove pass. [Network.cs:435](../../../../CE_CIVIL/src/CeCivil.Brain/Things/Network.cs#L435) · [UnfinishedList.cs:44](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/UnfinishedList.cs#L44) · [Disprove pass, line 36](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md#L36) · [Disprove pass, line 19](../disproved_rulings_DETENTION.md#L19)

14. **Two tags can claim the same pit without asking which is real.** An older drawing needs one row asking the drafter to choose the real tag. Both tags can instead be left claiming the pit. In the drawing model, switching the tag off erased one of them without that choice.  
   **unsafe edit** · D-311, D-340 · survived disprove pass. [PitTool.cs:148](../../../../CE_CIVIL/src/CeCivil.Hands/Pit/PitTool.cs#L148) · [Unfinished.cs:62](../../../../CE_CIVIL/src/CeCivil.Hands/Joins/Unfinished.cs#L62) · [Disprove pass, line 8](../disproved_rulings_D298_D344.md#L8) · [Disprove pass, line 10](../disproved_deep_src_CeCivil_Window_Parts_WindowFrame_cs.md#L10)

15. **Handwritten pipe wording can be lost without a reminder.** After the drafter wrote “EXISTING PIPE”, accepting a pipe edit restored the generated label. Unfinished had no row naming the held wording or letting the drafter choose when to follow the pipe again.  
   **unsafe edit** · D-182, D-185, D-311 · survived disprove pass. [EndOfCommand.cs:336](../../../../CE_CIVIL/src/CeCivil.Hands/EndOfCommand.cs#L336) · [PipeTool.cs:711](../../../../CE_CIVIL/src/CeCivil.Hands/Pipe/PipeTool.cs#L711) · [Disprove pass, line 28](../disproved_rulings_FOUNDATION.md#L28) · [Disprove pass, line 44](../disproved_deep_src_CeCivil_Hands_EndOfCommand_cs.md#L44)

16. **The cover check can use more slab thickness than Job shows.** Job displayed 100 mm for both 100 mm and 100.5 mm. On the same pipe at the tolerance boundary those entries gave opposite cover verdicts.  
   **wrong figure** · D-293, D-318, D-321 · survived disprove pass. [JobSettings.cs:42](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/JobSettings.cs#L42) · [StdJob.cs:250](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L250) · [Disprove pass, line 23](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L23)

17. **A saved tolerance can show one value and use another.** In the calculation model, setting 2.5 mm directly was refused. Changing an already saved 5 mm setting through the value it returned accepted 2.5 mm and displayed 3 mm. This was reproduced beneath the window.  
   **wrong figure** · D-318, D-321 · survived disprove pass. [Network.cs:127](../../../../CE_CIVIL/src/CeCivil.Brain/Things/Network.cs#L127) · [Disprove pass, line 50](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md#L50)

18. **A copied drawing has no job-wide confirmation.** Starting a new job from a saved drawing has no step to mark inherited site area or rainfall as assumed and ask the engineer to confirm them. A copied pit’s level has its own separate handling.  
   **ruling not built** · D-191, D-310 · survived disprove pass. [Commands.cs:135](../../../../CE_CIVIL/src/CeCivil.Acad/Commands.cs#L135) · [Network.cs:93](../../../../CE_CIVIL/src/CeCivil.Brain/Things/Network.cs#L93) · [Disprove pass, line 54](../disproved_rulings_FOUNDATION.md#L54) · [Disprove pass, line 44](../disproved_rulings_DRAWING_AND_SHEETS.md#L44)

19. **The job loses the office figures it was designed with.** Step 3 has no saved office-list date, comparison or “Take it up” action. If the office pit drop changes from 20 to 30 mm, the drafter cannot see the old and new values or choose which the job keeps.  
   **ruling not built** · D-180, D-310 · survived disprove pass. [jobsettings.csv:60](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv#L60) · [StdJob.cs:403](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L403) · [Disprove pass, line 30](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L30) · [Disprove pass, line 54](../disproved_rulings_FOUNDATION.md#L54)

20. **Unfinished cannot take the drafter to the part.** “Go to” lights the list row alone. The drawing has no handler to locate the selected pipe or pit. The approved panel is meant to sit beside the drawing and light the matching part.  
   **ruling not built** · D-301, D-311 · survived disprove pass. [UnfinishedList.cs:117](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/UnfinishedList.cs#L117) · [StdUnfinished.cs:108](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdUnfinished.cs#L108) · [Disprove pass, line 26](../disproved_rulings_D298_D344.md#L26) · [Disprove pass, line 42](../disproved_deep_src_CeCivil_Window_Parts_WindowFrame_cs.md#L42)

21. **An engineer cannot accept a finding with a note.** A Wrong row offers “Go to” only. The drafter cannot record the engineer’s reason, keep the measured shortfall visible, or find the decision again under “Accepted with a note”.  
   **ruling not built** · D-003, D-311 · survived disprove pass. [UnfinishedList.cs:6](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/UnfinishedList.cs#L6) · [StdUnfinished.cs:108](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdUnfinished.cs#L108) · [Disprove pass, line 26](../disproved_rulings_D298_D344.md#L26)

22. **The last faults in a long list cannot be reached.** Only the rows that fit can be selected. In the 1080 example six amber rows were hidden. The remaining line calls them the least urgent and provides no way to reveal them, even when hidden rows have the same urgency as visible ones.  
   **screen rule** · D-286, D-311 · not yet disproved. [StdUnfinished.cs:73](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdUnfinished.cs#L73) · [StdUnfinished.cs:85](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdUnfinished.cs#L85) · [Review, line 46](../screen_unfinished.md#L46) · [Review, line 46](../../deep_Window.md#L46)

23. **Plotting gives no count of unfinished work.** A drafter can plot a sheet with open pipe ends or assumed figures and get no quiet line giving the count. Getting the list requires a separate manual self-check.  
   **ruling not built** · D-188, D-311 · survived disprove pass. [Commands.cs:89](../../../../CE_CIVIL/src/CeCivil.Acad/Commands.cs#L89) · [Commands.cs:221](../../../../CE_CIVIL/src/CeCivil.Acad/Commands.cs#L221) · [Disprove pass, line 30](../disproved_rulings_DRAWING_AND_SHEETS.md#L30)

24. **The reminder to place the standing note is missing.** The schedule can mark an assumed level “APPROX.”. Unfinished does not remind the drafter to place the approved note once on that sheet.  
   **ruling not built** · D-177, D-248, D-311 · survived disprove pass. [UnfinishedList.cs:44](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/UnfinishedList.cs#L44) · [ScheduleModel.cs:274](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs#L274) · [Disprove pass, line 16](../disproved_rulings_FOUNDATION.md#L16)

25. **Missing outlet lettering can pass unnoticed.** With no usable text height, a connected council-pipe outlet can have neither a tag nor a note. The tool warns at placement, but Unfinished gives the next drafter no row for the missing words.  
   **ruling not built** · D-274, D-311 · survived disprove pass. [Unfinished.cs:55](../../../../CE_CIVIL/src/CeCivil.Hands/Joins/Unfinished.cs#L55) · [LpdTool.cs:154](../../../../CE_CIVIL/src/CeCivil.Hands/Outlet/LpdTool.cs#L154) · [Disprove pass, line 40](../disproved_deep_src_CeCivil_Hands_Outlet_LpdTool_cs.md#L40)

26. **Job lacks the inputs for calculating the permitted discharge.** The engineer can have a calculated discharge or a letter figure. Job offers no entry for the pre-development runoff coefficient or the five-year rainfall needed for the calculated route. A pre-filled 6.00 L/s can conceal that gap.  
   **ruling not built** · D-310, D-332 · survived disprove pass. [jobsettings.csv:44](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv#L44) · [Disprove pass, line 17](../disproved_rulings_DETENTION.md#L17)

27. **Job has no rainfall-table paste or visible source.** There are six separate duration boxes. The drafter cannot select the council rainfall source or paste the Bureau table for the site, and cannot see the source beside the entries.  
   **ruling not built** · D-249, D-310 · survived disprove pass. [StdJob.cs:158](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L158) · [StdJob.cs:204](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L204) · [Disprove pass, line 20](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L20) · [Disprove pass, line 19](../disproved_rulings_DETENTION.md#L19)

28. **An assumed connection invert cannot be confirmed in Job.** Changing an assumed connection invert from RL 4.95 m to RL 4.98 m kept it assumed. The approved Given/Assumed choice is missing, so entering the figure from the council letter does not clear the reminder.  
   **ruling not built** · D-177, D-310 · survived disprove pass. [StdJob.cs:212](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L212) · [WindowModel.cs:778](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/WindowModel.cs#L778) · [Disprove pass, line 20](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L20)

29. **A provisional discharge can keep the word “given”.** Job has no assumption choice for the discharge or destination. Typing a provisional 5.00 L/s over a previously supplied discharge can leave it marked “given” while the council letter is still outstanding.  
   **wrong figure** · D-030, D-074, D-310 · not yet disproved. [jobsettings.csv:44](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv#L44) · [WindowModel.cs:778](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/WindowModel.cs#L778) · [Review, line 38](../rulings_OUTLET_AND_LPD.md#L38)

30. **The stated source of a figure can be wrong.** An assumed 100 mm slab is labelled “given”. A missing council minimum is credited to a “council letter on file”, and a council runoff figure can be credited to the office. The two example slabs also claim to come from job plans although they came from the mock-up.  
   **wrong figure** · D-086, D-148, D-191, D-293, D-310, D-331 · survived disprove pass. [StdJob.cs:246](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L246) · [jobsettings.csv:54](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv#L54) · [Disprove pass, line 21](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L21) · [Disprove pass, line 24](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L24) · [Disprove pass, line 30](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md#L30)

31. **The drawing scale and model units are absent.** Step 2 does not show that the plan is drawn full size in millimetres and the layout is, for example, 1:100. The approved Job window displays both.  
   **ruling not built** · D-194, D-310 · survived disprove pass. [jobsettings.csv:53](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv#L53) · [StdJob.cs:337](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L337) · [Disprove pass, line 29](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L29)

32. **Site area cannot be picked from its boundary.** Job offers an area box but no way to measure the closed boundary into it. The engineer cannot compare that measurement with the supplied site area before choosing which figure to use.  
   **ruling not built** · D-171, D-286, D-310 · survived disprove pass. [jobsettings.csv:42](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv#L42) · [Disprove pass, line 50](../disproved_rulings_FIRST_RELEASE.md#L50)

33. **The Job picker offers only two councils.** The drafter may type another name, but adding a council to the standards list does not add it to the choices. The picker still offers only Glen Eira and Kingston.  
   **ruling not built** · D-009, D-310 · survived disprove pass. [jobsettings.csv:39](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv#L39) · [Disprove pass, line 46](../disproved_rulings_DIRECTION.md#L46)

34. **Some drawing facts never become Unfinished rows.** The drawing self-check can omit an assumed cover on a fully connected pit. The bench list can also omit a missing lid class, even when all rows fit. The approved list names the pit and the missing figure.  
   **ruling not built** · D-074, D-286, D-311 · not yet disproved. [Unfinished.cs:54](../../../../CE_CIVIL/src/CeCivil.Hands/Joins/Unfinished.cs#L54) · [UnfinishedList.cs:48](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/UnfinishedList.cs#L48) · [Review, line 6](../rulings_MANAGER.md#L6) · [Review, line 50](../screen_unfinished.md#L50)

35. **The Job window omits two drainage destinations.** The legal-point tool knows five destinations. Job offers three. A drafter cannot record “existing system on site” or “soak on site” there.  
   **ruling not built** · D-273, D-275, D-310 · not yet disproved. [jobsettings.csv:45](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv#L45) · [Review, line 22](../rulings_OUTLET_AND_LPD.md#L22)

36. **One house-driveway paving has no job thickness box.** A house driveway with pavers has a distinct cover calculation. Job offers the concrete house-driveway box only, so the drafter cannot supply the paver thickness once for the job.  
   **ruling not built** · D-293, D-310 · not yet disproved. [jobsettings.csv:28](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv#L28) · [job_slab.csv:9](../../../../CE_CIVIL/src/CeCivil.Brain/data/tables/job_slab.csv#L9) · [Review, line 16](../rulings_JOB_AND_OFFICE.md#L16)

37. **The first-drawing count misses the detention method.** The example with neither method selected reports 16 missing figures although 17 need attention. Detention and Schedule both list Method as missing, but neither the Job headline nor the choice itself tells the drafter.  
   **wrong figure** · D-286, D-310 · not yet disproved. [JobSettings.cs:123](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/JobSettings.cs#L123) · [StdJob.cs:310](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L310) · [Review, line 50](../screen_jobsettings.md#L50)

38. **A refused slab looks like one that has never been entered.** Entering −5 mm leaves the same amber “Needs you” band as an empty slab. The small grey explanation is easy to miss. The approved failure state is “Wrong”.  
   **screen rule** · D-286, D-295, D-310 · not yet disproved. [StdJob.cs:68](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L68) · [StdJob.cs:244](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L244) · [Review, line 30](../screen_jobsettings.md#L30)

39. **The storm label can describe the wrong return period.** Job displays a bare 10 for “Storage storm”. Changing it to 20 leaves the rainfall heading at “1 in 10”. The mismatch is visible. Which rainfall series to use when the return period changes remains an engineering decision.  
   **screen rule** · D-249, D-310 · survived disprove pass. [StdJob.cs:156](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L156) · [StdJob.cs:191](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L191) · [Disprove pass, line 27](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L27) · [Disprove pass, line 28](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L28)

40. **A blank slab can lose its “Not known” wording.** Typing a space clears the thickness. While the box still has focus, it looks blank although the model knows that the figure is missing.  
   **screen rule** · D-286, D-295, D-310 · survived disprove pass. [StdInput.cs:143](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdInput.cs#L143) · [JobSettings.cs:62](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/JobSettings.cs#L62) · [Disprove pass, line 18](../disproved_deep_src_CeCivil_Window_Parts_Std_StdInput_cs.md#L18)

41. **A missing office figure can look like a measured figure.** When the office threshold is absent but the pit has its own override, Job can show “Not known m” in the normal answer colour. The shipped list has a threshold. The disprove pass reproduced this with that office entry removed in memory.  
   **screen rule** · D-286, D-310 · survived disprove pass. [StdJob.cs:360](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L360) · [ViewModels.cs:146](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/ViewModels.cs#L146) · [Disprove pass, line 25](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L25)

42. **Some warnings do not tell the drafter how far out the part is.** For a 620 mm pit against a 600 mm guide, Unfinished quotes the guide but omits “20 mm over” and the next action. A cover row says “Short by 1.65” without a unit. The shortfall has the same visual weight as the explanation.  
   **screen rule** · D-286, D-295, D-311 · not yet disproved. [StdUnfinished.cs:132](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdUnfinished.cs#L132) · [checks.csv:59](../../../../CE_CIVIL/src/CeCivil.Brain/data/checks.csv#L59) · [Review, line 18](../screen_unfinished.md#L18) · [Review, line 26](../screen_unfinished.md#L26) · [Review, line 60](../screen_unfinished.md#L60)

43. **A changed council loses its point of comparison.** After a council change, Job shows the new name without a “Changed” mark or the opening council for comparison.  
   **screen rule** · D-286, D-295, D-310 · not yet disproved. [StdJob.cs:269](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L269) · [StdJob.cs:66](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L66) · [Review, line 54](../screen_jobsettings.md#L54)

44. **Job omits the new-pipe starting figures.** The approved office-settings step shows the starting pipe diameter and grade. The built step has no corresponding row for the drafter to read.  
   **ruling not built** · D-310 · not yet disproved. [jobsettings.csv:53](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv#L53) · [DRAFTS_job_unfinished.md:12](../../../../CE_CIVIL/bench/DRAFTS_job_unfinished.md#L12) · [Review, line 21](../../sweep_rulings/FINDINGS.md#L21)

45. **A valid new warning can disappear from the Job layout.** Adding an ordinary note to Step 2 left a blank row on the bench. The shipped five rows all display. The omission occurs when the office supplies a row of a recognised kind that this screen does not draw.  
   **screen rule** · D-286, D-310 · survived disprove pass. [StdJob.cs:366](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L366) · [Disprove pass, line 31](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L31)

46. **Window wording and controls differ from the approved screens.** Job leaves “OSD4W” and “Pervious runoff” unexplained and uses different-sized arrow and close marks. Unfinished uses a 32 px “Go to” button in place of the approved 24 px one, adds 4 px gaps and can show bench wording on closing.  
   **screen rule** · D-286, D-295, D-310, D-311 · not yet disproved. [jobsettings.csv:41](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/windows/jobsettings.csv#L41) · [StdChrome.cs:30](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdChrome.cs#L30) · [StdUnfinished.cs:153](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdUnfinished.cs#L153) · [WindowHost.cs:112](../../../../CE_CIVIL/src/CeCivil.Window/WindowHost.cs#L112) · [Review, line 56](../screen_jobsettings.md#L56) · [Review, line 60](../screen_jobsettings.md#L60) · [Review, line 56](../screen_unfinished.md#L56) · [Review, line 60](../screen_unfinished.md#L60)

47. **The tolerance tests would reject the required box.** Two checks require the placeholder and the absence of an editable tolerance. A working, labelled 5 mm setting would fail them. Neither enters 3 mm in Job and follows the verdict through to Pipe.  
   **missing test** · D-310, D-321 · survived disprove pass. [JobAndUnfinishedWindowTests.cs:148](../../../../CE_CIVIL/bench/CeCivil.Bench.Tests/JobAndUnfinishedWindowTests.cs#L148) · [StyleCheckJobUnfinished.cs:53](../../../../CE_CIVIL/bench/CeCivil.Bench/StyleCheckJobUnfinished.cs#L53) · [Disprove pass, line 36](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L36)

48. **The sharing test passes when the windows disagree after an edit.** The test compares opening values loaded from examples. It never changes Job, accepts the edit and checks the next tool, so it passed with 650 m² in Job and 600 m² in Detention.  
   **missing test** · D-171, D-310, D-311 · survived disprove pass. [JobAndUnfinishedWindowTests.cs:35](../../../../CE_CIVIL/bench/CeCivil.Bench.Tests/JobAndUnfinishedWindowTests.cs#L35) · [Disprove pass, line 37](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L37)

49. **The clash test counts answers without checking their verdicts.** The two readings each returned 49 results. On the same example, 36 differed in status or in whether the check could run. Comparing only the counts let the test pass.  
   **missing test** · D-125, D-311 · survived disprove pass. [ChecksTests.cs:923](../../../../CE_CIVIL/tests/CeCivil.Brain.Tests/ChecksTests.cs#L923) · [Disprove pass, line 54](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L54)

50. **The first-entry and refusal tests skip what the drafter types.** The slab test sends a whole invalid word to an empty box. It misses the effect of typing into an existing 125 mm slab. The first-drawing check clears rainfall directly and never fills the empty box or leaves it.  
   **missing test** · D-249, D-293, D-310 · survived disprove pass. [JobAndUnfinishedWindowTests.cs:81](../../../../CE_CIVIL/bench/CeCivil.Bench.Tests/JobAndUnfinishedWindowTests.cs#L81) · [BenchStates.cs:18](../../../../CE_CIVIL/bench/CeCivil.Bench/BenchStates.cs#L18) · [Disprove pass, line 38](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L38) · [Disprove pass, line 41](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L41)

51. **The navigation test stops before the actual pipe.** The test supplies its own receiver and passes when the row asks to jump. It never checks which drawing object lit up, whether the view reached it, or whether the highlight cleared.  
   **missing test** · D-301, D-311 · survived disprove pass. [JobAndUnfinishedWindowTests.cs:225](../../../../CE_CIVIL/bench/CeCivil.Bench.Tests/JobAndUnfinishedWindowTests.cs#L225) · [StyleCheckJobUnfinished.cs:68](../../../../CE_CIVIL/bench/CeCivil.Bench/StyleCheckJobUnfinished.cs#L68) · [Disprove pass, line 26](../disproved_rulings_D298_D344.md#L26) · [Disprove pass, line 78](../disproved_rulings_FOUNDATION.md#L78)

52. **The Job screen tests can miss a wrong field, missing tool or grey selection.** “Not known” on a different box can satisfy the check. Removing Detention from both the list and the panel also passed. Turning every selected button grey still passed the Job colour check.  
   **missing test** · D-286, D-295, D-310 · survived disprove pass. [StyleCheckJobUnfinished.cs:40](../../../../CE_CIVIL/bench/CeCivil.Bench/StyleCheckJobUnfinished.cs#L40) · [StyleCheckJobUnfinished.cs:50](../../../../CE_CIVIL/bench/CeCivil.Bench/StyleCheckJobUnfinished.cs#L50) · [Disprove pass, line 39](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L39) · [Disprove pass, line 40](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L40) · [Disprove pass, line 28](../disproved_deep_src_CeCivil_Window_Parts_Std_StdInput_cs.md#L28)

53. **A long-list test accepts hidden faults.** The test checks the overflow wording. It never asks the drafter to identify or reach the last Wrong row when the panel is full.  
   **missing test** · D-286, D-311 · not yet disproved. [JobAndUnfinishedWindowTests.cs:318](../../../../CE_CIVIL/bench/CeCivil.Bench.Tests/JobAndUnfinishedWindowTests.cs#L318) · [Review, line 40](../../deep_Bench.md#L40)

54. **The live drawing and screen-size checks are still outstanding.** The Part 7 plan contains 64 numbered entries and records zero AutoCAD tests. The saved bench pictures do not prove save, reopen, Cancel or one drawing undo. There is also no recorded check of the panel beside a drawing at 150% on the drafting laptop, or a picture of the all-clear Unfinished panel. The common setup and find-and-fix tasks also lack a measured click count in these reviews.  
   **missing test** · D-193, D-286, D-308, D-310, D-311 · not yet disproved. [Shoot.cs:21](../../../../CE_CIVIL/bench/CeCivil.Bench/Shoot.cs#L21) · [Chooser.cs:78](../../../../CE_CIVIL/bench/CeCivil.Bench/Chooser.cs#L78) · [Test plan, line 16](../testplan_p7.md#L16) · [Review, line 14](../screen_jobsettings.md#L14) · [Review, line 64](../screen_unfinished.md#L64) · [Review, line 38](../screen_unfinished.md#L38) · [Test plan, line 386](../testplan_p7.md#L386)

55. **The time taken for a Job edit has not been established.** One slab text change caused two full recalculations and redraws. The disprove pass counted both but did not time them. It therefore gives no verdict against the 0.1 s typing target.  
   **missing test** · D-165, D-286, D-310 · survived disprove pass. [StdJob.cs:230](../../../../CE_CIVIL/src/CeCivil.Window/Parts/Std/StdJob.cs#L230) · [JobSettings.cs:68](../../../../CE_CIVIL/bench/CeCivil.Bench.Core/JobSettings.cs#L68) · [Disprove pass, line 32](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L32)

---

**Review coverage.** Read 121 files as at 19 November 2026, 08:04 PM AEDT, including 110 under `findings` (35 disprove passes), 6 in the sweep folders and 5 top-level deep reviews. Repeated reports of the same fault count once. A planned test supplies no pass result. D-288 includes planning calls. The job brief specifies `gpt-6.2-astra`.

**Verification.** Checked every cited file and line. Product tests run for this review 0. AutoCAD sessions 0. The only file written was this list.
