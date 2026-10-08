# Bug hunt 3, cross-cutting (headless run 2), Fri 9 Oct 2026

**Written 09:21 to 09:50 Melbourne time (PC clock). Code reading only.** Nothing was built, nothing was run in AutoCAD or accoreconsole, nothing was seen in a window. "The code shows" means I read it at the release commit named. "I think" means my judgement, not read.

**Commits read (with `git show` / `git grep`, nothing checked out):**
1. **Civil and Manager installed:** `origin/claude/rel-20261009e` = 1200744d (Civil 3.0.41 / Manager 1.1.41).
2. **Civil and Manager next:** 319ba688 (the branch tip `rel-20261009g` is now 660487d1 = 319ba688 plus the version stamp only). Civil and Manager file:line below are at 319ba688. Between 1200744d and 319ba688 only 18 files changed and none in `Shared/`; of the files cited here only `Modules/Drainage/Models/UserSettings.cs` moved (its lines after 90 are 7 higher than installed).
3. **Structural installed:** `origin/claude/rel-20261009f` = 9babe787 (Structural 1.0.110).

**Also read (live, read only):** the CE_SHARED and helper files inside the three installed bundles in `%APPDATA%\Autodesk\ApplicationPlugins` (file hashes and version numbers).

**Not reported because already in `C:\CE_PLAN\BUG_CARPARK.md`:** BUG-360 (unnamed window controls, class names in grid rows, P:handles in group headers), BUG-201 (PIT placement diagnostic line), the FEDIT "Selected entity is not linked" line, the FST status-line log tail, BUG-453 (the "Settings page for it is still to be built" sentence for CSLEVELCARRY / CSROOFSETOUT / CSFLOORSETOUT), the missing Settings rows for `grade.showGradeCheckMarkerOnPlan` (C-24 finalizer) and `xcivilImport` (C-27 finalizer), BUG-255 (Edit Pipe size strip uses a fixed 600 mm cover), BUG-316 / BUG-299 (two Structural settings files), BUG-482 ("not sent anywhere"). The Manager start-up error lines are already HUNT-M-15 in the run 1 Manager report.

---

## Counts

1. **Jargon or untrue command-line sentences:** 12 findings.
2. **Ribbon, tooltip and window words (plain name AND command, Tim 9 Oct):** 8 findings.
3. **Blue in windows, themes, icons and printed sheets:** 14 findings (2 of them borderline).
4. **New Settings values with no plain-English label:** 5 findings.
5. **One Settings value read from two places that can disagree:** 4 findings.
6. **CE_SHARED and other shared files (first loaded wins):** 3 findings, plus one check that came out clean.

**Total: 46 findings.** Highest value first in my view: 1.1, 1.2, 3.1 to 3.3, 3.7, 3.8, 5.1, 5.4, 2.1, 4.3.

---

## 1. Command-line sentences that are jargon or untrue

1. **1.1 Structural prints about 44 lines of program words at every AutoCAD start (MEDIUM).**
   - **The code shows:** `Modules/Structural/Plugin.cs:232-286` (9babe787) writes, every start: "Build: CE_STRUC_SUITE" (:233), "Assets root: <folder on this PC>" (:234), "Native mode: structural command runtime is now C#." (:248), "Bundle/install-path diagnostics" (:256), "Admin hub + consolidated diagnostics, runtime health, and workspace recovery" (:257), "fleet health, version control" (:258), "unified debug toggle" (:276), "(Visibility1 = BRACING TRUSS)" (:281), "Exception-first Excel to schedule workflow with corpus-backed review" (:286). Civil prints two short lines (`Modules/Drainage/PluginInitialization.cs:507-510`).
   - **Fix:** keep only "[CE STRUC] 1.0.110 loaded. Type CE_HELP for the command list." (the Civil pattern).
2. **1.2 The same start-up list names four commands that do not exist (MEDIUM, untrue).**
   - **The code shows:** `Plugin.cs:277` advertises BTXT2MT and BMT2TXT, `Plugin.cs:273` advertises SBL and BREAKLINE. No command of those names is registered anywhere in Structural 9babe787 (BTXT2MT and BMT2TXT are `"hidden": true` registry rows only, `command-registry.json:2225, 2265`). Typing them would give AutoCAD's "Unknown command". `Plugin.cs:270` also offers MR/CR, which only Civil registers (`Modules/Drainage/Commands/CopyRotateCommands.cs:24-30`).
   - **Fix:** removing the list (1.1) removes these; otherwise delete the four names.
3. **1.3 "Selected entity is not a pit block." (LOW-MEDIUM, jargon).**
   - **The code shows:** PITEDIT `Modules/Drainage/Commands/PitEditCommand.cs:93, 126` (Tim's own DAY1 step 5 command); CDRUNSOLVE `RunSolveCommand.cs:253, 277, 424, 457`; PITDELETE `LinkCommands.cs:67, 84`. Also `Services/SurveyService.cs:96` "Selected entity is not a block reference."
   - **Fix:** "That is not a CE pit. Pick a pit." (and "That is not a block. Pick a block.").
4. **1.4 CDANNOTATIONEDIT (on the ribbon) uses three code words (LOW).**
   - **The code shows:** `AnnotationEditCommand.cs:38` "Select an MText, DBText, or block entity."; `:57` "That entity is a CE compound root - use CDEDIT to edit it."
   - **Fix:** "Pick a CE label, text or block." / "That is a CE pipe or pit: use CDEDIT to change it."
5. **1.5 CDCHECK (DAY1 step 12) can print "spine" and "snapshot" lines (LOW).**
   - **The code shows:** `Commands/SpineCheckCommand.cs:132` "{n} record(s) failed the spine gate", `:135` "Stored spine snapshot unreadable", `:137` "Stored snapshot in the drawing: {n} objects (live now: {m})". Line 137 prints whenever a stored record exists.
   - **Fix:** "{n} items could not be checked; see the CE log." / "The check CE saved in this drawing earlier lists {n} objects; the drawing now has {m}."
6. **1.6 CDIMPORTCOMPARE (on the ribbon, "Compare Import") ends with a cache sentence (LOW).**
   - **The code shows:** `Commands/LinkCommands.ReadOnlyAudit.cs:36` "cached ownership Unknown"; `:40` "checking a snapshot of the stored CE cache, not verified current ownership. Pending changes have not been synchronised; no repair performed."
   - **Fix:** "This compares the pits and pipes CE saved in this drawing. Nothing was changed."
7. **1.7 CDIMPORTXCIVIL refusal says "No entities inserted." (LOW).**
   - **The code shows:** `Commands/LinkCommands.ImportXcivil.cs:148`.
   - **Fix:** "Nothing was drawn. The earlier import is left as it was."
8. **1.8 CDSLABIMPORT (on the ribbon) uses "entity", "node" and "handle" (LOW).**
   - **The code shows:** `Commands/SlabCommand.cs:79` "Selected entity is not a polyline."; `:422` "{n} drainage node(s) inside boundary". CDSLABEDIT (hidden) `:1210`, `:1231` "slab boundary polyline handle".
   - **Fix:** "That is not a polyline. Pick the slab outline." / "{n} pits inside the outline".
9. **1.9 Window status and dashboard lines with "entity", "handle", "transaction" (LOW).**
   - **The code shows:** Pit Schedule status `ViewModels/PitScheduleViewModel.cs:1266` "Pipe entity was not found in this drawing.", `:1275` "Pipe entity is not available."; Design Check Dashboard items `Services/LinkService.RepairAudit.Analysis.cs:496` "(handle …) contains invalid ID characters", `:533` "has no matching drawing entity (handle …)", `:567` "Schedule and drawing entities are in sync.", `:440` "Circular dependency … [cycle]"; repair result `LinkService.RepairAudit.Apply.cs:149` "in one drawing transaction".
   - **Fix:** use the pit or pipe name ("P7", "P3-P4"), "pipe", "drawing", and "in one step (one U takes it back)".
10. **1.10 Structural prompts with "entities" and "database" (LOW).**
    - **The code shows:** CE_INSPECT `Commands/InspectCommands.cs:27` "Select entities to inspect", `:32`, `:75`; joint swap `Services/JointDraftingService.cs:128` "Select CJ or SSC joint entities to swap"; bored pier marker `Services/NativeBoredPierService.cs:187` "Selected entity must be a block."; XRL `Services/NativeXrefLayerService.cs:45, 55, 130` "XREF entities"; MTS `Commands/LegacyPortCommands.cs:236` "Updated entities …, dimstyles …"; `Services/DrawingSafetyService.cs:28` "drawing database not available."
    - **Fix:** "objects", "Xref objects", "dimension styles", "This drawing is not ready; try again."
11. **1.11 Raw Windows error text shown straight on the command line (LOW-MEDIUM).**
    - **The code shows** (count of command-line lines that print the program's own error text): Civil 16, Manager 5, Structural 71. Examples: `Modules/Drainage/Commands/PipeEditCommand.cs:253` "Error during CDEDIT: {error}"; `CdCommand.SamePlanBreak.Atomic.cs:147`; `CopyRotateCommands.cs:176, 255, 466`; Manager `Commands/PluginManagerCommands.cs:255`, `Services/CeBlocksInsertService.cs:196`, `Services/CeBlocksPaletteService.cs:26`; Structural `Plugin.cs:465` "Runtime guard check failed: {error}". (Manager menu and telemetry lines are HUNT-M-15, not repeated.)
    - **Fix:** one plain sentence saying what did not happen and what to do, with "the details are in the CE log".
12. **1.12 Manager start-up and status bar say "[Modern]" (LOW).**
    - **The code shows:** `Modules/Manager/Plugin.cs:162` "[CE_SUITE_MANAGER] v{version} [{BuildType}] loaded."; DAY1 step 2 quotes "CE MANAGER v1.1.40 [Modern]" on the status bar.
    - **Fix:** drop the bracket, or say "for AutoCAD 2027".

---

## 2. Ribbon, tooltip and window words (Tim 9 Oct: plain name AND the AutoCAD command during the transition)

1. **2.1 The "Show AutoCAD command names" switch is not built in any of the three releases (MEDIUM).**
   - **The code shows:** no setting or code for it at 1200744d, 319ba688 or 9babe787 (searched for the switch and for any command-name suffix code). Tim's ruling is INT-075 (decision log, 9 Oct about 08:30), filed in IDEAS_INBOX.
   - **Fix:** build it as filed: plain name first, "(COMMAND)" after it, switch on by default.
2. **2.2 Civil ribbon: 21 of 64 visible buttons show the plain name only (LOW-MEDIUM).**
   - **The code shows:** button text is the registry label (`Shared/CE_SHARED/Services/RibbonBuilder.cs:135, 273`); only the tooltip title adds the command (`:452`). Labels without the command in `Modules/Drainage/Assets/Config/command-registry.json`: CEBLOCKS "CE Blocks" (:5), CDINSPECTOR "Inspector" (:74), PITSCHEDULE "Pit Schedule" (:211), CDHUB (:238), CDDASHBOARD (:247), CDCALC "Calculations" (:256), CDMANAGER (:317), CDIMPORTCOMPARE (:334), CDEXPORTENTITIES (:342), CDREPAIR "Repair Center" (:350), CDDISCIPLINE (:359), CDFEEDBACK (:367), CDHELP (:383), CESTARTHERE (:391), CDIMPORTXCIVIL (:437), CDIMPORTLANDXML (:445), CDCHECKDWG (:463), CDLPD (:764), CDCHECKCURRENT (:789), CDDESIGN "Design setup" (:1118), CDRAINFALL (:1126). The other 43 already read like "Pipe Layout (CD)".
   - **Fix:** add "(COMMAND)" to these 21 labels, or let the switch in 2.1 add it.
3. **2.3 Manager ribbon: all 10 visible buttons show the plain name only (LOW).**
   - **The code shows:** `Modules/Manager/Assets/Config/command-registry.json:5-66` ("Suite Manager", "Health Check", "Support Bundle", and the rest).
   - **Fix:** as 2.2.
4. **2.4 Structural ribbon: 312 of 313 visible buttons show the plain name only; the command is only in the tooltip body (LOW-MEDIUM).**
   - **The code shows:** `Modules/Structural/Services/RibbonCommandHubService.cs:802-804` (button text = label), `:1021-1025` (tooltip title = label, body "Type: X"), large buttons `:38-48` (for example "Beam" for command 1, "Footing" for FPFC). Structural does not use CE_SHARED for its ribbon (`CE_STRUC_SUITE.csproj:158-166`).
   - **Fix:** as 2.2, in `RibbonCommandHubService`.
5. **2.5 Three window titles show ONLY the code word (LOW).**
   - **The code shows:** `Modules/Drainage/Dialogs/CalculationsV2Dialog.xaml:1` "Creative Engineering | CDCALC"; `Modules/Drainage/Dialogs/CheckDwgResultWindow.xaml:4` "Creative Engineering | CDCHECKDWG results"; Structural `Modules/Structural/UI/MarkupWindow.xaml:8` "CEMARKUP".
   - **Fix:** "Calculations (CDCALC)", "Check consultant drawing (CDCHECKDWG)", "Markup review (CEMARKUP)".
6. **2.6 No window title carries its command (LOW).**
   - **The code shows:** 41 Civil, 2 Manager, 1 Help Centre and 43 Structural window title lines, none with "(COMMAND)". Examples: `PitScheduleDialog.xaml:5` "Pit Schedule", `CdRepairDialog.xaml` "Repair Center", Structural `UI/FstManagerWindow.xaml:7` "Foundations manager" (typed FST), `UI/Dialogs/CeSheetsWindow.xaml` "Drawing sheets" (CESHEETS), `UI/LayerManagerWindow.xaml` "Drawing standards".
   - **Fix:** append the command, driven by the same switch as 2.1.
7. **2.7 Code words in ribbon names and tooltips (LOW).**
   - **The code shows:** Civil registry "Export Entities" label and tooltip "Export entity geometry …" (:342), CDANNOTATIONEDIT tooltip "the compound entity" (:309), CDDASHBOARD tooltip "network topology … schedule drift" (:247), CDREPAIR "sync, rebuild, upgrade and diagnostics" (:350); Manager CEMANAGERREFRESH "upload queued telemetry, and reload dashboard data" (:24), "Survey Intake Review" (:30), "Support Bundle" (:66); Structural XCLMTXT / EXCELMTEXT "Exception-first Excel to schedule workflow" (:1844, :1865), MR / CR / MOVEROT / COPYROT "Run legacy transform tool …" (:4536, :4392, :4518, :4356), XRL "Analyze and normalize xref entities to target layer" (:4829), CEADMIN "Central admin and diagnostics entrypoint" (:315).
   - **Fix:** plain wording, for example "Save pit and pipe shapes to a file (CDEXPORTENTITIES)", "Move all Xref objects onto the Xref layer (XRL)", "Move and rotate (MR)".
8. **2.8 Code words inside windows that BUG-360 does not cover (LOW).** BUG-360 is about hidden control names; these are words a drafter reads.
   - **The code shows:** CE Inspector rows "Handle" and "GIO Handle" (`Modules/Drainage/Controls/InspectorPanelControl.xaml:266, 321`) and "full-detail snapshot" (`:89`); New Pipe option "Use single pipe entity" (`Dialogs/CdDialog.xaml:469`); Settings tooltip "LPD anchor node" (`Dialogs/CivilSettingsView.xaml:162`); Help "Command registry" and "Rebuild refreshes caches" (`Dialogs/CdHelpDialog.xaml:145, 94`); column "Entity" (`Dialogs/ProposalPreviewDialog.xaml:72`); column "Label handle" (`Dialogs/SlabEditDialog.xaml:132`); Structural Settings tooltip "seed the store" (`UI/Dialogs/CeSettingsDialog.xaml:142`), XCLMTXT "draft snapshot" (`UI/Dialogs/XclmTxtDialog.xaml:597`).
   - **Fix:** drop the handle rows (or show the pit or pipe name), "Draw as one pipe", "LPD pit", "List of commands", "Rebuild re-reads the drawing", "Object".

---

## 3. Blue (Tim INT-075 Batch 3 item 8: "ideally no blue please our colours are gold, black and white /grey"; the deep blue #1E5AA8 of 4 Sep is superseded)

1. **3.1 Every Civil window in a light AutoCAD uses blue as its main colour (MEDIUM).**
   - **The code shows:** `Modules/Drainage/Themes/LightTheme.xaml:14` AccentColor #1E5AA8, `:15` hover #164782, `:16` soft #E4EEF9 (used for selected rows and menus, `:288, :692, :745, :787, :906, :930`).
   - **Fix:** light accent in black or charcoal with gold highlights; soft fill in warm grey.
2. **3.2 Other blues in both Civil themes (LOW-MEDIUM).**
   - **The code shows:** light `LightTheme.xaml:30` Info #3B6EA8, `:35` linked row #D6EAF8, long-section chart `:24-26` (#0277BD, #4FA8DC, #4A7C90); dark `DarkTheme.xaml:25-27` chart (#4FC3F7, #8BD7FF, #6A9FB5), `:31` Info #6B8FBF, `:36` linked row #132E3D.
   - **Fix:** grey or gold family. I think the long-section water line is the one place Tim might accept blue: ask him with a picture rather than assume.
3. **3.3 Manager windows: blue accent (MEDIUM).**
   - **The code shows:** `Modules/Manager/UI/Themes/Theme.Base.xaml:17-19` and `Theme.SwissModern.xaml:17-19` (#1E5AA8, #164782, #E4EEF9), used for borders and buttons (for example `UI/Pages/DrawingRepairPage.xaml:85`, `UI/Pages/ProjectQaPage.xaml:71`).
   - **Fix:** as 3.1.
4. **3.4 Structural light editor theme: blue accent (MEDIUM).**
   - **The code shows:** `Modules/Structural/UI/Themes/StructuralEditor.Light.xaml:12-14` (#1E5AA8, #164782, #E4EEF9).
   - **Fix:** as 3.1.
5. **3.5 Help pages: blue accent (LOW).**
   - **The code shows:** Help Centre (shared) `Shared/CE_SHARED/Help/HelpCentreView.xaml.cs:311` light #1E5AA8; Civil help pages `Modules/Drainage/Assets/Help/help-pages.js:111` accent #1E5AA8; Civil guide `Modules/Drainage/Assets/Help/ce_cvl_guide.html:22` (--blue #5b9bd5), `:207`, `:305` (opened by Help and What's New, `Services/HelpLauncher.cs:32`).
   - **Fix:** gold or charcoal.
6. **3.6 The "Start Here" ribbon dot is blue on a light ribbon (LOW).**
   - **The code shows:** `Shared/CE_SHARED/Services/RibbonBuilder.cs:206` (gold on dark, #1E5AA8 on light).
   - **Fix:** gold on both, or black on light.
7. **3.7 406 of the 410 light-ribbon icons are drawn in #1E5AA8 (MEDIUM).**
   - **The code shows:** `Shared/CE_SHARED/Resources/Icons/V3/light/*.png` (pixel colour measured: #1E5AA8), colour recorded in `approved-coverage.json:8` ("light": "#1E5AA8"), chosen whenever AutoCAD is in light mode (`Services/CeRibbonIconCatalog.cs:648`). Tim's Batch 3 item 14 asks for FINAL ribbon pictures before the colleague release.
   - **Fix:** redraw the light set in black or charcoal (gold accent if wanted) as part of the final pictures.
8. **3.8 The Civil computations sheet prints the practice name and its rule line in blue (MEDIUM, goes onto paper and PDF).**
   - **The code shows:** `Modules/Drainage/ViewModels/CalculationsV2ViewModel.cs:906` (#1E5AA8), used at `:926, :929, :933, :972`.
   - **Fix:** black, or the office gold if Tim wants colour on the sheet.
9. **3.9 Water tank windows draw the tank outline preview in blue (LOW).**
   - **The code shows:** `Modules/Drainage/Dialogs/WaterTankDialog.xaml:232`, `Dialogs/WaterTankPlanBlockPickerDialog.xaml:52` (#1E5AA8).
   - **Fix:** use the theme text colour.
10. **3.10 Structural windows and reports with hard-coded blues (LOW-MEDIUM).**
    - **The code shows:** hatch presets `UI/Dialogs/CeHatchPresetDialog.cs:86, 210, 343` (#2563EB); notes `UI/Dialogs/NoteEntryDialog.xaml.cs:309, 532` and `NotesBrowserDialog.xaml.cs:572, 777` (#0078D4); RC beam picker `UI/Dialogs/RCBeamPickerDialog.xaml:19` (#2563EB); RC member info line `UI/Dialogs/RCMemberDialog.xaml.cs:274` (#1E40AF); checklist suggestions `UI/Dialogs/ViewSuggestionsDialog.xaml.cs:219`; time reports `Core/Reports/ReportManager.cs:572, 575, 581, 771-778` (#0078D4, #00BCF2); notes export `Services/NotesExportService.cs:55` (#1a73e8).
    - **Fix:** theme accent (after 3.4 is gold or charcoal).
11. **3.11 Structural B-bracing icons are bright blue (LOW).**
    - **The code shows:** `Modules/Structural/Resources/Icons/commands/cmd_bb_16.png`, `cmd_bb_32.png`, `readable_cmd_bb_16.png`, `readable_cmd_bb_32.png` (measured #1764DC / #0D3CB8), used by BB (`Assets/Config/command-registry.json:2633`).
    - **Fix:** redraw in the CE family colours.
12. **3.12 Civil spot level icon is blue (LOW).**
    - **The code shows:** `Modules/Drainage/Resources/Icons/commands/dimension_16.png`, `dimension_32.png` (measured #416EA1 / #1565C0), used by CDSL and four other buttons (`command-registry.json:61, 138, 146, 297, 305`).
    - **Fix:** redraw.
13. **3.13 Borderline: dark slate in Structural dark theme and very dark navy icons (LOW, I think).**
    - **The code shows:** `Modules/Structural/UI/Themes/Theme.SwissModern.Dark.xaml:8-10` (#1B2430, #18212C, #2C3A4A); icons `cmd_sl25*_16/32.png` (#121E30).
    - **I think:** these read as near-black, not blue. Only change if Tim says they look blue.
14. **3.14 Borderline: the pit snap glow in the drawing is light blue (LOW, ask Tim).**
    - **The code shows:** `Modules/Drainage/Services/SnapTargetFeedback.cs:100` (110, 190, 255).
    - **I think:** Tim's rule was about windows and colours of the CE look; this is a temporary glow in the drawing. Ask before changing.

---

## 4. New Settings values with no plain-English label

1. **4.1 Civil "speed in a pipe leaving a pit" (1.5 recommended / 2.0 limit m/s): no row on the Settings window (LOW-MEDIUM).**
   - **The code shows:** `pipeSpeed.pitOutletRecommendedMs` and `pitOutletLimitMs` (`Modules/Drainage/Models/UserSettings.cs:1665, 1669`, added 8 Oct, INT-068 item 2). The Settings window code (`ViewModels/AdvancedSettingsViewModel.cs`, `ViewModels/SettingsValueCatalog.cs`, the settings views) never refers to them; only CDRULES names them in its own output (`Commands/RulesCommand.cs:248`).
   - **Fix:** a Design-tab row "Pipe leaving a pit: recommended speed / limit (m/s, AS/NZS 3500.3 5.4.11.2(d))" plus its catalogue entry.
2. **4.2 Civil detention-pipe minimum grade (1 in 200 from 225 mm): no row (LOW-MEDIUM).**
   - **The code shows:** `detention.minDetentionPipeGradeRatio` and `minDetentionPipeGradeFromDiameterMm` (`UserSettings.cs:1517, 1521`, INT-068 item 3, rule R-32); read only by `Rules/RulebookValues.cs`.
   - **Fix:** row "Flattest detention pipe: 1 in N, for pipes this size and larger (mm)".
3. **4.3 Structural footing width offered by FADOPT (300 strip / 300 beam / 150 screw pile): no Settings row and no label (MEDIUM, command is live).**
   - **The code shows:** `FootingWidth.StripWidthMm`, `BeamWidthMm`, `ScrewPileDiameterMm` (`Modules/Structural/Models/UserSettings.cs:1109, 1112, 1115`), read by `Services/FoundationService.cs:31-33`. CESETTINGS (`UI/Dialogs/CeSettingsDialog.xaml.cs`) never refers to the group, and it is not in the plain-name list (`Services/SettingsService.LoadRecovery.cs:1261` onward), so any start-up or recovery line names it by splitting the code name: "Footing width: strip width mm" (`LoadRecovery.cs:821-834`).
   - **Fix:** a CESETTINGS row "Strip footing width offered when unknown (mm)" (and the other two), plus plain names in the list.
4. **4.4 Structural lintel and framing legend groups: no row, no label; the lintel tolerances are office-only (LOW, commands are OFF).**
   - **The code shows:** `LintelProposal` (`UserSettings.cs:1164-1224`: 600 mm smallest opening, 150 mm offset, 350 mm two faces, 2 degrees, …) and `FramingLegend` (`:1048-1099`). CESETTINGS does not read them. `Services/LintelProposalService.cs:59` reads the office value only; Tim said the lintel tolerances are "different depending on the job" (INT-075 Set A 8, desk interpretation: office default plus job override), and I found no job override in the code. `FramingLegend.NewLayerColourIndex` defaults to 7 (white) (`:1060`); I think that sits badly with INT-077 item 1 ("never white or colour 7", said about Civil layers).
   - **Fix:** rows with plain names before these commands are switched on; a per-job value for the three lintel tolerances; a non-white office colour for the legend layer.
5. **4.5 29 Structural Settings groups are never read by the CESETTINGS window (LOW, record).**
   - **The code shows:** `CeSettingsDialog.xaml.cs` never refers to SbeamPicker, BraceLength, ReoBars, CommandHub, CeSheets, Migration, LineStyles, TieDowns, LevelCarry, Slabs, FoundingNote, StructuralComputations, WindClass, LoadPath, RoofPointLoads, RoofSetout, FootingWidth, LintelProposal, FramingLegend, FloorSetout, MemberSchedule, FoundationPlan, FoundationGrips, BasementWall, FoundationProposal, PumpPit, BoredPierPlan, Layouts, PlanLevel (`UserSettings.cs:21-74`). Some may have their own window: NOT checked.
   - **Fix:** a short list of which ones a drafter must be able to change, then rows for those (Settings-first rule R-00).

---

## 5. One Settings value read from two places that can disagree

1. **5.1 Minimum pipe cover: CDRULES uses council, then project, then office; the Inspector and the dashboard use the office value only (MEDIUM).** Same kind as BUG-255 but in other places.
   - **The code shows:** CDRULES `Modules/Drainage/Rules/RulebookValues.cs:210-220`. CE Inspector network summary and pit cover row `Services/InspectorPaletteService.cs:2335, 3036`; dashboard and repair checks `Services/LinkService.RepairAudit.Analysis.cs:191, 251`. Those four read `DesignStandards.MinimumCoverDepth` and fall back to 600 mm, while the Settings default is 300 mm (`Models/UserSettings.cs:1174`).
   - **Example:** a council job with a 450 mm council minimum and the office 300: a pit with 350 mm cover is OK in the Inspector and a warning in CDRULES.
   - **Fix:** all four read the resolved rulebook value (the BUG-255 cure, applied here too).
2. **5.2 Pipe speed limit: the Inspector and the dashboard use the office maximum (falling back to 3.0 m/s); CDRULES uses the per-material scour figures (MEDIUM).**
   - **The code shows:** `InspectorPaletteService.cs:3207`, `LinkService.RepairAudit.Analysis.cs:37, 250`, `LinkService.RepairAudit.InvertPropagation.cs:156` read `MaximumPipeVelocity ?? 3.0`; the Settings default is 6.0 (`UserSettings.cs:1163`); CDRULES `RulebookValues.cs:184-191` uses `ScourVelocityByMaterial` first.
   - **Fix:** one speed reader shared by the Inspector, dashboard and CDRULES.
3. **5.3 Fall-back numbers in code that differ from the Settings default (LOW).**
   - **The code shows** (these only bite when a Settings group is missing or blank in the file, so I think rarely): concrete joint label height 150 in code vs 250 in Settings (`Commands/CdJointCommand.cs:116, 151, 172` vs `UserSettings.cs:1431, 1434`); text offset 0 or 400 vs 70 (`CdCommand.cs:677, 964`, `CdCommand.SamePlanBreak.cs:397`, `Services/PipeCreationService.cs:292`, `Services/XcivilPipeInsertionService.cs:148`, `Services/LinkService.CloneRegeneration.cs:139` vs `UserSettings.cs:796`); invert mask gap 0 vs 70 (`Services/TextService.cs:67` vs `:621`); longest pipe run 0 vs 80 m (`Services/LinkService.FlatPipeRepair.cs:37` vs `:1254`).
   - **Fix:** take the fall-back from the Settings model's own default (one number per value).
4. **5.4 The job timer is set in two files, and Civil and Structural each run their own timer in every drawing (MEDIUM, I think visible).**
   - **The code shows:** Civil `CD_Settings.json` jobTime: user name, idle minutes 5, auto resume, data folder, status-bar timer (`Modules/Drainage/Models/UserSettings.cs:154-177`); Structural `CS_Settings.json` General: the same five (`Modules/Structural/Models/UserSettings.cs:218-236`, labelled "Pause timer after (minutes)" and "Show status bar timer" in `SettingsService.LoadRecovery.cs:1269, 1273`). Both start a timer at load with no check for the other (`Modules/Drainage/Services/CivilJobTimeService.cs:28`; `Modules/Structural/Services/CeToolsInitializer.cs:63`). Civil finds and saves its own time-log folder (`Services/CivilJobTimeSettings.cs:76-90`).
   - **I think:** a drafter who changes "Pause timer after" in Structural Settings still gets Civil pausing at 5 minutes, two status-bar timers may show, and the two time logs can land in different folders. Not seen.
   - **Fix:** one owner for the timer and its five values (Tim's INT-076 item 2 keeps naming by user; that stays).

---

## 6. CE_SHARED and other shared files (first loaded wins)

**Checked and clean:** the installed Civil and Manager bundles carry byte-identical CE_SHARED.dll in all three lanes (Legacy d4fd28e3…, Net8 487261d0…, Modern ba80d429…, all dated 9 Oct 08:35-08:36). Structural carries none and does not use CE_SHARED (`Modules/Structural/CE_STRUC_SUITE.csproj:158-166, 379-380`). A Manager release build refuses a CE_SHARED that is not the approved Civil one (`Modules/Manager/CE_SUITE_MANAGER.csproj:175-216`), and approval is a pair (`Services/CeApprovedReleaseService.cs:136`). No CE_SHARED source changed between 1200744d and 319ba688.

1. **6.1 CE_SHARED's identity number never changes, and nothing at start-up notices two different copies (LOW).**
   - **The code shows:** `Shared/CE_SHARED/CE_SHARED.csproj:15` AssemblyVersion 1.1.0.0 (fixed). I found no start-up check in Civil or Manager that compares the CE_SHARED AutoCAD actually loaded with the one in its own bundle.
   - **I think:** a PC can only get mixed copies if Civil and Manager come from different releases (for example a half-finished update, BUG-478). Then AutoCAD silently uses whichever loaded first.
   - **Fix:** at start, Civil and Manager compare the loaded CE_SHARED file with their own copy and print one plain line if they differ ("CE Civil and CE Manager are from different releases: run the CE installer again.").
2. **6.2 AutoCAD 2022-2024 lane: Civil and Structural carry different versions of seven Microsoft helper files (LOW, I think).**
   - **Read on disk (installed bundles, Legacy folder):** System.Memory (Civil 4.0.5.0 / Structural 4.0.1.2), System.Buffers (4.0.5.0 / 4.0.3.0), System.Runtime.CompilerServices.Unsafe (6.0.3.0 / 6.0.0.0), System.Threading.Tasks.Extensions (4.2.4.0 / 4.2.0.1), System.Numerics.Vectors (4.1.6.0 / 4.1.4.0), System.IO.Packaging (6.0.0.0 / 6.0.0.1), Microsoft.Bcl.AsyncInterfaces (10.0.0.1 / 8.0.0.0). The Net8 and Modern lanes have no such differences; Newtonsoft, ClosedXML, Serilog and the rest are identical.
   - **I think:** in AutoCAD 2022-2024 the first plugin to load one of these decides which copy the other gets, or both load side by side. Not tested on a 2024 PC.
   - **Fix:** align the package versions between Civil and Structural for the Legacy lane, then compare hashes in the release check.
3. **6.3 A CE_SHARED note tells builders the wrong thing (LOW, builders only).**
   - **The code shows:** `Shared/CE_SHARED/Services/CeUnifiedHostGuard.cs:24` says each of the three bundles (CVL, STRUC, Manager) ships its own CE_SHARED. Structural ships none (6, checked and clean).
   - **Fix:** correct the note.

---

## What I did NOT check

1. **Nothing was looked at in a window or in AutoCAD.** Every colour is from the code and from icon pixels, not from a screenshot.
2. **Lisp, DCL, CUIX menu text and the help HTML text** were not read for jargon (only the help colours).
3. **Structural windows other than CESETTINGS** were not read for Settings rows (4.5).
4. **Manager Settings:** no new Manager Settings values were added since 1 Oct (commit log), so heading 4 has no Manager item.
5. **The jargon scans are word searches** (entity, handle, node, transaction, snapshot, cache and similar) over lines that print to the command line or a window; a sentence with jargon that avoids those words would be missed.
