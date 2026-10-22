**ANSWER FIRST — independent WPF window hunt, 22 October brief; completed 23 October 2026, Melbourne**

1. **Counts: HIGH 1 / MEDIUM 6 / LOW 2.** Nine distinct findings, verified-by-reading. Their AutoCAD demonstrations are NOT RUN. The inventory below is a source inventory, not thousands of additional defects.

2. **Most important: several Structural windows use the wrong screen measurements at 150%.** Drawing Sheets sizes itself using screen pixels as though they were unscaled window units. On a 5120 × 1440 display this can put the bottom of its window beyond the screen. A separate minimum-size fault affects the beam picker on a 1920 × 1080 display.

3. **Civil + Manager before 9 November:** prioritise Settings saving when Enter was intended to search, remembering the main editors' positions, and the stale dark/light appearance of the two Checks palettes. About always selects its light appearance. None of this authorises a release block or restarting parked Manager administrator work.

4. **Delivered:** findings, exact failure scenarios, proposed deterministic tests and a complete static declaration inventory for the window/control scope below. No plugin file, drawing, setting, installation or branch was changed. No build, tests, AutoCAD or sub-agent was started. Only this findings file is authored in CE_PLAN.

---

1. **Source and scope.** C = Civil + Manager/shared source at origin/claude/rel-20261022m, commit 40ee0a36f7960145743954b39859eb6c3af92869 (brief nominates Civil 3.0.70 / Manager 1.1.70). S = Structural source at origin/claude/rel-20261022s2, commit 2c9a96942a024888a5ab520600f2d5025de83036 (Structural 1.0.121). Fetched origin; inspected Git objects, not working-tree source. All file:line references refer to C unless marked S. Installed DLLs were not independently inspected.

2. **Deduplication and limits.** Read the requested AUDIT_C58_C60_S40_S41_2026-10-22 and CODEX_AUDIT_CIVIL/GATE/STRUCTURAL_22OCT reports. Do not recount the source double-click doorway, ignored checks, outcome logging, missing engineering Settings rows, installer faults or Structural engineering calculations. Read Tim's RULES and ROUTER, START_HERE and MASTER_PLAN. This is desk plan/03's independent window hunt; the brief overrides worktree/build/PR/bug-register instructions. Manager's PluginAdminWindow is excluded. Structural's drawing-tools AdminHubWindow is included because it is a drafting surface, not Manager administration.

3. **Evidence language.** Verified-by-reading means the stated source behaviour or calculation is proved, not that a screenshot or host result exists. Where DPI/ownership affects manifestation, the fixture explicitly measures that condition. Suspected probes are separated below and excluded from the counts. This audit cannot certify focus, clipping or native UI Automation without launching the actual windows.

4. **Test conditions for the later test lane.** Use synthetic copies only: WINDOWS_AUDIT.dwg, millimetres, Civil designation, two ordinary CE pipes P1–P2 and P2–P3, three pits with valid levels, and a tagged source DP1. Run the applicable Civil cases on AutoCAD 2024/net48 and 2027/net10. Use 1920 × 1080 and 5120 × 1440 at 100% and 150%; repeat with the second screen to the left (negative X). Capture actual HWND and work-area rectangles, WPF DPI transform, keyboard focus and UIA tree. Guard test Settings and restore exact original bytes afterwards. All steps below remain instructions, not results.

**Numbered findings**

1. **HIGH — Structural's shared host treats screen pixels as unscaled window units. Verified-by-reading, conditional on the measured 150% WPF transform.**

   **File:line:** S, Modules/Structural/UI/AutoCadWindowHostHelper.cs:49, :59, :61, :102, :105, :112, :118, :164; caller Modules/Structural/Commands/SheetsCommands.cs:25 and :26; Settings caller Services/CeSettingsUiService.cs:39.

   **For Tim:** Drawing Sheets, Settings and several other windows can open too large and too far across the monitor. Their lower buttons may be beyond the visible screen even though CE says it is fitting the window to AutoCAD.

   **Exact failure scenario:** both ConfigureOwnerAndRelativeBounds and ConfigurePaletteOwnerAndBounds copy GetWindowRect dimensions and desktop coordinates directly into Window.Width/Height/Left/Top. There is no pixel-to-WPF conversion or monitor work-area intersection. With native AutoCAD bounds (0,0)–(5120,1440), CESHEETS requests Width 4403.2 and Height 1296 in WPF units, Left 358.4 and Top 72. At a measured transform of 1.5, those dimensions request approximately 6605 × 1944 physical pixels. At 100% they request 4403 × 1296. An offset secondary monitor also has its offset incorrectly scaled. Windows may constrain some final geometry; that does not repair the source calculation or establish visible footer controls.

   **DETERMINISTIC TEST:** fixture: maximise AutoCAD on the 5120 × 1440 monitor at 150%, with a synthetic drawing and no prior window placement. Type CESHEETS. Read the native frame and WPF TransformToDevice; require 1.5 for this case. Assert every visible footer button's physical rectangle lies inside the selected monitor's work area, the window's width is at most that work area, and the drawing-sheet controls can be reached without moving the window. Repeat at 100% as the control, then with AutoCAD on a secondary screen at X=1920 and at negative X. Repeat CESETTINGS and the palette's Drawing standards route; these share the helper. Record window title, rectangles and screenshots. No update or publish action is needed.

   **Why text tests miss it:** pure ratio calculations without the real HWND/DPI boundary can all pass. The two coordinate systems must be tested together.

2. **MEDIUM — several Structural windows cannot fit a 1080p screen at 150%, even after correcting the host conversion. Verified-by-reading.**

   **File:line:** S, Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.xaml:5, RCMemberDialog.xaml:5, CeSettingsDialog.xaml:5; direct picker caller Commands/SbeamCommandRunner.cs:30; host minimum enforcement UI/AutoCadWindowHostHelper.cs:104 and :204.

   **For Tim:** the beam picker and Structural Settings demand a window taller than the available screen. Dragging the edge smaller cannot reveal a complete usable layout.

   **Exact failure scenario:** at 150%, 1920 × 1080 gives at most 1280 × 720 WPF units before taskbar allowances. SteelSectionPickerDialog has MinWidth=1340, MinHeight=820; RCMemberDialog has 1060 × 850; CeSettingsDialog has 1180 × 850. SBEAM opens the picker directly with ShowModalWindow, without responsive sizing. The other host paths preserve their minima. These minima exceed the entire screen; this is separate from finding 1's conversion fault. At 5120 × 1440/150% the 960-unit total height can accommodate these minima, so that display alone would miss this defect.

   **DETERMINISTIC TEST:** fixture: empty metric drawing, 1920 × 1080 at 150%, measured WPF transform 1.5. Type SBEAM. Assert the title, section search, section choices, Cancel and Place are simultaneously within the monitor work area; drag smaller and repeat. The current minimum alone requires 2010 × 1230 pixels. Cancel without drawing. Type CESETTINGS and assert Save/Cancel and the selected settings page are simultaneously accessible. Capture the actual buttons' UIA rectangles, not just a screenshot of the top. Repeat the same openings at 100% and on the ultrawide as controls.

3. **MEDIUM — Enter in a Settings search with no matches saves the whole draft. Verified-by-reading.**

   **File:line:** Modules/Drainage/Dialogs/AdvancedSettingsDialog.xaml.cs:57 and :62; Dialogs/AdvancedSettingsDialog.xaml:237 and :1432; ViewModels/AdvancedSettingsViewModel.cs:1104 and :1113.

   **For Tim:** a drafter changes a value, searches for another setting, mistypes the search and presses Enter. CE saves the changes and closes Settings, although the drafter was still looking for a setting.

   **Exact failure scenario:** the search's PreviewKeyDown consumes Enter only when SearchResults.Count > 0. With zero results it leaves Enter unhandled. Save remains IsDefault=True and calls ExecuteOk, which applies the draft and closes the window. The search box is single-line. This is not a claim that every Enter key should be disabled: the defect is the unsuccessful search falling through to an unrelated acceptance action. Microsoft's documented default-button contract confirms Enter invokes it. [WPF default button](https://learn.microsoft.com/en-us/dotnet/api/system.windows.controls.button.isdefault?view=windowsdesktop-10.0).

   **DETERMINISTIC TEST:** isolated valid Settings fixture, level text “In from the pipe end” = 100 mm. Type CDS; change that field to 125; click the search box and type zzzz_no_setting_22oct. Verify SearchResults.Count=0 in the UI probe. Press Enter once. Assert the Settings window is still visible, the draft is still pending, and the persisted value remains 100. Current route calls Save and closes with 125. Reopen and read the field as the window-text oracle. Positive control: searching a real result then Enter must jump to its tab without saving.

4. **MEDIUM — Remember window position skips Edit Pipe, Edit Pit, New Pit and CDS. Verified-by-reading; switch-dependent.**

   **File:line:** Modules/Drainage/Services/CeWindowPlacementHook.cs:49, :100 and :101; Dialogs/PitWindowLayout.cs:27; Dialogs/PipeWindowLayout.cs:13; Dialogs/AdvancedSettingsDialog.xaml.cs:82; Services/WindowSizingService.cs:173; Models/UserSettings.cs:2521.

   **For Tim:** after moving an editor away from the pipe or pit being checked, its next opening returns to CE's calculated centre. Turning on “remember” does not make these high-use windows remember.

   **Exact failure scenario:** PitWindowLayout.Apply sets WindowStartupLocation.Manual; PipeWindowLayout calls it; CDS's successful TryFitTabbedEditor path also sets Manual, and its fallback does likewise. These run at SourceInitialized, before the placement hook's Loaded handler. PlanFor treats Manual as “leave alone” and returns before either restoring a position or subscribing the tracker. Manual here is just CE's fitting result, not a drafter's request to opt out. Default Remember=false is not itself a fault; this finding requires it true.

   **DETERMINISTIC TEST:** isolated profile with windowPlacement.remember=true. On a 5120 × 1440 monitor, type PIPEEDIT, pick pipe P1–P2, move the window 200 physical pixels left while keeping it inside the work area, and Cancel. Reopen the same pipe. Assert its top-left is within 2 physical pixels of the moved position. Repeat PITEDIT on P2, PIT then Cancel, and CDS. Repeat once after Inspect Drawing for the editor route. Current source has no save/restore subscription for these windows. A window genuinely designed to position itself permanently may remain exempt; these normal editors must not inherit that exemption accidentally.

5. **MEDIUM — Civil Hub rejects a valid saved position on a secondary monitor; other Civil sizing paths also clamp to the primary monitor. Verified-by-reading.**

   **File:line:** Modules/Drainage/Dialogs/CivilHubDialog.xaml.cs:419, :449, :459 and :467; Services/CeWindowPlacementHook.cs:26; Services/WindowSizingService.cs:189, :214 and :216; representative callers Dialogs/CdLinkDialog.xaml.cs:17 and CalculationsV2Dialog.xaml.cs:115.

   **For Tim:** leave Civil Hub on the large second screen and reopen it: CE can move it back to the small primary screen. A valid monitor position is treated as though that monitor had disappeared.

   **Exact failure scenario:** Civil Hub saves desktop Left/Top, but restores against SystemParameters.WorkArea, which describes the primary work area. An ordinary secondary-screen X lies outside that rectangle and is replaced/clamped to the primary rectangle. The shared hook deliberately excludes CivilHubDialog, so it cannot correct this. ApplyPreferredWindowSize also calculates owner-relative bounds and then clamps them against the primary work area. The saved-Hub reproduction is independent of WPF's later CenterScreen placement behaviour in other windows.

   **DETERMINISTIC TEST:** two monitors at 100% for an unambiguous coordinate fixture: primary 1920 × 1080 at X=0; secondary 5120 × 1440 at X=1920. Set checks.checksCommandEnabled=false so CDHUB opens Civil Hub, not the newer Checks palette. Type CDHUB, move it wholly onto the second monitor with Left=2200, close and reopen. Assert its native centre remains on monitor 2 and its Left is restored within 2 pixels. Current restore logic classifies 2200 as outside the primary work area. Repeat with the second monitor left of primary and at 150%. Restore the routing switch afterwards.

6. **MEDIUM — Checks and What CE Found retain their old dark/light appearance, even after closing and reopening the palette. Verified-by-reading.**

   **File:line:** Modules/Drainage/Controls/ChecksListControl.xaml.cs:12; Controls/DrawingCheckPanelControl.xaml.cs:11; Services/ThemeService.cs:107, :118, :219 and :220; Services/ChecksListPaletteService.cs:57 and :59; Services/DrawingCheckPaletteService.cs:43; Dialogs/AdvancedSettingsDialog.xaml.cs:24; ViewModels/AdvancedSettingsViewModel.cs:235.

   **For Tim:** choose Light while the Checks list is dark, and it stays dark. Closing its palette and opening it again still shows the old appearance. CDS's own live preview has the same local-resource problem.

   **Exact failure scenario:** ApplyThemeToControl installs a theme dictionary directly on the palette control. ApplyResolvedTheme replaces only Application.Current.Resources. The nearer control dictionary continues to win resource lookup; the two palette controls have no refresh handler. Their static hosts return early once created, including after hiding/closing the palette. CDS preloads a local dictionary too; SelectedTheme previews the global dictionary without replacing that local copy. Manager's separate CeManagerAppearanceService has a refresh route, so this finding does not indiscriminately accuse every CE window.

   **DETERMINISTIC TEST:** saved Civil theme Dark, checks.checksCommandEnabled=true. Type CDCHECKS; note the palette BackgroundBrush value via the WPF probe and capture its appearance. Open CDS, Display, choose Light, Save. Reopen CDS: its new instance should be light. The still-open Checks palette must match it. Close Checks with X and type CDCHECKS again; assert it remains light and its BackgroundBrush equals the LightTheme.xaml resource. Current cached control keeps the dark resource. Repeat in reverse. Repeat CDCHECKCURRENT with checks.checksCommandEnabled=false for What CE Found. Separate preview assertion: CDS changes its own background immediately when Light is selected, and Cancel restores the saved appearance.

7. **LOW — About CE Suite is always painted with Manager's light palette. Verified-by-reading.**

   **File:line:** Modules/Manager/UI/Dialogs/CeVersionWindow.xaml:14; UI/Dialogs/CeVersionWindow.xaml.cs:17; Commands/PluginManagerCommands.cs:31. Contrast UI/Dialogs/PluginManagerWindow.xaml.cs:38.

   **For Tim:** About opens as a bright window while AutoCAD and Manager are dark. Changing the appearance preference does not change About.

   **Exact failure scenario:** About merges Theme.SwissModern.xaml locally and never attaches CeManagerAppearanceService. The command directly shows the new window, without that service. This is a missing theme route, not a request to redesign its styling.

   **DETERMINISTIC TEST:** Follow AutoCAD preference; type COLORTHEME, 0; open CEMANAGER and confirm its dark appearance; close/leave it aside, type CE_VERSION. Assert About's UiBackgroundBrush equals Theme.SwissModern.Dark.xaml's value. Current source loads the light resource. Close with Esc, repeat COLORTHEME=1, CE_VERSION and assert the light value. Record title “About CE Suite”, brush values and screenshots.

8. **LOW — Escape in Edit 2 Pipes' Inspect Drawing prompt reopens the editor instead of cancelling. Verified-by-reading.**

   **File:line:** Modules/Drainage/Commands/BatchEditDialogHost.cs:38, :43, :47 and :48.

   **For Tim:** while looking at the drawing from Edit 2 Pipes, Escape does not end the edit. The window comes back and requires another cancellation.

   **Exact failure scenario:** the host calls Editor.GetString for “Press Enter to reopen CDEDIT:” and discards the returned PromptStatus. Both Enter and Cancel proceed to continue, which constructs another batch window with the same draft. This is not the already-known source-tag double-click problem.

   **DETERMINISTIC TEST:** synthetic two-pipe fixture; select P1–P2 and P2–P3, type CDEDIT. Tick Diameter, enter a different valid diameter, click Inspect Drawing. At “Press Enter to reopen CDEDIT:” press Esc once. Assert no batch window reappears, the command returns to Command:, and both drawing diameters remain unchanged. Current loop reopens. Positive control: Enter reopens with the pending diameter and tick preserved; Cancel then leaves both original diameters. Do not infer success merely from the absence of drawing changes.

9. **MEDIUM — some test-critical fields have no stable semantic identity; counting rendered windows cannot verify them. Verified-by-reading; actual UIA trees unmeasured.**

   **File:line:** Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:47 and :52; Modules/Drainage/Dialogs/CivilImportWindow.xaml:133 and :171; full declaration/construction inventory follows.

   **For Tim:** an automated check can see that Manager opened but cannot select “running build” versus “installed build” by a reliable name. That can let the robot read the wrong value and pass the window. The two import review lists have the same identification gap.

   **Exact failure scenario:** Manager repeats two unnamed read-only TextBoxes per module card. Neither has AutomationId, x:Name/Name, AutomationProperties.Name or LabeledBy; adjacent “Running now” and “Installed next start” TextBlocks are not linked labels. The Civil import schedule/results ListBoxes likewise omit identity. These controls can still be reached by tree position or coordinates, but that is not a stable named oracle. Conversely, an unnamed Button with Content=Cancel can expose UIA Name=Cancel; the blanket statement “no explicit name means UIA cannot find it” is false. [Microsoft UI Automation testing guidance](https://learn.microsoft.com/en-us/dotnet/framework/ui-automation/using-ui-automation-for-automated-testing).

   **DETERMINISTIC TEST:** fixture Manager with Civil and Manager loaded, and a controlled test card whose running/installed detail strings differ. Type CEMANAGER; select its status view. Use UIA to find each module card, then query semantic names for running detail and installed detail without coordinates, child indices or matching their changing values. Assert exactly one match for each and that their ValuePattern text matches the expected fixture build. Current declarations cannot supply these identities. For CDIMPORTXCIVIL, use a synthetic package with one pit and one pipe; reach Pit and pipe schedule, then Results and review, and locate each review list by its own stable identifier. Assert expected row text under the correct list. Repeat at 150% and in both themes.

**Window-route coverage and checks not counted as further defects**

1. **Edit Pipe / Edit Pit / New Pit.** Followed DialogService, native context capture, one-page composition, More options, focus registration, acceptance/cancellation and Inspect-session lifetime. Their bound core controls receive runtime C2 identifiers through WorkshopEditorFocus. Do not report every absent XAML ID here as a missing runtime ID. Window X does not return an accepted result. The source does not prove native focus or drawing rollback; test diameter/level edits followed by Cancel, Esc and X independently and compare drawing values.

2. **Edit 2 Pipes.** Followed BatchEditDialogHost and the shared model's Apply/Cancel RequestClose. The old window's event subscription is retained across Inspect loops, but the catch and WPF's idempotent closed-window Close defeat the tempting claim that Apply necessarily fails. This is not counted as a broken Apply. Framework check: [WPF Window implementation](https://github.com/dotnet/wpf/blob/main/src/Microsoft.DotNet.Wpf/src/PresentationFramework/System/Windows/Window.cs). Its scroll fallback needs a real small-screen inspection; no picture was made here.

3. **Edit source.** SourceEditDialog.xaml:34 binds TagText, not Window.Tag; code-behind :28 focuses/selects the tag. OK/default and Cancel/Escape are wired; X leaves the model's default Cancel outcome. Test with DP1 preselected and CDEDIT, avoiding the previously audited broken double-click doorway: type DP2 then Cancel/Esc/X separately, assert DP1 remains; type DP2 then Enter, assert DP2. This is proposed coverage, not a new fault.

4. **CDS.** Traced search, Save/Cancel, OnClosed disposal and theme preview. Dispose restores the saved preference; X is not proved to persist a draft. The current previous-review Settings fit problem is not recounted. Finding 3 covers a different acceptance route. On a short screen, inspect every tab with longest help/error wording and verify Save/Cancel remain visible; the layout measurement alone cannot certify readable text.

5. **Checks / What CE Found.** These are PaletteSets hosting WPF controls, not modal Windows. Their lists are deliberately bounded scrolling areas. Checked document guards: Show where refuses another drawing, and the older palette protects its saved document identity. Theme defect is finding 6. Suspected/unscored DPI risk: What CE Found's minimum is 460 × 820 physical pixels (DrawingCheckPaletteService.cs:24), while its WPF layout scales independently. Run both palettes at their actual minimum at 150%; assert every tab and footer action's UIA rectangle is visible. Do not substitute a 460 × 820 WPF render.

6. **X-Civil import.** Actual source/schedule/results callers use Application.ShowModalWindow (LinkCommands.ImportXcivil.cs:66, :174, :230), bypassing DialogService's help/sizing hooks. Esc is handled explicitly; X/Close leave ContinueRequested=false. Continue is enabled only by the model. Suspected/unscored: fixed initial 1160 × 760 with no fit pass may overflow 1080p/150%, but the native host's final sizing was not observed. Assert the source chooser, Continue and Close are on screen. The folder picker uses an ownerless WinForms ShowDialog at CivilImportWindow.xaml.cs:61; measure focus/owner after opening it rather than declaring it lost without evidence.

7. **Help Centre and HTML Help.** Shared HelpCentreView owns Escape/Ctrl+F/PageUp/PageDown; standalone HelpCentreWindow additionally routes preview keys. Embedded Help's Close minimises its host by design. No definite double-command fault was found. F1 from Civil's modal editors opens modeless HelpGuideWindow owned by AutoCAD, not the active editor (HelpLauncher.cs:43). Suspected/unscored ownership test: PIPEEDIT P1–P2, F1, click a named help link, close Help, then Esc the editor; assert Help receives focus while open and the pipe remains unchanged. Repeat More options, Manager embedded Help and both runtime lanes; net48 uses browser fallback.

8. **About and non-administrator Manager.** Traced CE_VERSION modal entry, CEMANAGER modeless lifetime, minimise/reopen restoration and appearance service. Main Manager has a restore-before-activate path. Findings 7 and 9 are the definite gaps. Manager administrator window and its update-authority work remain excluded. No new release gate or administrator feature is proposed.

9. **Other Civil/Structural windows.** The full declaration inventory below includes the remaining windows, embedded pages and shared templates. Read-only cross-cutting sweeps covered owner/show calls, Esc/Enter/close handlers, dimensions, work-area calculations, theme attachment and identifier assignment. This is not a claim that every branch of every view model was reviewed or that all 91 XAML windows are reachable in the installed configuration.

**Automation inventory — how to read it**

1. **What is listed.** Every explicit WPF control/readout declaration lacking all four direct identity attributes: AutomationProperties.AutomationId, AutomationProperties.Name, x:Name and Name. Templates are listed once at the declaration that generates their repeated instances. Line numbers let the builder find each declaration without changing this source. Inputs/actions and passive readouts/containers are separated; labels, images and separators are not each counted as functional defects.

2. **Scope and exclusions.** All production XAML under Modules/Drainage, Modules/Manager and Shared/CE_SHARED/Help at C, and Modules/Structural/UI at S; shared theme templates included. Test fixtures, image/resource assets and Manager PluginAdminWindow are excluded. Native AutoCAD title bars, WinForms dialogs and WebView HTML descendants have no XAML AutomationProperties; they need their own native/DOM selectors and are not falsely called missing WPF properties.

3. **Runtime exceptions.** WorkshopEditorFocus.cs:64–87 assigns C2.<binding-path>[.<parameter>] plus names to bound TextBox, ComboBox, ToggleButton and Button controls in the pipe/pit workshop and attached fallback/More sessions. PipeOnePageLayout.cs:59 and :280, PitOnePageLayout.cs:229/:244/:280, PipePreviewInteraction.cs:31 and PitConnectionSelector.cs:29 add further names. Declarations marked “workshop runtime coverage” below are absence-in-XAML inventory, NOT evidence of a missing runtime identity. Retained CdDialog/PitDialog naming depends on the caller attaching that lifecycle. Repeated data-template instances also need row scoping.

4. **Limits of static completeness.** A property's absence in a declaration is verified; an empty UIA Name at runtime is not automatically proved. Caption-derived names, style setters, helper assignments and generated native template parts can supply identity. The C# index separately enumerates control-construction sites and naming assignments, including programmatic windows. It is a review list, not a false claim that every constructor site is unnamed. A complete runtime list of unfindable controls is impossible under this brief's no-launch restriction.

5. **DETERMINISTIC INVENTORY TEST, not run.** On each named window/page below, instantiate the real production route, select every tab and expand each permitted list/menu. Dump the UIA ControlView tree after Loaded, including ControlType, AutomationId, Name, LabeledBy, parent identity, BoundingRectangle and supported patterns. Assert every input/action and required result readout has a nonempty, stable, unique selector within its window and row. Require fresh instances and theme/DPI changes to preserve selectors; exclude decorative nodes explicitly. Fail empty semantic inputs and duplicate unscoped action selectors, not every unnamed border or captioned button. Capture empty, populated, validation and repeated-row states.


**Full XAML declaration inventory**

1. **Static totals.** 139 XAML files scanned; 91 Window declarations; 4542 control/readout declarations without a direct identity attribute; 1273 with at least one. These are source-declaration counts, not UIA failures or live-window counts.

2. **C — Modules/Drainage/Controls/CeAssistantControl.xaml.** Missing direct identity: 9.

   **Input/action/template — Button:** lines 103.

   **Readout/container — Image:** lines 84.

   **Readout/container — TextBlock:** lines 38, 43, 91, 96, 100, 128.

   **Readout/container — UserControl:** lines 1.

3. **C — Modules/Drainage/Controls/CeEditorShell.xaml.** Missing direct identity: 11.

   **Input/action/template — Button:** lines 150, 163.

   **Readout/container — Image:** lines 42.

   **Readout/container — ProgressBar:** lines 140.

   **Readout/container — ScrollViewer:** lines 114.

   **Readout/container — TextBlock:** lines 51, 68, 87, 106, 145.

   **Readout/container — UserControl:** lines 1.

4. **C — Modules/Drainage/Controls/CeFieldRow.xaml.** Missing direct identity: 4.

   **Readout/container — TextBlock:** lines 55, 62, 66.

   **Readout/container — UserControl:** lines 1.

5. **C — Modules/Drainage/Controls/CePipePreviewControl.xaml.** Missing direct identity: 5.

   **Readout/container — TextBlock:** lines 15, 19, 22, 23.

   **Readout/container — UserControl:** lines 1.

6. **C — Modules/Drainage/Controls/CePitPreviewControl.xaml.** Missing direct identity: 1.

   **Readout/container — UserControl:** lines 1.

7. **C — Modules/Drainage/Controls/CeProvenanceChip.xaml.** Missing direct identity: 1.

   **Readout/container — UserControl:** lines 1.

8. **C — Modules/Drainage/Controls/CeSuggestionStrip.xaml.** Missing direct identity: 5.

   **Input/action/template — Button:** lines 42.

   **Readout/container — TextBlock:** lines 29, 33, 57.

   **Readout/container — UserControl:** lines 1.

9. **C — Modules/Drainage/Controls/ChecksListControl.xaml.** Missing direct identity: 17.

   **Input/action/template — Button:** lines 121, 125, 128.

   **Readout/container — Image:** lines 37.

   **Readout/container — ScrollViewer:** lines 16.

   **Input/action/template — TabItem:** lines 83, 106.

   **Readout/container — TextBlock:** lines 40, 42, 64, 67, 92, 96, 99, 110, 118.

   **Readout/container — UserControl:** lines 1.

10. **C — Modules/Drainage/Controls/DesignImpactHubPage.xaml.** Missing direct identity: 32.

   **Input/action/template — Button:** lines 168, 169, 185.

   **Input/action/template — ListBox:** lines 113, 154.

   **Input/action/template — TabItem:** lines 110, 146.

   **Readout/container — TextBlock:** lines 30, 31, 66, 68, 69, 72, 79, 80, 85, 86, 91, 92, 97, 98, 103, 104, 118, 132, 133, 135, 141, 142, 153, 167.

   **Readout/container — UserControl:** lines 1.

11. **C — Modules/Drainage/Controls/DrawingCheckPanelControl.xaml.** Missing direct identity: 60.

   **Input/action/template — Button:** lines 304, 307, 310, 370, 373, 377, 380.

   **Readout/container — Image:** lines 90.

   **Readout/container — ItemsControl:** lines 352.

   **Readout/container — ScrollViewer:** lines 17, 182, 352.

   **Input/action/template — TabItem:** lines 146, 165, 235, 281.

   **Readout/container — TextBlock:** lines 39, 41, 43, 47, 54, 61, 63, 93, 100, 123, 138, 148, 149, 151, 152, 154, 155, 158, 160, 175, 183, 189, 192, 194, 197, 199, 202, 205, 209, 228, 242, 251, 275, 292, 298, 314, 318, 332, 333, 348, 349, 355, 367.

   **Readout/container — UserControl:** lines 1.

12. **C — Modules/Drainage/Controls/InspectorPanelControl.xaml.** Missing direct identity: 207.

   **Input/action/template — Button:** lines 20, 33, 111, 112, 113, 340, 390, 491, 530, 542, 543, 553, 563, 573, 583, 593, 607, 657, 674, 676, 677, 678.

   **Readout/container — GroupBox:** lines 128, 166, 208, 229, 251, 272, 303, 352, 361, 404, 418, 494, 537, 622, 646, 659.

   **Readout/container — Image:** lines 78.

   **Readout/container — ItemsControl:** lines 353, 362, 435, 661.

   **Input/action/template — ListBox:** lines 99, 102, 105, 496.

   **Readout/container — ScrollViewer:** lines 332, 400, 660.

   **Input/action/template — TabItem:** lines 98, 101, 104, 123, 125, 331, 372, 399, 452, 454, 533, 612.

   **Readout/container — TextBlock:** lines 17, 18, 19, 32, 80, 81, 82, 83, 109, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 219, 220, 221, 222, 223, 224, 231, 235, 239, 243, 262, 263, 264, 265, 266, 267, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 300, 315, 316, 317, 318, 319, 320, 321, 322, 327, 339, 347, 348, 374, 378, 379, 385, 392, 393, 402, 406, 407, 408, 409, 410, 411, 412, 413, 421, 423, 424, 425, 426, 427, 428, 434, 438, 445, 473, 474, 477, 478, 481, 482, 485, 486, 492, 511, 512, 517, 535, 540, 549, 550, 559, 560, 569, 570, 579, 580, 589, 590, 599, 600, 603, 619, 634, 635, 639, 640, 650, 651, 664.

   **Readout/container — UserControl:** lines 1.

13. **C — Modules/Drainage/Controls/NetworkRedesignHubPage.xaml.** Missing direct identity: 119.

   **Input/action/template — Button:** lines 286, 287, 298, 305, 322, 323, 344, 365, 366, 367, 380, 406, 407, 423, 440.

   **Input/action/template — DataGrid:** lines 160, 172, 188, 200, 215, 227, 241.

   **Input/action/template — DataGridTextColumn:** lines 162, 163, 164, 165, 166, 167, 174, 175, 176, 177, 178, 179, 190, 191, 192, 193, 194, 195, 202, 203, 204, 205, 206, 207, 208, 217, 218, 219, 220, 229, 230, 231, 232, 233, 234, 235, 236, 243, 244, 245, 246, 247, 248.

   **Input/action/template — ListBox:** lines 256, 327, 370.

   **Input/action/template — TabControl:** lines 158, 186, 225.

   **Input/action/template — TabItem:** lines 157, 159, 171, 185, 187, 199, 214, 224, 226, 240, 254, 276, 311, 352.

   **Readout/container — TextBlock:** lines 68, 110, 112, 113, 117, 119, 126, 127, 132, 133, 138, 139, 144, 145, 150, 151, 260, 265, 284, 296, 297, 303, 304, 319, 320, 337, 338, 369, 373, 385, 386, 403, 404.

   **Readout/container — UserControl:** lines 1.

14. **C — Modules/Drainage/Controls/PipePreviewControl.xaml.** Missing direct identity: 2.

   **Readout/container — TextBlock:** lines 102.

   **Readout/container — UserControl:** lines 1.

15. **C — Modules/Drainage/Controls/SearchableComboBox.xaml.** Missing direct identity: 1.

   **Readout/container — UserControl:** lines 1.

16. **C — Modules/Drainage/Controls/SlabSurfacePreviewControl.xaml.** Missing direct identity: 1.

   **Readout/container — UserControl:** lines 1.

17. **C — Modules/Drainage/Controls/StatusChip.xaml.** Missing direct identity: 1.

   **Readout/container — UserControl:** lines 1.

18. **C — Modules/Drainage/Dialogs/AdvancedSettingsDialog.xaml.** Missing direct identity: 246.

   **Input/action/template — Button:** lines 253, 628, 1111, 1117, 1132, 1428, 1432.

   **Input/action/template — CheckBox:** lines 794.

   **Readout/container — Image:** lines 210.

   **Input/action/template — RadioButton:** lines 325, 328, 375, 378, 879, 882, 1016, 1019, 1022, 1149, 1153, 1156.

   **Readout/container — TextBlock:** lines 215, 222, 226, 259, 261, 264, 280, 295, 310, 314, 321, 339, 346, 354, 361, 364, 371, 389, 396, 405, 412, 423, 430, 436, 444, 451, 459, 466, 468, 471, 479, 486, 494, 501, 503, 514, 529, 533, 541, 548, 556, 563, 565, 568, 576, 583, 585, 593, 600, 602, 607, 612, 617, 622, 626, 631, 634, 642, 649, 651, 662, 679, 683, 691, 698, 707, 714, 722, 729, 737, 744, 746, 752, 755, 759, 762, 766, 768, 772, 774, 778, 780, 784, 787, 791, 799, 807, 815, 825, 831, 832, 834, 837, 850, 865, 869, 876, 887, 890, 893, 898, 901, 909, 916, 918, 920, 926, 928, 929, 933, 935, 936, 940, 955, 957, 959, 962, 964, 966, 969, 971, 973, 987, 1002, 1006, 1013, 1027, 1033, 1041, 1048, 1050, 1061, 1076, 1080, 1084, 1087, 1090, 1096, 1099, 1103, 1109, 1115, 1122, 1127, 1129, 1130, 1134, 1138, 1145, 1161, 1164, 1167, 1174, 1183, 1196, 1198, 1201, 1204, 1215, 1217, 1220, 1224, 1226, 1230, 1232, 1235, 1238, 1241, 1244, 1250, 1252, 1255, 1258, 1261, 1272, 1274, 1285, 1287, 1290, 1293, 1296, 1307, 1309, 1320, 1322, 1325, 1333, 1337, 1339, 1341, 1343, 1345, 1347, 1349, 1351, 1353, 1355, 1357, 1359, 1361, 1364, 1366, 1368, 1370, 1372, 1374, 1376, 1377, 1379, 1381, 1383, 1385, 1387, 1389, 1391, 1393, 1395, 1397, 1399, 1401, 1403, 1405, 1407, 1421.

   **Readout/container — Window:** lines 1.

19. **C — Modules/Drainage/Dialogs/BatchEditWorkshopDialog.xaml.** Missing direct identity: 36.

   **Input/action/template — Button:** lines 383, 388, 391.

   **Readout/container — Image:** lines 197.

   **Readout/container — ItemsControl:** lines 239, 258, 319, 355.

   **Input/action/template — RadioButton:** lines 344, 349.

   **Readout/container — ScrollViewer:** lines 222, 261.

   **Readout/container — TextBlock:** lines 107, 151, 158, 162, 166, 201, 204, 217, 231, 233, 235, 250, 252, 254, 274, 277, 311, 313, 315, 332, 359, 365, 369.

   **Readout/container — Window:** lines 1.

20. **C — Modules/Drainage/Dialogs/CalculationsDialog.xaml.** Missing direct identity: 194.

   **Input/action/template — Button:** lines 34, 190, 537.

   **Input/action/template — CheckBox:** lines 181.

   **Input/action/template — ComboBox:** lines 139.

   **Input/action/template — DataGrid:** lines 36, 244, 514.

   **Input/action/template — DataGridTextColumn:** lines 39, 40, 41, 42, 247, 248, 249, 250, 251, 252, 524, 525.

   **Readout/container — ItemsControl:** lines 107, 162, 200, 322, 389, 503.

   **Readout/container — ScrollViewer:** lines 49, 265.

   **Input/action/template — TabControl:** lines 19.

   **Input/action/template — TabItem:** lines 48, 119, 173, 211, 264, 334, 399.

   **Readout/container — TextBlock:** lines 32, 56, 69, 72, 75, 77, 80, 85, 87, 101, 102, 103, 104, 105, 106, 110, 126, 138, 144, 148, 150, 152, 157, 158, 159, 160, 161, 165, 180, 187, 193, 194, 195, 196, 197, 198, 199, 203, 231, 233, 235, 237, 239, 241, 256, 257, 258, 259, 272, 289, 291, 293, 295, 298, 300, 302, 304, 306, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 325, 341, 357, 359, 361, 363, 365, 367, 369, 371, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 392, 416, 433, 437, 441, 445, 449, 453, 457, 461, 469, 471, 472, 474, 475, 477, 478, 480, 482, 484, 485, 487, 506, 530.

   **Input/action/template — TextBox:** lines 33, 71, 74, 76, 79, 81, 149, 151, 153, 188, 232, 234, 236, 238, 240, 242, 290, 292, 294, 297, 299, 301, 303, 305, 307, 358, 360, 362, 364, 366, 368, 370, 372, 435, 439, 443, 447, 451, 455, 459, 463.

   **Readout/container — Window:** lines 1.

21. **C — Modules/Drainage/Dialogs/CalculationsV2Dialog.xaml.** Missing direct identity: 367.

   **Input/action/template — Button:** lines 109, 120, 121, 122, 134, 149, 299, 300, 318, 319, 443, 444, 538, 539, 540, 979, 980, 1246, 1291, 1311, 1316, 1317, 1338, 1339.

   **Input/action/template — CheckBox:** lines 193, 197, 201, 307, 903, 1306, 1307, 1308, 1309.

   **Input/action/template — ComboBox:** lines 190, 294, 296, 298, 462, 573, 894, 896.

   **Input/action/template — DataGrid:** lines 413, 649, 935, 1160.

   **Input/action/template — DataGridCheckBoxColumn:** lines 1162.

   **Input/action/template — DataGridTemplateColumn:** lines 131, 940, 948, 969.

   **Input/action/template — DataGridTextColumn:** lines 126, 127, 128, 129, 130, 152, 153, 154, 415, 416, 417, 418, 419, 420, 421, 523, 524, 525, 526, 527, 528, 529, 530, 531, 651, 652, 653, 654, 655, 937, 938, 939, 968, 1163, 1164, 1165, 1166, 1167.

   **Readout/container — GroupBox:** lines 291, 303, 316, 556, 572, 575, 611, 648, 660, 701, 739, 798, 833, 880, 929, 988, 1034, 1065, 1100, 1159.

   **Readout/container — Image:** lines 87.

   **Readout/container — ItemsControl:** lines 348, 360, 375, 387, 498, 502, 506, 510.

   **Readout/container — Separator:** lines 761, 855, 1237, 1250, 1310, 1312.

   **Input/action/template — TabControl:** lines 100, 113, 279, 1207.

   **Input/action/template — TabItem:** lines 101, 114, 144, 164, 219, 280, 326, 412, 546, 603, 693, 780, 872, 1005, 1206, 1208, 1297.

   **Readout/container — TextBlock:** lines 89, 90, 106, 108, 116, 146, 166, 182, 183, 184, 185, 186, 187, 199, 213, 221, 238, 240, 241, 242, 243, 244, 245, 246, 247, 248, 250, 252, 254, 283, 293, 295, 297, 305, 308, 310, 312, 320, 336, 338, 340, 342, 344, 345, 401, 405, 406, 408, 438, 439, 440, 457, 461, 465, 469, 473, 476, 488, 489, 490, 513, 515, 516, 536, 558, 563, 568, 588, 590, 591, 593, 595, 596, 626, 628, 630, 632, 634, 636, 667, 671, 678, 683, 718, 720, 722, 724, 726, 728, 730, 732, 734, 741, 746, 751, 756, 762, 767, 814, 816, 818, 820, 822, 824, 826, 828, 835, 840, 845, 850, 856, 861, 866, 893, 895, 897, 910, 913, 943, 951, 972, 994, 995, 1024, 1050, 1051, 1052, 1054, 1057, 1059, 1061, 1077, 1078, 1082, 1083, 1087, 1094, 1115, 1116, 1118, 1119, 1123, 1128, 1129, 1133, 1138, 1139, 1143, 1148, 1149, 1153, 1190, 1210, 1224, 1226, 1228, 1230, 1232, 1234, 1238, 1245, 1249, 1258, 1262, 1287, 1289, 1305, 1320.

   **Input/action/template — TextBox:** lines 107, 188, 189, 192, 196, 306, 309, 311, 313, 466, 470, 475, 589, 592, 594, 627, 629, 631, 633, 635, 637, 719, 721, 723, 725, 727, 729, 731, 733, 735, 815, 817, 819, 821, 823, 825, 827, 829, 904, 1053, 1055, 1056, 1058, 1060, 1062, 1225, 1227, 1229, 1231, 1233, 1235, 1288, 1290, 1323.

   **Readout/container — Window:** lines 1.

22. **C — Modules/Drainage/Dialogs/CatchmentReportPickDialog.xaml.** Missing direct identity: 12.

   **Input/action/template — Button:** lines 109, 111.

   **Input/action/template — ListBox:** lines 60.

   **Readout/container — TextBlock:** lines 42, 44, 53, 78, 80, 84, 86, 106.

   **Readout/container — Window:** lines 1.

23. **C — Modules/Drainage/Dialogs/CdDialog.xaml.** Missing direct identity: 139.

   **Workshop runtime coverage:** bound editor controls can receive C2 identifiers/names from WorkshopEditorFocus; see the exceptions above. Do not treat this source-only list as missing runtime identifiers.

   **Input/action/template — Button:** lines 145, 347, 353, 969, 1228, 1234, 1241, 1248, 1257.

   **Input/action/template — CheckBox:** lines 77, 141, 335, 451, 469, 476, 477, 478, 479, 753, 851.

   **Input/action/template — Expander:** lines 473.

   **Readout/container — GroupBox:** lines 195, 363, 449, 516, 619, 1012, 1030.

   **Readout/container — Image:** lines 117.

   **Readout/container — ItemsControl:** lines 961, 1168.

   **Readout/container — ScrollViewer:** lines 1167.

   **Input/action/template — SearchableComboBox:** lines 208, 228.

   **Readout/container — TextBlock:** lines 51, 67, 70, 95, 125, 129, 134, 188, 189, 205, 213, 224, 236, 262, 292, 326, 331, 395, 413, 433, 441, 454, 489, 507, 508, 532, 539, 581, 610, 623, 671, 679, 685, 694, 695, 708, 709, 719, 722, 816, 913, 928, 943, 958, 987, 1005, 1006, 1022, 1037, 1089, 1099, 1103, 1119, 1122, 1128, 1131, 1136, 1141, 1146, 1160, 1163, 1176, 1181, 1194, 1202.

   **Input/action/template — TextBox:** lines 79, 265, 329, 417, 536, 585, 699, 759, 858.

   **Input/action/template — ToggleButton:** lines 239, 242, 245, 248, 253, 274, 286, 306, 311, 369, 373, 387, 401, 406, 437, 438, 439, 559, 565, 596, 627, 633, 647, 675, 681, 779, 796, 876, 893, 949.

   **Readout/container — Window:** lines 1.

24. **C — Modules/Drainage/Dialogs/CdHelpDialog.xaml.** Missing direct identity: 41.

   **Input/action/template — Button:** lines 104, 105, 106, 107, 108, 109, 110, 111, 184.

   **Readout/container — GroupBox:** lines 58, 102, 115, 131, 152, 165.

   **Readout/container — Image:** lines 32.

   **Readout/container — ScrollViewer:** lines 56.

   **Readout/container — TextBlock:** lines 39, 43, 62, 64, 72, 74, 82, 84, 92, 94, 117, 120, 123, 133, 137, 141, 145, 154, 159, 167, 170, 173, 176.

   **Readout/container — Window:** lines 1.

25. **C — Modules/Drainage/Dialogs/CdLinkDialog.xaml.** Missing direct identity: 21.

   **Input/action/template — Button:** lines 67, 74, 81, 92, 97, 102, 107, 128.

   **Readout/container — GroupBox:** lines 57, 90, 114.

   **Readout/container — Image:** lines 31.

   **Readout/container — TextBlock:** lines 38, 42, 61, 62, 71, 78, 116, 119.

   **Readout/container — Window:** lines 1.

26. **C — Modules/Drainage/Dialogs/CdRepairDialog.xaml.** Missing direct identity: 15.

   **Readout/container — GroupBox:** lines 73, 106, 146.

   **Readout/container — Image:** lines 35.

   **Readout/container — TextBlock:** lines 42, 46, 58, 80, 90, 100, 113, 122, 131, 140.

   **Readout/container — Window:** lines 1.

27. **C — Modules/Drainage/Dialogs/CheckDwgResultWindow.xaml.** Missing direct identity: 14.

   **Input/action/template — Button:** lines 95.

   **Readout/container — Image:** lines 49.

   **Input/action/template — ListBox:** lines 86.

   **Readout/container — TextBlock:** lines 23, 25, 27, 52, 54, 61, 71, 81, 82, 83.

   **Readout/container — Window:** lines 1.

28. **C — Modules/Drainage/Dialogs/CivilDesignWindow.xaml.** Missing direct identity: 85.

   **Input/action/template — Button:** lines 252, 333, 334, 339, 340.

   **Input/action/template — CheckBox:** lines 206.

   **Readout/container — Image:** lines 21.

   **Readout/container — ItemsControl:** lines 133, 245, 299.

   **Readout/container — ScrollViewer:** lines 132, 244.

   **Input/action/template — TabItem:** lines 35, 152, 188, 211.

   **Readout/container — TextBlock:** lines 23, 24, 44, 54, 58, 62, 77, 81, 85, 87, 91, 95, 102, 103, 124, 127, 128, 129, 130, 138, 147, 160, 161, 163, 167, 171, 172, 175, 177, 179, 182, 183, 184, 190, 191, 193, 195, 196, 200, 204, 205, 207, 217, 226, 227, 239, 241, 242, 251, 264, 265, 266, 268, 270, 272, 274, 277, 279, 281, 283, 285, 287, 297, 298, 303, 304, 319, 320.

   **Readout/container — Window:** lines 2.

29. **C — Modules/Drainage/Dialogs/CivilGeneralSettingsView.xaml.** Missing direct identity: 6.

   **Input/action/template — Button:** lines 14.

   **Input/action/template — ComboBox:** lines 11.

   **Readout/container — GroupBox:** lines 4.

   **Readout/container — ScrollViewer:** lines 2.

   **Readout/container — TextBlock:** lines 10.

   **Readout/container — UserControl:** lines 1.

30. **C — Modules/Drainage/Dialogs/CivilHelpGuideView.xaml.** Missing direct identity: 9.

   **Input/action/template — Button:** lines 54.

   **Readout/container — Image:** lines 16.

   **Readout/container — TextBlock:** lines 13, 18, 19, 32, 36, 55.

   **Readout/container — UserControl:** lines 1.

31. **C — Modules/Drainage/Dialogs/CivilHubDialog.xaml.** Missing direct identity: 27.

   **Input/action/template — Button:** lines 45, 46, 97, 98, 112, 114.

   **Readout/container — Image:** lines 33.

   **Readout/container — ScrollViewer:** lines 93.

   **Readout/container — TextBlock:** lines 35, 36, 38, 59, 60, 62, 69, 76, 77, 79, 83, 84, 89, 92, 94, 101, 104, 110.

   **Readout/container — Window:** lines 1.

32. **C — Modules/Drainage/Dialogs/CivilImportWindow.xaml.** Missing direct identity: 32.

   **Input/action/template — Button:** lines 94, 96, 98, 189, 191.

   **Readout/container — Image:** lines 58.

   **Input/action/template — ListBox:** lines 133, 171.

   **Input/action/template — TabItem:** lines 70, 103, 141.

   **Readout/container — TextBlock:** lines 33, 35, 37, 61, 63, 77, 85, 86, 89, 110, 112, 128, 129, 130, 148, 150, 166, 167, 168, 186.

   **Readout/container — Window:** lines 1.

33. **C — Modules/Drainage/Dialogs/CivilSettingsView.xaml.** Missing direct identity: 155.

   **Input/action/template — Button:** lines 136, 200.

   **Input/action/template — CheckBox:** lines 129, 130, 194, 198.

   **Input/action/template — ComboBox:** lines 16, 18, 183.

   **Readout/container — GroupBox:** lines 5, 21, 40, 58, 77, 96, 115, 127, 133, 139, 169, 188, 192, 197, 204, 207.

   **Readout/container — ScrollViewer:** lines 3, 214.

   **Input/action/template — TabControl:** lines 2.

   **Input/action/template — TabItem:** lines 2.

   **Readout/container — TextBlock:** lines 15, 17, 32, 34, 35, 37, 51, 52, 54, 69, 71, 72, 74, 88, 90, 91, 93, 107, 109, 110, 112, 122, 124, 135, 153, 155, 156, 158, 159, 161, 162, 164, 166, 181, 182, 184, 186, 189, 205, 208, 223, 225, 228, 231, 242, 244, 247, 251, 253, 257, 259, 262, 265, 268, 271, 277, 279, 282, 285, 288, 299, 301, 312, 314, 317, 320, 323, 334, 336, 347, 349, 352, 362, 364, 366, 368, 370, 372, 374, 376, 378, 380, 382, 384, 386, 389, 391, 393, 395, 397, 399, 401, 402, 404, 406, 408, 410, 412, 414, 416, 418, 420, 422, 424, 426, 428, 430, 432.

   **Input/action/template — TextBox:** lines 33, 36, 53, 55, 70, 73, 89, 92, 108, 111, 123, 154, 157, 160, 163, 165, 185.

   **Readout/container — UserControl:** lines 1.

34. **C — Modules/Drainage/Dialogs/CommandAliasEditorDialog.xaml.** Missing direct identity: 16.

   **Input/action/template — Button:** lines 61, 83, 95, 115, 118.

   **Input/action/template — ListBox:** lines 67.

   **Readout/container — TextBlock:** lines 32, 34, 37, 79, 81, 82, 93, 106.

   **Input/action/template — TextBox:** lines 108.

   **Readout/container — Window:** lines 1.

35. **C — Modules/Drainage/Dialogs/ContinueRisingMainDialog.xaml.** Missing direct identity: 6.

   **Input/action/template — Button:** lines 47, 52.

   **Readout/container — TextBlock:** lines 26, 29, 36.

   **Readout/container — Window:** lines 1.

36. **C — Modules/Drainage/Dialogs/CouncilSourceDialog.xaml.** Missing direct identity: 14.

   **Input/action/template — Button:** lines 54, 110.

   **Readout/container — ScrollViewer:** lines 26, 67, 77.

   **Readout/container — TextBlock:** lines 23, 27, 41, 48, 68, 70, 71, 73.

   **Readout/container — Window:** lines 1.

37. **C — Modules/Drainage/Dialogs/DesignCheckDashboardDialog.xaml.** Missing direct identity: 53.

   **Input/action/template — Button:** lines 169, 262, 266, 272, 450, 485, 491, 496, 501, 507, 513, 518.

   **Input/action/template — CheckBox:** lines 435.

   **Input/action/template — ContextMenu:** lines 184.

   **Readout/container — GroupBox:** lines 217.

   **Readout/container — Image:** lines 313.

   **Readout/container — ItemsControl:** lines 388.

   **Input/action/template — MenuItem:** lines 185, 189, 195.

   **Readout/container — ScrollViewer:** lines 22.

   **Readout/container — Separator:** lines 194.

   **Readout/container — TextBlock:** lines 119, 120, 125, 136, 140, 166, 207, 212, 234, 235, 239, 243, 246, 249, 253, 255, 259, 280, 321, 325, 330, 357, 385, 401, 402, 410, 424, 430, 447, 471.

   **Readout/container — Window:** lines 1.

38. **C — Modules/Drainage/Dialogs/DrawingStandardsResources.xaml.** Missing direct identity: 0.

   No missing direct identity attributes among the scanned controls.

39. **C — Modules/Drainage/Dialogs/FeedbackDialog.xaml.** Missing direct identity: 28.

   **Readout/container — GroupBox:** lines 64, 72, 77, 110, 133.

   **Readout/container — Image:** lines 39.

   **Input/action/template — RadioButton:** lines 66, 68.

   **Input/action/template — TabItem:** lines 57, 103.

   **Readout/container — TextBlock:** lines 44, 47, 84, 95, 122, 123, 124, 125, 126, 127, 128, 135, 137, 139, 141, 143, 159.

   **Readout/container — Window:** lines 1.

40. **C — Modules/Drainage/Dialogs/GradeMismatchDialog.xaml.** Missing direct identity: 6.

   **Input/action/template — Button:** lines 50, 54.

   **Readout/container — TextBlock:** lines 25, 31, 38.

   **Readout/container — Window:** lines 1.

41. **C — Modules/Drainage/Dialogs/HelpGuideWindow.xaml.** Missing direct identity: 1.

   **Readout/container — Window:** lines 1.

42. **C — Modules/Drainage/Dialogs/LabelStyleDialog.xaml.** Missing direct identity: 44.

   **Input/action/template — Button:** lines 47, 48, 71, 101, 134, 135, 136.

   **Readout/container — Image:** lines 20.

   **Input/action/template — Menu:** lines 72, 102.

   **Input/action/template — MenuItem:** lines 73, 74, 75, 76, 77, 78, 79, 80, 81, 103, 104, 105, 106, 107, 108, 109, 110, 111.

   **Readout/container — ScrollViewer:** lines 88, 118.

   **Input/action/template — TabControl:** lines 61.

   **Input/action/template — TabItem:** lines 62, 92.

   **Readout/container — TextBlock:** lines 22, 23, 42, 58, 86, 88, 116, 118, 123, 133.

   **Readout/container — Window:** lines 1.

43. **C — Modules/Drainage/Dialogs/LayerManagerDialog.xaml.** Missing direct identity: 40.

   **Input/action/template — Button:** lines 88, 89, 90, 94, 95, 96, 132, 133, 148, 159, 170.

   **Input/action/template — CheckBox:** lines 49, 50.

   **Input/action/template — ComboBox:** lines 65, 72.

   **Input/action/template — DataGridTemplateColumn:** lines 62, 69.

   **Input/action/template — DataGridTextColumn:** lines 61, 116, 117, 118, 119, 120.

   **Readout/container — Image:** lines 23.

   **Readout/container — Separator:** lines 149.

   **Input/action/template — TabControl:** lines 31.

   **Input/action/template — TabItem:** lines 33, 101, 138.

   **Readout/container — TextBlock:** lines 25, 26, 43, 108, 131, 141, 144, 151, 154, 169.

   **Readout/container — Window:** lines 1.

44. **C — Modules/Drainage/Dialogs/LpdWindow.xaml.** Missing direct identity: 31.

   **Input/action/template — Button:** lines 95, 96.

   **Input/action/template — CheckBox:** lines 49.

   **Input/action/template — ComboBox:** lines 39.

   **Readout/container — Image:** lines 20.

   **Input/action/template — TabItem:** lines 29, 62.

   **Readout/container — TextBlock:** lines 22, 23, 37, 38, 42, 46, 48, 50, 54, 55, 56, 57, 64, 65, 66, 67, 68, 69, 70, 71, 72, 82.

   **Input/action/template — TextBox:** lines 47.

   **Readout/container — Window:** lines 2.

45. **C — Modules/Drainage/Dialogs/NewJobDrawingDialog.xaml.** Missing direct identity: 11.

   **Input/action/template — Button:** lines 47, 82.

   **Readout/container — ScrollViewer:** lines 73.

   **Readout/container — TextBlock:** lines 24, 26, 44, 53, 57, 67, 72.

   **Readout/container — Window:** lines 1.

46. **C — Modules/Drainage/Dialogs/OsnapSettingsDialog.xaml.** Missing direct identity: 23.

   **Input/action/template — Button:** lines 87, 91, 95, 138, 142, 146, 164, 169, 176, 183.

   **Input/action/template — CheckBox:** lines 75, 126.

   **Readout/container — GroupBox:** lines 52, 103.

   **Readout/container — ItemsControl:** lines 68, 119.

   **Readout/container — ScrollViewer:** lines 67, 118.

   **Readout/container — TextBlock:** lines 33, 37, 60, 111.

   **Readout/container — Window:** lines 1.

47. **C — Modules/Drainage/Dialogs/PartsCatalogueDialog.xaml.** Missing direct identity: 28.

   **Input/action/template — Button:** lines 62, 63, 64, 84, 85, 86, 105, 107, 108.

   **Input/action/template — ComboBox:** lines 52.

   **Input/action/template — DataGridCheckBoxColumn:** lines 57.

   **Input/action/template — DataGridTemplateColumn:** lines 44.

   **Input/action/template — DataGridTextColumn:** lines 42, 43, 56, 58, 78, 79, 80.

   **Readout/container — Image:** lines 23.

   **Input/action/template — TabControl:** lines 31.

   **Input/action/template — TabItem:** lines 33, 69.

   **Readout/container — TextBlock:** lines 25, 26, 47, 104.

   **Readout/container — Window:** lines 1.

48. **C — Modules/Drainage/Dialogs/PipeEditWorkshopDialog.xaml.** Missing direct identity: 168.

   **Workshop runtime coverage:** bound editor controls can receive C2 identifiers/names from WorkshopEditorFocus; see the exceptions above. Do not treat this source-only list as missing runtime identifiers.

   **Input/action/template — Button:** lines 149, 372, 373, 380, 449, 450, 490, 493, 494.

   **Input/action/template — CheckBox:** lines 417, 442, 443, 444, 447, 476.

   **Input/action/template — ComboBox:** lines 92, 95, 314.

   **Readout/container — Image:** lines 40.

   **Readout/container — ItemsControl:** lines 104, 116, 258.

   **Input/action/template — TabItem:** lines 61, 155, 287, 310, 434.

   **Readout/container — TextBlock:** lines 43, 44, 46, 47, 49, 58, 71, 78, 81, 91, 93, 94, 97, 103, 135, 137, 139, 147, 150, 151, 152, 162, 164, 165, 174, 176, 178, 182, 185, 188, 190, 194, 197, 205, 209, 212, 214, 215, 216, 218, 219, 229, 231, 233, 235, 243, 245, 247, 249, 251, 253, 257, 277, 281, 283, 284, 289, 296, 297, 300, 301, 304, 306, 313, 317, 318, 325, 330, 338, 343, 345, 352, 355, 369, 377, 382, 384, 385, 388, 392, 399, 407, 414, 415, 418, 426, 427, 440, 446, 448, 458, 467, 469, 477.

   **Input/action/template — TextBox:** lines 79, 136, 175, 186, 213, 230, 244, 353, 425.

   **Input/action/template — ToggleButton:** lines 64, 65, 66, 67, 68, 69, 146, 183, 184, 195, 206, 207, 228, 242, 278, 279, 315, 326, 327, 328, 339, 340, 341, 368, 378, 379, 386, 387, 389, 390, 398, 409, 410, 411, 412, 457, 466.

   **Readout/container — Window:** lines 1.

49. **C — Modules/Drainage/Dialogs/PipeValidationWarningDialog.xaml.** Missing direct identity: 9.

   **Input/action/template — Button:** lines 80.

   **Readout/container — ItemsControl:** lines 43.

   **Readout/container — ScrollViewer:** lines 42.

   **Readout/container — TextBlock:** lines 27, 30, 51, 56, 74.

   **Readout/container — Window:** lines 1.

50. **C — Modules/Drainage/Dialogs/PitDialog.xaml.** Missing direct identity: 128.

   **Workshop runtime coverage:** bound editor controls can receive C2 identifiers/names from WorkshopEditorFocus; see the exceptions above. Do not treat this source-only list as missing runtime identifiers.

   **Input/action/template — Button:** lines 114, 216, 268, 325, 328, 353, 421, 627, 628, 629, 658.

   **Input/action/template — CheckBox:** lines 91.

   **Input/action/template — ComboBox:** lines 122, 198, 372, 380, 386, 395, 399, 420.

   **Readout/container — GroupBox:** lines 104, 126, 225, 301, 338, 365, 383, 411, 425, 452, 540, 560.

   **Readout/container — Image:** lines 83.

   **Input/action/template — ListBox:** lines 428.

   **Input/action/template — TabItem:** lines 102, 223, 299, 335, 364, 409.

   **Readout/container — TextBlock:** lines 56, 86, 87, 89, 112, 121, 147, 149, 150, 152, 164, 166, 167, 169, 177, 179, 188, 190, 197, 206, 208, 215, 234, 236, 244, 246, 251, 254, 262, 263, 275, 283, 291, 309, 310, 311, 313, 319, 322, 324, 329, 354, 355, 357, 358, 371, 379, 385, 389, 394, 398, 402, 406, 419, 427, 432, 433, 535, 536, 542, 546, 547, 553, 554, 557, 571, 583, 595, 596, 602, 643.

   **Input/action/template — TextBox:** lines 165, 168, 178, 189, 207, 235, 245, 276, 284, 292, 390, 403.

   **Input/action/template — ToggleButton:** lines 341, 347, 348, 350.

   **Readout/container — Window:** lines 2.

51. **C — Modules/Drainage/Dialogs/PitEditWorkshopDialog.xaml.** Missing direct identity: 124.

   **Workshop runtime coverage:** bound editor controls can receive C2 identifiers/names from WorkshopEditorFocus; see the exceptions above. Do not treat this source-only list as missing runtime identifiers.

   **Input/action/template — Button:** lines 50, 106, 132, 203, 223, 243, 307, 327, 330, 331.

   **Input/action/template — CheckBox:** lines 314.

   **Input/action/template — ComboBox:** lines 56, 91, 93, 105, 123, 141, 160, 162.

   **Readout/container — Image:** lines 20.

   **Readout/container — ItemsControl:** lines 225.

   **Input/action/template — ListBox:** lines 110.

   **Input/action/template — TabItem:** lines 40, 182, 249, 305.

   **Readout/container — TextBlock:** lines 23, 24, 26, 28, 48, 52, 55, 59, 67, 69, 71, 73, 78, 80, 81, 83, 85, 87, 89, 90, 92, 95, 98, 100, 102, 104, 108, 109, 111, 111, 122, 124, 126, 128, 131, 140, 143, 151, 153, 155, 159, 161, 164, 171, 173, 175, 178, 179, 190, 192, 194, 197, 212, 214, 216, 222, 231, 232, 233, 235, 244, 255, 256, 257, 259, 266, 268, 275, 278, 279, 280, 288, 290, 298, 301, 302, 308, 315.

   **Input/action/template — TextBox:** lines 68, 70, 79, 82, 88, 99, 125, 152, 172, 191, 213, 265, 274, 299.

   **Input/action/template — ToggleButton:** lines 57, 211, 252, 253, 287.

   **Readout/container — Window:** lines 1.

52. **C — Modules/Drainage/Dialogs/PitScheduleDialog.xaml.** Missing direct identity: 145.

   **Input/action/template — Button:** lines 125, 130, 256, 327, 333, 448, 915, 919, 923, 928, 933, 1109, 1115, 1210, 1216, 1263, 1272, 1279, 1288.

   **Input/action/template — CheckBox:** lines 238, 342.

   **Input/action/template — ContextMenu:** lines 507, 571.

   **Input/action/template — DataGridTemplateColumn:** lines 630, 649, 802, 844.

   **Input/action/template — DataGridTextColumn:** lines 627, 628, 677, 689, 712, 724, 736, 748, 763, 775, 790, 821, 901, 902.

   **Readout/container — GroupBox:** lines 946.

   **Readout/container — Image:** lines 92.

   **Readout/container — ItemsControl:** lines 217, 1046.

   **Input/action/template — MenuItem:** lines 509, 513, 518, 520, 528, 532, 537, 572, 575, 579, 583, 586.

   **Input/action/template — RadioButton:** lines 156, 160, 473, 476, 479.

   **Readout/container — ScrollViewer:** lines 217, 1046, 1145.

   **Readout/container — Separator:** lines 517, 522, 536, 578, 582.

   **Input/action/template — TabItem:** lines 144, 386, 1019, 1126.

   **Readout/container — TextBlock:** lines 100, 104, 110, 155, 164, 167, 172, 175, 178, 185, 186, 198, 212, 213, 241, 244, 249, 281, 289, 296, 307, 313, 323, 341, 352, 366, 368, 374, 376, 411, 418, 425, 444, 454, 472, 591, 596, 659, 810, 886, 939, 955, 959, 962, 970, 984, 994, 1032, 1033, 1038, 1055, 1077, 1081, 1100, 1103, 1128, 1129, 1133, 1142, 1143, 1145, 1146, 1166, 1167, 1170, 1177, 1179, 1182, 1192, 1256.

   **Readout/container — Window:** lines 1.

53. **C — Modules/Drainage/Dialogs/ProjectReviewDraftingFixesDialog.xaml.** Missing direct identity: 9.

   **Input/action/template — Button:** lines 88, 92.

   **Readout/container — TextBlock:** lines 28, 30, 51, 56, 71, 84.

   **Readout/container — Window:** lines 1.

54. **C — Modules/Drainage/Dialogs/ProjectReviewProposalsDialog.xaml.** Missing direct identity: 33.

   **Input/action/template — Button:** lines 257, 262.

   **Readout/container — ItemsControl:** lines 132.

   **Readout/container — TextBlock:** lines 68, 70, 82, 110, 112, 113, 114, 117, 128, 129, 131, 135, 164, 165, 171, 174, 177, 193, 194, 203, 206, 209, 210, 211, 212, 225, 234, 244, 254.

   **Readout/container — Window:** lines 1.

55. **C — Modules/Drainage/Dialogs/PropagationPreviewDialog.xaml.** Missing direct identity: 29.

   **Input/action/template — Button:** lines 187, 192.

   **Input/action/template — DataGrid:** lines 93, 148.

   **Input/action/template — DataGridTemplateColumn:** lines 105.

   **Input/action/template — DataGridTextColumn:** lines 114, 115, 118, 121, 124, 127, 130, 133, 136, 139, 155, 156, 157, 158.

   **Input/action/template — Expander:** lines 146.

   **Readout/container — ItemsControl:** lines 164.

   **Readout/container — TextBlock:** lines 67, 72, 76, 85, 108, 167, 182.

   **Readout/container — Window:** lines 1.

56. **C — Modules/Drainage/Dialogs/ProposalPreviewDialog.xaml.** Missing direct identity: 17.

   **Input/action/template — Button:** lines 116, 122, 127.

   **Input/action/template — DataGrid:** lines 59.

   **Input/action/template — DataGridTextColumn:** lines 72, 73, 74, 75, 76.

   **Readout/container — ItemsControl:** lines 81, 91.

   **Readout/container — TextBlock:** lines 44, 51, 84, 94, 110.

   **Readout/container — Window:** lines 1.

57. **C — Modules/Drainage/Dialogs/RainfallWindow.xaml.** Missing direct identity: 29.

   **Input/action/template — Button:** lines 42, 63, 64, 75, 112, 113.

   **Input/action/template — CheckBox:** lines 89.

   **Readout/container — Image:** lines 20.

   **Input/action/template — TabItem:** lines 29, 47, 78.

   **Readout/container — TextBlock:** lines 22, 23, 38, 39, 40, 41, 43, 62, 67, 71, 72, 85, 99.

   **Input/action/template — TextBox:** lines 36, 68, 74, 87.

   **Readout/container — Window:** lines 2.

58. **C — Modules/Drainage/Dialogs/SettingsHistoryDialog.xaml.** Missing direct identity: 9.

   **Input/action/template — Button:** lines 73.

   **Input/action/template — ListBox:** lines 43.

   **Readout/container — TextBlock:** lines 29, 31, 51, 53, 55, 58.

   **Readout/container — Window:** lines 1.

59. **C — Modules/Drainage/Dialogs/SlabDialog.xaml.** Missing direct identity: 18.

   **Input/action/template — Button:** lines 135, 141.

   **Input/action/template — ComboBox:** lines 72.

   **Readout/container — GroupBox:** lines 100.

   **Readout/container — Image:** lines 37.

   **Readout/container — ScrollViewer:** lines 57.

   **Readout/container — TextBlock:** lines 44, 48, 61, 69, 76, 89, 92, 102, 111, 116.

   **Input/action/template — TextBox:** lines 64.

   **Readout/container — Window:** lines 1.

60. **C — Modules/Drainage/Dialogs/SlabEditDialog.xaml.** Missing direct identity: 50.

   **Input/action/template — ComboBox:** lines 71, 275.

   **Input/action/template — DataGrid:** lines 88, 122, 209, 251.

   **Input/action/template — DataGridTemplateColumn:** lines 219.

   **Input/action/template — DataGridTextColumn:** lines 96, 97, 98, 101, 102, 132, 133, 134, 216, 217, 218, 261, 262.

   **Readout/container — GroupBox:** lines 66, 70, 82, 116, 159, 200, 208, 243, 282.

   **Input/action/template — ListBox:** lines 160.

   **Input/action/template — TabControl:** lines 47.

   **Input/action/template — TabItem:** lines 50, 150, 174, 235.

   **Readout/container — TextBlock:** lines 40, 42, 78, 138, 157, 189, 197, 222, 245, 247, 283, 299.

   **Input/action/template — TextBox:** lines 67, 277.

   **Readout/container — Window:** lines 1.

61. **C — Modules/Drainage/Dialogs/SourceEditDialog.xaml.** Missing direct identity: 7.

   **Input/action/template — Button:** lines 46, 50, 55.

   **Input/action/template — CheckBox:** lines 38.

   **Readout/container — TextBlock:** lines 24, 31.

   **Readout/container — Window:** lines 1.

62. **C — Modules/Drainage/Dialogs/StartHereTourDialog.xaml.** Missing direct identity: 8.

   **Input/action/template — Button:** lines 81, 87.

   **Readout/container — Image:** lines 32.

   **Readout/container — TextBlock:** lines 39, 43, 60, 71.

   **Readout/container — Window:** lines 1.

63. **C — Modules/Drainage/Dialogs/WaterTankDialog.xaml.** Missing direct identity: 31.

   **Input/action/template — Button:** lines 285, 288, 290.

   **Readout/container — Image:** lines 55.

   **Readout/container — ItemsControl:** lines 224.

   **Input/action/template — TabItem:** lines 67, 168.

   **Readout/container — TextBlock:** lines 58, 60, 80, 82, 95, 97, 105, 108, 119, 145, 149, 152, 156, 160, 179, 181, 184, 194, 196, 240, 244, 264, 269.

   **Readout/container — Window:** lines 1.

64. **C — Modules/Drainage/Dialogs/WaterTankPlanBlockPickerDialog.xaml.** Missing direct identity: 9.

   **Input/action/template — Button:** lines 72, 73.

   **Readout/container — ItemsControl:** lines 44.

   **Readout/container — TextBlock:** lines 20, 22, 59, 62, 71.

   **Readout/container — Window:** lines 1.

65. **C — Modules/Drainage/Dialogs/WhatsNewDialog.xaml.** Missing direct identity: 5.

   **Input/action/template — Button:** lines 72, 78.

   **Readout/container — Image:** lines 32.

   **Readout/container — TextBlock:** lines 62.

   **Readout/container — Window:** lines 1.

66. **C — Modules/Drainage/Themes/CivilEditorShellTheme.xaml.** Missing direct identity: 0.

   No missing direct identity attributes among the scanned controls.

67. **C — Modules/Drainage/Themes/DarkTheme.xaml.** Missing direct identity: 6.

   **Input/action/template — RepeatButton:** lines 424, 449, 468, 493.

   **Readout/container — ScrollViewer:** lines 231.

   **Readout/container — TextBlock:** lines 122.

68. **C — Modules/Drainage/Themes/LightTheme.xaml.** Missing direct identity: 6.

   **Input/action/template — RepeatButton:** lines 421, 446, 465, 490.

   **Readout/container — ScrollViewer:** lines 228.

   **Readout/container — TextBlock:** lines 121.

69. **C — Modules/Drainage/UI/JobTimerToast.xaml.** Missing direct identity: 1.

   **Readout/container — Window:** lines 1.

70. **C — Modules/Manager/UI/Dialogs/CeVersionWindow.xaml.** Missing direct identity: 13.

   **Input/action/template — Button:** lines 96.

   **Readout/container — Separator:** lines 50.

   **Readout/container — TextBlock:** lines 29, 34, 44, 66, 69, 72, 75, 78, 82, 92.

   **Readout/container — Window:** lines 1.

71. **C — Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml.** Missing direct identity: 83.

   **Input/action/template — Button:** lines 57, 58, 88, 145, 147, 148, 149, 150, 151, 152, 153, 154, 191, 192, 197, 198.

   **Readout/container — ContentControl:** lines 134, 135, 170, 171.

   **Readout/container — Image:** lines 72.

   **Readout/container — ItemsControl:** lines 117, 143.

   **Readout/container — ScrollViewer:** lines 113, 128, 164.

   **Input/action/template — TabItem:** lines 112.

   **Readout/container — TextBlock:** lines 30, 31, 38, 39, 45, 46, 50, 51, 55, 83, 96, 97, 98, 99, 106, 107, 115, 116, 126, 126, 130, 131, 134, 135, 139, 139, 140, 140, 141, 141, 143, 146, 166, 167, 170, 171, 175, 175, 175, 176, 176, 176, 177, 177, 177, 181, 181, 182, 182, 188, 189, 201, 202.

   **Input/action/template — TextBox:** lines 47, 52.

   **Readout/container — Window:** lines 1.

72. **C — Modules/Manager/UI/Pages/DrawingRepairPage.xaml.** Missing direct identity: 36.

   **Input/action/template — Button:** lines 168, 173, 233, 245, 259, 265, 271, 276.

   **Input/action/template — ComboBox:** lines 64.

   **Input/action/template — ListBox:** lines 130.

   **Readout/container — TextBlock:** lines 37, 40, 45, 49, 67, 72, 88, 92, 115, 121, 125, 142, 147, 150, 154, 178, 195, 198, 211, 214, 218, 227, 229, 239, 241.

   **Readout/container — UserControl:** lines 1.

73. **C — Modules/Manager/UI/Pages/HelpWorkspacePage.xaml.** Missing direct identity: 9.

   **Input/action/template — TabItem:** lines 16, 25, 31, 37.

   **Readout/container — TextBlock:** lines 11, 12, 33, 39.

   **Readout/container — UserControl:** lines 1.

74. **C — Modules/Manager/UI/Pages/ProjectQaPage.xaml.** Missing direct identity: 33.

   **Input/action/template — Button:** lines 77, 83, 190, 195, 239, 258.

   **Input/action/template — ComboBox:** lines 43.

   **Readout/container — ItemsControl:** lines 105.

   **Input/action/template — ListBox:** lines 157.

   **Readout/container — TextBlock:** lines 31, 34, 39, 47, 88, 93, 96, 118, 124, 127, 153, 170, 175, 178, 200, 215, 220, 223, 226, 229, 232, 235, 263.

   **Readout/container — UserControl:** lines 1.

75. **C — Modules/Manager/UI/Pages/ProjectSheetsWorkspacePage.xaml.** Missing direct identity: 3.

   **Readout/container — TextBlock:** lines 13, 28.

   **Readout/container — UserControl:** lines 1.

76. **C — Modules/Manager/UI/Pages/SettingsWorkspacePage.xaml.** Missing direct identity: 14.

   **Input/action/template — Button:** lines 49.

   **Input/action/template — TabItem:** lines 16, 22, 31, 38.

   **Readout/container — TextBlock:** lines 12, 13, 33, 34, 41, 44, 45, 47.

   **Readout/container — UserControl:** lines 1.

77. **C — Modules/Manager/UI/Pages/SurveyIntakePage.xaml.** Missing direct identity: 3.

   **Readout/container — TextBlock:** lines 11, 12.

   **Readout/container — UserControl:** lines 1.

78. **C — Modules/Manager/UI/Themes/Theme.Base.xaml.** Missing direct identity: 0.

   No missing direct identity attributes among the scanned controls.

79. **C — Modules/Manager/UI/Themes/Theme.SwissModern.Dark.xaml.** Missing direct identity: 0.

   No missing direct identity attributes among the scanned controls.

80. **C — Modules/Manager/UI/Themes/Theme.SwissModern.xaml.** Missing direct identity: 0.

   No missing direct identity attributes among the scanned controls.

81. **C — Shared/CE_SHARED/Help/HelpCentreView.xaml.** Missing direct identity: 10.

   **Input/action/template — Button:** lines 64, 104, 115, 116, 120.

   **Readout/container — TextBlock:** lines 68, 69, 79, 81.

   **Readout/container — UserControl:** lines 1.

82. **C — Shared/CE_SHARED/Help/HelpCentreWindow.xaml.** Missing direct identity: 1.

   **Readout/container — Window:** lines 1.

83. **S — Modules/Structural/UI/Dialogs/AboutDialog.xaml.** Missing direct identity: 21.

   **Input/action/template — Button:** lines 152, 157.

   **Readout/container — ScrollViewer:** lines 42.

   **Readout/container — Separator:** lines 53, 125.

   **Readout/container — TextBlock:** lines 30, 47, 66, 69, 71, 87, 90, 92, 108, 111, 113, 118, 136, 138, 147.

   **Readout/container — Window:** lines 1.

84. **S — Modules/Structural/UI/Dialogs/AdminHubWindow.xaml.** Missing direct identity: 34.

   **Input/action/template — Button:** lines 47, 49, 51, 58, 59, 60, 61, 62, 63, 74, 75, 76, 77, 83, 84, 85, 86, 87, 88, 93, 94, 95.

   **Readout/container — GroupBox:** lines 44, 55, 72, 81.

   **Readout/container — Separator:** lines 89.

   **Input/action/template — TabControl:** lines 35.

   **Input/action/template — TabItem:** lines 36, 69.

   **Readout/container — TextBlock:** lines 28, 29, 90.

   **Readout/container — Window:** lines 1.

85. **S — Modules/Structural/UI/Dialogs/BeamSettingsDialog.xaml.** Missing direct identity: 27.

   **Input/action/template — Button:** lines 77, 83, 84.

   **Input/action/template — TabControl:** lines 45.

   **Input/action/template — TabItem:** lines 46, 53, 60, 72.

   **Readout/container — TextBlock:** lines 40, 41, 48, 48, 49, 49, 50, 50, 55, 55, 56, 56, 57, 63, 64, 65, 66, 76.

   **Readout/container — Window:** lines 1.

86. **S — Modules/Structural/UI/Dialogs/BracingPanelWindow.xaml.** Missing direct identity: 4.

   **Readout/container — TextBlock:** lines 30, 38, 49.

   **Readout/container — Window:** lines 1.

87. **S — Modules/Structural/UI/Dialogs/CategoryManagerDialog.xaml.** Missing direct identity: 5.

   **Readout/container — TextBlock:** lines 22, 23, 31, 39.

   **Readout/container — Window:** lines 1.

88. **S — Modules/Structural/UI/Dialogs/CeAlertDialog.xaml.** Missing direct identity: 2.

   **Input/action/template — Button:** lines 26.

   **Readout/container — Window:** lines 1.

89. **S — Modules/Structural/UI/Dialogs/CeIssuePublishDialog.xaml.** Missing direct identity: 8.

   **Readout/container — ScrollViewer:** lines 28.

   **Readout/container — TextBlock:** lines 19, 20, 27, 33, 40, 48.

   **Readout/container — Window:** lines 1.

90. **S — Modules/Structural/UI/Dialogs/CeNewSheetDialog.xaml.** Missing direct identity: 7.

   **Input/action/template — Button:** lines 54.

   **Readout/container — TextBlock:** lines 20, 21, 28, 34, 37.

   **Readout/container — Window:** lines 1.

91. **S — Modules/Structural/UI/Dialogs/CeProgressDialog.xaml.** Missing direct identity: 4.

   **Input/action/template — Button:** lines 29.

   **Readout/container — TextBlock:** lines 20, 21.

   **Readout/container — Window:** lines 1.

92. **S — Modules/Structural/UI/Dialogs/CeProjectSetupDialog.xaml.** Missing direct identity: 22.

   **Input/action/template — TabControl:** lines 24.

   **Input/action/template — TabItem:** lines 25, 93.

   **Readout/container — TextBlock:** lines 19, 20, 28, 30, 33, 54, 57, 62, 67, 72, 77, 82, 87, 96, 98, 101, 104, 109.

   **Readout/container — Window:** lines 1.

93. **S — Modules/Structural/UI/Dialogs/CePropsDialog.xaml.** Missing direct identity: 24.

   **Input/action/template — Button:** lines 218, 224.

   **Input/action/template — TabControl:** lines 39.

   **Input/action/template — TabItem:** lines 40, 139.

   **Readout/container — TextBlock:** lines 29, 33, 42, 64, 75, 87, 114, 117, 120, 123, 126, 129, 132, 141, 163, 166, 171, 213.

   **Readout/container — Window:** lines 1.

94. **S — Modules/Structural/UI/Dialogs/CeSettingsDialog.xaml.** Missing direct identity: 143.

   **Input/action/template — Button:** lines 18, 19, 20.

   **Readout/container — Label:** lines 32, 36, 40, 49, 57, 65, 71, 75, 113, 115, 117, 119, 121, 123, 125, 127, 129, 132, 134, 136, 173, 175, 177, 191, 193, 195, 201, 212, 226, 228, 230, 254, 256, 273, 275, 277, 279, 315, 319, 364, 368, 372, 376, 382, 400, 404, 408, 412, 417, 432, 436, 440, 444, 450, 454, 458, 469, 471, 473, 478, 480, 495, 499, 505, 520, 524, 530, 547, 559, 563, 567, 581, 598, 602, 606, 612, 616, 644, 648, 652, 658, 662, 677, 681, 685, 689, 695, 699, 703, 740, 744, 748, 752, 758, 775, 779, 783, 787, 791, 797, 801, 805, 809.

   **Input/action/template — TabControl:** lines 85, 537, 634.

   **Input/action/template — TabItem:** lines 86, 154, 236, 285, 538, 589, 635, 668, 709, 731, 766, 815.

   **Readout/container — TextBlock:** lines 12, 13, 162, 180, 200, 203, 215, 244, 261, 293, 294, 298, 299, 398, 419, 468, 477, 482, 557, 577, 627.

   **Readout/container — Window:** lines 1.

95. **S — Modules/Structural/UI/Dialogs/CeSharedTitleMappingWindow.xaml.** Missing direct identity: 17.

   **Input/action/template — Button:** lines 61, 62, 63.

   **Input/action/template — DataGridTextColumn:** lines 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44.

   **Readout/container — TextBlock:** lines 20, 21.

   **Readout/container — Window:** lines 1.

96. **S — Modules/Structural/UI/Dialogs/CeSheetsManagerWindow.xaml.** Missing direct identity: 83.

   **Input/action/template — Button:** lines 38, 39, 40, 41, 42, 125, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 190, 191, 192, 193, 194, 195, 196, 197, 216.

   **Input/action/template — ContextMenu:** lines 158.

   **Input/action/template — DataGridTextColumn:** lines 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185.

   **Input/action/template — MenuItem:** lines 159, 160, 161, 162, 164, 166, 167, 169, 170.

   **Readout/container — Separator:** lines 163, 165, 168.

   **Input/action/template — TabControl:** lines 54, 142.

   **Input/action/template — TabItem:** lines 54, 81, 110, 121, 142, 147, 154.

   **Readout/container — TextBlock:** lines 20, 21, 33, 56, 58, 61, 64, 67, 70, 73, 76, 83, 85, 88, 93, 102, 112, 124, 140.

   **Readout/container — Window:** lines 1.

97. **S — Modules/Structural/UI/Dialogs/CeSheetsSyncPreviewWindow.xaml.** Missing direct identity: 17.

   **Input/action/template — Button:** lines 100.

   **Readout/container — ItemsControl:** lines 65.

   **Readout/container — ScrollViewer:** lines 30, 41.

   **Readout/container — TextBlock:** lines 29, 33, 40, 48, 50, 53, 56, 62, 75, 76, 77, 78.

   **Readout/container — Window:** lines 1.

98. **S — Modules/Structural/UI/Dialogs/CeSheetsValidationReportWindow.xaml.** Missing direct identity: 17.

   **Input/action/template — Button:** lines 108, 109.

   **Input/action/template — DataGridTextColumn:** lines 55, 56, 57, 58, 59.

   **Readout/container — ItemsControl:** lines 63.

   **Readout/container — ScrollViewer:** lines 38.

   **Readout/container — TextBlock:** lines 40, 44, 51, 72, 73, 74, 95.

   **Readout/container — Window:** lines 1.

99. **S — Modules/Structural/UI/Dialogs/CeSheetsWindow.xaml.** Missing direct identity: 27.

   **Input/action/template — DataGridCheckBoxColumn:** lines 219.

   **Input/action/template — DataGridTextColumn:** lines 238, 242, 245, 248, 252, 256, 260.

   **Readout/container — ScrollViewer:** lines 133.

   **Input/action/template — TabItem:** lines 90, 118.

   **Readout/container — TextBlock:** lines 28, 31, 51, 98, 101, 104, 107, 110, 113, 126, 155, 160, 203, 206, 305.

   **Readout/container — Window:** lines 1.

100. **S — Modules/Structural/UI/Dialogs/CommandHelpWindow.xaml.** Missing direct identity: 11.

   **Input/action/template — Button:** lines 77, 229.

   **Readout/container — ScrollViewer:** lines 198.

   **Readout/container — TextBlock:** lines 50, 56, 107, 179, 188, 200, 226.

   **Readout/container — Window:** lines 1.

101. **S — Modules/Structural/UI/Dialogs/CommandPaletteWindow.xaml.** Missing direct identity: 7.

   **Readout/container — TextBlock:** lines 40, 41, 54, 146, 150, 162.

   **Readout/container — Window:** lines 1.

102. **S — Modules/Structural/UI/Dialogs/ExcelSheetPickerDialog.xaml.** Missing direct identity: 5.

   **Input/action/template — Button:** lines 49, 53.

   **Readout/container — TextBlock:** lines 29, 33.

   **Readout/container — Window:** lines 1.

103. **S — Modules/Structural/UI/Dialogs/FloatingTimerWindow.xaml.** Missing direct identity: 4.

   **Readout/container — TextBlock:** lines 16, 62, 64.

   **Readout/container — Window:** lines 1.

104. **S — Modules/Structural/UI/Dialogs/IdlePromptDialog.xaml.** Missing direct identity: 10.

   **Readout/container — TextBlock:** lines 22, 26, 31, 53, 54, 73, 74, 93, 94.

   **Readout/container — Window:** lines 1.

105. **S — Modules/Structural/UI/Dialogs/MarkupPreviewWindow.xaml.** Missing direct identity: 16.

   **Input/action/template — Button:** lines 33, 34.

   **Input/action/template — DataGridCheckBoxColumn:** lines 85.

   **Input/action/template — DataGridTextColumn:** lines 81, 82, 83, 84, 86, 87.

   **Readout/container — ScrollViewer:** lines 53, 66.

   **Readout/container — TextBlock:** lines 30, 52, 65, 78.

   **Readout/container — Window:** lines 1.

106. **S — Modules/Structural/UI/Dialogs/NoteEntryDialog.xaml.** Missing direct identity: 14.

   **Readout/container — ScrollViewer:** lines 68, 106.

   **Input/action/template — TabControl:** lines 30.

   **Input/action/template — TabItem:** lines 30, 86.

   **Readout/container — TextBlock:** lines 30, 30, 38, 51, 63, 72, 82, 92.

   **Readout/container — Window:** lines 1.

107. **S — Modules/Structural/UI/Dialogs/NotesBrowserDialog.xaml.** Missing direct identity: 12.

   **Input/action/template — Button:** lines 201.

   **Readout/container — ScrollViewer:** lines 178.

   **Readout/container — TextBlock:** lines 22, 27, 30, 35, 59, 60, 68, 105, 170.

   **Readout/container — Window:** lines 1.

108. **S — Modules/Structural/UI/Dialogs/RCBeamPickerDialog.xaml.** Missing direct identity: 8.

   **Input/action/template — Button:** lines 71, 72.

   **Input/action/template — TabItem:** lines 47, 53.

   **Readout/container — TextBlock:** lines 40, 41, 67.

   **Readout/container — Window:** lines 1.

109. **S — Modules/Structural/UI/Dialogs/RCLigDialog.xaml.** Missing direct identity: 17.

   **Input/action/template — Button:** lines 153, 154.

   **Readout/container — Label:** lines 63, 78, 90, 102, 122, 140.

   **Readout/container — TextBlock:** lines 36, 54, 68, 80, 92, 104, 111, 129.

   **Readout/container — Window:** lines 1.

110. **S — Modules/Structural/UI/Dialogs/RCMemberDialog.xaml.** Missing direct identity: 27.

   **Input/action/template — Button:** lines 211, 212.

   **Readout/container — Label:** lines 45, 56, 67, 94, 106, 115, 134, 145, 156, 167, 178.

   **Readout/container — ScrollViewer:** lines 204.

   **Readout/container — TextBlock:** lines 47, 58, 69, 81, 97, 136, 147, 158, 169, 180, 192, 203.

   **Readout/container — Window:** lines 1.

111. **S — Modules/Structural/UI/Dialogs/ReportsDialog.xaml.** Missing direct identity: 17.

   **Input/action/template — Button:** lines 70, 71, 72, 73, 111.

   **Readout/container — Separator:** lines 66.

   **Readout/container — TextBlock:** lines 27, 28, 33, 53, 55, 58, 61, 68, 87, 88.

   **Readout/container — Window:** lines 1.

112. **S — Modules/Structural/UI/Dialogs/SettingsDialog.xaml.** Missing direct identity: 18.

   **Input/action/template — Button:** lines 49, 57, 58, 61, 62.

   **Input/action/template — TabControl:** lines 21.

   **Input/action/template — TabItem:** lines 22, 29, 43.

   **Readout/container — TextBlock:** lines 16, 17, 23, 30, 34, 38, 44, 46.

   **Readout/container — Window:** lines 1.

113. **S — Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.xaml.** Missing direct identity: 48.

   **Input/action/template — Button:** lines 227.

   **Readout/container — Separator:** lines 144, 171, 177.

   **Readout/container — TextBlock:** lines 18, 19, 37, 47, 57, 58, 60, 62, 64, 78, 90, 110, 111, 112, 113, 115, 116, 118, 119, 121, 122, 124, 125, 127, 128, 130, 131, 133, 134, 136, 137, 139, 140, 142, 145, 147, 167, 179, 188, 200, 206, 213, 218.

   **Readout/container — Window:** lines 1.

114. **S — Modules/Structural/UI/Dialogs/SuggestEditDialog.xaml.** Missing direct identity: 12.

   **Input/action/template — Button:** lines 79.

   **Readout/container — TextBlock:** lines 21, 29, 40, 46, 52, 54, 59, 64, 66, 76.

   **Readout/container — Window:** lines 1.

115. **S — Modules/Structural/UI/Dialogs/TemplateEditorDialog.xaml.** Missing direct identity: 21.

   **Input/action/template — DataGridCheckBoxColumn:** lines 173.

   **Input/action/template — DataGridTextColumn:** lines 170, 171, 172.

   **Readout/container — Separator:** lines 185.

   **Readout/container — TextBlock:** lines 21, 22, 46, 59, 67, 68, 112, 118, 130, 136, 138, 153, 158, 194, 195.

   **Readout/container — Window:** lines 1.

116. **S — Modules/Structural/UI/Dialogs/TemplateSelectorDialog.xaml.** Missing direct identity: 11.

   **Readout/container — ScrollViewer:** lines 85.

   **Readout/container — TextBlock:** lines 22, 23, 29, 64, 67, 70, 79, 87, 97.

   **Readout/container — Window:** lines 1.

117. **S — Modules/Structural/UI/Dialogs/ViewSuggestionsDialog.xaml.** Missing direct identity: 4.

   **Input/action/template — Button:** lines 45.

   **Readout/container — ScrollViewer:** lines 28.

   **Readout/container — TextBlock:** lines 21.

   **Readout/container — Window:** lines 1.

118. **S — Modules/Structural/UI/Dialogs/XclmTxtAdvancedEditDialog.xaml.** Missing direct identity: 29.

   **Input/action/template — Button:** lines 110, 111, 112, 113, 114, 118, 119, 120, 121, 122, 123, 124, 125, 142, 143.

   **Input/action/template — ComboBox:** lines 163.

   **Input/action/template — DataGridTemplateColumn:** lines 157.

   **Input/action/template — DataGridTextColumn:** lines 155, 156, 168, 169, 170.

   **Readout/container — TextBlock:** lines 77, 81, 85, 107, 137, 159.

   **Readout/container — Window:** lines 1.

119. **S — Modules/Structural/UI/Dialogs/XclmTxtDialog.xaml.** Missing direct identity: 99.

   **Input/action/template — Button:** lines 162, 186, 192, 228, 236, 239, 246, 250, 498, 501, 595, 598.

   **Input/action/template — CheckBox:** lines 516.

   **Input/action/template — DataGrid:** lines 427, 454.

   **Input/action/template — DataGridCheckBoxColumn:** lines 435.

   **Input/action/template — DataGridTemplateColumn:** lines 375, 385, 436, 465, 513, 528, 635, 650, 661, 675, 762.

   **Input/action/template — DataGridTextColumn:** lines 371, 372, 432, 433, 434, 459, 460, 461, 462, 523, 524, 525, 526, 527, 644, 647, 672, 758, 759, 760, 761.

   **Readout/container — ItemsControl:** lines 312.

   **Readout/container — TextBlock:** lines 108, 112, 116, 120, 123, 130, 135, 139, 143, 168, 198, 219, 287, 288, 292, 293, 297, 298, 302, 303, 307, 308, 311, 325, 346, 350, 378, 388, 404, 408, 422, 439, 449, 468, 487, 491, 531, 559, 563, 568, 610, 614, 638, 653, 664, 678, 694, 698, 765.

   **Readout/container — Window:** lines 1.

120. **S — Modules/Structural/UI/FstManagerWindow.xaml.** Missing direct identity: 88.

   **Input/action/template — Button:** lines 45, 373, 374, 406, 407, 408, 409, 410, 411, 412, 442, 443.

   **Input/action/template — DataGridCheckBoxColumn:** lines 314, 331.

   **Input/action/template — DataGridTextColumn:** lines 69, 70, 71, 72, 90, 91, 92, 93, 111, 112, 113, 114, 132, 133, 134, 135, 153, 154, 155, 173, 174, 175, 193, 194, 195, 213, 214, 215, 233, 234, 235, 253, 254, 255, 256, 291, 292, 293, 294, 295, 311, 312, 313, 361, 362, 363, 364, 365, 386, 387, 388, 389.

   **Input/action/template — TabItem:** lines 54, 265, 303, 351, 370.

   **Readout/container — TextBlock:** lines 47, 48, 60, 81, 102, 123, 144, 164, 184, 204, 224, 244, 273, 282, 428, 440.

   **Readout/container — Window:** lines 1.

121. **S — Modules/Structural/UI/JobTimerToast.xaml.** Missing direct identity: 1.

   **Readout/container — Window:** lines 1.

122. **S — Modules/Structural/UI/LayerManagerWindow.xaml.** Missing direct identity: 58.

   **Input/action/template — Button:** lines 69, 70, 71, 72, 73, 96, 146, 147, 207, 214.

   **Input/action/template — DataGridCheckBoxColumn:** lines 60, 61, 62, 63, 64, 89, 90, 91, 92.

   **Input/action/template — DataGridTextColumn:** lines 56, 57, 58, 59, 65, 85, 86, 87, 88, 189, 190, 191, 192, 199, 200, 201.

   **Readout/container — GroupBox:** lines 183, 186, 196.

   **Input/action/template — TabControl:** lines 47.

   **Input/action/template — TabItem:** lines 48, 77, 100, 151.

   **Readout/container — TextBlock:** lines 32, 35, 39, 109, 123, 125, 127, 128, 129, 130, 140, 165, 169, 173.

   **Readout/container — Window:** lines 1.

123. **S — Modules/Structural/UI/MarkupWindow.xaml.** Missing direct identity: 1.

   **Readout/container — Window:** lines 1.

124. **S — Modules/Structural/UI/Palette/ChecklistPanel.xaml.** Missing direct identity: 5.

   **Input/action/template — Button:** lines 109.

   **Readout/container — ScrollViewer:** lines 98.

   **Readout/container — TextBlock:** lines 105, 133.

   **Readout/container — UserControl:** lines 1.

125. **S — Modules/Structural/UI/Palette/CommandsPanel.xaml.** Missing direct identity: 20.

   **Input/action/template — Button:** lines 124, 268, 384.

   **Input/action/template — Expander:** lines 290.

   **Readout/container — Image:** lines 240.

   **Readout/container — ScrollViewer:** lines 144, 164, 191, 293.

   **Readout/container — TextBlock:** lines 100, 140, 160, 186, 252, 259, 263, 332, 342, 352.

   **Readout/container — UserControl:** lines 1.

126. **S — Modules/Structural/UI/Palette/MainPalette.xaml.** Missing direct identity: 34.

   **Input/action/template — Button:** lines 217.

   **Readout/container — ScrollViewer:** lines 208.

   **Input/action/template — TabItem:** lines 133, 178, 219.

   **Readout/container — TextBlock:** lines 85, 105, 133, 138, 155, 158, 161, 164, 167, 170, 173, 178, 191, 196, 201, 207, 219, 241, 244, 247, 250, 253, 256, 259, 262, 265, 268, 271, 274.

127. **S — Modules/Structural/UI/Palette/MarkupAIPanel.xaml.** Missing direct identity: 34.

   **Input/action/template — Button:** lines 43, 44, 61, 62, 63, 91, 92, 93, 94, 95, 96, 97, 113, 114.

   **Input/action/template — DataGridCheckBoxColumn:** lines 75.

   **Input/action/template — DataGridTextColumn:** lines 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87.

   **Input/action/template — TabItem:** lines 91, 94.

   **Readout/container — TextBlock:** lines 24, 47, 53, 111.

   **Readout/container — UserControl:** lines 1.

128. **S — Modules/Structural/UI/Palette/MemberCataloguePanel.xaml.** Missing direct identity: 34.

   **Input/action/template — DataGridTextColumn:** lines 125, 126, 127, 128, 129, 130, 131.

   **Readout/container — ScrollViewer:** lines 137.

   **Input/action/template — TabItem:** lines 34, 72, 119, 137.

   **Readout/container — TextBlock:** lines 23, 24, 25, 36, 52, 56, 67, 74, 75, 89, 93, 97, 101, 105, 109, 121, 139, 147, 148, 149, 150.

   **Readout/container — UserControl:** lines 1.

129. **S — Modules/Structural/UI/Palette/NotesPanel.xaml.** Missing direct identity: 2.

   **Readout/container — ScrollViewer:** lines 181.

   **Readout/container — UserControl:** lines 1.

130. **S — Modules/Structural/UI/Palette/SelectedBeamInspectorPanel.xaml.** Missing direct identity: 22.

   **Readout/container — ItemsControl:** lines 51, 84.

   **Readout/container — ScrollViewer:** lines 48, 80.

   **Input/action/template — TabControl:** lines 46.

   **Input/action/template — TabItem:** lines 47, 79.

   **Readout/container — TextBlock:** lines 18, 19, 20, 41, 42, 43, 50, 56, 58, 59, 89, 90, 104, 105.

   **Readout/container — UserControl:** lines 1.

131. **S — Modules/Structural/UI/Palette/SheetsPanel.xaml.** Missing direct identity: 11.

   **Input/action/template — Button:** lines 50, 51, 52.

   **Readout/container — TextBlock:** lines 11, 12, 16, 25, 32, 39, 47.

   **Readout/container — UserControl:** lines 1.

132. **S — Modules/Structural/UI/Palette/StructuralInspectorPanel.xaml.** Missing direct identity: 4.

   **Input/action/template — TabControl:** lines 5.

   **Input/action/template — TabItem:** lines 6, 9.

   **Readout/container — UserControl:** lines 1.

133. **S — Modules/Structural/UI/StrucSuiteWindow.xaml.** Missing direct identity: 132.

   **Input/action/template — Button:** lines 50, 51, 60, 61, 62, 63, 64, 72, 73, 74, 75, 76, 84, 85, 86, 87, 88, 89, 98, 99, 100, 101, 102, 107, 108, 109, 110, 111, 116, 117, 118, 119, 120, 121, 122, 123, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 166, 167, 168, 169, 170, 171, 172, 177, 178, 179, 180, 185, 186, 187, 188, 189, 190, 191, 192, 197, 202, 203, 212, 213, 214, 222, 223, 224, 225, 226, 227, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246.

   **Input/action/template — TabControl:** lines 56, 95.

   **Input/action/template — TabItem:** lines 57, 69, 81, 94, 96, 105, 114, 126, 144, 164, 175, 183, 195, 200, 209, 219, 232.

   **Readout/container — TextBlock:** lines 25, 46, 47.

   **Readout/container — Window:** lines 1.

134. **S — Modules/Structural/UI/Themes/StructuralEditor.Dark.xaml.** Missing direct identity: 0.

   No missing direct identity attributes among the scanned controls.

135. **S — Modules/Structural/UI/Themes/StructuralEditor.Light.xaml.** Missing direct identity: 0.

   No missing direct identity attributes among the scanned controls.

136. **S — Modules/Structural/UI/Themes/StructuralEditorShellTheme.xaml.** Missing direct identity: 4.

   **Readout/container — ScrollViewer:** lines 124.

   **Readout/container — TextBlock:** lines 83, 88, 110.

137. **S — Modules/Structural/UI/Themes/Theme.Base.xaml.** Missing direct identity: 0.

   No missing direct identity attributes among the scanned controls.

138. **S — Modules/Structural/UI/Themes/Theme.SwissModern.Dark.xaml.** Missing direct identity: 0.

   No missing direct identity attributes among the scanned controls.

139. **S — Modules/Structural/UI/Themes/Theme.SwissModern.xaml.** Missing direct identity: 0.

   No missing direct identity attributes among the scanned controls.

140. **S — Modules/Structural/UI/TimeEntryBrowserWindow.xaml.** Missing direct identity: 18.

   **Input/action/template — DataGridTextColumn:** lines 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85.

   **Readout/container — TextBlock:** lines 28, 29, 47, 50, 53, 56.

   **Readout/container — Window:** lines 1.

**C# control-construction and naming index**

1. **Method.** Lexical Git search for explicit new Window/control expressions in production dialog/control/UI/help files, plus Civil's off-screen rendering host. Includes named and unnamed construction sites so later SetName/SetAutomationId calls are not lost. Factory loops are one source site, not a fabricated count of instances. C# comments/conditional and retained paths may be listed; this is deliberately a construction-site index, not a count of verified unnamed controls. All paths use the pinned C/S refs above.

2. **C — Modules/Drainage/Controls/CdPlanPreviewControl.cs.**

   **TextBlock construction:** lines 234.

3. **C — Modules/Drainage/Controls/DetentionRowPager.cs.**

   **Button construction:** lines 67.

4. **C — Modules/Drainage/Controls/PitConnectionStubOverlay.cs.**

   **TextBlock construction:** lines 102.

5. **C — Modules/Drainage/Controls/PitCornerGuide.cs.**

   **TextBlock construction:** lines 18.

6. **C — Modules/Drainage/Controls/PitEntryOverlay.cs.**

   **TextBlock construction:** lines 18.

7. **C — Modules/Drainage/Dialogs/CivilMoreOptions.cs.**

   **Button construction:** lines 26, 40.

   **Window construction:** lines 33.

8. **C — Modules/Drainage/Dialogs/CivilPreviewSelection.cs.**

   **Label construction:** lines 45, 46, 47, 48, 49, 52, 53.

9. **C — Modules/Drainage/Dialogs/EditorTextReviewWindow.cs.**

   **Button construction:** lines 21.

   **TextBlock construction:** lines 25.

   **TextBox construction:** lines 29.

10. **C — Modules/Drainage/Dialogs/EditPipePresentationLayout.cs.**

   **Button construction:** lines 139.

   **CheckBox construction:** lines 299.

   **ScrollViewer construction:** lines 115.

   **TabItem construction:** lines 284.

   **TextBlock construction:** lines 138, 266, 272, 309, 326.

   **TextBox construction:** lines 328.

   **Explicit naming/label assignment in this file:** lines 301, 329. Verify the specific target; not every constructor is covered.

11. **C — Modules/Drainage/Dialogs/PipeOnePageLayout.cs.**

   **CheckBox construction:** lines 278.

   **GroupBox construction:** lines 169.

   **TextBlock construction:** lines 54, 65, 255, 288.

   **TextBox construction:** lines 57.

   **Explicit naming/label assignment in this file:** lines 59, 280. Verify the specific target; not every constructor is covered.

12. **C — Modules/Drainage/Dialogs/PipePreviewInteraction.cs.**

   **ComboBox construction:** lines 26.

   **Explicit naming/label assignment in this file:** lines 31. Verify the specific target; not every constructor is covered.

13. **C — Modules/Drainage/Dialogs/PitConnectionSelector.cs.**

   **TextBlock construction:** lines 31.

   **Explicit naming/label assignment in this file:** lines 29. Verify the specific target; not every constructor is covered.

14. **C — Modules/Drainage/Dialogs/PitDetailsReview.cs.**

   **Button construction:** lines 22, 34.

   **ScrollViewer construction:** lines 56.

   **TextBlock construction:** lines 38, 41, 50.

   **Window construction:** lines 28.

15. **C — Modules/Drainage/Dialogs/PitOnePageLayout.cs.**

   **Button construction:** lines 85.

   **CheckBox construction:** lines 242.

   **ComboBox construction:** lines 226, 278.

   **TextBlock construction:** lines 127, 200, 240, 297, 304, 312, 332.

   **Explicit naming/label assignment in this file:** lines 229, 244, 280. Verify the specific target; not every constructor is covered.

16. **C — Modules/Drainage/Dialogs/PitReadinessPresentation.cs.**

   **TextBlock construction:** lines 58.

17. **C — Modules/Drainage/Dialogs/PitScheduleDialog.xaml.cs.**

   **MenuItem construction:** lines 411.

18. **C — Modules/Drainage/Dialogs/StartHereTourDialog.xaml.cs.**

   **Image construction:** lines 123.

19. **C — Modules/Drainage/Dialogs/WorkshopFieldFeedback.cs.**

   **TextBlock construction:** lines 87, 157.

20. **C — Modules/Manager/UI/Dialogs/PluginManagerWindow.ProjectSheets.cs.**

   **Button construction:** lines 595.

   **TextBlock construction:** lines 590.

21. **C — Modules/Manager/UI/Pages/CeBlocksPaletteControl.cs.**

   **Button construction:** lines 222.

   **Image construction:** lines 210.

   **ScrollViewer construction:** lines 95, 107.

   **TabControl construction:** lines 92.

   **TabItem construction:** lines 101.

   **TextBlock construction:** lines 59, 61, 70, 81, 116, 157, 167, 177, 189, 216, 218.

   **TextBox construction:** lines 67.

22. **C — Shared/CE_SHARED/Help/HelpCentreView.xaml.cs.**

   **Button construction:** lines 64, 133, 241.

   **Image construction:** lines 96, 243.

   **TextBlock construction:** lines 123, 129, 130, 131, 132.

   **Window construction:** lines 246.

23. **S — Modules/Structural/UI/Dialogs/CeHatchPresetDialog.cs.**

   **Button construction:** lines 231.

   **ComboBox construction:** lines 54.

   **ScrollViewer construction:** lines 195.

   **TextBlock construction:** lines 50, 51, 52, 176, 210.

   **TextBox construction:** lines 53.

24. **S — Modules/Structural/UI/Dialogs/CeSheetsManagerWindow.xaml.cs.**

   **Button construction:** lines 983, 984, 1322, 1323.

   **ComboBox construction:** lines 1294, 1300.

   **TextBlock construction:** lines 978, 1330, 1332.

   **TextBox construction:** lines 979.

25. **S — Modules/Structural/UI/Dialogs/CeSheetsWindow.xaml.cs.**

   **TextBlock construction:** lines 228.

   **Explicit naming/label assignment in this file:** lines 237. Verify the specific target; not every constructor is covered.

26. **S — Modules/Structural/UI/FstManagerWindow.xaml.cs.**

   **Button construction:** lines 481, 482, 643, 644, 645.

   **TextBlock construction:** lines 476.

   **TextBox construction:** lines 477.

**All XAML Window declarations — breadth check**

1. **Reading convention.** Dimensions are declared WPF units, not physical pixels. Code may subsequently change them. A declaration's presence is not proof that the installed command reaches it. Programmatic windows appear in the C# index, including More options, pit reviews and Manager popup classes.

2. **Modules/Drainage/Dialogs/AdvancedSettingsDialog.xaml.** Title: Creative Engineering / Settings. Declared 1100 × 620; minimum 1100 × .

3. **Modules/Drainage/Dialogs/BatchEditWorkshopDialog.xaml.** Title: Creative Engineering / Edit Selected. Declared 720 × 900; minimum 640 × 520.

4. **Modules/Drainage/Dialogs/CalculationsDialog.xaml.** Title: Creative Engineering / Calculations. Declared 1100 × 820; minimum 980 × 740.

5. **Modules/Drainage/Dialogs/CalculationsV2Dialog.xaml.** Title: Creative Engineering / Calculations. Declared 1400 × 1000; minimum 1200 × 820.

6. **Modules/Drainage/Dialogs/CatchmentReportPickDialog.xaml.** Title: Creative Engineering / Add catchment from rating report. Declared 640 × 560; minimum 640 × 560.

7. **Modules/Drainage/Dialogs/CdDialog.xaml.** Title: Creative Engineering / Civil Drainage. Declared 1100 × 780; minimum 820 × 560.

8. **Modules/Drainage/Dialogs/CdHelpDialog.xaml.** Title: Creative Engineering / Help & Status. Declared 1080 × 760; minimum 900 × 640.

9. **Modules/Drainage/Dialogs/CdLinkDialog.xaml.** Title: Creative Engineering / Link Tool. Declared 900 × 620; minimum 760 × 560.

10. **Modules/Drainage/Dialogs/CdRepairDialog.xaml.** Title: Creative Engineering / Repair Center. Declared 980 × 680; minimum 820 × 600.

11. **Modules/Drainage/Dialogs/CheckDwgResultWindow.xaml.** Title: Creative Engineering / Check consultant drawing results. Declared 980 × 660; minimum 760 × 480.

12. **Modules/Drainage/Dialogs/CivilDesignWindow.xaml.** Title: Creative Engineering / Design. Declared 1280 × 800; minimum  × .

13. **Modules/Drainage/Dialogs/CivilHubDialog.xaml.** Title: Creative Engineering / Civil Hub. Declared 1440 × 880; minimum 1180 × 760.

14. **Modules/Drainage/Dialogs/CivilImportWindow.xaml.** Title: Creative Engineering / Civil import. Declared 1160 × 760; minimum 940 × 640.

15. **Modules/Drainage/Dialogs/CommandAliasEditorDialog.xaml.** Title: Creative Engineering / Office short names. Declared 640 × 620; minimum 560 × 520.

16. **Modules/Drainage/Dialogs/ContinueRisingMainDialog.xaml.** Title: Creative Engineering / Rising Main. Declared 560 × ; minimum 520 × 220.

17. **Modules/Drainage/Dialogs/CouncilSourceDialog.xaml.** Title: Creative Engineering / Council Source. Declared 1050 × 780; minimum 760 × 560.

18. **Modules/Drainage/Dialogs/DesignCheckDashboardDialog.xaml.** Title: Creative Engineering / Project Review. Declared 1216 × 800; minimum 1216 × 600.

19. **Modules/Drainage/Dialogs/FeedbackDialog.xaml.** Title: Creative Engineering / Feedback. Declared 760 × 680; minimum 760 × 660.

20. **Modules/Drainage/Dialogs/GradeMismatchDialog.xaml.** Title: Creative Engineering / Grade mismatch. Declared 560 × ; minimum 520 × 220.

21. **Modules/Drainage/Dialogs/HelpGuideWindow.xaml.** Title: Creative Engineering / Help Centre. Declared 1100 × 780; minimum 820 × 560.

22. **Modules/Drainage/Dialogs/LabelStyleDialog.xaml.** Title: Creative Engineering / Label Styles. Declared 1100 × 740; minimum 1100 × 740.

23. **Modules/Drainage/Dialogs/LayerManagerDialog.xaml.** Title: Creative Engineering / Drawing Standards Manager. Declared 1100 × 740; minimum 1100 × 740.

24. **Modules/Drainage/Dialogs/LpdWindow.xaml.** Title: Creative Engineering / Legal point of discharge. Declared 1100 × 660; minimum  × .

25. **Modules/Drainage/Dialogs/NewJobDrawingDialog.xaml.** Title: Creative Engineering / New job drawing. Declared 720 × 560; minimum 620 × 480.

26. **Modules/Drainage/Dialogs/OsnapSettingsDialog.xaml.** Title: Creative Engineering / OSNAP Settings. Declared 820 × 720; minimum 720 × 650.

27. **Modules/Drainage/Dialogs/PartsCatalogueDialog.xaml.** Title: Creative Engineering / Parts Catalogue. Declared 1100 × 740; minimum 1100 × 740.

28. **Modules/Drainage/Dialogs/PipeEditWorkshopDialog.xaml.** Title: {Binding WorkshopWindowTitle}. Declared 680 × 820; minimum 680 × 0.

29. **Modules/Drainage/Dialogs/PipeValidationWarningDialog.xaml.** Title: Creative Engineering / Design Warnings. Declared 480 × 320; minimum 380 × 220.

30. **Modules/Drainage/Dialogs/PitDialog.xaml.** Title: {Binding WorkshopWindowTitle}. Declared 1100 × 680; minimum 900 × 600.

31. **Modules/Drainage/Dialogs/PitEditWorkshopDialog.xaml.** Title: {Binding WorkshopWindowTitle}. Declared 1680 × 920; minimum 1000 × 680.

32. **Modules/Drainage/Dialogs/PitScheduleDialog.xaml.** Title: Creative Engineering / Pit Schedule. Declared 1440 × 800; minimum 1440 × 640.

33. **Modules/Drainage/Dialogs/ProjectReviewDraftingFixesDialog.xaml.** Title: Creative Engineering / Project Review — Safe Drafting Fixes. Declared 760 × 520; minimum 620 × 380.

34. **Modules/Drainage/Dialogs/ProjectReviewProposalsDialog.xaml.** Title: Creative Engineering / Project Review — Proposals. Declared 980 × 850; minimum 780 × 620.

35. **Modules/Drainage/Dialogs/PropagationPreviewDialog.xaml.** Title: Creative Engineering / Cascade Preview. Declared 980 × 640; minimum 780 × 460.

36. **Modules/Drainage/Dialogs/ProposalPreviewDialog.xaml.** Title: Creative Engineering / Proposal Preview. Declared 900 × 560; minimum 700 × 420.

37. **Modules/Drainage/Dialogs/RainfallWindow.xaml.** Title: Creative Engineering / Job rainfall / IFD. Declared 1100 × 730; minimum  × .

38. **Modules/Drainage/Dialogs/SettingsHistoryDialog.xaml.** Title: Creative Engineering / Settings history. Declared 640 × 560; minimum 520 × 420.

39. **Modules/Drainage/Dialogs/SlabDialog.xaml.** Title: Creative Engineering / Slab Fall Design. Declared 680 × 760; minimum  × .

40. **Modules/Drainage/Dialogs/SlabEditDialog.xaml.** Title: Creative Engineering / Slab Edit. Declared 700 × 720; minimum 560 × 620.

41. **Modules/Drainage/Dialogs/SourceEditDialog.xaml.** Title: Creative Engineering / Edit source. Declared 420 × ; minimum 380 × .

42. **Modules/Drainage/Dialogs/StartHereTourDialog.xaml.** Title: Creative Engineering / Start Here. Declared 760 × 560; minimum 640 × 480.

43. **Modules/Drainage/Dialogs/WaterTankDialog.xaml.** Title: Creative Engineering / Water tank. Declared 1280 × 820; minimum 1080 × 780.

44. **Modules/Drainage/Dialogs/WaterTankPlanBlockPickerDialog.xaml.** Title: Creative Engineering / Water tank plan block. Declared 1180 × 760; minimum 820 × 520.

45. **Modules/Drainage/Dialogs/WhatsNewDialog.xaml.** Title: Creative Engineering / What's New. Declared 760 × 640; minimum 640 × 500.

46. **Modules/Drainage/UI/JobTimerToast.xaml.** Title: CE Timer. Declared 320 × 76; minimum  × .

47. **Modules/Manager/UI/Dialogs/CeVersionWindow.xaml.** Title: About CE Suite. Declared 470 × 390; minimum  × .

48. **Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml.** Title: CE Suite Manager. Declared 1040 × 740; minimum 900 × 620.

49. **Shared/CE_SHARED/Help/HelpCentreWindow.xaml.** Title: CE Help Centre. Declared 1180 × 820; minimum 780 × 540.

50. **Modules/Structural/UI/Dialogs/AboutDialog.xaml.** Title: About CE Suite. Declared 620 × 600; minimum 500 × 360.

51. **Modules/Structural/UI/Dialogs/AdminHubWindow.xaml.** Title: Drawing tools and checks. Declared 860 × 830; minimum 760 × 760.

52. **Modules/Structural/UI/Dialogs/BeamSettingsDialog.xaml.** Title: Beam settings. Declared 820 × 620; minimum 700 × 460.

53. **Modules/Structural/UI/Dialogs/BracingPanelWindow.xaml.** Title: CE Bracing. Declared 300 × 230; minimum 260 × 200.

54. **Modules/Structural/UI/Dialogs/CategoryManagerDialog.xaml.** Title: Checklist sections. Declared 400 × 350; minimum  × .

55. **Modules/Structural/UI/Dialogs/CeAlertDialog.xaml.** Title: Drawing notice. Declared 500 × 250; minimum 420 × 220.

56. **Modules/Structural/UI/Dialogs/CeIssuePublishDialog.xaml.** Title: Publish issue PDFs. Declared 620 × 650; minimum 540 × 560.

57. **Modules/Structural/UI/Dialogs/CeNewSheetDialog.xaml.** Title: New sheet. Declared 460 × 420; minimum 420 × 380.

58. **Modules/Structural/UI/Dialogs/CeProgressDialog.xaml.** Title: Drawing progress. Declared 480 × 250; minimum  × .

59. **Modules/Structural/UI/Dialogs/CeProjectSetupDialog.xaml.** Title: Set up drawing sheets. Declared 820 × 760; minimum 760 × 680.

60. **Modules/Structural/UI/Dialogs/CePropsDialog.xaml.** Title: Drawing properties. Declared 720 × 760; minimum 620 × 620.

61. **Modules/Structural/UI/Dialogs/CeSettingsDialog.xaml.** Title: CE Settings. Declared 1180 × 850; minimum 1180 × 850.

62. **Modules/Structural/UI/Dialogs/CeSharedTitleMappingWindow.xaml.** Title: Match title block fields. Declared 1180 × 760; minimum 980 × 620.

63. **Modules/Structural/UI/Dialogs/CeSheetsManagerWindow.xaml.** Title: CE Sheets Manager. Declared 1260 × 820; minimum 1080 × 700.

64. **Modules/Structural/UI/Dialogs/CeSheetsSyncPreviewWindow.xaml.** Title: Preview drawing updates. Declared 820 × 600; minimum 640 × 440.

65. **Modules/Structural/UI/Dialogs/CeSheetsValidationReportWindow.xaml.** Title: Project drawing checks. Declared 880 × 660; minimum 680 × 480.

66. **Modules/Structural/UI/Dialogs/CeSheetsWindow.xaml.** Title: Drawing sheets. Declared 1180 × 780; minimum 980 × 640.

67. **Modules/Structural/UI/Dialogs/CommandHelpWindow.xaml.** Title: Command help. Declared 1100 × 720; minimum 900 × 560.

68. **Modules/Structural/UI/Dialogs/CommandPaletteWindow.xaml.** Title: Command search. Declared 520 × ; minimum  × .

69. **Modules/Structural/UI/Dialogs/ExcelSheetPickerDialog.xaml.** Title: Choose worksheet. Declared 460 × 520; minimum 400 × 420.

70. **Modules/Structural/UI/Dialogs/FloatingTimerWindow.xaml.** Title: Timer. Declared 180 × 85; minimum  × .

71. **Modules/Structural/UI/Dialogs/IdlePromptDialog.xaml.** Title: Time away from drawing. Declared 480 × 390; minimum  × .

72. **Modules/Structural/UI/Dialogs/MarkupPreviewWindow.xaml.** Title: Markup preview. Declared 1600 × 900; minimum 1200 × 700.

73. **Modules/Structural/UI/Dialogs/NoteEntryDialog.xaml.** Title: Add Note. Declared 500 × 620; minimum 500 × 540.

74. **Modules/Structural/UI/Dialogs/NotesBrowserDialog.xaml.** Title: Shared Notes Browser - All Jobs. Declared 1100 × 700; minimum 900 × 550.

75. **Modules/Structural/UI/Dialogs/RCBeamPickerDialog.xaml.** Title: RC Beam — Section Type. Declared 890 × 650; minimum 890 × 650.

76. **Modules/Structural/UI/Dialogs/RCLigDialog.xaml.** Title: Beam stirrup. Declared 680 × 440; minimum 620 × 420.

77. **Modules/Structural/UI/Dialogs/RCMemberDialog.xaml.** Title: RC Member Section. Declared 1060 × 850; minimum 1060 × 850.

78. **Modules/Structural/UI/Dialogs/ReportsDialog.xaml.** Title: Time reports. Declared 900 × 850; minimum 780 × 820.

79. **Modules/Structural/UI/Dialogs/SettingsDialog.xaml.** Title: Time and palette settings. Declared 630 × 510; minimum 560 × 440.

80. **Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.xaml.** Title: Steel / Timber Beam Section. Declared 1340 × 820; minimum 1340 × 820.

81. **Modules/Structural/UI/Dialogs/SuggestEditDialog.xaml.** Title: Suggest a checklist change. Declared 600 × 620; minimum 500 × 600.

82. **Modules/Structural/UI/Dialogs/TemplateEditorDialog.xaml.** Title: Checklist templates. Declared 1400 × 900; minimum 1000 × 700.

83. **Modules/Structural/UI/Dialogs/TemplateSelectorDialog.xaml.** Title: Select Checklist Template. Declared 800 × 700; minimum 600 × 500.

84. **Modules/Structural/UI/Dialogs/ViewSuggestionsDialog.xaml.** Title: Pending Template Suggestions. Declared 700 × 500; minimum 500 × 400.

85. **Modules/Structural/UI/Dialogs/XclmTxtAdvancedEditDialog.xaml.** Title: Edit schedule rows. Declared 1560 × 920; minimum 1240 × 760.

86. **Modules/Structural/UI/Dialogs/XclmTxtDialog.xaml.** Title: Excel to schedule. Declared 1820 × 1040; minimum 1460 × 900.

87. **Modules/Structural/UI/FstManagerWindow.xaml.** Title: Foundations manager. Declared 1520 × 900; minimum 1120 × 700.

88. **Modules/Structural/UI/JobTimerToast.xaml.** Title: CE Timer. Declared 320 × 74; minimum  × .

89. **Modules/Structural/UI/LayerManagerWindow.xaml.** Title: Drawing standards. Declared 1100 × 760; minimum 760 × 520.

90. **Modules/Structural/UI/MarkupWindow.xaml.** Title: CEMARKUP. Declared 1480 × 860; minimum 980 × 640.

91. **Modules/Structural/UI/StrucSuiteWindow.xaml.** Title: CE Structural Suite. Declared 1040 × 720; minimum 860 × 600.

92. **Modules/Structural/UI/TimeEntryBrowserWindow.xaml.** Title: Job Timer — Edit Time Entries. Declared 1100 × 640; minimum 900 × 500.

**Summary — under 100 words**

1. **Summary.** Nine findings: one HIGH, six MEDIUM, two LOW. The strongest is Structural's pixel/WPF conversion error at 150%. Civil's definite gaps include search Enter saving, ignored window-position memory, primary-monitor clamping and stale palette themes. About remains light; batch Inspect ignores Escape. Test-critical unnamed controls and the full source inventory are recorded without confusing caption-derived or runtime names with failures. No runtime acceptance is claimed. Only this report changed; builds, tests, installation and AutoCAD remain untouched.
