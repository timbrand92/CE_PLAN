# Layer presentation — saved rules versus a changed drawing

FOR TIM

When a hatch hides drainage linework, show which layers will move in front or behind, and whether the action covers model space or every layout. Saving a rule, applying it now and having it run later are three different actions.

This deepens the existing [Layer Manager contract](planner/civil_configuration_layer_and_parts_contract.md). It proposes clear review and receipts, not a new layer editor or approved changes to office standards.

## Bounded source observation

Named root source: LayerManagerViewModel.cs163–225 and245–361; LayerService.cs631–840. The view model Add/Remove/Reset edits its rule list. ApplyNow calls ApplyLayerOrderPreview and then sets an applied message. Save calls SaveLayerOrderSettings separately. Colour reset clears pending cells; colour Save rejects invalid nonblank ACI entries before replacing the overrides and calling settings Save.

Despite its name, ApplyLayerOrderPreview runs actual drawing-rule application twice: command actions, then save actions. Each call has a drawing transaction and commit. It is not shown as a temporary overlay. It can return early when no active target/active project/action map exists, without an applied-object receipt to the view model. The later applied message alone is not proof that visible objects changed.

The command/save configured routes check their respective enable flags. The inspected ApplyLayerOrderPreview directly calls both action sets; it does not check those flags itself. Rules group matching entities by exact layer-name lookup into Front/Back actions. All-layout scope visits layout block records; model-only scope uses model space. The sampled helper does not establish native protection behaviour, total Undo grouping, success under every exception, or saved-file durability. No draw-order operation or settings save was executed.

## Proposed ordinary sequence

| Engineer action | Visible meaning and limit |
|---|---|
| Open Layer Manager | Show saved rules, pending changes, command-end and save/regen triggers separately. Retain the existing owner and controls. |
| Choose layer/rule | Name the layer and Front/Back/Ignore action for each trigger. Adding/removing a rule row does not create/delete a drawing layer. |
| Inspect the intended effect | Relevant plan/layout preview identifies the intended layer groups and scope. A proposed non-writing review must be distinguished from today's actual Apply action labelled preview. |
| Choose Model or All Layouts | Show exact drawing and included spaces. Do not silently interpret All Layouts as all open drawings or project-wide application. |
| Apply now | Confirm the qualified drawing action and report affected/skipped/failed/unknown scope. Keep configuration persistence separate. The owner must establish how both action columns are evaluated; contradictory command/save actions cannot be concealed by one preview image. |
| Save rules | Save the intended configuration and identify later enabled triggers. A saved-rule receipt does not claim the drawing was updated or the settings file verified unless actually established. |
| Close | Discard remaining unsaved rule edits through the owner. Earlier accepted drawing application remains applied until a separate qualified Undo/recovery action. |

**Example:** a drainage layer is Front for command-end but Back for save/regen. The engineer needs to see those two intended outcomes before saving, and what Apply now actually does when it invokes both. This card approves neither a winner nor an automatic rewrite to make them identical. An unavailable preview stays unavailable, not a fabricated guarantee of final draw order.

## Future automation affects actual drawing presentation

Turning on a future command/save trigger can mean existing matching objects are affected when that trigger next runs. Do not describe such a rule as changing only newly created objects. Saving the configuration itself and its later drawing action remain separate, and the owner must make the authorised recurring scope clear. This qualification does not permit silent engineering changes, reset hand-positioned labels or override protected content.

If manual draw order is intended to be preserved or overridden by an enabled rule, its exact policy requires the existing owner's reviewed contract; do not invent a hidden presentation lock or assume every manual move is permanent. Positional label overrides are not draw-order rules. Existing project/firm-governed standards remain subject to their approved authority.

## Colour is a separate scope

Show default colour, pending override and saved override. Reset colour cells is a draft edit until saved; an invalid row should remain identifiable while other pending text is retained. A colour preference is not proof existing layer definitions or ByLayer/entity colours changed. The inspected status mentions future CD-created layers; actual consumers and existing-layer update behaviour require owner evidence before making a broader promise. No blanket existing-drawing recolour is added by this plan.

## Interrupted work and representative proof

Changing active drawings while this review is open requires target revalidation before Apply; old pending scope cannot silently act on another job. A protected or unsupported object remains protected, with skipped/failed/unknown outcome rather than an unlock/explode workaround. Partial application must distinguish the actual completed action set from an unstarted second set; Close does not undo either. Native Undo scope is future evidence, not inferred from two commits.

Future combined check: use one model view and two layouts with a hatch, pipe and manual label; compare Model versus All Layouts; use differing command/save actions; disable triggers and inspect Apply-now behaviour; cancel unsaved rules after a real Apply; exercise invalid colour; switch drawings; inspect protected objects, Undo and save/reopen. Check the actual visible stacking and settings file separately. No such test was run here.

Planning only. No source/settings/drawing changes, build, native test, deployment or new acceptance. [Independent bounded audit passed](audit/coverage/LAYER_PRESENTATION_DAILY_AUDIT.md).
