ANSWER FIRST — BUG-1089

1. **Result:** DONE for this build brief. [Draft PR #1805](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1805), open against claude/rel-20261026u. Built and unit-tested; no real AutoCAD pass, install or deployment.

2. **What Tim will see:** CDCALC, Pipe Flows, 300 mm at 1 in 600 with roughness 0.013 gives 0.56 m/s and now shows "Velocity is low; check for sedimentation risk." At 375 mm and 1 in 20 it gives 3.55 m/s with no scour warning when the general Settings maximum is 6 m/s. The warning sentences are unchanged.

3. **Branch and heads:** cx5/bug-1089-pipeflows-settings-limits, final head a9fec2d844d7e8d352b7f9a9b2bb0a4197331506. Base used: origin/claude/rel-20261026u at 270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1. Installed-line branch: origin/claude/rel-20261026t at d3f9c5dfc6241815d587f335a7ae49ca603c58fa. All three were checked again after fetching; the release base had not moved. No master base or rebase was used.

4. **Full suites:** BEFORE: total 20,539; passed 20,505; skipped 32; failed 2; duration 50 min 50 s. AFTER: total 20,557; passed 20,524; skipped 32; failed 1; duration 39 min 44 s. No new failing name. The after-run's only failure was also present on the base. The old figure of 11 failures was not used.

5. **Red first:** with the product unchanged, four tests ran: 3 failed, 1 passed. Both required carpark examples failed. Commit 49c1c902 adds only the test file; the exact observed lines were:

```text
Failed PipeFlowCalc_Bug1089_ConcreteDn300At1In600_WarnsBelowSettingsMinimum
Expected: equivalent to < "Velocity is low; check for sedimentation risk." >
But was: <empty>
Failed PipeFlowCalc_Bug1089_ConcreteDn375At1In20_NoScourWarningUnderConcreteCap
Expected: <empty>
But was: < "Velocity is high; check for scour risk." >
Failed PipeFlowCalc_Bug1089_UnknownMaterialUsesGeneralMaximum
Expected: <empty>
But was: < "Velocity is high; check for scour risk." >
Passed PipeFlowCalc_Bug1089_UpvcDn150At1In100_InsideBothLimits_NoWarning
Test Run Failed. Total tests: 4; Failed: 3; Passed: 1.
```

6. **Green:** all 17 focused BUG-1089 checks passed, with none skipped or failed. Existing related Pipe Flows and Settings checks passed 170/170, with none skipped or failed. The four original examples also passed in the full after-run. Eighteen cases were added overall, including the Settings-row case.

```text
Passed PipeFlowCalc_Bug1089_ConcreteDn300At1In600_WarnsBelowSettingsMinimum
Passed PipeFlowCalc_Bug1089_ConcreteDn375At1In20_NoScourWarningUnderConcreteCap
Passed PipeFlowCalc_Bug1089_UnknownMaterialUsesGeneralMaximum
Passed PipeFlowCalc_Bug1089_UpvcDn150At1In100_InsideBothLimits_NoWarning
Test Run Successful. Total tests: 17; Passed: 17.
Settings tallest tab needs 670 px. (Dark and Light.)
```

7. **Switch and limit:** detention.pipeFlowsUseSettingsSpeedLimits ships ON. The Settings > Newer tools tick reads "[CE] Pipe Flows uses the Settings speed limits". OFF restores the older 0.5 and 3.0 m/s warnings. The tab has only a roughness number and a drawing-pipe picker, with no material choice; under the brief's explicit fallback, its maximum comes from the shared unknown-material lookup and therefore uses the general Settings maximum. It never guesses a material from roughness. No material control was added.

8. **Assumed minimum:** the stored MinimumVelocityMs still applies when MinimumVelocityConfirmed is false. No extra warning is added for that status. No speed value, material table or engineering default was changed. The roughness note (BUG-1036), calculation maths and pipe-prefill behaviour are unchanged.

9. **Exact real-AutoCAD check — low speed, NOT RUN:** the next AI tester uses an Example Job drawing copy and the carpark values: minimum 0.6 m/s, general maximum 6 m/s, concrete cap 6 m/s, concrete roughness 0.013. Leave the new Settings tick ON. Open CDCALC > Pipe Flows; enter diameter 300, roughness 0.013, Grade 1 in X = 600. Right: velocity 0.56 m/s and "Velocity is low; check for sedimentation risk." Run CDRULES on a matching drawn concrete pipe; its speed finding must flag below the 0.6 m/s minimum. Other grade findings are separate.

10. **Exact real-AutoCAD check — high speed, NOT RUN:** in the same tab enter diameter 375, roughness 0.013 and Grade 1 in X = 20. Right: velocity 3.55 m/s and no "Velocity is high; check for scour risk." warning. A matching drawn concrete pipe must have no high-speed finding in CDRULES under the 6 m/s cap.

11. **Exact real-AutoCAD check — control and switch, NOT RUN:** enter 150, roughness 0.010 and grade 100: velocity 1.12 m/s and no speed warning. Untick the new Settings row and save; on reopening Pipe Flows, the 300/600 case must again be clear and the 375/20 case must show the old scour warning. Return the tick to ON. No part of these real-AutoCAD steps was carried out by this job.

12. **What was not run / known limits:** AutoCAD was not started. The real AutoCAD window, carpark drawing-file scenario and native ARX functions were not run. Six off-screen pictures were inspected, which is separate from an AutoCAD pass. Pipe Flows has no material choice, so its general maximum applies even when a drafter types concrete roughness. The full suite still has the existing logging failure and temporary-log cleanup error described below.

---

13. **Builds:** Civil Release net48: 0 errors, 242 warnings, 6 min 49.66 s. net8.0-windows: 0 errors, 216 warnings, 7 min 42.32 s. net10.0-windows: 0 errors, 214 warnings, 6 min 43.70 s. Product source validated at 0b30d9fb96e405f5a98dc4eb0e43007fa951d6b0; the final code-branch commit records results only.

14. **Full-suite failing names:** CE_CVL_SUITE.Tests.Services.LoggingServiceThroughputTests.Diagnostic_MessagesReachTheLogFile failed on BOTH runs: "Queued diagnostic never reached the log file", expected true, got false. CE_CVL_SUITE.Tests.Services.MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully failed on the BASE only: "PDF rendering failed: The requested resource is in use. (0x800700AA)"; it passed after. The XML result files were compared by full name and the new-failure list was empty. No change was made to either area.

15. **Outer cleanup:** both full runs reported SettingsIsolationSetup could not remove its temporary CE_CVL_SUITE.log because it was still in use. This is recorded alongside the console totals, not hidden as a passing full run. The focused 17 and related 170 runs passed cleanly.

16. **Changes and switch checks:** only the warning-limit block changed in PipeFlowCalcViewModel. It reads SettingsSizingStandards.CurrentOffice().MinimumVelocityMs and MaterialVelocityLimits.GetMaxVelocityMs(null). Recalculate is an instance method that already has Settings access; no parser or extra static-parser parameter was needed. The new switch sits beside the other CDCALC switches in DetentionSettings. Both normal and tolerant startup reads default it ON for an older file and keep a typed OFF. In-memory round-trip, reset, old behaviour and preservation of all other values are checked. The existing Bj32 row and persistence patterns were read and followed; the new save-candidate check stays in memory rather than writing a Settings file.

17. **Settings window:** the row uses the existing Newer tools draft, changed mark, search, reset and save paths in AdvancedSettingsDialog and CivilSettingsView. Existing page, tick-text and theme resources were reused; no new look. The shorter column accommodates it. The tallest standard Settings page remains 670 px, below the 673 px limit. Related checks include the existing Settings window size and row inventory checks.

18. **Picture — low speed, dark:** docs/image/V3_WINDOWS/cdcalc-bug1089-dark-pipeflows-low.png

19. **Picture — low speed, light:** docs/image/V3_WINDOWS/cdcalc-bug1089-light-pipeflows-low.png

20. **Picture — clear result, dark:** docs/image/V3_WINDOWS/cdcalc-bug1089-dark-pipeflows-clear.png

21. **Picture — clear result, light:** docs/image/V3_WINDOWS/cdcalc-bug1089-light-pipeflows-clear.png

22. **Picture — Settings, dark:** docs/image/V3_WINDOWS/settings-bug1089-dark-newertools.png

23. **Picture — Settings, light:** docs/image/V3_WINDOWS/settings-bug1089-light-newertools.png

24. **Picture limits:** all six are committed, rendered at 96 dpi within a 1920 x 1080 desktop envelope, and were looked at individually. The warning, clear result and new tick are readable and unclipped in both themes. No new scrolling. Pipe Flows uses the compiled calculation window; Settings uses the existing SettingsWindowV3Tests source-window render helper, which omits code-behind and the icon. The real AutoCAD-hosted windows were not viewed.

25. **Overlap:** PR #1561 (BUG-980) and #1258 remain open and touch this file or its tests. The required log command, git log origin/claude/rel-20261026u..origin/b03/bug-980-pipeflows-second-pick -- Modules/Drainage/ViewModels/PipeFlowCalcViewModel.cs, returned no commits: that branch is already an ancestor of the fetched base. Its change at 81e64f7da2ba1690b3d7b7101622da73a7e2f369 was read; it refills only values CE filled on the previous pipe pick. This edit leaves it alone.

26. **Safety:** no protected file or CE_SHARED source was edited. The warning calculation adds no drawing write, including nothing between Undo and Redo; locked layers, Xrefs and REFEDIT protection are unaffected. No deploy, install, AutoCAD start, force-push, rebase, PR merge or PR closure. No client name, site address or secret was added. New tests use synthetic in-memory Settings and an empty test project; Tim's Settings files were not used by those checks. The carpark, desk log and queue were not edited.

27. **Safe build and test commands:** absolute project paths were used: C:\ce-cx\bd15\Modules\Drainage\CE_CVL_SUITE.csproj and C:\ce-cx\bd15\Modules\Drainage.Tests\CE_CVL_SUITE.Tests.csproj. Every build/test used -c Release -p:SkipDevBundle=true -nr:false --disable-build-servers. References on every call: -p:_AcadRef48="C:\TimOS\refs\autocad\autocad-2024-ref" -p:_AcadRefNet8="C:\TimOS\refs\autocad\autocad-2026-ref" -p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027". Tests used net10.0-windows. Later calls reused restored packages with --no-restore; the related run also used --no-build. All calls ran in the foreground.

28. **Test-host preparation:** the initial untouched-base attempt stopped before tests with MSB3030, missing CE_TRANSFORM_2027.arx; it is not counted as a suite result. An ignored zero-byte placeholder was then created only at C:\ce-cx\bd15\Modules\Shared.Transform.Native2027\bin\x64\Release\CE_TRANSFORM_2027.arx. AutoCAD 2027 was added only to the test process PATH. No native binary was installed or pushed. C: had 48,994,447,360 bytes free at setup (49.0 GB), above the 8 GB stop limit.

29. **Evidence retained outside the worktree:** C:\ce-cx\bd15-evidence\bd15-base.trx, bd15-red.trx, bd15-green.trx, bd15-related.trx and bd15-after.trx. Logs: C:\ce-cx\bd15-base.log (initial setup error), bd15-base-placeholder.log, bd15-red.log, bd15-green.log, bd15-related.log and bd15-after.log. Builds: C:\ce-cx\bd15-build-net48.log, bd15-build-net8.0-windows.log and bd15-build-net10.0-windows.log. Red/green filter: FullyQualifiedName~Bug1089. Related filter covered PipeFlowCalcViewModelTests, Bj32, SettingsWindowV3Tests, PipeFlowUnknown and CalculationPanelDraftTests. Both full runs were unfiltered.

30. **Delivery and undo:** the code branch was pushed through the normal leak-scan hook: clean, 36 terms checked. Draft PR #1805 was read back as OPEN and isDraft=true with the correct base and head. REGRESSION_LOG.md has the entry at the very top, keeping all prior entries. To compare old warning behaviour, switch the new Settings tick OFF; to undo the change, revert the BUG-1089 change. No other bug was built. The Notion Inbox search returned no CE items.

31. **Cleanup:** after this report is pushed, this session will remove only its own worktree at C:\ce-cx\bd15, as the brief requires. Removal completion will be recorded here afterwards. Evidence files above remain outside that worktree.