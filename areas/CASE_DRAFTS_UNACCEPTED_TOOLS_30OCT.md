# Case drafts for the everyday tools not yet accepted, and for tools proved by one route only (Fri 30 Oct 2026)

Written Fri 30 Oct 2026, about 11:45 to 12:25 Melbourne (PC clock read with `date` at 12:02), by a read-only case-drafting job. Nothing was run in AutoCAD, nothing was built, no case file, runner, allow-list, ledger, carpark or desk log was edited. This is the only file written. Every case below is a DRAFT, NOT RUN, NOT REVIEWED.

Sources read: `C:\TimOS\RULES.md`; `areas\TIM_ACCEPTED_TOOLS_30OCT.md`; `areas\CLAUDE_ACCEPTED_TOOLS_30OCT.md`; `areas\RETEST_SMOKE_SETS.md`; `areas\EVERYDAY_TOOLS_STATUS_29OCT.md`; `areas\RELEASE_SCOREBOARD.md` section 4; `areas\RELEASE_9NOV_GAP_PLAN_2026-10-22.md` item 7; `areas\ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md` items 11, 20, 28 and H1 to H57; `areas\DAILY_TOOLS_TEST_CASES_2026-10-23.md` cards D05 to D30; `areas\GAP_CASES_DRAFT_30OCT.md`; `decisions\2026-10-29_TIM_ANSWERS.md` items 76, 77, 89; `BUG_CARPARK.md` BUG-861, 1236, 1238, 1239, 1242, 1252; `areas\TRAIN_C77_PR_LIST_2026-10-29.md`; the runner's `cases\README_CASES.md`, `_setups\SETUP-P8`, cases N03, N04, N11, N21, N30, N31, R08, R11, R12, R18, R25, R35, R40; both driver allow-lists (read only); runner report `RUN-20261030-0107-C3.0.86-b80F1.md` (N03's recorded FO insert); Codex reports G4 (07:27) and G5 (07:39) of 30 Oct.

---

## ANSWER FIRST

### FOR TIM

1. **12 of the 40 lines now have a drafted case or a drafted Codex look that can move them; 6 of those are among the 11 not accepted.** The other 5 of the 11 cannot be moved by any test: they need a counting ruling or a build.
2. **A counting slip worth one tool, found while reading (RULES 6.2).** You passed quick MOVE of a pit by hand on Thu 29 Oct at about 12:00 ("passed", ledger H10). Your accepted list files it as "NOT among the 40". The plan's own list of 40 (gap plan item 7) and CE 00's count ruling (ledger item 28) both name quick MOVE as one of the 40. If CE 00 agrees, the headline is **30 of 40**, not 29. Codex later found one invert text sitting on its pipe after the move (look G5, 07:39 today); like D10, that is a new fault, not a withdrawal of your pass.
3. **The 40 can never reach 40 as counted today.** Two lines were never named, and CE 00 ruled the PIT and CD lines are the same checks as D01, so they are never counted. That makes 36 the ceiling. CE 00 should either name four real tools for those lines or say the target is "of 36".
4. **The 11 not accepted, in plain words:**
   1. **D05 recent buttons:** the fix is in tonight's build (C-77). Robot case N45 drafted to check the buttons on the first page.
   2. **D08 FO symbol:** you ruled FO must read FO. Needs that build first. Today the symbol's text sits inside the block where the robot cannot read it, so a Codex look is the quickest proof.
   3. **D13 hand-placed label:** waits on your Monday question 19. Both answers have a drafted case.
   4. **D22 long Pit Schedule:** you ruled "one table". Needs that build. Robot case N47 drafted for after it.
   5. **D25 existing and demolished layers:** not built. No case can help.
   6. **Edit Pipe cascade with U and REDO:** robot case N48 drafted. It reopens Edit Pipe after U and after REDO and reads the stored levels, the part never checked.
   7. **Quick MOVE:** see item 2 above. A Codex re-look after a fix is drafted.
   8. **PIT line, CD line, two unnamed lines:** counting rulings only.
5. **Nothing here needs you in AutoCAD.** Your Monday question 19 (D13) is the only answer that unblocks a tool.

---

## How the 11 were found

1. **The 40 (gap plan item 7):** the 30 daily cards D01 to D30, plus PIT, CD, Edit Pipe cascade with U and REDO, quick MOVE, CDSYNC keeps the schedule, CDTWL freeboard, Recover Inverts, Tidy labels. That is 38 named lines; two were never named (CE 02, 29 Oct).
2. **Accepted, 29 (Rule 16 union, scoreboard section 4):** Tim's 25 (D01, D02, D03, D04, D06, D07, D09, D10, D11, D12, D14, D15, D16, D17, D18, D20, D21, D23, D24, D26, D27, D28, D29, D30, Recover Inverts) plus robot-only 4 (D19, CDSYNC keeps the schedule C42, Tidy labels C37, CDTWL C39).
3. **Not accepted, 11:** D05, D08 (disputed), D13, D22, D25, Edit Pipe cascade, quick MOVE, the PIT line, the CD line, and the two unnamed lines.
4. **Single route, 14:** Tim only 10 (D06, D07, D10, D21, D23, D24, D26, D28, D29, D30); robot only 4 (D19, C42, C37, C39). Both routes: 15.

---

## PART A. The 11 not accepted

### A1. D05: recent diameters, materials and inverts as one-click buttons

1. **What the card claims:** New Pipe and Edit Pipe show "Recent:" buttons for diameter, material and invert; one click fills the box and the drawn label follows.
2. **Why not accepted:** Tim said "no" (H16, BUG-1238): he does not see them. The diameter and material buttons sit on the Pipe tab, which the robot cannot open, and pressing "Use recent ..." is on neither press list. The fix B-006 (#1839, switch `pipe.recentInvertButtonsOnMainPage`, ON by default) puts the recent INVERT buttons on the first page and is in the C-77 train (TRAIN_C77_PR_LIST item 7), not installed yet.
3. **Existing case:** N30 (`drafts_opus_28oct_b3`), part only: reads the recent invert buttons after a placed pipe, newest first. Never run.
4. **New robot case N45 (after C-77 is installed), the smallest whole check of what #1839 changes:**

```
CASE N45
TITLE With the recent-invert switch ON, the first page of New Pipe shows 'Use recent invert' buttons for the last two levels, newest first, and pressing the newest fills the first invert box
PLAN_ITEM UX-PIPE-04 (daily card D05), the recent-invert part on the main page (BUG-1226 / BUG-1238, fix B-006 #1839)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pipe.recentInvertButtonsOnMainPage true
ORDER 320
TIMEOUT 900
BUG BUG-1238
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED As N30 steps 1 to 7 (pipe 150000,-90000 to 160000,-90000, inverts 18.240 / 18.190, Start Pipe, one Esc). The second CD (150000,-92000 to 160000,-92000) opens New Pipe; its dump, taken before any tab is touched, holds 'Use recent invert 18.190 m AHD' before 'Use recent invert 18.240 m AHD'. Cancel without saving closes it.
WHY_NOT_UNIT_TEST The buttons are built in the installed window from the list the real Start Pipe just wrote.
NOT_AUTOMATED Pressing a recent button (not on the press list) and the diameter and material buttons (Pipe tab): Codex look D05-L below.
STEPS
  (N30's STEPS unchanged)
ASSERT
  (N30's ASSERT unchanged)
  record $np2 "FULL first-page dump, to pin the tab the buttons sit on"
```

5. **Failing twin:** N45_BROKEN = the same case with `SETTING CD_Settings.json pipe.recentInvertButtonsOnMainPage false`. Expected red on the two order checks if the buttons leave the first page when the switch is off (DERIVED from the switch name; read #1839's diff to confirm the OFF behaviour before trusting the twin).
6. **Codex look D05-L (the half the robot cannot do), re-use the G-brief template `C:\Lisp Files\_CODEX_RUNNER\verifyG3_c84_full.txt`:**
   1. On a DRV1_B1 copy: CD 150000,-90000 to 160000,-90000; in New Pipe set 225, STORMPRO, inverts 18.240 / 18.190; Start Pipe; Esc.
   2. CD again at 150000,-92000 to 160000,-92000. Screenshot the first page. Report every "Use recent ..." button seen and where.
   3. Click "Use recent invert 18.190 m AHD"; screenshot; read the first invert box.
   4. Open the Pipe tab; click the recent diameter 225 and material STORMPRO; screenshot; read both boxes; Start Pipe; Esc; read the new label text ("225 DIA. STORMPRO PIPE ...").
   5. PASS = buttons visible without hunting, each click fills its box, label follows. Also report the window height at 150 percent scaling (#1839 was first too tall).
7. **Counts when:** N45 two clean starts plus review plus twin red, and D05-L PASS. Tim may still say the buttons are hard to find (his BUG-1238 was "I don't see them").

### A2. D08: OF and FO, one symbol with their own tags (disputed)

1. **What the card claims:** OF and FO insert the same overflow symbol; the tag (OF1, FO1) and the plan label (OF, FO) tell them apart.
2. **Why not accepted:** robot N03 passed (Claude-accepted), but Tim saw the FO symbol reads "OF" (H12, BUG-1236). Tim then ruled (decisions item 76): "fo should insert with FO as the label"; every source block has a visible, editable label plus a tag; numbers stay in the tag only (item 77). So the card changes and needs a build. No build item number found in the C-77 list (UNKNOWN whether one exists).
3. **What the robot can see today (fact from the 3.0.86 run b80F1, N03 check 14):** the FO insert is block `OVERFLOW` with NO attributes. The "OF" text is an MText inside the block definition (part 2, layer 25TEXT), and `ent-read` returns that part's layer but not its words. So no case can read "OF" or "FO" on the symbol today. N03 passes because it never looks there (the carpark entry says so).
4. **New robot case N46 (after the FO-label build), smallest check:**

```
CASE N46
TITLE FO places a symbol whose own visible label reads FO, OF places one reading OF, and neither label carries a number
PLAN_ITEM UX-SRC-01 (daily card D08, as changed by Tim's ruling 29 Oct item 76)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 31
TIMEOUT 600
BUG BUG-1236
EXPECT-FAIL BUG-1236
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED OF at 150000,-80000, Esc; FO at 152000,-80000, Esc (N03's route). The FO insert's visible label reads exactly FO; the OF insert's reads exactly OF; neither reads OF1 or FO1; the tags (command line) are still OF<n> and FO<n>.
WHY_NOT_UNIT_TEST The symbol's label is written into the live drawing by the live command.
NOT_AUTOMATED Double-click editing of label and tag (item 76's one window) is a separate case once built.
STEPS
  (N03 STEPS unchanged, then:)
  ent-parts {$h_fo} -> $parts_fo
  ent-parts {$h_of} -> $parts_of
ASSERT
  history has "Front overflow placed. Tag: FO"
  matches $parts_fo "text.:.FO.(,|\})"
  not-contains $parts_fo "OF"
  matches $parts_of "text.:.OF.(,|\})"
  not-contains $parts_fo "FO1"
```

5. **Two things it needs first:** (a) the FO-label build; (b) the read step `ent-parts <handle> -> $list` with each part's text, the SAME new verb GAP_CASES_DRAFT_30OCT.md asked for N44b. If the build instead puts the label in an attribute, plain `ent-read` is enough and `ent-parts` is not needed: read the build's diff first. Until then the case runs as EXPECT-FAIL BUG-1236 (expected red today on the `text FO` check, or BLOCKED on the missing verb).
6. **Failing twin:** N46_BROKEN reverses the FO check (expects OF); it must fail after the build and pass today.
7. **Codex look D08-L (quicker, works today as "fault still present", and as the proof after the build):** blank copy F-BLANK, Y to the tag question; OF at 150000,-80000, Esc; FO at 152000,-80000, Esc; ZOOM W 149500,-80500 152500,-79500; screenshot; report the words inside each black box and the green plan labels. PASS (after build) = FO box reads FO, OF box reads OF, plan labels OF and FO without numbers.
8. **Ruling needed:** CE 00 should mark N03 as "agrees with the OLD card" so it is not counted for D08 again after the card changes.

### A3. D13: a pipe label moved by hand stays put

1. **What the card claims:** after you MOVE a pipe label by hand, later CE tidying leaves it where you put it (switch `linking.handPlacedLabelsStay`, OFF in Tim's file).
2. **Why not accepted:** Codex G7 FAIL today (06:27, BUG-1252): with the switch ON, the label moved 250 mm when its pit moved 500 mm (half, which fits neither design) and Tidy labels counted "placed by hand: 0". N31 (draft) is judged WEAK by cx_cr25. Tim's Monday question 19 decides the rule: (a) label rides with its pipe end, or (b) label stays exactly put.
3. **Draft for answer (a), ride along (recommended in BUG-1252):** strengthen N31 to the card's real distances. Change three lines of N31: hand move `0,0{NL}0,1000`, pit move `0,0{NL}500,0`, and the checks become `number $pm_moved = 500 +- 5` (moved the full pit distance, never half) and `history has "Placed by hand (left alone) 1"`. Twin: N31_BROKEN as drafted (hand-placed protection OFF).
4. **Draft for answer (b), stays put:** same three distance changes; the check becomes `number $pm_moved = 0 +- 1`. Twin unchanged.
5. **Today either version is EXPECT-FAIL BUG-1252** (G7 saw 250 of 500 and a zero count).
6. **Codex look:** re-run G7 unchanged (`verifyG7_c84_full.txt`, update N14 to the installed build) after the fix; it is the picture half.
7. **Counts when:** Tim answers, the fix is installed, N31 (revised) two clean starts plus review plus twin red, and G7 PASS.

### A4. D22: a long Pit Schedule placed in the drawing

1. **What the card claims (old):** the placed schedule splits into repeated-header parts at the row limit.
2. **Why not accepted:** Tim ruled "one table" (decisions item 89, H42: "i dont see why it cant just keep making rows ... everythign else passes"). The card must change and the change must be built. No build item found in the C-77 list (UNKNOWN).
3. **Route fact:** driver v2 allows "Continue to Place / update" and "Update existing schedule" on the Pit Schedule window (allow-list, deny exceptions). So the robot can place and update a drawn schedule; nobody has tried (Codex D6-03 was blocked on a disabled button, Tim got it to work by hand).
4. **New robot case N47 (after the one-table build):**

```
CASE N47
TITLE The placed Pit Schedule is one table: all rows in one part, and after a new pit and Update it is still one part with one more row
PLAN_ITEM UX-SCHED-04 (daily card D22, as changed by Tim's ruling 29 Oct item 89)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 340
TIMEOUT 1500
REVIEWED_AGAINST
EXPECTED PITSCHEDULE, Continue to Place / update, insertion point 200000,-50000: exactly one new drawn schedule object (TABLE, or one block) holding every pit row the window lists (27 on DRV1_B1, R25). SETUP-P8 then adds P8; PITSCHEDULE, Update existing schedule: still one schedule object, now one more row, no second part below. One U removes the update.
WHY_NOT_UNIT_TEST The drawn table is built by live placement in the real drawing.
NOT_AUTOMATED The look (readable, nothing overlaps): a Codex look. The optional row-limit split (kept as a setting) is not driven.
STEPS
  ms-count -> $n0
  type "PITSCHEDULE" -Force -ExpectWindow "Pit Schedule" -TimeoutSec 120 -> $ps1
  ui-dump "Pit Schedule" -> $psd1
  ui2-press "Pit Schedule" "Continue to Place / update" -Secs 120
  type "200000,-50000" -Force -> $place
  wait
  ms-new $n0 -> $sched1
  (SETUP-P8 steps inline, then:)
  type "PITSCHEDULE" -Force -ExpectWindow "Pit Schedule" -TimeoutSec 120 -> $ps2
  ui2-press "Pit Schedule" "Update existing schedule" -Secs 120
  wait
  ms-new $n0 -> $sched2
ASSERT
  record $place "FULL what placement printed (the prompt words are DERIVED)"
  matches $psd1 "Will be placed: 27 rows"
  count $sched1 = 1
  record $sched1 "the drawn schedule object, type and size"
```

5. **DERIVED, must be pinned by one probe start first:** the placement prompt words, what the drawn schedule is made of (one TABLE or many texts), and how a row count can be read from it. If it is many texts, the check becomes "every PIT No. text has the same X and a falling Y, no second header row".
6. **Failing twin:** `SETTING CD_Settings.json pit.scheduleRowsPerSheet 5` (the old split): must give more than one part.
7. **Counts when:** build installed, probe pins the DERIVED items, two clean starts, review, twin red, and a Codex look of the placed table.

### A5. D25: existing work greyed, demolished dashed (NOT BUILT)

1. **What the card claims:** existing pits and pipes greyed on EX layers; demolished ones dashed on a DEMO layer with "TO BE REMOVED".
2. **Why not accepted:** not built. No window sets a pit's status; no DEMO layer exists in the code (card D25).
3. **No case drafted.** A case on the installed part (an "Existing Pipe" lands on EX DRAIN HATCH) can never make the card PASS, so it would spend robot time for nothing. **Needed instead:** CE 00's decision whether D25 stays in the 9 Nov scope.

### A6. Edit Pipe cascade with U and REDO (named check)

1. **What the check claims:** Edit Pipe with new levels updates the pipes and pits downstream, one U takes it all back, REDO puts it back.
2. **Why not accepted:** R11 (text sequence, U echo, REDO "Everything has been redone") and N11 (Pit Schedule rows after U and REDO) both pass, but are judged PART: the levels CE STORES on the pipe are never read. The REDO fault R08 (BUG-861) is a different route (REDO lost after the first mouse click in a fresh drawing with the Inspector open); it is not inside the cascade. **Ruling needed:** CE 00 to say BUG-861 is outside this named check, otherwise it cannot count until BUG-861 is fixed.
3. **New robot cases N48 and N48u: read the stored levels by reopening Edit Pipe (the window shows what is stored).** Opening CDEDIT is a command, so it ends the REDO chain: the read must come AFTER the REDO (N48) or in its own start after the U (N48u).

```
CASE N48
TITLE After an Edit Pipe cascade from P3, U and REDO, reopening Edit Pipe on P3 shows the stored levels 17.60 and 17.50
PLAN_ITEM Named check "Edit Pipe cascade with U and REDO" (gap plan item 7), the stored-level half
KIND deterministic
FIXTURE DRV1_B1
SETUP SETUP-R47
ORDER 350
TIMEOUT 1500
REVIEWED_AGAINST
EXPECTED R11's steps through REDO ('Everything has been redone'). Then pick-first 10A98D, CDEDIT, Y: Edit Pipe opens and its first and second invert boxes read 17.60 and 17.50 (the stored values). Cancel without saving closes it and nothing changes.
WHY_NOT_UNIT_TEST The stored record after a live U and REDO is only visible through the real window on the real drawing.
NOT_AUTOMATED Downstream pipes' stored levels: N11 reads the pit levels in the Pit Schedule.
STEPS
  (R11 STEPS unchanged, then:)
  pick-first "10A98D"
  type "CDEDIT{NL}Y" -Force -ExpectWindow "Edit Pipe" -TimeoutSec 120 -> $re_t
  ui-dump "Edit Pipe" -> $ep_r
  ui-press "Edit Pipe" "Cancel without saving" -> $re_c
  await-window-gone "^Edit Pipe" -Secs 120
ASSERT
  (R11 ASSERT unchanged)
  history has "Everything has been redone"
  control $ep_r "C2.FirstInvert" value "17.60"
  control $ep_r "C2.SecondInvert" value "17.50"
```

4. **N48u:** R11 steps up to and including the U, then the same reopen; the checks become the pre-edit values. **DERIVED:** pipe P3's stored levels before the edit are not written anywhere I read. Add `ui-dump "Edit Pipe" -> $ep0` right after R11's first CDEDIT opens (before the `ui2-set` lines) and run one probe start to pin them; then write them as `control $ep_u "C2.FirstInvert" value "<pinned>"`. Also DERIVED: whether the box shows "17.60" or "17.600" (use `control-text $ep_r has "17.6"` if the probe shows a third decimal).
5. **Failing twin:** N48_BROKEN expects the pre-edit values after REDO (reversed read-back); must fail.
6. **Counts when:** both cases two clean starts, review, twin red, plus CE 00's BUG-861 ruling.

### A7. Quick MOVE of a pit (named check, card C41)

1. **What the check claims:** MOVE a pit; no CE window opens; its number, cover text and invert texts come with it; one U puts everything back.
2. **Why not counted (a counting slip):** Tim passed it by hand (H10, "passed", 29 Oct about 12:00). His accepted list files it under "NOT among the 40"; the gap plan item 7 and ledger item 28 list it among the 40. **CE 00 ruling needed; if agreed, the headline is 30 of 40.**
3. **New fault after his pass:** Codex G5 FAIL, SURE (07:39 today): after moving P3 2 m, the upper-left IL text (116BE4, IL 18.24) now sits on its pipe strip. **I found no carpark entry for it** (searched "G5" and BUG-1250 to 1252): CE 05 should log it. Likely the BUG-1234 family (IL and arrow clash); not checked.
4. **Robot route:** R12 is Claude-accepted for the part named (labels go with the pit, four IL texts return after U). Missing: a clash check. Add to R12 as a NOT_AUTOMATED line, because the runner reads insertion points, not text extents; a clash is a picture item.
5. **Codex look G5b (after the overlap fix):** `verifyG5_c84_full.txt` unchanged except N14 (installed build). PASS = no new text-on-pipe or text-on-text overlap at M2 and M3.

### A8 to A11. PIT line, CD line, two unnamed lines

1. **PIT and CD:** CE 00 ruled they are the same checks as D01 (and D12) and are not counted twice. Both are passed by both routes through D01 (R01, H1, H2). **No case can move them.** Recommend CE 00 either counts them (they are passed) or replaces them with two real tools.
2. **Two unnamed lines:** the plan never named them. **No case can be drafted.** Recommend CE 00 names two tools (candidates from Tim's own passes outside the 40: Move + Rotate and Copy + Rotate on an ordinary object; CDSURVEY with Survey Review) or rescales to "of 36".

---

## PART B. Tools accepted by ONE route that gain from the other

### B1. Robot only (4): what Tim's hand or a Codex look would add

1. **D19, every CE step undoes under its own name.** Tim passed the PIT half (H7); the MOVE half was by grip, then H10 MOVE "passed" without the echo pasted. The CD [Undo] sentence half needs `options.autoCadStyleCdPrompts` and `options.cdCommandLine.sayWhatWasUndone` ON (robot N18 covers it). **Codex look D19-L (no picture judged, only the command line):** on a DRV1_B1 copy, PIT at 150000,-80000 (cover 19.000), Esc three times, type U, copy the echo; pick pit 109D56, MOVE 0,0 to 0,2000, U, copy the echo. PASS = echoes "PIT" (or the CD continuation name) and "MOVE". Small cost; adds an independent route to a robot-only tool.
2. **CDSYNC keeps the schedule (C42).** Already robot N26 plus Codex D4-01 PASS (keeps the schedule values). **Nothing to add.**
3. **Tidy labels names the pipe (C37).** Robot R16, switch ON only; Tim's file is OFF and he said yes to ON by default (answers item 8). **Codex look C37-L:** with `linking.tidyLabelsEnabled` true through the guard, R16's route (SETUP-R47, spot level 10EC5D moved onto IL 18.000), then CDTIDYLABELS All; screenshot the command line and the preview. PASS = each line names the pipe ("P8 -> Open end" or similar), never a handle. Answer No at "Move this label now?".
4. **CDTWL freeboard (C39).** Robot R14 and R14h x3. No picture involved. **The value is engineering (150 and 200 mm freeboard)**, so RULES 4.5 says the setting values need Tim's word, not a test; the behaviour (warns at the set value) is proved. **No case drafted;** CE 00 to confirm the values are Tim's (Settings-first rule R-00).

### B2. Tim only (10): what a robot case would add

1. **D06, hide the grade in the pipe text.** Case N35 and its twin are drafted (`drafts_opus_29oct_b5`). Blocked on the reviewed allow-list change to press "More..." (Opus said GO TO APPLY). **Smallest steps:** apply that change after 5:30 pm, run N35 twice, review file. Watch for Tim's approved design change (the tickbox moving off "More...", H20): if it lands first, N35's route changes.
2. **D07, downpipe and raingarden before any pipe.** N04 passes on 3.0.86 for the part named. Missing: the RG label, which B-007 (#1845, in C-77) adds. **New case N49 = N04 plus, after CDRG:** `select $new "text~^RG$" "near=162000,-78500,3000" -> $rg` then `count $rg = 1` and `not-contains $new_texts "RG1"` (Tim item 77: number in the tag only). **Twin:** #1845's switch OFF (name DERIVED: read #1845's diff). **DERIVED:** whether the label is a text object or part of the raingarden block.
3. **D10, pipe label mid-pipe and reading left to right.** R18 checks the words and the distance to the middle. Two gaps: (a) R18's note says rotation cannot be read, but `ent-read` DOES return `rotation` (seen in the b80F1 record of N03); (b) BUG-1239 (the 450 offset) was found after Tim's yes. **New case N50 = R18 plus:** `field $label handle -> $lh`, `ent-read {$lh} -> $le`, `matches $le "rotation.:0(\.0+)?[,}]"` on the horizontal pipe, and a second pipe drawn right to left (CD 190000,-80000 to 170000,-80000) whose label must also read rotation 0, never 180. Record the label's distance from the pipe line (y minus -80000) WITHOUT judging: the right gap is Tim's call (BUG-1239, a Settings value not yet agreed). **Twin:** none safe until the gap value exists; the right-to-left pipe at rotation 180 is the natural red if the "keep readable" code is broken.
4. **D21, Pit Schedule natural order.** N29 (part) and N33 passed twice on 3.0.86 with a red twin; the independent review is running (`OPUS_CASE_REVIEW_C76_PROOFS_30OCT.md`). **Smallest step:** finish that review; N29 plus N33 then cover the card as Tim's file runs it (switch OFF). N40 (switch ON) is only needed if the switch is turned on for colleagues.
5. **D23, Excel export with a Checking sheet.** Tim H26 PASS and Codex D5-03 PASS: already two independent routes. A robot case would need "Export Excel" taken off both deny lists and a new file-reading verb. **Not drafted; not worth it.**
6. **D24, office layers, current layer never changes.** N28 (part) passed; N32 had one BLOCKED start and one PASS on 3.0.86. **Smallest step:** one more clean start of N32, then the review (running). N43 (existing colours never changed) is EXPECT-FAIL: not built. N44 (three more pipe types) is drafted, not needed for the count.
7. **D26, CDSL survey level then proposed level.** R35 covers the typed-level half. The survey half needs a drawing holding a stored CDSURVEY survey, made from non-client data. **Smallest step:** a fixture job builds `C:\ce_rc_drv\DRV1_SURV.dwg` from DRV1_B1 with a made-up point file (one point at 150000,-80000, level 18.250), then case N51: `type "CDSL{NL}150000,-80000" -Force -> $sl`, `history has "Existing level from the survey here: 18.250 m"`, the prompt has no `<`, then `type "18.600"` and `history has "Spot level placed. Level: P18.600"`. **DERIVED:** whether CDSURVEY can be driven from a typed file path (R26 drives only its refusal); UNKNOWN who builds the fixture.
8. **D28, CDCHECKDWG one summary line and results window.** R40 checks the four CE lines and one summary. **New fault after Tim's pass:** Codex G4-01 FAIL, SURE (07:27 today): the bottom row of the results list is cut off and one wheel turn does not scroll it. No carpark entry found for it: CE 05 should log it. **Smallest steps:** R40's review file (part: command line and file only), the clipping fix, then a G4 re-look.
9. **D29, CDFEEDBACK prints one honest line.** Tim accepted the Cancel half from his own use; robot N21 (Cancel) passed twice on 3.0.86. **Smallest step:** an N21 review file naming "D29 Cancel half" (the robot route then matches Tim's route). The Send half still needs the spare Windows login and Tim's yes.
10. **D30, own ribbon tab on selection.** No robot route reads the active ribbon tab. **Codex look D30-L:** on a DRV1_B1 copy, screenshot the ribbon; click pipe P3 (10A98D) with the mouse; wait 2 s; screenshot; Esc; screenshot; click pit P3 (109D56); screenshot. PASS = "Pipe" tab with Edit Pipe, Adjust Positions, Reverse Flow, Focus, Close; then "Pit" tab; Esc returns to the CE tab (Codex D8-04 saw Plug-ins instead: say which tab it returns to, and whether the brief's "CE Tools" name is right).

### B3. Halves of both-route tools (no count change, noted only)

1. **D04:** the "Enter gives the straight pipe" half is in neither route.
2. **D20:** the No path (Tim did not report it; robot N08 covers No) and Tim's word on the numbering order.
3. **D27:** U after CDREBUILD (Tim did not type it; robot N01 covers the U echo).
4. **D02:** the exact 100 mm line is not tried by either route (90 and 110 mm only).

---

## Count of drafted cases and looks

1. **Part A (11 not accepted): 6 drafted** (D05 N45 plus D05-L; D08 N46 plus D08-L; D13 N31 revised both ways plus G7 re-run; D22 N47; Edit Pipe cascade N48 and N48u; quick MOVE G5b plus a counting ruling). 5 cannot be drafted: D25 (not built), PIT, CD, two unnamed lines (rulings).
2. **Part B (14 single route): 6 new drafts** (D19-L, C37-L, D07 N49, D10 N50, D26 N51, D30-L), plus 5 where an existing case only needs a run or a review (D06 N35, D21 N33 review, D24 N32, D28 R40 review, D29 N21 review). C42, D23 and C39 need nothing more from a test.
3. **Total: 12 tools with a new drafted case or look.**

---

## What I did NOT verify (RULES 5.9)

1. **Nothing was run.** Every DERIVED item above (placement prompt words for N47, the drawn schedule's object type, pipe P3's pre-edit stored levels, #1839's and #1845's OFF behaviour, the RG label's object type, the CDSURVEY typed route) is unseen.
2. **The `ent-parts` verb N46 relies on does not exist yet** (same request as N44b).
3. **No case file was written to the runner folders and no case was offline-validated.** The case text here is a draft for the case owner to turn into files; `case_runner.ps1 validate` must be run on each file.
4. **I did not read the C-77 finalizer report** (not landed at the time of the scoreboard I read), so "in C-77" means "in the promoted PR list", not "installed".
5. **The two new faults (G4-01 list clipping, G5-01 invert text on pipe) have no carpark entries that I could find;** I did not write them (read-only job).
6. **The quick MOVE counting slip** rests on gap plan item 7, ledger item 28 and ledger H10; CE 00 makes the count.

## Summary

Twelve of the 40 lines now have a drafted robot case or Codex look. Of the 11 not accepted, six can be moved by tests once their builds or Tim's Monday answer arrive (D05, D08, D13, D22, Edit Pipe cascade, quick MOVE). Five cannot: D25 is not built, and the PIT, CD and two unnamed lines need counting rulings, so 36 is the ceiling as counted today. Quick MOVE was passed by Tim and should count: the headline may be 30, not 29. Two new faults found by Codex this morning (D28 list clipping, quick MOVE text on pipe) still need carpark entries.
