# Area K — Profiles/long sections and plan-profile coordination (CDLPD)

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

Profiles/long sections and plan-profile coordination (CDLPD). (From the area register in `MASTER_PLAN.md`.)

## 2. Where the detail is

1. `archive\chat-records-2026-09\MORNING_PACK_K_L_2026-09-17.md` (what was built for K and L)
2. `PENDING_TESTS.md` rows TWL-04/05/06, PSD-01, K4

## 3. Items and status

_Opened 19 Sep 2026; this area had no area file before. Its state in the old master plan's register was "Source evidence exists; integration pending". Add items here as work starts; say Built / Tested / Installed / Tim-accepted separately, never a percentage._

1. **CDPROFILE rebuild, PR #187:** merged in release train 3 and installed on Tim's PC in Civil 3.0.3 (release-v3 items 100-102). Not tested in AutoCAD by Tim; not Tim-accepted.
2. **K-REQ-01 — REQUESTED BUILD (Tim, 25 Sep 2026, 13:18: "Both together now"):** when a long section is updated with CDPROFILE, the Pit Schedule rows it touches update in the same step, with one preview showing both changes and one Undo for both. Not built. For the release chat to schedule; needs its workflow card first (the combined preview and single-Undo Apply). Until built, CDPROFILE leaves the schedule alone. Ruling: `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` UX-PROFILE-05.
3. **PR #187 open decisions, answered 25 Sep 2026:** 1 kept by the standing no-retirement rule; 2 pump/WSUD under Older calculators (UX-CALC-OLDER-01); 3 orifice rounds down to whole mm (CR-A3); 4 any CE user approves, recorded (UX-CALC-APPROVE-01); 5 schedule updates with the section (UX-PROFILE-05). **6 (one Review home) still open.**

## 4. Bugs

`BUG_CARPARK.md` at the root of this repository is the one bug file. List this area's open bug IDs here.

## 5. Parked

`IDEAS_INBOX.md` at the root is the one idea file. List this area's parked items here.

## 6. Test steps

`PENDING_TESTS.md` at the root is the one list of built-but-not-tested work. Rows for this area are named there. Write steps Tim can follow in AutoCAD, saying what "right" looks like, in both lanes (2027 and 2024/net48).

## 7. Regression list

_"These things must still work", re-checked before any deploy. Seed from `REGRESSION_LOG.md` in the plugin repo._

1. _(none recorded yet)_
