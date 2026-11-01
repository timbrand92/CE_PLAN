# BUGFIX q10 report: BP bored pier and the Settings diameter (BUG-536, BP part), 1 Nov 2026

## FOR TIM

1. **My own mistakes first.** (1) I ran the net48 check without PowerShell on the path, so it failed once on a post-build step (not the code); I fixed the path and it passed. (2) The batch said BP "always uses the 450 block"; I read that as a fault until I read the code. No time lost to Tim.
2. **BP already draws the pier size from Settings.** CE has only ONE pier block, `450DIABPV2`, and it holds the 300, 450 and 600 sizes as visibility states. BP sets the size from the diameter. So 600 in Settings already gives a 600 pier. There is no separate 600 block to switch to, and I did not invent one.
3. **What WAS wrong and is now fixed in the draft:** if the Settings pier diameter is not 300, 450 or 600 (for example 500), BP quietly offered 450. Now BP prints one line: the Settings value, that the block only has 300, 450 and 600, and that 450 is offered instead. The pier is still drawn. Pick a size or change the Settings value.
4. **Switch:** `FootingWidth.BoredPierBlockFollowsDiameter`, ships ON. OFF gives the old silent 450.
5. **What a drafter sees:** set Bored pier plan default diameter to 500, type BP: the new line appears above the question. With 300, 450 or 600: nothing new.
6. **What is NOT proven:** nobody has run BP in AutoCAD. Built and unit-tested only; BUG-536 is not marked fixed (and its other parts are Tim's talk-later items, #1910 and #1911). I did not check in AutoCAD that the block's 300 and 600 states display.
7. **PR:** #1986 (draft, base `claude/rel-20261026s`, title starts B-153). Merge after #1911; both edit `UserSettings.cs` and `REGRESSION_LOG.md`, keep both sides.
8. **Robot case that proves it (style N31_dp_time), name `q10_bp_settings_dia_warn`:**
   1. Before launch set `BoredPierPlan.DefaultDiameterMm` to 500 in the settings file (settings are read at AutoCAD start).
   2. Type `BP`. Check the command line contains `only has 300, 450 and 600` and `450 is offered instead`. Type `450`, `No`, pick a point, Escape: check `[BP] 450 DIA. placed.`
   3. Control (switch OFF): same, with `FootingWidth.BoredPierBlockFollowsDiameter` false: the warning line is absent and the pier still places.
   4. Control (600): diameter 600, type `BP`: no warning; Enter, pick a point: `[BP] 600 DIA. placed.` and the block reference's Visibility1 reads `600 DIA.`.
9. **Isolation:** my run did not write real files. The before and after listings differ, but a live AutoCAD session (Manager, Civil and Structural all updating) was already running when I took the "before" listing at about 22:25 and closed at 22:33:06 ("CETOOLS terminated successfully"). My scratch log folders stayed empty and my tests never load AutoCAD. Details below.

---

## TECHNICAL

1. **Fault check on `origin/claude/rel-20261026s` (204dfad2):** `Services/FoundationService.cs` `ExecuteBoredPier`: the block name was the constant `"450DIABPV2"`, but `visState = $"{diameter} DIA."` already selects the 300/450/600 state; the diameter comes from `BoredPierPlan.DefaultDiameterMm` via `BoredPierDiameterChoice.DefaultFor`. Only one pier block asset exists (`Modules/Structural/Assets/Blocks/450DIABPV2.dwg`). The silent fallback was `DefaultFor` returning 450 for an off-block value with no message. Verdict: block choice already follows the diameter; the real silent fault was the fallback.
2. **Change:** `Core/Footings/BoredPierDiameterChoice.cs` `FallbackWarning(double)` (pure); `FoundationService.ExecuteBoredPier` prints it when `FootingWidth.BoredPierBlockFollowsDiameter ?? true`; `Models/UserSettings.cs` property (default true, "Default: on."); `REGRESSION_LOG.md`; new `Structural.Tests/Core/Footings/BoredPierBlockFollowsDiameterTests.cs`. CE_SHARED untouched. No new write, regen, view or variable change.
3. **Tests:** `dotnet test Modules\Structural.Tests\CE_STRUC_SUITE.Tests.csproj -f net10.0-windows --filter "BoredPierBlockFollowsDiameterTests|BoredPierDiameterChoiceTests|S45NewSwitchDefaultsTests|S44NewSwitchDefaultsTests"` (with `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2` and the refs): Total 28, Passed 28, Failed 0. Switch default pinned through the tolerant start-up reader on both paths (normal and value-by-value; it is the only start-up read in `SettingsService.LoadRecovery.cs`), plus a switch typed OFF and a source guard that the warning is inside the switch check. I did not run the tests red against the old code.
4. **net48 compile:** `dotnet build ... CE_STRUC_SUITE.csproj -f net48 -c Release` with the 2024 refs: 0 errors, 0 warnings (after fixing PATH).
5. **Open drafts read:** #1911 (UserSettings.cs, FoundationService.LoadPath.cs) and #1910 (settings dialog); neither touches `ExecuteBoredPier` or `BoredPierDiameterChoice`. Not stacked. Other open drafts touching FoundationService.cs not read line by line.
6. **Isolation echo:** `CE_LOG_DIR_OVERRIDE=C:\CE_WORK\scratch\q10\logs TEMP=TMP=C:\CE_WORK\scratch\q10\tmp CE_STRUC_SUITE_APPDATA_ROOT=C:\CE_WORK\scratch\q10\struc` set in the script before every dotnet command. Manager tests never run.
7. **Real-folder listings before and after** (full listings: 35,094 lines before, 35,103 after; the difference is below, paths under `%APPDATA%`; `=>` after, `<=` before):

```
=> TIM_CE_CADTOOLS\CD_RecentValues.json	12220	2026-11-01 22:28:50
=> TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_CVL_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json	521	2026-11-01 22:33:06
=> TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_STRUC_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json	477	2026-11-01 22:33:06
=> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-01\usage_20261101_112714_106_7b59a7ed062940808cce4a47c19bc4e9.json	387	2026-11-01 22:27:14
=> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-01\usage_20261101_112802_164_dfcb09ff88424984ace6ad449a80ba16.json	394	2026-11-01 22:28:02
=> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-01\usage_20261101_112802_898_b5febf3e2a9848898b959fea2ab008bf.json	391	2026-11-01 22:28:02
=> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-01\usage_20261101_112802_900_83eb5f3192ed47e78f6bc6b87b3e694f.json	387	2026-11-01 22:28:02
=> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-01\usage_20261101_112950_492_33c597a1f3844915b2e9af11c38b23af.json	387	2026-11-01 22:29:50
=> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-01\usage_20261101_113123_774_56e5aa51a50d450399f96f2224352be0.json	394	2026-11-01 22:31:23
=> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-01\usage_20261101_113124_589_43d49e36380c4340bfec9d2bc528a1da.json	391	2026-11-01 22:31:24
=> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-01\usage_20261101_113124_590_e78b0119a93046d2842a89b94bf254e6.json	387	2026-11-01 22:31:24
=> TIM_CE_CADTOOLS\CE_Admin\sessions\CE_CVL_SUITE.json	232	2026-11-01 22:33:06
=> TIM_CE_CADTOOLS\CE_Admin\sessions\CE_STRUC_SUITE.json	234	2026-11-01 22:33:06
=> TIM_CE_CADTOOLS\logs\ce_struc_structured_20261101_001.log	2381444	2026-11-01 22:33:04
=> CE_STRUC_SUITE\logs\ce_struc_suite.log	4312033	2026-11-01 22:33:06
=> CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_20261101.jsonl	297715	2026-11-01 22:31:33
=> CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_snapshot.json	885	2026-11-01 22:33:06
=> CE_CVL_SUITE\logs\ce_cvl_structured_20261101.log	10262728	2026-11-01 22:33:06
=> CE_CVL_SUITE\logs\CE_CVL_SUITE.log	881526	2026-11-01 22:33:06
=> CE_CVL_SUITE\logs\native_grip_2027.log	166644	2026-11-01 22:31:18
=> CE_CVL_SUITE\telemetry\outbox.jsonl	3	2026-11-01 22:31:19
=> CE_CADTOOLS\CE_Admin\manager-menu-state.json	224	2026-11-01 22:31:35
=> CE_CADTOOLS\CE_Admin\outbox\machines\CE_SUITE_MANAGER__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json	573	2026-11-01 22:33:06
=> CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json	261	2026-11-01 22:33:06
=> CE_CADTOOLS\CE_SUITE_MANAGER\CE_SUITE_MANAGER_MENU.cuix	28808	2026-11-01 22:31:33
<= TIM_CE_CADTOOLS\CD_RecentValues.json	12220	2026-11-01 22:26:25
<= TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_CVL_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json	544	2026-11-01 22:25:48
<= TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_STRUC_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json	480	2026-11-01 22:25:46
<= TIM_CE_CADTOOLS\CE_Admin\sessions\CE_CVL_SUITE.json	233	2026-11-01 22:25:27
<= TIM_CE_CADTOOLS\CE_Admin\sessions\CE_STRUC_SUITE.json	235	2026-11-01 22:25:28
<= TIM_CE_CADTOOLS\logs\ce_struc_structured_20261101_001.log	2351808	2026-11-01 22:24:35
<= CE_STRUC_SUITE\logs\ce_struc_suite.log	4307473	2026-11-01 22:26:59
<= CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_20261101.jsonl	294613	2026-11-01 22:25:41
<= CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_snapshot.json	885	2026-11-01 22:25:46
<= CE_CVL_SUITE\logs\ce_cvl_structured_20261101.log	10184756	2026-11-01 22:27:06
<= CE_CVL_SUITE\logs\CE_CVL_SUITE.log	814894	2026-11-01 22:25:50
<= CE_CVL_SUITE\logs\native_grip_2027.log	166428	2026-11-01 22:25:27
<= CE_CVL_SUITE\telemetry\outbox.jsonl	3	2026-11-01 22:25:28
<= CE_CADTOOLS\CE_Admin\manager-menu-state.json	224	2026-11-01 22:25:43
<= CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json	228	2026-11-01 22:26:28
<= CE_CADTOOLS\CE_SUITE_MANAGER\CE_SUITE_MANAGER_MENU.cuix	28808	2026-11-01 22:25:41
```

   Reading: every changed file is a log, session, usage-outbox or recent-values file written by a real AutoCAD session with the CE plugins loaded (Civil and Manager files included, which no Structural unit test touches). It started before my first test and ended at 22:33:06. My run could not have written them, and my scratch log folders held no files afterwards. I am stating it because the rule says to; I have not proven it beyond this.
8. **Cleanup:** worktree `C:CE_WORKbuildq10` and scratch `C:CE_WORKscratchq10` removed (`git clean -fdXq`, `git worktree remove`). C: free was about 44 GB at the start and is 44,729 MB now; I lost the exact before-cleanup figure (the tool output file sat inside the scratch folder I deleted), so I cannot state how much the cleanup freed.
