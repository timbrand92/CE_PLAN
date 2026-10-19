# Train C-46 finalizer report (Civil + Manager), Mon 19 Oct 2026 night (about 22:24 to 22:50, Melbourne time)

**ANSWER FIRST**

1. **Verdict: GO.** Train `claude/rel-20261019b`, final head `1de8d3fdc704bd871b1ceca0b445b1ebc1dd0e25` (was 9638622b, checked against origin before starting; one finalizer commit on top, normal fast-forward push, leak scan clean). Built and unit-tested only. Nobody has opened it in AutoCAD. Nothing installed, deployed or version-edited; AutoCAD and accoreconsole were not touched.
2. **Nothing reverted.** All 25 PRs stay in.
3. **What I changed (commit 1de8d3fd):** one `REGRESSION_LOG.md` entry, the train record. **No code, no default, no test changed.** The code I built and tested is exactly the 9638622b code.
4. **Fix rounds:** every MERGE-WITH-FIXES head (#1439, #1456, #1458, #1469) and the three newer LOW rounds (#1441, #1453, #1470) cure what their review entries asked (diffs read, not titles). The three hand merges (#1444, #1454, #1462) hold both PRs' changes. Every merged PR has an Opus review entry. One new LOW (#1456, section 1).
5. **Manager must ship: yes.** 12 Manager files change. The Installer also changes (#1442 to #1444). #1449, #1458 and #1462 change CE_SHARED, and the built CE_SHARED is byte-identical in Civil and Manager on all three runtimes. Ship Civil, Manager and the Installer together from this commit.
6. **The installer's safety check (#1442) is still safe.** Only one extra file, the installer's own staging receipt with its exact name, may now sit beside the three signed files. The signature, the trusted key, the record and every file hash are still checked. An unsigned or tampered update is still refused.
7. **New Settings switches: none.** One new saved value, a one-time marker for BUG-825 (not a choice). Nothing needed turning OFF.
8. **Tests at the final head:**
   1. **Whole solution, Release:** 0 errors, 889 warnings (same as the assembler).
   2. **Civil net10 full:** 18,830 run, 18,810 pass, 19 skipped, **1 failed**: the known Glen Eira back-test. The blank-PDF render test the assembler saw fail once **did not recur**.
   3. **Manager net10:** 815 of 815.
   4. **Civil net48 focused:** 279 of 279 (the 12 changed classes, RedoSafe, DoubleClick, plus PiiHash, SettingsService, RulebookEngine). No stub-lane fix needed.
9. **Your settings files:** unchanged (checksum read before and after).

---

## 1. Fix rounds and hand merges (diffs read)

1. **#1439 (BUG-814), MEDIUM cured.** Spine sentences now say "an unnamed pipe" instead of a gap or a handle, in both junction sentences and the attachment line. Two tests added.
2. **#1456 (BUG-829), MEDIUM cured.** Manager no longer creates the shared policies folder. It copies a local administrator list to the shared folder only when that folder already exists and the person on the PC is on the list. The compile clash with #1454 is gone.
   1. **New LOW:** that "is on the list" check compares names exactly, without the "CE\tim" tidy-up #1450 added elsewhere. A list holding "CE\tim" is then simply not copied. That fails safe (nothing is written), so it is LOW. Carpark suggestion: use the same name rule.
3. **#1458 (BUG-828), build fault cured.** The new ribbon test is wrapped so the net48 test project builds. The whole solution builds with 0 errors.
4. **#1469 (BUG-848), split done.** Only the upload fix is left. #1459's CE Blocks settings fix is intact in the train.
5. **#1441 (BUG-820), LOW cured.** The Recover Inverts line names the pipes (at most five), never by handle.
6. **#1453 (BUG-827), LOW cured.** The held-file warning now says checks use CE's standard values, and that saving in Settings now would replace the office file.
7. **#1470 (BUG-835), LOW cured.** "v3.0.56" and "3.0.56" count as the same version.
8. **Hand merges:** #1444 (installer tests: both PRs' tests present, compiles), #1454 (both helper blocks kept, three-part read), #1462 (two cancels first, then the click log line without the drawing name).
9. **LOW items left by the lanes, judged again: all truly LOW, accepted.** #1439 (spine fingerprint changes once), #1444 (two version-reading edge cases; nothing passes the approved version yet), #1449 (Structural salt, in #1466 for S-train), #1450 (other-domain names match), #1452, #1454, #1461, #1462, #1448, #1463, #1473, #1476, #1469, #1458.

## 2. Shared code and Installer

1. **CE_SHARED is the same for Civil and Manager.** Built `CE_SHARED.dll` checksums match in Civil, Manager and CE_SHARED's own output for net48, net8 and net10.
2. **#1442, the release gate:**
   1. Only the Installer passes the extra name, `ce-update-stage.json`, matched exactly (letter case included).
   2. Any other extra file still fails the check. A linked (shortcut-style) receipt is still refused.
   3. The signed record, the signature against the trusted key, the summary and the bundle hashes are checked exactly as before.
   4. The signing and approval tools pass nothing, so they stay strict.
3. **#1444, LOW:** if a caller ever passes an approved version that cannot be read as a number, nothing is refused. Nothing passes it today.
4. **Nothing runs the Installer on a build.** No project, props or targets file changes in the train. Installer tests were compiled, never run.

## 3. Settings defaults

1. **New switches: none.**
2. **New saved value:** `options.oldStartingValuesMoved` (BUG-825). It marks that CE has made its one-time move of old starting values. Your file already holds 6.0 m/s and 250 mm, so nothing moves on your PC.
3. **Behaviour changes with no switch.** Each fixes behaviour that is itself the bug:
   1. A ribbon click cancels a running command first, as AutoCAD's own buttons do.
   2. A typed 3.0 m/s stays 3.0 after a restart.
   3. Saving one settings window no longer undoes the other window's change.
   4. The Civil tab no longer rebuilds under you.
   5. Disable on Restart leaves the pipe-object file loading.
4. **Switches without a Settings page row:** none new. C-45's 32 still have none (standing R-00 LOW; not built, per the job).

## 4. What you will see in AutoCAD after this train is installed (none of it seen in AutoCAD yet)

1. **CDCHECKS:** rows say "unnamed pipe" or the two pit names, never a code like "1093C7".
2. **Tidy labels and MOVE:** the "no clear spot" line says "a pipe", never "pipe 11C65B".
3. **Recover Inverts:** erase one of a pipe's two IL texts and run it. A line names the pipe and says nothing was drawn for it.
4. **Settings (CDS):**
   1. Set Maximum pipe velocity to 3.0, Save, restart. It is still 3.0.
   2. If the settings file is held by another program at start-up, a line says CE is on standard values for now.
5. **CEMANAGER Civil page:** Reset Civil leaves values that page does not show alone. Saving there keeps a value you saved in CDS meanwhile.
6. **Ribbon:**
   1. Start TEXT, then click a CE button. TEXT is cancelled and the CE command starts.
   2. About 35 seconds after start-up the Civil tab no longer flickers.
   3. With Show the old CE tabs ON, the old layout stays.
7. **CEMANAGER:**
   1. Disable Civil on restart, then open a drawing with CE pipes. The pipes keep their grips; no grey proxy boxes.
   2. The Admin Dashboard counts "v1.0.118" as behind 1.0.119.
   3. Pressing Approve twice keeps the right roll-back version.
   4. One bad report file no longer blanks the dashboard.
   5. A not-yet-downloaded administrator list says so, with what to click.
   6. "CE\tim" in the administrator list now lets you in.
8. **On colleagues' PCs (Installer):** a staged update installs instead of stopping on the receipt or on the pipe-object file. An older stage installs with a warning.

## 5. Do not mark FIXED

1. **Everything in this train is built and unit-tested only:** not installed, not tested in AutoCAD, not Tim-accepted, not Codex-accepted.
2. **Stays OPEN even after an AutoCAD pass:**
   1. BUG-372 (block-name half, Recover Inverts line).
   2. BUG-814 (parts 1 and 4).
   3. BUG-820 (your call: draw the missing end?).
   4. BUG-829 (colleague set-up route).
   5. BUG-832 (Manager-only approval and the status line).
   6. BUG-834 (rolled-back stage; your question, section I item 5).
   7. BUG-838 (installer half is #1475, not in this train).
   8. BUG-846 (Structural salt, #1466, Structural train).
   9. BUG-847 (no PR in this train: #1474 not yet fixed).
   10. BUG-849 (lock-out half).
   11. BUG-850 (needs the AutoCAD look #1463 asks for).
   12. BUG-430 (its diagnostic, #1477, is not in this train).
3. **Full lists:** review entries 1308 and 1333.

## 6. Risks

1. **Unit tests and source guards only.** The drawing-level proof is the Codex pass.
2. **Installer tests never run on this PC.** BUG-823, 824 and 834's fixes are read, compiled and reviewed, not exercised. The first real colleague update is their first run.
3. **Left for C-47:** #1474 (BUG-847), #1475 (installer half of BUG-838), #1477 (BUG-430 log lines). Their fix rounds are not pushed yet.
4. **Not run:** Installer tests, CommandTruth, TestHarness, Spine, Diagnostics, AI.Core, ReleaseTests, Structural (no Structural file changed), Manager on net48, the full net48 lane, each PR alone, AutoCAD, accoreconsole.

## 7. Hygiene

1. Worked in a private worktree, `C:\ce-fin\c46`, detached at the input head.
2. The build lock was taken only while each command ran and is released.
3. Every run used Below Normal priority, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, `_AcadRef48` CERef 24.3.0, `_AcadRefNet8` the TimOS 2026 ref folder, AutoCAD 2027 on PATH for tests, an empty placeholder transform file, CE logs in fresh Temp folders.
4. **Your settings files, checksum at 22:24 and 22:45, unchanged:** `CD_Settings.json` 15,270 bytes; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713; `CE_STRUC_SUITE\CS_Settings.json` 34,858; `CE_CVL_SUITE\settings.json` 672.
5. AutoCAD was not running at the end. No PR closed, no branch deleted. `DESK_LOG.md` not edited.
