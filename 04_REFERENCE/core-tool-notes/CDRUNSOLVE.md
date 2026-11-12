# CDRUNSOLVE: tool note (DRAFT, Solve inverts down a run)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Solve inverts down a run (CDRUNSOLVE)
Core since: not yet. Several faults report results that are not true, see item 7.
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   You pick a start pit. It proposes inverts and grades for the whole downstream run, previews them, and applies them if you say so. The run preview lists the affected pits, pipes and proposed levels.

2. WHAT IT CHANGES IN THE DRAWING
   The inverts and grades of the pipes and pits in the run, after Apply. BUG-290: a refresh overwrites typed levels (fix installed, untested).

3. WHAT IT WILL NOT DO
   It does not read the stored LPD. It finds the outlet by looking for a pit whose number contains "LPD". Plan step 7 is meant to change this.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The start pit, then Apply or not. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   It says "already matches" when it solved nothing (BUG-999). It treats every pipe as UPVC, so concrete capacity is overstated by about 23 per cent (BUG-868, draft pull request, switch off). The cover check is skipped at a lid RL of 0.000 (BUG-1093).

6. HOW TO UNDO IT
   Not known. Cancel also rolls back a palette change (BUG-311), which is more than Cancel should do.

7. KNOWN FAULTS
   BUG-868: treats every pipe as UPVC (concrete capacity overstated by about 23 per cent).
   BUG-999: says "already matches" when it solved nothing.
   BUG-311: Cancel also rolls back a palette change (loses data).
   BUG-290: a refresh overwrites typed levels (fix installed, untested).
   BUG-1088: the sizer picks the smallest pipe at any grade.
   BUG-1093: the cover check is skipped at lid RL 0.000.
   BUG-056: existing council line case.
   BUG-964: redesign fault.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: none.
```
