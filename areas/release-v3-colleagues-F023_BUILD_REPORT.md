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
