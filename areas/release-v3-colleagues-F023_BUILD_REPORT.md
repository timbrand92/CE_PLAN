# F-023 build report: colleague starting settings (CE 01 Build, Thu 29 Oct 2026, about 14:15 Melbourne)

**DRAFT. WAITING FOR TIM ON QUESTIONS ITEM 40.** Built and unit-tested only. Nobody has started CE on a clean profile. Not installed, not Tim-accepted.

## ANSWER FIRST

1. **PR:** #1844, DRAFT, against `claude/rel-20261026z`. Branch `fb/f023-colleague-defaults`, commit `7d59574f`.
2. **What a drafter will see differently:** on a PC with NO `CD_Settings.json` (a fresh login), CE starts with Tim's choices instead of the built-in ones. Nothing changes on a PC that already has a settings file, Tim's included.
   1. The one-piece pipe object is On (`options.pipeObjectUpgrade` On).
   2. Snaps while picking a pipe route are 1151 (no Extension snap); snaps while placing pipe text are 0 (none).
   3. Dark window colour.
   4. Rising main destination starts as WT; pit lid starts as "Class A Grate"; the three tank-to-plan captions are already remembered.
3. **Tim's answer to item 40 has arrived** ("defualt on for everyone", decisions item 63). That says the pipe object should be On by default for every login. This PR covers only the fresh-profile route (the shipped file says On). Changing the built-in default itself, so that an existing colleague file saying Automatic also flips, is NOT in this PR: it is a separate change, and item 63 also asks the desk to say whether any existing setting is edited.
4. **My mistakes first:**
   1. My first wait script called `powershell` and `dotnet` from the Bash tool, where neither is on the path. It looped quietly on an empty count for about 13 minutes before I saw it. Cost: about 13 minutes.
   2. My first focused test run failed on a test of my own: I had assumed the strict start-up read restores a settings group written as null. It does not (no group is). I changed the test, and added one that checks the tolerant read, which is the real start-up read.
   3. The "documented default" guard test caught that my new group lacked "Default:" text. Fixed. I had run a very wide filter that took 30 minutes in the shared queue to find it; a one-class filter would have shown it in seconds.
   4. My first edit script left one line of the settings file with a stray character and mixed line endings. I caught it in the diff and fixed it before the commit.
5. **What is NOT proven:**
   1. Nobody has started AutoCAD on a profile with no settings file. The real first-start path (`SettingsService.Initialize`) ran in unit tests only, through a test scope.
   2. That the shipped file reaches the installed bundle: the existing rule `Assets\Config\**\*` in `CE_CVL_SUITE.csproj` copies it, and a test pins that rule, but I did not look in an installed bundle (not allowed here).
   3. That the pipe object works on an ordinary non-Tim login. Never run there.
   4. The list of values is not Tim's approved list (see the four open questions in the comparison report: textOsmode 0, pit drop 5, DN100 UPVC, column layout).
   5. Structural settings are not covered.
6. **Robot case that proves it:** **F23_fresh_profile** (control **F23s**, broken twin **F23x**). Wording in section 4.
7. **Tests:** net10 Drainage full suite 20,798 passed, 32 skipped, 1 failed: `Timing_ARelinkOf300PipesAgainst300ScaledPits_MeasuresEachPitOnce` (a speed test, 5.9 s against a 1.5 ratio) while other builds were running; it passed alone. Net48 compile of Drainage: 0 errors. 20,831 tests ran (not zero).

---

## FOR TIM

1. **What I built.** When Max (or anyone) starts CE on a PC that has never had CE settings, CE now starts with your choices. He does not open Settings or copy a file.
2. **What he gets:** your snaps, your dark windows, WT as the rising main destination, "Class A Grate" for the pit lid, your three tank plans, and the one-piece pipe object turned On.
3. **What he does not get:** your folder paths, window sizes and positions, recent diameters, tour and tip counters. Those stay his own.
4. **What does not change:**
   1. Your own PC. You already have a settings file, so CE never reads the new file there.
   2. Anyone who already has a settings file. It is never overwritten.
   3. Settings CE adds in later updates (for example Tidy labels once it is switched on): they still reach Max, because the starting file lists only the seven things above.
5. **Your answer on the pipe object:** "default on for everyone" is built for the fresh-start route. It is not yet built for people who already have a settings file that says Automatic. That needs a separate small change and your word on whether existing files may be edited. I have not decided that for you.
6. **Still waiting on you (QUESTIONS item 40 and the comparison report):** the list is my export of your values. Four of them might be test leftovers (no snaps for pipe text, the 5 mm pit drop, the DN100 UPVC pipe, the pit schedule column order). I left out the 5 mm pit drop, the DN100 pipe and the column order; I included "no snaps for pipe text" because the comparison report recommended it. Say if you want it out.
7. **What to test in AutoCAD:** nothing for you. The robot test (section 4) does it on the test PC.

---

## 1. Entry point and cause

1. **Cause of the gap:** `SettingsService.LoadSettings` (`Services/SettingsService.cs:153-320`) returned `new UserSettings()` when `CD_Settings.json` was absent, so a fresh login always got the built-in values; and `options.pipeObjectUpgrade` Automatic is on only for Tim's Windows account (`PipeObjectUpgradeGate.Resolve`, comparison report section 5).
2. **The change:** `LoadSettings` records whether the file existed (`settingsFileExisted`). Only when it did NOT exist, at the old "Using default settings" fall-through, it calls `ColleagueDefaultsService.BuildFreshSettings`. A file that exists but is empty, damaged or locked never takes this road (existing protect-the-original paths unchanged).

## 2. Files

1. `Modules/Drainage/Assets/Config/colleague-defaults.json` (new): `settings.firstStartUsesColleagueDefaults` true; `options.pipeObjectUpgrade` "On"; `osnap.drawingOsmode` 1151, `osnap.textOsmode` 0; `theme` "dark"; `pipe.risingMainDestination` "WT"; `pit.lidType` "Class A Grate"; `waterTank.planForTank` (3 entries). No path, nothing personal.
2. `Modules/Drainage/Services/ColleagueDefaultsService.cs` (new): reads the file, drops any path-looking string, honours the file's own switch, deserialises through `SettingsService.DeserializeSettingsTolerant` (a key the file lacks keeps its built-in value; one wrong-kind value costs only itself), sets `OldStartingValuesMoved` like the plain fresh path. Any failure returns the built-ins with one plain log line. Never throws, never blocks.
3. `Modules/Drainage/Services/SettingsService.cs`, `Modules/Drainage/Models/UserSettings.cs`: the load hook and the `settings` group.
4. `Modules/Drainage.Tests/Services/F023ColleagueDefaultsTests.cs` (new, 25 test methods and cases) and `REGRESSION_LOG.md` entry.

## 3. Answers to the task's specific questions

1. **How other shipped config files are placed:** `council-profiles.json` and its neighbours sit in `Modules/Drainage/Assets/Config/`, included by `<None Include="Assets\Config\**\*">` (`CE_CVL_SUITE.csproj:309`), copied to the bundle by the existing post-build step. The new file needs no csproj edit and is read through `RuntimePathService.GetPluginPath("Assets","Config",...)` like `council-profiles.json` (`CouncilProfileService.cs:342`).
2. **Manager release file count guard:** I found no fixed number of files in the repo. `OfficialReleaseGate` compares the package's file count with the signed release record's list (`OfficialReleaseGate.cs:1899`), computed from the build. So the build that carries this PR has one more file than C-75; the next signed release record will simply include it. I did not run the release gate (no deploy, no signing in this job). If the next train's record is generated from the final build, nothing to change; if anyone has a hand-written count, it goes up by one.
3. **Why the switch lives in the shipped file:** a fresh PC has no settings file to hold a switch. So `settings.firstStartUsesColleagueDefaults` is a real key in the settings classes (default ON, pinned through both start-up reads), and OFF for a fresh PC is the same key written false in the shipped file. It is not on the Settings page (the other recent switches are not either).
4. **Test hygiene:** a test run (the log-folder override is set) never reads the shipped file unless a test points at one, so every older test still sees the built-in values. Tests: the 20,831-test suite showed no other change.
5. **BUG-1167 and `options.computationsFolder`:** the built-in value of `computationsFolder` is still Tim's dev folder (`UserSettings.cs:1693`). It is the comparison report's "third path". My loaded result for that key equals the built-in value, not blank. That fix is separate code and is not in this PR.
6. **REDO-safe:** the change reads one file at the start and writes nothing: no drawing write, command, regen, view or system variable. The shipped-file read is in the settings loader, not in any selection or undo path.

## 4. Proof for CE 02 (proposed, not written as a case file)

1. **Where it runs:** the test PC's ordinary, non-Tim Windows login (QUESTIONS 37). Tim's PC cannot prove it (he has a settings file).
2. **F23_fresh_profile:**
   1. Set-up: the profile's `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` is absent; the installed Civil build carries `Assets\Config\colleague-defaults.json` with the switch true.
   2. Start AutoCAD, open a fresh drawing, open the Settings page from the CE ribbon and read: Theme dark, pipe object upgrade On, Rising main destination WT, Pit lid type Class A Grate (read from the window or from a CE log line).
   3. Check the CE log has `Fresh profile: office starting settings applied.` and `[C7] pipe upgrade on this PC: allowed (setting On; this Windows sign-in is not the CE test-bed account).`
   4. Type `CD`; at the route prompt type `'OSMODE` then Enter; check the echoed value is `1151`. Esc out, U.
   5. Check `CD_Settings.json` still does not exist (nothing written).
3. **F23s (switch-off control):** the same set-up with the shipped file's `settings.firstStartUsesColleagueDefaults` set to false (the robot edits the bundle copy of the file on the test PC only). Check the log has `Office starting settings are switched off`, the `[C7]` line says `held (setting Automatic; ...`, and `'OSMODE` in CD echoes `5247`.
4. **F23x (broken twin, existing profile):** a profile that already holds a `CD_Settings.json` with `osnap.drawingOsmode` 5247 and `options.pipeObjectUpgrade` Automatic, shipped file switch true. `'OSMODE` must echo `5247` and the `[C7]` line must say held (on a non-Tim login). That proves the shipped file never overrides an existing file.
5. **Reviewer line for the ledger:** this proves the fresh-profile route only. It does not prove item 63's "On for everyone, including existing files".

## 5. Environment

1. Worktree `C:\ce-fx\c78k` (private, short path), base `origin/claude/rel-20261026z` at `09126560` (Civil 3.0.85). Every dotnet command had `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Release, below normal priority, AutoCAD 2027 on PATH, a 0-byte placeholder `CE_TRANSFORM_2027.arx` (git-ignored), a fresh TEMP and CE log folder per run, net48 refs at `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`. At most two top-level dotnet commands ran at once (count checked by script before each). Never deployed. Tim's settings, bundles and ProgramData not touched. `CE_SHARED` unchanged.
2. Scratch: `C:\ce-fx\f023\`. Worktree `bin/obj` cleaned at the end with `git clean -fdXq` inside the worktree only.

---

## FOLLOW-UP B-035b (Fri 30 Oct 2026, built overnight): Tim's remembered tank picks removed from the shipped file

### FOR TIM

1. **Answer first:** done. The starting settings for a new colleague no longer carry your three remembered water-tank plan choices. It is the same draft PR, #1844 (same branch `fb/f023-colleague-defaults`, new commit `ab8ea0b9`, normal push, nothing forced).
2. **What a drafter will see differently:** a colleague on a fresh login picks a 3000 L round, above-ground tank in CDWT. Before this fix, CDWT would have pre-selected your "U/G TANK" plan and said "The plan you chose before for this tank is selected". Now CDWT picks by litres and above or below ground, as it does for everyone, with no "chose before" line. After they pick a plan themselves, CE remembers that for them.
3. **What did not change:** everything else in the starting settings (pipe object On, snaps, dark window, rising main WT, pit lid). A PC that already has a settings file, yours included, is untouched, so you keep your own tank picks.
4. **Mistakes of my own first:**
   1. I lost about 7 hours waiting for a free build slot. The first wait script I started was killed by the tool at 30 minutes without telling me, so it never ran. Cost: the PR came late.
   2. My first relaunch of the test script ran nothing and reported "exit" with no result (the tool's search path has no `cmd`). I only saw it when the log came back empty. Cost: one more wait in the queue.
5. **What is NOT proven:** nothing was run in AutoCAD. The three tank picks are gone from the file and the unit tests prove that a fresh profile loads with no remembered tank plan. I did not look at what CDWT does on screen. Also not checked: whether the 2000 L round tank should share the slimline caption for everyone (review said it may be right if the master has one 2000 L plan); that is a separate question.
6. **Robot case that proves it:** **F23t_no_tank_pick** (control **F23ts**, broken twin **F23tx**). Wording in section 4 below.
7. **What to test in AutoCAD:** nothing for you; the robot does it.

---

### Technical detail

1. **Cause:** `Modules/Drainage/Assets/Config/colleague-defaults.json` had a `waterTank.planForTank` group of three entries ("2000 L SLIMLINE|2000", "3000 L ROUND|3000", "2000 L ROUND|2000") copied from Tim's settings. In `WaterTankPlanMatch.Arrange` a remembered plan beats the litres and above/below-ground match (Opus pre-review finding 1, #1844).
2. **Change:** the `waterTank` group is deleted from the shipped file. No code change. The switch `settings.firstStartUsesColleagueDefaults` is untouched and still ON. A key the shipped file lacks keeps its built-in value, here an empty list.
3. **Tests (`F023ColleagueDefaultsTests`):** the old "three picks read back" assertions now assert `WaterTank.PlanForTank` is empty after a fresh-profile load; new `ShippedFile_CarriesNoRememberedChoice_NoTankPlanPicks` (no `waterTank` group, no `planForTank` key anywhere in the file, no "U/G TANK" text, empty list after the load); leaf-count floor 8 to 7 (one group of 3 picks counted as one leaf, so 8 became 7).
4. **Results:** focused net10 classes (F023, ColleagueDefaults, ColleagueStandalone, WaterTank): **291 total, 291 passed, 0 failed** (count not 0). Full net10 suite and net48 compile: see the RESULT LINE at the end of this section.
5. **REGRESSION_LOG.md:** new B-035b entry at the top.
6. **Proof for CE 02 (proposed):**
   1. **F23t_no_tank_pick:** non-Tim login, no `CD_Settings.json`, installed build carries the shipped file with the switch true. Start AutoCAD, type `CDWT`, choose a 3000 L round tank and above ground. Check the plan list does NOT pre-select "3000 LITRE GARANTIA LI-LO / U/G TANK (2456 x 2139 mm)" and the dialog does not show the line "The plan you chose before for this tank is selected". Esc out.
   2. **F23ts (control, a pick the drafter made themselves):** same login, but a `CD_Settings.json` is first written that holds `waterTank.planForTank["3000 L ROUND|3000"]` set to the U/G TANK caption. The same `CDWT` steps must show that plan pre-selected with the "chose before" line. This proves the line still works for a real remembered pick.
   3. **F23tx (broken twin, switch off):** shipped file switch false, no settings file: the tank list must also be unselected (built-in empty list). If F23t shows a pre-selected U/G TANK plan, the picks are back in the shipped file.
7. **Environment:** worktree `C:\ce-fx\c81b` (short path), detached at `origin/fb/f023-colleague-defaults` (the branch was already checked out in the older worktree `C:\ce-fx\c78k`, so I pushed with `git push origin HEAD:refs/heads/fb/f023-colleague-defaults`). Every dotnet command had `-p:SkipDevBundle=true -nr:false --disable-build-servers`, below normal priority, AutoCAD 2027 on PATH, placeholder `CE_TRANSFORM_2027.arx`, fresh TEMP per run, one top-level dotnet command at a time and only when the count was 0. Never deployed. Tim's settings, bundles and ProgramData not touched. `CE_SHARED` unchanged. Scratch: `C:\ce-fx\c81b_*`.
