# Opus pre-review N: PR #1877 (B-061, BUG-1112, WSUD export sample site)

Independent read-only review, Fri 30 Oct 2026 20:45 Melbourne time. Head `b9842f28`, base `claude/rel-20261102a` at `91963bd0` (the PR sits directly on the base tip: one commit, six files). Nothing built, no test run, no AutoCAD opened, no repository file changed.

## FOR TIM

1. **Verdict: KEEP-WITH-NOTE, next Civil train on `claude/rel-20261102a`.** It does what the bug asks: a new job's computations package no longer prints a 1,000 m2 site with 200 / 700 m2 roofs and paving that nobody typed. Those lines now read "not entered". Built and unit-tested only. Nobody has opened it in AutoCAD.
2. **One claim in the author's report is wrong.** It says "type a site area and everything prints as normal". You cannot type there: the WSUD tab in CDCALC is read-only (every box is locked). In practice the figures only print for an older drawing that already carries a saved WSUD calculation with real figures. The robot case as written ("type 850") cannot be run and must be rewritten.
3. **How it decides "not entered": by a "changed since the window opened" mark, not by the number itself.** A job whose saved calculation holds exactly 1000 / 200 / 700 would wrongly read "not entered". Low risk, because nobody can type into that tab now.
4. **Rainfall (630 mm) and the C figures still print.** The bug listed "630 mm rain" as part of the sample. The author kept it because it comes from your Settings page. I agree, but the bug entry should say so.
5. **The switch works and OFF gives back exactly the old export.** It is in the settings file only, with no Settings page row. Its sister WSUD switch (impervious areas held to the site) does have a row, so this one should get one too, after #1875 lands.
6. **No clash, nothing else moves.** It does not touch CDDESIGN, the computations sheet, council checks or saved CDRULES results. It merges with #1874, #1872, #1868, #1857 and #1875 with no new conflict. The one failed test is an old, unrelated PDF-picture fault seen on many earlier runs.

---

## DETAIL

### 1. What the drafter sees, and how "not entered" is decided

1. **Command and path.** CDCALC (`Commands/CalculationsCommand.cs`, `[CommandMethod("CDCALC")]`) opens the calculations window. On the export page the tick box "WSUD / annual load reduction" (`Dialogs/CalculationsV2Dialog.xaml`, the `ExportWsud` check box) adds the WSUD section. `Services/CalculationExportPackage.cs` line 102 to 103 calls `CaptureWsud`; this is the only place the WSUD figures leave the program (no other reader of `WsudViewModel` outside the calculations window).
2. **Where 1,000 / 200 / 700 come from.** `ViewModels/WsudViewModel.cs` lines 20 to 22 start the three boxes as the text "1000", "200", "700". Rainfall and the two C figures (lines 35 to 37) start from the Settings page (`wsudTab`).
3. **The WSUD tab is read-only.** `Dialogs/CalculationsV2Dialog.xaml` line 1005 (tab "Older calculators — WSUD", tooltip "Read-only"), lines 1012 to 1015 (every text box `IsReadOnly=True`), line 1024 (banner "Read-only — an Older calculator"). BUG_CARPARK BUG-1112 itself says "The drafter cannot correct them." So the drafter cannot type a site figure on this build.
4. **Before.** The package's "Site — Pre & Post Development" table printed Total site area 1000 m2, Impervious 200 / 700 m2, and the "Annual Runoff Volumes" table printed the volumes worked from them, as if they were the job's.
5. **After (switch ON).** `CalculationExportPackage.cs` lines 508 to 515 work out `sample`; line 526 (site area), 528 (impervious pre and post) and 538 to 541 (pre, post, increase m3, increase %) print "not entered" with the unit cell left blank. Rainfall, C impervious, C pervious (lines 529 to 531), the treatment-measure table and the advisory line still print.
6. **The exact rule.** `WsudViewModel.cs` lines 39 to 68: the three site setters call `SiteFigureTyped`, which sets `_siteFiguresEntered = true` and never clears it. The setters only fire on a change: `ViewModelBase.SetProperty` returns early when the new text equals the old (`Equals(field, value)`). So the test is "has any of the three boxes' text changed from the opening text in this window session". It is a mark, not a value test, and it compares text, not numbers ("1000.0" or "1,000" would count as entered; "1000" would not).
7. **What can actually set the mark on this build.** Only `TryRestoreDraft` (`WsudViewModel.cs` lines 349 to 351), when CDCALC restores a saved calculation workspace (`CalculationsV2ViewModel.TryRestoreCalculationWorkspace`) whose WSUD figures differ from the sample. Typing cannot, because the boxes are locked.
8. **False positive.** A saved calculation that really holds exactly "1000", "200", "700" reads "not entered". The author's own REGRESSION_LOG entry says so. Risk is low: those are the untouched sample in almost every case, and the tab has been locked since UX-CALC-OLDER-01.
9. **False negative (partial entry).** Once any one box differs, all three print. A saved calculation with a real site area but the untouched 200 / 700 would print 200 / 700 as the job's. The test `SwitchOn_OnceTheDrafterTypesASite_TheFiguresPrint` (new test file, line 58 onwards) pins this behaviour (site 850, impervious still the sample). A per-box mark would close it. Low practical risk on a read-only tab; worth a note on BUG-1112.
10. **The bug's own "expected".** BUG_CARPARK line 15111: "Blank starting values, or untick and disable the export while the tab is read-only." The PR takes a third route (print "not entered"). It meets the intent (no sample printed as the job's) and is in line with R-12 Unknown stays Unknown. Rainfall 630 mm, listed in the bug's symptom, still prints; the author's reason is that it is an office Settings figure, not a job figure. Reasonable, but the bug entry should record that reading.

### 2. Switch

1. **Name and default.** `linking.wsudExportSkipsSampleSite`, `Models/UserSettings.cs` lines 739 to 746, initialiser `= true`, comment ends "Default: on." (line 743). The read in `CalculationExportPackage.cs` lines 509 to 511 falls back to ON when settings cannot be read.
2. **OFF is exactly the old export.** With OFF, `sample` is false, so `Site(v)` returns `v`, `Runoff(v)` returns `F1(v)`, the percent is `F0(...)` and every unit cell is "m²", "m³/yr" or "%" as before. I compared the diff line by line; no other line of `CaptureWsud` changed.
3. **Both start-up reads.** The new test `SwitchDefault_IsOn_BothStartUpReads` checks `new UserSettings()`, `DeserializeSettings("{}")`, `DeserializeSettingsTolerant` with an empty `linking` group, and typed false through both. Not run by me.
4. **Settings page: none.** No row in `AdvancedSettingsDialog.xaml`, `CivilSettingsView.xaml` or `SettingsValueCatalog.cs`. The author says "as for the other recent switches"; that is true of the C-78 three (`raingardenLabelWithoutNumber` has no row) but the closest sibling, `wsudAreasHeldToSite` (BUG-772), does have one: `AdvancedSettingsDialog.xaml` line 1464, `CivilSettingsView.xaml` line 438, `SettingsValueCatalog.cs` line 93 ("FixesTab"). It is a behaviour switch, not an engineering value, so the Settings-first rule is bent rather than broken. Recommend a follow-up row next to the BUG-772 one, after #1875 lands (#1875 edits the same three Settings files).

### 3. The one failed test

1. **Name.** `MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` (`Drainage.Tests/Services/MarkupFileImageLoaderTests.cs` line 242).
2. **The author's description is inaccurate.** It does not need "AutoCAD's PDF renderer". `Services/MarkupFileImageLoader.cs` (class comment, about lines 25 to 33) renders PDFs through WebView2 (the Edge browser engine) off-screen. Harmless mistake, but rule 6.1 says say so.
3. **Known before this PR.** REGRESSION_LOG on the PR tip records it failing on unrelated runs at lines 929, 973, 1144, 1734 ("a blank-render fluke under load that passes 15 of 15 when its class is run alone"), 1757, 1767, 2147, 2292 and others. CE_PLAN `areas/CODEX_BUILD_BD10_26OCT.md` line 38 has it failing "only on the untouched base"; `CODEX_BUILD_BD09_26OCT.md` line 10 has it as the single base failure. `PENDING_TESTS.md` line 1096 calls it "the known flaky one".
4. **Could it hide a regression here?** No. It tests loading a PDF into pictures for the AI markup panel. The PR touches none of that code or anything it calls. I could not re-run it (no tests allowed); the author did not re-run it alone either.

### 4. Results, fingerprints and clashes

1. **CDDESIGN, CDCALC detention, the computations sheet.** Untouched. `WsudViewModel` is used only by `CalculationsV2ViewModel` (line 388 creates it); `CaptureWsud` is reached only when the WSUD export box is ticked (`CalculationExportPackage.cs` line 102). The computations sheet (`CaptureComputationsSheet`) and detention sections are unchanged.
2. **Council sweep parity.** No council file, council profile or rule file changed.
3. **CDRULES Stale.** The criteria fingerprint is built from the office standards, the council profile and three evidence entries (`Rules/RulebookValues.cs` lines 408 to 419), not from the `linking` group. A new `linking` key cannot move it, so no saved CDRULES run goes Stale.
4. **Draft schema.** The new mark is not saved in the calculation draft (`CaptureDraft`, `WsudViewModel.cs` lines 311 to 331 unchanged), so saved drawings are unaffected.
5. **Dry-run merges (read-only `git merge-tree`, PR head against each other head):**
   - **#1874** (`1b8b4af1`): conflicts in `UserSettings.cs` (around line 3041) and `REGRESSION_LOG.md` (top).
   - **#1872** (`336bc513`): conflicts in `CouncilSweepParityTests.cs`, `KingstonStormFrequencyTests.cs`, `REGRESSION_LOG.md`.
   - **#1868** (`38c3f825`) and **#1857** (`09a6d1b8`): conflicts in `UserSettings.cs` (around line 1467) and `REGRESSION_LOG.md`.
   - **#1875** (`1a6c332b`): `REGRESSION_LOG.md` only.
6. **None of those is caused by #1877.** Merging each of the five onto the base alone (`91963bd0`) gives the same conflicts in the same files: the four other PRs are based on `claude/rel-20261026z`, not on this base. #1877's own `UserSettings.cs` block (lines 739 to 746) sits away from every conflict region and survives every dry-run merge intact. No other listed PR touches `CalculationExportPackage.cs` or `WsudViewModel.cs`. The `REGRESSION_LOG.md` clash is the usual top-of-file one: keep both entries.

### 5. Test isolation

1. **The tests themselves are isolated.** The test assembly's `SettingsIsolationSetup.cs` (a once-per-run set-up) points `SettingsService` at a fresh temporary `CD_Settings.json` and the CE log at a temporary folder. The new tests only change the in-memory switch and put it back in `TearDown`; `CaptureWsud` writes nothing to disk. I found no new test that reaches `%APPDATA%`.
2. **The author's before/after listing missed the real Civil settings folder.** The report lists `%APPDATA%\CE_SUITE` and `%APPDATA%\CE_CVL_SUITE`. `Services/SettingsService.cs` lines 46 to 56 say the Civil settings file `CD_Settings.json` lives in `%APPDATA%\TIM_CE_CADTOOLS`. That folder was not listed, so the "identical before and after" claim does not cover the file that matters (rule 5.5). Given point 1 I expect it is unchanged, but I did not check it: my brief forbids reading Tim's real settings files.
3. **Test-strength notes (not blockers).**
   - In `SwitchOn_UntouchedSite_PrintsNoSampleFigures`, `Has.None.EqualTo("1000").Or.EqualTo("200").Or.EqualTo("700")` binds "None" to the first figure only, so I believe only "1000" is checked across all cells (the 200 / 700 cells are still checked by the row asserts above it). Not run by me.
   - The edited `WsudAreasHeldToSiteTests.cs` case (line 68) now sets a site of 900 so the old check still runs. It would be truer to the original to turn the switch OFF there. Minor. The REGRESSION_LOG "Files" line omits this edited file.

### 6. Not proven, and the AutoCAD scenario

1. **Not proven:** the real package (preview, PDF or xlsx) in AutoCAD; that a restored saved calculation with real figures prints them; the switch OFF in a real settings file; net48 (2022 to 2024) at run time (compile only).
2. **The author's robot case cannot run as written.** Step "type 850 in Total site area" is impossible: the box is locked. Rewrite C32_wsud_export_sample as:
   - **Case A, new job, switch ON:** blank drawing copy, type CDCALC, export page, tick "WSUD / annual load reduction", prepare the package. Right looks like: Total site area, both Impervious cells and all four Annual Runoff lines read "not entered"; the text 1000, 200 and 700 appears nowhere in the WSUD section; Annual rainfall still reads 630 mm.
   - **Case B, saved real figures, switch ON:** a test drawing copy that already carries a saved calculation with WSUD site 850, impervious 300 / 600 (made on an older build that allowed typing, or from an existing job copy that has one). CDCALC, same steps. Right looks like: 850, 300, 600 and runoff volumes print with their units.
   - **Case C, switch-off control:** set `"wsudExportSkipsSampleSite": false` inside the `linking` group of the test profile's settings file (never Tim's), restart AutoCAD, repeat case A. Right looks like: 1000, 200, 700 and the volumes print exactly as on the build before the fix.
   - **Case D, failing build:** case A on the installed build before B-061 must show 1000 / 200 / 700 (needed for Claude-accepted, condition 2).
3. **If case B has no source drawing**, case A plus C plus D still prove the bug's own "right looks like" ("no 1000 m2 site in the package"); B then stays NOT TESTED and is said so.

### 7. Verdict

**KEEP-WITH-NOTE.** Train: the next Civil train built on `claude/rel-20261102a` (C-78's branch). Notes to carry:

1. Correct the author's report and the REGRESSION_LOG wording: the tab is read-only, so the figures print only from a restored saved calculation, not from typing.
2. Rewrite robot case C32 as in section 6.
3. Record on BUG-1112: the mark is "changed since opening" (exact 1000 / 200 / 700 reads "not entered"; one changed box releases all three); rainfall and C still print as office Settings figures.
4. Follow-up: a Settings page row beside the BUG-772 WSUD row, after #1875.
5. Re-take the settings-folder listing including `%APPDATA%\TIM_CE_CADTOOLS` on the next run that executes these tests.

BUG-1112 stays open. Nothing here is Tim-accepted, Codex-accepted or Claude-accepted.
