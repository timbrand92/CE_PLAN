# Structural batch S-15 report (B-091), Sat 31 Oct 2026, job s15

## FOR TIM

1. **Two fixes are built as draft PRs. Nothing has been opened in AutoCAD.** Built and unit-tested only, not accepted.
2. **PR 1912, BUG-1186 (bearer tags on a locked layer):** if 25TEXT (or BEARERS - SUBFLOOR, or STUMPS AND PIERS when you place stumps) is locked, CSTAGBEARERS now says "Layer 25TEXT is locked, so CE drew no bearer tags. Unlock it and try again. Nothing changed." and adds nothing. No more "Tagged 1 bearer(s)". CE never unlocks the layer. I also gave CSSUBFLOORGRID the same check, because it writes on the same three layers and would fail the same way.
3. **PR 1913, BUG-1187 (mistyped lineweight):** in CE Admin Settings, Drawing Layers, typing "typo" in the Lineweight cell and pressing Save Layer Changes now leaves the layer as it was and shows a plain message naming the layer and what you typed. Valid weights (0.50, 0.50 mm, Default, ByLayer, ByBlock) save as before. If you changed another cell on that row in the same save, that edit is also not saved until the weight is fixed.
4. **BUG-473 (BT1, C1, TS1, BTX and locked layers): ALREADY FIXED, no PR.** The installed Structural line (1.0.125) already stops BT1, C1, TS1 and BTX with one plain line when their layer is locked, and BTX leaves locked text alone. It is still OPEN until someone confirms it in AutoCAD.
5. **What to test in AutoCAD (after a build is installed):**
   1. **BUG-1186:** lock 25TEXT. Run CSTAGBEARERS on a line, size 150x50 F17, No stumps. Right = a refusal naming 25TEXT, no new objects, no "Tagged" line. Then unlock 25TEXT and run it again: it tags as before.
   2. **BUG-1187:** make a layer AUDIT-WEIGHT at 0.50 mm. CEADMINSETTINGS, Drawing Layers, type "typo" in its Lineweight cell, Save Layer Changes. Right = a warning box, the cell goes back to 0.50, the layer is still 0.50. Then type 0.25 and save: it changes to 0.25.
6. **Mistakes of my own:** the first test start failed because a new worktree needs a "Hosted restore" first (about 1 minute lost), and the first net48 compile reported one error that was only the post-build check not finding PowerShell on this job's path (no code error; re-run clean). No effect on the PRs.

---

## ANSWER FIRST (technical)

1. **PRs (both DRAFT, base claude/rel-20261026s, titles start with B-091 from register item 152):** #1912 `claude/s15-bug1186` (commit 27b51979), #1913 `claude/s15-bug1187` (commit 77001e12). Neither is merged or closed.
2. **BUG-473: ALREADY FIXED** by commit 06af5e65 (9 Oct 2026, "HUNT-S-08: BT1/AB/BB/C1/TS1/BTX respect a locked layer"). On origin/claude/rel-20261026s (204dfad2): BT1 `Commands/BracingCommands.cs:250-255`; AB `:19`, BB `:135`; C1/TS1 `Commands/SupportBlockCommands.cs:226-232`; BTX `Commands/BeamTextConvertCommands.cs:97` and `:155` (locked text left alone and counted, message `LockedTextMessage`); tests `Modules/Structural.Tests/Commands/HuntS08LockedLayerTests.cs`. No PR opened.
3. **Not proven:** both fixes in real AutoCAD (lock behaviour with a real locked layer; the warning box and reloaded row of the Layer Manager window); the net10 full suite was NOT run (task rule: focused classes only).
4. **Robot case proposal (for CE 02), style N31_dp_time:**
   1. **S15_tagbearers_locked25text:** draw a line on layer 0; lock layer 25TEXT; type `CSTAGBEARERS`, pick the line, Enter, `150x50 F17` Enter, `No` Enter (if it reaches the preview the switch is broken). Checks the command-line line contains `Layer 25TEXT is locked, so CE drew no bearer tags` and that the count of objects on 25TEXT is unchanged (0) and no `Tagged` line appears. **Switch-off control:** set `TimberSubfloor.LockedLayerRefusesTagging` to false before AutoCAD starts (settings are read at launch), same typing: it must print `Tagged 1 bearer(s)` and add one text object on 25TEXT (the old fault).
   2. **S15_layerweight_typo (C-style window case, needs a Codex look for the box):** create layer AUDIT-WEIGHT with lineweight 0.50; open CEADMINSETTINGS, Drawing Layers; type `typo` in the Lineweight cell; press Save Layer Changes. Checks the layer's LineWeight reads back 50 (0.50 mm) and the status line starts `Lineweight "typo" is not a lineweight`. **Switch-off control:** `Options.LayerLineweightTypoKeepsOriginal` false before launch: the layer reads back as Default (-3) and the status says `Updated layer AUDIT-WEIGHT`. Note: the Layer Manager grid is likely not pressable by the runner (see the runner press lists memory), so this one may stay a Codex look.

## What changed (files)

1. **PR 1912:** `Core/Subfloor/SubfloorLockedLayerRule.cs` (new, pure rule), `Services/TimberSubfloorService.cs` (`RefuseIfOutputLayerLocked`, called before the preview in both commands), `Models/UserSettings.cs` (`TimberSubfloor.LockedLayerRefusesTagging`, first property of the class, documented "Default: on."), `Services/SettingsService.LoadRecovery.cs` (label), `REGRESSION_LOG.md`, tests `Core/SubfloorLockedLayerRuleTests.cs` (7 pass: locked 25TEXT/bearer/stump layer named; stump layer ignored when no stump is placed; none locked; switch off returns the old behaviour; the switch loads ON from `{}`, from an installed-line file without the key, from a damaged file (value-by-value path) and a typed false stays).
2. **PR 1913:** `Services/LayerService.cs` (`LineweightFieldError`, pure), `UI/LayerManagerWindow.xaml.cs` (`BtnSaveRow_Click` checks first), `Models/UserSettings.cs` (`Options.LayerLineweightTypoKeepsOriginal`, "Default: on."), `Services/SettingsService.LoadRecovery.cs` (label), `REGRESSION_LOG.md`, tests `Services/Bug1187LayerLineweightTests.cs` (typo, empty, spaces, 0.5x, 0.47 refused with the layer and value named; valid weights not refused; switch off returns the old silent Default; same default-on checks through the tolerant reader). Note: Structural has only `DeserializeSettingsTolerant` as its start-up read (no separate `DeserializeSettings`), so both its paths (normal and value-by-value) are pinned.
3. **Cause found:** BUG-1186: `TimberSubfloorService` lines 204-224 (tag) and 101-121 (grid) wrote on three layers with `EnsureLayer` (creates only, never checks lock). BUG-1187: `LayerRow.ToSnapshot` fell back to `ByLineWeightDefault` when `TryParseLineweight` failed, and `BtnSaveRow_Click` then wrote it and said "Updated layer".
4. **Not built:** the pick-list of valid weights suggested in BUG-1187.

## Tests run (all one project, with a filter, net10.0-windows Release, -m:2, below normal, scratch env)

1. `SubfloorLockedLayerRuleTests`: 7 passed.
2. `TimberSubfloor | NewSwitchDefaults | SubfloorLockedLayerRuleTests`: 32 passed.
3. `Bug1187LayerLineweightTests | Bug367LayerKeepTests | NewSwitchDefaults`: 48 passed.
4. net48 compile of `CE_STRUC_SUITE.csproj`: 0 errors (after adding Windows PowerShell to the job's PATH for the post-build binary check).
5. Env echoed in every run log (`C:\ce-fx\s15_<step>.log`, first line): `CE_STRUC_SUITE_APPDATA_ROOT` and `CE_LOG_DIR_OVERRIDE` under `C:\ce-scratch\s15\run_<step>`. No Manager, Civil or full Structural suite run. No test names the .sln.

## Shared-file clashes seen

1. **PR 1906 (B-084, BUG-1185, branch claude/s8-bug1185-1200)** edits `TimberSubfloorService.cs` (the pick loop around line 145-170, the apply loop around 219, and `TryGetEndpoints`) and `UserSettings.cs` (after `DefaultStumpPierSizeLabel`, and in `FootingWidth`). My edits sit at lines 91 and 192 (a call before `PreviewMarks`), a new helper before "Shared mark logic", and the first property of `TimberSubfloorSettings`. Expected: a plain textual merge, possible small conflict near line 192. After 1906 merges, with `TagBearersLabelOnly` on, only 25TEXT is written for a tag, but my check still also refuses when BEARERS - SUBFLOOR is locked (conservative; a one-line follow-up if you want it relaxed).
2. **PR 1895 (BUG-1184, bearer and stump marks)** also touches `TimberSubfloorService.cs` (the mark logic, `PreviewMarks` area, which my edits sit next to at lines 91 and 192). Not read line by line; expect a small textual conflict at most. I did not edit `PreviewMarks` or the mark engine.
3. **Searches run (gh pr list --state open --search):** `TimberSubfloorService` gave #1895, #1906, #1142 (older, BUG-534, span table), #647 (older, BUG-388); `LayerService` gave many older Structural and Civil drafts, none on `LineweightFieldError` or the save path (#889 is the already-merged-in-line HUNT-S-08 draft); `LayerManagerWindow` gave only #1142 (not read line by line); `UserSettings.cs` gave the S-7, S-8, S-13, S-14 and other drafts (#1903 to #1911 among them), all adding properties elsewhere in the file. My additions are at the top of `TimberSubfloorSettings` and `OptionsSettings`, so only an adjacent-line conflict is possible.

## Real-files compare (names, sizes, last-write; no contents)

Listings: `C:\ce-fx\s15_before.txt` (taken 04:43:17 on 31 Oct, 32,550 files) and `C:\ce-fx\s15_after.txt` (taken 04:59:56, 32,546 files plus 6 new). Folders listed: `%APPDATA%\TIM_CE_CADTOOLS` (with CE_Admin\outbox and logs), `%APPDATA%\CE_STRUC_SUITE`, `%APPDATA%\CE_CVL_SUITE`, `%APPDATA%\CE_CADTOOLS` (with CE_Admin).

1. **Result: 32 lines differ, all with last-write 04:44:09 to 04:45:35, and no real file changed after 04:45:35.** None of my test runs wrote there (every run had `CE_STRUC_SUITE_APPDATA_ROOT` and `CE_LOG_DIR_OVERRIDE` set to scratch; first test process started 04:44).
2. **What changed (not by my tests, my reading):** `CD_Settings.json` (15335 to 15270 bytes, last-write back to 2026-10-04 08:22:30: the doubleClick keys restored by a robot run), `CD_RecentValues.json`, `ledger\suggestions.jsonl`, four new `CE_Admin\outbox\usage` files, the machine and session JSON for CE_CVL_SUITE, CE_STRUC_SUITE and CE_SUITE_MANAGER, `cdcheck-CLDV...txt` (a Civil CDCHECK output, which no Structural test runs), and the CE_CVL and CE_STRUC logs. That pattern is an AutoCAD session (robot) starting and ending between 04:43 and 04:45 on this PC (no acad.exe was running at 05:00). I could not prove who started it from the files alone: it is the robot run the task said may legitimately change them. If you want it checked, CE 02's robot log for 04:43 to 04:46 would show it.
3. **No Structural settings file** (CS_Settings.json) was in the changed list.

## Disk and slots

C: had 49.3 GB free at the start (above the 12 GB rule); build slot count 0 each time; builds ran at below-normal priority with -m:2. Worktree `C:\ce-fx\s15` cleaned with `git clean -fdXq`.

## Questions for CE 04

None.

## Summary

PR 1912 (BUG-1186: `TimberSubfloorService.cs`, new `SubfloorLockedLayerRule.cs`, switch `TimberSubfloor.LockedLayerRefusesTagging`) and PR 1913 (BUG-1187: `LayerService.cs`, `LayerManagerWindow.xaml.cs`, switch `Options.LayerLineweightTypoKeepsOriginal`), both draft on claude/rel-20261026s, title B-091, switches ON, 48 focused tests pass, net48 clean. BUG-473 already fixed (06af5e65). Nothing seen in AutoCAD.
