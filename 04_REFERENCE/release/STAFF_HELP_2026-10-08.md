# CE staff help: one page per job (Friday 9 October 2026, Melbourne time, updated 07:30)

**Installed now: Civil 3.0.40, Manager 1.1.40 and Structural 1.0.110.** Every SEEN mark below names the date and version it was seen on. A mark with only a date was seen on 3.0.34 / 1.0.104 or earlier (7 to 8 Oct); the newer versions contain those steps but nobody re-read them. Codex saw parts of Structural 1.0.110 on 9 Oct (W41, W43, W44) and the versions on 3.0.40 / 1.1.40 / 1.0.110 (W45); the rest is NOT SEEN on that version. Type CEHEALTH to check your own versions. **Tim has accepted nothing.** A step marked **Tim has ruled; not built yet** is a decision, not a fix: it is not in the installed version. A step that says "built" is in the installed version but NOT SEEN unless a mark says otherwise.

1. **How to read the marks.** **SEEN** means Codex watched it work in real AutoCAD on a test copy, on the date shown. Tim has not yet accepted it. **NOT SEEN** means built and unit-tested only. Nobody has watched it in AutoCAD yet. Where the words differ from yours, tell Tim.
2. **The one rule.** Work on a COPY of the job until Tim says otherwise.
3. **F2 runs CLEAN.** In a CE drawing, F2 runs the CE command CLEAN (purge, restyle, regen) instead of opening the text window. Do not press F2 expecting a save. Tim has ruled F2 is left as it is for now ("leave as is for now, commonly used by me to save"); nothing is changing yet. To read the whole command line, type TEXTSCR, then GRAPHSCR to come back.

---

## 1. Place a pit

1. **Start.** Type PIT. CE asks "Specify pit insertion point:". Click where the pit goes.
2. **The New Pit window opens.** The pit number box holds the next free number (for example P8). The cover level is blank. SEEN 7 Oct.
3. **Type the cover level.** The button reads "Continue placement" and stays grey until you do. The window says "Enter the cover level." SEEN 7 Oct.
4. **Leave a level blank if you do not know it.** The window says "Blank value = Unknown. CE does not infer missing levels, depth or geometry." NOT SEEN.
5. **Recall Last** should bring back your last cover level. Codex could not see that button on the window. NOT SEEN.
6. **A number another pit already uses.** A box titled "Pit number already used" says "There is already a pit P1. Type a different number." The window stays open with your entries kept. SEEN 7 Oct.
7. **A look-alike number.** Type "C 2" when C2 exists. A box titled "Check pit number" says "This looks like C2. Continue?" Yes places it as typed. No keeps the window open. SEEN 7 Oct.
8. **Press Continue placement.** CE asks "Specify pit label insertion point:", then "Click to place cover text (Enter = <BR>):". Click, or press Enter for the position shown in the brackets.
9. **Done.** CE prints "Pit placed successfully." then "[CE] Pit placed. Pick the next pit, or press Esc to stop." SEEN 7 Oct.
10. **Place more, or stop.** Click for the next pit, or press Esc. Esc prints "[CE] Stopped. Everything placed stays; U takes back the last one."
11. **Cancel in the window.** CE prints "PIT command cancelled." and draws nothing.
12. **One U takes back one pit** (body, label and cover text together). The U line reads PIT. SEEN 7 Oct.
13. **If you see** "CE could not save its pipe and pit record with this command. It will be saved with your next command." write down what you did just before. Seen once, cause not found (BUG-412).

---

## 2. Draw a pipe

1. **Start.** Type CD. CE asks "Select the first two points to start the polyline, or E to use a line you have drawn."
2. **Pick the pits.** CE asks "Specify first point or [Existing line] [Existing]:" then "Specify second point:". Click the first pit, then the second.
3. **Straight or bent.** CE asks "Select point 3 (or Enter for straight pipe):". Press Enter for a straight pipe.
4. **The New Pipe window opens.** Both invert levels read Unknown and Start Pipe stays grey until you type them. The window says "Enter the invert level for the first end." SEEN 7 Oct.
5. **Type the real levels from your job, then press Start Pipe.**
6. **Pipe ends.** CE may print "[CE] Pipe end moved to the inside wall of P10 (was 225 mm inside the pit)." That is normal. SEEN 7 Oct.
7. **A label with no clear spot.** CE may print "[CE Civil] a pipe's start invert text: no clear spot among its usual positions, left where it is". Move that label by hand. SEEN 7 Oct.
8. **Done.** CE prints "Inserted flow arrow.", "Flow: P10 -> P9" and "[CE] Pipe placed. Pick the next pipe's first point, or press Esc to stop." SEEN 7 Oct.
9. **Stop.** Press Esc. CE prints "[CE] Stopped. Everything placed stays; U takes back the last one."
10. **Cancel in the window.** CE prints "[CE] CD command cancelled." and draws nothing.
11. **One U takes back the whole pipe** (pipe, flow arrow and both invert labels). The U line reads CD. SEEN 7 Oct.
12. **An older pipe** may ask a question when you edit it later. See "Edit a pipe".
13. **Same level typed at both ends.** The window says "Pipe is essentially flat - no measurable fall" and "Warnings are informational - the pipe has been saved." The label reads "100 DIA. UPVC PIPE FLAT" (your size and material) with no grade figure. SEEN 3.0.37, 8 Oct (W32): U echoes CD and the pipe goes; REDO says "Everything has been redone" and the FLAT label returns. (3.0.36 and earlier read "AT 1 IN 100".) Tim ruled "5. yes". **Known gap:** the Edit Pipe window still shows the "1 in 100" grade selector beside the two equal inverts (seen again on 3.0.40, W45). 3.0.40 adds a read-only preview line "Grade: FLAT (same inverts)": built, NOT SEEN. Write down what your label says.
14. **A pipe with its own grade.** In New Pipe set Pipe grade to "Set my own", type 1 in 100, tick "I know one end - work the other out from the grade" and type one invert. The window shows the other end (20.000 gave 19.91). SEEN 3.0.38, 8 Oct (W34 to W36).

---

## 3. Edit a pit

1. **Three ways in.** Type PITEDIT ("Select pit block to edit:"; SEEN 8 Oct), or double-click a pit's cover text (SEEN 7 Oct), or type CDEDIT ("Select a pit, pipe, source or CE text to edit: "; NOT SEEN). All open the Edit Pit window. **Do not double-click the pit's plan label:** on 3.0.35 that opened AutoCAD's own attribute editor, not Edit Pit (Codex W20, BUG-430). Use PITEDIT.
2. **Change what you need,** then press Save. CE prints "Pit updated."
3. **Capitals.** Type p10 over P10 and CE saves capital P10. SEEN 8 Oct.
4. **A number another pit uses is refused.** Type P9 when a P9 exists. CE prints "[CE] Pit number P9 is already used by another pit (P9), so this pit keeps P10. Type a number no other pit uses. Nothing was changed. Your entries have been kept — correct them and press Update again." SEEN 8 Oct. On 3.0.35 the line ends "press Save again." SEEN W20 (typed 2 beside P2).
5. **The same thing without the P.** Type 9 when P9 exists. CE prints "[CE] Pit number 9 is the same pit number as P9 (another pit), so this pit keeps P10. Type a number no other pit uses. Nothing was changed. Your entries have been kept — correct them and press Update again." SEEN 8 Oct.
6. **After a refusal the window opens again** with your typed number still in it. Fix the number and press Save, or press Cancel. The button reads "Save", though the line says "Update".
7. **A number nobody uses** saves with "Pit updated." The pit's row and its pipes' From and To should follow. SEEN 8 Oct on 3.0.34 (Codex W18), on a pit WITH pipes: the plan label, the schedule row and the pipe's From all read 77. The rename's own undo is NOT SEEN.
8. **Undo.** One U takes it back (the U line reads PITEDIT). SEEN 8 Oct.
9. **Pilot ground rule: renumber pits only in Edit Pit** (Tim, INT-069). Never renumber in the Pit Schedule window. See "The Pit Schedule", step 9.

---

## 4. Edit a pipe

1. **Start.** Type CDEDIT, then pick the pipe. (PIPEEDIT also asks "Select pipe to edit: ".)
2. **A pipe drawn in an older CE may ask first.** CE highlights a text and asks "Is the highlighted text "..." this pipe's label? [Yes/No] <Yes>:". Answer Yes only if it really is that pipe's label. SEEN 7 Oct.
3. **If you answer No or press Esc,** CE prints "[CE] Pipe not opened for editing: this pipe was drawn with an older version of CE, before CE recorded which of its texts is the pipe label, and CE will not guess. Nothing was changed. Your drawing is fine and nothing needs deleting. Edit the pipe again and answer Yes when CE highlights its label, or redraw the pipe with CD if it must change." SEEN 7 Oct.
4. **The Edit Pipe window opens.** Change the size, levels or labels, then press Save. CE prints "Pipe updated." SEEN 3.0.37, 8 Oct (W32) with nothing changed, on a flat pipe: "[CE] Warning: Pipe is essentially flat - no measurable fall", then "Pipe updated.", and the label stayed FLAT. Changing a value and then saving: NOT SEEN.
5. **Undo.** One U takes the edit back. SEEN 3.0.37 (W32) for that unchanged save: the U line read PIPEEDIT and the label stayed FLAT. A changed save: NOT SEEN.
6. **Pick the pipe line itself.** PIPEEDIT asks "Select pipe to edit:". A pick that misses the line says "That is not a pipe. Click the pipe line or its outline." and asks again. SEEN 3.0.38, 8 Oct (W36).
7. **Watch the size suggestion.** If the pit's ground level is not recorded, the size strip used to say a size works without checking cover. Built in 3.0.36: it now says out loud that cover was not checked, and an unknown ground level is never read as level 0. Built in 3.0.38: a trench grate placed with no cover level stores a blank, not 0.000. NOT SEEN. Check cover yourself.

---

## 5. The Pit Schedule

1. **Open it.** Type PITSCHEDULE. The Rows tab lists every pit, with a header like "Will be placed: 27 rows · All sets · All systems" and "Drawing check: 95 data issues may affect this schedule" (your numbers will differ). Opening it changes nothing in the drawing. SEEN 5 Oct; the header SEEN 3.0.38, 8 Oct (W33, W34).
2. **Change a cell.** Click the cell, press F2 (inside this window F2 edits the cell), type the new value, press Enter. The footer says "Override enabled for linked row." and the row shows override styling. SEEN 8 Oct.
3. **What that means.** The row holds the value you typed, but the PLAN does not change yet. A typed inlet level sat as an override with the plan unchanged, and "Continue to Place / update" stayed grey. SEEN 3.0.38, 8 Oct (W33, W34). The plan is written when you choose Stop overriding (step 5) and close the window (step 11). On 3.0.34 a cover typed this way read CL 18.82 on the plan label by the end of the test (W16).
4. **Right-click a row** for the menu: Restore Cell, Restore Row, Enable Row Override, Stop overriding.
5. **Stop overriding.** Hover text: "Stop treating this row as an override. The values you typed stay." The footer then reads "Stopped overriding this row. The values you typed stay." The cover stays as typed and the override styling goes. SEEN 8 Oct, and the footer again on 3.0.35 (W20). On 3.0.35 the override tick stayed ticked on the pit-number cell after Stop overriding (BUG-430, open).
6. **Restore Row** clears every override on the row and puts every cell back to the pit's own value. NOT SEEN.
7. **Close the window.** One U takes back the whole Pit Schedule visit (every edit made in it), not just the last click. The U line reads PITSCHEDULE. SEEN 8 Oct; on 3.0.35 REDO after it also said "Everything has been redone" (W20). On 3.0.38 the typed level and the red CHECK marker (step 11) went back together and returned together (W35, W36).
8. **A placed table.** A cell on a locked layer, in an Xref or in a reference edit is never written. CE names what it skipped. NOT SEEN.
9. **Pit numbers: use Edit Pit, not this window.** On 7 Oct (3.0.33) this window accepted a bare "2" over P1 and lower-case "p1" with no warning (BUG-420, not retested). Edit Pit refuses both. Tim's ruling: a FREE number typed in this window waits as a pending override until you press Review, Update or Stop overriding (that is how it works now). Civil 3.0.35 carries a window fix (PR 766) that nobody has seen in AutoCAD, and BUG-426 (open) says a typed 9 then p1 still shows 9. **Seen on 3.0.35 (W20):** a bare 2, p2 or P2 over P1 was refused ("[CE] Pit number 2 is the same pit number as P2 (another pit), so this pit keeps P1. Type a number no other pit uses."); p1 and "P 1" stayed P1; "P 2" was accepted with "[CE] P 2 looks like P2 (another pit). Check the numbering." The BUG-426 case was not reached. A fix for the "typed 9, then p1 still shows 9" case came in 3.0.36 (PR 786): NOT SEEN. So the ground rule stands: renumber only in Edit Pit.
10. **Warnings column.** A warning is information. It never stops you. See "How to read a warning".
11. **A level typed on a pipe with its own grade (3.0.38).** On a pipe drawn with "Set my own" grade 1 in 100, click the downstream pit's "IL (Inlet)" cell, press F2, type a slightly different level (19.85 against 19.91 was used), press Enter, right-click the row and choose Stop overriding, then Close (do not press Continue to Place / update). The footer says "Override enabled for linked row." then "Stopped overriding this row. The values you typed stay." The plan then shows your level and a red marker like "CHECK: LABEL GRADE 1 IN 100, LEVELS GIVE ABOUT 1 IN 61". The command line says "[CE] Pipe P10-P9: the label grade is 1 IN 100 but its levels now give about 1 IN 61. Only the end at P9 changed; the far end was not moved. Check the grade, or set it in Edit Pipe (CDEDIT)." SEEN 3.0.38, 8 Oct (W35, W36). The line says the label grade is still 1 IN 100: whether that is what Tim meant is for him to judge. The marker's layer, that it does not plot, and Edit Pipe Save removing it: NOT SEEN. Without Stop overriding nothing is written (W33, W34).

---

## 6. Undo and Cancel

1. **One U takes back one whole CE action.** A pit with its label and cover text, a pipe with its arrow and labels, a beam, a Pit Schedule visit: each is one U.
2. **U prints the name of what it took back.** Names seen: PIT, CD, PIPEEDIT, PITEDIT, PITSCHEDULE, CDIMPORTXCIVIL, MOVE, COPY, ERASE, FEDIT, BTX, C1 GROUP, Grip Edit, CDDISCIPLINE. (Codex did not check by eye that an erased object returns.) If the name is not what you meant, tell Tim.
3. **To REDO, wait.** After U, wait about 10 seconds with nothing typed (Codex waited 12). Then type REDO. CE prints "Everything has been redone". SEEN 7 Oct. On Structural 1.0.105 the same was seen for beam command 1, FEDIT (with the Bracing panel open), ERASE of a footing outline, and FST delete PF2 then U (W19). Also SEEN: a flat pipe (3.0.37, W32), the whole X-Civil import (3.0.36, W29), the C1 column (1.0.107, W31) and a Pit Schedule visit with its CHECK marker (3.0.38, W35, W36). **One mouse click on empty drawing, then Esc twice, in the wait did not stop REDO** (W36).
4. **Type nothing between U and REDO.** Any typed command in between ends REDO: REGEN gave "Nothing to redo" (3.0.38, W35). That is AutoCAD's rule, not a CE fault. A LIST, TEXTSCR, GRAPHSCR, REGEN or a mouse-wheel zoom also leaves its own undo step, so one U may take back only that (Codex saw U echo GRAPHSCR, INTELLIZOOM and REGEN). Look at the U line. Do nothing between your last edit and the U you mean.
5. **Do not rely on REDO after switching drawing tabs.** It says "Nothing to redo". Seen 7 Oct. This is a known limit.
6. **Cancel with Esc.** PIT prints "PIT command cancelled.", CD prints "[CE] CD command cancelled.", a beam prints "Beam cancelled. Nothing was written."
7. **Windows.** Cancel writes nothing. In the Foundations window (FST), Esc does not close it: press the Cancel button.
8. **CDRENUMBER asks "Apply? [Yes/No]" and the default is No.** Pressing Enter prints "Renumber cancelled - nothing changed." Type Yes to apply. Whether one U takes a whole applied renumber back is NOT SEEN.
9. **A refusal changes nothing,** so you do not need U after it.

---

## 7. Settings: where they live and how to change one

1. **Civil settings.** Type CDS. The window "Creative Engineering | Settings" has the tabs Drafting, Pipes & Pits, Design, Survey, Display and Advanced.
2. **Example.** Survey tab, "Last cover level in New Pit". It reads "Leave cover level blank". Choose "Propose last cover level" for the old behaviour. SEEN 7 Oct (read only).
3. **Another example.** Drafting tab, "Grade note tolerance" (starts at 10 per cent). NOT SEEN.
4. **Change a value, then press Save.** Cancel keeps what was saved. "Reset all tabs" fills every tab with CE's starting values and saves nothing until you press Save. History... opens the settings history.
5. **Council and project rules.** Type CDRULEBOOK to change the project drop, the council or the cover override.
6. **Structural settings.** Type CESETTINGS. NOT SEEN.
7. **Settings stay when you go back a version.** They are kept on your computer, not in the drawing.
8. **Not on the Settings window yet.** The steep-pipe limit, the downpipe values, the two pit-outlet speed figures (1.5 and 2.0 m/s), the Detention and Markup values and the switch for the CHECK marker live only in the settings file for now. If a message says "Settings" and you cannot find the row, that is why. Do not open the Settings window on Day 1.
9. **Structural's settings file grows once after an upgrade.** The first AutoCAD start on a new Structural version that adds Settings rows writes those default rows into CS_Settings.json. None of your values change. One line in the CE log says so (seen for 1.0.107); the command line does not. 1.0.110 added 13 new default rows once at its first start (28,361 to 28,872 bytes) and changed nothing you set.

---

## 8. How to read a warning

1. **A warning informs and is recorded. It does not stop you.** Tim's rule: only two things are hard blocks (deleting the spine IDs, and pushing an update on a failed build).
2. **Look-alike pit number.** "C 2 looks like C2 (another pit). Check the numbering." The rename goes ahead.
3. **Pit Schedule WARNING column.** For example "LABEL GRADE 1 IN 100, LEVELS GIVE ABOUT 1 IN 67". The pipe label and the levels disagree by more than the tolerance. NOT SEEN (the window said "No warnings" while a typed level was still waiting as an override, W33). The same disagreement also shows on the plan as the red CHECK marker (Pit Schedule, step 11): SEEN 3.0.38.
4. **CDRULES.** Type CDRULES. CE asks "[All/Problems/Values/Explain/pReview/Source] <Problems>:". Type A for everything. The first line reads like "[CE] CDRULES: 4 finding(s) across 4 rules; 0 warnings, 3 unknown, 1 pass". SEEN 7 Oct.
5. **Unknown is not a pass.** "unknown" means CE could not check, usually because a level is missing. The line ends with a fix, for example "Enter the pit cover level or invert (CDEDIT)".
6. **Steep pipe.** CDFIXFLATPIPES may add "steeper than 1 in 10 (Settings warning) - check it" (built in 3.0.34). NOT SEEN: no test drawing has had a pipe flattened the old way. A pipe typed flat is listed "to check by hand" and CE leaves it alone.
7. **Pipe leaving a pit too fast (built in 3.0.37).** PIPEEDIT and CDRULES (rule R-31) may say "Pipe P3-P2 leaves P3 at <speed> m/s: over the 2.0 m/s limit in AS/NZS 3500.3." or the 1.5 m/s recommended sentence. A warning only. NOT SEEN.
8. **Detention pipe flatter than 1 in 200 (pipes 225 mm and larger; built in 3.0.38).** A warning in CDRULES (rule R-32). The "orifice not required at 12 L/s or less" figure is blank per council, so CE sizes as before. NOT SEEN.
9. **Kingston commercial lot under 1000 m2 (built in 3.0.37).** Minor storm 1 in 10, time of concentration 7 minutes. A bigger lot says the time of concentration is Unknown. NOT SEEN. Saved Kingston CDRULES runs show Stale once: run CDRULES again.
10. **What to do.** Read the line. Fix it if it is yours to fix. If it looks wrong as an engineer, stop and tell Tim.

---

## 9. When CE refuses

1. **A refusal changes nothing.** The command line says why and says "Nothing was changed" or "nothing was unlocked".
2. **Read the whole line.** Type TEXTSCR to see it all, then GRAPHSCR. F2 runs CLEAN in a CE drawing (see the top of this page).
3. **Pit number in use.** See "Edit a pit", steps 4 and 5. Type a number no other pit uses.
4. **Support block.** STS1 on a line says "Object must be a support block." On an ordinary block it says "That is not a support block, so nothing changed. Type the command again and pick a support block." SEEN 8 Oct. On a support block whose layer is locked, 1.0.105 and later say "STS1 could not switch this support block because its layer ... is locked. Nothing was changed. Unlock the layer, then run STS1 again." (1.0.104 printed "eOnLockedLayer".) NOT SEEN.
5. **Locked layers, Xrefs and reference edits are never changed.** CE skips them and says so. It will not unlock a layer. For example Foundations re-link says "(nothing was unlocked)". From 3.0.36 the X-Civil and LandXML imports (CDIMPORTXCIVIL) skip an item that needs a locked layer and say so in one sentence. Unlock the layer yourself only if you meant to change that object. NOT SEEN.
6. **Do not repeat a refused command over and over.** Change the cause (the number, the layer, the pick) first.
7. **If the reason does not make sense,** write down the exact line and tell Tim.

---

## 10. Send a support report

1. **When.** Something looks wrong and you want Tim to see your logs.
2. **Type CESUPPORT.** CE prints "[CESUPPORT] Creating support bundle..." then "[CESUPPORT] Support file saved on this PC: ..." with the file path. SEEN 3.0.37, 8 Oct (W32) and 3.0.40, 9 Oct (W45).
3. **It NEVER uploads by itself.** CE prints "It has not been sent anywhere. If support asks for it, send it yourself (email, or the job's support folder). Drawing paths inside it are cut to job numbers and your login and computer name are coded." SEEN 3.0.37 (W32). Send the file yourself. (3.0.35 and earlier said it would be uploaded; that is no longer true.)
4. **The file name is coded.** It reads like CE_SUPPORT_sOkhYs-36_stPtHp_20261008_001123.zip: no login, no computer name (SEEN 3.0.37, W32). The zip is made in a "CE Support" folder on your Desktop. A last line says "The zip lists what it holds in WHAT_IS_IN_THIS_ZIP.txt (10 files, 8 left out)." **On 3.0.40 the zip holds 10 files plus that index** (the CE logs of the last 14 days among them); the 8 items left out are listed with reasons, and no real login or computer name is inside. SEEN 3.0.40, 9 Oct (W45). On 3.0.37 it held only the index (856 bytes). Keep your own screenshots and notes as well.
5. **Where it goes.** For the pilot (Max): save the support report and your notes in the SharePoint folder **CE Plugin Pilot Results** in the Engineering library (https://residentialstructures.sharepoint.com/Engineering/CE%20Plugin%20Pilot%20Results, or the synced copy of that folder in your Engineering library), in a sub-folder named by the date, for example 2026-10-12. Job numbers only: no client names, no addresses. **OPEN ITEM: Tim has not yet confirmed that Max can write to the Engineering library.** If you cannot save there, tell Tim. For anyone else no support route is recorded: send it to Tim.
6. **Write these seven things down too.** Version (type CEHEALTH and copy the lines), the exact command and clicks, the drawing name, what you expected, what you saw (exact words), what one U did, and the time (Melbourne).
7. **Do not send the drawing.** Tim will ask if he needs one. Do not delete CE's log files.
8. **To look at the logs yourself,** type CEMANAGERLOGS. It opens the log folder.

---

## 11. Go back a version

1. **Roll back only if the install itself is broken.** No CE ribbon, AutoCAD crashes or hangs, drawings you made will not open, or every CE command says "Unknown command". One wrong message is a bug report, not a rollback.
2. **Close AutoCAD first,** and make sure no Codex test is running.
3. **Civil and Manager go back together.** They share a file and one new with one old gives a missing CE ribbon. **Structural goes back alone.** (From 3.0.37 Manager's own Roll Back and Approve buttons treat Civil and Manager as one pair; NOT SEEN.)
4. **The method.** Rename the live folder to a ".backup" name (never delete it), rename the matching "_PRE_" backup to the live name, read the version off the file, start AutoCAD.
5. **The backups on this PC (names read from the folder 9 Oct; the older versions inside were not opened).** Each install kept the build it replaced, named by that build's commit. Newest first: Civil and Manager `_PRE_e8e9e0dc_20261009-065432` (3.0.39 and 1.1.39, the pair to use to leave 3.0.40 and 1.1.40) and `_PRE_3e59c62a_20261009-033137` (3.0.38 and 1.1.38); Structural `CE_STRUC_SUITE_PRE_5aff4fe6_20261009-055704.backup` (1.0.109, the one to use to leave 1.0.110) and `_PRE_d7879e79_20261009-035145` (1.0.108). Those six were opened and their versions read on 9 Oct. Older: Civil and Manager pairs: `_PRE_62514a67_20261008-035945` (3.0.34 and 1.1.34), `_PRE_49730bfb_20261008-063137` (3.0.35 and 1.1.35), `_PRE_86aa7e2a_20261008-105736` (3.0.36 and 1.1.36) and `_PRE_8946e185_20261008-123615` (3.0.37 and 1.1.37). Structural: `CE_STRUC_SUITE_PRE_ebc1654d_20261008-042112.backup` (1.0.104), `_PRE_2f30d176_20261008-070646` (1.0.105), `_PRE_7ff53894_20261008-094538` (1.0.106) and `_PRE_90ce00bc_20261008-122853` (1.0.107). The commit-to-version match comes from the test reports; if unsure, read the file's version before starting AutoCAD.
6. **Your settings are not touched.** But a Structural version that added Settings rows has already written them into your file (see "Settings", step 9); an older Structural reads the file fine.
7. **Manager "Roll Back Release": do NOT press it.** Pressed today it changes nothing: the office record holds no earlier build and Manager says "No trusted rollback target has been recorded yet." Whether the installer accepts an older version is unproven. Use the steps above.
8. **The full steps, with the exact commands, are in ROLLBACK_GUIDE_2026-10-07.md** in this folder. Use that file. This page is only a summary.

---

## 12. Structural (installed 1.0.110): roof first, footings last

**Seen status.** Marks name the version they were seen on: 1.0.104 (W17), 1.0.105 (W19), 1.0.107 (W31) and, on 9 Oct, 1.0.110 (W41 roof, W43 columns, W44 reo bar and footings). Anything without a mark is NOT SEEN on 1.0.110. The newer versions contain the older steps but nobody re-read them.

**ROOF**

1. **BT1, bracing truss.** Type BT1. CE prints "=== BT1 - BRACING TRUSS (Universal BRACING block) ===" and, the first time in a drawing, "The BRACING block is loaded into this drawing." The repeat does not print it again. Then "Specify first point of bracing truss:". Esc prints "Operation cancelled." SEEN 8 Oct (1.0.104, W17). On 1.0.110 the next prompts are "Specify second point of bracing (drag preview, ENTER for 0°/2700) [Zero]:", "Bracing truss number [1-9] <1>:", "Preview length: 4000 rotation: 0°" and, when CE cannot tell which side the brace goes, "CE could not tell from the Xref walls which side the brace should go. Flip it by hand if it is on the wrong side." then "Toggle flip? [Yes/No]:". Prompts, U/REDO and Esc SEEN 1.0.110, 9 Oct (W41).
2. **BT1, after the first point.** CE asks "Specify second point of bracing (drag preview, ENTER for 0°/2700): " and "Bracing truss number [1-9] <1>: ". NOT SEEN.
3. **A brace over 2700 mm keeps its drawn length and warns.** This is in 1.0.105 and later (Tim, INT-066 C: "keep the drawn length and warn"). The finalizers checked it in the code; Codex has not seen it in AutoCAD: **NOT SEEN.** From 1.0.106 BB warns the same way as AB, and the limit is judged in millimetres whatever the drawing units. Markup AI refuses a brace if the default brace length in Settings is blank. An older bracing block that does not store its length is left as it is, with one line saying so.
4. **Hidden and OFF.** CSROOFSETOUT (roof area setout) and CSPOINTLOAD (roof point loads): if typed, CE says it is switched off in Settings and draws nothing. SEEN 1.0.107 (W31): "The roof area setout is switched off in Settings (Roof area setout), so nothing was drawn. The Settings page for it is still to be built." (two sentences, not one). CSLEVELCARRY (carry a level from the other drawing, new in 1.0.110) is also hidden and OFF by default and prints a switched-off sentence. These sentences all end "The Settings page for it is still to be built." (a wording gap, BUG-453).

**UPPER FLOORS**

5. **Beam command 1.** (There is no command called BEAM. The beam commands are 1, 2, 4, 5 and BDL.) Type 1. CE asks "Select the first support (a support block or a line), or press Enter to pick points:". Press Enter, then "Specify the START point:", "Specify the END point or [Object]:", "Enter text <bd1>:" (Enter takes it), and "Beam preview [Accept/Cancel] <Accept>:". Each shows once. SEEN 7 Oct. Result "Beam placed. One UNDO removes the complete beam." One U removes it; REDO after a wait returns it (1.0.105, W19). A second run cancelled at the first question prints "Beam cancelled. Nothing was written." SEEN 7 Oct.
6. **C1 and TS1, the column commands.** C1 asks "Specify insertion point for C1:", then AutoCAD's rotate questions, then "Pick desired support text location (auto left/right/top/bottom):". Click a point, or press Enter. With Enter, CE says "Label on the right: enter its text, then click where it goes." Type the number, click where the label goes and answer "Top or Bottom" with Enter. The "C1" label appears (fixed in 1.0.110; it was missing before). A bare Enter at the number question exits and leaves the column without a label. Esc removes the half-placed column in one run; in another, Esc at the support text step kept the column and printed "Support text command failed: Command cancelled." (needs Tim's choice). One U takes the column and its label away together. Your current layer comes back to what it was. SEEN 1.0.110, 9 Oct, 06:05 to 06:09 (W43: C1 with a pick, C1 with Enter, TS1); layer and U line also SEEN 1.0.107 (W31).
7. **BTX, beam text to MTEXT.** Type BTX. CE asks "Select beam TEXT/MTEXT to convert:". Select text and CE asks "Choose suffix [NONE/CANT/CONT/BOTH/LOWER/PORTAL/PF/OTHER] <NONE>:". Result: "BTX done: 1 TEXT changed to MTEXT, 0 MTEXT changed to TEXT, 0 skipped." One U takes it back. SEEN 8 Oct (1.0.104).
8. **BTX with nothing in the window.** On 1.0.104 CE printed "0 found" then "There is no TEXT or MTEXT in that window." (SEEN 8 Oct). From 1.0.105 the sentence is "No TEXT or MTEXT was selected. Nothing changed." and a BTX that changes nothing leaves no undo step (from 1.0.106). NOT SEEN.
9. **STS1, change a support block to a tagged triple stud.** Type STS1. CE asks "Select support block:". Picking a line says "Object must be a support block." Picking an ordinary block says "That is not a support block, so nothing changed. Type the command again and pick a support block." SEEN 8 Oct (1.0.104). A support block on a locked layer now says so in plain words and changes nothing (1.0.105 and later; see "When CE refuses", step 4). Picking a real, unlocked support block: NOT SEEN.
10. **Hidden and OFF.** CSFLOORSETOUT (floor setout) and CSFRAMINGLEGEND (framing legend), both new in 1.0.108. CSFLOORSETOUT prints a "switched off in Settings" sentence ending "The Settings page for it is still to be built." (reported on 1.0.110, BUG-453); CSFRAMINGLEGEND: NOT SEEN. The framing legend title height now comes from Settings (1.0.110): NOT SEEN. CSLINTELPROPOSE (lintel proposals): SEEN 1.0.107 (W31), the same two-sentence "switched off in Settings" reply.
11. **Sheets palette, Sync.** From 1.0.106 sheet sync skips a drawing a colleague holds open and names it. The log line carries no colleague login. NOT SEEN.

**GROUND FLOOR**

12. **CSREOBAR.** Type CSREOBAR. CE asks "Bar size", "Number of bars <8>:", "Spacing (mm) <200>:", "Face [Top/Bottom/tAndB] <Bottom>:", "Start of the bar extent:" and "End of the bar extent:", then shows "Preview: BM1  8-N12-200 CTS x 4000 LG, BOTTOM" and asks "Place this reo bar? [Yes/No] <Yes>:". Each default shows once. One U removes the bar and REDO restores it. SEEN 1.0.110, 9 Oct, 06:32 (W44); the defaults were also SEEN 1.0.102 (5 Oct, W11c).
13. **ANY LEVEL: RC, revision cloud.** Type RC. CE asks "Keep OSNAP ON? [Yes/No] <No>:", then the normal AutoCAD revision cloud questions. A rectangular cloud is drawn. One U removes it. SEEN 7 Oct.

**FOOTINGS (last)**

14. **FSF, strip footing.** Type FSF. "Enter text <SF1>:", then only if that mark has no size yet "Enter width for SF 1 <300>:", then "Enter depth <0 to skip>:". SEEN 1.0.102 and 1.0.103 (W15). On 1.0.110 it asks "Select centerline (Line/Polyline/Arc) or press Enter for 2-point line:" and pressing Enter there ended the command silently with no "Specify start point:" (seen twice, BUG-454). Pick a line or polyline instead; finishing a strip on 1.0.110 is NOT SEEN. The strip-footing layer tidy-up (SF, BSF, STRIPLAYERSMERGE) is built in 1.0.106 and runs quietly: NOT SEEN.
15. **FADOPT, adopt a footing or beam with no known width (1.0.107).** CE now ASKS: "The width of ... is not known. Width in mm <300>:" (shown once; Enter takes the Settings value 300 mm, screw pile 150 mm). NOT SEEN.
16. **FEDIT.** Type FEDIT. CE asks "Select a footing to edit:". Pick the footing outline. CE prints "[FEDIT] You picked CE's outline: editing PF1, the footing nearest your pick." then "[FEDIT] Current: PF1, Pad footing, 600x600".
17. **FEDIT questions.** "Enter new label text <PF1>: ", "Enter new X size <600>: ", "Enter new Y size <600>: ", "Enter new depth <0>: ", then the footing type. CE redraws and prints "[FEDIT] PF1 updated." One U takes it back; REDO after a wait brings the new size back. SEEN 8 Oct. On 1.0.105 FEDIT to 700x700 with the Bracing panel open: U echo FEDIT, REDO said "Everything has been redone" (W19). On 1.0.110 the size 700 persisted through U and REDO and a second FEDIT read "Current: PF5, Pad footing, 700x600"; the last question reads "Change footing type? [Yes/No] <No>:". SEEN 1.0.110, 9 Oct, 06:40 (W44).
18. **After a grip or STRETCH resize of a footing,** every size line now reads millimetres to one decimal ("PF1 is now 700 x 600 mm."; a 24-inch pad reads 609.6 in both lines), from 1.0.105. NOT SEEN.
19. **Propose footings.** Typing CSFDNPROPOSE prints only "Propose footings is not switched on in this version. Nothing was proposed or drawn." It is switched off on purpose. SEEN 8 Oct (1.0.104).
20. **FPFC, pad footing.** Type FPFC. With an existing PF1 it asks "Warning: Label 'PF1' already exists. Use anyway? [Yes/No/Increment] <Increment>:". Enter gives "Auto-incremented to 'PF5'.", then "Specify insertion point (center):" and "Additional rotation around center <0>:", then "[FOUNDATION] Redrew footing system 'Footing Network': 5 footings. Nothing needs attention." No size questions are asked. The pad is drawn and numbered (PF5) but no label text was visible at the zoom Codex used (BUG-454). SEEN 1.0.110, 9 Oct (W44).

---

## Gaps for the writer's reviewer

1. **Edit Pipe window.** Codex saw Save with nothing changed on a flat pipe (3.0.37, W32). No Codex evidence of a changed value being saved. CDEDIT's prompt text comes from the source.
2. **Pit placement button wording.** The source calls the New Pit button "Place Pit" in one place and "Continue placement" in another. I used "Continue placement" because Codex saw it.
3. **CESUPPORT.** Codex ran it on 3.0.37 (W32) and 3.0.40 (W45): the wording, the Desktop "CE Support" folder, the coded name, the 10 files plus index and the list of 8 left-out items are seen (W45). What the cut-down drawing paths inside look like was not stated to me. No colleague support route is recorded, so I said "send it to Tim".
4. **Structural settings (CESETTINGS).** Found in the source. Nobody has seen its window.
5. **RC.** The command list calls it "Revision Cloud" in the Annotation group. I could not find where it sits in the roof-down order, so I put it under "any level".
6. **STS1 success.** Codex only saw refusals. Nothing records a real support block being switched.
7. **FEDIT footing-type question.** The exact words of the last FEDIT question were not in the evidence, so I did not quote them.
8. **The 12 s REDO wait.** Codex used 12 seconds. I wrote "about 10". The real minimum is not recorded.
9. **Rollback guide.** `ROLLBACK_GUIDE_2026-10-07.md` was refreshed at 07:30 on 9 Oct for the installed 3.0.40, 1.1.40 and 1.0.110. The six newest backups were opened and their versions read; the older ones were not.
10. **Pit Schedule window renumbering.** BUG-420 was retested on 3.0.35 (W20): the refusals were seen (page 5, step 9). The ground rule stays because it is Tim's ruling (INT-069) and the BUG-426 case, with its 3.0.36 fix, was not reached.
11. **Pit Schedule menu items** Restore Cell, Restore Row and Enable Row Override are read from the window's source. Only Stop overriding was seen.
12. **Hidden commands.** CSLEVELCARRY, CSROOFSETOUT and CSFLOORSETOUT were reported (1.0.110) to print a "switched off in Settings" sentence ending "The Settings page for it is still to be built." (BUG-453). The exact full wording of CSLEVELCARRY and CSFLOORSETOUT was not relayed to me, so I quote only the ending. CSFRAMINGLEGEND: nobody has typed it.
13. **Pit-outlet and detention warning words.** They come from the C-23 finalizer report and the C-23 and C-24 test lists, not from a screen.
