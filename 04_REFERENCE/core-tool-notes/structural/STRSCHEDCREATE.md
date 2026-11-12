# TOOL NOTE: Create schedules (STRSCHEDCREATE)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Draws three schedule tables in Model space,** one under the other, at one point you click: Bracing Schedule, Bored Pier Schedule and Tie-Down Schedule.
2. **Lists what is already drawn:** one row per brace, per bored pier and per kind of tie-down. It reads the blocks named BRACING, 450DIABPV2, CE_BORED_PIER_ (a number after it) and the tie-down block.
3. **Table text follows the office text height:** the Settings plot height times the drawing scale (DIMSCALE, or the annotation scale when DIMSCALE is 1 or 0), worked out for millimetre or metre drawings.
4. **Bracing columns:** TYPE, LENGTH, ROTATION, LAYER, HANDLE. **Bored pier columns:** MARK, DIA MM, VISIBILITY, LAYER, HANDLE. **Tie-down columns:** TYPE and QTY.

## 2. What it changes in the drawing

1. **Three new tables in Model space,** on whatever layer is current (CE sets no layer), in the drawing's current table style.
2. **A hidden record inside each table** of which drawing object each row came from. SYNC and REFRESH read it later.
3. **CE's working list of braces, piers and tie-downs is re-read.** No write to the drawing was found on that step.
4. **With the Settings switch "update existing on rerun" ON** (it ships OFF): tables already on the drawing are refreshed in place and only the missing ones are placed.
5. **It does not save the drawing.**

## 3. What it will not do

1. **Refuses a read-only drawing** with one line, before anything is asked.
2. **Does not check for a layout tab or REFEDIT.** It still puts the tables in Model space (see section 7).
3. **Does not look for tables already on the drawing** unless the switch above is on. Run it twice and you get six tables, the older three going out of date.
4. **Does not list older brace blocks** named like "A - BRACING LEFT". Only the block named BRACING is read.
5. **Does not convert length to millimetres.** The LENGTH column prints the block's value as it is, two decimals, no unit.
6. **Locked current layer, Xref, REFEDIT:** not checked on this path. What happens is not known.
7. **The two schedule switches have no box on CESETTINGS.** They can be changed only by editing the settings file.

## 4. What it asks you, and what Enter means

1. **"Select insertion point for schedules: "** A plain point prompt. Esc ends the command, nothing placed, nothing printed. What a bare Enter does is not known (the code does not offer it as an answer).
2. **No other question.** With the switch OFF there is no confirmation line after the tables are placed.
3. **With the switch ON and all three tables already there:** no point is asked. It refreshes them and prints "Schedules already on this drawing: N updated in place. No new tables were placed."
4. **With the switch ON and some missing:** it asks for the point, refreshes the old ones, places the rest and prints "Schedules: N already on this drawing updated in place, M placed new."

## 5. When it says Unknown or "needs checking"

1. **It never says Unknown.** A brace whose type is blank is listed as type A (a guess shown as a fact).
2. **A bored pier with no mark or diameter** (the older pier block) shows a blank cell, not 0.
3. **An older brace block** is left out with no word at all.

## 6. How to undo it

1. **U once should remove the tables** (placing and, with the switch on, refreshing happen in the one command). Not proven in AutoCAD.
2. **Delete the tables by hand** if you ran it twice.

## 7. Known faults

**Still open**
1. **BUG-497 (HIGH):** every table is one row too short. The code sizes each table items plus one row, but a table needs a title row, a heading row, then one row per item. With one or more items the last row is probably written past the end of the table. The fix exists only on an unmerged branch; the installed code has no trace of it. Not seen in AutoCAD.
2. **BUG-503 item 1:** the bracing table prints LAYER and HANDLE (AutoCAD's internal number); a new pier table prints them too unless the pier switch is on (it ships off).
3. **BUG-498:** a refresh never clears rows left over from erased braces or piers. It reaches this tool only when the switch is on (see STRSCHEDREFRESH).

**New in code, no bug covers it**
1. **On a layout tab or during REFEDIT** the tables still go into Model space at the point you clicked on the sheet. Other Structural commands stop with a plain line; this one does not. (Also in hunt note 19 Oct, item 9; no bug number.)
2. **In a rotated UCS** the table is placed at your click read as World coordinates, so it lands somewhere other than where you clicked. Not seen; read from the code.
3. **Run twice, get six tables** with the switch OFF, the first three left out of date. The switch is "off until Tim says".
4. **The tables sit on whatever layer is current.** CE puts them on no layer of its own.
5. **Older brace blocks are not counted** and no message says so (hunt BRACE-05, 19 Oct; no bug number).
6. **ROTATION column ignores AutoCAD ROTATE:** it shows the block's own rotation setting, and the block rotation only when that setting is exactly 0 (hunt BRACE-02; no bug number).
7. **A blank brace type is listed as A.**
8. **No Settings box** for the two schedule switches (the Settings-first rule).
9. **Help says nothing useful:** its "In AutoCAD" steps read "Command-specific utility prompts" and its description is "Create Schedule."

## 8. On AutoCAD 2022 to 2024

1. **Same code.** No version-specific lines were found in the schedule files, and the 2022 to 2024 build compiles the same source. Whether tables behave the same there is not known.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`.

1. **1.1:** `Services\ScheduleService.cs:184-258` (placing), `229-245`, `Core\ScheduleSetPlan.cs:30-35`.
2. **1.2:** `Services\ProjectDataService.cs:276-307` (blocks read); `ScheduleService.cs:405-414, 458-470`; `Services\TieDownService.cs` (rows, not re-read).
3. **1.3:** `ScheduleService.cs:35-82, 135-145, 223`.
4. **1.4:** `ScheduleService.cs:399-403, 449-456, 591-593`.
5. **2.1:** `ScheduleService.cs:247-248, 382-474` (no layer set), `385-388, 425-428` (table style).
6. **2.2:** `ScheduleService.cs:249, 792-810`; `RecordPierRowLinks` `661-667`.
7. **2.3:** `ScheduleService.cs:195`; `ProjectDataService.cs:230-314` (no write call inside).
8. **2.4:** `ScheduleService.cs:198-208, 213-214, 256-257`; `Models\UserSettings.cs:2134-2136`.
9. **3.1:** `ScheduleService.cs:193`; `Services\DrawingSafetyService.cs:18-44` (line 38 is the read-only line).
10. **3.2, 7 new 1:** `ScheduleService.cs:193, 210-221` uses `CommandPreFlight`, not `CommandPreFlightModelSpace` (`DrawingSafetyService.cs:62-67`). Carpark `BUG-472` evidence note names it as not checked.
11. **3.3, 7 new 3:** `ScheduleSetPlan.cs:34-35`; `UserSettings.cs:2136`.
12. **3.4, 7 new 5:** `ProjectDataService.cs:282-283`.
13. **3.5:** `ScheduleService.cs:409`; `ProjectDataService.cs:322`.
14. **3.6:** no check in `ScheduleService.cs:216-254`.
15. **3.7, 7 new 8:** `UserSettings.cs:2136, 2141` against `UI\Dialogs\CeSettingsDialog.xaml.cs` (no ScheduleSet name in the file).
16. **4.1:** `ScheduleService.cs:210-211`.
17. **4.2-4.4:** `ScheduleService.cs:202-208, 256-257`; `ScheduleSetPlan.cs:46-47`.
18. **5.1, 7 new 7:** `ProjectDataService.cs:316-320`.
19. **5.2:** `ScheduleService.cs:461-462, 476-479`.
20. **6.1:** `ScheduleService.cs:216-254` (one transaction, one command).
21. **7 BUG-497:** `ScheduleService.cs:384, 422, 572`; the switch name `ScheduleTablesHaveTitleAndHeadingRows` (carpark BUG-497) does not appear anywhere in `Models\` or `Services\`.
22. **7 BUG-503 item 1:** `ScheduleService.cs:399-403, 449-456`; `UserSettings.cs:2141`.
23. **7 BUG-498:** `ScheduleService.cs:681-723` (see the STRSCHEDREFRESH note).
24. **7 new 2:** `ScheduleService.cs:210, 221, 228` (no UCS conversion in the file).
25. **7 new 4:** `ScheduleService.cs:382-474`.
26. **7 new 6:** `ProjectDataService.cs:322-326`.
27. **7 new 9:** `Assets\Config\command-registry.json:1939-1944`.
28. **8.1:** no `#if` in `ScheduleService.cs`, `UtilityCommands.cs`, `ScheduleSetPlan.cs`; `CE_STRUC_SUITE.csproj:27` (net48 builds the same files); `ScheduleService.cs:159-165`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026, 02:55. Nothing was run in AutoCAD.
