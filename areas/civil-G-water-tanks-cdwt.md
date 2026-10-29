# Area G — Water tanks, reuse, underground/underdeck tanks and complete standard details (CDWT)

> *Note 29 Oct 2026 (Tim: "lets remove the codex or claude ownship rubbish, add cemember to build list"): the lines below that say who owned a branch or window ("Codex owns codex/ui-cdwt", "ownership remains CDWT only") record the situation at that time, not a rule. Any builder can build any item, windows included; acceptance rules and who deploys are unchanged.*

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
## 11. Bounded scrolling follow-up — 24 September 2026

1. **Tim's midnight ruling:** "I am happy to scroll in places when you would have to implement a next page button like in the help window i just dont want high use windows to have scrolling areas where the ui and ux could be designed far better". This supersedes sections 8–10's paging requirement for the Capacity and Plan lists only. The fixed window layout and two tabs remain.
2. **Approved Modify card:** replace Previous/Next capacity and plan controls with one bounded scrolling list per tab; retain all choices, matching, selection, typing, double-click placement, Tag existing, Cancel/Escape and command paths. Keep one next-action line; show the capacity summary only when answered. No engineering changes. Existing representative AutoCAD checks remain pending; use scroll-to-last-item instead of final-page checks.
3. **Takeover and integration:** worktree was clean; no new WIP commit was needed. Fetched master `5c02992b`, merged as `651f96fd`; only regression-log conflict, both sides retained with CDWT first. Work is in `codex/ui-cdwt`, PR #135. No protected builder files edited.
4. **Evidence in progress:** real-window dark/light renders and focused guards now cover bounded scrolling, every choice reachable, stable footer, retained selections/reordering and scrollbar double-click safety. Three Release lanes and full Civil net10 suite will be recorded after completion. No AutoCAD opened or installation authorised.

5. **Final code result / handoff:** pushed `d12fd5b756ba1d622294049ef0657eafa7ed09d3` on `codex/ui-cdwt`; PR #135 remains **draft / BLOCKED** under the 11-failure gate. Three Release lanes: 0 errors each. Focused Water Tank: 192 passed, 0 failed. Full Civil net10: 10,579 total, 10,548 passed, 12 failed, 19 skipped. Compared by name with the prior result: all 11 baseline failures retained; PDF now passes; extra failure is Settings `ResetCommand_Execute_SetsDesignStandardDefaults` (old 3.0 m/s expected, fresh-file 6.0 m/s returned). Protected Settings untouched; its builder's correction `5d533ab9` reached master after this session's starting merge. Release integration can take it and rerun. No further code work after the failed gate.
6. **Pictures and learning:** 20 `docs/image/V3_WINDOWS/cdwt-*.png` images inspected, now named by tab plus scroll position instead of page number. Fixed controls fit; partial rows at viewport edges can be scrolled fully into view. All 20 hashes remained identical after the full suite. Test discovery requires the real AutoCAD 2027 folder on the test process PATH; this loads assemblies, never AutoCAD. Text boxes' internal scroll controls must be excluded from a form-scroll guard. Scrolling/empty-space double-clicks must not reach plan placement.
7. **Status and undo:** code built, automated checks recorded, leak scan clean, pushed; no AutoCAD/core console opened, nothing installed or Tim-accepted. Revert `d12fd5b7` to restore the prior paging presentation. Native acceptance remains the existing combined checklist, updated to scrolling in PENDING_TESTS.md. Future hydraulics/detail scope remains parked.

## 12. V3 plan rulings UX-TANK-01..04 — 25 September 2026

1. **Ruling source:** `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Pass 3, family 3: water tanks (CDWT)". Worked by the release chat, branch `claude/ux-tanks` from `origin/release/civil-train-0925` (not yet merged into `master` on 25 Sep), draft PR [#241](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/241).
2. **UX-TANK-04 (LidType "Standard" retired) — BUILT, not Tim-accepted.** A new tank's PitData record no longer carries a LidType; CE Inspector drops the "Lid" row entirely for a water tank on both its display paths, instead of showing it blank. Real pits' own LidType is untouched. Old drawings with a saved `"lidType":"Standard"` on a WT record still load cleanly (back-compat test). AGI and trench-grate records carry the identical "Standard" placeholder but were not named in the ruling — left alone, flagged as a separate follow-up candidate.
3. **UX-TANK-01 (no-detention callout) and UX-TANK-02 (R1/D1 tags) — confirmed kept as built.** No code changed.
4. **UX-TANK-03 ("Annotate existing detention pit" gives a real record) — BLOCKED, not built.** `docs/workflows/CV-04_CDWT_WATER_TANKS_ONLY_ATOMIC_2026-09-13.md` records that Tim retired this exact mode from CDWT on 13 Sep 2026 ("water tanks only... the CV4-9 'annotate an existing detention pit' mode is NOT in CDWT... a detention-pit annotation tool needs its own card") and no command anywhere in the repo does this today (confirmed by search: `TryRunDetentionPitMode`/`BuildPitDetentionCalloutText`/`ResolvePitTag` are gone, only referenced in a retired-behaviour guard test and in docs). The 25 Sep ruling's "today it only annotates" framing does not match the live code — there is no live "annotate only" path either. Building a brand-new CDWT-style adopt-a-pit command from a one-paragraph ruling would skip AGENTS.md's mandatory command/workflow review gate (card + Tim's approval before code starts) and the "incremental, never big-bang" rule. **Question for Tim, not guessed at:** is this ruling for when the parked "its own card" (CV-04's words) gets built later, or does Tim want it built now as a new command? If now, it needs its own review-gate card first (ribbon trigger, prompts, Cancel/Escape/Undo, example drawings) per AGENTS.md.
5. **Evidence:** three Civil lanes 0 errors each; focused 54 passed/0 failed; `InspectorPaletteRenderTests` 20 passed/0 failed with new dark+light pictures `docs/image/V3_WINDOWS/inspector-{dark,light}-{pit-tank,live-pit-tank}.png`; full Civil net10 11,159 total / 11,134 passed / 6 failed (all match `PENDING_TESTS.md`'s baseline by name, no new failures) / 19 skipped. Full detail in the plugin repo's `REGRESSION_LOG.md`, UX-TANK-04 entry.
6. **Status:** code built, tested, pushed, draft PR open. Not installed, not Tim-accepted. AutoCAD acceptance steps are in the REGRESSION_LOG entry.
