# CDMA: tool note (DRAFT, Move a flow arrow)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Move a flow arrow (CDMA)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Moves the flow arrow of one pipe to a new spot along it, or puts an arrow on a pipe you pick. Typed only today.

2. WHAT IT CHANGES IN THE DRAWING
   The arrow's position. If you pick a pipe, it can also take the two end levels you type and reverse the arrow. Not known: anything else.

3. WHAT IT WILL NOT DO
   Not known.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Pick the arrow to move or the pipe to put one on. For an arrow, click its new position. For a pipe you can type the two end levels (Enter skips them) and answer whether to reverse the arrow.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known.

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   BUG-1218: the Help page was missing (the shipped Help now lists CDMA, so this may be out of date; not re-checked).

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: none.
```
