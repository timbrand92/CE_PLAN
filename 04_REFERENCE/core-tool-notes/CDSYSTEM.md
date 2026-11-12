# TOOL NOTE: Put pipes in a system (CDSYSTEM)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Records which system the pipes you select belong to:** Property, Outfall, Council or Inherit.
2. **Changes only CE's record,** not the drawing's lines or labels.

## 2. What it changes in the drawing

1. **Each selected pipe's system** in CE's record, then saves the record.
2. **No geometry, labels or layers.**
3. **No whole-drawing record update;** it makes CE's record this drawing's without saving.

## 3. What it will not do

1. **No start-up checks** (read-only, REFEDIT, Paper Space, drawing type); no locked-layer check (it changes no objects).
2. **Pipes with no CE record are skipped** without a word.
3. **Nothing that is a CE pipe:** "None of those is a CE pipe. Nothing was changed."

## 4. What it asks you, and what Enter means

1. **"Select the pipes to put in a system":** Esc or an empty selection ends quietly.
2. **"System for these pipes [Property/Outfall/Council/Inherit]" (Property is the default):** Esc ends quietly. Enter most likely means Property (AutoCAD returns the default; not proven).
3. **When done:** "N pipe(s) recorded as ... Save the drawing to keep it." For Inherit it says "N pipe(s) now follow their upstream pipe's system. Save the drawing to keep it."

## 5. When it says Unknown or "needs checking"

1. **Not applicable.**

## 6. How to undo it

1. **Whether U takes back the record change was not traced.**

## 7. Known faults

No bugs are filed under this command.

**New in code, no bug covers it**
1. **The count is pipes changed, not pipes picked;** skipped pipes are never mentioned, and "0 pipe(s) recorded" can print.
2. **Other objects in the selection** are dropped without a count.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 4.2:** `Commands\PipeSystemCommand.cs:24, 64-72`.
2. **2.1, 2.2:** `PipeSystemCommand.cs:78`; `Services\ProjectDataService.Mutations.cs:1634-1659`.
3. **2.3:** `PipeSystemCommand.cs:33`.
4. **3.1:** no `CommandPreFlight` in `PipeSystemCommand.cs`.
5. **3.2, 7 new 1:** `ProjectDataService.Mutations.cs:1647`; `PipeSystemCommand.cs:78-81`.
6. **3.3:** `PipeSystemCommand.cs:51`.
7. **4.1, 7 new 2:** `PipeSystemCommand.cs:36-48`.
8. **4.3:** `PipeSystemCommand.cs:79-81` (recorded line at 81, Inherit line at 80).
9. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 02:20; corrected after independent review. Nothing was run in AutoCAD.
