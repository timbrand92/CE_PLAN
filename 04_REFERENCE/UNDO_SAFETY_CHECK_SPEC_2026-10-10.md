# Undo-safety check for every build (spec, 10 Oct 2026)

**Why.** Tim, 10 Oct 2026 (decompile chat), choosing "all" of: *"An undo-safety check for every new build ...
so this kind of bug can't sneak back."* REDO in AutoCAD 2027 is destroyed by plugin code that runs between the
user's U and REDO, even with no command (measured; `ENGINEERING_RULEBOOK.md` guardrail 8 item 17;
`areas\AUTOCAD_API_DECOMPILE_TESTING_ANSWERS_2026-10-10.md` R2-2). BUG-256 and BUG-558 are this class.
Owner of the build: the desk routes it; repo code belongs to its builders. This file is the spec only.

**Hard limit learnt:** the core console has NO Idle loop and only one drawing (BUG-256 history: a console-only
"proof" was wrong in real AutoCAD). So a headless run cannot exercise CE's Idle, palette, selection or
drawing-switch code. The check therefore has two layers.

## Layer 1: code-scan rule (runs in every build, no AutoCAD)

Add to the existing IL guard (the "Cecil guard" in the test suites):
1. **Roots:** every method subscribed to `Application.Idle`, `DocumentCollection.DocumentActivated /
   DocumentBecameCurrent / DocumentToBeActivated / DocumentCreated`, `Document.ImpliedSelectionChanged`,
   `Document.CommandEnded / CommandCancelled / CommandFailed`, `Database.ObjectModified / ObjectAppended /
   ObjectErased`, `SystemVariableChanged`, `DispatcherTimer.Tick`, `TransientManager` / overrule callbacks
   (`WorldDraw`, `GetGripPoints`, `MoveGripPointsAt`, `TransformBy`), `PointMonitor`.
2. **Forbidden within N call levels (start N = 4):** `TransactionManager.StartTransaction`,
   `Editor.SetCurrentView`, `Application.SetSystemVariable`, `Document.SendStringToExecute`,
   `Editor.Command` / `CommandAsync`, `DocumentCollection.ExecuteInCommandContextAsync`, P/Invoke
   `acedPostCommand`, any `OpenMode.ForWrite` open.
3. **Allowed:** `StartOpenCloseTransaction` reads, `Regen`, `UpdateScreen`, `SetImpliedSelection`,
   `LockDocument(Read)`, `GetCurrentView`, `GetSystemVariable`.
4. **Escape hatch, never silent (R-27 warn + record):** a call site may be allowed only with an attribute or a
   listed entry naming WHY it cannot run between U and REDO (e.g. "gated: skips when the last command was
   U/UNDO/REDO"). The list is printed in the test output so it stays visible.
5. Start as a WARNING list (today's code has known hits, see the REDO-breaker sweep), then turn into a failure
   per module once its list is cleared.

## Layer 2: real-AutoCAD routine (driver or Codex, once per installed build)

Test copies only, CE loaded, one drawing pair (a Civil copy with a CD pipe and a pit; a Structural copy).
Each line: draw `CIRCLE 0,0 5`, type `U`, do the action, type `REDO`, expect **"Everything has been redone"**.
1. wait 15 s (Idle only);
2. switch to the other drawing and back (Ctrl+Tab twice);
3. click once on a CE pipe, then Esc (selection handlers, contextual tab);
4. hover over a CE pit for 3 s (PointMonitor / hover);
5. open and close the CE Inspector / Hub palette;
6. the same five in the Structural copy with a beam and a footing.
Pass = all "redone". Record in the witness log which CE handlers ran between U and REDO.

## Layer 3: headless guard for transaction-only paths (optional)

`C:\Tools\AcadProbe` already measures U/REDO around any API call from LISP (no command). Builders can wrap a
CE service method in a `[LispFunction]` test probe to prove it keeps REDO, for code that never needs Idle.
