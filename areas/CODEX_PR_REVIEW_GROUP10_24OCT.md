# Independent draft PR review, Group 10 — 24 October 2026

**FOR TIM — ANSWER FIRST**

1. **Eight remaining delivery faults: HIGH 1, MEDIUM 5, LOW 2.** These are faults or missing connections at the reviewed PR heads, not eight faults newly introduced by those PRs. They are verified by reading; none was run in AutoCAD.

2. **Most important — #1013 can still draw the wrong column.** With C1 listed at two sizes, it says it will ask which size to draw, then skips the question and uses 89 SHS. For example, a floor needing 75 SHS still gets 89 SHS.

3. **Verdicts: MERGE 3; MERGE-WITH-FIXES 8; HOLD 2; REJECT 2.** MERGE means suitable for the relevant product's code line, subject to the recorded native checks. It does not mean installed, tested or accepted. Structural branches must stay out of the Civil + Manager C-63 train.

4. **Another fix that does nothing where it matters — #988.** The short-pipe explanation is created after the window's rows have already been saved. The results window reuses those old rows, so the promised explanation still never appears.

---

**Technical scope and evidence**

1. **Exact selection.** Positions 1–15 within class E of `areas/PR_PILE_TRIAGE_2026-10-24.md:967`: #987, #988, #989, #998, #1004, #1005, #1008, #1011, #1012, #1013, #1014, #1016, #1018, #1024, #1026. Read the nominated 22 October audit and the three CODEX_AUDIT reports; their existing findings are not recounted here.

2. **Earlier reviews.** Searched `areas/REVIEW_*.md` and `areas/CODEX_PR_REVIEW_GROUP*.md` for all 15 PR numbers. Only `REVIEW_PILE_B4_24OCT.md` referred to #1024, as #1207's dependency; it expressly says #1024 was not reviewed in full. No earlier verdict on these 15 was found in those files.

3. **Pinned evidence.** Fetched origin; read each PR with `gh pr view/diff --repo timbrand92/CE_ACAD_PLUGIN`, then traced Git objects. Civil/Manager reference: `40ee0a36f7960145743954b39859eb6c3af92869`; Structural reference: `2c9a96942a024888a5ab520600f2d5025de83036`; C-63 comparison: `28987b73548da07bbd5f4215f44b917755955367`. “Installed” below means the brief's nominated source reference; live bundle DLLs were not inspected. The triage itself names newer installed releases, so this report does not assert the current machine version.

4. **Isolation and limits.** Used detached, unpopulated worktree `C:\ce-cx\review-group10-24oct`; no branch, checkout of source files, code edit, build, unit test, AutoCAD, installation or sub-agent. Merge checks used `git merge-tree --write-tree --name-only`: Git object simulation only, no working-tree merge. All deterministic tests below are NOT RUN and are instructions for the later test lane, on synthetic copies, on 2024/net48 and 2027/net10.

5. **Common release checks.** None of the 15 PR's own diff touches CE_SHARED, installer or signed-update files. No incremental change adds an engineering refusal/hard block. New numerical engineering controls and switches are discussed individually. Native locked-layer/Xref/REFEDIT protections remain mandatory; an unchanged old guard is not a newly proven protection. The two R-27 exceptions are not expanded by this review.

6. **C-63 warning applying to items 7–15.** A full merge of EACH Structural head into C-63 produces 168 conflict messages, including `Installer/ReleaseAuthorityPackaging.cs`, `Installer/SafeBundleInstaller.cs`, `Installer/build_installer.ps1`, `ReleaseAuthority/Program.cs` and `Shared/CE.Release/OfficialReleaseGate.cs`. This is inherited branch divergence, not those small PRs editing the installer. **HOLD that cross-product merge.** Their individual verdicts below apply to the Structural line. Structural-to-Structural simulations are also reported.

7. **Test discipline.** For every drawing-changing case, finish the operation, type `U`, wait 10 seconds without another drawing-changing command, then `REDO`. Assert the same entities/values return and the baseline survives. Inspect values after REDO; do not insert LISP probes between U and REDO. Also repeat with a named output/target layer locked, a synthetic attached Xref and an active REFEDIT: assert no protected entity is changed and no layer is unlocked. Where a specific protection is unproven below, this remains an outstanding check, not a PASS.

**One item per PR, in class-E order**

1. **#987 — MERGE-WITH-FIXES — MEDIUM, verified-by-reading.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/987), head `33d4d05e`.

   **For Tim / failure scenario:** A detention tank at exactly 45° can still turn to 0° when only its number is changed. The same boundary exists at 135°, 225° and 315°. The promise to preserve an unchanged angle is incomplete.

   **Evidence:** `Modules/Drainage/Commands/PitEditCommand.cs:2012` correctly replaces stale stored orientation with the block's orientation. However `:2079` allows rotation when the difference is **at least** 45° minus a tolerance. `:2174` rounds to the nearest quarter turn. An unchanged 45° tank therefore passes the “turn wanted” test; `:2114` sets its rotation. This is the remaining boundary of the real stale-record/rounding cause, not an invented new cause.

   **Exact fix / test quality:** Compare the accepted orientation/rotation with the values presented when this edit opened; preserve the original drawn angle if those inputs did not change. Do not infer user intent from a 45° distance. Existing tests cover 12°, 30°, 75°, 190° and -20° but omit the halfway angles. Add all four halfway cases through the save path, plus an intentional change of side.

   **DETERMINISTIC TEST:** Synthetic mm drawing with CE detention pit D1 at 45°, grate and solid sides distinguishable, and its CE record deliberately containing the old 0° default. Type `PITEDIT`, select D1, change only number to D2, Save. Assert BlockReference rotation remains exactly 45°, and side positions are unchanged. Repeat at the other three halfway angles; then explicitly choose a different orientation and assert it changes.

   **Safety / integration:** No new switch; fix runs whenever editing. No new engineering value (the angular tolerance is an edit-intent heuristic). Existing Civil preflight contains REFEDIT protection; the rotation write does not force-open locked layers. Cancellation initialisation is not certified REDO-safe by these helper tests. Not present in the nominated Civil source. C-63 conflicts: `PitEditCommand.cs` and regression log; preserve newer pit-edit fixes while resolving.

2. **#988 — MERGE-WITH-FIXES — MEDIUM, verified-by-reading.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/988), head `607a636c`.

   **For Tim / failure scenario:** The import results still omit the explanation for a short pipe whose far end was left open. Length display is added, but the important explanation is not connected to the results stage.

   **Evidence:** `Modules/Drainage/Commands/LinkCommands.ImportXcivil.cs:166` builds and caches immutable review rows during confirmation; `:219` later copies those same rows into results. `Services/XcivilImportService.cs:853` invokes confirmation before insertion at `:1181`. The only production assignment to `FarEndKeptOpenNote` is in `Services/XcivilPipeInsertionService.cs:712`, during insertion. The new reader at `LinkCommands.ImportXcivil.cs:291` therefore runs too early.

   **Exact fix / test quality:** Return the final per-pipe import outcomes to the command and rebuild result rows after insertion. Keep preliminary schedule rows separate. The existing test pre-populates the note before calling the row builder, which bypasses the real failure. Add a pipeline/presenter test that starts with an empty note, supplies the note during insertion, and checks the final window model. Preserve LandXML wording and C-63's box-size and changed-source checks.

   **DETERMINISTIC TEST:** Synthetic source DWG with scheduled pit P8 and a recognised 1,680 mm pipe whose two endpoint candidates both resolve to P8, but whose geometry remains a real line. Use `CDIMPORTXCIVIL`, choose that file, accept the schedule. Confirm `CDIMPORTXCIVIL_LAST_REPORT.txt` contains “CE left its other end open”. Assert the results window contains a “Note: pipe” row with that same sentence, and the pipe row says “1.7 m long”. The report sentence is the control proving this exact insertion branch ran.

   **Safety / integration:** Presentation-only changes, always active, no new writer or engineering setting; 1,000 is a unit conversion. Existing import protection/REDO behaviour is not changed or validated by this PR. Absent in nominated installed source. C-63 conflicts in `LinkCommands.ImportXcivil.cs` and regression log.

3. **#989 — MERGE-WITH-FIXES — no additional counted fault.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/989), head `8f90b09e`.

   **Cause / effect:** The early binding cause is real at this old base: New Pipe can resolve pits against another drawing's in-memory record. The added call at `Modules/Drainage/Commands/CdCommand.cs:63` precedes picks. However that call is already present in nominated Civil/C-63 at `CdCommand.cs:68`. The warning-text fixes are still absent: nominated Civil `CdCommand.cs:1064` and `PipeEditCommand.Update.cs:600` print raw `w.Message`.

   **Exact integration fix:** Keep the installed binding and port just the two `CommandLineText.Plain(w.Message)` changes and appropriate tests. Resolve the C-63 `CdCommand.cs`/regression-log conflicts without inserting the bind twice. Not wholly redundant.

   **Safety qualification:** “Writes nothing” only describes the target drawing in the binding helper. At PR head `Services/ProjectDataService.Mutations.cs:252` it can flush a pending save to the previous drawing. That inherited cross-drawing writer was already covered by the earlier Civil audit and is not counted again. The ASCII text change adds no drawing write, switch, hard block or engineering constant; native protection stays unchanged.

   **Tests / DETERMINISTIC TEST:** The bind-order source check fails when the call is absent; the warning call-site checks fail without formatting. Synthetic drawings A and B: B has recorded pits P10 and P9. Run a CE command in A, switch to B, type `CD`, pick P10 and P9, Enter. Assert New Pipe names both ends. For a 10 m, 225 mm UPVC pipe set both invert levels to 18.500 m; assert the command line includes “Pipe is essentially flat - no measurable fall”. Also cancel before creation with pending work in A and record whether A was written; do not claim REDO safety from the helper's name.

4. **#998 — REJECT as a release candidate — no additional counted fault.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/998), head `a6a89554`.

   **Cause / scope:** The author correctly calls the cross-drawing explanation a hypothesis. This experiment does not prove why AutoCAD lost REDO. `Modules/Drainage/Models/UserSettings.cs:780` defaults `RedoHoldOtherDrawings` OFF; `Services/RedoWindowGuard.cs:435` clears every remembered window on a command in any drawing. Its tests deliberately assert that policy rather than an AutoCAD outcome.

   **Why reject:** The nominated Civil source already has `DeferAnywhere` at `Services/RedoWindowGuard.cs:505`, which parks work under the drawing whose Undo window holds it. Bringing the old optional experiment into that newer mechanism adds competing policy and starts OFF, contrary to this brief's bug-fix requirement. The prior audit already discusses guard lifecycle/command-start risks; those are not new findings here.

   **DETERMINISTIC TEST:** Two synthetic drawings, B containing a CE pipe. In A draw a circle, type `U`; switch tabs to B, then A; type `REDO`. Assert the circle returns and “Everything has been redone” is printed. Repeat with a benign read command in B and with the Inspector open. Capture CE write logging between U and REDO. A registry unit test is not a substitute.

   **Safety / integration:** No entity/layer/Xref writer in this diff, no engineering number; hold callbacks can lead to existing writers, so native REDO remains unproven. Its exact OFF switch is absent in installed code, but the broader intended hold already exists. C-63 conflicts in `Models/UserSettings.cs` and regression log. Leave the PR untouched; use the newer guard's targeted native test.

5. **#1004 — MERGE-WITH-FIXES — no additional counted fault.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1004), head `7c2630c2`, stacked on #1002.

   **Cause / scope:** The old background readers contain ordinary transactions. This is a real code path; assigning it as the sole cause of BUG-558 remains suspected. Two parts are already superseded: nominated Civil/C-63 `CivilBackgroundXrefReader.cs:59` and `PitScheduleHostInstanceService.cs:97` read open-close unconditionally.

   **Remaining useful change / exact fix:** `Modules/Drainage/Services/PitScheduleXrefDiscoveryService.cs:39` still constructs `XrefReads(ReadSourcePath, ReadProjectRecord)` in nominated Civil/C-63. Port the PR's change to the open-close delegates there. Keep the newer unconditional host/path reads; do not replace them with the PR's conditional ordinary-transaction fallback. The installed guard already supplies `IsOpenAnywhere`; do not re-merge the old #1002 stack merely to obtain it.

   **Tests / DETERMINISTIC TEST:** Source tests detect the changed delegates, but the host test also insists an ordinary transaction remains; revise that obsolete assertion. Fixture: host H with a Pit Schedule sourced from an attached synthetic Civil Xref X. Open Project QA and record the findings; draw a circle, `U`, switch tabs away/back, wait 10 seconds, `REDO`. Assert the circle returns, QA still reads the same Xref pits, and the source Xref file's hash is unchanged. Test with X's source layers locked and during REFEDIT.

   **Safety / integration:** The changed readers request ForRead; no engineering values, new switches, hard blocks or layer changes. No native result claimed. C-63 conflicts in `CivilBackgroundXrefReader.cs`, `PitScheduleHostInstanceService.cs` and regression log; the remaining discovery line itself is still useful.

6. **#1005 — REJECT as superseded — no additional counted fault.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1005), head `6d7733d7`, stacked on #1002.

   **Evidence / effect:** `Modules/Drainage/Services/BlockService.cs:268` adds a conditional open-close dynamic-block-name read. Nominated Civil and C-63 `BlockService.cs:267` already use open-close unconditionally. Reintroducing the conditional version would restore ordinary reads when the guard is closed, with no new benefit.

   **Test quality / DETERMINISTIC TEST:** Its source test requires both transaction kinds, so it rejects the better installed implementation. Replace that expectation only if maintaining the test separately. Synthetic host with dynamic CE pit P1: keep Inspector open, draw a circle, `U`, mouse-click P1, wait 10 seconds, `REDO`. Assert the pit type is unchanged in Inspector and the circle returns. This also avoids treating a typed selection script as proof of a mouse-click path.

   **Safety / integration:** Read-only, no engineering values, switch, layer/Xref writer or new block. Native REDO still needs the stated test. Exact PR head is not an ancestor of installed code, but its useful behaviour is already present more broadly. C-63 conflicts in `BlockService.cs` and regression log. No merge recommended.

7. **#1008 — MERGE on Structural — no remaining counted defect in the row-count fix.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1008), head `d30d5a0f`.

   **Real cause / evidence:** `Modules/Structural/Services/ScheduleService.cs:378` supplies item count plus two to all three builders (`:382`, `:420`, `:528`). Their title is row 0, headings row 1, items begin at row 2 (`:403`). The old items-plus-one allocation is genuinely short and remains in nominated Structural at `:384`, `:422`, `:572`.

   **Test quality:** Arithmetic tests and negative source checks fail without the helper/fix, but the reported initial compile failure is not a native Table test. The implementation matches the actual loops, not merely its helper tests.

   **DETERMINISTIC TEST:** Synthetic mm fixture with exactly one AB brace, one CE bored pier and one tie-down; type `STRSCHEDCREATE`, pick `0,0`. Assert three tables, each with title, headings and its one data row (three rows total), and no error. Repeat with four braces; bracing table must contain six rows and all four handles. Then U/REDO as in the common recipe.

   **Safety / integration:** Always active; no switch, engineering default or new writer route. New tables use existing write transactions, never force-open locked source objects. The inherited create path's preflight checks read-only state but does not itself establish complete REFEDIT protection; that native case remains unproven and must be recorded before installation. Not installed in the nominated Structural source. Structural merge simulation conflicts only in regression log; C-63 direct merge HOLD under the common warning.

8. **#1011 — MERGE on Structural — no remaining counted defect in clearing spare rows.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1011), head `ba61da8b`.

   **Real cause / evidence:** `Modules/Structural/Services/ScheduleService.cs:618` and `:649` clear all cells after the current bracing/pier list. ScanFromDrawing runs before update at `:328`; `UtilityCommands.cs:83` calls that actual refresh route. The unmodified sync skips a blank handle at `ScheduleService.cs:661`. Nominated Structural still lacks these two cleanup loops.

   **Test quality:** The new tests prove the first spare index and look for the helper in both methods. They would not detect a loop whose bounds never execute. Add or retain the later actual-table deletion case; source reading supports the fix but is not a native PASS.

   **DETERMINISTIC TEST:** Fixture has four AB braces, four bored piers and already-created schedules with four data rows each. Erase one brace and one pier. Type `STRSCHEDREFRESH`, select the table titled “BRACING SCHEDULE”; repeat on “BORED PIER SCHEDULE”. Assert three occupied rows and one wholly blank row, including its handle cell. Repeat after erasing the last three. Assert no erased handle returns after `STRSCHEDSYNC`. Test refresh U/REDO separately before running sync.

   **Safety / integration:** Writes occur in the explicit refresh command, not a newly added idle callback; normal ForWrite does not force locked layers. REFEDIT admission is an inherited gap to test, not certified by this PR. No switch or engineering constant. Structural conflict in `ScheduleService.cs` plus regression log: retain newer pier columns/map handling and add the two cleanup loops. C-63 direct merge HOLD.

9. **#1012 — MERGE-WITH-FIXES on Structural — LOW, verified-by-reading.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1012), head `597439fb`.

   **Cause / benefit:** Roof trusses really reach this panel: `Commands/BracingCommands.cs:330` writes BT1/BT2 into attribute A, and `Services/ProjectDataService.cs:318` reads A as Type. `Structural.DesignCore/BracingPanelCalculator.cs:65` now excludes BT-prefixed types before summing. That fixes the false wall-bracing total.

   **Remaining fault / exact fix:** `Modules/Structural/Models/UserSettings.cs:729` exposes `PanelCountsRoofTrusses`, but no Settings window control reads/writes it. Add the corresponding labelled control with the engineering consequence stated plainly, or remove the unused rollback option and keep the wall-only rule unconditional. The fix is correctly ON by default: the inverse “count roof trusses” option is false. Do not mistake that false for a disabled bug fix.

   **Tests / DETERMINISTIC TEST:** Existing calculator test genuinely distinguishes 2,700 mm wall bracing from the old 6,700 mm sum; not merely a compile-only test. Fixture: NS A brace 2,700 mm and NS BT1 truss 4,000 mm, required NS 5,000 mm. Type `CSBRACINGPANEL`; assert NS provided 2,700 mm and insufficient, not 6,700 mm/sufficient. Open `CESETTINGS`; assert the named counting option is available, then toggle it and assert the documented total. Restore the original setting afterwards.

   **Safety / integration:** Panel scan uses open-close reads; this change writes no entities, so locks/Xrefs/REFEDIT are not newly bypassed. No fixed engineering number added. Not installed. Structural conflict in UserSettings plus log. Also conflicts with #1026 in calculator and panel service: preserve both roof filtering and unit conversion with explicit named parameters. C-63 direct merge HOLD.

10. **#1013 — MERGE-WITH-FIXES on Structural — HIGH, verified-by-reading.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1013), head `42a0f493`.

    **For Tim / failure scenario:** With C1 scheduled at 89 SHS on one floor and 75 SHS on another, CE prints “so CE asks which one to draw here”, but asks only for the insertion point. It draws its built-in 89 SHS size.

    **Evidence:** `Modules/Structural/Commands/SupportBlockCommands.cs:68` constructs C1 without `requiresVisibilitySelection`, whose default is false at `:36`. The new ambiguity branch at `:248` clears `scheduleRow`. The fallback starts with `cfg.Visibility` at `:255`, then prompts only if `cfg.RequiresVisibilitySelection` at `:262`. Thus the new diagnostic does not make C1 ask. The duplicate-size detection itself in `Services/MemberScheduleService.cs:51` is sound.

    **Exact fix / test quality:** Make ambiguity explicitly request a supported size regardless of the command's ordinary prompting flag. Resolve the chosen schedule size to a real block state; if unavailable, explain it and obtain an explicit alternative instead of silently using the built-in size. Test C1 and C2 through the command decision/prompt path. Current tests check a distinct-size list and source words, so pass with this fault.

    **DETERMINISTIC TEST:** Synthetic drawing with active member-schedule rows C1=89 SHS and C1=75 SHS, using a support definition containing both states. Type `C1`. Assert a size question occurs before “Specify insertion point”. Choose 75 SHS; place at `0,0`, finish rotation/label prompts. Assert the new block's visibility/size is 75 SHS. Repeat C2 with two supported sizes; Cancel at the size question must add no support. This fails at the question on the reviewed head.

    **Safety / integration:** Existing support entry checks model/REFEDIT state and locked output/text layers. New code only reads schedule data and changes selection; no new switch or hard block. Existing hard-coded fallback 89 SHS is specifically what the incomplete fix still selects. Not installed. Structural merge conflicts only in regression log; C-63 direct merge HOLD.

11. **#1014 — MERGE-WITH-FIXES on Structural — LOW, verified-by-reading.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1014), head `aca6a37c`.

    **Cause / benefit:** `Modules/Structural/Services/TimberSubfloorService.cs:79` now describes starter dimensions honestly; `:443` returns “Unknown” when the offer is disabled. The actual spacing and size values already come from Settings, with controls in `UI/Dialogs/CeSettingsDialog.xaml.cs:145`. They are not newly hard-coded here.

    **Remaining fault / exact fix:** The new `Models/UserSettings.cs:1579` `OfferStarterSizes` option has no Settings control. Add it to the existing Timber subfloor page, load and save it, and show that OFF makes unentered sizes Unknown. The wording fix is always active; default true means starter sizes remain offered, not that the warning fix is OFF.

    **Tests / DETERMINISTIC TEST:** Current tests verify SizeDefault and literal question strings, not a usable Settings route. Synthetic 6,000 by 6,000 mm closed rectangle; type `CSSUBFLOORSET`. Assert the offer switch is visible. Turn it OFF, Save; run `CSSUBFLOORGRID`, select that rectangle, pick joist direction `0,0` to `1000,0`, accept spacing defaults, press Enter at both size questions, answer Yes to Apply. Assert the bearer/stump labels say Unknown. With ON, assert each starter question says assumed/not checked and configured sizes are offered.

    **Scope / safety:** This PR improves the questions; it does not add an Assumed status to the resulting plan labels (`TimberSubfloorService.cs:111`, `:118`), so do not claim the whole assumption problem closed. Existing drawing/locking/REFEDIT behaviour is unchanged; the thin command forwards directly to the service, so native protection is not certified here. No new hard block. Not installed. Structural merge conflicts only in regression log; C-63 direct merge HOLD.

12. **#1016 — MERGE on Structural — no remaining counted defect in the preview fix.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1016), head `6f528e83`.

    **Real cause / evidence:** Old preview used a circle and the built-in size; Accept used a square and the configured size. `Modules/Structural/Services/LintelProposalService.cs:121`, `:315`, `:341`, `:370` and `:401` now use the same chosen size, drawing-unit conversion and four square corners. The nominated Structural source still has the old circle.

    **Test quality:** Coordinate tests exercise real square arithmetic; source tests ensure the preview calls it. They do not render the transient. No claim of visual acceptance.

    **DETERMINISTIC TEST:** Synthetic mm fixture with one recognised unsupported beam end at `1000,2000`, producing one stud-support proposal and no existing support. Isolated test Settings: proposal feature ON, SupportSizeMm=200. Type `CSLINTELPROPOSE`. Assert the grey preview has four corners at (900,1900), (1100,1900), (1100,2100), (900,2100). Accept that proposal and final Yes. Assert the permanent square has exactly the same corners. Repeat in a metre fixture with converted coordinates; repeat Cancel and assert no permanent entity. Capture the actual preview for independent visual checking.

    **Safety / integration:** Feature gate is inherited OFF; this PR adds no separate OFF bug-fix gate. Do not enable the whole proposal feature just to ship its geometry correction. REFEDIT/read-only checks occur before preview; locked output layers are skipped and source Xref blocks excluded. No engineering size is newly hard-coded. Structural conflict only in regression log; C-63 direct merge HOLD.

13. **#1018 — MERGE-WITH-FIXES on Structural — MEDIUM, verified-by-reading.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1018), head `65d5d8b0`.

    **For Tim / failure scenario:** Entering 31/09/2026 still silently becomes today's date. The new warning exists only as a helper; no window or issue operation calls it.

    **Evidence:** Git search in production finds only the declaration `Modules/Structural/Services/CeSheetsIssueService.cs:130`. `:138` continues to normalise invalid dates to today. `UI/Dialogs/CeIssuePublishDialog.xaml.cs:195` and `:281` still use normalisation without calling the warning. The author's “engine only” qualification is honest, but this is not a delivered bug fix.

    **Exact fix / test quality:** Connect the warning to both issue entry routes and the publish preview using the exact date selected for that operation. Display it once, without a new hard block. Add a window/presenter test entering an invalid date and observing the displayed warning. Existing tests call the unused helper directly and cannot catch the disconnect.

    **DETERMINISTIC TEST:** Synthetic sheet manifest with one managed Structural sheet S01, included in issue, valid revision A. Type `CESHEETS`, open Issue, enter 31/09/2026, click “Record this issue”. Assert visible warning quotes the rejected date and the replacement Melbourne date; inspect the saved issue record for that same replacement date. Repeat the “Publish issue PDFs” preview and the classic route `CESHEETSCLASSIC`; a warning must appear before proceeding. No PDF generation is necessary to check the preview.

    **Safety / integration:** No new drawing writer, switch, engineering constant or hard block in this PR; existing publishing safety remains outside its helper test. Not installed. Structural conflict in `CeSheetsIssueService.cs` plus regression log; retain newer sheet-inclusion/revision handling. C-63 direct merge HOLD.

14. **#1024 — HOLD — MEDIUM delivery gap, verified-by-reading.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1024), head `22914140`.

    **For Tim / failure scenario:** With normal defaults, another job still receives the previous job's required-bracing figures. The new drawing storage works only behind an OFF option that is absent from the Settings window.

    **Evidence:** `Modules/Structural/Models/UserSettings.cs:726` defaults `RequiredStoredInDrawing` false. `Services/BracingPanelService.cs:23` consequently resolves from per-PC settings; `Commands/BracingPanelCommands.cs:96` keeps the old write route. With ON, `Core/JobRecord/JobRecordStorage.cs:19` reads the drawing, `:49` writes it, and `Structural.DesignCore/JobRequiredBracing.cs:45` preserves NotSet instead of importing another job's value.

    **Reason for HOLD / required work:** The historical question at `04_REFERENCE/ux-plan/cards/TIM_BATCH_QUESTIONS_STRUC_LANES_2026-10-10.md:43` explicitly parks this option OFF pending confirmation; this brief requires delivered bug fixes ON. Record the release decision, expose the drawing values and switch on Settings, and complete an explicit migration/warning path. Do not automatically copy a per-PC figure into every drawing; it may belong to another job. This review makes no engineering choice for Tim and requests no extra permission to finish the report.

    **Tests / DETERMINISTIC TEST:** With default Settings, drawing A: `CSBRACINGREQUIRED`, enter NS 12000 and EW 9000. Switch to new empty drawing B, `CSBRACINGPANEL`. Assert required figures are Not set; reviewed default path shows A's figures. With the corrected ON route, set A, Save As A-copy and reopen under a clean test profile: assert A-copy retains 12000/9000 and B stays Not set. Change A to 15000/10000, U, wait with panel open, REDO; assert its saved values undo/redo and B never changes.

    **Safety / integration:** Codec tests cover unknown/invalid data and round trips, plus source pins; none exercises a DWG write. Panel reads open-close, writes are explicit and document-locked. The new writer has no REFEDIT admission check: `TryGetContext` only obtains document/editor/database. Behaviour during REFEDIT/read-only documents remains unproven and must be guarded/tested before release. No new fixed engineering number or hard block. Not installed. Structural conflict only in regression log; C-63 direct merge HOLD. #1207's earlier review is dependency context, not acceptance of this PR.

15. **#1026 — HOLD with #1024; split the useful unit fix — MEDIUM, verified-by-reading.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1026), head `963af9df`, stacked on #1024.

    **Real cause / benefit:** `Modules/Structural/Services/ProjectDataService.cs:322` reads the block's raw length. `Services/BracingPanelService.cs:39` correctly converts it using INSUNITS before summing. A 2.7-unit metre brace becomes 2,700 mm. This part is always active and its arithmetic tests distinguish the old result.

    **Remaining fault / scenario:** The new plan-axis angle at `Models/UserSettings.cs:731` is a per-PC setting with no Settings window control. `BracingPanelService.cs:42` applies it to whichever drawing is active. After using 90° for a turned plan A, opening an ordinary plan B silently swaps its NS/EW classification. Unlike the two required lengths in its parent, this new job-specific angle neither travels with the drawing nor switches per job.

    **Exact fix:** Separate the unit conversion from the held job-record branch for an independently reviewable small change. Put the plan-axis value on the job's Settings page and persist/switch it with the job; retain Unknown handling for unset units rather than claiming all units were established. If combined with #1012, retain both arguments with named calls: the two branches currently compete for Summarise's fourth parameter (boolean versus angle). Dry merge confirms calculator and panel-service conflicts.

    **DETERMINISTIC TEST:** Synthetic metre fixture with one A brace whose dynamic length is 2.7 and rotation 90°, required NS 2700 mm. Type `CSBRACINGPANEL`; assert provided NS 2700 mm and sufficient. For the angle defect, prepare A with job axis 90° and B with job axis 0°, both with a 2700 mm brace at world 0°. Open each and read the panel: A must count NS 2700; B EW 2700. Switch back twice; figures must stay attached to their jobs. On current code an isolated per-PC angle of 90° gives NS in both. Assert the corrected angle can be changed through Settings.

    **Safety / integration:** Calculation and panel reads only; no new entity writer or native-protection bypass. The explicit 45° classification threshold is inherited, not newly invented by this PR; choosing a different engineering split is outside this review. Default axis zero preserves old unturned behaviour. Neither the conversion nor axis control is in nominated Structural. Structural merge conflicts only in regression log when considered alone; parent remains held; C-63 direct merge HOLD.

---

**Summary**

Fifteen PRs reviewed. Three small Structural fixes are suitable for their own code line; eight need corrections, two remain held and two are superseded or obsolete. The strongest fault is C1 silently taking 89 SHS after promising a size question. The import explanation and issue-date warning also fail to reach their windows. Drawing-specific bracing controls still need proper storage and Settings routes. No build, test or AutoCAD session ran. Only this findings file was authored; no PR, bug register or queue was changed.
