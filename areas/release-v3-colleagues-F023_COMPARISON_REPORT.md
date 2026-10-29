# F-023: Tim's settings compared with what a fresh PC gets (CE 01, Thu 29 Oct 2026, 12:40 Melbourne)

Read-only comparison. Nothing built, nothing installed, no PR, none of Tim's files changed, moved or copied.
Code read: `origin/claude/rel-20261026z` at `09126560` (Civil 3.0.85, the installed build).
Files read on this PC: `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`, `CD_RecentValues.json` beside it, `parts_catalogue.json`, `label_styles.json`, and the Manager CE Blocks file. Folder paths below are shown as `<path>`.

## ANSWER FIRST

1. **PR:** none (read-only job, as asked).
2. **What Max would see differently today, if he got the built-in defaults:**
   1. **Ordinary pipes, not the one-piece CE pipe object.** This is the big one. It is decided by Max's Windows login, not by any file.
   2. **Different snaps while drawing with CD.** AutoCAD's Extension snap would be on while he picks the route, and snaps would be on while he places pipe text. Both are off on Tim's PC.
   3. **A light or "auto" window colour** instead of dark.
   4. **Different starting answers:** a rising main has no default destination (Tim: WT, the water tank); the pit lid type starts as "Class C Grated Lid" (Tim: "Class A Grate"); and the tank-to-plan picks Tim has already made are not remembered.
3. **My own mistakes first:**
   1. My first pass at reading the built-in values misread four settings groups. The cause was a comment containing the word "class". I caught it, fixed the reader and ran it again. The counts below come from the second run.
   2. Every built-in value here was read from the code, not from a running CE (no dotnet, no AutoCAD in this job). I worked out about 20 named starting values by hand, from their constants.
4. **What is NOT proven:**
   1. Nobody has started CE on a clean profile and read what it actually used.
   2. I did not compare the Structural settings file (`CS_Settings.json`, 351 KB).
   3. I do not know why Tim's `CD_Settings.json` shows a last-changed date of 11 Mar 2026 when it holds values from late September.
5. **Robot case that would prove it:** **F23_fresh_profile** (and its control **F23s**). The full wording is in section 7.

---

## FOR TIM

1. **How many differ.**
   1. CE has 500 settings in its Civil settings file.
   2. Your file holds 222 of them. For the other 278 your PC uses the same built-in value Max would get, so those already match.
   3. Of the 222 your file holds, only **6 behaviour choices** are really different from a fresh PC, plus **1 extra pipe** in your parts list (DN100 UPVC).
   4. Everything else that differs is personal: your folder paths, window sizes and positions, recent diameters, last cover level, the "start here" tour already opened. Those must not go to Max.

2. **The three that matter most to Max.**
   1. **One-piece pipe object.** On your login CE turns every pipe into the one-piece CE pipe object. On Max's login it would not, so his pipes stay ordinary polylines.
      - Copying your file does NOT fix this. Your file says "Automatic", and on Max's login "Automatic" means off.
      - For Max to get your pipe, his starting settings must say **On**.
      - On 26 Sep you chose to hold this on colleagues' PCs until it was proven on AutoCAD 2022 to 2024. Max is now on 2027 only, so that reason may no longer apply to him, but that is your call (question 40, still open).
      - Example: with it off, when Max moves a pit, his pipes do not follow the way yours do.
   2. **Snaps during CD.**
      - While you pick a pipe route, your CD leaves AutoCAD's Extension snap off. A fresh PC turns it on.
      - While you place the pipe text, your CD turns every snap off. A fresh PC turns 11 snaps on (Endpoint, Midpoint, Nearest and others).
      - Example: on Max's PC the pipe text could snap onto a nearby pit corner instead of landing where he clicks.
   3. **Starting answers in the windows.**
      - **Rising main destination:** WT (water tank) on your PC; blank on a fresh PC.
      - **Pit lid:** "Class A Grate" on your PC; "Class C Grated Lid" on a fresh PC.
      - **Tank plans:** your three tank-to-plan picks (2000 L slimline, 2000 L round, 3000 L round) are remembered on your PC; on a fresh PC CDWT asks again.

3. **What I recommend.**
   1. Max's starting settings carry only the 6 choices above (plus the extra pipe, if you want it) and the pipe-object answer you give.
   2. Everything else stays at CE's built-in value. That way a switch we turn on in a later update (for example Tidy labels, which you said yes to today) also turns on for Max.
   3. CE reads this small starting file only the very first time it starts on a PC that has no settings yet. It never touches a PC that already has settings.
   4. Example: Max installs, starts AutoCAD, draws a pipe, and gets your snaps and your dark windows without opening Settings.

4. **For CE 04 to ask you (I have not decided these):**
   1. **The 5 mm pit drop in your file.** It is not used anywhere today: the pit drop rule in the drawing uses 20 mm and only allows 0, 20 or 50. Is it a test leftover?
   2. **"No snaps at all while placing pipe text".** Is it your choice, or left over from a test?
   3. **The extra DN100 UPVC pipe** in your parts list (added on or before 15 Sep). Is it a choice or a test leftover?
   4. **The pit schedule column order you set** (Source, State and Override columns first). Should Max get the same, or the standard order?
   5. **The pipe object for Max:** On, or keep the hold (question 40).

5. **What is unknown.**
   1. Nobody has started CE on a clean login to see what it really does. That needs the test PC (or Max's PC).
   2. Nobody has tested the pipe object on an ordinary login. Every robot test so far has run on your login.
   3. Your Structural settings were not compared.

---

## 1. Where CE keeps its switches (read on 3.0.85)

1. **Civil settings file:** `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`.
   - `SettingsService.cs:51-56`: `ResolveSettingsFolder` gives `%APPDATA%\TIM_CE_CADTOOLS`. A test run uses a temporary folder instead (`CE_LOG_DIR_OVERRIDE`).
   - `:82`: the file is `CD_Settings.json` inside that folder.
2. **Missing file:**
   - `LoadSettings` (`SettingsService.cs:156-311`) finds no file, logs "Using default settings" and returns `new UserSettings()` with `OldStartingValuesMoved = true` (`:306-310`). Nothing is written until a real save.
   - A file that exists but cannot be read is copied aside (`ProtectUnreadableOriginal`), and routine saves are held. It is never replaced by the built-in values behind the user's back.
3. **Start-up read:** `ReadSettingsText`, then `DeserializeSettingsTolerant` (`:752`), with `ObjectCreationHandling.Replace`.
   - Any key absent from the file keeps its code initialiser.
   - Any section that is missing is restored by `RestoreMissingSections`.
   - So a key Tim's file does not hold takes the built-in value on his PC too.
4. **Load-time moves that change Tim's stored values:**
   - **Once-only moves** (`:173-223`, plus step-iron depth `:241-258`): velocity no greater than 3.0 is raised to 6.0, an SC/CJ label height under 200 is raised to 250, and a step-iron depth of 1000 drops to 900. None of these touches Tim's values (6 / 250 / 250 / 900).
   - **`ResolveSteepestGrade`** (`:943-954`): Tim's file holds the retired `20` / "Assumed - office value to confirm" / `false`. It is moved to 0 (no limit) at every load, so it is effectively the built-in value.
   - **LPD note:** an old default is replaced. Tim's note is already the current default.
5. **Remembered-values file:** `CD_RecentValues.json`, beside the settings file (`SettingsService.RememberedValues.cs:35-60`).
   - About 60 "last used" fields (pit sizes, last pipe, recent strips, CD tick boxes, quick mode, pit schedule filters) are laid on top of `CD_Settings.json` at load.
   - On Tim's PC this overlay puts pit size, label position, detention widths and grade method back to the built-in values. That cancels the older values still sitting in `CD_Settings.json` (600 x 900 pit, "custom 100" grade, TR label).
6. **Editor shell flags:** `editorShell.flags` inside `CD_Settings.json`.
   - `CeEditorShellStateStore.cs` holds only the fallback constant (`CeEditorShellFlagDefaults.WorkshopLayout = true`, line 41).
   - Tim's `{"editors.workshopLayout": true}` gives the same result as the built-in value.
7. **Manager switch file:** `%APPDATA%\CE_SUITE\manager-switches.json` (`CeOneGlanceStatus.cs:223,260-268`). If it is missing, every Manager switch is OFF. **Tim has no such file** (the `CE_SUITE` folder does not exist), so Max and Tim match.
8. **Manager CE Blocks file:** `%APPDATA%\Creative Engineering\CE Suite Manager\ce-blocks-settings.xml` (`CeBlocksSettings.cs:32-63`).
   - Tim's file holds two folder paths (both equal to the built-in pattern under his own profile), `PaletteDockVersion 2`, and two recent blocks.
   - `FrozenLayerWarnsAndPlaces` is not stored, so it is built-in ON for both.
9. **Other per-user files read by CE:**
   1. `parts_catalogue.json` (`PartsCatalogueService.cs:35`): built-in is 17 grated pits and 10 RCP pipes. Tim's has the same plus **DN100 UPVC**.
   2. `label_styles.json` (`LabelStyleService.cs:21`): Default / Verbose / Compact. It looks like the built-in seed (not checked against code character for character).
   3. `CE_Admin\manager-menu-state.json` (per-machine menu path).
   4. `theme.json`, `CD_ProjectData.json` and `jobtime_resume.json`: no reader on 3.0.85 (git grep found none).
10. **The one switch tied to the Windows login:** `PipeObjectUpgradeGate` (section 5). git grep found no other login-based or user-name-based gate.
11. **A hard-coded Tim path** still sits in the code: `LayerService.cs:262` (linetype template drawing under Tim's profile). It is already listed in TEAM_AUDIT finding 11 (BUG-1174 group). It matters for Max but is not a setting.

## 2. Keys where Tim's value differs from the built-in value (`CD_Settings.json`, after load)

The raw text compare flagged 76 of the 222 keys (146 were equal outright). Each one has been checked by hand.

### 2a. Behaviour and drafting choices (carry Tim's value to Max)

1. `osnap.drawingOsmode`: built-in **5247** (END MID CEN NOD QUA INT INS GCEN EXT); Tim **1151** (the same without Extension).
   - CD and Edit Pipe set this while picking the route (`OsnapService.cs:268-271`; `CdCommand.cs:94,236,361,791`).
   - Tim had 1279 in June and 1151 since at least 16 Sep. It looks like a choice.
2. `osnap.textOsmode`: built-in **5887** (END MID CEN NOD QUA INT INS PER NEA GCEN EXT); Tim **0** (no snaps while placing pipe text) (`CdCommand.cs:674`; `PipeEditCommand.Update.cs:666,765`).
   - Tim had 1791 in June and 0 since at least 16 Sep. **List for CE 04:** a choice or a test value?
3. `theme`: built-in "auto"; Tim "dark" (`ThemeService.cs:60`). Tim has had dark since at least June.
4. `pipe.risingMainDestination`: built-in ""; Tim "WT". Not a remembered field, so it is a real setting (read in `CdCommand*.cs`, `PipeEditCommand*.cs`).
5. `pit.lidType`: built-in "Class C Grated Lid"; Tim "Class A Grate". Not in the remembered list (`pit.lidStrength` is).
6. `waterTank.planForTank`: built-in empty; Tim has 3 entries.
   - The keys are `2000 L SLIMLINE|2000`, `3000 L ROUND|3000` and `2000 L ROUND|2000`; the values are plan captions.
   - Office content, no personal data (`SettingsService.cs:976-990`, "a pick made once is never made again").
7. *(Separate file)* `parts_catalogue.json`: Tim has one extra pipe, **DN100 UPVC**. **List for CE 04.**

### 2b. Engineering values (Settings-first, R-00)

1. `inverts.pitInvertDropMm`: built-in **20**; Tim **5**.
   - **Nothing on 3.0.85 reads it.** The R-08 pit drop comes from the drawing's rulebook (`RulebookSettings.cs:46,49`: 20 mm; allowed 0, 20 or 50).
   - `designStandards.pitInvertDropMm` is 20 in both.
   - **Leave out of the export; list for CE 04 as a probable leftover.**
2. No other engineering value differs. These are all equal in Tim's file and the built-ins:
   - Manning's n table, scour table (3 / 6 / 4 m/s), minimum grade by diameter, maximum velocity 6.0, step-iron 900, pit drop 20, LPD note and wrap width, grate capacities, lid class by surface, layer order rules, pavement types, downpipe words.

### 2c. Folder paths and personal items (must NOT go to Max)

1. `options.standardDetailsCivilFolder`, `options.drawingTemplatesFolder`: Tim `<path>` under his own profile.
   - The built-in value is worked out on each PC from that PC's own profile (`UserSettings.cs:1698-1737`), so leaving them out gives Max the right folder (BUG-1167).
2. `jobTime.dataFolderPath`: Tim `<path>`; built-in "" (found on each PC; `detectDataFolderEachStart` ON).
3. `options.computationsFolder`: Tim's value equals the built-in value, but **the built-in value itself is a dev folder on Tim's PC** (`<path>` under `C:\Lisp Files`). It is BUG-1167's third path. Max's export must not hold it, and the built-in value needs its own fix (code, not this job).
4. `install.workspaceMenuCuixPath` and `install.lastWorkspaceMenuVersionInstalled`: per-machine.
5. Window sizes and positions: `options.pitScheduleWindow{Width,Height,Left,Top}` and `options.civilHubWindow{Width,Height,Left,Top}`.
6. `options.pitScheduleColumnLayout`: Tim's column order and widths (Source, State and Override columns first). **List for CE 04.** Recommended: leave out, because the widths suit Tim's screen.
7. `onboarding.startHereTourOpened`, `startHereTourOpenedUtc`, `toolTipShownCount`, `singleObjectCdeditCount`, `fasterWayBatchEditSuggested`: Max should see his own tour and tips.
8. `concreteJoints.lastSlabTypeId` (COMMERCIAL): the last one used.
9. `pipe.lastChoiceByJob`: keyed on a test folder `<path>` (`_test_copies_…`), so a **test leftover**.
10. Remembered fields (in both files; `CD_RecentValues.json` wins):
    - Recent diameters, materials and inverts.
    - Last cover level, last inverts.
    - `pipe.chargedDestination` (WT, a remembered field, so it is not carried).
11. `grade.defaultMinimumValue` "100 MIN.": an old pre-BUG-024 value; the suffix is removed when it is read. Leave it at the built-in "100".
12. `version` "4.0" vs "5.0": no reader. Leave out.
13. Manager CE Blocks: both paths and the recent blocks.

### 2d. Stored in Tim's file but the same as the built-in value (no export needed)

These are among the keys that are effectively the same:

1. `options.pipeObjectUpgrade` "Automatic".
2. `options.cdDrawFirst` true.
3. `options.compoundBehaviorEnabled` true.
4. `editorShell.flags` (workshopLayout true).
5. `options.annotationOffsets` (200 / 150 / 200 / Top).
6. `learning.habitMinRepeats` 3.
7. `linking.pitCatchMarginMm` 100.
8. `linking.pipeEndJoinDistanceMm` 75.
9. `surface.drainTagTextHeightMm` 250.
10. `survey.workflowMode` Design.
11. `options.debugLogging` false, `options.debugEcho` false, `options.quietFirstStart` false.

## 3. Keys Tim's file does not hold (278; built-in value on his PC AND on Max's)

1. All 19 `diag.redo.*` switches are absent, so they are OFF on both PCs. **No diagnostic switch is left ON on Tim's PC.**
2. All 26 pilot switches named in `PILOT_CRITICAL_TEST_LIST_29OCT.md` are absent, so they are at the built-in value on both PCs. This confirms that list's statement.
3. **Tidy labels** (`linking.tidyLabelsEnabled`) and **grip copy clean-up** (`linking.cleanUpGripRotateScaleCopies`) are absent, so both are **OFF** on 3.0.85 for both PCs.
   - Tim ruled both ON today (TIM_ANSWERS items 8 and 9).
   - When the train changes the code default, both PCs follow automatically, **as long as nobody writes these keys into a file**.
   - **Risk:** a Settings-window save writes every value. If Tim (or Max) saves in Settings before the default flips, their file freezes them OFF. This is the same "no skip defaults" behaviour as BUG-1167.
4. The full list (key = built-in value) is in the appendix.

## 4. Proposed export ("office starting settings")

1. **Carry Tim's value:**
   - `osnap.drawingOsmode` 1151
   - `osnap.textOsmode` 0 (unless CE 04 says it is a leftover)
   - `theme` "dark"
   - `pipe.risingMainDestination` "WT"
   - `pit.lidType` "Class A Grate"
   - `waterTank.planForTank` (3 entries)
   - and, if Tim says so, the extra DN100 UPVC catalogue pipe (a separate file; leave out of version 1).
2. **Carry Tim's ANSWER, not his stored value:** `options.pipeObjectUpgrade`. It must hold **"On"** for Max to get the one-piece pipe. Tim's stored "Automatic" gives Max ordinary pipes. This waits on question 40 and on Tim lifting UX-MIX-03 for Max.
3. **Stay at the built-in value (do not write them):** everything else, so that later default changes (Tidy labels, grip copy, every bug-fix switch shipped ON) reach Max.
4. **Left out, and why:**
   - Every folder path (2c 1-4): each PC works out its own folder.
   - Window sizes and the column layout: they depend on the screen.
   - Onboarding: Max needs his own tour.
   - Remembered and last-used values and recents: personal.
   - `lastChoiceByJob`: a test leftover.
   - `pitInvertDropMm` 5: not read, and probably a leftover.
   - `version`, and `defaultMinimumValue` "100 MIN.": obsolete.
   - Manager CE Blocks paths: per-PC built-in values are right.
5. **For CE 04 (not decided here):**
   1. textOsmode 0
   2. pitInvertDropMm 5
   3. DN100 UPVC
   4. pit schedule column layout
   5. pipeObjectUpgrade On for Max
   6. Whether the Structural settings need the same comparison.

## 5. `options.pipeObjectUpgrade`: exactly what the gate reads

1. **The read:** `PipeObjectUpgradeGate.IsUpgradeAllowed` (`PipeObjectUpgradeGate.cs:54`) is `Resolve(StoredMode(), CurrentAccountSid())`.
   - It is read at each moment of use, not cached, apart from the Windows account, which is read once per AutoCAD session (`:113-136`).
2. **`StoredMode()`** (`:107-111`) is `SettingsService.Current.Options.PipeObjectUpgrade`. It comes from `CD_Settings.json` (not a remembered field).
3. **`Resolve`** (`:58-68`), with `NormaliseMode` (`:75-80`):
   - "On" (any case): allowed.
   - "Off": held.
   - Anything else, including blank, absent and "Automatic": allowed only when the Windows account identifier equals `TestBedAccountSid` (Tim's Entra ID account; `:42,70-72`).
   - An account that cannot be read counts as a colleague.
4. **For Max to get the one-piece pipe:** the export must hold `"options": { "pipeObjectUpgrade": "On" }`. Nothing else works. Copying Tim's file gives "Automatic", which is held on Max's login (the code comment at `:12-14` says this was deliberate).
5. **Unknown:**
   1. Whether the 2027 pipe-object enabler loads and behaves on an ordinary (non-admin, non-Tim) login. It has never run there.
   2. What colleagues still on older AutoCAD see when they open Max's upgraded drawings. They see view-only proxy graphics if PROXYGRAPHICS=1 at save (UX-MIX-03 probe); the safeguard's state is not checked here.
   3. Whether "On" on Max's PC also upgrades older jobs when he opens them (the open-a-job upgrade is inside the gate, so yes by reading). That is a decision about existing jobs as well as new ones.
   4. Twenty robot cases name the pipe object, and all of them ran on Tim's login.

## 6. How a first start on a clean profile should load the export (design only)

1. **Option A: a shipped starting file (recommended).**
   - The bundle carries a small `CE_OfficeStartingSettings.json` that holds only the section 4 keys.
   - `LoadSettings` reads it **only on the branch where no `CD_Settings.json` exists** (`SettingsService.cs:306-310`). It goes through the same `DeserializeSettingsTolerant` reader, laid onto `new UserSettings()`.
   - It never reads the file when `CD_Settings.json` exists, even if that file is empty or damaged. Those keep today's protect-the-original path.
   - Nothing is written until a real save, so until Max saves in Settings a later update's starting file still reaches him.
   - It sits behind a switch, `options.officeStartingSettingsOnFreshProfile`, default ON, shown on the Settings page, pinned in the defaults test.
   - Why: Max does nothing (Tim's 24 Sep "never ask"). It cannot overwrite anything because it runs only when there is nothing to overwrite. It carries no paths.
2. **Option B: a "Load office starting settings" button** on the Settings page.
   - Useful later for a colleague who already has a file.
   - It must show the list of values it will change and need a Save. It must never touch folder paths.
   - Not recommended as the first route, because it relies on Max finding a button.
3. **Both:** A for version 1, with B later if a colleague already has settings.
4. **Never:** copying Tim's whole file (BUG-1167 paths, the test leftovers, and his stored "Automatic" pipe answer).

## 7. Robot case that proves it (draft, not written as a case file)

1. **Where it runs:** on the test PC's ordinary login (QUESTIONS 37). Tim's PC cannot prove the pipe half, because his login turns "Automatic" on.
2. **F23_fresh_profile:**
   1. Set-up: the profile's `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` is absent, and the build carries the starting file holding `pipeObjectUpgrade` "On" and `textOsmode` 0.
   2. Start AutoCAD and open a fresh drawing.
   3. Check the CE log line `[C7] pipe upgrade on this PC: allowed (setting On; this Windows sign-in is not the CE test-bed account).`
   4. Type `CD`. At the first route prompt type `'OSMODE`, then Enter.
   5. Check that the echoed value is `1151`. Esc out, then U.
   6. Check that `CD_Settings.json` still does not exist (nothing was written).
3. **F23s (switch-off control):**
   1. Same set-up, with `options.officeStartingSettingsOnFreshProfile` OFF. That needs a file, so the control is "starting file absent from the bundle" instead.
   2. Check the log says `held (setting Automatic; ...not the CE test-bed account)`.
   3. Check that `'OSMODE` inside CD echoes `5247`.
4. **Broken twin:** a profile that already has `CD_Settings.json` with `osnap.drawingOsmode` 5247. `'OSMODE` must echo 5247, which proves the starting file never overrides an existing profile.

## Appendix: the 278 keys Tim's file does not hold (key = built-in value; the same on both PCs)

1. **pipe:** blankInvertIsWarningNotBlock = true; editPipeReverseArrowReadsDrawnEnds = true; calculatedLevelSetsDirection = true
1. **pit:** coverTextGapMm = 200.0; detentionCoverTextGapMm = 250.0; coverTextStyle = string.Empty; spsLabelHeightSingleMm = 300.0; spsLabelHeightNumberedMm = 250.0
1. **pits:** skipCurrentPitBlockRedefine = true; blocksFromRunningBundleFirst = true
1. **grade:** achievedGradeNoteTolerancePercent = 10.0; showGradeCheckMarkerOnPlan = true
1. **options:** commandOutcomeLines = true; sheetAccentColour = "#000000"; oldStartingValuesMoved = false; proposeLastPitCoverLevel = false; pipeTextHeight = 250.0; levelTextHeight = 180.0
1. **designStandards:** networkUsesPipeMaterial = true; manningsNNotRecognised = DefaultManningsNNotRecognised; manningsNMaterialBlindChecks = DefaultManningsNMaterialBlindChecks; manningsNConfirmedMaterials = (none); minGradeLadderConfirmed = false; minimumVelocityConfirmed = false; pipeSizeLadderMm = (none); scourVelocityConfirmedMaterials = (none)
1. **survey:** xrefHeightsStayRealLevels = true; intakeChecksFollowDrawingUnits = true; transformPairsNeedUniqueLevels = true; unitlessMetreSiteReadAsMetres = true; nestedSurveyBlocksKeepTheirPlace = true; loadSurveySkipSuspectPoints = false; surveyRlMinM = -100.0; surveyRlMaxM = 3000.0; surveyReadsMTextAndMoreTags = false; spotVsSurfaceToleranceMm = 100.0; duplicateDistanceMm = 50.0; duplicateLevelToleranceMm = 10.0; transformMaxRmsMm = 250.0; transformMinPairs = 3; lowCoveragePercent = 50.0; nearestSpotLevelMaxDistanceM = 0.0; offerDesignLevelsBeforeSurvey = false
1. **markup:** gradeSteepestN = 10.0; gradeFlattestN = 2000.0; diameterMinMm = 50.0; diameterMaxMm = 2100.0; levelMinM = -50.0; levelMaxM = 1000.0
1. **layerNames:** names = new Dictionary<string, string>(StringComparer.OrdinalIgno...
1. **layerChecks:** wrongLayerRows = false; layerDiffersRows = false
1. **linking:** propagateWritesSingleIlToItsOwnEnd = true; flatPipeIsWarningNotBlock = true; escKeepsPlacedCalloutLinks = true; batchBlankFieldIsLeftOut = true; keepUnreadableDrawingRecord = true; otherUsersFoldersFollowThisPc = true; civilWakesForPitsWithoutRecord = true; pasteLineForDrawingWithNoRecord = true; inspectorPickWaitsAfterUndo = true; pitScheduleFingerprintScopedToSchedule = true; sourceLabelOwnerCheck = true; reopenedDrawingLoadsItsOwnRecord = true; sourcePickComparesPipeRecordLikeForLike = true; paletteCloseKeepsYourSelection = true; longSectionFrameIncludesPipeStubs = true; scheduleDeleteCellStaysBlank = true; pipeTextFollowsClickedLeg = true; scheduleMoveKeepsRecords = true; scheduleTypedCellsMustBeClean = true; scheduleFromKeepsPitNumber = true; scheduleContinuationRepeatsPitColumns = true; scheduleRowOrderByPit = true; scheduleMergedRowsKeepOwnPipe = true; scheduleWindowMarksOnlyChangedCells = true; scheduleOutletVsLargestInlet = true; raingardenPositionIsAreaCentre = true; wsudAreasHeldToSite = true; sourceTagRefusalsInPlainWords = true; cascadeKeepsPitDrop = true; showOlderLongSectionTab = true; cdUphillAnswerUpdatesSchedule = true; cdUphillCancelPutsBackWhatItCan = true; cdSamePlanRealLengthFirst = true; cascadeRelinksOnlyPlanPipes = true; editPipeRetidyLabels = false; cleanUpGripRotateScaleCopies = false; rotateScaleCopyLikeCopy = true; pitCopyLineNamesOnlyWhatIsMissing = true; cdTagRefusesUsedNumberedName = true; handPlacedLabelsStay = false; pitScheduleNaturalOrder = false; designReviewReadsOfficeSettings = true; pitScheduleXrefSeparatesSaveAsCopies = true; scheduleRefreshKeepsTwinAndTrenchText = true; levelTextRoundsHalfAway = true; pitScheduleDepthOneRule = true; shallowPitDepthMm = 300.0; pitScheduleExportWritesNothing = true; pitScheduleUsesPitFloor = true; pitScheduleRefreshCountsAllConnectedPipes = true; recoverInvertsChecksDrawnText = true; longSectionOlderWriterChecksLevels = true; drawingRecordBeatsPcFile = true; longSectionUpdateKeepsCopies = true; refoundPitKeepsScheduleOverrides = true; renumberScoresJoiningPipe = true; scheduleXrefGroupsKeepDrawing = true; cdMirrorKeepsPipeTextLink = true; xrefCompareChecksOldPosition = true; qaMarksStaleOnCeWrites = true; xrefRepairAvoidsHostAndPrefersMatchingFolder = true; profilePitWidthCountsSpsRadiusOnlyOnPumpStations = true; profileRouteDefaultsToItsOwnScheduleSet = true; longSectionBridgeFullBoreFlowRow = true; topWaterLevelDefaultIsHighestObvert = false; rebuildKeepsOnlyCarrierIdentity = true; copyContinuesWhenDownpipeCannotFollow = true; refuseSplitOfPairedPipe = true; inlineSplitMovesDecisions = true; copyCleanUpKeepsEveryPiece = true; relinkKeepsRecordedDirection = true; pitLabelOnEsc = false; pitLabelOnEscOffsetMm = 350.0; plasticCoverTextOnEsc = false; keepTextReadableAfterRotateMirror = false; tidyLabelsEnabled = false; tidyMovesPitText = false; tidyLeaderOut = false; tidyIgnoresSheetFrame = true; tidyPitByBodyOutline = true; tidyLeaderOutMaxMm = 1500.0; tidyRearrangeNeighbours = false
1. **diag:** redo.disableSelectionObserver = false; redo.disableRibbonContextTab = false; redo.disablePaletteSelectionHandler = false; redo.disablePaletteFirstPickLog = false; redo.disablePaletteTimer = false; redo.disablePaletteRefresh = false; redo.disableContributedPages = false; redo.disableProjectDataSync = false; redo.disablePaletteFirstScan = false; redo.disableOwnershipHighlight = false; redo.disableTwinPickRedirect = false; redo.disableCompoundSelection = false; redo.disableHoverServices = false; redo.disableProjectQaWait = false; redo.disableAllSelectionWork = false; redo.disableUndoProjectReload = false; redo.disableUndoCacheRebuild = false; redo.disableUndoEndWork = false; redo.watchUndoGap = false
1. **pipeSpeed:** pitOutletRecommendedMs = 1.5; pitOutletLimitMs = 2.0; longSectionUsesSettingsRoughness = false
1. **calculationExport:** stampIssueStateOnEveryPage = true; excelNumbersAsNumbers = true
1. **pitScheduleRemarks:** keepCustomNoteBesideStepIrons = true
1. **pitScheduleExcel:** numbersAsNumbers = true
1. **councilRfi:** enabled = false; fileExtensions = new List<string> { ".pdf" }; fileNameWords = new List<string> { "RFI", "request for information", "req...; closingWords = new List<string> { "Yours faithfully", "Yours sincerely",...; topics = new List<CouncilRfiTopic> { new CouncilRfiTopic { Name
1. **xcivilImport:** invertTextAtItsOwnPipeEnd = true; pipeEndPitSearchMm = 3200.0; pitSnapMinMm = 500.0; pitSnapMaxMm = 1600.0; gradeInvertSkipsPipeDrawnFromLowEnd = true; landXmlSumpLevelAsInvert = false; pitFloorIsNotAPipeInvert = true; landXmlAskBeforeWrite = true; scheduleCoverNeedsOneBareNumber = true; landXmlAsksBeforeReplacing = true; importReviewRefusesChangedSource = true; importedPipeNoInventedGrade = true; schedulePairRowsByOrderOnlyWhenSafe = true; landXmlKeepsYourPitOnNumberClash = true; levelRangeFollowsSettings = false; pipeSizesFollowSettingsLadder = false; landXmlCircularDiameterFirst = true
1. **ai:** titleBlockArea = string.Empty; featuresEnabled = false
1. **longSection:** officeLayout = false; refreshDisplayAfterUpdate = true; fitWrappedTitle = true; rows = new List<string> { "DATUM LEVEL R.L.", "PIPE SIZE", "PIPE...
1. **pumpStation:** risingMainSplitLps = 5.0; risingMainSmallMm = 50; risingMainLargeMm = 80
1. **checks:** coverUsesRulebookValue = false; consultantCheckReportBesideDwg = false; recordPipeEndsOffPit = false; leaveOutRemovedPits = false; showProgressWhenSlow = false; progressAfterSeconds = 1.0; typedAnswersPointToChecksPalette = true; allowIgnoreFinding = false; showWhereFillFraction = 0.33; showWhereMinViewMm = 2000.0; showWhereGlow = false; offerToPauseSlowFeature = false; slowFeatureThresholdMs = 2000.0; slowEditsInARow = 3; useSharedResult = false; checksCommandEnabled = ChecksCommandEnabledDefault
1. **windowFeel:** previewQuietMs = 300
1. **privacy:** drawingPersonName = "coded"
1. **tankCallout:** addMakeAndSize = false
1. **doubleClick:** opensEditWindow = OpensEditWindowDefault; sourceEditWindow = SourceEditWindowDefault
1. **rightClick:** editItems = false; showCommandNames = true
1. **windowPlacement:** remember = false
1. **fleetTelemetry:** heartbeatEnabled = true
1. **help:** openWebFallback = false
1. **pipeSpeedChecks:** useMaterialLimit = false
1. **sharedValues:** pitDropFollowsBox = false
1. **wsudTab:** targetTnPct = 45.0; targetTpPct = 45.0; targetTssPct = 80.0; targetGpPct = 70.0; annualRainfallMm = 630.0; imperviousC = 0.85; perviousC = 0.10
1. **chargedTab:** downpipeEntryCoefficient = 0.82; startingRunoffC = 0.9; pipeRoughness = 150.0; lossCoefficient = 2.95
1. **reaches:** floorWasteSpacingMm = 12000.0; lpdPitSearchMm = 500.0; lpdOtherBlockSearchMm = 2500.0; lpdPickedPointSearchMm = 250.0; lpdPitWithinMm = 500.0; joinLabelReachMm = 2500.0; spsWallClearanceMm = 200.0
1. **crossingServices:** showOnLongSections = false; minimumClearanceMm = null; serviceLayers = CrossingServiceLayer.Seed()
1. **downpipeDetection:** duplicateToleranceMm = 50.0; circleDiameterMinMm = 50.0; circleDiameterMaxMm = 300.0
1. **jobChecklist:** officeSteps = new System.Collections.Generic.List<string>(); draftMinJobs = 3; draftMinSharePercent = 50.0
1. **surface:** slabMinimumFalls.concreteOneIn = 100.0; slabMinimumFalls.paversOneIn = 50.0; slabMinimumFalls.asphaltOneIn = 67.0; catchmentOverlayLabelColour = 7; catchmentOverlayLabelOffsetMm = 300.0; catchmentOverlayFillBehindDrawing = true; slabFallUsesDrawingUnits = true
1. **detention:** defaultTcMinutes = 5; catchmentsStartBlank = true; chargedMinHeadWarning = true; defaultPsdAriYears = 5; boydsStartsBlank = true; flowsUseJobRainfallCurve = false; hardGroundRunoffC = 0.9; boydsUsesHardGroundC = false; connectionPipe.connectionPipeAssumedLengthM = TodaysLengthM; connectionPipe.connectionPipeAssumedMaterial = "UPVC"; orificeUsesRuledGravity = true; detentionTabUsesCouncilOrificeCo = true; minDetentionPipeGradeRatio = 200.0; minDetentionPipeGradeFromDiameterMm = 225.0; pipeStorageWallToWall = false; twlUsesDrawingUnits = true; storageMatchTolerancePercent = 0.5; storageMatchToleranceLitres = 1.0; designTabStartsAtSettingsPreDevC = false; detentionWithoutLengthNotDiameterChecked = true
1. **jobTime:** detectDataFolderEachStart = true; weeklyExportInBackground = true
1. **levelsProposal:** warnSteeperThanGradeN = 10.0; warnSteeperThanGradeSource = CeSteepStartingSource; warnSteeperThanGradeConfirmed = true
