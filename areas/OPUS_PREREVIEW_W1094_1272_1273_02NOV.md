# Opus pre-review: draft PRs from jobs 240 to 243 as one group (Tue 3 Nov 2026, about 00:30, Melbourne)

Read-only drafting job for CE 05, on the CE 00 order of Mon 2 Nov 20:45. Written by Opus. Nothing built, nothing tested, nothing installed, AutoCAD not opened.

## FOR TIM

1. **Only one of the four jobs opened a PR:** #1994 (BUG-1273, Cascade Preview pit count). The other three stopped on purpose, with no PR (see the end).
2. **Verdict on #1994: HOLD for your answer, the code itself is sound.** It makes the preview say "4 pipes, 3 pits will change", the same 3 the history line says after Apply.
3. **Why hold:** that wording is a choice still waiting for you. Question 3 in last night's batch for you recommends the OTHER way: keep "5 pits including the one you picked" and have the finished message name any pit it left alone. The fix job was told to build the "count only changed pits" way before you answered.
4. **What it means on a job:** with #1994, the preview stops counting the pit you started from and any pit CE has no record for. With the other way, the preview number stays at 5 and the message after Apply tells you which pit was skipped and why.
5. **If you pick "count only changed pits":** #1994 is ready to go into a build as it is (one tiny wording slip, "1 pits", can be fixed later). If you pick the other way, #1994 is not used and a new small job is needed.
6. **Not in what you have installed** (Civil 3.0.89), nor in 3.0.90 or the build after it.
7. **Not proven:** nobody has run a real cascade in AutoCAD with this. The count is checked by unit tests only.
8. **Your one decision:** answer question 3 in the 2 Nov question batch. Nothing else for you tonight.

---

## What I did

1. **Read:** `C:\TimOS\RULES.md`; the template `areas\OPUS_PREREVIEW_1989_1993_02NOV.md`; the four reports `areas\BUGFIX_w1094_REPORT_02NOV.md`, `BUGFIX_w1272_REPORT_02NOV.md`, `BUGFIX_w1273_REPORT_03NOV.md`, `BUGFIX_w1270b_REPORT_03NOV.md` (the FOR TIM blocks of all four, the whole of w1273); the job brief `desk_jobs\team_fix_w1273.txt`; the carpark entry BUG-1273 and the notes under it (C:\CE_PLAN at 0db88c39, 00:21 Tue 3 Nov); question 3 in `areas\OPEN_QUESTIONS_FOR_TIM_BATCH_02NOV.md`; the latest decision file `decisions\2026-11-02_TIM_AWAY_ALL_DAY_TEST_HARD.md` (nothing in it on BUG-1273); the full #1994 diff; the Cascade Preview view model around the change; the Apply loop in `LinkService.RepairAudit.InvertPropagation.cs` on the base, on 3.0.89, on 3.0.90 and on b2; `PropagationPlan.CanApply`; the Edit Pipe caller that opens the preview.
2. **Fetched first:** `git fetch origin` at 00:29 Tue 3 Nov, then `refs/pull/1994/head` and the heads of #1989 to #1993 for the overlap check.
3. **Found the PRs:** `gh pr list --state open --search "BUG-1094 OR BUG-1272 OR BUG-1273 OR BUG-1270"` (by full path, `gh` is not on this shell's path) returns #1994, #1990, #1962 and #1402. Only #1994 comes from jobs 240 to 243. #1990 (BUG-1270 decimals half) was reviewed in the 1989 to 1993 group; #1962 (B-131, BUG-1094) is older and already inside 3.0.89 (`merge-base --is-ancestor 7f7bc477 61fd6fbc` true); #1402 is an October BUG-785 PR. None of those three re-reviewed here.
4. **Merge check:** read-only `git merge-tree` (old form, writes nothing) of #1994 into 3.0.90 (cf059dcf) and against each of #1989 to #1993.
5. **Built:** nothing. **Tested:** nothing (I read the tests, I did not run them). **Installed:** nothing. **Opened AutoCAD:** no.

## Where #1994 sits (the build question)

1. **PR head:** 1e310948, one commit on `origin/claude/rel-20261102a` = 3fbb9da5 ("Version: Civil 3.0.88 / Manager 1.1.88 (C-78)"), branch `claude/w1273-preview-count`, draft.
2. **In installed 3.0.89 (61fd6fbc):** no (`git merge-base --is-ancestor 1e310948 61fd6fbc` false).
3. **In candidate b1 = c1076 = 3.0.90 (`rel-20261108a`, cf059dcf):** no. **In b2 (`rel-20261110a`, d4ce878e):** no. The new switch name `cascadePreviewCountsChangedPits` has zero hits in all three trees, so no copy arrived by another route.
4. **Written against 3.0.88, not 3.0.89.** For this PR that does not matter: the Apply loop it copies is word for word the same in 3.0.88, 3.0.89, 3.0.90 and b2 (lines 964 to 970 in the last three: skip the anchor, skip a pit with no CE record, count the rest), and the completion line `Updated {pipesUpdated} pipes and {pitsUpdated} pits` is unchanged.

## #1994 (B-168, BUG-1273): Cascade Preview states the pits that will change. Verdict: HOLD (Tim's word on the wording); code GO

1. **The hold (rule 3.4, never turn an unanswered question into a decision):** the carpark entry says "Fix-ready only after an owner decision on the wording (count written pits in the preview, or label 'including the anchor')". That question went to Tim as question 3 of `OPEN_QUESTIONS_FOR_TIM_BATCH_02NOV.md`, whose recommended default is the opposite of #1994: preview "4 pipes, 5 pits including the one you picked", and the finished message names any pit it left alone. I found no answer from Tim in `decisions\` or the carpark. The job brief (`team_fix_w1273.txt`, THE TASK) told the builder to make the preview count the changed pits, so the builder did what it was told; the slip is upstream of the job. CE 05: either hold #1994 until Tim answers, or withdraw question 3 and tell Tim the desk chose. Do not put it in a train on the brief alone.
2. **Does what the brief says, nothing more:** yes. One summary line changes. The pit rows listed in the window, the Apply loop, the history line and every level written are untouched (diff read in full: a new counting helper, the view model, one Settings line, the change log, one test file).
3. **The count truly mirrors Apply:** yes. The helper skips `IsAnchor` and any pit whose `ProjectDataService.GetPitByHandle` comes back empty, the same two skips and the same call Apply uses. The lookup is made in the same drawing just before Apply, from the same Edit Pipe path (`PipeEditCommand.Update.cs` builds the plan, opens the preview, then applies `preview.ViewModel.CurrentPlan`), so the two numbers should agree. If the lookup throws, the pit is counted (old behaviour), never hidden.
4. **OFF gives the old behaviour exactly:** yes. With the switch off `Wording` returns `"{PitRows.Count} pits"`, which is the old text character for character inside the same sentence.
5. **Switch through both start-up reads:** yes. `{}`, `{"linking":{}}` and a linking group without the key all read ON through `DeserializeSettings` and `DeserializeSettingsTolerant`; typed false reads OFF through both (read, not run by me). The key sits in the existing `linking` group beside `cascadeRelinksOnlyPlanPipes`. Not added to the train's `NewSwitchDefaultsTests` list; the report says so and leaves it to CE 01's finalizer. CE 01 should add it when the PR goes on a train.
6. **Tests are honest about what they prove:** one test drives the real view model with an anchor, two pits with a record and one without, and checks "2 pits will change" plus four pit rows still listed. A source check pins that the Apply loop still holds both skip lines, so a later change to Apply makes that test fail. There is no view-model test with the switch OFF (only the helper is tested off). Report: 47 run, 47 passed on net48 and net10 (not re-run by me).
7. **CE_SHARED:** none. **Locked layer / Xref:** nothing touches the drawing. **Hard-coded engineering value (R-00):** none. **REDO:** text only, nothing written, safe. **Warn and carry on:** nothing blocks; Apply's enable rule is untouched.
8. **Small notes, no change asked before Tim answers:**
   1. **"1 pits will change":** the wording does not go singular. Same habit as the existing "1 pipes" in the same line, so it is consistent, but Codex will read it on a one-pit cascade.
   2. **"0 pits will change":** a cascade where every downstream pit has no CE record will say so before Apply, which is correct and more useful than before.
   3. **The pipe half of the line is unchanged:** the preview still counts every pipe row, while Apply skips a pipe on a locked layer or with no CE record. In S5-02 both said 4, so no mismatch was seen; just noting the same kind of gap could show for pipes.
   4. **The new file ends without a final line break.** Cosmetic.
9. **Merge note:** clean into 3.0.90 apart from routine "keep both" overlaps in `UserSettings.cs` and `REGRESSION_LOG.md`. Against #1989 (which also edits the Cascade Preview view model): no conflict, different places, and #1989 does not touch the summary line. Against #1993: one change-log-only conflict (both added their entry at the same end of `REGRESSION_LOG.md`); keep both entries. Against #1990, #1991, #1992: no markers.
10. **Not proven:** nobody has run a real cascade with this in AutoCAD; which two pits made the 5-against-3 gap in Codex's S5-02 is still not known (the carpark and the report both say so). The robot case in the report (`N31_bug1273_cascade_pit_count` with an OFF twin) reads the preview line and the history line and checks the two numbers match, which is the right proof.
11. **The one sentence for Tim (if he picks this way):** "The Cascade Preview now counts only the pits it will actually change, so its number matches the history line after Apply."

## Points that apply to the whole group

1. **Real-file listings:** w1273 and w1272 both report files in Tim's AppData folders changing during their runs (w1273: 12 files and 11 usage events, all 23:50 to 23:59:53 Mon 2 Nov, a pattern that looks like a live AutoCAD session closing). w1273 judged it not its own and opened the PR; w1272 could not separate them and stopped. Same window of time, so one answer from CE 01 (whose AutoCAD closed at about 23:59) settles both. I did not check this (read-only job).
2. **None marked FIXED,** correctly. BUG-1094, BUG-1270, BUG-1272 and BUG-1273 all stay OPEN.

## Skipped, and why

1. **Job 240, w1094 (BUG-1094 Inspector "no Grade line"): no PR.** The job found the red Grade line and the "To fix" line sit on the Checks tab of CE Inspector, not Summary, and that Codex only looked at Summary. Making Summary show it is a window change, so it wrote a Codex window brief instead (`areas\BRIEF_W1094_INSPECTOR_HEALTH_02NOV.md`). Nothing to review.
2. **Job 241, w1272 (BUG-1272 Material conflict sentence twice in Edit Pipe): no PR.** Built and unit-tested on a local branch only (`claude/w1272-editpipe-banner`, commit 640b2578, switch `pipe.editPipeWarningShownOnce`), not pushed. It stopped under its real-file rule (17 changed and 42 new files in Tim's AppData during its run, some possibly its own) and waits for one line from CE 01 or Tim: push or stop. I did not review the local commit (the order says skip jobs with no PR).
3. **Job 243, w1270b (BUG-1270 depth half): no PR.** Diagnosis only: by code read the P8 depth step from 1.00 to 1.10 looks like CE filling a blank pit floor from the lowest pipe end, which matches Tim's 20 Oct depth ruling; it ends with a question for Tim (keep filling a blank floor, or leave it blank and measure to the lowest pipe straight away). Nothing to review.
4. **#1990, #1962 and #1402** appear in the search but are not from jobs 240 to 243 (see "What I did" item 3).
5. **Did not build or run any test** (read-only order). Every "yes" about tests above is from reading the test file.
6. **Did not check the robot case drafts** (`areas\ROBOT_CASE_DRAFTS_W1094_1272_1273_02NOV.md`); outside this order.
7. **Output path:** the order named `C:\CE_PLANreas\...`, which does not exist; read as `C:\CE_PLAN\areas\` (the backslash-a was lost), the same reading as the 1989 to 1993 review. Written there. Not committed or pushed (CE 05 pushes).
