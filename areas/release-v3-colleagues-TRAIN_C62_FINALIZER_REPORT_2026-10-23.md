# Train C-62 finalizer report (Civil + Manager), Fri 23 Oct 2026 (real clock 15:30 to about 16:10 Melbourne)

Opus 5.5 (claude-opus-5-5), Team, headless, desk plan/03. Inputs: the C-62 assembly report, REVIEW_FIXWAVE2_A and B (23 Oct), the C-62 fix-round report, `BUG_CARPARK.md` entries BUG-874, BUG-877, BUG-963, BUG-965, `decisions\2026-10-20_TIM_ANSWERS.md` (no answer there touches these four switches). Method and shape: the C-61 finalizer report. Two Opus read-only helpers checked REVIEW_FIXWAVE2_A and B item by item against the merged code; I did the six full reads, the defaults, the builds and the tests myself.

Built and unit-tested only. Not installed. Nobody has opened it in AutoCAD. No PR closed, no branch deleted, no bug marked FIXED, no version bumped, `DESK_LOG.md` not edited.

## ANSWER FIRST

1. **GO at `ea752acf63877f6ea83083de835bc29a0f6b814f`.**
2. **Branch and final head:** `claude/rel-20261023m` @ `ea752acf63877f6ea83083de835bc29a0f6b814f` (normal fast-forward push from `dd13cf580b3ef68029a028e48ebfe7775f8823c3`; leak scan clean, 36 terms). The start head matched the assembly report by `git ls-remote` at 15:30 and again just before the push. Base: installed C-61 `88bd62f7` (Civil 3.0.71 / Manager 1.1.71). All 23 PRs merged, none left out; every merge's second parent equals the fixed head (both helpers checked one by one).
3. **What I changed: one commit, `ea752acf`, test only.** New `C62NewSwitchDefaultsTests` (copy of the C-61 one): an older settings file (empty, and a C-61-shaped one) loads the four new switches ON through the same two reads AutoCAD uses at start-up (`DeserializeSettings` and the tolerant start-up read), keeps the three C-61 switches ON and `checks.allowIgnoreFinding` OFF, and a typed OFF of each new switch is kept by both reads. Plus my REGRESSION_LOG entry at the top. No product code changed, no switch default changed.
4. **Settings defaults, verdict on each (checked in the merged code, every read site, the Bug Carpark and Tim's answers; not the PR text):**
   1. **`linking.propagateWritesSingleIlToItsOwnEnd` (#1567, BUG-963): ON, KEPT ON.** The old behaviour is the bug: with the upstream IL hidden, CDPROPAGATE 9.50 at the downstream pit wrote "IL 9.60" beside it. ON writes each level only into the text of its own end. The only read site falls back to ON. Tim sees a change only on pipes with one IL text left.
   2. **`linking.escKeepsPlacedCalloutLinks` (#1562, BUG-874): ON, KEPT ON.** The old behaviour is the bug: Esc after a placed CD pipe threw away the callout's link, so erasing the pipe left its label behind. Read site falls back to ON. Tim sees: after Esc, erasing or moving that pipe now takes its callout along.
   3. **`linking.scheduleRefreshKeepsTwinAndTrenchText` (#1570, BUG-965): ON, KEPT ON.** The old behaviour is the bug: Refresh turned "2/375" into "375" and a trench grate "3000" into "300 x 300". Both read sites fall back to ON. Tim sees: Refresh keeps what the Pit Schedule window shows.
   4. **`xcivilImport.importReviewRefusesChangedSource` (#1558, BUG-877): ON, KEPT ON.** The old behaviour is the bug: choosing another file and clicking Read source drew the FIRST file. ON stops with nothing drawn and says to run the command again. Both read sites fall back to ON. Tim sees the refusal only if he swaps files on the review page.
   5. **C-61 switches unchanged:** `detention.twlUsesDrawingUnits` ON, `pits.skipCurrentPitBlockRedefine` ON, `linking.pitScheduleUsesPitFloor` ON, `checks.allowIgnoreFinding` OFF (all pinned again by my test).
   6. **Nothing else added:** the assembler's whole-diff search found no other new settings key (`orificeHeadM` and `detentionRequired` from #1623 are saved design data, not settings). Manager adds no switch.
   7. **No new-behaviour-ON default whose old behaviour is not the bug.** Nothing turned OFF.
5. **Switches without a Settings page row (I built none; owed to the Codex window lane):** the four above plus the two from C-61 (`detention.twlUsesDrawingUnits`, `pits.skipCurrentPitBlockRedefine`). Checked by searching the Settings window files on the final head (control: `pitScheduleUsesPitFloor` is found in five window files). With no row, the only way to switch any of these off is the settings file.
6. **Manager: a real Manager release.**
   1. **What changed, in plain words:** CEHEALTH now prints a WARN line ("installed, but not loaded in this AutoCAD session ... Restart AutoCAD") when Civil (or another CE tool) is installed but not running, instead of an OK line (#1594). The CE Tools "Updates & Rollback" button opens the Manager window on its Updates page for a colleague who is not a CE administrator, instead of the administrator-only refusal; no administrator right is granted (#1595). Every Manager window button and every CE Blocks palette tile now sends two cancels first when a command is running, so the command name is never typed into TEXT or a point prompt; with nothing running the text is as before; same text as the ribbon (#1613). "Get update ready" now sets a damaged prepared copy aside (moved to `.damaged-staging` inside the staging folder, never deleted) and puts a freshly verified copy in its place, instead of failing (#1632).
   2. **Official release build: PASSED, guard at exactly 75 files** ("Complete 75-file, three-lane release candidate verified", 0 warnings, 0 errors, 15:51:48 to 15:52:12). Command: exactly the one in `C:\ce_rc_scratch\p93_scripts\payload93_mgr_build.ps1` (read, not edited), copied into my scratch script with the worktree pointed at mine and TEMP inside `C:\ce-fin\c62`. The approved CE_SHARED root came from a Civil bundle I built in the same worktree with the unchanged `Installer/build_installer.ps1` (EXIT 0). Guard constant unchanged at 75: the only new Manager product file (`CeManagerCommandSender.cs`) is compiled source, `CE_SUITE_MANAGER.csproj` is unchanged, so nothing needed fixing. CE_SHARED SHA-256 this build: Legacy `9EE4E40A...`, Net8 `8D2E0902...`, Modern `53EB9623...`; the Manager build checks its three lanes against these.
   3. **Said plainly about that Civil bundle:** it carried the 0-byte transform placeholder (`CE_TRANSFORM_2027.arx`, the installer script does not build that module) and is NOT a releasable Civil bundle; it only supplied CE_SHARED. The payload builder must use its real transform module as before.
7. **Installer safety:** the train cannot affect the signed-update gate (OfficialReleaseGate) or SafeBundleInstaller. By diff from `88bd62f7`: 0 files under `Shared/`, `Installer/`, `Modules/Manager/Installer`, `CE.Host`, `Installer.Tests`; the file that uses the gate in Manager (`CeApprovedReleaseService.cs`) is unchanged. #1632 changes only what happens AFTER a new prepared copy has passed the existing signed-approval check (the damaged copy already there is moved aside instead of refusing); if the source does not match the approval that point is never reached. **Commands:** none added or removed (`command-registry.json`, `ce-tool-register.json`, every `PackageContents.xml`, both product csproj files unchanged); CrossModuleGuard 6 of 6.
8. **Tests (Release, worktree `C:\ce-fin\c62\w`, my commit included):**
   1. **Whole solution: 0 errors** (891 warnings), net48, net8.0-windows and net10.0-windows all built (15:32 to 15:34). So the net48 compile of the merged train is confirmed by my own build, not copied.
   2. **Civil net10 full: 19,548 total, 19,526 passed, 22 skipped, 0 failed** (assembler's 19,545 plus my 3), run twice: on the commit's files at 15:34 and again on the final commit at 15:56 (same result). The PDF load test passed both times.
   3. **Named tests (net10): 37 of 37 passed.** Settings fit `EveryTab_FitsTheScreen_AtOneFixedHeight`: tallest tab 670 px in all five cases; at 1920x1080 150% the window is 1100 x 672 in 688 px available. `NewSettingsKeys_NeedADocumentedDefault`: passed. `RedoSafeCallGraphTests` after #1562: 25 of 25. `C61NewSwitchDefaultsTests` 3 of 3, `C62NewSwitchDefaultsTests` 3 of 3.
   4. **Manager net10 full: 932 total, 931 passed, 1 skipped, 0 failed.** **Manager net48 build: 0 errors** (in the solution build and again in the release build).
   5. **Civil net48 focused (Settings, SettingsFit, RedoSafe, CommandOutcomeLine, KeywordPromptBracketTag, CrossModuleGuard, CheckIgnore, DoubleClick, PickHandlerProbe, Raingarden, PitSchedule, Twl, Import, Propagate, C61/C62 switch tests): 1,691 total, 1,623 passed, 51 skipped, 17 failed.** All 17 are `InvalidProgramException` from the reference-only AutoCAD files on this PC. **I built the C-61 base `88bd62f7` (own worktree) and ran the same 17 there: 17 of 17 fail the same way.** Not from this train.
9. **What Tim will see in AutoCAD, plain words, per PR:**
   1. **CD then Esc (#1562, BUG-874):** place a pipe with a callout, Esc at the next pipe, erase the pipe: the callout goes with it (before, the label stayed behind).
   2. **CDRG raingarden (#1645):** a placed raingarden now stays; before, every CDRG was rolled back with "appearance changed during placement". Outline and hatch are ByLayer.
   3. **CDSPOON (#1552, BUG-966):** a traced spoon drain now stays (before, nothing was left and the command said it failed readback).
   4. **Pit Schedule typed Depth (#1612, BUG-1011):** with Auto-calculate depth OFF, typing 1.15 over cover 42.350 sets the outlet IL cell to 41.20 and the status reads "Outlet invert changes from 41.25 m to 41.20 m ... Your typed value is waiting"; the pit changes only at Stop overriding; one U takes it back.
   5. **CDRUNSOLVE (#1617, BUG-999):** with no design flow it says "Nothing was changed. CE could not size these pipes because none of them has a design flow yet." instead of "every invert already matches".
   6. **CDPROPAGATE (#1567, BUG-963):** a pipe with one IL text left gets its own end's level.
   7. **Pit Schedule Refresh (#1570, BUG-965):** "2/375", "3000" and a blank pump pit stay after Refresh.
   8. **Imports (#1558, #1557, #1586):** swapping the file on the review page stops with nothing drawn (BUG-877); Replace keeps an old pit whose replacement cannot be drawn and says so (BUG-876); a level named for pipe A no longer lands on pipe B (BUG-878).
   9. **CDTWL (#1556, BUG-970):** two schedule sets that both use P1/P2 stay apart; typing 2 picks row 2 when marks repeat.
   10. **Blue Factor report (#1553, BUG-967):** garden and lawn no longer counted as roof and paved; no contradicting "not in any catchment" note.
   11. **CDRENUMBER (#1591, BUG-968):** a looped pipe record no longer closes AutoCAD; it says so.
   12. **CDSYNC (#1611, BUG-987):** each pit keeps its own lid, remarks and schedule tick after a pit swap.
   13. **CDDESIGN (#1623, BUG-1004):** a changed orifice head or detention answer is listed, no more "Nothing has changed".
   14. **CDCALC (#1625, BUG-1019):** pipe and lid levels at or below RL 0.00 are used, not treated as blank.
   15. **CDNEWDWG (#1619, BUG-969):** uses the job record of the folder chosen.
   16. **Inspector (#1609, BUG-892):** clicking a problem count that reads zero no longer costs the next U or REDO.
   17. **Settings search (#1610, BUG-957):** Enter in the search box never saves and closes Settings.
   18. **Manager (#1594, #1595, #1613, #1632):** item 6.1 above.
10. **Do not mark FIXED (each needs a robot PASS plus a Codex PASS in AutoCAD, on copies):**
    1. **BUG-1017 (#1613):** run TEXT, at the text prompt click a Manager button (CDREPAIR) and a CE Blocks tile: the TEXT ends, the command runs, no "CDREPAIR" text in the drawing; with nothing running the button behaves as before.
    2. **BUG-947 (#1632):** damage a prepared copy (delete one file), Get update ready: it succeeds, the damaged copy sits under `.damaged-staging`, installed files untouched.
    3. **BUG-957 (#1610):** CDS, type in search, Enter: Settings stays open, nothing saved.
    4. **BUG-892 (#1609):** an Inspector count of 0, click it, then U and REDO still work as before.
    5. **BUG-969 (#1619)**, **BUG-1019 (#1625)**, **BUG-1004 (#1623)**, **BUG-987 (#1611)**, **BUG-999 (#1617)**: each its REGRESSION_LOG checklist.
    6. **BUG-1011 (#1612):** pit with no recorded floor (typed 1.15 gives 41.20 and the two-part status line; Stop overriding writes once; one U undoes) and a pit with a floor (floor sentence, nothing changes).
    7. **BUG-966 (#1552)** CDSPOON and **the CDRG raingarden fault (#1645, still needs a BUG number from the desk)**: one real placement each; LIST shows Color BYLAYER on outline and hatch; one U removes both.
    8. **BUG-967 (#1553)**, **BUG-878 (#1586)**, **BUG-968 (#1591)**, **BUG-876 (#1557)**, **BUG-877 (#1558**, and check whether "aborted at pre-flight gate" prints twice), **BUG-965 (#1570)**, **BUG-963 (#1567)**, **BUG-970 (#1556)**.
    9. **BUG-874 (#1562):** CD a pipe with a callout, Esc, ERASE the pipe (callout goes), U (both back together, one U), REDO (works); switch OFF before AutoCAD starts gives the old behaviour.
    10. **BUG-946 (#1594):** CEHEALTH with Civil installed but not loaded shows the WARN line. **BUG-948 (#1595):** as a non-administrator, CE Tools > Updates & Rollback opens the Manager window on the Updates tab.
11. **LOW items left for the next round (none a blocker under R-27; what Tim loses if they ship as is):**
    1. **#1557:** a code comment sits on the wrong method (nothing visible). Carpark entry owed: imported PIPES are still erased before the replacement is checked (with a locked pipe layer, Replace can lose an old imported pipe).
    2. **#1562:** the source pin that the failed-command handler never passes the cancel flag reads only 500 characters (a future edit could slip past; an older whole-method test still guards it). Nothing today.
    3. **#1567:** the summary says "most often a locked layer" when the real cause is an IL text with no recorded end (Tim may hunt for a locked layer that is not there); nearer-pit second clue not added.
    4. **#1610:** no source pin that Enter is swallowed (a later edit could bring back "Enter saves and closes" with no test failing).
    5. **#1632:** no log line when a damaged copy is set aside (support cannot see it happened without looking in the folder).
    6. **Settings rows:** the six switches in item 5 have no row (only the settings file switches them off).
    7. **#1613:** Load Now has no tooltip saying it cancels a running command; the installer's QUIT path still sends straight (reachable only on an excluded migration path). The C-61 test `PaletteTile_UsesTheSameCancelFirstPathAsRibbon` is still `[Ignore]` with a now-wrong reason ("still sends CEBLOCKINSERT directly"); the tile is fixed and covered by #1613's `NoManagerButtonSendsItsCommandStraightToAutoCad`; re-pin or retire that ignored test (it is Manager's 1 skipped test).
    8. **#1609:** a stale non-zero Inspector count still opens a normal transaction (can cost one U/REDO in a rare case); duplicate "No ... found." text.
    9. **#1619:** job record re-read on every keystroke in the folder box (possible stutter on OneDrive online-only folders).
    10. **#1625:** with no inverts recorded, storage and baffle figures still come from a 0.00 placeholder instead of saying "no water level".
    11. **#1623:** detention answer is yes/no only ("never answered" saved as "no"); "could not be read now" wording for a blank head.
    12. **#1611:** dead old copy of the pit snapshot code; the 200-unit "same pit" distance is Tim's call (Monday question: make it a Setting, default 200 mm).
    13. **#1617:** the suggestion ledger records "plan created" for a run that failed; Monday question on sizing from saved flows.
    14. **#1556:** no note when a pipe is left out because it belongs to the other schedule set.
    15. **#1552, #1594, #1595:** proof only in AutoCAD (checklists above); fold the three Manager "open the window on a page" copies into one at next touch. **#1591:** F-202 (shorter branch numbering) still open.
    16. **Process gap:** REVIEW_FIXWAVE2_B asked for #1632's own Opus review before taking it; none is on file. I read it in full here (section 1.2) and found no fault.
12. **Risks (none a blocker):**
    1. **#1562 one-Undo claim** rests on the cancelled-command callback being inside CD's Undo step, the same moment the normal command end already writes; only a Codex U/REDO run proves it.
    2. **#1594** also warns for a CE tool that a user has deliberately set not to load (a correct but possibly surprising WARN).
    3. **AutoCAD was running on Tim's PC** at every build and test step (1 acad.exe at each of 8 steps and at 16:01). Builds ran Below Normal in my own worktree and TEMP, partly in Tim's 3:00 to 5:30 pm window.
    4. **Tim's settings files: unchanged** (hash, size and on-disk time identical at 15:31 and 16:01): `TIM_CE_CADTOOLS\CD_Settings.json` acd64e7 (15,270 bytes, 11 Mar), `CS_Settings.json` 622a246 (351,713 bytes, 31 Mar), `CE_CVL_SUITE\settings.json` efe307c (672 bytes, 16 Sep), `CE_STRUC_SUITE\CS_Settings.json` 2972ce7 (35,259 bytes, 22 Oct 18:54).

## 1. Review of every merged PR (merge order)

### 1.1 The twenty-two Opus-reviewed PRs: fix round checked in the merged code

All second parents equal the fixed heads (helpers checked each). #1555, #1576 (HOLD), #1621 (REJECT), #1630, #1624, #1622 (duplicates) are not in the train: their commits are not ancestors and their switches (`keepUnreadableDrawingRecord`, `newDrawingReadsChosenFolderRecord`, `belowZeroLevelsAreReal`) appear nowhere.

1. **#1613 BUG-1017:** MERGE, 2 LOWs open (11.7). Read in full (1.2).
2. **#1632 BUG-947:** both review MEDIUMs closed in code: damaged copy moved to `<staging root>\.damaged-staging\<plugin>\<version>\<id>`; a CHANGED file (not just a missing one) is also replaced; tests for changed, missing, set-aside-never-read, intact-reused, changed-source-still-fails. LOW log line open (11.5). Read in full (1.2).
3. **#1610 BUG-957:** MERGE; code right (`case SearchKeyAction.SwallowEnter: e.Handled = true;`), pin open (11.4).
4. **#1609 BUG-892:** MERGE; 2 LOWs open (11.8).
5. **#1619 BUG-969:** duplicate #1630 kept out (closed); keystroke LOW open (11.9).
6. **#1625 BUG-1019:** duplicate #1622 kept out (closed); 2 LOWs open (11.10).
7. **#1623 BUG-1004:** duplicate #1624 kept out (fields inside `designInputs`); 2 LOWs open (11.11).
8. **#1611 BUG-987:** MERGE, no fix needed; distance is Tim's call; LOWs open (11.12).
9. **#1617 BUG-999:** MEDIUM closed (plain words, no INVALID_FLOW, no doubled command name, old "Plan could not be built -" lead-in gone; 5 reason cases tested). LOW ledger open (11.13). Read in full (1.2).
10. **#1612 BUG-1011:** both MEDIUMs closed (status line set after the invert; a row already waiting still solves). Read in full (1.2).
11. **#1552 BUG-966:** spoon check uses `SpoonColourReadbackAccepted` at both readbacks; the review's CDRG MEDIUM is closed by #1645.
12. **#1553 BUG-967:** MEDIUM closed (listed area = impervious + garden + lawn); both LOWs closed ("No roof or paved catchments were found..."; "Other" note kept until Tim decides).
13. **#1586 BUG-878:** consistent with BUG-605; nothing asked.
14. **#1591 BUG-968:** loop message in; F-202 open.
15. **#1557 BUG-876:** re-run wording already present; misplaced summary and pipes carpark open (11.1).
16. **#1558 BUG-877:** "Default: on." closed; row and possible doubled line open.
17. **#1570 BUG-965:** "Default: on." closed; row open.
18. **#1567 BUG-963:** "Default: on." closed; reason wording open (11.3).
19. **#1562 BUG-874:** "Default: on." closed; the AutoCAD proof cannot close in code (10.9); 500-character pin open (11.2). The REDO baseline change is exactly #1562's own +10 lines (five under `OnCommandCancelled`, five under `OnCommandFailed`); nothing re-pinned.
20. **#1556 BUG-970:** MEDIUM closed (`PlainNumberMarksTwoSetsShare_RowTwoCanStillBePicked`); note LOW open (11.14).
21. **#1594 BUG-946**, **#1595 BUG-948:** closed as reviewed; end-to-end proof owed in AutoCAD; helper fold deferred.

### 1.2 Read in full, adversarially

1. **#1562 (BUG-874, Esc keeps the callout linked): GO.** What I checked: only the CommandCancelled handler passes `cancelled: true`; CommandFailed still discards (old behaviour). The write runs only when all hold: switch ON, cancelled, a CE editor (CD) was running (`ResumeOnNextCommandEnd`), at least one queued link, the ending command is not U / UNDO / REDO / MREDO, and REDO is not available in the drawing (`RedoHistoryCommandEndRule.MayWriteAtCommandEnd`). That is stricter than the normal command end (which checks only the history name). It uses the same `ProcessDeferredAttachmentRegistrations` the normal end uses at the same moment of the command, skips erased or missing objects, and the queue is cleared after either way, so Idle never writes it a second time. Switch OFF: the rule returns false and the queue is dropped exactly as before. No REDO is lost: Esc after U is a history command or inside the REDO window, both refused. `RedoSafeCallGraphTests` 25 of 25 on the final head.
2. **#1645 (CDRG readback accepts ByLayer, never reviewed): GO.** The writer `AppendRaingardenGeometry` sets `ColorIndex = ByLayerColourIndex` (256) on the outline and on the hatch. `RequireExactAuthoredAppearance` now accepts 256 only; colour 3, 113 or 257 and a non-SOLID pattern still throw (tested). The atomic rollback and the one-U undo are untouched: only the colour comparison changed, inside the same `verify` step of the same placement transaction. It agrees with #1552: CDSPOON uses an identical `== 256` helper. The rest of the readback (layer, closed outline, vertices, association, loop) is unchanged.
3. **#1612 (typed Depth reaches the pit): GO.** The decision to solve is taken before the Depth cell is tracked, so the row is no longer made an override first. Solving sets the outlet-invert CELL; that re-enters the handler as an outlet-invert edit, which makes the row "waiting", and the plan-sync gate (`!row.IsLinkedOverride`) then skips any write to the pit. So nothing is written to the drawing before the user's answer. Depth is not tracked, so Stop overriding pushes the invert once through the existing path and does not blank the depth. One U: the existing Stop overriding transaction, unchanged. A pit with a recorded floor still refuses with the floor sentence.
4. **#1617 (CDRUNSOLVE plain words): GO.** The new error is added only when at least one pipe could not be solved AND no real change is in the plan; the command then returns before anything is applied (existing `Errors > 0 && EffectiveChanges == 0` return). A partly solved run applies as before. No code words reach the command line.
5. **#1613 (Manager cancels a running command first): GO.** One sender: two cancels (`\u0003\u0003`) only when `CommandInProgress` is not empty, then the command and Enter; identical to the ribbon's text (tested). Every Manager window button, the Help and Settings pages, the plugin NETLOAD and the CE Blocks tile use it; a source test fails if any of those five files calls `SendStringToExecute(` directly. The tile's old trailing space became Enter (both end the command name).
6. **#1632 (damaged prepared copy): GO.** No file Tim needs is deleted: the damaged folder is MOVED inside the staging root, and only if it is inside it (else it refuses and touches nothing). The update scans read only `<staging root>\<plugin>`, never `.damaged-staging`. If the move of the fresh copy then failed, only the fresh preparation folder is removed and the damaged copy stays set aside; the result says Failed. Installed bundles are never touched. The signed-approval check before this point is unchanged.

### 1.3 Merge conflicts re-read

1. **REGRESSION_LOG.md:** every added line of all 23 PRs is present on the head (checked line by line against each PR's own diff from its merge-base: 0 missing in every one); no line of the C-61 log removed; 0 conflict markers; order newest first (#1645 down to #1613, then C-61); every heading has a blank line before it. My entry is now on top.
2. **`UserSettings.cs` `LinkingSettings`:** #1567 and #1562 side by side at the top of the class, #1570 further down: three keys, three `= true` defaults, three documentation lines each ending "Default: on." Nothing lost. #1558's key is in `XcivilImportSettings`.
3. **Files touched by more than one PR:** `UserSettings.cs` (#1558, #1570, #1567, #1562; above), `PluginManagerWindow.xaml.cs` (#1613 sender line and #1595 `ShowUpdatesPage`, both present), `PluginManagerCommands.cs` (#1595 Updates branch and #1594 NotLoaded WARN, both present). Build and tests green.
4. **`git diff --stat 88bd62f7..HEAD -- Shared Installer`: empty.** CE_SHARED unchanged, so Civil and Manager carry the same CE_SHARED.

## 2. Hygiene

1. Every dotnet command: `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Release, the C-62 assembly refs (`_AcadRef48` CERef 24.3.0, `_AcadRefNet8`, `_AcadRefNet10`, `_AcadRef100`), AutoCAD 2027 on PATH, the 0-byte `CE_TRANSFORM_2027.arx` placeholder (untracked), my own TEMP and CE log folder per step (inside TEMP), Below Normal, foreground. The Manager release build used the payload script's own refs.
2. **Mistake, owned (time only):** my first Manager net10 run failed 5 tests because my log-folder override used forward slashes, so the hygiene test did not see it as inside TEMP; with Windows-style paths all passed. About 1 minute. My first Civil-bundle run stopped because I had removed the arx placeholder (the installer script expects that module already built); about 6 minutes, nothing archived.
3. **Build lock** `C:\CE_PLAN\desk_jobs\build.lock`: free each time; taken and released around each of my steps; not present at the end.
4. **The installer script writes a release archive** to `C:\Lisp Files\SUPERSEDED\CE_CVL_SUITE\` (outside my area): it made `20261023_155137_v2026.1023.1550` (389 MB) from my placeholder bundle; I deleted it; that folder is back to its earlier listing (29 entries, compared). Installed Civil and Manager DLLs still carry their 23 Oct 09:04 to 09:08 times: nothing deployed.
5. Worktrees `C:\ce-fin\c62\w` and the base worktree `C:\ce-fin\c62\b` removed (`git worktree remove --force`), local branch deleted, `C:\ce-fin\c62` deleted with my scripts and logs. The main checkout's status is as it was at the start.
6. Not run: AutoCAD, accoreconsole, Codex, Structural, Installer.Tests, Manager net48 tests, net8 tests. No version bumped, nothing installed, nothing else merged, no Structural PR.
7. Four words: **built and unit-tested. Not installed. Nobody has opened it in AutoCAD. None Tim-accepted or Codex-accepted.**

## Summary

GO at `ea752acf63877f6ea83083de835bc29a0f6b814f` on `claude/rel-20261023m`. All 23 PRs reviewed; the six full reads (#1562, #1645, #1612, #1617, #1613, #1632) are sound. One commit by me: a real-loader test pinning the four new switches ON (each guards a bug fix). Solution 0 errors on net48 and net10; Civil net10 19,548, 0 failed; Manager 932, 0 failed; net48 focused 17 reference-only reds, identical on the base; Manager release guard 75 files. Shared and Installer untouched. Not installed, not seen in AutoCAD.
