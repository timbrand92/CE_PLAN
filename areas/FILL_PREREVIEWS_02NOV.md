# FILL: Opus pre-review groups for open drafts with a Settings switch (Mon 2 Nov 2026)

## FOR TIM

1. **Count:** 1,564 draft PRs are open. 177 have the word "switch" in the title. 65 of those had no Opus pre-review and were not in the two triage files or PRs 1975 to 1988.
2. **Queued:** 58 of the 65, in 15 Opus review jobs (files 601 to 615 in `C:\CE_PLAN\desk_jobs\team_queue`). Each job is 3 to 5 PRs on the same line.
3. **Not queued (7):** #1829 and #1798 (robot-only diagnostics, no drafter change), #1576 (replaced by #1658), #1306, #871, #954 and #441 (see below).
4. **Read, built, tested:** I read PR titles, file lists and sizes only. Nothing was built, tested or opened in AutoCAD. No PR has been judged yet.
5. **Pilot-critical first:** jobs 601 to 603 (drawing record safety, Esc and Cancel in CD, Undo and REDO) should run before the rest.

## WHAT WAS DONE, AND WHAT WAS NOT PROVEN

1. **How the 65 were found:** I took every open draft with "switch" in its title. I dropped any PR number mentioned in any `OPUS_PREREVIEW_*.md`, the two triage files or the `FILL_*` files, and PRs 1975 to 1988.
2. **Weak spot:** a PR number merely mentioned in one of those files counts as covered. Some PRs may be covered more loosely than I assumed. A draft with a switch but no "switch" in its title was not searched for. The real number of unreviewed drafts could be higher.
3. **Same-function rule:** I could only check which files PRs touch, not which functions. Where two PRs share a file I split them across jobs where I could. Where I could not, the job tells the reviewer to say so under question 5. The three Pit Schedule jobs (613 to 615) say this in their text.
4. **Unusual PRs:**
   - **#1434, #1435, #1437:** a stack. They are in one job (602), as an exception to the same-function rule, so the stack can be checked as a whole.
   - **#1562, #1567, #1570, #1558:** each shows about 6,600 changed lines because the shared branch history is included. Job 603 tells the reviewer to read only each PR's own commits.

## THE 15 JOBS (queue order, pilot-critical first)

1. **601_prereview_rec_record_safety** (Civil, output `OPUS_PREREVIEW_FILL_REC_02NOV.md`): #1658, #1416, #1419, #1837. #1658 touches a protected file (`ProjectDataService.Persistence.cs`).
2. **602_prereview_uphill_cd_stack** (Civil, `..._FILL_UPHILL_...`): #1434, #1435, #1437. Cancel and line restore; Undo and REDO.
3. **603_prereview_chain_cd_fixes_1022m** (Civil, `..._FILL_CHAIN_...`): #1562, #1567, #1570, #1558. #1562 is marked "needs Opus review".
4. **604_prereview_long_section_frame** (Civil, `..._FILL_LONG_...`): #1433, #1421, #1432.
5. **605_prereview_chk_checks_and_reads** (Civil, `..._FILL_CHK_...`): #1525, #1512, #1403, #1407.
6. **606_prereview_edit_native_protection** (Civil, `..._FILL_EDIT_...`): #1417 (Xref repair), #1328, #1430, #1429, #1176 (in conflict with its base).
7. **607_prereview_detn_tank_and_pipe_material** (Civil, `..._FILL_DETN_...`): #1411, #1305, #1825, #1664.
8. **608_prereview_older_civil_switches** (Civil, `..._FILL_OLDER_...`): #1010, #705, #928 (in conflict), #1382 (marked "needs Opus review"), #1513. The job first asks whether each is still needed.
9. **609_prereview_late_settings_ribbon_checks** (Civil, `..._FILL_LATE_...`): #1278, #1297, #1495, #1517, #1180 (in conflict).
10. **610_prereview_mgr_manager_switches** (Manager, `..._FILL_MGR_...`): #1836, #1473, #1515.
11. **611_prereview_struc_switches** (Structural, `..._FILL_STRUC_...`): #1794, #1797, #1600.
12. **612_prereview_old_redo_and_sync** (Civil, `..._FILL_OLD_...`): #487 (REDO round 2), #610, #398, #406. Oldest drafts, so the job also asks whether to close them.
13. **613_prereview_ps1_pit_schedule_numbers** (Civil, `..._FILL_PS1_...`): #1426, #1425, #1413, #1409, #1431.
14. **614_prereview_ps2_pit_schedule_rows** (Civil, `..._FILL_PS2_...`): #1410, #1422, #1420.
15. **615_prereview_ps3_pit_schedule_merge_and_bridge** (Civil, `..._FILL_PS3_...`): #1415, #1412, #1424.

All 15 are `# MODEL: opus`, use the eight questions of `team_fix_rv19.txt` word for word, and carry its safety paragraph word for word. I changed only the PR list, the output file name, and three small additions: the intent now points to the PR description and `BUG_CARPARK.md`, a same-function note, and a closing "Final message" line. Output names are `OPUS_PREREVIEW_FILL_<key>_02NOV.md` in `C:\CE_PLAN\areas`. None of those names existed before.

## NOT QUEUED, AND WHY

1. **#1829 and #1798:** BUG-861 diagnostic switches for the robot only. No drafter-facing change.
2. **#1576:** the older version of #1658. Job 601 asks whether it can be closed once #1658 is kept.
3. **#1306** (section marks, stacked on #1298): shares `SettingsService.LoadRecovery.cs` with #1278 and #1382, so it could not be grouped cleanly. Needs its own group later.
4. **#871** (Manager menu bar) and **#954** (Manager outbox, 3,694 lines): both touch `CeOneGlanceStatus.cs` with #1836. They need a second Manager group.
5. **#441:** 36,669 lines. Too large for one review.

## SLIPS

1. **Scratch file:** my first `gh` attempt wrote an empty scratch file to `C:\ce-fx`, outside the output files I was allowed. I deleted that one file straight away. Nothing else was written outside `C:\CE_PLAN\desk_jobs\team_queue` and this report.
2. **`gh` not on the path:** `gh` was not on the tool path. I ran it from `C:\Program Files\GitHub CLI` and added Git's folder to PATH for that call only.
