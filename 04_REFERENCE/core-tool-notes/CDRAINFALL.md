# TOOL NOTE: Job rainfall curve (CDRAINFALL)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Opens "Job rainfall / IFD"** (tabs: Current rainfall, Import coefficients, Review change) to set this job's own rainfall curve, or go back to the office curve.
2. **You must preview the curve and tick "I have checked this rainfall"** before Save is offered.
3. **Prints the curve in use** at 10 years when the window closes.

## 2. What it changes in the drawing

1. **Before the window:** runs CE's whole-drawing record update (only if something changed since last time) and saves; Close afterwards does not take it back.
2. **Save:** stores the job's curve (location name, source, time, coefficients per return period) in CE's record and saves it at once.
3. **"Use office rainfall":** stores nothing, which clears the job curve.

## 3. What it will not do

1. **No start-up checks** (read-only, REFEDIT, Paper Space, drawing type).
2. **No Save until previewed and ticked.**

## 4. What it asks you, and what Enter means

1. **The window has no default button.** Close or Esc closes.
2. **No command-line questions.**

## 5. When it says Unknown or "needs checking"

1. **The 10-year line is printed even if nothing changed.**

## 6. How to undo it

1. **Inside one command,** so one U is expected for the saved curve. Not proven.

## 7. Known faults

**Still there in this build**
1. **BUG-1216:** Help opens at the previous command for CDRAINFALL (it is not in Help's list).

**New in code, no bug covers it**
1. **The office curve is fixed in code,** not in Settings.
2. **The record update runs before the window** although choosing a curve does not need it.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 4.1:** `Commands\RainfallCurveCommand.cs:41`; `Dialogs\RainfallWindow.xaml:29, 47, 78`; `Dialogs\RainfallWindow.xaml.cs:19-24`.
2. **1.2, 3.2:** `ViewModels\RainfallWindowViewModel.cs:44, 70-95`.
3. **1.3, 5.1:** `RainfallCurveCommand.cs:39, 57-58`.
4. **2.1, 7 new 2:** `RainfallCurveCommand.cs:52`; `Services\ProjectDataService.cs:595-693`.
5. **2.2, 2.3:** `Services\ProjectDataService.Rainfall.cs:62-82`; `Rules\RainfallCurveStorage.cs:31-49`.
6. **3.1:** no `CommandPreFlight` in `RainfallCurveCommand.cs`.
7. **7 BUG-1216:** `Services\CdHelpService.cs:40-53`.
8. **7 new 1:** `Rules\RainfallCurve.cs:152-171`.
9. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:08. Nothing was run in AutoCAD.
