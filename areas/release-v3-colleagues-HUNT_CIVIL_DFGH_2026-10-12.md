# HUNT — Civil areas D, F, G, H: catchments, CDCALC, detention, water tanks, pump stations

**Read-only code audit, 18 Oct 2026 (Melbourne).** Desk plan/03 headless job. File name keeps the dispatcher's date (12 Oct).
**Lineage audited:** installed Civil lineage, `origin/claude/rel-20261018c` @ `def8e56f` = **Civil 3.0.54 / Manager 1.1.54**.
Private worktree `C:\ce-hunt\dfgh`, removed at the end. Not master. Structural not in scope.
**Nothing was built, run, edited or opened in AutoCAD.** Every finding is "found by reading the code", not "seen on a drawing".
**No BUG numbers filed** — the controller does that. Finding IDs below are local to this file (DFGH-xx).

**Known bugs excluded.** Checked against `BUG_CARPARK.md` (137 entries that touch these areas, to BUG-747), `HUNT_CIVIL`,
`HUNT2_CIVIL`, `HUNT3_CROSS`, `HUNT_CIVIL_B`, `HUNT_CIVIL_E`, `R00_CIVIL` and `AUDIT_01`. Hard-coded numbers already
catalogued by R00 are not repeated. Where a finding sits next to a known one, it says so.

---

## FOR TIM — the 10 worst, in plain English

1. **A tank placed through the CDWT window is never counted as storage.** The window forgets which tank you picked, so
   the drawing record has no height. CDTWL then leaves the tank out: a 5000 L tank with 2000 L detention counts 0 L.
   This hits every tank placed through the window on 2027. (DFGH-01)
2. **The computations sheet prints the wrong head on the orifice.** CDCALC sizes the orifice with head = plate height −
   half the hole (CE's rule), but the sheet, the export and the OSD block print the plate height as the "head".
   A council checker working from the printed 0.500 m gets 5.14 L/s against a 5.00 L/s PSD and rejects it. (DFGH-02)
3. **CDCALC counts every detention pipe as brim-full, whatever the top water level.** A 375 pipe 20 m long with TWL only
   200 mm above its invert shows 2.21 m³; the real figure is about 1.56 m³. That can turn "Shortfall" into "Surplus" on
   the issued OSD block. (DFGH-03)
4. **A blank pipe level is read as RL 0.000.** Pit storage is then measured from sea level (a 600 x 600 pit shows 3.68 m³
   instead of 0.08), and if it is the orifice pit the baffle becomes about 10 m and the orifice shrinks to 27 mm. (DFGH-04)
5. **CDTWL counts the tank a second time as a fake 450 x 450 pit.** Any tank piped into the detention branch adds a
   phantom "pit WT1" of about 200 L per metre of depth. (DFGH-05)
6. **CDDESIGN cannot size detention at all for the eight councils that give you the PSD** (Kingston, Bayside, Monash,
   Boroondara and others). It says "enter the council's figure", but there is no box to type it in. (DFGH-06)
7. **CDEDIT on a rising main wipes where it discharges to.** After one OK with no changes, CDRULES and the network check
   treat the rising main as a gravity pipe running uphill and raise errors. Point Order mode does this even without
   CDEDIT. (DFGH-07, DFGH-08)
8. **CDTWL counts the detention pit's solid outlet chamber and dividing wall as storage.** A 450 + 450 detention pit is
   counted at about 0.47 m² instead of 0.20 m²; CDCALC counts the same pit correctly, so the two disagree. (DFGH-09)
9. **CDCALC's detention total never reads the tanks.** The plan says 2.00 m³ of tank detention; CDCALC's "Add" button
   starts a made-up WT row of 1000 L that counts straight away and goes onto the OSD block. Your T-02 rule says this
   must be impossible. (DFGH-10)
10. **CDCALC Pipe Flows keeps the first pipe's grade and roughness when you pick a second pipe.** Pick a uPVC pipe at
    1 in 150, then a concrete one at 1 in 60: it still says 1 in 150 and n 0.010, so Q reads 18% low, and that goes
    onto the export. (DFGH-11)

**What I recommend first:** DFGH-01, 05 and 10 together (one tank fix makes plan, CDTWL and CDCALC agree), then DFGH-02,
03 and 04 (the detention tab's numbers on the issued sheet). All six can be shown failing in a unit test before fixing.

**Severity count:** 11 HIGH, 21 MEDIUM (two of them MEDIUM-HIGH), 15 LOW across 47 findings. 41 CONFIRMED by reading the full code path, 6 PLAUSIBLE.

---

## A. Water tanks (CDWT) — area G

### DFGH-01 (HIGH, CONFIRMED) — CDWT window drops the library tank, so the tank has no size and CDTWL counts 0 L
- **Where:** `Modules/Drainage/Commands/WaterTankCommand.cs:80` (`libraryChoice = null`), `:93` and `:553-606`
  (`TryChooseTankInWindow` hands back litres, detention and plan block, never the tank), passed on at `:157`.
  `Dialogs/WaterTankDialog.xaml.cs:70-76` exposes no chosen tank. Effect: `Commands/WaterTankCommand.Apply.cs:336-357`
  (`BuildTankFacts` with a null library leaves Length/Width/Height null) and `Rules/WaterTankFacts.cs:100-104`.
- **Steps:** AutoCAD 2027, CDWT. Pick "5000 L Round" (1900 x 1900 x 2000), detention 2000, Place tank, pick point and
  callout, Base RL 20.00. Run CDTWL on the downstream detention pit.
- **Wrong:** "WT1 has no rated capacity or no height recorded"; tank counted 0 L. Make-and-size callout line never
  appears. Adopt (tag existing block) loses it the same way.
- **Right:** area = 5000 L ÷ 2.0 m = 2.5 m², orifice 21.20, top 22.00, 2000 L counted once TWL reaches 22.00.
- **Fix:** expose the chosen `TankLibraryEntry` on the window and pass it out of `TryChooseTankInWindow` into `BuildAndApply`.
- **Unit test RED:** not cleanly (window-to-command hand-off). A source-contract test on `TryChooseTankInWindow`, or
  extract the hand-off into a pure record.

### DFGH-05 (HIGH, CONFIRMED) — CDTWL counts the tank again as a phantom 450 x 450 pit
- **Where:** `Rules/DetentionBranchCollector.cs:110-118` (every branch id with a PitData record goes to `BuildPit`,
  including WT records); `:175-204`; tank records keep `PitData` defaults `XWidth = YWidth = 450` (`Models/PitData.cs:25,28`)
  and their `BaseRl` becomes the invert (`:258-265`). CDTWL passes `project.Pits` unfiltered
  (`Services/DetentionTwlService.cs:140-155`).
- **Steps:** WT1 Base RL 20.00, pipe WT1 → P2 → detention pit, CDTWL, TWL 21.00.
- **Wrong:** extra "pit WT1" 0.45 × 0.45 × 1.00 = 202.5 L, on top of the tank item (or alone, when DFGH-01 left the tank out).
- **Right:** WT1 appears only as a tank.
- **Fix:** skip `WaterTankFacts.IsTank` records in the pit loop; keep them for the upstream walk.
- **Unit test RED:** yes — `DetentionBranchCollector.Collect` with a WT record (Base RL 20, default widths) returns a Pit item "pit WT1".

### DFGH-10 (HIGH under T-02, CONFIRMED; phantom pit row PLAUSIBLE) — CDCALC detention never reads tank litres; "Add" invents a 1000 L WT row
- **Where:** `ViewModels/DetentionSystemViewModel.cs:162-165` (total = pipes + pits + hand-typed extras),
  `Dialogs/CalculationsV2Dialog.xaml.cs:215` (Add creates "WT{n+1}, 1000 L" that counts at once),
  `Rules/CriteriaBlockRows.cs:63-66` (extras go onto the OSD block). Phantom pit row: `PopulateFromSeeds` `:625-654`
  turns a detention pipe ending at WT1 into a ticked 450 x 450 pit row.
- **Steps:** CDWT WT1 5000 L with 2000 L detention (callout "2000 lt FOR DETENTION"). CDCALC > Detention > Add extra.
- **Wrong:** WT1 = 1.00 m³ on the OSD block; plan says 2.00 m³. Nobody typed 1000.
- **Right:** extras come from the WT records (tag and detention litres); a WT record is never a pit row; Add starts blank/Unknown.
- **Fix:** seed extras from WT records; skip WT in pit seeding; Add starts Unknown.
- **Unit test RED:** yes — `DetentionSystemViewModel.PopulateFromSeeds` with seed From = "WT1" plus a WT record gives `Pits` containing WT1.

### DFGH-12 (MEDIUM, CONFIRMED) — Esc at the callout, riser or dropper prompt still places the tank
- **Where:** `Commands/WaterTankCommand.cs:682-694` (any non-OK status treated as Enter), used `:222, 231-232` and
  `Commands/WaterTankCommand.Window.cs:417-420`. Detention prompt: Esc becomes 0 (`:516-517`) or the library default (`:498-500`).
- **Steps:** CDWT, pick the insertion point, Esc at "Specify callout text location", Esc at riser and dropper.
- **Wrong:** "Water tank placed. Tag: WT1 … Callout: skipped". The class promises Cancel/Escape leaves nothing.
- **Right:** Esc cancels and nothing is drawn; only Enter skips.
- **Fix:** distinguish `PromptStatus.Cancel` from `None`.
- **Unit test:** no; manual AutoCAD check.

### DFGH-13 (MEDIUM-HIGH, CONFIRMED) — typed "1,000" or "5kL" reads as 0 in the tank window
- **Where:** `Dialogs/WaterTankDialog.xaml.cs:436-440` (`Number()` rejects commas and units), summary at `:233-236`.
- **Steps:** detention "1,000" on a 5000 L tank; or total "5,000" / "5kL".
- **Wrong:** detention 0 → tank recorded all re-use ("5000 lt TO BE USED FOR TOILET FLUSHING…"). Total → Place stays off,
  while the box above says "Selected capacity: 5,000 L".
- **Right:** 1000 L detention / 5000 L total, or a refusal naming the bad input.
- **Fix:** accept thousands separators and an L/kL suffix; say "not a number" instead of using 0.
- **Unit test RED:** yes — `WaterTankDialog.TankViewModel` with `TypedDetention = "1,000"` gives `DetentionLitres == 0`.

### DFGH-14 (MEDIUM, CONFIRMED) — Base RL is only asked after a callout point and can never be edited
- **Where:** `Commands/WaterTankCommand.cs:224-229`; `Commands/WaterTankCommand.Window.cs:422-423`. No other code writes a tank's Base RL.
- **Steps:** CDWT, Enter at the callout prompt (or at Base RL). CDTWL.
- **Wrong:** "WT1 has no base level recorded" — for good; the message says "fill them in" but nothing can.
- **Right:** Base RL asked regardless of callout, and editable in CDINSPECTOR.
- **Fix:** ask Base RL unconditionally; add a tank Base RL field to the Inspector.
- **Unit test:** no; manual.

### DFGH-15 (MEDIUM, CONFIRMED for Xref; CE pit block PLAUSIBLE) — "Tag a block already in the drawing" will adopt an Xref
- **Where:** `Commands/WaterTankCommand.cs:348-381`; `Commands/WaterTankCommand.Apply.cs:90-98, 225-230`. No Xref check.
- **Steps:** CDWT > Tag a block already in the drawing > pick the architectural Xref.
- **Wrong:** the Xref insert moves to the WATER TANK layer and is recorded as WT1. Breaks the AGENTS.md native-protection rule.
  A CE pit block looks adoptable too, giving two records on one handle.
- **Fix:** refuse Xref/overlay inserts and blocks that already own a pit record.
- **Unit test:** no; manual.

### DFGH-16 (LOW-MEDIUM, CONFIRMED) — command-line tank list shows only the nine smallest tanks
- **Where:** `Commands/WaterTankCommand.cs:471-474` with `Rules/TankLibrary.cs:282-311` (sorted by size, cut at nine,
  undoing the JSON's most-used order).
- **Steps:** AutoCAD 2022-2026 (or window fails). Underground: "5000 L Slimline", 6000, 7000, 8000, 10000 never offered.
- **Fix:** filter by position first, keep library order.
- **Unit test RED:** yes — `TankLibrary.Keywords(TankLibrary.ForPosition(parsed shipped JSON, "Underground"))` lacks "5000 L Slimline".

### DFGH-17 (LOW, CONFIRMED) — callout detention + re-use can add to more than the tank
- **Where:** `Commands/WaterTankCommand.Plan.cs:185-193` (each rounded separately).
- **Steps:** total 3000, detention 1499.5. **Wrong:** "1500 … DETENTION / 1501 … REUSE" = 3001. **Right:** 1500 / 1500.
- **Unit test RED:** yes — `WaterTankCommand.BuildCalloutText("WT1", 3000, 1499.5, 1500.5)`.

### DFGH-18 (LOW, CONFIRMED) — typing 0 detention for a library tank brings back the library default
- **Where:** `Commands/WaterTankCommand.cs:498-501`. Only office libraries with a non-zero default are affected
  (shipped JSON has 0 everywhere). **Fix:** only Enter takes the default.

### DFGH-19 (MEDIUM, PLAUSIBLE) — plan tile size can differ from the block actually inserted
- **Where:** `Services/WaterTankPlanBlockSource.cs:211-212, 241` (tile size × master insert scale) vs
  `Commands/WaterTankCommand.Apply.cs:234-239` (always scale 1, no rotation). A master plan drawn in metres and scaled
  ×1000 would show "(1900 x 2150 mm)" but land 1000 times too small. Depends on how the master is drawn.
- **Fix:** carry the master insert's scale and rotation, or show unscaled size.

**Not reported (latent):** `WaterTankDetailDrafter`, `WaterTankDetailFieldMap`, `WaterTankDetailGrouping`,
`WaterTankZoneSplit` have no live caller, so there is currently no detail-side tank figure at all (relevant to T-02).

---

## B. Detention, OSD and orifices — area F

**Context:** the live CDCALC uses Boyd's plus the Detention System tab. `OrificeCalcViewModel`, `DetentionCalcViewModel`
and `DetentionDesignViewModel` live only in the old `CalculationsDialog`, which nothing opens; the orifice pit detail
mappers (`OrificePitDetailLiveMapper`, `OrificeDetailFieldMap`, `OrificeStandardDetailDrafter`) also have no live caller.
Findings there are LOW.

### DFGH-02 (HIGH, CONFIRMED) — sheet, export and OSD block print the plate height as the orifice head
- **Where:** `Services/ComputationsRecordBuilder.cs:365-390` (plate height Unknown "the calculation records the head";
  `statedHeadM` = baffle ÷ 1000). Sizing uses h = baffle − d/2 (`ViewModels/DetentionSystemViewModel.cs:1028`).
  Also `Services/CalculationExportPackage.cs:401` ("Head (Baffle)") and `Rules/CriteriaBlockRows.cs:51` ("HEAD" = baffle).
- **Steps:** CDCALC > Detention, PSD 5.00, TWL 0.500 m above orifice pit invert (baffle 500). Export, or insert the OSD block.
- **Wrong:** Head 0.500 m, plate height Unknown, Ø59, Qo 4.98. Checker: 0.6 × 0.002734 × √(2 × 9.81 × 0.5) = 5.14 L/s > PSD.
- **Right:** plate height 500 mm, head 0.4705 m (CE practice, 43 of 43 sheets: head = plate − d/2).
- **Fix:** pass the baffle as `plateHeightMm` and drop `statedHeadM`, so `ComputationsOrifice.Head()` derives plate − d/2;
  relabel the OSD block row "PLATE HEIGHT" or print the true head.
- **Unit test RED:** yes — `ComputationsRecordBuilder.SystemFrom(summary, …)`: `Orifice.Head()` should be (500 − 59/2)/1000.

### DFGH-03 (HIGH, CONFIRMED) — CDCALC counts every detention pipe as full, regardless of TWL
- **Where:** `ViewModels/DetentionSystemViewModel.cs:162` and `:600-602` (volume = πd²/4 × L, no TWL). Pits honour TWL
  (`:715-721`). Suggested TWL uses the diameter of the pipe with the highest invert, not the highest obvert (`:818-826`);
  CDTWL's rule level has the same fault (`Services/DetentionTwlService.cs:77-87`).
- **Steps:** 375 pipe, 20 m, IL 10.00 → 9.90. Untick suggested TWL, type 10.20.
- **Wrong:** 2.21 m³. **Right:** circular-segment storage below 10.20 ≈ 1.56 m³ (42% over). Second case: 375 at IL 10.00
  beside 225 at IL 10.10 gives suggested TWL 10.325 while the 375 (obvert 10.375) is counted full.
- **Fix:** use `DetentionStorageMath.PipeRunLitres` at the TWL; suggested TWL = max(invert + diameter).
- **Unit test RED:** yes — `DetentionSystemViewModel.PopulateFromSeeds` with a manual TWL.

### DFGH-04 (HIGH; path CONFIRMED, frequency PLAUSIBLE) — blank pipe invert read as RL 0.000
- **Where:** `ViewModels/DetentionSystemViewModel.cs:564-567` (`Parse` blank → 0), `:674-691`
  (`GetPitOutletInvertFromSeeds` takes the minimum including 0), `:717-720` (pit depth), `:837` (baffle). CDTWL guards
  this (`Rules/DetentionBranchCollector.cs:296`); CDCALC does not.
- **Steps:** detention pipe P1 → P2 225, FromInvert blank, ToInvert 10.00; P1 600 x 600 grated. CDCALC > Detention.
- **Wrong:** P1 depth 10.225 − 0 → 3.68 m³ (right ≈ 0.08). If the blank end is the orifice pit: baffle 10 225 mm,
  orifice 27 mm (right ≈ 59), OSD block "HEAD 10225.00 mm".
- **Fix:** blank/non-number = Unknown; leave that end out and name it.
- **Unit test RED:** yes — `PopulateFromSeeds` with `FromInvert = 0`.

### DFGH-06 (HIGH, CONFIRMED) — CDDESIGN cannot size detention for councils that provide the PSD
- **Where:** `Services/CivilDesignService.cs:146-169` builds `DesignInputs` without `CouncilProvidedPsdLps`; no PSD field
  in `Rules/CivilDesignWorkflow.cs` or `Dialogs/CivilDesignWindow.xaml`. `Services/AutoDesignService.cs:135-137, 347`
  then stops. Eight profiles carry `"psdMethod": "council-provided"` (`Assets/Config/council-profiles.json`).
- **Steps:** CDRULEBOOK = Kingston (or Monash), CDDESIGN, fill all fields, work it out.
- **Wrong:** always "Permitted discharge not given … Enter the council's figure"; storage, orifice and detention pipe all zero; no box exists.
- **Right:** a PSD box in CDDESIGN (or CDCALC Detention's PSD) passed through.
- **Fix:** add council PSD to `CivilDesignState` and pass it in `Run`.
- **Unit test RED:** yes — `CivilDesignService.Run(state)` for a council-provided profile.

### DFGH-09 (HIGH, CONFIRMED) — CDTWL counts the detention pit's solid chamber and dividing wall as storage
- **Where:** `Rules/DetentionBranchCollector.cs:200-218` uses `XWidth × YWidth`; for a detention pit `XWidth` = solid +
  grated + wall (`Commands/PitCommand.cs:831-833`, `Rules/PitOutline.cs:247-252`). CDCALC uses the grated chamber only
  (`ViewModels/DetentionSystemViewModel.cs:1038-1053`).
- **Steps:** detention pit solid 450 + grated 450, CDTWL.
- **Wrong:** ≈ 0.47 m² plan (with 150 wall) vs 0.20 m²; at 0.6 m depth 0.28 vs 0.12 m³. TWL solved too low; "That is enough" can be wrong; CDCALC and CDTWL disagree.
- **Fix:** for detention pits use `DetentionGratedWidth × DetentionYWidth`.
- **Unit test RED:** yes — `DetentionBranchCollector.Collect`.
- **Related:** BUG-720 (LandXML detention pit double length) is a different path.

### DFGH-20 (MEDIUM, PLAUSIBLE) — CDCALC orifice head measured from the inlet detention pipe, not the orifice invert
- **Where:** `ViewModels/DetentionSystemViewModel.cs:558` (only detention pipes become seeds), `:648`, `:674-691`, `:833-849`.
- **Steps:** inlet detention pipe at IL 9.95, outlet/orifice at 9.85, TWL 10.45, PSD 5.00.
- **Wrong:** baffle 500 → Ø59. Real plate height 600 → h 0.5705, Qo 5.49 L/s (10% over PSD).
- **Fix:** use the pit floor or outlet pipe invert. **Unit test RED:** yes — `PopulateFromSeeds` + `BuildSummary`.

### DFGH-21 (MEDIUM, CONFIRMED) — shallow baffle: orifice search can adopt a hole bigger than the baffle
- **Where:** `ViewModels/DetentionSystemViewModel.cs:915-951` (flow peaks at d = 1.6 × baffle; loop stops at first failure).
- **Steps:** baffle 150, PSD 25. **Wrong:** adopts Ø299, Qo 4.17, shown as pass; PSD 15 → ≈ Ø167 on a 150 baffle.
- **Right:** warn "no valid orifice — top of hole above TWL"; cap d below the baffle.
- **Unit test RED:** yes — `DetentionSystemViewModel` via `PopulateFromSeeds`.

### DFGH-22 (MEDIUM, CONFIRMED) — sheet says storage "derived by Boyd's method" even when typed
- **Where:** `Services/ComputationsRecordBuilder.cs:353-358` ignores `DetentionSystemViewModel.StorageSource`.
- **Steps:** type 2.58 in Volume required; prepare the sheet. **Wrong:** "derived … by Boyd's method". **Right:** "Typed".
- **Unit test RED:** yes — `SystemFrom`.

### DFGH-23 (MEDIUM, CONFIRMED) — "2,58" read as 258 on the Detention tab; OSD block prints it
- **Where:** `ViewModels/DetentionSystemViewModel.cs:1089-1096` (`NumberStyles.Any`, invariant), read by `BuildSummary:782-786`.
  `Rules/DetentionVolumeRequired.cs:43` uses `NumberStyles.Float`, so the screen and block disagree.
- **Wrong:** screen "Enter required volume to compare", block "VOLUME REQUIRED 258.00 m3"; PSD "5,24" → 524 L/s.
- **Fix:** one parser, `NumberStyles.Float`. **Unit test RED:** yes — `BuildSummary`.

### DFGH-24 (MEDIUM, CONFIRMED) — clearing the PSD leaves the old orifice on the OSD block
- **Where:** `ViewModels/DetentionSystemViewModel.cs:723-731` returns early.
- **Steps:** PSD 5 (Ø59), clear PSD, insert block. **Wrong:** "PSD NOT SET" beside "DIA. OF ORIFICE 59.00 mm"; a typed
  60 also prints "(exact 55.83 mm)". **Right:** orifice NOT SET; "exact" only for the auto value.
- **Unit test RED:** yes — `BuildSummary`.

### DFGH-25 (LOW, CONFIRMED) — removed detention pipes and pits come back on reopen, ticked and counted
- **Where:** `ViewModels/DetentionSystemViewModel.cs:427-445, 618, 1150-1159, 1251-1262`. **Fix:** save removals as deselected.

### DFGH-26 (LOW, CONFIRMED) — CDCALC pit storage not capped at the lid; cover warning checks only the orifice pit
- **Where:** `ViewModels/DetentionSystemViewModel.cs:715-721, 1276-1301`. CDTWL caps correctly (`DetentionStorageMath.PitLitres`).

### DFGH-27 (LOW, CONFIRMED) — Boyd's: site area 0 leaves the previous storage on offer
- **Where:** `ViewModels/BoydsCalcViewModel.cs:224-228` returns early; "Use Boyd's value" still offers the old figure.

### DFGH-28 (LOW, CONFIRMED, unreachable today) — old-window orifice pages round to nearest mm / ignore d/2
- **Where:** `ViewModels/DetentionDesignViewModel.cs:246` (83.81 → 84 → 10.04 L/s FAIL on its own defaults);
  `ViewModels/OrificeCalcViewModel.cs:122` (head = plate height). Only in the old window nothing opens.

**Note for whoever fixes BUG-330:** the BUG-331 metre-drawing pipe-length fix went into `DetentionCalcViewModel.cs:189-237`
(old window). The live Detention tab still divides drawn length by 1000 (`DetentionSystemViewModel.cs:1066-1076`).

---

## C. Pump stations, wet wells, rising mains — area H

**Context:** CDDESIGN never runs the pump sizing (DFGH-29), so DFGH-30 and DFGH-31 cannot reach a drawing yet; they will
the moment the pump step is connected.

### DFGH-07 (HIGH, CONFIRMED) — CDEDIT wipes a rising main's destination; checks then call it an uphill gravity pipe
- **Where:** `Commands/PipeEditCommand.Update.cs:1844` sets `RisingMainDestination = string.Empty` on every single-pipe
  save; `Services/ProjectDataService.Mutations.cs:755-760` replaces the stored row. Consumers:
  `Services/CivilNetworkHealthService.cs:278, 299-301`, `Rules/RulebookEngine.cs:81` via
  `Services/DesignValidationService.cs:432-448`, `Rules/PipeWindowPrefill.cs:116`.
- **Steps:** CD a Rising Main SPS1 (IL 8.50) → P5 (IL 10.20). CDEDIT it, change nothing, OK. Run the network check and CDRULES.
- **Wrong:** Error "Gravity pipe rises toward its recorded outlet"; R min-grade "flows uphill: 8.500 below 10.200";
  gravity speed and cover rules applied; record now says Stormwater.
- **Right:** destination P5 kept, no findings.
- **Same cause:** CD gives the SPS half of a split rising main a blank destination (`Commands/CdCommand.Schedule.cs:186-212`).
- **Fix:** keep the existing destination when the type is Rising Main.
- **Unit test RED:** after extracting the row build; downstream effect RED today via `IsGravityPipeType` on a row with blank destination.

### DFGH-08 (HIGH, CONFIRMED) — "gravity or pumped" ignores the drawn pipe type; Point Order always means gravity
- **Where:** `Services/DesignValidationService.cs:432-448` returns gravity for FlowMode "pick" before checking destination;
  never reads `RulebookDrawingType` (loaded at `Services/ProjectDataService.RulebookDrawing.cs:249`).
- **Steps:** CD a Rising Main SPS1 → P5 in Point Order mode; CDRULES. **Wrong:** uphill warning plus gravity speed/cover checks.
- **Fix:** check `RulebookDrawingType == RisingMain/Charged` first; move the "pick" rule after.
- **Unit test RED:** yes — `IsGravityPipeType(new PipeData{FlowMode="pick", RisingMainDestination="P5"})` returns true.

### DFGH-29 (MEDIUM, CONFIRMED) — CDDESIGN never sizes a pump and says "Nothing is stopping this design" on an SPS job
- **Where:** `Services/CivilDesignService.cs:147-171` (no basement flag, no pump inputs; defaults off,
  `Models/DesignPackageModels.cs:38, 43`); pump step `Services/AutoDesignOrchestrator.cs:98-105, 168-184` and SPS detail
  `:227` unreachable.
- **Steps:** basement job with SPS1 and rising main; CDDESIGN. **Wrong:** no pump section, no SPS detail, all clear.
- **Fix:** if the drawing has an SPS pit, set the basement flag (existing refusal/warning fires) or warn "size separately".
- **Unit test RED:** yes — `CivilDesignService.Run` with an SPS state.

### DFGH-30 (MEDIUM, CONFIRMED, not yet reachable) — pump sizing can pick a pump too small for its own wet well rule
- **Where:** `Services/PumpSizingService.cs:263-282` (storage worked with first-pass duty, duty re-picked from the smaller well, never re-checked).
- **Hand example:** 321 m², 214 hard, C 0.70, I 18.1 mm/h at 120 min, Q 1.13 L/s, storm 8.13 m³, 1% term 3.21 m³.
  Step B picks 5 L/s (9.0 m³) → additional 0 → well 3.21 → re-pick 2 L/s. With 2 L/s the additional is 8.13 − 3.6 = 4.53 > 3.21.
  **Right:** 3 L/s, 3.21 m³. Notes also describe the 5 L/s pump not chosen.
- **Fix:** first duty d with 1.8d ≥ max(Qtotal − 1.8d, 1% term); well with that d.
- **Unit test RED:** yes — `PumpSizingService.Design`, assert `WetWellVolumeM3 >= QTotalM3 − PumpDutyLps × 1.8`.

### DFGH-31 (MEDIUM, CONFIRMED, not yet reachable) — no rising main friction, total head or velocity check
- **Where:** `Services/PumpSizingService.cs:284-300`; `RisingMainLengthM` required (`:415`) but used only in a note.
- **Hand example (Hazen-Williams C 140, 30 m):** 5 L/s in 50 mm: 2.55 m/s, friction ≈ 4.0 m — pump specified on static
  rise (~2 m) alone. 1 L/s in 50 mm: 0.51 m/s (below 0.6 scour) and no warning.
- **Fix:** add friction + fittings, report total head, warn outside 0.6–3 m/s. **Unit test RED:** yes.

### DFGH-32 (MEDIUM, CONFIRMED) — CDCALC Pump System tab shows and saves a made-up result; ARI box does nothing
- **Where:** `ViewModels/PumpSystemCalcViewModel.cs:9-16` (fixed 321/214/107 m², 18.1 mm/h, 3.4 L/s), read-only tab
  (`Dialogs/CalculationsV2Dialog.xaml:786-790`), saved on every CDCALC save (`ViewModels/CalculationsV2ViewModel.cs:543`).
  ARI unused (`:113-145`); areas never reconciled; additional storage not floored (10 L/s → "−9.09 m³"); no 30-min empty check.
- **Wrong:** every new job shows "Selected wet well = 3.210 m³". Sibling of HUNT2-C-03 (Boyd's), different tab.
- **Unit test RED:** yes — change `Ari` 10 → 100, `SelectedWetWell` unchanged.

### DFGH-33 (MEDIUM; code CONFIRMED, frequency PLAUSIBLE) — a pit with "pump" in its remarks is treated as an SPS; schedule picks the rising main as outlet
- **Where:** `Services/PitScheduleBuilder.cs:681-702` (Remarks contains PUMP or Id contains SPS), `:511-520`. Three different
  SPS tests exist (`CdCommand.Schedule.cs:196-201`, `PitViewModel.cs:807` use pit type only).
- **Steps:** P5 remark "Rising main from pump", rising main in, 150 gravity out. **Wrong:** schedule outlet = 50 rising main.
- **Fix:** one shared SPS test on pit type. **Unit test RED:** yes — `PitScheduleBuilder.IsSpsPit(…Remarks="Rising main from pump")` true.

### DFGH-34 (MEDIUM, PLAUSIBLE) — CD orders a rising main's From/To by level, not by which end is the SPS
- **Where:** `Commands/CdCommand.Schedule.cs:55-66` vs destination at `:110`.
- **Steps:** SPS1 exit IL 10.10 discharging to P5 inlet 9.95. **Wrong:** From P5 To SPS1 while destination says P5.
- **Fix:** SPS end is always From. **Unit test:** after extracting the decision.

### DFGH-35 (LOW, PLAUSIBLE — engineering call for Tim) — SPS schedule depth leaves out the wet well
- **Where:** `ViewModels/PitScheduleViewModel.Data.cs:2108-2117`. Cover 10.50, wet well floor 8.30 → schedule says 0.70 m; structure is 2.20 m.

### DFGH-36 (LOW, CONFIRMED) — small text faults
- `Services/PumpSizingService.cs:278` prints "1%%-term" (escaped inside `$""`).
- `Services/SpsDetailGenerator.cs:426-428` labels "100 DIA. INLET PIPE" whatever the diameter (no live caller today).
- `SpsDetailGenerator.Validate` (`:461-473`) refuses pump 2 stop = pump 1 stop.

---

## D. Catchments, rational method and the rest of CDCALC — area D

**Checked and sound:** Q = C·I·A(ha)/0.36; m² → ha; Charged tab's /3600; Hazen-Williams; Manning full bore; minor losses;
WSUD runoff m³; IFD polynomial with duration in hours; ARI interpolation; rainfall paste rejects reversed/AEP blocks;
grated-pit area split; catchment-row save/reload.

### DFGH-11 (HIGH, CONFIRMED) — Pipe Flows keeps the first pipe's grade and n when a second pipe is picked
- **Where:** `ViewModels/PipeFlowCalcViewModel.cs:159-181, 195-226` (`IsBlankOrDefault` treats the previous prefill as typed; hint cleared and not reset).
- **Steps:** CDCALC > Pipe Flows. Pick A (300 uPVC, 1 in 150): fills n 0.010, 1 in 150. Pick B (300 concrete, 1 in 60).
- **Wrong:** B shows n 0.010, 1 in 150 → Q 102.64 L/s, V 1.45. **Right:** n 0.013, 1 in 60 → Q 124.84 L/s, V 1.77 (18% low).
  Goes into the export under "Selected pipe B".
- **Fix:** remember last prefilled values and treat them as fillable.
- **Unit test RED:** yes — seed two pipes, select A then B, assert SlopeRatio "60", Roughness "0.013".

### DFGH-37 (MEDIUM-HIGH, CONFIRMED) — Print tab title block wiped on every reopen
- **Where:** `ViewModels/CalculationsV2ViewModel.cs:58-63, 524-551`; `Models/CalculationWorkspaceData.cs:35-79` (only revision fields saved).
- **Steps:** Print > Sheet details: Job 26001, address, Engineer TB, Page 3. Close, reopen.
- **Wrong:** all blank, plot date reset; a re-export prints a computations sheet with no job number or address.
- **Fix:** save/restore the five fields and the export ticks.
- **Unit test RED:** yes — `CaptureCalculationWorkspace` → `TryRestoreCalculationWorkspace`, assert JobNumber "26001".

### DFGH-38 (MEDIUM, CONFIRMED) — a new job exports made-up catchment and pipe-flow figures
- **Where:** `ViewModels/RationalMethodViewModel.cs:157, 391-392`; `PipeFlowCalcViewModel.cs:17-21`; `CalculationsV2ViewModel.cs:331-333` (both sections ticked).
- **Wrong:** "C1, 500 m², C 0.9, Q 6.89 L/s" and "300 mm at 1 in 100, Q 96.70 L/s" in the council package for a job nobody typed into.
- **Right:** empty/Unknown until real inputs. Sibling of HUNT2-C-03 (Boyd's only).
- **Unit test RED:** yes — new `CalculationsV2ViewModel` → `CalculationExportPackage.Capture`, no 500 m² row.

### DFGH-39 (MEDIUM, CONFIRMED) — "Prefilled from P1→P2 inverts" stays after the grade is overtyped
- **Where:** `PipeFlowCalcViewModel.cs:34-50`; `CalculationExportPackage.cs:441-442`. Same class as BUG-598 but on Pipe Flows.
- **Unit test RED:** yes — after prefill set SlopeRatio "80", hint should be empty.

### DFGH-40 (MEDIUM, CONFIRMED) — Charged System accepts millimetres in metre boxes with no warning
- **Where:** `ViewModels/ChargedSystemCalcViewModel.cs:160-202`; `Dialogs/CalculationsV2Dialog.xaml:726, 734` (Pipe Flows next door takes mm).
- **Steps:** shipped inputs but diameter "150". **Wrong:** friction 0, Qmax 26.15 L/s. **Right (0.15 m):** total loss 0.3603 m, Qmax 19.76 L/s (32% over).
- **Fix:** warn above ~3 m or switch to mm. **Unit test RED:** yes.

### DFGH-41 (MEDIUM, PLAUSIBLE) — last box typed lost when CDCALC closes with Esc or the X
- **Where:** `Dialogs/CalculationsV2Dialog.xaml:1337` (Close IsCancel), `CalculationsV2Dialog.xaml.cs:124-134`. Standard WPF
  lost-focus binding behaviour; not visible in this code. **Fix:** commit the focused box in OnClosing.

### DFGH-42 (LOW-MEDIUM, CONFIRMED) — CDCATCHMENT labels 200 m tall in a metre drawing
- **Where:** `Services/GratedPitCatchmentOverlayService.cs:146` (TextHeight 200.0); `CatchmentOverlayStyle.cs:25-29` (mm offset added as drawing units).
- **Fix:** divide by `DrawingAreaUnits.MillimetresPerUnit`.

### DFGH-43 (LOW-MEDIUM, CONFIRMED) — Pipe Flows keeps 1 in 100 silently for an uphill pipe
- **Where:** `Services/CdCalcPrefillService.cs:112-117`; `PipeFlowCalcViewModel.cs:198-206`. From 10.00 To 10.10 → exported as 1 in 100, Q 96.70.
- **Unit test RED:** yes — `CdCalcPrefillService.BuildPrefill`, assert an adverse-grade flag.

### DFGH-44 (LOW, CONFIRMED) — comma decimal read as thousands on Catchments, Pipe Flows, Charged, WSUD
- **Where:** `RationalMethodViewModel.cs:289-294` (same in `PipeFlowCalcViewModel.cs:279-286`, `ChargedSystemCalcViewModel.cs:292-299`,
  `WsudViewModel.cs:222-227`). "12,5" m² → 125 m². Same root as DFGH-23; fix once.

### DFGH-45 (LOW, CONFIRMED) — WSUD says FAIL at exactly the target
- **Where:** `ViewModels/WsudViewModel.cs:185-199` (44.99999999999999 < 45); export "Pass?" always blank (`CalculationExportPackage.cs:536-540`). Tab read-only; old drafts only.

### DFGH-46 (LOW, PLAUSIBLE) — rating-report pick refuses a second catchment with the same name
- **Where:** `ViewModels/CatchmentReportPickViewModel.cs:68-74`; `CalculationsV2Dialog.xaml.cs:189-191`. Two "ROOF" rows (120, 80 m²): only one addable.

### DFGH-47 (LOW, CONFIRMED) — small CDCALC items
- Pipe Flows shows Unknown for "1:100" / "1 in 100" though `MathHelper.TryParseGrade` exists.
- Unticking Catchments "Manual override" leaves the old manual figure in the greyed box.
- The Charged System tab cannot be included in the export.

---

## What this hunt did and did not do

- **Did:** read the installed 3.0.54 Civil code for areas D, F, G, H; checked the worst findings (DFGH-01, 02, 03, 05, 06, 07,
  08, 11, 37) a second time against the source; de-duplicated against the carpark and all earlier hunt files.
- **Did not:** build, run tests, open AutoCAD, edit code, or file BUG numbers. Line numbers are for `def8e56f`.
- **DATA-01:** no client names or addresses recorded.

## Summary

This read-only hunt of installed Civil 3.0.54 found 47 new defects in catchments, CDCALC, detention, water tanks and pump
stations (11 HIGH, 21 MEDIUM, 15 LOW; 41 confirmed by reading, 6 plausible), none already in the carpark or earlier hunts.
The worst cluster breaks Tim's T-02 rule: a tank placed through the CDWT window is never counted by CDTWL, CDTWL also
counts it as a phantom pit, and CDCALC never reads tank litres at all, so plan, CDTWL and the OSD block give three
different tank figures. The second cluster puts wrong numbers on the issued computations sheet and OSD block: the orifice
"head" printed is really the plate height, detention pipes count brim-full whatever the TWL, and a blank pipe level is
read as RL 0.000. CDDESIGN cannot size detention for any council that provides the PSD, and CDEDIT wipes a rising main's
destination so the checks call it an uphill gravity pipe. Most HIGH findings can be shown failing in a unit test first.
