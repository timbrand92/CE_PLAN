# Opus pre-review, queue filler 6: Civil #487, #610, #398 and #406 (oldest open drafts with a switch)

Written Monday 2 November 2026 (Melbourne) by an independent read-only Opus reviewer for CE 05 at CE 00's request.
Latest Civil line checked: `origin/claude/rel-20261102a` at 3fbb9da5 (Civil 3.0.88 / Manager 1.1.88, C-78), fetched read-only today.
Heads checked: #487 b10f1843, #610 dddcfbee (on #604 b6b9e960), #398 6a90fad8, #406 ff2f3b1a. All four are still OPEN DRAFTS on GitHub.
Nothing was built, tested, installed or opened in AutoCAD by this review. I ran read-only `git fetch`, `git log`, `git grep`, `git show` and `git merge-base` only, and read the PR pages with `gh`.

## FOR TIM

1. **The short answer: all four are already in your plugin. None needs reviewing. Close all four.** Each one was merged into a release train in late September or early October, and every one of them is still inside today's line (Civil 3.0.88). They show as "open" on GitHub only because they were merged into a train, not into the branch the PR points at. GitHub then never closes them by itself.
2. **The brief was wrong on one point.** All four already had an Opus review before they were merged. The queue list that called them "no Opus review" was mistaken. I checked the review comments on each PR page.
3. **#487, REDO kept after a drawing switch, an automatic save or a hatch pick with the Inspector open: CLOSE (already landed, Civil 3.0.19, 1 Oct).** It has no Settings switch. Opus reviewed it (fix needed), the fix was made, and Opus then confirmed it. The code is still in today's build. Whether REDO really survives those four cases in AutoCAD is still NOT proven.
4. **#610, CDSLABEDIT, CDSLABEREGEN, CDRAINFALL and CEHEALTH use the open drawing's own pit record: CLOSE (already landed, merged 4 Oct).** It has no switch, and that is fine for a bug fix. Codex passed the parent bug (BUG-385, a Pit Schedule row going missing) in real AutoCAD on 3.0.28. Nobody has driven these four commands in a second drawing.
5. **#398, the AutoCAD-style CD prompt with [Undo], the glow on the pit a pipe will join, [Size/Grade] typed at the command line and "Undid: point 4": CLOSE (already landed, Train C-1, 30 Sep).** All four switches are still OFF by default today. A drafter sees no change unless someone turns one on in Settings.
6. **#406, CE proposes levels: CLOSE (already landed, Train C-1, 30 Sep).** No command runs it today. A drafter cannot reach it, even with its switch turned on. The switch is not read anywhere outside the engine yet.
7. **No merging work and no train needed.** Merging any of these four again would add nothing, because every one of their changes is already on the line.
8. **What is still owed:** the AutoCAD proof for #487's REDO cases, for #610's four commands in a second drawing, and for #398's four switches turned ON. Those belong on the test list. They do not belong to these PRs. #406 can only be tested once a levels window exists.

---

## DETAIL

### Group facts (apply to all four)

1. **Already merged into the line.** `git merge-base --is-ancestor <head> origin/claude/rel-20261102a` is TRUE for all four heads (and for #604 b6b9e960, which #610 stacks on). `git log origin/claude/rel-20261102a..<head>` is empty for each, so no commit on any PR is missing from the line.
2. **Where each landed.**
   1. **#487:** commits 48bed6d7 and b10f1843 sit directly on the line's main history, just before "Version: Civil 3.0.19 / Manager 1.1.19" (31185e04, 1 Oct 21:36).
   2. **#610:** merge b8431db8, "Merge #610 (BUG-385 sync binds the record to the open drawing) @ dddcfbee into claude/rel-20261015f", 4 Oct 05:35. #604 came in at 68d1222a, 4 Oct 03:14.
   3. **#398:** merge c2b2d13a, "Train C-1 final: merge PR #398 new head (claude/c1-undo @ 6a90fad8)", 30 Sep 20:17.
   4. **#406:** merge abb6470d, "Train C-1: merge PR #406 (claude/l3-levels @ ff2f3b1a)", 30 Sep 16:59.
3. **Why GitHub still shows them open:** the trains merged them into release branches, not into each PR's own base branch (rel-20261003b, bug-385-revert-row-drop, rel-20260929c). GitHub only closes a PR on its own base.
4. **Earlier reviews already on the PR pages (the brief said there were none):**
   1. **#487:** Opus MERGE-WITH-FIXES at 48bed6d7, then Opus CONFIRM MERGE at b10f1843.
   2. **#610:** Opus MERGE at dddcfbee (review lane 01, 4 Oct 03:35).
   3. **#398:** Opus MERGE-WITH-FIXES (30 Sep), then a Codex static review and a Codex fix (typed size 0.0001). I did not find an Opus confirm of the final head 6a90fad8 in the comments I read. The train controller merged it.
   4. **#406:** Opus MERGE-WITH-FIXES at 50649f72, then Opus CONFIRM at 6548b670, then a Codex static review. The merged head ff2f3b1a is later than 6548b670. I did not re-check what changed between the two.
5. **Question 5, merging, for the whole group:** moot. Each head is already part of the line, so `git merge-tree` against the tip can only say "nothing to add". No function is changed by two PRs in this group, by file list: #487 is Inspector, link reactors and the undo watch; #610 is the project record; #398 is CD and its settings; #406 is the proposals engine and its settings. #398 and #406 both added lines to UserSettings.cs and REGRESSION_LOG.md. Both came in the same Train C-1, and both sets of lines are on the tip today (UserSettings.cs lines 290-292 and 2048-2064).
6. **Recommendation for CE 05 or CE 00:** close each PR with a one-line comment naming the merge commit above. Do not rebase, reopen or re-merge any of them.

### #487: C-4 REDO round 2 (drawing switch, automatic save, hatch pick)

1. **What changes for the drafter.** After U, CE no longer reads the drawing straight away when you pick a hatch with the Inspector open, or the first time a drawing is looked at after a switch. It waits until AutoCAD is quiet or until the next command. The aim is that REDO is not thrown away. CE's own "who changed the drawing after U" log also became better at naming CE as the writer. This matches the C-4 REDO work. The PR itself says the cause of the drawing-switch case (A3) is UNKNOWN.
2. **Still on the tip.** `InspectorPaletteService.cs:386` and `:559` call `RedoWindowGuard.DeferWhileRedoOpen` (the hatch pick and the first scan after a switch). `:693-707` carries the "Unproven in AutoCAD until Codex re-runs A2 OPEN g" note. `PostUndoWriteWatch.cs` is 267 lines on the tip, with one commit since #487. The tests `RedoRound2Tests.cs` and `RedoSafeCallGraphTests.cs` are on the tip. `LinkService.Reactors.cs` and `InspectorPaletteService.cs` have each had 32 commits since then. I did not re-review those later changes.
3. **Switch.** None. This is REDO hardening on a timing path, with no Settings switch. The later `RedoDiagSwitches` lines (`:527`, `:648`, `:655`, `:711`) are diagnostic switches added by other work, not by #487.
4. **No-hard-blocks, native protection.** Nothing in the PR stops the drafter. It only delays a read. It does not touch locked layers, Xrefs or REFEDIT.
5. **Protected files.** It does not touch LinkService.Persistence.cs, ProjectDataService.Persistence.cs or RulebookEngine.cs.
6. **Tests and settings.** The two test files on the tip have no reference to %APPDATA%, CD_Settings.json or the settings service (searched). I did not re-run them and did not check the before and after run.
7. **NOT proven.** REDO surviving A2 OPEN g (hatch pick with the Inspector open), A3 (U in drawing A, switch to B and back), A4 (U, then wait through an automatic save) and A1c. The robot scenario for CE 02: LINE, U, pick a hatch with the Inspector open, REDO must bring the line back. Then U in drawing A, switch to B and back to A, REDO. Then U, wait past one automatic save (SAVETIME 1), REDO. Each run with the Structural bundle loaded and again unloaded, because the PR names Structural as a suspect it could not rule out.
8. **Verdict: CLOSE, already landed.** In the brief's words: KEEP-WITH-NOTE (the note is the unproven REDO cases above). No train.

### #610: BUG-385 class, the drawing sync switches CE's record to the open drawing first

1. **What changes for the drafter.** In the second drawing of a session, or with two drawings open, CDSLABEDIT, CDSLABEREGEN, CDRAINFALL and CEHEALTH no longer pull the open drawing's pits into the OTHER drawing's record and save that mixture. Before the update, CE first makes the record belong to the open drawing. That is what BUG-385 (BUG_CARPARK.md line 3749) points at, in its wider form.
2. **Still on the tip.** `ProjectDataService.cs:599-610`: `EnsureDrawingDataCurrent` calls `BindRecordToOpenDrawing(db)` at line 610. The helper is at `ProjectDataService.Mutations.cs:296`, and its catch at `:316` writes a diagnostic line only. The helper is now also used by eight later callers in LinkService (Utilities, Reactors, PitOops, PipeOops, PitCoverText, LinkedTextEdits, SurfaceDrainTags). `Bug385SyncBindsRecordTests.cs` is on the tip.
3. **Switch.** None. It is a correctness fix and writes nothing extra, so having no switch is reasonable. No engineering value is involved.
4. **No-hard-blocks, native protection.** No stop is added. If finding the open drawings fails, nothing changes, as before. It does not touch locked layers, Xrefs or REFEDIT.
5. **Protected files.** ProjectDataService.Mutations.cs is not on the protected list. ProjectDataService.Persistence.cs is not touched.
6. **The stack.** #604, then #610, both merged into the line (68d1222a, then b8431db8). The stack is sound and finished.
7. **Tests and settings.** The PR says the tests failed first (a456198c, 2 failures on net10) and passed after. I did not re-run them. The test file has no %APPDATA% or settings reference.
8. **Proven and NOT proven.** Codex W6-02 PASSED BUG-385 itself (the Pit Schedule row loss) in real AutoCAD on 3.0.28 (carpark line 3714). Driver run 22 C1 also passed it with two drawings open (line 3729). Nobody has driven the four named commands in a second drawing. The carpark status line (OPEN, "fix installed in 3.0.70 via #612, #617, #667") is behind the W6-02 pass above it. The ledger owner should reconcile that, not this PR. The robot scenario: open drawing A, then B, close A, run CDRAINFALL and CEHEALTH in B, then PITSCHEDULE must list only B's pits. Reopen a copy of A: all its pits are still there. Repeat with both open, the Inspector closed, and CDSLABEDIT.
9. **Verdict: CLOSE, already landed.** In the brief's words: KEEP. No train.

### #398: UX-CMD-01 (part) and UX-CMD-04, the CD [Undo] prompt and the pit join glow (switches OFF)

1. **What changes for the drafter.** Nothing at default Settings. With switches on: CD's next-point question reads like AutoCAD's own, with [Undo] to take the last point back. The pit a pipe end will join gets a soft glow and a centre marker (only while object snaps are on). In window-first CD you can type [Size] or [Grade] (for example `300` or `1 in 80`). After [Undo], CE says "Undid: point 4 of the pipe route." This is what Tim asked for on 26 Sep ("AutoCAD style", "Subtle glow + snap marker") and on 29 Sep, question 11 ("Yes, all three"), as quoted in the PR.
2. **Switches on the tip, all OFF.** `UserSettings.cs:2052-2053` `autoCadStyleCdPrompts = false`. `:2060-2061` `showJoinTargetGlow = false`. `:2064` `cdCommandLine`, with `CdCommandLineSettings.cs` `sizeGradeAtCommandLine = false` and `sayWhatWasUndone = false`. `git log -S` shows the two top-level defaults have not changed since be370f23 (the PR's own commit).
3. **Defaults test.** `CdCommandLineSpecRulesTests.cs:164-175` pins both `cdCommandLine` switches OFF, including for an older settings file that has only `autoCadStyleCdPrompts: true`. I did NOT find a test on the tip that pins `autoCadStyleCdPrompts` and `showJoinTargetGlow` OFF through both start-up reads. It may exist under another name. Worth one check before any of these switches is turned on.
4. **No-hard-blocks.** A bad typed size or grade is refused and asked again. An unlisted size or a flat grade gets a one-line note, not a stop (from the PR body). The glow is screen-only.
5. **Native protection and REDO.** The glow reads the drawing once per point question through a read-only transaction (the Opus review cites `LinkService.PitOutline.cs:170-213`). No undo grouping is touched (PR body). No protected file is touched.
6. **Tests and settings.** `CdCommandLineSpecRulesTests.cs:250` uses `SettingsService.BeginTestScope(new UserSettings(), path)`, a test-only settings scope. I did not confirm that `path` sits under TEMP.
7. **NOT proven.** No switch has been turned on in AutoCAD. The robot scenario: turn on each switch in turn, then run CD. Pick three points, type U, and point 3 must come back. Hover near a pit with snaps on and look for the glow. Turn OSMODE off and the glow must disappear. In window-first CD type `Size` `300` and then `Grade` `1 in 80`; the pipe must be drawn as 300 mm at 1 in 80. Esc must cancel the pipe, and U must undo the whole CD. A Codex look is needed for the glow (it is visual).
8. **Verdict: CLOSE, already landed.** In the brief's words: KEEP-WITH-NOTE (pin the two top-level switches if not already pinned). No train.

### #406: L3-LEVELS, CE proposes levels (engine switched off, plus the window contract)

1. **What changes for the drafter: nothing.** On the tip, `LevelsProposalEngine` is called by no command or window. The only use outside its own folder is `Rules/EditGhostPlan.Levels.cs:50` (the dashed "new level" ghost, added later), and `ForLevels` itself has no caller outside the tests. `LevelsProposalSettings.Enabled` (`LevelsProposalSettings.cs:22`, default `false`) is not read by any command. **A drafter cannot reach this feature, with the switch on or off.**
2. **Settings and R-00.** `UserSettings.cs:290-292` `levelsProposal`. Later work (Tim, INT-059, 5 Oct) added a steepest-grade limit and a "warn steeper than 1 in 10" value with their sources (`LevelsProposalSettings.cs:25-64`). Those values are in Settings, as R-00 requires. The engine itself, the settings file and the models have all changed since #406 (131 lines added). This review did not re-check the levels arithmetic on the tip. The earlier Opus review checked the worked tests by hand (10.75 / 10.31, junction 10.43, drop 260 mm).
3. **No-hard-blocks.** By design, "no solution" names the worst pit and the shortfall and offers four options, choosing none. Every result says "Needs Tim's engineering acceptance". That is a warning, not a stop.
4. **Native protection.** The engine writes nothing to the drawing. The ghost is drawn on screen only.
5. **Tests and settings.** `LevelsProposalEngineTests.cs` is on the tip and has no %APPDATA% or settings reference.
6. **NOT proven.** Everything in AutoCAD. There is no window to test yet. The engineering values (minimum cover, 20 mm pit drop, the grade table, "Top of every branch") need Tim's own word once a window exists, not a Codex pass.
7. **Verdict: CLOSE, already landed.** In the brief's words: KEEP. No train. When the levels window is built, that PR gets the full review, including Tim's engineering check.

### What I could not verify

1. I did not re-review the code these four PRs touched as it stands today after later changes (for example, the 32 later commits to `LinkService.Reactors.cs` and `InspectorPaletteService.cs`). Those changes belong to other PRs.
2. I did not run any test, so "fails before, passes after" rests on each author's report and the earlier Opus reviews.
3. I did not open the BUGFIX reports in `C:\CE_PLAN\areas` or the decision files directly. Tim's words above are as quoted in the PR bodies.
