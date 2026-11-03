# BUGFIX w1148 (B-192) — BUG-1148 report, 3 Nov 2026

**Result: STOPPED. No PR opened. Needs Tim's engineering call (one question below).**

## FOR TIM

1. **What I found:** the bug is real in the code, but the fix as written in the carpark would break something you already rely on. I did not build anything.
2. **Why:** when you paste a pit from Stage 2 into Stage 1, AutoCAD tells CE "this came from another drawing". It tells CE exactly the same thing when you copy a pit and paste it back into the SAME drawing (Ctrl+C, Ctrl+V). A "Save As" sister keeps the same pit handles and the same pit identity as the original. So the pasted Stage 2 P4 looks identical, to CE, to an ordinary copy of Stage 1's own P4. Checking "matching, non-blank identity" cannot tell them apart, because the identity matches in both cases.
3. **What it would break:** a past review (PR #474, rated HIGH) fixed the opposite fault. Ordinary copy and paste inside one drawing must count as local. Two tests pin it (`F2_AutoCADsCopyMap_NamingAnotherDrawing_IsNotProofOnItsOwn`, `F2_CtrlCThenCtrlV_InsideOneDrawing_APitAndAPipe_AreLocalCopies`). Making the map win would turn every in-drawing paste into a "foreign" paste.
4. **The blank-identity half:** a drawing never upgraded to identity keys also looks local today, on purpose (stated in the rule's comment). Changing that is a behaviour call for older drawings, not a safe small change.
5. **My mistakes:** none made; I read code only, ran no builds or tests, touched no settings, bundles or drawings. Nothing here is proven in AutoCAD.

## THE ONE QUESTION FOR TIM

**How should CE tell "pasted from a Save As sister" from "pasted from this same drawing"?** Suggested answer: compare the drawing the clipboard came from with this drawing (its stored drawing identity, which a Save As would change only if CE re-stamps it on Save As). If the source drawing identity differs, treat as foreign. If CE does not re-stamp identity on Save As, the sisters share one identity and the question becomes: should Save As give the new drawing its own identity? That is a design card, and AutoCAD is needed to see what the clipboard drawing exposes.

## Technical detail

1. **Base:** origin/claude/rel-20261102a at 3fbb9da5. Not already fixed there.
2. **Decision code:** `Modules/Drainage/Rules/CloneOriginRule.cs` `Decide` (the lines after the "Review fix (Opus, PR #474, HIGH)" comment). Local = named handle found here, same kind, and keys equal, or either key null. A blank-versus-blank or matching key returns `ThisDrawing` whatever the map says.
3. **Map is logged only:** `MapSaysOtherDrawing` is set in `LinkService.ForeignClones.cs` (about line 130, 207) and `LinkService.Utilities.cs` (about line 1282, 68) and `Decide` never reads it.
4. **Needed to fix:** a new fact in `CloneOriginEvidence` (the source drawing's identity from the clipboard map's source database, compared with this drawing's), plus a Settings switch ON by default, a unit test through both start-up reads, a REGRESSION_LOG entry. Reading the source database in the paste reactor is native AutoCAD behaviour I cannot see without AutoCAD, and it risks the clipboard's temporary drawing being closed (the reason `NoteQuietPasteClone` reads the map early). More than one small change, so stopped per the batch instruction.
5. **Robot case to write once the answer is in:** type COPYCLIP on P4 in the Stage 2 sister, open Stage 1, type PASTECLIP, then read the new pit's size, type and invert in Edit Pit. Passes if they equal Stage 2's values. Switch-off control: with the switch OFF the pasted pit shows Stage 1's P4 values (old behaviour). Control 2: Ctrl+C, Ctrl+V of P4 inside Stage 1 must stay a local copy with a new number, switch ON or OFF.
6. **Disk, worktree, isolation listings:** no worktree created, no tests run, nothing in %APPDATA% written by this job, so no before/after listings needed.
