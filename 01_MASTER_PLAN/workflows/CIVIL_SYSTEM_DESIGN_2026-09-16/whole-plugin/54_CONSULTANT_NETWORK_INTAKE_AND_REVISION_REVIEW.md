# Consultant network intake — ordinary first import and later revision

FOR TIM

Review the consultant network against the architectural background before placing CE pits and pipes. A later file shows what was added, changed or removed; it does not wipe the previous import or your manual levels merely because its date is newer.

This is detailed planning under approved CV7, not permission to expose the hidden import commands. X-Civil/LandXML remain hidden until the drafting-quality gate passes. Use the approved Review destination and retain standalone Civil access. No client package was read in this pass.

## Source and authority

[Approved CV7 requirements](13_CIVIL_APPROVED_DECISION_RECONCILIATION.md) govern: survey ground levels; LandXML structured network; DWG plan evidence; schedules corroboration; CE rules engineering checks. Preserve units, transform, source fingerprint/revision and original Z/RLs. No manual alignment pick-points or flatten-to-zero; ambiguous alignment blocks Apply. Raw corpus export stays disabled under its separate approval gate.

Actual caller inspected: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Drainage\Commands\LinkCommands.ImportXcivil.cs`, lines1–315 only. Both import callers initialise and call SyncWithDrawing before the file choice. Xcivil supports a configured source or picker; its package branch runs only when the resolved path is a directory. The picker title's package language is not proof that picking any file converts it into a folder. Prior-import detection offers Replace/Abort with Replace as the default; the service then imports before report/log writes. This observation does not establish cleanup completeness, preserved overrides, or an atomic service operation.

LandXML offers a same-stem file near the last source. Its caller only explicitly clears that candidate on an OK/No response; other statuses leave the candidate for the next branch. Therefore Escape at that question is not shown to stop the import in this caller. This is a source-level concern, not a reproduced AutoCAD failure. The header's flatten-Z comment is not proof of service behaviour and cannot override approved Z retention. Import service internals were not traced in this pass.

The existing comparison/read-only snapshot contract remains in13/18. This card does not claim these import callers are read-only, or that a missing report means no drawing changes occurred.

## Proposed daily sequence

| Stage | What the engineer sees and decides |
|---|---|
| Select source | Exact selected DWG/XML and any associated evidence, revision and current target drawing. Auto-discovered related files are candidates; a last-used file from another job never becomes governing silently. |
| Establish basis | Units, coordinate alignment, level datum and source role with evidence. Unknown scale/datum stays Unknown; no guessed conversion or zero level. Preserve source Z separately from plan transformation. |
| Review overlay | Large plan overlay against architectural Xref; recognised, skipped, missing and conflicting objects visibly distinguished. Show actual transform and applicable limitations. Ambiguous alignment prevents Apply; no workaround by manual alignment picks. |
| Inspect objects | Select a proposed pit/pipe to see source identity, type, geometry and numerical values beside current CE values. Invalid or unsupported items remain explicit; do not substitute a vaguely similar native asset. Council infrastructure remains Fixed. |
| Review output | Native CE assets and their proposed relationships, not imported graphic clutter. Crossings/proximity do not create hydraulic topology. Show incomplete endpoints or conflicting identities rather than fabricating connectivity. |
| Confirm operation | Name the selected supported change scope and previous import affected. A comparison is not a command to delete/reimport. Where safe selective application cannot be qualified, keep the review pending rather than claiming unsupported merge capability. |
| Read receipt | Added/updated/retained/skipped/failed/unknown records and geometry, plus separate report saved/failed status. Drawing changes are not proof of a saved DWG. Retry begins with actual state inspection. |

The comparison remains genuinely non-writing: no hidden sync, relink or move. Show whether evidence represents the current unsaved drawing or a saved snapshot; do not call a disk-only comparison current when the open drawing has edits. Reports use the approved output location, not whichever legacy temp/log path happens to exist.

## Revision example — fictional identities only

An earlier import has pits P-A and P-B connected by L-A. The new source changes P-A's level, adds P-C and omits P-B. P-A has an explicit manual adopted level in the CE drawing.

1. Stable source evidence proposes P-A as changed; show old source, new source and retained manual value. The manual value stays governing until the engineer confirms a change.
2. P-C is a proposed addition, not already adopted merely because it parsed successfully.
3. P-B is missing from this source revision. Omission is not automatically a deletion instruction: show affected pipes, labels and dependent records and qualify source coverage first.
4. A match based only on a repeated label or nearest location is ambiguous. Keep both identities visible for review; do not duplicate or merge silently.
5. Confirmed numerical/topology changes identify actual affected calculations and schedules. A candidate revision alone marks evidence for review without replacing the numerical basis.

No particular partial-merge mechanism, source-ID mapping, transform algorithm or replacement policy is declared built. These are implementation-owner evidence requirements within approved stable-identity/override preservation, not new engineering decisions for Tim to repeat.

## Cancellation and verification requirements

Before confirmation, Cancel/Escape must stop the proposed operation and retain the prior import. Early setup effects in legacy callers require owner qualification; do not claim existing full rollback. After accepted partial work, report the actual result rather than relabelling it cancelled. AutoCAD Undo, source-record persistence and report-file recovery have separate boundaries.

Future representative check: first qualified import; ambiguous units/alignment; suspect survey point; same-source repeat; revised source with pinned level; omitted pit with connected pipe; unsupported asset; Escape at auto-detected XML question; output-write failure after geometry work; save/reopen and drawing Undo. Inspect the actual preview/geometry/records, not just counts or messages. These cases were not run.

Planning only. No source edits, build, import execution, corpus access, deployment or new Tim acceptance in this pass. [Independent bounded audit passed](audit/coverage/CONSULTANT_INTAKE_DAILY_AUDIT.md); overall run's earlier search incident remains recorded in00.
