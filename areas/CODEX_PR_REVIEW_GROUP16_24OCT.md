# Independent PR review, group 16 — class E positions 91–105

1. **ANSWER FIRST — 6 MERGE; 8 MERGE-WITH-FIXES; 1 HOLD; 0 REJECT.** Priority counts for the nine outstanding PR issues: **HIGH 2 / MEDIUM 5 / LOW 2**. Three verdict-changing escalations account for HIGH 1 / MEDIUM 2; six issues retain earlier reviews and are not new discoveries.

2. **Most important: leaving a floor out of the schedule can still select its support size.** In #1589, insert only the Ground Floor schedule, leaving a Roof C2 row out. Typing C2 can still take the Roof size without asking. The row exclusion repair is real, but the saved sizes still disagree with the schedules the drafter chose to insert.

3. **Do not merge #1604 as written.** It stops CEMEMBER before its first question in a metre drawing. The earlier MERGE verdict treats an existing switch as permission for this new stop. Tim's R-27 permits only the two named exceptions; this is neither.

4. **Two earlier decisions need correcting in the other direction.** #1597 has since repaired its empty rollback-file fault. #1598's proposed rejection of every 1:1 annotation scale would break genuine full-size details; that change is not justified.

5. **Evidence limit.** Reviewed on 26 October 2026, Melbourne time, against the exact heads below. Nothing was built, tested or opened in AutoCAD. All test recipes below are for the test lane, not Tim. No code, PR, branch, drawing or live setting was changed.

---

1. **Scope and method.** Positions counted within class E of PR_PILE_TRIAGE_2026-10-24.md, not the whole list. Read RULES.md, ROUTER.md, START_HERE.md and MASTER_PLAN.md; consulted AUDIT_C58_C60_S40_S41_2026-10-22.md and the three CODEX_AUDIT_*_22OCT.md reports for exclusions. All 15 PRs already have Opus coverage in REVIEW_PILE_B1, B2, B3, B9 or B10_24OCT.md. I retained sound verdicts, checked current PR metadata/diffs, and traced the questionable verdicts and changed head. Retained findings below are attributed rather than presented as independent discoveries.

2. **Frozen comparisons.** Fetched origin. The brief's Civil/Manager installed reference is origin/claude/rel-20261022m at 40ee0a36f7960145743954b39859eb6c3af92869; Structural is origin/claude/rel-20261022s2 at 2c9a96942a024888a5ab520600f2d5025de83036. These are the requested historical comparisons, not a claim about today's loaded DLLs. None of the 15 PR heads is an ancestor of either reference. Each PR's changed behaviour is absent from its applicable historical base. No current binary was inspected.

3. **C-63 and isolation.** origin/claude/rel-20261024m is now 5467f7053a2e9275cb450409c142ef9aa26dad53, later than the earlier reviews' 28987b73. Git merge-tree trials changed no checkout, index or branch; they created Git objects only. Civil PRs #1588 and #1593 conflict in InspectorPaletteService.cs and DetentionBranchCollector.cs respectively, plus REGRESSION_LOG.md. Civil #1597, #1599, #1601 and #1607 have only the log conflict. None of the 15 heads is contained in C-63. C-63 makes no Structural source changes relative to the Civil reference. A whole Structural branch merged into C-63 produces extensive inherited cross-product conflicts; these are not changes introduced by these small PRs. Keep Structural on its own release line, not the 9 November Civil/Manager train. Merge, never rebase, when resolving the Civil integration work.

4. **Common rule checks.** The actual PR file lists touch no CE_SHARED, installer or signed-update file. No installer-triggered HOLD applies to these deltas. No new engineering threshold was found: sizes use the existing Settings values; the tag ratios are drafting proportions, and the bracing patch adds no strength rating. New switches in #1592, #1603 and #1606 initialise ON; #1596 uses the existing ON label switch; #1598 adds none and its EBT caller retains that switch, and #1604 uses the existing ON units switch. Remaining PRs have no new switch.

5. **Drawing protection and REDO.** No delta adds a layer unlock, Xref traversal/write, REFEDIT bypass or asynchronous drawing writer. Retained insert/edit writers still need their existing protection tests; this is not certification of every inherited guard. #1589 saves after a successful insert; #1597 writes only on explicit Apply; #1605/#1606 write on the user's checklist action. Inspector display/zoom and bracing changes add no drawing write between U and REDO. No host-level REDO claim was proved here. For every later native test, repeat U, wait five seconds with the relevant palette open, REDO; assert the original drawing values return and no CE drawing-save/write line occurs in the interval. On insertion cases also repeat with the named output layer locked, an attached synthetic Xref, and REFEDIT active; assert no protected object or layer is altered.

6. **Counting and limits.** HIGH/MEDIUM/LOW count one primary outstanding issue per non-MERGE PR, not every symptom or every original bug. The three escalations are #1589, #1599 and #1604. The six retained issues are #1588, #1590, #1592, #1593, #1596 and #1606. #1598 is a withdrawn review objection; #1597 is a verified revision. “Verified-by-reading” describes source behaviour only. Source-text tests and a test that cannot compile without a new method are not proof of the AutoCAD result. This run: **0 builds, 0 tests executed, 0 AutoCAD sessions**. The opening read-only instruction superseded the worktree/build boilerplate, so no worktree or branch was created.

---

1. **Position 91 — PR #1588 — MERGE-WITH-FIXES — LOW integration issue retained.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1588), head 8ae9c2f392915d08aec3e27df7fcf7913b019bfd. Prior: REVIEW_PILE_B2_24OCT.md item 5.

   **For Tim:** a 10 m pipe in a metre drawing currently reads “10 mm” in the compact Inspector. The proposed conversion correctly makes it “10000 mm”. C-63 also changed the neighbouring pipe-type display, so both changes must survive integration.

   **Evidence/status:** verified-by-reading, Modules/Drainage/Services/InspectorPaletteService.cs:860 and :1120. The same conversion is already used by the detailed editor. InspectorDrawnLengthUnitsTests checks 10 units at INSUNITS 6 gives 10000 mm, plus millimetre/unitless controls and the production call. It would distinguish the old raw-number expression; not run here.

   **Exact fix:** merge C-63 and retain its pipe-type resolution while supplying DrawnLengthText(line.Length, LinkService.InsunitsOf(line.Database)) to ShowCivilPipeRecord. Do not follow the old report's rebase instruction. Its comment-placement observation is style and is not counted.

   **DETERMINISTIC TEST:** synthetic metre DWG, named CE pipe P1–P2 from (0,0) to (10,0), known pipe type. Open the normal Inspector and click that pipe. Assert window text “Drawn length” is “10000 mm” and the correct type remains displayed. Repeat in a mm fixture with endpoints (0,0) and (10000,0). Passive inspection must preserve REDO. C-63: real code conflict; not in the historical installed reference.

2. **Position 92 — PR #1589 — MERGE-WITH-FIXES — HIGH, verdict escalated.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1589), head cecf35060e1239dbd0f55ee263338306aa87f6d4. Prior: REVIEW_PILE_B9_24OCT.md item 1 and its final limitation 6.

   **For Tim:** an unselected floor can still supply the size for C2. The visible schedule and the size used for drafting can disagree without a question. This is a pre-existing gap left by this partial repair, not a newly introduced regression. The earlier review acknowledged it but did not follow it into support placement.

   **Evidence/status:** verified-by-reading. Modules/Structural/UI/Dialogs/XclmTxtDialog.xaml.cs:1348 returns every row alongside the selected InsertFloors. Services/ExcelMTextService.cs:464 filters actual insertion by floor. Services/XclmTxtService.cs:279 passes all result.Rows for storage; :308 checks Include but not the selected floors. Commands/SupportBlockCommands.cs:248–259 reads the saved C2 size and skips the size question. MemberScheduleService.cs:33 selects the first matching code without a floor discriminator.

   **Exact fix:** persist the effective rows used for successful insertion, using the same floor/row filtering as placement, or explicitly separate an all-floor reference catalogue from the active inserted schedule so it cannot silently drive C2. Do not merely add another unrelated filter. The three existing snapshot tests cover individual Include=false, not floor selection or the command handoff.

   **DETERMINISTIC TEST:** synthetic worksheet with Ground Floor B1=310UB32 and Roof C2=200 SHS, both row Include ticks ON; start with no saved member schedule. In XCLMTXT tick only the Ground Floor schedule for insertion, click Insert Selected and confirm, then place it at (0,0). Type C2 and stop before insertion. Assert no command-line line “C2: size '200 SHS' from the schedule” and no saved C2 row; the ordinary size question must remain available. The present head instead stores two member rows and prints the excluded floor's size. Add an integration test that supplies Rows plus InsertFloors to the storage handoff. Structural release only; no own delta to installer/Shared.

3. **Position 93 — PR #1590 — MERGE-WITH-FIXES — LOW retained.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1590), head bd91dbd7074cdf5b96eac47c91cb02412cefd563. Prior: REVIEW_PILE_B9 item 2.

   **For Tim:** CEMEMBER now uses the office fallback scale when DIMSCALE is zero, but the warning does not say where that number came from.

   **Evidence/status:** verified-by-reading. Modules/Structural/Commands/CeMemberCommands.cs:101 passes fallbackScale into Modules/Structural.DesignCore/SteelSections/CeMemberEngine.cs:192. The earlier two-argument call substituted 100; the new rule uses a valid office value. Existing tests check fallback 50, invalid settings and positive DIMSCALE precedence; the source guard checks the caller.

   **Exact fix:** name the office default scale on the Settings page in the fallback warning and test that wording. Do not make this PR depend on merging #1604's prohibited stop.

   **DETERMINISTIC TEST:** isolated profile with CeMember.DefaultScale=50, default break overshoot 1.5 mm and kink 2 mm; mm DWG, DIMSCALE 0, LTSCALE 500. Type CEMEMBER, SI, 310UB32, Centreline, Both, (0,0), (3000,0), Esc. Assert warning identifies the office default 1:50 and the break overshoot is 75 mm, kink 100 mm. The historical base uses 1:100. Structural release only.

4. **Position 94 — PR #1592 — MERGE-WITH-FIXES — MEDIUM retained.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1592), head 602bc901aaabffe31102ee868aff2cfeb16435a3. Prior: REVIEW_PILE_B9 item 3. Stacked on #1577.

   **For Tim:** a hatch can now be placed with a warning when the two scale settings disagree, but its picker can still say it cannot show a preview.

   **Evidence/status:** verified-by-reading. Modules/Structural/Commands/HatchCommands.cs:1663 supplies carryOn to PlacementScale. The preview's separate call at UI/Dialogs/HatchPreviewGeometry.cs:211, identified by the earlier review, lacks it. HatchCarryOnWhenScalesDisagreeTests covers placement/audit and the ON default; it does not cover the picker. The DIMSCALE 100/LTSCALE 1 placement case returns no scale on the old rule.

   **Exact fix:** feed the same switch to preview geometry and test the preview/placement agreement. Keep the existing #1577 audit correction. This removes a refusal; it does not authorise a new block or new engineering value.

   **DETERMINISTIC TEST:** mm DWG, DIMSCALE 100, LTSCALE 1, three relevant Layouts switches ON; closed 5000 by 3000 mm rectangle. Type CEHATCH and select the Earth preset. Assert the preview is present, not “No preview: the drawing scale is not valid”. Place on the rectangle: assert the warning says the scales disagree and hatch PatternScale=40. Structural release only; retain both Settings label additions when combined with #1596.

5. **Position 95 — PR #1593 — MERGE-WITH-FIXES — HIGH retained, not a new discovery.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1593), head 7884b0cf8cf5fe9e4c12d3ce364d41b8bb1c5e6c. Prior: REVIEW_PILE_B1 item 7.

   **For Tim:** a pit with a known low lid but no floor is now included in the warning, yet the suggested water levels and “first thing water would come out of” description can still overlook it.

   **Evidence/status:** verified-by-reading. Modules/Drainage/Rules/DetentionBranchCollector.cs:229 retains LidOnlyPits; Services/DetentionTwlService.cs:164 and :169 still send only branch.Items to the solver/candidates, and :289 searches only that list for the lowest pit name. Rules/TopWaterLevelCandidates.cs:144 also derives lid choices from those storage items. The four new tests cover the warning/minimum helper, not all three consumers.

   **Exact fix:** pass lid-only information to the solver ceiling, candidate descriptions and lowest-pit-name lookup without inventing any storage volume. Merge the current Civil train and preserve BUG-970/871 changes at the real collector conflict; coordinate #1635's overlapping wording. Never rebase.

   **DETERMINISTIC TEST:** connected synthetic detention branch: LOW lid RL 10.200, unknown invert and no known connected pipe invert; HIGH lid RL 12.000, known invert RL 9.000 and 1000 by 1000 mm chamber. Required storage 2000 L. Type CDTWL and choose that branch. Assert every “first thing water would come out of” choice/message names LOW at 10.200, the calculation recognises that lid as the overflow ceiling, and LOW adds zero litres. Choose a typed TWL 10.500: assert the warning names LOW. Do not hard-block the typed level. C-63: real collector conflict.

6. **Position 96 — PR #1596 — MERGE-WITH-FIXES — MEDIUM retained.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1596), head be6e198f7d7521e1c38a72c7274b3badfa11bd75. Prior: REVIEW_PILE_B9 item 4.

   **For Tim:** the main tag shrinks correctly at 1:20, but the adjacent column-over “(O)” can stay at its old large height.

   **Evidence/status:** verified-by-reading. Modules/Structural/Services/CeTextService.cs:663 onward routes tags through FixedTagHeight, but :1308 retains QuickFootingDrawn(180.0) and :1421 retains 180.0 for column-over text. Core/Units/LabelTextHeightRule.cs:21 handles the proportion correctly. The source test only searches selected assignment patterns; it misses these positional arguments.

   **Exact fix:** use FixedTagHeight(180) at both sites and remove the extra QuickFootingDrawn conversion at :1308. Add coverage for the actual column-over routes, not just a count of 27 calls. #1598 remains the units correction needed by the combined stack.

   **DETERMINISTIC TEST:** mm drawing, DIMSCALE 20, label height 2.5 mm, tag-height switch ON. Run BPC and place a synthetic BP1 tag with column-over mark C1. Inspect both texts in Properties. Assert main height 50 mm and C1(O) height 36 mm; current C1(O) is 180 mm. Repeat the THC/PFC column-over paths. Structural release only; no engineering rating added.

7. **Position 97 — PR #1597 — MERGE — earlier MEDIUM condition repaired.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1597), current head 10ed4f53f235eb3005380575e8b191555c859e23. Prior REVIEW_PILE_B1 item 6 reviewed a11a1bef, not this revision.

   **For Tim:** bringing the CE record back into step now keeps the useful earlier rollback file.

   **Evidence/status:** verified-by-reading. Modules/Drainage/Commands/SpineUpgradeCommand.cs:72 compares a detached record copy; :85 requires NewKeyCount>0 before creating a rollback file; :144 guards the actual Save. The “Nothing to write” branch at :131 is reached only when that comparison finds no repair. The review revision adds the requested new-key/record-only tests and source guards. The storage paths remain inside explicit Apply; dry-run exits at :110.

   **DETERMINISTIC TEST:** synthetic drawing with pit P1 and pipe A, existing object identities, matching geometry, an earlier nonempty rollback file, and a deliberately rebuilt project record with only its identity fields missing. Type CDSPINEUPGRADE, Apply. Assert “0 identities written”, a positive project-record update count and “No new identities, so no rollback file was needed”; latest rollback file path/hash must be unchanged. Repeat Apply: assert “Nothing to write”. In a separate disposable rollback test, verify the earlier file is still selected; this is not permission to delete live spine identities. C-63: log-only conflict.

8. **Position 98 — PR #1598 — MERGE for its own delta — prior 1:1 objection withdrawn.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1598), head 5550289002583a0837b39a86977a9833f4acc4c0. Prior: REVIEW_PILE_B9 item 5. Stacked on #1596, whose outstanding fix still applies to the combined result.

   **For Tim:** a genuine full-size detail needs 2.5 mm text, not 250 mm text. A 1:1 annotation scale alone does not prove that the drafter intended 1:100.

   **Evidence/status:** verified-by-reading. Modules/Structural/Services/CeTextService.cs:5546 uses positive DIMSCALE or the parsed annotation ratio; Services/ScheduleService.cs:113 deliberately reads 1:1 as 1 and also supports ratios such as 2:1. The older review assumed an intended 1:100 plot that is absent from its fixture. Its proposed “reject ratios <=1” change would introduce an error on full-size/enlarged details. The metre conversion and 1:50 cases are legitimate repairs. No code change is required for that objection.

   **DETERMINISTIC TEST:** isolated 2.5 mm label setting, mm model space, annotative dimension style with DIMSCALE 0, CANNOSCALE 1:1, non-annotative Standard text. Type 25C, CHECK, (0,0). Assert Height=2.5. Repeat CANNOSCALE 2:1: assert 1.25; repeat 1:50: assert 125. In a metre DWG at DIMSCALE 50 assert Height=0.125 m. Existing tests cover the last two principal unit/scale paths; add the 1:1 and 2:1 regressions to prevent the proposed incorrect review fix. Structural release only.

9. **Position 99 — PR #1599 — MERGE-WITH-FIXES — MEDIUM, verdict escalated.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1599), head fc905d69f52cced399dc6f56dbc82e7d685f5cf8. Prior: REVIEW_PILE_B2 item 6 called rotated-view cropping a small optional risk.

   **For Tim:** moving the UCS is repaired, but in a rotated plan view the zoom can still request an almost flat window instead of enclosing the selected object. The inherited shared zoom helper is the remaining fault.

   **Evidence/status:** the defective rectangle calculation is verified-by-reading; the exact resulting viewport crop is **suspected until run in AutoCAD**. Modules/Drainage/Services/InspectorPaletteService.cs:2785 and CeZoomHighlightService.cs:208 correctly undo the unwanted UCS conversion. DrawingService.cs:653 transforms those points back to world, so merely adding corners at those callers is insufficient. At :698 the final world window is transformed to view coordinates using only min/max opposite corners, then :717 clamps a collapsed dimension to 1. For a square and a 45-degree view rotation, one requested dimension collapses although the square has substantial extent in both directions.

   **Exact fix:** transform all four corners of the final world XY rectangle in ApplyZoomWindowWorld and bound those in view coordinates. Preserve the PR's world-to-UCS caller correction. Add numeric tests for both +45 and -45 degrees; current three tests only search for source strings.

   **DETERMINISTIC TEST:** synthetic mm drawing, CE pit P1 whose complete drawn extents are square, centred at (5000,5000); record those extents. Open Inspector, use UCS Origin (1000,2000), UCS Z 45, PLAN Current, then click the Unconnected pits count for P1. Repeat with the opposite view rotation. Assert all four transformed extents lie inside the resulting view and the CE “Zoom window WCS ... DCS ...” log does not report a collapsed dimension. A pure helper fixture of world corners (0,0), (1000,0), (1000,1000), (0,1000), zero target and 45-degree rotation must bound 1414.214 mm in BOTH directions before padding. Present two-corner maths cannot. C-63: log-only conflict.

10. **Position 100 — PR #1601 — MERGE — no additional finding.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1601), head 7e32a24125f382fcff10f4afbf9ac6ea0bff39d1. Prior: REVIEW_PILE_B3 item 7.

    **For Tim:** two close imported pits can each keep their own label instead of the second receiving an invented number.

    **Evidence/status:** verified-by-reading. Modules/Drainage/Services/XcivilScheduleService.cs:819 checks both used sets before adding either index. The old short-circuit expression marked a pit used even when its nearest text was already taken. The new two-pit test distinguishes that error; the single-label control prevents duplicate assignment. No new drawing writer or setting.

    **DETERMINISTIC TEST:** synthetic X-Civil import fixture with 600 mm pits at (10000,10000) and (11000,10000), P10 text at (10000,12000) and P20 at (11000,13000), no competing text. Type CDIMPORTXCIVIL and import it. Assert the resulting pit record/labels are P10 and P20, not P10 and an invented P11. With P20 text removed, assert P10 is assigned only once. C-63: log-only conflict.

11. **Position 101 — PR #1603 — MERGE — no additional finding; interim only.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1603), head b86a2f01e6bdb7e57121ef56968d21ad9466360a. Prior: REVIEW_PILE_B9 item 6.

    **For Tim:** mixed brace types no longer earn a green answer just because their lengths add up. This does not calculate engineering capacity.

    **Evidence/status:** verified-by-reading. Modules/Structural.DesignCore/BracingPanelCalculator.cs:73 collects types per direction, :114 returns unknown for mixed types that meet the length; Services/BracingPanelService.cs:31 passes the ON switch, and UI/Dialogs/BracingPanelWindow.xaml.cs:133 adds the explanation. Tests include mixed/same types, directions, blank type and OFF behaviour. No new brace strength or engineering default. BUG-950 remains open for the separately approved capacity work.

    **DETERMINISTIC TEST:** synthetic mm drawing with one AB and one BB brace in the same direction, each 1500 mm; required length for that direction 3000 mm, UnknownWhenTypesDiffer ON. Type CSBRACINGPANEL. Assert 3000 mm provided, no green tick, and window text “lengths only, brace types not weighted”. Repeat two AB braces as the same-type control. After U, let the panel refresh, then REDO: assert both braces return and no refresh writes to the drawing. Structural release only.

12. **Position 102 — PR #1604 — HOLD — MEDIUM, verdict overturned.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1604), head c857bdf9d8a106497031a8275b9dead0a1388eba. Prior: REVIEW_PILE_B9 item 7.

    **For Tim:** typing CEMEMBER in a metre drawing now stops outright. The earlier review says “no hard blocks” while approving precisely that behaviour.

    **Evidence/status:** verified-by-reading. Modules/Structural/Commands/CeMemberCommands.cs:39 returns before any question when FoundationService.Day1CommandUnitsAllowed is false. Services/FoundationService.Identity.cs:123 reads the default-ON hold switch; FoundationService.cs:5472 delegates to the non-converting units rule and returns false for HoldNotMillimetres. Modules/Structural.DesignCore/DrawingUnitRule.cs:330 says “CE has not run it”. This is new to CEMEMBER even though the helper already serves other commands. ENGINEERING_RULEBOOK.md:265–266 and the current brief allow only deletion of spine identities and a failed-build update to colleagues as hard-block cases.

    **Exact replacement required:** provide unit-correct member placement with a plain warning/record where needed, or an explicit permitted continuation path with the size basis stated. Do not simply turn this guard OFF and silently draw millimetre catalogue values as metres. Preserve locked-layer/Xref/REFEDIT protection. The new source test enforces the prohibited early stop; replace it with continuation and geometry assertions.

    **DETERMINISTIC TEST:** disposable metre drawing, INSUNITS 6, DIMSCALE 50, units switch ON. Type CEMEMBER. Current head prints “This drawing's units are metres ... CE has not run it” and never asks for the view: that proves the prohibited stop. Corrected version must warn/record and reach the normal choices; place SI, 310UB32, Centreline, None, (0,0), (6,0). Assert catalogue depth converted from 298 mm to 0.298 m, not 298 m, and one U/REDO restores the member. Repeat in mm as control. Structural release only.

13. **Position 103 — PR #1605 — MERGE as a bounded repair — no new finding; claimed root cause remains suspected.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1605), head eb7e41e0023b63041dcc585f10c933563c61f7ac. Prior: REVIEW_PILE_B10 item 1.

    **For Tim:** checklist saves now update the two existing records. That is a reasonable repair, but this review cannot say it cures the reported disappearance after Undo.

    **Evidence/status:** replacement of erase/recreate is verified-by-reading at Modules/Structural/Core/Checklist/ChecklistStorage.cs:135 and :163. The assertion that this was the AutoCAD root cause remains suspected. The three tests inspect source text; they cannot prove native Undo or palette refresh. No new asynchronous write, switch or hard block.

    **DETERMINISTIC TEST:** synthetic DWG with a four-item unchecked checklist. Type CECHECKLIST, click N/A on item 1; assert count 0 of 3. Type U once: assert the checklist still exists and count is 0 of 4. Type REDO immediately: assert 0 of 3. Save, close and reopen; assert the same checklist and N/A status. Later repeat with #1606 and enter a reason. Do not mark BUG-610 fixed from the source guards. Structural release only; first in the checklist stack.

14. **Position 104 — PR #1606 — MERGE-WITH-FIXES — MEDIUM retained.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1606), head 8688153fba37017246366c7aecf8619cdc762321. Prior: REVIEW_PILE_B10 item 2. Stacked on #1605.

    **For Tim:** the drafter is asked why an item is N/A, but cannot see the saved reason afterwards. Older N/A items without a reason also lack the promised visible review flag.

    **Evidence/status:** verified-by-reading. Modules/Structural/UI/Palette/ChecklistPanel.xaml.cs:710 asks and saves; Core/Checklist/ChecklistItem.cs:65 adds the fields and NeedsNotApplicableReview, but the PR adds no display binding. Its serialisation test round-trips an item string, not an AutoCAD drawing. The test named for an old settings file only constructs new OptionsSettings.

    **Exact fixes:** display reason, author/time and the missing-reason warning on the item and required export; add the Settings row. Add a real missing-key settings-load test or rename the overstated test. Complete the user-visible path before claiming this bug closed. Blank/Cancel is abandonment of this requested N/A action, not permission to stop unrelated drafting.

    **DETERMINISTIC TEST:** synthetic four-item checklist, NeedsReason switch ON. Type CECHECKLIST; click N/A on item 1, enter “No Xref in this synthetic drawing”, OK, then save/close/reopen. Assert the same reason is visible on the item/tooltip and required export. On a second older fixture with N/A but no reason, assert a visible “needs review” indication. Cancel must preserve both item state and count; U/REDO must preserve reason with state. Structural release only.

15. **Position 105 — PR #1607 — MERGE — no additional finding.** [PR](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1607), head 8adabfe69a7a8fcf2b39239795f555ee1f80412e. Prior: REVIEW_PILE_B3 item 8.

    **For Tim:** imported spot levels and FALL arrows now move with the shifted pits and pipes.

    **Evidence/status:** verified-by-reading. Modules/Drainage/Services/XcivilImportService.cs:711 passes the two lists; XcivilPitInsertionService.cs:954 adds the same translation to their positions. It does not rotate or scale them and does not change the separate LandXML call. The numeric test distinguishes the missing translation; a source/caller check and native import are still needed to prove the complete route.

    **DETERMINISTIC TEST:** synthetic import fixture with spot (15000,12000) and FALL arrow (15000,14000), plus pits/pipes forcing translation (985000,990000). Type CDIMPORTXCIVIL, import and accept the alignment. Assert spot insertion is (1000000,1002000), FALL insertion is (1000000,1004000), both have moved once and only once, and their levels/direction are unchanged. Assert the import log's “Applied import translation” agrees. Repeat with no spot/FALL objects. C-63: log-only conflict.

---

1. **Summary — under 100 words.** Six PRs can proceed on their appropriate release lines; eight need the specified fixes and CEMEMBER's units stop is held. Three earlier approvals were too generous: saved sizes from an unselected floor, degenerate rotated zoom bounds, and a prohibited units block. One earlier scale objection was unjustified, and the rollback-file objection has since been repaired. Retained findings are attributed, not counted as new discoveries. No build, test, AutoCAD session or code change occurred. Only this report is authorised for commit and push.

