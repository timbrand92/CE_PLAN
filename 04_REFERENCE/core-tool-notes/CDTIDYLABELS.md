# CDTIDYLABELS: tool note (DRAFT, Slide labels clear of other text)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Slide labels clear of other text (CDTIDYLABELS)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Slides CE pipe labels, invert texts and flow arrows that sit on other text to the nearest clear spot, on the whole sheet or on the pipes you pick. It counts first and moves nothing until you say Yes. It is switched off until the office turns it on, and the command offers to switch it on.

2. WHAT IT CHANGES IN THE DRAWING
   The positions of CE labels, invert texts and arrows only. BUG-873: some start-up writing happens before the switch and the preview. BUG-1034 puts invert text on the pipe line.

3. WHAT IT WILL NOT DO
   Labels placed by hand, labels with no clear spot and labels on a locked layer are counted and left alone (Help). A label you moved by hand can still be shifted (BUG-1252, on hold for Tim's answer).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   All pipes or Select pipes (Enter is All). Then a count of labels that will move, are placed by hand, have no clear spot or sit on a locked layer. Then "Move these labels now?" Enter means No.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   BUG-896: on a crowded drawing it says "No CE label needs to move" when it gave up on a pipe.

6. HOW TO UNDO IT
   U once puts every label back (Help). Cancel has not been proven by the robot. BUG-893: Apply differs from the preview.

7. KNOWN FAULTS
   BUG-873: writes start-up data before the switch and preview (loses nothing known, writes unasked).
   BUG-1034: invert text put on the pipe line.
   BUG-879: its own moves are not marked as hand-placed.
   BUG-896: crowded drawing says nothing to move.
   BUG-890, 891, 893, 894, 895, 897, 962: sub-switches, all off.
   BUG-1252: a hand-placed label is shifted.
   BUG-897 and BUG-962 depend on drawing size and Settings.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: 1 (R16, names the pipe, switch on only). Codex looks: none. Tim's trial: the hand-placed-label card was not run by Tim.
```
