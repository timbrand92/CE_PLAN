# Colleague release readiness, Thu 29 Oct 2026 (Sonnet desk assistant, about 11:10 to 12:00 Melbourne)

**What this is.** Tim asked: "hows overall progress towards our colleague issue" (the pilot hand-over to Max, target Mon 9 Nov 2026). Read-only job: I read files and counted. I did not open AutoCAD, run the robot, start Codex or build anything. The only file written is this one.

**Sources read:** the gate list at the top of `areas\release-v3-colleagues.md`; `BUG_CARPARK.md` (parsed by script, see section 8); `ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md` (items 13 to 28 and the hand checks H1 to H4); `areas\release-v3-colleagues-QUEUE.md` installs 296 to 310; the tail of `areas\release-v3-colleagues-DESK_LOG.md` (to 10:55 today); `decisions\2026-10-29_TIM_ANSWERS.md`; `areas\colleague-pack\01` to `06` and `COLLEAGUE_KNOWN_PROBLEMS_DRAFT_25OCT.md`; the five pilot-critical batch reports and four reviews; `PLAN_RECOUNT_28OCT_2026.md`; `V3_RECOUNT_2026-10-24.md`; the 18 Oct recount; `RELEASE_9NOV_GAP_PLAN_2026-10-22.md`; `RELEASE_9NOV_TODO_FROM_T5_2026-10-24.md`; `TEAM_AUDIT_T5_24OCT.md`; `BUG_REGISTER_TRIAGE_2026-10-24.md`; `BUILD_REGISTER.md`; `PROGRESS.json`.

---

# FOR TIM

1. **The honest answer.** A small, hand-installed pilot for Max on Mon 9 Nov is still possible, but I think Mon 16 Nov (the fallback date already written into the gap plan) is the more likely date, because nobody has yet rehearsed the hand install on an ordinary Windows login, the everyday-tools score is 19 of 40 against a target of 30 by tomorrow (Fri 30 Oct), and none of the 60 pilot-critical bugs is accepted yet. This is my reading of the files, not a measurement.

2. **The three biggest blockers.**
   1. **The hand install has never been tried on a normal login.** There is no spare standard Windows login, nobody has recorded Max's AutoCAD year or whether his login has administrator rights, and old CE copies in his all-users plug-in folders could beat the new one. I found no record of a rehearsal in any file I read.
   2. **Acceptance is far behind.** Everyday tools: 19 of 40 Claude-accepted, 3 of 40 confirmed by you. Pilot-critical bugs: 0 of 60 Claude-accepted, 0 of 60 confirmed by you. Ten of the serious wrong-answer bugs have no fix at all because each needs your engineering word.
   3. **Your yes is needed on four things, and none has been given.** The colleague pack (all drafts), where the frozen copy sits (publishing), the old install scripts move, and the final "yes, hand it to Max" (due Fri 6 Nov). Without these the build can be perfect and still not go.

3. **The scores (two figures each, never merged).**
   1. **Release gate list:** 1 of 11 done / 10 open. The one done is the administrator set-up on your PC (a Codex look saw it; you have not confirmed it; other PCs not shown). Two of the ten (Structural items 6 and 7) fall away if Structural stays on your PC only, which is your 17 Oct ruling, but you have not said so for the gate list itself.
   2. **Pilot-critical bugs (60):** Claude-accepted 0 of 60 / confirmed by you 0 of 60. A fix is built for 33 of the 60; 24 of the 27 new fix PRs are installed on your PC; 27 of the 60 have no fix yet.
   3. **9 Nov scope (390 plan items):** built 47 percent (184 of 390) / tested 3.1 percent (12 of 390 whole; 6.7 percent counting parts, 26 of 390). Tested means a reviewed robot pass in AutoCAD; four of the 12 also have a Codex look that passed.
   4. **The 40 everyday tools:** Claude-accepted 19 of 40 (47.5 percent) / confirmed by you 3 of 40 (7.5 percent). The 20th (CDTWL freeboard) counts once three more robot passes finish.

4. **Only you can decide or do these.**
   1. **Publishing.** Where the frozen release copy sits (recommended: a separate `CE V3 PILOT` folder). Placing it there is publishing. Then your word "yes, hand it to Max" on Fri 6 Nov.
   2. **Administrator set-up.** Confirm the administrator list is right (gate item 1). Remove the stale Manager 1.0.0 in the all-users plug-in folder (needs administrator rights; the 20 Oct record says not done, I did not re-check). Provide or approve a spare standard Windows login for the dry runs (a Windows security setting, not ours to make).
   3. **The old-files move.** Move the old July install scripts and builds in the IT Admin folder to an OLD folder (BUG-483). Recommended yes, before 9 Nov, so nobody runs a July script over Max's install.
   4. **Colleague pack approval.** Pages 01 to 05 are drafts of 22 Oct (the known-problems page has a newer 25 Oct draft). Page 06 holds 20 questions for you; the engineering ones were answered or ruled today, the rest are open (section 4).
   5. **Facts only you can get.** Max's AutoCAD year, whether his login has administrator rights, who installs on the morning, whether the pilot results folder is shared with him.
   6. **Open engineering calls on the daily path.** Survey XREF detached after approval (PR #1756, BUG-1189); stage drawing BIND versus detach (PR #1767, BUG-1149); which head the 300 mm charged-system minimum means (PR #1772); the rainfall curve (BUG-866, "leave them until you've checked the curve").

5. **What to expect next.** Checkpoint 1 is tomorrow, Fri 30 Oct. The freeze is Mon 2 Nov; Tue 3 Nov is Cup Day. Train C-76 (Civil 3.0.86) is assembling now: the downpipe double-click, CDCHECK wording, the About window, the slow DP, and the grade that rounded flatter than chosen.

---

# DETAIL (nothing below needs action from you)

## 1. Gate list, item by item (the 11 items at the top of the release area file)

How I scored: "done" needs evidence the condition is true AND seen working. Bug statuses in the carpark lag the installs, so I also used the 24 Oct triage and the train reports.

1. **Administrator set-up on your PC (BUG-476): DONE on your PC, not yours to confirm yet.** Codex W53 PASS 3 of 3 on 10 Oct: the shared admin list holds one entry, your Windows login. Not shown: arrival on other PCs. BUG-843 (no way to add a second administrator) is a separate open question. Evidence: carpark BUG-476, report `CODEX_VERIFYW53_2026-10-10.md`. **Tim's call:** confirm it.
2. **Roll Back hidden (BUG-477, BUG-441): OPEN.** The 24 Oct triage lists BUG-477 as installed under a hunt label and BUG-441 as installed in 3.0.70, neither tested. The same day the T5 audit (item 17) rated "Update and Roll Back buttons are hidden from a colleague" NOT MET. The two records disagree and I did not open Manager. Page 02 of the pack tells Max not to press them. Evidence: `TEAM_AUDIT_T5_24OCT.md` item 17; `BUG_REGISTER_TRIAGE_2026-10-24.md` section A.
3. **A real update route, or reworded messages (BUG-478): OPEN, decided.** The gap plan cuts the update button and the self-serve installer: you update Max by hand during the pilot (your 20 Oct yes). BUG-478 is still OPEN and I found no record that the update messages were reworded. Quiet update at next start (UX-MGR-04) moves to after 9 Nov. Evidence: gap plan section 1b item 1; pack page 02.
4. **Old install scripts moved to an OLD folder (BUG-483): TIM'S CALL, not done.** T5 item 29: UNKNOWN. Evidence: pack page 06 question 6.
5. **Fault report and CEMANAGERDIAG code the login and folders (BUG-488): OPEN.** The gap plan (22 Oct) says no fix; the 24 Oct triage lists BUG-488 among bugs installed under a hunt label. I could not tell which is right without opening the build. The gap plan says Max is told not to press either; the pack drafts I read name the Roll Back, update and Admin buttons (pages 02 and 04) but not CEMANAGERDIAG or the support bundle. Evidence: gap plan section 3 item 4; triage section A.
6. **Publish Issue stamps only ticked sheets (BUG-495): OPEN, Structural only.** Falls away for 9 Nov if Structural stays on your PC (ruling B3, 17 Oct). **Tim's call:** confirm it is out of the gate list.
7. **Job record lives with the job (BUG-496): OPEN, Structural only.** Same position as item 6.
8. **X-Civil and LandXML units (BUG-505): OPEN.** A fix is installed but failed real AutoCAD twice (Codex V3b-04 FAIL 21 Oct, V8-01 DIFFERENT 22 Oct). Your 29 Oct answer: yes, keep reading as millimetres and print one soft line "This drawing has no units set; CE read it as millimetres." That build item is queued (B-010, not built). Robot cases for the unit imports (C35, C36 in the gap plan) are not recorded as passing in anything I read. Evidence: `decisions\2026-10-29_TIM_ANSWERS.md` item 10; `BUILD_REGISTER.md` B-010.
9. **No blue anywhere a colleague sees (BUG-517): OPEN, partly built.** The printed computations sheet colour is in the installed line (PR #1783 part g, train C-69, Civil 3.0.79), built and unit-tested only. The other blues (BUG-525: windows, ribbon icons, help) have no PR and need your colour word. A Codex look at three windows and the printed sheet is owed. Evidence: `TRAIN_C69_FINALIZER_REPORT_2026-10-26.md`; `PILOT_CRITICAL_BATCH5_REPORT.md` (BUG-525).
10. **Markup and chat send nothing off the PC (BUG-549 family): OPEN.** Structural BUG-549 fix is installed (1.0.121) and Civil BUG-551 (X-Civil AI extraction, CDASK) fix is installed (3.0.70, PRs #950 to #952); neither is tested. BUG-550 is open and PR #1794 (the MarkupAI switch) was dropped after a Codex hold. For the pilot, AI features are OFF and Structural is not shipped. T5 item 15 ("nothing personal leaves Max's PC") was NOT MET on 24 Oct. Evidence: `OFF_PC_CALLS_2026-10-09.md`; queue item 305.
11. **Structural 1.0.113 and the Civil privacy train C-35 installed: OPEN by the gate's own words.** The install condition is long met (PROGRESS.json says Civil 3.0.85, Manager 1.1.85, Structural 1.0.125; I did not re-read the DLLs). The gate keeps the item open until a driver pass shows the AI-off messages, nothing sent and the layout tab sending nothing. I did not find that pass.

**The independent 30-item checklist (T5 audit, 24 Oct) is a stronger scoreboard than the 11 items:** 6 met, 14 not met, 10 unknown. I did not re-score it. Things that have moved since: the three engineering HIGHs (item 25) are better (HIGH 1 and HIGH 2 installed; HIGH 3, the rainfall note, still needs your word); everyday tools (item 26) went from 1 to 19 of 40; the known-problems page (item 27) has a 25 Oct draft but is not final. Items 7, 8, 9, 10, 11, 12, 13, 22, 24, 28, 29 are still facts nobody has gathered (see `RELEASE_9NOV_TODO_FROM_T5_2026-10-24.md`, 21 jobs, none recorded as done).

## 2. What went in lately (queue installs 303 to 310)

1. **Installs:** eight, 26 to 29 Oct. Civil/Manager 3.0.79 (C-69), 3.0.80 (C-70), 3.0.81 (C-71), 3.0.82 (C-72), 3.0.83 (C-73), 3.0.84 (C-74), 3.0.85 (C-75, 29 Oct 00:21); Structural 1.0.125 (S-45, 27 Oct).
2. **What they were:** bug fixes, wording and switched-off diagnostics. No whole plan item was added (recount 5 checked this).
3. **Hand-confirmed by you on 3.0.85 this morning:** BUG-1225 (downpipe after reopen), BUG-665 (ROTATE Copy label, SCALE Copy not tried), BUG-1222 (Edit Pipe second Save), PIT and CD keep placing until Esc, Recover Inverts, EXPLODE a pit. New faults you found: BUG-1228 (DP and PIT slow), BUG-1229 (grade shown 1 in 102), BUG-1230 (preview, on hold), BUG-1231 (EXPLODE noise).
4. **Waiting:** train C-76 (not built or installed): #1834 (BUG-859, downpipe double-click), #1835 (BUG-372), #1836 (BUG-090), #1837 (BUG-1228, DP speed, not yet timed), #1838 (BUG-1229).
5. **Still real faults on the build:** REDO lost after a pit pick (BUG-861, cause unknown, the fix in 3.0.78 does not work), DP double-click (BUG-859, fix queued), CDCHECK wording (BUG-372).

## 3. Pilot-critical bugs (the 60 from the 24 Oct triage)

1. **Scored:** Claude-accepted 0 of 60 / confirmed by you 0 of 60. All 60 still read OPEN in the carpark, as they should until accepted. No acceptance ledger, Opus case review or robot report I read mentions any of the 27 fixed ones.
2. **Fix built for 33 of 60:**
   1. **27 new fix PRs** from the five batches (batch 1: 5; batch 2: 6; batch 3: 5; batch 4: 5, of which BUG-1101, BUG-1090 and BUG-1097 are partial; batch 5: 6). Each was independently reviewed (MERGE, or MERGE-WITH-FIXES for two; none rejected). Built and unit-tested only; nobody has opened any in AutoCAD.
   2. **1 document fix:** BUG-1173 (backup step lists all five folders), in the pack, no PR.
   3. **5 covered elsewhere:** BUG-1049 (PR #1743, installed in C-67), BUG-540 (already fixed on the base), BUG-905 (built, switched OFF for your word), BUG-1052 and BUG-1053 (PRs #1716 and #1727, not installed).
3. **Installed on your PC (my reading of the finalizer reports, not the DLLs): 24 of the 27 PRs.** C-64: #1747 #1748 (via C-65) #1750 #1751 #1754. C-65: #1752 #1755 #1757 #1758 #1760 #1761 #1763 #1764 #1765. C-66/C-67: #1768 to #1770, #1772 to #1778.
4. **Left out of every train, three:** #1756 (BUG-1189, survey XREF detached), #1767 (BUG-1149, stage drawing BIND) both waiting on your questions; #1771 (BUG-1090, the "hydraulic grade line not calculated" line on every council sheet): you said yes today ("do as you recommend"), so it needs a rebase, review and a train.
5. **27 have no fix.** They are skipped because each needs your engineering word, a design call, or protected shared code:
   1. **Engineering numbers (10):** BUG-1088 (sizer picks smallest pipe at any grade), BUG-1095 and BUG-1099 (council C values never applied), BUG-1091 (DN450 and larger lose minimum grade), BUG-901 (cover to inside top of pipe, you ruled yes today), BUG-902, BUG-903, BUG-907 (you ruled yes today for a warning), BUG-866 (rainfall curve note), BUG-1096 (tank reuse credit).
   2. **Design or window calls:** BUG-1192 (long section hides a depression), BUG-1031, BUG-685, BUG-857, BUG-1148, BUG-855, BUG-587, BUG-648, BUG-525, BUG-865, BUG-816.
   3. **Install and rollback facts to gather on Max's PC:** BUG-1166, BUG-1169, BUG-1170.
   4. **Only on AutoCAD 2022 to 2024:** BUG-1209, BUG-1210. Max's year is unknown.
   5. **Needs a protected file:** BUG-1171 (Civil reports never reach you).
6. **Of the 23 serious wrong-answer or data-loss risks:** 9 are fixed and installed (BUG-1135, 1137, 1138, 1142, 1150, 1188, 1190, 1196, and 540 on the base); 1 is built but left out (1189); 2 have PRs on hold (1052, 1053); 1 is built but switched off (905); 10 have no fix (685, 866, 901, 907, 1088, 1091, 1095, 1099, 1148, 1192).
7. **Limits:** the batch reports say three of the changes have real limits (a survey approved before the fix keeps wrong positions until CDSURVEY is run again; a damaged pit record is tolerated in one step but about 95 other places still stop on it; the 2022 to 2024 fixes cannot be seen on your 2027 PC).

## 4. The colleague pack (`areas\colleague-pack`)

1. **Pages 01 to 05 are drafts of Thu 22 Oct,** written against Civil 3.0.70 (installed is now 3.0.85). Every one carries [CHECK] marks. Nothing has been published and nothing has been shown to Max.
2. **01 Start here** (one page for Max). **02 Install and update** (hand install, about 5 minutes, AutoCAD closed; screenshots still placeholders; rollback backup fixed today to list all five folders). **03 What is in this release** (based on 3.0.70). **04 Known problems** (22 Oct draft; a newer 25 Oct draft, `COLLEAGUE_KNOWN_PROBLEMS_DRAFT_25OCT.md`, about 30 statements marked [CHECK], awaiting your read and your yes to publish). **05 How to report a problem** (CDFEEDBACK; BUG-1215 wording fix installed).
3. **06 Questions for Tim: 20 questions.** Answered or ruled since it was written: 14 rainfall note (not changed; you said leave the curve until checked), 15 cover (yes), 16 pit drop (yes), 17 minimum grade (guidebook decides), 18 Inspector versus CDRULES (not answered). Still open: who installs on 9 Nov and when; Max's AutoCAD year; Max's old July Structural (leave, switch off or remove); the old Manager in the all-users folder; where the frozen copy sits; the old-files move; how long Max works on copies only; use of CDDESIGN, CDRUNSOLVE and CDTWL for drafting only; switches left OFF; F2 runs CLEAN; the pilot results folder write access; reply time; the practice drawing; format and screenshots.
4. **Not in the pack and not done:** the approved colleague-defaults export (no folder paths, F-023), the known-problems page final version (due Thu 5 Nov from the frozen build), the dry runs on a spare login.

## 5. The 390-item 9 Nov scope (from the 28 Oct recount, nothing moved since)

1. **Built:** 184 of 390 in the plugin on your PC (47 percent); 290 counting unshipped draft PRs (74 percent).
2. **Tested:** 12 whole (3.1 percent), 26 counting parts (6.7 percent). Four of the 12 also have a Codex look that passed: Esc at CD's third point, OF and FO, EXPLODE a pit, CDSYNC and CDREBUILD warnings.
3. **Your hand checks this morning** cover PIT and CD (UX-STD-01b) and EXPLODE a pit (UX-EDIT-04) by my mapping of the daily-tool cards to plan items; that mapping is mine and is not recounted.
4. **About 158 built items have no test at all** (Civil about 100, shared rules about 55, Manager 9).
5. **Bug side (24 Oct triage, 1,170 entries, then 11 more filed):** 43 closed, 552 with a fix installed and awaiting acceptance, 242 built not installed, 333 with no fix. Since then 7 more are Claude-accepted FIXED (BUG-711, 684 half, 697, 863, 384, 460, 1222) and BUG-1225, 1222 and the ROTATE half of 665 are confirmed by you.

## 6. The 9 Nov scope items NOT built yet (about 100), for the build session (CE 01)

**Read this first.** The gap plan of 22 Oct deliberately cut every item below from the 9 Nov pilot, because nothing unbuilt can be built, reviewed, installed and tested twice before the freeze (Mon 2 Nov). So these are for the release after the pilot, not blockers for 9 Nov. Your pause on plan-item building ended today (29 Oct), so the build session can queue them now. Sizes are the gap plan's guesses from 22 Oct (S about a day, M two to three days, L longer); no builder has confirmed them. "Value" is my judgement of a drainage drafter's week. The list comes from the 18 Oct recount, section 3; recount 5 confirmed no whole plan item shipped since, but nobody has re-listed these by name, so check each against the installed line before writing its card.

**Already queued by CE 01 from your 29 Oct answers, so NOT in the list below:** Recent levels buttons (BUG-1226), raingarden RG1 label, Tidy labels ON by default, grip copy default ON, no-units import note, #1788 small extras, cover to the outside of the pipe, pit drop warning, DP label double-click (BUG-860), and PR #1771.

### 6a. Civil (27 items, cheapest and most valuable first)

1. **UX-LYR-03, colour always ByLayer (S to M).** CE objects plot with your pen table. High value for Max's first issued sheet. The gap plan substitutes a pack check for now.
2. **UX-TANK-01, one-line tank callout without detention (M).**
3. **UX-RL-04 and UX-RL-05, assumed datum when there is no survey, and a later survey fills it in (M).** Matters on jobs that start before the survey arrives.
4. **UX-SCHED-01b, a value typed in the Pit Schedule updates the pit, all values (M).** Cut from the pilot; the schedule behaves as it does on your PC today.
5. **UX-SCHED-04b (size not stated).** I could not find a plain description in the files I read.
6. **UX-CR-10 and X-C07, council rules with sourced values (L).** The engines UX-CR-01 to 17 are built on PRs; these two need real council values and your word. High value: CDCHECK cannot yet say "this council refuses that storage item".
7. **UX-CPLAN-04, UX-DET-08 and X-C11, C01 and C02 sheet set-up (L, needs a card).** Engines for about 17 IDs sit on open PRs; nothing places them on a sheet.
8. **UX-L3-02, UX-L3-19 and UX-L3-20, Level 3 proposals (L).** 19 and 20 have no approved card.
9. **UX-SITE-01, UX-SLAB-01 and 02, UX-SPS-02 to 04 (pump stations), UX-WSUD-02 to 04 (L, mostly no card).**
10. **X-C09, E-HOLD-01 (L).** Only a probe exists.

### 6b. Manager (3 items)

1. **UX-MGR-04, quiet update at next start.** The largest of the three and the most valuable: every colleague update after 9 Nov depends on it (L; Opus wants a separate helper and a signature check; do the approval-path fix with it).
2. **UX-SET-01, Settings search (M).**
3. **UX-SET-08, office changes hit new work only (M).**

### 6c. Shared (70 items, in rough order of what a new colleague meets first)

1. **UX-FAIL-01 and 02, a failure window with "Send to admin" (M).** Max currently uses CDFEEDBACK plus a screenshot to you.
2. **UX-FIRST-01 to 03, UX-START-01, UX-HELP-01 and 06, the first day: welcome card, first-use tips, practice job (M each).** Replaced by the one-page guide for the pilot.
3. **UX-MIX-02 and UX-DWG-01 to 03, mixed AutoCAD years (M).** "Needs AutoCAD 2027" greying; clean linework for people without CE. Becomes urgent if Max is not on 2027.
4. **UX-PERF-01, progress bar with Cancel for slow commands (M, part built, OFF).** Relevant now that DP and PIT are slow (BUG-1228).
5. **UX-WIN-01 and 04, Enter applies and Esc cancels everywhere; windows reopen where left.** Size not stated.
6. **UX-SEL-01 (built as PR #1000, never installed).** The only plan-item PR held in a train list; needs a decision to install.
7. **Smaller shared rules (sizes not stated):** UX-RCLICK-01, UX-PROP-01, UX-NAMES-03 and 05, UX-LAY-03 and 04, UX-JOB-02 and 05, UX-STDS-03, UX-RULES-01, UX-SHARE-01, UX-XREF-02, UX-VOICE-01, UX-LEARN-02 to 04, UX-ARCH-01 and 02, UX-LOOK-01 as a whole item.
8. **The one-tab ribbon and CE panel (L):** UX-RIBBON-02 to 07, UX-PANEL-01 and 02, UX-RECENT-01. Held by your ruling F2 until you check the plan.
9. **Ask CE (L):** UX-AI-01 to 07 and the separate Ask CE command item (UX-ASK number 01); UX-AI-04 is marked "later, not V3".
10. **Keyboard access (L):** UX-ACC-01 to 03.
11. **Civil and Structural reading each other (L):** UX-XDISC-01 to 04.
12. **Issue register, Civil half (L):** UX-REG-01 to 03, 06, 08, 10, 11, 13 to 15.

### 6d. Structural (outside 9 Nov; 36 unbuilt, listed for completeness)

Structural stays on your PC only (ruling B3), with 108 items built and 0 tested and no Structural robot cases. Unbuilt: UX-D2-05b; UX-DET-01 to 03 and 06; UX-MARK-08; UX-QA-02; UX-RW-03 to 09 and 11; UX-SEC-02 and 03; UX-SL3-01; UX-SSCHED-04, 06, 12, 13; UX-STEEL-01; UX-STRUC-05, 07, 08, 09, 09b, 11; X-S04, X-S05, X-S09. No build action is needed for 9 Nov.

### 6e. Built but not installed (cheaper to finish than to build)

From the 18 Oct recount and the gap plan, not re-checked: council rule engines UX-CR-01 to 17 (16 on PRs); sheet set-up engines (about 17); Manager pages UX-MGR-05 to 13 (PRs #1072, #1075, #1076, #1077, #1080, #1111, #1113, #1119); the detention chain (#1031, #1123); the four Civil Settings pages (#1208, #1246, #1251, #1252, on stale bases). That is where most of the gap between 184 installed and 290 built sits.

## 7. Cheapest ways to move the numbers before 9 Nov (my suggestions)

1. **Everyday tools 19 to 30.** The seven daily-tool cards with a written test and no pass yet are the New Pipe recent values (BUG-1226 fix queued), Hide grade, the mid-pipe label, the hand-placed label, the schedule onto the next sheet, CDCHECKDWG's summary and the ribbon tab jump. The last two have real faults Codex saw. About eight part-tested items need one more check each.
2. **Pilot-critical 0 to something.** The 24 installed fixes mostly have an AutoCAD route the robot can drive; the triage says 348 bugs are robot-provable. Put the 24 installed fixes into the next robot batch ahead of other bugs.
3. **Your four yeses and the facts about Max.** These cost you minutes and nothing else moves without them.
4. **Rehearse the hand install on a spare login twice and the rollback once** (T5 to-do items 1 and 2).

## 8. What I could not verify

1. **Nothing was run or opened.** No AutoCAD, no robot, no Codex, no build. I did not read any installed DLL: installed versions come from `PROGRESS.json`, the queue and the recount.
2. **The bug counts by severity are a script parse of `BUG_CARPARK.md`,** which is a loose file: 1,181 entries found, 990 open plus 94 with no status line. Severity is the first severity word near the top of each entry, so treat it as a guide. Not closed: HIGH 172 (94 with no fix named, 71 with a fix installed, 7 built), MEDIUM-HIGH 27, MEDIUM 439, LOW-MEDIUM 21, LOW 150, severity not stated 275.
3. **Installed status of the 27 pilot-critical PRs** is my reading of which train files name them, not a check of the code on your PC. Some train files only mention a PR as "left out".
4. **Gate items 2 and 5:** two records disagree (gap plan and T5 versus the triage); I could not settle it without opening Manager.
5. **A hand-install rehearsal, a spare Windows login, Max's AutoCAD year:** I found no record in the files I read. They may exist in a chat or a folder I did not search.
6. **The "tested" figures** are reviewers' verdicts from the ledger and recount; I re-judged no case.
7. **Whole versus part** for the 12 tested plan items is the reviewer's word; read strictly, 9 are whole.
8. **The unbuilt list** is the 18 Oct list. Items may have been partly built since; I did not search the code.
9. **Sizes (S, M, L)** are the gap plan's guesses.

---

## Summary (under 100 words)

1. **Realistic?** A small hand-installed pilot on Mon 9 Nov is possible; Mon 16 Nov looks more likely.
2. **Blockers:** the hand install is unrehearsed, acceptance is far behind, and four yeses are waiting on you.
3. **Scores:** gate 1 of 11; pilot-critical bugs 0 of 60 accepted / 0 of 60 confirmed by you; 390 scope built 47 percent / tested 3.1 percent; everyday tools 19 of 40 Claude-accepted / 3 of 40 confirmed by you.
4. **Unbuilt:** about 100 plan items, listed by area in section 6, none a pilot blocker.
