# MR: tool note (DRAFT, Move and rotate)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Move and rotate (MR)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Moves and rotates the objects you pick in one go. It is a working transform command kept until the approved Shared migration. Tim, 5 Nov: "so far cr/mr work but not on all objects". It is the first tool on trial.

2. WHAT IT CHANGES IN THE DRAWING
   The position and angle of the objects you pick. Not known: what it does to CE's record.

3. WHAT IT WILL NOT DO
   It stops when a raingarden is selected (BUG-1245). It must leave locked layers, Xrefs and REFEDIT alone (the native protection rule); that has not been checked for this tool.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   When it stops on a raingarden it prints a code word, not drafting words (BUG-1245).

6. HOW TO UNDO IT
   Not known.

7. KNOWN FAULTS
   BUG-1245: stops with a code word when a raingarden is selected.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: hand pass on an ordinary object only (29 Oct, listed as "also passed"). Not on a raingarden.
```
