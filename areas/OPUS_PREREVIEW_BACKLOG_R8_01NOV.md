# Opus pre-review, backlog group r8: Manager start-up and status lines (#1799, #1691, #1233)

Written Monday 2 November 2026 (Melbourne) by an independent read-only Opus reviewer for CE 05, at CE 00's and CE 01's request.
Release tip checked: `claude/rel-20261112a` at ccaf0783 (C-79c finalizer, Civil 3.0.89 / Manager 1.1.89 line), the newest `claude/rel-*` head on GitHub at the time of review.
Heads reviewed: #1799 e1172154, #1691 b1c1ab64, #1233 64a8d952. All three are DRAFT and Manager only. None touches Civil drawing code, Structural, CE_SHARED, UserSettings.cs or any protected file.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the diffs, the carpark entries, the two named reports and the release-line code. I ran read-only `git fetch`, `git merge-tree` and `git log` only.

## FOR TIM

1. **#1799, Manager says "running now, off next start" (BUG-1181): KEEP-WITH-NOTE, Manager area + smoke.** Example: you click Disable on Restart for Civil in CEMANAGER. Today the page goes back to "Healthy" after a refresh, as if nothing changed. With this fix it says "It is running in this AutoCAD, but it will not start next time", and keeps saying it after you close and reopen Manager. It needs a rebase, and its switch should be added to the existing Manager switch-defaults check. It changes default wording, so it must land by C-80 (Mon 9 Nov), the last build that changes defaults.
2. **#1691, stable names on the Manager version fields (BUG-961): KEEP-WITH-NOTE, Manager area + smoke.** You will see nothing change. It gives the four "Running now" and "Starts next time" version boxes a fixed name, so the robot reads the right number. It clashes with a wording change already on the release line: the column heading now says "Starts next time", not "Installed next start". Keep the new heading and add the names.
3. **#1233, CEHEALTH Manager line and second-copy warning (BUG-484): CHANGE-NEEDED, do not merge. Close it as already done.** The release line has had this fix since 9 October (commit 5a344c73). It already prints a CE Manager line, a "Civil and Manager are a matching pair" line (which #1233 does not have) and a "installed in two places" warning. Merging #1233 as well would print two Manager lines and two warnings for the same second copy.
4. **The carpark is out of date for BUG-484.** It still says "found by reading code". It should say: fix on every release line since 9 October, waiting for a robot check in AutoCAD.
5. **Merging order:** #1799 and #1691 do not share any program file. After a rebase, they clash only at the top of the change log (REGRESSION_LOG.md); keep both entries. #1691 also clashes on one window file (the heading wording, item 2).
6. **The spares clash with these two.** #1802 and #1800 change the same Manager status file as #1799. #1232 changes the same Manager window code as #1691. Take only one from each pair per train, or hand-merge them.
7. **Nobody has opened #1799 or #1691 in AutoCAD.** Both are built and unit-tested only, by their authors. Off-screen pictures of the windows exist but are not a live AutoCAD check. All three bugs stay OPEN.
8. **No test touched your real settings.** #1799 and #1691 tests use a throw-away switch file in the temp folder. #1233 tests use temp folders only.

---

## DETAIL

### Group facts

1. **Bases and how far behind.** #1799 sits on `claude/rel-20261025r` (merge-base d8840a09): 2 commits ahead, 384 behind the C-79c tip. #1691 sits on `claude/rel-20261023l` (merge-base 88bd62f7): 4 ahead, 767 behind. #1233 sits on `claude/rel-20261009w` (merge-base 2388c329): 2 ahead, 1,667 behind. None is stacked on another, so there is no stack to check.
2. **Merge-tree against the C-79c tip (ccaf0783):**
   1. #1799: only REGRESSION_LOG.md conflicts. CeOneGlanceStatus.cs, CePluginDescriptor.cs and ManagerSwitchFileTests.cs merge cleanly.
   2. #1691: REGRESSION_LOG.md and Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml conflict. The .xaml.cs merges cleanly.
   3. #1233: REGRESSION_LOG.md and Modules/Manager/Commands/PluginManagerCommands.cs conflict. The code conflict is the whole fix (see #1233 below).
3. **Between the three PRs:** their program files do not overlap (#1799: CeOneGlanceStatus.cs and CePluginDescriptor.cs; #1691: PluginManagerWindow.xaml and .xaml.cs; #1233: PluginManagerCommands.cs, CeHealthLines.cs and CePluginRegistryService.cs). After each is rebased onto the tip, only REGRESSION_LOG.md clashes. A direct merge-tree of #1799 against #1691 also shows the .xaml conflict, but that comes from the base gap (the BUG-917 wording on the newer base), not from the two fixes.
4. **UserSettings.cs:** not touched by any PR in this group. Manager has its own switch file (`manager-switches.json`), read by `CeManagerSwitches`.
5. **Spares:** pairwise merge-tree shows #1799 x #1802 clash on CeOneGlanceStatus.cs and ManagerSwitchFileTests.cs; #1799 x #1800 clash on CeOneGlanceStatus.cs; #1691 x #1232 clash on PluginManagerWindow.xaml.cs and CeAdminStorageService.cs. Part of each clash comes from the different bases. I did not resolve them.

### #1799 BUG-1181: show when Civil is running but off next start

Head e1172154, base `claude/rel-20261025r`. Report: `release-v3-colleagues-CODEX_BRIEFS_26OCT_REPORT.md` (brief cx_bd14, item 6 at line 64; it holds no build detail). The PR body and its REGRESSION_LOG entry hold the evidence.

1. **What the drafter sees, and is it what was asked.**
   1. On CEMANAGER, Module page, after Disable on Restart for a module that is running: the next-step line says "It is running in this AutoCAD, but it will not start next time. Click Enable on Restart if it should." and the health summary says "Running now, off next start" (`Modules/Manager/Services/CePluginDescriptor.cs`, HealthSummary and NextActionText, the new `if (RunningButOffNextStart)` branches).
   2. The one-glance line turns amber with "Running now, off next start" and offers the existing "Switch on at next start" button when the module may change its start-up (`CeOneGlanceStatus.cs`, Describe, new branch placed after the update-waiting and restart-to-use branches and before "Switched off at start-up").
   3. It works from two facts already read from the module's manifest (loaded now, and not set to start), not from the one-off "restart needed" flag. That is why it survives refresh and reopening Manager, which is exactly what the carpark entry (BUG_CARPARK.md line 16463 onwards) asks: "kept across refresh and reopening Manager; separate from an update waiting to install".
   4. An update waiting to install still wins: "Update staged" and "An update is ready..." come first (the reordered `RestartRequired && HasStagedCandidate` lines). With the old switch on, the reorder gives exactly the old text, because the new branch is skipped and the remaining order matches the old one.
   5. Matches the carpark. No decision in `C:\CE_PLAN\decisions` covers this wording, and none is needed: it is status words only.
2. **The switch.**
   1. Key `legacyStatusWhenSwitchedOffAtStart` in `manager-switches.json`. Missing, OFF or a broken file means the new words show. Only a plain `true` brings back the old words. The fix is therefore on by default, which is the normal intent for a fix.
   2. Pinned: `ManagerSwitchFileTests.Bug1181_MissingFileAndMissingKey_DefaultOffMeansTheNewWordsAreOn` checks both the file read (`ReadAll`) and the text read (`Parse("{}")`). Manager has one start-up read, not two (there is no UserSettings.cs), so "both start-up reads" here means those two routes; both are pinned.
   3. OFF restores the old behaviour exactly: `CePluginDescriptor_Bug1181_SwitchSetToOldBehaviour_KeepsTheOldHealthyWording` checks "Healthy", the old next-step line, and the old green "Up to date" one-glance line.
   4. **Note for the builder:** the C-76 finalizer test on the tip, `Modules/Manager.Tests/Services/C76ManagerSwitchDefaultsTests.cs`, lists every earlier Manager switch and checks a new key does not move any of them. #1799 does not add its key there. Add `legacyStatusWhenSwitchedOffAtStart` to that list during the rebase, so the next new switch is also checked against this one.
   5. **Style note, not a blocker:** newer Manager switches on the tip are named for the fix and ship ON (for example `aboutWindowFitsItsRows`, only a plain false turns it off). #1799 uses the older pattern: a "legacy" switch that ships OFF. The drafter gets the same result either way. I would not rename it now.
   6. **Strict reader side effect:** the key is added to the strict list in `ParseObject` (`CeOneGlanceStatus.cs`, the `foreach (string key in new[] {...})` line). So a typo such as `"legacyStatusWhenSwitchedOffAtStart": "true"` (in quotes) turns OFF the other Manager switches in that file too, and logs one line. That is the same rule the existing siblings already follow, and the PR tests it (`Bug1181_ABrokenFileLeavesTheFixActive_AndAllSiblingSwitchesOff`). Acceptable, but say so in the switch's help line if one is ever written.
   7. No engineering value is involved, so nothing belongs in Settings under R-00.
3. **No hard blocks (R-27).** None. Words and one amber colour only. No new window, question or refusal.
4. **Native protection and REDO.** No drawing is read or written, so locked layers, Xrefs, REFEDIT and REDO are not affected. No protected file touched. The switch file is read once per module record (a field set when the record is made, `CePluginDescriptor.cs` near the top); that is a small read each time Manager rescans, no write.
5. **Keep-both merge.** Only REGRESSION_LOG.md conflicts against the tip; keep both entries. The PR's own test helper change (`OneGlanceStatusTests.cs`, `Row(...)` now defaults to `loadOnStartup: true`) is needed: without it every existing "Up to date" test would now be amber. I checked the existing tests that pass `loadOnStartup: false` on purpose; they still describe a switched-off or not-loaded module, so their meaning is unchanged.
6. **Tests.**
   1. The author reports 8 new behaviour checks run against unchanged product code first: 4 failed (got "Healthy", and "Up to date" in green), 4 passed (the ones that check unchanged behaviour). That is a real red-first run, not "red by construction". 22 BUG-1181 checks pass after. Full Manager net10 suite 1,035 total, 1,034 passed, 1 skipped (the same skipped test as before), 0 failed. I did not re-run any of this.
   2. Real %APPDATA%: no. The switch tests assert `CeManagerSwitches.DefaultPath()` equals the sandbox path. The sandbox (`ManagerTestSwitchSandbox`) is a set-up fixture in namespace `CE_SUITE_MANAGER.Tests`, so it covers every Manager test, including the Services tests that make module records and now trigger a switch read. I found no test outside the Manager test project that makes a `CePluginDescriptor`.
   3. Two off-screen pictures (`docs/image/V3_WINDOWS/manager-bug1181-light-module.png` and `-dark-module.png`). I did not open them. They are not a live AutoCAD check.
7. **Not proven, and the scenario.**
   1. Not proven: the real Module page in AutoCAD after a real Disable on Restart and a real reopen; how a module that loads by another route (for example a Structural bundle loaded outside the CE manifest) is shown; the 2024 and 2027 lanes.
   2. Robot (CE 02), on a copy or a spare test login: CEMANAGER, Module, select Civil, click Disable on Restart. Read the next-step line and the health line: they must say it will not start next time, not "Healthy". Press Refresh, read again. Close Manager, run CEMANAGER again, read again. Then click Enable on Restart and confirm the line goes back to the normal words, so the real start-up setting is not left off. Then put `{"legacyStatusWhenSwitchedOffAtStart": true}` in the test login's Manager switch file, restart, repeat once: the old "Healthy" wording must come back.
   3. Codex look: one screenshot of the Module page in Dark and Light with the new sentence, checking it fits without scrolling at 1080p.
8. **Verdict: KEEP-WITH-NOTE.** Notes: rebase onto the C-79 tip; keep both REGRESSION_LOG entries; add the key to `C76ManagerSwitchDefaultsTests`. It changes default wording, so it must be in C-80 or earlier. Train class: Manager area + smoke.

### #1691 BUG-961: distinguish Manager running and installed build fields

Head b1c1ab64, base `claude/rel-20261023l`. Report: `release-v3-colleagues-MAX_BUILD_G_REPORT.md` (line 56: skipped there with "rebase"; no build detail for this PR). The PR body and its REGRESSION_LOG entry hold the evidence.

1. **What the drafter sees.** Nothing. Four version boxes on the CEMANAGER Status page (running version, running build, installed version, installed build) get a fixed automation name such as `Manager.Status.CE_CVL_SUITE.Running.Version`, plus a spoken name for screen readers (`PluginManagerWindow.xaml`, the StatusModuleTemplate, lines 46 to 52 at the PR head). This is what BUG-961 asks for on the Manager side (BUG_CARPARK.md line 13191: "Each test-critical field has a stable name"). The import-list half of BUG-961 was #1527, already on the line, as the PR says.
2. **The switch.** None, and none is needed: these are hidden labels with no visible or drawing effect. No engineering value involved.
3. **No hard blocks.** None.
4. **Native protection, REDO, protected files.** No drawing touched. One code change: the window gains a second, internal constructor that skips hooking the drawing list, for tests only (`PluginManagerWindow.xaml.cs` lines 35 to 50 at the head). The public constructor still always hooks it, so AutoCAD behaviour is unchanged. No protected file.
5. **Keep-both merge.**
   1. Against the tip, PluginManagerWindow.xaml conflicts on the "Installed next start" column. The tip changed that heading to "Starts next time" (commit 4d4b9b9c, BUG-917 plain wording). Resolve: keep the tip's heading text and add the PR's two attribute pairs to the two lines under it. This is the clash the C-64 and C-65 finalizers noted.
   2. **Suggested while resolving:** change the spoken names "installed next start version" and "installed next start build" to "starts next time version" and "starts next time build", so a screen reader matches the heading. The test checks those spoken names, so change the test's `spoken` strings too. The automation IDs (`.Installed.Version`, `.Installed.Build`) stay as they are: the robot uses those.
   3. REGRESSION_LOG.md: keep both.
6. **Tests.**
   1. `Bug961ManagerFieldTests` builds the real compiled window off-screen, fills three modules with deliberately different running and installed numbers, and checks each of the twelve IDs is found exactly once, holds the right number and has the right spoken name. The author reports it failed before the change (0 matches instead of 1) and passed after; full Manager 918 total, 917 passed, 1 skipped, 0 failed. I did not re-run.
   2. Real %APPDATA%: I checked what the window's constructor does on the tip. The theme read only looks at an in-memory Civil settings session, which is empty in the test, and the Settings page set-up only writes placeholder words. I found no file read in the constructor. The picture goes to the test's work folder unless `CE_UPDATE_DOC_SCREENSHOTS=1` is set. I could not prove that every page the window builds at start (Project Sheets, Help, Survey Intake) never reads a file, but I found none that does.
7. **Not proven, and the scenario.**
   1. Not proven: that UI Automation finds these IDs in the live window inside AutoCAD (the Status page is filled by the window's Loaded step, which the test never runs).
   2. Robot (CE 02): CEMANAGER, Status. For CE_CVL_SUITE, CE_STRUC_SUITE and CE_SUITE_MANAGER, find `Manager.Status.<id>.Running.Version`, `.Running.Build`, `.Installed.Version`, `.Installed.Build`. Each must find exactly one box, and its value must match what the card shows under "Running now" and "Starts next time". Dark and Light.
   3. Codex look: not needed for the drafter (nothing visible changes); one Status screenshot is enough to confirm nothing moved.
8. **Verdict: KEEP-WITH-NOTE.** Notes: rebase onto the C-79 tip; hand-resolve the heading clash keeping "Starts next time"; align the spoken names. Train class: Manager area + smoke.

### #1233 BUG-484: CEHEALTH Manager line and second-copy warning

Head 64a8d952, base `claude/rel-20261009w`. Report: none found in `C:\CE_PLAN\areas` (several CODEX_BUILD and audit files mention BUG-484, none is this PR's report). Judged from the diff, the PR body and the carpark entry (BUG_CARPARK.md line 9972).

1. **What the drafter would see, and is it already there.**
   1. The PR adds to CEHEALTH: "[OK] CE Manager v1.1.xx", a "[NOTE]" when the Manager folder in the plugins folders is missing or a different version from the one running, and one "[WARN] ... a second copy ... is installed at ..." per extra copy (`Modules/Manager/Services/CeHealthLines.cs`, new; `CePluginRegistryService.FindSecondCopies`; `PluginManagerCommands.cs` RunHealthCheck).
   2. **The release line already does this, and more.** Commit 5a344c73 "HUNT-M-09: CEHEALTH checks Manager, the Civil/Manager pair and duplicate installs" (9 October 2026) is in every release line I checked (`rel-20261023l`, `rel-20261025r`, `rel-20261026z`, `rel-20261102a`, so in installed Civil 3.0.88 if that is what is installed). On the C-79c tip, `PluginManagerCommands.cs` RunHealthCheck prints `CeHealthChecks.ManagerLine`, `CeHealthChecks.PairLine` (compares the shared CE file in Civil and Manager, "CE Civil and CE Manager are a matching pair") and `CeHealthChecks.DuplicateLines` ("installed in two places") (`Modules/Manager/Services/CeHealthChecks.cs`). The carpark asked for exactly those three lines. #1233 itself says it does not do the pair line.
   3. If merged as well, CEHEALTH would print two CE Manager lines and two warnings for one second copy, and count the second copy as two issues.
2. **The switch.** None. The tip's fix has none either; both only print. Not worth adding one now.
3. **No hard blocks.** None; it only prints.
4. **Native protection.** Reads folders only; nothing removed. No drawing touched. No protected file.
5. **Merge.** Conflicts against the tip in `PluginManagerCommands.cs` exactly where the two fixes sit side by side (tip lines 261 to 288 of the merged file). Resolving by "keep both" is wrong here: it duplicates the lines. Resolving by keeping the tip discards the whole PR.
6. **Tests.** `Bug484HealthCheckTests` (8 checks, temp folders only, no %APPDATA%). The PR says "red by construction (the types did not exist; the red run itself was not done)", so there is no real red-first run.
7. **Only two things #1233 has that the tip lacks, both minor:**
   1. It finds a second copy by the tool name inside the folder's PackageContents.xml, so it would catch a renamed copy such as `CE_CVL_SUITE_old.bundle`. The tip groups by folder name, so it misses that case.
   2. The "[NOTE]" that the running Manager differs from the one in the plugins folder (mainly a developer case).
   Neither is in the carpark's request. If Tim wants the renamed-copy case, it is a new small item on top of `CeHealthChecks.DuplicateLines`, not this PR.
8. **Not proven, and the scenario for the fix already on the line.** Robot (CE 02): run CEHEALTH on a test login: expect one "[OK] CE Manager v..." line and one "matching pair" line. Copy the Civil bundle folder into the second plugins folder (for example from ProgramData into the user's AppData plugins folder), run CEHEALTH: one "installed in two places" warning, and the final line counts it as an issue. Remove the copy afterwards.
9. **Verdict: CHANGE-NEEDED.** Do not merge. Close #1233 as superseded by 5a344c73 (HUNT-M-09). Update BUG-484 in the carpark to "fix on the release line since 9 Oct (5a344c73); not yet checked in AutoCAD", and give it to the robot with the scenario above. Train class: none (nothing to carry).

### What I could not verify

1. I did not open the PNG pictures in #1799 and #1691.
2. I did not build or run any test; every pass or fail count above is the author's.
3. I did not check whether the installed bundle on Tim's PC is 3.0.88 or later; I only checked that 5a344c73 is inside `rel-20261102a`.
4. The spare-PR clashes (#1802, #1800, #1232) are listed, not resolved.
