Checked: 2026-09-17T02:53:48.0127992+10:00

# Layer presentation ordinary-flow audit

FOR TIM

- Apply Now changes drawing order; it is not a harmless preview.
- Saving rules is separate, and later enabled triggers can change existing presentation.
- The proposal preserves those distinctions and existing ownership.

---

Read root57 in full. Independently read LayerService631–814, LayerManagerViewModel163–225,245–361. Source confirms draft BuildSettings feeds two actual rule applications, command first then save, without checking enable flags in ApplyLayerOrderPreview. Configured command/save routes check their respective flags. Each helper action uses its own transaction/commit, may return early for missing target/inactive drawing/no action map, and supplies no object receipt. View-model status follows the void call. Action lookup is exact layer name with ordinal-ignore-case map, not wildcard matching; Back precedes Front within each set. All-layouts traverses IsLayout records; model-only accesses model space. Save separately updates settings. Invalid nonblank colour blocks the save; Reset clears pending cells. No native protection/Undo/durability claim follows from source.

No material correction found. Proposed scope preview, opposing trigger actions, active-drawing revalidation, drawing-versus-settings receipt, later automation effects and Close-after-Apply retention are coherent. The precise approved recurring manual draw-order policy remains an owner question; no hidden permanent lock or blanket recolour is invented. No source/runtime/settings-file action occurred.

## Next concrete integration gap from a named card

The existing `planner/civil_survey_activation_and_tree_constraint_trace.md` already covers centre/radius first placement (43–44), stored Tree ID/radius/source/revision, record-versus-geometry radius edits and copy. Do not duplicate that card as another first-placement flow.

A narrower unresolved daily scenario is **relocating a tree centre after a reviewed survey/report correction when TPZ and SRZ marks both reference the same Tree ID**. Its current target review fields/actions (109–130) specify radius updates but do not state how the changed centre is represented, how two same-tree marks are individually identified, or whether either companion moves. Add a bounded proposal: show original/current/proposed centre evidence and both actual mark identities where known; require explicit selected-mark/confirmed companion scope, preserve entered radii and manual values, show mismatch if only one mark moves, and retain accepted native MOVE when later evidence review is Cancelled. Unknown correspondence cannot become automatic linking or a calculated radius. This is a concrete ordinary revision handoff, not permission for a new inference engine or source scan.

This gap is based on those named card sections only, not a whole-plugin absence claim. No whole-run completion or Tim acceptance.
