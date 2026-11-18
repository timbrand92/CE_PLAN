# Click, pick and typing budgets for the first release: a proposal for Tim to set

**Written:** Wed 18 Nov 2026 (Melbourne time), read-only, for Tim's screen rule 18.
**Status: PROPOSAL, DRAFT.** Nothing here is a decision until Tim's word is filed in `DECISIONS.md`. Nothing was built, run or installed. AutoCAD was not started and no AutoCAD profile, licence or setting was touched. No drawing, client name, address or job number was read or used; jobs are the made-up Job 1 to Job 3 of `design\FUNCTION_PLAN.md` section 2, and the old-job figures are the anonymous counts in `design\EASY_AND_AUTOCAD_LIKE.md`.

**Tim's rule 18, in his words:** "Every common task has a tap budget, a scroll budget and a count of typed fields. Write them down and test them. Over budget is not finished. In AutoCAD: commands, clicks and picks, and one undo per command."

---

## 1. The answer first (for Tim)

1. **I have written a budget for each of the 19 common tasks.** Each has a target (the tight number I would hold the build to) and a limit (the looser number, used where two readings are possible). Scrolls are 0 for every task.
2. **Most placing and editing tasks come out at one command, a few picks, two or three clicks and no typing.** That follows from your own rulings: the window opens filled in (D-060, D-234), pipes carry on like PLINE (D-237), a pipe follows what it joins (D-263), and cover levels are never asked for at placing (D-178).
3. **The five tasks done most often on a job** (section 5) are editing an object, drawing a pipe from pit to pit, placing downpipes, placing a pit like the last one, and placing a pit that differs in one thing. Their budgets matter most.
4. **Some budgets rest on evidence only in part.** Section 4 lists what I could not ground: no record of seconds per click anywhere, the pit grip's behaviour, two command names not ruled (the Job window and the Unfinished list), and a clash between D-237 ("one undo steps back one pipe") and your rule 18 ("one undo per command").
5. **What I ask you to do:** set or change each budget in the tick list below, one line each, and answer the undo clash (section 4, item 1). Format of each line is: command, picks in the drawing, clicks, typed figures. Limit in brackets.

**The tick list (tick to accept, or write a new number beside it):**

1. [ ] **Place a pit like the last one:** PIT, 1 pick, 2 clicks, 0 typed. (Limit: 1 pick, 3 clicks, 0 typed.)
2. [ ] **Place a pit that differs in one thing:** PIT, 1 pick, 3 clicks, 0 typed. (Limit: 1 pick, 4 clicks, 1 typed; this is the build chat's figure.)
3. [ ] **Place a plastic pit (PP):** PP, 1 pick, 2 clicks, 0 typed. (Limit: 1 pick, 3 clicks, 0 typed.)
4. [ ] **Draw a pipe from pit to pit like the last one:** CD, 2 picks, 2 clicks, 0 typed. (Limit: 3 picks, 3 clicks, 0 typed.)
5. [ ] **Draw a run of five pipes through four pits with one bend:** CD, 7 picks, 2 clicks, 0 typed. (Limit: 8 picks, 4 clicks, 0 typed.)
6. [ ] **Change one pipe's grade:** no command, 1 pick (double-click), 2 clicks, 0 typed. (Limit: 1 pick, 3 clicks, 1 typed.)
7. [ ] **Hold an invert at one end:** no command, 1 pick, 1 click, 1 typed. (Limit: 1 pick, 2 clicks, 1 typed.)
8. [ ] **Move a pit with its pipes (plain MOVE):** MOVE, 3 picks, 0 clicks, 0 typed. (Limit: 4 picks, 1 click, 0 typed.)
9. [ ] **Resize a pit by its grip:** no command, 3 picks, 0 clicks, 0 typed. (Limit: 4 picks, 0 clicks, 1 typed.)
10. [ ] **Place six downpipes:** DP, 6 picks, 2 clicks, 0 typed. (Limit: 6 picks, 3 clicks, 0 typed.)
11. [ ] **Place the LPD at the end of a system:** LPD, 1 pick, 2 clicks, 0 typed. (Limit: 2 picks, 3 clicks, 1 typed.)
12. [ ] **Place a tank with its re-use figure:** WT, 2 picks, 2 clicks, 1 typed. (Limit: 2 picks, 4 clicks, 2 typed.)
13. [ ] **Check detention on a finished job:** DET, 0 picks, 1 click, 0 typed. (Limit: 0 picks, 2 clicks, 0 typed.)
14. [ ] **Fix "storage short" by changing one thing:** DET, 0 picks, 2 clicks, 0 typed. (Limit: 0 picks, 3 clicks, 1 typed.)
15. [ ] **Place the pit schedule:** SH, 1 pick, 0 clicks, 0 typed. (Limit: 1 pick, 1 click, 0 typed.)
16. [ ] **Set up a new job (Job window, first drawing):** one command (name not ruled), 2 picks, 7 clicks, 3 typed. (Limit: 4 picks, 10 clicks, 5 typed.)
17. [ ] **Find and fix the one thing wrong on the Unfinished list:** one command (name not ruled), 0 picks, 2 clicks, 1 typed. (Limit: 1 pick, 3 clicks, 1 typed.)
18. [ ] **Edit any object (double-click route):** no command, 1 pick, 2 clicks, 0 typed. (Limit: 1 pick, 3 clicks, 1 typed.)
19. [ ] **Undo any of the above:** U once, 0 picks, 0 clicks, 0 typed. (Limit: one U per step where a ruling says steps, section 4 item 1.)

---

## 2. How the counts are made (so every budget means the same thing)

1. **Command:** one typed short name such as PIT or CD, followed by its Enter. Counted as 1, not by letters. A plain AutoCAD command (MOVE, U) counts the same way.
2. **Pick:** one click in the drawing: a place, a pit, a pipe, a corner, a grip. A double-click on an object counts as 1 pick.
3. **Click:** one click in a CE window or on a right-click menu, plus an Enter or Esc used to accept or finish. "OK" is 1 click. Enter to finish a run is 1 click.
4. **Typed:** one figure typed into a box or onto the command line. A command name is not a typed figure. A figure picked from a list is a click, not a typed figure.
5. **Scrolls:** 0 for every task. A window that needs a scroll to finish the task is over budget.
6. **One undo:** after the task, one U puts the drawing back exactly as it was, with every tag, label and schedule row that the task made or changed.
7. **Target and limit:** the target is the tight reading and the number the build is held to. The limit is the looser reading, where the ruling can be read two ways or one more small step is normal. Over the limit is "not finished" (rule 18). Between target and limit is "finished, but look at it".
8. **What the budgets assume:** the window opens filled in (D-060, D-234); there is no "Are you sure?" question (rule 21); Cancel and Esc change nothing; the job is not fresh, so the Job window is already done unless the task says so.
9. **The build chat's figure, used as an anchor:** the Pit window in the approved style is "PIT + 1 pick + 4 clicks + 1 typed field + 0 scrolls". It did not say which four clicks or which figure. I take it as the limit for a pit that differs in one thing (task 2), and ask for tighter figures when the pit is the same as the last (task 1).

---

## 3. The 19 tasks

### Task 1. Place a pit like the last one

1. **Today:** old PIT, 45 runs on the two office PCs, median 29 s, 8 of the 45 not completed (18%). One pit per window. The old PIT has no "same again" step and no time is recorded for "like the last". Not measured separately. On the old jobs, 25 of 46 pits (54%) repeated the pit before.
2. **Proposed budget:** target PIT, 1 pick, 2 clicks (OK, Enter to finish), 0 typed, 0 scrolls, one undo. Limit: 1 pick, 3 clicks, 0 typed.
3. **Why that is achievable:** the window opens filled in with last time's choices and Enter accepts (D-234), pits open with last used (D-263), the number comes next free (D-075) and no cover level is asked for at placing (D-178; it prints TBC). Style: the Pit window is the small-tool form (`STYLE_APPROVED_18NOV.md` section 1).
4. **What would break the budget:** (a) asking for a number or cover level at placing; (b) a first-time-in-session window that opens on an office default and has to be changed (D-263 says last used is kept between AutoCAD sessions, which avoids this).
5. **How it is tested:** a robot count. The robot sends PIT, one pick, Enter, Enter on a test copy, counts its own inputs, and checks the pit, tag and "TBC" cover text appear. Pass is exactly the target with no extra input.

### Task 2. Place a pit that differs in one thing

1. **Today:** same old PIT figures as task 1 (45 runs, median 29 s). On the old jobs 21 of 46 pits (46%) differed from the one before, mostly by size. Time not measured separately.
2. **Proposed budget:** target PIT, 1 pick, 3 clicks (change one tile or tick, OK, Enter), 0 typed. Limit: 1 pick, 4 clicks, 1 typed (a change made through a list, or a typed number). The limit is the build chat's figure.
3. **Why that is achievable:** the same window opens filled in (D-234) and one change is one click in step 1 "What you type" (`STYLE_APPROVED_18NOV.md` section 1 item 4). The pit opens at 450 x 450 and size from depth is only a feature when the depth is known (D-235), so size is a plain choice.
4. **What would break the budget:** (a) the change being in a list that needs two clicks (open, choose), which uses the whole limit; (b) the window asking for more than the one change (a lid choice appearing when only the size changed).
5. **How it is tested:** a robot count with one scripted change (size 450 to 600). Codex then looks at the real window to confirm the change was one click and nothing scrolled.

### Task 3. Place a plastic pit (PP)

1. **Today:** old PP had no runs in the records. It was "pre-filled as a 350 x 350 plastic pit"; the old CDPIT350 to CDPIT1200 size presets also had no runs. By hand: not measured. On the old jobs 350 x 350 was the commonest single size (22 of 52, 42%).
2. **Proposed budget:** target PP, 1 pick, 2 clicks (OK, Enter), 0 typed. Limit: 1 pick, 3 clicks, 0 typed.
3. **Why that is achievable:** D-235 (Tim: "PP COMMAND SHOULD OPEN PRESET WITH 350 x 350 PLASTIC PIT") means the window opens already as a 350 x 350 plastic pit. Plastic pits stay out of the schedule unless ticked (D-076).
4. **What would break the budget:** PP is "Pedit" in your own alias list (FM-002), so a second meaning for the same two letters could push a drafter into an extra step; and a plastic pit asking for a lid class it does not have.
5. **How it is tested:** a robot count on a test copy, then a check that the pit is plastic, 350 x 350, and not in the schedule. A Codex look at the window.

### Task 4. Draw a pipe from pit to pit like the last one

1. **Today:** old CD, 155 runs, median 21 s, 14 of 155 not completed (9%). One pipe per run, window every time. By hand this is a PLINE with the width set; not measured. On the old jobs 155 of 230 pipes (67%) repeated the settings of the pipe before.
2. **Proposed budget:** target CD, 2 picks (start pit wall, end pit wall), 2 clicks (OK, Enter), 0 typed. Limit: 3 picks (one re-pick), 3 clicks, 0 typed.
3. **Why that is achievable:** the window opens filled in (D-234); a pipe starting from a pipe or pit opens with the size of what it joins (D-263); the pipe starts exactly on the wall in line with the click (D-034, D-102); grade 1 in 100 and size 100 are the office defaults, right on 89% and 64% of the old jobs (D-143, D-174).
4. **What would break the budget:** (a) a pipe that lands "short of the outer wall line" and stays loose (D-270), forcing a second pick; (b) the window opening on a size that is wrong for the run, needing a size click.
5. **How it is tested:** a robot count on a test copy: CD, two picks, two Enters, then a check that both ends are joined and the label reads in the office wording. Codex looks at the label position.

### Task 5. Draw a run of five pipes through four pits with one bend

**Reading used:** five pipes have six end points, so "four pits" means four pits in the middle, with the start and finish on pits or the outlet. If Tim meant something else, the pick count changes by one per end point.

1. **Today:** old CD, one pipe per run: five runs at the 21 s median is about 105 s (5 x 21 s, worked out, not a measured run of five). Bends needed a second command (EASY section 8 item 3.1). 18% of gravity pieces on the old jobs had bends.
2. **Proposed budget:** target CD, 7 picks (start, four pits, the bend point, finish), 2 clicks (OK, Enter), 0 typed. Limit: 8 picks, 4 clicks (one size change in the window), 0 typed.
3. **Why that is achievable:** D-237 (Tim: "Like PLINE and LINE: it carries on"): click to click, a click between ends is a bend, reaching a pit ends that pipe and starts the next, Enter finishes. D-189 allows bends on every kind of pipe.
4. **What would break the budget:** (a) a second command or window each time a pipe reaches a pit; (b) the pipe size changing along the run, which costs a window visit each time; (c) the undo reading in section 4, item 1.
5. **How it is tested:** a robot count with a scripted run of seven picks on a test copy, then a check of five pipes, five labels, four pits joined at both sides and the bend kept. Stopwatch only if Tim wants a time figure (none is proposed).

### Task 6. Change one pipe's grade

1. **Today:** old PIPEEDIT 66 runs and CDEDIT 67 runs (8 PIPEEDIT runs not completed); no median is recorded. Change by hand: not measured. 89% of old graded labels were 1 in 100, so a different grade is the exception (5 of 47).
2. **Proposed budget:** target no command, 1 pick (double-click the pipe), 2 clicks (choose the grade from the list, OK), 0 typed. Limit: 1 pick, 3 clicks, 1 typed (a typed grade).
3. **Why that is achievable:** D-061 (double-click opens the window it was placed with; Properties does the same); grade is "pick or type" (D-079, D-080); inverts and the label follow (FOUNDATION, "one fact one place"). Rule 26: a typed or locked value is never overwritten, so a held invert shows both instead.
4. **What would break the budget:** (a) a held (padlocked) invert at one end, which makes the change need a decision click; (b) the double-click not opening the CE window (task 18, item 4).
5. **How it is tested:** a robot count on a test copy with one scripted grade change, then a check that the label, both inverts and the downstream inverts changed as the sums say. Codex looks at the window.

### Task 7. Hold an invert at one end

1. **Today:** not measured; no record of how often or how long. Old tools could override levels by typing; D-080 asks for both inverts to be typeable.
2. **Proposed budget:** target no command, 1 pick (double-click the pipe), 1 click (OK), 1 typed (the invert). Limit: 1 pick, 2 clicks (padlock then OK), 1 typed.
3. **Why that is achievable:** D-080 (Tim: "you need ability to override both invert levels as well"); the number carries a padlock and a status word on every line (D-128); typing in the box is the hold, per INPUT_AUDIT section 10 (typed "to hold").
4. **What would break the budget:** (a) the hold needing the padlock clicked separately every time; (b) the box refusing a value that clashes with the other end (it must warn amber, never block, rule 24).
5. **How it is tested:** a robot count, then a check that the held invert is unchanged after a grade change on the next pipe. Tim's judgement is needed only on whether a typed hold should need the padlock click: that is an engineering call.

### Task 8. Move a pit with its pipes (plain MOVE)

1. **Today:** not measured. The plain MOVE is AutoCAD's own; whether the old plug-in kept the pipes joined is not recorded in what I read. The new build proved joins through move in the 16 Nov trial (FM-015).
2. **Proposed budget:** target MOVE, 3 picks (the pit, base point, new point), 0 clicks, 0 typed. Limit: 4 picks, 1 click (Enter ending a selection).
3. **Why that is achievable:** D-181 (tag and cover text go with the pit and a hand-moved label keeps its offset); pipe ends follow the pit and lengths and labels update (D-256, D-034); a join is a pointer kept on the object itself (FM-015).
4. **What would break the budget:** (a) a window-selection that grabs the labels but not the pit, adding a pick; (b) loose pipe ends that were never joined (D-270) staying behind, so the drafter has to move them too.
5. **How it is tested:** a robot count of MOVE and three picks on a test copy, then a check that tag, cover text, three joined pipes, labels and schedule row all moved, and one U puts everything back. This is a Claude-accepted case (nothing to see on screen except the drawing values).

### Task 9. Resize a pit by its grip

1. **Today:** not measured. D-256 says pipe ends follow the wall when a pit is made smaller or bigger "by grip, the block's own properties or the window"; whether the old plug-in did this is not in the records.
2. **Proposed budget:** target no command, 3 picks (select the pit, the grip, the new place), 0 clicks, 0 typed. Limit: 4 picks, 0 clicks, 1 typed (a typed size).
3. **Why that is achievable:** D-256 (each pipe end moves to the new wall, lengths and labels update, one Undo puts it all back). The grip itself is part of the pit's block.
4. **What would break the budget:** (a) the grip not stepping to a whole pit size from the office list (a free stretch gives a size that is not in the table, and a typed correction); (b) the custom grip trial that failed once (D-155).
5. **How it is tested:** a robot count where possible (the grip drag is a scripted pick sequence), then Codex on screen, because a grip is something to see. If the grip cannot be driven, Tim's own hand once. Marked "not yet grounded" in section 4.

### Task 10. Place six downpipes

1. **Today:** old DP only 2 runs in the records, while the six old jobs held 77 downpipes. They were placed from the palette and by COPY, not timed. Not measured. On the old jobs 78 of 78 downpipes repeated the one before.
2. **Proposed budget:** target DP, 6 picks, 2 clicks (OK, Enter to finish), 0 typed. Limit: 6 picks, 3 clicks (one change of kind), 0 typed.
3. **Why that is achievable:** D-186 (Tim: "Keep clicking, Enter to finish"): one window, then pick after pick, each numbered in turn; D-279 adds the nine kinds in one window; downpipe size is the office 100 or the pipe it sits on (INPUT_AUDIT Inlet item 3). A downpipe is never numbered on the sheet (0 of 6 old jobs).
4. **What would break the budget:** (a) the window asking for a roof area per downpipe (0 of 6 old sheets print it; EASY section E item 3 proposes it leave the placing window); (b) a mixed set (two inspection openings in the six), each kind change costing one click.
5. **How it is tested:** a robot count of DP, six picks, two Enters, then a check of six blocks and the closing line "6 downpipes placed. Not joined yet: 6". The same six placed by drag from the palette must give identical objects (EASY question H5).

### Task 11. Place the LPD at the end of a system

1. **Today:** old CDLPD, 5 runs on the ribbon; no median recorded. Not measured. The legal point of discharge is marked "LPD" on 2 of the 6 old jobs.
2. **Proposed budget:** target LPD, 1 pick (the end of the last pipe), 2 clicks (the kind, OK), 0 typed. Limit: 2 picks (the tag slid to the boundary), 3 clicks, 1 typed (a connection invert not yet in the Job window).
3. **Why that is achievable:** D-274 (Tim: "One tool, LPD"): pick the end of the last pipe, choose the kind, and it marks the end of the system and places the tag and note; the note prints APPROX. with one standing note until confirmed (D-177, D-248). The invert is held once on the job (INPUT_AUDIT section 3).
4. **What would break the budget:** (a) the connection invert not yet typed, which pushes 1 typed figure into this task; (b) the legal point sitting back at the boundary, which needs the tag slid along the pipe by its grip.
5. **How it is tested:** a robot count on a test copy, then a check that the end carries its tag, the note, and the APPROX. wording where the invert is assumed. Codex looks at the label.

### Task 12. Place a tank with its re-use figure

1. **Today:** old CDWT, none in the records; the tank was tagged and sized by hand or from the palette. Not measured. On the old jobs 2 of 4 tank jobs used a 2,000 litre re-use tank.
2. **Proposed budget:** target WT, 2 picks (the tank, the note), 2 clicks (the size, OK), 1 typed (the re-use litres). Limit: 2 picks, 4 clicks, 2 typed (the size typed too).
3. **Why that is achievable:** D-278: the tank size is picked, re-use is typed once from the STORM or sustainability report (D-024), and detention fills in as the tank less re-use. Tanks open with last used (D-263). The note and leader come with it (D-039).
4. **What would break the budget:** (a) a size that is not in the offered list (D-282 offers the office's own tank blocks, a draft call, not Tim's words); (b) a second box for detention that has to be typed as well; (c) several tanks on a job each needing their own re-use figure (Job 3 has four).
5. **How it is tested:** a robot count on a test copy, then a check that the note and the Detention window print the same litres. Codex looks at the Tank window.

### Task 13. Check detention on a finished job (open, read the answer, close)

1. **Today:** old CDTWL and CDCALC, none in the records; the check was a hand trial of the orifice and a calculation sheet (INPUT_AUDIT section 6, "hand calculations"). Not measured.
2. **Proposed budget:** target DET, 0 picks, 1 click (close), 0 typed. Limit: 0 picks, 2 clicks, 0 typed.
3. **Why that is achievable:** D-099 (one Detention window for the job); the answer is the one band at the top, "Suits", "Short" or "Needs a look", readable without scrolling (`STYLE_APPROVED_18NOV.md` section 1 item 3); the window reads the drawing, so step 1 shows "Nothing needs you" when the job is complete.
4. **What would break the budget:** (a) an unfinished job: with no site rainfall the answer reads "cannot work out yet" (D-218), so the task is not a read-and-close; (b) the answer sitting below the fold.
5. **How it is tested:** a robot count, plus a Codex look to confirm that the answer shows on first view with no scroll. Time on screen is not a budget.

### Task 14. Fix "storage short" by changing one thing

1. **Today:** not measured. By hand: change a figure, re-trial the orifice and re-read the sheet. On one old Glen Eira-type case the old storage figure came out 17% short while saying it was safe (R-008), so any "today" time would also include a wrong answer.
2. **Proposed budget:** target DET, 0 picks, 2 clicks (accept the suggested next tank size, OK), 0 typed. Limit: 0 picks, 3 clicks, 1 typed (the top water level typed instead).
3. **Why that is achievable:** D-278: "the Detention window says whether total storage is short or spare and, if short, suggests the next tank size up, the engineer decides." The band changes as the choice is made (rule 25) and the criteria box follows.
4. **What would break the budget:** (a) the short answer needing a drawn change (more pipe), which is not "one thing in the window"; (b) a pit that grows by itself changing the tank share (INPUT_AUDIT risk 7), which must be said in "What else changes" but should not add a click.
5. **How it is tested:** a robot count on a test copy of a deliberately short job, then a check that the band flips from "Short" to "Suits" and the figures add up as printed. Judgement on whether the suggested size is the right engineering answer stays with Tim (engineering call).

### Task 15. Place the pit schedule

1. **Today:** old PITSCHEDULE, 39 runs, median 22 s. It was a review, override and place in one step. On the old jobs the schedule is on 6 of 6 sheets.
2. **Proposed budget:** target SH, 1 pick (the top-left corner), 0 clicks, 0 typed. Limit: 1 pick, 1 click, 0 typed (if a window opens).
3. **Why that is achievable:** D-109 (Tim: "Placed once, then follows the pits"): type SH, pick where it goes, it draws in the office layout and updates itself. EASY section C7 proposes no window on placing, because there is nothing to choose; D-060 "every time" is then not applied to this one tool.
4. **What would break the budget:** (a) a window opening anyway (the limit); (b) a long schedule that does not fit its spot, which prints one line (D-114) and costs a second pick.
5. **How it is tested:** a robot count on a test copy, then a check that every pit has a row and that the schedule updates when a pit changes. Codex looks at the printed layout.

### Task 16. Set up a new job (Job window, first drawing)

1. **Today:** old CDDESIGN, none in the records; the setup was by hand. Not measured. The drawing starts from the office template (D-191).
2. **Proposed budget:** target one command (name not ruled; JOB is only a draft), 2 picks (the site outline, the paving hatch), 7 clicks (council, kind of development, discharge point at 2 clicks each, then OK), 3 typed (the permitted discharge, the top water level, the connection invert). Limit: 4 picks, 10 clicks, 5 typed. The rainfall table is outside this budget (section 4, item 4).
3. **Why that is achievable:** INPUT_AUDIT section 6 counts 20 typed figures for a whole two-unit job where the drawing is readable (down from 85), and 4 of them are on the job sheet: the council, the permitted discharge, the top water level and the connection invert. Areas are picked once and linked (D-107, D-108); cover levels are never taken from the survey (D-178).
4. **What would break the budget:** (a) the Job window holding all 13 facts in `INPUT_AUDIT.md` section 3 and needing a scroll or a tab change; (b) a council whose file has no sourced figure, forcing a typed one; (c) areas that cannot be read from the drawing (paving, roof), pushing the typed count to the limit.
5. **How it is tested:** a robot count on a test copy of a blank template, then Codex for the layout (no scroll, "N figures need you" showing honestly). This is the one task I expect to land at the limit first time.

### Task 17. Find and fix the one thing wrong on the Unfinished list

1. **Today:** old CDCHECK and the other check tools had no runs recorded; CDINSPECTOR had 42 runs. Not measured. The Unfinished list is a new idea: one list shown on request and as one quiet line when plotting (D-176, D-188).
2. **Proposed budget:** target one command (name not ruled), 0 picks, 2 clicks (jump to the item, OK), 1 typed (the missing figure). Limit: 1 pick (a double-click if the jump does not open the window), 3 clicks, 1 typed.
3. **Why that is achievable:** D-176 (unfinished is normal, quiet, one list), D-188 (plot with one quiet line, never a stop). Each line names the thing and what is missing, so the drafter does not hunt for it.
4. **What would break the budget:** (a) the jump-to only zooming, so the fix needs a double-click (the limit); (b) the missing figure being one the engineer must decide, such as a cover level (D-178), which is typed and may need thought; (c) the list showing more than one item.
5. **How it is tested:** a robot count with one deliberately missing figure on a test copy. Codex looks at the list. Whether the jump-to opens the window is not ruled; Tim may need to say.

### Task 18. Edit any object (double-click route)

1. **Today:** old PITEDIT 74, CDEDIT 67 and PIPEEDIT 66 runs: 207 edit runs against 200 placing runs (PIT 45 plus CD 155). No median. Not measured. The old route was a typed command, a pick, then a window.
2. **Proposed budget:** target no command, 1 pick (double-click), 2 clicks (change one choice, OK), 0 typed. Limit: 1 pick, 3 clicks, 1 typed.
3. **Why that is achievable:** D-061 (double-click opens the window it was placed with, or Properties), D-048; D-058 (placement by command, editing by Properties or a like window).
4. **What would break the budget:** whether the CE window wins over AutoCAD's own double-click on the same object has not been proved in a real mouse trial (FM-004, THE_PLAN section 6a item 3); and a held value asking for a decision click (rule 26).
5. **How it is tested:** a robot count, with a Codex mouse trial on a real double-click. This route is not yet proven, so it is the first budget to test.

### Task 19. Undo any of the above

1. **Today:** not measured. Undo and Cancel changing nothing is a repeated fault: about 25 of 597 recurring faults (R-007, in `EASY_AND_AUTOCAD_LIKE.md` section 10).
2. **Proposed budget:** target U, once, 0 picks, 0 clicks, 0 typed: one U puts the whole task back. Limit: one U per step only where a ruling says steps (section 4, item 1).
3. **Why that is achievable:** OC-07 and `EASY_AND_AUTOCAD_LIKE.md` section C ("one U removes the whole command"); D-221 and D-256 both say one undo brings everything back; Esc and Cancel change nothing (OC-08); rule 21 (undo instead of "Are you sure?").
4. **What would break the budget:** a command that makes several undo steps (a window that writes twice), or a schedule row, label or tag left behind after U.
5. **How it is tested:** a robot count for every task above: run it, send one U, and compare the drawing before and after (object count, tags, cover text, schedule rows, joins). Any difference fails that task's undo.

---

## 4. Budgets I could not ground in evidence

1. **Undo and a run of pipes.** D-237 says "one undo steps back one pipe"; rule 18 and OC-07 say one undo per command. Both cannot be exact for task 5. My reading: while CD is running, U steps back one pipe (as PLINE does), and after Enter one U takes back the whole run. If Tim means one undo per pipe even after the run, the limit for task 5 and task 19 becomes five. His call.
2. **Seconds.** No record anywhere gives the time of a click, a window or a pick (EASY section G item 1: "Time per window: not in any record"). So I have proposed no time budget, only counts. The "today" seconds are old plug-in medians (PIT 29 s, CD 21 s, PITSCHEDULE 22 s) and are not comparable one to one, because the old tool did one object per run.
3. **The Pit window figure.** The build chat's "1 pick + 4 clicks + 1 typed field" did not say which clicks or which field. I used it as the limit for task 2; the targets for tasks 1 and 3 are mine and not yet shown on a real window.
4. **The Job window (task 16).** The command name is not ruled (JOB is a draft, FM-048); how the site's rainfall table arrives is open (INPUT_AUDIT question 5, FP-007); how the top water level is first chosen was not answered (D-175). The budget excludes rainfall and assumes the top water level is typed once.
5. **The Unfinished list (task 17).** The command name is not ruled (CHECK or CK is a draft, FM-041), and no ruling says whether a jump-to opens the item's window or only zooms.
6. **Pit grip (task 9).** Nothing says whether the grip steps through the office pit sizes or stretches freely. D-155 records a custom grip failing once.
7. **Moving and resizing, grade, hold (tasks 6 to 9).** No old record separates how often each happens or how long it takes; counts rest on the rulings only.
8. **Tank (task 12).** Where the re-use figure sits is settled by D-278, but D-278 is "his to overturn", and the tank sizes offered (D-282) are the planning chat's call, not Tim's words.
9. **Detention and storage short (tasks 13 and 14).** No old time exists. The "next size up" suggestion is D-278, also "his to overturn".
10. **Double-click (task 18).** Not proven in a real mouse trial (FM-004).

---

## 5. The five tasks done most often on a job

Counts come from two places: the three made-up jobs in `design\FUNCTION_PLAN.md` section 2 (they give steps and some counts, not pipe counts), and the six old jobs in `design\EASY_AND_AUTOCAD_LIKE.md` (pits median 8 per job, range 5 to 15; downpipes median about 10, range 5 to 28; pipe pieces median about 30, range 19 to 89). Where a count is my arithmetic it says so.

1. **Edit any object (task 18, with tasks 6, 7 and 9).** The old records show 207 edit runs against 200 placing runs, so edits were as common as placements. On a median job (about 8 pits and about 30 pipe pieces) that is roughly 30 to 40 edits: my arithmetic, low confidence. No walked job counts them. **Proposed budget:** no command, 1 pick, 2 clicks, 0 typed (limit 1 pick, 3 clicks, 1 typed).
2. **Draw a pipe from pit to pit (tasks 4 and 5).** About 30 pipe pieces per median job, 67% repeating the one before, 18% of gravity pieces bending. The three walked jobs give no pipe counts. **Proposed budget:** one pipe CD, 2 picks, 2 clicks, 0 typed; a five-pipe run CD, 7 picks, 2 clicks, 0 typed.
3. **Place downpipes (task 10).** The walked jobs have 8 (Job 1) and 16 (Job 3) downpipes, Job 2 not stated; the old median is about 10 per job. Placed in one command per group, so usually 2 to 3 commands a job. **Proposed budget:** DP, 6 picks, 2 clicks, 0 typed.
4. **Place a pit like the last one (task 1).** The old median is 8 pits per job and 54% repeat the one before, so about 4 per job. The walked jobs give 3 pits (Job 1), at least 3 (Job 2) and about 20 (Job 3, from "20-odd" schedule rows). **Proposed budget:** PIT, 1 pick, 2 clicks, 0 typed.
5. **Place a pit that differs in one thing (task 2).** The same median of 8 pits and 46% differing gives about 4 per job. (Tanks come next: 1, 2 and 4 on the three walked jobs, 7 in all, so about 2 per job.) **Proposed budget:** PIT, 1 pick, 3 clicks, 0 typed (limit 4 clicks, 1 typed).

**Not countable, but probably the most used of all:** undo (task 19). Nothing records it. Once per job in the walked jobs for sure: Job 2 puts back an erased P3 with one undo (D-221).

**Done once or a few times a job:** the pit schedule (once on each walked job), the Job window (once), the LPD (once on each walked job), the Unfinished list (once on each walked job, before issue), and the detention check (Jobs 2 and 3 only, and again after any change).

---

## 6. What I read

1. `C:\CE_PLAN\zero\design\SCREEN_RULES_18NOV.md` (rules 18 to 21), `STYLE_APPROVED_18NOV.md`, `EASY_AND_AUTOCAD_LIKE.md`, `INPUT_AUDIT.md`, `FUNCTION_MAP.md` section 6 (Civil drainage), `FUNCTION_PLAN.md` section 2 (three walked jobs).
2. `C:\CE_PLAN\zero\DECISIONS.md`: D-024, D-034, D-058, D-060, D-061, D-077, D-080, D-081, D-099, D-100, D-102, D-105, D-109, D-172, D-173, D-175, D-176, D-179, D-181, D-185, D-186, D-188, D-189, D-190, D-191, D-221, D-234, D-235, D-237, D-256, D-262, D-263, D-266, D-270, D-274, D-278, D-279, D-282.
3. `C:\TimOS\RULES.md`, for tone and format (numbered lists with bold labels, no tables).
4. **Not looked at:** any drawing, any programme, AutoCAD, the live Pit window, and the mock-up pictures. Every number above is a proposal, not a measurement.
