# Label styles — previewed, active and applied are separate

FOR TIM

Preview the intended pit and pipe text, explicitly choose the style for future labels, then separately review changes to existing annotations. For example, viewing Compact must not suggest that Apply will use Compact when Default is still active.

## Authority and inspected boundary

Extends root03/11/14 and C3 output preservation. These are proposed interaction details, not changes to active CD/PIT ownership or permission to redesign their windows. Retain CDLABELSTYLE and existing supported fields/actions. Actual source read in this continuation: full root `Modules/Drainage/Commands/LabelStyleCommands.cs`, `Dialogs/LabelStyleDialog.xaml` and `.xaml.cs`, `ViewModels/LabelStyleDialogViewModel.cs`, `Services/LabelStyleService.cs`. No live installation, command execution, file persistence or native drawing operation checked.

| Inspected source | Bounded observation and consequence |
|---|---|
| SelectedStyle setter, RefreshPreview, ExecuteSave | Selection changes the editable/sample style. Save preserves the prior ActiveStyleName if its name still exists; selecting a different row does not itself activate it. No explicit activation control appears in the inspected dialog. |
| ExecuteSave and service Save | The service can return without a path or catch a write failure; the caller subsequently invalidates cache and displays Saved. This is not durable-save proof. ExecuteApplyAll calls ExecuteSave without a success result before continuing. |
| ApplyAllToDrawing | Uses CurrentStyle and traverses pit attachments matching CL:/IL: text. It does not rewrite existing pipe labels in this method. A template-only ID label can cease to match that text heuristic on later updates; this is a source-derived scenario, not a reproduced native outcome. |
| ApplyAllToDrawing count | Count increases on MText assignments before transaction commit; outer catch logs then returns count. Preserve the earlier audit qualification: returned count is not verified committed labels, and labels are not necessarily distinct pits. |
| GetPitPreview/GetPipePreview | Samples are synthetic, not selected project values. A tidy sample is no proof of actual missing-level handling, fitted text or engineering correctness. |
| Load/SeedDefaults | Missing or unreadable catalogue leads to default seeding with attempted write. Merely opening this real editor is therefore not guaranteed read-only. No editor was opened here. |
| OnSourceInitialized | Source requests 0.75 preferred sizing. Tim's approximately90% owner target remains proposed future presentation; this read does not prove native dimensions. |

## Ordinary proposed sequence

1. Open CDLABELSTYLE. Show **Previewing style**, **Active for future labels**, and the actual settings scope separately. Do not claim project-local persistence from the inspected settings-folder path alone; shared settings authority governs the eventual scope.
2. Select a style. The large preview displays Sample explicitly until the engineer deliberately selects a supported existing pit/pipe for a project example. That selection is inspection, not relabelling or a connection change.
3. Edit name and retained pit/pipe fields. Keep the current token vocabulary and multiline capability. Show unknown or unsupported placeholders as findings; do not invent missing levels or substitute engineering zero. A plain-language field picker is a proposal alongside retained template editing, not an approved replacement.
4. Save the reviewed style definition with a verified persistence result. Separately choose **Use for future labels** with the exact style identity visible. If renaming/deleting the active definition, show its proposed replacement explicitly before accepting; do not quietly fall back to the first list entry.
5. To change placed annotations, choose **Review existing labels**. Display current text, proposed text, exact owning object/label, current placement and eligibility. Keep existing pit-only support explicit; applying to existing pipes requires the command owner's separate reviewed capability, not an inference from the sample preview.
6. Accept the supported reviewed scope. Show verified updated, unchanged, skipped/protected and unresolved outcomes. Style saving and drawing changes have separate results and undo boundaries. Cancel the review without undoing an already confirmed settings save.

These action names/layout are proposals. They are not claims of current buttons or new Tim-approved engineering decisions.

## Preserve drawing meaning and manual work

| Situation | Proposed review |
|---|---|
| Label has been moved manually | Preserve position, leader, rotation and owned presentation unless that exact presentation change is separately reviewed. Text formatting alone does not change pit levels or pipe geometry. |
| Text differs from the linked engineering record | Show existing text, source value and proposed rendered text. Do not silently treat a manual text edit as an adopted engineering change or erase it through an all-labels action. |
| Missing level/length or unsupported grade | Keep the missing basis apparent in the project example. A synthetic sample must not hide an unavailable engineering value. No new precision or grade policy authorised. |
| Compact/custom label no longer contains CL:/IL: | Use the existing owner's qualified identity/attachment contract for proposed review. Do not scan arbitrary nearby text and declare it owned. Current heuristic limitations remain explicit. |
| Protected/foreign content | Show unavailable update; preserve normal locked-layer/Xref/REFEDIT protections. No clone, unlock or explode workaround. |
| Style save failed or outcome unknown | Retain edits and report persistence separately. Do not continue a drawing update under an unverified claim that the intended style was saved. |
| Drawing update failed after attempted writes | Read actual affected objects before retry; assignment counts do not justify success or automatic replay. |
| Close with pending edits | Proposed Apply/Discard/Stay follows shared draft rules, with already saved settings and accepted drawing changes retained honestly. This is not current Close behaviour proof. |

## Future consolidated acceptance

Use fictional Default and Compact styles, two local pits, one pipe, a manually moved label, an edited text value and protected content. Preview Compact while Default is active and verify their names stay distinct. Save without changing drawing text; explicitly select future use; review supported existing pit labels, preserve manual position and inspect text conflicts. Cancel once. Exercise failed catalogue save and partial/unknown drawing update without claiming success from a count. Save/reopen and inspect actual style persistence and actual drawing output separately. Check that an ID-only label is not silently forgotten on a later format review.

No tests executed: this is source-qualified planning, not built, installed or Tim-accepted behaviour. Active CD/PIT changes remain with their existing owner.
