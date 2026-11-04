# BUGFIX w1096 report, 4 Nov 2026 (B-208, Civil, DRAFT-DO-NOT-SHIP)

**FOR TIM**

1. **PR:** #2022, DRAFT, titled "B-208 DRAFT-DO-NOT-SHIP ...", against `claude/rel-20261102a`. Built and unit-tested only. Nobody has opened it in AutoCAD. Nothing is installed.
2. **What you will see:** draw a pipe with Custom grade 1 in 100 and type your own levels that give 1 in 200. Run CDRULES. There is one extra warning row: "Grade typed against chosen: levels typed give 1 in 200, flatter than the 1 in 100 grade chosen when the pipe was drawn." The pipe is never changed or blocked.
3. **Which pipes:** Custom grade, Default standard grade and Default minimum grade pipes drawn from now on. A pipe set to the minimum is only questioned when flatter (steeper is what a minimum allows). Pipes drawn before this, simple pipes and "grade from inverts" pipes keep nothing, so no row.
4. **If you edit the pipe later:** changing its grade choice or Custom value means the kept figure no longer applies, so CDRULES stays quiet rather than quoting an old choice. Correcting the levels only is re-checked against the original choice.
5. **How far off:** the same Settings percentage the pit schedule note already uses (10 as shipped). No new engineering value.
6. **Switch:** `grade.recordChosenGrade`, ships ON. OFF: nothing is stored and no row appears, exactly as before.
7. **This is a DRAFT on purpose.** You said yes against the recommendation (decision 199). The batch gave you the short question, so CE 04 confirms in plain words before it ships. The one thing to confirm: "CE will remember the grade you picked on every new pipe, and CDRULES will warn when your typed levels disagree with it by more than 10 percent."
8. **Mistakes of my own:** (a) my first scratch test script mangled backslashes with sed and then could not find dotnet on the tool PATH: about ten minutes lost, no other cost. (b) I first labelled the change "BUG-1267 follow-up". That was a guess: BUG-1267 is the Recall Last item. This item has no BUG number in the carpark; I corrected every file before committing, and the PR title says decision 199.
9. **NOT proven:** nothing was tried in AutoCAD. The row showing in the CDRULES list and its saved text file, and the kept grade surviving save and reopen in a real drawing, have not been seen. A pipe copied or split (Same-plan break, split halves) does not carry the kept grade, so those get no row (deliberate, quiet).

**Robot case CE 02 should write: `CG1_dp_chosen_grade`** (style of N31_dp_time)

1. **Setup:** fresh drawing, two pits 20 m apart, switch on (default). CD, Custom grade, type `100`, type upstream level 18.000 and downstream level 17.900 (fall 100 mm over 20 m = 1 in 200), accept. Then CDRULES All.
2. **Check:** the saved CDRULES text file has a row titled "Grade typed against chosen" for that pipe, with the words "1 in 200" and "flatter than the 1 in 100 grade chosen".
3. **Switch-off control:** set `grade.recordChosenGrade` to false BEFORE launch (settings are read at start), repeat the same typing. CDRULES All has no such row and the R-03 row is the same as today.
4. **Second control:** same pipe with levels 18.000 and 17.800 (exactly 1 in 100). No row.

## Technical detail

1. **Base:** `origin/claude/rel-20261102a` at 3fbb9da5 (Civil 3.0.88). Not stacked. Fault confirmed on base: `PipeData` keeps `GradeMode` and `CustomGrade` only (`Modules/Drainage/Models/PitData.cs`), and the Default modes store no number at all, so CDRULES (`RulebookEngine.cs` R-03 row) had nothing to compare typed levels with. Not already fixed. No design card or window change needed (no window touched).
2. **Files:** `Rules/ChosenGradeRule.cs` (new), `Models/PitData.cs` (+`chosenGradeN`, `chosenGradeMode`, ignored when null), `Models/UserSettings.cs` (+`RecordChosenGrade`, "Default: on."), `Commands/CdCommand.Schedule.cs` (one `Record` call before `AddPipe`), `Rules/RulebookEngine.cs` (one row after the R-03 row, reusing rule id R-03 with title "Grade typed against chosen", so no new rule id and no catalogue change), `REGRESSION_LOG.md`, `Drainage.Tests/Rules/ChosenGradeRuleTests.cs`. CE_SHARED untouched.
3. **Saved record and fingerprint:** old pipes serialise without the new keys, so their CDRULES fingerprint is unchanged. The switch is not in the criteria fingerprint (same as the other new Checks/Grade switches).
4. **Overlap:** open drafts #1949, #1963, #1971 also touch `RulebookEngine.cs`/`RulesCommand.cs`; my edit is a 5-line insertion after the R-03 call, keep both sides on any conflict. #1919 (w1) is not in this base; this change does not depend on it.
5. **Tests:** `ChosenGradeRuleTests` 17/17 pass (net10, Release, count not zero). It includes the worked 1 in 100 / 1 in 200 example, steeper, within tolerance, tolerance from Settings, default standard and minimum, inverts and simple pipe keep nothing, stale after edit, older record round trip, switch OFF stores nothing and adds no row, and the switch pinned through `DeserializeSettings` and `DeserializeSettingsTolerant`. I added them in their own file rather than the C78 new-switch-defaults table (that table is a fixed three-switch pin with fingerprint hashes).
6. **Wider run:** one filter for Settings, Rulebook, Bug857, Bug331, NewSwitch, Fingerprint and PipeData names: 21,607 passed, 32 skipped, 1 failed: `CivilHelpHostTests.AcceptedCommandContextFailure_CompletesOnceWithoutFallbackStart` (help window host, unrelated to grades). It passed 9/9 when the fixture was run alone, so it is order or timing dependent. I did not compare it against the base run, so "pre-existing" is not proven.
7. **net48 compile:** `CE_CVL_SUITE.csproj -f net48`, 0 errors, 246 warnings (existing).
8. **Commands:** every dotnet call used `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, one test project and a `--filter`, below-normal priority, slot count 0 before each, C: 72 GB free. No Manager tests. No AutoCAD, Codex or accoreconsole.

## Isolation listings (rule 1)

CE_LOG_DIR_OVERRIDE, TEMP, TMP set to `C:\CE_WORK\scratch\w1096\...` and echoed before every test; `CE_STRUC_SUITE_APPDATA_ROOT` set too. Full listings (name, size, last write) were taken before the first test and after the last; per folder, before then after:

1. **CE_CADTOOLS** (includes CE_Admin): 1023 files, 110,300,866 bytes both times. ONE file changed: `CE_Admin\sessions\CE_SUITE_MANAGER.json`, 228 bytes, last write 07:11:27Z to 07:25:27Z (6:25 pm Melbourne).
2. **TIM_CE_CADTOOLS** (outbox 31,414 files, logs): 33,070 files, 1,149,628,570 bytes both times, newest 06:19:19Z both times. Unchanged.
3. **CE_STRUC_SUITE:** 2,513 files, 2,104,696,107 bytes both times, newest 06:24:37Z. Unchanged.
4. **CE_CVL_SUITE:** 390 files, 78,641,751 bytes both times, newest 06:24:23Z. Unchanged.

**The one changed file:** `CE_SUITE_MANAGER.json` is a Manager session record. I ran no Manager tests, and nothing in `Modules/Drainage` or its tests names that file. An `acad` process was running on the PC at 6:26 pm, a likely writer (an open AutoCAD with the Manager loaded). I cannot prove my run did not write it, so I am flagging it as asked: it looks like a live heartbeat that moves about every 14 minutes, not from this job.

## Cleanup

Worktree `C:\CE_WORK\build\w1096` and scratch `C:\CE_WORK\scratch\w1096` removed after this report was pushed; C: free space is stated in the final summary.
