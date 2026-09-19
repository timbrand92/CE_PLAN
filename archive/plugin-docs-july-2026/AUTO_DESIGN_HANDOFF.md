# Auto-Design — New-Session Handoff Prompt

Paste the block below into a fresh Claude Code session opened in `C:\Lisp Files\CE_CVL_SUITE`.
*(Rewritten 2026-06-12 mid-gate-test — supersedes all earlier versions.)*

---

```
Continuing the CE_CVL_SUITE AUTO-DESIGN + AUTO-DRAFT initiative (Tim's AutoCAD stormwater plugin).
GOAL v3.0: ~90% autonomous DESIGN + DRAFT of single-lot stormwater — Tim does setup + sign-off; engine
designs (PROVEN) and drafts to the office's own standards (in progress). Tim is a VISUAL learner, not a
coder — short tables, exact click-by-click steps, no jargon, no walls of text.

READ FIRST: memories project_ssr_backtest_calibration (master log), project_engineer_answers (ALL
answered + the 0.35 STANDING HOLD), reference_gold_standard_drawings, feedback_bump_build_number_each_deploy
(3-PART scheme NEW), feedback_visual_learner, feedback_prove_accuracy_before_auto, regression_dbtext_dtext_doubleclick
(read BEFORE touching reactors); docs: PROJECT_STATE.md (top entries), REGRESSION_LOG.md (2026-06-12
GATE-TEST BATCH — has the OPEN BLOCKER), GOLD_STANDARD_DRAWINGS_SPEC.md (31 reqs ORIF/SPS/SHEET),
EVIDENCE_REPLICATION.md, ENGINEER_QUESTIONS_PENDING.md (all answered + Q23 hold).

STATE (all COMMITTED+PUSHED to master; suite ~1850 pass / 5 pre-existing ForkPit env-fails / 39 skip;
exclude ForkPit_*/IsWorldUcs_*; build net48 + net10.0-windows, -p:SkipDevBundle=true when AC open, NOT net8):
✅ DESIGN BRAIN PROVEN: ReplicationEvidenceTests = 14 real Kingston jobs through AutoDesignOrchestrator
   from inputs only, TWICE: PSD exact 14/14, SSR +12..19% never undersized, orifice ≤7mm 13/14,
   run-to-run byte-identical. Re-run: dotnet test --filter ReplicationEvidence -p:SkipDevBundle=true.
✅ Rulebook FINAL: zero engineer questions open. Kingston unfrozen (PSD 1-in-5, preDevC 0.4, 5-min Tc
   <1000m², basement policy v2.0 rules incl. council APEX LEVEL for ramps). Manningham orificeMin 40mm +
   OSD-guideline rules (in-situ baffle no plates, head = top-of-baffle→orifice centre, chambers by baffle
   height, reuse eligibility ENFORCED ≥2000L/≥50m²/toilets-only). Glen Eira minUnderground 50% soft.
   ⚠ STANDING HOLD: pre-dev C = 0.35 all / Kingston 0.4 — DO NOT change unless Tim EXPLICITLY confirms
   (he flip-flopped once; gate held). Office Boyd's templates fixed to match (backups alongside).
✅ XrefSiteGeometryService: boundary 16/17 real jobs ≤0.2% (chain-closer 5/50/250mm), TPZ/easements/
   driveway; roof BIMODAL → IsRoofReadable self-detection — NEVER consume RoofUnionM2 when false.
✅ AutoDesignOrchestrator (beta 4): DesignInputs → archetype refuse-gate → solvers (+pump/soakage/reuse-
   credit informational) → NetworkDesign → LongSection bridge → DetailSelector → DesignPackage.
✅ Drafter HARDENED by Tim's reviews: AssignMissingHandles (incl. insert ATTRIBs!) + DXF-roundtrip
   normalisation + 2 hard gates (zero-handle, entity-count drop); council note ADDED never substituted;
   TextStyle fonts seeded (ARIALN.TTF — update-in-place when name exists); .dwg = AutoCAD-verified output
   (.dxf flavor REJECTED by AutoCAD: "group code 94"); 3 evidence DWGs plot to PDF via headless
   accoreconsole (proven /isolate + setenv PrinterConfigDir + -PLOT script; works with Tim's AC open).
✅ GOLD-STANDARD SPEC mined from Tim's 4 reference jobs (W26-26 detail IS to scale — 5×, DIMLFAC 0.2,
   graded floor, 4 pipe penetrations; 25-15 SPS 9-level RL ladder; CG26-02/MJS26-03 sheets) →
   docs/GOLD_STANDARD_DRAWINGS_SPEC.md: ORIF-1..19, SPS-1..6, SHEET-1..6.

🔶 IN FLIGHT — THE GATE TEST (PL-072 + R15, Tim's AutoCAD session; unlocks CDAUTODESIGN deploys):
- Tim ran it on v2.1.0.2. FIXED same-day (deployed v2.1.0.3): A1 Cxx/Sxx filename discipline
  (C01=Civil/S01=Structural, DrawingDisciplinePolicy, lookaround regex); A2 keyword prompt showed
  "Yes/CE" — the literal "[CE]" in the GetKeywords message was parsed as a keyword (never put [..] in
  prompt text); BONUS LoggingService.Diagnostic crash outside AutoCAD (JIT of EchoDiagnostic loads
  accoremgd at the CALL site — guarded with one-shot latch).
- ⚠ OPEN BLOCKER B (REGRESSION_LOG 2026-06-12): fresh session + window-select whole drainage system +
  MOVE @10000,0 → EVERYTHING reverts (single-pit move works). Evidence: Tim's drawing is a renamed COPY →
  filename-keyed project JSON missing → recovery/sync ([PitRestore] 9 pits / [PipeRestore] 49 pipes)
  + ~40 MLINEs erased+recreated in 2 bursts mid-MOVE → native command aborted/rolled back. debugLogging
  is NOW ON (CD_Settings.json, backup alongside) — Tim was asked to rerun B1 once on v2.1.0.3 to capture
  the DEBUG trail in %APPDATA%\CE_CVL_SUITE\logs\CE_CVL_SUITE.log. NEXT SESSION: read that log tail,
  fix (likely: defer recovery/MLINE refresh while a native command is in progress), validate with the
  headless harness (scripts\Run-HeadlessTests.ps1 pattern), deploy, Tim re-gates. CAUTION: reactor
  minefield — read regression_dbtext_dtext_doubleclick memory first.

VERSIONING (NEW, Tim 2026-06-12): THREE-part <Version> in CE_CVL_SUITE.csproj — currently 2.1.3 staged
for the NEXT deploy. Bump the LAST digit +1 before EVERY dev-bundle deploy (status pane shows
Major.Minor.Build; the old 4-part bumped an invisible digit). Deploy = close AC → build net10 + net48
WITHOUT SkipDevBundle → verify %APPDATA%\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle DLL versions →
tell Tim the number to check in the status bar.

BUILD QUEUE AFTER THE GATE (in order):
  (G) Fix open blocker B + Tim re-gates → GATE GREEN.
  (1) Parametric orifice-pit detail generator to ORIF-1..19 (upgrade OrificeDetailGenerator: to-scale 5×,
      ALL connecting pipes at their ILs incl. end-on circles, graded/benched floor, baffle to TWL,
      DIMLFAC-0.2 dims, ARIALN text). PROOF: regenerate W26-26's own detail from its job data →
      side-by-side PDF vs the office original (same evidence method as the calcs).
  (2) Beta piece 5 CDAUTODESIGN (AutoCAD-coupled, BUILD+HEADLESS-TEST, deploy only after gate): dialog →
      orchestrator → propose-and-approve preview → draw pits/pipes (PipeCreationService/BlockService,
      placement respecting xref boundary/TPZ no-go) + place details + long-section via existing
      LongitudinalSectionService + calc summary.
  (3) Piece 7 SPS drafter (SPS-1..6) + DetailSheetComposer (SHEET-1..6, office border/title block).
  (4) Piece 6 headless R15/PL-072 scenarios; (5) piece 8 ribbon; (6) beta trial on 2-3 real jobs.

RULES (mandatory): visual-first for Tim; propose-and-approve; NEVER loosen a tolerance / fake green /
change office ground truth; adversarial review after each build (caught 30+ real bugs so far); archive +
office masters + Drafting standard-details READ-ONLY (drafters work on copies; the ONE authorized
exception was the Boyd's template fix, done); commit+push master freely; bug workflow per
collaboration.md (failing test → fix → REGRESSION_LOG → AC checklist for Tim); one build-workflow at a
time; finish-before-moving-on.

FIRST MOVE: ask Tim if he ran the B1 rerun (debug log ready?) — if yes, read the log and fix blocker B;
if he reports A-fix results too, process them. Keep replies short and visual.
```

---

*Generated 2026-06-12 mid-gate (HEAD 70a835df + version/handoff commit; v2.1.0.3 deployed, 2.1.3 staged).*
