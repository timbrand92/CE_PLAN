# Card drafts 1 of 15: X-Civil import, LandXML import and Survey Intake (Mon 2 Nov 2026, Melbourne)

Written by Sonnet (Team, read-only) for CE 05 at CE 00's request. DRAFT FOR TIM: nothing in this file is approved. Nothing was run, built, tested or opened in AutoCAD to write it. Every "DERIVED" or "GUESS" mark means it was read from text or code, not seen.

## FOR TIM

1. **Four cards drafted:** CDIMPORTXCIVIL results and cancel (card 1), CDIMPORTXCIVIL reading the consultant table (card 2), Survey Intake doubtful spot levels (card 3), LandXML import (card 4). All are suggestions. Nothing is approved and no class (Keep / Modify and so on) is decided.
2. **The line the brief named is not the line that holds the fixes.** `rel-20261102a` is C-78 (Civil 3.0.88) and holds none of PR #1941, #1942 or #1926. #1926 (CHECK THE SCALE on the page) is in C-79a, which is installed on your PC as 3.0.89. #1941 and #1942 are only in the C-79c branch `rel-20261112a`, which is NOT installed. #1987, #1982, #988 and #1809 are open PRs that are on no train yet. I read code on `rel-20261112a` and say so on each card.
3. **Commands pinned down:** all four. The X-Civil and LandXML imports are CDIMPORTXCIVIL and CDIMPORTLANDXML (ribbon CE > Import > Import arrow). Survey Intake is CDSURVEY on the command line, then the "Survey Intake" page in CE Manager (command CESURVEYREVIEW, ribbon button "Survey Review"). Nothing was left unfound.
4. **#1982 (level range) is NOT approved.** Opus said CHANGE-NEEDED and the card says plainly it is on hold for your word. It would change every import at the shipped settings, not "nothing changes".
5. **Questions only you can answer** (batched at the bottom of each card): the level range for imports (card 2), whether a set UNITS should beat CE's size guess (card 2), the wording of the cancelled line (card 1), whether an unknown pipe size should stay Unknown instead of drawing a 375 mm placeholder (card 4).
6. **BUG-512 and BUG-513 (LandXML):** the fix PR #1229 should not be merged because the same fix has been on the line since 9 Oct under the name HUNT2-C-08/09 (commit ae64971a). The carpark still reads OPEN for both and does not mention it. BUG-512 still has a gap: placeholders of 375 mm and 600 x 600 are still drawn.
7. **What was read:** the Opus pre-reviews, the build register, the three train lists, the carpark entries, the older cards, and the code and settings on `rel-20261102a` and `rel-20261112a` (read-only git).
8. **NOT proven anywhere:** none of these changes has been seen in AutoCAD. Built and unit-tested for most; installed for #1926 only (C-79a 3.0.89); accepted by you or Codex for none. The robot cannot drive the file picker these commands start with, so every card needs a Codex look or your hands.

---

## CARD 1: CDIMPORTXCIVIL results page and cancelled sentence

DRAFT FOR TIM: nothing is approved.

1. **Name, and what it does for a drafter.** CDIMPORTXCIVIL (X-Civil import). It reads a consultant's drawing or package and redraws the pits and pipes as CE pits and pipes. This card covers the two pages the drafter reads at the end: the schedule page and the results page.
2. **Ribbon or trigger.** Tab "CE" (the classic layout calls it "CE Civil"), panel "Import", the big split button "Import". Its face opens Survey. The arrow lists Survey, Consultant DWG, X-Civil, LandXML and Compare. Pick "X-Civil" (`CeCvlRibbonContributor.cs` line 158). Or type `CDIMPORTXCIVIL`. The command registry calls it "Import X-Civil", group "Import / Export".
3. **Works today.** Choose a drawing or package, read the source, review the "Pit and pipe schedule" page, press "Import to drawing", then a results page lists every pit and pipe. A previous import is found and the drafter is asked "Replace (delete + reimport) or Abort? [Replace/Abort] <Replace>". Keep would protect all of that. Nothing in the old family card says what "Recorded" means for a pit that was skipped.
4. **What the train or PR changes.**
   1. **#1941 (B-122, BUG-898), head 9ec6f131.** The results page is built from what was really drawn. A pit or pipe left out reads "Check" with "Not drawn - <reason>". A locked layer reads: `Not drawn - layer "STORMWATER PIT" is locked, so CE did not draw it`. The default reason is "CE could not place it - see the report for the reason". Status lines: "Import finished, but N of M pits and pipes were NOT drawn. The rows marked Check say why; the report has the detail." and "Nothing was drawn: no pit or pipe was placed in your drawing. See the report for why (a locked layer, a pit number already in the drawing, or a problem placing the items)." A fully drawn import keeps the old words. Switch `xcivilImport.importResultsFromWhatWasDrawn`, default ON. OFF gives the old rows (every row "Recorded"). It also works for CDIMPORTLANDXML.
   2. **#1942 (B-122, BUG-1256), head 6733f165, stacked on #1941.** Pressing Close on the schedule page now prints "CDIMPORTXCIVIL cancelled. Nothing was drawn." Switch `xcivilImport.cancelLineIsPlainEnglish`, default ON. OFF prints the old "Import aborted at pre-flight gate — no entities were inserted."
   3. **#988 (BUG-559), head 607a636c.** Each pipe row on the schedule and results pages gets its length, for example "P8 to Unknown, 100 mm UPVC pipe from the schedule, 1.7 m long", and a second row "Note: pipe P8 to Unknown" explains that CE left the far end open. No switch (words only). Opus said KEEP-WITH-NOTE and it needs a hand-merge because the window wording has moved on. It is on no train yet.
   4. **Where they are today.** #1941 and #1942 are merged on `rel-20261112a` (C-79c, assembled 1 Nov) and are NOT installed. The line `rel-20261102a` (C-78) has neither. #988 is on neither.
5. **Suggested class: Modify.** Words and a list change; the drawing result and the locked-layer rule do not. Suggestion only.
6. **Prompts and windows.** First page: Choose DWG, close = "CDIMPORTXCIVIL cancelled. Nothing was drawn." (`LinkCommands.ImportXcivil.cs` line 71). Schedule page banner "Schedule read. Review the pit and pipe rows." or "Check the schedule before accepting the import." Buttons: Import to drawing, Close. Replace prompt as in field 3. Results page lists rows with state "Recorded" or "Check". Status line as in field 4.
7. **Selection.** None in the drawing. The source is chosen in the window. GUESS: no object picking.
8. **Preview.** The schedule page is the preview (rows of pits and pipes before anything is drawn). No on-drawing preview was read.
9. **Drawing output.** Pits and pipes are drawn as CE pits and pipes. Nothing new is drawn by #1941, #1942 or #988; they only report. Protection (read from the code): the import first refuses when a block is being edited in place (`RefuseWhenReferenceEditing`). A pit or pipe that needs a locked layer is not drawn at all, never half drawn, and nothing is unlocked (`XcivilImportLockedLayers.LeaveOut`). An earlier imported item on a locked layer is left exactly as it is. Xrefs: GUESS, the consultant file is read from disk, not attached; this was not checked in the code.
10. **Cancel, Escape, Undo and Redo.** Close on page 1 or page 2 draws nothing. After #1942 both say the same plain sentence and no results window opens. Undo and Redo: the import is the existing path and none of these PRs adds a write. The carpark records an earlier Codex run (3.0.41) where U, wait 12 s, REDO on an import passed; it has not been repeated on these PRs. Opus asked the robot to check U then REDO for #988.
11. **Save and reopen.** Not changed by these PRs. The import records are stored with the drawing as before. NOT proven for these PRs.
12. **Assets, data and Settings.** Reads the consultant DWG or package. Writes an import report and debug log (the command prints "CDIMPORTXCIVIL wrote report: ..."). Two Settings switches, both in the settings file, no tick box found: `xcivilImport.importResultsFromWhatWasDrawn` and `xcivilImport.cancelLineIsPlainEnglish`. A settings file saved earlier keeps its old value until the key is written; both default ON for new files and files without the key. Settings are read at AutoCAD start, so change them before launching.
13. **Performance.** No change expected: the importer notes each item as it draws it. Not measured.
14. **Discovery.** Ribbon as in field 2. Command line. Help list (`CdHelpService.cs` line 47 includes CDIMPORTXCIVIL). "What's New" says "Choose a drawing or package folder, then review the pit and pipe schedule before importing." It does not mention the results page or the Not-drawn rows. GUESS: no Help page text for them.
15. **Example drawing and expected result.** A made-up package with 3 pits and 2 pipes. Lock layer STORMWATER PIT with the LAYER command. Run CDIMPORTXCIVIL and accept. Right (DERIVED): "Import finished, but 3 of 5 pits and pipes were NOT drawn", pit rows Check with the locked layer named, pipe rows Check with "one of its pits is missing" style reasons if the pits are missing. GUESS: the pipes' reason words were not read. Unlock and import again into a fresh copy: all rows "Recorded", "Import complete. Check the listed drawing items."
16. **Older family card.** `docs\CARDS\CV-07_SURVEY_IMPORT.md` (approved 22 July). It no longer says: X-Civil and LandXML are now on the ribbon (it says hidden); the results page is built from what was drawn; the cancel sentence; the results rows for a locked layer. `docs\workflows\C5_C1_READ_ONLY_IMPORT_COMPARISON_2026-09-10.md` is only about CDIMPORTCOMPARE, and `C5_IMPORT_DECISION_EXAMPLES_2026-09-13.md` is about LandXML units and per-pipe inverts, so neither covers this page.
17. **Tim's AutoCAD checklist.** (On a copy; C-79c must be installed first. Today nothing here is installed.)
    1. Open a copy of a Civil drawing. Type LAYER and lock STORMWATER PIT.
    2. Type `CDIMPORTXCIVIL`. Choose DWG, pick the made-up package, press Read source.
    3. On the "Pit and pipe schedule" page press Import to drawing.
    4. Look at the results page. You should see "Import finished, but N of M pits and pipes were NOT drawn" and each pit row marked Check saying the layer is locked.
    5. Look at the drawing: no pit blocks on that layer. Type U. Everything the import did goes back in one step.
    6. Unlock the layer, repeat on a fresh copy: every row says Recorded.
    7. Run CDIMPORTXCIVIL again, read the source, and press Close on the schedule page. The command line must end "CDIMPORTXCIVIL cancelled. Nothing was drawn." and no results window opens.
    8. Pipe length (only if #988 is merged later): find "P8 to Unknown"; it should end "m long" and be followed by a "Note: pipe P8 to Unknown" row.
18. **Questions only Tim can answer.**
    1. **Cancelled wording (BUG-1256).** Context: the line used to say "pre-flight gate". Understood: the builder chose the plain sentence; you have not ruled. Recommendation: keep "CDIMPORTXCIVIL cancelled. Nothing was drawn." because it matches page 1 and has no jargon. Yes means one sentence everywhere. No means tell us the words you want, or the card is changed to the old line.
    2. **Locked layers: skip or warn.** Context: today a pit on a locked layer is skipped and now reported. Understood: your rule is that CE never unlocks a layer. Recommendation: keep skip-and-report. A different answer would be a reviewed workflow with its own preview.
    3. **Pipe length wording (#988).** Context: the window gets "1.7 m long" and a Note row. Recommendation: accept it as words only. It assumes the drawing is in millimetres.
19. **NOT proven.**
    1. **Built:** yes for #1941 and #1942 on `rel-20261112a` (Civil net10 22,703 tests, 0 failed, per the C-79c assembly report). #988: built on its own branch only, not on a train.
    2. **Tested:** unit tests only, including the exact status sentences. No robot case can reach it (file picker). No Codex look has been done.
    3. **Installed:** no. C-79c is not installed. Installed is C-79a 3.0.89 and it has neither PR.
    4. **Tim-accepted:** no. Nobody has seen the page in AutoCAD, including Codex.

---

## CARD 2: CDIMPORTXCIVIL reading the consultant table

DRAFT FOR TIM: nothing is approved.

1. **Name, and what it does for a drafter.** CDIMPORTXCIVIL, the part that reads the consultant's pit and pipe schedule (the drawn table, or a picture of it). It decides each pit's depth, size and level, which pipe gets which size, and whether the drawing's scale looks right.
2. **Ribbon or trigger.** Same as card 1: CE > Import > Import arrow > X-Civil, or type `CDIMPORTXCIVIL`.
3. **Works today.** The scale guess, with a warning when the drawing's own UNITS disagree: "CHECK THE SCALE ..." (BUG-505, installed). When the source has no units set, CE reads it as millimetres and prints "This drawing has no units set; CE read it as millimetres." (switch `xcivilImport.noUnitsNote`, on the line). Levels above 0 and up to 250 m are kept; others are dropped without a word.
4. **What the train or PR changes.**
   1. **#1926 (B-112, BUG-505), head f0b98291.** The CHECK THE SCALE or no-units sentence now leads the "Pit and pipe schedule" banner, and the page asks for attention. The page says "Check the schedule before accepting the import." under it. Switch `xcivilImport.scaleNoteOnReviewPage`, default ON. OFF gives "Schedule read. Review the pit and pipe rows." Wording only; it never blocks (your decision 10 of 29 Oct: a soft note). It is in C-79a (installed 3.0.89) and in C-79c. Opus: KEEP.
    2. **#1987 (B-158, BUG-805), head 5770235a.** (a) "0.9 m" or "1.2 metres" reads as 900 or 1,200 mm, not 0.9 mm. (b) The pit depth comes from the cell under a "DEPTH" header; without one, the single "number m" in the row that does not follow CL, RL, IL, TL, FL, SL or LEVEL. So "CL 8.45m 1.20m" gives a 1,200 mm depth, not 8,450. Two or more candidates leave depth Unknown and add a WARNING line. (c) A pipe row with one end blank goes to no pipe, with a WARNING line. Switch `xcivilImport.scheduleReadsMetresAndDepthColumn`, default ON; OFF restores the old reading. Depth limits (more than 0.3 m, less than 15 m) are copied from the old code, not in Settings. Opus: KEEP-WITH-NOTE. Not on any train.
    3. **#1982 (B-150, BUG-908), head b6dd9dbb. NOT approved. Opus said CHANGE-NEEDED: hold for Tim's word.** It switches `xcivilImport.levelRangeFollowsSettings` from OFF to ON, so an import keeps levels from -50 m to 1000 m (the markup range) instead of above 0 and up to 250 m. That changes every X-Civil and LandXML import at the shipped settings. Examples: a pit at RL 300 would come in; a "0.00" written as "no level" would come in as a real level of 0; in a schedule row holding a real cover 45.20 plus another figure 0.00 or 300.00, the cover could be left blank. Anyone whose settings file was saved since the switch was added already holds OFF, so only new installs would change. Opus recommends an import-only range in Settings starting at today's above 0 to 250 m. Not on any train. Not part of any card decision.
    4. **#892 (HUNT2-C-01), two commits.** Opus: CHANGE-NEEDED, do not merge. Keep only one small piece: a warning line on the import page when the JOB drawing you import INTO is not in millimetres (for example a metres drawing puts pits 1,000 times off). That line is not built yet. The unit question (a set UNITS beats CE's size guess) is your open question, voice batch 4 question 1, and is not built.
5. **Suggested class: Modify.** The reading rules change, and a metre-and-depth-column reader is new behaviour that needs your word on real tables. Suggestion only.
6. **Prompts and windows.** Schedule page banner as in field 4.1. The warning lines for ambiguous depth and half-blank pipe rows go into the schedule pre-flight list (`LastRowPairingLines`, read at `XcivilImportService.cs` 848 and 1461). Whether those lines appear on the results page end to end is not tested (Opus note 2).
7. **Selection.** None in the drawing.
8. **Preview.** The schedule page. The banner is the preview of the scale warning.
9. **Drawing output.** Only what the import already draws. These PRs change which numbers are read, not what is drawn or where. No layer is unlocked and no Xref or REFEDIT object is touched; the locked-layer rule from card 1 is unchanged.
10. **Cancel, Escape, Undo and Redo.** Close on the schedule page imports nothing. The numbers read are not written anywhere until Import to drawing; after that Undo and Redo are the existing path.
11. **Save and reopen.** Not changed. NOT proven.
12. **Assets, data and Settings.** Switches `xcivilImport.noUnitsNote` (ON, on the line), `xcivilImport.scaleNoteOnReviewPage` (ON, C-79a), `xcivilImport.scheduleReadsMetresAndDepthColumn` (ON, PR only), `xcivilImport.levelRangeFollowsSettings` (OFF on every line, PR flips it). Level range today from `markup.levelMinM` and `markup.levelMaxM` (-50 and 1000 m) only when that switch is ON. The AI-vision reader needs the AI key and a picture; keys stay in `C:\Users\TimothyBrand\Keys\keys.txt` and are never written into files.
13. **Performance.** No change expected. Not measured.
14. **Discovery.** Same as card 1. The scale banner is visible only inside the window.
15. **Example drawing and expected result.**
    1. **Metres and depth (#1987).** Drawn table on GN-ANNO-TABL with the row "SEP1 CL 8.45m 1.20m". Today the depth is 8,450 mm. With #1987 ON the depth is 1,200 mm. A row with two unlabelled metre figures shows depth Unknown and a WARNING line.
    2. **Half-blank pipe row (#1987).** A pipe schedule row with the From end blank: gives no pipe a size and a WARNING line.
    3. **Scale (#1926).** A source with units not set: banner begins "This drawing has no units set; CE read it as millimetres." A source set to millimetres with 200 mm stubs: "CHECK THE SCALE ...".
    4. **Range (#1982, NOT approved).** A pit cover of RL 300.00: dropped today, kept if #1982 is merged.
16. **Older family card.** `docs\CARDS\CV-07_SURVEY_IMPORT.md`, approved 22 July. It no longer says: units and scale checks (CV7-7 only talks about alignment); metres in the schedule; the depth column; half-blank pipe rows; the level range. It says X-Civil was hidden; it is now on the ribbon.
17. **Tim's AutoCAD checklist.** (Needs the PRs installed; today #1926 only.)
    1. **Scale note (#1926, installed in C-79a).** Open a Civil copy. Type `CDIMPORTXCIVIL`. Choose DWG: a source copy with units not set. Read source. The banner must begin "This drawing has no units set; CE read it as millimetres." Press Close. Nothing is imported.
    2. Repeat with a source set to millimetres that holds a 200 mm stub on a pipe layer. The banner must begin "CHECK THE SCALE".
    3. **Metres (#1987, once built into a train).** Use a made-up drawing with a table on GN-ANNO-TABL: row "SEP1 CL 8.45m 1.20m". Import. Pit SEP1 depth must read 1,200 mm.
    4. Add a second row with a DEPTH column and a blank depth cell and one other "number m" in the row. Note what depth the page shows. Opus says it would take the other figure; your answer decides whether that is wrong.
    5. A pipe row with the From end blank: it gives no pipe a size; the results page should carry the WARNING line.
    6. **Range (#1982):** do not test until you rule on question 1 below.
18. **Questions only Tim can answer.**
    1. **Import level range (#1982, BUG-908).** Context: today an import keeps levels above 0 up to 250 m. Understood: the PR would make it -50 to 1000 m for every import, against the brief's "nothing changes". Recommendation: give the import its own range in Settings, starting at today's above 0 to 250 m, so nothing changes until someone raises it. Example: a hill site at RL 300 would need you to raise the import maximum once. Saying "yes -50 to 1000 m" means a 0.00 placeholder level now comes in as a real level of 0. **This is not approved.**
    2. **A set UNITS beats the size guess? (voice batch 4 question 1, item 95.1).** Context: CE now warns when the two disagree. Understood: you have not answered. Recommendation: say yes only after you have seen the page banner on a real consultant file. Yes means a FULL train. No means CE keeps guessing from sizes and only warns.
    3. **Job drawing not in millimetres.** Context: a metres job drawing puts pits 1,000 times off. Recommendation: a warning line on the page, not a stop, as Opus suggests.
    4. **Blank depth cell under a DEPTH column.** Recommendation: leave that row Unknown (safer). Today the PR falls back to any other "number m" in the row.
    5. **Real consultant tables:** does a real table carry a header called DEPTH? Only you or a real file can tell.
19. **NOT proven.**
    1. **Built:** #1926 yes (in C-79a and C-79c). #1987 built and 667 related tests passed on its own branch; net48 0 errors. #1982 built; 626 focused and 301 Settings tests on its branch. None of #1987, #1982 is on a train.
    2. **Tested:** unit tests only. #1987's tests pass the switch directly and read no file. No test shows the half-blank WARNING reaching the results page. No real consultant schedule has been tried. N91 start-up smoke for #1982 not run.
    3. **Installed:** #1926 yes (C-79a Civil 3.0.89, installed 2 Nov 10:56 to 10:58). #1987 and #1982 no.
    4. **Tim-accepted:** none. BUG-505 stays OPEN: the carpark says Codex V3b-04 failed and V8-01 differed on earlier builds, and no one has seen the banner (robot run 39 was blocked at the file dialog).

---

## CARD 3: Survey Intake, doubtful spot levels

DRAFT FOR TIM: nothing is approved.

1. **Name, and what it does for a drafter.** CDSURVEY (command line), then the "Survey Intake" page in CE Manager. You click a survey Xref; CE reads its spot levels, flags doubtful ones as "suspect", and shows them on the Survey Intake page before you Approve. A suspect point stays Unknown and cannot become ground.
2. **Ribbon or trigger.** Tab "CE", panel "Import", split button "Import": the face and the first arrow item are "Survey" (CDSURVEY, "Import Survey" in the classic layout). The page is opened by the Manager command `CESURVEYREVIEW`, ribbon button "Survey Review" in the CE Manager "Product" panel, whose description reads "Review the pending survey intake in CE Manager before approval." The command line tells you: "[CE] Review this survey in CE Manager > Survey Intake, then Approve or Cancel there. Nothing is stored until you approve."
3. **Works today.** CDSURVEY prompts "Click on the survey XREF:", reads spot levels (and TIN triangles if present), and prints "[CE] Survey intake review (nothing stored yet):". A blocked intake prints "[CE] Intake blocked - suspect or conflicting evidence stays Unknown and cannot be activated." Approve stores the survey with the drawing. Cancel prints "[CE] Survey intake cancelled - nothing stored."
4. **What the train or PR changes.** **#1809 (BUG-1191), head 1b0190e1, on base rel-20261025r.** Today only ten finding lines are listed, then "... and 1 more" (command line line 177 on `rel-20261112a`, and `Take(10)` on the page). Eleven doubtful spot levels means the eleventh cannot be identified before Approve. With #1809 the Survey Intake page lists every finding in its scrolling list. The command line stays capped at ten with ": all of them are listed on the Survey Intake review page" when the page opens. When the page will not open (no Manager, or a blocked intake) the command line lists every finding. New switch `survey.surveyIntakeListsEveryFinding`, default ON, with a tick box in Settings > Survey "Survey Intake lists every suspect point". OFF gives the old ten-and-"and N more" text, except each command-line line now starts "[CE] " instead of a blank indent. Opus: KEEP-WITH-NOTE. It must be rebased; it is on no train. It is not in `rel-20261102a` nor `rel-20261112a` (the switch is absent from both).
5. **Suggested class: Modify.** The approve gate is unchanged; only the list length changes. Suggestion only.
6. **Prompts and windows.** Prompts as in field 3. The page is CE Manager > Survey Intake. After the review the command asks "Approve this survey intake and store it with the drawing?" (keyword answer, BUG-144). The Settings page is Settings > Survey.
7. **Selection.** One Xref click: "Click on the survey XREF:". A wrong pick prints "[CE] Please click directly on the survey XREF block."
8. **Preview.** The command-line review and the Survey Intake page are the preview. "Nothing stored yet" until Approve.
9. **Drawing output.** Nothing is drawn at review. After Approve the survey (spot levels, TIN) is stored with the drawing and the nearest ground RL is suggested when a pit is placed. The survey Xref is read only; it is not edited, unlocked, detached or bound. #1809 changes only the review lines.
10. **Cancel, Escape, Undo and Redo.** Esc or no pick: "[CE] CDSURVEY cancelled - nothing stored." Cancel on the page or at the Approve prompt: nothing stored. #1809 adds no write, so Undo and Redo are unchanged.
11. **Save and reopen.** The CV-07 card records that CDSURVEY project storage survives reopening. #1809 does not change that. Not re-proven.
12. **Assets, data and Settings.** Reads the survey Xref and optionally a raw 3D survey DWG. Writes the survey to the project data on Approve. Switch `survey.surveyIntakeListsEveryFinding` (ON). Settings are read at AutoCAD start, so change the tick box, then restart.
13. **Performance.** With ON, and no Manager or a blocked intake, a survey with hundreds of suspect points prints hundreds of command-line lines before the Approve prompt (Opus note 8). Not measured.
14. **Discovery.** Ribbon as in field 2. "What's New" says "Survey link: Choose a survey drawing and review the result in the Import window." The Manager registry says "Opens CE Manager at the survey you just brought in with CDSURVEY, so you can check it before it is used."
15. **Example drawing and expected result.** From Opus: a host copy with a survey Xref of 32 RL texts: 21 at 10.000 to 10.200 and 11 at 100.000. Today: ten lines and "... and 1 more". With #1809 ON: the page lists all eleven, including "Spot RL 100.000 at (31.0, 0.0)". Command line stays at ten plus the pointer to the page.
16. **Older family card.** `docs\CARDS\CV-07_SURVEY_IMPORT.md`, rows CV7-5 and CV7-8: "Suspect points are excluded or marked Unknown" and "Preview shows ... skipped items". It no longer says how many findings the page shows (ten, not all), and it still describes Manager's "Review workspace" generally.
17. **Tim's AutoCAD checklist.** (Needs #1809 in an installed build.)
    1. Open a copy of a host drawing. Attach the 32-text survey Xref. Type `CDSURVEY` and click the Xref.
    2. The command line shows ten finding lines and "... and 1 more: all of them are listed on the Survey Intake review page".
    3. Open CE Manager > Survey Intake (ribbon: Survey Review). Scroll the list. "Spot RL 100.000 at (31.0, 0.0)" must be there: eleven lines.
    4. Press Cancel. Nothing is stored.
    5. Open Settings > Survey, untick "Survey Intake lists every suspect point". Save, restart AutoCAD. Repeat. You get ten lines and "... and 1 more" on both. Check the tick box is not clipped at 100% and 150% in dark and light.
18. **Questions only Tim can answer.**
    1. **Command-line prefix.** Context: with the box OFF the lines start "[CE]" not a blank indent. Understood: harmless and newer CE lines all start "[CE]". Recommendation: accept it. No means ask for a byte-for-byte old text.
    2. **Does ten suspect points on the command line matter?** Recommendation: keep the command line capped and send you to the page; the cap is a display count, not an engineering value.
    3. **Is there a real survey with more than ten doubtful points you can lend as a copy?** Only you hold one.
19. **NOT proven.**
    1. **Built:** yes on #1809's own branch (18 new checks; the author reports a real red run before the change). Not on any train.
    2. **Tested:** unit tests and off-screen pictures only. Nothing run in AutoCAD or Manager. Not pinned through the tolerant settings read (Opus asks the train to add it).
    3. **Installed:** no.
    4. **Tim-accepted:** no. BUG-1191 stays OPEN.

---

## CARD 4: CDIMPORTLANDXML, pits and pipes from a LandXML file

DRAFT FOR TIM: nothing is approved.

1. **Name, and what it does for a drafter.** CDIMPORTLANDXML. It reads a LandXML drainage file (Civil 3D or 12d style) and draws its pits and pipes as CE pits and pipes.
2. **Ribbon or trigger.** Tab "CE", panel "Import", split button "Import" arrow, item "LandXML" (`CeCvlRibbonContributor.cs` line 159). Or type `CDIMPORTLANDXML`. Registry label "Import LandXML", shortDesc "Choose a LandXML file and review the drainage items before import."
3. **Works today (C-78 line and later).** If a matching .xml sits next to the last source DWG, CE asks "Use '<file>'? [Yes/No] <Yes>:". Otherwise the window's Source page picks the file. After reading, the review page lists what was read; the headless route asks "Import these into the drawing? [Yes/No] <No>:". If there is an earlier import CE asks "Replace the earlier import or Abort? [Replace/Abort] <Abort>:" (switch `xcivilImport.landXmlAsksBeforeReplacing`, ON). Cancelling prints "CDIMPORTLANDXML cancelled. Nothing was drawn." and an aborted replace prints "CDIMPORTLANDXML aborted - the earlier import was left untouched. Nothing was drawn." CE then prints "CDIMPORTLANDXML wrote report: ..." and a debug-log line. A stated-millimetre file stays 1:1 (BUG-725).
4. **What the train or PR changes.**
   1. **BUG-513 and BUG-512 — PR #1229, head cb71824f. Opus: CHANGE-NEEDED, do not merge, close it as already done.** The same fix is on the line since 9 Oct: commit **ae64971a "HUNT2-C-08/09: LandXML placeholders marked and listed; sump level not the invert"** (this is the head of PR #911 in the C-30 train list; I confirmed it is an ancestor of `rel-20261102a`). HUNT2-C-08 is BUG-512 and HUNT2-C-09 is BUG-513. The commit never says the BUG number, so a search for "BUG-513" finds nothing.
    2. **What is on the line today (BUG-513).** A pit with no Invert rows but a sump (floor) level gets no IL. The report says "the file gives no invert level" and its floor level and tells you to type the IL with PITEDIT. Switch `xcivilImport.landXmlSumpLevelAsInvert`, default **false**: false is the new behaviour; true restores the old IL-from-the-sump behaviour exactly (`UserSettings.cs` lines 4114 to 4119 on `rel-20261112a`).
    3. **What is on the line today (BUG-512).** Placeholders are marked, not hidden. A pit with no size in the file is drawn 600 x 600: "the file gives no size, so it is drawn 600 x 600 as a placeholder: set the real size with PITEDIT". A circular structure the file sizes by "diameter" (not read yet): "CE does not read this structure's size from the file yet, so it is drawn 600 x 600 as a placeholder: set the real size with PITEDIT". A pipe with no size is drawn 375 mm and marked uncertain: "the file gives no size, so it is drawn 375 mm as a placeholder (marked uncertain): set the real size with PIPEEDIT". No material uses STORMPRO SN12: "the file gives no material, so STORMPRO SN12 was used as a placeholder: set the real material with PIPEEDIT". Box and egg pipes have their own lines (BUG-723). Unnamed ends: "not drawn: the file does not say which pits it joins".
    4. **What is still open in BUG-512.** The carpark's right result is that an unknown size stays Unknown ("SIZE NOT IN FILE"). The line still draws 375 mm and 600 x 600, marked as placeholders. Those are hard-coded numbers (rules R-00, R-12). This is why BUG-512 stays open.
    5. **#1941 also covers CDIMPORTLANDXML.** The results page lists what was drawn and a pit number already in the drawing reads "Not drawn" (C-79c only; see card 1). #988's pipe length would also show on LandXML rows (Opus note 3).
    6. **#892 and #1982 touch this command too.** #892's LandXML half is already on the line as BUG-725 (do not merge). #1982 would also let LandXML pit inverts of 0 or negative values come in as real ILs (card 2, NOT approved). #1816 is not here.
5. **Suggested class: Keep, with the BUG-512 remainder as a later Modify.** The command works and has had its main faults fixed; the placeholder question is yours. Suggestion only.
6. **Prompts and windows.** As in field 3. Source page, review page (CivilImportWindow), results page. Report lines as in field 4.3.
7. **Selection.** None in the drawing.
8. **Preview.** The review page ("Choose the file and review what was read before adding it to the drawing", per What's New). Rows carry the placeholder lines.
9. **Drawing output.** Pits and pipes drawn as CE objects. Same locked-layer protection as card 1: an item needing a locked layer is not drawn and nothing is unlocked. A pit with no coordinates is "not placed: the file gives it no coordinates". A pipe whose pit is missing is "not drawn: one of its pits is missing or was not placed". REFEDIT is refused at the start (`RefuseWhenReferenceEditing`); this was read in the X-Civil command and is GUESS for LandXML.
10. **Cancel, Escape, Undo and Redo.** Cancelling prints the sentences in field 3 and draws nothing. Undo and Redo: existing path; not re-proven for these fixes.
11. **Save and reopen.** Not read. NOT proven.
12. **Assets, data and Settings.** Reads the .xml. Writes a report and debug log. Switches: `xcivilImport.landXmlSumpLevelAsInvert` (false), `xcivilImport.landXmlAsksBeforeReplacing` (true), `xcivilImport.importResultsFromWhatWasDrawn` (ON on C-79c). Tests for the unknown markers are in `Modules/Drainage.Tests/Helpers/LandXmlUnknownsTests.cs`.
13. **Performance.** Not measured.
14. **Discovery.** Ribbon as in field 2. "What's New" and the registry text. Help list: GUESS, CDIMPORTLANDXML may not be in the Help list (only CDIMPORTXCIVIL was seen at `CdHelpService.cs` line 47).
15. **Example drawing and expected result.** From Opus: a LandXML file where one structure has its Invert rows removed but keeps a sump of 97.80, and one pipe has no CircPipe element. Expect: no IL on that pit, a report line naming its floor level 97.80 and saying to type the IL with PITEDIT, and the pipe drawn 375 mm with a placeholder line telling you to use PIPEEDIT. Copy of a made-up file only.
16. **Older family card.** `docs\CARDS\CV-07_SURVEY_IMPORT.md` (CV7-10: "LandXML retains its Z values and RLs") and `docs\workflows\C5_IMPORT_DECISION_EXAMPLES_2026-09-13.md` (official LandXML schema, units, per-pipe inverts). They do not say: the sump is no longer written as IL; placeholder sizes are drawn and marked; the report wording; the replace-before-importing prompt. CV-07 still says LandXML is hidden.
17. **Tim's AutoCAD checklist.** (On the installed build; this behaviour is already there.)
    1. Make a copy of a small made-up LandXML file. Delete the Invert rows of one structure but keep its sump level. Delete the CircPipe of one pipe.
    2. Open a Civil copy drawing. Type `CDIMPORTLANDXML`. Choose the file. Review. Import.
    3. The pit with no Invert has no IL label, and the report line says the file gives no invert level and names its floor level.
    4. The pipe is drawn 375 mm and the report says it is a placeholder, with "PIPEEDIT".
    5. Type U: everything the import did goes back in one step. Wait 12 seconds, type REDO.
    6. Run `CDIMPORTLANDXML` again on the same drawing. You should be asked "Replace the earlier import or Abort? [Replace/Abort] <Abort>:". Press Enter: "aborted - the earlier import was left untouched. Nothing was drawn."
18. **Questions only Tim can answer.**
    1. **Unknown size (BUG-512).** Context: the file says nothing about a pipe or pit size and CE draws 375 mm or 600 x 600. Understood: both are marked uncertain with a PITEDIT/PIPEEDIT line. Recommendation: keep the marked placeholder for now, because an empty drawing is harder to fix than a flagged one, and decide later whether a real "Unknown" size is worth the rework. Keep means a drafter must read the report. Change means a pit or pipe with no size shows blank and later checks skip it.
    2. **Sump as IL switch.** Recommendation: leave it false (no IL from a sump). A pit's floor is not the pipe invert, so IL 19.70 where the outlet is at 19.85 would pull pipes 150 mm too low.
    3. **BUG-512 and BUG-513 in the carpark:** your word on whether to annotate them as "fix on the line since 9 Oct, not seen in AutoCAD". I recommend yes (a note only, not FIXED).
19. **NOT proven.**
    1. **Built:** yes, ae64971a is on the line (C-78 and later).
    2. **Tested:** unit tests for the markers (LandXmlUnknownsTests). No robot or Codex run of this exact file is recorded in what I read.
    3. **Installed:** yes, as part of C-78 (3.0.88) and C-79a (3.0.89). I did not read the DLL or the installed bundle.
    4. **Tim-accepted:** no. The carpark says "not seen in AutoCAD yet" for both BUG-512 and BUG-513. They are not FIXED.
