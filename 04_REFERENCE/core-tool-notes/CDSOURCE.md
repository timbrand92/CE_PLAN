# CDSOURCE: tool note (DRAFT, Place a generic source)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Place a generic source (CDSOURCE)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Places a generic source block, such as a roof drain or an AC unit, with an identifier you type.

2. WHAT IT CHANGES IN THE DRAWING
   Draws the block with your identifier and adds it to CE's record. It is not added to the Pit Schedule.

3. WHAT IT WILL NOT DO
   It does not add the source to the Pit Schedule.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The source type, the identifier to show, and the point. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known.

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   BUG-740: source names of more than one word (fix installed; a robot or Codex pass was seen but not accepted).

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none accepted. Codex looks: none accepted. Tim's trial: none.
```
