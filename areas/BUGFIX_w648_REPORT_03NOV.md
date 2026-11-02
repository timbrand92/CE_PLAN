# BUGFIX w648 report: BUG-648 AG drain grade label (B-182), 3 Nov 2026

## FOR TIM

1. **Result:** draft PR #2001 (B-182). After CDAGI with a start and end level, pressing Accept now draws a "1:50" text under the middle of the longest leg of the drain, on the drain's own layer, one per run. One Undo removes the drain, its record and the text together.
2. **What you will see:** your exact run (5000,5000, 10000,5000, 10000,0; start 20.200, end 20.000) gives a "1:50" text under the middle of the first 5 m leg. A run that rises towards its outlet reads "1:50 rising". Levels skipped or equal: no text, as before.
3. **Switch:** Settings, Surface drainage, `agDrainGradeLabel`, ON by default. Set it false and restart AutoCAD to get the old drawing exactly (line only).
4. **My own mistakes first:** none that cost a run. The tests pass but I have not seen it in AutoCAD.
5. **NOT proven / NOT done:** (a) built and unit-tested only; nobody has opened it in AutoCAD. (b) The text is NOT yet linked to the drain: MOVE, COPY or ERASE of the drain will not carry the grade text with it. The existing link holds exactly one PD text and a renumber would overwrite it, so I did not reuse it. Linking properly is a design decision for you (question below). (c) Plotted paper height, save/reopen and Undo/Redo duplicates were not checked in AutoCAD. BUG-648 stays OPEN.
6. **One question for you (engineering call):** should the grade text follow the drain on MOVE/COPY/ERASE like the PD tag does? Recommendation: yes, as a follow-up build with its own link record, so a renumber can never rewrite it. On a job: without it, moving an AG drain leaves "1:50" behind on the old spot.
7. **Robot case:** `ag648_grade_label`. Types in a fresh mm drawing: CDAGI, 5000,5000, 10000,5000, 10000,0, Enter, Enter (skip outlet), 20.2, 20, Enter (Accept). Checks the drawing has exactly one TEXT/MTEXT on the AG layer whose contents are `1:50`, at X 7500. Control: set `surface.agDrainGradeLabel` to false before launch, repeat; the check must find zero text entities and the one LWPOLYLINE only. Then U: both gone. Case file not written here (brief covers it).

---

## Technical detail

1. **Base:** origin/claude/rel-20261102a (3fbb9da5). Fault confirmed on it: `AgiCommand.Apply.cs` writes the polyline, the record and (perimeter only) `AppendTagLabel`; `GradeCheckText` is only stored (RegisterInTransaction) and printed (ApplyAccepted message). No grade entity anywhere. Not already fixed.
2. **PR:** #2001, branch claude/w648-ag-grade-label, one commit. Files: `Commands/AgiCommand.GradeLabel.cs` (new: pure `BuildGradeLabelText`, `BuildGradeLabel`, `AppendGradeLabel`), `Commands/AgiCommand.Apply.cs` (write step plus read-back), `Models/UserSettings.cs` (`SurfaceDrainageSettings.AgDrainGradeLabel`, json `agDrainGradeLabel`, "Default: on."), `Drainage.Tests/Commands/Bug648AgGradeLabelTests.cs`, REGRESSION_LOG.md. CE_SHARED untouched. No Settings page row.
3. **Tests (net10, ref paths from the C-62 assembly report, SkipDevBundle, one project per command, filtered):** new class 17/17 pass; related set (Agi, NewSwitchDefaults, UserSettings, RedoSafe, SurfaceDrain) 423/423, 0 failed. net48 compile of Modules/Drainage: 0 errors. Switch pinned through DeserializeSettings and DeserializeSettingsTolerant for `{}`, empty surface group, a group without the key, and typed false.
4. **Why not the PD tag link:** `WriteSurfaceDrainTagLink` / `IsSurfaceDrainTagLinkExactInTransaction` require exactly one attachment, and `TryRenumberSurfaceDrainTag` sets the text of every attachment to the new number (`DecideRenumber`), which would overwrite "1:50".
5. **Isolation:** CE_LOG_DIR_OVERRIDE, TEMP, TMP set under C:\CE_WORK\scratch\w648 before each run. Listing of %APPDATA%\TIM_CE_CADTOOLS, CE_STRUC_SUITE, CE_CVL_SUITE, CE_CADTOOLS (36,465 files) before and after: identical, 0 differences (listings deleted with the scratch folder). No Manager tests run.
6. **Environment notes:** gh and dotnet are not on the tool PATH; used full paths and added Git to PATH for gh. The job env had a different preset CE_LOG_DIR_OVERRIDE (319_fix_w648); I reset it to the w648 scratch.
