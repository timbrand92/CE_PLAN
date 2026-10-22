1. **ANSWER FIRST — 3 HIGH, 3 MEDIUM, 0 LOW.** Six additional faults are verified by reading the installed release's code. None has been run in AutoCAD during this hunt.

2. **Most important — selecting another pipe can give it the previous pipe's grade.** In Calculations, selecting a 1 in 50 pipe and then a 1 in 200 pipe can leave 50 in the grade box. The second pipe's displayed capacity is then twice the correct value. The source hint can even name the second pipe while using the first pipe's grade.

3. **Other effects for Tim.** LandXML can enlarge a stated millimetre network 1,000 times. A combined XREF schedule can omit a different pit's identifying fields. A typed depth can disappear after Stop overriding. A supposedly schedule-only lid change writes the underlying pit record. A closed boundary can lose its closing side in a long section. All 154 requested files were read; no code, drawing, Settings or installation was changed.

---

1. **S11-01 — HIGH — Pipe Flows keeps the first selected pipe's grade when the selection changes. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/ViewModels/PipeFlowCalcViewModel.cs:159`, `:178`, `:202`, `:209`, `:215`, `:225`. Live bindings: `Modules/Drainage/Dialogs/CalculationsV2Dialog.xaml:573`, `:594`, `:596`. Source calculation: `Modules/Drainage/Services/CdCalcPrefillService.cs:104`, `:121`.

   **What happens in AutoCAD:** A drafter checks one pipe, selects the next, and gets a plausible capacity calculated with the first pipe's grade. The second selection does not require any manual edits to trigger this.

   **Exact failure scenario:** `SelectedPipeId` calls `LoadFromSelectedPipe`. Diameter is replaced on every selection. Grade and roughness are replaced only while blank or equal to the factory defaults. The first automatic fill of grade 50 makes that field ineligible for the second automatic fill of 200. No state distinguishes a value automatically filled by CE from one deliberately typed by the drafter. With concrete roughness 0.013, the roughness condition still succeeds on the second selection, so `appliedRoughness` can make the source hint name the second pipe's inverts even though its grade was not adopted. The same selection-history defect affects a non-default roughness supplied by the first pipe.

   **DETERMINISTIC TEST — fixture:** A fresh synthetic millimetre Civil DWG with no saved calculation draft. Four ordinary CE pits, all with known positions and cover RL 12.00 m: P1 `(0,0)`, P2 `(10000,0)`, P3 `(0,20000)`, P4 `(10000,20000)`. Pipe A joins P1-P2, diameter 300 mm, RCP, inverts 10.20/10.00 m. Pipe B joins P3-P4, diameter 450 mm, RCP, inverts 10.05/10.00 m. Both recorded lengths are 10 m; positions carry millimetre units. For this test profile, concrete Manning's n is 0.013.

   **Typed steps and assertion:** Type `CDCALC`; open `Pipe Flows`. In `SELECT FROM DRAWING`, select A, then B, without typing into any input. Assert B is selected, Diameter is 450 and `Grade 1 in X` is 200. Current code leaves 50. Record the displayed Flow; type 200 in the grade box and press Tab. The corrected flow must be half the previous value, within the two-decimal display rounding. Also inspect the source hint: it can say `from P3→P4 inverts` while the box still says 50. This is a visible window-value test, not a test of the prefill helper in isolation.

2. **S11-02 — HIGH — LandXML ignores explicit millimetre units and scales coordinates by their magnitude. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Helpers/LandXmlParser.cs:125`, `:189`, `:446`, `:452`. Native route: `Modules/Drainage/Commands/LinkCommands.ImportXcivil.cs:325`, `:467`; `Modules/Drainage/Services/XcivilImportService.cs:1841`, `:1860`, `:1879`, `:1961`.

   **What happens in AutoCAD:** A supplied millimetre network can be drawn 1,000 times too large. Moving the import onto the drawing does not correct the spacing between its pits.

   **Exact failure scenario:** Unit detection returns true only for meter/metre/m. A declared `millimeter` is treated like unknown units. `ParseStruct` then uses `coordsAreMeters || ShouldScaleAsMeters(...)`, multiplying by 1,000 whenever easting is between 100 and 1,000,000 and absolute northing is between 100 and 10,000,000. Thus stated millimetre positions `(1000,1000)` and `(2000,1000)` become `(1000000,1000000)` and `(2000000,1000000)`. This is not merely an origin shift. The native importer subsequently flattens Z, prepares/snaps pipes and applies a common translation; it does not undo this scale. With no pipes, the two pit positions go straight through that path.

   **DETERMINISTIC TEST — fixture:** A fresh millimetre Civil DWG with the normal CE pit blocks available, no prior import and unlocked target layers. Supply this synthetic parser-supported XML as `S11_MM.xml`; zero elevations avoid a separate level-unit question:

   ```xml
   <LandXML xmlns="http://www.landxml.org/schema/LandXML-1.2" version="1.2">
     <Units><Metric linearUnit="millimeter" areaUnit="squareMeter"
       volumeUnit="cubicMeter" temperatureUnit="celsius" pressureUnit="milliBars"/></Units>
     <PipeNetworks><PipeNetwork name="S11">
       <Structs>
         <Struct name="P1" elevRim="0" elevSump="0">
           <Center>1000 1000</Center><RectStruct width="600" length="600"/>
         </Struct>
         <Struct name="P2" elevRim="0" elevSump="0">
           <Center>1000 2000</Center><RectStruct width="600" length="600"/>
         </Struct>
       </Structs>
     </PipeNetwork></PipeNetworks>
   </LandXML>
   ```

   **Typed steps and assertion:** Type `CDIMPORTLANDXML`, choose the file, click `Read source`, then `Import to drawing`. Close the result window. Type `DIST` and use insertion snaps on the imported P1 and P2 pit blocks. Assert a separation of 1,000 drawing units, which is 1 m. Current code produces 1,000,000 units, which is 1,000 m, regardless of any common translation. The latest import debug log also incorrectly reports `coordinate units=auto-detect` for this explicitly declared file. No client or real survey data is needed.

3. **S11-03 — HIGH — Different XREF pits with equal local handles lose their separate schedule headings. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/ViewModels/PitScheduleViewModel.Schedule.cs:410`, `:441`, `:75`, `:176`, `:1267`, `:1723`. Source rows: `Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:667`, `:768`, `:812`, `:818`, `:826`.

   **What happens in AutoCAD:** A combined schedule can export the inlet of a second, different pit while leaving its pit number, size, outlet figures, cover and lid/remarks blank. That row reads as another inlet to the first pit.

   **Exact failure scenario:** External rows carry both their drawing identity and a qualified pit identity. Their grid group key also includes the drawing identity. However, output grouping rebuilds its key as `H:<SourcePitHandle>|<schedule set>`, omitting the drawing identity. Handles only identify an object within its own DWG. Adjacent pits from different sources with equal handles and the same schedule set therefore compare as one group. CSV and Excel explicitly blank the second row's pit fields; drawn output uses the same decision. The duplicate-pit-number check does not catch P1 and P2 because their numbers are different.

   **DETERMINISTIC TEST — fixture:** Two independently created synthetic CE source DWGs, `S11_A.dwg` and `S11_B.dwg`, with distinct CE drawing identities. Each contains exactly one scheduled ordinary pit in `Main`, one registered inlet and one registered outlet. A's pit is P1, cover 11.00 m, outlet invert 10.00 m; B's is P2, cover 21.00 m, outlet invert 20.00 m. Give both pits 600 by 600 mm size and 300 mm connections. Build both DWGs from the same clean template in the same creation order, then change B's pit number and levels; verify their pit block handles are equal. This handle equality and the distinct drawing identities are explicit fixture preconditions. Do not use a copied CE drawing identity. Attach both at scale 1 to a third Civil DWG.

   **Typed steps and assertion:** Type `PITSCHEDULE`; on `Source`, choose `Drainage XREFs`, tick A and B, select `Main` and all systems. Confirm two source groups are available. Click `Export CSV`. Assert the two data rows each have their own non-empty PIT No., PIT SIZE, outlet diameter/invert and COVER; specifically P2 and 21.00 must occur in the second row's pit fields. Current grouping blanks those fields. Repeat with `Export Excel` to check its schedule sheet. Keep the rows consecutive and on the same sheet for a drawn-output check, so continuation-sheet heading logic cannot mask the fault.

4. **S11-04 — MEDIUM — A typed depth never reaches its edit helper and is discarded by Stop overriding. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:1157`, `:1179`, `:1270`, `:1290`, `:1561`, `:1814`, `:2128`, `:2826`; `Modules/Drainage/ViewModels/PitScheduleViewModel.cs:976`. Editable window cell: `Modules/Drainage/Dialogs/PitScheduleDialog.xaml:815`.

   **What happens in AutoCAD:** With Auto-calculate depth off, entering a depth appears to work in the cell but does not perform the intended level edit. Stop overriding then loses the typed value while saying it stays.

   **Exact failure scenario:** The real row-change handler first tracks `Depth` as an override, which synchronously sets `IsLinkedOverride=true`. Later in that same handler, the call to `ApplyTypedDepthEdit` requires `!row.IsLinkedOverride`. It is therefore unreachable for the ordinary linked row just edited. Stop overriding pushes a fixed list of other fields, with no Depth entry, clears the override and reloads the rows. Fresh linked rows do not initialise Depth; with automatic depth still off, `UpdateDepth` leaves it blank. The footer nevertheless says `Stopped overriding this row. The values you typed stay.` This is separate from the already logged question of measuring depth to the pit floor versus the outlet.

   **DETERMINISTIC TEST — fixture:** An unlocked ordinary scheduled pit P1 in `Main`, cover 10.00 m, one inlet at 9.10 m and one outlet at 9.00 m, all CE links and geometry present. Start with no row overrides. Use a separate synthetic drawing from the other tests.

   **Typed steps and assertion:** Type `PITSCHEDULE`. On `Source`, untick `Auto-calculate depth`. On `Rows`, double-click P1's `DEPTH` cell, enter `2.00`, press Tab, then right-click that row and choose `Stop overriding`. Assert the depth remains 2.00 m after that action and after reopening the window, with an actual corresponding level change under the agreed depth rule. Current code leaves the original levels unchanged and reloads a blank Depth while displaying the quoted success sentence. The minimum failure assertion is the lost 2.00 value; it does not depend on choosing a new pit-floor policy.

   **Why green helper tests do not establish the window behaviour:** `Modules/Drainage.Tests/ViewModels/PitScheduleDepthEditWiringTests.cs:25`, `:41`, `:55`, `:69` call `ApplyTypedDepthEditForTest` directly. That entry at `PitScheduleViewModel.cs:90` bypasses `TrackOverriddenField` and the guard that prevents the live cell edit from reaching the helper. The later regression needs to edit a subscribed row through the real grid/property-change route.

5. **S11-05 — MEDIUM — A schedule-only lid override writes the underlying pit record immediately. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:1301`, `:1305`, `:1327`, `:1382`; `Modules/Drainage/ViewModels/PitScheduleViewModel.cs:1464`, `:1091`, `:1159`. Persistence: `Modules/Drainage/Services/ProjectDataService.Mutations.cs:1339`, `:1356`, `:1361`, `:1378`.

   **What happens in AutoCAD:** Enabling a row override promises changes to schedule output only. Typing a lid type nevertheless changes the pit's saved engineering record. Restoring the cell cannot recover the old record value: the supposed source has already been replaced.

   **Exact failure scenario:** The LidType and Remarks branches check only that the row is not manual, has a pit handle and is not being synchronised. They do not exclude `IsLinkedOverride`, unlike the later general plan-write branch. `UpdatePitLidTypeByHandle` assigns `pit.LidType` and saves project data; the Remarks equivalent does the same to `pit.Remarks`. Override persistence then flushes the save. Restore Cell removes the override and temporarily blanks the cell under `_isRestoringCell`, but does not restore the original pit record. The reload reads the changed `pit.LidType`. This finding concerns the current drawing's record; the external-source early return does protect XREF rows.

   **DETERMINISTIC TEST — fixture:** One unlocked ordinary CE pit P1 with a valid inlet/outlet, `IncludeInSchedule=true`, saved `LidType="Class A Solid Lid"`, no custom remarks and no overrides. Confirm the original value in the window before proceeding.

   **Typed steps and assertion:** Type `PITSCHEDULE`, select P1 on `Rows`, right-click `Enable Row Override`; observe `Edits now affect schedule output only.` Double-click `LID TYPE`, replace it with `Class B Solid Lid`, press Tab, then right-click that same cell and choose `Restore Cell`. Assert the cell returns to `Class A Solid Lid` and that P1's saved CE pit record still has Class A. Current code has already written Class B and the restored cell reloads Class B. Close, `QSAVE`, reopen the schedule and check again. A native test reader can additionally assert `ProjectDataService.GetPitByHandle(P1Handle).LidType` immediately after committing the edited cell, before Restore Cell: it must still be Class A while the schedule-only override is active. Repeat with a plain Remarks value to exercise the parallel branch.

6. **S11-06 — MEDIUM — A closed boundary's last-to-first edge is omitted from long-section evidence. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/ViewModels/LongitudinalSectionViewModel.cs:1181`, `:1190`, `:1207`, `:1219`. Capture and filtering: `:893`, `:939`, `:1138`, `:1287`. Current command path: `Modules/Drainage/Services/ProfileRouteEvidenceCaptureService.cs:315`, `:403`; output consumes the captured markers at `Modules/Drainage/Services/LongitudinalSectionService.cs:1059`, `:1682`.

   **What happens in AutoCAD:** A pipe crosses a clearly drawn closed property boundary, but its long section has no BOUNDARY marker at the crossing. The result depends on which corner happened to be the first polyline vertex.

   **Exact failure scenario:** Boundary collection enumerates consecutive vertices only, stopping at `Count - 1`. None of the lightweight, 2D or 3D polyline branches adds the last-to-first segment when the polyline is closed. The resulting incomplete segment list feeds both the older longitudinal output and the current CDPROFILE review. Successful capture returns true, so the missing side is not reported as unavailable evidence.

   **DETERMINISTIC TEST — fixture:** Synthetic millimetre source DWG `S11_BOUNDARY.dwg`, with one closed lightweight polyline on layer `BOUNDARY`. Vertices, in order: `(0,0)`, `(10000,0)`, `(10000,10000)`, `(0,10000)`; Closed=true, all bulges zero. Attach it at origin, scale 1, rotation 0 to a Civil drawing. Host CE pits P1 `(-5000,5000)` and P2 `(5000,5000)`, both in Main, cover 12.00 m, connected by a 300 mm gravity pipe with inverts 10.10/10.00 m; nominate P2 as the discharge endpoint. The route crosses only the implicit closing side, 5 m from each endpoint, beyond the 2 m endpoint-extension allowance.

   **Typed steps and assertion:** Type `CDPROFILE`, pick P1, choose P1-P2 and Main; set datum 9.00, horizontal scale 100 and vertical scale 50. Click `Preview New`, pick a clear insertion point, then `Apply`. Assert the drawn profile contains a BOUNDARY line and label at chainage 5.00 m. Current capture supplies no marker there. For the positive control, add an explicit LINE from `(0,10000)` to `(0,0)` on the same source layer, save/reload the XREF and repeat into a clear position: the marker must now appear. This isolates missing closure from XREF discovery, layer naming or route selection.

7. **Scope, evidence and exclusions.** Review date: 23 October 2026, Melbourne. Code was read with Git from `origin/claude/rel-20261022m`, commit `40ee0a36f7960145743954b39859eb6c3af92869`, the brief's Civil 3.0.70 / Manager 1.1.70 baseline. All 154 named files were read, starting with the largest central files, plus supporting command, service, dialog and test-source paths needed to establish reachability. Structural was outside this sweep. Read first: `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md`. Additional candidate checks against the 22 October hunt reports and findings ledger found no matching recorded defect for these six. Existing findings were excluded. Counts contain verified-by-reading findings only; no suspected finding is counted. The deterministic tests above are future execution instructions, not passing results. No build, test, AutoCAD session, installation or sub-agent was used. Only this findings file was authored; no fixes or new hard blocks are proposed here. Manager administration remains parked.

8. **Summary.** Six additional faults: three HIGH and three MEDIUM. Prioritise pipe-selection state, explicit LandXML units and XREF schedule identity before colleague release. Then repair the unreachable depth edit, schedule-only record writes and missing closed-boundary side. Each finding has a concrete fixture and observable assertion. All 154 requested files were read at the installed Civil ref. Findings are code-proven, not runtime-certified; no tests or AutoCAD were run.
