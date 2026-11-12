# CDRULEBOOK: tool note (DRAFT, Rulebook settings for the job)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Rulebook settings for the job (CDRULEBOOK)
Core since: not yet. Open faults say "set" when nothing was saved, see item 7.
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Sets the project's pit drop, council profile and cover override for the rule check. The shipped Help has no page for it.

2. WHAT IT CHANGES IN THE DRAWING
   Stores the job's rulebook choices in the drawing. Not known: anything else.

3. WHAT IT WILL NOT DO
   No council value can be edited anywhere in this build, though one record says values are on Settings (BUG-1109; the records conflict).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   It says "set" when the save was skipped (BUG-1071). 284 values are marked Assumed with no council source (audit).

6. HOW TO UNDO IT
   Not known.

7. KNOWN FAULTS
   BUG-1071: says "set" when the save was skipped (loses a change).
   BUG-1109: no council value can be edited anywhere.
   BUG-1213: older AutoCAD cannot open the evidence.

8. ON AUTOCAD 2022 TO 2024
   Known fault: BUG-1213, the evidence cannot be opened.

9. PROVEN BY
   Robot cases: none. Codex looks: 1 start-up pass in a sweep of 11 small passes (C1). Tim's trial: none.
```
