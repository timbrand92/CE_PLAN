# Design-pack questions for Tim, sorted — 25 September 2026

Made by `CE_ACAD / V3 PLAN / DISCUSSION / 01` for Tim's UX plan (purpose: `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`).
Source list: plugin repo `docs\design\V3_UI\00B_SWEEP_REPORT.md`, "Open questions for Tim" (5 Sep 2026). Its header says
49; the list actually runs 1 to 84 plus X1 and R3 (86). Sorted read-only against the 5 Sep review (`00C`), CE_PLAN
decisions, area files and the code on master. **Nothing here is a Tim ruling unless it quotes one.** As each is
answered, mark it here with a pointer to the decisions file.

## How they are used

1. **Numbers and defaults are not asked** (Tim, 25 Sep: plan talk is UX, not numbers). They take the design pack's
   default as a Settings value (R-00): 11 (shallow-pit reference), 12 (driveway lid class), 13 and 38 (decimals),
   19 (item count before asking), 66 (two text gaps or one), 67 (which settings tier).
2. **Pass 1, front door:** 1, 2, 4, 5, 50, 62, 75, 80, plus the design pack's four "Retired — needs Tim" items
   (`windows\01_RIBBON.md` §9: Workspace flyout, System flyout, CE Tools help/standards items, the CE CVL
   pull-down menu and seven toolbars).
3. **Pass 2, one way of working:** 9, 17, 21, 22, 25, 39, 41, 52, 53, 55, 71, 74, 79, 81, 85, 86.
4. **Pass 3, by family:** everything else, asked with its family.

## 1. Answered by Tim (8)

3 Water Tank has its own button on Draw (RIBBON-02, 23 Sep; code comment "Tim names CDWT first"). 23 Schedule
inclusion editable live in Civil Properties (00C, 5 Sep). 40 CDCHECK "as intended. No change." (00C). 45 Longitudinal
instruction kept (standing no-retirement rule). 46 UX-CALC-OLDER-01. 47 CR-A3. 48 UX-CALC-APPROVE-01. 49 UX-PROFILE-05.

## 2. Overtaken (5)

10 Pipe tab count — New Pipe and every Edit Pipe route are the one-page window (Tim 24 Sep, BUG-173). 20 Grip
crowding — four square grips plus hover menu (PR59 review, 5 Sep). 42 Checks navigation — replaced by per-row Fix,
Why and "Fix all safe drafting items" (00C). 43 and 57 Paging — Tim's midnight 24 Sep bounded-scrolling ruling.

## 3. Built one way, no recorded Tim ruling (3) — to confirm

1 Pit button face opens the full Pit window; the arrow drops the preset sizes. 2 Solve Run Inverts is on the Review
panel. 4 The discipline switch is always visible on the CE panel. (`Modules\Drainage\Services\CeCvlRibbonContributor.cs`.)

## 4. Still open (70), by family

1. **Ribbon:** 5 jump to the contextual Pipe tab on selection, or only show it.
2. **Pipe:** 6/16 "Keep separate" and "Keep as a free end" (both or one; remembered per drawing or job); 7 broken-pipe
   total length always typeable or only when CE cannot measure; 8 "Hide" grade on every type or Existing only;
   9 after Save as Simple Pipe start the next pipe or stop; 14 plastic off-schedule pit label block; 15 75 mm
   sole-candidate auto-connect default; 17 after "Edit 4 pipes" restore the mixed selection or keep the four;
   18 design grade with several pipes selected.
3. **Civil Properties / Inspector:** 21 hidden palette then clicking a pipe; 22 "Network OK" line on a clean
   drawing; 24 dock side; 25 "Not linked" screen detail.
4. **Sources:** 26 OF and FO same symbol; 27 strip drain placement in the list; 28 raingarden tag prefix; 29 trench
   grate length by drag or typed.
5. **Water tank:** 30 reuse always calculated or typeable; 31 no-detention callout wording; 32 LidType "Standard";
   33 riser/dropper numbering; 34 existing detention pit gets a real record or stays a callout.
6. **Slab:** 35 demo outlet naming; 36 "Meets 1 in 100" becomes "Pass" once signed; 37 Purpose list; 39 "Make fixed
   control" confirm first or just do it.
7. **Review and checks:** 41 passes folded by default; 44 export default; 50 CDHUB opens Proposals or Project Checks;
   51 proposal ranking; 52 wording for an unsigned rule; 53 override reason pick list or typed; 54 record who
   approved an applied proposal; 55 retire the "Highlight warnings" switch; 56 DET X (Grated) column.
8. **Pit Schedule:** 58 typed DEPTH display-only or updates the pit; 59 Excel checking sheet.
9. **Import:** 60 CDCHECKDWG output; 61 CDIMPORTCOMPARE writing before comparing; 62 X-Civil greyed or left out
   while hidden; 63 survey pick in canvas or files in window; 64 report file after Apply.
10. **Settings:** 65 Mirror Text Default; 68 administrator on day one; 69 adopting a newer rulebook.
11. **Repair:** 70 CDSYNC/CDREBUILD direct writes for experts; 71 pre-tick safe repairs; 72 quarantine list home;
    73 deleting quarantined records; 74 save after Apply.
12. **Manager, Help, Ask CE, Feedback:** 75 "Open Hub" in Manager; 76 guides in the default browser; 77 "Update
    colleagues" everyone or pick; 78 Ask CE "Review changes"; 79 "Save report" or "Submit".
13. **Design (CDDESIGN):** 80 CDLPD/CDLPDRESET hidden or not; 81 default route on an existing CE drawing; 82 area
    overlay colours; 83 draftsperson "Confirm setup" route; 84 outlet invert source words.
14. **Wording:** X1 "Not connected" and "Not connected yet"; R3 "Leave undecided".
