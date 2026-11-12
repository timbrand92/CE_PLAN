# CDWT: tool note (DRAFT, Place a water tank)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Place a water tank (CDWT)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Places a tank plan, its tag and callout, with detention and reuse litres kept apart. You choose the tank capacity and a matching plan, check the two storage portions, then pick the point. It also links the riser and dropper under the same WT tag.

2. WHAT IT CHANGES IN THE DRAWING
   Draws the tank, tag, callout and sub-blocks and adds the tank to CE's record. BUG-1081: it writes lettering on a locked layer.

3. WHAT IT WILL NOT DO
   Not known. The council tank checks never run (BUG-1102, BUG-1104), and the tank in the report is not compared with the drawn tank (BUG-1105).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Total, detention and reuse litres, then the point. A typed detention of 0 is ignored (BUG-1115). It sometimes skips its window with no reason (BUG-1174). Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Council checks stay silent rather than saying they did not run (BUG-1102, BUG-1104, BUG-1105).

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   BUG-1081: writes lettering on a locked layer (the fix exists only in the held build C-80).
   BUG-1083: accepts an attached drawing (Xref) as the tank block (fix only in C-80).
   BUG-1115: a typed detention of 0 is ignored.
   BUG-1174: skips its window with no reason.
   BUG-1212: loses the tank pictures in AutoCAD 2022 to 2024.
   BUG-1102 and BUG-1104: council tank checks never run.
   BUG-1105: report tank not compared with drawn tank.
   BUG-1166: Civil and Manager look for office folders in different places.

8. ON AUTOCAD 2022 TO 2024
   Known fault: BUG-1212, the tank pictures are lost.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: none (he did not reproduce the old BUG-163 report on 24 Sep). 3 ribbon clicks.
```
