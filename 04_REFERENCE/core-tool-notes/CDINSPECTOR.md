# CDINSPECTOR: tool note (DRAFT, Show what you have selected)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Show what you have selected (CDINSPECTOR)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Opens a palette beside the drawing that shows the pit or pipe you select, its levels and its known connections. It is for reading.

2. WHAT IT CHANGES IN THE DRAWING
   Nothing by design. The audit says it can run a full update of CE's record when it opens if the Workshop layout flag is off. Not run in AutoCAD for this note.

3. WHAT IT WILL NOT DO
   Not known.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Nothing. Select a pit or pipe and read.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   BUG-1240: after Save As it says "not in CE's record" for a pit the schedule lists. BUG-1094: a pipe 20 per cent flat shows amber when it fails.

6. HOW TO UNDO IT
   Nothing to undo by design.

7. KNOWN FAULTS
   BUG-994: drawn length wrong in a metre drawing.
   BUG-995: the Drawing health buttons.
   BUG-1094: a pipe 20 per cent flat shows amber.
   BUG-1240: after Save As it says "not in CE's record" for a pit that is.
   BUG-1249: says a pit label is bottom right when it is above.
   BUG-098 and BUG-099: older wording faults.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: hand pass 29 Oct on a pit only, half passed, on a scratch drawing (BUG-1249 and BUG-1240 were found on it). 4 ribbon clicks.
```
