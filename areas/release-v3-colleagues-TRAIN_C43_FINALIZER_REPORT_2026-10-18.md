# Train C-43 finalizer report (Civil + Manager), Sun 18 Oct 2026 (about 06:15 to 06:40, Melbourne time)

**Answer first: GO.** Train `claude/rel-20261018c`, final head `ea44f14b97d76e73482fec531a56b8ad28885336` (was 0d32f126; one finalizer commit on top, pushed as a normal fast-forward). Built and unit-tested only. Nobody has opened any of it in AutoCAD; nothing was installed, deployed or version-edited. The HIGH silent-data bug (BUG-698: CDSYNC set 30 Pit Schedule sizes to 100) is closed on every route I could find that reads a pipe size and falls back to 100. The un-reviewed #1338 fix round `1041f89b` is right.

**Manager does not need to ship with this train:** nothing under `Shared/`, `Modules/Manager`, the installer, any csproj, props or PackageContents changed between C-42 (b06126db) and the final head. CE_SHARED is the same as the one installed with 3.0.53 / 1.1.53.

## 1. What I changed (one commit, `ea44f14b`)

1. **CD, answer E, refuses a line CE registered to a pipe, pit or source (review 1121, LOW 1).** The selection test CD E uses passes over a CE label, arrow or outline and answers "not a CE pipe" for it, so CD E took it as a plain route and, for an open line, erased it. Now the pick is refused with: "That line is part of a CE pipe, pit or source (its label, arrow or outline). Use CD answer E on a plain drawn line instead. Nothing was changed." The test is the one the contextual ribbon tab already uses (one code path), one read-only look at the drawing (Undo and Redo stay safe), never throws.
2. **How rare it is (honest):** today CE draws labels as text and arrows as blocks, which the CD E pick already turns away as "That is not a polyline." It matters only on an older or imported drawing where a polyline was registered to a pipe or pit. Cheap guard, no prompt, no switch, no Settings value.
3. **Red first:** a source guard in `AdoptedLineRoutePolicyTests` failed on the train head (1 of 9 failed), then passed (9 of 9).
4. **REGRESSION_LOG:** item 7 added under the BUG-697 entry, 1 line added, 0 removed, ASCII only.

## 2. The #1338 fix round `1041f89b`, judged against entry 1121

1. **MEDIUM cured.** The pick filter now allows "a polyline or anything built on one" (exact match off), the same switch the other pipe picks use (`PipePickService.AllowPipeClasses`, with its own note that exact match refused the CE pipe object).
2. **A real CE pipe:** reaches the ownership check and gets "That line is already a CE pipe. Double-click it to change it. Nothing was changed." The ownership check reads the CE pipe object by its own class name first, so a converted pipe always answers Pipe.
3. **A plain polyline:** not owned, not an attachment (now checked too), so it goes on to the existing Xref, locked-layer and closed or curved line handling and is accepted as before.
4. **A plain Line or Circle:** neither is built on a polyline, so the pick still says "That is not a polyline." A 2D or 3D polyline (the old heavy kind) is also still refused, as before the PR.
5. **LOW 2 (only a source guard covers the wiring):** still true; the classifier itself is covered by the existing selection tests. The Codex step is the real proof.

## 3. BUG-698: every route that reads a pipe size and could fall back to 100

1. **CDSYNC and CDUPGRADE (`LinkCommands.TryGetPipeInfo`):** stored size first, then drawn width, then 100 (last resort only). Fixed by #1339. The reader is a read-only look (open-close), and it cannot clash with CDSYNC's own writes because each pipe's record is read before that pipe is written. If the read ever fails it returns 0 and the old order applies; it never writes a guess of its own.
2. **Drawing-recovery scan (`ProjectDataService.Recovery`, both the empty-schedule rebuild and the missing-pipe add):** stored size first on both branches. Fixed by #1340. The scan reads in its own transaction before any pipe is registered.
3. **Open-time upgrade to the pipe object:** refuses a pipe with no stored size ("its width is not set"); never writes 100. Safe.
4. **Relink-all and CDREPAIR (`RepairAudit.Linking`):** returns early when the pipe already has a schedule row; reads the stored size first; 100 only for a pipe with no record, no width and no row. Writes the schedule row only, not over a recorded pipe. Safe.
5. **Edit Pipe:** no 100 fallback anywhere in the Edit Pipe files (the only "100" hits are grades). Saves what the box shows. Safe.
6. **Pit Schedule refresh (`PitScheduleBuilder.GetPipeDiameterDisplay`):** reads the stored record, otherwise its own cell; never 100. Safe once the record is right.
7. **Other 100s found, none writes over a recorded pipe:** clone label placement (`CloneRegeneration`, text offset only), the CDPIPEOBJ test command (uses the Settings pipe size, 100 only if that is blank), split row building, the Xcivil import defaults (imports only).
8. **Still open, not new in this train:** CDSYNC takes an older pipe's old pipe data size before the stored record (branch unchanged). Only Edit Pipe updates that old data; the Pit Schedule edit writes elsewhere. So "change a size in the Pit Schedule on an older pipe, then CDSYNC" may put the older size back. Not a 100 fallback; pre-existing; Codex recipe item (review 1122 LOW 1).
9. **Drawings already hit stay at 100** until each pipe is fixed or undone; nothing repairs them (review 1126.3). Carpark line suggested, not added by me.

## 4. Tim's rules

1. **Settings-first:** no new engineering value. The 100 mm last resort was already hard-coded and is now reached less often (R-00 standing).
2. **No hard blocks:** my refusal is the same kind as the Xref and locked-layer ones: nothing is changed, the drafter is told why and what to pick instead. No switch needed (taking a CE line as a route is the bug).
3. **No blue:** no colour added anywhere in the train.
4. **Plain English with the command shown:** the new sentence names CD and answer E.
5. **Redo-safe (guardrail 8 item 17):** the train's only added drawing reads are open-close (`ReadRecordedPipeDiameter`, the CD E classifier, my attachment check). No normal transaction, view change, system variable, idle, selection or timer hook added. RedoSafe guard green on net10 and net48.
6. **CE_SHARED unchanged:** nothing under `Shared/` changed.
7. **Ruling I2 (no pop-ups that block a quick edit):** no window, message box, new prompt or held lock in the train or in my commit.

## 5. Builds and tests (build lock taken and released around every run; Below Normal; skip-bundle, -nr:false, no build servers; logs to scratch; CE log folder redirected to scratch)

1. **Whole solution Release at the final head:** 0 errors, 884 warnings (assembler 0 / 885).
2. **Civil net10 full suite:** 18,130 run, 18,110 pass, 19 skipped, 1 failed: `BackTest_GlenEira24115_Computed_WithinTolerance`, the known red on the plain base. Assembler: 18,129 / 18,109 / 19 / 1; the one extra test is mine.
3. **Manager:** 751 of 751 pass.
4. **Civil net48 focused** (AdoptedLineRoutePolicy, RecordedPipeSizeRule, RecoveredPipeSizeWiring, RedoSafe): 41 run, 41 pass (assembler 40; plus mine).
5. **Trap found, cost two short runs:** the net48 Civil tests built against the TimOS 2024 reference folder discover zero tests and still exit 0. Built against the CERef 24.3.0 folder they discover and pass. The builder brief names the TimOS folder; anyone running net48 Civil tests should use the CERef folder or check the discovered count.
6. **Not run:** CommandTruth, TestHarness, Spine, Diagnostics, AI.Core, ReleaseTests, Installer (nothing they cover changed since the assembler's green runs), Structural, accoreconsole, anything in AutoCAD.
7. **Tim's settings files, size and hash start, before and after:** `CD_Settings.json` 15,270 ACD64E79; Civil `CS_Settings.json` 351,713 622A246F; Structural `CS_Settings.json` 34,858 24D8E5F7. Unchanged. AutoCAD was not running at the start or the end; I did not start it.

## 6. What Tim will see (after the train is installed)

1. **CDSYNC** keeps every pipe's real size: a 300 stays 300 in the pipe and in the Pit Schedule. Before, every converted pipe came out as 100.
2. **Opening an older drawing whose schedule is empty or missing a pipe:** the rebuilt rows keep the real sizes, not 100.
3. **CD, answer E, on a plain drawn polyline:** accepted again ("Using the drawn line (N points) as the pipe route."), the pipe window opens.
4. **CD, answer E, on a real CE pipe:** "That line is already a CE pipe. Double-click it to change it. Nothing was changed."
5. **CD, answer E, on a Line or Circle:** "That is not a polyline." as before.
6. **CD, answer E, on a polyline CE registered to a pipe, pit or source** (older or imported drawings only): "That line is part of a CE pipe, pit or source ... Nothing was changed." and the line stays.

## 7. Codex recipe additions

1. CDSYNC on the driver run 25 test copy; the Pit Schedule matches the baseline sizes.
2. A copy with the schedule data removed, reopen: sizes not 100.
3. CD E on a plain open line, a closed rectangle, a real CE pipe and a Line.
4. An older pipe whose size was changed in the Pit Schedule, then CDSYNC: does the new size survive?
5. On a drawing already hit by the bug: open and save one pipe in Edit Pipe; does its size come back from the label?

## 8. Top risks

1. **Drawings already at 100 are not repaired** (MEDIUM for Tim's own drawings hit on the installed build; nothing in the train fixes them).
2. **Older pipe data size wins in CDSYNC** (LOW, pre-existing, Codex item 7.4).
3. **All three fixes are proven by pure-rule tests and source guards only;** the drawing-level proof is the Codex pass.
