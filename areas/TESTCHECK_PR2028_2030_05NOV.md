# TESTCHECK PR 2028 / 2030 (5 Nov 2026) - FOR CE 01

1. **Both failures are PRE-EXISTING on base 8de95c34 (same message, same R8 hash 9AC65ED1...).** Neither PR causes them.
2. **#2028 (eeceb0b9):** SbeamEditAutoCadEvidenceReaderTests.CompiledProductionRoute_BindsRealEntryNativeProtectionDirectStorageAndC0 (R4 flow mismatches). Fails on base: YES, identical message.
3. **#2030 (5fc1388d):** SbeamEditAutoCadEvidenceReaderTests.CompiledProductionRoute_R8KnownSafeUnreachablePathsRemainAccepted("R8BranchSwitchSafe") (R4 mismatches + "R8 exact reader IL provenance mismatch: 9AC65ED1..."). Fails on base: YES, plus its three siblings (BranchFalseBeq/Bne/Rel), 0 of 4 pass on base.
4. **Not run:** the whole Structural suite; net48; AutoCAD. #2028 run was the Sbeam/Evidence filter only and the test host crashed after that failure (aborted run), so other tests in that filter went unchecked. The base run of #2030 used the single test family, not the 624-test filter.
5. **Method:** net10.0-windows, isolated APPDATA/LOCALAPPDATA in C:\CE_WORK\scratch\tc, SkipDevBundle, no deploy, no repo change; worktrees removed. Note the test project needs a restore of CE_STRUC_SUITE.csproj with EnableUnifiedHostAdapters=true first, or it fails with NETSDK1004.
6. **My mistakes:** first test run failed on that missing restore (no harm). AutoCAD (acad.exe) was running on the PC throughout; I did not touch it.
