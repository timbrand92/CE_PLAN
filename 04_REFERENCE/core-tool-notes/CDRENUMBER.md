# CDRENUMBER: tool note (DRAFT, Renumber pits)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Renumber pits (CDRENUMBER)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Renumbers every plain pit number from the outlet up: P1 nearest the outlet, then up the main line, then each branch starting nearest the outlet. It lists every old and new number on the command line and asks Yes or No first. Typed only today, no ribbon button.

2. WHAT IT CHANGES IN THE DRAWING
   The pit numbers, after you answer Yes. Not known: everything else it touches.

3. WHAT IT WILL NOT DO
   It renumbers plain pit numbers only. Exactly what counts as plain is not known. It forgets which pit is the outlet every time it runs, so the same drawing can number differently on another day (audit).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Which pit is the outlet, then Yes or No. The default outlet is the lowest invert. Enter at Yes or No means No (Help): the drawing is left exactly as it was.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   With no inverts it says "not available" and nothing more. With no outlet pipe drawn it stops with no help (BUG-1237).

6. HOW TO UNDO IT
   U once after Yes (Help, Tim's hand pass H14, Codex G2 PASS).

7. KNOWN FAULTS
   BUG-1237: stops with no help when there is no outlet pipe.
   BUG-968: two opposite pipes confuse the outlet.
   BUG-1005: a short side run is numbered first.
   Numbering order still needs Tim's word.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: 1 on record (N15). Codex looks: 1 (G2 PASS, ledger 21). Tim's trial: hand pass H14 (preview, Yes, U; the No path was not reported). His first run on 29 Oct printed "nothing to renumber", so the real work was not seen then. No real-job trial.
```
