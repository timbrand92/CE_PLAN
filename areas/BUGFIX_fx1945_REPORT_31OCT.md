# BUGFIX fx1945 report: review fixes on PRs #1940, #1943, #1945 (31 Oct 2026)

## FOR TIM

1. **#1940 (BUG-1144, damaged outlet record in Redesign Apply):** the warning after Apply now says "CE kept a copy" only when CE really made the copy. If the record was empty or the copy failed, it says plainly that no copy was kept. Nothing else changes. Switch OFF is the old behaviour exactly.
2. **#1943 (BUG-1153):** now contains #1940's fix (a normal merge). Its own behaviour is untouched.
3. **#1945 (BUG-1158, Save As copy warning in CDDESIGN):** a drawing that has never been saved, or whose file name is a template (.dwt) or standards (.dws) file, now records no path. So approving outlets before the first save no longer makes CDDESIGN warn every time afterwards. The warning also says "Approve the outlets again in CDLPD to clear this warning." The folder-path comparison is NOT changed: your answer (warn every time, once, or compare name and folder only) is still pending.
4. **Log tidy:** the doubled "Undo" line and the missing blank line in REGRESSION_LOG.md are fixed on #1940 and carried into #1943.
5. **Built and unit-tested only. Nobody has opened any of this in AutoCAD.** No bug is fixed.

What the robot and Codex still need to prove:
1. **#1945:** start a new drawing from the CE template, approve Design outlets in CDLPD before saving, save, run CDDESIGN: expect no warning. Also confirm what AutoCAD really reports as the file name of a never-saved drawing (this was never checked).
2. **#1940:** damage the saved outlet record on a test copy, run the redesign and Apply: expect the warning to say a copy was kept. A case where the copy cannot be made was only proven in code, not in AutoCAD.

## DETAIL

1. **Heads pushed (normal commits, no force-push):** #1940 c55494e0, #1943 62c8f363 (merge of #1940 into its branch), #1945 a6a892bc.
2. **#1940 change:** `RedesignOutletRecordRule` now has `WarningWithCopyOutcome(bool)`. `NetworkRedesignOutletRoleService.WriteInTransaction` returns whether the copy was really made; `NetworkRedesignApplyCoordinator` builds the shown warning from that. The warning inside the ticket (before the write) makes no claim about the copy, so ticket hashes are unchanged. Two new tests in `Bug1144DamagedOutletRolesTests`.
3. **#1945 change:** `LpdSaveAsCopyRule.PathToRecord(filename, drawingHasBeenSaved)`; `LpdService.WriteApprovedPath` reads DWGTITLED (a read-only system variable, active drawing only; an unreadable value counts as saved). New test `ANeverSavedDrawing_RecordsNoPath_NotEvenTheTemplateItWasStartedFrom` failed before the fix (it returned the template path) and passes after. The old "Drawing1.dwg" assertion stays and still passes.
4. **Tests run (net10.0-windows only, scoped, -p:SkipDevBundle=true, isolated env folders under C:\CE_WORK\scratch\fx1945):** #1940: Bug1144 + NetworkRedesignApplyTicketServiceTests, 29 passed. #1943 (after merge): Bug1144 + Bug1153 + ticket tests, 39 passed. #1945: Bug1158, 6 passed.
5. **NOT tested:** net48 build (the DWGTITLED call uses `Autodesk.AutoCAD.ApplicationServices.Core.Application`, which should exist there, unverified); the full suite; Manager tests; anything in AutoCAD; the other Opus notes left alone (double blank line in UserSettings.cs, duplicate LPD read in #1943, several-complete-outlets silent skip). A 0-byte placeholder CE_TRANSFORM_2027.arx was created in the worktree only (not committed).
6. **Undo:** revert the single new commit on each branch (#1943: revert the merge commit).
