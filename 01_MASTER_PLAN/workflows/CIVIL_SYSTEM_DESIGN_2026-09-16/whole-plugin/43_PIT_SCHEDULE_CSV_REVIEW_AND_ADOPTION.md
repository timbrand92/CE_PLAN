# Pit schedule CSV — inspect, match and confirm differences

FOR TIM

Choose the file, inspect its columns and every difference, then confirm the intended rows. An imported pit number does not establish which physical pit it belongs to.

## Authority and actual source boundary

PS15 retains export and requires import to preview every difference and identify its source; PS2/8/10/11/16/21 retain engineering authority, set ownership, overrides, freshness and read-only Xrefs. Root25 governs existing-cell comparisons and42 governs ordinary placement. The sequence below is proposed interaction detail, not a new importer implementation or CD/PIT ownership change.

Actually read root `Modules/Drainage/ViewModels/PitScheduleViewModel.Schedule.cs:1–165` this continuation. Export calls PersistManualRows and FlushPendingSave before the save-file chooser, then writes selected placement rows; non-first group rows have several repeated cells blanked. Import chooses a file, reads records, captures a snapshot, clears the current Rows collection, maps a header where recognised, constructs new manual rows with fresh ManualRowId and empty source handles, updates depth, then calls PersistManualRows. That inspected method does not show a difference-confirmation step. This is a bounded source observation, not a claim about actual installed behaviour, all downstream persistence, native Undo, parser robustness or hydraulic mutation.

Consequences: imported rows are not proved linked by matching names; an exported display table is not proved to round-trip stable pit/pipe identity; blank group cells need qualified interpretation. Export file-dialog Cancel is not proof that its earlier persistence calls had no effect. No CSV file or product command was run.

## Proposed normal review

| Stage | Visible review and action | Boundary |
|---|---|---|
| Select file | Existing Import CSV entry → file picker → show exact file, modification/revision evidence where available, selected job/source drawing and intended set scope | Merely reading a candidate must not clear the current working rows, overwrite linked values or save new manual rows. |
| Inspect columns | Show original headers beside proposed field mapping, sample cell text and declared/unknown units. Recognised mapping is a proposal for review; unsupported columns remain visible. | Do not infer metres/millimetres or a datum from a plausible number. Blank, zero and missing column are distinct. No invented mandatory column list or parser capability. |
| Inspect grouping | Show each raw row and any proposed grouped inlet relationship, including blank repeated pit fields from display-oriented exports | A blank pit-number cell is not automatically a new pit or safely attached to the preceding row. Confirm a qualified group interpretation before using it. |
| Resolve identity | Compare named source drawing, set, pit identity and inlet/outlet row role against candidate values. Show exact matched, ambiguous, unmatched and duplicate groups. | Same displayed P3 in two sources cannot be matched by nearest, first or name alone. A fresh imported manual ID is not a physical-pit identity. |
| Review differences | For every candidate cell show imported text/value, fresh linked value, saved override, pending typed value and source. Distinguish new, changed, unchanged, missing and unrecognised content. | Existing pending schedule edits remain available. A row absent from the file is not a deletion instruction. A changed source invalidates the affected comparison. |
| Choose intent | Keep current; propose schedule-only override with reason; retain/create explicitly manual row in a named set; or route eligible engineering change to the existing source owner for review | No silent source update. Xref engineering values cannot be written through the host. New manual row creates no physical pit, pipe or connection. |
| Confirm subset | Show exactly selected rows/cells, resolved identities, units and set ownership, rejected/unresolved candidates and downstream affected schedule views | Confirmation cannot include hidden unmatched rows or unresolved coupled fields. No unsupported partial engineering-group policy is decided here. |
| Return to schedule | Show confirmed changes and actual persistence state in Full Schedule; use the usual placement/update preview afterwards | Import confirmation is not proof of a placed schedule update, a saved DWG or an issued drawing. |

## Detailed distinctions

- **One pit, one set:** a candidate set change shows previous and proposed membership. It is not duplication into both. Source-owned set changes follow the source owner's reviewed path; manual rows keep their named set.
- **Manual versus linked:** choosing a manual row explicitly keeps it outside physical engineering identity. If later linking is desired, use the existing reviewed adoption/repair capability; this card does not invent name-based automatic linking.
- **Units and levels:** a confirmed field mapping still needs the appropriate unit/datum basis. An imported depth is not automatically authority over cover/invert or evidence that those values agree. Show disagreement; do not choose a winner silently.
- **Repeated imports:** display prior file/content evidence and candidate differences. A repeated filename or row number is not a deduplication identity. Do not append duplicate manual rows merely because each read can generate fresh IDs.
- **Filter versus scope:** filters help inspect candidates; the final selected-subset summary remains explicit. Unresolved rows stay outside accepted scope and visible for later work.
- **CSV warnings:** imported warning text is evidence from the file, not current project QA. Shared QA/fingerprint authority determines current findings.
- **Cancel:** before confirmation, return with prior working rows and edits intact under the proposed workflow. Current method's snapshot/persistence calls do not prove that guarantee already exists. Accepted source actions, schedule records and external file writes retain their actual separate undo/save boundaries.
- **Failure:** retain candidate and unresolved status; inspect actual changed records before retry. No successful row-count claim without verified committed scope, and no repeat of completed source changes.

## Fictional production example

Two loaded source drawings both contain P3. The CSV has P3 with an altered invert, a continuation inlet row with a blank pit number, an entirely new manual note row and an undeclared level unit. Review exposes the ambiguous source and blank grouping; neither is silently linked. Select the exact source only after resolving identity and units, retain the invert as a reviewed schedule-only override if intended, and assign the note to Rear as manual. Unresolved rows remain candidates. Refresh after a source change rechecks the comparison; only the confirmed subset returns to the schedule. Later placement/update remains a separate reviewed action.

Future native qualification must inspect parsing and original row text, mapped units/grouping, duplicate sources, repeated import, existing draft preservation, explicit subset confirmation, Xref protection, cancellation, actual saved records and schedule output. None executed. This record is planning only; no native, build, installed or Tim-accepted claim.
