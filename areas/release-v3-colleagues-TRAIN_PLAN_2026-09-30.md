# Train plan A1 (Opus, claude-opus-5-5, Wed 30 Sep 2026 about 10:58)

Written by the Opus planning job for controller 06. It is a PLAN, not a decision: nothing is merged, no train is built. Tim decides the items in section 8 on his return. The record it was made from is the queue file sections 4.6, 13, 14 and 15 and `gh pr list` at 10:56.

## Two findings the record did not have
1. **#397 and #402 lose code whichever order they merge in.** #397's head (8aa589a5) is a revert of 9e82f9a1 (the CSUNITCOPY slice). #402 contains 9e82f9a1 but not the revert. Merge #397 then #402: git treats 9e82f9a1 as already merged, so only #402's two fix commits arrive and CSUNITCOPY is silently lost. Merge #402 then #397: the revert strips it out. **Rule: merge #402 only.** It already contains #397's confirmed content (controller check 30 Sep 11:00: `git diff 8d0797e8 origin/claude/s2-unit` is empty and #402 = 8d0797e8 plus slice 2, 18 files). #397 is to be closed as "included in #402": that close is Tim's call (return page). #402's title has been corrected (it no longer says DO-NOT-MERGE).
2. **More overlaps than the record listed:** #389 also edits Civil `UserSettings.cs` (six PRs touch it: #389 #390 #396 #398 #401 #406); #390 and #406 both insert at line 93 (certain conflict); #388 also edits `CdCommand.cs`; #401 and #410 share `ProjectDataService.Mutations.cs`; #404 and #407 share `CdViewModel.DrawFirst.cs`. No PR touches `Shared/`. There is no `claude/bug223-editflow` branch on origin yet (at 10:58).

Facts at the time: Civil line `claude/rel-20260929c` is 75 commits ahead of master and 0 behind; Structural line is 20 ahead of `struc-d1-prep` and 0 behind.

## 1. Train grouping
Each train branches from the previous installed train (naming e.g. `claude/rel-20261001a` and `-struc`). One install carries one Civil train plus at most one Structural train, no more than about 8 PRs, one tick-list. Codex passes each install before the next train is built. If a PR fails, rebuild the train without it; never revert it.
1. **C1 (close, save, schedule):** #412 #393 #416 #409 #419 #389 #395 #400
2. **C2 (CD flow):** #404 #407 #388 #398 #401 #387
3. **C3 (reactors):** #391 #410 #417, plus #414 only if proven
4. **C4 (hidden features, Manager):** #390 #406 #396 #394
5. **C5 (calculations and units):** #411 #421 #403 #413 #420
6. **C6:** #414 if it missed C3, then BUG-223's PR
7. **S1 (Structural):** #399 #392 #418 #415
8. **S2 (Structural):** #402 (NOT #397) #405

## 2. Order and resolution rules
- **Stacks, parents first:** #393 before #414; #411 before #421 (its PR base says `rel-20260929c` but the branch contains #411); #403 then #413 then #420; #404 before BUG-223. Merge each branch as it is: no rebase, no retargeting.
- **Expected conflicts (all others are disjoint):**
  1. C1: #393 and #412 in `LinkService.cs` (lines 1246-1276 against 1316).
  2. C2: #404 then #407 (lines 205-231 against 248-270); the `CdCommand.cs` hunks of #388, #398 and #401 are at 639, 331-1144 and 61.
  3. C3: `LinkService.Reactors.cs` hunks at 848-878, 1197 and 1348.
  4. C4: #390 then #406 conflict for certain; keep both properties.
  5. S1: #399 then #392 (lines 758-783 against 800); check that `partial` compiles.
  6. S2: registry hunks at 2247 and 4935.
- **`REGRESSION_LOG.md`:** keep every entry, incoming PR's entry on top.
- **`UserSettings.cs`:** keep every property, leave every default unchanged.
- **`command-registry.json`:** keep every entry, parse it (`ConvertFrom-Json`), check no `"command"` value appears twice.

## 3. Content check after each merge (M = P merged into train T; mb = `git merge-base T P`)
1. `git diff --numstat $mb P` must equal `git diff --numstat T M`, except the resolved files; each difference needs a reason.
2. `git diff P M -- $(git diff --name-only $mb P)` must show only hunks from earlier PRs in the train.
3. Line counts for the log, both `UserSettings.cs`, the registry, `LinkService*.cs`, `PitEditCommand.cs`: wc(M) = wc(T) + P's added lines minus P's deleted lines.
4. Removed test lines: `git diff T M -- '*Tests*' | grep '^-[^-]'` may show only approved removals: #407 11, #421 19, #410 6, #394 6, #420 3, #414/#417/#415 2 each, #387/#404/#413 1 each, and #405's pin hash. (Controller note: #394 and #420 counts were re-measured after their fixes: re-measure at train time.)
5. Test attribute count `git grep -cE '^\s*\[(Test|TestCase)' <rev> -- 'Modules/*Tests*/'`: train must equal base + sum of (P minus mb).
6. `--list-tests` names on base and train: `comm -23` must be empty (no test lost).
7. The merged SHA must equal the SHA in the PR's last OPUS comment.

## 4. Semantic conflicts a textual merge hides (Codex must test the COMBINATION)
1. #404 + #407 (+ BUG-223): both change the two-open-ends case. Test "Use level direction" with a size-only Edit Pipe save.
2. #391 + #410 + #417 (+ #414): one reactor path. Drag a grade-held pipe end off its pit and back; COPY Multiple then Esc, U, REDO; MOVE; at most one question appears.
3. #393 + #412 (+ #414): run the close probe in a Structural drawing too.
4. #409 + #419 + #410: schedule refresh, pit identity, a freed pipe leaving its pit's schedule.
5. #398 + #401: CD's [Undo] after an auto-join (only matters before either switch is on).
6. #411 + #421 + #403/#413/#420: units feed detention; the sheet wording changes.
7. Structural: #402 and #415 both go through BeamLink: test erasing a column under a copied beam.

## 5. Not in the first trains
1. #414: the evening headless proof must show the base losing Redo 3/3 and the branch keeping it 3/3.
2. #421: its fix confirm is pending. BUG-223: not built yet.
3. C5 changes engineering outputs; Tim still owes Kingston (Q17) and the office templates' INSUNITS answer; #420 changes wording on a signed sheet.
4. #406 can ship hidden but Tim must accept the Assumed 1 in 20 steepest grade before it is switched on.
5. PRs that are OFF and only need Codex before switch-on are fine to include.

## 6. Build and test
- Build: `dotnet build CE_ACAD_PLUGIN.slnx -c Release -p:SkipDevBundle=true -nr:false --disable-build-servers`: 0 errors on net48, net8.0 and net10.0.
- Tests: full Drainage, Manager and Structural on net10 and net48, only in Tim's free windows.
- Compare failures BY NAME against the same run on the base. Accepted (long-standing, environment): net48: TreeSiteConstraintServiceTests, RaingardenPlanPointTests (plus #421's 20), IsSaveWaitingFor_NoDrawing_IsFalse, BlankLevelClearsTests x4. net10: AddSystemCommand x3, BoydsDetentionRequired, BackTest_GlenEira, and the two SourceAtomic tests (flaky).
- Watch SpineHoldPointTests. The full count must complete (#398's first run stopped at 6,135 tests).
- Run the Structural SbeamEditAutoCadEvidenceReaderTests fixture on its own, base and train. Run the `Plugin.cs` pin test after S2.

## 7. Minimum evidence
- **Before `OPUS SIGN-OFF train <branch> GO`:** an Opus verdict on each flagged PR's merged head and a Sonnet MERGE on each unflagged PR; the section 3 outputs; 0 build errors; the test-name diff; `CE_SHARED.dll` SHA256 identical in the Civil and Manager outputs; versions bumped.
- **Before the install:** `Get-Process acad` empty on two checks about 5 minutes apart; no codex or `queue3.sh` process; `CS_Settings.json` (and `CD_Settings.json`) copied aside; current bundles backed up with the undo named; SHA256 of the built DLL equals the installed DLL; ProductVersion read back from disk; #78 updated.

## 8. For Tim to decide (not decided here)
1. Merge into master or keep the release branches. Master: the Civil merge is conflict-free (use `--no-ff`), but gate 4.6.3 needs a Codex PASS on every flagged PR and none has one yet; the old PRs aimed at master (#1-#360) go stale. Release branches: dated branches drift, stacks pile up, `builder_rules` and #78 can name the wrong base.
2. Structural never merges master (the lines split on 26 Jul; `CE_SHARED` differs in 870 files): is the Structural trunk `struc-d1-prep` or the release line.
3. Whether installs keep coming before a Codex PASS.
4. What happens to drafts #357-#386 (closing any is his call).
5. Close #397 as "included in #402".

Not in the record at the time: Codex PASS status (`PENDING_TESTS.md`), #414's evening result and #421's confirm (PR comments), the install recipe (section A2 of the area file).
