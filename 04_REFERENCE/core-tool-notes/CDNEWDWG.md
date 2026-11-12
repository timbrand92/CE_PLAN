# TOOL NOTE: New job drawing (CDNEWDWG)

**Core since:** not yet (typed only; no ribbon button today)
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Makes a new job drawing** by copying the office template into the job folder and opening it.
2. **Fills the title block fields** (reference number, client, project address, suburb) from the job's record, as drawing properties.
3. **AutoCAD 2027 only.**

## 2. What it changes in the drawing

1. **Copies the template file** into the job folder (a new file on disk).
2. **Opens the copy** and writes the title block fields into its drawing properties.
3. **Does not save the new drawing:** "CE has not saved this drawing - save it when you are ready."
4. **The drawing you were in is not changed.**

## 3. What it will not do

1. **Template missing:** "Template ... could not be found - it may have moved. Check Settings > Office templates folder and try again."
2. **File already exists:** "... already exists in that job folder - nothing was overwritten."
3. **No job record:** says the title block is left blank.
4. **Discipline:** Civil only in the list. Sheet sizes A1 to A4, A3 by default.

## 4. What it asks you, and what Enter means

1. **New job drawing window:** Enter and Esc do nothing (no default or cancel button). "Create and open" is enabled only when everything is valid. Cancel or X ends with nothing written.
2. **Name clash:** a warning box before closing.
3. **The job folder** is guessed from the open drawing; the job record is re-read whenever you change the folder.

## 5. When it says Unknown or "needs checking"

1. **Job record unreadable:** shown blank and read again later.

## 6. How to undo it

1. **U does not remove the copied file.** Delete it in Windows if not wanted.

## 7. Known faults

**Still there in this build**
1. **BUG-1166 (also lists CDNEWDWG):** the default templates folder is looked for only under your user folder.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-969:** the window re-reads the job record for the folder now in the box.

**New in code, no bug covers it**
1. **The command opens another drawing** while set up as an ordinary drawing command; whether this behaves in every case is not proven.

## 8. On AutoCAD 2022 to 2024

1. **Not available.** The command does not exist below the AutoCAD 2027 build; typing it gives "Unknown command" (also on 2025 and 2026).

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 2.1, 2.2:** `Commands\NewJobDrawingCommand.cs:40-120` (copy 94-95, open 97, properties 99-102); `Shared\CE_SHARED\Services\CeDwgPropsCustomProperties.cs:25-53` (repo root).
2. **1.3, 8.1:** `NewJobDrawingCommand.cs:1, 148` (`#if NET10_0_OR_GREATER`); `Dialogs\NewJobDrawingDialog.xaml.cs:1`; `Assets\Config\command-registry.json:1175-1182`.
3. **2.3:** `NewJobDrawingCommand.cs:116-118`.
4. **3.1 to 3.3:** `NewJobDrawingCommand.cs:80-82, 89-90, 109-112`.
5. **3.4:** `NewJobDrawingDialog.xaml.cs:67, 70-71`.
6. **4.1, 4.2:** `Dialogs\NewJobDrawingDialog.xaml:82-87`; `NewJobDrawingDialog.xaml.cs:174-175, 195-204`; `NewJobDrawingCommand.cs:61-62`.
7. **4.3, 5.1, 7 BUG-969:** `NewJobDrawingCommand.cs:51, 128-145`; `NewJobDrawingDialog.xaml.cs:62, 122`; `Rules\NewJobDrawingRecordSource.cs`.
8. **7 BUG-1166:** `Models\UserSettings.cs:2183-2197`.
9. **7 new 1:** `NewJobDrawingCommand.cs:40` (Modal), `97`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:06. Nothing was run in AutoCAD.
