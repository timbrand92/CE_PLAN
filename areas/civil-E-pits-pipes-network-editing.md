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

1. **E-HOLD-01 — Hold grade / hold levels when a pipe end moves** (Tim's idea and rulings, 23 Sep 2026: `decisions\2026-09-23_HOLD_GRADE_HOLD_LEVELS.md`).
   - **What it does:** moving a pipe end or a pit opens a preview window listing every level and grade the move changes, old to new, including the pipes downstream. Grade-held pipes keep the top level and drop the bottom. Numbers Tim typed by hand are shown beside the automatic number for him to pick. Apply = one Undo.
   - **Pieces, in order (re-ordered 23 Sep 10:40 by Claude, because Tim's "always confirm" rule means no piece may add a new silent automatic change):** (0) **probe first** — can the preview open once MOVE / STRETCH / a grip drag / a pit move has finished, and can Cancel take the move back cleanly as one Undo? The code cannot answer this; it needs one short AutoCAD check in a free window. (1) after any move, one change list (the moved pipes, grade-held pipes' bottom levels, the downstream carry with the pit drop, hand-typed ends flagged) shown in the existing Cascade Preview window; Apply = one Undo, Cancel = the move undone. Pit move and pipe drag go through the same route, so they give the same answer, and BUG-160 goes with it. (2) window wording and the "you typed / automatic" choice — Codex, from a contract Claude writes.
   - **Cancel** undoes the move (Tim, 23 Sep 2026: "answer for question is a").
   - **Status:** Piece 0 (the probe, `CDMOVETEST`) **built** 23 Sep 2026: branch `claude/e-hold-01-move-test` @ `42766dd9`, PR #88, 33/33 unit tests on net10, both lanes compile. **Not installed, not tested in AutoCAD, not accepted.** Steps in `PENDING_TESTS.md`. **Installed only by the release chat** — Tim, 23 Sep 2026: *"CE_ACAD / release-v3-colleagues / plan / 01 this chat controls deployment"*; PR #88 handed to it by message the same day, with the advice that CDMOVETEST goes on Tim's PC only, never to colleagues. **Held by the release chat (23 Sep):** PR #88 stays off `master` until the colleague package is cut (Thu 24 Sep 5:30pm); PR converted to draft. It goes onto Tim's PC after Codex pass 2 (Fri 25 Sep evening to the weekend). Pieces 1 and 2 not started; parked until Tim's probe results (CLAUDE.md: no new work before the previous change is tested).

1. **UI-NEWPIT-02 — PR #127 takeover, 24 Sep 2026 (Codex).** Tim authorised "BUILD A WHOLE WINDOW - layout AND the code behind it. Code only." New Pit then Edit Pit bottom-level attention; keep shared PitViewModel/PitConnectedLevelsViewModel/Rules owned by Claude. Confirmed takeover; worktree clean, master `0de60b36` merged into `codex/ui-newpit` as `064ca210`, both regression histories kept. Modify presentation and bind PR #134's shared readiness, never duplicate its checks. Current brief supersedes the earlier missing-readiness blocker. No AutoCAD, installation, deployment or PR merge authorised. Final candidate `1a780add`, tested production code `fe48b037`: all three Release lanes 0 errors; full Civil 10,686 reported / 10,656 passed / 11 exact known failures / 19 skipped. All 260 Pit checks pass, including the 18 new render/readiness checks. Fourteen dark/light compiled-window pictures inspected and unchanged by SHA256 after the full suite. Code gate met for review; native acceptance remains pending in PENDING_TESTS.md.
   - **Scrolling ruling, Tim at midnight 24 Sep:** "I am happy to scroll in places when you would have to implement a next page button like in the help window i just dont want high use windows to have scrolling areas where the ui and ux could be designed far better". Fixed form; bounded long lists/reading can scroll.
   - **Preservation:** keep all fields, presets, survey reference, drawing/schedule choices, command bindings, preview, Inspect/return, Cancel/Escape and existing placement routes. Move detention lid layout/rotation into the fixed Rotation tab, with the existing alignment, angle, side and offset inputs, to clear small-display overflow and make every shared blocker reachable. (Supersedes the interim Drawing options placement recorded earlier in this session.) Shared readiness selects the attention field; real-window dark/light renders and all three builds plus the Civil suite required before review.
## 4. Bugs

`BUG_CARPARK.md` at the root of this repository is the one bug file. List this area's open bug IDs here.

1. **BUG-162** (23 Sep 2026) — a Pipe Edit source-text check has failed since 13 Sep on every line; stale check, not lost code.
1. **BUG-160** (23 Sep 2026, suspected from code, not seen in AutoCAD) — dragging the end of a grade-held pipe rewrites a hand-typed bottom level on the plan but not in the schedule.

## 5. Parked

`IDEAS_INBOX.md` at the root is the one idea file. List this area's parked items here.

1. **Hold grade / hold levels** (Tim, 23 Sep 2026) — when a pipe end moves, the pipe either keeps its grade (bottom level re-worked, change carried downstream) or keeps its levels (grade re-worked). Half exists hidden in the CD grade choice; gaps and open questions in IDEAS_INBOX 23 Sep.

## 6. Test steps

`PENDING_TESTS.md` at the root is the one list of built-but-not-tested work. Rows for this area are named there. Write steps Tim can follow in AutoCAD, saying what "right" looks like, in both lanes (2027 and 2024/net48).

## 7. Regression list

_"These things must still work", re-checked before any deploy. Seed from `REGRESSION_LOG.md` in the plugin repo._

1. _(none recorded yet)_

1. **UI-INSPECTOR-01 — whole CE Inspector palette, 24 Sep 2026 (Codex).** Tim: "BUILD A WHOLE WINDOW - layout AND the code behind it. Code only." Branch `codex/ui-inspector`, fresh clean worktree; origin/master already included. Tim explicitly assigns InspectorPaletteService and its views/view models for this run; "Behaviour (what is read from the drawing, when it refreshes) stays as it is - presentation and grouping only." Modify presentation: fixed CE/New Pipe shell; Selected object, Drawing health and Schedules tasks; retain compact selection / Full Inspector loading gate, every property/action, Refresh timing and PR #134 wording. Move connection/evidence/findings/schedule lists into bounded task areas; remove size fallback that hides the selected object. No workflow retired; no drawing writes added. Native docking, selection, editor hand-off and acceptance remain Tim's later checks in 2027 and 2024. This brief is the approved presentation workflow card; older live-edit aspirations are outside this run. No AutoCAD, installation, deployment or PR merge authorised.
   - **Inspector checkpoint, 24 Sep:** implementation saved as `f70f1ac2` on `codex/ui-inspector`; 166 focused checks passed. Real compiled off-screen pictures cover 17 states in each theme. Three-lane Release builds and unfiltered Civil validation now running. The pre-existing compact selection service still disables Edit; plain CDEDIT guidance replaces its unfinished internal wording. Enabling that hand-off is a behaviour-owner follow-up, outside this presentation-only scope. No AutoCAD, install or deployment.
