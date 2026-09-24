# Area L — Schedules, construction details, notes, issue QA and drawing-wide review

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

Schedules, construction details, notes, issue QA and drawing-wide review. (From the area register in `MASTER_PLAN.md`.)

## 2. Where the detail is

1. `archive\chat-records-2026-09\MORNING_PACK_K_L_2026-09-17.md`
2. `PENDING_TESTS.md` rows T-01 CDFIXTAGS and the schedule rows

## 3. Items and status

_Opened 19 Sep 2026; this area had no area file before. Its state in the old master plan's register was "Partial foundations". Add items here as work starts; say Built / Tested / Installed / Tim-accepted separately, never a percentage._

1. **PERF-1B — automatic drawing QA and command usage (24 Sep 2026):** Tim's performance-fix brief authorises the existing service paths; `codex/perf-audit` @ `05476cd2`, PR #156. QA invalidates immediately but waits for three seconds of quiet after the last edit before subscribing to Idle, then unsubscribes when capture finishes. Civil command usage JSON is queued for background writing with the same content. Synthetic QA burst: 600 callbacks before, 0 during quiet after. Synthetic 100 ms serialiser: 103 ms caller time before, 5 ms after. Three Release lanes: zero errors; 67 focused net10 tests pass. Full Civil suite awaits the release chat after 17:30. Built and code-tested; not installed or Tim-accepted. AutoCAD checklist is consolidated in `PENDING_TESTS.md`.

## 4. Bugs

`BUG_CARPARK.md` at the root of this repository is the one bug file. List this area's open bug IDs here.

## 5. Parked

`IDEAS_INBOX.md` at the root is the one idea file. List this area's parked items here.

## 6. Test steps

`PENDING_TESTS.md` at the root is the one list of built-but-not-tested work. Rows for this area are named there. Write steps Tim can follow in AutoCAD, saying what "right" looks like, in both lanes (2027 and 2024/net48).

## 7. Regression list

_"These things must still work", re-checked before any deploy. Seed from `REGRESSION_LOG.md` in the plugin repo._

1. _(none recorded yet)_
