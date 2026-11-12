# TOOL NOTE: Strip drain (CDSTRIP)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Draws a strip drain** along the points you pick (a double line), with floor wastes along it and fall arrows.
2. **Shows a preview and asks Accept or Cancel** before anything is drawn.
3. **Records it** as a strip drain (SD tag), not in the Pit Schedule.

## 2. What it changes in the drawing

1. **Draws** a double line (100 wide) on layer STRIP DRAIN, FLOOR WASTE blocks on the centreline at corners, ends (set in 50 mm) and no more than 12 m apart (a Settings value), high-point marks, and fall-arrow leaders.
2. **Stores** a record row with an SD tag.
3. **Everything is drawn in one step after you press Accept.**
4. **No whole-drawing record update before the questions.**
5. **The "TIM LEADER" dimension style** is created or overwritten for the whole drawing (scale 100, arrow 3.0).

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open. A Structural or untagged drawing is asked first; the answer is applied at Accept.
2. **Before the first question:** refuses if FLOOR WASTE.dwg is missing ("... Nothing was drawn.") or the STRIP DRAIN layer is locked ("Layer STRIP DRAIN is locked.").
3. **At Accept** it refuses REFEDIT, a changed drawing, a locked layer or a changed line style.
4. **Metre drawings:** no unit handling; widths and spacings are millimetres taken as drawing units.

## 4. What it asks you, and what Enter means

1. **"Justification [Top/Center/Bottom] <Center>":** Enter = Center. Esc: "CDSTRIP cancelled - nothing was drawn."
2. **"Specify first strip drain point":** Enter not accepted; Esc cancels.
3. **"Next point (N pts) or Enter to finish [Close/Undo]":** Enter finishes an open drain from 2 points. Close is offered from 2 points. Undo removes the last point (cancels if only one is left). Live words show while picking.
4. **"Place this strip drain? [Accept/Cancel] <Accept>":** **Enter = Accept.** Esc or Cancel draws nothing.

## 5. When it says Unknown or "needs checking"

1. **Not applicable;** the preview line describes what will be drawn.

## 6. How to undo it

1. **U once.** It says so; the drawing is one step.

## 7. Known faults

**Partly fixed**
1. **BUG-028:** ends are set in 50 mm; corners are at 0 (Tim's locked rule R6.7), not 25.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-022:** floor wastes sit on the centreline at corners, ends and spacing.
2. **BUG-290:** no full record update before the preview or question.

**Reported, could not confirm in code**
1. **BUG-029:** the code draws a plain leader on STRIP DRAIN with dimension style TIM LEADER, one arrow on a short run, otherwise two at the quarter points, with no FALL text. Whether that matches Tim's latest ruling is not known.

**New in code, no bug covers it**
1. **Overwrites the "TIM LEADER" dimension style** in the drawing.
2. **The layer name is fixed** ("STRIP DRAIN"), so a layer rename in Settings is ignored.
3. **Close is offered with only 2 points.**
4. **No unit handling** for metre drawings.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 2.1:** `Commands\StripDrainCommand.cs:34-68`, `316-322`; `Commands\StripDrainCommand.Plan.cs:81-124`, `182-189`; `Commands\StripDrainCommand.Apply.cs:196-203`; `Models\ReachSettings.cs:14, 28`.
2. **1.2, 4.4:** `StripDrainCommand.cs:139-146`, `319-324`.
3. **1.3, 2.2:** `StripDrainCommand.Apply.cs:261-290`.
4. **2.3, 6.1:** `StripDrainCommand.Apply.cs:84-130`.
5. **2.4, 7 BUG-290:** `StripDrainCommand.cs:87-93`; `Commands\CeCommandBase.cs:53-58`.
6. **2.5, 7 new 1:** `StripDrainCommand.Apply.cs:95, 374-388`; `StripDrainCommand.cs:40-41, 50-52`.
7. **3.1:** `StripDrainCommand.cs:75`; `Services\DrawingSafetyService.cs:22-30`.
8. **3.2:** `StripDrainCommand.Apply.cs:41-54`.
9. **3.3:** `StripDrainCommand.Apply.cs:84-92`.
10. **3.4, 7 new 4:** no unit handling in `StripDrainCommand*.cs`.
11. **4.1 to 4.3, 7 new 3:** `StripDrainCommand.cs:157-292`.
12. **7 BUG-028:** `StripDrainCommand.cs:61-68, 316-322`. **7 BUG-022:** `StripDrainCommand.Plan.cs:81-124`. **7 BUG-029:** `StripDrainCommand.cs:48-52`; `StripDrainCommand.Plan.cs:182-189`.
13. **7 new 2:** `StripDrainCommand.cs:34`; `Services\LayerService.cs:365-368`.
14. **8.1:** no `#if` in `StripDrainCommand*.cs`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:00. Nothing was run in AutoCAD.
