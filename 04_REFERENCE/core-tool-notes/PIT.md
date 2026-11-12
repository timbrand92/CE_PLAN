# PIT: tool note (DRAFT, Place a pit)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Place a pit (PIT)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Places a pit with its cover, invert and schedule information at the point you pick. A New Pit window has tabs: Pit and size, Levels and text, Connected pipes, Drawing options, Rotation, Presets. It keeps placing pits until you press Esc.

2. WHAT IT CHANGES IN THE DRAWING
   Draws the pit and its label and cover text. Adds the pit to CE's record. First it runs CE's quiet update of the record (the audit names PIT), and today no line says so (plan step 5). BUG-793: the pit block is swapped for the current one every time a drawing opens.

3. WHAT IT WILL NOT DO
   Not known. It runs inside an in-place block edit (REFEDIT) with no protection (BUG-458).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The pit size and type, levels and text in the window, then the point. A blank cover level refuses placing (BUG-1042). What Enter means at each prompt: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known. The quiet update fills a lid class of "Class C" and applies the plastic-pit rule from Settings without saying so (first check, rule 3).

6. HOW TO UNDO IT
   U once per pit (Tim's hand pass, 29 Oct). BUG-267: after OOPS the pit labels are lost (fix installed, untested).

7. KNOWN FAULTS
   BUG-690: splitting a pipe on a pit loses the link (HIGH, no fix seen).
   BUG-691: a pit split at a breakline keeps the wrong pipe ends (fix installed, untested).
   BUG-693: an arc pipe gets the wrong curves.
   BUG-267: OOPS loses pit labels (fix installed, untested).
   BUG-793: block swap on every open.
   BUG-1042: a blank cover level refuses placing.
   BUG-458: runs inside REFEDIT.
   BUG-1231: eight stray "not updated" lines.
   BUG-287: a metre drawing with millimetre pits.
   BUG-663: a fixed 2 km reach for the label (fix installed, untested).
   BUG-1165: an old all-users bundle supplies the pit blocks first.

8. ON AUTOCAD 2022 TO 2024
   Not known. Never checked.

9. PROVEN BY
   Robot cases: 4 on record (R01, R03, R05, N25, Claude-accepted on 3.0.84 to 3.0.86). Codex looks: not known. Tim's trial: hand pass 29 Oct on scratch drawings (keeps placing until Esc, label and cover text, native erase, copy and explode, one U per pit). No three-day trial recorded.
```
