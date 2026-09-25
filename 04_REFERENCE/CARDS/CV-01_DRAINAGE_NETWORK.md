# CV-01 — Civil pipe and pit workflow (drainage network)

**Planning:** approved
**Record:** complete — exact source recovered from the planning review chat, 2026-07-22
**Implementation:** CV-01E1/E2/E3 code complete — connected-flow resolution plus safe command-end geometry and owned-text editing; AutoCAD verification pending
**AutoCAD verification:** not started
**Design rules enforced:** one authority / one shared atomic core; identity over proximity; Unknown never a false zero; Fixed vs Designed provenance (solver never overwrites survey/council/locked); preview→apply→one Undo; idempotent solve; detect-don't-mutate; never silently rewrite an opened drawing
**Source:** planning review chat (this session) — Tim's posted CV-01 card (CV1–CV15), six refinements + Fixed/Designed + compatibility safeguard, and the CV16–CV25 safety layer, with assistant approvals

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification. CV-01 covers PIT → CD → CDEDIT → CDINSPECTOR → CDRUNSOLVE. Hydraulic values live in CV-02; schedules in PS-01; issue readiness in QA-01.

## Next planning priority — direct two-way plan editing

**Idea banked by Tim, 2026-07-23:** staff should be able to change a CE pit, pipe or annotation directly on
plan and have the linked drawing data, related labels and schedules update together, removing much of the need
to launch `CDEDIT`. `CDEDIT` remains a fully supported, equal workflow for staff who prefer to work in that
style; direct plan editing is an additional doorway, not a replacement or fallback.

```text
Direct AutoCAD edit
        ↓
CE identifies the owned pit / pipe / annotation and the changed field
        ↓
Obvious change: update the one authority and every linked view
Ambiguous engineering change: show Preview / choices before applying
```

Both doorways must call the same underlying edit service so the same change produces the same result:

```text
Direct plan edit ─┐
                  ├─→ one CE data authority ─→ labels + schedule
CDEDIT ───────────┘
```

The dedicated implementation plan is now approved and recorded in
`docs/workflows/CV-01_TWO_WAY_PLAN_EDITING_IMPLEMENTATION_PLAN.md`. It deliberately refines CV10 and CV18.
The plan must separate safe automatic changes (for example, an owned label move) from changes whose engineering
meaning is ambiguous (for example, moving a pipe endpoint, changing an invert text or stretching a pit). It must
reuse the shared identity, transaction, one-Undo and change-record core; it must not return to unsafe mid-command
reactor writes. Schedule refresh connects through PS-01D.

**CV-01E3 approved addition, 2026-07-23:** directly editing CE-owned pipe or pit
text must update the identified linked field and then refresh the proven flow
direction, flow arrow, related labels and PITSCHEDULE. Free remarks remain free
text. Ambiguous or invalid edits must not be guessed; they go to review. Text is
read only after AutoCAD's edit command ends, preserving the existing crash and
text-corruption guards.

**CV-01E4 approved addition, 2026-07-24:** the
[CD draw-first AutoCalc and connected-end preview plan](../workflows/CV-01E4_CD_DRAW_FIRST_AUTOCALC_PLAN.md)
is a mandatory behaviour gate before rebuilding the CD WPF window. Drawing a
pipe before the window opens must prefill AutoCalc from proven endpoint
identity. Preview and Flow / Inverts show both connected ends, such as
`PP → P3`. Polyline direction and hydraulic direction remain separate; an
opposite fall prompts the drafter and never silently reverses or swaps the
physical endpoint inverts. A confirmed result updates arrow, text, endpoint
roles and schedule together. Unknown, XREF, Cancel, Undo and save/reopen
behaviour remain fail-closed.

**CV-01G planning gate, 2026-07-23:** the dedicated
[Design-change impact preview plan](../workflows/CV-01G_DESIGN_CHANGE_IMPACT_PREVIEW_PLAN.md)
and current/proposed visual are ready for Tim. This remains an unapproved,
read-only proposal: no code, command, writer or deployment has started.

**CV-01H implementation gate, 2026-07-24:** the dedicated
[Network redesign / relocated-LPD plan](../workflows/CV-01H_NETWORK_REDESIGN_RELOCATED_LPD_PLAN.md)
and current/proposed visual are approved. H1/H2/H3A/H3B/H3C1 independently
pass. H3C1 joins those authorities into one read-only, fail-closed pipeline.
H3C2A now projects sealed, exactly bound and fully bounded ProjectData/impact
evidence into that pipeline and independently passed at `e7507f3`.
H3C2B now has one bounded read-only live-drawing authority shared with the
existing design-impact preview and independently passed at `c598d03`. H3C3
now adds the commandless, memory-only Civil Hub nomination flow and
independently passed at `a007bf7`. H4 now adds explicit end-user sign-off,
an exact fresh-drawing/schedule recheck and one atomic Undo. Exact source
correction `2612a2399ec1f6bf139cb694ab3a2b310bfe9863` also requires every
approved IL/grade/arrow annotation to open and rewrite successfully; MLeader
annotations use the same fail-closed rule. Exact follow-up
`d69a6a798263ae1dcb169add6cfd91cea8a8b42b` preserves the existing `IL`
prefix when inserting the approved invert value. Direct schedule-cell edits, damaged
or unwritable links, Fixed/XREF conflicts, REFEDIT, paper space, read-only
drawings and any stale preview block before writing. Formal independent
re-audit passed exact clean closure `90451c1` with no findings.
AutoCAD-visible Undo/save-reopen proof remains the release gate.
Fixed values, explicit outlet assignment and the one existing solver remain
mandatory.

**CV-01H5 multiple-LPD addition, 2026-07-24:** Tim requires projects with two
or more legal points of discharge to remain explicit and safe. The dedicated
[multiple-LPD authority plan](../workflows/CV-01H5_MULTIPLE_LPD_AUTHORITY_PLAN.md)
extends the existing H1–H4 several-outlet topology into the older singular
`CDLPD` drawing authority. Separate networks retain separate outlets; a shared
network requires staff to nominate the split and assign each branch. CE never
chooses the nearest outlet. Legacy one-LPD drawings remain readable, passive
reads do not migrate or dirty them, and every Fixed LPD remains protected.
The H5A AutoCAD-free authority-set model independently passed at `89d4bf9`.
It provides immutable outlet/branch identities, canonical
fingerprinting, strict legacy-single migration and fail-closed duplicate,
damage, ambiguity and bifurcation guards. Equivalent AutoCAD handles are
canonicalised without changing the existing typed `PIPE:`/`PIT:` identities,
one object cannot carry conflicting engineering/presentation roles, every
outlet endpoint is proven inside its nominated branch, and saved records
require every safety-critical member. H5B1 now adds the first passive DWG
reader: it opens only the existing LPD dictionary for read, converts one
legacy `DATA` record in memory or validates the stable `AUTHORITY_SET` record
through the sealed H5A schema and fingerprint. Keeping schema versioning
inside that one record means future unsupported content cannot silently fall
back to the old outlet. It blocks missing, damaged, unsupported,
wrong-drawing, oversized or mixed legacy/versioned evidence without choosing
the first outlet. Fragmented Xrecord text is streamed and bounded by both
total characters and an exact 4,096-fragment limit. The source identity is
derived from the same AutoCAD
database being read, so a host drawing cannot claim an XREF's authority; read
failures remain contained and fail closed. It has no writer or consumer
integration. Final controlled re-audit passed at `ab372dc`. H5B2 now routes
`LpdService` drawing reads through that one reader, exposes the complete set
and gives old singular data/pit-handle routes an immutable result containing
the exact authority status, source, reasons and outlet count. Those routes
succeed only for one proven outlet and never choose the first of two. The
existing ProjectData/end-index/500 mm pit fallback remains available only
after a proven legacy-single record; a versioned target-only outlet never
uses nearest geometry. Passive legacy reads are always non-serializable,
including fully populated old records; only reviewed migration may create a
versioned set. `PipeHandle` and `EndIndex` must both be present, so missing
endpoint evidence cannot silently become endpoint 0. Full `Set/Clear`,
`CDLPD`, Inspector, PITSCHEDULE and H1–H4 conversion remain later gates. A
bounded interim guard now blocks the
old Set/Reset writers before any erase or write whenever `AUTHORITY_SET`,
mixed or unverified evidence exists, so they cannot partly mutate or falsely
clear a versioned outlet. `CDLPD` runs that guard before its independently
committing layer/label route and rechecks at persistence; this is a bounded
safety preflight, not a set-aware command conversion. The WPF proposal and
remaining H5B→H5E gates remain separate and are not claimed. H5B3 now adds
one exact, read-only endpoint resolver over the complete proven authority
set. The existing Inspector pipe-connectivity warning keeps its original
hydraulic From/To warning by default. It suppresses that warning only when
the current pipe truth maps the same hydraulic side unambiguously to the
precise physical pipe end nominated as an outlet. Reversed flow therefore
maps to the opposite physical end without guessing. Missing or ambiguous
mapping, Unknown, unsupported, damaged, duplicate and unmatched authority
remain fail-closed. It never chooses by list order, proximity, level or
display text. No other Inspector surface, command, writer, label, arrow,
schedule or H1–H4 consumer is changed.
H5B3 independently passed at `e827290`, is integrated at `3342dd0`, and the
complete joined source independently re-passed at `34d5e3c`.

**CV-01I planning gate, 2026-07-23:** the dedicated
[Smart annotation tidy-up plan](../workflows/CV-01I_SMART_ANNOTATION_TIDY_UP_PLAN.md)
and current/proposed visual are ready for Tim. The visual pack now also shows
the same review state across CE Legacy, Modern and Fluent, plus keyboard,
resize, 100/150/200% DPI and fail-closed Apply states. This remains
unapproved as a hardened pack and needs fresh explicit visual approval before
I1. The first slice moves only proven CE pipe annotations, protects
legacy/manual positions, consumes one read-only adapter over the existing
QuickMode/PipeText/Arrow placement sources and never changes engineering
content or flow direction.

**Required worked case — reversed gravity flow:** line-drawing direction and hydraulic flow direction are
separate facts. Each invert remains attached to its identified pit/end, never merely “start” or “end.” If later
invert edits make the fall reverse, Preview must state the old and proposed direction, for example
`P1 → P2` becoming `P2 → P1`. Confirming updates arrow, inlet/outlet roles, FROM/TO labels, links and schedule as
one action. Equal/missing inverts remain **Unknown**; rising mains use their pump/design direction; Fixed
survey/council levels cannot be silently swapped or overwritten. The plan must also test rotated/copy/UCS cases
and any other feature that currently confuses geometry direction with engineering direction.

## Approved source card A — verbatim (CV1–CV15)

# CV-01 — Civil pipe and pit workflow

### Current condition

| Command | Assessment | Main issue |
|---|---|---|
| PIT | Keep + modify | UCS, label movement and save-speed problems |
| CD | Keep + modify | Many improvements exist but still await consolidated proof |
| CDEDIT | Modify | Remark duplication and several interface fixes need confirmation |
| CDINSPECTOR | Modify | Counts can disagree; drawing switching can fail |
| CDRUNSOLVE | Modify heavily | Existing/council outlet boundary is not properly modelled |

Several fixes are marked "coded" but not consistently confirmed across the logs; treat them as one combined verification package rather than a long list of tiny AutoCAD tests.

| ID | Recommendation |
|---|---|
| CV1 | Keep the existing CD pipe engine. Improve and consolidate it rather than rebuilding it wholesale. |
| CV2 | Make draw/select first the eventual default: select pits or draw the route, then CE reads the drawing and pre-fills the pipe information. Keep the current settings-first path until both behave identically. |
| CV3 | Allow drawing in either direction. CE shows the detected flow direction before applying and never silently reverses the pipe. |
| CV4 | Pit-to-pit pipes connect to the correct pit boundaries and write geometry, links and drainage data as one operation. Failure rolls everything back. |
| CV5 | Grades, inverts, cover and velocity suggestions remain advisory until the engineering rulebook is verified. Display values consistently to two decimals. |
| CV6 | Pipe text, invert text and flow arrows are placed automatically, avoid obvious clashes, remain manually movable, and preserve those positions after reopening. |
| CV7 | Keep the familiar PIT workflow and the approved PIT LABEL 2 block. Fix its behaviour without replacing the office standard. |
| CV8 | Pit geometry remains plan-readable and consistently aligned, regardless of the active UCS. The insertion location still follows the point selected by the drafter. |
| CV9 | Resizing or editing a pit preserves its label side and offset. Connected pipe endpoints and annotations update together as one Undo action. |
| CV10 | CDEDIT remains the single edit doorway: select a pipe or pit and it opens the correct editor. Batch editing will be reviewed separately. |
| CV11 | Editing uses Preview → Apply. Cancel leaves the drawing untouched; Apply is one Undo action. Existing manually adjusted annotation positions are preserved by default. |
| CV12 | CDINSPECTOR becomes the live inspection palette, not another home screen. It uses the same pipe/pit count as every other CE tool and survives drawing changes safely. Selecting an issue zooms to the object. |
| CV13 | Extend the existing CDLPD connection marker to store an explicit existing/council boundary and outlet invert. CDRUNSOLVE stops there and never redesigns council infrastructure. |
| CV14 | CDRUNSOLVE previews every proposed diameter, grade and invert change with a reason. Unverified rules appear as warnings, not claimed compliance. Apply is one Undo action and rerunning an unchanged design produces no changes. |
| CV15 | Automated tests cover WCS/UCS, save/reopen, Cancel, Undo, missing data, existing outlet boundaries, drawing switching and large networks. Your final AutoCAD check is one ≤10-minute end-to-end workflow—not dozens of old bug checks. |

```text
CV13 example
New development pipes → Last private pit → CDLPD: Existing/Council Connection
Stored outlet IL: 42.150 → Existing council system — solver stops
```

## Approved refinements — verbatim (six additions + Fixed/Designed + compatibility safeguard)

| Add to | Refinement |
|---|---|
| CV10 | Double-clicking a CE pipe or pit opens CDEDIT. Ordinary blocks still use AutoCAD's native editor. |
| CV13 | Support multiple fixed downstream boundaries per network: council connections or existing on-site infrastructure. Each stores its own outlet IL. |
| CV13/14 | Every important value is marked Fixed or Designed. The solver must never overwrite surveyed, existing or manually locked values. |
| CV14 | Run a network pre-check before solving: disconnected pipes, missing inverts, loops, conflicting boundaries and broken links. Clicking an issue zooms to it. |
| CV14 | If the drawing changes after Preview, Apply is disabled until the solution is recalculated. This prevents applying stale results. |
| CV4/9/11/14 | Use one shared atomic core for read, preview, apply, rollback and Undo—not separate versions inside each command. |

```text
Fixed versus Designed
Council outlet IL     42.150   🔒 Fixed
Surveyed pit lid RL   45.320   🔒 Fixed
Private pipe grade     1.00%   ✏ Designed
Upstream pit IL       43.210   ✏ Designed
CDRUNSOLVE may change the Designed values. It cannot change either Fixed value unless the user explicitly unlocks it.
```

**Compatibility safeguard (existing CE drawings):** Open older drawing → read existing CE pipe/pit data → report missing or outdated information → preview safe upgrade → user approves → one Undo. It must never silently rewrite an older drawing merely because it was opened.

**Logged interpretation (Tim, review):** hand-typed value defaults to **Designed** (solver may refine), with a one-click 🔒 lock and every solver change previewed with a reason — so nothing is changed invisibly and "this is Fixed" is one click away. Flip to Fixed-by-default if staff prefer.

## Approved source card B — verbatim (CV16–CV25 safety/integrity layer)

| ID | Recommendation |
|---|---|
| CV16 — Units/datum | Confirm metres/millimetres and AHD/local datum before calculations. Block solving if they conflict. |
| CV17 — Connection tolerance | Connect only when an endpoint genuinely touches or is explicitly assigned to a pit. Never link to the "nearest" pit silently. |
| CV18 — Native edits | If someone uses native MOVE, STRETCH or grip editing, mark the network Needs review instead of silently recalculating it. |
| CV19 — Deletion safety | Deleting a pit shows its connected pipes and consequences. Cancel changes nothing; confirmation removes or disconnects everything cleanly. |
| CV20 — Copy safety | Copied pits and pipes receive new permanent identities. They must not remain secretly linked to the originals. |
| CV21 — Branch solving | At pipe junctions and multiple outlets, show exactly which branches will be solved. Never choose an outlet silently. |
| CV22 — Change record | Record who/what changed each design value: survey, user, import or solver—plus time and previous value. |
| CV23 — Performance budget | Normal drafting remains responsive. Large-network checks run at idle; dragging, zooming and selecting must not trigger a complete solve. |
| CV24 — Drawing health banner | Inspector shows a simple status: Current, Needs review, or Blocked, with the next useful action. No repetitive pop-ups. |
| CV25 — Safe corruption handling | If CE data is incomplete or damaged, preserve the visible drawing, disable unsafe calculations and offer a repair preview. Never guess silently. |

```text
Native-edit protection example
Drafter grip-moves a pit → connected pipe geometry updates visually
→ network becomes ⚠ Needs review → Inspector lists affected pipes → Preview → Apply or Restore
```

Scoping ruling (Tim): anything beyond CV25 — hydraulic standards, QA requirements, drainage schedules and AI design assistance — belongs in its own command card (CV-02, QA-01, PS-01, Ask CE / EV) so this flagship workflow does not become oversized.

## Timothy's approval and refinements — verbatim

### Approval 1 — CV1–CV15

✅ CV1–CV15 approved. This is the flagship card — the commands that generated the most bugs in the whole audit (CD/CDEDIT alone ~39 IDs) — and it's strong because it attacks the **root causes**, not the symptoms.

| Bug chain that burned you before | Fixed at root by |
|---|---|
| Invert-text side flipping (BUG-021→123→130→075→078, 5 rounds) | CV9 (label side/offset preserved; endpoints+annotations one Undo) |
| Two sources of truth diverging (BUG-058/059/060) | CV4 (geometry + links + data as one operation, rollback on failure) |
| Manual annotation positions lost on reopen | CV6 + CV11 (positions stored as truth, preserved by default) |
| Inspector count ≠ pipe label (BUG-026/127) | CV12 (same count source as every tool — one authority) |
| CDRUNSOLVE "no invert to anchor on" (BUG-056) | CV13 (the council boundary) |
| Pipe silently reversed | CV3 (show detected direction, never silent) |

🏆 **CV13 is the standout** — it fixes CDRUNSOLVE's root failure by modelling the real engineering boundary: you design *to* the council connection, not *through* it. Generalisation approved: support more than one existing/council boundary per network, "existing" meaning any known-fixed downstream connection (council or existing on-site), each with its own outlet IL.

🔧 Three build notes: **(1)** CV4/CV9/CV11/CV14 all lean on the *same* foundation — build the atomic write + one-authority read + preview/apply core **once**; re-implementing per command re-creates the parallel-code-path disease (rule #1). **(2)** CV14's idempotency ("rerun unchanged → no changes") depends on rule #8 (one rounding helper) — the `Math.Ceiling(0.05×100)=5.000…1 → 1.10 shows 1.11` drift is exactly what breaks it. **(3)** CV5 decouples the workflow from the rulebook — build all the mechanics now with numbers shown as advisory, flip advisory→authoritative when §11's AS/NZS values land; you are not blocked on the scour numbers to build this card.

📝 CV10's "single edit doorway" should include the double-click path (PL-069 — double-click a pit currently opens native BEDIT).

### Approval 2 — the six refinements + Fixed/Designed + compatibility safeguard

✅ All six refinements + the compatibility safeguard approved — CV-01 decision-complete.

🔒 **R3 (Fixed vs Designed) is the keystone.** A solver that can overwrite a surveyed RL or a council outlet IL produces a drawing that looks solved but contains fabricated survey data — the worst possible "confidently wrong." Locking Fixed values out of the solver is the most important protection on the card. The one thing pinned: default provenance per source — imported survey → 🔒 Fixed auto; council/CDLPD boundary → 🔒 Fixed auto; CE-computed → ✏ Designed; **hand-typed → logged as Designed-by-default + one-click lock + every change previewed** (flip to Fixed-by-default if staff rely on typed input being respected). Guardrails: Fixed status survives save/reopen; unlocking is a deliberate, logged action.

Affirmed: **R1** correctly scopes double-click to CE objects only; **R4** pre-check before solve is the right order (and "conflicting boundaries" is only detectable because of R3); **R5** stale-preview lock needs a cheap drawing fingerprint; **R6** one shared atomic core, built once, ends the parallel-code-path disease. **Compatibility safeguard** strongly endorsed — build note: store a CE-data **schema version** in the drawing so the open-time check is a cheap version compare, not a full rescan (keeps it off the PD6 open-lag path).

### Approval 3 — CV16–CV25 (safety/integrity layer); CV-01 closed

✅ CV16–CV25 approved — CV-01 closed. This last set is the integrity & safety layer, and it converts every silent-failure/reactor-crash/silent-mutation root cause into detect → flag → preview → apply.

- **CV18 (native-edit → "Needs review", not silent recalc)** is the most important — the direct answer to the crashiest pattern in the codebase (reactors reading objects mid-edit, BUG-053/054). CE observes and flags rather than auto-mutating.
- **CV16 (units/datum before solving)** kills the mm-vs-m bug that once produced a 47.86 m fall.
- **CV22 (change record: who/what/when/previous)** completes Fixed-vs-Designed — together they give full auditability ("why is this invert 43.21 and who set it?").
- **CV20 (new identity on copy)** rides on CV18's change-detection — a copy is another native operation to detect; build them on one detection core.
- **CV19 (deletion shows consequences + counts)** and **CV25 (damaged data → preserve visible drawing, disable unsafe calcs, repair preview, never guess)** round out the fail-loud posture.

CV22 note: bound the change record (keep last N per value) so a long-lived drawing doesn't bloat.

🔒 CV-01 is decision-complete and closed: draw, connect, edit, inspect, solve — plus the atomic core, Fixed-vs-Designed provenance, and the full safety/integrity layer — built to end the "fixed 5 times, still broken" pattern for the most-used commands.
