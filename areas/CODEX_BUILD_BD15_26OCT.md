ANSWER FIRST — BUG-1089

1. **State:** In progress. No PR yet. Working branch cx5/bug-1089-pipeflows-settings-limits; no product edits yet.
2. **Heads:** Fetched base origin/claude/rel-20261026u = 270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1. Installed-line branch origin/claude/rel-20261026t = d3f9c5dfc6241815d587f335a7ae49ca603c58fa. C: free at setup: 48,994,447,360 bytes (49.0 GB).
3. **Before tests:** Full untouched-base Civil net10 Release suite is running. Initial attempt ran no tests: MSB3030, missing CE_TRANSFORM_2027.arx. Added an ignored zero-byte placeholder only at C:\ce-cx\bd15\Modules\Shared.Transform.Native2027\bin\x64\Release\CE_TRANSFORM_2027.arx and reran. AutoCAD 2027 is on the test process PATH. Totals and failure names pending.
4. **Limits:** The Pipe Flows tab has a roughness number and drawing-pipe picker, no material choice. Under the brief's explicit fallback it will read the shared unknown-material lookup, which uses the general maximum in Settings. Roughness is not treated as a material. The stored minimum will apply even when MinimumVelocityConfirmed is false; no new warning for that.
5. **Overlap:** PR #1561 (BUG-980) and #1258 remain open and touch this file or its tests. The required git log range for BUG-980 is empty: its branch is already an ancestor of the fetched base. Read its change, 81e64f7da2ba1690b3d7b7101622da73a7e2f369: it refills only values CE filled on the previous pick. Warning-limit edits will leave that alone.
6. **Not run:** AutoCAD, the real window in AutoCAD and a drawing-file check. No install or deployment. No protected files or CE_SHARED edits needed. Warning calculations write nothing to the drawing, so Undo/Redo, locked layers, Xrefs and REFEDIT are unaffected.
7. **Evidence:** C:\ce-cx\bd15-base.log (setup failure); C:\ce-cx\bd15-base-placeholder.log and C:\ce-cx\bd15-evidence\bd15-base.trx (run in progress). The Notion Inbox search returned no CE items. Working on the existing BUG-1089 carpark entry only; the carpark, desk log and queue remain untouched.
8. **Progress, 26 October 2026 evening (Melbourne):** the untouched-base rerun reached the test host at about 20:11 and is still running. Two failing short names observed so far: Diagnostic_MessagesReachTheLogFile and LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully. Final totals, full names and messages are pending. The installed DLL was read directly: 3.0.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa. No product or test source has been edited. Four red-first checks, the switch coverage and six off-screen picture checks are prepared in memory, to be written only after the before-run closes.
9. **Untouched-base completed:** total 20,539; passed 20,505; skipped 32; failed 2; duration 50 min 50 s. Failing names: CE_CVL_SUITE.Tests.Services.LoggingServiceThroughputTests.Diagnostic_MessagesReachTheLogFile (queued diagnostic never reached the log file; expected true, got false) and CE_CVL_SUITE.Tests.Services.MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully (PDF rendering failed: The requested resource is in use, 0x800700AA). The outer SettingsIsolationSetup cleanup also reported its temporary CE_CVL_SUITE.log was in use. No source was edited during the run. Evidence: C:\ce-cx\bd15-evidence\bd15-base.trx and C:\ce-cx\bd15-base-placeholder.log. Four BUG-1089 tests have now been written, with the product code unchanged; their red-first run is in progress.
10. **Red first proved, product unchanged:** commit 49c1c902 contains the four tests only. The command filtered FullyQualifiedName~Bug1089. The failing lines were:

```text
Failed PipeFlowCalc_Bug1089_ConcreteDn300At1In600_WarnsBelowSettingsMinimum
Expected: equivalent to < "Velocity is low; check for sedimentation risk." >
But was: <empty>
Failed PipeFlowCalc_Bug1089_ConcreteDn375At1In20_NoScourWarningUnderConcreteCap
Expected: <empty>
But was: < "Velocity is high; check for scour risk." >
Failed PipeFlowCalc_Bug1089_UnknownMaterialUsesGeneralMaximum
Passed PipeFlowCalc_Bug1089_UpvcDn150At1In100_InsideBothLimits_NoWarning
Test Run Failed. Total tests: 4; Failed: 3; Passed: 1.
```

11. **Change written:** only the warning-limit block in PipeFlowCalcViewModel changed. The shared MaterialVelocityLimits.GetMaxVelocityMs(null) lookup supplies the general maximum because there is no material choice. The minimum is read directly from SettingsSizingStandards.CurrentOffice().MinimumVelocityMs. No parser was changed: Recalculate already has access to Settings, so no extra static-parser parameter is needed. The new default-on switch is detention.pipeFlowsUseSettingsSpeedLimits. Its Settings row uses the existing Newer tools draft, search and save behaviour, in the shorter column. The old high-speed test now uses a grade steep enough to exceed the general maximum. Off-screen pictures, green run, all three builds and after-suite are pending.
12. **Green focused run:** 17 tests ran and all 17 passed, none skipped or failed. The four original lines now read:

```text
Passed PipeFlowCalc_Bug1089_ConcreteDn300At1In600_WarnsBelowSettingsMinimum
Passed PipeFlowCalc_Bug1089_ConcreteDn375At1In20_NoScourWarningUnderConcreteCap
Passed PipeFlowCalc_Bug1089_UnknownMaterialUsesGeneralMaximum
Passed PipeFlowCalc_Bug1089_UpvcDn150At1In100_InsideBothLimits_NoWarning
Test Run Successful. Total tests: 17; Passed: 17.
Settings tallest tab needs 670 px. (Dark and Light, under the 673 px limit.)
```

13. **Pictures seen:** six 96 dpi off-screen PNGs, within a 1920 x 1080 desktop envelope. The Pipe Flows test constructs the compiled calculation window; Settings uses the existing SettingsWindowV3Tests source-window render helper. The warning, clear result and new tick are readable and unclipped in both themes; no new scrolling. Paths under docs/image/V3_WINDOWS: cdcalc-bug1089-dark-pipeflows-low.png; cdcalc-bug1089-light-pipeflows-low.png; cdcalc-bug1089-dark-pipeflows-clear.png; cdcalc-bug1089-light-pipeflows-clear.png; settings-bug1089-dark-newertools.png; settings-bug1089-light-newertools.png. The existing roughness note and the calculation pane layout were left alone. Evidence: C:\ce-cx\bd15-green.log and C:\ce-cx\bd15-evidence\bd15-green.trx. Existing related Pipe Flows, Settings rows, persistence and full Settings window checks are now running; three-lane builds and the after-suite remain pending.
14. **Related checks:** 170 tests ran; all 170 passed, none skipped or failed. This includes the existing Pipe Flows tests, Bj32 Settings row and persistence checks, Settings window checks, unknown-result display and calculation-draft checks. Evidence: C:\ce-cx\bd15-related.log and C:\ce-cx\bd15-evidence\bd15-related.trx. Change and six pictures saved in code commit 0b30d9fb (after the red-only commit). Civil Release net48, net8.0-windows and net10.0-windows builds are now running in that order, with every required safe flag and reference parameter. To undo the saved behaviour, untick the new Pipe Flows Settings switch, or revert the BUG-1089 change.
