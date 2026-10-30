# BUGFIX s6 report: Structural batch S-6 (Sat 31 Oct 2026, about 02:00 Melbourne)

## ANSWER FIRST

1. **PR number:** draft PR **#1902** against `claude/rel-20261026s` (Structural 1.0.125): BUG-1126 and BUG-1131 together. No B number is in `release-v3-colleagues-BUILD_REGISTER.md` for these bugs, so the title says "no B number yet"; CE 01 to assign one.
2. **BUG-611: ALREADY FIXED on this line, no PR.** The status text now skips Timber: `Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.xaml.cs:451` reads `options.Count == 0 && family != "Timber"`. The fixing commit is `0bae4ef8` ("Fix Timber picker status and retain readable steel search feedback", draft PR #1262), which is an ancestor of the 1.0.125 line (checked with merge-base). Not marked FIXED: nobody has confirmed it in AutoCAD on 1.0.125.
3. **BUG-1126 and BUG-1131 still existed** on 204dfad2 and are changed in #1902. Both are built and unit-tested only. Nobody has opened them in AutoCAD. Neither is marked FIXED.

---

## FOR TIM

1. **What you will see differently in SBEAM (once it is installed):** pick a 40 x 40 x 3 EA and the window shows Ix 0.04 instead of 0. A 75 PFC shows Iy 0.14 instead of 0.1. A 1.12 kg/m angle shows 1.12 instead of 1.1. Anything 10 or bigger looks exactly as before (306, 152.4).
2. **The length box:** type 6000 for a 310UB32 and the window now says 192 kg (length read as 6000 mm), not 192000 kg. A length of 100 or less is still metres, so 6 still means 6 m.
3. **Switches, all in Settings, all ticked on:** "SBEAM section window shows small figures to three significant figures", "SBEAM optional member length above the figure below is read as millimetres" and the figure itself (100). Untick either and the window behaves exactly as it does today.
4. **BUG-611 (Timber preview says "No local steel sections match"):** already fixed in the build you have installed. To confirm: SBEAM, choose Timber, type 90 and 240, and check no steel "no match" line shows. Needs your yes before it can be marked fixed.
5. **Nothing was tested in AutoCAD.** The robot case below is the proof still owed.

---

## MISTAKES OF MY OWN (first)

1. **Two bugs in one PR.** The job said one draft PR each. I put BUG-1126 and BUG-1131 in #1902 because they edit the same window file and the same settings lines. If CE 01 wants them separate, say so and I split it.
2. **Wrong tool path at first.** `git`, `gh` and `dotnet` are not on the PowerShell path; I lost a few minutes. A net48 build failed once on a missing `powershell` for the post-build check (exit 9009), not on code; re-run with it on PATH: 0 errors.
3. **No B number and the bug text was lightly corrected.** The batch file says BUG-1131's fix is in `SbeamSelectionPlanner.cs`. I did not change it: that file is in `Structural.DesignCore`, which cannot read Settings. The conversion sits in the window's own length reader instead, so the length stored with a placed section is now in metres (6 m, not 6000 m).

---

## WHAT IS NOT PROVEN

1. **The window in AutoCAD.** Unit tests cover the number formatting, the 6000 to 6 m to 192 kg arithmetic, the switch defaults and the switch-off text. They do not show the window. The weight-line wording "(length read as 6000 mm)" has never been seen.
2. **Existing placed sections** keep whatever length they were stored with. Only new entries in the box are read the new way.
3. **A length between 100 and 1000 typed as metres on purpose** (for example a 150 m span) is now read as mm. That is the point of the rule; the threshold is in Settings if the office wants it moved.
4. **The Settings page row:** I added the three description lines in `SettingsService.LoadRecovery.cs` (where the other switches are described); I did not open the Settings page to look at them.
5. **Full Structural suite not run (job rule).** Only focused classes.

---

## ROBOT CASE THAT PROVES IT (with a switch-off control)

**Case name: `S31_sbeam_len_mm`** (and control `S31_sbeam_len_mm_off`), plus `S32_sbeam_small_figs` (control `S32_sbeam_small_figs_off`).

1. **S31 types:** SBEAM, pick 310UB32, in "Optional member length" type 6000. **Checks** the weight line reads `192 kg (length read as 6000 mm)`. Then type 6 and check it reads `192 kg` with no note.
2. **S31 off control:** set `Options.SbeamLengthOverThresholdIsMillimetres` to false in the settings before AutoCAD starts (CE reads settings at launch), repeat: the weight line must read `192000 kg`.
3. **S32 types:** SBEAM, search 40x40x3, pick the 40 x 40 x 3 EA. **Checks** the Ix property reads `0.04`.
4. **S32 off control:** `Options.SbeamPickerThreeSignificantFigures` false: Ix reads `0`.

---

## TECHNICAL DETAIL

1. **Branch / PR:** `claude/s6-picker-bugs-20261031`, one commit on 204dfad2, PR #1902 (draft). Worktree `C:\ce-fx\s6`.
2. **Entry points:** BUG-1126 `SteelSectionPickerDialog.xaml.cs` `FormatDim` (was `ToString("0.#")`). BUG-1131 `TryParseMemberLength` feeds both `UpdateWeightDisplay` and the placement request (`MemberLengthMetres`), so one conversion covers the display and the stored value.
3. **Files:** new `Services/SbeamPickerDisplay.cs` (pure formatting and conversion), new `Services/SbeamPickerDisplaySettings.cs` (one reader, recommended answer when Settings cannot be read), `Models/UserSettings.cs` (3 properties after `TimberQuantityAnyNumber`), `Services/SettingsService.LoadRecovery.cs` (3 description lines), the dialog, `REGRESSION_LOG.md`, new `Structural.Tests/Models/S6PickerSwitchDefaultsTests.cs` (two fixtures).
4. **Switch-default test:** only `DeserializeSettingsTolerant` exists as a start-up read on this line (there is no separate `DeserializeSettings`); it tries the normal read first and falls back value by value. Pinned on a blank file, a 1.0.125-shaped file without the keys, and a file with a bad value; typed-off values stay off.
5. **Display rule:** below 10, three significant figures (0.04, 0.14, 1.12); 10 and above, the earlier `0.#`. 9.999 shows 10.
6. **Tests run (net10, test count not 0):** 45 passed (`S6PickerSwitchDefaultsTests`, `SbeamPickerDisplayTests`, `S44NewSwitchDefaultsTests`, `SteelSectionPickerDialogTimberQuantityTests`), then 64 passed (`SettingsLoadRobustnessTests`, `Bug1076FaultReportSettingsWordsTests`, any `SteelSectionPickerDialog*`, `SbeamSelectionPlannerTests`, `S45NewSwitchDefaultsTests`, `SettingsFileUpdatedTraceTests`). net48 Release build of `CE_STRUC_SUITE.csproj`: 0 errors, 0 warnings. Each test command named one `.csproj` with a `--filter`, with `-m:2`, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, below-normal priority, isolation variables printed first (`CE_STRUC_SUITE_APPDATA_ROOT=C:\ce-scratch\s6\struc`, `CE_LOG_DIR_OVERRIDE=C:\ce-scratch\s6\logs`, TEMP under `C:\ce-scratch\s6`). I did not run a red run without the fix; the switch-off tests pin the old text instead.
7. **Shared-file clashes (gh pr list on the base):** `UserSettings.cs` is edited by open PRs 1885, 1886, 1895, 1898, 1899, 1900, 1901; `SettingsService.LoadRecovery.cs` by 1885, 1895, 1901; `REGRESSION_LOG.md` by all of them. No open PR touches `SteelSectionPickerDialog.xaml.cs` on this base (only #1673 on an older base mentions the name). Expect keep-both conflicts at the settings lines.
8. **Real-files compare (names, sizes, times only):** full listings of `%APPDATA%\TIM_CE_CADTOOLS` (including `CE_Admin\outbox` and logs), `CE_STRUC_SUITE`, `CE_CVL_SUITE` and `CE_CADTOOLS` (including `CE_Admin`) are in `C:\ce-scratch\s6\scr\real_before.txt` (32368 rows, 01:45:00) and `real_after.txt` (32369 rows, 02:00 about). Settings files, identical before and after: `CE_STRUC_SUITE\CS_Settings.json` 35613 bytes 30 Oct 19:54:14; `TIM_CE_CADTOOLS\CD_Settings.json` 15404 bytes 31 Oct 01:42:08 (the robot's start, before my first test); `TIM_CE_CADTOOLS\CS_Settings.json` 351713 bytes 31 Mar 13:18:00. Only differences: `CE_CVL_SUITE\logs\CE_CVL_SUITE.log` and `ce_cvl_structured_20261031.log` grew, `CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json` heartbeat time moved (01:44:20 to 01:47:20), and one new usage file `TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-10-30\usage_20261030_144708_167_...json` (385 bytes, 01:47:08). **Cause:** an `acad.exe` (pid 80872, started 01:42:10) was running during my work, so these are the robot's AutoCAD writing its own logs and heartbeat. My test runs were Structural-only with every folder redirected to `C:\ce-scratch\s6`, and none of those files are Structural files. I did not run Manager or Civil tests.
9. **Skipped bugs:** BUG-611 only (already fixed, above). Nothing needed Tim wording.
10. **Undo:** revert commit on `claude/s6-picker-bugs-20261031`; nothing was installed or deployed.
