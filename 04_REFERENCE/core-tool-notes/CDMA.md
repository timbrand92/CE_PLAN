# TOOL NOTE: Move a flow arrow (CDMA)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Pick an arrow** and it moves the arrow to a new point.
2. **Pick a pipe** and it places a new flow arrow on the pipe leg you picked, pointing downhill from two levels you type, or in drawing order.
3. **The Pipe editors use the same steps** for their "Move arrow" button.

## 2. What it changes in the drawing

1. **Arrow picked:** moves the arrow block (its rotation is not changed).
2. **Pipe picked:** inserts a flow arrow on the ARROW layer on that leg and attaches it to the pipe.
3. **The levels you type only set the arrow's direction;** they are not stored on the pipe.
4. **No whole-drawing record update.**

## 3. What it will not do

1. **No start-up checks:** no read-only, Paper Space, REFEDIT or drawing-type check.
2. **Does not check the block is an arrow:** any block picked (a pit, a title block) can be moved.
3. **Locked layer:** the standard locked-layer line, then "Failed to move arrow."
4. **Does not check for an arrow already on the pipe;** a second arrow can be added (read from code, not run).

## 4. What it asks you, and what Enter means

1. **"Select flow arrow to move OR select pipe segment to place arrow on":** a wrong pick says "Please select an arrow block or a pipe." Esc: "Move arrow cancelled - nothing changed."
2. **Arrow picked: "Specify new arrow position":** Esc: "Command cancelled."
3. **Pipe picked: "Enter first invert level [or press Enter to skip]":** Enter skips the levels. **Esc also skips;** it does not cancel.
4. **"Enter second invert level"** (only if the first was a number).
5. **"Reverse arrow direction? [Yes/No] <No>":** Enter = No. **Esc also means No,** and the arrow is still placed.

## 5. When it says Unknown or "needs checking"

1. **No levels, or one level:** the arrow follows drawing order and it says "Direction: drawing order".

## 6. How to undo it

1. **U once.** One command. Not proven in AutoCAD.

## 7. Known faults

No bugs are filed under this command.

**New in code, no bug covers it**
1. **Says "Flow arrow moved." whatever happened,** including after Esc, a locked layer, or "Failed to move arrow."
2. **Esc does not cancel** at the level and reverse questions; an arrow is placed anyway.
3. **Any block can be moved** as if it were an arrow.
4. **No start-up checks.**
5. **In a rotated UCS** the wrong pipe leg may be chosen (the pick is compared as if it were a world point; not proven).
6. **Fixed fallback values:** pipe size 100 when the polyline has no width, levels 1.0 and 0.9 when none are used.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1 to 1.3:** `Commands\CdCommand.Arrows.cs:238-300` (`MoveFlowArrowCore`), `312-340`, `346-452`.
2. **2.1:** `CdCommand.Arrows.cs:318-331`; `Services\ArrowService.cs:590-594`.
3. **2.2:** `CdCommand.Arrows.cs:429-437`.
4. **2.3:** `CdCommand.Arrows.cs:412-416`.
5. **2.4, 3.1, 7 new 4:** `CdCommand.Arrows.cs:255-262` (logging only; no `CommandPreFlight`).
6. **3.2, 7 new 3:** `CdCommand.Arrows.cs:264-268` (any block allowed), `281-285`.
7. **3.3:** `CdCommand.Arrows.cs:338`.
8. **4.1 to 4.5, 7 new 2:** `CdCommand.Arrows.cs:264-272`, `318`, `389-426`.
9. **5.1:** `CdCommand.Arrows.cs:445`.
10. **7 new 1:** `CdCommand.Arrows.cs:300`.
11. **7 new 5:** `CdCommand.Arrows.cs:290, 370`; `Services\PipePickService.cs:53`.
12. **7 new 6:** `CdCommand.Arrows.cs:377-385`, `415-416`.
13. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:58. Nothing was run in AutoCAD.
