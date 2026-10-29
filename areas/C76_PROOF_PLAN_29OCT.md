# C-76 robot proof plan: what the robot checks after tonight's install (Thu 29 Oct 2026)

Job `CE_ACAD / robot / draft / 21` (CE 02 Robot and Codex Testing, Team, Opus, headless). Real clock 12:58 to about 13:20 Melbourne. Read and write documents only. Tim's AutoCAD was open and in use and was not touched: no AutoCAD start, no run or run-pack, no driver call, no settings guard, no lock (the AutoCAD count read 1 before and after my offline checks). Source read with `git show` / `git grep` / `git diff` only, at `origin/claude/rel-20261029a` (nothing checked out).

## ANSWER FIRST

1. **The robot job is ready:** `C:\CE_PLAN\desk_jobs\tester_run80_c76_proofs.txt`. It is NOT in ROBOT_QUEUE.txt (the desk adds it). It refuses to run unless Civil 3.0.86 is installed.
2. **Proofs first, then everything:** three bug proofs, each twice in separate AutoCAD starts with a switch-off run that must show the old fault, then all 66 accepted checks again. **About 49 AutoCAD starts, about 8 h 15 min** plus any stalls.
3. **Decision: FULL, not AREA.** C-76 touches shared parts of CE, not just the four tools CE 01 named.
4. **One finding that matters:** robot case R09 cannot pass as written even if the double-click fix works. I wrote a corrected copy, R09s, beside it.
5. **New DP-time case is N36,** not N31 (N31 is taken). Its switch-off twin is N36_BROKEN.

## FOR TIM

1. **What the robot checks after tonight's install.**
   1. **Double-click a downpipe (BUG-859):** it places DP1, double-clicks its circle with the real mouse, and checks CE's small "Edit source" window opens and AutoCAD's "Enhanced Attribute Editor" never does.
   2. **CDCHECK words (BUG-372):** it runs CDCHECK on the test drawing and checks no line says "handle 1197BB" or "CE-CIV-PIPE-6A33...". An unnamed pipe should read "An unnamed pipe flows to WT4".
   3. **DP speed (BUG-1228):** it places one downpipe at 150000,-80000. Each drawing read must take under 1.5 s and the whole DP under 10 s. On today's 3.0.85 it takes about 30 s.
2. **Why each check runs with the fix switched off too.**
   1. **Example:** with the DP speed-up turned off, the same downpipe must take about 30 s again.
   2. **What it proves:** the check can tell the fix from the fault. A check that passes either way proves nothing.
3. **One finding: R09 cannot pass as written.**
   1. **What is wrong:** R09 looks for buttons called "Cancel" and "OK" and a box called "Tag". The real Edit source window calls them "Cancel source changes", "Accept source changes" and "Source tag".
   2. **What that means:** even if the fix works, R09 stays red. The robot still runs it, and reports its window checks one by one.
   3. **What I did:** I wrote R09s, the same route with the real names. R09s is the case that can prove the fix. R09 itself is untouched; its owner gets the exact replacement lines below.
4. **Why the robot re-runs all 66 checks tonight (FULL).**
   1. **CE 01 said** only four tools were touched. The real file list says more.
   2. **The double-click fix** sits in the service that handles a double-click on any CE pit, pipe or source, not only downpipes.
   3. **The DP speed fix** sits in the part that works out which pit a pipe end belongs to. CD, PIT and the repair commands use that part too.
   4. **The About window fix** is in the Manager, which installs and loads CE.
   5. **Your rule (29 Oct):** a shared part touched means everything. So no check is "carried from 3.0.85".
5. **Time.**
   1. **49 AutoCAD starts, about 8 h 15 min,** plus stalls. Started after the install (about 17:45), it should finish by about 02:00 to 03:00.
   2. **It stops by itself** before your 08:30 start (no new start after 07:50, nothing after 08:10).
6. **What only a Codex look can show: the About window (BUG-090).**
   1. **The fix:** CE_VERSION's About window now grows to fit Civil, Structural, Manager, AutoCAD and Runtime, the hover hint and Close.
   2. **Why not the robot:** a window is never accepted by a machine. Codex must look at it, at 100 and at 150 percent display scaling.
7. **What you need to do: nothing.** The desk queues the job; CE 02 sends Codex the About window look.

---

## Detail

### 1. Switch names and defaults, checked against the train source (`5888ee75`, the version commit on top of the GO head `adcd57e4`)

1. **The branch has moved one commit since the GO:** `origin/claude/rel-20261029a` is now `5888ee75` "Version: Civil 3.0.86 / Manager 1.1.86 (C-76)". `adcd57e4` is its parent; `git diff adcd57e4 5888ee75` touches only the four version lines (both `PackageContents.xml` and both `.csproj`). The installed DLL should read `3.0.86+5888ee75...`.
2. **`doubleClick.sourceStopsAttributeEditorFirst`:** `Models/DoubleClickSettings.cs` line 51, default `SourceStopsAttributeEditorFirstDefault = true`. Right.
3. **`checks.cdcheckLinesShowNoInternalIds`:** `Models/UserSettings.cs` line 3320 (group `checks`, line 173), default true. Right.
4. **`linking.sourceLandingReadsEachObjectOnce`:** line 648, default true. **`linking.sourceLandingTimingLog`:** line 656, default false (log only). Right.
5. **`options.compoundBehaviorEnabled`:** line 1812 (class `OptionSettings`, group `options`), default `CompoundBehaviorDefaults.Enabled` = true. The finalizer fix `7e81ac51` reads it in `OnDocumentLockModeChanged` and returns before any drawing read when it is OFF. Right.
6. **Manager `aboutWindowFitsItsRows`:** `Services/CeOneGlanceStatus.cs` line 260, in `%APPDATA%\CE_SUITE\manager-switches.json`; anything but a plain false reads ON. Right.
7. **Log lines the cases rely on (exact source text):**
   1. **BUG-859, stopped:** "TryRedirectToCdEdit: EATTEDIT stopped before AutoCAD's attribute editor opened (BUG-859, doubleClick.sourceStopsAttributeEditorFirst); source DP1" (`Rules/DoubleClickAttributeEditorStopRule.cs` line 50), written by Serilog, so it is in the structured log (runner key `civilx`), `CompoundEditModeService.cs` line 972, followed by the existing "target registered; CDEDIT scheduled at Idle" (line 973).
   2. **BUG-859, switch OFF:** "TryRedirectToCdEdit: EATTEDIT left to start: doubleClick.sourceStopsAttributeEditorFirst reads OFF" (line 928).
   3. **BUG-1228:** "[BUG-1228] Source landing index read in N ms[ (refused)]: ... reads each object once: on|off." and the same with "Source change read" (`SourceLandingSpeedRule.TimingLine`; callers `LinkService.SourceLanding.cs` 333 and `LinkService.SourceChangeCapture.cs` 163), written by `LoggingService.Info`, so it is in `CE_CVL_SUITE.log` (runner key `civil`) and the structured log. `LoggingService.Log` is not gated by the diagnostic switch.
   4. **DP total:** "Command outcome: DP completed N ms" (`CommandOutcomeLogService.cs` line 120, `options.commandOutcomeLines` default ON, also `LoggingService.Info`).

### 2. The three existing cases against the new code

1. **R09** (`cases\R09_dp1_double_click_edit_source.case.txt`, SHA-256 `8763A665A9C3EEFB8E04AFFED95632E407945453E05158982DB28F41872C9B74`; review `A8B3B729...`, which reviewed an older file hash `E08D4711...` and gives VERDICT FAIL = real fault on 3.0.72; the reviewer asked to fix the Tag box name, assert Cancel closes, add the red centre and the DP text, and said the window look needs Codex).
   1. **Does it reach the new code?** Yes. It sets DBLCLKEDIT 1 and `doubleClick.sourceEditWindow true`, places DP1 and double-clicks its outer circle. Tim's real `CD_Settings.json` has no `sourceStopsAttributeEditorFirst` key, and a missing key reads ON, so the new lock handler is live.
   2. **It cannot PASS even if the fix works.** The window (`Dialogs/SourceEditDialog.xaml`) has the title "Creative Engineering | Edit source"; its tag box is named "Source tag" (AutomationId `SourceEdit.Tag`); its buttons are "Cancel source changes" (`SourceEdit.Cancel`) and "Accept source changes" (`SourceEdit.OK`). The runner's `control` check matches by name or AutomationId exactly, so `control $es "Tag"`, `"Cancel"` and `"OK"` find nothing.
   3. **The Cancel press is refused too:** the window is on the v3 read list only through the `Creative Engineering*` entry (press list: Cancel without saving, Cancel, Close). `ui-press "Edit source" "Cancel"` finds no button named or id'd "Cancel", so `window-closed $esc` fails. The `Edit source*` entry never matches the real title.
   4. **Exact replacement lines for the case owner** (do not apply until reviewed; R09s below already uses them):
      1. `control $es "Tag" value "DP1"` becomes `control $es "SourceEdit.Tag" value "DP1"`
      2. `control $es "Cancel" exists` becomes `control $es "SourceEdit.Cancel" exists`
      3. `control $es "OK" exists` becomes `control $es "SourceEdit.OK" exists`
      4. `ui-press "Edit source" "Cancel" -Optional -> $esc` becomes `ui-press "Edit source" "Close" -Optional -> $esc` (and the same for `$esc2`): the title-bar Close is on the press list. DERIVED: not yet seen on this window.
      5. Add `log civilx has "EATTEDIT stopped before AutoCAD"` (the new handler's own line).
      6. After two passing starts and a review: drop `EXPECT-FAIL BUG-859` and rewrite the first NOT_AUTOMATED line (the Tag box name is now known from the XAML).
      7. The alternative (add "Cancel source changes" to the press list) is an allow-list change, pinned by SHA-256 in the driver; not recommended for tonight.
   5. **Its twins now:** `variants\R09_off_broken` (SHA-256 `93283A5F...`, `doubleClick.sourceEditWindow false`) is still a valid red (the new handler needs that switch ON; the older path logs no "CDEDIT scheduled" line, so check 2 fails as on 3.0.78), but it does NOT test the new switch. So I wrote two new controls (section 4).
2. **R22** (`cases\R22_cdcheck_words_no_internal_ids.case.txt`, SHA-256 `8C3D7C746AD46DE73F7F630E6D8233442651A1EF129C469276B85E7C0D8FC835`; no review.txt exists, so it is not counted until reviewed).
   1. **Does it reach the new code?** Yes: CDCHECK with Enter (All). On 3.0.85 (runs `RUN-20261029-0718-C3.0.85-aX9` and `-0727-bX9`) only check 2 ("FALL arrow, handle 1197BB") and check 3 ("1. CE-CIV-PIPE-6A33BA73-... flows to WT4") failed.
   2. **With the switch ON both go:** `SpineCheckCommand.cs` line 110 prints `CdCheckLineWordingRule.RowText` (an unnamed side becomes "An unnamed pipe"), line 119 prints the FALL lines through `WithoutHandles` (removes ", handle 1197BB"), line 121 the pipe-end lines without "(handle ...)". The other printed lines (fit review, unreadable record, saved-list path, shared Checks line) carry no handle text in the source.
   3. **No line of R22 must change for the new wording:** its checks are all "absent" checks. Suggested for its owner (not applied): replace the EXPECTED text (it still quotes 3.0.73 and "Pipe 150 (handle 10A86B)"); after two passes and a review, drop `EXPECT-FAIL BUG-372`; optionally add the positive lines `history has "An unnamed pipe flows to WT4"` and `history has "FALL arrow points away from the nearest grated pit P4"` (DERIVED from the rule and the fix report, not yet seen).
   4. **Edge case, not expected on this drawing:** an arrow with an empty handle would print ", handle , points" and keep "handle " (the remover needs hex digits).
   5. **Its twin:** there was none; I wrote `R22_off_broken` (section 4).
3. **The runner reports a PASS of an EXPECT-FAIL case** as "now passes: candidate"; it does not count as accepted until the tag is dropped and the case reviewed.

### 3. AREA or FULL (rule: `RETEST_AREA_MAP_29OCT.md` section 4 with Addendum 1)

1. **Changed files, installed commit `09126560` (Civil 3.0.85) to `adcd57e4`:** 24 files. Dropped as never counted: the 7 test files and `REGRESSION_LOG.md`. The version commit `5888ee75` adds only the four version files, each changing only its `<Version>` or `AppVersion=` line (dropped by the rule).
2. **Each product file and where the map puts it:**
   1. `Modules/Drainage/Commands/SpineCheckCommand.cs`: area 10 (Checks).
   2. `Modules/Drainage/Models/DoubleClickSettings.cs`: settings model; `git diff` shows **13 lines added, 0 removed**, one new switch block (doc comment, `[JsonProperty("sourceStopsAttributeEditorFirst")]`, property, default constant). New-switch exception applies.
   3. `Modules/Drainage/Models/UserSettings.cs`: **29 added, 0 removed**, three new switch blocks (`sourceLandingReadsEachObjectOnce`, `sourceLandingTimingLog`, `cdcheckLinesShowNoInternalIds`). New-switch exception applies.
   4. `Rules/CdCheckLineWordingRule.cs`: callers `SpineCheckCommand.cs` (area 10) and `FallArrowDirectionReviewService.cs` (in no area).
   5. `Rules/DoubleClickAttributeEditorStopRule.cs`: caller `Services/CompoundEditModeService.cs`: **SHARED** (section 3 item 8, `Services/Compound*`).
   6. `Rules/OwnerScanMemo.cs`: callers `LinkService.Geometry.cs` (**SHARED**, linking engine core) and `LinkService.SourceScanMemo.cs` (no area).
   7. `Rules/SourceLandingSpeedRule.cs`: caller `LinkService.SourceScanMemo.cs` (no area).
   8. `Services/CompoundEditModeService.cs`: **SHARED** (overrules and compound, item 8).
   9. `Services/FallArrowDirectionReviewService.cs`: **no area** (unknown means FULL).
   10. `Services/LinkService.Geometry.cs`: **SHARED** (core, item 3). It holds `FindBestPitOwnerAtPoint` and `FindBestTaggedOwnerAtPoint`, which every pipe-end owner lookup uses (`ResolveOwnerAtEndpoint`, `FindOwnerAtPoint`, the repair relink).
   11. `Services/LinkService.SourceChangeCapture.cs`, `Services/LinkService.SourceLanding.cs`: area 8 (sources; SourceLanding also area 7).
   12. `Services/LinkService.SourceScanMemo.cs`: **no area** (a new file).
   13. `Services/PipeEndReviewService.cs`: area 5 (sync and repair).
   14. `Modules/Manager/Services/CeOneGlanceStatus.cs`, `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml.cs`: **SHARED** (item 11, `Modules/Manager/**`).
3. **Decision: FULL.** Reason: SHARED files touched (`CompoundEditModeService.cs`, `LinkService.Geometry.cs`, two Manager files) and two product files in no area (`FallArrowDirectionReviewService.cs`, `LinkService.SourceScanMemo.cs`). The settings changes alone would NOT force FULL (additions only, Addendum 1).
4. **CE 01's touched-area list, corrected:** double-click on a downpipe, CDCHECK text, the About window and the DP/OF/floor waste cases are touched, but so are shared parts: the double-click change lives in the compound service that handles double-clicks on every CE object, and the speed change rewrote the two owner-lookup walks in the core geometry file (with the switch's memo only ON inside the two source reads, but the walk code itself changed shape for every caller). The map counts both as SHARED.
5. **Accepted set re-tested:** all 66 (recomputed 13:04 with a read-only copy of the eligibility rule, `C:\ce-fx\c76proofs\eligible_c76.ps1`, output `eligible_c76.txt`: 71 reviews, 66 accepted with matching hash; the same 66 as `spec_full_weekend.txt`). Not counted: R06, R09, R18, R08_broken, R10_broken. Nothing is carried from 3.0.85.

### 4. The new cases (folder `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_c76_29oct\`, each starting "BUILD PENDING: cannot run until Civil 3.0.86 is installed")

1. **Name clash:** CE 01 and the BUG-1228 report call the timing case `N31_dp_time`, but N31 to N34 are batch 4 drafts (`drafts_opus_29oct_b4`) and N35 is batch 5. I checked every case folder and `C:\CE_PLAN` (`ROBOT_MORE_BUTTON_B5_29OCT.md` says "N36 is not used (D05 dropped)"). **The case is N36; its control is N36_BROKEN** (the report's `C31`). I avoided `C36` because `controls\C36e_cdfw_opening_switch_off` exists.
2. **N36_dp_time_under_budget** (`98209E977450D411BDE1101DCE9C4089B67D68DAD973FCF0F4EF349748641935`): DRV1_B1, fresh slot, `SETTING CD_Settings.json linking.sourceLandingTimingLog true`. Route from N04 and N13: `DP{NL}150000,-80000`, Esc at the next prompt. Checks: "Downpipe placed. Tag: DP"; no "could not be refreshed" or "Nothing will be placed here"; one new DOWNPIPE DYNAMIC WITH MASK; the CE log has a "Source landing index read in" and a "Source change read in" line, "reads each object once: on" and never "off"; one pattern that fails if any landing or change read shows 1500 ms or more; "Command outcome: DP completed" with 1 to 4 digits (under 10,000 ms). The new log lines are recorded in full.
3. **N36_dp_time_under_budget_BROKEN** (`27C84F954BD36F5A7578527E295353A08B7AA1357BBFFCFB9E78F2A85E5447A3`): the same plus `linking.sourceLandingReadsEachObjectOnce false`. Must FAIL on the timing checks; its placement checks must pass.
4. **R22_off_broken** (`BACB1EB2E4016435F23FC5D1266D684793E7A5628A00638718AF990CB5202161`): R22 word for word plus `SETTING CD_Settings.json checks.cdcheckLinesShowNoInternalIds false`. Must FAIL on checks 2 and 3; check 1 must pass.
5. **R09s_dp1_double_click_stops_editor_first** (`F790604750671EE941F0C2DA35A4FA7D8718D1F61ABF5929FB8B24B8766EE278`): R09's route word for word, with the replacement lines of section 2 item 1.4, plus "not-contains Enhanced Attribute Editor" again 10 s later. Its four window checks are DERIVED (from the XAML, not yet seen).
6. **R09s_new_switch_off_broken** (`E42A64BD6C9FE0BF0A05307B654517A142C555C2DCF08E263F8BE39F2B0B9067`): `doubleClick.sourceStopsAttributeEditorFirst false`. Must FAIL as the old behaviour (AutoCAD's editor opens; no "stopped" line).
7. **R09s_compound_off_broken** (`25C12EA46E1CBDC038CBED9168CF3FD9EE911C48BAEBE783EAF5C53A1E95DC0F`): `options.compoundBehaviorEnabled false` (the finalizer's fix). Must FAIL (AutoCAD's editor opens; no "stopped" and no "CDEDIT scheduled" line). Compound OFF also turns off the dashed group box, grip guard, group move and group selection; nothing in the case uses them.
8. **Offline format check** (I read `case_runner.ps1`: the `validate` branch calls only `Read-CaseFile` and `Test-CaseFile`; `acad_driver_v3.ps1 -Library` defines functions and runs nothing, line 1154; the AutoCAD count was 1 before and 1 after). Output (`C:\ce-fx\c76proofs\validate_output.txt`):
   1. "ok N36_dp_time_under_budget_BROKEN.case.txt (N36_BROKEN: 9 steps, 13 checks)"
   2. "ok N36_dp_time_under_budget.case.txt (N36: 9 steps, 13 checks)"
   3. "ok R09s_compound_off_broken.case.txt (R09S_COMPOUND_OFF_BROKEN: 28 steps, 14 checks)"
   4. "ok R09s_dp1_double_click_stops_editor_first.case.txt (R09s: 27 steps, 14 checks)"
   5. "ok R09s_new_switch_off_broken.case.txt (R09S_NEW_SWITCH_OFF_BROKEN: 28 steps, 14 checks)"
   6. "ok R22_off_broken.case.txt (R22_OFF_BROKEN: 4 steps, 7 checks)"
   7. "6 file(s) checked, 0 invalid", exit 0. The existing R09, R09_off_broken and R22 also validate ok (12, 12 and 7 checks).
9. **The timing patterns, tested offline** (`C:\ce-fx\c76proofs\regex_test.ps1`, output `regex_test_output.txt`): 8 samples joined the way the runner joins log lines; **8 of 8 right** (all fast passes; 1500, 5123 refused and 12000 fail; DP 9999 passes, 10000 and 29000 fail; a slow line that is not a landing read is ignored).

### 5. The chain spec and the robot job

1. **Spec:** `C:\ce-fx\c75regrade3\spec_c76.txt` (SHA-256 `D43DF0AB3BBA02C364E3F907D62EFFC36FBFD9692AC121253607835F6FE48F37`), format of `spec3.txt`, 33 job lines, every tag unique and starting `a80` or `b80`:
   1. **Proofs, pass a:** `a80R09` (R09), `a80R09s`, `a80T09` (R09_off_broken), `a80C09n`, `a80C09c`, `a80D` (N36, N36 BROKEN, R22_off_broken: three SETTING sets, so three starts in one call), `a80R22`.
   2. **Proofs, pass b:** `b80R09`, `b80R09s`, `b80R22`, `b80N36`.
   3. **FULL:** the 22 lines of `spec_full_weekend.txt` (`a80L` to `a80V`, then `b80L` to `b80V`), without its extras line (R09 and R22 already run above).
2. **Checked offline** (`C:\ce-fx\c76proofs\check_spec_c76.ps1`, output `check_spec_c76_output.txt`, the runner's `-Only` rule copied): every line picks exactly the intended files; **66 of 66 accepted cases once in pass a and once in pass b**; 49 AutoCAD starts (13 proof starts, 36 FULL starts). It prints "faults: 1": that is my checker being stricter than the runner (it counts `N36_dp_time_under_budget_BROKEN` as a prefix match of `N36_dp_time_under_budget`; the runner never prefix-matches a file ending `_broken`, and its file list for `a80D` is exactly the three intended files).
3. **Estimate:** FULL lines about 385 min (the weekend figure of 400 min less its extras line); proofs about 110 min (7 mouse starts, 6 other starts, 11 chain gaps). **About 8 h 15 min** plus stalls. `chain3.ps1` (SHA-256 `EBD9D3BF...`, read, not edited) reads the installed build at its start and aborts on a change.
4. **Job:** `C:\CE_PLAN\desk_jobs\tester_run80_c76_proofs.txt` (Team Sonnet, headless): build check (Civil 3.0.86, Manager 1.1.86, else report and stop), offline validate, CD_RecentValues.json hash before and after (not restored), the stop-times rule, the chain through WMI, a single re-run for a failed main case or a regression, the count from the runner's own JSON, what each proof's right result is, the report path `release-v3-colleagues-RUNNER_C76_PROOFS_REPORT.md`, no edits to reviews, ledger, runner, driver, DESK_LOG, ACCEPTANCE_LEDGER, BUG_CARPARK or ROBOT_QUEUE.

### 6. For Codex (BUG-090, not in the robot job)

1. **CE_VERSION on a copy, at 100 and at 150 percent display scaling:** the window "About CE Suite" shows Civil Suite, Structural Suite, Suite Manager, AutoCAD and Runtime in full, the line "Hover over a version to see which file was loaded." and the Close button; then U leaves no Undo step.
2. **Control:** `"aboutWindowFitsItsRows": false` in `%APPDATA%\CE_SUITE\manager-switches.json` before AutoCAD starts must bring the cut-off rows back (the file does not exist on this PC today; remove it afterwards).
3. **Note:** the Structural add-in's own About window is unchanged and the same fixed size (finalizer question 1).

### 7. What I did NOT verify (RULES 5.9)

1. **Nothing ran in AutoCAD.** Every case here is a draft; every right result is from the source and the fix reports.
2. **DERIVED, not seen:** the Edit source window's AutomationIds and the tag box value reading exactly "DP1"; that its title-bar Close is pressable through UI Automation; the exact CDCHECK wording "An unnamed pipe flows to WT4"; that a new key set by a `SETTING` line (for example `linking.sourceLandingTimingLog`, not in Tim's file today) is written and read (C13 used the same pattern on 3.0.84, but the switch's effect was not proven there).
3. **Whether AutoCAD honours CE's refusal** of the attribute editor: only the run can show it (the finalizer's honest doubt).
4. **The 10,000 ms DP budget** includes the runner's own wait at the next prompt (about 4 s on 28 Oct); a slow night could tip it. The job allows one re-run.
5. **The structured log name** is fixed by date when the runner starts; a runner call that crosses midnight would read the wrong day's file (the R09 family runs first, about 18:00, so this should not arise).
6. **The time estimate** is from the weekend spec's measured medians; the new groupings of the proof lines have not run.
7. **I did not run** the driver self-tests, any runner `run` or `run-pack`, or the settings guard.

### 8. Files written by this job

1. `C:\CE_PLAN\areas\C76_PROOF_PLAN_29OCT.md` (this report, pushed).
2. `C:\CE_PLAN\desk_jobs\tester_run80_c76_proofs.txt` (pushed).
3. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_c76_29oct\` (six case files, section 4; not in any git repository).
4. `C:\ce-fx\c75regrade3\spec_c76.txt` (new; `chain3.ps1`, `spec3.txt` and `tally3.ps1` untouched).
5. `C:\ce-fx\c76proofs\`: `eligible_c76.ps1` and `eligible_c76.txt`, `acc_now.txt`, `validate_and_hash.ps1` and `validate_output.txt`, `regex_test.ps1` and `regex_test_output.txt`, `check_spec_c76.ps1` and `check_spec_c76_output.txt` (read-only helpers and their output).

## Summary

The C-76 robot job is written: R09s (a corrected copy of R09, whose window checks cannot pass), R22 and the new N36 DP-time case each run twice in separate AutoCAD starts, with switch-off controls that must show the old faults, then all 66 accepted checks again. Decision FULL: C-76 touches shared code (the compound double-click service, the core owner lookup, the Manager). About 49 starts, 8 h 15 min. The About window needs a Codex look at 100 and 150 percent. Six drafts validate 6 of 6; nothing ran in AutoCAD.
