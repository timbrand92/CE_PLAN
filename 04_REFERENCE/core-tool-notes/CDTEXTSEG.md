# TOOL NOTE: Move pipe text to another leg (CDTEXTSEG)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Moves a pipe's label** to the middle of another leg of the same pipe (a pipe with two or more legs).
2. **Picks the leg you click** (nearest to your click, switch on), and turns the label to read left to right.
3. **Only the label moves;** the flow arrow stays.

## 2. What it changes in the drawing

1. **The pipe label** (text or callout): new position and angle.
2. **CE's record of that label** is rebuilt afterwards.
3. **No whole-drawing record update.**

## 3. What it will not do

1. **No start-up checks:** no read-only, Paper Space, REFEDIT or drawing-type check.
2. **A pipe with no label CE can find:** "Unable to resolve pipe text for the selected pipe." It finds only the first label on the pipe text layer.
3. **A one-leg pipe:** "Pipe only has one segment. There is nothing to move between."
4. **Locked layer:** the standard locked-layer line, after both questions; nothing moves.

## 4. What it asks you, and what Enter means

1. **"Select pipe to move text between segments":** Esc ends quietly.
2. **"Pick a point to move pipe text to that segment, or press Enter to accept":** Enter or Esc leaves the label where it is, with no message.
3. **Nothing is written before the second answer.**

## 5. When it says Unknown or "needs checking"

1. **Not applicable.** It prints "Pipe text moved." when done.

## 6. How to undo it

1. **U once.** One command. Not proven in AutoCAD.

## 7. Known faults

**Still there in this build**
1. **BUG-1161:** moving the label forgets its kept wording (for example "APPROX."); the label's record is rebuilt without it.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-1194:** the leg you click is used, not the nearest leg midpoint (switch on).
2. **BUG-1195:** the label angle is worked out in World, not the UCS (switch on).

**New in code, no bug covers it**
1. **No start-up checks;** in REFEDIT the label can move while its record is not written (not proven).
2. **Twin detention pipes:** the label may land on the barrels (the move ignores the twin width; not proven).
3. **Not marked placed by hand,** so Tidy labels can move it again.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1 to 1.3, 2.1:** `Commands\CdCommand.Arrows.cs:20-45`; `Services\PipeTextPlacementService.cs:21-50`, `69`, `87-116`, `208-215`.
2. **2.2:** `PipeTextPlacementService.cs:122`.
3. **2.3, 3.1, 7 new 1:** no `CommandPreFlight` or record update in `CdCommand.Arrows.cs:20-50`; `Services\LinkService.Persistence.cs:1184`.
4. **3.2:** `CdCommand.Arrows.cs:33`, `188-232` (first label only at 215-226).
5. **3.3:** `CdCommand.Arrows.cs:39`.
6. **3.4:** `PipeTextPlacementService.cs:80`.
7. **4.1, 4.2:** `CdCommand.Arrows.cs:28`; `PipeTextPlacementService.cs:33-43`.
8. **5.1:** `CdCommand.Arrows.cs:45`.
9. **7 BUG-1161:** `PipeTextPlacementService.cs:122`; `Services\LinkService.cs:1161-1173`; `Services\LinkService.SegmentAnalysis.cs:259-281`.
10. **7 BUG-1194:** `Helpers\PipeTextSegmentChooser.cs` (`NearestSegmentToPick`); `PipeTextPlacementService.cs:48`; `Models\UserSettings.cs:931`.
11. **7 BUG-1195:** `PipeTextPlacementService.cs:193-206`; `UserSettings.cs:940`.
12. **7 new 2:** `PipeTextPlacementService.cs:69` against `Services\ArrowService.cs:33`.
13. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:58. Nothing was run in AutoCAD.
