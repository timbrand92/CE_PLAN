# CE staff help: one page per job (Thursday 8 October 2026, Melbourne time)

**Installed now: Civil 3.0.35, Manager 1.1.35 and Structural 1.0.104** (Structural 1.0.105 is to follow). Every SEEN mark below was seen on 3.0.34 / 1.0.104 or earlier; no Codex pass has seen 3.0.35 yet. Type CEHEALTH to check your own versions. A step marked **Tim has ruled; not built yet** is a decision, not a fix: it is not in the installed version.

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
13. **Same level typed at both ends.** The window says "Pipe is essentially flat - no measurable fall" and the pipe is saved, but today the label still reads "1 IN 100" (BUG-427, seen W18). **Tim has ruled; not built yet:** the label will read FLAT with no grade figure (Option A; Tim to confirm). Write down what your label says.

---

## 3. Edit a pit

1. **Three ways in.** Type PITEDIT ("Select pit block to edit:"; SEEN 8 Oct), or double-click a pit's cover text (SEEN 7 Oct), or type CDEDIT ("Select a pit, pipe, source or CE text to edit: "; NOT SEEN). All open the Edit Pit window.
2. **Change what you need,** then press Save. CE prints "Pit updated."
3. **Capitals.** Type p10 over P10 and CE saves capital P10. SEEN 8 Oct.
4. **A number another pit uses is refused.** Type P9 when a P9 exists. CE prints "[CE] Pit number P9 is already used by another pit (P9), so this pit keeps P10. Type a number no other pit uses. Nothing was changed. Your entries have been kept — correct them and press Update again." SEEN 8 Oct.
5. **The same thing without the P.** Type 9 when P9 exists. CE prints "[CE] Pit number 9 is the same pit number as P9 (another pit), so this pit keeps P10. Type a number no other pit uses. Nothing was changed. Your entries have been kept — correct them and press Update again." SEEN 8 Oct.
6. **After a refusal the window opens again** with your typed number still in it. Fix the number and press Save, or press Cancel. The button reads "Save", though the line says "Update".
7. **A number nobody uses** saves with "Pit updated." The pit's row and its pipes' From and To should follow. NOT SEEN: the pit Codex used had no pipes.
8. **Undo.** One U takes it back (the U line reads PITEDIT). SEEN 8 Oct.
9. **Pilot ground rule: renumber pits only in Edit Pit** (Tim, INT-069). Never renumber in the Pit Schedule window. See "The Pit Schedule", step 9.

---

## 4. Edit a pipe

1. **Start.** Type CDEDIT, then pick the pipe. (PIPEEDIT also asks "Select pipe to edit: ".)
2. **A pipe drawn in an older CE may ask first.** CE highlights a text and asks "Is the highlighted text "..." this pipe's label? [Yes/No] <Yes>:". Answer Yes only if it really is that pipe's label. SEEN 7 Oct.
3. **If you answer No or press Esc,** CE prints "[CE] Pipe not opened for editing: this pipe was drawn with an older version of CE, before CE recorded which of its texts is the pipe label, and CE will not guess. Nothing was changed. Your drawing is fine and nothing needs deleting. Edit the pipe again and answer Yes when CE highlights its label, or redraw the pipe with CD if it must change." SEEN 7 Oct.
4. **The Edit Pipe window opens.** Change the size, levels or labels, then press Save. CE prints "Pipe updated." NOT SEEN (Codex was stopped by the older-pipe question).
5. **Undo.** One U should take the edit back. NOT SEEN.
6. **Watch the size suggestion.** If the pit's ground level is not recorded, the size strip may say a size works without checking cover (BUG-422, still open). Check cover yourself.

---

## 5. The Pit Schedule

1. **Open it.** Type PITSCHEDULE. The Rows tab lists every pit. Opening it changes nothing in the drawing. SEEN 5 Oct.
2. **Change a cell.** Click the cell, press F2 (inside this window F2 edits the cell), type the new value, press Enter. The footer says "Override enabled for linked row." and the row shows override styling. SEEN 8 Oct.
3. **What that means.** The row now holds the value you typed. For a cover level the plan label follows (it read CL 18.82 after the test). SEEN 8 Oct.
4. **Right-click a row** for the menu: Restore Cell, Restore Row, Enable Row Override, Stop overriding.
5. **Stop overriding.** Hover text: "Stop treating this row as an override. The values you typed stay." The footer then reads "Stopped overriding this row. The values you typed stay." The cover stays as typed and the override styling goes. SEEN 8 Oct.
6. **Restore Row** clears every override on the row and puts every cell back to the pit's own value. NOT SEEN.
7. **Close the window.** One U takes back the whole Pit Schedule visit (every edit made in it), not just the last click. The U line reads PITSCHEDULE. SEEN 8 Oct.
8. **A placed table.** A cell on a locked layer, in an Xref or in a reference edit is never written. CE names what it skipped. NOT SEEN.
9. **Pit numbers: use Edit Pit, not this window.** On 7 Oct (3.0.33) this window accepted a bare "2" over P1 and lower-case "p1" with no warning (BUG-420, not retested). Edit Pit refuses both. Tim's ruling: a FREE number typed in this window waits as a pending override until you press Review, Update or Stop overriding (that is how it works now). Civil 3.0.35 carries a window fix (PR 766) that nobody has seen in AutoCAD, and BUG-426 (open) says a typed 9 then p1 still shows 9. So the ground rule stands: renumber only in Edit Pit.
10. **Warnings column.** A warning is information. It never stops you. See "How to read a warning".

---

## 6. Undo and Cancel

1. **One U takes back one whole CE action.** A pit with its label and cover text, a pipe with its arrow and labels, a beam, a Pit Schedule visit: each is one U.
2. **U prints the name of what it took back.** Names seen: PIT, CD, PITEDIT, PITSCHEDULE, MOVE, COPY, ERASE, FEDIT, BTX, Grip Edit, CDDISCIPLINE. (Codex did not check by eye that an erased object returns.) If the name is not what you meant, tell Tim.
3. **To REDO, wait.** After U, wait about 10 seconds with nothing typed or clicked (Codex waited 12). Then type REDO. CE prints "Everything has been redone". SEEN 7 Oct.
4. **Type nothing between U and REDO.** A LIST, TEXTSCR or GRAPHSCR in between becomes the thing U and REDO act on. Codex saw U take back GRAPHSCR instead of PIT.
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
8. **Not on the Settings window yet.** The steep-pipe limit and the downpipe values live only in the settings file for now. If a message says "Settings" and you cannot find the row, that is why.

---

## 8. How to read a warning

1. **A warning informs and is recorded. It does not stop you.** Tim's rule: only two things are hard blocks (deleting the spine IDs, and pushing an update on a failed build).
2. **Look-alike pit number.** "C 2 looks like C2 (another pit). Check the numbering." The rename goes ahead.
3. **Pit Schedule WARNING column.** For example "LABEL GRADE 1 IN 100, LEVELS GIVE ABOUT 1 IN 67". The pipe label and the levels disagree by more than the tolerance. NOT SEEN.
4. **CDRULES.** Type CDRULES. CE asks "[All/Problems/Values/Explain/pReview/Source] <Problems>:". Type A for everything. The first line reads like "[CE] CDRULES: 4 finding(s) across 4 rules; 0 warnings, 3 unknown, 1 pass". SEEN 7 Oct.
5. **Unknown is not a pass.** "unknown" means CE could not check, usually because a level is missing. The line ends with a fix, for example "Enter the pit cover level or invert (CDEDIT)".
6. **Steep pipe.** CDFIXFLATPIPES may add "steeper than 1 in 10 (Settings warning) - check it". NOT SEEN.
7. **What to do.** Read the line. Fix it if it is yours to fix. If it looks wrong as an engineer, stop and tell Tim.

---

## 9. When CE refuses

1. **A refusal changes nothing.** The command line says why and says "Nothing was changed" or "nothing was unlocked".
2. **Read the whole line.** Type TEXTSCR to see it all, then GRAPHSCR. F2 runs CLEAN in a CE drawing (see the top of this page).
3. **Pit number in use.** See "Edit a pit", steps 4 and 5. Type a number no other pit uses.
4. **Support block.** STS1 on a line says "Object must be a support block." On an ordinary block it says "That is not a support block, so nothing changed. Type the command again and pick a support block." SEEN 8 Oct.
5. **Locked layers, Xrefs and reference edits are never changed.** CE skips them and says so. It will not unlock a layer. For example Foundations re-link says "(nothing was unlocked)". Unlock the layer yourself only if you meant to change that object. NOT SEEN.
6. **Do not repeat a refused command over and over.** Change the cause (the number, the layer, the pick) first.
7. **If the reason does not make sense,** write down the exact line and tell Tim.

---

## 10. Send a support report

1. **When.** Something looks wrong and you want Tim to see your logs.
2. **Type CESUPPORT.** CE prints "[CESUPPORT] Creating support bundle..." then "[CESUPPORT] Bundle saved: " and the file path. NOT SEEN.
3. **It is queued for the office.** CE prints "It will be uploaded to the IT Admin folder on the next refresh." **Tim has ruled; not built yet:** CESUPPORT will never upload by itself. The current build's wording says it will upload, so treat that line as wrong and still send the file to Tim yourself.
4. **The file name carries your computer's name** (CE_SUPPORT_ then the computer name, date and time). It zips CE's own log folder and, if you have one, a "CE Diagnostics" folder on your desktop. **Tim has ruled; not built yet:** PC names stay out of the file name and drawing paths in the bundle become job numbers.
5. **Send it to Tim.** No other support route is recorded. Tim will say where.
6. **Write these seven things down too.** Version (type CEHEALTH and copy the lines), the exact command and clicks, the drawing name, what you expected, what you saw (exact words), what one U did, and the time (Melbourne).
7. **Do not send the drawing.** Tim will ask if he needs one. Do not delete CE's log files.
8. **To look at the logs yourself,** type CEMANAGERLOGS. It opens the log folder.

---

## 11. Go back a version

1. **Roll back only if the install itself is broken.** No CE ribbon, AutoCAD crashes or hangs, drawings you made will not open, or every CE command says "Unknown command". One wrong message is a bug report, not a rollback.
2. **Close AutoCAD first,** and make sure no Codex test is running.
3. **Civil and Manager go back together.** They share a file and one new with one old gives a missing CE ribbon. **Structural goes back alone.**
4. **The method.** Rename the live folder to a ".backup" name (never delete it), rename the matching "_PRE_" backup to the live name, read the version off the file, start AutoCAD.
5. **The backups on this PC (named, not opened; read before the 3.0.35 install).** Civil and Manager pair: CE_CVL_SUITE_PRE_d2575455_20261008-005047.backup and CE_SUITE_MANAGER_PRE_d2575455_20261008-005047.backup (the 3.0.33 and 1.1.33 pair). Structural: CE_STRUC_SUITE_PRE_6f2e9763_20261008-005612.backup (1.0.103). The 3.0.35 / 1.1.35 install on 8 Oct 03:59 also kept the 3.0.34 / 1.1.34 pair as `*_PRE_62514a67_*.backup`; its full file names were not read here.
6. **Your settings are not touched.**
7. **Manager "Roll Back Release".** **Tim has ruled; not built yet:** PCs will go back at their next AutoCAD start, with an "are you sure" question. BUG-425 records that today the button does nothing, so do not rely on it; use the steps above.
8. **The full steps, with the exact commands, are in ROLLBACK_GUIDE_2026-10-07.md** in this folder. Use that file. This page is only a summary.

---

## 12. Structural (versions 1.0.104): roof, upper floors, ground floor, footings last

1. **ROOF: BT1, bracing truss.** Type BT1. CE prints "=== BT1 - BRACING TRUSS (Universal BRACING block) ===" and, the first time in a drawing, "The BRACING block is loaded into this drawing." The repeat does not print it again. Then "Specify first point of bracing truss:". Esc prints "Operation cancelled." SEEN 8 Oct.
2. **BT1, after the first point.** CE asks "Specify second point of bracing (drag preview, ENTER for 0°/2700): " and "Bracing truss number [1-9] <1>: ". NOT SEEN. A brace longer than 2700 is still cut to 2700 today. **Tim has ruled; not built yet:** a brace over 2700 mm will keep its drawn length and warn.
3. **UPPER FLOORS: beam command 1.** (There is no command called BEAM. The beam commands are 1, 2, 4, 5 and BDL.) Type 1. CE asks "Select the first support (a support block or a line), or press Enter to pick points:". Press Enter, then "Specify the START point:", "Specify the END point or [Object]:", "Enter text <bd1>:" (Enter takes it), and "Beam preview [Accept/Cancel] <Accept>:". Each shows once. SEEN 7 Oct.
4. **Result.** "Beam placed. One UNDO removes the complete beam." One U removes it. A second run cancelled at the first question prints "Beam cancelled. Nothing was written." SEEN 7 Oct.
5. **UPPER FLOORS: BTX, beam text to MTEXT.** Type BTX. CE asks "Select beam TEXT/MTEXT to convert:". Select text and CE asks "Choose suffix [NONE/CANT/CONT/BOTH/LOWER/PORTAL/PF/OTHER] <NONE>:". Result: "BTX done: 1 TEXT changed to MTEXT, 0 MTEXT changed to TEXT, 0 skipped." One U takes it back. SEEN 8 Oct.
6. **BTX with nothing in the window** prints "0 found" then "There is no TEXT or MTEXT in that window." SEEN 8 Oct.
7. **UPPER FLOORS: STS1, change a support block to a tagged triple stud.** Type STS1. CE asks "Select support block:". Picking a line says "Object must be a support block." Picking an ordinary block says "That is not a support block, so nothing changed. Type the command again and pick a support block." Picking a real support block: NOT SEEN.
8. **GROUND FLOOR.** Nothing here has Codex evidence yet.
9. **ANY LEVEL: RC, revision cloud.** Type RC. CE asks "Keep OSNAP ON? [Yes/No] <No>:", then the normal AutoCAD revision cloud questions. A rectangular cloud is drawn. One U removes it. SEEN 7 Oct.
10. **FOOTINGS (LAST): FEDIT.** Type FEDIT. CE asks "Select a footing to edit:". Pick the footing outline. CE prints "[FEDIT] You picked CE's outline: editing PF1, the footing nearest your pick." then "[FEDIT] Current: PF1, Pad footing, 600x600".
11. **FEDIT questions.** "Enter new label text <PF1>: ", "Enter new X size <600>: ", "Enter new Y size <600>: ", "Enter new depth <0>: ", then the footing type. CE redraws and prints "[FEDIT] PF1 updated." One U takes it back; REDO after a wait brings the new size back. SEEN 8 Oct.
12. **Propose footings.** Typing CSFDNPROPOSE prints only "Propose footings is not switched on in this version. Nothing was proposed or drawn." It is switched off on purpose. SEEN 8 Oct.

---

## Gaps for the writer's reviewer

1. **Edit Pipe window.** No Codex evidence of the window saving. The "Save" button and "Pipe updated." come from the source, not a screen. PIPEEDIT and CDEDIT prompt texts also come from the source.
2. **Pit placement button wording.** The source calls the New Pit button "Place Pit" in one place and "Continue placement" in another. I used "Continue placement" because Codex saw it.
3. **CESUPPORT.** Codex has not run it. The zip's folder (Temp) and what it holds come from the source. No colleague support route is recorded, so I said "send it to Tim".
4. **Structural settings (CESETTINGS).** Found in the source. Nobody has seen its window.
5. **RC.** The command list calls it "Revision Cloud" in the Annotation group. I could not find where it sits in the roof-down order, so I put it under "any level".
6. **STS1 success.** Codex only saw refusals. Nothing records a real support block being switched.
7. **FEDIT footing-type question.** The exact words of the last FEDIT question were not in the evidence, so I did not quote them.
8. **The 12 s REDO wait.** Codex used 12 seconds. I wrote "about 10". The real minimum is not recorded.
9. **Rollback guide is out of date by one install.** It says Civil 3.0.33, Manager 1.1.33 and Structural 1.0.103 are live. Today they are 3.0.34, 1.1.34 and 1.0.104. The backup names on page 11 were read from the folder; the versions inside them were not opened.
10. **Pit Schedule window renumbering.** BUG-420 was not retested on 3.0.34, so the page 5 step 9 advice rests on the 7 Oct run.
11. **Pit Schedule menu items** Restore Cell, Restore Row and Enable Row Override are read from the window's source. Only Stop overriding was seen.
