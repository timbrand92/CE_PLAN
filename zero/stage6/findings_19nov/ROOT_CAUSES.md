One-job release | Part 1 of 9: Drawing safety (copy, move, erase, undo) | Built 2, Checked 0, Installed 0, Accepted 0 (of 9)  
Now: Keep AutoCAD testing stopped until the night runner can prove which drawing it owns and stop safely at a licence or sign-in window.

**Step A covers all nine parts.** The nine reports confirm 508 numbered findings, 119 more than the earlier tally. They reduce to 25 causes in repair order. **24 causes have a release blocker.** A finding marked “can wait” in its part keeps that priority when it shares a cause with a blocker. [Earlier count of 389](FINDINGS_SUMMARY.md) · [Release board](../../../CE_PLAN/BOARD.json)

## Unsafe edits

1. **C1. The night runner can close the wrong drawing** · 5 findings · Part 9 · **BLOCKS**  
    Keep night testing stopped. Before every action, verify the permitted action, Melbourne test hours, session the runner started and full path to its test copy. Stop if ownership is uncertain or a licence or sign-in window appears. Leave that window untouched.

2. **C2. A pit edit can move a protected pipe** · 19 findings · Parts 1, 2, 5 · **BLOCKS**  
    Check the actual drawing, space, units, record, destination layer and every affected neighbour immediately before writing. Check layer lock, external reference and active reference edit. Refuse an unsafe write in words. The bench recorded a protected end moving 1,000 mm.

3. **C3. A failed edit can leave half the change on the drawing** · 11 findings · Parts 1, 2, 5, 9 · **BLOCKS**  
    Make each complete command one drawing change, including its labels, joins and new layers. Force the second write to fail and compare with the starting drawing. One Undo restores a finished run. During placement, Undo takes back the last pipe.

4. **C4. A copy, label or held cell can belong to the wrong part** · 27 findings · Parts 1, 2, 4–7, 9 · **BLOCKS**  
    Give each part and arrival a permanent identity in its drawing and require both sides of a join to agree. Each copied pit gets the next free pit number. Separately copied lettering belongs to the drafter. Keep disputed tags for Unfinished. Removing a pipe must leave its 6.66 m hold off the 5.32 m downpipe.

5. **C5. A move can find the wrong wall, bend or pipe end** · 28 findings · Parts 1, 2, 4, 5 · **BLOCKS**  
    Carry the picked part and its exact attachment through the edit. Recalculate only the affected wall, open end, bend and followers. Keep hand-set offsets, elevation and scale. Placing an outlet must leave a pipe 30 m away untouched.

6. **C6. Editing one figure can erase another or change who supplied it** · 37 findings · Parts 1–8 · **BLOCKS**  
    Save the measured or supplied figure, its source and any engineer’s hold together on the job, part or arrival that owns it. Change only what the drafter edits. Reopening a pipe must keep its held 450 mm cover and source. A held roof total must still show the connected-roof comparison.

## Wrong figures

7. **C7. Job and the design windows can use different figures** · 24 findings · Parts 2–8 · **BLOCKS**  
    Give the drawing one Job record for council, method, rainfall source and period, paving and tolerance. Each tool reads the applicable sourced rule from it. If Job saves 650 m², Detention must use 650 m². Selecting the relevant council must apply its 65 mm hole and 60% underground checks.

8. **C8. Two joined ends can look like a route to the legal point** · 11 findings · Parts 4, 5, 7, 8 · **BLOCKS**  
    Trace each run downstream through its recorded joins, including branches. Use the same trace for storage, discharge, Unfinished and the direction shown in plan. Name every excluded part. With 1.46 m³ required, the connected 1.44 m³ is 0.02 m³ short. Exclude the isolated pit’s 0.04 m³.

9. **C9. The sums can measure a different pipe from the one drawn** · 18 findings · Parts 1–3, 8 · **BLOCKS**  
    Read one set of quantities from each finished part after every edit. Measure the centreline through arcs, count barrels, and check cover to the outside crown at each known change of surface or level. A semicircle with a 5 m radius contributes 15.71 m. At a bend, 240 mm cover must remain visible even with 300 mm at both pits.

10. **C10. A refused or missing entry can leave a green answer** · 39 findings · Parts 2–4, 6–8 · **BLOCKS**  
    Give each input and rule one validity check, then update only the results that depend on it. A bad entry reads “Wrong” and its dependent answer “Cannot check yet”. A required missing value reads “Not known” in the window and “TBC” on the sheet. A known discharge failure stays visible when rainfall is wrong.

11. **C11. Printed numbers can change a verdict or hide the working** · 23 findings · Parts 2, 3, 5–8 · **BLOCKS**  
    Calculate once from the full figures and print the operands, units and difference from that calculation. Use the job’s level and cover tolerance, initially 5 mm. Outside tolerance, say how short. Compare grades at two decimal places. Keep Boyd’s two-place inflow rounding. A 50 mm fall over 10.004 m must be checked at 1 in 200.08.

12. **C12. Detention can check a different hole from the one on the detail** · 6 findings · Part 8 · **BLOCKS**  
    Use one outlet calculation from the control pit’s levels and chamber sizes. Derive the plate height, round the automatic hole down to a fitting whole millimetre and use the adopted hole for discharge and the detail. Check the gravity outlet pipe’s own capacity in L/s. The review found 70 mm displayed beside a pass for 69 mm.

## Rulings still to build

13. **C13. Warnings can lose the part, the shortfall or the remedy** · 32 findings · Parts 2–8 · **BLOCKS**  
    Publish one list of check results keyed to each part, end or sheet. Pit, Pipe, Schedule, Detention, Unfinished and the plot notice read that list. Keep every affected pit and remedy when grouping warnings, show how short it is and keep one standing-note reminder for an “APPROX.” sheet.

14. **C14. The same part can have different symbols or words on the issued sheet** · 39 findings · Parts 1, 2, 4–6, 8, 9 · **BLOCKS**  
    Draw, label and schedule each part from one approved office definition for its kind and actual connection. Include dimensions, layer and plot state, edge lines, masks, “APPROX.” for estimates and “TBC” for missing figures. Offer to show an off or frozen layer. The council pit needs the crossed square with an editable EX tag. The kerb outlet needs a half circle facing the road.

15. **C15. The window can show a sample pipe or hide the actual result** · 54 findings · Parts 2–4, 6–8 · **BLOCKS**  
    Use the same approved window on the bench and over the drawing, fed by the selected parts, checked geometry and actual before-and-after figures. Keep the Pipe and Detention previews across the top, the Pit and Pipe sketches beside their inputs, and every warning reachable at 150% scaling.

16. **C16. A drafting choice can do nothing or act on another value** · 23 findings · Parts 2, 4–6 · **BLOCKS**  
    Bind each offered action to the current selection and save the choice on its proper part. Use the current run for placement defaults. Write the selected invert labels and flow arrow, and refresh the schedule from each plastic pit’s inclusion tick. Renumber from the street outlet only on request.

## Missing AutoCAD commands

17. **C17. The Inlet command cannot place or edit an inlet** · 2 findings · Part 4 · **BLOCKS**  
    Connect the Inlet window to one drawing placement-and-edit command for the kinds Tim selects. If downpipes are selected, one opening must place 12 successively numbered downpipes and one Undo must remove that batch.

18. **C18. The Pit schedule command stops at a preview** · 2 findings · Part 6 · **BLOCKS**  
    Give the schedule one placement-and-refresh command. A single pick places the office grid and text on the sheet. When a pit changes, its row must refresh in that same schedule and keep its own held remarks after reopening.

19. **C19. The Job command cannot open the current drawing’s settings** · 3 findings · Part 7 · **BLOCKS**  
    Give Job its own drawing command. Read the actual model units and layout scale, allow a closed boundary to be measured and compared with the supplied area, and save council and tolerance with that drawing.

20. **C20. The Unfinished command cannot take the drafter to the fault** · 3 findings · Part 7 · **BLOCKS**  
    Give Unfinished its own drawing command backed by the current open-item list. “Go to” must locate and temporarily highlight the named part, then clear the highlight and restore the view. Plotting must report the current count and continue.

21. **C21. The Detention command cannot carry the design onto the drawing** · 2 findings · Part 8 · **BLOCKS**  
    Connect the approved Detention window to the active drawing through DET. Follow one picked part from its temporary highlight through saving and reopening to the printed, working in flow order, with one row per pipe size and every contributing length for that same drawing.

## Other causes

22. **C22. A test result can retain identifying text** · 3 findings · Parts 2, 9 · **BLOCKS**  
    Write results using only approved fields and neutral test identifiers. Check the saved filenames and contents with a made-up marker, including paths below the test folder. The reviews found a retained test path. They recorded no client disclosure.

23. **C23. A permanent check can pass with the wrong answer** · 48 findings · Parts 1–9 · **BLOCKS**  
    Start each repair with an independently worked expectation for the named part, field, figure or visible mark. Break that exact case and require it to fail. For example, a check for 1.70 must reject 11.70. For Boyd’s, work from the original areas through all six storms to the printed result.

24. **C24. A release can receive credit for a result nobody saw** · 47 findings · Parts 1, 2, 4–7, 9 · **BLOCKS**  
    Keep one record per required case on the exact combined build, with the expected command owner and observed drawing, plot, screen or elapsed time. Require two distinct clean nights on test copies, then the load for Tim on a test copy, then his chosen real job. Keep the night hold at C1 in force.

25. **C25. A new job can inherit the last job’s confirmations** · 2 findings · Parts 1, 7 · **can wait**  
    Distinguish same-job Save As from starting a different job with an old drawing. On a new job, retain each inherited figure’s source and mark it assumed until confirmed. This can wait while the first job starts from the office template.

---

**First-job choices.** Tim still has to name the inlet kinds and choose pipe or tank storage. Tank-specific follow-ups come forward if he picks a tank. The initial water level, partly submerged pipe credit and underdeck tank treatment remain open. Long section stays parked. [One-job scope](../../../CE_PLAN/zero/stage6/ONE_JOB_RELEASE.md) · [Detention review][p8]

<details>
<summary>Check the counts, finding numbers and rulings</summary>

1. **Count by part.** Parts 1 to 9 contribute 51, 132, 46, 28, 46, 50, 54, 62 and 39 findings respectively. One number in one part counts once. Different parts can describe the same fault. Their numbers are kept so the repair can be checked everywhere it matters.

2. **Why 508 differs from the board’s 389.** The earlier summary recorded 389 survivors and 125 pending out of 514 entries. The nine later reports confirm 119 more. The other six are Part 3 #29 (paused Long section), #30 and #31 (conditional cover cases), #50 (outstanding drawing proof included in C24’s sign-off), Part 5 #33 and Part 7 #35 (both disproved). Those six add zero to the cause totals. [Earlier summary](FINDINGS_SUMMARY.md) · [Part 3][p3] · [Part 5][p5] · [Part 7][p7]

3. **The two Part 7 commands.** Finding #1 records both missing commands and is counted under Job, C19. Unfinished, C20, counts its three separate findings on locating the part, reporting at plot and proving the highlight. Both commands block release. [Part 7][p7]

4. **Review limits.** The source reports concern revision `2ce8070`. Step A changes this report only. Product tests, AutoCAD sessions, builds and installations in this review were all zero. The board records Parts 3 and 7 as built on the bench. D-346 is the planning chat’s repair order. The Codex job brief specifies `gpt-6.2-astra`. [Decisions](../../../CE_PLAN/zero/DECISIONS.md) · [Release board](../../../CE_PLAN/BOARD.json)

### Original finding numbers by cause

1. **C1** · [Part 9][p9] 1–5. (Rule 1.9, D-116, D-160, D-325, D-326)

2. **C2** · [Part 1][p1] 1, 18–21, 31 · [Part 2][p2] 1, 25–29, 57, 58 · [Part 5][p5] 1, 6, 30, 38, 39. (D-216, D-344)

3. **C3** · [Part 1][p1] 2, 16, 17, 30, 38 · [Part 2][p2] 5, 100 · [Part 5][p5] 5, 18 · [Part 9][p9] 13, 36. (D-216, D-256, D-324)

4. **C4** · [Part 1][p1] 3, 5–8, 12–15, 32, 33, 36 · [Part 2][p2] 6, 48–50, 67 · [Part 4][p4] 2, 3 · [Part 5][p5] 16 · [Part 6][p6] 2, 3, 16, 17 · [Part 7][p7] 14, 15 · [Part 9][p9] 12. (D-103, D-113, D-179, D-340)

5. **C5** · [Part 1][p1] 4, 23–26, 28, 29, 34, 35 · [Part 2][p2] 7, 22, 23, 30–34, 51, 52, 69 · [Part 4][p4] 4 · [Part 5][p5] 2, 8–11, 17, 19. (D-034, D-176, D-189, D-256)

6. **C6** · [Part 1][p1] 9, 11, 22 · [Part 2][p2] 9–15, 19 · [Part 3][p3] 3, 7, 22, 33 · [Part 4][p4] 6, 8, 12 · [Part 5][p5] 7, 12, 21, 34 · [Part 6][p6] 8, 18 · [Part 7][p7] 19, 28–30, 41 · [Part 8][p8] 13, 17–19, 28, 30, 38, 47. (D-074, D-171, D-179, D-322, D-332)

7. **C7** · [Part 2][p2] 93 · [Part 3][p3] 6, 16, 18, 42 · [Part 4][p4] 11 · [Part 5][p5] 26 · [Part 6][p6] 14 · [Part 7][p7] 2, 3, 5, 12, 26, 27, 33, 36, 39, 44 · [Part 8][p8] 3, 12, 14, 29, 35, 36. (D-249, D-310, D-321, D-327, D-330–332)

8. **C8** · [Part 4][p4] 10 · [Part 5][p5] 3, 4, 15 · [Part 7][p7] 7, 8 · [Part 8][p8] 1, 2, 21, 32, 43. (D-176, D-311, D-343)

9. **C9** · [Part 1][p1] 27 · [Part 2][p2] 4, 16, 17, 20, 21, 53, 54, 62, 108 · [Part 3][p3] 2, 5, 8, 17 · [Part 8][p8] 20, 22, 27, 31. (D-082, D-146, D-277, D-330)

10. **C10** · [Part 2][p2] 8, 38, 44, 47 · [Part 3][p3] 10, 12, 13, 19–21, 41, 43–45 · [Part 4][p4] 5, 7, 16, 22 · [Part 6][p6] 4–7, 12 · [Part 7][p7] 4, 9–11, 37, 38, 40 · [Part 8][p8] 5, 6, 11, 15, 16, 23, 24, 37, 41. (D-219, D-286, D-295)

11. **C11** · [Part 2][p2] 3, 39, 41, 56 · [Part 3][p3] 1, 4, 23–25, 27, 35, 38, 40 · [Part 5][p5] 27 · [Part 6][p6] 9, 11, 22 · [Part 7][p7] 16, 17 · [Part 8][p8] 8, 9, 42, 45. (D-079, D-295, D-318, D-321, D-343)

12. **C12** · [Part 8][p8] 4, 25, 26, 33, 39, 49. (D-018, D-095, D-104, D-172, D-173)

13. **C13** · [Part 2][p2] 18, 42, 99, 101, 102, 107 · [Part 3][p3] 9, 11, 28, 36 · [Part 4][p4] 13 · [Part 5][p5] 28, 35, 36 · [Part 6][p6] 10, 20, 21, 28, 29, 45, 46 · [Part 7][p7] 6, 13, 21, 24, 25, 34, 42 · [Part 8][p8] 10, 52–54. (D-216, D-248, D-311, D-343)

14. **C14** · [Part 1][p1] 10 · [Part 2][p2] 2, 24, 35–37, 40, 59, 61, 63–66, 71, 90, 92, 103, 104, 110 · [Part 4][p4] 18 · [Part 5][p5] 13, 14, 20, 22–25, 31, 32, 40–42 · [Part 6][p6] 13, 15, 36 · [Part 8][p8] 34, 40, 55 · [Part 9][p9] 30. (D-177–179, D-260, D-320, D-333, D-334)

15. **C15** · [Part 2][p2] 43, 45, 46, 73–77, 79, 81–83, 94–98, 105, 106 · [Part 3][p3] 14, 15, 26, 32, 34, 37, 39 · [Part 4][p4] 9, 15, 17, 20, 21, 23, 27 · [Part 6][p6] 30–34, 37, 39, 43, 44, 47, 49, 50 · [Part 7][p7] 22, 43, 45, 46 · [Part 8][p8] 44, 46, 48, 50, 51. (D-286, D-301, D-305, D-309, D-313)

16. **C16** · [Part 2][p2] 55, 60, 68, 70, 72, 78, 80, 84–89, 91, 109 · [Part 4][p4] 14, 19 · [Part 5][p5] 29, 37 · [Part 6][p6] 19, 24, 35, 48. (D-076, D-183–185, D-236, D-263, D-322, D-323)

17. **C17** · [Part 4][p4] 1, 26. (D-050, D-101, D-186, D-338)

18. **C18** · [Part 6][p6] 1, 38. (D-103, D-109, D-113, D-221)

19. **C19** · [Part 7][p7] 1, 31, 32. (D-171, D-194, D-310, D-321)

20. **C20** · [Part 7][p7] 20, 23, 51. (D-188, D-301, D-311)

21. **C21** · [Part 8][p8] 7, 62. (D-099, D-305, D-338, D-343)

22. **C22** · [Part 2][p2] 127 · [Part 9][p9] 11, 28. (Rule 11, standing brief §1.4, D-216)

23. **C23** · [Part 1][p1] 41, 45–47 · [Part 2][p2] 111–118, 128, 130, 132 · [Part 3][p3] 46–49 · [Part 4][p4] 24, 25 · [Part 5][p5] 43–46 · [Part 6][p6] 23, 26, 40, 41 · [Part 7][p7] 47–50, 52, 53 · [Part 8][p8] 56–61 · [Part 9][p9] 16, 20, 21, 24, 25, 35, 37. (D-095, D-216, D-321, D-346)

24. **C24** · [Part 1][p1] 37, 39, 40, 42, 44, 48–51 · [Part 2][p2] 119–126, 129, 131 · [Part 4][p4] 28 · [Part 5][p5] 47 · [Part 6][p6] 25, 27, 42 · [Part 7][p7] 54, 55 · [Part 9][p9] 6–10, 14, 15, 17–19, 22, 23, 26, 27, 29, 31–34, 38, 39. (D-216, D-325, D-338)

25. **C25** · [Part 1][p1] 43 · [Part 7][p7] 18. (D-191, D-216)

</details>

[p1]: ROOT/group_part_1.md
[p2]: ROOT/group_part_2.md
[p3]: ROOT/group_part_3.md
[p4]: ROOT/group_part_4.md
[p5]: ROOT/group_part_5.md
[p6]: ROOT/group_part_6.md
[p7]: ROOT/group_part_7.md
[p8]: ROOT/group_part_8.md
[p9]: ROOT/group_part_9.md
