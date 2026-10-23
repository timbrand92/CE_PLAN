# Opus review of the PR pile, batch 5 (class E, positions 43 to 54), Sat 24 Oct 2026

Headless job, desk plan/03, Team (Opus 5.5). Started 05:24 Melbourne time. Read only: no build, no test run, no AutoCAD, nothing pushed to a PR branch, nothing merged, closed or labelled. My own copy of the repo was `C:\ce-tr\b5.git` (borrows objects from the triage copy; the local clone was not touched).

Input: `areas/PR_PILE_TRIAGE_2026-10-24.md`, class E, items 43 to 54: #1232, #1233, #1234, #1235, #1236, #1238, #1242, #1243, #1245, #1246, #1256, #1260. None has a `REVIEW_*.md` entry, so none was skipped.

Compared against: installed Civil 3.0.72 / Manager 1.1.72 = `claude/rel-20261023m` f7f7d551; installed Structural 1.0.122 = `claude/rel-20261023s` e6d597c0 (both fetched from GitHub at 05:26); planned C-63 = `claude/rel-20261024m` 28987b73; S-43 = PRs #1695 to #1699.

## ANSWER FIRST

1. **Counts:** 1 MERGE, 1 MERGE-WITH-FIXES, 2 HOLD, 8 REJECT.
   1. **MERGE:** #1243 (Help note on Undo and Redo, Civil, next Civil train C-64).
   2. **MERGE-WITH-FIXES:** #1245 (Structural menu bar, next Structural train S-44).
   3. **HOLD:** #1246 (Civil Settings page, needs rebuilding on today's Settings window), #1260 (Structural checklist test, waits for its repair).
   4. **REJECT, already done another way in the installed code:** #1232, #1233, #1234, #1235, #1236, #1238, #1242, #1256. These can be closed (Tim's call; I closed nothing).

2. **The triage report again missed earlier verdicts.** All 12 already have an Opus verdict in `release-v3-colleagues-REVIEWLANE_LOG.md` (round 10, 12 Oct; round 11, 20 Oct; entries 985 and 989, 17 Oct). The verdicts below are on the current heads against the installed code, and they agree with the earlier ones except where noted.

3. **Top faults:**
   1. **Eight of twelve are stale.** The Manager hunt fixes of 9 Oct (HUNT-M-09 to M-15) and the Civil ones (HUNT-C-11, the BUG-586 repair) are already installed. Merging these now would duplicate or undo installed work.
   2. **#1245 starts with the fix switched OFF.** By default Structural still turns the menu bar back on at every start, so the bug stays for everyone. Manager already leaves the menu bar alone by default. Flip it.
   3. **Found while checking #1234 (not this PR's fault): BUG-486 is not really fixed in the installed Manager.** The short update-folder names sit behind the switch `shortStagingFolders`, which starts OFF. So nobody gets the shorter paths unless the switch file is edited. That is a signed-update file, so it needs Tim's word before anyone changes it.
   4. **#1246 would not compile on the installed code** (one Settings box, "record pipe ends off a pit", is declared twice) and it clashes with today's Settings window in two files.

4. **Safe to merge today:** **#1243** only. Its one conflict is the change log (keep both entries).

5. **Nothing here touches CE_SHARED. Two touch installer or signed-update files:** #1234 (update staging), #1235 (Manager install service). Both are REJECT anyway, so no HOLD for that reason. No new hard block. No PR adds a write on an automatic path between a U and its REDO; #1245 removes one.

---

## Per PR

1. **#1232 @ 604931f9 (BUG-485, Manager): REJECT, already installed.**
   1. **Cause real:** it was. The installed code already fixes it: `CeAdminStorageService.cs` lines 122 to 210 catch the office-folder failure, keep the reports waiting and use the plain sentence "Could not reach the office folder; reports will wait on this PC." (commits 3fdea24a and c88d3bdb, PR #873).
   2. **Verdict reason:** a second copy of the same fix (design rule 1). Agrees with round 11.

2. **#1233 @ 64a8d952 (BUG-484, Manager CEHEALTH): REJECT, already installed.**
   1. **Installed:** `PluginManagerCommands.cs` lines 250 to 257 already add the Manager line, the Civil and Manager pair line and the "two copies found" lines (commit 5a344c73, PR #877).
   2. Agrees with round 11.

3. **#1234 @ bac3a16d (BUG-486, Manager short update folder): REJECT, already installed (behind a switch).**
   1. **Installed:** commit b71d1139 already shortens the staged folder name, behind the Manager switch `shortStagingFolders`.
   2. **But the installed switch starts OFF** (`CeOneGlanceStatus.cs` line 245: "Default OFF = the old long name"). A bug-fix switch must start ON. In plain words: on a colleague's PC with a long Windows name, getting an update ready on AutoCAD 2022 to 2024 can still fail.
   3. **The one useful extra in this PR:** the temporary copy folder `.preparing-<32 characters>` is still longer than the short final name in the installed code. This PR cuts it to 12 characters.
   4. **Recommendation:** close this PR. Open one small new PR that turns `shortStagingFolders` ON by default and shortens the `.preparing-` folder. It touches the signed-update staging file, so it needs Tim's word first.

4. **#1235 @ c8f2598f (BUG-487 item 14, first install per-user): REJECT, already installed.**
   1. **Installed:** commit 280e7681 (HUNT-M-14) already sends a first install to `%APPDATA%\Autodesk\ApplicationPlugins` (`CePluginInstallerService.cs` lines 41 to 47). The only remaining `C:\ProgramData` line is the folder scan list, which is right.
   2. Round 10 said MERGE (train C-38). It was superseded by the HUNT-M-14 commit, so the verdict changes to REJECT.

5. **#1236 @ 47813304 (BUG-487 items 12 and 13, feedback count and hover text): REJECT, already installed.** Commit f31c325f (HUNT-M-12/13) changes the same five files the same way. Round 10's MERGE is superseded.

6. **#1238 @ da33bd23 (BUG-487 item 15, plain start-up lines): REJECT, already installed.** Commit 4d8ce52a (HUNT-M-15) already gives plain start-up sentences, sends the Windows error to the trace file only, and lists CEMANAGERADMIN only to the administrator. Two copies of the same wording class would break design rule 1.

7. **#1242 @ 85730fdb (BUG-465 item 11, SPS pump-pit number): REJECT, already installed.**
   1. **Installed:** `PitCommand.cs` `ComputeNextSpsLabel` (line 1044) works from the numbers in use, so SPS1 + SPS3 now gives SPS2, never a second SPS3.
   2. **Open question for Tim (not decided here):** fill the gap (today: SPS2) or always go one above the highest (SPS4). Round 10 recommended "never re-use" because a re-used SPS2 can clash with an erased pit's leftover label or schedule row. If Tim wants that, it is a one-line change in a new PR.

8. **#1243 @ 9f96e506 (BUG-558, Help note): MERGE, train C-64.**
   1. **Cause real:** yes. Driver run 19 lost Redo the same way in plain AutoCAD with every CE bundle parked; the trigger is a view change in the other drawing. So it is AutoCAD's behaviour, and a help line is the right fix.
   2. **Fix does only that:** adds one heading and one sentence to the Civil Help guide, between the intro and "Start with a task". Both anchors are still in the installed guide. No command, setting or drawing output changes.
   3. **Test fails without it:** yes. The new test looks for the exact sentence in `guide-content.js`, which the installed guide does not contain.
   4. **Fixes:** none to the code. Merge conflict in `REGRESSION_LOG.md` only: keep both. Round 10's "log heading" LOW is cured on this head.
   5. **Tim's word:** the log says "Tim's wording to confirm". Not a merge blocker.

9. **#1245 @ 9f6c124d (BUG-566, Structural forces the menu bar on): MERGE-WITH-FIXES, train S-44.**
   1. **Cause real:** yes, still in installed Structural 1.0.122. `CuiMenuGeneratorService.cs` line 1419 sets MENUBAR to 1 without looking, every start-up, through `Plugin.cs` lines 217 and 224.
   2. **Fix does what it says:** reads MENUBAR first, never writes it when it is already 1 (which also protects Redo), and obeys a new switch `MenuBar.LeaveAlone`. The typed CEADMIN repair still turns the bar on, so round 11's MEDIUM ("prints MENUBAR=1 but does not set it") is cured.
   3. **Test fails without it:** the policy tests are on new code; the source guard `TheMenuLoad_AsksThePolicyBeforeItWritesMenubar` fails on the old line. Good enough.
   4. **Fix needed (MEDIUM): the fix starts switched OFF.** `LeaveAlone` defaults to false, so a drafter who keeps the menu bar hidden still gets it back at every start. That is the bug. Change the default to true, or copy Manager's installed rule (`CeSuiteManagerMenuService.ShouldSetMenuBar`): when the drafter has not chosen, only turn the bar on if the CE ribbon is not drawn. Flip the test `TheSwitch_IsOffByDefault_SoTodaysBehaviourIsKept` to match.
   5. **LOW:** the switch has no box on the Structural Settings page (file only). Manager has its own matching switch (`forceMenuBar`), so a drafter must set two files for one wish. Say so in the AutoCAD steps, or add a box later.
   6. **Conflicts:** `REGRESSION_LOG.md` only, against installed Structural. None with S-43 (#1695 to #1699 touch other files).
   7. **AutoCAD check after merge:** set MENUBAR to 0, close AutoCAD, start it: the menu bar stays hidden. Then CEADMIN repair: the menu bar comes on.

10. **#1246 @ eea027eb (BUG-546, Civil Settings "New features" page, 15 switches plus #1208's 23 values): HOLD, rebuild on today's Settings window.**
    1. **Cause real:** yes. In installed Civil 3.0.72, none of the engineering values this PR adds a box for (minimum self-cleansing speed, scour speed by material, minimum grade by diameter, pit outlet speeds, X-Civil snap distances, detention defaults and so on) has a box. All 37 setting names it writes do exist in the installed Settings file (checked one by one).
    2. **Why HOLD, not small fixes:**
       1. **Does not compile on installed code (HIGH):** the "record pipe ends off a pit" box is already on the installed "Newer tools" tab, and this PR declares it again.
       2. **Clashes** in `CivilSettingsView.xaml` and `AdvancedSettingsViewModel.cs` with installed Civil and with C-63. Today's window has three tabs (Civil defaults, Newer tools, Fixes); this PR adds its rows to a different layout from 9 Oct.
       3. It carries all of #1208 inside it, which is still open.
    3. **What is good and should be kept:** the save writes only changed values; range checks only warn and keep the typed value (no new hard block); the 15 switch defaults are not changed.
    4. **Fixes for the rebuild:** drop the duplicate "record pipe ends off a pit" row; take "Source edition to be confirmed by Tim" and "Tim decides which stay on" out of text colleagues see (say "office value" instead); put the rows on one new tab of the installed window, using the Newer tools pattern and its save path.
    5. **It is a window:** it needs Codex or Tim to look at it in AutoCAD before it counts as accepted.

11. **#1256 @ b56b2250 (BUG-586, Pit Schedule custom note test): REJECT, already installed.** The test file this PR adds is already in installed Civil, byte for byte (same file fingerprint 7bffce10), together with the repair (commits b27c49d2 and 13a77f38, PR #1286). Only the log entry differs. Close it. Agrees with entry 1019.

12. **#1260 @ 6e01714a (BUG-609, Structural checklist after the last drawing closes, tests only): HOLD, merge only with the repair.**
    1. **Cause real:** yes, in installed Structural 1.0.122. Only "drawing activated" reaches the checklist refresh (`MainPalette.xaml.cs` line 72); the "drawing closing" handler (line 1017) only stops the change tracker. So the closed drawing's checklist stays on screen.
    2. **The test is intentionally failing.** Merged alone it would turn the Structural test run red, so it must travel with the repair.
    3. **Fix needed in the guard (MEDIUM, from entry 989, still true):** the test accepts the "drawing about to close" event as the refresh route. At that moment AutoCAD still reports the closing drawing as current, so a refresh there would show the closing drawing's checklist again. Accept only "drawing closed" or "drawing became current", plus a "No drawing open" state.
    4. **Conflicts:** `REGRESSION_LOG.md` only. None with S-43.

---

## What I did NOT check

1. **Nothing was built or run.** No test was run; "fails without it" is from reading the test against the installed code.
2. **No AutoCAD, no Help browser.** I did not see the #1243 note on screen or the #1246 window.
3. **#1232:** I checked the office-folder copy in the storage service, not every button handler in the Manager and admin windows.
4. **#1246:** I did not check that each of the 37 values is actually read by the command it describes (BUG-546 says some, such as the default pipe diameter, are ignored in places). A box that changes nothing would mislead; check this in the rebuild.
5. **C-63 clashes** were checked with a trial merge for the Civil PRs only (#1243, #1246, #1256); Structural against S-43 by file list.
6. I did not post PR comments, close anything, or touch any branch.
