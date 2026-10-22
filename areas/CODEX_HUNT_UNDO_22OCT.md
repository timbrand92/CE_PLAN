# Independent Civil UNDO, REDO and transaction hunt — 22 October 2026

1. **ANSWER FIRST — HIGH 1 / MEDIUM 2 / LOW 0.** Three source findings, with three proposed AutoCAD tests. No test was run. These are not fixes or AutoCAD acceptance results.

2. **Most important: finishing a callout pipe with Esc can leave its label unlinked.** CD has already drawn the pipe and its callout, but still owes the drawing the link between them. The cancellation handler discards that work. The pipe can then move or be erased without taking its callout. This particularly matters for colleagues using ordinary CE pipes.

3. **The other two:** clicking an Inspector problem count can lose REDO even when it finds nothing; choosing the pipe window before the route leaves an extra Undo step when the automatically opened next window is cancelled.

4. **Next action belongs to the AI test lane.** Run the three fixtures below on disposable synthetic drawings. Nothing here asks Tim to test, changes an engineering value, adds a hard block or restarts parked Manager work.

---

1. **Scope and evidence.** Read `C:\TimOS\RULES.md`, `ROUTER.md`, CE_PLAN's start/map and the four existing audit files: `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md`. Fetched the plugin origin. All Civil source references below are Git objects at `origin/claude/rel-20261022m`, commit `40ee0a36f7960145743954b39859eb6c3af92869`, the brief's Civil 3.0.70 / Manager 1.1.70 candidate. Also resolved the supplied Structural ref to `2c9a96942a024888a5ab520600f2d5025de83036`; this is a Civil hunt, not a fresh Structural audit. Installed binaries were not independently read.

2. **Method and limits.** Searched the entire Civil source tree, not just the latest release diff: 147 lines declaring `[CommandMethod` were found, including aliases and diagnostic commands. Traced common command initialisation, continuation, cancellation, history reload, record saving, selection/grips, Inspector, migration, upgrade and idle handlers. Inspected transaction/lock acquisition and release at the suspicious sites. This is a whole-tree risk search with focused call-path reading, not proof that every command or every native exception path is correct. No build, test, AutoCAD launch, installation, branch, worktree or sub-agent. Only this report is authored; unrelated CE_PLAN changes are excluded from the commit.

3. **Evidence labels.** VERIFIED-BY-READING means the cited control flow is present at the pinned commit. SUSPECTED identifies a native manifestation not reproduced here. All deterministic tests below are NOT RUN. Earlier audit records are supporting evidence only, not tests performed by this reviewer. No finding is labelled fixed.

## Numbered findings

1. **U-01 — HIGH — Esc after an accepted CD placement discards its deferred callout registration. VERIFIED-BY-READING; exact native reproduction pending.**

   **File:line:** `Modules/Drainage/Services/LinkService.Reactors.cs:1420`, `:1542`, `:1557`; enqueue at `Services/LinkService.Registration.cs:978`; normal completion at `Services/LinkService.Reactors.cs:849`; caller at `Commands/CdCommand.cs:214`, `:235`, `:1196`; callout creation/registration at `Services/PipeCreationService.cs:319`, `:329` and `Services/TextService.cs:355`.

   **What happens in AutoCAD:** the drafter successfully places a pipe with a leader label, then presses Esc when asked for the next pipe. The drawing keeps the pipe and label, but their ownership link can be absent. Erasing the pipe can leave its label behind, or moving the pipe can leave the arrow pointing at its old position. Undo and REDO cannot restore a link that was never written.

   **Exact failure scenario:** use an ordinary CE polyline pipe, Callout text layout, route-first CD, no same-plan break and no crossings. CD suspends linking during creation. `RegisterAttachment` sees an MLeader while suspended, stores only a `DeferredAttachmentRegistration`, commits its read and returns before `RegisterAttachmentCore`. The accepted callout already exists as a separate drawing entity. `ResumeRuntimeLinkingOnCommandEnd` leaves registration for the terminal event. CD then asks for the next route start while still inside the same command.

   **Failure boundary:** normal `CommandEnded` flushes the registrations inside the command. `CommandCancelled` instead calls `HandleCommandInterrupted`, which queues a cache refresh but unconditionally clears every deferred registration at line 1557. Its final branch says cancellation means the edit was not accepted; CD's carry-on contract explicitly says already placed items survive Esc. The earlier audit's real CD outcome line establishes that an Esc-ended accepted CD can take the cancellation event. It did not test a callout or inspect this queue. This is a drawing-integrity consequence, not a repeat of its outcome-log wording finding. No automatic cache reader recreates this discarded ownership write in the traced route.

   **DETERMINISTIC TEST — fixture:** fresh synthetic millimetre Civil drawing, World UCS, all output layers unlocked, no existing pipes or crossing pits. Route-first ON (`Options.CdDrawFirst=true`), full pipe rather than simple line, Callout label, normal straight pipe, no break. Use AutoCAD 2024, where the new native pipe object is unavailable; alternatively use AutoCAD 2027 with the isolated fixture's `options.pipeObjectUpgrade=Off`. This is also the ordinary-pipe route retained by the colleague upgrade policy. Enable diagnostic logging before starting. Do not change Tim's live Settings.

   **Typed/clicked steps:** type `CD`; pick `0,0` and `10000,0`, then finish the route. In New Pipe choose a 225 mm pipe, first invert RL 10.000 m, second invert RL 9.900 m, and Callout; accept Start Pipe. At `Snap callout arrow to pipe:` choose `5000,0`; click the leader text position at `5000,2000`. Complete any enabled annotation prompts. Wait for `[CE] Pipe placed. Pick the next pipe's first point, or press Esc to stop.` Press Esc once. Name this pipe P-A and its MLeader L-A in the test observer, retaining both handles. Do not open Edit Pipe or run repair before inspection.

   **Assertions:** at the terminal event, read the drawing through an observer already installed before the test: the pipe's `PIPE_LINK` attachment list must include L-A, and L-A must have its `PIPE_ATTACHMENT` ownership record. The diagnostic sequence must not end with `RegisterAttachment: deferred callout registration ...` and no matching `Deferred attachment registered ...`. Next type `_.ERASE`, select only the pipe centreline, Enter: L-A must also disappear. `_.U` must restore pipe, callout and both ownership directions; `_.REDO` must erase both again. Source predicts the missing ownership immediately after Esc; orphaned-label behaviour is the native symptom to confirm. Control: on an independent copy, answer the next-start prompt with a point so the first CD ends normally; observe that first pipe's registration before cancelling the next CD.

   **Correction direction:** distinguish cancellation before any accepted placement from Esc-to-finish after a retained placement. Finish the retained item's registration inside its own terminal event, with exact live-object checks. Preserve the no-write rule for genuine cancelled previews and history commands. Do not move the write to idle, where it would create a separate Undo step.

2. **U-02 — MEDIUM — an empty Inspector problem lookup takes write access and an ordinary transaction, consuming history for no drawing change. VERIFIED-BY-READING; full-AutoCAD REDO result SUSPECTED pending the test.**

   **File:line:** `Modules/Drainage/Services/InspectorPaletteService.cs:271`, `:2752`, `:2765`, `:2766`, `:2793`, `:2796`; visible button at `Controls/InspectorPanelControl.xaml:573`; existing native evidence described by `Services/RedoWindowGuard.cs:10` and `Services/OutsideCommandUndoPolicy.cs:8`.

   **What happens in AutoCAD:** the drafter clicks `Flat / backfall pipes` in the Inspector to locate a problem. Even when its count is zero, CE takes the access used for a drawing edit before saying there are none. This can use up the next U or destroy the line the drafter was about to restore with REDO. No pipe or label needed changing.

   **Exact failure scenario:** `ShowFailingGradePipesCommand` directly calls `ShowEntitiesByHandles`; this is a palette callback, not an AutoCAD command. An empty, non-null handle list passes the initial check. The method takes default `doc.LockDocument()` and `StartTransaction()`, commits, disposes both, and only then checks `resolved.Count == 0`. In this case it returns before either `SetImpliedSelection` or zoom. The same helper serves shallow pits, unconnected pits, disconnected pipes, duplicate numbers and missing levels. An empty-result case isolates the access fault from native zoom or selection behaviour.

   **Why this is separate from BUG-861/BUG-416:** this is a specific Inspector button and an explicit ordinary-transaction call, not a proposed explanation for a plain pit pick or `CE: Select this run`. The repository's existing native primitive evidence says this transaction type loses REDO and a write lock outside a command adds an unnamed Undo record. I did not rerun those primitives or this UI route. Ordinary user-initiated editing may legitimately consume history; an empty lookup is not an edit.

   **DETERMINISTIC TEST — fixture:** synthetic Civil drawing with one correctly graded pipe, no flat/backfall pipes, and Inspector open on `Drawing health` > `Network overview`; verify `Flat / backfall pipes` reads 0. Use the existing Inspector layout for this fixture (`editors/workshopLayout` false) so the view cannot reset to the short Inspector during the test. Set `RedoHoldSeconds=0`. Finish all fixture setup and wait for first-open work before starting the sequence.

   **Typed/clicked steps A:** type `_.LINE`, `20000,0`, `21000,0`, Enter; type `_.U`; click `Flat / backfall pipes` once; type `_.REDO`. Do not run a query, LISP expression or diagnostic command between U and REDO.

   **Assertions A:** the click must print `[CE] No pipes failing grade found.` REDO must restore that exact 1000 mm line, with `Everything has been redone`, and the observer must record no ordinary transaction or write lock for the empty lookup. Source predicts both unsafe access calls despite the empty list. Use an otherwise identical no-click control to distinguish this from the still-open general first-pick issue.

   **Typed/clicked steps B:** on a fresh copy, draw the same line, click the same zero-count button, then type one `_.U`. Assert the line disappears immediately. Record the Undo description; a nameless step leaving the line present is a failure. There must be no zoom because the list is empty.

   **Correction direction:** return immediately for an empty list; use open-close read access for resolving non-empty lists, with a read lock only if needed. Selection/zoom must remain available after U; do not hard-block the button behind the REDO guard.

3. **U-03 — MEDIUM — window-first CD automatically starts an empty next command, so cancelling that window costs another U. VERIFIED-BY-READING; native retest pending.**

   **File:line:** `Modules/Drainage/Commands/CdCommand.cs:239`, `:242`; `Services/PlacementContinuationService.cs:78`, `:83`, `:89`; Settings control at `Dialogs/AdvancedSettingsDialog.xaml:609` and `Dialogs/CivilSettingsView.xaml:194`.

   **What happens in AutoCAD:** with the pipe window shown first, the drafter places one pipe and gets another New Pipe window automatically. Cancelling it, then pressing U once, leaves the finished pipe in place. A second U is needed. That breaks the stated one-U-after-stopping placement contract for an exposed Settings choice.

   **Exact failure scenario:** `CdDrawFirst=false` uses `ContinueWithoutAsking`, which unconditionally queues `CD` after successful placement. The next command starts and displays its own window; Cancel returns from that second invocation. The route-first branch avoids this by asking the next first point inside the completed pipe's command. The helper's own comment expressly records that window-first cancellation leaves the old empty Undo step. This is an acknowledged source residual, not a newly introduced release regression and not a new claim about the already-audited writing initialiser. Even removing that initialiser's writes would not remove the extra command boundary.

   **DETERMINISTIC TEST — fixture:** fresh synthetic millimetre Civil drawing, World UCS, all layers unlocked, ordinary straight pipe with no crossings, normal inline label. In the fixture Settings turn off `Pick the route first, then open the pipe window` (the other Settings view calls it `Draw pipe run before options dialog (CD)`). Preserve and restore fixture Settings after the test.

   **Typed/clicked steps:** type `CD` interactively. In New Pipe choose 225 mm, first invert RL 10.000 m, second invert RL 9.900 m; accept. Pick `0,0` and `10000,0`, finish the route and complete any annotation prompts. At `[CE] Pipe placed. Opening the next pipe - press Esc there to stop.`, let the next New Pipe window appear, then press Esc or click Cancel. Type one `_.U` immediately, without TEXTSCR, LIST or any other intervening command.

   **Assertions:** one U must remove the pipe, its labels and its project row. Current control flow predicts that U consumes the automatically started cancelled CD, leaving the pipe; a second U removes it. After the first U, an event observer must record that the pipe is still live without issuing a command to inspect it. Repeat route-first ON as the control: Esc at the next first-point prompt and one U must remove the accepted pipe. Run by UI/keyboard, not a script or LISP wrapper: `ContinueWithoutAsking` deliberately skips chaining in those contexts, so an automated command-script test alone misses the fault.

   **Correction direction:** avoid starting another command merely to offer a window the drafter may cancel. Keep continuation admission inside the current placement's boundary or provide an explicit continuation action that preserves one U per accepted item. No engineering setting or new refusal is required.

## Coverage and exclusions

1. **Undo marks and transactions.** No direct Civil use of `UNDOCTL`, `UNDOMARKS`, `StartUndoMark`, `EndUndoMark`, `StartUndoRecord` or `NoUndoMarker` was found. Ordinary modal commands rely on AutoCAD command boundaries. Lack of a manual mark is not itself a fault. Multiple committed transactions inside one command also do not, by themselves, prove multiple U steps. Transaction locals at the inspected atomic apply sites have explicit abort/dispose lifecycles; no proven leaked transaction is added to this report.

2. **Shared history and background paths checked.** `ProjectDataService.Persistence.cs:504` only performs idle housekeeping; it does not flush records there. The history branch at `LinkService.Reactors.cs:867` reloads the project and caches through light reads. `RedoWindowGuard` defers the inspected automatic QA, Xref checks, Inspector scans, link-cache refresh, pit migration and native-pipe upgrade. Their timeout behaviour is an explicit Settings choice. These observations are source checks, not certification of host event order or all AutoCAD versions.

3. **Two tempting false positives excluded.** The post-save drawing-order callback is write-capable, but its CLEAN/FASTSAVE path also clears the pending flag at bulk-command completion; the existence of that callback alone does not prove a normal extra Undo step. Slab compound-move registration is held OFF (`SlabCompoundMoveAutoCadAdapter.StartupEnabled=false`); its dormant writer is not counted as an installed drafting fault. Opening/refreshing pit definitions is intentional migration behaviour; no new unexplained REDO attribution is made from its mere existence.

4. **Previous findings not counted again.** Disabled CDCHECKIGNORE and preview/cancelled CDTIDYLABELS writing through shared initialisation; outcome-log semantics; the missing double-click selection; generic plain-pick REDO loss; and the right-click network selection investigation remain in their existing audits/bug records. U-01 traces a distinct lost ownership write. U-02 supplies an exact additional read-only UI route. U-03 identifies the exposed window-first continuation residual. No bug-register edits or new bug IDs are made under this one-file brief.

5. **Evidence still required.** Test on full AutoCAD 2024 and 2027 where applicable. A later observer should capture command end/cancel events, active transaction count before/after, database identity and passive `UNDOCTL`/`UNDOMARKS` values where supported. Never type diagnostic commands into the U/REDO interval. Tests here are instructions only: builds 0, unit tests 0, native tests 0, installs 0. Civil + Manager delivery remains 9 November; Manager administrator work stays parked.

## Summary

1. **Summary — 74 words.** Three findings remain: an Esc-ended accepted callout pipe can lose its unwritten ownership link; an empty Inspector lookup takes history-changing access; and window-first CD leaves an extra cancelled-command Undo step. Prior audits' faults are excluded. The shared idle saver and guarded history readers were not blamed without evidence. Each finding has a synthetic fixture and observable assertions. Only this findings file changed; no source, settings or drawings were changed, and no build or test ran.
