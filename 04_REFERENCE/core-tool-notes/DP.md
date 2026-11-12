# DP: tool note (DRAFT, Place a downpipe)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Place a downpipe (DP)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Places a downpipe block and numbers it (DP1, DP2 and so on). You pick the building outlet.

2. WHAT IT CHANGES IN THE DRAWING
   Draws the downpipe block with its tag and adds it to CE's record. Not known: anything else.

3. WHAT IT WILL NOT DO
   Not known. It works before any pipe exists (Tim's hand pass).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The point, and source details. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   BUG-1242: the tag shows no number.

6. HOW TO UNDO IT
   Not known. Never checked as a whole. BUG-1140: a pasted downpipe keeps the original's link, so MOVE or CDREPAIR can act on the wrong object.

7. KNOWN FAULTS
   BUG-859: the double-click fix still fails in real AutoCAD.
   BUG-860: double-click on the green label does nothing.
   BUG-1118: the preview marker is fixed at 100 units, so it is 200 m long in a metre drawing.
   BUG-1140: a pasted downpipe keeps the original's link.
   BUG-1209: cannot place on a pit in AutoCAD 2022 to 2024.
   BUG-1228: placing takes about 30 seconds.
   BUG-1242: tag shows no number.

8. ON AUTOCAD 2022 TO 2024
   Known fault: BUG-1209, it cannot place on a pit.

9. PROVEN BY
   Robot cases: none recorded for DP itself. Codex looks: none. Tim's trial: hand pass 29 Oct on a scratch drawing for "downpipe before any pipe exists" (D07) and for close, reopen, then DP again (BUG-1225). Placement time was not accepted.
```
