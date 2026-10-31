# B-093 report: Grade mismatch becomes a warning line (w1, Sat 31 Oct 2026)

## ANSWER FIRST

**FOR TIM**

1. **PR:** #1919, DRAFT, titled B-093, against `claude/rel-20261102a` (Civil 3.0.88). Nothing is installed. It is built and unit-tested only; nobody has opened it in AutoCAD.
2. **What you will see:** type your own two levels in New Pipe (Custom grade). If they are more than 10 percent off the grade you chose, CE no longer opens the Grade mismatch window. It writes one line, for example "Levels typed give 1 in 200, flatter than the 1 in 100 grade chosen. Your levels are used.", shows the same line in the New Pipe window's warning box, and draws the pipe with your levels.
3. **Steeper pipe (your "2no but warn"):** the same line, saying "steeper than". **This is a guess at what you meant and it is unconfirmed.** It has its own switch so it can be turned off alone.
4. **Default grade on empty ground (your "3yes"):** two typed levels flatter than the Settings minimum (1 in 100 as shipped) give the same line, worded "... minimum grade". The 1 in 100 is read from Settings, not fixed in code.
5. **Never blocks:** the pipe is always drawn. CE's own suggested level is still never questioned. No window layout was changed.
6. **Not done:** CDRULES. It reads the stored pipe, and the stored pipe does not keep the grade you chose, so there is nothing to compare. CDRULES already warns on a stored pipe flatter than the minimum-grade ladder. If you want CDRULES to list "typed against chosen", CE would have to start storing the chosen grade on the pipe: that is your call.
7. **Mistakes of my own:** (a) I broke an old source-guard test (`Bug331MetreLengthTests.CD_Held_WorksNoLevelOutOfTheLength_AndAsksNoMismatchQuestion`) by rewording one line in the Draw code; I found it in the full run, restored the line and re-ran it green. (b) My first test command failed because the placeholder transform file was missing in a fresh worktree: two minutes lost, no other cost.

**What is NOT proven:** nothing was tried in AutoCAD. The warning box showing the line, the command-line line at Draw, and the Grade mismatch window really staying away have not been seen on screen. The "empty ground" test for Default grade is "Default grade, two typed levels, CE not working a level out"; it does not separately check that neither end sits on a pit. Switching the Default/Standard radio buttons does not refresh the box until a level or the grade box changes.

## Robot cases CE 02 should write (GM1p and GM2 exist; these are new)

1. **GM3_flatter_line** (switch ON): New Pipe, Custom, type 100 in the "Set my own" grade box, two points 10 m apart on empty ground, first level 10.000, second level 9.950, Draw. Check the command line has `Levels typed give 1 in 200, flatter than the 1 in 100 grade chosen. Your levels are used.`, no window titled "Creative Engineering | Grade mismatch" appears, and the pipe levels read 10.000 and 9.950. **Switch-off control:** set `pipe.gradeMismatchIsWarningLine` false before launch, same typing: the Grade mismatch window must appear (and no line).
2. **GM4_steeper_line** (switch ON): as GM3 but second level 9.850. Check `... 1 in 67, steeper than the 1 in 100 grade chosen ...`, no window. **Control:** `pipe.steeperThanGradeWarns` false before launch: no line, no window, pipe drawn at 9.850.
3. **GM5_default_flat_line** (switch ON): New Pipe, Default grade, same 10 m, levels 10.000 and 9.950. Check `... 1 in 200, flatter than the 1 in 100 minimum grade ...`. **Control:** `pipe.flatterThanMinimumWarnsInDefault` false: no line. Also levels 10.000 and 9.900 (exactly 1 in 100): no line.
4. **GM6_own_level_quiet:** Custom 100, 4.1 m pipe from 19.45, let CE work the second level (19.40): no line and no window (B-057 still holds).
5. Settings are read at launch, so each control needs its own AutoCAD start.

## What changed (technical)

1. **Entry point:** `CdCommand.cs` Draw block "BUG-CDGR R5.7" opened `GradeMismatchDialog` from `TryDetectCustomGradeMismatch` (`CdCommand.Grade.cs`, the 10 percent test, which also fires when steeper). `CdViewModel.Inverts.cs` `InvertWarningText` is the warning box already bound in `CdDialog.xaml` (no layout change).
2. **New:** `Rules/GradeMismatchWarningRule.cs` (pure decision and wording), `CdCommand.EvaluateGradeMismatchWarning` (one decision used by the window box and by Draw), `CdViewModel.TryGetGradeMismatchWarning` (New Pipe only, never Edit Pipe), change notices from `PipeLength` and `CustomGrade`.
3. **Switches** in `PipeSettings` (`UserSettings.cs`, each documented "Default: on."): `pipe.gradeMismatchIsWarningLine`, `pipe.steeperThanGradeWarns`, `pipe.flatterThanMinimumWarnsInDefault`. With the first OFF the old window path runs unchanged (`&& !gradeMismatchIsLine` is the only change to that condition).
4. **Tests:** `Commands/B093GradeMismatchWarningTests.cs`: flatter, steeper, within 10 percent, CE's own level, Default flatter / at minimum / minimum from Settings (250 and 150 tried), each switch OFF, warning box, three switches ON through `DeserializeSettings` and `DeserializeSettingsTolerant` for `{}`, `{"pipe":{}}` and a pipe group with neighbours, each typed false changes only itself. The pins are in the new file, not in `C78NewSwitchDefaultsTests`. No before-the-fix failing run was recorded: the new tests do not compile without the new code.
5. **Runs:** net48 Release build 0 errors (twice). Focused net10 (B093, Bug331, B057, Bug857, GradeMismatchTolerance, GradeAutoCalc): 158 passed, 0 failed. Full Civil net10 Debug before the Bug331 fix: 21,604 passed, 3 failed, 32 skipped (21,639 total, not 0): `CD_Held_WorksNoLevelOutOfTheLength_...` (mine, fixed, re-run green) and the two known Debug IL-shape tests `FinalLandingProducerCollapsesOnlyItsOwnFreeEndRun...` and `RefusedNativeCallbackInvalidatesTheManagedSession...` (same two named in earlier reports). The full suite was not re-run after the one-line restore; the focused re-run covers it.
6. **Commands used:** every dotnet command named `CE_CVL_SUITE.Tests.csproj` (or the Drainage csproj for the build) with `--filter` on tests, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, below normal priority, slot check passed (1 busy) each time. Env echoed each run: `CE_STRUC_SUITE_APPDATA_ROOT=C:\CE_WORK\scratch\w1\struc`, `CE_LOG_DIR_OVERRIDE=C:\CE_WORK\scratch\w1\logs`, `TEMP` and `TMP` = `C:\CE_WORK\scratch\w1\tmp`. No Manager tests, no Structural tests.
7. **Base:** `origin/claude/rel-20261102a` (3fbb9da5). I could not list open PRs for the same files before building (gh was not on the Bash path); the PR was opened against the release branch directly. The fault was present on the start point.

## Real-files compare (names, sizes, last-write; no contents)

1. **Folders listed:** `%APPDATA%\TIM_CE_CADTOOLS` (with `CE_Admin\outbox` and logs), `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS` (with `CE_Admin`), and `CE_SUITE`. Before at 14:12: 33,246 files. After at about 14:30: 33,259 files.
2. **Result:** 13 new files and several changed files (list below). **No settings file changed**: no `CD_Settings.json`, `CS_Settings.json` or any `*Settings*` file is in the list.
3. **Were they mine? I believe not.** Another AutoCAD 2026 session started at 14:26:30 (acad.exe pid 79280, not started by me; the CVL log at 14:29 reads "CD command started"). The new outbox records name plugin 3.0.88.0 and AutoCAD 26.0, which my net10 test host is not; they include "previous CE CVL session did not close cleanly" records and CD usage records. `CD_RecentValues.json` was rewritten at 14:28:27 with the same size (12,218 bytes) while that CD was running. My test runs wrote their logs and ledger to `C:\CE_WORK\scratch\w1\logs` (seen there). I cannot prove none of the 14:14 to 14:17 files came from my run, but their content is from the installed 2026 plugin. If Tim or CE 02 was testing, that is the source.

Changed or new lines (`<` before, `>` after; paths relative to %APPDATA%):

```
< CE_CADTOOLS\CE_Admin\manager-menu-state.json	224	2026-10-31 14:01:18
< CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json	228	2026-10-31 14:11:07
> CE_CADTOOLS\CE_Admin\manager-menu-state.json	224	2026-10-31 14:27:01
> CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json	228	2026-10-31 14:29:41
< CE_CADTOOLS\CE_SUITE_MANAGER\CE_SUITE_MANAGER_MENU.cuix	28808	2026-10-31 14:01:17
> CE_CADTOOLS\CE_SUITE_MANAGER\CE_SUITE_MANAGER_MENU.cuix	28808	2026-10-31 14:26:59
< CE_CVL_SUITE\ledger\suggestions.jsonl	3575820	2026-10-31 14:05:24
> CE_CVL_SUITE\ledger\suggestions.jsonl	3576537	2026-10-31 14:29:36
< CE_CVL_SUITE\logs\CE_CVL_SUITE.log	365372	2026-10-31 14:05:24
> CE_CVL_SUITE\logs\CE_CVL_SUITE.log	396993	2026-10-31 14:27:09
< CE_CVL_SUITE\logs\ce_cvl_structured_20261031.log	8190589	2026-10-31 14:05:25
< CE_CVL_SUITE\logs\native_grip_2027.log	138780	2026-10-31 14:01:06
> CE_CVL_SUITE\logs\ce_cvl_structured_20261031.log	8232202	2026-10-31 14:29:36
> CE_CVL_SUITE\logs\native_grip_2027.log	138996	2026-10-31 14:26:39
< CE_CVL_SUITE\telemetry\outbox.jsonl	3	2026-10-31 14:01:07
> CE_CVL_SUITE\telemetry\outbox.jsonl	3	2026-10-31 14:26:41
< CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_20261031.jsonl	209909	2026-10-31 14:01:17
< CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_snapshot.json	842	2026-10-31 14:02:11
> CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_20261031.jsonl	213012	2026-10-31 14:26:59
> CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_snapshot.json	887	2026-10-31 14:27:05
< CE_STRUC_SUITE\logs\ce_struc_suite.log	3699136	2026-10-31 14:09:44
> CE_STRUC_SUITE\logs\ce_struc_suite.log	3702461	2026-10-31 14:27:59
< TIM_CE_CADTOOLS\CD_RecentValues.json	12218	2026-10-31 14:05:24
> TIM_CE_CADTOOLS\CD_RecentValues.json	12218	2026-10-31 14:28:27
< TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_CVL_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json	532	2026-10-31 14:02:11
< TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_STRUC_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json	482	2026-10-31 14:02:11
> TIM_CE_CADTOOLS\CE_Admin\outbox\failures\2026-10-31\failure_20261031_031714_182_4afe03a8f9ae4c2fa903d744d0fcdc56.json	402	2026-10-31 14:17:14
> TIM_CE_CADTOOLS\CE_Admin\outbox\failures\2026-10-31\failure_20261031_031715_223_02bc0706cd9a461cad19c810cd5fcb85.json	444	2026-10-31 14:17:15
> TIM_CE_CADTOOLS\CE_Admin\outbox\failures\2026-10-31\failure_20261031_032639_718_33f3a06bad03468abd7fdd6f89c6d543.json	402	2026-10-31 14:26:39
> TIM_CE_CADTOOLS\CE_Admin\outbox\failures\2026-10-31\failure_20261031_032640_562_17b6736be6f84038857cd1ee3616f818.json	444	2026-10-31 14:26:40
> TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_CVL_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json	544	2026-10-31 14:27:08
> TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_STRUC_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json	480	2026-10-31 14:27:05
> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-10-31\usage_20261031_031425_499_320da0fd3b62472aaf88de62c3b79adc.json	387	2026-10-31 14:14:25
> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-10-31\usage_20261031_031722_996_edb9ebd5eefa445cb3f799a4bad87451.json	394	2026-10-31 14:17:23
> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-10-31\usage_20261031_031724_090_966eecda2228415e8926431b1ecc343d.json	392	2026-10-31 14:17:24
> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-10-31\usage_20261031_031724_093_f6fec685f39442f0ab59ca9beeb98372.json	388	2026-10-31 14:17:24
> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-10-31\usage_20261031_032427_962_bf5d69272807418bbce694ad18f3655f.json	387	2026-10-31 14:24:27
> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-10-31\usage_20261031_032647_172_485682ee1424455abe7b0fd9f91d93aa.json	394	2026-10-31 14:26:47
> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-10-31\usage_20261031_032648_657_84b6cb1e614440a19c63ba5b4d4c6d68.json	392	2026-10-31 14:26:48
> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-10-31\usage_20261031_032648_660_0e3a4cc52a324c879409083df747c730.json	388	2026-10-31 14:26:48
> TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-10-31\usage_20261031_032929_988_31257798b232488baf6de502a9ea7237.json	387	2026-10-31 14:29:29
< TIM_CE_CADTOOLS\CE_Admin\sessions\CE_CVL_SUITE.json	233	2026-10-31 14:01:06
< TIM_CE_CADTOOLS\CE_Admin\sessions\CE_STRUC_SUITE.json	235	2026-10-31 14:01:06
> TIM_CE_CADTOOLS\CE_Admin\sessions\CE_CVL_SUITE.json	233	2026-10-31 14:26:39
> TIM_CE_CADTOOLS\CE_Admin\sessions\CE_STRUC_SUITE.json	235	2026-10-31 14:26:40
< TIM_CE_CADTOOLS\logs\ce_struc_structured_20261031.log	1711139	2026-10-31 14:00:15
> TIM_CE_CADTOOLS\logs\ce_struc_structured_20261031.log	1732304	2026-10-31 14:24:27
```
