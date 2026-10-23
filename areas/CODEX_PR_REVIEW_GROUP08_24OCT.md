# CODEX independent PR review — Group 08 — 24 October 2026

**ANSWER FIRST — FOR TIM**

1. **New faults: HIGH 1 · MEDIUM 4 · LOW 0.** All five are verified by reading the code; none was run in AutoCAD. These counts exclude faults already recorded by Opus and the 22 October audits.
2. **Most important: #1712 can still leave a 450 mm rise through a rejoining pit.** Keeping a manually fixed arrival at RL 9.50 can leave the outlet at RL 9.95. Change the earlier MERGE verdict to MERGE-WITH-FIXES.
3. **31 PRs reviewed: 23 MERGE · 7 MERGE-WITH-FIXES · 1 HOLD · 0 REJECT.** The other new faults affect the pit picture (#1693), repair counts (#1701), LEVEL wording for rising pipes (#1710), and a missing Settings-page control (#1722). #1706 stays on HOLD because its claimed AutoCAD cause has not been established.
4. **Release boundary:** Civil and Manager remain the 9 November colleague release. Structural reviews are included as requested, without making Structural a release dependency. Manager administrator work stays parked. No new engineering values or additional hard blocks are approved here.

---

**TECHNICAL REVIEW — source evidence and tests for the implementing/testing AI**

1. **Scope and frozen inventory.** GitHub was queried with: gh pr list --repo timbrand92/CE_ACAD_PLUGIN --state open --limit 300 --json number,title,headRefName,headRefOid,baseRefName. The final inventory used here was captured about 03:53 AEDT, 24 October 2026. It includes every open fb/max-* branch, Team FB-05 onward, and the newly opened fb/b5 branch #1722. FB-02 #1659 and FB-04 #1663 are outside “5 onward”; other cx* PRs are mentioned only where they affect integration. This is a finite snapshot, not a claim to cover PRs opened later.
2. **Source revisions.** Read-only detached/no-checkout worktree: C:/ce-cx/group08-24oct. No code branch or code commit was made. The requested installed-source references are Civil/Manager origin/claude/rel-20261022m at 40ee0a36f7960145743954b39859eb6c3af92869 and Structural origin/claude/rel-20261022s2 at 2c9a9694. PRs actually target claude/rel-20261023m at f7f7d551552c21db3058ed839abacd1ec8a3b4d4, or claude/rel-20261023s at e6d597c0fbc25e78118760887a70810e0890c9a9. Git ancestry checks confirm both 22 October references precede those bases. Review diffs use each PR's actual base; #1669 is also checked incrementally over #1664. “Installed” is the brief's baseline description, not a DLL inspection in this hunt.
3. **Previous reviews read first.** AUDIT_C58_C60_S40_S41_2026-10-22.md and CODEX_AUDIT_CIVIL/GATE/STRUCTURAL_22OCT.md supplied the exclusions. REVIEW_MAX_AND_TEAM_PRS_A_23OCT.md (“A”) and REVIEW_MAX_AND_TEAM_PRS_B_23OCT.md (“B”), plus the CODEX/LF review files, supplied prior decisions. REVIEW_CX4_AND_BATCH4_24OCT.md was discovered and read during the hunt; it is a local working report, so its decisions are identified explicitly rather than assumed to have been committed. No corresponding Opus review was found for the items marked “No”.
4. **Meaning of verdicts and evidence.** MERGE means no additional fault proved in this source change, not tested, installed or Tim-accepted. MERGE-WITH-FIXES means complete the stated correction/condition first. HOLD #1706 is an evidence gap, not a fabricated confirmed bug. Every deterministic test below is a proposed synthetic fixture, NOT RUN, for the testing AI rather than Tim. No builds, test suites, AutoCAD sessions, installs or sub-agents were used.
5. **Common safety limit.** Every PR's changed-file list was checked: CE_SHARED is unchanged. Each item's protection statement concerns the changed path, not a certification of every inherited writer. For every drawing-writing test, also use a locked-layer copy and an Xref/REFEDIT copy; assert no protected entity or owned annotation changes. For viewing-only routes, capture drawing values, record bytes and a pending Redo before opening and closing. Green pure/helper/source tests alone do not establish those host properties.
6. **Merge order checked without merging branches.** Read-only three-way merge previews for #1658/#1671, #1660/#1722, #1695/#1698, #1707/#1708, #1709/#1710, #1710/#1711 and #1701/#1712 produced no code conflict; their REGRESSION_LOG.md insertions clash and both entries must survive. The separate units PR #1716 conflicts in LandXmlParser.cs with each of #1707 and #1708. Merge #1707 and #1708 first, then integrate #1716 by MERGE and preserve both behaviours; never rebase. Merge #1664 before its stacked #1669. Do not also merge superseded #1576/#1537/#1555/#1531/#1619. Pairwise clean text is not proof of a combined runtime result.

**ONE ITEM PER PR**

1. **[#1658](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1658) — MERGE.**

   **Branch/head/base:** fb/max-971 · f007893b47ee8750d227bff42b311b0eb7051330 · claude/rel-20261023m.

   **Opus:** Yes — A, MERGE; same head.

   **Cause, scope and evidence:** VERIFIED-BY-READING. A damaged CE record could be replaced through a writer other than the main save. Modules/Drainage/Services/ProjectDataService.Persistence.cs and the RulebookDrawing, IgnoredChecks and AiAccessDrawing writers now consult the same hold; LinkService also does. Modules/Drainage/Models/UserSettings.cs:492 defaults the bug fix ON. The pure hold tests and writer source guards discriminate the base, but do not prove AutoCAD persistence.

   **Safety and order:** No new idle writer; ordinary drafting can continue while the unreadable record is preserved. No layer unlock, Xref or REFEDIT bypass added. No engineering number added; CE_SHARED unchanged. The already-reported missing Settings switch row is not a new finding here. Pair with #1671 joins in code; preserve both log entries. Use this replacement rather than also merging #1576.

   **DETERMINISTIC TEST — NOT RUN:** Synthetic drawing G08-BAD has an existing malformed CE record whose bytes are captured. Open it, change an ignored check, change a drawing rule and save. Assert the unreadable-record warning and byte-identical original record after each route; a separate healthy drawing still saves normally.

2. **[#1660](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1660) — MERGE.**

   **Branch/head/base:** fb/max-c-pit-depth · ca83afd017c0bfde172086fbf395152dd2900d37 · claude/rel-20261023m.

   **Opus:** Yes — A, MERGE; same head.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Rules/PitScheduleDepthRule.cs:63 and ViewModels/PitScheduleViewModel.Data.cs use the recorded depth for step irons, not rounded display text. ScheduleLinkService refuses to rename a shared frame definition. These are real causes, with boundary-depth and shared-frame tests that distinguish the base.

   **Safety and order:** Existing schedule write transaction and protection checks remain; no background write, layer unlock, Xref or REFEDIT bypass added. Step-iron threshold remains the Settings value, not a new engineering constant; CE_SHARED unchanged. No new switch. Shares the depth-rule file with #1722; read-only merge preview found only the log clash. Do not also merge superseded #1531.

   **DETERMINISTIC TEST — NOT RUN:** Use synthetic pit P1 with actual depth 0.899 m, displayed depth 0.90 m, and the office step-iron threshold set to 900 mm. Update PITSCHEDULE: assert no step-iron note. At 0.901 m assert the note. Use two references to one schedule frame; update one heading and assert the other reference's heading is unchanged. U then REDO must restore the update once.

3. **[#1664](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1664) — MERGE-WITH-FIXES.**

   **Branch/head/base:** fb/max-868 · b8c17aa1ec35e35075bcd773fba70fe51623b1e8 · claude/rel-20261023m.

   **Opus:** Yes — A, MERGE-WITH-FIXES; engineering fallback decision remains unresolved.

   **Cause, scope and evidence:** VERIFIED-BY-READING. The solver previously discarded pipe material when sizing. Modules/Drainage/Services/NetworkDesignService.cs, NetworkRedesignSolverService.cs and PipeSizeNetworkReviewService.cs now carry material to roughness selection; hashing and validation carry it too. Tests with different material roughness values would distinguish the base. Settings UI and default-ON switch are included.

   **Exact outstanding condition:** Close the already-recorded unknown-material fallback decision before release: retain a visible, Settings-sourced fallback and an explicit indication that the material was not recognised; record Tim's approved behaviour rather than silently treating the existing default as approval. No new engineering value is authorised by this review. This is Opus's existing hold point, not a new finding.

   **Safety and order:** Solver/preview work adds no drawing callback; apply protection remains in the existing route. CE_SHARED unchanged. Merge before #1669; replace #1537 rather than merging both.

   **DETERMINISTIC TEST — NOT RUN:** In a synthetic two-pipe CDDESIGN network, assign two recognised materials with deliberately different roughness values in Settings. Hold all other inputs constant; assert proposed capacity/size follows each value. Use material UNKNOWN-G08 and assert the approved fallback source is visible. Cancel leaves drawing values unchanged; accepted apply must survive U/REDO.

4. **[#1665](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1665) — MERGE.**

   **Branch/head/base:** fb/max-wording-1 · 24b09bd92753f00e0c03755e583167037d0b2cc6 · claude/rel-20261023m.

   **Opus:** Yes — A, MERGE-WITH-FIXES; the reviewed omission is fixed in this head.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Assets/Config/ce_toolbar_layout.json:219, command-registry.json and the affected Civil/Manager windows now agree on Repair Centre and the plain wording. The earlier toolbar omission is corrected. Wording assertions would fail on the old literals; they do not establish window appearance.

   **Safety and order:** Presentation changes only, retaining old typed commands. No new drawing writes, engineering numbers or switches; CE_SHARED unchanged. No locked-layer, Xref or REFEDIT behaviour changed. Manager wording does not start parked administrator work. No special code dependency found.

   **DETERMINISTIC TEST — NOT RUN:** Open Repair Centre from its ribbon button and the old typed shortcut; assert both reach the same window and the ribbon reads “Repair Centre”. Open Manager Settings and assert the requested button wording. Run CR/MR and cancel at their prompts; verify the revised plain command-line messages and no new drawing objects.

5. **[#1669](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1669) — MERGE.**

   **Branch/head/base:** fb/max-964 · d361f797528f18e5debb2bf9fe1da75cdf835b48 · claude/rel-20261023m.

   **Opus:** Yes — A, MERGE after #1664; same head.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Services/NetworkDesignService.cs uses the start of the outgoing pipe for the redesign pit invert; Models/NetworkDesignModels.cs:51 and output validation agree. The incremental change over #1664 is narrow. A pit-drop fixture distinguishes the previous end-level choice.

   **Safety and order:** No new writer or protection bypass; existing apply transaction and layer/Xref/REFEDIT checks remain. No new engineering number or switch; CE_SHARED unchanged. This head contains #1664: MERGE is conditional on resolving #1664's existing fallback condition first. Do not also merge replaced #1555.

   **DETERMINISTIC TEST — NOT RUN:** Synthetic pit P2 receives at RL 10.00 and its outgoing pipe starts at RL 9.95. Open CDDESIGN and review/apply. Assert the pit's proposed and saved invert is 9.95, matching the outgoing pipe start; it must not take the arriving pipe level or the far end's level. U/REDO must restore the same pair of values.

6. **[#1671](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1671) — MERGE.**

   **Branch/head/base:** fb/fb05-pit-schedule-open-no-write · 920e8995ede2c969fdfbd158a23465346010e737 · claude/rel-20261023m.

   **Opus:** Yes — A, MERGE; same head.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Dialogs/PitScheduleDialog.xaml.cs:21 and Services/LinkService.cs remove the unconditional close-time save. The pure close-flush rule and source checks distinguish the base. Explicit edits and explicit relink remain available; opening the list is not made into a repair action.

   **Safety and order:** This removes a write that could consume Redo. No new layer/Xref/REFEDIT behaviour, engineering value or switch; CE_SHARED unchanged. #1658 touches LinkService too, but the read-only merge preview joins code cleanly.

   **DETERMINISTIC TEST — NOT RUN:** Draw a synthetic LINE, U it, open PITSCHEDULE, make no edit and close. Type REDO; assert the LINE returns and the command is not refused for lack of redo history. Repeat opening/closing the schedule without U: DBMOD and saved CE record must be unchanged. Then edit a manual schedule row explicitly and verify that action still saves.

7. **[#1676](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1676) — MERGE.**

   **Branch/head/base:** fb/max-c-dp-dblclick · dee2744f3f11e1556e822e66867fce397fd2a6e7 · claude/rel-20261023m.

   **Opus:** Yes — B, MERGE; same head.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Services/DoubleClickHitTest.cs:88 narrows an otherwise ambiguous hit to a unique tagged downpipe when the other hit is an enclosing border/plan. It does not simply choose the nearest object. Ambiguity tests distinguish the base.

   **Safety and order:** Target protection runs after narrowing; a protected downpipe remains protected. The enclosing Xref is read as hit geometry, not edited. Multiple tagged candidates remain ambiguous. No drawing write or engineering constant added, existing fix path enabled, CE_SHARED unchanged. No special code dependency found.

   **DETERMINISTIC TEST — NOT RUN:** Place DP1 inside a large rectangular Xref plan boundary. Double-click DP1: assert Edit Downpipe opens for DP1. Put DP2 at the same pick position: assert no arbitrary DP is opened. Lock DP1's layer and repeat; assert the protected-object response and unchanged values. Repeat in REFEDIT and verify no outside object is edited.

8. **[#1682](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1682) — MERGE.**

   **Branch/head/base:** fb/fb06-pit-rename-pipe-notes · 19f02107844622b48430354bf82f02f991c3404b · claude/rel-20261023m.

   **Opus:** Yes — B, MERGE-WITH-FIXES; per-pipe isolation and visible failure reporting are now present.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Commands/PitEditCommand.cs:620 calls Services/LinkService.PitRenameOwnership.cs so a pit renamed in Edit Pit updates the connected pipes' own ownership notes. The current head catches failure per pipe and reports it; this addresses Opus's earlier fix request. Tests cover ownership replacement and guarded iteration, not the full native write.

   **Safety and order:** IsSpineWritable protects each pipe; no forced layer unlock or Xref/REFEDIT bypass added. Writes remain in the explicit edit action. No new engineering value or switch; CE_SHARED unchanged. Scope is Edit Pit, not a promise to repair every renumbering command.

   **DETERMINISTIC TEST — NOT RUN:** P1 connects to unlocked pipe A and locked pipe B. Double-click P1, rename to P9 and Save. Assert A's own From/To note says P9, B is unchanged, and the command line names the failure. Add a third pipe with an unreadable ownership record; assert it cannot prevent A updating. U/REDO must restore the corresponding pit and pipe notes together.

9. **[#1687](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1687) — MERGE.**

   **Branch/head/base:** fb/max-c-bluefactor · ddb583d9d3b0a609dbf7cc2ca8ef7e00a917c373 · claude/rel-20261023m.

   **Opus:** Yes — B, MERGE; same head.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Rules/BlueFactorReport.cs:103 warns when listed areas exceed the site; StormReport.cs includes a garden-only case in report availability. The old conditions genuinely omitted both behaviours. Pure report fixtures distinguish the base.

   **Safety and order:** Reporting only, warning rather than a hard block. No drawing transaction, layer/Xref/REFEDIT change or new switch; CE_SHARED unchanged. No engineering default introduced. No special code dependency found.

   **DETERMINISTIC TEST — NOT RUN:** In the Blue Factor report use site 100 m² and listed roof/paving/garden areas totalling 110 m². Assert the visible over-area warning while the report remains available. Then use only 100 m² garden/lawn and no roof: assert the report is offered and shows the entered pervious area rather than disappearing.

10. **[#1688](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1688) — MERGE.**

   **Branch/head/base:** fb/fb07-inline-split-callout-curve · 69451402decf98431d98a2bfce15a29a6f4830d0 · claude/rel-20261023m.

   **Opus:** Yes — B, MERGE; same head.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Services/LinkService.Split.cs assigns a callout to the split half from its arrow, not the text position. Rules/InlineSplitHalfRules.cs:1 supplies the decision. Curved pipes are declined before split writes. Tests distinguish displaced callout text and curved geometry.

   **Safety and order:** The new curve guard precedes mutation and leaves an existing curved pipe whole. Existing placement protection and command transaction remain; no unlock or Xref/REFEDIT bypass added. No engineering value or switch; CE_SHARED unchanged. This builds on existing split decisions; it is not a replacement for the separately scoped FB-02 work.

   **DETERMINISTIC TEST — NOT RUN:** A 20 m straight pipe has a callout arrow at 5 m and its text beside 15 m. Place pit P2 at 10 m; assert the callout remains owned by the first half. Repeat on a pipe with a bulged segment: assert the original curve and its records remain whole and the command-line explanation appears. U/REDO the straight split and inspect both ownership records.

11. **[#1689](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1689) — MERGE.**

   **Branch/head/base:** fb/max-c-cdcalc-cover · 324bec7cf6ee36ec52cd2cf52733958a196af427 · claude/rel-20261023m.

   **Opus:** Yes — B, MERGE; same head.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/ViewModels/DetentionSystemViewModel.cs:655 uses KnownCoverLevelRl rather than treating “recorded” as proof of a numeric cover. An old trench-grate placeholder 0.000 therefore no longer becomes a confident RL 0.00. The unknown-cover versus genuine-zero fixtures distinguish the base.

   **Safety and order:** Read/projection change only; existing records are not rewritten. No layer/Xref/REFEDIT or redo write added. No new engineering number or switch; CE_SHARED unchanged. No special code dependency found.

   **DETERMINISTIC TEST — NOT RUN:** Open CDCALC for TG1 whose legacy record has unknown cover represented by 0.000, alongside P1 with a genuinely established RL 0.00 cover. Assert TG1 displays unknown/blank cover while P1 retains its real zero. Cancel; the two stored records must be byte-identical to their starting values.

12. **[#1692](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1692) — MERGE.**

   **Branch/head/base:** fb/max-c-newdwg · c0706e5e9bc31f50e2b88368b74f4c76e485b6e1 · claude/rel-20261023m.

   **Opus:** Yes — B, MERGE-WITH-FIXES; the initial-read caching fault is corrected in this head.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Commands/NewJobDrawingCommand.cs:49 passes a failed initial read as unavailable, and Dialogs/NewJobDrawingDialog.xaml.cs retries through Rules/NewJobDrawingRecordSource.cs. A failed read is not cached as a successfully empty record. The retry helper tests discriminate the earlier implementation.

   **Safety and order:** File-reading/new-drawing route only; no new editing of existing drawing entities, layer unlock or Xref/REFEDIT bypass. No engineering number or switch; CE_SHARED unchanged. Do not also merge replaced #1619.

   **DETERMINISTIC TEST — NOT RUN:** Use a synthetic job folder with a valid CE record containing pit P1. Deny the first record read, start CDNEWDWG, restore access and choose that same folder again. Assert the preview now names P1. Choose a genuinely record-free folder and assert it is shown as empty, without borrowing P1 from the first folder.

13. **[#1693](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1693) — MERGE-WITH-FIXES.**

   **Branch/head/base:** fb/fb11-pit-preview-live · ae1566c6451ec4d4bb82fcb71095335fbc4decb6 · claude/rel-20261023m.

   **Opus:** No matching Opus review found in the reviewed files.

   **NEW G08-01 — MEDIUM, VERIFIED-BY-READING.** The Edit Pit picture can still show the old pit number and cover after the user changes or turns them off. The fix draws new text on top of a saved drawing picture; it never removes the original text in that picture.

   **File:line and exact scenario:** Modules/Drainage/Controls/PitBlockPreviewControl.cs:280 renders the saved plan and :292 assigns it to the image. PitFootprintOverlay.cs:153 adds only the new centre text. PlanAreaRenderer.cs:75–90 draws all visible intersecting model-space entities, including the saved labels. With P13 and CL 21.00 visibly beside the pit, typing P77/21.10 leaves the original labels in the bitmap. Turning Add Label/Add Cover Text off only hides the new overlay. The withdrawn dry-run writer has no active assignment on this head.

   **Exact fix and test gap:** Suppress this pit's saved annotation entities in the read-only preview renderer and draw their pending equivalents, including visibility, while preserving neighbouring entities. Do not restore an aborted drawing-write preview. PitPreviewPendingTextTests uses a blank black bitmap and asserts PendingText, so it cannot catch old saved words remaining visible.

   **Safety/order:** Pure preview change; no new layer/Xref/REFEDIT write, switch or engineering number; CE_SHARED unchanged. No special code dependency found.

   **DETERMINISTIC TEST — NOT RUN:** Synthetic P13 has a number and CL 21.00 label outside its outline but inside the preview. Double-click P13; type P77 and 21.10. Assert the window picture contains P77/21.10 and no saved P13/21.00 for that pit. Untick both label options: assert neither subject label remains. Cancel; drawing text and Redo history remain unchanged. Include a neighbouring P14 label to prove it is not hidden.

14. **[#1694](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1694) — MERGE.**

   **Branch/head/base:** fb/max-c-mgrlogs · c9585bc8170e0841d599487b020bb958f8573fe4 · claude/rel-20261023m.

   **Opus:** Yes — B, MERGE; same head.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Manager/Services/CeSupportBundleService.cs:238 adds the Manager's own trace folder to Open logs. Previously only the product log folders were opened. The folder-list assertion distinguishes the base.

   **Safety and order:** Opens log folders; no drawing writes, engineering values, new switch or CE_SHARED change. Locked layers, Xrefs and REFEDIT are outside this filesystem action. This is existing support access, not parked Manager administrator work. No special code dependency found.

   **DETERMINISTIC TEST — NOT RUN:** Give the synthetic test profile distinct Civil, Structural and Manager log folders, each with a uniquely named dummy log. Click Manager's Open logs. Assert the Manager trace directory opens as well as the existing product folders; it must not substitute a product folder for Manager's own log.

15. **[#1695](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1695) — MERGE.**

   **Branch/head/base:** fb/max-s43-ucs-frame · c5990580af7c3b2cf7886dd8000956cf20ff3968 · claude/rel-20261023s.

   **Opus:** No matching Opus review found in the reviewed files.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Structural/Services/ExcelMTextService.cs:3714 applies the UCS orientation at insertion to schedule-frame geometry, with attributes appended in the transformed frame. The old frame stayed in world axes while its text turned. Geometry tests distinguish the rotation error; this is the correction to the already-known UCS fault, not a new finding.

   **Safety and order:** Existing explicit placement transaction/protection remains; no new event writer, forced unlock or Xref/REFEDIT bypass. No engineering value or switch; CE_SHARED unchanged. Structural only, not required for the 9 November Civil/Manager release. Pair with #1698 joins code cleanly.

   **DETERMINISTIC TEST — NOT RUN:** Set UCS Z rotation to 30 degrees, run XCLMTXT with a synthetic two-row schedule and place it at a non-origin point. Assert frame, wipeout, heading and cell text all share 30-degree orientation and the picked origin. U/REDO must restore one complete schedule without a world-axis remnant.

16. **[#1696](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1696) — MERGE.**

   **Branch/head/base:** fb/max-s43-win-dpi · 22d1f3eda5c2d4636afbe1a2ee3aecc4b7eed61c · claude/rel-20261023s.

   **Opus:** No matching Opus review found in the reviewed files.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Structural/UI/AutoCadWindowHostHelper.cs:21 and AutoCadWindowHostMath.cs convert physical work-area coordinates using window DPI before sizing CESETTINGS, RCMember and SteelSectionPicker. Oversized content becomes reachable through scrolling. Pure conversion/fit tests distinguish the base, but do not prove mixed-monitor behaviour or real window rendering.

   **Safety and order:** Window geometry only; no drawing write, layer/Xref/REFEDIT change, engineering value or switch; CE_SHARED unchanged. No new fault proven. Whole-content scrolling and mixed-monitor rendering remain explicit acceptance limitations, not claims of visual approval. Structural can proceed separately from the colleague release.

   **DETERMINISTIC TEST — NOT RUN:** On a 1920 × 1080 display at 150% Windows scaling, open each of the three named windows. Assert the title bar and a route to Save/Cancel remain within the work area and every input is reachable. Repeat at 100%, then move AutoCAD to a monitor with a different scale and reopen; assert the same reachability.

17. **[#1697](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1697) — MERGE.**

   **Branch/head/base:** fb/max-s43-cem-names · 4cff3d0a2270bafffe50c20e426bad3915f026e6 · claude/rel-20261023s.

   **Opus:** No matching Opus review found in the reviewed files.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Structural.DesignCore/SteelSections/CeMemberPrompts.cs:113 tries exact/prefix matches first, then removes trailing zero decimals from numeric tokens for a catalogue match. It addresses the previously reported supplier-name mismatch. Tests distinguish a .0/.00 name from the base and preserve a genuinely fractional size.

   **Safety and order:** Catalogue lookup only; the existing CEMEMBER writer's locked-layer/Xref/REFEDIT protection is unchanged. No engineering dimension is rounded or invented, no new switch, CE_SHARED unchanged. No special code dependency found.

   **DETERMINISTIC TEST — NOT RUN:** With a synthetic catalogue entry named 200UB25.4, run CEMEMBER and enter 200.0UB25.4. Assert that exact catalogue section is offered and drawn. Enter 200.4UB25.4: assert it is not silently treated as 200UB25.4. A normal exact entry must still win over fallback candidates.

18. **[#1698](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1698) — MERGE.**

   **Branch/head/base:** fb/max-s43-cem-layers · ffe90c5c704b9469943d2d0f26456bc4912c45bf · claude/rel-20261023s.

   **Opus:** No matching Opus review found in the reviewed files.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Structural/Services/CeMemberLineWriter.cs and Commands/CeMemberCommands.cs add a post-placement frozen/off-layer explanation and improve locked-layer wording through Structural.DesignCore/SteelSections/CeMemberLayerWording.cs:1. This closes the already-audited invisible-output explanation gap. Message tests distinguish the base.

   **Safety and order:** Layer status is read; the patch does not thaw, unlock or edit an Xref. Existing protected-context checks remain. No new engineering value or switch; CE_SHARED unchanged. Read-only merge preview with #1695 found only the log clash.

   **DETERMINISTIC TEST — NOT RUN:** Set CEMEMBER's configured output layer frozen, place synthetic member M1 and assert a command-line warning names the layer; thaw it and assert M1 exists. Lock that layer and repeat: assert no new member and a plain locked-layer message. Repeat elevation and section routes. U/REDO of the successful placement must restore one member.

19. **[#1699](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1699) — MERGE.**

   **Branch/head/base:** fb/max-s43-table-guard · 22af077032abd17b9196f69fc2809d154503952d · claude/rel-20261023s.

   **Opus:** No matching Opus review found in the reviewed files.

   **Cause, scope and evidence:** VERIFIED-BY-READING, test-only guard. Modules/Structural.Tests/Rules/UncitedEngineeringTablesGuardTests.cs:1 searches commands/services for calls to the uncited lap, cover and steel-grade table APIs. Production is unchanged. These tables were already known and not called; this PR prevents selected future calls rather than correcting a present AutoCAD result. The guard would also pass on the current base; its synthetic bad-source cases are the discriminating part.

   **Safety and order:** No runtime change, switch, engineering number, drawing write or CE_SHARED modification. Layer/Xref/REFEDIT and redo behaviour are unchanged. It is a narrow named-API guard, not proof that every engineering value has a source. No dependency found.

   **DETERMINISTIC TEST — NOT RUN:** For the builder's later test run, feed the guard a synthetic command containing one forbidden table call and assert rejection, then a harmless string/comment fixture and assert the intended result. In AutoCAD, CEMEMBER output before and after this test-only PR must be identical. Do not label the existing engineering tables fixed by this PR.

20. **[#1700](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1700) — MERGE.**

   **Branch/head/base:** fb/fb13-cdrg-enter-finishes · 78e889613b0de2c609b26438693a040666084b56 · claude/rel-20261023m.

   **Opus:** No matching Opus review found in the reviewed files.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Commands/SourceBlockInsertCommands.cs separates an Enter finish from a cancelled jig, using RaingardenOutlineStep.cs:1. Undo at the first point no longer abandons CDRG. Decision-helper tests distinguish the old transitions; they do not execute Editor.Drag.

   **Safety and order:** Existing placement transaction and context protection remain; Escape still cancels. No new idle write, layer unlock, Xref/REFEDIT bypass, engineering value or switch; CE_SHARED unchanged. No special code dependency found.

   **DETERMINISTIC TEST — NOT RUN:** Type CDRG; at the first point choose Undo, then pick a 3 m × 4 m triangular outline and press Enter. Assert it proceeds to the normal completion inputs and ultimately produces one closed outline. Repeat with only two points: Enter must request another point. Escape must produce no outline. U/REDO after completion must remove/restore the entire rain garden once.

21. **[#1701](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1701) — MERGE-WITH-FIXES.**

   **Branch/head/base:** fb/fb14-repair-report-counts · aaaa7ff4f38b992da834624e4368c336a3096190 · claude/rel-20261023m.

   **Opus:** No matching Opus review found in the reviewed files.

   **NEW G08-02 — MEDIUM, VERIFIED-BY-READING.** Rebuild links can announce that a locked pit or source was registered when its drawing record was never written.

   **File:line and exact failure:** Modules/Drainage/Services/LinkService.RepairAudit.Relink.cs:172 and :179 increment rootsRegistered after void registration calls. LinkService.Registration.cs:680–710 catches source-registration failures internally. Pit writes call LinkService.Persistence.cs:893; the locked-layer check at :943 can return no dictionary, and WriteXrecordString at :1217 quietly returns for that case. Neither route gives this counter a success result. A recognised root without a compound record on a locked layer therefore reaches the success count despite remaining unregistered.

   **Exact fix and test gap:** Return an explicit committed registration receipt, or read back and validate the expected root record before counting success. Count skipped/failed roots separately and name them. The PR correctly reads back dangling pipe registration, but not these roots. RepairReportCountsTests exercises wording and grade arithmetic, so it does not expose this native no-op.

   **Safety/order:** Layer protection remains effective; the report is wrong. No new switch, engineering value or CE_SHARED change. #1712 shares the propagation file but joins cleanly; neither resolves the other's fault.

   **DETERMINISTIC TEST — NOT RUN:** Synthetic drawing G08-REPAIR contains only recognised pit P1 with no compound-link record, on locked layer G08-PITS, and no labels/pipes. Type CDREBUILDLINKS. Assert the record is still absent and the final report says zero registered plus one not linked. Current code instead reports one registered; the CE completion log also records that success. Unlock and repeat: assert one registered and a readable identity record. Repeat with a tagged source DP1.

22. **[#1706](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1706) — HOLD.**

   **Branch/head/base:** fb/fb12-pit-tab-close · 65d77570f8302553ab788933020774ad69e268b5 · claude/rel-20261023m.

   **Opus:** No matching Opus review found in the reviewed files.

   **SUSPECTED effectiveness, not a counted defect.** Modules/Drainage/Commands/RibbonContextCommands.cs:21 adds a one-shot Idle follow-up after Pit tab Close clears selection and hides the tab. Services/OneShotIdleAction.cs correctly unsubscribes before work. The builder explicitly did not reproduce the original host failure; generic scheduling/selection-array tests cannot prove that this repairs it.

   **Required evidence before MERGE:** Capture a deterministic failing Close sequence on the base, then show this change repairs it without clearing a newer selection, hiding another drawing's relevant context, or consuming Redo. Bind any delayed action to its originating document if that test exposes a cross-document effect. I have not proved a destructive cross-document failure and do not count one.

   **Safety/order:** No database write or transaction added; nevertheless selection and ribbon callbacks need native acceptance. No engineering value, new switch or CE_SHARED change; no layer/Xref/REFEDIT writer. No special code dependency found.

   **DETERMINISTIC TEST — NOT RUN:** In G08-A draw a LINE and U it. Select P1, click the Pit tab's Close button, then REDO: assert the LINE returns and the tab stays closed with empty implied selection. Repeat Close followed immediately by selecting P2, and Close followed by activating G08-B with P3 selected; assert the later selection and its appropriate tab survive. Record the base failure, not just a passing helper test.

23. **[#1707](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1707) — MERGE.**

   **Branch/head/base:** fb/fb16-landxml-import · f9eebcfb36257eaae09d25830fa16acdf05bf1f9 · claude/rel-20261023m.

   **Opus:** No matching direct Opus review found; the 24 October review flags its integration with #1716.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Helpers/LandXmlParser.cs and Commands/LinkCommands.ImportXcivil.cs:287 accept refStart/refEnd aliases, report missing references, preserve material/class text and describe uncertain non-circular sizes. Parsed XML fixtures distinguish the schema-alias and dimension bugs on the base. The existing placeholder policy is labelled, not silently converted into established engineering data.

   **Safety and order:** Import uses the existing command writer/protected-context path, no new event writer or layer unlock; CE_SHARED unchanged. No new feature switch. The detention half-width is geometry, not a new design standard. #1707 + #1708 joins code cleanly. Both conflict with #1716 in LandXmlParser.cs: integrate the two import PRs first, then MERGE the units fix and resolve deliberately, never rebase.

   **DETERMINISTIC TEST — NOT RUN:** CDIMPORTLANDXML a synthetic metre-unit file with P1/P2, pipe references refStart/refEnd, a detention structure with two defined parts, material “RCP CLASS 4”, and a second pipe referencing missing P9. Assert the first pipe connects P1/P2, material survives, total detention width matches the file and the missing-P9 pipe is identified in the import report. Cancel/undo must not leave partial imported entities.

24. **[#1708](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1708) — MERGE-WITH-FIXES.**

   **Branch/head/base:** fb/fb17-landxml-scale-grade-rim · 2ed82768e914cf30060db339f145a911471e614c · claude/rel-20261023m.

   **Opus:** No matching direct Opus review found; #1716's unit review already identifies the dependent correction.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Helpers/LandXmlParser.cs:123 chooses one coordinate scale per file, displays negative-export slope magnitude and formats cover text using Settings precision. Parser tests distinguish these changes. They do not prove complete units consistency: the millimetre fixture itself supplies metre-like rim/dimension values. This is the already-identified #1716 integration issue, not a new finding count.

   **Exact condition:** Integrate #1716's elevation/unit conversion while preserving this PR's one-file coordinate scale, slope handling and Settings formatting. Normalise elevation to metres before rounding. Retain one coherent unit interpretation rather than accepting an entire side of the conflict. No new blocking rule or engineering default is requested.

   **Safety/order:** Existing import transaction and protected-context checks remain; no new switch, forced unlock or CE_SHARED change. Code conflict with #1716 is confirmed by read-only merge preview; #1707 + #1708 itself joins cleanly.

   **DETERMINISTIC TEST — NOT RUN:** Import equivalent synthetic metre and millimetre LandXML networks, including metre rim 21.125 versus millimetre rim 21125, and matching physical coordinates/dimensions. Assert both drawings have identical locations/sizes and cover text 21.13 at two decimals. Repeat slope +0.01 and -0.01 for a file whose established endpoint levels describe the same fall; assert grade 1:100. Missing slope must remain unknown.

25. **[#1709](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1709) — MERGE.**

   **Branch/head/base:** fb/fb20-boundary-along-pipe · 32d8a1556c4d177d4a9bf463cbf4c71f53962050 · claude/rel-20261023m.

   **Opus:** No matching Opus review found in the reviewed files.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Helpers/LongSectionBoundaryProjector.cs:1 measures intersection distance along the captured pipe path; ProfileRouteEvidenceCaptureService and LongitudinalSectionViewModel wire the path into CDPROFILE. This corrects projection onto a straight chord. The pure bent-path fixtures distinguish the base. Resident C7 pipe geometry is a Polyline on this branch; that cast is not a missing-native-pipe fault.

   **Safety and order:** Read-only capture/projection, existing explicit section writer remains. No layer unlock, Xref/REFEDIT write or new switch; CE_SHARED unchanged. Existing reach tolerances remain; arc tessellation is geometry approximation, not a design-rule value. The builder explicitly leaves the older CDCALC route outside this correction. #1710 shares capture code but joins cleanly.

   **DETERMINISTIC TEST — NOT RUN:** Millimetre drawing: pipe P1–P2 runs (0,0) to (10000,0) to (10000,10000); a boundary crosses its vertical leg at (10000,5000). Run CDPROFILE on that route. Assert the boundary chainage is 15.000 m, not a distance projected onto the diagonal. Repeat the reversed route: 5.000 m. Cancel must leave drawing values unchanged.

26. **[#1710](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1710) — MERGE-WITH-FIXES.**

   **Branch/head/base:** fb/fb19-level-pipe-grade · b46f0c3251aeceab6a224bd4ef793dcafef16164 · claude/rel-20261023m.

   **Opus:** No matching Opus review found in the reviewed files.

   **NEW G08-03 — MEDIUM, VERIFIED-BY-READING.** A rising pipe can be labelled LEVEL simply because the displayed levels round to the same number. That removes the existing rising-pipe explanation.

   **File:line and exact failure:** Modules/Drainage/Services/ProfileRouteEvidenceCaptureService.cs:618 tests IsLevelPipe after grade derivation returns zero for a rise. At :755–761, IsLevelPipe compares levels rounded to Settings' CalculatedDecimals. With 20 m length, established From RL 10.10, To RL 10.40, no stored grade and zero calculated decimals, the 300 mm rise is accepted as LEVEL. At the normal two decimals, 10.001 to 10.004 also passes. Display precision has become an undeclared engineering tolerance.

   **Exact fix and test gap:** Classify the sign of the unrounded established level difference before level handling. A real rise must retain its warning; genuinely equal levels may read LEVEL with blank speed/flow. If a non-zero tolerance is wanted, it needs a separate approved meaning, not the number of displayed decimals. Bug760LevelPipeGradeTests.cs:20 actually asserts that the small rising case is level, so green tests endorse this mistake.

   **Safety/order:** No new writer or layer/Xref/REFEDIT bypass; fix is effectively ON, CE_SHARED unchanged. Keep the warning without inventing a new hard block. Shares capture/section files with #1709/#1711; both pairs join in code.

   **DETERMINISTIC TEST — NOT RUN:** In synthetic G08-LEVEL set Calculated decimals to 0 and provide the exact established levels above in the pipe record, clearing grade text/XData/custom grade. Type CDPROFILE, pick P1–P2 and inspect review/section grade text: assert a rise explanation, never LEVEL. Repeat equal RL 10.10/10.10: assert LEVEL and blank speed/flow. Repeat at two decimals with 10.001/10.004: assert a rise. Changing display precision alone must not change the classification.

27. **[#1711](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1711) — MERGE.**

   **Branch/head/base:** fb/fb22-cdprofile-junction-marks · 5ee899a2ee49203db09a06b7a4aa61c37078e23b · claude/rel-20261023m.

   **Opus:** Yes — 24 October CX4/batch-4 review, MERGE; same head rechecked.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Services/LongitudinalSectionService.cs:804 attaches branch markers to the reviewed CDPROFILE section before its first write. It uses the same read-only junction facts and marker placement rule as the established route, including reverse direction. Pure marker fixtures and a source-order guard distinguish the base.

   **Safety and order:** No new record repair or background writer. Existing section transaction and layer/Xref/REFEDIT protection remain. No engineering value or new switch; CE_SHARED unchanged. #1710 edits the same section service, but read-only merge preview finds only the log clash. Its separate LEVEL defect still requires correction.

   **DETERMINISTIC TEST — NOT RUN:** Synthetic 20 m main P1–P2 has one recorded branch at chainage 6.4 m. Run CDPROFILE and place its section: assert one branch tick at 6.4 m. Review the main backwards: assert 13.6 m. A route without branch facts must have no tick. U/REDO must remove/restore the complete section without writing branch facts.

28. **[#1712](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1712) — MERGE-WITH-FIXES.**

   **Branch/head/base:** fb/fb23-cascade-rejoin-order · 49792ecacfcbb6d9eb50d619b9b51ff894123d38 · claude/rel-20261023m.

   **Opus:** Yes — 24 October CX4/batch-4 review, MERGE. This review changes that verdict.

   **NEW G08-04 — HIGH, VERIFIED-BY-READING.** The corrected rejoin still uses a calculated arrival that AutoCAD will not write when the drafter keeps a manually set end. A pipe can arrive at RL 9.50 while the outlet leaves at RL 9.95: a 450 mm rise through the pit despite the PR's “lowest arriving pipe” promise.

   **File:line and exact failure:** Modules/Drainage/Services/LinkService.RepairAudit.InvertPropagation.cs:441–451 carries the manual flags but :471/:477 stores/minimises newOtherEndIL, not the effective kept level. The lower-arrival scan at :377 skips already-cascaded pipes. Apply at :856–857 instead uses EffectiveUpstreamIL/EffectiveDownstreamIL; Models/PropagationPlan.cs:99–103 keeps a pinned end at its old value. Each individual pipe still falls, so RowsFlatWhenWritten does not detect the rise across the pit.

   **Fixture and calculation:** Use the PR's five-pipe diamond, all pipes 50 m: AB 10.00/9.90, AC 10.00/9.60, BD 9.90/9.80, CD 9.60/9.50, DE 9.45/9.35. Pin only CD's downstream end at 9.50. Raise A to 10.50. Planned arrivals are 10.30 and 10.00; the new minimum gives DE 9.95/9.85. Keep leaves CD at 10.10/9.50, so the actual lowest arrival is still 9.50. The fault is an incomplete fix, not a claim this PR introduced manual-end handling.

   **Exact fix and test gap:** Build/rebuild downstream levels from the effective levels for the selected Keep/Overwrite choice. With Keep, D's outlet must use 9.50 less the existing 0.05 m pit drop, giving 9.45; with Overwrite, the new 9.95 result is correct. Keep downstream dependencies and preview consistent. Do not add a hard block. The four new graph tests supply no pinned-end database records, so they cannot expose this.

   **Safety/order:** Existing explicit transaction and protected-object checks remain; no new engineering constant, switch or CE_SHARED change. #1701's grade-summary fix does not repair this dependency; code merges cleanly.

   **DETERMINISTIC TEST — NOT RUN:** Prepare the diamond above with CD's manual flag persisted. Type CDPROPAGATE, select head pit A, enter 10.50, accept the downstream preview and choose Keep. Assert CD's end remains 9.50 and DE's start is 9.45, not 9.95. Check the saved record and visible invert notes. U/REDO must preserve those same values. Repeat from the original fixture choosing Overwrite: CD end 10.00 and DE start 9.95.

29. **[#1713](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1713) — MERGE.**

   **Branch/head/base:** fb/fb24-audit-read-only · a8df14593c5ab8ae0a25d5c2c70103ba70d65360 · claude/rel-20261023m.

   **Opus:** Yes — 24 October CX4/batch-4 review, MERGE; same head rechecked.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Commands/LinkCommands.cs:320 removes record initialisation from the import audit. Services/LinkService.RepairAudit.AuditPasses.cs reads pit outlines passively and measures outside the actual wall with drawing-unit conversion. The previous centre-based and millimetre assumptions were real. Unit/source fixtures distinguish the base; the audit remains read-only.

   **Safety and order:** Removes an unnecessary write path; no new background work, layer unlock, Xref/REFEDIT write, switch or engineering default; CE_SHARED unchanged. No special dependency found. Existing generic read-failure wording is not counted as a new fault.

   **DETERMINISTIC TEST — NOT RUN:** Use equivalent metre and millimetre drawings with a 900 mm pit and a pipe end 20 mm outside the pit wall, within the configured reach. Run CDIMPORTAUDIT and CDAUDITDETAIL: assert equivalent findings in both drawings, measured from the wall. Before running, U a LINE; after the audit REDO must restore it. Compare the CE record bytes and DBMOD to confirm no audit write.

30. **[#1717](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1717) — MERGE.**

   **Branch/head/base:** fb/fb25-schedule-order-pump · 676874b54645f83aa8b838856ffc54b876a5c413 · claude/rel-20261023m.

   **Opus:** Yes — 24 October review, MERGE-WITH-FIXES at cedc590e; updated head 676874b5 addresses repeated warnings.

   **Cause, scope and evidence:** VERIFIED-BY-READING. Modules/Drainage/Services/NetworkRedesignScheduleReviewService.cs:895 and PitScheduleNewRowPlacement.cs insert new marks alongside existing natural-order marks without sorting away manual row positions. PumpPitScheduleReader.cs:113 now filters screen messages through LinesNotShownYet. The follow-up adds once-per-drawing/session coverage for duplicate-pump and read-failure messages, satisfying Opus's earlier request.

   **Safety and order:** List ordering and diagnostics only in the changed paths; no new drawing transaction, layer/Xref/REFEDIT bypass, engineering value or CE_SHARED change. Natural mark ordering retains its existing user preference; it is not a newly introduced OFF bug-fix switch. No special code dependency found. Old known spam is not counted again.

   **DETERMINISTIC TEST — NOT RUN:** With natural mark order ON, existing schedule marks P1/P2/P3/P10 and a manual note row, apply a redesign adding P2A. Assert P2A falls between P2 and P3 while the manual note retains its intended place. Copy pump SPS1 with the same LABEL; open/Refresh/reopen PITSCHEDULE six times. Assert one listed SPS1 and only one duplicate-SPS1 command-line warning in that drawing's session. A distinct duplicated SPS2 must produce its own warning.

31. **[#1722](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1722) — MERGE-WITH-FIXES.**

   **Branch/head/base:** fb/b5-bug1035-shallow-pit-setting · 544022b8cba3b2de6e3b8084a5761ec60253cd78 · claude/rel-20261023m.

   **Opus:** No — opened during this hunt; absent from the completed Opus review.

   **NEW G08-05 — MEDIUM, VERIFIED-BY-READING.** The shallow-pit limit is still unavailable to a drafter on the Settings page. The PR moves the fixed number into a settings file but explicitly leaves the page control undone, contrary to R-00.

   **File:line and exact failure:** Modules/Drainage/Models/UserSettings.cs:734–735 adds shallowPitDepthMm; Rules/PitScheduleDepthRule.cs:26–32 validates it; ViewModels/PitScheduleViewModel.cs:38–40 reads it. A repository search finds no Settings-page binding/catalogue entry for this value. REGRESSION_LOG.md explicitly says the plain-English box is not done. An office wanting 450 mm cannot make that change through CDS, so a 310 mm pit remains OK under the default 300 mm.

   **Exact fix and test gap:** Add a bound “Shallow pit depth (mm)” control to the existing Pipes and Pits Settings page, include it in its load/save/reset path, and make the warning update when that saved value is used. Distinguish pit depth from minimum cover. Preserve the current 300 mm default pending any separate engineering ruling; no new standard is asserted. Tests set SettingsService.Current directly, so they bypass the missing user action.

   **Safety/order:** Warning only, no new hard block, callback or CE_SHARED change. Existing schedule writers and layer/Xref/REFEDIT checks are untouched. No new switch needed. Shared depth-rule file with #1660 joins cleanly; log entries clash.

   **DETERMINISTIC TEST — NOT RUN:** Open CDS > Pipes and Pits; locate “Shallow pit depth (mm)”, enter 450, Save, reopen and assert 450 persists. Open PITSCHEDULE on synthetic pits 290, 300, 310 and 450 mm deep: first three must say Shallow, last OK. The current head fails at locating the control. Restore 300 and assert 290 alone is Shallow. No schedule placement should be blocked.

---

**SUMMARY**

Thirty-one PRs have source-based verdicts. Five new faults need correction: kept manual arrivals at rejoining pits, saved labels remaining in the pit preview, unsuccessful roots counted as repaired, rising pipes classified LEVEL, and the shallow-depth setting missing from the page. The Close-tab change still needs a reproduced AutoCAD cause. Retain the earlier engineering fallback condition and integrate the LandXML units correction carefully. No native behaviour was tested in this hunt.

