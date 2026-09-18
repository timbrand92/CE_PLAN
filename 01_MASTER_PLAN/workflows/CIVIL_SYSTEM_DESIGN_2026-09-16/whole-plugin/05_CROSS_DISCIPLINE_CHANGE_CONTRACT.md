# One job across disciplines — evidence, changes and user control

FOR TIM

CE should recognise a changed source once, then show the consequences in the relevant drawing tools. Finding a new file is not permission to revise drainage, framing or issued sheets.

This is a planning contract joining the existing approved Civil, Structural, shared settings and Project-to-Issue decisions. It is not a new shared database, automatic engineering policy or implementation assignment.

## Keep these responsibilities distinct

| Information | Its authority | What the other areas receive |
|---|---|---|
| Job identity and seven current metadata fields | Existing shared project/manifest owner; later checked-by requirement remains separately reconciled | The same job context, never a second Civil/Structural job record |
| Drawing geometry, labels and approved object identity | Active DWG and the relevant object/relationship owner | Read-only observed state and explicit proposed changes; not a competing geometric model |
| Architectural backgrounds/views | Actual file/object/view/level evidence, confirmed by user where interpretation is needed | Scale/alignment/revision and identified features, with uncertainty retained |
| Engineer instructions | Selected document/page/revision and user-confirmed interpretation | Scoped instructions for the affected members/details; no guessed structural design |
| Civil authority and criteria | Per-outlet council/document evidence and adopted project decisions | Governing criteria by scope; multiple outlets do not inherit one another's conditions |
| Site extent, surface class and hydraulic catchments | Separate confirmed records linked to actual geometry or explicit manual values | Different meanings remain different even if the same polygon contributes evidence |
| Member/support/foundation relationships | Explicit or otherwise approved confirmed association | Connections retain provenance and validity status; proximity is not identity |
| Schedule content | Its approved object/size/source owner and reviewed overrides | Coordinated updates only for the chosen operation; independent edits leave visible discrepancies |
| Office assets and project copies | Governed library original versus traceable project copy | A revision comparison; never automatic replacement of a modified job detail |
| Issued documents | Exact reviewed issue-set evidence and verified saved output/history | Immutable comparison baseline; current drafting does not rewrite historic issue evidence |

## C-01 — automatic context without mandatory modules

Latest V3 scope expressly allows Civil to operate without Manager or Structural. The longer-term one-product direction must not become a mandatory runtime dependency or a folder-link wizard. Keep standalone drafting, Help, diagnostics and recovery usable when another module is absent. Where compatible shared pages exist, reuse them through the already-owned route; absence gives an honest fallback, not an empty imitation.

Project discovery and rich engineering/document interpretation are different operations. Drawing location can suggest a job record; it cannot prove which report governs, which architectural revision the engineer used, or that an overlay is aligned. Resolve those separately and preserve earlier confirmed choices.

Changing active DWG, entering a background-edit context, opening a second job, or saving a copy must re-evaluate the visible context before any Apply. A late result from one drawing cannot modify the next. Existing pending operations are cancelled/held with an explicit target rather than silently retargeted. No heavy startup scan is authorised by these requirements.

## C-02 — review a revised background

1. Discover the candidate file/version and distinguish identical copies from changed content. Display document identity/revision/status rather than selecting the newest timestamp as governing authority.
2. Compare old and proposed backgrounds in their actual view, level, host placement and clipping context. User confirms alignment. Overlapping plans from different levels must not merge into a single physical feature.
3. Show relevant consequences by discipline: roof/catchment extent, drainage source placement, member/support context, footing/slab boundary and sheet/detail references. A feature shift is a review trigger, not proof that a pipe/member is wrong.
4. Let the user accept clear portions and defer ambiguous ones. Preserve unrelated confirmed work and manual drawing presentation. Unknown thickness/depth/load/connectivity stays Unknown.
5. Only confirmed changed governing inputs mark dependent numeric results out of date. A newly discovered but unadopted drawing marks evidence review, not automatic recalculation or revised sizing.

**Example:** a roof outline extends in a revised architectural plan. Civil shows the possible catchment change while retaining the adopted manual area. Structural flags affected framing/background relationships; it does not choose new beam sizes. The issue view suggests affected sheets; it does not revise every page.

## C-03 — independent versus coordinated editing

The Structural operation-scoped choice **Edit this only / Edit together** is approved beside grips and in the right-click menu. The chosen scope is visible before commitment and ends on acceptance/cancellation. There is no newly approved universal starting mode or persistent global toggle.

| Action | Coordinated scope | Independent scope |
|---|---|---|
| Change a member's confirmed size | Reviewed member, label and schedule updates; affected details flagged for review | Only selected object changes. Related label/schedule/detail stays as it was and resulting discrepancy is retained for QA |
| Move a beam | Owned label follows under approved body action; supports remain in place; affected connections reviewed | Only selected object changes; do not silently propagate to owned or related objects beyond the selected scope |
| Move its label | Position changes independently and is remembered; geometry stays | Same selected-label operation; no member move or reattachment |
| Move a support | Highlight connected beams; no silent stretch | Selected support moves; retained relationships are reviewed later rather than silently disconnected or guessed anew |
| Change a slab boundary | Preview affected hatches/edges/thickenings/annotations before selected coordinated changes | Preserve related objects and show discrepancies for later review |

Keeping a relationship does not make it valid after movement. Returning to Edit together must not trigger automatic catch-up. Disconnect is separate and explicit. All paths continue to respect locked layers, Xrefs, REFEDIT and unsupported-object protections. Civil workflows retain their own reviewed semantics; this table is not permission to copy Structural propagation rules into pipe/pit commands.

## C-04 — status language with a precise cause

| Visible status | Trigger | What must not happen |
|---|---|---|
| Unknown | Required fact has no supported value | Replace it with zero/default or show a pass |
| Assumed | A working value is explicitly an assumption | Rename it Verified merely because the user confirms use |
| Manual / pinned | User deliberately selected value or presentation | Overwrite it during discovery/refresh |
| New evidence / Needs review | New candidate revision or relationship discrepancy | Change design solely from discovery |
| Numerically out of date | Accepted governing calculation input changed | Keep displaying an old result as current |
| Cannot calculate | Required calculation basis is unavailable/invalid | Fabricate a result; block unrelated drafting |
| Display override | Presentation intentionally differs from the engineering field | Treat display text as an unrecorded engineering change; source-specific plan-label rules still govern reviewed interpretation |
| Ready / Verified | Relevant deterministic checks and evidence actually establish that scope | Infer whole-job readiness from one passing module or unchecked sheets |

No universal confidence percentage can replace these states. A geometric support check passing does not prove structural adequacy. A structurally valid PDF does not prove engineering approval.

## C-05 — revision impact without duplicate approval work

One accepted change records its target, previous/current fact, scope, source/revision and manual rationale where applicable. Reuse that decision across dependent views rather than ask the user to re-enter it in a calculator, schedule and issue page. Only the appropriate approved owner writes each record.

Revalidation is scoped: a markup change concerning B1 reopens B1's relevant remembered departure; it does not invalidate unrelated accepted B2 notes. Conversely, a changed instruction must not inherit a stale exception merely because the item mark is unchanged. Repeated job choices may propose an office preference but require Tim's explicit approval before wider use.

Issue membership and revision membership are separate. Include unchanged sheets when making the full set PDF, while retaining their dates/revisions. Proposed folders/files are editable and reviewed. A plot failure leaves issue preparation unfinalised; retry reuses the reviewed revision intent and does not increment it again. Existing shared phased publishing/history work is reused, not replaced.

## C-06 — Undo/Redo after separate design and drawing actions

This is proposed cross-tool state review, not a new Undo command or a claim about AutoCAD internals. Preserve each owner's approved operation boundary and prove its actual restored state. A drawing Undo is not a global rollback of report adoption, settings files, exported files or issued history.

| User action | Required visible reconciliation |
|---|---|
| Undo an accepted pipe/member geometry edit | Read the actual restored object/relationship state through its owner. Recheck only affected dependants. Do not assume a result became Current merely because the visible line resembles its earlier position. |
| Undo a manual label move | Reconcile presentation and any draft that consumed its prior position. This alone does not change runoff, a member size or a calculation's numerical basis. |
| Undo a drawing edit after separately accepting report criteria | Retain the report fact's actual adopted state unless its own qualified operation was also explicitly reversed. The restored geometry may now disagree with that still-adopted basis; show the mismatch instead of silently reverting the report. |
| Undo a selected coordinated operation | Restore only what the qualified operation actually owned and restored; show any separate output/record that remains. A cross-tool transaction is not assumed from an Edit together label. |
| Undo/Redo a Structural Edit this only change | Recompare the actual member with its related schedule/detail state. Retain or clear the mismatch only as that comparison establishes; do not refresh the related views automatically or assume their currentness from the member's display alone. |
| Redo after another relevant value or source changed | Revalidate actual current scope and dependent status. Redo does not approve newer evidence, reuse a stale proposal's permission or overwrite unrelated manual work. Exact native availability/behavior remains to be qualified. |
| Undo after a file or issue output was completed separately | Keep the existing file/history identity intact. The current drawing can differ from the issued baseline; do not delete or relabel that issued evidence as though it never existed. |

An earlier result may only be described as current when the owning calculation/check can establish that its relevant numerical inputs, method, system identity and applicable evidence status match the actual state. An unchanged displayed number is insufficient proof. Conversely, restoring presentation alone must not cause a blanket numerical recalculation demand. Numerical freshness and source/relationship review remain separate where their causes differ.

**Fictional example:** a permitted-discharge criterion is adopted, then a pipe is moved. Undoing the pipe move does not cancel that separate criterion adoption. The engineer sees the restored geometry against the retained criterion and the actual affected result status. No report or pipe value is silently chosen to make them agree.

Future combined qualification uses an accepted drawing change, a separate report fact, a manual label move and a completed historical output. Exercise only the supported native Undo/Redo operations and inspect actual objects, saved/unsaved state, adopted facts and result/output identities. Record Unsupported/Unknown where restoration cannot be established. These cases were not run.

## Synthetic end-to-end scenarios for later implementation acceptance

| Scenario | Required observation | Current proof |
|---|---|---|
| Open a Civil job with Structural/Manager unavailable | Civil tools work; fallback Help/support remains; no invented shared-page success | Planning requirement; native proof outstanding |
| Two jobs open while a report is being reviewed | Result stays bound to original job; switching drawings does not retarget Apply | Planning requirement; native proof outstanding |
| Revised roof but old confirmed manual area | Review flag only; current calculation inputs remain pinned until confirmation | Bounded concept demonstrates distinction; no integrated ingestion |
| Copy a beam without its supports | Copy retains its approved owned label but gains no inferred support links | Existing approved requirement; native lifecycle proof outstanding |
| Same mark used at different levels | Level/view/source identity prevents unintended cross-level bulk edit | Planning scenario; no matching accuracy claim |
| Independent member edit, later coordinated operation | Quiet discrepancy remains; no automatic catch-up or sticky edit mode | Bounded concept only; native persistence outstanding |
| Workbook missing when schedule opens | Retain last known data with source/currentness warning; never substitute another file by name similarity | Planning requirement; route-specific source checks outstanding |
| Library detail revised after project modification | Side-by-side differences retain project changes; user selects adopted scope | Planning requirement; actual detail recognition outstanding |
| Four-sheet issue, two revised, one missing source | Missing sheet is explicit; no complete-output success; unchanged dates preserved on valid retry | Shared owner has newer mechanical checks; this overnight has not run them |
| New office rule version arrives | Job retains original rule version and offers scoped review | Approved settings requirement; cross-module native proof outstanding |

These scenarios define complete behaviour, not a list of performed AutoCAD tests. No calculation value, load, design adequacy, client issue or unreviewed engineering rule was adopted during planning.
