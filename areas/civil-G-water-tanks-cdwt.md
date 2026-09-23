# Area G — Water tanks, reuse, underground/underdeck tanks and complete standard details (CDWT)

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

Water tanks, reuse, underground/underdeck tanks and complete standard details (CDWT). (From the area register in `MASTER_PLAN.md`.)

## 2. Where the detail is

1. `PENDING_TESTS.md` rows W-09 / W-10 and the CDWT tank plans
2. `decisions\DECISIONS_LOG_DRAWING_INTELLIGENCE.md` (TWL rulings, 15 Sep)

## 3. Items and status

_Opened 19 Sep 2026; this area had no area file before. Its state in the old master plan's register was "Existing CDWT task; do not duplicate". Add items here as work starts; say Built / Tested / Installed / Tim-accepted separately, never a percentage._

## 4. Bugs

`BUG_CARPARK.md` at the root of this repository is the one bug file. List this area's open bug IDs here.

## 5. Parked

`IDEAS_INBOX.md` at the root is the one idea file. List this area's parked items here.

## 6. Test steps

`PENDING_TESTS.md` at the root is the one list of built-but-not-tested work. Rows for this area are named there. Write steps Tim can follow in AutoCAD, saying what "right" looks like, in both lanes (2027 and 2024/net48).

## 7. Regression list

_"These things must still work", re-checked before any deploy. Seed from `REGRESSION_LOG.md` in the plugin repo._

1. _(none recorded yet)_

## 8. CDWT layout review and build — 23 September 2026

1. **Tim's instruction:** "Split into Capacity and Plan tabs. The plan gallery becomes paged groups with labelled page controls - today the lower gallery row is clipped. Place tank is fixed and always visible. Plan captions get two fixed lines instead of clipping." "LAYOUT ONLY. Do NOT change behaviour or view-model logic." "DO NOT OPEN AUTOCAD. DO NOT INSTALL ANYTHING."
2. **Approved scope / classification: Modify.** Capacity: move existing Above ground/Underground, tank list, typed litres, detention and reuse explanation onto Capacity. Plan: move existing drawings, matching message and missing-plans explanation onto Plan. Replace scrolling with bounded pages; keep all choices. Keep selected capacity, readiness, Tag a block already in the drawing, Place tank and Cancel outside both tabs. Keep existing selection, matching, double-click, placement, Escape and command paths. Retire nothing.
3. **Owner:** Codex, branch `codex/ui-cdwt`, new worktree `.codex/worktrees/ui-cdwt-20260923`, base `8f5b8d9f`. Window XAML and a separate view-only paging control; no edits to WaterTankDialog.xaml.cs or its nested view model. Other builder owns readiness wording, stale values and matching behaviour.
4. **Evidence and guards:** Pass 5 Civil UI/UX review, top ten 2 and walkthrough 1; `docs/design/V3_UI/windows/07_WATER_TANK.md` for fixed layout and footer. The older four-tab future scope does not supersede this two-tab instruction. Three safe Release build lanes, full Civil suite compared by failure names, isolated WPF layout/paging checks. No AutoCAD or core-console launch.
5. **Acceptance pending:** after separately authorised installation, on 2027 and 2024/net48 check the available CDWT route; window changes currently compile only on net10. On 2027 open Capacity, choose and type litres, change ground position and detention, visit every Plan page, select a final-page plan and return, resize to the minimum, check both themes, captions and fixed footer. Cancel/Escape must leave nothing drawn; Place/double-click and Tag existing retain their established command prompts. Save/reopen and one Undo remain the existing command's acceptance checks.
6. **Status:** implementation starting; not installed or Tim-accepted.

## 9. Confirmed takeover and completed-window scope — 23 September 2026

1. **Tim's instruction:** "TAKEOVER IS CONFIRMED." "BUILD A WHOLE WINDOW - layout AND the code behind it. Code only." The earlier session is stopped. Codex owns `codex/ui-cdwt` and its uncommitted work. No ownership question is outstanding.
2. **Scope update:** section 8's restriction against editing this window's code-behind/view model is superseded by this instruction. Ownership remains CDWT only: its XAML, code-behind, nested view model, new helper and tests. No command/service/rule/other-window edits. Keep PR #110 matching/order and PR #124 theme-owned next-action colour. No AutoCAD, installation, deployment or PR merge. Tim expressly requested a merge of master into the branch, not a rebase.
3. **Recovery:** unfinished work saved as `f711d81a` (`WIP (taken over)`); master `6eec48af` merged in `f5f51b02`. Both regression-log entries retained, CDWT first. New Pipe's header, fixed footer, theme resources, spacing and typography are the reference.
4. **Evidence in progress:** 191 focused Water Tank checks passed before final opening-size and rendered-page-button guards. Dark/light off-screen pictures are generated from the real WPF window at 96 dpi in `docs/image/V3_WINDOWS/cdwt-*.png`, using anonymous synthetic data. Final three-lane build and full Civil-suite counts will be recorded here when finished. Not installed or Tim-accepted.
5. **Presentation lesson:** paged lists must retain the source collection and selected item; paging is visibility only. Off-screen WPF render checks must drain the dispatcher before checking page-button availability. Blank office lists must state a way forward, and the selected-capacity summary belongs in the view model so it remains readable on either tab.
## 10. Code handoff — 24 September 2026

1. **Built and pushed:** `codex/ui-cdwt` at `24dde70378244cf723546778bb8235532e8cd9cb`; draft PR https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/135. Complete Capacity/Plan window, persistent summary, bounded paging and New Pipe shell resources. All three Release build lanes passed with 0 errors using SkipDevBundle and the specified references.
2. **Tested:** focused Water Tank 192 passed, 0 failed. Full Civil net10: 10,384 total; 10,353 passed, 12 failed, 19 skipped. All 11 new CDWT cases passed. The 11 existing failures were matched to earlier recorded results; the extra PDF loader failure reports resource in use (0x800700AA), also recorded on master. Tim's instruction: "More than 11: fix yours or stop and say so." No unrelated PDF fix attempted; PR remains draft.
3. **Pictures inspected:** all 20 `docs/image/V3_WINDOWS/cdwt-*.png` files in the PR: five Capacity pages, three Plan pages and each empty-list state, dark and light. Real WPF content on STA at 96 dpi, anonymous data. No clipped/overlapping text, scrollbars or blank render. Full-suite regeneration produced identical hashes.
4. **Integration:** master advanced during checks. A fresh merge dry-run found only a REGRESSION_LOG.md conflict; no code conflict. Release integration must keep both entries, CDWT first. The tested tip was left unchanged after the full-suite stop threshold was exceeded.
5. **Not installed or Tim-accepted:** no AutoCAD/core console opened; no installation, deployment, PR merge, rebase or force push. Remaining representative native acceptance is on PENDING_TESTS.md and in the PR. Future four-tab hydraulics/detail scope is still parked; no decision to implement it was made here.