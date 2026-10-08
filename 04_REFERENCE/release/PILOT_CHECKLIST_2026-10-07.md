# CE Pilot Checklist: Day 1 on your own real job (copies first)

**Written 9 Oct (updated 07:30) for Civil 3.0.40 / Manager 1.1.40 / Structural 1.0.110**

First written Wed 7 Oct 2026, Melbourne time. Corrected Thu 8 Oct 2026 against the installed code and Codex runs W10 to W17 (corrections listed in `RELEASE_DOCS_ACCURACY_READ_2026-10-08.md`). **Refreshed Fri 9 Oct 2026** against what is installed now and Codex runs W19 to W36. **Installed now: Civil 3.0.38, Manager 1.1.38, Structural 1.0.108** (the product versions were read from the three installed program files on Tim's PC on 9 Oct). For Tim and the colleagues piloting CE. **Tim reads `DAY1_FOR_TIM_2026-10-09.md` first**: it is the one-page, 24-step version of this list. This file is the long version.
**Which Codex run saw what:** every "proven in AutoCAD" or "SEEN" line below names the version it was seen on. Most were seen on an OLDER version (Civil 3.0.33 to 3.0.35, Structural 1.0.102 to 1.0.107); the newer versions contain them but nobody re-read them. Only these were seen on the installed Civil 3.0.38 (W33 to W36: Pit Schedule, a pipe drawn with a held grade, a typed level with the CHECK marker, U and REDO after it, CDCHECK, CDRULES, the status-bar lines). The FLAT label and CESUPPORT were seen on Civil 3.0.37 (W32), which 3.0.38 contains. **Nothing has been seen on Structural 1.0.108 except its status-bar version and its first start**; the newest Structural commands seen were on 1.0.107 (W31, the C1 column) and 1.0.105 (W19, beam, FEDIT, FST). Manager 1.1.38 was seen only as a status-bar line.
**A ruling is not a fix, and nothing is accepted.** Each ruled change is marked "Tim has ruled; not built yet" where that is true. Tim has accepted nothing in these releases.
Sources: the Opus train reports C-19 to C-24 and S-19 to S-25, Codex runs W10c to W36, release queue items 196 to 224, BUG-425 to BUG-445 in `BUG_CARPARK.md`, Tim's rulings INT-066 to INT-072, and the release ladder in V3_OVERALL_PLAN.md.

---

## 1. ANSWER FIRST

1. **What the pilot is for.** To find out whether CE works on a real job, not a test drawing. Automated checks and Codex have tested CE on test copies. The plan's ladder is: automated checks, drawing evidence, Tim acceptance, real-work Pilot, Staff Stable. **The Tim-acceptance step has not happened yet:** Tim has accepted nothing in these releases.
   - **Tim has ruled (INT-069, "15. as recommended"):** Tim runs this Day 1 checklist HIMSELF on one real job copy BEFORE any colleague pilot. That has not been done (as of 9 Oct). No colleague starts until Tim has. His one-page list is `DAY1_FOR_TIM_2026-10-09.md`.
   - **First pilot colleague (INT-069, "16. as recommended"):** on AutoCAD 2027, installed by hand (AutoCAD closed, the old folder renamed to `_PRE_V3.backup`, the new one copied in). **The pilot colleague is Max** (Tim, INT-071 item 8: "Max - IDK"; no surname was given, so this page says only Max).
   - **Where Max saves results (Tim, INT-072 item 1):** the SharePoint folder **CE Plugin Pilot Results** in the Engineering library: https://residentialstructures.sharepoint.com/Engineering/CE%20Plugin%20Pilot%20Results (on your PC, the synced copy of that folder in your Engineering library). Tim's words: "a need to set it up though and make sure it happens".
   - **OPEN ITEM, not done: Tim still has to confirm that Max can write to the Engineering library.** Do not assume it works. Until Tim confirms it, do not use any other place. Sharing is Tim's to grant.
2. **How long.** Day 1 is about 2 to 3 hours of your normal work (an estimate, not measured). The whole pilot is the plan's selected 2 to 3 people over ten working days.
3. **Who stops it.** You stop your own day the moment a STOP RULE in section 6 happens. Only Tim ends the pilot.
4. **The one rule.** Work on a COPY of the job. Never save over the original. Nothing here needs the original.
5. **Honest status.** Lines marked **proven in AutoCAD** or **SEEN** were watched by Codex in real AutoCAD on a test copy, on the version named in the line. That is not Tim's acceptance. Others are built and unit-tested only, marked **not proven yet: tell us what you see** or **NOT SEEN**. Those are exactly why the pilot exists. Seeing something different is useful, not your fault.

---

## 2. BEFORE YOU START

1. **Copy the job folder.** Copy the whole job folder to a new folder, for example `JobName_CE_PILOT`. Open only drawings from the copy. Check the folder path in the AutoCAD title bar before you touch anything.
2. **AutoCAD version.** The first pilot colleague is on AutoCAD 2027 (Tim's ruling). Every Codex run was on 2027. If yours is 2022 to 2024, say so on every report, and tell Tim before you start: those years have never been opened.
3. **Open the drawing first.** Open your copy as the FIRST drawing in a freshly started AutoCAD. The file list shifts after a close and Codex opened the wrong drawing twice that way.
4. **Read the CE versions.** Installed now on Tim's PC (read from the program files 9 Oct):
   - **Civil:** 3.0.38
   - **Manager:** 1.1.38
   - **Structural:** 1.0.108
5. **Where to read them.**
   - **Status bar** (bottom of AutoCAD): "CE MANAGER v1.1.38 [Modern]", "CE CVL SUITE v3.0.38" and "CE STRUC SUITE v1.0.108". "[Modern]" is the AutoCAD 2027 copy; on another AutoCAD year that word differs. **SEEN on these exact numbers, 8 Oct (Codex W33):** "CE MANAGER v1.1.38 [Modern] 2026-10-08", "CE CVL SUITE v3.0.38 2026-10-08 [Modern]", "CE STRUC SUITE v1.0.108 2026-10-08".
   - **Or type `CEHEALTH`.** It prints "[CEHEALTH] Checking the CE tools on this PC...", "[OK] CE Civil Suite v3.0.38", "[OK] CE Structural Suite v1.0.108", "[OK] The office IT folder (where CE updates come from) can be reached.", then "[CEHEALTH] All checks passed." (Codex saw these four lines with v3.0.34 for Civil and v1.0.104 for Structural, W16; nobody has read them on 3.0.38 / 1.0.108.) Manager is not listed by CEHEALTH.
   - **If a number is lower, or a line is not OK:** stop and tell Tim before doing anything else.
6. **Do NOT press F2 expecting a save.** In the setup Codex tested, F2 runs the CE command CLEAN (it purges, restyles and regenerates the drawing). Tim has ruled F2 is **left as it is for now** (INT-069 item 9: "leave as is for now, commonly used by me to save"); BUG-411 stays open and the desk will check what F2 does for Tim before anyone changes it. To save your copy type `QSAVE`. To see the command history type `TEXTSCR`, and `GRAPHSCR` to go back to the drawing. **Inside the Pit Schedule window F2 edits the cell** (that is the window's own key, not the drawing's).
7. **Never save over the original.** On Day 1 you may save your copy. Do not use Save As to the original name or folder.
8. **Do not change any CE setting on Day 1.** Do not open the CE Settings window (`CDS`), `CDRULEBOOK`, Beam Settings or `ABFLIPAUTO`. A settings command once rewrote Tim's own settings file during a test (BUG-409). Tim sets values.
9. **Know the typed U and REDO rules.**
    - **U:** takes back one step.
    - **REDO:** type it straight after U, with nothing typed in between. A command typed between U and REDO (even LIST, and REGEN: Codex saw "Nothing to redo" after U, a wait, REGEN, a wait, REDO on 3.0.38, W35) kills REDO in AutoCAD, so it is not a CE fault. **One mouse click on empty drawing plus Esc twice in the wait did NOT kill it** (W36, 3.0.38). A mouse-wheel zoom between U and REDO has not been tested.
    - **Wait:** the tests waited about 12 seconds untouched before REDO. Do the same.
    - **Things that leave their own undo step (Codex, W27, W33, 8 Oct):** a mouse-wheel zoom (U echoes INTELLIZOOM), LIST, TEXTSCR, GRAPHSCR, REGEN and a Pit Schedule visit (PITSCHEDULE). So after reading output, one U may undo only the zoom or the text window, not your last edit. Look at the U echo line. Type nothing and do not zoom between your last edit and the U you mean.
    - **Automatic save:** Codex turned AutoCAD's automatic save off (SAVETIME 0) during its U and REDO tests, so a REDO after an automatic save has not been tried. If AutoCAD prints "Automatic save to ..." between your U and REDO, write it down.

---

## 2A. KNOWN GAPS YOU WILL MEET (stated up front; none is a stop rule)

1. **The C1 and TS1 column commands place the column but NO "C1" label (BUG-438).** After the insertion point, the rotation question and the support-text question, CE prints "Text placed at the top right (CR1)." then asks "Enter a number to append to 'C' (or press Enter to exit):". Whatever you answer (a number or Enter) you get "[CR1] DefaultValue is not set.", "Type CESUPPORT to generate a diagnostic bundle for support.", "[CE_STRUC_SUITE] Support text command failed: CE text command 'CR1' failed." and "[CE] No beam found nearby, so the support is not linked. Place the beam first, or run BEAMLINKMIGRATE." The column stays, with no label. At "Pick desired support text location (auto left/right/top/bottom):" Enter was refused with "Invalid point." on 1.0.106 (BUG-437): click a point. SEEN on 1.0.107 (W31). A cancelled C1 or TS1 now puts your current layer back (SEEN on 1.0.107, BUG-434 / #810).
2. **Three "Menu item failed to load" lines and "; error: syntax error" at AutoCAD start (BUG-435, BUG-437).** The lines are "Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL", "Menu item failed to load: CE_STRUC_SUITE_MENU:CE STRUC" and "Menu item failed to load: CE_SUITE_MANAGER_MENU:CE Manager" (earlier runs show only the first and last), then "; error: syntax error" and "AutoCAD menu utilities loaded." They come from old menu names in the AutoCAD profile. **Harmless to drafting:** the CE ribbon tabs and the CE pull-down menus ("CE CVL - Layout" and the others, "CE Manager - Control") are there and every command ran. SEEN on Civil 3.0.36 with Structural 1.0.106 or 1.0.107 (W26, W29, W31). Not re-read on 3.0.38 / 1.0.108.
3. **Manager "Roll Back Release": do NOT press it (BUG-425, BUG-441).** Whether the installer accepts an older version is unproven. Pressed today it changes nothing: the office record holds no earlier build and Manager says "No trusted rollback target has been recorded yet." (read from the source in the C-23 finalizer report, not seen in AutoCAD). To go back a version use `ROLLBACK_GUIDE_2026-10-07.md`.
4. **Renumber pits ONLY in Edit Pit (`PITEDIT`).** Not in the Pit Schedule window (section 3B, step 6). Not by double-clicking the plan label: that opens AutoCAD's own Enhanced Attribute Editor, not Edit Pit (BUG-430, SEEN on 3.0.35, W20).
5. **A flat pipe's Edit Pipe window still shows "grade 1 in 100" beside two equal inverts (BUG-442).** The plan label reads FLAT (SEEN on 3.0.37, W32). Do not trust the window's grade box on a flat pipe.
6. **`CESUPPORT` makes a zip with only its index file (BUG-442).** The zip held WHAT_IS_IN_THIS_ZIP.txt and nothing else (856 bytes; "1 files, 0 left out"; SEEN on 3.0.37, W32). So keep your own screenshots and notes as well (section 5).
7. **A level typed in the Pit Schedule waits as an override.** Type a level in a cell and press Enter: the footer says "Override enabled for linked row." and the plan does not change. "Continue to Place / update" stays greyed out (W34). Right-click the row and choose Stop overriding: then the level, the IL text and, for a pipe with a HELD grade ("Set my own"), the red CHECK marker are written to the plan. **One U takes back the whole visit** (level and marker together, SEEN on 3.0.38, W36). **REDO works only immediately after U:** any typed command in between ends it, and that is AutoCAD's own rule (W35). Tim ruled a free number typed here waits as a pending override until Review, Update or Stop overriding (INT-069 item 5).
8. **The first AutoCAD start after each Structural install writes new default rows into your `CS_Settings.json` (BUG-429).** No value of yours changes. One line in the CE log says so: "Settings file updated with new default rows (CS_Settings.json). No value you set was changed." (SEEN in the CE log on 1.0.107, W29; it is NOT on the command line). On Tim's PC 1.0.108 already did it at its first start on 8 Oct at 12:39 (26,901 bytes became 28,361). Every upgrade that adds Settings rows does this once.
9. **File > New opens a test template (BUG-440).** Tim's AutoCAD profile default template points to a test copy left by an earlier experiment. It is a profile setting, not CE code. It does not matter when you open your job copy.

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

**Ground rule (Tim, INT-069 "6. as recommended"): renumber pits ONLY in Edit Pit (step 1 and 2).** Never renumber in the Pit Schedule window. Steps 3 to 5 are other renumber routes: a colleague skips them during the pilot; they are for Tim's own Day 1 run and none is proven in AutoCAD. INT-069 says the Pit Schedule window fix is installed in Civil 3.0.35 (PR 766; it is inside 3.0.38), and BUG-426 (open) says a typed 9 then p1 still shows 9. **Seen on 3.0.35 (Codex W20):** in the window a bare 2, p2 or P2 over P1 was refused with "[CE] Pit number 2 is the same pit number as P2 (another pit), so this pit keeps P1. Type a number no other pit uses."; p1 and "P 1" stayed P1; "P 2" was accepted with "[CE] P 2 looks like P2 (another pit). Check the numbering." The free-number-then-p1 case (BUG-426) was not reached. Not re-read on 3.0.38. So the ground rule stands until Tim has seen the window right. Tim's ruling (INT-069 item 6, "6. as recommended"): colleagues renumber pits only in Edit Pit.

1. [ ] **Rename in Edit Pit to a free number.**
   - **Do:** type `PITEDIT`, pick P5. In "Pit number" type 9 (no pit 9 or P9 exists), press Save. Then `PITSCHEDULE` to look, close it.
   - **You should see:** "Pit updated."; P5 becomes 9 on the plan label, in the schedule row and in the pipes' From and To. One `U` takes it back.
   - **If not, write down:** which of the three did not change. **Seen in AutoCAD on 3.0.34 (Codex W18), on a pit WITH pipes:** the plan label, the schedule row and the pipe's From all read 77, and the window said "Pit updated." **Not proven yet:** this rename's own U.
2. [ ] **Edit Pit: a number another pit already has.**
   - **Do:** `PITEDIT`, pick P5, type P8 (a P8 exists), press Save. Then try just 8.
   - **You should see:** "[CE] Pit number P8 is already used by another pit (P8), so this pit keeps P5. Type a number no other pit uses. Nothing was changed. Your entries have been kept — correct them and press Update again." (for 8: "... is the same pit number as P8 (another pit) ..."). The window opens again with your number still typed: press Cancel. The schedule still has one P5 and one P8. Proven in AutoCAD (W16). On 3.0.34 the sentence said "Update"; on 3.0.35 it ends "... correct them and press Save again." and the button reads Save (seen, W20, with 2 typed).
3. [ ] **A placed table cell.**
   - **Do:** double-click a pit number cell in a placed Pit Schedule table and type 8 (P8 exists).
   - **You should see:** "[CE] 8 is the same pit number as P8 (another pit). P5 kept." and the cell reads P5 again.
   - **Known limit:** double-click typing in a placed cell may not reach CE at all (release notes, section 6, item 6). If nothing happens, write that down. Not proven yet.
4. [ ] **A plan label double-click.**
   - **Do not use this route.** Seen on 3.0.35 (Codex W20, BUG-430): double-clicking a pit's plan label opens AutoCAD's own attribute editor, NOT Edit Pit. **Use `PITEDIT` instead** (step 1).
   - **If you try it anyway, write down:** which window opened and whether the label, schedule and pipes changed. Typing c2 into the label itself is not proven.
5. [ ] **A label typed as a bare number.**
   - **Do:** double-click P5's plan label and type 8 (P8 exists).
   - **You should see:** "Pit ID must be one compact identifier such as P1 or SPS1. The visible text was kept; linked Civil data was not changed. Run CDEDIT to review it."
   - **Then:** do NOT move that label. Moving it renames the pit. Write down what the label shows.
6. [ ] **DO NOT renumber pits in the Pit Schedule window.** On 3.0.33 it accepted "2" beside P2 and "p1" over P1 with no warning (Codex W14, BUG-420; not retested since). Renumber with Edit Pit (steps 1 and 2). Tim has ruled that a FREE number typed in this window simply waits as a pending override until you press Review, Update or Stop overriding; that is how it works and is not being changed. If you did type a number there by mistake, write down the row and what it shows.

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
   - **Same level at both ends (SEEN on 3.0.37, 8 Oct, Codex W32):** the New Pipe window shows "This pipe has design warnings. Review before proceeding." / "Pipe is essentially flat — no measurable fall" / "Warnings are informational — the pipe has been saved." The command line adds "[CE] Warning: Pipe is essentially flat — no measurable fall". **The label reads "100 DIA. UPVC PIPE FLAT"** (your size and material) with no grade figure; both invert texts read the levels you typed (BUG-427 / #789; before this the label read "AT 1 IN 100"). Tim's ruling (INT-070 item 5): "5. yes". Edit Pipe on it: "Pipe updated.", the label STAYS FLAT. **Known gap (BUG-442):** the Edit Pipe window still shows "grade 1 in 100" beside the two equal inverts. Write down what your label says.
2. [ ] **Undo and redo the pipe.**
   - **Do:** `U`, wait 12 seconds, `REDO`.
   - **You should see:** U echoes "CD" and the pipe goes. REDO says "Everything has been redone" and brings back the pipe, the flow arrow and both invert labels. Proven in AutoCAD (W13 on 3.0.32; again on a flat pipe, W32 on 3.0.37).
3. [ ] **Edit an older pipe.**
   - **Do:** `CDEDIT`, pick a pipe drawn in an older CE.
   - **You may see:** "This pipe was drawn with an older version of CE. Is the highlighted text ... this pipe's label? [Yes/No] <Yes>". Answer Yes only if the highlighted text really is that pipe's label.
   - **If you answer No or Esc:** CE says the pipe was not opened, nothing was changed, and you can redraw the pipe with CD (seen in W14). Write down which pipes triggered it.

### 3E. Pit Schedule

1. [ ] **Open the schedule, change nothing.**
   - **Do:** type `PITSCHEDULE`, read it, press Close without placing a table.
   - **You should see:** a header like "Will be placed: 27 rows · All sets · All systems", a line "Drawing check: 95 data issues may affect this schedule", and a row count at the bottom. Your numbers will differ. SEEN on 3.0.38 (W33, W34, 8 Oct). The drawing must not become modified just by opening it: AutoCAD should not ask to save when you close the copy later, if you changed nothing else.
   - **If not, write down:** the three lines you see.
2. [ ] **Override a cover, then stop overriding.**
   - **Do:** change a cover level in a cell (the footer says "Override enabled for linked row."), then right-click that row and choose Stop overriding.
   - **You should see:** the cover you typed STAYS, the override mark goes, and the bottom left reads "Stopped overriding this row. The values you typed stay." Proven in AutoCAD (W16).
   - **Then:** close the window and press `U` once. It takes back the whole Pit Schedule visit (every edit in it). Write down what the cover and the plan label show after that U. On 3.0.35 Codex saw the U line read PITSCHEDULE and REDO say "Everything has been redone" (W20); the same on 3.0.38 (W35, W36). **Open (BUG-430 item 2):** the override tick stays ticked on the pit-number cell after Stop overriding; write it down if you see it.
3. [ ] **Type a level for a pipe end, then Stop overriding (SEEN on 3.0.38, 8 Oct, Codex W35 and W36).** This is gap 7 in section 2A.
   - **Do:** draw a pipe with `CD` but in the New Pipe window set Pipe grade to **Set my own**, type 100 in the "1 in" box, tick "I know one end — work the other out from the grade" and type the start invert (Codex used 20.000 and the window showed the calculated end 19.91); Start Pipe, then Esc. Type `PITSCHEDULE`, search for the downstream pit, click its **IL (Inlet)** cell, press F2, select all, type a slightly different level (Codex typed 19.85), press Enter. Right-click the row and choose **Stop overriding**. Close the window; do NOT press "Continue to Place / update".
   - **You should see:** after Enter "Override enabled for linked row." (plan unchanged). After Stop overriding "Stopped overriding this row. The values you typed stay." and the inlet level and depth in the row follow your level. After Close: the IL text on the plan shows your level, and a red marker reads like "CHECK: LABEL GRADE 1 IN 100, LEVELS GIVE ABOUT 1 IN 61" (your figures will differ). The command line says "[CE] Pipe P10-P9: the label grade is 1 IN 100 but its levels now give about 1 IN 61. Only the end at P9 changed; the far end was not moved. Check the grade, or set it in Edit Pipe (CDEDIT)." The command line says the label grade is still 1 IN 100.
   - **Tim's words (INT-071 item 10, card A):** "10. answers below 1. yes 2. yes 3. warning on plan implenmented well would be good". The desk read that as: update the label grade on a held-grade pipe, warn when the label is more than 10 % off, and show the warning on the plan as a non-plotting marker. Whether what Codex saw is what Tim meant is for Tim to judge.
   - **Then U once:** U echoes PITSCHEDULE; the level goes back to the old one and the marker goes, together (one Undo step). Wait 12 seconds untouched, `REDO`: "Everything has been redone", the level and marker return (SEEN, W35 and W36). One mouse click plus Esc twice in the wait also passed (W36). REGEN between U and REDO gives "Nothing to redo": that is AutoCAD's rule.
   - **If no marker appears:** the pipe was not "Set my own", or you did not choose Stop overriding (Codex saw exactly that in W33 and W34: nothing was written without Stop overriding).
   - **Not seen:** the marker's layer (CE GRADE CHECK) and that it does not plot; Edit Pipe Save removing the marker (Codex's pick answered "That is not a pipe. Click the pipe line or its outline."; pick the pipe line itself).
4. [ ] **Message "CE could not save its pipe and pit record with this command. It will be saved with your next command."** This appeared once after a pit placement on 3.0.32 (BUG-412). If you see it, write it down with what you did just before.

### 3F. CDRULES All on an old metre job

1. [ ] **Run it.**
   - **Do:** on a copy of an older job drawn in metres, type `CDRULES`.
   - **You should see:** "CE rules: show all findings, problems only, the values in use, or explain each problem [All/Problems/Values/Explain/pReview/Source] <Problems>:" Type `A` and Enter.
   - **What we hope to see:** your pipes with their lengths, falls and grades. **Not proven yet:** All has not given pipe grades on any test drawing. Tell us exactly what it prints, and whether a pipe grade looks wrong to you as an engineer (for example 1% where you expect 0.1%).
   - **Seen with Problems (3.0.38, 8 Oct, W35):** at the question type `P`. "[CE] Previous rule results (2026-09-05 00:26) were STALE: recorded inputs, decisions or observed geometry changed. Re-checking now." (first run only), "[CE] CDRULES: 408 finding(s) across 12 rules; 29 warnings, 312 unknown, 67 pass; no council profile set (CDRULEBOOK > Council).", "Problems only: 341 of 408." and last "Drawing geometry unchanged; results recorded in the project." "Unknown" means CE could not check; it is not a pass. Orifice rules R-05, R-15 to R-18 and R-20 to R-23 say "not evaluated here (needs the CDCALC orifice result)" or similar: that is expected.
   - **Seen with Values (not All):** a list of office values such as "R-02 minimum velocity: 0.6 m/s (office)", "R-04 minimum cover: 300 mm (office)" and "Nothing was changed."
2. [ ] **Nothing changes.** After CDRULES the drawing should not be modified. Write down if AutoCAD marks it modified.

### 3G. Close a saved drawing by the X

1. [ ] **Save the copy first.** Type `QSAVE` on YOUR COPY only.
2. [ ] **Close it with the X on the drawing tab.**
   - **Do:** click the X on the drawing's tab. The first click may only show a hover. Click the X again if nothing happened.
   - **You should see:** the drawing closes, no "Save changes" question, no crash window, AutoCAD stays open. Tested on blank copies only. **Not proven yet:** on a real job. Tell us what you see.
3. [ ] **Reopen the copy.** It should open clean. Typing `CLOSE` also closes it with no question.

### 3H. CDCHECK (reading only)

1. [ ] **Run it.**
   - **Do:** type `CDCHECK`, press Enter at All, press Enter at "Jump to item number".
   - **You should see:** "CE check: show all connections, problems only, or save as CSV [All/Problems/Csv] <All>:", then a summary like "[CE] CDCHECK: 217 objects, 190 connections: 185 Connected, 1 Possible, 4 Unresolved, 0 Not Connected, 0 Unknown.", possibly "[CE] FALL arrow direction: 5 arrow(s) point away from their nearest grated pit." with "Check the fall direction or move the arrow.", then "Jump to item number (1-60) or [Ends]:" and "Nothing in the drawing was changed." SEEN on 3.0.38 (W35, 8 Oct; your numbers will differ). The full list is also written to a file.
   - **If not, write down:** the summary line. A fall arrow pointing away from a grated pit is worth a look as an engineer.

---

## 4. DAY 1 STRUCTURAL (Tim's order: ROOF, upper floors, ground floor, slab and raft, FOOTINGS LAST)

**Version note.** Structural 1.0.108 is installed. Nothing in this section has been seen on 1.0.108; each line says the version it was seen on. Between 1.0.105 and 1.0.108 Structural gained several things that ship **OFF** and hidden (roof setout CSROOFSETOUT, floor setout CSFLOORSETOUT, framing legend CSFRAMINGLEGEND, lintel proposals CSLINTELPROPOSE, point loads CSPOINTLOAD). Do not try to switch them on. If you type one, CE says it is switched off in Settings and draws nothing; SEEN on 1.0.107 (W31) for the first, third and fourth, for example "The roof area setout is switched off in Settings (Roof area setout), so nothing was drawn. The Settings page for it is still to be built." (two sentences, not one). Also read gap 8 in section 2A: your CS_Settings.json grows at the first start of a new Structural version.

Use a structural copy. If CE says Civil tools are off in this drawing, that is the drawing's discipline. To read it, type `CDDISCIPLINE`: it prints "[CE] Current drawing discipline: ..." and then asks "Set this drawing's discipline: [Civil/Structural/cLear/cAncel]" with the current one as the default. **Press Esc** to leave it unchanged ("[CE] No change."). Changing it needs a Save to keep, so only change it on your copy.

### 4A. ROOF (do this first)

1. [ ] **BT1 bracing truss.**
   - **Do:** type `BT1`.
   - **You should see:** "=== BT1 - BRACING TRUSS (Universal BRACING block) ===", then (the first time in this drawing only) "The BRACING block is loaded into this drawing.", then "Specify first point of bracing truss: ", then "Specify second point of bracing (drag preview, ENTER for 0°/2700): ", then "Bracing truss number [1-9] <1>: " once. Enter means truss 1.
   - **Must NOT appear:** a file path, "ERROR", or "Duplicate definition of block _Dot ignored." Proven in AutoCAD up to the first point (W15, W17).
   - **Then:** one `U` removes the truss (not proven yet). Esc at the first point prints "Operation cancelled." (proven, 1.0.104, W17).
   - **A brace over 2700 mm:** the documents disagree. KNOWN_LIMITATIONS_2026-10-08.md says it is still cut to 2700; BUG-428 (the S-22 finalizer, which shipped in 1.0.105) says it now keeps its drawn length and warns (Tim, INT-066 C). Not seen in AutoCAD. Write down what you see; BB does not warn (BUG-428).
2. [ ] **R1 roof tag.**
   - **Do:** type `R1`.
   - **You should see:** four picks first: "Pick LEFT beam or wall [Object/Point] <Object>:" (proven in AutoCAD), then RIGHT beam or wall, TOP/near side, BOTTOM/far side. Then "Enter the tag text <R1>:" with the default (your last tag) shown once. Enter tags it. Esc draws nothing. The tag question is not proven yet.

### 4B. UPPER FLOORS

1. [ ] **Beam command 1 (proven in AutoCAD).**
   - **Do:** type `1`. At the first question press Enter to pick points.
   - **You should see, each once:** "Select the first support (a support block or a line), or press Enter to pick points:", "Specify the START point:", "Specify the END point or [Object]:", "Enter text <bd1>:", "Beam preview [Accept/Cancel] <Accept>:".
   - **Result:** "Beam placed. One UNDO removes the complete beam." One `U` removes it. **Seen on Structural 1.0.105 (Codex W19):** `U` (echo 1), wait 12 seconds, `REDO` said "Everything has been redone". On 1.0.106 with clicked supports (W28): "Select the end support (a support block or a line), or press Enter to pick a point:" then the same preview and "Beam placed. One UNDO removes the complete beam." A second run cancelled at the first question says "Beam cancelled. Nothing was written."
   - **Note:** BEAM is not a command. The beam commands are `1`, `2`, `4`, `5` and `BDL`.
2. [ ] **C1 column, and TS1 (SEEN failing in part, 1.0.107, 8 Oct, Codex W31; known gap 1 in section 2A, BUG-438).**
   - **Do:** type `C1`. Click the insertion point. Press Enter at the rotation question. CLICK a point at the support-text question. At the number question answer 1 or press Enter.
   - **You should see:** "Specify insertion point for C1:", then AutoCAD's own ROTATE lines ("Current positive angle in UCS: ANGDIR=counterclockwise ANGBASE=0", "Specify rotation angle or [Copy/Reference] <0>:"), then "Pick desired support text location (auto left/right/top/bottom):", then "Text placed at the top right (CR1)." and "Enter a number to append to 'C' (or press Enter to exit):", then "[CR1] DefaultValue is not set." and the other three lines in gap 1. **The column is placed with no "C1" label.** "Duplicate definition of block _Dot ignored." should NOT appear (SEEN gone on 1.0.107). Your current layer comes back (SEEN, 1.0.107), also after Esc.
   - **Then:** one `U` takes the column away (U echoes "C1 GROUP"); wait 12 seconds, `REDO` says "Everything has been redone" and the column returns (SEEN, 1.0.107).
   - **Grips:** a column that has no beam linked shows AutoCAD's own grips, not CE's "Edit together / Edit this only / Disconnect" (W28). Place the beam first (step 1) or run BEAMLINKMIGRATE. Not seen with a linked beam.
   - **If a "C1" label DOES appear:** that is good news; write down the version and what you answered.
3. [ ] **BDL beam lower.**
   - **You should see:** "BEAM LOWER offset distance <n>:" then "Enter BEAM LOWER text <BR7>:" once each. Enter takes the default. Not proven yet.
4. [ ] **BTX text to MTEXT (proven in AutoCAD).**
   - **Do:** type `BTX` and select some text.
   - **You should see:** "Choose suffix [NONE/CANT/CONT/BOTH/LOWER/PORTAL/PF/OTHER] <NONE>:" once. Enter. Then "BTX done: 1 TEXT changed to MTEXT, 0 MTEXT changed to TEXT, 0 skipped." `U` takes it back.
   - **If your window catches no text:** AutoCAD says "0 found", then after Enter CE says "There is no TEXT or MTEXT in that window." Proven in AutoCAD (W17).
5. [ ] **SBEAM and SBEAMEDIT.** Not proven yet.
   - **SBEAM:** click the same point twice: "SBEAM: the start and end points are the same. Pick two different points, or press Escape."
   - **SBEAMEDIT:** "Select an SBEAM steel section to edit:". On a locked layer it must say so ("nothing was unlocked") and leave the layer locked.
6. [ ] **STRUCLINKTEXT.** Not proven yet. Questions: "Select the object the label belongs to (a block, line or polyline):" then "Select the label text:".
7. [ ] **STS1 on something that is not a support block (proven in AutoCAD, 1.0.104, W17).**
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
   - **Tim has ruled (INT-069 item 14, "14. as recommended"):** an unknown footing width asks for it with the Settings value pre-filled (today 300 mm; screw pile 150 mm). The Foundations adopt command FADOPT carries this from 1.0.107 ("Width in mm <300>:", shown once; BUG-439); FSF's own width question is as listed above. Not seen on 1.0.108.
   - **Then:** one `U` removes the strip and its label. Not proven yet.
2. [ ] **FPFC pad footing.** Not proven yet beyond the first question.
   - **You should see, in this order:** "Enter text <PF1>:" (proven), then, only if that mark has no size yet, "Enter X size for PF 1" with a default, "Enter Y size <same as X>:", "Enter depth <0 to skip>:", the centre point, then "Additional rotation around center <0>:".
   - **A second FPFC with PF1:** "Warning: Label 'PF1' already exists. Use anyway? [Yes/No/Increment] <Increment>:" once. Enter gives the next free number (PF2 if it is free).
3. [ ] **FEDIT (proven in AutoCAD).**
   - **Seen in AutoCAD:** "[FEDIT] You picked CE's outline: editing PF1, the footing nearest your pick." then "[FEDIT] Current: PF1, Pad footing, 600x600" then "[FEDIT] PF1 updated."
   - **Do:** change the X size, then `U`. The old size must return. Then `REDO` straight away: "Everything has been redone" (proven, W15 and W17). Do not type `LIST` between U and REDO.
   - **Also seen on 1.0.105 (Codex W19):** FEDIT to 700x700 with the Bracing panel open: U echo FEDIT, REDO said "Everything has been redone"; the panel's 5-second timer did not break REDO. ERASE of a footing outline with the panel open also redid. **Not proven:** the footing's size after REDO.
4. [ ] **FST delete then U (proven in AutoCAD).**
   - **Do:** type `FST`, Foundation systems tab, select PF2, Delete Selected Element, Yes, OK, close, then `U`.
   - **You should see:** PF2 back on the drawing and back in FST's list. **Seen on 1.0.105 (W19):** after the U the outline was back, and REDO took it away again ("Everything has been redone"). The exact U and REDO lines for FST were not recorded.
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
7. **Where to save it.** Put the CE support report (type `CESUPPORT`) and your notes in the SharePoint folder **CE Plugin Pilot Results** in the Engineering library: https://residentialstructures.sharepoint.com/Engineering/CE%20Plugin%20Pilot%20Results (or the synced copy of that folder in your Engineering library). Make a sub-folder named by the date inside it, for example `2026-10-12`, and put that day's files in it. **Job NUMBERS only: no client names, no addresses.** Tim, INT-072 item 1: "a need to set it up though and make sure it happens".
   - **What CESUPPORT does (SEEN on 3.0.37, 8 Oct, W32):** it prints "[CESUPPORT] Creating support bundle...", then "[CESUPPORT] Support file saved on this PC: ... It has not been sent anywhere. If support asks for it, send it yourself (email, or the job's support folder). Drawing paths inside it are cut to job numbers and your login and computer name are coded." and "The zip lists what it holds in WHAT_IS_IN_THIS_ZIP.txt (1 files, 0 left out)." The zip is in a "CE Support" folder on your Desktop, named like CE_SUPPORT_<code>_<code>_<date>_<time>.zip (no real login or computer name in the name). **It holds only that index file (BUG-442):** keep your own screenshots and command-line notes as well. The printed path on your screen shows your login: do not copy that line into a shared note.
   - **OPEN ITEM: Tim has not yet confirmed that Max can write to the Engineering library.** If you cannot save there, stop and tell Tim. Do not use another place.
8. **Do not send the drawing.** Client drawings stay on your machine. Tim will ask if he needs one.

---

## 6. STOP RULES (stop and tell Tim at once, before you do anything else)

**The known gaps in section 2A are NOT stop rules** (no C1 label, the start-up menu lines, the Edit Pipe window's grade box on a flat pipe, the nearly empty support zip, a settings-file growth after a Structural install). Write them down once if you wish and carry on.

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
6. [ ] **Read the versions at the start of tomorrow** (status bar or `CEHEALTH`), the same three numbers: 3.0.38, 1.1.38 and 1.0.108.
7. [ ] **Save your notes** from section 5 and the CE support report into today's date sub-folder in the CE Plugin Pilot Results folder (section 5, item 7), and tell Tim. Write "no problems" if there were none. (OPEN: Tim must still confirm Max can write there.)
