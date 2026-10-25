1. **ANSWER FIRST — class E positions 106–120: 11 MERGE, 4 MERGE-WITH-FIXES, 0 HOLD, 0 REJECT.** All fifteen already had Opus reviews. Three earlier requests are now satisfied at the current PR heads: #1614, #1626 and #1634.

2. **New finding count: HIGH 0 / MEDIUM 1 / LOW 0.** The single new finding is #1637: CDAUDIT says pipes are copies when it has only found duplicate CE records pointing to the same drawing object. A drawing with one pipe can be reported as having two copied pipes. Correct the message and its test before merging.

3. **Four fixes still needed.** #1608 must skip locked text in both its count and its conversion; #1615 must retain Top/Bottom typing options; #1620 must require an approved destination even when the approval record is absent; #1637 must describe duplicate records accurately. The first three concerns were already recorded and are not counted as new discoveries.

4. **What this result means.** This is a source review, not AutoCAD acceptance. No builds, tests, AutoCAD sessions, installations or sub-agents were run. The tests below are for the later AI test lane, not Tim. Structural #1608/#1615 belong on the separate Structural line; the 9 November colleague release remains Civil + Manager.

---

1. **Scope and date.** CE_ACAD / desk / plan / 03, independent review group 17. Reviewed 26 October 2026, Melbourne morning. The requested filename retains 24OCT. Positions are counted within the class-E section of `PR_PILE_TRIAGE_2026-10-24.md`, lines 1072–1086: #1608, #1614, #1615, #1616, #1618, #1620, #1626, #1627, #1628, #1629, #1631, #1633, #1634, #1637, #1638.

2. **Prior-review filter.** Read `AUDIT_C58_C60_S40_S41_2026-10-22.md` and the Civil, Structural and Gate `CODEX_AUDIT_*_22OCT.md` reports. Searched all `REVIEW_*.md` and `CODEX_PR_REVIEW_GROUP*.md` for the fifteen numbers. Relevant Opus reviews are [batch 1](REVIEW_PILE_B1_24OCT.md), [batch 2](REVIEW_PILE_B2_24OCT.md), [batch 3](REVIEW_PILE_B3_24OCT.md), [batch 10](REVIEW_PILE_B10_24OCT.md) and [batch 11](REVIEW_PILE_B11_24OCT.md). Retained sound verdicts; reopened four changed heads, #1620's conditional approval and #1608's incomplete repair instruction. #1637's underlying count contradicted its wording approval. Known faults are referenced, not recounted as new findings.

3. **Source evidence.** Fetched origin; used `gh pr view/diff --repo timbrand92/CE_ACAD_PLUGIN` for every PR and Git object reads. Rechecked all fifteen head hashes before writing; none moved during this review. All file:line references below refer to the item's pinned PR head. A detached, unpopulated reading worktree is at `C:\ce-cx\review-g17-20261026`; no code branch, source checkout, source edit or code commit was made. Only this findings file is authored.

4. **Installed comparison is the requested historical baseline.** Civil/Manager `origin/claude/rel-20261022m` = `40ee0a36f7960145743954b39859eb6c3af92869`; Structural `origin/claude/rel-20261022s2` = `2c9a96942a024888a5ab520600f2d5025de83036`. These are the brief's 3.0.70/1.1.70 and 1.0.121 sources, not a claim about today's loaded DLLs. No PR head is an ancestor of either baseline. Scoped `git cherry` comparisons found no equivalent PR commits in the relevant baseline or C-63. The introduced behaviour markers are absent from C-63; its AI client and Ignore command still have the old lines.

5. **C-63 comparison.** Fetched `origin/claude/rel-20261024m` = `5467f7053a2e9275cb450409c142ef9aa26dad53`, the versioned C-63 head, later than the reviews' `28987b73`. Read-only `git merge-tree --trivial-merge` checks report conflict markers only in `REGRESSION_LOG.md` for each of the thirteen Civil PRs. Keep both log entries. This is a textual preview, not a completed integration or build. Structural #1608/#1615 produce many conflicts if their whole branches are merged into C-63, including installer/shared history: do not combine release lines. Their stack has no conflict markers against S-41. Combining the Civil PRs with each other still needs deliberate retention of all new Linking switches at their common insertion point.

6. **Common safety checks.** The fifteen scoped PR diffs touch no CE_SHARED, installer, signed-update or Manager administrator files. CE.AI.Core in #1618 is a different component from CE_SHARED. No new engineering constants or drafting hard blocks were found. All six new bug-fix switches initialise ON: #1608, #1615, #1627, #1628, #1629 and #1631. The others introduce no switch; #1638 respects the existing Privacy choice and does not enable the separate Ignore feature. Collection limits in #1626 are processing limits, not engineering values.

7. **REDO and protected-content limits.** No scoped diff adds an Idle, command-end, selection or object-change callback that writes to the drawing. #1629 changes data inside an existing reconciliation path; that is not proof that all existing callers are REDO safe. Retained Opus protection conclusions apply only to these deltas. No complete host-level locked-layer, Xref or REFEDIT certification is claimed. For every drawing-writing test below, also run on a fresh synthetic copy with its affected layer locked and during REFEDIT of an attached synthetic drawing; require no protected-object change and no silent unlock. For successful edits, type `U`, wait 12 seconds, then `REDO`, with no intervening command. An out-of-band observer must record zero database writes between U completion and REDO; assert the exact original and reapplied drawing values. These checks are NOT RUN.

8. **Evidence language.** “Verified-by-reading” means the named source path, calculation or guard is present. Prior tests are assessed from their code or attributed to the earlier reviewer; none is claimed as run here. “Suspected” means a host outcome still needs the stated experiment. MERGE is a code-review recommendation for the proper release lane, not permission to install or mark a bug accepted.

---

1. **Position 106 — [PR #1608](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1608) — MERGE-WITH-FIXES. MEDIUM, existing review requirement; verified-by-reading.** Head `5fece523274b76c455aac618781853a084d32340`. Retain batch 10 item 3, but strengthen its repair instruction.

   **For Tim and exact scenario:** R2LTXT now asks before converting text. With an unlocked eligible note and a locked eligible note selected together, its count promises both will change; the conversion then opens the locked note for writing and can abort the whole operation. Changing the count alone does not repair the write loop.

   **Evidence and exact fix:** `Modules/Structural/Services/CeTextService.cs:5139`, `:5157`, `:5204`, `:5245`; switch `Models/UserSettings.cs:394`. Read and classify layer protection before opening an entity for write. Use the same eligible-object set for the count and conversion; skip protected text in both and report the locked count. Do not force-open or unlock it. The existing preview/position issue remains with batch 10; it is not newly audited here.

   **Test quality:** Four tests in `Bug645R2lTextAskFirstTests.cs` pin the ON default, source ordering and helper calls. They do not exercise a mixed locked selection. Without the fix the prompt source guards fail; that is weaker than a drawing test.

   **DETERMINISTIC TEST — not run:** Synthetic mm DWG: left-attached TEXT “OPEN NOTE” on unlocked 25TEXT and “LOCKED NOTE” on locked 18TEXT; both are eligible target layers. Type `R2LTXT`, select both, Enter, then No; assert both justifications/positions unchanged. Repeat with Yes after the repair: command-line count must say one conversion and one locked skip, only OPEN NOTE becomes right-attached, and no “Failed:” line appears. Run the common U/REDO probe. Native exception/selection behaviour is suspected until this test.

   **Integration:** Absent from S-41; depends on #1606, itself stacked on #1605. Separate Structural lane, never a whole-branch merge into C-63. No new asynchronous writer or protected-layer bypass is introduced by this PR.

2. **Position 107 — [PR #1614](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1614) — MERGE. No new defect; verified-by-reading.** Head `d91e4dfb0417eaa57a5a5abdd912727e99e92e13`. Upgrade batch 2 item 7 from MERGE-WITH-FIXES: its reviewed head was `26fcd655`.

   **For Tim and exact scenario:** A schedule row from an Xref can carry the same internal object number as an unrelated host object. Single-click, Enter and double-click must not jump to that host object. The requested double-click guard now exists.

   **Evidence:** `Modules/Drainage/Dialogs/PitScheduleDialog.xaml.cs:262`; `ViewModels/PitScheduleRow.cs:225`; `ViewModels/PitScheduleViewModel.cs:1279`. External-row checks precede host lookups, including the shared inlet/outlet highlight route. This is selection/display protection, with no drawing-write addition.

   **Test quality:** `Bug1009XrefRowZoomTests.cs:35` now calls `HighlightBestPipeForRow` and the inlet command, checks the Xref status, and pins guard-before-lookup ordering. The old head lacks that guard and cannot produce that early status. It remains a non-native test.

   **DETERMINISTIC TEST — not run:** Host and attached synthetic source each contain an object with matching handle H; the source's schedule row P3 also has inlet/outlet handles matching unrelated host lines. Open `PITSCHEDULE` using the attached source. Click P3, press Enter, double-click P3, and use its inlet/outlet highlight actions. Assert no host object becomes selected and the view extents stay unchanged; the relevant status contains “attached drawing (Xref)” and “cannot zoom” or “cannot highlight”. Repeat with a host-owned row as the working control.

   **Integration:** Not in C-60 or C-63; C-63 textual conflict only in the change log. No switch, engineering change or new refusal of a legitimate host edit.

3. **Position 108 — [PR #1615](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1615) — MERGE-WITH-FIXES. LOW, existing review requirement; verified-by-reading.** Head `261aa2e9b5fd25cf65ce56c49e82c0c1dd7d81a0`. Retain batch 10 item 4.

   **For Tim and exact scenario:** F now flips a 25L note before placement, but a drafter typing the familiar T or B has no matching option at that question. The former post-pick Top/Bottom question is removed when the new switch is ON.

   **Evidence and exact fix:** `Modules/Structural/Services/CeTextService.cs:949`, `:1020`, `:1026`; `Models/UserSettings.cs:401`. Add explicit Top and Bottom keywords alongside Flip; assign T/B directly for those answers and toggle only for Flip. Preserve OFF behaviour. The live preview and other BUG-644 work remain outside this narrow PR.

   **Test quality:** Three tests in `Bug644TextSideAtInsertionTests.cs` inspect defaults/source. None drives AutoCAD's keyword parser. Add coverage for all three choices; a source assertion for Top/Bottom must fail on this head.

   **DETERMINISTIC TEST — not run:** Fresh mm drawing, DIMSCALE 50, ordinary unlocked text layer, switch ON. Type `25L`, supply label number 1, type F at insertion; assert the prompt changes from Top to Bottom. Cancel, repeat with B directly, then T directly. Require no “Invalid point” response and the correct side in the prompt before clicking `0,0`. Each placement asks no later side question. Check drawing attachment and U/REDO. Native keyword outcome is suspected until run.

   **Integration:** Not in S-41; stacked directly on #1608. Separate Structural lane. The change touches prompts/defaults, not the existing layer/Xref admission or write machinery.

4. **Position 109 — [PR #1616](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1616) — MERGE. No new defect; prior verdict retained.** Head `74c696781e45debad04f7f72356d63a9178044fe`. Batch 3 item 9.

   **For Tim and exact scenario:** Two otherwise identical X-Civil FALL blocks inserted at 0 and 90 degrees previously imported with the same arrow direction. The helper now adds the insertion transform's rotation to the arrow's local angle.

   **Evidence:** `Modules/Drainage/Services/XcivilEntityScanner.cs:389`, `:1924`. Verified-by-reading for ordinary planar rotations. Mirrored blocks remain the earlier stated limitation; do not mark all transform cases accepted.

   **Test quality:** `Bug1002XcivilFallBlockRotationTests.cs` checks 0+90 = 90 degrees, 180+90 = 270 degrees, and scanner wiring. The old helper/call is absent, so these discriminate the change, but they do not read a real exported block.

   **DETERMINISTIC TEST — not run:** Synthetic source DWG with two recognised X-Civil FALL blocks, same internal arrow line pointing east, inserts at `0,0`/0 degrees and `10000,0`/90 degrees. Type `CDIMPORTXCIVIL`, choose this source, complete preview/import into a fresh mm host. Read the placed fall-arrow direction: first east, second north, 90 degrees apart. Preserve source bytes; repeat with a locked destination layer and the common REFEDIT/U/REDO probes.

   **Integration:** Absent from C-60/C-63; change-log-only textual conflict. No new switch or engineering value. Existing import writer/protection is unchanged.

5. **Position 110 — [PR #1618](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1618) — MERGE. No new defect; prior verdict retained.** Head `004ece8d52fa1b9513802b1bd69bf0102a25b2f8`. Batch 10 item 5.

   **For Tim and exact scenario:** If the AI destination replies “send this request somewhere else”, CE's shared sender must not forward the drawing question there. The default client now disables redirects.

   **Evidence:** `CE.AI.Core/AnthropicChatClient.cs:38`; test `CE.AI.Core.Tests/AnthropicChatClientTests.cs:303`. Verified-by-reading. Other AI clients outside this shared sender are not certified by this PR.

   **Test quality:** The new test uses the real default client and two loopback listeners, rather than merely checking a mock. Batch 10 records 15 sender tests passing; that is the earlier reviewer's result, not this review's. Its pre-fix failure is reasoned, not executed here.

   **DETERMINISTIC TEST — not run:** Isolated harness with synthetic question and dummy credential; approved endpoint A replies HTTP 307 with Location B. Invoke the production shared sender once. Assert A receives one request, B receives zero, and a `CeAiException` records the redirect status. Repeat through CDASK on an isolated test profile with a controlled approved HTTPS A: the error must be visible in the command/window and B's request log must remain empty. No real credentials or drawing data.

   **Integration:** Absent from C-60/C-63; change-log-only textual conflict. No database transaction, layer operation, new switch or drafting hard block.

6. **Position 111 — [PR #1620](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1620) — MERGE-WITH-FIXES. MEDIUM, known privacy gap; verified-by-reading.** Head `9c7953ce87ada5ce4bae70623b4fe09af54431e9`. Replace batch 10's conditional “MERGE, pending Tim's answer” with a concrete repair against BUG-990's recorded requirement. This is not a new finding.

   **For Tim and exact scenario:** Opening AutoCAD on a PC with a cloud address and access key but no approved-address record can still send the key to any HTTPS destination. HTTPS alone does not make that destination approved.

   **Evidence and exact fix:** `Modules/Drainage/Services/TelemetryQueueService.cs:73`–`:81` returns true when approval text is empty; `:159` uses that decision before sending; `:217` supplies the access-key header. BUG-990 explicitly requires HTTPS AND the approved host. Return false for absent/blank approval, keep the queued note, and retain the diagnostic. Check the approved authority when present. This suppresses a background send; it does not block drafting or restart Manager administrator work.

   **Test quality:** The four new tests cover HTTP, a mismatching policy, a matching policy and the real handler's redirect setting. None tests absent approval. Add absent and whitespace-only policy cases through `TryFlushAsync`; these must fail on the current head.

   **DETERMINISTIC TEST — not run:** Isolated profile/harness: one synthetic heartbeat in the outbox, `CE_CLOUD_URL=https://unapproved.example.invalid`, dummy auth, approval variable absent, recording HTTP handler returning 202. Invoke the real flush entry. Assert zero recorded requests, false return, one unchanged outbox line, and the “nothing was sent” CE diagnostic. Repeat blank, malformed, mismatching and matching policies: only matching HTTPS may send. Later repeat on AutoCAD startup with the isolated profile; no Tim settings are required.

   **Integration:** Absent from C-60/C-63; change-log-only textual conflict. Redirect disabling is correct. No switch is needed to re-enable insecure transport.

7. **Position 112 — [PR #1626](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1626) — MERGE. No new defect; verified-by-reading.** Head `e852f2589d879ca412520bc829d23da75fd82e14`. Upgrade batch 1 item 9 from MERGE-WITH-FIXES; its reviewed head was `d6ac68ce`.

   **For Tim and exact scenario:** A pipe arriving 30 mm above a pit floor must show its own invert in the “before” column, not the pit floor. Otherwise an unchanged drawing is rejected as changed since preview. The current head also contains both requested follow-ups: endpoint orientation and the 4,000-pipe list limit.

   **Evidence:** `Modules/Drainage/Services/NetworkRedesignDrawingProjector.cs:23`, `:450`; `NetworkRedesignPipelineService.cs:72`; `NetworkRedesignPreviewService.Projection.cs:147`; `Models/NetworkRedesignPipelineModels.cs:36`. Levels travel from each pipe to preview. The existing binding validator still excludes mismatched stored endpoints; the new orientation helper is defensive, not permission to bypass that validator. No new engineering number or drawing writer.

   **Test quality:** `NetworkRedesignApplyTicketServiceTests.cs:37` uses the full projector/pipeline/ticket path and asserts a pipe end of 9.530 m against a 9.500 m pit floor remains applicable. Added tests exercise reversed/unknown names and 3,000/4,001 link lists. Original failing-test commit `a190c19e` is in history; no execution here.

   **DETERMINISTIC TEST — not run:** Synthetic valid redesign fixture with two connected pits, all required flow/outlet evidence completed, and the downstream pipe invert 9.530 m above pit floor 9.500 m. Type `CDHUB`, click “Network redesign”, complete the fixture's network/outlet nominations, then “Build read-only preview”. In “Full pipe schedule” → “Route and levels”, assert BEFORE ILs uses 9.530, not 9.500. Without editing the drawing, click “Check again”; assert no “levels changed after the preview” reason. The pure test's 1.000/9.530 values are fixture data, not recommended design levels.

   **Integration:** Absent from C-60/C-63; change-log-only textual conflict. Read-only projection preserves the existing Apply and ownership gates.

8. **Position 113 — [PR #1627](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1627) — MERGE. No new defect; prior verdict retained.** Head `3acc9b20902138d2d7bca1be746d1efa4639817c`. Batch 1 item 10.

   **For Tim and exact scenario:** Copy an older long section to retain the earlier design. Updating the original used to redraw the shared block and change both. The selected insert now receives a separate definition before redraw when there is more than one live insert.

   **Evidence:** `Modules/Drainage/Services/LongitudinalSectionService.cs:499`, `:532`, `:549`; `Models/UserSettings.cs:737`. Verified-by-reading for the ordinary shared-definition path. Existing selected-insert and child-layer protection runs before separation. The count-error fallback still assumes one insert; its exception case is not proven safe and is not counted as a demonstrated drafter fault here.

   **Test quality:** `Bug997LongSectionUpdateOwnDefinitionTests.cs` covers count/switch decisions, old JSON defaults and source ordering; it cannot prove native cloning, block references or Undo.

   **DETERMINISTIC TEST — not run:** Create a two-pit older longitudinal section A, COPY it to B, and lock B's insert layer while leaving section geometry layers unlocked. Record both definitions/extents and B's displayed levels. In `CDCALC` → older longitudinal workflow, change a fixture level and “Update Existing”, selecting A. Assert A has its new level and a distinct block definition; B retains every old geometry/level value. U must restore A and the original shared relationship; REDO must separate/update A again. Repeat with A or a child layer locked: no section geometry changes.

   **Integration:** Absent from C-60/C-63; change-log-only textual conflict. Switch ON. Native REFEDIT and the common REDO observer check remain owed.

9. **Position 114 — [PR #1628](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1628) — MERGE. No new defect; prior verdict retained.** Head `3851df80bfd91abeef5c46e33c750c8c9b71d5a6`. Batch 2 item 1.

   **For Tim and exact scenario:** A 100 m single branch could lose the main-line numbering to a 20 m side branch because its joining pipe was omitted. The score now includes that joining length.

   **Evidence:** `Modules/Drainage/Rules/PitRenumberPlanner.cs:144`; `Commands/PitRenumberCommand.cs:71`. Verified-by-reading. Actual lengths come from the existing network; no engineering threshold is added. The existing preview/Apply path remains.

   **Test quality:** `Bug1005RenumberJoiningPipeTests.cs:32` distinguishes new order P10,P11,P12,P13 from OFF/old order P10,P12,P13,P11. Tests also deserialize absent/false switch values and pin command wiring; failing-test commit `6807788e`.

   **DETERMINISTIC TEST — not run:** Four synthetic pits: outlet P10 at `0,0`; P11 connected by 100 m; P12 connected to P10 by 10 m; P13 a further 10 m upstream of P12. Use actual metre lengths regardless of drawing units. Type `CDRENUMBER`, choose P10 as downstream root. Assert preview visits P11 before P12/P13; cancel and require unchanged labels. Repeat, Apply, and assert numbering follows that preview. Run locked-layer/REFEDIT and U/REDO probes.

   **Integration:** Absent from C-60/C-63; change-log-only textual conflict. `linking.renumberScoresJoiningPipe` starts ON; all new switches must survive train integration.

10. **Position 115 — [PR #1629](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1629) — MERGE. No new defect; prior verdict retained.** Head `01c299c8723d2b131e79f1fec990d840e7d64ebb`. Batch 2 item 2.

    **For Tim and exact scenario:** When CE re-finds a pit at its recorded position under a new handle, its typed schedule values and saved row order must follow it. The old pit-handle keys previously remained orphaned.

    **Evidence:** `Modules/Drainage/Services/ProjectDataService.cs:470`; `Services/PitHandleRefound.cs:16`, `:29`, `:39`. Verified-by-reading. The helper runs before the pit handle is reassigned. It preserves an already occupied destination sort position. It does not remap changed inlet/outlet handles; that was already recorded by batch 2.

    **Test quality:** `Bug1022RefoundPitKeepsOverridesTests.cs` checks data migration, unrelated rows, case/space handling, existing destination sort order, switch JSON and call ordering. Failing-test commit `e4104791`. The real drawing re-find is not covered.

    **DETERMINISTIC TEST — not run:** Prepared synthetic DWG: stored pit P3 has old handle A1 and no live A1 block; exactly one unclaimed compatible pit block F9 sits at P3's recorded location; linked override “CHECK OVERRIDE” and sort key `A1|C3||` position 0 exist; C3 remains unchanged. Open it and let the existing reconciliation complete. Open `PITSCHEDULE`; assert P3 retains “CHECK OVERRIDE” and position 0, and is not a “lost source pit”. Read stored data: F9 replaces A1 in both references. Observe any later U/REDO interval without forcing another sync.

    **Integration:** Absent from C-60/C-63; change-log-only textual conflict. Switch ON. Coordinate the previously recorded #1423/BUG-780 schedule-matcher interaction before assembling those additional changes; this review does not approve #1423.

11. **Position 116 — [PR #1631](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1631) — MERGE. No new defect; prior verdict retained.** Head `2c481e58d24f4155c8489e4a9a4f5ebed20cb62c`. Batch 2 item 3.

    **For Tim and exact scenario:** Two drainage Xrefs can both contain pit handle 2A1. Grouping only by that handle hides the second pit's heading/cover as though it were another inlet of the first. The group key now includes the external source's drawing identity.

    **Evidence:** `Modules/Drainage/ViewModels/PitScheduleViewModel.Schedule.cs:445`; `Models/UserSettings.cs:736`. Verified-by-reading. Host/manual grouping is unchanged; no source drawing or entity is written by this key calculation.

    **Test quality:** `Bug981XrefGroupsKeepDrawingTests.cs:34` uses two distinct drawing GUIDs with equal pit handles and tests that row 2 starts a group; the same-drawing two-inlet control stays grouped. OFF and old JSON cases are present. Failing-test commit `b701a3b2`. It does not prove how every damaged/copied source obtains its identity.

    **DETERMINISTIC TEST — not run:** Synthetic Xrefs A and B, distinct validated CE drawing identities, each pit handle 2A1 with one inlet; give their displayed covers 10.100 m and 20.200 m. Build a combined `PITSCHEDULE`. Assert both pit headings and both covers appear on screen and in exported CSV; B must not have blank cover/outlet cells. Add a second inlet to A: A remains one group. Repeat with the switch OFF as the failing comparison. Xrefs remain unchanged.

    **Integration:** Absent from C-60/C-63; change-log-only textual conflict. Switch ON; no new scheduler, layer write or REFEDIT path.

12. **Position 117 — [PR #1633](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1633) — MERGE. No new defect; prior verdict retained.** Head `0ea77f4b40fb8604ed2e99de1fdd1ef497fee2c7`. Batch 11 item 1.

    **For Tim and exact scenario:** Enter on an untagged source block previously said “CDTAG removed.” The new line correctly says no tag was typed and the block has no source tag. Successful tagging also uses plain words.

    **Evidence:** `Modules/Drainage/Commands/SourceTagCommand.cs:311`, `:391`; `Services/SourceTagMessages.cs:9`. Verified-by-reading. Only wording changes; the existing remove/apply transaction remains. This does not newly certify every source-edit window route.

    **Test quality:** `Bug927CdtagMessagesTests.cs` pins empty/zero/one/two-pipe strings and command calls. Failing-test commit `0131b8ad`. Text assertions prove the chosen words, not a live command route.

    **DETERMINISTIC TEST — not run:** Synthetic untagged source block S0 with no connected pipes. Type `CDTAG`, pick S0, Enter at its tag prompt. Assert “[CE] No tag typed. This block has no source tag.” and absence of “CDTAG removed.” Repeat supplying DP2: assert “[CE] Tagged DP2. No pipes are connected to it yet.” and the stored tag DP2. Repeat with one connected fixture pipe and assert singular “1 pipe is connected to it.” Run U/REDO on the successful tag change.

    **Integration:** Absent from C-60/C-63; change-log-only textual conflict. No switch, engineering change, new hard block or protection bypass.

13. **Position 118 — [PR #1634](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1634) — MERGE. No new defect; verified-by-reading.** Head `9354d130f31821ce1554a5b3e1e65c5a83671340`. Upgrade batch 11 item 2; its reviewed head was `1108ee05`.

    **For Tim and exact scenario:** The revised messages now name a pit/downpipe block accurately and tell a drafter with a missing pit record exactly which repair button to use. All three wording corrections requested by Opus are present.

    **Evidence:** `Modules/Drainage/Services/CommandWording.cs:10`, `:13`; `Commands/AnnotationEditCommand.cs:57`; `Commands/RunSolveCommand.cs:288`, `:467`. The conditions themselves and other commands' behaviour are unchanged. `Bug944PlainCommandMessagesTests.cs` contains the corrected expectations and caller checks.

    **Test quality:** Literal/source checks would fail against the earlier wrong strings. They do not establish that every repair scenario is reachable or that the repair succeeds. No native test run.

    **DETERMINISTIC TEST — not run:** Synthetic recognised CE pit block P3. Type `CDANNOTATIONEDIT`, pick P3; assert “[CE] That is a CE pit or downpipe block. Use CDEDIT.” A separate prepared fixture retains the block but lacks its CE project entry at the CDRUNSOLVE selection boundary. Type `CDRUNSOLVE`, pick it as the start/end pit; assert “CE has no record of this pit” and “click 2. Rebuild Project Data”. Open `CDREPAIR` and verify that named button exists. No pipe-level absence is misreported as the cause.

    **Integration:** Absent from C-60/C-63; change-log-only textual conflict. C-63's nearby repair-report helper remains; no runtime conflict identified in the changed lines.

14. **Position 119 — [PR #1637](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1637) — MERGE-WITH-FIXES. MEDIUM — the one NEW finding, verified-by-reading.** Head `584fd1684e4b9da571e2499793799cf059b8c3a9`. Batch 11's requested “may have been copied” correction is present, but its approval of the duplicate-count wording is wrong.

    **For Tim and exact failure scenario:** A drawing has one physical CE pipe line H, but a stale CE record contains two pipe entries both pointing at H. CDAUDIT prints “2 pipes are copies of one another.” The drafter is told to look for copied pipe geometry when the fault is two saved entries for one object. Conversely, two physically copied lines normally have different handles; this particular check does not establish that those copies are absent.

    **Exact evidence:** `Modules/Drainage/Commands/LinkCommands.cs:389` counts stored PipeData entries; `:394` groups their `EntityHandle` strings; `:403` passes the sum of those group sizes. There is no entity/geometry comparison in this pass. `Modules/Drainage/Services/AuditWording.cs:17` turns that count into “pipes are copies”, and `:22` calls the zero-count case “No copies or loose pipes found.” `Modules/Drainage.Tests/Services/Bug945PlainAuditMessagesTests.cs:17` pins the unsupported claim. Batch 11 item 3 approved that mapping rather than testing what was counted.

    **Exact fix:** Describe saved records, for example “2 saved pipe entries point to the same drawing object. Type CDREPAIR to review them.” With multiple groups, say the entries “share drawing object IDs”; do not imply every group refers to one common object. Qualify the clean result as “No duplicate object references or missing references found in the saved CE record.” Do not claim physical duplicate detection. Update both summary and detail tests, with one-object/two-record and two-object/distinct-handle fixtures. No new drawing scan is required for this wording fix.

    **DETERMINISTIC TEST — not run:** Prepare a synthetic DWG with exactly one live line H from `0,0` to `10000,0` and two CE pipe records referencing H; use a fixture writer before opening the test drawing, not diagnostic commands during a REDO interval. Type `CDAUDIT`. Assert its first summary describes two saved entries sharing a reference, contains no “pipes are copies”, and leaves geometry/records unchanged. Current head deterministically chooses the “2 pipes are copies” string. Control: two physical parallel lines H/J with one record each must not produce a blanket claim that no physical copies exist. Add two duplicate groups to check the plural wording.

    **Test quality and safety:** Existing string tests pass the false explanation. The proposed fixture assertion fails on this head and protects the meaning, not style. This PR changes output only; no new hard block, database write or protected-content bypass. Native display remains unobserved.

    **Integration:** Absent from C-60/C-63; change-log-only textual conflict. Retain the already-corrected tentative copied-file note and all original audit checks.

15. **Position 120 — [PR #1638](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1638) — MERGE. No new defect; prior verdict retained.** Head `14c8272c1212fb2bb92ced918f1067098732453a`. Batch 11 item 4; the login leak was already in the 22 October audit and is not newly counted.

    **For Tim and exact scenario:** Ignoring a finding writes who made the decision into the DWG. This change uses the existing Privacy choice: a coded name by default, blank for “none”, and a login only when explicitly chosen. It does not scrub old records.

    **Evidence:** `Modules/Drainage/Commands/CheckIgnoreCommand.cs:164` replaces the direct Windows username argument with `DrawingPersonName.Current()`. Verified-by-reading. No new storage or automatic-save path.

    **Test quality:** `CheckIgnoreStoresCodedNameTests.cs:17` pins the command call and removes direct username use. Its pure coded-name helper test already passes before this PR; only the caller guard discriminates the change. Native persisted-record coverage is still needed.

    **DETERMINISTIC TEST — not run:** Synthetic drawing with one reproducible Checks finding, Ignore enabled in an isolated profile, Privacy “Name stored in the drawing” set to coded. Type `CDCHECKIGNORE`, Ignore, select that finding's listed number, choose a displayed valid reason, Enter for no note. Save/reopen, then `CDCHECKIGNORE`, Unignore to view the list. Assert the saved By field/list uses the coded “ce-” name and contains no synthetic Windows login. Independently repeat with Privacy “none”: By is blank. Test U/REDO immediately after Ignore before opening the list; verify the decision disappears and returns intact.

    **Integration:** Absent from C-60/C-63; change-log-only textual conflict. The older Ignore command and fingerprint limitations remain with their existing audits; this privacy argument change does not claim to resolve them.

---

1. **Summary.** Eleven PRs are suitable for their proper release lanes; four need the exact repairs above. Three older requested fixes are already present. One new MEDIUM fault remains: CDAUDIT confuses duplicate saved records with copied drawing pipes. The heartbeat approval gap and Structural prompt/conversion requirements are retained from earlier reviews, not counted twice. No source was changed and no build, test or AutoCAD session ran. All native tests remain pending. Only this findings file is to be committed and pushed; no PR, bug register, desk log or queue is changed.
