# Pilot risk plan: the bugs a colleague is most likely to hit (Fri 30 Oct 2026, about 12:15 Melbourne by the PC clock)

**Who and how.** Read-only planner (Opus), started from the desk. Text only: no AutoCAD, no robot, no Codex, no build, no git. The only file written is this one.

**Pilot:** Max, Mon 16 Nov 2026. **Cut:** Fri 13 Nov (the newest TESTED build goes to the pilot; anything untested stays out of the pilot build).

**Sources read:** `C:\TimOS\RULES.md`; `areas\COLLEAGUE_READINESS_29OCT.md`; `areas\PILOT_CRITICAL_TEST_LIST_29OCT.md`; `areas\release-v3-colleagues-BUILD_REGISTER.md`; `areas\TRAIN_C77_PR_LIST_2026-10-29.md` (lines 1 to 136); `areas\COLLEAGUE_KNOWN_ISSUES_DRAFT_30OCT.md`; the carpark entries for BUG-1227, BUG-1229, BUG-1251 to BUG-1256; `QUESTIONS_FOR_MONDAY.md` item 21; `decisions\2026-10-29_TIM_ANSWERS.md` items 43 to 46; the desk log 30 Oct 07:43 to 12:12; the C-77b lines of `RELEASE_SCOREBOARD.md`.

---

# FOR TIM

1. **Answer.** Five bugs carry most of the pilot risk. Two of them can hurt Max's drawing or design without him noticing. None of the five is proven fixed today.

2. **The five riskiest, in order.**
   1. **A ROTATE Copy or SCALE Copy that lands on a pit steals that pit's pipes (BUG-1227).** In the test the original pit kept 1 of its 5 pipes. The fix is built, not in C-77; it goes in C-77b (Sat 31 Oct) or C-78 (Mon 2 Nov).
   2. **The automatic pipe sizer picks the smallest pipe at any grade (BUG-1088).** A 40 L/s connection comes out DN100 at about 1 in 3. The fix is written but has never compiled; C-77b or C-78.
   3. **The council minimum runoff figure is never applied (BUG-1095).** On a Darebin job CDDESIGN uses 0.70 where the council says 0.80, so the tank is too small. Fixed in C-77 (installing today), not yet seen working.
   4. **CDCHECK straight after reopening a drawing reports false faults (BUG-1251).** 44 Unresolved instead of 4. Max does this every morning. Fix promoted late into C-77.
   5. **Excel export of the Pit Schedule fails in AutoCAD 2027 (BUG-1255).** AutoCAD 2027 ships its own older copy of the Excel library and it wins over CE's. No fix and no train yet.

3. **One unknown could be bigger than all five: Max's AutoCAD year.** If he is on 2022 to 2024, a downpipe cannot be placed on a pit (BUG-1209) and Edit Pipe loses its picture (BUG-1210). Neither has a fix. One answer from you settles it.

4. **What I recommend.**
   1. **Put BUG-1255 on the build list now.** It is probably one line in the Civil project file, but a short probe in AutoCAD 2027 must show which of two fixes works. Target C-78.
   2. **Keep BUG-1227 first in C-77b.** It is the only fault on the list that changes drawing data.
   3. **Answer the 12 questions in section C.** Most are facts about Max's PC that take you a minute each.

5. **A correction (RULES 6.2).** The release scoreboard still says page 04 should tell Max to "use a small offset" when copying a pit. That is not safe: a copy only 0.1 mm off still took the pipes. The 30 Oct page 04 draft already says "place the copy well clear (5 m was safe)". Use that wording.

6. **Nothing for you to test.** Every proof below is a robot case or a Codex look.

---

# DETAIL (nothing below needs action from you)

## A. How I ranked

1. **Likelihood** is how often a drainage drafter on a normal residential job meets it in a pilot week: 5 = every day, 1 = rarely. **Damage** is what it does to the drawing or the design: 5 = wrong design or lost drawing data that nobody would notice, 1 = a cosmetic or wording fault. Both are my judgement from the bug entries, not a measurement.
2. **The score is likelihood times damage on today's installed build (Civil 3.0.86).** It is not reduced for fixes that are built but unproven, because nothing is accepted yet. Where a fix is in a train I say so; the risk drops only when its proof passes.
3. **Train names.** **C-77** = Civil 3.0.87, installing today about 16:00 to 16:40 (not installed when I read the desk log at 12:12). **C-77b** = the hotfix-size train for items that missed C-77 (planned Sat 31 Oct; no assembly time recorded). **C-78** = PR-ready by Sun 1 Nov 12:00, install Mon 2 Nov after 17:30. **C-79** = install Fri 6 Nov evening (window and look items). **C-80** and **C-81** follow; nothing new after C-81 (Thu 12 Nov noon).
4. **"Proof"** is the single check that would let the desk call it Claude-accepted or Codex-accepted. A Codex look is needed wherever the answer only shows in a window the robot cannot read.

## B. The ranked list (65 bugs considered: the 60 pilot-critical plus the five found today)

### Tier 1: most likely to hurt Max (score 9 to 10, or unknown but possibly worse)

1. **BUG-1227: a ROTATE Copy or SCALE Copy landing on top of a pit takes the original pit's pipes.**
   1. **Score:** likely 2, damage 5 = 10. Silent loss of pipe joins; the only fault here that changes drawing data.
   2. **Fixed?** No. Part A built and unit-tested as PR #1867 (switch `linking.pitCopyKeepsOriginalPipeEnds` ON); NOT in C-77. Part B (the repeated "Pit schedule cell ... not updated" lines said once) has no PR.
   3. **Train:** C-77b (first item), else C-78. The Opus pre-review D said C-78.
   4. **Page 04 workaround:** "Never ROTATE or SCALE with the Copy option on top of a pit. Place the copy well clear (5 m was safe; 0.1 mm was not). If it happens, close the drawing without saving." (One U putting the pipes back is NOT proven, so do not promise it.)
   5. **Proof:** robot case "rotate-copy on a pit" (working title C36 in the build register; CE 02 renumbers, N36 is taken) with its switch-off control, two starts.

2. **BUG-1088: the automatic pipe sizer picks the smallest pipe at any grade, up to 1 in 1.**
   1. **Score:** likely 2 (only if Max sizes pipes in CDDESIGN or a network redesign), damage 5 = 10.
   2. **Fixed?** No. B-020, PR #1863: written, NEVER COMPILED, and it conflicts with #1841. Tim answered "yes" (QUESTIONS 21a). An Opus plan for the conflict (team_opus_o9, `C77B_SIZER_STACK_PLAN_30OCT.md`) was started 12:25.
   3. **Train:** C-77b or C-78. A named freeze fix: if it misses C-80, the pilot build must say so on page 04.
   4. **Page 04 workaround:** "Do not accept a pipe size CE picks for you. Choose the size and grade yourself; anything steeper than 1 in 20 is wrong."
   5. **Proof:** Codex look H8: a 40 L/s connection gives DN225 at about 1 in 200, not DN100 at 1 in 3; switch-off control gives the old pick.

3. **BUG-1095: the council minimum after-development runoff figure (Darebin, Maribyrnong, Boroondara) is never applied.**
   1. **Score:** likely 2, damage 5 = 10. Tank too small on those councils' jobs.
   2. **Fixed?** Built (B-017, PR #1852, switch `detention.councilMinimumRunoffCApplied` ON), merged into C-77. Not seen in AutoCAD. The Settings page has no row for it (the row did not fit).
   3. **Train:** C-77.
   4. **Page 04 workaround (until the proof passes):** "On Darebin, Maribyrnong and Boroondara jobs, check the after-development C on the computations sheet is at least the council minimum (Darebin 0.80)."
   5. **Proof:** Codex look H8: CDDESIGN Darebin example reads C 0.80 with a "council minimum governs" note; switch-off control reads 0.70.

4. **BUG-1251: CDCHECK run first on a reopened drawing reports false Unresolved joins (44 instead of 4).**
   1. **Score:** likely 5 (every reopen where CDCHECK is the first CE command), damage 2 = 10. CDCHECK writes nothing, but a drafter may "repair" faults that are not there.
   2. **Fixed?** Built (B-055, PR #1866, switch `checks.cdcheckReadsThisDrawingsRecord` ON), net10 focused tests only. PROMOTED LATE into C-77: the finalizer merges it first and leaves it out if it fails.
   3. **Train:** C-77, else C-77b.
   4. **Page 04 workaround:** "After you open a drawing, run any CE drawing command first (for example PITEDIT on a pit, then Cancel), then CDCHECK."
   5. **Proof:** robot case N38_cdcheck_reopen with control C38 (R21 is the expect-fail twin on the old build), two starts.

5. **BUG-1255: Pit Schedule "Export Excel" fails in AutoCAD 2027 with "Pit Schedule rendering error".**
   1. **Score:** likely 3 (any drafter who sends a schedule to Excel, on 2027), damage 3 = 9. No drawing harm, but a deliverable cannot be made and the message gives no reason. Probably also the CDCALC Excel export (not seen).
   2. **Fixed?** No. Cause found from the CE log: AutoCAD 2027 ships ClosedXML 0.102.2 and it is loaded before CE's 0.102.3. No B number, no PR, no job.
   3. **Train:** none yet. Recommended C-78: build the 2027 lane against 0.102.2 (or load CE's copy separately), after a short accoreconsole probe shows which works. A project-file change: the C-78 finalizer must say it touches the bundle.
   4. **Page 04 workaround:** "Use Export CSV, then open the CSV in Excel. Export Excel does not work in AutoCAD 2027 yet."
   5. **Proof:** Codex look H3 repeat (Export buttons are on the robot's never-press list): the Windows save box opens and an .xlsx is written to a test folder.

6. **BUG-1209 and BUG-1210: on AutoCAD 2022 to 2024, a downpipe cannot be placed on a pit, and Edit Pipe and Edit Pit lose the plan picture.**
   1. **Score:** UNKNOWN. If Max is on 2027: zero. If he is on 2024: likely 5, damage 4 = 20, the biggest risk on this page.
   2. **Fixed?** No. Both wait for Max's year; BUG-1210 also waits for your choice (port the picture or say "needs AutoCAD 2027").
   3. **Train:** none until the year is known. A fact, not code (section C, questions 1 and 2).
   4. **Page 04 workaround (only if not 2027):** "Place the downpipe beside the pit, then join it. Edit Pipe's picture is blank on your AutoCAD; use the boxes."
   5. **Proof:** a Codex look on an AutoCAD 2024 test PC; on Tim's 2027 PC nothing shows.

### Tier 2: likely, moderate damage (score 6 to 9)

7. **BUG-1090: nothing on the council sheet says the hydraulic grade line and pit losses were not checked.**
   1. **Score:** likely 5 (every council computations sheet), damage 2 = 10 on paper; I hold it here because your sign-off still catches it.
   2. **Fixed?** Built (B-015, PR #1771) on an old base; needs a rebase and review. You said "do as you recommend".
   3. **Train:** C-78.
   4. **Page 04 workaround:** "Add a note on the computations sheet: hydraulic grade line not calculated."
   5. **Proof:** robot case: CDRULES on a Frankston-profile copy prints a line saying the HGL is not calculated.

8. **BUG-901: cover is measured to the inside top of the pipe, so it reads high by the wall (about 45 mm on concrete 375).**
   1. **Score:** likely 3, damage 3 = 9. A marginal pipe passes that should not.
   2. **Fixed?** Built (B-012, PR #1848) and merged into C-77. The follow-up B-012b (an unknown wall reads Unknown, never a pass) moved after the merge, so it is NOT in C-77 as built: C-77b.
   3. **Train:** C-77, completed in C-77b.
   4. **Page 04 workaround:** "Where CDRULES cover is within 50 mm of the minimum, take off the pipe wall by hand."
   5. **Proof:** Codex look H8 on the CDRULES tab (the row names the wall used); switch-off control gives the old figure.

9. **BUG-1192: the long section hides a ground depression (survey levels more than 1.20 m off the cover line are dropped).**
   1. **Score:** likely 2, damage 4 = 8. An issued long section can show a buried pipe that is really exposed.
   2. **Fixed?** Step one built (B-021, PR #1864, a warning line only, no drawing change) and merged into C-77. The dashed "ground not confirmed" stretch (you said yes, QUESTIONS 21d) is not built.
   3. **Train:** C-77 for the warning; the dashed stretch after the pilot unless a lane frees.
   4. **Page 04 workaround:** "If CDPROFILE says survey levels were ignored, check the ground line against the survey before issue."
   5. **Proof:** Codex look on a copy with ground 1.5 m below the covers (I did not check whether the warning prints on the command line; if it does, a robot case is cheaper).

10. **BUG-1189: approved survey levels stay in use after the survey Xref is moved.**
    1. **Score:** likely 2, damage 4 = 8. Wrong level offered for New Pit.
    2. **Fixed?** Built (PR #1756), held out of every train for your answer (section C, question 9).
    3. **Train:** C-78 if you answer by Sun 1 Nov, else after the pilot.
    4. **Page 04 workaround:** "If you move, reload or re-attach the survey Xref, run CDSURVEY and approve it again before placing pits."
    5. **Proof:** robot case on a rotated survey test drawing (RD15_NESTED, still to be made by Codex; the same drawing also proves the installed BUG-1190).

11. **BUG-866: CDDESIGN says the office rainfall curve reads "7 to 9 per cent high".**
    1. **Score:** likely 4, damage 2 = 8. Confusing on a sheet that goes to council.
    2. **Fixed?** No. Your ruling: curve numbers stay until you have checked it. The note wording is still open (B-016, not started).
    3. **Train:** C-78 for the wording once you answer (section C, question 6).
    4. **Page 04 workaround:** "Ignore the rainfall curve note; the curve is the office curve."
    5. **Proof:** Codex look at CDDESIGN reading the new note.

12. **BUG-1253 (today): after a pit move, its invert text sits on the blue pipe strip.**
    1. **Score:** likely 5, damage 1 = 5, but it reaches issued sheets.
    2. **Fixed?** No. Cause found (a text's own pipe strip is never treated as keep-clear); same root as BUG-1034. No B number.
    3. **Train:** none before C-79 at best; probably after the pilot.
    4. **Page 04 workaround:** "After moving a pit, zoom to it and move any level text off the pipe strip before issue."
    5. **Proof:** Codex look G5 repeat (MOVE P3 by 0,2000, text clear of the strip).

13. **BUG-1252 (today): a pipe label you placed by hand moves half the pit's move when the pit moves.**
    1. **Score:** likely 4, damage 1 = 4.
    2. **Fixed?** No. On hold for your QUESTIONS item 19 (section C, question 10).
    3. **Train:** depends on the answer; after the pilot.
    4. **Page 04 workaround:** "Move pits first, then place labels by hand. After a pit move, check labels you placed."
    5. **Proof:** Codex look G7 repeat after the ruling.

14. **BUG-1196 (installed): after Edit Pit, the drawn Pit Schedule depth and "With Step Irons" change on a pit with a lower second outgoing pipe.**
    1. **Score:** raw likely 3, damage 4 = 12; fix installed (3.0.75), unproven.
    2. **Train:** already installed.
    3. **Page 04 workaround (until proven):** "After Edit Pit on a pit with two outlets, check its schedule row depth."
    4. **Proof:** robot case after a reviewed allow-list change (press "Edit pit, Save" and read the drawn schedule) on a P2/P3/P4 test drawing.

15. **BUG-907, BUG-902, BUG-903 (CDRULES checks): the pit drop compares inverts only; cover is checked only at the two pits; screens disagree on minimum grade and cover.**
    1. **Score:** each likely 2 to 3, damage 2 to 3 = about 6.
    2. **Fixed?** BUG-907 (B-013) queued, not started; BUG-902 (B-026, PR #1869) built, a C-77b candidate; BUG-903 (B-022) not started, waits for the guidebook cover slices.
    3. **Train:** C-77b (902), C-78 (907, 903).
    4. **Page 04 workaround:** "Where a pipe gets bigger at a pit, check the outlet pipe top is not above the inlet pipe top. Check cover at any low garden bed between pits. If two windows disagree on a minimum, use CDRULES."
    5. **Proof:** Codex look H8 on the CDRULES tab, one example each.

16. **BUG-1099: Boroondara, Maribyrnong and Maroondah's own detention time of concentration is never used.**
    1. **Score:** likely 1 to 2, damage 4 = about 6. On a bare 600 m2 Maroondah lot CE gives 5.18 L/s where the council gives 3.68.
    2. **Fixed?** No (B-018, not started). Your answer was read as yes from a pasted example (a GUESS).
    3. **Train:** C-78, after you confirm (section C, question 5).
    4. **Page 04 workaround:** "On those three councils, work out the permitted discharge by the council's method by hand."
    5. **Proof:** Codex look H8: Maroondah 600 m2 bare lot, 1 in 5, PSD 3.68 L/s.

### Tier 3: rarer or minor (score 5 or under)

17. **BUG-1053 and BUG-1052: LandXML levels in millimetres not converted; CDAGI and CDPERIMETER pass a flat drain in a metre drawing.** Likely 1, damage 5. Built (PRs #1716 on HOLD, #1727 unreviewed); need an Opus review; C-78 or after the pilot. **Workaround:** "Work in millimetre drawings only; after a LandXML import check the first pit's cover level reads in metres." **Proof:** robot case on the existing metre drawings DRV15_METRE (1052); a test file UNIT-RL-MM.xml plus a reviewed file-chooser step (1053).
18. **BUG-1091: DN450 and larger lose their minimum grade in redesign.** Likely 1, damage 4. Partly in C-77 (#1841: a blank row says "No minimum fall set for this size"); the redesign half (#1868) is unbuilt, C-77b or C-78. **Workaround:** "Set the grade of any 450 or larger pipe by hand." **Proof:** Codex look H8 (DN450 at 30 L/s gives 1 in 200, not 1 in 1,500).
19. **BUG-1171: Civil's failure reports never reach you and pile up on Max's PC.** Likely 5, damage 1. Manager short list built (PR #1860) and in C-77; sending stays OFF until you answer QUESTIONS item 61 (section C, question 8). **Workaround:** "If CE fails, use CDFEEDBACK and send Tim a screenshot." **Proof:** Manager test on a spare profile listing both outbox folders.
20. **BUG-685: CD rounds the level you typed (10.125 becomes 10.13).** Likely 3, damage 1. Answered (keep the 10 mm rule, say it in one line); a small build with NO B number yet. **Train:** C-78 if CE 01 numbers it. **Workaround:** "Type levels to the nearest 10 mm." **Proof:** robot case reading the one command line.
21. **BUG-1148: pasting a pit from a Save As sister drawing gives it this drawing's values.** Likely 1, damage 3. Answered: a known limit for the pilot. No code. **Workaround:** "After pasting a pit from another stage drawing, check its size and levels in Edit Pit." **Proof:** none for the pilot (page 04 line only).
22. **BUG-1149: after XREF BIND of a stage drawing the schedule says SOURCE MISSING and QA fails.** Likely 1, damage 3. Built (PR #1767), held for your answer (section C, question 11). **Workaround:** "Detach, do not BIND, CE stage drawings." **Proof:** Codex look on a sheet with a bound stage drawing (the bug entry's expected wording must first be changed to what #1767 really prints; test list finding F1.2).
23. **BUG-1096: the rainwater-tank reuse credit never runs.** Likely 2, damage 2 (the tank comes out about 18 per cent too big, the safe side). B-029, large, C-79, at risk. **Workaround:** "Take the reuse credit off by hand on the sheet if the council allows it." **Proof:** Codex look (Manningham 3,000 L gives credit 1.50 m3, net 8.50 m3).
24. **BUG-587: drawn Pit Schedule remarks cross the row lines.** Likely 2, damage 1. Your answer: tighter line spacing first, else a two-row-thick row with a wipeout like XCLMTXT; picture first. B-028, C-79. **Workaround:** "Keep schedule remarks to two lines." **Proof:** Codex look at a three-line remark.
25. **Install facts on Max's PC (BUG-1165 installed, BUG-1166, BUG-1169, BUG-1170).** Old CE copies in the all-users folder, the office folder path, the July Structural, the old Manager. Damage 3 if wrong, but all are checked once at install. **Workaround:** page 02 install steps (remove old copies, back up all five folders). **Proof:** the hand-install rehearsal on a spare standard login, twice, plus one rollback.
26. **Low and cosmetic:** BUG-857 (Grade mismatch box X; PR #1858 built, C-77b), BUG-1031 (Delete cell; in C-77), BUG-816 (after-MOVE tidy switch; B-025, C-79), BUG-525 (blues; B-027, C-79, picture first), BUG-865 (double-click slow in survey drawings; Codex to time it first), BUG-855 (data-issues count +1 after CDSYNC; robot probe first), BUG-648 (AG drain grade not labelled: see section C note), BUG-1254 (CDCHECKDWG half row, probably no fault), BUG-1256 (cancel wording).

### Also on page 04, outside the 65 (from the 30 Oct known-issues draft, not re-ranked)

1. **REDO lost after the first click (BUG-861).** Every day. Cause unknown. "After U, type REDO before you click anything."
2. **PIT slow (BUG-1228 follow-up, B-031).** "Wait; do not click again."
3. **Inspector says Unknown after reopen or Save As (BUG-1240).** "Run CDSYNC first." This and BUG-1251 share a cause family; the B-055 fix covers CDCHECK only.

## C. The 27 no-fix bugs: code, Tim ruling, or fact

**Already answered by you (no question; checked in `QUESTIONS_FOR_MONDAY.md` item 21 and `decisions\2026-10-29_TIM_ANSWERS.md`):**
1. **BUG-1088** (21a, yes), **BUG-1096** (21c, yes), **BUG-1192** dashed stretch (21d, yes), **BUG-587** (21e, items 43 and 44), **BUG-685** (21h, keep 10 mm and say it), **BUG-1148** (21i, known limit for the pilot), **BUG-525** (21j water line may stay blue, 21k glow gold), **BUG-901** (yes, add the wall), **BUG-907** (yes, warn).
2. **BUG-648 is settled by your ruling, not by code.** Item 46: "no text at all" on AG drains. Today CE draws no AG drain grade label, which is what you ruled. CE 05 should note it "behaviour matches Tim's ruling 29 Oct item 46" (not FIXED; D6 keeps the entry). B-030 (copy gets its own label) should be re-read by CE 01 against the same ruling before any build.

**Pure code, no question needed:** BUG-1095, BUG-1091, BUG-902, BUG-903, BUG-1031, BUG-816 (built on the recommended answer).

**Count check:** all 27 are placed above or below: 9 answered, 1 settled by ruling (648), 6 pure code, 2 facts for Codex or the robot (865, 855), and 9 with an open question (1209, 1210, 1169, 1166, 1170, 866, 1099, 1171, 857). Questions 9, 10 and 11 are not in the 27: they are for built-but-held fixes (BUG-1189, BUG-1149) and today's BUG-1252.

**Facts to gather (not code, not engineering):** BUG-865 (Codex times a double-click) and BUG-855 (a robot probe). No question for you.

**Questions for CE 04 (one line each, recommendation included; the first five are facts only you can get):**

1. **BUG-1209 / BUG-1210, Max's AutoCAD year:** "Which AutoCAD year does Max run (2027, 2026, 2025 or 2024)?" No recommendation; a fact. If not 2027, two faults with no fix apply to him.
2. **BUG-1210, if Max is not on 2027:** "Should Edit Pipe and Edit Pit show 'picture needs AutoCAD 2027' on his year, rather than port the picture before the pilot?" Recommend the line (small, safe); port after the pilot.
3. **BUG-1169, Max's old July Structural:** "Remove Max's July Structural at install (a backup kept), so it cannot load an older shared file?" Recommend remove.
4. **BUG-1166, office folder on Max's PC:** "Where does 'Creative Engineering - Drafting' sync to on Max's PC, and may we then make Civil and Manager look in the same place?" Recommend yes once the path is read on his PC.
5. **BUG-1170, Max's Manager and a spare login:** "Which CE Manager version is on Max's PC now, and can we have one spare standard Windows login for the install and rollback rehearsal?" Recommend yes; it also proves eight installed fixes.
6. **BUG-866, rainfall note wording:** "Until you have checked the curve, should the sheet drop the '7 to 9 per cent high' line and say only 'office rainfall curve'?" Recommend yes, so a council reviewer does not read it as an admission.
7. **BUG-1099, confirm the guess:** "For Boroondara, Maribyrnong and Maroondah, use the council's own time of concentration for the tank and keep 5 min for the pipe?" Recommend yes (your pasted example was read as yes; confirm it).
8. **BUG-1171 (QUESTIONS item 61):** "Turn on sending of Civil failure reports from Max's PC to the office IT folder for the pilot?" Recommend yes, so you see his crashes without asking him.
9. **BUG-1189, survey Xref moved after approval:** "When a survey Xref is moved or re-attached after approval, should CE stop offering its levels until you re-approve it?" Recommend yes (PR #1756 is built that way).
10. **BUG-1252 (QUESTIONS item 19):** "When a pit moves, should a pipe label you placed by hand travel the full distance with the pipe (a), or stay exactly put (b)?" Recommend (a): a label left behind ends up detached from its pipe.
11. **BUG-1149, BIND:** "When a stage drawing is BOUND into a sheet, should the schedule freeze 'as placed' with a QA warning (PR #1767), rather than fail QA for good?" Recommend yes.
12. **BUG-857, Grade mismatch box:** "Should the corner X in the Grade mismatch box cancel the pipe, like Esc?" Recommend yes. PR #1858 is built on the recommended answer; I did not read the PR to confirm which way it goes.

**Two pilot-scope facts that change the ranking (already on pack page 06, repeated because they move BUG-1088, 1095, 1099 and 1255):**
1. **"Will Max size pipes and tanks in CDDESIGN, or only draft?"** If draft only, items 2, 3 and 16 drop to Tier 3.
2. **"Does Max export the Pit Schedule or CDCALC to Excel?"** If not, item 5 drops to Tier 3 (it still needs fixing for Tim).

## D. Per-train view (what each train must carry to remove pilot risk)

1. **C-77 (today):** BUG-1095, BUG-1251 (late), BUG-901 (without B-012b), BUG-1192 warning, BUG-1031, BUG-1171 short list, BUG-905 ON, BUG-1097 head after losses, BUG-1229, BUG-860, B-035 colleague defaults, B-046 pipe object for everyone. Proofs owed: Codex H8 for the calculation items; N38/C38 for BUG-1251; the spare-login check for B-035 and B-046.
2. **C-77b (Sat 31 Oct, hotfix size):** BUG-1227 Part A (#1867), B-012b (live heads of #1848, #1850, #1851), BUG-902 (#1869), BUG-857 (#1858), and BUG-1088 (#1863) plus BUG-1091 redesign (#1868) only if they compile in time.
3. **C-78 (Mon 2 Nov):** BUG-1255 (recommended, needs a B number today), BUG-1090 (#1771 rebase), BUG-907, BUG-903, BUG-1099, BUG-866 wording, BUG-685 one-line message (needs a B number), BUG-1189 and BUG-1149 if you answer, BUG-1053 and BUG-1052 if reviewed; anything from C-77b that missed.
4. **C-79 (Fri 6 Nov):** BUG-1096, BUG-587, BUG-525, BUG-816; BUG-1227 Part B.
5. **Cannot be fixed by a train before the pilot:** BUG-1209 and BUG-1210 (year unknown, protected area); BUG-1148 (your ruling: known limit); BUG-1252 (waits for question 10); BUG-1253 (no B number, shares a root with BUG-1034, a label-placement change too large to test twice before Fri 13 Nov in my judgement); BUG-861 (cause unknown).

## E. Findings for the desk (RULES 6.2)

1. **Unsafe workaround still written in `RELEASE_SCOREBOARD.md`:** "tell Max to use a small offset when copying a pit". The BUG-1227 diagnosis shows 0.1 mm still steals the pipes. The 30 Oct page 04 draft is right; the scoreboard line should be corrected by its owner (CE 07).
2. **BUG-1255 has no B number and no job.** CE 00 called it a PILOT-BLOCKER. It needs a B number and a probe job before the C-78 cut (Sun 1 Nov 12:00).
3. **BUG-685 has a ruling but no B number.** The build register (line 87) still says it waits for your ruling; 21h answered it on 29 Oct.
4. **The build register's "Not buildable" line (87) is stale for BUG-1148 and BUG-685** (both answered 29 Oct afternoon).
5. **P01 (BUG-1194) and P02 (BUG-1140, MOVE half) passed in both starts on 3.0.86** (desk log 12:02). An Opus review (team_opus_pilot_n36_k_triage) is running; if it says READY, the pilot-critical accepted count can move from 0 to 2 (BUG-1140 counts for its MOVE half only).

## What I did NOT verify (RULES 5.9)

1. **Nothing was run.** No AutoCAD, robot, Codex or build. Installed and train contents come from the desk log, the build register and the C-77 PR list, not from the DLLs.
2. **C-77 is not installed** at the time I read (12:12 by the log); its final contents depend on the finalizer, which may still leave #1866 out.
3. **The scores are my judgement,** not measured; likelihood depends on how Max works (section C, the two scope facts).
4. **I did not read the PRs** for #1858, #1864 and #1867; what they do is taken from the build register and the reports it names.
5. **C-77b has no recorded assembly time;** "Sat 31 Oct" is the scoreboard's plan.
6. **BUG-1255's reach beyond the Pit Schedule** (CDCALC Excel, Structural exports, AutoCAD 2025 and 2026) is not seen in AutoCAD.
