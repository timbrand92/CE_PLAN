# Structural batch S-16 report, Sat 31 Oct 2026, job s16

## ANSWER FIRST

Three draft PRs, all against `claude/rel-20261026s` (Structural 1.0.125, head 204dfad2). All three faults were confirmed still present on that line before any change. Nothing is marked fixed. No B number for these bugs is in BUILD_REGISTER, so the PR titles carry the BUG number only.

1. **BUG-1134, PR #1914:** the member schedule counts `310UB32` and `310 UB 32` as one size.
2. **BUG-1203, PR #1915:** unticking "Background refresh enabled" stops the start-up folder scan and cache load.
3. **BUG-1219, PR #1916:** CEHELP for Beam Settings (8) and RJSET now describes opening CE Settings.

## FOR TIM

1. **BUG-1134 (schedule sizes).** Two FB3 beams labelled `310UB32` and `310 UB 32` now give one row, "FB3 310 UB 32", with no "drawn with different sizes" note. A real difference (310 UB 32 against 250 UB 26) still shows Unknown. The member schedule is still off by default, so you will only see this once it is switched on. Switch: `MemberSchedule.CompareSizesIgnoringSpaces`, ON.
2. **BUG-1203 (background refresh).** In CESETTINGS, XCLMTXT, untick Background refresh enabled and restart. AutoCAD no longer scans the schedule-history folders or loads that cache while starting. XCLMTXT still works when you use it, and its own Refresh button still refreshes. Switch: `XclmTxt.BackgroundRefreshSwitchIsHonoured`, ON.
3. **BUG-1219 (Help wording).** CEHELP (tick Show advanced commands), entries "Beam Settings" and "Rafter/Joist Settings": they now say nothing is asked on the command line, CE Settings opens on the right page, and Save keeps the changes. Wording only, no switch.
4. **Nobody has opened any of these in AutoCAD.** All three are built and unit-tested only.
5. **Skipped:** none. No questions for CE 04.

---

## Mistakes of my own

1. **A pointless first command.** I ran a stray `python3` heredoc in Bash that hung for 120 s before I stopped it. It touched nothing.
2. **Stale first test run.** The first test run failed with NETSDK1004 (missing Hosted restore in the fresh worktree). I ran the restore from the memory recipe and re-ran. About two minutes lost.

## Technical detail

1. **BUG-1134.** Confirmed on the line: `Core/Schedules/MemberScheduleFromPlan.cs` used `.Distinct(StringComparer.OrdinalIgnoreCase)`. Now `DistinctSizes()`: with the switch ON, whitespace is removed, case folded and the times sign (U+00D7) treated as X; when two spellings merge, the one with more spaces is shown (first drawn on a tie). Switch OFF returns the exact old call. Option plumbed through `MemberScheduleOptions.FromSettings`. Five new tests in `MemberScheduleFromPlanTests` (spacing, X and case, real difference still Unknown, switch off returns the old Unknown, default through the tolerant reader on the normal path and the value-by-value path). Structural has no separate `DeserializeSettings`; the tolerant reader is the only start-up read, so both of its paths are pinned. Run: MemberSchedule and NewSwitchDefaults classes, 109 passed. net48 Release compile of `CE_STRUC_SUITE.csproj`: 0 errors, 0 warnings.
2. **BUG-1203.** Confirmed on the line: `Plugin.cs:156` called `XclmTxtCorpusIndexService.Initialize()` unconditionally; `Initialize()` loads the cache and ends in `RequestRefreshIfStale()`, which never read the tick; `RequestRefresh()` saves a start timestamp and runs `RefreshCore` on a worker, which saves `LastCorpusRefreshUtc`. The only tick check was in `XclmTxtService.Run`, after `Initialize()`. Fix: pure `AutomaticRefreshAllowed(XclmTxtSettings)`; start-up asks it before `Initialize()`; `RequestRefreshIfStale()` asks it before scheduling. Explicit calls (`XclmTxtService.cs:189`, `:360`) are not gated. Initialize is idempotent, so XCLMTXT and `GetSnapshot` still initialise on first use. Tests: `Bug1203BackgroundRefreshSwitchTests` (6) plus the XclmTxt and NewSwitchDefaults classes, 658 passed. net48 compile 0 errors. The real service reads the drafter's settings folder, so it is not run in a test; the order of the gate is pinned by a source guard.
3. **BUG-1219.** Confirmed on the line: `BeamSettingsCommand.cs:22` and `RafterJoistCommands.cs:90` only call `CeSettingsUiService.Open(...)`; `command-registry.json` entries 8 and RJSET still listed placement prompts. Changed `longDesc` and `prompts` of those two entries only. The old long description also claimed osnap and mirror settings, which the Beam page does not show, so it was replaced with what the page really holds. No C# change. Tests: `Bug1219SettingsCommandsHelpWordsTests` (5 cases) plus help-words and CommandRegistry classes, 50 passed. I did not verify that Save closes the window; the wording says only that Save keeps changes and Cancel leaves them.
4. **Shared-file clashes seen.** `UserSettings.cs` is touched by open PRs #1909, #1910, #1911 (S-13, S-14); I edited only `MemberScheduleSettings` (1134) and `XclmTxtSettings` (1203), different classes from theirs as far as the PR titles say, but I did not diff their hunks. `CeSettingsDialog.xaml` not touched (no Settings row added for either switch). `command-registry.json` and `Plugin.cs`: no open Structural PR seen in the title list; I did not read every file list.
5. **Not proven.** Nothing seen in AutoCAD. No Settings page row for the two new switches (a drafter cannot untick them; the settings file only). The 1203 start-up behaviour is proven by the rule and source order only, not by a start-up log from a real AutoCAD.
6. **Robot cases, with a switch-off control.**
   - **S16_bug1134_size_spacing:** with `MemberSchedule.Enabled` on, draw two FB3 beams, type `310UB32` on one and `310 UB 32` on the other, run CSMEMBERSCHED. Check the schedule row reads `FB3 310 UB 32` and the command line has no "drawn with different sizes". Control: set `MemberSchedule.CompareSizesIgnoringSpaces` false before launch, repeat, expect `FB3 Unknown` and the "different sizes" line.
   - **S16_bug1203_no_refresh:** before launch set `XclmTxt.BackgroundRefreshEnabled` false and clear `LastCorpusRefreshUtc`; start AutoCAD, do not run XCLMTXT, read `CS_Settings.json` and the Structural log. Check `LastCorpusRefreshUtc` is still empty and no corpus-refresh line is logged. Control: set `BackgroundRefreshSwitchIsHonoured` false and repeat; expect a refresh time and the old scan. (Settings are read at launch, so set them before starting.)
   - **S16_bug1219_help_text:** type CEHELP, tick Show advanced commands, open "Beam Settings" and "Rafter/Joist Settings"; check the prompts list reads "Nothing is asked on the command line..." and has no "Start point". Then type `8` and RJSET and check CE Settings opens on Beam and Rafter / Joist. No switch, so no switch-off control; the control is the old build.
7. **Environment.** Worktree `C:\ce-fx\s16`, branches `claude/s16-bug-1134`, `-1203`, `-1219`, each from origin/claude/rel-20261026s; cleaned with `git clean -fdXq` at the end. Every dotnet command ran through `C:\ce-fx\s16_run.ps1` (copy of s15's runner with s16 paths): below normal, one test csproj plus `--filter` enforced (refuses otherwise), slot check under 2, 12 GB disk check, TEMP, `CE_LOG_DIR_OVERRIDE` and `CE_STRUC_SUITE_APPDATA_ROOT` set to scratch folders under `C:\ce-scratch\s16` per run, `-m:2`, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, AutoCAD 2027 on PATH. Test counts were never 0. No full suite and no Manager or Civil tests were run (brief). Never deployed.
8. **Real-files compare, before the first test and after the last.** Full per-file listings (name, size, last write; no contents) are saved at `C:\ce-scratch\s16\tmp\before.txt` and `after.txt` (32,556 lines each). A line-by-line compare shows **no difference: nothing new, nothing changed.** Summary of both:
   - `%APPDATA%\TIM_CE_CADTOOLS` (including CE_Admin\outbox and logs): 28,752 files, 1,138,974,240 bytes.
   - `%APPDATA%\CE_STRUC_SUITE`: 2,499 files, 2,099,620,564 bytes.
   - `%APPDATA%\CE_CADTOOLS` (including CE_Admin): 1,023 files, 110,300,899 bytes.
   - `%APPDATA%\CE_CVL_SUITE`: 278 files, 70,884,050 bytes.
   - Settings files, unchanged: `CE_STRUC_SUITE\CS_Settings.json` 35,613 bytes, 30 Oct 19:54:14; `CE_CVL_SUITE\settings.json` 672 bytes, 16 Sep 12:13:17; `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 bytes, 4 Oct 08:22:30; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 bytes, 31 Mar 13:18:00; `TIM_CE_CADTOOLS\CD_RecentValues.json` 12,222 bytes, 31 Oct 04:44:39 (written before my first listing at about 05:20, same in both).
9. **Undo.** Each PR: revert its single commit (b8853b02 for 1134; the other two heads are on their PRs).
