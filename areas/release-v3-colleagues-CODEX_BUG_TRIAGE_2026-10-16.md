# Codex native findings: triage into lane fix queues (desk plan/03, Fri 16 Oct 2026 evening)

Source: Codex's 762 native AutoCAD checks (592 PASS / 139 FAIL / 7 BLOCKED / 24 UNPROVEN), 81 new bugs BUG-570..650, and three read-only code-location passes (Civil UI, Civil engine, Structural) done 16 Oct by Opus agents at Civil 48662ddd / Structural f180b349. "Cause" below is from READING the code, not from a run: every cause needs its RED test first. Nothing here is FIXED until Tim confirms in AutoCAD.

## 1. ANSWER FIRST: the ten that can put a wrong number or lost data on a real drawing

1. **BUG-650 (HIGH, lost data):** cancelling CDFW or CDSOURCE blanks the stored invert level of existing pits (P1, P2 20.000 and 19.800). Cause: every source command starts with a full drawing refresh (`InitServicesFull` then `SyncWithDrawing`, ProjectDataService.cs ~249/575) and `RefreshPitMetadataFromDrawing` (~856, key line ~985) copies the cover label back into the pit record. A label with a CL line but no IL line gives an empty invert, written over the stored level and saved at once (`SaveProjectData(db, immediate:true)`). A pipe-based refill (`DeriveMissingPitInvertsFromPipes` ~488) puts it back in memory only, which fits "blank after Cancel, restored after save and reopen".
2. **BUG-574 and BUG-290:** same path (PitEditCommand.cs:64 calls the same refresh): Edit Pit Bottom shows blank after a cover-only save.
3. **BUG-649 (HIGH, misleading verdict):** a rising above-ground drain towards its outlet passes "meets office minimum": `BuildGradeCheckText` (AgiCommand.cs ~281) uses `Math.Abs(start - end)` and never asks which end is the outlet.
4. **BUG-643 (wrong area):** CDCATCHMENT area ignores arcs (vertex-only `SignedArea`; bulges dropped in `TryPickPavedOutline` ~140). Also PAVE (`PavementAreaPlan` ~97-130) and probably the slab boundary plan. 22.28 m2 expected.
5. **BUG-605 (blank inverts on LandXML import):** `BuildImportedPitData` always sets `InvertLevel` to empty and the LandXML path never runs the derive steps the X-Civil path runs; the parser also matches each Invert twice.
6. **BUG-592 / 593 / 597 (stale or zero shown as a result):** a blank grade or area keeps old Q or shows 0.00 in the window, draft and export. PR #1259 fixes the window; its export still prints 0.00 (review verdict: two-line export change needed).
7. **BUG-637 and BUG-586 (pit schedule remarks lost or rewritten):** custom note erased next to "With Step Irons" (three composers and two cleaners with a whole-line regex); DUP (Structural, `BulkDimensionUpdate`) opens every entity including pit blocks for writing, which fires Civil's link refresh and rewrites the schedule cell.
8. **BUG-590 / 591 (calc export):** pages 2+ and XLSX tabs drop the DRAFT state; numbers saved as text.
9. **BUG-583 / 617 / 638 / 636:** Structural commands write without a locked-layer check (ABS switch, Xref normalise, DSET1, DUP).
10. **BUG-619 / 618:** CEHATCHAUDIT and CEHATCHCHANGE fail (eInvalidKey) because risky AutoCAD 2027 hatch getters are read inside the caller's transaction (own comment in HatchPersistencePolicy ~565); the fix pattern already exists in `CaptureDirectNewPersistedFacts`.

## 2. Shared fixes (one change clears several bugs) — do these first

CIVIL ENGINE
1. **No full refresh before the first question; keep a stored pit level when the label has no IL line** (clears 650, 574, 290; lowers risk in CDCATCHMENT and CDIMPORTLANDXML). Use the 2f3f4df6 pattern: `BindToDrawingWithoutSaving` instead of `InitServicesFull`; and in `RefreshPitMetadataFromDrawing` clear an invert only if the label used to show it. RED test: invert 20.000, label with no IL line, result stays 20.000.
2. **One read-only loader for "no record loaded yet"** (`TryReadProjectWithoutChanging` instead of `TryPeekCurrent`): clears 589 (and the lost fit warnings) and the "not recorded" part of 572.
3. **One polyline-area-with-arcs helper** (densify bulges or `Curve.Area`): clears 643, PAVE, helps 641 (real per-pit regions).
4. **One LandXML-to-shared-level mapper** plus preview-then-Apply with source-aware wording: clears 605, 603, 604, 602.
5. **One "Unknown, not zero or blank" state** across window, draft, preview and export: clears 592, 593, 597, 582, 573 (compare numbers at displayed precision), 607 (missing items count against the score).
6. **One "surface drain is not a pit" predicate** (STRIPDRAIN, AGI, PERIMETER rows left out of the pit-identity backfill, as BUG-139 did for tanks): clears the 647 CDFW refusal; the full fix (own record and ownership so MOVE carries children, also 358) is larger.
7. **One direction-aware AGI grade builder:** 649 first, then 648 (the label needs a correct grade).

CIVIL UI / WINDOWS
8. **One canonical remark model** (custom note and a generated step-irons suffix kept apart; one composer; one cleaner): clears 586, 637 (together with the DUP change below), makes 587 row heights predictable.
9. **One schedule cell formatter** shared by placement, Changes and Excel: clears 573 and the numeric part of 571.
10. **One calc-export writer** (job and issue state on every PDF page and XLSX tab, typed cells): clears 590, 591.
11. **Boyd's-to-sheet transfer** (rainfall curve actually used, critical duration): clears 249 and the critical-duration gap; 515 is covered by PR #1257.

STRUCTURAL
12. **One locked-layer check before opening for write** (`LayerService.FirstLockedLayer`): 583, 617, 638, and DUP (636/637).
13. **One save-and-restore of drafter settings helper** (`LegacyToolCommon.CaptureSysvars/RestoreSysvars`; DIMSTYLE through the database): 621, 646.
14. **One drawing-scale rule** (proportional to DIMSCALE, CANNOSCALE fallback; `ScheduleService.ResolveDrawingScale` and `HatchPreviewGeometry.ResolveScale` already exist): 614, 628, 454, 531.
15. **Compound/group identity** (copy the `SbeamCompoundStore` Group pattern): 613, 627, 631, 625 ownership.
16. **Preview, then Apply** (needs windows; Codex builds them after 22 Oct): 615, 616, 625, 626, 630, 634, 636, 645; the prompt-order and F-keyword work also covers 622, 640, 644.
17. **Name the real cause and log the stack instead of a catch-all message:** 577, 612, 618.
18. **Read the risky hatch getters in their own transaction:** 619 (both commands).

## 3. Queues per lane (ordered; each = one DRAFT PR, failing test first, Settings-backed, no hard blocks)

### build/03 Civil engine + Manager + shared
1. Shared fix 1 (650, 574, 290). 2. Shared fix 2 (589, 572). 3. BUG-649 then 648 (AGI). 4. Shared fix 3 (643, PAVE; slab check). 5. Shared fix 4 (605, 603, 604, 602). 6. Shared fix 6, filter part (647). 7. BUG-573 + 607 + 582 (Unknown state). 8. BUG-588 (saved list leaves out fall-arrow findings; `SaveListing` signature). 9. BUG-594 (call `StormReport.ParseAnyRatingReport`). 10. BUG-599, 600, 601 (CDPROFILE linetype preflight, title layout, redraw flag). 11. BUG-606 (report location). 12. BUG-358 (MOVE of a source block leaves the pipe end). 13. BUG-641, 642 (catchment overlay). 14. BUG-581 (Manager Help Start tool). 15. BUG-256 hooks as per sweep (PostUndoWriteWatch, RedoWindowGuard, CivilProjectQaAutomaticService :275/:685).

### build/04 Civil UI / calculations / schedules
1. PR #1259 fix (export reads the Unknown state), then BUG-592/593/597 (the Unknown state in Pipe Flows, Catchments, Charged) with the RED tests in #1258, each test file moving into its fix. 2. BUG-596, 598 (covered by #1259). 3. BUG-590, 591 (export writer). 4. BUG-586, 637 Civil half (remark model + composer; DUP half is build/02). 5. BUG-571 (Excel: typed cells, header width, secondary-row pit number). 6. BUG-587 (remark overflow: row height planner). 7. BUG-570 (Edit Pit preview caption and pending label). 8. BUG-595 (CDCALC nested dialog Escape; suspect: parent IsCancel). 9. BUG-360 (pipe picker shows raw handles). 10. BUG-249 and the critical-duration gap. 11. BUG-515 (covered by #1257). 12. BUG-580 (#1255), 576 (#1261), 611 (#1262) once merged.

### build/02 Structural
1. Shared fix 12 (583, 617, 638, then DUP 636/637: open only dimensions and leaders for write). 2. Shared fix 18 (619). 3. Shared fix 14 (614, 628, 454, 531). 4. BUG-585 (Esc at the purlin lap keyword places a purlin: needs `else return;`). 5. BUG-633 (DSET rejects rotated dimensions: `AddAllowedClass(typeof(Dimension), false)`). 6. BUG-578, 579 (footing key format; Depth never set). 7. Shared fix 13 (621, 646). 8. BUG-504 (empty wind class saved). 9. Shared fix 17 (577, 612, 618). 10. BUG-629 (BL and `CreateTextEntity` into ModelSpace instead of the current space). 11. BUG-620, 617 (Xref normalise outside the undo scope and at FASTSAVE). 12. BUG-575 (Settings shows a stale package version). 13. BUG-609, 608, 610 (checklist). 14. BUG-584 (visible failure for dynamic property setter). 15. BUG-632 (section mark identifier hidden), 635, 623, 622/624.

## 4. Questions for Tim (answer by number or "as recommended"; builders do not wait, they use the recommendation as a DRAFT default behind a Settings switch)

1. **Rising above-ground drain (649):** what should CE say when the drain rises towards its outlet? Recommend: a clear fail, "falls the wrong way (rises 200 mm towards the outlet)". 
2. **Grade label on an above-ground drain (648):** draw "1 in N" next to the drain? Recommend yes, Settings text height, off for existing jobs.
3. **Stored pit levels (650):** a cover label without an IL line must never blank a stored invert. Recommend: confirm (no other behaviour wanted).
4. **Hatch scale rule (614):** hatch and break sizes scale with DIMSCALE (LTSCALE = 10 x DIMSCALE) for any scale, not only 1:20 and 1:100. Recommend yes.
5. **Pit Schedule remarks (586/637):** the custom note and "With Step Irons" kept as two parts, step irons added or removed by the tick only. Recommend yes.
6. **Excel exports (571/591):** numbers saved as numbers; "Unknown" stays text. Recommend yes.
7. **DRAFT stamp (590):** the "DRAFT - NOT FOR CONSTRUCTION" line and job name on every PDF page and every Excel tab until the sheet is issued. Recommend yes.
8. **Locked layers (583/617/638/636):** commands that would write to a locked layer stop up front with one sentence naming the layer. Recommend yes.
9. **LandXML import (603):** preview the pits and pipes before anything is drawn. Recommend yes.
10. **Footing label height (454):** label height from the drawing scale (Settings plot height 2.5 mm x annotation scale). Recommend yes.
11. **Wind class (504):** pressing Enter with nothing typed keeps the old value. Recommend yes.
12. **Still open from earlier batches:** Batch 6 Q1 and Q5 (wrong survey level, nearest spot level distance), Set C Q5 (minimum cover 300 or 600), the clearance numbers.

## 5. Test plan for what is untested (ranked by risk to a real job; Claude robot first, Codex after its reset Thu 22 Oct 17:13)

1. Pit and pipe numbers on a drawing sent to council: CDCALC criteria table, pit schedule vs drawing agreement, long section figures. 2. Source commands: CDSOURCE Custom, duplicates, connected MOVE/COPY, other categories, preview, plot. 3. CDWT modes, capacities, compound grouping, Cancel. 4. Schedules and publishing: Excel intake, calculation links, engineering-edit previews, read-only sheet scan, QA gate, isolated PDF publishing and overwrite protection (ST07: 3 partial, 12 untested). 5. Structural shared supports, foundation hosts, COPY identities, regeneration, reinforcement. 6. Repair and migration: all 15 CV08 requirements. 7. Different units and UCS, paper space, older AutoCAD (2022 to 2026 never run), plots, performance.

## 6. The four figures (honest)

1. **Built:** about 60 percent (last recount 12 Oct, estimate; denominator about 1,000 = 509 UX IDs + open bugs). 2. **Installed:** about 53 percent at 12 Oct, a little higher after 3.0.50 and 1.0.117. 3. **Codex-tested:** UNKNOWN as a percentage: 762 scoped native checks touch 104 of 523 installed catalogue entries and 94 bug IDs; 12 of 39 plan cards audited in full (180 of 600 numbered requirements). A PASS here is a bounded check, not a whole workflow. 4. **Tim-accepted:** 0.
