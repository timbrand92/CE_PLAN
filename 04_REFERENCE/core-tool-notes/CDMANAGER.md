# CDMANAGER: tool note (DRAFT, Layer standards)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Layer standards (CDMANAGER)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Opens the CE Drawing Standards Manager: layer colours, drawing order and label styles. You review the layer or label choice and save only the change meant for this drawing.

2. WHAT IT CHANGES IN THE DRAWING
   Layer colours, draw order and label styles in the drawing, when you Add, Reset, Apply or Save. Not known: anything else.

3. WHAT IT WILL NOT DO
   Not known.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   A window with layers, order and labels. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known.

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   BUG-229: the draw-order list looked wrong to Codex (cause unknown, observation only).

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: 1 read-only sweep (C1, 30 Sep; no Add, Reset, Apply or Save was used). Tim's trial: none. The Manager Status tab Tim passed is a different tool.
```
