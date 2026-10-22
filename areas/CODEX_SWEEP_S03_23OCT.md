# CODEX SWEEP S03 — Civil Services — 23 October 2026 (Melbourne)

1. **ANSWER FIRST — HIGH: 2; MEDIUM: 2; LOW: 0.** Four findings verified by reading the pinned code. None has been run in AutoCAD in this hunt. No suspected finding is included in the counts.

2. **Most important — a cascade can put the wrong level on the drawing.** If only the last end's invert label is visible, changing the downstream level can make that label show the upstream level. In the test below, the downstream label should read **IL 9.50**, but the writer puts **IL 9.60** there.

3. **The other faults.** An ordinary 225 mm pipe outline is drawn 225 m wide in a metre drawing; choosing to mirror a manually placed pipe label leaves its replacement outside the pipe's attachment list; updating one older long section also changes its copied insert, including a copy placed on a locked layer.

4. **Scope and status.** This is the independent desk plan/03, S03 hunt. Only this findings file is being changed. No plugin fix, build, test, installation or AutoCAD session was performed. The drawing checks below are instructions for the later robot test pass, not reported passes.

---

1. **Reading basis and limits.**

   Repository: `C:\Lisp Files\CE_ACAD_PLUGIN`. All source references below mean `origin/claude/rel-20261022m`, fetched and resolved to `40ee0a36f7960145743954b39859eb6c3af92869`. The brief identifies this as Civil 3.0.70 / Manager 1.1.70; this hunt did not independently inspect installed binaries.

   Retrieved all **112 requested files** individually with `git show`, working from the largest central services into their related partials and smaller services. The source set contains 59,982 returned lines. Also traced the relevant commands, windows, callers and recovery paths at that same ref. This source sweep is not an assertion that the remaining code is fault-free.

   Read the earlier audit and the three present `CODEX_AUDIT_*_22OCT.md` reports before the hunt: `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md`, and `CODEX_AUDIT_STRUCTURAL_22OCT.md`. Their reported Ignore, Tidy, command-outcome, downpipe double-click, REDO and Structural findings are not recounted here.

   All fixtures below are synthetic, in model space with World UCS, unlocked output layers unless specified, no Xref and no REFEDIT. Use fresh drawing copies. For ordinary-pipe fixtures on the test PC, use Settings **Upgrade pipes → Off** and leave **One continuous pipe** off; colleagues' default upgrade hold already retains ordinary pipes. Restore any test-only Settings changes afterwards. Do not change engineering defaults to conceal these defects.

2. **S03-01 — HIGH — the sole last-end invert label is written as the first end. Verified-by-reading.**

   **Where:** `Modules/Drainage/Services/LinkService.RepairAudit.InvertPropagation.cs:991`–`:995`; label discovery at `:974`–`:987`, actual text write at `:1045`–`:1046`.

   **What happens in AutoCAD:** a drafter hides the first end's invert text, keeping the last end visible. After cascading a new downstream level, the remaining label shows the other end's level. The command can still report that it updated the pipe.

   **Exact failure scenario:** one ordinary CE pipe is drawn first-to-last in the upstream-to-downstream direction. Its first-end label is hidden; its last-end label is the only attached text containing `IL `. The accepted propagation row contains different upstream and downstream levels. All affected layers are writable.

   **Code proof:** the method collects surviving IL texts, sorts them by segment/station, and always assigns the first surviving text the first physical end's new value. It assigns the last physical end's value only when there are at least two texts. It does not consult the attachment's end role or the pipe's hidden-label flags.

   For `StartIsUpstream = true`, one surviving downstream label receives `newUpStr`. The caller has just assigned the actual first/second stored levels at `:783`–`:791`, accepts the label write at `:799`, writes the link record at `:817`, and counts success at `:839`. Its success summary is at `:917`.

   Hiding only one IL is an exposed operation, not a damaged drawing: `Dialogs/PipeEditWorkshopDialog.xaml:387` binds the first **Hidden** toggle; `:390` binds the second. `Commands/LinkCommands.cs:475` exposes `CDPROPAGATE`, with the apply call at `:624`. The endpoint relink at `LinkService.Geometry.cs:937` follows connectivity; it is not an end-role correction for this text selection.

   **DETERMINISTIC TEST — fixture:** two linked synthetic pits P1 and P2, with one straight ordinary pipe whose measured route is 10,000 mm. The first vertex belongs to upstream P1 and the last to P2. Initial pipe ILs are 10.00 m and 9.90 m, giving 1:100. Use level-driven mode with no held-grade recalculation. Both levels are known; the pipe has no extra supplementary text containing `IL `.

   **Steps:** type `CDEDIT`, select that pipe, turn on **Hidden** for the first end only, and click **Save**. Confirm the sole remaining IL label is beside P2 and initially reads `IL 9.90`. Type `CDPROPAGATE`, select P2, enter `9.50`, confirm the preview gives 9.60 upstream / 9.50 downstream, and click **Apply**. If the command asks about hand-set levels, type `Overwrite`.

   **Assertion:** after command completion, the visible label beside P2 must read `IL 9.50`; no first-end label should appear. The defective writer sets that existing P2 label to `IL 9.60`. Capture its handle and MText/DBText contents, the preview values, and the command-line `[CDPROPAGATE] Updated 1 pipes` summary. Also record the final stored end levels to detect any later propagation of the wrong text into the schedule; this finding does not assume those later readers will leave the discrepancy isolated.

   **Repair boundary:** choose each text's physical end from its identity/end position even when the other text is absent. Do not create a hidden label or make hiding labels a hard block.

3. **S03-02 — HIGH — ordinary pipe outlines use millimetres as metre drawing coordinates. Verified-by-reading.**

   **Where:** `Modules/Drainage/Services/MlineService.cs:397`; unconverted input at `:346`–`:374`. The same raw-scale pattern also exists in its two-point creation path.

   **What happens in AutoCAD:** in a drawing measured in metres, choosing diameter 225 mm produces an ordinary MLINE pipe border 225 drawing units wide: **225 m instead of 0.225 m**, a factor of 1,000. The route can be correctly placed while its outline covers a huge part of the plan.

   **Exact failure scenario:** `INSUNITS=6`, a two-element drainage MLINE style with offsets +0.5 and -0.5, ordinary pipe creation, diameter 225 mm, and a route supplied in metre coordinates. No native pipe-object conversion subsequently replaces the border.

   **Code proof:** `Commands/CdCommand.cs:684` passes the selected diameter into `PipeCreationParams`. `Services/PipeCreationService.cs:217`–`:222` forwards `p.Diameter` to `DrawingService.CreatePipeMline`; `DrawingService.cs:333` forwards it to MlineService. None converts the diameter into drawing units on this path.

   `MlineService.cs:353`–`:358` treats the number as a millimetre diameter, validating it against 50–5,000 and falling back to 75. `:397` then assigns that same number directly to `Mline.Scale`. Route points are only transformed at `:402`. The CE style's opposed half-unit elements are defined at `:493` and `:497`. Consequently, their separation is the unconverted diameter.

   Metre geometry is expressly handled elsewhere at this ref, for example the CD minimum-route check at `Commands/CdCommand.cs:1296` converts 1 mm into drawing units. This is a missing conversion in the outline path, not an instruction to treat all Civil drawings as millimetres. Scope here is the ordinary MLINE representation, not the native C7 renderer.

   **DETERMINISTIC TEST — fixture:** a fresh metre drawing, `INSUNITS=6`, with the DRAINAGE MLINE style containing exactly the +0.5/-0.5 elements. Use no pits, avoiding any mismatched-pit-size inference. Keep ordinary pipes as described above.

   **Steps:** type `UCS`, then `World`. Type `CD`; select a 225 mm stormwater pipe and automatic label placement. Start the pipe, draw a two-point route from `0,0` to `10,0`, and finish it. Select the resulting MLINE border and read its scale in Properties or `LIST`.

   **Assertion:** the border scale must be **0.225**, with 0.225 drawing units between the two parallel elements. The code instead sets **225**, with 225 units between them. Capture the MLINE's `Scale`, vertices and style-element offsets; this establishes the defect without judging zoom or apparent screen size. Control: repeat in `INSUNITS=4` with a 10,000-unit route; scale 225 and a 225 mm separation are correct there.

   **Repair boundary:** retain the engineering diameter in millimetres and convert only the geometric width into the target database's drawing units. Keep validation on the millimetre diameter; feeding 0.225 through the existing 50 mm clamp would create another wrong width.

4. **S03-03 — MEDIUM — mirroring a manually placed CD label loses the pipe's link to it. Verified-by-reading.**

   **Where:** `Modules/Drainage/Services/MirrorService.cs:133`–`:149`, reached immediately after registration in `Modules/Drainage/Commands/CdCommand.cs:771`–`:780`.

   **What happens in AutoCAD:** the drafter places pipe text manually and answers Yes to the mirror question. The text appears mirrored successfully, but the visible replacement is not in the pipe's attachment list. Moving the pipe can leave this label behind.

   **Exact failure scenario:** ordinary two-point pipe, inline pipe text, both automatic-placement checkboxes off, and Yes to CD's own mirror prompt. This concerns the helper inside CD, not AutoCAD's separately typed native `MIRROR` command.

   **Code proof:** CD registers `pipeTextId` at `:777`, then calls `PromptAndMirrorText(pipeTextId, ...)` at `:779`. The helper clones that entity, appends the clone under a new handle, erases the registered original, commits, and returns only `true`. It neither replaces the original handle in the pipe record nor returns the new ID for CD to register.

   The registration path for ordinary text is immediate: `LinkService.Registration.cs:978` defers only MLeader registration, while `:1005` registers ordinary text. The binding reader at `LinkService.PipeAttachmentBinding.cs:49`–`:56` requires the actual visible child's handle in the parent list. A copied owner marker on the clone is insufficient.

   Moving attachments iterates that parent list at `LinkService.PipeAttachmentUpdates.cs:109` and prunes erased entries at `:115`–`:118`. The new handle is absent. The suspended-editor append reactor at `LinkService.Reactors.cs:59`–`:69` marks objects for a cache refresh; it does not perform the missing parent-list replacement.

   **DETERMINISTIC TEST — fixture:** millimetre drawing, ordinary two-vertex stormwater pipe, 225 mm diameter, no extra pipe label or callout. Set `PICKSTYLE=0` so selecting the route does not select the text through a group.

   **Steps:** type `CD`. Clear **Auto-place all labels** and **Auto-place pipe text only**; use inline text. Draw from `0,0` to `10000,0`, place the pipe text near `5000,500`, and answer **Yes** to **Do you want to mirror the text?** Pick mirror points `0,0` and `10000,0`; finish the remaining prompts normally. Record the mirrored label's handle and position. Type `MOVE`, select only the pipe route, and use displacement `0,1000`.

   **Assertion:** the same visible label must move by that displacement, and the pipe's attachment list must contain its live handle exactly once. The defective sequence logs/prints `Text mirrored successfully.` but retains the erased original handle instead of the clone. Check the handle relation before MOVE as the primary deterministic oracle, then capture the label position after MOVE. A fresh non-mirrored manual-label control must remain linked and follow its pipe.

   **Repair boundary:** transform the existing registered text, or return and atomically register the replacement handle while removing the old one. Do not adopt nearby unrelated text to repair this relationship.

5. **S03-04 — MEDIUM — updating one older long section rewrites copied inserts too. Verified-by-reading.**

   **Where:** `Modules/Drainage/Services/LongitudinalSectionService.cs:484`–`:498`, in `UpdateExistingSection`.

   **What happens in AutoCAD:** a drafter copies a long-section block to retain another view, then updates only the original. Both inserts acquire the new section geometry. Even placing the copy on a locked layer does not protect its shared block contents from this path.

   **Exact failure scenario:** section A is exported through **CDCALC → Older longitudinal**. Native `COPY` produces B referencing the same block definition. A is writable; B may be on a locked layer, while the definition's child entities remain on unlocked layers. Update Existing targets A.

   **Code proof:** the method checks the selected reference at `:473`, then opens its shared `BlockTableRecord` at `:484`. It checks child protection at `:492`, erases the definition's old contents at `:495`, and recomposes that same definition at `:496`. Only A receives the new per-reference metadata at `:498`.

   There is no check for other inserts and no independent replacement definition. `TryFindProtectedSectionChild` at `:2648` checks the children, not the layers of every other reference. Both inserts therefore resolve to the changed contents, while B's own metadata remains old.

   This is specifically the older button. The newer accepted-profile writer checks `GetBlockReferenceIds` and rejects a shared definition at `:2506`–`:2513`; that safeguard is not called here. `Dialogs/CalculationsV2Dialog.xaml:278` names **Older longitudinal**, and `:319` binds **Update Existing**. `ViewModels/LongitudinalSectionViewModel.cs:718` calls the affected helper. The older tab is shown by default at this ref.

   **DETERMINISTIC TEST — fixture:** a valid two-pit synthetic route with known covers and pipe inverts. Through `CDCALC`, choose **Older longitudinal → Route and scales**, select the route's Schedule Set, Start Pit and End Pit, set horizontal scale 1:100 and vertical scale 1:10, then **Export to Drawing**. Call the resulting insert A. Native `COPY` it by displacement `50000,0` to obtain B; confirm A and B reference the same definition. Put B alone on layer `AUDIT_SECTION_HOLD` and lock that layer.

   **Steps:** record B's definition contents and scale-note text. Reopen `CDCALC`, use the same route, change **Vert. 1:** from 10 to 20, click **Update Existing**, and select A. Type `REGEN` after the dialog returns so display caching cannot hide the result.

   **Assertion:** A should change independently; B must retain its original geometry and `VERTICAL SCALE 1:10` note. The current code changes the shared definition's note to `VERTICAL SCALE 1:20` for both inserts and reports `Longitudinal section updated.` Check B's nested MText contents and geometry, not merely whether its outer BlockReference was modified. Also compare A/B metadata: only A is rewritten. The scale note is composed at `LongitudinalSectionService.cs:1215`.

   **Repair boundary:** give the selected insert an independent definition before rebuilding, preserving other inserts and their metadata. Do not solve this ordinary copy case by adding a blanket hard block contrary to R-27.

6. **Summary.** Four code-proven findings: two HIGH and two MEDIUM. Prioritise the sole downstream invert label and metre-drawing pipe width. Preserve mirrored-label ownership and isolate older long-section updates from copied inserts. All four include synthetic fixtures and precise drawing assertions. No build, test or AutoCAD run was authorised or performed; none is marked fixed. Only this findings file is the deliverable.
