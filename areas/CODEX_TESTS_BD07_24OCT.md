# BD07 — Civil tanks, raingardens, downpipes and Blue Factor regression audit — 24 October 2026, Melbourne

## ANSWER FIRST — IN PROGRESS

1. **Four tests passed (focused net10):** BUG-773 two (concave raingarden saved centre, both tracing directions); BUG-967 two (actual Blue Factor PDF extraction and reader, Garden/Lawn excluded from hard area, unknown outlet preserved). Focused result confirmed in TRX: 4 executed, 4 passed, 0 failed, 0 skipped. Full suite and before-fix proof pending.
2. **Draft PR:** [#1725](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1725), branch `cx3/tests-bd07`, head `e14ece596453c3516348f40164114d3ca506fcda`. Base `origin/claude/rel-20261023m` at `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`, fetched first. Own worktree `C:\ce-cx\bd07`.
3. **Builds:** all three Civil Release lanes passed: net48 0 errors / 242 warnings; net8 0 errors / 210 warnings; net10 0 errors / 208 warnings. Focused 4/4 passed; unfiltered full Civil net10 run started at 06:39 Melbourne; before-fix proof remains queued. No zero-test success claimed. Initial C: 21.19 GB free; hard stop below 14 GB.
4. **New findings:** no new reproduced product failure yet. Source residual: BUG-773's saved-number exact-comparison half remains unchanged; its own regression entry explicitly says it was never fixed. No bug status changed.
5. **What Tim sees:** no drawing, window or setting changes. Tests only; no product code, default, version or installed file changed.
6. **Not run:** AutoCAD, accoreconsole, deployment, installer tests, new window pictures or native transform execution. Required builds/full suite and before-fix runs are pending, not passed.

## Coverage audit

1. **Read:** BUG_CARPARK.md, REGRESSION_LOG.md, C-57 assembly report, first-wave BD01/02/03/04 reports and open cx3 PRs #1702/#1703/#1704/#1705/#1723. None covers these four selected scenarios. BD05 report also inspected; BD06 had no report or open PR at the initial check. Rechecked new drafts #1724 (Checks/settings) and #1726 (Structural breaklines), including their bodies and file lists: no overlap with these four scenarios.
2. **BUG-773:** RaingardenAreaCentreTests already checks extra points along a rectangle edge, normal rectangles and survey-coordinate precision. It does not check a concave outline's centre reaching a serialised project row in both tracing directions. Added a 20 m2 L shape with centre (2200,2200) mm; the old corner average is (2666.6667,2666.6667) mm.
3. **BUG-967:** BlueFactorReportTests already checks the ordinary four-row roof/drive/garden/lawn fixture, shortfall notes and Other. RatingReportReaderRegressionTests previously reads roof-only PDFs. Added Garden and Lawn PDF-reader cases with mixed-case surface words and a destination-looking soft-surface name. Only the real roof and paving survive; paving without a named outlet stays Unknown.
4. **Tanks, covered:** BUG-137 has WaterTankRecordTests, WaterTankAtomicPlacementTests and WaterTankWindowContractTests, including blank/zero/negative Base RL. BUG-139 has R3BatchGuardTests and PitSpineRowBackfillSurfaceDrainTests, including WT16. BUG-020 has general tank apply/compound guards, but these do not prove the legacy RISER/DROPPER attribute appearance; that direct native-attribute check remains outside this no-AutoCAD job. BUG-163 is explicitly not reproduced, not a known fixed defect. BUG-040 is retired from CDWT. New locked-layer/Xref findings BUG-1081/1083 are open, outside fixed-bug coverage.
5. **Downpipes, covered:** BUG-281 C5MixedUnitsTests checks stored radius; BUG-695 MillimetresAsDrawingUnitsHuntTests checks metre and millimetre chainage/junction display and end refusal; BUG-815 has detention-rule guards. BUG-859/860 need real pointer/double-click handling and are not newly claimed fixed.
6. **Spoons, covered:** SpoonDrainRunPlanTests checks the repeated-pick admission route for BUG-774. ByLayerColourRoutesTests and current spoon readback guards cover BUG-966. No duplicate cases added. CDRG ByLayer writer/readback also already has RaingardenAtomicPlacementTests.
7. **Blue Factor reader:** BUG-594 already has actual PDF reader/newest-report guards. No duplicate added. Selected BUG-967 tests protect the missing integration between extraction, dispatch and area classification.

## Exact real-AutoCAD check — NOT RUN

1. **Raingarden:** in a disposable millimetre drawing, CDRG outline (0,0), (6000,0), (6000,2000), (2000,2000), (2000,6000), (0,6000); finish and place without optional inlet. Saved area must be 20 m2 and saved position (2200,2200,0) mm. Read the raingardens row in the DWG Named Objects Dictionary CE_CVL_SUITE_PROJECT / PROJECT_DATA (Xrecord text chunks, DXF group 1). Save/reopen and read the same row. Repeat with point order reversed. One U must remove the placement. Keep the existing area-centre switch at its default ON in the disposable profile.
2. **Rating report:** synthetic PDF under the job's Civil/STORM Report - WSUD folder: Blue Factor; Site area 1000 m2; D1 ROOF TO WT1 Roof, 400m2; YARD Paved, 100m2; ROOF TO WT9 Garden, 500m2. First use a fresh synthetic job with site/roof figures not yet recorded. Run CDDESIGN and answer Yes to "Look through this job's folders for its rating report and offer the site and roof areas?". Its offer must print Site area 1000 m2 and Roof and paved area 500 m2; cancel before committing the design. This is the actual BUG-967 consumer (CivilDesignCommand.cs:482, :500, :571). Separately, CDCALC > Catchments > Add from rating report must offer only the roof and paved rows, with YARD outlet Unknown; Cancel adds none. Parsed pervious area is 500 m2. Repeat Garden as Lawn. Use no live job or Tim settings.

## Safety and evidence

1. **Ownership:** two test files and top REGRESSION_LOG.md entry only. Main checkout's unsaved files untouched; no WIP takeover. No edits to BUG_CARPARK.md, DESK_LOG.md, QUEUE.md, protected files or Structural.
2. **Before-fix copies:** own detached worktrees `C:\ce-cx\bd07-pre773` at `70a4e24f` (parent of 04930ee3) and `C:\ce-cx\bd07-pre967` at `40ee0a36` (parent of 39ca847c). Only corresponding new test files copied; product source unmodified.
3. **Safe commands:** every dotnet invocation uses `-p:SkipDevBundle=true -nr:false --disable-build-servers`, C-57 reference paths, process-local TEMP/TMP and log folder beneath TEMP, shared build.lock. Live settings read only for SHA-256 fingerprints. Evidence folder `C:\ce-cx\bd07-evidence`.
4. **Native build limitation:** C-57's zero-byte CE_TRANSFORM_2027.arx placeholder inside ignored worktree output, never installed or executed.
5. **Undo:** revert this branch's tests/log commits. No live setting or installed file needs restoring.

6. **Notion Inbox:** queried all Hub Inbox rows; only an already Processed, unrelated item returned. No New CE instruction to file.

7. **Queue, 04:39 Melbourne:** BD07's current-code runner has waited for the shared build lock since 04:09 and its historical runner since 04:12. No BD07 build or test has started. C: 19.24 GB free at 04:39; both wrappers enforce the 14 GB floor before each launch. Existing runner processes are left alone.


8. **Runtime lane:** all four new cases target net10 only. The raingarden fixture now has the same NET10_0_OR_GREATER guard as the PDF fixture; net48/net8 product builds remain required. The historical raingarden copy has the identical test body before that preprocessor-only guard, so its net10 assertions are unchanged.

9. **Build slot acquired, 05:53 Melbourne:** net48 Civil build started, followed by net8/net10 and the focused four cases. Historical-parent runner remains queued. C: 20.63 GB free at 05:53. No passing build/test result yet.

10. **Builds complete, 06:09 Melbourne:** all three Release builds exited 0. Focused test project is now compiling/running. Three monitored live-settings SHA-256 fingerprints match the pre-build values in a fresh pre-test check; no restore or settings edit performed.

11. **Focused result, 06:12 Melbourne:** console and TRX agree on four executed / four passed / zero failed / zero skipped. Both cases per bug are present. All three monitored settings fingerprints match again after the focused run. Full net10 Civil run queued with reference-picture updates disabled and no filter; product HEAD stays e14ece59 until testing finishes.

12. **Full Civil started, 06:39 Melbourne:** unfiltered net10, --no-build, same compiled e14ece59 source and all mandatory safe flags/references. Reference-picture updates and optional external render-directory overrides are unset. Historical-parent runner remains queued; no full total claimed until the result file exists.
