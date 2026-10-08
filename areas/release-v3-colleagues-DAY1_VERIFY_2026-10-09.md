# Day 1 page check, 9 Oct 2026

**Job:** main_day1_verify (desk plan/03, run 3 of the Max-account helpers, Opus). Read only: no AutoCAD, no builds, no code changed, the Day 1 page itself NOT edited (the controller owns it).
**Page checked:** `04_REFERENCE/release/DAY1_FOR_TIM_2026-10-09.md` as it stood at 09:41 Fri 9 Oct (PC clock).
**What is installed (read from the installed files at 09:45 PC clock, not remembered):** Civil 3.0.41 and Manager 1.1.41 (both built from 660487d1, branch rel-20261009g); Structural 1.0.110 (9babe787, branch rel-20261009f). All three program versions (2022 to 2027) carry the same numbers.
**Checked against:** the code at those two release points, Tim's own CE settings files on this PC (read only), and the Codex reports W12 to W45 in `C:\Lisp Files\_TEST_COPIES_20260923` plus the runner briefs W46 to W53.
**How to read this:** "Codex saw" = a Codex report says it watched it in AutoCAD. "The code shows" = I read it in the code at the installed version; nobody has watched it. "I think" = my judgement, not proven.

---

## Answer first

1. **The page is mostly right, but it needs 30 corrections before Tim runs it (26 wrong, stale or missing items, plus 4 that are right but incomplete).** Five matter most, because Tim would be misled or stuck:
   - **Step 19 (FSF) has the questions in the wrong order.** On 1.0.110 FSF still asks the mark, width and depth FIRST; "Select centerline" is the fourth question, not the first. Codex saw this on 1.0.110 (W44, 06:33). Gap 10 repeats the error. Also, the code shows that the line Tim picks is moved onto the layer STRIP FOOTINGS.
   - **Step 24 cannot be followed.** After `CLOSE` there is no drawing, so the command line goes away and `QUIT` cannot be typed. Codex closed AutoCAD with File > Exit every time (W32 to W36, W43 to W45).
   - **Step 14 (R1) on Tim's PC asks "Enter the tag text <RT1>:", not "<R1>".** Tim's own settings file remembers RT1 as his last rafter tag. And the BT1 sentence "SEEN on 1.0.110 (W41)" is wrong: W41 ran on Structural 1.0.109, and Codex marked it BLOCKED because the truss was cut off the screen.
   - **Step 5 quotes the duplicate-number sentence in words the program no longer prints**, and gives a 3.0.35 test as proof. Codex saw different, older words on 3.0.35 (W20). The words in 3.0.41 (code, nobody has watched them) are below.
   - **Gap 1 and step 16 say TS1 was seen on 1.0.110 in W43.** W43 did not test TS1. TS1 was seen on 1.0.109 (W39).
2. **Beam linking:** the code shows the default is still OFF in Structural 1.0.110, and still OFF in the 40 newest code branches I read (Tim's "beam linking on", INT-078, is not built yet). Tim's own settings file stores OFF ("LinkingEnabled": false). So on Day 1, every column Tim places will print "[CE] Beam linking is switched off in Settings, so the support is not linked." (Codex saw this line on Tim's PC, W43). The page does not mention it.
3. **Nothing has been watched on Civil 3.0.41 or Manager 1.1.41 yet.** Every Civil "SEEN" on the page is on 3.0.32 to 3.0.40. The code shows Manager 1.1.41 changed nothing except its number. Civil 3.0.41 changed only four things: the Edit Pipe save (it now removes a stale red CHECK text), the What's New window heading, the Pit Schedule "waiting" sentence, and the consultant (X-Civil) import. None of the steps that Codex watched on 3.0.38 to 3.0.40 touch these, apart from step 10 (the page already flags it) and the What's New window (missing, see correction 2).
4. **Two new windows or lines Tim WILL meet that the page does not mention:** the What's New window for 3.0.41 at the first start (this PC last showed 3.0.40), and the pipe-upgrade line when an older job opens.

---

## Corrections, with the exact replacement text

### Top of the page and step 1

1. **Header line (line 3), stale versions.**
   - **Why:** installed is now Civil 3.0.41 / Manager 1.1.41 / Structural 1.0.110.
   - **Replace with:** "Written 9 Oct for Civil 3.0.40 / Manager 1.1.40 / Structural 1.0.110. Installed now (read from the installed files 9 Oct 09:45): Civil 3.0.41 / Manager 1.1.41 / Structural 1.0.110. Codex has not run anything on 3.0.41 or 1.1.41 yet, so every Civil SEEN below was on an older Civil."
2. **Step 1, missing "what right looks like".**
   - **The code shows:** the What's New window opens once whenever the installed Civil is newer than the last one shown. This PC's record (`last_version.txt`) says 3.0.40, and Tim's settings do not have "Quiet start after an update" switched on. Opening a job whose pipes were drawn by an older CE upgrades them and writes one backup drawing ending `_PRE_C7_` beside the drawing (Codex saw "[CE] 49 pipe(s) upgraded to CE pipe objects ..." on a test copy, W45).
   - **Add after "Should see":** "A What's New window titled 'CE Civil — Version 3.0.41' opens once. Read it or close it. If your job has pipes drawn by an older CE you will also see a line like '[CE] 12 pipe(s) upgraded to CE pipe objects ... Backup: ...', and a backup drawing ending _PRE_C7_ appears beside your copy. Both are normal."
   - **I think:** because that upgrade changes the drawing, AutoCAD will ask "Save changes?" at step 24 even if Tim changes nothing. Worth one sentence (see correction 7).

### Civil steps 2 to 13

3. **Step 2, versions.**
   - **Replace the first sentence of "Should see" with:** "the status bar shows 'CE MANAGER v1.1.41 [Modern]', 'CE CVL SUITE v3.0.41' and 'CE STRUC SUITE v1.0.110', each followed by a date. CEHEALTH lists '[OK] CE Civil Suite v3.0.41' and '[OK] CE Structural Suite v1.0.110' and ends '[CEHEALTH] All checks passed.' (The same lines were SEEN on 3.0.40 / 1.1.40 / 1.0.110, 9 Oct, W45. 3.0.41 is NOT SEEN.)"
   - **Also add:** "One start-up line reads 'CE CVL loaded: CE_CVL_SUITE v3.0.41.0 [Modern]'." (Codex saw the 3.0.40 form of it, W45.)
4. **Step 3, the click path names no button.**
   - **The code shows** the questions and the button name; Codex saw them on 3.0.33 (W14) and earlier.
   - **Replace the instruction with:** "Type `PIT`. At 'Specify pit insertion point:' click an empty spot. The New Pit window opens: type a pit number and a cover level, then press **Continue placement**. At 'Specify pit label insertion point:' click where the label goes. At 'Click to place cover text (Enter = <BR>):' click where the cover text goes. Press Esc."
5. **Step 4, wrong proof.**
   - **Codex saw:** in W14 (3.0.33), U echoed PIT and the pit went, but REDO said "Nothing to redo", because Codex had switched to another drawing in between. The W14 test that was meant to prove U and REDO was BLOCKED (U echoed GRAPHSCR instead). The only U then REDO on PIT is W12 (3.0.32, 7 Oct): U echoed PIT, REDO echoed PIT and "Everything has been redone", but the pit was too small on screen to confirm that the label and cover text came back too.
   - **Replace "Should see" with:** "U echoes PIT and the pit goes (SEEN on 3.0.33, 7 Oct, W14). REDO says 'Everything has been redone' (SEEN on 3.0.32, 7 Oct, W12). That the label and the cover text both come back with the pit has NOT been seen: look for all three. Do not switch to another open drawing between U and REDO. Codex did that and got 'Nothing to redo'."
6. **Step 5, the duplicate-number sentence.**
   - **The code shows** that since Civil 3.0.38 (still in 3.0.41) Edit Pit prints: "[CE] Pit number P8 is already used by pit P8, so this pit keeps P5. Type a number no other pit uses. Nothing was changed. Your entries have been kept — correct them and press Save again."
   - **Codex saw** a different, older sentence on 3.0.35 (W20): "... is the same pit number as P2 (another pit) ...". The sentence on the page ("already used by another pit (P8)") is not in the code at any version I read.
   - **Replace that quote and its SEEN mark with:** "For a used number: '[CE] Pit number P8 is already used by pit P8, so this pit keeps P5. Type a number no other pit uses. Nothing was changed. Your entries have been kept — correct them and press Save again.' (your numbers will differ). This wording is built and NOT SEEN; Codex saw older words on 3.0.35, 8 Oct (W20). Press Cancel."
   - **Also add** the first question: "PITEDIT first asks 'Select pit block to edit:'." (Codex saw this, W20.)
7. **Step 6, a save-question test that can mislead.**
   - **Why:** "AutoCAD must not ask to save later just because you looked" is not a fair test if the drawing was already changed when it opened (correction 2).
   - **Replace with:** "Looking must not change any number in the schedule. (Do not use the save question at the end to judge this: if CE upgraded older pipes when the job opened, AutoCAD asks to save anyway.)"
8. **Step 7, the prompt list is short.**
   - **Codex saw the full sequence** on 3.0.38 (W35, W36) and 3.0.40 (W45).
   - **Replace "Should see" with:** "'Select the first two points to start the polyline, or E to use a line you have drawn.', 'Specify first point or [Existing line] [Existing]:', 'Specify second point:', 'Checking 861 intersections...' (your count will differ), 'Select point 3 (or Enter for straight pipe):'. After Start Pipe: 'Inserted flow arrow. Flow: P10 -> P9', then '[CE] Pipe placed. Pick the next pipe's first point, or press Esc to stop.' These are normal too: '[CE] Pipe end moved to the inside wall of P10 (was 225 mm inside the pit).' and '[CE Civil] a pipe's start invert text: no clear spot among its usual positions, left where it is (on "pit P10")'."
9. **Step 9, the warning window is not mentioned.**
   - **Codex saw** a small Design Warnings window that opens with "This pipe has design warnings. Review before proceeding." (W32, W45).
   - **Add:** "A small Design Warnings window opens with those two sentences. Press OK."
10. **Step 10, F2 can run CLEAN in the drawing.**
    - **Why:** the page itself says F2 runs CLEAN in a CE drawing. If the Pit Schedule window is not in front when Tim presses F2, F2 goes to the drawing. Codex always clicked the window's title bar first (W33, W34).
    - **Replace "press F2 (inside this window F2 edits the cell)" with:** "click the Pit Schedule window's title bar first so it is in front, then click the cell and press F2 (inside this window F2 edits the cell; outside it, F2 runs CLEAN in your drawing)".
    - **Optional line to add (built, NOT SEEN):** "From 3.0.41, if you then open the pipe in Edit Pipe (CDEDIT) and save matching levels, the red CHECK text should go away (BUG-446). On 3.0.38 it stayed (Codex W37)."
11. **Step 12, two lines missing.**
    - **The code shows** that CDCHECK always writes its list to a file and says where. Codex saw the FALL arrow lines (W35).
    - **Add:** "It also says '[CE] Full list saved: ...' (a file in your CE logs folder, not in the job folder), and may list '[CE] FALL arrow direction: ...' lines, each ending 'Check the fall direction or move the arrow.'"
12. **Step 13, the question is not quoted.**
    - **Codex saw** this on 3.0.33 (W14) and 3.0.38 (W35).
    - **Add before the summary line:** "The question reads 'CE rules: show all findings, problems only, the values in use, or explain each problem [All/Problems/Values/Explain/pReview/Source] <Problems>:' (Enter also gives Problems). A first line '[CE] Previous rule results (...) were STALE ... Re-checking now.' is normal."

### Structural steps 14 to 21

13. **Step 14, BT1: the version is wrong and the click path contradicts itself.**
    - **Codex saw:** the BT1 prompts, U, REDO and Esc on Structural **1.0.109** (W41, 05:27), and marked it BLOCKED because the drawn truss was cut off at the top of the screen. The code shows BT1 is unchanged between 1.0.109 and 1.0.110.
    - **Why it contradicts itself:** the step says "Type BT1. Then press Esc.", but its "Should see" lists all of BT1's questions, which Tim will not see if he presses Esc straight away.
    - **Replace the BT1 part with:** "Type `BT1`, click two points along a wall (or press Enter at the second point for the default length), press Enter at the truss number, and answer the flip question if it appears. Then `U`. Should see: 'Specify first point of bracing truss:', 'Specify second point of bracing (drag preview, ENTER for 0°/2700) [Zero]:', 'Bracing truss number [1-9] <1>:', a preview line 'Preview length: ... rotation: ...' (your length), and maybe 'CE could not tell from the Xref walls which side the brace should go. Flip it by hand if it is on the wrong side.' and 'Toggle flip? [Yes/No]:'. SEEN on 1.0.109, 9 Oct (W41, the truss itself was cut off the screen); BT1 is unchanged in 1.0.110. Esc at the first question prints 'Operation cancelled.'"
14. **Step 14, R1: the evidence, the tag on Tim's PC, and how it ends.**
    - **Codex saw:** "Pick LEFT beam or wall" and "Pick RIGHT beam or wall" on 1.0.110 (W44, 06:27). "Pick TOP/near side" was also seen on 1.0.110, in W44, not W41 (W41 was 1.0.109 and stopped at RIGHT). W44 was BLOCKED because the empty test area had no third object to pick.
    - **The code shows:** the tag question offers the last tag used. Tim's settings file holds "RT1", so Tim will see "Enter the tag text <RT1>:". At "Select object:", Enter or Esc asks "Select object:" once more, and a second Enter or Esc ends R1 with no message and nothing drawn.
    - **Replace the R1 sentences with:** "Run `R1` inside a real bay of your job, between two beams or walls, because R1 needs real objects to pick (Codex could not finish it in an empty test area). It asks four picks: 'Pick LEFT beam or wall', 'Pick RIGHT beam or wall', 'Pick TOP/near side', 'Pick BOTTOM/far side'. Each one first asks '[Object/Point] <Object>:': press Enter, then click the beam or wall at 'Select object:'. Then 'Enter the tag text <RT1>:' (your last rafter tag; Enter keeps it, or type R1). So one rafter tag takes eight actions. If you press Enter or Esc twice at 'Select object:', R1 ends silently and draws nothing. That is not a fault. The first three questions were SEEN on 1.0.110 (W44); the fourth pick, the tag question and the drawn tag are NOT SEEN."
15. **Step 15, beam command 1: two prompts missing, and newer evidence exists.**
    - **Codex saw** the full prompt list on 1.0.110 while setting up for R1 (W44, 9 Oct). The U then REDO proof is only on 1.0.105 (W19).
    - **Replace "Should see" with:** "'Select the first support (a support block or a line), or press Enter to pick points:', 'Specify the START point:', 'Specify the END point or [Object]:', 'Enter text <bd1>:', 'Beam preview [Accept/Cancel] <Accept>:', then 'Beam placed. One UNDO removes the complete beam.' (prompts SEEN on 1.0.110, 9 Oct, W44). U echoes 1; REDO says 'Everything has been redone' (SEEN on 1.0.105, 8 Oct, W19)."
16. **Step 16 and gap 1, C1 column: TS1, the question after a click, the linking line, the rotate lines.**
    - **Codex saw on 1.0.110 (W43):** C1 with Enter, and C1 with a click. TS1 was NOT in W43; TS1 was seen on 1.0.109 (W39-03). With a click, CE printed "Text placed at the top right (CR1)." and then asked "Enter text for 'C' or <1>:". Every column printed "[CE] Beam linking is switched off in Settings, so the support is not linked." The rotation step showed AutoCAD's own lines "_.ROTATE", "Select objects: 1 found", "Specify rotation angle or [Copy/Reference] <0>:". Codex's click on the command line hit the word Reference by mistake.
    - **The code shows:** the number question depends on whether CE remembers a number from earlier in this AutoCAD session. The first C1 asks "Enter a number to append to 'C' (or press Enter to exit):", and a bare Enter there leaves the column without a label. Later C1s ask "Enter text for 'C' or <1>:", where Enter reuses the last number (Codex saw this on 1.0.109, W40-03). The remembered number is forgotten when AutoCAD closes.
    - **Replace the "SEEN on 1.0.110 ... and TS1" sentence (step 16) and the matching words in gap 1 with:** "SEEN on 1.0.110, 9 Oct, 06:05 to 06:09 (W43): C1 with a click and C1 with Enter. TS1 was SEEN on 1.0.109 (W39)."
    - **Add to step 16 "Should see":** "After the insertion point, AutoCAD's own rotate lines appear ('Select objects: 1 found', 'Specify rotation angle or [Copy/Reference] <0>:'): press Enter, and do not click the words on the command line. If you click a label spot, CE says 'Text placed at the top right (CR1).' and then asks 'Enter text for 'C' or <1>:': press Enter or type the number. The first C1 since AutoCAD started asks 'Enter a number to append to 'C' (or press Enter to exit):' instead, and a bare Enter there leaves the column without a label. Every column ends with '[CE] Beam linking is switched off in Settings, so the support is not linked.' That is your current setting, not a fault."
    - **Also change** "Esc removes the half-placed column" to "Esc removes the half-placed column (SEEN on 1.0.109, W39)".
17. **Gap 13 (b), C1 Esc: the questions quoted are not the ones Codex saw.**
    - **Codex saw on 1.0.109 (W39-02):** "Enter text for 'C' or <1>:" (Enter), then Esc at "Specify insertion point:", which printed "[CE_STRUC_SUITE] Support text command failed: Command cancelled." and left the column. The words "Enter a number to append to 'C'" are the 1.0.110 first-column question, and Esc there has not been seen.
    - **Replace case (b) with:** "(b) after you pressed Enter there, Esc at 'Specify insertion point:' keeps the column and prints 'Support text command failed: Command cancelled.' (SEEN on 1.0.109, W39). Esc at the number question on 1.0.110: NOT SEEN."
18. **Step 17, BTX.**
    - **The code shows** BTX changed after 1.0.104, but only for the case where nothing gets converted. The normal path in step 17 is the same.
    - **Add:** "BTX first asks 'Select beam TEXT/MTEXT to convert:'." (Codex saw this, W17.)
19. **Step 18, CSREOBAR: add the exact lines.**
    - **Codex saw** these on 1.0.110 (W44).
    - **Replace "Bar size" with** "'Bar size [n10/n12/n16/n20/n24/n28/n32/n36/n40/r10/r6/?] <N12>:'", and **add at the end:** "After Yes: 'BM1: 8-N12-200 CTS x 4000 LG, BOTTOM.' (your mark and length will differ)."
20. **Step 19 and gap 10, FSF: wrong order of questions, and the picked line changes layer.**
    - **Codex saw on 1.0.110 (W44, 06:33):** "Enter text <SF1>:", "Enter width for SF 1 <300>:", "Enter depth <0 to skip>:", THEN "Select centerline (Line/Polyline/Arc) or press Enter for 2-point line:". Enter at that fourth question ended FSF with no "Specify start point:". The same happened on 1.0.109 (W41).
    - **The code shows:** the line or polyline you pick at that question is moved onto the layer STRIP FOOTINGS (it becomes the strip's centreline). FSF is unchanged between 1.0.109 and 1.0.110.
    - **Replace step 19 "Should see" with:** "On 1.0.110 FSF asks 'Enter text <SF1>:', then 'Enter width for SF 1 <300>:' (only if that mark has no width yet), then 'Enter depth <0 to skip>:', then 'Select centerline (Line/Polyline/Arc) or press Enter for 2-point line:' (all SEEN on 1.0.110, 9 Oct, W44). Draw a new LINE first and pick that, because CE moves the line you pick onto the layer STRIP FOOTINGS; do not pick one of your wall lines. Pressing Enter at the centreline question ends FSF with nothing drawn (gap 10). Finishing a strip, its label, and one U removing both: NOT SEEN."
    - **Replace gap 10 with:** "**FSF strip footing: Enter at the centreline question ends the command silently (BUG-454).** FSF asks the mark, width and depth first. At the fourth question, 'Select centerline (Line/Polyline/Arc) or press Enter for 2-point line:', pressing Enter ended the command with no 'Specify start point:' (seen on 1.0.109 and 1.0.110). Draw a new line and pick it instead."
21. **Step 20 and gap 11, FPFC: first question missing, and the missing label was seen twice.**
    - **Codex saw:** "Enter text <PF1>:" comes first (W41, W44). The label was not visible in W41 (1.0.109, zoomed out) or in W44 (1.0.110, zoomed in to 1.5 m). Codex marked W44 FAIL.
    - **Replace the start of step 20 "Should see" with:** "'Enter text <PF1>:' (press Enter). With an existing PF1 it then asks 'Warning: Label 'PF1' already exists. Use anyway? [Yes/No/Increment] <Increment>:' ...". **In gap 11, replace "NOT SEEN either way" with:** "Codex looked twice (1.0.109 and 1.0.110, once zoomed in close) and saw no label both times. Look at the pad yourself."
22. **Step 21, FEDIT: the opening lines were seen on 1.0.110 too.**
    - **Codex saw on 1.0.110 (W44):** "Select a footing to edit:", "[FEDIT] You picked CE's outline: editing PF5, the footing nearest your pick.", "[FEDIT] Current: PF5, Pad footing, 600x600", and at the end "[FEDIT] PF5 updated.".
    - **Replace "Earlier wording ... was seen on 1.0.105, 8 Oct (W19)" with:** "It starts 'Select a footing to edit:', '[FEDIT] You picked CE's outline: editing PF5, the footing nearest your pick.' and '[FEDIT] Current: PF5, Pad footing, 600x600', and ends '[FEDIT] PF5 updated.' (SEEN on 1.0.110, W44)."

### Finish, steps 22 to 24

23. **Step 22 and gap 6, CESUPPORT: the privacy claim says more than Codex checked.**
    - **Codex saw (W45):** no real login or computer name in the zip's file names or in its index list. Codex was told NOT to open the other files, and did not. The file count depends on the logs on the day.
    - **In both places, replace "no real login or computer name is inside" with:** "no real login or computer name appears in the file names or the index list inside it (Codex did not open the log files themselves)". **And replace "It holds 10 files plus the index" with** "It held 10 files plus the index on 9 Oct (your count will differ)". The code shows CESUPPORT is unchanged in Manager 1.1.41.
24. **Step 24, QUIT cannot be typed after CLOSE.**
    - **Codex saw:** with no drawing open the command line disappears; Codex used File > Exit every time (W32 to W36, W43 to W45).
    - **Replace the instruction with:** "Type `CLOSE`, answer No to 'Save changes to ...?' (unless you want to keep the copy: then `QSAVE` first). With no drawing open the command line goes away, so close AutoCAD with File > Exit (or the X at the top right). Then open the original job folder."
    - **Update the SEEN line to:** "SEEN (CLOSE with No, then File > Exit, 8 Oct W32 to W36 and 9 Oct W45 on 3.0.40)."

### The gaps list and the start-up clean-up

25. **Gap 8, already done on this PC.**
    - **Codex saw** the one-time growth happen at 06:00 on 9 Oct, at the first start of 1.0.110 (W43). Tim's Structural settings file is 28,872 bytes now (read 09:45).
    - **Replace gap 8 with:** "**Structural 1.0.110 grew your CS_Settings.json once, at 06:00 on 9 Oct (Codex W43): 13 new default rows, nothing you set was changed. It will not happen again on your PC for 1.0.110.** A colleague's first start of 1.0.110 does it once on their PC."
26. **"Clearing the three start-up lines" step 2, Tim will find five acad.cuix files.**
    - **Codex saw (W45 file list):** five files named acad.CUIX under `%APPDATA%\Autodesk\AutoCAD 2027`. The one AutoCAD uses is in `...\R26.0\enu\Support\`; four more sit in `AutoIsolate0` to `AutoIsolate3` folders.
    - **Replace the "Find it with ..." sentence with:** "It is in `%APPDATA%\Autodesk\AutoCAD 2027\R26.0\enu\Support\acad.CUIX`. (A search finds four more copies inside folders called AutoIsolate: leave those alone.)"
    - **I think, not proven:** unloading `CE_SUITE_MANAGER_MENU` in the CUI window will not stay unloaded. The code shows CE Manager loads that menu file again at every AutoCAD start (and switches the menu bar on). So step 6's "the lines should be gone" may hold only for the Civil line. The pending Codex run W46 is written to try this clean-up; until it reports, say "should" not "will".

### Things that are right but now incomplete

27. **Gap 14, administrator.** Tim answered "yes admin" (INT-076, decisions file) to making himself the CE administrator once, before any colleague installs. The page still says "Until Tim sets himself up". **Add:** "You said yes (9 Oct): you set yourself up once, on your PC: CE Manager > Admin Dashboard > Yes. Codex run W53 is written to do this and has not run yet." I did not check whether it is already done.
28. **Gap 9, File > New template.** Codex run W46 (written, not run) is set to change your File > New default template to "acadiso" (Tim's words "just the regular acad iso"). If it runs before Day 1, gap 9 is out of date.
29. **Gap 2, the three start-up lines.** Seen on 3.0.40 (W45). The code shows 3.0.41 and 1.1.41 changed nothing about menus, so expect them on 3.0.41 too. **Add:** "Expected the same on 3.0.41 (no menu change)."
30. **Gaps 15 to 18 (Manager updates, status line, "CE is current", fault report button).** These come from the Manager bug hunt (code reading only); Codex has not seen them. The code shows Manager 1.1.41 changed nothing but its number, so they still apply. I did not re-trace each one.

---

## Settings on Tim's PC that change what he sees (read 09:45, read only)

1. **Beam linking: OFF** (Structural settings, "LinkingEnabled": false). The code default in 1.0.110 is also OFF; INT-078's "default ON" is not built in any branch I read. Every column prints the "switched off in Settings" line (correction 16). Codex run W47 (written, not run) ticks the box and then puts it back to its original value, so after W47 it stays OFF unless Tim ticks it himself.
2. **Last rafter tag: RT1.** R1 offers <RT1>, not <R1> (correction 14). FJ1 offers <DJ1>; P1 offers <P1>.
3. **Support text side found automatically: ON.** C1 asks "Pick desired support text location ..." as the page says.
4. **Quiet start after an update: not set (so OFF).** The What's New window opens once for 3.0.41 (correction 2).
5. **Last What's New shown: 3.0.40** (`last_version.txt`, written 06:58, 9 Oct).

---

## Steps a non-coder cannot follow as written (all covered above)

1. **Step 24:** typing QUIT after CLOSE (correction 24).
2. **Step 14:** "press Esc" then a list of prompts that only appear if he does not press Esc (correction 13).
3. **Step 14, R1:** cannot be finished in an empty area; it needs real beams or walls (correction 14).
4. **Step 10:** F2 with the wrong window in front runs CLEAN (correction 10).
5. **Clean-up step 2:** "search for acad.cuix" finds five files (correction 26).
6. **Step 19:** "pick a line or polyline" without warning that the picked line moves layer (correction 20).

---

## What I did NOT check

1. **Nothing was run.** No AutoCAD, no build, no test. Everything above is the code at the installed version, Tim's settings files, or what a Codex report says.
2. **Not traced in the code:** the Manager gaps 3 and 15 to 18; where the "Menu item failed to load" line itself comes from; whether opening the Pit Schedule alone marks the drawing changed; whether Civil 3.0.41 adds rows to Tim's Civil settings file at its first start (it added a new group of X-Civil import distances).
3. **Not checked:** whether Tim is already set up as administrator; whether the SharePoint results folder in step 23 accepts files (the page already says so).
4. **Not re-read in full:** Codex reports W1 to W11 (older than every version on the page).
5. **Times:** the decisions file stamps INT-076 to INT-078 at "about 10:00 to 10:40 (real PC clock)", but the PC clock read 09:41 to 09:52 while I worked. I used what the file says and did not change it.
