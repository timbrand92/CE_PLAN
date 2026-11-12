# TOOL NOTE: Move and rotate (MR)

**Core since:** not yet (first tool on trial)
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Moves the objects you select and then rotates them** about the destination point, in one go.
2. **On AutoCAD 2027** it is CE's own move-rotate, which accepts only eight plain kinds of object (see 3).
3. **On AutoCAD 2022 to 2026** it runs the office LISP move-rotate (AutoCAD's MOVE then ROTATE).

## 2. What it changes in the drawing

1. **Moves and rotates** the selected objects.
2. **CE's record:** MR writes nothing itself; in a CE drawing CE's usual clean-up after a move runs when MR ends (pit labels and cover text follow their pit).
3. **No whole-drawing record update.**

## 3. What it will not do

1. **No start-up checks** for a read-only drawing, Paper Space or a Structural drawing.
2. **On 2027, only these kinds:** line, circle, arc, ellipse, lightweight polyline, single-line text, multiline text, block. Anything else stops it: hatches (so a raingarden's fill), CE's pipe object (so pipes drawn on 2027), pipe outlines, leaders and dimensions. It cannot move a CE pipe.
3. **On 2027 it refuses** REFEDIT ("Run REFCLOSE first. Drawing unchanged."), anything or any attribute on a locked layer, Xref and overlay blocks, and anything not in the current space. It unlocks nothing.
4. **The whole selection is checked** before "Specify base point", and again after the move.

## 4. What it asks you, and what Enter means

1. **On 2027:** "Select objects": Enter with nothing selected ends quietly.
2. **"Specify base point":** Enter or Esc ends; nothing changed.
3. **"Specify destination point":** Enter is not accepted; Esc ends quietly.
4. **"Specify rotation angle <0>":** **Enter = 0.** The objects are moved without rotating and the move is kept.
5. **Esc ends quietly** at every question.
6. **On 2022 to 2026:** AutoCAD's own MOVE and ROTATE questions.

## 5. When it says Unknown or "needs checking"

1. **A refusal on 2027** prints a code word first, for example "CE transform stopped (eNotApplicable). Drawing changes rolled back.", then "This trial accepts ordinary local lines, arcs, circles, ellipses, lightweight polylines, text and blocks only; external/protected content is blocked." It does not name the object that stopped it.
2. **Locked layer:** "CE transform stopped (eOnLockedLayer) ..." then "The selection contains an object or attribute on a locked layer."

## 6. How to undo it

1. **On 2027: U once.** One change, committed once; Esc before the end writes nothing.
2. **On 2022 to 2026:** no undo grouping in the LISP, so MOVE and ROTATE are probably separate U steps (not proven).

## 7. Known faults

**Still there in this build**
1. **BUG-1245:** the refusal shows a code word and "This trial ...", and does not say which object stopped it.

**Filed under MR but not MR's code**
1. **BUG-519:** Structural's start-up text on the command line. Still there in Structural's code; only one of its lines mentions MR.

**New in code, no bug covers it**
1. **No start-up checks** (read-only, Paper Space, Structural drawing) on any AutoCAD version.
2. **Cannot move pipes drawn on 2027** (CE's pipe object is not on the list); old plain-polyline pipes do move.

## 8. On AutoCAD 2022 to 2026

1. **A different tool:** the office LISP move-rotate, with no object-type limits beyond AutoCAD's own, and REFEDIT refused ("MoveRot: Cannot run inside an active REFEDIT session").
2. **Also on 2025 and 2026** (every build except 2027). A Settings switch (off by default) chooses a CE version of the command there, but it is not the 2027 tool: it still runs AutoCAD's own MOVE then ROTATE, with its own REFEDIT refusal ("[CE] This command cannot run while you are editing in place (REFEDIT). Type REFCLOSE first, then try again.").

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\`.

1. **1.1, 1.2, 3.2:** `Shared.Transform.Native2027\TransformCommands.cpp:157-176`, `256-338`; `Drainage\Commands\CopyRotateCommands.cs:1-66` (`#if NET10_0_OR_GREATER`, 2027).
2. **1.3, 8.1, 8.2:** `Drainage\Commands\CopyRotateCommands.cs:67-424` (`#else` of `#if NET10_0_OR_GREATER`; switch at `117-186`: AutoCAD's own MOVE then ROTATE, REFEDIT line at about 147), `374-389`, `399-424`; `Drainage\Models\UserSettings.cs:2324-2325`; LISP `Drainage\Assets\Lisp\Copy Rotate.lsp`.
3. **2.2:** `Drainage\Services\ExternalMutationCommandPolicy.cs:20`; `Drainage\Services\LinkService.Reactors.cs:542, 636-660, 1739-1768`; `Drainage\Services\LinkService.PipeMoveHelpers.cs:326-342` (labels following a moved pit; `LinkService.Utilities.cs:253-258` is the COPY clean-up, not MR).
4. **2.3, 3.1, 7 new 1:** no `CommandPreFlight` in `CopyRotateCommands.cs`.
5. **3.2, 7 new 2:** `TransformCommands.cpp:162-167`; pipe object class `Drainage.NativeObjects2027\CeCvlPipeObject.h:27`; `Drainage\Services\PipePickService.cs:20-30`; raingarden layers `Drainage\Services\LayerService.cs:205, 210`.
6. **3.3:** `TransformCommands.cpp:140-176`, `262`.
7. **3.4:** `TransformCommands.cpp:275-285`, `298`.
8. **4.1 to 4.5:** `TransformCommands.cpp:113-127`, `205-215`, `266`, `288`, `294`.
9. **5.1, 5.2, 7 BUG-1245:** `TransformCommands.cpp:322-336`.
10. **6.1:** `TransformCommands.cpp:269, 294, 322`.
11. **7 BUG-519:** `Structural\Plugin.cs:178, 192, 214, 217, 221, 225`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 02:33; corrected after independent review. Nothing was run in AutoCAD.
