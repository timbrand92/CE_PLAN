1. **ANSWER FIRST — HIGH: 1; MEDIUM: 4; LOW: 0.** Five findings are verified-by-reading. The most important: changing an older pipe's diameter through Pit Schedule can make its drawn width 1,000 times too large in a metre drawing. A change to 375 mm writes a width of 375 metres.

2. **Other drafter-visible faults.** A rotated FALL arrow can escape the direction check; Inspector labels a 10 m pipe as 10 mm; changing pit label wording can prevent later style changes reaching those labels; Inspector's health buttons can zoom to empty space with a moved UCS origin.

3. **What is and is not proven.** These are source-proven paths, not observed AutoCAD results. All five reproduction tests below are pending for a later AI tester on synthetic copies. No build, test, AutoCAD session, installation or source edit was performed. Nothing is marked fixed or accepted.

---

1. **Review boundary.** CODE SWEEP S02, Civil Services slice 2 of 6, desk plan/03; 23 October 2026, Melbourne. Read RULES.md, ROUTER.md and the project plan before the hunt. The specific read-only brief overrides the appended worktree/build/PR instructions. Only this findings file is authored.

2. **Pinned source.** Repository: `C:\Lisp Files\CE_ACAD_PLUGIN`. After `git fetch origin`, the requested `origin/claude/rel-20261022m` resolves to `40ee0a36f7960145743954b39859eb6c3af92869`. Every file:line below refers to that source, not the working checkout. Civil 3.0.70 / Manager 1.1.70 are the versions identified by the brief; installed binaries were not inspected. Structural's separate release was not used as Civil source.

3. **Coverage and exclusions.** Read all 112 listed Services files through `git show`, starting with the largest central files: InspectorPaletteService, LinkService, LayerService, LinkService.Cache, CuiMenuGeneratorService and CompoundEditModeService. Continued through every listed file, including interfaces and the polyfill. Used additional Git reads to trace callers and observable UI text. No checkout or branch was made.

   Read the earlier `AUDIT_C58_C60_S40_S41_2026-10-22.md` and `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md`. Their findings are not counted again. Manager administrator work remains parked. These findings do not propose new hard blocks or new engineering defaults.

4. **Severity and evidence.** HIGH means a persisted drawing dimension becomes materially wrong. MEDIUM means a supported drafting operation displays wrong evidence, misses a check or fails to perform its stated action. “Verified-by-reading” covers the actual source path and arithmetic. No suspected-only finding is included. Native appearance, reactors, save/reopen and Undo/Redo still require the specified tests.

---

1. **S02-01 — HIGH — Pit Schedule writes a millimetre diameter as metres into an older pipe's width. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/LinkService.cs:1077`, `:1079`, `:1084`, `:1102`. Reachable caller: `Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:1814`, `:1858`, `:1864`. Supporting seam: `Modules/Drainage/Services/LinkService.PipeWriteSeam.cs:31`; `Modules/Drainage/Services/NativeObjects/PipeGeometrySeam.cs:210`.

   **What happens in AutoCAD:** An existing ordinary CE pipe polyline in a metre drawing becomes enormously wide when the drafter changes its diameter through Pit Schedule. The schedule can correctly say 375 while the pipe's own stored polyline width is 375 metres.

   **Exact failure scenario:** Use a recognised older CE pipe represented by an ordinary Polyline, not a native CE pipe object, in INSUNITS 6. Change its scheduled diameter from 300 to 375 and write that override to the drawing. `SyncDiameter` updates the project diameter and calls `RefreshPipeVisualByHandle`. That method parses the millimetre number and assigns it directly to every start/end width. The ordinary-polyline seam returns true without converting anything, then the transaction commits.

   The ordinary single-pipe outline refresh does not correct the root polyline width. The subsequent schedule sync updates annotations. This finding is deliberately limited to the supported ordinary-polyline path; it does not assume how the native enabler implements its diameter setter.

   **DETERMINISTIC TEST — fixture:** Synthetic metre model-space DWG, World UCS, INSUNITS 6, FILLMODE 1, unlocked visible pipe/label layers. Two recorded pits P1 and P2 with a scheduled, ordinary CE stormwater pipe P1→P2, length 10 drawing units, diameter record 300 mm, start/end widths 0.300, valid reciprocal pipe/pit records, and no detention twin option. Give the pits and pipe valid levels. Confirm the root is an ordinary LWPOLYLINE and the P1 schedule row resolves this pipe as its outlet.

   **Typed/click steps:** Type `PITSCHEDULE`. On Rows, type `375` into P1's outlet diameter cell and commit the cell. Right-click the P1 row and choose **Stop overriding** to write it to the plan. Close the window, type `REGEN`, and read the same root polyline's start/end widths using AutoCAD Properties or a read-only entity inspection.

   **Assertion:** The schedule/project diameter must be 375 mm and every polyline width must be **0.375 drawing units**. The reviewed code writes **375**. Retain the entity handle and width values as evidence; additionally inspect appearance with FILLMODE 1. Save/reopen and one U/REDO are follow-up checks, not claims made by this read. The missing conversion must be fixed at the drawing write, while keeping the engineering diameter in millimetres.

2. **S02-02 — MEDIUM — the FALL direction check ignores rotation of the placed block. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/FallArrowDirectionReviewService.cs:145`, `:155`, `:169`, `:175`, `:193`. Callers: `Modules/Drainage/Services/Checks/ChecksResultReader.cs:143`; `Modules/Drainage/Commands/SpineCheckCommand.cs:115`. Angle calculation: `Modules/Drainage/Rules/FallArrowGeometry.cs`, `TryInvertFallDynamicParams` and `IsPointingAwayFromNearestPit`.

   **What happens in AutoCAD:** Rotate a correctly aimed FALL symbol by 180° so it points away from its grated pit. CDCHECK can continue treating it as aimed towards the pit. Conversely, a corrected rotated arrow can retain a false warning.

   **Exact failure scenario:** The scan reads Angle1 and Flip State1, turns those into a direction, and stores it unchanged. It reads the block position in drawing/world coordinates but never applies the block's rotation or transform to the direction. Review then compares that local direction with the world direction to the pit. Rotating the whole block about its insertion point changes the visible arrow without changing the two dynamic values used by this check.

   **DETERMINISTIC TEST — fixture:** Synthetic millimetre model-space DWG, World UCS, INSUNITS 4. One recorded pit P1, type exactly `GRATED PIT`, at (5000,0), valid cover level and live block. One supported dynamic FALL SYMBOL block A at (0,0), normal positive scales, Angle1 = 0 radians, Flip State1 = 0 and block Rotation = 0. Verify it points east towards P1. Set the existing Surface settings to nearby-pit distance 15000 mm and away-angle tolerance 45° in the isolated test profile. No other grated pits or FALL symbols.

   **Typed steps:** Type `CDCHECK`, choose `All`, and retain the output. Type `ROTATE`, select only A, Enter, base point `0,0`, angle `180`. Confirm Rotation is 180° and Angle1/Flip State1 are unchanged. Run `CDCHECK`, `All` again.

   **Assertion:** The second output must include `FALL arrow direction: 1 arrow(s) point away from their nearest grated pit.` and A's handle with approximately 180° difference. The current reader still supplies direction 0 and produces no away finding for A. Record the drawing appearance alongside the command-line text. Tests of the angle helper alone cannot detect the missing block transform.

3. **S02-03 — MEDIUM — the compact Inspector reports drawing units as millimetres. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/InspectorPaletteService.cs:856`, `:860`, `:1128`. Display binding: `Modules/Drainage/ViewModels/InspectorViewModel.cs:143`. Correct conversion in the other Inspector path: `Modules/Drainage/Services/InspectorPaletteService.cs:1614`.

   **What happens in AutoCAD:** Select a 10 m pipe in a metre drawing and the normal Inspector's **Connections → Drawn length** says **10 mm**. A drafter using that row to check a route receives a figure 1,000 times too small.

   **Exact failure scenario:** With the workshop Inspector enabled, `RefreshCivilProperties` formats `line.Length` directly as `"{line.Length:0} mm"`. Polyline length is in drawing units. It neither reads INSUNITS nor uses the conversion already present in the full-detail pipe path. This is a display defect; this particular line does not change pipe geometry.

   **DETERMINISTIC TEST — fixture:** Synthetic INSUNITS 6 DWG with one recognised CE pipe whose actual polyline length is exactly 10.000 drawing units. Use a single root selection, suppress compound selection expansion for this fixture, and enable `editors.workshopLayout`. Keep its records loaded and all layers visible.

   **Typed/click steps:** Type `CDINSPECTOR`, select only that pipe, and read **Connections → Drawn length** in the compact view. If full detail is showing, click **Return to CE Inspector** first. Record the window text and independently read the same entity's Length.

   **Assertion:** Inspector must show **10000 mm**, or an explicitly labelled equivalent **10 m**. Source predicts **10 mm**. Repeat with an equivalent INSUNITS 4 fixture of length 10000: it must report the same physical length. The test must exercise the selection-to-window path, not just a unit conversion helper.

4. **S02-04 — MEDIUM — a pit label becomes ineligible for later style changes after its wording loses “CL:” and “IL:”. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/LabelStyleService.cs:210`, `:226`, `:235`, `:418`. Window caller and result text: `Modules/Drainage/ViewModels/LabelStyleDialogViewModel.cs:199`, `:216`, `:218`. Button: `Modules/Drainage/Dialogs/LabelStyleDialog.xaml:134`.

   **What happens in AutoCAD:** Apply a short custom pit label, then restore the original wording and press **Apply to drawing**. The existing label stays short and CE says no matching labels were found, even though it still has that label recorded as an attachment of the pit.

   **Exact failure scenario:** The service finds the pit's recorded attachments, but then identifies eligible MText by searching its current contents for `CL:` or `IL:`. It replaces those contents with the selected active style's text. If that text has neither marker, the next application skips the same recorded object. This includes legitimate short wording; the supplied Compact template itself contains only `{ID}`.

   **DETERMINISTIC TEST — fixture:** Synthetic mm DWG with one recorded pit P1, cover 10.000 m, invert 9.000 m, and one unlocked attached MText label L reading `P1  CL:10.000  IL:9.000`. Pit-link attachment records must contain L's handle. Isolated label catalogue with Default active. Use the active Default entry throughout to avoid relying on the separate style-selection behaviour.

   **Typed/click steps:** Type `CDLABELSTYLE`. Select Default, copy its original **Pit label wording**, replace it with literal `TEST PIT`, and click **Apply to drawing**. Confirm L now reads TEST PIT. Restore the original wording in Default and click **Apply to drawing** again, then close the window.

   **Assertion:** The second application must restore L to `P1  CL:10.000  IL:9.000` and report one updated pit label. The reviewed code leaves L as TEST PIT and reports `No matching labels found — styles applied to new labels going forward.` Verify that L's handle remains in the pit's attachment list. Eligibility should come from recorded label ownership/role, not words erased by the previous application.

5. **S02-05 — MEDIUM — Inspector's health drill-down applies the UCS transformation twice and zooms away from the selected objects. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/InspectorPaletteService.cs:275`, `:2783`, `:2804`, `:2805`; `Modules/Drainage/Services/DrawingService.cs:595`, `:658`, `:714`. Named button: `Modules/Drainage/Controls/InspectorPanelControl.xaml:593`.

   **What happens in AutoCAD:** With a moved UCS origin, click **Unconnected pits** in Inspector's full detail. CE selects the correct pit but zooms to empty space and says “Zoom fit applied”. The drafter cannot see the problem the button was meant to locate.

   **Exact failure scenario:** `ShowEntitiesByHandles` collects `Entity.GeometricExtents` min/max points, which are already world coordinates. It passes them into `ZoomToPointsWithPadding`, whose extent routine treats every point as a UCS point and calls `TransformToWorld` again. A translated UCS therefore adds its origin to the target a second time. No rotated-view assumption is needed to prove this case.

   **DETERMINISTIC TEST — fixture:** Synthetic mm model-space DWG, top World plan, one recognised unconnected pit P1 centred at world (0,0), known symmetric block extents from (-300,-300) to (300,300), and no pipes. Records must produce one **Unconnected pits** item. Set UCSFOLLOW 0. With World UCS active, type `UCS`, `Origin`, `100000,0,0`; retain the World plan view.

   **Typed/click steps:** Clear the selection. Type `CDINSPECTOR`, click **Show full detail** if required, open **Drawing health → Network overview**, then click **Unconnected pits**. Capture the selected handle, the view centre expressed in world coordinates and the command-line output.

   **Assertion:** P1 must remain visible and the world view centre must be approximately (0,0), with P1 selected. The reviewed path targets approximately **(100000,0)** while printing `[CE] Selected 1 unconnected pits. Zoom fit applied.` In a diagnostic test profile, the drawing-service log's calculated centre supplies an additional exact assertion. Repeat after `UCS`, `World`: the target then becomes correct. Pass world extents through a world-coordinate zoom path, or convert them to UCS exactly once before the existing helper.

---

1. **Completion and limitations.** All 112 requested files were read. Five distinct findings were retained; speculative candidates and the earlier audit findings were excluded. The five deterministic scenarios are instructions, not executed tests: **builds 0; automated tests 0; AutoCAD tests 0**. No client data, source changes, new branch, worktree, deployment or PR belongs to this hunt. CE_PLAN is the sole authorised documentation commit/push destination; only `areas/CODEX_SWEEP_S02_23OCT.md` is staged by name.

2. **Summary — under 100 words.** One HIGH and four MEDIUM findings remain: an older pipe's width can be written 1,000 times too large, rotated FALL arrows can escape checking, Inspector mislabels metre lengths, edited pit labels stop accepting style changes, and health navigation misuses UCS coordinates. All are verified-by-reading at the pinned Civil release. Each has a deterministic synthetic AutoCAD test. Nothing was built, tested, installed or fixed. Prioritise the diameter write and fall-arrow check before the Civil + Manager colleague release on 9 November.
