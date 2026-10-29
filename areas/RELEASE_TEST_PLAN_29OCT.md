# Release test plan: the smallest set of checks before "yes, hand it to Max"

**Owner:** CE 07 Release. Written Thu 29 Oct 2026, 11:17 Melbourne; moved to schedule B (freeze Fri 6 Nov, pilot Mon 16 Nov) at 11:31. Draft until CE 00 and Tim see it; nothing here starts a run (CE 02 and CE 03 start their own).
**Sources:** release gate (release-v3-colleagues.md top), gap plan section 3 (22 Oct), Team audit T5 (24 Oct), PILOT_CRITICAL_TEST_LIST_29OCT.md, COLLEAGUE_READINESS_29OCT.md, Tim's rulings of 29 Oct (TIM_ANSWERS, TIM_RETEST_RULE), RULES 4.5 and the 24 Oct acceptance amendment.

---

# FOR TIM

1. **The answer.** 35 checks decide whether Max gets the build: 8 are package and install checks (mine), 9 are robot checks run twice (CE 02), 6 are Codex looks at windows and printed pages (CE 02), 2 are hand checks by you (CE 03), and 10 are your decisions (CE 04). Several overlap with each other, so the real count of separate sittings for you is small.
2. **Your hand checks are only two,** both on the final frozen build, about 20 minutes in total: the five-step walk Max will do (PIT, CD, Edit Pipe, Pit Schedule, CDFEEDBACK), and a look at one finished council sheet. Everything else is the robot, Codex or a spare login.
3. **The exit rule I propose for the 60 pilot-critical bugs.** By Fri 13 Nov each of the 60 is one of: closed (Claude-accepted or Tim-confirmed), written on page 04 as a known problem with a workaround, or switched off and not offered to Max. Nothing is left unaccounted for. That is realistic where closing all 60 is not, because the robot can reach only 2 of the 26 installed fixes today.
4. **What I need from you this week** (each sits in QUESTIONS_FOR_MONDAY.md as a numbered item for CE 04): Max's AutoCAD year and whether his login has administrator rights; a spare standard Windows login; the frozen-copy folder; the old-files move; one-pass approval of the pack; a few engineering words. Detail in section 6.

---

# DETAIL

## 1. How a check is judged (no change to anyone's rules)

1. **Robot twice:** two separate AutoCAD starts on the same build, a failing twin, an independent reviewer who has named the case hash (24 Oct amendment). A carried pass from an earlier build counts if the install did not touch that area (29 Oct re-test rule), and says "carried from <build>".
2. **Codex look:** needed for anything the drafter must see (a window, a picture, a label position, a printed page). A Codex PASS counts as "Codex-accepted" (RULES 4.5), never as Tim's word.
3. **Tim:** only for engineering judgement or a decision. Tim can reject anything.
4. **Package and install:** judged by hash read-back and by a person (or Codex) following the written steps on a login that is not Tim's.
5. **All of it runs on the frozen candidate** (section 4). A check run on an earlier build is evidence only, not a sign-off.

## 2. The checks, by owner

### A. Package and install (owner CE 07; CE 01 builds; the rehearsal login comes from Tim)

1. **A1 Frozen copy equals the tested build.** Every file in the frozen folder has the same SHA-256 as the candidate folder (today C:\ce_rc_scratch\c1071 equals the installed 3.0.85 bundle: 903 files, six DLL hashes equal). Gap plan 3.2, T5 item 1 and 6.
2. **A2 Civil and Manager carry the identical shared file** in all three lanes (Legacy 2022 to 2024, Modern 2025 to 2026, Net8 2027). T5 item 2.
3. **A3 Hand install rehearsed twice** on a spare standard Windows login, no administrator rights: both bundles arrive; CE_VERSION (About) shows Civil and Manager; Structural "Not loaded"; whether AutoCAD asks "Load / Always Load" written down; CEHEALTH all [OK]. Gap plan 3.1, T5 item 7.
4. **A4 First start on a fresh profile leaves a clean CE log.** T5 item 22.
5. **A5 Rollback rehearsed once on that login,** including all five settings folders and the CE Manager menu (BUG-1173), ending with no CE menu and no leftover folders. T5 item 18.
6. **A6 Max's starting switches equal Tim's,** compared value by value, with every folder path blanked (F-023, BUG-1167); differences listed for Tim's yes. Gap plan 3.12.
7. **A7 Max's PC facts gathered:** AutoCAD year (ABOUT), whether his login has administrator rights, his Manager version, his old July Structural 1.0.41 (switch off or move aside, BUG-1169), the all-users plug-in folders on his PC (BUG-1165), where his OneDrive puts "Creative Engineering - Drafting" (BUG-1166, BUG-1168), the pilot results folder write access. T5 items 8 to 13, 24.
8. **A8 If Max is not on AutoCAD 2027:** start-up and one of Tim's drawings (with one-piece CE pipes) opened on his year, with BUG-1209 and BUG-1210 written on page 04. Gap plan 3.14.

### B. Robot, twice (owner CE 02)

1. **B1 The 40 everyday tools: at least 30 Claude-accepted** (19 today). Checkpoint Fri 30 Oct. Target of 40 of 40 is not claimed.
2. **B2 Import units:** a metre drawing and a unitless drawing never come in 1000 times too big (C35, C36; BUG-505 build B-010 first).
3. **B3 REDO:** C31 to C34 pass, or BUG-861 is on page 04 as a known problem (cause still unknown, the 3.0.78 fix did not work).
4. **B4 Clean start-up log (C03) and an honest outcome log line (BUG-862),** because the other tests read it.
5. **B5 Pilot-critical robot cases:** P01 (BUG-1194), P02 (BUG-1140), then each case unlocked by a test drawing or reviewed runner change in PILOT_CRITICAL list section C.
6. **B6 Engineering HIGH 1, 2, 3** (route length for grade, solver material, rainfall note): drawing values by robot, wording by Codex look, or a plain warning on the tool.
7. **B7 Tim's new defaults:** Tidy labels ON, grip copy ON (needs a robot pass with it ON first, Tim 29 Oct item 9), BUG-1226 Recent levels (N30), DP speed N31 against control C31, grade-not-flatter N32.
8. **B8 Full re-test on the frozen candidate:** weekend 1 Sat 31 Oct, an early run Tue 3 Nov, and the pre-pilot full re-test on the freeze candidate Sat 7 and Sun 8 Nov. All accepted cases still PASS; any regression is a stop.
9. **B9 Max-like configuration re-run:** the release-critical cases re-run once with `CE.AutoCADLink.2027` and `CE.Transform.Trial.2027` moved aside (restored by hash; Tim's 29 Oct yes covers it), planned by CE 02 for the Tue 3 Nov full re-test and reported with the BUG-861 control run. Any case that changes is a finding for Max's page. Evidence for Max's PC, not proof of it.

### C. Codex looks (owner CE 02; held until Tim is off AutoCAD, rule 1.8)

1. **C1 No blue:** the three windows Max uses most, the ribbon icons, and the printed computations sheet opened as a PDF (BUG-517, BUG-525).
2. **C2 Manager window:** Roll Back and Update hidden or clearly marked "do not press"; About window grows to fit its rows after C-76 (BUG-090); CEMANAGER Status page truthful (gate 2, T5 17 and 23).
3. **C3 Nothing leaves the PC:** AI features OFF message, X-Civil AI extraction and CDASK send nothing, layout tab sends nothing (gate 10 and 11, T5 15).
4. **C4 CDCALC and CDDESIGN windows:** blank Catchments (BUG-1101), 300 mm head warning (BUG-1097), council shown as Glen Eira (BUG-1106), rainfall note wording (BUG-866 build B-016).
5. **C5 Other windows:** Help "Feedback" page wording (BUG-1215), Drawing Repair wording (BUG-1180), Pit Schedule export Cancel then CLOSE with no "Save changes?" (BUG-1198), ribbon tab with Manager loaded first (BUG-1206).
6. **C6 Daily-path looks that have real faults on record:** CDCHECKDWG summary line, ribbon tab jump on selecting a pipe or pit, label positions after a pit move (Tim's question 19).

### D. Tim's hand checks (owner CE 03; two only)

1. **D1 The five-step walk on the final frozen build:** PIT, CD, Edit Pipe, Pit Schedule, CDFEEDBACK, as the gap plan day-of check. Right looks like: each does what the page for Max says, nothing slow enough to worry (DP and PIT speed, BUG-1228), CDFEEDBACK prints one honest result line.
2. **D2 One finished council sheet from a real job copy:** read the computations sheet and the Pit Schedule for what Max would hand a client (cover to the outside, the HGL "not calculated" line, rainfall note). Tim judges the engineering.

### E. Tim's decisions (owner CE 04; section 6 has the list)

## 3. Pass line for "yes, hand it to Max" (Fri 13 Nov, pilot Mon 16 Nov)

1. A1 to A6 all green; A7 all facts recorded; A8 green or Max is on 2027.
2. B1 at 30 of 40 or more; B2 to B8 green; no regression in the last full re-test.
3. C1 to C6 each Codex-accepted or the item written on page 04 as a known problem.
4. D1 and D2 passed by Tim, and every E decision answered (or the default written down as Tim's word).
5. Each of the 60 pilot-critical bugs is closed, a known problem on page 04, or switched off.
6. Page 04 final from the frozen build (due Wed 11 Nov); pack approved by Tim.
7. Tim says "yes, hand it to Max" in chat. Without that word nothing is copied or sent.

## 4. Which build gets signed off (Tim, 29 Oct: option b)

1. **Freeze candidate = the build installed on Tim's PC after 5:30 pm on Fri 6 Nov:** C-76, C-77 and the pilot-critical fixes CE 01 can build and get reviewed by Thu 5 Nov (B-016 to B-032, as many as are ready). Anything not reviewed by then waits for the release after the pilot and goes on page 04.
2. **Why the line is firm:** every install after the candidate restarts the two-pass clock for the area it touches (re-test rule). The pre-pilot re-test must run on one installed build.
3. **Large-batch warning (Tim, 16 Sep):** 17 fixes in one train is large. Ask CE 01 to land them in two trains (C-78 around Wed 4 Nov, C-79 on Fri 6 Nov) so Sat 7 Nov tests a build most of which has already had a weekday of checks.
4. **Rule for the last 24 hours:** after Fri 6 Nov only a blocker is fixed, and a blocker means a new candidate plus a full re-test.

## 5. Schedule B (Melbourne; AutoCAD only in free windows, rule 1.8)

1. **Thu 29 Oct:** C-76 installs; check lists sent; P01 and P02 after 5:30 pm; Codex G3 G7 G4 then H1 to H3.
2. **Fri 30 Oct:** C-77 assembled and installed Friday night; Max's year known; rehearsal R1 if a login exists; Codex H4 to H6, G6, G5.
3. **Sat 31 Oct:** weekend re-test 1 on the installed C-77.
4. **Sun 1 to Mon 2 Nov:** fix builds and reviews; soak continues.
5. **Tue 3 Nov (Cup Day):** early Max-like run (check B9), Codex looks C1, C3, C6, rehearsal R2 and R3 on the current build.
6. **Wed 4 and Thu 5 Nov:** C-78 and C-79 assembled; Opus finalizer; page 04 drafted.
7. **Fri 6 Nov:** freeze candidate installed after 5:30 pm.
8. **Sat 7 and Sun 8 Nov:** pre-pilot full re-test (two separate starts), Codex looks, Max-like run, R2 and R3 on the final build.
9. **Mon 9 to Thu 12 Nov:** Tim's soak and his hand checks D1 and D2; pack approved Mon 9; package built from the frozen folder Tue 10; page 04 final Wed 11; Opus freeze report Thu 12.
10. **Fri 13 Nov:** final go checklist; Tim's word.
11. **Mon 16 Nov:** hand-over. Fallback Mon 23 Nov.

## 6. What Tim must decide (numbered items go to CE 04 / QUESTIONS_FOR_MONDAY.md; each with a recommendation)

1. **Max's AutoCAD year and his Windows rights.** Recommend: Tim asks Max to type ABOUT and tell him whether he can install programs on his PC; nothing else moves without it.
2. **A normal (non-administrator) Windows login on a second machine for the rehearsals (by Fri 30 Oct).** Tim, 29 Oct: the spare 2027 PC is not possible now; he proposed a laptop with AutoCAD 2026. See RELEASE_HANDOVER_PLAN_29OCT.md section 11 for what that tests (the Net8 folder, not his 2027 one) and the questions.
3. **Where the frozen copy sits** (publishing). Recommend: a separate `CE V3 PILOT` folder, July copies untouched.
4. **The old-files move (BUG-483).** Recommend: yes, move the July scripts and builds to an OLD folder before 16 Nov.
5. **Confirm the administrator list is right** (gate 1) **and that Structural items 6 and 7 are out of the gate** (Structural stays on his PC).
6. **One-pass approval of the colleague pack** from RELEASE_PACK_CHANGES_FOR_APPROVAL_29OCT.md (up to 12 yes/no items) by Mon 9 Nov.
7. **Freeze content: DECIDED (Tim, 29 Oct, option b):** C-76, C-77 and the pilot-critical fixes built and reviewed by Thu 5 Nov. BUG-1095, 1091 and 1088 are in the build list (B-017, B-019, B-020).
8. **Engineering words that change page 04:** BUG-905 (hard-ground C, is 0.9 right?), BUG-1097 (300 mm rule applies to which head), BUG-1189 (survey Xref detached after approval), BUG-1149 (stage drawing BIND or detach), BUG-685 (typed level never moved?), BUG-1148 (made-in-this-drawing stamp). Recommended answers are in PILOT_CRITICAL_TEST_LIST and BATCH reports.
9. **Max's old July Structural, the stale Manager 1.0.0 copy, who installs on the day, results folder write access, reply time, practice drawing:** page 06 questions 1, 3, 4, 11, 12, 13; recommendations already written there.
10. **Fri 13 Nov: "yes, hand it to Max".** The date is settled: pilot Mon 16 Nov (Tim, 29 Oct, option b).

## 7. Tracking: is each owner moving?

I check each owner's files every 30 minutes (section 8). A line goes in RELEASE_SCOREBOARD.md section 10 whenever an assigned item has no movement for 4 hours in work hours or by the next free window.

## 8. My own 30-minute check

1. Refresh RELEASE_SCOREBOARD.md: PROGRESS.json, USAGE.json, ledger tail, carpark tail, QUEUE and BUILD_REGISTER, DESK_LOG tail.
2. Who is idle (list_sessions); blockers for Tim go to QUESTIONS_FOR_MONDAY.md as numbered items.
3. Report to CE 00 only for a decision, an install-ready release candidate, a slipping date, or a plan number that moved.
4. Push CE_PLAN by name, never `git add -A`.

## 9. What I did NOT verify

1. I ran nothing: no AutoCAD, robot, Codex or build.
2. Installed versions were read from the DLLs (Civil 3.0.85, Manager 1.1.85, 09126560); source-based statements about pilot-critical fixes come from CE 02's list.
3. The robot and Codex schedules above are proposals until CE 02 confirms them.
4. Counts of checks (35) are mine and will change as CE 02 refines the pilot cases.
