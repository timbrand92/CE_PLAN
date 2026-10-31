# BUGFIX n2 report, Manager colleague pack and start-up lines (B-116), Sat 31 Oct 2026

## FOR TIM

1. **Two draft PRs are open, both Manager only, both with a Settings-style switch that ships ON.**
   1. **#1935 (BUG-1172):** on AutoCAD 2025 or 2026 the Manager start-up line and the status-bar box now say `[Net8]`. AutoCAD 2027 still says `[Modern]`, 2022 to 2024 still says `[Legacy]`. Test: start AutoCAD 2026 and read the line "CE_SUITE_MANAGER v... [Net8] loaded". The same fault exists in Civil's own start-up line; that is a Civil build, not in this batch.
   2. **#1936 (BUG-1244):** CE Tools > Refresh now prints a second line, for example "Refreshed: the CE ribbon was rebuilt; the Manager window is not open, so nothing to update there; no reports were waiting to send." Test: click Refresh and read the command line.
2. **BUG-1173 (backup step): no PR, and nothing for me to build.** Page 02 of the colleague pack already lists all five settings folders and tells the colleague to unload the CE Manager menu (type `MENULOAD`, unload `CE_SUITE_MANAGER_MENU`). The draft #1876 (job p1) did not cover it either; job p1 reached the same answer on 30 Oct. Two small wording lines are still not in page 02 (they need the pack owner, because page 02 is under the approval sheet):
   1. After step 4 add: "Also copy `%APPDATA%\CE_SUITE` if it exists (an optional hand-written Manager switch file)."
   2. Add: "If a folder with `_PRE_V3` on the end already exists, stop and tell the desk. Never copy over it." (Security: a local copy of an old administrator folder may hold a write key; it must never be zipped or emailed. The support zip cannot reach that folder, per CE 05's evidence note 2.)
3. **BUG-1261 (support zip upload): skipped, the fault is not in the code.** CESUPPORT only saves a zip on this PC. The Manager's upload of reports deletes any support-zip it finds in the outbox and never sends it (`CeAdminStorageService.cs` lines 433 to 436, 518 and 644). There is no upload of the zip to the office folder to protect. The by-name skip for the zip itself is already draft #1878 (B-063). The only leftover is an old comment on the command ("for upload to the IT Admin support folder", `PluginManagerCommands.cs` near line 285) that is out of date. Nothing for Tim to decide.
4. **Nothing was tested in AutoCAD.** Built and unit-tested only. AutoCAD was open on this PC (Tim's own session) for the whole run; I did not start it.

## What I did

1. Worktree `C:\CE_WORK\build\n2` from `origin/claude/rel-20261102a` (Civil 3.0.88 / Manager 1.1.88), now removed. Scratch folder `C:\CE_WORK\scratch\n2` removed. Build number B-116 (from the coordinator) on both PR titles.
2. **BUG-1172, PR #1935, branch `claude/n2-b116-bug1172-net8-lane-label`.** New `Modules/Manager/Services/CeManagerLaneLabel.cs`; two display lines in `Modules/Manager/Plugin.cs` (loaded line and status pane). `Plugin.BuildType` (sent in support records) is untouched. Manager switch `laneLabelNamesNet8`, Default: on.; OFF gives the old names exactly. Tests `Bug1172LaneLabelTests`: 12 of 12 pass (not zero). Manager net48 and net8.0-windows compile: 0 errors.
3. **BUG-1244, PR #1936, branch `claude/n2-b116-bug1244-refresh-line`.** New `CeManagerRefreshSummary.cs`; `CEMANAGERREFRESH` in `PluginManagerCommands.cs` prints the line. What Refresh does is unchanged. Switch `refreshPrintsResultLine`, Default: on.; OFF is silent as before. Tests `Bug1244RefreshLineTests`: 12 of 12 pass. Manager net48 compile: 0 errors.
4. **Mistake of my own:** I ran an empty bare `python3` heredoc by accident that hung for 2 minutes until I stopped it. It touched nothing.

## Shared files and clashes

1. **Shared files touched:** `REGRESSION_LOG.md` (new top entry on each PR, will clash with other PRs: keep both sides). `PluginManagerCommands.cs` (#1936) is also in open draft #1876 (different lines, expected to merge cleanly). **Not touched:** CE_SHARED, `UserSettings.cs`, `CeOneGlanceStatus.cs` (new switches live in new files so #1876, #1860 and #1878 do not clash). I used the Manager switch file mechanism, so no Settings-engine or loader change; the coordinator's "area plus N91" note does not apply.
2. **Open Manager drafts seen:** #1876 (B-058: PluginManagerCommands.cs, CeOneGlanceStatus.cs), #1878 (B-063: CeSupportBundleService.cs), #1860 (B-050, base `claude/rel-20261029a`: CeAdminStorageService.cs, CeOneGlanceStatus.cs). Neither of my PRs stacks on them.
3. **Not added:** a pin of the two new switches in `C76ManagerSwitchDefaultsTests` (that file is the one other drafts extend); each switch has its own default-ON test through the text reader and a missing file instead.

## Robot cases proposed (with switch-off control)

1. **N116_net8_label:** on AutoCAD 2026, run `NETLOAD`-free start-up and read the "[CE_SUITE_MANAGER] v... [..] loaded." line; expect `[Net8]`. Control: set `"laneLabelNamesNet8": false` in `%APPDATA%\CE_SUITE\manager-switches.json` on a test login, expect `[Modern]`.
2. **N116_refresh_line:** type `CEMANAGERREFRESH`, read the command line for a line starting `[CEMANAGER] Refreshed:`. Control: `"refreshPrintsResultLine": false`, expect no such line.

## Real-folder comparison (names, sizes, last-write only)

Listed with a script before the first test (18:05) and after the last build (18:15) over `%APPDATA%\TIM_CE_CADTOOLS`, `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS` and `CE_SUITE`.

1. **Before:** TIM_CE_CADTOOLS 29,634 files 1,140,972,214 bytes; CE_STRUC_SUITE 2,500 files 2,100,155,999 bytes; CE_CADTOOLS 1,022 files 110,300,293 bytes; CE_CVL_SUITE 306 files 82,468,221 bytes; CE_SUITE 1 file 0 bytes.
2. **After:** same except TIM_CE_CADTOOLS 29,639 files 1,140,974,152 bytes and CE_CVL_SUITE 82,490,294 bytes.
3. **Changed (11 lines):** five new `CE_Admin\outbox\usage\2026-10-31\usage_*.json` files (about 388 bytes each, 18:07 to 18:14, one every 2 minutes), `CD_RecentValues.json` and `logs\ce_cvl_structured_20261031.log` (18:14), and `CE_Admin\sessions\CE_SUITE_MANAGER.json` (18:15). These are written by Tim's own running AutoCAD (acad.exe was open, the cadence is steady); my test runs used the redirected scratch folders and my tests are pure (no file writes). No settings file (names containing settings) changed. The full listings were in the scratch folder, now removed; the diff above is complete.

## Not tested

1. Nothing in real AutoCAD (no start-up line read on 2025/2026, no Refresh clicked).
2. The Manager full suite was not run (rule: focused only). Only the two new classes ran (24 of 24).
3. The Net8 label was proven by the pure rule and a net8.0-windows compile, not by running a Net8 build.

## Space and time

C: free was 42.95 GB at the start and 42.97 GB after cleanup (net change about 0; other jobs were also writing). Finished Sat 31 Oct 2026, 18:17 Melbourne.
