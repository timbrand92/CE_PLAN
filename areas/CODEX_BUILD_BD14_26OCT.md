1. **ANSWER FIRST — BUG-1181: DONE, built and unit-tested only.** Draft PR [#1799](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1799), against `claude/rel-20261025r`. Nothing installed or checked in AutoCAD. Report: 26 October 2026, Melbourne time.

2. **Heads.** Branch `cx4/bug-1181-manager-off-next-start`, head `e1172154bde5ca5730c856acc6127ff10e91b890`. Base head used after the first fetch: `d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`. Delivery fetch: the same base head. The base commit names Civil 3.0.78 / Manager 1.1.78, rather than the 3.0.72 / 1.1.72 description in the brief. The release merge said Already up to date. No master base or rebase.

3. **Proof and totals.** Eight new behaviour cases ran with product code unchanged: 4 passed, 4 failed. Red health line: `Failed CePluginDescriptor_Bug1181_LoadedButSwitchedOffAtStart_HealthSummaryIsNotHealthy`; expected `Running now, off next start`, but was `Healthy`. Red one-glance line: `Failed CeOneGlanceStatus_Bug1181_LoadedButSwitchedOffAtStart_IsAmberNotUpToDate`; expected the new headline, but was `Up to date`; expected Amber, but was Green. Final filtered run: all 22 BUG-1181 cases passed. Full Manager before: **1,013 total, 1,012 passed, 1 skipped, 0 failed**. After: **1,035 total, 1,034 passed, 1 skipped, 0 failed**. No base case disappeared; exactly 22 were added. Failure names before and after: none. Same skipped name both times: `PaletteTile_UsesTheSameCancelFirstPathAsRibbon`.

4. **What Tim will see.** CEMANAGER, Module page, select Civil, click Disable on Restart: the next-step line says, “It is running in this AutoCAD, but it will not start next time. Click Enable on Restart if it should.” The health summary says “Running now, off next start”; the one-glance description uses that headline in amber and offers the existing “Switch on at next start” action when available. The explanation remains after refresh or reopening. An update waiting to install keeps its own line first. The existing left-hand Loaded label, buttons and layout are unchanged.

5. **Exact real-AutoCAD check still required.** Use a COPY/test setup or a spare test login so Tim's real manifest is not left switched off. Run CEMANAGER, open Module, select Civil, click Disable on Restart, wait for refresh, close Manager, then run CEMANAGER again and select Civil. Right looks like: the line still says it is running in this AutoCAD but will not start next time. Check the health/one-glance warning where shown. Click Enable on Restart afterwards and verify the start-up flag is back on. Repeat on AutoCAD 2024 and 2027. This check was not run here.

6. **What was not run.** AutoCAD, the Manager window on screen, an installer, a deployment or any live manifest change. No AutoCAD acceptance claimed. No Civil build or Civil test suite was run for this Manager-only job.

---

7. **Six named checks, red then green.** Added to the two files named in the brief. Red is the unchanged-product run; the control cases correctly passed that run.

   `CePluginDescriptor_Bug1181_LoadedButSwitchedOffAtStart_HealthSummaryIsNotHealthy`

   Red: `Failed CePluginDescriptor_Bug1181_LoadedButSwitchedOffAtStart_HealthSummaryIsNotHealthy` — `Expected: "Running now, off next start"; But was: "Healthy"`.

   Green: `Passed CePluginDescriptor_Bug1181_LoadedButSwitchedOffAtStart_HealthSummaryIsNotHealthy`.

   `CePluginDescriptor_Bug1181_LoadedButSwitchedOffAtStart_NextActionSaysItWillNotStartNextTime`

   Red: `Failed CePluginDescriptor_Bug1181_LoadedButSwitchedOffAtStart_NextActionSaysItWillNotStartNextTime` — the old line was `Use Open Hub, Open Help or View Commands.`

   Green: `Passed CePluginDescriptor_Bug1181_LoadedButSwitchedOffAtStart_NextActionSaysItWillNotStartNextTime`.

   `CeOneGlanceStatus_Bug1181_LoadedButSwitchedOffAtStart_IsAmberNotUpToDate`

   Red: `Failed CeOneGlanceStatus_Bug1181_LoadedButSwitchedOffAtStart_IsAmberNotUpToDate` — `But was: "Up to date"`, Green, no SwitchOnAtNextStart action.

   Green: `Passed CeOneGlanceStatus_Bug1181_LoadedButSwitchedOffAtStart_IsAmberNotUpToDate` — also checks the action and exact label.

   `CePluginDescriptor_Bug1181_LoadedAndSwitchedOn_StillHealthy`

   Red control: `Passed CePluginDescriptor_Bug1181_LoadedAndSwitchedOn_StillHealthy`.

   Green: `Passed CePluginDescriptor_Bug1181_LoadedAndSwitchedOn_StillHealthy`.

   `CePluginDescriptor_Bug1181_TwoDescriptorsFromTheSameManifestFlags_GiveTheSameText`

   Red: `Failed CePluginDescriptor_Bug1181_TwoDescriptorsFromTheSameManifestFlags_GiveTheSameText` — first object said Restart needed; the new object said Healthy. Same loaded/start-up flags, but only the first has the pending restart flag.

   Green: `Passed CePluginDescriptor_Bug1181_TwoDescriptorsFromTheSameManifestFlags_GiveTheSameText`.

   `CePluginDescriptor_Bug1181_SwitchSetToOldBehaviour_KeepsTheOldHealthyWording`

   Red control: `Passed CePluginDescriptor_Bug1181_SwitchSetToOldBehaviour_KeepsTheOldHealthyWording`.

   Green: `Passed CePluginDescriptor_Bug1181_SwitchSetToOldBehaviour_KeepsTheOldHealthyWording` — also checks the old green Up to date description.

8. **Other checks.** Two update-priority cases passed red and green. Added 12 strict-switch/source-guard cases and 2 STA render cases; all pass. The existing one-glance helper defaults to start-up ON for its healthy controls. No existing test was removed. Red-only test commit: `b26648e1fa18d9d96880c9cbf40530f6ac2198cd`; product files were unchanged at that commit.

9. **Builds and safe commands.** Manager Release net48, net8.0-windows and net10.0-windows each built with **0 warnings and 0 errors**. Every build/test used `-p:SkipDevBundle=true -nr:false --disable-build-servers` and all three supplied reference parameters. Absolute project paths throughout. No ARX placeholder or PATH adjustment needed. C: had 46.88 GB free at setup.

   Build: `dotnet build C:\ce-cx\bd14\Modules\Manager\CE_SUITE_MANAGER.csproj -f <target> -c Release`, with the safe flags and references.

   Tests: `dotnet test C:\ce-cx\bd14\Modules\Manager.Tests\CE_SUITE_MANAGER.Tests.csproj -f net10.0-windows -c Release`, with the safe flags and references. Red/green also used `--filter "FullyQualifiedName~Bug1181"`.

   References: `-p:_AcadRef48="C:\TimOS\refs\autocad\autocad-2024-ref" -p:_AcadRefNet8="C:\TimOS\refs\autocad\autocad-2026-ref" -p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"`.

10. **One shared input and switch.** `RunningButOffNextStart` uses the loaded state and start-up flag already read from the manifest; all three descriptions use it. It does not depend on the pending restart flag. Inverse key `legacyStatusWhenSwitchedOffAtStart`: missing/OFF activates the new wording; plain true restores the older wording. Parsed and checked with the existing strict reader alongside sibling keys, captured once per descriptor for the three descriptions. Tests use `ManagerTestSwitchSandbox` / `CeManagerSwitches.TestPathOverride`; Tim's real switch file was never read or changed. Disabled, Healthy, Not loaded and Missing files retain their words.

11. **Pictures and limits.** Committed `docs/image/V3_WINDOWS/manager-bug1181-light-module.png` and `docs/image/V3_WINDOWS/manager-bug1181-dark-module.png`. Both final images opened and inspected: the explanation fits without scrolling, clipping or overlap. The STA test renders the real Module XAML and Manager theme resources, header and footer at 1040 × 740, 96 dpi (1080p scale 1). AutoCAD host actions are disconnected; no live Manager window is created. These pictures do not establish AutoCAD acceptance. No new visual design or layout.

12. **Safety, ownership and undo.** BUG-1181 only. Product changes confined to `CePluginDescriptor.cs` and `CeOneGlanceStatus.cs`. No CE_SHARED source, protected file, Structural source, installer, signing or staged-update file changed. No drawing write, including between U and REDO; locked layers, Xrefs and REFEDIT protection unaffected. No ApplicationPlugins/ProgramData writes or real manifest/settings changes. Main-checkout loose files and other CE_PLAN work left alone. Undo: revert the two BUG-1181 commits. REGRESSION_LOG.md has the entry at the top, retaining every earlier entry.

13. **Evidence saved.** Raw local evidence under `C:\ce-cx\bd14-evidence`: before.log/trx, red.log/trx, green.log/trx, after.log/trx, and the three build-target logs. The code branch and this report are pushed separately, staging by name only, with the leak-scan hook enabled. The PR stays draft, open and unmerged. No other bug taken on or parked.
