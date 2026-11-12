# CDLPD: tool note (DRAFT, Legal point of discharge)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Legal point of discharge (CDLPD)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Records the discharge connection, then guides you to place its pipe end and label. Tim's ruling: the LPD is the start point of the network.

2. WHAT IT CHANGES IN THE DRAWING
   Draws the LPD label and marks the pipe end. Stores one record that links a pipe end and a pit. A second, newer record that can hold several outlets is written from CDDESIGN. Each refuses to be written while the other exists.

3. WHAT IT WILL NOT DO
   It does not tell the other tools where the start point is. CDRENUMBER forgets the outlet every run. CDRUNSOLVE looks for a pit whose number contains "LPD" and does not read the stored LPD. Plan step 7 is meant to change this.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The connection, then the pipe end, then the label position. Esc cancels before placement. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known.

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   BUG-1153: Redesign skips a fixed outlet when the record cannot be read.
   BUG-1158: a Save As copy keeps the original drawing's identity.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none recorded. Codex looks: none. Tim's trial: none.
```
