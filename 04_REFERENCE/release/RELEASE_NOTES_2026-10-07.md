# What changed in your CE tools

**Civil 3.0.30 to 3.0.34. Manager 1.1.30 to 1.1.34. Structural 1.0.100 to 1.0.104.**
Written Wed 7 Oct 2026 (Melbourne time) from the finalizer, assembly and install reports of 4 to 7 Oct. **Corrected Thu 8 Oct 2026** by an accuracy read against the installed code and the Codex AutoCAD reports W10 to W17 (list of corrections: `RELEASE_DOCS_ACCURACY_READ_2026-10-08.md`).

---

## 1. Answer first: what a drafter will notice

1. **Pit numbers stay as you type them.** Type C2 and you get C2, not PC2. Type "8" in New Pit or Edit Pit when P8 exists and CE refuses it with a sentence naming P8. **Exception:** the Pit Schedule window itself does not refuse it yet (section 5, item 3).
2. **New Pit opens with the cover level blank** after you restart AutoCAD. Place stays greyed out until you type a cover level.
3. **Prompts show each default once.** Structural questions that used to read "<600> <600>" now read "<600>" once. Enter still takes the default.
4. **FST: each change you make in the window is one U.** Delete a footing, close FST, press U, and the footing comes back.
5. **Edit Pit now refuses a number another pit already has (3.0.34).** Before, it could wipe the other pit's record.
6. **Plainer words everywhere**: Manager, CEHEALTH, CDCHECK, Structural beam, bracing and footing messages. Wording is the biggest change in Structural.

**Where each version stands (read from the installed program files 8 Oct):**
0. **Installed now (8 Oct 03:59): Civil 3.0.35 and Manager 1.1.35**, with Structural 1.0.104 unchanged. Structural 1.0.105 is to follow. The 3.0.35 changes (PR 762, 763, 766, 747, 774, 777) are NOT described below and no Codex pass has seen 3.0.35 yet. Everything below is written for 3.0.34 / 1.1.34 / 1.0.104, which 3.0.35 contains.
1. **Installed and in use before that (from Thu 8 Oct 00:50):** Civil 3.0.34 and Manager 1.1.34 (installed 8 Oct 00:50), Structural 1.0.104 (installed 8 Oct 00:56).
2. **Earlier installs, still inside these:** Civil 3.0.33, Manager 1.1.33 (7 Oct 21:16) and Structural 1.0.103 (7 Oct 21:21); Civil 3.0.32, Manager 1.1.32 and Structural 1.0.102 (5 Oct).
3. **Check your own version:** the AutoCAD status bar shows "CE MANAGER v1.1.34 [Modern]", "CE CVL SUITE v3.0.34" and "CE STRUC SUITE v1.0.104". Or type CEHEALTH: it prints one line for Civil and one for Structural (not Manager), then a line about the office IT folder.

**What has been tested, in plain words:**
1. **Built and unit-tested:** every item in this note.
2. **Seen working by Codex in real AutoCAD (copies of test drawings, Tim's PC):** the items marked "Codex saw it". Runs: W10 to W13 on 3.0.32 / 1.0.102, W14 and W15 on 3.0.33 / 1.0.103, W16 and W17 on 3.0.34 / 1.0.104.
3. **Everything else says "not checked in AutoCAD".**
4. **Accepted by Tim:** nothing in this note is recorded as accepted by Tim.

---

## 2. NEW IN CIVIL 3.0.34, MANAGER 1.1.34 AND STRUCTURAL 1.0.104 (installed 8 Oct)

### 2A. Civil 3.0.34 and Manager 1.1.34

1. **Edit Pit refuses a pit number another pit already has.** In PITEDIT on P10, type P9 (or just 9) while P9 exists and press Save. The command line says "[CE] Pit number P9 is already used by another pit (P9), so this pit keeps P10. Type a number no other pit uses. Nothing was changed. Your entries have been kept — correct them and press Update again." and the window opens again with your number still typed. Codex saw it (W16, both "P9" and "9"). The sentence says "Update" but the button reads Save: press Save.
2. **Edit Pit: small letters become capitals.** Type p10 over P10 and it stays P10. Codex saw it (W16), and U then REDO worked.
3. **Edit Pit: a free number is not fully checked yet.** Codex renamed a pit to 77 ("Pit updated.") but did not read the schedule row or pipes afterwards. Not checked in AutoCAD on a pit with pipes.
4. **Pit Schedule: "Stop overriding" now says what it did.** Right-click an overridden row and choose Stop overriding. The bottom-left of the window reads "Stopped overriding this row. The values you typed stay." The cover you typed stays and the override mark goes. Codex saw it (W16). This was BUG-408.
5. **Undo after the Pit Schedule window.** There is no Undo button in the window. Close it and press U once: U takes back the whole Pit Schedule visit, every edit in it. Codex saw U echo "PITSCHEDULE" and REDO work (W16); what each cell went back to was not read.
6. **CDFIXFLATPIPES now offers steep pipes it used to refuse.** A flattened pipe whose label held 1 in 5 used to read "Check by hand". It is now offered with "; steep: 1 in 5 is steeper than 1 in 10 (Settings warning) - check it", and a typed Yes writes the levels. Tim's steep-pipe ruling (no fixed limit, warn above 1 in 10, never block) was about proposed levels; applying it here is the release chat's reading. **Tim should see this once.** Codex saw only the "No flat pipes found: every pipe with a recorded grade falls. Nothing was changed." line (W16); the steep line is not checked in AutoCAD.
7. **The steep-pipe values are not on the Settings window yet.** The warning (1 in 10) and the limit (none) live only in the settings file, although the message says "Settings warning".
8. **CDRULES wording.** A pit at the top of a line with two pipes leaving it and no main outlet chosen now says "no incoming pipe" instead of "main outlet needs confirmation". Not checked in AutoCAD.
9. **Report files no longer carry your login (Civil and Manager).** New machine report files are named with 16-character codes, not your Windows login or computer name. Codex saw the new names (W16, W17). The old real-named Civil file stays on the PC, the Manager report still has the real names inside it, and a support bundle (CESUPPORT) is still named with the computer name. Tim has ruled all three should be cleaned up (section 5A, item 4); not built yet.
10. **Civil 3.0.34 and Manager 1.1.34 must be installed together.** They share CE_SHARED, and it changed in this release.

### 2B. Structural 1.0.104

1. **BT1 says plainly that the block loaded.** The first BT1 in a drawing prints "The BRACING block is loaded into this drawing." with no file path. The next BT1 in the same drawing does not print it again. No "Duplicate definition of block _Dot ignored." Codex saw it (W17). AB and the other bracing commands use the same words.
2. **BTX with nothing to convert.** Window only lines and press Enter: "There is no TEXT or MTEXT in that window." Nothing changes. Escape prints nothing. Codex saw it (W17).
3. **STS1 refuses a block that is not a support block.** Pick an ordinary block: "That is not a support block, so nothing changed. Type the command again and pick a support block." Codex saw it (W17). The same words apply to SDS, SDS1, SC1, SC2, TDS, TDS1, TTS1 and TC1.
4. **BATTER's refusal tells you what to do.** "[BATTER] CE could not read one of those lines, so nothing was drawn. Type BATTER again and pick the top and bottom lines." It is very hard to reach. Not checked in AutoCAD.
5. **A footing stretched with AutoCAD's own STRETCH reports millimetres.** In a centimetre drawing: "PF1 was resized in the drawing; CE's footing record now says 800 x 600 mm." (not "80 x 60"). In an inch drawing the two lines round differently (609.6 then 610). Not checked in AutoCAD.
6. **CSFDNPROPOSE stays hidden and OFF.** Its help sentence now ends "Not switched on in this version." Codex saw it still does nothing (W17).
7. **Structural reports scrub your login from three more fields** (source folder, status line and the drawing name in usage reports). A login glued to other letters or digits in a drawing name (login + "2.dwg") is not scrubbed.

---

## 3. CIVIL (3.0.31, 3.0.32, 3.0.33), grouped by what you do in AutoCAD

### 3.1 Placing pits

1. **New Pit cover level starts blank (3.0.33).** After a restart, the cover box is empty and the place button is greyed with "Enter the cover level." until you type one. Tim ruled this ("Blank"). Nothing is ever stored as 0. Codex saw it (W14).
2. **Recall Last (3.0.33).** The New Pit window has a Recall Last button in its code, which should fill in the last cover (for example 12.340). **Not checked in AutoCAD:** Codex could not see the button on the New Pit window (W14).
3. **You can switch the old behaviour back (3.0.33).** Type CDS, open the Survey tab, find "Last cover level in New Pit". It reads "Leave cover level blank". Choose "Propose last cover level" to get the old proposal. Codex read the setting (W14) but did not change it.
4. **New Pit refuses a number another pit already uses (3.0.33).** Type 1 when P1 exists and press Place. A box titled "Pit number already used" says "There is already a pit P1. Type a different number." The window stays open and every level you typed stays in the boxes. Codex saw it (W14).
5. **New Pit asks about look-alikes (3.0.33).** Type "C 2" when C2 exists. A box titled "Check pit number" says "This looks like C2. Continue?" Yes places it as typed. No keeps the window open. A free number places with no question. Codex saw it (W14).
6. **Placing a pit no longer prints the duplicate block line (3.0.32).** "Duplicate definition of block _Dot ignored." did not appear in a full placement transcript Codex read on 3.0.33 (W14).
7. **CDRENUMBER keeps your typed numbers (3.0.31, 3.0.33).** A pit you typed as 8 stays 8. The plan then runs P7, P9 and never makes a P8 beside it. One U takes the whole renumber back. **Watch:** the question "Apply? [Yes/No] <No>" defaults to No, so Enter cancels ("Renumber cancelled - nothing changed."). Type Y to apply. The renumber itself is not checked in AutoCAD.

### 3.2 Editing pit numbers (three places)

Tim's rulings (5 Oct) are what these follow. Items 1 to 4 apply to a placed Pit Schedule table cell and a plan pit label. **None of them is checked in AutoCAD yet.**

1. **Capitals only puts the old number back.** Type p5 over P5 and the pit stays P5. You see: "[CE] p5 is the same pit number as P5 (capitals and spaces do not count). P5 kept."
2. **"8" beside P8 is refused.** The pit keeps its own number and a sentence names P8: "[CE] 8 is the same pit number as P8 (another pit). P5 kept."
3. **"C 2" beside C2 is allowed with a warning.** The rename goes ahead and the command line says "C 2 looks like C2 (another pit). Check the numbering."
4. **A free number stays exactly as typed.** Only spaces at the ends are trimmed.
5. **The Pit Schedule window (PITSCHEDULE) does NOT refuse yet.** The code has the sentence "Pit number 8 is the same pit number as P8 (another pit), so this pit keeps P5." but in AutoCAD Codex typed "2" over P1 (P2 exists) and "p1" over P1: the cell took both and no line appeared (W14, BUG-420, still open in 3.0.34). Do not renumber in this window until it is fixed. It also accepts "C 2" with no warning (section 5).
6. **A placed Pit Schedule table cell:** a refused number puts the old number back in the cell. A cell on a locked layer, in an Xref or in a reference edit is never written.
7. **A plan pit label:** moving a label with MOVE reads the number you typed and applies the same rules. Double-click typing in a label also works for lettered numbers such as C2 (see section 5 for bare numbers).
8. **A pit you already have as PC2 can be corrected (3.0.31).** Type C2 on its row in the Pit Schedule, then right-click and choose Stop overriding. It becomes C2 on the plan, in the table and in both pipes' From and To. Not checked in AutoCAD, and the window route has the fault in item 5.
9. **A level you typed is never moved by a rename (3.0.33).** Only the number and the pipes' From and To change. Not checked in AutoCAD.
10. **Labels on a locked layer are named (3.0.33).** If a second label of the pit is on a locked layer, one line says it still reads the old number. The layer stays locked. Not checked in AutoCAD.

### 3.3 Pipes and levels

1. **A typed level on a fixed-grade pipe changes only that end (3.0.31).** Pipe P3 to P2 is set to 1 in 100. You type a new P2 inlet level in the Pit Schedule. P3 stays put and the command line says "Only the end at P2 changed" with the real grade (about 1 IN 67 in the example). Not checked in AutoCAD.
2. **Both pit rows then show a warning (3.0.31).** The WARNING column reads "LABEL GRADE 1 IN 100, LEVELS GIVE ABOUT 1 IN 67". The tolerance is on the Settings window (type CDS): Drafting tab, "Grade note tolerance". It starts at 10 %.
3. **Moving a flat pipe onto other pits keeps its pit names right (3.0.31).** MOVE a flat pipe so its ends land on two other pits. Its From and To follow the pits. The arrow does not turn when CE cannot prove the direction. Not checked in AutoCAD.
4. **A hand-typed invert level survives that move (3.0.31, fixed again in 3.0.32).** A later grade recalculation will not overwrite your number. Not checked in AutoCAD.
5. **Relinking an open-end pipe keeps it downhill (3.0.31).** CE now reads levels the same way Edit Pipe does. Rising mains are still exempt. Not checked in AutoCAD.
6. **CDRECOVERINVERTS only writes levels it can prove (3.0.33).** It writes invert text only where CE can prove which end is upstream. It never assumes a 150 mm pipe size. One U removes everything it wrote. Not checked in AutoCAD.
7. **What CDRECOVERINVERTS tells you.** A pipe it cannot prove reads "CE could not prove which end is upstream, so nothing was written for it." A pipe with no size keeps its levels but gets no text. On old drawings, expect it to skip more pipes than 3.0.32 did, because 3.0.32 guessed.

### 3.4 Pit Schedule

1. **"Stop overriding" is the new name (3.0.31).** It replaces the old "Revert Row Override" menu item. The values you typed stay. Codex confirmed the new name and saw no old name.
2. **The hover text no longer promises Undo (3.0.32).** It now reads "Stop treating this row as an override. The values you typed stay."
3. **The sentence after clicking (3.0.34).** "Stopped overriding this row. The values you typed stay." at the bottom left. Missing in 3.0.32 and 3.0.33 (BUG-408); Codex saw it on 3.0.34 (W16).
4. **Cells a locked layer kept as drawn are shown (3.0.32).** If a placed table sits on a locked layer and a pit changed, the LINKED SCHEDULE badge reads OUT OF DATE. The status line says how many cells are out of date and to press Refresh. Not checked in AutoCAD.
5. **Opening the window changes nothing in the drawing (3.0.32).** Codex checked this and DBMOD stayed unchanged (W10).
6. **Refresh updates the cells and skips protected ones.** It says "1 drawn schedule cell brought up to date." and leaves locked-layer, Xref and reference-edit cells alone, naming them. Not checked in AutoCAD.
7. **A caution on a large drawing.** PITSCHEDULE now scans the drawing each time it opens, so it may open a little slower. This was not measured.
8. **The badge sentence can be cut short on screen (3.0.32).** The full sentence is in the hover.
9. **Your current layer is put back (3.0.32).** If PITSCHEDULE finds your current layer gone, CE makes it current again and says "The current layer had gone missing; CE made layer ... current again." CE never thaws or unlocks a layer to do this. Codex confirmed the layer was kept (W10).

### 3.5 Undo and Redo, and working in two drawings

1. **Text edits in a second drawing no longer touch the first (3.0.33).** Before, double-clicking a label or cover level in drawing B could write into drawing A's pit with the same number. Now CE reads the drawing you are in first. Not checked in AutoCAD (in W14 the double-click opened Edit Pit instead of a text editor).
2. **Hovering a pit shows your drawing's values or nothing (3.0.33).** It never shows another drawing's pit. Not checked in AutoCAD.
3. **Closing one of two drawings.** Codex closed A then B on 3.0.33: no crash, and each save question named the drawing that had changed (W14).
4. **Codex ran U and Redo on 3.0.32 and 3.0.33.** All of these passed: grip-move a pit, COPY a pit, MOVE a pit with linked pipes, CDDISCIPLINE Civil to Structural and back, placing a pit, drawing a pipe (CD), ERASE. REDO after a 12-second wait said "Everything has been redone". What an ERASE looks like after Redo was not checked by eye.
5. **REDO after switching drawings.** Place a pit in A, U, switch to B, come back: REDO says "Nothing to redo" (W14). That is a known limit when you switch drawings.
6. **Each new pit-number and CDRECOVERINVERTS action is one U.** U puts it all back. Not checked in AutoCAD for CDRECOVERINVERTS.

### 3.6 Old metre drawings

1. **Pipe lengths in older metre drawings read correctly (3.0.31, 3.0.32).** On a metre drawing last saved before 3.0.27, grades read about "1 IN 100", not "1 IN 100000". This applies to CDRUNSOLVE, CDRENUMBER and the CDHUB redesign (3.0.31), and to the rules check and the "fix to minimum grade" proposal (3.0.32).
2. **Four places still read the old way.** Markup-to-change plans and the AI helper's network read still treat a metre drawing as millimetres. This is still on the bug list (BUG-406).
3. **Not checked in AutoCAD.** Codex tried three times (W10, W13, W14). The test drawing gave no pipe grades at all (every rule read Unknown), so a better test drawing is needed.

### 3.7 Manager, health check and updates

1. **Plainer words in CEMANAGER and CEHEALTH (3.0.31).** Every module card now has a grey next-step line that names a real button. CEHEALTH no longer prints "DLL", "LoadOnStartup" or "staged".
2. **CEHEALTH checks the office IT folder (3.0.32).** The line reads "The office IT folder (where CE updates come from) can be reached." or "cannot be reached" with the folder path.
3. **CEHEALTH seen by Codex on 3.0.34 (W16).** Lines: "[CEHEALTH] Checking the CE tools on this PC...", "[OK] CE Civil Suite v3.0.34", "[OK] CE Structural Suite v1.0.104", "[OK] The office IT folder (where CE updates come from) can be reached.", "[CEHEALTH] All checks passed."
4. **A missing program file gets a plain sentence (3.0.32).** CEMANAGERDIAG says, for example, "its program file is missing from this PC. Run the CE installer again." It no longer prints "DLL missing" or "missing bundle files". Not checked in AutoCAD.
5. **A failed update explains itself (3.0.32).** A box says "CE cannot find the update files in the office IT folder." The technical reason sits under "Details for your CE administrator". This cannot be tested without breaking an update, so it was not seen.
6. **CESURVEYREVIEW now works as the first command (3.0.32).** On a fresh AutoCAD start it opens CE Manager at Survey Intake. Not checked in AutoCAD.
7. **CEBLOCKINSERT is a hidden helper (3.0.32).** The CEBLOCKS palette uses it to place a block. It is not listed on the commands page.
8. **Manager has 11 commands now (3.0.32),** up from 9, because those two commands are real. The footer count on screen is not checked in AutoCAD.
9. **Manager 1.1.33 had no new behaviour.** Manager 1.1.34 renames its machine report file (section 2A, item 9).
10. **Updates cannot ship with missing or extra files (3.0.32).** The Manager build now stops if the file list is wrong. You will not see it, but a broken update is less likely.

### 3.8 Smaller changes you may notice

1. **CDCHECK prints "->" (3.0.31).** It used to print "\U+2192" on the old-pipes list and the Connect line.
2. **Pick-again prompt (3.0.31).** A small cleanup so a pick-again prompt appears once. The reports say no more than that.
3. **Behind the scenes (3.0.31).** An unused flip grip was removed. Nothing visible changes.

---

## 4. STRUCTURAL (1.0.101, 1.0.102, 1.0.103), roof down, footings last

### 4.1 Roof

1. **R1 asks the tag once (1.0.102).** R1 first asks four picks: "Pick LEFT beam or wall [Object/Point] <Object>:" (Codex saw this, W15), then RIGHT, then TOP/near side, then BOTTOM/far side. Only then "Enter the tag text <R1>:", where the default is the last tag you used, shown once. Enter takes it. Escape draws nothing. The tag question is not checked in AutoCAD.
2. **ABFLIPAUTO question is clearer (1.0.102).** It reads "Skip the flip question when CE can tell which way the brace faces? [ON/OFF] <On>:" with the list shown once. The default shown is your own current value (Tim's is On).
3. **After AB, CE says when it skipped the flip question (1.0.102).** With ABFLIPAUTO ON: "CE could tell which way the brace faces, so it did not ask about flipping (ABFLIPAUTO is ON)." Not checked in AutoCAD.
4. **BT1 asks the truss number once (1.0.102).** "Bracing truss number [1-9] <1>:" appears once and Enter means 1. Not checked in AutoCAD.
5. **BT1 no longer prints the duplicate block line (1.0.103).** "Duplicate definition of block _Dot ignored." did not appear on 1.0.103 or 1.0.104 (Codex W15 and W17). CE switches messages off only while it reads the block, then puts the setting back (NOMUTT stayed 0).
6. **CSWINDCLASS help reads clearly (1.0.102).** The Topography line explains the keywords. Typing H picks Hill top. Not checked in AutoCAD.

### 4.2 Upper floors

1. **Each question shows its default once (1.0.101, 1.0.102).** A change across about 80 questions in 1.0.102. Enter takes the default. Escape cancels.
2. **BEAM questions have plainer words (1.0.101, 1.0.102).** BEAM is not a typed command. The beam commands are 1, 2, 4, 5 and BDL. The first question reads "Select the first support (a support block or a line), or press Enter to pick points:".
3. **After picking a line as first support (1.0.102).** The next question offers "[Point/WholeLine] <WholeLine>" and Enter draws along the whole line. Not checked in AutoCAD.
4. **Codex saw command 1 work (W13, 1.0.102).** Each prompt appeared once, the result read "Beam placed. One UNDO removes the complete beam.", one U removed the beam, and a second run cancelled with "Beam cancelled. Nothing was written."
5. **BDL asks once (1.0.101).** "BEAM LOWER offset distance <n>:" and "Enter BEAM LOWER text <BR7>:" each appear once. Enter takes them. Not checked in AutoCAD.
6. **BTX tells you what happened (1.0.102, 1.0.104).** With text: "BTX done: 1 TEXT changed to MTEXT, 0 MTEXT changed to TEXT, 0 skipped." and U takes it back (Codex W13, W17). With no text in the window, see section 2B, item 2.
7. **SBEAM and SBEAMEDIT say what is wrong (1.0.102).** Click the same point twice and SBEAM says "SBEAM: the start and end points are the same. Pick two different points, or press Escape." SBEAMEDIT on a locked-layer or Xref section says so and "nothing was unlocked". Nothing is bypassed. Not checked in AutoCAD.
8. **STRUCLINKTEXT questions are clearer (1.0.102).** First "Select the object the label belongs to (a block, line or polyline):" then "Select the label text:". Not checked in AutoCAD.
9. **CE's text-label questions repeat your last text once (1.0.101).** "Enter text or <last>:" shows once. (This is CE's shared text tool behind the label commands; there is no command called CETEXT.) Not checked in AutoCAD.
10. **Beam settings (command 8) fallback prompts show one default (1.0.102).** If the window does not open, the command-line version works the same way. Not checked in AutoCAD.
11. **Beam support-block questions say "support block or line" (1.0.101).** The same-object and "cannot draw a beam between those two" lines are plainer. Not checked in AutoCAD.

### 4.3 Ground floor, slab and raft

1. **CSREOBAR shows its defaults once (1.0.101, 1.0.102).** Codex saw on 1.0.102 (W11c): "Bar size [n10/n12/n16/n20/n24/n28/n32/n36/n40/r10/r6/?] <N12>:" once (the default is the last size used), "Number of bars <8>:" once, then "Spacing (mm) <200>:" once. "Place this reo bar? [Yes/No] <Yes>" comes later and was not reached.
2. **CEHATCHGAP, STIRRUP, CEHATCHAUDIT, level and section marks show defaults once (1.0.101, 1.0.102).** For example CEHATCHGAP "<5>" once, STIRRUP "Cover (mm) <30>:" once, CEHATCHAUDIT "Hatch audit mode [Report/rEpair] <Report>:". Not checked in AutoCAD.
3. **Basement wall with a site-cut batter (1.0.102).** It asks "Excavation depth for the site-cut batter, 0 to skip <0>:" once. Enter means 0. Not checked in AutoCAD.
4. **BATTER and support-block refusals (1.0.102, reworded in 1.0.104).** The 1.0.102 "pick again" lines came after the command had ended. 1.0.104 says "Type the command again" instead (section 2B, items 3 and 4).

### 4.4 Footings (last)

1. **FST: one U per change (1.0.101).** Every window button is one Undo step: Regenerate, Regenerate all, Delete footing, Rename, Delete system, Re-link, Remove unlinked, and the Size library OK. FST, Delete PF2, close, then U brings PF2 back on the drawing and in the FST list.
2. **Codex checked Delete plus one U (W11 on 1.0.102, W15 on 1.0.103).** PF2 came back on the drawing and in the list. The locked-layer delete showed a warning, unlocked nothing and U brought PF2 back. Other FST Undo cases are not completed (section 5).
3. **FST Cancel writes nothing (1.0.101).** Cancel echoes "[FST] Cancelled." (Codex W15). That the drawing stays unmodified (DBMOD 0) is not checked in AutoCAD.
4. **The delete footer keeps its true sentence (1.0.101).** When the redraw was refused because of a locked layer, the footer says so and does not say "or changed". Not checked in AutoCAD.
5. **FST Re-link keeps AutoCAD's protection (1.0.103).** Click "Link selected element" and pick a line on a locked layer. A box says "That line is on locked layer '...', so CE did not re-link the footing (nothing was unlocked). Unlock the layer and try Re-link again." The layer stays locked and there is no empty U. Not checked in AutoCAD.
6. **Re-link also refuses an Xref, an object outside model space, and a pick during a reference edit (1.0.103).** Text is rejected at the pick with "Pick a line, polyline, arc, circle or pile block." Not checked in AutoCAD.
7. **Re-link checks the shape for the footing type (1.0.103).** A strip footing given a circle says "A strip or beam footing follows a line, polyline or arc, so CE did not re-link it. Pick one of those." This is new: before, FST accepted any object. Not checked in AutoCAD.
8. **FST has one code path now (1.0.103).** An old second copy of FST was removed. You will not see it.
9. **FSF, FPFC and FEDIT show each default once (1.0.101, 1.0.102).** The order is unchanged. Examples are "Enter Y size <same as X>:" (Enter makes a square) and "Enter depth <0 to skip>:" (Enter means 0). A second FPFC with PF1 asks "Warning: Label 'PF1' already exists. Use anyway? [Yes/No/Increment] <Increment>:" once, and Enter gives the next FREE number (PF2 only if PF2 is free; Codex got PF5 when PF2 to PF4 existed).

```before
Enter new X size <600> <600>:
```
```after
Enter new X size <600>:
```

10. **FEDIT Enter keeps the footing exactly (1.0.101).** Press Enter at the size and depth questions and LIST shows no change. The summary says "Pad footing", not "PadFooting" (1.0.102). Codex saw both (W11c). Codex also changed PF1 to 700 x 700, then U and REDO worked (W15, W17).
11. **The units question is plainer (1.0.101).** On a drawing with units not set and imperial measurement, it shows "[Yes/No] <No>" once and No ends FEDIT. FST never asks it. Not checked in AutoCAD.
12. **A decimetre, yard or kilometre drawing is refused clearly (1.0.102).** FPFC says "This drawing's units are decimetres. CE footings convert millimetres, centimetres, metres, inches and feet only, so CE has not run this command. Check what the drawing is really drawn in (LIST one footing) before changing anything." Nothing is drawn. Codex saw the exact text (W11).
13. **Footing sizes after a grip drag read in millimetres (1.0.103).** In a centimetre drawing a 70 by 60 pad grip line now reads "PF1 is now 700 x 600 mm.", not "70 x 60". Millimetre drawings are unchanged. The STRETCH line was fixed later (section 2B, item 5). Not checked in AutoCAD.
14. **The support-ring minimum is 50 mm, not 50 drawing units (1.0.103).** In a metre drawing that was 50 m before. Not checked in AutoCAD.
15. **The units warning shows only where CE cannot convert (1.0.103).** That means units not set with imperial measurement, or a unit AutoCAD does not define. Not checked in AutoCAD.
16. **FEDIT outline pick (1.0.103).** Codex saw "[FEDIT] You picked CE's outline: editing PF1, the footing nearest your pick." (W15, W17). If CE cannot tell which footing you meant it says "[FEDIT] CE cannot tell which footing this outline belongs to. Pick the pad or its label. Nothing changed." (not checked in AutoCAD).
17. **Footing grip warning names the unit (1.0.101).** In a metre drawing it says "metres", not "INSUNITS = 6". Not checked in AutoCAD.

### 4.5 Behind the scenes (not a drawing job)

1. **The Structural machine report no longer carries your login (1.0.102).** The report file name and its UserName and MachineName fields are 16-character codes. From 3.0.34 Civil's new report file is coded too (section 2A, item 9).

---

## 5. WHAT IS NOT DONE OR STILL SWITCHED OFF

Nothing here is promised beyond what is installed.

1. **CSFDNPROPOSE ("Propose footings") is hidden and OFF (1.0.103, 1.0.104).** It is not in the ribbon, the palette or help. If you type it, you get exactly "Propose footings is not switched on in this version. Nothing was proposed or drawn." and nothing else. Codex saw this twice (W15, W17), with no drawing change. There is no Settings control for it yet. Do not try to switch it on.
2. **In 1.0.102 CSFDNPROPOSE said "Unknown command".** Codex saw this, as intended. From 1.0.103 it is a known command that does nothing.
3. **The footing-proposal engine is OFF by default.** When it is eventually switched on, proposed footing sizes read "Unknown", never 0.
4. **Steepest-pipe limit.** Tim ruled: no fixed limit, a Settings value, a warning above 1 in 10, never a block. **3.0.34 now follows this** in its values (no limit, warn above 1 in 10), but the values are not on the Settings window yet, and the levels proposal that uses them is still OFF. CDFIXFLATPIPES uses them now (section 2A, item 6). Tim confirmed on 8 Oct ("4. as recommended", INT-068): a flattened pipe held at 1 in 5 is offered with the "steep, check it" line, not "Check by hand". Codex has not seen that line.
5. **Same-day re-issue replaces the earlier set; issue with no sheet ticked.** Tim ruled both. The issue-set changes are not in these releases.
6. **"A level typed in the Pit window is never moved".** Tim ruled this. The rename routes in 3.0.33 already keep to it. The separate Pit-window change for it is not in these releases.
7. **The two Civil changes held out of 3.0.33 are now in 3.0.34.** The steep-pipe change no longer brings back a fixed 1-in-20 limit, and the "Stop overriding" sentence now shows (section 2A).
8. **Roof and floor point-load carry-down, member schedule from plan, title block question for new jobs, downpipe layouts.** Tim ruled on all of them. None is in these releases.
9. **Clearances (footing and service distances in metres).** Tim has not typed the numbers. They stay Unknown and will live on the Settings page.
10. **Charged rising pipe flips on a grip drag.** Tim ruled "keep it, with a one-line message that it flipped". The sources do not confirm that message is in these builds.

---

## 5A. DECIDED, NOT YET BUILT (Tim's rulings INT-066, INT-068, INT-069, 8 Oct)

A ruling is not a fix. None of these is in the installed Civil 3.0.35, Manager 1.1.35 or Structural 1.0.104 unless a line says so, and none has been seen in AutoCAD. Tim has accepted nothing.

1. **UPVC pipe speed limit.** Tim: "1. as recommended" (INT-068). The authority is the CPAA Hydraulics Design Manual. The figures read from it become PROPOSED Settings values for Tim to tick "Confirmed". Until then 3 m/s stays the one unconfirmed value and Civil Design stays at 6. (The manual has been read; it gives no UPVC figure. See CPAA_VELOCITY_READ_2026-10-08.md.)
2. **Two new warnings, never blocks, figures on Settings.** Pit outlet speed (AS/NZS 3500.3 clause 5.4.11.2(d): 1.5 m/s recommended, 2.0 m/s shall not exceed). Detention pipe flatter than 1 in 200 for pipes 225 mm and larger, and "orifice not required" at 12 L/s or less.
3. **Pit numbers.** Colleagues renumber pits only in Edit Pit during the pilot. A free number typed in the Pit Schedule window waits as a pending override until Review, Update or Stop overriding (that is how it works now).
4. **Privacy.** Delete the old real-named Civil report files (Civil and Manager at start-up), scramble the names inside the Manager report, keep PC names out of support-bundle file names. CESUPPORT never uploads by itself, and drawing paths in it become job numbers.
5. **Locked layers.** CDIMPORTXCIVIL skips a locked layer and says so (BUG-417; draft PR 765). A brace over 2700 mm keeps its drawn length and warns (it is still cut to 2700 today). The strip-footing layer tidy-up stays and runs quietly if done properly (draft PR 764). The 350 mm wall pair gap is kept.
6. **Manager updates.** Roll Back Release: PCs go back at their next AutoCAD start, with an "are you sure". Approving a Civil update also approves the matching Manager update. (BUG-425 records that today the button does nothing and Civil can update without Manager.)
7. **Sheet sync** skips sheets a colleague has open and says which.
8. **Footings.** An unknown footing width asks for it, with the Settings value pre-filled (today 300 mm; screw pile 150 mm).
9. **Flat pipe label (BUG-427).** The label reads FLAT with no grade figure when both ends are typed the same (Option A; Tim to confirm in one line). Today it still reads 1 IN 100. Built only as a draft.
10. **F2 is left as it is for now.** Tim: "leave as is for now, commonly used by me to save". F2 runs CLEAN in a CE drawing; nothing is changing yet.
11. **Structural framing cards A to E approved, roof first:** roof area setout, floor joist span arrow, framing legend, lintel/support proposals, level above and below (O)/(U). Nothing built.
12. **Still open with Tim:** the seven design cards (he is answering them himself), the pilot colleague's name and the results channel. Tim runs the Day 1 checklist himself on one real job copy before any colleague pilot.

---

## 6. KNOWN LIMITS AND THINGS TO CHECK FIRST

1. **F2 runs CLEAN.** In the setup Codex tested, pressing F2 runs the CE Structural command CLEAN (purge, restyle, regen on the open drawing) instead of opening the text window. Use TEXTSCR and GRAPHSCR to flip the text window. Do not press F2 expecting a save. Logged as BUG-411, still open. Tim has ruled "leave as is for now, commonly used by me to save": nothing is being changed, and the desk will check what F2 does for him first.
2. **Edit Pit pit-number clash: fixed in 3.0.34.** Before 3.0.34, Edit Pit could remove another pit's record when you typed its number. 3.0.34 refuses it (section 2A, item 1). Anyone still on 3.0.33 or older: do not renumber in Edit Pit.
3. **The Pit Schedule window did not check pit numbers on 3.0.33 (BUG-420, BUG-415).** In AutoCAD it accepted "2" beside P2, "p1" over P1 and "C 2" beside C2 with no line. Tim's pilot ground rule: renumber pits ONLY in Edit Pit. INT-069 says a window fix is in 3.0.35 (PR 766), but nobody has seen it in AutoCAD and BUG-426 (open, MEDIUM) says a typed 9 then p1 still shows 9, so the rule stands.
4. **A plan label typed as a bare number by double-click is refused with a generic sentence.** "Pit ID must be one compact identifier such as P1 or SPS1." The label keeps showing what you typed. A later MOVE of that label then renames the pit, to "12" quietly if 12 is free. Nothing is lost, but it is late and quiet.
5. **A stale table cell can rename a pit on MOVE.** A placed table cell that still shows an old number (because its layer was locked at the last refresh) is read as typed when you MOVE it after unlocking. Read in the code, not checked in AutoCAD.
6. **Double-click typing in a placed table cell may not reach CE.** CE pauses while TEXTEDIT, MTEDIT or DDEDIT run, and no other route was found. If you type C2 over P5 and nothing changes after the next refresh, this is why. Same as 3.0.30. Not checked in AutoCAD.
7. **Look-alike numbers.** On 3.0.31 and 3.0.32 a typed "8" beside P8 was accepted as two pits. From 3.0.33 New Pit refuses it, and from 3.0.34 Edit Pit refuses it. The Pit Schedule window still accepts it (item 3). "C 2" beside C2 is accepted, by Tim's ruling, with a warning (except in the window).
8. **Pit placement message.** After placing a pit on 3.0.32, Codex saw once: "CE could not save its pipe and pit record with this command. It will be saved with your next command." The cause is not yet found (BUG-412). Codex did not see it on 3.0.33 (W14). Say so if you see it.
9. **CDRECOVERINVERTS may skip many pipes on old drawings.** It will not guess. The final line counts the skips, so read it.
10. **Undo after Stop overriding.** The window has no Undo button. After you close it, one U takes back the whole Pit Schedule visit. Check what U brings back, including the plan label text.
11. **FST Undo cases not all completed.** Delete plus one U passed twice. Other cases, including U after an FST Zoom (it should take back only the zoom), are not checked. If, after an FST Delete, U does nothing, or takes back two commands, or brings back a footing on the drawing but not in FST, stop using FST Delete on real jobs and tell Tim.
12. **Footing resize lines round differently in an inch drawing (1.0.104).** After STRETCH the first line can read "609.6 x 609.6 mm" and the next "610 x 610 mm". Both are millimetres.
13. **A support block on a locked layer gives raw words.** STS1 prints "[CE_STRUC_SUITE] TS1 switch failed: eOnLockedLayer". Nothing is unlocked or changed.
14. **Old real-named report files stay.** Civil's old machine report named with your login and computer name is kept on the PC; the Manager report still has the real names inside it; CESUPPORT bundles are named with the computer name. Tim has now ruled these should go (BUG-423; section 5A, item 4). Not built yet.
15. **Not measured on a real job:** the cost of the extra record read when you start a text edit, and PITSCHEDULE's extra scans on a large drawing.
16. **AutoCAD 2022 to 2024.** These builds were built and unit-tested. The reports list failures that come from the older reference files in the test host, not from the product. Nothing here was opened in those versions.
17. **Old test failure.** One long-known Civil calculation test (Glen Eira detention back-test, 34.6 % against 30 %) is still red. It is not new and not touched by this release.

---

## 7. IF SOMETHING LOOKS WRONG

1. **Stop and use a copy.** Do not save over your original drawing while you check. Press U once and see what comes back.
2. **Tell Tim.** The sources name no other support route for colleagues, so I do not invent one.
3. **Write down these seven things:**
   1. **Version:** read the CE lines on the status bar, or type CEHEALTH and copy the Civil and Structural lines.
   2. **Command:** the exact command you typed, and what you clicked.
   3. **Drawing:** the file name, and whether it is an older metre drawing.
   4. **Expected:** what you thought would happen.
   5. **Saw:** what happened, and the exact words on the command line. Use TEXTSCR to read them. Do not press F2.
   6. **U result:** did one U put it back, do nothing, or take back two commands?
   7. **Time:** when it happened (Melbourne time).
4. **Do not delete CE's log files.** CE keeps its own logs in the `logs` folders of CE_CVL_SUITE, CE_STRUC_SUITE and TIM_CE_CADTOOLS under AppData. They help find the cause.
5. **Pit numbers: renumber only in Edit Pit, not in the Pit Schedule window.** That is Tim's pilot ground rule (section 6, item 3). Tell Tim first.
6. **FST: if U goes wrong after Delete,** stop using FST Delete on real jobs and report it.
7. **If CE does not load,** tell Tim, and say what AutoCAD showed at start. Do not reinstall by hand.

---

## 8. Where this came from

Reports read: the Opus finalizer reports for each train (C-17 to C-20, S-18 to S-21), the matching assembly reports, the payload reports for the installs, the install logs (`C:\ce_rc_scratch\install_c30.log`, `install_c31s.log`, `install_c32.log`, `install_c33s.log`), the Codex reports W10 to W17 and the release queue (items 160 to 211), plus Tim's rulings in the 28 Sep to 8 Oct decisions file (INT-059 to INT-066).

1. **Civil 3.0.31 (installed 4 Oct):** PR #637, #660, #645, #654, #659, #646, #643, #641, #656, #634, #663, #655, #661.
2. **Civil 3.0.32 (installed 5 Oct):** PR #666, #671, #669, #681, #685, #683, #658, #677, #684.
3. **Civil 3.0.33 (installed 7 Oct 21:16):** PR #667, #695, #670, #687, #723, #734, #705, #715, #731.
4. **Civil 3.0.34 (installed 8 Oct 00:50):** PR #758, #740, #722, #703, #697, #745, #733, #750, #752, #753. #703, #733, #750 and #752 have nothing that runs yet; #753 is a test only.
5. **Manager 1.1.31 to 1.1.34:** the Manager changes are inside the Civil trains above (#663, #669, #681, #684, #677, #745).
6. **Structural 1.0.101 (installed 4 Oct):** PR #664, #647, #651, #652, #653.
7. **Structural 1.0.102 (installed 5 Oct):** PR #672, #662, #674, #675, #688, #630, #686. PR #678 was dropped.
8. **Structural 1.0.103 (installed 7 Oct 21:21):** PR #738, #673, #665, #744.
9. **Structural 1.0.104 (installed 8 Oct 00:56):** PR #759, #760, #761, #746, #749, #748, #757 (and #662's log entry; its code was already in 1.0.102).
10. **Reports used:** TRAIN_C17 to C20 and S18 to S21 finalizer and assembly reports, PAYLOAD reports, and CODEX_VERIFYW10 to W17 in `C:\Lisp Files\_TEST_COPIES_20260923`.
