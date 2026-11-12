# CDFW: tool note (DRAFT, Place a floor waste)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Place a floor waste (CDFW)
Core since: not yet. Open data-loss fault, see item 7.
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Places one floor waste block at the point you pick and gives it the next FW number (FW1, FW2 and so on).

2. WHAT IT CHANGES IN THE DRAWING
   Draws the block with its tag and adds it to CE's record. AND, today, clears the stored invert of existing pits (BUG-650, see item 7).

3. WHAT IT WILL NOT DO
   Not known.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The point. Esc at the first question does not leave things as they were (BUG-650).

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known. BUG-647: the refusal wording needs work.

6. HOW TO UNDO IT
   U once restores the inverts and removes the floor waste (read from the evidence on BUG-650, 16 Oct). Not proven by the robot as a repeatable check.

7. KNOWN FAULTS
   BUG-650 (HIGH, loses stored data): pressing Esc at the first question clears the stored invert of every pit, for example P1 20.000 and P2 19.800 become blank. Even a successful placement clears them. The drawn invert text on the pipes still shows the old levels, so the drawing and CE's record then disagree. Way round: not known. Do not use CDFW on a job whose pit inverts you need until fixed.
   BUG-1223: refuses a pick on an opening at pipe ends.
   BUG-647: refusal wording.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: 1 (found BUG-650 on a copy, 16 Oct). Tim's trial: none.
```
