1. **ANSWER FIRST — HIGH: 2; MEDIUM: 2; LOW: 0.** The most important fault is **CDJOINT deleting the existing slab joints before the replacement questions are finished**. Accept regeneration, then press Esc at the slab-type question: the old joints have already been erased. The other findings are a pit edit saving the wrong position and putting new cover text away from its pit in a shifted UCS, a metre-drawing raingarden losing its last corner, and a short fall-direction pick producing an east-pointing arrow instead of the chosen direction.

2. **What this means for Tim.** These are four specific drawing faults, not style comments. All four are **verified-by-reading**, with repeatable AutoCAD tests specified below. They have **not** been reproduced in AutoCAD during this hunt. No build, test, installation, source change or sub-agent work was performed. There are no suspected-only findings in the counts.

---

3. **Scope and evidence — 23 October 2026, Melbourne.** Read-only S09 sweep of all 132 command files named in the brief, starting with the largest central command files, followed by focused tracing through the supporting services for the retained findings. Source authority: `C:\Lisp Files\CE_ACAD_PLUGIN`, `origin/claude/rel-20261022m`, fetched commit `40ee0a36f7960145743954b39859eb6c3af92869`. The brief identifies this release as Civil 3.0.70 / Manager 1.1.70; this hunt did not inspect installed binaries. Every source line below refers to that commit, not the current working tree. Structural was outside S09.

   The prior `AUDIT_C58_C60_S40_S41_2026-10-22.md` and available `CODEX_AUDIT_*_22OCT.md` reports were read first. Earlier relevant hunt reports were also checked for overlap. Existing findings about ignored checks, tidy previews, deferred labels on cancellation, locked-label partial pit edits, detention identifiers and import recovery are not repeated here. This is a risk sweep with detailed traces for the four findings, not a claim that every possible command path is sound.

4. **S09-01 — HIGH — Regenerating slab joints deletes the old drawing before a later cancellation. Status: verified-by-reading.**

   **File:line:** `Modules/Drainage/Commands/CdJointCommand.cs:94`, `:100`, `:223`, `:250`, `:528`.

   **In AutoCAD:** A drafter asks to regenerate a slab's joints, accepts the clear-and-regenerate question, then changes their mind at the next question. The original joint lines and labels disappear even though no replacement was accepted or drawn. Ordinary Undo may recover them; this finding does not claim that Undo is broken. The defect is cancellation leaving the drawing changed.

   **Exact failure scenario:** The selected registered slab already has joint segments. At `Clear and regenerate? [Yes/No] <Yes>`, answer Yes. Press Esc at `Enter selection [1-.../C]`, or choose C and press Esc at `Enter custom joint spacing (mm)`. A second path reaches the same loss when a valid but larger-than-slab spacing generates no segments.

   **Proof:** Lines 77–95 offer regeneration, call `EraseJoints`, then clear the in-memory segment list. `EraseJoints` opens the recorded line and label handles for write, erases them and **commits its own transaction** at line 528. Only afterwards do lines 99–101 ask for the slab type/spacing. Cancellation returns zero at line 223 or 250 and exits at line 101. New joints and the replacement slab record are not written until lines 117–127. The zero-segment path exits at lines 109–112 after deletion too. `SlabService.LoadSlabs` reads a deserialised list from the drawing dictionary; clearing that local list does not update the stored list. `SlabService.StoreSlabs` is never reached on these exits. The drawing can therefore contain erased joint handles still listed in its slab record.

   **DETERMINISTIC TEST — fixture:** In an isolated test copy, use millimetres, World UCS and unlocked layers. Prepare registered slab S1 with closed rectangular boundary `(0,0)`, `(9000,0)`, `(9000,6000)`, `(0,6000)`, no pits or spoon drains. Run CDJOINT, select S1, choose C and enter 3000. Capture the resulting joint line/label handles, geometry, text and saved S1 joint list as the baseline. The grid should contain three joint segments; use the captured handles as the primary oracle.

   **Typed steps:** Run CDJOINT again; select S1; answer Yes; press Esc at the slab-type selection. Repeat from a fresh baseline copy, choosing C and pressing Esc at the spacing prompt. A third independent copy can use C then 12000 to exercise the empty-grid return.

   **Assertion:** After either cancellation, every baseline line and label must still be live with unchanged geometry/text; the saved S1 joint list must describe those same live entities. At this ref the erase transaction has already committed, so those handles resolve as erased while the saved list retains them. For the third case, capture the command-line text `No SC joints generated - slab may be smaller than one panel spacing.` and assert the old joints still exist; the current ordering fails that assertion too. These are assertions on the drawing immediately after CDJOINT returns, before issuing Undo or another CE command.

   **Correction direction:** Complete the replacement questions and construct a usable replacement plan before deleting anything. Apply the old-joint removal, replacement entities and stored slab list as one recoverable operation. This requires no new engineering hard block.

5. **S09-02 — HIGH — Editing a pit in a shifted UCS transforms its already-world position a second time. Status: verified-by-reading.**

   **File:line:** `Modules/Drainage/Commands/PitEditCommand.cs:133`, `:632`, `:1790`, `:1839`, `:1473`, `:1889`.

   **In AutoCAD:** A drafter edits an existing pit while working around a local drawing origin. The pit block stays in place, but the edit writes a different position into the CE pit record. If the edit creates missing cover text, that text is placed away from the pit by the UCS displacement. The command can still report `Pit updated.` This affects an ordinary single-pit edit, without requiring batch editing, locked layers or an Xref.

   **Exact failure scenario:** A pit is already at world position `(10000,20000,0)` in a millimetre drawing. Set a parallel UCS with its origin at that world position. Run PITEDIT on that pit, enter a cover level and save. If cover text is absent, accept its default corner with Enter. The pit record is constructed with `(20000,40000,0)`, despite the unchanged block being at `(10000,20000,0)`. New cover text receives the same extra displacement relative to an otherwise identical World-UCS edit.

   **Proof:** Line 133 gets `pitPosition` directly from `BlockReference.Position`, which is a world position. `ApplyPitEdit` passes it to `BuildPitData` at line 632. Line 1790 calls `DrawingService.TransformToWorld(centerPoint)` again, and line 1839 assigns that result to `PitData.Position`. The supporting `DrawingService.cs:53`–`:66` applies the editor's UCS matrix; it is not an identity conversion when the origin is shifted. `ProjectDataService.AddPit` receives the erroneous row at line 635; the successful command explicitly flushes its pending save at line 437 before resuming runtime linking at line 458.

   The missing-cover path passes the same world centre to `CreatePitCoverText` at line 1473. That method calculates the corner from the world centre at line 1881, transforms it again at line 1889 and assigns it to `MText.Location` at line 1897. Registering the attachment does not undo that calculation. The preflight warning about a non-World UCS does not reset the UCS. This report makes no claim about whether a later drawing synchronisation might repair the stored position; the erroneous record write and cover placement are present in the edit itself.

   **DETERMINISTIC TEST — fixture:** Prepare two identical isolated millimetre drawing copies. Each has one registered, unrotated, unit-scale 600 mm square grated pit P1 at world `(10000,20000,0)`, an existing number label, no cover-text attachment, no connected pipes and no schedule table. Its recorded position matches the block; cover level is blank; the default cover-text corner is BR. All relevant layers are unlocked. Use the same pit cover-text gap setting in both copies; set 100 mm through Settings in the isolated test profile. All coordinates below are drawing millimetres.

   **Typed/window steps:** In control copy A, type `UCS`, `World`, then PITEDIT and select P1. Enter cover level `10.10`, enable `Cover level text on plan`, click the footer **Save**, then press Enter at `Click near pit to place cover text (Enter = <BR>)`. Capture P1's world block position, the newly created cover MText world location L and the saved pit record. In fresh copy B, type `UCS`, `World`, then `UCS`, `Origin`, `10000,20000,0`. Perform the identical PITEDIT, Save and Enter sequence. Inspect coordinates in World UCS afterwards without running another CE synchronisation command.

   **Assertion:** Both copies must have P1's block and saved record at `(10000,20000,0)`, and the cover text at the same world location L. At this ref, copy B constructs and saves record position `(20000,40000,0)` and creates the cover text at `L + (10000,20000,0)`, while its pit block remains unmoved. Capture `Pit updated.` as evidence that the command reported success. The cover-position comparison is the visible drawing oracle; capture the record at the command's save flush as well as after command completion to distinguish the faulty write from any subsequent reactor repair.

   **Correction direction:** Keep existing block positions and points derived from them in world coordinates throughout editing and saving. Convert actual user-picked UCS points once at the prompt boundary. Preserve the ability to work in a local UCS.

6. **S09-03 — MEDIUM — A metre-drawing raingarden closes within 1 m and discards a legitimate final corner. Status: verified-by-reading.**

   **File:line:** `Modules/Drainage/Commands/SourceBlockInsertCommands.cs:495`–`:507`, `:588`, `:608`.

   **In AutoCAD:** Drawing a narrow rectangular raingarden in metres can finish as a triangle. Its area is then saved and reported as half the intended area. The command reports successful placement, with no explanation that the fourth point was discarded.

   **Exact failure scenario:** Use a metre drawing and enter four successive corners `(0,0)`, `(4,0)`, `(4,0.5)`, `(0,0.5)`. The last corner is 0.5 m from the first. It is a distinct corner, but the command treats it as a snap back to the start and closes the three-point polygon before adding it.

   **Proof:** The CDRG drag path holds world-plan points in drawing units. Line 495 declares `SnapClosureTolerance = 1.0` with the comment `1 mm in drawing units`, but performs no unit conversion. Once three points exist, lines 498–503 compare the squared distance to 1 and break before `pointsWcs.Add(wcs)` at line 507. In a metre drawing the tolerance is therefore 1 m. The area calculation later correctly receives `doc.Database.Insunits` at line 588, but it only sees the already-truncated vertex list. `RaingardenPlacementPlan` accepts the nonzero-area triangle and calculates 1.0 m²; it cannot recover the discarded corner. Line 608 reports the resulting vertex count and area.

   **DETERMINISTIC TEST — fixture:** Empty isolated Civil model-space drawing, World UCS, `INSUNITS=6` (metres), `DYNMODE=0`, `OSMODE=0`, unlocked layers, no existing raingardens. Use ordinary absolute coordinate input.

   **Typed steps:** Run CDRG. Enter `0,0`, `4,0`, `4,0.5`, `0,0.5` at its successive point prompts. After the fourth point, the expected next action is still the polygon prompt: type Close, then Skip at `Add a GIO source to this raingarden? [Place/Skip] <Skip>`. At this ref the fourth point instead takes the command straight to that GIO question; capture that transition and answer Skip there. Do not send Close blindly to the wrong prompt.

   **Assertion:** The boundary must contain four vertices and have area 2.0 m², the saved raingarden area must be 2.0 m², and completion must report `4 vertices, 2.0 m²`. The current path produces three vertices and area 1.0 m², with completion containing `3 vertices, 1.0 m²`. Control: repeat in a fresh millimetre drawing (`INSUNITS=4`) with coordinates `(0,0)`, `(4000,0)`, `(4000,500)`, `(0,500)`, then Close and Skip. The physically identical rectangle should have the same four vertices and 2.0 m² area in both drawings.

   **Correction direction:** Express the intended closing tolerance in drawing units using the drawing's unit conversion. A distinct fourth corner must not be silently consumed by a metre-wide closing radius.

7. **S09-04 — MEDIUM — A fall direction picked within 1 m defaults to east in a metre drawing. Status: verified-by-reading.**

   **File:line:** `Modules/Drainage/Commands/FallCommand.cs:83`–`:99`, `:108`, `:138`; supporting log at `Modules/Drainage/Services/BlockService.cs:1963`.

   **In AutoCAD:** A drafter picks north, south or west near the fall symbol, but gets an east-pointing fall indication. In a metre drawing a perfectly usable direction pick 500 mm away is silently treated as though it provided no direction. That can communicate the wrong drainage direction on the plan.

   **Exact failure scenario:** In World UCS in a metre drawing, run CDFALL with insertion `(0,0)` and direction `(0,0.5)`, then enter fall ratio 80. Those are distinct points giving due north, but the command selects an angle of zero rather than 90 degrees.

   **Proof:** Lines 83–85 calculate the direction vector between world positions in drawing units. Lines 97–99 use `Atan2` only when `direction.Length > 1.0`; otherwise they select `0.0`. No drawing-unit conversion or direction re-prompt occurs. Exactly 1 m also takes the zero-angle branch. The cardinal snapping at line 108 preserves zero, and line 138 sends it to `ApplyFallBlockOrientation`. This finding is about the distance threshold before block orientation, not the previously discussed FALL flip-state/orientation implementation.

   **DETERMINISTIC TEST — fixture:** Empty isolated Civil metre drawing (`INSUNITS=6`), World UCS, `DYNMODE=0`, `OSMODE=0`, unlocked layers, and the normal supplied FALL symbol definition. Enable the normal CE information log in the isolated profile. Use separate fresh drawing copies for each case so an existing symbol cannot affect selection or placement.

   **Typed steps:** Case A: CDFALL; insertion `0,0`; direction `0,0.5`; ratio `80`. Case B: CDFALL; insertion `0,0`; direction `0,2`; ratio `80`. Case C: CDFALL; insertion `0,0`; direction `0,1`; ratio `80`. All three specify due north. A millimetre control uses `INSUNITS=4`, insertion `0,0`, direction `0,500`, ratio `80`.

   **Assertion:** All four inserted symbols must indicate the same northward direction. The CE log entry from `ApplyFallBlockOrientation` must have `FALL orientation: input=90.0°` for each case. At this ref, metre cases A and C pass `input=0.0°`; metre case B and the millimetre control pass `input=90.0°`. Read the log's numeric angle using the profile's decimal separator if it is localised. The angle comparison independently proves the lost direction even if the supplied block's visual configuration has another issue.

   **Correction direction:** Calculate the bearing for distinct usable points. If a minimum separation is needed, convert an appropriately small tolerance to drawing units and preserve the user's direction instead of silently substituting east.

8. **Validation and limits.** The tests above are specifications for the separate authorised AutoCAD test lane, not tasks assigned to Tim and not tests executed by this reviewer. Run on isolated fixture copies, preserving the user's drawings and settings. Record the host version, plugin build, before/after entity values and command/log output. The useful assertions cross the prompt, command, service and actual drawing boundaries; checking only the geometry helpers would miss the destructive command order and discarded inputs. No Australian engineering-standard compliance conclusion is made: these findings concern cancellation, coordinate handling and consistent metric units. Suggested corrections do not introduce new R-27 hard blocks or move engineering values away from Settings.

9. **Summary.** Four new code-proven findings remain: two HIGH and two MEDIUM. CDJOINT can erase existing joints before a cancelled replacement; PITEDIT transforms world coordinates twice; CDRG can lose a corner in metre drawings; CDFALL can discard a short but valid bearing. All 132 specified command files were included in the sweep. AutoCAD reproduction remains unrun under the read-only brief. Only this findings file was authored for publication; no source fix or release action was attempted.
