# RD17 — Pit Schedule and network editing audit — 24 October 2026, Melbourne

1. **ANSWER FIRST — HIGH 1 / MEDIUM 2 / LOW 0.** Three new findings, all SURE about the source fault and verified-by-reading. No AutoCAD reproduction is claimed. Proposed tests below were not run.

2. **Most important — a refresh can remove a necessary step-irons note.** With two pipes leaving a pit, the window can show 1.10 m depth and “With Step Irons”, but the drawn schedule's refresh calculates 0.80 m and removes the note. It overlooks the lower second pipe.

3. **Second — updating one schedule can change another schedule's heading.** The new depth heading is written into a shared block definition. An older copy can acquire “PIT DEPTH (m)” while keeping its old depth-to-outlet figures, including when that copy is on a locked layer.

4. **Third — cancelling an export still changes the drawing's saved records.** Click Export CSV or Export Excel, then Cancel: CE has already saved the schedule's row order. This can contribute to the unwanted Save changes question even though no schedule cell was edited and no export was produced.

5. **For the release team.** Fix the three paths below and run their synthetic drawing checks before calling them accepted. No code, drawing, setting, bug register or release queue was changed by this audit.

---

1. **Source and scope.** Area E/L: Pit Schedule, Edit Pit, Edit Pipe, batch edit, renumbering and relinking. Fetched origin and used Git objects in the audit's own detached worktree, `C:\ce-cx\rd17`. No code branch or code commit was created. Civil/Manager source: `origin/claude/rel-20261023m`, `f7f7d551552c21db3058ed839abacd1ec8a3b4d4` (manifest release 3.0.72 / 1.1.72). All source line numbers below refer to that commit. The earlier `origin/claude/rel-20261022m` was used for comparison. Structural reference resolves to `origin/claude/rel-20261023s`, `e6d597c0fbc25e78118760887a70810e0890c9a9`; Structural implementation is outside this audit. Installed DLLs were not inspected.

2. **Deduplication and limits.** Grepped `BUG_CARPARK.md`, whose allocation marker was BUG-1088, and consulted `AUDIT_C58_C60_S40_S41_2026-10-22.md` and the existing `CODEX_AUDIT_*_22OCT.md` reports. Findings are limited to concrete source paths; no speculative AutoCAD event ordering is counted. R-27 and R-00 were retained; this report proposes no new engineering limit and no Manager administrator work.

3. **Evidence terms.** SURE / verified-by-reading establishes the control flow and calculation, not a native PASS or FAIL. Every fixture below is a specification for a future tester to create on a disposable synthetic drawing. None was created here. Assertions use recorded values, drawing text or CE log lines; a green isolated helper test is not enough.

## Ranked findings

1. **RD17-01 — HIGH — Refresh ignores a lower second outgoing pipe when calculating pit depth and step irons. SURE; verified-by-reading.**

   **What the drafter sees:** a schedule that showed 1.10 m and “With Step Irons” can change to 0.80 m without that note after an ordinary pit edit. Reopening the schedule window shows 1.10 m again. The drawing and window disagree about the same pit.

   **File:line:** `Modules/Drainage/Services/ScheduleLinkService.cs:2743`, `:2759`, especially `:2767`; note generation at `:2920`. The differing window inputs come from `Services/PitScheduleBuilder.cs:666` and `:673`, then `ViewModels/PitScheduleViewModel.Data.cs:325`, `:371`, `:2152`.

   **Exact failure:** the window puts every connected pipe except the chosen outlet into its remaining rows, then sorts those pipes by their level at the pit. This includes an additional outgoing pipe. Its primary row therefore supplies the lowest remaining level to the new floor-depth rule. The automatic drawn-cell writer instead calls `LowestInletInvertText`, which accepts only records whose `To` equals the pit number. Every additional outgoing pipe has the pit in `From`, so it is omitted. Both routes call the same arithmetic rule with different inputs.

   **Concrete numbers:** P2 cover RL 11.00 m, recorded floor RL 10.20 m; chosen outlet P2 to P3 leaves at RL 10.40 m; second outlet P2 to P4 leaves at RL 9.90 m. The window uses min(10.20, 10.40, 9.90) and shows 1.10 m. Refresh uses min(10.20, 10.40) and writes 0.80 m. At the existing 900 mm step-irons setting, the note disappears. A pipe recorded below the floor is exactly the inconsistent-record case the new rule says it handles by using the lower pipe (`Rules/PitScheduleDepthRule.cs:49–63`). No new judgement about a permitted sump or pipe arrangement is needed.

   **Why the refresh is reachable:** `BuildCellText` passes the chosen outlet and the saved depth-adoption flag at `ScheduleLinkService.cs:2043–2050`. Depth checks the chosen outlet's side, not the second pipe's side (`:3077–3085`); the chosen P2-to-P3 outlet passes. Edit Pit explicitly refreshes linked cells at `Commands/PitEditCommand.cs:437–439`. The new floor path was added after the 22 October comparison head.

   **DETERMINISTIC TEST — fixture:** millimetre model-space drawing, ordinary 600 x 600 mm pits P2/P3/P4, two valid linked 225 mm pipes leaving P2 with the numbers above, far-end levels 10.30 and 9.80 m respectively. Both pipes are included in Main. Persist the P2 outlet selection as the P2-to-P3 pipe; use distinct handles and valid reciprocal links. Enable the existing floor-depth setting and leave the step-irons value at 900 mm. Provide a valid owned placed schedule whose P2 depth and remarks cells have `UsesPitFloorDepth=true`, initially 1.10 and “With Step Irons”. No manual cell overrides, protected layers or missing labels.

   **Typed steps:** type `PITSCHEDULE`; read P2's depth and remarks, then Close. Type `PITEDIT`, select the P2 body, change only Plan length from 600 to 900 mm and save. Read the P2 depth and remarks text entities on the drawing. Reopen `PITSCHEDULE` and compare P2. The length edit supplies a normal refresh trigger without altering the stated levels.

   **Assertions:** placed depth remains 1.10; placed remarks retain “With Step Irons”; window and drawing agree; all four pipe-end levels and P2's floor remain unchanged. The inspected refresh code produces 0.80 and removes the generated phrase. Also compare the real window builder with `BuildCellText` on this fixture; testing `DepthText` alone misses the different pipe sets. Repeat with the lower pipe arriving at P2 as a control, where both paths include it.

   **Smallest fix:** give the drawn depth/note calculation the same complete, correctly scoped connected-pipe levels as the window, including additional outgoing pipes, while keeping the chosen outlet separate. Reuse a pure shared selection rule so automatic refresh needs no new drawing transaction. Preserve the per-cell opt-in for older schedules.

2. **RD17-02 — MEDIUM — Depth-heading migration changes shared definition text outside the selected schedule. SURE for shared-definition fixtures; verified-by-reading.**

   **What the drafter sees:** updating the working schedule can also rename the depth heading on an older copy kept elsewhere on the drawing. That copy's numbers remain depth-to-outlet values. Locking the older copy's layer does not protect text held in an unlocked shared definition.

   **File:line:** `Modules/Drainage/ViewModels/PitScheduleViewModel.Schedule.cs:1109–1111`, `:1256`, `:1491–1513`; protection check at `:1518–1530`. The old/new depth distinction is stored per cell in `Services/ScheduleLinkService.cs:93` and used at `:2043–2048`.

   **Exact failure:** `UpdatePitDepthHeadingInTransaction` starts at the selected reference's `BlockTableRecord`, traverses nested block definitions and changes matching DBText/MText in those definitions. It neither makes the heading unique to the selected schedule nor checks other references to those definitions. Its protection check examines the definition text's own layer. This is a shared-object write, even though the surrounding update checks only the selected authority and its continuations. Other schedules' separate cell records are not adopted or rewritten by that operation.

   **DETERMINISTIC TEST — fixture:** two schedule frames A and B in the same drawing. A is the valid owned authority offered for update; B is an older comparison copy, not an owned continuation. Use a shared static heading definition, referenced by both frames, containing DBText `DEPTH TO OUTLET` on unlocked layer 0. This is also valid as a nested heading in dynamic frames: make the shared child definition explicit so the test does not depend on AutoCAD's anonymous-block reuse. B and its separate numeric text are on locked layer `AUDIT-OLD-SCHEDULE`. A and B initially contain depth 0.85 for cover 11.00, outlet 10.15 and recorded floor 10.05. Their old cell flags are false. The floor-depth setting is ON. Record the shared heading ObjectId before the operation.

   **Typed steps:** type `PITSCHEDULE`; choose the current drawing and Main; click `Continue to Place / update`, then the enabled update action for A. Accept the reviewed A update. Type `REGEN`. Inspect the heading text reached through A and through B, and inspect B's depth text and layer lock.

   **Assertions:** A becomes “PIT DEPTH (m)” with 0.95. B remains “DEPTH TO OUTLET” with 0.85 and its lock stays set. The current writer changes the shared heading object to “PIT DEPTH (m)”, so B also acquires that heading despite retaining 0.85. Verify the definition object's TextString directly as well as its displayed references. One `U` must restore the complete pre-update fixture; do not infer that from the transaction alone.

   **Smallest fix:** isolate the heading representation for the selected schedule and its owned continuations before changing it; use a private definition or an instance-owned heading. Do not rewrite a shared nested definition or silently update other schedules to make their numbers fit the new caption. Include an unrelated locked reference in the regression fixture.

3. **RD17-03 — MEDIUM — Export writes drawing records before the file chooser, including Cancel. SURE; verified-by-reading.**

   **What the drafter sees:** after merely trying to export a schedule and cancelling the file chooser, closing the drawing can ask to save changes. The drawing's geometry looks untouched, but its saved schedule record has changed.

   **File:line:** `Modules/Drainage/ViewModels/PitScheduleViewModel.Schedule.cs:46–65` and `:106–126`; `ViewModels/PitScheduleViewModel.Filters.cs:491–534`; `Services/ProjectDataService.Mutations.cs:1740–1759`; `Services/ProjectDataService.Persistence.cs:425–458`, `:1099–1126`.

   **Exact failure:** both export handlers call `PersistManualRows()` and `FlushPendingSave()` before checking for rows or opening `SaveFileDialog`. Persistence rebuilds the linked-row sort map for all rows and invokes both project setters, which save unconditionally. The flush writes the drawing's project Xrecord. Only afterwards can the user choose Cancel. There is no rollback. A previously empty sort map becomes populated even when nothing was edited in the window, so this is an actual record change, independent of native empty command markers.

   **DETERMINISTIC TEST — fixture:** saved clean synthetic Civil drawing containing one valid scheduled pit P1 and an embedded project record. Use no manual rows and an empty `LinkedRowSortOrder`. Ensure the CE in-memory record matches the saved record, with no outstanding save or repair, and capture the original project Xrecord and DBMOD before starting. Keep the Inspector closed and autosave outside the test interval. Test CSV and Excel on separate fresh copies.

   **Typed steps:** type `PITSCHEDULE`; edit nothing. Note the current CE log position. Click `Export CSV`, then Cancel in the file chooser. Capture the embedded project record immediately, while the schedule window remains open, to isolate the export from the window's separate close handler. Repeat on the second copy with `Export Excel`. Then Close the schedule and type `CLOSE`; record the Save changes question and answer No.

   **Assertions:** cancelling creates no export file and makes no project Xrecord write; the sort map stays empty and the original record bytes remain unchanged. There must be no export-caused `Project data saved to DWG successfully` line between the click and Cancel. Current code instead fills the map with P1's linked-row key and saves before displaying the chooser. Record DBMOD and the close question as native confirmation, not as a substitute for the record assertion. A successful export should likewise not require a drawing write merely to produce an external file.

   **Smallest fix:** export a detached snapshot of the displayed rows without persisting them or the row order. Keep accepted editing persistence in its editing action. Moving the flush past the file chooser only fixes Cancel; removing export's unnecessary drawing mutation fixes both paths.

## Known issues excluded from the new count

1. **BUG-817; BUG-791; BUG-1011; BUG-1031.**
2. **BUG-664; BUG-674; BUG-676; BUG-677; BUG-685; BUG-687; BUG-688; BUG-689.**
3. **BUG-780; BUG-785; BUG-786; BUG-787; BUG-965; BUG-968; BUG-981; BUG-1005; BUG-1008; BUG-1009; BUG-1022; BUG-1023; BUG-1049.**

## What was not checked

1. **No execution.** No build, unit test, AutoCAD/core-console run, render, installation or deployment. Test counts: zero run. No window appearance, native Undo/Redo behaviour, save prompt or proposed fixture is claimed as observed. No bug is marked fixed or accepted.
2. **Bounded code review.** Traced schedule loading, overrides, export, depth/heading updates and supporting writes; read the renumber apply path, relevant single-editor writes, batch coordination and relink level/mark handling. This was not an exhaustive proof of every editor option, reactor, native pipe-object route, damaged-record combination, UCS, unit, Xref or concurrent drawing-switch case.
3. **Release limits.** No current Settings, installed DLL, customer drawing, Manager administrator feature or Structural workflow was inspected. Native checks on AutoCAD 2024/net48 and 2027/net10 remain outstanding; repeat the synthetic cases on both. The specified release labels are source labels, not independently verified installation facts.
4. **Repository handling.** Only this findings file is authorised for authorship and commit in CE_PLAN. The temporary detached code worktree is to be removed after the review. Other sessions' modified/untracked plan files are outside this commit. No BUG_CARPARK, DESK_LOG or QUEUE edit is part of this audit.

## Summary

1. **Three new faults: one HIGH and two MEDIUM.** Refresh can overlook a lower second outlet and remove the step-irons note. Heading migration can alter another schedule through a shared definition. Cancelling an export still saves schedule records into the drawing. Each has source locations, a smallest fix and a deterministic synthetic AutoCAD check. Known issues were excluded. Nothing was built, tested, installed or accepted; only this report was authored.
