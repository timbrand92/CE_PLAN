# Review fixes applied to six Civil and Manager PRs, Sun 25 Oct 2026

Job: desk plan/03, Team (Sonnet). Contract: `REVIEW_OPEN_PRS_25OCT.md`. Built and unit-tested only. Nobody has opened any of this in AutoCAD. No PR was closed, retargeted or merged, no branch deleted, no force-push, no bug marked FIXED, no version bumped, DESK_LOG.md and BUG_CARPARK.md not edited, CE_SHARED untouched.

## ANSWER FIRST

1. **All six fixes are pushed** to their own PR branches as normal fast-forward commits. Every live head matched the head the review named before I started. No PR was skipped.
2. **#1753 (BUG-1051), slab fall:** old head `0217714d`, new head `bb34aaee`.
   - **What changed:** added the switch `surface.slabFallUsesDrawingUnits`, shipped ON. OFF gives the old reading (levels as millimetres against the plan units as drawn), for a metre-labelled drawing that is really drawn in millimetres.
   - **Tests added:** new object ON, old file ON, OFF gives 1:10 in a metre drawing, a millimetre drawing is the same either way, and a source guard that all four callers pass the drawing's units.
   - **Totals:** Civil net10 20,258 total, 20,226 passed, 32 skipped, 0 failed. Civil net48 test project compiles, 0 errors.
3. **#1734 (BUG-1040), flat pipe warning:** old head `7617ff57`, new head `eb3a2889`.
   - **What changed:** the line now says "Its levels are kept as they are and the rest of the cascade goes ahead - check that pipe's levels." The test checks the new words and fails if "went ahead" returns.
   - **Totals:** Civil net10 20,254 total, 20,222 passed, 32 skipped, 0 failed. net48 compile 0 errors.
4. **#1735 (BUG-1043), blank end level:** old head `45e9ddfe`, new head `46376980`.
   - **What changed:** all three sentences now say "...is blank: it is saved blank (Unknown) and no fall or grade is worked out." Tests updated (one blank end, and both blank).
   - **Totals:** Civil net10 20,254 total, 20,222 passed, 32 skipped, 0 failed. net48 compile 0 errors.
5. **#1743 (BUG-1049), CDEDIT batch blank field:** old head `7afad0d4`, new head `2a85890d`.
   - **What changed:** the one old-settings-file test line is added. The keep-both clash in `UserSettings.cs` is resolved by merging the base `claude/rel-20261025o` into the PR branch (the only way to remove a clash with the base): both the new `batchBlankFieldIsLeftOut` switch and the base's five switches stay.
   - **Side effect to know:** the PR's diff against its old GitHub base `claude/rel-20261023m` now also shows the base's own changes, because the branch carries the merge. Against `claude/rel-20261025o` it is just the BUG-1049 change.
   - **Totals:** Civil net10 20,253 total, 20,221 passed, 32 skipped, 0 failed. net48 compile 0 errors.
6. **#1738 (BUG-1047), CE Blocks frozen layer (Manager):** old head `81d1772c`, new head `c5774cf2`.
   - **What changed:** with the switch ON a refusal says "[CE] Layer X is locked. No block was placed." (the one-block path says it inside its own sentence, without a second "[CE]"). With the switch OFF the old "locked or frozen" words stay. Two tests on the redirected settings file (an old file without the element loads ON; a saved OFF reads back OFF) plus two wording tests.
   - **Totals:** Manager net10 1,005 total, 1,004 passed, 1 skipped, 0 failed. Manager net48 product project compiles, 0 errors. The Manager version bump is still owed at train time (not done here).
7. **#1723 (BUG-703, BUG-704, BUG-783 and BUG-604), BD05 tests:** old head `55f65b33`, new head `b27b96b6`.
   - **What changed:** the two Bug604 cases now feed 0.000 / -0.350 and look for "0.00" / "-0.35". The log's "BLOCKED validation" line is replaced by the real result.
   - **One extra change the review did not list (needed to get 0 failed):** the first full run on the merged tree had 1 failure, the base's BUG-318 guard `NoTestFile_WritesIntoDocsImageV3WindowsItself`. The PR's test wrote its window pictures straight into `docs/image/V3_WINDOWS`. It now saves to `TestPaths.ScreenshotFolder`, as every other window test does. The review's focused run missed it because the guard is a different test class.
   - **Totals (second run, after the change):** Civil net10 20,255 total, 20,223 passed, 32 skipped, 0 failed. net48 compile 0 errors. The two Bug604 cases pass.
   - **The commits were squashed** into one commit (unpushed at the time) so its message names all four bugs.

## How each was checked

1. **Heads:** read live with gh before touching each PR; all six equal the review's heads. Re-read just before each push; none had moved.
2. **Where tested:** each fix was committed on the PR head, then the base `claude/rel-20261025o` (`2c805a39`) was merged into the worktree without committing (the REGRESSION_LOG.md clash resolved keep-both), built and tested, then the merge was aborted before the push. So the tested tree is the PR plus the base, which is what the train gets. The pushed commits are the PR head plus the fix only, except #1743 as above.
3. **Build rules kept:** foreground builds one at a time, under `C:\CE_PLAN\desk_jobs\build.lock`; every build and test used `-p:SkipDevBundle=true -nr:false --disable-build-servers` with the refs from the C-62 assembly report (`_AcadRef48`, `_AcadRefNet8`, `_AcadRefNet10` = AutoCAD 2027 folder, `_AcadRef100`); AutoCAD 2027 on PATH; a 0-byte placeholder arx; a fresh TEMP and log folder per step (inside TEMP, in Windows backslash form). C: free space was 14 to 15 GB before every build (stop line 12 GB).
4. **Leak scan:** clean on every push. Commit messages each name every bug in full and end with the attribution line.
5. **Private worktrees:** one per PR under `C:\ce-fx` (p53, p34, p35, p43, p38, p23), all removed. My local branches `fx/pr1753`, `fx/pr1734`, `fx/pr1735`, `fx/pr1743`, `fx/pr1738`, `fx/pr1723` are left in the main repo's list (not deleted, per D6); they hold the same commits that were pushed.

## My mistakes, with cost

1. **A wrong escape in a test file (#1738):** a shell heredoc turned `'\\'` and `D:\\Palettes` into single backslashes, so the Manager test project did not compile. Cost: one wasted Manager run, about 12 minutes of waiting on the build lock. Fixed with the Edit tool and amended before the push; nothing wrong was pushed.
2. **Manager tests failed on my run folder:** my first Manager run used a forward-slash TEMP path, so the Bug842 guard (and my new tests that copy its pattern) refused it: 7 failures, none of them product faults. Re-run with a backslash TEMP path: 0 failed. Same trap the review reported.
3. **A queued Manager job ran the Civil suite by mistake:** I killed it before it built.

## What I did NOT do or check (RULES 5.9)

1. **AutoCAD:** nothing opened in AutoCAD or accoreconsole. Built and unit-tested only.
2. **RED proof:** not re-run. The OFF-switch and old-wording tests prove the old behaviour in code, not by running the old build.
3. **Full net48 tests:** net48 test lanes do not load on this PC, so only compilation was checked (Civil test project and Manager product project).
4. **Manager net48 test project:** there is none (Manager tests are net10 only).
5. **Pictures:** the BD05 window pictures were not generated or looked at.
6. **Structural:** not in scope (#1737 and the CEMEMBER holds are untouched).
7. **Settings page rows:** none of the switches has a Settings page row (still owed, window lane).

## Heads for the train builder

1. **#1753** `bb34aaee823048d15c9c7dadf48754531bf1f722`
2. **#1734** `eb3a2889e53382df00885cc60841f8341f889b0f`
3. **#1735** `4637698090bb70bcff36cf56f37638cabc70e0af`
4. **#1743** `2a85890d79661435ca0d6b8731ce105334b7cc03`
5. **#1738** `c5774cf2818d7f7c9bde1c3ce9c2177fa4ed13aa`
6. **#1723** `b27b96b65ef8d9318f046499e0e23b5f94b612db`

**Train note:** new-switch defaults test should now also pin ON `surface.slabFallUsesDrawingUnits` (#1753). The #1743 branch already contains the base merge, so merging it onto `claude/rel-20261025o` is a no-op for the base side.
