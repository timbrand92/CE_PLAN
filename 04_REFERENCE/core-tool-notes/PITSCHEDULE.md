# TOOL NOTE: Pit Schedule (PITSCHEDULE)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Opens the Pit Schedule window** (tabs: Source, Rows, Changes, Placement) listing the drawing's scheduled pits, from this drawing or from drainage Xrefs.
2. **Lets you edit cells,** reorder rows, then place a new schedule table or update a placed one.
3. **Exports** the rows to CSV or Excel.

## 2. What it changes in the drawing

1. **Opening is meant to change nothing,** but one write remains: when a drawn pipe's size differs from the record, building the rows copies the drawn size into CE's record.
2. **Cell edits** write level text and CHECK markers into the drawing; a typed pit size resizes the pit; a typed pit number renames the pit (with a warning line if it looks like another pit's number).
3. **Place (new):** saves the row order and the record first, then asks for the point; then gives older pits and pipes their CE identity, makes layer SCHEDULE (colour 7) and a layer per column, and inserts the table.
4. **Place (existing):** updates the placed schedule; it says "One Ctrl+Z undoes it."
5. **"Relink and recalculate" button:** runs CE's forced whole-drawing record update and relinks pipes to pits (only when you click it).
6. **Close button** writes your Settings file (window choices). The window's X does not.

## 3. What it will not do

1. **REFEDIT open:** "PITSCHEDULE cannot run while a reference is being edited in place (REFEDIT). Finish or close it (REFCLOSE) first. Nothing was changed." If AutoCAD cannot say, it opens anyway.
2. **Read-only drawing:** opens to view only: "This drawing is read-only, so the schedule can be viewed but not changed."
3. **No Paper Space or drawing-type check.**
4. **Plastic pits, and pits with "include in schedule" off, are left out with no message.**
5. **Update of a placed schedule:** refuses a missing or locked column layer ("Schedule layer X is missing or locked."). For a new table no lock check was found.
6. **Two Xref drawings both with a pit "P1":** the combined schedule comes up empty, and the window's status line names the clash ("Cannot combine sources: Pit P1 appears in ... Rename it in a source drawing."); placement is blocked.

## 4. What it asks you, and what Enter means

1. **The window has no default button.** Enter on a row zooms to that pit. Close or X closes.
2. **"Specify schedule insertion point"** (Place, new): Enter is not accepted. Esc places nothing but the row order is already saved.
3. **Export Excel:** a Save window opens first; if Excel cannot start: "Excel export could not start on this AutoCAD. Use Export CSV, it saves the same rows."

## 5. When it says Unknown or "needs checking"

1. **Blank pipe size** shows blank in the cells; "?" appears only in the picked pipe's description line.
2. **Shallow pits** are judged from a Settings depth (300 mm by default).
3. **A pit with no number** shows CE's internal code, never blank (the record update gives it one).

## 6. How to undo it

1. **U once** for what the window did in one PITSCHEDULE command.
2. **Not undone by U:** CSV and Excel files, and the Settings written by Close.

## 7. Known faults

**Still there in this build**
1. **BUG-1274:** plastic and "not in schedule" pits drop out silently.
2. **BUG-787:** typed pit-level cells are keyed to the whole row and slide when an inlet is added.
3. **BUG-1023:** the saved row order is thrown away if less than 90% of rows have a saved place (with under 10 rows, one new pit resets it).
4. **BUG-1044:** a pit number repeated across Xref drawings empties the combined schedule.

**Partly fixed**
1. **BUG-457, BUG-817:** the close and command-end record writes are fixed, but opening can still write a drawn pipe size into the record (see 2.1).
2. **BUG-799:** Xref paths now resolve against the host drawing; "SOURCE MISSING" is still tested before "SOURCE UNLOADED".

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-1255:** Excel export uses AutoCAD's own Excel library when loaded (switch on), with a plain fallback line.
2. **BUG-1198:** a cancelled export saves nothing (switch on).
3. **BUG-458:** refuses during REFEDIT. **BUG-464:** read-only drawing opens view-only.
4. **BUG-780, 786, 791, 965, 981, 1008, 1009, 1011, 1022, 1031, 1035, 1197:** each has a change in this build (see the sources).

**New in code, no bug covers it**
1. **CSV export has no guard** if the file is open in Excel (expect an error line; not proven).
2. **Placing colours the SCHEDULE layer 7.**

## 8. On AutoCAD 2022 to 2024 (Excel)

1. **Excel export is not left out of any build.** The Excel writer is part of every build with no condition, and the Export Excel button has no older-AutoCAD exclusion. Only the helper that loads AutoCAD's own copy of the Excel library is version-specific (2025 and later). Whether Export Excel works on 2022 to 2024 has not been tried; CSV saves the same rows.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1:** `Commands\PitScheduleCommand.cs:18-49`; `Dialogs\PitScheduleDialog.xaml:144, 386, 1030, 1137`.
2. **2.1, 7 BUG-457/817:** `Services\PitScheduleBuilder.cs:1085-1089`; `Services\ProjectDataService.Mutations.cs:1661-1679`; `ViewModels\PitScheduleViewModel.Data.cs:363`; close fix `Dialogs\PitScheduleDialog.xaml.cs:159-164`, `Services\LinkService.cs:68-69`.
3. **2.2:** `PitScheduleCommand.cs:27`; `PitScheduleViewModel.Data.cs:1745-1756` (the pit-number cell renames the pit).
4. **2.3, 4.2:** `ViewModels\PitScheduleViewModel.Schedule.cs:816-878`, `892-936`, `1267-1270`.
5. **2.4:** `PitScheduleViewModel.Schedule.cs:799-811`.
6. **2.5:** `PitScheduleViewModel.Data.cs:996-999`.
7. **2.6, 6.2:** `ViewModels\PitScheduleViewModel.cs:313-318`; `ViewModels\PitScheduleViewModel.Filters.cs:246`.
8. **3.1, 7 BUG-458:** `PitScheduleCommand.cs:30-40`; `Services\DrawingSafetyService.cs:51-59`.
9. **3.2, 7 BUG-464:** `PitScheduleViewModel.cs:352, 401-421`.
10. **3.3:** no `CommandPreFlight` in `PitScheduleCommand.cs`.
11. **3.4, 7 BUG-1274:** `PitScheduleViewModel.Data.cs:851-859`.
12. **3.5:** `PitScheduleViewModel.Schedule.cs:1515-1517`.
13. **3.6, 7 BUG-1044:** `PitScheduleViewModel.Data.cs:652-665` (status line at 663).
14. **4.1:** `Dialogs\PitScheduleDialog.xaml.cs:262-267`; no IsDefault or IsCancel in `PitScheduleDialog.xaml`.
15. **4.3, 7 BUG-1255:** `PitScheduleViewModel.Schedule.cs:126-147`; `PluginInitialization.cs:61-63`; `Models\UserSettings.cs:3643-3644`.
16. **5.1:** `PitScheduleBuilder.cs:1102-1104`; `PitScheduleViewModel.cs:1353, 1511`. **5.2:** `UserSettings.cs:1187`. **5.3:** `Services\ProjectDataService.Mutations.cs:2005-2006`.
17. **6.1:** `PitScheduleCommand.cs:45-49`.
18. **7 BUG-787:** `PitScheduleViewModel.Schedule.cs:564-571, 686-696`. **BUG-1023:** `PitScheduleViewModel.Data.cs:907-911`. **BUG-799:** `Services\PitScheduleXrefDiscoveryCore.cs:222-240`; `Services\PitScheduleStatusService.cs:162, 171`.
19. **7 BUG-1198:** `PitScheduleViewModel.Schedule.cs:48-53, 113-117`.
20. **7 fixed list:** BUG-780 `PitScheduleBuilder.cs:282-332`; BUG-786 `PitScheduleViewModel.Data.cs:936-946`; BUG-791 `PitScheduleDialog.xaml.cs:225-243`; BUG-965 `Services\ScheduleLinkService.cs:2625-2638`, `UserSettings.cs:1161-1167`; BUG-981 `PitScheduleViewModel.Schedule.cs:470-476`; BUG-1008 `PitScheduleDialog.xaml.cs:380-383`; BUG-1009 `PitScheduleDialog.xaml.cs:268-277`; BUG-1011 `PitScheduleViewModel.Data.cs:1275-1280`; BUG-1022 `Services\ProjectDataService.cs:484-487`; BUG-1031 `PitScheduleDialog.xaml:529-535`; BUG-1035 `PitScheduleViewModel.cs:39-40`; BUG-1197 `PitScheduleViewModel.Schedule.cs:1522-1579`.
21. **7 new 1:** `PitScheduleViewModel.Schedule.cs:72-75`. **7 new 2:** `PitScheduleViewModel.Schedule.cs:828`.
22. **8.1:** `CE_CVL_SUITE.csproj:194` (ClosedXML referenced with no condition); `ViewModels\PitScheduleViewModel.Schedule.cs:110-151` (button, no version check); `Shared\ExcelBinding\ExcelLibraryBinding.cs:6, 17, 80, 94` (repo root path; `#if NET` is only the loader for AutoCAD's own copy).

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 02:33; corrected after independent review. Nothing was run in AutoCAD.
