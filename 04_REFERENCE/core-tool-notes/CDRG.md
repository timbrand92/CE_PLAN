# CDRG: tool note (DRAFT, Draw a raingarden)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Draw a raingarden (CDRG)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Draws a raingarden outline with a solid hatch and an inlet marker (GIO block). You trace the boundary.

2. WHAT IT CHANGES IN THE DRAWING
   Draws the outline polyline, the hatch and the GIO block, and adds the raingarden to CE's record. BUG-1107: the outlet pit is never recorded, so a connection is hidden.

3. WHAT IT WILL NOT DO
   Move or copy with MR and CR: they stop on a raingarden with a code word (BUG-1245).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The boundary points. Enter or U while finishing the outline cancels the whole command (BUG-771).

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known.

6. HOW TO UNDO IT
   Not known. Never checked. BUG-771: U during the command cancels everything.

7. KNOWN FAULTS
   BUG-1107: the outlet pit is never recorded (loses a link).
   BUG-771: Enter or Undo cancels the whole command.
   BUG-773: refuses a good garden (fix installed, untested).
   BUG-1242: tag shows no number.
   BUG-1245: stops MR and CR.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: 1 (N04, area 12.0 m2). Codex looks: none. Tim's trial: hand pass 29 Oct on a scratch drawing for "raingarden before any pipe exists" (D07). The RG label wording was still owed.
```
