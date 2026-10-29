# Release scoreboard: Civil + Manager pilot hand-over to Max

**Owner:** CE 07 Release. One file, refreshed at least hourly. Others read it, they do not edit it.
**Last refreshed:** Thu 29 Oct 2026, 13:11 Melbourne (PC clock). Ledger entries H15 to H19 carry times about an hour ahead of the PC clock; I use the PC clock.
**Schedule in force:** Tim's item 69 (decisions\2026-10-29_TIM_ANSWERS.md): the pilot takes the newest build that has passed review and testing on **Fri 13 Nov**; the Fri 6 Nov freeze of option b is superseded. **Pilot Mon 16 Nov.** The dates inside the schedule (section 1, schedule E, matching CE 01's train calendar) are a proposal until Tim confirms them (question 42).
**Words:** Built, Tested, Installed and Tim-accepted are four separate facts (RULES 4). "Claude-accepted" and "Codex-accepted" are never Tim's word. Unknown stays Unknown.

---

# FOR TIM

1. **Will Mon 16 Nov hold? At risk, but a fair chance.** Mon 9 Nov is no longer the target. It holds if the everyday tools climb from 19 to about 30 of 40 (CE 02 estimates 26 to 30 by Sat 7 Nov), the latest builds get their tests, the weekend full re-test on Sat 14 and Sun 15 Nov passes, the install steps pass on an ordinary login, and Max's AutoCAD 2027 is in by Fri 13 Nov. Fallback is Mon 23 Nov.
2. **Days left:** 11 to Mon 9 Nov, 18 to Mon 16 Nov, 15 to the Fri 13 Nov cut-off (10 working days; Tue 3 Nov is Cup Day).
3. **The scores (two figures each).**
   1. **Gate list:** 1 of 9 done / 8 open (you confirmed gate item 1 and took gate items 6 and 7 out).
   2. **Pilot-critical bugs (60):** 0 of 60 closed by Claude / 0 of 60 confirmed by you. 26 fixes installed, 5 built not installed, 27 no fix.
   3. **Everyday tools (40):** 19 of 40 Claude-accepted (47.5 percent) / 17 of 40 confirmed by you (42.5 percent; PROGRESS.json 12:47, hand checks H1 to H18). Not passed yet: the OF and FO symbol (BUG-1236) and the "Show grade in pipe text" tickbox (found under More..., you dislike where it is; a design pass is running).
   4. **9 Nov-scope items (390):** built 47 percent (184 of 390) / tested 3.1 percent (12 of 390).
4. **Installed right now (I read the files at 13:11):** Civil 3.0.85 and Manager 1.1.85, commit 09126560, in all three folders (Legacy, Modern, Net8). Unchanged since 00:21. **Next: C-76 (Civil 3.0.86 / Manager 1.1.86)** passed its Opus final check ("GO", commit adcd57e4: double-click on a downpipe, CDCHECK wording, the Manager About window, DP speed). Its install package (payload 112, candidate c1072) is building; CE 01 plans to install it this evening after 5:30 pm when AutoCAD is closed. Undo: the old bundle folders are kept beside the new ones as backup folders; rename them back.
5. **Your decisions today that shape the plan:**
   1. **Max** is on AutoCAD 2022 now and will have 2027 before the pilot ("yes", read as by about Fri 13 Nov). The pilot is **2027 only**; nothing is installed on his PC until 2027 is in. His install rights are not answered.
   2. **Cut-off (item 69):** "other choice": the pilot gets the newest build that has passed review and testing on Fri 13 Nov. **Nothing is deferred (item 68):** every build goes in, and the release note says per item what was tested and what was not.
   3. **The one-piece pipe object is ON by default for everyone** (item 63, "defualt on for everyone"). That is a build and a full re-test; the tests so far already ran with it on, so they stay valid.
   4. The frozen copy goes in a separate `CE V3 PILOT` folder shared "can view" to Max only (created after your word on Fri 13 Nov); the old July install files move to an OLD folder now and are deleted later on a dated timeline; BUG-905 ON (0.9); BUG-1097 head after losses; BUG-1095, 1091, 1088 all built; BUG-1099, 1096, 1192 built; BUG-587 two-row-thick row with a wipeout mask (picture first); AG drains carry no text at all; BUG-1189 and 1149 keep as built; BUG-685 a one-line note; BUG-1148 a known limit on page 04; the settings-switch re-test point yes. The 2026 laptop is dropped (you will get 2027 on another PC and organise the ordinary login: "tomorrow maybe").
6. **Needs you, through CE 04:** confirm the dates in section 1 (question 42); Max's install rights; which PC is the second 2027 PC and when (item 37); two words on the test PC (items 38 and 39); the one-pass pack approval; whether any colleague still installs from the old July files before they are moved; your word on Fri 13 Nov.
7. **The main risk now:** more builds, fewer tests. the hotfix (C-81, Thu 12 Nov) gets an area re-test only until the confirming full pass on Sat 14 and Sun 15 Nov; so your "yes" on Fri 13 Nov is, in my proposal, conditional on that weekend result, with C-80 (fully re-tested on Tue 10 Nov) as the fallback build. You accepted that; the release note will say so.
8. **Nothing has been published, copied or sent to Max.**

---

# DETAIL

## 1. Schedule E (in force: Tim's item 69 plus CE 01's train calendar, BUILD_REGISTER "Train calendar to the Fri 13 Nov cut", which now matches my cut-offs; dates are proposals until Tim confirms, question 42)

1. **Thu 29 Oct, after 5:30 pm:** **C-76 installs, AREA class (wide):** the shared double-click redirect is touched (additions only), so every double-click case is re-tested, plus CDCHECK text, the DP/OF/floor-waste reading step and the Manager About window. Pilot cases P01 and P02; Codex looks G3 G7 G4 then H1 to H3 from 17:53.
2. **Fri 30 Oct, evening:** **C-77 installs, FULL class** (F-023 fresh-profile defaults and pipe object ON for everyone, Tidy default, grip default if its robot pass is in, and B-033/B-034/B-017/B-019/B-020 change answers). **Sat 31 Oct: full re-test 1.**
3. **Tue 3 Nov (Cup Day):** **C-78 installs, AREA class** (council time of concentration, long-section warning, rainfall note, cover screens, CDRULES row; FULL if B-012 cover lands there). Catch-up re-tests, rehearsals R2 and R3, Max-like run.
4. **Fri 6 Nov, evening:** **C-79 installs, FULL class** (B-030 AG drain copy touches the link kind and Undo; B-029 changes the CDDESIGN window and reuse credit; the large window items B-027 picture part, B-028, B-029, B-030 come here, early; declutter slices B-043a to c). Codex looks Sat 7 to Mon 9 Nov. **Sat 7 Nov: full re-test 2** (second start Sun 8 Nov if needed).
5. **Mon 9 Nov, after 5:30 pm: C-80, the LAST FULL-CLASS INSTALL** (guidebook slices B-042 and later, declutter S4 and S5 B-043d/e). **Tue 10 Nov evening: the pre-pilot full re-test** (66 checks twice, about 6 h 40 min, ends before about 00:30).
6. **Wed 11 Nov: packaging starts** from the newest tested build; Opus builds the per-item "tested / not tested" list (CE 02 is writing the first cut); pack approval (Tim, one pass) by Wed 11; page 04 final Thu 12.
7. **Wed 11 to Thu 12 Nov noon: C-81, AREA hotfix only.** Opus release report Thu 12 (what passed, what is known, how to roll back). Tim's soak runs Mon 9 to Thu 12.
8. **Fri 13 Nov (the cut):** Tim and CE 02 name the newest TESTED build (C-80 plus any hotfix); untested builds stay out of the pilot build but still ship to Tim's PC. Final go checklist (hand-over plan section 8); Tim's "yes, hand it to Max". Max's 2027 should be in.
9. **Sat 14 and Sun 15 Nov: a confirming full pass on the exact named build** (CE 02: "the last full proof of the exact build Max gets"). My proposal: Tim's yes is conditional on it, with a final confirmation Sun 15 night. If it fails, Max gets the last build that passed a full re-test (C-80 as tested on Tue 10 Nov) or the pilot slips to Mon 23 Nov.
10. **Package copy and share (publishing):** the `CE V3 PILOT` folder is created and shared "can view" to Max only after Tim's word AND the Sun 15 night confirmation (Mon 16 morning at the latest).
11. **Mon 16 Nov:** hand-over, if Max's 2027 is in. Fallback Mon 23 Nov.
12. **Not ready by Mon 9 Nov (CE 01's honest estimate; goes on page 04 as "coming"):** BUG-685 and BUG-1148 (wait for Tim's rulings; BUG-1148 is a known limit), BUG-1171 (needs a Shared train), the facts bugs BUG-1166, 1169, 1170, 855, 865 (not code), and, if C-79 or C-80 slips, B-029, B-030, B-043d/e and later guidebook slices; also B-031 and B-032 until confirmed. CEMEMBER (Structural) is not in the pilot build. **The named fixes B-017, B-019, B-020, B-033, B-034 and F-023 are not expected to slip.**
13. **Cost of Tim's choice (accepted):** the hotfix reaches Max with an area re-test and the weekend confirming pass only; the release note says "tested in these areas, not in full". **Biggest risks:** C-79 or C-80 slipping (the large window items); the one dotnet build lane; Max's 2027 not in by Fri 13 Nov; a FULL-class change sneaking into C-81.

## 2. Gate list (the 11 items at the top of release-v3-colleagues.md; items 6 and 7 removed by Tim, 29 Oct)

1. **Item 1, administrator set-up on Tim's PC (BUG-476): DONE and CONFIRMED BY TIM** (29 Oct, question 26; Codex W53 PASS 3 of 3 on 10 Oct). Other PCs not shown.
2. **Item 2, Roll Back hidden (BUG-477, BUG-441): OPEN.** Records disagree. Needs a Codex look at Manager (C2).
3. **Item 3, update route or reworded messages (BUG-478): OPEN, decided.** Updates by hand during the pilot.
4. **Item 4, old install scripts moved (BUG-483): TIM SAID YES, NOT DONE.** "yes - set a timeline to delete". Move five items to an OLD folder first (nothing deleted); proposed delete-review date Mon 14 Dec (a guess for Tim to change). Before moving, ask whether any colleague still installs from them.
5. **Item 5, fault report and CEMANAGERDIAG code the login (BUG-488): OPEN.** Fallback: Max told not to press them.
6. **Items 6 (BUG-495) and 7 (BUG-496), Structural only: OUT OF THE GATE** (Tim: Structural stays on his PC only).
7. **Item 8, units (BUG-505): OPEN.** Tim said yes; B-010 queued, not started; robot cases C35, C36 not recorded passing.
8. **Item 9, no blue (BUG-517): OPEN, partly built.** B-027 (BUG-525) queued; the long-section water line may stay blue (Tim); needs Codex look C1.
9. **Item 10, nothing off the PC (BUG-549 family): OPEN.** AI OFF and Structural not shipped; Codex look C3.
10. **Item 11, Structural 1.0.113 and C-35 installed plus a driver pass: OPEN.** Install met; the driver pass was not found.

Gate score: **1 of 9 done / 8 open.** Open: items 2, 3, 4, 5, 8, 9, 10, 11.

## 3. Pilot-critical bugs (the 60; PILOT_CRITICAL_TEST_LIST_29OCT.md)

1. **Closed (Claude-accepted or Tim-confirmed): 0 of 60.**
2. **Fix installed, awaiting acceptance: 26.** Plus 1 installed but OFF (BUG-905, now ruled ON) and 1 document fix (BUG-1173).
3. **Built, not installed: 5** (BUG-1189 and 1149, ruled keep as built; 1090 needs rebase and review; 1052 and 1053 need review).
4. **No fix: 27.** Queued B-016 to B-034; none started at the last register read. All in the build, as many as are reviewed and tested by Fri 13 Nov.
5. **Exit rule for 16 Nov:** each of the 60 is closed, written on page 04 as a known problem with a workaround, or switched off.
6. **Robot-provable now:** P01 and P02 (tonight); more if CE 02's four runner changes and four test drawings land (CE 02 confirms Friday midday). The five engineering fixes (BUG-905, 1097, 1095, 1091, 1088) need Codex looks; the robot cannot read those tabs (ENGINEERING_FIX_PROOF_PLAN_29OCT.md).
7. **All rulings are in** (TIM_ANSWERS items 30 to 55): nothing is waiting on Tim for the pilot-critical list; the work is building and proving. BUG-1148 stays unfixed for the pilot (one line on page 04); BUG-587 is two-row-thick with a wipeout mask (picture first).
8. **Scope (carpark, CE 02):** BUG-1209 and BUG-1210 apply to AutoCAD 2022 to 2026. Max is going to 2027, so they stay on page 04 only as a note for anyone on an older year. I have not re-read the entries.

## 4. Everyday tools (the 40; EVERYDAY_TOOLS_STATUS_29OCT.md)

1. **Claude-accepted: 19 of 40 (47.5 percent).** CE 00 ruled PIT and CD are the same checks as D01 and D12, not counted twice. CE 02 notes the plan names only 38 of the 40.
2. **Tim-confirmed: 17 of 40 (42.5 percent; PROGRESS.json 12:47).** D06 (tickbox) and the OF/FO symbol are not passed.
3. **Estimate (CE 02):** 20 to 22 by Fri 30 Oct, 26 to 30 by Sat 7 Nov. The 30 target is now Sat 7 Nov.
4. **Next:** CDTWL freeboard, layers D24, schedule order D21, hide grade D06, Excel export D23, D13 (needs Tim), CDCHECKDWG D28, mid-pipe label D10, D05 and D07 after their builds.

## 5. Plan numbers (PROGRESS.json, counted 29 Oct 12:47)

1. **Whole plan (548):** built 300 of 548 (54.7 percent) / tested 12 of 548 (2.2 percent). Plan last recounted 28 Oct 18:12.
2. **9 Nov scope (390):** built 47 percent installed (184 of 390; 290 including unshipped drafts) / tested 3.1 percent (12 whole; 26 counting parts). Never mixed with the 40 tools. About 100 scope items are unbuilt and are not pilot blockers.
3. **Meters (USAGE.json 12:47):** Max 4 percent five-hour / 85 percent week; Codex 13 percent week; Team week 41 percent, stale (28 Oct 18:10).

## 6. Build trains

1. **Installed (CE 07 read the DLLs at 13:11):** Civil 3.0.85 and Manager 1.1.85, commit 09126560, Legacy, Modern and Net8 for both; equal to candidate C:\ce_rc_scratch\c1071 (903 files). Structural 1.0.125 (not shipped). Tim's AutoCAD (pid 30056, since 09:14) is open.
2. **C-76 (3.0.86 / 1.1.86): FINALIZER GO** (CE 01, 12:49): branch claude/rel-20261029a head adcd57e4, four PRs kept (#1834 BUG-859, with a finalizer fix so the double-click stop respects options.compoundBehaviorEnabled; #1835 BUG-372; #1836 BUG-090, needs a Codex look, Manager changed; #1837 BUG-1228). Diff 24 files. Payload 112 (candidate c1072) building since 12:49; install this evening after 5:30 pm through the install chain (waits for AutoCAD closed, the robot lock, the settings guard and every Codex job). CE 02's order is install first, robot second. #1838 (BUG-1229) goes to C-77.
3. **C-77:** backlog B-005 to B-015 plus Tim's named fixes B-017 (BUG-1095), B-019 (BUG-1091), B-020 (BUG-1088), B-033 (BUG-905), B-034 (BUG-1097) plus F-023 (B-035), as far as PR-ready at the Fri 06:00 cut. Two build lanes since 12:03; builds still run one at a time; both lanes done Thursday about 17:00 to 20:00 if nothing stalls; CE 01 rates all nine backlog items making C-77 at about 70 percent (was 50). B-006 has a draft PR #1839. Saturday's full re-test runs on whatever is installed at Fri 21:00; C-76 is the safe base.
4. **C-78 and later:** the rest. Pilot-critical (stay): B-012, B-013, B-016 to B-030, B-033, B-034. Large window work that needs a Codex look and is at risk of slipping past the cut-off: B-028 (BUG-587 row height), B-029 (BUG-1096 rainwater reuse boxes), B-030 (BUG-648, now "no text at all" so it may shrink), and the picture part of B-027. They go last; if not ready they are written on page 04. Tim's item 68 also puts B-031, B-032, B-036/037 (CEMEMBER), B-040, B-041, the New Pipe declutter and guidebook slice 1 into the build, after the pilot-critical items.
5. **B-035 F-023, colleague defaults, with the pipe object ON for everyone (FULL re-test class):** CE has 500 settings; Tim's file holds 222; the other 278 already match. A fresh profile gets built-in defaults, not Tim's switches, and no approved export exists (T5 item 14; Tim's file also carries his folder paths, BUG-1167). Plan: a shipped defaults file read only when a profile has no settings file (never overwrites, no folder paths, a damaged file falls back to built-ins), `options.pipeObjectUpgrade` On for everyone. Max would also see different snaps in CD, a light or auto window colour, a different lid type and rising-main start unless these are set (F023_COMPARISON_REPORT). Proof needs an ordinary login or the 2027 test PC; a headless unit proof exists meanwhile.
6. **Pilot lane:** Max moves to 2027, so the pilot lane is the Modern (2027) folder. The Legacy lane must still build and pass but has no pilot role unless his move slips.
7. **Add-ins:** CE.AutoCADLink.2027 and CE.Transform.Trial.2027 stay out of Max's package (CE 01 note); check B9 (Max-like re-run) proves it.

## 7. Re-test rules and capacity

1. After an install, re-test only what the fix touched; untouched cases are "carried from <build>" (Tim, 29 Oct). A fix whose only settings change is a brand-new switch counts as touching only its own tool (Tim, Addendum 1); editing, renaming or removing an existing setting (including defaults and the sizing and start-value files) is a FULL re-test, as is shared-code change. Examples (CE 02 estimates): an Edit Pipe fix 7 of 66 checks (about 1 h); a 3.0.85-type install 32 of 66 (about 3 h 25 min); PIT or CD fixes about 30; a core change (pit/pipe record, undo/redo, start-up) is FULL. **B-008, B-009, B-012, B-033, B-034 and B-035 each change an existing default or an engineering value, so the trains carrying them are likely FULL.**
2. A full set is 66 checks twice in 38 starts: about 6 h 40 min now, about 5 h 45 min after the shorter-wait change (CE 02 estimates).
3. Codex: weekly 13 percent; each look 1 to 3 points; daily caps 30 from Thu 17:53, 44 from Fri 17:53, 58 from Sat 17:53. Looks need Tim's AutoCAD closed.
4. **CE 02's capacity and class answers (29 Oct):** a full re-test fits any evening (66 checks twice in 38 starts, about 6 h 40 min, ends before about 00:30 from 17:30; less on the second 2027 PC). **Every pass of a case must be on ONE build, so any FULL-class install after a full re-test voids it and restarts the clock.** That means the hotfix C-81 (Wed 11 to Thu 12 Nov) must be AREA class, otherwise the Tue 10 Nov result no longer covers the build and only the Sat 14 and Sun 15 Nov pass remains. C-80 on Mon 9 Nov is the last FULL-class install. CE 02 states AREA or FULL with the reason in each robot job file and the desk log. C-76 is being classed by a Team Opus job reading the real diff (areas\C76_PROOF_PLAN_29OCT.md; the double-click redirect and the landing read are shared by DP, OF, floor waste and source picks). B-035 is FULL; anything touching CE_SHARED or the record is FULL. The per-item "tested / not tested" list is being written by CE 02 (areas\TESTED_NOT_TESTED_LIST_29OCT.md, first cut about 20 minutes after 13:27, refreshed after each re-test); I lift it into the release note.

## 8. Install rehearsal and the test PC

1. **Hand install on a normal login rehearsed: 0 of 2.** Rollback rehearsed: 0 of 1.
2. **Test PC:** the 2026 laptop is dropped. Tim: "i will get 2027 on that pc", "i will organise" the ordinary login, "tomorrow maybe". The office has spare AutoCAD licences (year and who assigns: not stated). No rehearsal starts until Tim says the login exists and which PC. CE 02: yes, it can run the robot nightly and the Codex looks if (a) it has an unlocked desktop Windows thinks has a monitor, no lock or sleep, auto-login, (b) the office gives it its own AutoCAD seat, (c) about half a day of reviewed runner changes lands first (the working-hours stop becomes per-machine, hard-coded C:\ paths and the profile name "Tim", the machine name in each run header, pointer calibration on three cases; an estimate). About 3 working days from Tim naming the PC, about 45 minutes of his time; if named by Fri 30 Oct the first proof runs Wed 4 Nov. Its results count as normal 2027 passes (TEST_PC_2027_ROUTE_29OCT.md). Two words from Tim are asked as items 38 and 39: the "Tim is drafting" hours do not apply on a PC Tim never uses; a Codex look there counts as "Codex-accepted (test PC name)".
3. **Max:** AutoCAD 2022 today, 2027 by about Fri 13 Nov. Nothing installed on his PC before 2027 is in. His install rights, folders, old Structural and Manager version are Unknown.
4. **If Max's 2027 is not in by about Fri 13 Nov,** the 16 Nov hand-over cannot happen on his own PC.
5. **Tim's PC all-users folder (read earlier):** the stale Manager 1.0.0 in C:\ProgramData is disabled (PackageContents.xml renamed), not removed.
6. **Colleague pack:** change list ready (RELEASE_PACK_CHANGES_FOR_APPROVAL_29OCT.md): 97 changes, 12 decisions. Wrong as drafted: "drawings are safe either way" after a rollback (BUG-1135). Approval by Wed 11 Nov once the content list is known.

## 9. Will it hold? (plain)

1. **Mon 9 Nov:** no, not the target any more.
2. **Mon 16 Nov: at risk, fair chance.** For: 10 working days to build, two full weekend re-tests, tools rising (19 to a likely 26 to 30), 17 of Tim's tools confirmed, all pilot-critical rulings in, a clear schedule. Against: 0 of 60 pilot-critical closed and the robot reaches only 2 of 26 installed fixes; most fixes not yet built; the one dotnet build lane; no rehearsal machine yet; Max still on 2022 with his 2027 only "by about Fri 13 Nov"; late builds get thin tests.
3. **What turns it to NO:** Max's 2027 not in by Fri 13 Nov; a FULL-class change after Tue 10 Nov; a rehearsal that finds an install fault needing a build; the C-77 or C-78 jobs stalling.

## 10. Idle, blockers, not moving (13:11)

1. **Running (session list):** CE 01 build, CE 09 (New Pipe window declutter), CE 10 (guidebook slice 1, pipe).
2. **Idle:** CE 00 Control Room, CE 02 testing, CE 03, CE 04, CE 05, CE 06 guidebook, CE 08 research.
3. **Not yet moved:** C-77 lanes (still unconfirmed); the second 2027 PC (item 37); Max's install rights; the old-files move (Tim said yes, not done; the colleague check before moving is not done); CE 02's runner changes (due Fri); Tim's confirmation of the dates (question 42); BUG-1209/1210 scope not yet in the pack.
4. **Blockers for Tim:** all in QUESTIONS_FOR_MONDAY.md for CE 04 (items 22 to 42; 31, 33 and 35 are withdrawn).

## 11. Decision log

1. **29 Oct (Tim, "option b"):** freeze Fri 6 Nov, pilot Mon 16 Nov. **SUPERSEDED the same day by item 69** (kept for the record).
2. **29 Oct (CE 02, accepted):** 30 of 40 by Fri 30 Oct is not reachable; target Sat 7 Nov.
3. **29 Oct (Tim):** questions only through CE 04; the 2026 laptop assessed then dropped.
4. **29 Oct (CE 00 via CE 01):** the two extra add-ins stay out of Max's package.
5. **29 Oct afternoon (Tim, TIM_ANSWERS items 24 to 55):** spare licences exist; Max "will have 2027, currently has 2022"; "i will organise" the ordinary login; the `CE V3 PILOT` folder; gate item 1 confirmed, items 6 and 7 out; the engineering rulings; "yes - set a timeline to delete" for the old July files.
6. **29 Oct (Tim, items 63, 68, 69):** the one-piece pipe object ON by default for everyone ("defualt on for everyone"); "nothing waits for the pilot, pilot get very latest version at the time of release, we try to test as much as we can"; cut-off "other choice": the newest tested build on Fri 13 Nov.
