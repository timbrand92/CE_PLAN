# Area E — Pits, pipes, grades, sizes, labels and connected-network editing

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

Pits, pipes, grades, sizes, labels and connected-network editing. (From the area register in `MASTER_PLAN.md`.)

## 2. Where the detail is

1. `04_REFERENCE\CE_CIVIL_EDITOR_UI_UX_BRIEF.md` (CDEDIT, PIPEEDIT, PITEDIT, approved 31 Aug)
2. `04_REFERENCE\contracts\CONTRACT_GHOST_PREVIEW_2026-09-18.md`
3. `04_REFERENCE\contracts\CONTRACT_SPLIT_ON_DRAW_TICK_2026-09-18.md`
4. `decisions\2026-09-16_TEST_DAY_RESULTS.md` (Tim's results on the 16 Sep payload)
5. `areas\civil-stage1-foundation-status-log.md` (Stage 1 grip and twin-pipe history)

## 3. Items and status

_Opened 19 Sep 2026; this area had no area file before. Its state in the old master plan's register was "Active through Stage 1 to 3 core work". Add items here as work starts; say Built / Tested / Installed / Tim-accepted separately, never a percentage._

1. **E-HOLD-01 — Hold grade / hold levels when a pipe end moves** (Tim's idea and rulings, 23 Sep 2026: `decisions6-09-23_HOLD_GRADE_HOLD_LEVELS.md`).
   - **What it does:** moving a pipe end or a pit opens a preview window listing every level and grade the move changes, old to new, including the pipes downstream. Grade-held pipes keep the top level and drop the bottom. Numbers Tim typed by hand are shown beside the automatic number for him to pick. Apply = one Undo.
   - **Pieces, in order:** (1) moving a pit and dragging a pipe end give the same answer, BUG-160 fixed; (2) the move builds one change list and shows it in the existing Cascade Preview window; (3) window wording and the "you typed" column — Codex, from a contract Claude writes.
   - **Open:** what Cancel does (asked 23 Sep).
   - **Status:** Planned. Not built, not tested, not installed, not accepted. **Waits for BUG-161** (the trunk lacks the 15 Sep hand-typed-level fix this builds on).

## 4. Bugs

`BUG_CARPARK.md` at the root of this repository is the one bug file. List this area's open bug IDs here.

1. **BUG-160** (23 Sep 2026, suspected from code, not seen in AutoCAD) — dragging the end of a grade-held pipe rewrites a hand-typed bottom level on the plan but not in the schedule.

## 5. Parked

`IDEAS_INBOX.md` at the root is the one idea file. List this area's parked items here.

1. **Hold grade / hold levels** (Tim, 23 Sep 2026) — when a pipe end moves, the pipe either keeps its grade (bottom level re-worked, change carried downstream) or keeps its levels (grade re-worked). Half exists hidden in the CD grade choice; gaps and open questions in IDEAS_INBOX 23 Sep.

## 6. Test steps

`PENDING_TESTS.md` at the root is the one list of built-but-not-tested work. Rows for this area are named there. Write steps Tim can follow in AutoCAD, saying what "right" looks like, in both lanes (2027 and 2024/net48).

## 7. Regression list

_"These things must still work", re-checked before any deploy. Seed from `REGRESSION_LOG.md` in the plugin repo._

1. _(none recorded yet)_
