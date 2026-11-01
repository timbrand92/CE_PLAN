# Queue filler: Codex look briefs (CE 05 queue, Mon 2 Nov 2026)

Read-only job. Nothing was built, tested, run or installed. No AutoCAD, no robot, no Codex run. No repository file was changed. Ten new job files were created in `C:\CE_PLAN\desk_jobs\team_queue` and this report. Nothing was pushed.

## FOR TIM

1. **What I did:** I queued ten read-only Team jobs. Each one writes a Codex look brief (exact steps, expected words, old fault, controls) in the style of the existing runner briefs. I did not write the briefs themselves: a job writes each brief, so I have not seen any finished brief yet.
2. **K1_02b (BUG-1268, CDCALC Export to XLSX):** one job (400). It covers the Enter run, the Save-click run, the Cancel control, the bad-folder run, the switch-off run (only with a GO flag) and the Excel look.
3. **"A3, B and C": I could not find a set of looks with those names.** The nearest matches are listed below. If CE 02 meant something else, say so before the jobs run.
4. **What the briefs cannot prove:** nothing here is proven yet. Each brief only becomes a result after Codex runs it in real AutoCAD, and the PRs are drafts that are not in the installed build (3.0.88).
5. **Mistake to own:** `team_queue_started\021_fill_codex_briefs.txt` is this same job, so another session may already have started it. I found no earlier output file, so I carried on. If two copies run, the second only repeats work.

---

## What A3, B and C could be (searched, not found as a named set)

1. **Searched:** `C:\CE_PLAN\areas` (all 1,023 files by name; content search of the Codex, proof-lane, session-map and triage files), `desk_jobs`, the runner folder `C:\Lisp Files\_CODEX_RUNNER` (1,150 files by name) and the Codex runner report names.
2. **"A3" in the 24 Oct triage** (`BUG_REGISTER_TRIAGE_2026-10-24.md`) means "needs Tim's engineering word" (21 bugs). That is not a look, so I did not brief it.
3. **Batch A, B and C in `CODEX_LOOKS_PLAN_C78_C79_01NOV.md`:** these are the three Codex sessions planned for 1, 3 and 4 Nov. Batch A already has briefs (`verifyA78`, `verifyA78b`, `verifyA78c`, `verifyS467`, `verifyK1`). Batch B and batch C have no briefs. I queued those (jobs 401, 402, 403). This is my best reading of "B and C". For "A3" I found no match, so Batch A is not re-queued.
4. **Lanes A, B and C in `BUG_PROOF_LANES_31OCT.md`:** lane B is "judged by eye" (27 bugs), lane C is "needs Tim's engineering call" (11 bugs). I briefed lane B in three jobs (405, 406, 407). Lane C needs a question answered, not a look, so I left it out.

## The jobs queued (all `# MODEL: sonnet`, prefix 4)

1. **400_look_k1_02b_cdcalc_xlsx.txt** writes `areas\LOOKBRIEF_K1_02B_02NOV.md`: K1_02b, draft #1983 (B-157, switch `excel.confirmCalcXlsxSaved`).
2. **401_look_batchB_civil_screens.txt** writes `areas\LOOKBRIEF_BATCHB_CIVIL_SCREENS_02NOV.md`: #1857, #1875, #1962 and the CDRULES window answers (#1949, #1887).
3. **402_look_batchB_drawing_and_manager.txt** writes `areas\LOOKBRIEF_BATCHB_DRAWING_MANAGER_02NOV.md`: #1888 and #1926 (drawing session); #1876, #1936 and #1935 (Manager session).
4. **403_look_batchC_hub_and_edits.txt** writes `areas\LOOKBRIEF_BATCHC_HUB_EDITS_02NOV.md`: #1940 and #1945 (Civil Hub); #1972, #1892, #1950 and #1923 (drawing edits; #1950 needs an older drawing and #1923 only if it ships OFF).
5. **404_look_w234_blocked_for_robot.txt** writes `areas\LOOKBRIEF_W234_BLOCKED_CASES_02NOV.md`: W234 (the Design Warnings box, decision 186) plus every other robot case blocked for a window, box, ribbon, second drawing or restart that no other brief covers.
6. **405_look_laneB_part1.txt** writes `areas\LOOKBRIEF_LANEB_PART1_02NOV.md`: lane B bugs 011, 050, 090, 180, 194, 219, 226, 227, 228.
7. **406_look_laneB_part2.txt** writes `areas\LOOKBRIEF_LANEB_PART2_02NOV.md`: lane B bugs 233, 239, 243, 263, 264, 322, 518, 524, 571 (571 opens a Save box).
8. **407_look_laneB_part3.txt** writes `areas\LOOKBRIEF_LANEB_PART3_02NOV.md`: lane B bugs 576, 642, 669, 678, 748, 754, 767, 850, 858.
9. **408_look_export_save_box_fixes.txt** writes `areas\LOOKBRIEF_EXPORT_SAVE_BOX_02NOV.md`: every other fix that opens an Export, Save As or Open box (K1 and K1_02b excluded).
10. **409_look_ribbon_second_drawing_two_starts.txt** writes `areas\LOOKBRIEF_RIBBON_TWO_DRAWINGS_TWO_STARTS_02NOV.md`: fixes that need a ribbon, a second drawing, a second monitor or two AutoCAD starts.

## What each job tells the worker (so the briefs obey the rules)

1. **Safety paragraph:** copied word for word from `team_queue_started\010_weakcheck_N06v87.txt` (the same paragraph the other queued jobs use). I did not find a "safety paragraph" in `team_fix_cs1.txt` or `team_fix_rv19.txt` that differs from it, so I used the queue one.
2. **Style:** read `verifyK1_c88_full.txt`, `verifyA78c_c88_full.txt` and `verifyS467_c88_full.txt` (three existing briefs), plus `lookCOMMON_full.txt`, the batch A report and the driver-rules memory note (D1 to D12). The worker copies rules N1 to N17, D1 to D12 and changes (a) to (i) word for word and does not retype them.
3. **The word "follow":** each job forbids it in the brief text (BUG-421) and asks the worker to search the finished text for it. The word appears twice in each job file, both times inside that instruction.
4. **Save and Open boxes:** never accept or capture the folder the box opened in. Codex types a full path inside its own evidence folder, and the saved capture is taken after that, cropped to the File name box and buttons.
5. **Evidence folder:** `C:\CE_WORK\codex\<look id>_<yyyyMMdd_HHmm>\`.
6. **Output:** the brief is written as draft text inside the areas file. CE 02 copies it into `_CODEX_RUNNER`. No job writes outside `C:\CE_PLAN\areas`.
7. **Opus:** none of the ten is an Undo/REDO, locked-layer, Xref/REFEDIT or protected-file review, so all are Sonnet. Jobs 403 and 404 add Undo/Cancel controls to the looks.

## Checked and NOT checked

1. **Checked by reading:** the PR numbers and titles in jobs 400 to 403 exist on GitHub and are open drafts (`gh pr view`); #1857 returned a title but no state in my output, so I did not confirm its state. `W234_flat_pipe_moved_onto_other_pits.case.txt` exists in `_ACAD_DRIVER\cases\drafts_wave1_31oct`.
2. **Not checked:** the exact on-screen words and switch defaults for most PRs (the workers read them from the diffs), whether the fixtures the briefs need exist on disk, and whether the lane B items are still real on the installed build (jobs 405 to 407 decide that item by item).
3. **Likely clashes to watch:** look and launcher names such as `verifyB1_c79a` and `verifyLB1_c88` are suggestions. Each job tells the worker to list the runner folder and pick a free name.
4. **Build timing:** batch B looks need the C-79a build and batch C looks need the C-79b1 build (Wed 4 Nov evening). K1_02b needs the build that carries #1983. Each brief says "whatever is installed" and marks a look NOT TESTED, BUILD LACKS THE FIX if the switch is missing, which is information, not a stop.
5. **Not covered:** Batch A (already briefed), #1969 (comma-decimal PC, parked), #1957 and #1959 (AutoCAD 2022 to 2024 only), and lane C (needs Tim's engineering call).
