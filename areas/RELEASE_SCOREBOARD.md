# Release scoreboard: Civil + Manager pilot hand-over to Max

**Owner:** CE 07 Release. One file, refreshed at least hourly. Others read it, they do not edit it.
**Last refreshed:** Thu 29 Oct 2026, 11:32 Melbourne (PC clock).
**Schedule in force:** Tim's ruling "option b" (decisions\2026-10-29_TIM_RELEASE_FREEZE.md): **freeze Fri 6 Nov, pilot Mon 16 Nov.** Option A (freeze Sat 31 Oct, pilot 9 Nov) was not chosen.
**Words:** Built, Tested, Installed and Tim-accepted are four separate facts (RULES 4). "Claude-accepted" and "Codex-accepted" are never Tim's word. Unknown stays Unknown.

---

# FOR TIM

1. **Will Mon 16 Nov hold? AT RISK, but a fair chance.** It is a better bet than 9 Nov was. It holds if: the everyday tools climb from 19 to 30 of 40 by Sat 7 Nov (CE 02 estimates 26 to 30), the final build is installed by Fri 6 Nov, one install rehearsal on a normal login passes, and Max is on an AutoCAD year we can test. Fallback is Mon 23 Nov.
2. **The scores (two figures each).**
   1. **Gate list:** 1 of 11 done / 10 open.
   2. **Pilot-critical bugs (60):** 0 of 60 closed by Claude / 0 of 60 confirmed by you. 26 fixes installed, 5 built not installed, 27 no fix (the builds before the freeze target these).
   3. **Everyday tools (40):** 19 of 40 Claude-accepted / 4 of 40 confirmed by you (PROGRESS.json). Today you completed 8 of 12 planned hand checks.
   4. **9 Nov-scope items (390):** built 47 percent (184 of 390) / tested 3.1 percent (12 of 390).
3. **Needs you, all through CE 04** (items 22 to 30 in QUESTIONS_FOR_MONDAY.md, plus the laptop items): Max's AutoCAD year and Windows rights; the test laptop (whose, user type, sign-in, when); where the frozen copy sits; the old-files move; one-pass approval of the pack; your word on Fri 13 Nov.
4. **A finding that matters for the laptop:** the installed Civil bundle sends AutoCAD 2025 and 2026 to its own "Net8" folder, and 2027 to a different folder that also carries 2027-only pipe-object files. So a 2026 laptop tests a different build of CE from the one on your PC, and nobody has ever run that one in AutoCAD. It is good for the install rehearsal, and for Max if he is on 2025 or 2026. It does not repeat your 2027 tests.
5. **Nothing has been published, copied or sent to Max.**

---

# DETAIL

## 1. Dates (Melbourne)

1. **Today:** Thu 29 Oct 2026.
2. **Freeze:** Fri 6 Nov, installed after 5:30 pm = 8 days away. Working days left before it: Fri 30 Oct, Mon 2, Wed 4, Thu 5, Fri 6 (5), plus the rest of today. **Tue 3 Nov is Cup Day** (free AutoCAD day).
3. **Pilot:** Mon 16 Nov = 18 calendar days away. Fallback Mon 23 Nov.

## 2. Schedule B (in force)

1. **Thu 29 Oct (tonight, after 5:30 pm):** C-76 installs; CE 02 re-tests only what it touched; P01 and P02 pilot cases (50 to 85 min); Codex looks G3 G7 G4 then H1 to H3 from 17:53; CE 02's CDTWL, layer and schedule cases.
2. **Fri 30 Oct:** C-77 candidate assembled (install Friday night so Saturday's full re-test runs on it); rehearsal R1 if a login exists; Max's year known? Codex H4 to H6, G6, G5 from 17:53.
3. **Sat 31 Oct (weekend re-test 1):** full re-test on the build installed before the start (an install mid-run voids it).
4. **Sun 1 and Mon 2 Nov:** fix builds continue (B-016 to B-032); reviews; Tim's soak continues on his PC.
5. **Tue 3 Nov (Cup Day) and Wed 4 Nov:** partial re-tests of whatever has installed (CE 02, revised after option b); Codex looks C1, C3, C6; rehearsal R2 and rollback R3 if a login exists.
6. **Wed 4 and Thu 5 Nov:** train C-78 assembled with every reviewed pilot-critical fix; Opus finalizer; page 04 drafted.
7. **Fri 6 Nov (freeze):** C-78 (or later) installed after 5:30 pm = **freeze candidate**. Anything not reviewed by then waits for the release after the pilot and goes on page 04.
8. **Sat 7 Nov (pre-pilot re-test, pass 1) and Sun 8 Nov (second start if needed):** full re-test on the freeze candidate; one full pass in the Max-like configuration (add-ins moved aside); Codex looks on the final build; R2 and R3 on the final build. CE 02 then runs nightly Thu 12 and Fri 13 Nov and a last full pass Sat 14 Nov.
9. **Mon 9 to Thu 12 Nov:** Tim's soak (4 working days) and his two hand checks (D1 five-step walk, D2 one council sheet); pack approved in one pass (Mon 9); package from the frozen folder (Tue 10); page 04 final from results (Wed 11); Opus freeze report (Thu 12). A blocker means a new candidate and a restarted clock for what it touches.
10. **Fri 13 Nov:** final go checklist (hand-over plan section 8); Tim's word "yes, hand it to Max".
11. **Mon 16 Nov:** hand-over.
12. **Biggest risks:** about 17 fixes in one last train with one week of tests (Tim, 16 Sep: large batches failed, so split the train if CE 01 can); several fixes need a Codex look; Tim's rulings on BUG-685 and BUG-1148 and Max's facts are outstanding; the final install is on Fri 6 Nov so every later bug costs a new candidate.

## 3. Gate list (the 11 items at the top of release-v3-colleagues.md)

1. **Item 1, administrator set-up on Tim's PC (BUG-476): DONE, Tim has not confirmed.** Codex W53 PASS 3 of 3, 10 Oct. Other PCs not shown.
2. **Item 2, Roll Back hidden (BUG-477, BUG-441): OPEN.** Records disagree. Needs a Codex look at Manager (C2).
3. **Item 3, update route or reworded messages (BUG-478): OPEN, decided.** Updates by hand during the pilot.
4. **Item 4, old install scripts moved (BUG-483): TIM'S CALL.** Question 25.
5. **Item 5, fault report and CEMANAGERDIAG code the login (BUG-488): OPEN.** Fallback: Max told not to press them.
6. **Items 6 (BUG-495) and 7 (BUG-496), Structural only: OPEN.** Out of the gate if Tim confirms Structural stays on his PC (question 26).
7. **Item 8, units (BUG-505): OPEN.** Tim said yes 29 Oct; B-010 queued, not built; robot cases C35, C36 not recorded passing.
8. **Item 9, no blue (BUG-517): OPEN, partly built.** B-027 (BUG-525) queued; needs Codex look C1.
9. **Item 10, nothing off the PC (BUG-549 family): OPEN.** AI OFF and Structural not shipped; Codex look C3.
10. **Item 11, Structural 1.0.113 and C-35 installed plus a driver pass: OPEN.** Install met; the driver pass was not found.

Gate score: **1 of 11 done / 10 open.**

## 4. Pilot-critical bugs (the 60; PILOT_CRITICAL_TEST_LIST_29OCT.md)

1. **Closed (Claude-accepted or Tim-confirmed): 0 of 60.**
2. **Fix installed, awaiting acceptance: 26.** Plus 1 installed but OFF (BUG-905, waits for Tim's figure) and 1 document fix (BUG-1173).
3. **Built, not installed: 5** (BUG-1189 and 1149 wait on Tim; 1090 needs rebase and review; 1052 and 1053 need review).
4. **No fix: 27.** Triage: 11 build now, 6 build on a recommended answer, 2 need Tim (685, 1148), 7 facts to gather (Max's PC or a robot run), 1 needs the protected shared file. Queued B-016 to B-032; under schedule B they go in the freeze candidate if reviewed by Thu 5 Nov.
5. **Exit rule for 16 Nov:** each of the 60 is closed, written on page 04 as a known problem with a workaround, or switched off.
6. **Robot-provable by Fri:** P01 and P02 tonight; up to 4 to 6 more by Sat 31 Oct if CE 02's four runner changes and four test drawings land (CE 02 confirms Friday midday).
7. **Waiting on Tim's word:** BUG-905, 1097, 1189, 1149, 685, 1148 (asked through CE 04).

## 5. Everyday tools (the 40; EVERYDAY_TOOLS_STATUS_29OCT.md)

1. **Claude-accepted: 19 of 40 (47.5 percent).** CE 02 notes the plan names only 38 of the 40.
2. **Tim-confirmed: 4 of 40 (PROGRESS.json).** Hand checks passed today: PIT, CD, Recover Inverts, EXPLODE, ERASE, COPY, U names PIT, pit catch (90 mm caught, 110 mm free). Open: CDRENUMBER (nothing to renumber), quick MOVE, CDSYNC and CDREBUILD, OF and FO. CE 00 and CE 02 recount.
3. **Estimate (CE 02):** 20 to 22 by Fri 30 Oct, 26 to 30 by Sat 7 Nov. The 30 target is now Sat 7 Nov, not Fri 30 Oct.
4. **Next 11:** CDTWL freeboard, PIT and CD (by ruling), layers D24, schedule order D21, quick MOVE, hide grade D06, Excel export D23, D13 (needs Tim), CDCHECKDWG D28, mid-pipe label D10.

## 6. Plan numbers (PROGRESS.json, counted 29 Oct 10:47)

1. **Whole plan (548):** built 300 of 548 (54.7 percent) / tested 12 of 548 (2.2 percent).
2. **9 Nov scope (390):** built 47 percent installed (184 of 390; 290 including unshipped drafts) / tested 3.1 percent (12 whole; 26 counting parts). Never mixed with the 40 tools. About 100 scope items are unbuilt and are not pilot blockers.

## 7. Build trains

1. **Installed (CE 07 read the DLLs):** Civil 3.0.85 and Manager 1.1.85 at 09126560 in all three lanes; hash for hash equal to candidate C:\ce_rc_scratch\c1071 (903 files). Structural 1.0.125 (not shipped).
2. **C-76 (3.0.86 / 1.1.86):** PRs #1834 BUG-859, #1835 BUG-372, #1836 BUG-090, #1837 BUG-1228; #1838 BUG-1229 if the assembler takes it. Built, unit-tested, not installed.
3. **C-77 backlog (B-006 to B-014):** Recent levels, raingarden label, Tidy labels ON, grip copy ON (after a robot pass), no-units note, two small extras, cover to outside, pit drop warning, green DP label. B-015 (#1771) needs rebase and review.
4. **C-78 and later (B-016 to B-032):** the pilot-critical no-fix list. Nothing started as of the build register.
5. **Add-ins:** CE.AutoCADLink.2027 and CE.Transform.Trial.2027 stay out of Max's package (CE 01 note); Max-like re-run check B9 proves it.

## 8. Re-test schedule (Tim's rule, 29 Oct)

1. After an install, re-test only what the fix touched; untouched cases are "carried from <build>". Full re-tests: Sat 31 Oct, Sat 7 Nov plus Sun 8 Nov second pass, and the pre-pilot re-test after the freeze.
2. A full set takes 6 to 8 hours now (about 4 with the speed changes CE 02 is testing tonight).
3. CE 02's re-test area map warns that every fix adds a settings switch, and the settings rule then forces a full re-test, so "carry" saves little until Tim rules on it (their question).
4. Codex looks: weekly 13 percent; daily caps 30 from Thu 17:53, 44 from Fri 17:53, 58 from Sat 17:53.

## 9. Install rehearsal and the test laptop

1. **Hand install on a standard login rehearsed: 0 of 2.** Rollback rehearsed: 0 of 1. The spare 2027 work PC: Tim cannot set it up now.
2. **Tim's alternative: a laptop with AutoCAD 2026.** See RELEASE_HANDOVER_PLAN_29OCT.md section 11. Questions sent to CE 04.
3. **Max's year, rights, folders, old Structural, Manager version: all Unknown.**
4. **Tim's PC all-users folder (read):** the stale Manager 1.0.0 in C:\ProgramData is disabled (PackageContents.xml renamed), not removed.
5. **Colleague pack:** change list ready (RELEASE_PACK_CHANGES_FOR_APPROVAL_29OCT.md): 97 changes, 12 decisions. Wrong as drafted: "drawings are safe either way" after a rollback (BUG-1135). Approval once the freeze list is known.

## 10. Idle, blockers, not moving (11:32)

1. **Idle at last list:** CE 03, CE 04, CE 05, guidebook session, CE 02, CE 01 (done on #1837). CE 08 research is working (Tim started it).
2. **Not yet moved:** the standard-login route (now the laptop question), Max's year, the freeze-candidate list, CE 02's runner changes (due Fri), acknowledgements from CE 03 and CE 04.
3. **Blockers for Tim:** all in QUESTIONS_FOR_MONDAY.md for CE 04.

## 11. Decision log

1. **29 Oct (Tim, "option b"):** freeze Fri 6 Nov including the pilot-critical fixes the desk can build now; pilot Mon 16 Nov. My earlier Option A text was removed from this file (it is in git history).
2. **29 Oct:** 30 of 40 by Fri 30 Oct is not reachable (CE 02); the target is now Sat 7 Nov.
3. **29 Oct (Tim):** questions only through CE 04; a test laptop with AutoCAD 2026 is to be assessed.

## 12. Inputs received after the first schedule B draft (29 Oct)

1. **CE 02 (revised after option b):** Sat 31 Oct weekend-1 full re-test on whatever is installed; per-install area re-tests; FULL pre-pilot re-test on the frozen build run Sat 7 Nov (second start Sun 8 Nov if needed); nightly Thu 12 and Fri 13 Nov; last full pass Sat 14 Nov; one full pass in the Max-like configuration. The Tue 3 and Wed 4 Nov slots are partial re-tests. A 2026 pass is labelled 2026-only, never a 2027 pass. Click-by-click laptop steps are coming in areas\TEST_LAPTOP_STEPS_29OCT.md.
2. **CE 08 research (RESEARCH_SCOUT_29OCT.md, figures from search summaries, unchecked):** a test PC or laptop must keep an unlocked desktop (monitor or a dummy display plug), no lock, no sleep, auto-login, or the robot's real key presses fail. Max's AutoCAD year decides whether a cloud AutoCAD trial is worth it. A separate test seat licence may exist through an Autodesk developer membership (decision queued with CE 04).
3. **Effect:** the laptop questions to CE 04 (item 33) now also ask for: unlocked desktop with the lid open or a display plug, auto-login, no lock or sleep.

## 13. Laptop answer (CE 02, 29 Oct)

1. Laptop with AutoCAD 2026 can be a 2026-only test machine: about 3 working days after Tim's yes, earliest Tue 3 Nov; it does the install rehearsal, a first 2026 check and Codex looks first; the robot runs there nightly only after Max's year is known. Licence check first (stop if it is Tim's own login and no spare seat). Pipes are plain polylines on 2026, so about 20 of 85 checks read differently. Detail: RELEASE_HANDOVER_PLAN_29OCT.md section 11a.
2. **Gap that stays open under every route:** a normal-login rehearsal on AutoCAD 2027 does not exist yet. If Max is on 2027 and no 2027 machine is available, the first 2027 normal-login install is on Max's own PC.

## 14. Two corrections picked up at 11:50 check (CE 02 / carpark)

1. **BUG-1209 and BUG-1210 (downpipe placement on a pit; Edit Pipe/Edit Pit plan picture) now apply to AutoCAD 2025 and 2026 as well, not only 2022 to 2024** (carpark commit d8fa0f78, "CE 02 correction"). So if Max is on 2025 or 2026 (or the 2026 laptop is used), those two pilot-critical bugs apply to him and to the laptop results. Question 22 and the pack must say "2022 to 2026", not "2022 to 2024". Detail is in the carpark entries; I have not re-read them.
2. **Hand checks:** commit 82c31173 says the 12 planned hand checks are complete (H14 CDRENUMBER passed). Tim-confirmed tool count per the ledger/PROGRESS.json is for CE 00 and CE 02 to recount; I have not re-read the ledger since 11:30.
