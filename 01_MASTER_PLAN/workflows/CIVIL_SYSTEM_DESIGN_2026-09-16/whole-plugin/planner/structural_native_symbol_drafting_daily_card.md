# Structural native symbol drafting daily card

**Planning-only.** CL/CENTERLINE/CENTRELINE/CLINE, REBAR/RB, SCABBLE/SCAB and RC remain direct native drafting entries. Their visible symbols are not calculations, design approval or issue status.

| Family | Named source fact | Proposed ordinary use |
|---|---|---|
| Centreline aliases | All dispatch CreateCenterLineSymbol; source prompts an insertion point and places within an Undo-mark transaction. [Commands](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LegacyPortCommands.cs:51>), [service](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/NativeTimToolsService.cs:83>). | Type the familiar alias, choose the local point, see a transient native preview and confirm with its normal placement click. Existing text/scale/layer outcome remains source/runtime evidence, not an invented default. |
| Rebar aliases | Both dispatch CreateRebar(false). These aliases dispatch `CreateRebar(false)`: source prompts a bar size, then one location, places one dot and returns in Undo scope. The endpoint/Spacing/Number branch belongs to an uncalled `lineMode=true` path, not these aliases. [Commands](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LegacyPortCommands.cs:69>), [service](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/NativeTimToolsService.cs:177>). | Preserve the direct size-plus-one-location prompt and a transient placement preview. The user-supplied size is Manual/Assumed until its source is stated; this utility does not replace the approved RBL/RBC compound card or calculate reinforcement. |
| Scabble aliases | Both dispatch CreateScabbleLine; source prompts start/end points and writes in Undo scope. [Commands](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LegacyPortCommands.cs:75>), [service](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/NativeTimToolsService.cs:289>). | Direct point prompts and one confirming placement click remain; no modal setup. The symbol has local annotation scope only. |
| Revision cloud | RC dispatches CreateRevisionCloud; current source visibly asks **Keep OSNAP ON?**, sets early layer/current-property state, registers command-end/cancel/fail restoration callbacks, then asks native REVCLOUD for first and opposite corners of a rectangular cloud. [Command](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LegacyPortCommands.cs:48>), [service](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/NativeTimToolsService.cs:340>). | Keep the OSNAP choice and native rectangular-corner gesture. Early layer/current-property changes and registered callback restoration are source observations; the native callback result is untested. A cloud is markup evidence only; it does not mark an item accepted, update a sheet revision or issue an output. Markup/issue owner contracts remain authoritative. |

## Direct boundaries

- Command prompt, transient drawing preview, and an existing palette where present are sufficient; no new modal window or second confirmation is proposed.
- Select only explicit local geometry. Xref, locked, REFEDIT and unsupported-object protections remain.
- Cancel before a normal direct placement remains the proposed no-symbol boundary. RC has early state changes and callback restoration in source, so its actual Cancel/restoration result is explicitly untested. Native output, Undo and save/reopen remain future AutoCAD evidence.
- Copy/MOVE/ERASE affects the selected drafting symbol only unless an existing approved compound contract explicitly says otherwise. No proximity link or design-data adoption is created.

## Future acceptance

Use a synthetic drawing to place/cancel/Undo one of each symbol; verify the native result, layer/text state and Manual source state, then save/reopen. Run an RC cloud beside a markup item and confirm it does not alter item approval or issue status.

**Limits:** CPB is excluded because current source seeks a superseded legacy LISP route; LU stays shared-settings owned. No runtime test was performed.

