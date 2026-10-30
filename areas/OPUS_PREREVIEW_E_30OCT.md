# Opus pre-review E: the PRs that missed C-77 (#1854, #1855, #1857, #1858, #1863, #1867, #1868, #1869), Fri 30 Oct 2026, about 12:20 to 12:50 Melbourne

Read-only review by Opus 5.5. Train read: `claude/rel-20261030a` at head `c87249c6`. Each PR read with `gh pr diff` at its live head, plus the surrounding code on the train, the fix reports in `C:\CE_PLAN\areas`, the build register, the C-77 assembly report, and pre-reviews C and D. No build, no test run, no AutoCAD. **No open PR numbered #1870 or higher exists** (checked 12:19; #1869 is the newest).

---

## FOR TIM

1. **Answer first: two of the eight are ready for a C-77b train tonight, one more is ready after a small re-base, and the rest belong in C-78.**
   1. **Ready:** the pit copy fix (#1867) and the Grade mismatch box Cancel (#1858). Both are built and tested, and both merge onto C-77 with no clash except the change log.
   2. **Ready after a re-base:** the CDRULES "cover between the pits not checked" line (#1869). It was built on the older cover fix and now clashes with the newer one.
   3. **C-78:** the pipe sizer (#1863) and the large-pipe fall (#1868) go together. The comma refusal (#1857) has never been compiled. The council data (#1854) and the soakage engine (#1855) need a hand merge.
2. **The pit copy fix (#1867) does stop the theft in the case the robot found.** When a copy lands on P3, any pit that is not already joined to a pipe end now steps aside. P3 is already joined to its five pipe ends, so it keeps them all. The copy gets none, and one line says so: "P11 sits on pipe ends already joined to P3; they stay joined to P3." It also covers the second command, where the earlier copy P11 sits even closer to P3's pipe ends than P3 does.
3. **What it does NOT do.** It does not repair a drawing that already lost pipes to a copy on Civil 3.0.84 to 3.0.86. Those pipes now belong to the copy, so the copy keeps them. Anyone who copied a pit onto a pit in the last week should check that pit's pipes in the Inspector.
4. **One merge trap the finalizer must not miss (the pipe sizer, #1863).** Its clash with C-77 looks like "keep both lines", but keeping both the obvious way silently breaks two settings. After any Settings save, every saved CDRULES run would then say "out of date". Exact fix below (item 2.5).
5. **One proof text is wrong (the pipe sizer).** The build register says the Codex look should see "DN225 near 1 in 200". The fix gives DN225 at 1 in 100, because your guidebook ruling made 1 in 100 the flattest fall for ordinary sizes. Change the proof text before Codex runs it, or Codex will mark a correct result as FAIL.
6. **One thing that may need your word (#1869).** The bug list still says BUG-902 "needs Tim's word". I found no quote from you approving the extra line. It adds one grey Unknown line per pipe, so a 30-pipe job shows 30 more Unknowns in CDRULES. If you have not said yes, it waits for you.

What I did not check: nothing was built, run or opened in AutoCAD. Every verdict is a code read. All AutoCAD behaviour is unproven.

---

## 1. TOP THREE (for the finalizer and CE 01)

1. **#1867 is KEEP-WITH-NOTE and is the C-77b headline.** The fix is sound for the robot case and safe off the copy route. Its proof is the robot twin in item 3.4. It does not repair drawings already damaged by 3.0.84 to 3.0.86 (item 3.3.1).
2. **#1863 merge trap, `Modules/Drainage/Rules/RulebookValues.cs` (train line about 481 in the fingerprint resolver's `CreateProperty`).**
   1. **The clash:** the train has GB-01 slice 2's four-name `if (...)` (`minCoverBySurfaceMm`, `minCoverPavedSlabMm`, `minCoverPavedSurfaces`, `minCoverCouncilFigureIsFloor`). #1863 adds `if (... "sizerStepsUpBeforeSteepGrade")`. Both share ONE trailing line, `property.ShouldSerialize = _ => false;`.
   2. **Why keep-both breaks it:** the assembler's keep-both method (ours, then theirs) gives `if (slice2) if (bug1088) property.ShouldSerialize = ...`, a nested if. It compiles. Neither exclusion then works. The four cover-table names and the sizer switch all enter the CDRULES fingerprint, so a saved CDRULES run goes Stale on a job that only had a Settings save.
   3. **Fix:** each `if` gets its own `property.ShouldSerialize = _ => false;` line. Then run `Int068*Fingerprint*` and the slice-2 fingerprint tests; they should catch it, but I have not seen them run on that merge.
3. **#1869 must be re-based onto the live B-012b heads before it can join anything.** It was built on #1848 at `3261cf8f`. The live #1848 is `21a3bbb4` (B-012b: an unknown wall reads Unknown), carried by #1850 `d363c129` and #1851 `7c547ebb`. None of the three is in C-77.
   1. Dry run: the train plus the live #1851 head merges with no clash at all. #1869 on top of that clashes in `Modules/Drainage.Tests/Rules/RulebookEngineTests.cs` (both edited the same cover-row tests).
   2. Its tests count "non-Unknown cover rows". With B-012b an unknown wall makes more rows Unknown, so those counts must be re-checked, not just merged.

---

## 2. MERGE ORDER FOR C-77b (onto `claude/rel-20261030a`, dry runs with `git merge-tree`)

1. **B-012b first:** the live #1851 head `7c547ebb` (it contains the live #1848 and #1850). Clean, no clash, not even the log.
2. **#1867** (BUG-1227 Part A): only `REGRESSION_LOG.md` clashes.
3. **#1858** (BUG-857): only `REGRESSION_LOG.md` clashes.
4. **#1869** (BUG-902), only after its re-base onto the live #1848 and a new focused run (`Bug901|Bug902|RulebookEngineTests|RuleSourceEvidenceTests`).
5. **Not tonight (C-78), in this order:** #1868, then #1863 (both stacked on GB-01 slice 1, which C-77 already carries at `ead7c837`; #1868 first so the sizer reads the large-pipe rows), then #1857, then #1854, then #1855.
6. **Clashes between the PRs themselves** (after the train): #1857 with #1868 in `Models/UserSettings.cs` (both add one switch after `declutteredLayout` in PipeSettings; pure additions, keep both). #1854 with #1855 in `Rules/RulebookValues.cs`, `Models/CouncilProfileModels.cs` and `Drainage.Tests/Services/CouncilSweepParityTests.cs`. No other pair clashes.

---

## 3. #1867 BUG-1227 Part A, pit copy keeps off the original's pipe ends — KEEP-WITH-NOTE

Head `a6969702` on base `claude/rel-20261029a`. Built: net10 0 errors, net48 0 errors. Full Civil net10 suite 20,935 with 1 fail (its own BUG-288 guard text), fixed and the class re-run green. The whole suite was not re-run after the fix. Not in AutoCAD.

### 3.1 Does it really stop the stealing? Yes, for the diagnosed path.

1. **The path in the diagnosis:** copy reconcile queues the copy (`LinkService.Utilities.cs:457`, `QueueClonePitRelinks`), then `ApplyPendingPitRelinks`, then `RelinkAllPipesToPitsScoped` (train `LinkService.RepairAudit.Relink.cs:664`). Every candidate pipe goes through `RelinkPipeThroughDirectionWriter` (`:842`), because `ScopedRelinkCandidateRule.UsesDirectionWriter` is true for every kind except `None` (`ScopePitClaimEvidence.cs:95`). That calls `UpdatePipeLinksFromGeometry(db, pipeId, tr, scopePitClaims)`, then `ResolvePipeEndpointOwners`, then `FindBestPitOwnerAtPoint`. The PR threads the guard down exactly this chain (`LinkService.Geometry.cs` diff lines 228, 1024 to 1129, 1220, 1268). The plain `LinkPipeEndpointsToPits` branch (no guard) is reached only for kind `None`, which this route never produces.
2. **Why P3 wins now:** P3 is not a scope pit, so its own pipe list is never cleared (only the copies' lists are cleared, train `:811` to `:823`). `WasPitLinkedToPipeEnd` (train `LinkService.Geometry.cs:1346`) finds P3's record first, or falls back to the pipe's From/To. P3 is the keeper. The copy's own list was emptied by `RemapClonePit` and cleared again by the scope clear, and its project record is new, so the copy is "not joined". `CopiedPitEndOwnerGuard.Decide` then does not offer the copy, and the picker sees only P3.
3. **Second command (SCALE Copy after ROTATE Copy):** P11 from the first command got nothing, so it is "not joined" and also steps aside. That is why the builder widened the rule from "the copy" to "every pit not joined to the end". This is correct and needed.
4. **Ambiguity flag:** the held-back copy is no longer offered, so `picker.TouchCount` drops to 1 and `IsAmbiguous` is false. The end key is vouched for P3 again. That is the right answer, but it is a behaviour change worth one line in the log.

### 3.2 What could break for a drafter (none found that blocks; three to watch)

1. **Wider reach for the keeper.** A joined pit is tested with `TouchesExistingLink` (the old, wider reach), a new pit with `Touches`. So during a copy relink, a pipe end inside the wider reach of the pit it is joined to stays there, even when the copy sits right on it. Example: a drafter copies a new pit onto the end of a pipe whose recorded pit P5 is a short way off but still inside P5's wider reach. The copy will not take that end. That is arguably right (nothing silently re-wired), and the drafter can still use PIT or CDREPAIR.
2. **Reversed pipes with a missing pit record.** `WasPitLinkedToPipeEnd` matches the pit record by `EndIndex`, else the pipe's From (index 0) or To (index 1). On a pipe drawn against its flow whose pit record is missing, the From/To fallback may not match the physical end, so no keeper is found and the old nearest-wins answer comes back. Old drawings only; not proven either way.
3. **Copy-then-erase-the-original.** If a drafter copies a pit onto P3 to replace it and then erases P3, whether the copy picks up P3's pipe ends is not tested (the diagnosis's open question 3). Before this fix the copy had already taken most of them. Now it has none until the erase relink runs. Put it in the robot case list.

### 3.3 What is missing

1. **No repair of drawings already damaged on 3.0.84 to 3.0.86.** A copy that already holds P3's pipe ends is "joined" to them, so it keeps them. Say so in the colleague known-issues page, and fix the scoreboard line that still advises "use a small offset when copying a pit" (pilot risk plan E1: 0.1 mm still steals).
2. **The new switch `linking.pitCopyKeepsOriginalPipeEnds` is pinned only in the PR's own test file.** It is documented "Default: on." (`UserSettings.cs` +865), so `NewSettingsKeys_NeedADocumentedDefault` passes. The finalizer should add it to the train's newest NewSwitchDefaults list like the other C-77 keys.
3. **The unit tests re-create the owner walk in the test** (`Decide` plus the real `NearestPitPicker` and real `PitOutline` boxes). They do not run `FindBestPitOwnerAtPoint` or `WasPitLinkedToPipeEnd`, which need AutoCAD. So the pit-record read is proven only by the robot twin.
4. **Full suite after the last fix not re-run.** Only the affected classes were. Any C-77b assembly runs the full suite anyway.
5. **Part B (the repeated "Pit schedule cell for C1" lines, BUG-1231) is not in this PR.** C1's lines will still repeat after every pit command. Do not count BUG-1231 as fixed.

### 3.4 The failing twin it must have (robot case, working title N36_rotcopy_on_pit; CE 02 renumbers)

1. **Drawing:** the R34 drawing, the same copy the 3.0.86 run used.
2. **Steps:** pick P3 (handle `109D56`), `_.ROTATE`, base point typed `53777.7,-25569.9` (the ROUNDED point; it puts the copy 0.1 mm off P3), `C`, `90`. Wait. Pick P3 again, `_.SCALE`, same base point, `C`, `1.5`.
3. **The rounded base point is essential.** With an exact snap, the old code may already let P3 win (a true tie goes to the older pit), so the case could pass on the broken build and prove nothing.
4. **Checks (switch ON):**
   1. No command-line line matching `Pit schedule cell for P3`.
   2. The CE log has no `Pipe endpoints updated: 10A901 .* to=P11`, none for `10A98D` and `110136`, and no `109E23 from=P12` and no `110179 .* to=P12`.
   3. Exactly one `P11 sits on pipe ends already joined to P3; they stay joined to P3.` after the first command, and one `P12 sits on pipe ends already joined to P3` after the second.
   4. The R34 label checks for P11 and P12 still pass.
   5. `U` twice puts the drawing back.
5. **Failing twin (must FAIL checks 1 to 3):** the same steps with `linking.pitCopyKeepsOriginalPipeEnds false` in `CD_Settings.json` before AutoCAD starts (control C36, `VARIANT_OF N36`), AND the same case on the installed C-77 build (3.0.87, before the fix). Both must show `10A901 from=WT9 to=P11` and the six-then-nine schedule lines, as the 3.0.86 run did. Without the twin on the old build the Claude-accepted rule's condition (2) is not met.
6. **Two guard cases so the fix is not over-blocking:** (a) copy a pit onto a LOOSE pipe end (no pit joined): the pipe must join the copy, with no "sits on" line; (b) copy P3 5 m away: no line and nothing changes. Both pass on old and new builds; they prove nothing broke.

### 3.5 Conflicts and readiness

1. **With the C-77 train:** only `REGRESSION_LOG.md`. Also clean on top of B-012b.
2. **With the other PRs here:** none.
3. **Chance it is ready for a C-77b train this evening: about 75 percent** (code sound, built, clean merge; the risk is a red full-suite test that only shows on the train).

---

## 4. #1858 B-023 BUG-857, Grade mismatch box Cancel / Esc / X — KEEP-WITH-NOTE

Head `c92db9ad`. Built (B-023b): net10 0 errors, net48 0 errors, 9 of 9 new tests pass. Full suite 20,815: 1 fail, `CeMessageCentreTests.WorkQueue_DrainGivesUpAtTheTimeout`, a timing test in code this PR does not touch. It was green on the C-77 train run, so it is load-dependent.

1. **Behaviour checked:** `Dialogs/GradeMismatchDialog.xaml.cs` starts `Choice` at `WhenDismissed(closeCancels)`, so the X (no button) reads Cancel with the switch ON and Keep with it OFF. Esc is bound to `EscapeCommand`, which picks Cancel or Keep the same way. `Commands/CdCommand.cs:586` returns false before the pipe is built and prints `[CE] Grade mismatch box cancelled - no pipe placed...`. Switch OFF is exactly the old behaviour.
2. **What could break:** the box gains a third button (90 px plus an 8 px gap) and one more sentence. On a narrow fixed-width box or at 150 percent scaling it could clip. That needs the Codex look the report already lists.
3. **Missing:** the switch `grade.mismatchBoxCloseCancels` is not on the Settings page (same as its neighbours) and is pinned only in its own test file. The finalizer adds it to the NewSwitchDefaults list.
4. **Conflicts:** `REGRESSION_LOG.md` only, on the train and on train plus B-012b.
5. **Proof:** robot N33_grade_mismatch_x with control `_off`; Codex look for the three buttons. Tim's UX-WIN-01 ruling ("Esc = Cancel") covers the choice.
6. **Chance ready tonight: about 85 percent.**

---

## 5. #1869 B-026 BUG-902, CDRULES "cover between the pits is not checked" — FIX-FIRST (re-base), then KEEP-WITH-NOTE

Head `bdec2fd1` on `fb/cover-to-pipe-outside` at `3261cf8f`. Built: net10 focused 66 of 66 after fixes, full suite 20,852 with 5 fails on the first run (all fixed, full suite not re-run), net48 compile 0 errors.

1. **FIX-FIRST:** re-base onto the live #1848 `21a3bbb4` (B-012b) and re-run the focused tests (item 1.3).
2. **What the drafter sees:** one extra grey Unknown row per gravity pipe (`Rules/RulebookEngine.cs` +513), sorted first because CDRULES sorts by outcome. The summary line (`RulebookEngine.Summarise`, train `:353`) counts it, so "0 warnings, 0 unknown" becomes "0 warnings, 30 unknown" on a 30-pipe job. Together with B-012b (unknown wall) and GB-01 slice 3 (pit depth Unknowns), CDRULES gets much louder on every job.
3. **Handled well:** the fix advisor offers no fix for it (`RuleFixAdvisor.cs` +60), and the levels check ignores it (`RulebookLevelsCheck.cs` +138). `RuleFixPlanner.Plan` refuses non-Warn findings anyway. The proposal path only plans Warn rows.
4. **Needs Tim's word?** `BUG_CARPARK.md` BUG-902 says "Needs Tim's word (after 9 Nov)", and the Codex ledger batch of 23 Oct skipped it for that reason. I found no quote of Tim approving it. The register lists B-026 as "Build now". Before it ships, CE 01 should name the decision it rests on, or put it in the questions batch (CE 04).
5. **Missing:** the switch `cover.rowSaysUnknown` is not part of the CDRULES fingerprint (the cover group is kept out, per #1848), so a saved CDRULES run from C-77 will not go Stale although a re-run shows more rows. Low.
6. **Chance ready tonight: about 45 percent** (re-base plus the possible Tim decision).

---

## 6. #1863 B-020 BUG-1088, sizer steps up a size before a steeper grade — KEEP-WITH-NOTE, C-78

Head `30990e61` on GB-01 slice 1's OLDER head `78fda55b` (the train has `ead7c837`). Built: net10 only, focused 72 of 72. **Full suite NOT run, net48 compile NOT run.**

1. **Behaviour:** `Services/PipeSizingSolver.cs` new three-argument `TrySize`; with the switch ON a first pass takes the smallest size whose result is no steeper than that size's minimum grade (`Rules/SizerGradeLadderRule.cs`). Callers switched: CDDESIGN connection pipe (`AutoDesignService.cs:683`) and network design plus its re-validation (`NetworkDesignService.cs:96, 294, 543`, one switch read for both, good). Edit Pipe strip and Project Review keep the old two-argument call.
2. **Merge trap:** item 1.2. FIX-FIRST at merge time.
3. **Proof text wrong:** register line 86 expects "DN225 near 1 in 200"; the fix gives DN225 at 1 in 100 (the slice 1 ladder). Correct the H8 proof before Codex runs it.
4. **Engineering point, not a defect:** the first pass always lays the chosen size at its minimum grade. On a site falling much faster than 1 in 100, the connection pipe loses cover towards the downstream end. The old sizer did not look at the ground either. Tim's decision 37 "yes" covers the method; the H8 look should note the cover on a steep example.
5. **Missing:** full suite, net48 compile, the switch in the NewSwitchDefaults list.
6. **Chance ready tonight: about 35 percent.**

---

## 7. #1868 BUG-1091, redesign reads the large-pipe minimum fall — KEEP-WITH-NOTE, C-78

Head `c88cd7dc` on `78fda55b`. **NOT built, NOT run** (the job's `focus7.log` was never written; `C:\ce-fx\b019` holds only empty early logs).

1. **Behaviour:** `Services/SettingsSizingStandards.cs` `GradeLadder` now lets the DN450-and-up rows through for `ForEveryMaterial` when `pipe.largePipeRedesignReadsMinFall` is ON. Those rows exist only when the large-pipe row has a figure, so a blank row changes nothing. `office.LargeGravityFromMm` exists on the train (`UserSettings.cs:2545`) and on `78fda55b`, so it should compile.
2. **Goes with #1863:** merge #1868 first, so the sizer's "flattest allowed" for DN450+ is the large-pipe figure.
3. **Small:** the file loses its final newline. Cosmetic.
4. **Missing:** any build or test at all.
5. **Chance ready tonight: about 25 percent.**

---

## 8. #1857 B-011 #1788 extras, comma figure refused and unset material speed — KEEP-WITH-NOTE, C-78

Head `09a6d1b8`. **NOT compiled, NOT tested** (`1788_EXTRAS_REPORT.md` line 7; no later build section).

1. **Comma refusal:** `Rules/TypedFigureCommaRule.cs` new; `Rules/PipeStartReadiness.cs` `FirstCommaFigure` sits after the material check, looks only at boxes the pipe uses. The "1,200" case names both readings and guesses nothing. Good. The constructor and helpers I read should compile (`RuleValue(double, RuleValueSource, string, bool, RuleSourceEvidence = null)` exists, train `RulebookValues.cs:23`).
2. **Unset material speed:** `RulebookValues.ScourVelocityForCheck` gives a material whose own figure is 0 the office figure. That changes a CDRULES answer: a pipe that read "no scour cap" now gets a speed warning. Tim agreed ("agreed to two small extras"). The new value carries no source evidence (5th argument omitted, like the unknown-material line at train `:511`), so "Show exact source" for it is thin. Low.
3. **Conflicts:** `Models/UserSettings.cs` with the train (PipeSettings, after `declutteredLayout`, pure additions) and with #1868 (same place).
4. **Missing:** compile, focused tests, full suite, net48.
5. **Chance ready tonight: about 30 percent.**

---

## 9. #1854 GB-02 part A council data — KEEP-WITH-NOTE, C-78

Head `07fdd419`. Pre-review C's two MEDIUM notes are answered in this head (Cardinia's method now Assumed; Port Phillip's effect stated in numbers in the log). Built on its own base earlier (net10 full 20,814, net48 0 errors).

1. **Conflicts with the train:** `Models/CouncilProfileModels.cs` (both add after `DetentionMinGradeN`, pure additions) and `Drainage.Tests/Services/CouncilSweepParityTests.cs` (the last list entry's comma: a hand merge). Opus job team_opus_o8 is writing the merge plan for #1854 and #1855.
2. **Watch at merge:** `Assets/Config/council-profiles.json` auto-merges with #1855 (git saw no clash). An auto-merged JSON file can still be broken by a missing comma. Parse it after the merge, and run `CouncilProfileServiceTests`, `KingstonStormFrequencyTests` and `Gb02CouncilDataTests` (the profile count goes 22 to 28).
3. **Engineering:** every Port Phillip job now gets a sized tank from Assumed office figures. Data, not a switch (Tim item 27 "follow book").
4. **Chance ready tonight: about 30 percent.** Not pilot-critical tonight.

---

## 10. #1855 GB-03 slice 4 soakage engine — KEEP-WITH-NOTE, C-78 (or later)

Head `8d40c424`, unchanged since pre-review C. Nothing a drafter can see (no window calls it).

1. **Still open from pre-review C:** with an Unknown soil factor the rows show outflow 0 and a "governing" 7-day storm. Must be fixed before any window or sheet shows the rows; harmless while engine-only.
2. **Conflicts:** the train (`CouncilProfileModels.cs`, `CouncilSweepParityTests.cs`, `UserSettings.cs`) and #1854 (`RulebookValues.cs` fingerprint name list line, plus the same two files). Merge #1854 first.
3. **Chance ready tonight: about 25 percent**, and there is no reason to rush it.

---

## 11. WHAT I DID NOT DO

1. No build, no test run, no AutoCAD, no robot or Codex look. Every verdict is a code read.
2. I did not read the full test files, only their names and the harness for #1867.
3. Dry-run merges used `git merge-tree`. I fetched the eight PR heads into `refs/remotes/pr/<n>` (the namespace the assembler already uses) and made ONE unreferenced temporary commit object (`3f5c19d8`, the train plus the live B-012b chain) only to dry-run on top of it. No branch, working tree or remote was changed; the object is unreferenced and will be cleaned up by git.
4. I did not check whether the CDRULES fingerprint includes the `pipeSpeedChecks` group (#1857).
5. I did not find a Tim quote for BUG-902 (#1869); I searched CE_PLAN for "BUG-902" and "B-026" only.
