# CDSL: tool note (DRAFT, Spot level)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Spot level (CDSL)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Places or edits a Civil spot level. You pick the location and type the level to show.

2. WHAT IT CHANGES IN THE DRAWING
   Draws the spot level block with your level. First it runs CE's quiet update of the record (the audit names CDSL). BUG-1201: Cancel leaves a SPOT LEVEL block definition behind.

3. WHAT IT WILL NOT DO
   It does not guess a level: a stored survey level is shown as the existing level and you type the proposed one (passed on record).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The position and the level. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Passed on record for typed levels and stored survey levels. Its wording points at Tim's own folders (BUG-1175), which means nothing to a colleague.

6. HOW TO UNDO IT
   Not proven. Cancel leaves a real change (BUG-1201).

7. KNOWN FAULTS
   BUG-1201: Cancel leaves a SPOT LEVEL block definition.
   BUG-712 (fix installed, a Codex look passed, not accepted).
   BUG-1175: wording points at Tim's folders.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: 1 (R35, typed levels and the refusal, on 3.0.75, Claude-accepted). Codex looks: 1 (D5-02, passed). Tim's trial: hand passes 29 Oct on scratch drawings (typed level, stored survey level). No real-job trial. 2 ribbon clicks.
```
