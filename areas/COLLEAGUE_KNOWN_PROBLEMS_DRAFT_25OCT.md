# Colleague pack page 04: known problems and what to do instead (rewrite)

**DRAFT, Sun 25 Oct 2026 (Melbourne), written by Team (Sonnet) for checklist item 27. Not published and not copied anywhere else. Tim approves publishing (checklist 28).** It replaces the 22 Oct draft in `areas\colleague-pack\04_KNOWN_PROBLEMS_AND_WORKAROUNDS.md`, which still says Civil 3.0.70.

---

## FOR TIM (read this, then stop)

1. **Answer:** the page below is ready for your read. It is written for a drafter, with no bug numbers in the body. It says what you will see, what to do instead, and which version has the fix.
2. **What it covers:** the five things to know on day one, then problems grouped by the drafter's job: placing pits and pipes, editing, schedules and calculations, survey and LandXML, install and update, Structural.
3. **Versions used, from the brief and the carpark, not read from the installed files by me:** Civil 3.0.75, Manager 1.1.75, Structural 1.0.123 [CHECK: confirm against the installed DLL version strings before publishing].
4. **Word "fixed":** I used it only where the carpark has a FIXED line. Where a fix is installed but nobody has accepted it, the page says "fixed in the build, not yet confirmed". Where the fix is only built for the next update, it says so. Where there is no fix, it says "no fix yet".
5. **Mistake to own first:** the 22 Oct page was wrong in at least three places by now. The grade measurement, the pipe sizing material and the Pit Schedule depth each have a fix built since, so those items changed.
6. **Not verified, so marked [CHECK]:** about 30 statements. Most are items from the 22 Oct page that I could not re-check without opening AutoCAD (which this job may not do), plus whether the 3.0.75 build holds exactly the fixes I list.
7. **What you need to decide before publishing (all in your Monday list already):** the rainfall note wording, whether the cover figure should add the pipe wall, the computations-sheet sentence about the hydraulic grade line, and whether two switches are ON for colleagues. The page says how each behaves today.
8. **Where the facts came from:** the carpark statuses, the bug triage section C, the 25 Oct pilot-critical batch reports and the train lists, the T5 audit, the open items in QUESTIONS_FOR_MONDAY.md, and the 22 Oct page. A desk-only list of bug numbers is at the very bottom, to be removed before publishing.

---

# Known problems and what to do instead

**Version this page is written for:** Civil 3.0.75, Manager 1.1.75, Structural 1.0.123. The next update (Civil 3.0.76, Manager 1.1.76) is being built. This page says which problem the next update fixes. [CHECK: re-read every line against the frozen build before it goes out]

**What the words mean:**

1. **Fixed:** Tim or a test in real AutoCAD has seen it work.
2. **Fixed in the build, not yet confirmed:** the fix is in the version you have, but nobody has proved it works yet. Treat it as possibly still wrong.
3. **Fix built for the next update:** the fix exists but is not in your version yet.
4. **No fix yet:** use the workaround.

---

## The five things to know on day one

1. **Work on a copy of the job until Tim says otherwise.** If a number looks wrong to you as an engineer, trust yourself and tell Tim.
2. **Install by hand, and leave the update buttons alone.** In CE Manager, do not press Roll Back, Get update ready or any update button. Answer No to any "become administrator" question. Page 02 has the hand install.
3. **Check every engineering number by hand before you issue.** The sizing, cover, step-iron and storage figures each have a known weakness (sections C and D below). Run CDRULES before issue and read its list.
4. **Do not rely on double-click.** Double-clicking a pit number or a downpipe label may open AutoCAD's own editor. Select the item and type PITEDIT or CDEDIT instead.
5. **Report anything odd the same day.** Type CESUPPORT, then follow page 05. Press U straight away if a command went wrong, and type REDO before you click anything else.

---

## A. Placing pits and pipes

1. **A pit placed from an old office copy looks like last year's block.**
   - **You will see:** the pit symbol or fall arrow is not the current one. No warning shows.
   - **Why:** if an older CE was ever installed for all users on your PC, CE reads its blocks first.
   - **Do this:** ask your administrator to check the all-users plug-ins folders for an old CE copy before you start. Tell Tim if the pit looks different from the page-03 pictures.
   - **Fixed in:** no fix yet. [CHECK: Tim to confirm whether the check goes in the hand-install steps]
2. **"Work it out from the grade" in CD rounds the level you typed.**
   - **You will see:** you type a level to three decimals and the pipe holds it to two.
   - **Do this:** read the invert on the drawn label after placing. If it is not the level you meant, type the level you want rather than asking CE to work it out. [CHECK: wording of the workaround]
   - **Fixed in:** no fix yet. Tim has to rule on the rounding.
3. **The grade label ignores which way the levels fall.**
   - **You will see:** a pipe running uphill still reads "1 IN 100".
   - **Do this:** run CDRULES before issue. It says "flows uphill".
   - **Fixed in:** [CHECK: still true on 3.0.75]
4. **A drawing with no units set is read as millimetres.**
   - **You will see:** a drawing drawn in metres with no units set gives nonsense grades, and CE does not say so.
   - **Do this:** type UNITS and set the drawing units before you use CE.
   - **Fixed in:** no change yet. Tim is deciding whether CE prints a one-line note.
5. **Metre drawings need extra care.**
   - **You will see:** some length, level and message checks were written for millimetre drawings. A flat drain (AG drain or perimeter drain) can pass the grade check on a metre drawing. A downpipe or crossing split on a metre drawing may land in the wrong place.
   - **Do this:** use millimetre drawings for CE. If you must use metres, check every grade and length by hand.
   - **Fixed in:** the drain check has no fix yet. The other metre-drawing fixes are in the build, not yet confirmed. [CHECK]
6. **"No clear spot" labels are left where they are.**
   - **You will see:** a pipe label crowded by other text stays put and shows in the "No clear spot" list.
   - **Do this:** move it by hand. This is how Tim wants it.
7. **The grade mismatch box: pressing X still places the pipe.**
   - **Do this:** press Cancel or Escape if you do not want the pipe. Tim has to say whether X should cancel.
   - **Fixed in:** no fix yet.
8. **Pit drop check compares inverts only.**
   - **You will see:** a 150 into a 300 can pass while the top of the 300 sits higher than the top of the 150.
   - **Do this:** where the pipe gets bigger at a pit, match the pipe tops yourself.
   - **Fixed in:** no fix yet. Tim is deciding whether CE warns on the tops.
9. **A pasted pit from a "Save As" sister drawing takes this drawing's pit values.**
   - **You will see:** the pasted pit's size, cover or similar values change to this drawing's defaults.
   - **Do this:** after pasting, open the pit in Edit Pit and check each value.
   - **Fixed in:** no fix yet.
10. **A pasted network that was saved without a repair could leave pipes behind when you moved a pit.**
    - **Fixed in:** the build, not yet confirmed (Civil 3.0.75). After you reopen the drawing, CE should wake up and move the pipes and labels with the pit.
    - **Do this:** after your first MOVE on a pasted network, look that the pipes and labels went with it.
11. **A pasted downpipe took its original's label.**
    - **Fixed in:** the build, not yet confirmed (Civil 3.0.75). Check the label stays with the downpipe you pasted.
12. **One damaged pit record could stop every new pipe linking to any pit.**
    - **Fixed in:** the build, not yet confirmed (Civil 3.0.75). CE should skip the damaged pit, say so once, and link the pipe to the other pits.
13. **Pipe drawn along a curved polyline.**
    - **Fixed (confirmed by the test runner, not by Tim) in Civil 3.0.75:** the pipe length and grade now follow the true line, and a closed polyline keeps its last side.
    - **Still unproved:** picking an existing CE pipe still says "already a CE pipe".

---

## B. Editing

1. **Double-clicking a downpipe does not open the Edit window yet.**
   - **You will see:** AutoCAD's attribute editor opens, or only a text prompt appears, or nothing happens.
   - **Do this:** select the downpipe and type CDEDIT.
   - **Fixed in:** no. The last look in real AutoCAD (22 Oct) still failed. A newer round is in the build, not yet confirmed. [CHECK]
2. **Double-clicking a pit's number label opens AutoCAD's attribute editor, not Edit Pit.**
   - **Do this:** type PITEDIT or CDEDIT and pick the pit. Do not change the pit number in AutoCAD's editor.
   - **Fixed in:** no. The last look (19 Oct) still failed. [CHECK: newer look]
3. **Double-clicking the green downpipe label opens plain text editing.**
   - **Do this:** select the downpipe symbol and type CDEDIT.
   - **Fixed in:** no fix yet. It is waiting for a decision on how the label should behave.
4. **REDO can be lost after you pick a pit.**
   - **You will see:** after U, REDO is greyed out or does nothing. This was seen in a freshly opened drawing.
   - **Do this:** after U, type REDO straight away, before you click anything. Do not rely on REDO after you switch drawing tabs. That is AutoCAD's own limit.
   - **Fixed in:** no fix yet. The cause is not yet found.
5. **Anything you type between U and REDO ends REDO.** That is AutoCAD's own rule. A zoom or REGEN also takes its own Undo step, so read the U line.
6. **A batch edit with one ticked but blank field switches Apply off for the whole batch.**
   - **Do this:** untick the blank field, or fill it, then press Apply.
   - **Fixed in:** no fix yet.
7. **Moving a pit on a pipe with a held grade can make the pipe slightly flatter.**
   - **Do this:** after moving a pit, read the grade label. If it is flatter than intended, retype the downstream level in CDEDIT.
   - **Fixed in:** [CHECK: still true on 3.0.75]
8. **CDTEXTSEG and the arrow prompts used the leg nearest the middle, not the leg you clicked.**
   - **Fixed in:** the build, not yet confirmed (Civil 3.0.75).
9. **Renumber pits only in Edit Pit,** never in the Pit Schedule window. This is Tim's ground rule.
10. **A pit sitting on a pipe: CDSYNC and relinking on a PC that cannot read CE pipe objects used to empty every pit's pipe list.**
    - **Fixed in:** the build, not yet confirmed (Civil 3.0.75). CDSYNC and CDUPGRADE should now stop with a clear line.
    - **Do this:** if you see that line, stop and tell Tim. Do not carry on.
11. **A drawing saved by a newer CE, opened in an older CE, could lose the newer parts of the CE record.**
    - **Fixed in:** the build, not yet confirmed (Civil 3.0.74 onward). Builds older than 3.0.74 still do this.
    - **Do this:** make sure every PC working on the same job is on the same Civil build. Do not open the job on an older build.
12. **The drawn Pit Schedule and the window can disagree on depth when a pit has two outgoing pipes at different levels.**
    - **Fixed in:** the build, not yet confirmed (Civil 3.0.75). A second, lower outgoing pipe should now count in both places.
    - **Do this:** after any pit edit, compare the drawn depth and the step-iron note with the Edit Pit window.

---

## C. Schedules and calculations

**Rule for this whole section: check the number by hand before you issue. Run CDRULES first.**

1. **The Pit Schedule measures depth in two places that can disagree.**
   - **You will see:** the schedule says "no step irons" while CDRULES says they are needed, or the other way round.
   - **Do this:** for step irons, go by CDRULES, or work the depth from the pit floor yourself. Tim ruled pit floor on 20 Oct.
   - **Fixed in:** the pit-floor depth fix is in the build, not yet confirmed. [CHECK: the step-iron depth is still read from two places and one fix was reviewed and rejected]
2. **The drawn Pit Schedule remarks can cross the row lines on the issued sheet.**
   - **Do this:** look at the printed sheet. Move or widen the row if the remark crosses a line.
   - **Fixed in:** [CHECK: a fix is in the Structural build; whether it covers the Civil schedule is not confirmed]
3. **A Pit Schedule placed as an Xref says OUT OF DATE, and Project QA fails, when nothing has changed.**
   - **Fixed in:** the build, not yet confirmed (Civil 3.0.75). It should say OUT OF DATE only when something the schedule draws has changed.
4. **After you BIND a CE Xref, the schedule says SOURCE MISSING and QA fails for good.**
   - **Do this:** tell Tim. [CHECK: no safe workaround recorded]
   - **Fixed in:** not yet. Tim is deciding whether a bind should warn or fail.
5. **Cancelling a Pit Schedule export used to save the row order into the drawing anyway.**
   - **Fixed in:** the build, not yet confirmed (Civil 3.0.75). CLOSE should not ask "Save changes?" after you Cancel an export.
6. **No "Delete cell" on the Pit Schedule cell right-click menu.**
   - **Do this:** clear the text by typing over the cell. [CHECK]
   - **Fixed in:** no fix yet.
7. **After your first CDSYNC the Pit Schedule header "data issues" count goes up by one.** The rows are unchanged. Ignore it.
8. **CDRULES and CDCHECKS used to measure a pipe's grade pit centre to pit centre.**
   - **Fixed in:** the build, not yet confirmed. A fix using the real pipe length is installed.
   - **Do this:** on any bent or broken pipe, still check the grade on the drawn label against the minimum yourself.
9. **CDRUNSOLVE and the network redesign sized every pipe as UPVC.**
   - **Fixed in:** [CHECK: the fix is built (pipe material in the solver); confirm it is in the installed version and not yet confirmed in AutoCAD]
   - **Do this:** until confirmed, do not accept proposed sizes for concrete pipes without a hand check.
10. **The automatic pipe sizer can pick the smallest pipe at any grade.**
    - **You will see:** CDRUNSOLVE or auto-design offers a pipe that is too small for a flat or steep grade. A steep pipe may be offered at 1 in 1.
    - **Do this:** do not accept a proposed size without checking it. Redesign and auto-design also drop the minimum grade for DN450 and larger, so check large pipes by hand.
    - **Fixed in:** no fix yet.
11. **Council figures are not all used.**
    - **You will see:** the council's minimum after-development runoff coefficient (Darebin, Maribyrnong and Boroondara) is never applied. The before-development figures stored for Maroondah and Yarra Ranges are not used.
    - **Do this:** for those councils, enter the council's own figures and check the storage by hand.
    - **Fixed in:** no fix yet.
12. **A STORM rating report that names a two-word council (Glen Eira, Yarra Ranges) sets a council CE could not find.**
    - **Fixed in:** the build, not yet confirmed (Civil 3.0.75).
13. **CDDESIGN's rainfall note says the office curve reads "7 to 9 per cent high".**
    - **You will see:** on two real Glen Eira jobs the curve read 6 to 8 per cent low, so storage came out about 18 per cent short (2.12 m³ against 2.58 m³ on the issued sheet).
    - **Do this:** for on-site detention, use the site's own rainfall and check the figure against the office method before anything is issued.
    - **Fixed in:** no fix yet. Tim is deciding the wording and the curve values.
14. **Cover is measured to the inside top of the pipe, and only at the two pits.**
    - **You will see:** the pipe wall is ignored. That is about 20 mm on UPVC 225 and about 45 mm on concrete 375. A low spot between pits (a garden bed or a driveway) is never checked.
    - **Do this:** add the wall thickness, and check cover where the surface dips between pits.
    - **Fixed in:** no fix yet. Tim is deciding whether CE adds the wall.
15. **Different screens judge one pipe against different minimum grades and cover.**
    - **You will see:** the Inspector palette and CDRULES can disagree on the same pipe.
    - **Do this:** go by CDRULES and tell Tim about the difference. [CHECK: Tim to confirm which one is right]
    - **Fixed in:** no fix yet.
16. **The Boyd's tab in CDCALC and CDDESIGN use different hard-ground runoff figures, so one site gives two storage figures.**
    - **Do this:** note which one you used, and tell Tim if they differ.
    - **Fixed in:** no fix yet.
17. **The CDDESIGN storm list jumps from 5 to 10 minutes, so storage can come out 2 to 3 per cent low.**
    - **Do this:** add a small margin, or check a 6 to 8 minute storm by hand. [CHECK: still true]
18. **CDCALC Catchments opens with a made-up catchment and a 15-minute storm.**
    - **Do this:** clear it and enter your own catchment and storm before you read any result.
    - **Fixed in:** fix built for the next update (Civil 3.0.76). It should open empty at the office storm time. [CHECK]
19. **The computations sheet does not say the hydraulic grade line and pit losses were not checked.**
    - **You will see:** each pipe is checked full-bore on its own grade only. A council reviewer could read the sheet as a full hydraulic check.
    - **Do this:** where the council asks for a hydraulic grade line, work it out separately.
    - **Fixed in:** the sentence is built but held until Tim says yes. Not in the next update unless he does.
20. **The charged-system tab does not check the 300 mm minimum head on a downpipe system.**
    - **Fixed in:** fix built for the next update (Civil 3.0.76). It warns if the head you type is under 300 mm. It compares the head you type, not the head left after pipe losses. [CHECK: Tim has not ruled]
21. **The rainwater-tank reuse credit does not run on a real job.**
    - **You will see:** storage can come out larger than needed.
    - **Do this:** if the council allows a reuse credit, work it out by hand.
    - **Fixed in:** no fix yet.
22. **The WSUD tab in CDCALC credits every ticked measure over the whole site.**
    - **You will see:** a tank, a gross pollutant trap and a swale together can show a PASS that MUSIC would not give.
    - **Do this:** treat the WSUD tab as indicative only. Do not give it to council as a MUSIC result. [CHECK: the "indicative" label may or may not be in the build]
23. **CDTWL on a drawing set in metres counts pipe storage 1,000 times too small. On any drawing it can count a little water twice (about 4 per cent).**
    - **Do this:** use millimetre drawings for CDTWL, and check the total storage by hand.
    - **Fixed in:** [CHECK: some of the CDTWL number fixes are in the build, not yet confirmed]
24. **CDCALC number boxes read "0,35" as 35.**
    - **Do this:** always use a full stop for decimals. [CHECK: still true]
25. **Main pipes ticked as Detention with no length read "not judged" in CDCHECKS.**
    - **Do this:** enter the detention length, or untick Detention, and the row clears. Tim has not decided whether that is the wanted behaviour.
26. **Some CDRULES, CDCHECKS and CDTWL words say "Unknown" and others say "not known".** Both mean the value is missing. Tim is deciding which word to use.

---

## D. Survey and LandXML

1. **Approved survey levels stay in use after you move the survey Xref.**
   - **You will see:** CDSURVEY approved the levels at the old position. After you move, turn or scale the Xref, New Pit still offers those levels.
   - **Do this:** run CDSURVEY again after you move the Xref. Check the first level it offers against the survey.
   - **Fixed in:** not in your version. The fix is built but held until Tim decides what should happen if you detach the Xref. [CHECK]
2. **Levels in a block inside a turned survey Xref used to land in the wrong place.**
   - **Fixed in:** the build, not yet confirmed (Civil 3.0.75).
3. **The long section throws away survey levels more than 1.20 m from the cover line.**
   - **You will see:** a dip or depression in the survey is hidden.
   - **Do this:** compare the long section with the survey where the ground dips.
   - **Fixed in:** no fix yet.
4. **A LandXML pipe with no grade prints an invented "AT 1 IN 100".**
   - **Do this:** do not trust a grade on an imported pipe unless the LandXML file gives one.
   - **Fixed in:** fix built for the next update (Civil 3.0.76). [CHECK]
5. **LandXML cover and invert levels are not converted from millimetres to metres.**
   - **You will see:** levels in a millimetre file read 1,000 times too large.
   - **Do this:** check imported levels against the source file.
   - **Fixed in:** no fix yet. A draft fix is waiting for a review.
6. **X-Civil import drops levels above RL 250 m.**
   - **Do this:** on a high site, check the imported levels against the source. [CHECK: still true]
7. **A consultant's schedule import has not been tried on real packages from every consultant.** Check pit numbers, sizes and levels against the PDF schedule after import.
8. **Two survey points within 50 mm of each other with different levels (a wall top and bottom shot) can refuse a whole CDSURVEY load in a millimetre drawing.**
   - **Do this:** if the load refuses, tell Tim. [CHECK: whether "skip suspect points" is ON]
9. **Every double-click on a block scans every block, which is slow in survey drawings.**
   - **Do this:** be patient, or turn off the survey Xref layers while you edit.
   - **Fixed in:** no fix yet. [CHECK: the layer workaround]

---

## E. Install and update

1. **You can run the installer program only with administrator rights.** The hand copy (page 02) does not need administrator rights. Use the hand copy.
2. **An old CE copy in the all-users plug-ins folders can win over your new one.** See section A item 1. Ask your administrator to check before you start.
3. **An old July Structural on your PC may stop Civil finding its files.**
   - **You will see:** "command failed" lines on your first job, or Help and linetype lookups failing.
   - **Do this:** tell Tim the Structural version you have before your first start. He may ask you to switch it off. [CHECK: not proved]
4. **The office folders may not be where Civil looks.**
   - **You will see:** CDFEEDBACK says "saved on this PC" every time, so Tim never gets your report. CE Blocks says "Could not find a part of the path". CDNEWDWG cannot find the templates. CDWT loses its tank window.
   - **Why:** Manager and Civil look for the office folders in different places. Civil looks only under your own Creative Engineering folder.
   - **Do this:** before your first start, check that "Creative Engineering - Drafting", Standard Details and Drawing Templates show as fully synced. Tell Tim where OneDrive puts them.
   - **Fixed in:** no fix yet.
5. **Do not copy Tim's settings file as it stands.** It carries his folder paths, so CDWT and CDNEWDWG will not find their files on your PC. Ask Tim for the colleague settings. [CHECK: no approved colleague settings file exists yet]
6. **Your job time may go to your own PC instead of the office, if OneDrive has not finished syncing the Drafting folder at your first start.**
   - **Do this:** wait for the sync before your first AutoCAD start.
   - **Fixed in:** fix built for the next update (Civil 3.0.76). It looks again at every start. [CHECK]
7. **The weekly time export can slow AutoCAD's start, and it writes your name and job addresses to the shared Drafting folder from your first start.** You cannot turn it off. Tim decides this. [CHECK]
   - **Fixed in:** the slow start is fixed for the next update (Civil 3.0.76). The export itself stays.
8. **If Manager loads before Civil, the CE Tools tab can be missing.**
   - **Do this:** close AutoCAD and start it again. Tell Tim if the tab is still missing.
   - **Fixed in:** no fix yet. [CHECK: restart workaround]
9. **The status bar says "[Modern]" on both AutoCAD 2025 and 2026.** It does not tell them apart. Tell Tim your AutoCAD year as well as the number on the bar.
10. **CEHEALTH can call an unloaded Civil "OK".** Check that the CE tabs are on the ribbon, as well as reading CEHEALTH.
11. **The Manager can show "CE is current." after a failed read of the office approval file.**
    - **Fixed in:** fix built for the next update (Civil 3.0.76 / Manager 1.1.76). [CHECK]
12. **CDFEEDBACK Help promises a "Save report" step that does not exist.**
    - **Do this:** press the Send report button. Page 05 has the steps.
    - **Fixed in:** the Help wording is fixed for the next update.
13. **Drawing Repair says "Nothing has been changed" after a successful repair.** Read the summary line. If it says the item was fixed, it was.
    - **Fixed in:** the next update.
14. **Civil's error reports to Tim never arrive and pile up on your PC.** Use CESUPPORT and send the zip. No fix yet.
15. **Manager buttons to leave alone:**
    1. **Roll Back Release:** do not press it. Go back by hand (page 02, section 7).
    2. **Get update ready, or any update button:** do not press it. Updates come by hand for now (page 02, section 5).
    3. **Set up CE administrator, and any "become administrator" question:** always answer No. Only Tim is the CE administrator.
    4. **The Manager fault report and diagnostic buttons:** use CESUPPORT instead (page 05). [CHECK: whether the coded-names work is complete in 1.1.75]
16. **Going back (rollback) is written but not rehearsed on a normal login, and saves only two of the CE settings folders.** Follow page 02, section 7. Add `%APPDATA%\CE_CADTOOLS`, `%APPDATA%\Creative Engineering\CE Suite Manager` and `%APPDATA%\CE_SUITE_MANAGER\logs` to your backup. [CHECK: Tim to confirm the extra folders]
17. **Going back may restore an old Manager that tries to stage updates by itself.** If CE puts a new folder into the all-users plug-ins folder after a rollback, tell Tim. [CHECK: not proved]
18. **A package that arrives as a downloaded zip may block a helper file.**
    - **You will see:** the PDF pit-schedule part of CDIMPORTXCIVIL fails quietly.
    - **Do this:** copy the package from a USB stick or the synced pilot folder, not from an emailed or Teams zip. [CHECK]
19. **There is no uninstall button.** The only route is renaming the CE folders by hand (page 02).
20. **Help and messages still point at Tim's own folders in a few places** (CDSL, CDHELP, CDTRENCHGRATEAUDIT). Ignore the path. Tell Tim if CDTRENCHGRATEAUDIT cannot find its drawing.
21. **Some start-up lines look like errors:** "Menu item failed to load: CE_..._MENU" and "; error: syntax error". They are harmless and the CE tabs still work. [CHECK: still appear on 3.0.75 on a clean PC]
22. **In a CE drawing, F2 runs the CE command CLEAN, not the text window.** Save with Ctrl+S. To read the whole command line, type TEXTSCR, then GRAPHSCR to come back. [CHECK: still true on 3.0.75]

**Only if your AutoCAD is 2022, 2023 or 2024** (your year is not recorded; Tim will ask you). Nothing on this build has been driven in those years.

1. **A downpipe cannot be placed directly on a pit.** Place it beside the pit and move it. [CHECK: workaround]
2. **One downpipe in a COPY used to cancel the clean-up for every pit and pipe copied.** Fix built for the next update (Civil 3.0.76). Until then, copy pits and pipes without downpipes, and add the downpipes after.
3. **Edit Pipe and Edit Pit lose the plan and picture selection.** No fix yet.
4. **Moving a pit can leave CE pipe objects behind with no message.** The next update prints a line naming them. Check the pipes after any MOVE.

---

## F. Structural

Structural stays on Tim's PC for the 9 Nov release. [CHECK: Tim to confirm whether a colleague gets Structural at all] The items below are what Tim has recorded as open or undecided in Structural 1.0.123.

1. **The Dimension tool (AD) may refuse a drawing at 1:50.**
   - **You will see:** "Only DIMSCALE 20 or 100 is supported" and nothing is placed.
   - **Do this:** dimension by hand at 1:50. [CHECK: Tim ruled all scales supported on 20 Oct; whether the build now accepts 1:50 is not confirmed]
2. **DOTS and wall hatches change look with the drawing scale.** At 1:100 the load-bearing wall hatch is five times sparser, and a short wall nib can show no hatch line.
   - **Do this:** look at every hatch at the plotted scale. Add a line by hand where a nib shows none.
   - **Fixed in:** no fix yet. Tim is deciding a minimum spacing.
3. **The scale-aware hatches refuse to draw when LTSCALE is not 10 times DIMSCALE.**
   - **Do this:** set LTSCALE to 10 times DIMSCALE.
   - **Fixed in:** no fix yet. Tim has said it should warn and carry on.
4. **Some label text heights are fixed at every scale** (TH, PF, BP, column and 18-text labels), so they plot larger than the paper size at 1:50.
   - **Do this:** check label heights on the sheet.
   - **Fixed in:** no fix yet. Tim is deciding.
5. **SBEAM and CEMEMBER draw the same steel section at different sizes at 1:100.**
   - **Do this:** use CEMEMBER for the true model-space size. Do not mix the two on one view. [CHECK: Tim has not confirmed which is right]
6. **CEMEMBER still uses the old steel section list.**
   - **You will see:** 310UB32.0 is refused, there is no Z15015, and the 380PFC web thickness is wrong.
   - **Do this:** do not use CEMEMBER for those sections.
   - **Fixed in:** no fix yet. The corrected list is waiting for Tim's yes.
7. **A fresh open of a drawing can mark it as changed**, so CLOSE asks "Save changes?" with nothing touched. [CHECK: seen on 1.0.96; not re-checked]
   - **Do this:** if you have not changed anything, choose No.

---

## What has been fixed and checked

These had a fix that was seen working. They are no longer problems.

1. **CDSL now checks the number you type.** Confirmed by the test runner on Civil 3.0.75 (not by Tim). "P18.6", "18,6" and "18.6m" no longer become wrong text.
2. **CDSYNC no longer turns every pipe size in the Pit Schedule to 100.** Confirmed in real AutoCAD, Civil 3.0.64.
3. **Tidy labels now says which pipe's text it will move.** Confirmed in real AutoCAD, Civil 3.0.67.
4. **The pit and Drawing Border no longer block a label for no reason.** Confirmed in real AutoCAD, Civil 3.0.65.
5. **CDCHECKS no longer warns "detention diameter" on 100 and 150 mm downpipes.** Confirmed in real AutoCAD, Civil 3.0.64.
6. **Recover Inverts reports its totals correctly** (the totals half only; it still does not redraw a single missing invert text). Confirmed in real AutoCAD, Civil 3.0.64.
7. **Typing A at the strip drain "Accept" prompt now accepts.** Confirmed by Tim on 14 Sep.
8. **Edit Pipe on a locked pipe layer now says the layer is locked and nothing was changed.** Confirmed by the test runner on Civil 3.0.75. [CHECK: the carpark entry does not show this FIXED line yet]

---

## Decisions Tim has not made yet (so these behave as described until he does)

1. **Rainfall note wording and whether the curve values are raised.**
2. **Whether cover adds the pipe wall.**
3. **Whether CE warns when a pipe gets bigger at a pit and the tops do not line up.**
4. **Whether a drawing with no units prints a one-line note.**
5. **Whether the computations sheet carries the hydraulic grade line sentence.**
6. **Whether the "Tidy labels names the pipe" switch is ON for colleagues.** It is OFF in Tim's file, so it is OFF for you until he says.
7. **Whether the "clean up grip Ctrl-drag, ROTATE Copy and SCALE Copy like COPY" switch is ON for colleagues.** Until it is, a ROTATE Copy or SCALE Copy of a pit leaves two pits with the same number and no label or cover text. **Do this:** use COPY, not a grip copy, for pits.
8. **What happens if you detach a survey Xref after CDSURVEY approved it, and what happens after you BIND a stage drawing.**
9. **How a colleague finishes an update.** Updates are by hand for now.

---

## [DESK ONLY: remove this whole section before publishing] Bug numbers behind each statement

Not part of the page. Kept so Tim or the desk can trace each line. Source for versions and statuses: BUG_CARPARK.md, BUG_REGISTER_TRIAGE_2026-10-24.md section C, the pilot-critical batch 1 to 5 reports, TRAIN_C65_PR_LIST_2026-10-25.md, REVIEW_PILOT_CRITICAL_B4B5_25OCT.md, TEAM_AUDIT_T5_24OCT.md, QUESTIONS_FOR_MONDAY.md.

1. **Day one and section A:** old all-users copy supplies blocks BUG-1165 (no fix); level rounding BUG-685; uphill label (22 Oct page); unitless drawing BUG-505; drain on metre drawings BUG-1052; "No clear spot" Tim's 20 Oct ruling; grade mismatch X BUG-857; pit drop BUG-907; paste from sister drawing BUG-1148; pasted network BUG-1150 (#1758, C-65); pasted downpipe BUG-1140 (#1763, C-65); damaged record BUG-1142 (#1752, C-65); curved polyline BUG-684 (FIXED, Claude-accepted, 3.0.75).
2. **Section B:** downpipe double-click BUG-859 (OPEN, still fails 22 Oct); pit label BUG-430 (OPEN, fails 19 Oct); green label BUG-860 (no fix); REDO BUG-861; batch edit BUG-1049; arrows BUG-1194 (#1757, C-65); CDSYNC no pipe objects BUG-1138 (#1748, C-65); newer job record parts BUG-1135 (#1747, C-64); lower second pipe BUG-1196 (#1760, C-65).
3. **Section C:** step-iron depth BUG-540 (PR #1192 rejected) and BUG-869 (pit floor, built C-63); remarks BUG-587 (carpark says fix in Structural 1.0.121 via #1270, odd, check); Xref schedule BUG-1145 (#1765, C-65) and BUG-1149 (#1767, left out for Tim); export Cancel BUG-1198 (#1764, C-65); Delete cell BUG-1031; data issues count BUG-855; grade length BUG-867 (installed); UPVC sizing BUG-868 (C-63); sizer BUG-1088 and BUG-1091; councils BUG-1095 and BUG-1099; two-word council BUG-1106 (#1761, C-65); rainfall note BUG-866; cover BUG-901 and BUG-902; screens disagree BUG-903; Boyd's BUG-905; catchments BUG-1101; hydraulic line BUG-1090 (#1771); head BUG-1097 (#1772); tank credit BUG-1096; WSUD IJK-18; CDTWL BUG-777, BUG-871, BUG-970, BUG-1019; Detention "not judged" BUG-815 follow-on (Monday I8); Unknown wording (Monday, 23 Oct).
4. **Section D:** BUG-1189 (#1756, left out); BUG-1190 (#1755, C-65); BUG-1192; BUG-1188 (#1773); BUG-1053; X-Civil RL 250 (22 Oct page); consultant package BUG-058 to BUG-068 group; suspect survey points (Monday G4); double-click scan BUG-865.
5. **Section E:** installer admin BUG-882; old Structural BUG-1169; office folders BUG-1166; settings copy BUG-1167; job time folder BUG-1168 (#1775); weekly export BUG-492 and BUG-1202 (#1776); Manager before Civil BUG-1206; status bar T5 finding 8; CEHEALTH MGR-01; approval file BUG-1179 (#1769); feedback Help BUG-1215 (#1768); Drawing Repair BUG-1180 (#1774); reports pile up BUG-1171; update buttons BUG-477, BUG-948, BUG-478; backup folders BUG-1173; old Manager after rollback BUG-1170; zip block T5 finding 12; uninstall BUG-888; Lisp Files wording T5 finding 11; older AutoCAD: BUG-1209, BUG-1137 (#1778), BUG-1210, BUG-1151 (#1777).
6. **Section F and fixed list:** Monday questions F1, F2, E (Structural), 23 Oct Structural list; fresh open modified BUG-383 (OPEN); fixed list BUG-711, BUG-698, BUG-856, BUG-141 and BUG-207, BUG-854 and BUG-815, BUG-820, BUG-100, BUG-384 (desk log 25 Oct 09:00, no FIXED line in the carpark file when I read it).
7. **Not checked by me:** I did not read the installed DLL versions, open AutoCAD, or open any PR. Whether each C-65 fix is really in 3.0.75 rests on the C-65 finalizer report and the brief.
