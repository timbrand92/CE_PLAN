# Area A — Project setup, planning documents, council rules and project evidence (CDSETUP)

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

Project setup, planning documents, council rules and project evidence (CDSETUP). (From the area register in `MASTER_PLAN.md`.)

## 2. Where the detail is

1. `02_COUNCIL_RULES\` (every council write-up, the design guidebook, OPEN_QUESTIONS.md)
2. `04_REFERENCE\civil-system-design-2026-09-16\` (planner outputs and the whole-plugin requirement cards)
3. `04_REFERENCE\CARDS_INDEX.md`

## 3. Items and status

_Opened 19 Sep 2026; this area had no area file before. Its state in the old master plan's register was "Planned". Add items here as work starts; say Built / Tested / Installed / Tim-accepted separately, never a percentage._

1. **V3 item 39.8, Design project setup:** Slice 1, source-reference Save Draft,
   is built in PR #210 (`codex/v3-cdsetup-1` at `a650644a`), not merged or
   installed. Slice 2, pick/preview/confirm of the existing CDLPD marker and
   CE note with one outlet record each, is built in ready-for-review PR #212
   (`codex/v3-cdsetup-2` at `0cee02af`), stacked on #210. On 25 Sep 2026 the
   three Civil Release build lanes had 0 errors; the full net10 suite had
   11,078 passed, 19 skipped and the same 6 known failures as Slice 1. WPF
   dark/light pictures were reviewed. No AutoCAD test, installation, merge or
   Tim acceptance has occurred. The CDLPD reuse is the recorded plan
   interpretation supplied with Slice 2, not a new Tim ruling. Council rule
   review, area confirmation, accepted-design/CDCALC hand-off and During/Finish
   remain later slices; pipe linking requires explicit outlet-pipe selection.

## 4. Bugs

`BUG_CARPARK.md` at the root of this repository is the one bug file. List this area's open bug IDs here.

## 5. Parked

`IDEAS_INBOX.md` at the root is the one idea file. List this area's parked items here.

## 6. Test steps

`PENDING_TESTS.md` at the root is the one list of built-but-not-tested work. Rows for this area are named there. Write steps Tim can follow in AutoCAD, saying what "right" looks like, in both lanes (2027 and 2024/net48).

## 7. Regression list

_"These things must still work", re-checked before any deploy. Seed from `REGRESSION_LOG.md` in the plugin repo._

1. _(none recorded yet)_
