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

## HELP-UI-20260923 — widened window scope, 23 September 2026

1. **Tim's ruling:** "BUILD A WHOLE WINDOW - layout AND the code behind it. Code only." "The scope has been widened: you may now change the view model and add commands for THIS window." This supersedes the earlier presentation-only stop for PR #125. "DO NOT OPEN AUTOCAD. DO NOT INSTALL. DO NOT MERGE."
2. **Workflow card — Modify:** Civil guide navigation and shared Help reading become bounded pages. Keep Home, search, discipline, task groups, direct command bookmarks, continue reading, theme, minimise, tool launch gate, existing guides, support and picture enlargement. Remove no guide content. Close/Escape leave the drawing unchanged. Existing launch safety remains owned by its existing host.
3. **Implementation in progress:** same codex/ui-help worktree and draft PR #125; Civil host reuses New Pipe header/footer resources. HTML columns provide measured reading pages; shared WPF reader uses document pages and a saved page number. Earlier scroll positions remain readable as legacy preferences but new reading starts at page one unless a page was saved.
4. **Evidence learned:** Help ships two rendering paths: Civil HTML (also used by net48 in the browser) and shared WPF task guides. Both require page navigation to avoid losing access to content. The Civil guide's engineering descriptions are older-release content, retained with its existing version warning; updating those claims needs the behaviour owners, not guesses in a window change.
5. **Validation pending:** three Release build lanes, Civil known-failure comparison, Help tests and standalone visual checks. Not installed or Tim-accepted. No protected builder files to be edited.
