# Opus pre-review AB: PR #1841 (B-042, guidebook slice 1, the pipe falls) and PR #1868 (B-019, BUG-1091, stacked on #1841)

Written Saturday 31 October 2026, about 22:25 Melbourne, by an independent read-only Opus reviewer for CE 05 at CE 00's request.
Release tip checked: `claude/rel-20261102a` at `3fbb9da5` (C-78, Civil 3.0.88 / Manager 1.1.88, installed). Heads (`git ls-remote`, 31 Oct): #1841 = `ead7c837`, #1868 = `38c3f825`.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the code and the authors' reports, and ran read-only `git fetch`, `git ls-remote`, `git merge-base` and `git merge-tree` only. `gh` is not on this shell's path, so the PR pages themselves (open/closed state, base field) were not read; the heads come from `git ls-remote`.

## FOR TIM

1. **The brief's starting point is wrong, and it matters.** #1841 is not waiting: it went into C-77 on Friday and is in the build on your PC now (3.0.87, and still in 3.0.88). It also had an Opus review on 29 Oct (review B), and its one fix was made. The GitHub page is still open only because trains merge without closing pages.
2. **What a drafter sees from #1841 today:** every ordinary pipe (90 to 375) is held to 1 in 100, as the guidebook says. A 300 at 1 in 200 now gets a yellow warning in Edit Pipe and CDRULES. In New Pipe, "Standard grade" on a 225, 300 or 375 now drops the far end at 1 in 100, two to three times steeper than before.
3. **450 and bigger:** no warning at all, and the screens say "No minimum fall set for this size". That is your 29 Oct ruling: big pipes get their own figure, and nobody has named it yet.
4. **Detention pipes:** 1 in 200 is allowed only in Darebin, Banyule, Manningham and Maroondah. Elsewhere they are held to 1 in 100. One gap: the Edit Pipe strip does not know a pipe is a detention pipe. So in those four councils it warns on a 1 in 200 detention pipe that CDRULES passes. It is a known gap, written down by the builder.
5. **#1841 verdict: KEEP-WITH-NOTE. It is already in, so it must NOT be merged again in any train.** What it still needs is the Codex look on 3.0.88 (seven checks already written on the test list). Nobody has checked it in AutoCAD yet.
6. **#1868 verdict: KEEP-WITH-NOTE, area plus smoke. It CAN ride C-79a.** The part of #1841 it sits on is already in the line. It merges with two keep-both clashes (the Settings file and the change log). It does nothing until someone types a figure for 450 and bigger. Then Civil Design, the network redesign and New Pipe's suggested grade use that figure too. Today they ignore it: a 450 comes out at about 1 in 890 while Edit Pipe holds it to 1 in 200.
7. **Your call, not urgent:** the 1 in N figure for 450 mm and bigger gravity pipes. Until you name it, #1868 sleeps and big pipes are not checked for a flat fall on any screen.
8. **Not proven:** neither PR has been opened in AutoCAD. I did not test the merges of #1868 with today's New Pipe changes (#1919, #1927, #1928) as one combined trial. I checked them one at a time, and they touch different places.

---

## DETAIL

### 0. Facts that change the brief

1. **#1841 is in the release line.** `git merge-base --is-ancestor ead7c837 3fbb9da5` is true. The train merge commit is `f495fcc5` "Merge PR #1841 (B-042) at ead7c837", also an ancestor of the tip. `C77B_COUNCIL_MERGE_PLAN_30OCT.md` line 188 says "#1841, already in C-77". So #1841 shipped in Civil 3.0.87 (installed 14:29 Fri 30 Oct) and is in 3.0.88.
2. **#1841 has had an Opus pre-review:** `areas\OPUS_PREREVIEW_B_29OCT.md`, section "## #1841 B-042" (line 45), read at head `78fda55b`. Its finding 6 (the hand-edited list did not mark CDRULES runs Stale) was fixed by `ead7c837`, whose title says "(Opus pre-review B)". The hold line in `TRAIN_C79A_PR_LIST_2026-10-31.md` line 36 ("#1841 ... has not been reviewed") is therefore out of date.
3. **#1868 has had an Opus pre-review too:** `areas\OPUS_PREREVIEW_K_1868_BUG1091_30OCT.md` (30 Oct), at the same head `38c3f825`, verdict KEEP-WITH-NOTE. Its condition "ship with or after #1873" is met: #1873's switch `mismatchBoxSkipsOwnSuggestion` is on the tip (`UserSettings.cs` about line 1487).
4. **The stack.** #1868's parent chain is `38c3f825` → `c88cd7dc` → `78fda55b` (an older #1841 commit). `78fda55b` is an ancestor of the tip. So everything #1868 depends on is already on `rel-20261102a`. #1868 adds 2 commits and 4 files over the tip. It does not need #1841 to "go first"; #1841 is already there.
5. **What I could not verify:** whether the #1841 GitHub page still says OPEN, and what #1868's base field says (no `gh`). Closing or retargeting either page is for CE 01, not this review.

### 1. What the drafter sees, against Design Guidebook v1.3 (#1841, read on the tip)

Authority used: `02_COUNCIL_RULES\CE_GUIDEBOOK_V1_3_SUPERSEDES.md` §5 (thumb rules §7.1.18: "Minimum pipe slope 1 in 100") and the GB-01 card `04_REFERENCE\guidebook-cards\GB-01_PIPE_AND_PIT_CHECKS.md` §2 items 1 and 2 and §8 (Tim's answers, 29 Oct item 26). I did not open the guidebook PDF itself; I relied on those two notes. I did not find a memory note named `design-guidebook-v1-3` in this project's memory index.

1. **Ordinary gravity pipes, 1 in 100 at every size: MATCHES.** Settings seed `UserSettings.cs:2554` (`minGradeByDiameter`, 90 to 375 all 100). The one shared reader is `EffectiveMinGradeLadder()` at `UserSettings.cs:2608`, read by CDRULES (`RulebookValues.cs` about line 295) and the sizing screens (`SettingsSizingStandards.cs:135`).
   1. Edit Pipe strip and CDRULES R-03: a 300 at 18 m with 90 mm fall (1 in 200) now warns; at exactly 1 in 100 it passes.
   2. New Pipe "Standard grade": `CdViewModel.Inverts.cs:905-913` reads the same list, so a 300 at 18 m now drops 180 mm, not the 72 mm the old 1 in 250 gave. This is the guidebook figure; drafters will notice it.
2. **An old shipped list in a settings file is moved once: MATCHES Tim's "retire R-03 ladder".** `SettingsService.cs:288` and `:995`. Only a list exactly equal to the old shipped one is replaced; any hand edit is left alone; the "ladder confirmed" tick is cleared. Logged, not shown.
3. **450 mm and larger, own blank row: MATCHES Tim's ruling, DIFFERS from the book's plain words.** The book says 1 in 100 for every pipe; Tim said "bigger pipes get their own figure". `largeGravityMinGradeN` (`UserSettings.cs:2582`) is blank, so:
   1. Edit Pipe strip: "No minimum fall set for this size (DN450) ..." (`PipeGradeAdvisorService.cs:64`).
   2. CDRULES R-03: Unknown with the same words (`RulebookEngine.cs:410`).
   3. Project Review still offers 450 and up (`PipeSizeNetworkReviewService.cs:157`, `:511`).
   4. New Pipe "Standard grade" on a 450: the lookup finds no figure and the far level is not filled in (`CdViewModel.Inverts.cs` returns 0, "a no-op"). I did not confirm what the window says to the drafter in that case. It may simply leave the box empty with no reason given; Codex should look.
4. **Detention pipes, 1 in 200 only in Darebin, Banyule, Manningham and Maroondah: MATCHES** (book pp.41 to 45; Manningham read as 1 in 200 per Tim). `council-profiles.json:602, 665, 782, 840` carry `detentionGuideGradeN` 200; `RulebookValues.cs:383` reads it; `RulebookEngine.cs:394` routes a detention pipe in those councils to R-32 and holds every other council to 1 in 100 under R-03, at every size including 450 and up.
5. **Charged and pumped pipes are not held to the fall rule: MATCHES** (Tim's answer 3). Pinned by `Gb01Slice1FallsTests.ChargedAndPumpedPipes_AreNotHeldToTheFallRule`.
6. **DIFFERS, known gap:** the Edit Pipe strip does not know a pipe is a detention pipe, so in the four councils it warns on a 1 in 200 detention pipe that CDRULES passes. Two screens disagree on the same pipe. Written down by the builder (GB-01 card §9 item 4). It needs its own bug entry if it is not already in the carpark; I did not check the carpark for it.
7. **DIFFERS, open engineering point:** Maroondah's own Table 6 gives 1 in 250 and 1 in 400, flatter than the 1 in 200 used (GB-01 card §9 item 5). For the engineers, not a code fault.
8. **MISSING from slice 1 (by design, other slices):** cover by surface, minimum pit depth, lid class, pipes under garages, pit sizes; also the book's "minimum diameter 100" and "SN8" thumb rules are not part of GB-01 slice 1. Slice 2 (cover) is already on the tip (`8f2d61cd`, per `BUGFIX_x4_REPORT_31OCT.md`).
9. **MISSING: no Settings page rows** for the ordinary list, the large-pipe figure and "applies from 450", or the council viewer label. The values are in the Settings file (R-00 satisfied as data), but a drafter cannot see or change them without editing the file.

### 1b. What #1868 adds to the pipe flow

1. **Change:** `SettingsSizingStandards.ForEveryMaterial` (the one place Civil Design, auto-design, the network redesign and New Pipe's suggested grade get their list; tip line 103) used to keep only the six ordinary sizes. With the switch ON it also keeps the 450-and-up rows, which exist only when the large-pipe figure is set (PR head `SettingsSizingStandards.cs` lines 97-105 and 137-157).
2. **New Pipe:** `CdCommand.GradeSuggestion.cs:381` and `CdViewModel.Inverts.cs:910` both go through `PipeSizingStandards.CreateDefault()` → `ForEveryMaterial`. So once a figure is typed, New Pipe "Standard grade" on a 450 fills the far level at that figure, instead of leaving it empty (point 1.3.4 above).
3. **With the row blank (as shipped): nothing changes on any screen.** Pinned by `BlankRow_NothingChanges_NoMinimumFallSetForLargeSizes`.

### 2. The Settings switch

1. **#1841: no switch, by Tim's ruling** (decision 26 point 4: the old ladder and the every-council rule "are retired when slice 1 is built"). OFF therefore does not exist. The one-way settings move (point 1.2) cannot be undone by a switch; only the settings backup restores the old list. That is consistent with the ruling. Recorded, not a fault.
2. **#1868: `pipe.largePipeRedesignReadsMinFall`, default ON** (`UserSettings.cs` PR head line 1346). Pinned through both start-up reads (`DeserializeSettings` and `DeserializeSettingsTolerant`) with `{}` and a partial `pipe` group, and typed `false` reads false: `Bug1091RedesignReadsMinFallTests.SwitchLoadsOn_ThroughBothStartUpReads`. A missing file or group reads ON (`LargePipeRedesignReadsMinFall => ... ?? true`).
3. **OFF restores the old behaviour exactly:** OFF takes the old filter path unchanged (only the six ordinary sizes). Pinned by `SwitchOff_RowSetTo200_GivesExactlyTheOldAnswer` (count 6, no "450") and `SwitchOff_ThroughSettings_IsReadByTheDefaultPath`. Read by code, I agree.
4. **The switch is read live** (`SettingsService.Current` at each call), not only at start-up. The large-pipe FIGURE still comes from the settings file read at launch, so a robot must set both before AutoCAD starts.
5. **For the C-79 defaults class:** add `pipe.largePipeRedesignReadsMinFall` (ON). No Settings page row (same as its siblings; decision 126 "Switches" tab).
6. **Hard-coded engineering values (R-00):**
   1. **LOW, #1841:** `PipeSizingModels.cs:40-48` keeps a second copy of the 1 in 100 seed in code (`As3500MinGrades`, used at line 87). It matches the Settings seed today, but it is a second place the figure lives (design rule 1). I did not trace every caller of the builder at line 87.
   2. **LOW, #1841:** the list of large pipe sizes the figure is spread over (450 to 2400) is fixed in code (`UserSettings.cs`, `LargePipeSizesMm`). These are pipe sizes, not a design figure.
   3. **LOW, #1841:** the words "1 in 100" appear as a fallback in two messages (CDRULES R-03 detention line and R-32 settings line) when the ordinary list is empty. Display only.
   4. **#1868:** none. It moves no figure; it only stops dropping one.

### 3. No hard blocks (R-27)

1. **#1841:** adds no stop, refusal or window. It REMOVES one: Project Review used to refuse a 450-and-up size "no minimum grade ... cannot be checked"; now it offers it, checked on speed, capacity and cover (`PipeSizeNetworkReviewService.cs:511`). The old refusal for an ORDINARY size with no list entry remains; that is older code, not this PR.
2. **#1868:** no stop, refusal or window. A steeper proposed fall on a big pipe can push upstream pipes deeper and raise more COVER warnings on a flat site (review K point 3); that is the figure working, and only warnings.

### 4. Native AutoCAD protection and REDO

1. **Both PRs change readings only.** No drawing object is written, no layer is touched, no Xref or REFEDIT path is involved, no command, regen, view or system variable change. Nothing for locked layers to protect against.
2. **#1841 writes the settings file** (the one-time list move), not the drawing. That cannot affect REDO.
3. **REDO-safe:** by code reading, yes for both. Not seen in AutoCAD.

### 5. Merges (read-only `git merge-tree`)

1. **#1841 against the tip:** nothing to merge. Its head is already an ancestor of `3fbb9da5`. **Do not list it in any train**; a second merge would be a no-op at best and confusing at worst.
2. **#1868 against the tip (`git merge-tree --write-tree 3fbb9da5 38c3f825`):** two conflicts, both keep-both.
   1. **`Modules/Drainage/Models/UserSettings.cs`, tip line about 1465:** #1868 adds its `largePipeRedesignReadsMinFall` block straight after `EditPipeReverseArrowReadsDrawnEnds` (tip line 1462). The tip has since added the BUG-1229, B-057, BUG-1226 and B-043 blocks at the same spot. Keep the tip's blocks AND #1868's block, one after the other.
   2. **`REGRESSION_LOG.md`, line 1:** keep both entries.
   3. `SettingsSizingStandards.cs` and the new test file merge clean. #1868 also drops the newline at the end of `SettingsSizingStandards.cs` (cosmetic).
3. **#1868 against today's New Pipe PRs:**
   1. **#1919 (B-093, `d12f06d7`) and #1927 (B-095, `1732eb32`, stacked on #1919):** neither touches `SettingsSizingStandards.cs`. Both add their switches in `UserSettings.cs` straight after `mismatchBoxSkipsOwnSuggestion` (tip about line 1487), about 25 lines below #1868's spot, so I expect them to merge cleanly once #1868's own conflict is resolved. **Not proven:** a direct `merge-tree` of #1868 with each shows `UserSettings.cs` and the log conflicting, but that is because #1868 sits on the old base; I did not build a resolved #1868-on-tip tree to test against them. Both are C-79b, not C-79a.
   2. **#1928 (B-094, `22766c90`, in C-79a):** touches only `colleague-defaults.json` and the log. No code clash with #1868. It starts colleagues in Custom 1 in 100, which is steeper than any big-pipe figure, so the two cannot fight.
   3. **#1962 (B-131, `7f7bc477`, in C-79a):** adds its switch at tip line about 1711 and does not read the sizing list. No clash expected beyond the log.
   4. **#1863 (B-020, sizer):** not in C-79a. The C-78 list's order "#1868 then #1863" and its `RulebookValues.cs` trap are about #1863 against the tip (`merge-tree 3fbb9da5 30990e61` shows `RulebookValues.cs` and the log); #1868 does not touch `RulebookValues.cs`.
4. **The stack is sound:** #1868's base commit is in the tip, so #1868 can go alone in C-79a.

### 6. Tests

1. **#1841 (`Gb01Slice1FallsTests`, 19 tests, plus about 25 existing test files re-pinned from the old ladder):** by reading, most new tests fail on the old code (for example `Ordinary300_18mRunWith90mmFall_OneIn200_NowWarns` passes on the old 1 in 250 at 300; `Detention450_AtOneIn200_InKingston_NowWarns` passes on the old every-council 1 in 200). I did not run them. Re-pinning 25 old test files to the new figures is expected for a ruled figure change, but it means those files no longer guard the old answers.
2. **#1868 (`Bug1091RedesignReadsMinFallTests`, 7 cases):** `RowSetTo200_...` and `CreateDefault_...` fail on the old code (no "450" in the list: a missing-key failure). The switch tests fail to compile on the old code, which is a red of a weaker kind. The author reports net10 full Civil 20,840 total, 0 failed, net48 0 errors, on the OLD base; not on the C-78 tip.
3. **NOT proven:** nothing in AutoCAD for either. For #1841 I found no robot or Codex result naming GB-01 slice 1, although it has been installed since Friday. Its Codex checks are written (`PENDING_TESTS.md` lines 90 to 99) and should run on 3.0.88 now.
4. **Robot (CE 02) for #1868:** use review K's point 5: CDHUB network redesign keeping existing sizes on a 450 at 30 L/s, with `largeGravityMinGradeN` 200 written to the settings file BEFORE AutoCAD starts. Expect no proposed fall flatter than 1 in 200. Control: same with `pipe.largePipeRedesignReadsMinFall` false: about 1 in 890. Third start: row blank, answer identical to the control.
5. **Codex look for #1868:** New Pipe, Standard grade, 450 UPVC, 10 m, upstream 10.000 with the row at 200: far level 9.950 or lower. Row blank: note what the window shows (point 1.3.4).
6. **Settings-file isolation:** the #1868 tests use `SettingsService.BeginTestScope` with a temp path. I did not check the author's real-file listings.

### 7. Verdicts

1. **#1841 (B-042): KEEP-WITH-NOTE. Train class: none; already in C-77, installed in 3.0.87 and 3.0.88. Do not merge it again.** Notes: (a) the C-79a hold line is out of date and should be removed; (b) run the seven Codex checks in `PENDING_TESTS.md` on 3.0.88; (c) the Edit Pipe strip versus CDRULES detention disagreement needs a carpark entry if it has none; (d) the duplicate seed in `PipeSizingModels.cs` is LOW; (e) no Settings page rows yet.
2. **#1868 (B-019, BUG-1091): KEEP-WITH-NOTE, area plus smoke** (calculations area: Civil Design, CDHUB redesign, New Pipe suggested grade; plus S1). **It CAN ride C-79a**: its base is already in the line, its only clashes are keep-both (`UserSettings.cs` about line 1465 and `REGRESSION_LOG.md`), it is asleep until the big-pipe figure is set, and its #1873 condition is met. Add its switch to the C-79 defaults class. BUG-1091 stays OPEN until the robot and Codex pass.
