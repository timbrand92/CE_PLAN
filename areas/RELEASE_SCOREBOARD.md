# Release scoreboard: Civil + Manager pilot hand-over to Max

**Owner:** CE 07 Release. One file, refreshed at least hourly (30-minute check). Other sessions read it; they do not edit it.
**Last refreshed:** Thu 29 Oct 2026, 11:17 Melbourne (PC clock).
**Words:** Built, Tested, Installed and Tim-accepted are four separate facts (RULES 4). "Claude-accepted" and "Codex-accepted" are never written as Tim's word. Unknown stays Unknown.

---

# FOR TIM

1. **Will Mon 9 Nov hold? AT RISK, leaning to Mon 16 Nov.** I would plan for 16 Nov and treat 9 Nov as a stretch that holds only if the four things in item 3 are green by Fri 30 Oct (tomorrow).
2. **The scores (two figures each).**
   1. **Gate list:** 1 of 11 done / 10 open.
   2. **Pilot-critical bugs:** 0 of 60 closed by Claude / 0 of 60 confirmed by you. 26 have a fix installed, 5 are built but not installed, 27 have no fix.
   3. **Everyday tools (the 40):** 19 of 40 Claude-accepted / 4 of 40 confirmed by you (up to 6 or 7 by the hand checks since; CE 02 recounts).
   4. **9 Nov scope (390 items):** built 47 percent (184 of 390 installed) / tested 3.1 percent (12 of 390).
3. **What decides 9 Nov this week.**
   1. **Fri 30 Oct:** the everyday tools reach 30 of 40 (today 19).
   2. **Fri 30 Oct:** the hand install is rehearsed once on a spare standard Windows login. Nobody has one set up yet.
   3. **Fri 30 Oct:** Max's AutoCAD year is known (he types ABOUT).
   4. **Sat 31 Oct:** the freeze candidate (C-76 plus C-77) is built.
4. **Only you can do these.** They are listed with a recommendation in RELEASE_TEST_PLAN_29OCT.md section 6 (and the hand-over steps in RELEASE_HANDOVER_PLAN_29OCT.md) and go to CE 04 as numbered items: Max's AutoCAD year and rights, the spare login, where the frozen copy sits, the old-files move, the pack approval, then "yes, hand it to Max" on Fri 6 Nov.
5. **Nothing has been published, copied or sent.** The frozen copy plan, the install steps and the pack changes are drafts.

---

# DETAIL

## 1. Dates

1. **Today:** Thu 29 Oct 2026.
2. **Days to Mon 9 Nov:** 11 calendar days. Working days left before the Fri 6 Nov go decision: Fri 30, Mon 2, Wed 4, Thu 5, Fri 6 (5), plus the rest of today. **Tue 3 Nov is Cup Day**, a full free AutoCAD day.
3. **Days to Mon 16 Nov:** 18 calendar days.
4. **Fixed points (gap plan 22 Oct):** checkpoint 1 Fri 30 Oct; candidate Sat 31 Oct; freeze Mon 2 Nov; package Wed 4 Nov; soak Thu 5 Nov; checkpoint 2 and Tim's word Fri 6 Nov; hand-over Mon 9 Nov.

## 2. Gate list (the 11 items at the top of release-v3-colleagues.md)

1. **Item 1, administrator set-up on Tim's PC (BUG-476): DONE, not yet confirmed by Tim.** Evidence: Codex W53 PASS 3 of 3, 10 Oct; shared admin list holds one entry. Other PCs not shown. **Tim's call:** confirm.
2. **Item 2, Roll Back hidden (BUG-477, BUG-441): OPEN.** Records disagree (24 Oct triage says installed, T5 audit item 17 says NOT MET). Evidence needed: a Codex look at Manager's window. Fallback: pack tells Max not to press it.
3. **Item 3, update route or reworded messages (BUG-478): OPEN, decided.** Updates by hand during the pilot (Tim 20 Oct). Messages not shown reworded.
4. **Item 4, old install scripts moved (BUG-483): TIM'S CALL.** Recommended yes before 9 Nov.
5. **Item 5, fault report and CEMANAGERDIAG code the login (BUG-488): OPEN.** Fallback: Max told not to press them (pack does not yet say so for CEMANAGERDIAG).
6. **Item 6, Publish Issue stamps only ticked sheets (BUG-495): OPEN, Structural only.** **Tim's call:** confirm out of scope (Structural stays on his PC, ruling B3).
7. **Item 7, job record lives with the job (BUG-496): OPEN, Structural only.** Same call.
8. **Item 8, X-Civil and LandXML units (BUG-505): OPEN.** Tim said yes 29 Oct to one soft line; build item B-010 queued, not built. Robot cases C35 and C36 not recorded as passing.
9. **Item 9, no blue anywhere (BUG-517): OPEN, partly built.** Printed sheet colour installed (built only); windows and ribbon (BUG-525) not fixed. Needs a Codex look at three windows and the printed sheet.
10. **Item 10, markup and chat send nothing off the PC (BUG-549 family): OPEN.** Fixes installed, untested. For the pilot AI is OFF and Structural is not shipped.
11. **Item 11, Structural 1.0.113 and C-35 installed plus a driver pass: OPEN.** Install long met; the driver pass (AI-off messages, nothing sent) not found.

Gate score: **1 of 11 done / 10 open** (2 of the 10 fall away if Tim confirms Structural stays on his PC).

## 3. Pilot-critical bugs (the 60; detail in PILOT_CRITICAL_TEST_LIST_29OCT.md)

1. **Closed (Claude-accepted or Tim-confirmed): 0 of 60.**
2. **Fix installed on Tim's PC, awaiting acceptance: 26 of 60** (24 fix PRs, plus BUG-1049 and BUG-540). Source-checked by CE 02, not read from the DLL.
3. **Fix installed but switched OFF: 1** (BUG-905, waits for Tim's hard-ground C figure). **Document fix only: 1** (BUG-1173, pack page 02).
4. **Fix built, not installed: 5** (BUG-1189, 1149, 1090, 1052, 1053). Two wait for Tim (1189, 1149), BUG-1090 needs rebase and review (Tim said yes), 1052 and 1053 need review.
5. **No fix: 27.** Triage of 29 Oct: 11 build now, 6 build on a recommended answer, 2 need Tim (BUG-685, 1148), 7 are facts to gather (Max's PC or a robot run), 1 needs the protected shared file. Queued as B-016 to B-032.
6. **Needs Tim before it can move:** BUG-905 and BUG-1097 (fix built, his figure), BUG-1189 and BUG-1149 (his question), BUG-685 and BUG-1148 (his ruling).
7. **Robot can prove now: 2** (P01 BUG-1194, P02 BUG-1140; drafts, never run). 18 need a test drawing, a runner change or a second PC. 6 need a Codex look.

## 4. Everyday tools (the 40)

1. **Claude-accepted: 19 of 40 (47.5 percent).** Target at checkpoint 1 (Fri 30 Oct): 30 of 40. Gap: 11.
2. **Tim-confirmed (PROGRESS.json, 10:47): 4 of 40.** The ledger hand checks H1 to H7 since then passed PIT and CD keep placing (D01 both halves), Recover Inverts, EXPLODE a pit, ERASE a pit, COPY a pit, U names what it undid (PIT half only). Not passed: CDRENUMBER (ran, nothing to renumber), pit catch D02 (invalid test). By that mapping the figure may now be 6 or 7 of 40; **CE 00/CE 02 own the recount**, I do not change PROGRESS.json.
3. **Next ones in reach:** CDTWL freeboard (the 20th, needs R14h x3 two passes), New Pipe recent values (B-006), Hide grade, mid-pipe label, hand-placed label, schedule onto next sheet, CDCHECKDWG summary (real fault seen), ribbon tab jump (real fault seen).

## 5. 9 Nov scope and whole plan

1. **390-item 9 Nov scope:** built 47 percent (184 of 390 installed; 290 including unshipped drafts, 74 percent) / tested 3.1 percent (12 of 390 whole; 6.7 percent counting parts).
2. **Whole 548-item plan (PROGRESS.json):** built 300 of 548 (54.7 percent) / tested 12 of 548 (2.2 percent). Never mixed with the 40 tools.
3. **About 100 plan items in the 9 Nov scope are not built.** The gap plan cut them from the pilot on purpose.

## 6. Build train state

1. **Installed now (read from the DLLs by CE 07, about 11:15):** Civil 3.0.85 and Manager 1.1.85 at commit 09126560 in Legacy, Modern and Net8. The candidate folder C:\ce_rc_scratch\c1071 has the same six DLL hashes and 903 files, same as the installed bundle. Structural 1.0.125 (not shipped to Max).
2. **C-76 (Civil 3.0.86 / Manager 1.1.86): assembling.** PRs #1834 (BUG-859 downpipe double-click), #1835 (BUG-372 CDCHECK wording), #1836 (BUG-090 About window, Manager), #1837 (BUG-1228 DP speed). #1838 (BUG-1229 grade) joins if the assembler says so. Built and unit-tested only. Not installed.
3. **C-77 backlog (nine jobs), building:** B-006 Recent levels buttons (running), B-007 raingarden label, B-008 Tidy labels ON by default, B-009 grip copy ON (after a robot pass with it ON), B-010 no-units note, B-011 two small extras, B-012 cover to the outside of the pipe, B-013 pit drop warning, B-014 green DP label double-click. B-015 (PR #1771 sheet line) needs rebase and review.
4. **After that:** B-016 to B-032, the pilot-critical no-fix items. Not all can make a freeze on Mon 2 Nov.
5. **Risk I am raising to CE 00:** every install after the freeze candidate restarts the two-pass clock for the areas it touches. Recommend freeze candidate = C-76 plus C-77 only, built by Sat 31 Oct; B-016 onward go to the release after the pilot unless Tim wants a specific one (see test plan section 4).

## 7. Re-test schedule (Tim's re-test rule, 29 Oct)

1. **Rule:** after an install, re-test only what the fix touched; untouched accepted cases are written "carried from <build>". A full re-test runs every weekend and before anything goes to Max.
2. **Planned full runs (CE 02 owns):** Sat 31 Oct (weekend 1), Sat 7 Nov (weekend 2), and the **pre-pilot full re-test on the frozen candidate**: proposed Tue 3 Nov (Cup Day, whole day free) with a second start on Wed 4 Nov, then nightly on Thu 5 and Fri 6. Last full regrade took 7.6 hours (3.0.84, 33 runs); about 6.3 sessions an hour.
3. **Weakness:** the robot can reach only 2 of the 26 installed pilot-critical fixes today. Unlocking the rest needs four test drawings, four reviewed runner changes and a spare login (test list section C). Without them the 0 of 60 barely moves before 9 Nov.
4. **Status:** none of these runs has been confirmed scheduled by CE 02 yet (I have asked, see test plan).

## 8. Install rehearsal and hand-over

1. **Hand install on a standard Windows login rehearsed: 0 of 2** (target before Fri 30 Oct for the first). No spare login recorded anywhere.
2. **Rollback rehearsed: 0 of 1.**
3. **Max's AutoCAD year: Unknown.** Pack says 2027 but nobody has looked. Question for Tim (to CE 04).
4. **Max's login rights, old Structural 1.0.41, Manager version, all-users plug-in folders, OneDrive folder layout: all Unknown.**
5. **Tim's PC all-users folder (read about 11:15):** C:\ProgramData\Autodesk\ApplicationPlugins holds a CE_SUITE_MANAGER.bundle whose PackageContents.xml has been renamed PackageContents.xml.DISABLED-duplicate-appdata-wins, files at Manager 1.0.0 (commit cac19768). So the stale copy is disabled, not removed. The 20 Oct "not done" note is out of date for this folder (the disabled file does the job). Nothing under C:\Program Files\Autodesk\ApplicationPlugins starts with CE. Max's PC is not read.
6. **Frozen copy:** not placed (publishing, Tim's word). Plan in RELEASE_HANDOVER_PLAN_29OCT.md.
7. **Colleague pack:** 5 pages are 22 Oct drafts against 3.0.70; page 06 has 20 questions, several answered. Change list for one-pass approval is being drafted: RELEASE_PACK_CHANGES_FOR_APPROVAL_29OCT.md.

## 9. Will 9 Nov hold? AT RISK

**Why at risk:**
1. Gate 1 of 11, pilot-critical 0 of 60 closed, tools 19 of 40 against 30 wanted tomorrow.
2. Hand install never rehearsed; no spare login; Max's year and rights Unknown.
3. Robot can drive only 2 of 26 installed pilot-critical fixes.
4. Fixes still landing (C-76, C-77, then B-016 on); each install resets the two-pass clock for what it touches.
5. Colleague pack unapproved; the known-problems page must be final on Thu 5 Nov.

**What would turn it to YES:** 30 of 40 and the first rehearsal by Fri 30 Oct; candidate frozen Sat 31 Oct; full re-test green Tue 3 and Wed 4 Nov; Tim's pack approval by Wed 4 Nov; his word on Fri 6 Nov.

**What would turn it to NO:** the 30 of 40 check on Fri 30 Oct comes in below about 26, or the rehearsal finds an install fault that needs a build, or Max is on AutoCAD 2022 to 2024 (those years have never been driven with this build; BUG-1209, BUG-1210 apply).

## 10. Blockers and who is idle (11:17)

1. **Idle:** CE 03 (test-with-tim), CE 04 (questions-for-tim), CE 05 (carpark-planning), guidebook session. CE 01 build session reported done on PR #1837; CE 02 working.
2. **Held by Tim being on AutoCAD:** robot, Codex looks G3 G7 G4 (Thu 17:53), G6 G5 (Fri 17:53).
3. **Blockers for Tim:** listed as numbered items in QUESTIONS_FOR_MONDAY.md for CE 04 (see section 6 of RELEASE_TEST_PLAN_29OCT.md).

## 11. Change log (newest first)

1. **29 Oct 11:17 CE 07:** first scoreboard written. Read installed DLLs and c1071 (identical). Asked CE 02, CE 03, CE 04 for their lists. Pack change list job started.

## 12. Two schedules ready for Tim's freeze ruling (CE 00 asked for both, 29 Oct 11:25; his answer drops straight in)

**Option A: freeze Sat 31 Oct (C-76 + C-77 only), pilot Mon 9 Nov.**
1. **Thu 29 Oct (tonight, after 5:30 pm):** C-76 installs; CE 02 re-tests what C-76 touched (R09, R22, N31/C31, N32, About window Codex look); P01 and P02 first pass.
2. **Fri 30 Oct (checkpoint 1):** 30 of 40 tools? first rehearsal R1 on the spare login (current 3.0.85 build)? Max's year known? Tim's 9-or-16 lean.
3. **Sat 31 Oct:** C-77 (B-006 to B-014) finalised and installed = freeze candidate FC-A. Weekend-1 full re-test starts (about 8 hours).
4. **Sun 1 Nov:** second pass of the full re-test; rehearsal R2 and rollback R3 on FC-A.
5. **Mon 2 Nov:** freeze. Tim's soak on his PC Mon 2, Wed 4, Thu 5, Fri 6 (Cup Day Tue 3 is a free robot day).
6. **Tue 3 Nov (Cup Day):** pre-pilot full re-test, Codex looks C1 to C6, second Codex pass on windows; Tim's D1 and D2 hand checks not in this day (he is on a holiday); do them Wed 4 Nov evening or Thu 5.
7. **Wed 4 Nov:** package from the frozen folder, hash read-back; pack changes approved by Tim in one pass.
8. **Thu 5 Nov:** page 04 final from the test results; nightly re-test.
9. **Fri 6 Nov:** freeze report, final go checklist, Tim's word.
10. **Mon 9 Nov:** hand-over.
11. **What Max gets with it:** the 27 no-fix bugs and the 5 built-not-installed ones are written on page 04 with workarounds; CDDESIGN, CDRUNSOLVE and CDTWL are for drafting only, never an issued number (page 06 question 8). Twelve of them are wrong-answer engineering bugs (BUG-1088, 1095, 1099, 1091, 866, 901, 902, 903, 907, 1096, 685, 1192): that is what a first colleague would meet on a storage or pipe-size job.
12. **Biggest A risks:** only 4 working days for the soak; any blocker after Sat 31 Oct builds a new candidate and restarts the two-pass clock; 30 of 40 must come in tomorrow.

**Option B: freeze Fri 6 Nov (C-76 + C-77 + the pilot-critical fixes CE 01 can build now, B-016 to B-032), pilot Mon 16 Nov.**
1. **Thu 29 Oct to Wed 4 Nov:** C-76 installs tonight and C-77 on Sat 31 Oct as ordinary trains, so the robot has early passes on them; CE 01 builds B-016 to B-032 as drafts behind switches ON; Opus reviews as they land. Rehearsal R1 on the spare login by Fri 30 Oct, still on the current build.
2. **Thu 5 Nov:** train C-78 assembled and finalised with every reviewed pilot-critical fix.
3. **Fri 6 Nov (after 5:30 pm):** C-78 installs = freeze candidate FC-B. Anything not reviewed by then stays out and goes on page 04.
4. **Sat 7 and Sun 8 Nov:** full re-test, first pass Sat, second pass Sun in a separate start; Codex looks; rehearsals R2 and R3 on FC-B.
5. **Mon 9 to Thu 12 Nov:** Tim's soak (4 working days); targeted fixes only for blockers (each one restarts the clock for its area); pack changes approved Mon 9 Nov; package from the frozen folder Tue 10 Nov.
6. **Wed 11 Nov:** page 04 final from the results.
7. **Fri 13 Nov:** freeze report, final go checklist, Tim's word.
8. **Mon 16 Nov:** hand-over. Fallback Mon 23 Nov.
9. **What Max gets with it:** the 11 build-now and 6 build-on-recommended no-fix bugs fixed and tested; only the Tim-ruling, facts-from-Max and protected-file items stay on page 04.
10. **Biggest B risks:** 17 new fixes in one train with one week of tests is a large batch (Tim 16 Sep: large batches failed); several need a Codex look; Tim's rulings on 685 and 1148 and the Max facts still outstanding; one week later than the pilot target.

**Side by side (my reading; Tim decides):**
1. **Earlier pilot:** A by 7 days.
2. **Fewer known wrong-answer problems for Max:** B (about 17 fewer).
3. **Chance the test numbers are ready:** A needs 30 of 40 tomorrow and a rehearsal before there is a login; B has a week more.
4. **Hybrid I would consider:** A's Sat 31 Oct freeze plus only the four small sourced fixes (BUG-1095, BUG-1091, and B-012 and B-013 already in C-77), with BUG-1088 as a CDDESIGN warning and the rest on page 04. This moves the pilot to Mon 9 Nov only if Friday's checkpoint is green; otherwise it becomes B.
5. **My lean:** B, because the first colleague job is likely to hit CDDESIGN, and 0 of 60 closed with no rehearsal makes 9 Nov a guess. Tim's call.
