# UI audit against Tim's screen rules (15 Nov 2026)

**Read-only audit. Nothing was changed, built, tested or opened in AutoCAD. Code read: the installed line (Civil 3.0.90.4, commit `dadac7e7`, checkout `C:\CE_WORK\build\wtB14b`). Rules read: `04_REFERENCE/TIM_UI_UX_RULES_15NOV.md` (phone, folding-phone and iPad checks left out for AutoCAD windows).**

---

# FOR TIM

**1. Headline.** 112 of 116 windows audited (11 read in full, 101 measured only). None of the 11 read in full meets your rules: 0 meet, 9 partly, 2 do not (New Pipe and CDCALC). Of the 101 measured only: 42 had no fault in what a machine can measure, 56 partly, 3 do not. Those 42 were not checked for "one big number" or "a picture on every card", so do not count them as passes.

**2. The five changes that would matter most to a drafter, ranked.**

1. **Put the answer first in the windows you use every day.** None of the ten tools' windows has a card with one big number, its working as a sum, and a picture. Pit Schedule is a wide table. CDCALC is ten tabs of fields with "Required volume 9.42" as a small box. CDCHECKCURRENT is lines of words. This is the biggest gap against "I read pages like a maths teacher".
2. **Bring New Pipe (CD) down to the Edit Pipe look.** Edit Pipe is already one page with a "More…" button. New Pipe is the old crowded window: 59 controls, five open sections, one tucked-away "Quick placement" and nothing else folded.
3. **Cut Civil to three text sizes and keep gold or blue for main buttons and the selected tab only.** Civil windows use 17 different text sizes. Gold (dark) or blue (light) is also used for titles, warnings and figures, for example the area figure in the drawing check (`DrawingCheckPanelControl.xaml` line 54).
4. **Replace "are you sure" boxes with Undo.** CDRENUMBER asks "N pit(s) will be renumbered. Apply? [Yes/No]" with No as the default. The uphill-pipe box asks Yes, No or Cancel. Edit Pipe and CDRUNSOLVE already lean on one Undo; the other two should follow.
5. **Say it in drafting words, and make errors say what to do.** Words found: "Entity", "XREFs", "Sync", "Handle", "Debug", "Manifest", "Support Bundle". Structural shows the raw error text in pop-ups (for example `CeSheetsWindow.xaml.cs` lines 111, 124, 158 and 383). The check panel's own error line is the model: it says what happened and what to do.

**3. The ten tools, one line each.**

1. **PIT.** New Pit window (seen on screen, 3 Nov). Pre-filled, one page, "More…" and a plan picture. Partly: no big answer, gold on warnings, "Preview — changes not saved" banner in gold.
2. **CD.** New Pipe window (read from code, not seen on screen). Does not meet: crowded, 5 text sizes, almost nothing folded away.
3. **CDLPD.** Legal point of discharge window (seen on screen, 14 Nov). Partly: two fields and 3 clicks, but the title is a question and the "Connection note" card is words only.
4. **CDEDIT.** Edit Pipe window (seen on screen, 15 Nov) and Edit Pit (read from code). Partly: the best two windows, with a green "Ready to save the pipe." chip, but 30 or so buttons on show and no sum.
5. **CDRUNSOLVE.** Proposal Preview (read from code, not seen on screen). Partly: Apply is the default button (1 click), but it is a table headed "Entity" and "Old value / New value".
6. **CDRENUMBER.** No window, command line only. Does not meet "Undo instead of Are you sure": it asks Yes/No (default No). Two typed answers, no clicks.
7. **PITSCHEDULE.** Pit Schedule window (seen on screen, 26 Oct, older build). Partly: four tabs, 8 text sizes, a wide table; "Drawing check: 97 data issues" shows in amber with a word.
8. **CDRULES with CDCALC.** CDRULES is a command-line question ("All Problems Values Explain pReview Source", seen on screen 3 Nov) plus a council source window (read from code). CDCALC is seen on screen (18 Oct, older build): does not meet, ten top tabs and 72 input controls.
9. **CDCHECKCURRENT.** "What CE Found" panel (read from code). Partly: opens with 0 clicks and has plain captions, but cards are words only.
10. **MR.** No window at all; it runs a native AutoCAD command. Nothing to score on screen.

**4. What was not audited.**

1. Light mode on screen: no screenshot of any CE window in light mode was found.
2. 4 of 116 windows: the two Structural DCL dialogs (`CDD_DCL.dcl`, `RECTANGLE_SIZE_MANAGER.dcl`) and two Civil windows built only in code (`EditorTextReviewWindow.cs`, `PitDetailsReview.cs`).
3. Manager's CE Blocks palette (built in code in `CeBlocksPaletteService.cs`).
4. The 101 measured-only windows were not scored for cards, working-as-a-sum, visuals or click counts.
5. Click counts for CD, PITSCHEDULE and CDCALC are estimates from code, not tested.

---

# TECHNICAL NOTES

**A. Method and counts**

1. **Code line.** `C:\CE_WORK\build\wtB14b`, history contains `dadac7e7`. All file paths below are under `Modules\` in that checkout.
2. **Windows that exist, N of M.** Civil 56: 45 windows, 3 pages hosted in windows (`CivilGeneralSettingsView`, `CivilHelpGuideView`, `CivilSettingsView`), 6 panels or pages (`CeAssistantControl`, `DrawingCheckPanelControl`, `ChecksListControl`, `InspectorPanelControl`, `DesignImpactHubPage`, `NetworkRedesignHubPage`), 2 code-built windows. Manager 9 (3 windows, 6 pages). Structural 51 (49 XAML windows, pages and palettes, plus 2 DCL). Total 116.
3. **Audited, N of M.** 112 of 116. Read in full (11): LPD, New Pit, New Pipe, Edit Pipe, Edit Pit, Pit Schedule, CDCALC, Proposal Preview, Council Source, What CE Found panel, Checks list. Measured only (101) with `scratchpad\scan.sh` and `tally.sh`.
4. **Measured tests per window** (any failure counts one): more than three text sizes; hard-coded hex colours; a question as a title; a software word in a label; more than 20 input controls. Zero failures = "no fault found in what can be measured". Three or more failures = "does not". "Meets" was only awarded where all five groups were read, so 0.
5. **Seen versus read.** Screenshots under `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\` that I looked at: `LPD14_L2_20261114_1618\screenshots\LPD14-15-lpd-window.png`; `RSQ15_Q1_20261115_0123\screenshots\RSQ15-05-Q01-edit.png`; `BWa_20261103_1944\screenshots\W234-01-01-newpit_20261103_194731_425.png`; `D6_20261026_0510\screenshots\D6-26-schedule-window.png`; `L1_20261018_1027\screenshots\L1-18-calculations.png`; `B1b_20261103_2057\screenshots\B1b-CDRULES_20261103_210508_466.png`. The 18 Oct, 26 Oct and 3 Nov shots predate 3.0.90.4, so layouts could differ. Everything else is **read from code, not seen on screen**.
6. **Rule groups scored.** (a) Look: shared parts, one accent, dark and light. (b) Cards: one answer, order, sum, three sizes, bold number, picture. (c) Colour: meaning plus word, status colours only. (d) Fewer clicks: few fields with "More", Undo, actions on the item, click count. (e) Words: plain words, errors, short titles.

**B. Shared parts or each window styles itself**

1. **Partly shared in Civil.** `Drainage\Themes\DarkTheme.xaml` and `LightTheme.xaml` (72 keys each; `BaseWindowStyle` line 85, `PrimaryButtonStyle` line 542, `SecondaryButtonStyle` line 547, `PillToggleButtonStyle` line 762). `Themes\CivilEditorShellTheme.xaml` (glyphs, `CeShell*` styles). Controls `StatusChip.xaml`, `CeEditorShell.xaml`, `CeFieldRow.xaml`, `CeSuggestionStrip.xaml`, `CeProvenanceChip.xaml`. 45 of 45 Civil windows except `JobTimerToast.xaml` use `BaseWindowStyle`.
2. **No shared card in Civil.** There is no card style key in the Civil themes (only 9 style keys, none a card). Cards are hand-built borders, for example `PitDialog.xaml` line 76 and `PitEditWorkshopDialog.xaml` header border. Manager's `FactCardStyle` and Structural's `UiSectionCardStyle` (`Structural\UI\Themes\Theme.Base.xaml` line 267) are separate.
3. **Same style written more than once.** `DesignPrimaryButton` is defined in `CivilDesignWindow.xaml` line 5, `LpdWindow.xaml` line 4 and `RainfallWindow.xaml` line 4. Four toggle-button looks: `TypeToggleButtonStyle`, `PillToggleButtonStyle`, `CeShellToggleStyle`, and a local `CeToggleButtonStyle` (`PitDialog.xaml` line 13).
4. **Three module style sets.** Civil uses `AccentBrush`-style names. Manager and Structural use `Ui*` names (`Manager\UI\Themes\Theme.Base.xaml`, `Theme.SwissModern.xaml`, `Theme.SwissModern.Dark.xaml`; same trio in Structural). `Manager\UI\Dialogs\PluginManagerWindow.xaml` redefines `PrimaryButtonStyle` locally (lines 15 to 27) with a header colour instead of the accent.
5. **Accent.** Civil dark `#C9A84C` (`DarkTheme.xaml` line 15), light `#1E5AA8` (`LightTheme.xaml` line 14). This is the point the 15 Nov reading flags: your rule is one accent; the guidebook has two. Use in text: 193 `Foreground` uses of `AccentBrush` across Civil dialogs and controls; `InspectorPanelControl.xaml` has 22.
6. **Status colours.** `StatusChip.xaml` draws a shape plus a word, so it survives losing colour (good). But `DarkTheme.xaml` lines 42 to 53 define five chip colours (ok, warn, stop, unknown, propose, notice); "propose" is a violet (`#C88FBD`), which is outside green, amber, red.
7. **Charts.** `ChartSurface/Invert/Crown/PipeWall/GridBrush` (`DarkTheme.xaml` lines 72 to 77) are named by meaning, not a fixed five-colour order. `CalculationsV2Dialog.xaml` lines 335 to 343 uses a legend of line swatches, not direct labels.
8. **Text sizes.** Civil dialogs and controls use 17 distinct sizes (9 to 28); the most common are 11 (289 uses), 12 (254) and 10 (51). Manager uses 13; Structural 14.

**C. Per window, the ten tools first**

1. **LPD, `Drainage\Dialogs\LpdWindow.xaml` (seen on screen, 14 Nov). Overall partly.**
   - **Look: partly.** Shared `BaseWindowStyle`; gold on the title (line 37 area), the selected tab and the main button. Gold on a title is outside "main buttons and selected item only".
   - **Cards: does not meet.** The "Connection note" card is words only; no answer, no picture, no sum.
   - **Colour: partly.** Gold only; no status colour needed.
   - **Fewer clicks: meets.** 2 fields and a tick box; Continue in drawing is default. Clicks to finish: 3 (type dropdown, pick, Continue). Seen.
   - **Words: partly.** Title "What does this site discharge into?" is a question (`LpdWindow.xaml` line 37). "invert" is a drafting word, fine.
2. **New Pit, `PitDialog.xaml` with `PitOnePageLayout.cs` (seen on screen, 3 Nov). Overall partly.** The XAML tabs are only a source; the shown page is rebuilt in code (`PitOnePageLayout.cs` lines 37 to 135).
   - **Look: partly.** Shared styles plus local `CeToggleButtonStyle` and `PitCompactGroupBoxStyle` (lines 13, 46). Dark seen; light not seen.
   - **Cards: partly.** Plan preview picture (good); no big number; working line "Cover level: Was Unknown → Now 19.000 m AHD" is not a sum. 5 text sizes.
   - **Colour: partly.** Gold banner "Preview — changes not saved" and `PitDialog.xaml` line 252 use gold for a caution (should be amber with a word). Green chip carries a word.
   - **Fewer clicks: meets.** Pit number pre-filled (P91), "More…" holds the rest (`PitOnePageLayout.cs` lines 51 to 77), Enter places. Clicks: 1 (Continue placement) plus typing the cover. Seen.
   - **Words: partly.** "IL", "SPS radius", "Sump pit · own bottom IL" are drafting words; "Preview — changes not saved" fine; "Read full plan text" fine.
3. **New Pipe (CD), `CdDialog.xaml` (read from code, not seen on screen). Overall does not meet.** `CdCommand.cs` line 148 opens this window; unlike Edit Pipe it is not rebuilt as one page.
   - **Look: partly.** Shared theme; `TypeToggleButtonStyle` and `PillToggleButtonStyle` side by side.
   - **Cards: does not meet.** 1,267 lines, 5 text sizes (two at 28), no answer card, a preview only.
   - **Colour: partly.** `AccentBrush` on 7 text items.
   - **Fewer clicks: does not meet.** 59 input controls; groups PIPE BASICS (line 195), TEXT & ARROW (363), SCHEDULE & AUTOMATION (449), GRADE (516), FLOW / INVERTS (619) all open; only "Quick placement" is an Expander (line 473). Clicks for the usual job: 1 if the remembered settings are right (Primary action default, line 1249), 3 to 5 when diameter, grade and inverts change (estimate).
   - **Words: partly.** "Mask invert text (MTEXT)" (line 949), "Use single pipe entity" (line 469), "Cross-plan break" (line 306). Uphill warning (`CdCommand.cs` lines 888 to 900) is plain but is a three-way question box.
4. **Edit Pipe, `PipeEditWorkshopDialog.xaml` with `PipeOnePageLayout.cs` (seen on screen, 15 Nov). Overall partly.**
   - **Look: partly.** One page, ENGINEERING and DRAFTING columns, rounded plan picture. Gold on headings and on selected toggles (right use) plus on the heading text (outside the rule).
   - **Cards: partly.** Real plan preview is the visual; no single answer or sum; one line "IL Unknown" in the picture.
   - **Colour: meets.** Green chip "Ready to save the pipe." has a word.
   - **Fewer clicks: partly.** "More…" exists (`PipeOnePageLayout.cs` line 154) but about 30 buttons show at once (seen). Save is 1 click; a diameter change is 1 click (recent buttons) plus Save.
   - **Words: partly.** "Legacy geometry only", "Adjust Arrow Position", "IL labels". "I know one end — work the other out from the grade" is plain and good.
5. **Edit Pit, `PitEditWorkshopDialog.xaml` (read from code, not seen on screen).** Same one-page build as New Pit (`PitOnePageLayout.cs`); scores follow New Pit: partly.
6. **CDRUNSOLVE, `ProposalPreviewDialog.xaml` (read from code). Overall partly.**
   - **Look: partly.** Shared style; 3 text sizes (meets that test); gold title (line 47).
   - **Cards: does not meet.** One grid headed "Entity, Field, Old value, New value, Reason" (lines 78 to 86).
   - **Colour: cannot tell from code.** Errors red and warnings amber (lines 99 to 117) but the status word comes from the message text.
   - **Fewer clicks: meets.** Apply is default (`IsDefault`, line 143 area); 1 click. Escape cancels.
   - **Words: partly.** "Entity" (line 78) is a software word. Footer sentence "Apply rechecks this exact proposal, then writes every reviewed change in one step" is long.
7. **CDRENUMBER, `Commands\PitRenumberCommand.cs` (command line, no window).** Lines 101 to 110: "N pit(s) will be renumbered. Apply? [Yes/No]", default No. **Fewer clicks: does not meet** (a question instead of Undo). Other groups not applicable.
8. **PITSCHEDULE, `PitScheduleDialog.xaml` (seen on screen, 26 Oct, older build). Overall partly.**
   - **Look: partly.** 8 text sizes (11 to 22); gold on header title and "CUSTOM REMARKS" (accent used on 10 text items).
   - **Cards: does not meet.** Wide table; no big number; "29 rows listed" and "Will be placed: 29 rows" are the only counts, in small text.
   - **Colour: partly.** "Drawing check: 97 data issues may affect this schedule" in amber (with a word, good), but the amber and the gold selected-tab colour are close.
   - **Fewer clicks: partly.** Four tabs (Source, Rows, Changes, Placement; lines 144, 386, 1030, 1137); Continue is greyed in the shot. Estimate 3 clicks to place. Right-click menu has the row actions (lines 509 to 592), so actions are off the card.
   - **Words: partly.** "XREFs" (line 160), "Link and overrides" (479), "Enable Row Override" (543), "Export CSV" (1275), tooltip "Controls CSV, new placement…" (311).
9. **CDCALC, `CalculationsV2Dialog.xaml` (seen on screen, 18 Oct, older build). Overall does not meet.**
   - **Look: partly.** 7 text sizes, four local styles.
   - **Cards: does not meet.** Ten top tabs (Detention, Older longitudinal, Profiles, Pipe Flows, Boyd's Method, Charged System, Older calculators — Pump System, Catchments, Older calculators — WSUD, Print) and a nested set under each; "Required volume 9.42 m³" is a field, not an answer card. The long-section chart (lines 330 to 410) is a real picture.
   - **Colour: partly.** `AccentBrush` on 13 text items; legend swatches.
   - **Fewer clicks: does not meet.** 72 input controls, no "More". Estimate 3 clicks to Print, then Insert Criteria Block.
   - **Words: partly.** "Older longitudinal", "Older calculators" are not drafting words. Pop-ups in `CalculationsV2Dialog.xaml.cs` lines 165 to 216 say what happened and what to do ("Type the areas as usual"), which is the right pattern.
10. **CDRULES.** Command line (seen on screen, 3 Nov): "CE rules: show all findings, problems only, the values in use, or explain each problem [All Problems Values Explain pReview Source]" (`RulesCommand.cs` lines 43 to 50). **Words: partly** (a long prompt, no click path). **Council Source window, `CouncilSourceDialog.xaml` (read from code): partly.** 1 text size (meets); a fixed yellow highlight `#33FFD54F` (hard-coded, same in dark and light; look: does not meet for dark and light); "Applicability passage" (line 48); cards words only.
11. **CDCHECKCURRENT, `DrawingCheckPanelControl.xaml` and `ChecksListControl.xaml` (read from code). Overall partly.**
    - **Look: partly.** Shared panel host; 6 text sizes; area figure in gold (`DrawingCheckPanelControl.xaml` line 54).
    - **Cards: does not meet.** A headline plus lists of words (lines 118 to 195); no picture, no sum.
    - **Colour: meets.** Status text carries a word (line 42).
    - **Fewer clicks: meets.** The panel opens with 0 clicks (`CheckCurrentDrawingCommand.cs` lines 30 to 34).
    - **Words: meets.** Captions "WHAT CE FOUND", "WHY IT NEEDS CHECKING". Failure message (`CheckCurrentDrawingCommand.cs` lines 43 to 46) says what happened and what to do. Note: with the "Checks list" switch on, the command opens `ChecksListControl.xaml` instead (line 28 of the command); that list has 6 sizes.
12. **MR, `Commands\CopyRotateCommands.cs` lines 25 to 32.** Runs the native component; no window. The missing-file error (lines 46, 53, 55) is worded for an engineer-IT reader ("CE ObjectARX transform component is missing. Repair the CE installation."): words: partly.

**D. Civil: the rest (measured only, 43 windows)**

1. **Result.** 19 no fault found, 22 partly, 2 do not. Over three sizes: 17. Hard-coded colour: 3. Question title: 1. Software word: 7. Over 20 fields: 4.
2. **Hard-coded colours.** `CouncilSourceDialog.xaml` (1), `SlabEditDialog.xaml` (2), `WaterTankDialog.xaml` (1), `WaterTankPlanBlockPickerDialog.xaml` (1).
3. **Question title.** `ContinueRisingMainDialog.xaml` line 37: "Continue this rising main on another plan?".
4. **Software words.** `CdHelpDialog.xaml` lines 94, 123 ("Sync or Rebuild"), 145 ("Command registry"); `CdRepairDialog.xaml` lines 85 ("Rebuild Project Data"), 126 ("Rebuild Compound Links"), 164 ("Toggle Debug / Diagnostics"), 167 ("evidence for IT"); `AdvancedSettingsDialog.xaml` line 1135 ("diagnostic log"); `CivilSettingsView.xaml` line 213 ("diagnostic logging"); `SlabEditDialog.xaml` line 132 ("Label handle"); `InspectorPanelControl.xaml` lines 266 and 321 ("Handle", "GIO Handle"); `DesignImpactHubPage.xaml` line 169 and `NetworkRedesignHubPage.xaml` line 407 ("Rebuild … preview", "signed preview"); `DesignCheckDashboardDialog.xaml` lines 197, 517 ("CSV").
5. **Largest windows by control count.** `AdvancedSettingsDialog.xaml` 127 controls over 1,504 lines (words in a settings page, no "More"); `CivilSettingsView.xaml` 87; `CalculationsV2Dialog.xaml` 72.
6. **Are-you-sure pattern.** `RibbonContextCommands.cs` line 49 ("…One Undo. Continue?"), `NativePipeObjectCommands.cs` line 176 ("Continue? [Yes/No] <No>"), `MirrorService.cs` line 45 ("Do you want to mirror the text?"). The batch editor is the good example: `BatchEditWorkshopDialog.xaml` line 19 says Apply is one AutoCAD Undo.
7. **Raw message boxes.** `CeAssistantControl.xaml.cs` lines 747 to 791 (for example "CE Cloud authority is unavailable", "No authenticated seat grant", and line 791 appends `ex.Message`). Software words and no next step.

**E. Manager (measured only, 9 windows and pages)**

1. **Result.** 6 no fault found, 3 partly, 0 do not. Over three sizes: 2 (`PluginManagerWindow.xaml` has 11 sizes). Hard-coded colour: 0. Software word: 1 (`PluginAdminWindow.xaml` line 52, "Create Support Bundle").
2. **Good practice.** `ManagerScreenText.cs` (lines 9 to 21) keeps a list of banned software words ("bridge", "payload", "assembly", "contract"…) and rewrites screen text. No equivalent exists in Civil or Structural.
3. **Dark and light.** Manager has both `Theme.SwissModern.xaml` (accent `#1E5AA8`) and `Theme.SwissModern.Dark.xaml` (accent `#C9A84C`). Designed in code; not seen on screen.

**F. Structural (measured only, 49 windows, pages and palettes)**

1. **Result.** 17 no fault found, 31 partly, 1 does not. Over three sizes: 13. Hard-coded colour: 13 windows. Question title: 2. Software word: 12. Over 20 fields: 1.
2. **Dark mode not designed in places.** `CeSheetsValidationReportWindow.xaml` lines 53 to 75 hard-code light pastel chips (`#E6F4EA`, `#FFF8E1`, `#FDECEA` with green, amber, red text) and heading text "White" (line 38 area). They stay light in dark mode. Also hard-coded colours in `CeSheetsSyncPreviewWindow.xaml` (6), `RCMemberDialog.xaml` (4), `StrucSuiteWindow.xaml` (5).
3. **Question titles.** `SuggestEditDialog.xaml` lines 45, 56, 73, 91; `IdlePromptDialog.xaml` line 38 ("You've been idle. What would you like to do?").
4. **Software words.** `AdminHubWindow.xaml` lines 37 to 60 ("diagnostics, debug toggles", "Toggle Bracing Debug"); `CePropsDialog.xaml` lines 184, 189, 192, 213 ("manifest", "Sync managed project drawings"); `CeSettingsDialog.xaml` lines 148, 323, 363 ("Diagnostic mode", "debug logging"); `CeSharedTitleMappingWindow.xaml` line 92 ("CS_Settings.json"); `CeSheetsSyncPreviewWindow.xaml` lines 4, 34, 188 ("Sync"); `CeProjectSheetsWorkspaceView.xaml` lines 338, 339 ("Save Manifest", "Sync Drawings"); `SheetsPanel.xaml` line 116; `StrucSuiteWindow.xaml` lines 69, 231; `AboutDialog.xaml` line 83 ("loaded DLL path").
5. **Errors.** `BeamSettingsDialog.xaml.cs` lines 148 to 220 say "Invalid Input" and the allowed range (says what is wrong, not always what to do; mentions "OSMODE" at lines 204 to 220). `CeSheetsWindow.xaml.cs` lines 111, 124, 158, 383 and `CeIssuePublishDialog.xaml.cs` line 269 pass `ex.Message` straight to the user.
6. **Most fields on one screen.** `CeSettingsDialog.xaml` 141 controls in 429 lines, two Expanders. `FstManagerWindow.xaml` and `CommandsPanel.xaml` use "More" or Expanders.
7. **Own theme loader.** Dialogs call `ThemeManager.ApplySwissTheme` (for example `CePropsDialog.xaml.cs` line 15) instead of one shared window style.

**G. Click counts, most common task (estimates unless seen)**

1. **PIT** 1 click plus the cover typed (seen).
2. **CD** 1 to 5 (code; estimate).
3. **CDLPD** 3 (seen).
4. **CDEDIT** 2 for a diameter change (1 recent-size click, Save) (seen).
5. **CDRUNSOLVE** 1 (Apply, code).
6. **CDRENUMBER** 0 clicks, 2 typed answers (code).
7. **PITSCHEDULE** about 3 (code).
8. **CDRULES** 0 clicks, 1 Enter (default Problems); **CDCALC** about 3 (code).
9. **CDCHECKCURRENT** 0 (code).
10. **MR** 0 clicks, picks on the drawing (no window).
11. **Tap budgets.** No window states a written click budget anywhere in the code; "over budget = not finished" cannot be tested today.
