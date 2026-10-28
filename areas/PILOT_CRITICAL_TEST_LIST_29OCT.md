# Pilot-critical test list: the 60 bugs, what proves each one (Thu 29 Oct 2026)

**Who and how.** CE 02 Robot and Codex Testing, headless Team job "CE_ACAD / robot / plan / 11" (Opus), started 10:35 Melbourne by the PC clock. Text and source reading only: AutoCAD, the runner, the driver, the settings guard and the lock were not touched. Installed build taken as Civil 3.0.85 / Manager 1.1.85 at commit `09126560` (the brief's word; I did not read the DLL version strings).

**Sources read:** `C:\TimOS\RULES.md`; `areas\COLLEAGUE_READINESS_29OCT.md` (in full); `areas\BUG_REGISTER_TRIAGE_2026-10-24.md` (section C, the 60); the five `release-v3-colleagues-PILOT_CRITICAL_BATCH1` to `BATCH5_REPORT.md`; the C-64 to C-75 finalizer reports (by search); `BUG_CARPARK.md` (the Command / Area, Steps to confirm and Status line of all 60 entries); `ROBOT_NEXT_CASES_SPEC_B3_28OCT.md` and `B4_29OCT.md`; `C:\Lisp Files\_ACAD_DRIVER\cases` (all folders) and `runner-reports\ledger.json`; the runner's own files (`case_runner.ps1`, `case_runner_lib.ps1`, both allow-lists); the installed source by `git show` / `git grep` / `git log` on `09126560`.

---

# ANSWER FIRST

1. **Closed: 0 / 60.** No pilot-critical bug is Claude-accepted, Codex-accepted or confirmed by you. No robot case touched any of them before today (two existing cases only mention BUG-855 as "not tested").
2. **Robot can prove now: 2.** BUG-1194 (label to the clicked leg) and BUG-1140 (pasted downpipe and its label). I wrote both as draft cases today, each with a broken twin. Nothing has run yet.
3. **Need a new case: 18.** 8 need a test drawing or a small reviewed runner change on your PC; 10 need another PC, a spare Windows login, an older AutoCAD or an older CE build.
4. **Need a Codex look: 6.** The value sits in a window the robot cannot read (CDCALC, Help, Manager, Pit Schedule export, CDDESIGN, the ribbon).
5. **Need your engineering word: 2 with a fix built** (BUG-905 the hard-ground C figure, switched off; BUG-1097 which head the 300 mm rule means). **10 more have no fix until you give a number.**
6. **No fix installed: 32.** 27 have no fix at all; 5 are built but not installed (BUG-1189, BUG-1149, BUG-1090, BUG-1052, BUG-1053).
7. **Installed fixes: 26 of 60** (24 new fix PRs plus BUG-1049 and BUG-540), checked in the installed source, not in the DLL.

---

# FOR TIM

1. **Where it stands.** 0 of 60 pilot-critical bugs are closed. 26 have a fix on your PC, but the robot can only drive 2 of them with the tools it has today; I have written those 2 tests.
2. **Why so few.** Most of these fixes sit where the robot cannot reach: a second PC or login, AutoCAD 2024, a survey Xref, a LandXML file, or a window it cannot read. Example: the nested survey fix (BUG-1190) needs a test drawing with a rotated survey Xref, which does not exist yet.
3. **What moves the number fastest.** (a) Run the 2 new tests twice tonight. (b) A Codex look at 6 windows. (c) 8 test drawings or small runner additions, listed in section C below. (d) A spare Windows login for 10 day-one checks.
4. **Your word is needed on two built fixes.** BUG-905: is 0.9 the right hard-ground C for CDCALC Boyd's? Until you say, that fix stays off. BUG-1097: should the 300 mm check use the head you type (as built) or the head left after pipe losses?
5. **Nothing for you to test.** Every check here is for the robot, Codex or a spare login.

---

# THE 60, ONE BY ONE (most severe first; the no-fix bugs are grouped at the end)

**How to read an entry.** "Installed" is from the git history of the installed commit `09126560` (which version first held the merge). "Switch" names the settings-file key and its built-in default; your `CD_Settings.json` holds no value for any of these keys, so the default applies (I read the file; I did not see CE read it). "Steps to confirm" is quoted from the bug entry; where the entry has none, I say so and quote the fix report instead.

## A. Bugs with a fix built (28), most severe first

1. **BUG-1135: an older CE silently deletes newer parts of the job record (for example an ignored check comes back after a colleague saves on an older build).**
   1. **Severity:** HIGH, DATA LOSS.
   2. **Fix:** PR #1747. Installed in Civil 3.0.74 (C-64).
   3. **Switch:** none.
   4. **Robot case:** needs a case, and the case needs two CE builds and a save and reopen, which the runner forbids. Only builds from 3.0.74 on keep the newer parts, so the full check waits until a build newer than 3.0.85 exists.
   5. **Status:** NEEDS CASE (older or newer build plus save; not possible on your PC today).
   6. **Steps to confirm:** "on a test copy ignore a CDCHECKS finding on 3.0.72, save, open and save from the older 3.0.6x build, reopen on 3.0.72. Right looks like: the ignored finding is still ignored."

2. **BUG-1196: after Edit Pit, the drawn Pit Schedule depth and the "With Step Irons" note change when the pit has a lower second outgoing pipe (P2 drops from 1.10 to 0.80).**
   1. **Severity:** HIGH, WRONG ANSWER.
   2. **Fix:** PR #1760. Installed in Civil 3.0.75 (C-65).
   3. **Switch:** `linking.pitScheduleRefreshCountsAllConnectedPipes`, default ON.
   4. **Robot case:** needs a case. Blocked twice: the Edit Pit "Edit pit, Save" button is not on the robot's press list, and the robot reads the Pit Schedule window grid but not a drawn schedule on the sheet. Needs a reviewed allow-list change and a test drawing with a placed schedule and the P2, P3, P4 layout.
   5. **Status:** NEEDS CASE (test drawing plus a reviewed allow-list change).
   6. **Steps to confirm:** "PITSCHEDULE read P2, PITEDIT P2 length, read the drawn cells, reopen PITSCHEDULE. Right looks like: 1.10 m and "With Step Irons" in both."

3. **BUG-1190: survey levels inside a nested block in a turned survey Xref land in the wrong place, so New Pit offers the wrong level.**
   1. **Severity:** HIGH, WRONG ANSWER.
   2. **Fix:** PR #1755. Installed in Civil 3.0.75 (C-65).
   3. **Switch:** `survey.nestedSurveyBlocksKeepTheirPlace`, default ON.
   4. **Robot case:** needs a case and a test drawing: no survey Xref drawing exists in `C:\ce_rc_drv` (R26 says the same). The fix report names the drawing to make: `RD15_NESTED.dwg`, block `RD15_LEVEL` with TEXT 12.000, a loose TEXT 15.000, attached rotated 90 degrees.
   5. **Status:** NEEDS CASE (test drawing).
   6. **Steps to confirm:** "CDSURVEY the rotated Xref, approve, PIT at 0,10,0. Right looks like: New Pit offers 12.00 at zero distance."

4. **BUG-1188: a LandXML pipe with no grade is labelled with an invented "AT 1 IN 100".**
   1. **Severity:** HIGH, WRONG ANSWER.
   2. **Fix:** PR #1773. Installed in Civil 3.0.76 (C-66).
   3. **Switch:** `xcivilImport.importedPipeNoInventedGrade`, default ON.
   4. **Robot case:** needs a case. The robot can press Read source and Import to drawing, but "Choose LandXML" opens a file chooser it cannot type into from a case, and no `RD15_GRADE.xml` test file exists.
   5. **Status:** NEEDS CASE (test file plus a reviewed file-chooser step).
   6. **Steps to confirm:** "CDIMPORTLANDXML on RD15_GRADE.xml, Read source, Import to drawing. Right looks like: no invented grade and the review shows grade as Unknown."

5. **BUG-1137: on AutoCAD 2022 to 2024, one downpipe in a COPY cancels the clean-up for every pit and pipe copied with it.**
   1. **Severity:** HIGH, DATA LOSS (AutoCAD 2022 to 2024 only).
   2. **Fix:** PR #1778. Installed in Civil 3.0.76 (C-66).
   3. **Switch:** `linking.copyContinuesWhenDownpipeCannotFollow`, default ON.
   4. **Robot case:** needs a case on AutoCAD 2024. On your 2027 the change shows nothing.
   5. **Status:** NEEDS CASE (older AutoCAD).
   6. **Steps to confirm:** "AutoCAD 2024 test copy, COPY P1-P6, their pipes and DP1 together. Right looks like: each copy gets a new pit number and schedule row."

6. **BUG-540: the step-iron depth is read from two places that can disagree (Pit Schedule and pit set-up advice).**
   1. **Severity:** MEDIUM-HIGH, WRONG ANSWER.
   2. **Fix:** already on the base before the triage (batch 2 report: the window, the after-command refresh and the pit advice all read the Settings step-iron depth). The old PR #1192 was rejected.
   3. **Switch:** none found for this part.
   4. **Robot case:** needs a case. The Pit Schedule cells the robot reads stop at the Depth column and do not include the remarks where "With Step Irons" sits (seen in run `RUN-20261029-0624-C3.0.85-bX6`), so a probe of the remarks cell must come first.
   5. **Status:** NEEDS CASE (probe of the remarks cell first).
   6. **Steps to confirm:** the entry has no "Steps to confirm" line. Its own example: change the Settings step-iron depth to 1000; a 0.95 m pit must no longer say "With Step Irons" anywhere.

7. **BUG-905: CDCALC Boyd's tab and CDDESIGN use different hard-ground C, so one job gets two storage figures.**
   1. **Severity:** MEDIUM, WRONG ANSWER.
   2. **Fix:** built on the base by HUNT2-C-06 (batch 4 report). Installed but switched OFF.
   3. **Switch:** `detention.boydsUsesHardGroundC`, default **OFF** in the installed code ("until Tim confirms the figure"). A case would have to turn it ON through the settings guard.
   4. **Robot case:** none; needs your figure first, then a Codex look (CDCALC window).
   5. **Status:** NEEDS TIM (confirm 0.9 or give the figure).
   6. **Steps to confirm:** the entry has no "Steps to confirm" line.

8. **BUG-1138: on a PC without the CE pipe add-on, CDSYNC and every relink empty all pits' pipe lists.**
   1. **Severity:** MEDIUM, DATA LOSS.
   2. **Fix:** PR #1748. Installed in Civil 3.0.75 (C-65).
   3. **Switch:** none.
   4. **Robot case:** needs a PC without the add-on. On your PC CDSYNC completes normally; R13 and N26 show that, which is not proof of this fix.
   5. **Status:** NEEDS CASE (another PC).
   6. **Steps to confirm:** "open a 3.0.72 drawing with CE pipe objects on a PC without the enabler and run CDSYNC. Right looks like: a refusal naming the pipes it cannot handle."

9. **BUG-1150: a network pasted into a new drawing goes quiet after save and reopen: pits move without their pipes.**
   1. **Severity:** MEDIUM, DATA LOSS.
   2. **Fix:** PR #1758. Installed in Civil 3.0.75 (C-65).
   3. **Switch:** `linking.civilWakesForPitsWithoutRecord`, default ON.
   4. **Robot case:** needs a case. The robot never saves; the fix needs a drawing that was pasted into and saved without CDREPAIR. Recommended: Codex makes that drawing once as a robot test drawing; then the robot only has to MOVE a pit and read the pipe ends.
   5. **Status:** NEEDS CASE (test drawing).
   6. **Steps to confirm:** "paste a network into a new drawing, save, close, reopen, MOVE a pit. Right looks like: pipes and labels follow."

10. **BUG-1142: one unreadable pit record stops new pipes linking to any pit, while the pipe looks saved.**
    1. **Severity:** MEDIUM, DATA LOSS.
    2. **Fix:** PR #1752. Installed in Civil 3.0.75 (C-65).
    3. **Switch:** none (OFF would only bring back the stop).
    4. **Robot case:** needs a test drawing with one pit's link record damaged. None exists.
    5. **Status:** NEEDS CASE (test drawing).
    6. **Steps to confirm:** "test copy with one damaged pit record, draw a pipe between two good pits, move one pit. Right looks like: the pipe follows."

11. **BUG-1097: the 300 mm minimum head on a charged downpipe system is never checked.**
    1. **Severity:** HIGH (partial fix).
    2. **Fix:** PR #1772. Installed in Civil 3.0.76 (C-66). Warns on the head you type; the CDRULES line and the Settings box are not done.
    3. **Switch:** `detention.chargedMinHeadWarning`, default ON.
    4. **Robot case:** none possible: the CDCALC window is not on the robot's read list and the robot cannot change tabs. A Codex look can read the warning.
    5. **Status:** NEEDS TIM (which head the rule means: open call in the readiness report, PR #1772), then NEEDS LOOK.
    6. **Steps to confirm:** "CDCALC, Charged System, enter an available head of 250 mm. Right looks like: a warning that the head is under 300 mm."

12. **BUG-1140: a pasted downpipe keeps a link to the original's label, so MOVE or CDREPAIR moves or takes the wrong label.**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1763. Installed in Civil 3.0.75 (C-65).
    3. **Switch:** `linking.sourceLabelOwnerCheck`, default ON.
    4. **Robot case:** draft **P02** (`drafts_pilot_29oct\P02_pasted_downpipe_leaves_original_label.case.txt`), twin `P02_BROKEN` with the switch OFF. Covers the MOVE half only: CDREPAIR opens a window the robot cannot drive. Not run, not reviewed.
    5. **Status:** CASE READY (draft, MOVE half).
    6. **Steps to confirm:** "test copy: Ctrl+C / Ctrl+V DP1, run CDREPAIR. Right looks like: DP1's label stays with the original."

13. **BUG-1194: CDTEXTSEG puts the pipe label on the leg round the corner, not the leg you clicked.**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1757. Installed in Civil 3.0.75 (C-65).
    3. **Switch:** `linking.pipeTextFollowsClickedLeg`, default ON.
    4. **Robot case:** draft **P01** (`drafts_pilot_29oct\P01_cdtextseg_label_goes_to_clicked_leg.case.txt`), twin `P01_BROKEN` with the switch OFF. It proves WHICH leg by coordinates (the two legs are about 10 m apart in the test); how the label looks stays a Codex look. Not run, not reviewed.
    5. **Status:** CASE READY (draft).
    6. **Steps to confirm:** "CDTEXTSEG on that pipe, enter 19000,0. Right looks like: the label sits beside the first horizontal leg, parallel to it."

14. **BUG-1145: an Xref'd Pit Schedule says OUT OF DATE and fails Project QA when nothing on it changed.**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1765. Installed in Civil 3.0.75 (C-65).
    3. **Switch:** `linking.pitScheduleFingerprintScopedToSchedule`, default ON.
    4. **Robot case:** needs a stage drawing Xref'd into a sheet with a placed schedule, and a save of the stage drawing between reads. Neither exists for the robot.
    5. **Status:** NEEDS CASE (two linked test drawings; the save step is a Codex job).
    6. **Steps to confirm:** "stage drawing Xref'd into a sheet with a placed schedule; ignore a CDCHECKS finding in the stage drawing; reload the sheet. Right looks like: the schedule is still "up to date"."

15. **BUG-1198: Cancel on a Pit Schedule export still writes into the drawing, so CLOSE asks "Save changes?".**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1764. Installed in Civil 3.0.75 (C-65).
    3. **Switch:** `linking.pitScheduleExportWritesNothing`, default ON.
    4. **Robot case:** none possible: every "Export" button is on the robot's never-press list. Codex can do it on a copy.
    5. **Status:** NEEDS LOOK.
    6. **Steps to confirm:** "PITSCHEDULE, Export CSV, Cancel, close the schedule, CLOSE. Right looks like: no "Save changes?" question."

16. **BUG-1049: in the CDEDIT batch window, one ticked but blank field greys out Apply for the whole batch.**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1743. Installed in Civil 3.0.77 (C-67).
    3. **Switch:** `linking.batchBlankFieldIsLeftOut`, default ON.
    4. **Robot case:** needs a case and a reviewed allow-list change: the batch window is titled "Edit 2 Pipes", which no read pattern matches, and "Apply to Selected" is not pressable (spec B3 section B). The result (both pipes 375, materials kept) is a drawing value, so the robot is the right tester once allowed.
    5. **Status:** NEEDS CASE (allow-list change).
    6. **Steps to confirm:** "select two 300 mm pipes with different materials, CDEDIT, tick Diameter 375, tick Material and leave it empty. Right looks like: Apply works, both pipes 375, each keeps its material."

17. **BUG-1106: a STORM report naming a two-word council (Glen Eira, Yarra Ranges) sets a council CE cannot find.**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1761. Installed in Civil 3.0.75 (C-65).
    3. **Switch:** none.
    4. **Robot case:** none: the council shows in the CDDESIGN window, which the robot cannot read, and a test STORM report is needed.
    5. **Status:** NEEDS LOOK (Codex, with a test STORM report).
    6. **Steps to confirm:** "CDDESIGN, offer a rating report naming Glen Eira. Right looks like: the design shows Glen Eira as the council, no "council outstanding" line."

18. **BUG-1101: CDCALC Catchments opens with a made-up 500 m2 catchment and a 15-minute storm.**
    1. **Severity:** MEDIUM (partial fix: a row added with Add still carries 500 m2 and C 0.9).
    2. **Fix:** PR #1770. Installed in Civil 3.0.76 (C-66).
    3. **Switch:** `detention.catchmentsStartBlank`, default ON.
    4. **Robot case:** none: CDCALC window not readable by the robot, and the robot cannot open the Catchments tab.
    5. **Status:** NEEDS LOOK.
    6. **Steps to confirm:** "CDCALC on a new job, Catchments. Right looks like: an empty list, storm duration equal to the Settings Tc."

19. **BUG-1206: when Manager loads before Civil, the CE Tools tab is missing.**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1750. Installed in Manager 1.1.74 / Civil 3.0.74 (C-64).
    3. **Switch:** none.
    4. **Robot case:** none: the robot cannot choose the load order (NETLOAD is forbidden in cases) and a ribbon tab is a look.
    5. **Status:** NEEDS LOOK (Codex, on a copy of the bundles, not your live ones).
    6. **Steps to confirm:** "NETLOAD Manager's DLL, then Civil's, look at the ribbon. Right looks like: CE Tools present as in the Civil-first order."

20. **BUG-1165: an old Civil bundle in the all-users plug-ins folder supplies the pit blocks first.**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1751. Installed in Civil 3.0.74 (C-64).
    3. **Switch:** `pits.blocksFromRunningBundleFirst`, default ON.
    4. **Robot case:** needs a marked old block in `C:\ProgramData\...\CE_CVL_SUITE.bundle` (administrator rights). Not to be done on your live PC by the robot; a spare PC or the hand-install rehearsal.
    5. **Status:** NEEDS CASE (spare PC, administrator).
    6. **Steps to confirm:** "test PC with a marked old block in a fake all-users bundle and the new blocks in %APPDATA%; type PIT. Right looks like: the 3.0.72 pit block, not the old one."

21. **BUG-1167: copying your settings file to a colleague carries your own office-folder paths.**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1754. Installed in Civil 3.0.74 (C-64).
    3. **Switch:** `linking.otherUsersFoldersFollowThisPc`, default ON.
    4. **Robot case:** needs a second Windows login.
    5. **Status:** NEEDS CASE (spare login).
    6. **Steps to confirm:** "export the colleague defaults and read the file. Right looks like: folder paths blank or relative." (The fix report's own check: on a second login, copy your CD_Settings.json in and check CDWT, CDNEWDWG and the Drawing Templates folder point at that login.)

22. **BUG-1215: Feedback Help promises a "Save report" step that does not exist.**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1768. Installed in Civil 3.0.76 (C-66).
    3. **Switch:** none (wording).
    4. **Robot case:** none: the Help window is not readable by the robot.
    5. **Status:** NEEDS LOOK.
    6. **Steps to confirm:** "CDHELP, search CDFEEDBACK, read Feedback. Right looks like: it describes Send report."

23. **BUG-1179: a damaged office approval file can still show "CE is current.".**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1769. Installed in Manager 1.1.76 (C-66).
    3. **Switch:** none.
    4. **Robot case:** needs a spare profile: the check writes a broken `approved.json` into the office releases folder, which must never happen on your live set-up.
    5. **Status:** NEEDS CASE (spare login).
    6. **Steps to confirm:** "as the test above on a disposable profile. Right looks like: the tooltip says Civil's approval could not be checked."

24. **BUG-1180: Drawing Repair says "Nothing has been changed" after a successful repair.**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1774. Installed in Manager 1.1.76 (C-66).
    3. **Switch:** none (wording).
    4. **Robot case:** none: the CEMANAGER window is not on the robot's lists. Codex, on a drawing with one missing label owner record.
    5. **Status:** NEEDS LOOK.
    6. **Steps to confirm:** "CEMANAGER, Drawing Repair, Civil, Inspect, Fix it on a drawing with one missing label owner record. Right looks like: no "Nothing has been changed" after the fix."

25. **BUG-1168: the job-time folder is fixed on the first AutoCAD start and never looked for again.**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1775. Installed in Civil 3.0.76 (C-66).
    3. **Switch:** `jobTime.detectDataFolderEachStart`, default ON.
    4. **Robot case:** needs a test profile with the office Drafting folder missing, then added.
    5. **Status:** NEEDS CASE (spare login).
    6. **Steps to confirm:** "start AutoCAD on a test profile with the folder missing, then add it and restart. Right looks like: time logs in the office folder."

26. **BUG-1202: the weekly time export runs on AutoCAD's start-up and holds it up.**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1776. Installed in Civil 3.0.76 (C-66).
    3. **Switch:** `jobTime.weeklyExportInBackground`, default ON.
    4. **Robot case:** needs a test profile with a prepared time-log folder; the robot's log offset starts after start-up, so it cannot time start-up. The entry's own step types LISP, which cases forbid.
    5. **Status:** NEEDS CASE (spare login).
    6. **Steps to confirm:** "start AutoCAD on a blank drawing with that folder, then type `(princ "\nRD19-01 READY")`. Right looks like: READY appears without waiting for the export."

27. **BUG-1151: on AutoCAD 2022 to 2024 without the add-on, moving a pit leaves CE pipe ends behind with no message.**
    1. **Severity:** MEDIUM.
    2. **Fix:** PR #1777. Installed in Civil 3.0.76 (C-66).
    3. **Switch:** none.
    4. **Robot case:** needs AutoCAD 2024 without the add-on.
    5. **Status:** NEEDS CASE (older AutoCAD).
    6. **Steps to confirm:** "AutoCAD 2024 without the enabler, MOVE a pit with a CE pipe object. Right looks like: a line naming the pipe that did not follow."

28. **BUG-1173: the colleague pack's backup step saved only 2 of the CE settings folders.**
    1. **Severity:** LOW.
    2. **Fix:** document fix in colleague pack page 02 (batch 4), no PR, nothing to install.
    3. **Switch:** none.
    4. **Robot case:** none: the check is a rollback rehearsal on a spare login.
    5. **Status:** NEEDS CASE (spare login rehearsal).
    6. **Steps to confirm:** "rollback rehearsal on a spare login; open AutoCAD. Right looks like: no CE Manager menu and no leftover folders."

## B. Bugs with no installed fix (32), most severe first, and what each is waiting for

29. **BUG-1189: approved survey levels stay in use after the survey Xref is moved.**
    1. **Severity:** HIGH, WRONG ANSWER.
    2. **Fix:** built in PR #1756, **not installed**: held out of every train (C-65 to C-75) waiting for your question "survey Xref detached after approval".
    3. **Switch (when installed):** `survey.storedLevelsFollowXrefPosition`, ON (not in the installed code).
    4. **Waiting for:** your answer, then a train, then a survey test drawing (as BUG-1190).
    5. **Status:** NO FIX (built, not installed).
    6. **Steps to confirm:** "as the test. Right looks like: the survey is marked as needing a reread; after re-approving, the offer is 12.00."

30. **BUG-1192: the long section drops survey levels more than 1.20 m from the cover line, hiding a depression.**
    1. **Severity:** HIGH, WRONG ANSWER.
    2. **Waiting for:** your design word on how an unsupported stretch is shown (batch 3 recommends a warning line first, nothing redrawn).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** "CDPROFILE with datum 8.00 / H100 / V10, Preview New, Apply, inspect the 70CONT polyline. Right looks like: a disclosed unresolved surface or an independently justified one."

31. **BUG-1088: the automatic pipe sizer picks the smallest pipe at any grade, up to 1 in 1.**
    1. **Severity:** HIGH, WRONG ANSWER.
    2. **Waiting for:** your number (the steepest grade CE may choose; batch 3 recommends a cap such as 1 in 20 and flattest grade first).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** "CDDESIGN on a test copy with a 40 L/s connection pipe. Right looks like: a DN225 or larger pipe at a sensible grade (about 1 in 200), not DN100 at 1 in 3."

32. **BUG-1095: the council minimum after-development C (Darebin, Maribyrnong, Boroondara) is never applied.**
    1. **Severity:** HIGH, WRONG ANSWER.
    2. **Waiting for:** your engineering word (open questions C16, C19).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** "CDDESIGN on a Darebin-profile test copy with that lot. Right looks like: C 0.80 on the computations sheet with a "council minimum governs" note."

33. **BUG-1099: Maroondah and Yarra Ranges' own before-development C and Tc table are stored but never used.**
    1. **Severity:** HIGH, WRONG ANSWER.
    2. **Waiting for:** your engineering word (open question C17).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** "CDDESIGN on a Maroondah test copy, 600 m2 bare lot, 1-in-5. Right looks like: PSD 3.68 L/s."

34. **BUG-866: CDDESIGN says the office rainfall curve reads "7 to 9 per cent high".**
    1. **Severity:** HIGH, WRONG ANSWER (your word).
    2. **Waiting for:** your check of the curve ("leave them until you've checked the curve").
    3. **Status:** NO FIX. (The installed commits named "BUG-866" are a different bug, CDCHECKIGNORE Undo; the number needs splitting.)
    4. **Steps to confirm:** the entry has no "Steps to confirm" line.

35. **BUG-1053: LandXML cover and invert levels in millimetres are not converted to metres.**
    1. **Severity:** HIGH, WRONG ANSWER.
    2. **Fix:** built in PR #1716 (HOLD) and #1727 (unreviewed); **not installed** (no RD04-03 or BUG-1053 commit on `09126560`).
    3. **Waiting for:** an Opus review and a train; then a LandXML test file (as BUG-1188).
    4. **Status:** NO FIX (built, not installed).
    5. **Steps to confirm:** "make UNIT-RL-MM.xml (one grated pit P1, elevRim="100200", Invert elev="100000", mm units) in a fresh empty INSUNITS 4 drawing. CDIMPORTLANDXML, Choose LandXML, Read source. Right looks like: "cover level 100.200 m". Import only on the disposable copy and read P1's cover (100.2). Repeat with a metre file and in an INSUNITS 6 target; covers must match."

36. **BUG-1052: CDAGI and CDPERIMETER pass a flat drain in a metre drawing.**
    1. **Severity:** HIGH, WRONG ANSWER (metre drawings).
    2. **Fix:** built in PR #1716 (HOLD) and #1727; **not installed**.
    3. **Waiting for:** an Opus review and a train; the metre test drawings `DRV15_METRE`, `DRV24_METRE` and `DRV26_METRE` exist and could carry the case.
    4. **Status:** NO FIX (built, not installed).
    5. **Steps to confirm:** "empty synthetic INSUNITS 6 drawing with Settings AG minimum grade 1 in 100. CDAGI, Enter for None, pick 0,0 then 10,0, Enter, Enter to skip outlet, start invert 10.001, end invert 10.000, read the Preview line before Accept. Right looks like: "1:10000" and "below the office minimum". Repeat with CDPERIMETER, and with a 0.5 m run (it must still ask for levels). Cancel the previews."

37. **BUG-685: CD "work it out from the grade" rounds the level you typed (10.125 becomes 10.13).**
    1. **Severity:** MEDIUM, WRONG ANSWER.
    2. **Waiting for:** your ruling between "a typed level is never moved" and "inverts to 2 dp".
    3. **Status:** NO FIX.
    4. **Steps to confirm:** the entry has no "Steps to confirm" line.

38. **BUG-1148: pasting a pit from a Save As sister drawing gives it this drawing's pit values.**
    1. **Severity:** MEDIUM, WRONG ANSWER.
    2. **Waiting for:** your design word (batch 2 recommends a "made in this drawing" stamp that Save As renews; needs a workflow card).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** "Save As Stage 1 to Stage 2, change P4 in Stage 2, copy it into Stage 1. Right looks like: the pasted pit carries Stage 2's values."

39. **BUG-1091: redesign and auto-design drop the minimum grade for DN450 and larger.**
    1. **Severity:** MEDIUM, WRONG ANSWER.
    2. **Waiting for:** your word (the code itself lists it "for Tim"; batch 3 recommends using the whole Settings grade ladder).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** "network redesign preview with preserve-existing-sizes on a DN450 pipe carrying 30 L/s. Right looks like: grade 1 in 200, not 1 in 1,500."

40. **BUG-901: cover is measured to the inside top of the pipe, so it reads high by the wall thickness.**
    1. **Severity:** MEDIUM, WRONG ANSWER.
    2. **Waiting for:** your wall thicknesses. You ruled yes today to measuring to the outside; the readiness report says CE 01 has queued it, not built.
    3. **Status:** NO FIX.
    4. **Steps to confirm:** the entry has no "Steps to confirm" line.

41. **BUG-907: the pit drop where the pipe gets bigger compares inverts only (a 150 in, 300 out can pass).**
    1. **Severity:** MEDIUM, WRONG ANSWER.
    2. **Waiting for:** the build. You ruled yes today for a warning; queued by CE 01, not built.
    3. **Status:** NO FIX.
    4. **Steps to confirm:** the entry has no "Steps to confirm" line.

42. **BUG-1096: the rainwater-tank reuse credit never runs on a real job.**
    1. **Severity:** HIGH.
    2. **Waiting for:** your window and engineering word (three new CDDESIGN fields; BUG-1098 must be fixed with it).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** "CDDESIGN on a Manningham test copy with a 3,000 L reuse tank. Right looks like: credit 1.50 m3, net 8.50 m3."

43. **BUG-1209: on AutoCAD 2022 to 2024 a downpipe cannot be placed directly on a pit.**
    1. **Severity:** HIGH (older AutoCAD only).
    2. **Waiting for:** Max's AutoCAD year, then your word on the fix route (protected area).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** "as the test, one year at a time. Right looks like: joined placement on every supported year."

44. **BUG-1090: nothing says the hydraulic grade line and pit losses were not checked (the sheet goes to council).**
    1. **Severity:** MEDIUM.
    2. **Fix:** built in PR #1771, **not installed**. You said "do as you recommend" today; it needs a rebase, a review and a train.
    3. **Switch (when installed):** none.
    4. **Waiting for:** the train. Then a robot case is possible (CDRULES prints its list on the command line).
    5. **Status:** NO FIX (built, not installed).
    6. **Steps to confirm:** "CDRULES on a Frankston [profile] test copy. Right looks like: a line saying the HGL is not calculated."

45. **BUG-1149: after BIND of a CE Xref, the schedule says SOURCE MISSING and QA fails for good.**
    1. **Severity:** MEDIUM.
    2. **Fix:** built in PR #1767, **not installed**: held for your question "stage drawing BIND versus detach".
    3. **Waiting for:** your answer, then a train.
    4. **Status:** NO FIX (built, not installed).
    5. **Steps to confirm:** "sheet with a placed schedule from an Xref'd stage drawing; XREF BIND the stage; reopen Pit Schedule. Right looks like: "source bound" and QA passes."

46. **BUG-902: cover is checked only at the two pits, not under a lower garden bed between them.**
    1. **Severity:** MEDIUM.
    2. **Waiting for:** your word (batch 4 recommends an "Unknown: cover between pits not checked" note first).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** the entry has no "Steps to confirm" line.

47. **BUG-903: different screens judge one pipe against different minimum grades and cover.**
    1. **Severity:** MEDIUM.
    2. **Waiting for:** your confirmation of the grade ladder values.
    3. **Status:** NO FIX.
    4. **Steps to confirm:** the entry has no "Steps to confirm" line.

48. **BUG-1166: Civil and Manager look for the office folders in different places.**
    1. **Severity:** MEDIUM.
    2. **Waiting for:** a fact from Max's PC (where "Creative Engineering - Drafting" lands) and your OK to change the protected shared file.
    3. **Status:** NO FIX.
    4. **Steps to confirm:** "test profile with the office folders only under an "OneDrive - ..." path; CDFEEDBACK and open CE Blocks. Right looks like: report reaches the office folder and the palette opens."

49. **BUG-1169: Max's old July Structural may load an older shared file with the same version number.**
    1. **Severity:** MEDIUM, UNSURE.
    2. **Waiting for:** a check of Max's Structural bundle before 9 Nov (a release check, not code).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** "on a spare PC install the July Structural then the 3.0.72 pair; type CDHELP and CD_LINETYPE-using commands. Right looks like: no "command failed" lines."

50. **BUG-1170: going back restores an old Manager that may stage updates by itself.**
    1. **Severity:** MEDIUM, UNSURE.
    2. **Waiting for:** Max's current Manager version and a rollback rehearsal on a spare login (a release check, not code).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** "rehearse the rollback on a spare standard login, restart AutoCAD twice, list ProgramData. Right looks like: nothing new in ProgramData."

51. **BUG-1210: on AutoCAD 2022 to 2024, Edit Pipe and Edit Pit lose the plan picture.**
    1. **Severity:** MEDIUM (older AutoCAD only).
    2. **Waiting for:** Max's AutoCAD year and your choice (port the picture, or say "needs AutoCAD 2027" on the window).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** "PIPEEDIT the bent pipe, then PITEDIT P1 and click a pipe tag, on 2024 and 2027. Right looks like: the real route and clickable picture on both."

52. **BUG-1031: the Pit Schedule cell right-click menu has no "Delete cell".**
    1. **Severity:** MEDIUM.
    2. **Waiting for:** a desk and window-lane decision (the handler exists; nothing calls it).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** the entry has no "Steps to confirm" line.

53. **BUG-587: drawn Pit Schedule remarks cross the row lines on the issued sheet.**
    1. **Severity:** MEDIUM.
    2. **Waiting for:** your word that rows may grow taller only when a remark needs a third line (batch 2 option C).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** the entry has no "Steps to confirm" line; its "Test/retest" asks for two adjacent pits with a short custom multi-line note, update and fresh placement, text extents inside each row.

54. **BUG-648: the AG drain grade is checked but never labelled.**
    1. **Severity:** MEDIUM.
    2. **Waiting for:** your word on the wording, layer and height of a new drawn label (FB-18).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** the entry has no "Steps to confirm" line; its "Guard / confirmation" asks for the plan to show the 1:50 grade on the run, with no duplicate after edit, Undo, Redo or save and reopen.

55. **BUG-865: every double-click on a block scans every block (slow in survey drawings).**
    1. **Severity:** LOW-MEDIUM.
    2. **Waiting for:** a measurement first (Codex: time a double-click in a survey drawing).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** the entry has no "Steps to confirm" line.

56. **BUG-816: a "no clear spot" line prints after MOVE even with Tidy labels off.**
    1. **Severity:** LOW-MEDIUM.
    2. **Waiting for:** your Settings decision (give the after-MOVE tidy its own named switch).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** the entry has no "Steps to confirm" line.

57. **BUG-525: the other blues (windows, ribbon icons, Help).**
    1. **Severity:** LOW-MEDIUM.
    2. **Waiting for:** your colour word from a picture; touches the protected shared code.
    3. **Status:** NO FIX.
    4. **Steps to confirm:** the entry has no "Steps to confirm" line.

58. **BUG-1171: Civil's reports to you never arrive and pile up on a colleague's PC.**
    1. **Severity:** LOW.
    2. **Waiting for:** your OK to change the protected shared file, or a privacy ruling.
    3. **Status:** NO FIX.
    4. **Steps to confirm:** "trigger a Civil failure record on a test profile and list both outbox folders. Right looks like: one folder only."

59. **BUG-857: in the Grade mismatch box, the corner X still places the pipe.**
    1. **Severity:** LOW.
    2. **Waiting for:** your call (should X cancel, or should the box say what X does).
    3. **Status:** NO FIX.
    4. **Steps to confirm:** the entry has no "Steps to confirm" line.

60. **BUG-855: the Pit Schedule "data issues" count goes up by one after the first CDSYNC.**
    1. **Severity:** LOW.
    2. **Waiting for:** a robot probe to name the cause (batch 2 gives the steps: save the "Drawing check" details before and after CDSYNC and compare). N26 and R13 run CDSYNC but do not read the header.
    3. **Status:** NO FIX (cause not pinned; may be by design).
    4. **Steps to confirm:** the entry has no "Steps to confirm" line.

---

# C. What would unlock the 18 "needs a case" (for the desk)

1. **Test drawings on your PC (no runner change):** a pasted-and-saved network without CDREPAIR (BUG-1150); one pit with a damaged link record (BUG-1142); a survey Xref with a nested rotated block (BUG-1190, later BUG-1189); a stage drawing Xref'd into a sheet with a placed schedule (BUG-1145). Codex can make these once, on copies.
2. **Small reviewed runner changes:** the Edit Pit "Edit pit, Save" press and a drawn-schedule read (BUG-1196); the "Edit 2 Pipes" window read and "Apply to Selected" press (BUG-1049); a file-chooser path step for LandXML (BUG-1188); the Pit Schedule remarks cell (BUG-540). Each is a pinned allow-list edit that needs its own review.
3. **A spare Windows login or second PC:** BUG-1135, BUG-1138, BUG-1165, BUG-1167, BUG-1168, BUG-1173, BUG-1179, BUG-1202; AutoCAD 2024 for BUG-1137 and BUG-1151. These line up with the hand-install rehearsal the gap plan already needs.

---

# D. Run order for the robot (task 3)

To be filled once the drafts pass the format check (section E).

---

# E. Draft cases written today

To be filled after task 2.

---

# What I did NOT verify (RULES 5.9)

1. **Installed versions** are from git ancestry on `09126560`, not from the DLL product-version strings on your PC.
2. **Switch values:** your `CD_Settings.json` has no entry for any of these keys, so the built-in default applies; I did not see CE read the file.
3. **Nothing was run.** No AutoCAD, no runner, no Codex.
4. **The readiness report's own times** (11:10 to 12:00) are later than this PC's clock when I read it (10:40 Melbourne); its content is unaffected.
