# BUGFIX w925 (B-203, BUG-925) report, 4 Nov 2026

## FOR TIM

1. **What you will see differently:** open a saved CDRULES warning and choose "Show saved calculation sources". The saved pipe now reads "Diameter 225 mm, Upstream IL 10.250 m, Downstream IL 10.125 m, Material UPVC". Before, it showed curly-bracket data with the drawing handle and CE's internal id. The explanation lines are plain English.
2. **Switch:** checks.savedSourceValuesInWords, on by default. Set it to false and restart AutoCAD to get the old text back exactly.
3. **My own mistakes:** my first test run failed because the AutoCAD folder name has a space and split the command (no harm; fixed and rerun). I also edited my first test so it set the switch on the live settings object, not a copy, because that is how the other tests do it.
4. **Draft #1661 (old BUG-925 draft):** already held the display code but had no switch, was never compiled and had no test run. I did not touch it. #2014 is the compiled, switch-guarded version on the current train. Both stay open for you to choose.
5. **NOT proven:** nobody has opened this in AutoCAD. The two window-picture tests from #1661 were not carried over. Only the saved-source window is changed; the CDRULES result text itself is not.
6. **Robot case to prove it:** name `N60_bug925_source_words` (suggested). Type CDRULES on a 225 mm UPVC pipe with ILs 10.250 and 10.125, open a saved warning's sources, pick the saved pipe values, read the detail text. Check it contains "Diameter 225 mm" and "Upstream IL 10.250 m" and contains no "EntityHandle" and no "{". Switch-off control: with checks.savedSourceValuesInWords false at start-up, the same steps must show "EntityHandle" and "{".

## Technical detail

1. **Fault confirmed on claude/rel-20261102a:** ViewModels/CouncilSourceViewModel.cs, ForSavedFinding, the `_inputDetails` line printed `input.UsedValueJson` raw (line 81 on the base). Not already fixed: no commit on the train touches it after 2ee08dfa.
2. **Change (PR #2014, draft, base claude/rel-20261102a, one commit):** SavedRuleInputDisplay.cs (from cx2/bug-925-source-values), CouncilSourceViewModel.cs (switch read through SettingsService.Current.Checks; missing settings reads on), UserSettings.cs (ChecksSettings.SavedSourceValuesInWords, JSON savedSourceValuesInWords, "Default: on."), Bug925SavedSourceValuesTests.cs, REGRESSION_LOG.md. CE_SHARED untouched. No write, regen or view change. No locked layer, Xref or REFEDIT code involved.
3. **Tests:** Bug925SavedSourceValuesTests, 16 pass of 16 (net10.0-windows, Release, filter FullyQualifiedName~Bug925SavedSourceValuesTests, one project). Includes switch OFF restores the old text exactly, and ON through DeserializeSettings and DeserializeSettingsTolerant (empty file and an old-style file). net48 compile of CE_CVL_SUITE.csproj: 0 errors.
4. **Not done:** I did not add the switch to the C-series new-switch-defaults fixtures (those are per-train files); the defaults are pinned in the BUG-925 test file instead. No Settings window row was added (no window change).
5. **Isolation:** TEMP, TMP and CE_LOG_DIR_OVERRIDE set under C:\CE_WORK\scratch\w925\run_024614 before the test (echoed in env.txt). Listings of %APPDATA%\TIM_CE_CADTOOLS, CE_STRUC_SUITE, CE_CVL_SUITE and CE_CADTOOLS (36,869 files, names, sizes, last-write) taken before and after: identical, 0 differences. Files: C:\CE_WORK\scratch\w925\listing_before.txt and listing_after.txt. No Manager tests run.
6. **Disk:** C: free was about 58 GB before the build.
