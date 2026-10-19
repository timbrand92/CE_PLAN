# Wording, colour and plain-English audit (read-only), file dated 12 Oct, run 19 Oct 2026

**Job:** "AUDIT: plain-English, no blue, jargon and wording in every window and message" (Team usage governor, desk plan/03). Nothing was built or run; nothing seen in AutoCAD. No BUG numbers filed (the controller does that).

**What was read (installed lineage only, never master):**

1. **Civil 3.0.56 and Manager 1.1.56:** `origin/claude/rel-20261019b` at 9638622b (read in a private worktree `C:\ce-hunt\wording`, removed at the end).
2. **Structural 1.0.118:** `origin/claude/rel-20261017s` at 9a8e5d4e (worktree `C:\ce-hunt\wording-struc`, removed at the end). The Civil head (19b) does NOT hold this Structural commit, so every Structural line number below is from 1.0.118, not from the Civil head. The two heads differ (the 19b copy of Structural has a gold ThemeManager accent, a different set of blue dialogs and so on), which is why this matters.
3. **Known findings read first, so none are repeated:** `ENGINEERING_RULEBOOK.md` (engineering numbers, no wording rules in it), `HUNT3_CROSS_2026-10-09.md` (its headings 1 to 3 are exactly this topic), BUG-517, 518, 523, 524, 525, 814, 360 in `BUG_CARPARK.md`, and the other HUNT files by name. Where I re-checked a HUNT3 item against the installed heads it is in Part B, not Part A.

**Method:** a script listed every colour in `.xaml` and `.cs` (named, `#RRGGBB`, `FromRgb`) and kept the blue ones; a second script listed user-visible strings (command-line `WriteMessage`, message boxes, prompts, window text, tooltips, registry labels) that contain program words; a third looked for American spellings and mixed units. Log-only lines (`LoggingService`, `Serilog`) were left out because a drafter never sees them. Then each hit was read in place.

**Not checked (so nobody assumes it was):** the pixels of the ribbon icons (HUNT3 3.7 and 3.11 and 3.12 stand as written), the text inside the Civil help HTML and JavaScript pages beyond the blue accent, the LISP files, AutoCAD's own windows, text built from values at run time (a sentence assembled from three pieces can hide a program word that only appears in one case), and the Structural registry tooltips beyond a spelling check.

---

## Plain English summary: the 10 worst

1. **The Civil computations sheet still prints in blue (KNOWN, still there at 3.0.56).** The practice name, the rule line under it, the approval line and the block titles use `CeBlue` (#1E5AA8) at `Modules/Drainage/ViewModels/CalculationsV2ViewModel.cs` line 907, used at lines 927, 930, 934, 973 and 982. This goes on paper and PDF to a client. Tim's rule is gold, black, white and grey.
2. **Every light-theme window in all three products is still blue (KNOWN, still there).** Civil `Themes/LightTheme.xaml:14-16`, Manager `UI/Themes/Theme.Base.xaml:17-18` and `Theme.SwissModern.xaml:17-18`, Structural `UI/Themes/StructuralEditor.Light.xaml:12-13`. Part B has the full re-check.
3. **Structural still prints about 50 lines of program words at every AutoCAD start, and 4 of the commands it advertises look unregistered (KNOWN, still there at 1.0.118).** `Modules/Structural/Plugin.cs:239-292`. By string search nothing registers BTXT2MT, BMT2TXT, SBL or BREAKLINE, so a colleague who types one from that list may get "Unknown command" (type them in AutoCAD to confirm).
4. **NEW: turning the "Show AutoCAD command names" switch OFF leaves 44 of the 65 visible Civil buttons with a command still on them.** The command is typed into the registry label itself ("Pit Layout (PIT)"), so the switch cannot remove it. Details in W-01.
5. **NEW: the Slab command prints "Pit cover (P3, 450mm): 12.345".** The 450 mm is how far you clicked from the pit, and 12.345 is a level with no unit. A drafter reads it as "the cover is 450 mm". `Commands/SlabCommand.cs:655`. Details in W-02.
6. **NEW: "Repair Center" is the American spelling, in 7 places, in the same product that says "Help Centre".** Details in W-03.
7. **NEW: in Suite Manager the Structural module's colour stripe is blue (#1E6BB0).** `Modules/Manager/Services/CePluginRegistryService.cs:562` (the other known modules get gold and grey). W-04.
8. **NEW: a group of Civil command-line sentences still use "entity", "compound root", "persisted", "cache adoption" and similar (about 20 lines not in HUNT3).** W-06 has each line with proposed wording.
9. **NEW: a group of Structural sentences use "cache", "snapshot", "registry", "whitelisted direct command", "deterministic native payload" and "normalization dispatched".** W-07.
10. **NEW: volume and flow units are written two ways on screen and on drawings.** "m3" and "m2" in the Detention windows and the auto-design summary, "m³" and "m²" in the Calculations window; "l/s" on the pump detail and the detention criteria block, "L/s" in the other 38 places. W-05.

**Honest scale:** nothing here makes a wrong number on a drawing. The worst by consequence is item 1 (colour on a client sheet) and item 5 (a level read as a depth). The rest is wording a colleague has to guess at.

---

## Part A: NEW findings (not in HUNT3, BUG-517/518/523/524/525, BUG-814 or BUG-360)

Each entry: where, what a drafter does, wrong result, right result, severity, confidence, one-line fix, whether a unit test can show it RED.

1. **W-01 (LOW-MEDIUM, PLAUSIBLE): the "Show AutoCAD command names" switch cannot turn the brackets off for 44 of 65 Civil buttons.**
   - **Where:** `Modules/Drainage/Assets/Config/command-registry.json` (44 of the 65 visible, non-hidden rows have a label that ends in "(COMMAND)", for example `CD` "Pipe Layout (CD)", `PIT` "Pit Layout (PIT)", `PP` "Quick Plastic Pit (PP)", `CDEDIT` "Edit Pit or Pipe (CDEDIT)", `CDWT` "Water Tank (CDWT)", `CDPARTS` "Parts Catalogue (CDPARTS)"; the other 21 are plain, for example `CDINSPECTOR` "Inspector", `CDCALC` "Calculations"). The switch reads `showCommandNames` (`Models/UserSettings.cs:2456`, default true) through `Shared/CE_SHARED/Services/CeRibbonLabel.cs` and `RibbonBuilder.cs:451`.
   - **Steps:** Settings, turn "Show AutoCAD command names" OFF, restart the ribbon, look at the Civil tab.
   - **Wrong:** 21 buttons lose the bracket and 44 keep it, so one tab mixes the two styles. The class comment says the switch "turns every bracket off".
   - **Right:** OFF shows plain names on all 65; ON shows "(COMMAND)" on all 65.
   - **Fix idea:** strip a trailing "(COMMAND)" from the registry label before use (or remove it from the 44 JSON rows and let the switch add it). `CeRibbonLabel.WithCommand` already avoids doubling.
   - **Why only PLAUSIBLE:** I did not confirm that the ribbon button text comes from the registry label rather than from `Assets/Config/ce_toolbar_layout.json` (which also carries a `displayName`, for example line 222 "Repair Center"). Check which one the button reads.
   - **RED test:** yes, a pure-text test over the registry with the switch off.

2. **W-02 (LOW-MEDIUM, CONFIRMED by reading): the slab level suggestion is ambiguous.**
   - **Where:** `Modules/Drainage/Commands/SlabCommand.cs:655`.
   - **Steps:** CDSLAB, pick slab points near a pit that has a cover level.
   - **Wrong:** the command line prints `Pit cover (P3, 450mm): 12.345`. The "450mm" is the distance from the picked point to the pit (`nearestPitDist` in millimetres) and 12.345 is the pit's cover LEVEL with no unit. Next line asks "Enter FSL for point n [12.345]:". Read quickly, it says the pit's cover is 450 mm.
   - **Right:** `Nearest pit P3 (450 mm away) has a cover level of 12.345 m. Used as the suggested FSL.`
   - **Fix idea:** change the one string.
   - **RED test:** needs the sentence pulled into a small helper first; then yes.

3. **W-03 (LOW, CONFIRMED): "Repair Center" is American spelling, in seven places.**
   - **Where:** `Assets/Config/command-registry.json:351` (the ribbon label), `Assets/Config/ce_toolbar_layout.json:222`, `Dialogs/CdHelpDialog.xaml:111`, `Dialogs/CdLinkDialog.xaml:102` ("Open Repair Center"), `Dialogs/CdRepairDialog.xaml:4` (window title) and `:42` (window heading), `Services/InspectorPaletteService.cs:961` ("use Repair Center's Register Unregistered Pipes").
   - **Wrong:** the same product has a window titled "Help Centre".
   - **Right:** "Repair Centre" everywhere.
   - **Fix idea:** one find-and-replace in those seven lines (the command stays CDREPAIR).
   - **RED test:** yes, a source guard that no label or title contains "Center". Note "Center" is also AutoCAD and WPF code (`HorizontalAlignment`, `CenterScreen`), so the guard must look at label and title strings only.
   - **Other spelling hits, all small:** Structural `Services/FoundationService.cs:3828` "Select centerline (Line/Polyline/Arc)" (centreline); `Services/NativeXrefLayerService.cs:128, 164` and `UI/LayerManagerWindow.xaml:57` "Color" (AutoCAD itself says Color, so ask Tim whether he wants colour); Structural `UI/Dialogs/AdminHubWindow.xaml:63` "Normalize" and `UI/Dialogs/XclmTxtAdvancedEditDialog.xaml:125` "Normalize Selected" (normalise, and also a program word). The Structural registry labels "Synchronise Schedule" and "Standardise Text Styles" are already Australian, so the product is otherwise consistent and these are the exceptions.

4. **W-04 (LOW-MEDIUM, CONFIRMED by reading): Suite Manager paints the Structural module in blue.**
   - **Where:** `Modules/Manager/Services/CePluginRegistryService.cs:562` sets `AccentColorHex = "#1E6BB0"` for `CE_STRUC_SUITE`; `CePluginDescriptor.cs:241-247` turns it into the brush the module row uses. The other known modules get #D4AF37 (gold, line 580), #8B6914 (dark gold, 597) and #555E6B (grey, 609).
   - **Wrong:** one blue module colour on an otherwise gold list, and it is not the theme blue so the theme fix (HUNT3 3.3) will not remove it.
   - **Right:** gold or grey like the others.
   - **Fix idea:** change one hex. **RED test:** yes (descriptor accent for each known plugin must not be blue).
   - **Where I am not sure:** which part of the card uses the brush (stripe or heading). Check by looking at the Module tab.

5. **W-05 (LOW, CONFIRMED mix; whether a drawing figure is deliberate is Tim's call): units are written two ways.**
   - **"m3" and "m2" typed plain:** Detention windows `ViewModels/DetentionPipeRow.cs:94`, `DetentionPitRow.cs:73`, `DetentionExtraRow.cs:31`, `DetentionSystemViewModel.cs:1127, 1132` ("Shortfall: 0.40 m3", "Surplus: 1.20 m3"); auto-design summary on the command line `Services/AutoDesignOrchestrator.cs:298-321`; `Services/XrefSiteGeometryService.cs:119, 149, 154` ("boundary: 612.0 m2"); `Rules/StormReportOffer.cs:155-184`; `Rules/BlueFactorReport.cs:187-191`; `Rules/DetentionVolumeRequired.cs:71, 120`; `Rules/ComputationsSheet.cs:283-284`; `Rules/ComputationsSheetV3.cs:420`; `Rules/StorageDesignedVsDrawn.cs:108`; `Rules/CriteriaBlockRows.cs:58-66` (this one goes ON THE DRAWING and a golden file pins it, `Drainage.Tests/Fixtures/C4CalcGolden/rows_0.txt:8` "0.49 m3", so it is probably deliberate: plain text on a drawing).
   - **"m³" and "m²" with the superscript:** 31 and 37 other visible strings, and the Calculations window converts "m3" to "m³" on screen (`Dialogs/CalculationUnitTextConverter.cs:12`).
   - **Flow "l/s" against "L/s":** `Services/SpsDetailGenerator.cs:335` ("DUAL 12.50 l/s ALTERNATING PUMPS"), `Rules/CriteriaBlockRows.cs:48` ("l/s") and `ViewModels/DetentionSystemViewModel.cs:364`, against "L/s" in 38 other visible strings. The Australian convention is L/s.
   - **Wrong:** a colleague sees "m3" in the Detention window and "m³" in the Calculations window for the same figure; the pump detail says "l/s" while the report says "L/s".
   - **Right:** screen text "m³", "m²", "L/s" everywhere; ask Tim whether drawing text (CAD text with no superscript) stays "m3".
   - **Fix idea:** one shared units helper, or apply the existing converter to the Detention windows and the command-line summaries.
   - **RED test:** yes for screen strings; leave the golden-pinned drawing figures alone until Tim rules.

6. **W-06 (LOW to LOW-MEDIUM, CONFIRMED for the strings; whether each one is shown depends on the path): Civil command-line and window sentences with program words, not in HUNT3.** HUNT3 1.3 to 1.12 and 2.7 and 2.8 are not repeated. Proposed wording after each.
   1. `Commands/HealthCheckCommand.cs:70` "{n} pit(s) in project data have no matching entity in the drawing — run CDSYNC." Say: "{n} pit(s) CE has on record are no longer in the drawing. Run CDSYNC to tidy the record."
   2. `Commands/HealthCheckCommand.cs:187` "Layer '…' is missing — it will be auto-created on next use, but existing entities may be on the wrong layer." Say: "Layer '…' is missing. CE will create it next time it is needed; anything drawn before may be on another layer."
   3. `Commands/HubCommands.cs:650` "Compound links rebuilt - {n} compound root(s) registered." Say: "Pit and pipe links rebuilt: {n} pits and pipes re-linked."
   4. `Commands/HubCommands.cs:654` "{n} entity(ies) skipped due to read errors - see CE log." Say: "{n} object(s) could not be read and were skipped. Details are in the CE log."
   5. `Commands/HubCommands.cs:683` "Registered {n} previously-unregistered pipe(s)." Say: "{n} pipe(s) that CE did not know about are now in the pipe list."
   6. `Commands/LinkCommands.cs:520` "Selected entity is not a valid pit block." (HUNT3 1.3 fixed the PITEDIT, RunSolve and PITDELETE copies; this one and `AI/SmartifyPitTool.cs:154` "Selected entity is not a pit block." were missed.) Say: "That is not a CE pit. Pick a pit."
   7. `Commands/LinkCommands.cs:2379` "Invert values are now persisted on the pipe entities. They will survive MText deletion." Say: "The invert levels are now saved with the pipes, so they stay even if you delete the label text."
   8. `Commands/CdMoveCommands.cs:53` "{command}: no valid entities selected." Say: "{command}: nothing usable was picked."
   9. `Commands/CopyRotateCommands.cs:231` "CopyRot: Copy produced no new entities -- operation aborted." Say: "Nothing was copied, so the rotate was cancelled."
   10. `Commands/ExportEntitiesCommand.cs:68` "CDEXPORTENTITIES: exporting entities from …" Say: "Saving the pit and pipe shapes from …"
   11. `Commands/TriageCommands.cs:74` "No entities found in model space (or file could not be read)." Say: "Nothing found in Model space, or the file could not be read."
   12. `Commands/SlabCommand.cs:423` "{n} drainage node(s) inside boundary" Say: "{n} pit(s) inside the slab outline." (HUNT3 1.8 covers `:80`, `:422`, `:1210`, `:1231`; this is the same family at a line it did not list.)
   13. `Commands/SlabCommand.cs:123` "This boundary is already registered as a CE slab. Use CDSLABEDIT to modify." and `:407` "The slab was registered, but Civil display recovery is required. Reopen the drawing before further slab edits." Say: "This outline is already a CE slab. Use CDSLABEDIT to change it." and "The slab was saved, but its labels could not be refreshed. Close and reopen the drawing before editing slabs again."
   14. `Services/ProposalApplyService.cs:285` "[CDRULES] Proposal committed, but cache adoption or its applied receipt failed. Do not Apply again; reopen the drawing." Say: "The changes were made, but CE could not update its own record of them. Do not press Apply again: close and reopen the drawing."
   15. `Services/ProposalApplyService.cs:468` "[CDRUNSOLVE] Invalid plan/database." Say: "CDRUNSOLVE could not start: the drawing is not ready. Try again."
   16. `Services/ProposalApplyService.PlanBuilders.cs:87` "Pipe 'P1' → 'P2' has no entity handle recorded — skipped." Say: "Pipe P1 to P2 is not linked to a pipe in the drawing, so it was skipped."
   17. `Services/PitScheduleDifferenceService.cs:192` "{snapshotName} schedule row P3 has no permanent identity." Say: "The row for P3 in {name} is not linked to a pit in the drawing yet."
   18. `Services/LinkService.RepairAudit.Analysis.cs:776` "…drainage outlet is not registered as a pit yet — use Repair & Upgrade to add it to the schedule." and `:918` "No slabs registered — use Slab System to add surface drainage areas." and `:887` "A fall symbol on the drawing is not linked to any registered slab — delete it, or re-run Edit slab." Say: "…outlet is not a pit in the schedule yet. Use the Repair Centre to add it.", "No slabs yet. Use CDSLAB to add surface drainage areas.", "A fall arrow on the drawing is not part of any slab. Delete it, or run CDSLABEDIT again." (also uses two different names for the same tool: "Repair & Upgrade" and "Repair Center".)
   19. `Services/NetworkDesignService.cs:105, 109, 116, 589` "NETWORK: a node has a blank PitId — skipped." "duplicate PitId …" "OutfallPitId … not found in the node list." "a null link was supplied — skipped." Say: "A pit with no name was skipped." "Two pits are both called P3; only the first is used." "The outfall pit P9 is not in the pit list." "A pipe with no pit at one end was skipped." (if these reach the screen; if they go only to the log they are fine, so check.)
   20. `Controls/InspectorPanelControl.xaml:89` "This is the full-detail snapshot. Return to CE Inspector for the current selection." Say: "This is a saved copy of the detail view. Go back to the Inspector for what is selected now." and `Dialogs/CdLinkDialog.xaml:119` "…review the row in PITSCHEDULE and the selected entity in the Inspector." Say: "…check the row in the Pit Schedule and the selected pit or pipe in the Inspector."
   21. `Controls/CeAssistantControl.xaml.cs:768` message box "Only Timothy-authorized proof may mark this project Standard." names a person and uses American spelling; a colleague cannot act on it. Say: "This project can only be marked Standard by the CE administrator." (Same sentence at `Services/ProjectDataService.AiAccessDrawing.cs:68`, an exception text.)
   - **Severity:** LOW each; item 14 is LOW-MEDIUM because the sentence tells a drafter not to press Apply and gives no plain reason. **RED test:** yes for each string once it sits in a testable helper; a guard that no visible string contains "entity", "persisted", "cache adoption" or "compound root" is cheap.

7. **W-07 (LOW to LOW-MEDIUM, CONFIRMED for the strings): Structural 1.0.118 sentences with program words, not in HUNT3 1.10.** Line numbers are from Structural 1.0.118.
   1. `Services/XclmTxtService.cs:325` "Member schedule snapshot saved ({n} row(s))." and `:366-374` XCLMTXT status prints "Active cache: C:\…", "Legacy cache fallback: C:\…", "Last refresh error: …". Say: "Member schedule saved ({n} rows)." and "Past-job list: last updated …, stored at …".
   2. `UI/Dialogs/CeSheetsManagerWindow.xaml.cs:1198, 1201, 1224` "Issue 'X' snapshot created." "Issue snapshot created in: …" "Create an issue snapshot first." Say: "Issue X saved: a copy of the issued drawings is in …" and "Save an issue copy first."
   3. `UI/LayerManagerWindow.xaml.cs:272` "Text style normalization dispatched: MTS." Say: "Text styles are being merged (the MTS command is running)."
   4. `UI/Palette/CommandsPanel.xaml.cs:430` "CETOOLS remains usable. The Commands tab is disabled until the registry loads cleanly." Say: "The Commands tab is off because the command list did not load. The rest of CETOOLS still works."
   5. `Services/MarkupAIExecutionService.cs:176, 190` "Dispatched via whitelisted direct command." "No native result or approved direct-command fallback was available." Say: "Done with a standard CE command." and "CE has no safe way to do this one automatically. Do it by hand."
   6. `Services/MarkupAIWorkflowService.cs:435` "Could not create a deterministic native payload; item left manual." Say: "CE could not work out the change for this item. It is left for you to do."
   7. `Commands/MarkupAICommands.cs:109` "Parse error: {ex.Message}" (raw program text), `:122` "Select Markup Package JSON", `:429` "Output JSON path". Say: "CE could not read that markup file." "Pick the markup file." "Save the markup list as:".
   8. `UI/Palette/MarkupAIPanel.xaml.cs:53` "No active package. Parse a PDF or load a package." Say: "No markup loaded. Open a markup PDF or a saved markup file."
   9. `Commands/DiagnosticsCommands.cs:57, 78` and `Services/HealthCheckService.cs:120` "{n} incomplete command snapshot(s) from a previous session" / "{n} snapshot(s) cleared." Say: "{n} command(s) did not finish last session. Type CERECOVERY to look at them." / "{n} cleared."
   10. `Services/DrawingSafetyService.cs:28` "drawing database not available." (HUNT3 1.10 listed it; still there.) `Services/BracingDiagnosticsService.cs:64, 74, 309, 319` "No entities found." "Last entity is not a dynamic block." Say: "Nothing found." "The last object drawn is not a CE bracing block."
   11. `UI/Dialogs/CeSettingsDialog.xaml:142` (HUNT3 2.8 lists it) and `:177-178` "Wall-assembly gap tolerance" "Detect wall-assembly (double-line walls) within this many units gap." Say: "Wall gap tolerance" and "Treat two lines as one wall when they are within this distance of each other (drawing units)." The word "units" with no number is also unclear: drawing units may be mm or m.
   - **RED test:** same guard as W-06.

8. **W-08 (LOW, CONFIRMED): window titles and button names are inconsistent.**
   - **Capitalisation mixed in one product** (Civil dialog titles): "Water tank", "Water tank plan block", "Legal point of discharge", "Job rainfall / IFD", "Office short names", "New job drawing", "Civil import", "Settings history" in sentence case, against "Slab Fall Design", "Pit Schedule", "Link Tool", "Label Styles", "Design Warnings", "Council Source", "Cascade Preview", "Proposal Preview", "Drawing Standards Manager" in title case.
   - **Names that do not match:** ribbon "Import X-Civil" (registry `CDIMPORTXCIVIL`) opens "Civil import"; ribbon "Check Consultant DWG" (registry `CDCHECKDWG`, label at line 464) opens "Check consultant drawing results" ("DWG" is a file word, drafters say "drawing"); registry "Repair Center" / window "Repair Center" / the Analysis message "Repair & Upgrade" for the same tool; `Dialogs/CivilHubDialog.xaml:3` "Civil Hub" and `CivilSettingsView` "Civil Drainage" and plain "Design" and "Edit Selected" give no idea what they hold.
   - **Right:** one capitalisation style (Tim to pick; sentence case matches the new windows) and the ribbon name and window title say the same thing.
   - **Fix idea:** a one-off pass over `Title=` and the registry labels; HUNT3 2.5 and 2.6 (add the command to titles) is built in the Civil head by `Services/CeWindowTitle.cs` and `CeWindowTitleHook.cs`, so do both in the same pass. **RED test:** a source guard for the pairs only.

9. **W-09 (LOW, admin only, CONFIRMED): the Suite Manager Admin Dashboard uses release-engineering words.**
   - **Where:** `Modules/Manager/UI/Dialogs/PluginAdminWindow.xaml` lines 100 "Failures 24h", 108 "Behind Approved", 112 "Missing Signals", 193 "Mark as Investigated", 236 "Roll Back Approved Release", 240 "Canary Rollout...", 244 "Promote to All", 255 "Support Bundles", 198-202 columns "Severity", "Plugin" (the id), "Category".
   - **Who sees it:** the administrator only (Tim). The colleague-facing Manager window (`PluginManagerWindow.xaml`) is already plain ("Running now", "Installed next start", "Review update").
   - **Say instead:** "Failures in the last 24 hours", "Not on the approved version", "PCs that have not reported", "Mark as looked at", "Go back to the previous approved version", "Release to a few PCs first...", "Release to everyone", "Support files".
   - **RED test:** not worth one.

10. **W-10 (LOW, PLAUSIBLE): a blue is hard-coded as a fallback and as an "info" colour outside the themes.**
    - **Where:** Civil `Controls/SlabSurfacePreviewControl.xaml.cs:86` falls back to `Brushes.SteelBlue` when the theme has no InfoBrush; Structural 1.0.118 `UI/Dialogs/NotesBrowserDialog.xaml:60` sets the subtitle "All users / shared Job Notes workspace" to a pale blue `#DDEBFF` (readable only on a dark header; on the light theme it fades), `UI/Dialogs/NotesBrowserDialog.xaml.cs:592` draws a badge in purple (111, 66, 193) (not blue, but outside gold, black and grey), and `UI/Dialogs/RCMemberDialog.xaml.cs:274` uses `#1E40AF` on `#EFF6FF` for the information line.
    - **Right:** theme text colour and the grey or gold family.
    - **RED test:** yes, one colour guard over `.xaml` and `.cs` text (my script is a starting point: blue means the blue channel is more than 25 above red and 8 above green).
    - HUNT3 3.10 lists the other Structural blue dialogs; the two NotesBrowser lines, the purple badge and the SteelBlue fallback are not in it.

---

## Part B: known HUNT3 items re-checked against the installed heads

Status words: **STILL THERE** (same defect at Civil 3.0.56 / Structural 1.0.118), **FIXED** (gone in the installed head), **CHANGED** (partly built). Nothing here is a new bug.

1. **HUNT3 1.1 and 1.2, Structural start-up text and four commands that do not exist: STILL THERE.** `Modules/Structural/Plugin.cs:239-292` (about 50 lines; "Build:", "Assets root:", "Native mode: structural command runtime is now C#.", the whole command list). A string search of the 1.0.118 sources finds no registration of the names BTXT2MT, BMT2TXT, SBL or BREAKLINE (SBL and BREAKLINE appear only inside a menu-text match in `Services/CuiMenuGeneratorService.cs:1576`), so those four are still PLAUSIBLY untrue; HUNT3's reading holds. MR and CR do exist in 1.0.118 (`Services/NativeTransformToolsService.cs:34`, `Services/CeStrucRibbonContributor.cs:53`), so I do NOT repeat HUNT3's claim that only Civil has them. The attribute form could differ from my search, so type each name in AutoCAD before filing.
2. **HUNT3 1.3, "Selected entity is not a pit block.": MOSTLY FIXED** in PITEDIT, CDRUNSOLVE and PITDELETE; two copies remain (see W-06 item 6).
3. **HUNT3 2.1, the "Show AutoCAD command names" switch: CHANGED.** Built in Civil (`CeRibbonLabel`, `CeWindowTitle`, setting `showCommandNames`, on by default) and read by the Civil ribbon and window titles. NOT wired in Structural 1.0.118 (no `ShowCommandNames` or `CeRibbonLabel` anywhere in its source), so the Structural ribbon (313 buttons) still shows plain names only, and not wired by Manager's start-up (`ShowCommandNamesProvider` is set only in `Modules/Drainage/PluginInitialization.cs:250`). Whether the Manager buttons get brackets therefore depends on Civil having loaded first in the same AutoCAD (shared static). Related new finding: W-01.
4. **HUNT3 2.5 and 2.6, window titles carry the command: CHANGED** (Civil only, same switch). Civil window titles in the XAML are still the plain "Creative Engineering | Name"; the command is added at run time. Structural window titles are unchanged.
5. **HUNT3 3.1, Civil light theme blue: STILL THERE.** `Themes/LightTheme.xaml:14` AccentColor #1E5AA8, `:15` hover #164782, `:16` soft #E4EEF9.
6. **HUNT3 3.2, other Civil blues: STILL THERE.** Light `LightTheme.xaml:30` Info #3B6EA8, `:35` linked row #D6EAF8, chart `:24-26` #0277BD / #4FA8DC / #4A7C90; dark `DarkTheme.xaml:25-27` #4FC3F7 / #8BD7FF / #6A9FB5, `:31` Info #6B8FBF. `Controls/CeProvenanceChip.xaml.cs:157` hard-codes the Info colour (0x6B, 0x8F, 0xBF) as well.
7. **HUNT3 3.3, Manager blue: STILL THERE.** `UI/Themes/Theme.Base.xaml:17-18` and `Theme.SwissModern.xaml:17-18`.
8. **HUNT3 3.4, Structural light editor blue: STILL THERE in 1.0.118.** `UI/Themes/StructuralEditor.Light.xaml:12-13`. The dark and base Structural themes in 1.0.118 use gold (`Theme.Base.xaml` accent #B66B00; `ThemeManager.cs:43` Accent #B66B00), so the blue is the light editor theme only. Small slate-blue greys also remain (`Theme.SwissModern.xaml:14-15` #334155 / #64748B, `Theme.SwissModern.Dark.xaml:11, 14`); HUNT3 3.13 says leave unless Tim says they look blue.
9. **HUNT3 3.5, Help blue: STILL THERE.** `Shared/CE_SHARED/Help/HelpCentreView.xaml.cs:311` light #1E5AA8; `Modules/Drainage/Assets/Help/ce_cvl_guide.html:22, 207, 305` still use `--blue` #5b9bd5.
10. **HUNT3 3.6, the "Start Here" ribbon dot: STILL THERE.** `Shared/CE_SHARED/Services/RibbonBuilder.cs:207-215` (blue on a light ribbon); the comment above it still quotes the old "CE deep blue on light" rule, which Tim has superseded.
11. **HUNT3 3.7, light ribbon icons in blue: STILL THERE by the record** (`Resources/Icons/V3/approved-coverage.json:8` still says light "#1E5AA8"). Pixels not re-measured.
12. **HUNT3 3.8, computations sheet in blue: STILL THERE.** See summary item 1.
13. **HUNT3 3.9, water tank preview blue: STILL THERE.** `Dialogs/WaterTankDialog.xaml:232` and `Dialogs/WaterTankPlanBlockPickerDialog.xaml:52`.
14. **HUNT3 3.10, Structural hard-coded blues: STILL THERE in 1.0.118.** `CeHatchPresetDialog.cs:86, 210, 343` (#2563EB), `NoteEntryDialog.xaml.cs:309, 532`, `NotesBrowserDialog.xaml.cs:572, 777` (#0078D4), `RCBeamPickerDialog.xaml:19` (#2563EB), `RCMemberDialog.xaml.cs:274`, `ViewSuggestionsDialog.xaml.cs:219`. Note `CeHatchPresetDialog.cs:512-513` maps AutoCAD colour 4 and 5 to cyan and blue for a picture of the hatch colour; that is a picture of the drawing colour and should stay.
15. **HUNT3 3.14, the pit snap glow in the drawing is light blue: STILL THERE** (`Services/SnapTargetFeedback.cs:100`). Still a question for Tim, not a defect.

---

## Rulebook note

`ENGINEERING_RULEBOOK.md` holds engineering values only (ARI, runoff, velocities, orifice, cover). It has no wording, colour or spelling rule, so none of the findings above contradict it. The wording rules used here are Tim's: plain English, gold / black / white / grey with no blue (INT-075 Batch 3 item 8), plain name plus command during the transition (UX-NAMES-03, INT-075), Australian spelling, metric.

---

## Cheap guards that would catch most of this (RED tests)

1. **No blue:** one test that reads every `.xaml` and `.cs` colour in `Modules\*` and `Shared\*` and fails when blue is stronger than red by more than 25 and green by more than 8, with a short allow-list Tim approves (the AutoCAD colour-index pictures, the long-section water line if he agrees).
2. **No program words on screen:** a test over the visible-string sinks that fails on "entity", "entities", "persisted", "snapshot", "cache", "payload", "JSON", "handle", "registered" (except where the word is the AutoCAD or CE term for a thing a drafter knows).
3. **Australian spelling:** fails on "Center", "center", "Normalize", "authorized", "Color" in label and title strings (with AutoCAD's own "Color" on an allow-list if Tim wants it).
4. **Units:** fails on a number followed by "m3", "m2" or "l/s" in a screen string (drawing text on an allow-list).

---

## Summary (one paragraph)

I read Civil 3.0.56 and Manager 1.1.56 (`rel-20261019b`) and Structural 1.0.118 (`rel-20261017s`) for blue, program words, spelling and units, and re-checked the 9 Oct HUNT3 list against them: about 15 of its items are still there (the light-theme blue in all three products, the blue computations sheet, the Structural start-up text with four commands that look unregistered, the Structural ribbon with no command names) and the PITEDIT, RunSolve and PITDELETE wording is now fixed. I found 10 new groups, none of which puts a wrong number on a drawing: the command-names switch cannot turn off 44 of 65 Civil brackets, the slab "Pit cover (P3, 450mm): 12.345" line reads as a depth when it is a level, "Repair Center" is spelt the American way in seven places, the Structural module is blue in Suite Manager, about 20 Civil and 11 Structural sentences still use program words, units are written "m3" and "m²" and "l/s" and "L/s" in different places, and window titles and button names disagree. Nothing was run or seen in AutoCAD, the ribbon icon pixels and the help pages' text were not re-checked, and a few strings may only reach the log, which I flagged where I could not tell.
