# CEBLOCKS: tool note (DRAFT, Office blocks palette)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Office blocks palette (CEBLOCKS)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Opens a docked palette of the office blocks, in Tim's twelve tool-palette groups in his order, each with thumbnails. Click a block and pick its point: it is inserted as the office tool palettes insert it, on its own layer, at its own fixed size, with its stored rotation or explode.

2. WHAT IT CHANGES IN THE DRAWING
   Inserts the block you pick on its own layer. Nothing else is described.

3. WHAT IT WILL NOT DO
   A locked target layer is named on the command line and nothing is inserted there (Help). BUG-1047: a frozen layer is refused before it asks for the point.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Click a block, then pick the point. Escape during placement adds nothing (Help).

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known.

6. HOW TO UNDO IT
   One U per insert (Help). Not proven by the robot.

7. KNOWN FAULTS
   BUG-1047: refuses a frozen layer before asking for the point.
   BUG-188: fixed and merged, awaiting acceptance.
   BUG-1017, BUG-524 and BUG-1243: open.
   The palette folder is a Manager setting.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: none.
```
