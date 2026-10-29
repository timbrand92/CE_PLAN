# Release scoreboard: Civil + Manager pilot hand-over to Max

**Owner:** CE 07 Release. One file, refreshed at least hourly. Others read it, they do not edit it.
**Last refreshed:** Thu 29 Oct 2026, 12:02 Melbourne (PC clock; session list times agree). One ledger entry (H15) says "about 12:55"; that is a typo for about 11:55.
**Schedule in force:** Tim's ruling "option b" (decisions\2026-10-29_TIM_RELEASE_FREEZE.md): **freeze Fri 6 Nov, pilot Mon 16 Nov.** Mon 9 Nov is no longer the target.
**Words:** Built, Tested, Installed and Tim-accepted are four separate facts (RULES 4). "Claude-accepted" and "Codex-accepted" are never Tim's word. Unknown stays Unknown.

---

# FOR TIM

1. **Will Mon 9 Nov hold? No: you chose Mon 16 Nov.** **Will Mon 16 Nov hold? At risk, but a fair chance.** It holds if the everyday tools climb from 19 to 30 of 40 by Sat 7 Nov (CE 02 estimates 26 to 30), the final build is installed by Fri 6 Nov, one install rehearsal on a normal login passes, and Max is on an AutoCAD year we can test. Fallback is Mon 23 Nov.
2. **Days left:** 11 to Mon 9 Nov, 18 to Mon 16 Nov, 8 to the Fri 6 Nov freeze (5 working days; Tue 3 Nov is Cup Day).
3. **The scores (two figures each).**
   1. **Gate list:** 1 of 9 done / 8 open. Tim confirmed gate item 1 (administrator set-up) and ruled gate items 6 and 7 (Structural only) out of the gate, so the list is now 9 items, not 11.
   2. **Pilot-critical bugs (60):** 0 of 60 closed by Claude / 0 of 60 confirmed by you. 26 fixes installed, 5 built not installed, 27 no fix.
   3. **Everyday tools (40):** 19 of 40 Claude-accepted (47.5 percent) / 7 of 40 confirmed by you (PROGRESS.json, 11:49; up from 4). Your 12 planned hand checks: 11 passed, 1 not passed (OF and FO symbol, BUG-1236). Four more tools you confirmed on screenshots (D09, D10, D12, D03) are in the ledger but not yet in the count.
   4. **9 Nov-scope items (390):** built 47 percent (184 of 390) / tested 3.1 percent (12 of 390).
4. **Installed right now (I read the files):** Civil 3.0.85 and Manager 1.1.85, commit 09126560, in all three folders (Legacy, Modern, Net8). Unchanged since 00:21 today. Next build C-76 is assembled but not installed.
5. **What is not moving:** the C-77 build jobs. Of nine, only one (B-006) has a log file, and it is empty since 10:20; the other eight have a brief but no log. Friday night's install of C-77 is at risk unless more start soon. I have asked CE 01.
6. **Your answers this afternoon (decisions\2026-10-29_TIM_ANSWERS.md items 24 to 34) change the plan:** Max is on AutoCAD 2022 today and will have 2027 before the pilot, so the pilot is **2027 only** and nothing is installed on his PC until 2027 is in; the frozen copy goes in a separate `CE V3 PILOT` folder shared "can view" to Max only; the freeze is the latest build on Fri 6 Nov; BUG-905 is ON (0.9), BUG-1097 uses the head left after losses, and BUG-1095, 1091 and 1088 are all built before the freeze; the 2026 laptop is dropped (you will get 2027 on another PC) and you will organise the spare ordinary Windows login.
7. **Still needs you, through CE 04:** **when Max moves to 2027 and whether he can install programs** (the pilot cannot start before his 2027 is in: new item 36); **which PC has the ordinary login and when it is ready** (item 37); the old-files move (item 25); one-pass approval of the pack; your rulings on BUG-1189, BUG-1149, BUG-685 and BUG-1148; your word on Fri 13 Nov.
8. **Nothing has been published, copied or sent to Max.**

---

# DETAIL

## 1. Schedule B (in force; the dates CE 02 confirmed)

1. **Thu 29 Oct (tonight, after 5:30 pm):** C-76 (4 PRs, Opus final check running) installs; CE 02 re-tests only what it touched; P01 and P02 pilot cases (50 to 85 min); Codex looks G3 G7 G4 then H1 to H3 from 17:53.
2. **Fri 30 Oct:** C-77 assembled and installed Friday night so Saturday's full re-test runs on it; Tim confirms the 2027 PC with an ordinary login; rehearsal R1 once he says it exists; Codex H4 to H6, G6, G5 from 17:53.
3. **Sat 31 Oct:** full re-test 1 on whatever is installed then (an install mid-run voids it).
4. **Sun 1 and Mon 2 Nov:** fix builds continue (B-016 to B-032), reviews; Tim's soak continues.
5. **Tue 3 and Wed 4 Nov:** partial re-tests of whatever installed; Codex looks C1, C3, C6; rehearsal R2 and rollback R3 on the current build if a machine exists; the earliest the test laptop could be ready is Tue 3 Nov.
6. **Wed 4 and Thu 5 Nov:** C-78 (and C-79) assembled with every reviewed pilot-critical fix; Opus finalizer; page 04 drafted.
7. **Fri 6 Nov (freeze):** final candidate installed after 5:30 pm. Anything not reviewed by then waits for the release after the pilot and goes on page 04.
8. **Sat 7 Nov and Sun 8 Nov:** FULL pre-pilot re-test on the freeze candidate (two starts); one full pass in the Max-like setup (both extra add-ins moved aside); Codex looks; R2 and R3 on the final build. Then nightly Thu 12 and Fri 13 Nov and a last full pass Sat 14 Nov (CE 02).
9. **Mon 9 to Thu 12 Nov:** Tim's soak (4 working days) and his two hand checks (five-step walk, one council sheet); pack approved in one pass (Mon 9); package from the frozen folder (Tue 10); page 04 final (Wed 11); Opus freeze report (Thu 12).
10. **Fri 13 Nov:** final go checklist (hand-over plan section 8); your word "yes, hand it to Max".
11. **Mon 16 Nov:** hand-over.
12. **Biggest risks:** about 17 fixes in one last train with one week of tests (Tim, 16 Sep: large batches failed; I suggested splitting it); several fixes need a Codex look; outstanding rulings on BUG-685 and BUG-1148 and Max's facts; the C-77 jobs not yet started; the final install is on Fri 6 Nov so every later bug costs a new candidate.

## 2. Gate list (the 11 items at the top of release-v3-colleagues.md; items 6 and 7 removed by Tim, 29 Oct)

1. **Item 1, administrator set-up on Tim's PC (BUG-476): DONE and CONFIRMED BY TIM** (29 Oct: "Recommended: yes to both", answering question 26; Codex W53 PASS 3 of 3 on 10 Oct). Just closed. Other PCs not shown.
2. **Item 2, Roll Back hidden (BUG-477, BUG-441): OPEN.** Records disagree. Needs a Codex look at Manager (C2).
3. **Item 3, update route or reworded messages (BUG-478): OPEN, decided.** Updates by hand during the pilot.
4. **Item 4, old install scripts moved (BUG-483): TIM'S CALL.** Question 25.
5. **Item 5, fault report and CEMANAGERDIAG code the login (BUG-488): OPEN.** Fallback: Max told not to press them.
6. **Items 6 (BUG-495) and 7 (BUG-496), Structural only: OUT OF THE GATE** (Tim, 29 Oct: Structural stays on his PC only). The bugs stay open for Structural's own release.
7. **Item 8, units (BUG-505): OPEN.** Tim said yes 29 Oct; B-010 queued, not started; robot cases C35, C36 not recorded passing.
8. **Item 9, no blue (BUG-517): OPEN, partly built.** B-027 (BUG-525) queued; needs Codex look C1.
9. **Item 10, nothing off the PC (BUG-549 family): OPEN.** AI OFF and Structural not shipped; Codex look C3.
10. **Item 11, Structural 1.0.113 and C-35 installed plus a driver pass: OPEN.** Install met; the driver pass was not found.

Gate score: **1 of 9 done / 8 open.** Done: item 1. Open: items 2, 3, 4, 5, 8, 9, 10, 11. Items 6 and 7 are out of the gate.

## 3. Pilot-critical bugs (the 60; PILOT_CRITICAL_TEST_LIST_29OCT.md)

1. **Closed (Claude-accepted or Tim-confirmed): 0 of 60.**
2. **Fix installed, awaiting acceptance: 26.** Plus 1 installed but OFF (BUG-905, waits for Tim's figure) and 1 document fix (BUG-1173).
3. **Built, not installed: 5** (BUG-1189 and 1149 wait on Tim; 1090 needs rebase and review; 1052 and 1053 need review).
4. **No fix: 27.** Queued B-016 to B-032; none started as of the build register. Under schedule B they go in the freeze candidate if reviewed by Thu 5 Nov.
5. **Exit rule for 16 Nov:** each of the 60 is closed, written on page 04 as a known problem with a workaround, or switched off.
6. **Robot-provable by Fri:** P01 and P02 tonight; up to 4 to 6 more by Sat 31 Oct if CE 02's four runner changes and four test drawings land (CE 02 confirms Friday midday).
7. **Tim answered 29 Oct:** BUG-905 yes (0.9, fix ON in the next train); BUG-1097 the head left after losses (PR #1772 to change; still a warning); BUG-1095, 1091, 1088: build all three before the freeze. **Still waiting on Tim's word:** BUG-1189, 1149, 685, 1148.
8. **Scope (carpark, CE 02):** BUG-1209 and BUG-1210 apply to AutoCAD 2022 to 2026. Max is going to 2027 (Tim, 29 Oct), so they stay on page 04 only as a note for anyone on an older year. I have not re-read the entries.

## 4. Everyday tools (the 40; EVERYDAY_TOOLS_STATUS_29OCT.md)

1. **Claude-accepted: 19 of 40 (47.5 percent).** CE 00 ruled PIT and CD are the same checks as D01 and D12, not counted twice. CE 02 notes the plan names only 38 of the 40.
2. **Tim-confirmed: 7 of 40 (PROGRESS.json 11:49): D01, Recover Inverts, D16, D15, D02, D20 (Yes path), D27 (warn-first).** The ledger also records quick MOVE, CDREBUILD and CDSYNC, and D09, D10, D12, D03 (H15) as confirmed by Tim; CE 00 recounts.
3. **Estimate (CE 02):** 20 to 22 by Fri 30 Oct, 26 to 30 by Sat 7 Nov. The 30 target is now Sat 7 Nov.
4. **Next:** CDTWL freeboard, layers D24, schedule order D21, hide grade D06, Excel export D23, D13 (needs Tim), CDCHECKDWG D28, mid-pipe label D10, D05 and D07 after their builds.

## 5. Plan numbers (PROGRESS.json, counted 29 Oct 11:49)

1. **Whole plan (548):** built 300 of 548 (54.7 percent) / tested 12 of 548 (2.2 percent). Plan last recounted 28 Oct 18:12.
2. **9 Nov scope (390):** built 47 percent installed (184 of 390; 290 including unshipped drafts) / tested 3.1 percent (12 whole; 26 counting parts). Never mixed with the 40 tools. About 100 scope items are unbuilt and are not pilot blockers.
3. **Meters (USAGE.json 11:49):** Max 20 percent five-hour / 84 percent week; Codex 13 percent week; Team week 41 percent, stale (28 Oct 18:10).

## 6. Build trains

1. **Installed (CE 07 read the DLLs at 11:59):** Civil 3.0.85 and Manager 1.1.85, commit 09126560, Legacy, Modern and Net8 for both; equal to candidate C:\ce_rc_scratch\c1071 (903 files). Structural 1.0.125 (not shipped). Tim's AutoCAD (pid 30056, since 09:14) is open.
2. **C-76 (3.0.86 / 1.1.86): ASSEMBLED** (CE 01, 11:50): branch claude/rel-20261029a head dced33cf, four PRs merged (#1834 BUG-859, #1835 BUG-372, #1836 BUG-090 incl. Manager, #1837 BUG-1228). Build 0 errors; Civil net10 20,888 total / 20,856 passed / 32 skipped / 0 failed; Manager net10 1,056 / 0 failed. Opus final check running. Not installed. #1838 (BUG-1229) moved to C-77.
3. **C-77 backlog (B-005 to B-014):** Recent levels (B-006, "running"), raingarden label, Tidy labels ON, grip copy ON (after a robot pass), no-units note, two small extras, cover to outside, pit drop warning, green DP label. CE 01's answer (12:10): B-006 has been running since 10:20 (code and tests written, not committed, no PR yet; it waits for the one build lane behind the C-76 assembler and Opus finalizer); B-007 to B-014 have NOT started and run strictly one after another, 1.2 to 2 hours each. If nothing stalls they finish about Fri 30 Oct 03:00 to 06:00, then assemble 1 h, Opus finalizer 2 h, payload 40 min, so a ready payload about Fri 10:00 to 13:00 and an install Friday after 5:30 pm only if AutoCAD is closed and the robot lock is free. **CE 01 rated all nine making C-77 at about 50 percent; since 12:03 (Control Room ruled two lanes) CE 01 says about 70 percent:** lane 1 B-006, B-007, B-008, B-010, B-009; lane 2 B-012, B-013, B-011, B-014; builds still run one at a time; both lanes done Thu about 17:00 to 20:00 if nothing stalls, assemble Fri early morning. C-77 takes whatever is built and PR-ready by Fri 06:00 (#1838 first, then B-006 onward); the rest moves to C-78. CE 01 will say at Fri 08:00 which items made C-77. **Saturday's full re-test runs on whatever is installed at Fri 21:00** (C-76 is the safe base: finalizer GO expected about 14:00, install Thursday evening). B-015 (#1771) needs rebase and review.
4. **C-78 and later (B-016 to B-032):** the pilot-critical no-fix list. Nothing started.
5. **Add-ins:** CE.AutoCADLink.2027 and CE.Transform.Trial.2027 stay out of Max's package (CE 01 note); check B9 (Max-like re-run) proves it.

## 7. Re-test rules and capacity

1. After an install, re-test only what the fix touched; untouched cases are "carried from <build>" (Tim, 29 Oct). Until Tim rules on the settings-switch question (CE 04), the robot treats any settings change as a FULL re-test.
2. A full set is 66 checks twice in 38 starts: about 6 h 40 min now, about 5 h 45 min after the shorter-wait change (CE 02 estimates).
3. Codex: weekly 13 percent; each look 1 to 3 points; daily caps 30 from Thu 17:53, 44 from Fri 17:53, 58 from Sat 17:53. Looks need Tim's AutoCAD closed.

## 8. Install rehearsal and the test PC

1. **Hand install on a normal login rehearsed: 0 of 2.** Rollback rehearsed: 0 of 1.
2. **Test PC (Tim, 29 Oct):** the 2026 laptop is dropped; "i will get 2027 on another pc" and "i will organise" the ordinary login. The office has spare AutoCAD licences (year and who assigns: not stated). No rehearsal starts until Tim says the login exists and which PC. This is the 2027 normal-login rehearsal I needed; it also suits the robot (built for 2027). Needs an unlocked live desktop, no lock or sleep (CE 08).
3. **Max:** AutoCAD 2022 today, 2027 before the pilot (Tim). The pilot is 2027 only; nothing is installed on his PC until his 2027 is in; his install rights, the date of the upgrade, folders, old Structural and Manager version are Unknown.
4. **Dependency I am raising:** if Max's 2027 is not in by about Fri 13 Nov, the 16 Nov hand-over cannot happen on his own PC. The date of his upgrade is a new question for Tim (item 36).
5. **Tim's PC all-users folder (read earlier):** the stale Manager 1.0.0 in C:\ProgramData is disabled (PackageContents.xml renamed), not removed.
6. **Colleague pack:** change list ready (RELEASE_PACK_CHANGES_FOR_APPROVAL_29OCT.md): 97 changes, 12 decisions. Wrong as drafted: "drawings are safe either way" after a rollback (BUG-1135). Approval Mon 9 Nov once the freeze list is known.

## 9. Will it hold? (plain)

1. **Mon 9 Nov:** no, not the target any more.
2. **Mon 16 Nov: at risk, fair chance.** For: 5 working days to build, 11 days of re-tests, tools rising (19 to a likely 26 to 30), Tim's 12 hand checks mostly passed. Against: 0 of 60 pilot-critical closed and the robot reaches only 2 of 26 installed fixes; nine C-77 jobs barely started; one big last train; no rehearsal machine yet; Max still on 2022 with his 2027 date unknown.
3. **What turns it to NO:** the C-77 jobs not finishing in time for a Friday-night install, a rehearsal that finds an install fault needing a build, a blocker found after the Fri 6 Nov freeze, or Max's move to 2027 not being in before the hand-over (the pilot is 2027 only), or no ordinary-login PC being ready for the rehearsals.

## 10. Idle, blockers, not moving (12:02)

1. **Running (session list):** CE 02 (testing), CE 04 (questions).
2. **Idle:** CE 00 Control Room, CE 01 build (done on #1837; the Team jobs are separate processes), CE 03, CE 05, CE 06 guidebook, CE 08 research.
3. **Not yet moved:** C-77 jobs B-007 to B-014 (no log); Max's 2027 date and install rights (item 36), the rehearsal PC (item 37); CE 02's runner changes (due Fri); acknowledgements from CE 03 and CE 04 (CE 04 is working); BUG-1209/1210 scope not yet in the pack.
4. **Blockers for Tim:** all in QUESTIONS_FOR_MONDAY.md for CE 04 (items 22 to 37; 31, 33 and 35 are withdrawn because the laptop was dropped).

## 11. Decision log

1. **29 Oct (Tim, "option b"):** freeze Fri 6 Nov including the pilot-critical fixes the desk can build now; pilot Mon 16 Nov.
2. **29 Oct (CE 02, accepted):** 30 of 40 by Fri 30 Oct is not reachable; target Sat 7 Nov.
3. **29 Oct (Tim):** questions only through CE 04; a test laptop with AutoCAD 2026 is to be assessed (assessed; waiting on his yes and licence check).
4. **29 Oct (CE 00 via CE 01):** the two extra add-ins stay out of Max's package.
5. **29 Oct afternoon (Tim, decisions\2026-10-29_TIM_ANSWERS.md items 24 to 34):** "we have spare autocad licenses"; "he will have 2027, currently has 2022"; "i will organise" the spare ordinary Windows login; "the latest version ideally" for the frozen build; the `CE V3 PILOT` folder, shared "can view" to Max only; gate item 1 confirmed and gate items 6 and 7 out; BUG-905 yes; BUG-1097 the head left after losses; "build all three before 6 Nov" (BUG-1095, 1091, 1088); "i will get 2027 on another pc" (laptop dropped). Not answered: the settings-switch re-test point (item 34), the old-files move, Max's install rights and upgrade date.
