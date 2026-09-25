# CV-01J — Multi-level plans, network continuations and pit orientation

**Planning:** approved by Tim, 2026-07-24
**Implementation:** J1 independently PASS at `7200f93`; J2 independently PASS
at `61bdc29`; J3 compatibility/upgrade/rollback core built and tested,
independently PASS at `815f487`; separate bounded storage codec built/tested,
independently PASS at `ae83353`; J5A saved mapping/continuation authority PASS
at `374596e`; J5B1 read-only DWG continuation discovery built, tested and
independently audited PASS. The combined CV-01J source is integrated with
single-owner `PP` command truth, locked-layer fail-closed placement and
full-shape stale-geometry detection; final integration audit PASS at
`422e9e0`.
J5B2 paired-writer foundation and its three bounded audit corrections
independently PASS at `89a46f5`, integrated at `7c628e8`; live AutoCAD proof
remains pending.
J6 command/UI confirmation and all consumer wiring remain pending.
**AutoCAD verification:** not started
**DATA-01:** blocked; preset calibration must not inspect corpus/history

## The engineering rule

```text
BASEMENT PLAN                         GROUND PLAN
PP ── fragment A ── CD-S01  ···  CD-S01 ── fragment B ── P3
 \______________________ ONE LOGICAL PIPE PP → P3 _______________________/

Total developed length = A + proved/declared hidden gap + B
```

`CD-S01` is a display and plan-mapping link. It is not a pit, hydraulic node,
riser, dropper or second pipe. One persistent logical Pipe ID owns the type,
diameter, material, endpoint inverts, flow direction and total developed
length. Every Civil consumer must see that one pipe.

## Gravity and rising mains

| Pipe | Direction authority | Full-pipe result |
|---|---|---|
| Gravity | source pit/invert → destination pit/invert | grade over total developed length |
| Rising main | explicit pump/source → discharge destination | pressure/pump route using total developed length; no gravity-grade rejection or invert-direction guessing |

A split-plan continuation is always display-only. A future true vertical/riser
connection must have a separate type and must never be inferred from separated
plans.

## End-user workflow

```text
Insert pit → choose pit orientation → draw fragment 1
    → Continue on another plan
    → place linked CD-S01 pair from the saved plan mapping
    → draw/select fragment 2 to the real destination pit
    → confirmation card
       PP → P3 | Gravity/Rising Main | Ø/material
       A + hidden/mapped + B = total | grade or RM status
    → Confirm = one atomic logical pipe
      Cancel = no drawing/data change
```

One mapping point is allowed only when orientation and scale are confirmed
equal. Rotation or scale differences require two reference points.

## Existing UI ownership

- `PIT`: Manual / Align to pipe / Align to building. Building alignment uses a
  live parallel/perpendicular/side preview and an offset from wall line to pit
  outside face. The selected building is a reference only; placed pits do not
  follow it later.
- Cover-level placement: classify the clicked corner in the rotated pit's
  local axes, then return readable text to WCS. A local top-right click stays
  top-right even if its world Y is below the pit centre.
- `PP`: reuse the existing Pit popup in compact Quick PP mode. Fixed 350×350
  plastic pit; request cover, lid class, pit type, text/remarks and optional
  invert. “More options” reveals existing PIT controls.
- `CD`: add `Continue on another plan`, linked-pair status and the one-pipe
  confirmation card.
- `CDEDIT`: selecting any fragment resolves to the same logical pipe.
- `CDCALC`: gravity uses full-length grade; rising mains route to existing
  pump/pressure calculations.
- `PITSCHEDULE`: one row per real pit, never a continuation row; optional
  Plan/Level and Continuation information.
- Civil Hub Network Health: show actionable continuation and legacy-upgrade
  faults. No rival palette or new ribbon ownership.

## Compatibility and safety

Older drawings remain unchanged in Compatibility mode. `Upgrade this split`
must preview the conversion and keep a per-split rollback journal containing
the original records and entity fingerprints. Rollback fails closed if the
drawing no longer matches those fingerprints. Opening or saving an old drawing
must not silently convert it.

Creation/update is blocked for missing partners, duplicated pair/fragment
identities, mismatched logical Pipe IDs, wrong endpoints, conflicting
type/diameter/inverts, ambiguous transforms, moved anchors, stale geometry,
unknown hidden length, invalid fragment order/direction, gravity/rising-main
confusion, duplicate presentations or a cross-level pipe without a
continuation.

## Approved implementation slices

| Slice | Outcome |
|---|---|
| J1 | Versioned logical-pipe, plan, mapping, fragment and continuation model plus fail-closed validator |
| J2 | One canonical resolver; every fragment handle reaches one PipeData and one total length — independently PASS at `61bdc29` |
| J3 | Legacy detection, Compatibility mode, Upgrade this split and fingerprint-guarded rollback — safety core PASS `815f487`; strict bounded storage PASS `ae83353`; read-only discovery delivered in J5B1; atomic writer and existing-UI wiring pending |
| J4A | Manual / pipe / building pit orientation, WCS/UCS safe |
| J4B | Rotation-aware cover text, labels, hit areas and pipe connections |
| J4C | `PP` compact 350×350 plastic-pit insertion using the existing PIT popup |
| J5A | Saved plan mappings and paired continuation authority core — PASS `374596e` |
| J5B1 | Read-only DWG continuation discovery/reader; no placement/write/UI — source built and net48/net10 focused tests plus net48/net8/net10 release builds pass; independent slice audit PASS; combined integration now fingerprints full live polyline shape and remains fail-closed where live marker/note or anchor proof is not yet available |
| J5B2 | Paired `CD-S01` writer foundation: deterministic two-DWG locking, per-DWG Undo boundary, strict bounded pending/completed journals, whole-document save-stable canonical retry identity, two-DWG completed publication proof, mutation-aware reverse compensation, marker/text/anchor evidence and schema 1.1; independently PASS `89a46f5`, integrated `7c628e8`; live AutoCAD proof pending |
| J6 | Gravity/RM continuation staging, confirmation and atomic Confirm/Cancel |
| J7 | PITSCHEDULE, CDEDIT, CDCALC, labels/arrows and Civil Hub integration |
| J8 | net48/net8/net10 regression evidence and consolidated AutoCAD checklist |
| J9 | Preset calibration from approved anonymised project evidence; blocked by DATA-01 and a later Tim preset-table approval |

## J5B2 writer evidence and boundary

```text
Preflight both DWGs
  → lock DWG A, then DWG B in stable order
  → start one bounded Undo group in each DWG
  → write a pending journal in both DWGs
  → place both CD-S01 sides and hidden mapping anchors
  → validate the combined two-DWG evidence
  → write the same one-pipe record + completed ledger to both DWGs
  → read/discover only after both completed ledgers prove the same publication

Any mutation/finalisation failure → compensate both DWGs from their before-images
Compensation failure → repairable Incomplete state, never false Success
```

- Schema `1.1` adds stable drawing, marker and anchor identities. Strict
  schema `1.0` records remain read-only Compatibility data with their raw JSON
  unchanged; they are never silently rewritten. Future schemas fail closed.
- `CE-CD-CONTINUATION` owns one closed chevron, exact continuation-ID text and
  hidden mapping-anchor points per target drawing. Marker note evidence is
  keyed by stable Marker ID, not by cross-DWG handle uniqueness.
- There is no global cross-DWG AutoCAD transaction or global Undo. Each
  drawing has one bounded Undo group. The durable journals and reverse-order
  compensation are the cross-DWG recovery authority.
- Read-only, closing, saving, plotting, busy, arbitrary inactive/unapproved or
  protected-layer targets fail before placement. XREF write-through is not
  permitted; the future J6 host must approve exactly the two real target
  documents.
- The corrected focused selection passes 129/129 on both lanes: net48 has 120
  passes plus 9 intentional native-host skips; net10 has 125 passes plus 4
  intentional native-host skips. Release-build evidence is recorded in the
  regression log.
- J5B2 adds no command, ribbon, confirmation window, schedule/calculation
  consumer, deployment or passive migration.

### Live AutoCAD checklist still required

1. Cancel before Apply: `DBMOD` unchanged; no layer, entity, journal or Undo
   entry in either DWG.
2. Apply one approved pair: both saved writable DWGs show the chevron and exact
   ID on `CE-CD-CONTINUATION`; save/reopen preserves one logical pipe.
3. Run Undo separately in each DWG and prove each bounded drawing-side group;
   do not expect one global two-DWG Undo.
4. Lock/freeze/off the owned layer, then repeat with read-only, XREF,
   arbitrary inactive, closing, saving, plotting and busy targets: every case
   rejects with no partial write.
5. Move a fragment vertex or mapping anchor, change units/fingerprint, or
   supply a mismatched pair/pipe/plan/marker identity: Apply remains blocked.
6. Retry the exact completed proposal: no duplicate marker or pipe. Retry a
   conflicting proposal: reject.
7. Force a second-side failure: both before-images return. Force compensation
   failure: persistent Incomplete evidence remains available for repair and
   the operation never reports Success.

## Acceptance examples

- Rotations `0, 30, 45, 90, 135, 180, 270, 359°`: each local cover-text
  corner remains correct under WCS and rotated UCS.
- Gravity `PP IL 11.00 → P3 IL 10.00`, fragments `10 m + 8 m`, declared gap
  `2 m`: one `20 m` pipe at `5.00%`.
- Rising main `PP IL 10.00 → P3 IL 14.00`, same lengths: one `20 m` rising
  main with explicit pump/source and discharge; no gravity warning.
- Unknown hidden gap, moved mapping anchor, missing marker or stale fragment:
  Confirm/Apply disabled and no schedule/calculation update.
