**ANSWER FIRST — independent PR review group 09, 24 October 2026, Melbourne**

1. **New fault count: HIGH 1 / MEDIUM 0 / LOW 0.** The most important finding is in #1721: Refresh Blocks still replaces the pit symbol used by locked pits. Its new protection checks run only on the later riser, dropper and pit-label replacements. This is verified by reading, not reproduced in AutoCAD.

2. **Verdicts for all 11 PRs: MERGE 2 / MERGE-WITH-FIXES 2 / HOLD 5 / REJECT 2.** MERGE #1703 and #1719. MERGE-WITH-FIXES #1720 and #1721. HOLD #1702, #1704, #1705, #1716 and #1718. REJECT the release merge of #1714 and #1715, which contain routing notes only. Leave every PR and branch open.

3. **Opus coverage:** all seven cx4 PRs have a review in `REVIEW_CX4_AND_BATCH4_24OCT.md`; no Opus review was found for the four cx3 PRs. The 23 October review files do not cover this set. I reviewed all four cx3 changes and all seven cx4 changes, including the later #1720 test correction and #1721 protection follow-up.

4. **What the release team should do:** close the pit-symbol protection gap, retain the existing Opus conditions on units and Label Styles, and finish the outstanding validation before merging those candidates. Civil + Manager remain the 9 November scope. Structural stays on its own line; Manager administrator work remains parked.

5. **Evidence limit:** no builds, tests, AutoCAD, installation or sub-agents were run. I read existing test-result files. They do not all show green full runs. All native checks below are instructions for the later AI test lane, not requests for Tim to test.

---

1. **Method and pinned source.** Read RULES, ROUTER, CE_PLAN start/map and the desk continuity record. Read the named C58–C60/S40–S41 audit and the Civil, Structural and gate CODEX_AUDIT files from 22 October, then the four REVIEW_*_23OCT files and the relevant 24 October Opus review. Earlier faults are not counted again.

2. **Repository boundary.** Fetched origin and used a private detached, no-checkout worktree at `C:\ce-cx\review-group09-24oct`. All product source came from Git objects, never another chat's working files. The supplied 22 October references remain `40ee0a36` and `2c9a9694`; the PRs actually target the later Civil/Manager base `f7f7d551` or Structural base `e6d597c0`. Diffs were reviewed against those declared bases, avoiding attribution of intervening release changes to a PR. Installed DLLs were not inspected.

3. **Inventory and timing.** Used the requested `gh pr list --repo timbrand92/CE_ACAD_PLUGIN --state open --limit 300 --json number,title,headRefName,headRefOid,baseRefName`, then filtered cx3/ and cx4/. Repeated the inventory at approximately 03:51 AEDT. The exact 11 heads are listed below. #1720 advanced from `50fd12eb` to `1b40fd11` during review; its delta changes one retained test's expectation and the log, not production code. GitHub returned no review or comment nodes for #1702–#1705; no matching Opus entry was found in the review records searched.

4. **Meaning of verdicts.** MERGE is a source-review recommendation, not installation or native acceptance. MERGE-WITH-FIXES requires the exact changes and validation stated below. HOLD means an unresolved assembly/validation condition remains. Severity counts describe newly established product faults only; previously recorded Opus conditions and missing test runs are not inflated into additional drawing defects.

**One numbered item per PR**

1. **#1721 — MERGE-WITH-FIXES. HIGH, new residual protection finding G09-01. VERIFIED-BY-READING.**

   **Snapshot:** [PR #1721](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1721) — RD12: protect locked symbol copies and tank content (BUG-1080 BUG-1081 BUG-1083). Branch `cx4/fa07-native-protection`; head `0d4df01cc2a0f204d0791ebf381ba7429a26ac14`; base `claude/rel-20261023m`.

   **Opus:** reviewed `dc7870a6`, HOLD pending builds/tests, then MERGE. I also read its follow-up to `0d4df01c`, which adds the pre-clone tank-definition check. The wider claim that shared pit symbols are protected is not supported by the command path.

   **For Tim:** lock a finished pit, then run Refresh Blocks: the pit's shape can still change while its layer remains locked. The new checks correctly cover a locked RISER, but the pit symbol is replaced before those checks are reached.

   **File:line and exact failure:** `Modules/Drainage/Commands/RefreshBlocksCommand.cs:54` calls `PitBlockMigrationService.Migrate` at line 55. Only the later four-target loop reaches `NativeBlockProtection.DescribeRefresh` at line 124. The migration's own `Services/PitBlockMigrationService.cs:343` calls `BlockService.InsertQuietly` and line 346 writes its stamp, without a reference-layer check. Explicit refresh passes the default `allowSkipCurrent=false`, so a current fingerprint does not avoid this path. This is inherited behaviour left exposed by the fix, not a regression introduced by the new helper. It is distinct from BUG-793's already-known name/fingerprint problem and from RD12-01's explicitly non-pit fixture.

   **Cause, scope and tests:** the original non-pit locked-definition, forced attribute write and Xref-adoption causes are real. The new helper and tank checks address those routes. However, `Modules/Drainage.Tests/Commands/Rd12NativeProtectionTests.cs:12` compares the guard's textual position only with the command's later InsertQuietly; its separate check before Migrate is REFEDIT-only. All 16 proposed checks can therefore pass while this locked-pit path survives. No build/test result was claimed in the current PR/report when read.

   **Exact fix:** before calling Migrate, check every present migration name (PIT BLOCK, PIT BLOCK 2, PIT BLOCK 3) with the same protected-reference helper. If any is protected, skip the migration as a unit with a plain line naming the symbol/layer; continue the independent safe refresh targets. This avoids a rename into a protected definition. Alternatively the protected migration owner can enforce the same rule inside the service. Add a caller-order guard and a native locked-pit fixture; keep the existing non-pit, containing-block, dynamic-block and attribute checks.

   **DETERMINISTIC TEST:** after startup has settled, create a synthetic mm drawing fixture with an ordinary resident PIT BLOCK 3 containing a distinctive extra circle, radius 123 mm at local 7000,7000, absent from the resolvable shipped source. Insert it on AUDIT-PIT-LOCK and lock that layer; keep layer 0 current and definition members unlocked. Record its handle, definition geometry, layer flag and migration stamp immediately before the command. Type `CDREFRESHBLOCKS`, then `REGEN`. Assert geometry, stamp and layer lock are unchanged and a command-line line names the skipped pit symbol/layer. Current source instead reaches the replacement and predicts a `[PitBlockMigration] redefined=1` line and loss of the extra circle. An unlocked RISER control must still refresh. Repeat with a pit inside a locked parent block; repeat REFEDIT with zero replacements. On the unlocked control, U and REDO must restore/reapply the exact geometry. NOT RUN.

   **Safety/defaults/order:** the tank's new checks precede its accepted writes, then recheck the actual definitions within its existing transaction; forced attribute-layer access is removed. Xref adoption and REFEDIT checks are present. No new passive event writer, switch, engineering value or CE_SHARED change. Native REDO preservation is not established merely by an aborted transaction. No other PR in this set edits these source files. Complete the PR's build/test gates after the fix.

2. **#1720 — MERGE-WITH-FIXES. No additional counted fault; retain Opus's Apply-window condition.**

   **Snapshot:** [PR #1720](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1720) — Audit RD03: allow unknown pit cover and independent catalogue work. Branch `cx4/fa01-inspection`; head `1b40fd11d71a55059be79bb94b21ca5ba5f57c62`; base `claude/rel-20261023m`.

   **Opus:** reviewed `50fd12eb`, MERGE-WITH-FIXES. Production code is unchanged at the new head. I read the follow-up `1b40fd11`: it replaces the obsolete blank-cover blocker expectation with a real enabled-button/warning test; this is consistent with the intended fix, not suppression of an unexpected product failure.

   **Cause real / scope:** yes. `Rules/PitStartReadiness.cs:85` now permits blank cover with an attention message; the writers retain the blank and the cover formatter omits its numeric claim. `Services/DrawingSafetyService.cs:75` lets the two office editors open independently of the drawing. `Services/LabelStyleService.cs:294` retains an intentionally empty catalogue; `ViewModels/LabelStyleDialogViewModel.cs:178` permits the last deletion. No engineering default is invented.

   **Existing condition, verified by reading:** `ViewModels/LabelStyleDialogViewModel.cs:208` calls drawing preflight inside the still-open modal Label Styles window. That leads to command-line questions at `Services/DrawingDisciplineService.cs:113` or `:161` on Structural/untagged drawings. A blocked or inaccessible prompt behind the window is a SUSPECTED native symptom, not something I observed. Exact fix: close or temporarily hide the modal window before the command-context question and application, or use an existing modal-safe drawing decision; do not restore the blanket restriction on opening the office editor.

   **Test evidence:** read the 157/157 focused TRX and the first full result: 19,554 passed, one failed. The failure was `EachSharedBlocker_HighlightsItsOnlyInput_WithoutChangingDraft("CoverLevel")`, now corrected in the follow-up. No final full pass at the corrected head was established here. The builder reports three successful build lanes. Sixteen committed renders exist; I did not inspect them and claim no visual acceptance.

   **DETERMINISTIC TEST:** in synthetic untagged and Structural drawings, type `CDLABELSTYLE`, select a style, click **Apply to drawing**. Assert the Civil question is visible and answerable, No leaves all label text unchanged, and Yes completes once. Repeat in REFEDIT: catalogue editing/Save works but drawing labels remain unchanged with an explanation. Separately place a 600 x 600 mm pit with blank cover, PITEDIT its width to 900 mm, Save: no 0.000 cover appears; U restores 600 and REDO restores 900. Delete the only custom style, Save, reopen: the list stays empty with the built-in-wording explanation. NOT RUN.

   **Safety/defaults/order:** office open/save adds no drawing initialisation; Apply still checks drawing protection. No new undo handler, switch, CE_SHARED change or engineering number. Existing label-writer native behaviour is not certified. No source-file overlap with the other ten PRs. Require corrected full-suite evidence and the modal-route repair before merge.

3. **#1719 — MERGE. No new product fault. VERIFIED-BY-READING.**

   **Snapshot:** [PR #1719](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1719) — RD09: remove false pipe-label and ownership test passes (BUG-1067, BUG-1068). Branch `cx4/fa05-rd09-tests`; head `b6d3d6929b75f5784f80cdf4c0cfd818ac177191`; base `claude/rel-20261023m`.

   **Opus:** MERGE at the same head; independently rechecked because evidence honesty is the purpose of this hunt.

   **Cause real / scope:** yes. Ten annotation bodies either unconditionally passed or compared disconnected local objects/literals; three ownership scenario bodies also unconditionally passed if called. The ownership fixture was already ignored, so it is inaccurate to say all 13 formerly increased the ordinary pass total. `Services/AnnotationSystemTests.cs:165` onward now explicitly ignores missing native scenarios; `Services/OwnershipTests.cs:55` does likewise. The compile-contract/default tests are labelled honestly. No production files change.

   **Fail-without proof:** the 13 cases in `Services/Rd09EvidenceHonestyTests.cs:16` invoke the actual old bodies and require IgnoreException plus the named missing readback. The original bodies cannot meet that assertion. I read corrected-before TRX (13 failed), after TRX (40 passed) and full TRX (19,540 passed, zero failed, 19,600 result records). Eleven additional tests call real preparation/formatting routines; they are explicitly not drawing checks.

   **DETERMINISTIC TEST:** existing unit evidence is adequate for this test-only correction. For eventual native acceptance use a synthetic 150 mm pipe with recorded label handles, PIPEEDIT to 225 mm and Save; assert the same handles now contain 225, U restores 150, REDO restores 225. Separately draw from P3 to P5 with unselected P9 close by; read saved From/To after PIPEEDIT and save/reopen, requiring P3/P5 throughout. Until then the native scenarios remain UNVERIFIED. NOT RUN here.

   **Safety/defaults/order:** no drawing code, REDO path, layer/Xref/REFEDIT protection, switch, engineering number or CE_SHARED change. It neither tests nor certifies those native protections. No code-file overlap in this set; preserve its regression entry during assembly.

4. **#1718 — HOLD for its own build/test and picture evidence. No new counted fault.**

   **Snapshot:** [PR #1718](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1718) — Fix BUG-1074 and BUG-1075: RD11 Manager hover and Civil preview wording. Branch `cx4/fa06-plain-words`; head `9135d337dc36890a9d8199f8dc6026864fa4da39`; base `claude/rel-20261023m`.

   **Opus:** HOLD pending validation, then MERGE at the same head. That condition remains.

   **Cause real / scope:** seven Manager hovers held technical connection text. They are cleared and the reason is logged through `Modules/Manager/UI/ManagerScreenText.cs:32`. `Modules/Drainage/Commands/SpineUpgradeCommand.cs:41` changes displayed options and routes to `Rules/SpineUpgradeWords.cs:8`; full technical details stay in the log. Apply/Rollback writers are otherwise unchanged. DryRun and Rollback remain hidden typed options.

   **Test strength:** `Manager.Tests/UI/Bug1074UnavailableHoverTests.cs:33` invokes actual page setters and inspects tooltip properties; it would fail on the base. The new Civil formatter tests call the real rule. The keyword test is only a source check: it cannot prove AutoCAD accepts displayed/hidden choices. The PR and report still claim no passing run at this head.

   **DETERMINISTIC TEST:** isolated Manager host with the synthetic failure “The Civil settings bridge payload is incomplete.” Open Settings General/Civil, Help/guides, Survey Intake and Project/Sheets; hover each warning. Assert no technical tooltip, visible plain recovery instruction, and one retained reason in the Manager trace. In a synthetic Civil drawing type CDSPINEUPGRADE, Enter/Preview, then DryRun on a separate run: both must print **Preview only. Nothing was written.** and preserve identity records. With an existing test rollback receipt, Undo and Rollback must choose the same restoration route. NOT RUN.

   **Safety/defaults/order:** no new drawing writer or automatic callback; file logging only. Existing protected-object rules, defaults, engineering values and CE_SHARED are unchanged. No overlap with the other ten PRs' source files. Exact release condition: complete its own three Civil/Manager build lanes, focused/full suites and promised real-window captures; verify native keywords before acceptance. Manager administrator work is not reopened.

5. **#1716 — HOLD until the LandXML combination and missed callers are corrected. Existing Opus conditions; no new counted fault.**

   **Snapshot:** [PR #1716](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1716) — Fix audit RD04-02, RD04-03 and RD04-04 unit conversions. Branch `cx4/fa02-units`; head `8b95539a8fc1caaf3e4096073cf6bbc346fae759`; base `claude/rel-20261023m`.

   **Opus:** HOLD. Retained, with one procedural correction: combine changes by merge, never rebase.

   **Cause real / scope:** `Commands/AgiCommand.cs:319` previously returned drawing units as millimetres; `Commands/AgiCommand.Plan.cs:124` used a 1-unit closing reach. The new conversion fixes the primary CDAGI/CDPERIMETER route. `Helpers/LandXmlParser.cs:201` converts supplied elevations before their checks. Its tests call those production paths and would fail without conversion, rather than asserting a duplicate calculation.

   **Residual and exact fixes:** `Services/LinkService.SurfaceDrainTags.cs:834` and `:845` still omit units, taking the new optional millimetre default in a metre drawing. Pass the actual owning database units at both calls, through the protected-file owner. A copied open drain can otherwise be described/planned as closed even though its copied polyline remains open; do not overstate this as proof that COPY changes its Closed flag.

   **Merge conflict:** compared the actual patches of #1707 `f9eebcfb`, #1708 `2ed82768` and this PR. They edit the same report-filter and ParseStruct/units areas. Preserve #1707's report markers, #1708's one horizontal fileScale and this PR's separate levelMetresPerUnit. Convert the cover first, then apply #1708's rounding. Do not replace either scale decision with the other. This review did not execute a merge. Add an absent-Units-element test, as distinct from an empty linearUnit attribute; current code deliberately leaves levels Unknown. Opus's separate vertical-unit/schema question remains unverified, not a new asserted defect.

   **DETERMINISTIC TEST:** two synthetic drawings, INSUNITS 4 and 6. CDAGI from 0,0 to 10000,0 mm or 10,0 m, levels 10.001 and 10.000: require 1:10000 and the office-minimum warning, not 1:10. CDPERIMETER points 0,0; 10,0; 10,10; 0,0.5 in metres, finish open, then COPY just the drain: both original and copy must retain four open vertices and open remarks/tag placement. Import a millimetre LandXML with cover 100200 and invert 100000: require RL 100.20/100.000, subject to configured display precision. Repeat without Units: Unknown with the report reason, never assumed metres. U/REDO each accepted drawing operation. NOT RUN.

   **Safety/defaults:** no new writing callback, switch or CE_SHARED change; the 1 mm reach is an existing drafting tolerance, not a new engineering rule. Locked/Xref/REFEDIT application protections are unchanged and untested here. Builder reports 26 new cases, 112 focused passes, full 19,552 passes/zero failures and all three build lanes; these are reported evidence, not my execution.

6. **#1715 — REJECT release merge; keep as an open routing record. No implemented fix and no new counted finding.**

   **Snapshot:** [PR #1715](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1715) — Audit RD05 / FA03: verified drainage-default holds (no engineering changes). Branch `cx4/fa03-drainage`; head `a477bcecb3021722804eae43fb2612d4d5b2721f`; base `claude/rel-20261023m`.

   **Opus:** REJECT at the same head. Confirmed by the complete diff: ten lines appended to REGRESSION_LOG only. The text explicitly says no engineering change and no fix; it is not a concealed implementation.

   **Cause/coverage:** the existing RD05 issues are routed to their recorded engineering/protected owners. Their original audit remains the evidence; this PR supplies no caller, repair or failing-before/passing-after test. Do not count any of its build claims as testing a repair.

   **DETERMINISTIC TEST:** applicable acceptance cases remain in `CODEX_FIXAUDIT_FA03_23OCT.md`. For this PR's actual claim, Git diff must show only REGRESSION_LOG; drawing-value assertions must match the base because no executable file differs. A native run cannot demonstrate a fix from this PR. No native test requested or run for this documentation-only change.

   **Safety/defaults/order:** REDO, protected objects, switches, engineering values and CE_SHARED all unchanged. No administrator work authorised. Unlike the other log entries, this one is appended at the old end of the file; do not assume every pair necessarily has a top-of-file log conflict. The useful routing record already exists in CE_PLAN.

7. **#1714 — REJECT release merge; keep as an open routing record. No implemented fix and no new counted finding.**

   **Snapshot:** [PR #1714](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1714) — RD08-01..03 / BUG-1064 BUG-1065 BUG-1066: protected installer routing only. Branch `cx4/fa04-rd08-desk`; head `fe99515f7af09198fd27be54cc66cdf51317bbd0`; base `claude/rel-20261023m`.

   **Opus:** REJECT at the same head. Confirmed: eleven inserted REGRESSION_LOG lines, no executable or test changes.

   **Cause/coverage:** the recorded overlap/recovery faults belong to the standalone installer. A Manager-only change cannot guard direct activation, and this PR correctly claims none. It supplies no regression that would fail without a repair. Do not repeat RD08's original faults as new group09 findings.

   **DETERMINISTIC TEST:** source assertion for this PR is a documentation-only diff. Later protected-owner tests must use disposable installer targets: pause activation A after retiring its target, complete B, fail A, and require that B is not overwritten; hold a first-install manifest during cleanup and require an explicit recovery result; force restore failure and require the saved verified backup path in the result. These are installer fixture assertions, not live AutoCAD experiments, and were NOT RUN.

   **Safety/defaults/order:** no drawing, REDO, lock/Xref/REFEDIT, settings, engineering or CE_SHARED change; no update gate was changed. Only the prepend to REGRESSION_LOG overlaps. Manager administrator development remains parked.

8. **#1705 — HOLD for the remaining Structural validation. Source review found no new product fault.**

   **Snapshot:** [PR #1705](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1705) — BUG-303 BUG-315 BUG-858: fill Structural regression scenarios (BD04). Branch `cx3/tests-bd04`; head `c181b138dfbe78b23f3d212c54213d2332b835b0`; base `claude/rel-20261023s`.

   **Opus:** no review found in the searched files, review lane or GitHub reviews/comments. Fully reviewed here. Structural only; not a Civil/Manager release payload.

   **Cause and tests:** real gaps. `Structural.Tests/Services/Bd04ScheduleRegressionTests.cs:22` tests swapped/renamed rows without changing the count, including preservation of the last-written comparison values; line 56 isolates an invalid table from a valid companion; line 82 exercises the actual cut-grid acceptance and absorption. `Structural.Tests/UI/Bd04ZPreviewRegressionTests.cs:21` invokes the actual preview geometry. Read the production AbsorbTableEdits/GridToRead and original fixes `11413b34`, `e07e99b3`, `1ea2517d`: old positional reads, old cut rejection and old 2W envelope fail these expectations. Historical execution was not performed here.

   **Evidence:** read focused TRX: ten passed, zero failed/skipped. Builder stopped at the disk floor after the hosted net10 build. Standalone lanes and full required suites remain unverified. These are not ten native schedule operations.

   **DETERMINISTIC TEST:** synthetic footing EB1, bars N16-200, note KEEP COVER; place footing and R.C beam schedules. Swap DEPTH and REINFORCEMENT rows without adding a row, run FSTEXPORT/CSRCBEAMSCHEDULE: altered table must be left alone; erase/recreate it and require stored N16-200. On a fresh intact R.C beam table type N20-150, Ctrl+X/Ctrl+V, run CSRCBEAMSCHEDULE: text remains N20-150. SBEAM Z preview and placed section must show opposing flanges/lips; the synthetic 250/125/20/5 mm geometry has width 245 mm, not 250 mm. U, REDO and save/reopen retain accepted values. NOT RUN.

   **Safety/defaults/order:** test/log files only; no REDO/protection/default/engineering/CE_SHARED change. The tests do not establish native locks, Xrefs or REFEDIT. No test-file overlap in this set. Exact HOLD exit: finish the builder's recorded outstanding Structural build/suite requirements on the pinned test source, retain its separate Structural base.

9. **#1704 — HOLD for the two outstanding build lanes. Source review found no new product fault.**

   **Snapshot:** [PR #1704](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1704) — Test BUG-005 invert-label sides and BUG-798 Pit Schedule continuation text. Branch `cx3/tests-bd01`; head `0f3289263fb373d452964b90020a07f57fe88fa2`; base `claude/rel-20261023m`.

   **Opus:** no review found. Fully reviewed here.

   **Cause/test strength:** `Drainage.Tests/Commands/Bug005EditPipeInvertSideTests.cs:22` invokes the actual Edit Pipe side reader, not only its geometry helper; `Drainage.Tests/ViewModels/Bug798ContinuationCellTextTests.cs:24` invokes the actual formatter with a blank continuation row and populated heading row. The production callers use those routines (`Commands/PipeEditCommand.Update.cs:103`, `ViewModels/PitScheduleViewModel.Schedule.cs:1289`). The six formatter cases cover all repeated pit columns. The old three-argument formatter is deliberately still callable so failure means wrong text rather than missing code.

   **Evidence:** read parent TRX six failures, focused TRX ten passes and full TRX 19,536 passes/zero failures. BUG-005's archived-parent argument remains the builder's inspected-diff reasoning; no archived parent execution was verified by me. Net48/net8 builds were stopped before starting. The separately reported BUG-006 arrow exclusion suspicion is not re-counted or presented as an established native failure.

   **DETERMINISTIC TEST:** synthetic mm rising-main route from 5000,5000 to approximately 4128.443,14961.947 (10 m at 95 degrees); invert labels offset 300 mm east/west at opposite ends. Open PIPEEDIT: choices must match the existing sides; Save unchanged and require neither label to cross the pipe. Put P12's second inlet at row 21 of a 20-row schedule; Place and Refresh. Sheet two must show P12, 900 x 900, outlet 450, IL 18.125, CL 19.25 and its lid/remarks, with that sheet's own inlet. U/REDO must restore/reapply the accepted operation. NOT RUN.

   **Safety/defaults/order:** only two new test files and the log; no production REDO, protection, Settings, engineering or CE_SHARED change. No code overlap here. Exact HOLD exit: finish the two missing build lanes and record their results; retain native workflows as unaccepted until driven.

10. **#1703 — MERGE. No new product fault. VERIFIED-BY-READING.**

   **Snapshot:** [PR #1703](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1703) — Manager: add regression cases for BUG-425 BUG-832 BUG-835 BUG-842 BUG-848 BUG-1028. Branch `cx3/tests-bd03`; head `4cb41a0b91d248408d8639d643aa501fb194f529`; base `claude/rel-20261023m`.

   **Opus:** no review found. Fully reviewed here.

   **Cause/test strength:** `Manager.Tests/Services/Bd03ManagerRegressionTests.cs:46`, `:65`, `:88`, `:111`, `:128`, `:143`, `:157`, `:174` exercise real approval reads, staging decisions, rollback copying, settings replacement, outbox filtering and support-warning methods. The stage callback records attempts instead of installing anything. Files sit under a unique temporary root, the log override is restored, and CeBlocksSettings resolves through that override. These are meaningful service tests, not disconnected literal checks.

   **Before-fix reasoning:** inspected original changes `47804bde`, `d79f8f10`, `49c930c6`, `7eaa55db`, `a1b0ddf8`. The original reader stopped later approvals, stage failure did not stop Manager, old reapproval lost prior rollback evidence, and .TMP/.BAK lacked the filter. Some newly exposed helper signatures are compile-red on their parents; not every case has an executed historical failure.

   **Evidence:** read focused nine passes, final Manager 940 passes/zero failures of 941 records, final Civil 19,526 passes/zero failures of 19,576 records. The earlier eight-failure Manager run also exists; the corrected final run is distinct, not hidden. Builder reports six successful build lanes and discloses a Civil teardown log-handle warning.

   **DETERMINISTIC TEST:** isolated profile with synthetic approvals A_Held and B_Good; hold A_Held/approved.json exclusively, open CEMANAGER and Refresh. Require B_Good remains available and the Manager trace names the held approval. Release the hold, Refresh, require both. In the isolated stage fixture fail Civil, assert attempts contain Civil and independent Structural but never Manager; no activation is required. A held CE Blocks settings destination must keep original bytes and leave no .tmp. NOT RUN by this reviewer.

   **Safety/defaults/order:** tests only; no administrator feature is enabled or resumed. No drawing writer, REDO, native protection, default, engineering value or CE_SHARED change. No test-file overlap with this set. Native startup/command-line delivery remains unproven by callback tests.

11. **#1702 — HOLD for the unresolved full-suite result. No new product fault attributed to this test-only PR.**

   **Snapshot:** [PR #1702](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1702) — BD02: add 12 Civil level, calculation, long-section and LandXML regression checks. Branch `cx3/tests-bd02`; head `4142849f7e532ab5e5d98b60d4a3d8e36d054606`; base `claude/rel-20261023m`.

   **Opus:** no review found. Fully reviewed here.

   **Cause/test strength:** `Drainage.Tests/Services/Bd02CivilRegressionTests.cs:71`, `:96`, `:112` call the real cascade planner with unknown ends, below-zero drop and a later junction. Line 130 joins the real sump-only parser to the real pipe mapper; the empty inserted-object list does not short-circuit the mapper, which still walks ProjectDataService.Current.Pipes. Line 158 independently checks Manning arithmetic against the real profile routine. Lines 188–211 exercise actual detention/solver view-model paths. Original cascade and roughness fix diffs confirm differing old results.

   **Defaults caveat:** the roughness test deliberately sets LongSectionUsesSettingsRoughness=true. It proves the ON path, not that this bug fix ships ON. The inherited default remains OFF; already-recorded BUG-542/R-00 work remains open and is not silently certified by these tests. The PR changes no default.

   **Evidence:** read focused twelve passes and full TRX 19,537 passes, one failure, 19,588 records. The blank-PDF failure is outside the new fixtures, but no current-base isolation was established. Three successful build lanes are reported. Do not call the run green merely because all twelve additions passed.

   **DETERMINISTIC TEST:** synthetic P1→P2 IL -0.900/-1.000 and P2→P3 -1.050/-1.150. PIPEEDIT the arriving end to -1.200, accept the downstream preview: outlet/next end must be -1.250/-1.350. Clear either end of the intervening pipe and repeat: neither it nor the valid pipe beyond moves. In CDCALC Detention a known DN300 end at RL 0.000 suggests TWL 0.300; a cover at 0.000 and TWL -0.100 warns of the configured shortfall. With isolated n=0.020 and roughness switch ON, DN400 at 1:100 gives about 1.077 m/s. U/REDO and saved values must agree. NOT RUN.

   **Safety/defaults/order:** only tests/log, isolated Settings scope; no new drawing write, protection bypass, engineering value or CE_SHARED change. No test-file overlap here. Exact HOLD exit: isolate and resolve/explain the failing PDF check on this base, then record a valid final required-suite result without suppressing it.

**Assembly and evidence close-out**

1. **Merge order:** the eleven scoped PRs share no source/test file with one another; REGRESSION_LOG is the common file. Ten prepend, #1715 appends. Preserve every prior entry; never resolve by dropping a side. #1716 additionally collides with the independently open #1707/#1708 LandXML changes described above. Merge those changes deliberately and validate the combined parser; never rebase. #1705 stays on the Structural line, not the Civil/Manager line.

2. **Shared/default audit:** every scoped name-only diff has zero Shared/ or CE_SHARED source changes. This does not prove compiled CE_SHARED bytes match; no binaries were built or hashed. No scoped PR adds a behaviour switch or a new hard-coded engineering value. Product fixes execute when their existing feature is used; no new OFF switch hides them. The inherited roughness switch caveat is explicitly retained under #1702.

3. **What remains untested:** every native workflow, locked-layer/Xref/REFEDIT fixture, U/REDO sequence, real window and save/reopen result in this report. No images were newly rendered or inspected. Existing TRX files are evidence of their recorded runs only. No bug was marked fixed/accepted. Only this findings file was authored; BUG_CARPARK, DESK_LOG and QUEUE were not edited.

4. **Summary — under 100 words.** Eleven PRs reviewed: two MERGE, two MERGE-WITH-FIXES, five HOLD and two documentation-only REJECT recommendations. The new HIGH finding is the pit-migration route bypassing #1721's locked-symbol check. The other fixes and regression additions largely match their stated causes, but native behaviour remains unproved and several validation records are incomplete. Retain Opus's units and modal-window conditions, merge LandXML changes together without rebasing, keep Structural separate, and leave Manager administrator development parked. Nothing was built, run or installed.

