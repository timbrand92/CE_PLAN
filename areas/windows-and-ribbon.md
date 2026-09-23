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

## HELP-SCROLL-20260924 — approved scrolling follow-up

1. **Tim, midnight 24 September (verbatim):** "I am happy to scroll in places when you would have to implement a next page button like in the help window i just dont want high use windows to have scrolling areas where the ui and ux could be designed far better". Supersedes the paging requirements in the earlier Help cards above.
2. **Approved Modify card:** each Civil guide section and shared task guide becomes one bounded scrolling reading area. Keep the fixed New Pipe shell, search, left section list, bookmarks, 2.1 honesty note, themes, close, launch gate and saved reading. Page Up/Page Down scroll the reading area. No engineering content or protected builder files change.
3. **In progress:** clean takeover of codex/ui-help, no uncommitted work found; origin/master merged at 100b200c retaining both regression histories. Re-render both themes, test navigation/reading restoration, run all three safe Release builds and unfiltered Civil net10 suite, then update PR #125. Code-only: no AutoCAD, install, deployment or PR merge.

4. **Built, 24 September 2026:** 54801c50 replaces paging in both Civil and shared Help. All 14 Civil sections and 50 topics scroll inside the fixed shell; all 54 bookmarks remain reachable. Shared reading resumes its saved offset. Browser checks 3/3, shared Help 45/45, actual Civil window render tests 2/2. All 64 current dark/light pictures inspected. Three Release lanes and full Civil suite now running; no installation or AutoCAD acceptance.
5. **Evidence learned:** reserve scrollbar width so reading text wraps; WebView2 is a native surface and needs CapturePreview pixels before RenderTargetBitmap can capture the real WPF shell with content. Light-theme evidence must set the actual window background/icon, not only replace a palette dictionary. Earlier -page-* and -tasks-* pictures are superseded by section/reading pictures. Undo is reverting 54801c50.

6. **Completed code-only follow-up, 24 September 2026 02:50 Melbourne:** PR #125 ready for review; codex/ui-help tip a651680b (code 54801c50), pushed with a clean leak scan. Three Release lanes each 0 errors. Unfiltered Civil net10: 10,595 passed / 11 failed / 19 skipped (10,625 CLI total; 10,606 executed). Failure names exactly equal the saved prior 11-failure baseline. Shared Help 45/45; browser 3/3; real Civil-window render 2/2, also passed in the full suite. All 64 inspected current images have unchanged hashes after the full run. No protected builder file changed. Not installed, no AutoCAD opened or PR merged, not Tim-accepted.
7. **Remainder:** representative native acceptance is consolidated in PENDING_TESTS.md. After release-owner installation, check scroll/keyboard, search, final section, Home/Escape and shared resume in 2027 and the 2024/net48 route. Current generated ribbon tour and older engineering guide corrections remain with behaviour owners; the 2.1 note is retained.

## REVIEW-SCHEDULE-20260924 — confirmed whole-window takeover

1. **Tim's scope, 24 September:** "BUILD A WHOLE WINDOW - layout AND the code behind it. Code only." Project Review (CDDASHBOARD), What CE Found and Pit Schedule dialogs and their own view models are assigned to codex/ui-review. "DO NOT OPEN AUTOCAD. DO NOT INSTALL. DO NOT MERGE." The specific instruction permits merging origin/master into this branch, but no PR merge.
2. **Approved Modify card:** retain existing check, navigation, proposal, CSV, pit row editing, source/set/system, difference review and placement commands. Fit New Pipe header/footer and fixed task tabs. Tim: "the schedule rows may scroll inside their own area"; replace Project Review finding pages with a bounded scrolling list too. Drawing labels identify objects. No command/service/rule behaviour is added.
3. **Takeover evidence:** worktree clean; no WIP commit needed. Merged origin/master 0de60b36 as 6e507cd5, keeping both regression histories. Initial safe test build found the missing native transform artifact; use the existing documented ProductionIntegration native build before restarting. Existing handoff claims will be rechecked.
4. **Validation/acceptance:** real compiled windows, STA RenderTargetBitmap, synthetic data, dark/light, 1080p scale 1; inspect every picture. Three safe Release lanes and full Civil net10 suite must meet the 11-known-failure gate. One PR; no native AutoCAD acceptance claimed. Later acceptance covers selection/highlight, row edits, placement/Undo, Escape and save/reopen on 2027 and 2024/net48.

5. **Built and checked, 24 September 03:34 Melbourne:** Project Review findings, What CE Found lists and Pit Schedule rows now scroll inside fixed task layouts. Pit Schedule has Source / Rows / Changes / Placement, three column views, explicit filtered-row and output-scope wording, and selected pit labels for secondary inlet rows. Existing editing, sorting, overrides, group menus and placement commands are retained. Targeted tests passed 65/65; final wording rerun and three-lane/full-suite gate remain in progress. Initial full suite was 10,679 passed / 11 exact baseline failures / 19 skipped.
6. **Evidence learned:** a root-window bounds check alone missed controls clipped by the tab viewport; tests now check tab bounds too. Inactive DataGrid selection needed explicit theme colours to keep text readable. Real compiled STA pictures exposed both defects and drove the fixes. Bounded-list tests reach the final schedule/finding row without changing output or selection identity. No service, command or protected builder file was authored by this takeover.
7. **Saved/pushed and build gate:** implementation commit af7dd32c; single draft PR https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/140. Global push hook clean with the local terms file present. Final targeted run 65 passed / 0 failed / 0 skipped. All 34 inspected compiled-window pictures committed. Final Release net48, net8.0-windows and net10.0-windows builds each report 0 errors; unfiltered Civil net10 suite is running. Undo: revert af7dd32c. No AutoCAD or bundle changes.
8. **DONE for the code-only brief, 24 September 2026:** PR #140 is ready for review; codex/ui-review tip 00fbda40 (implementation af7dd32c), pushed through the clean leak-scan hook. Final full Civil net10: 10,692 passed / 11 failed / 19 skipped, 10,722 total, 3 min 59 s. The 11 failure names exactly equal the inherited full-run baseline; all 65 targeted tests pass again in the full suite. All 34 inspected picture hashes stayed unchanged. All three Release lanes have 0 errors. No code gate blocker; not installed, no AutoCAD opened, no PR merged, not Tim-accepted. Native remainder is consolidated in PENDING_TESTS.md.

## CIVIL-HUB-UI-20260924 — Print fallback, approved whole-window brief

1. **Authority:** Tim: "BUILD A WHOLE WINDOW - layout AND the code behind it. Code only." "If it is CDCALC's Print tab ... take the next scrolling window ... nobody has rebuilt yet". Review item 15 explicitly identifies CDCALC Print; merged PR #139 owns it. After the excluded review/schedule windows, item 20 is Civil Hub (CDHUB). The classic Review ribbon calls it Civil Hub; the contributor calls CDHUB Proposals. No open PR owns this window.
2. **Modify workflow card:** keep refresh, finding selection/show/edit, Show all, Pit Schedule and Long profile hand-offs; keep Design impact and Network redesign, their selections, preview, approval, Apply and safety gates. Move finding actions to one selection pane; fixed New Pipe shell and task tabs; lists alone may scroll. Replace collapsed sketch and scrolling redesign setup with explicit tabs. Preserve every field and action; no service/command/rule or protected window edits. Escape closes without an action; Apply stays the existing one-Undo route.
3. **Tim's standing ruling:** "I am happy to scroll in places when you would have to implement a next page button like in the help window i just dont want high use windows to have scrolling areas where the ui and ux could be designed far better". Dark gold / light CE blue, plain drafting words, stable opening and footer. No new engineering behaviour.
4. **In progress:** codex/ui-print worktree clean at takeover, no WIP needed; fetch/merge origin/master reported already current at 53e1baf8. Own CivilHubDialog, its two embedded Hub pages and their view models, new tests and pictures. No AutoCAD, installation, deployment or PR merge. Real-window STA renders in both themes, three Release lanes and Civil net10 exact 11-failure comparison required. Later representative 2027/2024 acceptance: findings navigation, hand-offs, redesign approval/Undo, Escape and save/reopen.
5. **Saved/pushed:** implementation db4ffe78; draft PR https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/142. First focused Hub/host run 49 passed / 0 failed. Initial net10 Release build 0 errors. Real compiled pictures caught capture-margin cropping and unthemed footer buttons; corrected, with long-cell bounds guards added. Final render review, three safe lanes and full Civil net10 remain in progress. Revert db4ffe78 to undo. No protected builder source changed.

6. **Picture and interaction gate:** code/pictures saved as 9c226efc on codex/ui-print, PR #142 remains draft. Focused Hub/host checks 52 passed / 0 failed; 40 actual-window dark/light pictures inspected, 96 DPI. Escape closes every task without Apply; refresh revokes approval. Learned: embedded WPF pages must receive theme resources before InitializeComponent, and the inherited primary-button foreground needs a local theme-aware override on light blue. No shared theme edited. Final three lanes/full suite running; net48 already 0 errors. Undo by reverting 9c226efc then db4ffe78.

7. **Final code gate, 24 September 2026:** PR #142 is ready for review, codex/ui-print tip 49020240, tested code 9c226efc. Three Release lanes 0 errors each; full Civil 10,668 passed / 11 exact known failures / 19 skipped / 10,698 reported. All 52 Hub checks pass in the full run; all 40 inspected picture hashes unchanged. Leak scan clean and branch pushed. No protected source changed, no AutoCAD opened, no installation or merge. Native acceptance is consolidated in PENDING_TESTS.md. Existing Plan vs schedule / Xref destinations remain unavailable and labelled honestly, requiring separate service/command-owner work.

## DESIGN-WINDOWS-20260924 — whole-window brief

1. **Tim's authority, 24 September 2026:** "BUILD WHOLE WINDOWS - layout AND the code behind them. Code only." Order: CDDESIGN, CDRAINFALL, CDLPD; Import only if time remains. "DO NOT OPEN AUTOCAD. DO NOT INSTALL. DO NOT MERGE." Explicit exception: merge origin/master into codex/ui-design-windows, never rebase. Clean takeover; fetch/merge reports already current at c78a350d.
2. **Approved Modify cards:** Design retains the existing ordered workflow, all prerequisites, route choices, council figures and calculation service; fixed Setup / Areas and route / Results tabs, all prerequisites visible alongside. Rainfall retains current curve, file/clipboard input, shared parser, intensity preview and explicit confirmation for save or office fallback; fixed Current / Import / Review tabs. LPD retains object-or-point selection, all shared connection choices including Other, label-location prompt and no-write cancellation; fixed Connection / Drawing steps tabs. No engineering decisions duplicated; no command, service, rule or other builder window edited.
3. **Boundary found:** all three current commands run prompt chains and have no window hand-off. New windows and own models can be built/tested, but protected command integration and named Design ribbon routes must be routed to Claude in the PR. Existing command prompts stay working. CDDESIGN contract is docs/workflows/CDDESIGN_WINDOW_CONTRACT.md. Supplied review's relevant entries are walkthrough 16 and 22 plus Top Ten 3; walkthrough 14 is Levels, not ribbon design.
4. **Standing scrolling ruling:** "I am happy to scroll in places when you would have to implement a next page button like in the help window i just dont want high use windows to have scrolling areas where the ui and ux could be designed far better". Fixed New Pipe shell; bounded report/input text may scroll, forms never scroll. Dark gold/light CE blue, no teal. Real-window STA pictures, three safe Release lanes, full Civil exact 11-failure comparison. No native acceptance claimed.
5. **Built/saved, 24 September:** code cbe68716 plus rainfall read-safety follow-up 218b2394, codex/ui-design-windows, draft PR https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/146. Earlier focused runs passed 20/20 then 23/23. Eighteen real compiled dark/light pictures inspected: every task fits with fixed actions. Final three safe Release lanes and 25-case focused/full Civil runs in progress. No AutoCAD or installation. Undo: revert 218b2394 then cbe68716.
6. **Evidence learned:** this theme's ComboBox selection displayed class names with DisplayMemberPath alone; local ItemTemplate bindings fixed it without changing shared resources. A returned CivilDesignOutcome is not automatically a passing design; its CanProceed controls attention. The existing LPD Other prompt allows a blank note, so the new window warns but retains that allowance. Failed rainfall file/clipboard reads must revoke any earlier approval to avoid saving a stale candidate. The protected command connections are documented individually in PR #146; no commands were replaced or intercepted.
