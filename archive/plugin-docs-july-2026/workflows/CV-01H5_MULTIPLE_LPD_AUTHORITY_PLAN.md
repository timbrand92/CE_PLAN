# CV-01H5 — Multiple legal points of discharge

**Status:** planning approved by Tim; H5A pure authority model independently
passed at `89d4bf9`; H5B1 passive drawing reader independently passed at
`ab372dc`; final H5B2 compatibility correction independently passed at
`dc9e971` and is integrated at `fdd98e4`; H5B3 exact endpoint authority
independently passed at `e827290` and is integrated at `3342dd0`; proposed WPF
visual still awaits approval; complete joined source re-audit passed at
`34d5e3c`
**Depends on:** CV-01H1–H4, current `CDLPD`, `LpdService`, ProjectData,
PITSCHEDULE and the one Civil Hub
**Deployment:** not authorised
**DATA-01:** remains blocked

## Practical result

One project may have two or more legal discharge points. CE must preserve each
outlet as its own authority and show exactly which connected network drains to
it.

```text
Project
├─ Network A → LPD 1 (for example, West Street kerb)
└─ Network B → LPD 2 (for example, East easement)
```

If one connected graph could reach both outlets, CE must not choose the
nearest or lowest outlet. Staff nominate graph-cut boundaries and assign each
resulting branch before preview. H5 does **not** divide one pipe or catchment
flow between two outlets: every pit, pipe and contributing branch belongs to
exactly one outlet. A genuine hydraulic bifurcation or proportional flow
allocation is `Unknown` / blocked until a separate engineering design,
approval and sizing increment exists.

![Proposed CE multiple-LPD window](../image/CV-01/cv-01h5-multiple-lpd-mockup.svg)

The complete state pack also shows the protected Fixed outlet, XREF read-only
view, blocked removal, Step 2 branch assignment and Step 3 full review:

![Multiple-LPD protected, XREF, conflict, assignment and review states](../image/CV-01/cv-01h5-multiple-lpd-states.svg)

## Required situations

| Situation | Required CE behaviour |
|---|---|
| Two separate networks | Keep one stable LPD authority and schedule relationship per network |
| One connected graph with two outlets | Require explicit graph-cut boundaries and one outlet per resulting branch; never guess or divide flow |
| Two Fixed council/survey LPDs | Preserve both levels, locations and outlet roles |
| Fixed plus Designed LPD | Protect the Fixed outlet; allow only the Designed role to change through preview/Apply |
| One LPD relocated | Preview only its assigned subnetwork and name every unaffected outlet |
| One outlet removed | Block while pits/pipes remain assigned; require reassignment first |
| XREF outlet | Read-only preview; direct staff to the source DWG |
| Old drawing with one LPD | Read exactly as today; migration occurs only on an explicit saved edit |
| Damaged/duplicate outlet identity | `Unknown` / Review required; no schedule or network write |
| Older plugin opened after a multi-LPD save | Fail visibly rather than silently treating one outlet as the whole project |

## Authority model

Each LPD requires:

- a stable, non-label identity;
- display name such as `LPD 1`;
- exact pipe end, pit and optional target-block identities;
- connection type and outlet invert;
- `Fixed` or `Designed` provenance;
- label/callout identities;
- assigned network/branch identities;
- source schema version and canonical authority-set fingerprint.

Display text is not identity. Renaming `LPD 2` must not break its network,
schedule or sign-off links.

The current single `CE_CVL_SUITE_LPD/DATA` record remains readable. A legacy
LPD receives a deterministic stable identity from its drawing identity plus
its exact pipe/end/pit/target identities; a damaged or incomplete legacy record
cannot be migrated.

Passive inspection never upgrades or dirties a drawing. Steps 1–3 keep the
proposed authority set in memory only. The window does not offer a misleading
separate Save. The existing H4 Apply writes the authority set, ProjectData,
labels, schedule and redesign together in one caller-owned transaction and one
Undo.

Once more than one LPD exists:

- the versioned authority set is the only engineering authority;
- singular callers must fail closed and must not return only the first outlet;
- H5D writes a capability Xrecord named `multi-lpd-v2` beside the immutable
  authority set and a persistent visible drawing marker owned by that set. The
  marker says `CE MULTI-LPD — Requires CE <minimum signed release version>` and
  stores its handle in the set. An older plugin need not understand the new
  Xrecord to leave that visible warning on plan;
- any later legacy `DATA` change is preserved as a conflict beside the
  authoritative set and cannot overwrite it;
- the separately approved and audited `RS-01C5` Release Manager increment
  records `multi-lpd-v2`, the required minimum signed Civil version and the
  drawing evidence; it blocks stage/activation/rollback to an older Civil
  bundle while any registered drawing still needs that capability;
- rollback to an older CE release requires `Convert to one LPD`: staff select
  the retained outlet, reassign/retire every other branch/outlet, review the
  full schedule, and use the same H4 one-Undo Apply to write one legacy LPD and
  remove the multi-LPD capability marker.

An older binary cannot be retroactively taught the new schema. Therefore a
multi-LPD drawing opened on an untracked older machine is visibly labelled
`Requires CE multi-LPD support`; older CE must not be represented as a safe
editing route. The immutable newer authority set remains preserved for
recovery even if an old singular mirror is changed.

## Interaction rules

The proposed window uses the approved CE dark visual language and three short
steps:

1. define/select each outlet;
2. assign connected networks or explicit branches;
3. review the complete outlet/network/schedule change.

Rules:

- one selected LPD at a time, with every project outlet always visible;
- explicit `Fixed`/`Designed` badge, never colour alone;
- action targets are at least 44 device-independent pixels high;
- visible keyboard focus and logical Tab order;
- `Escape` means Cancel/no write;
- `Enter` may continue between memory-only steps but cannot trigger or bypass
  Step 3 review, H4 sign-off or H4 Apply;
- every control, warning and status has an accessible name that remains
  equivalent in the compact net48 and enhanced net8/net10 presentations;
- descriptive labels for every field;
- `Cancel` changes nothing;
- `Continue to assignments` and `Review proposal` keep changes in memory;
- Apply remains the existing H4 full-preview/sign-off/one-Undo route;
- 100%, 125%, 150% and 200% DPI must not clip the list, warnings or buttons;
- net48 uses the compact fallback presentation, net8/net10 use the same
  information hierarchy with newer visual capability only.

## One engineering authority

H5 extends the already-built H1–H4 multiple-outlet topology; it does not add a
second solver.

- every connected component must have exactly one assigned outlet unless staff
  explicitly nominate graph-cut boundaries that create separate branches;
- each resulting branch, pit and pipe has exactly one outlet; H5 never allocates
  one pipe/catchment flow across multiple outlets;
- every branch assignment uses stable pit/pipe identity;
- no proximity-based assignment;
- each outlet subnetwork solves and validates independently;
- combined preview is proceedable only when every outlet subnetwork is
  complete and feasible;
- H4 protects and fingerprints the complete Fixed-LPD set, not one singular
  Fixed LPD;
- PITSCHEDULE and Inspector show all outlets and their assigned networks.

## Singular-consumer conversion map

H5B must convert or visibly block every existing singular route before H5D can
write two outlets:

| Existing route | Required H5 behaviour |
|---|---|
| `LpdService` read/set/clear/pit-handle APIs | Add set-aware APIs; singular APIs fail visibly when count is not exactly one |
| `CDLPD` | Open the one approved management flow; add/edit nominations remain in memory until H4 Apply |
| `CDLPDRESET` | Cannot clear one hidden “global” LPD; choose an outlet and prove all assignments are handled |
| Pipe endpoint ownership and hard-coded `LPD` tokens | Store stable outlet identity separately from display text; no shared ambiguous token |
| Pipe solve/profile/flow consumers | Resolve the pipe’s explicitly assigned outlet subnetwork |
| Inspector and CE Health/Repair | List every outlet; name duplicate/damaged/legacy conflicts |
| PITSCHEDULE discovery/build/update | Merge all qualified outlets and keep each source/network identity |
| H1–H4 current evidence, ticket and Apply | Bind the complete outlet set, every Fixed authority and every branch assignment |
| Label/callout attachment and movement | Update only the selected outlet’s owned presentation |

No exception handler may silently fall back to the first LPD.

## XREF ownership contract

- the authoritative LPD set lives only in the drainage source DWG;
- host identity is the composite of source drawing identity, stable LPD
  identity and source object identities;
- XREF instance identity/transform is presentation evidence, not a second
  engineering outlet;
- two instances of the same source/fingerprint deduplicate to one authority;
- same claimed source identity with different fingerprints or object identities
  is a visible conflict;
- unloaded or missing selected sources preserve the last proven status but
  block a new combined placement/update as `Could not verify`;
- a retargeted XREF is a new source until exact identity proves otherwise;
- the host PITSCHEDULE merges source-qualified rows only after every selected
  source is available and unique;
- Locate may select the host XREF presentation; edit/repair opens the source
  DWG;
- host commands never write, reload or dirty the source DWG in the background.

## Incremental build

### CV-01H5A — pure authority-set model

- immutable versioned multi-LPD model and canonical fingerprint;
- stable identity, provenance and duplicate/damaged-data guards;
- pure legacy-single-to-set migration codec;
- no Autodesk, WPF, drawing write or UI.

**Implementation boundary, 2026-07-24:** H5A now provides the AutoCAD-free
`multi-lpd-v2` model, validator, deterministic legacy codec, strict JSON
round-trip and canonical fingerprint. It preserves stable outlet identity
separately from the display name, records Fixed/Designed provenance and binds
exact outlet endpoint plus pit/target/label/callout and branch pit/pipe
identities. Multiple outlets require explicit, disjoint branches. Duplicate,
blank, damaged, unsupported or ambiguous evidence returns `Unknown` or
`UnsupportedVersion`; typed H1–H4 identities such as `PIPE:A1` and `PIT:B1`
remain intact while equivalent text handles resolve to one AutoCAD object.
One physical object cannot carry conflicting pipe/pit/presentation roles,
every outlet pipe/pit must be present in one nominated branch, every saved
member is mandatory and the largest accepted authority round-trips within the
JSON limit. Genuine shared-pipe/bifurcation allocation is blocked.
This increment does not read or write a DWG and does not change `LpdService`.
H5B remains a separate gate.

### CV-01H5B — read-only drawing adapter and consumer conversion

- read legacy single record or the versioned authority set;
- expose all outlets to Inspector, schedule discovery and H1–H4;
- singular compatibility calls fail visibly when more than one LPD exists;
- passive reads create no Undo and do not dirty the drawing.

**H5B1 implementation boundary, 2026-07-24:** the first H5B slice adds only
the passive source-DWG reader. It opens the existing
`CE_CVL_SUITE_LPD` dictionary and its records with `OpenMode.ForRead`.
`DATA` is decoded through the sealed H5A legacy migration in memory;
`AUTHORITY_SET` is the stable record name and schema versioning remains inside
its sealed H5A envelope. This ensures a future unsupported schema is read and
blocked rather than hidden behind a newly invented record name. The public
reader derives identity from the same AutoCAD database whose dictionary it
reads, so callers cannot substitute a host or stale identity. The stored
drawing identity must match that database identity. Missing, unreadable,
oversized, non-text, unsupported, damaged or wrong-drawing evidence returns
`Unknown` or `UnsupportedVersion` with no authority set. If both `DATA` and
`AUTHORITY_SET` exist, H5B1 reports a visible conflict rather than choosing one
or falling back to the old singular outlet. Fragmented text is bounded and
streamed without an eager array copy, with an exact maximum of 4,096 text
fragments before validation. Passive legacy conversion is never written
back, and this slice contains no `OpenMode.ForWrite`, transaction commit, Undo
record, geometry search or consumer integration.
Inspector, PITSCHEDULE, H1–H4 and singular-API conversion remain separate H5B
increments.

**H5B2 implementation boundary, 2026-07-24:** `LpdService` now exposes one
set-aware read entry point and delegates all drawing persistence reads to the
audited H5B1 reader. Existing singular data and pit-handle callers pass through
an immutable compatibility result that retains the H5B1 authority status,
source, every reason and outlet count. A singular result succeeds only for
exactly one proven outlet. No authority, two or more outlets, damaged,
unsupported, conflicting, wrong-drawing or unavailable evidence returns an
explicit fail-closed status/reason and no outlet data; input list order never
changes that result and no first outlet is selected.

The existing legacy pit-handle resolution order is preserved only after a
proven legacy-single record: stored pit, ProjectData connection/lower invert,
stored end index, then the existing 500 mm nearest-pit fallback. A versioned
authority with a stored pit returns that exact pit. A versioned target-only
outlet never enters geometry/nearest fallback, and multiple/Unknown/
unsupported evidence never invokes any resolver. The old boolean APIs remain
for binary/source compatibility, return `false` unless exactly one outlet is
proven, and write the explicit non-missing failure to CE diagnostics.
Every passive legacy `DATA` result is marked read-compatibility-only—even when
all later fields are populated—and cannot be serialized as `AUTHORITY_SET`.
Only the explicit reviewed `MigrateLegacy` route produces a serializable set.
The old JSON must contain both `PipeHandle` and `EndIndex`; a missing end no
longer defaults to 0, while an explicitly recorded 0 remains valid. Later
Phase-6 fields remain optional for old drawings.

H5B2 remains read-only: no write-open, document lock, transaction commit, Undo
record, passive migration or geometry-based outlet selection was added.
`SetLpdData`, `ClearLpdData`, `CDLPD`, Inspector, PITSCHEDULE and H1–H4
consumer conversion remain later H5B/H5D gates. Until that conversion,
`SetLpdData` and `ClearLpdData` now inspect the same reader result before any
write/erase. They proceed only when the drawing has exactly no LPD record or
one Complete legacy-single authority. `AUTHORITY_SET`, mixed, damaged,
unreadable or otherwise unverified evidence throws and rolls the caller
transaction back. This bounded guard prevents old `CDLPD`/`CDLPDRESET` from
creating a legacy conflict, erasing a versioned label or claiming an outlet was
cleared. `CDLPD` also performs the same guard before its label/layer/callout
route begins because the existing layer helper commits independently; the
`SetLpdData` guard remains as the persistence-time recheck. This is only an
early safety preflight, not a command-flow redesign or the future set-aware
writer. H5C WPF and H5D writer work have not started.

**H5B3 implementation boundary, 2026-07-24:** the AutoCAD-free
`MultiLpdEndpointAuthorityResolver` consumes only a proven complete H5
authority result plus an exact pipe handle and exact end index. It returns an
immutable result containing status, canonical pipe handle, end index, stable
outlet identity, display name, connection/pit provenance and the authority
fingerprint. It reuses H5A handle canonicalisation and never selects by record
order, distance, level or display text. Missing, damaged, unsupported,
duplicate, ambiguous or unmatched evidence returns no outlet metadata.

The first bounded consumer is the existing Inspector pipe-connectivity
warning. Its existing hydraulic From/To warning is preserved by default.
The warning is suppressed only when current pipe truth unambiguously maps
that same hydraulic side to the exact physical pipe end proven by the
complete authority set. Same-direction and reversed-flow pipes therefore
use the correct physical end without guessing. Missing or ambiguous mapping
and every no-match/Unknown/exception result preserve the original warnings.
This does not change the general Inspector summary, `LinkService`,
ProjectData, arrows, PITSCHEDULE, H1–H4, `CDLPD`, writers, commands, ribbon,
palette or WPF. Focused resolver/Inspector-decision coverage is 23/23 on
net48 and net10. After the final H5B2 guards are included, the integrated
H5A–H5B3 selection is 116/116 on both lanes (the isolated H5B3 candidate was
110/110 before those six guards were merged).
Release builds for net48, net8 and net10 complete with zero errors using
`-p:SkipDevBundle=true`. Independent candidate audit passed at `e827290` and
the complete joined source re-audit passed at `34d5e3c`.

### CV-01H5C — approved WPF management flow

- outlet list, add/edit/remove nomination and branch assignment;
- full current/proposed review;
- Cancel/keyboard/DPI/all three runtime presentations;
- command ownership remains `CDLPD`; no rival command or palette.

### RS-01C5 — capability-aware downgrade guard

- separately owned, approved and audited Manager/release increment;
- signed package metadata declares the minimum Civil version that understands
  `multi-lpd-v2`;
- before H4 starts any drawing write, Release Manager durably records a
  `Pending` downgrade guard bound to drawing identity, proposed authority-set
  fingerprint and minimum signed Civil version. If that registration fails,
  H4 Apply does not start;
- after H4 Apply succeeds, Release Manager confirms the same guard. If
  confirmation fails, `Pending` remains fail-closed and still blocks an older
  stage, activation or rollback until reconciliation proves the drawing state;
- stage, activation and rollback fail closed when the target Civil package is
  older than the drawing capability requirement;
- explicit `Convert to one LPD` completion removes the drawing marker and
  clears the guard only after successful conversion plus exact one-LPD
  drawing/fingerprint proof. Failed or cancelled conversion leaves the guard;
- H5D remains disabled until RS-01C5 package tests, downgrade tests and
  convert-back tests pass. H5 source must not make ad-hoc Manager edits.

### CV-01H5D — atomic save/apply

- hard prerequisite: accepted RS-01C5 capability/downgrade guard;
- explicit single-to-multiple migration and outlet edits occur only inside H4
  Apply, in one transaction;
- ProjectData, labels/callouts, Inspector and PITSCHEDULE reconcile together;
- removal requires prior branch reassignment;
- H4 ticket binds every LPD and each branch assignment;
- one Undo restores the complete prior authority set and drawing presentation.

### CV-01H5E — AutoCAD evidence

- one legacy LPD, two separate LPD networks and one graph-cut network with
  exactly one outlet per resulting branch;
- genuine bifurcation/flow-allocation request is blocked as `Unknown`;
- Fixed+Fixed and Fixed+Designed cases;
- Cancel, one Undo, Undo/Redo, save/reopen/rerun;
- damaged/duplicate/stale/XREF/read-only cases;
- downgrade block, legacy-marker conflict and explicit convert-back-to-one-LPD
  rollback;
- AutoCAD 2022–2024, 2025–2026 and 2027+ presentation/load proof.

## Release boundary

No implementation may:

- pick an outlet or graph-cut boundary by nearest geometry;
- divide one pit/pipe/catchment flow between multiple outlets;
- overwrite a Fixed LPD;
- mutate an XREF or its source drawing;
- make a passive migration write;
- hide a second outlet from older singular consumers;
- bypass H4 preview, sign-off, schedule review or one-Undo Apply;
- access DATA-01, package, deploy or touch ApplicationPlugins.
