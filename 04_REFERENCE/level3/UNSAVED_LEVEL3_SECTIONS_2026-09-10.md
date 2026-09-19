# Level 3 sections added 10 Sep 2026 in the unsaved working copy of docs/V3_0_PLAN.md (branch codex/CIVIL3RESEARCH)

Rescued 19 Sep 2026. These 48 lines existed in no commit. Source: git diff HEAD -- docs/V3_0_PLAN.md in C:\Lisp Files\CE_ACAD_PLUGIN.

**For the whole CE product and every questionnaire batch:** [V3 Overall Plan](V3_OVERALL_PLAN.md).
This document remains the current Civil delivery plan; it does not replace the wider approved programme.

**Colleague support gate — Tim, 9 September 2026:** M1/Q1 must include the
[crash evidence and support-readiness checklist](workflows/COLLEAGUE_SUPPORT_READINESS_2026-09-09.md).
It requires exact loaded-versus-installed build evidence, useful sanitised support export,
honest crash correlation, recovery/rollback, automatic serious-failure alerts to Tim's configured destination,
and offline/failure handling through existing PD-01/RS-01 owners. Tim's clarification extends crash-prevention
acceptance to **all shipped CE components and lifecycle/background operations**, not just Civil pipe commands.
This records release requirements, not implementation completion or a change to an interim test candidate.

## 4.1. Level 3 external-tool integration — 10 September 2026

Tim requested assessment of CivilSurveySuite, CivilConnection and the supplied Civil 3D LISP sources,
then incorporation of useful findings into Level 3. The [source assessment and integration plan](V3_LEVEL3_EXTERNAL_REUSE_PLAN.md)
records exact revisions, licence findings, CE overlap, known defects and future acceptance checks.

| Addition | What Level 3 gains | Delivery |
|---|---|---|
| L3-R1 — surface evidence | Ground RL source, method, revision, gaps and conflicts alongside proposals. | C5 intake → C4 review → C6. |
| L3-R2 — measurement explanations | Checkable current/proposed lengths, falls and grades using CE's existing authorities. | C4 and C6-A/B/C. |
| L3-R3 — location/revision context | Locate affected geometry and invalidate advice when its source changes; optional reviewed chainage/offset. | C1/C5 records → C4/C6-A/B/E. |

Planning integration is complete; runtime changes and AutoCAD acceptance are pending. These refine existing
workflows and do not replace DWG authority, C5-before-C6 delivery, approved engineering policy or the command
review gate. Revit exchange and additional standalone drafting tools are deferred. No third-party runtime,
auto-loader, save replacement or second calculation engine is selected. The existing
[C6 build review](workflows/C6_LEVEL3_BUILD_REVIEW.md) retains its start/ownership decisions.

## 4.2. Further Level 3 support — Civil, Structural and Manager

Tim's second 10 September request extends the [external-resource integration plan](V3_LEVEL3_EXTERNAL_REUSE_PLAN.md)
with the following assessed uses. Section 8 of that record contains exact source revisions, existing CE
integration points, trial contracts and acceptance examples.

| Work | Added value | Scope / existing owner |
|---|---|---|
| L3-R4 — existing NetTopologySuite | Clear evidence for invalid/overlapping boundaries and area calculations. | C4/C5 → C6; retain NTS 2.6.0 and current geometry owner. |
| L3-R5/R6 — sectionproperties / PyNite | Independent section and beam reference checks; explicit loads, supports, units and assumptions. | Structural ST-07 / TH-01; offline trials, not a Civil-release structural solver. |
| L3-R7 — OpenTelemetry concepts | Useful operation/phase timings in the existing support evidence. | Manager PD-01/SUP; extend existing logs first, no new exporter selected. |
| L3-R8 — ClrMD | Optional isolated inspection of approved crash evidence. | Manager support trial outside AutoCAD; basic support never requires a dump. |
| L3-R9 — SWMM | Specify and test comparable hydraulic examples against an independent model. | Later CV-02/C4 research; live storm simulation deferred. |

Official Autodesk version-specific guidance supports each implementation. Manager remains independent
M1 work required before S3; Structural follows its existing adoption/pilot route. Optional R8/R9 trials
do not become new blockers for Civil Level 3. These are planning additions, not installed capabilities,
engineering-rule approvals or a change to C5-before-C6. No runtime dependencies or tool setup changed.

