# CDCALC: tool note (DRAFT, Drainage calculations)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Drainage calculations (CDCALC)
Core since: not yet. Several faults print invented values, see item 7.
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Opens the drainage calculation work: detention, longitudinal, pipe flows, Boyd's method, charged system, pump system, catchments, WSUD, and a computation sheet to print. Results can need review.

2. WHAT IT CHANGES IN THE DRAWING
   Not known. The plan (step 5) lists calculations among the windows that can run CE's quiet update of the record. Closing with nothing changed leaves an undo step (BUG-1030). Detention has a Drawing output step.

3. WHAT IT WILL NOT DO
   It does not check a 300 mm head (BUG-1097). The pump tab is read-only with no banner saying so (BUG-1033). WSUD accepts negative areas (BUG-772).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Inputs on the relevant tab, then calculate. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   It opens with a made-up catchment and a 15-minute storm (BUG-1101). The WSUD export prints a sample site nobody typed (BUG-1112). The council sheet was dropped silently (BUG-158, fix installed, untested).

6. HOW TO UNDO IT
   Not known. BUG-1030 leaves an undo step.

7. KNOWN FAULTS
   BUG-1101: opens with a made-up catchment and a 15-minute storm (prints invented values).
   BUG-1268: Export to XLSX writes no file.
   BUG-1112: the WSUD export prints a sample site nobody typed.
   BUG-1036: roughness described as "office Settings values" but is not.
   BUG-1089: its own fixed speed limits, not Settings.
   BUG-1033: pump tab read-only with no banner.
   BUG-1097: a 300 mm head is never checked.
   BUG-772: WSUD accepts negative areas.
   BUG-158: the council sheet is dropped (fix installed, untested).
   BUG-590 and BUG-591: export drops DRAFT.
   BUG-249: rainfall curve missing on the sheet.
   BUG-1030: closing with nothing changed leaves an undo step.
   About 23 open.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: 2 windows seen only (W5-01, W5-03). Tim's trial: none.
```
