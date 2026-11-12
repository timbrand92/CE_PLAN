# CDHELP: tool note (DRAFT, Help centre)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Help centre (CDHELP)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Opens the offline guide: find a task or command and read its section. It leaves the drawing alone. Esc closes it. It is the most clicked help button (7 ribbon clicks).

2. WHAT IT CHANGES IN THE DRAWING
   Nothing.

3. WHAT IT WILL NOT DO
   Not known.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Nothing. Search for a task, such as "change pipe size".

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not applicable.

6. HOW TO UNDO IT
   Nothing to undo.

7. KNOWN FAULTS
   BUG-1175: wording points at Tim's own folders, so a colleague sees them.
   BUG-1216: Help opens the wrong page for new tools.
   BUG-1215: Help promised a "Save report" step. The Help shipped with this build already describes Send report differently, so this may be out of date.
   BUG-1217: invites input to read-only calculators.
   BUG-1218 and BUG-1220: pages missing or wrong (the shipped Help now has pages for CDMA and CDREVERSEFLOW; may be out of date).
   BUG-555: makes calls off the PC.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: his 7 clicks. No dated trial.
```
