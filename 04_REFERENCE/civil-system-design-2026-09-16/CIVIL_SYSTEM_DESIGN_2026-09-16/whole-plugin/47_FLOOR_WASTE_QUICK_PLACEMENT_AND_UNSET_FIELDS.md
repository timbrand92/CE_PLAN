# Floor waste — quick placement and filling unset fields

FOR TIM

Place the FW quickly. Optional size and level may stay unset; a deliberately connected pipe can supply those unset fields while explicit entries remain yours. No grate-specific fields or grate level are added.

## Settled scope and current caller

The Drainage Items handover's FW row governs: Main choice, quick placement, optional size/level, connected-pipe values fill unset fields and preserve explicit entries. Existing CDFW mapping stays; no unchecked new FW alias. Source-first and explicit connection rules apply. This is planning detail for the existing owner, not a second item editor or active CD/PIT change.

Actually read full root `Modules/Drainage/Commands/FloorWasteCommand.cs`. The caller checks block-file availability, invokes shared PromptInsertBlock, then separately commits tag/label/connection-point data, adds a FW record with IncludeInSchedule=false, registers source and calls RelinkAllPipeEndpoints. It exposes no size/level fields in this method; shared prompt implementation was not re-traced here. UsePickSet is a declaration flag, not proof this caller edits preselected FW.

The caller has a FW1 fallback if allocation returns blank, and ReadHandle returns empty on failure. These are observed source qualifications, not approval for duplicate identity or successful linkage. Insertion can precede later registration failure; one placed message does not prove complete durable compound identity. Full relink call needs owner reconciliation with targeted update/explicit connection; no actual downstream connection was executed or asserted. Earlier initialisation/layer creation precedes the prompt, so point Cancel alone is not whole-command no-side-effect proof.

## Proposed ordinary sequence

| Action | What the engineer sees | Result boundary |
|---|---|---|
| Open FW | Approved Main → FW or retained CDFW. Keep quick placement, with optional size/level and large symbol preview where the owner provides the window. | Unset is visibly Unknown/blank, not zero or an arbitrary inherited number. No compulsory setup wizard. |
| Enter optional value | Show explicit size/level, units, level role and source/manual state before placement. | No grate-level reinterpretation; values retain the entered role. This card introduces no default size, datum or source precedence. |
| Place | Use the shared source preview and native point/rotation options actually supported by that owner; show overlap/connection proposals when relevant. | This caller alone does not prove rotation options. Never invent them as currently built. Ambiguous connection is not automatically resolved by proximity. |
| Confirm output | Verify block, label, stable identity and supported relationships as one reviewed output. | A bare graphic or allocated tag is not a complete successful engineering record. Missing asset gives its exact reason; no lookalike substitution. |
| Select connected pipe | Through the existing reviewed network route, identify the actual pipe and proposed relationship. Show unset FW fields beside compatible candidate pipe values. | Merely selecting/hovering a nearby pipe does not connect or populate governing values. Pipe diameter and specific level role must be applicable, not copied by label resemblance. |
| Fill unset fields | After the approved relationship/field review, populate only still-unset applicable fields and retain their pipe source. | An explicit FW size or level remains unchanged; discrepancy is visible for review. No invented rule choosing among multiple incompatible pipe values. |

The exact point at which confirmed pipe-derived values become active belongs to the approved item/network workflow. This proposal must not bypass Tim's source adoption requirements or add a competing confirmation system. If a field has been explicitly entered while the pipe selection was underway, it is no longer unset on return.

## Ordinary change and recovery

Select the exact FW to review present values, source and connected identity. A pipe revision may propose a new value for a field previously derived from it; it does not overwrite an explicit manual value. Show prior/current/pending evidence and effects through the shared source review. If the pipe is removed/unloaded or role no longer applicable, preserve the last known basis with its missing/out-of-date status, not a fresh zero or unrelated nearest connection.

Moving/copying/removing follows the existing source compound rules and exact affected-connection preview. Copied FW gets fresh identity and does not silently share connection/allocation. Manual label placement remains separate from level changes. Schedule exclusion in the inspected caller is preserved as source evidence; this planning does not turn FW into an ordinary scheduled pit.

If insertion exists but tag/handle/record is unresolved, show those states separately and inspect actual objects before retry. Do not place another FW just because registration failed. Cancel before proposed acceptance retains existing explicit entries; accepted drawing effects retain their actual Undo/save boundaries.

## Fictional example

Place a FW with an explicit level and size unset. Deliberately connect the intended pipe. Review the compatible size candidate; retain the explicit FW level even if the pipe carries a different value. Later change the pipe size: show the derived-field difference without changing the manual level. Select another nearby pipe only to inspect it, cancel, and verify the original relationship remains. Simulate failure after block insertion and confirm retry does not duplicate it.

Future native checks cover quick placement, missing assets, overlap, explicit versus unset values, exact pipe role/identity, typed-value race during selection, copy/removal, partial registration, Undo and save/reopen. No runtime/native test, build, installation or Tim acceptance claimed.
