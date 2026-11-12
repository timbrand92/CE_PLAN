# CDAGI: tool note (DRAFT, Draw an AGI drain)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Draw an AGI drain (CDAGI)
Core since: not yet. Placed on the ribbon by Claude; not yet confirmed by Tim.
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Draws a polyline as an agricultural drain on the AGI DRAIN layer (yellow, AG_LINE linetype) and numbers it AGI1, AGI2 and so on. It is in the "More sources" list. Tim, 7 Nov: used on normal jobs.

2. WHAT IT CHANGES IN THE DRAWING
   Draws the drain on its layer and adds it to CE's record. BUG-1054: in a metre drawing the drain loses its last point and closes itself.

3. WHAT IT WILL NOT DO
   It does not label the grade (BUG-648).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The route points. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   BUG-649 and BUG-1052: a rising or flat drain is reported as meeting the minimum grade. That is a wrong grade shown as a pass.

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   BUG-1054: in a metre drawing the drain loses its last point and closes itself (loses a point).
   BUG-1052: a flat drain passes the grade check in a metre drawing.
   BUG-649: a rising AGI passes the grade check.
   BUG-648: the grade is never labelled.
   BUG-290: a refresh overwrites levels (fix installed, untested).

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: his use on normal jobs (7 Nov). No dated trial.
```
