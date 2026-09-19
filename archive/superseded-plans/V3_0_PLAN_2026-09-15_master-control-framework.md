# CE Civil Version 3 — Master Control Framework

**Status:** Active and authoritative
**Updated:** 2026-09-15 — council rulebook (CR) added as an approved addition; see §7 and the
[integration specification](workflows/COUNCIL_RULES_V3_INTEGRATION.md)
**Release target:** Standalone CE Civil plugin ready for normal office use
**Current baseline:** exact source `3b06a61b` is deployed as the bounded Stage 1 grip/twin candidate. Tim's 2026-09-03
field run proves normal pipe creation, corrected twin-pipe text clearance, twin compounding and one-system scheduling.
It also proves two failures: Civil Slide / Offset / Flip markers are absent, and none of the two visible polylines or
two MLINEs transfers selection to the dashed centreline. A source correction is now built and checked: it restores
the previously proven exact Civil-link grip admission, requires that fallback to resolve a live Civil pipe, prepares
the exact twin child-to-centreline selection before the pick, and writes schedule diameter as `2/450`. Release control
stopped the first implementation because it read drawing objects during selection; that unsafe path has been replaced
with a lookup that reads prepared memory only. It is not packaged or deployed. Manager is
separately installed and its independent startup loading remains a separate Stage 1 fault. Stage 1 is not staff ready.

## 1. Mandatory continuity rule

This document controls every Version 3 session.

Tim reaffirmed on 2026-09-01 that this master must be consulted on every work turn, not only after a chat handoff
or context compaction. Before selecting or resuming work, Codex must confirm that the action advances the first
incomplete release gate recorded here. New requests are added to the correct stage or Parking lot without silently
replacing the active gate. Material source, audit, package, deployment and AutoCAD results must be recorded here
before the next task is selected.

After context compaction, a new chat, a handoff or a resumed task:

1. read this document first;
2. confirm the current branch, commit, deployed version and active gate;
3. continue the first incomplete item in the approved sequence;
4. classify new ideas as Current, Next, Version 3 scope change or Parking lot;
5. update this document before a material handoff.

A chat summary, automation prompt or worker handoff may add current evidence, but it never replaces this plan.
No session may declare Version 3 complete using source tests alone.

## 2. Purpose

This framework combines the approved Civil Drawing Intelligence model, project evidence/data model, editor UI/UX
contract, workflow cards, implementation roadmap and release gates into one Version 3 delivery sequence.

It does not rewrite detailed engineering decisions. It identifies the controlling document, present implementation
state, next gate and definition of completion.

## 3. Version 3 outcome

Version 3 is complete only when colleagues can install and use CE Civil without CE Manager or CE Structural.

The staff-ready release must provide:

- its own CE Civil ribbon and command loading;
- no runtime DLL or command dependency on Manager or Structural;
- reliable native AutoCAD grips and previews;
- complete Pipe, Pit and CDEDIT workflows;
- identity/evidence-driven Drawing Intelligence with no nearest-object guessing;
- visible Unknown, ambiguity and provenance rather than invented values;
- safe Preview, Cancel, one Undo and exact save/reopen behaviour;
- independent source and package audits;
- standalone install, help, diagnostics, rollback and release notes;
- Tim acceptance followed by a controlled colleague pilot.

The deployed v3.0.0 foundation is the first integrated field baseline. It is not the completed Version 3 program.

## 4. Authority order

When requirements conflict:

1. Tim's latest explicit decision recorded in a current approved brief/card.
2. Approved engineering, topology, calculation and drawing-data contracts.
3. This document for Version 3 scope, sequence, status and release gates.
4. [Civil Drawing Intelligence brief](./CE_CIVIL_DRAWING_INTELLIGENCE_BRIEF.md).
5. [Civil editor UI/UX brief](./CE_CIVIL_EDITOR_UI_UX_BRIEF.md).
6. [Consolidated Civil UI/UX behaviour contract](</C:/Users/TimothyBrand/.codex/visualizations/2026/08/19/01a0185e-7339-78e2-ad52-57980b223827/CE_CIVIL_CLAUDE_UI_UX_CONTRACT.md>).
7. [EV-03 project evidence model](./CARDS/EV-03_EVIDENCE_MODEL.md).
8. [Workflow-card index](./CARDS/INDEX.md) and individual approved cards.
9. [Implementation roadmap](./IMPLEMENTATION_ROADMAP.md).
10. Existing shipped behaviour unless a higher authority changes it.

Entry point: [Civil Editor Workshop Context](./CE_CIVIL_EDITOR_WORKSHOP_CONTEXT.md).

The UI contract cannot weaken engineering rules. Historical frequency cannot promote a drafting pattern into an
engineering rule. Conflicting or missing evidence remains Unknown.

## 5. Shared intelligence, data and evidence backbone

~~~text
Project sources + accepted user decisions
                    ↓
Evidence + provenance + confidence + revision
                    ↓
Stable Civil identity + relationships
                    ↓
Canonical engineering data
                    ↓
Drawing presentation + regenerable views
                    ↓
QA + review + schedule + profile + calculation outputs
~~~

Non-negotiable rules:

- engineering data and presentation are separate;
- stable identity outranks proximity;
- touching/termination may prove a connection; crossing alone does not;
- Xrefs are evidence, never live Civil connection targets;
- important values expose provenance;
- Unknown, Assumed, Manual/Pinned and Display Override remain distinct;
- accepted manual edits outrank later conflicting imports until reviewed;
- evidence extraction is read-only, reproducible and privacy-governed;
- learning may propose but never silently changes engineering rules;
- one accepted operation maps to one AutoCAD Undo step.

## 6. Completion gates

Every work item keeps separate states:

| Gate | Evidence required |
|---|---|
| Behaviour approved | Tim decision recorded in a current brief/card |
| Source complete | Implementation plus focused regression checks |
| Integrated | Present on the Version 3 integration branch |
| Source audited | Genuinely independent all-zero review |
| Package audited | Exact clean lanes, assets, manifest and hashes verified |
| Tim accepted | Representative real-drawing AutoCAD checklist passes |
| Staff pilot accepted | Standalone colleague install and workflow passes |
| Staff ready | Help, rollback, release notes and known limitations complete |

Only Staff ready counts as 100%.

## 7. Master workstream status

Update this table whenever a checkpoint, audit, deployment or AutoCAD result changes the truth.

| Workstream | Plan | Source/integration | Runtime truth | Next gate |
|---|---|---|---|---|
| Standalone Civil host/ribbon/package | Approved | Corrected integrated package independently audited ALL-ZERO at `cf751353` | PARTIAL/FAIL: ribbon appeared only with Manager loaded; standalone ownership unproven and visible ribbon is not the approved v3 layout/icons | Prove standalone load, then implement and approve the intended v3 ribbon |
| Native grips and Civil attachments | Approved | Source correction restores the exact canonical Civil-link admission that rendered/clicked in the earlier proof, requires a live same-drawing Civil pipe owner, and retains the newer marker plus all final write checks; 133/133 focused checks pass on both targets | **FAIL in deployed build / source correction untested:** ordinary grips remain sound, but deployed `3b06a61b` showed no Slide / Offset / Flip markers | Include in one consolidated field candidate; no repeated audit loop |
| Pit middle-ground compounding | Approved | Implemented | Previously confirmed | v3 regression check |
| CDPARTS | Approved | Implemented | Previously confirmed | v3 regression check |
| Twin detention pipes | Approved | Exact picked route is the dashed no-plot centreline; both pipes and both MLINEs are owned children. Source correction prepares an exact child-to-centreline map during safe idle/command-end reading, uses only that prepared map during the original pick, and writes `2/450`, while preserving the passing clearance and arrow | **PARTIAL in deployed build / source correction untested:** clearance, compounding and one-system schedule pass; child-to-centreline selection failed in deployed `3b06a61b` | Include in one consolidated field candidate and test all four visible geometry picks plus exported schedule wording |
| Shared editor shell | Approved direction | Planning-only visual/decision packets prepared at `77ea1b55`; production shell remains foundation-only | Not staff accepted | Tim visual approval of CD/PIPEEDIT first |
| PIPEEDIT | Approved | Part-built; first realistic approval mockup prepared | Incomplete | Tim visual approval, then finish Engineering/Connections/Presentation |
| PITEDIT | Approved | Part-built | Incomplete | Finish levels/details/connections/presentation |
| Pipe-to-pit physical fit warning | Approved warning-only behaviour | Not built | Not tested | Implement with Pipe/Pit connection evidence, then prove warnings in PIPEEDIT, PITEDIT, CDCHECK and Project Review |
| CDEDIT/batch | Approved | Part-built | Incomplete | Finish routing and same-type one-Undo batch |
| Editing/annotations | Approved/closed | Partial | Not accepted | Labels, inverts, remarks, levels and fall arrows |
| Topology/local reassessment | Approved | Source slices exist | Runtime acceptance incomplete | Integrate and prove normal-edit reassessment |
| CDCHECK/smart drafting | Approved | Partial foundations | Not accepted | Build after topology core |
| CDPROFILE | Approved/closed | Strong source evidence exists | Drawing workflow incomplete | Integrate then route/insertion acceptance |
| Slab System | Approved/closed | Strong source/evidence chain exists | Drawing insertion incomplete | Integrate then regeneration acceptance |
| Calculations/catchments | Approved/closed | Existing foundations; **area plan for D+F written 15 Sep 2026** | Guided v3 workflow incomplete | **Provenance and Apply-to-drawing review** — still the gate; the area plan puts provenance first for that reason |
| Survey/import/consultants | Approved/closed | Partial | Unified CDIMPORT incomplete | Implement reviewed import/update path |
| Review/issue readiness | Approved/closed | Partial | Unified workspace incomplete | Project Review and issue gates |
| Repair/legacy/admin | Approved/closed | Partial | Unified CDREPAIR incomplete | Read-only scan and reviewed repair |
| CDWT/tank family | Active approved addition | Protected recovery at `629c67ee`; current tank catalogue expanded through `3fb2e3bd`; approved-project topology/conflict evidence recorded through `ffdc86e0`; 146/146 focused tests pass on net10 and net48 | Not integrated/audited in v3; AW2000LL engineering hold, unmatched details and disputed SPS/tank levels remain blocked | Resolve later detail holds, then selectively integrate after Stage 1, audit and field-test |
| CDSETUP guided project design | Behaviour and visual approved | Approved workflow card exists; the separate pipe-detention dependency card records one stable DetentionSystem identity and quarantines conflicting historical calculation evidence. No production source is built | Not tested | Complete the DetentionSystem/data dependency and catalogue decisions before guided automation; do not learn from unreconciled old jobs |
| CDHELP/support | Requirement captured | Not built | Not tested | Visual plain-language help and error reporting |
| EV-03 learning/evidence pipeline | Approved | Implementation incomplete | No production model | Privacy gate, extraction and controlled release |
| **Council rulebook (CR)** | **Active approved addition — Tim 2026-09-15: *"make sure all these documents and information is included in V3 plan and the plugin reads, understands them and CE based design and drafting is working with this context"*** | **Thirteen council documents across ten councils read and written up in `docs/workflows/COUNCIL_*.md`; full specification, data-model gap and build order at [COUNCIL_RULES_V3_INTEGRATION.md](workflows/COUNCIL_RULES_V3_INTEGRATION.md). No production source built** | **Twelve confirmed errors found in the shipped `council-profiles.json` by reading councils' own documents against stored values; most published rules currently land in free-text `warnings`, so the plugin can print them but cannot check them** | **Sweep the known error patterns across all 22 councils, then extend the model and make the checks real; eight decisions listed in §6 of the integration spec gate the later steps** |

### Stage 1 field result — 2026-09-03

The exact `3b06a61b` deployment has now been tested. Normal pipe creation passes. The full two-pipe envelope fix
passes: the main pipe text and both invert labels clear the upper barrel, and the already-approved flow arrow remains
correct. Twin compounding and the one-system schedule also pass. Two failures remain: no Civil Slide / Offset / Flip
markers appear, and selecting any of the two visible polylines or two MLINEs does not transfer to the dashed
centreline. The CE file log contains the correct centreline creation and all four stored child identities but no
`Twin pipe selected at its centreline` record, proving the late idle hand-off never ran. The next correction must run
at the original object pick. Tim also confirmed that final schedule presentation must read `2/450`; legacy `2 x 450`
may remain readable for old schedules but must no longer be newly written.

Tim's real-drawing run records: CE Civil ribbon visible while the separate Manager bundle is also loaded; ordinary
AutoCAD grips/previews pass; Civil Slide / Offset / Flip grips absent; twin compounding and one-row schedule work;
twin flow arrow and the corrected main/invert text clearance pass; only the centre polyline exposes centreline end
grips; pit middle-ground and CDPARTS pass. The ribbon is still not proven standalone.

The source correction after this field result is complete. Civil action-grip admission now first uses the richer
derived marker and then falls back to the exact canonical Civil attachment link that already produced a rendered,
clickable native grip in the earlier proof. That fallback now also proves its recorded owner is a live Civil pipe in
the same drawing. All movement remains in the existing preview/accept command with final identity and drawing-
protection checks. Twin selection prepares an exact child-to-centreline map during safe idle/command-end reading.
At the original object pick, before AutoCAD decides which grips to display, it consults only that prepared map and
leaves uncertain selection unchanged. New schedule cells write `2/450` while old `2 x 450` values remain readable.
Focused checks pass 133/133 on both targets; the broader relevant set records 529 passed, 2 skipped and the same one
known unrelated pit-schedule wording failure on both targets; both Civil builds have zero errors. Two native rebuilds
match exactly at 47,104 bytes and SHA256
`FD5D57DB18A9DAB5308F3745160D82A5A25184F67C33F2C4253F504343BE5384`. Release control stopped the first unsafe
selection-callback implementation before packaging. No live package changed and the corrected source remains
runtime-unproven.

A read-only inventory of the running AutoCAD process proves the exact installed Modern Civil DLL
`3.0.0+1b2b1945...` and `CE_CVL_NATIVE_GRIP_2027.arx` are loaded from the Civil bundle. It also proves Manager
`1.0.5+51044f08...` is loaded from its own `CE_SUITE_MANAGER.bundle`; Civil packaging did not contain Manager.

The field failure exposed a concrete ObjectARX defect: display admission called a single-selection check before
AutoCAD guarantees that its selection set is complete. This can suppress all three Civil grips; the next field run
must still prove it was the complete runtime cause. The source correction keeps exact Civil identity, drawing, locked
layer, Xref/overlay and REFEDIT protections at display time, then applies the single-selection rule at the actual
click. AutoCAD's normal grips are still requested first. A four-message cap now states either `CE Civil grips ready:
Slide, Offset and Flip.` or that AutoCAD requested plain points, making the next test decisive without flooding the
command line. Focused checks pass 17/17 on both targets, broader native/attachment/twin checks pass 200/200 on both,
and two zero-error ObjectARX builds are byte-identical at 43,520 bytes and SHA256
`2B1B6AB01B92717E8BE80895EB07FEA03090D6A41A77FCBE1AF34348287E8953`. Source checks and deployment truth remain
separate.

The same field run also proved that ownership highlighting alone cannot expose centreline end grips from a visible
twin child. The source correction is intentionally narrower than the disabled whole-family selection system: only
an exact stored primary/secondary pipe or MLINE child in a confirmed centreline-owned twin transfers the one real
AutoCAD selection to that centreline. Labels, inverts, arrows, normal pipes, protected content and uncertain links
do not transfer. It performs no drawing write or geometry movement. Focused ownership checks pass 24/24 on both
targets, the wider grip/twin/ownership set passes 241/241 on both and both Civil builds have zero errors. Runtime
selection and end-stretch behaviour remain unproven until the next consolidated deployment.

### Deployed-state note — 2026-09-03

Tim explicitly confirmed AutoCAD was closed and authorised deployment. Process checks found neither `acad` nor
Core Console running. The existing installer built exact source `1b2b19456442a4cdb7567f11b59bc5254c82161f`, then
one consolidated package check passed:

- Civil grip/twin/ribbon/manifest/block checks: **246/246** on net10 and **246/246** on net48;
- installer checks: **45/45**;
- package: **503 files**, with zero ZIP differences, 17/17 matching source blocks and no Manager, Structural or
  test files;
- payload ZIP SHA256: `C1FFA1DED6A514CCD6418932776DDCDEF009C26695F9B151B62C78C0C5A29A10`;
- Legacy DLL: `53EDA84CCC987CAA6F865BED9375FF40E58742566EA066DBD17B426883090897`;
- Net8 DLL: `71E4B49A6A0768E1B6F44B39B65AC356910AC2023D0EEF68776059E0A25A491F`;
- Modern DLL: `FA08CC9A541C364F2AAEEB59F1AA9715D3414E16258A97D227B5A1CA79110D77`;
- AutoCAD 2027 grip module: `4F0CE7038320654AFBEB935C79C5F20CD9921677529D8FC20A5CCD550E1AC9D4`.

The per-user ApplicationPlugins bundle was replaced only after the closed-process and exact-target checks. The
installed tree contains the same 503 files with zero missing, extra or different files; all three installed DLLs
match the candidate hashes and report product `3.0.0+1b2b1945...`. AutoCAD remained closed. Installation was
verified; the later field result above supersedes its previously untested runtime state.

### Superseded deployed-state note — 2026-09-02

With AutoCAD fully closed, the exact independently audited Stage 1 package at `cf751353` was deployed to
`%APPDATA%\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle`. All **502 source files** and **502 installed files**
match: zero missing, extra or different files. The installed program-file SHA256 values are Legacy
`667A1ACDAE50F0F7C62F2DA342B6F2F2C55C51502F4C4BED434BEB2891148FB5`, Net8
`E605CF61286C6B4929C645AEF12F86754EB0327BA55295EBF0A9F6E6DEB33C0B`, and Modern
`8A8A456D9203DB31746504DDE718C5472143365A25578FCC1BAE2F82B444FB92`. No second Civil bundle exists in the checked
ProgramData or LocalAppData plugin locations. AutoCAD remained closed after deployment. This records installation
only; full-restart real-drawing acceptance is still required. The later CDWT recovery remains source-only and is not
part of this deployed package.

### Stage 1 field result — 2026-09-01, W26-26_C01.dwg

| Check | Result | Evidence / required guard |
|---|---|---|
| Standalone CE Civil ribbon | FAIL | No ribbon visible. Log claimed v3 CUIX generated and toolbars patched, so installer success is not proof of visible ribbon. |
| Ordinary grips/native preview | PARTIAL/FAIL | Classic AutoCAD grips remain, but Civil role-specific grips are absent. Do not reintroduce a global overrule that breaks Structural/native previews. |
| Pit cover-level text manipulation | NOT BUILT | Add separate presentation grips to rotate/flip the cover text around its owning pit. |
| Pipe label/invert/arrow movement | FAIL | First invert MOVE also moved main label; later attempt behaved differently. Main label alone moved independently. Require deterministic role ownership per move. |
| MLINE compound selection | FAIL | Compound selection works from a pipe polyline but not its MLINE representation. Both accepted representations must resolve to the same logical pipe. |
| Cancel/Undo | PASS | Restored prior positions in this field run. |
| Twin detention pipe | FAIL | Compounds from one polyline only; grip anchors, main label and invert labels use the wrong physical/reference centre. |
| PITSCHEDULE/CDPARTS/PP/pit compounding | PARTIAL PASS | Commands broadly worked but require focused regression after corrections. |
| CDEXPORTENTITIES | FAIL without crash | AutoCAD remained open, but export ended with 'eInvalidInput' and produced an error. No-crash alone is not acceptance. |

Stage 1 remains active. Do not proceed to Stage 2 integration or another deployment until these failures are
corrected, mechanically checked, independently audited and packaged.

### Stage 1 corrected-package field result — 2026-09-02, W26-26_C01.dwg

| Check | Result | Evidence / required guard |
|---|---|---|
| Standalone CE Civil ribbon | PARTIAL/FAIL | Ribbon appeared, but only after Manager was loaded. Standalone ownership is not proven. The visible ribbon is also not the approved v3 layout with the intended sections and new icons. |
| Ordinary grips/native preview | PASS | Ordinary AutoCAD grip movement and moving preview worked again. Preserve this exactly. |
| Civil pipe attachment grips | FAIL | Civil Slide/Offset/Flip behaviour did not work for the main label, invert labels or flow arrow. Obtain an independent AutoCAD custom-grip implementation review before another correction. |
| Twin detention pipe | FAIL | Screenshots show editing and grip references still tied to physical barrel geometry rather than one logical centreline. Main text and invert placement remain crowded/misaligned at the pits. |
| Pit cover-level presentation | FAIL/NOT BUILT | No cover-level orbit/flip action. Required behaviour: move the cover text around its owning pit or flip it to the opposite side without changing the CL value, pit geometry or hydraulic data; keep text readable and preserve Cancel/Undo/save-reopen. |
| Pit/CDPARTS functions | PARTIAL PASS | Existing pit middle-ground, schedule and parts behaviour broadly works, but requires regression after grip changes. |
| CDEXPORTENTITIES | PASS | 1,110 entities written; 21 unreadable items reported by handle and listed in the JSON; command completed without crash or generic failure. |

Stage 1 remains the active gate. The next source action is the independent custom-grip/root-ownership investigation,
not Stage 2 or tank integration. A new package/deployment requires a corrected source audit and exact package audit.

### Stage 1 independent custom-grip investigation — 2026-09-02

Claude's independent read-only report verified exact deployed source head `cf751353`, tree `533d977a`, and made no
repository, build, package, AutoCAD or live-bundle change. Verdict: **not ALL-ZERO; SAFE TO IMPLEMENT**, with the
managed on-screen trigger-grip slice held behind one small AutoCAD proof run.

The evidence-backed root causes are:

- the live action path creates three managed trigger grips but does not retain their objects for AutoCAD's grip
  lifecycle; this is the leading unproven reason that visible CE grips disappear;
- AutoCAD 2027 does not support that newer grip request for the existing DBText invert labels, so they can never use
  the current trigger-grip path;
- the old 1,835-line point-grip implementation is not registered and is dead code retained by source-text tests;
- twin detention uses barrel 1 as its root, so label/invert/flip frames and native end grips use the wrong physical
  line; the stored logical centreline only redraws the barrels;
- the primary MLINE lacks a durable owner tag, so selection depends on a temporary memory cache;
- first-click Civil grip eligibility can fail before that cache is warmed;
- pit cover-level text has no distinct attachment role or presentation action.

Recommended one-path correction, subject to the mandatory workflow decision:

1. keep one modal placement command as the only Slide/Offset/Flip behaviour;
2. first add an object right-click menu for linked main labels, DBText inverts, arrows and pit cover text, all feeding
   that same command and its existing preview/Cancel/one-Undo protections;
3. make the twin root the exact picked logical centreline, with both barrels and both MLINE representations tagged as
   owned display children;
4. give pit CL text a stable role plus Move around pit / Flip side presentation actions; never change CL value, pit
   geometry, connections or hydraulic data;
5. remove the dead point-grip implementation and replace its source-text tests with behaviour checks;
6. separately repair the managed trigger-grip lifetime for MText/blocks, add bounded diagnostics and prove it in one
   AutoCAD probe before trusting or releasing that entry point.

Tim approved the investigation recommendations on 2026-09-02. Visible grips remain the normal interaction and the
right-click action menu is a backup route to the same placement command. A newly drawn pipe must work on first
selection in an older drawing. The twin logical root will appear as a thin dashed selectable no-plot centreline.
Ordinary AutoCAD grips and Structural/native moving previews remain a non-negotiable preservation gate.

### Stage 1 correction progress — twin detention logical centreline

Source checkpoint `6a7ea1db` on `codex/civil-v3-twin-centreline-r1` replaces the disproven barrel-1 authority for
new or deliberately converted twin detention systems:

- the exact route picked point-to-point is the one selectable engineering route;
- that route is a zero-width dashed line on `CE DETENTION CENTRELINE`, and the layer is explicitly non-printing;
- the two visible pipe polylines and both MLINE outlines are regenerated symmetrically and carry the exact route
  identity as linked drawing children;
- selecting either pipe or either MLINE resolves and highlights the same single detention system;
- the main label and both invert labels continue to use the exact picked route and its endpoints;
- PITSCHEDULE and calculations still consume the canonical system once, not four display items;
- turning twin mode off restores one normal pipe and MLINE, while stale recorded child parts are removed by exact
  identity only;
- older twins are not silently reinterpreted on drawing open. They require a deliberate accepted edit, and ambiguous
  old barrel evidence remains unchanged.

Mechanical evidence is **92/92 focused tests on both net10 and net48**, **251/251 wider tests on net10** and
**249 passed / 2 expected skips on net48**, dual Civil Release builds with **0 errors**, and the full modern run at
**5,122 passed / 17 skipped / the same one known unrelated pit-schedule wording-test failure**. Every build/test used
`SkipDevBundle`; no package, live bundle or AutoCAD session changed.

Runtime truth remains **FAIL / correction untested** until Tim draws one new twin in AutoCAD and proves midpoint
end grips, all four selectable representations, label/invert placement, one schedule row, symmetric regeneration,
Cancel/Undo and twin off/on. This correction must travel with the grip runtime correction through one consolidated
review and package gate; it is not a separate deployment request.

### Stage 1 correction progress — bounded Civil action-grip probe

The first bounded grip correction is protected on `codex/civil-v3-native-grip-r1` at exact head
`573099f412c56b2236a524ae35327f86b6d3f9cb`, tree `217f73f8e3aa3609ea544e1e632aaccff4373d6e`.
Linked MText labels and block arrows retain their Slide/Offset/Flip action points for the complete AutoCAD selection
session. Older DBText inverts use the same placement command through a backup object menu. New-pipe creation refreshes
only that committed pipe and its exact stored children before reporting success. Normal AutoCAD grip movement is not
overridden.

The first audit correctly blocked packaging at `5d8d4b33`. Its findings are closed: grip-points-only requests leave
displayed generations alive, repeat full requests accumulate until selection ends, every native status/entity access
is guarded, drawing close releases only that drawing's retained items, bounded probe evidence is always logged and a
refused click returns safely to AutoCAD's normal warm state. Fresh independent re-audit verdict: **ALL-ZERO** at
`573099f4`. Independent proof is **21/21 focused** and **154/154 broader** on net10 and net48; Release rebuilds have
**0 errors**, the same existing **136 net10 / 164 net48 warnings**, and no warning from a changed line.

This source remains runtime-unproven. After Tim confirmed AutoCAD was closed, the existing safe release builder made
the exact three-lane probe candidate at
`C:\Lisp Files\SUPERSEDED\CE_CVL_SUITE\20260902_111035_v2026.0902.1108`. Its working bundle, archived bundle and
ZIP contain the same **502 files** with no missing, extra or changed content. The bundle content-ledger SHA256 is
`9C54DCECAAF9C999192EBFDBBF1767C4ADA66202D4A0CF679B49E2ADB4B792C9`; the payload ZIP SHA256 is
`C2056A51B4B5524E0A7B20E40030186A346C754491FB8AF7DF9EFD8B4A2B8FA4`; and the installer SHA256 is
`D70A1F3BBA0B8F5BA8985DA237F78FA67AE16B47FE985937B99262B5500BDA1F`. Packaged Civil DLL hashes are Legacy
`4B1A7660A3914A49441F73D8DDDBECD60FC819EE74BD49DE5F8AD5212F35AD1B`, Net8
`AABCF83320B490230B579CEEC00D23F389D12B5DD24EE3321550A8645DD290B3`, and Modern
`471B8D12315810AD2C0A6107F80354B7D28E70551D21634F8DC5719525AE84FF`; each exactly matches its fresh Release
build and identifies product version `3.0.0+573099f412c56b2236a524ae35327f86b6d3f9cb`.

Local package safeguards pass **44/44** for grip/ribbon/manifest/blocks and **43/43** for installer safety. No
Structural, Manager, test or harness program file is present. The installed live DLLs retain their previous hashes,
so this build did not deploy or touch ApplicationPlugins.

The independent read-only package audit returned **ALL-ZERO** for this exact candidate. It independently matched all
502 files across the working bundle, archive and ZIP; all three Civil DLLs; the manifest lanes; packaged assets; the
live-bundle non-change; and the supplied content, ZIP and installer hashes. Independent checks passed **44/44** on
net10 and net48, expanded safeguards passed **52/52 net10** and **41/41 net48**, and installer safety passed
**43/43**. The package is approved only for one bounded AutoCAD grip probe. It is not a staff release. The next gate
is a fresh AutoCAD-closed deployment instruction, a complete AutoCAD restart and the early-session grip checklist
before the 40-record probe log limit is reached. Twin root ownership and pit cover-level orbit/flip remain the next
separate approved slices after the probe.

After Tim gave a fresh AutoCAD-closed deployment instruction, this exact audited candidate was installed to the
per-user AutoCAD ApplicationPlugins folder using the existing project deployment path. Candidate and installed
bundles each contain **502 files**, with **0 missing, 0 extra and 0 different** files. Installed program hashes are
Legacy `4B1A7660A3914A49441F73D8DDDBECD60FC819EE74BD49DE5F8AD5212F35AD1B`, Net8
`AABCF83320B490230B579CEEC00D23F389D12B5DD24EE3321550A8645DD290B3`, and Modern
`471B8D12315810AD2C0A6107F80354B7D28E70551D21634F8DC5719525AE84FF`. No duplicate Civil bundle exists in the
checked LocalAppData or ProgramData locations, and AutoCAD remained closed. Installation is proven; grip behaviour
is not accepted until the early-session AutoCAD checklist passes.

### Stage 1 grip-probe field result — 2026-09-02

The exact audited `573099f4` candidate failed its bounded AutoCAD test in `W26-26_C01.dwg`. Ordinary AutoCAD grips
and their moving preview passed, and Cancel/Undo passed. Civil action points did not appear on the existing pipe label
or flow arrow; Slide/Offset/Flip therefore did not exist; the object right-click menu showed no Civil actions for the
selected invert; and a newly drawn pipe still had no Civil actions on first selection. Locked/Xref refusal was not
tested because the entry points were absent. Twin detention remains broken and was not part of this probe correction.

The normal CE log provides decisive evidence rather than another visual guess. Both services reported registered,
and the new pipe's exact cache refresh completed for pipe `11AF35`. AutoCAD later reported `GripsDone` for existing
MText `1101B4`, flow-arrow block `1101DD` and new MText `11AF4B`, but every record showed
`retainedEntities=0`; no `grips-ready` or grip-click record exists. This proves the new-pipe/old-drawing cache was not
the blocker: the active AutoCAD grip request returned before adding any Civil action point. The right-click service
registered but its confirmation/visibility gate hid every Civil item, matching the supplied screenshot. Treat the
probe as **FAIL**, not progress. The next source slice must prove both visible action points and the backup menu from
these exact request/identity states while preserving the now-confirmed ordinary AutoCAD grip preview.

### Stage 1 failed-probe correction r2 — 2026-09-02

The corrected source checkpoint is pushed on `codex/civil-v3-native-grip-r2` at head
`976b36ec2e95a10731cbd6d4ddc5a1a73c489341`, tree `14c5c03405e382d25ba6a3463258e7bf5c42c6b0`. It appends Civil action points to AutoCAD 2027's displayed point request instead of returning before they are added. It
preserves AutoCAD's own grips first and still does not replace normal grip movement. An older invert is eligible only
where its exact handle is already recorded by one pipe and its role/field remain unclassified legacy evidence. The
exact stored-membership result is carried into every display, preview and accepted-write gate. Explicit non-invert
roles such as Supplementary text cannot be promoted by `IL ` wording/layer, and Civil menu actions stay absent from
ordinary and Structural text/blocks. A missing direct child-owner tag is written only after the user accepts the
placement; proximity is never used.

Focused checks pass **25/25** and broader attachment/twin safeguards pass **158/158** on net10 and net48. Safe Civil
Release builds complete with zero errors, and the complete modern suite reports **5,071 passed / 17 skipped / the
same one known pit-schedule wording failure**. The earlier independent run against the pre-correction checkpoint is
superseded. The live bundle remains untouched and r2 is not packaged or deployed. The subsequent separate Stage 1
slice remains twin logical-centreline root, MLINE ownership and correct label/invert placement.

Fresh independent source re-audit is **ALL-ZERO** at exact head
`976b36ec2e95a10731cbd6d4ddc5a1a73c489341`, tree
`14c5c03405e382d25ba6a3463258e7bf5c42c6b0`. The reviewer independently reproduced **25/25** focused and
**158/158** broader checks on net10 and net48, both Release builds with 0 errors and the full modern result above.
Exactly the seven expected files differ from base `573099f4`; tracked source is clean. All three interim findings are
closed: exact stored membership is derived and carried through every gate, explicit non-invert roles cannot use the
legacy IL fallback, and Civil menu actions remain absent from ordinary/Structural objects. No source finding remains.
The exact source may now enter non-live package creation and independent package audit. AutoCAD runtime remains FAIL/
unproven until the exact audited package is deployed with AutoCAD closed and the bounded grip checklist passes.

The existing safe release builder created the exact non-live r2 candidate from audited head `976b36ec` at
`C:\Lisp Files\CE_ACAD_PLUGIN_V3_NATIVE_GRIP_R1\Installer\payload_build\CE_CVL_SUITE.bundle`, with archive
`C:\Lisp Files\SUPERSEDED\CE_CVL_SUITE\20260902_123817_v2026.0902.1236` and payload ZIP SHA256
`3A3BC1E39EC95E440723E4C24AE9FA959678067AA872588DA86BD91F7EA5D430`. Working bundle, archive and ZIP each contain
**502 files** with zero missing, extra or changed content; content-ledger SHA256 is
`95834BFD172DC182674CA30FB36AFA34706E17F0B15AC9D6E22458A8595AF30B`. Packaged Civil DLL SHA256 values are Legacy
`F76D5206A1DD795D83B8D57E79FC5173A94DBDF380F2A110DD15E3258B4C47CC`, Net8
`6F101E0E9AF5F9B1370CA6C5BE7ADDD3AACC138D304D450E34F6F4A0148FF2B0`, and Modern
`986773D42815EA5A2F1B021A486918D2F3CE585C7474557E024AFCA6D5B02D27`; all identify exact product source
`3.0.0+976b36ec2e95a10731cbd6d4ddc5a1a73c489341`. Package safeguards pass **48/48** on net10 and net48 and installer
safety passes **43/43**. Installed r1 hashes remain unchanged, proving no deployment occurred. This local package
evidence does not replace the required genuinely independent exact-package audit.

Independent exact-package audit is **ALL-ZERO** for head
`976b36ec2e95a10731cbd6d4ddc5a1a73c489341`, tree
`14c5c03405e382d25ba6a3463258e7bf5c42c6b0`. The auditor independently matched the working bundle, archived
bundle and extracted payload ZIP at **502/502/502 files with zero differences**, reproduced payload ZIP SHA256
`3A3BC1E39EC95E440723E4C24AE9FA959678067AA872588DA86BD91F7EA5D430` and installer SHA256
`94212BF95C044944CDB3B4C3E3324A684F271928532A1A3D7BBEC59AE53DF482`, and verified all three packaged Civil
DLLs are byte-identical to the audited Release outputs and identify product source
`3.0.0+976b36ec2e95a10731cbd6d4ddc5a1a73c489341`. Package safeguards pass **48/48** on net10 and net48 and
installer safety passes **43/43**. The installed r1 bundle remains unchanged. No further source or package audit is
required before this bounded test. The next gate is explicit closed-AutoCAD deployment of this exact package,
followed by the early-session grip checklist; it remains a test candidate, not a staff release.

Tim explicitly confirmed AutoCAD closed and authorised deployment on 2026-09-02. Windows initially still showed
two closing `acad.exe` processes, so deployment correctly waited until both had exited. The exact audited r2 bundle
was then installed from
`C:\Lisp Files\CE_ACAD_PLUGIN_V3_NATIVE_GRIP_R1\Installer\payload_build\CE_CVL_SUITE.bundle`. The prior live
502-file bundle was preserved outside AutoCAD's plugin folders at
`C:\Lisp Files\SUPERSEDED\CE_CVL_SUITE\20260902_r2_grip_predeploy_976b36ec\CE_CVL_SUITE.bundle`. Full post-install
comparison reports **502 candidate files / 502 installed files / 0 differences**. Installed DLL SHA256 values are
Legacy `F76D5206A1DD795D83B8D57E79FC5173A94DBDF380F2A110DD15E3258B4C47CC`, Net8
`6F101E0E9AF5F9B1370CA6C5BE7ADDD3AACC138D304D450E34F6F4A0148FF2B0`, and Modern
`986773D42815EA5A2F1B021A486918D2F3CE585C7474557E024AFCA6D5B02D27`; all report product source
`3.0.0+976b36ec2e95a10731cbd6d4ddc5a1a73c489341`. Only the expected per-user Civil `.bundle` exists in AutoCAD
plugin scan paths. Deployment is exact; runtime remains unproven until Tim completes the bounded early-session
grip checklist.

The exact deployed r2 package then **failed** its early-session AutoCAD test. Tim reported: existing pipe-label
Civil points absent; Slide/Offset/Flip therefore unavailable; flow-arrow Civil points absent; older invert
right-click actions absent; and a newly drawn pipe still failed on first selection. Cancel/Undo and ordinary
AutoCAD grip movement/preview both passed and must remain untouched. The normal CE log proves the r2 program loaded
and both Civil services registered. New pipe `11AFF5` recorded exact child identity for main label `11B003`, first
invert `11B008`, last invert `11B00C` and flow arrow `11B02D`; its exact cache refresh and deferred full cache rebuild
both completed. Nevertheless, selection ended with `retainedEntities=0` for existing MText/arrow items and for the
new labels, with no `grips-ready` record. This rules out packaging, missing registration, old-drawing identity and
new-pipe cache warming as the primary cause. Treat the r1/r2 managed applicability path as failed. The next correction
must use AutoCAD's own extension-dictionary/object filtering or another documented exact-identity entry, preserve
ordinary native movement, and keep the one existing preview/Cancel/Undo placement command underneath. No further
audit or deployment of r2 is warranted.

### Stage 1 Civil action-grip correction r3 — 2026-09-02

The corrected source-only checkpoint is pushed on `codex/civil-v3-native-grip-r3` at exact head
`4e6328532f841bbcdd6a020aebdda582b994b695`, tree
`5479ef471ac8283e23d1f7bc12f1a903b93201fd`. It addresses the exact r2 log result instead of changing grip shapes
again:

- AutoCAD calls the narrow MText/block action-point path without excluding an older attachment whose exact handle
  is stored by its pipe but predates the child-side Civil owner record; CE performs one exact cached-membership
  lookup and immediately returns for unrelated objects;
- cache misses have a separate 12-message limit, preserving the 40 useful records for exact candidates and retained
  grip sessions;
- Autodesk's 2027 reference states that `GripPointsOnly` requests do not invoke custom glyphs or callbacks, so CE
  retains AutoCAD's ordinary points and does not add a dead action-looking square on that request;
- a newly committed pipe republishes its exact attachment positions after the final command cleanup that otherwise
  clears temporary attachment data;
- each standard-square Civil action point is explicitly pickable using Autodesk's documented trigger-grip settings;
- the older-invert backup menu appears only for one exactly proven pipe attachment;
- no Civil movement callback, custom grip drawing, proximity ownership, locked-layer bypass, Xref/REFEDIT bypass or
  Structural behaviour was added.

The first independent review correctly returned **NOT ALL-ZERO** for initial r3 head `6482b348`. Its two findings
were that the durable-record filter excluded those older exact children before CE could see them, and unrelated
Civil blocks could consume the useful diagnostic limit. Both are corrected above; that initial head was not
packaged. Mechanical proof after correction is **26/26 focused** and **159/159 broader** on both net10 and net48.
Full safe Release rebuilds complete with **0 errors** and the existing **136 net10 / 164 net48 warnings**. The
complete modern suite reports **5,072 passed / 17 skipped / the same one known unrelated pit-schedule wording
failure**. All commands used `SkipDevBundle`; the installed r2 bundle was not touched. This is not runtime
acceptance. The next gate is one genuinely independent corrected-r3 re-audit, followed by an exact package check and
one short AutoCAD run. Twin detention centreline ownership/text placement and pit cover-level orbit/flip remain the
following separate Stage 1 slices.

### Stage 1 ObjectARX 2027 native-grip proof A — 2026-09-02

Tim approved a bounded native ObjectARX proof after the managed r1/r2 field failures and the corrected managed r3
remaining runtime-unproven. Autodesk's official AutoCAD 2027 SDK was signature-checked and installed outside the
repository at `C:\Autodesk\ObjectARX2027\CDROM1`; no Autodesk header, library or installer is committed.

The clean pushed checkpoint is `codex/civil-v3-objectarx-grip-probe` at exact head
`c51e60f56b4d7f1b20978f0be6418219e7b5340f`, tree
`544282d9cc891f4c4b5706eabef115f6a287eee1`. This is deliberately a proof, not a replacement grip system:

- it targets only AutoCAD 2027 x64 and only MText/block children carrying the exact
  `CE_CVL_SUITE_LINKS/PIPE_ATTACHMENT` owner record written by new CE pipes;
- AutoCAD's normal grips are requested first and remain unchanged;
- display-only `GripPointsOnly` requests receive no dead Civil action point;
- one standard trigger point is appended on an action-capable request;
- clicking it prints `CE grip clicked ... Native grip works; drawing unchanged` and returns to the normal warm
  state; it cannot move, stretch, transform, redraw or write the entity;
- ordinary/Structural objects fail closed; partial registration, allocation failure and shutdown are guarded; the
  module cannot be manually unloaded while a selection may retain native callback pointers.

The official ObjectARX Release build completes for x64 and exports the required AutoCAD entry points. The only link
message is Autodesk's `rxapi.lib` lacking its optional PDB debug-symbol file. Two clean builds produce the same
module SHA256, `59710E88B5AD24BF20B67759FD16A098D92A5A77973F731DA239E0FAC2033126`. Focused guards pass **10/10** and broader
native/managed attachment plus twin-pipe guards pass **169/169** on both net10 and net48. Both normal Civil builds
are **0 errors**. The complete modern suite reports **5,082 passed / 17 skipped / the same one known unrelated
pit-schedule wording failure**. Every Drainage command used `SkipDevBundle`; AutoCAD and the installed bundle were
untouched.

Independent review returned **ALL-ZERO** for proof head `b13db85d` and declared it safe for one manual ARXLOAD test.
Its one meaningful recommendation was that every refused/skipped path was silent and could make the test
inconclusive. Head `c51e60f5` adds capped plain-language messages for unrelated objects, AutoCAD display-only grip
requests, normal-grip failure, a changed link and a successfully added point. It changes no selection, drawing or
movement authority. The two low audit notes are intentionally unchanged: the shared AutoCAD overrule switch must
not be disabled on unload because other plug-ins may use it, and the second read-only owner check remains a safe
last identity guard.

Independent delta review returned **ALL-ZERO** for exact head `c51e60f5`, tree `544282d9`. It independently
reproduced **10/10** focused, **169/169** broader on both lanes, both 0-error Civil builds, the complete modern
suite result, and two byte-identical 27,648-byte native builds with SHA256
`59710E88B5AD24BF20B67759FD16A098D92A5A77973F731DA239E0FAC2033126`. No safety, correctness or scope defect
remains in the source proof.

**AutoCAD field result — PASS, 2026-09-02.** Tim drew a new CE pipe (`11B043`). Its main label (`11B048`), both
invert labels (`11B04C`, `11B050`) and flow arrow (`11B071`) were recorded as exact children during creation. The
extra native point rendered and its click callback fired on the last invert, main label and flow-arrow block, with
the expected `Native grip works; drawing unchanged` message. The successful point-add message appeared immediately
after the new-pipe cache refresh. Ordinary non-Civil selections were refused with the capped plain-language message,
and normal grip attempts still entered AutoCAD's usual `STRETCH` operation. This proves that AutoCAD 2027 can display
and fire the chosen native grip mechanism on newly created CE MText and block attachments without changing the
drawing.

This field pass proves the **point transport only**. It does not claim real Slide / Offset / Flip movement,
pit-cover orbit/flip, older DBText support, twin-pipe centreline behaviour or save/reopen. The next gate is one
bounded source slice that connects the proven native points to the existing single placement command while keeping
preview, Cancel, one Undo, locked-layer, Xref and REFEDIT protections. That exact source must pass focused/broader
tests and independent review before the next short AutoCAD placement check. No package or deployment is authorised
by this proof checkpoint.

### Stage 1 native attachment actions — source checkpoint (2026-09-02)

The next bounded source slice is complete and pushed on `codex/civil-v3-native-grip-attachments-r1` at exact head
`48647475`. It extends the same native Slide / Offset / Flip doorway to four exact confirmed attachment roles:

- main pipe label — MText;
- first-point invert label — MText;
- last-point invert label — MText;
- flow arrow — block reference.

All four feed the existing single preview/Cancel/one-Undo placement command. No native callback moves or writes a
drawing object. Ordinary AutoCAD grips are still requested first. Exact current pipe membership, direct owner,
drawing identity, role/type match, locked layers, Xrefs/overlays and REFEDIT are rechecked before the action is
shown, again at the managed doorway and again before the accepted write. Older DBText inverts remain on the approved
right-click fallback because AutoCAD 2027 does not expose this native grip route for DBText.

The final failure review found and fixed a genuine compatibility mismatch: the DWG stores the exact role text
`Pipe label`, while the native comparison used `PipeLabel`. The native and managed role words are now guarded
together. Focused checks pass **42/42** on net10 and net48; broader attachment/native/twin-pipe checks pass
**201/201** on both. Safe Civil Release rebuilds have **0 errors** with the unchanged **136 net10 / 164 net48**
warning baseline. Two native rebuilds are byte-identical at **42,496 bytes**, SHA256
`D63978C609F012D91457A2CA0DF2FF4F6F4FB17BAA771BB8EEEE6309BA2D98D2`; only Autodesk's missing optional
`rxapi.pdb` warning remains.

The distinct-marker and four-role action sources are now combined on
`codex/civil-v3-grip-combined-integration-r1` at source checkpoint
`c2d88173d917b8c7a118d24763da6631824db43f`, tree
`0e69c8277bf5d49d07d22f369c418314549a5f8e`. The integration contains the exact previously checked Civil and
native source from `48647475`; only the authoritative master-plan conflict was resolved, preserving the current
V3 sequence. Focused checks pass **42/42** and the wider attachment/native/twin-pipe checks pass **201/201** on
both net10 and net48. Civil Release rebuilds finish with **0 errors** and the unchanged **136 net10 / 164 net48**
warnings. Repeated ObjectARX 2027 rebuilds are byte-identical within the integration worktree at **42,496 bytes**,
SHA256 `A433E3B716352E01A34B806EF3D8DC31B13BE3952C179C572CB3BC82CD16565E`; only Autodesk's missing optional
`rxapi.pdb` warning remains. Every Drainage command used `SkipDevBundle`; no package, live bundle or AutoCAD
session changed.

Per Tim's 2026-09-02 direction, small bounded slices do not enter repeated independent-audit loops. The next release
checkpoint is one consolidated exact-package check followed by one short AutoCAD field run. That run must prove all
three distinct markers, Slide/Offset preview, exact Cancel, one Undo, Flip, each of the four supported items, refusal
of protected/ordinary content, and unchanged normal AutoCAD grips. Twin detention centreline ownership remains the
next separate Stage 1 source correction.

### Stage 1 combined-package failure and runtime correction — 2026-09-02

The first combined package did not provide usable Civil action grips in Tim's real drawing. A newly drawn pipe was
recorded correctly and its attachment cache refreshed, but every managed action-grip request ended with
`grips-skip context-stale`. Ordinary AutoCAD grips and their moving preview still worked. The field run therefore
remains a **FAIL** for Civil Slide / Offset / Flip, not an acceptance of the combined package.

The bounded correction is committed at `52a0f508` and follows the field evidence:

- AutoCAD's short-lived display copy is no longer asked to match the real attachment's layer and owner IDs. The
  exact cached attachment ID, handle, drawing and stored pipe membership remain mandatory;
- final preview/write still reopens and rechecks the real cached attachment, write access, locked layer, Xref and
  REFEDIT protections before any accepted movement;
- the AutoCAD 2027 package now declares the native module with the documented
  `LoadReasons="LoadOnAutoCADStartup"` form;
- AutoCAD 2027 registers only the version-matched native Slide / Offset / Flip owner. The older managed fallback is
  retained only for older lanes, preventing duplicate Civil grip sets on one label;
- release cleanup resolves the same exact cached attachment ID, so AutoCAD display copies cannot leave stale grip
  generations behind.

Current mechanical proof: focused grip/native/manifest checks pass **57/57** on net10 and net48; wider attachment,
twin and manifest safeguards pass **209/209** on both; installer safety passes **45/45**; Civil Release builds have
**0 errors** on both lanes; and the pinned ObjectARX 2027 build has **0 errors**. The full modern suite is the final
overnight check: **5,118 passed / 17 skipped / 1 known existing unrelated pit-schedule source-text failure**
(`PassiveStatus_IsSurfacedInPitScheduleAndInspector`). No package, deployment or AutoCAD session is changed by this
checkpoint. Runtime truth remains FAIL until Tim tests one later exact candidate.

### Stage 1 correction progress — standalone Civil ribbon

The bounded source correction now gives the standalone modern Civil plugin its own idle-time CE Civil ribbon
builder and suppresses the legacy CUI toolbar auto-loader on modern AutoCAD. Manager-hosted mode remains isolated;
AutoCAD 2023/2024 retains the legacy menu path because the shared modern ribbon builder is deliberately excluded
from net48.

The first independent audit failed the checkpoint with two valid findings: modern `CDMENU` and the repair window
could still call the legacy CUI loader, and a null AutoCAD ribbon left the idle retry attached indefinitely. Both
are corrected: modern recovery now queues the direct Civil ribbon builder; only net48 can call the legacy menu;
the ribbon-ready wait stops after 30 seconds, build failures stop after three attempts, and `CDMENU` may retry.

The fresh re-audit correctly found that the old CUI implementation still physically existed in the modern DLL,
the AutoCAD ribbon getter was outside the idle failure boundary, `CDMENU`/repair recovery could queue UI work in
Core Console, net48 success wording was not proven and standalone help retained dead Manager actions. These are now
corrected: `WorkspaceMenuInstallerService` and `CuiMenuGeneratorService` compile only for net48; compiled modern
assembly guards prove their types and `LoadPartialMenu`/`UnloadPartialMenu` calls are absent; the whole idle handler
and cleanup path is guarded; Core Console cannot queue ribbon work; recovery reports the actual result; and the
standalone help/repair windows no longer direct colleagues to Manager.

The following re-audit found two final retained-legacy/native-event gaps: the net48 deferred document-activation
handler and banner failure handler did not guard their Idle unsubscriptions, and the net48 Civil toolbar layout still
created a dead `CEMANAGER` action. The cleanup and failure-reporting paths are now fail-safe across AutoCAD's native
event boundary and the standalone Civil toolbar layout contains Civil commands only.

Mechanical evidence after the final correction: focused ribbon/startup/legacy-menu checks 17/17 on net10 and
17/17 on net48; complete net10 suite 5,036 passed / 17 skipped with the same one unrelated existing pit-schedule
source-text failure; Release builds on net10 and net48 both completed with 0 errors. A prior v3.0.0 run may still
have left `CE_CVL_SUITE_MENU` partial-CUI state in Tim's AutoCAD profile. New modern source cannot create/load/unload
that menu; the full-restart acceptance must visibly check the loaded-menu/profile state and toolbar-name prompt.
No automatic profile mutation is authorised.

Fresh independent audit result: **ALL-ZERO** at head
`ebcf11b6e7a68cd79e1167857a56484acca73740`, tree
`e951c4ec04b1d56e091613b6d80a21db6f319e22`. The auditor independently confirmed 17/17 focused checks on
both targets, compiled modern absence of legacy CUI types/load calls, no Manager/Structural assembly reference,
Civil-only net48 toolbar contents, guarded Idle/native-event paths, headless isolation and zero build errors. Source
gate is cleared.

Exact package audit result: **ALL-ZERO** at head
`c35299ff69ccc93469f5687095ec3b61f52dd8c3`, tree
`6c1c217080e1a1fd86486cb65dd02431ec5f6a7c`. The independently audited v3.0.0 candidate is
`C:\Lisp Files\CE_ACAD_PLUGIN\.codex\worktrees\civil-v3-ribbon-package-audit\Installer\payload_build\CE_CVL_SUITE.bundle`.
It contains exactly 496 files and has OfficialReleaseGate content digest
`1C143FEAA11B17F8EBEE35168FD429100175820D66BAB812210838E9A9C5963E`. Staged DLL SHA256 values are Legacy
`F9F8A28E024657879780F475E0737B9E5C0A75C3F27C98D4B7EDBAF0E3EF942A`, Net8
`3C60DEC6BFD0E5307DF98DBD83B241F1E1F0362B8CEF542A109086C6E7D99E16`, and Modern
`92A8ADB7C5BF693D053BD5DDB84F0CC612A4A823B793446F4903B35F535F27B2`. Every staged DLL matches its exact
just-built DLL; all 51 advertised commands exist per lane; no Manager/Structural command, assembly or asset is
present; and the Modern DLL contains no legacy CUI implementation. Focused package and ribbon/host checks passed
37/37 on net10 and 37/37 on net48. Deployment and AutoCAD acceptance remain, so runtime stays FAIL. AutoCAD was
still open at the package gate and the live bundle was deliberately untouched.

### Stage 1 overnight mechanical campaign — 2026-09-01/02

The exact audited source `c35299ff69ccc93469f5687095ec3b61f52dd8c3` was exercised in a detached isolated
lab while AutoCAD remained open and completely untouched. The full modern test lane reported **5,037 passed / 17
skipped / 1 failed**; the sole failure was the same known existing unrelated
`PassiveStatus_IsSurfacedInPitScheduleAndInspector` pit-schedule source-text assertion. The combined ribbon,
package, command, grip/native-preview, twin-pipe, MLINE, pit-compounding, CDPARTS and CDEXPORTENTITIES safeguard
set passed **276/276 on net10** and **276/276 on net48**.

Release builds for Legacy, Net8 and Modern completed with 0 errors. Two clean same-path package builds each produced
496 files and the identical content digest
`86CD2410E979C8F4A6A8CA2EB1B0B5D911BB303D43DA16B08C7A06F37D6EA76B`, with zero file-ledger differences.
Their compiled hashes differ from the separately audited package because compiler output records the absolute
checkout path; therefore the regenerated lab package is repeatability evidence only and is **not** release
authority. The audited candidate hashes and the older live bundle hashes remained unchanged throughout. AutoCAD
remained open as PID 10200, so there was no deployment or runtime control. The next master action remains the exact
audited package deployment after Tim closes AutoCAD, followed by a full restart and the short Stage 1 field check.

### Stage 1 diagnosis progress — Civil attachment grips

The missing Civil role grips are now explained by source history rather than an AutoCAD display setting. Commit
`c160b175` registered `PipeAttachmentFlipGripOverrule` for linked pipe labels, invert text and arrows. During the
Version 3 integration merge `a198937b`, that registration and shutdown path were deliberately removed because the
overrule sat on normal DBText/MText/BlockReference grips and had broken AutoCAD/Structural transient drag previews;
the merged contract test explicitly requires AutoCAD to own those normal grips end-to-end.

Therefore the safe correction is **not** to re-enable the historical global overrule. The next bounded grip slice
must expose role-specific Civil actions only for exact stored Civil child identity while leaving ordinary AutoCAD
grips and their moving preview untouched. It must also fail closed for ambiguous ownership, locked layers, Xrefs and
REFEDIT. AutoCAD runtime acceptance remains mandatory because source tests cannot prove transient grip behaviour.

The UI/UX Control Room has now recorded Tim's approved presentation: one exact-owned pipe label, End 1 invert,
End 2 invert or flow arrow receives three CE actions — Slide along pipe, Offset from pipe and Flip Side — while
Reset Position remains in the hover menu. Native AutoCAD grips and moving previews stay unchanged. Multiple
selection and ambiguous, stale, locked, Xref, REFEDIT or temporary drag-copy evidence expose no CE action grips.
This clears the visual decision only; the bounded source implementation, independent audit and AutoCAD acceptance
are still required.

The bounded source implementation is now mechanically complete. It keeps the old point-grip fallback disabled,
asks AutoCAD for its normal grips first and appends standard trigger-only actions only for a current exact stored
pipe label, End 1 invert, End 2 invert or flow arrow. It does not replace AutoCAD's grip movement or draw a custom
grip icon. Slide and Offset show a cloned moving preview; Flip and accepted placements recheck exact identity,
locked-layer, Xref and REFEDIT protections before one final drawing write, then store only the exact child placement.
MLeader remains excluded for its separate behaviour rule. Reset Position is not yet implemented because the current
record does not truthfully retain an original/default placement; no default was invented.

The first independent source review correctly failed this checkpoint with six findings: the owning pipe's locked
layer was not checked, the shared link writer could hide a failed placement save, severe host failures were still
hidden in called helpers/startup, an unreadable REFEDIT state could continue, partial grip registration was not
fully tracked for cleanup, and a legacy unclassified item could pass using layer/text clues. All six are corrected.
The attachment and owning pipe must both be current-drawing, unlocked and writable; placement uses a strict writer
that must succeed before commit; uncertain REFEDIT state stops; severe failures propagate; every registered class is
tracked for exact cleanup; and only an explicit stored Pipe label, End 1 invert, End 2 invert or Flow arrow role passes.
Older missing ownership tags now require repair rather than being silently restored by the grip action.

The next independent re-review also correctly failed. It showed that the first corrected checkpoint had not actually
compiled its newest tests: a misplaced test variable meant an older built copy had been run, so its claimed 104/104
result was invalid. It also found that called object-identity, DBText-position/readability and current-context helpers
could still hide a severe failure before the new outer boundary. The test source and all cited helper catches are now
corrected. Both complete test assemblies were rebuilt without reusing previous outputs before any test result was taken.

Mechanical evidence after the second correction and full rebuild: focused grip/command guards pass **104/104** on net10 and **104/104** on net48; the complete
modern suite reports **5,063 passed / 17 skipped / 1 known existing unrelated pit-schedule wording failure**; and
safe Release builds pass with **0 warnings / 0 errors** on net10 and net48. AutoCAD and the live bundle were untouched.
The second corrected source remains runtime-unproven. It must enter a separately audited package before the
normal-preview, action, Cancel/Undo and save/reopen field checklist.

Fresh independent source re-review: **ALL-ZERO** at head
`888959fc81fcded0658fea3dde0af97dc52a6278`, tree
`5bc6b3f0f7b5b7d485ef67458b06c2310798b780`. The reviewer rebuilt both full test projects without reusing previous
outputs and then passed **108/108** focused checks on net10 and **108/108** on net48. It confirmed every prior finding
closed, normal AutoCAD grip movement remains untouched, MLeader and the old overrule remain excluded, and exact
identity/protection/Cancel/one-transaction/saved-placement ordering remains coherent. Source gate is cleared; a new
exact package audit and AutoCAD runtime acceptance remain mandatory.

### Stage 1 integrated package review — shared Civil settings correction

The first exact integrated package review at head `79b04e5827a600d742bc342e7ee3d2a8d025e977` is **on HOLD**, not
all-zero. Its three Civil program lanes, commands, ribbon guards, assets, ZIP ledger and standalone boundaries passed,
but `Contents\Assets\Config` was empty. The package builder looked in the old non-x64 build folder, which could exist
as stale local output but is not the official release build path. This omitted the six shared fallback settings files
used when a lane-local lookup cannot resolve them.

The correction now reads the official `bin\x64\Release\net48\Assets\Config` output and stops package creation if
that source is missing, empty, changed during copying or produces a different staged file count. Each copied file is
matched to its source by SHA256. The focused package-builder checks pass **11/11** on net10 and **11/11** on net48.

Fresh independent package review: **ALL-ZERO** at head
`cf751353a8673e2023d4ec482d6c5b80ab921ce0`, tree
`533d977aec9150d8e9c599c9bc2ec8458a6046df`. The exact candidate is
`C:\Lisp Files\CE_ACAD_PLUGIN\.codex\worktrees\civil-v3-stage1-package-cf751353\Installer\payload_build\CE_CVL_SUITE.bundle`.
It contains 502 files and has digest `3340834661997E016D229D2E40D9601CD0E25774C8D994C2F7ED60BF4DBD6975`.
All six shared settings match their official x64 Legacy source; all 502 ZIP entries match the bundle; all 51 advertised
commands compile in each supported AutoCAD lane; and Manager/Structural dependencies remain absent. Package/ribbon/
grip/twin/export checks pass **195/195** on net10 and **195/195** on net48. Pit/CDPARTS checks pass **106/106** on
net10 and **100/100** on net48. All three Release builds complete with 0 errors. The exact package was deployed with
AutoCAD closed on 2026-09-02; all 502 installed files match the audited source and all three program-file hashes match.
The package/deployment gate is cleared; full-restart AutoCAD acceptance remains.

### Stage 1 correction progress — CDEXPORTENTITIES

The `W26-26_C01.dwg` failure was traced to one AutoCAD item returning `eInvalidInput` while the export command was
reading or converting it. The source now isolates each Model Space item: readable items continue into the JSON,
while an unreadable item is logged and listed by handle and reason under `SkippedEntities`. The final command-line
message reports both written and skipped counts. No drawing write is performed.

The first independent source audit was **not all-zero**. It found that severe host failures were incorrectly treated
as ordinary unreadable items and that a heavily damaged drawing could create an unlimited detailed failure list.
Both findings are corrected: severe failures now stop safely; the exact skipped total remains available while detail
is limited to the first 100 items and each reason is capped at 512 characters.

Mechanical evidence after correction: focused export checks pass **10/10** on net10 and **10/10** on net48; the
complete modern suite reports **5,045 passed / 17 skipped / 1 known existing unrelated pit-schedule source-text
failure**; and net10/net48 Release builds complete with 0 warnings and 0 errors. AutoCAD and the live bundle were
untouched. Fresh independent source audit: **ALL-ZERO** at head
`efaba26c4b5e20c90e11113a277c04520e827c38`, tree
`a1c9607a9954704e58a5449752cfd0dd211ce945`; it independently confirmed both prior findings are closed, drawing
access remains read-only and the added JSON evidence remains compatible. Packaging/audit of the corrected integrated
candidate and a same-drawing AutoCAD rerun remain mandatory before this Stage 1 item passes runtime acceptance.

The corrected package passed its 2026-09-02 field export check: **1,110 entities written** and **21 unreadable items**
reported by exact handle and retained in the JSON evidence. The command completed without a crash or generic error.
This closes the Stage 1 export runtime item; it does not close the separate ribbon, Civil grip or twin-pipe failures.

### Stage 4 protected recovery — CDWT tank family

The missing later CDWT source has been recovered from the exact 2 September workspace safety snapshot and protected
on local branch `codex/cdwt-lost-source-snapshot` at
`629c67ee2eb6665deb7884005ec9af222b7d4b40`, with clean validation worktree
`C:\Lisp Files\CE_ACAD_PLUGIN_CDWT_SNAPSHOT`. The recovered material includes AW2500, AW4000 and AW5000S presets,
complete CE detail mappings, true-size plan geometry, tank-base/surface RL handling, the learning ledger and historical
evidence catalogue. Focused CDWT checks pass **134/134** on net10 and **134/134** on net48.

This is protected recovery evidence, not merge or release authority. The safety snapshot also contains unrelated
concurrent workspace material, so Stage 4 must selectively extract and review the CDWT-only change after the current
Stage 1 AutoCAD gate. Nothing was deployed; the live Modern DLL remained unchanged at SHA256
`789FF73428F9F4F03C3ED6C8949C11245EB697E6E0A06234ED87C541A6808EF3`.

Bounded continuation checkpoint `8686020eee959be3bbba4a6ce07bd42c4903205a` adds current All Weather `AW3000SX`
as a true-size plan preset at **2995 x 700 x 2010 mm**. The similar CE office detail is **3000 x 700 x 2010 mm**;
CDWT therefore blocks that 5 mm-different detail instead of stretching or falsely reusing it. An automated guard
holds this boundary. Focused CDWT checks now pass **135/135** on net10 and **135/135** on net48. This continuation
remains source-only and undeployed.

Checkpoint `2e125753` adds current All Weather `AW2000SB` as a high-confidence true-size plan preset at
**2000 x 680 x 2010 mm**. The read-only office master scan found other 2000 L details, including
**2400 x 570 x 2010 mm** and **2900 x 750 x 1200 mm**, but no exact complete AW2000SB construction-detail group.
Detail insertion therefore remains blocked rather than reusing a visually similar tank. Focused CDWT checks now pass
**136/136** on net10 and **136/136** on net48. AutoCAD PID 10200 remained open; nothing was deployed and the installed
Modern DLL hash remained `789FF73428F9F4F03C3ED6C8949C11245EB697E6E0A06234ED87C541A6808EF3`.

Checkpoint `beb66e50` adds current All Weather `AW2000SX` as an exact true-size plan preset at
**2400 x 565 x 2010 mm**. Current Oztanks and ASC supplier evidence agrees on the model and dimensions. The closest
office-master detail is **2400 x 570 x 2010 mm**, so that 5 mm-wider construction group remains blocked. An automated
guard proves it cannot be borrowed. Focused CDWT checks now pass **137/137** on net10 and **137/137** on net48.
AutoCAD PID 10200 remained open; nothing was deployed and the live hash remained unchanged.

Checkpoint `acd9d4f8` adds current All Weather `AW2000LL` as a true-size plan preset at
**2900 x 750 x 1200 mm**. That exact size appears twice in the office master, but construction-detail insertion stays
blocked until one complete isolated group and every replaceable project field are proven. AW2000SB, AW2000SX and
AW2000LL are now three separate current plan presets rather than one generic 2000 L tank. Focused CDWT checks pass
**138/138** on net10 and **138/138** on net48. AutoCAD remained open; nothing was deployed and the live hash was
unchanged.

Read-only detail audit `926d4efe` found two matching detention-only AW2000LL candidates containing fixed **30 mm
orifice**, **150 diameter overflow** and **1000 HEAD** wording; only the first isolated window also contains its
100 mm riser. Neither construction detail is released. Later engineering decision required: confirm whether
`1000 HEAD` is a fixed product/standard hydraulic head or must be calculated from the project's tank levels and
orifice IL. Until then, the plan preset remains available and detail insertion remains blocked. The read-only probe
passes on net10 and net48; nothing was deployed.

Checkpoint `67c8af77` adds current local All Weather `AW2000SSB` super-short as a high-confidence true-size plan
preset at **1680 x 780 x 2030 mm**. The supplier page confirms the SKU and dimensions; the office master has no exact
clean construction detail, so detail selection remains blocked. The current 2000 L All Weather catalogue now keeps
standard, super-slim, lowline and super-short footprints separate. Focused CDWT checks pass **139/139** on net10 and
**139/139** on net48. AutoCAD remained open; nothing was deployed and the live hash was unchanged.

Checkpoint `c4f25ae4` adds current local All Weather `AW2000SQ` at **2400 x 750 x 1550 mm** and `AW3000SB` at
**2350 x 745 x 2225 mm** as separate true-size plan presets. Neither has an exact clean construction group in the
office master, so both remain plan-only and cannot borrow an equal-capacity historical detail. An automated guard
proves the catalogue order is unique and increasing. Focused CDWT checks pass **141/141** on net10 and **141/141**
on net48. AutoCAD remained open; nothing was deployed and the live hash was unchanged.

Checkpoint `3ca621cc` adds current local All Weather round tanks `AW2000R` at **1180 mm diameter x 2050 mm high** and
`AW5000R` at **1800 mm diameter x 2150 mm high** as true circular plan presets. Above-ground tank validation now
accepts either rectangular length/width/height or round diameter/height dimensions. Historical round construction
details use different products and dimensions, so current round details remain blocked. Focused CDWT checks pass
**143/143** on net10 and **143/143** on net48. AutoCAD remained open; nothing was deployed and the live hash was
unchanged.

Checkpoint `d3d4f694` adds current All Weather underdeck tanks `AW1000UD` at **3000 x 1200 x 395 mm** and
`AW2000UD` at **3000 x 1200 x 690 mm** as manufacturer-specific true-size plan presets. They remain separate from
Melro and older CE details; no construction detail is released. Focused CDWT checks pass **145/145** on net10 and
**145/145** on net48. This continuation remains source-only and is not included in the deployed Stage 1 package.

Checkpoint `3fb2e3bd` adds current All Weather `AW1000SX` at **2000 x 400 x 1800 mm** as a true-size plan preset.
Generic 1000 L office evidence does not prove an exact construction group, so detail selection remains blocked.
Focused CDWT checks pass **146/146** on net10 and **146/146** on net48. AutoCAD was open for the separate Stage 1
field test; this tank continuation was not deployed and the installed Stage 1 Modern file remained unchanged.

Read-only issued-source verification is recorded on `codex/cdwt-overnight-continuation` at `970ae7f6` in
`docs/WATER_TANK_PROJECT_COMPARISON.md`; it changed no CDWT command source or live bundle. It confirms tank-owned
detention/orifice identity stays separate from a site OSD-pit orifice, tank-base RL stays separate from slab/top/TWL,
and multi-tank jobs need per-tank plus group authority. Prefill is allowed only where council, issued drawing and
calculation evidence agree. Orifice rounding and whether coincident slab top may only be suggested as tank underside
remain later engineering decisions. This evidence stays parked behind the Stage 1 grip gate.

Read-only approved-project evidence checkpoint `ffdc86e0` adds two further fail-safe boundaries without changing
CDWT source or the live bundle. Kingston-stamped evidence confirms two separate 2,000 L under-deck reuse tanks with
detention retained in separate SP1/SP2 wet wells; its historical anonymous **2950 x 1160 x 630 mm** layout is approved
topology/presentation evidence only and must not become a named current-supplier preset or create an inferred tank-base
RL. Bayside-stamped evidence confirms a combined SPS/underground-reuse-tank structure and its PIT/SPS routing, but the
approved drawing and calculation conflict on pump-2 start (**RL 15.41 versus 15.74**) and cover (**RL 16.55 versus
16.65**). Approval therefore does not erase field-level conflicts: automatic numeric adoption remains blocked until
engineering reconciliation. Remaining evidence gaps are a clean approved standalone underground tank example and a
current supplier match for the historical under-deck layout. This remains parked behind Stage 1.

## 8. Required delivery sequence

### Stage 1 — Stabilise the deployed foundation

1. Civil ribbon loads once without the toolbar-name prompt.
2. Ordinary AutoCAD grips show normal moving previews.
3. Civil label, invert and flow-arrow movement works.
4. Cancel, Undo and save/reopen retain exact placement.
5. Pit compounding and CDPARTS remain working.
6. Twin pipes compound and schedule correctly; record centreline-grip gap.
7. CDEXPORTENTITIES no longer crashes.
8. Correct any failure, re-audit and redeploy before widening the candidate.

### Stage 2 — Complete the core editors

**Visual approval gate:** before production WPF changes for each core editor slice, show Tim a realistic visual
mockup covering Insert/Update, drawing preview, engineering review and Cancel/Undo wording. Record his approval or
requested changes here; a written description alone is not approval.

**Autodesk-style visual checkpoint — 2026-09-01:** Tim approved a medium floating Properties-style window for
single-object Pipe/Pit editing, with `Inspect Drawing` temporarily moving it aside; the real AutoCAD drawing provides
zoom, highlight and ghost preview, with no permanent duplicate plan preview inside the editor. CDEDIT batch editing
uses a Panorama-style grid with explicit enabled fields and protected rows left visibly unchanged. Tabs versus one
stacked scrolling form remains open pending Tim's comparison of both visuals. No production WPF is approved yet.

~~~text
Shared editor shell
        ↓
CD Insert mode + PIPEEDIT Update mode
(one Pipe window)
        ↓
PIT Insert mode + PITEDIT Update mode
(one Pit window)
        ↓
CDEDIT routing + same-type batch editing
~~~

Tim authorised Codex on 2026-09-01 to own layout, hierarchy, wording and WPF build as well as engineering/data
services, topology, transaction, preview, Undo and highlighting. Visual controls still cannot invent Civil meaning;
the WPF-to-engineering authority boundary remains explicit and testable.

**UI/UX Control Room ownership — 2026-09-01:** task `01a037f4-b1e4-73c3-9dec-c0a923a09ebd` now controls all
Civil window, ribbon, command-discovery, editor-shell, wording, interaction, highlight, preview and presentation
decisions. This release Control Room retains engineering logic, evidence/data behaviour, integration and release
gates. Each area sends its required fields, actions, states, current behaviour and constraints to the UI/UX Control
Room before production UI work. No competing visual system may be started and no current function may be removed.

**Planning-only checkpoint — 2026-09-02:** the UI/UX Control Room has completed mockups and decision packets for
CD/PIPEEDIT, Pit/Schedule, Sources/CDWT, Slab System and Review/Calculations/Profiles at checkpoint `77ea1b55` on
`codex/civil-ui-ux-area-plan`. Survey/Import and Repair/Legacy/Settings are being prepared read-only. CD/PIPEEDIT
remains Tim's first visual approval gate. These packets do not authorise production window changes, builds or a
change to the Stage 1 release order.

### Stage 3 — Complete topology and Drawing Intelligence

1. Stable identity, relationships and provenance.
2. Exact/ambiguous connection criteria.
3. Bounded local reassessment after normal AutoCAD edits.
4. Explicit Connect/Disconnect/Ignore/Resolve decisions.
5. Pipe-to-pit physical fit warning from accepted pipe envelope, invert/level evidence and pit clear geometry.
6. CDCHECK and Show Where.
7. CDTRIM, CDEXTEND, CDBREAK, CDJOIN and CE-aware movement.
8. Locked-layer, Xref and REFEDIT protection.

#### Approved pipe-to-pit physical fit warning — 2026-09-02

When a pipe is connected to a pit, CE must check whether the proposed physical opening can fit within the pit and
coexist with its other connected pipes. This is always a **warning**, never a restriction: the user may continue and
the connection remains available.

- Use the accepted pipe outside envelope, wall thickness/shape where known, invert and crown/obvert evidence, plus
  the pit's accepted internal clear dimensions, base, walls and cover/lid structure. Nominal pipe diameter alone must
  not be presented as a proven physical fit.
- Check clashes with the pit base, walls, corners and cover/lid zone, and clashes or insufficient space between
  multiple pipe openings.
- Where the physical pipe envelope, pit clear geometry, levels or required clearances are missing or conflicting,
  report **Fit cannot be confirmed** rather than guessing or reporting Pass.
- Required wall, edge and pipe-to-pipe clearances must come from an approved part/manufacturer, company or project
  setting with visible provenance. Historical frequency must not silently create an engineering clearance.
- Show the exact pit and affected pipe(s) in the drawing through highlighting and **Show where**, with plain wording
  stating what may not fit and which evidence caused the warning.
- Recheck after an accepted pipe size, pipe type, invert, pit type/size/level or connection change. Surface the same
  result in PIPEEDIT, PITEDIT, CDCHECK and Project Review without blocking unrelated Civil work.
- Keep the user's accepted connection unchanged when the warning is acknowledged or left unresolved. Record the
  unresolved fit risk for later review; do not silently consume it as a confirmed fit.

#### Approved council rulebook (CR) — 2026-09-15

Tim's instruction: *"make sure all these documents and information is included in V3 plan and the plugin reads,
understands them and CE based design and drafting is working with this context."*

Thirteen council documents across ten councils have been read from the councils' own sources and written up in
`docs/workflows/COUNCIL_*.md`. The full specification — every rule extracted, every field the plugin has nowhere
to put, the errors found in the shipped data, the build order and the decisions Tim still owes — is
[COUNCIL_RULES_V3_INTEGRATION.md](workflows/COUNCIL_RULES_V3_INTEGRATION.md). That document governs this item.

The binding points:

- **Three kinds of council, not two.** Values *published* (Kingston, Frankston, Darebin, Banyule), values *issued
  on request* (Bayside, Monash, Boroondara, Manningham), or *computed by the designer to Australian Rainfall and
  Runoff and shown* (Mornington Peninsula, Whitehorse). The third has no representation in the data model. For the
  second, the plugin should **produce the enquiry from the drawing** — Boroondara names the five figures it needs
  and all five are measurable on plan.
- **Councils disagree in direction, not just in value.** Frankston gives multi-dwelling the shortest time of
  concentration (3 minutes) and Kingston the longest (7). Darebin publishes a discharge coefficient of 1.0 for a
  round orifice where CE applies 0.6 everywhere. Manningham requires storage pipes no flatter than 1:180 where
  Darebin and Banyule say 1:200. An office default is therefore wrong in both directions, and every engineering
  value must be held **per council with its source**, per the settings-first rule.
- **Most published rules currently land in free-text `warnings`.** The plugin can print them; it cannot check
  them. Turning them into fields is what makes design and drafting actually work with this context.
- **Freeboard is not one number.** Nine distinct rules are now recorded, each with a different *from* and *to*;
  several apply to the same job at once. Tim's ruling that floor level does not *set* the top water level stands —
  these are checks the top water level must **pass**.
- **Twelve confirmed errors exist in the shipped `council-profiles.json`**, each found by reading a council's own
  document against the stored value. `minUndergroundPct` was already wrong for Boroondara and fixed; the identical
  error at Banyule proves it is a pattern, so the file is to be **swept**, not corrected council by council as
  documents arrive.
- **Two councils independently confirm CE's own top water level rule** (obvert of the highest storage pipe at or
  below the top of the baffle wall — Darebin and Manningham), and three independently confirm the 1 m step-iron
  depth (Banyule, Manningham, CE office rule). Those office rules can be promoted from assumption to sourced.
- Every new check is a **warning that records, never a block** (R-27), and every new value is a **Settings entry
  with visible provenance** — Sourced, Assumed or Office rule — so the user can see which council document a
  number came from and override it with a recorded reason.

Build order and the eight gating decisions are in §5 and §6 of the integration specification. Steps 1 and 7 (sweep
the known errors; surface the council, document and edition on the job) do not depend on any pending decision.

### Stage 4 — Integrate completed specialist slices

1. CDWT complete CE detail families and automatic level evidence.
2. CDPROFILE content evidence, route confirmation and linked drawing output.
3. Slab System evidence, insertion, regeneration and material/feature views.
4. Calculation/catchment provenance and reviewed drawing application.

Integrate, retest, audit and field-accept each slice separately.

### Stage 5 — Project-wide workflows

1. CDSETUP guided start, LPD evidence and design sequence.
2. CDSURVEY and the single CDIMPORT workflow.
3. Project Review/issue readiness.
4. CDREPAIR, upgrade and Civil settings.
5. CDHELP visual guidance, diagnostics and safe support/error submission.

### Stage 6 — Staff release

1. Full automated suite and release builds.
2. Independent source and exact-package audits.
3. Tim representative-project acceptance.
4. Clean standalone colleague installation without Manager/Structural.
5. Small colleague pilot with rollback.
6. Correct findings and repeat affected gates.
7. Publish staff help, release notes and known limitations.

## 9. Tim testing policy

Tim is the final AutoCAD/engineering acceptance gate, not the primary debugger. Codex completes all safe automated
checks and audits first. Tim receives one short representative checklist per release slice:

~~~text
Action → expected drawing result → Pass/Fail
~~~

Cancel, Undo, save/reopen, locked layers, Xrefs and ordinary AutoCAD behaviour are explicit checks where relevant.

## 10. Release and change control

- A version number does not mean the full Version 3 program is complete.
- Controlled foundation candidates may use v3.0.x while the approved scope is completed.
- No deployment occurs without Tim explicitly confirming AutoCAD is closed.
- Every deployed DLL must match the exact independently audited package hash.
- New ideas enter the correct stage or Parking lot; they do not silently replace the active task.
- A workstream leaves Version 3 only through Tim's explicit decision recorded here.

## 11. Civil guided-workflow area register

Detailed research/planning may use separate area chats, controlled by this master task:
'01a0185e-7339-78e2-ad52-57980b223827'.

Every area chat must:

1. read this master first and quote its current gate/checkpoint;
2. treat this master as authority over chat summaries;
3. report findings, decisions, source status, checks and AutoCAD acceptance back to the master task;
4. update the master before handoff or context compaction;
5. inspect old projects and CE standard DWGs read-only before defining workflow;
6. use complete CE standard model-space detail groups where applicable, never a nested geometry component as if it
   were a complete standard detail;
7. fail safe on unproven engineering decisions;
8. never deploy without Tim explicitly confirming AutoCAD is closed and authorising that exact deployment;
9. avoid overlapping file edits and normally use no more than two active area workers at once.

| ID | Guided workflow area | State / control note |
|---|---|---|
| A | Project setup, planning documents, council rules and project evidence (CDSETUP) | Planned |
| B | Survey, surfaces, existing/proposed RLs and consultant imports | Planned |
| C | Legal point of discharge/outfall and authority connection | Planned |
| D | Catchments, roof/impervious areas, flow paths and CDCALC | **Planned — area plan written 15 Sep 2026: [AREA_D_F_CATCHMENTS_CDCALC_OSD_PLAN.md](AREA_D_F_CATCHMENTS_CDCALC_OSD_PLAN.md). Far more is already built than "Planned" implies; five decisions await Tim** |
| E | Pits, pipes, grades, sizes, labels and connected-network editing | Active through Stage 1–3 core work |
| F | OSD/detention design, orifice sizing and storage calculations | **Planned — see the D+F area plan. Tim, 15 Sep: CDCALC must PRODUCE the computations sheet, *"that's been the plan the whole time"*. `CalculationExportPackage` already exports most of it** |
| G | Water tanks, reuse, underground/underdeck tanks and complete standard details | Existing CDWT task '01a05643-e6cb-7793-9230-18b9951d99f5'; do not duplicate |
| H | SPS/pump stations, wet wells, pump controls and rising mains | Planned |
| I | WSUD/treatment: raingardens, swales, buffer strips, sedimentation and treatment devices | Planned |
| J | Overland flow, overflow paths, flood/surcharge evidence and surface safety | Planned |
| K | Profiles/long sections and plan-profile coordination | Source evidence exists; integration pending |
| L | Schedules, construction details, notes, issue QA and drawing-wide review | Partial foundations |
| M | Repair/legacy migration and linked-object integrity | Approved plan; implementation partial |

First planned independent pair after this master checkpoint:

1. **CE Civil V3 - Plan - Project Setup & Site Evidence** — areas A+B+C.
2. **CE Civil V3 - Plan - Catchments, CDCALC & OSD** — areas D+F.

These chats perform bounded read-only research/planning first. They must not compete with the current Stage 1
runtime stabilisation or edit the same production files.

## 12. Progress baseline

| Measure | 2026-09-01 estimate |
|---|---:|
| Behaviour/planning | approximately 95% |
| Intelligence/data/source implementation | approximately 65% |
| UI/UX implementation | approximately 35% |
| AutoCAD/staff acceptance | approximately 20% |

Overall Version 3 is approximately **50% complete**. These are planning estimates; update only when evidence changes.

## 13. Definition of 100%

Version 3 reaches 100% when:

- every retained workstream is implemented and integrated;
- source and exact package audits are all-zero;
- standalone Civil ribbon/commands work without Manager/Structural;
- real drawings pass Tim's representative acceptance;
- Cancel, Undo, save/reopen and native AutoCAD interaction are proven;
- a colleague installs and completes representative workflows;
- help, support, rollback, release notes and limitations are ready;
- GitHub contains the exact released source and immutable release identity.

Until then, resume from the first incomplete gate in this document.
