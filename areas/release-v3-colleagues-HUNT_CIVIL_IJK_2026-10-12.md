# HUNT: Civil I, J, K — WSUD, overland flow, profiles and long sections (read-only code audit)

**Job:** desk plan/03, Team usage governor. Read-only. No code changed, nothing built, nothing run in AutoCAD.
**Written:** 18 Oct 2026 (Melbourne). The file name keeps the 12 Oct date the job asked for.
**Code audited:** the installed Civil lineage: `origin/claude/rel-20261018d` at `70a4e24f` ("Civil 3.0.55 / Manager 1.1.55 (C-44)"). This is the newest Civil release head on origin; it is not master. It was read in a private detached worktree at `C:\ce-hunt\ijk`, which is removed at the end of the job.
**Known bugs left out:** BUG-599, 600 and 601 (CDPROFILE linetype found late, title overlap, update needs REGEN); BUG-542 (the long section's own roughness list); BUG-331 item 4 (the long section reads metre-drawing lengths as millimetres); BUG-338 (metre and millimetre mix); BUG-176 (CDRG and the GIO); BUG-230 and BUG-242 (raingarden areas in metre drawings); BUG-695; DFGH-44 and DFGH-45 (WSUD comma decimals, FAIL at exactly the target); HUNT_CIVIL_E G7 (crossing within 1 m); R00_CIVIL items 22 and 64 to 67 (fixed numbers); and the PLAN_GAP note that `CrossingServiceRule` and `ProfileScheduleRowPreview` have no caller.
**Rulebook read:** `ENGINEERING_RULEBOOK.md` sections B to E (grades show the achieved grade; invert levels to 2 dp; 1 in N is a whole number; detention TWL rules).

---

## Plain-English summary: the 10 worst

1. **The long section draws a pipe at the next pipe's size.** In a run that goes from 225 to 375, the 225 pipe is drawn as a 375: its top line sits 150 mm too high. Every pipe just before a size step is wrong. This happens in both CDPROFILE and the older CDCALC long section.
2. **A trench grate with a placeholder cover of "0.000" is drawn at RL 0.00.** The surface line drops from about RL 19 to RL 0, through the datum and into the table, and CE still says Ready.
3. **CDCALC still has a second long-section writer with no safety checks.** The "Older longitudinal" tab is hidden in CDPROFILE but shows in CDCALC. Its "Export to Drawing" button writes a section with none of CDPROFILE's checks:
   - a blank cover or invert is drawn as RL 0.00;
   - the path can run up one branch and down another, against the flow;
   - its default vertical scale is 1:50, where CDPROFILE's is 1:10.
4. **A datum typed above the lowest pipe is accepted.** Type 20.00 when the lowest invert is 18.50: the pipe and pit sumps are drawn 1.5 m below the datum line, through the table text. CE still says Ready.
5. **A level pipe stops the whole long section.** A pipe with zero fall and no grade label (detention storage pipes are often laid flat) gets no grade. The whole route then stays "Unknown" and can never be drawn.
6. **An uphill pipe is shown as a normal falling pipe.** A pipe rising 200 mm over 20 m prints "1 in 100", 1.37 m/s and 96.7 L/s, with no warning.
7. **An invert above the cover is hidden.** Cover 10.00 with invert 10.20: the review shows depth 0.00 and Ready, while the drawn INVERT DEPTH row prints -0.20. The two disagree, and nothing flags the level error.
8. **Each row in the CDPROFILE review grid mixes two pipes.** At a middle pit, the size and speed belong to the pipe leaving the pit, but the grade belongs to the pipe arriving. The speed shown does not match the grade beside it.
9. **CDRG: pressing Enter to finish the raingarden outline probably throws the whole outline away.** Enter is the normal AutoCAD way to finish, and CDSPOONDRAIN accepts it. In CDRG it appears to read as Escape: "CDRG command cancelled", nothing drawn.
10. **Boundary marks on the long section sit in the wrong place on bent pipes.** CE finds where the boundary crosses a straight line from pit centre to pit centre, not the real bent pipe. A boundary crossing the real pipe can be missed, or a crossing shown that the pipe never makes.

**Area J (overland flow) has no code yet.** Its UX items (UX-OLF-01 to 04) are "Not built"; the only freeboard code belongs to detention and pumps (areas F and H). There was nothing to hunt.

---

## Findings in full

Each finding says where it is, how to trigger it, what is wrong, severity (HIGH = wrong output on a drawing, data loss, crash or refuses real work), confidence, a one-line fix idea, and whether a unit test can show it RED. Line numbers are on `rel-20261018d`. All paths are under `Modules/Drainage/`.

### Area K — long sections and profiles (CDPROFILE and the CDCALC older tab)

#### IJK-01 (HIGH, CONFIRMED) — each pipe's top line is drawn at the larger of its own size and the next pipe's

1. **Where:** `Services/LongitudinalSectionService.cs:1385`: `double crownOffset = Math.Max(start.DiameterMm, end.DiameterMm) * ...`.
   - Each pit row's `DiameterMm` is the size of the pipe *leaving* that pit: `Services/ProfileRouteReviewService.cs:389-391`, `index < pipes.Count ? diameters[index] : diameters[index - 1]`.
   - The older tab does the same: `ViewModels/LongitudinalSectionViewModel.cs:412`.
   - So for the pipe from pit i to pit i+1, `end.DiameterMm` is the size of the pipe after it.
2. **Trigger:** CDPROFILE on P1 → P2 → P3, with P1-P2 at 225 dia and P2-P3 at 375 dia. Preview, then Apply.
3. **Wrong vs right:**
   - **Wrong:** P1-P2's top (obvert) line is drawn 375 mm above its invert.
   - **Right:** 225 mm above its invert.
   - Every pipe before a size increase is drawn one size too big, which also makes the cover over it look smaller than it is. The PIPE SIZE row still says 225, so the drawing contradicts itself.
4. **Fix idea:** use `start.OutgoingDiameterMm` (this pipe's own size) for segment i.
5. **RED test:** not directly, because `AddPipeProfile` is private and draws in AutoCAD. Move the choice into a pure helper `CrownDiameterForSegment(start, end)` and test 225 → 375.

#### IJK-02 (HIGH, CONFIRMED) — a TG "0.000" placeholder cover is read as a real RL 0.00

1. **Where:** `Services/ProfileRouteReviewService.cs:381`: `ParseStoredPositiveOrFinite(pit.CoverLevel, false, ...)` reads the stored text straight.
   - It skips `PitData.KnownCoverLevelRl()` (`Models/PitData.cs:72-82`), the BUG-432 rule that treats a skipped TG cover "0.000" as not known. Nineteen other places already use that rule.
2. **Trigger:** a route through a trench grate placed by an older CDTG where Enter was pressed at the cover prompt (stored CoverLevel "0.000"). Run CDPROFILE on that route.
3. **Wrong vs right:**
   - **Wrong:** with invert 18.20, SURFACE LEVEL prints 0.00 and the surface line drops to RL 0, below the datum and into the table. Depth is clamped to 0.00 and the status can be Ready.
   - **Right:** cover Unknown, status Unknown, nothing drawn until the cover is set.
4. **Fix idea:** read cover through `KnownCoverLevelRl()`.
5. **RED test:** yes. `ProfileRouteReviewService.Prepare` with a TG pit whose CoverLevel is "0.000"; expect `Nodes[i].CoverLevel.IsKnown == false`.

#### IJK-03 (HIGH, CONFIRMED) — CDCALC's "Older longitudinal" tab still writes long sections, with none of CDPROFILE's checks

1. **Where:** `Dialogs/CalculationsV2Dialog.xaml:278` (the tab) and `:318-319` (the "Export to Drawing" and "Update Existing" buttons).
   - `CalculationsV2Dialog.xaml.cs:93` hides the tab only in the CDPROFILE constructor. The CDCALC constructor (`:40-73`, opened by `Commands/CalculationsCommand.cs:58`) leaves it showing.
   - The buttons call `LongitudinalSectionService.InsertSection` and `UpdateExistingSection` (`Services/LongitudinalSectionService.cs:378, 425`). Neither runs `LongitudinalSectionGeometryAuthorityPolicy.TryAdmit`, the check the reviewed CDPROFILE path relies on.
2. **What goes wrong through this tab:**
   - **Blank levels become RL 0.00.** A pit with a blank cover, or a pipe with a blank invert, is read as 0.0 (`LongitudinalSectionViewModel.cs:1714-1721`, `ParseDouble` returns 0.0). The automatic datum then becomes -0.50 (`:542-557`). At V 1:50 a 19 m surface sits 19.5 × 2000 = about 39,000 drawing units above the table: a section many metres tall, drawn without a warning.
   - **The path can run against the flow.** The route search is undirected (`FindShortestPath`, `:1778-1882`, adds every pipe both ways). Start at one branch head and end at another: the section runs up one branch and down the other, with rising inverts, and is drawn without a warning.
   - **The default scales differ.** This tab defaults to V 1:50 and H 1:100 (`:63-66`). CDPROFILE defaults to V 1:10 and H 1:100 (`ProfileRouteReviewViewModel.cs:77-78`). Design rule #1 says one code path per behaviour.
   - **Lengths can be dummies.** A missing pipe falls back to 0.01 m (`:1913`).
3. **Trigger:** CDCALC → Older longitudinal → choose a start and end where one pit has a blank cover → Export to Drawing.
4. **Wrong vs right:**
   - **Wrong:** the section is drawn with the surface at RL 0.
   - **Right:** refused, or Unknown, as CDPROFILE does.
5. **Fix idea:** in CDCALC, hide the tab the same way CDPROFILE does, sending the drafter to CDPROFILE. At minimum, run `TryAdmit` inside `InsertSection` and `UpdateExistingSection`. Hide it, do not delete it (the standing no-retirement rule; Tim's PR #187 decision 1).
6. **RED test:** yes. Call `LongitudinalSectionGeometryAuthorityPolicy.TryAdmit` on the nodes the older tab builds with a 0.0 cover: it passes today, because 0.0 is a finite number. Add a source guard test that `InsertSection` calls `TryAdmit`.

#### IJK-04 (MEDIUM-HIGH, CONFIRMED) — nothing checks that the datum is below the lowest invert and sump

1. **Where:** `Services/ProfileRouteReviewService.cs:61-67` checks only that the datum is a finite number to 0.01 m. `LongitudinalSectionService.cs:190-200` checks the same.
   - The review starts the datum box blank (`ProfileRouteReviewViewModel.cs:76`) and suggests nothing.
2. **Trigger:** CDPROFILE, lowest invert 18.50, type datum 20.00 (or 118.00 by a slip), Preview, Apply.
3. **Wrong vs right:**
   - **Wrong:** Ready. With datum 20.00 the pipe and the 0.30 m sump are drawn 1.5 m × the vertical factor below the datum line, through the table rows and their text. With 118.00 the whole section lands about 1 km of drawing units below the table.
   - **Right:** refused, with a message such as "Datum must be at or below 18.20 (lowest invert less the sump)". Even better, offer the rounded-down value the old generator already computes (`LongSectionGenerator.RoundDownDatum`).
4. **Fix idea:** add a refusal in `Prepare` when datum > lowest invert − 0.30.
5. **RED test:** yes. `ProfileRouteReviewService.Prepare` with datum above an invert; expect Refused.

#### IJK-05 (MEDIUM, CONFIRMED) — a level pipe with no grade label stops the whole long section

1. **Where:**
   - The grade is the plan label, then XData, then the custom grade, then fall over length (`Services/ProfileRouteEvidenceCaptureService.cs:590-614`).
   - For a zero fall, `MathHelper.ActualGradeDenominator` returns 0 (`Helpers/MathHelper.cs:58-59`), so the grade stays Unknown.
   - Every pipe on the route must have a known grade (`ProfileRouteReviewService.cs:446-450`).
   - Apply needs Ready (`LongitudinalSectionService.cs:889`), and `TryAdmit` refuses a grade or velocity of 0 (`:224-231`).
2. **Trigger:** a route that includes a pipe with equal upstream and downstream inverts and no "1 IN N" label. For example, a detention storage pipe laid flat, or a charged line.
3. **Wrong vs right:**
   - **Wrong:** the status stays Unknown ("pipe grade") forever and the section cannot be drawn.
   - **Right:** draw it, with PIPE GRADE "LEVEL" (or "0%") and the speed and full-bore flow rows blank.
4. **Fix idea:** a zero fall is a known grade of "level", not Unknown. Let the writer accept velocity 0 when the grade is level.
5. **RED test:** yes. `ProfileRouteEvidenceCaptureService.ComputeEstablishedGrade(20, 10.00, 10.00)` returns 0, and a `Prepare` test with that pipe expects Ready.

#### IJK-06 (MEDIUM, CONFIRMED) — an uphill pipe is printed as a normal falling grade with a velocity

1. **Where:** `Services/ProfileRouteEvidenceCaptureService.cs:719-722` and `Helpers/MathHelper.cs:57` (`Math.Abs(fallMetres)`).
2. **Trigger:** a route pipe with no label grade, length 20 m, From IL 10.00, To IL 10.20. Routes always run From → To, so this pipe rises along the flow.
3. **Wrong vs right:**
   - **Wrong:** a 300 RCP prints "1 in 100", 1.37 m/s and 96.7 L/s.
   - **Right:** flagged "ADVERSE" (or Unknown), with no velocity.
   - The drawn invert line does visibly rise, but the table says the opposite.
4. **Fix idea:** in the long-section grade, return Unknown (or an adverse flag) when the To invert is at or above the From invert.
5. **RED test:** yes. `ComputeEstablishedGrade(20, 10.00, 10.20)` returns 100 today; expect 0 or an adverse result.

#### IJK-07 (MEDIUM, CONFIRMED) — an invert above the cover is hidden as depth 0.00, and the review and the drawing disagree

1. **Where:** `Services/ProfileRouteReviewService.cs:413-416`, `Math.Max(0.0, cover - controlling)`. The drawn INVERT DEPTH row computes its own value without the clamp: `LongitudinalSectionRows.InvertDepthText` (`Services/LongitudinalSectionRows.cs:75-80`).
2. **Trigger:** cover 10.00, lowest invert 10.20 (a typed or imported level error).
3. **Wrong vs right:**
   - **Wrong:** the review shows depth 0.00 and Ready; the drawing prints -0.20.
   - **Right:** an Unknown reason, "invert is above the cover at P3", before Apply.
4. **Fix idea:** a negative depth adds an Unknown reason instead of being clamped.
5. **RED test:** yes. `ProfileRouteReviewService.Prepare`; expect not Ready.

#### IJK-08 (MEDIUM, CONFIRMED) — each row of the CDPROFILE review grid shows two different pipes

1. **Where:** `ViewModels/ProfileRouteReviewViewModel.cs:44-51` shows `DiameterMm`, `GradeOneIn` and `VelocityMs`.
   - At a middle pit, the diameter and velocity are the outgoing pipe's (`ProfileRouteReviewService.cs:389-391, 431`), but the grade is the incoming pipe's (`:392-394`, `grades[index - 1]`).
2. **Trigger:** A → B → C, with A-B at 300 dia 1 in 100 and B-C at 375 dia 1 in 200.
3. **Wrong vs right:**
   - **Wrong:** row B reads 375 / "1 in 100.0" / B-C's velocity, which was worked out at 1 in 200.
   - **Right:** all three figures from B-C, the pipe leaving B.
   - The drawn table is correct; only the review grid is mixed, but that grid is what the drafter checks before pressing Apply.
4. **Fix idea:** bind the grid to `OutgoingDiameterMm`, `OutgoingGradeOneIn` and `VelocityMs`.
5. **RED test:** yes. `Prepare` with two grades; assert that the grade shown equals `OutgoingGradeOneIn`.

#### IJK-09 (MEDIUM, CONFIRMED by reading; the effect needs AutoCAD) — boundary marks are found on the straight line between pit centres, not on the real pipe

1. **Where:** `ViewModels/LongitudinalSectionViewModel.cs:1296-1336`.
   - `ProjectBoundaryMarkers` intersects the boundary with the straight line between the two pit centres.
   - It then shares out chainage in proportion to the curve length.
2. **Trigger:** a pipe with a bend (a polyline with a middle vertex, or an arc) where the title boundary crosses the bent part.
3. **Wrong vs right:**
   - **Wrong:** the boundary mark sits at the wrong chainage, is missing, or appears where the real pipe never crosses.
   - **Right:** intersect the boundary with the pipe's own centreline.
4. **Fix idea:** intersect with the pipe's own curve and use the curve's distance at that point.
5. **RED test:** partly. The geometry is pure maths on `Point2d`. A chord-versus-polyline case can go RED once the projection is moved behind a pure helper.

#### IJK-10 (LOW-MEDIUM, CONFIRMED) — the end-of-route boundary chainage uses straight-line distance, not distance along the pipe

1. **Where:** `ViewModels/LongitudinalSectionViewModel.cs:1338-1390`.
   - `AddEndpointBoundaryProjection` takes the closest distance from the pit centre to the boundary and subtracts half the pit width.
   - It does not measure along the pipe's direction.
2. **Trigger:** the existing pipe leaves the end pit at 45° to a boundary 1.0 m away.
3. **Wrong vs right:**
   - **Wrong:** the mark is placed 1.0 m (less half the pit) from the pit.
   - **Right:** about 1.41 m along the pipe.
4. **Fix idea:** measure along the outward direction (divide by the cosine of the angle), or reuse the existing-pipe intersection at `:1010-1073`.
5. **RED test:** yes, once the method is reachable (it is private static and takes only `Point2d` values).

#### IJK-11 (LOW-MEDIUM, PLAUSIBLE) — any plain number in an Xref can become a surface level on the long section

1. **Where:** `ViewModels/LongitudinalSectionViewModel.cs:1230-1272` and `:1568-1641`.
   - Any DBText or MText inside an Xref whose whole text is a number like "18.45" (on any layer) is a survey spot.
   - It is used when within 2.5 to 12 m and within 0.6 to 1.2 m of the cover interpolated between pits.
2. **Trigger:** a survey Xref that writes pit inverts or kerb inverts as bare numbers next to the run.
3. **Wrong vs right:**
   - **Wrong:** an invert of 18.60 between covers of 19.20 is taken as natural surface, and the existing-surface line dips 0.6 m.
   - **Right:** only level texts on survey layers, or the CDSURVEY points, count.
4. **Fix idea:** restrict to recognised survey layers, or to the points CDSURVEY already understands.
5. **RED test:** yes. `TryEstimateSurveyLevel` and `TryParseSurveyLevel` are pure.

#### IJK-12 (LOW, CONFIRMED) — CDPROFILE never draws branch junction marks

1. **Where:** `Services/LongitudinalSectionService.cs:1045-1058`. `TryProjectReviewedSection` never sets `JunctionMarkers`, so `AddJunctionMarkers` (`:1419`) draws nothing.
   - The CD-BRANCH-01 part 2 log already says "a section refreshed through the reviewed-route path does not add them yet".
   - The older tab, which does draw junction marks, is hidden when the window is opened by CDPROFILE.
2. **Effect:** Tim's CD-BRANCH-01 check step 1 ("a tick with 100 DIA. BRANCH stands at 6.4 m") can only pass through CDCALC's older tab (IJK-03).
3. **Fix idea:** project the junction facts in the reviewed path.
4. **RED test:** yes, as a source guard test.

#### IJK-13 (LOW, CONFIRMED) — the existing-pipe stub at each end is drawn through the table frame

1. **Where:** `Services/LongitudinalSectionService.cs:1494-1515`. The 1.2 m stub is drawn left of the first pit and right of the last pit.
   - When no surface sample or boundary lies beyond the pit, the profile frame stops at the pit (`ResolveMinimumDisplayedChainage`, `:1672-1700`).
   - So the stub crosses the frame line into the header column on the left, and runs past the frame on the right.
2. **Fix idea:** widen the displayed chainage by the stub length when an existing pipe is drawn.
3. **RED test:** yes, after moving the displayed-chainage rule into a pure helper.

#### IJK-14 (LOW, CONFIRMED) — any pit width counts as at least 1800 mm in the profile evidence

1. **Where:** `Services/ProfileRouteReviewService.cs:843-844` adds `SpsRadius × 2`. `Models/PitData.cs:49` gives every pit `SpsRadius = 900` by default.
2. **Effect:** a 600 × 600 pit records 1800 mm. Today this is only checked and fingerprinted.
   - The boundary rule in IJK-09 uses half the pit width, so a boundary within 0.9 m of a small pit's centre is dropped.
3. **Fix idea:** count `SpsRadius` only on pump-station pits.

#### IJK-15 (LOW, CONFIRMED) — the schedule set starts on the drawing's first set, not the route's own set

1. **Where:** `Services/ProfileRouteEvidenceCaptureService.cs:45-54` and `ViewModels/ProfileRouteReviewViewModel.cs:229`.
2. **Trigger:** a drawing with sets "A" and "Main", where the route is in "Main".
3. **Effect:** the first Preview is refused ("Every route pit must belong to the exact reviewed schedule set") until the drafter changes the set by hand.
4. **Fix idea:** default to the set shared by the route's pits.

#### IJK-16 (LOW, CONFIRMED, latent) — the auto-design long section would put design flow in the "pipe flowing full" row

1. **Where:** `Services/LongSectionBridge.cs:99`, `row.FullFlowLs = outSeg.CumulativeFlowLps`.
2. **Effect:** a 300 at 1 in 100 would show 40 L/s (design flow) instead of 96.7 L/s (full-bore capacity).
   - Nothing outside tests draws `DesignPackage.LongSectionRows` today.
   - `LongSectionGenerator.cs:194-200` also turns a missing cover or invert into 0.0 on the same path.
3. **RED test:** yes. `LongSectionBridge.ToNodeRows`.

### Area I — WSUD and treatment (CDRG raingarden, the CDCALC WSUD tab)

#### IJK-17 (MEDIUM, PLAUSIBLE, strong) — CDRG: Enter while drawing the outline cancels the command and loses every point

1. **Where:** `Commands/SourceBlockInsertCommands.cs:915-934`.
   - The jig accepts Enter (`NullResponseAccepted`), then turns anything that is not a point into `SamplerStatus.Cancel`.
   - The loop at `:455-459` reads "cancelled, no keyword" as Escape.
2. **Trigger:** CDRG, pick four corners, press Enter or right-click to finish (normal AutoCAD habit; CDSPOONDRAIN finishes this way).
3. **Wrong vs right:**
   - **Wrong:** "CDRG command cancelled." Nothing is drawn.
   - **Right:** with 3 or more points, Enter closes the outline; with fewer, CE asks for more.
4. **Fix idea:** record that Enter was pressed (for example `jig.FinishedByEnter`) and treat it as Close when there are 3 or more points.
5. **RED test:** no; it needs AutoCAD. Add it to Codex's CDRG run.

#### IJK-18 (MEDIUM, CONFIRMED behaviour; whether it is right is Tim's engineering call) — WSUD tab chains every ticked measure in series over the whole site

1. **Where:** `ViewModels/WsudViewModel.cs:178-189`, `remTss *= 1 − reduction`, with no treated area or treated fraction.
   - The annual runoff worked out at `:163-174` never feeds the pollutant result.
2. **Trigger:** tick Rainwater Tank + GPT + Swale.
3. **Wrong vs right:**
   - **Wrong:** TSS 1 − 0.6 × 0.6 × 0.3 = 89.2%, PASS against 80%.
   - **Right:** a tank treats roof water only. If the swale alone treats the whole site, the result is 70%, a FAIL.
4. **Context:** DFGH-45 records this tab as read-only, for older drafts only. The risk is an old draft, or the export, showing a PASS that MUSIC would not give.
5. **Fix idea:** at minimum, label the result "indicative, not a MUSIC result". Better, a treated-fraction input per measure.
6. **RED test:** only once the intended rule is decided.

#### IJK-19 (LOW-MEDIUM, CONFIRMED) — WSUD accepts impervious area larger than the site, and negative areas

1. **Where:** `ViewModels/WsudViewModel.cs:164-169`. Pervious area is clamped at 0, but the full impervious figure is used. `ParseD` uses `NumberStyles.Any`, which accepts "-200".
2. **Trigger:** site 1000 m², post-development impervious 1200 m² (a typo), rainfall 630 mm, C 0.85.
3. **Wrong vs right:**
   - **Wrong:** 642.6 m³ a year.
   - **Right:** the maximum possible is 535.5 m³; better, refuse the input.
4. **RED test:** yes, on `WsudViewModel`.

#### IJK-20 (LOW-MEDIUM, PLAUSIBLE) — CDRG can refuse a good raingarden on the 2024/net48 lane by comparing saved numbers exactly

1. **Where:** `Services/RaingardenPlacementPlan.cs:195-198` (`actual.AreaSqM != expected.AreaSqM`, exact position compare) and `Services/SourcePlacementService.cs:785` (compares JSON text).
2. **Mechanism:** the area and centroid are full-precision results that go through JSON. On 64-bit .NET Framework, the "R" number format is documented as not always reproducing the exact value.
3. **Effect:** a rare "The saved raingarden project record changed after preparation", with nothing placed.
4. **Fix idea:** round the area and position (for example to 1e-6) before saving, or compare with a tolerance.
5. **RED test:** only on net48 x64.

#### IJK-21 (LOW, CONFIRMED) — the raingarden "centroid" is the average of the corners, not the centre of the area

1. **Where:** `Services/RaingardenPlacementPlan.cs:133`.
2. **Example:** a 10 × 10 m square drawn with many points down one edge stores its position about 3 m off centre. A doubled click counts twice.
3. **Effect:** only the stored position used to find nearby items. Low impact.
4. **RED test:** yes, on `RaingardenPlacementPlan.TryCreate`.

#### IJK-22 (LOW, CONFIRMED) — CDRG: Undo at the second point cancels the whole command

1. **Where:** `Commands/SourceBlockInsertCommands.cs:480-484`. AutoCAD's own PLINE undoes the point and carries on.

### Areas I and J edge — surface drains and crossings

#### IJK-23 (MEDIUM, CONFIRMED) — CDSPOONDRAIN: one repeated pick throws the whole run away at the end

1. **Where:** `Commands/SpoonDrainCommand.cs:85-90` keeps a pick identical to the last one. `Rules/SpoonDrainRunPlan.cs:88-91` then refuses the run: "Every spoon drain point must be different from the last."
2. **Trigger:** pick A, B, then B again (a double-click or snap), then C, then Enter.
3. **Wrong vs right:**
   - **Wrong:** the running length stops printing. After the fall and outlet prompts it says "Spoon drain not placed", and every pick is lost.
   - **Right:** ignore the repeated pick when it is made, and say so.
4. **RED test:** yes. `SpoonDrainRunPlan.TryCreate` with (0,0), (10,0), (10,0), (20,0).

#### IJK-24 (MEDIUM in metre drawings only, CONFIRMED) — CDSPOONDRAIN reads every drawing as millimetres

1. **Where:** `Rules/SpoonDrainRunPlan.cs:87, 93, 100`. The command passes raw drawing coordinates and never reads INSUNITS.
2. **Trigger:** a UNITS = Metres drawing. Pick (0,0) then (25,0), fall 100 mm.
3. **Wrong vs right:**
   - **Wrong:** "0.03 m, 1:0", and LengthM 0.025 is saved.
   - **Right:** 25.00 m at 1:250.
4. **Context:** this is the same family as BUG-331 and BUG-338, but CDSPOONDRAIN is not on either list. Office drawings seen so far are millimetre (BUG-331 notes), so the real risk depends on Tim's BUG-287 answer.
5. **RED test:** yes, once a units input is added to `TryCreate`.

#### IJK-25 (MEDIUM, CONFIRMED, latent: no caller yet) — the services-crossing check measures clearance to the inside of the pipe and gives the service no size

1. **Where:** `Rules/CrossingServiceRule.cs:121-124`: top = invert + DN/1000; clearance is measured to the invert or that top.
2. **Example:** pipe invert 10.000, DN375 (wall about 42 mm), service at 9.700, minimum 300 mm.
   - **Wrong:** clearance 0.30 m, "Clear".
   - **Right:** about 0.258 m to the outside of the pipe, so under the minimum. The service's own diameter is also ignored. The error is always on the unsafe side.
3. **Fix idea:** subtract the wall thickness and the service size before card 6.8 wires this in. Otherwise word the result "to inside of pipe".
4. **RED test:** yes. `Evaluate("WATER", 9.70, 10.00, 375, 300)`; expect UnderMinimum.

#### IJK-26 (LOW, CONFIRMED) — the crossing-split message names pits that were not split

1. **Where:** `Services/PipeCrossingSplitService.cs:71` passes all crossings to `PipeCrossingSplitPolicy.BuildDoneMessage` (`Rules/PipeCrossingSplitPolicy.cs:84-90`).
2. **Example:** crossings at A2 and A3, with A3 refused. The message says "Split into 2 pipes at A2 and A3", then "not split at A3".
3. **RED test:** yes, on `BuildDoneMessage`.

#### IJK-27 (LOW, CONFIRMED, latent) — two problems in `CrossingServiceRule` for card 6.8

1. **Units:** `CrossingChainages` says metres but returns drawing units (`Rules/CrossingServiceRule.cs:100`): 12,500 "m" in a millimetre drawing.
2. **Layer names:** the layer match is a plain substring (`:69`), so "EX-WASTEWATER" is labelled "EX. WATER MAIN".
3. **RED test:** both can go RED today.

### Outside I, J and K, found on the way (for the controller to place)

#### IJK-X1 (MEDIUM, CONFIRMED) — CDTWL's suggested default is "highest invert + its pipe", not the highest obvert

1. **Where:** `Rules/TopWaterLevelCandidates.cs:73-84`. It picks the highest invert, then adds the widest pipe at that invert.
2. **Example:** 225 at IL 10.000 and 375 at IL 9.990.
   - **Offered:** 10.225.
   - **Rulebook default:** 10.365 ("obvert of the highest detention pipe", section C7).
3. **Context:** under TWL-01 the drafter must still choose a level, so this is the default CE names, not a silent value.
4. **RED test:** yes, on `RulebookDefault`.

#### IJK-X2 (LOW, CONFIRMED) — pump notes print "1%%-term" literally

1. **Where:** `Services/PumpSizingService.cs:278`. It should read "1%-term".

---

## What was NOT checked

1. **Nothing was run.** No build, no tests, no AutoCAD. Every finding is from reading code; IJK-17, IJK-20 and IJK-11 need AutoCAD or net48 to prove.
2. **Area J (overland flow) has no code** to audit (UX-OLF-01 to 04 are "Not built").
3. **Not traced in depth:**
   - CDRG's commit and rollback inside `SourcePlacementService`;
   - `TryAutoSplitNearestPipeAtOwner` and how inverts carry across a crossing split;
   - the WSUD export and its XAML;
   - `LongitudinalSectionTitleLayout` beyond BUG-600;
   - `PipeSystems` system inheritance;
   - the update and preflight path of the linked-section writer (`TryPreflightLinkedSectionWrite`, `:2255-2505`) beyond its use of the protections.
4. **Structural was not in scope** and was not read.
5. **Council WSUD targets** were not checked against council documents.

---

## Summary

Read-only audit of Civil 3.0.55 (`origin/claude/rel-20261018d` at `70a4e24f`) for WSUD, overland flow, long sections and crossings: 27 findings in scope plus 2 found outside it, none already in the carpark.

The worst are on the long section:

1. **The pipe size it draws** (every pipe before a size increase is drawn one size too big).
2. **A trench grate placeholder cover drawn at RL 0.**
3. **A second, unchecked long-section writer** still live in CDCALC's "Older longitudinal" tab.
4. **A datum above the pipes accepted** without a warning.

Next come four review gaps: a level pipe blocks the section, an uphill pipe shows a normal grade, an invert above the cover is hidden as depth 0, and the review grid mixes two pipes. Smaller items cover CDRG (Enter cancels the outline), the WSUD tab's series credit, CDSPOONDRAIN repeated points and metre drawings, and the not-yet-wired crossing clearance rule (which measures to the inside of the pipe). Overland flow has no code yet. Most findings can be shown RED with a pure unit test. The crown-size bug, IJK-17 and the boundary-on-chord bug need a small pure helper or an AutoCAD run first. Nothing here has been seen in AutoCAD, and no BUG numbers were filed; that is the controller's job.
