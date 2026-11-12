# TRUST-02: the core ribbon, two tabs with only what you keep

**Status: DRAFT.** Not approved, not built, not tested, not installed. No code starts until Tim approves this card and lifts the HOLD for it.
**CORRECTED 12 Nov (review of draft pull request 2038):** wherever this card says the way back is the existing "Show the old CE tabs" switch, that is wrong. That switch brings up an earlier three-tab layout. The way back is the new core-layout switch, off by default: off means today's ribbon exactly. Also found: New Job (CDNEWDWG) exists only in the AutoCAD 2027 version, so on 2025 and 2026 the button must be left off or greyed with a plain reason; and each core button must keep today's plain tooltip.
**Class:** Modify (the Civil ribbon). Nothing is deleted; every command can still be typed.
**Source:** Tim, 5 Nov: small core for colleagues. Voice talk 6 Nov: two tabs, both always visible, CE Drainage left to right pits, downpipes and tanks, pipes, Check this drawing, schedules; CE Design for the engineering. Tim, 7 Nov: "some of the commands are useful in all drawings as ce tools". Step 2 of `areas\trust-plan.md`. Button list: `areas\CIVIL_COMMAND_SORT_06NOV.md`.

---

## FOR TIM

**Today the Civil tab is one tab called CE with 9 panels, 49 buttons and 27 more inside drop-downs. This card replaces it with two tabs that read in the order you draft.**

```before
One tab "CE": CE, Draw, Sources, Edit, Design, Review, Site, Import, Settings.
49 buttons, 27 more in drop-downs. Review alone has 10.
New Job can only be typed.
```

```after
Tab "CE Drainage": [New Job] Pits | Downpipes and tanks | Pipes | Check this drawing | Schedules | Help
Tab "CE Design": design inputs, calculations, rainfall, top water level, solver, rules.
47 buttons in all. Everything else is typed only.
```

**What this card does not do:**

1. **It does not stop anyone typing a hidden command.** It cuts what people see, not what they can reach.
2. **It does not fix any tool.** A button with an open fault (FO, CDFW, PITSCHEDULE) either waits for step 4 or goes on with its fault written on its tool note. That is your call, decision 4 below.
3. **It does not touch Structural.** Its tab stays as it is for now (decision 5).

## 1. What you'd see

1. **Two tabs on every drawing,** Civil or not, with no switch between them. Nothing in the code hides tabs by drawing type today, so this needs no new behaviour.
2. **CE Drainage, left to right:** the panels and buttons in the Civil sort, with whatever you change in the interview.
3. **CE Design:** the nine design tools in the Civil sort.
4. **The Check this drawing button** opens the read-only check (CDCHECKCURRENT) until step 8 replaces what is behind it. The button does not move when that happens.
5. **Pipe, Pit and Source pop-up tabs** still appear when you pick a CE object (decision 3).
6. **A Civil button pressed in a non-Civil drawing** still asks "Is this a Civil drainage drawing?" once, as it does today. That gate is unchanged.

## 2. The full experience

1. **Trigger:** the ribbon is built once when AutoCAD starts. A change of layout needs AutoCAD restarted. The card must say so on screen when the layout switch is changed.
2. **Prompts, selection, preview:** none. This is layout only.
3. **Cancel, Escape, Undo:** nothing to cancel or undo; no drawing is touched.
4. **Save and reopen:** nothing is stored in a drawing.
5. **Locked layers, Xrefs, REFEDIT:** not touched.
6. **Typed commands:** every command keeps working by name, including the old names (UX-NAMES-01).
7. **AutoCAD 2022 to 2024:** there is no ribbon on those years. They get the CE CVL pull-down menu, which today is a separate list (8 sections, 51 items) and does not include New Job. **This card makes the pull-down follow the same approved list,** so the two cannot drift. Whether that menu can show the same grouping needs a look in AutoCAD 2024 (not known yet).
8. **CE Tools tab (Manager):** stays, with CE Manager, version, health, support, updates, CE Blocks, Move + Rotate and Copy + Rotate. Which of those colleagues should see is decision 6.
9. **Discovery:** the old layout stays reachable by the existing "Show the old CE tabs" switch, so nobody is stranded.

## 3. Settings

1. **"Show the old CE tabs"** (exists today, off): turns the old one-tab layout back on after a restart. This is the undo.
2. **The approved button list** lives in one file that both the ribbon and the 2022 to 2024 menu read (new). It is office-wide, not per person: it ships with the release.
3. **No per-person hiding** in this card. One layout for everyone is the point (trust rule 2).

## 4. What it reuses

1. **The hand-written Civil layout.** A tool comes off the ribbon by being left out.
2. **The tab list** that already orders Civil (15) before Structural (20). A second Civil entry gives the second tab.
3. **The existing old-layout switch** as the way back.
4. **The click log,** to see after three days which buttons were used. It records the command and the time, not the drawing.

## 5. How it gets proven

**Robot, in real AutoCAD 2027:**

1. Read the ribbon back and compare it with the approved list: every tab, panel and button, in order. Any extra or missing button fails.
2. Press every button once in a Civil copy: each starts its command (the click log shows "sent", none "FAILED").
3. Type ten hidden commands: each still runs.
4. Open a Structural drawing and a blank drawing: both tabs still show.
5. Turn on the old-layout switch and restart: the old tab is back, complete.
6. A deliberately wrong list (one button removed) must fail check 1.

**Robot, AutoCAD 2024:** the pull-down menu lists the same tools as the approved list.

**Codex:** one look at each tab at normal and narrow window widths: no cut-off labels, no software words, icons present.

**Tim, about three working days:** draft real jobs from the two tabs. Right = you never had to type a command you use daily, and never hunted for a button.

## 6. Decisions for Tim

1. **The button list:** Civil sort questions 3 to 11 (interview F3 to F11). OPEN.
2. **Tab order:** CE Drainage first, CE Design second, then Structural, then CE Tools. Recommended. OPEN.
3. **Pop-up tabs for a picked pipe, pit or source:** keep them. Recommended, because CDEDIT on pick is your most used action. OPEN.
4. **Buttons with open faults:** on the ribbon with the fault on the tool note, or off until fixed in step 4. Recommended: off until fixed for anything that can lose or hide data (CDFW, PITSCHEDULE); on with a note for cosmetic ones (FO symbol). OPEN.
5. **Structural:** stays a third tab, unchanged, until Civil's core is accepted (Civil sort question 8). OPEN.
6. **CE tools on every drawing:** which tools those are (interview F12). OPEN.
7. **One Checks button or three:** the core shows one, "Check this drawing". The three overlapping check buttons come off. Recommended. OPEN.

## 7. Not known yet

1. What the 2022 to 2024 pull-down looks like to a colleague today, and whether it can be grouped the same way.
2. Which AutoCAD year each first colleague uses (interview A3).
3. Whether any colleague relies on a button that the click log, which is Tim's PC only, never saw.
4. Whether the pop-up tabs still appear if the plugin is ever loaded the one-host way. They would not, by the code read; that way of loading is off on every PC today.

Written from reading Civil 3.0.90 and Manager 1.1.89 (commit cf059dcf). Nothing here was run in AutoCAD.
