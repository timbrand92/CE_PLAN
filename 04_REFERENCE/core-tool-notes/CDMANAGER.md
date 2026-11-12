# TOOL NOTE: Layer colours and draw order (CDMANAGER)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Opens a window with three tabs:** Draw Order, Layer Colours, Labels & Dimensions.
2. **Saves your draw-order list and colour choices** for CE layers, to use from now on.
3. **Apply Now** puts the draw order on this drawing straight away.

## 2. What it changes in the drawing

1. **Save buttons change only your Settings file,** not the drawing. Colours are used when CE next makes or updates a layer.
2. **Apply Now (Model, or All Layouts)** changes the drawing's draw order.
3. **Labels & Dimensions** opens the label style window or AutoCAD's DIMSTYLE.

## 3. What it will not do

1. **No start-up checks;** no locked-layer, Xref or REFEDIT check (draw order is not an object edit).
2. **Apply Now does nothing** in a drawing CE has not yet marked as a CE drawing, though it still says it applied.

## 4. What it asks you, and what Enter means

1. **No questions.** Enter does nothing (no default button). Close, Esc or X closes and **drops unsaved edits without asking**.

## 5. When it says Unknown or "needs checking"

1. **Not applicable.**

## 6. How to undo it

1. **Apply Now is not undone by U** (it writes with undo recording off).
2. **Saves are files;** change back and save again.

## 7. Known faults

**Already fixed in this build, not yet seen working in AutoCAD** (read from code; the window was not looked at)
1. **BUG-229:** the draw order list no longer shows layer names twice (names are merged and the file no longer appends defaults).

**New in code, no bug covers it**
1. **"Saved" when nothing was saved:** both save messages show even when the save was held back or failed.
2. **"Applied" when nothing changed:** in a drawing with no CE mark.
3. **Unsaved edits dropped** on Close with no question.
4. **Apply Now cannot be undone.**

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1:** `Commands\LayerManagerCommand.cs:12-31`; `Dialogs\LayerManagerDialog.xaml`.
2. **1.2, 2.1, 6.2:** `ViewModels\LayerManagerViewModel.cs:212-216, 293-326`; `Services\LayerService.cs:344-357, 874-880`; `Services\SettingsService.cs:600-628`.
3. **1.3, 2.2:** `LayerManagerViewModel.cs:204-210`; `LayerService.cs:958-1099`.
4. **2.3:** `Dialogs\LayerManagerDialog.xaml.cs:53-67`.
5. **3.1:** no `CommandPreFlight` in `LayerManagerCommand.cs`.
6. **3.2, 7 new 2:** `LayerService.cs:972-973`; `LayerManagerViewModel.cs:207-209`.
7. **4.1, 7 new 3:** `Dialogs\LayerManagerDialog.xaml:170`; `LayerManagerDialog.xaml.cs:71-75`.
8. **6.1, 7 new 4:** `LayerService.cs:1087`.
9. **7 BUG-229:** `LayerManagerViewModel.cs:99`; `LayerService.cs:1207-1238`; `SettingsService.cs:776, 788`.
10. **7 new 1:** `SettingsService.cs:613-614, 625-626`; `LayerManagerViewModel.cs:215, 320-325`.
11. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:06. Nothing was run in AutoCAD.
