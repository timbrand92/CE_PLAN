# CDNEWDWG: tool note (DRAFT, New job drawing)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): New job drawing (CDNEWDWG)
Core since: not yet. Typed only today; its ribbon spot is assumed, Tim to confirm.
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   You pick a job folder, discipline and sheet size. CE copies the right office template in, names the drawing from the job's own drawings, fills the title block from the job record, and opens it. AutoCAD 2027 only. Civil only for now: Structural has its own template setup.

2. WHAT IT CHANGES IN THE DRAWING
   It creates a new drawing file in the job folder and opens it. A preview is shown first. It fills the title block. BUG-969: the title block shows the previous job's reference after you change the job folder, and the preview shows the same wrong reference.

3. WHAT IT WILL NOT DO
   It does not work on AutoCAD 2022 to 2024 and does not do Structural jobs.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Job folder, discipline, sheet size. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known. A wrong job reference is printed as the job's own (BUG-969).

6. HOW TO UNDO IT
   Not known. It creates a file; nothing is recorded about removing it.

7. KNOWN FAULTS
   BUG-969: title block shows the previous job's reference after the job folder is changed (HIGH, wrong value shown as fact).
   BUG-1166: Civil and Manager look for office folders in different places.

8. ON AUTOCAD 2022 TO 2024
   Does not run (the command is built for AutoCAD 2027 only).

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: none. The A1 and A3 dialog files exist (audit).
```
