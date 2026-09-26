# Area CR — Council rulebook workstream: every council value on the Settings page, nothing hard-coded (R-00)

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

Council rulebook workstream: every council value on the Settings page, nothing hard-coded (R-00). (From the area register in `MASTER_PLAN.md`.)

## 2. Where the detail is

1. `02_COUNCIL_RULES\COUNCIL_RULES_V3_INTEGRATION.md`
2. `02_COUNCIL_RULES\OPEN_QUESTIONS.md` (questions Tim has not answered, never decisions)
3. `02_COUNCIL_RULES\CE_DESIGN_GUIDEBOOK_RULESET.md` and `CE_GUIDEBOOK_V1_3_SUPERSEDES.md`
4. `ENGINEERING_RULEBOOK.md`

## 3. Items and status

_Opened 19 Sep 2026; this area had no area file before. Its state in the old master plan's register was "see the source documents". Add items here as work starts; say Built / Tested / Installed / Tim-accepted separately, never a percentage._

1. **CR-D1, 26 Sep 2026 — Built and automated-tested; not installed or Tim-accepted.** All 22 council profiles swept in draft [PR #259](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/259), `codex/cr-d1-council-sweep` at `afa5435c`; 352 field changes and their sources are listed in `02_COUNCIL_RULES/CR-D1_SWEEP_2026-09-26.md` (report commit `fdf4cb9`). Whitehorse 90 mm remains Assumed under CR-C2. Civil Release net48/net8/net10 built with 0 errors; focused checks 63/63; final full Civil suite 11,131 passed, 6 known baseline failures, 19 skipped. No AutoCAD opened. The existing numeric loader still retains legacy placeholders behind Unknown provenance; a later reviewed model/consumer change is needed to remove them.

## 4. Bugs

`BUG_CARPARK.md` at the root of this repository is the one bug file. List this area's open bug IDs here.

## 5. Parked

`IDEAS_INBOX.md` at the root is the one idea file. List this area's parked items here.

## 6. Test steps

`PENDING_TESTS.md` at the root is the one list of built-but-not-tested work. Rows for this area are named there. Write steps Tim can follow in AutoCAD, saying what "right" looks like, in both lanes (2027 and 2024/net48).

## 7. Regression list

_"These things must still work", re-checked before any deploy. Seed from `REGRESSION_LOG.md` in the plugin repo._

1. **CR-D1:** A council figure needs its own source, not a copied office or neighbouring-council value. Verify Banyule 100% below ground / 40 mm orifice, Maribyrnong 10-year storage / 40 mm orifice, and Whitehorse 90 mm marked Assumed. Unknown must not be shown as a council pass. Use the after-install checklist in `PENDING_TESTS.md`; no result is accepted until Tim confirms it in AutoCAD.
