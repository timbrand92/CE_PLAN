1. **ANSWER FIRST — HIGH 2 / MEDIUM 3 / LOW 0: five NEW findings.** All five are SURE, verified by reading the pinned source. None has been run in AutoCAD. The steps below are for the later AI tester, not a request for Tim to test.

2. **Most important — rearranging a pier schedule can resize the wrong piers.** Sync trusts the old row positions even when whole rows have moved. A 300 mm pier and a 600 mm pier can exchange their drawn sizes without a warning.

3. **Second — different bearer sizes reuse BR1.** The tagging command writes its labels on one layer but searches for them on another. A later run forgets the earlier marks, including after saving and reopening.

4. **Third — tagging an existing bearer draws it again.** An ordinary straight bearer gets an overlapping second line. A bent bearer gets an extra straight line across its bends. The drafter asked for tags, not new framing.

5. **Other faults.** Bearer tagging adds objects to locked output layers. Drawing standards can replace a mistyped lineweight with Default and report a successful update. Only this report was authored; no code was changed.

---

1. **Evidence and boundary — RD14, 24 October 2026, Melbourne.** Read TimOS RULES.md and ROUTER.md, CE_PLAN START_HERE.md, MASTER_PLAN.md and areas/structural.md. Searched BUG_CARPARK.md before source inspection and again for every candidate. Read the supplied 22 October audit and the existing CODEX_AUDIT_CIVIL, CODEX_AUDIT_STRUCTURAL and CODEX_AUDIT_GATE reports. This is the independent Structural command audit requested by desk plan/03.

2. **Pinned source.** Fetched origin in C:\Lisp Files\CE_ACAD_PLUGIN. Structural: origin/claude/rel-20261023s = e6d597c0fbc25e78118760887a70810e0890c9a9, version commit Structural 1.0.122. Civil/Manager reference: origin/claude/rel-20261023m = f7f7d551552c21db3058ed839abacd1ec8a3b4d4. The later AREA instruction supplies these targets, superseding the earlier 22 October targets. No installed DLL identity is claimed: the installed files were not inspected.

3. **Isolation and method.** Created the requested short-path worktree C:\ce-cx\rd14 at the Structural commit, detached so no branch was created. Used git show, git grep and git diff for source reads. The worktree had no changes and matched the pinned Structural ref before removal; removal completed and its path no longer exists. No source commit, build, test, AutoCAD, installation or sub-agent. The generic appended build/PR brief was excluded as instructed.

4. **Scope and severity.** Traced CEMEMBER prompts, catalogue projection, section/elevation writers, schedule create/refresh/sync, member-schedule reading, bearer tags, shared layer creation and the Drawing standards layer-save route. HIGH means plausible wrong member identification or size; MEDIUM means unintended drawing work or a silent incorrect drafting result. SURE describes the code path, not native acceptance. No suspected-only finding is counted. No Australian Standard calculation is asserted or changed. Fixes must preserve R-27 native protection and R-00 Settings ownership.

5. **Known findings excluded; BUG numbers only.** BUG-196, BUG-334, BUG-367, BUG-369, BUG-418, BUG-497, BUG-498, BUG-501, BUG-502, BUG-503, BUG-531, BUG-532, BUG-537, BUG-646, BUG-750, BUG-818, BUG-819, BUG-858, BUG-864, BUG-880, BUG-909, BUG-910, BUG-911, BUG-912, BUG-951, BUG-952, BUG-974, BUG-977, BUG-1014, BUG-1039, BUG-1082.

---

1. **RD14-01 — HIGH — SURE — pier schedule row moves can change the wrong pier. Verified-by-reading.**

   **File:line:** Modules/Structural/Core/Schedules/ScheduleRowLink.cs:16, :23, :25, :29; Modules/Structural/Services/ScheduleService.cs:664, :772, :777, :783, :786, :788. Public command: Modules/Structural/Commands/UtilityCommands.cs:92.

   **What the drafter sees:** Rearrange two whole rows in the Bored Pier Schedule, keeping each row's contents together, then run STRSCHEDSYNC. The actual pier at each location can change diameter. Moving schedule rows should not alter which pier each row describes.

   **Exact failure scenario:** A refreshed five-column table has two data rows and a saved row map [pier A, pier B], with RowAlignedMarker 1. Moving the complete rows produces visible order [pier B, pier A] without changing the count. RecordMatches checks only the count. HandleForRow then ignores the HANDLE cell and returns the old saved handle. Sync writes the moved row's Visibility1 to that old target. No stale-record warning is emitted because the counts still agree. No other production caller updates this private row map when ordinary table cells move. This is independent of surplus rows or the initial table row-count fault.

   **DETERMINISTIC TEST — fixture:** Synthetic millimetre Model drawing, World UCS, ordinary unlocked layers, ScheduleSet.PierTableWithoutLayerAndHandle=false. First run STRSCHEDCREATE at 10000,0 while the drawing has no braces, piers or tie-downs. Then BP, 300, 0,0, Escape; BP, 600, 3000,0, Escape. The fixture must contain the standard 450DIABPV2 dynamic block with Visibility1 states 300 DIA. and 600 DIA. Name the two inserts A at 0,0 and B at 3000,0 in the test record and retain their handles. STRSCHEDREFRESH, pick BORED PIER SCHEDULE: assert four total rows and two data rows. Creating the empty table first avoids the separate known create failure.

   **Typed action:** Swap the complete data-row cell contents with the following native AutoLISP, then type STRSCHEDSYNC and pick the same table. This is an exact fixture operation equivalent to moving the rows; it does not edit CE's saved row map.

   ```lisp
   (vl-load-com)
   (setq rd14Table (vlax-ename->vla-object (car (entsel "\nPick BORED PIER SCHEDULE: "))))
   (setq rd14Col 0)
   (repeat 5 (setq rd14Cell (vla-GetText rd14Table 2 rd14Col)) (vla-SetText rd14Table 2 rd14Col (vla-GetText rd14Table 3 rd14Col)) (vla-SetText rd14Table 3 rd14Col rd14Cell) (setq rd14Col (1+ rd14Col)))
   ```

   **Assertion:** Before Sync, the first visible row carries B's handle and 600 DIA.; the second carries A's handle and 300 DIA. After Sync, A must still have Visibility1=300 DIA. and B=600 DIA., or CE must identify the ambiguous mapping and leave those rows unchanged. The source predicts A=600 DIA. and B=300 DIA. Record both native property values and the absence/presence of a warning. Test one U and REDO separately to capture restoration; no Undo/Redo result is claimed here.

   **Smallest fix:** Where the visible handle column exists, reconcile it with the saved mapping and use a validated row identity, not count equality. Without that column, retain identity with each row or detect row edits before applying values. Leave only ambiguous rows unchanged with a clear explanation; continue safe rows. Do not silently guess a new pairing.

2. **RD14-02 — HIGH — SURE — separate tagging runs give different sizes the same BR1 or SPR1 mark. Verified-by-reading.**

   **File:line:** Modules/Structural/Services/TimberSubfloorService.cs:192, :194, :253, :289, :292, :334, :359; mark allocation: Modules/Structural/Core/Marks/MemberMarkEngine.cs, AssignNew. Command registration: Modules/Structural/Plugin.cs:59; Commands/TimberSubfloorCommands.cs:17.

   **What the drafter sees:** A 150x50 F17 bearer is BR1. Tag a different bearer as 200x75 F17 in another run and that is also BR1. An office member mark no longer identifies one size, so a schedule or detail reference becomes ambiguous.

   **Exact failure scenario:** PreviewMarks searches BEARERS - SUBFLOOR for BR labels and STUMPS AND PIERS for SPR labels. DrawBearerLabel and DrawStumpPier both write their label DBText on 25TEXT. The scanner rejects those texts at its layer check, then finds no text on the geometry layers. AssignNew therefore receives only the new members and starts again at 1. Both entry routes use this same reader/writer mismatch. This is not the known question about assumed timber sizes: use explicitly typed sizes.

   **DETERMINISTIC TEST — fixture and typed steps:** New synthetic mm Model drawing, World UCS, unlocked layers, no existing BR or SPR notes. LINE from 0,0 to 3000,0; another LINE from 0,2000 to 3000,2000. CSTAGBEARERS, pick the first line, Enter to finish selection, type 150x50 F17, No to supports, Yes to Apply. Repeat on the second line with 200x75 F17, No, Yes. On a third separate line repeat 150x50 F17. Read the DBText strings on 25TEXT, including the label near each line's midpoint.

   **Assertion:** First size uses BR1; second size uses a different mark (BR2 in this clean fixture); third line shares BR1 with the first size. The code predicts BR1 on all three. Save, close and reopen the fixture before a fourth run: the numbering must still respect those existing sizes. For SPR coverage, add a support in each of two confirmed runs, explicitly choosing 90x90 F17 then 100x100 F17; distinct sizes must not both become SPR1.

   **Smallest fix:** Scan the layer where this service actually writes its labels, using the family prefix and size parsing already present. Keep compatibility with older labels on the geometry layer. Longer term ownership links can avoid treating an unrelated note as a member; that is not required to correct this mismatch.

3. **RD14-03 — MEDIUM — SURE — Tag Bearers adds unwanted overlapping or shortcut lines. Verified-by-reading.**

   **File:line:** Modules/Structural/Services/TimberSubfloorService.cs:166, :215, :320, :327, :328, :491, :493, :494.

   **What the drafter sees:** Tagging a hand-drawn bearer leaves two lines on top of one another. Erasing or moving one leaves the other behind. On a bent polyline, the extra line cuts straight from its first point to its last point across the bend.

   **Exact failure scenario:** The tag command retains only the selected object's endpoints, not its identity. It calls DrawBearerLabel, which unconditionally appends a new Line before the text. The existing object is neither adopted nor replaced. For a polyline, intermediate vertices and arcs never reach that writer. Selecting the same member twice also schedules two duplicate lines and labels because selections are not deduplicated.

   **DETERMINISTIC TEST — fixture and typed steps:** Synthetic mm Model drawing; one LINE from 0,0 to 3000,0 on AUDIT-BEARER. Record its handle and drawing line count. CSTAGBEARERS, pick it, Enter, 150x50 F17, No, Yes. Repeat independently with a three-vertex PLINE through 0,5000, 1500,6500, 3000,5000; finish the polyline, run the same tagging sequence on it.

   **Assertion:** For the straight member there must still be one framing line with its original handle and exactly one new label. The source adds a second Line with identical endpoints on BEARERS - SUBFLOOR. For the polyline its original vertices must remain and no Line from 0,5000 to 3000,5000 may be added. The source adds precisely that chord. One U must remove just the tagging operation and leave the original geometry; REDO must restore only the intended label after a fix. Also select one line twice in a run and require one tag.

   **Smallest fix:** Separate label-only placement from grid generation. CSTAGBEARERS retains and deduplicates selected ObjectIds and calls the label-only writer. CSSUBFLOORGRID can still create its new lines. Do not replace the drafter's polyline with an endpoint chord.

4. **RD14-04 — MEDIUM — SURE — bearer tagging writes onto locked output layers. Verified-by-reading.**

   **File:line:** Modules/Structural/Services/TimberSubfloorService.cs:207, :209, :215, :327, :334, :354, :359; Modules/Structural/Services/LegacyToolCommon.cs:15; Modules/Structural/Services/LayerService.cs:177. Public doorway: Commands/TimberSubfloorCommands.cs:17.

   **What the drafter sees:** Lock 25TEXT to protect completed annotation, then tag a bearer. CE still adds its label and reports it was tagged. Its lock flag stays on, which wrongly suggests that the protected layer received no changes.

   **Exact failure scenario:** The entry helper only obtains the active document. After Yes, EnsureLayer preserves existing layers but does not test whether they are locked. The writer appends new objects and assigns the locked target layer. There is no FirstLockedLayer or equivalent admission check before writing. The same absence applies to BEARERS - SUBFLOOR and optional STUMPS AND PIERS output. This is an additional command path, not another report about the level-mark commands.

   **DETERMINISTIC TEST — fixture and typed steps:** Synthetic mm Model drawing, World UCS; unlocked AUDIT-BEARER containing LINE 0,0 to 3000,0. Precreate BEARERS - SUBFLOOR, STUMPS AND PIERS and 25TEXT, then lock 25TEXT only; current layer 0. Capture entity counts per layer. CSTAGBEARERS, select the line, Enter, 150x50 F17, No, Yes.

   **Assertion:** CE names the locked layer, adds no tag or associated new framing, and leaves all lock flags unchanged. The source instead reaches the append for one DBText on 25TEXT and prints Tagged 1 bearer(s) and 0 stump/pier(s). Repeat with each of the other two output layers locked separately; request one optional support to exercise STUMPS AND PIERS. A refusal must leave no partial tag/support objects. An unlocked control must place the intended objects. Inspect counts, not visibility alone.

   **Smallest fix:** Check actual output layers at Apply, before any creation, including optional support and text layers. Keep that check and the related writes in the same transaction. Skip/refuse protected output with one named-layer message, without unlocking or redirecting it. This is native protection, not a new engineering hard stop.

5. **RD14-05 — MEDIUM — SURE — an invalid layer lineweight silently becomes Default. Verified-by-reading.**

   **File:line:** Modules/Structural/UI/LayerManagerWindow.xaml.cs:187, :194, :196, :364, :366, :367; Modules/Structural/Services/LayerService.cs:477. Editable field: Modules/Structural/UI/LayerManagerWindow.xaml:59.

   **What the drafter sees:** In Drawing standards, a mistyped lineweight is saved as Default. Existing ByLayer linework changes thickness even though that was not the value requested. The window says Updated layer rather than identifying the invalid entry.

   **Exact failure scenario:** The Lineweight grid cell is a free-text string. ToSnapshot catches no validation error: if TryParseLineweight returns false, it substitutes ByLineWeightDefault. UpdateLayer writes that value, and the click handler displays success. The original lineweight is not retained. This is not the separate current-lineweight restoration issue in text commands.

   **DETERMINISTIC TEST — fixture and clicks:** Synthetic mm drawing with unlocked AUDIT-WEIGHT at 0.50 mm and one LINE on it with lineweight ByLayer. Set LWDEFAULT to 25 (0.25 mm) in the test copy. Type CEADMINSETTINGS. On Drawing Layers, filter AUDIT-WEIGHT; double-click its Lineweight cell, type typo, then Tab to commit the cell. Click Save Layer Changes. Read the layer's lineweight through native Layer Properties and capture the window's status text.

   **Assertion:** The layer stays 0.50 mm, the typed entry remains available for correction, and the window explains the invalid lineweight. The source changes the layer to Default and displays Updated layer AUDIT-WEIGHT. Confirm the control case with 0.35 mm succeeds. After a fix, one U after a successful valid change must restore the original layer weight; invalid input must make no layer write. Restore LWDEFAULT afterwards.

   **Smallest fix:** Validate before constructing/applying the snapshot; keep the original value on invalid input and show a plain field error. A list of valid native layer lineweights would prevent this typing error. Do not quietly substitute an office default.

---

1. **What I did NOT check.** No build, unit test, native test, AutoCAD session, visual window check, installation, deployed DLL hash, live settings file or Australian Standard verification. Native crashes and complete Undo/Redo chains remain unproven. The written tests are proposed tests, not results.

2. **Coverage limits.** This was a focused command-path hunt, not a line-by-line review of every Structural service. The large Excel importer, all footing/reactor interactions, every catalogue dimension, every tag alias, every layer-template asset, all UI event sequences and every AutoCAD version were not exhaustively checked. CEMEMBER catalogue/units/UCS issues already in the register were excluded. No new CEMEMBER crash or REDO defect was proved. Manager administrator work and Civil behaviour were outside this audit.

3. **Later test lane.** Run these fixtures on AutoCAD 2027/net10 and 2024/net48 using synthetic copies. Keep before/after drawing values and exact command text; capture the layer-window result visually. Exercise successful Apply, Escape, one U, REDO and save/reopen where specified. Preserve the original Settings bytes if a fixture needs a switch change. Native evidence is required before marking any item accepted.

4. **Summary — under 100 words.** Five new source-verified faults: reordered pier rows can resize the wrong piers; bearer tagging forgets prior marks, adds unwanted lines and writes onto locked layers; an invalid layer lineweight silently becomes Default. The strongest risks are wrong pier sizes and ambiguous member marks. Each finding has a reproducible synthetic scenario, measurable assertions and a small fix direction. Known faults are excluded by BUG number. No code changed and nothing ran in AutoCAD. The temporary worktree was removed. Only this findings file is to be saved and pushed.
