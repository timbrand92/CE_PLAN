# BUGFIX w1275 report: BUG-1275 SBEAM crash guard (5 Nov 2026)

## FOR TIM

1. **What you will see differently:** if a steel beam section placement refers to something that has been erased or belongs to another drawing, the command line now says "This beam section could not be placed because something it refers to was removed. Nothing was changed." and the drawing stays exactly as it was. Before, AutoCAD could close.
2. **PR:** #2024, DRAFT, B-1275, against `claude/rel-20261026s`. No Settings switch: it only turns a crash into a refusal.
3. **Not proven:** nobody has reproduced the crash, and I have not opened this in AutoCAD. If the crash is a true native access violation, .NET cannot catch it, so the up-front checks (null, erased, wrong drawing) are the real protection. If your crash comes from a cause other than a stale id, this will not fix it. Not marked fixed.
4. **My own mistakes:** two small ones. My first edit pass used the wrong shell, so it ran again; and the net48 post-build step failed once because `powershell` was not on this job's PATH (not a code fault; it passed once the PATH was set).
5. **Robot case (proposed, not yet written):** `S_sbeam_stale_id`. It would place a beam section on a copy of a drawing after erasing the current layer's entities the plan refers to, and check the command line shows the "could not be placed because something it refers to was removed" line and that the entity count is unchanged. Switch-off control: none exists, because there is no switch; the control is a normal placement on the same copy, which must still draw.

## Technical detail

1. **Fault confirmed on base:** `SbeamAtomicPlacementWriter.RecheckAdmission` (line 371 before the change) called `transaction.GetObject(database.CurrentSpaceId, ...)` with no id check; so did the pre-check, `StageOwnedEntities`, the transform loop and `ReadLayerStates`. Matches the stack in BUG-1275.
2. **Fix:** new `Modules/Structural/Services/SbeamStoredIdGuard.cs`: pure `IsSafeToOpen(isNull, isErased, sameDatabase)`; `OpenOrRefuse<T>` checks `IsNull`, `IsErased`, same database (by `UnmanagedObject`, since Database wrappers are not cached) and catches `Autodesk.AutoCAD.Runtime.Exception`, throwing `SbeamStaleObjectException` with the plain message. `TryStage` catches it and returns `Failed` with that message (the runner prints it; the transaction aborts). The pre-check method returns the same message as its issue.
3. **Tests:** `SbeamStoredIdGuardTests` (7): five flag cases (valid, null, erased, foreign, null and erased), message wording, source test that `RecheckAdmission` uses the guard and the writer has no raw `transaction.GetObject(`. Run with `SbeamAutoCadPlacementAdapterTests`: 39 passed, 0 failed, net10.0-windows, one project, with filter.
4. **Built:** net10 test build and net48 Release compile of `CE_STRUC_SUITE`, 0 errors, with `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`. net8 not built.
5. **CE_SHARED untouched.** No Manager tests. No AutoCAD started.
6. **Real-file listings (rule 1):** the listings of `%APPDATA%\TIM_CE_CADTOOLS`, `CE_STRUC_SUITE`, `CE_CVL_SUITE` and `CE_CADTOOLS` taken before the first test and after the last are byte-identical (SHA256 971B828C...ACDBF13, 37,008 lines each). Files: `C:\CE_WORK\scratch\w1275\before.txt` and `after.txt` (scratch folder removed at clean-up; hash recorded here).
7. **Not tested:** any real erased or foreign id (needs a real AutoCAD `Database`, which aborts the unit-test host); the three-lane net8 build; the new-switch-defaults test (no switch added).
