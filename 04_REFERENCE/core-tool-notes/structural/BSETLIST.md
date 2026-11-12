# TOOL NOTE: List the inside points (BSETLIST)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Prints the inside points saved in this drawing** on the command line, one per line, numbered.
2. **Each line shows the point's X and Y** to one decimal place, in drawing units, with no unit written.
3. **It only reads.** Use BSET to add a point and BSETRESET to clear them.

## 2. What it changes in the drawing

1. **Nothing in the drawing.** It reads the saved list and writes nothing to it.
2. **Not the drawing:** a line in CE's command history on the PC, with each point.

## 3. What it will not do

1. **Does not show the points on screen.** Coordinates only.
2. **Does not say which building a point belongs to,** or which beams use it.
3. **Does not show a saved entry that is not a complete point** (three numbers). Such an entry is left out of the count.
4. **Does not check** whether the drawing is read-only or which space you are in. It does not need to, since it writes nothing.

## 4. What it asks you, and what Enter means

1. **It asks nothing.** There is no Enter or Esc step.
2. **What it prints:** "N inside-point(s) stored:" and then "  [1] (x, y)" for each point.
3. **With none saved:** "No inside-points stored for this drawing. Use BSET to add one."

## 5. When it says Unknown or "needs checking"

1. **"No inside-points stored" may be wrong when the saved list cannot be read** (see 7). If beams are refusing with "no inside-of-building point" and BSETLIST says none, do not trust the "none" yet.

## 6. How to undo it

1. **Nothing to undo.** It changes no drawing data.

## 7. Known faults

**Still open**
1. None found in the records for BSETLIST.

**Already fixed in this build, not yet seen working in AutoCAD**
1. None.

**Partly fixed**
1. None.

**New in code, no bug covers it**
1. **"No inside-points stored" is also printed when the list could not be read.** A read error is swallowed and treated as an empty list. The drafter is told there are none, when the truth is that CE could not look.
2. **Coordinates carry no unit.** In a metre drawing the numbers are metres, in a millimetre drawing millimetres. A point saved from the beam command's own question and a point saved by BSET are both in drawing units.
3. **The registry text uses words from the code:** "Shows how many inside-points are stored for the current drawing and their coordinates." The reader is not told what a point is for.

## 8. On AutoCAD 2022 to 2024

1. **No version difference found on this path** (no #if in the command file or the inside-point store).

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`.

1. **1.1, 1.2, 4.1-4.3:** `Commands\BeamInsidePointCommands.cs:80-103`.
2. **1.3:** `Commands\BeamInsidePointCommands.cs:80-110` (no write call).
3. **2.1:** `Services\BeamInsidePointStore.cs:28-49` (opens and reads only).
4. **2.2:** `Commands\BeamInsidePointCommands.cs:84, 100, 102`; `Services\CommandHistoryService.cs:48-69, 79-89`.
5. **3.3:** `Services\BeamInsidePointStore.cs:118-139` (only complete real-number triples are returned).
6. **3.4:** `Commands\BeamInsidePointCommands.cs:83-88`.
7. **5.1, 7 new 1:** `Services\BeamInsidePointStore.cs:43-48` (the catch returns the empty list); `Commands\BeamInsidePointCommands.cs:88-94`.
8. **7 new 2:** `Commands\BeamInsidePointCommands.cs:99`; `Services\BeamInsidePointStore.cs:141-150`; `Services\ConnectedDesign\Commit\AutoCadBeamInsidePointAtomicWriter.cs:21-26` (the beam command divides its millimetre figure back to drawing units before saving).
9. **7 new 3:** `Assets\Config\command-registry.json:2192-2206`.
10. **8.1:** no `#if` in `Commands\BeamInsidePointCommands.cs` or `Services\BeamInsidePointStore.cs`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026. Nothing was run in AutoCAD.
