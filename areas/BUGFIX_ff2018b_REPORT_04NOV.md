# BUGFIX ff2018b report — PR #2018 (CIVIL-OFF-4), review FIX 2 (5 Nov 2026)

## FOR TIM

1. **What you will see differently:** in "Upgrade this drawing" (CDUPGRADEDRAWING), after you press OK on the preview box, the command line now asks "Upgrade mode [Merge/Replace] <Merge>" straight away. Before, it asked this after the drawing had already been marked Civil ON and the pipes converted. Cancel or Escape now changes nothing at all. The typed CDUPGRADE command asks as before.
2. **What was wrong:** pressing Cancel at Merge or Replace left a half-upgraded drawing (Civil ON, pipes converted, no version stamp), and the next open would ask the "older drawing" question again, with the default answer marking it OFF.
3. **My own mistakes:** (a) I ran the folder listings of the real CE files only once, after the test, not before and after. The test suite's own guard compared them and was inconclusive because AutoCAD was open on this PC. So "no real file changed" is not proven by me. (b) The first test attempts failed because dotnet was not on the shell path; no harm done.
4. **NOT proven:** nobody has driven this in AutoCAD. The Merge/Replace question is an AutoCAD prompt, so it has no unit test; the 34 existing CivilOff4 tests pass on net10 and net48 (net48 compile checked).
5. **Robot case (to write):** `CO4_cancel_merge_replace`. Type CDUPGRADEDRAWING on a saved drawing marked OFF, press OK on the box, type `C`? No: send Escape at the Merge/Replace line. Check: the command line shows "Upgrade cancelled. Nothing has been changed.", the drawing's Civil mark is still OFF, DBMOD is unchanged and no PRE_C7 backup file appears. Switch-off control: set `options.oneUpgradeAction` false before launch; CDUPGRADEDRAWING then says it is switched off and the Merge/Replace line never appears.

## Technical

1. **Fault confirmed** on `claude/civil-off-4` f39d2226: `UpgradeDrawingCommand.cs` wrote the OFF to CVL mark (step 2) and converted pipes (step 3) before `CdUpgrade()` asked Merge/Replace (step 4).
2. **Fix (review option 1):** commit 328e2fb5 on the PR's own branch (one extra normal commit, no force-push, base unchanged). `UpgradeDrawingCommand.cs` asks the keyword prompt after the preview and before the backup; `LinkCommands.cs` gains `internal static bool? UpgradeReplacePreset`, which `CdUpgrade` uses instead of asking when set. It is cleared in a `finally`.
3. **Switch:** unchanged, `options.oneUpgradeAction`, Default: on. No new write, regen, view or system variable. CE_SHARED untouched.
4. **Log:** REGRESSION_LOG.md item 9 added under the CIVIL-OFF-4 entry.
5. **Tests:** `dotnet test Modules\Drainage.Tests\CE_CVL_SUITE.Tests.csproj --filter FullyQualifiedName~CivilOff4 -c Release -p:SkipDevBundle=true -nr:false --disable-build-servers -m:2` gives 34 passed on net10.0 and 34 passed on net48. The B-099 real-folder guard teardown was Inconclusive (AutoCAD running, 0 differences seen). RedoSafe call-graph tests were not run (not in the filter); the change adds no writes.
6. **Real-folder listing:** after-listing saved at `C:\CE_WORK\scratch\ff2018b\listing_after.txt`; no before-listing exists (see mistake a).
7. **Not done:** FIX 1 (slice 2). Report not pushed with git by me beyond this file; commit it by name from C:\CE_PLAN.
