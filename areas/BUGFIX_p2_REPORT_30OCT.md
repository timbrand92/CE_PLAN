# BUG-1240 report: the CE Inspector says "Unknown" on a pit until CDSYNC (draft PR #1880)

Fri 30 Oct 2026, 21:30 Melbourne time. Key p2. Branch `fb/bug1240-inspector-reads-saved-record`, base `claude/rel-20261102a` (the C-78 line, Civil 3.0.85 train), worktree `C:\ce-fx\p2w`.

---

## FOR TIM

### Answer first

1. **Draft PR #1880 is open.** It is built and unit-tested only. Nobody has opened it in AutoCAD. Nothing is installed. BUG-1240 is not marked FIXED.
2. **What you will see differently:** open a drawing (or Save As), pick pit P2 and open the CE Inspector before running anything else. It should now show P2's real number, cover level and connections straight away. Before, it said "This pit is not in CE's recorded project data yet. Values below are Unknown" until you ran CDSYNC or the Pit Schedule.
3. **Why it happened:** the Inspector only looked at the pit list CE keeps in its memory. CE fills that memory only when a drawing or edit command runs. A freshly opened drawing has the list saved inside it, but the Inspector never read it.
4. **How the fix works:** when CE has no list in memory for the drawing in front of you, the Inspector reads the list saved inside the drawing. It only reads. It writes nothing, saves nothing and does not touch locked layers, Xrefs or REFEDIT. This is the same read CDCHECK got for BUG-1251 (PR #1866, already in this base).
5. **Switch:** `linking.inspectorReadsSavedRecordWhenNotLoaded`, ON. Set it to false and the Inspector behaves exactly as before.
6. **Build number:** the build register has no entry for BUG-1240 yet. The PR title starts "BUG-1240 ...", so CE 01 can rename it to its B number.

### Mistakes of my own, first

1. **My first test run stopped at once** because the placeholder file the build needs (`CE_TRANSFORM_2027.arx`, empty and git-ignored) was missing in my new worktree. I had the recipe in memory notes and did not apply it up front. It cost about 5 minutes.
2. **I waited about 80 minutes** for a free build slot before the first test and about 50 minutes before the full run, because other jobs held both slots.

### What to check in AutoCAD (the robot case does this)

1. Open a job drawing, close it without saving, open it again.
2. Before typing any CE command, pick pit P2 and read the Inspector.
   - **Right:** Number P2, the cover level, the connections list.
   - **Wrong:** "This pit is not in CE's recorded project data yet".
3. Do the same after Save As on a new drawing that has pits and pipes.

### What is NOT proven

1. **Nothing was driven in AutoCAD.** That the saved list returns P2 on a real reopened drawing is expected from the code (the same read CDCHECK uses), not seen.
2. **Speed is not measured.** Until some CE command attaches the list, each pick reads the saved list from the drawing (an open-close read of the list text). I expect it to be small; I did not time it on a big drawing.
3. **The Inspector's "Open existing" button** still depends on the list in memory only, deliberately, so it is unchanged.
4. **The old (non-workshop) Inspector path** is unchanged; it already attaches the record by itself, with a write. Only the default passive path was changed.
5. **The two failing full-suite tests are not compared with the base** (technical item 5).
6. **Pipe pick and other Inspector pages** use the same list, so they should also stop reading Unknown; I tested only the pit wording in logic, not any page in AutoCAD.

### Robot case that proves it

1. **N39_inspector_reopen** (DRV1_B1 drawing with pits and pipes; `SETTING CD_Settings.json linking.inspectorReadsSavedRecordWhenNotLoaded true` before launch). Case A: launch on the drawing. Case B: after the runner's normal `reopen-copy -Force`, with no CE command typed, select pit P2 (the same blind pick the other Inspector cases use) and read the Inspector's Number row and header text.
2. **It checks:** the Inspector header does not contain "not in CE's recorded project data yet", the Number row reads P2, and the CE log has no `Project data switched to` line before the pick (proves nothing was bound or saved).
3. **Control C39** (`VARIANT_OF N39`, the switch set to `false`): it must FAIL by showing "This pit is not in CE's recorded project data yet".

---

## Technical detail

1. **Cause and entry point:** `Modules/Drainage/Services/InspectorPaletteService.cs`, `RefreshCivilProperties` (the workshop layout is the default, `CeEditorShellFlagDefaults.WorkshopLayout = true`, so `RefreshInspector` goes to it). It took the list from `ProjectDataService.TryPeekCurrent(_civilDatabase, out data)` only. `SetDrawingPath` / `EnsureDrawingDataCurrent` (what attaches the list) run only from CE commands and from the legacy Inspector path, which `!WorkshopInspectorEnabled` skips. With no list, `data` was null, `pit` null, `ShowCivilPitRecord(null, ...)` printed the "not in CE's recorded project data yet" subtitle. Matches the CE log of 29 Oct 13:22 (the Pit Schedule attached the list, "nothing written").
2. **Change (commit 3f7ed338):**
   1. New `Rules/InspectorProjectSourceRule.cs`: `Choose(liveRecordIsThisDrawings, recordDrawingClosed, switchOn)` giving None / Live / StoredRecord. OFF returns Live or None, ignoring the closed flag (today exactly).
   2. `InspectorPaletteService.RefreshCivilProperties`: after the live peek, when the rule says StoredRecord, `data = ProjectDataService.TryReadProjectWithoutChanging(_civilDatabase, ...)`. A failed read logs one `[Inspector]` warning and leaves `data` as before. `CivilCanOpenExisting` is still decided from the live peek, before the new block.
   3. `Models/UserSettings.cs`: `LinkingSettings.InspectorReadsSavedRecordWhenNotLoaded`, `[JsonProperty("inspectorReadsSavedRecordWhenNotLoaded")]`, "Default: on.", beside `inspectorPickWaitsAfterUndo`. No Settings page row (the neighbouring `linking` switches have none).
   4. `REGRESSION_LOG.md` entry added at the top. CE_SHARED unchanged. `ProjectDataService.cs` and `ChecksResultReader.cs` (the #1866 files) unchanged.
3. **Tests:** new `Modules/Drainage.Tests/Services/Bug1240InspectorReadsSavedRecordTests.cs` (12 cases): rule truth table ON and OFF; live record used as today; switch loads ON through `SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant` for three file shapes (empty, empty group, group with other keys); typed false turns off only itself; source guards (choice made before the read, saved list read via `TryReadProjectWithoutChanging`, "Open existing" still decided by the live list, `RefreshCivilProperties` holds no `SetDrawingPath`, bind, `EnsureDrawingDataCurrent`, save, `FlushPendingSave` or `StartTransaction(`; the rule file holds no drawing work). I did not add the key to `C78NewSwitchDefaultsTests`/`C75` pins, to avoid a merge clash with the train files; the new class pins its own default.
4. **Results:**
   1. Focused net10 (Bug1240, B055, C75 to C78 switch tests, RedoSafe, Inspector): **444 total, 444 passed, 0 failed** (count is not 0).
   2. **Full Civil net10: 21,576 total, 21,542 passed, 32 skipped, 2 failed.** The PDF page test did not fail, so no lone re-run.
   3. net48 compile of `CE_CVL_SUITE.csproj`: **0 errors**, 246 warnings.
5. **The two failures:** `FinalLandingProducerCollapsesOnlyItsOwnFreeEndRunBeforeSplitPreflightAndFinalDecision` and `RefusedNativeCallbackInvalidatesTheManagedSessionBeforeReportingChannelFailure`. These are the same two names the B-055 report lists as failing on its branch. Neither touches the Inspector or the project record. I did not run the base to prove they fail there.
6. **Environment:** Debug net10 and net48 through `C:\ce-fx\p2_run.ps1` (two-slot wait, below-normal priority, `-p:SkipDevBundle=true -nr:false --disable-build-servers`), AutoCAD 2027 on PATH, placeholder 0-byte arx. Never deployed; no bundle, settings or ProgramData touched. Worktree bin/obj cleaned with `git clean -fdXq` inside `C:\ce-fx\p2w` only.
7. **Not tested:** anything in AutoCAD or accoreconsole; timing; the legacy Inspector path; net48 tests (they do not load on this PC).

---

**Summary (under 100 words):** Draft PR #1880 (BUG-1240, no B number yet). `InspectorPaletteService.RefreshCivilProperties` now reads the pit and pipe list saved in the drawing, read only, when CE holds none in memory, so the Inspector no longer says Unknown after a reopen or Save As. New `Rules/InspectorProjectSourceRule.cs`, plus `UserSettings.cs`, a new test class and a log entry. Switch `linking.inspectorReadsSavedRecordWhenNotLoaded` (ON; OFF = old). Focused 444 of 444; full net10 21,542 of 21,576 with 2 unrelated reds (same names as #1866); net48 0 errors. Robot proof: N39_inspector_reopen, control C39.
