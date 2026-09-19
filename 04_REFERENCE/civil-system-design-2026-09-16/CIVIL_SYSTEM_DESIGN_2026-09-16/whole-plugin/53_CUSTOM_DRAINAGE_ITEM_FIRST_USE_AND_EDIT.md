# Custom drainage item — source first, connection later

FOR TIM

Open Drainage Items → More → Source/custom, give the item its name and any known size/level, check its label, then place it. A pipe connection is not required to begin. Hiding the label keeps the item and its engineering identity.

This is proposed workflow detail under the approved handover, not a built window. Example: place an AC condensate outlet with its level Not set; connect it later without inventing a zero level or turning the outlet into a pit-schedule row.

## Approved basis

The original Drainage Items handover specifies Name, optional size/level and label controls, Source/custom under More, source first, and shared window/command preselection. Existing older Roof Drain identities require deliberate reconciliation; they are not silently deleted or converted because the reviewed DP is called Downpipe. Water Tank remains last. This card does not change the active Drainage Items owner's implementation.

## Actual bounded source observation

Read in full: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Drainage\Commands\SourceBlockGenericCommand.cs`. This checkout's CDSOURCE uses fixed SOURCE.dwg resolved through BlockService, asks a free-text ID, then calls PromptInsertBlock. It does not itself present an arbitrary local-block chooser or the approved optional size/level window. UsePickSet on the declaration is not proof of a working edit path.

The caller prepares services/layer before prompts; empty or cancelled ID exits. Insertion precedes the separate tag/label/connection-point transaction and ProjectData registration. It registers PitType SOURCE with IncludeInSchedule=false, then calls source registration, nearest-pipe split helper, endpoint relinking and configured draw order. Helper internals were not re-traced here: their names do not prove an incorrect connection, successful atomic placement or complete rollback. Do not claim cancellation reverses all early setup or later registration failure removes the inserted geometry.

The free-text ID is used directly by this caller, without a shown uniqueness check or automatic numbering allocation. Actual downstream duplicate handling remains unestablished. Numbering and individual wording follow the approved project settings contract; changing displayed wording must not be assumed to change a stable internal identity.

## Ordinary proposed sequence

| Step | User experience and retained scope |
|---|---|
| Start | CDSOURCE opens the shared Drainage Items window with Source/custom selected; More is an item choice, not a second design record. |
| Describe item | Enter Name. Optional size/level remain Not set until known; show units and level meaning from the qualified item contract. Do not infer an invert from block Z or fill an unexplained level role. |
| Check drafting | Large plan preview shows the actual supported symbol and numbered/worded label under project settings; individual wording and visibility remain editable. A generic sample is identified if the actual symbol is unavailable. |
| Place | Confirm insertion using the existing owner placement route. No destination pipe prerequisite. Native layer/Xref/protected-object rules remain in force. |
| Review result | Distinguish placed geometry, registered item and established connection. If later steps fail, show what exists before retry rather than inserting a second item blindly. |
| Connect later | Existing reviewed connection protections choose/confirm the actual endpoint or branch. Proximity or crossing alone is not evidence of the intended hydraulic connection. |
| Edit | Selecting the existing item returns to its own shared record, preserving identity and explicit values. Name/label visibility changes are separate from numerical or connection changes. Existing source-tag editing remains its own retained route. |

No new arbitrary-asset chooser is introduced here: the inspected caller uses SOURCE.dwg. If a later owner proposes user-selected symbols, that choice must identify its exact asset and suitability; selecting a block would not approve it as a firm library asset or authorise reading unrelated files.

## Change and recovery

- A hidden label stays hidden on ordinary refresh while engineering identity and connections remain reviewable. A missing/erased label is not proof the item itself was deleted.
- Confirmed level/size changes identify affected consumers; a label move or wording change alone does not approve engineering changes or demand a new calculation.
- Copied/duplicate names must not silently merge two physical items. Preserve distinct drawing evidence and flag unresolved identity through the existing repair owner.
- An older Roof Drain source remains identifiable while its transition is reviewed. Do not silently convert historical objects to DP or release/reallocate their catchments.
- Source geometry present but registration uncertain requires inspect/reconcile, not a success banner or blind retry. Saved in the open drawing and saved to disk remain separate.

## Future representative review — not executed

Place with optional fields unset; cancel before insertion; hide/show a label; edit wording without losing identity; connect later at an ambiguous branch; copy a same-name source; simulate insertion-before-registration failure; reopen a saved item and an older Roof Drain source. Check actual geometry, records and affected calculations with the owner. No numerical defaults, automatic inheritance policy for custom types, schedule inclusion change or conversion rule is invented by these cases.

Planning only. No plugin source changes, builds, native testing, installation or Tim acceptance. [Bounded independent audit passed](audit/coverage/LU_CUSTOM_SOURCE_DAILY_AUDIT.md).
