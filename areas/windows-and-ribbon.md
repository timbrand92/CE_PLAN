# Area W — The CE windows, ribbon and design pack. Codex builds windows, Claude builds behaviour (Ruling B, 15 Sep); the CDWT window is the exception (Tim, 16 Sep)

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

The CE windows, ribbon and design pack. Codex builds windows, Claude builds behaviour (Ruling B, 15 Sep); the CDWT window is the exception (Tim, 16 Sep). (From the area register in `MASTER_PLAN.md`.)

## 2. Where the detail is

1. `decisions\2026-09-04_to_09-10_RECONCILED_DELIVERY_PLAN_AND_DESIGN_PACK_D1-D10.md` (window map, ribbon plan, Tim's 5 Sep review, icons, drawing desk)
2. `04_REFERENCE\CE_CIVIL_EDITOR_UI_UX_BRIEF.md`
3. `archive\chat-records-2026-09\MORNING_PACK_WINDOWS_2026-09-18.md`

## 3. Items and status

_Opened 19 Sep 2026; this area had no area file before. Its state in the old master plan's register was "see the source documents". Add items here as work starts; say Built / Tested / Installed / Tim-accepted separately, never a percentage._

## 4. Bugs

`BUG_CARPARK.md` at the root of this repository is the one bug file. List this area's open bug IDs here.

## 5. Parked

`IDEAS_INBOX.md` at the root is the one idea file. List this area's parked items here.

## 6. Test steps

`PENDING_TESTS.md` at the root is the one list of built-but-not-tested work. Rows for this area are named there. Write steps Tim can follow in AutoCAD, saying what "right" looks like, in both lanes (2027 and 2024/net48).

## 7. Regression list

_"These things must still work", re-checked before any deploy. Seed from `REGRESSION_LOG.md` in the plugin repo._

1. _(none recorded yet)_

## HELP-UI-20260923 — presentation-only build stopped at navigation boundary

1. **Tim's instruction, 23 Sep 2026:** "BUILD A WINDOW. Code only. DO NOT OPEN AUTOCAD. DO NOT INSTALL ANYTHING." Scope: Help Centre on new branch `codex/ui-help`; "If a layout change seems to need a behaviour change, STOP and say so in the PR."
2. **Status:** no window built or tested, nothing installed or Tim-accepted. Draft PR https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/125, documentation commit `5f441f0c`. Fresh worktree `C:\Lisp Files\CE_ACAD_PLUGIN\.codex\worktrees\ui-help-20260923`, based on fetched master `8f5b8d9f`.
3. **Evidence learned:** Civil guide HTML explicitly scrolls for section links and direct command anchors; the shared Help reader creates result controls in code and restores scroll/expanded-detail state. Removing scrollbars in markup alone hides content. Behaviour owner must supply bounded navigation preserving these destinations before layout can safely finish. This is an implementation finding, not a new Tim decision.
4. **Preserved:** guide content, commands, all code and view models. No builds or Civil tests run for this documentation-only stop. No manual test requested. Future window must match CdDialog header/footer and theme and pass all three build lanes, the known Civil baseline and Tim's no-scroll acceptance in 2027 / 2024 fallback.
