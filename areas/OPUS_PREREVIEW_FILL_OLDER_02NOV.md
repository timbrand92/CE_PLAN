# Opus pre-review FILL (older switch drafts): PRs #1010, #705, #928, #1382, #1513

Written Monday 2 November 2026, about 03:30 Melbourne, by an independent read-only Opus reviewer for CE 05 at CE 00's request (queue filler 6).
Civil line checked: origin/claude/rel-20261102a at 3fbb9da5 (Civil 3.0.88, C-78), as the brief asked. Note: newer Civil lines exist (rel-20261108a = Civil 3.0.90 C-79b1, rel-20261112a = C-79c finalizer); nothing in this group changes because of them.
Structural line checked for #1382: origin/claude/rel-20261026s (Structural 1.0.125, S-45), the newest Structural release branch on the remote.
Heads reviewed: #1010 1ca9c514, #705 a9334dfd, #928 9dd4f8e4, #1382 578d133d, #1513 9a26c6bb. All five are DRAFT and still OPEN on GitHub.
Nothing was built, tested, installed or opened in AutoCAD by this review. I ran read-only `git fetch`, `git ls-remote`, `git merge-base`, `git merge-tree` and `gh pr view` only.

## FOR TIM

1. **The big finding: none of these five needs merging.** Four of them are already in your installed Civil, word for word. The fifth (#1382, the dots hatch) was replaced by a different, later fix that follows your 20 Oct ruling. The five GitHub pages were simply never closed.
2. **#1010, a LandXML round pit comes in at its real size, not 600 x 600: ALREADY LANDED (Civil 3.0.75, C-65). Close it.** Example: a consultant file says a pit is 1050 diameter; CE now draws it 1050. The switch is ON, as your Set C answer allowed.
3. **#705, New Pit's cover box after a restart: ALREADY LANDED (Civil 3.0.33), then overtaken by your 5 Oct answer "Blank". Close it.** Today New Pit opens with the cover blank, even with "Remember last pit settings" ticked. Recall Last still fills it.
4. **#928, CDTWL pipe storage measured wall to wall: ALREADY LANDED (Civil 3.0.48). Close it.** The switch is OFF, so CDTWL still gives the old number. The "conflict" GitHub shows is only the change-log file and does not matter now. One note: the new "matches within 0.5 per cent" Settings value is not read by any command yet.
5. **#1382, dots hatch density at 1:20, 1:50 and 1:100 (Structural, not Civil): SUPERSEDED. Close it, do not merge.** Your later fix (in Structural 1.0.121) does the same job for all hatches and is ON. Merging #1382 would add a second, clashing switch and clash in seven files.
6. **#1513, CDTIDYLABELS moves a crowded callout out with its leader: ALREADY LANDED (Civil 3.0.69, C-59). Close it.** It is OFF by default. One fault it left (a callout could land on a plain label that stays, BUG-890) is fixed by #1978, which is in the newer C-79c line, not in 3.0.88.
7. **Built, tested, accepted:** all four Civil pieces are built and installed with their switch at the stated default. None of them has been Codex-accepted or Tim-accepted in AutoCAD for the switched-on behaviour, as far as I can find. The robot checks are listed below.
8. **Verdicts:** #1010 KEEP-WITH-NOTE (close, landed); #705 KEEP-WITH-NOTE (close, landed and overtaken); #928 KEEP-WITH-NOTE (close, landed; tolerance not yet used); #1382 CHANGE-NEEDED (close as superseded); #1513 KEEP-WITH-NOTE (close, landed; BUG-890 follow-up in C-79c). No train class is needed for any of them.

---

## DETAIL

### Group facts

1. **Already on the Civil line.** `git merge-base --is-ancestor <head> origin/claude/rel-20261102a` is TRUE for #1010, #705, #928 and #1513. `git merge-tree --write-tree` of each head with the tip gives the tip's own tree (b93851dc) every time: merging any of them changes nothing.
2. **First release that carried each** (earliest `Version:` commit on the ancestry path): #705 Civil 3.0.33; #928 Civil 3.0.48; #1513 Civil 3.0.69 (C-59); #1010 Civil 3.0.75 (C-65). These agree with C:\CE_PLAN\areas\PR_PILE_TRIAGE_2026-10-24.md, which already listed #705, #928 and #1513 as "class A: head is an ancestor of installed 3.0.72", and #1382 as "class G: same bug as #1498, already installed".
3. **#1382 is Structural.** Its base claude/rel-20261017s is Structural 1.0.118. Neither of its two commits (b7108265, 578d133d) is on rel-20261026s. BUG-748 landed there instead through commits f19b054d, 33a7b912 and 80f28581 (PR #1498, also still open on GitHub, branch b03/ad-any-dimscale), first released in Structural 1.0.121 (S-41).
4. **No two PRs in this group touch the same function.** #1010 is the LandXML parser, #705 New Pit, #928 CDTWL, #1513 CDTIDYLABELS, #1382 Structural hatches. The only shared files are the two Civil `UserSettings.cs` (different classes) and `REGRESSION_LOG.md`, all already merged.
5. **Recommended action for CE 05 / CE 00:** close #1010, #705, #928 and #1513 with a comment "landed in Civil 3.0.xx via the release train"; close #1382 as "superseded by #1498 (Structural 1.0.121)". Do not rebase or merge any of them.

### #1010: Set C item 8, LandXML circular pit reads "diameter" first

1. **What changes for the drafter.** CDIMPORTXCIVIL on a LandXML file: a round pit (`CircStruct`) whose size is in the standard `diameter` field now comes in at that size. Before, CE read only `diamWidth`, and a pit with only `diameter` fell back to 600 x 600. `Modules/Drainage/Helpers/LandXmlParser.cs` (PR line 194; tip line 223): reads `diameter` when the switch is ON, falls back to `diamWidth` if that is zero or missing. This matches the Set C recommended answer, which Tim accepted under INT-073 and INT-078 ("the rest i am happy with", decisions/2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md line 608).
2. **Switch.** `xcivilImport.landXmlCircularDiameterFirst`, default ON (UserSettings.cs tip line 3671). Pinned through BOTH start-up reads (`DeserializeSettings` and `DeserializeSettingsTolerant`) in `Modules/Drainage.Tests/Services/C65NewSwitchDefaultsTests.cs` line 49, and re-pinned in C66 to C69. OFF restores the old reading exactly (only `diamWidth`). No engineering number added; the 600 fallback is older code, not this PR.
3. **No-hard-blocks.** No stop or window added.
4. **Protection / REDO / protected files.** Reading a file only; no drawing write in the changed lines. No protected file.
5. **Merge.** Already an ancestor of the tip; merge-tree result = tip tree. Nothing to resolve.
6. **Tests.** PR says 2 of 5 new tests failed before the parser change (RED first), then passed. The tests set `SettingsService.Current` in memory and put it back (`LandXmlParserTests.cs` tip lines 332-335). I could not re-check the historical run's %APPDATA% use; the code shown touches no file.
7. **Not proven.** No real consultant file with only `diameter` has been imported in AutoCAD. A file with both fields that disagree now takes `diameter`; nobody has seen one. Robot (CE 02): import a copy of a LandXML file where one CircStruct carries `diameter="1050"` and no `diamWidth`; expect a 1050 round pit, and with the switch OFF (set before launch) a 600 x 600 pit.
8. **Verdict: KEEP-WITH-NOTE** (already landed in Civil 3.0.75; close the PR). Train class: none needed.

### #705: BUG-401, New Pit cover proposal switch

1. **What changes for the drafter.** As written in the PR: nothing by default. A three-way switch `options.proposeLastPitCoverLevel` (empty / ON / OFF) decided whether New Pit opens with the last cover level (`Rules/NewPitCoverProposalRule.cs`, `ViewModels/PitViewModel.cs` PR line 1141-1155).
2. **Overtaken by Tim's answer.** BUG-401 in BUG_CARPARK.md (line 3594): "DECIDED 5 Oct (Tim, INT-059/060): New Pit cover after restart stays BLANK (default)". Commit 1b509a84 on the line then changed the rule so empty or OFF = blank, ON = propose, and "Remember last pit settings" no longer decides the cover (tip `NewPitCoverProposalRule.cs` lines 3-16, `PitViewModel.cs` line 1170-1172). That is what Tim asked for. The Settings window now has a Blank / Propose choice (`AdvancedSettingsViewModel.cs` lines 1238 and 1350).
3. **Switch default.** Empty, never written (`NullValueHandling.Ignore`, UserSettings.cs tip line 1793). The tip's default meaning (blank) follows Tim's ruling. Pinned through the Settings window save in `Drainage.Tests/Dialogs/CoverProposalSettingsRowTests.cs`; I did not find a pin through both start-up reads for this key. Low risk: an empty `bool?` cannot be read two ways.
4. **No-hard-blocks.** None. The existing "Enter the cover level." warning is unchanged.
5. **Protection / REDO / protected files.** Window values only; no drawing write. No protected file.
6. **Merge.** Already an ancestor of the tip; merge-tree = tip tree.
7. **Tests.** Red first per the PR (50db50ba did not compile), 11/11 then. The view-model wiring is not unit-tested (the PR says so).
8. **Not proven.** Robot (CE 02): with "Remember last pit settings" ticked, place a pit with cover 12.340, restart AutoCAD, PIT: cover box blank; press Recall Last: 12.340 appears. Set the choice to Propose (before launch), restart, PIT: 12.340 proposed.
9. **Verdict: KEEP-WITH-NOTE** (landed in Civil 3.0.33 and since overtaken by the "Blank" ruling; close the PR, it describes a state that no longer exists). Train class: none.

### #928: HUNT2-C-12, CDTWL pipe storage wall to wall, match tolerance in Settings

1. **What changes for the drafter.** With `detention.pipeStorageWallToWall` ON, CDTWL counts a detention pipe's storage only between the inside pit walls, not centre to centre, so the length inside each pit is not counted twice (`Rules/DetentionBranchCollector.cs` `PipeGeometry.TryLengthMm` and `ExitDistanceMm`, PR lines 307-340; `Services/DetentionTwlService.cs` tip lines 193 and 206). Example from the carpark: a 15 m twin 375 run between two 600 pits was over-counted by about 0.13 m3 of 3.3 m3. This is the "smallest fix" the carpark entry (line 10259, part a) asked for.
2. **Switch.** OFF by default (UserSettings.cs tip line 3071), so CDTWL's number is unchanged. Pinned by `new UserSettings()` (Hunt2C12PipeStorageWallToWallTests.cs line 59-65) and by a bare `JsonConvert` read of an older file (Bug871TwlDrawingUnitsTests.cs line 176). **Not pinned through both start-up reads** (`DeserializeSettings` and `DeserializeSettingsTolerant`). LOW: a plain `bool` default of false reads the same both ways today.
3. **R-00 note.** The 0.5 per cent and 1 L match tolerances are now Settings values (`storageMatchTolerancePercent`, `storageMatchToleranceLitres`, tip lines 3087-3103), but the tip's own comment says "NOT USED BY ANY COMMAND YET: StorageDesignedVsDrawn.Compare has no production caller". So the carpark's worry (CDTWL saying "the drawing holds more than the sheet says") cannot come from that comparison today; the values are ready for when a caller exists.
4. **Engineering limits (switch ON only).** The wall is found as if the pit were a square-on rectangle: pit rotation (`PitData.RotationRadians`) is ignored, and a round pit is treated as a square of its diameter, so a pipe entering a round pit on a diagonal is trimmed too much (up to about 40 per cent more than the true radius). Bent runs are still straight (the PR says so). Both are LOW with the switch OFF; they matter before anyone turns it ON.
5. **No-hard-blocks.** None. Touching or overlapping pits fall back to centre to centre (test line 55-56), no refusal.
6. **Protection / REDO / protected files.** A calculation only; no drawing write. No protected file.
7. **Merge and the GitHub "CONFLICTING".** Against its old base claude/rel-20261009l, `git merge-tree` shows the ONLY conflict is `REGRESSION_LOG.md` (the base gained a newer entry at the top). The resolution would be keep both entries, newest first, no code change. It no longer matters: the head is an ancestor of the tip and merge-tree with the tip = tip tree.
8. **Tests.** PR says red first; 80 related pass. The tests use in-memory settings. I could not re-check the historical run for %APPDATA% use.
9. **Not proven.** Robot (CE 02): CDTWL on a copy of a detention job with one straight run between two 600 x 600 pits, switch OFF then ON (set before launch); the storage line drops by about pipe area x 0.6 m. Then repeat with one pit rotated 45 degrees and note the result as "known approximate" before anyone proposes ON.
10. **Verdict: KEEP-WITH-NOTE** (landed in Civil 3.0.48; close the PR). Notes for the carpark, not for this PR: rotated and round pits in the wall-to-wall trim, and the unused tolerance values. Train class: none.

### #1382: BUG-748, dots hatch same paper spacing at every scale (Structural)

1. **What it would change.** With `Layouts.DotsSamePaperDensity` ON, the LBUH dots hatch goes at pattern scale 20 / 50 / 100 for 1:20 / 1:50 / 1:100 instead of 20 at every scale. Default OFF.
2. **Superseded.** Tim's 20 Oct answer (decisions/2026-10-20_TIM_ANSWERS.md line 18, desk reading): "hatch density is the same dots per square cm of paper at every scale (BUG-748, section B4/F2 closed by this rule)". The landed fix uses a different switch, `Layouts.HatchDensityFollowsPaper`, default ON (rel-20261026s `Models/UserSettings.cs` line 1960; `Services/DrawingScaleSetting.cs` lines 15-18; one rule `HatchCommands.PlacementScale` line 1639), and covers every scale-aware preset, not only DOTS. BUG-748's status line says the fix is installed in Structural 1.0.121 via #1498.
3. **Why merging it would be wrong.** It would add a second switch for the same behaviour, default OFF, contradicting the ON ruling and breaking design rule #1 (one code path per behaviour). `git merge-tree` against rel-20261026s conflicts in seven files: HatchCommands.cs, HatchUpgradeCommands.cs, Structural UserSettings.cs, SettingsService.LoadRecovery.cs, CeHatchPresetDialog.cs, HatchPreviewGeometry.cs and REGRESSION_LOG.md. There is no keep-both resolution; the right resolution is to drop #1382.
4. **Questions 3, 4 and 6 (blocks, protection, tests)** were not reviewed in depth because the PR should not merge. Its test file `Bug748DotsPaperDensityTests` is not needed; the landed fix has its own.
5. **Verdict: CHANGE-NEEDED: close #1382 as superseded by #1498 (Structural 1.0.121).** Do not merge. If anything in it is still wanted (the review-fix commit 578d133d stops the dots switch accepting a scale other presets refuse), check that rule against `PlacementScale` on rel-20261026s in a fresh small PR. Train class: none.

### #1513: CDTIDYLABELS, callouts with no clear spot move out with their leader

1. **What changes for the drafter.** With `linking.tidyLeaderOut` ON, CDTIDYLABELS takes a callout that has no clear spot nearby and moves it to the nearest clear space up to `tidyLeaderOutMaxMm` (1500 mm), and its existing leader follows. A plain text that would need a new leader stays put and the report says how far out a clear spot was (`Services/LinkService.TextClashTidyUp.cs` `PlanWithLeaderOut`, PR lines 416-437; `Rules/TidyLeaderOutRule.cs` `SplitByLeaderSupport`). The fix-round commit converts the millimetre Settings values to drawing units, so a metre drawing does not search 1.5 km. This is Batch 1 card 1.4 (Q12) on the recommended answer under INT-073.
2. **Switch.** OFF by default (UserSettings.cs tip line 1289); 1500 mm in Settings (line 1310), not in code. Pinned by `new UserSettings()` (TidyLeaderOutRuleTests.cs line 68) and the Settings window row tests (C60SettingsRowsTests.cs line 41). Not pinned through both start-up reads; LOW for a plain `bool` false. OFF gives the earlier `TextClashTidyUpRule.Plan` call exactly (PR line 335).
3. **No-hard-blocks.** None; held labels are reported, not refused.
4. **Protection / REDO / protected file.** `LinkService.TextClashTidyUp.cs` is a carpark "protected file" (Sonnet lane). I read the changed lines with care. A callout on a locked layer or a hand-placed one has no candidate spots or is not movable, and `Rescue` skips those (tip `TidyLeaderOutRule.cs`: `if (!IsNoClearSpot(hold) || !item.Movable || item.Candidates.Count == 0)`). So locked layers are respected. The move is in the same transaction as the other tidy moves (one Undo). No Xref or REFEDIT path is touched.
5. **Known gap, already fixed elsewhere.** In `Rescue`, a plain text that is "sent out" but then held still has its imagined new spot recorded, so a later callout can be put on top of the plain text's real place (BUG-890, ledger F-030). Fixed by #1978 (4dc1b03a), which is on rel-20261112a (C-79c) but not on 3.0.88 or 3.0.90. BUG-891 (layout pipes checked against model text) is #1979 (995a736a), same line.
6. **Merge.** Already an ancestor of the tip; merge-tree = tip tree.
7. **Tests.** The PR says plainly the code and tests were written together, NOT run red first. 28 narrow tests pass on net10 with `CE_LOG_DIR_OVERRIDE` and "settings files unchanged". Not run: net48, AutoCAD.
8. **Not proven.** Robot (CE 02), switch ON (set before launch), on the C-79c build: a pipe with a callout boxed in by other text; CDTIDYLABELS; the callout moves out up to 1.5 m and the leader still points at the pipe; one U puts it back. Repeat in a metre drawing (distance about 1.5, not 1500). Repeat with the callout on a locked layer: it stays and the report says why.
9. **Verdict: KEEP-WITH-NOTE** (landed in Civil 3.0.69; close the PR; BUG-890 and BUG-891 follow-ups ride C-79c through #1978 and #1979). Train class: none.

### What this review could NOT verify

1. Whether the historical test runs of these PRs touched the real %APPDATA% settings files: I can only read the code and the PR text.
2. Any AutoCAD behaviour: nothing was opened or driven.
3. Whether Codex or the robot has already run any of the switched-ON scenarios above on an installed build; I found no acceptance line for them in BUG_CARPARK.md.
