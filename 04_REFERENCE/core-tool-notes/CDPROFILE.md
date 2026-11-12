# CDPROFILE: tool note (DRAFT, Long section)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Long section (CDPROFILE)
Core since: not yet. Several open faults hide or misstate a level, see item 7.
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Draws a longitudinal section from the upstream pit you pick along the connected run. You check the route and scales, see a section preview, then place it.

2. WHAT IT CHANGES IN THE DRAWING
   Draws the long section. The plan (step 5) lists the long section among the windows that can run CE's quiet update of the record. It has a Review then Apply step (BUG-1020 depends on a layout setting). It saves a large record as one long text value (BUG-1154).

3. WHAT IT WILL NOT DO
   It treats a curved boundary as straight (BUG-1193, BUG-764). Branch marks are never drawn (BUG-766). A level pipe with no grade stops the whole section (BUG-760).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   The upstream pit, route and scales. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   It hides some wrong data instead of saying so: an invert above cover shows as depth 0.00 (BUG-762); an uphill pipe is printed as falling (BUG-761); a real depression is hidden by a 1.20 m survey limit (BUG-1192); any number in an Xref becomes a level (BUG-765).

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   BUG-762: invert above cover hidden as depth 0.00 (hides a level).
   BUG-761: uphill pipe printed as falling (wrong value shown as fact).
   BUG-1192: a real depression hidden by the 1.20 m survey limit.
   BUG-760: a level pipe with no grade stops the whole section.
   BUG-756: the top line is drawn at the next pipe's size.
   BUG-765: any number in an Xref becomes a level.
   BUG-766: branch marks never drawn.
   BUG-1193 and BUG-764: a curved boundary is treated as straight.
   BUG-1020: needs an office layout setting.
   BUG-1154: a large record saved as one long text value.
   About 8 more.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: 1 (W5-01 passed for the window half of the older tab only). Tim's trial: never accepted by Tim.
```
