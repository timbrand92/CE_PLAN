# CARD DRAFTS 9 of 15: CDCALC and CDWT (5 cards), Mon 2 Nov 2026, Melbourne time

Written by Sonnet (Team, read-only) for CE 05, at CE 00's request. Nothing was built, tested, installed or opened in AutoCAD. Only this file was written. Every card below is a DRAFT for Tim: nothing is approved.

## FOR TIM

1. **Five cards, all pinned down:** CDCALC Export to XLSX (#1983), CDCALC Pipe Flows speed warnings (#1805), CDCALC Charged System millimetre warning (#1806), CDWT "why no tank pictures" (#1808), CDWT typed 0 detention (#1807). I could pin every command to the ribbon and the code.
2. **None of the five changes is on any release line yet.** All five are draft PRs. I checked that none of their heads is inside `rel-20261102a` (3fbb9da5, Civil 3.0.88), `rel-20261106a` (61fd6fbc, Civil 3.0.89, the installed one) or `rel-20261108a` (cf059dcf, Civil 3.0.90, the newest). None of the five switch names exists in the Settings code on any of the three.
3. **A correction to the brief:** the newest Civil line is `rel-20261108a`, not `rel-20261102a`. I read both. The CDCALC and CDWT code I quote is identical on both for these five points.
4. **A finding for card 3 (you asked me to check):** the CDCALC Charged System tab shows ONLY the first warning when several apply (the window prints the first one in the list). On the line today, "Qmax is less than design flow rate" comes before the 300 mm head warning, so a drafter who has both sees only the Qmax line. The 300 mm head warning is hidden. Pipe Flows never has two warnings at once, so it does not have this problem.
5. **Card 2 (#1805) is not ready:** Opus said CHANGE-NEEDED. As written it would stop warning on a fast uPVC pipe (4 m/s warns today, would not warn with the PR). It must use the picked pipe's material.
6. **Questions that need you:** 4 in all. The fixed 2 m limit (card 3), where the Pipe Flows slow-pipe limit comes from (card 2, already answered by your earlier ruling, I only confirm it), whether the file-only switches are acceptable (cards 4 and 5), and whether BUG-1268 may be called visible-only (card 1).
7. **Read:** the five Opus reviews, the BUG-1268 root-cause report, the q11 report, the build register items 263 and 264, the carpark entries, and the code on the three lines and on each PR head. **NOT proven:** anything in AutoCAD. Nobody has seen any of these five changes in a real window. The Claude robot cannot press Export or a Save box, so card 1 needs a Codex look.

---

# CARD 1 of 5: CDCALC Export to XLSX says what happened (#1983)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** CDCALC "Export to XLSX" saves the calculation sheets you ticked as an Excel file. The change makes it say "saved" or "nothing was saved" instead of closing silently.
2. **Ribbon or trigger:** command `CDCALC`. Ribbon: tab **CE** (the default tab; the old "CE Civil" tab only shows if "Show classic CE tabs" is on), panel **Review**, button **Calculations**. On the old tab it is panel **Output**, button **Calculations**. Then in the window "Creative Engineering | Calculations": tab **Print**, sub-tab **Sections and export**, tick sections, **Preview package**, then **Export to XLSX** (`CalculationsV2Dialog.xaml:1317`). The button is enabled only after a package is previewed.
3. **Works today:** the Excel file is written when the Save As box returns a good answer (Codex saw this work on 18 Oct on Civil 3.0.54: `L1_calc_XLSX.xlsx`, 10,233 bytes). One sheet per ticked section, with the cover fields. The Excel-library fault message (BUG-1255, #1871) stays. Keep protects that.
4. **What the train or PR changes:** **PR #1983** (B-157, BUG-1268, one commit 4fcf82b4 on `rel-20261102a` 3fbb9da5). Draft only. Switch `excel.confirmCalcXlsxSaved`, **ON by default**, a missing settings file also reads ON. With it ON: (a) the Save box opens in the same folder Pit Schedule uses (job's Civil folder, else the drawing's folder, else Documents); (b) after the save CE checks once that the file is there and not empty; (c) the window's bottom status line reads "XLSX saved: <name> in <folder>"; (d) if the file is missing, a box reads "The XLSX file was not created in <folder>. Nothing was saved." With it OFF: no start folder, no box, no status line, exactly today. In both cases CE writes log lines (file name only, never the folder): cancelled, saved with its size, or not created. It also adds one "cancelled" log line to Pit Schedule CSV export, Pit Schedule Excel export and the Design-check CSV export (nothing changes on screen for those). **The switch has no Settings window row; it is in the settings file only.**
5. **Suggested class: Keep** (with a note). Why: Opus (1981_1983 group) said KEEP-WITH-NOTE. The export itself is sound; the change only makes the result visible. GUESS on the label: "Modify" is also fair because the Save box and status line change. Your call.
6. **Prompts and windows:** the Windows Save As box, filter "Excel Workbook (*.xlsx)", suggested name from the sheet name (it read "CalcReport.xlsx" on the Codex drawing). Status line text above. Error box title "CDCALC Export". Another existing box: "The calculation package changed while the Save window was open. Preview the package again, then export."
7. **Selection:** none in the drawing. It uses the sections you ticked.
8. **Preview:** the Preview package step, which already exists. The XLSX reads the same prepared package as the preview.
9. **Drawing output:** none. Nothing is drawn or changed in the drawing. Locked layers, Xrefs and REFEDIT do not apply because no drawing object is touched. It writes one file to disk, at the path you pick.
10. **Cancel, Escape, Undo and Redo:** Cancel in the Save box writes nothing; on screen nothing shows (as before), the CE log gets one INFO line. Undo and Redo do not apply (no drawing change). The file is not removed by Undo.
11. **Save and reopen:** the file stays where you saved it. Nothing changes in the DWG. Whether the Save box really starts in the right folder after reopening a drawing is NOT proven.
12. **Assets, data and Settings:** reads the one switch above, the previewed package and the Civil folder/drawing folder. Writes only the chosen .xlsx and the CE log. Excel library: ClosedXML (BUG-1255 handles a load fault).
13. **Performance:** one extra file-exists check, once, no retry. The write itself is synchronous on the window's thread, as before. A slow network folder could pause the window; that is NOT proven either way.
14. **Discovery:** ribbon as in field 2; command line `CDCALC`; Help page `.../commands/cdcalc` (command-registry) and the Help guide entry for CDCALC. The guide lists the Print tab; it does not mention the XLSX saved line (GUESS: help text is unchanged by #1983).
15. **Example drawing and expected result:** use a test copy of a job drawing with a calculated detention system. CDCALC, Print, Sections and export, tick Detention and Pipe Flows, Preview package, Export to XLSX, type the full path `C:\<test folder>\Job24-115_calc.xlsx`, Save. Expected: the file exists, is not empty, opens in Excel with two sheets; the status line reads "XLSX saved: Job24-115_calc.xlsx in C:\<test folder>"; the CE log has one "CDCALC: XLSX saved Job24-115_calc.xlsx (<bytes> bytes)" line. GUESS on file name: any name works.
16. **Older family card:** `docs\CARDS\CV-06_REVIEW_CALCULATION.md`. It says XLSX export was implemented 10 Sep 2026 and reads the same prepared package (one worksheet per ticked section). It does NOT say: the export is silent on Cancel and on failure, it has no start folder, it never says "saved", BUG-1268 (found 1 Nov: the 3.0.88 install wrote no file in the Codex look), or the new switch. Its AutoCAD verification line still reads "not started".
17. **Tim's AutoCAD checklist** (after a build is installed, on a COPY of a drawing, after 5:30 pm):
    1. **Open CDCALC** (ribbon CE, Review, Calculations). Print, Sections and export. Tick two sections. Press Preview package.
    2. **Press Export to XLSX.** Look at which folder the Save box opened in. Expect your job's Civil folder or the drawing's folder. Do not send a screenshot of that folder outside.
    3. **Type a full path and press Save.** Expect the bottom status line to say "XLSX saved: <name> in <folder>". Open the file in Excel: one sheet per ticked section.
    4. **Press Export to XLSX again and press Cancel.** Expect no box, no file, no message.
    5. **Press Export to XLSX and type a path in a folder that does not exist.** Expect a plain box or a Windows error, never silence.
    6. **Pit Schedule control:** PITSCHEDULE, Export Excel. Expect the Save box to open in the same folder as before.
    7. **Tell me if the Save box opens partly off the screen.** That was seen on 1 Nov and may be the real cause of BUG-1268.
18. **Questions only Tim can answer:**
    1. **Context:** BUG-1268 (CDCALC export wrote no file on 1 Nov). **Understood:** the root-cause job is about 75% sure the Save box returned "not saved" and CDCALC treated it like Cancel. This PR makes that visible; it does not explain why Windows said "not saved". **Recommendation:** accept the PR as a visibility fix and keep BUG-1268 OPEN until a Codex look shows a confirmed Save leaves a file. **Meaning on a job:** if you say yes, a drafter who loses the export sees a box instead of sending a package with no spreadsheet. If you say no, the silent failure stays on the next build.
    2. **Context:** the "XLSX saved" line shows the folder. **Understood:** job folders can hold an address; the log lines hold the file name only. **Recommendation:** keep the folder on screen only (as built). **Meaning:** the drafter sees where it went; the log and fault reports never carry the job address.
19. **NOT proven:** **Built:** yes, PR #1983 head 4fcf82b4 built (author report: 18 of 18 new tests, 116 of 116 focused, net10 and net48; full suite not run). **Tested:** unit tests only; the real Save box and the real default folder were never tested. **Installed:** no. The installed 3.0.89 has the silent version. **Tim-accepted:** no. Nobody has opened this change in AutoCAD, and nobody has done a Codex look (K1_02b_calc_xlsx_saved is not yet run). BUG-1268 stays OPEN. Opus said Codex look plus Pit Schedule folder check; the Claude robot cannot press Export.

---

# CARD 2 of 5: CDCALC Pipe Flows warns at your Settings speed limits (#1805)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** CDCALC Pipe Flows tab: you type a pipe size, roughness and grade and it shows full-bore flow and speed with a warning if the pipe is too slow (silting) or too fast (scour). The change makes it use your Settings limits, as CDRULES does.
2. **Ribbon or trigger:** command `CDCALC`, ribbon tab **CE**, panel **Review**, button **Calculations** (old tab: panel **Output**). In the window, tab **Pipe Flows** (`CalculationsV2Dialog.xaml:546`). The warning line is the red line under the results (`:568`).
3. **Works today (on the line):** the tab warns "Velocity is low; check for sedimentation risk." below a fixed 0.5 m/s, and "Velocity is high; check for scour risk." above the material limit from Settings for the pipe you picked, else a fixed 3.0 m/s (`PipeFlowCalcViewModel.cs:308-311`, same on rel-20261102a and rel-20261108a). Only one warning shows at a time (low or high, never both).
4. **What the train or PR changes:** **PR #1805** (BUG-1089, head a9fec2d8, 333 commits behind its release base). Draft only. Switch `detention.pipeFlowsUseSettingsSpeedLimits`, **ON by default**, with a row in Settings, Newer tools: "[CE] Pipe Flows uses the Settings speed limits" (both Settings windows). With it ON the slow warning uses the Settings minimum (0.6 m/s as shipped) instead of 0.5. As written, the fast warning uses the Settings "unknown material" maximum (6 m/s as shipped) instead of 3.0, **which Opus says loses a warning** (see field 5). Settings are read at AutoCAD start, so a change needs a restart.
5. **Suggested class: Modify**, and not ready. Why: Opus (BACKLOG R1) said **CHANGE-NEEDED**. The slow-pipe half is right. The fast-pipe half would stop a uPVC pipe at 4 m/s warning (today it warns above 3.0; with the PR only above 6.0). The release line already reads the picked pipe's material (BUG-527 item 5.2, commit bea97ec2), so the PR must use it: switch ON = the Settings table for the picked pipe's material (or the general maximum when none is picked); switch OFF = the line's current behaviour exactly. This also needs a rebuild of the one line, not a mechanical merge.
6. **Prompts and windows:** no new window. Two warning lines exactly as above. One new Settings row.
7. **Selection:** you can pick a pipe from the drawing to load its size and material, or type the numbers.
8. **Preview:** the results and warning update as you type.
9. **Drawing output:** none. A calculator tab; it writes nothing to the drawing, so locked layers, Xrefs and REFEDIT do not apply.
10. **Cancel, Escape, Undo and Redo:** closing the window discards the tab. No drawing change, so Undo and Redo do not apply. A draft of the entries is saved with the CDCALC draft (existing behaviour).
11. **Save and reopen:** the typed entries and warnings are kept in the CDCALC draft record (existing). The new warnings are recalculated, not stored. Not tested.
12. **Assets, data and Settings:** reads the minimum speed (`designStandards` minimum velocity, 0.6 m/s default), the per-material maximum table, and the new switch. Writes nothing new.
13. **Performance:** instant (a few multiplications).
14. **Discovery:** ribbon and command line as above; Help guide lists the Pipe Flows tab. The new Settings row is under Newer tools. Whether that Settings page still fits the agreed window height on the newest line is NOT proven (Opus warned the page may now be too tall).
15. **Example drawing and expected result:** no drawing needed. CDCALC, Pipe Flows: **300 mm concrete, n 0.013, grade 1 in 600**: full-bore speed about 0.56 m/s. Today: no warning. With the change: "Velocity is low; check for sedimentation risk.", and CDRULES on a matching drawn pipe also warns "below 0.6 m/s". **375 mm, 1 in 20:** about 3.55 m/s. Today (no material picked) the line warns of scour (above 3.0); with the Settings unknown-material maximum of 6 m/s it would not. **uPVC pipe picked from the drawing at about 4 m/s:** must warn (limit 3.0); this is the case the PR as written loses.
16. **Older family card:** `docs\CARDS\CV-02_HYDRAULIC_DESIGN.md`. It says one hydraulic engine must give identical results across CDCALC, CDEDIT, Inspector and CDRUNSOLVE (HD2), and lists "CDCALC: separate calculator can disagree with drawing commands" and "UPVC has conflicting 3.0 and 6.0 m/s limits". It does NOT say the Pipe Flows tab uses its own fixed 0.5 and 3.0 m/s (BUG-1089), nor the new switch. Its status reads implementation "not started".
17. **Tim's AutoCAD checklist** (after a fixed build is installed; set the switch in Settings, then restart AutoCAD):
    1. **CDCALC, Pipe Flows.** Enter 300 mm, 0.013, 1 in 600. Expect the red line "Velocity is low; check for sedimentation risk."
    2. **Enter 375 mm, 1 in 20.** Expect no scour warning if no pipe is picked and the Settings unknown-material maximum is 6 m/s.
    3. **Pick a uPVC pipe from the drawing and set a grade for about 4 m/s.** Expect the scour warning. If it does not warn, the change is wrong.
    4. **CDRULES on a matching drawn pipe.** Expect CDRULES and CDCALC to agree.
    5. **Turn the switch OFF in Settings, Newer tools, restart AutoCAD, repeat step 1.** Expect today's behaviour (no low-speed warning at 0.56 m/s).
    6. **Look at Settings, Newer tools in light and dark.** Expect nothing cut off.
18. **Questions only Tim can answer:**
    1. **Context:** the fast-speed limit on Pipe Flows when no pipe is picked. **Understood:** your R-01 ruling (QUESTIONS item 112, build register item 223) is one Settings speed table, uPVC 3.0, and the general maximum when the material is unknown. That already answers it; I only confirm it. **Recommendation:** no new decision. Build the picked-pipe version. **Meaning on a job:** a uPVC pipe at 4 m/s warns whether you type it in CDCALC or run CDRULES; a pipe with no material shows the general maximum.
    2. **Context:** whether the low-speed limit should follow the Settings 0.6 m/s or stay at 0.5. **Understood:** the carpark entry and CDRULES use 0.6. **Recommendation:** use 0.6 so both commands agree. **Meaning:** your 300 mm at 1 in 600 line warns instead of passing quietly.
19. **NOT proven:** **Built:** the PR head built on its old base (author report CODEX_BUILD_BD15_26OCT.md: red first, 3 of 4 red, then green, no new full-suite failure); not built on the newest line. **Tested:** unit tests only, on the 26 Oct base. **Installed:** no. **Tim-accepted:** no. Nobody ran Pipe Flows in AutoCAD, with or without the change. The picked-pipe case, and the Settings page height on the newest line, are untested.

---

# CARD 3 of 5: CDCALC Charged System warns when a diameter looks like millimetres (#1806)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** the Charged System tab sizes a charged (full-bore, pressurised) stormwater pipe, and its "Pipe diameter (m)" and "Downpipe dia (m)" boxes take METRES. The change warns when you type a number that is clearly millimetres (150 instead of 0.15).
2. **Ribbon or trigger:** command `CDCALC`, ribbon tab **CE**, panel **Review**, button **Calculations**; tab **Charged System** (`CalculationsV2Dialog.xaml:693`, tooltip "NCC H2P1, charged stormwater pipe sizing (Hazen-Williams)").
3. **Works today (on the line):** the nine boxes (Runoff coeff C, Rainfall I, Catchment area, H-W roughness C, Pipe diameter (m), Pipe length (m), Loss coeff K, Available head (m), Downpipe dia (m)) give Design flow Q, friction loss, minor loss, total loss and Qmax. It warns only for: missing inputs, "Qmax is less than design flow rate.", and the minimum head (BUG-1097, "Head left after pipe losses ... is under the 300 mm minimum for a charged system (R-13)"). **Today a typed 150 gives a 150 m pipe with 0.0000 m losses and a comfortable-looking 26.15 L/s, with no warning** (carpark BUG-1103).
   **What a drafter sees when several warnings apply:** the window shows ONLY the first warning in the list (`CalculationBaseViewModel.cs:24`: `Warning` is the first item; the Charged tab binds `{Binding Warning}`). The list order on the line is: missing inputs, missing length/K/head, **Qmax less than design flow**, **minimum head (300 mm)**, then the starting-figure notes. So if Qmax is too low AND the head is under 300 mm, the drafter sees only the Qmax line; the 300 mm warning is hidden. Same on rel-20261108a.
4. **What the train or PR changes:** **PR #1806** (BUG-1103, two commits, head c68c5db4, 384 commits behind). Draft only. Switch `detention.chargedDiameterSenseWarning`, **ON by default**, with a row on the Settings Design page. A Pipe diameter or Downpipe dia over **2 m** adds one warning line: "Pipe diameter 150 m is over 2 m. This box takes metres: type 0.15 for a 150 mm pipe." (and "Downpipe diameter ..." the same way). Results still show. Exactly 2 m, blank, zero, negative or text gives no new line. The 2 m is a fixed number in the code (`DiameterSenseLimitMetres = 2.0`); **only the on/off is in Settings**. In the PR's order the two diameter warnings come BEFORE Qmax and head, so a typed 150 shows first.
5. **Suggested class: Keep** (with notes). Why: Opus (BACKLOG R4) said KEEP-WITH-NOTE. Notes: Tim to confirm the fixed 2 m; the merge needs a keep-both in six files; the Design page height must be re-measured (the author measured 670 px against a 673 px limit, and the line has since added another row on that page). Caveat: even with this PR, the window still shows only the first warning.
6. **Prompts and windows:** no new window. One warning line in the existing red warning area under the results. One new Settings row (Design page).
7. **Selection:** none (typed values only).
8. **Preview:** the results and warning update as you press Tab.
9. **Drawing output:** none; calculator only. Locked layers, Xrefs and REFEDIT do not apply.
10. **Cancel, Escape, Undo and Redo:** close the window to discard. No drawing change. Undo and Redo do not apply.
11. **Save and reopen:** the typed entries are kept in the CDCALC draft (existing, CV6-13B). The warning is recalculated, not stored.
12. **Assets, data and Settings:** reads the switch, and (existing) the charged minimum head from Settings (`ChargedMinHeadMm`, the 300 mm house rule) and its two switches. The 2 m limit is not in Settings.
13. **Performance:** instant.
14. **Discovery:** ribbon and command line as above; Help guide lists "Charged System". The Settings row is on the Design page. Page height on the newest line is NOT proven.
15. **Example drawing and expected result:** no drawing needed. CDCALC, Charged System, **Pipe diameter 150, Tab.** Today: results of 26.15 L/s, no warning. With the change: the red line "Pipe diameter 150 m is over 2 m. This box takes metres: type 0.15 for a 150 mm pipe.", results still shown. Type 0.15: no diameter warning. **Downpipe dia 100:** the matching "Downpipe diameter 100 m ..." line (type 0.1). Edge to know: 2.5 gives "type 0.0025 for a 2.5 mm pipe"; harmless, nobody means a 2.5 mm pipe. **Hidden-warning check for the drafter:** set a flow that gives Qmax below Q and an available head of 0.25 m: the window shows only the Qmax line today; the 300 mm head line is not visible.
16. **Older family card:** none for the Charged System tab by name. The nearest is `docs\CARDS\CV-02_HYDRAULIC_DESIGN.md` (HD1: "Charged pipes, pumps and detention use the same rulebook but receive dedicated workflow reviews"). That dedicated review is not in the folder I read (GUESS: not yet written). The card does NOT say charged boxes are in metres, nor that nothing checks a typed 150.
17. **Tim's AutoCAD checklist** (after a build is installed):
    1. **CDCALC, Charged System.** Type 150 in Pipe diameter, press Tab. Expect the red line naming 150 m and "type 0.15 for a 150 mm pipe", and the results still showing.
    2. **Type 0.15, Tab.** Expect no diameter warning.
    3. **Type 100 in Downpipe dia, Tab; then 0.1, Tab.** Expect the downpipe line, then none.
    4. **Hidden warning:** set Available head to 0.25 and a Pipe length that makes Qmax lower than the design flow. Expect one line only; note which one. Tell me if you would have wanted both.
    5. **Settings, Design page.** Expect the new row visible, not cut off, in light and dark. Turn it off, Save, restart AutoCAD, repeat step 1: expect no diameter warning.
18. **Questions only Tim can answer:**
    1. **Context:** the 2 m limit. **Understood:** your carpark entry says "warn on any diameter over 2 m"; no real charged pipe is 2 m across; the PR keeps 2 m fixed in code, with only an on/off in Settings. **Recommendation:** leave it fixed (Opus agrees; it catches typing mistakes only). **Meaning on a job:** fixed = a 2.5 m typed value warns for every office; changeable = an office with a real large culvert could raise it, at the cost of one more Settings row.
    2. **Context:** the window shows only the first warning. **Understood:** the head under 300 mm warning (BUG-1097) can be hidden by "Qmax is less than design flow". **Recommendation:** show all warnings, one per line (a separate small change, not part of #1806). **Meaning:** a charged system that is both too small and too shallow tells you both. Not decided; nothing is built.
19. **NOT proven:** **Built:** PR head c68c5db4 built on its 25 Oct base (author: red first, 6 of 13 failed on unchanged code, then 79 focused green; full suite no new failing name). **Tested:** unit tests and an off-screen picture only; the real CDCALC window was never seen in AutoCAD. **Installed:** no. **Tim-accepted:** no. The hidden-warning finding above is from reading the code; nobody has seen it on screen either.

---

# CARD 4 of 5: CDWT says why the tank pictures are missing (#1808)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** CDWT places a water tank. It normally opens a window with tank pictures from the office Standard Details drawing. The change prints one line at the command line saying why the pictures did not show.
2. **Ribbon or trigger:** command `CDWT`. Ribbon: tab **CE**, panel **Draw**, button **Water Tank** (tooltip "Place a water tank from the office tank plans."). Old tab "CE Civil": panel **Draw**, flyout **Drainage Sources**, item **Water Tank**.
3. **Works today:** if the Standard Details Civil folder (Settings) has the tank master drawing, the picture window opens first ("where it goes, which tank, how much is detention, which plan drawing"), then CE asks for the point. If the folder is missing, CDWT skips the window and asks, with no reason given, "Adopt a block already in the drawing, or Insert a plan block from the office master?". If you pick Insert with no master it says "CDWT refused - neither <plans file> nor <tanks file> was found in the Civil Standard Details folder (Settings). Nothing was placed." On AutoCAD 2022 to 2026 the picture window never exists, so those versions always use the command-line questions.
4. **What the train or PR changes:** **PR #1808** (BUG-1174, one commit 39697c32, 333 behind its base). Draft only. Switch `options.cdwtSaysWhyNoTankPictures`, **ON by default**, **no Settings row** (the page would have been 725 px, over the 673 px limit), so it can only be changed in the settings file. One new line, before the Adopt/Insert question, with three wordings: "[CE] Tank pictures not shown: no Standard Details folder is set." / "[CE] Tank pictures not shown: Standard Details folder not found at <folder>." / "[CE] Tank pictures not shown: no tank master drawing found in Standard Details folder at <folder>." Text only; nothing else changes.
5. **Suggested class: Keep** (with note). Why: Opus (BACKLOG R4) said KEEP-WITH-NOTE. Notes: the author marked their own full-suite gate BLOCKED (one PDF render test, unrelated to CDWT; the train must show the same failing names as the base); add the key to the next defaults pin through both start-up reads; the switch is file-only. The wording on 2022 to 2026 will also say "folder not found" even though fixing the folder will not bring pictures back on those versions. True but may confuse.
6. **Prompts and windows:** the new command-line line, then the existing "Water tank: Adopt a block already in the drawing, or Insert ..." prompt. No new window.
7. **Selection:** as before (Adopt asks you to pick an existing tank block; Insert asks for a point).
8. **Preview:** none new.
9. **Drawing output:** none new; the line is text at the command line only. The placement, block, label and drawing write are untouched, so locked-layer, Xref, REFEDIT and Redo handling stay on their existing path (Opus, and `WaterTankAtomicPlacementTests` still checks every placement line).
10. **Cancel, Escape, Undo and Redo:** Escape at the following question places nothing ("CDWT cancelled - nothing was placed."). Undo after a placed tank is unchanged.
11. **Save and reopen:** unchanged.
12. **Assets, data and Settings:** reads Settings Standard Details Civil folder (`StandardDetailsCivilFolder`) and the new switch; checks the folder exists (one extra folder check on the fallback route; a dead network drive could double a short wait, Opus note).
13. **Performance:** one extra folder check, only on the fallback route.
14. **Discovery:** ribbon and command line as above; the Help page keyword list includes "cdwt". The new line is the discovery: it names the folder to fix. The switch is not discoverable (file-only).
15. **Example drawing and expected result:** a blank test drawing on a disposable settings file. Set Standard Details Civil folder to `C:\Example Job\Missing Standard Details` (it must not exist). Type `CDWT`. Expect, once, "[CE] Tank pictures not shown: Standard Details folder not found at C:\Example Job\Missing Standard Details." before the Adopt/Insert question. Press Escape: nothing placed. Then an empty folder gives the "no tank master drawing found" line; a blank folder setting gives the "no Standard Details folder is set" line.
16. **Older family card:** `docs\CARDS\CV-04_SURFACE_DRAINAGE.md`. It says CDWT starts with a clear mode (adopt, insert or annotate, CV4-9) and flags "CDWT can leave a partly created tank if cancelled after placement", with CDWT marked "Rebuild workflow and compound grouping". It does NOT say anything about the picture window being skipped silently, the Standard Details folder, the 2022-2026 versus 2027 difference, or this line. Also relevant on the same area: `docs\workflows\CDWT_WINDOW_CONTRACT.md` (not read for this draft).
17. **Tim's AutoCAD checklist** (on AutoCAD 2027, disposable settings, blank drawing):
    1. **Settings:** point the Standard Details Civil folder at a folder that does not exist. Restart AutoCAD.
    2. **Type CDWT and press F2** to see the command history. Expect the "folder not found at ..." line once, then the Adopt/Insert question.
    3. **Press Escape.** Expect "CDWT cancelled - nothing was placed."
    4. **Blank the folder setting; repeat.** Expect "no Standard Details folder is set".
    5. **Use an empty existing folder; repeat.** Expect "no tank master drawing found".
    6. **Restore the real folder; type CDWT.** Expect the picture window and none of these lines.
    7. **Optional:** put `"cdwtSaysWhyNoTankPictures": false` in a COPY of the settings file's options group, restart, repeat step 2. Expect none of the lines.
18. **Questions only Tim can answer:**
    1. **Context:** the switch has no Settings row. **Understood:** the Settings page would be too tall; Opus accepted a file-only switch for a LOW text-only change. **Recommendation:** accept file-only. **Meaning on a job:** drafters always get the helpful line; only a support person editing the file can turn it off. If you would rather have a row, the Settings page needs a taller window or another page.
19. **NOT proven:** **Built:** PR head 39697c32 built on its 26 Oct base (author: 13 of 13 CDWT tests; full-suite gate marked BLOCKED by the author for an unrelated PDF test). **Tested:** unit tests only; no real tank master and no real tank window opened. **Installed:** no. **Tim-accepted:** no. No Codex look needed (command line only), but a robot run on a test copy has not been done.

---

# CARD 5 of 5: CDWT keeps a typed 0 for detention (#1807)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** when you place a tank from the office tank library, CDWT asks how many litres of the tank are detention (the rest is reuse). The change makes a typed 0 mean zero detention (all reuse) instead of putting the library tank's figure back.
2. **Ribbon or trigger:** command `CDWT`. Ribbon: tab **CE**, panel **Draw**, button **Water Tank**. Old tab: panel **Draw**, flyout **Drainage Sources**, item **Water Tank**. The prompt it changes is `Detention volume (litres) <1000>:` on the **command-line route (AutoCAD 2022 to 2026)** with a library tank.
3. **Works today (on the line):** on the command line the prompt takes a number or Enter. Enter keeps the library tank's detention figure; a typed value is used. **A typed 0 is quietly replaced by the library figure** (`WaterTankCommand.cs:498`, using `PromptPositiveDouble`, which returns "true, 0" for both Enter and a typed 0). Nothing shows today because every library tank we ship holds 0 L detention. Same on rel-20261108a.
4. **What the train or PR changes:** **PR #1807** (BUG-1115, head 446980a0, 333 behind its base). Draft only. Switch `linking.cdwtTypedZeroDetentionIsKept`, **ON by default**, **no Settings row** (689 px against the 673 px limit), file-only. ON: the prompt reads its own answer. Typed 0 means 0 L detention, all reuse; Enter alone keeps the library figure; typed 400 means 400 L; Escape keeps the library figure and the command carries on. OFF: the old behaviour (any 0 or less puts the library figure back).
5. **Suggested class: Keep** (with note). Why: Opus (BACKLOG R6) said KEEP-WITH-NOTE. Notes: the PR calls itself BLOCKED by one PDF test, but that test also fails on the unchanged base (a flaky test, not this change); add the switch to the C-79 defaults test through both readers; file-only switch.
6. **Prompts and windows:** `Detention volume (litres) <1000>:` (the number in the brackets is the library tank's detention). No new window. Existing capacity check after it: a reason line then "Nothing was placed." if the capacity does not work.
7. **Selection:** the library tank choice, then the point (existing).
8. **Preview:** none.
9. **Drawing output:** only the number fed into the existing capacity check and the callout changes. The callout reads, for example, `5000 lt TO BE USED FOR TOILET FLUSHING AND WATER REUSE` when detention is 0 (Opus robot scenario). Tank placement, block, label and drawing write are untouched, so locked-layer, Xref, REFEDIT and Redo handling stay on their existing path.
10. **Cancel, Escape, Undo and Redo:** Escape at the detention prompt keeps the library figure and carries on (as before). Undo after placing must remove the tank cleanly, Redo put it back; this is NOT proven in AutoCAD.
11. **Save and reopen:** the detention figure is stored with the tank record and callout as before. After save and reopen it must still read 0 L. Not tested.
12. **Assets, data and Settings:** reads the tank library entry (total and detention litres), the switch. Writes the tank record and callout as before.
13. **Performance:** none.
14. **Discovery:** ribbon and command line as above. The switch is not discoverable (file-only). **The change is invisible on a normal job**, because every shipped library tank holds 0 L detention; it only shows once an office tank carries a detention share.
15. **Example drawing and expected result:** make a TEST library tank of 5,000 L total holding 1,000 L detention (none shipped has any; it must be made on a copy of the library). CDWT, choose it, at `Detention volume (litres) <1000>:` type `0`, place it. Expect **0 L detention and 5,000 L reuse**, callout `5000 lt TO BE USED FOR TOILET FLUSHING AND WATER REUSE`. Enter alone: 1,000 detention and 4,000 reuse. Type 400: 400 detention and 4,600 reuse. With the switch OFF (set before AutoCAD starts): typed 0 gives 1,000 detention. Undo removes the tank; Redo puts it back.
16. **Older family card:** `docs\CARDS\CV-04_SURFACE_DRAINAGE.md` (the same card as card 4; it records CDWT tank capacities and the cancel-after-placement fault). It does NOT say how the detention prompt treats 0, the library-tank detention question (Opus: asked "even when the size came from the library", because the detention share is a per-job decision), or this switch. **Cross-reference only:** the Rational and Pump tab C changes (PR #1965) are on the CDDESIGN card; I did not draft or read them here.
17. **Tim's AutoCAD checklist** (on AutoCAD 2022 to 2026, a copy of a job drawing, a TEST library tank holding 1,000 L detention):
    1. **Type CDWT, choose the test tank.** At `Detention volume (litres) <1000>:` type 0 and press Enter. Place the tank. Expect 0 L detention, 5,000 L reuse in the callout.
    2. **Repeat with Enter alone.** Expect 1,000 L detention, 4,000 L reuse.
    3. **Repeat with 400.** Expect 400 L detention, 4,600 L reuse.
    4. **Press U after placing; then Redo.** Expect the tank removed cleanly, then back.
    5. **Save, close, reopen.** Expect the callout unchanged.
    6. **Switch OFF** in a COPY of the settings file before AutoCAD starts; repeat step 1. Expect 1,000 L (the old behaviour).
    7. **On AutoCAD 2027** the picture window is used; whether its detention field accepts a typed 0 was NOT read here (GUESS: separate code, not changed by #1807). Please type 0 in that window and tell me what the tank records.
18. **Questions only Tim can answer:**
    1. **Context:** a typed 0 for detention on a library tank. **Understood:** your carpark entry says "A typed 0 is an answer"; today it silently becomes the library figure. **Recommendation:** accept #1807. **Meaning on a job:** you place a 5,000 L library tank as reuse only and the callout is right, instead of the tank being drawn with a detention volume you did not want.
    2. **Context:** the 2027 window route. **Understood:** #1807 changes only the command-line prompt. **Recommendation:** have the robot check the 2027 window with a typed 0 as part of the same test. **Meaning:** if the window ignores 0 too, that is a separate bug to park, not part of this card.
19. **NOT proven:** **Built:** PR head 446980a0 built on its 26 Oct base (author: helper test red then green, "Expected: 0, But was: 1000" then passes; full-suite gate called BLOCKED by a flaky PDF test). **Tested:** the helper that chooses the figure is unit-tested; **the prompt itself is not driven by any test**, so the real fix is proven only in AutoCAD, and nobody has done that. **Installed:** no. **Tim-accepted:** no. A test library tank holding detention must be made first; without it the change cannot be seen.

---

## Which items are on which line (one place)

1. **On `rel-20261102a` (3fbb9da5, Civil 3.0.88):** none of the five. The silent export (BUG-1268), the fixed 0.5 and the material-based fast limit on Pipe Flows, the unwarned millimetre diameter, the silent skipped picture window and the swallowed typed 0 are all on the line.
2. **On `rel-20261106a` (61fd6fbc, installed Civil 3.0.89) and `rel-20261108a` (cf059dcf, Civil 3.0.90):** none of the five either; I checked that no PR head is an ancestor and that no switch name exists in the Settings code.
3. **Drafts only:** #1983 (4fcf82b4), #1805 (a9fec2d8), #1806 (c68c5db4), #1807 (446980a0), #1808 (39697c32). Opus pre-review verdicts: #1983 KEEP-WITH-NOTE; #1805 CHANGE-NEEDED; #1806, #1807, #1808 KEEP-WITH-NOTE. Build register items 263 and 264 record #1983 as a "candidate for C-80". I found no register line naming #1805 to #1808 as C-80 candidates (GUESS: the brief names them from other files I did not read).
4. **I could not run `gh` here** (not on this tool's PATH), so PR open/draft state comes from the Opus reviews (all DRAFT, 1 Nov), not a live check.
