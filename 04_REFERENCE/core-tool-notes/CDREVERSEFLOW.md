# CDREVERSEFLOW: tool note (DRAFT, Turn a pipe around)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Turn a pipe around (CDREVERSEFLOW)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Swaps the From and To of one pipe, with their end levels, and flips the flow arrow. The pipe route, its barrels and the label positions stay where they are.

2. WHAT IT CHANGES IN THE DRAWING
   The pipe's From and To, its end levels and the flow arrow. Not known: whether it changes anything else in CE's record.

3. WHAT IT WILL NOT DO
   It does not move the pipe or its labels (Help).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Pick one CE pipe (or use the Pipe tab). The command line explains what will happen and asks "Continue?" Yes or No. Enter means No, and the pipe is left exactly as it was.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known.

6. HOW TO UNDO IT
   U once (Help says so; not proven by the robot).

7. KNOWN FAULTS
   BUG-1220: Help promised a preview window and an Apply button that do not exist. The Help shipped with this build already says there is no preview window and no Apply button, so this entry may be out of date. Not re-checked.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: none.
```
