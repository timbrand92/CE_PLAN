One-job release | Part 3 of 9: Cover and grade checks, 5 mm tolerance | Built 2, Checked 2, Installed 0, Accepted 0 (of 9)  
Now: A pipe with 291.67 mm of cover passed a 300 mm minimum at the job’s 5 mm tolerance.

**40 findings survived a disprove pass.** A further 10 are marked **not yet disproved** and are excluded from that count. Each link opens the review that supplies the example. Code paths start at `C:\CE_CIVIL`.

1. **A shallow pipe can pass outside the job tolerance.** An 8 m pipe at 1 in 75 had 291.67 mm of cover against 300 mm. Using the downstream invert printed as RL 5.12 gave 295 mm and “Suits”. Holding the full invert gave “Wrong”. The same rounding made a 4 mm fall read “runs uphill”.  
   `src/CeCivil.Brain/Facts/Fact.cs:54` · `src/CeCivil.Brain/data/printed_figures.csv:6` · D-318, D-321 · **wrong figure** · survived. [Checks, line 12](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L12)

2. **A low point between pits gets no cover check.** Both pits can meet 300 mm while a bend has only 240 mm. Pipe receives the two end levels and one length. There is nowhere to take an intermediate finished level or the underside of paving into the check.  
   `src/CeCivil.Hands/Pipe/PipeTool.cs:53` · `src/CeCivil.Brain/data/checks.csv:37` · D-146, D-330, D-338 · **ruling not built** · survived. [Pipe, line 98](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L98)

3. **The last pipe loses the legal point’s levels.** Opening a pipe joined to the legal point rebuilt that end as a pit. Its council invert was lost and the window ran zero council-arrival checks. This also bypasses the cover check specific to the legal point.  
   `bench/CeCivil.Bench.Core/PipeToolWindow.cs:36` · `src/CeCivil.Brain/data/checks.csv:47` · D-018, D-176, D-321, D-338 · **ruling not built** · survived. [Pipe, line 102](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L102)

4. **A too-flat pipe can pass after its measured length is rounded.** Over 10.004 m, a 50 mm fall gives 1 in 200.08 and warrants “Needs a look”. The window received 10.00 m, calculated 1 in 200.00 and said “Suits”.  
   `src/CeCivil.Hands/Pipe/PipeTool.cs:221` · `bench/CeCivil.Bench.Core/PipeToolWindow.cs:65` · `src/CeCivil.Brain/data/checks.csv:28` · D-142, D-277, D-321 · **wrong figure** · survived. [Pipe, line 90](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L90)

5. **A hand-curved pipe is checked at the distance across its ends.** A semicircle of 5 m radius supplied 10.00 m instead of 15.71 m. The same fall therefore appears steeper. On a closed line the measurement also omits the closing side. Straight bends were the control.  
   `src/CeCivil.Acad/AcadDrawing.cs:93` · `src/CeCivil.Hands/Pipe/PipeTool.cs:220` · D-277, D-338 · **wrong figure** · survived. [Pipe, line 94](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L94)

6. **The drawing’s Pipe window starts again at 5 mm.** Job has no editable tolerance. Even when 3 mm was supplied to one calculation, opening the same pipe started a fresh one at 5 mm. A pipe with 246 mm against 250 mm fails at 3 mm and passes at 5 mm.  
   `bench/CeCivil.Bench.Core/PipeToolWindow.cs:73` · `src/CeCivil.Window/Parts/Std/StdJob.cs:139` · D-310, D-318, D-321 · **wrong figure** · survived. [Pipe, line 110](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L110) · [Job window, line 16](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L16)

7. **Accepting an edit can erase the engineer’s cover requirement.** A saved 450 mm cover requirement and its source disappeared after a Pipe edit. OK rewrites the pipe record using only diameter, grade, both inverts and pipe kind.  
   `src/CeCivil.Hands/Pipe/PipeTool.cs:527` · `src/CeCivil.Brain/data/tools.csv:109` · D-086, D-287, D-330 · **unsafe edit** · survived. [Pipe, line 60](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L60)

8. **Pipe gives the drafter no surface choice or cover override.** The calculation has 300 mm for a paved driveway and 450 mm for an unpaved vehicle crossing. On a new pipe the drafter cannot select between them, see the governing preset as a standing field or enter the engineer’s replacement.  
   `bench/CeCivil.Bench.Core/windows/pipe.csv:26` · `src/CeCivil.Brain/data/tools.csv:109` · D-133, D-287, D-330 · **ruling not built** · not yet disproved. [Levels and standards, line 88](../rulings_LEVELS_AND_STANDARDS.md#L88) · [Levels and standards, line 112](../rulings_LEVELS_AND_STANDARDS.md#L112)

9. **A larger shortfall at the other end can disappear.** Both ends needed 300 mm. The Pipe window showed the first end at 293 mm and omitted the other end at 200 mm. Two red cover warnings for the same pipe were reduced to one, hiding the 100 mm shortage.  
   `bench/CeCivil.Bench.Core/WindowModel.cs:1771` · D-140, D-280, D-321 · **screen rule** · not yet disproved. [Bench review, line 16](../../deep_Bench.md#L16)

10. **A negative cover requirement can earn a green result.** In a calculation with −300 mm held as the required cover, a pipe with only 10 mm of actual cover passed. The refusal for a bad dimension does not protect the required-cover figure in this example.  
   `src/CeCivil.Brain/data/checks.csv:37` · `src/CeCivil.Brain/data/checks.csv:158` · D-140, D-288, D-321 · **wrong figure** · not yet disproved. [Calculation review, line 64](../../deep_Brain.md#L64)

11. **A known grade clash disappears from Unfinished.** An 8 m pipe at 1 in 100 with held inverts RL 5.23 and 5.10 has a 50 mm clash. Pipe reported it. Unfinished asked for the checks again without the clash, got “Suits” and dropped that warning.  
   `src/CeCivil.Brain/Things/Network.cs:417` · `bench/CeCivil.Bench.Core/UnfinishedList.cs:37` · D-124, D-125, D-311 · **wrong figure** · survived. [Checks, line 21](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L21) · [Network, line 10](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md#L10)

12. **Two bad entries can leave a usable-looking cover figure.** With length 0 m and slab −100 mm, the cover check recognised the bad slab but the job still held 550 mm of calculated cover. Only the figures affected by the first bad entry were cleared.  
   `src/CeCivil.Brain/Things/Checks.cs:371` · `src/CeCivil.Brain/Things/Network.cs:363` · D-288 · **wrong figure** · survived. [Checks, line 15](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L15) · [Network, line 12](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md#L12)

13. **A refused grade can still show a fall, a passing invert or a clash.** Entering letters over 1 in 100 left the bench showing 0.08 m fall and a downstream invert marked “Suits”. In the engine, an 8 m pipe at 1 in −50 could leave a 250 mm clash after the invalid fall was cleared. The affected result should say “Cannot check yet”.  
   `src/CeCivil.Brain/Things/Network.cs:331` · `src/CeCivil.Window/Parts/Std/StdSteps.cs:589` · D-124, D-219, D-288 · **wrong figure** · survived. [Window working, line 10](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md#L10) · [Network, line 14](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md#L14)

14. **The cover sketch can overstate cover by the full slab thickness.** The sketch showed 450 mm to the finished surface where 125 mm of paving left 325 mm to the crown. It still showed 450 mm with the slab missing. Both sketch layouts use this shortcut. The separate cover calculation deducts the slab.  
   `src/CeCivil.Window/Parts/Std/StdPictures.cs:193` · `src/CeCivil.Window/Parts/Pictures.cs:185` · D-146, D-293, D-330 · **wrong figure** · survived. [Pipe sketches, line 11](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md#L11)

15. **A bad diameter can increase the cover shown in the sketch.** At surface RL 10.00 and invert RL 9.40, a diameter of −150 mm gave 750 mm of apparent cover while the diameter check said “Wrong”. The sketch supplies a figure where it should say “Cannot check yet”.  
   `src/CeCivil.Window/Parts/Std/StdPictures.cs:182` · D-219, D-288 · **wrong figure** · survived. [Pipe sketches, line 12](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md#L12)

16. **The slab entered in Job does not reach a separately opened pipe.** After 165 mm was entered for a house driveway, a separately opened Pipe window had no job slab and could not check paved cover. The drawing-backed Pipe window also starts its own calculation.  
   `bench/CeCivil.Bench.Core/WindowModel.cs:81` · `bench/CeCivil.Bench.Core/JobSettings.cs:55` · D-171, D-293 · **ruling not built** · survived. [Network, line 32](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md#L32)

17. **There is no entry for a local thickening or for the job’s paver thickness.** The Job form has slab entries for three kinds of paving but no paver entry. Pipe has no control or saved field for the engineer to use a different thickness on one pipe. A thicker slab over one crossing therefore cannot be allowed for through the window.  
   `bench/CeCivil.Bench.Core/windows/jobsettings.csv:28` · `src/CeCivil.Brain/data/tools.csv:109` · D-146, D-293 · **ruling not built** · not yet disproved. [Levels and standards, line 96](../rulings_LEVELS_AND_STANDARDS.md#L96)

18. **The selected council is not carried into the calculation.** Choosing a council changes the text in Job. That choice does not set the council used by the calculation. The calculation itself distinguishes a 250 mm council house-garden minimum from the 100 mm office figure when its council is set directly.  
   `bench/CeCivil.Bench.Core/WindowModel.cs:1319` · D-022, D-144, D-310 · **ruling not built** · survived. [Later rulings, line 10](../disproved_rulings_D298_D344.md#L10) · [Standards, line 28](../disproved_deep_src_CeCivil_Brain_Things_Standards_cs.md#L28)

19. **A refused slab entry can leave its first digits in use.** Starting at 125 mm and typing 12x one character at a time left 12 mm saved after the refusal. Pipe still listed a slab as supplied. Pasting the whole bad entry retained 125 mm, so a paste-only test misses the fault.  
   `bench/CeCivil.Bench.Core/JobSettings.cs:59` · `src/CeCivil.Window/Parts/Std/StdJob.cs:230` · D-293, D-288 · **wrong figure** · survived. [Job window, line 15](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L15) · [Input fields, line 4](../disproved_deep_src_CeCivil_Window_Parts_Std_StdInput_cs.md#L4)

20. **Charged and suspended pipes get the same missing-cover answer.** A buried charged pipe lost the ordinary 300 mm garden requirement. A suspended pipe should show a grey “no cover check: suspended”. It instead asked for a requirement, and directly supplying 300 mm made it say “Suits”.  
   `src/CeCivil.Brain/data/tables/cover_by_kind.csv:4` · `src/CeCivil.Brain/data/sums.csv:19` · D-269 · **ruling not built** · survived. [Checks, line 24](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L24)

21. **A loose pipe loses a grade warning that its typed grade already proves.** With grade held at 1 in 250 and both inverts missing, the ordinary pipe did not show the 1 in 200 warning. Giving it just the upstream invert made the warning appear. The missing levels prevent checking fall direction. The typed grade is already flatter than the limit.  
   `src/CeCivil.Brain/data/checks.csv:23` · `src/CeCivil.Brain/Things/Checks.cs:365` · D-142, D-154, D-176 · **wrong figure** · survived. [Checks, line 33](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L33)

22. **A held pit drop is left out when the pipe is reopened.** A saved 50 mm inlet drop became unknown in the reopened pipe calculation. With both pit outlets held at RL 5.00, the reopened calculation instead worked out −100 mm. The drawing still held 50 mm.  
   `bench/CeCivil.Bench.Core/PipeToolWindow.cs:40` · `src/CeCivil.Hands/Pipe/PipeTool.cs:195` · D-084, D-086, D-141 · **wrong figure** · survived. [Pipe, line 106](../disproved_deep_src_CeCivil_Hands_Pipe_PipeTool_cs.md#L106)

23. **A failed cover or connection check can misstate the shortfall.** At 294 mm against 300 mm, the 5 mm setting correctly gave “Wrong” but reported “Short by 0.01”. At zero tolerance, 0.4 mm short read “Short by 0 mm”. At the legal point, RL 4.944 against RL 4.950 failed without saying “6 mm short”.  
   `src/CeCivil.Brain/data/checks.csv:37` · `src/CeCivil.Brain/data/checks.csv:55` · D-280, D-321 · **wrong figure** · survived. [Checks, line 27](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L27) · [Checks, line 30](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L30)

24. **A calculated steep grade can disappear.** A 0.40 m run falling 1.00 m gives 1 in 0.40. The worked grade rounded to zero, was refused, and produced no grade-range result. Typing the same positive grade gave the intended amber “Needs a look”.  
   `src/CeCivil.Brain/data/facts.csv:17` · `src/CeCivil.Brain/Facts/Fact.cs:247` · D-276, D-321 · **wrong figure** · survived. [Calculation rules, line 6](../disproved_deep_src_CeCivil_Brain_Things_Library_cs.md#L6)

25. **A fractional grade limit is compared at a different precision from the pipe.** Against a held limit of 1 in 199.996, a pipe at 1 in 200.001 got “Needs a look”. Both are 1 in 200.00 at two places. The supplied whole-number office limits do not expose this error.  
   `src/CeCivil.Brain/data/checks.csv:26` · `src/CeCivil.Brain/data/checks.csv:28` · D-321 · **wrong figure** · survived. [Checks, line 36](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L36)

26. **The outlet sketch warns inside tolerance and can warn with a level missing.** A 4 mm difference stayed amber at both 1 mm and 5 mm tolerance. When an outlet level was missing, the sketch compared the arrival with RL 0.00 and could still paint a warning.  
   `src/CeCivil.Window/Parts/PreviewPane.cs:292` · D-219, D-318, D-321 · **screen rule** · survived. [Drawing preview, line 16](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md#L16)

27. **Held levels can produce an “Out by 0.00” clash.** RL 5.804 less RL 5.300 equals the held 0.504 m depth. The engine compared that depth with 0.50 m and reported “Out by 0.00”. That can send a drafter looking for a level error in three figures that agree. A separate joined-pipe example, not yet disproved, gave the same message for a genuine 4 mm difference inside the 5 mm setting.  
   `src/CeCivil.Brain/Sums/Solver.cs:162` · `src/CeCivil.Brain/Things/Stretch.cs:50` · D-125, D-321 · **wrong figure** · survived. [Network, line 16](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md#L16) · [Levels review, line 22](../rulings_LONG_SECTION.md#L22)

28. **The cover check can be missing from the joined pit.** Pipe offers the cover check, but the Pit window’s checks omit cover on its joined pipe. Opening the pit where cover is short therefore need not show the required red warning.  
   `bench/CeCivil.Bench.Core/windows/pit.csv:59` · D-140, D-338 · **ruling not built** · not yet disproved. [Levels and standards, line 40](../rulings_LEVELS_AND_STANDARDS.md#L40)

29. **A run’s cover warning gives no way to compare remedies.** On a run 40 mm short, the release window does not say how much cover could be recovered by flattening the grade, reducing a pit drop or lowering the connection. Those choices matter when a level is fixed.  
   `bench/CeCivil.Bench.Core/windows/pipe.csv:64` · D-280 · **ruling not built** · not yet disproved. [Levels and standards, line 100](../rulings_LEVELS_AND_STANDARDS.md#L100) · [Levels review, line 30](../rulings_LONG_SECTION.md#L30)

30. **A walkers-only paving preset has no separate check for a higher minimum.** The preset offers 75 mm for a paved footpath. The project’s reference review records 100 mm for plastic pipe under untrafficked brick or unreinforced pavement. It found no separate floor for that construction. Whether the first job uses that pavement is open.  
   `src/CeCivil.Brain/data/tables/over_it_list.csv:14` · `src/CeCivil.Brain/Things/Standards.cs:177` · D-144, D-287 · **ruling not built** · not yet disproved. [Levels and standards, line 8](../rulings_LEVELS_AND_STANDARDS.md#L8)

31. **Pipe cannot use a council’s stated cover measurement point.** The paved calculation always deducts the slab. Where the council explicitly specifies finished surface, 350 mm to the crown under a 125 mm slab is assessed as 225 mm. The default measurement point for the office’s new 300 mm preset is a separate open question.  
   `src/CeCivil.Brain/data/sums.csv:12` · `src/CeCivil.Brain/data/tables/job_slab.csv:10` · D-144, D-146, D-330 · **ruling not built** · not yet disproved. [Levels and standards, line 32](../rulings_LEVELS_AND_STANDARDS.md#L32) · [Part 3 test plan, line 86](../testplan_p3.md#L86)

32. **A pipe check can lose its location on screen.** The drawing-backed window opened the pipe between P6 and P7 but painted its cover levels under P4 and P3. The correct figures appeared beside the wrong pits.  
   `src/CeCivil.Window/Parts/PreviewPane.cs:307` · D-064, D-125, D-280 · **screen rule** · survived. [Drawing preview, line 10](../disproved_deep_src_CeCivil_Window_Parts_PreviewPane_cs.md#L10)

33. **The bench can describe an assumed paving thickness as supplied by the engineer.** The populated example recorded 125 mm and 150 mm as taken from the plans. A separately supplied 100 mm assumed slab was labelled “given”. The first-drawing example cleared the sample figures. The evidence concerns the source shown in the bench example.  
   `bench/CeCivil.Bench.Core/windows/jobsettings.csv:28` · `src/CeCivil.Window/Parts/Std/StdJob.cs:246` · D-086, D-191, D-293 · **screen rule** · survived. [Network, line 30](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md#L30) · [Job window, line 21](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L21)

34. **The Pipe window can name the wrong pits below a clash warning.** On a P6–P7 pipe, the red headline can name the actual ends while the supporting list still names the example stretch P4–P3. A drafter following the list could investigate the wrong pits.  
   `bench/CeCivil.Bench.Core/WindowModel.cs:1879` · `bench/CeCivil.Bench.Core/PipeToolWindow.cs:68` · D-125 · **screen rule** · not yet disproved. [Levels review, line 24](../rulings_LONG_SECTION.md#L24)

35. **The thickness shown can hide the half millimetre that decides cover.** Job displayed 100 mm for both 100 mm and 100.5 mm of paving. With the same pipe and 5 mm tolerance, one thickness gave “Suits” and the other “Wrong”. The check used the stored thickness correctly.  
   `bench/CeCivil.Bench.Core/JobSettings.cs:42` · D-293, D-318, D-321 · **screen rule** · survived. [Job window, line 23](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L23)

36. **The cover summary can ask for attention before it has a figure.** With a missing cover requirement, the detailed row was correctly grey and said “Cannot check yet”. The answer band and downstream invert were amber and said “Needs a look”, giving the drafter a different verdict for the same pipe.  
   `src/CeCivil.Window/Parts/Std/StdSteps.cs:540` · D-219 · **screen rule** · survived. [Window working, line 20](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md#L20)

37. **The cover arrow and the drawn slope can mislead.** A 350 mm end-cover label pointed to a place with about 368 mm. On the 8 m slope sketch, 200 mm and 800 mm of fall drew the same line. Supplying a flat or rising line directly still drew a downhill slope. Changing only the level datum also changed the apparent width of the same 150 mm pipe.  
   `src/CeCivil.Window/Parts/Std/StdPictures.cs:165` · `src/CeCivil.Window/Parts/Std/StdPictures.cs:195` · D-064, D-313 · **screen rule** · survived. [Pipe sketches, line 20](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md#L20) · [Pipe sketches, line 18](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md#L18) · [Pipe sketches, line 19](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md#L19)

38. **The displayed pipe working can give a false equation.** The bench displayed 5.28 − 0.09 = 5.194, a 4 mm error. Separately, when directly given an inconsistent division, its correction returned 8.00 m of fall for 8.00 ÷ 100. The correct fall is 0.08 m. Test calculations with a missing or zero divisor also passed the display checker.  
   `src/CeCivil.Window/Parts/Std/StdSteps.cs:953` · `src/CeCivil.Window/Parts/Std/StdSteps.cs:1015` · D-219, D-295 · **wrong figure** · survived. [Window working, line 12](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md#L12) · [Window working, line 14](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md#L14) · [Window working, line 16](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md#L16)

39. **An edit can change cover without appearing in the change list.** A change from 396 to 397 mm was absent because both covers displayed as 0.40 m. Confirming the same 150 mm slab also changed cover from assumed to confirmed without an entry.  
   `src/CeCivil.Brain/Things/Network.cs:402` · D-086, D-176, D-177 · **screen rule** · survived. [Network, line 40](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md#L40)

40. **The engine can use a tolerance different from the one it shows.** The ordinary job setting refused 2.5 mm. Changing the already-saved value directly made Pipe use 2.5 mm and show 3 mm. In another direct call, explicitly selecting the office tables replaced a job tolerance of 0 mm with 5 mm and lost its 150 mm slab. The ordinary window update does not request that substitution.  
   `src/CeCivil.Brain/Things/Network.cs:121` · D-321 · **wrong figure** · survived. [Network, line 50](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md#L50) · [Network, line 54](../disproved_deep_src_CeCivil_Brain_Things_Network_cs.md#L54)

41. **A missing office rule can turn a 100 mm cover shortage into “Suits”.** The unaltered data correctly failed 350 mm against 450 mm under unpaved traffic. Removing the larger-minimum rule, adding a differently capitalised duplicate or making only the office figure unknown let a 250 mm council figure govern. The same pipe then passed despite the known 450 mm minimum.  
   `src/CeCivil.Brain/Things/Standards.cs:177` · `src/CeCivil.Brain/Things/Standards.cs:465` · D-022, D-144, D-330 · **wrong figure** · survived. [Standards, line 11](../disproved_deep_src_CeCivil_Brain_Things_Standards_cs.md#L11) · [Standards, line 12](../disproved_deep_src_CeCivil_Brain_Things_Standards_cs.md#L12) · [Standards, line 14](../disproved_deep_src_CeCivil_Brain_Things_Standards_cs.md#L14)

42. **An unrecognised crossing or an unsourced council row can set the cover.** With altered tables, a crossing defined only for one council triggered another council’s general 250 mm rule. Separately, 650 mm governed even though the added council row had no source or status. These examples used made-up test rows outside the normal menu.  
   `src/CeCivil.Brain/Things/Standards.cs:117` · `src/CeCivil.Brain/Things/Standards.cs:407` · D-022, D-096, D-287 · **wrong figure** · survived. [Standards, line 15](../disproved_deep_src_CeCivil_Brain_Things_Standards_cs.md#L15) · [Standards, line 16](../disproved_deep_src_CeCivil_Brain_Things_Standards_cs.md#L16)

43. **A damaged grade table or a formula using the wrong units can still load.** Writing the 300 mm diameter as `3OO` (two letter Os) selected 1 in 300 instead of 1 in 250. In altered formulas, using a 10 m length as diameter selected 1 in 200, and copying a 150 mm diameter into cover gave 150 m. The supplied formulas and diameter table were correct.  
   `src/CeCivil.Brain/Things/Standards.cs:371` · `src/CeCivil.Brain/Things/Standards.cs:436` · `src/CeCivil.Brain/Things/Library.cs:217` · D-134, D-146, D-338 · **wrong figure** · survived. [Standards, line 13](../disproved_deep_src_CeCivil_Brain_Things_Standards_cs.md#L13) · [Standards, line 17](../disproved_deep_src_CeCivil_Brain_Things_Standards_cs.md#L17) · [Calculation rules, line 16](../disproved_deep_src_CeCivil_Brain_Things_Library_cs.md#L16)

44. **A damaged check list can hide cover checks or pass a refused input.** Removing just the cover rules left a joined pipe with zero cover results and 12 other answers. In another incomplete copy, −5 mm tolerance was “Wrong” but its cover said “Suits”. The complete data refused the dependent check.  
   `src/CeCivil.Brain/Things/Library.cs:72` · `src/CeCivil.Brain/Things/Checks.cs:162` · D-219, D-288, D-338 · **wrong figure** · survived. [Calculation rules, line 12](../disproved_deep_src_CeCivil_Brain_Things_Library_cs.md#L12) · [Checks, line 44](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L44)

45. **A newly written rule can return “Suits” on a calculation it refused.** A test rule accepted a division by zero in its answer and printed “Suits: Fall Not known m.” Another rule rejected −5 mm tolerance in its final condition but left the dependent check green. These were altered rules. The supplied tolerance rule names the bad input explicitly.  
   `src/CeCivil.Brain/Things/Checks.cs:301` · `src/CeCivil.Brain/Things/Checks.cs:389` · D-219, D-288 · **wrong figure** · survived. [Checks, line 46](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L46) · [Checks, line 48](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L48)

46. **Permanent tests require a false cover pass and a missing tolerance control.** One bench test requires an absent tolerance box, and a style test rejects a labelled working control. A separate regression test demands “Suits” for 296.67 mm against 300 mm at zero tolerance when the invert is worked out. A fix would fail those assertions.  
   `tests/CeCivil.Brain.Tests/SweepTwoTests.cs:82` · `bench/CeCivil.Bench/StyleCheckJobUnfinished.cs:53` · `bench/CeCivil.Bench.Tests/JobAndUnfinishedWindowTests.cs:148` · D-318, D-321 · **missing test** · survived. [Calculation rules, line 24](../disproved_deep_src_CeCivil_Brain_Things_Library_cs.md#L24) · [Job window, line 36](../disproved_deep_src_CeCivil_Window_Parts_Std_StdJob_cs.md#L36)

47. **Individual tests can pass when end checks vanish or disagree.** Removing all cover or uphill answers still satisfied “all suit”. Two lists of 49 answers passed a count comparison despite 36 differing outcomes. A zero-tolerance assertion also accepted “Cannot check yet”. Other tests protect particular rows and the basic zero-tolerance case.  
   `tests/CeCivil.Brain.Tests/ChecksTests.cs:323` · `tests/CeCivil.Brain.Tests/ChecksTests.cs:923` · `tests/CeCivil.Brain.Tests/ToleranceTests.cs:239` · D-125, D-140, D-311, D-321, D-338 · **missing test** · survived. [Checks, line 52](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L52) · [Checks, line 54](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L54) · [Checks, line 56](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L56)

48. **Individual standards tests miss a stale council or a fixed cover figure.** The council-clear test ends with 450 mm under either council choice. The fixed-figure scan misses a literal such as 4_50, and the source test accepts an empty preset list. Other tests check the full list and use changed data. The supplied figures passed.  
   `tests/CeCivil.Brain.Tests/StandardsTests.cs:205` · `tests/CeCivil.Brain.Tests/StandardsTests.cs:806` · `tests/CeCivil.Brain.Tests/OverItListTests.cs:125` · D-022, D-133, D-144, D-287, D-330 · **missing test** · survived. [Standards, line 28](../disproved_deep_src_CeCivil_Brain_Things_Standards_cs.md#L28) · [Standards, line 29](../disproved_deep_src_CeCivil_Brain_Things_Standards_cs.md#L29) · [Standards, line 26](../disproved_deep_src_CeCivil_Brain_Things_Standards_cs.md#L26)

49. **The window tests can pass without checking the pipe figure where the drafter reads it.** Swapping the two displayed invert values satisfied the word searches. The sketch check counted drawings without testing the cover shown, and the list test could pass without selecting and reading back the Pipe grade. A printed-sum test also reused the window’s rounding check.  
   `bench/CeCivil.Bench/StyleCheck.cs:628` · `bench/CeCivil.Bench/StyleCheck.cs:658` · `bench/CeCivil.Bench/UiaCheck.cs:84` · `bench/CeCivil.Bench/StyleCheckTankSchedule.cs:93` · D-064, D-079, D-286, D-295 · **missing test** · survived. [Window working, line 34](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md#L34) · [Pipe sketches, line 36](../disproved_deep_src_CeCivil_Window_Parts_Std_StdPictures_cs.md#L36) · [Input fields, line 30](../disproved_deep_src_CeCivil_Window_Parts_Std_StdInput_cs.md#L30) · [Window working, line 32](../disproved_deep_src_CeCivil_Window_Parts_Std_StdSteps_cs.md#L32)

50. **The Part 3 drawing cases still lack a recorded AutoCAD pass.** The Part 3 plan records zero AutoCAD cases run and says its named test objects had not been verified in a supplied drawing. The open cases include the 5 mm and 6 mm boundaries, cover at a bend using the outside diameter, a changed job tolerance, and the result after saving and reopening.  
   `findings/testplan_p3.md:254` · `sweep_gate/FINDINGS.md:30` · D-146, D-318, D-321, D-338 · **missing test** · not yet disproved. [Part 3 test plan, line 254](../testplan_p3.md#L254) · [Part 3 test plan, line 10](../testplan_p3.md#L10) · [Release gate review, line 30](../../sweep_gate/FINDINGS.md#L30)

---

**Engineering questions kept open.** The evidence does not settle whether a lower council figure can replace the 300 mm office driveway preset, the default measurement point for that preset, or whether a 19 mm pit drop needs an advisory against the 20 mm preset. The 300 mm entries for ramps and hardstands are recorded as an extension awaiting a ruling. None of those choices is counted as a fault. [Driveway rulings](../disproved_rulings_D298_D344.md#L36) · [Measurement point](../testplan_p3.md#L86) · [Pit drop](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L40) · [Ramp and hardstand](../rulings_LEVELS_AND_STANDARDS.md#L88)

**Review record.** Read 114 files, including 32 named disprove passes, across `findings`, the five sweep folders and the five top-level deep reviews. The code references are for local main `2ce8070`. The earlier 246 mm against 250 mm example is a valid pass at 5 mm. The original Checks review’s 64 reported tests were excluded following its file-handling breach. Its separate disprove pass reproduced the 8.33 mm error. [Second sweep](../../sweep_2/FINDINGS.md#L14) · [Checks disprove pass](../disproved_deep_src_CeCivil_Brain_Things_Checks_cs.md#L60)

**This audit.** Product tests run 0. AutoCAD sessions 0. Only this report was written. The release counts come from the board. The brief specifies Codex model `gpt-6.2-astra`.
