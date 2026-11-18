# Board, revision 2 (DRAFT for the planning chat to check; not yet the board)

**Date:** Wed 18 Nov 2026, evening (Melbourne time). Built from `BOARD.md` revision 1 (sections 1 to 11) plus all 79 dated items of its section 12, `DIRECTOR_SUMMARY.md` (6:00 pm) and `DECISIONS.md` D-238 to D-297. Highest decision D-297. Nothing here is a ruling; where the board does not say an item is closed, it is listed open. Planning-chat calls (not Tim's words) are marked as such.

**Counts (open now, and closed since revision 1):**

1. **Waiting on Tim (W-):** 45 open (28 old IDs plus 17 new, W-044 to W-060). 14 closed since revision 1.
2. **Owed by the chats (O-):** 33 open (17 old plus 16 new, O-022 to O-037). 4 closed since revision 1.
3. **Problems (N-):** 38 open (26 old plus 12 new, N-057 to N-068; N-048 is kept open and merged into N-001, not counted twice). 29 closed since revision 1 (N-002, N-027, N-029 to N-056 except N-048). Two IDs, N-032 and N-033, were used twice (see "Not sure").
4. **Unproven (U-):** 38 open (28 old plus 10 new, U-031 to U-040). 2 numbered ones closed (U-006, U-030) and 3 unnumbered trial items closed.
5. **Parked (K-):** 25 (K-001 to K-025) plus the idea ID-019.

**Installed: 0. Accepted by Tim: 0.** Last AutoCAD pass: pass 7, 102 checks, 98 pass, 2 fail, 2 not tested; speed 13 of 13. Today's function batch A and the 18 risk-list fixes after pass 7 are not run in AutoCAD yet.

---

## 1. WAITING ON TIM

"One click" = a clickable choice is enough. "At the PC" = he must do it on his machine. "Document" = he must supply a paper or file. Times are approximate where the board gave none.

### First thing in the morning (he asked for the preview options; the planning chat owes the rest)

1. **W-057 Retire the old desk robot.** Ask: yes to stop three old scripts (`acad_watchdog.ps1`, `chain_robot_standing.ps1`, `disk_guard.ps1`), remove the stale away flag of 29 Oct, and make sure the old janitor script cannot be relaunched. Why: if the old queue were ever refilled it could start AutoCAD in his working hours. Nothing has been touched. Detail: BOARD section 12 item 76. Since: 18 Nov, about 6:50 pm. Needs: one click.
2. **W-053 His "q" alias.** Ask: put it back or leave it removed. Why: the planning chat removed eleven aliases including q on his D-250 answer, but D-208 says he keeps his own Q. Putting it back is one line from the dated copy. Detail: item 68, D-208, D-250. Since: 18 Nov, about 5:50 pm. Needs: one click.
3. **W-051 Preview: option A, B or C.** Ask: pick how the preview panel works (A as approved, a quarter of the window; B half the window; C no preview inside, window docked beside the real drawing). Test result for C: view remembered, zoom to the set, temporary outlines and tags, and keeps working with a floating window all proven on a 2,500-object drawing in 10 thousandths of a second. The catch: any view change makes AutoCAD ask "Save changes?" at close, as after a plain zoom; docking at the right is not proven (it stayed floating). Detail: `pictures\preview_options.html`, items 66 and 74, D-297, R-012. Since: 18 Nov, 5:30 pm. Needs: one click.
4. **W-055 Pipe labels in tight spaces.** Ask: which of four ways (full label; two-line stack; short form; one standing note with labels only on the exceptions, recommended). Detail: `pictures\pipe_label_tight_spaces.html`, items 67 and 69, D-268. Since: 18 Nov, about 5:50 pm. Needs: one click.
5. **W-049 The "_pedit, *Cancel*" flash on double-click.** Ask: is the brief line in the command history each time acceptable. Detail: item 64, trials chat R-011. Since: 18 Nov, 5:38 pm. Needs: one click.
6. **W-056 Detention pipe cover under a driveway.** Ask: D-145 (the larger, 0.45 cover) or D-287's presets (detention pipe keeps 300 everywhere). Detail: item 71, D-145, D-287. Since: 18 Nov evening. Needs: one click.
7. **W-058 How the end of a system is drawn.** Ask: confirm council pit = PIT BLOCK 3 on the EXISTING DRAIN layer tagged "ExP" (existing) or "SEP" (new side entry pit); kerb = pipe ends on the kerb line with the office connection note, no symbol; council pipe or easement = pipe ends on the existing drain line. Why: no kerb symbol and no existing-pit block exist in the blocks review. Detail: item 77, D-275, `design\BLOCKS_REVIEW.md`. Since: 18 Nov, 6:50 pm. Needs: one click.
8. **W-052 PT opening at 450 x 450 against "last used".** Ask: confirm the typed name sets the size (PT 450, PP 350) while kind, lid and the rest open with last used (planning chat's reading). Detail: item 68, D-235, D-263. Since: 18 Nov, about 5:50 pm. Needs: one click.
9. **W-050 Does a printed schedule mark a depth worked from a level below 0.00.** Ask: yes or no. Note: D-288 (planning chat's call, DQ-098) already makes such a level amber "check the datum" everywhere including the schedule; his word not given. Detail: item 65, D-288. Since: 18 Nov, 5:37 pm. Needs: one click.
10. **W-054 One re-use figure shared between two tanks.** Ask: how one typed re-use figure is shared when a job has two tanks (D-285 says each tank holds its own detention). Detail: item 68, D-278, D-285. Since: 18 Nov, about 5:50 pm. Needs: one click.
11. **W-046 Existing civil text when DIMSCALE changes.** Ask: does existing civil text resize (new text follows DIMSCALE, D-210 dimensions do, hatches keep their scale, TA-110). Source: your brief; not recorded in BOARD.md (check `interview_tools\TEXT_SPEC.md`). Since: 18 Nov. Needs: one click.
12. **W-059 The typed EXPLODE check.** Ask: run EXPLODE on a pipe at the PC while a supervised check watches, to learn what typed EXPLODE does to the hidden note. Detail: N-001, `EXPLODE_GAP.md`, item 17. Since: 17 Nov. Needs: at the PC.

### Blocks building now

13. **W-002 Council minimum runoff figures.** Ask: confirm Darebin 0.80, Maribyrnong 0.75, Boroondara 0.65, each with the council's document. Detail: OQ-05, R-008, D-282 (DQ-082 says a council with no figure on file shows one grey line). Since: 18 Nov. Needs: a document for two councils; one click for Darebin.

### Needed before a named tool

14. **W-004 Inspection opening: how long a run.** Ask: the figure or the AS 3500.3 clause. Detail: D-081, R-002 L. Since: 16 Nov. Needs: document. Before: Pipe tool accepted.
15. **W-008 Which inlet symbols.** Ask: the "... DYNAMIC WITH MASK" set or the plain floor waste and machine-named downpipe. Detail: BLOCKS_REVIEW decision 2. Since: 18 Nov. Needs: one click. Before: Inlets tool.
16. **W-009 How FO and OF are drawn (tank sizes now settled).** Ask: show how FO and OF are drawn. The tank size list is settled by D-282 (office tank blocks, planning chat's call). Detail: THE_PLAN 7.4, D-059. Since: 16 Nov. Needs: document. Before: Tank tool.
17. **W-010 Two design questions on a part-drawn job.** Ask: how the top water level is first chosen; whether the orifice pit is always the last pit before the council connection. (The re-use question is settled by D-278.) Detail: INPUT_AUDIT 2 and 4, D-175, O-004. Since: 16 Nov. Needs: one click each, brought by the planning chat. Before: Detention tool.
18. **W-012 Pipe capacity on bigger jobs.** Ask: what the office does when detention or a bigger site needs pipe capacity checked. Detail: Q-002. Since: 16 Nov. Needs: at the PC or a document. Before: Detention tool.
19. **W-014 Boyd's or OSD4W, and OSD4W inputs.** Ask: who confirms the method with council, and where the OSD4W rainfall zone and times come from. Detail: Q-006, THE_PLAN 7.3. Since: 16 Nov. Needs: document. Before: Detention tool.
20. **W-060 Plain names for the two detention methods.** Ask: plain words for the two methods in the Detention window. Source: your brief; not recorded in BOARD.md. Since: 18 Nov. Needs: one click. Before: Detention tool.
21. **W-015 Detention pipe look (narrowed).** Ask: the printed pen width and the legend wording; look at colour 160 on screen and on a real plot. (Label wording settled by D-268.) Detail: D-153, D-156, U-015. Since: 17 Nov. Needs: at the PC (one real plot).
22. **W-017 What form cover-level help takes.** Ask: click two trusted levels, click one and type a fall, or both. Detail: D-195, D-178. Since: 18 Nov. Needs: one click. Before: any cover-level helper.
23. **W-018 Your alias Bl (narrowed).** Ask: move Bl so BL is BREAKLINE. (Wall-t, WT is now Tank, was handled by D-250.) Detail: D-170, TA-023. Since: 18 Nov. Needs: at the PC. Before: break line tool.
24. **W-019 Typed names still to pick (narrowed).** Ask: full words for FO and GIO; names for the AG drain, perimeter drain and Job window; names for the shared tools ST-11 to ST-18. Settled since: LEGALPOINT / LPD (D-274), SCH, TG (D-233), MANAGER / MG, OFFICETEXT / OT, OFFICEHATCH / OH, joints CJ / SSC / AJ / JS. Detail: NAMING_DRAFT, interview file 8a, O-009. Since: 16 Nov. Needs: one click per batch.
25. **W-020 Base scales for the hatch tool.** Ask: confirm each office hatch's base scale at DIMSCALE 100. Detail: D-227, TA-058, TA-061, `OFFICEHATCH_SPEC.md`. Since: 18 Nov. Needs: one click. Before: OH.
26. **W-047 Legend wording for joints and hatches, and the AJ layer.** Ask: legend wording per joint (CJ, SC, AJ) and for hatches where no old-job legend exists; the layer name and colour for AJ. Detail: item 58, item 44, `JOINTS_SPEC.md`, `OFFICEHATCH_SPEC.md`. Since: 18 Nov, about 5:25 pm. Needs: one click. Before: joints window and OH.
27. **W-045 Default pen for each text size.** Ask: the default pen for each of 1.8, 2.0, 2.5, 3.0, 3.5, 5.0 and 7.0 mm text (the number in a text layer's name is the pen). Detail: item 56, `TEXT_SPEC.md`. Since: 18 Nov, about 5:10 pm. Needs: one click. Before: OT.
28. **W-048 The 189-layer list when it arrives.** Ask: settle the overlaps in the master drawing's 189 layers sorted by function; say where the consultant match list lives (office IT folder assumed, DRAFT). Detail: item 61, `OFFICELAYER_SPEC.md`, O-035. Since: 18 Nov, about 5:30 pm. Needs: one click per batch, after the list lands. Before: OL.
29. **W-022 Buttons on the three ribbon tabs.** Ask: which buttons sit on CE Civil, CE Tools and the light tab. Detail: D-200, D-208, `pictures\whole_plugin_few_tools.html` (ribbon in job order: Set up, Draw, Design, Sheet and check; he is marking it up, O-021). Since: 16 Nov. Needs: one click per tab. Before: ribbon.
30. **W-024 An office layer already in the drawing with another colour.** Ask: leave it and say once with a one-click fix (recommended), or set it to the list. Note: D-260 (planning chat's call, DQ-005) already says an existing layer is never changed (D-191). Detail: OQ-07. Since: 18 Nov. Needs: one click.
31. **W-025 Test the new plug-in beside your old ones.** Ask: yes to a night session with old and new loaded together on test copies. Detail: OQ-10, U-008. Since: 18 Nov. Needs: one click. Before: colleagues.
32. **W-039 Two pairs of rulings that pull against each other (narrowed).** (a) a new pipe opening with last used (D-060) against 1 in 100 and 100 dia (D-143, D-174), which D-263 appears to settle (the board does not say so); (b) whole-job facts in a CE side panel (D-048) against a Job window (D-099, D-171). The third pair (tank re-use) is closed by D-278. Detail: `rulings\INDEX.md`. Since: 18 Nov. Needs: one click each, with a part-drawn job as the example.
33. **W-043 How our facts are shown and edited for a selected object.** Ask comes after a night proof. Recommended order (build chat): (1) a size change by grip lands in our note (done in round 39); (2) facts as rows in AutoCAD's Properties palette through one small native helper file; (3) LIST output and a right-click "CE: edit"; (4) Quick Properties and a CE palette only on his yes (each saves into his profile); (5) no double-click change unless asked. Detail: `C:\CE_CIVIL\acad\PROPERTIES_OPTIONS.md`, item 24, U-001, D-241, O-020. Since: 18 Nov. Needs: one click, after the proof.
34. **W-044 The CN time limit on a big job.** Ask: how long CN may run before it says so. Not ruled; belongs in `stage6\PERFORMANCE.md` (O-024). Detail: item 23. Since: 18 Nov. Needs: one click. Before: CLEAN built.

### Can wait

35. **W-027 Which numbering option is offered first** when a pit is added after issue (next free, a letter, renumber all). Detail: D-184. Since: 18 Nov. One click.
36. **W-028 Laptop screen sizes.** Which laptops draft, their resolution and scaling (built for 1920 x 1080 at 125 percent meanwhile). Detail: D-193, SITUATIONS 17. Since: 18 Nov. At the PC.
37. **W-029 Monash step irons wording.** The council's own wording for step irons deeper than 0.9 m (left blank). Detail: D-148. Since: 17 Nov. Document.
38. **W-030 Freeze the old bug list.** Approve the five steps of the old bug-list sweep. Detail: R-007 section 5, D-206. Since: 18 Nov. One click.
39. **W-032 Hatch fault checks.** Two-minute read-only checks on his hatch (Associative line, six variable values, a blank drawing test). R-011 found our code was not the cause in its test, so still probably plain AutoCAD. Detail: R-006 A3, D-199. Since: 18 Nov. At the PC.
40. **W-033 Leftovers of the first trial run (narrowed).** Delete the ZeroTrial profile and the isolate folder (his to do; rule 1.9). SECURELOAD is settled: stays 0 (D-255). Detail: D-111, P-08. Since: 16 Nov. At the PC.
41. **W-034 Disk clean-up leftovers.** Say which may go: install backups and rollback archive (14.1 GB), Codex data (36.6 GB), mail archive in use out of OneDrive (18.9 GB), hibernation file (25.5 GB), CERef (11 GB), Team transcripts, a local AI model, auto-saves. Detail: clean-up `SURVEY.md`. Since: 18 Nov. One click each.
42. **W-035 Client details in local study copies.** Clean the old job details inside evidence and workbooks, and delete study copies now or when planning ends. Detail: P-06, P-07. Since: 16 Nov. One click.
43. **W-036 Questions for the later kinds.** Pump workbook version, raingarden area, mark-up contents, checks before council issue, fresh discharge letters, as-built duty, other civil site drawings, driveway and ramp grades, soakage storm, industrial stub. Detail: `OPEN_QUESTIONS.md` Q-003, Q-005, Q-007 to Q-014. Since: 16 Nov. One click each, when the kind is designed.
44. **W-037 Where is the drawing that showed nothing without the plug-in.** File location for the no-plug-in test case. Detail: P-04, D-015. Since: 16 Nov. Needs a file.
45. **W-038 Which real job to carry through.** Pick the finished house or two-unit job to run blank-to-issue, and the time. Detail: THE_PLAN stage E, LOOPS 3. Since: 16 Nov. One click, then his time.
End of the waiting list: 45 open items (the numbered lines above).

---

## 2. OWED (O-), open only, by chat

### Planning chat

1. **O-002 The rulings pages, 23 fixes (narrowed).** Pages run to D-297 (26 pages, new `SCREENS_AND_STYLE`); a second reader (Opus) found them sound with fixes; 23 exact fixes were sent back; not shown applied. Since 18 Nov.
2. **O-004 The part-drawn-job design questions** (delivers W-010). Since 18 Nov.
3. **O-005 The concept gap check's 52 owner decisions,** reconciled against D-075 to D-114 and D-133 to D-136; bring only the unanswered. Since 16 Nov.
4. **O-006 An answer to the ten gaps of the concept gap check** (sheet set-up, viewport colours, fixed frame, slabs, second sheet, title strip). Since 16 Nov.
5. **O-007 The 18 general rules of SITUATIONS put to him** one by one. Since 18 Nov.
6. **O-008 Plain explanation of the obstacle course.** Since 18 Nov (D-216).
7. **O-010 Read the Job Manager's own plan** and design how the plug-in hands it job facts. Since 16 Nov.
8. **O-011 How he moves from the old plug-in to the new (narrowed).** D-258 settles PIT and CD; the rest (side by side, old names gone) is open. Since 18 Nov.
9. **O-012 Bring stale documents into line** with each decision (RULES 9.7). Standing.
10. **O-013 File D-138 to D-297 into the reference library.** It stops at D-137. Since 17 Nov.
11. **O-017 The easiest, most AutoCAD-like way to use the plug-in** from old-job evidence (D-230; `design\EASY_AND_AUTOCAD_LIKE.md`, being written). Since 18 Nov.
12. **O-018 Re-score the obstacle course (narrowed).** The director's summary was refreshed at 6:00 pm; the score (3 of 108) predates pass 2 and has not been redone. Since 18 Nov.
13. **O-021 The drafter's picture of the whole plug-in (delivered as a draft; open until he has marked it up).** `pictures\whole_plugin_few_tools.html` and the artifact "CE Civil Final Program" (D-246, D-281); 11 civil windows and one Unfinished list. Since 18 Nov.
14. **O-022 Bring `rulings\` names page, THE_PLAN section 3 and the joints names into line** with D-274 (Outlet and LPD are one tool) and the joints settled in `JOINTS_SPEC.md`. Since 18 Nov.
15. **O-023 Add Tim's two extra rules to every screen-audit brief** (inputs boxed and grouped first, worked-out figures plain, a stated reading order with a one-line why), and give each other window a separate checker's look in the approved style (D-295). Since 18 Nov.
16. **O-024 Put the CN time limit into `stage6\PERFORMANCE.md`** once ruled (W-044). Since 18 Nov.
17. **O-025 Put a line in THE_PLAN about the native helper file** once the night proof passes (the "C# only" approach changes). Since 18 Nov.

### Build chat (CE_CIVIL)

18. **O-026 Live on-cursor preview for Pit and Pipe; pipe edge lines that move with the pipe; the "opens with" setting; the small CE memory file.** D-263, D-264, D-266, D-267. Not built, not proven. Since 18 Nov.
19. **O-027 The office's circled pit tag and masked text for levels and labels; PP over CL on two lines; pipe label as masked text with a typed-over wording kept and flagged,** before first real use. D-260, D-290. Since 18 Nov.
20. **O-028 Function batch B:** LPD merge (D-274), pipe-end join to a pit wall (D-270), label follows a moved pipe (D-271), Long section cover-text redo (D-271), copies numbered (D-262), the read-only "which plug-in owns this command" check (D-258), layer-lock tests, and a night check per copy route. Committed? no. Since 18 Nov.
21. **O-029 Run function batch A and batch B in real AutoCAD at night.** Batch A (ea1af65, brain 644, bench 318, hands 512) is not run in AutoCAD. Since 18 Nov.
22. **O-030 Text heights from size times DIMSCALE** for pit numbers, cover levels, pipe labels and invert text (invert text done in batch A, 1.8 mm on 20TEXT; the rest not stated). Item 56. Since 18 Nov.
23. **O-031 Tank sizes from the office tank blocks; each tank holds its own detention; no orifice pick list; no pipe size box in Detention.** D-282, D-285. Since 18 Nov.
24. **O-032 Restyle windows to the approved style, by risk, no rebuilds** (D-295); preview waits for W-051. Since 18 Nov.

### Trials chat

25. **O-033 Preview option C, remaining tests:** docked at the right; a real click on the window's OK and Cancel; a way to show the system without moving the view. Only if he picks C. R-012. Since 18 Nov.
26. **O-034 R-70 checks for every robot that sends to AutoCAD:** refuse if any extra AutoCAD window exists; wait while the PC's last input is under 10 seconds old; confirm exactly one test AutoCAD after a launch; guard against notifications taking the foreground. Items 27 and 70. Since 18 Nov.

### Interview chat

27. **O-009 Names for ST-11 to ST-18 checked in both lists, in one batch.** The board says the interview is 28 of 28 answered; whether this was delivered is not stated. Since 18 Nov.
28. **O-035 The 189-layer list sorted by function from the old jobs** (read-only, coded labels, no AutoCAD; started). Delivers W-048. Since 18 Nov.
29. **O-036 Read the OFFICEHATCH mock-up (and the later windows) against Tim's 31 screen rules through a separate checker.** The mock-up was approved before the rules were pasted. Since 18 Nov.
30. **O-037 Draw the OT window in the approved style** (its look waited for the style, now approved except the preview). Since 18 Nov.

### Clean-up chat

31. **O-015 Pack the plug-in history store in the 2 to 3 pm break.** Result in `LOG.md`. Not mentioned in section 12. Since 18 Nov.
32. **O-016 A note, found in the best way possible, that things must be kept clean in future.** Not mentioned in section 12. Since 18 Nov.

### Raised by Tim, no chat named

33. **O-020 Pictures of the slimmer windows beside the Properties palette (D-241).** Held until the research landed; folds into W-043. Since 18 Nov.

---

## 3. PROBLEMS (N-), open only

Where each stands: **found** (known, no fix); **bench** (fixed on the test bench, not seen in AutoCAD); **AutoCAD** (proven in AutoCAD).

1. **N-001 (with N-048) Exploding a pipe from code loses its hidden note.** Found. The night check golden_explode_pipe still fails in pass 7; what typed EXPLODE does is not known (W-059).
2. **N-003 Detention would use one Kingston job's rainfall everywhere and has no council minimum runoff.** Fix under way by the build chat; the board never says it finished (W-002).
3. **N-004 A pipe cannot be bent** (every pipe is two points; D-237 wants a click between ends to bend). Found, not built.
4. **N-005 Assumed and not-known figures do not print APPROX. and TBC.** Found; part of the sweep N-068; the APPROX. note's reminder is N-059.
5. **N-006 Pipe labels do not follow a move yet** (pit labels do, proven pass 7). Batch B.
6. **N-007 A typed-over pipe label is not kept and flagged** (D-182, D-290: it is just the text's own words). Found.
7. **N-008 Copies and numbering rules:** a copied pit is named "not yet named (copy of P3)", not the next free number (D-262); one series for two systems (D-183), after-issue choices (D-184), retyped tag renames the pit (D-185), next free numbers and assumed levels (D-179). Found; batch B has the next free number. The foundation already gives a copy its own identity at the end of the command, proven for COPY.
8. **N-009 The drawing does not keep the standard values it was designed with** (D-180). Found.
9. **N-010 The tools refuse a drawing in metres** (D-217 says work in both). Found.
10. **N-011 Nothing checks locked layers, xrefs, REFEDIT or paper space.** Found; layer-lock tests are in batch B; hard rule sent to the build chat (a plug-in edit tests the layer lock first).
11. **N-012 No log or fault report exists yet.** Found; waits for the Manager.
12. **N-013 The Pipe tool does not yet draw the flow arrow or the office's edge lines** (invert text is done, batch A). Found; edge lines are O-026.
13. **N-014 Joining to another pipe is not built; a pit dropped on a pipe does not split it** (D-077). Found; pipe-end join to a pit wall is in batch B.
14. **N-015 A stand-in outline cannot be swapped for the office block; "Turned" is not acted on** (D-261 DQ-013; turning is O-026). Found.
15. **N-016 Stretch parameters of PIT BLOCK 3.** Probably read now (placed by data, pass 5 checks 8 of 8) but the board does not say closed.
16. **N-017 A custom grip on an ordinary object crashed AutoCAD.** Cause found and proven: returning the Failure value from a grip click kills AutoCAD in one click. Rule "never return Failure" is in the builder brief; not yet built into the real tools (U-033).
17. **N-018 The self-check does not run when a drawing opens.** Found.
18. **N-019 One undo step for the mover and each tool is unproven.** Proven for a grip drag, flip and slide on test code only.
19. **N-020 Placing many in a row (D-186), the plot line (D-188), "take it up" for a hand-drawn pipe (D-192) and tabs on small screens (D-193) are not built.** Found.
20. **N-021 The long section is not drawn onto the sheet** (D-276: a "Draw on sheet" button inside LONGSECTION, built last). Found.
21. **N-022 The computations sheet has no tool;** CDCALC is the only thing that makes it. Found.
22. **N-023 Small window faults from the fifth tester round** (Inlet preview prints UPVC from its data file; one window name in shared code; the Schedule's red line says 0.00; one dead line). Partly checked.
23. **N-024 Pit window opens with a 450 square preview while the size is unknown; tag and cover text are plain, not the office's masked text** (O-027). Found.
24. **N-025 The golden recordings are "designed, not yet seen"** until a night run re-takes them. The board does not say they were all re-taken.
25. **N-026 The plan has no home for sheet set-up, viewport colour overrides, the fixed frame, slabs or the second sheet** (O-006). Found.
26. **N-028 The agricultural drain card in the concept pages prints an invert text and feeds the schedule, against D-040.** Found (working references only).
27. **N-057 Cleaning xrefs writes other files (CLEAN, when built):** needs a backup, a read-only or in-use check, a report line; cannot be undone with U; touches the native xref protection rule. Found; needs its own obstacle-course check.
28. **N-058 Three stale click scripts not run.** Found (round 39 review).
29. **N-059 The Unfinished reminder for the APPROX. note (D-248) is not built.** Found.
30. **N-060 The council C line pushes card 2 off the window at 1080.** Found (build log entry 40).
31. **N-061 Levels at a grade of 1 in 0 still shows a cover answer.** Found.
32. **N-062 The Pipe clash test looks at the whole drawing.** Found.
33. **N-063 A line said twice in a window.** Found.
34. **N-064 The night check CELEV1 is stale:** it expects a typed-over figure to read "Chosen"; since N-038 it rightly reads "TypedOver". The check is wrong, not the tool. To be corrected next round.
35. **N-065 A robot launch started a second AutoCAD** (blank drawing, closed at once). Found by the trials chat; launchers must confirm exactly one test AutoCAD (O-034).
36. **N-066 Windows notifications steal the foreground from the mouse robot.** Found (item 70, the Codex run was blocked once).
37. **N-067 DIMSCALE 0 or unreadable: a pit gets no tag and only the command line says so** (73 of 218 old drawings are not at 1:100). Should say so in plain words before any install. Batch B, first.
38. **N-068 The "unknown" to "Not known" sweep** (D-286 rule 24: windows say exactly "Not known", the sheet "TBC"). Batch B, first.

---

## 4. UNPROVEN (U-), with what would prove it

1. **U-001 Our facts as rows in AutoCAD's own Properties palette.** The block's own size and kind show natively (pass 5). Our facts need one small native helper file; research says nothing is written to the registry. Proof: a night run, one row "CE cover level" read and written on a pit, gone at shutdown, registry and settings read before and after.
2. **U-002 The ribbon tab and tips on screen, and the rules-file route.** Proof: trial 7 re-run inside AutoCAD.
3. **U-003 Update and rollback from the user folder inside AutoCAD.** Proof: trial 9 on the AutoCAD side.
4. **U-004 The corner site locator inside AutoCAD (D-167).** Proof: a drawn locator in a real window.
5. **U-005 A window painted on screen inside AutoCAD,** including 2560 x 1440, laptops at 125 and 150 percent, dark and light of AutoCAD (OC-17). Proof: an on-screen pass.
6. **U-007 Speed on screen,** for the window, plotting, saving, panning, zooming and the whole load by the clock. Command speeds are met (13 of 13).
7. **U-008 The new plug-in beside your old ones (OQ-10, OC-21).** Proof: W-025's session.
8. **U-009 A drawing with no plug-in in paper space, viewports, xrefs, dynamic blocks** and his own live drawing (trial 3).
9. **U-010 Whether AutoCAD LT keeps and returns third-party notes (R-002).** LT is out of scope (K-017), so low value.
10. **U-011 Interaction with his installed plug-ins,** which were loaded in every full-AutoCAD trial.
11. **U-012 That each typed name is free in AutoCAD 2027** (BREAKLINE as an Express Tools name; REVBOX, CLEAN, ARCDIM and others). PP, SCH, LPD, AG found free; PIT and CD are owned (U-031).
12. **U-013 Sums on a loop of pipes where flow depends on depth (trial 11).**
13. **U-014 The join self-check on hundreds of pits and the real cost of reads.**
14. **U-015 Detention colour 160 on screen and on a real plot (D-156).** Proof: one real plot (W-015).
15. **U-016 The hatch fault's cause** (R-006: plain AutoCAD about 85 percent; R-011's test: our code was called 0 times for plain hatches). Proof: W-032's checks.
16. **U-017 BUG-1095 fixed in the installed old build** (read from code only). He does not use those commands (D-246).
17. **U-018 The bug sort of R-007** (597 would happen again, 256 die, 399 out of scope): never re-checked.
18. **U-019 The no-screen engine:** shares his licence? runs beside an open AutoCAD? writes to his profile? The 16 Nov licence error cause is unknown.
19. **U-020 Office facts taken from the reference and not confirmed** (revision rows, existing drains on EX layers, charged lines, nothing annotative).
20. **U-021 The 16 "still unknown" items of study D.**
21. **U-022 Whether the Structural CLEAN saves** (registry and notes disagree).
22. **U-023 The usage counts behind the function map** are weak evidence.
23. **U-024 The office master drawing's dynamic block states and real-job use of each block.** R-011 found 163 dynamic blocks in the master; the DWG states are not all opened.
24. **U-025 PIT BLOCK 3 behaviours read from memory** (snap to list, Properties hiding, wipeout setting saved per drawing). Pass 5 checks 8 of 8 cover part.
25. **U-026 AS 3500.3:** the inspection opening spacing and whether cover is measured from the underside of pavement. Proof: the standard's printed text.
26. **U-027 What the aliases behind Wall-l, L2ML and others do.** WX, q and the others in D-250 were removed.
27. **U-028 Meaning of HATCH 155, 70, 221 and HATCH-SLAB INFILL.** Answered "Not sure either" (D-232); kept marked unknown.
28. **U-029 The Job Manager's own plan:** not read (O-010).
29. **U-031 D-258: the new tools take PIT and CD while the old plug-in is loaded.** Pass 7's typed probe hung AutoCAD. Proof: the read-only command-owner check (batch B).
30. **U-032 The live preview on the cursor for Pit and Pipe** (D-266, D-267). Proof: a night run once built.
31. **U-033 Grip click, drag, flip, slide, hover menu and double-click takeover inside the real Pit and Pipe tools.** Proven on test code only (R-011); to be rebuilt with a test.
32. **U-034 Preview option C: the window docked at the right, and a real click on its OK and Cancel.** Proof: R-012 follow-up (O-033).
33. **U-035 A copy gets its own identity by Ctrl grip-copy, paste, MIRROR and ARRAY.** Proven for COPY and a pit only. Proof: a night check per route (O-028).
34. **U-036 The approved style's fonts inside AutoCAD windows.** Source: your brief; the board does not state it (D-294 asked for an ordinary figure font). Proof: a window shown inside AutoCAD.
35. **U-037 The approved style at 1080 and 1440, in Lighter, Mid and Dark, over real model space,** and its budgets, undo and motion. Only one ground at one size was checked (item 52). Proof: a checker's pass at each size.
36. **U-038 Function batch A and the risk-list fixes after pass 7 are run in AutoCAD.** Proof: tonight's pass (O-029).
37. **U-039 The short name SH may clash with an AutoCAD shell command** (function plan). Proof: the next AutoCAD pass reads which answers.
38. **U-040 Whether another AutoCAD version or an office-shared alias file holds the aliases D-250 and D-251 removed.** Not checked.
Closed and left out of this list: U-006 (Boyd's by hand, matches the office sheet) and U-030 (our own drawn grips paint on 2027, R-011). 28 old plus 10 new = 38 open.

---

## 5. PARKED (K-), with the slot each waits for

1. **K-001** Structural and structural-only tools. Waits for civil, CE tools and Manager working (D-006).
2. **K-002** Title block and issue; checks between preliminary and council issue. Waits for the first release (D-097).
3. **K-003** "Changed since last issue" list with Mark as issued. Waits for later (D-187).
4. **K-004** Silt pit and soakage pit; council calculators. Waits for later kinds (D-098, D-104; "soak on site" is an end kind now, D-273, sums later).
5. **K-005** Strip drain. Offered, not ticked (D-223).
6. **K-006** Raingarden, slab design, spoon drain, kerb, paved-area and catchment tools, tree zones, spot levels and fall symbols. Wait for the function plan.
7. **K-007** Taking up old drawings. After the first release.
8. **K-008** Imports (another package, LandXML, survey). Later.
9. **K-009** Fuller admin control, a better overall system, joint labels that learn. Later. (Statistics were moved INTO the first release by TA-096; D-205's "later" for them is superseded.)
10. **K-010** Manager pages dropped on purpose (TA-012, TA-013).
11. **K-011** Existing drains "to be removed" other than the council pit. Waits for how the office shows it.
12. **K-012** Cloud engine and a second machine for testing (D-161).
13. **K-013** The no-screen engine; waits for the no-AutoCAD options to run out.
14. **K-014** Background plotting profile (P-03). Blocked by rule 1.9; needs a fresh yes in words.
15. **K-015** The real-job loop. Starts when the first tool passes the night loop.
16. **K-016** Colleagues' release. After one real job by Tim, then 1 to 2 weeks.
17. **K-017** AutoCAD 2022 to 2026 and LT. Out of scope (D-008).
18. **K-018** Plot to PDF, Excel into schedule, north point and scale bar, command search, marks, multileaders and multilines. Revisit only if raised.
19. **K-019** Old test evidence, 54 GB. Waits for the old plan to be fully retired.
20. **K-020** The 399 old bugs outside the first release. Waits for their tools.
21. **K-021** The old ideas inbox sort. Waits for W-030.
22. **K-022** Other structural questions. Waits for structural.
23. **K-023** Before CE_CIVIL is ever shared with anyone else, clean its git history first (login and PC name in two committed result files; Tim: "Leave the history alone", D-231).
24. **K-024** SECURELOAD: look again before colleagues get the plug-in (their PCs at 1 with the CE folder trusted). Stays 0 for now (D-255). Newly issued ID; item 22.
25. **K-025** The September grip failure in the old Civil build: paints nothing, cause unknown; five differences tried in 2027 all paint. Not worth trying inside the old build, which is being replaced (planning chat's call, item 35). Newly issued ID.
26. **ID-019** A searchable details library and job library, "at some point". Parked in `IDEAS.md` (not a K- ID).

---

## 6. CLOSED SINCE REVISION 1 (18 Nov)

### By Tim's rulings

1. **W-003** PIT and CD: new tools take them now, D-258 (proof still U-031).
2. **W-005** Slab thickness: read from the job's plans, set per job, "Not known" until set, D-293.
3. **W-006** The two boxes: one "what is over it" list on pit or pipe, D-287; no pipe size box in Detention, D-285 (planning chat's call).
4. **W-011** Where rainfall comes from: a mix, council figures or the Bureau table, D-249.
5. **W-013** Pervious C: 0.35 Boyd's, 0.30 OSD4W, D-283.
6. **W-016** APPROX. note wording, D-248.
7. **W-021 and TQ-13** Office blocks and names for the 18 palette blocks: D-229, D-232, TA-076.
8. **W-031** Old wrong-figure bugs: "Seen, I will follow that", D-245; he does not use those commands, D-246.
9. **W-040** Function plan ASK items: ASK-1 D-248, ASK-2 D-249, ASK-3 D-252, ASK-4 D-253, ASK-5 D-250.
10. **W-041** Four hatch layers of unknown meaning: "Not sure either", D-232 (stay U-028).
11. **Lid class** house driveway Class C D-242, truck hardstand Class D D-243, one list D-287 (closes O-019).
12. **Grips:** extra grips and research, D-244; pipe ends follow the pit wall, D-256; grated or solid followed everywhere, D-257.
13. **Aliases and SECURELOAD:** eleven aliases removed D-250; Pp removed, PP is plastic pit D-251; SECURELOAD stays 0 D-255 (supersedes D-254).
14. **Pump well:** sums on the pump pit D-247; levels as the newest office sums D-252; orifice pit detail per council D-253.
15. **Build calls:** 104 of 104 closed. His own words: D-258, D-259, D-262 to D-270, D-272 to D-275, D-279, D-280, D-283, D-284, D-293. Planning-chat calls (his to overturn): D-260, D-261, D-271, D-276, D-277, D-278, D-282, D-285, D-288, D-289.
16. **Look and screens:** screen rules D-286; style approved D-295 (preview at the left D-296, but see D-297); grey and rose D-292; changes D-294; mock-up looked at D-291.
17. **Others:** history left alone D-231; MIN. rule D-238; material follows size D-239; lid class researched D-240; names SCH and TG D-233.

### By the build chat

18. **N-029 to N-031** (sizes read back inexact, wipeout setting in a side drawing, a size not on the list becoming one): fixed and proven in pass 5.
19. **N-032 to N-038** (the seven build-against-ruling fixes), lid class in the Pit window, "SPS grated" and "SPS solid": round 39, abd517c, proven in pass 7. Also a size or grated/solid change by grip or block property now followed with one put-back (this is the other N-032 and N-033, see "Not sure").
20. **N-039 to N-056** (18 wrong-figure and pretend-to-work fixes; N-056 settled by D-289): 4821fd4, reviewed, proven in pass 7. Boyd's re-worked by hand under round-first: 2.65 and 2.29 unchanged, the office case 1.66, the made-up job 1.64.
21. **N-002** Pit move speed: speed 13 of 13 in passes 4, 5 and 7.
22. **N-027** Unsaved changed files: committed (beff8de through ea1af65).
23. **Runner:** a guard trip now stops the whole pass (item 55); each step has a 60 second limit and it closes its own test AutoCAD (item 73).
24. **Deleted picture folders:** in its own scratchpad, no evidence lost (item 79).
25. **Properties research** written (corrects pass 5's reading), test command renamed CEFACTS1.
26. **Pit tool block reading and long section check** (fixed and passed in pass 2; revision 1 closed tail items).

### By the trials chat

27. **Grips:** our own drawn shapes paint; hover words; click safe; the 17 Nov crash cause found (Failure value); drag with one undo; double-click takeover on our noted objects only; flip and slide on a masked label; nothing on a locked layer; 60 labels in 19 thousandths of a second; hover menu (R-011). Closes U-030 and three unnumbered trial items.
28. **Preview option C** measured (R-012); the catch and the unproven parts are W-051 and U-034.
29. **The 3:30 pm test-AutoCAD incident:** closed as far as it can be; cause not found.

### By the interview chat

30. **CLEAN / CN** (CL-01 to CL-09, TA-077 to TA-087), **Manager** (TA-088 to TA-101, statistics in the first release), **OFFICEHATCH / OH** (TA-102 to TA-110), **OFFICETEXT / OT** (TA-111 to TA-119), **joints** CJ, SSC, AJ, JS (TA-120 to TA-125), **OFFICELAYER / OL** (TA-126 to TA-130). **W-023** is settled by the Manager spec (fault report always carries the drawing, office IT folder only).

### By the planning chat

31. **O-001** function plan and tick sheet delivered; **O-003** build calls in batches; **O-014** director's summary refreshed (6:00 pm); **O-019** lid class.
32. **Label blocks** (D-290): the PT labels carry a fixed tag, not the pipe description; the pipe label is masked text. Corrects D-261.
33. **N-056** reading reversed by D-289; the Detention mock-up passed checkers and Tim's look; rulings pages to D-297 and a second reader; artifact "CE Civil Final Program" (D-281).
34. **Rule for each ID clash** (revision 1 section 9 item 25) stands.

---

## 7. WHERE THINGS LIVE

Every kind of ID in use, its home and the highest number used. IDs are never reused.

1. **D-** decisions. Home: `zero\DECISIONS.md`. Highest D-297. The last pages are out of order (D-016 to D-030, D-156, D-167 sit after D-226 and later ones).
2. **R- (rules).** R-01 to R-71 (two digits). Home: `zero\RULES.md`. **R-70** is the check list for every robot that sends to AutoCAD (new today).
3. **R- (research).** R-001 to R-012 (three digits). Home: `zero\reference\research\`. New: R-010 lid class, `R-011_GRIP_SHAPES.md`, `R-012` the preview. **CLASH** with the rules' prefix; only the digit count differs.
4. **P-** parked items. Home: `zero\PARKING_LOT.md`. Highest P-08.
5. **Q-** open questions: Q-001 to Q-017 (Tim), Q-101 to Q-107 (files), Q-201 to Q-206 (research), Q-301 (Stage 5). Home: `zero\OPEN_QUESTIONS.md`.
6. **FM-** function map lines. Home: `zero\design\FUNCTION_MAP.md`. Highest FM-184. **FP-** function plan lines FP-001 to FP-077 live in `design\FUNCTION_PLAN.md`; its tick sheet is `design\FUNCTION_PLAN_TICK_SHEET.md`.
7. **OC-** obstacles. Home: `zero\stage6\OBSTACLE_COURSE.md`. Highest OC-27; OC-28 named as next. **SP-** shared parts (highest SP-22) and **OQ-** obstacle questions (highest OQ-10) are in the same file.
8. **ST-** shared tools ST-01 to ST-18; **MG-** Manager MG-01 to MG-06; **TQ-** TQ-01 to TQ-13; **CX-** CX-01 to CX-04; **FI-** FI-01 to FI-04. Home: `zero\design\TOOLS_AND_MANAGER_INTERVIEW.md`.
9. **TA-** Tim's tool answers. Home: `zero\interview_tools\ANSWERS.md`. Highest TA-130 (added since revision 1: TA-064 to TA-130). **Flag:** older files still cite A-01 to A-17, which are TA-001 to TA-017.
10. **Interview specs (new today), all in `zero\interview_tools\`:** `CLEAN_STEPS.md` (CL-01 to CL-09), `OFFICEHATCH_SPEC.md` (OH-01 to OH-11), `TEXT_SPEC.md` (TX-01 to TX-05), `JOINTS_SPEC.md` (JT-01 to JT-06), `OFFICELAYER_SPEC.md`, `MANAGER_SPEC.md` (rev 3). Hatch ticks HT-, HF-, HL-, HX- stay in `HATCHES_BY_FUNCTION.md` (HT superseded by D-227).
11. **BK-** office blocks. Home: `zero\design\BLOCKS_REVIEW.md`. Highest BK-453 (check; 18 blocks were added to the palette, TA-076).
12. **T-** tools of today. Home: `zero\reference\today\TOOLS_TODAY.md`. Highest T-056. **Flag:** T- also meant "tests" in the first rules.
13. **E-, S-, L-, K- (job kinds):** `zero\reference\` (`drafting\ELEMENTS.md`, `design\SUMS.md`, `design\LIMITS.md`, `design\JOB_KINDS.md`). **Flag:** K- is also used on this board for parked items; job kinds are written "JOB KIND K-nn".
14. **C-** councils C-001 to C-009, home `zero\reference\councils\`. **Flag:** the old plan's release names such as "C-80" use the same prefix; no rule given.
15. **CIV-** coded reference jobs; no home file by design; the keys stay on Tim's PC.
16. **CP-** concept principles CP-01 to CP-12. Home: `zero\design\CONCEPT.md`.
17. **BUG-** the old plug-in's bugs. Home: `C:\CE_PLAN\BUG_CARPARK.md`. **NB-** new plug-in bugs: `zero\NEW_BUGS.md`. **ID-** ideas: `zero\IDEAS.md` (ID-001 to ID-019). Tests: `zero\TESTS.md`.
18. **DQ-** the build chat's merged draft questions DQ-001 to DQ-153 (104 live, all closed; 49 answered earlier). Home: `C:\CE_CIVIL\acad\DRAFT_QUESTIONS.md`.
19. **W-, O-, N-, U-, K-** (and the closed list). Home: this file. Highest now W-060, O-037, N-068, U-040, K-025. **Note:** N-032 and N-033 are each used twice.
20. **Design records (new today), all in `zero\design\`:** `SCREEN_RULES_18NOV.md` (Tim's 31 screen rules, his words); `STYLE_APPROVED_18NOV.md` (the approved style; the mock-up wins where they differ); `SCREEN_AUDIT_18NOV.md` (the audit of eight screen groups, 224 marks: 37 meet, 127 fail, 60 not checked).
21. **Pictures (new today), all in `zero\pictures\`:** `detention_fixed_mockup.html` (version 4 is the approved style, with `detention_fixed_suits.png`, `_short.png`, `_notknown.png`); `preview_options.html` with `preview_option_A.png`, `_B.png`, `_C.png`; `pipe_label_tight_spaces.html` (and `.png`); `whole_plugin_few_tools.html`; `pick_an_oh_window.html`; `final_program_artifact.html` (source of the published "CE Civil Final Program").
22. **Rulings:** `zero\rulings\` (26 pages to D-297; includes new `SCREENS_AND_STYLE.md`; index `INDEX.md`).
23. **Build chat files:** `C:\CE_CIVIL\BUILD_LOG.md` (entry numbers repeat, so they are not IDs), `acad\PROPERTIES_OPTIONS.md`, `acad\DRAFT_QUESTIONS.md`, `stage6\TRY_THE_WINDOWS.md`.
24. **Not IDs but cited as if they were:** BUILD_LOG entry numbers; numbered DRAFT lines per file; trial numbers 1 to 11; night check names CETEST, CEPIT1 to 7, CEPIPE1 to 8, CELEV1 to 7, CESPEED, CEFACTS1.
25. **Stray:** GB-04 (R-002), IFD-01 (R-008).
26. **Rule for each clash:** R- research is "R-0nn" with its title, Tim's rules "R-nn"; T- is "TOOLS_TODAY T-nnn", tests are OC-; interview answers are TA-nnn; board parked items stay K-nnn and job kinds are "JOB KIND K-nn"; FP- in `design\FUNCTION_PLAN.md`; CIV- keys stay on Tim's PC; C-: no rule given; bugs BUG- (old), NB- (new); ideas ID-.

---

## 8. NOT SURE (I did not guess)

1. **The W count.** I counted 45 open W items by hand (26 old IDs still open, plus W-039 and W-043, plus 17 new W-044 to W-060). Please recount; the W list is the longest and most likely to hold a slip.
2. **N-032 and N-033 are each used twice:** item 13 (palette size not carried into our note; CEPROPS already a command in his AutoCAD) and item 17 (hand-moved pit label must follow; "Cannot check yet" must be grey). Item 45 closes N-032 to N-038 meaning item 17's set. I treat item 13's as closed too (round 39 followed a size change; the test command was renamed CEFACTS1), but the board does not say so in those words.
3. **N-048 against N-001:** N-048 is the explode recording failing in pass 7, the same fault as N-001 (item 40 listed it under the risk list, and item 72 says the explode gap is the only known failure). I merged them.
4. **Pass counts do not add:** pass 4 reads 104 checks, 97 pass, 4 fail, 2 not tested (103); pass 7 first read 101 checks with 98 + 2 + 2 (102), squared to 102 in item 73. Pass 4 was not squared.
5. **D-261 against D-290:** items 30, 31 and the DQ files say the pipe label is the office's own label block; D-290 corrects this (a fixed-tag block, not the pipe description). I followed D-290.
6. **W-023 against the Manager spec:** W-023 asked him to approve a report that never carries a drawing; TA-088 to TA-101 say it always carries the drawing (office IT folder only). I closed W-023 as settled by the Manager spec; the board never says so.
7. **W-024 against D-260 DQ-005** (existing layer never changed, D-191): kept open because the board does not close it.
8. **W-002:** whether Darebin 0.80 is confirmed is not stated. **N-003:** whether the rainfall and council-C fix finished is not stated.
9. **W-008, W-009 (FO and OF), W-010 (top water level, orifice pit), W-019, W-020:** each may be partly answered by interview rulings, but section 12 never says so.
10. **W-018:** D-250 removed WT, but Bl (BREAKLINE) is not mentioned; I kept Bl open.
11. **W-039 pair (a):** D-263 appears to settle it; the board does not say. Pair (c) closed by D-278.
12. **W-040:** the five ASK items are answered; the other FP lines are "agreed unless he says otherwise". Also D-246 and D-274 changed the plan from 31 tools to 11 windows, so I could not tell if the 77 lines are still what stands. I closed W-040; O-001 closed with it.
13. **Planning-chat calls counted as closed:** the 104 build calls include about 50 settled by the planning chat from earlier rulings (D-260, 261, 271, 276 to 278, 282, 285, 288, 289), each "his to overturn". I count them as closed, as the board's own running count does; W-026 closed on one of them (D-288). This is a policy choice for you.
14. **W-050 against D-288:** the planning chat's call already says a level below 0.00 is amber everywhere; the question to Tim also stands.
15. **O-009, O-014, O-015, O-016, O-020:** O-009 delivery not stated; O-014 closed on the summary's date but the board's counts are not on it; O-015 and O-016 not mentioned in section 12; O-020 (slimmer window pictures) is held for W-043.
16. **N-016, N-025:** probably done (PIT BLOCK 3 placed by data and 8 of 8 checks; recordings re-taken in later passes), but not stated; kept open. **N-002** closed on "speed 13 of 13", not on a named pit-move check.
17. **N-027** closed on commits shown; the build log's own "not committed" labels were not checked.
18. **N-017 and U-033:** the crash cause is found and the rule exists; whether to call N-017 closed until the real tools carry it is a choice; I kept it open.
19. **Items from your brief not found in BOARD.md:** plain names for the two detention methods (W-060); whether existing civil text resizes (W-046); fonts inside AutoCAD windows (U-036). I wrote them as you named them and marked the source.
20. **Time stamps:** the board itself says items 15, 17, 18, 19, 42, 47, 52 and 53 carry times written from memory; item 20 corrects only the first four. I give "since" times as about, from the item.
21. **Alias file as a "saved setting" under rule 1.9:** the board lists this as unsure; not resolved.
22. **Hours disagree:** the zero plan, `C:\TimOS\RULES.md` 1.8 and AGENTS.md give three different free and workday hours; revision 1 section 10 item 13 left it for Tim. Not in your layout, so not folded.
23. **Revision 1 sections 4 (Being built), 8 (the old plug-in) and 10 (checks failed) are not in your nine-part layout.** Section 8's BUG-866 advice is now closed by D-245 and D-246 but the other bugs in it (BUG-1095, hatch, the 15 that stop work) are unchanged; section 10's LEFT items (BUILD_LOG stale, SITUATIONS, reference library behind) are unchanged except as above.
24. **Section 12 item 69's slip:** the tight-spaces page's last line says the wording is unchanged in all four ways; the short form does change it. Not fixed per the board.
25. **Other small items I left unplaced as separate entries:** the grade pick list's "60" is DRAFT (item 45); the 23 fixes to the rulings pages not shown applied (O-002); the "Match" button and "Turned" box are hidden in the AutoCAD tools until built (N-044, N-045 closed by hiding them, not by building them).
26. **K-009:** statistics are in the first release (TA-096) so I trimmed K-009; it still lists "fuller admin control" and others as later.

---

**Section 12 items folded: 79 of 79; items I could not place as a list entry (context only, nothing to carry): 8 (highest decision), 43 (grey look, absorbed into D-294), 59 (night status), 63 (Tim has gone home), 67 (a helper started).**
