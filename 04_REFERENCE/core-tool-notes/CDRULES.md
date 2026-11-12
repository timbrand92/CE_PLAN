# TOOL NOTE: Check against the rulebook (CDRULES)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Checks the drawing's pits and pipes against the engineering rulebook** (council, then project, then office values) and lists the findings on the command line.
2. **Options:** all findings, problems only, the values in use, explain each problem, preview fixes, or (2027) show the council source.
3. **Preview** offers each engineering fix in a preview window to Apply or Cancel.

## 2. What it changes in the drawing

1. **Records the run in the drawing** (every finding is added to a record in the drawing), except for the Values option.
2. **Saves the full list as a text file** in your CE logs folder on this PC.
3. **Apply in Preview** changes the drawing as the fix describes.
4. **No whole-drawing record update.**

## 3. What it will not do

1. **No start-up checks** (read-only, REFEDIT, Paper Space, drawing type). On a read-only drawing the run record cannot be written (not proven how it reports).
2. **Hydraulic grade line and pit losses** are not checked, and nothing says so (see 7).

## 4. What it asks you, and what Enter means

1. **"CE rules: show all findings, problems only, the values in use, or explain each problem [All/Problems/Values/Explain/pReview/Source]":** Enter = Problems. Esc ends quietly.
2. **Values** prints the values and "Nothing was changed."
3. **Preview:** each engineering finding, then a preview window: Enter = Apply. Not applied: "Not applied. Nothing was changed." (the run record has already been written).
4. **Source (2027 only):** "Recorded check number:", then "Finding number:".

## 5. When it says Unknown or "needs checking"

1. **Blank material or pit type:** Unknown with a reason. **Blank size:** a warning.
2. **The end line** says whether the run was recorded.

## 6. How to undo it

1. **The run record and any Apply** are inside the one command. Not proven in AutoCAD.
2. **Not undone by U:** the saved text file.

## 7. Known faults

**Still there in this build**
1. **BUG-520:** no Settings row for the pit-outlet speed or the detention guide grade.
2. **BUG-527:** the Inspector and repair audit still read their own speed value (fallback 3.0).
3. **BUG-902:** cover is judged only at the two pit ends.
4. **BUG-923, BUG-924:** row wording uses program words; "no minimum in the rulebook" lines.
5. **BUG-1006:** the fix advice says "increase the pipe size" for too fast and "reduce the pipe size" for too slow.
6. **BUG-1057, BUG-1059:** council speed limits and the council's DN150 minimum grade never reach the checks (office values only).
7. **BUG-1060:** new jobs show the stormwater standard as 2021.
8. **BUG-1090:** nothing says the hydraulic grade line and pit losses were not checked.
9. **BUG-1111:** the before-development formula text says 0.3 beside a number worked from 0.35.

**Partly fixed**
1. **BUG-461:** the end sentence now depends on whether the run was recorded, but a held-back record write is still reported as recorded.
2. **BUG-521:** CDRULES uses council, project, office; the Inspector and repair checks follow only with a switch (off by default).
3. **BUG-903:** cover follows BUG-521; the grade part not traced.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-239, 514, 540, 867, 901, 906, 907, 1092:** each has a change in this build (see the sources). BUG-542 is fixed behind a switch that is off by default.

**Reported, could not confirm in code**
1. **BUG-441:** no CDRULES fault in the entry.
2. **BUG-546, BUG-547:** several values still have no Settings box; not all were checked.

**New in code, no bug covers it**
1. **"Results recorded" can print when the record write was held back.**
2. **The run record grows** with every run (no cap found).
3. **A second Apply in one Preview** is likely refused as out of date (not proven).

## 8. On AutoCAD 2022 to 2024

1. **No Source option** (the council source view is AutoCAD 2027 only).

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 1.2, 4.1:** `Commands\RulesCommand.cs:34-57`; `Services\ProjectDataService.RulebookDrawing.cs:19-27, 206`; `Rules\RulebookValues.cs:111`.
2. **1.3, 2.3, 4.3:** `RulesCommand.cs:123-124`, `193`, `210`; `Services\ProposalApplyService.cs:208`.
3. **2.1, 7 new 2:** `RulesCommand.cs:112-115`; `Rules\RulebookRunRecord.cs:16-21`.
4. **2.2, 6.2:** `RulesCommand.cs:274-296`.
5. **2.4, 3.1:** no record update or `CommandPreFlight` in `RulesCommand.cs` (note at `15`).
6. **4.2:** `RulesCommand.cs:75`. **4.4, 8.1:** `RulesCommand.cs:49-51, 61-67, 134-176` (`#if NET10_0_OR_GREATER`).
7. **5.1:** `Rules\RulebookEngine.cs`. **5.2, 7 BUG-461, 7 new 1:** `RulesCommand.cs:40, 113, 130`; `Rules\CheckEndSentences.cs:9-14`; `ProjectDataService.RulebookDrawing.cs:385-400`.
8. **7 still there:** BUG-520 `Models\UserSettings.cs:3585`; BUG-527 `Services\InspectorPaletteService.cs:3404`, `Services\LinkService.RepairAudit.Analysis.cs:37, 250`; BUG-902 `RulebookEngine.cs:524-566`; BUG-923 `RulebookEngine.cs:76, 290, 371, 482-490`; BUG-924 `RulebookEngine.cs:411, 505, 516, 536, 800, 895`; BUG-1006 `Rules\RuleFixAdvisor.cs:81, 86`; BUG-1057 `RulebookValues.cs:278-289`, `Models\CouncilProfileModels.cs`; BUG-1059 `RulebookValues.cs:295-300`; BUG-1060 `UserSettings.cs:3033`, `RulesCommand.cs:258`; BUG-1090 `RulebookEngine.cs:46-57`; BUG-1111 `CouncilProfileModels.cs:124`, `Rules\CouncilRuleValues.cs:147-153`.
9. **7 partly:** BUG-521 `UserSettings.cs:3985`, `Services\MinimumCoverForChecks.cs:35-45`.
10. **7 fixed:** BUG-239 `Rules\CouncilRuleValues.cs:19-22, 48-52`; BUG-514 `RulebookEngine.cs:488-490`; BUG-540 `ViewModels\PitScheduleViewModel.cs:41-43`; BUG-542 `UserSettings.cs:3597`, `Services\ProfileRouteEvidenceCaptureService.cs:798-804`; BUG-867 `RulebookEngine.cs:64-80`; BUG-901 `UserSettings.cs:317`, `RulebookEngine.cs:546-564`; BUG-906 `RulebookEngine.cs:631-636`; BUG-907 `UserSettings.cs:1918`, `RulebookEngine.cs:804-820`; BUG-1092 `Services\DesignValidationService.cs:318-349`, `RulebookEngine.cs:384-386`.
11. **7 BUG-546/547:** `ViewModels\AdvancedSettingsViewModel.cs:1339, 1679`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:08. Nothing was run in AutoCAD.
