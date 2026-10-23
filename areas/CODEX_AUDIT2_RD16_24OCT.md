# RD16 independent long-section and profile audit — 24 October 2026, Melbourne

1. **ANSWER FIRST — HIGH 1 / MEDIUM 3 / LOW 0.** Four new findings, all SURE and verified-by-reading. None was run in AutoCAD. Known bugs are excluded from these counts.

2. **Most important — the section can hide a real depression in the ground.** Survey levels 1.50 m below the pit covers are silently discarded. CE draws a straight surface through the covers instead, making an exposed pipe look buried. The review does not warn that these survey levels were rejected.

3. **Second — a curved property boundary is treated as straight.** In the specified example, its mark is drawn at 5.00 m along the pipe when the real crossing is at 10.00 m.

4. **Third — clicking one pipe leg can move the label to another.** CE chooses the closest leg midpoint rather than the closest part of the pipe. Clicking directly on a long leg near a bend can therefore choose the short leg beside it.

5. **Fourth — moving pipe text in a rotated view turns it wrongly.** CDTEXTSEG converts the label position back to the drawing axes but leaves its angle relative to the rotated axes. A label intended to follow a 45-degree pipe can finish horizontal in World coordinates.

6. **Next step.** The test lane has exact synthetic cases below. This audit authorises no repair or installation and asks Tim to do no testing.

---

1. **Source and ownership.** Read RULES.md, ROUTER.md, START_HERE.md, MASTER_PLAN.md and Area K. Fetched the plugin repository and created the detached, read-only worktree `C:\ce-cx\rd16` at `origin/claude/rel-20261023m`, commit `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`. The nominated source is Civil 3.0.72 / Manager 1.1.72; installed DLL identity was not independently checked. No branch or code commit was made. The clean audit worktree was removed before saving this report. This report is the only file authored by this session.

2. **Prior evidence and duplicate check.** Read `AUDIT_C58_C60_S40_S41_2026-10-22.md` and the Civil, Structural and Gate `CODEX_AUDIT_*_22OCT.md` reports. Searched BUG_CARPARK.md before code reading and again against the final failure mechanisms. Read source using Git objects; compared the relevant profile/label files against `origin/claude/rel-20261022m` with no differences in that scoped comparison. These findings are present at the requested newer head, not claims of regressions introduced by C-62.

3. **Known items excluded — numbers only.** BUG-074; BUG-331; BUG-542; BUG-544; BUG-547; BUG-599; BUG-600; BUG-601; BUG-756; BUG-757; BUG-758; BUG-759; BUG-760; BUG-761; BUG-762; BUG-763; BUG-764; BUG-765; BUG-766; BUG-767; BUG-768; BUG-769; BUG-997; BUG-1012; BUG-1020.

4. **Meaning of the verdict.** SURE / verified-by-reading means the cited code and the specified arithmetic establish the failure path. It does not mean a native reproduction passed. HIGH means materially misleading engineering output; MEDIUM means a wrong drafting result. All deterministic tests below are proposed, NOT RUN. Fix directions retain R-27: warn and continue for uncertain engineering evidence, without inventing a new hard block. Any engineering thresholds retained belong on Settings under R-00.

5. **Common profile fixture for the later tester.** Use a disposable, synthetic millimetre model-space drawing, INSUNITS 4, World UCS, Z=0, unlocked output layers and all profile linetypes already loaded, including DASHDOT2. Two registered CE pits P1 at (0,0) and P2 at (20000,0), both 600 x 600 mm, cover RL 10.000 m; one linked straight DN300 UPVC pipe P1-P2, IL 9.000 to 8.800 m, grade 1 in 100. Pits and pipe belong to schedule set Main, are included in the schedule and have one consistent recorded drainage system, readable ownership and complete route records. No other pipes or Xrefs. Use datum RL 8.00 m, horizontal 1:100 and vertical 1:10. Fixtures must be prepared by the later test lane; none was created here.

## Numbered findings

1. **RD16-01 — HIGH — legitimate survey relief is silently replaced by the line through pit covers. SURE; verified-by-reading.**

   **File:line:** `Modules/Drainage/ViewModels/LongitudinalSectionViewModel.cs:1468`, `:1488`, `:1522`, `:1583`, `:1598`; `Modules/Drainage/Services/ProfileRouteEvidenceCaptureService.cs:315`, `:335`; `Modules/Drainage/Services/ProfileRouteReviewService.cs:608`, `:640`; `Modules/Drainage/Services/LongitudinalSectionService.cs:1598`, `:1263`.

   **What a drafter sees:** The pipe appears buried below a level surface even though the supplied survey shows a depression beneath it. There is no warning that the surface has been replaced by a line between the pit covers. This concerns genuine surface levels, not unrelated numbers misread as survey levels.

   **Exact failure scenario and proof:** Add an identity-transform Xref containing only two plain DBText spot levels `RL 8.50`, at (9000,0) and (11000,0), on a survey layer. At chainage 10 m the expected level is the average pit cover, 10.00. All three search passes reject both actual levels because their difference, 1.50 m, exceeds even the largest allowed difference, 1.20 m. The earlier passes allow only 0.60 and 0.90 m. Other probes also reject them. Failed estimation merely continues; the samples seeded from pit covers survive. Capture returns success and marks surface evidence complete. The writer joins those covers on 70CONT, producing RL 10.00 across the middle. The DN300 pipe crown there is RL 9.20: the drawn ground is 0.80 m above it although the survey depression is 0.70 m below it. The thresholds and fallback, not text recognition, cause this failure.

   **Smallest fix:** Preserve an explicit unresolved/rejected-survey result for each failed probe, carry its reason into the review and output, and do not present an unqualified line through covers as established surface across that gap. Let the section continue with a clearly marked unknown surface. Do not silently widen the tolerance and certify the estimate. Any retained acceptance limits need named Settings values; no new engineering limit is proposed here.

   **DETERMINISTIC TEST — fixture and typed steps:** Use the common fixture plus the two-level Xref above. Type `CDPROFILE`, pick P1, select the explicit P1-P2 route and Main, enter datum 8.00 / horizontal 100 / vertical 10, click **Preview New**, enter insertion (40000,0), click **Apply**, then **Close**. Read the review status before Apply and inspect the resulting section block's 70CONT surface polyline.

   **Assertion:** The review/output must disclose that the survey cannot be represented by the current surface estimate, or draw an independently justified surface; it must not silently show RL 10.00 through the depression. At the midpoint, the current source predicts a surface ordinate 20000 drawing units above the datum line: `(10-8) x 10000`. RL 8.50 would be 5000 units above it. Capture must retain a warning or unknown gap when rejecting those spots. Positive control: change both source strings to `RL 9.50`, reload the Xref and repeat; the code then accepts an interior RL 9.50 sample. This isolates the cover-based rejection from loading, units and parsing. Read-back assertions, not a successful Apply message, decide this test.

2. **RD16-02 — MEDIUM — a curved boundary is replaced by its chord, moving the boundary mark. SURE; verified-by-reading.**

   **File:line:** `Modules/Drainage/ViewModels/LongitudinalSectionViewModel.cs:1189`, `:1192`, `:1225`, `:1314`, `:1319`. Active reviewed-path entry: `:845`, `:893`, `:895`.

   **What a drafter sees:** A curved title boundary crosses the pipe at 10.00 m in plan, but the section marks it at 5.00 m. This case uses a straight pipe and an open boundary; it does not rely on either a bent route or a missing closing side.

   **Exact failure scenario and proof:** In an identity-transform Xref, put an open lightweight polyline on BOUNDARY, vertices (5000,-5000) and (5000,5000), first-vertex bulge +1. Its semicircle bows east through (10000,0). The common fixture's straight P1-P2 pipe therefore crosses the actual arc at chainage 10.00 m. CollectBoundarySegments reads only consecutive vertex positions and constructs a LineSegment2d, never reading the bulge. Its substitute vertical chord crosses at (5000,0); ProjectBoundaryMarkers converts that to chainage 5.00 m. Both locations lie clear of the pits. An ARC entity is also absent from the collector's handled types, but the counted finding and test use the explicitly accepted polyline case.

   **Smallest fix:** Intersect the actual transformed polyline segments, including arcs, with the route and measure the actual crossing. Preserve curve geometry in the captured evidence. If a curve cannot be resolved, warn and leave that mark unresolved while drawing the rest; do not manufacture a straight-boundary mark.

   **DETERMINISTIC TEST — fixture and typed steps:** Use the common fixture without survey text. Attach the synthetic Xref with the exact open curved BOUNDARY polyline above. Type `CDPROFILE`, pick P1, select P1-P2 / Main, datum 8.00 / H100 / V10, click **Preview New**, insert at (40000,0), **Apply**, **Close**. Read the X coordinate of the section's vertical BOUNDARY mark relative to P1's section station.

   **Assertion:** At H1:100 the mark is 10000 drawing units right of P1, representing 10.00 m; current source predicts 5000 units, representing 5.00 m. The captured boundary snapshot should likewise carry 10.00 m. As a control, make the first bulge zero and reload: 5.00 m is then correct. No closing edge is involved in either case.

3. **RD16-03 — MEDIUM — click-to-move selects the nearest midpoint instead of the pipe leg clicked. SURE; verified-by-reading.**

   **File:line:** `Modules/Drainage/Helpers/PipeTextSegmentChooser.cs:116`, `:124`, `:126`; production caller `Modules/Drainage/Services/PipeTextPlacementService.cs:35`, `:48`; command entry `Modules/Drainage/Commands/CdCommand.Arrows.cs:20`, `:43`. The arrow relocation path also calls this chooser at `CdCommand.Arrows.cs:87`.

   **What a drafter sees:** They click directly on the long leg of a bent pipe to move its label there. The label goes onto the short leg around the corner and CE prints `Pipe text moved.`

   **Exact failure scenario and proof:** Linked pipe vertices in World coordinates are (0,0), (20000,0), (20000,1000). Pick (19000,0), exactly on the first leg and 1000 mm from the second. The chooser measures 9000 mm to the first midpoint (10000,0), but approximately 1118 mm to the second midpoint (20000,500), so returns segment index 1. The actual point-to-segment distances are 0 and 1000 mm: index 0 is unambiguous. The existing chooser tests use equal-length legs and picks close to their midpoints; those inputs do not expose this case. They were read, not executed.

   **Smallest fix:** Rank the clamped perpendicular distance from the pick to each finite segment, retaining a stable tie-break at shared vertices. Do not use midpoint distance to identify which leg was clicked.

   **DETERMINISTIC TEST — fixture and typed steps:** Disposable mm drawing, World UCS, one linked CE DN300 three-vertex pipe with the vertices above, and one ordinary inline MText pipe label on unlocked 25TEXT. No supplementary label or callout. Type `CDTEXTSEG`, pick this pipe, enter `19000,0` at the move prompt.

   **Assertion:** The command may print `Pipe text moved.`, but the label must sit beside the first, horizontal leg, centred longitudinally at X=10000 with rotation parallel to that leg. Current source places it beside the second, vertical leg, longitudinally at Y=500. Read the label's actual Location and Rotation. A focused future regression must require `NearestSegmentToPoint` to return 0 for this same three-point fixture; the current loop returns 1. Positive control: pick (20000,500), which must choose the second leg.

4. **RD16-04 — MEDIUM — CDTEXTSEG writes a UCS angle into a World-plane text object. SURE; verified-by-reading.**

   **File:line:** `Modules/Drainage/Commands/CdCommand.Arrows.cs:43`, `:206`; `Modules/Drainage/Services/DrawingService.cs:71`; `Modules/Drainage/Services/PipeTextPlacementService.cs:69`, `:72`, `:89`, `:90`, `:96`, `:99`; `Modules/Drainage/Services/PipeCreationService.cs:985`.

   **What a drafter sees:** With their view aligned to a diagonal pipe, moving its label makes the words sit diagonally across that view rather than following the pipe. Returning to World shows that the pipe is at 45 degrees but its text is horizontal. This occurs even when the correct segment is selected.

   **Exact failure scenario and proof:** Start with a World-plane pipe and inline MText, normal (0,0,1), vertices (0,0), (10000,10000), (10000,20000). Set UCS Z=45 degrees. TryGetPipeTextMoveContext converts the vertices to UCS; CDTEXTSEG calls PromptMovePipeTextToSegment without the optional transform. For the first leg, the calculated angle is now zero. MovePipeTextToSegment sends the location through PipeCreationPlanPoints.Output, whose null-transform branch applies the current UCS, but writes `mtext.Rotation = rotation` directly. DBText has the same mismatch. The subsequent UpdateAttachmentFromEntity at `LinkService.cs:1106` records the resulting placement; its inspected path does not correct this angle. This finding is limited to ordinary World-plane inline text, not MLeader text or tilted planes.

   **Smallest fix:** Pass the current UCS explicitly when CDTEXTSEG hands its UCS vertices to the placement service, so the existing admission path converts points before both position and angle are calculated. Alternatively transform the direction as well as the location; use one consistent coordinate system for both. Preserve the World-plane output contract.

   **DETERMINISTIC TEST — fixture and typed steps:** Prepare the exact linked pipe and a single ordinary World-plane inline MText label above; all annotation layers unlocked. Type `UCS`, `World`; `UCS`, `Z`, `45`; `PLAN`, `Current`. Type `CDTEXTSEG`, pick the pipe, enter `7071.067811865,0` at the move prompt, which is the first leg's midpoint in this UCS. Type `UCS`, `World`, then read the label's Rotation and Location using Properties or a read-only entity inspection.

   **Assertion:** The label rotation must be 45 degrees modulo 180 degrees, parallel to the first leg, while its location remains alongside that leg. Current source assigns 0 degrees. Repeat on a fresh copy without the UCS rotation: the same World midpoint pick (5000,5000) produces 45 degrees, isolating the coordinate mismatch from the text style and ownership. The midpoint pick deliberately avoids RD16-03.

## What was not checked

1. **No execution.** No build, unit test, native test, AutoCAD session, installation, settings change, drawing change or sub-agent. The report's examples are source-derived predictions. No bug was marked fixed or accepted.

2. **Unreviewed runtime behaviour.** Actual window appearance, text extents, plots, command event timing, Undo/Redo, save/reopen, automatic reactions after label movement, performance and older AutoCAD runtime lanes remain untested. The proposed tests must inspect the persisted drawing values as well as what appears on screen.

3. **Scope limits.** No separate Structural source review, Manager administrator work, standards-edition review, live installation verification, XCLIP/visibility validation, arbitrary 3D transforms or full survey-import audit. Boundary and surface paths were traced through CDPROFILE's capture and writer; branch-mark routing and the older writer were read for duplicate checking. No known defect is restated as a new finding. No new engineering number or standard is asserted.

4. **Delivery.** Only `areas/CODEX_AUDIT2_RD16_24OCT.md` is to be staged and committed in CE_PLAN. Other sessions' files are outside this audit. BUG_CARPARK.md, DESK_LOG.md and QUEUE.md were not edited. No code PR applies to this read-only task.

## Summary

1. **Four new faults: one HIGH, three MEDIUM.** Survey rejection can conceal a depression, curved boundaries receive wrong chainages, midpoint-based picking selects the wrong pipe leg, and CDTEXTSEG mishandles text rotation under a rotated UCS. All are verified by reading the nominated source and have deterministic future checks. Known bugs were excluded. No code changed and no tests ran; native confirmation remains outstanding.
