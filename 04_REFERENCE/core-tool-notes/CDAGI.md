# TOOL NOTE: AGI drain (CDAGI)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Draws an agricultural (AG) drain** along the points you pick, with the AG line type, and records it with an AGI tag.
2. **Can join it to an outlet pit or pipe** and take start and end levels, then shows the grade against the office minimum.
3. **Shows a preview and asks Accept or Cancel** before drawing.

## 2. What it changes in the drawing

1. **Draws** one polyline on layer AGI DRAIN (or the Charged or Suspended layer), line type AG_LINE (loaded from the shipped file if needed).
2. **Stores** a record row: AGI tag, outlet, grade text.
3. **Everything is drawn in one step after Accept.**
4. **No whole-drawing record update before the questions.**

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open. A Structural or untagged drawing is asked first; the answer is applied at Accept.
2. **After the property question, before any point:** refuses a locked layer ("CDAGI refused - Layer X is locked. Nothing was drawn.") or a missing AG_LINE line type (same "refused ... Nothing was drawn." wording).
3. **A closed drain needs 3 points:** "A closed drain needs at least 3 distinct vertices."
4. **At Accept** it refuses REFEDIT.

## 4. What it asks you, and what Enter means

1. **"AG drain pipe property [None/Charged/Suspended] <None>":** Enter = None. Esc: "CDAGI command cancelled."
2. **"Specify first AGI vertex",** then **"Next AGI vertex (N pts) or Enter to finish [Close/Undo]":** Enter finishes from 2 points; Close needs 3.
3. **"Select outlet pit or pipe (Enter to skip)":** Enter skips. A wrong pick: "That isn't a CE pit or pipe. Pick one, or press Enter to skip." Esc cancels.
4. **"Start invert level (m) <skip>", "End invert level (m) <skip>":** Enter skips. **Esc also skips,** it does not cancel.
5. **"Place this AGI drain? [Accept/Cancel] <Accept>":** **Enter = Accept.**

## 5. When it says Unknown or "needs checking"

1. **Grade line:** shows the worked-out grade and whether it meets the office minimum (1 in 100 from Settings).

## 6. How to undo it

1. **U once.** The drawing is one step.

## 7. Known faults

**Still there in this build**
1. **BUG-1052:** in a metre drawing the run length is treated as millimetres, so a flat drain can be reported as meeting the minimum grade (a 10 m run reads as 1:10). CDPERIMETER shares this.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-290:** no full record update before the preview or question.

**New in code, no bug covers it**
1. **Esc at the level questions skips** instead of cancelling.
2. **Snap-close and outlet-join distances** are 1 drawing unit, treated as 1 mm (1 m in a metre drawing).

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 2.1, 2.2:** `Commands\AgiCommand.cs:59-72`; `Commands\AgiCommand.Apply.cs:129-133`, `210-227`.
2. **1.2, 4.3 to 4.5, 5.1:** `AgiCommand.cs:133-162`, `218-251`, `264-313`, `428-434`; `Models\UserSettings.cs:3472`.
3. **2.3, 6.1:** `AgiCommand.Apply.cs` (one transaction; message at `AgiCommand.cs:160`).
4. **2.4, 7 BUG-290:** `AgiCommand.cs:84-93`; `Commands\CeCommandBase.cs:53-58`.
5. **3.1:** `AgiCommand.cs:75`; `Services\DrawingSafetyService.cs:22-30`.
6. **3.2:** `AgiCommand.cs:103-107` (the message printed); `AgiCommand.Apply.cs:32-52` (the reasons).
7. **3.3:** `Commands\AgiCommand.Plan.cs:127`.
8. **3.4:** `AgiCommand.Apply.cs:84-86`.
9. **4.1, 4.2:** `AgiCommand.cs:185-191`, `336-399`.
10. **7 BUG-1052:** `AgiCommand.cs:264-295`; `Commands\AgiCommand.GradeDirection.cs:57`.
11. **7 new 1:** `AgiCommand.cs:304-313`.
12. **7 new 2:** `AgiCommand.Plan.cs:77`; `AgiCommand.GradeDirection.cs:24`.
13. **8.1:** no `#if` in `AgiCommand*.cs`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 02:19; corrected after independent review. Nothing was run in AutoCAD.