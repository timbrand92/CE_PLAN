**ANSWER FIRST — Structural command hunt, 22 October brief; reviewed 23 October 2026, Melbourne**

1. **Counts: HIGH 2 / MEDIUM 3 / LOW 0.** Four findings are verified by reading; one MEDIUM is suspected and needs its intended behaviour confirmed. None has been run in AutoCAD during this hunt.

2. **Most important: SBEAM can put the member somewhere other than where you picked.** In a shifted or rotated UCS, it uses the local point numbers as World coordinates. For example, a beam picked beside a detail at World X = 10000 can appear near X = 0 instead.

3. **Other confirmed faults.** CSREOBAR can shorten a sloping bar after showing the correct length in its preview; its length calculation also uses metres for millimetres drawn directly on a layout sheet. CEHATCHCHANGE cannot complete a preset change on a non-associative hatch.

4. **Delivery and limits.** Only this report was authored. No code change, branch, build, test, AutoCAD launch, installation or sub-agent. The tests below are for a later AI tester on synthetic drawings; Tim is not being asked to test. Existing audit findings are excluded from the counts.

---

1. **Evidence boundary.** Source was fetched and read through Git in `C:\Lisp Files\CE_ACAD_PLUGIN`. All source references below are at `origin/claude/rel-20261022s2`, commit `2c9a96942a024888a5ab520600f2d5025de83036`, the brief's Structural 1.0.121 baseline. No checkout files were used as source authority. The installed binary was not independently inspected.

2. **Prior work and exclusions.** Read `AUDIT_C58_C60_S40_S41_2026-10-22.md` and the available `CODEX_AUDIT_STRUCTURAL_22OCT.md`, `CODEX_AUDIT_CIVIL_22OCT.md` and `CODEX_AUDIT_GATE_22OCT.md`. Excluded their CEMEMBER unit/UCS/scale faults, standard-name hidden-layer overwrite, invisible-layer warning, hatch scale fallback and paper-density issues, missing Settings controls and command-outcome classification. The SBEAM finding below is a separate, unconverted command route; it is not CEMEMBER's already-reported loss of Z after conversion.

3. **Severity and certainty.** HIGH means materially wrong placement/length or a consequential drawing change. MEDIUM means a supported context cannot complete correctly or a significant interpretation risk. Verified-by-reading proves the active path and arithmetic, not native acceptance. Suspected means the stated behaviour is visible in source but its classification as a defect needs further evidence. No item is marked fixed or accepted. R-27 remains in force; correction directions do not propose new engineering hard stops. Engineering values remain Settings responsibilities under R-00. Civil + Manager's 9 November release and parked Manager administrator work are unchanged.

**Numbered findings**

1. **SC-01 — HIGH — SBEAM loses the picked location in a non-World UCS. Verified-by-reading.**

   **File:line:** `Modules/Structural/Commands/SectionDetailCommands.cs:26`; `Modules/Structural/Commands/SbeamCommandRunner.cs:164`, `:191`, `:234`; `Modules/Structural/Services/SbeamAtomicPlacementWriter.cs:255`, `:355`, `:456`.

   **What happens in AutoCAD:** A drafter sets a UCS at a detail or aligns it to a skewed building, then picks a beam. SBEAM draws at different World coordinates. The section route has the same missing position conversion. This is a location error even when the UCS has only been moved, so it does not depend on a decision about section orientation.

   **Exact failure scenario:** Both prompt routes call `ToPoint2` directly on `GetPoint` results. That helper copies X/Y without `CurrentUserCoordinateSystem`. The writer converts those numbers to World X/Y/Z=0. Its section transform contains only the plan's flip, turn and translation; no later UCS conversion repairs the error. The command entry delegates directly to this runner.

   **DETERMINISTIC TEST — fixture:** Empty synthetic mm model drawing; INSUNITS 4, DIMSCALE 100, LTSCALE 1000, OSMODE 0, DYNMODE 0. Preload the ordinary SBEAM output layers and linetypes. Draw a witness line in World coordinates from `10000,20000` to `13000,20000`.

   **Typed steps:** `UCS`, `World`; `UCS`, `Origin`, `10000,20000,0`. Type `SBEAM`; select `310UB32`, `Side Elevation`, scale `Auto`, elevation reference `Centre`, then click `Place`. Answer `None` for break-line ends. Type local start `0,0`, end `3000,0`, then Esc. Return to `UCS World` and use LIST/Properties on the beam outline lines.

   **Assertion:** The elevation must be centred on the witness, with end stations World X = 10000 and 13000. Source predicts end stations 0 and 3000 and centreline Y = 0 instead of 20000. The command still prints `SBEAM placed 310UB32 (1). Pick again or press Escape.` Check one immediate `U` removes the complete beam and label while preserving the witness; that Undo result is pending.

   **Second case and correction direction:** On a fresh fixture use `UCS World`, `UCS Z 90`, `PLAN Current`; repeat the local picks. Expected World axis is (0,0) to (0,3000), not (0,0) to (3000,0). Convert picks and preserve the intended drawing plane consistently before planning/writing. Do not change catalogue dimensions to compensate for a coordinate error.

2. **SC-02 — HIGH — CSREOBAR previews the true sloping length, then writes a shorter flat extent and note. Verified-by-reading.**

   **File:line:** `Modules/Structural/Services/ReoBarService.cs:130`, `:142`, `:188`, `:192`, `:486`, `:637`, `:745`, `:762`.

   **What happens in AutoCAD:** A bar picked between points at different heights can show 5000 mm in the preview and completion line, but end up with a 3000 mm extent and a 3000 mm drawing note. A subsequent bar schedule also uses the shorter length. A tilted UCS or snapping to 3D detail geometry can expose this.

   **Exact failure scenario:** The preview note uses the full 3D endpoint distance. `BuildBarEntities` puts only the four vertices' X/Y into a 2D polyline and assigns every vertex the first point's elevation. It sets no matching plane normal. Before committing, `RefreshInTransaction` reads that flattened polyline's length and calls `UpdateNote`, replacing the original note. The completion line still prints the original local `note` string. Thus the command itself can produce contradictory evidence without a later stretch.

   **DETERMINISTIC TEST — fixture:** Fresh synthetic mm model drawing, World UCS, DIMSCALE 20/LTSCALE 200, OSMODE 0, DYNMODE 0. Isolated default reo settings: length rounding 0, default note template, unlocked output layers. No existing bars or schedule.

   **Typed steps:** `CSREOBAR`, `N16`, count `3`, spacing `100`, face `Top`; start `0,0,0`, end `3000,0,4000`. Read the Preview line, then answer `Yes`. Select the new extent and note and read Length, endpoint Z and Contents in Properties. Run `CSBARSCHEDULE`, place at `10000,0,0`, and read the BM1 length cell.

   **Assertion:** Preview, completion, drawing note and schedule must agree on 5000 mm, and the final extent must join the picked endpoints. Source predicts preview/completion contain `x 5000 LG`, while the extent length, note and schedule give 3000 mm; the second endpoint has Z = 0 rather than 4000. Use a 0.01 mm geometric tolerance. This is a 40% shortening, not a rounding difference.

   **Tilted-UCS repeat and correction direction:** On a fresh copy, `UCS World`, `UCS Y -53.130102354`, `PLAN Current`; pick local `0,0,0` and `5000,0,0`. Assert the same 5000 mm length and plane preservation. Draw the extent and annotation in a consistent plane and derive preview/final measurements from the same geometry. A passing note-format unit test cannot detect this mismatch.

3. **SC-03 — MEDIUM — CSREOBAR applies model units to lengths drawn directly on a layout. Verified-by-reading.**

   **File:line:** `Modules/Structural/Services/ReoBarService.cs:138`, `:165`, `:424`, `:490`, `:878`, `:896`; `Modules/Structural/Core/Rebar/ReoBarCore.cs:162`.

   **What happens in AutoCAD:** On a millimetre layout in a metre drawing, a 100 mm bar extent is labelled 100000 mm long. Text and arrows look sensibly sized because their layout handling is separate. A plotted note or schedule can therefore be wrong while its appearance looks normal.

   **Exact failure scenario:** The command explicitly writes to `CurrentSpaceId`. Annotation sizing recognises paper space and uses one drawing unit per millimetre there. Initial and refreshed bar lengths instead always multiply by the drawing's INSUNITS factor. INSUNITS 6 supplies 1000, including when the extent belongs to the layout. Refresh calculates one factor for all bars, even if model-space and layout bars coexist.

   **DETERMINISTIC TEST — fixture:** Two otherwise identical synthetic drawings with a millimetre layout plotted 1:1. One has INSUNITS 4, the other INSUNITS 6. In each enter that layout and type `PSPACE` so CVPORT is 1. Use World UCS, length rounding 0, the default note template and unlocked layers. This is a full-size paper detail, not a model viewport or a reduced-scale detail.

   **Typed steps:** In each drawing type `CSREOBAR`, `N16`, `3`, `100`, `Top`, start `20,20`, end `120,20`, `Yes`. Read the preview, note Contents and extent Length. Type `CSBARSCHEDULE`, place at `20,100`, and read the length cell.

   **Assertion:** Both layouts contain a 100 mm extent and must report length 100 mm. Source predicts the metre drawing reports 100000 mm in preview, note and schedule, while the mm drawing reports 100 mm. As a control, in metre MODEL space an extent of 0.1 must correctly report 100 mm. Correction must choose units from each extent's owning space during refresh; checking only the currently active tab is insufficient for a mixed-space drawing.

4. **SC-04 — MEDIUM — CEHATCHCHANGE rejects an ordinary non-associative hatch after changing it. Verified-by-reading.**

   **File:line:** `Modules/Structural/Commands/HatchUpgradeCommands.cs:208`, `:248`, `:255`, `:503`, `:513`, `:601`; `Modules/Structural/Commands/HatchPersistencePolicy.cs:250`, `:254`, `:955`.

   **What happens in AutoCAD:** Select an existing hatch whose boundary is no longer linked, choose a CE preset and apply it. Instead of changing its appearance, CE enters its failure/rollback route. Selecting one such hatch alongside healthy hatches makes the whole batch fail verification. Non-associative hatches are ordinary drawing content, not missing geometry.

   **Exact failure scenario:** Selection admits every HATCH. Applying the preset changes layer/colour/pattern/scale/angle but neither creates boundary links nor changes Associative. Final verification unconditionally demands Associative=true and valid non-empty boundary links, even when the captured original had none. That invariant belongs to new associative hatches; preserving an existing hatch's valid non-associative state cannot satisfy it. The fault does not require a native exception during the property change.

   **DETERMINISTIC TEST — fixture:** Synthetic mm model drawing, World UCS, valid DIMSCALE 20/LTSCALE 200. Two closed rectangular boundaries, 5000 by 3000 mm. Create native ANSI31 hatches at scale 50, angle 0, Background None: H-A with Associative Yes and H-B with Associative No. Confirm both still have visible filled geometry. Set CLAYER 0; leave all involved layers unlocked.

   **Typed steps:** Type `CEHATCHCHANGE`; select only H-B, Enter. In the preset window choose `Solid 10`, click `Apply preset`. Solid 10 avoids the unrelated patterned-background clearing restriction. Repeat on a fresh copy selecting H-A and H-B together. Read command-line text and both hatch properties after the command returns.

   **Assertion:** A successful preset change must produce SOLID on HATCH 10 while preserving each hatch's original boundary relationship and geometry. Source instead reaches the failure text containing `AutoCAD did not retain the required hatch state:` and `not associative`/`boundary links`, then attempts rollback. Assert both original hatches survive with their original properties if it fails; rollback success is not claimed from this reading. For a fix, verify preservation against the captured association state rather than imposing new-hatch requirements on old objects. Do not manufacture boundaries without the drafter choosing that operation.

5. **SC-05 — MEDIUM — Audit Repair can replace an office hatch solely because it shares a CE layer. Suspected defect; replacement path verified-by-reading.**

   **File:line:** `Modules/Structural/Commands/HatchUpgradeCommands.cs:333`, `:342`, `:369`, `:413`, `:455`, `:541`, `:552`; Earth definition at `Modules/Structural/Commands/HatchCommands.cs:73`.

   **What happens in AutoCAD:** An office uses a different ground hatch on HATCH EARTH. Audit classifies it as an incorrect Earth preset and Repair changes it to EARTH. The concluding message says custom hatches were untouched, but the recognition step checks only the layer before forcing a closest preset.

   **Exact failure scenario:** Only an empty same-layer candidate list increments Custom/unmatched. `FindClosestPreset` always takes the nearest candidate, even when every pattern differs; its mismatch penalty is not a rejection threshold. With only the Earth preset on HATCH EARTH, any other pattern wins that match. A valid associative boundary and proven Background None then admit repair.

   **DETERMINISTIC TEST — fixture:** Synthetic mm model drawing, DIMSCALE 20/LTSCALE 200. One native associative ANSI31 hatch, scale 8, angle 45 degrees, Background None, ByLayer colour, on an existing unlocked HATCH EARTH layer. Preserve its rectangle and record the hatch handle. No other hatches.

   **Typed steps:** `CEHATCHAUDIT`, `Report`; capture counts and issue text. Then `CEHATCHAUDIT`, `Repair`; read the same hatch's Pattern name, scale, angle and boundary association. Immediately `U` and read them again.

   **Assertion for the custom-preservation interpretation:** Report must identify this as custom/unmatched and Repair must leave ANSI31 unchanged. Source predicts `Custom/unmatched 0`, an issue naming preset Earth, and replacement with EARTH, scale 8, angle 45. It then reports a repaired hatch while saying custom hatches were untouched. Undo restoration remains a native check.

   **Why suspected:** The source proves the replacement, but the read material does not establish whether Tim intends every hatch on a standard layer to be normalised regardless of authorship. If that is the approved meaning of Repair, this is not a defect and should be removed from the confirmed queue. Do not silently assume ownership from a layer name when resolving it; record the intended scope or present the proposed replacements before applying them.

**Requested corner-case coverage — checks prepared, not additional findings or test results**

1. **Esc before placement.** On independent clean fixtures run CSREOBAR and cancel separately at size, count, spacing, face, first endpoint, second endpoint and `Place this reo bar?`; also answer No at the last prompt. Assert no new extent, note, mark, CE_REO_BARS record or output layer. The read path first creates layers after confirmation (`ReoBarService.cs:145`, `:157`).

2. **SBEAM Esc and whole-member Undo.** Cancel the picker, the break-end prompt, the first point, then the second point on independent copies. Assert no member entities or output-layer changes. In another run place two complete elevations, start a third, Esc at its end point. Require two complete members and no third fragment, then one immediate U removes both complete placements, their labels and compound records; REDO restores them. Repeat with a hatched hollow section and missing output layers. The outer run transaction starts only after a ready plan and admission, and the normal finish commits it (`SbeamCommandRunner.cs:99`; `SbeamAtomicPlacementWriter.cs:588`, `:629`). This is evidence of intent, not proof of native Undo.

3. **Hatch prompt cancellation and conversion cancellation.** In separate fixtures run each of LBUH, LBH, EH and CH with valid scale pairs. Esc at Objects/Points, at object selection, at the first internal point and after one internal point. Assert no hatch/layer changes and unchanged CLAYER/HPNAME/HPSCALE/HPANG/HPASSOC/HPLAYER/HPBACKGROUNDCOLOR. The points collector returns null on Esc rather than completing the collected points (`HatchCommands.cs:1701`). For CEHATCHCHANGE, cancel selection and then cancel the preset window; for CEHATCHAUDIT, Esc at mode. Require no changed hatch properties or layer definitions. Repeat successful placement followed immediately by U, checking the pre-existing boundary survives.

4. **CEMEMBER.** Read its prompt returns, per-member transactions and section/line writers. No additional cancellation defect was established. Its already-recorded prompt-by-prompt and whole-run Undo recipes in CODEX_AUDIT_STRUCTURAL_22OCT.md remain pending; they are not counted again here. Cancel after one complete member and halfway through the next must retain only the first; native Undo/Redo must be measured with no diagnostic command inserted before U.

5. **New versus existing layers.** CSREOBAR and hatch placement call the shared LayerService helper, which returns an existing layer unchanged (`LayerService.cs:193`, `:198`). Later testing should compare colour, linetype, weight, plot, lock and visibility before/after a successful placement and one U, using both absent layers and existing office layers. Keep the already-known SBEAM/CEMEMBER hidden-layer overwrite separate. CSREOBAR has explicit hidden-layer notices; no new visibility defect is claimed here.

6. **Units, scale and rotated views.** SC-01 to SC-03 isolate new position/length faults. Earlier CEMEMBER and hatch-density findings already cover metre geometry, layout scale, annotation fallback and unusable scale pairs. A rotated view alone is not the same as a rotated UCS: use a World-UCS/view-twist-only control when running SC-01. No new Australian Standard value or engineering acceptance is inferred from these software calculations.

7. **Publication scope.** CE_PLAN was fetched and merged with `origin/main` using `git merge --no-edit`, never rebased. The only authored/staged path is `areas/CODEX_HUNT_STRUCTCMDS_22OCT.md`. Other working files are excluded. Publishing uses the normal leak-scan hook; no code PR, code commit, regression-log edit or build artifact is part of this hunt.

**Summary — under 100 words**

1. **Summary.** Five findings: two HIGH and three MEDIUM, including one explicitly suspected Audit Repair policy issue. Four source-proven faults concern SBEAM's UCS coordinates, CSREOBAR's flattened sloping extent, layout length units and CEHATCHCHANGE's rejection of non-associative hatches. The report supplies deterministic drawing checks and cancellation/Undo coverage. Earlier CEMEMBER, layer and hatch-scale findings are excluded. No build, test or AutoCAD run occurred; nothing is marked fixed or accepted. Only this report is published.
