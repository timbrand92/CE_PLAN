# CDDESIGN: tool note (DRAFT, Design setup)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Design setup (CDDESIGN)
Core since: not yet. Many open faults in the rules behind it, see item 7.
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Reviews the job, the discharge choice, the contributing areas and the design route, and works out the design. Nothing is drawn. Tabs: Setup; Areas and route; Results.

2. WHAT IT CHANGES IN THE DRAWING
   Nothing is drawn. It keeps a design draft and writes the newer record that can hold several outlets. Per-discipline job mode (UX-DES-01) is in the code and has never been tested.

3. WHAT IT WILL NOT DO
   Council rules behind it never run in several cases and the results look as if they did (BUG-1095, BUG-1096, BUG-1099, BUG-1100, BUG-1102, BUG-1104).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Job name, council, discharge note, contributing areas, route. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   It warns about values it never uses (BUG-1110). Lots of 1,000 m2 and over get a Tc of 5 min with no note (BUG-1116).

6. HOW TO UNDO IT
   Not known. A damaged draft is replaced by the next Save Draft, losing the agreed design (BUG-1143).

7. KNOWN FAULTS
   BUG-1143: a damaged draft is replaced by the next Save Draft (loses the agreed design).
   BUG-1156: an older CE wipes newer answers from the draft (loses data).
   BUG-1088: the sizer picks the smallest pipe at any grade.
   BUG-1091: the minimum grade is dropped for DN450 and larger.
   BUG-1095, 1096, 1099, 1100, 1102, 1104: council rules never applied.
   BUG-1110: warns about values it never uses.
   BUG-1116: lots of 1,000 m2 and over get Tc 5 min with no note.
   BUG-1106: a two-word council is not found.
   BUG-866: open question.
   BUG-1158: a Save As copy keeps the drawing identity.
   About 30 open.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: none. Results have never been accepted by Tim.
```
