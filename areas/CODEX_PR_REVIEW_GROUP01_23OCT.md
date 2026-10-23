**ANSWER FIRST — independent draft PR review, group 1 — 23 October 2026, Melbourne**

1. **New findings: HIGH 1, MEDIUM 2, LOW 0.** Ten draft PRs reviewed. All three findings are verified-by-reading; none has been run in AutoCAD in this review. Earlier audit findings are excluded from these counts.

2. **Most important: the Pit Schedule can lose its step-iron note while the pit remains deep.** In #1531, typing a shallower displayed depth can remove “With Step Irons” and its badge without changing the pit floor or pipe levels. The same warning calculation also loses millimetres by using the rounded display.

3. **Two other faults.** #1522 cannot open Edit source when a surrounding border or background block merely encloses the downpipe. #1531 can rename an unselected schedule frame because it edits a shared block definition.

4. **Recommendation.** Return #1522 and #1531 for these corrections. Keep the existing hold on #1528. The other seven have no additional demonstrated defect from this reading; the native checks already owed remain owed. Civil + Manager on 9 November remains the release scope; Manager administrator work stays parked.

5. **Work completed.** Source reading and this findings file only. Builds: 0. Unit tests: 0. AutoCAD checks: 0. No installation, source change, branch, code commit, PR edit or sub-agent. The tests below belong to the later AI testing lane, not Tim.

---

**Scope, selection and evidence**

1. **Instructions and references.** Read Tim’s RULES.md and ROUTER.md, CE_PLAN START_HERE.md and MASTER_PLAN.md. Checked AUDIT_C58_C60_S40_S41_2026-10-22.md and the three existing CODEX_AUDIT_*_22OCT.md reports for exclusions. Checked REVIEW_CODEX_PRS_A/B_2026-10-23.md and REVIEW_FIXWAVE2_A/B_2026-10-23.md; the latter two principally cover later groups. For the three older b04 drafts, also read REVIEWLANE_LOG entries 1537, 1588/1595 and 1599. This is the desk plan/03 independent review task, not a new build plan.

2. **Selection method.** Ran the requested gh pr list --state open --limit 200 --json number,title,headRefName,headRefOid,baseRefName,isDraft. Its 200 returned entries contained 57 drafts whose head began fw2/, cx/, cx2/, fix/ or b04/. Sorted numerically, divided by six, and allocated the three remainder entries to the first three groups. This is deliberately the requested 200-entry snapshot, not a claim to have enumerated older open PRs outside that limit.

1. **Group 1 (10).** #1502, #1520, #1522, #1524, #1526, #1527, #1528, #1530, #1531, #1533.

2. **Group 2 (10).** #1534, #1535, #1536, #1537, #1538, #1539, #1540, #1541, #1542, #1543.

3. **Group 3 (10).** #1544, #1545, #1546, #1547, #1548, #1549, #1550, #1551, #1552, #1553.

4. **Group 4 (9).** #1554, #1555, #1556, #1557, #1558, #1562, #1567, #1570, #1571.

5. **Group 5 (9).** #1576, #1586, #1591, #1594, #1595, #1609, #1610, #1611, #1612.

6. **Group 6 (9).** #1613, #1617, #1619, #1621, #1623, #1625, #1635, #1636, #1645.

3. **Pinned bases.** After git fetch origin, Civil baseline origin/claude/rel-20261022m was 40ee0a36f7960145743954b39859eb6c3af92869; Structural origin/claude/rel-20261022s2 was 2c9a96942a024888a5ab520600f2d5025de83036. Older bases: origin/claude/rel-20261020i = 6c2bc2c7a34c3216c50142190c5759ebfd93045a; origin/claude/rel-20261020l = 33ef049e0b87b5107ba8bd71f1488e187fb1f00c. “Installed” version names in the brief identify these historical baselines; this review did not inspect today’s installed DLLs.

4. **Method and limits.** Read each PR’s three-dot diff against its named base, changed tests and relevant callers using git show, git grep and git diff. All code references below are at the PR head in the manifest, not the checkout. Verified-by-reading proves the branch and calculations; native event delivery, displayed appearance and Undo/REDO remain unexecuted. No additional suspected issue is promoted into the finding counts. No runtime timing or visual fit measurement was made.

**New numbered findings**

1. **F1 — HIGH — #1531: the step-iron decision trusts the editable, rounded depth cell. VERIFIED-BY-READING.**

   **Where:** Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:2251, :1285 and :1565; ViewModels/PitScheduleViewModel.Filters.cs:29; Rules/PitScheduleDepthRule.cs:63. Contrast Rules/RulebookEngine.cs:666, which compares unrounded recorded depth with the Settings threshold.

   **What happens in AutoCAD:** a pit can remain 1.20 m deep while its schedule loses “With Step Irons” and the orange badge. Export uses that schedule row, so the omission can reach the Excel schedule. This is an engineering warning being removed, not merely a changed column heading.

   **Exact failure:** the new UsesPitFloor branch immediately returns the parsed row.Depth. It bypasses the old check of cover minus inlet/outlet. A typed Depth is tracked as a pending override before UpdateWarning runs; if the direct depth-edit path is reached with a known floor, it explicitly returns without changing the pipe. Either way, the warning now takes the shallow display as its only evidence. ApplyDepthRemark(false) removes the generated phrase. The floor itself is not part of this warning calculation.

   **Second deterministic case, same cause:** cover 11.000, floor and lowest pipe invert 10.096 gives 904 mm. DepthText prints 0.90; the new warning compares 0.90 with the 0.90 m Settings threshold and omits the note. R-29 compares 904 mm with 900 mm and requires it. A missing-floor ordinary pit with a lower inlet likewise loses the former maximum-depth warning when the displayed outlet depth is shallower.

   **DETERMINISTIC TEST — not run:** use a synthetic current-drawing linked pit P2, cover 11.00 m, floor 9.80 m, inlet 10.00 m, outlet 9.90 m, no custom step-iron wording, and Settings step-iron depth 900 mm. Enable “Pit Schedule depth uses the pit floor”. Type PITSCHEDULE; initially assert depth 1.20 and “With Step Irons”. On Source, untick “Auto-calculate depth”; on Rows, edit P2’s PIT DEPTH to 0.50 and press Tab. Assert the note and badge remain because the recorded floor is still 9.80 and the pipe levels are unchanged. The reviewed code instead removes the generated note. Click Export Excel and assert the same note is retained in P2’s exported remarks. Repeat on a fresh fixture with cover 11.000 and floor/inlet/outlet 10.096: the displayed 0.90 is allowed, but the step-iron note must remain and agree with CDRULES All. Restore test Settings afterwards.

   **What Opus missed / missing test:** Group B entry 4 corrected missing-floor arithmetic and pipes below the floor, but did not follow the separate warning calculation through an edited or rounded row. PitScheduleFloorDepthTests.cs:230 calls the depth-edit helper and asserts only that two pipe levels stay unchanged; its ordinary 0.95 test never covers an overridden depth or the 900 mm boundary. Fix the warning from recorded engineering levels independently of the display override; retain the drafter’s override and explain it, without adding a hard block or another engineering threshold.

2. **F2 — MEDIUM — #1522: empty space inside a border/background block prevents downpipe editing. VERIFIED-BY-READING.**

   **Where:** Modules/Drainage/Services/DoubleClickHitTest.cs:72 and :91; Services/CompoundEditModeService.cs:534, :544, :555 and :565.

   **What happens in AutoCAD:** double-click DP1 on an otherwise clear part of the plan and CE still leaves it to AutoCAD’s attribute editor. A large border or background block around the plan is enough, even when none of that block’s lines is under the pointer.

   **Exact failure:** every visible block’s full rectangular extents become a candidate, including untagged blocks and Xrefs. IsUnderPointer tests containment in the rectangle, not a hit on drawn geometry. The surrounding block plus DP1 therefore count as two; Decide returns Ambiguous before the source-tag or Xref distinction can help. Both coordinate interpretations preserve this ambiguous result rather than returning DP1. This is separate from the previously audited full-scan cost and screen-coordinate guessing.

   **DETERMINISTIC TEST — not run:** synthetic mm model space, World plan view. Make a visible, unfrozen block named REVIEW_FRAME from a rectangle with corners 90000,190000 and 110000,210000. Place one CE-tagged attributed downpipe DP1 centred at 100000,200000, well clear of the rectangle edges; no other blocks. Keep sourceEditWindow ON, opensEditWindow OFF and compound behaviour ON. Clear selection and double-click DP1’s circle. Assert the small “Edit source” window opens for DP1. The failing branch logs “double-click hit-test: 2 block(s) under the pointer; source tag = none” and does not open it. On a separate copy erase only REVIEW_FRAME and repeat as the positive control. Also repeat with a synthetic Xref rectangle enclosing DP1. An actually overlapping second symbol must continue to be treated as ambiguous.

   **What Opus missed / missing test:** REVIEWLANE_LOG 1599’s GO treats “ambiguous left to AutoCAD” as sufficient. Bug859Round2HitTestTests covers genuinely overlapping small boxes but does not distinguish enclosing empty background from an actual overlapping object. Use a proven native target or a geometric hit test; merely choosing the nearest tagged block would introduce a different wrong-object risk.

3. **F3 — MEDIUM — #1531: updating one schedule changes other inserts of its frame. VERIFIED-BY-READING; conditional on a shared definition.**

   **Where:** Modules/Drainage/ViewModels/PitScheduleViewModel.Schedule.cs:1491, :1496, :1507 and :1511. Called on explicit update at :1109 and placement at :1256. Old-cell adoption remains separately stored in Services/ScheduleLinkService.cs:93.

   **What happens in AutoCAD:** an unselected old table can acquire the heading “PIT DEPTH (m)” while its numbers still use outlet depth. The drafter only approved updating the selected schedule. A frame on a locked insert layer can also display the changed heading when its internal text is on an unlocked layer.

   **Exact failure:** the new routine starts at scheduleBlock.BlockTableRecord, follows nested block definitions, and upgrades their matching DBText/MText. It neither clones the definition for this schedule nor limits the change to owned cell entities. Other references to that same definition therefore share the new heading. Their UsesPitFloorDepth flags and cell text are not part of the selected schedule’s update. ValidateWritableEntity checks the internal text’s layer and owner, not every other insert that displays it.

   **DETERMINISTIC TEST — not run:** prepare a synthetic old-format linked schedule A with a supported static frame whose header is DBText “DEPTH TO OUTLET”. Insert a second reference B to that same frame definition, away from A; give B an independent old outlet-depth text 0.85 and label it REVIEW_B outside the block. P2 in A has cover 11.00, outlet 10.15, floor 10.05. Switch pit-floor depth ON. Type PITSCHEDULE, review A on Changes, continue to Placement and choose Update existing schedule. Assert A reads 0.95 under its new heading, while B’s heading remains “DEPTH TO OUTLET” and its value remains 0.85. The reviewed routine renames both headings while only A’s depth is adopted. Repeat with B’s insert layer locked and its internal header on layer 0. After closing the window, one U should restore A’s update and the shared header; verify REDO as a separate native obligation.

   **What Opus missed / missing test:** Group B entry 4 says old drawn cells keep their rule until explicitly updated; that is true of the cell metadata, but not of a shared heading. PitScheduleFloorDepthTests tests the string matcher and one linked cell, not two references to one definition. Preserve frame B by making A’s heading instance-owned or giving A an isolated definition, including shared nested header blocks. Do not silently migrate every insert.

**Per-PR verdicts and comparison with Opus**

1. **#1502 — AGREE with GO, scoped to the removed write.** Head 222c35b4b732a68bd5ee78eb2e791501eb721c6c; b04/bug-416-select-run-readonly; base claude/rel-20261020i. REVIEWLANE_LOG 1537 is the relevant Opus verdict, absent from the four new group reports.

   The three right-click handlers call BindToDrawingForRightClick; its null write delegate cannot call PerformPendingSaveLocked. LoadCurrentForDrawingLocked retains the previous drawing’s pending record before switching. Other callers retain the old save delegate. Agree with the LOW about a call-graph test not following delegates: the accompanying source guards are essential. Agree this cannot explain a single-drawing REDO failure. No switch or new default. Native obligation remains LINE, U, select P3, right-click “CE: Select this run”, REDO, with both one drawing and a second drawing owing a saved record. No new defect established.

2. **#1520 — AGREE with the gate correction; DISAGREE with treating GO as a complete BUG-859 fix.** Head 9daa061da2a800828d67df0b66b6febcbfa3856f; b04/bug-859-dp1-doubleclick; base claude/rel-20261020l. Relevant Opus entries 1588 and 1595.

   The source-window default stays ON; pit-label default stays OFF. EATTEDIT can reach the source resolver with the source switch alone; the no-pits/no-pipes bypass is correctly exempted for this route. Typed EATTEDIT still requires the recent-double-click condition, and source protection remains downstream. The empty implied selection still returns before resolution: that already-known native failure is not counted again. The missing source-label doorway and the non-source-block selection concern are also already recorded, not new findings. #1522 is the subsequent attempt; its independent new defect is F2.

3. **#1522 — DISAGREE with unqualified GO; needs F2 corrected.** Head 8799d20002550858dda0a5dedad1bc23602781dc; b04/bug-859-r2-pick-at-doubleclick; base claude/rel-20261022m. Relevant Opus verdict: REVIEWLANE_LOG 1599.

   Agree item by item that the fallback follows the switches/recent double-click/empty selection, reads with open-close access, never adds a found block to selection, and passes a usable target through existing owner protection. Agree true ambiguity should preserve AutoCAD’s editor. Disagree that all counted rectangles represent an object under the pointer: F2 proves the missing case. The earlier audit’s scan-cost and dual-coordinate warnings remain exclusions. No new switch; do not turn source editing OFF to hide this bug.

4. **#1524 — AGREE with MERGE as a source change, with native proof still owed.** Head e1a59824c536a9b4359236f8fe94163b0219e311; cx/ignore-undo-c60; base claude/rel-20261022m. Group A entry 1.

   Agree with all five control-flow claims: switch first, detached reads, NoUndoMarker listing, synchronous separate apply command, per-document consumed/cleared gate. The live rule reader is supplied explicitly. Default allowIgnoreFinding remains OFF; the branch does not alter it. The MEDIUM about command callbacks and real nested-command Undo remains unresolved by unit tests. Both LOWs remain documentation issues: old bug number and checklist wording dependency. Group A’s cross-module count/reset and #1536 guard integration requirements remain assembly work. No new finding; prior ignored-state/fingerprint defects are outside this fix and are not repeated.

5. **#1526 — AGREE with Opus’s required outcomes; current head addresses both MEDIUM items.** Head 3cb4c807aca45e9d0ca5443bab7c016a27d38eeb; cx/settings-rows-c60; base claude/rel-20261022m. Group A reviewed older f1ab1589.

   Save remains changed-values-only; Reset takes model defaults; unreadable seconds preserve the saved value. Source Edit remains ON, four other boolean rows OFF, wait 1 second. MEDIUM fit: the revision reduces spacing and adds a strict 670 px assertion in SettingsWindowV3Tests, rather than moving the three rows; its regression entry explains why the proposed move was taller. I verified that code and assertion, not the reported rendering result. MEDIUM wording and LOW wrong-layer promise are corrected. LOW unused layer-comparison setting remains explicitly described in its tooltip. Additive Settings clashes remain; two separately passing branch fits do not prove the merged window fits. No new fault demonstrated.

6. **#1527 — AGREE with MERGE-WITH-FIXES rationale; the current head implements the requested fixes.** Head f64420f453537ea046304207187b9d85b2ae053e; cx/automation-ids-c60; base claude/rel-20261022m. Group A reviewed older 235e0c33.

   MEDIUM: Apply now catches and logs once; the queued callback calls that guarded method. LOW later content: Selector.SelectionChanged now schedules another pass, in addition to popup events; this does not establish coverage of every later-created row. LOW brace formatting is escaped. The About title/name conflict with #1534 remains an integration choice. The newer LoadedImport test exercises a live WPF Loaded path and changing button caption; other window tests still explicitly call Refresh. Manager’s About XAML is the only shipped Manager change; its bundle must accompany that change. No Settings default or drawing write added. No new demonstrated drafter-facing defect.

7. **#1528 — AGREE with HOLD.** Head 5b2de089e7ac7cbef57ef6d4c56423e858fbf33d; cx/test-state-c60; base claude/rel-20261022m. Same head as Group A entry 4.

   The HIGH callback problem remains: command start releases the REDO hold and command-end work is not excluded. Command-body read-only flags cannot establish observer safety. Both MEDIUM groups remain: no build/native evidence, missing strict Settings binding/default-documentation integration, and additive command-count/Settings conflicts. The two LOWs about testing terminology and control styling are unchanged. The test requiring callback exclusions is explicitly marked blocked. OFF is appropriate for this test-only tool and does not prevent command events if it is typed. No new finding counted; no permission to deploy or test it is implied.

8. **#1530 — AGREE with the engineering correction; current head addresses Opus’s requested check-text fix.** Head f18585ada58e0e848a63b660e07d0ad5b0fe5cd0; cx/eng-real-length-c60; base claude/rel-20261022m. Group B reviewed older afc45df8.

   The caller supplies lengths to the detached live snapshot; the engine uses positive finite object length first, otherwise the explicit pit-centre fallback. Split-pipe real length remains metres; drawn lengths pass through the existing unit conversion. No new engineering switch. MEDIUM robot expectation now compares against the actual drawn pipe length, rather than insisting on 24 m after wall snapping. LOW no-read wording is corrected; duplicate warnings are suppressed by drawing/pipe/reason, subject to a 4,000-entry reset. LOW unused RulebookLevelsCheck still needs alignment before wiring. The grade-text assertion now accommodates #1549. Native curved/split/metre checks remain owed: pure injected length tests do not execute the AutoCAD reader. No further fault demonstrated.

9. **#1531 — AGREE with the earlier two arithmetic corrections, but DISAGREE that these make the current head ready.** Head 67ae72de32f8af3082d55f726e3efb6d0be10e0a; cx/eng-pit-floor-c60; base claude/rel-20261022m. Group B reviewed older 4a438d26.

   MEDIUM 1 is corrected: no recorded floor delegates to the old SPS/inlet-fallback rule. MEDIUM 2 is corrected: with a floor, the lowest of floor, inlet and outlet is used. The new default is ON and exposed on Settings, consistent with the reviewed bug-fix direction. The picture-file clash with #1526 remains; do not claim merged-window fit from either branch’s pictures. Opening the schedule alone does not call the new heading writer. However the edited-depth warning and shared-heading effects were missed: F1 and F3 require further work. The later #1612 Stop overriding change does not by itself fix either separate path.

10. **#1533 — AGREE with MERGE; no additional fault established.** Head 40c9a97735a7ff55f52568d796ba41d5c0d1997f; cx/xclmtxt-s41; base claude/rel-20261022s2. Same head as Group B entry 7.

   Decimal strings are preserved rather than rounded; UB/UC designations are protected before abbreviation expansion; each angle glyph uses its own adjacent dimensions and catalogue/fallback family. Tests cover multiple angles in one cell and a second formatting pass. Agree with LOW 1: a glyph before its dimensions remains raw; already recorded, not counted again. LOW 2 concerns restored test pictures, not delivered behaviour. No switch, new engineering figure or AutoCAD object writer introduced. Native XCLMTXT placement/update remains unexecuted here. Structural is separate from the 9 November Civil + Manager delivery.

**Handoff and exclusions**

1. **Do not recount prior faults.** The known disabled-Ignore write, ignored-finding identity omissions, “Asked again” limitation, outcome-log meaning, source-label doorway, #1520 empty selection, REDO uncertainty, #1522 scan cost/coordinate ambiguity and Structural audit findings are excluded. F1–F3 describe different failure mechanisms introduced by these drafts.

2. **Integration cautions checked.** #1502 and #1520 are already ancestors of the pinned C-60 base; their open draft status does not mean they are uninstalled work. #1524 and #1528 each raise the same Civil command-count expectation from 146 to 147, so a combined set needs 148. Settings additions must retain each load/save/reset/catalogue entry; #1526 and #1531 share generated image paths. These are review notes, not a claim that a combined build was run.

3. **Ownership and recovery.** Only areas/CODEX_PR_REVIEW_GROUP01_23OCT.md is this session’s change. CE_PLAN was fetched and merged with origin/main; unrelated existing changes were left alone. The report can be undone by reverting its named commit. No bug is marked FIXED, installed, or accepted.

4. **Summary — under 100 words.** Ten draft PRs reviewed against their bases and earlier Opus verdicts. Three new faults remain: a displayed schedule depth can suppress required step-irons, a surrounding block prevents the downpipe double-click fix, and updating one schedule renames other frames sharing its definition. Return #1522 and #1531 for corrections; retain #1528’s existing hold. Seven other drafts have no new demonstrated fault. All evidence is source reading; native tests remain pending.
