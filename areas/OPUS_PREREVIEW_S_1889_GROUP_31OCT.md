# Opus pre-review S: PRs #1889, #1890, #1891, #1892, #1896, #1897 (C-79 candidates)

Written Saturday 31 October 2026, 19:30 Melbourne, by an independent read-only Opus reviewer for CE 05 at CE 00's request.
Release tip checked: claude/rel-20261102a at 3fbb9da5 (Civil). All six PRs are Civil only; none touches Structural.
Heads reviewed: #1889 ff36dbeb, #1890 5e8e208f, #1891 7e19a867, #1892 9545489c, #1896 6c6f0db1, #1897 b73618c3.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the code and the authors' reports and ran read-only `git fetch` and `git merge-tree` only.

## FOR TIM

1. **#1889 CDRENUMBER "no outlet" wording (BUG-1237): KEEP-WITH-NOTE, Civil area + smoke.** It now says "draw the last pipe out to an open end, then run CDRENUMBER again". Letting you pick the outlet pit yourself is still not built.
2. **#1890 "Not saved" on a damaged drawing (BUG-1071): KEEP-WITH-NOTE, Civil area + smoke.** Ignore and CDRULEBOOK no longer claim a save that did not happen. CDCHECK's "main outlet" save still has the same fault and needs its own bug entry.
3. **#1891 copied downpipe gets its own tag (BUG-1246): CHANGE-NEEDED, FULL.** The copy now becomes DP3, not a second DP2. The fault: CE can put the copy's new DP3 label on a locked layer without checking the lock first. That breaks your locked-layer rule. It is a small fix (see the detail section, #1891, item 4).
4. **#1892 one damaged pit record no longer stops every pit dragging its pipes (BUG-1141): KEEP-WITH-NOTE, FULL.** The robot must open the damaged drawing in a fresh AutoCAD for each run. Otherwise the warning line is shown only once and the second run looks wrong.
5. **#1896 Help pages for Reverse Flow, Label Styles and Move Arrow (BUG-1218, BUG-1220): KEEP-WITH-NOTE, Civil area + smoke.** Wording only. Nobody has looked at the Help window.
6. **#1897 one cover figure on every screen (BUG-903): KEEP-WITH-NOTE, Civil area + smoke, but install it only together with #1920.** On its own it lets a driveway pit with 250 mm depth pass where it failed before. The reason is that it still measures to the pit invert, not to the pipe top. #1920 fixes that.
7. **None of the six has been opened in AutoCAD.** All six are built and unit-tested only, and all six bugs stay OPEN. The merges are easy: the only clash in this group is the top of the change log (REGRESSION_LOG.md), which needs both entries kept.

---

## DETAIL

### Group facts (apply to every PR below)

1. **Bases.** #1889, #1890, #1891 and #1892 branch from 91963bd0, which is 11 commits behind the tip. #1896 and #1897 branch from 7c6af57b, which is 1 behind. None has been tested on 3fbb9da5. The train's full run must be the proof.
2. **Merge against the tip (read-only `git merge-tree`).** #1889, #1890, #1891 and #1892 each conflict in REGRESSION_LOG.md only, because every one adds an entry at the top. #1896 and #1897 merge clean. `UserSettings.cs` auto-merges for all six.
3. **Merge between the six.** Every pair conflicts in REGRESSION_LOG.md only. No code file clashes. `UserSettings.cs` auto-merges in every pair, because each adds its switch at a different place. I checked the pairs one at a time; I did not run all six merged in one go.
4. **Merge against the other open PRs on rel-20261102a (I checked 30).** Only one real clash: **#1892 x #1877 (BUG-1112), `UserSettings.cs` line about 739.** Both add a switch straight after `RaingardenLabelWithoutNumber`. Keep both blocks, one after the other. Everything else is REGRESSION_LOG.md only. #1897 and #1880 both touch `InspectorPaletteService.cs` and merge clean.
5. **Stacking.** #1920 (B-096) is based on #1897's branch, is one commit ahead of it, and merges onto it cleanly. The order must be #1897 and then #1920, in the same train.
6. **Defaults test.** There is no `C79NewSwitchDefaultsTests` yet; the last one on the tip is C78. Five new switches ship ON. Each is pinned in its own PR's test class through both start-up reads (`DeserializeSettings` and `DeserializeSettingsTolerant`), with "typed false changes only itself" tests. The switches are `linking.renumberNoOutletSaysWhatToDraw`, `linking.saveSkippedSaysNotSaved`, `linking.copiedDownpipeGetsOwnTag`, `linking.unreadableLinkRecordSkippedOnOpen` and `checks.screensShareOneCover`. **The finaliser should add all five to a C-79 defaults class.** None has a Settings page row. Decision 126 already puts them on the planned "Switches" tab, so no new question is needed.
7. **Test isolation (from the authors' own listings, not checked by me).** Every author redirected TEMP, the CE log folder and the Structural settings root to a scratch folder. No real settings file changed during the #1889/#1890 (p7) or #1892 (p10) runs. The #1891 (p11), #1896 (p16) and #1897 (p14) authors each saw `TIM_CE_CADTOOLS\CD_Settings.json` or `CD_RecentValues.json` change during their window. Each matched the change to a robot AutoCAD start by time, and none can prove their own run did not do it. p14 also had an accidental Manager and Structural run inside that window. I did not open `%APPDATA%`.
8. **The same two compiled-code test failures** (`FinalLandingProducer...` and `RefusedNativeCallback...`) show in every author's Debug full run. p7 ran both on the untouched base and they failed there too. They are not caused by this group.

---

### #1889: B-067, BUG-1237, CDRENUMBER says what to draw when it cannot find the outlet

1. **What the drafter sees.** On a drawing where no pipe leaves any pit to open ground or an outfall, CDRENUMBER used to print "No pit discharges outside the network - CE could not tell which pit is nearest the outlet." Now it prints: "CDRENUMBER numbers the pits from the outlet, but no pipe leaves any pit to open ground or an outfall, so it cannot tell which pit is the outlet. Draw the last pipe from the downstream pit out to an open end (finish it clear of every pit), then run CDRENUMBER again. Nothing was renumbered." (`Rules/PitRenumberOutletWordsRule.cs` 22-27). It still stops at the same point (`PitRenumberNetworkBuilder.cs` 138-142). The command reads the switch once and passes it to both builds (`PitRenumberCommand.cs` 48-50 and 60).
2. **Against the carpark.** The carpark entry asks for a sentence saying what to add, "or a question that lets you pick the outlet". The sentence is built. Picking the outlet yourself is not, and the author says so (REGRESSION_LOG item 5). That is fine for a low-severity wording bug, but put "pick the outlet pit when none is found" on the build list so it is not lost.
3. **Switch.** `linking.renumberNoOutletSaysWhatToDraw` (`UserSettings.cs` about 1108) ships ON, and a missing file or group reads ON (`IsOn`, line 19). OFF returns the old sentence byte for byte. The test `SwitchOff_TheOldSentenceReturnsExactly` and the old `NoTerminalOutlet_Refuses` test, now run with the switch off, both pin it, em dash included. No engineering value is involved.
4. **No-hard-blocks (R-27).** The stop is old behaviour; this PR adds no new stop. It is still a dead end until the drafter draws an outlet pipe. Offering the pick (item 2) would turn it into a choice.
5. **Native protection and REDO.** Nothing is written, no layer is touched, and there is no regen, view or system-variable change.
6. **Tests.** `Bug1237RenumberNoOutletWordsTests` has 7 methods. The new-words test would fail on the base because the old sentence has no "Draw the last pipe". The defaults, typed-false and save tests are real. The test drawing matches Tim's drawing in hand check H13: P1 to P2, plus two pipes running into P1 from open ends.
7. **Not proven.** Nobody has run it in AutoCAD. Robot case C31 (the author's own design) is sound. Add one check: the pit labels P1 and P2 are unchanged afterwards. Switch-off twin: the exact old line.
8. **Verdict: KEEP-WITH-NOTE (the outlet pick goes on the build list). Class: Civil area + smoke.**

### #1890: B-067, BUG-1071, CDCHECKIGNORE and CDRULEBOOK say "Not saved" when CE did not save

1. **What the drafter sees.** This only happens on a drawing whose CE record CE is holding as unreadable (the BUG-971 protection). Ignore used to print "Ignored: P1 ... Type U to take it back" although nothing was stored. Now it prints "Not saved: the CE data in this drawing could not be read, so CE has left it exactly as it is and has not saved this. P1 ... is not ignored and still shows on the Checks list. Nothing was changed, so there is nothing to undo." (`Rules/SaveSkippedWordsRule.cs` 20-36). The same applies to Un-ignore and to all six CDRULEBOOK saves: the pit drop by shortcut and by prompt, council set and cleared, cover override set and removed (`RulebookCommand.cs` 59-61, 146-148, 171-173, 183-185, 202-204, 215-217).
2. **How it works.** `WriteProjectKeyInDrawing` and `WriteRulebookMetadata` now return false when the hold skips them (`ProjectDataService.IgnoredChecks.cs` 44-45, `ProjectDataService.RulebookDrawing.cs` 399-400). Every other failure still throws as before. `WriteChoice` passes back the writer's answer. I checked `IgnoreFindingWriteGate.Run`: the save runs before `Run` returns, so the answer is ready when the command reads it (`CheckIgnoreCommand.cs` 92-102). This matches the carpark's expected behaviour.
3. **A sibling left with the same fault (new bug needed).** `SpineCheckCommand.cs` 476 and 480 save the main outlet with `SetRulebookSettingsInDrawing` and ignore the answer. On a held drawing, CDCHECK's main-outlet nomination can therefore still report a save that did not happen. The author left it out on purpose because it is not in BUG-1071. CE 05 should file it as its own carpark entry.
4. **Switch.** `linking.saveSkippedSaysNotSaved` (`UserSettings.cs` 624-631) ships ON and is pinned through both reads. OFF gives back the old success lines, because `SayNotSaved(false, x)` is always false (`SaveSkippedWordsRule.cs` 17). No engineering value is involved.
5. **No-hard-blocks.** No new stop. The refusal to write over damaged data is BUG-971's existing protection; this PR only tells the truth about it.
6. **Native protection and REDO.** No new write. The writers are unchanged apart from their return value. One small point: Ignore still runs the nested CDCHECKIGNOREAPPLY command, which leaves an empty Undo step. "Nothing to undo" is true for the drawing, but one U would step back over that empty step. That is cosmetic.
7. **Tests.** The word and decision tests, plus four source checks (a scan of the code text): the writers return false on the held path, Ignore asks before it prints "Ignored:", and every one of the six rulebook saves keeps its answer and asks before its success line (`Bug1071SaveSkippedWordsTests.cs` 130-176). The source checks would fail on the base. No test drives a real held drawing. The author says that needs AutoCAD.
8. **Not proven.** The held-drawing path in AutoCAD, and that the stored bytes stay unchanged. Robot case C32 (the author's design) covers both. Add one check: after the "Not saved" line, CDCHECKS still lists P1's wrong-layer finding.
9. **Verdict: KEEP-WITH-NOTE (file the CDCHECK main-outlet sibling). Class: Civil area + smoke.**

### #1891: B-071, BUG-1246, a copied downpipe gets its own next tag

1. **What the drafter sees.** This is the case where AutoCAD gives CE no exact copy record, which is Tim's CR in hand check H39. Before, the copy stayed DP2 and CE printed the "could not be given its own link" line. Now the copy gets the next free tag, the same number New DP would give. It gets a fresh identity, its own record (its links to the original's pit and pipes are cleared) and its own plan label. The new line reads "[CE] The copied downpipe was given its own tag DP3 (the original stays DP2). Check where it connects." (`LinkService.CopiedSourceOwnTag.cs` 20-94, `CopiedSourceOwnTagRule.cs` 32-44, `LinkService.Utilities.cs` 233-247). This matches decision 80 for downpipes. Decision 80 also asks for every CE object kind to be checked for the same copy behaviour; this PR does not cover that, and the desk still owes the check.
2. **Switch.** `linking.copiedDownpipeGetsOwnTag` (`UserSettings.cs` about 1198) ships ON and is pinned through both reads. OFF: nothing is subtracted and the old line counts every downpipe as before (`Utilities.cs` 240-247). That restores the old behaviour exactly. No engineering value is involved.
3. **No-hard-blocks.** There is no new stop. A copy that cannot be tagged falls back to the old line.
4. **Native protection: FAULT, change needed.**
   - `IsSpineWritable(clone, tr)` (line 34) checks only the copied downpipe's own layer, Xref and REFEDIT.
   - The new label is drawn on the original label's layer (lines 62-73). Nothing checks that layer is unlocked. `AppendLabelText` says in its own comment, "The caller has already checked the layer is writable" (`SourceTagService.cs` about 627), and this caller has not.
   - So if the downpipe's layer is open but the label layer (normally GUIDELINES) is locked, CE adds new text to a locked layer. As I understand AutoCAD's .NET rules, adding a new object to a locked layer is not refused, so the protection would be quietly bypassed. I have not checked this in AutoCAD.
   - The author's own robot case expects the opposite ("a locked GUIDELINES layer: copy stays DP2 with the old line").
   - **Fix, about five lines:** read the label layer's `LayerTableRecord.IsLocked`. If it is locked, either draw no label and add "its label was not drawn because layer X is locked" to the line, or leave the whole copy untagged with the old line. I recommend the first: the tag is the important part.
5. **Other risks (not proven either way).**
   - **A leftover copied label:** if the drafter selected the DP2 label together with the downpipe, AutoCAD copied that text too. It still reads DP2, and nothing erases or re-links it. The result would be a stray "DP2" text beside DP3's new label. The robot should run one CR with the label selected.
   - **Undo:** the write runs in CE's command-end clean-up, in its own transaction for each copy. Whether one U takes away the retag only, or the whole CR, is not proven. The robot must type U and read the result, then U again.
   - **The label does not turn:** it sits at a fixed distance up and right of the copy, whatever the rotation. The author says so.
6. **REDO-safety.** The new writes sit inside `ReconcileClones`, after `RedoHistoryCommandEndRule.MayWriteAtCommandEnd`. Six reviewed lines were added to `RedoSafeReviewedHooks.baseline.txt` with that reason. No regen, view or system variable change, and no layer is created: the author removed an earlier `EnsureLayerNonPlot` call, and a test pins that.
7. **Tests.** `Bug1246CopiedDownpipeOwnTagTests` has 8 tests: the words, the switch through both reads, and source checks (one caller behind the switch, New DP's numbering rule, no unlock, one commit). The words test would fail on the base. Nothing tests the locked label layer of item 4.
8. **Not proven.** Everything in AutoCAD. Robot N38 and its control C38 are sound. Add: (a) the label layer locked with the downpipe layer open; (b) CR with the label selected too; (c) U, then U again. Codex look: where the DP3 label sits on a 90-degree copy.
9. **Verdict: CHANGE-NEEDED (item 4: check the label layer lock before drawing the label, and say so on the line). Then KEEP. Class: FULL (the copy clean-up shared by COPY, CR, SCALE copy and grip copy, and a REDO-list change).**

### #1892: BUG-1141, one unreadable pit or pipe record no longer stops CE remembering every pit's links

1. **What the drafter sees.** After opening the drawing, or after U, one damaged pit or pipe record used to make CE forget every pit's links. MOVE of good pits then left their pipes behind, and nothing was said. Now that one record is skipped and every other pit still drags its pipes. One line names it: "[CE] The CE link record on one pit (drawing handle 2A4, at 1250.5, 8000) could not be read, so CE skipped it and loaded the rest. That pit may not drag its pipes when it is moved; its record has been left as it is." (`UnreadableLinkRecordRule.cs` 23-31). This matches the carpark's expected behaviour, except that the pit is named by drawing handle, not pit number. The author's reason is that at open the project record may not belong to this drawing yet, and a wrong name is worse than a handle. I agree.
2. **How it works.** Five reads now go through tolerant readers (`LinkService.Cache.cs` 575, 665, 745, 1005, 1039, 1056): pit, source and pipe in the full rebuild, and pit, pipe and pipe-member owner in the idle refresh. The pit reader reuses BUG-1142's existing parser. The pipe reader catches only bad-text errors (`JsonException`) (`LinkService.Persistence.cs` 853-905).
3. **Switch.** `linking.unreadableLinkRecordSkippedOnOpen` (`UserSettings.cs` 739-746) ships ON and is pinned through both reads. OFF goes back to the old reads that throw (`Persistence.cs` 855-856 and 868-869). No engineering value is involved.
4. **No-hard-blocks, native protection, REDO.** It removes a silent failure and adds no stop. The damaged record is only read. A test pins that the new methods hold no write, no unlock, no commit and no system variable. The new command-line line is not a drawing change.
5. **Robot trap (important for CE 02).** The "named once" memory is keyed on the drawing's FingerprintGuid (`Persistence.cs` 883). Copies of one DWG share that number. If N41 and its twin, or two passes, open copies of the same drawing in one AutoCAD session, the second one prints nothing. **Restart AutoCAD between those runs**, or save each copy under a fresh fingerprint (for example a SAVEAS of a new drawing with the same objects).
6. **Two different lines about the same pit.** When the same damaged pit is also met by the pipe-linking scan, BUG-1142's existing line names it by pit number ("pit P5"), while this one names it by handle. The drafter may see both. That is acceptable, but CE 05 may want one wording later.
7. **Tests.** The test `OneDamagedRecordAmongTen_NineLoad...` (`Bug1141UnreadableLinkRecordTests.cs` about 100-118) calls BUG-1142's parser, which is already on the base, so it **passes before the fix too**. It is not a before-and-after test. The real proof is the source check `TheRebuild_ReadsEveryPitAndPipeRecordThroughTheTolerantReads`, which would fail on the base. Two older source-pinning tests were edited to follow the renamed read; the checks they make are unchanged.
8. **Not proven.** Everything in AutoCAD. Also, a pit with a damaged record is still not dragged when that pit itself is moved; the author says the move path's own reader is unchanged. Robot N41 and its twin N41_off are as the author designed them, plus item 5.
9. **Verdict: KEEP-WITH-NOTE (item 5 must go into the robot case; item 7 recorded honestly). Class: FULL (the link memory behind every MOVE drag, on open and on Undo).**

### #1896: B-074, BUG-1218 and BUG-1220, Help pages: Reverse Flow wording, Label Styles and Move Arrow cards

1. **What the drafter sees.** In CDHELP:
   - **Reverse Flow** no longer promises a "Change preview" or an "Apply" button. It describes the command-line explanation and the "Continue? Yes or No (Enter means No)" question, and says one Undo puts it back (`guide-content.js` line 103).
   - **Two new cards:** "Label Styles · CDLABELSTYLE" in Settings (line 97) and "Move Arrow · CDMA" in Edit (line 48). Both are marked typed only.

   I checked the Reverse Flow text against the command (`RibbonContextCommands.cs` 47-60), and it matches. I checked the Label Styles card against the dialog (`LabelStyleDialog.xaml` 123 and 134), and it matches, including "Apply to drawing saves first, then updates existing pit level labels".
2. **Not checked by me.** The second half of the CDMA card ("you can type the two end levels (Enter skips them) and answer whether to reverse the arrow") describes the pipe-pick branch. I read only the first prompt of `CdCommand.Arrows.cs` (about 264). The carpark also expects F1 from inside Label Styles to open the new page. I did not trace that route through `CdHelpService`.
3. **Switch.** None: wording only, no behaviour change. R-00 does not apply.
4. **Blocks, protection, REDO.** None. Help text only.
5. **Merge note.** The Help render test now expects 83 Help cards (`HelpGuideWindowRenderTests.cs` 93). Any other PR in the same train that adds a Help card will clash on that number. None of the open PRs I checked does.
6. **Tests.** `B074HelpWordingTests` reads the Help file and the command source. The Reverse Flow test would fail on the base, which still says "Change preview". The Label Styles test checks each button name in both the dialog and the card, which is a good guard against drift. It runs on net10 only (`#if NET8_0_OR_GREATER`).
7. **Not proven.** How the cards look in the Help window, and that search finds them. Robot H31 and H32 (the author's design) are fine. Codex look: one picture of each card. Also press F1 inside Label Styles.
8. **Verdict: KEEP-WITH-NOTE (check the CDMA pipe-branch wording and the F1 route during the robot or Codex look). Class: Civil area + smoke.**

### #1897: B-022, BUG-903, every cover screen reads the one minimum cover CDRULES uses

1. **What the drafter sees.** The following now read `RulebookValues.MinCoverFor(pit surface)`, the same figure CDRULES R-04 uses:
   - the Inspector pit cover row and network summary;
   - the Civil Hub;
   - the CDGRAPH repair Pass D and the health snapshot;
   - the Edit Pipe and CD grade/flow strips;
   - the pit editor and Smartify strips.

   The figure comes from a council figure or project override first, then the cover table row for the surface, then the office minimum (`MinimumCoverForChecks.cs` 46-162). Examples: a Road pit with 400 mm depth is now flagged against 600 (it was OK against the office 300). A Driveway pit with 250 mm depth now passes against 200 (it was flagged against 300). This is what register item B-052 asked for ("B-022 must read RulebookValues.MinCoverFor").
2. **Engineering concern: install with #1920, not alone.** These screens still measure **pit depth** (cover level minus pit invert) and now compare it with the **pipe-cover** figure from the cover table. For driveways and gardens that is looser than before. The 250 mm driveway pit now passes, and the PR's own test pins it (`TheDriveway_PitWith250Depth_NoLongerFlaggedAgainstTheSingle300`). On a real pit, a 250 mm depth to the invert leaves the pipe top only a few tens of millimetres below the surface. Tim's decision 127 ("10yes") asks for these screens to measure to the outside top of the pipe; #1920 does that and is based on this branch. **Ship #1897 only in the same train as #1920.** If #1920 slips, hold #1897 too.
3. **Wording faults (small, fix in #1920 or at finalising).**
   - The Hub line still reads "depth is below the 600 mm **office target**" when 600 is the Road table or a council figure (`CivilNetworkHealthService.cs` 251). #1920 rewrites that line.
   - The `UserSettings.cs` comment (3687-3692) says Civil Design reads the shared figure. It does not: the PR's own REGRESSION_LOG item 5 says Civil Design and CDRUNSOLVE still read one network-wide minimum. Correct the comment.
4. **Switch and R-00.** `checks.screensShareOneCover` ships ON and is pinned through both reads plus a grid test for "OFF equals the old figures" (`Bug903OneCoverFigureTests.cs` 27-110). OFF restores each screen's old read exactly (`Reader()`, 145-164). **R-00 trap:** while this file-only switch is ON, the Settings page tick for the older switch `coverUsesRulebookValue` has no effect. A drafter who unticks it will see nothing change. Put both on the decision 126 "Switches" tab with one plain line saying which one wins. No new figure is hard-coded. The 400 mm Warning/Error split in the Inspector pit row is an existing fixed number; the author flags it and leaves it alone.
5. **No-hard-blocks, protection, REDO.** Read-only screens and advice strips. No drawing write (a test pins that), no new stop, regen, view or system variable change.
6. **Tests.** The per-surface figure, council and override precedence, the strictest-end rule for strips, "unknown stays unknown", the worked Road and Driveway examples, a source check that every screen goes through the one path, and no drawing write. The worked-example and source-check tests would fail on the base.
7. **Not proven.** The Inspector and Hub text on screen (Codex look). A pit with no surface picked (it should keep the office figure). The strips in Edit Pipe and CD with two pits on different surfaces (the strictest should win). Robot N40 and its control C40 (the author's design) are fine. Run them after #1920 is stacked, with #1920's N96 cases, because the figures in N40 change once #1920 measures to the pipe top.
8. **Verdict: KEEP-WITH-NOTE (install only with #1920; fix the "office target" wording and the Civil Design comment). Class: Civil area (cover and check screens) + smoke.**

---

### Robot (CE 02) and Codex summary

1. **C31** (#1889) and **C32** (#1890), as in report p7, plus the extra checks above.
2. **N38 and C38** (#1891), plus three extra checks: a locked label layer, CR with the label selected, and U then U again. Codex look: the label on a rotated copy.
3. **N41 and N41_off** (#1892): **restart AutoCAD between runs** (item 5 of #1892).
4. **H31 and H32** (#1896). Codex look: a picture of each new card, and F1 inside Label Styles.
5. **N40/C40** (#1897), run together with **N96/N96c** (#1920) on one build. Codex look: the Inspector pit row and the Hub list.
6. **Every case needs a failing twin on 3.0.85 (or the switch-off control) before it counts towards Claude-accepted.** Items that need engineering judgement (the cover figures in #1897 and #1920) still need Tim's word.
