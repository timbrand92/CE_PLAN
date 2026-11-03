# CARD DRAFTS 11 of 15: Civil start-up, menu, Ask CE and Help

Written Mon 2 Nov 2026 (Melbourne) by Sonnet, read-only. DRAFT FOR TIM: nothing in this file is approved.

## FOR TIM

1. **Five cards below** (menu and Repair, Ask CE "From file", WSUD export, Help pages, two Save As Xrefs). Every card is a suggestion only. None is approved.
2. **Where the changes are:** all five PRs (#1957, #1959, #1877, #1896, #1925) are on `rel-20261106a` (C-79a, Civil 3.0.89) and on the later 08a, 10a and 12a lines. **None is on `rel-20261102a`** (that line stops at C-78, Civil 3.0.88). I checked this by asking git whether each PR's last commit is inside each line.
3. **Corrections to the brief:** the WSUD export is in **CDCALC** (the Calculations window), not CDDESIGN. CDMENU has **no ribbon button** (typed only). The Xref change touches the Pit Schedule (PITSCHEDULE), not the import.
4. **Xrefs:** no path in the Pit Schedule's Xref reader writes to an Xref. I read the reader file: it only opens drawings for reading. I did not trace every other part of the Pit Schedule.
5. **Questions that need you:** 6 in total (card 1: two, card 2: one, card 3: two, card 4: one, card 5: none). Most important: card 3, because the WSUD tab boxes are read-only, so the export may print "not entered" for every drafter.
6. **Could not pin down:** the text of the PRs themselves (the `gh` tool is not on this PC), so PR wording comes from the commits, the finalizer report and the Opus reviews. Draft #599 (menu text sweep) was not found in any file I could read; its clash is taken from CE 05's note.
7. **Read:** RULES.md, the finalizer report, PR list, build register, Opus re-check, review S, the carpark entries, the five PR commits, and the code on the line. **NOT proven:** nothing here was run or opened in AutoCAD. Menu and Ask CE changes only matter on AutoCAD 2022 to 2024, and nobody has that year here (decision 181 parks it).
8. **Flaky test:** the "1 failed of 47" on #1959 did not repeat. The finalizer ran that test class five times on net10 (7 of 7 each time) and once on net48 (7 of 7). The 47 was probably a wider filter in the author's run. Not understood for certain.

---

## CARD 1: CDMENU and Repair: check the Civil menu is really loaded (AutoCAD 2022 to 2024)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** CDMENU (typed) and the Repair window's "Restore CE Civil Tools" button bring the CE Civil menu back when it has gone missing. PR #1957 makes them check that the menu is truly loaded before saying "loaded".
2. **Ribbon or trigger:** **CDMENU** has no button: it is typed only (registry entry "Civil Menu (CDMENU)", hidden, expert, group "Help & Status / Review Pending"). **Repair window:** ribbon tab **CE** (tab is called **CE Civil** if "Show classic CE tabs" is on), panel **Edit**, button **Repair & Upgrade** (command CDREPAIR), then the button **Restore CE Civil Tools** at the bottom of the window. The old Admin-panel layout file calls the same command "Repair Centre".
3. **Works today (Keep would protect):** start-up installs the menu once and trusts that for the whole session. CDMENU rebuilds the Civil ribbon (2025 and later prints "The Civil ribbon rebuild is queued. If it remains hidden after a moment, restart AutoCAD."). The Repair window shows the installed menu path and the "recorded menu version".
4. **What the train or PR changes:** PR #1957 (BUG-1211, B-129, head 4e1574d6, merged as 058edc17 on 20261106a). Switch **`install.restoreMenuChecksLoadedGroup`**, **ON** by default (a missing settings file or group reads ON). **AutoCAD 2022 to 2024 only** (the code sits inside the older-lane build). The drafter's own restore now asks AutoCAD for its list of loaded menu groups (the list CUILOAD shows) and looks for `CE_CVL_SUITE_MENU`. If it is not there, it loads it again in the same session. Start-up keeps its old shortcut. OFF gives the old words and old skip exactly. The existing master switch `install.autoInstallWorkspaceMenu` still applies (OFF means nothing is loaded).
5. **Suggested class:** **Modify.** The command works; its "loaded" claim was wrong after CUILOAD unloaded the menu. Suggestion only.
6. **Prompts and windows (exact words in the code):**
   1. CDMENU first prints: "[CE] Restoring the CE Civil drawing tools..."
   2. Confirmed loaded: "[CE] The Civil menu is loaded."
   3. AutoCAD could not say: "[CE] The Civil menu was loaded again, but AutoCAD did not confirm it. If it is still hidden, restart AutoCAD."
   4. Failed, or still not loaded: "[CE] The Civil menu could not be restored. See the CE log, then restart AutoCAD."
   5. Repair window first line: "CE Civil tools are loaded." / "CE Civil menu file is there but not loaded. Press Restore CE Civil Tools (below)." / "Installed menu: file found; AutoCAD did not say if it is loaded." / "Installed menu: Missing". Switch OFF: "Installed menu: OK" or "Missing" (file only).
7. **Selection:** none. No object is picked.
8. **Preview:** none.
9. **Drawing output:** none. The finalizer report says this "touches no drawing object at all": it reads AutoCAD's menu list and may reload CE's own menu file into the session. Locked layers, Xrefs and REFEDIT are not involved. The reload goes through the existing menu-load path, which also re-saves the menu path in CE Settings (as start-up always did), and only when the drafter asks.
10. **Cancel, Escape, Undo and Redo:** nothing is drawn, so Undo and Redo have nothing to undo. CDMENU runs to the end without asking anything. The finalizer's check for hooks that could disturb Undo or Redo found only the five read-only lines of this menu check, and the Redo-safety tests passed (25 on net10).
11. **Save and reopen:** nothing saved in the drawing. Settings may be re-written with the menu path (see 9). After reopening, start-up installs the menu as before.
12. **Assets, data and Settings:** reads AutoCAD's loaded menu groups (`MenuGroups`, read late-bound, no new AutoCAD reference). Reads the menu file path and "recorded menu version" in Settings. Writes the menu path in Settings only through the existing loader.
13. **Performance:** one small read of AutoCAD's menu list per explicit restore. Not measured. Nothing added at start-up.
14. **Discovery:** typed CDMENU; Repair & Upgrade on the Edit panel; Help Centre (CDHELP). Whether a Help page names CDMENU: **not checked**.
15. **Example drawing and expected result:** on AutoCAD 2024, type CUILOAD, untick CE_CVL_SUITE_MENU, close. Type CDMENU. Before: "The Civil menu is loaded" and the menu stays missing. After: the menu comes back and the line says "The Civil menu is loaded." (Taken from the PR text and the carpark; not run.)
16. **Older family card:** `docs\CARDS\CV-08_REPAIR_MIGRATION.md` (approved plan: CDREPAIR becomes the one recovery entry; says it opens Manager > Drawing Repair). **No longer says:** anything about the menu, CDMENU or CUILOAD; and the code on this line still opens the Civil Repair window (`CdRepairDialog`) from CDREPAIR, so the card's direction is plan, not current behaviour. The AI-01 and FIRST_COLLEAGUE cards do not cover CDMENU.
17. **Tim's AutoCAD checklist (needs AutoCAD 2022, 2023 or 2024):**
   1. Open any drawing. Type **CUILOAD**, select **CE_CVL_SUITE_MENU**, click **Unload**, then **Close**. The CE menu disappears.
   2. Click **CE tab, Edit panel, Repair & Upgrade**. Look at the first line. You should see "CE Civil menu file is there but not loaded. Press Restore CE Civil Tools (below)."
   3. Click **Restore CE Civil Tools**. The menu returns and the status reads "CE Civil tools are loaded."
   4. Repeat step 1, then type **CDMENU**. You should see "[CE] The Civil menu is loaded." and the menu back.
   5. Type **CDMENU** again with the menu loaded. Same line, nothing doubled.
   6. If you ever see "loaded again, but AutoCAD did not confirm it", tell me: that is the unconfirmed case.
18. **Questions only Tim can answer:**
   1. **Draft #599.** Context: open draft #599 (a text-clean-up sweep) also edits the menu installer and the CDMENU failure line, and is not in any train. I understand: both change the same lines, so one has to be reworked after the other. Recommendation: **put #1957 in first** (it is in C-79a and fixes a real fault), then rebase #599, because the text sweep is cosmetic. If yes: #1957 ships and #599 waits. If no: the C-79a menu fix is held back until #599 is decided. (This clash is from CE 05's note of 31 Oct; I did not test it.)
   2. **Unconfirmed reload.** Context: when AutoCAD will not say whether the menu is loaded, the restore now loads it again. I understand: if the menu was really loaded, that is a second load of a loaded menu, and nobody has tested it on any year (Opus note). Recommendation: **keep it** (the drafter asked for the restore; the line says "did not confirm"). If yes: a drafter on a busy 2023 PC may see a harmless second load. If no: the restore says "could not confirm" and does nothing, so an unloaded menu stays missing.
19. **NOT proven:** **Built:** yes (finalizer: whole solution 0 errors). **Tested:** unit tests only (`Bug1211MenuRestoreTests`, the switch default tests, Redo-safety); nobody ran it on AutoCAD 2022 to 2024. **Installed:** no (no bundle was deployed by this card). **Tim-accepted:** no. BUG-1211 stays OPEN. Nobody has done any of the last three; there is no robot lane for these years. Which of 2022, 2023 and 2024 answer the `MenuGroups` read is the open fact.

---

## CARD 2: CDASK (Ask CE, canonical name CEASK): "From file…" picker (AutoCAD 2022 to 2024)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** Ask CE's "From file…" button lets you pick a screenshot or scan of a redline and have CE read the markups. PR #1959 stops the file picker offering PDFs on AutoCAD years that can never read them.
2. **Ribbon or trigger:** ribbon tab **CE**, panel **CE**, large button **Ask CE** (command **CEASK**; **CDASK** is the older name for the same thing). It opens the Ask CE palette. Inside the palette: buttons **Analyse markups** and **From file…**.
3. **Works today (Keep would protect):** PNG and JPG load (large images are shrunk before sending). On 2025 and later, a PDF is drawn to pictures (first 5 pages only). Findings go through the existing review and Apply gates.
4. **What the train or PR changes:** PR #1959 (BUG-1214, B-129, head d7c1e154, merged 7dad606d on 20261106a). Switch **`ai.markupFilePickerMatchesLane`**, **ON**. **AutoCAD 2022 to 2024 only:** the picker lists images only ("Markup images (*.png;*.jpg;*.jpeg)" plus "All files"). 2025 and later: unchanged. OFF gives the old list exactly. Also: this PR added an invisible text-format marker to the first line of `MarkupFileImageLoader.cs` (finalizer: harmless).
5. **Suggested class:** **Modify** (small). The command stays; the picker list and one sentence change. Suggestion only.
6. **Prompts and windows (exact words):**
   1. File window title: "Select a markup file".
   2. Old list (2025 and later, or switch OFF): "Markup files", "Images", "PDF", "All files".
   3. New list (2022 to 2024, switch ON): "Markup images (*.png;*.jpg;*.jpeg)" and "All files (*.*)".
   4. A file type CE cannot read: "Unsupported file type '.xyz' — pick a PNG or JPG file." (old wording: "pick a PNG, JPG, or PDF file").
   5. A PDF chosen through All files on 2022 to 2024 is still refused with the unchanged sentence: "PDF support requires AutoCAD 2025 or later. On this AutoCAD version, please convert the PDF to PNG/JPG and use "From file…" with the image instead."
   6. If AI is switched off or not allowed, the palette says so before the file window opens (the master-switch sentence, or "AI access is unavailable, stale or confidential.", or "AI access was blocked because the egress audit could not be recorded.").
7. **Selection:** one file only (multi-select is off). No drawing objects.
8. **Preview:** none for the picker. After analysis, any suggested drawing changes use the existing proposal preview, then Apply (unchanged by this PR).
9. **Drawing output:** the picker itself draws nothing. Any change comes only from the existing Review and Apply step; that step is not changed here. The picked image is sent to the AI service for reading, and CE records an audit entry first ("user-selected-image"). Locked layers, Xrefs and REFEDIT: the picker does not touch them; the later Apply step keeps its existing protections (not re-read here).
10. **Cancel, Escape, Undo and Redo:** closing the file window without choosing does nothing. The palette's Stop button and a time limit already exist (BUG-CDASK-HANG fixes, older). Undo: this PR changes no drawing write.
11. **Save and reopen:** nothing saved by the picker.
12. **Assets, data and Settings:** reads the one file you pick; reads `ai.markupFilePickerMatchesLane`; records the AI-egress audit entry.
13. **Performance:** none added. The 2025 and later PDF path is untouched.
14. **Discovery:** ribbon **Ask CE** button; typed CEASK or CDASK. (In the registry CEASK is hidden under "Review Pending", the ribbon button is the way in.)
15. **Example drawing and expected result:** on AutoCAD 2024, a PNG screenshot of a marked-up pipe layout, "REDLINE_P3.png". Click Ask CE, From file…, you see only "Markup images" and "All files" (no PDF choice). Pick the PNG: it analyses. Before the PR, a one-page PDF could be picked and then refused.
16. **Older family card:** `docs\CARDS\AI-01_ASK_CE_MCP_AUTOMATION.md` and `docs\workflows\C6_SHARED_CANONICAL_ASK_CE_2026-09-13.md`. **No longer says:** anything about the file picker, PDF support by AutoCAD year, or the unsupported-file sentence. C6 only covers the CEASK name and that CDASK reaches the same palette. `FIRST_COLLEAGUE_ISSUE_2026-09-07.md` mentions Ask CE only for palette-close.
17. **Tim's AutoCAD checklist (needs AutoCAD 2022 to 2024):**
   1. Click **CE tab, CE panel, Ask CE**. The palette opens.
   2. Click **From file…**. In the type box, you should see only "Markup images" and "All files".
   3. Pick a PNG. It should start analysing.
   4. Click **From file…** again, choose **All files**, pick a one-page PDF. You should see the "PDF support requires AutoCAD 2025 or later…" sentence, and nothing sent.
   5. Click **From file…** and Cancel. Nothing happens.
   6. (On AutoCAD 2025 or later, for comparison) From file… still lists Markup files, Images, PDF, All files.
18. **Questions only Tim can answer:**
   1. **PDF backport.** Context: colleagues on 2022 to 2024 are still told to convert PDFs to PNG. I understand: the PDF reader for those years is separate work and not part of this PR. Recommendation: **leave the picker fix as is and decide the PDF backport later**, because it is a feature, not a fault. If you want PDFs on older years: it becomes its own card. If not: those colleagues keep converting to PNG first, now with an honest picker.
19. **NOT proven:** **Built:** yes. **Tested:** unit tests only (`Bug1214MarkupPickerTests`, 7 tests; five reruns on net10 and one on net48 all 7 of 7). The "1 failed of 47" did not repeat and is not explained for certain. **Installed:** no. **Tim-accepted:** no; BUG-1214 stays OPEN. Nobody has opened the picker on any AutoCAD year; nobody has done the last three. Opus rated it KEEP (re-check) and the finalizer KEEP-WITH-NOTE.

---

## CARD 3: CDCALC WSUD export prints "not entered" instead of a sample site

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** the Calculations window's computations package (PDF or XLSX) includes the WSUD section. PR #1877 stops it printing the opening sample site (1,000 m², 200, 700) as if it were the job's.
2. **Ribbon or trigger:** command **CDCALC** (ribbon label "Calculations"; **not CDDESIGN**, which is "Design setup" and draws nothing). Window tabs: **Older calculators — WSUD** (the data), then **Print** then **Sections and export**. Tick **WSUD / annual load reduction**, click **Preview package**, then **Export to PDF** or **Export to XLSX**.
3. **Works today (Keep would protect):** the package builds with sections for detention, pipe flows, catchments and WSUD; the preview freezes the package and PDF and XLSX use that same package. The rainfall and the two runoff coefficients still print from the tab. WSUD target and treatment tables print as before.
4. **What the train or PR changes:** PR #1877 (BUG-1112, B-061, head b9842f28, merged bf8cb05e on 20261106a). Switch **`linking.wsudExportSkipsSampleSite`**, **ON**. Code: `Services/CalculationExportPackage.cs` (`CaptureWsud`) and `ViewModels/WsudViewModel.cs`. While none of the three site boxes (site area, impervious pre, impervious post) has changed from the opening 1000 / 200 / 700, the package prints **"not entered"** for the site area, both impervious areas and the four runoff lines (and blanks their units). OFF prints the sample as before.
5. **Suggested class:** **Modify.** Suggestion only. (The carpark's own "expected behaviour" also offered "disable the export while the tab is read-only": not what this PR does.)
6. **Prompts and windows (exact words):** the printed words are "not entered". Rows affected: "Total site area", "Impervious area" (Pre-Dev and Post-Dev columns), and under "Annual Runoff Volumes": "Pre-development", "Post-development", "Increase" (m³/yr) and "Increase" (%). No new window or prompt.
7. **Selection:** none (tick boxes for sections).
8. **Preview:** the existing **Preview package** step shows the "not entered" words before any file is made.
9. **Drawing output:** none. It writes a PDF or XLSX file only. It does not touch the drawing, layers, Xrefs or REFEDIT.
10. **Cancel, Escape, Undo and Redo:** closing the window cancels. Nothing in the drawing, so no Undo.
11. **Save and reopen:** nothing saved in the drawing. Note from the code: "not entered" is decided by whether any of the three boxes **changed** since the window opened, not by the number. A saved draft whose figures differ from the sample counts as entered.
12. **Assets, data and Settings:** reads `linking.wsudExportSkipsSampleSite`. The tab's starting figures come from the Settings page (the `wsudTab` group, BUG-547 part 2); the shipped starting values are the sample (1000 / 200 / 700 in the code).
13. **Performance:** none noticeable (one flag read).
14. **Discovery:** CDCALC; the WSUD tab is labelled "Older calculators — WSUD" with a tooltip "Read-only — under review before its rules are signed". Whether a Help page covers the export: **not checked**.
15. **Example drawing and expected result:** with the sample and typical figures (630 mm rain, C 0.85 impervious, 0.10 pervious: the tooltip values, not checked against the shipped starting values), the old package would print runoff pre 157.5, post 393.75, increase 236.25 m³/yr (150%), worked by me from the formula `(Ai×Ci + Ap×Cp) × rain` in the code. New package: those rows read "not entered". Real site 850 m² still prints only if a box has changed.
16. **Older family card:** none for this export. `docs\CARDS` has no WSUD or computations-package card that I found in this job (**GUESS:** a CDCALC family card may exist; I did not search every file). So the card **no longer says** anything about this.
17. **Tim's AutoCAD checklist:**
   1. Type **CDCALC**. Click the **Older calculators — WSUD** tab: the boxes show 1000 / 200 / 700 and are read-only.
   2. Click **Print**, then **Sections and export**. Tick **WSUD / annual load reduction** only.
   3. Click **Preview package**. In the Site table, Total site area and Impervious area should read **not entered** (no m²). In Annual Runoff Volumes, all four rows read **not entered**.
   4. Click **Export to PDF**, open the PDF and check the same words appear. Rainfall (e.g. 630 mm) and the C figures still show.
   5. If you can change a site figure (see Question 1), change it, preview again: the real figures print.
18. **Questions only Tim can answer:**
   1. **Read-only boxes.** Context: the carpark note (30 Oct review) says every WSUD box is read-only, so a drafter cannot type a site. I understand: the "entered" flag only turns true when a box changes, so with read-only boxes the export may print "not entered" for everybody, always. Whether the Settings starting figures count as "entered" is **not clear from the code I read (GUESS: they do not, because the starting text is set before the flag exists)**. Recommendation: **do not accept the card until a robot or you confirm what a real colleague sees**; if every export says "not entered", the next step is to make the box typeable or hide the WSUD export (your call). If it prints real figures when Settings holds real figures: good, accept.
   2. **Exactly 1,000 / 200 / 700.** Context: a job whose real figures are exactly the sample would print "not entered" until one box is changed. I understand: it is rare and safe (Unknown, never a wrong figure). Recommendation: **accept this limit**. If yes: nothing more. If no: a "typed" flag saved with the draft is needed, which is more work.
   3. (Open limit from Opus, not a question) once one box changes, all three print, so a real site area beside the untouched 200 / 700 would print 200 / 700 as the job's.
19. **NOT proven:** **Built:** yes. **Tested:** unit tests only (`Bug1112WsudExportSampleSiteTests`; `WsudAreasHeldToSiteTests` edited to type a 900 m² site first). One Opus note: the PDF-to-picture test fails on the Edge browser engine, an old fault, not this PR. **Installed:** no. **Tim-accepted:** no; BUG-1112 stays OPEN. Nobody has opened the package in AutoCAD, or looked at the PDF or XLSX; the robot case written for this (C32) was reworked by the reviewer because the first draft assumed typing a figure.

---

## CARD 4: Civil Help pages: Move Arrow, Label Styles and Reverse Flow

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** the Civil Help Centre now has pages for **Move Arrow (CDMA)** and **Label Styles (CDLABELSTYLE)**, and the **Reverse Flow** page now says what the command really does. PR #1896.
2. **Ribbon or trigger:** command **CDHELP**; ribbon tab **CE**, panel **CE**, button **Help Centre** ("Open the CE Help Centre"). **F1** inside any CE window opens that window's page (all CE windows shown through the shared dialog service). In the old classic layout the button is "Help & Status" on the Admin panel. (CEHELP is the Structural command, not Civil.)
3. **Works today (Keep would protect):** the Help window opens (a modeless window, so AutoCAD stays usable) from the offline guide, or a help address if the last CE command has one; search by command name; cards built from the guide list.
4. **What the train or PR changes:** PR #1896 (BUG-1218 and BUG-1220, B-074, head 6c6f0db1, merged 88c01e1d on 20261106a). **No switch** (wording only). File: `Assets/Help/guide-content.js`. Adds two guide entries (CDMA, CDLABELSTYLE); rewrites the CDREVERSEFLOW entry. The guide count moved from 81 to 83 (a true change of the test's expectation, per the finalizer).
5. **Suggested class:** **Keep** (wording fix, no behaviour change). Suggestion only.
6. **Prompts and windows (exact words in the code):**
   1. **Move Arrow:** "Moves the flow arrow of one pipe to a new spot along it, or puts an arrow on a pipe you pick. Typed only; the Edit panel has no separate button for it." Steps: "Type CDMA, then pick either the flow arrow to move, or the pipe to put an arrow on. For an arrow, click its new position. For a pipe, you can type the two end levels (Enter skips them) and answer whether to reverse the arrow."
   2. **Label Styles:** "Opens the window that sets the wording of the pit and pipe labels … Typed only; the Settings panel has no separate button for it." Steps: type CDLABELSTYLE, pick the Pit label or Pipe label tab, Insert field, check the example, Save; "Apply to drawing saves first, then updates the pit level labels already drawn…".
   3. **Reverse Flow:** "Swaps the From and To of one pipe, with their end levels, and flips the flow arrow. The pipe route, its barrels and the label positions stay where they are. It tells you this on the command line and asks Yes or No first; Enter means No." Old text promised a "change preview" and an "Apply" button that do not exist.
7. **Selection:** none (Help). The pages describe selecting one CE pipe.
8. **Preview:** none. The Reverse Flow page now says there is no preview window.
9. **Drawing output:** none. Help only. Locked layers, Xrefs and REFEDIT are not involved.
10. **Cancel, Escape, Undo and Redo:** close the Help window. Nothing to undo.
11. **Save and reopen:** nothing saved.
12. **Assets, data and Settings:** reads `Assets/Help/guide-content.js` in the install. No Settings.
13. **Performance:** none (three text entries).
14. **Discovery:** CDHELP, the Help Centre button, F1 in a CE window, and search for "CDLABELSTYLE" or "CDMA" (before, searching CDLABELSTYLE gave "No matching topic").
15. **Example drawing and expected result:** type **CDHELP**, search **CDREVERSEFLOW**. The page should say it asks Yes or No on the command line and has no preview or Apply. Then on a pipe with inverts 10.00 and 9.90, run Reverse Flow and press Enter at "Continue?": "[CE] Nothing was changed." (from the carpark test).
16. **Older family card:** none specific to Help pages found; `docs\workflows\FIRST_COLLEAGUE_ISSUE_2026-09-07.md` and the C6 card do not cover Help text. **No longer says:** which commands have a Help page. A Help family card may exist elsewhere (**GUESS**; not searched).
17. **Tim's AutoCAD checklist:**
   1. Type **CDHELP** (or click **CE tab, CE panel, Help Centre**). The Help window opens.
   2. Search **CDLABELSTYLE**. You should see a Label Styles page (not "No matching topic").
   3. Search **CDMA**. You should see Move Arrow, "Typed only".
   4. Search **CDREVERSEFLOW**. It should say Yes or No on the command line, no preview, no Apply.
   5. Type **CDLABELSTYLE**, press **F1** in that window: it should open the Label Styles page, not the general guide.
   6. Pick a pipe, run **CDREVERSEFLOW**, press Enter at "Continue?": nothing changes.
18. **Questions only Tim can answer:**
   1. **Reverse Flow wording.** Context: Help now describes the command as it behaves (Yes or No, no preview). I understand: your earlier plan may have wanted a real preview with Apply. Recommendation: **keep the honest wording now**; if a preview is wanted, that is a separate rebuild card. If you keep it: Help matches the command. If you want a preview: the Help text will change again.
19. **NOT proven:** **Built:** yes. **Tested:** unit tests only (`B074HelpWordingTests`, `HelpGuideCoverageTests`, `HelpGuideWindowRenderTests` count 81 to 83). **Installed:** no. **Tim-accepted:** no; BUG-1218 and BUG-1220 stay OPEN. Opus: "Nobody has looked at the Help window." F1 inside Label Styles was not checked in AutoCAD, and I did not confirm F1 routes to the new page (**GUESS**: it should, by the carpark test).

---

## CARD 5: Pit Schedule: two Save As Xrefs are read separately

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** when a sheet has two Xrefs that are Save As copies of each other (Stage 1 and Stage 2), the Pit Schedule now reads each one's pits from its own file instead of reading Stage 1 twice. PR #1925.
2. **Ribbon or trigger:** command **PITSCHEDULE** (the Pit Schedule window; its Xref source list). I did not find the exact ribbon panel for the Pit Schedule button in this job (**not checked**).
3. **Works today (Keep would protect):** Xref pit data is read once per drawing and cached; the source list shows each Xref; the 18 Oct work (existing switch) lists a second Xref with the same hidden drawing ID but different pit data as its own greyed row with a plain message. Two Xrefs with the same ID and same data (the same drawing attached twice) still merge.
4. **What the train or PR changes:** PR #1925 (BUG-788, B-113, head 8b7ee79b, merged b2592c89 on 20261106a). **Existing switch `linking.pitScheduleXrefSeparatesSaveAsCopies`, ON** (the switch is already on `rel-20261102a`; the **change** to the reader is only on 20261106a and later). The reader's cache now keys each Xref by drawing ID **and** the file path (new internal class `XrefRecordCache`), so two Save As copies are each read from their own file. OFF = the old ID-only key. Where no file path is known, each drawing is read on its own.
5. **Suggested class:** **Modify.** Suggestion only.
6. **Prompts and windows:** no new words in this PR. The existing twin message (18 Oct) says "internal drawing ID" (Opus fix round).
7. **Selection:** none new (the window lists Xref sources).
8. **Preview:** the window's existing source list.
9. **Drawing output:** **no path in this reader writes to an Xref.** `Services/PitScheduleXrefDiscoveryService.cs` uses only open-close or read transactions; a search of that file for write-open, upgrade or write modes found none. The finalizer's guard test also pins that the new cache "never opens, writes or changes an Xref". The new cache only stores what was read. **Not traced:** the rest of the Pit Schedule (the schedule itself writes level text and the CHECK marker into the **current** drawing, and PITSCHEDULE refuses to open during REFEDIT, per the command code). Locked layers: not touched by this reader.
10. **Cancel, Escape, Undo and Redo:** read-only reader, nothing to undo from it.
11. **Save and reopen:** nothing saved by the reader.
12. **Assets, data and Settings:** reads the CE project record held in each Xref's drawing; reads the switch.
13. **Performance:** still one read per distinct drawing and path; a size limit on Xref data exists (aggregate byte limit message "Automatic QA XREF ProjectData exceeded its aggregate byte limit."). Not measured.
14. **Discovery:** PITSCHEDULE and the Pit Schedule button. Help page: not checked.
15. **Example drawing and expected result:** DRAIN_STAGE1.dwg (pit A1 at RL 10.20), change the pit to A1 at RL 10.45, Save As DRAIN_STAGE2.dwg. Xref both into a sheet, run PITSCHEDULE. Expected: Stage 1 lists A1 at 10.20 and Stage 2 lists its own A1 at 10.45, not Stage 1's twice. (Numbers are mine; the scenario is from the carpark.)
16. **Older family card:** none found for the Pit Schedule Xref source list. The 18 Oct REGRESSION_LOG entry covers the earlier "greyed twin row" step. **No longer says:** it described Stage 2 greyed and not offered; with this PR the **cache** reads each file separately, but whether Stage 2 is now offered as a normal source or is still greyed is **not clear from what I read** (the 18 Oct entry says giving Stage 2 its own identity is separate work). **Cross-reference only:** the X-Civil import window's **CHECK THE SCALE** line (PR #1926, BUG-505, switch `xcivilImport.scaleNoteOnReviewPage`) belongs on the import card, not here.
17. **Tim's AutoCAD checklist (copies only):**
   1. Open a copy of DRAIN_STAGE1.dwg, change one pit's level, **Save As** DRAIN_STAGE2.dwg.
   2. Open a new sheet, **XATTACH** both. Type **PITSCHEDULE**.
   3. You should see each Xref listed, and each one's own pits (Stage 2's changed level, not Stage 1's).
   4. Check nothing in either Xref file changed (date modified unchanged).
   5. Attach the same Stage 1 file twice: still one source (they merge).
18. **Questions only Tim can answer:** none new. (Whether Stage 2 should be offered for linking is decided by the earlier BUG-788 card; I did not turn it into a question.)
19. **NOT proven:** **Built:** yes. **Tested:** unit tests only (`Bug788XrefRecordCacheTests`, 96 lines; finalizer guard tests). **Installed:** no. **Tim-accepted:** no; BUG-788 stays OPEN. Nobody has seen a real Save As pair in AutoCAD, and whether the hidden drawing ID truly survives Save As is the unproven premise (from the 18 Oct entry). The finalizer says no robot case exists for this; I did not search the robot case list.

---

## What I read and did not

1. **Read:** RULES.md (first 6,000 characters only, which covers sections 0 to 5), AGENTS.md, the finalizer report, TRAIN_C79A_PR_LIST, OPUS_PREREVIEW_RECHECK and review S, BUGFIX_n15 (for #599), the carpark entries for all six bugs, the five PR commits (diffs) and the code on `rel-20261106a` (command registry, ribbon contributor, HelpLauncher, CDMENU, CDASK control, WSUD view model, export, Pit Schedule reader), REGRESSION_LOG BUG-788 entries, and the three family cards.
2. **Did not read:** the PR text on GitHub (`gh` is not installed here), the BUILD REGISTER row detail, Opus reviews T, X, Y and Z (they did not mention these five PRs by number in my search), Tim's real settings files, the robot cases.
3. **Branch tips:** `rel-20261102a` at 3fbb9da5 (C-78, Civil 3.0.88); `rel-20261106a` has the version commit 61fd6fbc (Civil 3.0.89, C-79a). I read the code on 20261106a because that is where these PRs are.
4. **Nothing was run, built or installed.**
