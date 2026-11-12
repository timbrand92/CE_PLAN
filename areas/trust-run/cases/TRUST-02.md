# Cases for TRUST-02: the core ribbon (two tabs)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Written from card `04_REFERENCE\ux-plan\cards\TRUST-02_CORE_RIBBON_CARD_DRAFT_2026-11-12.md`, the Civil sort (`areas\CIVIL_COMMAND_SORT_06NOV.md`) and installed Civil 3.0.90 (commit cf059dcf). **Nothing here was run.** Nothing is built, installed or accepted.
**Drawings and readings:** `areas\trust-run\cases\_MADE_UP_DRAWINGS_AND_READINGS.md`.
**The controller's correction is built in:** the two-tab layout sits behind a NEW switch, OFF by default, and today's layout is left alone. So there are cases for the switch off, the switch on, and the old-tabs switch that already exists.

---

# FOR TIM

**These checks prove the new tabs show exactly the buttons you approved, in your order, that every button starts the right tool, and that switching it all off gives you today's ribbon back.**

1. **20 robot cases** (section 2). The ribbon is read back button by button and compared with one approved list.
2. **The approved list is a draft.** Until you answer the Civil sort questions, the list the robot checks against is the sort proposal (47 buttons: 38 on CE Drainage and 9 on CE Design). Your answers replace it, and the cases do not change.
3. **A faulty partner for each check.** One of them is today's own menu for AutoCAD 2022 to 2024, which has no New Job button. The check must fail on it. That proves the check can tell.
4. **What the robot cannot judge:** whether the order feels right to draft in, and whether any button you use daily has gone. That is your three days and the click log.

---

## 1. What is being proven

1. **The ribbon equals the approved list,** tab by tab, panel by panel, button by button, in order, with each button's command.
2. **Every button works,** meaning it starts its tool and the tool then does what the answer sheet says, not just "a command was sent".
3. **Nothing was taken away from reach.** Every hidden command still runs when typed.
4. **There is a way back.** Switch off the new layout and today's ribbon is back, complete, after a restart.
5. **2022 to 2024 follow the same list.** Their pull-down menu matches.
6. **No drawing is touched.** The ribbon is layout only.

## 2. The robot cases

### Group A: the layout equals the list

**R1. Read the new ribbon back and compare every button**
1. **Drawing:** MD-01 open. New-layout switch ON, AutoCAD restarted.
2. **Do:** read the ribbon through AutoCAD's own ribbon list: every tab, its panels, each button's label, order and command string.
3. **Right:** the tabs in order are CE Drainage, CE Design, Structural, CE Tools (card decision 2, recommended, so DRAFT default). On CE Drainage the panels run: Pits (6), Downpipes and tanks (11), Pipes (11), Check this drawing (2), Schedules (2), Everyday help (6), with New Job placed where the approved list puts it. CE Design has 9. 47 buttons in all. Every label, order and command equals the approved list. Any extra, missing or moved button fails.
4. **Faulty partner:** the approved list with CDPITCOVERFLIP left out, and a second with CDRENUMBER and CDEDIT swapped. Both must fail R1 by name.

**R2. Each button holds the right command**
1. **Drawing:** same as R1.
2. **Do:** for each of the 47 buttons read the command it will send, before pressing anything.
3. **Right:** equals the approved list's command, button by button.
4. **Faulty partner:** the PIT button wired to PP. The label reads right and the old check would pass. R2 must fail on that button.

**R3. Pressing each button does the work**
1. **Drawing:** MD-01 fresh copy for each button group; MD-01-DP for downpipe and tank buttons.
2. **Do:** press each button once. Read what is active straight after (the command or window it opened).
3. **Right:** the right command or window is active. No "Unknown command" in the command-line reading. Then press Escape up to three times. The drawing reading is identical to before. For the buttons that finish without a prompt (help, health, check this drawing), the result is as the answer sheet says: Check this drawing opens the CDCHECKCURRENT result for MD-01 with 6 pits and 6 pipes (the same counts as UX-OPEN-01 O1).
4. **Faulty partner:** a button wired to a command that no longer exists. Must fail on "Unknown command", even though the click log says "sent".

**R4. Hidden commands still run**
1. **Drawing:** MD-01.
2. **Do:** type ten hidden commands, chosen so none writes without a prompt: PIPEEDIT, PITEDIT, TG, MOVEROT, COPYROT, CDSETUP, CDHUB, CDCHECKS, CDAUDIT, CDPIT450.
3. **Right:** each starts (a prompt or window appears). Escape leaves the drawing reading identical. None says "Unknown command".
4. **Faulty partner:** a build that removes one old name (TG). Must fail on TG.

**R5. One list drives both places**
1. **Drawing:** none needed.
2. **Do:** on a scratch copy of the approved-list file, remove one button. Restart 2027. Then start 2024.
3. **Right:** the button is gone from the 2027 ribbon and from the 2024 pull-down menu, and nothing else changed.
4. **Faulty partner:** a build where the ribbon has its own written list. The button stays on the ribbon and the case fails.

### Group B: today's layout is untouched, and the way back

**R6. New switch OFF: today's ribbon exactly**
1. **Drawing:** MD-01.
2. **Do:** switch OFF (the default), restart, read the ribbon.
3. **Right:** one tab, "CE", with 9 panels (CE, Draw, Sources, Edit, Design, Review, Site, Import, Settings), 49 buttons and 27 more inside drop-downs. This is compared with a reading taken from installed 3.0.90 on the same PC, saved before any change, button by button.
4. **Faulty partner:** a build with the new switch default ON. R6 fails because the tab names differ.

**R7. Old tabs switch (already exists)**
1. **Do:** with the new switch OFF, turn on "Show the old CE tabs" (ShowClassicCeTabs), restart, read.
2. **Right:** the classic layout (tab titled "CE Civil") matches its own saved reading from installed 3.0.90. Note for Tim, from the review: this is an older layout, not today's.
3. **Faulty partner:** a classic layout with one panel missing.

**R8. Both switches on**
1. **Do:** new layout ON and old tabs ON together, restart, read.
2. **Right:** RECORD, because the card does not say which wins. The robot writes down what it sees. It must show exactly one family of tabs, no two tabs with the same name, and no crash. Anything else fails.

**R9. Changing the layout switch says restart**
1. **Do:** change the layout switch in the settings file or window while AutoCAD runs.
2. **Right:** CE says on screen that AutoCAD must restart for the layout to change (card section 2, item 1). The words are read back. The ribbon does not change until restart.
3. **Faulty partner:** a build with no message.

### Group C: where it shows, and what it leaves alone

**R10. Every kind of drawing**
1. **Drawing:** MD-01, MD-15 (Structural), MD-15-B (blank), no drawing open.
2. **Right:** both CE Drainage and CE Design show in every case, with the same buttons. Pressing a Civil button on MD-15 asks "Is this a Civil drainage drawing?" once. The second press does not ask again. Answering No leaves the drawing reading identical.
3. **Faulty partner:** a build that hides the tabs on a Structural drawing (the old per-drawing behaviour). Must fail.

**R11. Pop-up tabs on a picked object**
1. **Drawing:** MD-01-DP.
2. **Do:** pick a pit, then a pipe, then a downpipe, then nothing.
3. **Right:** the Pit, Pipe and Source tabs appear for each pick, with the same panels and buttons as today (compared with the saved reading), and go away on an empty pick. Not known yet (card item 4): whether they appear if the plugin loads one-host. The robot only checks the way it loads today.
4. **Faulty partner:** a build that removes the Pipe tab. Must fail on the pipe pick.

**R12. No drawing change from building the ribbon**
1. **Drawing:** MD-01.
2. **Do:** open it with the new layout, wait for the ribbon, close with no edits.
3. **Right:** changed counter unmoved, drawing reading and record reading identical, no save question, no new file.
4. **Faulty partner:** a build that writes a ribbon-state note into the drawing. Must fail.

**R13. A layout (paper space) is current**
1. **Drawing:** MD-11.
2. **Do:** make a layout current. Press the PIT button.
3. **Right:** RECORD. The card does not say what a pit button does in paper space. Pass only if no pit object is created in paper space and CE says something plain. The robot writes down what it says and sends it to Tim.

**R14. Click log**
1. **Do:** press five buttons, then read the click log.
2. **Right:** each press is recorded with the command and the time. No drawing name, path or job name appears.
3. **Faulty partner:** a build that logs the drawing name. Must fail.

### Group D: AutoCAD 2022 to 2024

**R15. Pull-down menu equals the approved list**
1. **Drawing:** MD-01 on AutoCAD 2024.
2. **Do:** read the CE CVL menu (through AutoCAD's menu list).
3. **Right:** every item and its command equals the approved list, including New Job. Today the menu has 8 sections and 51 items and no New Job.
4. **Faulty partner:** today's own menu. It has no New Job and a different item count, so it must fail R15. If R15 passes it, R15 is wrong.

**R16. Pull-down items work**
1. **Do:** pick each menu item once.
2. **Right:** as R3: the right command or window starts, then Escape leaves the drawing reading identical.

**R17. The grouping on 2024**
1. **Do:** read how the menu groups its items.
2. **Right:** RECORD. Whether the menu can show the same grouping as the ribbon is not known (card section 7, item 1). The robot writes down what it sees.

### Group E: two logins, other versions

**R18. Two Windows logins read the same ribbon**
1. **Do:** run R1 on a second login with a different theme, workspace and personal Settings.
2. **Right:** identical to the first login, button for button. If the second login's saved workspace hides the CE tab, RECORD it (not known whether a workspace can hide it).
3. **Faulty partner:** a build where a per-person setting hides a button. The two readings differ and the case fails.

**R19. Manager older, newer, or missing**
1. **Do:** run R1 with Civil new and Manager one build older, then with Manager absent.
2. **Right:** RECORD. The CE Drainage and CE Design tabs must still show. The CE Tools tab shows or not according to Manager. Not known which order the tabs take when Manager is missing. No crash.

**R20. CE Tools tab contents**
1. **Do:** read the CE Tools tab with the new layout.
2. **Right:** it equals today's (CE Manager, version, health, support, updates, CE Blocks, Move + Rotate, Copy + Rotate) unless the approved list changes it (card decision 6, OPEN). A command that appears on two tabs is allowed only if the approved list says so.

## 3. The four gaps from the review, answered

1. **Reading alone is not enough.** Here the thing read is the ribbon. R3 and R4 press and then read the drawing again, so an edit made by a button is seen.
2. **The same jobs taught and tested.** Not applicable: the ribbon has no reader. The approved list is fixed by Tim, not learnt.
3. **"Sent" is not "worked".** R2 reads the wired command, R3 reads what happened next. The click log's "sent" is never accepted as proof (card section 5 used it).
4. **Undo compared on linework.** Not applicable: no button here is claimed to be one U. Each button's own undo is covered by that tool's cases.
5. **Twice, identical.** R18.

## 4. The nine cases every card must answer

1. **Read-only drawing:** R12 on MD-14. The ribbon is layout only, so run R1 and R12 on MD-14 and expect no change.
2. **Save As, copied pits:** not applicable. Layout only.
3. **Units:** not applicable. Layout only.
4. **Xref:** not applicable. Run R1 on MD-10 for completeness; the ribbon is the same.
5. **Paper space:** R13 (RECORD).
6. **A colleague typing a hidden command:** R4.
7. **Another CE version:** R19, and the Manager case in R20.
8. **Spoiled blocks:** not applicable.
9. **One job over several drawings:** not applicable.

## 5. The look by eye (Codex, real AutoCAD 2027, copies only)

**What to open:** MD-01 with the new layout on, at the normal window width and at a narrow one.

**What to look at, and what right looks like:**
1. **Both tabs, left to right,** read in drafting order. Right = a drafter finds pits, then downpipes and tanks, then pipes, then Check this drawing, then schedules, with no hunting.
2. **No label is cut off,** at normal or narrow width. If the ribbon shrinks a panel to an icon, the icon is still recognisable. Right = nothing reads "CD..." in the middle of a word.
3. **Every button has its icon,** not a blank square or a generic gear.
4. **No software words** in any label or tooltip (no "NOD", "record", "sync").
5. **The Check this drawing button is easy to find** and sits where it will stay when its behaviour is replaced later.
6. **Pop-up tabs** appear next to the main tabs when a pit or pipe is picked and do not push the main tabs off.
7. **The restart message** (R9) is plain and one decision.
8. **On 2024:** open the pull-down and look: grouped, readable, with New Job.

**Screenshots:** `RIBBON02_drainage_normal.png`, `RIBBON02_drainage_narrow.png`, `RIBBON02_design.png`, `RIBBON02_menu2024.png`.

**Cannot be proven without Tim:** whether the order feels right; whether a colleague relies on a button the click log never saw (Tim's PC only).
