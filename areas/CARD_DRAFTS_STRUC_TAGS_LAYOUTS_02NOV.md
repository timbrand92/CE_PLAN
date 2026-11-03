# Card drafts 14 of 15: Structural tags, layout units and Settings

Written Monday 2 November 2026 (Melbourne) by Sonnet for CE 05, at CE 00's request. Read-only job: nothing was built, tested, installed or opened in AutoCAD, and the robot was not run. Tim's real settings files were not read or written.

## FOR TIM

1. **Five cards, all drafts, nothing approved.** One each for: tag sizes at every scale (#1596), CSREOBAR on a layout (#1587), Structural Reset Defaults (#1457), typed bar counts in the RC windows (#1731), and Bored Pier plus the column picker (#1986 and #1261, one card because both were asked for as item 5).
2. **Everything was pinned down.** Each command has an exact name on the Structural line. Where the exact ribbon panel is a guess from a routing list rather than the screen, the card says GUESS.
3. **Questions that need you: 7, in cards 1, 3, 4 and 5.** Cards 1 and 5 have two each, card 3 has two, card 4 has one. Card 2 has none. Nothing is turned into a decision.
4. **Two PRs must change before they ship.** #1596 would draw the footing tags (THC, PFC and similar) 1,000 times too small in a drawing set to metres. #1457 says it resets "the settings shown in this window" but resets about 40 groups, including ones the window never shows.
5. **#1261 needs no build.** The "Press 1 to 9" wording is already on the Structural line and in installed Structural 1.0.121 (per the carpark). Only the look in AutoCAD is owed.
6. **A mismatch to fix in the paperwork.** The draft CESETTINGS card of 31 Oct says "Reset ... restores office defaults per section". The code on the Structural line has one Reset Defaults button that rewrites the whole file with no question. The card is wrong on that point.
7. **Read:** the Opus reviews of 1 Nov (backlog R2, R7, and the 1984 to 1988 group), the carpark entries, your 20 Oct answers, the build register, the three older family cards, and the Structural code on origin/claude/rel-20261026s (head 204dfad2, 27 Oct). I could not check live PR state because the `gh` tool is not available in this shell.
8. **NOT proven for any of the five:** none has been opened in AutoCAD, none is installed (except the #1261 wording), none is accepted by you or by Codex. Built and unit-tested only, by the PR authors, and I ran none of those tests.

---

## CARD 1: TH, PF, BP, column and 18 tags keep their size on paper at every scale (PR #1596, BUG-951)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter.** Tag text for thickenings, pad footings, bored piers, columns and 1.8 mm notes is drawn at a size that gives the same height on the printed sheet at every drawing scale, instead of always 250, 200 or 180 model units.
2. **Ribbon or trigger.** Tab "CE Structural" (CeStrucRibbonContributor). The routing list puts THL, PFL, BPL, CL1 and 18T under Structural > Text Tags, and THC and PFC under Structural > General (GUESS that these are the panel names on screen). The older toolbar file also lists THL under a "Footings" section. Command line: THL, THR, PFL, PFR, BPL, BPR, CL1, CR1, PCL, PCR, 18L, 18R, 18T, 18B, SL, SR, DSL, DSR, TSL, TSR, THC, THCL, THCR, BTHC, PFC, BPFC, BPC and their L and R forms (27 lines in CeTextService.cs on the PR).
3. **Works today.** The tags draw on layer 25TEXT, colour 7, at a fixed 250 (TH, PF, BP, THC, PFC), 200 (column tags) or 180 (the 1.8 mm tags). At 1:100 with a 2.5 mm label height that is the correct plotted size. Keep would protect: the prompts, the placement, the layer and colour, and that a 1:100 drawing looks unchanged.
4. **What the train or PR changes.** PR #1596 (head be6e198f). Each of the 27 lines calls `FixedTagHeight(250|200|180)`. The height becomes label plot height x drawing scale x (old height / 250). It reuses the existing switch `Layouts.TagTextFollowsLabelHeight`, which is **ON by default** and already exists on the Structural line (UserSettings.cs line 1967; label plot height `Layouts.LabelPlotHeightMm` is 2.5). With the switch OFF the old fixed heights come back exactly. The 25C and EBT tags already follow this rule.
5. **Suggested class: Modify.** Same command, same prompts, new height rule. Right idea, but CHANGE-NEEDED first (see field 9). GUESS: Modify, not Rebuild, because nothing else about placement changes.
6. **Prompts and windows.** No new prompt or window. The registry lists "Text input", "Insertion point", "Orientation keyword" for the tag commands. No new message.
7. **Selection.** Unchanged: you type or pick the text value and a point, as today.
8. **Preview.** No new preview. The ST-04 family card asks for a "preview at approved plotted height"; this PR does not add one.
9. **Drawing output.** Only the text height changes. Same layer 25TEXT, same colour. Nothing else is touched. The footing rectangle commands already stop on a layout tab and in REFEDIT (CeTextService.cs line 614 on the Structural line). Nothing about locked layers, Xrefs or REFEDIT changes. No new write path.
   1. **Fault found by Opus (1 Nov):** in a drawing set to metres, the twelve footing rectangle commands (THC, THCL, THCR, BTHC and L/R, PFC and L/R, BPFC and L/R) convert the height twice. A 250 mm tag at 1:100 would come out 0.25 mm high. Millimetre drawings are not affected. Must be fixed and tested before shipping.
   2. **Still fixed:** the "column over" second line inside those commands stays 180 at every scale (line 1308 on the Structural line). At 1:50 the main tag would be 125 while that line stays 180.
   3. **Not covered:** the setout, floor setout, lintel and level-carry tags keep their own Settings height. BUG-951's title names setout tags, so BUG-951 cannot close on this PR alone.
10. **Cancel, Escape, Undo and Redo.** No change. Cancel at the prompts leaves the drawing as it was. One U removes a tag and Redo puts it back (to be proven; see field 17).
11. **Save and reopen.** The text is ordinary text with its drawn height, so it reopens as saved. A drawing placed before the change keeps its old heights until the tags are redrawn (GUESS: nothing rewrites old tags; I did not find code that does).
12. **Assets, data and Settings.** Reads `Layouts.TagTextFollowsLabelHeight` (default true; unreadable means on), `Layouts.LabelPlotHeightMm` (2.5), and DIMSCALE. The 250, 200 and 180 base sizes stay in code as ratios (1, 0.8, 0.72). Writes nothing. The switch has no row on any Settings page (CODEX_AUDIT_STRUCTURAL_22OCT); the PR only adds a recovery help line.
13. **Performance.** One extra height calculation per tag. Nothing noticeable.
14. **Discovery.** Same ribbon buttons and command names. No Help page change is recorded. A change-log entry is needed saying that at 1:100 with label height 3.5 mm a TH tag becomes 350, as EBT already does.
15. **Example drawing and expected result.** Millimetre drawing, label plot height 2.5.
    1. DIMSCALE 100: PFL 250, CL1 200, 18T 180 (unchanged).
    2. DIMSCALE 50: PFL 125, CL1 100, 18T 90 (2.5 mm, 2.0 mm and 1.8 mm on paper).
    3. DIMSCALE 20: PFL 50. Today it is 250 high, which prints 12.5 mm on paper.
    4. Layout tab: PFL 2.5.
    5. Metre drawing (UNITS metres), DIMSCALE 100: PFC 600x300 label 0.25. This is the case that fails on the PR as written.
16. **Older family card.** `C:\Lisp Files\CE_ACAD_PLUGIN\docs\CARDS\ST-04_TEXT_PLACEMENT.md`. It says THL/THR, PFL/PFR and BPL/BPR are "Keep; add visible preview and ownership" and (ST4-8) that heights are based on plotted paper size. It no longer says: which commands change now, the switch name and its default, the metre-drawing fault, the 180 second line, or that your 20 Oct ruling settles the scale rule. Also read ST-03 for BL and scale; it says nothing about these tags.
17. **Tim's AutoCAD checklist (after the metre fix; a copy of a drawing, settings set before AutoCAD starts).**
    1. New millimetre drawing. Type DIMSCALE, 100. Type LTSCALE, 1000.
    2. Type PFL, text 250, pick a point. You should see text 250 high. Type 18T and CL1 the same way: 180 and 200 high.
    3. Type DIMSCALE, 50 and LTSCALE, 500. Repeat PFL, 18T, CL1. You should see 125, 90 and 100.
    4. Type THC, 600x300, pick a point. You should see the outline and a TH label 125 high.
    5. Go to a layout tab. Type PFL. You should see 2.5 high. THC should stop with its layout message.
    6. Type U after each command: the tag goes. Type REDO: it comes back.
    7. Switch off: ask CE 05 to set `Layouts.TagTextFollowsLabelHeight` to false in a copy of the settings before AutoCAD starts. Every tag returns to 250, 200 or 180.
    8. New drawing set to metres, DIMSCALE 100. Type PFC, 600x300. The label should be 0.25 high, not 0.00025.
18. **Questions only Tim can answer.**
    1. **The 180 "column over" line inside the footing tags.** Context: it stays 180 at every scale. I understand it should follow the same rule. Recommendation: yes, make it follow, so a tag never has one line at one scale and the next at another. On a job: at 1:50 the TH label would be 125 and the column line 90 instead of 180.
    2. **Setout, lintel and level-carry tags.** Context: they use their own Settings height and BUG-951 names setout tags. I understand your 20 Oct ruling says every scale follows DIMSCALE and LTSCALE. Recommendation: record them as a separate carpark item and decide with the office block questions (BUG-536 is parked "8talk later"). On a job: a setout tag stays one size on the sheet whatever the scale until that item is done.
19. **NOT proven.**
    1. **Built:** by the PR author only. net48 was not built for #1596 (PR body, per Opus). Nobody has re-built it.
    2. **Tested:** 17 unit cases by the author; they would also pass with the metre fault because none covers a converted drawing. I ran none.
    3. **Installed:** no.
    4. **Tim-accepted:** no. Nobody has opened #1596 in AutoCAD. BUG-951 stays OPEN.

---

## CARD 2: CSREOBAR bar lengths on a layout read in millimetres as drawn (PR #1587, BUG-1025)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter.** CSREOBAR writes the bar note (for example "3-N16-100 CTS x 5500 LG") from the length you draw. On a layout sheet in a metre drawing it should read the length in sheet millimetres, so a 100 mm bar says 100, not 100000.
2. **Ribbon or trigger.** Command CSREOBAR, label "Reo bar", group Footings, subgroup Rebar (command registry on the Structural line). CSBARSCHEDULE refreshes the bar schedule. Ribbon tab "CE Structural"; GUESS for the exact panel, not read on screen.
3. **Works today.** In model space and in ordinary millimetre drawings the length reads correctly. The command asks size, number, spacing and face, then the two ends, shows a check and places on Enter. Keep would protect all of that, the bar mark and the locked-layer and REFEDIT refusals.
4. **What the train or PR changes.** PR #1587 (head b8026c89). New `ReoBarCore.MmPerUnitInSpace(onLayout, insunits)`: 1 on a layout, the model conversion otherwise. Place decides by the current space; Refresh judges each bar by the space its extent sits in. **No Settings switch** (a unit reading, not an engineering value). Joins the line with a keep-both clash next to the BUG-986 plan-length line.
5. **Suggested class: Modify** (a unit reading corrected), noted KEEP-WITH-NOTE by Opus. GUESS: no card work beyond the note.
6. **Prompts and windows.** From the code: bar size; "Number of bars <n>: "; spacing; face (Top / Bottom / Top and bottom); "Start of the bar extent: "; "End of the bar extent: "; then "Place this reo bar? [Yes/No] <Yes>: ". No new prompt. For CSBARSCHEDULE: "Pick the top-left corner of the bar schedule: ".
7. **Selection.** Two picked points for the extent. Refresh reads existing bars.
8. **Preview.** The existing check before Enter. Unchanged.
9. **Drawing output.** The bar line, extent arrows, note text and bar mark. Only the length figure changes. Existing protection stays: "A block or Xref is open for editing (REFEDIT), so CE drew no reo bar. Close REFEDIT and try again." and the locked-layer line (LayerService.LockedLayerLine "reo bar"). Refresh says "...CE left the bar schedule as it was" in REFEDIT and refuses on a locked layer. No new write path. A layout with a model-space viewport active counts as model space.
10. **Cancel, Escape, Undo and Redo.** Cancel at any point stops with nothing drawn. One U removes the bar; Redo puts it back with the same note (to be proven).
11. **Save and reopen.** The note is text and reopens as saved. Opus noted that Refresh can still print the "drawing is in metres" units line for a schedule whose bars are all on a layout; harmless, optional tidy.
12. **Assets, data and Settings.** Reads INSUNITS and the current space. Reads bar defaults from Settings (size, spacing, count, zone). Writes nothing new.
13. **Performance.** No change.
14. **Discovery.** Same command and registry entry. No Help change recorded.
15. **Example drawing and expected result.** Drawing UNITS set to Meters (INSUNITS 6). Layout tab. CSREOBAR, N16, 3 bars, spacing 100, Top, from 20,20 to 120,20 on the sheet. Note should read 100 (today 100000). CSBARSCHEDULE row reads 100. In model space draw 0,0 to 0.1,0: still 100 (as before).
16. **Older family card.** `C:\Lisp Files\CE_ACAD_PLUGIN\docs\CARDS\ST-06_FOUNDATIONS_REBAR.md`. It lists rebar tools (RBL and others) but says nothing about CSREOBAR on a layout or the metre-drawing reading. It does not record the unit rule. (The registry notes the command comes from UX-BSMT-04 and UX-FDN-04.)
17. **Tim's AutoCAD checklist (on a copy).**
    1. New drawing. Type UNITS, set Meters.
    2. Click a layout tab. Type CSREOBAR. Answer N16, 3, 100, Top. Pick 20,20 then 120,20, press Enter to place. You should see a note ending in 100, not 100000.
    3. Type CSBARSCHEDULE and pick a corner. The row should say 100.
    4. Go to model space. Type CSREOBAR again, same answers, from 0,0 to 0.1,0. You should see 100.
    5. Type U on the layout bar, then REDO. The same note returns.
    6. Lock the rebar layer and try again on the layout. CE should refuse with the locked-layer line.
18. **Questions only Tim can answer.** None. Rule used: your reading of a drawing in sheet millimetres is AutoCAD's own sheet convention, not an engineering value.
19. **NOT proven.**
    1. **Built:** by the PR author; net48 not built (PR body, per Opus).
    2. **Tested:** 4 unit cases (3 pure, 1 source guard) by the author. I ran none.
    3. **Installed:** no.
    4. **Tim-accepted:** no. BUG-1025 stays OPEN. No Codex window look is needed (no window text).

---

## CARD 3: Structural Reset Defaults asks first and keeps a copy (PR #1457, BUG-826)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter.** The "Reset Defaults" button in the Structural CE Settings window puts standard values back. Today it does so in one click with no question.
2. **Ribbon or trigger.** Command CESETTINGS (label "CE Settings"). The routing list puts it under Administration > General (GUESS for the exact ribbon panel). The button "Reset Defaults" sits at CeSettingsDialog.xaml line 18, beside Save and Cancel.
3. **Works today.** On the Structural line the button runs `SaveAndClose(new UserSettings())` (CeSettingsDialog.xaml.cs lines 475 to 478): everything is rewritten with standard values and the window closes. No question, no kept copy, migration flags reset too. A kept copy is made only after an unclean load. What Keep would protect: the button's position, Save and Cancel, and the rest of the window.
4. **What the train or PR changes.** PR #1457 (head 3feb0668, two commits; no new commit since 19 Oct). It asks a Yes/No question (default No), saves `CS_Settings.before-reset-yyyyMMdd-HHmmss.json` beside the file, refuses the reset if that copy cannot be saved, then resets. It keeps: migration flags, SBEAM favourites and recents, line styles, mark prefixes, command hub, wall schedule, six Excel lists, the bearer span table and the Python path. **No Settings switch** (a safety question has no "today's number"). Still owed from Codex review group 14 (24 Oct): reset only what the window shows.
5. **Suggested class: Modify**, CHANGE-NEEDED before it ships. Suggestion only.
6. **Prompts and windows.** A Yes/No window. Wording on the PR: "Put the settings shown in this window back to the standard values?" The copy-failed message wording was not quoted in the review (not read). Opus found the question lists what is kept but leaves out the bearer table and Python path. For Codex to look at: wording, dark and light themes, that No is the button Enter presses.
7. **Selection.** None.
8. **Preview.** None.
9. **Drawing output.** None; this is a settings window, not a drawing edit. Nothing in the drawing is touched. Locked layers, Xrefs and REFEDIT do not apply.
   1. **The fault (Opus 1 Nov):** the question says "shown in this window", but the reset covers about 40 groups, including ones the window never shows. A colleague with `CeMember.BreakOvershootPaperMm` at 2.0 presses Yes and it silently returns to 1.5. The same applies to hidden switches in Layouts, Options and Install.
   2. Second reset within the same second fails with "nothing was reset" (copy not overwritten). Harmless.
10. **Cancel, Escape, Undo and Redo.** Answer No or press Escape: nothing changes and no copy file appears. AutoCAD Undo does not apply. The way back is the kept copy (rename it back, or the CE Settings file transfer; GUESS on exactly how a drafter restores it).
11. **Save and reopen.** Yes writes the reset file and the dated copy. Reopening CESETTINGS shows the standard values. CE reads settings at AutoCAD start (see the driver note in memory), so GUESS: values the window does not show may need AutoCAD restarted to take effect.
12. **Assets, data and Settings.** Reads and writes CS_Settings.json and writes the dated copy beside it. Tests on the PR point at a temp folder. I did not read or touch the real file.
13. **Performance.** Instant.
14. **Discovery.** The button is on the window. No Help page change is recorded.
15. **Example drawing and expected result.** In a copy of the profile: star an SBEAM favourite, set the CEMEMBER break overshoot to 2.0 in the file before AutoCAD starts. Change Beam large offset in CESETTINGS, press Reset Defaults. Press No: nothing changes. Press again, Yes: the offset is back to standard, the favourite is still there, the overshoot is still 2.0 (after the fix), and a `CS_Settings.before-reset-...json` sits beside the file.
16. **Older family card.** `C:\CE_PLAN\areas\cards\CARD_CESETTINGS_FIVE_GROUPS_DRAFT_31OCT.md` (field 3 and field 7 say "Reset to default as today" and "restores office defaults per section"). That card does not cover the one-click, whole-file reset or the new question. Its "per section" statement does not match the code I read on the Structural line. `docs/CARDS/SH-04_SETTINGS_STANDARDS.md` is the family card for settings (title only read; I did not check whether it mentions Reset).
17. **Tim's AutoCAD checklist (on a copy of the profile, after the Codex fix).**
    1. Before AutoCAD starts: set `CeMember.BreakOvershootPaperMm` to 2.0 in the copy's settings and star an SBEAM favourite.
    2. Start AutoCAD. Type CESETTINGS. Change Beam large offset to a new number.
    3. Press Reset Defaults. You should see a question. Press No (or Escape). The offset is still your new number; no before-reset file appears.
    4. Press Reset Defaults again and pick Yes. The offset is standard, the SBEAM favourite is still there, the overshoot is still 2.0, and a `CS_Settings.before-reset-...json` file sits beside the settings file.
    5. Check the question's wording reads true to what happened.
18. **Questions only Tim can answer.**
    1. **If the dated copy cannot be saved, should the reset refuse or ask "Reset anyway?"** Context: today the PR refuses. I understand the reason is that a reset with no copy is the harm BUG-826 describes. Recommendation: keep the refusal. On a job: a locked folder means the reset does nothing and tells you; with "Reset anyway?" a misclick could still wipe a value with no copy.
    2. **What should Reset Defaults reset?** Context: the carpark says "a reset limited to what the window shows". The PR resets almost everything. Recommendation: the carpark rule (only shown fields, keep hidden ones). Lighter option, not recommended: change the question to say "all settings except your lists". On a job: with the carpark rule a hidden office value like a break overshoot survives; with the light option it goes back to standard.
19. **NOT proven.**
    1. **Built:** by the PR author; net48 not built (PR body, per Opus).
    2. **Tested:** 7 unit cases by the author, one a source check; no preservation test exists yet. I ran none.
    3. **Installed:** no.
    4. **Tim-accepted:** no. Codex window look owed. BUG-826 stays OPEN.

---

## CARD 4: RC windows take a typed bar count (PR #1731, BUG-1038)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter.** In the concrete section windows (RCCIRCCOL, RCRECTCOL, RCBEAM) the bar count boxes accept a typed whole number, so a 14N20 round column can be drawn. Today the boxes only let you pick from a list.
2. **Ribbon or trigger.** Commands RCCIRCCOL ("Circular Column Section"), RCRECTCOL and RCBEAM. Routing list: Section Details > Column Sections (RCCIRCCOL, RCRECTCOL) and Section Details > Beam Sections (RCBEAM). Ribbon tab "CE Structural" (GUESS for how the panels show on screen).
3. **Works today.** The window opens with sensible starting values (round column: 8 total bars; beam: 3 bottom and 2 top bars; rectangular: 2 bars per face). The drawing loop already draws any count it is given (ColumnDetailCommands.cs, loops to `spec.BarCount`). The picks are lists: round "Total bars" 4, 6, 8, 10, 12, 16, 20 (so 14 and 18 cannot be entered); rectangular "Bars per face (with corners)" 2 to 6; beam bottom 1 to 12 and top 1 to 8 (RCMemberDialog.xaml.cs lines 140 to 155 on the Structural line).
4. **What the train or PR changes.** PR #1731 (head 2878e6c2, two commits). New rule `BarCountEntryRule`: whole number from the smallest allowed count to 999. Switch `Options.BarCountsTypedFreely`, **default ON**; OFF restores pick-only boxes exactly. The 24 Oct review fix is in: Bars per face must be 2 or more (1 had drawn 2 bars labelled "0N20"). Beam and round-column boxes stay 1 or more.
5. **Suggested class: Modify** (the window gets typable boxes). Opus: KEEP-WITH-NOTE. GUESS: not Rebuild, because the drawing code is unchanged.
6. **Prompts and windows.** Labels in the window: "Bottom bars:", "Bars per face (with corners):", "Total bars:". Registry prompts for RCCIRCCOL: "Diameter (mm)", "Bar count", "Bar size", "Tie size", "Cover (mm)", "Centre point". Error: a message box "[CE] ... must be a whole number of 1 or more (up to 999)." (wording abbreviated in the review); the window stays open. For bars per face it adds "Each face has its two corner bars."
7. **Selection.** A point pick for the section centre after the window closes; no object selection.
8. **Preview.** The window preview follows the typed number.
9. **Drawing output.** Concrete outline on SUPPORT COLUMN, rebar on 35CONT, labels on 25TEXT, dimensions on 25DIMS (registry layerBehavior). 14 typed gives 14 bar circles and the label 14N20. Nothing else touched. Window and drawing happen inside the command's own transaction; no new write path. Locked layers, Xrefs and REFEDIT: not changed by this PR (I did not read the protection checks in the RC commands; GUESS they behave as today).
   1. Not done (the PR says so): the suggestion lists are still fixed in code, not office-editable; columns have no warning for unusual arrangements.
10. **Cancel, Escape, Undo and Redo.** Cancel or Escape in the window or at the point pick leaves the drawing alone ("OnCancelled" in the command). One U removes the whole section.
11. **Save and reopen.** Plain drawing objects; reopens as saved. The window picture files under docs/image were not regenerated, so a picture test may go red on assembly.
12. **Assets, data and Settings.** Reads `Options.BarCountsTypedFreely` through one reader that gives ON if unreadable. Neither an older settings file nor OFF is tested end to end (reading shows an older file reads ON). 999 is a loop limit; 2 per face is geometry.
13. **Performance.** More bars means more circles; 999 is the ceiling. Nothing noticeable at 14 or 18.
14. **Discovery.** Same commands. No Help change recorded.
15. **Example drawing and expected result.** Millimetre drawing, DIMSCALE 20. RCCIRCCOL, diameter 600, N20 bars, N10 ties, cover 40. Type 14 in Total bars, place at 0,0: label 14N20 and exactly 14 bar circles. Repeat with 18. RCRECTCOL 800 x 800, N20, type 7 per face: 24 bars, label 24N20. Type 1 per face and press OK: the corner-bars message and the window stays open. RCBEAM: type 14 in the bottom bar count: 14 is kept; a "bars do not fit" warning may show and does not block.
16. **Older family card.** `C:\Lisp Files\CE_ACAD_PLUGIN\docs\CARDS\ST-08_SECTIONS_DETAILS.md` is the nearest family card (section details). I read only its title; GUESS it does not mention typed bar counts. The carpark item itself is BUG-1038.
17. **Tim's AutoCAD checklist (needs a Codex window look first, or your own).**
    1. Millimetre drawing, type DIMSCALE, 20. Type RCCIRCCOL.
    2. Diameter 600, bars N20, ties N10, cover 40. Click into the Total bars box and type 14. Press OK, pick 0,0. You should see 14 bar circles and the label 14N20.
    3. Repeat with 18.
    4. Type RCRECTCOL, 800 x 800, N20. Type 7 in Bars per face, OK, place. You should see 24 bars and 24N20. Try 1 and OK: a message about two corner bars; the window stays open.
    5. Type RCBEAM and type 14 in the bottom bar count. 14 stays; a warning is allowed, no block.
    6. Clear a count box and press OK: a message, window stays open, nothing drawn.
    7. After a placement, type U. The whole section goes.
18. **Questions only Tim can answer.**
    1. **Should the bar count lists (4, 6, 8 ... 20 and the others) become office-editable in Settings, and should an unusual arrangement warn?** Context: the carpark asks for both; the PR does the typing only. I understand any whole number is allowed and a warning never blocks (R-27). Recommendation: yes to both, as a follow-up and not in this PR. On a job: the office can then put 14 and 18 on the pick list; with no follow-up a drafter just types them.
19. **NOT proven.**
    1. **Built:** by the PR author. net48 compiled with 0 errors on the first head (per Opus); the net48 test lane was not run; the second head was not re-built that way as far as I read.
    2. **Tested:** 23 unit cases by the author (4 drive the real window code). The author's main Structural run ended with 4,616 passed and 0 failed and then the test host hung on an unidentified test (not a clean finish). I ran none.
    3. **Installed:** no.
    4. **Tim-accepted:** no. Nobody has looked at the editable boxes in AutoCAD or Codex. BUG-1038 stays OPEN.

---

## CARD 5: BP warns when the Settings pier diameter is not on the pier block (PR #1986, BUG-536) and the C2/SC2 column picker "Press 1 to 9" (PR #1261, BUG-576)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter.**
   1. **BP (Bored Pier):** inserts the bored pier block; now says so on the command line when your Settings diameter is not one of the three sizes the block holds.
   2. **C2 and SC2:** C2 inserts a support column marker and SC2 changes the type; both open the "Select Column Type" picker, which now tells you to press 1 to 9.
2. **Ribbon or trigger.**
   1. BP: label "Bored Pier", group Foundations, subgroup Piers (registry); routing list Foundations > Piers.
   2. C2: label "Column Type Picker", SC2: label "Change Column Type", both Structural > Supports (registry and routing list). The toolbar file also lists them under a "Structural" section. Tab "CE Structural" (GUESS for how the panels show on screen).
3. **Works today.**
   1. **BP:** the question is "Select pier diameter [300/450/600] <450>: ". Enter takes the Settings diameter when it is 300, 450 or 600, otherwise 450 (`BoredPierDiameterChoice.DefaultFor`, offered sizes 300, 450, 600). Block `450DIABPV2` is one block with three visibility states ("300 DIA.", "450 DIA.", "600 DIA."). At 450 it also asks "With concrete hatch? [Yes/No] <No>: ". The registry says layer BORED PIER, colour 2, HIDDEN; Settings `BoredPierPlan.BpLayerName` can change the layer, with a message if the name is invalid. It loops for several points and offers optional registration in a foundation system.
   2. **C2/SC2 picker:** nine choices; key 9 selects 250x90 PFC and Enter accepts it (carpark, from AutoCAD 14 Oct). Installed Structural 1.0.121 already says "Choose column type / Press 1-9, then Enter to continue." (ColumnVisibilityPickerDialog.cs line 62 on the Structural line: `Press 1–{Math.Min(options.Count, 9)}`). It used to say "Press 1-8".
4. **What the train or PR changes.**
   1. **#1986 (BUG-536, BP part; build register B-153 = q10; head f2bd8aeb, one commit on the Structural line):** before the diameter question, if `BoredPierPlan.DefaultDiameterMm` is not 300, 450 or 600, BP prints one line. Example in the review: "[BP] The pier diameter in Settings ... is 500 mm, and the pier block only has 300, 450 and 600. 450 is offered instead..." (abbreviated; exact wording not seen in full). The answer offered and the drawing are unchanged. New switch `FootingWidth.BoredPierBlockFollowsDiameter`, default ON; OFF is silent as before. (The name says "follows diameter" but it controls only the warning; Opus noted this.)
   2. **#1261 (BUG-576):** wording only, and **already on the Structural line**, so there is nothing to merge. The PR is open by mistake and should be closed.
5. **Suggested class: Keep for both** (Opus: KEEP). GUESS: BP is a small Modify (one new message); the picker is Keep with an owed visual check.
6. **Prompts and windows.** BP as in field 3. The picker window: "Choose column type" then "Press 1–9, then Enter to continue." (with the count capped at nine). C2 registry prompts: "Insertion point", "Text value/orientation".
7. **Selection.** BP: insertion points. C2: a point. SC2: an owned support block.
8. **Preview.** No new preview. The ST-06 family card lists the bored pier preview as a future item ("At cut: green/solid or Below: yellow/hidden").
9. **Drawing output.** BP places block 450DIABPV2 on layer BORED PIER with the chosen visibility state. The new warning draws nothing and blocks nothing. BP runs inside its existing foundation edit scope. For C2/SC2 nothing changes in what is drawn. Locked layers, Xrefs and REFEDIT: the PRs add no new write path; I did not read BP's protection checks (GUESS: unchanged).
10. **Cancel, Escape, Undo and Redo.** BP: Cancel at the diameter or hatch question returns with nothing drawn. One U removes a pier. Picker: Cancel or Escape must leave the support unchanged (to be proven in AutoCAD).
11. **Save and reopen.** The pier is a block reference; the visibility state saves with it. The picker is not saved.
12. **Assets, data and Settings.** BP reads `BoredPierPlan.DefaultDiameterMm` (450 on today's code), `BoredPierPlan.BpLayerName` and the new switch. Block 450DIABPV2 is in the Structural assets. Picker: no Settings.
13. **Performance.** No change.
14. **Discovery.** Ribbon and command line as above. The new BP line shows only when the Settings diameter is off the block.
15. **Example drawing and expected result.**
    1. Set `BoredPierPlan.DefaultDiameterMm` to 500 in a copy of the settings before AutoCAD starts. Type BP. You should see one line saying 500 is not on the block and 450 is offered, then "Select pier diameter [300/450/600] <450>: ". Enter draws a 450 pier.
    2. Set it to 600 (control): no extra line, prompt shows <600>, the block's visibility reads "600 DIA.".
    3. C2 then SC2 on an owned support: nine choices, "Press 1–9". Press 9, Enter: 250x90 PFC chosen.
16. **Older family card.** `C:\Lisp Files\CE_ACAD_PLUGIN\docs\CARDS\ST-06_FOUNDATIONS_REBAR.md` (ST6-11: consolidate BP, SPW, SPW3, SPW6, SPWC onto one engine, preview At cut or Below). It no longer says: BP offers only 300, 450 and 600, the Settings diameter can silently fall back to 450, the hatched version is offered for 450 only, and the new warning. For C2/SC2 use `docs/CARDS/ST-02_SUPPORTS_BRACING_JOISTS.md` (carpark says "ST-02/ST2-2 reviewed"); I did not read it in full.
    1. **Mismatch in paperwork:** the carpark BUG-536 evidence note (31 Oct) says BP "still always uses the 450 block". #1986's builder found this is not a fault, because the one block switches state from the diameter. The real fault was the silent fallback. The carpark should be corrected when #1986 is accepted.
17. **Tim's AutoCAD checklist.**
    1. Before AutoCAD starts: set `BoredPierPlan.DefaultDiameterMm` to 500 in a copy of the settings (use the robot copy, not your real file). Start AutoCAD. Type BP.
    2. You should see one line that 500 is not on the block, then the diameter question with <450>. Press Enter, pick a point: a 450 pier appears. Type U: it goes.
    3. Set the value to 600, restart, type BP: no extra line, <600> offered, Enter draws a 600 pier.
    4. Turn the switch off (`FootingWidth.BoredPierBlockFollowsDiameter` false): with 500 there is no extra line, as before.
    5. Type C2. You should see nine choices and "Press 1–9, then Enter to continue". Press 9 then Enter: 250x90 PFC. Press Escape in a second try: the support is unchanged.
    6. Type SC2, pick an owned support, repeat step 5. Look in both dark and light appearance.
18. **Questions only Tim can answer.**
    1. **Does the office need a 500 (or other) pier on the block?** Context: BP draws 300, 450 or 600 only; a Settings value of 500 now warns and offers 450. The office-block sizes are parked ("8talk later", decision 168). I understand a new size means a new visibility state in the office block, which needs the office block. Recommendation: leave the warning as the answer for now and decide with the office block questions. On a job: a 500 mm pier still draws as 450 on the plan until the block has a 500 state, but you are told.
    2. **Should the block's Enter default follow Settings more tightly (for example refuse an off-block value instead of falling back)?** Recommendation: no; warn and carry on (R-27). On a job: the pier always gets drawn.
19. **NOT proven.**
    1. **Built:** #1986 by the PR author, net48 compile 0 errors per Opus. #1261 built as part of 1.0.121 per the carpark.
    2. **Tested:** #1986: 28 of 28 focused unit tests by the author, not run red on old code. #1261: no tests (a caption). I ran none.
    3. **Installed:** #1261 wording is in installed Structural 1.0.121 per the carpark (I did not read the installed DLL). #1986 is not installed.
    4. **Tim-accepted:** neither. Nobody has seen the BP warning line or the nine-choice picker in AutoCAD. BUG-536 and BUG-576 stay OPEN until the robot or Codex checks above pass.

---

Sources read: `C:\CE_PLAN\areas\OPUS_PREREVIEW_BACKLOG_R2_01NOV.md`, `OPUS_PREREVIEW_BACKLOG_R7_01NOV.md`, `OPUS_PREREVIEW_1984_1988_GROUP_01NOV.md`, `release-v3-colleagues-BUILD_REGISTER.md` (B-153 line only), `BUG_CARPARK.md` (BUG-951, 1025, 826, 1038, 536, 576), `decisions\2026-10-20_TIM_ANSWERS.md` (item 12, the scale ruling), the three ST family cards, `cards\CARD_CESETTINGS_FIVE_GROUPS_DRAFT_31OCT.md`, and code on origin/claude/rel-20261026s at 204dfad2 (command registry, routing list, toolbar file, CeTextService.cs, FoundationService.cs, ReoBarService.cs, CeSettingsDialog, ColumnVisibilityPickerDialog, RCMemberDialog, UserSettings.cs). Latest Civil/Manager line origin/claude/rel-20261102a (3fbb9da5) was fetched but not used; these commands are Structural.
