# Fix round 23 Oct 2026: Opus review fixes applied to the Codex draft PRs

Fri 23 Oct 2026, about 04:47 to 07:35 Melbourne (PC clock). Headless job "FIX ROUND 23 OCT" (desk plan/03), Sonnet. Inputs: `REVIEW_CODEX_PRS_A_2026-10-23.md` and `REVIEW_CODEX_PRS_B_2026-10-23.md`.

Built and unit-tested only. Not installed. Nobody has opened any of it in AutoCAD. No PR closed, no branch deleted, no bug marked FIXED, `DESK_LOG.md` and `BUG_CARPARK.md` not edited, AutoCAD / Codex / accoreconsole never started, no settings file, installed bundle or ProgramData touched, every build with `-p:SkipDevBundle=true -nr:false --disable-build-servers` and the refs from the C-57 / S-39 assembly reports.

## ANSWER FIRST

1. **All 15 listed PRs handled.** 13 got a fix commit on their own branch, pushed normally, with a comment on the PR (new head and fixes). #1524 and #1533 are "merge as is": nothing done, heads recorded below.
2. **The merged trains are green.** All 13 Civil PRs dry-merged in the review order onto `claude/rel-20261022m`, then built and tested: Civil net10 **19,419 total, 19,397 passed, 22 skipped, 0 failed**; Manager **916 total, 915 passed, 1 skipped, 0 failed**; net48 plugin build 0 errors. S-42 (#1547, #1533): Structural net10 about **5,703 passed, 0 failed**.
3. **The only clash beyond REGRESSION_LOG.md** in either train is two picture files, `settings-dark-8-fixes.png` and `settings-light-8-fixes.png` (#1526 and #1531 both add them). Keep one set and re-render on the merged train.
4. **The first merged-train run found three clashes the reviews did not.** All three are fixed on the PRs: (a) `UserSettings.pits` (from #1540) had no documented default, so the #1536 settings census failed; (b) #1530's fallback test expected "1:170" but #1549 prints "1:169.7" (5 cases); (c) the Settings tallest tab reached 687 px (over 670) with #1531's new tick on top of #1526.
5. **One deviation from the review, with the measurement.** #1526: the review said to move the three "Drawing checks" ticks to Newer tools. Measured, that makes the window taller (703 px, not 670). The real excess was 3 px on two tabs, so the fix is a few pixels of spacing and the ticks stay on Fixes. See the #1526 entry.
6. **Switches that now ship ON** (the old behaviour is the fault): #1538 `detention.twlUsesDrawingUnits`, #1540 `pits.skipCurrentPitBlockRedefine`. #1531's switch was already ON. #1549, #1530, #1546, #1545 have no switch. #1540: the Opus review suggested merging OFF and flipping after a Codex FX-03 pass; this round ships ON because the desk instruction names #1540. The real-AutoCAD FX-03 pass is still owed.
7. **Test runs of note:** a plain whole-suite Structural run hangs after about 4,600 tests (as Codex found), so Structural was run by class chunks with `SbeamEditAutoCadEvidenceReaderTests` left out. `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` timed out once or twice at 15 s under whole-suite load (#1538 and #1540 runs) and passes alone and in the merged-train run: treat it as a load flake.

## Per PR

Format: number, old head, new head, fixes, switch default, tests added, build and test totals. "Known red" = `BackTest_GlenEira24115_Computed_WithinTolerance`, which #1549 fixes. Every Civil run is net10 `CE_CVL_SUITE.Tests`; every PR also got a net48 plugin build with 0 errors.

### Group A

1. **#1524** (CDCHECKIGNORE Undo): MERGE as is. Head `e1a59824c536a9b4359236f8fe94163b0219e311`, unchanged. Nothing done, no comment.
2. **#1536** (guard tests): `719aadac` to `d463134a`. Fixes: removed the assertion that `InitServicesFull(` is still in `CheckIgnoreCommand`; the switch-before-write guard (BUG-863) no longer has a fixed Ignore, it skips itself only while the old code is there and runs for real once #1524 lands. Switch: none. Tests added: none (one removed assertion, one guard made self-activating). Civil 19,196 total, 19,172 passed, 23 skipped, 1 failed (known red).
3. **#1527** (automation IDs): `235e0c33` to `f64420f4`. Fixes: label pass wrapped in try/catch with one CE-log warning per window; late content (tab change) gets IDs on a throttled pass and the wrong "Loaded bubbles" comment corrected; braces escaped in the spoken name. Switch: none. Tests added: 2 source guards. Civil 19,182 total, 19,162 passed, 19 skipped, 1 failed (known red).
4. **#1526** (Settings rows): `f1ab1589` to `3cb4c807`. Fixes: tallest tab 673 px down to **670 px** (150% fit test green; it now also fails above 670 px, in all five screen cases); progress hint now says a command-line line about once a second, no status bar, no Esc; wrong-layer hint no longer promises "moved back"; the 16 settings pictures re-taken. Deviation: ticks NOT moved to Newer tools (measured 703 px there). Per-tab desired heights at 150%: before, Fixes col0 371, col2 374, col4 365, Newer tools col0 373, col2 about 310; the Newer tools right column has about 60 px spare and the three ticks need about 93. Trimmed spacing on the Drawing checks heading and ticks and on the new Double-click tick instead. Switch: none changed. Tests added: 0 new tests (one assertion added to the existing fit test; row-tab expectations unchanged). Civil 19,188 total, 19,168 passed, 19 skipped, 1 failed (known red).
5. **#1548** (Manager outcome lines): `41b326cf` to `41d921d9`. Fix: Manager skips CEBLOCKS while `CE_CVL_SUITE` is loaded (Civil already logs it), logs it when Civil is not loaded. Switch: reuses Civil's, ON, unchanged. Tests added: 2. Manager 903 total, 903 passed (the whole Manager suite is about 900 tests; this is its real size, not a wrong-reference run). Manager net48 build 0 errors.
6. **#1535** (Manager support): `96c27b5b` to `b7d77f17`. Fix: the palette-tile test that failed on purpose is now `[Ignore]` with its reason. The palette tile itself is not fixed (protected file). Switch: none. Tests added: none. Manager 866 total, 865 passed, 1 skipped (that test), 0 failed.
7. **#1547** (Structural outcome lines, base `claude/rel-20261022s2`): `7406cfb4` to `61ce20de`. The review read the earlier head `c6672ca3`; the branch already had a second commit. Fixes: command-name list keeps the loadable types if one type fails to load (`ReflectionTypeLoadException`). The MEDIUM (copy Manager's safer JSON reader and its tests) was already in `7406cfb4`, so no change. Switch: reuses Civil's, ON. Tests added: 1. Structural net10 by class chunks (Sbeam evidence class left out): about 5,258 passed, 0 failed; net48 test project builds 0 errors.

### Group B

8. **#1549** (eng small): `23d6f3da` to `5f37da1b`. Fixes: R-03 grade text prints one decimal, with "is just flatter than" when the one-decimal figure equals the limit (the 20000.04 case reads "actual 1:200 is just flatter than the ladder minimum 1:200"); new test keeps the engine's own Glen Eira 24-115 discharge sum honest (within 20 per cent of 5.87 L/s); the two Glen Eira back-tests renamed `...IssuedDischarge_WithinTolerance`. BUG-866 not marked fixed. Switch: none. Tests added: 2. Civil **19,164 total, 19,145 passed, 19 skipped, 0 failed** (this PR clears the known red).
9. **#1530** (eng real length): `afc45df8` to `e8c70789` to `f18585ad` (two commits). Fixes: the robot check text no longer expects exactly 24 m. CD snaps pipe ends to the inside pit walls, so the drawn pipe is about 23.4 m with 600 mm pits; the robot must assert R-03 Warn and that the length shown equals the pipe's own polyline length read with `vlax-curve-getDistAtParam`; same-plan case still 50 m. Corrected in the PR REGRESSION_LOG and in `CODEX_BUILD_ENG_REAL_LENGTH_22OCT.md` (item 1a, 9, 13; edited in this repo of plans). Also: fallback wording "the drawing was not read for this check" when no read was tried (LOW 1, five existing tests updated), unreadable pipe logged once per pipe per drawing (LOW 2), and the second commit makes the fallback test accept both "1:170" and "1:169.7" (clash with #1549). LOW 3 (`RulebookLevelsCheck`, no caller yet) left. Switch: none. Tests added: 2. Civil 19,182 total, 19,162 passed, 19 skipped, 1 failed (known red) on `e8c70789`; the second commit was checked with a 74-test focused run and by the merged-train run.
10. **#1531** (eng pit floor): `4a438d26` to `147a0ded` to `cd54b9c2` to `67ae72de` (three commits, one more than asked: the last two came from the merged-train run). Fixes: a pit with no recorded floor keeps the pre-#1531 rule, so a pump station keeps the deeper of inlet and outlet and its step-iron note (cover 11.00, inlet 9.00, outlet 10.50 reads 2.00, not 0.50) and an ordinary pit with an inlet only goes back to the inlet instead of blank; with a floor, depth is to the lowest of the floor and the pit's pipe inverts (as CDRULES R-29). Hint texts updated. Second commit: `Default: on.` documented on the setting (the #1536 census needs it). Third: Fixes page bottom padding and one tick margin trimmed so the merged train stays at 670 px. Switch `pitScheduleUsesPitFloor`: ON (unchanged). Tests added: 6 new cases, 3 expectations moved to the true rule. Civil 19,193 total, 19,173 passed, 19 skipped, 1 failed (known red) on `147a0ded`. BUG-869 not marked fixed. Pictures not re-rendered (see clashes).
11. **#1538** (eng TWL units): `9821c80c` to `bf311924`. Fix: default flipped to ON (model default, both service reads, doc line `Default: on`), tests that pinned OFF now pin ON, typed OFF kept, a metre drawing reads 1,413.7 L with no switch typed. Switch `detention.twlUsesDrawingUnits`: **ON** (was OFF). Tests added: 1 (plus 2 rewritten). Civil 19,172 total, 19,151 passed, 19 skipped, 2 failed: known red and the PDF render timeout (passes alone: focused run 65 of 65). A Settings row is still owed (Codex window lane). BUG-871 not marked fixed.
12. **#1546** (FB-08): `6f0423d7` to `eb613325`. Fix: code comment that a record's missing type reads Stormwater (default 0), no behaviour change. Switch: none (old behaviour is the fault; change is live). Tests added: none. Civil 19,168 total, 19,148 passed, 19 skipped, 1 failed (known red). BUG-572 not marked fixed.
13. **#1545** (FB-10): `fba3f674` to `8ed03233`. Fix: a survey stored with an Unknown revision, later flagged, now reads "was stored with an unknown revision, and it has changed on disk since review. Run CDSURVEY again." (LOW 3). Switch: none. Tests added: 1. Civil 19,169 total, 19,149 passed, 19 skipped, 1 failed (known red). BUG-707 not marked fixed.
14. **#1540** (FB-03): `07010c09` to `9ae7f1d6` to `50e5efa4` (two commits). Fixes: default ON (model default and the service read), tests that pinned OFF now pin ON, typed OFF kept, REGRESSION_LOG records the side effect (a drafter's own BEDIT change to PB3 now survives opening). Second commit: documented default on `UserSettings.pits` (census clash with #1536). Switch `pits.skipCurrentPitBlockRedefine`: **ON** (was OFF). Tests added: 1. Civil 19,172 total, 19,152 passed, 19 skipped, 1 failed (known red) on `9ae7f1d6`; the second commit is a doc comment, re-run on `50e5efa4` shows 19,172 total, 19,151 passed, 2 failed (known red and the PDF load flake). A Settings row is still owed. BUG-793 not marked fixed.
15. **#1533** (xclmtxt, Structural): MERGE as is. Head `40c9a97735a7ff55f52568d796ba41d5c0d1997f`, unchanged. Nothing done, no comment.

## Final heads (all verified against `gh pr list` at the end)

1. #1524 `e1a59824c536a9b4359236f8fe94163b0219e311`
2. #1536 `d463134aae07ccf03fc66ab88a4844f3783386cd`
3. #1527 `f64420f453537ea046304207187b9d85b2ae053e`
4. #1526 `3cb4c807aca45e9d0ca5443bab7c016a27d38eeb`
5. #1548 `41d921d9f8323d158fb0cec5b12b67fdf3a7977f`
6. #1535 `b7d77f17d95081aa65ee75c38b6572916fb79203`
7. #1547 `61ce20de2e5f7c87dfd7e7bf5855e11bdde3a3fc`
8. #1549 `5f37da1b18d8d4499b3e9c80402cda480adf2afa`
9. #1530 `f18585ada58e0e848a63b660e07d0ad5b0fe5cd0`
10. #1531 `67ae72de32f8af3082d55f726e3efb6d0be10e0a`
11. #1538 `bf311924360ba24dbb882a56fe4f02fb45fbd650`
12. #1546 `eb6133251cf8f14ac5d8b7371bdc1a1c62bc8d05`
13. #1545 `8ed032335cc9b85bb5e0db9b4cbc6f65257b1f34`
14. #1540 `50e5efa42c673118934d984de4e599c36aecd439`
15. #1533 `40c9a97735a7ff55f52568d796ba41d5c0d1997f`

## The dry merges (git merge-tree, objects only, no refs)

Method: `git merge-tree --write-tree` for each PR in turn onto the running result, parent chain made with `git commit-tree` (objects only). Run twice: once on the heads as I found them (heads after fix commits 1 to 13), once after the three follow-up commits.

1. **C-61, `claude/rel-20261022m` @ `40ee0a36`, order #1524, #1536, #1527, #1526, #1548, #1535, #1549, #1530, #1531, #1538, #1546, #1545, #1540.**
   1. **REGRESSION_LOG.md** clashes at every step after #1524 (all prepend at the top): keep every entry.
   2. **#1531 against #1526:** `docs/image/V3_WINDOWS/settings-dark-8-fixes.png` and `settings-light-8-fixes.png` (add/add, binary). Keep one set and re-render on the merged train. This is the only clash beyond REGRESSION_LOG.md.
   3. **Nothing else clashes in text.** #1536 after #1524 is now clean (the test no longer pins the old call).
2. **S-42, `claude/rel-20261022s2` @ `2c9a9694`, order #1547, #1533:** only REGRESSION_LOG.md (#1533). #1547 merges with no conflict.
3. **Merged-train results (heads before the three follow-ups, dry commit `34129dd0`):** Civil 19,419 total, 19,386 passed, 22 skipped, **11 failed**. The 11: `NewSettingsKeys_NeedADocumentedDefault` (UserSettings.pits), `UnavailableOrInvalidObjectLength_FallsBackWithAnExplicitReason` five cases ("1:170" against "1:169.7"), and the five "Settings fits ..." cases (tallest tab 687 px against 670). Each was a real clash between PRs, none a fault in one PR alone. Fixed by: #1540 second commit, #1530 second commit, #1531 third commit.
4. **Merged-train results after the follow-ups (dry commit `9c3e1e2c`):** Civil 19,419 total, 19,397 passed, 22 skipped, 0 failed. Manager 916 total, 915 passed, 1 skipped, 0 failed. net48 plugin build 0 errors. S-42 dry commit `fde39a55`: Structural.Tests net10 by class chunks about 5,703 passed, 0 failed (includes #1533's 445 focused tests).
5. **Not run on the merged train:** Structural net48 tests, DesignCore, Installer.Tests, the Sbeam evidence class, anything in AutoCAD or accoreconsole. The REGRESSION_LOG.md conflict markers in the dry tree were left as they were (throwaway tree, not pushed).

## What I could not do, or did differently, and why

1. **#1526 tick move to Newer tools:** not done; it measures worse (703 px). Reason and numbers in the entry above. The result still meets the goal (670 px, 150% fit green).
2. **#1526 LOW 11 (leave out the "different colour or linetype" row until it is connected):** left as is; its tooltip already says it does nothing yet.
3. **#1535 palette test:** the Ignore message has no BUG number because none exists; the desk owes a Carpark entry (I was told not to edit `BUG_CARPARK.md`).
4. **#1548 / #1535 LOW:** the new Manager log (`ce_manager_structured_*.log`) is still not on the CESUPPORT zip allow-list. Add it when both land.
5. **#1547:** the head had moved past the one reviewed (`c6672ca3` to `7406cfb4`); the reader fix was already in. LOW items 11 and 12 (nested native commands, no Structural Settings row) left.
6. **#1531 pictures:** the two `settings-*-8-fixes.png` pictures in the PR were not re-rendered (they clash with #1526). Re-render once on the merged train.
7. **#1538 and #1540 Settings rows** remain owed (Codex window lane). With no row, the only way to switch them off is the settings file.
8. **#1540 default:** the review suggested OFF now and ON after FX-03. Shipped ON per the desk instruction; FX-03 is still owed in real AutoCAD, on copies.
9. **Build lock:** `C:\CE_PLAN\desk_jobs\build.lock` was a stale 0-byte file dated 03:16 when I started. My scripts wrote and removed it for the first runs. From about 04:58 onwards the writes failed with "Device or resource busy" (another process held a handle), so later builds ran without taking the lock. I did not see a second build of the same worktree, and every build used its own worktree `C:\ce-fx\w` and its own TEMP. I did not delete the lock file.
10. **Test totals:** all Civil runs are in the 19,000s. Manager runs are 866 to 916 (the whole Manager suite). Structural runs are chunked, so a few classes whose names are prefixes of others can be counted twice; treat 5,703 as "about".
11. **Disk:** `C:` stayed at 98 to 99 per cent used (about 19 GB free) the whole time. My worktree `C:\ce-fx\w` was removed at the end; my helper scripts and logs stay in `C:\ce-fx` (`build.sh`, `test.sh`, `b48.sh` were already there; I added `prepend.sh`, `runchunks.sh`, `drymerge.sh`, `notes.txt`).
12. **Commit messages** name each bug in full (BUG-863, BUG-866, BUG-869, BUG-871, BUG-572, BUG-707, BUG-793); PRs #1527, #1526, #1548, #1535, #1547 and #1530 have no bug number of their own.

## Left untouched, as instructed

#1534 (wording, HOLD: garbled characters), #1528 (test state, HOLD), #1537 (pipe material, HOLD), #1551 (move-pit, HOLD), #1539 and #1550 (holds), #1541 to #1544 (notes only), and every PR not listed.

## What is still owed (the four words)

1. **Built:** yes, every PR, net10 (and net48 plugin builds).
2. **Tested:** unit tests only; totals above.
3. **Installed:** no.
4. **Tim-accepted / Codex-accepted:** no. Every checklist that was owed in AutoCAD before this round is still owed, plus: #1530 (snapped length, not 24 m), #1531 (pump station with no floor, pipe below the floor), #1538 (metre drawing), #1540 (FX-03 with the switch ON).
