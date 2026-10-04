# I-WSUD-02 workflow card: drawn treatment checked against the rating report

**DRAFT, awaiting Tim's approval before any code starts.** Written by build/04 (Team lane), 4 Oct 2026. Not built,
tested in AutoCAD, installed or Tim-accepted. Area: `areas/civil-I-wsud-treatment.md` item 1.
Ruling: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` UX-WSUD-02, Tim: **"Check and warn (Recommended)"**:
"Drawn treatment is checked against the rating report (areas, treated catchments, tank sizes) with both values shown
in Checks."

## 1. What exists today (Keep)

1. **The rating report reader, Keep.** CDCALC's STORM Rating Report intake (#233, `Rules/StormReport.cs`,
   `CatchmentReportIntakeOffer`) already reads each row: description ("D1 Roof"), impervious area m2, treatment
   (Rainwater tank / None / Buffer strip / Unknown, kept as written) and the treatment volume in litres.
2. **Drawn tanks, Keep.** CDWT places a tank from the master library with its capacity in litres.
3. **Buffer strips and raingardens, Missing as drawn objects with an area** (UX-WSUD-03 is their own card).
4. **Checks, Keep.** Project Review > Checks already lists warnings with a value and where it came from.

## 2. What this card adds (Missing)

One pure check, OFF by default (`wsudCheck.enabled`), run when Checks refreshes:

1. **Tank size:** each report row that goes to a tank, against the drawn tank its catchment name names (the
   L3-SOURCES whole-word rule, #680). Shows both: "Report: D1 Roof to tank, 3000 L. Drawn: WT1, 2000 L. Short 1000 L."
2. **Treated area:** the report's impervious area for each tank, against the CE catchment area drawn to that tank
   where one exists. Shows both values and the difference in m2.
3. **Missing treatment:** a report row with a treatment and nothing drawn for it ("Report: D3 Driveway to buffer
   strip. Nothing drawn.").
4. **Unknown stays Unknown (RULES 12.2):** no report = "not checked"; a row CE cannot match = "Unknown, pick the
   tank"; an unreadable volume is never 0.
5. **Warn, never block (R-27).** Nothing is drawn or changed. No Undo needed.

## 3. Questions for Tim (one batch, through the desk)

1. **Tolerance:** when is a drawn tank "the same" as the report's? *Recommended:* equal or bigger passes; smaller
   warns. Example: report 3000 L, drawn 3000 L passes; drawn 2500 L warns "short 500 L". Settings value, no hidden number.
2. **Area tolerance:** *Recommended:* warn when the drawn area differs from the report by more than 5 % or 5 m2,
   whichever is larger (Settings value, Assumed until he says).
3. **Scope now:** tanks only first (buffer strips and raingardens follow UX-WSUD-03)? *Recommended:* yes.

## 4. AutoCAD checklist (for later)

1. Switch OFF: Checks unchanged.
2. Switch ON, a job with a rating report and one drawn tank of the right size: no warning, both values shown.
3. Drawn tank smaller than the report: one warning with both values and the shortfall.
4. Report row to a buffer strip, none drawn: "Nothing drawn" warning.
5. No report attached: one "not checked" line, no warnings.
