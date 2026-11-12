# CDPITCOVERFLIP: tool note (DRAFT, Flip cover text)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Flip cover text (CDPITCOVERFLIP)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Moves a pit's cover level text to another corner. The invert text moves with it.

2. WHAT IT CHANGES IN THE DRAWING
   The position of the cover text and the invert text of the picked pit. Whether it changes CE's record is not known.

3. WHAT IT WILL NOT DO
   Not known.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Pick a pit, then a corner in the drawing. Enter: not known. It is also on the Pit tab that appears when you pick a pit.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known.

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   None on record (no bug names it). This does not mean it is fault-free: it has never been checked.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: none.
```
