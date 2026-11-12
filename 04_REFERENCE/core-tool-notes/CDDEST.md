# TOOL NOTE: Where each downpipe ends up (CDDEST)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Lists where each downpipe's water ends up** (which outlet), following the pipes in CE's record.
2. **For downpipes it cannot trace,** offers to let you type where each one goes.
3. **Draws nothing.**

## 2. What it changes in the drawing

1. **Marks the drawing as a CE drawing** before any question.
2. **Answers you type** are stored in CE's record (one at a time, saved as you type each).
3. **No whole-drawing record update;** it makes CE's record this drawing's without saving.

## 3. What it will not do

1. **No start-up checks** (read-only, REFEDIT, Paper Space, drawing type).
2. **A name CE cannot see is still recorded,** with a spelling warning.
3. **Pipes drawn since CE last brought its record up to date** may be missing, so a downpipe can read "not known" (not proven).

## 4. What it asks you, and what Enter means

1. **"Record where those go now? [Yes/No] <No>"** (only if some are unknown): Enter = No. Esc ends quietly.
2. **"Where does X go?"** for each unknown downpipe: Enter skips that one. Esc: "Stopped. N answer(s) were recorded." (earlier answers are kept).

## 5. When it says Unknown or "needs checking"

1. **Downpipes it cannot trace** are listed as not known.
2. **No registered downpipes:** it prints a count of older labels instead.

## 6. How to undo it

1. **Each typed answer is saved straight away.** Whether U takes them back was not traced.

## 7. Known faults

No bugs are filed under this command.

**New in code, no bug covers it**
1. **The CE mark is written before any question** and is not taken back by Esc.
2. **Possible stale record:** recently drawn pipes may not be seen (not proven).

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1 to 1.3:** `Commands\SourceDestinationCommand.cs:33-70`, `179`.
2. **2.1, 7 new 1:** `SourceDestinationCommand.cs:44`.
3. **2.2, 6.1:** `SourceDestinationCommand.cs:280`; `Services\ProjectDataService.Rulebook.cs:95-124`.
4. **2.3, 3.3, 7 new 2:** `SourceDestinationCommand.cs:47-49`; `Services\ProjectDataService.Mutations.cs:244`.
5. **3.1:** no `CommandPreFlight` in `SourceDestinationCommand.cs`.
6. **3.2:** `SourceDestinationCommand.cs:275-278`.
7. **4.1:** `SourceDestinationCommand.cs:236-248`. **4.2:** `SourceDestinationCommand.cs:258-280`.
8. **5.2:** `SourceDestinationCommand.cs:63-66`.
9. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:08. Nothing was run in AutoCAD.
