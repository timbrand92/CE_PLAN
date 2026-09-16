# Strip Drain — route, width and drawing output

FOR TIM

Draw or select the route, set its width, and preview which side of the picked line it occupies. Levels stay out of this window under the settled plan. Arrows and floor-waste symbols do not establish a calculated drainage result.

## Authority and source boundary

The approved Drainage Items handover puts Strip Drain in More and retains draw/select route plus width, explicitly leaving levels out for now. C5 retains CDSTRIP and its point/Close/Undo/justification behaviour. New gestures below are proposed detail within that owner contract; no active implementation is altered and no engineering size/default or spacing is newly approved.

Actual root source read: `Modules/Drainage/Commands/StripDrainCommand.cs:1–290,1146–1210`. Bounded observations:

- The inspected command takes justification, then freeform points; width is fixed by a100mm constant used as MLINE scale. It does not show the settled selectable-route/width interface. Do not turn that source constant into the newly approved width default.
- Prompt labels are Top/Center/Bottom. The justification helper maps None to Center and otherwise uses StringResult with a Center fallback; it has no separate Cancel-return path. Thus Escape here is not proved to abort placement; later first-point prompt can still be reached.
- After two points, Enter finishes open; Close requests closure; Undo removes the last point, or cancels at the first point. Temporary segment create/erase calls exist. Native cleanup and UCS/snapping remain unproved.
- InitServicesFull and layer setup occur before prompts. After points, MLINE creation commits before floor-waste placement, arrows and record registration. A later failure is not proved to roll back the whole compound.
- Caller invokes floor-waste placement and fall-arrow helpers, then registers output. Detailed placement algorithms were not audited in this bounded read. Existing historical drawing rules remain with their owner; do not silently remove those outputs or endorse every comment as engineering approval.
- Registration stores a STRIPDRAIN PitData representation with IncludeInSchedule=false and a sequential SD tag attempt with SD1 fallback. This source storage shape is not a physical pit classification or approved duplicate-ID fallback. Source-owner identity reconciliation remains required.

No command/native output was run. No statement in source comments about AutoCAD internals is adopted as verified behaviour.

## Proposed ordinary interaction

| Step | Drawing-facing experience | Important distinction |
|---|---|---|
| Choose route method | More → Strip Drain or retained CDSTRIP. Draw new or select an eligible local route through the owner-qualified implementation. | Selecting a foreign/protected route does not authorise modification, explosion or silent adoption. Source above proves only freeform drawing. |
| Width | Show entered/current width with units and a full-width preview. Retain pending width when picking on plan. | Displayed width must be the actual output width; do not claim arbitrary MLINE scale equals measured width without qualified style evidence. No level fields added. |
| Justification | Retain Top/Center/Bottom vocabulary, with preview showing both edges relative to the picked route and its direction. | Global left/right is unsafe shorthand on a bent/reversed route. User sees actual side and corner treatment before acceptance. |
| Draw | First point → next points; Undo last point; Enter finishes open when eligible; Close requests loop. Keep native snaps/UCS through the retained owner. | Open route is normal, not a failed polygon. A Close request is not proof the final geometry actually closed. |
| Select existing | Highlight exact route identity, direction and proposed width/side/output; preserve original route until reviewed adoption/replacement scope is explicit. | No nearest-line chain, inferred connection or route replacement merely from hovering. Unsupported geometry remains visible for another selection. |
| Review output | Large plan preview lists strip body, supported floor-waste symbols, arrows/high-point marks and retained manual presentation. Show unavailable assets or unsupported geometry explicitly. | These are actual drawing components; not proof of capacity, hydraulic fall or confirmed outlet. No numeric level assumption inserted because arrows are visible. |
| Accept | Confirm the reviewed compound scope and inspect actual body/children/registration outcome. | Atomic compound/Undo is a target requiring owner/native evidence, not inferred from an overall placed message. |

## Editing and recovery

Reopen/select the known strip-drain identity through its qualified owner route. Compare changed width, route and justification with existing body, generated symbols and manual positions. Preview affected children before refreshing; no automatic deletion/recreation of all nearby floor wastes. Distinguish owned outputs from independent objects and explicitly linked downstream drainage.

Cancel before proposed acceptance keeps prior accepted work. Current early setup and temporary/output commits need honest separate status. If body creation succeeded but a symbol or record failed, retain the actual partial outcome and inspect it before retry. Do not duplicate the whole drain or report success from requested closure and helper counts alone. Missing block/style is not permission to substitute a visually similar asset.

Copy keeps fresh identity under the approved compound rules and does not duplicate a confirmed catchment allocation or silently inherit downstream connection. A moved symbol/arrow can be a presentation change; a changed route/width affects the actual geometry comparison. No new hydraulic solver or automatic level assignment is implied.

## Fictional example and future proof

Draw a bent open strip beside a slab edge. Enter its intended width, inspect Top/Center/Bottom against both legs, Undo one mistaken point and finish open. Review body, supported symbols and arrows without any level fields. Repeat with an eligible existing route, then inspect Cancel before acceptance and a simulated missing-symbol asset after body creation. Later reverse/change the route and verify the side preview and retained manual annotation before updating.

Future native evidence must inspect actual width against the loaded style, reversed/rotated route/UCS, open versus physically closed output, justification Escape, point Undo/Cancel cleanup, compound children, partial failure, actual identity and save/reopen. Planning only: no built/tested/installed/Tim-accepted product claim.
