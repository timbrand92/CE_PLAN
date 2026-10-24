# Train C-64 finalizer report (Civil + Manager), Sat 24 Oct 2026 (real clock 15:42 to about 16:25 Melbourne)

Opus 5.5 (claude-opus-5-5), Team, headless, desk plan/03. Inputs: the C-64 assembly report, the C-64 PR list (read in full), the C-63 finalizer report (method and shape), the reviews named per PR (REVIEW_PILOT_CRITICAL_24OCT, REVIEW_PILE_B1, B2, B3, B6, B7, B8, B10, B11, B15, REVIEW_CX4_AND_BATCH4), `decisions\2026-10-20_TIM_ANSWERS.md` and `decisions\2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md` (no answer in either touches the ten new switches or the shallow-pit depth). Two Opus read-only helpers checked the review asks of Groups 1 to 3 against the merged code (14 PRs and 20 PRs); I did the full reads, the Group 4 first reviews, every verdict, the defaults, the builds and the tests myself.

Built and unit-tested only. Not installed. Nobody has opened it in AutoCAD. No PR closed, no branch deleted, no bug marked FIXED, no version bumped, `DESK_LOG.md` not edited.

## ANSWER FIRST

1. **GO at `f73755eec6439ebb9b18667b1c4364890a7f36c4`.**
2. **Mistakes first, plainly (nothing lost, no time lost):**
   1. **I did not build the base `5467f705` for the six new net48 reds.** The brief asks for it, but the six tests are new in this train (#1601, #1607, #1616): their test classes do not exist on the base, so a base build cannot run them. Instead I showed the cause: all six throw `InvalidProgramException` inside the net48 reference-only AutoCAD DLL (`Point3d.Origin`, `Vector3d.ZAxis`, `Vector3d.Length`), exactly like the 17 known names, and all six PASS on net10 in this run.
   2. **The solution build and the Civil full run went in the background, not the foreground.** Both can run past the tool's 10-minute limit, and the brief also says never kill your own compiler. I polled them myself and never ended my turn while they ran. Every other dotnet command ran in the foreground.
   3. **Correction for the assembler (RULES 6.2):** its net48 filter missed two test classes the train changes (`CeFindQueryTests` from #1565 and `FallSuggestEnterTests` from #1341). I added both; they pass. Its report also says the build lock "could not be taken (stale)": at 15:45 the lock was free and my run script took it for my first five steps, then another job held it for my last two (I built in my own worktree with my own TEMP either way, and never deleted it).
3. **Branch and final head:** `claude/rel-20261024n` @ `f73755eec6439ebb9b18667b1c4364890a7f36c4`, a normal fast-forward push from the assembler's `cb105ba84a04da49ae75106bd9f8105d98a15499` (which matched `git ls-remote` at 15:43 and again just before my push; leak scan clean, 36 terms). Base: installed C-63 `5467f7053a2e9275cb450409c142ef9aa26dad53` (Civil 3.0.73 / Manager 1.1.73). This train becomes Civil 3.0.74 / Manager 1.1.74 when the payload builder stamps it (I did not bump).
4. **What I changed: one commit, `f73755ee`, test only.** New `C64NewSwitchDefaultsTests` (copy of the C-63 one): an older settings file (empty, and a C-63-shaped one) loads the ten new switches ON and the shallow-pit depth at 300 mm through the same two reads AutoCAD uses at start-up; a typed OFF of each switch and a typed depth are kept; the C-61, C-62 and C-63 switches and the 0.013 not-recognised roughness are pinned again. Plus my REGRESSION_LOG entry at the top. No product code changed, no default changed, nothing dropped, nothing else merged. The assembler's own commit `cb105ba8` (the "Default: on." line on the #1419 switch) is kept: it is right.
5. **Group 4 verdicts (first independent review of each fix commit, read in full):** **#1626 KEEP**, **#1597 KEEP**, **#1419 KEEP**, **#1614 KEEP**, **#1722 KEEP**, **#1717 KEEP**. None dropped. Reasons in section 1.3.
6. **#1706 (BUG-225, Pit tab Close button): NOT in this train and I did not take it in** (Idle follow-up with no "REDO not available" check, as the C-63 finalizer found).
7. **Settings defaults (checked in the merged code, every read site and Tim's answers, not the PR text). Ten new switches, all ON, all KEPT ON; one new value; nothing turned OFF:**
   1. **`linking.drawingRecordBeatsPcFile` (#1642, BUG-988): ON.** Old behaviour is the bug: delete a job's last pit and pipe, reopen it, and an old record file on this PC brought back a colleague's rainfall and numbering. Tim sees a change only in a drawing whose CE record is empty while the PC holds an old record file.
   2. **`linking.longSectionUpdateKeepsCopies` (#1627, BUG-997): ON.** Old behaviour is the bug: Update Existing redrew every copy of a long section that shared its block, including copies on locked layers. Tim sees: only the section he picked changes.
   3. **`linking.refoundPitKeepsScheduleOverrides` (#1629, BUG-1022): ON.** Old behaviour is the bug: a pit CE re-found under a new handle lost its typed Pit Schedule figures and row position.
   4. **`linking.renumberScoresJoiningPipe` (#1628, BUG-1005): ON.** Old behaviour is the bug: CDRENUMBER chose a 20 m side run over the 100 m pipe that joins the same pit as "the main line".
   5. **`linking.scheduleXrefGroupsKeepDrawing` (#1631, BUG-981): ON.** Old behaviour is the bug: a schedule from two Xrefs merged two drawings' pits that share an internal handle and blanked their numbers.
   6. **`linking.cdMirrorKeepsPipeTextLink` (#1641, BUG-996): ON.** Old behaviour is the bug: Yes to "mirror the text" cut the text's link to its pipe.
   7. **`linking.xrefCompareChecksOldPosition` (#1640, BUG-992): ON.** Old behaviour is the bug: CDXREFCOMPARE missed CE objects beside a moved roof's OLD position. Tim sees more rows, marked "(old position)".
   8. **`pits.blocksFromRunningBundleFirst` (#1751, BUG-1165): ON.** Old behaviour is the bug: an old all-users CE copy supplied last year's PIT block and fall symbols. No change on a PC with no stale all-users copy.
   9. **`linking.otherUsersFoldersFollowThisPc` (#1754, BUG-1167): ON.** Old behaviour is the bug: a settings file copied from Tim's PC pointed CDWT, CDNEWDWG and job time at Tim's profile. Nothing changes on Tim's own PC.
   10. **`linking.rebuildKeepsOnlyCarrierIdentity` (#1419, BUG-803): ON.** Old behaviour is the bug: CDREBUILD gave a network brought in by WBLOCK or INSERT plus EXPLODE new IDs and cleared its pipe lists.
   11. **A value, not a switch: `linking.shallowPitDepthMm` (#1722, BUG-1035): 300 mm**, the number that was fixed in the code, so nothing changes until an office types another figure. It has a Settings row (Pipes & Pits tab). A blank, zero, negative or unreadable figure uses 300 mm; no hard block.
   12. **For every one:** an older settings file with the key missing loads the default above (my new test, both start-up reads); every read site falls back to the same default when Settings cannot be read (`?? true`, or `?? 0` then the 300 mm rule).
   13. **Earlier switches unchanged** (pinned again): C-61 to C-63 `detention.twlUsesDrawingUnits` ON, `pits.skipCurrentPitBlockRedefine` ON, `linking.pitScheduleUsesPitFloor` ON, `checks.allowIgnoreFinding` OFF, `linking.propagateWritesSingleIlToItsOwnEnd` ON, `linking.escKeepsPlacedCalloutLinks` ON, `linking.scheduleRefreshKeepsTwinAndTrenchText` ON, `xcivilImport.importReviewRefusesChangedSource` ON, `linking.keepUnreadableDrawingRecord` ON, `linking.inlineSplitMovesDecisions` ON, `designStandards.networkUsesPipeMaterial` ON. #1655 changes only the documentation of the existing `detentionWithoutLengthNotDiameterChecked` (still ON; OFF now brings back old R-06 and old R-30 together). Manager adds no switch.
   14. **Settings-fit (150 per cent):** `EveryTab_FitsTheScreen_AtOneFixedHeight` **5 of 5 passed, tallest tab 670 px in all five cases** (at 1920 x 1080 and 150 per cent the window is 1100 x 672 in 688 px available). #1722's box fits, but the window is now exactly at its 670 px limit. `NewSettingsKeys_NeedADocumentedDefault`: **passed**.
8. **QUESTIONS FOR TIM (queued for work hours; none turned into a decision):** section 8 has each in full. In short: (a) the 0.013 roughness for a pipe with no material is unchanged and still built, not accepted; (b) should CE build a finer storm sweep near the peak (a 25 m3 tank could really need about 25.6 m3 with nothing said); (c) not a question: the Ignored list now shows a coded name; (d) where may the start-up heartbeat go on a PC with no approved-address record (#1620, still WAITING).
9. **Manager (a real Manager release):**
   1. **What changed, in plain words:** looking at CEMANAGER or About CE Suite no longer uses up the next U (draw a circle, open CEMANAGER, close it, type U: the circle goes) (#1730, BUG-1085, BUG-1086). The CE Tools tab (Manager, Version, Health) now appears at start-up even when Manager loads before Civil (#1750, BUG-1206).
   2. **Official release build: PASSED, guard at exactly 75 files** ("[CE_SUITE_MANAGER] Complete 75-file, three-lane release candidate verified.", 0 warnings, 0 errors, 16:14). Command: exactly the one in `C:\ce_rc_scratch\p96_scripts\payload96_mgr_build.ps1` (read, not edited), copied into `C:\ce-fin\c64\mgr_build.ps1` with the worktree pointed at `C:\fin64\w`. **Guard constant unchanged and nothing to fix:** the two Manager PRs change two compiled source files only; no file added or removed under `Modules/Manager`, no csproj changed.
   3. **Approved CE_SHARED root:** from a Civil bundle I built in the same worktree with the unchanged `Installer/build_installer.ps1` (EXIT 0, 16:10 to 16:14; all three lanes, the native grip module, the object enabler and 8 shared config files verified by the script). Its CE_SHARED SHA-256: Legacy `BBB9E184...DCEF1`, Net8 `42B7DB00...9EEEC`, Modern `3F1389F5...90647`. These differ from C-63's figures although `Shared/` is unchanged since C-63 (diff empty): the DLL bytes depend on the build folder. **Said plainly:** that Civil bundle carries the 0-byte transform placeholder and is NOT a releasable Civil bundle; it only supplied CE_SHARED. The payload builder uses its own.
   4. **Release archive left in place, as briefed:** the installer script wrote `C:\Lisp Files\SUPERSEDED\CE_CVL_SUITE\20261024_161353_v2026.1024.1610` (388 MB). Not deleted (that folder now has 6 entries, was 5). **C: free:** 19 GB at 15:43, 18.0 GB before the Civil bundle, 16.9 GB after it and after the Manager build, 20 GB at 16:15 after removing my worktree. Never under 12 GB.
   5. **Manager tests:** net10 full **956 total, 955 passed, 1 skipped, 0 failed**. Manager net48 built with 0 errors in the solution build (there is no net48 Manager test project).
10. **Installer and signed-update safety: untouched.** `git diff --stat 5467f705..HEAD -- Shared Installer Installer.Tests Modules/Manager/Installer` is **EMPTY**. No file whose path names OfficialReleaseGate, SafeBundleInstaller, ReleaseAuthority or CE.Host changed; no `.csproj`, `.props` or `.ps1` changed. Civil and Manager carry the same CE_SHARED source as C-63. **No command added or removed:** `command-registry.json`, `ce_toolbar_layout.json`, `ce-tool-register.json` and every `PackageContents.xml` unchanged; CrossModuleGuard 6 of 6 (its command counts pass). The installer EXE does not change in this train. **The Installer suite was NOT run** (compiled only).
11. **Tests (Release, `C:\fin64\w`):**
    1. **Whole solution: 0 errors, 895 warnings** (15:45 to 15:51, before my commit). Civil and Manager built for **net48, net8.0-windows and net10.0-windows**; `CE_CVL_SUITE_Installer` (net9.0) and `CE_CVL_SUITE_Installer.Tests` (net9.0-windows) **COMPILED, not run**. After my commit the Civil test project was rebuilt for net10 and net48: 0 errors each. (The assembler counted 909 warnings; I did not chase the 14-warning difference: same code, no new errors.)
    2. **Civil net10 full: 20,030 total, 20,008 passed, 22 skipped, 0 failed** (15:56 to 16:03). That is the assembler's 20,027 plus my 3. The PDF test passed; the Glen Eira back-test `BackTest_GlenEira24115_Computed_WithinTolerance` is green, so no PR here brought that red in.
    3. **Named net10: 49 of 49 passed.** Settings fit 5 of 5 (670 px), `NewSettingsKeys_NeedADocumentedDefault` 1 of 1, `RedoSafeCallGraphTests` **25 of 25 after all merges** (no DROP, so no second run was needed), CrossModuleGuard 6 of 6, C-61/C-62/C-63/C-64 switch tests 12 of 12.
    4. **Manager net10 full: 956 total, 955 passed, 1 skipped, 0 failed.**
    5. **Civil net48 focused (72 class filters joined by `|`, saved in `C:\ce-fin\c64\f48_filter.txt` until cleanup, the assembler's list plus `C64NewSwitch`, `CeFindQueryTests` and `FallSuggestEnterTests`): 2,233 total, 2,145 passed, 65 skipped, 23 failed.** All 23 are `InvalidProgramException` from the reference-only AutoCAD DLL: **the 17 known names, unchanged** (`NonfiniteSource_IsRefusedBeforeFlattening` x3, `EditorPick_UsesRotatedTranslatedUcsOnce` x2, `JigWorldPoint_PreviewTemporarySegmentAndFinalVertexHaveExactSameXY` x2, `Raingarden_SameOutlineInMillimetresOrMetres_Is600SquareMetres` x2, `Raingarden_UnitlessDrawing_PlacesWithAreaUnknownAndReason`, `Raingardens_AreNamedRG1_RG2_InOrder_AndNeverReuseAName`, `MillimetreDrawing_Raingarden_IsBitIdenticalToTheOldDivision`, `TiltedNestedSource_ComposesAllFramesBeforeFlattening`, `OverflowDuringTransform_IsRefused`, `DefaultImportAndSideDatabaseParametersDoNotOptIntoCdPlanAdmission`, `XcivilImport_DoesNotAskForTheMainToBeTidied`, `FindRecordedPitAt_WithNoExplicitMargin_UsesTheOfficesSettingsValue`) **plus 6 new names, same cause** (#1616 `ABlockRotatedNinetyDegrees_TurnsTheArrowNinetyDegrees`, `TheBlocksOwnRotationAddsToTheArrowsAngleInsideTheBlock`; #1601 `ASingleLabelIsStillGivenToOnlyOnePit`, `TwoClosePits_EachTakeTheirOwnLabel_WhenTheFirstPitsTextIsAlsoNearestToTheSecond`; #1607 `NoSpotsOrFalls_IsStillFine`, `SpotLevelsAndFallArrows_MoveWithThePitsAndPipes`). Not a train fault; see mistake 2.1.
    6. **Installer suite: NOT RUN** (two of its groups run live deploy scripts on Tim's PC).
12. **Tim's settings files: unchanged.** At 15:44 and 16:15: `TIM_CE_CADTOOLS\CD_Settings.json` acd64e79a33 (15,270 bytes, 4 Oct 08:22:30 both times), `CS_Settings.json` 622a246f7d3 (351,713 bytes, 31 Mar 13:18), `CE_CVL_SUITE\settings.json` efe307c4fc7 (672 bytes, 16 Sep 12:13), `CE_STRUC_SUITE\CS_Settings.json` 2972ce70c51 (35,259 bytes, 22 Oct 18:54): hash, size and date identical. **AutoCAD (acad.exe) was running at every one of my steps**; I never touched it. A robot or Codex pass may have been using it; I do not know.
13. **Also in this report:** what Tim will see per merged PR (section 2), the do-not-mark-fixed list (section 3), the LOW items for the next round (section 4), the switches without a row (section 5), the PRs left out (section 6), what was NOT tested (section 7), the questions for Tim (section 8), risks (section 9).
14. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD. None Tim-accepted, Codex-accepted or Claude-accepted.

## 1. Review of every merged PR (merge order)

All 40 merges carry the reference head as second parent (the assembler checked three sources; I re-read each merge diff). The assembler left nothing out. #1706, #1727, #1716 and every WAITING PR are not in the train.

### 1.1 Groups 1 to 3 (thirty-four Opus-reviewed PRs): review asks against the merged head

Every MERGE-WITH-FIXES ask in these reviews is closed in the merged code (#1728's fix is in; the others were plain MERGE). What stays open is the LOW and optional items, all listed in section 4; none is a blocker under R-27.

1. **#1747 BUG-1135:** MERGE. Closed: catch-all on the job record (`ProjectData.cs` 177 to 179), marker never lowered (`ProjectDataService.Mutations.cs` 1966 to 1979), marker raised to 2.3 in one place, redesign freeze copy keeps the unknown parts. Open, as known: only the top level of the record has the catch-all (pits and pipes already had one; raingardens, slabs, rulebook and approvals do not); builds 3.0.73 and older still drop and lower; older builds refuse a CE XREF saved by this one. Full read 1.2.1.
2. **#1642 BUG-988:** MERGE. The one deliberate change stands (empty drawing record while the PC file holds settings only: the drawing's empty record now wins). Full read 1.2.2.
3. **#1627 BUG-997:** MERGE. Open: each separated section adds one block name (accepted). Full read 1.2.3.
4. **#1629 BUG-1022:** MERGE. Open: the saved row order keys still carry the OLD pipe handles (only the pit part of the key is rewritten); when the new key already exists the old entry is dropped; the re-find scan itself is AutoCAD-only and untested. Full read 1.2.2.
5. **#1628 BUG-1005, #1631 BUG-981, #1573 BUG-1007, #1561 BUG-980:** MERGE, no asks.
6. **#1559 BUG-979:** MERGE. Open (not this PR's fault): a joint on a locked layer is skipped without a word (`CdJointCommand.cs` 531 to 533).
7. **#1578 BUG-1012:** MERGE. Open, as known: arcs in a boundary are still read as straight sides.
8. **#1641 BUG-996:** MERGE. Open: whether the label follow keeps the mirrored look when the pipe later moves is AutoCAD-only.
9. **#1599 BUG-995:** MERGE. Open, optional: only two corners are converted to the UCS (a slightly cropped zoom in a rotated UCS); no test of the actual numbers.
10. **#1712 BUG-811:** MERGE. Open: the log does not say the JunctionLowest warning no longer names the other branch, and its entry still says "the Opus review is still to do". Full read 1.2.4.
11. **#1341 BUG-710:** MERGE. Open, LOW: a Unitless drawing really drawn in metres still gives 1:0.1.
12. **#1750 BUG-1206, #1730 BUG-1085/1086:** MERGE. Open on #1730, as known: the "never writes" guard reads the command file and the About window only, not the Manager window's start-up; CESURVEYREVIEW, CEMANAGERUPDATES, CEMANAGERADMIN and CEBLOCKS probably leave the same Undo step and were not changed. Full read 1.2.5.
13. **#1751 BUG-1165:** MERGE. No asks. Full read 1.2.6.
14. **#1754 BUG-1167:** MERGE. Open: the computation-sheet logo path is not covered; a profile on another drive is not matched; BUG-1166 (Max's OneDrive folder) is still open. Full read 1.2.7.
15. **#1638 (privacy):** MERGE. Open: no BUG number (my proposal: **BUG-1221**, the carpark's next free number at 16:00; the desk files it). Full read 1.2.9.
16. **#1618 BUG-991:** MERGE. Open: no plain message for a redirect (it ends as a bare "HTTP 307" error); the Structural markup AI senders still follow redirects (a carpark line is owed). Full read 1.2.8.
17. **#1569 BUG-1008:** MERGE. **The known unchecked point, now checked by reading (helper, confirmed by me):** on a detention pit's FIRST row, a typed remark is replaced in the window by the rebuilt detention wording (`PitScheduleViewModel.Data.cs` 434 to 441, code from July, not from this PR), while the cell stays marked as typed and the drawn table uses the typed text. So the window and the drawn table can disagree on that one row. No data is lost (the typed text is saved). This PR only made the cell reachable by double-click. Not a blocker; a carpark entry is owed (section 4).
18. **#1565 BUG-1003:** MERGE. Open, as known: a pit named like a source tag still finds the tag first.
19. **#1635 BUG-1032:** MERGE. Open, optional, as known: a level a hair above the lid prints "-0 mm below" on the AutoCAD 2027 build.
20. **#1580 BUG-1010:** MERGE. Open: the time log still records the whole break as idle.
21. **#1583 BUG-993, #1616 BUG-1002:** MERGE. Open: a FALL symbol flipped with MIRROR is still read the wrong way (both).
22. **#1554 BUG-799:** MERGE. Open: in a never-saved drawing a relative Xref still reads SOURCE MISSING. I opened one of its eight new window pictures (`pitschedule-unloaded-light-rows.png`): it renders cleanly; it is a test snapshot, not AutoCAD.
23. **#1655 BUG-906:** MERGE. Open, small: the Settings page text for that switch still describes only the size check, not R-30.
24. **#1656 BUG-904:** MERGE. The note ships; the finer sweep is parked (question 8.2).
25. **#1640 BUG-992:** MERGE. Open: the other half of the bug (the saved previous copy is replaced after each compare, so the old roof is forgotten).
26. **#1728 BUG-1036:** MERGE (the review's fix is in: the box starts from the office Settings value). Open, LOW: the box shows three decimals, so 0.0125 would show and be used as 0.013.
27. **#1601 BUG-1001, #1607 BUG-1000:** MERGE, no asks.
28. **#1711 BUG-766:** MERGE. Open: how the tick looks on a bent main is not checked.

### 1.2 Read in full, adversarially, as if new

1. **#1747 (BUG-1135, the job record keeps newer parts; the marker is never lowered): GO.** Every reader and writer of the marker: the one place that sets it is `NormalizeProjectData`, which now keeps a stored marker higher than this build's ("2.3") and raises anything lower; it is reached from load (drawing and PC file), `CloneProjectData` and the empty-record maker. The newer-record check (`CheckSchemaCompatibility`) and the Pit Schedule XREF check (`PitScheduleXrefDiscoveryCore`) both read the shared constant, now "2.3"; the duplicate private constant in `ProjectDataService.cs` now points at it, so there is one number. The catch-all (`[JsonExtensionData]`) rides along every JSON round trip; the field-by-field redesign freeze copy (`TryFreeze`, used by every `CloneForApply` caller: repair audits, source changes, landing, redesign apply, spine snapshots) now deep-copies it, and the version is copied as is. The empty-record check (`HasCivilContent`) counts only the lists, so unknown parts never wake Civil in a drawing; unchanged. **What a colleague on an OLDER build (3.0.73 or earlier) sees with a drawing saved by 3.0.74:** on open, the command line says "[CE] Warning: This drawing was saved by a newer version of CE_CVL_SUITE (schema 2.3). Update the plugin to avoid data loss." every time; when they save, their CE writes "2.2" back (old builds lower it) but loses nothing today, because C-64 adds no new part to the record; and their Pit Schedule refuses a CE XREF saved by 3.0.74 with "Schema 2.3 requires a newer CE Civil plugin". **So every office PC must get 3.0.74 together** (section 9).
2. **#1642 and #1629 (which record wins when a drawing opens; typed figures follow a re-found pit): GO.** #1642: one rule, read before the PC file is looked at: a record CE READ from the drawing wins even when its lists are empty; an unreadable record still falls back to the PC file as before (C-63's hold still applies), and a drawing with no record still migrates from the PC file. #1629: the move of override rows and row order happens inside the existing orphan-pit reconcile, which already saved the record whenever it re-found a pit; it changes only the content of that same save and adds no new write, so nothing new is written between a U and its REDO. A place the new handle already holds is never overwritten.
3. **#1627 (Update Existing changes only the picked long section): GO.** One transaction, so one U. The insert is opened with the existing "unless locked" helper (a section on a locked layer is left alone with one line), and every child is checked for a locked layer BEFORE anything changes, as before. Only then, if more than one live insert shares the block, a NEW empty block is made and the picked insert pointed at it; the shared block and every copy are never touched or erased. Then the new block is drawn. #1711's junction tick sits in the drawing step of the same file and joined cleanly.
4. **#1712 (cascade at a rejoining pit): GO.** Planning order only: a pit where branches rejoin is worked out after every arriving pipe, from the lowest; a tree walks in exactly the old order; a loop is released in the order first reached, so the walk always ends. No new write and no new transaction: the plan is applied by the existing path, one U. `RedoSafeReviewedHooks.baseline.txt` is not changed by any PR; the REDO call-graph test is 25 of 25.
5. **#1730 and #1750 (Manager): GO.** CEMANAGER and CE_VERSION now carry AutoCAD's "no Undo marker" flag. Their bodies only show a window (About is modal; Manager is modeless and returns at once); neither, nor the About window, starts a transaction, opens anything for write, sets a system variable, locks the document or sends a command (the PR's guard pins this, and I searched the whole Manager UI and services: the only drawing writes are in the CEBLOCKINSERT block insert, which keeps its Undo marker, and a MENUBAR set at plugin start-up, not in these commands). So looking at CEMANAGER or About never writes the drawing and never uses a U. Anything the Manager window does later runs as its own command. **The CE Tools tab cannot be built twice:** the start-up build is now always queued; a later rebuild request removes the waiting Idle hook before adding it again (one hook), and the tab is found by its fixed name `CE_TOOLS_TAB` and its panels cleared before rebuilding (`RibbonBuilder.EnsureTab`, `BuildTabPanels`).
6. **#1751 (blocks from the running bundle first): GO.** Only the search order moves: the running bundle's own `Contents\Blocks` goes first and is not searched twice; when CE is not running from a bundle, or the switch is OFF, the order is unchanged. The BLK-001 check (`ValidateBlockFilePath`) still runs on whatever file is found, unchanged (it warns in the log about a file outside the plugin folder, Program Files or ProgramData; it never blocked). The user bundle folder was already in the search list (third); it now wins over the all-users copies. It is not trusted more than before in any real sense: the same folder holds the running CE DLL itself, so anyone able to plant a block there could already replace the program.
7. **#1754 (another user's folders follow this PC): GO.** A folder path is changed only when it lies inside ANOTHER person's profile (a sibling of this PC's profile; Public, Default and All Users excluded) AND does not exist on this PC; a folder that exists is never rewritten; a path outside the profiles folder is never touched. The whole check is inside a try and returns the path unchanged on any error, so it never throws. It logs one line per changed folder each time the settings file is loaded (not once per session: a small difference from "logs once", harmless). Nothing changes on Tim's own PC (his own profile is excluded).
8. **#1618 (the shared AI sender does not follow a redirect): GO.** The one shared web client in `CE.AI.Core` is now built with redirects off, so a 3xx answer comes back as an error and the request (question, drawing facts, access key) is never re-sent to the address it names. The seat-grant call in the CE assistant already had redirects off. Other senders outside this PR remain as they were (Structural markup AI senders; the telemetry flush, which is #1620's area).
9. **#1638 (coded name instead of the Windows login): GO.** CDCHECKIGNORE now stores the name Settings > Privacy allows (coded by default, "ce-" and letters), through the same helper other drawing writers use. Existing ignore records are not rewritten, so an old record keeps its login; a re-ignored "asked again" row gets the coded name.

### 1.3 Group 4 (six PRs, first independent review of each fix commit)

1. **#1626 (BUG-998, network redesign "before" levels): KEEP.** Fix commit `e852f258`. Cause real (the before levels were the pit floors, so a pipe arriving above the floor looked "changed after the preview" and held up Apply). The fix does what the review asked: each pipe's own end levels are matched to the connection's pits by name (kept, swapped, or not used and the pit floors used as before), and the per-pipe list uses the pipe limit (4,000) not the pit limit (2,000). Tests fail without it (the new rule and limit tests). Preview data only: no drawing write, so Undo, Esc and REDO are untouched; no switch needed (old behaviour is the bug). The builder notes the swap is a guard (the redesign's binding check already refuses a record that runs the other way).
2. **#1597 (BUG-1024, CDSPINEUPGRADE Apply brings a rebuilt record back in step): KEEP.** Fix commit `10ed4f53`. The dry run still returns before anything is written. A record-only repair no longer saves an empty rollback file (which would have hidden the real one); the closing line says so. The writes stay in one transaction (one U). The "Nothing to write" line is reached only when the record is in step (source check added). LOW: a record-only repair has no rollback file of its own (U still undoes it).
3. **#1419 (BUG-803, CDREBUILD keeps a network's IDs after WBLOCK or INSERT plus EXPLODE): KEEP.** Fix commit `f0a87b5a`. The review's MEDIUM is closed: the stored handle of every object judged a COPY is left out of the old-to-new map, so a kept pit can no longer be pointed at an unrelated live pipe that happens to have that handle; the LOW is closed: the spine key is counted before the blank-handle skip. Verdicts and carriers stay in step (added in the same block). Writes only inside CDREBUILD; a pit or pipe on a locked layer fails its open-for-write and is counted as an error, never unlocked. Switch ON, documented (the assembler's line). LOW: tests cover the rule, not a whole CDREBUILD run; the later relink step was not traced (reviewer's note).
4. **#1614 (BUG-1009, Pit Schedule Xref rows): KEEP.** Fix commit `d91e4dfb`. The double-click path (`HighlightBestPipeForRow` to `HighlightPipeFromRow`) now stops on an Xref row with "This pipe is in an attached drawing (Xref), so CE cannot highlight it from here." and never looks the handle up in the current drawing; single click and Enter were already guarded. Read only. Test added.
5. **#1722 (BUG-1035, the "Shallow" depth is a Settings value): KEEP.** Fix commit `db50498a` adds the Settings box (Pipes & Pits, Pit Schedule group) with a plain warning line and no hard block. Default 300 mm = the old fixed number, so nothing changes by default; kept out of the design-standards group so saved CDRULES check records do not change. **Settings-fit test run by name: 5 of 5, tallest tab 670 px: it fits, exactly at the limit.** The layout is a draft; a Codex look at the window is owed.
6. **#1717 (BUG-812, a redesign's new pit takes its mark-order place; copied pump pit reported): KEEP.** Fix commit `676874b5` (the reviewer had already read it). Rows already placed never move; a new pit goes after the nearest earlier mark using the schedule's own order (the existing natural-order switch, still OFF, decides where P2A goes). The copied-pump-pit line and the read-failure line print once per drawing per session (remembered by drawing fingerprint and line). Command-line text and a preview list only: no drawing write.

### 1.4 #1706 (BUG-225): not in this train; I did not take it in (Idle hook with no "REDO not available" check, per the C-63 finalizer).

### 1.5 Merge conflicts re-read

1. **REGRESSION_LOG.md:** for each of the 40 PRs, every non-blank line it added (from its own merge-base) is on the head: **0 missing in all 40**. No line of the C-63 log removed (0 deleted lines against `5467f705`). 0 conflict markers. Order: newest merge on top (#1717 down to #1747), then the C-63 finalizer. Headings with no blank line before them: **160 on the base, 160 on the head** (the new region adds none). Headings 1,345 on the base, 1,393 now (46 from the PRs, the assembler's and mine).
2. **`UserSettings.cs`:** every PR's added lines present except the one line the assembler deliberately extended (`... Default: on.` on the #1419 switch). The ten new switches and the value are each a separate block with its own initialiser and its own documentation line saying its default ("Default: on." or "Default: 300 mm."). JsonProperty names are unique inside every class (checked by script); all ten switches and the value sit in `LinkingSettings` (JSON group `linking`) except `blocksFromRunningBundleFirst` in `PitMigrationSettings` (group `pits`). The list file wrote four without the `linking.` prefix; the code shows they are in `linking`.
3. **Other files touched by more than one PR** (every added line checked present): `PitScheduleDialog.xaml.cs` (#1569 REMARKS column and #1614 Xref zoom guard), `PitScheduleViewModel.cs` (#1614 highlight guard and #1722 depth from Settings), `FallArrowGeometry.cs` (#1341 run in millimetres and #1583 block rotation), `LongitudinalSectionService.cs` (#1627 own block and #1711 junction tick), `ProjectDataService.cs` (#1747 one constant and #1629 move on re-find), `PipeFlowCalcViewModel.cs` (#1561 refill and #1728 roughness from Settings). 0 missing in each. Build and tests green.
4. **Scope:** `Shared/`, `Installer`, `Installer.Tests`, `Modules/Manager/Installer`: empty. Outside `Modules/`: `CE.AI.Core` (#1618, 3 lines and its tests), the log, and #1554's eight pictures. New product files: five small Civil rule/service files, no new Manager, Shared or Installer file.

## 2. What Tim will see in AutoCAD (plain words, per merged PR)

1. **#1747 BUG-1135:** nothing new on 3.0.74. A colleague still on 3.0.73 opening a drawing saved on 3.0.74 sees "saved by a newer version" and cannot schedule its Xref.
2. **#1642 BUG-988:** delete a job's last pit and pipe, save, reopen: the job keeps its own rainfall and numbering, not an old file's.
3. **#1627 BUG-997:** copy a long section, Update Existing on one: only that one changes.
4. **#1629 BUG-1022:** a pit block copied or re-inserted keeps its typed Pit Schedule figures and its row place.
5. **#1628 BUG-1005:** CDRENUMBER keeps main-line numbers down the long pipe (P10, P11, P12, P13), not up a short side run.
6. **#1631 BUG-981:** a Pit Schedule from two drainage Xrefs keeps each drawing's pits on their own rows, numbers not blanked.
7. **#1559 BUG-979:** CDJOINT, Esc at "Select slab type": the old joints stay.
8. **#1578 BUG-1012:** a pipe crossing the last side of a closed boundary gets its boundary mark on the long section.
9. **#1573 BUG-1007:** CDFALL in a metre drawing points the way picked.
10. **#1641 BUG-996:** CD, Yes to "mirror the text": the text stays linked and moves with the pipe.
11. **#1561 BUG-980:** CDCALC Pipe Flows, pick a second pipe: its grade and roughness fill in (a typed value is kept).
12. **#1599 BUG-995:** with a moved UCS, Inspector health buttons, Pit Schedule row clicks and CEFIND zoom to the right pits.
13. **#1712 BUG-811:** at a pit where two branches rejoin, the cascade sets the outlet below the lower arriving pipe.
14. **#1341 BUG-710:** CDFALLSUGGEST in a metre drawing suggests 1:100 over 20 m, not 1:0.1.
15. **#1750 BUG-1206:** the CE Tools tab is there at start-up whichever CE part loads first.
16. **#1751 BUG-1165:** PIT and fall-symbol blocks come from this PC's installed CE, not an old all-users copy.
17. **#1754 BUG-1167:** on a colleague's PC with a copy of Tim's settings, CDWT, CDNEWDWG and job time find their own office folders.
18. **#1638 (privacy):** CDCHECKIGNORE's Ignored list shows "ce-" and letters instead of the drafter's Windows login (old entries keep their login).
19. **#1618 BUG-991:** nothing, unless the AI address redirects: then CDASK shows an HTTP 307 error instead of following it.
20. **#1569 BUG-1008:** double-click a Remarks cell in the Pit Schedule: it opens for typing (shown in italics as an override).
21. **#1565 BUG-1003:** CEFIND P1A, C2 or C2-C3 zooms to the pit or pipe.
22. **#1635 BUG-1032:** CDTWL names the pipe "P3 -> P2" and says "N mm ABOVE the lowest lid (water would come out)".
23. **#1580 BUG-1010:** a 6-minute break with a 5-minute idle limit offers back 1 minute, not 6.
24. **#1583 BUG-993:** CDCHECK reads a FALL symbol turned with ROTATE the right way.
25. **#1554 BUG-799:** an unloaded Xref shows SOURCE UNLOADED, not SOURCE MISSING.
26. **#1655 BUG-906:** CDRULES R-30 says "not judged (enter the length or untick Detention)" when the detention length is missing.
27. **#1656 BUG-904:** CDDESIGN adds a note when the 5-minute storm governs the storage.
28. **#1640 BUG-992:** CDXREFCOMPARE also lists pits beside a moved roof's old position, marked "(old position)".
29. **#1730 BUG-1085, BUG-1086:** draw a circle, open and close CEMANAGER or About CE Suite, U: the circle goes.
30. **#1728 BUG-1036:** the Pipe Flows Roughness box starts at the office Settings value; the note says "(from the pipe material, per office Settings)".
31. **#1601 BUG-1001:** an X-Civil import gives two close pits their own numbers.
32. **#1607 BUG-1000:** after a shifted X-Civil import, spot levels and FALL arrows land beside their pits.
33. **#1616 BUG-1002:** a rotated consultant FALL block imports pointing the right way.
34. **#1711 BUG-766:** a long section made through CDPROFILE shows the "100 DIA. BRANCH" tick.
35. **#1626 BUG-998:** network redesign no longer calls an untouched pipe "changed since the preview" when it arrives above the pit floor.
36. **#1597 BUG-1024:** CDSPINEUPGRADE Apply after a record rebuild says it is bringing the record back in step and that no rollback file was needed.
37. **#1419 BUG-803:** WBLOCK pits P1 to P3 out, INSERT and EXPLODE, CDREBUILD: they keep P1 to P3 and their pipes.
38. **#1614 BUG-1009:** click or double-click an Xref row in the Pit Schedule: a plain line, no zoom to an unrelated object.
39. **#1722 BUG-1035:** a new box "Shallow pit depth" (300 mm) on the Settings Pipes & Pits tab.
40. **#1717 BUG-812:** a redesign's new pit takes its mark-order place in the Pit Schedule (P2A after P2 only with natural order ON); a copied pump pit gets one command-line line.

## 3. Do not mark FIXED (each needs a robot PASS plus a Codex PASS in AutoCAD on copies; engineering items also Tim's word)

1. **BUG-1135 (#1747):** open a drawing whose record has a made-up extra part on 3.0.74, edit a pit, save: the part and the higher marker are still there; a 3.0.73 PC shows the newer-version line.
2. **BUG-988 (#1642), BUG-1022 (#1629):** the empty-record reopen; a copied pit keeps its typed schedule figures and row.
3. **BUG-997 (#1627), BUG-766 (#1711), BUG-1012 (#1578):** long section copy, junction tick, closing-side mark.
4. **BUG-1005 (#1628), BUG-981 (#1631), BUG-979 (#1559), BUG-1007 (#1573), BUG-996 (#1641), BUG-980 (#1561), BUG-995 (#1599):** each its REGRESSION_LOG checklist.
5. **BUG-811 (#1712, level-cascade half only; the AI vision half stays open), BUG-710 (#1341):** cascade at a rejoining pit, one U; metre-drawing CDFALLSUGGEST.
6. **BUG-1206, BUG-1085, BUG-1086 (Manager #1750, #1730):** CE Tools tab with Manager loading first; CEMANAGER and About then U.
7. **BUG-1165 (#1751), BUG-1167 (#1754):** a PC with a stale all-users bundle; a copied settings file on a colleague's PC.
8. **#1638 privacy fix (no bug number yet; proposal BUG-1221):** CDCHECKIGNORE stores a coded name; an old entry keeps its login.
9. **BUG-991 (#1618):** unit-proven only; a live redirect cannot be tested on Tim's PC without a test server.
10. **BUG-1008 (#1569), BUG-1003 (#1565), BUG-1032 (#1635), BUG-1010 (#1580), BUG-993 (#1583), BUG-799 (#1554), BUG-906 (#1655), BUG-904 (#1656, plus Tim's answer to 8.2), BUG-992 (#1640), BUG-1036 (#1728), BUG-1001 (#1601), BUG-1000 (#1607), BUG-1002 (#1616):** each its checklist (windows need a Codex look).
11. **Group 4 (all kept):** BUG-998 (#1626), BUG-1024 (#1597), BUG-803 (#1419), BUG-1009 (#1614), BUG-1035 (#1722, needs a Codex look at the Settings box), BUG-812 (#1717).
12. **Not in this train:** BUG-225 (#1706), BUG-1138 (#1748) and the rest of section 6.

## 4. LOW items for the next round (none a blocker under R-27; what Tim loses if they ship as is)

1. **#1569 (new from this finalize, by reading):** on a detention pit's first row, a typed remark shows as the rebuilt detention wording in the window while the drawn table uses the typed text. Tim loses: the window and the table disagree on that one row. **A carpark entry is owed** (code from July, made reachable by this PR).
2. **#1747:** catch-all only at the top level of the record; a "reads every older record" test before the next record change; every PC must get 3.0.74 together.
3. **#1629:** saved row order keys keep old pipe handles; the old entry is dropped when the new key exists.
4. **#1730:** CESURVEYREVIEW, CEMANAGERUPDATES, CEMANAGERADMIN and CEBLOCKS probably still leave an Undo step; the guard does not cover the Manager window's start-up.
5. **#1618:** no plain line for a redirect; the Structural markup senders still follow redirects (carpark line owed).
6. **#1754:** the logo path and other-drive profiles are not covered; one log line per changed folder per settings load.
7. **#1712:** log entry has a stale "review still to do" line and does not mention the JunctionLowest wording change.
8. **#1559:** a joint on a locked layer is skipped without a word.
9. **#1578:** boundary arcs read as straight sides.
10. **#1599:** two-corner UCS conversion (slightly cropped zoom).
11. **#1341:** Unitless drawing drawn in metres still gives 1:0.1.
12. **#1565:** a pit named like a source tag finds the tag first.
13. **#1635:** "-0 mm below" on AutoCAD 2027.
14. **#1580:** the time log counts the whole break as idle.
15. **#1583 and #1616:** a MIRRORed FALL symbol is read backwards.
16. **#1554:** never-saved drawing: relative Xref still SOURCE MISSING.
17. **#1655:** Settings page text for the R-06 switch does not mention R-30.
18. **#1656:** a peak between two tested storms gets no note (question 8.2).
19. **#1640:** the previous Xref copy is replaced after each compare.
20. **#1728:** three decimals in the roughness box.
21. **#1711, #1641:** the tick on a bent main and the mirrored label after a later move are AutoCAD-only checks.
22. **#1597:** a record-only repair has no rollback file of its own (U still undoes it).
23. **#1419:** no whole-CDREBUILD test; the later relink step not traced.
24. **#1722:** the Settings box is a draft layout; the window is now exactly at 670 px.
25. **#1638:** needs its bug number (BUG-1221 proposed).

## 5. Switches without a Settings page row (I built none; owed to the Codex window lane)

1. **New in C-64 (all ten):** `linking.drawingRecordBeatsPcFile`, `linking.longSectionUpdateKeepsCopies`, `linking.refoundPitKeepsScheduleOverrides`, `linking.renumberScoresJoiningPipe`, `linking.scheduleXrefGroupsKeepDrawing`, `linking.cdMirrorKeepsPipeTextLink`, `linking.xrefCompareChecksOldPosition`, `pits.blocksFromRunningBundleFirst`, `linking.otherUsersFoldersFollowThisPc`, `linking.rebuildKeepsOnlyCarrierIdentity`.
2. **Still without a row from C-61 to C-63:** `linking.keepUnreadableDrawingRecord`, `linking.inlineSplitMovesDecisions`, `detention.twlUsesDrawingUnits`, `pits.skipCurrentPitBlockRedefine`, `linking.propagateWritesSingleIlToItsOwnEnd`, `linking.escKeepsPlacedCalloutLinks`, `linking.scheduleRefreshKeepsTwinAndTrenchText`, `xcivilImport.importReviewRefusesChangedSource`.
3. **Checked** by searching every Settings window, view-model and catalogue file on the head (controls: `ShallowPitDepthMm` found in 4 files, `NetworkUsesPipeMaterial` and `PitScheduleUsesPitFloor` in 5; the one hit for `ScheduleXrefGroupsKeepDrawing` is the Pit Schedule's own read, not a row). With no row, the only way to switch any of these off is the settings file. The Settings window is at its 670 px limit (now including #1722's box).

## 6. PRs left out and why

1. **WAITING (a fix or Tim's word owed; only the desk can promote one):** **#1748 BUG-1138 (data loss: the one wording string in `UnloadedPipeObjectRule.cs` `RefusalLine` is still owed; the important one)**, #1643 BUG-982 (fix not pushed, needs a rebase), #1593 BUG-1021 (rebase), #1588 BUG-994 (rebase), #1657 BUG-917 and #1691 BUG-961 (clash in the Manager window), #1000 UX-SEL-01 (hand merge of three code files), #1620 BUG-990 (Tim's answer, question 8.4), #1195 and #1198 (repair-advice wording needs Tim's word).
2. **Next in line (over the cap of 40, all reviewed):** #1713, #1225 (privacy, read the G fix), #1167 (privacy), #985 (privacy), #1010, #1720 (later commits not re-reviewed), #1718, #1733, #1719, #1633, #1634, #1637, #1672, #1690, #1703, #1243, #1047, #1056, #1314.
3. **Touch Shared, Installer or signing (left out on purpose):** #992 (HOLD to after 9 Nov), #1649 (HOLD), #1652 (HOLD, a new hard block), #1234 and #1235 (REJECT).
4. **HOLD/REJECT and others:** #1706 (REDO), #1716 and its copy #1727 (not in this train), #1721 and the rest of list section 7; every Structural PR.

## 7. What was NOT tested

1. **Anything in AutoCAD or accoreconsole:** no drawing, window or command was opened; the new Settings box and the Pit Schedule windows were not looked at in AutoCAD (I opened one test snapshot picture only).
2. **The Installer suite** (compiled only).
3. Manager net48 tests (none exist); net8 tests; Structural (compiled in the solution build only, not in this train).
4. A base build for the six new net48 reds (they do not exist on the base; mistake 2.1).
5. A live redirect for #1618; a 3.0.73 PC opening a 3.0.74 drawing for #1747 (both by reading only).
6. The Civil bundle I built is not releasable (0-byte transform placeholder); it only supplied CE_SHARED.

## 8. Questions for Tim (work hours; RULES 3.2; none turned into a decision)

1. **(a) Roughness for a pipe with no material (#1664, BUG-868, from C-63): unchanged, still BUILT, NOT ACCEPTED.**
   1. **Context:** network sizing uses each pipe's own material; a pipe with no recorded material is sized with the Settings value for "not recognised", 0.013 (as rough as concrete).
   2. **What I understand:** nothing in C-64 changes this; my new test pins 0.013 again.
   3. **My recommendation: keep 0.013**, because a blank material then errs on the safe side and the row says "Material: Unknown".
   4. **On a job:** a 225 pipe at 1 in 100 that must carry 50 L/s, with no material typed, is proposed one size up (about 45 L/s at 0.013 against 58 L/s as UPVC); typing UPVC brings the 225 back.
2. **(b) Finer storm sweep near the peak (#1656, BUG-904).**
   1. **Context:** CDDESIGN tries a set of storm lengths and takes the one that needs the most storage.
   2. **What I understand:** C-64 adds a note only when the SHORTEST storm (5 minutes) governs. A peak that falls between two tested storms (say between 15 and 20 minutes) can read 2 to 3 per cent short with nothing said. The reviewer's words: "a 25 m3 tank could really need about 25.6 m3."
   3. **My recommendation: yes, build the finer sweep** (test extra storm lengths either side of the worst one), because it removes a silent under-size and costs only a little run time; until then the note ships.
   4. **On a job:** (yes) the 25 m3 tank comes out as about 25.6 m3; (no) it stays 25 m3 and nothing warns, unless the 5-minute storm governs.
3. **(c) Not a question, for your information (#1638):** CDCHECKIGNORE's Ignored list now shows a coded name ("ce-" and letters) instead of the drafter's Windows login, unless the office chooses "login" in Settings > Privacy. Older entries keep the login they already hold. I found no reason to ask.
4. **(d) Heartbeat on a PC with no approved-address record (#1620, BUG-990, WAITING; REVIEW_PILE_B10 item 6, quoted):** "where may the start-up heartbeat go on a PC with no approved-address record? ... What #1620 does now: http is always refused. https is allowed to any address if the PC has no approved-address record, and only to the approved address if it has one. Example: a PC set up by hand with a mistyped `https://ce-cloud.exmaple.com` and no record sends its key there every morning. With the stricter rule, that PC sends nothing until the record is installed. My recommendation: take #1620 as it is for the 9 Nov pilot. It closes the unencrypted-key hole. Then make the record compulsory once every pilot PC has one." #1620 is not in this train.
5. **Already open, from the CX4 review (not new):** "Mark order, natural" is still OFF; turned ON for 9 Nov, P2A sits after P2 everywhere (including after a redesign, #1717).

## 9. Risks (none a blocker)

1. **#1747 version marker 2.3:** every office PC must move to 3.0.74 together. A PC left on 3.0.73 or older warns "saved by a newer version" on every drawing saved by 3.0.74 and its Pit Schedule refuses those drawings as Xrefs. Nothing is lost today (C-64 adds no part to the record).
2. **Visible default changes (all bug fixes, all ON):** CDXREFCOMPARE lists more objects; CDREBUILD keeps IDs it used to replace; CDRENUMBER may number a network differently from before (the main line follows the joining pipe); a PC with a stale all-users CE copy gets the current blocks.
3. **Settings window at its limit:** 670 px tallest tab, with #1722's box; the next row anywhere on the tallest tab will fail the fit test.
4. **Load:** AutoCAD (acad.exe) was running at every step; other sessions' jobs were running (the build lock was taken by another job from 16:03). Today is Saturday (a free window). My solution build took 5 m 48 s.

## 10. Hygiene

1. Every dotnet command: `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Release, the C-63 assembly refs (`_AcadRef48` CERef 24.3.0, `_AcadRefNet8` autocad-2026-ref, `_AcadRefNet10` AutoCAD 2027, `_AcadRef100` autocad-net8-ref), AutoCAD 2027 on PATH, the 0-byte `CE_TRANSFORM_2027.arx` placeholder (untracked, in the ignored bin folder), projects restored one by one first (all 28 exit 0), solution built with `-m:1`, builds with the normal TEMP, test steps with their own TEMP and CE log folder inside it (`C:\fin64\t_<step>`), `VSTEST_CONNECTION_TIMEOUT=900`, Below Normal. The Manager release build and the Civil bundle used their scripts' own refs. Nothing deployed: nothing written under APPDATA.
2. **Build lock** `C:\CE_PLAN\desk_jobs\build.lock`: free at 15:45; my run script took it for each of my first five steps and released it after each; another job held it from 16:03 (my last two test steps ran without it, in my own worktree with my own TEMP). Never deleted by me.
3. **Removed at the end:** worktree `C:\fin64\w` (`git worktree remove --force`, it was clean at `f73755ee`), its local branch `fin/c64`, the whole `C:\fin64` folder (temps and the Civil payload inside the worktree). My scratch scripts and logs under `C:\ce-fin\c64` are removed after this report is pushed. The remote train branch stays. The SUPERSEDED archive stays (9.4 of the answer).
4. **Main checkout:** same untracked items at the end as at the start (`.codex/`, `Modules/Structural.Tests/Models/BracingLengthSettingsTests.cs`, `release-v3-colleagues-TEAMLANE4_LOG.md`, `tmp/`, one odd-named folder): another session's, not mine; left alone.
5. Four words: **built and unit-tested. Not installed. Nobody has opened it in AutoCAD. None Tim-accepted, Codex-accepted or Claude-accepted.**

## Summary

GO at `f73755eec6439ebb9b18667b1c4364890a7f36c4` on `claude/rel-20261024n`. All 40 merged PRs reviewed; the six Group 4 PRs kept; #1706 not taken. One commit by me: a test pinning the ten new bug-fix switches ON and the shallow depth at 300 mm. Solution 0 errors on net48, net8, net10; Civil net10 20,030, 0 failed; Manager 956, 0 failed; net48 focused 17 known plus 6 new reference-only reds; REDO 25 of 25; Settings fit 670 px. Manager release guard 75 files. Shared and Installer untouched; Installer suite not run. Every PC must get 3.0.74 together.
