# TOOL NOTE: Refresh a schedule (STRSCHEDREFRESH)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Brings one CE schedule table up to date with the drawing.** You pick the table; CE re-reads the braces, bored piers or tie-downs in Model space and rewrites the table's rows from the top.
2. **Works on the three tables STRSCHEDCREATE makes:** Bracing, Bored Pier and Tie-Down. A table CE did not make is not touched.
3. **Adds rows at the bottom** when there are more items than rows.

## 2. What it changes in the drawing

1. **The cell text of the table you picked,** in the columns each table has (bracing: TYPE, LENGTH, ROTATION, LAYER, HANDLE).
2. **New rows at the bottom,** copying the text height of the heading row.
3. **Tie-down table only:** rows left over from a longer list are blanked.
4. **Bored pier table:** the hidden record of which pier each row belongs to is rewritten to match the rows.
5. **CE's working list is re-read.** No write to the drawing was found on that step.
6. **It does not save the drawing.**

## 3. What it will not do

1. **Does not remove rows for erased braces or piers.** Rows past the last item keep their old text (see section 7).
2. **Does not keep typed edits.** Anything you typed into the table is written over by what the drawing says. Use STRSCHEDSYNC to push edits the other way.
3. **Refuses a read-only drawing** with "[CE_STRUC] STRSCHEDREFRESH: the drawing is read-only. Save a copy you can edit first."
4. **A table on a locked layer is left alone.** It prints "[STRSCHEDREFRESH] The schedule's layer is locked, so the schedule was not updated. Nothing was changed. Unlock the layer and run it again."
5. **Any other failure prints** "[STRSCHEDREFRESH] The schedule was not updated. Nothing was changed. Details are in the CE log."
6. **A table CE did not make: nothing happens and nothing is printed.**
7. **Does not read braces or piers on a layout tab or inside blocks.** It reads Model space only.
8. **Older brace blocks** ("A - BRACING LEFT") are not read.
9. **An old three-column pier table gets no MARK or DIA MM,** because it has no such columns. Nothing says so.
10. **Does not check for REFEDIT.** What happens there is not known.

## 4. What it asks you, and what Enter means

1. **"Select schedule table: "** One pick. Anything that is not a table is refused with "Select a Table."
2. **Esc ends the command with nothing changed.** What a bare Enter does is not known (the code does not offer it as an answer).
3. **No other question and no line on success.**

## 5. When it says Unknown or "needs checking"

1. **It never says Unknown.** A brace whose type is blank is written as type A.
2. **A legacy bored pier** (no mark, no diameter) gets blank cells.
3. **Rows for erased items stay with their old text,** with nothing to show they are stale.

## 6. How to undo it

1. **U once should put the table back.** The whole refresh is one change; not proven in AutoCAD.
2. **A failure puts nothing half done:** the change is dropped as a whole, which is why the line says "Nothing was changed". Read from the code, not seen.

## 7. Known faults

**Still open**
1. **BUG-498 (MEDIUM-HIGH):** rows for erased braces or piers stay. Four braces, one erased: the table still has four rows, the last repeating old data. A schedule that overstates bracing is the dangerous way round. The tie-down refresh does clear leftovers; the other two do not. The fix is only on an unmerged branch; the installed code has no trace of it. Not seen in AutoCAD.
2. **BUG-503 item 1:** the bracing table prints LAYER and HANDLE columns.

**Partly fixed**
1. **BUG-503 item 7:** the raw AutoCAD word on a locked layer is now the plain line in section 3. That is only the refresh part of a grouped entry. The entry stays open.

**New in code, no bug covers it**
1. **A table CE did not make is ignored in silence.** A drafter who picks the wrong table sees nothing.
2. **Older brace blocks are left out with no message** (hunt BRACE-05, 19 Oct; no bug number).
3. **ROTATION column ignores AutoCAD ROTATE** on a brace (hunt BRACE-02; no bug number).
4. **A blank brace type is written as A.**
5. **Rows can change order between refreshes,** because rows follow the order CE finds blocks in the drawing. A table you sorted by hand is re-sorted.
6. **Help hides it.** The command is marked "expert", so CEHELP does not list it until "Show advanced commands" is ticked. Its Help text only says "Refresh Schedule."

## 8. On AutoCAD 2022 to 2024

1. **Same code.** No version-specific lines were found in the schedule files; whether it behaves the same is not known.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`.

1. **1.1, 1.2:** `Commands\UtilityCommands.cs:68-90`; `Services\ScheduleService.cs:323-347`, `681-723`, `608-635`.
2. **1.3:** `ScheduleService.cs:686-690, 710-714, 617-621`.
3. **2.1:** `ScheduleService.cs:692-696, 716-720`.
4. **2.2:** `ScheduleService.cs:177-182, 688-689, 712-713`.
5. **2.3:** `ScheduleService.cs:629-634`.
6. **2.4:** `ScheduleService.cs:340, 661-667`.
7. **2.5:** `ScheduleService.cs:333`; `Services\ProjectDataService.cs:230-314`.
8. **3.1, 7 BUG-498:** `ScheduleService.cs:681-723` (no clearing step; compare `629-634`); the switch name `RefreshBlanksLeftoverRows` (carpark BUG-498) does not appear in `Models\` or `Services\`.
9. **3.2:** `ScheduleService.cs:692-696` (every row rewritten).
10. **3.3:** `UtilityCommands.cs:72`; `Services\DrawingSafetyService.cs:18-44` (line 38).
11. **3.4, 3.5, 7 BUG-503 item 7:** `UtilityCommands.cs:85-89`; `Services\StructuralPlainWords.cs:24-32`.
12. **3.6, 7 new 1:** `ScheduleService.cs:330-331` (returns with no line); `UtilityCommands.cs:83`.
13. **3.7:** `ProjectDataService.cs:266-308`.
14. **3.8, 7 new 2:** `ProjectDataService.cs:282-283`.
15. **3.9:** `ScheduleService.cs:512-537, 557-561`.
16. **3.10:** no check in `UtilityCommands.cs:68-90`.
17. **4.1, 4.2:** `UtilityCommands.cs:74-78`.
18. **5.1, 7 new 4:** `ProjectDataService.cs:316-320`.
19. **5.2:** `ScheduleService.cs:476-479, 716-720`.
20. **6.1, 6.2:** `ScheduleService.cs:323-346` (one transaction, committed at the end; dropped on an exception).
21. **7 BUG-503 item 1:** `ScheduleService.cs:399-403`.
22. **7 new 3:** `ProjectDataService.cs:322-326, 333`.
23. **7 new 5:** `ProjectDataService.cs:268-308`.
24. **7 new 6:** `Assets\Config\command-registry.json:1951-1967` (line 1965 `"expert": true`); `UI\Dialogs\CommandHelpWindow.xaml.cs:47, 71`; `Services\CommandRegistryService.cs:83-90`.
25. **8.1:** no `#if` in `ScheduleService.cs`, `UtilityCommands.cs`, `StructuralPlainWords.cs`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026, 02:58. Nothing was run in AutoCAD.
