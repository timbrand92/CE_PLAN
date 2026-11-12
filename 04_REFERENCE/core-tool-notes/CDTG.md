# CDTG: tool note (DRAFT, Place a trench grate)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Place a trench grate (CDTG)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Places a trench grate block and numbers it. You give the grate position and check the tag.

2. WHAT IT CHANGES IN THE DRAWING
   Draws the block with its tag and a cover level, and adds it to CE's record.

3. WHAT IT WILL NOT DO
   Not known.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The position and a cover level. Enter at the cover level can reuse a level typed in a different drawing earlier in the same AutoCAD session (BUG-743), or store 0.000 where it should store a blank (BUG-432).

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   After you have typed a level once, Enter can no longer mean Unknown (BUG-743). A placeholder level of 0.000 is drawn as RL 0.00 (BUG-757).

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   BUG-743: Enter reuses a cover level from another drawing (fix installed, untested).
   BUG-745 (fix installed, untested).
   BUG-757: placeholder level 0.000 drawn as RL 0.00.
   BUG-432: Enter stores cover 0.000 instead of blank.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: none.
```
