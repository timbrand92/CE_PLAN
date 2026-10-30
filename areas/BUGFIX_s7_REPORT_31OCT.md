# BUGFIX s7 report: Structural batch S-7 (Sat 31 Oct 2026, Melbourne time)

Base: origin/claude/rel-20261026s (204dfad2, installed Structural 1.0.125). Build number: B-083 (BUILD_REGISTER item 134). All three PRs are drafts against claude/rel-20261026s. Built and unit-tested only. Nobody has opened any of this in AutoCAD. No bug is marked FIXED.

## FOR TIM

1. **Three drafts are open, one per bug.** #1903 (BUG-1123), #1904 (BUG-1128), #1905 (BUG-1122). Each has a Settings switch that is ON.
2. **Schedule text from Excel (XCLMTXT):**
   1. If your office spelling list has a row for a UB or UC size, for example 250UB26 to 250 UB 25.7, XCLMTXT now uses it. Before, it skipped the row and printed "250 UB 26". (#1903)
   2. A cell "TOP PL & BOT PL" now prints TOP PLATE & BOT PLATE. Before it printed TOP PLATE & BOT PL, and a PL at the end of a cell stayed PL. A mark like PL1 or PL-1 is left alone. (#1904)
3. **Section search in SBEAM:** typing 410UB59, 410UB60 or 410UB59.7 finds the 410UB60 section (real mass 59.7 kg/m); 460UB75 finds 460UB74; 250UB25 finds 250UB26. A wrong depth or mass (410UB57) still finds nothing. (#1905)
4. **My mistakes first:** (a) I read the build register before CE 01 had written B-083, so my first PR bodies said "no B number"; I have since edited the three bodies and renamed #1905 (CE 01 had already renamed #1903 and #1904). (b) My first net48 build failed only because the shell had no powershell on its path (a post-build check); I re-ran it with the path fixed and it is clean.
5. **Not done, on purpose:** BUG-1122 also covers CEMEMBER's typed names and the Lysaght Z15019 names. CEMEMBER's lookup is in a file that open PR #1900 (BUG-1121) edits, so I left it until that merges. The Lysaght names need the BUG-818 section list.
6. **What to test in AutoCAD (all three are unproven there):**
   1. XCLMTXT with a MEMBERS.csv row such as 250UB26 to 250 UB 25.7 and a cell "250UB26": expect 250 UB 25.7. A cell "250UB26.5" is unchanged.
   2. XCLMTXT cell "TOP PL & BOT PL": expect TOP PLATE & BOT PLATE; cell "250 x 16 PL": expect 250 x 16 PLATE.
   3. SBEAM, type 410UB59 in the search: expect 410UB60 in the list. Type 460UB75: expect 460UB74.

---

## Technical detail

1. **BUG-1123 (#1903, branch claude/s7-bug1123-office-spelling-first).** Fault confirmed on the line by reading `ExcelMTextService.ExpandMemberAbbreviation` (Modules/Structural/Services/ExcelMTextService.cs, the call to `ProtectExplicitMemberSizes` ran before the office rows). Fix: `ExpandMemberAbbreviationCore` (internal static, testable) runs `ApplyOfficeSizeSpellings` first, for rows whose left side is a UB/UC size only, with a guard so 250UB26 never matches inside 250UB26.5. Switch `Excel.OfficeSpellingBeforeSizeLock` (UserSettings.cs, ExcelSettings), default on. Tests: `OfficeSpellingBeforeSizeLockTests` (6). Related run: 657 passed (XclmTxt*, StudWordingSettingTests, S45NewSwitch*), net10.
2. **BUG-1128 (#1904, branch claude/s7-bug1128-pl-plate-wholeword).** Fault confirmed: only `" PL "` was replaced (line 5793 on the base). Fix: `ExpandPlateWord` replaces the whole word PL, not preceded or followed by a letter, digit, hyphen or slash. Switch `Excel.PlateWordEverywhere`, default on; off returns the old rule exactly. Tests: `PlateWordEverywhereTests` (cases for start, middle, end, longer words, switch off, default through `new UserSettings()` and `DeserializeSettingsTolerant`, typed off stays off). Related run: 663 passed, net10.
3. **BUG-1122 (#1905, branch claude/s7-bug1122-ub-mass-spelling).** Fault confirmed: `SbeamSelectionPlanner.MatchesSearch` did a text match only; the catalogue names 410UB60 with massPerMetre 59.7 and 460UB74 with 74.6. Fix: when `SbeamCatalogueQuery.MatchMassSpelling` is true (query default false), a typed depth + family + mass also matches when depth and family are equal and the typed whole number equals the real mass cut down or rounded, or a typed decimal equals it to one decimal place (0.05). The picker dialog passes `SbeamPicker.MatchMassSpelling` (default on); `SbeamPickerController.QueryCatalogue` takes it as an optional parameter because that file is compiled into the DesignCore tests without `SettingsService`. Tests: `SbeamMassSpellingSearchTests` (11, DesignCore), `SbeamMassSpellingSwitchTests` (2, Structural). DesignCore run 250 passed (planner and picker adapter classes included), Structural 6 passed. The carpark's "within 0.5 kg/m" rule would not have found 410UB59 from 59.7 (0.7 apart), so the cut-down/rounded rule was used instead; this is my reading, Tim has not ruled on it.
4. **net48:** `dotnet build Modules/Structural/CE_STRUC_SUITE.csproj -f net48 -c Release` with the three ref paths from memory note structural-tests-net10-recipe item 8: 0 errors, 0 warnings, run on each branch.
5. **Commands:** every test: one .csproj with --filter, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, below normal priority, slot count and 12 GB disk check in my scratch script (C:\ce-scratch\s7\ps), env CE_STRUC_SUITE_APPDATA_ROOT, CE_LOG_DIR_OVERRIDE, TEMP, TMP echoed before each run. Test counts were never zero. Full Structural suite NOT run (not allowed); full Civil/Manager NOT run.
6. **Shared-file clashes seen:** open Structural drafts into claude/rel-20261026s: #1901, #1900 (touches CeMemberPrompts.cs, UserSettings.cs, S5SwitchDefaultsTests), #1899, #1898, #1895, #1886, #1885. None touches ExcelMTextService.cs. #1900 edits UserSettings.cs (different region; a trivial merge conflict is possible). My three PRs each add one property in UserSettings.cs (ExcelSettings twice at the same spot, SbeamPickerSettings once): merging #1903 and #1904 will give a small conflict at the same line, keep both.
7. **Switch on the Settings page:** not shown (the sibling switches such as UnknownPadSizeIsNotInvented are not shown either).
8. **Robot case wanted (for CE 02), with a switch-off control:**
   1. **N60_xclmtxt_pl_plate:** write a one-row Excel sheet with the member cell "TOP PL & BOT PL", run XCLMTXT, read the schedule MTEXT: expect "TOP PLATE & BOT PLATE". Control: set Excel.PlateWordEverywhere=false before AutoCAD starts (settings are read at launch), expect "TOP PLATE & BOT PL".
   2. **N61_xclmtxt_ub_row:** place MEMBERS.csv (in a copy, never Tim's) with row 250UB26,250 UB 25.7; cell "250UB26"; expect "250 UB 25.7". Control: Excel.OfficeSpellingBeforeSizeLock=false, expect "250 UB 26".
   3. **N62_sbeam_mass_search:** open SBEAM, type 410UB59 in the search, check the list shows 410UB60 (a window read, so a Codex look is also needed). Control: SbeamPicker.MatchMassSpelling=false, the list is empty.

## Real-files comparison (names, sizes, last-write; no contents)

Full listings of %APPDATA%\TIM_CE_CADTOOLS (with CE_Admin\outbox and logs), CE_STRUC_SUITE, CE_CVL_SUITE and CE_CADTOOLS (with CE_Admin) are saved (not in the repo) at C:\ce-scratch\s7\real_before.txt (01:5x, 32,372 lines) and C:\ce-scratch\s7\real_after.txt (32,382 lines).

1. **Settings files before and after:**
   1. %APPDATA%\CE_STRUC_SUITE\CS_Settings.json: 35,613 bytes, 2026-10-30 19:54:14, before and after. Unchanged. CS_Settings.json.PRE_TIM_YES_20261020.bak 34,858 bytes, 2026-10-18 10:00:24, unchanged.
   2. %APPDATA%\CE_CVL_SUITE\settings.json: 672 bytes, 2026-09-16 12:13:17, unchanged.
   3. %APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json: before 15,404 bytes, 2026-10-31 01:42:08; after 15,270 bytes, 2026-10-04 08:22:30. CHANGED. Not written by my runs (they are Structural tests redirected to C:\ce-scratch\s7). The robot's AutoCAD (acad.exe pid 14368, started 01:58:14, not mine) was running and the batch notes say the robot may legitimately change CD_Settings.json. CD_RecentValues.json also changed (02:03:21).
2. **Other changes between the two listings (all inside the window when AutoCAD pid 14368 was running):** CE_Admin\outbox\usage entries, outbox\machines and sessions files, logs\ce_struc_suite.log, logs\CE_CVL_SUITE.log, ce_cvl_structured and ce_struc_structured logs, RuntimeDiagnostics, telemetry\outbox.jsonl, CE_SUITE_MANAGER_MENU.cuix. These are what a running AutoCAD with CE loaded writes. I cannot prove from the listing alone that none came from my test host; what I can say is that my test runs had every CE path redirected to C:\ce-scratch\s7, they never started Manager or Civil code, and the CVL log changes cannot come from Structural tests.
3. **Verdict:** no real Structural settings file changed. One Civil settings file changed, explained by the robot's AutoCAD session; flagged here as asked.

## Skipped

None skipped; BUG-1122 done in part (SBEAM search only, see FOR TIM item 5). Questions for CE 04: none.

## Housekeeping

Worktree C:\ce-fx\s7w, bin/obj cleaned with `git clean -fdXq` inside it. The main checkout was not edited (its untracked .codex/, BracingLengthSettingsTests.cs and TEAMLANE4 log are not mine). DESK_LOG.md and BUG_CARPARK.md not edited.
