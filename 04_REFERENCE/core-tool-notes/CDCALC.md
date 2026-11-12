# TOOL NOTE: Drainage calculations (CDCALC)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Opens the Calculations window:** Detention (Storage, Discharge, Drawing output), Older longitudinal, Profiles, Pipe Flows, Boyd's Method, Charged System, Older calculators - Pump System, Catchments, Older calculators - WSUD, Print.
2. **Keeps your workings with the drawing** (saved into CE's record when you close).
3. **Prints and exports** the computations package (PDF through Windows Print, or Excel).

## 2. What it changes in the drawing

1. **Opening changes nothing** (reads CE's record; no record update, no CE marker).
2. **Closing saves the whole calculation draft** into CE's record. Close, Esc and X all save; there is no "close without saving". With nothing changed, nothing is written ("Nothing changed in the calculations, so nothing was written to the drawing.").
3. **Insert Criteria Block** (Detention tab) places the OSD criteria block at a point you pick.
4. **Older longitudinal** Export and Update write long sections; **Profiles** Apply writes through CDPROFILE.

## 3. What it will not do

1. **No start-up checks** (runs in any drawing, including Structural).
2. **A stored draft that cannot be restored stops it opening;** you see only "Error during CDCALC - see CE log".
3. **If the close save is refused** (drawing no longer active, or the council changed while open) the window will not close.
4. **Criteria block missing:** "Criteria block file not found."

## 4. What it asks you, and what Enter means

1. **No command-line questions;** no default button. Close is Esc.
2. **"Place OSD Criteria block"** (Insert Criteria Block): Esc places nothing.
3. **Export:** "Preview package" first; PDF opens Windows Print (you choose the printer); Excel opens a Save window.

## 5. When it says Unknown or "needs checking"

1. **Boyd's starts blank** (switch on) with a "nothing worked out" warning; Boyd's outputs show zeros, not Unknown. **Catchments starts empty** with the line "Add a catchment to begin." (no warning).
2. **Last-storm warning** on Boyd's when the worst storm is the last row.

## 6. How to undo it

1. **The close save, criteria block and section writes** are inside the one CDCALC command. Not proven in AutoCAD.
2. **Not undone by U:** exported files.

## 7. Known faults

**Still there in this build**
1. **BUG-003:** no CDCALC button calls the orifice pit detail writer (not found).
2. **BUG-249:** Boyd's intensity rows are fixed numbers, not the job's curve.
3. **BUG-1033:** the Pump System tab has only a tooltip, no read-only banner.
4. **BUG-1103:** Charged System sizes are in metres with no sense check.

**Partly fixed**
1. **BUG-507:** Boyd's starts blank with a warning; outputs are zeros, not Unknown.
2. **BUG-539, 543, 544:** several values now come from Settings or the council; the rational C 0.9 remains. CDCALC's window has no Orifice tab: the 0.61 start and its own 9.81 sit in an older orifice calculator that nothing opens now. The older orifice sizer's fixed 9.8 is still in the code (the ruled 9.81 is used when the Settings switch is on, the default); that split is between the sizer and CDCALC's detention tab, not inside CDCALC.
3. **BUG-758:** the older section writer now checks levels; the tab is still shown by default.
4. **BUG-1089:** Pipe Flows warns at a fixed 3.0 m/s high limit unless the material-limit switch is on (off); only the high limit follows the switch. The low-speed warning is always fixed at 0.5 m/s.
5. **BUG-1112:** WSUD still opens with a sample site; the export skips it until typed.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-1030:** closing with nothing changed writes nothing.
2. **BUG-158, 233, 515, 772, 905, 980, 997, 1019, 1036, 1097, 1101:** each has a change in this build (see the sources).

**Reported, could not confirm in code**
1. **BUG-517:** the printed sheet's look; it is visual.

**New in code, no bug covers it**
1. **No way to leave without saving,** and a refused save traps you in the window.
2. **Runs in Structural drawings** with no question.
3. **Sample figures** in Charged System and WSUD.

## 8. On AutoCAD 2022 to 2024

1. **Same as far as checked:** no version differences in the command, the window or the main tab files. Not every tab was traced to the end.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 4.1:** `Commands\CalculationsCommand.cs:15, 85`; `Dialogs\CalculationsV2Dialog.xaml:95-1339`.
2. **1.2, 2.2, 7 BUG-1030:** `Dialogs\CalculationsV2Dialog.xaml.cs:136-146`; `Services\CalculationWorkspacePersistenceService.cs:59-116`; `ViewModels\CalculationsV2ViewModel.cs:523-545`; `CalculationsCommand.cs:71-84`; `Services\CalculationDraftUnchangedGate.cs:25-30`.
3. **1.3, 4.3:** `CalculationsV2ViewModel.cs:501, 809-874`; `Services\CalculationExportPackage.cs:88-96`.
4. **2.1, 3.1:** `Services\ProjectDataService.Persistence.cs:140-143`; `Services\ProjectDataService.Mutations.cs:1238-1255`; no `CommandPreFlight` in `CalculationsCommand.cs`.
5. **2.3, 3.4, 4.2:** `Services\OnSiteDetentionCriteriaService.cs:51-98`.
6. **2.4:** `CalculationsV2Dialog.xaml.cs:346-366`; `Services\LongitudinalSectionService.cs:413-416, 467-470`.
7. **3.2:** `CalculationsCommand.cs:63-69, 95`. **3.3:** `CalculationsV2Dialog.xaml.cs:65-92, 136-146`.
8. **5.1, 7 BUG-507:** `ViewModels\BoydsCalcViewModel.cs:208-222`; Catchments empty line `ViewModels\RationalMethodViewModel.cs:163-167, 307-311`; `Models\UserSettings.cs:3250, 3288`. **5.2:** `BoydsCalcViewModel.cs:281`.
9. **7 still there:** BUG-003 `Services\OrificePitDetailDwgWriter.cs` (no caller found); BUG-249 `BoydsCalcViewModel.cs:119-124`; BUG-1033 `CalculationsV2Dialog.xaml:780`; BUG-1103 `CalculationsV2Dialog.xaml:726, 734`.
10. **7 partly:** BUG-543 `ViewModels\DetentionSystemViewModel.cs:19-30`, `Services\Hydraulics.cs:33` (9.8), `Services\OrificeBasis.cs:7-21` (9.81 switch), `ViewModels\OrificeCalcViewModel.cs:18-19` (0.61 and 9.81, used only by `Dialogs\CalculationsDialog.xaml`, which nothing opens; `CalculationsCommand.cs:58` opens `CalculationsV2Dialog`); BUG-544 `ViewModels\RationalMethodViewModel.cs:417`; BUG-758 `UserSettings.cs:1226`, `CalculationsV2Dialog.xaml.cs:76-85`; BUG-1089 `ViewModels\PipeFlowCalcViewModel.cs:308-311` (0.5 fixed; high limit from the switch at 310), `Models\PipeSpeedChecksSettings.cs:17`; BUG-1112 `ViewModels\WsudViewModel.cs:19-21`, `CalculationExportPackage.cs:510`.
11. **7 fixed:** BUG-158 `CalculationExportPackage.cs:88-96, 380-391`; BUG-233 `Rules\CouncilSourceWords.cs`; BUG-515 `BoydsCalcViewModel.cs:281`; BUG-772 `WsudViewModel.cs:183`; BUG-905 `BoydsCalcViewModel.cs:236-242`; BUG-980 `PipeFlowCalcViewModel.cs:170, 211-218`; BUG-997 `LongitudinalSectionService.cs:503-530`; BUG-1019 `DetentionSystemViewModel.cs:633, 749-755, 861-883`; BUG-1036 `CalculationsV2Dialog.xaml:586-590`; BUG-1097 `ViewModels\ChargedSystemCalcViewModel.cs:229-262`; BUG-1101 `CalculationsV2ViewModel.cs:387`.
12. **7 new 3:** `ChargedSystemCalcViewModel.cs:24-31`; `WsudViewModel.cs:19-21`.
13. **8.1:** no `#if` in `CalculationsCommand.cs`, `Dialogs\CalculationsV2Dialog.xaml.cs`, `ViewModels\CalculationsV2ViewModel.cs`, `BoydsCalcViewModel.cs`, `DetentionSystemViewModel.cs` or `PipeFlowCalcViewModel.cs`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 02:33; corrected after independent review. Nothing was run in AutoCAD.
