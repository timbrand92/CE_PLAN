# B-055 BUG-1251: CDCHECK reopen fix report

Fri 30 Oct 2026, 10:20 Melbourne time. Job B-055 (team_fix_c85a). Draft PR #1866, branch `fb/cdcheck-reads-this-drawings-record`, base `claude/rel-20261029a` (Civil 3.0.86, commit 5888ee75). Worktree `C:\ce-fx\c85a`.

---

## FOR TIM

### Answer first

1. **Draft PR #1866 is open.** It is built and unit-tested only. Nobody has opened it in AutoCAD. Nothing is installed. Not marked FIXED.
2. **What you will see differently:** open a drawing, close it, open it again, and type CDCHECK first (before any other CE command). Before, it said about 40 joins were "Unresolved" and called every pipe "an unnamed pipe" (142 Connected / 44 Unresolved on the robot drawing). Now it should give the same totals as the first open (179 Connected / 4 Unresolved) with the pipes named like "P3 to P2".
3. **How it works:** when CE has no pit and pipe list in memory for the drawing in front of you, CDCHECK reads the list saved inside the drawing. It only reads. It writes nothing, saves nothing, and does not touch locked layers, Xrefs or REFEDIT.
4. **Switch:** `checks.cdcheckReadsThisDrawingsRecord`, ON. Set it to false and CDCHECK behaves exactly as before.
5. **I missed the 06:00 cut for C-77.** The PR was open at about 07:10, because both build slots were taken by other jobs from 04:50 to 06:50. A fix for a reopen-first CDCHECK is not in a C-77 cut made at 06:00 unless the cut re-reads the branch.

### Mistakes of my own, first

1. **I wrote a wrong bug number.** My first commit said "BUG-1229 candidate". BUG-1229 is a different bug (typing one level). I found the real number, BUG-1251, in the build register before pushing, and amended the commit while it was still local. Nothing wrong reached GitHub.
2. **I broke two older safety tests and my first full run caught only one.** Three existing tests pinned the exact old wording of CDCHECK's code. I updated them as I met them, and my focused run missed the third. It cost one extra full run of about 50 minutes.
3. **My first full run was killed by the tool's two-hour limit.** I had to run the full suite again.

### What to check in AutoCAD (the robot case does this)

1. Open any job drawing, type CDCHECK, press Enter, note the totals line.
2. Close without saving. Open it again. Type CDCHECK first, press Enter.
   - **Right:** the same totals as step 1, and pipes named like "P3 to P2", not "An unnamed pipe".
3. Open a second drawing and type CDCHECK first.
   - **Right:** its pits are named (P1, P2 ...), not long IDs.

### What is NOT proven

1. **Nothing was driven in AutoCAD.** The totals 179 / 4 on a reopened drawing are expected from the code, not seen.
2. **The second-drawing case** (not a reopen) is expected from the same code, not seen.
3. **The secondary risk is not fixed.** If AutoCAD gives the reopened drawing the same memory as the closed one, CDCHECK could still read the closed drawing's unsaved list. The one place that decides this (`ProjectDataService.TryPeekCurrent`) is used by other readers, so changing it is not a one-line safe guard. Left as is. The fix avoids the in-memory list when CE knows the owning drawing closed, but then reads through the same function, so that exact case is still open.
4. **Two full-suite failures are not compared with the base.** See technical detail item 5.

### Robot case that proves it

1. **N38_cdcheck_reopen** (DRV1_B1, `SETTING CD_Settings.json checks.cdcheckReadsThisDrawingsRecord true`, as set in the diagnosis report). Two cases in ONE AutoCAD start. Case A: plain R21 on the launched copy. Case B: R21 again after the runner's normal `reopen-copy -Force`.
2. **Case B types:** `CDCHECK`, Enter (All), Esc; then `CDCHECK`, `Problems`, Esc.
3. **It checks:**
   1. The command line holds `[CE] CDCHECK: 212 objects, 184 connections: 179 Connected, 1 Possible, 4 Unresolved, 0 Not Connected` twice.
   2. No line containing `An unnamed pipe flows`.
   3. The CE log for case B has no `Project data switched to` line before the first `Command outcome: CDCHECK` line (proves no bind and no save).
4. **Control C38** (`VARIANT_OF N38`, the switch set to `false`): it must FAIL check 1 by printing `187 connections: 142 Connected, 1 Possible, 44 Unresolved`.

---

## Technical detail

1. **Cause and entry point:** `Modules/Drainage/Services/Checks/ChecksResultReader.cs` `GatherSpine` called `LinkService.BuildSpineRecords(db, tr, now, projectSnapshot)` with a null snapshot, so `PeekProjectForDatabase` (`ProjectDataService.TryPeekCurrent`) returned null when CE's in-memory record belonged to another database. Diagnosis: `areas/R21_MOVE_UNDO_DIAGNOSIS_30OCT.md`. I confirmed each file and line on the base before editing.
2. **Change (commits a9cc994a, dd8ea64d):**
   1. New `Modules/Drainage/Rules/CdCheckProjectSourceRule.cs`: `Choose(snapshotGiven, liveRecordIsThisDrawings, recordDrawingClosed, switchOn)` giving None / Snapshot / Live / StoredRecord. OFF returns Snapshot, else Live or None, ignoring the closed flag (today exactly).
   2. `ChecksResultReader.GatherSpine`: chooses before the transaction; on StoredRecord reads `ProjectDataService.TryReadProjectWithoutChanging(db, out storedProject)` (BUG-589), passes it as `spineProject` to `BuildSpineRecords`, and reuses it as `fitProject`. A failed read logs one `[CDCHECK]` warning and behaves as before. A caller-supplied snapshot is never replaced.
   3. `ProjectDataService.cs`: two read-only internals, `HasLiveRecordFor(db)` and `IsRecordDrawingClosed`. `HasLiveRecordFor` exists because the BUG-589 guard forbids a bare `TryPeekCurrent` inside `GatherSpine`.
   4. `Models/UserSettings.cs`: `ChecksSettings.CdcheckReadsThisDrawingsRecord`, `[JsonProperty("cdcheckReadsThisDrawingsRecord")]`, documented "Default: on.". There is no Settings page row for the BUG-372 switch beside it, so I added none.
   5. CE_SHARED unchanged. No command, write, regen, view or system variable added.
3. **Tests:** new `Modules/Drainage.Tests/Services/B055CdcheckReadsThisDrawingsRecordTests.cs` (12 cases): rule truth table ON and OFF, record in memory used as today, reopened drawing reads the saved list only with the switch ON, default ON through `SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant` for three file shapes, typed false turns off only itself, a miniature projector fixture (pits and pipe with the list: 2 Connected and 0 Unresolved; without it: Unresolved appear; the same list twice gives the same lines), source guards (chosen before the read, passed on, reused for the fit check, no `SetDrawingPath`/bind/save/`InitServices` in `ChecksResultReader`, `SpineCheckCommand` or the rule file, no drawing work in the rule). Three older source guards updated for the renamed variable: `SpineCommandContractTests`, `CheckIgnoreUndoTests`, `Bug589CdCheckReadsSavedRecordTests`. I did not add a pin to `C76NewSwitchDefaultsTests`; the new class pins its own default instead, to avoid a merge clash with that train file.
4. **Results:**
   1. Focused net10 run (B055, Bug372, C76 switches, CivilSpineProjector, SpineCommandContract, CheckIgnoreUndo, ChecksResult): **130 total, 130 passed, 0 failed** (count is not 0).
   2. **Full Civil net10 run (after the last commit): 20,935 total, 20,901 passed, 32 skipped, 2 failed.**
   3. net48 compile of `CE_CVL_SUITE.csproj`: **0 errors**, 242 warnings.
5. **The two failures:** `SourceAtomicCoordinatorDependencyTests.FinalLandingProducerCollapsesOnlyItsOwnFreeEndRunBeforeSplitPreflightAndFinalDecision` (SourceAtomicCoordinatorDependencyTests.cs:322) and `RefusedNativeCallbackInvalidatesTheManagedSessionBeforeReportingChannelFailure`. Neither touches CDCHECK, `ChecksResultReader` or the project record. Earlier reports on this train call two IL-shape tests known reds; I did **not** run the base to prove these two are those, and did not compare names with an earlier run, so treat them as unverified. One earlier full run (before my last commit) also failed `CeMessageCentreTests.WorkQueue_DrainGivesUpAtTheTimeout`, a timing test under load; it passed in the final run. The one PDF page test did not fail, so I did not re-run it alone.
6. **Environment:** Release not used; Debug net10 and net48, every command through `C:\ce-fx\b055_run.ps1` (waits for a free slot with the two-slot count, below-normal priority, `-p:SkipDevBundle=true -nr:false --disable-build-servers`). AutoCAD 2027 on PATH, placeholder 0-byte `CE_TRANSFORM_2027.arx` (git-ignored). The wait for a free slot took from 04:50 to 06:50 and again 08:10 to 08:45. Never deployed; no bundle, settings or ProgramData touched.
7. **Not tested:** anything in AutoCAD or accoreconsole; the second-drawing variant; the Checks palette (`ChecksListPaletteService.cs:98` uses the same `GatherSpine`, so it changes the same way, unseen); Manager; net48 tests (they do not load on this PC).
8. **REGRESSION_LOG.md:** entry added at the top.

---

**Summary (under 100 words):** Draft PR #1866 (B-055, BUG-1251). `ChecksResultReader.GatherSpine` now reads the drawing's saved pit and pipe list, read only, when CE holds none for this drawing, so a reopened drawing's CDCHECK gives the same totals (expected 179 / 4, not 142 / 44). New `Rules/CdCheckProjectSourceRule.cs`, plus `ProjectDataService.cs`, `UserSettings.cs`, three guard tests and a new test class. Switch `checks.cdcheckReadsThisDrawingsRecord` (ON; OFF = old path). Focused 130 of 130; full net10 20,901 of 20,935 with 2 unrelated reds not compared with base; net48 0 errors. Robot proof: N38_cdcheck_reopen, control C38.
