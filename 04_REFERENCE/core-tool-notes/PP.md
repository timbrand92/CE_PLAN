# PP: tool note (DRAFT, Quick plastic pit)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Quick plastic pit (PP)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Starts the normal pit placement with a plastic 350 x 350 mm pit already filled in.

2. WHAT IT CHANGES IN THE DRAWING
   The same as PIT: the pit, its label and cover text, and an entry in CE's record. Whether it runs the quiet update first is not known (the audit does not name PP; it shares the pit engine).

3. WHAT IT WILL NOT DO
   A plastic pit (350 x 350 and smaller) is left out of the Pit Schedule unless you use "Number and schedule this one anyway" in the PIT window (Tim's ruling, 5 Sep). Today the schedule does not say it left them out (BUG-1274).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The same New Pit window as PIT, with the preset filled in, then the point. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known.

6. HOW TO UNDO IT
   Not known. PIT is one U per pit; PP has not been checked.

7. KNOWN FAULTS
   BUG-458: runs inside REFEDIT.
   BUG-1274: plastic pits drop out of the Pit Schedule with no message. A real job on 4 Nov had six missing.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none recorded. Codex looks: none. Tim's trial: none.
```
