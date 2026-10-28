# Pilot-critical bugs with no fix: triage of the 27, Thu 29 Oct 2026

Written by a read-only triage job for CE 01. Nothing was built, run or opened. No code was read: the plugin worktree I had is on master, which is not what ships, so every file name below comes from the carpark entries filed on 24 Oct against Civil 3.0.72 and may have moved.

---

## FOR TIM (reads on its own)

1. **The answer:** 11 of the 27 can be built now with no word from you. 6 more can be built as a draft on my recommended answer, and your word replaces it before it ships. 2 need your ruling. 7 are facts to gather, not code. 1 needs the protected shared file.
2. **Counts by class:**
   1. **BUILD-NOW: 11 of 27.** BUG-1095, 1091, 901, 902, 903, 907, 1192, 1031, 857, 525, 816.
   2. **BUILD-ON-RECOMMENDED: 6 of 27.** BUG-1088, 1099, 866, 1096, 587, 648.
   3. **NEEDS-TIM: 2 of 27.** BUG-685, 1148.
   4. **FACTS: 7 of 27.** BUG-1166, 1169, 1170 (Max's PC), BUG-1209, 1210 (Max's AutoCAD year), BUG-855, 865 (a robot run each).
   5. **PROTECTED: 1 of 27.** BUG-1171.
3. **The 3 most valuable BUILD-NOW items** (BUG-901 and 907 are also top value but are already queued as B-012 and B-013):
   1. **BUG-1095, the council minimum runoff figure is never applied.** On a Darebin job CDDESIGN uses C 0.70 where the council requires at least 0.80, so the tank comes out about 25 per cent small. The council documents and your 4 Sep ruling already answer it.
   2. **BUG-1192, the long section can hide a ground depression.** It silently throws away survey levels more than 1.20 m off the pit covers and draws a straight line through the covers, so a pipe looks 0.8 m buried when the ground is below the pipe top. First step is a plain warning line; nothing drawn changes.
   3. **BUG-1091, pipes DN450 and larger lose their minimum grade in redesign.** The redesign proposes 1 in 1,509 where Edit Pipe says 1 in 200. Small to build, and it is the base for fixing the pipe sizer (BUG-1088) and the screens that disagree (BUG-903).
4. **Nothing waits on you.** The 12 small questions are one item for Monday (item 21 below). Builders start on my recommended answers; your answer replaces the default.
5. **Two things only you or Max can supply** (both already on your open list, I have not re-asked them): Max's AutoCAD year (type ABOUT), and which Structural and Manager he has. They decide five of the seven FACTS bugs.
6. **One extra find, not filed:** the label tidy after a MOVE treats the sheet border block as something labels clash with (every "no clear spot" line in runs 31 and 33 says "on the block Drawing Border"). On a bordered sheet that could mean labels never find a spot. It needs its own carpark entry; I was told not to touch the carpark.

---

## How I classed them

1. **BUILD-NOW:** a safe fix can ship behind a Settings switch ON, or a ruling, card, rulebook line, council document or the guidebook already answers it. The document is named each time.
2. **BUILD-ON-RECOMMENDED:** a draft is built on the recommended answer and your word is wanted before it ships (R-27).
3. **NEEDS-TIM:** no safe build without your word.
4. **FACTS:** a fact to gather first, not buildable yet.
5. **PROTECTED:** needs CE_SHARED, signing or the installer.
6. **Sizes** are the gap plan's scale: S about a day, M two to three days, L longer. They are my guesses from the carpark entries, not a builder's.
7. **Standing rules applied:** R-00 (nothing hard-coded: every number is a Settings value), R-27 (warn and record, never block), the Civil and Drainage Design Guidebook v1.3 as the authority for grades (decisions item 19 and 23, 29 Oct), and RULES 12 (unknown stays Unknown).

---

## A. Engineering numbers (10)

1. **BUG-1088, the pipe sizer picks the smallest pipe at any grade.**
   1. **What the drafter sees:** CDDESIGN, network redesign and auto-design offer a 40 L/s UPVC pipe as DN100 at about 1 in 3; a 30 m run at 1 in 3.9 falls 7.7 m and cannot reach a council connection. DN225 at 1 in 200 does the job.
   2. **Class:** BUILD-ON-RECOMMENDED.
   3. **Size:** M. One solver change, shared by three commands, plus a Settings value and tests.
   4. **Why:** your 28 Sep ruling already answers the steepness number ("we can allow very steep pipes make it a setting"; no limit, plain warning above 1 in 10, never a block; `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md` line 459). R-03 makes the per-size ladder govern. What is left is the policy: each size at its own flattest allowed grade, step up a size before going steeper. That changes the size every auto-sized pipe comes out at, so your yes comes before it ships.
   5. **Check first:** R-01 caps UPVC at 3.0 m/s, yet the audit says the sizer uses 6 m/s. If that is still true on the shipping line, applying R-01 alone removes the worst cases (DN100 at 5.1 m/s). I could not establish this without the code.
   6. **Question:** Monday item 21 (a).
   7. **Build order:** 7. Needs BUG-1091 (order 6) first.

2. **BUG-1095, the council minimum after-development C is never applied.**
   1. **What the drafter sees:** Darebin 0.8, Maribyrnong 0.75 and Boroondara 0.65 are stored but nothing calls them. A Darebin 600 m2 lot with 400 m2 hard and 200 m2 soft gets C 0.70, not 0.80, so inflow is 87.5 per cent of the council's and the tank is about 25 per cent small.
   2. **Class:** BUILD-NOW.
   3. **Size:** M. Three places (CDDESIGN, pump sizing, the Boyd's tab) through one rule, plus the sheet line.
   4. **Why:** the councils' own wording is "proposed land use or the floor, whichever is greater" (`COUNCIL_BOROONDARA_GUIDELINES_2017.md` line 35 and 63, `COUNCIL_MARIBYRNONG_GUIDELINES.md` line 59, `COUNCIL_DAREBIN_LPD_2025.md` line 43). Your 4 Sep ruling CP-02 stores the Darebin floor, and the 26 Sep council sweep applied the Boroondara and Maribyrnong floors as sourced data (`CR-D1_SWEEP_2026-09-26.md` lines 25, 26, 54, 55). Replacing the weighted figure by the floor when it is higher is the rule as published. It errs towards more storage. The batch 3 builder called it an engineering choice because it did not have these documents.
   5. **Build as:** switch ON; the sheet prints "Council minimum C 0.80 governs (calculated 0.70)".
   6. **Tell Tim, not ask:** open questions C16 and C19 ask whether the floor has been applied on past jobs. It has not, so earlier Darebin, Maribyrnong and Boroondara detention designs by CE may be small. The desk should list them from the job records.
   7. **Build order:** 4.

3. **BUG-1099, Maroondah's own before-development C and lot-size Tc table are never used.**
   1. **What the drafter sees:** on a bare 600 m2 Maroondah lot at 1 in 5, the council method gives a permitted discharge of 3.68 L/s; CE uses 5.18 L/s (41 per cent high), so the tank is too small and the orifice too big.
   2. **Class:** BUILD-ON-RECOMMENDED.
   3. **Size:** M. Needs a second time of concentration in the model.
   4. **Why not BUILD-NOW:** the Maroondah figures are sourced from the council PDF (`COUNCIL_MAROONDAH_GUIDELINES.md`, 35 per cent cap and the lot-size Tc table 12/9/8/7/6/5 min). The catch is that CE has one Tc and it also sizes the outlet pipe. On 26 Sep the same issue stopped the Maribyrnong (10 min) and Boroondara (15 min) detention Tc from being applied: they were left at 5 min awaiting your answer to C15 and C17 (`CR-D1_SWEEP_2026-09-26.md` lines 20 and 34). One answer closes all three. The batch 3 builder's recommendation, which I share, is a council detention Tc for permitted discharge and storage and the office Tc for the pipe.
   5. **Yarra Ranges:** I found no council write-up for it in `02_COUNCIL_RULES` and the 26 Sep sweep tags its values "Assumed", so the rule would stay dormant there.
   6. **Question:** Monday item 21 (b), which also answers C15 and C17.
   7. **Build order:** 5.

4. **BUG-1091, pipes DN450 and larger lose their minimum grade in redesign and auto-design.**
   1. **What the drafter sees:** an existing DN450 carrying 30 L/s is redesigned at 1 in 1,509 where Edit Pipe says 1 in 200.
   2. **Class:** BUILD-NOW.
   3. **Size:** S. Pass the whole Settings ladder to the sizer for every size.
   4. **Why:** R-03 ("the per-diameter ladder governs") and R-00 (one table). The code's own comment calls it a disagreement "kept as today, listed for Tim", but it needs no number from you: whatever Settings holds, the sizer reads. The ladder values themselves are the guidebook review's job (decisions item 19 and 23, 29 Oct), which may change them; this fix follows automatically. Do not hard-code any ladder.
   5. **Build order:** 6.

5. **BUG-901, cover is measured to the inside top of the pipe.**
   1. **What the drafter sees:** a concrete 375 shows 320 mm cover when it is really about 275 mm, so it can pass a 300 mm rule it fails.
   2. **Class:** BUILD-NOW. Already queued as B-012 (`team_fix_c77g`); listed for completeness.
   3. **Size:** M. The wall-thickness table per material and size is the work.
   4. **Why:** your ruling of 29 Oct, "yes, add the pipe wall" (`decisions\2026-10-29_TIM_ANSWERS.md` item 17).
   5. **One doubt:** your example of about 20 mm for UPVC 225 looks high to me against what I know of PVC-U sewer pipe, which has a wall of a few millimetres up to about 10 mm at that size. I have not looked it up in a standard. The builder should take the wall from the pipe data or the standard, seed the table tagged Assumed, and show it to you on Settings. Safe direction: a smaller wall means a smaller correction.
   6. **Related, unfiled:** BUG-775 (services-crossing clearance) has the same blind spot (measures to the inside of the pipe).
   7. **Question:** Monday item 21 (l).
   8. **Build order:** 2 (queued).

6. **BUG-902, cover is checked only at the two pits.**
   1. **What the drafter sees:** a pipe under a lower garden bed between two raised lids is never checked for cover there.
   2. **Class:** BUILD-NOW, for the first step only.
   3. **Size:** S for the note; M later for real checking along the pipe.
   4. **Why:** RULES 12.2 and R-27: say what was not checked, never leave a silent gap. Add one Unknown line to the CDRULES row, "Cover between the pits not checked (lids only)", on a Settings switch ON. That is the batch 4 builder's own first recommendation.
   5. **Later:** sampling ground levels along the pipe needs a spacing and the long-section ground line, which BUG-1192 is about to make honest. Leave it until then; no question now.
   6. **Build order:** 13.

7. **BUG-903, different screens judge one pipe against different minimums.**
   1. **What the drafter sees:** the Inspector says OK where CDRULES warns, because one uses one grade figure and the other uses the ladder, and cover differs (office 300 against the council value).
   2. **Class:** BUILD-NOW.
   3. **Size:** M. The Inspector and Hub read the same lookup as CDRULES.
   4. **Why:** R-03 and R-04 (the council value wins when present) and design rule 1, one code path per behaviour. The batch 4 builder wanted you to confirm the ladder first; the ladder is the guidebook review's job (decisions item 19), and one lookup follows whatever Settings holds.
   5. **Do after BUG-1091.**
   6. **Build order:** 9.

8. **BUG-907, pit drop where the pipe gets bigger compares inverts only.**
   1. **What the drafter sees:** a 150 in at 10.000 and a 300 out at 9.980 passes although the outlet top is 130 mm above the inlet top.
   2. **Class:** BUILD-NOW. Already queued as B-013 (`team_fix_c77h`); listed for completeness.
   3. **Size:** S.
   4. **Why:** your ruling of 29 Oct, "yes", warn and never block (decisions item 18).
   5. **Build order:** 3 (queued).

9. **BUG-866, the CDDESIGN rainfall note says the curve reads "7 to 9 per cent high".**
   1. **What the drafter sees:** a comfort sentence on every detention design. On the two Glen Eira sheets audited the curve reads 6 to 8 per cent low, so storage is about 18 per cent short (job 24-115: 2.12 m3 against the 2.58 m3 issued).
   2. **Class:** BUILD-ON-RECOMMENDED, for the note wording only.
   3. **Size:** S. Reword the text and update the two golden sheets that carry the old sentence.
   4. **Why:** you said "leave them until you've checked the curve" (decisions item 16), so no curve number changes. You did not say yes or no to the new wording, so it is built as a draft and reported to you: "may be high or low by up to about 8 per cent; storage moves about 2.5 times as much". An untrue sentence on a council sheet should not wait for the curve check (RULES 12.1).
   5. **The curve itself stays with the desk's guidebook comparison** (decisions item 23, stage a); it is not a question for you today. The heading BUG-866 is also shared with an installed fix for a different bug (CDCHECKIGNORE Undo); the desk needs a new number for this one (24 Oct triage section A).
   6. **No new question.** If you object to the wording, say so.
   7. **Build order:** 1.

10. **BUG-1096, the rainwater-tank reuse credit never runs on a real job.**
    1. **What the drafter sees:** on a Manningham job (gross storage 10 m3, 300 m2 roof into a 3,000 L plumbed tank, 500 m2 impervious) the credit should be 1.50 m3, net 8.50 m3. The sheet shows no credit section, so the tank is about 18 per cent bigger than needed.
    2. **Class:** BUILD-ON-RECOMMENDED.
    3. **Size:** L. A new group on the CDDESIGN window, wiring through to the result, a sheet section.
    4. **Why:** R-10 already says ask on every job and apply known council formulas (Manningham, Kingston, Bayside) without asking, so the behaviour is ruled. Where the boxes sit on the window is your layout call. Must be built together with BUG-1098 (Kingston credit rule over-credits big tanks: a 6,000 L tank credits 1.50 m3 against the council's 1.00 m3), or the first working credit would be on the unsafe side.
    5. **Question:** Monday item 21 (c).
    6. **Build order:** 16.

---

## B. Design or window calls (11)

1. **BUG-1192, the long section hides a real ground depression.**
   1. **What the drafter sees:** survey levels more than 1.20 m off the pit covers are dropped silently and a straight ground line is drawn through the covers. A pipe crown at RL 9.20 looks buried 0.80 m below RL 10.00 when the real ground is RL 8.50.
   2. **Class:** BUILD-NOW for the first step; one drawing choice goes to you.
   3. **Size:** M.
   4. **Why:** RULES 12.2 and R-27. Step one is text only, behind a switch ON: CDPROFILE prints "[CE] Survey levels between chainage 9.0 and 11.0 m differ from the pit covers by more than 1.20 m and were not used; the ground line there runs straight between the covers. Check the survey.", and the review lists it. Step three is R-00: the three tolerances (0.60, 0.90, 1.20 m) become named Settings values with today's numbers. Nothing drawn changes.
   5. **Question:** whether to also draw that stretch differently is Monday item 21 (d).
   6. **Build order:** 8.

2. **BUG-1031, no "Delete cell" on the Pit Schedule right-click menu.**
   1. **What the drafter sees:** a cell cannot be blanked from the window, so the Settings promise "a cell you clear in the Pit Schedule stays blank" (BUG-783) cannot be checked.
   2. **Class:** BUILD-NOW.
   3. **Size:** S. The handler already exists and nothing calls it.
   4. **Why:** the Settings page itself promises blank cells; git history shows the menu item was never removed on purpose (it was never there). Add "Delete cell" between Restore Cell and Restore Row. A window is never accepted by a machine (RULES 5.7), so it needs a Codex look after.
   5. **Build order:** 11.

3. **BUG-685, CD "work it out from the grade" rounds the typed level.**
   1. **What the drafter sees:** typed upstream 10.125 at 1 in 100 over 10 m: the typed end becomes 10.13, the other 10.03. Two of your rules disagree: a typed level is never moved (INT-059 item 23) and inverts are held to 2 dp, nearest 10 mm (locked, rulebook "Rounding and units").
   2. **Class:** NEEDS-TIM.
   3. **Size:** S once ruled. Found by reading only; nobody has seen it in AutoCAD, so a robot reproduction can run first.
   4. **Why:** the carpark says not to change it before your ruling. The output today is internally consistent (the fall is exactly 1 in 100); what is wrong is that the 5 mm change is silent. Typing three decimals is rare.
   5. **Question:** Monday item 21 (h).
   6. **Build order:** none yet.

4. **BUG-857, the Grade mismatch box: the X still places the pipe.**
   1. **What the drafter sees:** typed "1 IN 100" with inverts that give 1 in 198; the box has two buttons and no Cancel; closing it with the X places the pipe at the typed 1 in 100.
   2. **Class:** BUILD-NOW.
   3. **Size:** S.
   4. **Why:** your ruling UX-WIN-01, 25 Sep: "Enter = Apply, Esc = Cancel", as in AutoCAD's own dialogs (`decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` line 1833). So the X and Esc cancel and no pipe is placed, with one command line line saying so. Not an engineering value, and nothing is blocked (the drafter just retries). Needs a Codex look.
   5. **Build order:** 10.

5. **BUG-1148, pasting a pit from a "Save As" sister drawing gives it this drawing's values.**
   1. **What the drafter sees:** copy Stage 2's P4 into Stage 1 and it takes Stage 1's P4 size, type and levels, with stray extra labels.
   2. **Class:** NEEDS-TIM.
   3. **Size:** L. The batch 2 builder showed the carpark's suggested fix cannot work (after Save As both drawings carry the same pit identity, and AutoCAD marks every paste "from another drawing"). The exact fix is a "made in this drawing" stamp that Save As re-issues: a new identity scheme, so a workflow card first (the command review gate).
   4. **Why:** how often colleagues paste between stage drawings is unsure. The other options are a heads-up line or leaving it.
   5. **Question:** Monday item 21 (i).
   6. **Build order:** none yet.

6. **BUG-855, Pit Schedule "data issues" goes up by one after the first CDSYNC.**
   1. **What the drafter sees:** 95 before, 96 after; rows identical; a second CDSYNC changes nothing.
   2. **Class:** FACTS.
   3. **Size:** S. The batch 2 builder's best candidate is that the first CDSYNC records a pipe that was drawn but never recorded (the open-end pipe next to P8), so the check counts it for the first time: a real issue, not a defect.
   4. **How to settle it:** one robot run: save the Drawing check details before and after CDSYNC, compare by kind and row, and read the CE log line "Merged missing drawing entities". If the new row is legitimate, record it as by design and have the robot compare the row lists, not the bare count. Codex W1-03 neither confirmed nor cleared it.
   5. **Gather order:** G5. No question for you.

7. **BUG-587, drawn Pit Schedule remarks cross the row lines.**
   1. **What the drafter sees:** a third line of a custom note crosses the divider and the bottom border on the issued schedule; it survives save and reopen.
   2. **Class:** BUILD-ON-RECOMMENDED.
   3. **Size:** M to L. Every row is a fixed 750 units tall, and the same 750 sets the template block stretch and the continuation-sheet offsets.
   4. **Why:** the batch 2 builder's recommendation is that a row grows only when its remark needs more than two lines, so ordinary rows stay 750 and existing schedules do not move; ships behind a switch ON. Variable row height in the office template is your call. Not truncating the note and keeping text readable are your standing requirements, so smaller text is out.
   5. **Question:** Monday item 21 (e).
   6. **Build order:** 15.

8. **BUG-648, AG drain grade is checked but never labelled.**
   1. **What the drafter sees:** a 10 m AG drain with a 1:50 grade shows no grade text on the drawing.
   2. **Class:** BUILD-ON-RECOMMENDED.
   3. **Size:** L. A new kind of link between drain and label so ERASE, Undo, Redo and MOVE treat the label with the drain. Touches linking and Undo, so it needs an Opus review.
   4. **Why:** the label itself is already approved (card UX-SURF-04: "grade check and label"). What is not settled is the copy and renumber behaviour (`release-v3-colleagues-FB_TEAM_BATCH3_REPORT.md`, "Skipped and why: FB-18"). The recommendation is the drain's own link kind, so renumber leaves the label alone and a copy gets a fresh label from its own levels; switch `agDrain.drawGradeLabel` ON.
   5. **Question:** Monday item 21 (f) and (g).
   6. **Build order:** 17.

9. **BUG-525, the other blues.**
   1. **What the drafter sees:** blue still in the Civil light and dark themes, the water tank windows' outline preview, the Civil spot level icon, and (Structural) hatch, notes and RC windows, B-bracing icons and time reports.
   2. **Class:** BUILD-NOW for everything except the two items you must see first.
   3. **Size:** M for Civil. Structural pieces (3.10, 3.11) are separate and outside the pilot because Structural stays on your PC (ruling B3).
   4. **Why:** your 28 Sep ruling, "our colours are gold, black and white / grey" (`decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md` line 581). It answers items 3.2 (themes, except the water line), 3.9 (tank windows) and 3.12 (spot level icon). Items 3.2's long-section water line and 3.14's pit snap glow are the two places the carpark says to ask with a picture. 3.13 (dark slate) changes only if you say it looks blue.
   5. **Not Shared:** nothing in this entry's list names CE_SHARED. The three `codex/noblue-*` branches mentioned in batch 5 overlap BUG-517 (the main blue), which is the Shared part.
   6. **Question:** Monday item 21 (j) and (k).
   7. **Build order:** 14.

10. **BUG-865, every double-click on a block scans every block.**
    1. **What the drafter sees:** in a survey drawing with thousands of point blocks a double-click may lag. No lag has been measured.
    2. **Class:** FACTS.
    3. **Size:** S to measure, S to fix.
    4. **How to settle it:** a robot timing run: double-click a downpipe in a survey drawing with a few thousand point blocks, after the BUG-859 fix (#1834) is in, since that fix keeps the same scan. If slow, read tags and pit status only for blocks whose outline is under the pointer (same answer, small saving). Using AutoCAD's own selection around the pointer changes the rule and needs a Codex look.
    5. **Gather order:** G6. No question for you.

11. **BUG-816, "no clear spot" lines print after a MOVE with Tidy labels off.**
    1. **What the drafter sees:** a typed MOVE of pit P3 prints "label: no clear spot among its usual positions, left where it is" even with Tidy labels off. A drafter cannot tell which setting to change.
    2. **Class:** BUILD-NOW.
    3. **Size:** S to M. A Settings row is window-lane work.
    4. **Why:** the batch 3 builder found these lines come from the always-on after-MOVE tidy (your D9), not from the Tidy labels switch. Give that step its own named Settings switch, default ON, so nothing changes by default and R-00 is met. Not a fault in itself.
    5. **Noticed, not filed:** every clash in runs 31 and 33 is "on the block Drawing Border". The tidy may be treating the border block as an obstacle by its outline. Needs its own carpark entry (see FOR TIM item 6).
    6. **Build order:** 12.

---

## C. Install and rollback facts (3)

1. **BUG-1166, Civil and Manager look for the office folders in different places.**
   1. **What the drafter sees:** if Max's folders arrived by "Add shortcut to My files", CDFEEDBACK says "saved on this PC" every time (you never see the reports), CE Blocks says the palette files are unavailable, CDNEWDWG finds no templates, and CDWT loses its tank window.
   2. **Class:** FACTS.
   3. **Size:** S to check; the fix (a shared office-folder lookup used by both) is M and PROTECTED because it can only live in CE_SHARED, which must stay byte-identical between Civil and Manager.
   4. **The fact:** on Max's PC, open File Explorer and see whether "Creative Engineering - Drafting" sits under `C:\Users\<name>\Creative Engineering` (Sync, the usual layout, then the bug does not bite) or under a folder starting "OneDrive - ". Two minutes at the install or by a screenshot. It also decides whether the installed BUG-1167 fix (moves other users' folders onto this PC's profile) finds the folders.
   5. **No question for you** until the fact is known; if it comes back as "OneDrive - ", the CE_SHARED change goes in with its own train.
   6. **Gather order:** G2.

2. **BUG-1169, Max's old July Structural may carry an older shared file with the same version number.**
   1. **What the drafter sees:** "command failed" lines on the first job, wherever Civil looks up its own files (help, linetypes, config lists).
   2. **Class:** FACTS.
   3. **Size:** S. The check costs minutes; the fallback fix is a plain start-up message naming the mismatch (S to M).
   4. **The fact:** the version and date of Max's Structural bundle (1.0.41, July) and whether it holds its own `CE_SHARED.dll`. If so, switch that bundle off with Enable/Disable on Restart in CEMANAGER before the first start. This is the same question as page 06 item 3 of the colleague pack (leave, switch off or remove), where the recommendation is already "switch off". Whether AutoCAD loads it first is unverified (RULES 12.5).
   5. **Gather order:** G3.

3. **BUG-1170, going back restores an old Manager that may stage updates by itself.**
   1. **What the drafter sees:** after a rollback the old Manager may try to put the new version back after 15 seconds, or fail quietly on a standard login.
   2. **Class:** FACTS.
   3. **Size:** S. No code; it is a release check and a rehearsal.
   4. **The fact:** Max's current Manager version (CEMANAGER shows it). If older than 22 Jul, rehearse the rollback on a spare standard login, restart AutoCAD twice, and list `C:\ProgramData\Autodesk\ApplicationPlugins` for any new CE folder. The rehearsal has not been done.
   5. **Gather order:** G4.

---

## D. Only on AutoCAD 2022 to 2024 (2)

Both depend on one fact that is already on your open list: **Max's AutoCAD year** (colleague pack page 06 item 2; Monday item 19b). The pack and INT-069 say 2027 but nobody has looked. If he is on 2027, neither is a pilot problem.

1. **BUG-1209, a downpipe cannot be placed directly on a valid pit on 2022 to 2024.**
   1. **What the drafter sees:** the pick at a valid pit centre is refused ("Exact source COPY receipts are unavailable on this AutoCAD version"); an unjoined downpipe can be placed elsewhere.
   2. **Class:** FACTS (Max's year), then BUILD-ON-RECOMMENDED if he is on an older year.
   3. **Size:** L. The audit itself marks it "protected change, route to owner". The smaller route (batch 5, option a) reads the pit under the pick at placement time; the larger ships a native component for the older years. Each year needs a robot pass.
   4. **Context:** your 15 Sep ruling puts 2022 to 2024 in scope for pipe behaviour, but the 2024 enabler has never been loaded on real 2022 to 2024 and colleague installs hold the pipe upgrade (UX-MIX-03). So the pilot is blind on those years until proven.
   5. **Gather order:** G1. **Build order:** none yet.

2. **BUG-1210, Edit Pipe and Edit Pit lose the real plan and picture on 2022 to 2024.**
   1. **What the drafter sees:** a generic diagram instead of the real bent route; cannot click a pipe end to reach its level box. The numeric editors still work.
   2. **Class:** FACTS (Max's year), then BUILD-ON-RECOMMENDED.
   3. **Size:** L to port the controls (one lane per year); S for the cheap option, a caption on the window, "Plan picture needs AutoCAD 2027", which is the batch 5 recommendation if Max is on an older year.
   4. **Gather order:** G1. **Build order:** none yet.

---

## E. Needs a protected file (1)

1. **BUG-1171, Civil's reports to you never arrive and pile up on a colleague's PC.**
   1. **What the drafter sees:** nothing. You never see Max's Civil failures; files carrying drawing names build up in his profile with no clean-up.
   2. **Class:** PROTECTED.
   3. **Size:** M. Point Civil's records at the folder Manager uploads (CE_SHARED `CeTelemetryStore`), sync Manager lane for lane by hand, add a clean-up of old files.
   4. **Your 29 Oct ruling narrows it** (decisions items 12 and 14): the receiver is you, drawing and client names do not leave the PC, and the upload switch (#1788) stays OFF until a short list is built. So the batch 4 option of making Manager upload the old folder is out: it would send drawing names to a folder others can open. The path fix, the clean-up and the short-list upload belong together in one Shared train.
   5. **For the pilot:** nothing is lost that exists today; colleagues report through CDFEEDBACK. I could not establish how fast the folder grows.
   6. **No question for you.** **Build order:** none yet (waits for a Shared train).

---

## READY-TO-APPEND QUESTIONS BLOCK

Plain text for CE 01 to append to `C:\CE_PLAN\QUESTIONS_FOR_MONDAY.md`. The file's last numbered item is 19b, so the next free number is 21 (re-check before appending in case another item landed). Format matches the "Added 24 Oct" section: bold lead, recommendation, example, other choice.

```
21. **ADDED Thu 29 Oct 2026 (CE 01 triage of the 27 pilot-critical bugs with no fix; areas\release-v3-colleagues-PILOT_NOFIX_TRIAGE_29OCT.md). TWELVE SMALL ENGINEERING AND DESIGN QUESTIONS. Nothing blocks: drafts are built on the recommended answers and your answer replaces them.**
   (a) **Pipe sizer (BUG-1088):** when CDDESIGN or a network redesign picks a pipe size for you, should it use the flattest grade each size is allowed and step up a size before going steeper? Today it takes the smallest pipe at any grade, up to 1 in 1. Your 28 Sep rule already allows very steep pipes and warns above 1 in 10, so no new number is needed. **Recommendation:** yes, because a 30 m pipe at 1 in 4 falls 7.5 m and cannot reach a council connection. **Example on a job:** a 40 L/s connection pipe comes out DN100 at about 1 in 3 today; with the rule it comes out DN225 at about 1 in 200 (a bigger pipe, a sensible depth). **Other choice:** one preferred grade for every size (for example 1 in 100): simpler, but ignores the grade ladder.
   (b) **Council time of concentration (BUG-1099, also open questions C15 and C17):** Boroondara (15 min), Maribyrnong (10 min) and Maroondah (5 to 12 min by lot size) publish their own detention time of concentration. CE has one Tc and it also sizes the outlet pipe, so on 26 Sep these were left at 5 min. Should CE hold two: the council's for permitted discharge and storage, and the office 5 min for the pipe? **Recommendation:** yes, so the tank follows the council and the pipe is not made smaller. **Example on a job:** a bare 600 m2 Maroondah lot: CE says 5.18 L/s permitted discharge, the council method says 3.68 L/s, so the tank is too small and the orifice too big. **Other choice:** use the council Tc for the pipe too (the pipe flow drops, so a smaller pipe); not recommended.
   (c) **Rainwater reuse boxes (BUG-1096):** CDDESIGN never works out the reuse credit because the window has no place to enter the tank. May a small "Rainwater reuse" group go on the same CDDESIGN page: tank size in litres, roof connected (pre-filled from the rating report) and a "plumbed for reuse" tick? **Recommendation:** yes, built together with the Kingston credit fix (BUG-1098) so a big tank is not over-credited, and the sheet says "needs confirmation" where a council has no recorded rule (rulebook R-10). **Example on a job:** Manningham, 10 m3 gross storage, 300 m2 roof into a 3,000 L plumbed tank: credit 1.50 m3, net 8.50 m3; today the sheet shows no credit and the tank is about 18 per cent too big. **Other choice:** pick the tank from the CDRULES water tank record instead of typing it.
   (d) **Long section where the survey is not trusted (BUG-1192):** CE will now print a warning line when survey levels more than 1.20 m off the pit covers are ignored (text only, no drawing change). Should CDPROFILE also draw that stretch of the ground line dashed with a note "Ground not confirmed here: check survey"? **Recommendation:** yes, on its own Settings switch, so an issued long section never shows a confident straight line over unknown ground. **Example on a job:** pipe crown RL 9.20, covers at RL 10.00, real ground RL 8.50: today the section shows a buried pipe, with the rule it shows a dashed stretch flagged for checking. **Other choice:** warning line only.
   (e) **Pit Schedule row height (BUG-587):** may a drawn schedule row grow taller when its remark needs more than two lines? Ordinary rows would stay the same height, so existing schedules do not move. **Recommendation:** yes, because the other ways are a wider column (changes the template) or smaller text (less readable). **Example on a job:** pit P2 with a three-line custom note: today the third line runs over the row border; with the rule only P2's row is one line taller.
   (f) **AG drain copy (BUG-648):** when an AG drain is copied, should the copy get its own grade label worked out from its own levels? **Recommendation:** yes. **Example on a job:** you copy a 20 m AG drain at the same levels and the copy reads the same grade; if you change the copy's level, its label changes and the original's does not.
   (g) **AG drain label wording (BUG-648):** keep "AG DRAIN AT 1 IN 50"? **Recommendation:** keep it. **Other choice:** "AG DRAIN 1 IN 50".
   (h) **Typed level that is not to the nearest 10 mm (BUG-685):** you type an upstream invert of 10.125 in CD and ask it to work out the other end at 1 in 100 over 10 m. Today the typed end quietly becomes 10.13 and the other end 10.03. Two of your rules disagree (a typed level is never moved; levels are held to the nearest 10 mm). **Recommendation:** keep the 10 mm rule but say it out loud, one line: "Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm)". The grade stays exactly 1 in 100. **Example on a job:** a surveyor's 3-decimal level typed straight in. **Other choice:** keep 10.125 exactly; then the other end is 10.03 and the pipe comes out at 1 in 105, flatter than you asked, or 10.02 and 1 in 95.
   (i) **Pasting a pit between Save As stage drawings (BUG-1148):** if Stage 2 was made by Save As from Stage 1 and you copy Stage 2's P4 into Stage 1, it takes Stage 1's P4 values. Do colleagues copy pits between stage drawings? **Recommendation:** treat it as a known limit for the pilot (one line on the Known Problems page: check the pit after pasting from a stage drawing) and build the "made in this drawing" stamp after a workflow card. **Example on a job:** a driveway pit moved from Stage 2 back into Stage 1 arrives with Stage 1's size and levels. **Other choice:** build the stamp now (a large change to how pits are identified).
   (j) **Water line colour (BUG-525):** your rule is no blue (gold, black, white and grey). The long section water line is the one place blue might stay. May it stay blue? **Recommendation:** yes, in that one place only, because water reads as water; the desk will show you a picture first. **Other choice:** grey or gold like everything else.
   (k) **Pit snap glow colour (BUG-525):** the temporary glow when you snap to a pit is light blue. Change it to gold? **Recommendation:** yes, so there is no list of blue exceptions beyond the water line; picture first. **Other choice:** leave it, since it is a temporary glow in the drawing, not a window.
   (l) **Pipe wall thickness table (BUG-901, already approved):** your examples were about 20 mm for UPVC 225 and about 45 mm for concrete 375. The 20 mm looks high to me for UPVC (a few millimetres up to about 10 mm) but I have not checked a standard. May the desk take the wall for each size and material from the pipe data or the standard, and show you the table on Settings tagged Assumed until you tick it? **Recommendation:** yes. **Example on a job:** a concrete 375 showing 320 mm cover really has about 275 mm; if UPVC walls are over-stated, UPVC cover would be under-stated by the difference.
```

---

## BUILD ORDER

BUILD-NOW and BUILD-ON-RECOMMENDED bugs, highest value for a drainage drafter's week first, smallest first on ties. File names are from the carpark entries (24 Oct, Civil 3.0.72) and must be checked against the shipping line (`claude/rel-2026102*`), not master. Every fix behind a Settings switch, ON, with a `REGRESSION_LOG.md` entry and a robot or Codex proof named.

1. **BUG-866 (S, BUILD-ON-RECOMMENDED).** CDDESIGN rainfall note and the two golden sheets. Wrong sentence on every detention sheet.
2. **BUG-901 (M, BUILD-NOW).** Already queued as B-012 (`team_fix_c77g`). `Rules/RulebookEngine.cs:466`; wall table in Settings.
3. **BUG-907 (S, BUILD-NOW).** Already queued as B-013 (`team_fix_c77h`). `Rules/PitDropRule.cs:150-156`.
4. **BUG-1095 (M, BUILD-NOW).** `Rules/CouncilRuleValues.cs:99-114`, `Services/AutoDesignService.cs:309-321`, `Services/PumpSizingService.cs:211-212`, `Assets/Config/council-profiles.json`.
5. **BUG-1099 (M, BUILD-ON-RECOMMENDED).** `Services/DetentionSizingService.cs:277-309`, `AutoDesignService.cs:404-408`, `Rules/CouncilRuleValues.cs:116-159`. Do with the answer to question (b); Maroondah only until Yarra Ranges has a source.
6. **BUG-1091 (S, BUILD-NOW).** `SettingsSizingStandards.cs:72`, `Models/PipeSizingModels.cs:38-39`, `NetworkDesignService.PreserveExistingSizes.cs:114-127`. Prerequisite of 7 and 9.
7. **BUG-1088 (M, BUILD-ON-RECOMMENDED).** `Services/PipeSizingSolver.cs:131-186`, `AutoDesignService.cs:656-680`, `NetworkDesignService.cs:290`. Check R-01's 3.0 m/s UPVC limit first.
8. **BUG-1192 (M, BUILD-NOW).** `ViewModels/LongitudinalSectionViewModel.cs`, `Services/ProfileRouteEvidenceCaptureService.cs`, `ProfileRouteReviewService.cs`. Step one (warning) and the Settings tolerances first; the dashed stretch waits for question (d).
9. **BUG-903 (M, BUILD-NOW).** `Services/DesignValidationService.cs:350`, `Services/MinimumCoverForChecks.cs:18-30`. After 6.
10. **BUG-857 (S, BUILD-NOW).** New Pipe window Grade mismatch box. Needs a Codex look.
11. **BUG-1031 (S, BUILD-NOW).** `Dialogs/PitScheduleDialog.xaml` and `.xaml.cs` (`OnDeleteCellClicked`). Needs a Codex look. Both 10 and 11 are window-lane work.
12. **BUG-816 (S to M, BUILD-NOW).** `LinkService.TextClashTidyUp.cs`, `TextClashTidyUpRule.cs`; new Settings row.
13. **BUG-902 (S, BUILD-NOW).** `Rules/RulebookEngine.cs:444-474`; one Unknown note on the CDRULES row.
14. **BUG-525 (M, BUILD-NOW).** Civil only: `Themes/LightTheme.xaml`, `DarkTheme.xaml`, `Dialogs/WaterTankDialog.xaml:232`, `WaterTankPlanBlockPickerDialog.xaml:52`, `Resources/Icons/commands/dimension_16.png` and `_32.png`. Water line and snap glow wait for questions (j) and (k). Structural pieces after the pilot.
15. **BUG-587 (M to L, BUILD-ON-RECOMMENDED).** `PitScheduleContinuationLayout.cs:25` and the template block. Window lane plus a Codex look.
16. **BUG-1096 with BUG-1098 (L, BUILD-ON-RECOMMENDED).** `Services/AutoDesignOrchestrator.cs:156-157`, `CivilDesignService.cs:145-174`, `ReuseCreditService.cs:166-183`; CDDESIGN window. Window lane plus a Codex look.
17. **BUG-648 (L, BUILD-ON-RECOMMENDED).** AG drain link kind (linking and Undo); needs an Opus review and a Codex look.

**Gather order for the facts (not buildable):** G1 Max's AutoCAD year (BUG-1209, 1210); G2 where Max's office folder lands (BUG-1166); G3 Max's old Structural bundle and its shared file (BUG-1169); G4 Max's Manager version and the rollback rehearsal (BUG-1170); G5 CDSYNC row-list robot run (BUG-855); G6 double-click timing robot run after #1834 (BUG-865).

**Waiting, with no build order:** BUG-685 (your ruling, item h), BUG-1148 (your ruling, item i, then a card), BUG-1171 (a Shared train).

---

## What I did not do or could not establish

1. **No code was read, nothing built or run, no AutoCAD, robot or Codex.** File names and line numbers are the carpark's, filed 24 Oct against 3.0.72; the later trains (C-69 to C-76) may have moved them or fixed a part. The builders' first step is to confirm each claim on the shipping line.
2. **Whether R-01 (UPVC 3.0 m/s) already reaches the sizer** (BUG-1088): I could not establish it.
3. **Whether the pipe data holds wall thickness** (BUG-901), and whether Tim's 20 mm UPVC example is right: I have not looked up a standard.
4. **Yarra Ranges** has no council write-up in `02_COUNCIL_RULES`; its values are tagged Assumed.
5. **Past-job impact** of BUG-1095 and BUG-1099: I did not search the job records for Darebin, Maribyrnong, Boroondara or Maroondah detention designs.
6. **The sizes** (S, M, L) are my guesses from the carpark entries, not a builder's.
7. **Pit Schedule row height (BUG-587):** the knock-on to the template block and continuation sheets is the batch 2 builder's reading; I did not check it.
8. **I did not edit** `BUG_CARPARK.md`, `DESK_LOG.md`, the register or `QUESTIONS_FOR_MONDAY.md`. The extra finds (the Drawing Border clash, the BUG-866 duplicate number, BUG-775's wall blind spot) are for CE 01 to file.
