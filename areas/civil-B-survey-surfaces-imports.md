# Area B — Survey, surfaces, existing/proposed RLs and consultant imports

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

Survey, surfaces, existing/proposed RLs and consultant imports. (From the area register in `MASTER_PLAN.md`.)

## 2. Where the detail is

1. `04_REFERENCE\civil-system-design-2026-09-16\`
2. `04_REFERENCE\CARDS_INDEX.md`

## 3. Items and status

_Opened 19 Sep 2026; this area had no area file before. Its state in the old master plan's register was "Planned". Add items here as work starts; say Built / Tested / Installed / Tim-accepted separately, never a percentage._

1. **Civil import window, 24 September 2026:** Built and headless-tested on `codex/ui-import`: X-Civil source/schedule/results, LandXML source/results and a survey source/results presentation. Fourteen dark/light pictures inspected; three Civil Release lanes build with zero errors; full Civil suite has 10,829 passed, the exact 11 known failures and 19 skipped. The current CE ribbon commands still use their existing picker/command-line and Manager survey route because their command/service files are owned by Claude and were not changed. Installed: no. Tim-accepted: no. Command wiring and drawing interaction remain pending.

## 4. Bugs

`BUG_CARPARK.md` at the root of this repository is the one bug file. List this area's open bug IDs here.

## 5. Parked

`IDEAS_INBOX.md` at the root is the one idea file. List this area's parked items here.

## 6. Test steps

`PENDING_TESTS.md` at the root is the one list of built-but-not-tested work. Rows for this area are named there. Write steps Tim can follow in AutoCAD, saying what "right" looks like, in both lanes (2027 and 2024/net48).

## 7. Regression list

_"These things must still work", re-checked before any deploy. Seed from `REGRESSION_LOG.md` in the plugin repo._

1. Import source choice must preserve the existing DWG, package-folder, LandXML and survey routes; Cancel must leave the drawing unchanged. X-Civil schedule evidence must precede acceptance, and result rows must use drawing labels. The existing import arithmetic, output, report paths, Undo, locked-layer and Xref protections remain the command/service owner's responsibility.
