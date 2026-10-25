1. **ANSWER FIRST — class E, positions 46–60.** Reviewed on 26 October 2026, about 06:51 Melbourne time. **New findings: HIGH 0 / MEDIUM 1 / LOW 0.** Earlier findings are carried by reference and are not counted again. **Verdicts: 4 MERGE / 2 MERGE-WITH-FIXES / 4 HOLD / 5 REJECT.**

2. **Most important finding — #1419 still disconnects a pipe's break symbol during repair.** The revised repair can keep the pipe's identity while deleting its link to the zigzag symbol. The symbol-following code then has nothing to move. The link loss is verified by reading; the visible result needs the drawing test in item 15. The two corrections requested by the earlier review are present, but do not cover this case.

3. **What can proceed.** Retain MERGE for #1243, #1341, #1385 and #1386, with the existing review limits. #1245 needs its fix enabled by default. #1419 needs the symbol-preservation repair and a test through the real repair routine. These are review recommendations, not permission to merge or evidence of acceptance.

4. **What stays parked.** #1235 is HOLD because this brief requires HOLD for installer changes; its useful behaviour is already present. #1246, #1260 and #1383 remain HOLD. #1236, #1238, #1242, #1256 and #1384 remain REJECT. Leave all PRs open; this session changed none.

5. **What was actually done.** Source reading and Git comparisons only. Builds: 0. Tests executed: 0. AutoCAD sessions: 0. No install, code edit, branch creation, PR comment or sub-agent. Only this findings file was authored. The test steps below are for the later automated tester, not work for Tim.

---

1. **Scope, prior reviews and evidence standard.** The exact input is the numbered class-E section of `areas/PR_PILE_TRIAGE_2026-10-24.md`, not its ranked shortlist. Positions 46–60 are #1235, #1236, #1238, #1242, #1243, #1245, #1246, #1256, #1260, #1341, #1383, #1384, #1385, #1386 and #1419. Searched `REVIEW_*.md` and `CODEX_PR_REVIEW_GROUP*.md` before inspecting PRs. All 15 are covered by [Opus batch 5](REVIEW_PILE_B5_24OCT.md) or [Opus batch 6](REVIEW_PILE_B6_24OCT.md). Fourteen heads are unchanged; #1419 advanced from 6199df19 to f0a87b5a. Unchanged reviews were screened for continuing applicability rather than independently repeated. Their detailed safety conclusions remain attributed to those reviews.

2. **Pinned comparisons.** Read Git objects in detached worktree `C:\ce-cx\review-group13-24oct`. Civil/Manager comparison: `origin/claude/rel-20261022m` = `40ee0a36f7960145743954b39859eb6c3af92869`; Structural: `origin/claude/rel-20261022s2` = `2c9a96942a024888a5ab520600f2d5025de83036`. These are the brief's installed-code baselines, not a fresh claim about today's DLLs. Current fetched C-63: `origin/claude/rel-20261024m` = `5467f7053a2e9275cb450409c142ef9aa26dad53`, later than the 28987b73 used by Opus. Read `gh pr view` and `gh pr diff --repo timbrand92/CE_ACAD_PLUGIN` for all 15. None of their complete heads is an ancestor of its nominated installed baseline or C-63; equivalent fixes can nevertheless be present, as detailed below.

3. **Conflict checks and safety limits.** Git merge-tree simulations changed no checkout, branch or index; they only created Git objects. Civil/Manager conflict results below are against pinned C-63. Structural branch-to-C-63 simulations produce broad pre-existing line-divergence conflicts: do not combine those release lines. Structural results below therefore name the separate S-41 baseline. A conflict-free source merge is not a build. No native Undo/Redo, locked-layer, Xref or REFEDIT behaviour is claimed as tested.

4. **Shared checks.** The PR file inventories contain no CE_SHARED changes. #1235 touches `Modules/Manager/Services/CePluginInstallerService.cs`, so HOLD applies even though the per-user target already exists. No other scoped PR delta touches installer or signed-update code. Unchanged reviews report no newly added engineering constants or hard blocks; #1341's 50 mm is an existing pick reach, not a design criterion. UI, help and tests-only deltas add no drawing writer. #1419's added writes are in explicit CDREBUILD, not an automatic interval between U and REDO. #1245 still has an OFF bug-fix default; #1419 is ON and #1383's picture switch is ON despite its stale title. Existing switches exposed by #1246 are not changed by it.

5. **Exclusions and labels.** Read the nominated 22 October audit records: `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md` and `CODEX_AUDIT_STRUCTURAL_22OCT.md`. Their installed-code findings are not repeated here. VERIFIED-BY-READING means an identified source path or Git comparison, not a live pass. RETAINED means the unchanged Opus verdict is carried, not independently re-certified. SUSPECTED applies to unobserved host outcomes. All deterministic tests below are NOT RUN. File lines refer to the stated PR head unless an installed baseline is named.

---

1. **Position 46 — [#1235](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1235), c8f2598f — HOLD. No new defect counted; installer gate.**

   **Prior review and correction:** batch 5 item 4 says REJECT as superseded. The underlying conclusion remains sound, but this brief explicitly says installer files mean HOLD. Manager administrator work remains parked.

   **File:line / cause:** `Modules/Manager/Services/CePluginInstallerService.cs:207` introduces `FirstInstallBundleFolder`; `:227` uses it for a first staging target. The old ProgramData target was real at the PR base. At installed 40ee0a36, the equivalent helper already exists at `:44`, from 280e7681. Registry and window checks use that per-user destination too. This changes a staging target; it does not establish a working first-time installer.

   **AutoCAD scenario:** a colleague prepares a tool not yet installed. A machine-wide target requires permissions the colleague may not have; the existing installed fix already chooses the user's own AutoCAD plug-in folder.

   **Deterministic test:** isolated standard-user profile and synthetic approved test bundle, no existing test-tool install. Open CEMANAGER and click that row's “Get update ready”. Assert the staged record's intended destination equals that profile's AppData Autodesk ApplicationPlugins test bundle path, the live bundle is still absent, and the window says prepared rather than installed. This is staging only; do not activate a real bundle. The PR's helper/source tests distinguish its old base but add no proof of the separate installer.

   **Integration/safety:** C-63 conflicts in the installer service, two Manager test files and REGRESSION_LOG. No drawing edit, layer/Xref/REFEDIT route or new switch. Do not resolve these conflicts into a duplicate installer change.

2. **Position 47 — [#1236](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1236), 47813304 — REJECT, superseded. No new finding; RETAINED.**

   **File:line / cause:** `Modules/Manager/Services/CeFeedbackInboxService.cs:36` adds the administrator-only count; `CeReleaseStatusService.cs:220` applies it. The feedback count and “Send waiting reports” wording problems were real. Equivalent production changes are already in installed 40ee0a36 through f31c325f; batch 5 item 5 remains applicable.

   **AutoCAD scenario:** an ordinary colleague sees an office-wide feedback count they cannot manage, or hover text promises to send support ZIPs that this button does not send.

   **Deterministic test:** detached non-administrator profile, synthetic office inbox containing four reports. Open CEMANAGER; assert no administrator inbox count is shown. Hover “Send waiting reports”; assert its text explicitly says support ZIP files are not sent. Repeat with an administrator fixture and assert count 4. The unit callback test additionally asserts the colleague route never reads the inbox. No reports are to be sent.

   **Integration/safety:** C-63 conflicts in the inbox/status services, Manager window, disabled-reason text, related test and log. No drawing writer, engineering value, protection change or new switch. Administrator work is not reopened to merge duplicate code.

3. **Position 48 — [#1238](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1238), da33bd23 — REJECT, superseded. No new finding; RETAINED.**

   **File:line / cause:** `Modules/Manager/Services/CeStartupLines.cs:1` and `Modules/Manager/Plugin.cs:164`. The PR replaces raw failure text and hides the administrator command from ordinary colleagues. Installed `CeManagerStartupWords.cs:6` and `Plugin.cs:190` already do this via 4d8ce52a. Batch 5 item 6 remains applicable.

   **AutoCAD scenario:** startup prints technical exception details or advertises CEMANAGERADMIN to someone who cannot use it.

   **Deterministic test:** fresh detached colleague profile; start AutoCAD and capture the command history. Assert CEMANAGER and CEHEALTH are advertised and CEMANAGERADMIN is absent. In an isolated injected menu-failure fixture, assert one plain message points to restart/CEHEALTH and the raw synthetic exception appears only in the diagnostic trace. The PR's string/source tests distinguish its old base, not a new installed defect.

   **Integration/safety:** C-63 conflicts in Plugin.cs, CeSuiteManagerMenuService.cs and the log. Wording/diagnostic changes only; no engineering value, drawing mutation or protection change.

4. **Position 49 — [#1242](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1242), 85730fdb — REJECT, superseded for the claimed duplicate-number bug. No new finding; RETAINED.**

   **File:line / cause:** `Modules/Drainage/Commands/PitCommand.cs:990` adds the string-list numbering rule. Installed 40ee0a36 `PitCommand.cs:1044` already calculates an unused number, called at `:1087`. The old count-only logic could name a new pit SPS3 when SPS1 and SPS3 already existed.

   **Important distinction:** the PR chooses SPS4; installed code chooses SPS2. Both prevent this duplicate. Batch 5 item 7 correctly leaves “fill a gap versus never reuse” as an unresolved policy choice. Do not describe these implementations as identical or decide that policy through a bug merge.

   **Deterministic test:** synthetic drawing with SPS1 and SPS3, no SPS2. Type PIT, choose the SPS pit type, place one pit and Esc. Assert three distinct pit numbers in the drawing and schedule. Under the installed rule the new label is SPS2; under this PR it is SPS4. The PR's gap test fails on its count-based base. That difference alone does not authorise changing the installed numbering policy.

   **Integration/safety:** C-63 conflicts in PitCommand.cs and log. The delta changes numbering, not placement protection; locked-layer/Xref/REFEDIT safeguards were not re-audited. No added engineering constant, switch or hard block.

5. **Position 50 — [#1243](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1243), 9f96e506 — MERGE. No new finding; RETAINED.**

   **File:line / cause:** `Modules/Drainage/Assets/Help/guide-content.js:113`; test `Modules/Drainage.Tests/Services/HelpGuideCoverageTests.cs:49`. Adds only the Undo and Redo heading and advice to use Redo before changing drawings. Batch 5 item 8 cites driver run 19 for the native behaviour; this session did not repeat or independently establish that native result.

   **AutoCAD scenario:** a drafter undoes work, changes the view in another drawing, returns and finds Redo unavailable. The help gives the existing recorded workaround.

   **Deterministic test:** open CE Civil Help using CDHELP, open the guide introduction, and assert “Undo and Redo” plus “Press Redo before you switch drawings.” are visible before “Start with a task”. The added exact-content test distinguishes the base; the sentence is absent from both pinned Civil and C-63 source. This is a documentation test, not proof of every AutoCAD release's behaviour.

   **Integration/safety:** C-63 conflict only in REGRESSION_LOG; keep both entries. No setting, database operation, system-variable write, geometry, protection or engineering change.

6. **Position 51 — [#1245](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1245), 9f6c124d — MERGE-WITH-FIXES. Existing MEDIUM retained, not counted again.**

   **File:line / cause:** `Modules/Structural/Models/UserSettings.cs:308` defaults LeaveAlone to false; `Services/CuiMenuGeneratorService.cs:1423` asks the new policy. Installed S-41 still unconditionally writes MENUBAR=1 at `CuiMenuGeneratorService.cs:1419`. Batch 5 item 9 remains applicable.

   **AutoCAD scenario:** a drafter hides the classic menu bar, restarts, and Structural brings it back. The default still permits the behaviour this PR claims to fix. The same-value write is removed, which is useful, but does not fix the default hidden-bar case.

   **Exact fixes:** default LeaveAlone to true, including a missing MenuBar group; change the test that presently demands false. Retain the explicit CEADMIN repair override and the no-write-when-already-1 rule. The switch is not an engineering number.

   **Deterministic test:** isolated settings without MenuBar, set MENUBAR to 0 and restart AutoCAD. Assert MENUBAR remains 0. Then use CEADMIN's menu repair and assert it becomes 1. Separately draw a line, U, allow a normal menu-load opportunity without typing another command, REDO; assert the line returns and a passive observer records no background MENUBAR write. Current policy tests prove branches by reading, not this host interval.

   **Integration/safety:** S-41 merge conflicts only in the log. Structural remains separate from C-63. No entity/layer/Xref writer added. The changed default and native REDO check remain required before acceptance.

7. **Position 52 — [#1246](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1246), eea027eb — HOLD. Existing integration defect retained, not counted again.**

   **File:line / cause:** `Modules/Drainage/ViewModels/AdvancedSettingsViewModel.NewFeatures.cs:67` declares RecordPipeEndsOffPit; installed and C-63 already declare it in `AdvancedSettingsViewModel.NewerTools.cs:38`. Batch 5 item 10 identifies the duplicate declaration and old window layout. This session independently verified those two declarations, without compiling.

   **AutoCAD scenario:** the intended Settings page exposes currently hidden choices and engineering values. The old PR cannot simply be combined with today's window; it introduces a second declaration and clashes with existing controls. A build failure means no usable replacement window reaches the drafter.

   **Exact fixes:** reconstruct only the missing rows on the current Settings window; remove the duplicate property/control and share the existing save route. Reconcile the carried #1208 engineering rows. Keep warning-only range handling and changed-values-only saves. Remove internal review instructions from colleague-facing wording. Verify each engineering row reaches its actual consumer; Opus explicitly did not establish that.

   **Deterministic test:** after reconstruction, isolated settings with distinct known values. Open CESETTINGS, change only “record pipe ends off a pit”, Save, reopen and read the actual settings file. Assert exactly one control/property owns that setting, the changed value persists, and unrelated values remain byte-equivalent in meaning. Repeat with one engineering row and run its consuming command on a synthetic drawing, asserting the selected value changes the advertised result. Existing binding/round-trip tests are useful but do not prove every consumer.

   **Integration/safety:** C-63 conflicts in CivilSettingsView.xaml, AdvancedSettingsViewModel.cs and log. No automatic drawing writer introduced; geometry protections are outside this UI delta. R-00 is the reason to complete the rows, not a reason to merge the stale window. Native appearance and consumer effects remain untested.

8. **Position 53 — [#1256](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1256), b56b2250 — REJECT, already present. No new finding; RETAINED.**

   **File:line / cause:** `Modules/Drainage.Tests/ViewModels/PitScheduleRemarkPreservationTests.cs:14`. Both the PR and installed 40ee0a36 have exactly blob `7bffce10f3535e37b23d756d54a0abd622752fc5`. Batch 5 item 11 identifies the corresponding installed repair. This PR is tests only, not another repair.

   **AutoCAD scenario:** a custom Pit Schedule remark adjacent to “With Step Irons” must survive removal/recalculation of the generated warning.

   **Deterministic test:** synthetic deep pit with a generated step-irons note. Open PITSCHEDULE, type “CHECK COVER” in its Remarks cell, commit the cell, close and reopen the schedule. Change the pit depth so the generated note no longer applies, refresh the schedule, and assert “CHECK COVER” remains in both the window and placed schedule text. The existing test covers the production text parser only; it explicitly does not certify the whole edit lifecycle.

   **Integration/safety:** C-63 conflict only in log; no production delta, switch, engineering value, layer/Xref/REFEDIT or REDO change.

9. **Position 54 — [#1260](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1260), 6e01714a — HOLD. Existing test gap retained, not counted again.**

   **File:line / cause:** `Modules/Structural.Tests/UI/ChecklistLifecycleRegressionTests.cs:28` accepts any of DocumentToBeDestroyed, DocumentDestroyed or DocumentBecameCurrent reaching LoadChecklist. Batch 5 item 12 records the still-missing close refresh. This is an intentionally failing regression guard with no production repair.

   **AutoCAD scenario:** close the final drawing while Structural's checklist is open; the closed drawing's checklist can remain visible. A pre-close read alone need not clear it after there is no current drawing.

   **Exact fixes:** deliver with the real close/no-current-drawing repair. Require a post-close/no-current result, not merely a reachable LoadChecklist call before destruction. Keep subscription-disposal coverage. Event timing remains a native check; a compiled call-graph test does not prove it.

   **Deterministic test:** one synthetic drawing A with a distinctive checklist item “A ONLY”. Open the Structural palette's Checklist, verify “A ONLY”, then CLOSE the final drawing without saving. Assert the palette shows “No drawing open”, no “A ONLY” item and no enabled drawing action. Open a different blank drawing B; assert no item from A remains. Before the repair this is the intended red case; no test was executed here.

   **Integration/safety:** S-41 conflict only in log; not for C-63. Tests-only delta cannot fix or worsen drawing protection, engineering values or REDO behaviour.

10. **Position 55 — [#1341](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1341), 4771157c — MERGE. No new finding; RETAINED.**

   **File:line / cause:** `Modules/Drainage/Rules/FallArrowGeometry.cs:113` converts drawing length; `Commands/FallSuggestCommand.cs:183` converts spot-level pick reach. Installed Civil and C-63 still use raw drawing length at `FallArrowGeometry.cs:112`. Batch 6 item 1 remains applicable.

   **AutoCAD scenario:** a 20 m run falling 0.200 m in a metre drawing was read as 20 mm and suggested 1:0.1, not 1:100. The old 50-unit spot search also reached 50 m instead of 50 mm.

   **Deterministic test:** synthetic metre drawing, INSUNITS 6, CDSL spot at (0,0) RL 12.300 m and grated pit at (20,0) cover RL 12.100 m. Type CDFALLSUGGEST, pick the spot and assert suggested grade text 1:100. On a separate attempt pick (0,1), with no nearby level: assert “No spot level here” and the level prompt, rather than adopting the spot a metre away. Millimetre control uses a 20000 mm separation and must also show 1:100. Added arithmetic and source-wiring tests distinguish the base by reading.

   **Integration/safety:** C-63 conflict only in log. Unitless drawings still use the existing millimetre assumption; do not count this as support for a metre drawing labelled unitless. No new switch, hard block, engineering default or output-protection change. Native placement and U/REDO remain untested.

11. **Position 56 — [#1383](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1383), 4a5db9f7 — HOLD. Existing stacked-code conflict retained, not counted again.**

   **File:line / cause:** installed S-41 `Modules/Structural/UI/Dialogs/HatchPreviewGeometry.cs:273` is the invalid-scale preview route identified by batch 6 item 2. PR `Models/UserSettings.cs:1910` has HatchPreviewPictureAtAnyScale=true. The title saying OFF is stale; do not use it as evidence of the current default.

   **AutoCAD scenario:** CEHATCH at DIMSCALE 1 shows words instead of pattern pictures on affected cards. The preview-only change addresses that, but the branch carries an older density implementation through its #1382 base. S-41 already has the later density repair.

   **Exact fixes:** extract the picture-only change onto the current Structural line; omit the old dots-density switch/helpers/tests. Adapt the preview argument and tests to the installed paperDensity API; retain the ON picture default. Batch 6's note that the inherited density switch is OFF is separate from the ON picture switch.

   **Deterministic test:** synthetic drawing DIMSCALE 1; type CEHATCH. Assert each affected Load-bearing wall, Earth and Concrete card contains pattern geometry plus its explanatory note. At DIMSCALE 20 assert normal pictures remain. Cancel and assert the drawing's entities and layer records are unchanged. This PR is not authority to add a new placement hard block; native hatch-scale behaviour is outside the preview-only repair.

   **Integration/safety:** S-41 conflicts in HatchCommands.cs, HatchUpgradeCommands.cs, UserSettings.cs, SettingsService.LoadRecovery.cs, CeHatchPresetDialog.cs, HatchPreviewGeometry.cs and log. This independently confirms the need to extract the fix, rather than merge its ancestry into C-63. Preview delta writes no drawing; picture tests do not certify the inherited hatch writers.

12. **Position 57 — [#1384](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1384), 3d35f602 — REJECT under Tim's recorded decision. No new finding; RETAINED.**

   **Authority and file:line:** `decisions/2026-10-18_CEMEMBER_DESIGN.md:50` explicitly says #1384 stays open and is not merged. The side-elevation drawing changes are in `Modules/Structural/Services/StructuralDetailService.cs:741`, with preview changes in `UI/Dialogs/SteelSectionPickerDialog.Preview.cs:182`; the PR diff introduces a flange-line switch rather than implementing the later agreed view rules. Batch 6 item 3 remains applicable.

   **AutoCAD scenario:** the OFF switch suppresses inner flange lines which Tim subsequently said to keep. A technically functioning switch is not evidence the requested design is still wanted.

   **Deterministic test of the retained design:** synthetic millimetre drawing, SBEAM, select 310UB32, Side Elevation, place a 6000 mm member. Assert flange lines remain on the prescribed layers and match the approved side-elevation design. Compare with the PR's OFF fixture: it suppresses those lines. Its existing tests demonstrate that switch behaviour; they do not override Tim's decision.

   **Integration/safety:** inherits #1383/#1382 and the same seven S-41 conflicts. No reason to merge into C-63. No fresh re-audit of drawing protection was performed for a design-rejected change; leave it open and do not ship it.

13. **Position 58 — [#1385](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1385), cc6a5c58 — MERGE. No new finding; RETAINED.**

   **File:line / cause:** `Modules/Structural/UI/Dialogs/RCBeamPickerDialog.xaml.cs:300` and `:357` reposition the two affected thumbnails. Installed S-41 still has the old calculations at `:277` and `:333`. Batch 6 item 4 remains applicable: Type 2 and Type 6 reach above their picture boxes.

   **AutoCAD scenario:** RCBEAM's Edge Upstand and Upturn + Rebate pictures appear cut off at the top.

   **Deterministic test:** open RCBEAM, Beam Types, at 1920 by 1080 and scale 100%, once in light and once in dark. Assert Edge Upstand and Upturn + Rebate are completely inside their 130 by 90 preview boxes with the intended margin, and all other seven thumbnails remain visible. The new bounds test examines all nine geometries and stroke widths and distinguishes the old positions; it is not a captured AutoCAD picture.

   **Integration/safety:** S-41 conflict only in log. UI preview change only, no engineering section size or drawing writer changed. No switch is required. Acceptance still needs the actual window look; Structural stays separate from C-63.

14. **Position 59 — [#1386](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1386), e31f4c63 — MERGE. No new finding; RETAINED.**

   **File:line / cause:** `Modules/Structural/UI/Dialogs/CeSettingsDialog.xaml:603` and the other eight named path boxes gain TextWrapping=Wrap. Installed S-41 lacks that at `:603`. Batch 6 item 5 remains applicable.

   **AutoCAD scenario:** long folder/file paths are cut off in Settings, so the drafter cannot read the destination.

   **Deterministic test:** detached synthetic preferences with each of the nine paths at least 120 characters. Open CESETTINGS; inspect System > Installation, Schedules / Markup > Workbook files and System > Markup service in light/dark at 1920 by 1080, scale 100%. Assert every full path is visible, wraps without horizontal clipping, and no bottom control is obscured. Save/reopen an editable path and assert its stored value contains no inserted newline. The added layout test measures viewport/extents; it does not replace a native window check.

   **Integration/safety:** S-41 conflict only in log. No drawing writer, engineering rule, switch or new hard block. If combined with later Settings resizing, repeat the visual check on that combined Structural candidate; C-63 is not its destination.

15. **Position 60 — [#1419](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1419), f0a87b5a — MERGE-WITH-FIXES. G13-01: MEDIUM, VERIFIED-BY-READING; native appearance untested.**

   **Why reopened:** batch 6 item 6 reviewed 6199df19. This head adds 63 lines and removes 6 across the rule, its caller, tests and log. The requested copy-handle exclusion is now at `Modules/Drainage/Rules/StaleCloneIdentityRule.cs:78` onward; spine-key counting now precedes blank-handle skips at `Services/LinkService.CloneRepair.cs:131` and `:157`. Those requested edits are present. The whole-head MERGE recommendation still needs the case below.

   **Claimed cause is real:** the old repair treated every stored-self-handle mismatch as a copy. The ON rule now retains identity only for a sole carrier whose stored handle resolves to no other live object and whose key is not duplicated among scanned pits/pipes. Neither nominated Civil nor C-63 contains the new rule file. The switch is `linking.rebuildKeepsOnlyCarrierIdentity`, ON.

   **Additional failure — a kept pipe loses its existing break-symbol link.** At `Services/LinkService.CloneRepair.cs:158`, ordinary break-symbol polylines without PipeLinkData are skipped. The handle map at `:203` therefore contains only recognised pits/pipes, not their ordinary break-symbol entities. At `:220` the new kept-identity route calls RemapClonePipe. That routine unconditionally remaps-or-clears BreaklineGlyphHandle and SecondaryBreaklineGlyphHandle at `Services/LinkService.Utilities.cs:818` and `:819`. `Services/CloneLinkHandles.cs:12` returns an empty string when the symbol is absent from the map. Keeping identity does not protect those fields.

   **What a drafter meets:** on a legacy/partly recovered pipe whose own stored handle is wrong but whose break-symbol link is still correct, CDREBUILD repairs the pipe identity and disconnects its zigzag symbol. A later move no longer has that symbol in the pipe's recorded members. `Services/LinkService.PipeUpdates.cs:318`–`:325` exits symbol-following when both glyph handles are blank. The symbol itself is not erased by this repair, so the expected visible symptom is a stranded symbol. That visible symptom is SUSPECTED until the stated native run; the destructive clearing of the drawing record is verified.

   **Why the later rebuild does not establish a repair:** CDREBUILD calls this routine at `Commands/LinkCommands.cs:221`, then EnsureDrawingDataCurrent at `:233`. That pipeline synchronises project records and levels (`ProjectDataService.cs:650`–`:675`); its pipe metadata refresh at `:1003` reads levels, not missing glyph membership. The glyph assignment search found placement/copy setters, not a CDREBUILD rediscovery step. A general claim that a later relink will restore every cleared child is unsupported. This finding concerns break symbols, not the already-documented clearing of pit labels.

   **Exact failure fixture:** synthetic millimetre DWG with one already-valid legacy CE pipe A, a break symbol G represented by an ordinary polyline with no PipeLinkData, and no locked layers. A's current own entity handle is H; its stored PipeHandle alone is changed in the fixture to an unused valid hexadecimal handle. Its spine key is unique; G's actual handle is correctly stored in BreaklineGlyphHandle. Keep any real partner pipe and endpoint records valid. No other object has the unused handle. Ensure the fixture is opened after preparation so the normal live-copy handler has not repaired it first. This isolates a stale self handle rather than relying on arbitrary WBLOCK handle allocation.

   **DETERMINISTIC TEST:** later native runner opens that fixture on the PR candidate and captures the original link records and symbol coordinates using its read-only observer. Type CDREBUILD. Assert A retains its spine key, its stored PipeHandle becomes H, and BreaklineGlyphHandle still names G. Current source predicts the last assertion fails: it becomes empty while G remains in the drawing. The CE log should contain `[RepairStaleClones] repaired=1 errors=0` for a fixture with exactly one stale candidate; success wording must not substitute for the record assertion.

   **Continue the same native test:** after the record assertion, MOVE A by 1000 mm in X using its normal compound-selection route; assert G moves by exactly 1000 mm too. On an independent untouched copy run CDREBUILD, U, wait for idle, then REDO with no intervening diagnostic command. Assert the entire repair is undone/redone together, with G still correctly owned after the fixed version. Test the same path with the secondary glyph, ordinary pipe labels and shadow geometry; the shared remapper also clears unmapped child handles, but those additional visible outcomes are not counted as separate proved findings.

   **Exact fixes:** give the kept-original repair an ownership-aware child policy. Preserve an existing child only after proving its type, owning space, unique ownership and unchanged correct relationship; remap imported children only with an exact proven old-to-new relationship. Do not fill the map with every live handle or adopt by proximity, which would reopen the wrong-object problem. If ownership cannot be established, warn and leave that portion unrepaired rather than silently advertise complete preservation. Retain copy exclusion and key-count fixes. Add an integration regression through RepairStaleClones that seeds the fixture above and asserts the saved fields; current pure map/source-token tests do not exercise RemapClonePipe against real symbol records.

   **Protection and REDO:** this is an explicit command writer, not a new idle writer. Its scan is top-level ModelSpace and does not traverse Xref definitions. Ordinary ForWrite opens do not request locked-layer override; per-item exceptions are counted. No REFEDIT guard appears in the command or new repair routine, so REFEDIT safety is not independently certified: the later native fixture must also prove that foreign/protected content remains unchanged, without unlocking it. The test must include a locked A, attached synthetic Xref and active REFEDIT; do not accept a pass based only on the rule's pure tests. No new engineering constant or hard block is added by this PR.

   **Integration:** C-63 conflicts in Models/UserSettings.cs and REGRESSION_LOG only; preserve both neighbouring settings and both log entries. Resolve the remaining child-link repair before a release train takes it. The new symbol finding is a residual defect in the promised kept-original workflow, not a claim that this PR first invented the old copy-remapper's clearing policy.

---

1. **Summary.** Four unchanged recommendations remain MERGE; two need fixes, four are held and five are superseded or rejected by Tim's design. The only additional counted finding is #1419's loss of break-symbol ownership during kept-original repair. Its earlier requested corrections are present, but its tests still stop short of the real drawing remapper. Installer #1235 remains held under this brief. No PR, source file, build, test or AutoCAD session was changed or run. All proposed native checks remain outstanding; no bug is marked fixed.
