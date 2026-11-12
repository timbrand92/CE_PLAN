# CDFEEDBACK: tool note (DRAFT, Report a problem)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Report a problem (CDFEEDBACK)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Sends a problem report or suggestion to CE support. "Send report" saves a copy on this PC and tries the office feedback folder in the same step. If the office folder cannot be reached, the copy stays on this PC and the command line tells you to email the file.

2. WHAT IT CHANGES IN THE DRAWING
   Nothing in the drawing. It writes a report file on this PC and, if it can reach it, in the shared office folder.

3. WHAT IT WILL NOT DO
   Civil and Manager look for the office folder in different places (BUG-1166), so a report can land where support does not look.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Describe what happened, check what the report includes, then Send report. Cancel gives one honest line (Tim's hand pass).

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   After Send it says whether the office folder received it.

6. HOW TO UNDO IT
   A sent report cannot be taken back.

7. KNOWN FAULTS
   BUG-1215: Help promised a send step that did not exist. The shipped Help now says Send report saves a copy and tries the office folder, so this may be out of date.
   BUG-1166: Civil and Manager look in different office folders.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: hand pass for Cancel only (D29). Send report has never been pressed in a test; it needs Tim's yes and a spare login. 1 ribbon click.
```
