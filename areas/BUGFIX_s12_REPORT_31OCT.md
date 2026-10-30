# BUGFIX s12 report: Structural batch S-12 (31 Oct 2026, Melbourne)

## ANSWER FIRST (FOR TIM)

1. **Two draft PRs are open, one skipped.** PR #1908 (BUG-1129) and PR #1909 (BUG-579), both drafts against `claude/rel-20261026s`, both titled B-088 (register entry 143). BUG-615 is skipped (below).
2. **BUG-1129, what you will see:** BARWEIGHT 100 N20 at 6 m now says 1479.6 kg, the same as the bar schedule (it said 1482.0). 50 N16 at 12 m is 946.8 kg in both (was 948.0). N40, R6 and R10 are still UNKNOWN on the bar schedule because the catalogue has no row for them; BARWEIGHT keeps their built-in mass and prints a one-line note saying so. Switch: Settings, Options, "BarWeightUsesBarCatalogue", ON.
3. **BUG-579, what you will see:** FPFC with depth 350, then FEDIT offers 350 (not 0) and the footing schedule shows 350 deep (not UNKNOWN). FSF strips do the same. A footing placed with no depth typed still shows UNKNOWN, which is right. Switch: Settings, Footing width, "FootingDepthKeptOnPlacement", ON.
4. **Mistakes of my own:** (a) I first wrote both fixes in one working copy and had to split them into two branches by hand; the split was checked by diff (each PR holds only its own lines). (b) My first net48 build failed only because `powershell.exe` was not on the job PATH (post-build check); I added it and the rebuild passed. (c) I used the wrong deserialiser name in a first test draft (`DeserializeSettings` does not exist in Structural); fixed before any run.
5. **Nothing here is proven in AutoCAD.** Built and unit-tested only. Nobody has opened either change in AutoCAD. Neither bug is marked fixed.
6. **Real-files comparison needs your eyes (item 7 of the technical part):** one real file in the Civil folder changed during my window and an AutoCAD session started at 03:36 that is not mine. I believe none of it is from my runs; details below.

---

## TECHNICAL DETAIL

### 1. Per-bug result

1. **BUG-1129: BUILT, PR #1908** (`claude/s12-bug1129-one-bar-table`, commit 845ec656). Fault confirmed still present on the line: `Services/StandardsService.cs:83` N20 = 2.47, `Assets/Config/rebar-catalogue.json:8` = 2.466; BARWEIGHT (`Commands/RebarCommands.cs` `RunBarWeight` via `RebarService.CalculateWeight`) read the first, the bar schedule (`ReoBarService.cs:855` `MassPerMetre` via `ReinforcementService.FindBar`) the second.
   - Fix: new `Services/BarWeightMassRule.cs` (one rule, plus the Settings reader); `RebarService.CalculateWeight` now looks the bar up in the catalogue first and falls back to the built-in mass when the catalogue has no row or the mass is not positive; `RunBarWeight` prints a note on fallback. Catalogue file not changed.
   - Switch `Options.BarWeightUsesBarCatalogue` (`Models/UserSettings.cs`), default ON, label in `SettingsService.LoadRecovery.cs`. Off returns 1482.0 exactly (test).
   - Left alone: adding N40, R6, R10 rows to the catalogue. They need lap and cover values (Tim's call). Question for CE 04 below.
2. **BUG-579: BUILT, PR #1909** (`claude/s12-bug579-footing-depth`, commit 5c2261c7). Cause named from the code: `FoundationService.cs` `TryGetOrPromptRectSize` (and `TryGetOrPromptWidth` for strips) ask "Enter depth" and `fst.Upsert(bucket, key, x, y, depth)` only; the `FoundationElementData` created at the rectangle placement (about line 1289) and strip placement (about line 1367) never set `Depth`, so it stayed 0. FEDIT (`:1942-1948`) and the schedule (`FoundationScheduleService.cs:828`, `FoundationScheduleBuilder.cs:160-204`) read the element, not the size list. This matches the entry's fresh isolation (PF2, FEDIT 0 and UNKNOWN before any Undo) and the strip extension. The earlier CE 05 note called this "cannot tell"; reading the placement code answers it for the placement half.
   - Fix: new `Core/Footings/FootingDepthKept.cs`; `FoundationService.SavedDepthToRecord` reads the size-list depth for the footing's key; both placement sites set `Depth = SavedDepthToRecord(...)`.
   - Switch `FootingWidth.FootingDepthKeptOnPlacement`, default ON. Off = depth stays in the size list only (old behaviour exactly).
   - Not covered: FADOPT-adopted footings, screw pile and stump routes; the Undo then Redo part of the entry (not traced; the isolation shows the loss before any Undo; the registry is saved with the footing, so Undo/Redo should now carry the depth like width, but that is a belief, not seen).
   - The entry says a behaviour-owner Modify card is needed before code. The change only stops an entered value being dropped (no new prompt, no new drawing output); I treated it under the job's "smallest safe change behind a switch" rule and flag it here for CE 04.
3. **BUG-615: SKIPPED (needs a decision and an AutoCAD run).** `Commands/HatchCommands.cs` CH (`:214`) builds the hatch at `:484-519`, so the fault is still there (matches the CE 05 check, item 28). The fix is a new live-preview and Apply step with adjustable Scale/Angle/Origin across CH, EH, WH, LBH, LBUH, BLH, CEHATCHBATCH and CEHATCHGAP: a new interactive workflow, which the mandatory command review gate forbids without an approved card (ST-05/ST5-4 is approved as a design, no card for code). It cannot be proven without AutoCAD. **Question for CE 04 (via CE 05):** "Is the ST5-4 live-preview-then-Apply card approved for code? Recommendation: build it first for CH only, behind a switch, with Escape leaving no hatch. On a job, picking a rectangle would show the hatch live and wait for Apply instead of placing it at once."

### 2. Tests (focused only, one test project per command, `--filter` on each)

1. `Bug1129BarWeightOneTableTests` + `S44NewSwitchDefaultsTests`: 16 passed, 0 failed (12 new).
2. 103 passed in neighbouring Rebar/Reo/guard classes (UncitedEngineeringTablesGuard, KeywordShortcutGuard, Bug367/368/369, FootingUnitsGuardSource, RebarDrawingUnits, ReoEntryRules, LabelTextHeightRule).
3. BUG-579 branch: `Bug579FootingDepthKeptTests` + S44/S45 defaults + guards: 42 passed; footing-area classes and source guards: 163 passed. Test counts were not zero.
4. Switch defaults checked through both start-up reads (normal tolerant read and the value-by-value path with a damaged value), switch typed OFF stays OFF, switch OFF returns old behaviour (1482.0 kg; depth 0).
5. net48 compile of `CE_STRUC_SUITE.csproj` Release: 0 errors, 0 warnings, on both branches.
6. NOT run: the full Structural suite (job rule), Manager, Civil, anything in AutoCAD.
7. Commands used a scratchpad runner (`C:\ce-scratch\s12\run.ps1`, not in any repo): below-normal priority, top-level dotnet count 0 or 1 checked before each, C: free space at least 12 GB checked (52 GB free), `-m:2 -p:SkipDevBundle=true -nr:false --disable-build-servers`, refuses a test command that names a solution or has no `--filter`.

### 3. Robot cases that would prove them (names in the N31_dp_time / C31 style)

1. **S12_barweight_one_table** (proves BUG-1129). Types `BARWEIGHT`, picks N20, length `6000`, quantity `100`, answers No to "Place result"; checks the command-line line reads `= 1479.6 kg`. Then adds 100 N20 at 6 m to a bar schedule and checks the schedule weight is 1479.6. **Switch-off control:** Settings, `Options.BarWeightUsesBarCatalogue` false before launch (settings are read at start-up), the same typing must read `= 1482.0 kg`. Second check: N40 prints the "not in the bar catalogue" note and still gives a kg figure.
2. **S12_fpfc_depth_kept** (proves BUG-579). Types `FPFC`, label PF2, X `800`, Y `800`, depth `450`, point `-2000,2000`, rotation 0; then `FEDIT` on PF2 and reads the line `Enter new depth <450>` (pass), then cancels and runs `CSFOOTINGSCHEDULE` and checks the PF2 depth cell is `450` not `UNKNOWN`. Then `U` and `REDO` and repeats FEDIT (reads `<450>`). **Switch-off control:** `FootingWidth.FootingDepthKeptOnPlacement` false before launch: FEDIT must read `<0>` and the schedule `UNKNOWN`. Strip variant: `FSF` width 400 depth 300 then FEDIT reads `<300>`.

### 4. Shared-file clashes seen (open Structural drafts)

1. `FoundationService.cs`: no open draft on the 26s base touches it. Older PRs #1792 and #1793 (base `claude/rel-20261025s`) do; they are on an older base and I did not read them.
2. `UserSettings.cs` and `SettingsService.LoadRecovery.cs`: many open drafts add lines (#1907, #1906, #1905, #1904, #1903, #1902, #1901, #1900, #1899, #1898, #1895, #1886, #1885 and others). My lines are one switch each in different places; a textual conflict will be keep-both-sides.
3. `FoundationModels.cs` and `FstMemoryService.cs`: #1898 (size memory per drawing) edits them; I did not. Its size-list changes touch where the depth I read (`Size3`) is stored, so after #1898 lands, re-run the BUG-579 tests.
4. `REGRESSION_LOG.md`: both my PRs prepend an entry to the top; the second to merge needs keep-both-sides.

### 5. Entries to be added elsewhere (not by me)

DESK_LOG.md and BUG_CARPARK.md untouched (job rule). Register entry 143 needs the PR numbers #1908 and #1909.

### 6. Cleanup

Worktree `C:\ce-fx\s12`: bin/obj cleaned with `git clean -fdXq` in my worktree only; `git status` clean; both branches pushed, nothing force-pushed, nothing closed or deleted. Branches in the old `claude/tl2-r120-s12` and `s12pay-local` names belong to other earlier jobs and were not touched.

### 7. Real-files comparison (before the first test at about 03:20, after the last test at about 03:50)

Folders listed (names, sizes, last-write, no contents): `%APPDATA%\TIM_CE_CADTOOLS` (including CE_Admin and logs), `%APPDATA%\CE_STRUC_SUITE`, `%APPDATA%\CE_CVL_SUITE`, `%APPDATA%\CE_CADTOOLS` (including CE_Admin), `%APPDATA%\CE_SUITE`. Before: 32,462 lines; after: 32,481. Full listings: `C:\ce-scratch\s12\before.txt` and `after.txt`.

1. **Settings files: unchanged.** `CE_STRUC_SUITE\CS_Settings.json` 35613 bytes, 30 Oct 19:54:14 (before and after); `CS_Settings.json.PRE_TIM_YES_20261020.bak` 34858, 18 Oct 10:00:24; `CE_CVL_SUITE\settings.json` 672, 16 Sep 12:13:17 and its `.bak` 672; `TIM_CE_CADTOOLS\CD_Settings.json` 15270, 4 Oct 08:22:30 and both `.bak` files; `TIM_CE_CADTOOLS\CS_Settings.json` 351713, 31 Mar 13:18:00.
2. **Changed during my window (53 diff lines): `TIM_CE_CADTOOLS\CD_RecentValues.json` (12222 bytes, 03:27:33) plus CE_Admin session, menu-state and machines files, the CE_SUITE_MANAGER menu `.cuix`, 20 new `CE_Admin\outbox\usage\2026-10-30\usage_*.json` files, the CE logs (`ce_struc_suite.log`, `CE_CVL_SUITE.log`, structured logs, RuntimeDiagnostics, `native_grip_2027.log`) and `telemetry\outbox.jsonl`.** Cause I can establish: an `acad.exe` process (id 63900) started at 03:36:38, which I did not start; its start-up writes logs, session files, the menu file and flushes the usage outbox. `CD_RecentValues.json` (Civil's remembered values, written at 03:27:33, before that session) I cannot attribute: I ran only Structural focused test classes with `CE_STRUC_SUITE_APPDATA_ROOT`, `CE_LOG_DIR_OVERRIDE`, TEMP and TMP pointing at `C:\ce-scratch\s12\...` (echoed before each run), and no Structural test touches Civil's file as far as I know; I did not read every class in the wider filters (source-guard and rule classes). Tim or CE 05 should say whether a robot run was active at 03:27. Per the job rule I am saying so first rather than continuing.
3. No file was found new or changed in `CE_STRUC_SUITE` or `CE_CVL_SUITE`.
