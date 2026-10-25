**ANSWER FIRST — class E, positions 121–134**

1. **New findings: HIGH 0 / MEDIUM 2 / LOW 0.** Both are verified-by-reading, not observed in AutoCAD. The most important is PR #1661: a saved detention length of 10,000 mm is displayed as **10,000 m**. A 10 m pipe therefore appears to require 10 km in the saved calculation evidence. The drawing and calculation themselves are not changed.

2. **Verdicts: MERGE 8 / MERGE-WITH-FIXES 3 / HOLD 1 / REJECT 2.** MERGE #1640, #1641, #1642, #1655, #1656, #1672, #1690 and #1703. MERGE-WITH-FIXES #1643, #1657 and #1691. HOLD #1661. REJECT #1644 and #1670 as release changes; leave their PRs and branches open.

3. **The second finding changes an earlier approval.** #1643 correctly recognises levels that round flat, but makes those additional cases stop Apply. R-27 requires a warning and recorded decision, with continuation available. Its two permitted hard blocks do not include flat pipes. The earlier review explicitly accepted this extended refusal; that part of its verdict is wrong.

4. **What must happen next.** Correct #1661's unit label and add the missing detention-length case before its existing build/visual hold can clear. In #1643 retain the rounded-level warning and truthful grade report, but remove the flat-grade refusal. Resolve the three code clashes with C-63 listed below. No action from Tim is needed for these corrections.

5. **What was done.** Source review only: 0 builds, 0 tests, 0 AutoCAD sessions, 0 installs and 0 PR changes. Only this report was authored. Nothing is marked fixed or accepted. Manager administrator work remains parked; #1672 is dormant wording only and #1703 is tests only.

---

**Technical scope and evidence**

1. **Selection and date.** Reviewed 26 October 2026, Melbourne time; the requested filename retains 24OCT. The numbered class-E section of PR_PILE_TRIAGE_2026-10-24.md, lines 1087–1100, gives exactly #1640, #1641, #1642, #1643, #1644, #1655, #1656, #1657, #1661, #1670, #1672, #1690, #1691 and #1703. Positions were counted within class E, not across the full document.

2. **Prior-review filter.** Read AUDIT_C58_C60_S40_S41_2026-10-22.md and the Civil, Structural and Gate CODEX_AUDIT_*_22OCT reports. Searched REVIEW_*.md and CODEX_PR_REVIEW_GROUP*.md for every number. Relevant reviews: [batch 1](REVIEW_PILE_B1_24OCT.md), [batch 2](REVIEW_PILE_B2_24OCT.md), [batch 3](REVIEW_PILE_B3_24OCT.md), [batch 11](REVIEW_PILE_B11_24OCT.md) and [Codex group 09](CODEX_PR_REVIEW_GROUP09_24OCT.md). All fourteen have prior coverage. Current heads match those reviews. Retained sound verdicts after reading the current PR view/diff; reopened #1661's unit claim and #1643's R-27 endorsement. Earlier findings are referenced, not counted again.

3. **Pinned Git sources.** Fetched origin in C:/Lisp Files/CE_ACAD_PLUGIN. The brief's Civil/Manager baseline is origin/claude/rel-20261022m at 40ee0a36f7960145743954b39859eb6c3af92869; Structural baseline is origin/claude/rel-20261022s2 at 2c9a96942a024888a5ab520600f2d5025de83036. The requested C-63 branch now resolves to 5467f7053a2e9275cb450409c142ef9aa26dad53, later than the 28987b73 used in the earlier reviews. These are source baselines, not a fresh inspection of installed DLLs. Every PR was OPEN at review. File:line references below are at that item's PR head unless identified otherwise.

4. **Already included and conflicts.** None of the fourteen exact heads is an ancestor of either supplied installed baseline or C-63. Checked the relevant implementations as well: C-63 has #1617's alternative BUG-999 fix and #1665's partial BUG-917 wording. An absent ancestor alone is not proof that a fix is absent. Read-only three-way merge-tree output against C-63 contains conflict markers in the propagation writer for #1643; the Manager wording test and XAML for #1657; and Manager XAML for #1691. Every PR also conflicts at the top of REGRESSION_LOG.md. The remaining shared production-file edits merge textually in that comparison. Combining the independent PRs can create further Settings/log clashes; keep all intended keys and all log entries. No merge or worktree checkout was performed in the plugin repository.

5. **Safety checks.** No scoped diff changes CE_SHARED, Shared/, Installer/, signing, package verification or update activation code. Therefore no automatic installer/signed-update HOLD is triggered. #1672 changes a decision message, not an installer. #1703 tests signed rollback fields but does not change their implementation. No new engineering threshold was introduced. #1661's unit mistake is presentation of stored engineering evidence, not an authorised new value.

6. **Switches, protection and REDO.** Four added bug-fix switches start ON, including when absent from an older settings file: #1640, #1641, #1642 and #1643. #1655 reuses the existing ON detention switch. Other PRs add no switch. The diffs introduce no Idle, command-end or object-change drawing writer. #1690's dispatcher callback changes window resources only. #1641 changes a write inside the existing mirror command; normal locked-layer write access remains. #1643 retains existing locked-pipe/label safeguards. There is no added Xref/REFEDIT bypass. These are delta assessments and retained prior-review conclusions, not a claim that every inherited handler is REDO-safe.

7. **Test limits and ownership.** Every test below is a proposed deterministic test for the authorised test lane, NOT an executed result. Use synthetic drawing copies and disposable settings, AutoCAD 2027 and 2024 where the feature exists; #1661's source window is net10 only. For newly integrated drawing paths, also run LINE, U, idle/pick, REDO and require the line to return with no CE drawing write between U and REDO. Exercise locked host layers, attached Xrefs and active REFEDIT; protected content must remain unchanged. The opening read-only override took precedence over later worktree/build/PR boilerplate: no branch, no code checkout changes, no tests, no sub-agents. Only this named CE_PLAN report is owned by this session.

**One numbered item per PR**

1. **Position 121 — [PR #1640](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1640) — MERGE. No new defect; prior verdict retained.** Head c9e26aa59926de528dec693165e07f2e1369c470. Batch 3 item 6.

   **Cause and effect, verified-by-reading:** BackgroundXrefGeometryDiffService.cs:74 and :109 formerly retained only a moved shape's new box. BackgroundXrefAffectedObjectsService.cs:29 and :61 now expand the comparison to its previous box as well. A pit beside the old roof is offered for review alongside a pit beside the new roof. Each candidate is still returned once, using its nearest affected area.

   **Test strength:** Bug992XrefCompareOldPositionTests exercises the actual Diff-to-FindAffected composition, not just a new data property. Its old-position assertion would fail without the change. It also checks one changed area, an added roof, OFF and missing-key defaults. The old-position snapshot being replaced after each comparison remains a disclosed, previously reviewed limitation; this is not a complete repair of BUG-992.

   **DETERMINISTIC TEST:** In a synthetic millimetre host drawing attach an Xref containing one rectangular roof from (0,0) to (10000,10000). Place CE pits P-OLD at (-500,5000) and P-NEW at (15000,5000). Run CDXREFCOMPARE to establish the original state. Move the roof 4500 mm in positive X in the source copy, save, reload the Xref and run CDXREFCOMPARE again. The nearby-object list must name both pits once, and the changed-area count must remain one. OFF must list P-NEW only. Compare source and host geometry before/after: the compare must not move either pit or roof.

   **Safety/integration:** ON default; read-only geometry comparison, no new protected-object write or engineering threshold. Not included in the supplied installed baselines or C-63. C-63 conflict is the log only; preserve this switch alongside the other Linking additions when assembling the batch.

2. **Position 122 — [PR #1641](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1641) — MERGE. No new defect; prior verdict retained.** Head c0a03bc129b7007676c0c9bea580da4e889f2acd. Batch 2 item 9.

   **Cause and effect, verified-by-reading:** MirrorService.cs:144–150 transforms the existing text instead of cloning and erasing it. CD had already registered the original handle as the pipe's attachment; erasing it left the pipe linked to a dead object. Keeping the handle repairs that identity break.

   **Test strength and limit:** Bug996CdMirrorKeepsLinkTests checks ON/OFF/migration and source wiring. Those assertions distinguish the old implementation, but do not execute AutoCAD's TransformBy or prove the later label-follow behaviour. The earlier review correctly left that native result unproven. It is not counted as an additional suspected defect.

   **DETERMINISTIC TEST:** Synthetic P1–P2 pipe with manual text on an unlocked host layer. During CD answer Yes to “Do you want to mirror the text?”, then pick a vertical mirror line beside the text. Capture the text handle registered by the pipe and its final insertion point. Finish CD, then MOVE the pipe 1000 mm in X. Require the registered text handle still resolves to a non-erased object and its insertion point moves by the same 1000 mm. There must be one label, not an orphan plus a replacement. U must restore the move and REDO must repeat it; inspect the mirrored appearance after the move separately. Repeat with the relevant text layer locked and require protected text to remain unchanged.

   **Safety/integration:** ON default; same explicit command/transaction, same write protection, no new automatic writer. Not already included. C-63 conflicts only on the log. Keep the native mirror/attachment test as a release check, not a claimed unit-test result.

3. **Position 123 — [PR #1642](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1642) — MERGE. No new defect; prior verdict retained.** Head 3d6c2b88a4891f78f0b423efc3e35edcfcd69f6a. Batch 1 item 1.

   **Cause and effect, verified-by-reading:** ProjectDataService.Persistence.cs:210–220 now calls ProjectRecordSourceRule.DrawingRecordWins before reading the PC file. Previously a successfully read drawing record lost authority merely because its pit, pipe and manual-row lists were empty. An old PC file could then replace the drawing's saved project choices.

   **Test strength:** Bug988DrawingRecordWinsTests covers the empty readable record, no readable record, OFF and old settings; a source guard pins the decision before File.ReadAllText. These fail against the old decision/wiring. They do not prove the actual DWG reader succeeds, which the PR correctly discloses.

   **DETERMINISTIC TEST:** Prepare EmptyRecord.dwg with an embedded CE project set to residential, empty pit/pipe/manual-row lists and no stale geometry; give its disposable legacy PC record commercial land use. Close and reopen the drawing, then open its project settings. Require residential, and the CE log line “Project data loaded from DWG: 0 pits, 0 pipes, manual rows=0”. Open the same drawing under a second disposable profile with a different legacy file: still residential. A separate drawing with no embedded record must retain the old migration behaviour. OFF must reproduce the legacy priority.

   **Safety/integration:** ON default; changes source selection during existing loading, adds no write event. No protected entity is newly opened. The persistence file is protected ownership territory for the eventual assembler, not an instruction for this reviewer to edit it. Not already included. Its production changes merge textually with C-63; log conflict only.

4. **Position 124 — [PR #1643](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1643) — MERGE-WITH-FIXES. MEDIUM — NEW review correction, verified-by-reading.** Head 18c6393e63a99301ac45a6b12a551f66f3222895. Batch 1 item 5 retained the code conflict but wrongly endorsed the extended hard block.

   **For Tim:** A 1 m pipe set to 1 in 300 now stops the whole cascade because the two saved levels would both read 10.00. Explaining that lost fall is correct; removing the drafter's ability to proceed contradicts R-27. This is an expanded existing refusal, not a claim that this PR invented the original refusal.

   **Exact path:** Models/PropagationPlan.cs:50 rounds the proposed levels before IsFlatOrNegative; :178–181 makes any such row disable CanApply. ViewModels/PropagationPreviewViewModel.cs:158 and :190–202 disable Apply and display “Apply blocked”. Services/LinkService.RepairAudit.InvertPropagation.cs:673–690 independently refuses the plan or flat written rows. ENGINEERING_RULEBOOK.md:265–266 specifies warn, record and continue, with only spine-identity deletion and a failed-build colleague push listed as hard blocks. Neither applies here.

   **Cause/test assessment:** The rounding fault is real: 10.003333 and 10.000 become 10.00 and 10.00. The new six tests correctly detect that arithmetic. They do not assert R-27's ability to continue. Hand-entered retained levels are also formatted by the writer at :772–775, so rounding those levels here is not a separate new mismatch; that possible concern was checked and discarded.

   **Exact fixes:** Keep a rounded-level warning containing the actual saved pair and affected pipe. Remove flat-grade-only gating from the preview and writer, while retaining the explicit Apply decision and native protected-object guards; record the warning with the action. Feed C-63's PropagationGrade.OneInN helper the same formatted levels the writer uses. Reuse PropagationPlan.FormatIl instead of duplicating “0.00”, and update the wiring test to the integrated helper. Do not replace the message with a universal “less than 10 mm” threshold: rounding depends on both absolute levels. Merge with C-63; never rebase. Keep C-63's single-invert-text end protection.

   **DETERMINISTIC TEST:** Fixture: unlocked P1–P2, 1000 mm long, downstream anchor 10.000 m, no manual pins, valid project and readable labels. Type CDPROPAGATE, choose P2 and enter 10.000; in the preview set the P1–P2 override to 300. Require a visible warning naming P1–P2 and the written pair 10.00/10.00, with Apply available. Explicitly Apply: assert the drawing labels and saved pipe values agree at 10.00, and the recorded warning names the zero written fall; no report may claim a written 1:300 grade. Current head fails at disabled Apply. A 1:100 control writes 10.01/10.00 and reports 1:100. U/REDO must restore/reapply once, with no intervening automatic CE write. Also add a plan-level regression asserting warning plus CanApply for this no-error fixture; the PR's arithmetic-only tests miss that contract.

   **Integration:** ON default, no new engineering value. Not already included. Real C-63 conflict: LinkService.RepairAudit.InvertPropagation.cs at the grade-report calculation, plus the log. The known stale override advice is not counted as a third finding.

5. **Position 125 — [PR #1644](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1644) — REJECT as a release merge. No new defect; superseded-fix verdict retained.** Head 2fd85563e6d94abbf163f470c55a826289d7f1cd. Batch 2 item 10.

   **Cause and effect, verified-by-reading:** RunSolveCommand.cs:176–180 adds RunSolveOutcomeWords when a plan has no effective changes. The original false success sentence is real in this PR's base and the supplied 22 October baseline. However, C-63 already contains #1617: ProposalApplyService.PlanBuilders.cs:113–122 puts a truthful failure into plan.Errors, and RunSolveCommand.cs:170–173 prints it and returns before this PR's helper. Do not call that alternative “installed on 22 October”; the earlier review used the later 3.0.72 baseline.

   **Test strength:** Bug999RunSolveHonestTests catches the old helper wording, not the existing #1617 end-to-end command behaviour. Empty result/inconsistent all-feasible flags are residual corners, not grounds for maintaining two competing outcome mechanisms. If needed, put an empty-result case in the established plan-builder path.

   **DETERMINISTIC TEST:** Synthetic P1–P2 run with known geometry and inverts but zero/unset design flow. On C-63 type CDRUNSOLVE and choose the run from P1. Require “Nothing was changed. CE could not size these pipes because none of them has a design flow yet.” Require no “every invert already matches” and unchanged saved inverts. For the residual empty-result case, feed NetworkDesignResult with no pipes to the real plan-building path and assert a truthful no-solve command outcome, not merely the new helper's returned text.

   **Safety/integration:** Wording only, no switch/writer/protection change. Exact PR head is absent; its main effect is superseded in C-63. Production merges textually, log clashes. Keep the PR open; no closure or merge performed.

6. **Position 126 — [PR #1655](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1655) — MERGE. No new defect; prior verdict retained.** Head 52efb49b918875d429c6935dfd1b440047611892. Batch 3 item 5.

   **Cause and effect, verified-by-reading:** Rules/RulebookEngine.cs:568 uses DetentionHasNoLengthToJudge before R-30's council-grade comparison, matching R-06. A downpipe accidentally marked Detention without a recorded storage length no longer receives a confident storage-grade pass/warning. It says the length is missing. Recorded storage and twins still receive the check.

   **Test strength:** Bug906DetentionGradeTests has missing, zero and invalid text lengths; passing/warning real storage; twins; and OFF. The old R-30 gives Warn instead of Unknown for the missing-length fixture, so the assertion distinguishes it. Three earlier tests now declare the storage length they intended to test. The earlier review's builder verification remained pending; no run was made here.

   **DETERMINISTIC TEST:** In a disposable profile choose Manningham with its existing 1:180 storage-grade setting. Fixture P1–P2 is 10 m, DN100, invert fall 40 mm, marked Detention, no twin and blank required length. Run CDRULES All: R-06 and R-30 must be Unknown with the missing-length explanation. Enter 10000 in the editor's required-length mm box and run again: R-30 must Warn for 1:250 versus 1:180. Clear the length and tick twin: the grade is still judged. OFF restores the earlier grade comparison. These fixture values do not alter council defaults.

   **Safety/integration:** Existing detention switch remains ON; report logic only, no new block or drawing hook. Not already included in the requested source baselines/C-63. Log conflict only.

7. **Position 127 — [PR #1656](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1656) — MERGE for its stated warning-only scope. No new defect; prior verdict retained.** Head cb53d0f897afcf79c95e70fb46b5ff4d6ccbc5c9. Batch 3 item 4.

   **Cause and effect, verified-by-reading:** Services/DetentionSizingService.cs:158–159 adds a caution when positive storage is governed by the first sampled storm. It changes no rainfall, duration ladder, discharge or storage result. A five-minute maximum no longer silently looks like a fully bounded peak.

   **Test strength and limit:** Bug904ShortestStormTests compares the unchanged sampled result with a separately calculated seven-minute result, tests non-first maxima/no storage, and CivilDesignWindowsTests feeds the real design service into the real window. Their absence-of-note assertions distinguish the base. The previously reviewed interior-peak limitation remains: this does not warn for every possible missed maximum between later samples. Keep BUG-904 open for that part; do not count it as newly discovered here.

   **DETERMINISTIC TEST:** Service fixture: site 640.67 m², weighted C 0.6511, supplied discharge 6.54 L/s, 1-in-10 storage storm and the existing office curve. Require the unchanged approximately 1.688 m³ at five minutes and the shortest-storm/finer-interval caution; the independent seven-minute calculation is approximately 1.734 m³. Native window fixture: CDDESIGN, Generic Default, confirmed synthetic outlet, design from scratch, site 640.67 m² and roof/paved 213.56 m², before-development C 0.35, soft-ground C 0.30, detention required and head 0.45 m. Work out design. Assert Results contains “shortest storm” and “finer intervals before issuing”. Close without creating output and confirm the drawing remains unchanged. Do not mix the service fixture's supplied discharge with the window's calculated discharge.

   **Safety/integration:** No switch, new constant, writer or block. Not already included. Log conflict only. Previously pending full-suite/render evidence is not silently upgraded to a pass by this review.

8. **Position 128 — [PR #1657](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1657) — MERGE-WITH-FIXES. No new defect; prior integration verdict retained.** Head ae113f75d8e858c35d4ca27ea53bd3247f4a76d9. Batch 3 item 1.

   **Cause and effect, verified-by-reading:** Services/CeOneGlanceStatus.cs:123–138 wrongly treated a checked copy as something that would start on the next AutoCAD launch. The PR distinguishes approval, checked copy awaiting installation, and newer installed files. PluginManagerWindow.xaml.cs:616, :672 and :680 and PluginManagerWindowViewModel.cs:202/:557 carry the same correction. Actions and eligibility checks are unchanged.

   **Exact fixes:** Merge C-63, keep its “Copied, waiting” labels and apply that spelling to the new status/dialog strings. Combine this PR's behavioural cases with C-63's existing Bug917UpdateStageWordsTests.cs; do not discard either set or create a duplicate class. Keep the additional truthful installation-needed sentences. Run the previously unexecuted compiled tests and inspect the real-window renders before release. No installer or administrator feature is to be enabled as part of this wording change.

   **DETERMINISTIC TEST:** Using the existing synthetic Manager evidence fixture, supply running 3.0.71, installed 3.0.72 and approved 3.0.73. Without a checked copy the Status headline must read “Approved: 3.0.73”. Add a verified staged-copy record without changing installed files: headline must read “Copied, waiting: 3.0.73” and say installation is still needed. Remove approval/copy but retain installed newer than running: “Starts next time: 3.0.72”. In an authorised AutoCAD test profile type CEMANAGER and inspect Status, Module and Updates against those same evidence states. Assert window text and loaded/installed facts, without installing anything merely to prepare this test. The PR's source/decision assertions distinguish the base; they are not executed here.

   **Safety/integration:** No switch, drawing write, engineering limit or signed-update implementation change. Partial effect already in C-63 via #1665. Actual conflicts: Manager XAML and the same-name test file, plus log.

9. **Position 129 — [PR #1661](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1661) — HOLD. MEDIUM — NEW unit defect, verified-by-reading.** Head caf3244aa368c761d4d09b2f309acf578f971ff7. Batch 11 item 5 said “No code change asked for”; that assessment is wrong. The existing unbuilt/unviewed hold also remains.

   **For Tim:** Open a saved council-check source for a 10 m detention pipe and the new window says “Required detention length 10000 m”. It is presenting the historical evidence at 1,000 times the actual length. This does not change the stored record or calculated storage.

   **Exact path:** ViewModels/SavedRuleInputDisplay.cs:29 assigns DetentionRequiredLength the suffix “ m”. At :64–69 it parses the existing number and appends that suffix with no conversion. The real editor labels the bound input “mm” at Dialogs/PipeEditWorkshopDialog.xaml:136–137. Commands/CdCommand.Schedule.cs:113 copies that text unchanged into the record. Rules/RulebookEngine.cs:164–168 captures it unchanged in the adverse finding's saved anonymous input. CouncilSourceViewModel.cs:81 routes that evidence through the faulty formatter. RulesCommand.cs:132–156 exposes it through CDRULES Source. Thus the display is reachable with real saved findings, not just a manually invented JSON shape.

   **Why the tests miss it:** Bug925SavedSourceValuesTests.cs:26–46 exercises sizes, material and levels, including real text storage. None of its fixtures supplies DetentionRequiredLength. The render fixture also uses the same pipe sample without that field. The test suite can therefore pass while this dimension is wrong. The original raw-JSON presentation fault is real, but this replacement introduces a false unit.

   **Exact fix:** Change the field's display unit to mm, consistent with the existing editor and saved value. Alternatively, if metres are deliberately chosen, divide this field by 1000 before formatting; do not change saved evidence or other metre-valued levels. Prefer the mm label for the smallest correction. Add a case produced by RulebookEngine's actual saved-observation path, not only the formatter, with DetentionRequiredLength="10000". Require “Required detention length 10000 mm”; test "12500" too, and assert the retained JSON remains byte-for-byte unchanged.

   **DETERMINISTIC TEST:** AutoCAD 2027 disposable profile and synthetic P1–P2 detention pipe, 10 m long, DN100, required detention length entered as 10000 mm, known inverts and council settings that produce an R-06 diameter warning. Type CDRULES All to record it. Then type CDRULES Source, choose that latest recorded run and the P1–P2 R-06 warning by its displayed list number. In the source window choose “Saved pipe values (not checked)”. Assert window text “Required detention length 10000 mm” and absence of “Required detention length 10000 m” as a complete value. The current head instead prints the latter. Change the current pipe length field to 12500 mm without replacing the saved run, reopen the same saved finding: it must still show 10000 mm. A new recorded run must show 12500 mm. No current-value substitution is allowed.

   **What clears HOLD:** Unit correction plus the new regression, then the prior required net10 build, all existing 15 cases plus the added cases, and inspected dark/light source-window pictures. Neither the PR nor the earlier reviewer established a compiled run; none was attempted here. Net48 has no such window. No new switch, engineering default or drawing writer. Not already included; C-63 conflicts only on the log.

10. **Position 130 — [PR #1670](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1670) — REJECT as a release merge. No new defect; prior verdict retained.** Head 62c94cefb617c6c501f642d25bc724837e694880. Batch 11 item 6.

    **Verified-by-reading:** Its entire change is REGRESSION_LOG.md:1–10. It explicitly says that BUG-948 through BUG-952 were skipped. There is no implementation or test, and no drafter-visible change. The routing evidence already belongs in CODEX_LEDGER_FIX_BATCH16_23OCT.md in CE_PLAN. This is not five bug fixes.

    **DETERMINISTIC CHECK:** Compare the PR head with its merge base, excluding REGRESSION_LOG.md: the diff must be empty. There is no claimed AutoCAD fix to test and no test that fails without this documentation-only change. For an unchanged-behaviour control, CEMANAGER's Updates action in a non-administrator fixture must behave exactly as at its base; this PR cannot provide the BUG-948 correction routed to #1595.

    **Safety/integration:** No product, switch, installer or drawing changes. No code is already included because no code was supplied. Only the log conflicts with C-63. Leave the PR/branch open; no plan files other than this report were edited.

11. **Position 131 — [PR #1672](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1672) — MERGE as dormant wording only. No new defect; prior verdict retained.** Head 8b3a1e09fb414b28f3efd5a7836e8b3bbf66197c. Batch 1 item 2.

    **Cause and effect, verified-by-reading:** Services/CeFinishUpdateStartRule.cs:36 replaces a promise of automatic completion with “Close every AutoCAD window on this PC, then ask your CE administrator to finish the update.” It changes no decision or caller. A production-tree search at this head finds only the rule declaration: nothing invokes it. A drafter sees no difference today.

    **Test strength:** The six new CeFinishUpdateStartRuleTests cases cover open/unknown process counts on either look and assert the exact message plus WaitForAutoCad. They distinguish the original promise. They do not establish an installed workflow, and no such claim should be made.

    **DETERMINISTIC TEST:** Isolated ready-plan fixture, switch ON, first/second AutoCAD counts (1,0), (0,1), (2,2), (-1,0), (0,-1), (-1,-1). Require WaitForAutoCad and the exact administrator-next-step message in every case; no process launch callback may occur. There is no current typed AutoCAD route to this rule, so a native window/command-line assertion is not available. Once a separately authorised caller exists, request completion with AutoCAD open and assert that same message; do not wire the caller just to satisfy this test.

    **Safety/integration:** Installer, signature checks and switch defaults untouched. Manager administrator work remains parked. Not already included; log conflict only. This is a code-review MERGE verdict, not authorisation to activate finish-update work.

12. **Position 132 — [PR #1690](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1690) — MERGE. No new defect; prior verdict retained.** Head a39b638bdae9e364f9cea2606b3930fa560ecbe4. Batch 11 item 7.

    **Cause and effect, verified-by-reading:** ChecksListControl.xaml.cs:12 and DrawingCheckPanelControl.xaml.cs:11 register retained palette bodies with ThemeService.FollowThemeChanges. Services/ThemeService.cs:120–123 and :240–278 refresh their local theme resources, including hidden bodies, through weak references and the owning dispatcher. Previously changing the application theme left each retained private dictionary in its old colours. Buttons now use dynamic styles, so their appearance follows too.

    **Test strength:** Bug960PaletteThemeTests uses real controls, changes theme, preserves the selected page/model, hides/reopens, restores the original preview and verifies colours/styles. This is behavioural coverage of the defect, unlike a search for the new method name. The earlier review retained the builder's four-before-fail/four-after-pass account; this session did not rerun it or inspect the twelve PNGs.

    **DETERMINISTIC TEST:** Synthetic drawing and disposable settings, with Checks enabled and the legacy What CE Found path available. Type CDCHECKS and open What CE Found through CDCHECKCURRENT in its legacy-view profile. Select a non-first tab. In CDS > Display > Theme change Dark to Light, then Cancel/Discard. Both palettes must immediately adopt Light for preview, then return to Dark, retaining their page and findings. Hide both, change to Light and reopen: both must now be Light. Assert window colours and selected-tab text; record drawing values unchanged. Repeat opposite starting theme and AutoCAD 2024.

    **Safety/integration:** Resource repaint only, no database or Settings write added, no new switch or hard block. Existing Checks feature default is unchanged. Not already included; log conflict only. Pictures/native appearance are unviewed by this reviewer, not implicitly accepted.

13. **Position 133 — [PR #1691](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1691) — MERGE-WITH-FIXES. No new defect; prior integration verdict retained.** Head b1c1ab6458301dbe8508b3418649ff81490f805e. Batch 3 item 2.

    **Cause and effect, verified-by-reading:** UI/Dialogs/PluginManagerWindow.xaml:46–52 adds unique module-qualified automation IDs and spoken names to running/installed version and build fields. This gives the test robot reliable field identities; visible values/layout do not change. PluginManagerWindow.xaml.cs:35–50 keeps the public constructor attaching native document hooks and adds only an internal test route to omit them.

    **Exact fixes:** Merge C-63's “Starts next time” label with these attributes; preserve all four IDs. Change the two spoken “installed next start” names and matching assertions to “starts next time” so accessibility text agrees with the integrated label. Combine after #1657's wording reconciliation. This is an integration requirement already recorded, not a newly discovered product defect.

    **DETERMINISTIC TEST:** CEMANAGER > Status in a disposable profile with deliberately different running and installed versions. Query Manager.Status.CE_CVL_SUITE.Running.Version, .Running.Build, .Installed.Version and .Installed.Build using UI Automation. Each must return exactly one field with the value shown in the corresponding labelled column; repeat for CE_STRUC_SUITE and CE_SUITE_MANAGER. Require the installed-column spoken names to say “starts next time”, in both themes. The two real-window test cases cover all twelve identities and real WPF peers and would fail without the attributes; they do not run AutoCAD's Loaded discovery.

    **Safety/integration:** No drawing write, new switch, engineering value or administrator action. Not already included. Actual conflict is Manager XAML plus log; code-behind edits merge textually with the pinned C-63. Images were not opened in this review.

14. **Position 134 — [PR #1703](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1703) — MERGE as regression coverage. No new defect; both prior verdicts retained.** Head 4cb41a0b91d248408d8639d643aa501fb194f529. Batch 11 item 8 and Codex group 09 item 10.

    **Verified-by-reading:** Modules/Manager.Tests/Services/Bd03ManagerRegressionTests.cs:46, :65, :88, :111, :128, :143, :157 and :174 adds nine cases for existing fixes: held approvals/recovery, Civil/Manager staging order, signed rollback fields, failed settings replacement, unfinished outbox files, and distinct support-warning delivery. Only this test file and the log change. No six-bug product fix is supplied by this PR.

    **Test strength:** Real service methods are exercised in private temporary folders, with staged installation represented by a callback. The earlier independent review checked the original fix diffs and the stored results. It distinguishes actual historical failure for the held settings writer from cases that are only compile-red on older parents. Do not claim all nine have an executed before-fix reproduction. This session read the cases and retained that conclusion; it ran none.

    **DETERMINISTIC TEST:** Disposable Manager profile and synthetic approval folder with A_Held and B_Good. Hold A_Held/approved.json exclusively, type CEMANAGER and click Refresh: B_Good remains available and the Manager trace names A_Held as unreadable. Release the file and Refresh: both return, with original approval bytes unchanged. In the isolated staging fixture, fail Civil's copy and assert attempts include Civil and independent Structural but never Manager alone. Hold the CE Blocks settings destination during Save: original bytes remain and no temporary file is left. These are observable file/log/window outcomes; no activation is needed.

    **Safety/integration:** Test-only signed-field reads do not trigger the installer-file HOLD. No new product defaults, drawing writes, REFEDIT route or administrator capability. Test additions are absent from the supplied baselines/C-63; the underlying fixes are earlier work and must not be credited again. Log conflict only. Native acceptance of those original fixes remains separate.

---

**Summary — under 100 words**

1. **Summary.** Fourteen PRs: eight MERGE, three MERGE-WITH-FIXES, one HOLD and two REJECT. Two new MEDIUM review findings: #1661 labels stored millimetres as metres; #1643 expands a flat-pipe hard block contrary to R-27. Correct the unit, add the missing saved-evidence regression, and preserve warning plus continuation for rounded-flat levels. Resolve C-63 conflicts in propagation and Manager wording/field identities. Earlier findings and partial fixes remain open. No builds, tests, AutoCAD checks, installations or PR edits were performed; only this report was saved.
