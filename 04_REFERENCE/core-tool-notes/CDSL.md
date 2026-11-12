# TOOL NOTE: Spot level (CDSL)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Places one SPOT LEVEL block** at the point you pick, with the proposed level you type (shown as "P" and three decimals).
2. **If a survey is linked,** it first tells you the existing level from the survey at that point.
3. **One per command.**

## 2. What it changes in the drawing

1. **Draws** the SPOT LEVEL block on 25DIMS (the layer name can be renamed in Settings) with its LEVEL filled in.
2. **Stores nothing in CE's record** for the spot level.
3. **Full record update before the first question.** It runs CE's forced whole-drawing record update and saves; Esc later does not take it back.
4. **Also before the first question:** makes 25DIMS if missing and loads the SPOT LEVEL block into the drawing.

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **Locked 25DIMS layer** (checked before any question): "The 25DIMS layer is locked, so a spot level cannot be placed. Unlock it and run CDSL again. Nothing was changed."
3. **Block file missing:** "SPOT LEVEL block not found." with a list of folders (see 7).
4. **Levels over 9000 m** are refused as not a level.

## 4. What it asks you, and what Enter means

1. **"Specify spot level insertion point":** a drag preview. Enter is not accepted. Esc: "CDSL command cancelled."
2. **Survey line** (if a survey is linked): "Existing level from the survey here: N m", or why there is none.
3. **"Enter proposed spot level (m)":** **Enter places a blank level.** Esc: "CDSL command cancelled. Nothing was placed." Text that is not a level asks again. P, RL, PRL, m and AHD and comma decimals are accepted.

## 5. When it says Unknown or "needs checking"

1. **Blank level** when you press Enter (whether the block then shows a default text from its drawing file could not be confirmed).

## 6. How to undo it

1. **U once** is expected: three steps inside one command. Not proven in AutoCAD.

## 7. Known faults

**Still there in this build**
1. **BUG-1201:** cancelling the first placement leaves the SPOT LEVEL block definition loaded in the drawing.
2. **BUG-1175:** the "not found" message lists a folder on Tim's own PC (C:\Lisp Files\) that release builds never search.

**Partly fixed**
1. **BUG-712:** 25DIMS is now checked before any question. Still there: the level is written without checking its own layer and the result is ignored, so a block with no level could be left while it says "Spot level placed".

**New in code, no bug covers it**
1. **Forced full record update before the first question,** though a spot level does not need it.
2. **Two different upper limits:** 9000 m here, 3000 m for survey levels in Settings.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 2.1:** `Commands\SpotLevelCommand.cs:26`, `77-160`; `Rules\SpotLevelText.cs` (`ToAttributeText`); `Services\LayerService.cs:131`.
2. **1.2, 4.2:** `SpotLevelCommand.cs:71, 94-103, 180-188`; `Models\UserSettings.cs:3155`.
3. **1.3:** no `PlacementContinuationService` in `SpotLevelCommand.cs`.
4. **2.3, 7 new 1:** `SpotLevelCommand.cs:41-43`; `Services\ProjectDataService.cs:264-269`.
5. **2.4, 7 BUG-1201:** `SpotLevelCommand.cs:45, 56`; `Services\BlockService.cs:490-515, 949`.
6. **3.1:** `SpotLevelCommand.cs:33`; `Services\DrawingSafetyService.cs:61-131`.
7. **3.2:** `SpotLevelCommand.cs:47-53`.
8. **3.3, 7 BUG-1175:** `SpotLevelCommand.cs:59-64`; `BlockService.cs:85-90`.
9. **3.4, 7 new 2:** `Rules\SpotLevelText.cs:17`; `UserSettings.cs:3175`.
10. **4.1:** `SpotLevelCommand.cs:77-83`; `BlockService.cs:1612-1614`.
11. **4.3:** `SpotLevelCommand.cs:109-135, 174`; `SpotLevelText.cs:15-16, 35-61`.
12. **6.1:** `SpotLevelCommand.cs:138-158`.
13. **7 BUG-712:** `SpotLevelCommand.cs:47-53, 150, 161`; `BlockService.cs:2467-2468`.
14. **8.1:** no `#if` in `SpotLevelCommand.cs` or `SpotLevelText.cs`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:58. Nothing was run in AutoCAD.
