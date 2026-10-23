**ANSWER FIRST — Civil units audit, RD04, 23 October 2026 (Melbourne)**

1. **Five NEW findings: HIGH 3 / MEDIUM 1 / LOW 1.** All five are SURE / verified-by-reading at Civil 3.0.72. None has been run in AutoCAD in this hunt. Known bugs are excluded from these counts.

2. **Most important — slab falls can pass when they are far too flat.** In a metre drawing, a surface falling just 1 mm over 10 m is calculated as 1:10 instead of 1:10000. The slab preview can say it achieves the minimum fall, and regenerated fall arrows carry the wrong grade.

3. **Second — AG drain checks have the same dangerous result through a different calculation.** A 10 m AG drain falling 1 mm is reported as 1:10 and meeting the office minimum 1:100. The correct grade is 1:10000. Millimetre drawings give the correct result for this example.

4. **Third — millimetre LandXML elevations are called metres.** A supplied cover elevation of 100200 mm is shown in the import review as 100200 m, rather than RL 100.200 m, and is passed into the pit record unchanged. This can happen even in a correctly configured millimetre target drawing.

5. **Action for the build and test lanes.** Correct the unit conversion at the input to each calculation, then run the paired millimetre/metre cases below. Keep engineering limits on Settings and warnings advisory under R-00/R-27. This report requests no work or testing from Tim.

---

1. **Source and method.** Fetched `C:\Lisp Files\CE_ACAD_PLUGIN` and used a detached, read-only worktree at `C:\ce-cx\rd04`. All source references below are pinned to `origin/claude/rel-20261023m`, commit `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`, whose version commit names Civil 3.0.72 / Manager 1.1.72. Read source with `git show` and `git grep`. No code branch or code commit was made. The brief's later, specific source revision takes precedence over its earlier 22 October revision. Installed DLL identity was not independently inspected.

2. **Prior evidence and scope.** Read RULES, ROUTER, CE_PLAN start/map and the survey/surface/import area; searched BUG_CARPARK before hunting and again for each candidate. Reviewed the relevant material in `AUDIT_C58_C60_S40_S41_2026-10-22.md` and the Civil, Structural and Gate `CODEX_AUDIT_*_22OCT.md` reports. Scope is Civil units, with Civil + Manager's 9 November release in mind. Manager administration and Structural implementation are outside this audit.

3. **Evidence meaning.** SURE / verified-by-reading means the production caller, values and conversion were traced. It does not mean a native test passed. All tests below are proposed, deterministic checks for the later AI test lane on synthetic copies. No fixture, build, unit test, AutoCAD session, installation, source edit or sub-agent was created or run here.

**Numbered NEW findings — ranked**

1. **RD04-01 — HIGH — SURE / verified-by-reading: slab fall calculation assumes every plan is drawn in millimetres.**

   **File:line:** `Modules/Drainage/Services/SlabService.cs:144` and `:145`; raw drawing-coordinate input at `Commands/SlabCommand.cs:698`, `:699`, `:827`; shared preview/regeneration call at `Services/SlabFallRegenerationPlan.cs:426`; passing verdict at `ViewModels/SlabViewModel.cs:171` and `:175`. All paths are relative to the pinned source root.

   **What the drafter sees:** In an INSUNITS 6 drawing, CDSLAB can approve a practically flat concrete surface. Its fall labels are also wrong. A 10 m run falling 1 mm reads 1:10, although it is 1:10000. INSUNITS 4, with equivalent physical geometry, calculates this example correctly.

   **Exact failure:** The command stores picked X/Y directly in drawing units and FSL in metres. `ComputeFallForTriangle` multiplies the FSL differences by 1000 but leaves X/Y unchanged; it has no units argument. The slope is therefore 1000 times too large for metre coordinates. `SlabFallRegenerationPlan` uses that result unchanged for both preview and replacement symbols. The creation view model compares it directly against the minimum fall and prints a passing sentence. This is the conversion fault, not a request to change the minimum fall value.

   **DETERMINISTIC TEST — fixture:** Two synthetic Civil-tagged model drawings, World UCS, no survey, unlocked output layers and the shipped fall-symbol definition. One uses INSUNITS 6; the other INSUNITS 4. Prepare a registered concrete slab named `UNIT-SLAB` with one closed triangular boundary, three known control points and matching boundary point IDs, no islands/breaklines/outlets and no existing fall-symbol handles. Metre points: A=(0,0), FSL=10.001; B=(10,0), FSL=10.000; C=(0,10), FSL=10.001. Multiply only X/Y by 1000 in the mm copy. The fixture must have matching slab records in the drawing's normal slab storage and project record, not merely a loose polyline.

   **Typed steps and assertion:** Clear preselection. Type `CDSLABEREGEN`, select the `UNIT-SLAB` boundary, then inspect the new FALL_GRADE attribute. Require `CDSLABEREGEN complete - 1 fall symbol(s) regenerated.` and grade `1:10000` in both drawings. Reading predicts `1:10` in the metre copy and `1:10000` in the mm copy. Separately, create the same boundary/control points through `CDSLAB`, skip spoon islands, and inspect the Slab Fall Design window before Apply: the metre case must not say all triangles achieve the advisory 1:100 minimum. If a native prompt prevents reaching that window, record that route as blocked; the registered-slab regeneration test remains the independent numerical oracle.

   **Smallest fix:** Pass the owning drawing's units through the shared fall planner and convert vertical rise into the same unit as plan distance, or normalise temporary calculation coordinates to metres. Preserve stored/drawn coordinates and use the same conversion for creation, regeneration and flow review. Do not fix only the displayed label. The existing simple-slope test (`Modules/Drainage.Tests/Services/SlabServiceTests.cs:83`) expressly supplies mm coordinates; that test cannot establish metre-command correctness.

2. **RD04-02 — HIGH — SURE / verified-by-reading: AG and perimeter drain grade checks divide metre distances by 1000.**

   **File:line:** `Modules/Drainage/Commands/AgiCommand.cs:268`, `:269`, `:295`, `:298`, `:322`; production call at `:141`; displayed/stored result at `Commands/AgiCommand.Apply.cs:137` and `Commands/AgiCommand.Plan.cs:174`.

   **What the drafter sees:** In INSUNITS 6, CDAGI and CDPERIMETER can say a very flat drain meets the office minimum. A 10 m run from RL 10.001 to 10.000 is reported as 1:10 rather than 1:10000. This is independent of whether an outlet was selected.

   **Exact failure:** `TotalRunLength` sums distances between the picked world points, in drawing units. `PromptGradeCheck` calls that result `runLengthMm`; `BuildGradeCheckText` divides it by 1000, then compares the calculated ratio with `AgDrainMinimumGradeRatio`. There is no INSUNITS conversion between those steps. Also, the raw `<= 1.0` early return skips level questions for runs up to 1 m in a metre drawing. The arithmetic and short-run cutoff belong to the same missing conversion.

   **DETERMINISTIC TEST — fixture:** Empty synthetic Civil-tagged INSUNITS 6 drawing, World UCS, object snaps off, standard AG_LINE resources available, unlocked AGI DRAIN layer, and test-profile `Surface.AgDrainMinimumGradeRatio=100`. Make an equivalent INSUNITS 4 control copy.

   **Typed steps and assertion:** Type `CDAGI`; Enter for None; pick `0,0`, then `10,0`; Enter to finish the open run; Enter to skip the outlet; enter start invert `10.001` and end invert `10.000`. Inspect the `Preview:` sentence before Accept. Require `1:10000` and `below the office minimum 1:100`; forbid `meets the office minimum`. Reading predicts `1:10` and `meets` in metres. Repeat in mm using `0,0` to `10000,0`, and repeat the command pair with `CDPERIMETER`. A separate 0.5 m run must still offer the level questions. Cancel the previews or accept only on disposable copies.

   **Smallest fix:** Convert `TotalRunLength(points)` to physical millimetres using the active document before the 1 mm cutoff and grade calculation. Keep the engineering ratio sourced from Settings. The helper tests at `Modules/Drainage.Tests/Commands/AgiCommandSurfaceDrainKindTests.cs:154` and `:163` feed already-normalised 6000/12000 mm, so they bypass the faulty drawing-to-helper boundary.

3. **RD04-03 — HIGH — SURE / verified-by-reading: LandXML cover and invert elevations are not converted from the source unit to metres.**

   **File:line:** `Modules/Drainage/Helpers/LandXmlParser.cs:125`, `:193`, `:236`, `:261`, `:267`, `:274`; review explicitly appends metres at `Commands/LinkCommands.ImportXcivil.cs:280`; persisted cover at `Services/XcivilPitInsertionService.cs:263`; insertion reached at `Services/XcivilImportService.cs:1983` and following pit-writing code.

   **What the drafter sees:** A millimetre LandXML file supplies cover elevation 100200 for RL 100.200 m. The review says `cover level 100200 m from the LandXML file`, and the imported pit receives that raw cover value. Supplied invert elevations can instead disappear because their unconverted mm values fail a range check intended for metres. The cover error exists in INSUNITS 4 and 6 targets; it is the file's vertical unit, independent of target geometry scale.

   **Exact failure:** Source-unit detection is used only for horizontal coordinates. `elevRim` goes through string cleaning, not unit conversion, and `<Invert elev>` is range-checked before any conversion. The review and pit data consume those strings as metres. A file declaring millimetres therefore does not have the same physical result as its metre equivalent. This finding is limited to vertical levels; previously reported position and size cases are excluded.

   **DETERMINISTIC TEST — fixture:** Create `UNIT-RL-MM.xml` for the later test lane with the following namespace-free content, a form the parser explicitly supports. Use a fresh, empty, Civil-tagged INSUNITS 4 target with no earlier imports, no nearby pits, unlocked layers, and `xcivilImport.landXmlAskBeforeWrite=true`.

   ```xml
   <LandXML>
     <Units><Metric linearUnit="millimeter" diameterUnit="millimeter" widthUnit="millimeter" /></Units>
     <PipeNetworks><PipeNetwork name="UNIT-NET"><Structs>
       <Struct name="P1" desc="grated pit" elevRim="100200">
         <Center>0 0</Center>
         <RectStruct width="600" length="600" />
         <Invert elev="100000" />
       </Struct>
     </Structs></PipeNetwork></PipeNetworks>
   </LandXML>
   ```

   **Typed steps and assertion:** Type `CDIMPORTLANDXML`, click **Choose LandXML…**, select that file, then **Read source**. P1's review row must state cover level 100.200 m (equivalent rounding accepted), never 100200 m. Click **Import to drawing** only on the disposable fixture; inspect P1's stored CoverLevel or its cover text: numerical value must be 100.2. Repeat with a metre source (`linearUnit="meter"`, cover 100.200, invert 100.000; keep explicit mm size units and sizes) and a fresh target. The two cover values must match. Repeat the cover-row comparison in an INSUNITS 6 target; do not use horizontal placement as the assertion. Zero horizontal coordinates deliberately avoid the separate coordinate-guess defect. The single pit and no pipes also avoid pipe-end-name issues.

   **Smallest fix:** Parse each supplied elevation numerically and convert the stated source linear unit to metres before range validation, formatting or storing it. Keep plan-coordinate and size conversions separate. If the source unit cannot be established, show the level as Unknown with a reason and continue the permitted workflow; do not silently call the raw number metres.

4. **RD04-04 — MEDIUM — SURE / verified-by-reading: an open AG/perimeter drain can lose its final vertex and become a closed loop in a metre drawing.**

   **File:line:** `Modules/Drainage/Commands/AgiCommand.Plan.cs:77`, `:123`, `:125`, `:126`; unconverted picked coordinates at `Commands/AgiCommand.cs:403`; accepted output reports the altered shape at `Commands/AgiCommand.Apply.cs:137`.

   **What the drafter sees:** Finish an open run half a metre short of its start, using Enter. CE treats that 500 mm gap as if it were below 1 mm, removes the last corner and previews a closed triangle. Accept draws that altered route. Equivalent mm geometry stays open.

   **Exact failure:** The close-on-near-start rule compares drawing-unit distance directly with `SnapClosureToleranceMm=1.0`. For INSUNITS 6 this is a 1 m reach. With four picked vertices it removes the fourth and sets Closed=true, even though the drafter did not choose Close. This is separate from the grade calculation in RD04-02: it changes the route itself.

   **DETERMINISTIC TEST — fixture and steps:** Synthetic INSUNITS 6 Civil drawing, World UCS, no snaps. Type `CDAGI`, Enter for None; pick `0,0`, `10,0`, `10,10`, `0,0.5`; Enter to finish; skip outlet and both level questions with Enter. Assert the preview reads **4 vertices, open**. Reading predicts **3 vertices, closed**. Accept on the disposable copy and inspect the polyline: four vertices, last at (0,0.5), Closed=false are required. Repeat with CDPERIMETER, and in INSUNITS 4 with all XY multiplied by 1000. The mm controls should remain open.

   **Smallest fix:** Supply the owning drawing's units to the plan builder and convert the intended 1 mm closure reach to drawing units before comparing. Retain the explicit Close option and the final picked vertex whenever the real gap exceeds that reach.

5. **RD04-05 — LOW — SURE / verified-by-reading: CDPIPEOBJ reports a metre-drawing pipe as 1000 times shorter.**

   **File:line:** `Modules/Drainage/Commands/NativePipeObjectCommands.cs:110` and `:111`; host availability and colleague hold at `:42` and `:49`; unit helper at `Services/DrawingAreaUnits.cs:118`.

   **What the drafter sees:** On an eligible AutoCAD 2027 test PC, draw a pipe 10 m long in an INSUNITS 6 drawing. The command says `Pipe object drawn: 0.0 m`. This finding concerns that sentence only; native pipe width is not certified here. The ordinary colleague default holds this command, so this is not asserted as a default colleague exposure.

   **Exact failure:** The route is collected in world drawing coordinates, but its total length is always divided by 1000 before formatting to one decimal place. No unit conversion precedes that division.

   **DETERMINISTIC TEST — fixture and steps:** AutoCAD 2027 with the matching pipe-object enabler already loaded and upgrade allowed on the authorised test profile; Civil-tagged model drawing, INSUNITS 6, World UCS. Type `CDPIPEOBJ`; pick `0,0`, `10,0`; Enter to finish; enter width `100`; choose Single. Require command text `Pipe object drawn: 10.0 m, 100 mm`. Reading predicts `0.0 m`. Repeat in INSUNITS 4 with endpoint `10000,0`; require the same 10.0 m message. If the enabler or gate refuses, record blocked rather than claiming this check passed.

   **Smallest fix:** Convert the route length from the owning database's units to metres before formatting, using the shared conversion. No native geometry change is needed to correct this reporting defect.

**Duplicate exclusions and coverage**

1. **Known bugs — identifiers only, excluded from new counts:** BUG-209, BUG-230, BUG-242, BUG-243, BUG-270, BUG-271, BUG-281, BUG-287, BUG-296, BUG-309, BUG-321, BUG-322, BUG-323, BUG-328, BUG-330, BUG-331, BUG-393, BUG-406, BUG-505, BUG-516, BUG-648, BUG-649, BUG-663, BUG-695, BUG-696, BUG-700, BUG-701, BUG-705, BUG-710, BUG-718, BUG-719, BUG-725, BUG-729, BUG-745, BUG-758, BUG-810, BUG-871, BUG-994, BUG-1007.

2. **Area checks read without a new units finding.** `DrawingAreaUnits.cs:57` divides square drawing units by the appropriate square-unit factor. `PavementAreaPlan.cs:124` and `PaveCommand.cs:58` use the drawing's units; the raingarden call at `SourceBlockInsertCommands.cs:588` does too. `XrefSiteGeometryService.cs:91` normalises source coordinates to mm; its hatch-boundary reader at `:300` applies that scale, and `SurfaceEvidenceMapService.cs:157` remeasures transformed areas using host units. This establishes conversion in those inspected routes, not general correctness of hatch holes, curved boundaries or all area callers.

3. **What was NOT checked.** No native appearance, plot, performance, Undo/Redo, save/reopen, actual installed binary, live Settings, client drawing or consultant export was checked. No builds or tests were run. Imperial/unitless behaviour, paper-space and viewport scaling, every legacy repair/label path, native C++ pipe rendering, external schema validation and exhaustive hatch-boundary topology were not audited. Structural and Manager code were not assessed for new defects. Proposed test data above is synthetic; it has not been loaded into AutoCAD.

4. **File and cleanup scope.** Only this report is authorised for writing and committing in CE_PLAN. No BUG_CARPARK, DESK_LOG, QUEUE, source, setting or drawing change is part of the hunt. The detached audit worktree is removed after source reading. The report can be undone by reverting its single-file commit.

**Summary**

Five new unit faults remain: slab and AG drain checks can falsely pass inadequate falls, LandXML elevations can be stored as the wrong metre values, open drains can close across a 500 mm gap, and CDPIPEOBJ understates length. The top three affect engineering information. All are verified by reading, not AutoCAD acceptance. Paired unit fixtures and exact assertions are recorded for the later test lane. Known bugs are excluded; inspected area conversions are present, but native results remain untested.

