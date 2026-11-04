# BUGFIX ff1982b report: fix-first on draft PR #1982 (B-181), 4 Nov 2026

## FOR TIM

1. **Fixed:** the X-Civil import now has its own level range in Settings, 0 to 250 m, exactly as you said in decision 192. At the shipped values nothing changes on a drawing: a "0.00" no-level placeholder is still dropped, and a level over 250 m is still dropped. Before this fix, #1982 would have let those in.
2. **What you will see differently:** nothing, until someone raises the range. To bring a 300 m hills job in, set `xcivilImport.levelMaxM` to 400 in the Settings file before AutoCAD starts.
3. **Switch:** the same one the PR already had, `xcivilImport.levelRangeFollowsSettings`, still ships ON. OFF gives the old fixed range (above 0, up to 250 m) whatever the two new values say.
4. **No new PR.** One extra normal commit, 26aa33a8, pushed to the #1982 branch (`claude/q7-xcivil-range-on`). Base is still `claude/rel-20261102a`.
5. **Mistakes of my own:** my first test edit used the wrong line endings and changed nothing; I caught it in the diff and redid it. Cost: about two minutes.
6. **NOT proven:** nobody has opened this in AutoCAD. The two new values have no row on the Settings page (a window change, Codex-owned), so they are edited in the Settings file for now. The N91 start-up check from the PR still applies.
7. **Robot case:** `N91_xcivil_level_range` (new name, needs writing by the case owner). It types CDIMPORTXCIVIL on a copy with two level texts, "0.00" and "300.00", and checks the imported pit list: neither level is read at the shipped values. Control: set `levelMaxM` 400 before launch, and the 300.00 reads as 300.000; set `levelRangeFollowsSettings` false with `levelMaxM` 400, and 300.00 is dropped again.
8. **One thing to look at:** two real files in my before and after listings changed, a Structural log and the Manager session file. Their times (16:51 to 16:57) match a running AutoCAD updating itself every six minutes. My run was Civil tests only, with log folders redirected to scratch. I think they are not mine, but I cannot prove it.

---

## Technical detail

1. **Fault confirmed on base:** `XcivilLayerRecognition.IsReasonableImportedLevel` (line 92 at b6dd9dbb) read `Markup.LevelMinM/LevelMaxM` (-50 to 1000) when the switch was ON, and the switch shipped ON. So 0 and below, and 250 to 1000, came in.
2. **Change:** `Models/UserSettings.cs` (XcivilImportSettings): new `LevelMinM` = 0.0 (`levelMinM`) and `LevelMaxM` = 250.0 (`levelMaxM`), documented. `Services/XcivilLayerRecognition.cs`: ON reads those; test is `value > lo && value <= hi` (same shape as the fixed range); an empty or reversed pair falls back to the fixed constants. Warn-not-block unchanged. CE_SHARED untouched. No new write, command, regen or view.
3. **Missing-group reading:** a missing group builds a default XcivilImportSettings, so the ON switch and the 0 to 250 range both read their shipped values. I did not change the `== true` read at the call site; it is on a non-null Settings object after start-up.
4. **Tests changed:** `Bug908LevelRangeDefaultOnTests` (own range ships 0 and 250 through both start-up reads, a file with only `levelMaxM` keeps min 0, shipped default drops 300, -1 and 0, raised own range followed, empty range falls back, the Markup range no longer moves the import, switch OFF pinned); `Bug544XcivilImportSettingsTests` (the two ON tests now set their own wider range and the fixture restores it).
5. **Run:** `dotnet test Modules\Drainage.Tests\CE_CVL_SUITE.Tests.csproj -f net10.0-windows -c Release --filter "FullyQualifiedName~Bug908|...Bug544XcivilImport|...XcivilLayerRecognition|...C61NewSwitch|...Bug351bPlanMarker" -p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`. Result: **144 total, 144 passed, 0 failed.** AutoCAD 2027 on PATH, TEMP, TMP and CE_LOG_DIR_OVERRIDE set to `C:\CE_WORK\scratch\ff1982b`. Count of other dotnet jobs was 0 before the run. Not run: the full suite, net48 tests.
6. **net48 compile:** `dotnet build Modules\Drainage\CE_CVL_SUITE.csproj -f net48 -c Release -p:_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs ...`: 0 errors, 246 warnings.
7. **REGRESSION_LOG.md:** one entry added (B-181 BUG-908). Bug stays OPEN.
8. **Real-file listings (rule 1):** before and after listings of `%APPDATA%\TIM_CE_CADTOOLS`, `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS` are at `C:\CE_WORK\scratch\ff1982b\before.txt` and `after.txt` (36,994 lines each). Difference is exactly two files: `CE_STRUC_SUITE\logs\ce_struc_suite.log` (5,031,495 to 5,032,519 bytes, 16:51:44 to 16:57:44) and `CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json` (228 bytes, 16:51:27 to 16:57:27). I did not stop for this because I judge them to be a live AutoCAD, and I say so here as the rule asks.
9. **Cleanup:** worktree `C:\CE_WORK\build\ff1982b` cleaned (`git clean -fdXq`) and removed after the push; scratch folder kept only for the two listings (before.txt, after.txt); say if you want it removed.
