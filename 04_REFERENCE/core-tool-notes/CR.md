# CR: tool note (DRAFT, Copy and rotate)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Copy and rotate (CR)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Copies and rotates the objects you pick in one go. A working transform command kept until the approved Shared migration.

2. WHAT IT CHANGES IN THE DRAWING
   Adds the copies. A copied downpipe is left linked as AutoCAD copied it and keeps its tag (BUG-1246).

3. WHAT IT WILL NOT DO
   It stops on a raingarden (BUG-1245). Not checked on a downpipe or raingarden.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   After a copied downpipe it says the copy "could not be given its own link on this AutoCAD", leaves tag DP2 on the copy and does not say what to do (BUG-1246).

6. HOW TO UNDO IT
   Not known.

7. KNOWN FAULTS
   BUG-1245: stops on a raingarden.
   BUG-1246: a copied downpipe keeps its tag (loses nothing, but two objects share one tag), and the wording hints at an AutoCAD version difference.

8. ON AUTOCAD 2022 TO 2024
   Not known. The BUG-1246 wording ("on this AutoCAD") hints at a difference. Not checked.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: ordinary-object use on 5 Nov. Same trial note as MR.
```
