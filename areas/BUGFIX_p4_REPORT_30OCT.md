# BUG-1112 fix report (key p4, 30 Oct 2026)

## FOR TIM

1. **Draft PR #1877, build number B-061, head b9842f28.** Built and unit-tested only. Nobody has opened it in AutoCAD. BUG-1112 is NOT marked fixed.
2. **What you will see differently:** in CDCALC, tick "WSUD / annual load reduction" and prepare the package. Before, it printed a 1000 m2 site with 200 and 700 m2 impervious and the runoff worked from them, though nobody typed those. Now those lines say "not entered" until you type a site area or an impervious area. Once you type any one, everything prints as normal.
3. **Settings switch:** linking.wsudExportSkipsSampleSite, ON by default. OFF brings the old sample figures back.
4. **My mistakes first:** (a) my first test build failed because a placeholder file for the native transform was missing, so one test run was wasted (no harm, nothing ran); (b) an existing test relied on the untouched sample printing, so I changed it to type a site first; (c) I did not set the scratch test folders until the coordinator's message arrived, but no test code had run before that (only a failed build), so no test ran without them.
5. **Not proven:** the real package in AutoCAD. If you type exactly 1000, 200 and 700 (the sample), it still reads as not entered. The on-screen tab still opens with the sample figures (I only changed the export, which is what the bug describes).

## Robot case that would prove it

1. **Name:** C32_wsud_export_sample (style C31).
2. **Steps:** open a blank drawing, type CDCALC, tick the WSUD export box, prepare the package, read the Site table and the Annual Runoff table in the preview or xlsx.
3. **Check:** with the switch ON, "Total site area", "Impervious area" and all four runoff lines read "not entered" and the text 1000, 200, 700 appears nowhere. Then type 850 in Total site area, prepare again, and the site figure reads 850.
4. **Switch-off control:** set linking.wsudExportSkipsSampleSite to false in the settings file, restart, repeat the first steps: the table reads 1000, 200, 700 as before.

## Technical detail

1. **Cause:** Modules/Drainage/ViewModels/WsudViewModel.cs opens with strings "1000", "200", "700" (lines 20 to 22); Services/CalculationExportPackage.cs CaptureWsud (about line 503) wrote them straight into the package.
2. **Fix:** WsudViewModel gains SiteFiguresEntered (true once any of the three site boxes changes from the sample, also via a restored draft). CaptureWsud prints "not entered" for site area, impervious areas and the four runoff-volume lines when the switch is ON and nothing was entered. Rainfall and C values come from Settings and still print. No drawing write.
3. **Files:** Models/UserSettings.cs, ViewModels/WsudViewModel.cs, Services/CalculationExportPackage.cs, REGRESSION_LOG.md, new Drainage.Tests/ViewModels/Bug1112WsudExportSampleSiteTests.cs (4 tests: default ON through DeserializeSettings and DeserializeSettingsTolerant, ON untouched, ON typed, OFF), edited WsudAreasHeldToSiteTests.cs (one case now types a site). CE_SHARED unchanged. No Settings page row (as for the other recent switches).
4. **Builds and tests:** Civil net10 focused 137 tests, then full suite 21,569 total, 21,536 passed, 32 skipped, 1 failed: LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully (needs AutoCAD's PDF renderer; not re-run alone because AutoCAD is not to be started). Drainage net48 Release compile: 0 errors. Test isolation set before every test run: CE_LOG_DIR_OVERRIDE, CE_STRUC_SUITE_APPDATA_ROOT, TEMP, TMP under C:\ce-scratch\p4-f1, p4-f2, p4-f3. Structural and Manager tests not run.
5. **Settings file listings (name, time, size; no contents).** BEFORE and AFTER the last test run were identical.
   - %APPDATA%\CE_SUITE: folder not present, before and after.
   - %APPDATA%\CE_CVL_SUITE: settings.json 2026-09-16 12:13:17, 672 bytes; settings.PRE_WORKSHOP_20260916.json.bak 2026-09-16 11:55:58, 672; feedback_20260511_165609.json 297; feedback_20260512_094651.json 327; spine-rollback files 2026-09-04 and 2026-09-14 (13979, 30852, 916, 1489, 1777 bytes). No change.
6. **Not touched:** BUG_CARPARK.md, no PR closed, no branch deleted, no AutoCAD started.
