# TOOL NOTE: Rulebook settings for the job (CDRULEBOOK)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Shows and sets this job's rulebook values:** pit invert drop, council, and a project minimum cover override (with a reason).
2. **Each change is saved straight away** to the drawing's rulebook record.
3. **On AutoCAD 2027** it can also show the council source behind a value.

## 2. What it changes in the drawing

1. **The drawing's rulebook record** (pit drop, council, cover override and its reason), each saved as you answer.
2. **Show and Source** change nothing.
3. **No whole-drawing record update.**

## 3. What it will not do

1. **No start-up checks** (read-only, REFEDIT, Paper Space, drawing type).
2. **Council values cannot be edited,** only the council chosen, cleared or viewed.
3. **A cover override needs a reason:** "A reason is required ... Nothing changed."
4. **Unknown council id** is refused.

## 4. What it asks you, and what Enter means

1. **"CE rulebook for this project: pit drop ..., council ..., cover .... Choose [Drop/Council/coVer/Show/sOurce/0/20/50]":** Enter = Show ("Nothing changed."). Typing 0, 20 or 50 here saves that pit drop at once. Esc ends quietly.
2. **Drop: "Pit invert drop is X. Enter drop in mm":** Enter or Esc keeps it ("pit invert drop stays X").
3. **Council: "Council id for this project <X>":** Enter keeps it ("Council unchanged."); "None" clears it; Esc ends.
4. **Cover: "Project minimum cover override in mm (0 = remove override)":** then "Reason for the override (recorded with it)".

## 5. When it says Unknown or "needs checking"

1. **Record held back:** says "not saved" (switch on).

## 6. How to undo it

1. **U once** is expected (one command). Not proven.

## 7. Known faults

**Still there in this build**
1. **BUG-1109:** no council value can be edited anywhere.
2. **BUG-1213:** older AutoCAD cannot open the council evidence behind a value.

## 8. On AutoCAD 2022 to 2024

1. **No Source option** and no council source window (AutoCAD 2027 only; also missing on 2025 and 2026).

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 4.1:** `Commands\RulebookCommand.cs:22-70`.
2. **1.2, 2.1:** `Services\ProjectDataService.RulebookDrawing.cs:344, 394-400`.
3. **1.3, 8.1, 7 BUG-1213:** `RulebookCommand.cs:43-45, 72-78, 98-117` (`#if NET10_0_OR_GREATER`); `CE_CVL_SUITE.csproj:271-273` (page removed for every target except net10.0-windows).
4. **2.3, 3.1:** `RulebookCommand.cs:30-31` (no `CommandPreFlight` or record update).
5. **3.2, 7 BUG-1109:** `RulebookCommand.cs:152-187`.
6. **3.3, 4.4:** `RulebookCommand.cs:191-212`. **3.4:** `RulebookCommand.cs:180`.
7. **4.2:** `RulebookCommand.cs:137-142`. **4.3:** `RulebookCommand.cs:156-169`.
8. **5.1:** `Models\UserSettings.cs:647`; `Rules\SaveSkippedWordsRule.cs:15`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 02:20; corrected after independent review. Nothing was run in AutoCAD.