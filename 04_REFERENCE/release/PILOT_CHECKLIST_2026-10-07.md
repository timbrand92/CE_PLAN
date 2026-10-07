# CE Pilot Checklist: Day 1 on your own real job (copies first)

Written Wed 7 Oct 2026, Melbourne time. **Corrected Thu 8 Oct 2026 for the versions installed 8 Oct** (Civil 3.0.34, Manager 1.1.34, Structural 1.0.104) against the installed code and Codex runs W10 to W17 (corrections listed in `RELEASE_DOCS_ACCURACY_READ_2026-10-08.md`). For Tim and the 2 to 3 colleagues piloting CE.
Sources: the Opus train reports C-19, C-20, S-19, S-20 and S-21, Codex runs W10c to W17, release queue items 196 to 211, and the release ladder in V3_OVERALL_PLAN.md.

---

## 1. ANSWER FIRST

1. **What the pilot is for.** To find out whether CE works on a real job, not a test drawing. Automated checks and Codex have tested CE on test copies. The plan's ladder is: automated checks, drawing evidence, Tim acceptance, real-work Pilot, Staff Stable. **The Tim-acceptance step has not happened yet:** Tim has accepted nothing in these releases.
2. **How long.** Day 1 is about 2 to 3 hours of your normal work (an estimate, not measured). The whole pilot is the plan's selected 2 to 3 people over ten working days.
3. **Who stops it.** You stop your own day the moment a STOP RULE in section 6 happens. Only Tim ends the pilot.
4. **The one rule.** Work on a COPY of the job. Never save over the original. Nothing here needs the original.
5. **Honest status.** Lines marked **proven in AutoCAD** passed in real AutoCAD on test copies (Codex). Others are built and unit-tested only, marked **not proven yet: tell us what you see**. Those are exactly why the pilot exists. Seeing something different is useful, not your fault.

---

## 2. BEFORE YOU START

1. **Copy the job folder.** Copy the whole job folder to a new folder, for example `JobName_CE_PILOT`. Open only drawings from the copy. Check the folder path in the AutoCAD title bar before you touch anything.
2. **AutoCAD version.** Use the version you normally use. CE is proven most on AutoCAD 2027 (every Codex run was on 2027). If yours is 2022 to 2024, say so on every report.
3. **Open the drawing first.** Open your copy as the FIRST drawing in a freshly started AutoCAD. The file list shifts after a close and Codex opened the wrong drawing twice that way.
4. **Read the CE versions.** They should be:
   - **Civil:** 3.0.34
   - **Manager:** 1.1.34
   - **Structural:** 1.0.104
5. **Where to read them.**
   - **Status bar** (bottom of AutoCAD): "CE MANAGER v1.1.34 [Modern]", "CE CVL SUITE v3.0.34" and "CE STRUC SUITE v1.0.104". "[Modern]" is the AutoCAD 2027 copy; on another AutoCAD year that word differs.
   - **Or type `CEHEALTH`.** It prints "[CEHEALTH] Checking the CE tools on this PC...", "[OK] CE Civil Suite v3.0.34", "[OK] CE Structural Suite v1.0.104", "[OK] The office IT folder (where CE updates come from) can be reached.", then "[CEHEALTH] All checks passed." (proven in AutoCAD on Tim's PC). Manager is not listed by CEHEALTH.
   - **If a number is lower, or a line is not OK:** stop and tell Tim before doing anything else.
6. **Do NOT press F2.** In this setup F2 runs the CE command CLEAN (it purges, restyles and regenerates your drawing). That is BUG-411. To see the command history type `TEXTSCR`. To go back to the drawing type `GRAPHSCR`.
7. **Never save over the original.** On Day 1 you may save your copy. Do not use Save As to the original name or folder.
8. **Do not change any CE setting on Day 1.** Do not open the CE Settings window (`CDS`), `CDRULEBOOK`, Beam Settings or `ABFLIPAUTO`. A settings command once rewrote Tim's own settings file during a test (BUG-409). Tim sets values.
9. **Know the typed U and REDO rules.**
    - **U:** takes back one step.
    - **REDO:** type it straight after U, with nothing typed in between. A command typed between U and REDO (even LIST) kills REDO in AutoCAD, so it is not a CE fault.
    - **Wait:** the tests waited about 12 seconds untouched before REDO. Do the same.

---

## 3. DAY 1 CIVIL (grouped by workflow)

Each line: Do, then what you should see, then what to write down if you do not see it. Tick the box only when you saw it.

### 3A. Place a pit

1. [ ] **Place one pit.**
   - **Do:** type `PIT`. At "Specify pit insertion point:" click an empty spot. In the New Pit window type a pit number and a cover level, then place it. At "Specify pit label insertion point:" click the label spot, then at "Click to place cover text (Enter = <BR>):" the cover text spot. Press Esc.
   - **You should see:** "Pit placed successfully." then "[CE] Pit placed. Pick the next pit, or press Esc to stop." then after Esc "[CE] Stopped. Everything placed stays; U takes back the last one."
   - **If not, write down:** every line you saw, and which step it stopped at. Proven in AutoCAD (W14, full transcript, no "Duplicate definition" line).
2. [ ] **Undo and redo the pit.**
   - **Do:** type `U`, look, wait 12 seconds, type `REDO`.
   - **You should see:** U echoes "PIT"; the pit, its label and its cover text all go, then all come back with "Everything has been redone".
   - **If not, write down:** which of the three did not come back. U and REDO are proven in AutoCAD; the visual check of the whole pit is not proven yet.
3. [ ] **Cover box after a restart.**
   - **Do:** close AutoCAD, reopen your copy, type `PIT`.
   - **You should see:** the cover box EMPTY and the place button greyed with "Enter the cover level." until you type a cover. Proven in AutoCAD (W14).
   - **Recall Last:** a Recall Last button should fill the last cover back in. **Not proven yet:** Codex could not see the button. Tell us whether you can see it.
   - **If not, write down:** what the cover box showed.
4. [ ] **Pit number already used.**
   - **Do:** with pit P8 on the drawing, type `PIT`, enter 8 as the number, press Place.
   - **You should see:** a box "Pit number already used": "There is already a pit P8. Type a different number." The window stays open with your levels still in it. Proven in AutoCAD (W14, with P1).
   - **If not, write down:** what happened.

### 3B. Rename a pit number

Pits P5 and P8 are used as examples. Use your own numbers.

1. [ ] **Rename in Edit Pit to a free number.**
   - **Do:** type `PITEDIT`, pick P5. In "Pit number" type 9 (no pit 9 or P9 exists), press Save. Then `PITSCHEDULE` to look, close it.
   - **You should see:** "Pit updated."; P5 becomes 9 on the plan label, in the schedule row and in the pipes' From and To. One `U` takes it back.
   - **If not, write down:** which of the three did not change. Not proven yet (Codex did this on a pit with no pipes and did not read the row).
2. [ ] **Edit Pit: a number another pit already has.**
   - **Do:** `PITEDIT`, pick P5, type P8 (a P8 exists), press Save. Then try just 8.
   - **You should see:** "[CE] Pit number P8 is already used by another pit (P8), so this pit keeps P5. Type a number no other pit uses. Nothing was changed. Your entries have been kept — correct them and press Update again." (for 8: "... is the same pit number as P8 (another pit) ..."). The window opens again with your number still typed: press Cancel. The schedule still has one P5 and one P8. Proven in AutoCAD (W16). The sentence says "Update": the button is Save.
3. [ ] **A placed table cell.**
   - **Do:** double-click a pit number cell in a placed Pit Schedule table and type 8 (P8 exists).
   - **You should see:** "[CE] 8 is the same pit number as P8 (another pit). P5 kept." and the cell reads P5 again.
   - **Known limit:** double-click typing in a placed cell may not reach CE at all (release notes, section 6, item 6). If nothing happens, write that down. Not proven yet.
4. [ ] **A plan label double-click.**
   - **Do:** double-click a pit's plan label and type c2 where no C2 exists.
   - **You should see:** label, schedule and pipes read c2 (small c).
   - **If not, write down:** the three readings. Not proven yet.
5. [ ] **A label typed as a bare number.**
   - **Do:** double-click P5's plan label and type 8 (P8 exists).
   - **You should see:** "Pit ID must be one compact identifier such as P1 or SPS1. The visible text was kept; linked Civil data was not changed. Run CDEDIT to review it."
   - **Then:** do NOT move that label. Moving it renames the pit. Write down what the label shows.
6. [ ] **DO NOT renumber pits in the Pit Schedule window.** In AutoCAD it accepted "2" beside P2 and "p1" over P1 with no warning (Codex W14, BUG-420, not fixed in 3.0.34). Renumber with Edit Pit (step 2). If you did type a number there by mistake, write down the row and what it shows.

### 3C. Move, copy, erase, then U and REDO

All of these passed on test copies in real AutoCAD (Codex W12, W13, W14). The point now is your own job.

1. [ ] **Grip move a pit.**
   - **Do:** select a pit, drag its centre grip a little. `U`, wait 12 seconds, `REDO`.
   - **You should see:** U echoes "Grip Edit" and the pit goes back. REDO says "Everything has been redone" and the pit moves again.
   - **If not, write down:** the exact echo and where the pit ended up.
2. [ ] **MOVE a pit that has pipes.**
   - **Do:** `MOVE` the pit, base point then `@500,0`. `U`, wait, `REDO`.
   - **You should see:** pit and pipes move, pipe length label changes. U puts them back. REDO restores the moved pit and the new label.
   - **Seen once and normal:** "[CE Civil] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is". Write down if it appears on every move.
3. [ ] **COPY a pit.**
   - **Do:** `COPY` a pit to an empty spot. `U`, wait, `REDO`.
   - **You should see:** "1 pit copied and numbered as new. Check levels: they came across from the originals (the Inspector shows which ones to confirm)." U removes it. REDO brings it back.
   - **If not, write down:** the pit number it got and the levels it shows.
4. [ ] **ERASE a pit, then U and REDO.**
   - **Do:** `ERASE` one pit, then `U`, wait, `REDO`.
   - **You should see:** U echoes "ERASE". REDO says "Everything has been redone".
   - **Not proven yet:** that the erased pit itself returns and goes again on a real job. Look closely at the drawing and tell us.
5. [ ] **Two drawings open.**
   - **Do:** place a pit with `PIT`, press `U`, switch to a second drawing, double-click some text there and press Esc, switch back and type `REDO`.
   - **You should see:** probably "Nothing to redo". That was seen in W14 and is a known limit when you switch drawings, not a stop rule.
   - **Write down:** what you got. Do not rely on REDO after switching drawings.

### 3D. Draw a pipe

1. [ ] **Draw one pipe between two pits.**
   - **Do:** type `CD`.
   - **You should see, in order:** "Select the first two points to start the polyline, or E to use a line you have drawn." then "Specify first point or [Existing line] [Existing]:" then "Specify second point:" then "Select point 3 (or Enter for straight pipe):". Pick pit 1, pit 2, press Enter. The New Pipe window asks for the invert levels. Type the real levels from your job. Click Start Pipe.
   - **Then:** "[CE] Pipe placed. Pick the next pipe's first point, or press Esc to stop." Press Esc.
   - **If not, write down:** which prompt changed or what the window asked.
2. [ ] **Undo and redo the pipe.**
   - **Do:** `U`, wait 12 seconds, `REDO`.
   - **You should see:** U echoes "CD" and the pipe goes. REDO says "Everything has been redone" and brings back the pipe, the flow arrow and both invert labels. Proven in AutoCAD (W13).
3. [ ] **Edit an older pipe.**
   - **Do:** `CDEDIT`, pick a pipe drawn in an older CE.
   - **You may see:** "This pipe was drawn with an older version of CE. Is the highlighted text ... this pipe's label? [Yes/No] <Yes>". Answer Yes only if the highlighted text really is that pipe's label.
   - **If you answer No or Esc:** CE says the pipe was not opened, nothing was changed, and you can redraw the pipe with CD (seen in W14). Write down which pipes triggered it.

### 3E. Pit Schedule

1. [ ] **Open the schedule, change nothing.**
   - **Do:** type `PITSCHEDULE`, read it, press Close without placing a table.
   - **You should see:** a header like "Will be placed: 30 rows · All sets · All systems", a line "Drawing check: 95 data issues may affect this schedule", and "30 rows listed" at the bottom. Your numbers will differ. The drawing must not become modified just by opening it: AutoCAD should not ask to save when you close the copy later, if you changed nothing else.
   - **If not, write down:** the three lines you see.
2. [ ] **Override a cover, then stop overriding.**
   - **Do:** change a cover level in a cell (the footer says "Override enabled for linked row."), then right-click that row and choose Stop overriding.
   - **You should see:** the cover you typed STAYS, the override mark goes, and the bottom left reads "Stopped overriding this row. The values you typed stay." Proven in AutoCAD (W16).
   - **Then:** close the window and press `U` once. It takes back the whole Pit Schedule visit (every edit in it). Write down what the cover and the plan label show after that U.
3. [ ] **Message "CE could not save its pipe and pit record with this command. It will be saved with your next command."** This appeared once after a pit placement on 3.0.32 (BUG-412). If you see it, write it down with what you did just before.

### 3F. CDRULES All on an old metre job

1. [ ] **Run it.**
   - **Do:** on a copy of an older job drawn in metres, type `CDRULES`.
   - **You should see:** "CE rules: show all findings, problems only, the values in use, or explain each problem [All/Problems/Values/Explain/pReview/Source] <Problems>:" Type `A` and Enter.
   - **What we hope to see:** your pipes with their lengths, falls and grades. **Not proven yet:** All has not given pipe grades on any test drawing. Tell us exactly what it prints, and whether a pipe grade looks wrong to you as an engineer (for example 1% where you expect 0.1%).
   - **Seen with Values (not All):** a list of office values such as "R-02 minimum velocity: 0.6 m/s (office)", "R-04 minimum cover: 300 mm (office)" and "Nothing was changed."
2. [ ] **Nothing changes.** After CDRULES the drawing should not be modified. Write down if AutoCAD marks it modified.

### 3G. Close a saved drawing by the X

1. [ ] **Save the copy first.** Type `QSAVE` on YOUR COPY only.
2. [ ] **Close it with the X on the drawing tab.**
   - **Do:** click the X on the drawing's tab. The first click may only show a hover. Click the X again if nothing happened.
   - **You should see:** the drawing closes, no "Save changes" question, no crash window, AutoCAD stays open. Tested on blank copies only. **Not proven yet:** on a real job. Tell us what you see.
3. [ ] **Reopen the copy.** It should open clean. Typing `CLOSE` also closes it with no question.

---

## 4. DAY 1 STRUCTURAL (Tim's order: ROOF, upper floors, ground floor, slab and raft, FOOTINGS LAST)

Use a structural copy. If CE says Civil tools are off in this drawing, that is the drawing's discipline. To read it, type `CDDISCIPLINE`: it prints "[CE] Current drawing discipline: ..." and then asks "Set this drawing's discipline: [Civil/Structural/cLear/cAncel]" with the current one as the default. **Press Esc** to leave it unchanged ("[CE] No change."). Changing it needs a Save to keep, so only change it on your copy.

### 4A. ROOF (do this first)

1. [ ] **BT1 bracing truss.**
   - **Do:** type `BT1`.
   - **You should see:** "=== BT1 - BRACING TRUSS (Universal BRACING block) ===", then (the first time in this drawing only) "The BRACING block is loaded into this drawing.", then "Specify first point of bracing truss: ", then "Specify second point of bracing (drag preview, ENTER for 0°/2700): ", then "Bracing truss number [1-9] <1>: " once. Enter means truss 1.
   - **Must NOT appear:** a file path, "ERROR", or "Duplicate definition of block _Dot ignored." Proven in AutoCAD up to the first point (W15, W17).
   - **Then:** one `U` removes the truss (not proven yet). Esc at the first point prints "Operation cancelled." (proven).
2. [ ] **R1 roof tag.**
   - **Do:** type `R1`.
   - **You should see:** four picks first: "Pick LEFT beam or wall [Object/Point] <Object>:" (proven in AutoCAD), then RIGHT beam or wall, TOP/near side, BOTTOM/far side. Then "Enter the tag text <R1>:" with the default (your last tag) shown once. Enter tags it. Esc draws nothing. The tag question is not proven yet.

### 4B. UPPER FLOORS

1. [ ] **Beam command 1 (proven in AutoCAD).**
   - **Do:** type `1`. At the first question press Enter to pick points.
   - **You should see, each once:** "Select the first support (a support block or a line), or press Enter to pick points:", "Specify the START point:", "Specify the END point or [Object]:", "Enter text <bd1>:", "Beam preview [Accept/Cancel] <Accept>:".
   - **Result:** "Beam placed. One UNDO removes the complete beam." One `U` removes it. A second run cancelled at the first question says "Beam cancelled. Nothing was written."
   - **Note:** BEAM is not a command. The beam commands are `1`, `2`, `4`, `5` and `BDL`.
2. [ ] **BDL beam lower.**
   - **You should see:** "BEAM LOWER offset distance <n>:" then "Enter BEAM LOWER text <BR7>:" once each. Enter takes the default. Not proven yet.
3. [ ] **BTX text to MTEXT (proven in AutoCAD).**
   - **Do:** type `BTX` and select some text.
   - **You should see:** "Choose suffix [NONE/CANT/CONT/BOTH/LOWER/PORTAL/PF/OTHER] <NONE>:" once. Enter. Then "BTX done: 1 TEXT changed to MTEXT, 0 MTEXT changed to TEXT, 0 skipped." `U` takes it back.
   - **If your window catches no text:** AutoCAD says "0 found", then after Enter CE says "There is no TEXT or MTEXT in that window." Proven in AutoCAD (W17).
4. [ ] **SBEAM and SBEAMEDIT.** Not proven yet.
   - **SBEAM:** click the same point twice: "SBEAM: the start and end points are the same. Pick two different points, or press Escape."
   - **SBEAMEDIT:** "Select an SBEAM steel section to edit:". On a locked layer it must say so ("nothing was unlocked") and leave the layer locked.
5. [ ] **STRUCLINKTEXT.** Not proven yet. Questions: "Select the object the label belongs to (a block, line or polyline):" then "Select the label text:".
6. [ ] **STS1 on something that is not a support block (proven in AutoCAD).**
   - **Do:** type `STS1`. At "Select support block:" click an ordinary block (a door, a symbol).
   - **You should see:** "That is not a support block, so nothing changed. Type the command again and pick a support block." The block is unchanged. (A plain line gets AutoCAD's own "Object must be a support block.")

### 4C. GROUND FLOOR, SLAB AND RAFT

1. [ ] **CSREOBAR reo bar.**
   - **You should see, each once:** "Bar size [...] <N12>:" (the default is the last size used), "Number of bars <8>:", "Spacing (mm) <200>:", and later "Place this reo bar? [Yes/No] <Yes>:". The first three were seen once each in AutoCAD (W11c); the last is not proven yet.
   - **Wrong:** a default shown twice, such as "<8> <8>". Esc at each question draws nothing.
2. [ ] **Hatch and level tools.** Not proven yet. CEHATCHGAP shows its "<5>" once. CEHATCHAUDIT shows "Hatch audit mode [Report/rEpair] <Report>:" once.
3. [ ] **Basement wall with a site-cut batter.** Not proven yet. It asks "Excavation depth for the site-cut batter, 0 to skip <0>:" once. Enter means 0.
4. [ ] **BATTER.** Type `BATTER`: "Select line/polyline at TOP of batter:" (proven in AutoCAD), then the bottom line. It draws, and one U removes it (not proven yet).

### 4D. FOOTINGS (LAST)

1. [ ] **FSF strip footing.**
   - **You should see, in this order:** "Enter text <SF1>:" (proven in AutoCAD), then, only if that mark has no size yet, "Enter width for SF 1 <300>:" (seen on 1.0.102), then "Enter depth <0 to skip>:", then the centreline.
   - **Then:** one `U` removes the strip and its label. Not proven yet.
2. [ ] **FPFC pad footing.** Not proven yet beyond the first question.
   - **You should see, in this order:** "Enter text <PF1>:" (proven), then, only if that mark has no size yet, "Enter X size for PF 1" with a default, "Enter Y size <same as X>:", "Enter depth <0 to skip>:", the centre point, then "Additional rotation around center <0>:".
   - **A second FPFC with PF1:** "Warning: Label 'PF1' already exists. Use anyway? [Yes/No/Increment] <Increment>:" once. Enter gives the next free number (PF2 if it is free).
3. [ ] **FEDIT (proven in AutoCAD).**
   - **Seen in AutoCAD:** "[FEDIT] You picked CE's outline: editing PF1, the footing nearest your pick." then "[FEDIT] Current: PF1, Pad footing, 600x600" then "[FEDIT] PF1 updated."
   - **Do:** change the X size, then `U`. The old size must return. Then `REDO` straight away: "Everything has been redone" (proven, W15 and W17). Do not type `LIST` between U and REDO.
4. [ ] **FST delete then U (proven in AutoCAD).**
   - **Do:** type `FST`, Foundation systems tab, select PF2, Delete Selected Element, Yes, OK, close, then `U`.
   - **You should see:** PF2 back on the drawing and back in FST's list.
5. [ ] **FST re-link.** Not proven yet. On a line on a LOCKED layer you should get "That line is on locked layer '...', so CE did not re-link the footing (nothing was unlocked). Unlock the layer and try Re-link again." The layer must still be locked afterwards. On an Xref: "That is an Xref, which CE does not change, so CE did not re-link the footing. Pick a line drawn in this drawing."
6. [ ] **Centimetre or inch drawing.** Not proven yet. A grip resize says "PF1 is now <a> x <b> mm." in millimetres (700-ish, not 70). After AutoCAD's own STRETCH: "PF1 was resized in the drawing; CE's footing record now says 800 x 600 mm. ..." (not "80 x 60").
7. [ ] **Odd units.** Proven in AutoCAD: in a decimetre drawing FPFC says "This drawing's units are decimetres. CE footings convert millimetres, centimetres, metres, inches and feet only, so CE has not run this command. Check what the drawing is really drawn in (LIST one footing) before changing anything." Nothing is drawn.
8. [ ] **CSFDNPROPOSE must do nothing (proven in AutoCAD).**
   - **Do:** type `CSFDNPROPOSE`.
   - **You should see only:** "Propose footings is not switched on in this version. Nothing was proposed or drawn." It must not draw anything. Do not try to switch it on.

---

## 5. WHAT TO WRITE DOWN

Write it down the moment something is not as listed. Do not tidy it up later.

1. **A screenshot of the whole screen.** The whole AutoCAD window, command line included. Not a crop.
2. **The last 20 command-line lines.** Type `TEXTSCR`, copy the last 20 lines (or screenshot them), then type `GRAPHSCR` to return. Never F2.
3. **The time.** Melbourne time to the minute.
4. **The drawing name** and the folder it was in (check it was your copy).
5. **The command and the step.** For example "CD, after the New Pipe window, pressed Start Pipe".
6. **What you expected, and what happened.** One sentence each.
7. **Where to send it.** Send it to Tim. The checklist sources name no other channel, so Tim will tell you the place (email or Teams). Use "CE pilot" and the date at the top.
8. **Do not send the drawing.** Client drawings stay on your machine. Tim will ask if he needs one.

---

## 6. STOP RULES (stop and tell Tim at once, before you do anything else)

1. **A crash.** AutoCAD closes by itself, an error window appears, or a crash report asks to send. Do not press Send. Tell Tim.
2. **A lost U or REDO.** In the SAME drawing, with nothing typed between, a U that does not undo what it should, or a REDO that says "Nothing to redo". Switching drawings first is the known exception: write it down but you can continue.
3. **A number changed that you did not type.** A pit number, a level, a pipe size or a cover that differs from what you typed or from what it was. Check the Pit Schedule if unsure.
4. **A pit or a pipe gone.** Something missing from the drawing or the schedule that you did not erase.
5. **Anything saved that you did not save.** The original's "date modified" changed, or a file you did not make appeared in the job folder. AutoCAD's own automatic save writes a temporary .sv$ file: that is normal and is not a save of your drawing.
6. **A save question you do not expect.** AutoCAD asks "Save changes" on a drawing you only opened.
7. **A CE command says "Unknown command".** Or a CE command is missing from the ribbon.
8. **A setting you did not change.** CE's settings or your current layer or snap settings different from before.
9. **Typing by itself.** Text you did not type shows up on the command line. In Codex runs this was traced to Codex's own screen tool, not CE (BUG-421), so it should not happen to you. If it does, press Esc twice, write down what appeared, tell Tim.
10. **Wrong gut feeling.** If a result looks wrong to you as an engineer, stop. You do not have to prove it.

---

## 7. END OF DAY

1. [ ] **Save your copy** if you want to keep it. Only with `QSAVE` on the copy.
2. [ ] **Close each drawing cleanly.** Use the tab X, or type `CLOSE`, and answer No to any save question on a drawing you did not mean to change.
3. [ ] **Quit AutoCAD** with `QUIT`. Confirm AutoCAD really ended (the window is gone, not hung).
4. [ ] **Check the original.** Open the original job folder. The "date modified" on every original drawing must be from before today. No new files in it.
5. [ ] **Check nothing else was saved.** The only new files should be inside your copy folder.
6. [ ] **Read the versions at the start of tomorrow** (status bar or `CEHEALTH`), the same three numbers.
7. [ ] **Send your notes** from section 5 to Tim, including "no problems" if there were none.
