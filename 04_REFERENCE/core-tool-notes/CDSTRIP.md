# CDSTRIP: tool note (DRAFT, Draw a strip drain)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Draw a strip drain (CDSTRIP)
Core since: not yet. Placed on the ribbon by Claude; not yet confirmed by Tim.
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Draws a closed strip drain about 100 mm wide and places a floor waste at every corner and at 12 m centres along straight runs. It asks for a justification and an external flow-direction arrow. It is in the "More sources" list. Tim, 7 Nov: used on normal jobs.

2. WHAT IT CHANGES IN THE DRAWING
   Draws the drain outline, the floor wastes and the arrow, and adds the drain to CE's record. The drain stays loose geometry (BUG-647).

3. WHAT IT WILL NOT DO
   MOVE does not carry the whole drain: it strands the child objects (BUG-647).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The route, a justification, and the flow direction. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known.

6. HOW TO UNDO IT
   Not known. Cancel has not been checked.

7. KNOWN FAULTS
   BUG-647: stays loose geometry, MOVE strands its children (loses the link).
   BUG-290: a refresh overwrites pipe levels (fix installed, untested).
   BUG-022: end floor wastes (the middle ones are Tim-confirmed).
   BUG-028 and BUG-029: in progress.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: his use on normal jobs (7 Nov). No dated trial.
```
