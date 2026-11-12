# Structural bugs the installed code already appears to fix, none yet seen working in AutoCAD

**Written Fri 13 Nov 2026 by lane trust-struc-mgr-plan, from reading Structural 1.0.126 (commit 8de95c34) for the 32 Structural core tool notes (`04_REFERENCE\core-tool-notes\structural\`). Nothing here was run in AutoCAD. No status in `BUG_CARPARK.md` was changed.** Candidates came from `areas\trust-run\BUGS_BY_STRUCTURAL_CORE_TOOL.md` and the carpark.

---

# FOR TIM

1. **How many:** 45 lines across the four tool families. A few bugs appear under two families (BUG-1077 under beams and Help; BUG-424, 428, 472 and 473 in parts under bracing and supports), so the number of different bugs is a little lower.
2. **The rule:** NONE of these may be marked fixed until it is seen working in AutoCAD. Each line ends with how to see it on a copy. Every one stays OPEN in the carpark until the robot and Codex have seen it pass.
3. **Partly fixed, so not a full fix even in the code:** BUG-577 (the units line does not name the unit), BUG-088 (only the L4 half), BUG-211 (a line, but no question), BUG-841 (a value below its minimum is still raised quietly), BUG-752 (wrapping on, page fit not seen), BUG-975 (the neighbour's label is safe; the switched support's own labels are still redrawn), BUG-503 (item 7 only).
4. **NOT on this list, because the installed code has no fix:** BUG-497 and BUG-498 (bracing schedule rows; their fixes are on unmerged branches), BUG-499 (trusses in wall totals), BUG-501 (column size ignores the floor), BUG-1139 (copied beam takes over links), BUG-467 (AB, BB, BT1 in a turned UCS), BUG-1183 (schedule sync resizes the wrong piers).
5. **The five that matter most to a drafter, to prove first:**
   1. **BUG-437 and BUG-438 (C1, TS1, DS1, C2):** Enter at the text spot and the number question no longer fail and lose the column. These are your most used tools.
   2. **BUG-585 (P1):** Esc at the purlin lap question no longer places a purlin.
   3. **BUG-974 (C2 and the other supports):** a schedule row you left out at XCLMTXT is no longer used.
   4. **BUG-840 (Settings):** a second AutoCAD no longer puts back a setting you just saved.
   5. **BUG-620 (FASTSAVE):** no longer purges and moves Xrefs before saving.

**This lane checked four of these fixes in the code itself** (BUG-576 "Press 1-9", BUG-620 the FASTSAVE switch, BUG-585 the Esc line, BUG-1077 the BSET wording); the rest are the readers' findings, each with its file and line.

---

## Roof marks and bracing (R1, P1, FJ1, BT1, AB, BB, ABS, CSBRACINGPANEL)

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`. Nothing was run in AutoCAD. Each is "fixed in code, not proven", so all stay open in the carpark.

1. BUG-585, P1: Esc at purlin lap still placed; fixed at `Commands\RafterJoistCommands.cs:185-187` (with 278-285 and `Services\BeamService.cs:1139-1140`); on a copy run P1, answer the four picks and the tag, press Esc at "Apply purlin lap?", then check nothing new was drawn.
2. BUG-583, ABS: locked brace error window; fixed at `Commands\BracingCommands.cs:434-482` (with `Services\LayerService.cs:239-240, 246-263`); on a copy lock layer WALL BRACING TYPE B, run ABS, pick the B brace, expect the "ABS left 1 bracing block alone..." line and no error window.
3. BUG-428 (BB part), BB: long brace no warning; fixed at `Commands\BracingCommands.cs:164-175` (with `Structural.DesignCore\BracingLengthPolicy.cs:63-77`); on a millimetre copy run BB for a 3500 mm brace, expect "This brace is 3500 mm, longer than the office limit of 2700 mm...".
4. BUG-428 (old block, no length), ABS: made-up length risk; fixed at `Services\BracingService.cs:2157-2162` and `Commands\BracingCommands.cs:492-495, 535-537`; on a copy with an older-style brace block that has no stored length, run ABS, expect "One older bracing block does not store its length..." and the block unchanged.
5. BUG-473 (HUNT-S-08), AB/BB/BT1: locked layer not checked; fixed at `Commands\BracingCommands.cs:19-24, 135-140, 250-255` (with `Services\LayerService.cs:219-232, 266-267`); on a copy lock each brace layer in turn, run the command, expect "Layer ... is locked, so CE drew no bracing. Unlock it and try again." and no brace.
6. BUG-472 (HUNT-S-07), R1/P1/FJ1/AB/BB/BT1: wrote on layout or REFEDIT; fixed at `Commands\RafterJoistCommands.cs:99` and `Commands\BracingCommands.cs:17, 133, 248` (with `Services\DrawingSafetyService.cs:62-102`); on a copy go to a layout tab, type each command, expect one stop line and no new object.
7. BUG-475 (S-10), R1: Esc asked question again; fixed at `Commands\RafterJoistCommands.cs:1396-1398`; on a copy run R1, choose Object, press Esc at "Select object:", expect the tool to end at once.
8. BUG-475 (S-14), R1/BT1: code-word lines on screen; fixed at `Commands\RafterJoistCommands.cs:246, 251, 1595-1600` and `Services\BracingService.cs:1773`; on a copy place an R1 and a BT1 with the flip question, expect "[R1] Placed R1 on layer RAFTERS." and "Brace flipped to the other side." and no "Direction=" line.
9. BUG-424 (item 4), BT1: block-load reason lost; fixed at `Services\BracingService.cs:1547-1553, 1563-1564`; on a test PC copy with the BRACING file unreadable, run BT1, expect the plain "CE could not load the BRACING block..." line and the reason in the CE log.
10. BUG-410 and BUG-413 (the _Dot line), BT1: "Duplicate definition of block _Dot ignored."; fixed at `Services\BracingService.cs:1530` with `Services\QuietBlockRead.cs:15-22`; on a copy that has no BRACING block yet, run BT1 for the first time and read the command line for that message.

## Beam tools (1, 2, 4, 5, BDL, BSET, BSETLIST, BSETRESET)

Paths are under C:\CE_WORK\scratch\audit_struc\Modules\ (S = Structural\, D = Structural.DesignCore\ConnectedDesign\, H = Structural\Services\ConnectedDesign\Host\). Read only; nothing run in AutoCAD.

1. BUG-1077, BSET: tooltip used code words; fixed at S\Assets\Config\command-registry.json:2164-2165 (the ribbon and CEHELP only print these two fields: S\Services\RibbonCommandHubService.cs:1031, S\UI\Dialogs\CommandHelpWindow.xaml.cs:334-335); on a copy hover the BSET button, then CEHELP and find BSET: both read the plain sentences, no "seed", "persistent" or "J11.2".
2. BUG-577, 1/2/4/5: units refusal called prompt failure; fixed at H\BeamCommandAutoCadPromptAdapter.cs:34-41 (1, 2) and H\BeamSpecialCommandAutoCadPromptSession.cs:92-99 (4, 5, same check for both), wording D\BeamRefusalWording.cs:212-216; on a copy set INSUNITS to 0 with UNITS and run 1, 2, 4, 5: the units line comes before the first question (it does not name the unit, only the log does, so the bug is partly fixed).
3. BUG-185, 1/2: 45 degree beam refused (metres); fixed at D\BeamCommandSourceCompatibility.cs:689-707; on a copy in a metre drawing put a non-square column rotated 45 degrees and run 1 from it at 45 degrees: the preview appears.
4. BUG-050, 1/2/4/5: mark side depends on pick order; fixed at D\BeamPlacementPlanner.cs:301-304 (4 and 5 at D\BeamSpecialCommandIntentPlanner.cs:324); on a copy place the same beam left to right, U, then right to left: the mark lands on the same side both times (BDL still uses the old routine and is not covered).
5. BUG-085, 1: wrong Xref-limit message, ends not independent; fixed at H\BeamCommandAutoCadPromptAdapter.cs:185-307 and 326-391 (all four object/point mixes; the code string XREF_OBJECT_LIMIT_EXCEEDED no longer exists in the code); on a copy run 1 as object to object, object to point, point to object, point to point: each reaches the preview.
6. BUG-088, 2/1: L4 lintel stopped, no beam; fixed (L4 half only) at D\BeamPlacementPlanner.cs:404-430 (midpoint when every outside cell is blocked); on a copy BSET a point inside, put walls blocking the outside, run 2 with mark L4: it previews at the middle. The RB9 far-label half is only partly fixed (H\BeamCommandAutoCadPlacementMath.cs:88-141 keeps a 2000 search distance).
7. BUG-211, ERASE column: erased silently, beam stays; prints a line at S\Services\BeamLinkService.Reactors.cs:395-400 and S\Services\SupportErasedPlanner.cs:412-440 but asks no question (the bug asked for one, so partly fixed); on a copy place a column, run 1 from it, erase the column: a line says the beam end has no support and is Unresolved, and U brings the column back.

## Support blocks (DS, DS1, TS1, C1, C2 and the five switch tools)

Build read: Structural 1.0.126, commit 8de95c34, under C:\CE_WORK\scratch\audit_struc\Modules\Structural\. "SBC" is Commands\SupportBlockCommands.cs. Read by code only. Nothing was run in AutoCAD, so every one stays OPEN under the carpark rule.

1. BUG-437, C1/TS1/DS1/C2: Enter at text spot rejected; fixed at SBC:961-990 (Enter handled 976-980) and 942-949; on a copy: C1, click, Enter at the turn, Enter at "Pick desired support text location": the label question appears, no "Invalid point."
2. BUG-438, C1/TS1/DS1/C2: "DefaultValue is not set" at number question; fixed at Services\CeTextService.cs:2012-2026 and Services\CeQuestion.cs:30-37 (default is only set when a label was typed before, and never read back); on a copy: C1, Enter at the text spot, type 1 at "Enter a number to append to 'C'": label C1 appears, no error lines. (The record's cause is a reading of AutoCAD's library, so this is the least certain of the list.)
3. BUG-434 part 1, C1/TS1 (and DS, DS1, C2): current layer left changed; fixed at SBC:233, 415 and Services\SettingRestore.cs:11-69; on a copy: note the current layer, run C1, Esc at the text question, current layer is back as it was.
4. BUG-434 part 2, C1/TS1/DS/DS1: "Duplicate definition of block _Dot ignored" printed; fixed at SBC:1357 and Services\QuietBlockRead.cs:13-21 (not for C2, see the new-faults file); on a copy with no support block, run C1 once: no _Dot line.
5. BUG-439 (LOW), C1/TS1/DS: finished command left layer changed; fixed at SBC:233, 415; on a copy: finish a C1 with a label, current layer is back as it was.
6. BUG-448, C1/C2/DS1/TS1: label lands beside previous column; fixed at SBC:1077-1096 and Services\CeTextService.cs:530-536 (also Esc no longer prints "failed", CeTextService.cs:464-499); on a copy: C1, Enter at "Enter a number" on one column, then C1 on the next column with a click: the label sits at the new column.
7. BUG-471, C1/C2/DS/DS1/TS1: metre drawing column 89 m wide; fixed at SBC:216 and Services\FoundationService.Identity.cs:119-128 (it stops, it does not convert); on a copy: set UNITS to metres, run C1: the units line prints and nothing is placed.
8. BUG-472, C1/C2/DS/DS1/TS1: ran on layout tab or REFEDIT; fixed at SBC:215 and Services\DrawingSafetyService.cs:62-100; on a copy: go to a layout tab (not inside a viewport), run C1: the layout-tab line prints and nothing is placed.
9. BUG-473, C1/C2/DS/DS1/TS1: no locked-layer check; fixed at SBC:225-232 and Services\LayerService.cs:219-232, 266-267 (the BT1 and BTX parts of the bug were not read here); on a copy: lock SUPPORT COLUMN, run C1: "Layer SUPPORT COLUMN is locked, so CE drew no support. Unlock it and try again."
10. BUG-974, C2 (also C1/DS/DS1/TS1): excluded schedule row still used; fixed at Services\XclmTxtService.cs:308-320 (only included rows are saved); on a copy: XCLMTXT with the C2 row ticked off, insert the rest, run C2: the size window opens and no "from the schedule" line prints.
11. BUG-576, C2/SC2: window says Press 1-8; fixed at UI\Dialogs\ColumnVisibilityPickerDialog.cs:62; on a copy: run C2: the window reads "Press 1-9" and key 9 picks the ninth size.
12. BUG-086, C2: old support block wins quietly; fixed at Commands\SupportBlockDefinitionUpgradeService.cs:186-197 and 231-243 (asks Upgrade or Cancel, Cancel is the default); on a copy from an older job holding the old support block: run C2: "Existing support block definition is outdated." then "Choose [Upgrade/Cancel] <Cancel>: ".
13. BUG-424 item 3, STS1 (also SDS/SDS1/SC1/SC2): raw locked-layer error text; fixed at SBC:434-439 and 587-588; on a copy: lock the layer the support is on, run STS1 and pick it: "STS1 could not switch this support block because its layer ... is locked. Nothing was changed. ..."
14. BUG-975, SDS/SDS1/STS1/SC1/SC2: neighbour's label swung round; fixed at SBC:1795-1830 and 1850-1888 (a label nearer another support is left alone); on a copy: two supports 200 mm apart with a label beside the second, SDS on the first and turn it 90 degrees: the second's label keeps its place and rotation. (The switched support's own labels are still drawn again as new text.)

## Schedules, CLEAN, Help and Settings

Paths are under C:\CE_WORK\scratch\audit_struc\Modules\Structural\. Read only; nothing run in AutoCAD. BUG-497 and BUG-498 are NOT here: their fixes are on unmerged branches and the installed code has no trace of them (the switch names ScheduleTablesHaveTitleAndHeadingRows and RefreshBlanksLeftoverRows appear nowhere in Models\ or Services\).

1. BUG-620, FASTSAVE: purged and moved Xrefs first; fixed at Services\CleanPipelineService.cs:105-126 with Services\CleanPipelinePlan.cs:11-13 (switch default false at Models\UserSettings.cs:372); on a copy with an unused layer and an Xref on its own layer, FASTSAVE: the unused layer is still in LAYER, the Xref stays on its layer, the drawing is saved (it still regenerates).
2. BUG-1077, CEHELP: BSET help used project words; fixed at Assets\Config\command-registry.json:2164-2165; CEHELP, search BSET: plain sentences, no "seed", "persistent store" or "J11.2".
3. BUG-1078, CEHELP: markup help used code words (text only; the group is still Administration); fixed at Assets\Config\command-registry.json:678, 746, 763; CEHELP, open Open Saved Markup Review, Set Drawing for Markup, Apply Next Markup Group: plain explanations, do not click Run.
4. BUG-1079, CEHELP: PDF help named a code class; fixed at Assets\Config\command-registry.json:4219-4224; CEHELP, search STRUCEXPORTPDF: no "AsyncCommandService" and no "asynchronously", still names layout, PDF and plotter.
5. BUG-299, CESETTINGS: failed settings save mishandled (all three parts); fixed at Services\SettingsService.cs:641, 669-670; UI\Dialogs\SettingsSaveAttempt.cs:24-37; Services\SettingsService.LoadRecovery.cs:1000-1007; on a test settings folder (set CE_STRUC_SUITE_APPDATA_ROOT, never Tim's live file) hold CS_Settings.json open elsewhere and press Save: "Not saved. Your entries remain in this window, and your settings file was left as it is." appears once, not repeated.
6. BUG-575, CESETTINGS: Installed version read 1.0.1.0; fixed at UI\Dialogs\CeSettingsDialog.xaml.cs:190-191 with Services\VersionInfoService.cs:287-299; CESETTINGS, System, Installation: the loaded build number matches the status bar.
7. BUG-840, CESETTINGS: second AutoCAD reverts saved change; fixed at Services\SettingsService.cs:933-937 with Services\SettingsRoutineMerge.cs:8-27 and SettingsService.LoadRecovery.cs:984-986; two AutoCADs on a test settings folder: Save a beam offset in A, run a last-used-value command in B, restart A: the offset stays.
8. BUG-841, CESETTINGS: mistyped number silently ignored (main symptom only; a value below its minimum is still raised quietly at UI\Dialogs\CeSettingsDialog.xaml.cs:409, 416); fixed at UI\Dialogs\CeSettingsDialog.xaml.cs:246-259 with UI\Dialogs\CeSettingsNumberBoxes.cs:11-70; type 1O0 in a beam offset box and press Save: a message names the box and the window stays open.
9. BUG-955, CESETTINGS: window too big at 150 per cent; fixed at UI\AutoCadWindowHostHelper.cs:49-68, 241-243 (screen pixels converted by the screen's scale, window kept inside the work area at 147-158); open CESETTINGS on a 150 per cent screen: Save and Cancel are on screen.
10. BUG-1072, CESETTINGS: autosave tick promised protection; fixed at UI\Dialogs\CeSettingsDialog.xaml:578-579; CESETTINGS, System, Saving and fault reports: "Also keep backup copies of Civil-only drawings" with "Copies the last saved drawing only. Unsaved changes are not included."
11. BUG-1076, CESETTINGS: diagnostics choice not explained; fixed at UI\Dialogs\CeSettingsDialog.xaml:538, 547, 572-576, 580; same page: the four plain labels and the extra-detail note.
12. BUG-752, CESETTINGS: long paths clipped at edge (wrap now on, page fit not seen); fixed at UI\Dialogs\CeSettingsDialog.xaml:605, 609, 615, 619, 647, 651, 655, 778; open Installation, Workbook files and Markup service with a 120-character path: the text wraps inside the box.
13. BUG-549, CESETTINGS (markup page; command CEMARKUP): PDF sent to OpenAI by default; fixed at Services\MarkupAIOffPcPolicy.cs:32-35 with Services\MarkupAIVisionParser.cs:44-55, Services\MarkupAIChatService.cs:32-40 and Models\MarkupAIModels.cs:240 (chat off by default); Read Markup PDF on a copy of a test PDF: it reads on this PC only and stops with the plain line, no outside call (only the two upload sites were read).
14. BUG-503 item 7 only, STRSCHEDREFRESH: raw AutoCAD word on locked layer; fixed at Commands\UtilityCommands.cs:85-89 with Services\StructuralPlainWords.cs:24-32; lock the table's layer on a copy, STRSCHEDREFRESH, pick the table: "[STRSCHEDREFRESH] The schedule's layer is locked, so the schedule was not updated. Nothing was changed. Unlock the layer and run it again." (the entry stays open for items 1 to 6).

---

## Not checked

1. **Nothing was run.** Every line is a reading of the installed code.
2. **Four readers** wrote these, one per family; this lane spot-checked four fixes and several quoted messages.
3. **BUG-438's cause** is the record's own reading of AutoCAD's library, so its fix is the least certain line here.
