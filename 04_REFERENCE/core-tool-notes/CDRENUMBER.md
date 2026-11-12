# TOOL NOTE: Renumber pits from the outlet up (CDRENUMBER)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Renumbers the drawing's plain pit numbers P1, P2, P3 ...** from the outlet uphill, following the pipes in CE's record.
2. **Lists every pit whose number changes** (old to new) and asks Yes or No before changing anything.
3. **Only plain numbers:** "P" followed by digits (capitals do not matter).

## 2. What it changes in the drawing

1. **Pit numbers in CE's record,** and the From and To names on the pipes that join them.
2. **The number on each pit's label.**
3. **Linked cells of a placed Pit Schedule.** Cells on a locked layer are left and listed afterwards.
4. **No quiet record update.** It reads CE's record as it already stands.

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **No pits:** "This drawing has no pits to renumber."
3. **Two pits with the same number:** "More than one pit is already numbered X — fix the duplicate before renumbering." (a long dash in the code)
4. **No pipe leaves the network:** stops and says to draw the last pipe out to an open end (it does not let you pick the outlet yourself).
5. **Locked layer or Xref** on a changing pit, its label or its cover text: refused before writing, but only after you have said Yes. It names the pit and the layer.
6. **Pits with no number are skipped** without a word.
7. **Start number and prefix are fixed** at P and 1.

## 4. What it asks you, and what Enter means

1. **"Which pit is the main outlet? Type its mark or pick it on screen [marks] <default>":** asked only when more than one pit drains out of the network. Enter takes the default (the lowest invert when every candidate's invert is known, otherwise the first found). Esc: "Renumber cancelled - nothing changed." A wrong pick asks again.
2. **"N pit(s) will be renumbered. Apply? [Yes/No]":** only a typed Yes renumbers. Enter, No or Esc: "Renumber cancelled - nothing changed."
3. **Nothing is written before Yes.**

## 5. When it says Unknown or "needs checking"

1. **Loops in the pipes:** it names the pits in a loop in plain words before the list, then carries on.
2. **A pit the pipes never reach** still gets a number, after the walked network.

## 6. How to undo it

1. **U once.** It says "One Undo restores the old numbers." Not proven in AutoCAD.
2. **A failure part way** puts the numbers back itself and says how many it restored.

## 7. Known faults

**Partly fixed**
1. **BUG-1237:** when no pit drains out, it now says what to draw (switch on), but still stops; there is still no way to pick the outlet yourself.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-968:** loops are named in plain words and the renumber carries on.
2. **BUG-1005:** a branch is scored including the pipe that joins it (switch on).

**New in code, no bug covers it**
1. **A second outlet's branch** is numbered after the main network in old-number order, not downhill to uphill.
2. **"8" and "P8" are not treated as the same number** by the duplicate check (the planner works round it).
3. **Not checked that the record is this drawing's.** No step makes CE's record this drawing's own before reading it. Whether a second drawing in one session could show the first drawing's pits: not proven.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 1.3:** `Rules\PitRenumberPlanner.cs:74, 131`, `266-277`.
2. **1.2:** `Commands\PitRenumberCommand.cs:94-99`.
3. **2.1, 2.2:** `Services\PitRenumberApplyService.cs:147, 179-227`; `Services\ProjectDataService.Mutations.cs:1592-1631`; `Services\ScheduleLinkService.cs:3237`.
4. **2.3:** `PitRenumberApplyService.cs:164-166`; `ScheduleLinkService.cs:525-537`.
5. **2.4, 7 new 3:** `PitRenumberCommand.cs:37` (reads the record; no update or bind call in the file).
6. **3.1:** `PitRenumberCommand.cs:34`; `Services\DrawingSafetyService.cs:61-131`.
7. **3.2:** `PitRenumberCommand.cs:41-45`.
8. **3.3:** `Rules\PitRenumberNetworkBuilder.cs:64-67`, `91-97` (message text at line 96).
9. **3.4, 7 BUG-1237:** `PitRenumberCommand.cs:51, 62-66`; `Rules\PitRenumberOutletWordsRule.cs:19-27`; `Models\UserSettings.cs:1273`.
10. **3.5:** `PitRenumberApplyService.cs:36-104` (after Yes, `PitRenumberCommand.cs:110-118`).
11. **3.6:** `PitRenumberNetworkBuilder.cs:70-72`.
12. **3.7:** `PitRenumberPlanner.cs:74, 131`.
13. **4.1:** `PitRenumberCommand.cs:51-61`, `147-208`; `PitRenumberNetworkBuilder.cs:156-158`.
14. **4.2, 4.3:** `PitRenumberCommand.cs:101-118`.
15. **5.1, 7 BUG-968:** `PitRenumberCommand.cs:71-79`; `PitRenumberPlanner.cs:98-110`, `205-242`.
16. **5.2:** `PitRenumberPlanner.cs:173-195`.
17. **6.1:** `PitRenumberCommand.cs:125`. **6.2:** `PitRenumberApplyService.cs:197-207`.
18. **7 BUG-1005:** `PitRenumberPlanner.cs:150-152`; `UserSettings.cs:1264`.
19. **7 new 1:** `PitRenumberPlanner.cs:173-195`. **7 new 2:** `PitRenumberNetworkBuilder.cs:91`; `PitRenumberPlanner.cs:118-126`.
20. **8.1:** no `#if` in `PitRenumberCommand.cs`, `Rules\PitRenumber*.cs` or `PitRenumberApplyService.cs`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 02:20; corrected after independent review. Nothing was run in AutoCAD.