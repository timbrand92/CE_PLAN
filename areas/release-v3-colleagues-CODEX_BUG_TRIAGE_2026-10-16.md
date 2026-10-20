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


## 5. Hunt Civil E fixes (17 Oct)

Added Sat 17 Oct 2026 night by the desk (job "file the hunt findings and queue the fixes"). This is a second section 5 appended after section 6, as briefed; sections 1 to 6 above are unchanged. Source: `areas/release-v3-colleagues-HUNT_CIVIL_E_2026-10-12.md` (46 findings, read-only code audit of installed Civil 3.0.51; nothing seen in AutoCAD). Filed as BUG-652 to BUG-696 in `BUG_CARPARK.md` (45 new); finding D1 is a duplicate and became a note on BUG-561. Ruling A (17 Oct): keep fixing bugs. Nothing is closed or deleted, and nothing is FIXED without a real AutoCAD pass. Same rules as section 3: one DRAFT PR per line, failing test first, Settings-backed, no hard blocks.

**Shared root causes (one fix each, do not fix finding by finding):**

1. **One level-cascade routine** (BUG-652, 653, 654, 655, then 656, 657, 658): Edit Pipe "Recalculate downstream" and CDPROPAGATE share `BuildPropagationPlan`.
2. **Drawn order beats recorded direction** (BUG-659; BUG-664 reads the same stale notes): drawing-wide relinks ignore the recorded flow direction.
3. **Clones that keep the original's identity** (BUG-665, 666, 670, 671, 672): copies made by GRIP, ROTATE and SCALE bypass the copy clean-up, and the clone remap leaves four partner fields behind.
4. **Millimetres used as drawing units** (BUG-663, 695, 696): one conversion helper fixes all three (same family as R00_CIVIL items 54 and 55).
5. **Zero or blank read as a real level** (BUG-653 and BUG-686): one shared "level is known" test.
6. **Pit frame ignored** (BUG-675, 678, 679, and BUG-674 for the missing re-snap): rotated or batch-resized pits are handled in world X/Y.
7. **Decide before writing** (BUG-681, 682, 683): CD writes the schedule row, erases the source or works out a level, and only then asks the question.

### build/03 Civil engine, Manager, shared: 14 lines, HIGH first

1. **BUG-652, 653, 654, 655 (HIGH, wrong levels on the drawing): the cascade.** Pit drops vanish downstream, a blank level is read as RL 0.00, a kept typed level can write a back-fall past the safety check, and another pipe arriving at a junction is ignored. File and function: `Services/LinkService.RepairAudit.InvertPropagation.cs:274-278, 218-229, 186-199`; `Services/LinkService.RepairAudit.Graph.cs:212-232`; `Models/PropagationPlan.cs:51, 91-96, 147`. Failing tests first (pure, no AutoCAD, public `BuildPropagationPlan(graph, anchor, 9.80, null, Downstream, null)`): a two-edge graph with a drop expects 9.75 (BUG-652); a pipe with a blank end is skipped and named, never -0.15 or +17 m (BUG-653); a `PipeUpdate` with `DownstreamManuallySet` and levels 9.95 to 10.10 is blocked (BUG-654); a three-edge junction expects the lowest arriving level minus the drop, plus a warning (BUG-655). One PR.
2. **BUG-659 (HIGH): quiet relink reverses a pipe drawn from its low end.** P1 17.80 up to P2 18.00 recorded P2 to P1 becomes P1 to P2 after PITEDIT, Edit Pipe or the Inspector. File and function: `Services/LinkService.RepairAudit.Linking.cs:83-127, 303-305, 372` (`UpdatePipeEndpointsFromProjectData`, `RelinkAllPipesToPits`); `Rules/RecordedPipeDirectionRule.cs:24-27`. Failing test first: `RecordedPipeDirectionRule.FirstEndIsFrom(false, "P2", "P1", "P1", "P2")` must keep P2 as From; then a relink test on a two-pit graph. Related BUG-278, 268.
3. **BUG-561 plus finding D1 (HIGH): Edit Pit Save turns a detention tank back to square, and swaps the grate and solid sides near 180 degrees.** No new id: D1 is a note on BUG-561. File and function: `Commands/PitEditCommand.cs:1192-1195, 2103-2127` (`ResolveDetentionRotation`); `Commands/PitCommand.cs:839-840`. Fix commit `e54b0aa5` is not in installed 3.0.51: review it first and test the "Align to pipe at 30 degrees" case on it. Failing test first (make `ResolveDetentionRotation` internal): stored "0 deg" with a block rotation of pi must keep pi, not 0.
4. **BUG-665, 666 (HIGH): copies by grip-Ctrl, ROTATE Copy and SCALE Copy are twins; erasing a copied pipe erases the original's outline, barrels or breakline symbol.** Then BUG-670 (CDREBUILD cuts an old copied pit off, use `MakePitItsOwn`), BUG-671 (partial-label pipe copy) and BUG-672 (one locked layer stops all annotation on a copied pit) in the same clone family. File and function: `Services/ExternalMutationCommandPolicy.cs:13-46`, `Services/LinkService.Compound.cs:218-227`, `Services/LinkService.Utilities.cs:787-806` (`RemapClonePipe`), `Services/LinkService.CloneRepair.cs:117-131`, `Services/LinkService.CloneRegeneration.cs:75-113, 288-298`. Failing tests first: `ExternalMutationCommandPolicy.CanCreateClones("GRIP_STRETCH")` must be true; a `RemapClonePipe` test that the four partner handles are cleared or remapped; `Take` with the root handle as the expected owner skips a foreign member.
5. **BUG-667 (HIGH): erasing a pit label on its own breaks the link memory for the session.** Pipe MOVE stops moving labels, PITDELETE fails. File and function: `Services/LinkService.Cache.cs:579-586, 667-674`; `Services/LinkService.Utilities.cs:3098` (`TryGetObjectId`); `Services/LinkService.cs:524-527`. Failing test first: needs the headless AutoCAD harness; write a guard test that every cache reader checks `IsErased`, then the harness case (erase label, U, rebuild, PITDELETE).
6. **BUG-668 (HIGH): pipe callouts land in the wrong place after MOVE or ROTATE of a run.** File and function: `Services/LinkService.PipeAttachmentUpdates.cs:171-200` via `Reactors.cs:1123` (`ApplyExternalModifiedPipeUpdates`). Failing test first: a pure projection test where a saved arrow point on a pipe moved 5 m along itself keeps its station along the pipe.
7. **BUG-690, 691 (HIGH): a pit placed on a pipe leaves connection decisions and junctions on the wrong half, and splits a paired pipe wrongly (breakline, same-plan break, twin detention).** Then BUG-692 (callout follows its text, not its arrow) and BUG-693 (arcs) on the same inline route. File and function: `Services/LinkService.Split.cs:1523-1788, 1548-1553, 1697-1709, 1888-1909, 1628-1630, 2280-2333`. Failing tests first: a pure transfer of end decisions and junctions to the half they sit on (`SourceChangeDecisionPolicy.cs:66-80` is the tracked-route model); a paired-pipe split is refused with one plain line (levels 20.00 to 19.90 over 6 m + 4 m: split level must be 19.97 or refused, never 19.95).
8. **BUG-656, 657, 658 (MEDIUM and LOW): the cascade rewrites links on pipes the preview never listed, can change one level text but not its record, and opens its question inside Edit Pipe's change.** Do after line 1, same routine. File and function: `InvertPropagation.cs:682, 806-816`; `PipeEditCommand.Update.cs:524, 1906-1908`; `Services/RelinkedPipeRecordWriter.cs:156`. Failing test first for 657: both level texts are checked writable before either is written (locked-layer fixture).
9. **BUG-660, 664 (MEDIUM): a pit relink drops a skipped pipe off the pit's own list; a pit rename leaves the old name in its pipes' ownership notes.** File and function: `Services/LinkService.RepairAudit.Relink.cs:726-794`; `PitEditCommand.cs:1839-1862`; `ProjectDataService.Mutations.cs:1537-1575`. Failing tests first: a pipe whose far pit is on a locked layer stays on the list; rename P5 to P9, place a new P5, relink: the pipe stays on P9.
10. **BUG-661 (MEDIUM): PIPEPITLINK and CDPIPEOVERRIDE pick the wrong pipe end in a rotated UCS.** File and function: `Commands/LinkCommands.cs:1285-1292`; `Services/PipePickService.cs:53` (convert to world first, as `PitCommand.Orientation.cs:133` does). Failing test first: a pure pick-to-end test with a 30 degree UCS.
11. **BUG-662 (MEDIUM, data loss): CDUPGRADE Merge strips typed flags, From/To keys, system, fit openings and design flow from every pipe row.** File and function: `Commands/LinkCommands.cs:1061-1093`; `Services/ProjectDataService.Mutations.cs:755-760`. Failing test first: a merge round trip keeps every field the scan did not prove.
12. **BUG-669 (MEDIUM): a pit's labels stop following on the second move by Properties or detention MovePit.** File and function: `Services/LinkService.PipeMoveHelpers.cs:330-345`. Failing test first: a guard test that the followed set is cleared per command or scoped per call.
13. **BUG-663, 695, 696 (LOW-MEDIUM): millimetres used as drawing units in a metre drawing** (CDREPAIR reach 5 km, downpipe chainage 1,000 times too small, crossings within 1 m never offered a split). One conversion helper. File and function: `RepairAudit.Relink.cs:187-188`; `Split.cs:82` with `NewPipeEnds.cs:292-311`; `Rules/PipeCrossingSplitPolicy.cs:46, 64-65`. Failing test first: `PipeCrossingSplitPolicy.Splittable` with station 0.8 and length 30 offers the split; the reach is 5 m in a metre drawing.
14. **BUG-673 (LOW): label displacement memory misses every lookup on AutoCAD 2027 and grows all session.** File and function: `Services/LinkService.PipeMoveHelpers.cs:229-240`. Failing test first: a guard test for `Dictionary<Database,` without `DatabaseIdentityComparer.Instance`; clear it on drawing close.

### build/04 Civil windows, schedules: 11 lines, HIGH first

1. **BUG-674, 679 (HIGH): CDEDIT multi-resize leaves pipe ends 225 mm inside the grown pit; rotating a pit in Edit Pit leaves its pipes behind and the Align options do nothing.** Shared root: the re-snap is only called from single Edit Pit and Resize. File and function: `Commands/PitEditCommand.Batch.cs:625-647, 708-714`; `PitEditCommand.cs:413-418, 2118-2134`; `Dialogs/PitDialog.xaml:383-403`. Failing test first: a guard test that every resize and rotate path calls `LinkService.ReSnapLinkedPipesToPitBoundary`; the AutoCAD case is two 450 pits to 900, pipe ends must sit on the new wall.
2. **BUG-681, 682, 683 (HIGH, wrong levels and lengths): CD writes before it asks.** After the Uphill box the schedule row keeps the old pit order; Cancel says "erased" but leaves the polyline erased and the pit upsized; same-plan break works the level over the drawn length, not the real length (19.80 over 20 m instead of 19.50 over 50 m). File and function: `Commands/CdCommand.cs:405, 426, 723, 731, 739, 836, 856, 863, 949`; `CdCommand.Schedule.cs:54-73`; `LinkService.FlipPipeInverts` (`InvertPropagation.cs:1348-1394`); `CdCommand.cs:476-540, 586`; `CdCommand.SamePlanBreak.Atomic.cs:106`. Failing tests first: after a flip the schedule row From/To and both levels match the plan; same-plan break at 1 in 100, 20.00, real length 50 m gives 19.50.
3. **BUG-675, 678 (HIGH and MEDIUM): the pit-fit check and Upsize ignore pit rotation; label and cover text step the wrong way on a rotated pit.** File and function: `Commands/CdCommand.PitFit.cs:43-45, 71-74`; `Services/PipeFitsPitRule.cs:58-67`; `Helpers/PitAnnotationShift.cs` (`ComputeShiftedPosition`). Failing tests first: a 600 x 900 pit rotated 90 degrees with a 750 pipe along world X fails the fit; a 90 degree pit X 600 to 1200 moves the text out along the pit's own axis.
4. **BUG-684 (HIGH): CD "Existing line" straightens arcs, drops a closed polyline's last side, then erases the source.** File and function: `Commands/CdCommand.ExistingLine.cs:159-161, 253-288`. Failing test first: a polyline with a bulge or Closed flag is refused or warned, and the source is kept.
5. **BUG-677, 680 (MEDIUM, HIGH if it triggers): the pit number comes from the wrong place.** CDEDIT gives every pit without a record the same "next" number; CD Upsize takes the label text as the number and can delete another pit's record. File and function: `Commands/PitEditCommand.cs:1181, 593-596`; `Batch.cs:521-533, 735-743`; `PitEditCommand.Resize.cs:96-97, 143`. Failing tests first: two pits with no record get different numbers; a record P5 with label P8 is refused.
6. **BUG-676 (MEDIUM-HIGH): Edit Pit Save and Upsize rewrite the lid wording** ("Class D Heelguard Grated Lid" becomes "Class D Grated Lid", unknown wording becomes Class C). File and function: `Commands/PitEditCommand.cs:1199, 1819, 2236-2247`; `ViewModels/PitViewModel.cs:1290-1316`; `PitEditCommand.Resize.cs:143`. Failing test first: a view-model round trip leaves the lid text untouched unless the lid field was edited.
7. **BUG-687 (MEDIUM, data loss): changing only the design flow in Edit Pipe is thrown away.** File and function: `Commands/PipeEditCommand.cs:295-408` (`HasDialogChanges` never compares `FlowLps`). Failing test first: make `HasDialogChanges` internal; a Q-only change returns true.
8. **BUG-688, 689 (MEDIUM): batch Design grade rolls back the whole batch when a held end's text is off, and never checks pipes arriving at a calculated upstream level.** File and function: `Commands/PipeEditCommand.Batch.cs:481, 721-722, 1520-1531`; `Batch.Cascade.cs:599-656, 743-760`. Failing test first: the clash builder names P1 to P2 when P2 to P3 is given 9.30 against an arriving 9.20.
9. **BUG-686 (LOW-MEDIUM): a level of exactly 0.00 makes the flow arrow ignore the levels.** Shares the "known level" test with BUG-653 (build/03 line 1): use the same helper. File and function: `Services/PipeCreationService.PreparedOutputs.cs:267` (`ResolveArrowFlowInverts`). Failing test first: levels 0 and 0.5 point from the 0.5 end.
10. **BUG-694 (MEDIUM, plausible): a level typed in the Pit Schedule on a breakline pipe updates one half only.** File and function: `Services/LinkService.ScheduleLevels.cs:59-134`; `ViewModels/PitScheduleViewModel.Data.cs:1870-1885` (`MirrorGradeLockToPartnerHalf`). Failing test first: both halves take the typed level.
11. **BUG-685 (HOLD, needs Tim's ruling): "Work it out from the grade" rounds a typed 10.125 to 10.13.** Do not build. Two rules conflict (a typed level is never moved, INT-059 item 23; the rulebook locks inverts to 2 dp). Add to the section 4 questions for Tim; recommendation: keep the typed level exact and round only the calculated end. If he agrees: `Helpers/MathHelper.cs:319-333`; failing test first: `ApplyCalculatedInvertRule(10.125, 10.025, 2, 20, preserveInlet: true)` keeps 10.125.

### Codex look L1B and L2 fixes (18 Oct, installed Civil 3.0.54 / Structural 1.0.118)

Added Sun 18 Oct 2026 by the desk (job "file the Codex look results as bugs"). Source: CODEX_LOOK_L1B_20261018_0922.md and CODEX_LOOK_L2_20261018_1001.md (catchment and Structural looks). L3, L4 and L5 had no real results (L3 and L5 stopped at the start check, L4 never started), so nothing is queued from them. No item here is HIGH: none puts a wrong number on a drawing. Ordered by how much a drafter loses.

**Shared root causes:** catchment drawing is one routine that writes both the fill and the labels (BUG-641, 642) but they are two separate faults (no per-pit boundary; label placement), so two fixes. The DOTS fault (BUG-748) is the hatch-density-by-scale rule only; do not touch the AR-CONC hatch.

#### build/03 Civil engine: 2 lines, MEDIUM first

1. **BUG-641 (MEDIUM): the catchment fill shows one block, not one region per pit.** Draw each grated pit's share as its own region with a visible edge at the shared boundary (x=5000 in the symmetric two-pit case), keeping pits, pipes and the paved outline unchanged. Failing test first: a pure test that two pits sharing an 84 m2 outline produce two regions of 42 m2 whose union is the outline and whose shared edge is the midline; today it returns one region. The way paving is shared between pits is already a Tim design call (QUESTIONS section C item 4): use the recommended default behind a Settings switch.
2. **BUG-642 (MEDIUM): the P1 catchment wording lands on the pipe wording.** Place the catchment label clear of existing pit and pipe text and keep it inside the view the user zoomed to. Failing test first: a pure placement test that the label box does not intersect the pipe-label box in the two-pit case (P1 label against the 1 IN 48 pipe text); today the boxes overlap. Check with a Codex look afterwards, since the colour and backing are already improved.

#### build/04 Civil windows, schedules: none new

Nothing from L1B or L2 belongs to windows, schedules or spot levels.

#### build/02 Structural: 3 lines, MEDIUM first

1. **BUG-748 (MEDIUM): the DOTS hatch gets denser with scale (dots at 1:20, bands at 1:50, solid at 1:100).** One fix: derive the DOTS spacing from the plotted scale so paper density is constant. Failing test first: a pure test that the pattern scale times the drawing scale gives the same paper spacing at 20, 50 and 100 (within 20 percent); today 1:100 gives a spacing so small the dots merge. The 1:50 number is not approved: use the recommended default from QUESTIONS section F item 2 behind a Settings switch and say so in the log.
2. **BUG-749 (MEDIUM-LOW until reproduced): Section Mark identifier answer ends in a paste command.** First prove whether CE or the Codex typing caused it. Failing test first: a pure test that the identifier step takes B and 01 as answers with SectionMarkIdentifierInClearHalf both false and true and moves to the sheet question; if it passes today, queue a second Codex look rather than a fix, and keep BUG-632 (identifier against the filled half) waiting behind it.
3. **BUG-454 (look, not fix): footing label readability.** Height is now 250 units = 2.5 mm at 1:100, so no code change is queued; ask for another Codex look at a closer zoom to see the PF label legible. A failing test is only needed if that look shows it unreadable.

**Not queued (already approved or fixed-looking):** BUG-614 and BUG-628 were NOT SEEN on 1.0.118 (hatches accepted at 1:50, break about 2.1 mm at 20, 50 and 100). They stay OPEN until a real pass that includes the CEHATCH window route and a plot check. The dimension at 1:50 is a question (QUESTIONS section F item 1), not a bug.

### Codex look L3 and L4 fixes (18 Oct, installed Civil 3.0.54 / Manager 1.1.54 / Structural 1.0.118)

Added Sun 18 Oct 2026 by the desk (job "file the Codex look results as bugs"). Source: CODEX_LOOK_L3_20261018_1052.md (21 looks, 15 PASS, 6 FAIL) and CODEX_LOOK_L4_20261018_1119.md (17 looks, 2 PASS, 5 DIFFERENT, 3 BLOCKED, 7 NOT TESTED). Not queued: L1 (10:27) was BLOCKED on picking and viewer problems (the same catchment fixture worked in L1B), L5 stopped at its start check, and L4's seven live-cursor looks need a mouse the Codex tool does not have; those are re-look jobs, not code. No item here is HIGH: none puts a wrong number on a drawing. Ordered by how much a drafter loses; one fix per root cause. Nothing is FIXED without a real AutoCAD pass.

**Shared root causes:** none shared. The double-click on the pit label (BUG-430) and on the schedule table cell (BUG-396) are separate routes. BUG-749 (paste command) is queued as a Codex re-look, not a fix: it has now happened on two different commands with the same typing method.

#### build/03 Civil engine: none new

Nothing from L3 or L4 belongs to the engine. BUG-641 and BUG-642 stay as queued from L1B.

#### build/04 Civil UI, windows, schedules: 5 lines, MEDIUM first

1. **BUG-430 (MEDIUM): double-click on a pit label opens AutoCAD's own attribute editor, not Edit Pit.** The double-click on the pipe and on the invert text already opens Edit Pipe. Failing test first: the double-click handler for a block named PIT LABEL2 with tag PIT_LABEL resolves to Edit Pit for the owning pit (the old name was PIT LABEL; whether the handler only knows the old name is a guess, check first); today it returns no CE target.
2. **BUG-396 (MEDIUM): double-click on a placed Pit Schedule table cell opens AutoCAD's own text editor and never renames the pit.** Needs the route first (the finalizer found none). Failing test first: renaming the P2 cell to C2 renames the pit and its plan label together, and a second edit is refused if C2 is taken. Check the 'Undefined shape' messages (BUG-623) with the same drawing, since they appeared on this editor too.
3. **BUG-221 (MEDIUM): Manager status cards, version text runs into the 'Installed next start' text.** Failing test first: a render test of the card layout with a 40-character hash at 1311 x 1073 and 1920 x 1080, no text boxes overlapping; the recommended layout is a short version on top and the full hash in a copyable detail line.
4. **BUG-753 (MEDIUM-LOW): the Checks list names pipes by internal id.** Failing test first: the row text for a pipe with no tag contains no 'CE-CIV-PIPE-' id and still says which pipe; then a Codex look with a faster capture to see the Show where glow.
5. **BUG-754 (LOW-MEDIUM): Manager Dark theme tab text is pale on near-white.** Failing test first: tab foreground against background reaches 4.5 to 1 in Dark, Light and Follow AutoCAD. Do after BUG-221 (same window).

#### build/02 Structural: 4 lines, MEDIUM first

1. **BUG-751 (MEDIUM): CEHATCH cards show words ('No preview: the drawing scale is not valid') instead of pictures, and the Waffle preview is empty at DIMSCALE 1.** Failing test first: a pure test that a card image is produced for every library entry at scales 1, 20, 50 and 100. Do not change the 1:50 density rule here (BUG-614 and BUG-748 own it).
2. **BUG-750 (MEDIUM-LOW): SBEAM Side Elevation draws two solid lines inside the flange edges.** Failing test first: the Side Elevation geometry for 610UB125 has no horizontal segment between the flange edge and the web. Ask Tim before removing the dashed centre lines in Front Elevation (not part of the expectation).
3. **BUG-752 (LOW): long folder paths clipped on three Structural Settings pages.** Failing test first: a render check of System > Installation, Workbook files and Markup service with a 120-character path at 1407 x 965: wrapped or shown in full.
4. **BUG-755 (LOW): RC beam Type 2 and Type 6 pictures reach the top edge of their boxes.** Failing test first: each thumbnail's drawn bounds lie inside its picture box.

**Questions queued:** QUESTIONS_FOR_MONDAY.md section G item 1 (what a double-click on a downpipe should do).

## 7. Hunt Civil B fixes (18 Oct)

Added Sun 18 Oct 2026 by the desk (job "file the hunt findings and queue the fixes"). Source: `areas/release-v3-colleagues-HUNT_CIVIL_B_2026-10-12.md` (49 findings, read-only code audit of installed Civil 3.0.53: survey, spot levels, LandXML, X-Civil import, source tags; nothing seen in AutoCAD). Filed as BUG-699 to BUG-747 in `BUG_CARPARK.md` (49 new, none duplicates; BUG-743 and BUG-723 carry "related" notes to BUG-432 and BUG-512). Sections 1 to 6 and the Hunt Civil E section above are unchanged. Ruling A (17 Oct): keep fixing bugs. Nothing is closed, and nothing is FIXED without a real AutoCAD pass. Same rules as section 3: one DRAFT PR per line, failing test first, Settings-backed, no hard blocks.

**Shared root causes (one fix each, do not fix finding by finding):**

1. **LandXML reader uses invented names and unchecked guesses** (BUG-719, 720, 723, 724, 725, 728, 729): all in `Helpers/LandXmlParser.cs`; tests use CE's own invented attribute names, so green means nothing. Get one real Civil 3D export as a fixture first.
2. **Re-import erases before it asks, and erases the drafter's own pipes** (BUG-721, 731, 732): one cleanup routine, `ClearPreviousXcivilImportArtifacts`, used by both importers.
3. **One shared level reader** (BUG-699, 709, 711, 713, 714, 717): survey text, CDSL, the spot-level finder, CDSLAB and the X-Civil prefix mapping each parse "a level" their own way.
4. **Millimetres used as drawing units** (BUG-701, 705, 710, 718, 745; joins BUG-663, 695, 696 from the Civil E queue): use the same one conversion helper.
5. **Multi-word source names cut to the first word** (BUG-740, 741): one family function.

### build/03 Civil engine, import services, shared: 14 lines, HIGH first

1. **BUG-719, 720, 723 (HIGH): LandXML imports pits only, control pits come out double length, box pipes become round.** Then BUG-724 (material class overwritten), 725 (position scale), 728 (negative slope), 729 (unrounded rim level) in the same PR. File and function: `Helpers/LandXmlParser.cs:322-326, 246-250, 346-351, 466-484, 189, 446-460, 371-373, 236`. Failing tests first (pure): `TryParse` on two Structs and one Pipe using `refStart`/`refEnd` gives one pipe; a 0.9 x 0.9 control pit gives 900 x 900; a 1200 x 600 RectPipe is not "1200 RCP, Read"; "uPVC SN10" stays SN10. Confirm the attribute names against one real export before fixing, then add that export as a fixture.
2. **BUG-731, 732, 721 (HIGH, data loss): Replace erases the old import then draws nothing; it erases the drafter's own hand-drawn pipes; LandXML erases earlier imports without asking.** File and function: `Services/XcivilImportService.cs:240, 1903` (`ClearPreviousXcivilImportArtifacts`, move to the start of the insert phase in `ContinueXcivilImportAfterPreflight`); `Services/XcivilImportIdempotencyService.cs:128-136`; `Services/XcivilImportReportService.cs:690-747`; `Services/LandXmlImportReview.cs:46`. Failing test first: `BuildPreviousImportPipeRemovalKeys_HandDrawnPipeToImportedPit_WhenBatchTaggedPipesExist_Excluded`; then the headless case (Replace, Close at the review, nothing erased). One PR; these are the ones that delete real work.
3. **BUG-733 (HIGH): X-Civil merges two pits with the same cover level within 1.8 m.** File and function: `Services/XcivilEntityScanner.Pits.cs:474-482`. Failing test first: `ConsolidateXcivilPitCandidates_DifferentPitIdsSameCoverWithin1800_KeepsBoth`.
4. **BUG-730 (HIGH): a good DWG pit schedule table is replaced by the weaker text guess.** File and function: `Services/XcivilScheduleService.cs:169, 176` (line 176 becomes `scheduleEntries.Count == 0`). Failing test first: `ApplyXcivilScheduleData(pits, texts, null, null, ...)` with GN-ANNO-TABL texts keeps source "DWG block". Do with BUG-737, 738, 739 (same file).
5. **BUG-722 (HIGH): a clashing LandXML pit number takes over the drafter's own pit.** File and function: `Services/ProjectDataService.Mutations.cs:374-380`; `Services/XcivilImportService.cs:1957`; `Helpers/LandXmlParser.cs:137-146`. Failing test first: a file with two networks both holding "Structure - (1)" lists the clash as a Check item and draws nothing over it.
6. **BUG-699, 709 (HIGH): CDSURVEY drops every level above RL 500 or below RL 0.** File and function: `Services/SurveyService.cs:627-638` (`TryParseRl`), `:162-173`. Failing tests first: `TryParseRl("616.250")` and `("-0.350")` succeed; fix the existing `TryParseRl_VariousInputs` cases that encode the wrong answer. One-line fix plus the text patterns; take the shared parser (root cause 3) from build/04 line 2 once it lands.
7. **BUG-700, 701, 705 (HIGH): a metre survey XREF in a millimetre drawing gives levels 1000 times too high; the intake checks treat mm as metres and can hang; a unitless metre drawing ignores the reach limit.** File and function: `Services/SurveyService.cs:107, 160, 201-213, 521-536`; `Services/SurveyIntakeSanityService.cs:46-47, 70-71, 84, 303, 420-437`. Failing tests first: two mm-scale spots 30 mm apart with RLs 0.5 m different give `DUPLICATE_POINT_CONFLICT`; `TryGetRlAtPoint(15.0, 0, ..., insunits 0)` says "15.0 m". The Z-scale case needs an AutoCAD scenario or a pure helper for the Z rule.
8. **BUG-702, 703, 704 (HIGH then MEDIUM): attribute defaults read as spot levels; the transform pairs by level only; quad 3DFACEs lose half.** File and function: `Services/SurveyService.cs:162-164, 188-189, 298-314, 201-203, 409-411`. Failing tests first: `MatchSpotLevelsByRl` with two equal RLs in reverse order; a quad splits into two triangles; skip `AttributeDefinition` (AutoCAD scenario).
9. **BUG-740, 741 (HIGH, MEDIUM): "ROOF DRAIN 1" becomes "ROOF" on COPY, CDTAG Set or a numbering change; CDFIXTAGS proposes "ROOF DRAIN 1 1".** File and function: `Rules/SourceFamilies.cs:211-219`; `Rules/SourceNumbering.cs:49`; `Services/SourceTagService.cs:153-182`; `Services/SourceTagService.SourceChangeApply.cs:32-33`; `Services/LinkService.SpineClones.cs:157`; `Rules/DuplicateSourceTagPolicy.cs:96`. Failing tests first: `SourceNumbering.LabelFor("HOT WATER UNIT 1", ...)` does not return "HOT"; `ProposeRepairs` gives "ROOF DRAIN 2".
10. **BUG-734, 735, 736, 737, 738 (MEDIUM-HIGH and MEDIUM, wrong levels on imported pipes): X-Civil works the upstream level from the wrong end, draws IL text at the wrong end, drops "IL:12.34" wordings, uses pit floor as every invert, reads depth as cover.** File and function: `Services/XcivilPipeInsertionService.cs:1497-1513, 379, 339`; `Services/XcivilPipeInsertionService.Annotations.cs:80-92`; `Helpers/XcivilImportPatterns.cs:13, 16`; `Services/XcivilScheduleService.cs:698-713, 1082`. Failing tests first: `ExtractInvertLevels(new[]{"IL:12.34"})` returns 12.34; `ApplyDerivedInvertsFromSchedule` then `AssignInvertsForPit`. Unknown stays Unknown (rule 12.2).
11. **BUG-742 (MEDIUM-HIGH): CDTAG on an untagged block never checks the name is free.** File and function: `Commands/SourceTagCommand.cs:306`; route through `SourcePlacementService.ResolvePlacementTag`. Failing test first: two blocks cannot both be "DP3".
12. **BUG-706, 707, 708 (MEDIUM, LOW): skipping the raw survey records the XREF as raw; fingerprint from disk but levels from the loaded copy; "1 suspect points" counts notes.** File and function: `Commands/CdSurveyCommand.cs:87, 117-120, 258-260, 317-322`; `Services/SurveyIntakeStalenessService.cs:373-375`; `Services/SurveyIntakeApplyCoordinator.cs:95`. Failing test first: `BuildMeta` with one LOW_TIN_COVERAGE note shows 0 suspect points.
13. **BUG-739, 747, 746 (LOW): the report keeps 30 warnings and reads the PDF twice; unnumbered AGI/LPD endpoints skipped silently; tag removal leaves orphan records.** File and function: `Services/XcivilImportService.cs:459-505, 1459`; `Services/XcivilSourceTagPitRegistrationService.cs:94`; `Services/SourceTagService.cs:488-497`.
14. **BUG-726, 727 (MEDIUM): CDIMPORTCOMPARE names the wrong pipe as missing and probably refuses an open reference DWG.** File and function: `Commands/LinkCommands.ImportXcivil.Corpus.cs:246-268`; `Services/CdImportCompareSnapshotService.cs:267, 332`. Failing test first: `BuildComparisonReport` with expected P1 to P2 and P1 to P3 and only P1 to P3 drawn reports P1 to P2 as MISSING.

### build/04 Civil windows, schedules, spot levels and commands: 8 lines, HIGH first

1. **BUG-710 (HIGH, wrong grade on metre drawings): CDFALLSUGGEST writes "1:0.1" instead of "1:100".** Shared root: millimetres used as drawing units (BUG-663, 695, 696). File and function: `Rules/FallArrowGeometry.cs:112, 188` (`TrySuggestNearestDownhillPit` needs the units). Failing test first: a 20 m run with 0.2 m fall in a Metres drawing gives 1:100.
2. **BUG-711, 714, 713, 717 (MEDIUM-HIGH, then MEDIUM): one level parser for CDSL, CDFALLSUGGEST, the pit offer, CDSLAB and the X-Civil prefix mapping.** CDSL accepts "P18.6" as "PP18.6" and "18600" as 18 600 m; "PRL 18.600" is read by one command and not another; a blank spot hides a valid one; X-Civil strips TW/BW. File and function: `Commands/SpotLevelCommand.cs:100-123`; `Commands/SlabCommand.cs:440-463`; `Services/SpotLevelReader.cs:48-74`; `Services/XcivilEntityScanner.cs:1294-1296, 1331`. Failing tests first: one shared pure parser with cases "P18.6", "18,6", "18600", "18.6m", "PRL 18.600", "TW 12.450"; bad input asks again, valid input is written as P plus 3 dp. Hand the parser to build/03 line 6.
3. **BUG-743, 745 (MEDIUM-HIGH, MEDIUM): CDTG "Enter to skip" reuses the last grate's level from another drawing; trench drains in Metres drawings.** Fix BUG-432 (skipped level stored as 0.000) in the same PR. File and function: `Commands/SourceBlockInsertCommands.cs:32, 188, 370, 742-759`. Failing tests first: a skipped cover level is blank, never the previous job's; a 0.9 m run in a Metres drawing is accepted at 900 mm.
4. **BUG-715, 716 (MEDIUM, plausible): the pit design-level offer ignores breaklines and edited spot text.** File and function: `Services/DesignLevelService.cs:28-49`. Failing test first (pure): a valley case where the offer matches the `SlabConstrainedSurfacePlan` level.
5. **BUG-712 (MEDIUM, plausible): CDSL can leave a half-placed spot level on a locked layer.** File and function: `Commands/SpotLevelCommand.cs:111-123`. Failing test first: a locked layer refuses before any block is written.
6. **BUG-744 (LOW-MEDIUM): CDFIXTAGS adds a label to sources that had none.** File and function: `Commands/SourceTagRepairCommand.cs:163`. Failing test first: a repair of an unlabelled source stays unlabelled.
7. **BUG-709 (MEDIUM): CDSURVEY reads only single-line TEXT and attributes tagged "RL".** Waits for the shared parser (line 2); then `Services/SurveyService.cs:162-173`.
8. **BUG-718 (LOW): unitless-metre reach, mm assumption in the level review, PC-culture level text.** File and function: `Services/DesignLevelService.cs:104-106`; `Services/ImportedLevelReviewService.cs:133`; `Services/PitConnectedLevelAnalysisService.cs:240`. Failing test first: levels format with a full stop on a decimal-comma culture.

**Left to Tim, none new:** no engineering ruling is needed for these. BUG-719 and BUG-728 need one real Civil 3D LandXML export to confirm the attribute names and slope sign before the fix is called safe.

## 8. Hunt Civil I/J/K fixes (18 Oct)

Added Sun 18 Oct 2026 by the desk (headless job). Source: `areas/release-v3-colleagues-HUNT_CIVIL_IJK_2026-10-12.md` (code audit of Civil 3.0.55, nothing seen in AutoCAD). Filed as BUG-756 to BUG-778. Spoon drain metres (IJK-24) is a note on BUG-338; the WSUD series-credit question (IJK-18) is in QUESTIONS_FOR_MONDAY section H. Every fix: failing test first, DRAFT PR, Settings-backed, Unknown stays Unknown.

**Shared root causes (one fix each):**

1. **The CDPROFILE review turns bad or missing levels into numbers instead of Unknown** (BUG-757, 759, 760, 761, 762): all in `ProfileRouteReviewService.Prepare` and `ProfileRouteEvidenceCaptureService`. One PR with five failing tests.
2. **A pipe's own size and grade are mixed with its neighbour's** (BUG-756, 763): the pit row holds the pipe leaving the pit, the grade holds the pipe arriving. Use `OutgoingDiameterMm` and `OutgoingGradeOneIn` everywhere.
3. **Boundary marks use straight pit-to-pit lines** (BUG-764, 768): one pure projection helper.
4. **Second long-section writer without safety checks** (BUG-758, 766): hide the old tab in CDCALC, run `TryAdmit` in the writer.

### build/03 Civil engine, hydraulics, long section maths: 11 lines, HIGH first

1. **BUG-756 (HIGH): pipe top line drawn at the next pipe's size.** `Services/LongitudinalSectionService.cs:1385`, `ProfileRouteReviewService.cs:389-391`, `ViewModels/LongitudinalSectionViewModel.cs:412`. Test first: pure helper `CrownDiameterForSegment`, 225 then 375 gives 225. Root cause 2, with BUG-763.
2. **BUG-757 (HIGH): TG "0.000" cover read as RL 0.00.** `ProfileRouteReviewService.cs:381`, use `PitData.KnownCoverLevelRl()`. Test first: `Prepare` with a TG pit at "0.000" gives cover not known. Root cause 1.
3. **BUG-758 (HIGH): write-side check for the older section tab.** `LongitudinalSectionService.InsertSection` (:378) and `UpdateExistingSection` (:425) call `TryAdmit`; `ParseDouble` blank must not become 0.0 (`LongitudinalSectionViewModel.cs:1714-1721`). Test first: `TryAdmit` on a 0.0 cover refuses; source guard. The window half (hiding the tab) is in build/04.
4. **BUG-759 (MEDIUM-HIGH): datum above the lowest invert less sump.** `ProfileRouteReviewService.cs:61-67`. Test first: `Prepare` with datum above an invert is Refused. Root cause 1.
5. **BUG-762 (MEDIUM): invert above cover hidden as depth 0.** `ProfileRouteReviewService.cs:413-416`. Test first: `Prepare` not Ready. Root cause 1.
6. **BUG-761 (MEDIUM): uphill pipe shows a falling grade.** `ProfileRouteEvidenceCaptureService.cs:719-722`, `MathHelper.cs:57`. Test first: `ComputeEstablishedGrade(20, 10.00, 10.20)` is not 100. Root cause 1.
7. **BUG-760 (MEDIUM): level pipe stops the section.** `ProfileRouteEvidenceCaptureService.cs:590-614`, `MathHelper.cs:58-59`, writer `LongitudinalSectionService.cs:224-231`. Test first: `ComputeEstablishedGrade(20, 10.00, 10.00)` and `Prepare` Ready. Root cause 1.
8. **BUG-764 (MEDIUM): boundary marks on the real pipe.** `LongitudinalSectionViewModel.cs:1296-1390`. Test first: chord versus bent polyline case in a pure helper. With BUG-768 (`ProfileRouteReviewService.cs:843-844`).
9. **BUG-777 (MEDIUM, engineering result): CDTWL default is the highest obvert.** `Rules/TopWaterLevelCandidates.cs:73-84`. Test first: 225 at 10.000 and 375 at 9.990 gives 10.365.
10. **BUG-775 (MEDIUM, latent): crossing clearance to outside of pipe; units; layer match.** `Rules/CrossingServiceRule.cs:121-124, :100, :69`. Test first: `Evaluate("WATER", 9.70, 10.00, 375, 300)` is UnderMinimum. Do before card 6.8 wires it in. With BUG-776 (`PipeCrossingSplitPolicy.BuildDoneMessage`).
11. **BUG-765, 769, 770, 778, 772 (LOW-MEDIUM and LOW):** survey-level text only on survey layers (`LongitudinalSectionViewModel.cs:1230-1272`); default schedule set from the route (`ProfileRouteEvidenceCaptureService.cs:45-54`); `LongSectionBridge.cs:99`; `PumpSizingService.cs:278`; WSUD input checks (`WsudViewModel.cs:164-169`). One small test each.

### build/04 Civil windows, commands, schedules: 6 lines, HIGH first

1. **BUG-758 (HIGH): hide the "Older longitudinal" tab in CDCALC.** `CalculationsV2Dialog.xaml.cs:40-73` (as the CDPROFILE constructor does at :93), send the drafter to CDPROFILE. Hide, never delete. Test first: source guard that the CDCALC constructor hides the tab. With BUG-766 (junction marks on the reviewed path, `LongitudinalSectionService.cs:1045-1058`).
2. **BUG-763 (MEDIUM): review grid shows one pipe.** `ViewModels/ProfileRouteReviewViewModel.cs:44-51`. Test first: grade shown equals `OutgoingGradeOneIn`. Root cause 2.
3. **BUG-771 (MEDIUM): CDRG Enter closes the outline; Undo removes one point.** `Commands/SourceBlockInsertCommands.cs:915-934, :455-459, :480-484`. Needs AutoCAD: add to Codex's CDRG run. With BUG-773 (`RaingardenPlacementPlan.cs:195-198, :133`; test pure on `TryCreate`).
4. **BUG-774 (MEDIUM): spoon drain ignores a repeated pick.** `Commands/SpoonDrainCommand.cs:85-90`. Test first: `SpoonDrainRunPlan.TryCreate` with (0,0), (10,0), (10,0), (20,0). Then the BUG-338 note: read INSUNITS.
5. **BUG-767 (LOW): widen the section frame for the existing-pipe stubs.** `LongitudinalSectionService.cs:1494-1515, :1672-1700`. Test first after moving the chainage rule into a pure helper.
6. **BUG-772 (LOW-MEDIUM): WSUD refuses impervious above site and negatives.** `ViewModels/WsudViewModel.cs:164-169`.

## 9. Hunt Civil L/M fixes (18 Oct)

Added Sun 18 Oct 2026 by the desk (headless job). Source: `areas/release-v3-colleagues-HUNT_CIVIL_LM_2026-10-12.md` (52 findings, read-only audit of Civil 3.0.55: Pit Schedule, Checks and QA, repair, legacy migration, X-Civil schedule import). Filed as BUG-779 to BUG-812 (34 entries; related findings grouped). Every fix: failing test first, DRAFT PR, Settings-backed, Unknown stays Unknown, native layer-lock protection respected.

**Shared root causes (one fix each):**

1. **The Pit Schedule builder, the Xref rows and the redesign review each copy the inlet-merge and row-mapping code** (BUG-780, 784, 786, 787, 798): pull one pure `ConsolidateInlets` and one row-ordering/override-key function and make all three callers use it (design rule #1).
2. **The drawn table, the window and redesign Apply each work out a cell's text their own way** (BUG-779, 783, 785, 791, 792, 807): one `BuildCellText`, one depth function, one "should this edit change the record?" decision, DELETE mapped to blank in one place.
3. **The level cascade maps drawn direction to flow direction wrongly** (BUG-782, with BUG-654 and 797): one pure `MapPinnedEnds` and one lock check.
4. **Repair buttons write without a preview and report candidates, not results** (BUG-789, 796, 803, 810): one preview-and-Yes/No wrapper, as CDFIXFLATPIPES has.
5. **Checks and QA ignore failures and Settings** (BUG-790, 794, 800, 801, 802, 808, 809): one "could not check" row type and one Settings-backed standards source.

### build/03 Civil engine, import services, cascade, shared: 14 lines, HIGH first

1. **BUG-782 (HIGH): cascade protects the wrong end.** `Services/LinkService.RepairAudit.InvertPropagation.cs:425-426, 793-794`. Test first: pure `MapPinnedEnds`, pipe drawn from the low end, typed 10.20 stays. Do with BUG-654 and BUG-797 (`:733, :790, :810`, refuse a locked pipe layer).
2. **BUG-781 (HIGH): X-Civil schedule rows paired to pits by position.** `Services/XcivilScheduleService.cs:308-329, 395-430`; `XcivilImportService.cs:773`. Test first: `AssignImportedSchedulePitIdsByOrder` with one row filtered out maps the third row to P2 today. Unknown stays Unknown.
3. **BUG-785 (HIGH): one depth rule in the refresh path.** `Services/ScheduleLinkService.cs:2598-2610, 2786`; `NetworkRedesignScheduleReviewService.cs:155-157, 1012-1031`. Test first: `BuildDepthText` against the window rule for an SPS pit. Child of BUG-540.
4. **BUG-788 (HIGH, plausible): SAVEAS Xrefs merge.** `Services/PitScheduleXrefDiscoveryCore.cs:56`, `PitScheduleXrefDiscoveryService.cs:394-398`. Test first: `Discover` with two probes sharing a fingerprint. With BUG-799 (`PitScheduleStatusService.cs:104, 301-305`).
5. **BUG-790 (MEDIUM-HIGH): Design Review ignores Settings.** `Services/DesignReviewService.cs:33`, `DesignValidationService.cs:195-204`. Test first: Settings stub with a different minimum grade.
6. **BUG-789 (MEDIUM-HIGH): Recover Inverts redraws nothing.** `Commands/LinkCommands.cs:2257-2267`, `LinkService.Persistence.cs:25-48`. Check for text before storing.
7. **BUG-794 (MEDIUM): "no issues" when no PDF was read.** `Services/PdfScheduleSanityService.cs:103-106`. Test first: `BuildPreflightLines(CheckSchedule(null))`. With BUG-804 (page selection, `XcivilVisionScheduleExtractionService.cs:274-277`) and BUG-805 (`XcivilVisionScheduleParser.cs:161`, `XcivilScheduleService.cs:523-526, 1165-1182`).
8. **BUG-796 (MEDIUM): preview and Yes/No for four repair buttons; honest counts.** `Commands/LinkCommands.cs:201-300, 2187`; `Commands/HubCommands.cs:636, 665`. With BUG-803 (`LinkService.CloneRepair.cs:39-46, 93, 113`) and BUG-795 (`BrokenXrefPathRepairService.cs:52-60`: exclude the host, prefer matching folders).
9. **BUG-793 (MEDIUM): pit-block migration checks for CE data and a version stamp.** `Services/PitBlockMigrationService.cs:150-237`.
10. **BUG-801, 800, 802 (MEDIUM): QA marked stale by CE writes; "could not check" row; ignore fingerprint with cover levels.** `Services/CivilProjectQaAutomaticService.cs:261-269, 677-690`; `Services/Checks/ChecksResultReader.cs:93-160`; `Services/Checks/IgnoredChecks.cs:204-260`.
11. **BUG-809, 808 (LOW-MEDIUM): small Checks and QA fixes.** `Services/MinimumCoverForChecks.cs:25` first (`Choose(false, null, 0.0)`), then `ConsultantDwgCheckService.cs:186-201`, `DesignReviewService.cs:64`.
12. **BUG-807 (LOW): no "-0.00"; half rounds away from zero on net10.** `Services/PitScheduleLevelText.cs:27`, `Rules/PipeEndClassification.cs:231`. Test first: `Format(-0.004, 2)` is "0.00".
13. **BUG-806 (LOW, latent): orifice mapper head from the orifice IL.** `Services/OrificeDetailFieldMap.cs:98-113`. Before it is wired up.
14. **BUG-811, 810, 812 (LOW): rejoin step, import log race, audit commands read-only, new-pit sort.** `InvertPropagation.cs:302-353`; `XcivilVisionFallbackOrchestrator.cs:208-231`; `Commands/LinkCommands.cs:722`; `AuditPasses.cs:102-163`; `NetworkRedesignScheduleReviewService.cs:886-905`. Note: build/03 owns the pure `ConsolidateInlets` and `MapPinnedEnds` extractions; build/04 owns the window callers.

### build/04 Civil windows, schedules, QA, repair, notes: 11 lines, HIGH first

1. **BUG-779 (HIGH): moving the table must not change records.** `Services/ScheduleLinkService.cs:226-332`. Test first: pure "should this cell change the record?" decision; unchanged cell text and overridden fields do nothing. Root cause 2.
2. **BUG-780 (HIGH): merged inlet rows map the wrong pipe.** `ViewModels/PitScheduleViewModel.Data.cs:309-326, 724-734`; `NetworkRedesignScheduleReviewService.cs:133-151`. Test first: P3 19.40, DP1 19.60, DP2 19.60, AG1 19.90 gives AG its own diameter. Root cause 1.
3. **BUG-783 (HIGH): DELETE token blanks everywhere.** `Services/ScheduleLinkService.cs:1887-1932, 2496`; `PitScheduleViewModel.Filters.cs:29-58`. Test first: `RefreshLinkedCellFromRecord` with Cover="DELETE" gives blank. Remarks wording waits for QUESTIONS_FOR_MONDAY section I item 1.
4. **BUG-784 (HIGH): FROM keeps C1.** `Services/PitScheduleBuilder.cs:209-217, 151, 248-249`; `ScheduleLinkService.cs:2548`. Test first: `BuildInletFromDisplay` with pit C1 gives "C1".
5. **BUG-786 and 787 (HIGH, MEDIUM-HIGH): row order and overrides by pit group.** `PitScheduleViewModel.Data.cs:859-930`; `Schedule.cs:450-586, 651-661`. Test first: add an inlet to P5 of a 10-row schedule; the new row stays in P5's group; an override keyed by pit survives.
6. **BUG-791 (MEDIUM-HIGH): pit size is never an override; untouched cells add none.** `Dialogs/PitScheduleDialog.xaml.cs:218`. Window code-behind: AutoCAD check by Codex.
7. **BUG-792 (MEDIUM, LOW-MEDIUM): refuse unclean typed numbers; put an ignored cell back with a message.** `Services/ScheduleLinkService.cs:3290, 226-337`.
8. **BUG-798 (MEDIUM): pit columns repeat on a continuation sheet.** `Services/PitScheduleContinuationLayout.cs:116`. Test first: two rows, one row per sheet, second sheet's first cell "P12".
9. **BUG-799 (MEDIUM): "SOURCE UNLOADED" wording and host-relative path.** `PitScheduleStatusService.cs:104, 301-305`.
10. **BUG-808 (LOW): outlet against the largest inlet.** `PitScheduleViewModel.Data.cs:2189-2212`.
11. **BUG-809 items (4) and (5) (LOW): palette close keeps your selection; the "Record pipe ends off pit" setting works or hides.** `Services/DrawingCheckPaletteService.cs:266-319`; `Services/Checks/ChecksResultReader.cs:170`.

## 10. Run 31 fixes (18 Oct)

Added Sun 18 Oct 2026 by the desk (headless job). Source: `areas/release-v3-colleagues-CLAUDE_DRIVER_RUN31_V2_2026-10-18.md` (robot pass 10, real AutoCAD 2027 on test copies, Civil 3.0.55). Filed as BUG-813 to BUG-817, plus "still seen" or "PASS" notes on BUG-141, 372, 698, 740 and 746. Nothing here is Tim-accepted. Tooling problems are not in this queue.

**Shared root cause:** the tag and tidy-label family prints reasons from internal ids and the CE log (BUG-372, 814, 816): one helper that names the pit or tag in words, used by CDTAG, CDFIXTAGS, tidy labels and CDCHECKS.

### build/03 Civil engine, shared: 3 lines

1. **BUG-813 (MEDIUM-HIGH): CDFIXTAGS rename did not apply.** Cause not proven. Start with a real fixture: two ordinary source blocks that are not pit blocks, both "DP3". Failing test first: `ProposeRepairs` then apply on that fixture renames the second block to DP4 in one undo step; also a pit block tagged as a source gets one identity. `Services/SourceTagService.cs` (the capture that raises "no unique matching drawing/project spine identity") and `Commands/SourceTagRepairCommand.cs`. Do not close BUG-740, 741, 744 or 746 on this run.
2. **BUG-141 (still seen) and BUG-816: the start invert text beside a pit is called "on the pit".** Lane 03 finds why the obstacle test treats text about 20 px clear of the pit box as on it (obstacle box too large, or the pit's pick area). Failing test first: a pure placement case, a 20 m pipe with the start text just clear of the pit, expects a clear spot (the run 31 numbers: inverts 18.000 and 17.900, 20 m). Also find which setting controls the automatic "no clear spot" line when Tidy labels is off.
3. **BUG-815 (LOW-MEDIUM): R-06 applies to detention pipes only, with Settings values.** `Rules` R-06 check behind CDCHECKS. Failing test first: a 100 mm downpipe is not flagged by R-06.

### build/04 Civil windows, commands, wording: 2 lines

1. **BUG-814 (LOW): plain-words refusals.** CDTAG retag refusal says "WT2 is already on another source. Choose a different number." (as the untagged path does); CDFIXTAGS refusal in words; CDCHECKS rows name pits, not handles (with BUG-372, 753, 754). Failing test first: the message text for a duplicate retag contains the tag name.
2. **BUG-817 (LOW): opening the Pit Schedule adds no undo step unless it changes the drawing.** Next tester watches DBMOD first; fix only if it does write.

**Tooling problems (not bugs, for the driver owner):** add Start Pipe and Checks Close to the `slow_press` list (they hit the 30 s watchdog though the action worked); Pit Schedule needs `ui tree -Depth 6` and a higher node cap (399 of 400 with one extra row); a typed point cannot pick an already-tagged block, so CDTAG Remove and Set cannot be driven by typed points; the driver prints a false "ALARM: AutoCAD may be waiting at a prompt" after CDTAG, CDSYNC and pipe placement; a fixture with two ordinary doubled source blocks and one with a multi-word tag ("ROOF DRAIN 1") is missing (BUG-741 and BUG-744 blocked); the BUG-650 check needs P8's "Pit bottom level" read before the CDFW cancel.

## 11. Run 32 fixes (19 Oct)

Added Mon 19 Oct 2026 by the desk (headless job). Source: `areas/release-v3-colleagues-CLAUDE_DRIVER_RUN32_V2_2026-10-19.md` (robot pass 11, real AutoCAD 2027 on test copies, installed Civil 3.0.56, train C-45). Filed as BUG-820 to BUG-822, plus "STILL SEEN" or "PASS" notes on BUG-141, 372, 698, 740, 742, 782, 789, 797, 813, 814, 815, 816 and 817. Nothing here is Tim-accepted. Robot gaps (driver and fixture problems) are in `areas/release-v3-colleagues-ROBOT_GAPS_2026-10-19.md`, not in this queue.

**Rule for every line below:** reproduce on a drawing that already has a detention-length "0" stored in its pipe records (the run 31 downpipe drawing), not on a freshly drawn pipe, and write the failing test first.

### build/03 Civil engine: 4 lines, in order

1. **BUG-815 second attempt (MEDIUM, engineering-result risk): the false R-06 rows survive fix #1436.** CDCHECKS still says "detention diameter 100 mm outside 225600 mm" on 100 and 150 mm downpipes on 3.0.56, with the same counts as 3.0.55 (63 to look at, 243 OK, 312 not known). Find why: the report says #1436 only stops a stored required length of 0 (or a non-number) making a pipe a detention pipe, in `RulebookEngine.IsDetentionPipe`, while the other two clauses (`RulebookDrawingType == DetentionPipe`, `DetentionTwinPipes`) are untouched, so these pipes may carry one of those; cause unproven, do not guess. Failing test first: a 100 mm downpipe with a stored detention length of 0 AND each of the other flags the drawing may carry gives no R-06 row; add a case read from the real run 31 drawing's pipe record, not only a hand-built pipe. Ask what the pipe record on handle 1093C7 actually holds before changing the rule.
2. **BUG-141 / BUG-816 / BUG-372 (MEDIUM): Tidy labels says "No clear spot" for a start text that is clear of the pit.** New pit, 20 m pipe, inverts 18.000 / 17.900: "IL 18.000" starts about 27 pixels right of the pit box, yet CE says "on pit P8" and Tidy gives "No clear spot found 2". Same result in run 31 and run 32. Find why the obstacle test counts the pit (obstacle box too large, or the pit's pick area) in the tidy placement code. Failing test first: a pure placement case, a 20 m pipe with the start text just clear of the pit, expects a clear spot. Also name the pipe in words, not "11C65B", and not "the block Drawing Border".
3. **BUG-813 (MEDIUM-HIGH): CDFIXTAGS rename does not apply.** Now refuses with "CE could not match this source block to the drawing's own records" on the DP3 pair. Cause not proven; the fixture may be the fault (two pit blocks). Failing test first: two ordinary source blocks both "DP3" are renamed to DP4 in one undo step; a pit block tagged as a source gets one identity. `Services/SourceTagService.cs` and `Commands/SourceTagRepairCommand.cs`. Do not close BUG-740, 741, 744 or 746.
4. **BUG-820 (LOW-MEDIUM, needs Tim's call): Recover Inverts skips a pipe that still has one of its two texts.** Ask Tim whether to draw the missing end; if yes, failing test first: erase one IL text, run it, the text comes back once, no duplicate.

### build/04 Civil UI, schedules, QA: 4 lines, in order

1. **BUG-814 (LOW): CDCHECKS rows still name pipes by handle** ("1093C7", "109CCF and WT10", "10993C and 10996E"), never "unnamed pipe". The rows come from `RulebookEngine.PipeMark`, which falls back to `pipe.EntityHandle`; `ChecksResult.cs` has the "unnamed pipe" wording but this path does not use it. Failing test first: a pipe with no id gives a row that says "unnamed pipe" with its pits (From pit to To pit), no handle. Reproduce on the run 31 drawing, which still has the stored detention-length "0". Same helper as BUG-372's "pipe 11C65B" lines.
2. **BUG-821 (LOW): CDTAG ignores a selected block.** Failing test first: with a block selected before CDTAG, the command either uses it or always asks, the same on every drawing. Check the robot cause (driver) before changing the command.
3. **BUG-817 (LOW): opening the Pit Schedule leaves a U step of its own** (seen again in run 32). Watch DBMOD before and after opening; fix only if it writes to the drawing.
4. **BUG-822 (LOW): a "What's New" palette opened partway through a session.** Find which step opens it; failing test first: What's New opens only at first start after an update or on request.

**Not in the queue:** BUG-698, 740 numbering, 742, 789 (two-text case), the Edit Pipe cascade regression (BUG-782 and 797 apply/U/REDO) PASS on the robot; they stay OPEN until Tim or Codex accepts. The locked-layer and low-end cases for BUG-782 and 797 were not tested.

## 12. Codex looks L3 and L4 on 3.0.56 (19 Oct)

Added Mon 19 Oct 2026 by the desk (headless job). Sources: `CODEX_LOOK_L3_20261019_1427.md` (PASS 17, FAIL 3, DIFFERENT 1) and `CODEX_LOOK_L4_20261019_1502.md` (PASS 2, DIFFERENT 5, BLOCKED 10, UNSURE 3), real AutoCAD 2027 on test copies, installed Civil 3.0.56 / Manager 1.1.56 / Structural 1.0.118. No new BUG numbers: every finding matched an existing bug and got a "Codex look L3/L4 (19 Oct)" note (BUG-750, 751, 752, 753, 755, 749, 580, 221, 430, 396, 623). Nothing here is Tim-accepted. Structural is still 1.0.118, so the three Structural FAILs are unchanged from 18 Oct. The ten BLOCKED looks are tool gaps, listed in ROBOT_GAPS_2026-10-19.md, not in this queue.

**Shared root cause (lanes 03 and 04):** double-click on a CE object does not reach one shared router for every object type. Pipe and IL text work; the pit label (a block with attributes) and the placed schedule table cell are handed to AutoCAD's own editor (BUG-430, BUG-396), and the downpipe prints a command-line prompt (QUESTIONS_FOR_MONDAY section G item 1). Tim's ruling G2 (17 Oct): double-click any CE object opens its Edit window.

### build/03 Civil engine, Manager, shared: 1 line

1. **BUG-430 (MEDIUM-LOW): double-click on the P8 pit label opens AutoCAD's Enhanced Attribute Editor, not Edit Pit.** The double-click redirect (`CompoundEditModeService`) handles the pipe and the IL text but not the PIT LABEL 2 attribute block. Failing test first: a double-click on the pit label block (tag PIT_LABEL) is routed to the Edit Pit command for that pit, with the switch ON. Fold the downpipe case in once Tim answers section G item 1.

### build/04 Civil windows, schedules, QA: 2 lines

1. **BUG-396 (MEDIUM): double-click on a placed Pit Schedule table cell opens AutoCAD's own Text Editor, and the plan label does not follow.** It also prints "Undefined shape 80" and "Undefined shape 50" (BUG-623). Approved design: double-click on a placed schedule opens the Pit Schedule window at that cell. Failing test first: a double-click on a cell of a linked table raises the Pit Schedule window on that pit's row, and a typed rename changes table, plan label and pit data in one undo step. Check BUG-396 item 1 (a table-cell edit may never reach CE) first. Shared root cause with BUG-430.
2. **BUG-753 and BUG-814 (LOW-MEDIUM): Checks rows name the pipe "unnamed pipe" with no pit names to tell two apart, or still by handle on other drawings.** Failing test first: a row for a pipe with no id says "unnamed pipe" with its From pit and To pit, never an id or handle. The Show where glow was not seen (UNSURE, fade time unknown): the next Codex look takes the capture faster; no fix until it is seen to fail.

### build/02 Structural: 3 lines

1. **BUG-751 (MEDIUM): CEHATCH library cards and the Waffle preview show "No preview: the drawing scale is not valid" on a Structural copy with DIMSCALE 1.** Five cards (Load-bearing wall over and under, Earth, Concrete, Waffle). Failing test first: the card image for every library entry is produced at scales 1, 20, 50 and 100; the scale note may show beside a picture, never in place of it. Related: BUG-614, BUG-748.
2. **BUG-752 (LOW): long folder paths are clipped on three Structural Settings pages.** System > Installation (Loaded plugin file, Ribbon file), Schedules > Workbook files (three paths), Schedules > Markup service (Last markup folder). Failing test first: a render check of those pages with a 120-character path at 1407 x 965 shows the whole path (wrapped or scrolling).
3. **BUG-755 (LOW): RC beam Type 2 and Type 6 pictures meet the top edge of their boxes.** Failing test first: each thumbnail's drawn bounds lie inside its picture box with a margin.

**Not in the queue:** BUG-750 (SBEAM inner flange lines) is superseded by the CEMEMBER design and stays OPEN (D6), no fix. BUG-749 (paste command at a Q or Section Mark prompt) is not shown to be a CE fault: all three occurrences came from how Codex typed. BUG-580 and BUG-221 passed (Manager Light header, status cards); they stay OPEN until Tim or Codex accepts, and need no builder work.

## 13. Manager, installer, admin, update route and settings hunt (19 Oct)

Added Mon 19 Oct 2026 by the desk (headless job). Source: `areas/release-v3-colleagues-HUNT_MANAGER_INSTALL_2026-10-12.md` (read-only audit of Civil 3.0.56 / Manager 1.1.56 on `rel-20261019a` and Structural 1.0.118 on `rel-20261017s`; nothing was run or seen in AutoCAD). Filed as BUG-823 to BUG-853 (HUNT-MI-n is BUG-(822+n)); none was already in the carpark (BUG-425, 476, 485, 489 and 491 are neighbours, cross-referenced). Nothing here is Tim-accepted. **Colleague install day:** BUG-823 and BUG-824 together mean the Manager update route cannot finish anything today.

**Shared root causes:** (a) BUG-823, 824, 834 are the installer and the release check (one package-root rule, one module-type rule). (b) BUG-825, 827, 831 are the Civil settings load and save path: one safe-write and "never overwrite a file we never opened" fix, plus a migrate-once flag. (c) BUG-830 and 839 are one fault: the Civil settings page applies its whole opening snapshot instead of only the fields changed. (d) BUG-836 and 837 are one version-comparison helper (strip "v" and "+..."). (e) BUG-842, 844 and 848 are report and settings files read or sent while half written.

### build/03 Civil engine, Manager, shared: 26 lines, HIGH first

1. **BUG-823 (HIGH): the installer refuses every update Manager gets ready.** The receipt beside the three signed files breaks the "exactly three files" rule. `CeUpdateStagingService.cs`, `SafeBundleInstaller.cs:240-249`, `OfficialReleaseGate.cs:732-735,1943-1957`. Failing test first: `InstallerApplicationTests` `Run_ActivateStaged_InstallsAndWritesCompletedResultRecord` (should be red now; check it is run, BUG-247). Root cause (a).
2. **BUG-824 (HIGH): the installer refuses Civil 3.0.56, and Manager on a PC with it, over the .dbx file.** `SafeBundleInstaller.cs:446-459,509-543`. Failing test first: a `SafeBundleInstallerTests` case with a command-free .dbx ComponentEntry installs. Root cause (a).
3. **BUG-825 (HIGH, engineering result): Civil puts a maximum velocity of 3.0 m/s back to 6.0 and label heights under 200 to 250 at every start.** `Services/SettingsService.cs:145-170,200-210`. Failing test first: test scope with 3.0 on disk, reload, still 3.0; the move runs once behind a flag. Root cause (b). The step-iron 1000 to 900 part waits on QUESTIONS_FOR_MONDAY section I item 6.
4. **BUG-827 (HIGH): an unreadable Civil settings file is overwritten with standard values at the next save.** `SettingsService.cs:235-240,472-482,522-561`. Failing test first: file opened with no sharing, reload, then save is refused and the bytes are unchanged. Root cause (b).
5. **BUG-831 (MEDIUM): Civil writes its settings file in place.** `SettingsService.cs:608-620`. Failing test first: a source guard against `File.WriteAllText` on the settings path. Do with item 4. Root cause (b).
6. **BUG-829 (MEDIUM-HIGH): a colleague can still take the administrator role.** `CeAdminPolicyService.cs:47-69,122-127,164-167`. Failing test first: only the local list exists, a colleague seeds the shared list, `GetPolicySnapshot` for "tim" still says administrator (promote the local list when the folder is reachable).
7. **BUG-828 (MEDIUM): a CE ribbon click during a running command types the command name into it.** `RibbonBuilder.cs:695`. Failing test first: the string sent starts with two cancels when a command is active.
8. **BUG-832 (MEDIUM): a failed Civil stage does not stop Manager being staged alone; the status line ignores Manager.** `CeApprovedReleaseService.cs:602-608`. Failing test first: `StageManagedUpdates` with a failing Civil install delegate never calls Manager's.
9. **BUG-833 (MEDIUM): one staging error turns off the status dot and report upload for the session.** `Plugin.cs:140-161`, `CeApprovedReleaseService.cs:604`. Failing test first: a throwing install delegate returns notes, not an exception.
10. **BUG-834 (MEDIUM): the installer installs any old stage.** `SafeBundleInstaller.cs:133-329`. Failing test first: a stage older than the approval is refused or warned. Waits on QUESTIONS_FOR_MONDAY section I item 5 for which.
11. **BUG-850 (MEDIUM): Manager rebuilds the Civil tab and ignores "Show the old CE tabs".** `CeUnifiedRibbonService.cs:127-133`. Failing test first: a source guard, one builder owns the tab.
12. **BUG-843 (MEDIUM): name matching in the administrator list fails** ("users" lower case, "CE\tim", leading space). `CeAdminPolicyService.cs:57`. Failing test first: `["CE\\tim"]` for user "tim" is administrator. The Add administrator button waits on QUESTIONS_FOR_MONDAY section I item 4.
13. **BUG-844 (MEDIUM): one half-copied report blanks the Admin Dashboard.** `CeAdminAnalyticsService.cs:208-227`. Failing test first: `LoadDashboard` with a 0-byte usage file still returns the others. Root cause (e).
14. **BUG-845 (MEDIUM): Create bundle and Mark as Investigated have no error catch.** `PluginAdminWindow.xaml.cs:182-192,329-344`. Failing test first: a source guard that both catch.
15. **BUG-842 (LOW): CE Blocks settings fall back to defaults and are then saved.** `CeBlocksSettings.cs:39-85`. Failing test first: a locked file on load then Save leaves the original bytes. Root cause (e).
16. **BUG-848 (LOW): the upload can send a half-written .tmp file.** `CeAdminStorageService.cs:170-192`. Failing test first: a .tmp in the folder is left alone. Root cause (e).
17. **BUG-835 (LOW-MEDIUM): approving the same version twice loses the real roll-back version.** `CeApprovedReleaseService.cs:100,119-128`. Failing test first (after a small seam): same version twice keeps the first roll-back.
18. **BUG-851 (LOW-MEDIUM): Disable on Restart also disables the pipe-object file and native grips.** `CePluginRegistryService.cs:251-256`. Failing test first: on a copy of Civil's manifest only the main dll entries change.
19. **BUG-836 (LOW): devices behind is wrong for Structural.** `CeAdminAnalyticsService.cs:46-48,156-158`. Failing test first: "v1.0.118" against approved "1.0.119" counts as behind. Root cause (d).
20. **BUG-837 (LOW): no restart message from 3.0.99 to 3.0.100.** `CeOneGlanceStatus.cs:134-135`. Failing test first: `CompareVersions("3.0.100", "3.0.99+abc")` is greater than 0. Root cause (d).
21. **BUG-838 (LOW): read-only synced files can leave old folders behind.** `CeUpdateStagingService.cs:607,784-798`. Failing test first: a read-only source file is staged and the old folder is removed.
22. **BUG-846 (LOW): fixed salt when the privacy code file cannot be saved.** `Shared/CE_SHARED/Services/CePiiHash.cs:128-135` (Structural has the same pattern, `StructuralPiiHash.cs:53`; lane 02 can take that half). Failing test first: with an unwritable folder two sessions give different codes.
23. **BUG-847 (LOW): the support-zip cleaner keeps names under AppData and Temp.** `CeSupportBundleScrub.cs:19,53,67-90`. Failing test first: a Temp PDF named after a job and an autosave .sv$ both come out coded.
24. **BUG-849 (LOW): an online-only admin list is reported as "damaged".** `CeAdminPolicyService.cs:77-79`. Failing test first: an offline-file read error says "not downloaded".
25. **BUG-852 (LOW): ribbon buttons call commands from modules that may not be installed.** `CeToolsRibbonDefinitionService.cs:18`. Failing test first: a cross-module guard. Waits on QUESTIONS_FOR_MONDAY section I item 7.
26. **BUG-853 (LOW): the ribbon click log grows for ever and records drawing names.** `RibbonBuilder.cs:705-716`. Failing test first: a source guard that the log is capped and has no drawing name.

### build/04 Civil windows, schedules, QA: 2 lines

1. **BUG-830 (MEDIUM-HIGH): Reset Civil in CEMANAGER resets values the page does not show** (LPD note, templates folder, confirmed clearances and more). `CivilSettingsView.xaml:197-200`, `AdvancedSettingsViewModel.cs:1045-1105,1512-1606`. Failing test first: `AdvancedSettingsViewModel` with a fake writer, Reset then Apply leaves the hidden values alone. Root cause (c).
2. **BUG-839 (MEDIUM): the CEMANAGER Civil page can undo a change just saved in CDS.** `CeCivilSettingsBridge.cs:20`, `AdvancedSettingsViewModel.cs:1174,1259,1512`. Failing test first: two view-model copies on one file, the second Apply keeps the first's cover depth. Root cause (c): fix 1 and 2 together.

### build/02 Structural: 3 lines

1. **BUG-826 (HIGH): Structural Reset Defaults wipes every setting in one click.** `CeSettingsDialog.xaml:18`, `CeSettingsDialog.xaml.cs:459-462`, `SettingsService.cs:108-121,510-520`. Failing test first: after the reset logic comes out of the window code, reset keeps the migration flags and the lists with no page, and a kept copy exists.
2. **BUG-840 (MEDIUM): a second AutoCAD's routine save reverts a change made in the first.** `SettingsService.cs:122-137,919-931`, `LoadRecovery.cs:955`. Failing test first: two settings copies on one file, each routine save leaves the other's field alone.
3. **BUG-841 (LOW-MEDIUM): CESETTINGS ignores a mistyped number and closes as if it saved.** `CeSettingsDialog.xaml.cs:257-270,563-592`. Failing test first (after parsing leaves the window code): "1,200" is refused with the box named.

## 14. Run 33 fixes (19 Oct night)

Added Mon 19 Oct 2026 (night) by the desk (headless job). Source: `areas/release-v3-colleagues-CLAUDE_DRIVER_RUN33_V2_2026-10-20.md` (robot pass 12, real AutoCAD 2027 on test copies, installed Civil 3.0.57 / Manager 1.1.57, train C-46). The report has 11 numbered checks: 7 PASS, 2 STILL FAILS, 1 BLOCKED, 1 UNPROVEN. No new bug filed. "Run 33" notes went onto BUG-815, 814, 813, 820, 825, 782, 797, 816, 835, 822, 372, 141 and 698. Nothing here is Tim-accepted and nothing is marked FIXED. Driver and fixture gaps are in `areas/release-v3-colleagues-ROBOT_GAPS_2026-10-19.md` (run 33 section), not in this queue.

**Rule for every line below:** reproduce on a drawing that already has a detention-length "0" stored in its pipe records (the run 31 downpipe drawing), not on a freshly drawn pipe, and write the failing test first.

### build/03 Civil engine: 3 lines, in order

1. **BUG-815 second attempt (MEDIUM, engineering-result risk): the false R-06 rows survive fix #1436 on 3.0.57.** CDCHECKS still says "63 to look at, 243 OK, 312 not known" and 14 of the 20 printed rows are "detention diameter 100 mm (or 150 mm) outside 225600 mm". The fix did not take effect on that drawing; cause unproven (a different code path, a stale stored value, or the switch/default; do not guess). NEW EVIDENCE: Edit Pipe on the 100 mm downpipe 1093C7 reads "Detention pipe, 100 mm, UPVC" with the Detention button ON and an EMPTY "Required detention pipe length" box. The second attempt must first decide whether the rule is right for a pipe that is marked Detention with no length (then the fixture is the problem and the row should say "detention pipe has no length" in words), or wrong (a plain downpipe wrongly marked Detention). Read the #1436 change and the stored-field behaviour first; `RulebookEngine.IsDetentionPipe` (stored length, `RulebookDrawingType`, the stored flag, twin pipes). Also find out whether the flag was in the file or set when CE upgraded 49 pipes to CE pipe objects on opening. Failing test first: a 100 mm pipe with the Detention flag and an empty length, and one with a stored 0, built from the real pipe record on 1093C7, each expected to give the answer the decision above sets.
2. **BUG-141 / BUG-816 / BUG-372 (MEDIUM): Tidy labels says "No clear spot" for a start text that is clear of the pit.** Third run in a row (runs 31, 32, 33): new pit P8, 20 m pipe, inverts 18.000 / 17.900, "IL 18.000" about 30 pixels right of the pit box, yet "on pit P8" and "No clear spot found". Nothing ever reaches "Will move", so Apply, U and REDO stay untested. Find why the obstacle test counts the pit (obstacle box too large, or the pit's pick area). Failing test first: a pure placement case, a 20 m pipe with the start text placed clear of the pit, expects a clear spot. Second half: after a typed MOVE the lines still end '(on "the block Drawing Border")'; name the real obstacle or say nothing.
3. **BUG-820 (LOW-MEDIUM, needs Tim's call): Recover Inverts.** Wording now PASS. Still open: it draws nothing for a pipe with one of two texts, and the totals line says "26 already had invert text" while the next line says those pipes were not drawn. If Tim says draw the missing end: failing test first, erase one IL text, run it, the text comes back once, no duplicate. Either way make the totals line not count those pipes as done.

### build/04 Civil UI, schedules, QA: 2 lines, in order

1. **BUG-813 (MEDIUM-HIGH): CDFIXTAGS rename still does not apply (not run in run 33; last seen run 32).** Failing test first: two ordinary source blocks both "DP3" are renamed to DP4 in one undo step. Needs a fixture of two ordinary source blocks (robot gap). Do not close BUG-740, 741, 744 or 746.
2. **BUG-822 (LOW): the "What's New" palette opens partway through a session** (seen again in run 33 session 1, not in session 2). Find which step opens it; failing test first: What's New opens only at first start after an update or on request.

**Not in the queue:** BUG-698, 782, 797 (CDSYNC and the Edit Pipe cascade Apply, U, REDO) and the quick-edit check (typed MOVE and STRETCH open no CE window) PASS again; BUG-814 part 3 wording PASS ("unnamed pipe"); BUG-825 PASS by the guard route only; they stay OPEN until Tim or Codex accepts. BUG-835 is UNPROVEN and BUG-830/839 BLOCKED (robot gaps 5 and 6).

## 15. Run 34 fixes (19 Oct night)

Added Tue 20 Oct 2026 by the desk (headless job). Source: `areas/release-v3-colleagues-CLAUDE_DRIVER_RUN34_V2_2026-10-20.md` (robot pass 13, real AutoCAD 2027 on test copies, installed Civil 3.0.58 / Manager 1.1.58, train C-47). The report has 12 numbered checks: 10 PASS, 2 STILL FAILS (both are BUG-141 halves). One new bug filed: BUG-854 (wording). "Run 34" notes went onto BUG-815, 814, 813, 698, 742, 797, 782 and 141. Nothing here is Tim-accepted and nothing is marked FIXED. Driver and fixture gaps are in `areas/release-v3-colleagues-ROBOT_GAPS_2026-10-19.md` (run 34 section), not in this queue.

**BUG-815 is not queued.** The robot saw the false R-06 rows go on the downpipe fixture (14 of 20 printed rows down to 0; 0 "outside" rows in the full list). Runs 32 and 33 had still seen them on 3.0.56 and 3.0.57, so the first #1436 fix did not take effect on that drawing and the cause was never proven. Do not reopen it unless Tim sees the false rows on his own drawing. The nine main pipes that now read "not judged" are a question for Tim (QUESTIONS_FOR_MONDAY.md, section I, item 8), not a fix.

**Rule for every line below:** reproduce on a drawing that already has a detention-length "0" stored in its pipe records (the run 31 downpipe drawing, DRV1_B1), not on a freshly drawn pipe, and write the failing test first.

### build/03 Civil engine: 2 lines, in order

1. **BUG-141 first half (MEDIUM): Tidy labels says "No clear spot" for a start invert text that is clear of the pit.** Fourth run in a row (runs 31 to 34). New pit P8, 20 m pipe, inverts 18.000 / 17.900: "IL 18.000" starts about 30 pixels clear of the pit outline with nothing under it, yet placement says "(on "pit P8")" and CDTIDYLABELS says "No clear spot found 5". The report names no file or function. Failing test first: a start invert text whose box does not touch the pit's own block extents is not reported as blocked by that pit. Find what extent is used for the pit (the block's full extents, an attribute or hidden geometry, or a padded search window) and compare it with the text box.
2. **BUG-854 (LOW): the R-06 "not known" fix line says "Enter the detention pipe diameter (CDEDIT)" while the row says enter the length or untick Detention.** Failing test first: the fix line for the no-length row matches the row. Then do not touch the "not judged" behaviour on the main pipes until Tim answers the question.

### build/04 Civil UI, schedules, QA: 3 lines, in order

1. **BUG-141 second half (MEDIUM): the border block is still named as the obstacle.** After a typed MOVE of P3 the line reads "pipe P3 -> P2 label: no clear spot ... (on "the block Drawing Border")" although `linking.tidyIgnoresSheetFrame` is ON by default, so fix #1480 did not recognise this drawing's border block. First find how #1480 decides a block is the sheet frame (the report names `TidyObstacleRule.IsSheetFrame`: it ignores only a block that wholly surrounds the search window and is more than twice its width and height; not by block name, layer or size alone) and why "Drawing Border" on the DRV1_B1 copy is not matched. Read the border block's extents against the P3 to P2 label's search window. Failing test first with that exact block (its real extents and the real search window), not an idealised frame. The same test must also cover "SC", named as the obstacle for the P4 to P3 label.
2. **BUG-813 (MEDIUM-HIGH): CDFIXTAGS rename still does not apply.** The refusal now names the fault ("already carries the CE identity of another kind of object"), but both fixture DP3 blocks are pit blocks, so a rename on two ordinary source blocks is still unproven. Failing test first: two ordinary source blocks both "DP3" are renamed to DP4 in one undo step. Needs the two-ordinary-source-blocks fixture (robot gap). Do not close BUG-740, 741, 744 or 746.
3. **BUG-822 (LOW): the "What's New" palette opens partway through a session** (listed after the typed MOVE in session 1, not in session 2). Failing test first: What's New opens only at first start after an update or on request.

**Not in the queue:** BUG-698 (CDSYNC), BUG-782 and 797 (Edit Pipe cascade Apply, U, REDO; the locked-layer and low-end cases were not tested in run 34), BUG-742 (used-name CDTAG), BUG-814 wording, and the typed MOVE / STRETCH quick-edit check PASS. They stay OPEN until Tim or Codex accepts. Recover Inverts #1406 (BUG-820) was not part of run 34.

## 16. Run 35 fix queue (20 Oct)

Added Tue 20 Oct 2026 by the desk (headless job). Source: `areas/release-v3-colleagues-CLAUDE_DRIVER_RUN35_V2_2026-10-20.md` (robot pass 14, real AutoCAD on test copies, installed Civil 3.0.59 / Manager 1.1.59, train C-49). The report has 16 numbered checks: 15 PASS, 1 STILL FAILS. One new bug filed: BUG-855 (LOW). "Run 35" notes went onto BUG-141, 820, 854, 815, 813, 742, 798/782 (cascade), 698 and 822. Nothing here is Tim-accepted and nothing is marked FIXED.

**Rule for every line below:** reproduce on the run 31 downpipe drawing (DRV1_B1 copy), not on a freshly drawn pipe, and write the failing test first.

**Not queued (PASS on the robot's copies):** BUG-141 pit-body half (#1482; with `linking.tidyPitByBodyOutline` ON the "no clear spot (on pit P8)" line is gone, with it OFF the line returns), BUG-820 totals line (#1441), BUG-854 wording (#1481, 30 of 30 rows), BUG-815 (0 false R-06 rows), the Edit Pipe cascade and CDSYNC rows. They stay OPEN until Tim or Codex accepts. The detention tank end walls and long sides of BUG-141 are unmeasured (no fixture).

### build/03 Civil engine: 1 line

1. **BUG-855 (LOW): the Pit Schedule header says "96 data issues" after the first CDSYNC where it said "95" before.** Every row is identical and a second CDSYNC changes nothing. Failing test first: on a drawing with a pit and a pipe that has a flagged open end, the count of data issues before CDSYNC equals the count after (or the new issue is named). Find which issue the count gains: compare the list of issues before and after, not just the number. Run 34 did not see it because its CDSYNC ran before the new pit and pipe were drawn.

### build/04 Civil UI, schedules, QA: 2 lines, in order

1. **BUG-141 Drawing Border half (MEDIUM), SECOND ATTEMPT THAT DID NOT TAKE: "pipe P3 -> P2 label: no clear spot ... (on the block Drawing Border)" with `linking.tidyIgnoresSheetFrame` ON by default.** Seen on runs 33, 34 and 35 (3.0.57, 3.0.58, 3.0.59); #1480 (C-47) did not change it, and the pipe P4 -> P3 label names a second block, "SC". First find how #1480 decides a block is the sheet frame. Run 34's note says `TidyObstacleRule.IsSheetFrame` ignores only a block that wholly surrounds the label's search window and is more than twice its width and height; it does not use the block name, layer or size alone. Then find why "Drawing Border" on the DRV1_B1 copy (and "SC") fails that test: is the border smaller than twice the window, does it not wholly surround the P3 -> P2 window (a border drawn as a frame around the sheet, or a sheet-sized block that the label sits near but outside), or are its extents measured differently (attributes, hidden geometry, a padded extents)? Failing test first with that exact block: its real extents, layer and name from DRV1_B1, and the real search window of the P3 -> P2 label, not an idealised frame. The same test must cover "SC". **Evidence still missing:** the border block's extents against the label's search window. The robot has no verb that returns a block's bounding box. Two ways to get it without inventing a command: (a) one read-only LISP line sent with `-AllowLisp`, as the robot already does to read a text's handle, that prints the block's name, layer and bounding box for the Drawing Border and "SC" handles (read only, nothing changed); or (b) a Codex Properties look at the block's position, scale and layer on a test copy. The desk should approve (a) or (b) before the next robot pass; the plan lists the missing read in the robot gaps file (run 35 section).
2. **BUG-822 (LOW): the "What's New" palette opens partway through a session.** Seen again on run 35 (session 1, closed by quit). Unchanged from the run 34 queue. Failing test first: What's New opens only at first start after an update or on request.

**Unchanged and not re-queued:** BUG-813 (CDFIXTAGS rename: still refuses on the pit blocks; the two-ordinary-source-blocks fixture is still missing, run 34 queue line 2 stands), CDTAG used-name refusal (BUG-742 and BUG-814 wording).

## 17. Run 36 fix queue (20 Oct)

Source: CLAUDE_DRIVER_RUN36_V2_2026-10-20.md (robot pass 15, installed Civil 3.0.60 / Manager 1.1.60, train C-50). The report names no other new product problem.

### build/04 Civil UI, schedules, QA: 1 line

1. **BUG-141 text obstacle (LOW, diagnostic only, NO behaviour change): add one CE log line when a TEXT is kept as an obstacle in the label tidy-up.** The Drawing Border half now has its evidence (the border fails only the "wholly surrounds the search window" test, right side short by 3,381 units, because pit P2 and its PIT LABEL lie outside the border); but the "SC" text obstacle seen on run 35 could not be reproduced and the log has no line for a text obstacle, so nobody can say what it was. The line, written with debug logging on, in the same style as the existing block line: the text's words, its handle, its layer, its corners in drawing units, and the search window it was kept against. Failing test first: a TEXT inside a pipe label's search window produces the line; no TEXT produces none; the tidy-up result is identical with and without the line. Do not touch the border rule: the desk is making that fix PR itself (see REVIEWLANE_LOG).


**Run 37 note on the lane 04 line above (20 Oct, Civil 3.0.61 / C-51, evidence CLAUDE_DRIVER_RUN37_V2_2026-10-20.md C items 1 and 2):** the border half now passes on the robot, so the text-obstacle diagnostic is now THE missing evidence for the last BUG-141 symptom. The P3 -> P2 label is still blocked, now by a text "SC" (layer SLAB SC, height 250, several in the window). Without the log line (words, handle, layer, corners, the window) the robot cannot tell which SC text was named. Still diagnostic only, no behaviour change. No other new fix line from run 37: the report names no other real product problem. The Tidy labels "would move" wording gap is filed as BUG-856 (LOW, wording only, not queued).
**Not queued (PASS on the robot's copies, run 36):** BUG-141 pit-body half, BUG-820 totals (#1441), BUG-854 wording (#1481), BUG-815, the Edit Pipe cascade, CDSYNC and quick-edit rows. They stay OPEN until Tim or Codex accepts. **UNPROVEN, nothing to build:** BUG-709 and BUG-683 (no typed form for either; see the robot gaps file, run 36).


## 18. Run 38 fix queue (20 Oct)

Source: CLAUDE_DRIVER_RUN38_V2_2026-10-20.md (robot pass 17, installed Civil 3.0.62 / Manager 1.1.62, train C-52). 10 of 10 checks PASS on the robot's copy.

**The BUG-141 chain is complete with no new fix line.** The text-obstacle diagnostic (#1485) works: the log named four SC texts on layer SLAB SC, and one of them (SC 10B734) really overlaps the P3 -> P2 label's box. The remaining "No clear spot" is a genuine overlap on a crowded drawing, not a Tidy labels fault. The two real causes the chain found (hidden pit circle #1482, border block #1484) both PASS on the robot. BUG-141 stays OPEN until Tim or Codex confirms in AutoCAD; it is proposed for closure by Tim, and the desk does not close it.

**No other real product problem named.** The report's lesser notes are already filed and not re-queued: the sheet-frame log line prints no numbers (run 37 note, low), the CDSYNC "95 to 96" Pit Schedule count (BUG-855), and the cosmetic "waiting at a prompt" alarm after CDSYNC. **Optional, not queued, Tim's call:** one more log line listing which alternative spots were tried and what stopped each (report D item 4); only worth building if Tim wants the SC question settled by evidence rather than by hand.


## 19. Run 39 fix queue (20 Oct)

Source: CLAUDE_DRIVER_RUN39_V2_2026-10-20.md (robot pass 18, installed Civil 3.0.63 / Manager 1.1.63, train C-53). Counts: PASS 9, FAIL 0, BLOCKED 1, UNPROVEN 2.

**No real product problem found, so no new lane line.** BUG-516 passes (CDRULES Values and CDTWL both print 150, and both print 200 when the Design Standards copy is 200). BUG-557 passes with a limit (file modified time only). BUG-820, BUG-854, BUG-815 and the BUG-141 pit half pass again. All stay OPEN until Tim or Codex confirms in AutoCAD.

**Driver, not product:** BUG-505 is BLOCKED because dialog-path fails in the driver (missing Windows UI Automation type). It is the next driver-v3 task for the desk; see the robot gaps file, run 39. No plugin change is needed to unblock it.

**UNPROVEN, nothing to build:** BUG-476 (Manager windows are read-only for the driver) and the command-name guard (UX-NAMES-01 and 06, #1166; a source test, 9 of 139 commands spot-checked fine). BUG-556 is a code removal with nothing to drive.

**Manager release-build guard finding (78 -> 75): FIXED ON THE BRANCH at 0d3b1f49 (fix job entry 1487).** It is awaiting Opus re-review in the next train. It is built and unit-tested only; nobody has opened it in AutoCAD.

## 20. Run 40 fix queue (20 Oct)

Source: CLAUDE_DRIVER_RUN40_V2_2026-10-20.md (robot pass 19, installed Civil 3.0.64 / Manager 1.1.64, train C-54). Counts: PASS 9, FAIL 0, BLOCKED 0, UNPROVEN 2.

**No real product problem found, so no new lane line.** BUG-820, BUG-854, BUG-815, BUG-516 and BUG-141 pass again. BUG-522 passes for the matched-copies case only. All stay OPEN until Tim or Codex confirms in AutoCAD.

**UNPROVEN, nothing to build:** BUG-416 (the right-click items cannot be driven; needs Tim or Codex by hand) and the BUG-522 mismatch case (needs different CE_SHARED files). One launch anomaly is noted in the robot gaps file, run 40; one occurrence, watch only.
