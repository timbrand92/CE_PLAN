# Cases for TRUST-S1: the Structural tab cut down to the core, roof down

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Written from card `04_REFERENCE\ux-plan\cards\TRUST-S1_STRUCTURAL_CORE_TAB_CARD_DRAFT_2026-11-12.md`, the keep list in `areas\STRUCTURAL_COMMAND_SORT_12NOV.md`, and the card's own code references (Structural 1.0.126, commit 8de95c34, read in the card; **not re-read by this lane**). **Nothing here was run.** Nothing is built, installed or accepted.
**Drawings and readings:** `areas\trust-run\cases\_MADE_UP_DRAWINGS_AND_READINGS.md` (MD-15 and MD-15-B for this card; the ribbon reading and menu reading are defined at its end).
**Defaults taken for Tim (DRAFT, all five decisions on the card are still OPEN, so the cases follow its recommended answers):** the button list is the one in the sort file (32 buttons); panels are Roof, Floors, Bracing, Tools; the beam drop-down is yes; the tab is named "CE Structural"; buttons with open faults are on the tab only once their fix has passed (decision 3).

---

# FOR TIM

**These checks prove the Structural tab shows exactly the buttons on the core list, in the order you draft a house, that every button starts the right command, that no command is lost, and that the old tab comes back with one switch.**

1. **24 robot cases** (section 2).
2. **The proof that matters:** the robot never carries its own copy of the button list. It reads the ribbon and the pull-down menu back against the office core list file, so a button added or removed anywhere fails (T1, T9, T10).
3. **Two places the card disagrees with itself, so the robot only records them:** the card's picture puts CLEAN, BT1, the bracing panel and the schedules on the tab, but its decision 3 says they stay off until their fixes pass; and STRSCHEDREFRESH is on the keep list yet is marked "expert" today, while the card says "expert" will mean never on the core tab (T11, T12).
4. **Not proven by any robot:** that colleagues can draft a real job from the tab without hunting for a button. That is your three working days.

---

## 1. What is being proven

1. **The tab equals the list.** Same panels, same buttons, same order, same names.
2. **Every button works.** Pressing it starts its own command.
3. **Nothing is lost.** Every typed command still runs, including the old short names.
4. **The way back works.** One switch and a restart returns today's tab, complete.
5. **Nothing in a drawing is touched.** Layout only.

## 2. The robot cases

### Group A: the tab matches the core list

**T1. The ribbon read back against the list**
1. **Drawing:** MD-15 (any Structural copy).
2. **Do:** switch "Structural core tab" on, restart AutoCAD, take the ribbon reading. Read the office core list file. Compare.
3. **Right:** one Structural tab named "CE Structural" (decision 5, recommended). Every panel and button in the list, in the list's order, and nothing else. The comparison is made from the file, not from a list the robot holds.
4. **Faulty partner:** (a) the list with one button removed (card check 6) must fail the comparison; (b) a build with one extra button; (c) a build with two buttons swapped. Each must fail.

**T2. Four panels in drafting order**
1. **Right:** left to right: Roof, Floors, Bracing, Tools (decision 2, recommended). Inside Floors the order follows the sort file (beams 1, 2, 4, 5, then BDL and the BSET tools, the five support markers, the five switch tools, FJ1).
2. **Faulty partner:** a build with the panels in the old order (Beams, Columns and Footings, Rebar and Bracing, and so on). Must fail.

**T3. Switch off by default: today's tab is untouched**
1. **Do:** with the switch at its default, take the ribbon reading and compare with the ribbon reading of the installed Structural build (1.0.126) on the same AutoCAD.
2. **Right:** identical, button for button. Settings reading shows the switch off.
3. **Faulty partner:** a build that changes the old tab with the switch off. Must fail.

**T4. Switching on needs a restart, and says so**
1. **Do:** change the switch with AutoCAD running; take the ribbon reading; read the Settings row's own text; then restart and read again.
2. **Right:** no change before the restart. The row says a restart is needed (card section 2, item 1). After the restart the four-panel tab.
3. **Faulty partner:** a build whose row does not say so. Must fail on the text check.

**T5. Switching off and restarting brings the old tab back, complete**
1. **Do:** from T1, switch off, restart, take the ribbon reading.
2. **Right:** equal to the T3 reading, every button (card check 5).

**T6. Which Structural tab draws (the card's open item)**
1. **Do:** read the ribbon after loading with the switch on and with it off.
2. **Right:** exactly one tab for Structural in each state, never two. The card does not say which of the two ribbon builders is live (card section 7, item 1). RECORD the name of the tab each state shows.
3. **Faulty partner:** a build that changes only one of the two builders. Two Structural tabs appear, or the old one stays, and the case fails.

### Group B: every button works, nothing is lost

**T7. Press every button once**
1. **Drawing:** MD-15.
2. **Do:** for each button in the ribbon reading: press it, read the command echoed and the first prompt, press Escape, read the drawing reading.
3. **Right:** each button starts its own command (the echoed name equals the command the list assigns). The drawing reading after Escape is identical to before. Buttons with a window (Help, Settings) open it and close it with no change.
4. **Faulty partner:** a build with the DS1 button wired to DS. Must fail by name.

**T8. Typed commands still run (ten, including the old short names)**
1. **Do:** on MD-15 type ten hidden commands, including SDS, ABS and FASTSAVE, each followed by Escape.
2. **Right:** each starts. None says "Unknown command". Drawing reading identical after each Escape.
3. **Faulty partner:** a build that unregisters hidden commands. Must fail.

**T9. The pull-down menu equals the core list**
1. **Do:** take the menu reading on AutoCAD 2027 and again on AutoCAD 2024.
2. **Right:** the same tools, in the same order, as the core list, on both years (card check 4 and the 2024 check). This is the menu built from the one office list (card section 2, item 5).
3. **Faulty partner:** the installed menu, which comes from a ready-made menu file or the separate 219-command list. Written to FAIL on today's build if the menu is not yet built from the list.

**T10. One list drives both**
1. **Do:** on a scratch copy of the code, remove one button from the core list file only. Take the ribbon reading and the menu reading.
2. **Right:** the button is gone from both and nothing else changed.
3. **Faulty partner:** a build where the menu keeps its own list. The button stays in the menu and the case fails.

**T11. The "expert" mark means never on the core tab (RECORD for one command)**
1. **Do:** on a scratch copy mark one listed command "expert". Then read the ribbon reading for STRSCHEDREFRESH, which is on the keep list and is marked expert today.
2. **Right:** the marked command is absent from the core tab (card section 3, item 3). For STRSCHEDREFRESH the card and the keep list disagree. RECORD what the tab does and put it to Tim. Not a pass or a fail.
3. **Faulty partner:** the installed ribbon, which ignores the expert mark. Written to FAIL on today's build.

**T12. Buttons with open faults (RECORD the count)**
1. **Do:** read which of BT1, the bracing panel, STRSCHEDCREATE, STRSCHEDREFRESH, CLEAN and the support markers are on the tab, and whether their fix is recorded as passed.
2. **Right:** under decision 3's recommended answer a fault-held button is on the tab only once its fix passed. The card's picture shows them on the tab, so the card disagrees with its own decision. The robot compares the tab with the list file and records which fault-held buttons are in it. The count 32 is true only if all are in. RECORD, not a pass or a fail.

**T13. Nothing is deleted**
1. **Do:** read the number of registered Structural commands and their names, with the switch off, then on.
2. **Right:** equal to the installed build's list (375 entries in the command list per the sort file). Nothing removed by turning the core tab on.
3. **Faulty partner:** a build that removes hidden commands. Must fail.

**T14. The beam drop-down (decision 4, recommended yes)**
1. **Do:** read the Floors panel; open the Beam drop-down; choose each of 1, 2, 4 and 5.
2. **Right:** one Beam button holds 1, 2, 4 and 5, each starting its own command. The button count then differs from 32; RECORD the new count. Also RECORD how the command log's "BEAM" maps to 1, 2, 4 and 5 (not known, card section 7, item 2).
3. **Faulty partner:** a drop-down whose "2" runs "1". Must fail.

### Group C: where it can go wrong

**T15. The Structural tab on every drawing, beside the Civil tabs**
1. **Drawing:** MD-01 (Civil), MD-15 (Structural), MD-15-B (blank).
2. **Right:** the same Structural tab on each, complete. With the Civil core ribbon switch (TRUST-02) on, the Civil tabs are unchanged and the Structural tab is still complete. RECORD the left-to-right order of the tabs.

**T16. Nothing stored in a drawing**
1. **Drawing:** MD-15.
2. **Do:** switch on, restart, open, close with no edits.
3. **Right:** record reading, drawing reading and file hash identical; no save question. The Settings reading differs only in the one switch.
4. **Faulty partner:** a build that writes the choice into the drawing. Must fail.

**T17. AutoCAD 2022 to 2024: greyed tools with a plain reason**
1. **Do:** on 2024 take the ribbon reading and each greyed button's tooltip.
2. **Right:** the tools that only work on 2027 are greyed, each with a plain reason in its tooltip (as built for UX-STRUC-12). All other buttons are live. The tab and menu list the same tools as on 2027. RECORD which tools are greyed (the card does not list them).

**T18. Help lists every typed command, as today**
1. **Do:** open Help (CEHELP) with the switch off and on.
2. **Right:** the same list of typed commands both ways, equal to the installed build's.

**T19. Tooltips and icons**
1. **Do:** from the ribbon reading read every button's tooltip and whether it has an icon.
2. **Right:** every button has a tooltip in drafting words (none of the words on the jargon list in `areas\TRUST_PLAN_REVIEW_12NOV.md`) and an icon.
3. **Faulty partner:** a button with an empty tooltip. Must fail.

**T20. Same answer twice, on two logins**
1. **Do:** take the ribbon reading twice from fresh starts on login 1, then on a second Windows login with a different workspace.
2. **Right:** identical, word for word. If the second login's own workspace hides the tab, RECORD it.

**T21. Escape and Cancel at layout level**
1. **Do:** press Escape in the middle of each pull-down menu open and each drop-down open.
2. **Right:** nothing starts and nothing changes.

**T22. The core list is office-wide, not per person**
1. **Do:** read where the list file lives; on a second login with different personal Settings read the ribbon.
2. **Right:** the same list, the same ribbon. A personal setting does not change which buttons are core.
3. **Faulty partner:** a build that reads the list from a per-person folder. Must fail on the second login.

**T23. The list file missing or damaged**
1. **Do:** on a scratch copy remove, then half-delete, the core list file; restart.
2. **Right:** RECORD. The card does not say what the tab does. Right at the least = AutoCAD still loads, typed commands still run, and one plain line says what is wrong. Never a blank AutoCAD.

**T24. Discovery**
1. **Do:** from the tab, open Help and find a hidden command by name.
2. **Right:** it is listed with its typed name (card section 2, item 7).

## 3. The gaps from the review, answered

1. **Reading alone is not enough.** T7 presses every button and reads what ran; T16 reads the drawing and file after the switch is used.
2. **The same jobs taught and tested.** Nothing here is learned; the list is a file. MD-15 is used for testing only.
3. **"Sent" is not "worked".** T7 reads the command that actually started.
4. **Undo compared on linework.** Layout only; T7 and T16 compare the full drawing reading after Escape and after close.
5. **Twice, identical.** T20.

## 4. The nine cases every card must answer

1. **Read-only or open elsewhere:** not applicable, no drawing is written (T16).
2. **Save As and copied pits:** not applicable.
3. **Units:** not applicable.
4. **Xref:** not applicable, no drawing is touched.
5. **Paper space:** T15 (the tab is the same in every drawing and layout). Nothing else applies.
6. **A hidden command typed from habit:** T8.
7. **Another CE version:** T3 and T5 (the old tab returns unchanged).
8. **Spoiled blocks:** not applicable.
9. **A job over several drawings:** T15 (several drawings open, the tab is the same).

## 5. The look by eye (Codex, real AutoCAD 2027, copies only)

**What to open:** the tab at a normal window width and at a narrow width; then one pull-down menu.

**What to look at, and what right looks like:**
1. **Labels are not cut off** at either width, and the four panels still read left to right as Roof, Floors, Bracing, Tools.
2. **Icons are present** and tell the buttons apart.
3. **No software words** in any label or tooltip.
4. **It looks like a house in the order you draft it:** a new colleague drafting a roof looks left first.
5. **The beam drop-down** opens and its four entries are readable.
6. **The menu** lists the same tools in the same order as the tab.

**Screenshots:** `S1_tab_normal.png`, `S1_tab_narrow.png`, `S1_menu.png`.

**Cannot be proven without Tim:** that the button list is the right 32, which Structural tools colleagues use (no record), and that the tab lets a colleague draft a real job from roof to bracing without typing a command or hunting for a button.
