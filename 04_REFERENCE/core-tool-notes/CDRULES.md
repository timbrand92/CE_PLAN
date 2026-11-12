# CDRULES: tool note (DRAFT, Check against the rulebook)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Check against the rulebook (CDRULES)
Core since: not yet. Several faults leave checks unsaid, see item 7.
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Checks the drawing against the engineering rulebook: velocities, grades, cover and pit drop. Read-only (command list). The shipped Help has no page for it.

2. WHAT IT CHANGES IN THE DRAWING
   Nothing by design. Not run in AutoCAD for this note.

3. WHAT IT WILL NOT DO
   Council speed limits never reach the speed checks (BUG-1057). Nothing says the hydraulic grade line was not checked (BUG-1090). One council minimum grade is not applied (BUG-1059).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Up to 5 mm uphill is called "essentially flat" (BUG-1092). Advice to cure a slow pipe makes it slower (BUG-1006). Checks that were not made are not listed as not made (BUG-1090, BUG-1057).

6. HOW TO UNDO IT
   Nothing to undo by design.

7. KNOWN FAULTS
   BUG-1057: council speed limits never reach the speed checks (hides a check).
   BUG-1090: nothing says the hydraulic grade line was not checked.
   BUG-1092: up to 5 mm uphill is called "essentially flat".
   BUG-1006: advice to cure a slow pipe makes it slower.
   BUG-907: the pit drop check looks at inverts only.
   BUG-903: screens judge one pipe differently (Tim's ruling 136: CDRULES wins).
   BUG-1059: one council minimum grade is not applied.
   BUG-1060: new jobs show edition 2021.
   BUG-1111: the formula text says 0.3 but the number used is 0.35.
   BUG-1213: older AutoCAD cannot open the council evidence.
   About 23 open.

8. ON AUTOCAD 2022 TO 2024
   Known fault: BUG-1213, the council evidence cannot be opened.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: none. None of its rules has been accepted by Tim.
```
