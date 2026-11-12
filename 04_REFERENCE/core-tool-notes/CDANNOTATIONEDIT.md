# CDANNOTATIONEDIT: tool note (DRAFT, Move one label or arrow)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Move one label or arrow (CDANNOTATIONEDIT)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Moves, rotates, mirrors or flips one CE label, invert text or flow arrow without redrawing the whole pit or pipe.

2. WHAT IT CHANGES IN THE DRAWING
   The position or angle of the label or arrow you pick. Not known: anything else.

3. WHAT IT WILL NOT DO
   Not known.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Pick the label or arrow, then its new position. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known.

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   None on record. BUG-879 says CE's own moves are not marked as hand-placed.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: none.
```
