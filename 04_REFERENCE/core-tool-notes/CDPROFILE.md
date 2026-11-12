# TOOL NOTE: Long section (CDPROFILE)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Builds a long section** from a starting pit you pick, along a route you choose, in the Profiles window.
2. **Preview first** (a new section at a point, or update a linked section), then **Apply** draws it.
3. **Apply is refused** unless the preview is complete and Ready: "Only a complete Ready profile review can be applied."

## 2. What it changes in the drawing

1. **Opening and previewing change nothing.** It reads a copy of CE's record.
2. **Apply** draws the section block with its information stored on it, and a pit marker block if missing, in one step, on layers 25CONT, 35CONT, 70CONT, the pipe text layer, 35TEXT, 50TEXT, BLOCKS and BOUNDARY.
3. **Missing layers are made** only if their line type already exists.
4. **No whole-drawing record update.**

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **At Apply:** "Finish or cancel REFEDIT before applying the profile." (or "CE could not prove that REFEDIT is inactive."); "Profile layer X is missing, external or locked."; "The profile requires the existing X linetype."; "The accepted profile target is protected by a locked layer or external content."; "The accepted profile belongs to a different active drawing."
3. **A datum above the lowest invert less the sump** is refused (no rounded value offered).
4. **The preview will not start until you choose a route,** even when there is only one.

## 4. What it asks you, and what Enter means

1. **"Select starting CE pit for profile review"** (skipped if one pit is already selected): a wrong pick says "Select a CE pit block." Enter or Esc ends with nothing changed.
2. **Profiles window:** buttons Choose Pit, Refresh, Preview New, Preview Update, Apply, and Close (Esc). No default button. Closing writes nothing.
3. **Preview New: "Specify final insertion point for profile Preview":** Enter not accepted.
4. **Preview Update: "Select linked CE profile to update".**
5. **Window starting values:** horizontal scale 100, vertical 10 (fixed), datum blank, route not chosen, schedule set from the route's pits.

## 5. When it says Unknown or "needs checking"

1. **A preview that is not complete and Ready** blocks Apply, with its reason.
2. **Survey levels thrown away** (further than the Settings tolerances from the cover line) are warned in one line.

## 6. How to undo it

1. **U once per Apply.** It says "Profile applied. One AutoCAD Undo removes this change."

## 7. Known faults

**Still there in this build**
1. **BUG-765:** any plain number in an Xref can become a surface level on the section.
2. **BUG-1193:** a curved property boundary is treated as straight lines between its points.
3. **BUG-1020:** pit depth uses only the route's lowest invert and Xref existing pipes, not side branches or the pit floor; INVERT DEPTH prints only with the office layout switch on (off by default).
4. **BUG-1154:** the section's information is stored as one long text value.

**Partly fixed**
1. **BUG-759:** CDPROFILE refuses a datum too high; the older CDCALC section tab has no such check.
2. **BUG-1192:** a warning for thrown-away survey levels exists; the ground line still runs through the covers, and the search distances are fixed.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-756, 760, 761, 762, 763, 764, 766, 767, 768, 769, 1012:** each has a change in this build (see the sources).

**New in code, no bug covers it**
1. **Route never chosen for you,** even with one route.
2. **Fixed numbers not in Settings:** pit sump 0.30 m, existing-pipe stub 1.20 m, survey search distances and counts, scales 100 and 10.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 4.1, 4.2:** `Commands\ProfileCommands.cs:39-95`; `Dialogs\CalculationsV2Dialog.xaml.cs:102-110, 276`; `Dialogs\CalculationsV2Dialog.xaml:443-444, 538-540, 1339`; `Services\CalculationDraftCloseGuard.cs:9-13`.
2. **1.2, 1.3, 5.1:** `ViewModels\ProfileRouteReviewViewModel.cs` (`CompleteApply`); `Services\LongitudinalSectionService.cs:835-842`.
3. **2.1, 2.4:** `Services\ProfileRouteEvidenceCaptureService.cs:24, 33, 183`; no record update call on this path.
4. **2.2, 6.1:** `ProfileRouteEvidenceCaptureService.cs:135-152`; `LongitudinalSectionService.cs:314-321, 391-398, 2539, 3408`.
5. **2.3, 3.2:** `LongitudinalSectionService.cs:2429, 2436-2444, 2481-2498, 2568`.
6. **3.1:** `ProfileCommands.cs:46`; `Services\DrawingSafetyService.cs:61-131`.
7. **3.3, 7 BUG-759:** `Services\ProfileRouteReviewService.cs:97-115`.
8. **3.4, 7 new 1:** `ProfileRouteReviewViewModel.cs:242`.
9. **4.3, 4.4:** `CalculationsV2Dialog.xaml.cs:310, 321-322, 368-380`.
10. **4.5, 7 new 2:** `ProfileRouteReviewViewModel.cs:82-84, 143-149`; `LongitudinalSectionService.cs:340, 361`; `ViewModels\LongitudinalSectionViewModel.cs:1632, 1676-1678, 1718, 1782-1784`.
11. **5.2, 7 BUG-1192:** `LongitudinalSectionViewModel.cs:1585-1635`; `Models\UserSettings.cs:3776-3794`.
12. **7 BUG-765:** `LongitudinalSectionViewModel.cs:1228-1236, 1336-1376`. **BUG-1193:** `LongitudinalSectionViewModel.cs:1269-1308`. **BUG-1020:** `ProfileRouteReviewService.cs:432-436, 862-865`; `UserSettings.cs:3757`. **BUG-1154:** `LongitudinalSectionService.cs:3301, 3357, 3408`.
13. **7 fixed list:** BUG-756 `LongitudinalSectionService.cs:1481-1489, 1513`; BUG-760 `ProfileRouteEvidenceCaptureService.cs:620-625, 754-761`; BUG-761 `ProfileRouteEvidenceCaptureService.cs:744-750, 777-785`; BUG-762 `ProfileRouteReviewService.cs:437-448`; BUG-763 `ProfileRouteReviewViewModel.cs:46-51`; BUG-764 `LongitudinalSectionViewModel.cs:854-935, 1402-1470`; BUG-766 `LongitudinalSectionService.cs:857-859, 967-990`; BUG-767 `LongitudinalSectionService.cs:1823-1845`, `UserSettings.cs:905`; BUG-768 `Rules\ProfilePitWidthRule.cs:25-52`; BUG-769 `ProfileRouteReviewViewModel.cs:143-149`; BUG-1012 `LongitudinalSectionViewModel.cs:1274-1322`.
14. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:03. Nothing was run in AutoCAD.
