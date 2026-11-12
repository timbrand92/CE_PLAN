# FO: tool note (DRAFT, Place a front overflow)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Place a front overflow (FO)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Places a front overflow block and numbers it.

2. WHAT IT CHANGES IN THE DRAWING
   Draws the block with its tag and adds it to CE's record.

3. WHAT IT WILL NOT DO
   Not known.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The point. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   The symbol on the plan reads "OF", so the plan label does not say what the object is (BUG-1236).

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   BUG-1236: the symbol text reads OF, not FO. Tim refused this tool on 29 Oct (D08) because of it.
   BUG-1242: tag shows no number.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none recorded. Codex looks: none. Tim's trial: his 29 Oct check found the fault. Not accepted.
```
