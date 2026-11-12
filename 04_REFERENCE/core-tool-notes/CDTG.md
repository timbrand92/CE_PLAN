# TOOL NOTE: Trench grate (CDTG, also TG)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Draws a trench grate** between a start point and an end point, at the width, style and class you choose, with a callout.
2. **Records it** in CE's record as a TG item (not in the Pit Schedule), with its cover level and outlet if given.
3. **One per command.** It does not carry on.

## 2. What it changes in the drawing

1. **Draws** the TRENCH GRATE block on layer TRENCH GRATE, stretched to the length and width, turned along the run; a tag label; and a callout on 25DIMS.
2. **Stores** a record row: tag, length in mm, style, cover level (blank if skipped), width, class, outlet.
3. **Splits the nearest pipe at the grate** and rejoins every pipe end, with no preview or question.
4. **Full record update before the first question.** Before asking anything it runs CE's forced whole-drawing record update and saves. Esc later does not take it back.
5. **Remembers** width, style, class and the cover level for this drawing until AutoCAD closes (not in a file).
6. **The callout sets the 25DIMS layer's colour to 7** if that layer exists and is unlocked (not proven).

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **Same point twice** (1 mm or less, metre drawings converted): "Those two points are the same point. TG command cancelled."
3. **No locked-layer or Xref check** of its own after the questions.
4. **Block file missing:** you answer every question, then only "TG command cancelled."; the reason is in the CE log.

## 4. What it asks you, and what Enter means

1. **"Specify trench drain start point":** Esc or Enter: "TG command cancelled."
2. **"Specify trench drain end point":** live length and angle. Enter not accepted; Esc cancels.
3. **"Trench width <last>":** Enter takes the last width (300 mm from Settings the first time).
4. **"Trench grate style [Standard/ACO] <last>":** Enter takes the last style.
5. **"Grate class [A/B/C/D] <last>":** Enter takes the last class (C from Settings the first time).
6. **"Cover Level (m AHD) or [Blank] <enter to skip>":** Enter takes the level remembered for this drawing, or leaves it blank if none (never 0.000). Type B for Blank to skip when a level is remembered.
7. **"Select outlet pit or pipe (Enter to skip)":** Enter skips. A wrong pick: "That isn't a CE pit or pipe. Pick one, or press Enter to skip."
8. **Esc at any question:** "TG command cancelled." The full record update has already run.

## 5. When it says Unknown or "needs checking"

1. **Cover level skipped** is stored blank and the callout leaves out the cover line.
2. **Overlap with another pit or source:** a warning, then it carries on.

## 6. How to undo it

1. **U once** is expected (one command), but the parts are written in separate steps; if one fails part way, what was already placed stays and it says "Error during TG - see CE log for details."
2. **Not undone by U:** the remembered width, style, class and level (memory only).

## 7. Known faults

**Partly fixed**
1. **BUG-745 (metre drawings):** the same-point test, width, length words, record and callout are converted. Whether the block itself is sized right in a metre drawing: could not confirm.
2. **BUG-432:** Enter now stores blank, not 0.000, and the callout leaves out the line. Still there: the label goes on GUIDELINES with no locked-layer check. "Existing 0.000 grates read as not known": could not confirm.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-743:** the remembered cover level is per drawing, and Blank exists. It holds one drawing at a time: a level typed in another drawing replaces it.

**New in code, no bug covers it**
1. **Forced full record update before the first question** (the same pattern removed from CDFW for BUG-650).
2. **Not all-or-nothing:** block, tag, record, callout and split are separate steps.
3. **Settings are read once per AutoCAD session,** not per drawing; a Settings change mid-session is ignored.
4. **The words "enter to skip"** stay even when Enter would take a remembered level.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 2.1:** `Commands\SourceBlockInsertCommands.cs:128-130`, `255-351`, `830-862`; `Services\LayerService.cs:131, 158-160`.
2. **1.2, 2.2:** `SourceBlockInsertCommands.cs:369-388`.
3. **1.3:** no `PlacementContinuationService` in `SourceBlockInsertCommands.cs:130-415`.
4. **2.3:** `SourceBlockInsertCommands.cs:394-398`.
5. **2.4, 7 new 1:** `SourceBlockInsertCommands.cs:147-149`; `Services\ProjectDataService.cs:264-270`.
6. **2.5, 6.2:** `SourceBlockInsertCommands.cs:24-33`, `356-362`; `Rules\TrenchGrateCoverMemory.cs:16-32`.
7. **2.6:** `Services\TextService.cs:699`; `LayerService.cs:128, 344-357, 484-486`.
8. **3.1:** `SourceBlockInsertCommands.cs:136`; `Services\DrawingSafetyService.cs:61-131`.
9. **3.2:** `SourceBlockInsertCommands.cs:188-191`; `TrenchGrateCoverMemory.cs:38-39`.
10. **3.3:** no lock or Xref test in `SourceBlockInsertCommands.cs:255-409`.
11. **3.4:** `SourceBlockInsertCommands.cs:261-265`; `Services\BlockService.cs:1028-1033`.
12. **4.1 to 4.8:** `SourceBlockInsertCommands.cs:159-246`, `699-748`, `760-790`; `Commands\AgiCommand.cs:218-251`; Settings defaults `Models\UserSettings.cs:3461, 3465`.
13. **5.1:** `SourceBlockInsertCommands.cs:784-801`, `812-814`. **5.2:** `SourceBlockInsertCommands.cs:251-252`.
14. **6.1, 7 new 2:** `SourceBlockInsertCommands.cs:255-414`.
15. **7 BUG-745:** `SourceBlockInsertCommands.cs:188, 197-215, 300-301, 331, 373, 400`.
16. **7 BUG-432:** `SourceBlockInsertCommands.cs:784-801, 812-814, 350`; `Services\SourceTagService.cs:539-551`.
17. **7 new 3:** `SourceBlockInsertCommands.cs:36-53`.
18. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:40. Nothing was run in AutoCAD.
