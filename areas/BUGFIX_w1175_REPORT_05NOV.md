# BUGFIX w1175 report, 5 November 2026 (BUG-1175)

## FOR TIM

1. **PR:** #2029, draft, B-214, on claude/rel-20261112a.
2. **In AutoCAD terms:** CDSL and CDTRENCHGRATEAUDIT were already fixed earlier (B-123, PR 1974). This PR fixes the last one: CDHELP, "Rollback and History" group, no longer shows C:\Lisp Files\SUPERSEDED. It shows the archive folder beside the installed bundle if one exists, otherwise "No superseded build archive was found on this PC."
3. **Built:** net10 test run and a net48 compile both succeeded.
4. **Tested:** 30 of 30 focused unit tests pass (the BUG-1175 wording class and the guard that lists shipped files). Nobody opened CDHELP in AutoCAD.
5. **NOT proven:** how the line looks in the real CDHELP window. No Settings switch (text only, same as B-123); say if you want one. The Computations folder default is still C:\Lisp Files\Computations but it is already a Settings value, so I left it.
6. **My own mistakes:** two shell commands hung (one waited on empty input, one directory listing was slow) and the first test run failed because the empty CE_TRANSFORM_2027.arx placeholder was missing; I created it and reran. About 15 minutes lost.
7. **Real files:** two files in your real %APPDATA% changed during my run: CE_SUITE_MANAGER.json (timestamp only, same size) and ce_struc_suite.log (grew by 280 bytes). My test run had APPDATA pointed at a scratch folder, and an AutoCAD is running on this PC, so these are almost certainly its own writes, but I cannot prove it.
8. **Robot case (switch-off control: none, no switch):** type CDHELP on a bundle with no SUPERSEDED folder beside it; the line must read "No superseded build archive was found on this PC." and never contain "Lisp Files".

---

## Technical detail

1. **Fault confirmed on base 7cc4d306:** `Modules/Drainage/Dialogs/CdHelpDialog.xaml.cs` line 41 held the fixed string `C:\Lisp Files\SUPERSEDED\CE_CVL_SUITE`. SpotLevelCommand and CdTrenchGrateAudit already use `Rules/BundleFolderWording.cs`.
2. **Change:** `BundleFolderWording.SupersededArchiveLine(bundleRoot)` (read-only Directory.Exists on `<bundle parent>\SUPERSEDED\CE_CVL_SUITE`, exceptions swallowed); CdHelpDialog line 41 calls it with `RuntimePathService.GetBundleRoot()`. Two new tests in `Bug1175BundleFolderWordingTests`. REGRESSION_LOG entry added. UserSettings.cs and CE_SHARED not touched.
3. **Command:** `dotnet test Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj -f net10.0-windows -p:SkipDevBundle=true -nr:false --disable-build-servers -m:2 --filter "FullyQualifiedName~Bug1175BundleFolderWordingTests|FullyQualifiedName~C79b2FinalizerGuardsTests"`: Passed 30, Failed 0. net48: `dotnet build Modules/Drainage/CE_CVL_SUITE.csproj -f net48` succeeded.
4. **Listings:** `C:\CE_WORK\scratch\w1175\real_before.txt` and `real_after.txt` (TIM_CE_CADTOOLS, CE_STRUC_SUITE, CE_CVL_SUITE, CE_CADTOOLS). 37,022 file lines each; only differences are the two files named above.
