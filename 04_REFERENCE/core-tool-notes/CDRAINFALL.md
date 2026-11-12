# CDRAINFALL: tool note (DRAFT, Rainfall for the job)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Rainfall for the job (CDRAINFALL)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Shows which rainfall curve this job is designed to, and lets you record the job's own coefficients from a text file or from what you paste, with a review step before Save. A job with none of its own is told it is using the office Melbourne curve, never given it silently.

2. WHAT IT CHANGES IN THE DRAWING
   Stores the job's coefficients after you review and Save. Nothing is drawn.

3. WHAT IT WILL NOT DO
   Not known.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Paste or import coefficients, review the change, Save. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   A missing job curve is named as the office Melbourne curve.

6. HOW TO UNDO IT
   Not known. An older test says Cancel closes with nothing drawn.

7. KNOWN FAULTS
   BUG-1216: Help opens the wrong page for this tool.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: none.
```
