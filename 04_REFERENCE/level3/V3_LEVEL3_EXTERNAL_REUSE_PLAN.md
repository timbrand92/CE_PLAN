# V3 Level 3 — external tools intake and integration plan

**Recorded:** 10 September 2026. **Status:** source assessment and planning integration complete;
runtime implementation, compatibility tests and AutoCAD acceptance remain pending.

**Authority:** Tim requested: “DO WHAT YOU NEED TO IN ORDER TO GET WHAT WOULD BE USEFUL FROM THESE
AND THEN IMPLEMENT IT INTO OUR VERSION 3 LEVEL 3 PLAN, LET ME KNOW IF YOU NEED HELP”. This authorises
the assessment and plan additions below. It does not resolve the existing C6 early-start decision,
approve unseen command behaviour, change engineering rules, or authorise installation/deployment.

This is a supporting intake record under [third-party intake §13.3](CLEAN_SLATE_REBUILD.md),
the [Civil V3 plan](V3_0_PLAN.md) and [C6 build review](workflows/C6_LEVEL3_BUILD_REVIEW.md).
It creates no additional product level, Tool Card approval, release gate owner or control board.
Existing issues #24/#31/#32 retain ownership. C5 still precedes C6 delivery.

## 1. Useful additions to Level 3

```text
Approved survey / current DWG geometry / approved project settings
                              |
       Source identity + revision + units + evidence quality
                              |
       Existing CE measurements, calculations and checks
                              |
     Ranked proposals: what changes, why, and what is uncertain
                              |
           Preview -> deliberate Apply -> one Undo
```

| ID | Added to the plan | Practical result | Existing delivery owner |
|---|---|---|---|
| L3-R1 | Surface evidence attached to proposals | Inspect the ground RL, sampling method, source revision and difference from a surveyed point; gaps/conflicts stay visible. | C5/CV-07 intake feeds C4 review and C6-A/B/C. |
| L3-R2 | Checkable measurement explanations | Compare actual geometry-derived length, fall and grade for alternatives, using the existing CE definitions and calculation engine. | C4/CV-06 and C6-A/B/C; C1 owns pipe-length meaning. |
| L3-R3 | Source/location context and stale-result checks | Locate the affected geometry; identify the source revision and optional chainage/offset; request re-check when its inputs change. | C1 identity, C5 source mapping, C4 impact review, C6-A/B/E. |

These are refinements of existing proposal/evidence workflows. They do not promise a new surface modeller,
survey design suite, Revit connector, hydraulic engine or separate review window.

## 2. Exact external evidence examined

The assessment read source, selected tests, project references and licences; it did not execute any
downloaded code. Dates below are the inspected default-branch head commit dates, not claims about all
repository activity or product support. No third-party code, DLLs, sample drawings or packages were copied
into CE. Pinned links preserve the reference even when upstream changes.

| Source | Pinned revision / date | Licence observed | Intake decision |
|---|---|---|---|
| [CivilSurveySuite](https://github.com/puppetsw/CivilSurveySuite/tree/c2e33c27693e96090cdf5118aba50f756679a823) | `c2e33c27693e96090cdf5118aba50f756679a823` / 2025-02-23 | [MIT; Scott Whitney](https://github.com/puppetsw/CivilSurveySuite/blob/c2e33c27693e96090cdf5118aba50f756679a823/LICENSE.md) | Adapt reporting ideas into existing CE services. No package dependency selected. |
| [CivilConnection](https://github.com/Autodesk/civilconnection/tree/2df726736f4abb203e6b1d66660eb899cb9255e1) | `2df726736f4abb203e6b1d66660eb899cb9255e1` / 2022-12-01 | [Apache-2.0; Autodesk](https://github.com/Autodesk/civilconnection/blob/2df726736f4abb203e6b1d66660eb899cb9255e1/LICENSING.md) | Reference for location/coordinate context. Revit exchange deferred. |
| [C3D-AutoCAD](https://github.com/mf4633/C3D-AutoCAD/tree/72dc925da13d2ed7bc87ab8acac966cc5a129970) | `72dc925da13d2ed7bc87ab8acac966cc5a129970` / 2026-09-03 | [MIT; Michael Flynn](https://github.com/mf4633/C3D-AutoCAD/blob/72dc925da13d2ed7bc87ab8acac966cc5a129970/LICENSE) | Adapt measurement presentation and adverse test examples. No LISP auto-loader. |
| [C3D-Utils](https://github.com/thelegendofbrian/C3D-Utils/tree/377fccc08c72a9bce95e3dffb9ef580ab1caa2fb) | `377fccc08c72a9bce95e3dffb9ef580ab1caa2fb` / 2021-05-24 | [MIT; Brian C.](https://github.com/thelegendofbrian/C3D-Utils/blob/377fccc08c72a9bce95e3dffb9ef580ab1caa2fb/LICENSE) | Do not adopt its QSAVE replacement/archive writer. Existing CE backup ownership remains. |

The supplied [Common Lisp topic page](https://github.com/topics/civil3d?l=common+lisp&o=desc&s=updated)
returned HTTP 429. The fallback [GitHub repository search](https://api.github.com/search/repositories?q=topic%3Acivil3d+language%3A%22Common%20Lisp%22&sort=updated&order=desc&per_page=20)
returned two repositories: C3D-AutoCAD and C3D-Utils. This is discovery evidence, not a claim that the
topic-page contents were rendered or that all Civil 3D repositories were searched.

### Source findings that control reuse

- **CivilSurveySuite:** [report service](https://github.com/puppetsw/CivilSurveySuite/blob/c2e33c27693e96090cdf5118aba50f756679a823/src/CivilSurveySuite.CIVIL/Services/CogoPointSurfaceReportService.cs)
  contains point/surface/chainage-offset columns; these are useful review concepts, although the README
  still labels reporting work unfinished. [SurfaceUtils](https://github.com/puppetsw/CivilSurveySuite/blob/c2e33c27693e96090cdf5118aba50f756679a823/src/CivilSurveySuite.CIVIL/SurfaceUtils.cs)
  returns zero for an out-of-surface query and for a distance-limit failure. Never import that sentinel
  as a real RL. The selected [report test](https://github.com/puppetsw/CivilSurveySuite/blob/c2e33c27693e96090cdf5118aba50f756679a823/tests/3DS_CivilSurveySuiteTests/CogoPointSurfaceReportViewModelTests.cs)
  checks command execution with a mocked service, not numerical surface correctness. Its
  [Civil project](https://github.com/puppetsw/CivilSurveySuite/blob/c2e33c27693e96090cdf5118aba50f756679a823/src/CivilSurveySuite.CIVIL/CivilSurveySuite.CIVIL.csproj)
  targets .NET Framework 4.6.1 and references Civil 3D libraries. It is not a verified modern CE dependency.
- **CivilConnection:** [Featureline](https://github.com/Autodesk/civilconnection/blob/2df726736f4abb203e6b1d66660eb899cb9255e1/Src/CivilConnection/2020/Autodesk2020/Featureline.cs)
  exposes station/offset/elevation and local coordinate frames. Borrow the explicit reference-frame idea;
  it does not prove CE drainage connectivity. Its [project](https://github.com/Autodesk/civilconnection/blob/2df726736f4abb203e6b1d66660eb899cb9255e1/Src/CivilConnection/2020/Autodesk2020/Autodesk2020.csproj)
  includes release-specific Civil 3D, Dynamo and Revit references. Its
  [README](https://github.com/Autodesk/civilconnection/blob/2df726736f4abb203e6b1d66660eb899cb9255e1/README.md)
  requires matching releases and describes disabled Python execution for newer CivilPython versions.
  No compatibility claim is made for CE's AutoCAD 2022–2027 lanes.
- **C3D-AutoCAD:** [slope](https://github.com/mf4633/C3D-AutoCAD/blob/72dc925da13d2ed7bc87ab8acac966cc5a129970/slope.lsp)
  reports percent/ratio, but zero horizontal run can be displayed as flat. CE must distinguish vertical,
  coincident and flat geometry. [Total length](https://github.com/mf4633/C3D-AutoCAD/blob/72dc925da13d2ed7bc87ab8acac966cc5a129970/totallength.lsp)
  measures curves but uses an imperial conversion and can omit failed measurements silently.
  [Bearing tables](https://github.com/mf4633/C3D-AutoCAD/blob/72dc925da13d2ed7bc87ab8acac966cc5a129970/bdtbl.lsp)
  pair chord bearings with arc lengths; that distinction must remain explicit.
  [CENTROID](https://github.com/mf4633/C3D-AutoCAD/blob/72dc925da13d2ed7bc87ab8acac966cc5a129970/centroid.lsp)
  uses the bounding-box centre, and [layer restore](https://github.com/mf4633/C3D-AutoCAD/blob/72dc925da13d2ed7bc87ab8acac966cc5a129970/layuniso.lsp)
  turns on/thaws all layers. Neither behaviour is adopted. Static TEXT creation does not establish
  linked-label updating. No automated test paths were identified in the inspected tree; code was not run.
- **C3D-Utils:** [archive-on-save](https://github.com/thelegendofbrian/C3D-Utils/blob/377fccc08c72a9bce95e3dffb9ef580ab1caa2fb/src/archive-on-save.lsp)
  replaces QSAVE and copies DWGs into an Archive folder. This would introduce another save/backup owner
  alongside the duplication already recorded in CE's master plan §6.11. Excluded from Level 3.

Before any future code copying, record the exact files, revisions, modifications and required notices
through §13.3; retain the applicable licence/attribution and check any bundled dependencies separately.
Licence identification alone is not code-quality or dependency approval. Security review here was bounded
to the selected paths; there was no whole-repository security audit, build or execution.

## 3. Existing CE capability comes first

Local inspection baseline: branch `codex/CIVIL3RESEARCH`, HEAD
`d017d506186729afbac9b97a050cc91c3ce8cfb8`, plus existing uncommitted planning work.
This is not the live-installation identity. Recheck the current integration branch before runtime work.

| CE source already present | What to retain / extend |
|---|---|
| [SurveyService](../Modules/Drainage/Services/SurveyService.cs), [SurveyData](../Modules/Drainage/Models/SurveyData.cs), [SurveyIntakeSanityService](../Modules/Drainage/Services/SurveyIntakeSanityService.cs) | Existing survey reading, triangle sampling, transforms and sanity checks. Extend their evidence output; no competing surface engine. |
| [NetworkDesignService](../Modules/Drainage/Services/NetworkDesignService.cs), [PipeGradeAdvisorService](../Modules/Drainage/Services/PipeGradeAdvisorService.cs) | Existing engineering calculations; external routines must not determine design values or compliance. |
| [ChangePlan](../Modules/Drainage/Models/ChangePlan.cs), [ProposalPreviewViewModel](../Modules/Drainage/ViewModels/ProposalPreviewViewModel.cs) | Existing change records and preview. Extend only after checking the current shared contract and preserving controls. |
| [DesignImpactSnapshotProjector](../Modules/Drainage/Services/DesignImpactSnapshotProjector.cs), [DesignImpactProposalGuard](../Modules/Drainage/Services/DesignImpactProposalGuard.cs) | Existing snapshot/changed-input checks. Include relevant evidence dependencies through this authority. |
| [ProposalApplyService](../Modules/Drainage/Services/ProposalApplyService.cs) | Reuse approved writers only after proving whole-proposal recovery and Undo. The inspected implementation can skip targets and calls pipe/pit writers separately; comments are not proof of atomic Apply. |

In this checkout, `TryGetRlAtPoint` distinguishes failure with a Boolean, but can return a nearest-spot
fallback as success with a source description. L3-R1 must retain that method/source distinction rather
than treating all successful samples as equally reliable. This is an integration requirement, not
permission to change the current CDSURVEY behaviour in isolation.

## 4. Level 3 work contracts

### L3-R1 — show the evidence behind a ground level

**Classification:** Keep + Modify existing survey/review workflow. **Priority:** first.

- Inputs: selected CE scope, admitted survey snapshot, source identity/revision, XY transform, horizontal
  units, vertical units/datum and existing quality findings. DWG geometry remains authoritative under D9.
- Output: sample location, ground RL if available, sampling method, source identity, revision, quality and
  any source-point difference. Report `point RL minus surface RL` with a stated sign; this is not earthworks volume.
- A real RL 0 remains valid when supported. Missing/outside-surface/invalid data stays Unknown. Distinguish
  TIN interpolation, nearest-spot evidence and any separately approved extrapolation. Do not invent a distance
  tolerance, datum conversion or survey-authority rule. Carry existing approved Settings and expose unresolved rules.
- Existing/fixed or manually approved levels are not overwritten by a comparison. Source disagreement is
  shown beside the override. Missing evidence can support a warning/explanation, never a fabricated engineering Pass.
- C6 consumes C5 evidence. Live COGO/TIN extraction is optional future adapter work requiring its own
  Civil 3D compatibility check; ordinary AutoCAD must still work with admitted CE survey data.

### L3-R2 — explain alternatives with measurements

**Classification:** Keep + Modify existing proposal explanation. **Priority:** second.

- Show current/proposed centreline geometry, explicitly named length measure, elevation difference and
  grade from existing CE authorities. Respect D1's six pipe-length definitions; a generic curve length
  cannot substitute for every hydraulic or scheduled length.
- Use metric/project units and the approved rounding policy. Keep raw calculation precision until display.
  Direction is explicit; never lose the sign of fall by formatting a positive ratio.
- Flat, vertical, coincident, unsupported and incomplete inputs are distinct. A partial selection total
  must list exclusions and cannot masquerade as a complete total. Unknown units must be resolved.
- Examples describe geometry, not hydraulic approval. Rank using C6's reviewed criteria, expose trade-offs
  and explain unavailable comparisons; no invented weights, acceptance thresholds or historical confidence.
- Standalone slope labels, quantity commands and bearing-table placement remain later workflow candidates.
  No extra command aliases or label ownership model are added by this plan.

### L3-R3 — retain location and revision context

**Classification:** Keep + Modify existing source/impact records. **Priority:** third, sharing R1/R2 data.

- Retain drawing identity + CE object identity + source revision + transformation/units/datum + relevant
  settings/rulebook version in the existing snapshot contract. An object handle alone is not globally unique.
- Where an admitted reference alignment exists, show optional chainage, signed offset and reference name.
  In ordinary AutoCAD, use the current approved CE geometry reference; absence is explicitly unavailable.
  Chainage direction/origin/equations require a defined contract before that display is activated.
- Source, geometry or relevant settings changes invalidate affected evidence/proposals through the existing
  stale check. Renaming a display label must not create a new engineering identity. Never infer connectivity
  from nearest alignment, equal chainage, crossing or proximity.
- Read-only Ask CE consumes the same frozen records subject to DATA-01/AI-01. It neither regenerates drawing
  records nor exposes CivilConnection command strings, Python, LISP, terminals or a new external connection.

### Shared user experience and acceptance boundary

Use the existing Review/Proposals entry points and approved C5 intake routes. Scope is explicit; opening
and reading do not mutate the DWG. Click a finding to locate/highlight its object. Preview shows values,
sources, changed dependencies and warnings. Apply goes through the existing approved writer after revalidation;
selection is not approval. Cancel/Escape clears temporary work; one accepted single-DWG proposal is one Undo,
including geometry, labels and CE records. Reopening requires current-evidence checks.

Keep locked layers, XREFs, REFEDIT and unsupported content protected. Preserve current warn-and-record
engineering policy and distinguish warnings from missing permissions/stale writes; this record adds no
blanket engineering blocks. Use bounded cancellable snapshots and existing PD-01 budgets, with no full scan
on cursor movement or network dependency during drafting. Use CE assets and existing unit/rounding helpers.

## 5. Delivery order and completion checks

| Slice | Purpose / dependency | Completion check | Effort forecast | Status |
|---|---|---|---|---|
| Intake | Pin sources, assess defects/licences/overlap and update Level 3 plan. | References and existing-work preservation checked. | This task: 15–25 minutes forecast. | Planning integrated; checks recorded in REGRESSION_LOG. |
| Contract extension | R1–R3 fields in existing C5/C4/C6 records; current branch and owner confirmed first. | Missing/assumed/stale states and current CE service mappings reviewed; exact workflow delta approved. | 0.5–1 day | Pending existing C6 start/ownership decision. |
| Evidence + explanation | R1/R2/R3, after contract and required C5 inputs. | Synthetic numerical, units, provenance and stale checks pass; no provider/drawing writes. | 1–2 days | Planned within C6-A/B; no early-start exception inferred. |
| Integration | Current C4 preview and C6 writers, after C1–C5 readiness. | Protections, all-or-nothing recovery, Undo and performance proven before acceptance. | 1–2 days | Planned within C6-B/C/E. |
| Acceptance | Existing exact-build release lane and consolidated sample. | Tim confirms representative AutoCAD experience. | One targeted session, aim ≤10 minutes. | Pending implementation/deployment. |

Implementation estimate: **2.5–5 focused working days for these refinements**, low confidence, excluding
prerequisite fixes, review and release work. It overlaps the existing C6 5–10-day estimate; do not add the
two blindly or claim a revised whole-project finish date. Recommend one implementer; shared contracts and
writers make parallel work low value. Re-estimate after current-branch interface checks. Existing ownership
remains Claude for behaviour/spine/deployment and Codex for windows unless Tim changes it.

## 6. Automated evidence and one representative AutoCAD check

These are future test requirements, not tests run in this planning task. Use invented local coordinates
and approved synthetic fixtures; no client drawings or third-party sample DWGs are admitted by this record.

| Guard | Synthetic example | Expected result |
|---|---|---|
| Surface sample and difference | Triangle vertices `(0,0,10)`, `(10,0,11)`, `(0,10,12)` metres; query `(2,3)`, point RL `10.820`. | Surface RL `10.800`; point-minus-surface `+0.020 m`, with source/method. |
| No false zero / hidden extrapolation | Outside triangle, valid zero-level surface, nearest spot, conflicting survey revision. | Unknown differs from valid RL 0; fallback/conflict identified explicitly. |
| Grade explanation | Horizontal run `12 m`, downstream fall `0.120 m`; alternative `15 m` with same fall. | `1.00% / 1:100` versus `0.80% / 1:125`, plus direction; no inferred compliance or ranking. |
| Geometry/units boundaries | Reversed endpoints, zero run, coincident points, arc vs chord, m/mm inputs, rotated UCS, unsupported curve. | Correct signed quantities or explicit unavailable state; convert once; exclusions visible. |
| Revision/identity | Same handle in two DWGs; source geometry/settings changed; only display name changed. | No cross-DWG identity collision; affected preview stale; stable identity retained. |
| Reversibility/protection | Cancel, protected/XREF object, failed second write, save/reopen. | No comparison write; protected content untouched; failure cannot leave a successful partial proposal; one Undo restores accepted change. |

Fold these into C5/C6's existing acceptance package: inspect a valid sample and an Unknown sample; check
the two grade alternatives and their sources; locate the affected object; Cancel; Apply one approved change
and Undo; change the source and verify stale advice; save/reopen. Automate numerical/failure/protection
cases first. Tim's remaining role is representative visual and interactive acceptance, not a separate
manual run for every table row.

## 7. Deferred and excluded items

- **Deferred:** Civil 3D–Revit exchange, corridor-driven structures and live Civil 3D adapters. Require a real
  office use case, supported product matrix and separate approved workflow; none blocks Level 3.
- **Deferred:** new bearing-distance tables, linked survey labels, area/length commands, text utilities and
  PDF publishing. Assess against current CE/native AutoCAD capability when that workflow is next reviewed.
- **Excluded from adoption:** external DLLs/auto-loaders, arbitrary code execution, native QSAVE replacement,
  duplicate backup machinery, blanket layer restore, flatten/explode workarounds, false-zero surface values,
  and bounding-box centres presented as engineering centroids.
- **Open only at implementation:** precise sampling/chainage contracts if not already approved, workflow
  deltas, current integration owner and existing early-start decision. No help from Tim is needed to finish
  this assessment and plan update. None of these records marks C5/C6 installed or AutoCAD-accepted.

## 8. Second intake — Civil, Structural and Manager resources

**Request / date:** Tim repeated the instruction to assess and incorporate useful resources into the
V3 Level 3 plan on 10 September 2026, after the SWMM / NetTopologySuite / sectionproperties / PyNite /
ClrMD / OpenTelemetry / Autodesk shortlist. This section extends R1–R3; it does not replace them.

**Result:** six bounded work items added to the plan. Reference assessment is complete; software trials,
implementation and AutoCAD acceptance remain pending. No new dependency, executable, Python environment,
crash attachment, network exporter or service was installed, downloaded to the workspace or enabled.
Source text was read remotely. No client drawings, corpus or real crash dumps were inspected.

### 8.1. What each module gains

| ID | Useful work added | AutoCAD/engineering benefit | Placement and disposition |
|---|---|---|---|
| L3-R4 | Extend existing NetTopologySuite geometry checks | Explain overlapping, invalid or incomplete catchment/site boundaries before using their area in a proposal. | C4/C5 evidence → C6. Keep existing library and reviewed geometry paths; Modify evidence where needed. |
| L3-R5 | Independent section-property benchmarks | Check area, centroid and bending properties against known answers before CE cites section results. | Structural ST-07 calculation evidence / TH-01; offline trial using sectionproperties. Missing comparison evidence, not permission to replace the calculation authority. |
| L3-R6 | Independent beam-analysis benchmarks | Check reactions, shear, moments and deflection; separate a plausible drawn beam position from a verified structural calculation. | Structural ST-07 / TH-01; offline PyNite trial. Any live analysis or sizing is a separately reviewed workflow. |
| L3-R7 | Timed operation records using OpenTelemetry concepts | A support report can show which CE operation or phase slowed down or failed. | Manager PD-01 / SUP-2/3/6. Keep current logging/correlation; Modify evidence gaps. An SDK dependency is trial-only. |
| L3-R8 | Optional isolated ClrMD dump analysis | Support staff can inspect available managed-code evidence when ordinary logs do not explain a failure. | Manager SUP-3/4; conditional external diagnostic trial. Not required for useful basic support or normal drafting. |
| L3-R9 | SWMM comparison specification and later offline trial | Investigate selected hydraulic examples with an independent model and show why results agree or differ. | CV-02/C4 evidence research supporting later C6 explanations; dynamic storm simulation remains deferred. |

Manager remains the independent M1 workstream required before S3; it does not wait for C6. Structural
items feed the existing Structural adoption/pilot route and do not expand the current Civil release into
a structural solver. R9 and optional dump analysis are not new blockers for Civil Level 3 release.
Autodesk's official guidance supports all relevant implementation reviews without adding another module.

### 8.2. Source register and intake findings

Inspected on 10 September 2026. A pinned development-head revision is a research reference, not a
selected production package. Match future trials to an explicit released version and record its package
hash, dependencies and licence notices. No upstream test suite was executed.

| Source / pinned revision | Observed licence / environment | Evidence and decision |
|---|---|---|
| [SWMM](https://github.com/USEPA/Stormwater-Management-Model/tree/07c371f8a0d477da1d9d4e7c0d75719664f62fec), `07c371f8a0d477da1d9d4e7c0d75719664f62fec`, 2025-02-23 | Official README describes solver C source as public domain; do not assume that covers every bundled component or document. | [Solver interface](https://github.com/USEPA/Stormwater-Management-Model/blob/07c371f8a0d477da1d9d4e7c0d75719664f62fec/src/solver/swmm5.c) exposes error/warning and mass-balance information. [Test guide](https://github.com/USEPA/Stormwater-Management-Model/blob/07c371f8a0d477da1d9d4e7c0d75719664f62fec/tests/Unit_Testing.md) and [EPA manuals/capabilities](https://www.epa.gov/water-research/storm-water-management-model-swmm) inform a bounded comparison trial. No solver bundled into CE. |
| [NetTopologySuite 2.6.0](https://github.com/NetTopologySuite/NetTopologySuite/tree/97d26b92586448b52d5a4f0c060217f94f882c75), `97d26b92586448b52d5a4f0c060217f94f882c75`, 2025-03-12 | [Project](https://github.com/NetTopologySuite/NetTopologySuite/blob/97d26b92586448b52d5a4f0c060217f94f882c75/src/NetTopologySuite/NetTopologySuite.csproj) declares BSD-3-Clause, netstandard2.0/2.1; [licence file](https://github.com/NetTopologySuite/NetTopologySuite/blob/97d26b92586448b52d5a4f0c060217f94f882c75/License.md) includes derivative/third-party notices. | Existing CE dependency. [IsValidOp](https://github.com/NetTopologySuite/NetTopologySuite/blob/97d26b92586448b52d5a4f0c060217f94f882c75/src/NetTopologySuite/Operation/Valid/IsValidOp.cs) supplies validity/error evidence. Reuse the 2.6.0 pin; no version upgrade selected. Latest development head was also identified, but is not the CE trial baseline. |
| [sectionproperties](https://github.com/robbievanleeuwen/section-properties/tree/1e12d48b3ccb9ee1b7df8e2ac357c633cc004bdf), `1e12d48b3ccb9ee1b7df8e2ac357c633cc004bdf`, 2026-04-16 | MIT; [project](https://github.com/robbievanleeuwen/section-properties/blob/1e12d48b3ccb9ee1b7df8e2ac357c633cc004bdf/pyproject.toml) requires Python ≥3.11 and numerical/meshing dependencies. | [Section analysis](https://github.com/robbievanleeuwen/section-properties/blob/1e12d48b3ccb9ee1b7df8e2ac357c633cc004bdf/src/sectionproperties/analysis/section.py) distinguishes geometric from material-weighted properties. [Validation documentation](https://sectionproperties.readthedocs.io/en/stable/user_guide/validation.html) provides reference cases. Use as an offline comparator, not a new calculation authority. |
| [PyNite](https://github.com/JWock82/Pynite/tree/120dfadf9ad575cc9764b35957ea1b7eddff12ba), `120dfadf9ad575cc9764b35957ea1b7eddff12ba`, 2026-08-22 | MIT; [project](https://github.com/JWock82/Pynite/blob/120dfadf9ad575cc9764b35957ea1b7eddff12ba/pyproject.toml) requires Python ≥3.11 plus numerical dependencies. | [Continuous-beam tests](https://github.com/JWock82/Pynite/blob/120dfadf9ad575cc9764b35957ea1b7eddff12ba/Testing/test_continuous_beam.py) contain asserted moment examples. Adapt test methodology and independently derived metric cases; do not copy their unit conventions or interpret their checks as AS compliance. |
| [ClrMD](https://github.com/microsoft/clrmd/tree/2b51c3ad21037ba75de78fe4345474e5e0f5c92c), `2b51c3ad21037ba75de78fe4345474e5e0f5c92c`, 2026-09-09 | MIT; [project](https://github.com/microsoft/clrmd/blob/2b51c3ad21037ba75de78fe4345474e5e0f5c92c/src/Microsoft.Diagnostics.Runtime/Microsoft.Diagnostics.Runtime.csproj) targets netstandard2.0/net10.0 and has runtime/client dependencies. | [Secure configuration](https://github.com/microsoft/clrmd/blob/2b51c3ad21037ba75de78fe4345474e5e0f5c92c/SECURE-CONFIGURATION.md) describes native diagnostic-library loading and symbol downloads. Optional analysis must be outside AutoCAD, with explicit attachment access and verified dependencies. Not a native-crash cure or cause detector. |
| [OpenTelemetry .NET](https://github.com/open-telemetry/opentelemetry-dotnet/tree/92806e199b05661cf76a073d4e45370c8f1b4fd0), `92806e199b05661cf76a073d4e45370c8f1b4fd0`, 2026-09-09 | Apache-2.0. [SDK project](https://github.com/open-telemetry/opentelemetry-dotnet/blob/92806e199b05661cf76a073d4e45370c8f1b4fd0/src/OpenTelemetry/OpenTelemetry.csproj) introduces additional configuration/logging dependencies. | [Trace guidance](https://github.com/open-telemetry/opentelemetry-dotnet/blob/92806e199b05661cf76a073d4e45370c8f1b4fd0/docs/trace/README.md) informs operation correlation. [Redaction example](https://github.com/open-telemetry/opentelemetry-dotnet/blob/92806e199b05661cf76a073d4e45370c8f1b4fd0/docs/logs/redaction/README.md) is a simple replacement example, not proof of CE privacy compliance. Prefer adapting the record pattern first. |
| [Autodesk Civil 3D development guidance](https://aps.autodesk.com/developer/overview/civil-3d) and [2026 samples](https://help.autodesk.com/cloudhelp/2026/ENU/Civil3D-DevGuide/files/GUID-DF3E8C70-B59F-44BD-B92F-1091F2509F47.htm) | Official documentation, consulted 2026-09-10; versioned help URL rather than a Git commit. No blanket open-source licence inferred. | Use the guide for the actual host/API version, document/thread ownership and supported operations. Check sample terms before copying. Samples do not override CE's review, privacy or native-protection rules. |

Licence observations are source identification, not a completed legal/security/dependency audit. Preserve
applicable notices for any later copying/distribution. All trial candidates still pass §13.3 and the
existing AutoCAD-version/dependency checks. A new Python runtime or diagnostic package is not silently
added to staff installations.

### 8.3. Current CE integration points — keep one owner

| Inspected CE source | Finding / implication |
|---|---|
| [Drainage project](../Modules/Drainage/CE_CVL_SUITE.csproj), [XrefGeometryMath](../Modules/Drainage/Services/XrefGeometryMath.cs), [XrefSiteGeometryService](../Modules/Drainage/Services/XrefSiteGeometryService.cs) | NTS 2.6.0 already handles site geometry. Helpers use drawing mm and mm²; callers convert. Extend evidence through this owner; do not create a parallel polygon engine or silently change tolerances. |
| [BeamProposalEngine](../Modules/Structural.DesignCore/BeamProposalEngine.cs) | Produces candidate beam lines from geometric rules. It is not a verified beam-force/deflection solver. R5/R6 must not manufacture support/load assumptions from these suggestions. |
| [ST-07 calculation/schedule contract](CARDS/ST-07_SCHEDULES_SHEETS_EXCEL.md) | The reviewed calculation/workbook owns engineering truth; schedules link to exact results. Benchmark reports support this contract and never overwrite schedules or section selections. |
| [CeAdminTelemetryService](../Modules/Manager/Services/CeAdminTelemetryService.cs), [CeRunCorrelationClassifier](../Shared/CE.Diagnostics/CeRunCorrelationClassifier.cs) | Session/operation timing and run/PID/time correlation already exist. Extend them; do not replace the shared classifier with trace IDs or infer a crash from an unfinished trace. |
| [CeSupportBundleService](../Modules/Manager/Services/CeSupportBundleService.cs), [support-readiness contract](workflows/COLLEAGUE_SUPPORT_READINESS_2026-09-09.md) | Current checkout export uses folder candidates and queued bundles. Adding OpenTelemetry or ClrMD alone does not prove the required sanitised support/export behaviour. Existing SUP owners must reconcile current integration evidence before changing it. |

These observations refer to the same local baseline recorded in §3, not the deployed colleague build.
Historical confidence comments and upstream passing tests are not current AutoCAD acceptance evidence.

### 8.4. Work contracts and expected results

**R4 — boundary evidence, first Civil item.** Feed C4/C6 read-only snapshots with boundary identity,
source revision, area/units, holes, overlap relationships and validity findings. Keep approved boundary
selection and geometry tolerances. Show a self-intersection or missing closure; do not silently repair it
with buffering/snapping. Name union area versus the sum of individual areas. Validate finite coordinates,
holes and scale before calculations. NTS is a planar geometry tool: it does not establish drainage
connectivity, infer a receiving pit, prove fall from XY, or validate structural support.

**R5/R6 — Structural benchmark records, before any live analysis.** Use synthetic geometries and
explicit section/material/load/support/release definitions. Record units, axes, analysis type, solver
version, input/output hashes, numerical tolerance and reference answer. Compare raw numbers before display
rounding; store unavailable, incompatible and failed results honestly. Establish tolerances against the
particular calculation, numerical convergence and an independently derived answer, not agreement between
two programs alone. Do not invent material strengths, load factors, restraint or combinations.

R5 starts with homogeneous rectangle properties, then reviewed asymmetric/hollow sections and mesh
convergence. Do not compare material-weighted stiffness with unweighted second moment of area.
R6 starts with linear-elastic simply supported/cantilever examples, then only reviewed continuous-beam
cases. Check equilibrium, sign/local axes, releases and singular/unstable models. Analysis results are not
section capacity, buckling adequacy, connection design or AS/NZS compliance. If no CE calculation exists
for an example, label it a reference benchmark; do not invent an engine just to complete the comparison.
Live member sizing, a structural analysis window and automatic geometry-to-analysis conversion are deferred.

**R7 — Manager operation timeline, highest practical priority.** Retain existing session/run identity,
process identity and exact loaded build; add only missing operation/parent-operation IDs, stable phase,
start/end/duration, outcome and safe failure category. Distinguish cancelled, deferred, failed, completed
and incomplete. Safe phases could describe snapshot, calculation, preview, Apply and support export.
Use existing PD-01 persistence/retention (70 MB / 14 days); timing information may batch at safe points,
while minimum critical evidence follows the existing immediate-write rules.

Reuse current logs before considering an OpenTelemetry SDK. No auto-instrumentation, second log store,
collector, dashboard, cloud exporter or new notification destination is selected. Validate an allow-list
of fields before logging; raw commands, drawing text, paths, credentials and project names are not allowed
by this record. Do not inspect live drawing objects from failure handlers or background callbacks.
Bound queues and retries; logging failure cannot fail a drawing command. Trace completion may be lost
on a hard crash, so the existing exact-run classifier remains authoritative.

**R8 — optional dump analysis, after basic support works.** Use only a separately approved attachment or
synthetic test dump, in an isolated support process outside AutoCAD. No automatic dump capture/upload,
live-process attach, colleague-memory access, new helper script or unattended service is authorised here.
Pin and verify any native diagnostic library; retain its signature protections. Account for required
runtime, architecture and symbol versions, bounded parsing/time/memory and explicit symbol-network policy.
Prefer approved local symbols; a missing dependency yields a partial/unavailable report. Do not disable
verification to make analysis succeed.

Output: dump/report identity, available managed stacks/modules and precise limitations, associated with
the existing support report. Scrub technical output through PD-01 before export. “Managed evidence
unavailable” and “native failure; cause unconfirmed” are legitimate results; ClrMD does not replace a native
debugger or establish causation from the faulting module. Crash correction and prevention remain the
existing SUP-8/RS-01 obligations. Basic offline support export must succeed without a dump.

**R9 — SWMM comparison, later optional research.** First specify the exact question and comparable
physics: geometry, roughness, boundary/tailwater conditions, inflows, units, time stepping and routing.
Begin with an agreed simple conduit/storage example and analytical balance; record solver errors,
warnings, continuity error and sensitivity to time step. A completed process alone is not a valid run.
A dynamic storm hydrograph and a Rational Method peak are not automatically equivalent; a discrepancy
requires explanation, not automatic CE recalibration. Keep D9 DWG authority, CV-02's rulebook/settings and
engineer acceptance. No solver output changes the drawing, sizes pipes, supplies council rainfall or
claims Australian compliance. Full rainfall modelling, storage optimisation and live import/export need
separate reviewed workflows.

**All runtime-facing changes:** retain familiar command routes; use existing Review/Proposals,
Structural calculation links and Manager Support surfaces. Opening reports is read-only; source/result
changes become Stale. No new ribbon, command aliases or automatic drawing writes are introduced.
Any later approved write uses the existing preview/Apply/Cancel/Escape/Undo/save-reopen contract and native
locked-layer/XREF/REFEDIT protections. Missing inputs are named rather than guessed. Exact new prompts,
fields and controls still pass the existing workflow-review gate before runtime code.

### 8.5. Sequencing and effort

| Work slice | Dependency / completion evidence | Estimated focused effort | Status |
|---|---|---|---|
| Source intake and plan wiring | Pinned sources, CE overlap, boundaries, links and preservation verified. | This task: 15–20 minute forecast. | Planning integrated; verification recorded in REGRESSION_LOG. |
| R7 existing-record gap analysis and bounded trial | Current M1/PD-01 implementation; prove useful phase evidence, privacy, retention and no drafting impact. | 0.5–1.5 days | Planned first under existing Manager owner. |
| R4 boundary evidence | Current C4/C5 snapshot contract and reviewed geometry behaviour; pass synthetic validity/area tests. | 0.5–1 day | Planned; C6 consumes accepted upstream evidence. |
| R5/R6 comparison trial | Explicit calculation cases, current Structural calculation owner and approved isolated execution setup. | 1–2 days together | Offline benchmark plan only. |
| R8 optional diagnostic trial | Approved synthetic dump/source, basic support ready, isolated tool/setup decision. | 0.5–1.5 days | Conditional; not a basic-support release dependency. |
| R9 comparison specification/trial | Reviewed common physics/input mapping and agreed question. | 1–2 days for a bounded example | Deferred research; full integration not estimated. |

The first R7/R4/R5/R6 trials total **2–4.5 focused days sequentially**, low confidence, excluding runtime
implementation, prerequisite fixes, deployment and Tim acceptance. That is a trial forecast, not delivery
of six features. It overlaps existing PD-01/C4/C5/Structural work; do not add it blindly to the C6 or R1–R3
estimates. No overall product percentage or completion date is inferred. Use one implementer for the
initial inventory; parallel work is unnecessary until exact independent trial ownership is established.
Existing Claude behaviour/spine/deployment and Codex window ownership remains unchanged.

### 8.6. Test and acceptance additions

The following are test specifications. Only illustrative arithmetic and document checks were verified
in this planning task; no external engine, crash parser or AutoCAD test was run.

| Item | Synthetic check | Expected evidence |
|---|---|---|
| R4 | Two 10 m × 10 m squares overlapping by 5 m × 10 m; a bow-tie boundary; a hole; same shape in mm/m. | Union 150 m² versus individual sum 200 m²; invalid geometry identified; holes/units handled; no automatic geometry repair. |
| R5 | Homogeneous 200 mm × 400 mm rectangle, lower-left origin. | Area 80,000 mm²; centroid (100,200) mm; centroidal horizontal-axis I = 1.066666667 × 10⁹ mm⁴, vertical-axis I = 2.666666667 × 10⁸ mm⁴. |
| R6 | Linear Euler–Bernoulli simply supported beam: L=4,000 mm, uniform w=2 N/mm, E=200,000 N/mm², I=8,000,000 mm⁴. | Reactions 4 kN each; maximum moment 4 kNm; maximum bending deflection magnitude 4.166667 mm. Match load, axes, releases and deformation assumptions before comparison. |
| R7 | Nested operations, cancellation, failed/denied log write, queue limit, two AutoCAD process identities, unended operation. | Correct ordering/association; no raw client fields; bounded impact; unended operation alone is not a confirmed crash. |
| R8 | Synthetic valid/truncated dump, missing or wrong runtime/symbols, denied network, wrong-session attachment. | Bounded failure or explicit partial result; no AutoCAD attach; no incorrect correlation or automatic upload. |
| R9 | Equivalent steady test and storage balance plus invalid input and time-step variation. | Boundary conditions/assumptions recorded; warnings, continuity and convergence examined; failed/incomparable runs never count as agreement. |

Reuse existing test projects and approved test machinery; no new helper/build/deploy scripts. Reference
reports retain calculation versions and provenance through ST-07/QA-01, with no automatic office-learning
promotion. Any future build/test keeps the mandatory safety flags and existing release lane.

For Tim, consolidate into existing acceptance: Civil shows one invalid boundary and a correct area;
Structural opens a benchmark/calculation link with explicit assumptions and no silent schedule change;
Manager exports one useful, sanitised operation timeline while drafting remains responsive. Only add
these checks when their changes are implemented, then use the existing Cancel/Undo/stale/reopen exercise
where applicable. R8/R9 offline research adds no routine manual AutoCAD burden or deliberate crash test.

### 8.7. What remains parked

Live structural solving/sizing, a SWMM design interface, automated dump collection, cloud telemetry,
new support destinations and replacing Manager's updater remain outside this intake. No sample source
approves a new engineering threshold or relaxes DATA-01. No help from Tim is needed to finish this plan
update; later trials use the existing ownership, workflow and privacy decisions at the appropriate stage.
