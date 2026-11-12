# CD: tool note (DRAFT, Draw a pipe)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Draw a pipe (CD)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Draws a drainage pipe with its plan text and flow arrow between the points you choose. You pick the first end, then the second end; Enter keeps a straight pipe. New Pipe is one page with Engineering and Drafting across the top and a plan preview below, then "Start Pipe". Second most used button (14 ribbon clicks).

2. WHAT IT CHANGES IN THE DRAWING
   Draws the pipe, its text, invert text at each end and the flow arrow, and adds the pipe to CE's record. First it runs CE's quiet update of the record (the audit names CD). Joins a pit where an end touches one. On a real job on 4 Nov, 6 of 46 pipes were converted on opening with no question (log).

3. WHAT IT WILL NOT DO
   Not known. It refuses a pipe 1 m or shorter in a metre drawing (BUG-331). It runs inside REFEDIT with no protection (BUG-458).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Two points, then the window. Enter at the second point keeps a straight pipe. The window remembers last-used values (CD_RecentValues), so the same click can give different results for different people. The recent-values buttons on the New Pipe page are missing (BUG-1226, BUG-1238).

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   A pipe with no size is given "100" and "UPVC" without saying so (audit, first check rule 3). BUG-685: a rounded typed level needs Tim's ruling.

6. HOW TO UNDO IT
   U once per pipe is the aim. Passed by Tim for PIT, not for CD's own Undo. Esc at the third point passed (D04). Esc drops the callout link (BUG-874) and leaves a drawn polyline behind (BUG-682).

7. KNOWN FAULTS
   BUG-680: Upsize can delete another pit's record (HIGH, loses data, fix installed, untested).
   BUG-681: an uphill flip leaves schedule levels swapped (HIGH, fix installed, untested).
   BUG-683: a real length typed gives the wrong level (HIGH, fix installed, untested).
   BUG-874: Esc drops the callout link (HIGH, loses data).
   BUG-682: Cancel leaves a drawn polyline.
   BUG-286: a pit on a locked layer links one-sided.
   BUG-675: a rotated pit fits wrong.
   BUG-1043: a blank invert refuses.
   BUG-1226 and BUG-1238: recent-value buttons missing.
   BUG-1239: label 450 units off centre.
   BUG-1228: slow, with DP.
   BUG-331 and BUG-337: metre drawings, short pipe refused and level and direction wrong.
   About 40 more open.

8. ON AUTOCAD 2022 TO 2024
   Not known. Never checked.

9. PROVEN BY
   Robot cases: 3 on record (R02, R03, R17 for the Esc half only, Claude-accepted). Codex looks: none recorded. Tim's trial: hand passes 29 Oct on scratch drawings (keeps placing, joins a pit, Esc at the third point, label text, leader label, one invert text each end, hide grade). His recent-values card was refused. No real-job trial.
```
