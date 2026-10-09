# Codex brief review: Saturday 10 Oct chain and the bj23-25 builders (written Fri 9 Oct 2026, about 12:30 Melbourne)

**Reviewer:** Opus brief reviewer, read-only. No brief was edited (the controller owns them). Nothing was built, nothing was run in AutoCAD.

**Checked against:** Civil/Manager at `rel-20261009g` = `660487d1` (Civil 3.0.41 / Manager 1.1.41) and Structural at `rel-20261009f` = `9babe787` (Structural 1.0.110), with `git show` / `git grep`; the Codex reports `CODEX_VERIFYW37`, `W38`, `W45` (and W27/W29 for counts); Tim's own files read only (acad.CUIX copied to the scratchpad and unzipped, settings files hashed, admin folders listed, the "Tim" profile keys read).

**Briefs reviewed (chain order in `chain_sat_final.sh`):** W46, W53, W48, W49, W52, W50, W51, W47; plus the builders bj23_noblue (Sun), bj24_cesettings_rows (Mon), bj25_cesettings_rows_civil (Tue). No `verifyW4*` brief is newer than W47 (11:38).

**Answer first:** every brief has at least one fault that would waste or spoil part of a run. The five that matter most:

1. **W46-02 cannot work as written.** All three CE menu files it may unload EXIST and are healthy (checked 12:05 today), so its own rule keeps all three, nothing changes, and W46-03 cannot pass. The start-up lines come from workspace entries inside acad.CUIX, not from the partial-file list (fix 46-2).
2. **Wrong item counts in every launcher and report line** ("FIVE items", "IN SCOPE 5"): W45 already lost an item this way ("W45-05 BLOCKED (missing brief)"). Real counts: W53 3, W49 8, W52 9, W50 6, W51 4, W47 4 (fix C-1).
3. **W47 expects the code word LEGACY_LINKING_MUST_BE_DISABLED on the command line.** The command never prints it: it prints a plain sentence (fix 47-2). And if the cap stops W47 after the tick goes ON, Tim's beam commands 1, 2 and 4 will refuse on Monday (fix C-13).
4. **W50-01 REFCLOSE defaults to Save.** One Enter writes the change into the fixture file DWG-B5_VC7.dwg on disk (fix 50-2).
5. **W53 will stop itself for nothing.** The `policies` folder does not exist yet (the Manager creates it), so "office folder not reachable" would fire and nothing is clicked (fix 53-3).

---

## Part C. Faults in the shared text of every verify brief (fix once, in the header all briefs share)

**C-1. Item counts.** The short launchers all say "the FIVE items Wnn-01 to Wnn-05" and every REPORT line says "IN SCOPE 5" and "the 5 results Wnn-01 to Wnn-05". Real counts are below. Replacement text, per brief (launcher sentence, then the REPORT FIRST LINE and the results list):
1. **W46:** (after fix 46-1) "the FOUR items W46-01 to W46-04" / "IN SCOPE 4" / "the 4 results W46-01 to W46-04".
2. **W53:** "the THREE items W53-01 to W53-03" / "IN SCOPE 3" / "the 3 results W53-01 to W53-03".
3. **W48:** "the FIVE items W48-01, W48-02, W48-03, W48-04a and W48-04b, then the clean end W48-05" / "IN SCOPE 6" / "the 6 results W48-01, 02, 03, 04a, 04b, 05".
4. **W49:** "the setup W49-00 and the EIGHT items W49-01 to W49-08" / "IN SCOPE 8" / "the 8 results W49-01 to W49-08".
5. **W52:** "the setup W52-00 and the NINE items W52-01 to W52-09" / "IN SCOPE 9" / "the 9 results W52-01 to W52-09".
6. **W50:** "the setup W50-00 and the SIX items W50-01 to W50-06" / "IN SCOPE 6" / "the 6 results W50-01 to W50-06".
7. **W51:** "the setup W51-00 and the FOUR items W51-01 to W51-04" / "IN SCOPE 4" / "the 4 results W51-01 to W51-04".
8. **W47:** "the FOUR items W47-01 to W47-04" / "IN SCOPE 4" / "the 4 results W47-01 to W47-04".

**C-2. The shared text forbids the very writes W46, W47 and W53 exist for.** Line 3 says "Change NO code, settings file, bundle or template"; line 7 says "nothing is created on disk by this pass"; line 19 says "never save a template, profile or setting"; the launcher ends "Do not change any code, setting file, bundle or template". A careful Codex may refuse the authorised step. Add ONE line straight after line 3 in those three briefs only:
1. **W46:** "EXCEPTION FOR THIS PASS ONLY (Tim, INT-075 Set A answers 2 and 12): you MAY (a) copy acad.CUIX to a backup file beside it and (b) change ONE profile value, 'Default Template File Name for QNEW', through OPTIONS. Nothing else in the profile, menus or templates is changed. These two lines win over line 3, line 7, line 19 and the launcher's last sentence."
2. **W47:** "EXCEPTION FOR THIS PASS ONLY (Tim said YES, INT-075): you MAY open the Structural Settings window (CESETTINGS) twice and change ONE tick, 'Enable beam linking', ON in W47-01 and back OFF in W47-04. This wins over line 3, the SETTINGS RULE's 'do not open the Settings window' and the launcher's last sentence. A changed size or SHA256 of %APPDATA%\CE_STRUC_SUITE\CS_Settings.json is EXPECTED in this pass and is not a FAIL by itself (W47-04 says what is checked instead)."
3. **W53:** "EXCEPTION FOR THIS PASS ONLY (Tim, INT-076 'yes admin'): the Yes click in W53-02 makes CE write ONE new file, admin-users.json, in the office policies folder. That is the purpose of the pass. It wins over line 3, line 7 and the launcher's last sentence. You write and edit nothing yourself."

**C-3. Line 7 names a Save that no longer exists and forbids the ones the items need.** "No item presses Save or Revert except the Save button inside the Edit Pit window in W16-01" contradicts the Save presses in W49-00, W49-04, W48-04b, W50-02 and W47. Replace that sentence with: "Save buttons INSIDE a CE window that an item names ARE allowed: they change the open COPY in memory only. Never save the DRAWING to disk (no QSAVE, SAVE, SAVEAS, no Yes to a save question)."

**C-4. W-1 tells Codex to click the command strip while a prompt is open.** W-1 defines "ANSWER = LEFT CLICK, count 1, on the command-line strip; type the answer; Enter". Lesson (11) says the opposite, and a click on the strip during a prompt is how a keyword got typed by accident before. Replace the ANSWER definition with: "ANSWER = do NOT click anything; just type the answer and press Enter (AutoCAD sends typing to the open prompt). Only if your typing does not appear on the command line: click ONCE on the far-left blank part of the strip, never on a word or a [bracketed] option, then type again." Keep the CDEDIT-after-a-selection rule as it is (it is typed at the bare 'Command:' line, where a click is safe).

**C-5. Line 15 and the SETTINGS RULE disagree about SAVETIME.** Line 15 says "Do NOT change SAVETIME"; the SETTINGS RULE says set it to 0 and put it back. Replace line 15's sentence "Do NOT change SAVETIME." with: "SAVETIME: set it to 0 straight after the START readings and put back the exact START value before the end (SETTINGS RULE below). SAVETIME is kept in Tim's AutoCAD profile, so it must be put back even if you stop early."

**C-6. The expected Structural settings hash is stale.** The SETTINGS RULE expects "Structural CS_Settings.json C34946A4... 26,901 bytes" and says any difference is a FAIL. Structural 1.0.110 grew the file on 9 Oct 06:00 (Codex W43; W45 reported it). Read today 12:05: 28,872 bytes, SHA256 D3890D560A451133D2B258765BEAE058A81A94477ECF5DB172910185C0799C05. The other two are unchanged (CD_Settings.json ACD64E79..., TIM_CE_CADTOOLS CS_Settings.json 622A246F...). Replacement: "Structural CS_Settings.json D3890D56... 28,872 bytes (9 Oct 06:00)". In W47 only, the controller takes its own copy just before the run: use that copy's hash as the start value.

**C-7. All runs write into the same evidence folder.** Line 13 and the END text write `VERIFYW9\settings_start.json`, `logs_start`, `logs_end`, `NEXT_START.txt`, so each run overwrites the last one's evidence. W45 avoided it by making its own sub-folder. Replacement for every `VERIFYW9\` in lines 13, 14, 18 and the END text: "VERIFYW9\<this pass name>_<yyyyMMdd_HHmm>\" (for example `VERIFYW9\W48_20261010_0215\`).

**C-8. A mouse-click selection is wiped by the Esc-twice rule.** The SELECTION RULE only protects a typed (sssetfirst ...) line. W49-03 and W50-02 select by clicking, then say TYPE MOVE / TYPE LIST, and a TYPE-COMMAND starts with Esc twice, so the selection is lost and the command asks "Select objects:", which the brief does not answer. Add to the SELECTION RULE: "The same applies after a selection made by a mouse click: the next command is typed WITHOUT Esc. Better still, where an item says 'click X, then TYPE a command', TYPE the command first and pick X at its 'Select objects:' prompt, then press Enter."

**C-9. Ctrl+Tab is a keyboard shortcut the rules forbid.** Line 6 allows only Esc in the drawing area; W49-02 and W52-07 switch drawings with Ctrl+Tab. Add to line 6: "EXCEPTION: Ctrl+Tab to switch between open drawings is allowed where an item names it."

**C-10. "LOCK NO LAYER" (line 7 (c)) contradicts W50-02 and W50-03**, which lock the label layer. See fix 50-3 for the exception line.

**C-11. The start rule is one point stricter than the runner.** `queue3.sh` starts a job when usage is at or below its cap (it skips only when usage is GREATER than the cap). The brief then says "If the reading at the start is already {CAP} or higher, do not start". So a job launched at exactly the cap starts Codex, which refuses, and the slot is spent for nothing. Replacement for line 4's last sentence: "If the reading at the start is already HIGHER than {CAP}, do not start: write that in the report." (Or the controller changes queue3's test to "at or above": one or the other, not both.)

**C-12. The budget sentence disagrees with the caps.** Line 4 says "this pass may spend about 5 points". With 64% now and caps of 66 to 70, no pass has 5 points. Recent passes cost 1 to 2 points each (queue.log W31 to W45). Replacement: "this pass should cost about 2 points; the {CAP} stop line wins over this figure."

**C-13. A cap stop must never leave Tim's PC changed.** "STOP AT {CAP}% even if items remain" would, in the middle of W46, W47, W49-06 or W52-08, leave Tim's profile or settings changed. Add to line 4: "STOP-SAFE RULE: when you stop for ANY reason (cap, crash, three unexpected inputs), first put back what this pass changed, then stop: SAVETIME to its START value; in W47 the beam-linking tick back to its W47-01 value (W47-04's Settings steps only); in W46, nothing extra (the template change is one OPTIONS step and is either done or not). These put-back steps are done even past {CAP}."

**C-14. Stale header and labels (low risk, Codex coped in W45).** Line 1 still reads "CODEX VERIFY W9 ... CIVIL ... on the installed Structural build"; line 27 says "W2-NN"; line 18 says "screenshots\W4-NN-<word>.png"; line 9 quotes 8 Oct versions. Replacement for line 1's opening: "CODEX VERIFY <pass name> - MOUSE-ONLY PASS - AUTOCAD TEST ON TIM'S PC"; line 27 "<pass>-NN"; line 18 "screenshots\<pass>-NN-<word>.png".

**C-15. The word 'follow'.** Found once, in W53 (fix 53-2). None in the other briefs, launchers or common.txt.

---

## W46 (profile clean-up and default template; cap 66)

**46-1. Two different start drawings and "one session" while the item restarts AutoCAD twice.** The ORDER OF WORK says "ONE FRESH AUTOCAD SESSION: the first drawing is C:\ce_rc_vc7\DWG-B1_VC7.dwg"; W46-01 needs AutoCAD closed; W46-02 opens DWG-S1_VC7_b.dwg; W46-03 restarts. Replace that sentence with: "W46-01 is done with AutoCAD CLOSED, before anything else. Then ONE AutoCAD session: start it by double-clicking C:\ce_rc_vc7\DWG-S1_VC7_b.dwg (85,871 bytes) in Explorer; START CHECK there. At the end TYPE CLOSE with No, then File > Exit."

**46-2. W46-02 cannot change anything, and the start-up lines are not where it looks.** Checked today, read only:
1. **The three partial menu files all exist:** `%APPDATA%\Autodesk\AutoCAD 2027\R26.0\enu\ce_cvl_suite\CE_CVL_SUITE_MENU.cuix` (70,775 bytes, 1 Sep), `...\enu\ce_struc_suite\CE_STRUC_SUITE_MENU.cuix` (122,625 bytes, 23 Sep), `%APPDATA%\CE_CADTOOLS\CE_SUITE_MANAGER\CE_SUITE_MANAGER_MENU.cuix` (28,808 bytes, rewritten by the Manager at every start, last 9 Oct 06:57). Under the brief's own rule ("if the file exists and looks healthy DO NOT unload it"), Codex keeps all three, nothing changes, and W46-03's "the lines are gone" cannot happen.
2. **The real source** is the WORKSPACE entries inside Tim's main file `...\enu\Support\acad.CUIX` (WorkspaceRoot.cui): 12 workspaces each list the CE pull-down menus and toolbars. The two failing names are the top pull-down menus: CE_CVL_SUITE_MENU "CE CVL" (its id is "CE Civil generated menu") and CE_SUITE_MANAGER_MENU "CE Manager". This matches the Team-lane run 60 diagnosis (TEAMLANE3_LOG, 9 Oct 02:05) and the BUG-435 comment in `CuiMenuGeneratorService.cs` at 660487d1. Civil no longer writes these entries (the old `TryPatchMainCuixWorkspaces` call is gone at 660487d1), so a clean-up would now stay clean.
3. **Removing those entries takes the CE CVL and CE Manager pull-down menus off the menu bar** (the ribbon tabs are not affected). That clashes with W46-03's check "the CE pull-down menus must still be there", which would then trigger the ROLLBACK. So this needs Tim's choice, not a Codex guess. The Day 1 page step 4 has the same wrong route and should be corrected by the desk.
4. **Replacement (makes W46-02 read only; the old W46-03 is removed; the template item and the clean end move up one number):**

   "W46-02 READ-ONLY LOOK AT THE MENU SET-UP (change nothing; press Cancel, never Apply or OK): TYPE TEXTSCR, bind to the text window, screenshot, WRITE every start-up line mentioning 'Menu item failed to load' or 'syntax error', TYPE GRAPHSCR. TYPE CUI: on the Customize tab, in 'Customizations in All Files', WRITE the name of the main customization file and of every entry under 'Partial Customization Files'. Expand 'Workspaces' and WRITE every workspace name, marking the one shown as current. Click the CURRENT workspace once: in the right-hand 'Workspace Contents' pane expand 'Menus' and 'Toolbars' and WRITE every entry whose name starts with CE. Screenshot. Press CANCEL (never Apply, never OK). TYPE (getvar \"MENUBAR\") and write it. Write the OSMODE/CLAYER/DBMOD line. Expected and NOT a fault: the lines are still there, because this pass removes nothing (the clean-up needs Tim's choice: the desk has the reason)."

   Then renumber: old W46-04 becomes W46-03, old W46-05 becomes W46-04 (C-1).

**46-3. W46-01 backs up five files and only one matters.** The search finds acad.CUIX in `...\enu\Support\` and four more in `AutoIsolate0` to `AutoIsolate3`. Replacement for W46-01's second sentence: "Back up ONLY %APPDATA%\Autodesk\AutoCAD 2027\R26.0\enu\Support\acad.CUIX (write its length and SHA256; copy it beside itself as acad.CUIX.before_ce_cleanup_20261009, or with a time stamp added if that name exists; write the copy's length and SHA256: they must be equal). List the AutoIsolate copies (path and length only) and leave them alone. PASS = the copy exists and its SHA256 equals the original." (AutoCAD rewrites acad.CUIX a few bytes at every start, as W45 saw: that is not a fault.)

**46-4. The template item: name the old value and avoid the File menu.** Tim's Set A question 2 says the current QNEW default points to `...\_TEST_COPIES_20260923\BISECT_STRUCT_ONLY\office_template_copy.dwt`. Replacement for the VERIFY sentence: "VERIFY: TYPE QNEW (do not use the File menu). Expected: a new drawing opens with NO template question. If a question 'Enter template file name...' or a 'Select template' window appears instead, write it, press Esc, and write FAIL. TYPE (list (getvar \"INSUNITS\") (getvar \"MEASUREMENT\")): expected (4 1). TYPE CLOSE, No. PASS = the OPTIONS box shows ...\Template\acadiso.dwt after OK AND QNEW opened without a question AND (4 1)." The file exists: `%LOCALAPPDATA%\Autodesk\AutoCAD 2027\R26.0\enu\Template\acadiso.dwt` (31,825 bytes).

**46-5. Add the exception line of C-2 (W46).**

---

## W53 (Tim becomes the CE administrator; cap 67)

**53-1. Counts:** see C-1 (three items, not five).

**53-2. Remove the word 'follows'.** In W53-02 replace "WRITE every window, line or message that follows, exactly" with "WRITE the exact text of every window, line or message that appears after that click".

**53-3. The policies folder does not exist yet, so W53-01 would stop for nothing.** Checked today: `%OneDriveCommercial%` is `C:\Users\<login>\OneDrive - Creative Engineering`, and neither `...\Creative Engineering - IT Admin` nor `...\Creative Engineering\Creative Engineering - IT Admin` exists under it. The code (CePluginInstallerService.GetItAdminPath) therefore uses its fallback `%USERPROFILE%\Creative Engineering\Creative Engineering - IT Admin`, which exists. Inside it `CE Plugin Admin` holds AC2026_WORK, failures, machines, releases, support-bundles and usage, but NO `policies` folder: the Manager creates it on the Yes (Directory.CreateDirectory). Replacement for W53-01's first two sentences: "in PowerShell check %USERPROFILE%\Creative Engineering\Creative Engineering - IT Admin\CE Plugin Admin (the folder CE uses on this PC; checked 9 Oct). WRITE whether it exists, whether it holds a folder named releases, and whether its files are local (not 'online only'). REACHABLE = that folder exists with releases inside. A missing policies sub-folder is EXPECTED: CE makes it on the Yes. If policies exists, list its file names and sizes."

**53-4. Add the missing stop for a local file.** The code offers the one-time question only when NO admin file exists anywhere (shared OR this PC's). Today `%APPDATA%\CE_CADTOOLS\CE_Admin\policies\` exists and is empty. Replacement for the STOP sentence: "IF the CE Plugin Admin folder is NOT REACHABLE, OR admin-users.json ALREADY EXISTS in ...\CE Plugin Admin\policies, OR %APPDATA%\CE_CADTOOLS\CE_Admin\policies\admin-users.json EXISTS: STOP, write BLOCKED with what you saw, and click NOTHING."

**53-5. The result box needs one click the brief forbids.** After Yes, CE shows a second box titled 'Admin Dashboard' with the result sentence and one OK button. The brief says "DO NOT click ... anything else". Add after "click YES ONCE": "a second box titled 'Admin Dashboard' then shows one sentence and an OK button: WRITE the sentence exactly (Windows account replaced by <login>), then click OK ONCE." The Admin Dashboard window does NOT open on this path (the code returns after the OK), so "if the Admin window opens..." can stay as a safety line.

**53-6. Say what PASS and FAIL are.** Add to W53-02: "PASS sentence: '<login> is now the CE administrator, recorded in the shared IT Admin folder. Every machine that can reach it will see this.' FAIL sentence: '... is now the CE administrator on this PC only ...' (the office folder was not reached: write FAIL and do not try again). Any other sentence: write it, BLOCKED." Add to W53-03: "PASS = the file exists in ...\CE Plugin Admin\policies, holds exactly ONE name, that name equals $env:USERNAME (write only YES/NO), and the local %APPDATA% file does NOT exist." Also: the file holds only a 'Users' list (no created-by or time fields), so "keep the structure" means that one list.

**53-7. Add the exception line of C-2 (W53).**

---

## W48 (check of Civil 3.0.41 / Manager 1.1.41; cap 68)

**48-1. Start drawing conflict, and DWG-B1 would be opened twice.** The header says the first drawing is DWG-B1_VC7.dwg; W48-01 says "the first drawing is a NEW blank drawing (File > New...)"; W48-03 then double-clicks DWG-B1 again. If DWG-B1 is already open, the second double-click gives AutoCAD's "already open / read-only" question. Replacement for W48-01's first clause: "Start AutoCAD by double-clicking C:\ce_rc_vc7\DWG-B1_VC7.dwg in Explorer (START CHECK there). Then TYPE QNEW: a new blank drawing opens (template acadiso.dwt if W46 ran, otherwise the old test template; if a template question appears press Enter at its default; write which). This blank drawing is the import drawing." Replacement for W48-03's first clause: "first TYPE CLOSE with No on the import drawing; AutoCAD shows DWG-B1_VC7.dwg again (it stayed open since the start: title bar proof; do NOT double-click it again)."

**48-2. Delete "Click the MODEL tab ... (the command line says '<Switching to: Model>')".** A new drawing already opens in Model, so no such line appears and Codex may think a step failed. Replacement: "Check the Model tab is the active one (bottom-left); if a layout tab is active, click Model."

**48-3. CDDISCIPLINE: type the answer, do not rely on the default.** The prompt is "Set this drawing's discipline:" with Civil / Structural / cLear / cAncel, and its default depends on what the drawing already looks like. Replacement: "TYPE CDDISCIPLINE; at 'Set this drawing's discipline' TYPE Civil and Enter; write the '[CE] Current drawing discipline:' line."

**48-4. W48-02 asks for lengths the list does not print.** CDAUDITDETAIL lines carry H= (handle), FROM, TO, DIA and IL@PIT only (LinkService.RepairAudit.StoredReport.cs). Also "say what changed against W48" points at itself: the previous import was W38 (M = 56, and a short pipe H=103111 FROM=P8 TO=Unknown DIA=100). Replacement for that part: "write M and compare with W38 (M = 56); write every line that names P8 with its H, FROM, TO and DIA (the list has no length: take the length from the W48-01 results line 'The 1.x m pipe drawn from P8'); write whether any line reads FROM=P8 TO=P8. PASS = 0 'STORED BOTH ENDS' lines and no FROM equal to TO."

**48-5. W48-03: point Codex at the right tab, the 'Set' toggles, the warnings box, and remove the flat pipe afterwards.** The pipe window has tabs Pipe / Levels & Flow / Connections / Drawing / Schedule & Preferences. Both lines live on Levels & Flow: "Flow: FLAT (same inverts)" near the top, "Grade: FLAT (same inverts)" near the bottom (PipeEditWorkshopDialog.xaml lines 164 and 283). Each invert box has a 'Set' toggle and stays greyed until it is on. W45 recorded a design-warnings box after Start Pipe on a flat pipe. W48-04a later draws ANOTHER P10 to P9 pipe, so the flat one must go first, or the schedule row and the PIPEEDIT pick are ambiguous. Replacement text for W48-03 after the CD prompts:

   "In the New Pipe window (title bar first) click the tab 'Levels & Flow'. If an invert box is greyed, click its 'Set' toggle first. Type 18.500 in both invert boxes (TEST INPUTS). BEFORE Start Pipe: screenshot the tab and WRITE every line beginning 'Grade:' or 'Flow:'. Click Start Pipe. If a box 'This pipe has design warnings...' opens, write its text and click its OK button once. Press Esc ONCE. TYPE CDEDIT, click the new pipe line, in Edit Pipe click 'Levels & Flow' and WRITE every 'Grade:' and 'Flow:' line (the 'Pipe grade / Standard / Set my own' selector is NOT the line: write both), screenshot, CANCEL. Then remove the flat pipe: TYPE U ONCE (echo expected CDEDIT), TYPE U ONCE more (echo expected CD): the flat pipe is gone (screenshot). PASS = 'Grade: FLAT (same inverts)' seen in BOTH windows."

**48-6. W48-04a: name the real controls; no F2; fix the dead link.** The window has no "Custom"; W37 already walked this route. Replacement for the window part: "on 'Levels & Flow': click 'Set my own' beside 'Pipe grade' and type 100 in the '1 in' box; click 'I know one end — work the other out from the grade'; at 'The end I know' choose the P10 end; type 20.000 in its level box; WRITE the calculated level shown for P9 (W37 saw 19.91)." In the Pit Schedule step replace "(F2 allowed, Ctrl+A, 19.85, Enter)" with "(DOUBLE-CLICK the cell, Ctrl+A, type 19.85, Enter; never F2: if the cell is not in edit mode F2 runs CLEAN)". The P9 row is a pit row with its inlet level (W37: "P9 row ... IL inlet 19.91"). W37 footers: "Override enabled for linked row." then "Stopped overriding this row. The values you typed stay." Replace "go to W48-04" with "skip W48-04b (write it NOT TESTED: no marker) and go to W48-05".

**48-7. W48-04b: name the Yes/No box and say what PASS is.** W37 saw, after Save: "CE — Recalculate downstream inverts?" with Yes / No. Add: "If the box 'Recalculate downstream inverts?' opens, write its text and press Enter once (Yes, as in W37); if a preview window then opens, click Cancel. PASS = the red marker is gone after Save AND, at the U, the 19.85 level and the marker come back together AND, at the REDO, 19.91 returns and the marker goes again."

---

## W49 (Civil Undo/Redo routes; cap 69)

**49-1. Counts:** see C-1.

**49-2. The undo target X changes nothing, so several checks are empty.** "Change NOTHING ... and press SAVE" makes a CDEDIT step with no change. CE's reconcile and reactors only wake when something changed, so an empty X can pass while a real edit would fail, and W49-02's "whether the pipe change is back" has nothing to look at. Suggested replacement for X (it only changes the plan text of one pipe, no levels, so no cascade box):

   "X: TYPE CDEDIT, click the pipe line of 109ED4 (IO8 to P3) away from its label (zoom in first, BEFORE X); in Edit Pipe (title bar first) click the tab 'Drawing' and click the toggle 'Show grade in pipe text' ONCE; press Save. WRITE the pipe's label text on the plan before and after (with or without the grade). Each X flips it. The next U echoes CDEDIT and must flip the label back; REDO must flip it again."

   (I did not run this: if the toggle is missing or greyed for this pipe, fall back to the PIT placement the brief already names, and say so.)

**49-3. W49-01: the Inspector command is a switch.** `CDINSPECTOR` toggles the palette: typed while it is open, it CLOSES it. Add: "If the CE Inspector palette is NOT visible, TYPE CDINSPECTOR once (before X, never between U and REDO); if it is visible, type nothing."

**49-4. W49-02:** Ctrl+Tab needs the C-9 exception.

**49-5. W49-03: the click selection is lost.** Replacement: "TYPE (sssetfirst nil (ssadd (handent \"109768\") (ssadd))) (pit P2), then with NO Esc (SELECTION RULE) TYPE MOVE; base point 0,0, second point 300,0 (TEST INPUT)."

**49-6. W49-04 (ii) and (iii) name no objects.** Replacements: "(ii) TYPE PITEDIT, pick the pit C1 (body 10901C), change its number to C99 (TEST INPUT), Save." and "(iii) TYPE CD from the pit P10 to the pit P9 (both exist: W37, W45), on 'Levels & Flow' set both 'Set' toggles, inverts 18.500 and 18.400 (TEST INPUTS), Start Pipe, OK on any design-warnings box, Esc."

**49-7. W49-04 (i): name PIT's real steps** (PitCommand.cs): "'Specify pit insertion point:' click an empty spot; in the New Pit window type the number and cover level, click 'Continue placement'; at the label prompt click the label spot; at 'Click to place cover text (Enter = <...>):' click the cover-text spot; at '[CE] Pit placed. Pick the next pit, or press Esc to stop.' press Esc. Any other prompt: write it, Enter."

**49-8. W49-05: type MREDO's answer, do not click it.** Replace "TYPE MREDO ALL" with "TYPE MREDO; at 'Enter number of actions or [All/Last]:' type A and Enter (do not click the option)".

**49-9. W49-06: say what counts.** Add: "PASS = 'Everything has been redone'. EXPECTED (AutoCAD's rule, not a CE fault) = 'Nothing to redo' AND the line 'Automatic save to ...' appeared during the wait. FAIL = 'Nothing to redo' with no autosave line." Also C-13: SAVETIME back to 0 at once, even if you then stop.

---

## W52 (Structural Undo/Redo routes; cap 70)

**52-1. Counts and start drawing.** See C-1. The header says the first drawing is DWG-B1_VC7.dwg; W52-00 says DWG-S1_VC7_b.dwg. Replace the header's drawing name with C:\ce_rc_vc7\DWG-S1_VC7_b.dwg (85,871 bytes).

**52-2. The zoom hides the columns.** `(command "_.ZOOM" "_C" '(18000 8000) 14000)` shows heights 1,000 to 15,000 only, but TS1 and the C1 columns go in at y = 0 (19000,0 / 22000,0 / 25000,0), so the screenshots cannot show "the column AND its label go and come together". Replacement: `(command "_.ZOOM" "_C" '(20000 6000) 16000)` (heights -2,000 to 14,000; covers the columns, the pads, the FSF line and the R1 points). Add: "If the area is not empty, write what is there and carry on (move nothing)."

**52-3. Two size questions have no default, so Enter does not answer them.** At 9babe787: "Enter X size for PFC PF9:" and "Enter width for SF <mark>:" show no <default> (FoundationService.cs 4047, 4102). W52-02: replace "800 or Enter" with "type 800 at 'Enter X size...'; Enter at 'Enter Y size <same as X>:' and at 'Enter depth <0 to skip>:'". W52-03: replace "text Enter, width Enter, depth Enter" with "text Enter (if it says the mark already exists, Enter = Increment), width: type 300 (TEST INPUT), depth Enter". The insertion question is "Specify insertion point (center):" and the rotation is "Additional rotation around center <0>:".

**52-4. W52-05: there is no centre grip.** CE's footing grips (corners plus centre) exist only when the Settings value FoundationGrips is on (FootingGripOverrule.cs: "OFF by default"); Tim's CS_Settings.json has no FoundationGrips entry, so it is off. The pad then has plain AutoCAD polyline grips, and a click on the edge may pick a CE outline piece (W-2 says so). Replacement: "click the pad edge once (fresh screenshot) so grips show; click ONE corner grip; at '** STRETCH ** Specify stretch point or [Base point/Copy/Undo/eXit]:' press Enter ONCE so the line reads '** MOVE ** Specify move point...'; type @300,0 and Enter. Write the exact prompts and which object(s) moved (pad, label, outline)."

**52-5. W52-06: the button it hunts for is not on the ribbon.** At 9babe787 'Update drawings' exists only as the apply button inside the Sheets sync preview window (CeSheetsSyncPreviewWindow.xaml, IsDefault), and it writes sheet data. The ribbon shows a 'Sheets' button (CESHEETS), which opens the Sheets manager and can read other drawings in a project folder. Replacement: "look at the CE STRUC ribbon only and WRITE the button labels of any Sheets panel; do NOT click 'Sheets' or anything in it. Expected: no 'Update drawings' ribbon button = NOT PRESENT."

**52-6. W52-07 says "as in W52-01" but W52-01 is TS1, not C1.** Replacement: "TYPE C1: insertion 22000,0, Enter at 'Specify rotation angle <0>:', at the support text location TYPE 22600,300, at the text question ('Enter text for 'C' or <...>:' or 'Enter a number to append to 'C' ...') TYPE 2."

**52-7. W52-04 R1 switches OSMODE and CLAYER while it runs** (nearest/perpendicular snaps, its own layer) and puts them back at the end (RafterJoistCommands.cs CaptureSysvars/RestoreSysvars). Add: "A different OSMODE or CLAYER DURING R1 is expected; one AFTER R1 ends is a finding." Typed points are not affected by the snaps.

---

## W50 (SEE the Civil hunt faults; cap 70)

**50-1. Counts:** see C-1. Also C-12 below on what PASS means in a SEE pass.

**50-2. W50-01: three prompts with risky defaults.**
1. **Attach dialog:** add "under Insertion point untick 'Specify On-screen' and leave X 0, Y 0, Z 0; Scale 1".
2. **REFEDIT dialog:** add "choose 'Automatically select all nested objects', then OK".
3. **REFCLOSE defaults to SAVE.** Its prompt offers Save / Discard reference changes with Save as the default. One Enter writes the change into C:\ce_rc_vc7\DWG-B5_VC7.dwg on disk. Replacement: "TYPE REFCLOSE; at the Save/Discard question TYPE D and Enter (NEVER Enter alone); if a box warns that changes will be discarded, click OK once; write the lines."

**50-3. W50-02 and W50-03 lock a layer; line 7 forbids it.** Add to W50: "EXCEPTION: line 7 (c) LOCK NO LAYER is lifted for W50-02 and W50-03 only. SAVETIME is 0, so no autosave can run while the layer is locked; unlock it again at the end of each item." Use typed lines instead of palette clicks: lock `(command "_.-LAYER" "_LO" "<layer name>" "")`, unlock `(command "_.-LAYER" "_U" "<layer name>" "")`.

**50-4. W50-02: the LIST selection and the U echo.**
1. Replace "click its label once, TYPE LIST then Enter" with "TYPE LIST; at 'Select objects:' click the P2 label once, then Enter".
2. The U comes after PITSCHEDULE, which may leave its own undo step. Add: "If the U echo is PITSCHEDULE, TYPE U ONCE more and write both echoes (no more)."

**50-5. W50-04: F2, a new file on disk, and QSAVE.**
1. Replace "click inside an IL (Inlet) cell of any row, F2" with "DOUBLE-CLICK an IL (Inlet) cell of any row" (F2 outside a cell runs CLEAN).
2. Add: "This item creates ONE new file of yours in C:\ce_rc_vc7 (exception to line 7). If W50_readonly_copy.dwg already exists, use W50_readonly_copy_<HHmm>.dwg. Opening it may also print a '[CE] ... pipe(s) upgraded' line and write a PRE_C7 backup beside it: report only."
3. QSAVE adds nothing to BUG-464 and opens a save window. Suggest deleting the QSAVE sentence; if kept: "if a 'Save Drawing As' window opens, click Cancel at once".

**50-6. W50-05 runs after W53 in the chain.** If W53 passed, Tim IS the administrator: the Admin Dashboard button shows because he is admin, not because nobody is. Add: "If W53 ran earlier today, the BUG-476 'first colleague becomes administrator' case no longer applies on this PC: just write what the window shows."

---

## W51 (SEE S-01 FPFC size, S-04 FEDIT Esc, pad label height; cap 70)

**51-1. Counts:** see C-1 (header says "FIVE ITEMS W51-01 to W51-04"; the report says 01 to 05).

**51-2. W51-01: the real prompts** (FoundationService.cs at 9babe787), so nothing is "unlisted": "'Enter text <...>:' TYPE PF9; 'Enter X size for PFC PF9:' TYPE 800 (no default is shown); 'Enter Y size <same as X>:' Enter; 'Enter depth <0 to skip>:' Enter; 'Specify insertion point (center):' 18000,20000; 'Additional rotation around center <0>:' Enter." The second run's warning is exactly "Warning: Label 'PF9' already exists. Use anyway? [Yes/No/Increment] <Increment>:" and the line is "[FOUNDATION] Auto-incremented to 'PF10'." FEDIT asks "Select a footing to edit:".

**51-3. W51-02: the last U may hit the cancelled FEDIT.** The second FEDIT (Esc twice) can leave its own empty undo step. Add: "If the U echo names that cancelled FEDIT, write it and do NOT press U again."

**51-4. W50/W51 PASS meaning (C-12 for SEE passes).** These passes record faults the hunt predicted. Add to both: "Each item is PASS when its steps were carried out and the evidence written, whatever the drawing did; never write FAIL because a predicted fault appeared. Use FAIL only when a step could not be carried out the way the item says for a reason that is a CE fault (for example a crash). The SEEN LIST is the result for Tim."

---

## W47 (column grip with beam linking ON; cap 70)

**47-1. Counts:** see C-1.

**47-2. The refusal is a plain sentence, not the code.** At 9babe787 the beam route stops with LEGACY_LINKING_MUST_BE_DISABLED internally, but the command line shows only (BeamRefusalWording.cs 186): "Beam not placed: this drawing still has the old beam-linking switch on. Turn off Enable beam linking in CE Settings > Beam, then run the command again." The code word goes only to the Structural log. Replacement for the expected text in W47-02: "(expected exactly: 'Beam not placed: this drawing still has the old beam-linking switch on. Turn off Enable beam linking in CE Settings > Beam, then run the command again.'; the code LEGACY_LINKING_MUST_BE_DISABLED is in the Structural log, not on the command line: copy the log line that holds it, read only)". PASS = that sentence.

**47-3. Name the window and the tick.** Replacement for W47-01's first part: "TYPE CESETTINGS; open the Beam page and the tab 'Placement'; in the right-hand column the first tick box is 'Enable beam linking (move/erase beam, supports & text together)'. WRITE its current value (expected OFF: Tim's file holds \"LinkingEnabled\": false). Tick it; press Save (the buttons are Reset Defaults / Cancel / Save: never Reset Defaults)."

**47-4. Add the exception line of C-2 (W47).** Without it, line 3 and the SETTINGS RULE ("do not open the Settings window", "any difference = FAIL") forbid W47-01.

**47-5. W47-04 must run even past the cap, and its check must not be a raw hash.** The Save rewrites the whole file, so its size and SHA256 can differ from the start even when the tick is back OFF. Replacement for W47-04's check: "PASS = the tick reads OFF when the window is reopened AND, in PowerShell (read only), Select-String -Path $env:APPDATA\CE_STRUC_SUITE\CS_Settings.json -Pattern 'LinkingEnabled' shows false AND the other two settings files are byte-identical to the start. Write the Structural file's size and SHA256 for the record (a difference is expected). This item is done even if the cap is reached (C-13)." (The controller's copy in `C:\ce_rc_scratch\settings_pre_W47_controller\` is the safety net. A desk check after the run that LinkingEnabled is false again is worth adding to the chain.)

---

## Builders bj23 (Sun), bj24 (Mon), bj25 (Tue)

**B-1. The text queue3 appends contradicts these briefs.** Every job gets common.txt appended. It says "own branch from origin/master ... MERGE (never rebase) origin/master", "CE deep blue #1E5AA8 on light", "11 known failures", "TIM IS AWAY UNTIL MONDAY 28 SEP". The briefs say their overrides win, but merging origin/master into a branch based on `claude/rel-20261009g`/`f` would drag master changes into the draft PR. Add to each brief's CONTROLLER OVERRIDES: "(R6) Do NOT merge origin/master into your branch (the appended text says to: ignore it); your base is only the rel branch in R5. Ignore the appended '#1E5AA8 on light' line (superseded by INT-075) and its test-failure count (run the suites as R2 says and report the counts)."

**B-2. bj25 names a command that does not exist.** There is no CDSETTINGS command at 660487d1. The Civil Settings rows reach Tim through CivilSettingsView inside CEMANAGER > Settings (CeCivilSettingsBridge.cs). The old window `CDS` (AdvancedSettingsDialog.xaml) is a second, separate Civil settings window. Replacement for Tim's check steps: "open CEMANAGER, Settings, Civil page, find each box ...". The controller should also say in one line whether the CDS window is in or out of scope (I think out).

**B-3. bj25's grep lands on the wrong line first.** `grep -n "WINDOW ROWS FOR CODEX (Civil)"` matches line 40 of BUG_CARPARK.md (the 'Next BUG ID' summary) before the entry itself (about line 7118, headed "**Command / Area:** WINDOW ROWS FOR CODEX (Civil)"). Replacement: "find the entry whose line starts '**Command / Area:** WINDOW ROWS FOR CODEX (Civil)' (about line 7118, BUG-546)".

**B-4. bj24: references checked and right.** StripWidthMm (UserSettings.cs 1109), ScrewPileDiameterMm (1115), BraceLength MaxLengthMm / DefaultLengthMm (717, 721), TerrainSteps (111), AssumedPointLoadKN (1315) and LintelProposalSettings (class at 1164, values 1167-1199) all exist at 9babe787. The audit file and builder_rules.txt exist. Suggest adding the carpark entry at about line 7026 ("WINDOW ROWS FOR CODEX: R00_STRUC items 4, 30, 31, 32, 33 and 38") as the minimum list, so the run cannot finish with fewer than those six.

**B-5. bj23: the Civil light-theme lines are right** (LightTheme.xaml 14-16 AccentColor #1E5AA8, AccentHoverColor #164782, AccentSoftColor #E4EEF9; line 30 InfoColor #3B6EA8; line 35 RowLinkedBrush #D6EAF8). No 'follow' and no AutoCAD step in any of the three builders.

---

## Budget and stop lines (Codex 64% now; chain caps 66, 67, 68, 69, 70, 70, 70, 70)

1. **What will really run:** passes cost 1 to 2 points each (queue.log W31 to W45). From 64%, expect W46, W53 and W48, perhaps W49; W52, W50, W51 and W47 will most likely be skipped by their caps and need re-queueing. The order already puts Tim's two authorised changes (W46, W53) first, which is right.
2. **Off-by-one:** fix C-11, or a job can start at exactly its cap and spend its slot refusing.
3. **Put-back steps:** C-13 makes SAVETIME and the W47 tick safe whatever stops the run. With fix 46-2, W46 has no half-done menu edit left to strand.
4. **The caps match the stated stop lines** (66 / 68 / 70). The extra 67 for W53 and 69 for W49 are harmless.

---

## I did not check

1. **Nothing was run in AutoCAD.** Every prompt above comes from code at the two release commits and from the W37, W38 and W45 reports; the way AutoCAD prints keyword lists on screen may differ slightly from the code strings.
2. **Whether the start-up lines come from the current workspace only**, and whether removing the CE pull-down entries really takes the two menus off the menu bar (fix 46-2 point 3 is inferred from the file contents).
3. **The name of the Structural Settings page** that holds the 'Placement' tab (I inferred "Beam" from the refusal sentence).
4. **Whether the 'Show grade in pipe text' toggle** on pipe 109ED4 opens any extra question (fix 49-2), and whether an "older pipe" label question still appears for 109ED4 (the fixture note says it is not answered; no recent report mentions the question).
5. **Whether the zoom areas** in W47, W51 and W52 are empty in DWG-S1_VC7_b.dwg.
6. **The P2 label layer name**, CE's behaviour inside REFEDIT, and the exact REFCLOSE discard box wording.
7. **The Manager status line** about a newer Structural 1.0.117 (W50-05).
8. **`codex_usage.sh` and `daily_cap.sh`** beyond the skip test in queue3.sh.
9. **bj23's other line references** (help pages, CalculationsV2ViewModel, the Structural dialogs) and the content of the R00 audits.
10. **The registry location of the QNEW value:** the "Tim" profile's General key has no QnewTemplate entry today, so the old value is taken from Tim's Set A question 2, not read from the registry.
