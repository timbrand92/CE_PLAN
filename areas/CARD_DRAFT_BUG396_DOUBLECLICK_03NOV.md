# Workflow card draft: BUG-396 item 1, double-click on a placed Pit Schedule cell opens the Pit Schedule window at that cell

Written Tuesday 3 November 2026 (Melbourne) by Sonnet (Team, read-only) for CE 05 / CE 00. The only file written is this one. The job file gave the path `C:\CE_PLANreas\...`; I read that as `C:\CE_PLAN\areas\` (the backslash before "areas" was lost), the same reading the other CARD_DRAFT files made.
Git: `git fetch origin` run first. Code read with `git show` at three points: the installed commit 61fd6fbc (Civil 3.0.89), b1 (`origin/claude/rel-20261108a`, cf059dcf, Civil 3.0.90) and b2 (`origin/claude/rel-20261110a`, aa3b92ac, Civil 3.0.91). `gh` is not on this tool path, so I read no PR list; I searched branches and commit messages instead.

## FOR TIM

1. **One card follows, a draft. Nothing is approved and no code exists.** The double-click on a placed Pit Schedule cell is not built on any line: not installed (3.0.89), not b1, not b2.
2. **What you see today:** double-click a cell of the placed schedule and AutoCAD's own text editor opens (it looks blank and prints "Undefined shape 80 / 50"). Codex saw this on 18 and 19 Oct. Typing a new number changes the table only; the plan label stays as it was; one U puts the table back.
3. **Installed check, done by me:** 61fd6fbc is an ancestor of b1 and b2 (checked with git). It is NOT an ancestor of `rel-20261102a` (3fbb9da5, Civil 3.0.88), which is an older line than what is installed. The three files that matter (the double-click list, the Pit Schedule window code, the PITSCHEDULE command) are identical on 61fd6fbc, b1 and b2. So b1 and b2 change nothing here.
4. **What I suggest:** double-click a data cell: the Pit Schedule window opens with that pit's row selected, no AutoCAD text editor. A switch in Settings turns it off and returns AutoCAD's editor exactly. It ships ON as the approved design says, but see question 1 below (the pit-label double-click was set OFF on 22 Oct until Codex had looked).
5. **Two things I found that the brief did not say:**
   1. **The window needs a change, which is Codex's.** The Pit Schedule window can only open on the whole project today; there is no "open at this pit" entry.
   2. **Two designs are on record and they disagree.** The approved design (decisions D1 to D10, "double-click opens the Pit Schedule window at that cell; Change the pit vs Change how it reads per cell") opens a window. The pilot checklist (7 Oct) and your tick list (12 Oct) instead expect you can type a new number straight into the cell and it renames the pit. That second route is the one that fails in real AutoCAD. This card follows the approved design and drops typing into the cell as a rename route; question 4 asks you to confirm.
6. **Five questions for you, each with a default, in field 18.** The ones that decide the shape: a locked or Xref schedule (read-only window, or leave AutoCAD alone), and a header or title cell (top of window, or nothing).
7. **Read:** the report and brief for this bug, the carpark entry, the D-pack line, the Codex triage, the double-click list file on three commits, the Pit Schedule window constructor, the status code. **NOT read:** `REGRESSION_LOG.md`, the Codex screenshots, the Pit Schedule window's view model end to end, the schedule-link code that handles a changed table cell, the code that places the table, Tim's settings (not allowed).
8. **Built: nothing. Tested: nothing. Installed: n/a. Tim-accepted: no. NOT proven:** everything marked "suggested" is a design, not something that exists. I did not open AutoCAD and did not run the robot.

---

## CARD: BUG-396 item 1, double-click a placed schedule cell opens the Pit Schedule window at that pit

**DRAFT FOR TIM: nothing is approved. No code, PR or branch exists. BUG-396 stays OPEN (Codex look L4-08, 3.0.54 on 18 Oct and 3.0.56 on 19 Oct: "DIFFERENT, SURE").**

1. **Name and what it does for a drafter.** Double-click on the placed Pit Schedule opens the Pit Schedule window with the clicked pit's row ready to read or change. For the drafter: you see a schedule row you want to check or change, you double-click it, and the same window you used to build the schedule opens on that pit, instead of a blank text editor.
2. **Ribbon or context trigger.** Context trigger: a double-click on a cell of a table that CE placed with `PITSCHEDULE`. The window's own command stays `PITSCHEDULE`, ribbon button "Pit Schedule" in the Civil Review panel (same button as in `CARD_DRAFTS_PIT_SCHEDULE_02NOV.md`). I did not re-read the ribbon tab title. Not to be confused with a double-click on a row INSIDE the open window: that one already exists and highlights the pipe on the plan (the window's own `OnScheduleGridMouseDoubleClick`, read on 61fd6fbc).
3. **Works today (read on 61fd6fbc, same on b1 and b2).**
   1. The double-click list file marks "placed pit schedule block" as having no window: "PITSCHEDULE opens one window over the whole project record and notes the placed block's Xref sources, but it does not open on a chosen placed schedule yet; that needs its own workflow card (G5)." So CE does nothing and AutoCAD's own double-click runs.
   2. Codex saw that route open AutoCAD's text editor (MTEDIT) on the P2 cell, blank-looking, with "** Undefined shape 80" and "** Undefined shape 50". Typing C2 after Ctrl+A and closing the editor changed the table to C2; the plan label stayed P2; one U restored the table. The "Undefined shape" lines also appear in BUG-623 (a Q note); whether the two share a cause was not checked.
   3. The Pit Schedule window opens on the whole project and has no way to open at a chosen pit (constructor reads no pit name; I found no start-at entry in the window, view model or command).
   4. **Keep:** the old schedule is never touched without an action from you; a double-click on a pit label in the plan is a separate route (BUG-430) and is not part of this card; AutoCAD's protection of locked layers, Xrefs and REFEDIT is never bypassed (Native AutoCAD protection rule).
4. **What the train or PR changes.** Nothing. I found no PR, branch or commit for item 1. `git log --all --grep=396` shows only item 6 (Manager diagnostic wording), 7a (a bare 8 beside P8 refused on every rename route), 7c (a charged pipe the relink turns round says one plain line) and one Structural footing log line (S-18). The same three files are identical on installed 61fd6fbc, b1 and b2. Not on any line.
5. **Suggested class: Modify** the CE side (the "no window" row becomes a real window kind, the same pattern used for pit, pipe and source double-clicks); **Rebuild** the window's opening (it needs a new start-at-pit entry, a Codex window brief). The decision to open the window is already approved in the D-pack; the placed table's wording "Change the pit" vs "Change how it reads" per cell is in the same line and is NOT covered by this card (see field 6.4).
6. **Prompts and windows (suggested).**
   1. Double-click a data cell: the Pit Schedule window opens on the Rows page with the clicked pit's row selected and in view. No command-line prompt, no AutoCAD text editor.
   2. One command-line line on opening: "[CE] Pit Schedule opened at P2." The wording is a suggestion for you to change.
   3. Header, title or blank cell: depends on question 2 (default: window opens at the top of the list; nothing selected).
   4. NOT in this card: renaming a pit by typing in the placed cell (the "Change the pit" per-cell choice). Renaming stays in Edit Pit (`PITEDIT`) as the release notes already tell you. If you want per-cell choice later it needs its own card.
   5. If the table's pit cannot be found in the project record (an old table with no link; status "UNLINKED SCHEDULE"): the window still opens, with no row selected, and the one-line message says plainly that this table is not linked and which button to use. Suggested wording only.
7. **Selection.** None to pick. The click gives the table and the cell; CE finds the schedule record for that table and the pit named in the cell's row. Suggested: the pit is read from the row's pit-number cell, not from the cell you clicked, so a click on Cover or Remarks still opens that pit. How the row is mapped to a pit was not read (field 19).
8. **Preview.** None. The window opens on a real row (that part is the window's job, not a drawing preview). The existing row zoom-and-glow on the plan (UX-NAV-02) is the window's own and stays as it is.
9. **Drawing output.** None. Opening the window changes nothing on the drawing. Locked layer: the double-click still opens the window (a read-only look is safe) and any later change is refused by the window's own rules, as it is when the window is opened from the ribbon. Xref schedule: a schedule that lives in an attached drawing opens the window with the Xref source named, and its rows stay read-only (BUG-1009 already stops an Xref row highlighting a pipe in the current drawing). REFEDIT: as for any open window; I did not read the REFEDIT rule for this window beyond its guard in `PitScheduleCommand`. This is why question 3 asks you.
10. **Cancel, Escape, Undo and Redo.** Required result: Cancel or Escape in the window, or closing it with nothing changed, leaves the drawing identical and adds no U step (the earlier BUG-391 / PitScheduleCloseFlushRule family: after a window with no change the first U must not say "PITSCHEDULE"). U after a change made in the window behaves as it does today when you open the window from the ribbon. Pressing Escape during the double-click itself (before the window shows) leaves nothing started. NOT tested; no AutoCAD run for this card.
11. **Save and reopen.** Nothing new is stored by the double-click, so nothing to save. The plain check is that the schedule and its link survive QSAVE and reopen exactly as they do now, then a double-click works the same on the reopened drawing. NOT proven.
12. **Assets, data and Settings.**
    1. Suggested switch: `doubleClick.pitScheduleOpensWindow`, shown on the Switches tab with "Default: on." OFF returns AutoCAD's text editor exactly as it is today. This follows the pattern of the other double-click switches already in the code (`doubleClick.opensEditWindow`, `doubleClick.sourceEditWindow`, `doubleClick.sourceStopsAttributeEditorFirst`; I saw the names in the code, not their defaults).
    2. **Default is your call (question 1).** On 22 Oct you set the pit-label double-click (`doubleClick.pitLabelStopsAttributeEditorFirst`) to ship OFF until Codex has looked. The D-pack approves this behaviour, which argues for ON; the pit-label precedent argues for OFF until the first Codex look. I recommend ON, because today's behaviour (a blank editor and a table that disagrees with the plan) is a fault, not something to preserve.
    3. No new data. Reads the existing schedule record only. A new test must pin the switch default through both start-up reads, as the other new switches do.
13. **Performance.** One lookup per double-click. Not measured. A large schedule (30 rows seen in earlier runs) is not a concern; a 500-row one is not tested.
14. **Discovery.** A double-click is how a drafter will try it first; the ribbon button stays. Needs: one line in the Pit Schedule help page ("Double-click a row in the placed schedule to open the window at that pit"), one What's New line, and the release notes item 6 caveat ("double-click typing in a placed cell may not reach CE") rewritten. The help page address was not checked. No What's New line exists yet (GUESS: none).
15. **Example drawings and expected results.**
    1. A drawing with a placed schedule of 5 pits, P1 to P5, linked. Double-click the P2 cell: the window opens with P2 selected. No text editor, no "Undefined shape" lines.
    2. Same, double-click the Cover cell on the P4 row: the window opens on P4.
    3. Same with the switch OFF: AutoCAD's text editor opens, as today (control case, so the test would fail on a deliberately broken build).
    4. Double-click the header row: per question 2.
    5. An older drawing with an unlinked schedule: window opens, no row selected, plain message.
    6. Schedule on a locked layer: per question 3.
    7. Schedule in an Xref: per question 3.
    8. Open the window by double-click, press Cancel: one U does not say "PITSCHEDULE".
16. **Older family card.** `CARD_DRAFTS_PIT_SCHEDULE_02NOV.md` covers the window and its ribbon button; `CARD_DRAFT_BUG1105_BUG213_02NOV.md` card 2 (BUG-213, Replace older schedule) also changes the same window's last step, so the two share Codex window work and must be briefed together to avoid two window changes. The older CDEDIT double-click cards (pit, pipe, source) are not read; the pit-schedule row in the list file says a card is needed (G5) and I found none.
17. **Tim's AutoCAD checklist** (copy of a drawing, after it is built and installed):
    1. Open a copy with a placed Pit Schedule (P1 to P5). Double-click the P2 cell. **Right looks like:** the Pit Schedule window opens with P2 selected. **Wrong looks like:** a text editor with a blank box.
    2. Press Cancel. Type `U` once. **Right:** the first U does not say PITSCHEDULE and the drawing does not change.
    3. Double-click the Cover cell on the P4 row. **Right:** the window opens on P4.
    4. Double-click the header row. **Right:** as you decide in question 2.
    5. Lock the schedule's layer, double-click a cell. **Right:** as you decide in question 3; the layer stays locked.
    6. `QSAVE`, close, reopen, double-click P2 again. **Right:** same result.
    7. Turn the switch OFF in Settings, restart AutoCAD (CE reads Settings at start-up), double-click P2. **Right:** AutoCAD's text editor, as before.
    8. Press Escape right after double-clicking. **Right:** nothing opens and nothing changes.
18. **Questions only Tim can answer.**
    1. Context: the default for the new switch. I understand your 22 Oct ruling put the pit-label double-click OFF until Codex looked. Recommendation: ON, because the approved design says so and today's behaviour is broken. On a job: ON means a drafter double-clicks a cell and gets the CE window straight away; OFF means they get the blank text editor until a Codex look turns it on.
    2. Context: a double-click on a header, title or blank cell. Recommendation: open the window at the top with nothing selected (still useful, never wrong). On a job: double-clicking the "COVER" heading opens the window at P1, not the editor.
    3. Context: a schedule on a LOCKED layer, in an Xref or in REFEDIT. Recommendation: open the window read-only with a one-line reason, and never unlock. On a job: a colleague's referenced schedule opens for reading and will not let you change it.
    4. Context: two designs on record (the approved window route, and the older "type into the cell to rename" route in the pilot checklist and tick list). Recommendation: follow the window route only, rename in Edit Pit or the window, and retire the "type into the cell" checklist step. On a job: renaming P5 to C5 is done in the window, and the table and plan label change together.
    5. Context: what the double-click does when the cell's pit is not in the project record (an old or hand-edited table). Recommendation: open the window with no row selected and say so on the command line. On a job: you still get the window and a plain reason, not AutoCAD's blank editor.
19. **NOT proven.**
    1. Built: no. Tested: no. Installed: no. Tim-accepted: no. Codex-accepted: no. Nobody has written code.
    2. I did not confirm how a table's double-click reaches CE. The carpark says the table edit is AutoCAD's own (seen as MTEDIT); the same route in other CE cards (pit, source) works by stopping AutoCAD's own command first (the "StopsAttributeEditorFirst" switches), which is a design I saw named, not one I read or tested for tables. Whether it works for a table cell is the first thing the build must prove in AutoCAD.
    3. The placed schedule is called a "block" in the code and a "table" in the Codex report and the D-pack. I did not read how it is placed, so I do not know which AutoCAD object a click lands on, or how a clicked cell maps to a pit.
    4. The Pit Schedule window's start-at-pit entry does not exist; its design is Codex's.
    5. The "Undefined shape" cause is unknown; this card removes the editor from the normal path but does not explain it, so BUG-623 stays open.
    6. Robot case (brief section 6) is not written. Suggested: place a schedule, type a double-click on the P2 cell, read the window's selected row, and check the command line shows no MTEDIT and no "Undefined shape"; a second case with the switch OFF expects MTEDIT. The "window shows P2 selected" part is something a person must SEE, so a Codex look is needed for that part (RULES 5.7); the "no MTEDIT" part can be read from the command line by the robot.

---

## Skipped items and why

1. **Not written: the Codex window brief for the Pit Schedule window's start-at-pit entry.** Window changes are Codex's, and the card must be approved first.
2. **Not read:** `REGRESSION_LOG.md`, the Codex evidence screenshots (L4-46, L4-49, L4-59), the full Pit Schedule view model, the schedule-link code that handles a changed table cell, the schedule placement code. They are named in field 19 as the first things the build must read.
3. **Not done:** no PR list read (`gh` is not on this tool path); no check of the Structural line (`rel-20261026s`) because this bug is Civil-only.
4. **Not touched:** no git write, no build, no test, no AutoCAD, no robot, no settings files, no other file than this one.
5. **Dropped from the brief's wording:** the brief's name "doubleClick.pitScheduleOpensWindow" is kept as a suggestion only; the name is not checked against the existing switch naming list beyond the three names I saw.
