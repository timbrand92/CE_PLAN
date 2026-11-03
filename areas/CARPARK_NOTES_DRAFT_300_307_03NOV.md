# CARPARK NOTE DRAFTS, fix jobs 300 to 307 (drafted Tue 3 Nov 2026, CE 05 desk, read-only job)

## FOR TIM

1. **Nothing here is fixed.** Six fixes are written and unit-tested. None is installed. Nobody has opened any of them in AutoCAD. No bug can be marked fixed from this.
2. **Five draft PRs are open and waiting:** #1995 (BUG-1053), #1996 (BUG-1042), #1997 (BUG-027), #1998 (BUG-1166), #1999 (BUG-900). All five are drafts on the 2 Nov line.
3. **BUG-1052 has no PR.** The fix is saved on this PC only (commit 6b26e852). It is held because your real AutoCAD data folders changed during its test window. CE 01 must confirm that was another job, then push.
4. **BUG-1173 needs no code.** Page 02 of the colleague pack already lists all five folders and the MENULOAD step. It stays open until the rollback is rehearsed on a spare login.
5. **BUG-396 is not built.** It needs a command card first and a window change (Codex's). Two questions for you, in the notes below.
6. **A flag for CE 01, from every job:** in five of the eight reports the before and after listings of your AutoCAD data folders differed. `CD_Settings.json` is the one to look at first (it went back to a 4 Oct date; 1053, 1042 and 027 all saw it). Every job says it was probably another AutoCAD session, and none can prove it.
7. **I checked the build position myself after a fresh fetch.** None of the six fixes is in the installed Civil 3.0.89 (61fd6fbc), in candidate b1 (3.0.90, cf059dcf) or in b2 (3.0.91, aa3b92ac). The faults are still there in b2.
8. **Not proven by me:** I built nothing, tested nothing, ran no AutoCAD. I read the eight reports and checked the git position only.

---

## WHAT I READ AND CHECKED

1. **Read:** the eight reports `BUGFIX_w1052`, `w1053`, `w1042`, `w027`, `w1173`, `w1166`, `w900`, `w396` (all `_REPORT_03NOV.md`), `BRIEF_W396_DOUBLECLICK_02NOV.md` (section 5), and the last two notes in `BUG_CARPARK.md`.
2. **Fetched first:** `git fetch origin` ran before every claim. Tips seen: rel-20261102a = 3fbb9da5, rel-20261108a = cf059dcf (Civil 3.0.90, b1), rel-20261110a = aa3b92ac (Civil 3.0.91, b2).
3. **Ancestry, checked with `git merge-base --is-ancestor`:**
   1. The five PR heads (26afae19, 6e3b64df, 352a838b, 6f5a80d9, 3a6a0b80) and the BUG-1052 commit 6b26e852: not in 61fd6fbc, not in b1, not in b2, not in the 2 Nov line.
   2. 61fd6fbc is not in the 2 Nov line (3fbb9da5), so the PRs were built on a base without the 3.0.89 version commit. It is in b1 and b2. This does not change whether the fixes are in; it matters for the finalizer merge.
4. **Faults still present in b2 (read from the files at aa3b92ac):** AgiCommand.cs still names the drawn length `runLengthMm` with no conversion (BUG-1052); LandXmlParser.cs has no level conversion (BUG-1053); PitStartReadiness.cs still returns "Enter the cover level." (BUG-1042); CdCommand.Grade.cs still has the MIN. suffix code (BUG-027); Extract-XcivilPdfSchedule.ps1 has no all-pages switch (BUG-900); DoubleClickEditTable.cs still lists the Pit Schedule as "no window" (BUG-396).
5. **PR state, read from GitHub:** all five are OPEN and DRAFT, base `claude/rel-20261102a`.
6. **Output path:** your order wrote `C:\CE_PLANreas\...`. I took that as `C:\CE_PLAN\areas\` (a lost backslash) and wrote there.

---

## THE NOTE LINES (copy under each bug in BUG_CARPARK.md)

**BUG-1052 (CDAGI and CDPERIMETER grade in a metre drawing)**

- Note (CE 05, Tue 3 Nov 2026, fix job B-171 / w1052): fix written and unit-tested, NO PR, HELD. **Built:** net10 and net48 compile, 0 errors (commit 6b26e852, local branch `w1052-bug1052-agi-units`, based on rel-20261102a, not pushed). **Tested:** 54 of 54 pass on net10 (count above zero); 12 net48 tests fail because the AutoCAD geometry library will not run outside AutoCAD, and the existing TotalRunLength test fails the same way, so they are not from this change (my own check: the report says so; I did not re-run). **Installed:** no; not in 61fd6fbc, b1 or b2 (checked after fetch). **Accepted:** no; nobody has opened it in AutoCAD. **Held on the isolation rule:** the before and after listings of the real AutoCAD data folders differ by 90 lines (Manager menu file, Civil suggestions ledger, native_grip_2027.log, sessions, about 80 usage events, files changed 17:21 to 17:48 UTC on 2 Nov, one burst at 17:48:55 inside the test window). Probably another job's AutoCAD session, not proven. CE 01 to confirm, then push and open the draft PR. Switch `surface.agiGradeUsesDrawingUnits`, ON. What Tim will see: a 10 m drain from RL 10.001 to 10.000 in a metre drawing reads "1:10000 ... below the office minimum 1:100" (before: "1:10, meets 1:100"). Proposed robot case `N_agi_metre_grade`, with switch-off control. BUG-1052 stays OPEN.

**BUG-1053 (LandXML levels in millimetres)**

- Note (CE 05, Tue 3 Nov 2026, fix job B-172 / w1053): draft PR #1995 (head 26afae19, base rel-20261102a), unit-tested only. **Built:** net48 build 0 errors. **Tested:** 155 of 155 pass on net10 (filter Bug1053, LandXml, Fb16, Fb17, Bug605, C78NewSwitch); tests read the LandXML parser only, no review line or imported pit was seen. **Installed:** no; not in 61fd6fbc, b1 or b2. **Accepted:** no. Switch `xcivilImport.landXmlLevelsConvertedToMetres`, ON. What Tim will see: a file in millimetres with pit cover 100200 reads 100.20 m, invert 100000 comes in as IL 100; an unconvertible unit gives Unknown levels and a report line, never a block. **Open question for Tim:** a file with no Units element is read as metres, as today; the carpark wording could mean Unknown. Recommendation: keep metres (Civil 3D files always carry Units). **Isolation flag:** listings differ, including `CD_Settings.json` (15270 to 15355 bytes at 05:06); an acad.exe started 05:06:15, so another job was probably driving AutoCAD; the job could not prove its own 04:59 to 05:03 usage files were not its own. Proposed robot case `B172_landxml_mm_levels` with switch-off control and a furlong broken twin. BUG-1053 stays OPEN.

**BUG-1042 (blank cover level blocks PIT and PITEDIT)**

- Note (CE 05, Tue 3 Nov 2026, fix job B-173 / w1042): draft PR #1996 (head 6e3b64df, base rel-20261102a), unit-tested only. **Built:** net48 compile 0 errors. **Tested:** 161 of 161 pass on net10 (eight fixtures); four older tests that pinned the block now run with the switch OFF. **Installed:** no; not in 61fd6fbc, b1 or b2. **Accepted:** no; the warning line under the window has not been looked at on screen, and the depth estimate and setup advisor were not driven with a blank cover. Switch `pit.blankCoverIsWarningNotBlock`, ON. What Tim will see: leave Cover level blank in PIT and Place works with a line "The cover level is blank: it is saved blank (Unknown) and nothing that needs it is worked out."; PITEDIT saves a blank-cover pit after an unrelated change and the cover stays blank, never 0.000. Finalizer to add the key to the new-switch-defaults file; expect a keep-both-sides merge in PitViewModel.cs. **Isolation flag:** `CD_Settings.json` went from 15355 bytes (3 Nov 05:06) to 15270 bytes dated 4 Oct, and `CD_RecentValues.json` was rewritten at 05:23; the job's own redirect folder wrote nothing there; not proven. Proposed robot case `W1042_pit_blank_cover` (case (c) is the broken twin). BUG-1042 stays OPEN.

**BUG-027 ("MIN." on pipe labels)**

- Note (CE 05, Tue 3 Nov 2026, fix job B-174 / w027): draft PR #1997 (head 352a838b, base rel-20261102a), unit-tested only. **Built:** yes (net48 and net10). **Tested:** 30 tests pass on net48 and net10; the net8 run found no matching tests. **Installed:** no; not in 61fd6fbc, b1 or b2 (the MIN. code is still in b2). **Accepted:** no. Follows Tim's ruling UX-CPLAN-05, 26 Sep 11:46: "Keep the May rule: no MIN." Switch `pipe.gradeLabelNeverMin`, ON. What Tim will see: New Pipe, grade on Standard, one level typed, "I know one end" off: the label reads "AT 1 IN 100" instead of "AT 1 IN 100 MIN."; two-level labels are unchanged. Robot case K02 is already drafted (no twin by design; the switch-off run is the control). **Isolation flag, stop flag in the report:** 19 files changed in the real AutoCAD data folders, and `CD_Settings.json` moved back to a 3 Oct date (15311 to 15270 bytes), which looks like a restore or copy, not a normal save. Not proven either way; CE 01 to look before any merge. BUG-027 stays OPEN.

**BUG-1173 (colleague pack rollback wording)**

- Note (CE 05, Tue 3 Nov 2026, fix job B-175 / w1173): ALREADY SATISFIED in the pack; no PR, no code, no switch (a switch has no meaning for hand-read pack text). **Built:** nothing to build. **Tested:** nothing run. **Installed:** not applicable (the pack is in C:\CE_PLAN, not the plug-in). **Accepted:** no. Page 02 (`colleague-pack\02_INSTALL_AND_UPDATE.md`) step 4 (line 31) lists all five folders to copy aside and step 5 (line 91) restores all five and tells the colleague to run MENULOAD and unload CE_SUITE_MANAGER_MENU if the pull-down stays; added by C:\CE_PLAN commit db6bbd79. The pack's own [CHECK] note stands: that unloading removes the menu has not been rehearsed on a spare login. That rehearsal is the test, so BUG-1173 stays OPEN until it is done and accepted. **Open for CE 05 or Tim:** two wording items from the 30 Oct p1 report are still not in page 02 ("also `%APPDATA%\CE_SUITE` if it exists"; "if a `_PRE_V3` folder already exists, stop and tell the desk, never copy over it"). Pack changes need approval through the pack-changes list. I did not check page 02 myself; the job report quotes the lines.

**BUG-1166 (office folders on OneDrive)**

- Note (CE 05, Tue 3 Nov 2026, fix job B-176 / w1166): draft PR #1998 (head 6f5a80d9, base rel-20261102a), unit-tested only. **Built:** net48 compile 0 errors. **Tested:** 57 of 57 pass on net10 (filter Bug1166, Bug1167, Bug1168, C78NewSwitchDefaults, FeedbackService, CivilJobTime). **Installed:** no; not in 61fd6fbc, b1 or b2. **Accepted:** no. Switch `linking.officeFolderFollowsOneDrive`, ON. What Tim will see: on a PC where the office folders came in as "Add shortcut to My files", CDFEEDBACK reaches the office folder, CDNEWDWG finds the templates, CDWT shows the tank pictures, job time finds its data folder; a folder Tim typed that exists is never moved; a plain Users\Creative Engineering PC is unchanged. **Not done:** Manager and CE Blocks (still have their own copy of the order; Civil-only batch), the FeedbackDialog fixed path line (a window change, Codex's), Structural. Max's real OneDrive layout has not been looked at (carpark says before 9 Nov). **Isolation flag:** 18 files changed in the real folders at 6:06 to 6:09 am, including a CDCHECK result file and Structural and Manager sessions that a Drainage test run does not load; probably another AutoCAD run, not proven. Proposed robot case `N47_office_folder_onedrive` with switch-off control. BUG-1166 stays OPEN.

**BUG-900 (X-Civil PDF schedule over several sheets)**

- Note (CE 05, Tue 3 Nov 2026, fix job B-177 / w900): draft PR #1999 (head 3a6a0b80, base rel-20261102a), unit-tested only. **Built:** net48 compile 0 errors; the script parses with the PowerShell parser, 0 errors. **Tested:** 8 of 8 (B177) and 89 of 89 (related) pass on net10; no test reads a real PDF (page reading needs Windows text recognition). **Installed:** no; not in 61fd6fbc, b1 or b2 (the one-sheet selection is still in b2). **Accepted:** no. Switch `xcivilImport.pdfScheduleReadsAllPages`, ON. What Tim will see: a pit schedule split over two or more sheets reads sizes and levels from every sheet; the pipe schedule is read from every sheet, not only the last; a sheet titled PIT SCHEDULE or PIPE SCHEDULE with no readable table is a warning and the import carries on. **Not proven:** a continuation sheet not headed "PIT SCHEDULE" gets no warning. **Needs:** a real multi-page X-Civil PDF and its DWG; none exists in the repo; Codex brief or Tim to supply. **Isolation flag:** 14 changed or new files in the real folders at 06:19 to 06:22 am (burst at 06:22:17 with all three suites starting and shutting down in a millisecond); none a settings file of Tim's; probably another job; not proven. Proposed robot case `N40_xcivil_pdf_pages` with switch-off control. BUG-900 stays OPEN.

**BUG-396 (double-click opens the Pit Schedule)**

- Note (CE 05, Tue 3 Nov 2026, fix job B-178 / w396): NOT BUILT, no PR. **Built:** nothing. **Tested:** nothing. **Installed:** no. **Accepted:** no. Today a double-click on a cell of a placed Pit Schedule opens AutoCAD's own text editor (blank, "Undefined shape" lines), as Codex saw on 18 and 19 Oct (L4-08); I did not re-run that. Confirmed unbuilt on the 2 Nov line and again on b2: `DoubleClickEditTable.cs` line 124 lists "pit-schedule" as no window, "needs its own workflow card (G5)". It is blocked on two things: (1) a command card, because it is a new double-click route (AGENTS.md review gate); (2) the Pit Schedule window has no way to open at a chosen pit, which is a window change, so Codex owns it. **Two questions for Tim (from `BRIEF_W396_DOUBLECLICK_02NOV.md` section 5):** a double-click on a locked or Xref schedule: open the window read-only, or leave AutoCAD's behaviour? A double-click on a header or title cell: open the window at the top, or do nothing from CE? Robot case in the brief section 6 (double-click the P2 cell, expect the window on P2 and no MTEDIT; switch OFF expects MTEDIT). BUG-396 stays OPEN.

---

## SKIPPED OR NOT DONE, AND WHY

1. **BUG_CARPARK.md not edited.** Your order: CE 05 appends.
2. **No gh check of PR contents.** I read only PR state and head from GitHub; I did not read the diffs. Test counts and file lists are from the job reports.
3. **BUG-1052 PR state.** I could not check whether a PR now exists beyond the five numbers above; I read the local branch only. If one was opened since, the note needs its number.
4. **Did not re-run the isolation comparison.** The listings were scratch files and are mostly removed. I repeat what each report says and add no judgement beyond "not proven".
5. **Page 02 of the colleague pack not read by me** (outside this job's reading list). The BUG-1173 lines are quoted from the report.
6. **Switch defaults file.** Reports 1052, 1053, 1042 say the new-switch-defaults file (C-78 style) was not touched. The finalizer folds those in; I have noted it only on BUG-1042 as the report did.
