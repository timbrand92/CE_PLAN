# Structural representative multi-step job scenarios

**Future AutoCAD acceptance scenarios — not results.** These seven synthetic-job sequences turn the Structural cards into full job journeys. They do not set a member size, load, footing, reinforcement, level or other engineering default. Mark every outcome separately as **Built / automated checks / installed / Tim-accepted**.

| System | Linked card/control coverage | Purpose |
|---|---|---|
| S1 | W1/W2/W9; project/context, Xref/layer and markup controls | Changed background and markup evidence stay proposal-only. |
| S2 | W3/W4; beam/support/bracing and contextual/grip routes | Repeated marks, levels, copy and connection review remain traceable. |
| S3 | W5/W7; foundation/slab and presentation routes | Manual overrides and independent/coordinated edits behave differently. |
| S4 | W6; sections, reinforcement and detail-source routes | Missing detail/catalogue evidence fails visibly without a substitute. |
| S5 | W7; annotations/levels/hatches/labels | Authoritative text reconciliation and manual label placement remain distinct. |
| S6 | W8; Excel/MText and schedule routes | Missing workbook, repeated marks and staged change remain reviewable. |
| S7 | W0/W10/W11; support, sheets/issue interface and recovery | A failed issue handoff preserves the previous issue and exposes the next safe action. |

Source inventory and every control/action: [structural_retained_control_ledger.md](structural_retained_control_ledger.md). Detailed workflow expectations: [structural_workflow_cards.md](structural_workflow_cards.md).

## S1 — Changed architectural background and markup review

**Start state:** a synthetic Structural drawing references a changed architectural background containing wall-like lines, one actual opening, one hatch resembling a void, a setdown with no recorded depth, and a matching elevation with one conflict. A markup package proposes a beam location but leaves its size unspecified.

1. Open Structural workspace/context and inspect the selected source drawing, view/level and revision. Do not adopt an interpretation.
2. Open markup preview. Use page picker, raw/overlay view and grid row selection; inspect type, confidence, approval and status. Open/Refresh remain review actions only.
3. Select the proposed beam row. Show the plan/elevation conflict and setdown Unknown state.
4. Keep the changed background/markup as evidence. Do not write to the Xref or create a structural relationship merely from the wall/void/line pattern.
5. Cancel the overlay and reopen the drawing.

**Right result:** the old and changed background references remain identifiable; markup stays proposal/evidence; a beam with unknown size appears in Needs clarification rather than drawing a made-up member; no Xref change, source overwrite, inferred load path or silent source adoption occurs.

## S2 — Framing, supports, bracing, repeated marks and copied entities

**Start state:** synthetic lower and upper framing plans share one repeated beam mark. One beam has confirmed supports; another has an uncertain endpoint. A copied beam is required on the upper level. A bracing/support rotation candidate sits near two wall directions.

1. Place/review regular, lower, special and offset beams using the retained route family. Use known source instruction where available; leave the uncertain size unresolved.
2. Select a beam and inspect mark, size, level, support/source facts. Preview an endpoint move, body move, independent label move and support move. Reject one preview with Escape.
3. Copy a beam only. Verify its owned label travels with it but no support connections are created by the copy.
4. Change the repeated mark’s size on one level. Choose the documented all-or-this-member decision path; do not silently apply the change to both levels.
5. Use **Edit this only** on one copied beam, then **Edit together** for one confirmed connection change. Inspect quiet QA mismatch rather than a disruptive popup.
6. Review bracing/support rotation. Preview selected wall alignment, choose manual angle where ambiguous, then cancel one and accept one operation.
7. Undo one accepted operation and save/reopen.

**Right result:** levels remain distinct, copied entities do not gain guessed relationships, repeated-mark scope is explicit, manual label position persists, connections are reviewed rather than proximity-inferred, and every accepted drawing action is one Undo. No green preview claims structural adequacy.

## S3 — Footing/slab context with manual override and changed background

**Start state:** synthetic footing/slab drawing has one confirmed supported wall, one candidate wall, a void, a changed architectural background, a setdown with Unknown depth, one manual/pinned footing note and a schedule relationship.

1. Open the retained foundation manager/context route. Inspect source geometry and select only the confirmed support relationship.
2. Preview a footing/slab boundary. Show affected hatch, edge-beam and annotation candidates, then Cancel without writing geometry.
3. Change the background source. Keep the governing manual/pinned note and mark the suitability/revision review; do not reshape geometry or replace the note.
4. Change a footing mark with **Edit this only**. Verify schedule/detail relationship is retained for QA but no drawing propagation occurs.
5. Make one separately reviewed **Edit together** slab-edge action. Inspect the preview and accept it once.
6. Undo the accepted action, reopen and inspect the Unknown setdown depth and manual source/reason.

**Right result:** no missing depth/thickness default is invented; the changed background does not overwrite a pin; independent change does not create a hidden catch-up update; coordinated change remains deliberate and reversible.

## S4 — Section, reinforcement and missing detail-source review

**Start state:** synthetic drawing needs a steel section, an RC member section and a reinforcement detail. The selected detail source/catalogue item is missing for one requested detail and another is available but has an unconfirmed suitability basis.

1. Open the steel-section picker. Inspect section type/name and insertion route; Cancel the first attempt.
2. Open RC beam/column and ligature dialogs. Inspect dimensions, bar/tie/stirrup/cover fields and source/Assumed/Manual state before any placement.
3. Place one explicitly selected detail as a single accepted operation, then Undo it.
4. Attempt the missing detail source. Keep it visible as unavailable/Unknown; do not stretch a similar detail or substitute a generic reinforcement arrangement.
5. Reopen and verify only the accepted detail has a retained identity/source reference; the unavailable and unconfirmed items remain distinguishable.

**Right result:** picker/dialog fields are reviewable, catalogues do not choose engineering values, missing detail source causes a visible unresolved state, and no false construction detail or adequacy claim appears.

## S5 — Annotation, labels, levels and presentation override

**Start state:** synthetic framing/detail drawing has a confirmed member record, one authoritative plan label field, one display-only label position, a level mark, a section mark, a hatch and a dimension/leader. One label is manually moved after placement.

1. Place each retained annotation type through its direct route. Verify selection/prompt scope is limited to the chosen object.
2. Move the display-only label with its independent control and save it as a presentation override.
3. Edit the authoritative label text. Preview reconciliation into the corresponding record when its established label contract supports it; otherwise retain a label-versus-record conflict.
4. Use a confirmed member change with Edit-together and inspect affected schedule/detail/annotation review. Do not overwrite the manually moved label position.
5. Escape a hatch/leader preview, accept another annotation, Undo, save/reopen.

**Right result:** engineering authority and presentation stay separate; manual position survives; no label text is silently rewritten to fit a record; every accepted action is locally undoable.

## S6 — Workbook unavailable, schedule mapping and repeated marks across stages

**Start state:** synthetic job has a source workbook with two sheets, a schedule with repeated marks on two levels, one manual row/presentation override and a later stage where the workbook is unavailable. An old selected schedule output exists.

1. Open XCLMTXT/Excel route and sheet picker. Inspect source/sheet/floor mapping, then Cancel.
2. Select a valid source/sheet, preview rows and create or refresh a schedule in an explicitly chosen scope.
3. Change one repeated member mark on one level using Edit-this-only. Verify the schedule relationship remains for QA and the manual row/presentation override is preserved.
4. Use an explicit all-or-one repeated-mark decision on a reviewed coordinated update. Inspect affected rows/detail flags before refresh/sync.
5. Make the workbook unavailable. Reopen schedule route: show source unavailable and preserve existing selected output/identity; do not substitute similarly named workbook/sheet or clear history.
6. Save/reopen and inspect source, manual override, selected stage and outstanding review items.

**Right result:** mapping is explicit, no workbook inference occurs, repeated marks do not silently change across levels, manual schedule presentation survives, and unavailable source leaves a visible review state instead of fake current data.

## S7 — Issue handoff fails safely, then recovery/support review

**Start state:** synthetic Structural drawing has a selected output set, an earlier issue identity, one unresolved markup item, one schedule/source discrepancy and an intentionally failing issue-handoff condition. A stale recovery snapshot also exists.

1. Open the root-owned sheets/issue interface from the Structural-facing route. Inspect selected output/revision/source records and preview the real artifact where that owner route permits it.
2. Attempt issue handoff. The mismatch/unresolved item causes the configured failure/warning path; do not change the earlier issue identity or stamp/publish a new issue.
3. Return to Structural review, open Help/diagnostic route and navigate to the relevant source/QA item without changing drawing geometry.
4. Open CERECOVERY. Inspect the named stale snapshot; choose Retain first, then reopen and choose Clear only as a deliberate support action.
5. Export a synthetic note/report through an explicit destination choice; confirm export is not issue/publish.

**Right result:** failed issue handoff is visible and reversible, previous issued output remains intact, unresolved items retain their source/revision/manual state, recovery does not replay geometry, and diagnostics/export do not become engineering approval.

---

## Batch stop rules

Stop the batch on the first failed prerequisite. Record: exact route/control, synthetic fixture, expected visible result, actual visible result, whether drawing/project/issue state changed, and whether Undo/save/reopen restored it. Do not infer the remainder, rerun against client work or call any scenario Tim-accepted until he has viewed it in AutoCAD.
