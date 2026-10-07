# What changed in your CE tools

**Civil 3.0.30 to 3.0.33. Manager 1.1.30 to 1.1.33. Structural 1.0.100 to 1.0.103.**
Written Wed 7 Oct 2026 (Melbourne time) from the finalizer, assembly and install reports of 4 to 7 Oct.

---

## 1. Answer first: what a drafter will notice

1. **Pit numbers stay as you type them.** Type C2 and you get C2, not PC2. Type "8" when P8 exists and CE refuses it with a sentence naming P8.
2. **New Pit opens with the cover level blank** after you restart AutoCAD. Place stays greyed out until you type a cover level.
3. **Prompts show each default once.** Structural questions that used to read "<600> <600>" now read "<600>" once. Enter still takes the default.
4. **FST: each change you make in the window is one U.** Delete a footing, close FST, press U, and the footing comes back.
5. **Plainer words everywhere**: Manager, CEHEALTH, CDCHECK, Structural beam and footing messages. Wording is the biggest change in Structural.

**Where each version stands (from the reports):**
1. **Installed and in use (from Wed 7 Oct):** Civil 3.0.33, Manager 1.1.33 (installed 7 Oct 21:16) and Structural 1.0.103 (installed 7 Oct 21:21).
2. **Earlier installs, still inside these:** Civil 3.0.32, Manager 1.1.32 and Structural 1.0.102 (installed 5 Oct). Items marked "3.0.33" or "1.0.103" below arrived in the 7 Oct installs and have NOT yet been opened in AutoCAD by Codex at the time of writing.
3. **Check your own version:** type CEHEALTH. It prints one line per product with its version.

**What has been tested, in plain words:**
1. **Built and unit-tested:** every item in this note.
2. **Opened in AutoCAD by Codex (on 3.0.32 and 1.0.102 only):** a handful of items. I say which. Everything else says "not verified in AutoCAD".
3. **Accepted by Tim:** nothing in this note is recorded as accepted by Tim.

---

## 2. CIVIL (3.0.31, 3.0.32, 3.0.33), grouped by what you do in AutoCAD

### 2.1 Placing pits

1. **New Pit cover level starts blank (3.0.33).** After a restart, the cover box is empty and Place is greyed until you type one. Tim ruled this ("Blank"). Nothing is ever stored as 0. Not verified in AutoCAD.
2. **Recall Last still works (3.0.33).** Click Recall Last in New Pit and the last cover (for example 12.340) fills in.
3. **You can switch the old behaviour back (3.0.33).** Type CDS, open the Survey tab, find "Last cover level in New Pit". It reads "Leave cover level blank". Choose "Propose last cover level" to get the old proposal.
4. **New Pit refuses a number another pit already uses (3.0.33).** Type 8 when P8 exists and press Place. A box titled "Pit number already used" says "There is already a pit P8. Type a different number." The window stays open and every level you typed stays in the boxes. Not verified in AutoCAD.
5. **New Pit asks about look-alikes (3.0.33).** Type "C 2" when C2 exists. A box says "This looks like C2. Continue?" Yes places it as typed. No keeps the window open. A free number such as 12 places with no question.
6. **Placing a pit no longer prints the duplicate block line (3.0.32).** The line "Duplicate definition of block _Dot ignored." should be gone, also after CDREFRESHBLOCKS. Codex did not see the line on 3.0.32, but its placement log was incomplete, so this is not fully certified.
7. **CDRENUMBER keeps your typed numbers (3.0.31, 3.0.33).** A pit you typed as 8 stays 8. The plan then runs P7, P9 and never makes a P8 beside it. One U takes the whole renumber back. Not verified in AutoCAD.

### 2.2 Editing pit numbers (three places)

Tim's rulings (5 Oct) are what these follow.

1. **Capitals only puts the old number back.** Type p5 over P5 and the pit stays P5. You see: "p5 is the same pit number as P5 (capitals and spaces do not count). P5 kept."
2. **"8" beside P8 is refused.** The pit keeps its own number and a sentence names P8: "8 is the same pit number as P8 (another pit). P5 kept."
3. **"C 2" beside C2 is allowed with a warning.** The rename goes ahead and the command line says "C 2 looks like C2 (another pit). Check the numbering."
4. **A free number stays exactly as typed.** Only spaces at the ends are trimmed.
5. **The Pit Schedule window (PITSCHEDULE):** type the number in the pit column and press Enter. A used number gives "Pit number 8 is the same pit number as P8 (another pit), so this pit keeps P5." This window accepts "C 2" with no warning line (see section 5).
6. **A placed Pit Schedule table cell:** a refused number puts the old number back in the cell. A cell on a locked layer, in an Xref or in a reference edit is never written.
7. **A plan pit label:** moving a label with MOVE reads the number you typed and applies the same rules. Double-click typing in a label also works for lettered numbers such as C2 (see section 5 for bare numbers).
8. **A pit you already have as PC2 can be corrected (3.0.31).** Type C2 on its row in the Pit Schedule, then right-click and choose Stop overriding. It becomes C2 on the plan, in the table and in both pipes' From and To.
9. **A level you typed is never moved by a rename (3.0.33).** Only the number and the pipes' From and To change.
10. **Labels on a locked layer are named (3.0.33).** If a second label of the pit is on a locked layer, one line says it still reads the old number. The layer stays locked.

### 2.3 Pipes and levels

1. **A typed level on a fixed-grade pipe changes only that end (3.0.31).** Pipe P3 to P2 is set to 1 in 100. You type a new P2 inlet level in the Pit Schedule. P3 stays put and the command line says "Only the end at P2 changed" with the real grade (about 1 IN 67 in the example).
2. **Both pit rows then show a warning (3.0.31).** The WARNING column reads "LABEL GRADE 1 IN 100, LEVELS GIVE ABOUT 1 IN 67". The tolerance is on the Settings page: Settings, Drafting, "Grade note tolerance". It starts at 10 %.
3. **Moving a flat pipe onto other pits keeps its pit names right (3.0.31).** MOVE a flat pipe so its ends land on two other pits. Its From and To follow the pits. The arrow does not turn when CE cannot prove the direction.
4. **A hand-typed invert level survives that move (3.0.31, fixed again in 3.0.32).** The 3.0.31 version could lose the "typed by hand" mark on one level. 3.0.32 fixes it, so a later grade recalculation will not overwrite your number. Not verified in AutoCAD.
5. **Relinking an open-end pipe keeps it downhill (3.0.31).** CE now reads levels the same way Edit Pipe does. Rising mains are still exempt.
6. **CDRECOVERINVERTS only writes levels it can prove (3.0.33).** It writes invert text only where CE can prove which end is upstream. It never assumes a 150 mm pipe size. One U removes everything it wrote.
7. **What CDRECOVERINVERTS tells you.** A pipe it cannot prove reads "CE could not prove which end is upstream, so nothing was written for it." A pipe with no size keeps its levels but gets no text. On old drawings, expect it to skip more pipes than 3.0.32 did, because 3.0.32 guessed.

### 2.4 Pit Schedule

1. **"Stop overriding" is the new name (3.0.31).** It replaces the old "Revert Row Override" menu item. The values you typed stay. Codex confirmed the new name on 3.0.31 and saw no old name.
2. **The hover text no longer promises Undo (3.0.32).** It now reads "Stop treating this row as an override. The values you typed stay." CE cannot promise Undo restores the plan label.
3. **The status line after clicking should say so (3.0.32).** Expected: "Stopped overriding this row. The values you typed stay." Codex did not see this sentence three times on 3.0.32. It is logged as BUG-408 and is still open.
4. **Cells a locked layer kept as drawn are shown (3.0.32).** If a placed table sits on a locked layer and a pit changed, the LINKED SCHEDULE badge reads OUT OF DATE. The status line says how many cells are out of date and to press Refresh.
5. **Opening the window changes nothing in the drawing (3.0.32).** Codex checked this on 3.0.32 and DBMOD stayed unchanged.
6. **Refresh updates the cells and skips protected ones.** It says "1 drawn schedule cell brought up to date." and leaves locked-layer, Xref and reference-edit cells alone, naming them.
7. **A caution on a large drawing.** PITSCHEDULE now scans the drawing each time it opens, so it may open a little slower. This was not measured.
8. **The badge sentence can be cut short on screen (3.0.32).** The full sentence is in the hover.
9. **Your current layer is put back (3.0.32).** If PITSCHEDULE finds your current layer gone, CE makes it current again and says "The current layer had gone missing; CE made layer ...". CE never thaws or unlocks a layer to do this. Codex confirmed the layer was kept on 3.0.32.

### 2.5 Undo and Redo, and working in two drawings

1. **Text edits in a second drawing no longer touch the first (3.0.33).** Before, double-clicking a label or cover level in drawing B could write into drawing A's pit with the same number. Now CE reads the drawing you are in first. Not verified in AutoCAD.
2. **Hovering a pit shows your drawing's values or nothing (3.0.33).** It never shows another drawing's pit.
3. **Closing one of two drawings.** The reports ask for a check that closing A then B gives no crash and no unwanted "save changes" question. Not verified in AutoCAD.
4. **Codex ran U and Redo on 3.0.32 (before 3.0.33).** All of these passed: grip-move a pit, COPY a pit, MOVE a pit with linked pipes, CDDISCIPLINE Civil to Structural and back, placing a pit, drawing a pipe, ERASE. REDO after a 12-second wait said "Everything has been redone". What an ERASE looks like after Redo was not checked by eye.
5. **Each new pit-number and CDRECOVERINVERTS action is one U.** U puts it all back.

### 2.6 Old metre drawings

1. **Pipe lengths in older metre drawings read correctly (3.0.31, 3.0.32).** On a metre drawing last saved before 3.0.27, grades read about "1 IN 100", not "1 IN 100000". This applies to CDRUNSOLVE, CDRENUMBER and the CDHUB redesign (3.0.31), and to the rules check and the "fix to minimum grade" proposal (3.0.32).
2. **Four places still read the old way.** Markup-to-change plans and the AI helper's network read still treat a metre drawing as millimetres. This is still on the bug list.
3. **Not verified in AutoCAD.** Codex tried on 3.0.32 but opened the wrong drawing and the result list showed rule values, not pipe grades.

### 2.7 Manager, health check and updates

1. **Plainer words in CEMANAGER and CEHEALTH (3.0.31).** Every module card now has a grey next-step line that names a real button. CEHEALTH no longer prints "DLL", "LoadOnStartup" or "staged".
2. **CEHEALTH checks the office IT folder (3.0.32).** The line reads "The office IT folder (where CE updates come from) can be reached." or "cannot be reached" with the folder path.
3. **CEHEALTH confirmed by Codex on 3.0.32.** Four lines: "[OK] Civil v3.0.32", "[OK] Structural v1.0.102", "[OK] office IT folder reached", "All checks passed".
4. **A missing program file gets a plain sentence (3.0.32).** For example "its program file is missing from this PC. Run the CE installer again." CEMANAGERDIAG no longer prints "DLL missing" or "missing bundle files". Not verified in AutoCAD.
5. **A failed update explains itself (3.0.32).** A box says "CE cannot find the update files in the office IT folder." The technical reason sits under "Details for your CE administrator". This cannot be tested without breaking an update, so it was not seen.
6. **CESURVEYREVIEW now works as the first command (3.0.32).** On a fresh AutoCAD start it opens CE Manager at Survey Intake. Not verified in AutoCAD.
7. **CEBLOCKINSERT is a hidden helper (3.0.32).** The CEBLOCKS palette uses it to place a block. It is not listed on the commands page.
8. **The Manager footer counts 11 commands now (3.0.32),** up from 9, because those two commands are real.
9. **Manager 1.1.33 has no new behaviour.** It is rebuilt alongside Civil 3.0.33 and shares the same CE_SHARED files.
10. **Updates cannot ship with missing or extra files (3.0.32).** The Manager build now stops if the file list is wrong. You will not see it, but a broken update is less likely.

### 2.8 Smaller changes you may notice

1. **CDCHECK prints "->" (3.0.31).** It used to print "\U+2192" on the old-pipes list and the Connect line.
2. **Pick-again prompt (3.0.31).** A small cleanup so a pick-again prompt appears once. The reports say no more than that.
3. **Behind the scenes (3.0.31).** An unused flip grip was removed. Nothing visible changes.

---

## 3. STRUCTURAL (1.0.101, 1.0.102, 1.0.103), roof down, footings last

### 3.1 Roof

1. **R1 asks once (1.0.102).** "Enter the tag text <R1>:" shows the default once. Enter tags R1. Escape draws nothing.
2. **ABFLIPAUTO question is clearer (1.0.102).** It reads "Skip the flip question when CE can tell which way the brace faces? [ON/OFF] <Off>:" with the list shown once.
3. **After AB, CE says when it skipped the flip question (1.0.102).** With ABFLIPAUTO ON: "CE could tell which way the brace faces, so it did not ask about flipping (ABFLIPAUTO is ON)."
4. **BT1 asks the truss number once (1.0.102).** "Bracing truss number [1-9] <1>:" appears once and Enter means 1.
5. **BT1 no longer prints the duplicate block line (1.0.103).** "Duplicate definition of block _Dot ignored." should not appear. Codex saw the line on 1.0.102. CE switches messages off only while it reads the block, then puts the setting back. Not verified in AutoCAD for Structural.
6. **CSWINDCLASS help reads clearly (1.0.102).** The Topography line explains the keywords. Typing H picks Hill top.

### 3.2 Upper floors

1. **Each question shows its default once (1.0.101, 1.0.102).** A change across about 80 questions in 1.0.102. Enter takes the default. Escape cancels.
2. **BEAM questions have plainer words (1.0.101, 1.0.102).** BEAM is not a typed command. The beam commands are 1, 2, 4, 5 and BDL (Codex's finding). The first question reads "Select the first support (a support block or a line), or press Enter to pick points:".
3. **After picking a line as first support (1.0.102).** The next question offers "[Point/WholeLine] <WholeLine>" and Enter draws along the whole line.
4. **Codex saw this on 1.0.102 (command 1).** Each prompt appeared once and one U removed the beam. A second run cancelled with "Nothing was written."
5. **BDL asks once (1.0.101).** "BEAM LOWER offset distance <n>:" and "Enter BEAM LOWER text <BR7>:" each appear once. Enter takes them.
6. **BTX tells you what happened (1.0.102).** With nothing to convert: "There is no TEXT or MTEXT in that selection. Nothing changed." With text: "BTX done: 2 TEXT changed to MTEXT, 0 MTEXT changed to TEXT, 0 skipped." Codex saw the second one. U takes it back.
7. **SBEAM and SBEAMEDIT say what is wrong (1.0.102).** Click the same point twice and you get a message to pick two different points. SBEAMEDIT on a locked-layer or Xref section says so and "nothing was unlocked". Nothing is bypassed.
8. **STRUCLINKTEXT questions are clearer (1.0.102).** First "Select the object the label belongs to (a block, line or polyline):" then "Select the label text:".
9. **CETEXT repeats its last text once (1.0.101).** "Enter text or <last>:" shows once.
10. **Beam settings (command 8) fallback prompts show one default (1.0.102).** If the window does not open, the command-line version works the same way.
11. **Beam support-block questions say "support block or line" (1.0.101).** The same-object and "cannot draw a beam between those two" lines are plainer.

### 3.3 Ground floor, slab and raft

1. **CSREOBAR shows its defaults once (1.0.101, 1.0.102).** "Bar size", "Number of bars <8>" and "Place this reo bar? [Yes/No] <Yes>" each appear once.
2. **CEHATCHGAP, STIRRUP, CEHATCHAUDIT, level and section marks show defaults once (1.0.101, 1.0.102).** For example CEHATCHGAP "<5>" once, and STIRRUP "Cover (mm) <30>:" once.
3. **Basement wall with a site-cut batter (1.0.102).** It asks "Excavation depth for the site-cut batter, 0 to skip <0>:" once. Enter means 0.
4. **BATTER and support-block commands have clearer refusals (1.0.102).** BATTER says "CE could not read one of those lines, so nothing was drawn". Two new lines say "pick again", but the command has already ended. Type the command again and pick again.

### 3.4 Footings (last)

1. **FST: one U per change (1.0.101).** Every window button is one Undo step: Regenerate, Regenerate all, Delete footing, Rename, Delete system, Re-link, Remove unlinked, and the Size library OK. FST, Delete PF2, close, then U brings PF2 back on the drawing and in the FST list.
2. **Codex checked part of this on 1.0.101 and 1.0.102.** Delete PF2 plus one U passed. The locked-layer delete showed a warning, unlocked nothing and U brought PF2 back. Some FST Undo cases were not completed (see section 5).
3. **FST Cancel writes nothing (1.0.101).** Opening FST and pressing Cancel should leave the drawing unmodified (DBMOD 0). Not verified in AutoCAD.
4. **The delete footer keeps its true sentence (1.0.101).** When the redraw was refused because of a locked layer, the footer says so and does not say "or changed".
5. **FST Re-link keeps AutoCAD's protection (1.0.103).** Click "Link selected element" and pick a line on a locked layer. A box says "That line is on locked layer '...', so CE did not re-link the footing (nothing was unlocked)." The layer stays locked and there is no empty U.
6. **Re-link also refuses an Xref, an object outside model space, and a pick during a reference edit (1.0.103).** Text is rejected at the pick with "Pick a line, polyline, arc, circle or pile block."
7. **Re-link checks the shape for the footing type (1.0.103).** A strip footing given a circle says "A strip or beam footing follows a line, polyline or arc, so CE did not re-link it. Pick one of those." This is new: before, FST accepted any object.
8. **FST has one code path now (1.0.103).** An old second copy of FST was removed. You will not see it.
9. **FSF, FPFC and FEDIT show each default once (1.0.101, 1.0.102).** The order is unchanged. Examples are "Enter Y size <same as X>:" (Enter makes a square) and "Enter depth <0 to skip>:" (Enter means 0). A second FPFC with PF1 asks the Yes/No/Increment question once and Enter makes PF2.

```before
Enter new X size <600> <600>:
```
```after
Enter new X size <600>:
```

10. **FEDIT Enter keeps the footing exactly (1.0.101).** Press Enter at the size and depth questions and LIST shows no change. The summary says "Pad footing", not "PadFooting" (1.0.102).
11. **The units question is plainer (1.0.101).** On a drawing with units not set and imperial measurement, it shows "[Yes/No] <No>" once and No ends FEDIT. FST never asks it.
12. **A decimetre, yard or kilometre drawing is refused clearly (1.0.102).** FPFC says the drawing's units are decimetres and CE has not run this command, and tells you to check what the drawing is really drawn in (LIST one footing). Nothing is drawn. Codex saw the exact text.
13. **Footing sizes after a grip drag or STRETCH read in millimetres (1.0.103).** In a centimetre drawing a 70 by 60 pad now reads "700 x 600 mm", not "70 x 60 mm". In an inch drawing a 24-inch pad reads 610. Millimetre drawings are unchanged. Not verified on a real command line.
14. **The support-ring minimum is 50 mm, not 50 drawing units (1.0.103).** In a metre drawing that was 50 m before.
15. **The units warning shows only where CE cannot convert (1.0.103).** That means units not set with imperial measurement, or a unit AutoCAD does not define.
16. **FEDIT outline pick measures a strip with no recorded width (1.0.103).** It uses the default band width in the drawing's units. If CE cannot tell which footing you meant it says "Pick the pad or its label. Nothing changed."
17. **Footing grip warning names the unit (1.0.101).** In a metre drawing it says "metres", not "INSUNITS = 6". Not verified in AutoCAD.

### 3.5 Behind the scenes (not a drawing job)

1. **The Structural machine report no longer carries your login (1.0.102).** The report file name and its UserName and MachineName fields are 16-character codes. Civil still names its file with the real login (see section 5).

---

## 4. WHAT IS NOT DONE OR STILL SWITCHED OFF

Nothing here is promised beyond what is installed.

1. **CSFDNPROPOSE ("Propose footings") is hidden and OFF (1.0.103).** It is not in the ribbon, the palette or help. If you type it, you get exactly "Propose footings is not switched on in this version. Nothing was proposed or drawn." and nothing else. There is no Settings control for it yet. Do not try to switch it on.
2. **In 1.0.102 CSFDNPROPOSE said "Unknown command".** Codex saw this, as intended. In 1.0.103 it is a known command that does nothing.
3. **The footing-proposal engine is OFF by default.** When it is eventually switched on, proposed footing sizes read "Unknown", never 0.
4. **Steepest-pipe limit.** Tim ruled: no fixed limit, a Settings value, a warning above 1 in 10, never a block. That change is not in these releases.
5. **Same-day re-issue replaces the earlier set; issue with no sheet ticked.** Tim ruled both. The issue-set changes are not in these releases.
6. **"A level typed in the Pit window is never moved".** Tim ruled this. The rename routes in 3.0.33 already keep to it. The separate Pit-window change for it is not in these releases.
7. **Two Civil changes were held out.** One would bring back a fixed 1-in-20 steepness limit, against Tim's ruling. The other rewrites the "Stop overriding" message and needs rework.
8. **Roof and floor point-load carry-down, member schedule from plan, title block question for new jobs, downpipe layouts.** Tim ruled on all of them. None is in the train lists for these releases.
9. **Clearances (footing and service distances in metres).** Tim has not typed the numbers. They stay Unknown and will live on the Settings page.
10. **Charged rising pipe flips on a grip drag.** Tim ruled "keep it, with a one-line message that it flipped". The sources do not confirm that message is in these builds.
11. **The one-line Stop overriding sentence** is in the code but Codex has not seen it on screen (BUG-408).

---

## 5. KNOWN LIMITS AND THINGS TO CHECK FIRST

1. **F2 runs CLEAN.** In this setup, pressing F2 for the text window runs the CE command CLEAN (purge, restyle, regen on the open drawing). Use TEXTSCR and GRAPHSCR to flip the text window. Logged as BUG-411.
2. **Edit Pit has no pit-number clash check (older than 3.0.32).** Edit Pit on P5, type P8 while a P8 exists, Apply: read in code, not run, this could remove P8's own data row and join P5's pipes to the name P8. Until fixed, use the Pit Schedule window to renumber. It is on the list to fix.
3. **Pit Schedule window accepts "C 2" beside C2 with no warning line.** The placed cell, plan label and New Pit all warn. Only the window does not.
4. **A plan label typed as a bare number by double-click is refused with a generic sentence.** "Pit ID must be one compact identifier such as P1 or SPS1." The label keeps showing what you typed. A later MOVE of that label then renames the pit, to "12" quietly if 12 is free. Nothing is lost, but it is late and quiet.
5. **A stale table cell can rename a pit on MOVE.** A placed table cell that still shows an old number (because its layer was locked at the last refresh) is read as typed when you MOVE it after unlocking.
6. **Double-click typing in a placed table cell may not reach CE.** CE pauses while TEXTEDIT, MTEDIT or DDEDIT run, and no other route was found. If you type C2 over P5 and nothing changes after the next refresh, this is why. Same as 3.0.30. Not verified in AutoCAD.
7. **Look-alike numbers.** On 3.0.31 and 3.0.32 a typed "8" beside P8 was accepted as two pits. From 3.0.33 it is refused. "C 2" beside C2 is still accepted, by Tim's ruling, with a warning.
8. **Pit placement message.** After placing a pit on 3.0.32, Codex saw once: "CE could not save its pipe and pit record with this command. It will be saved with your next command." The cause is not yet found (BUG-412). Say so if you see it.
9. **CDRECOVERINVERTS may skip many pipes on old drawings.** It will not guess. The final line counts the skips, so read it.
10. **"Undo takes it back" is no longer promised on Stop overriding.** The Pit Schedule's own Undo restores CE's data, but the reports found nothing that puts plan label text back. Check what U brings back.
11. **FST Undo cases not all completed.** Some FST Undo checks were blocked or are not recorded as done, including U after an FST Zoom (it should take back only the zoom). If, after an FST Delete, U does nothing, or takes back two commands, or brings back a footing on the drawing but not in FST, stop using FST Delete on real jobs and tell Tim.
12. **FST footing grip resize line mixes units (1.0.103).** After AutoCAD's own STRETCH in a centimetre drawing, the first line gives drawing units with no unit word and the second gives millimetres.
13. **BT1 still prints a file path and old-style error lines.** "✓ BRACING block loaded successfully from: <path>" and "✗ ERROR: ..." are unchanged and not yet in plain words.
14. **Civil's machine report file name still carries your Windows login and computer name.** Structural's does not (BUG-413).
15. **Not measured on a real job:** the cost of the extra record read when you start a text edit, and PITSCHEDULE's extra scans on a large drawing.
16. **AutoCAD 2022 to 2024.** These builds were built and unit-tested. The reports list failures that come from the older reference files in the test host, not from the product. Nothing here was opened in those versions.
17. **Old test failure.** One long-known Civil calculation test (Glen Eira detention back-test, 34.6 % against 30 %) is still red. It is not new and not touched by this release.

---

## 6. IF SOMETHING LOOKS WRONG

1. **Stop and use a copy.** Do not save over your original drawing while you check. Press U once and see what comes back.
2. **Tell Tim.** The sources name no other support route for colleagues, so I do not invent one.
3. **Write down these seven things:**
   1. **Version:** type CEHEALTH and copy the Civil and Structural lines.
   2. **Command:** the exact command you typed, and what you clicked.
   3. **Drawing:** the file name, and whether it is an older metre drawing.
   4. **Expected:** what you thought would happen.
   5. **Saw:** what happened, and the exact words on the command line. Use TEXTSCR to read them. Do not press F2.
   6. **U result:** did one U put it back, do nothing, or take back two commands?
   7. **Time:** when it happened (Melbourne time).
4. **Do not delete CE's log files.** CE keeps its own logs in your CE_CVL_SUITE and CE_STRUC_SUITE folders under AppData. They help find the cause.
5. **Pit numbers: do not fix by hand.** If a pit number looks wrong, do not retype it in Edit Pit. Tell Tim first. Edit Pit has no clash check (section 5, item 2).
6. **FST: if U goes wrong after Delete,** stop using FST Delete on real jobs and report it.
7. **If CE does not load,** tell Tim, and say what AutoCAD showed at start. Do not reinstall by hand.

---

## 7. Where this came from

Reports read: the Opus finalizer reports for each train (C-17, C-18, C-19, S-18, S-19, S-20), the matching assembly reports, the payload reports for the three installs and the Codex results in the release queue (items 160 to 206), plus Tim's rulings in the 28 Sep to 7 Oct decisions file (INT-059 to INT-064).

1. **Civil 3.0.31 (installed 4 Oct):** PR #637, #660, #645, #654, #659, #646, #643, #641, #656, #634, #663, #655, #661.
2. **Civil 3.0.32 (installed 5 Oct):** PR #666, #671, #669, #681, #685, #683, #658, #677, #684.
3. **Civil 3.0.33 (built, not installed):** PR #667, #695, #670, #687, #723, #734, #705, #715, #731. Left out: #722 and #740.
4. **Manager 1.1.31 to 1.1.33:** the Manager changes are inside the Civil trains above (#663, #669, #681, #684, #677).
5. **Structural 1.0.101 (installed 4 Oct):** PR #664, #647, #651, #652, #653.
6. **Structural 1.0.102 (installed 5 Oct):** PR #672, #662, #674, #675, #688, #630, #686. PR #678 was dropped.
7. **Structural 1.0.103 (built, not installed):** PR #738, #673, #665, #744.
8. **Reports used:** TRAIN_C17, C18, C19, S18, S19 and S20 finalizer and assembly reports, and PAYLOAD_C1018, C1019 and S1021 reports in `C:\Lisp Files\_TEST_COPIES_20260923`.
