1. **ANSWER FIRST — 3 new findings: HIGH 1 / MEDIUM 2 / LOW 0.** All three are SURE, verified by reading the specified source. No AutoCAD test was run. Date: 24 October 2026, Melbourne.

2. **Most important — Structural can put undone footing sizes back.** Undo removes a new thickening and its saved size from the drawing, but CE keeps the old size in memory. Making another thickening can save the undone size back; reusing the original number can silently reuse that size.

3. **Second — cancelling a Structural thickening can leave changes behind.** Escape before choosing its centre still saves its size. Escape at the later text-position question leaves an unlabelled outline as well.

4. **Third — cancelling Civil spot-level placement can change an otherwise untouched drawing.** On first use, CE imports the spot-level block before asking for its position. Escape leaves that unused block definition in the drawing, even though no symbol was placed.

---

1. **Scope and evidence.** Read-only independent source audit of Undo, Redo and unwanted drawing writes. Civil/Manager: `origin/claude/rel-20261023m`, commit `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`. Structural: `origin/claude/rel-20261023s`, commit `e6d597c0fbc25e78118760887a70810e0890c9a9`. These are source identities, not verification of the DLLs currently installed.

   Source was read with Git from a detached worktree at `C:\ce-cx\rd18`; Structural files were read directly from its specified remote ref. That clean worktree was removed after reading. No code branch, source edit, build, test, installation, AutoCAD session or sub-agent was used.

   Before selecting findings, searched `BUG_CARPARK.md` through BUG-1087 and read `AUDIT_C58_C60_S40_S41_2026-10-22.md`, the Civil, Structural and Gate `CODEX_AUDIT_*_22OCT.md` reports, and `CODEX_HUNT_UNDO_22OCT.md`. Findings below concern distinct writes, not another report of common command initialisation or empty Undo marks.

2. **RD18-01 — HIGH — SURE / VERIFIED-BY-READING: Structural keeps and later re-saves sizes that Undo removed.**

   **What the drafter sees:** after undoing a 600 x 600 mm thickening, its saved size can return when another thickening is made. Reusing its number can draw the old size without asking again. This risks wrong geometry and silently restoring discarded library data.

   **File and line:** `Modules/Structural/Services/CeTextService.cs:24`, `:2167`, `:2196`, `:5544`, `:5559`, `:5574`; `Modules/Structural/Services/FstMemoryService.cs:88`, `:106`, `:118`. All lines refer to the Structural commit above.

   **Exact failure path:** `GetFstData` loads the drawing's size library only on a cache miss. Later calls return the private static `FstCacheByDrawing` entry. There is no removal or invalidation of that dictionary on Undo, Redo, library edits or drawing close. Its usual key is the filename.

   `TryGetOrPromptRectSize` returns an existing cached size without prompting. For a new number it changes that same cached library and calls `SaveFstData`. `FstMemoryService.Save` writes every size bucket, including `FST_DATA/TH_MEMORY`, then commits. AutoCAD undoing a drawing record does not reverse this separate managed dictionary. Thus the next save can resurrect the undone entry, not merely suggest an old default. The FST window separately loads/saves the drawing library (`FoundationService.cs:1173`, `:1189`) without refreshing this cache.

   **Deterministic test — fixture:** use a new synthetic, uniquely named millimetre drawing in a fresh AutoCAD process. Model space, World UCS, `INSUNITS=4`, `DIMSCALE=50`, `LTSCALE=500`; required CE layers and HIDDEN linetype already present and unlocked. No footing system or existing geometry on `SLAB INTERNAL BEAM`. Library keys 81 and 82 absent. Save all fixture preparation before the test. A read-only observer must capture `FST_DATA/TH_MEMORY` and entity geometry without starting another drawing command.

   **Typed steps:** run `THCL`; enter `81`; answer `N` to column-over text; enter X `600`, Y `600`; centre `0,0`; desired text insertion `500,500`. Confirm the command has finished. Type `U` once. Assert the new outline/text and library key 81 have gone. If they have not, stop and record that separate Undo failure; do not proceed as though this precondition passed.

   Run `THCL`; enter `82`, `N`, X `900`, Y `900`, centre `2000,0`, text insertion `2500,500`. Read the same library record. **Required assertion:** key 82 has 900/900 and key 81 remains absent. **Predicted failure from source:** both 81=600/600 and 82=900/900 are saved. A separate fresh run that reuses 81 immediately after Undo should ask for X/Y again; the inspected code instead reuses cached 600/600.

   **Smallest fix:** read the current drawing library for each lookup and merge only the newly accepted entry into a fresh library before saving. Remove the long-lived drawing-data cache, or comprehensively invalidate it on history changes, library saves and document close. Never repair the library by writing during Undo/Redo.

   **Evidence boundary:** the stale-cache and whole-library write paths are proven from source. Actual native Undo grouping and the expected drawing snapshots remain untested. This finding concerns an explicit later placement after Undo; it does not claim a background write during an otherwise idle U-to-REDO interval.

3. **RD18-02 — MEDIUM — SURE / VERIFIED-BY-READING: Escape from THCL leaves a saved size, and later Escape leaves an unlabelled outline.**

   **What the drafter sees:** cancelling before placing anything still changes the drawing's saved sizes. Cancelling at the text-position question leaves a real thickening outline with no label. The drafter must undo a command they thought they cancelled.

   **File and line:** `Modules/Structural/Commands/CeTextCommands.cs:54`; `Modules/Structural/Services/CeTextService.cs:1107`, `:1118`, `:1195`, `:1232`, `:2197`, `:2324`; `Modules/Structural/Services/FstMemoryService.cs:118`; `Modules/Structural/Services/CommandExecutionService.cs:110`.

   **Exact failure path:** THCL calls `ExecuteRectWithText`. It asks for sizes and commits `SaveFstData` before asking for the centre. A cancelled centre returns immediately without undoing the saved record. After an accepted centre, `CreateCenteredRectangle` commits a real polyline before the desired text-insertion question. Cancelling that question again returns without removing the outline. The command wrapper restores system state; it does not roll back these committed drawing changes on an ordinary return.

   These are two cancellation points in the same placement path, counted as one finding. The THCL fixture avoids the separately documented strip-layer migration. Existing entities are absent so automatic trimming is not involved.

   **Deterministic test — fixture:** two independent fresh copies of the RD18-01 fixture, with unique filenames and no cached library entries. Capture the initial entity set, `FST_DATA/TH_MEMORY` and `DBMOD` after saving. Read-only observation must not create a new Undo step.

   **Typed steps, early Escape:** `THCL`, `81`, `N`, X `600`, Y `600`; press Escape at `Specify insertion point (center):`. **Required assertions:** no new entities, key 81 absent, drawing modification state unchanged. **Predicted failure:** there are no new entities, but key 81=600/600 has already been committed. An entity-count-only test misses this fault.

   **Typed steps, late Escape:** in the second fresh fixture, `THCL`, `82`, `N`, X `900`, Y `900`, centre `2000,0`; press Escape at `Pick desired text insertion point:`. The square avoids the additional-rotation prompt. **Required assertions:** original entity set and library restored. **Predicted failure:** a closed 900 x 900 mm polyline remains on `SLAB INTERNAL BEAM`, key 82 is saved, and its TH82 label is absent. Record the subsequent `U` echo and verify whether one U removes all leftovers; that native check has not been run.

   **Smallest fix:** defer persistent size saving and geometry creation until all placement inputs are accepted. Use transient geometry for preview, then commit the outline, label and library change together. Escape before acceptance must leave none of them. The stale-cache correction in RD18-01 is separately necessary.

   **Evidence boundary:** both commits precede their cancellation returns in source. The exact Save-changes prompt and number of native Undo steps still require AutoCAD verification; neither is claimed as an observed result.

4. **RD18-03 — MEDIUM — SURE / VERIFIED-BY-READING: cancelling the first CDSL placement leaves an imported block definition.**

   **What the drafter sees:** they start placing a spot level and press Escape without placing one. The drawing nevertheless acquires an unused SPOT LEVEL block definition. That is a real drawing change and can require saving a drawing that appears untouched.

   **File and line:** `Modules/Drainage/Commands/SpotLevelCommand.cs:56`, `:77`, `:83`; `Modules/Drainage/Services/BlockService.cs:451`, `:458`, `:476`, `:689`. Lines refer to the Civil commit above.

   **Exact failure path:** `PlaceSpotLevel` calls `EnsureBlockDefinition` before the first placement prompt. When SPOT LEVEL is absent and its asset file exists, the service opens the source drawing, calls `InsertQuietly`, and commits. `InsertQuietly` calls the target drawing's `db.Insert`; quiet command output does not make the import temporary. Cancelling `TryPreparePromptedBlockPlacement` then prints `CDSL command cancelled.` and returns, with no removal or rollback of the imported definition.

   This finding is specifically the block-table import. Common drawing activation, project-data synchronisation and layer creation are excluded from its count. The later change that deferred the actual block reference until after the level answer does not defer this earlier definition import.

   **Deterministic test — fixture:** a saved synthetic Civil millimetre drawing, already CE-active with project data in sync, default `25DIMS` layer present and unlocked, but no block-table record named `SPOT LEVEL`. A valid synthetic `SPOT LEVEL.dwg` must be available in the plugin's normal asset search location. Save setup first; capture block-table names, model-space entity count and DBMOD. Use a read-only observer, not a CE inspection command.

   **Typed steps:** type `CDSL`; press Escape at `Specify spot level insertion point:`. **Required assertions:** command line contains `CDSL command cancelled.`; model-space entity count is unchanged; block-table names are unchanged and SPOT LEVEL is absent. **Predicted failure:** the entity count is unchanged but SPOT LEVEL now exists; the CE log contains `Loaded block 'SPOT LEVEL' from:` before cancellation.

   Record DBMOD and the result of `CLOSE` on this clean fixture, cancelling any save question. The imported definition is the decisive assertion: a Save-changes prompt alone cannot separate this fault from the already-known initialisation writes. Repeat with the definition already present as a control for the import branch.

   **Smallest fix:** check/load the asset in a detached source database for availability and preview; import its definition into the drawing only after the insertion point and level have been accepted, with the accepted placement. Alternatively keep the import inside a genuinely rollback-capable operation that aborts on cancellation. Do not purge arbitrary blocks to clean up afterwards.

   **Evidence boundary:** the import and cancellation ordering are verified from source. Native DBMOD, Save-changes and Undo/Redo behaviour were not exercised.

5. **Known exclusions — identifiers only.** BUG-183; BUG-256; BUG-334; BUG-358; BUG-367; BUG-373; BUG-381; BUG-418; BUG-564; BUG-646; BUG-650; BUG-793; BUG-810; BUG-817; BUG-861; BUG-874; BUG-892; BUG-1030; BUG-1070; BUG-1085; BUG-1086.

6. **What was checked and what was not.** Read drawing-write and transaction paths, command cancellation returns, size-library persistence, relevant Civil/Structural history guards, document/idle/save handlers and prior audit exclusions. Traced the three new findings through their actual drawing writes. No additional SURE background write strictly between an idle U and REDO was established; that is not a clean bill of health.

   Did not execute the proposed fixtures, run unit tests or builds, inspect installed binaries, open AutoCAD, measure actual DBMOD/Undo marks, test every command, or assess Manager administrator work. The proposed observers are test requirements, not tools built or run in this audit. No UNSURE candidate is included in the three-finding count. No new hard block or engineering default is proposed.

7. **Summary.** Three new source-proven faults remain: Structural can restore discarded size-library entries after Undo, cancelled Structural placement commits sizes and sometimes an outline, and cancelled Civil spot-level placement imports a block definition. The report supplies deterministic native tests and minimal fix directions. Real AutoCAD confirmation is outstanding. Only this findings file is delivered; plugin source and the bug, desk and queue files remain untouched by this audit.
