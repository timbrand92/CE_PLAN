# Train C-57 finalizer report (Civil + Manager), Tue 20 Oct 2026 (run on the real clock Wed 21 Oct 04:25 to 04:45)

## ANSWER FIRST

1. **Verdict: GO.**
2. **Final head:** `claude/rel-20261020k` at `a76f8caf22ab0160883715b6f8921ac6a893993a` (normal fast-forward push from `081a5a83`; ls-remote equal after the push). Start head `081a5a83` was equal to the assembly report (checked with ls-remote before any work). Base: the installed line `claude/rel-20261020j` @ `581b0e7b` (Civil 3.0.66 / Manager 1.1.66, C-56).
3. **What I changed (LOUD): one test-only commit, `a76f8caf`. No plugin code changed.**
   1. **Why:** #1493 gives Manager the CE_VERSION command. This Civil + Manager line still carries the old Structural source (the removal is #1503, which is in Structural S-39, already installed). So three guard tests were red on the train: the two Drainage `CrossModuleGuardTests` the assembler found, and one more the assembler did not run: `CE.CommandTruth.Tests` "CE_VERSION must have exactly one compiled owner" (Structural and Manager). All three were green on the base (CE_VERSION was Structural's only there).
   2. **What:** Manager command count 11 to 12. For CE_VERSION only the exact pair Structural + Manager is let through; Structural alone, any third owner or any other duplicate still fails. Each allowance has a new check that goes red the day #1503 reaches this line, so it is removed then (and the Structural count drops by one). REGRESSION_LOG entry added.
4. **Manager must ship: YES.** #1493 changes Manager code, its installer file and its command list. Civil and Manager keep the same CE_SHARED (`Shared/` unchanged: 0 files).
5. **Install order (Structural first): already satisfied on Tim's PC.** The installed Structural 1.0.119 (S-39) lists no CE_VERSION in its installer file and none of its three DLLs registers it (checked the files). So the Manager bundle is NOT refused by the installer's command-ownership check. On a PC with an OLD Structural that still lists CE_VERSION, the Manager update WOULD be refused ("An older enabled CE command owner must be disabled before installation ... Commands: CE_VERSION"). Colleague PCs need S-39 (or later) before this Manager.
6. **Tests (Release, final head):**
   1. **Whole solution:** 0 errors.
   2. **Civil net10 full:** 19,040 run, 19,020 pass, 19 skipped, **1 failed (Glen Eira, the known red)**. The two new reds from the assembly are green.
   3. **Manager net10 full:** 837 of 837.
   4. **CE.CommandTruth.Tests:** 65 of 65 (was 63 of 64 at `081a5a83`).
   5. **Civil net48 focused:** 198 of 198 (RedoSafe, DoubleClick, Bug416, Bug385, CeVersion, Bug852, CrossModuleGuard, CivilNetworkSelect).
   6. **Manager release build (PrepareReleaseBundle):** "Complete 75-file, three-lane release candidate verified", 0 errors. File count unchanged at 75 (the new window is compiled into the Manager DLL, no new file), so the guard in `CE_SUITE_MANAGER.csproj` needs no change. CE_VERSION is in the bundle's installer file (three lanes) and in each lane's command list.
   7. Installer.Tests: compiled, not run (rule).
7. **What Tim will see in AutoCAD (once installed):**
   1. **CE Tools > Version (or typing CE_VERSION)** opens the "About CE Suite" window with Civil, Structural and Manager versions. Today, with S-39 installed and Manager 1.1.66, CE_VERSION is an unknown command; this train brings it back.
   2. A suite that is not loaded reads **"Not loaded"**. A suite loaded twice reads **"CONFLICT - 2 copies"** in the theme's red, bold.
   3. **Right-click a CE pit or pipe > "CE: Select this run" / "Select whole network" / Edit:** looks the same. The difference is hidden: with TWO drawings open, the click no longer saves CE's waiting record into the other drawing at the click; it is saved at that drawing's next command or save.
8. **Do not mark FIXED:** BUG-416 (residual path, #1502) and BUG-852 (#1493). Neither has been driven in AutoCAD. The version window has not been looked at.
9. **Switches without a Settings row:** none added by this train. This train adds no switch and changes no default.
10. **Risks:**
    1. **MEDIUM, BUG-416: #1502 is very unlikely to be the whole cause of Codex V1-01.** With only ONE drawing open, the write #1502 removes cannot run (CE's record is either already that drawing's, or there is no other open drawing to owe a save to). So if the Codex retest still says "Nothing to redo" with one drawing open, the cause is elsewhere. Reading the code, nothing else in the click writes. The remaining suspects are outside what reading can prove: AutoCAD itself (a selection set by a right-click menu item outside a command), the selection watcher, or the Inspector palette. The control test in REVIEWLANE entry 1511 (LINE, U, click, right-click, Escape, REDO) separates AutoCAD from CE.
    2. **LOW install order for colleagues** (item 5).
    3. **LOW the click's call-graph guard now cannot see the save** because it is handed in as a delegate; the source guards (`writeOwedSave: null` in the click bind) are what keep it honest.
    4. **Tim's `CD_Settings.json` was NOT unchanged during my run:** 9d27b04c (15,302 bytes, file time 21 Oct 04:16:37) at 04:28; acd64e79 (15,270 bytes, file time 4 Oct 08:22:30) at 04:39. A file time of 4 Oct means it was put back from a copy, not written by a test. AutoCAD was running at 04:28 and closed by 04:39; robot run 43 was committed at 04:34. Likeliest cause: that robot run swapping and restoring the file. Not proven. The other three files were unchanged (622a246f, efe307c4, f68eeb5e).

## 1. Re-review of MERGE-WITH-FIXES PRs

1. **#1493: reviewed head 6352fba0 (entry 1501, MERGE-WITH-FIXES, 1 HIGH, 1 MEDIUM); merged head 4746cfa9** (second parent of `081a5a83`).
   1. **HIGH (install order): answered.** The Structural removals left this PR (now #1503, in S-39, installed). This PR keeps only the Manager side. Install order is satisfied on Tim's PC (ANSWER item 5).
   2. **MEDIUM (central register): answered.** `ce-tool-register.json` Manager row 11 to 12 with the new fingerprint; CommandTruth's central-register check passes.
   3. Nothing else changed between the reviewed and merged heads beyond the moved tests (now checking the Manager side only).
2. **#1502 had no Opus entry** (1511 is a fix draft). Reviewed fully below.
3. **Shared/:** 0 files changed. **Installer/:** 0 files changed. **Modules/Manager:** changed (#1493).

## 2. Adversarial review

1. **#1502 (BUG-416 residual): GO, 0 fixes.**
   1. **All three right-click items** (Select this run, Select whole network, Edit) now bind through `BindToDrawingForRightClick`; no handler uses the writing bind (source guard).
   2. **The owed save is kept, not lost:** the click skips the save; the existing kept-record step then parks the record for its own drawing, and it is written at that drawing's next command end or save (the same path used since #617). A preview holding writes, or a closed drawing, drops it with a CE log line, as before.
   3. **Every other bind is unchanged** (still saves the owed record first).
   4. **The call-graph guard lost its one exemption**, and the PR reports it failed first. LOW: the graph cannot follow the delegate, so the source guards carry the proof (risk 10.3).
   5. **Rest of the click path read-only:** record load is an open-close read; an old project file only marks a save waiting (#1170); the pit check, network walk, selection and message write nothing. Edit then queues CDEDIT, which is a command, so REDO ends there as with any command.
   6. **Whole cause? Very unlikely** (risk 10.1).
2. **#1493 (BUG-852 Manager half): GO, 1 test-only fix (mine).**
   1. CE_VERSION registered once in Manager (`PluginManagerCommands.ShowVersion`), listed in all three lanes of the Manager installer file and the CE.Host list (and removed from CE.Host's Structural list), command list 12 rows, approved list 12.
   2. **Version window:** reads only which CE DLLs AutoCAD has loaded; nothing written. Matching is by exact name or name plus "_" (so `CE_STRUC_SUITE.DesignCore` is not miscounted as a second Structural). "Not loaded" when absent; CONFLICT when two copies. The red is `UiDangerBrush` from the theme (no new colour; a stock red is only a fallback if the theme is missing).
   3. LOW: the window always uses the light theme (merged in its own file), like the old Structural window.

## 3. New defaults

1. **Switches or defaults added:** none (no settings file, model or default changed).
2. **Behaviour change without a switch:**
   1. **#1502:** the right-click no longer writes into another drawing. The old behaviour is the bug (BUG-416). Nothing visible changes.
   2. **#1493:** CE_VERSION moves to Manager. Tim's ruling, 20 Oct item 8: "move version into manager". The old behaviour (version only with Structural) is the bug (BUG-852).
3. **Nothing had to be turned OFF.**
4. **Switches without a row:** none from this train.

## 4. Installer safety

1. **#1475 is not on this train** (landed earlier, REVIEWLANE entry 1481).
2. **No file under `Installer/`, `Installer.Tests/` or `Shared/` changed** between `581b0e7b` and `a76f8caf`, so the signed-update gate (OfficialReleaseGate) **cannot be affected**.
3. The only installer-facing effect is the command-ownership check in item 5 of the ANSWER FIRST block.

## 5. Test evidence

1. **Environment:** private worktree `C:\ce-fin\c57` (detached), Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, 0-byte `CE_TRANSFORM_2027.arx` placeholder, AutoCAD 2027 folder on a short PATH, fresh TEMP and CE log folder per step, Below Normal, every command in the foreground. Build lock held only while each command ran (no waits).
2. **Timings:** solution 2 min (re-run incremental 35 s, 0 errors); Civil net10 5 min 4 s; Manager 8 s; CommandTruth 33 s; net48 focused 9 s; Manager release build 5 s.
3. **Manager release build** used the CE_SHARED lanes from my own solution build at this commit (`Legacy 5210666B`, `Net8 211D11AD`, `Modern 02E3B996`). The installed Civil and Manager carry identical CE_SHARED (checked).
4. **Not run:** Installer.Tests (compile only), Structural, full net48, anything in AutoCAD or accoreconsole.

## 6. Hygiene

1. Worktree `C:\ce-fin\c57` removed (`git worktree remove --force`, prune); `c57tmp` and `c57logs` removed. `C:\ce-fin\logs` is not mine and was left. The plugin checkout's working tree is as found.
2. No PR closed, no branch deleted, no version bumped, nothing installed or deployed, DESK_LOG.md not edited. Structural, #1382, #1384, #1419, #1423 not merged.
3. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.
