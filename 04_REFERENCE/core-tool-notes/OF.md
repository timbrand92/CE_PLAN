# OF: tool note (DRAFT, Place an overflow)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Place an overflow (OF)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Places an overflow block and numbers it.

2. WHAT IT CHANGES IN THE DRAWING
   Draws the block with its tag and adds it to CE's record, through the same source engine as DP.

3. WHAT IT WILL NOT DO
   Not known.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The point. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   BUG-1242: the tag shows no number.

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   BUG-1242: tag shows no number.
   BUG-1225: placing after reopening a drawing (Tim passed the fix on 29 Oct).

8. ON AUTOCAD 2022 TO 2024
   Not known. The shared-engine fault BUG-1209 probably applies.

9. PROVEN BY
   Robot cases: 1 (N03). Codex looks: 1 (D7-02). Tim's trial: the robot accepted this tool on 29 Oct but Tim did not pass it (H12).
```
