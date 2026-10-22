# Civil drainage engineering-correctness audit, 22 Oct 2026

**What was audited:** the installed Civil line, git ref `origin/claude/rel-20261022m` at `40ee0a36` (Civil 3.0.70 / Manager 1.1.70), code under `Modules/Drainage` (plus the back-test fixtures in `Modules/Drainage.Tests`).
**How:** read-only. Nothing was built, run, installed or changed. Every number below was worked by hand or by a short scratch script that copies the code's formula. The two Glen Eira calculation sheets named by the back-test (jobs 23-129 and 24-115) were opened read-only to settle the red test.
**Who:** Claude (Opus 5.5), acting as a senior civil/stormwater reviewer.
**Status words:** "Verified by reading" = I read the exact lines and worked the example. "Suspected" = the code reads that way, but the effect depends on data or a convention I could not confirm.

---

## FOR TIM

### Answer first

1. **Counts:** 3 HIGH, 13 MEDIUM, 12 LOW.
2. **The one most likely to put a wrong number on an issued drawing:** the office rainfall curve. CDDESIGN tells the drafter that curve reads "about 7 to 9 per cent high" and sizes storage "7 to 9 per cent larger" than CE issued. On both Glen Eira jobs I checked it reads **6 to 8 per cent LOW**. Because storage is the gap between inflow and outflow, 7 per cent less rain means about **18 per cent less storage**. Example, job 24-115: the issued sheet says 2.58 m3; the same sheet re-worked on the office curve gives 2.12 m3, and the warning tells the drafter that number is on the safe side. Finding 3.
3. **The red test (GE 24-115, 1.69 vs 2.58 m3):** the storage maths is right; it is the same formula as the issued sheet, line for line. The test is out of date, not the engine. It feeds a 2024 job three inputs CE has since changed: the Glen Eira discharge storm (1 in 5 then, 1 in 10 now, from the July 2026 council report), the soft-ground C (0.35 then, 0.30 now) and the rainfall (site rainfall then, office curve now). Fix the test; **do not widen the 30 per cent band**. Finding 16.
4. **The other two HIGHs:**
   - **CDRULES / CDCHECKS measure a pipe straight from pit centre to pit centre**, not along the drawn route. A dog-leg pipe or a same-plan break gets a steeper grade than the drawing shows, so a pipe that is too flat can pass. Finding 1.
   - **CDRUNSOLVE and the network redesign size every pipe as UPVC**, whatever material is drawn. On a concrete line that over-states capacity by about 23 per cent. Finding 2.

### Questions for you (engineering calls, batched)

1. **Rainfall curve.** Should CDDESIGN refuse to call the office curve "high" and instead say "may be high or low, by up to about 8 per cent; storage moves about 2.5 times as much"? **Recommend yes.** On a job: a Glen Eira drafter would see that the 2.12 m3 might really be 2.58 m3, and would load the site rainfall.
2. **Cover.** Cover is measured to the inside top of the pipe, and only at the pits. AS/NZS 3500.3 measures to the outside top. Should CE add the pipe wall: about 20 mm for UPVC 225, about 45 mm for concrete 375? **Recommend yes, as a Settings table of wall thickness by material.** On a job: a concrete 375 showing 320 mm cover really has about 275 mm, below your 300 mm.
3. **Pit drop where the pipe gets bigger.** CDRULES only compares inverts. Should a 150 into a 300 also be checked obvert to obvert? **Recommend a warning when the outlet obvert sits above the inlet obvert.** On a job: a 150 in at IL 10.000 and a 300 out at 9.980 passes the 20 mm drop, but the outlet's top sits 130 mm above the inlet's top, so water backs up the 150.
4. **Pit Schedule depth.** You ruled on 20 Oct that pit depth means the pit floor. The Pit Schedule still measures to the outlet pipe. Should it use the pit floor when the pit has one? **Recommend yes.** On a job: cover 11.00, outlet 10.15, floor 10.05. The schedule says 0.85 m (no step irons); CDRULES says 950 mm (step irons needed).
5. **Minimum grade table.** It has 375 at 1 in 300 but 450 and larger at 1 in 200, so a bigger pipe must be laid steeper than a smaller one. Is that your office rule, or should 450+ be 1 in 300 or flatter? **Recommend you confirm the ladder in Settings.** It is still marked "AS/NZS attribution unverified".

### What I could not check

1. Anything inside AutoCAD (the label actually drawn, the criteria block on a sheet).
2. Clause numbers I mark "not certain" below; I have no copy of AS/NZS 3500.3:2021 to hand.

---

## Findings (technical detail below this line)

Severity order: HIGH, then MEDIUM, then LOW. File paths are relative to `Modules/Drainage/` at `40ee0a36`.

### HIGH

1. **HIGH. CDRULES and CDCHECKS work grade and speed on the straight pit-centre distance, not the drawn route or the real length.** Verified by reading.
   - **Where:** `Rules/RulebookEngine.cs:77` (length), `:88-89` (grade = length / fall); `Services/PipeGeometryHelper.cs:128-171` (straight line between the two pits' insertion points). The drawing's own label and calculated levels use the route length (`Commands/CdCommand.cs:437`, `PipeEditCommand.RouteLengthMillimetres`), or the real length on a same-plan break (`CdCommand.cs:441-453`, BUG-683). `PipeData` stores no length, so the rules cannot see the route.
   - **Rule touched:** AS/NZS 3500.3 minimum grade (the R-03 ladder), R-01 scour, R-02 self-cleansing, R-30, R-31, R-32. Also design rule #1 (one code path per behaviour): the pipe-size review already uses the drawn length (`Services/PipeSizeNetworkReviewService.cs:606-620`), the rules do not.
   - **For Tim:** a pipe with a bend, or a same-plan break, gets a steeper grade in CDCHECKS than on the drawing, so a pipe that is too flat can be marked OK.
   - **Worked example 1 (bend):** DN225 UPVC, route 12 m + 12 m = 24 m, straight distance 16.97 m, levels 10.000 to 9.900. Label: 1 in 240. CDRULES: 16.97 / 0.10 = 1 in 170, so R-03 PASSES against the 1 in 200 ladder step. It should WARN (1 in 240 is flatter than 1 in 200). Full-bore capacity: CDRULES works 44.8 L/s; the real figure is 37.7 L/s (19 per cent over).
   - **Worked example 2 (same-plan break):** DN225 drawn 20 m long, really 50 m, fall 0.20 m. CDRULES: 1 in 100, PASS. Real: 1 in 250, should WARN.
   - **Deterministic test:** a ProjectData with pits P1 at (0,0) and P2 at (12000,12000) (mm drawing), pipe P1 to P2, DN225 UPVC, IL 10.000 / 9.900, plus a supplied route length of 24.0 m. Expected: R-03 Warn with "1:240". Today: Pass with "1:170".

2. **HIGH. CDRUNSOLVE, the network redesign and the proposals that write sizes treat every pipe as UPVC.** Verified by reading.
   - **Where:** `Services/NetworkDesignService.cs:286` and `:520` (`Material = "UPVC"` on the first sizing and on the re-check). Callers: `Commands/RunSolveCommand.cs:143`, `Services/AutoDesignOrchestrator.cs:212`, `Services/NetworkRedesignSolverService.cs:23`, `Services/ProposalApplyService.PlanBuilders.cs`.
   - **Rule touched:** Manning roughness by material (Settings `manningsNByMaterial`: UPVC 0.010, RCP 0.013); R-00.
   - **For Tim:** on a concrete line the solver thinks the pipe carries about 30 per cent more than it does, so it can propose a size one step too small.
   - **Worked example:** a design flow of 200 L/s in DN375. As UPVC (n 0.010) the solver needs 1 in 130 and calls it a fit. The same pipe in RCP (n 0.013) at 1 in 130 carries 153.8 L/s, which is 23 per cent short.
   - **Deterministic test:** call `NetworkDesignService.Design` on a two-node network with one link, Q = 200 L/s, length 20 m, the link's material RCP. Expected: DN450, or DN375 at a grade of 1 in 77 or steeper (the grade that gives 1.811 m/s with n 0.013). Today: DN375 at 1 in 130.

3. **HIGH. The office rainfall curve is described as reading high; on real Glen Eira sheets it reads low, and storage is about 2.5 times as sensitive as the note says.** Verified by reading and by the two issued sheets.
   - **Where:** `Rules/RainfallCurve.cs:241-247` (sentence shown to the drafter), `:27-31` (provenance note), `Services/AutoDesignService.cs:185-188`.
   - **Rule touched:** ARR / BoM IFD for the site (the job's own IFD); council OSD volume.
   - **For Tim:** the warning tells the drafter the storage is on the safe side when, for these jobs, it is about 18 per cent short.
   - **Worked example (1 in 10 intensities, mm/h, office curve vs the issued sheet):** 5 min: 105.0 vs 112 (6.3 per cent low); 10 min: 78.7 vs 85.0 (7.4 per cent low); 15 min: 64.6 vs 69.4 (6.9 per cent low). Job 23-129 shows the same pattern (113 / 85.1 at 5 / 10 min). Storage for job 24-115 with every other input as issued (C 0.6718, permitted discharge 5.87 L/s): issued sheet 2.576 m3; office curve 2.123 m3 (17.6 per cent low). The sentence claims a 7 to 9 per cent oversize.
   - **Also:** even where the curve does read 7 to 9 per cent high, storage would come out about 15 to 25 per cent high, not 7 to 9, because storage = (inflow − permitted outflow) × duration.
   - **Deterministic test:** `DetentionSizingService.SizeBoyds` with area 640.67 m2, C 0.6718, provided PSD 5.87 L/s, office curve, storage ARI 10. Expected SSR 2.123 m3 at 10 min (±0.005). Then assert the curve sentence does not contain "high" unless a comparison proves it for this job.

### MEDIUM

4. **MEDIUM. Cover is measured to the inside top of the pipe; the pipe wall is ignored.** Verified by reading.
   - **Where:** `Rules/RulebookEngine.cs:466` (`(cover − invert) × 1000 − diameter`); `Services/PipeSizingSolver.cs:387-388` (`obvert = invert + diameter`).
   - **Rule touched:** AS/NZS 3500.3 cover: finished surface to the top of the pipe. I am fairly sure it means the outside top; clause number not certain.
   - **For Tim:** the cover is over-stated by the wall thickness.
   - **Worked example:** RCP DN375 (wall about 45 mm; check the supplier's table), cover level 11.000, IL 10.305. CE: (11.000 − 10.305) × 1000 − 375 = 320 mm, PASS against 300. Outside top: about 275 mm, which fails. UPVC DN225 (OD 250): over-stated by about 18 mm.
   - **Deterministic test:** R-04 with a Settings wall table {RCP 375: 45}. Pit cover 11.000, pipe IL 10.305, DN375 RCP, minimum 300. Expected Warn "cover 275 mm". Today: Pass "cover 320 mm".

5. **MEDIUM. Cover is checked only at the two pits, against the pit lid level, with one figure for every surface.** Verified by reading.
   - **Where:** `Rules/RulebookEngine.cs:444-474`; `Services/PipeSizingSolver.cs:353-371` (two ends only); `Models/UserSettings.cs:1736` (300 mm, your 24 Sep ruling).
   - **Rule touched:** AS/NZS 3500.3 minimum cover depends on the surface (no traffic, light vehicles, heavy vehicles; paved or not). Not certain of the exact table values.
   - **For Tim:** a pipe that runs under a lower garden bed between two raised pit lids, or under a driveway, is never checked there.
   - **Worked example:** pits at 11.00 and 10.90, pipe ILs 10.40 and 10.30, DN150. Cover at the pits: 450 mm each, PASS. Halfway, under a garden bed at 10.65, the pipe top is at 10.50, so cover is 150 mm, and nothing reports it.
   - **Deterministic test:** a cover check fed a surface profile (spot levels at 0, 5 and 10 m: 11.00, 10.65, 10.90). Expected: Warn at 5 m, 150 mm. Today: no such input exists; only the two pit rows.

6. **MEDIUM. Moving a pit with a held grade rounds the bottom level to the nearest step, so the pipe can come out flatter than the grade it was held at.** Verified by reading.
   - **Where:** `Services/LinkService.Utilities.cs:2293-2309` (`ComputeGradeLockLevels`: plain `ToString("F2")`). CD itself rounds the drop UP (`Helpers/MathHelper.cs:296-323`), so the same job gets two answers (design rule #1).
   - **Rule touched:** minimum grade; drafting rule "never flatter than the minimum".
   - **For Tim:** after a pit move a 1 in 100 pipe can read 1 in 102.
   - **Worked example:** top level 10.00, new length 15.30 m, held at 1 in 100. Raw bottom 9.847, written 9.85, fall 0.15, label 1 in 102. CD on the same pipe writes 9.84 (fall 0.16, 1 in 96).
   - **Deterministic test:** `ComputeGradeLockLevels(10.00, 9.90, "10.00", "9.90", 15.30, 100, 2, ...)`. Expected newTo "9.84". Today "9.85".

7. **MEDIUM. Different screens judge the same pipe against different minimums.** Verified by reading.
   - **Where:** grade: `Services/DesignValidationService.cs:350` uses one figure, `minimumPipeGrade` 1 in 200 (`Models/UserSettings.cs:1718`), while CDRULES uses the ladder by size (`Models/UserSettings.cs:1920-1924`, `Rules/RulebookValues.cs:337-358`). Cover: `Services/MinimumCoverForChecks.cs:18-30` (Inspector, Hub, repair checks read the office 300 while `checks.coverUsesRulebookValue` is OFF), while CDRULES reads the council first.
   - **For Tim:** the Inspector and CDRULES can disagree on the same pipe.
   - **Worked example 1:** DN100 at 1 in 150. Inspector: OK (1 in 150 is steeper than 1 in 200). CDRULES: Warn (the ladder says 1 in 100 for DN100).
   - **Worked example 2:** a Frankston job (council cover 250 mm) with a pipe at 270 mm cover. CDRULES: Pass. Inspector: Warn (office 300).
   - **Deterministic test:** DN100, length 15 m, ILs 10.10 / 10.00. Expected: Inspector and R-03 give the same verdict (Warn). Today: Inspector clean, R-03 Warn.

8. **MEDIUM. The Pit Schedule measures depth to the outlet pipe, not the pit floor (your 20 Oct ruling).** Suspected: depends on the pit record holding its floor as `InvertLevel`.
   - **Where:** `Rules/PitScheduleDepthRule.cs:32-47` (cover minus outlet, else cover minus inlet). CDRULES R-29 uses the lowest of the pit level and all pipe levels (`Rules/RulebookEngine.cs:660-670`, `:685-701`).
   - **Rule touched:** your step-iron rule (deeper than 900 mm), pit depth = pit floor.
   - **For Tim:** the schedule and CDRULES can disagree on step irons.
   - **Worked example:** cover 11.00, outlet 10.15, pit floor 10.05. Schedule: 0.85 m, no step-iron note. CDRULES: 950 mm, needs step irons.
   - **Deterministic test:** `DepthText(false, "11.00", "10.20", "10.15")` with a floor 10.05 supplied. Expected "0.95". Today "0.85" (no floor input exists).

9. **MEDIUM. CDTWL counts some water twice and counts water that never drains.** Suspected (the volumes depend on the drawing).
   - **Where:** `Rules/DetentionBranchCollector.cs:323-339` (pipe length pit centre to pit centre while `pipeStorageWallToWall` is OFF, the default, `Models/UserSettings.cs:2221-2222`); `Rules/DetentionStorageMath.cs:106-125` (a pit holds water from its floor up, including any sump below the orifice).
   - **Rule touched:** detention storage is the live volume above the orifice; council OSD.
   - **For Tim:** CDTWL can say the system holds a little more than it does, so the top water level comes out low.
   - **Worked example:** three 600 x 600 pits and four DN225 pipe ends (0.3 m of pipe inside each pit): 4 x 0.3 x 0.0398 m2 = 48 L counted twice. An orifice pit with a 150 mm sump below the orifice: 0.36 m2 x 0.15 m = 54 L of water that cannot drain. About 100 L over on a 2,576 L requirement, about 4 per cent.
   - **Deterministic test:** a branch with an orifice pit (600 x 600, floor 10.00, orifice invert 10.15) and one upstream DN225 pipe 10 m centre to centre, 9.4 m wall to wall, inverts 10.20 / 10.15. Expected live storage below TWL 10.60 excludes the 54 L sump and counts 9.4 m of pipe.

10. **MEDIUM. CDTWL ignores the drawing's units when it measures pipes.** Verified by reading.
    - **Where:** `Rules/DetentionBranchCollector.cs:323-330` (raw position difference read as millimetres). The rules already convert with `PositionInsunits` (`Services/PipeGeometryHelper.cs:128-153`); this path does not.
    - **For Tim:** on a metre drawing, every pipe in CDTWL holds 1,000 times too little water, so CDTWL says the storage is too small.
    - **Worked example:** metre drawing, 20 m DN300 pipe full: real 1,414 L; CDTWL 1.4 L.
    - **Deterministic test:** two pits at (0,0) and (20,0) with `PositionInsunits` 6, DN300, both inverts below the TWL. Expected about 1,414 L. Today about 1.4 L.

11. **MEDIUM. The storm sweep is too coarse near the peak, and says nothing when the worst storm is the first one.** Verified by reading and recalculation.
    - **Where:** `Services/DetentionSizingService.cs:66-67` (5, 10, 15, 20, 25, 30, 45, 60 ... minutes), `:156-159` (warns only when the LAST storm is worst).
    - **Rule touched:** Boyd's method takes the maximum over all durations.
    - **For Tim:** CDDESIGN can under-size storage by 2 to 3 per cent because it skips the storms between 5 and 10 minutes.
    - **Worked example:** job 24-115 as CDDESIGN runs it today: 1.688 m3 at 5 min. A 1-minute sweep finds 1.734 m3 at 7 min (2.7 per cent more). Job 23-129: 3.234 at 5 min vs 3.304 at 6 min.
    - **Deterministic test:** `SizeBoyds` with area 640.67, impervious 374.9, C 0.6511, PSD computed (6.54 L/s), office curve, ARI 10. Expected SSR at least 1.73 m3, or a note "worst storm is the first one worked". Today 1.688, no note.

12. **MEDIUM. CDCALC's Boyd's tab and CDDESIGN use different hard-ground C, so the same job gets two storage figures.** Verified by reading.
    - **Where:** `ViewModels/BoydsCalcViewModel.cs:233-237` (roof and paved at 1.0 unless `boydsUsesHardGroundC` is ON); `Services/AutoDesignService.cs:62-69` (0.9).
    - **For Tim:** CDCALC and CDDESIGN give different volumes for one site.
    - **Worked example (job 24-115, the issued sheet's rainfall and 5.87 L/s):** sheet with 0.9: 2.58 m3. CDCALC default (1.0): C 0.7304, 3.11 m3 (21 per cent more). CDDESIGN today (office curve, 1 in 10 discharge, soft C 0.30): 1.69 m3.
    - **Deterministic test:** same inputs through both. Expected: equal SSR.

13. **MEDIUM. R-30 (council detention-pipe grade) still judges pipes that R-06 says cannot be told from downpipes.** Verified by reading.
    - **Where:** `Rules/RulebookEngine.cs:95-106` runs R-30 for every pipe `IsDetentionPipe` accepts; `:479-497` makes R-06 "not judged" for the same pipe (BUG-815 / BUG-854).
    - **For Tim:** a 100 mm downpipe left marked Detention can get a council detention-grade warning while R-06 says it was not judged.
    - **Worked example:** Manningham (detention minimum 1 in 180). DN100 downpipe, Detention ticked, no length, laid at 1 in 250. R-06: Unknown, "not judged". R-30: Warn, "flatter than Manningham's minimum OSD/detention storage grade 1:180".
    - **Deterministic test:** that pipe in a Manningham job. Expected R-30 Unknown with the same "no detention length" reason as R-06. Today Warn.

14. **MEDIUM. The pit drop check compares inverts only, so a pipe size increase can back water up the smaller pipe.** Verified by reading.
    - **Where:** `Rules/PitDropRule.cs:150-156`; `Rules/RulebookEvaluator.cs` (diameters not passed).
    - **Rule touched:** common council / Melbourne Water practice of matching obverts (or dropping at least the size difference) where the pipe size increases at a pit. Not certain of an AS/NZS 3500.3 clause.
    - **Worked example:** DN150 in at 10.000, DN300 out at 9.980. Drop 20 mm, PASS. Outlet top 10.280, inlet top 10.150: the outlet top is 130 mm higher.
    - **Deterministic test:** that pit. Expected Warn "outlet obvert 130 mm above inlet obvert". Today Pass.

15. **MEDIUM. Engineering numbers still fixed in code (R-00).** Verified by reading. Where a Settings value exists and the code number is only the fallback, it is marked "fallback".
    - **Council rules written in code (no Settings, no council profile):** `Services/ReuseCreditService.cs:31` Kingston block 2000 L; `:32` Kingston credit 500 L per block; `:33` Manningham factor 0.25; `:34` Casey reuse fraction 1/3; `:115` Manningham minimum reuse 2000 L; `:118` Manningham minimum roof 50 m2.
    - **Pump station:** `Services/PumpSizingService.cs:75` impervious C 0.90 (not the Settings hard-ground C); `:86` emptying time 1800 s; `:145` top working offset 0.10 m; `:152` one-per-cent multiplier 0.01; `:159` Bayside 1 in 20; `:176` ramp overland 1 in 100; `:179` ramp duration 5 min; `:102-108` rising main 5 L/s / 50 / 80 mm (fallback).
    - **Sizing and design:** `Services/NetworkDesignService.cs:286`, `:520` material UPVC (Finding 2); `Services/AutoDesignService.cs:669-670` connection pipe length 10 m and material UPVC; `Services/SettingsSizingStandards.cs:96` speed cap 6.0 m/s; `:97` minimum cover 600 mm (Finding 26); `Models/PipeSizingModels.cs:40-47` AS/NZS 3500.3 grade table; `:55` 600 mm; `:69` 0.6 m/s; `:75-76` size ladder (fallback); `Services/PipeSizingSolver.cs:415` 0.6 m/s (fallback); `Services/MinimumCoverForChecks.cs:18` 600 mm (fallback; conflicts with your 300).
    - **Storm and runoff:** `Services/DetentionSizingService.cs:66-67` storm durations; `:58` before-development C 0.35 (fallback); `Services/AutoDesignService.cs:55` hard-ground C 0.9 (fallback); `Services/RationalFlowService.cs:57` small-lot threshold 1000 m2; `:60` Tc 5 min and `:63` discharge storm 1 in 5 (fallbacks); `Rules/CouncilRuleValues.cs:186` storage storm 1 in 10 with no council.
    - **Orifice:** `Services/Hydraulics.cs:30` Co 0.6 (fallback to the council orificeCo); `:33` g 9.8 (9.81 would change flow by 0.05 per cent; harmless); `Services/OrificeSizer.cs:55` Casey K 21.9.
    - **Levels:** `Helpers/MathHelper.cs:229-230` drop always rounded up at 2 decimals, whatever `calculatedDecimals` says; `Rules/RulebookCalculations.cs:22-23` 2 decimals / 20 mm (fallbacks); `Services/Proposals/LevelsProposalSelection.cs:21` minimum fall 0.0005 m; `Services/LongitudinalSectionService.cs:332` pit sump 0.30 m on long sections; `Services/LinkService.RepairAudit.InvertPropagation.cs:27` assumed DN225 when the size is unreadable (the speed warning is then worked on a size nobody drew).
    - **Limits that drop data:** `Services/XcivilLayerRecognition.cs:41-42` imported levels 0 to 250 m (CDSURVEY now accepts −100 to 3000, `Models/UserSettings.cs:2091`, `:2097`), so an X-Civil import on a high site drops real levels.
    - **Detention fallbacks:** `Rules/DetentionTwlSolver.cs:109` freeboard 150 mm; `Rules/DetentionPipeLimitsRule.cs:14-16` 40 m / 225 / 600 mm; `Rules/PitScheduleDepthRule.cs` step irons 900 mm.
    - **Deterministic test:** a "no engineering literal" guard listing these files; each number moves to Settings (or the council profile), with the code value kept only as the documented fallback.

16. **MEDIUM. The red back-test GE 24-115 (1.69 vs 2.58 m3) is out of date; the engineering formula is right.** Verified by opening the issued sheet.
    - **Where:** `Modules/Drainage.Tests/Services/AutoDesignBackTestTests.cs:146-157`.
    - **What the issued sheet does:** Ip = C·I·A/360, V1 = Ip × duration, Smax = V1 − Qp × duration, take the largest. That is `DetentionSizingService.cs:136-140` exactly. Its rows: 5 min 2,256 L, 10 min 2,576 L (critical), 15 min 2,185 L.
    - **Why the engine differs (each step on its own):**
      - Engine today: 1.688 m3 (permitted discharge 6.54 L/s at 1 in 10; soft C 0.30; office curve).
      - Change the soft-ground C to 0.35, as the sheet used: 1.804.
      - Then the discharge storm to 1 in 5, as the sheet used: 2.326.
      - Then the sheet's own rainfall and 5.87 L/s: 2.576 (equals the sheet).
    - **Which input is right today:** the 1 in 10 discharge storm follows the newest Glen Eira document (Point of Discharge Report, 20 Jul 2026: pre-development 10-year discharge; your CP-02). So the 2024 sheet's 1 in 5 is the stale input, not the engine. Soft C 0.30 is your 25 Sep ruling. The rainfall gap is Finding 3.
    - **Test fault:** the GE 23-129 fixture pins `PostDevSoftGroundC: 0.35` to stay like-for-like; GE 24-115 does not. It also passes no job rainfall curve and no discharge figure.
    - **Recommendation:** pin `PostDevSoftGroundC: 0.35` and `CouncilProvidedPsdLps: 5.87` (the sheet's figure), and give the job's rainfall curve if it can be rebuilt. Expected with soft C and discharge pinned on the office curve: 2.123 m3, 17.7 per cent, which passes. Keep the 30 per cent band. GE 23-129 passes today only by luck (3.23 vs 4.53, 28.6 per cent); it uses the same 1-in-5 discharge and the same site rainfall, so pin it the same way.

### LOW

17. **LOW. Hydraulic radius uses the nominal size, not the bore.** `Services/DesignValidationService.cs:141-142`, `Services/PipeSizingSolver.cs:313-314`. UPVC DN100 has a bore of about 104 mm, so capacity is under-stated by about 11 per cent. This errs on the safe side. Test: DN100 UPVC (n 0.010) at 1 in 100 with a bore table entry of 104 mm: about 7.5 L/s, vs 6.7 L/s today.

18. **LOW. CDTWL measures the orifice head to the orifice level, while the orifice equation wants the head to its centre.** Suspected (depends on whether the stored orifice level is the invert). `Services/DetentionTwlService.cs:217-226` vs `Services/OrificeSizer.cs` (`headM` = to centreline). Example: head 0.40 m to the invert, orifice 71 mm, so 0.3645 m to the centre: the plate passes 4.5 per cent less than the permitted discharge, the tank fills higher than designed, and freeboard shrinks. Test: TWL 10.40, orifice invert 10.00, d 71: report head 364 mm (to centre), or say "to invert".

19. **LOW. Casey's formula uses banker's rounding.** `Services/OrificeSizer.cs:65` `Math.Round` with no mode: 54.5 gives 54, 55.5 gives 56. Only exact halves are affected. Test: K 21.9 with inputs that give 54.5 exactly should return 55 (away from zero), if that is Casey's intent.

20. **LOW. The grade label ignores which way the levels fall.** `Services/PipeAnnotationTextFormatter.cs:41` (absolute fall). A pipe whose downstream level is higher reads "1 IN 100" on the drawing; only CDRULES says "flows uphill". Test: ActualGradeLabel(10000, 10.00, 10.10) should say it rises (or warn); today "100".

21. **LOW. The R-03 message can contradict itself after rounding.** `Rules/RulebookEngine.cs:347-351`. 20.04 m over 0.10 m is 1 in 200.4: "actual 1:200 is flatter than the ladder minimum 1:200". Test: expect "1:200.4" (one decimal when it rounds onto the limit).

22. **LOW. CDCALC calculation boxes accept a comma as a thousands mark.** `ViewModels/BoydsCalcViewModel.cs:277-280`, `DetentionCalcViewModel.cs:138-140`, `OrificeCalcViewModel.cs:158-160` (`NumberStyles.Any`, invariant culture). A typo "0,35" in a C box reads as 35 and is then clamped to 1.0. Test: Parse("0,35") should be rejected or warned.

23. **LOW. The CDDESIGN window shows the council's soft C, not the one used.** `ViewModels/CivilDesignWindowViewModel.cs:741-744` shows Glen Eira 0.35; the calculation uses Settings 0.30 (`Services/CivilDesignService.cs:156`). The printed summary is right (`Services/DesignProposalReport.cs:118`). Test: the window line reads "0.30 (Settings; council records 0.35)".

24. **LOW. The storm sweep includes storms shorter than the council's Tc.** `Services/DetentionSizingService.cs:131`: Darebin Tc is 10 min, but the 5-min storm is still worked. This errs on the safe side. Test: Darebin job, first row 10 min.

25. **LOW. Minimum grade ladder: odd values, and two readers.** `Models/UserSettings.cs:1920-1924` has 375 at 1 in 300 but 450-750 at 1 in 200. The solver looks up the exact size only (`Services/PipeSizingSolver.cs:422-437`); CDRULES falls back to the next size up (`Rules/RulebookValues.cs:337-358`). A DN250 gets no minimum in the solver and 1 in 250 in CDRULES. Test: DN250 in both, same minimum.

26. **LOW. Sizing defaults ignore your 300 mm cover.** `Services/SettingsSizingStandards.cs:91-99` builds standards with 600 mm cover and 6.0 m/s (used by CDDESIGN's connection pipe and `PipeSizingStandards.CreateDefault`). The connection pipe has no ground levels, so cover is not checked there today. It would matter the day ground levels are passed. Test: CreateDefault().MinCoverMm equals Settings `minimumCoverDepth`.

27. **LOW. A drawing with UNITS not set is read as millimetres.** `Services/PipeGeometryHelper.cs:150-153`. A unitless drawing drawn in metres makes every pipe 1,000 times short: grades read near-vertical, R-03 passes and R-01 warns on everything. Survey reading already has a metre-site guess (BUG-705); the rules do not. Test: unitless record with pits 20 units apart and 6-digit coordinates should read 20 m (or say Unknown).

28. **LOW. The self-cleansing check uses full-bore speed.** `Rules/RulebookEngine.cs:415`, `Services/PipeSizingSolver.cs:256`. This is accepted practice, but at low flow the real speed is below full-bore, so "0.6 m/s met" is optimistic for lightly loaded pipes. Information only; no change recommended without your ruling.

---

## Checked and found sound

1. **Orifice equation** `Services/Hydraulics.cs:53-90`: Q = Co·A·√(2gh), mm/m/L conversions right. Round-down to whole mm (`OrificeSizer.cs`, your CR-A3) is the safe direction for discharge.
2. **Boyd's storage formula** `Services/DetentionSizingService.cs:136-140`: identical to the two issued Glen Eira sheets.
3. **Rational method units** C·I·A/0.36 (L/s, ha) and /360 (m3/s): right everywhere I looked.
4. **Part-full pipe storage** `Rules/DetentionStorageMath.cs:28-45`: correct circular-segment area; graded barrel stepped in 200 slices.
5. **CD calculated levels** `Helpers/MathHelper.cs:296-323`: drop rounded UP, so never flatter than the chosen grade (contrast Finding 6).
6. **Levels proposal** `Services/Proposals/LevelsProposalEngine.cs:685-725`: upstream level rounded up, never flatter than the minimum grade.
7. **Number reading on stored levels**: invariant culture first, current culture second, everywhere checked; levels are written with invariant culture.
8. **Unknown stays Unknown**: no permitted discharge gives no storage and no orifice (`DetentionSizingService.cs:102-114`); no volume prints "NOT SET", never 0.00 (`Rules/DetentionVolumeRequired.cs`).
9. **No hard blocks** in any engineering rule read: every rule warns or says Unknown (R-27).

---

## Summary

The core hydraulics (Manning, orifice, Boyd's, rational method) is correct. The risks are in the inputs and the joins between screens. Three HIGH: CDCHECKS measures pipes pit to pit instead of along the route; the network solver treats every pipe as UPVC; and the office rainfall curve is labelled "high" when, on real Glen Eira jobs, it reads 6 to 8 per cent low, which leaves storage about 18 per cent short. The red GE 24-115 test is out of date (2024 discharge storm, soft C and site rainfall), not wrong engineering: fix the fixture, keep the 30 per cent band. Thirteen MEDIUM: mainly cover (pipe wall, between pits), rounding after a pit move, disagreeing screens, pit depth versus floor, CDTWL volumes, and engineering numbers still in code.
