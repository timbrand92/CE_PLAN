# Fix briefs team, batch 2 of 4: FB-11 to FB-15 (Fri 23 Oct 2026, Melbourne, evening)

Headless Team job (Sonnet). Base: `origin/claude/rel-20261023m` at `f7f7d551` (Civil 3.0.72 / Manager 1.1.72, installed 23 Oct 18:27), fetched before branching. Brief file: `areas/FIX_BRIEFS_9NOV_2026-10-23.md`. Nothing deployed, no AutoCAD, Codex or accoreconsole started, no settings file, bundle or ProgramData touched, CE_SHARED unchanged, nothing closed or deleted, no bug marked FIXED, `BUG_CARPARK.md`, `DESK_LOG.md` and `QUEUE.md` not edited.

## ANSWER FIRST

Four of the five briefs have a draft PR. One (FB-15) is skipped with a written reason. All four are built and unit-tested only; nobody has opened any of them in AutoCAD.

1. **FB-11, BUG-570, draft PR #1693** (head `ae1566c6451ec4d4bb82fcb71095335fbc4decb6`, branch `fb/fb11-pit-preview-live`). Edit Pit's plan picture now shows the typed pit number and cover text ("P77", "CL 21.10") inside the dashed pending outline as you type, and an existing pit's caption reads "Saved pit — changes waiting for Save". Tests: four new, none compile on the base. Civil net10 full run **19,552 total, 19,530 passed, 22 skipped, 0 failed**. net48 not built (the changed files are net10-only). Real-AutoCAD check: see FB-11 below.
2. **FB-13, BUG-771, draft PR #1700** (head `78e889613b0de2c609b26438693a040666084b56`, branch `fb/fb13-cdrg-enter-finishes`). CDRG: Enter or right-click finishes the outline with 3 or more points; fewer asks for more ("[CE] Pick at least 3 points (2 so far)."); Undo with one point says "[CE] Nothing to undo yet. Pick the next point." instead of cancelling; Esc still cancels. Tests: eight new. Civil net10 full run **19,558 total, 19,536 passed, 22 skipped, 0 failed**. Drainage net48 build **0 errors**.
3. **FB-14, BUG-796 (report half only), draft PR #1701** (head `aaaa7ff4f38b992da834624e4368c336a3096190`, branch `fb/fb14-repair-report-counts`). CDLINKDANGLINGPIPES counts only pipes whose CE record reads back and names a failure and a locked layer; CDREBUILDLINKS counts only the pits and sources it registered (not pipes) and adds a "could not be linked" line; CDPROPAGATE's Min grade uses the kept levels. Tests: seven new. Civil net10 full run **19,557 total, 19,534 passed, 22 skipped, 1 failed**: `CivilHelpHostTests.AcceptedCommandContextFailure_CompletesOnceWithoutFallbackStart`, which passed twice when its class was re-run alone and is in code this PR does not touch (looks load-dependent; I did not prove that). Drainage net48 build **0 errors**.
4. **FB-12, BUG-225, draft PR #1706** (head `65d77570f8302553ab788933020774ad69e268b5`, branch `fb/fb12-pit-tab-close`). **The fault was not reproduced and its cause is still unknown**, so this is the brief's second-chance fix: after the Close button's command ends, one Idle follow-up clears the same pick and hides the tab again. It may not cure it. Needs the Opus review the REDO rules ask for on Idle work. Tests: seven new. Civil net10 full run **19,555 total, 19,533 passed, 22 skipped, 0 failed** (first full run failed two REDO guard tests; fixed, see below). Drainage net48 build **0 errors**.
5. **FB-15, BUG-855: skipped.** The brief's own first step is a headless probe with accoreconsole, which this job may not run, and reading the code does not name the extra issue. Reasoning and options are below. No PR, no branch left behind.
6. **No existing PR held a real fix** for any of the five (search by bug id found nothing on any of them; #1541 to #1544 are other briefs and notes-only).

## What Tim will see and the Real-AutoCAD check, per fix

### FB-11 (BUG-570), PR #1693

1. **What he sees:** in Edit Pit, type P77 over P13 or 21.10 over 21.00: the big picture shows P77 and CL 21.10 straight away, not the old values. The caption for an existing pit says the pit is saved with changes waiting.
2. **Real-AutoCAD check (FX-11):** a detached grated pit P13, 900 x 450, CL 21.000. Click the pit body, Pit tab, Edit Pit; type P77; wait 1 s; screenshot; set the cover to 21.10; screenshot; Cancel. The screenshots show P77 and CL 21.10 in the preview; after Cancel the drawing is not marked changed and the plan still shows P13. Codex looks at the window (a robot cannot judge the picture).
3. **Honest caveat:** the real saved plan is drawn underneath, so the old label can still show under the new text until Save. The new text sits on a solid chip to mask most of it; I have not seen it in AutoCAD.

### FB-13 (BUG-771), PR #1700

1. **Real-AutoCAD check (FX-13):** an empty Civil drawing. `CDRG`, points 0,0 / 4000,0 / 4000,3000 / 0,3000, Enter, accept the remaining prompts at their defaults. Closed polylines on the raingarden layer go up by 1; one U removes it. Second run: `CDRG`, 0,0, `U`: it still asks for the next point. Press Esc: "cancelled", nothing drawn. Third: `CDRG`, two points, Enter: it asks for more.

### FB-14 (BUG-796 report half), PR #1701

1. **Real-AutoCAD check (FX-14):** three loose polylines on the stormwater pipe layer, one on a locked copy of that layer. `CDLINKDANGLINGPIPES`: the line says 2 registered and 1 could not be linked, naming the locked layer; CDCHECK lists 2 newly linked pipes.
2. **Also:** CDREBUILDLINKS on a drawing with pits, sources and pipes: the count equals pits plus sources, not pipes. CDPROPAGATE with one hand-set level kept: Min grade matches the kept pipe's real fall.
3. **Not in this PR:** the missing Yes/No before these buttons write (it changes the approved UX-REP-01 workflow, as the brief says).
4. **Honest caveat:** on a locked layer I could not tell without AutoCAD whether the old code threw (and so already failed quietly) or wrote anyway. The new code does not pre-skip locked pipes, so what is written is unchanged; it just reads the record back and counts only real successes.

### FB-12 (BUG-225), PR #1706

1. **Real-AutoCAD check (FX-12):** any drawing with a pit. The driver clicks the pit, clicks the Pit tab's "Close" by its accessible name, reads `(ssgetfirst)` and the ribbon's visible tabs: nothing selected, no Pit tab. Repeat twice. A Codex click with a screenshot completes it.
2. **If it still fails after this:** the cause is elsewhere. Reopen with the ribbon-clicks log and the CE log for that click.

## FB-15 (BUG-855): skipped, with the options

1. **Why skipped:** the carpark says "which issue is the new one is not known", and the brief's smallest fix starts with listing the issues before and after CDSYNC on a headless probe, which means running the real CE code under accoreconsole. This job is not allowed to start accoreconsole, so I cannot name the extra issue. A fix without that name would be a guess at the cause. Also, Codex W1-03 (23 Oct, 3.0.70) read 95 before and 95 after, but on a copy already edited by W1-01 and W1-02, so it neither confirms nor clears the 95 to 96 (BUG_CARPARK).
2. **What the code shows (read, not run):** the header count is the number of findings from `ProjectDataSanityService` (seven kinds: duplicate pit number, pipe end naming a pit that is not in the record, missing pit level, missing pipe invert, missing pipe diameter, duplicate pipe handle, pit excluded from the schedule). CDSYNC re-registers every pit, clears its pipe list, re-registers every pipe with no recorded owner, then re-reads the record from the drawing. Any pit or pipe that was in the drawing but not yet in CE's record, or any end whose recorded name changes, can add a finding.
3. **Best guess, not verified:** run 35's pit P8 and its pipe with a flagged open end were in the drawing but perhaps not yet in the record; CDSYNC adds them, and a freshly registered pit with no cover level (or a pipe end with no invert) is one more genuine "missing level" finding. If so the count is right and the drawing was simply not registered before, and the fix is only a named row, not a code change.
4. **Option A (recommended):** the desk runs the probe it already planned (accoreconsole job, read-only on a copy): list the sanity findings before and after CDSYNC on the run 35 drawing and print the new one. That is one short job, and the fix (or the decision "it is correct, show it as a named row") follows from the name.
5. **Option B:** add one CE log line to CDSYNC that prints the finding count before and after, with the kinds. About ten lines, new logging only, and it lets Codex's next real run name the culprit without accoreconsole. Say if you want that built.

## Findings from the code that the desk should know

1. **FB-12, the net48 clause does not apply.** The ribbon files (`RibbonBuilder.cs`, `CeContextualTabController.cs`) are excluded from the net48 build of CE_SHARED, so the net48 lane has no ribbon, no Pit tab and no Close button. The brief's "make the net48 lane hide the tab too" is moot.
2. **FB-12, REDO guards caught the first version.** My first version used lambdas to hook Idle. Two existing guards failed on the first full run (`RedoSafeCallGraphTests.EveryHookBetweenCommands_IsRedoSafe_OrReviewed`: handler not found; `RedoWindowGuardTests.EveryIdleHook_IsGuardedOrClassified`: file not classified). I changed it to a named Idle handler so the call-graph guard can follow it, and added `RibbonContextCommands.cs` to the Idle-hook inventory in `RedoWindowGuardTests` with its reason. Both pass now. This is why the PR needs the Opus review.
3. **FB-14, one brief line number is stale.** The brief says `HubCommands.cs` lines 636 and 669; at the base they are around 649 and 682. Nothing else about the brief's description was wrong.

## What I did NOT test

1. **None of the four was opened in AutoCAD.** Built and unit-tested only. Windows (FB-11) were not looked at.
2. **net48:** built for FB-12, FB-13 and FB-14 (0 errors each). Not built for FB-11 (its files are net10-only and guarded). No net48 test run was done for any of them (the net48 test run has the known reference-only AutoCAD faults).
3. **Structural and Manager** were not built or tested (not in scope; nothing there changed).
4. **FB-14:** the locked-layer behaviour of the old registration path was not observed; the "naming the lock" text comes from a read-only layer check after a failure.
5. **FB-12:** the failure itself was never seen; the Idle follow-up is not proven to cure it.
6. **The one FB-14 failure** (`CivilHelpHostTests...CompletesOnceWithoutFallbackStart`) was not run on the base, so "not caused by this PR" rests on the class passing twice alone and on the code being untouched.
7. **No reviewer ran** on any PR here; FB-12 especially needs the Opus Idle-work review.

## Process notes

1. **Builds:** each fix in its own worktree under `C:\ce-fx` (fb11, fb13, fb14, fb12; fb15 made and removed with no commits), all removed at the end. Every build and test used `-p:SkipDevBundle=true -nr:false --disable-build-servers` with the AutoCAD refs from the C-62 assembly report, through the existing scratch wrapper `C:\ce-fx\bt.sh` (no new script in any repo). Free space on C: stayed at 14 to 15 GB (above the 12 GB stop line) before every build.
2. **A build lock file** `C:\CE_PLAN\desk_jobs\build.lock` already existed throughout; `bt.sh` does not take it, so I did not take or delete it. Another build may have been running at the same time as mine (full runs took 8 to 16 minutes).
3. **Commit messages** each name their bug in full (BUG-570; BUG-771; BUG-796 (report half); BUG-225). Each commit and PR body ends with the Sonnet 5.5 attribution lines.
4. **REGRESSION_LOG.md:** a new entry at the top in each of the four branches (each branch is separate, so the entries will need both sides kept when the PRs merge into one train).

## Summary

Four draft PRs from base `f7f7d551`: #1693 (BUG-570), #1700 (BUG-771), #1701 (BUG-796 report half), #1706 (BUG-225). Built and unit-tested only; full Civil net10 runs 19,5xx total, 0 failed except one unrelated flaky help-host test on #1701. FB-12's cause was never reproduced, so it is a second-chance fix needing the Opus Idle review. FB-15 (BUG-855) skipped: it needs the accoreconsole probe. Nothing opened in AutoCAD.
