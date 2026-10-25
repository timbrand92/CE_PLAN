# Class E positions 16–30: independent second review

1. **ANSWER FIRST — new findings: HIGH 0 / MEDIUM 1 / LOW 0.** The most important new finding is #1120: switching on its pad-label fix makes a genuine 1:1 millimetre drawing use 1:100 label heights. A 2.5 mm label becomes 250 mm. This is verified by reading; AutoCAD has not been run.

2. **Verdicts: MERGE 0 / MERGE-WITH-FIXES 13 / HOLD 2 / REJECT 0.** Hold #1120 as submitted, and #1147 pending a consistent, ON-by-default solution. The other thirteen have specific conditions below. These are review recommendations; no PR was changed or merged.

3. **Earlier work is retained, not counted again.** Thirteen PRs have a substantive review in `REVIEW_OPEN_PRS_R2_26OCT.md`. #1142 is partly covered by `REVIEW_PILE_B4_24OCT.md`, item 3. I correct the earlier approval to leave #1147 and #1152 OFF: this brief explicitly requires bug fixes ON. Existing findings, including the external-beam labelling fault, are not new findings in this count.

4. **For the release.** Civil and Manager remain the 9 November scope. Structural fixes belong on the Structural line. None of these fifteen complete PR heads is contained in either requested 22 October reference or C-63. Part of #1156 is already superseded there. The Settings-only engineering changes need actual Settings controls before they satisfy R-00.

5. **Work completed.** Read-only source and review checks, with deterministic tests specified for a later AI tester. Builds 0; test executions 0; AutoCAD sessions 0; installations 0; sub-agents 0. Only this report was authored.

---

1. **Method and pinned evidence — 26 October 2026, Melbourne.** Scope is the original class-E ordering in `PR_PILE_TRIAGE_2026-10-24.md:982`: #1029, #1120, #1135, #1139, #1142, #1144, #1146, #1147, #1150, #1152, #1154, #1156, #1157, #1159, #1161. The requested filename retains 24OCT; this review was performed on 26 October.

2. **References.** After `git fetch origin`, C-60 is `40ee0a36f7960145743954b39859eb6c3af92869`, S-41 is `2c9a96942a024888a5ab520600f2d5025de83036`, and C-63 is `5467f7053a2e9275cb450409c142ef9aa26dad53`. These are the brief's historical comparison points, not a claim about today's installed DLLs. Each PR's live head is recorded below. All fifteen were OPEN when read.

3. **Prior-review boundary.** Consulted the named C58–C60/S40–S41 audit and the CIVIL, STRUCTURAL and GATE `CODEX_AUDIT_*_22OCT.md` reports. Searched `REVIEW_*.md` and `CODEX_PR_REVIEW_GROUP*.md` for every PR number before source review. “Retained” below means the earlier reviewer owns the substantive finding; it is cross-referenced, not presented as an independent rediscovery. Their test results are not my test results.

4. **Source and integration checks.** Used `gh pr view`, `gh pr diff`, `git show`, `git grep`, ancestry checks and `git merge-tree` calculations. No source checkout was altered. The opening prohibition on creating branches or repository files overrides the later worktree boilerplate, so no worktree or branch was created. Merge-tree calculates results in Git's object database; it does not merge a working branch. One initial ancestry loop used incorrect dictionary indexing and returned invalid-ref errors; it was discarded and rerun successfully. Every final ancestry result was exit 1, not an error.

5. **Shared, installer and release boundary.** The fourteen narrow PR diffs other than #1120 change no CE_SHARED/Shared, installer or signed-update file. #1120's GitHub diff includes `CE.Host/Installer/PackageContents.xml` and `Modules/Structural/Installer/PackageContents.xml`, so the submitted PR is HOLD under this brief. Those changes come from its S-39 merge; its unique delta against S-41 is only four files. Do not mistake a whole Structural-to-Civil branch merge for a small fix: all seven Structural heads conflict widely with C-63, including installer/release and Shared files. The proper S-41 comparisons are given below.

6. **Safety limits and common deterministic probe.** In the narrow changed hunks, no PR adds an idle/timer/selection database writer, layer unlocking, Xref traversal, or bypass of REFEDIT protection. This is not whole-plugin REDO certification. For every drawing-affecting candidate, use an isolated synthetic host with a CE object P1 or PF1, a locked output layer and a synthetic Xref; also run the operation during REFEDIT. Assert no protected geometry changes and no layer unlock. In a separate unlocked fixture, type `_.LINE`, `0,0`, `1000,0`, Enter; `_.U`; wait 10 seconds; select P1/PF1, right-click and press Esc; then `_.REDO`. No intervening diagnostic command. Assert the line returns exactly and the CE object, attributes and project record have not changed between U and REDO. Instrumentation must observe without issuing commands. These probes were not executed.

7. **Settings and test conventions.** Settings fixtures mean a disposable tester profile, prepared before AutoCAD starts, never an edit to Tim's live settings. A missing UI row is a merge condition for engineering values, not an instruction for Tim to edit JSON. “Fails without the fix” distinguishes a behavioural assertion from a new helper merely failing to compile on the parent. Every native test below remains unexecuted. File:line references are at the named PR head unless explicitly identified as a reference or prior report.

## One numbered item per PR

1. **Class E 16 — #1029 — MERGE-WITH-FIXES. LOW, retained review; no new finding. Head `55883cd3cb93856782fe0c6684c3d98601c271a6`.**

   **For Tim:** the computations sheet can print its headings and practice name in black instead of blue. The cause is real: the old sheet selected a fixed blue brush. The new default is black and malformed colour text also gives black.

   **Evidence and exact conditions:** `Modules/Drainage/ViewModels/CalculationsV2ViewModel.cs:907`, `Modules/Drainage/Models/UserSettings.cs:760`; retained from round-2 item 3. Add the missing `{}` deserialisation assertion for `OptionSettings.SheetAccentColour`, document `Default: #000000`, and retain this sheet change when resolving the overlap with #1043. This is an always-active colour choice, not an OFF bug-fix switch. No engineering number or drawing writer is added.

   **Deterministic test:** synthetic calculation package with one completed section and one unsettled section. Type `CDCALC`, open its export page, click `Preview package`, then `Export to PDF`; choose Microsoft Print to PDF. Assert page 1's practice name, underline and section headings are black, while the unsettled notice stays red. Repeat with the isolated colour setting `#B8860B`: those same elements must be gold. The pre-fix hard-coded brush fails this test. `SheetAccentColourRuleTests` includes a wiring guard, but is not a PDF observation.

   **Integration and protection:** absent as a head from C-60/S-41/C-63. C-63 conflicts: `UserSettings.cs` and `REGRESSION_LOG.md`; keep both additions. Export changes no drawing geometry, locked layer or Xref. Shared/install/signing untouched.

2. **Class E 17 — #1120 — HOLD. MEDIUM, NEW F1, verified-by-reading. Head `79fc91864d87aabfe2f2df3b80a8151d6c3ff33a`.**

   **For Tim:** turning the label fix ON can make an existing footing label 100 times too tall. It treats a valid 1:1 drawing as though its scale were missing, then silently substitutes 1:100. Leaving the fix OFF avoids that new case but also leaves the reported tiny-label case unchanged.

   **Exact cause:** `Modules/Structural/Services/FoundationService.cs:5227` takes the scale returned by `ScheduleService.ResolveDrawingScale`, then line 5233 rejects every result at or below 1. Line 5234 substitutes the hard-coded 100 from `Services/ScheduleService.cs:43`. `ScheduleService.cs:101` itself correctly returns 1 for DIMSCALE 1/CANNOSCALE 1:1. Creation at `FoundationService.cs:3057` and existing-label redraw at line 3119 both consume the changed height. `Models/UserSettings.cs:1897` defaults the fix OFF; no UI reference to `PadLabelHeightFromScale` was found.

   **Deterministic test:** synthetic millimetre model-space drawing, INSUNITS 4, DIMSCALE 1, CANNOSCALE `1:1`, non-annotative text style, plotted label setting 2.5 mm. Fixture contains one tracked 600 mm square pad PF1 with its generated label initially 2.5 mm high. Enable `Layouts.PadLabelHeightFromScale` in the disposable profile before starting. Type `FREGEN` and select PF1's generated outline. Read PF1 text Height in Properties: assert 2.5 mm; the head predicts 250 mm. Repeat with DIMSCALE 0/CANNOSCALE `1:50`: assert 125 mm. The first case passes before this change and fails with it ON; the second is the intended improvement. No pixel or native result is claimed.

   **Tests and exact fixes:** `FootingLabelHeightFromScaleTests.SwitchOn_ADrawingWithNoRealScale_IsReadAsOneToOneHundred` explicitly expects the erroneous 250 for `(1,"1:1",1,true)`, so green tests entrench the problem. Preserve valid positive scales, including 1 and enlargement ratios; handle genuinely unavailable scale with a visible, Settings-backed assumption. Add an ON default and missing-key test only after the valid-scale regression is corrected, plus a Settings row. Do not solve the original ambiguity by silently calling every 1:1 drawing unscaled.

   **Scope/HOLD condition:** the GitHub diff touches the two installer manifests named above; no signed-update code is in the unique fix. Extract only the footing fix (`1ced565c`, with the relevant default-preservation change in `79fc9186`) onto the Structural release line and review the resulting narrow diff. Against S-41 its four-file unique delta conflicts only in `UserSettings.cs` and the log. Locked-layer admission precedes label redraw (`FoundationService.cs:2337` onward); the new height helper adds no drawing transaction or callback. Existing protection and REDO still require the common native probe. Do not merge the Structural branch into C-63.

3. **Class E 18 — #1135 — MERGE-WITH-FIXES. LOW, retained review. Head `17df566711a619df892a65d46ebd26b8b71cec13`.**

   **For Tim:** Structural should start with one useful line instead of a long command list. The diagnostic option being OFF means the short-line fix is active; it is not a disabled bug fix.

   **Evidence and exact fixes:** `Modules/Structural/Plugin.cs:235`, `Core/StartupBanner.cs:14`, `Models/UserSettings.cs:343`; round-2 item 17. Resolve the Plugin conflict by retaining the new loop, remove `CE_VERSION` from the optional Structural list because Manager owns it, add that name to the unavailable-command assertion, and test `{ "Diagnostics": {} }` gives the short banner.

   **Deterministic test:** disposable profile with empty Diagnostics and a normal installed test bundle. Start AutoCAD; assert one line beginning `CE Structural` and containing `loaded. Type CE_HELP`, rather than the former build/assets/runtime list. Type `CE_HELP` and assert the help window opens. Restart with `ShowFullStartupList=true`; assert the expanded list contains none of the unavailable commands pinned by `StartupBannerTests`, including CE_VERSION after correction. Parent code fails the short-banner assertion.

   **Integration/protection:** no contained head in the three references. S-41 conflicts in `Plugin.cs` and log; C-63 whole-branch merge is inappropriate. Startup text adds no geometry writer or new hard block. Shared/install/signing untouched. Native startup remains untested.

4. **Class E 19 — #1139 — MERGE-WITH-FIXES. MEDIUM, retained review. Head `6128420e16f075babf51a155c68283405cb7dabc`.**

   **For Tim:** the Enable MarkupAI box finally controls the tools, but switching it off also prevents the drafter using CE's own markup undo. That recovery route must stay available.

   **Evidence and exact fixes:** `Modules/Structural/Commands/MarkupAICommands.cs:261`, `Services/MarkupAISwitch.cs:21`, `Models/MarkupAIModels.cs:232`; round-2 item 16. Remove the CEMARKUPUNDO gate and adjust the guard-count test; add `{}` tests proving Enabled true and LearningDataOptIn false. Honour an existing explicit privacy preference. An explicit user disabling an optional feature is distinct from a new engineering refusal; blocking recovery is the retained defect.

   **Deterministic test:** fixture has a synthetic markup package with exactly one applied group and its saved undo state. Disable MarkupAI through the Settings control, then type `CEMARKUPUNDO`. Assert the group's entities return to their prior values rather than the `is switched off in Settings` line. Independently, with a new profile, inspect the markup window: Enable is ticked and Share learning data unticked. The current head fails the recovery assertion; the original parent fails the fresh privacy-default assertion. `MarkupAISwitchTests` currently pins a gate on every markup command, which must change.

   **Integration/protection:** not contained; S-41 conflicts only in log. Gates precede existing drawing preflight and do not bypass protection, but the undo path must retain that existing preflight when the extra gate is removed. No new engineering constants, Shared, installer or signing changes; no permission to add any off-PC send.

5. **Class E 20 — #1142 — MERGE-WITH-FIXES. MEDIUM, prior partial finding retained; remaining patch reviewed by reading. Head `afe77cf961e7e4b7d964d98ba1ce46a27ce00f20`.**

   **For Tim:** warnings name the edition of the standard they rely on, and the subfloor preview admits its starting span table has not been checked. The AS 3600 edition can still disagree with CE's actual standards record because it is saved as a separate editable value.

   **Evidence and exact fixes:** `Modules/Structural/Models/UserSettings.cs:98`, `Services/StandardsService.cs:73`, `UI/Dialogs/RCMemberDialog.xaml.cs:172`, `Services/TimberSubfloorService.cs:96`. Retain `REVIEW_PILE_B4_24OCT.md` item 3: make As3600 read-only, derived from ActiveConcreteEdition, and JsonIgnore; remove the test that deliberately edits that edition. Test deserialising an old file with a conflicting saved year still reports the actual implementation edition. Add Settings presentation for editable source metadata; do not pretend changing a citation changes the engineering calculation.

   **Deterministic test:** disposable profile includes a deliberately conflicting saved `StandardEditions.As3600="2017"`; the code's active standard remains AS3600-2018. Open the RC member beam window, enter 15 mm cover, and assert the warning cites `AS 3600-2018 Table 4.10.3.2`. Current head predicts 2017. With ordinary defaults, the added edition appears; parent has no edition. On a synthetic closed subfloor outline, type `CSSUBFLOORGRID` and assert preview text contains `not checked against AS 1684.2 (edition not set)` before accepting anything. `StandardCitationTests` proves formatting and source wiring, not native preview output.

   **Integration/protection:** S-41 log conflict only; not contained in any requested reference. No new switch, database writer or hard block is added; the subfloor line is before the existing confirmation. The numerical cover/spacing checks are pre-existing and are not certified as standards-compliant by this review. Shared/install/signing untouched.

6. **Class E 21 — #1144 — MERGE-WITH-FIXES. MEDIUM, retained review. Head `1402c9f818d6dd26d80aabb69226242f76984216`.**

   **For Tim:** the detention tools should use one orifice basis. As submitted, the gravity fix remains OFF and two tools still use different values.

   **Evidence and exact fixes:** `Modules/Drainage/Models/UserSettings.cs:1605`, `Services/OrificeBasis.cs:11`, `Services/AutoDesignService.cs:482`, `ViewModels/DetentionSystemViewModel.cs:16`; round-2 item 6. Set OrificeUsesRuledGravity true, use OrificeBasis.RuledGravity in the tab, and pin both switches ON for new and missing-key profiles. Retain the earlier report's cited B6 ruling of 9.81 everywhere. Add documented defaults and actual Detention Settings controls. Keep the other 0.61 sites explicitly outside this partial fix; do not mark all BUG-543 fixed.

   **Deterministic test:** synthetic proposal and Detention tab with the same coefficient 0.6, PSD 4.27 L/s and effective head 0.428 m. Type `CDCALC`, select Detention System and set matching inputs; compare with `CDDESIGN`'s proposal. Assert the underlying unrounded diameter in both equals the 9.81 formula within 0.0001 mm; approximately 55.919 mm, with matching adoption rules checked separately. A fixture assertion on the proposal value is required because a whole-millimetre displayed hole can hide this fault. Existing `OrificeBasisTests` exercises helper maths but intentionally expects 9.8 by default; correct that expectation.

   **Integration/protection:** C-63 conflicts only in log. Not contained. Pure calculation changes add no idle writes or layer/Xref access; normal proposal application remains under existing command protections. No Shared/install/signing change.

7. **Class E 22 — #1146 — MERGE-WITH-FIXES. LOW, retained review. Head `7bebd0609e0db08873f7cd7cfd6602e0b47ddccb`.**

   **For Tim:** soil, wind and schedule messages become understandable, but must not send a drafter looking for a Settings box that does not exist.

   **Evidence and exact fixes:** `Modules/Structural/Services/StructuralPlainWords.cs:12`, `Commands/SoilAndWindCommands.cs:134`, `Commands/UtilityCommands.cs:87`; round-2 item 18. Apply the three replacement sentences recorded there: soil note is not placed and may be copied by hand; bracing must be entered with CSBRACINGREQUIRED; general notes put the saved wind class into design criteria once switched on. Remove the duplicated sentence and the nonexistent Settings destination. Preserve typed command aliases.

   **Deterministic test:** synthetic job with a soil report and stored wind class; type `CSSOILREPORT` then `CSWINDCLASS`, accept a class, and capture command history. Assert no `codebase` or plan-code wording and no direction to a nonexistent Settings control. On a fixture with a Structural schedule on a locked layer, type `STRSCHEDREFRESH`, select the schedule and assert `locked` appears without the raw AutoCAD exception word; the table and layer lock must remain unchanged. The parent fails the new wording assertions. `StructuralPlainWordsTests` covers the wording and call-site strings.

   **Integration/protection:** S-41 log conflict only; not contained. Text replacement is always active, adds no block, and leaves the original protected-write path intact. Shared/install/signing untouched.

8. **Class E 23 — #1147 — HOLD. MEDIUM, correction to the earlier approval; not a newly counted code fault. Head `d5b962695c781c351bf488efe245cbfb6776a4d8`.**

   **For Tim:** on a fresh setup a uPVC pipe flowing at 4 m/s can still pass one check and warn in another. The earlier review expressly approved shipping the consistency fix OFF. That does not meet this brief.

   **Verified-by-reading:** `Modules/Drainage/Models/PipeSpeedChecksSettings.cs:17` defaults UseMaterialLimit false; `Services/SettingsSizingStandards.cs:70` also falls back false. `InspectorPaletteService.cs:3318` uses that choice, while the rulebook uses the material limit. Round-2 item 4 already identified the omitted cascade caller and the unconfirmed material figures; those are retained, not rediscovered here.

   **Exact release conditions:** agree the governing material limits through the existing engineering authority, expose them in Settings, make the consistency fix ON for new/missing keys, and wire the cascade caller as specified in round-2 item 4. Until that is settled, HOLD rather than merging a claimed fix that starts inactive. Preserve explicit OFF only as the deliberate rollback setting. Add default/deserialisation and real caller tests; the five `PipeSpeedLimitTests` pass supplied booleans to a pure helper and do not prove the default or cascade wiring.

   **Deterministic test:** synthetic P1–P2 uPVC pipe with recorded full-bore velocity 4 m/s, office maximum 6 m/s and fixture material maximum 3 m/s; no project override. Start with no pipeSpeedChecks key. Select the pipe for the Inspector, run `CDRULES`, and run the network audit. Assert all three give the same over-limit warning and name 3 m/s; current head predicts no Inspector over-limit warning. Repeat the Edit Pipe cascade preview and assert agreement. These values are test inputs, not a standards recommendation. With explicit OFF, assert the documented old behaviour remains available.

   **Integration/protection:** C-63 conflicts in UserSettings and log; not contained. Changed paths calculate warnings, add no hard block or autonomous drawing write. Common REDO/protected-content probe remains required. Shared/install/signing untouched.

9. **Class E 24 — #1150 — MERGE-WITH-FIXES. MEDIUM, retained review. Head `72e6b48ea5bc6f84ba1f290b2ff657ca573c1282`.**

   **For Tim:** the minimum slab falls can follow office Settings, but the PR only supplies file values, and its written test example has the direction of the fall change backwards.

   **Evidence and exact fixes:** `Modules/Drainage/Services/SlabService.cs:232`, `Models/SurfaceFallSettings.cs:14`; round-2 item 7. Put the settings in the existing surface group, document defaults, add the real Settings controls, and change the test example to pavers 1 in 70 with an actual fall of 1 in 60. A 1 in 40 requirement is steeper, not more permissive. The 50/67/100 defaults retain existing behaviour; their engineering source is still unconfirmed.

   **Deterministic test:** synthetic paver slab with a measured 1 in 60 fall. Set the paver minimum to 1 in 70 in the completed Settings UI; type `CDSLAB` to inspect the slab, select it for Inspector, and open `CDDASHBOARD`. Assert no minimum-fall warning in each. Change the minimum to 1 in 50 and assert each warns. The fixed old minimum fails the 1 in 70 case. `SurfaceFallSettingsTests` tests the reader's numbers and old-file defaults, not all native call paths.

   **Integration/protection:** C-63 UserSettings/log conflicts; not contained. Setting reader is always active and adds no engineering refusal or geometry write. Existing slab protections are unchanged. Shared/install/signing untouched.

10. **Class E 25 — #1152 — MERGE-WITH-FIXES. MEDIUM, corrected merge conditions; existing defects not recounted. Head `117a631fad8054cea95ff9639d2e9f3d6dd9fd64`.**

    **For Tim:** changing Minimum outlet drop to 40 mm still leaves CDRULES checking 20 mm on a fresh setup. The earlier review's instruction to leave this fix OFF is overridden by the current brief.

    **Verified-by-reading and exact fixes:** `Modules/Drainage/Models/SharedValueSettings.cs:17`, `Rules/RulebookValues.cs:233`, `Services/SharedValueRule.cs:13`. Change the default and null/missing fallback to ON, with new-object, `{}` and explicit-OFF tests. Retain round-2 item 5's finite whole-millimetre check and warning fallback for invalid input, and include the effective box value in saved criteria staleness detection when ON. Preserve project-specific overrides. Add the switch to Settings and identify the one authoritative drop control. No new prohibition on drawing is needed.

    **Deterministic test:** synthetic network with a pit whose inlet-to-outlet drop is 30 mm, no project override, office DesignStandards drop 20 mm, and Minimum outlet drop box 40 mm. Omit sharedValues from the profile. Type `CDRULES`: assert its effective required drop is 40 mm and the 30 mm pit is flagged; the head uses 20 and misses that case. Change the box after saving a rules run: assert the old result becomes stale. In separate fixtures, 25.5 mm and Infinity must produce the specified warning/fallback rather than an unexplained Unknown. The existing test explicitly pins missing keys to OFF and must be corrected.

    **Integration/protection:** C-63 UserSettings/log conflicts; not contained. Resolution changes values, not drawing objects; no new callback, layer override or hard block. Shared/install/signing untouched. This remains a partial BUG-545 fix.

11. **Class E 26 — #1154 — MERGE-WITH-FIXES. MEDIUM, retained review. Head `542c1afe7ec16d2f103774fe48676662c67f0a39`.**

    **For Tim:** the current PR does not leave an unknown-size pad untouched, despite its title. It still draws the placeholder and adds a warning in FST, but only when its new switch is ON.

    **Evidence and exact fixes:** `Modules/Structural/Services/FoundationService.cs:2411`, `Models/UserSettings.cs:1240`, `Core/Footings/UnknownPadSizePolicy.cs:19`; round-2 item 15. Ship the warning ON, add missing-key/OFF tests, say `600 mm placeholder size`, and describe FST as the place the warning appears. Retain the unknown recorded size; do not silently save 600 as an engineered size. The choice of a visible unknown-size tag is outside this patch; the warning alone is not proof of that larger solution.

    **Deterministic test:** fixture PF3 is a tracked pad with SizeX 0, a point driver rather than a closed outline, and a default placeholder of 600 mm. With no new switch key, type `FREGEN`, select its existing generated outline, then `FST`. Assert the PF3 issue says `size not recorded`, `600 mm` and `FEDIT`, while the record's size remains unknown. Current head omits the warning. A companion pad with a genuine closed outline must retain that outline without the placeholder warning. `UnknownPadSizeTests` covers the policy, but currently locks in OFF.

    **Integration/protection:** S-41 log conflict only; not contained. Warning is inserted into existing regeneration, without new layer unlock or bypass. Common protection/REDO probe applies. No Shared/install/signing change.

12. **Class E 27 — #1156 — MERGE-WITH-FIXES, connection-pipe commit only. MEDIUM, retained review. Head `45f4f520910c9cb27ce3c1eaf694d1180b9f5790`.**

    **For Tim:** CDDESIGN can state and use the assumed length/material of its connection pipe. The other half of this PR would duplicate the X-Civil level-range settings already present in the requested installed reference.

    **Evidence and exact fixes:** `Modules/Drainage/Services/AutoDesignService.cs:664`, `Models/ConnectionPipeAssumption.cs:18`; round-2 item 8. Take commit `45f4f520` only, omit `93fdfef3`. C-60 already has `XcivilImportSettings.LevelRangeFollowsSettings` at UserSettings line 2710 and its reader at `XcivilLayerRecognition.cs:92`; absence of the whole PR head does not mean that feature is missing. Add defaults documentation and Settings controls. Say the pipe size “assumes” the configured length/material; do not say it has been sized successfully before sizing has succeeded.

    **Deterministic test:** synthetic design proposal with a connection pipe, no actual connection geometry requirement, isolated assumption 20 m UPVC. Type `CDDESIGN`; assert proposal text says `20 m` and `UPVC` as assumptions and the sizing input uses 20 m. Run a fixture where sizing fails; the text must not claim successful sizing. Existing parent supplies 10 m and fails the configured-input assertion. Existing X-Civil fixture tests must continue to use the already installed setting rather than a second key. `ConnectionPipeAssumptionTests` needs the corrected sentence expectation.

    **Integration/protection:** whole PR conflicts with C-63 in UserSettings, XcivilLayerRecognition and log. Do not resolve that by replacing installed recognition logic. No contained whole head; part superseded. The retained calculation slice adds no layer/Xref write or hard block. Shared/install/signing untouched.

13. **Class E 28 — #1157 — MERGE-WITH-FIXES. HIGH, retained earlier finding, not a new HIGH count. Head `bce513a2678a1fcfa8fc63e944ca1d1e87d4e967`.**

    **For Tim:** adopting a raft must not silently classify an external beam as internal. The earlier reviewer already found that the label lookup misses EB labels, even though the new decision helper can understand them.

    **Evidence and exact fixes:** `Modules/Structural/Services/FoundationService.cs:1493` searches using InternalBeam, while `Core/Footings/AdoptBeamKindAsk.cs:16` understands EB; round-2 item 14. Add the combined nearest IB/EB lookup described there, ship AdoptAsksUnlabelledBeamKind ON, add missing-key and explicit-OFF tests, and use the specified plain question. The thirteen helper/source tests do not prove an actual EB label reaches the helper. Keep Esc before any adoption write; asking a question is not a new engineering hard block.

    **Deterministic test:** synthetic raft outline with three beam lines: EB1 label beside the first, IB1 beside the second, and no label beside the third. Start with no switch key. Type `FADOPT`, choose `Raft`, select the raft outline. Assert EB1 remains External without being asked as unlabelled, IB1 remains Internal, and the third line prompts External/Internal. Answer External and inspect the stored kinds in FST. Repeat on a fresh copy and Esc at the question: assert zero adopted elements. The current head fails the default question and EB recognition cases. No duplicate new finding is claimed here.

    **Integration/protection:** S-41 log conflict only; not contained. Keep this on Structural, not C-63. Run the common locked/Xref/REFEDIT and U/REDO probes before acceptance. No Shared/install/signing changes.

14. **Class E 29 — #1159 — MERGE-WITH-FIXES. MEDIUM, retained review. Head `e3700167d1aba75de9f3550836b0b69595d04a7f`.**

    **For Tim:** WSUD targets and charged-system starting figures can follow Settings. Resolving its clash by taking the old PR file wholesale would throw away later fixes that distinguish unknown results.

    **Evidence and exact fixes:** `Modules/Drainage/Models/TabStartValueSettings.cs:12`, `ViewModels/ChargedSystemCalcViewModel.cs:153`, `ViewModels/WsudViewModel.cs:23`; round-2 item 9. Keep the target branch's ChargedSystemCalcViewModel and change its entry-coefficient read to `Tab.EntryCoefficientUsed`, preserving unknown-result and warning logic already on that target. Add documented defaults and Settings controls for the eleven keys; remove the unused SourceWords property/test, or actually display a reviewed source statement. Do not treat the retained starting figures as newly verified council requirements.

    **Deterministic test:** disposable profile sets `wsudTab.targetTnPct=50`. Type `CDCALC`, open WSUD and assert the nitrogen target reads 50; parent reads 45. In a separate profile vary only `chargedTab.downpipeEntryCoefficient` from 0.82 to 0.70 with otherwise identical valid inputs; assert the charged result uses the latter coefficient. Repeat with missing required head/input data: assert the target branch's Unknown behaviour survives. `TabStartValueSettingsTests` primarily tests the settings objects, so add window/view-model wiring assertions for these cases.

    **Integration/protection:** C-63 conflicts in UserSettings, ChargedSystemCalcViewModel and log; not contained. No new drawing writer, layer override, hard block, Shared, installer or signing change. Always-active settings readers, not OFF bug fixes.

15. **Class E 30 — #1161 — MERGE-WITH-FIXES. MEDIUM, retained review. Head `344a57424122d970ece105e1e38027007561f720`.**

    **For Tim:** changing the new trench-grate length setting does nothing. An LPD failure can also keep saying “within 2.5m” after its search distance has been changed.

    **Evidence and exact fixes:** `Modules/Drainage/Models/ReachSettings.cs:16`, `Commands/LpdCommand.cs:107`, `Commands/StripDrainCommand.Plan.cs:108`; round-2 item 10. Remove the unused trench-grate property, derive the LPD message from the actual configured distance, document defaults, remove the unused old floor-waste constant, and add Settings controls for the effective values. Preserve the existing JOIN unit conversion. Existing raw-unit limitations in other commands were already recorded by the prior review and are not counted again.

    **Deterministic test:** synthetic millimetre straight strip-drain run 18,000 mm long with identical end conditions. With floorWasteSpacingMm 12,000, run `CDSTRIP`; repeat on a fresh copy with 6,000. Assert the latter layout uses the configured smaller maximum spacing, measured between floor-waste insertion points; parent ignores the change. Separately set lpdOtherBlockSearchMm to 1,000, place an ordinary selected block with no pipe end within 1,000 mm, and type `LPD`: assert the command-line failure names 1 m, not 2.5 m. `ReachSettingsTests` exercises values but does not execute these command readers.

    **Integration/protection:** C-63 UserSettings/log conflicts; not contained. These readers run inside existing drawing operations; they do not add background writes or change locked-layer/Xref admission. Common native safety probe is still owed. No Shared/install/signing change.

## Summary

1. **Summary.** Fifteen PRs covered: two HOLD, thirteen MERGE-WITH-FIXES. One new MEDIUM fault: #1120 silently expands genuine 1:1 footing labels to 1:100. Earlier OFF-by-default approvals for #1147 and #1152 do not meet this brief. Other findings remain attributed to their existing reviews. Keep Structural separate from C-63, avoid #1156's duplicate range settings, preserve later charged-system fixes, and complete required Settings controls. No builds, tests, AutoCAD sessions or source edits were performed. No bug is marked fixed or accepted.
