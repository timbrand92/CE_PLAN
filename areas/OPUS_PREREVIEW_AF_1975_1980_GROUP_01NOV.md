# Opus pre-review AF: PRs #1975, #1976 (B-124, n10) and #1977, #1978, #1979, #1980 (B-125, n11), C-79c candidates

Written Sunday 1 November 2026, 04:35 Melbourne, by an independent read-only Opus reviewer for CE 05 at CE 01's request.
Release tip checked: claude/rel-20261102a at 3fbb9da5 (Civil 3.0.88, C-78), confirmed with `git ls-remote` at the time of review. All six PRs are Civil only; none touches Structural, CE_SHARED or the Manager.
Heads reviewed: #1975 85ed7a3a, #1976 d9f58c22, #1977 9022d0d1, #1978 4dc1b03a, #1979 995a736a, #1980 4b03038b. All six are DRAFT.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the code, the two authors' reports (areas\BUGFIX_n10_REPORT_31OCT.md, areas\BUGFIX_n11_REPORT_31OCT.md) and the carpark entries. I ran read-only `git fetch`, `git ls-remote` and `git merge-tree` only.

## FOR TIM

1. **#1975, invert text kept off its own pipe after a pit MOVE (BUG-1253 and BUG-1034): KEEP-WITH-NOTE, FULL.** Example: you MOVE a pit 2 m and an IL text ends up lying across its own blue pipe. CE now slides it to the nearest clear spot. Before, CE never treated a text's own pipe as something to keep clear of. This runs after every pit MOVE, for every colleague, so the train needs the full run. The robot must check that labels already sitting beside a pipe do not move.
2. **#1976, "APPROX." kept when you move or flip a pipe label (BUG-1161): KEEP-WITH-NOTE, Civil area + smoke.** It is a two-line fix. It may make no visible difference if CE already re-reads the wording from the text, which is what the bug entry itself says ("visible effect UNSURE").
3. **#1977, Tidy labels changes nothing in the drawing if you answer No or press Esc (BUG-873): KEEP-WITH-NOTE, Civil area + smoke.** Correct and small. One note: after Yes, CE does not save its project record at that moment (it is saved later, the normal way). That is safe, but the author's write-up says it is saved then.
4. **#1978, leader-out never puts a callout on top of a plain label that stays (BUG-890): KEEP, Civil area + smoke.** This only matters if you have turned on "move a crowded label out with a leader", which is off by default.
5. **#1979, a pipe drawn in a layout is checked against that layout's text (BUG-891): KEEP-WITH-NOTE, Civil area + smoke.** The second half (searching further out to match the leader-out distance) changes nothing at default Settings. The search already reaches 1,550 mm and the default leader-out distance is 1,500 mm. It only matters if someone sets the leader-out distance above 1,550 mm.
6. **#1980, Tidy labels starts faster on big drawings (BUG-962): KEEP, Civil area + smoke** (it rides the full run that #1975 forces anyway). It gives the same answer, found faster. The time saved has not been measured.
7. **Order and merging:** #1975 goes first. The other five are built on top of it, so taking any one of them also brings in #1975. Every pair clashes only in two places: the Settings list (UserSettings.cs) and the top of the change log (REGRESSION_LOG.md). The fix in both places is to keep both entries. No program code clashes.
8. **Nobody has opened any of the six in AutoCAD.** All are built and unit-tested only, and all seven bugs stay OPEN. No test touched your real settings. Both authors saw your real CD_Settings.json change during their runs, and both blame a robot AutoCAD session running at the same time. I cannot confirm who wrote it.

---

## DETAIL

### Group facts (apply to every PR below)

1. **Bases and the stack.** #1975 is one commit on the tip 3fbb9da5 (merge-base = tip, 0 behind). #1976, #1977, #1978, #1979 and #1980 each sit one commit on #1975's head 85ed7a3a (0 behind it), base branch `claude/b124-n10-bug1253-pit-move-label-strip`. The stack is sound today: nothing is stale.
2. **What happens if #1975 changes.**
   1. **A new commit added on top of #1975** (the normal way): the five children still merge. Each child's diff on GitHub will grow to show the new #1975 commit as "missing", but `git merge-tree` stays clean except for the two shared files.
   2. **#1975 force-pushed or rebased:** the five children still carry the OLD #1975 commit 85ed7a3a. Merging any child would then bring the old #1975 back alongside the new one. Every child must be rebased onto the new #1975 head before assembly.
   3. **#1975 dropped (if a later review says CHANGE-NEEDED and it misses C-79c):** do NOT merge any child on its own. Each child contains #1975's commit and would quietly ship it. In that case each child's single commit has to be cherry-picked onto the tip instead. #1977 and #1978 do not depend on #1975's code. #1979 and #1980 edit the same file next to #1975's lines, so a cherry-pick may need hand-merging there.
   4. **#1975 squash-merged:** the children then hold a commit whose content is already on the line under a different id. Git usually merges identical changes cleanly, but REGRESSION_LOG.md will conflict. Prefer a merge commit for #1975, or cherry-pick each child's single commit.
3. **Merge against the tip (read-only `git merge-tree`).** All six merge clean against 3fbb9da5 on their own.
4. **Merge between the six.** #1975 with any child: clean, because the child contains it. Every pair among #1976 to #1980 (10 pairs) conflicts in exactly two files:
   1. **UserSettings.cs, about line 720:** all five add their switch directly after `TidyKeepsLabelsOffOwnPipeStrip` (#1975's switch). Keep all five blocks, one after the other.
   2. **REGRESSION_LOG.md, the top:** keep every entry.
   3. **LinkService.TextClashTidyUp.cs auto-merges** in the three pairs that both touch it (#1978 x #1979, #1978 x #1980, #1979 x #1980). I read the merged `ScanNearby` from #1979 x #1980: it has #1980's grid lines and then #1979's space choice, and it reads correctly. I checked the pairs one at a time. I did not merge all six in one go and did not compile the result.
5. **Merge against the other open PRs on rel-20261102a (51 others, every one checked against all six heads).** The only clash outside REGRESSION_LOG.md is UserSettings.cs, with #1940 (B-121 n7, BUG-1144), #1944 (B-126 n12, BUG-296), #1945 (B-121 n7, BUG-1158) and #1950 (BUG-1152). Each adds its switch at the same place. Keep both blocks. No code file clashes. Draft #1875 (B-025), which the n10 author flagged, targets the OLD line `claude/rel-20261026z`, not this one, so I did not test it here. If it is ever retargeted, its change to `TidyOnePipe`'s signature will need hand-merging against #1975.
6. **Defaults test.** The tip has C76, C77 and C78 switch-default classes, but no C79 class yet. All six new switches ship ON. Each is pinned in its own PR's test file through both start-up reads (`DeserializeSettings` and `DeserializeSettingsTolerant`) with: an empty file, a linking group without the key, typed false and typed true. A missing linking group also reads ON (the `?? true` in each rule's `IsOn`). The C-79c assembler should add all six to the C79 defaults class.
7. **Protected files.** None of the named protected files is touched (LinkService.Persistence.cs, ProjectDataService.Persistence.cs, RulebookEngine.cs). Two caveats:
   1. `LinkService.TextClashTidyUp.cs` (the tidy and placement service) is marked "Lane: Sonnet (protected file)" in the carpark entries for BUG-890, BUG-891 and BUG-962. It is edited by #1975, #1978, #1979 and #1980, so I read every changed line in it (below).
   2. #1976 edits `LinkService.SegmentAnalysis.cs` (a LinkService file) and #1977 calls into `ProjectDataService.Mutations.cs` without editing it.
8. **Tests and the real folders.** The new test files contain no file write, no AppData path, no settings save and no environment change (I searched all seven new or changed test files). They build settings from text only. Both authors list your real `CD_Settings.json` as changed during their window: n10 says it was restored to a copy last written 4 Oct; n11 says it changed at 03:14:37, three seconds before another lane's `acad.exe` started. I cannot prove who wrote it. CE 02 should confirm those two writes were the robot's own settings-before-launch step.
9. **Full suite.** Neither author ran the full Drainage suite (both ran focused classes only, net48 compile 0 errors). n10 did not run the C77 and C78 defaults classes. The train's full run is the first proof of all six together.

### #1975: BUG-1253 and BUG-1034, invert text kept off its own pipe strip (head 85ed7a3a)

1. **What changes for the drafter.**
   1. **After a pit MOVE, and on Tidy labels Apply:** an IL text, pipe label or other CE text that lies across its OWN pipe's blue strip now counts as a clash. CE slides it to the nearest clear spot using the usual spot order: slide along, other side, further out.
   2. **A spot on its own strip is no longer offered.** This is the BUG-1034 case: "in from the pipe end" landing on the pipe.
   3. **Texts left alone:** a text placed by hand is left with no message (`TextClashTidyUpRule.cs:126-128, 139`). A text with no clear spot stays and is listed.
   4. **How the overlap is judged:** CE uses the text's true turned rectangle, not the square box around it (`OwnPipeStripClearRule.cs`, `TouchesStrip`; `LabelPlacementRule.cs:155-161`). A label beside a sloping pipe is therefore not called a clash.
   5. **Does it match the carpark?** Yes. BUG-1253's expected line says none of the texts "newly sits on ... a pipe strip". BUG-1034's says "clear of the pit AND of its own pipe line". The carpark says to fix the two together, and this PR does.
   6. **The open question in BUG-1034** ("If sitting on the pipe is the intended spot, the desk records that and closes this") was not put to Tim. The author followed the expected-behaviour line. I agree that needs no question: the expected line is Tim-facing text already in the carpark.
2. **Switch.**
   1. **The switch:** `linking.tidyKeepsLabelsOffOwnPipeStrip`, ON (`UserSettings.cs:719`, "Default: on."). It is pinned through both start-up reads (`B124N10OwnPipeStripTests.cs` lines 173-204).
   2. **OFF restores the old behaviour exactly.** With OFF, `keepOffOwnStrip` is false (`LinkService.TextClashTidyUp.cs:274`), so no box gets a turned rectangle (line 314) and no own-strip segment is added (line 334). In the rule, `fixedPipesNotOwnStrip` is then the same list, and `BoxTouchesPipe(TidyBox, …)` falls through to the old four-number test for every ordinary pipe.
   3. **No new engineering value.** The strip half-width is the existing `PipeStripHalfWidth(data)`: diameter/2, or the twin-detention width, which is the same figure the other-pipe test already used. There is no new clearance figure; touching counts as a clash.
3. **No-hard-blocks (R-27).** Pass. Nothing stops or opens a window. A text with no clear spot is held and listed (test `ATextOnItsOwnStripWithNoClearSpot_IsHeldAndListed_NeverForced`).
4. **Protection and REDO.**
   1. **Locked layers:** handled by the existing code. A text on a locked layer, or any record that is not "Update" (line 292), gets no spots and is never moved. Side effect: such a text lying on its own strip is now LISTED as "no clear spot" after each pit MOVE, where before it was silent. That is noise only, not a block.
   2. **Xrefs and REFEDIT:** unchanged.
   3. **Measuring writes nothing.** The rectangle is measured on a non-database copy that is disposed straight away (`TryReadOrientedTextRect`, line 879), so nothing is written to the drawing and nothing is added between U and REDO.
   4. **Error handling:** only AutoCAD's own errors are caught there. A different error type would stop that pipe's tidy just as an unreadable extents does today.
   5. **Callouts:** these are MLeaders and get no rectangle (lines 295-306), so they never clash with their own strip, as the doc says.
5. **Merge.** See group facts 3 to 5. Clean on the tip.
6. **Tests.**
   1. **What they prove:** they exercise the pure rules, including a real old-versus-new pair: `ASlideThatLandsOnTheOwnStrip_IsNotTaken…` asserts the old answer "in from the pipe end (1)" with no own strip and "further out" with it. The new-type tests could not have compiled before, which is the trivial form of "fails before".
   2. **What is not tested:** the service wiring (the switch read at line 274, the rectangle read at line 314, the own-strip add at line 334). It runs only inside AutoCAD.
   3. **Real folders:** no real-folder access (group fact 8).
7. **NOT proven.**
   1. **The measuring method** (turned copy plus `GeometricExtents`) has never run on a real DBText or MText. If CE's masked MText reports extents that include the mask border, normal labels could measure closer to the strip than they look.
   2. **Normal labels may move.** CE's quick invert placement puts the text anchor exactly one radius from the centreline, then adds the mask offset, which is at least 70 mm (`TextService.cs` `GetInvertMaskOffset`, `AdjustMaskedInvertAnchorPoint`). So a normally drawn invert text should measure about 70 mm clear. If it does not, every invert text beside every moved pit would be pushed out a lane. **This is the main regression risk.**
   3. **A pipe label the drafter picked onto the pipe when drawing it** (manual pick, `TextService.cs` around line 141) is protected only if CE recorded it as placed by hand. If not, it will now be moved off the pipe after a pit MOVE.
   4. **The drawn strip** is assumed to be exactly the diameter wide.
   5. **The text type of the G5 invert texts** was not checked by the author. A block attribute or MLeader gets no rectangle, which means no fix and the old behaviour.
8. **Robot and Codex.**
   1. **N10_pit_move_strip / C10, as in the author's report (G5 copy, MOVE P3 0,2000).** N10 passes when the upper-left IL text is more than half the diameter from the centreline. C10 (switch false) must show the old overlap, or the case proves nothing.
   2. **Add a "nothing else moved" check:** on the same MOVE, the other four invert texts, the number circle and the cover text must keep exactly their old positions (read every text's insertion point before and after). This guards point 7.2.
   3. **Add a sloping-pipe check:** a pit with a 45-degree pipe whose IL text sits beside the strip. MOVE the pit 500 mm along the pipe; the IL text must not be reported or moved.
   4. **Codex look:** one picture of the moved pit at working zoom: "every invert text beside its pipe, none on the blue fill".
9. **Verdict: KEEP-WITH-NOTE. Train class FULL** (it changes the tidy that runs after every pit MOVE, always on). Note for CE 01: the robot's "nothing else moved" check in 8.2 is required before Claude-accepted.

### #1976: BUG-1161, moved or flipped label keeps its kept wording (head d9f58c22)

1. **What changes for the drafter.** When a pipe label is moved, flipped or gripped (CDTEXTSEG, the label grip, a hand MOVE), its record now keeps the wording kept before and after the value, for example "APPROX. " (`LinkService.SegmentAnalysis.cs:261, 271-272`). Before, those two fields came back empty on that route. The split route already kept them (`Split.cs:2627`). This matches the carpark's expected line exactly ("Copy both fields from the previous entry").
2. **Switch.** `linking.movedLabelKeepsKeptWording`, ON, pinned through both reads. OFF passes null for both fields, which is exactly the old result: the old object initialiser never set them and their default is null (`LinkService.State.cs:487`). There is no engineering value involved.
3. **R-27.** No stop, no window.
4. **Protection and REDO.** This is a record field only, written inside the caller's existing transaction. There is no new write, and locked layer, Xref and REFEDIT handling is unchanged. One edge case: `Registration.cs:2280` also passes `previous` while it may change the label's role or linked field. Kept wording from the old role would then carry to the new role (for example, "APPROX." moving from an IL to a size label). `DisplayMode` and `CustomDisplayText` already carry the same way, so this is consistent, but CE 02 should know about it.
5. **Merge.** Stacked on #1975, which it does not need for its code; it was stacked only because of the shared files. Clashes are the Settings list and the change log only.
6. **Tests.** Rule tests, plus source pins that the move, flip and grip routes pass `previous` and that the rebuild uses the one rule. The rule test for OFF versus ON is a real before/after on the rule. No real-folder access.
7. **NOT proven.** The visible effect. If a later refresh re-reads the wording from the text itself, this change makes no visible difference (the author says so; the carpark says "visible effect UNSURE").
8. **Robot.** N11_label_wording / C11 as in the n10 report: give a label "APPROX.", flip it with the grip, then read the pipe record's `LinkedDisplayPrefix`. Then also change the pit's invert (so the IL refreshes) and read the drawn text: it must still start "APPROX.". That second step is the only one that shows the drafter anything. Needs the two-session check before Claude-accepted.
9. **Verdict: KEEP-WITH-NOTE, Civil area + smoke.** Note: the record check alone is not enough for acceptance; the refreshed text must be read too.

### #1977: BUG-873, Tidy labels writes nothing until Yes (head 9022d0d1)

1. **What changes for the drafter.** CDTIDYLABELS, then answering No, pressing Esc, refusing the switch-on, or getting "nothing to move", now leaves the drawing exactly as it was. Before, the start-up stamped the drawing as a CE drainage drawing, and on the first CE command in that drawing saved CE's record into it, before any question. This matches the carpark's expected line ("A cancelled or preview-only Tidy labels run writes nothing to the drawing").
2. **What the code does.**
   1. **Settings and the switch:** `TidyLabelsCommand.cs:37` loads settings (`InitServicesCore`, which is exactly the first three lines of the old `InitServices`; `CeCommandBase.cs:30-58`). It then reads the switch.
   2. **Switch ON:** CE binds its in-memory record to this drawing without saving (line 48, the same bind PITSCHEDULE and the Inspector use).
   3. **After Yes:** at line 97 the old two calls run: mark the drawing active, then set the drawing path.
   4. **The note.** Because the bind has already set this drawing's path, the second call takes the "same name" early return (`ProjectDataService.Mutations.cs:167`) and does NOT reach the save at line 185. So after Yes the record is not saved at that moment; it is saved by the normal save at command end or drawing save.
   5. **Why that matters only for the paperwork:** it is the same as every other command that uses the bind, and nothing is lost. But the REGRESSION_LOG entry (item 3) and the n11 report say "the two writes ... now run once, after Yes", and only the stamp does. The robot should not expect a "Project data switched to" log line after Yes either.
3. **Switch.** `linking.tidyLabelsWritesNothingUntilYes`, ON, pinned through both reads. OFF reaches the old two calls at the start and nothing after Yes, so the old behaviour is restored exactly, just reached through the two calls rather than the helper. There is no engineering value involved.
4. **R-27.** No new stop. The REFEDIT refusal (line 50) is old behaviour and correctly a refusal under the native-protection rule.
5. **Protection and REDO.**
   1. **Improves REDO-safety:** No and Esc no longer commit a marker transaction.
   2. **Previous drawing:** the bind may still save a record owed to the PREVIOUS drawing into that previous drawing (`BindCore`, `writeOwedSave: PerformPendingSaveLocked`). That is the existing behaviour of the old helper too, and it never writes to this drawing.
   3. **Protected files:** `ProjectDataService.Mutations.cs` and `Persistence.cs` are called, not edited. `CeCommandBase.cs` is not edited.
6. **Tests.** The source-order pins really fail on the old code: the old code contains `InitServices(doc)`, which the test asserts is gone. The existing `C60AuditSourcePinGuardTests` assertion was re-pointed from `InitServices(` to `MarkDrawingActive(`. That is fair, because the OFF branch still writes before Yes by design, and the ignored BUG-863 test stays ignored. No real-folder access.
7. **NOT proven.**
   1. **The drawing's change count (DBMOD) after No.** The count pass still opens and commits a normal transaction (BUG-863, ignored test `TidyCountPass_UsesNoNormalTransaction`). If DBMOD still moves after No with the switch ON, that transaction is the cause, and it needs its own change.
   2. **REDO after No** has not been driven.
8. **Robot.**
   1. **N11_tidy_no_write / C11_tidy_no_write as in the n11 report:** read DBMOD, run CDTIDYLABELS with All, answer No, then read DBMOD again. Do it in both an Esc variant and a No variant.
   2. **Add a REDO check:** draw a line, U, run CDTIDYLABELS and answer No, then REDO. The line must come back.
   3. **Use a drawing never opened by CE in this session,** so the old first-command save would have fired. Otherwise C11 shows nothing.
9. **Verdict: KEEP-WITH-NOTE, Civil area + smoke.** Note: correct the REGRESSION_LOG item 3 wording at assembly or in a follow-up: "the drawing stamp runs after Yes; the record is bound without saving and saved at the normal save". That is wording only, not a code change.

### #1978: BUG-890, leader-out never sends a callout onto a plain label that stays (head 4dc1b03a)

1. **What changes for the drafter.** This applies only with "move a crowded label out with a leader" ON (`linking.tidyLeaderOut`, OFF by default).
   1. **Before:** a plain text with no clear spot "reserved" its far-out clear space as if it would move there. It never moves, because CE draws no new leader for it. A later callout could then be planned onto the plain text's real place.
   2. **Now:** only labels that really move out (callouts) take a new place (`TidyLeaderOutRule.cs:134`). The plain text keeps holding its own place, and its clear space is still found and reported.
   3. **Carpark:** this matches the expected line ("The final applied set never overlaps a label that stays").
2. **Switch.** `linking.tidyLeaderOutKeepsPlainLabelsPut`, ON, pinned through both reads. The test also asserts that `linking.tidyLeaderOut` itself stays OFF.
   1. **OFF restores the old behaviour:** OFF passes null (`LinkService.TextClashTidyUp.cs:434`), which treats every label as moving.
   2. **Proven by a test:** `EveryLabelListedAsAbleToMoveOut_IsTheOldBehaviourExactly`.
   3. **No engineering value involved.** The callout set used is the same `calloutHandles` (MLeaders only, line 304) that decides which labels really move.
3. **R-27.** No stop.
4. **Protection and REDO.** Planning only. Locked-layer texts already get no spots and never reach the leader-out stage.
5. **Merge.** Auto-merges in the tidy file with #1979 and #1980. Otherwise only the Settings list and the change log clash.
6. **Tests.** A real before/after: `OldBehaviour_ACalloutIsSentOntoThePlainLabelThatStays` reproduces the fault (the callout lands 200 mm down, on the plain text), and the switch-ON test shows it clear, with the plain text's own 100 mm clear space still reported. No real-folder access.
7. **NOT proven.** A real drawing with leader-out on.
8. **Robot.** N11_tidy_leaderout_plain / C11 as in the n11 report, with `linking.tidyLeaderOut` true before launch. Read the callout's final box against the plain text's box.
9. **Verdict: KEEP, Civil area + smoke.**

### #1979: BUG-891, the tidy reads the pipe's own space and reaches as far as leader-out (head 995a736a)

1. **What changes for the drafter.**
   1. **Pipes drawn in one layout:** when every pipe in the pass is drawn in the same layout, the text scan reads that layout, not model space (`LinkService.TextClashTidyUp.cs:155, 162, 652, 756`). A layout pipe's labels are no longer shifted for model-space text that only happens to share coordinates.
   2. **Model-space pipes:** their owner IS model space, so they are unchanged.
   3. **Mixed spaces:** a pass with pipes in two spaces falls back to the old model-space scan.
   4. **The reach:** with leader-out ON, the search margin is never smaller than the leader-out distance (lines 611, 621-629, 639).
   5. **Carpark:** this matches the expected line ("The scan uses the pipe's own space and covers every destination").
2. **Switch and the margin finding.**
   1. **The switch:** `linking.tidyScanCoversOwnSpaceAndFullReach`, ON, pinned through both reads. OFF passes a null space (model space) and the old fixed margin, which is the old behaviour exactly.
   2. **The margin finding.** The old margin is `TidyUpSearchMarginMm` = 2 × 275 + 1000 = **1,550** (line 28). The default leader-out distance is **1,500 mm** (`TidyLeaderOutRule.DefaultMaxDistanceMm`). At default Settings, max(1550, 1500) leaves the margin unchanged. The reach half only acts when a drafter sets the leader-out distance above 1,550 mm.
   3. **Not a defect:** it is honest, and the code is right. But the report and REGRESSION_LOG present it as a fix that applies generally.
   4. **No new engineering value.** It uses the existing Settings leader-out distance, converted to drawing units.
3. **R-27.** No stop.
4. **Protection and REDO.** Read-only scan of a different block table record (the layout), opened for read. No write. Xref content inside a layout is still a block reference and is handled as before.
5. **Merge.** Auto-merges with #1978 and #1980 in the tidy file. I read the #1979 x #1980 result (group fact 4.3).
6. **Tests.** Rule tests for the space choice and the margin, plus source pins that both search boxes use the one margin helper and that the scan takes the space through the rule. The service's use of `OwnerId` has no live test. No real-folder access.
7. **NOT proven.**
   1. **Whether CE pipes ever sit in a layout on a real job** (the author says so too).
   2. **Two scans still read model space only:** pit cover-level text (`TidyPitText.cs`) and the live-word scan (`CollectTextBoxesNear`). For a layout pipe, the pit cover text tidy still uses model space. That is outside the entry, but CE 02 should not be surprised by it.
8. **Robot.**
   1. **N11_tidy_layout_space / C11 as in the n11 report.**
   2. **Reach-case setting:** for any reach case, set `linking.tidyLeaderOutMaxMm` to about 3,000 mm (and `linking.tidyLeaderOut` true) before launch. At the default distance the reach half cannot show.
9. **Verdict: KEEP-WITH-NOTE, Civil area + smoke.** Note: record in the change log at assembly that the reach half has no effect at default Settings.

### #1980: BUG-962, faster scan on big drawings (head 4b03038b)

1. **What changes for the drafter.**
   1. **Speed only.** Tidy labels, and the after-MOVE tidy, decide "is this text near any pipe?" with a grid lookup instead of testing every pipe's area (`Rules/TidyWindowIndex.cs`; `LinkService.TextClashTidyUp.cs:735-736, 756, 818`). Labels should move exactly as before.
   2. **Carpark:** this matches the expected line ("rejected ... through a bounded lookup, with local obstacles still complete").
2. **Switch.** `linking.tidyScanUsesWindowIndex`, ON, pinned through both reads. OFF uses `windows.Any(b.Clashes)`, the old test exactly. The grid size cap (256 cells a side) is an internal speed figure, not an engineering value, so it does not belong in Settings (R-00 not engaged).
3. **R-27.** No stop.
4. **Protection and REDO.** A pure in-memory lookup. No write.
5. **Same answer as the old test (my read of the grid).** Windows and query boxes are mapped to cells by the same clamped floor, so a box and a window that touch on a cell line always share a cell. Clashes stay inclusive. Fewer than two windows, or any non-finite number, falls back to the old test. I see no way for the grid to miss a window the old test would find.
6. **Tests.** An equivalence test over 20,000 random boxes plus edge-touching boxes against the old `Any` test; a far-away test showing far fewer window tests; the fallback cases; and a source pin that both scan tests use the index only when ON. A speed change has no fail-before, and that is fine here. No real-folder access.
7. **NOT proven.** The real time saved on a large drawing. The Yes pass still scans again, and the per-pipe filter is unchanged.
8. **Robot.** N11_tidy_time / C11 as in the n11 report. Compare the "will move" count AND the list of moved handles, not just the count, between N and C; then compare the `[PERF] CDTIDYLABELS count` milliseconds.
9. **Verdict: KEEP, Civil area + smoke.** It changes code on the after-MOVE path, so the full run that #1975 forces also covers it.

### What I could not verify

1. **I did not compile or run anything.** "Green" here means the authors' runs, as stated in their reports.
2. **I did not run a single merge of all six plus the other open PRs together,** only pairs.
3. **I did not check the G5 drawing's text types,** or whether CE's masked MText extents include the mask border.
4. **I did not identify who wrote the real `CD_Settings.json`** during the two authors' runs.
