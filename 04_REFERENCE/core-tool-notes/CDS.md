# TOOL NOTE: Civil Settings (CDS)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Opens the Civil Settings window,** where your drafting and engineering values live, with a search box.
2. **Save keeps only the values you changed;** Cancel throws your changes away.
3. **Opens on the Drafting page** every time.

## 2. What it changes in the drawing

1. **Nothing in the drawing.**
2. **Save writes your Settings files on this PC:** the main settings file, a recent-values file beside it, and a history file of what changed. With nothing changed, Save writes nothing.
3. **Cancel writes nothing.**

## 3. What it will not do

1. **Refuses a value outside its allowed range** when you press Save, and the window stays open.
2. **No start-up checks** (it opens in any drawing; it does not touch the drawing).

## 4. What it asks you, and what Enter means

1. **Enter = Save.** In the search box, Enter jumps to the top match instead.
2. **Esc = Cancel.** In the search box with text in it, Esc only clears the search.
3. **The window's X** closes without asking and without saving.
4. **Unsaved changes and the OSNAP button:** "Apply or discard ..." [Yes/No/Cancel].

## 5. When it says Unknown or "needs checking"

1. **Write failed:** an error box, and the window stays open.
2. **Older starting values moved:** a command-line warning when CE moves an old velocity or label height (see 7).

## 6. How to undo it

1. **U does not undo Settings.** Change the value back and Save, or use the history file.

## 7. Known faults

**Still there in this build**
1. **BUG-958:** "remember window position" does not work for this window (and Edit Pipe, Edit Pit, New Pit): the window is placed by hand-set rules that the remember step skips.

**Partly fixed**
1. **BUG-825:** a maximum velocity of 3.0 m/s or less, and joint label heights under 200, are moved to 6.0 and 250 only once per file, with a warning. An old file that is never saved again may move and warn at every start (not proven).
2. **BUG-227:** the ribbon tooltip now names six pages; the window has eight.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-957:** search jumps to the top match.

**New in code, no bug covers it**
1. **The ribbon says "Open Settings on the last page you used",** but it always opens on Drafting.
2. **Reset buttons hold a second copy** of the default values (they match today).

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1 to 1.3:** `Commands\CdCommand.cs:1558-1566`; `Dialogs\AdvancedSettingsDialog.xaml.cs:57-101`.
2. **2.2, 2.3:** `ViewModels\AdvancedSettingsViewModel.cs:1066-1079`, `1413-1454`, `1659-1796`; `Services\SettingsService.cs:51-56, 635-674, 724`; `Services\SettingsService.RememberedValues.cs:66-76`; `Services\SettingsHistoryService.cs:26-35`.
3. **3.1, 5.1:** `AdvancedSettingsViewModel.cs:1138-1142`, `1468-1658`.
4. **3.2:** no `CommandPreFlight` or record call in `CdCommand.cs:1558-1566`.
5. **4.1, 4.2:** `Dialogs\AdvancedSettingsDialog.xaml:1495-1498`; `AdvancedSettingsDialog.xaml.cs:57-92`.
6. **4.4:** `AdvancedSettingsViewModel.cs:1252-1266, 1292-1297`.
7. **5.2, 7 BUG-825:** `SettingsService.cs:108-114, 171-226, 341`; `Models\UserSettings.cs:2058`.
8. **7 BUG-958:** `Services\WindowSizingService.cs:175`; `AdvancedSettingsDialog.xaml.cs:83, 102`; `Services\CeWindowPlacementHook.cs:49, 101`; `UserSettings.cs:3706`.
9. **7 BUG-227:** `Services\CeCvlRibbonContributor.cs:164-165`; `AdvancedSettingsDialog.xaml.cs:19-20`.
10. **7 new 1:** `CeCvlRibbonContributor.cs:163`. **7 new 2:** `AdvancedSettingsViewModel.cs:1177-1205`.
11. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:03. Nothing was run in AutoCAD.
