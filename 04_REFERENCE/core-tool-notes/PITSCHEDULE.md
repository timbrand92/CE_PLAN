# PITSCHEDULE: tool note (DRAFT, Pit schedule)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Pit schedule (PITSCHEDULE)
Core since: not yet. Two open faults lose or hide pits and data, see item 7.
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Builds the pit schedule from the drawing, lets you compare and override any row, then places it on the drawing. The window has Source and Rows tabs. It can export to CSV and to Excel.

2. WHAT IT CHANGES IN THE DRAWING
   Places the schedule table. The relink button runs the same quiet update of CE's record as CDSYNC. BUG-817: opening the window leaves its own undo step. BUG-1198: a cancelled export still saves the row order.

3. WHAT IT WILL NOT DO
   A plastic pit (350 x 350 and smaller) is left out of the schedule unless you use "Number and schedule this one anyway" in the PIT window (Tim's ruling, 5 Sep). Today the window does not say so (BUG-1274). On a real job on 4 Nov the drawing held 11 pits and the schedule listed 5; six plastic pits were missing and nothing said so.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Source, rows, changed cells, then the placement choices. Row order is natural order (P1, P2, P10) only if that switch is on, and it is off by default, so with it off the order can read P1, P10, P2. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   A blank pipe size shows "?". It does not say which pits it left out (BUG-1274). A typed level can slide to another row (BUG-787). Refresh turns "2/375" into "375" (BUG-965).

6. HOW TO UNDO IT
   Not known. Never checked as a whole. The relink button may add changes with no line.

7. KNOWN FAULTS
   BUG-1274: plastic pits are left out and the window does not say so (loses pits from view).
   BUG-1255: Export Excel fails in AutoCAD 2027. AutoCAD 2027 ships its own older ClosedXML library and it wins over the one CE ships (cause confirmed 30 Oct; no fix; marked a pilot blocker). Way round: export CSV, which works.
   BUG-965: Refresh changes "2/375" to "375" (HIGH, loses data).
   BUG-787: typed levels slide to another row (loses data).
   BUG-1022: an override is lost after a copy (loses data).
   BUG-1198: a cancelled export still saves the row order.
   BUG-817: opening leaves its own undo step.
   BUG-855: the issues count rises after CDSYNC.
   BUG-1044: two Xrefs that each hold a P1 give an empty schedule.
   BUG-1035: a hidden fixed 300 mm "Shallow" rule.
   BUG-1197: a shared block heading changes another schedule.
   About 16 more open.

8. ON AUTOCAD 2022 TO 2024
   Not known. BUG-1255 is a 2027 fault; export is believed to work as before on 2022 to 2024 (not checked).

9. PROVEN BY
   Robot cases: not known. Codex looks: 2 on record (W2-02 passed for cell override; W2-04 failed on 3.0.70). Tim's trial: hand passes 29 Oct for natural order (D21) and Excel export with the Checking sheet (D23); BUG-1255 says Excel fails on 2027, after his pass. A long schedule over two sheets was not accepted. 2 ribbon clicks.
```
