# CDTEXTSEG: tool note (DRAFT, Move pipe text to another segment)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Move pipe text to another segment (CDTEXTSEG)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Moves the pipe text to a different segment of the pipe (command list entry). The shipped Help has no page for it.

2. WHAT IT CHANGES IN THE DRAWING
   The position of the pipe text. Not known: anything else. BUG-1161: the moved label forgets wording you kept, for example "APPROX."

3. WHAT IT WILL NOT DO
   Not known.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   BUG-1194: it picks the segment with the nearest midpoint, not the leg you clicked, and does not say so.

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   BUG-1161: moved label forgets kept wording (loses typed text).
   BUG-1194: picks the nearest midpoint, not the clicked leg.
   BUG-1195: writes the wrong angle plane, depending on the UCS in use.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: none.
```
