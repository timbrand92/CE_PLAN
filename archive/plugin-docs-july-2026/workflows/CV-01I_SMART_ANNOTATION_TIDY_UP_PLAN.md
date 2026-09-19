# CV-01I — Smart annotation tidy-up

**Status:** visual and implementation proposal ready for Tim; not approved  
**Depends on:** permanent CE attachment identity, compound manual-offset
tracking, one read-only adapter over the current QuickMode/PipeText/Arrow
placement sources, Civil Hub
**Implementation:** not started  
**Deployment:** not authorised  
**DATA-01:** remains blocked

The broader smart-stack visual pack received `proceed` on 2026-07-24. This
hardened CV-01I pack adds explicit spacing authority, per-item release,
keyboard/DPI behaviour and three presentation tiers; those additions require
fresh explicit visual approval before I1 starts.

## Practical result

```text
Select a CE pipe network or explicit pipes
                    ↓
CE reads proven owned annotations + nearby obstacle extents
                    ↓
Preview:
Clear · Suggested move · User protected · Unknown / unsupported
                    ↓
Staff reviews and may deselect any move
                    ↓
One Apply / one Undo
```

![Current manual tidy-up compared with the proposed reviewed preview](../image/CV-01/cv-01i-smart-annotation-tidy-up-mockup.png)

![The same review state across Legacy, Modern and Fluent, with keyboard and DPI rules](../image/CV-01/cv-01i-smart-annotation-tidy-up-states.png)

CV-01I changes placement only. It never edits label text, levels, pipe sizes,
grade, flow direction, arrow direction, links or schedule data.

## First supported boundary

An annotation is movable only when its permanent CE attachment record proves
both its parent pipe and its role.

| Proven CE pipe attachment | CV-01I1 treatment |
|---|---|
| Pipe text | May suggest another approved position |
| Existing callout | Unsupported until its current layout path exposes a read-only candidate without writing |
| From-end invert text | May suggest approved positions around that physical end |
| To-end invert text | May suggest approved positions around that physical end |
| Flow arrow | May move along the same proven pipe; never reverse |

The first release does not move:

- pit labels, cover/invert labels or other Civil families;
- free notes, dimensions, leaders, tables or schedule graphics;
- unowned/ambiguous entities or anything inside an XREF;
- manually drawn arrows or text that merely look like CE annotations;
- locked-layer, erased, unreadable or unsupported entities.

These remain visible as `Protected`, `Not CE-owned` or `Unknown`. A later
separately reviewed increment may add proven pit annotations; CV-01I does not
infer ownership by layer, proximity, wording or colour.

Ownership is one-to-one. One permanent attachment identity must resolve to
exactly one live supported entity and exactly one parent-pipe/role record.
Two entities claiming the same attachment identity, one entity claiming
conflicting parents/roles, or COPY/PASTE/WBLOCK-insert metadata clones make
every involved item `Unknown`. None may be released or selected and Apply is
disabled until the existing identity repair workflow resolves the conflict.

## Placement authority

Every supported attachment gains one explicit placement authority:

| Authority | Meaning | Tidy-up |
|---|---|---|
| `Auto` | CE placed it and staff have not moved it | May suggest a move |
| `UserProtected` | Staff moved/rotated/flipped it | Never move unless staff release it |
| `LegacyProtected` | Existing drawing has no explicit authority record | Never move until reviewed |

`CDANNOTATIONEDIT`, MOVE, grip move/stretch, ROTATE, MIRROR and equivalent
native edits mark the final attachment `UserProtected` only after the AutoCAD
command succeeds. This classification must reuse the approved two-way-edit
command-end/Undo lifecycle; it is not a second post-command transaction or a
mid-command reactor write. One native Undo restores both the transform and the
previous placement authority; Redo reapplies both. Cancel/fail/Escape changes
neither and creates no Undo record. CE's own approved placement writer must
identify itself so its move remains `Auto`.

Existing drawings migrate fail-closed: a missing authority becomes
`LegacyProtected`, even when its current position resembles a CE default.
Staff may explicitly choose `Allow CE placement` for one item from the preview.
No distance threshold guesses whether an old position was manual.

## Clash and candidate rules

### Obstacles

The snapshot includes valid geometric extents for:

- CE and non-CE text;
- dimensions, leaders and tables;
- visible annotation/symbol blocks;
- every protected CE annotation.

Ordinary linework, pipe geometry, hatches and regions are not treated as hard
text clashes in the first slice. The parent pipe remains the placement anchor,
not an obstacle.

An unreadable extent makes the affected candidate `Unknown`; origin is never
used as a fallback. Loaded XREF contents are read-only obstacles only when
AutoCAD exposes reliable transformed child extents; they are never move
candidates.

An unloaded, unresolved, damaged or unreadable XREF is never treated as empty.
If its conservative transformed block-reference extent/envelope intersects
the selected network plus candidate-search envelope, every affected candidate
is `Unknown` and Apply is disabled. If even that reference envelope is
unreadable, the preview is `Partial` and Apply is disabled. The preview
fingerprint records XREF identity, load state, transform and the extents used;
load/reload/unload or transform change makes the preview stale.

The supported annotation's own parent pipe and its own expected leader/anchor
are excluded from false self-clashes. Sibling annotations remain obstacles.

### One placement seam — no new offsets

Current placement truth is split across:

| Role | Existing source CV-01I must wrap, not copy |
|---|---|
| Pipe text / segment | `PipeTextPlacementService`, `PipeTextSegmentChooser` and `QuickModeService.CalculatePipeTextPosition` |
| Endpoint invert | `QuickModeService.TryGetQuickInvertPlacement`, current settings and its existing offset constants |
| Flow arrow | `ArrowService.CalculateArrowPosition`, `ARROW_OFFSET` and `QuickModeService.ANNOTATION_LANE_SPACING` |
| Existing callout | The current `TextService.ApplyCalloutLeaderLayout` path; unsupported until a read-only candidate can be extracted without writing |

CV-01I1 creates one read-only `IAnnotationPlacementCandidateAdapter` over
those sources. I2 consumes only that adapter. The adapter returns the proven
role, finite candidate anchors and the exact existing offset/lane provenance;
it introduces no new offset, lane, clearance or position value. Missing,
non-finite, contradictory or write-only role evidence returns `Unknown` and
disables Apply.

The first clash rule is exact and conservative: valid transformed entity
extents must not overlap or touch. There is no invented clearance halo.
Spacing alternatives are only the discrete candidates already produced by the
existing offset and annotation-lane rules above. Candidate comparison uses
WCS geometry and the same unit conversion authority in every runtime lane.

### Finite candidates

CV-01I does not invent arbitrary XY positions. It asks the one adapter over
the existing placement sources for a small deterministic candidate set:

- keep the current placement;
- approved above/below position on the same segment;
- approved along-segment positions on another segment of the same pipe;
- existing callout candidates only after the current layout path exposes a
  read-only query without writing; otherwise the callout is `Unsupported`.

Invert candidates remain attached to their identified physical end. Arrow
candidates remain on their parent pipe with the same stored direction.
Every proposed anchor stays within 1,000 mm of the current anchor. If a clear
same-type candidate does not exist inside that envelope, the result is
`No clear position`.

Candidate ordering is:

1. preserve `UserProtected` / `LegacyProtected`;
2. avoid hard overlaps;
3. keep text readable and on its parent;
4. preserve the current side/segment where clear;
5. use the smallest displacement;
6. compare one canonical candidate key as the deterministic final tie-break:
   adapter source role, orientation-independent physical segment identity/index,
   side/lane, canonical WCS anchor and normalised rotation. Numbers use the
   shared invariant unit/rounding policy and strings compare ordinally.

If no clear candidate exists, the item stays where it is and reports
`No clear position`; CE never shuffles other protected annotations to force a
result.

Attachments are evaluated in ordinal order of their proven unique attachment
identity, never database/enumeration order. Current protected/unselected
extents are fixed obstacles. After one candidate is accepted, its proposed
extent is reserved as an obstacle for every later attachment. A final pass
checks every selected transformed extent against fixed and reserved extents,
including boundary touch. Two selected proposals can therefore never be
individually clear but mutually overlapping.

If no coherent set exists, the affected attachment reports `No clear
position` and remains unselected; CE does not silently keep an overlapping
proposal. Changing a per-item selection rebuilds the reservations and proposal
hash in the same canonical order.

## Immutable preview

The preview records:

- drawing/network fingerprint and selected pipe identities;
- each attachment/parent identity, role and placement authority;
- current position/rotation/anchor and proposed position/rotation/anchor;
- every obstacle identity and exact extent used;
- candidate score/rejection reasons;
- `Clear`, `Suggested move`, `Protected clash`, `No clear position`,
  `Unknown` or `Unsupported`;
- immutable proposal hash.

Staff see the drawing before/after, every proposed displacement and every
attachment in scope, including `Clear / no move` items. The item list groups
clear items but never removes them; the group count and expand route remain
visible. Suggestions start selected; each may be deselected with `Keep current
placement`. A protected item remains selected off and offers a separate
per-item `Allow CE placement` choice. That choice releases only that
attachment, never a family/network/global preference, and rebuilds the
preview. A staff-entered manual position is therefore either preserved or
explicitly released item by item.

## Scope and performance

- explicit selected pipes or one proven connected network only;
- maximum 250 pipes, 1,000 CE annotations and 5,000 local obstacle extents;
- maximum 12,000 total pipe vertices, 10,000 valid pipe segments, 16
  candidates per attachment and 16,000 candidate records per preview;
- the first record beyond a cap makes the preview `Partial` and disables Apply;
- deterministic truncation is forbidden: cap + 1 stops bounded enumeration
  and never means "use the first N";
- obstacle search is bounded to the selected network envelope plus the largest
  configured candidate displacement;
- no whole-drawing scan while selecting, MOVE, grip drag, zoom or pan;
- no reactor performs geometry reads or placement work;
- calculation uses an immutable snapshot off the event callback and returns on
  safe Idle;
- target: preview in 500 ms p95 at 250 pipes/1,000 annotations using synthetic
  extents.

This is model-space/local drafting assistance. Viewport/issue-sheet readability
and plot-scale QA remain with QA-01; CV-01I makes no issue-readiness claim.

## Apply and Undo

`CanApply` requires:

- preview is complete, current and not `Partial`;
- the host drawing is writable model space and not read-only, XREF, REFEDIT or
  an unsupported side database;
- every attachment identity remains unique and bound to exactly one live
  entity and one parent/role;
- every selected item still has the same parent/attachment identity,
  placement authority and transform;
- every selected target layer/entity is writable;
- no selected candidate is `Unknown` or newly clashing;
- staff tick `I reviewed the proposed annotation moves`.

Immediately before Apply, CE rebuilds the same canonical fingerprint. Any
difference invalidates the proposal.

One caller-owned AutoCAD transaction:

- moves/rotates only the selected proven attachments;
- persists exact placement and `Auto` authority for moved items;
- leaves content, flow/link metadata and schedule data byte-for-byte unchanged.

Any failure aborts the complete transaction. One AutoCAD Undo restores every
position and authority value. Cancel/Escape creates no write, DBMOD or Undo
record.

## Incremental build

### CV-01I1 — ownership and authority

- pure supported-role/authority model;
- one read-only adapter over the exact existing placement sources; no copied
  offsets, lane rules or second placement engine;
- one-to-one attachment/parent/role proof and clone-conflict rejection;
- safe `LegacyProtected` migration;
- post-command user-edit classification through the existing two-way-edit
  Undo/Redo lifecycle;
- no placement engine or WPF.

### CV-01I2 — pure clash/candidate engine

- immutable extents and finite candidate input;
- deterministic score and fail-closed Unknown;
- protected, rotated, dense, no-solution and symmetric equal-score cases;
- reversed candidate/input enumeration must produce the same selected
  candidate and proposal hash in net48, net8 and net10;
- swapped two-way/three-way candidate clashes reserve the same non-overlapping
  set or report the same `No clear position`, independent of input order;
- one huge polyline and one many-segment network hit cap + 1 as `Partial`
  without retaining a truncated candidate set;
- no Autodesk dependency.

### CV-01I3 — read-only Civil Hub preview

- implement the approved visual in the existing Hub;
- select pipes/network, compare before/after and deselect suggestions;
- no Apply until I1/I2 and their independent audits pass.

### CV-01I4 — atomic placement writer

- exact stale/identity/authority/transform recheck;
- one transaction and one Undo;
- save/reopen authority and rerun-idempotence evidence.

## Required situations

| Situation | Expected |
|---|---|
| Clear auto label | No proposed move |
| Two auto pipe labels overlap | Smallest deterministic clear move |
| Auto label hits a protected label | Auto label moves; protected stays |
| Two or three moves target the same clear space | Canonical reservations prevent overlap; input order cannot change the result |
| Protected label still clashes | Report `Protected clash`; no move |
| Legacy drawing | Every unclassified attachment starts protected |
| COPY/PASTE or WBLOCK-insert clones CE metadata | All duplicate/conflicting identities are Unknown; Apply disabled |
| Staff releases one protected label | Rebuild preview for that item |
| Pipe text has no clear inline position | Read-only callout candidate only if the adapter proves it; otherwise Unsupported |
| Invert near wrong pipe end | Never cross/rebind physical endpoint |
| Arrow clashes | Move on same pipe; direction unchanged |
| XREF text blocks a candidate | Treat as obstacle only |
| Loaded rotated/scaled XREF | Reliable transformed child extents are read-only obstacles |
| Unloaded/unresolved XREF intersects search envelope | Unknown/Partial; never assume missing contents are empty |
| XREF reload/unload/transform changes after preview | Stale; rebuild before Apply |
| XREF/locked/unowned candidate | Unsupported; no write |
| Invalid geometric extents | Unknown; never use drawing origin |
| Rotated UCS | WCS snapshot/result; same visible outcome |
| Symmetric equal-score candidates in reversed input order | Same canonical candidate and proposal hash in every runtime lane |
| Cap exceeded | Partial; Apply disabled |
| Huge polyline / many-segment network exceeds a geometry or candidate cap | Partial at cap + 1; no first-N truncation |
| Drawing changes after preview | Stale; rebuild |
| Cancel/Escape | No DBMOD/Undo/authority change |
| Native MOVE then Undo/Redo | Transform and authority undo/redo together; no stray CE Undo record |
| Apply failure | Every position/authority rolls back |
| Apply then Undo | Exact before state returns |
| Save/reopen/rerun | Authority survives; no repeated drift |

## UI and release boundary

The existing sole `CDINSPECTOR` owner opens the one Civil Hub/palette.
CV-01I contributes one page through the approved Hub registry. It adds no
command, modal window, palette, checker, placement authority or scan engine.
`CDANNOTATIONEDIT` remains the familiar manual doorway.

The page reuses the Hub 1216×698 first-open size, 900×600 minimum,
under-1100-pixel single-column reflow, 44-pixel action targets, keyboard focus
and no-horizontal-scroll rule. Text plus shape identifies every state at
100/150/200% DPI and across Legacy/Modern/Fluent presentation tiers.

The three tiers show the same scope, item order, reasons, per-item choices,
review checkbox and Apply state:

| Tier | Intentional visual difference only |
|---|---|
| CE Legacy · AutoCAD 2022–2024 | Native WPF borders and simple status strips |
| CE Modern · AutoCAD 2025–2026 | Modern navigation and InfoBar after compatibility proof |
| CE Fluent · AutoCAD 2027 | Window-scoped Fluent theme after compatibility proof |

Keyboard order is `Scope → preview → item list → per-item choices → review
checkbox → Cancel → Apply`. Arrow keys move through the item list; Space
toggles one suggestion; Enter activates the focused control only; Escape
cancels and changes nothing. Apply cannot become the default Enter action
until the review checkbox is ticked and all fail-closed gates pass. Focus
remains visible in all tiers.

At 100%, 150% and 200% DPI the same text and controls remain available. Below
1,100 pixels wide the preview, summary and item list stack into one vertical
column; the full reason text wraps and no horizontal scroll is introduced.
The visual state pack is presentation approval evidence only, not runtime
proof.

The same ownership, preview and one-Undo behaviour applies in AutoCAD
2022–2024, 2025–2026 and 2027.

Approval authorises planning-to-code for I1–I4 only. It does not authorise new
commands, pit-annotation movement, content/flow/schedule changes, issue-sheet
QA, deployment or DATA-01 access.

No implementation starts until Tim approves this plan and visual.
