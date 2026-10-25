# Independent PR review, group 14 — class E positions 61–75

1. **ANSWER FIRST — new findings: HIGH 0 / MEDIUM 1 / LOW 0.** Verdicts: **10 MERGE / 3 MERGE-WITH-FIXES / 2 HOLD / 0 REJECT**. All 15 already had Opus reviews; all current heads still match those reviews. Earlier findings are referenced below, not counted again.

2. **Most important: switching a support on a layout sheet can change unrelated labels in Model space.** #1564 checks nearby supports and labels in Model space even when the selected support belongs to a layout. Its new “nearest support” check cannot protect the other space. Change the earlier MERGE verdict to **MERGE-WITH-FIXES**.

3. **The other 14 verdicts stand.** Keep #1423 and #1521 on HOLD. #1457 still needs the earlier hidden-settings preservation fix; #1560 still needs visible notice when a note cannot be saved. Structural changes belong on the Structural release line, not the Civil + Manager colleague train.

4. **Evidence and limits.** The new fault is **verified-by-reading**, not observed in AutoCAD. No builds, tests, AutoCAD sessions, installations or sub-agents. All tests below are instructions for a later AI test run on synthetic copies; Tim is not being asked to test them.

---

1. **Scope and pinned evidence.** Reviewed on 26 October 2026, Melbourne time; filename retained exactly as requested. Selection comes from class E alone in `PR_PILE_TRIAGE_2026-10-24.md`: positions 61–75 are #1423, #1457, #1460, #1464, #1521, #1529, #1554, #1559, #1560, #1561, #1563, #1564, #1565, #1566, #1568. Read RULES, ROUTER, START_HERE, the plan map, the named 22 October audits, and the matching earlier review entries.

2. **Earlier reviews used.** [Batch 1](REVIEW_PILE_B1_24OCT.md), item 4; [batch 2](REVIEW_PILE_B2_24OCT.md), item 8; [batch 3](REVIEW_PILE_B3_24OCT.md), items 3 and 10; [batch 6](REVIEW_PILE_B6_24OCT.md), items 7–11; [batch 7](REVIEW_PILE_B7_24OCT.md), items 1–6. These are substantive reviews, unlike PR-number mentions in group boundary lists. I retained their verdicts except #1564. “Retained” below means reliance on that earlier substantive review plus current head/diff checks, not a claim to have repeated its entire audit.

3. **Git evidence.** Fetched the plugin origin; read every PR through `gh pr view/diff --repo timbrand92/CE_ACAD_PLUGIN`. Nominated Civil/Manager baseline: `40ee0a36f7960145743954b39859eb6c3af92869`; nominated Structural baseline: `2c9a96942a024888a5ab520600f2d5025de83036`. These are the brief's 3.0.70/1.1.70 and 1.0.121 comparison points, not a fresh claim about today's installed DLLs.

4. **C-63 has moved.** Its fetched head is `5467f7053a2e9275cb450409c142ef9aa26dad53`, labelled Civil 3.0.73 / Manager 1.1.73. Earlier reviews used `28987b73`. None of these 15 PR heads is an ancestor of either its nominated installed baseline or this C-63 head. Searches also find their new implementation identifiers absent there; #1529's old layer-changing path remains. This is stronger than ancestry alone. Later release trains and today's installed binaries are outside this comparison.

5. **Conflict method and release separation.** Used read-only three-tree `git merge-tree --trivial-merge`, with each PR's base/head to examine its delta against pinned C-63; no merge was performed. Per-item conflicts below concern that delta and its changed files. This is not an integration build or a semantic proof. Whole Structural branches have extensive unrelated history conflicts with Civil; do not merge them into C-63. Structural verdicts mean eligibility for the separate Structural line after stated fixes.

6. **Common safety check.** None of the 15 PR file lists changes CE_SHARED, Shared/, installer files or signed-update files. No installer HOLD is triggered by their own diffs. No new engineering constant or engineering-limit refusal was found in those diffs. #1423's new bug-fix switch starts ON; #1521 uses the existing ON source-edit switch; the other fixes have no new OFF switch. File-save protection and invalid-number validation must not be confused with an engineering compliance block.

7. **REDO and protected drawings.** No new automatic drawing write between U and REDO was identified in the reviewed deltas. Lookup/calculator changes are read-only; drawing changes in #1559/#1563/#1564 remain command-driven. #1566 enables existing startup services in another process: its earlier review explicitly leaves concurrent-service behaviour unproven. Do not turn that into an unconditional REDO or two-process safety certificate. #1564's inherited space/protection weakness is examined below; unchanged locked-layer/REFEDIT paths in the retained PRs were not exhaustively audited again.

8. **Read-only override and ownership.** The leading brief's no-branch/no-repository-file-change instruction takes precedence over the appended worktree/build/PR boilerplate. No plugin checkout, branch, worktree, source, drawing or settings file was changed. Git object reading and fetch were used directly. This session owns only `areas/CODEX_PR_REVIEW_GROUP14_24OCT.md` in CE_PLAN; BUG_CARPARK, DESK_LOG and QUEUE were not edited.

**One numbered item per PR**

1. **Position 61 — #1423 — HOLD. Head `da925637`. Retained; no new severity counted.**

   **For Tim / cause:** typed cover and other pit figures can disappear from the visible first row when another inlet is added or the outlet changes. The proposed pit/inlet matching addresses that cause on its own branch.

   **Evidence:** `Modules/Drainage/Services/PitScheduleOverrideMatcher.cs:40`; `ViewModels/PitScheduleViewModel.Schedule.cs:525`; ON default at `Models/UserSettings.cs:476`. Batch 3 item 10 already identifies the incompatible BUG-780 merged-row handling and interaction with #1629. I found no reason to overturn that HOLD.

   **Required fix:** rebuild the change on the intended Civil train, preserve BUG-780's old-key lending before this matcher, and compose it with restored-pit handle remapping. Add merged-row, re-found-pit and cleared-cover regressions. Do not resolve the conflict by dropping either behaviour. C-63 delta conflicts: UserSettings.cs, PitScheduleViewModel.Data.cs and REGRESSION_LOG.md. Not in either nominated Civil baseline/C-63.

   **DETERMINISTIC TEST — not run:** synthetic Civil DWG, pit P5 with two inlet pipes and one outlet. In Pit Schedule type cover 20.95 on P5's first row and save. Add a lower inlet, rebuild the schedule, then change the outlet and rebuild. Assert 20.95 appears once on P5's first row, inlet overrides follow their own pipes, and non-first rows have no pit cover override. Clear the cover, save and reopen: 20.95 must not return from an orphan record. Repeat using a merged row and a re-found pit. Existing matcher tests do not establish this combined train result.

2. **Position 62 — #1457 — MERGE-WITH-FIXES. Head `3feb0668`. Retained; earlier MEDIUM is not recounted.**

   **For Tim / cause:** Reset Defaults used to replace the whole settings object. Confirmation and a backup help, but this PR still resets settings that its question says will be kept.

   **Evidence:** `Modules/Structural/Services/SettingsResetPlanner.cs:17` starts with new defaults and copies selected groups; `UI/Dialogs/CeSettingsDialog.xaml.cs:465` promises to reset settings shown in the window. Batch 6 item 7 already records the 28 hidden groups and the incorrect treatment of the bearer table/Python path.

   **Exact fixes retained:** clone current settings, reset only explicitly shown fields/groups, and preserve hidden fields within shown groups too. Pin that promise with a preservation test. Reset the displayed bearer table/Python setting or expressly say they remain. C-63 delta conflicts: CeSettingsDialog.xaml.cs and REGRESSION_LOG.md; this is a Structural change, not a C-63 merge.

   **DETERMINISTIC TEST — not run:** isolated Structural profile with `CeMember.BreakOvershootPaperMm` changed from its default and an SBEAM favourite. CESETTINGS: change a visible Beam offset, click Reset Defaults, then No; assert all values unchanged. Repeat Yes; assert the visible offset resets, the configured CEMEMBER value and favourite remain, and a dated pre-reset copy exists. The earlier tests cover selected preserved lists, not every hidden field.

3. **Position 63 — #1460 — MERGE. Head `c5e28d8f`. Retained; no new finding.**

   **For Tim / cause:** one AutoCAD's routine settings save could put back an old value saved deliberately in another AutoCAD. The PR writes only this process's changed fields for routine saves.

   **Evidence:** `Modules/Structural/Services/SettingsService.cs:934`; `SettingsService.LoadRecovery.cs:968`; `SettingsRoutineMerge.cs:15`. The merge is repeated under the existing save lock. Batch 6 item 8's cause and verdict remain supported. Deliberate Save still writes the whole current copy; that earlier limitation remains.

   **Tests and safety:** the changed-field test distinguishes the old overwrite; an unchanged list remains untouched, a changed list is replaced whole. No drawing write or engineering default added. C-63 delta conflicts: SettingsService.cs and REGRESSION_LOG.md. Not in nominated Structural baseline; use Structural release line.

   **DETERMINISTIC TEST — not run:** start two AutoCAD processes against an isolated shared profile with Beam offset 10. In A, CESETTINGS sets it to 99 and Save. In B, use SBEAM to change only a remembered section choice, triggering routine persistence; do not click Settings Save. Read the actual settings JSON: offset must remain 99 and B's section choice must persist. Restart and assert CESETTINGS shows 99. Do not use this to claim B's in-memory settings refresh immediately.

4. **Position 64 — #1464 — MERGE. Head `5cd70fe3`. Retained; no new finding.**

   **For Tim / cause:** a mistyped number could be silently skipped while Settings closed as if saved. The PR checks the numerical boxes before copying any values and names the offending box.

   **Evidence:** `Modules/Structural/UI/Dialogs/CeSettingsDialog.xaml.cs:244`; `CeSettingsNumberBoxes.cs:11`; `Services/SettingsNumberText.cs:12`. Batch 6 item 9 covers the wording and known low-number clamping limitation. Cancel remains available. This is input validation, not a new engineering compliance refusal.

   **Tests:** number parsing and label mapping have tests; there is no new native-window evidence here. C-63 delta conflicts: Structural.Tests project file and REGRESSION_LOG.md. No installer/Shared change. Separate Structural train.

   **DETERMINISTIC TEST — not run:** isolated profile, CESETTINGS, Side 1 offset (North/West): type `1O0` using letter O and click Save. Assert the message names that displayed box, the window stays open and the settings-file value is unchanged. Enter 100, Save, reopen; assert 100. Repeat invalid input then Cancel: window closes without saving. Run the same visible check in both themes.

5. **Position 65 — #1521 — HOLD. Head `2273c237`. Retained; no new finding.**

   **For Tim / cause:** double-clicking the green downpipe label opens ordinary text editing. The PR resolves the label back to exactly one source and uses Edit source instead.

   **Evidence:** `Modules/Drainage/Services/CompoundEditModeService.cs:401`, `:671`; `SourceLabelOwnerProof.cs:17`. Batch 6 item 10 holds this for the recorded command-card requirement. Current plan searches still record that HOLD; no approval replacing it was found. This is a release-review hold, not a new hard block inside AutoCAD.

   **Safety/tests:** read-only owner lookup, existing ON switch, ambiguous ownership falls back to AutoCAD. Pure owner tests cannot prove native double-click target delivery. No fresh claim that the prior empty-selection bug is fixed. C-63 delta has no textual conflicts; this is stacked on the earlier downpipe edit work and is not in the nominated Civil baseline.

   **DETERMINISTIC TEST — not run, after the recorded gate is met:** synthetic Civil DWG with tagged DP1 and its green label, one ordinary TEXT and a second source. Double-click DP1's label: assert Edit source opens with DP1. Cancel: no text change or stray TEXTEDIT prompt. Double-click ordinary TEXT: native editor opens. Make two source records name the same label: native editor must remain. Repeat U, a single selection only, REDO with no intervening CE command; assert the undone line returns.

6. **Position 66 — #1529 — MERGE. Head `7bf04976`. Retained; already-audited fault excluded from counts.**

   **For Tim / cause:** placing a member could restyle every existing line on 18HIDDEN/9HIDDEN2. The early return now leaves an existing layer alone.

   **Evidence:** `Modules/Structural/Services/StructuralDetailService.cs:1956`. The PR removes the later existing-layer linetype assignment and avoids loading a linetype just to touch a kept layer. This is the fix for the 22 October audit finding, not a newly discovered fault.

   **Safety/tests:** removes writes, adds no switch or engineering number. Source guards distinguish the old assignment; native appearance remains untested here. C-63 delta conflict: REGRESSION_LOG.md only. Nominated Structural baseline still has the old assignment.

   **DETERMINISTIC TEST — not run:** mm fixture with 18HIDDEN and 9HIDDEN2 set to Continuous and existing lines on both. Place a CEMEMBER side and a Beyond section, then SBEAM. Assert both layers' linetypes and existing line appearance remain Continuous. Separate blank fixture: required missing hidden layers are created with their intended linetypes. One U/REDO must remove/restore only the accepted placement.

7. **Position 67 — #1554 — MERGE. Head `7f4f8c39`. Retained; no new finding.**

   **For Tim / cause:** an unloaded relative Xref could be labelled SOURCE MISSING. The fix resolves its path from the host DWG and retains separately named unavailable references.

   **Evidence:** `Modules/Drainage/Services/PitScheduleXrefDiscoveryCore.cs:149`, `:224`; `PitScheduleXrefDiscoveryService.cs:153`. Batch 3 item 3's verdict stands. This remains display evidence, not replacement drawing identity.

   **Tests/safety:** earlier review records failing base cases and inspected pictures; neither was rerun here. Read-only Xref/status work, no layer changes or new block. C-63 delta conflict: REGRESSION_LOG.md only. Fix absent from nominated Civil baseline/C-63.

   **DETERMINISTIC TEST — not run:** save synthetic host and source DWGs in one scratch folder. Attach source by relative path, create linked Pit Schedule, then unload the Xref through XREF. Open the schedule: assert SOURCE UNLOADED, not SOURCE MISSING. Attach two differently named unavailable references to the same source and assert two display entries. Reload: assert normal source status returns without a new source identity.

8. **Position 68 — #1559 — MERGE. Head `ab8980c8`. Retained; no new finding.**

   **For Tim / cause:** accepting regeneration then cancelling the slab-type question could erase the existing joints. The erase now waits until the type and usable grid are known.

   **Evidence:** `Modules/Drainage/Commands/CdJointCommand.cs:78`, `:116`. Batch 7 item 1 already covers this ordering change and the inherited silent skip of locked old joints; that issue is not recounted.

   **Tests/safety:** the erase-order source test would fail before the fix; the “only one erase” test alone would not. No idle path or engineering value changes. C-63 delta conflict: REGRESSION_LOG.md only. Not in nominated Civil baseline.

   **DETERMINISTIC TEST — not run:** synthetic slab with recorded joints and SC labels, retain handles and coordinates. CDJOINT, select slab, Yes to regenerate, Esc at Select slab type. Assert all old handles remain live and coordinates/counts match. Repeat with a valid type: replacement completes; one U restores the original set and REDO restores the replacement. Separately lock an old joint layer and record the already-known partial-replacement behaviour.

9. **Position 69 — #1560 — MERGE-WITH-FIXES. Head `0aed87a3`. Retained; earlier findings not recounted.**

   **For Tim / cause:** after a failed notes-file read, adding one note could replace earlier notes. The new guard protects that file, but the window still silently loses the attempted note when saving returns false.

   **Evidence:** `Modules/Structural/Core/Notes/SharedNotesManager.cs:1007`, `:1023`, `:1134`. AddNote forces a reload before save; inspection did not substantiate an additional cache-based overwrite in that route. Batch 7 item 2 already records the missing message and separate project-tags problem.

   **Exact fixes retained:** show failure in the browser's Add, Edit and Resolve routes, retaining/copying the user's entered text. Do not show success or discard the text. Keep the separate project-tags defect linked to its earlier finding, not a duplicate here. Tests verify malformed-file bytes survive; they do not cover browser feedback. C-63 delta conflict: REGRESSION_LOG.md only; Structural release line.

   **DETERMINISTIC TEST — not run:** isolated notes folder with `notes_data.json` containing incomplete JSON and recoverable earlier note text. Record exact bytes. CENOTES, Add a note containing `NEW CHECK`, OK. Assert original bytes unchanged and a visible failure message containing or preserving NEW CHECK. Repair the fixture JSON and retry: assert earlier notes plus NEW CHECK survive reopening. Repeat Edit and Resolve failure feedback.

10. **Position 70 — #1561 — MERGE. Head `81e64f7d`. Retained; no new finding.**

    **For Tim / cause:** picking a second pipe in Pipe Flows could retain the first pipe's grade and give the wrong flow. The PR remembers values CE supplied and releases those before the next pick.

    **Evidence:** `Modules/Drainage/ViewModels/PipeFlowCalcViewModel.cs:161`, `:194`, `:226`. Batch 2 item 8 records two base-failing cases and the typed-value control. No drawing mutation or new engineering constant; the existing fallback remains when a pipe has unknown grade.

    **C-63:** REGRESSION_LOG.md conflict only; implementation absent from nominated baseline/C-63.

    **DETERMINISTIC TEST — not run:** synthetic same-diameter pipes A at 1:50 and B at 1:200, same known roughness. CDCALC, Pipe Flows, pick A then B. Assert the grade box changes from 50 to 200 and the source note names B. Then type 300 and pick A: assert 300 stays. Compare the shown flow with the calculator run entered directly with identical diameter, roughness and 1:200; they must agree.

11. **Position 71 — #1563 — MERGE. Head `c571e917`. Retained; no new finding.**

    **For Tim / cause:** SBEAM picks in a moved UCS could be drawn near the World origin. All six placement/replacement picks now pass through the same UCS-to-World conversion.

    **Evidence:** `Modules/Structural/Commands/SbeamCommandRunner.cs:166`, `:193`, `:236`; `SbeamEditCommandRunner.cs:402`, `:421`. Batch 7 item 3's verdict stands. Section orientation in a rotated UCS remains a separate unresolved expectation; do not claim that this position-only fix solves it.

    **Tests/safety:** mathematical conversion and source-call guards do not simulate a host pick. Existing writers/protection stay in use; no new automatic writer or settings value. C-63 delta conflict: REGRESSION_LOG.md only. Separate Structural train.

    **DETERMINISTIC TEST — not run:** mm drawing, World UCS, move UCS origin to World 10000,20000,0. SBEAM, choose 310UB32 elevation, pick local 0,0 and 3000,0. Assert the saved/planned beam axis is World (10000,20000) to (13000,20000), not (0,0) to (3000,0). Repeat SBEAMEDIT cross-kind replacement picks. One U/REDO restores the exact placement; run a separate rotated-UCS case and record orientation without assuming it passed.

12. **Position 72 — #1564 — MERGE-WITH-FIXES, changed from MERGE. Head `ada6c648`. NEW MEDIUM, verified-by-reading.**

    **For Tim:** switch a support on a layout sheet and CE can erase, recreate and rotate unrelated support text in Model space. A label on the other space is not protected merely because the new nearest-support arithmetic is correct.

    **Exact failure scenario:** selected support belongs to Layout1 paper space. Its computed centre is (100,100,0). Model space contains no support blocks, but has ordinary DBText MODEL KEEP on SUPPORT TEXT at (200,100,0). The scan looks only in Model space, sees the text 100 units away, finds no competing support, and accepts it. The switch erases/recreates that text; accepting a rotation can move it too. Layout labels are not even considered.

    **Code proof:** `Modules/Structural/Commands/SupportBlockCommands.cs:469` calls only CommandPreFlight; `Services/DrawingSafetyService.cs:18` checks document/database/read-only, not owning space or REFEDIT. The selected block reaches capture at `SupportBlockCommands.cs:562`. Capture opens ModelSpace at `:1787` and passes that space into the new neighbour collector at `:1788`; the new rule returns true for no neighbours at `:1852`. Erase is called at `:564`; recreation opens ModelSpace again at `:1940`. The command wrapper and base context reader do not add a layout guard.

    **Attribution:** the ModelSpace scan/recreation predates this PR. This is an incomplete repair in the exact production path being changed, not an allegation that the PR introduced the old scanner. Batch 7 item 4 judged the protection sufficient without checking this case. Its test-only arithmetic is insufficient to justify that unconditional verdict.

    **Exact fixes:** collect labels and competing supports from the selected support's owning block record; preserve each label's owning space when recreating it. Do not pull Model-space labels into a layout operation. Validate editable ownership/REFEDIT state before writes and preserve protected labels without erase/recreate duplication. Add the cross-space case through the real capture/write route, not just the distance helper.

    **Test gap:** `Modules/Structural.Tests/Commands/SupportSwitchNeighbourTextTests.cs:24` uses (245,145) against centre (0,0), about 284.7 mm away. Production's capture limit is 260. That purported bug case is already excluded before the new rule on the old implementation. Keep the arithmetic test, but add an actual in-range pair, e.g. supports (0,0)/(200,0), text (155,145): about 212.2/151.8 mm respectively. The regression must show that the old production route changes the neighbouring label and the repaired one preserves it.

    **DETERMINISTIC TEST — not run:** synthetic mm DWG, World UCS, Layout1 active in PSPACE. Fixture contains a valid unlocked CE SUPPORT BLOCK NEW in Layout1, visibility 90 x 90, rotation zero, insertion (55,55,0), hence centre (100,100,0). This may be prepared by copying an existing valid support into paper space; do not rely on the support-placement command, which has a different preflight. Model space contains only the named DBText MODEL KEEP at (200,100,0), height 2.5, layer SUPPORT TEXT, no Model-space supports. Record its handle and owner before the run.

    **Typed steps/assertions:** type SDS, pick the Layout1 support, accept a 90-degree rotation in its preview. Assert MODEL KEEP retains the same live handle, position, rotation, owner and text; no replacement MODEL KEEP entity appears. The current code predicts its original handle is erased already during the switch, before rotation. Add a layout-owned support label as a second case: only that label may follow the selected support. Repeat with protected label layers and during REFEDIT; assert foreign/protected entities remain unchanged. Check one U and REDO without an intervening writing command.

    **Release fit:** no new OFF switch, engineering number, installer or Shared change. C-63 delta conflict: REGRESSION_LOG.md only. The defect and fix belong on the Structural line. Native event/transaction outcomes remain untested; the cross-space selection of labels is directly established by the source.

13. **Position 73 — #1565 — MERGE. Head `51a01fcc`. Retained; no new finding.**

    **For Tim / cause:** CEFIND did not recognise P1A or an office pit name such as C2. It now accepts suffixed P numbers and checks other names against recorded pits.

    **Evidence:** `Modules/Drainage/Commands/CeFindCommand.cs:80`; `Rules/CeFindQuery.cs:80`; `Rules/CeFindFlow.cs:22`. Batch 1 item 4 already records the source-tag-name precedence limitation. It is not counted again.

    **Tests/safety:** P1A distinguishes the old parser. Read-only lookup, no new settings, layer writes or engineering limit. C-63 delta conflict: REGRESSION_LOG.md only; absent from nominated baseline/C-63.

    **DETERMINISTIC TEST — not run:** synthetic Civil record with uniquely named pits P1A, C2, C3 and one pipe C2–C3. Type CEFIND P1A, then CEFIND c2, then CEFIND C2-C3 on separate runs. Assert the selected/highlighted entity handle is respectively the recorded P1A pit, C2 pit and connecting pipe, with no “not in this drawing” message. Use an ordinary known source tag as a control.

14. **Position 74 — #1566 — MERGE. Head `753d90bd`. Retained with earlier concurrency limitation; no new finding.**

    **For Tim / cause:** the second AutoCAD could skip Structural startup because both processes shared one guard name. Including the process number allows both to start while retaining the duplicate-load check inside one process.

    **Evidence:** `Modules/Structural/Plugin.cs:454`; `Services/PluginRuntimeMutexName.cs:12`. Batch 7 item 5's verdict stands. Its unresolved concern about simultaneous timers, settings and notes is not a proved additional defect and is not counted here.

    **Tests/safety:** tests use different mutex names in one process; they do not run two AutoCADs. No engineering setting or installer change. Existing startup services are newly reachable in process two, so they still need the stated native check. C-63 delta conflict: REGRESSION_LOG.md only; Structural line only.

    **DETERMINISTIC TEST — not run:** isolated shared profile, launch two separate AutoCAD processes. In each, run CESTRUC and open the Structural ribbon. Assert both open and process two does not print “Another plugin runtime is already active”. Attempt the duplicate-runtime fixture inside one process: assert its guard refuses a second runtime. Run a controlled five-minute same-job interval and read the saved timer total against actual active time; check interleaved note saves and #1460's settings case. Timer correctness is **suspected/unproven**, not certified by the mutex test.

15. **Position 75 — #1568 — MERGE. Head `59623e91`. Retained; no new finding.**

    **For Tim / cause:** swapping sheet numbers could point both sheet rows to one DWG and archive the other. The PR captures each drawing's rows and issue snapshots before changing any paths.

    **Evidence:** `Modules/Structural/Services/CeSheetsSyncService.cs:515`, `:531`. Batch 7 item 6's verdict stands. Its inherited partial-failure rollback limitation is not counted as a new finding.

    **Tests/safety:** the existing swap test checks file contents, both row paths and no archive; those assertions distinguish the original sequential matching bug. No drawing idle callback, engineering value or new block. C-63 delta conflict: REGRESSION_LOG.md only; Structural release line.

    **DETERMINISTIC TEST — not run:** scratch sheet project with S01.dwg containing text FIRST and S02.dwg containing SECOND; each has its own manifest row and issue snapshot. In CESHEETSCLASSIC swap sheet numbers and apply drawing updates. Assert each original row/snapshot follows its own file contents, paths remain distinct, and neither live drawing is archived. Repeat a three-way rotation and an ordinary rename. Separately inject a file-move failure for the known rollback limitation; do not label that case passed from the normal swap test.

---

1. **Summary — under 100 words.** Fifteen existing reviews were checked against unchanged PR heads and the current C-63 comparison. Fourteen verdicts stand. #1564 needs an owning-space fix and a production-path regression: switching a layout support can still alter Model-space labels, while its headline test lies outside the real capture radius. New counts are zero HIGH, one MEDIUM, zero LOW. Totals are ten MERGE, three MERGE-WITH-FIXES and two HOLD. No build, test or AutoCAD run occurred. Only this findings file is authored.

