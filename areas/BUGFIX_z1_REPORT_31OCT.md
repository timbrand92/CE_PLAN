# BATCH Z-1 report (Structural, key z1, build B-107, Sat 31 Oct 2026)

## FOR TIM

1. **Draft PR #1933 is open** (against claude/rel-20261026s): "B-107 BUG-626 FFL offers Manual and Unknown level source with a live preview (switch ON)". Built and unit-tested only. Nobody has opened it in AutoCAD.
2. **What you will see:** type FFL. It asks "Level source [Manual/Unknown] <Manual>". Manual asks for the level value as before. Unknown asks nothing more and writes the plain word Unknown. Then the whole mark (triangle, tail and value) follows the cursor. F flips the side, a click places it, Escape draws nothing.
3. **Only FFL changes.** RL, SSL, NGL and LM keep their old questions. A locked 25DIMS/25TEXT layer or an open REFEDIT still stops FFL with the same one line before anything is drawn.
4. **Settings switch:** Annotation.FflOffersSourceAndPreview, ON by default. OFF gives the old FFL exactly (point, side, value, draws at once). There is no row for it on the Settings page yet (that is a window, so Codex).
5. **Mistakes of my own:** I ran two stray empty python commands by mistake; one hung for 2 minutes and I stopped it. No harm to files. My first test run failed because the new rule file used an AutoCAD type the test machine cannot load; I fixed it and re-ran.
6. **Not proven:** the preview itself, F, click and Escape in real AutoCAD. A Codex look is needed.

## CE 02 steps (copy of a drawing, Structural built from the PR)

1. Type FFL, press Enter at the source question (Manual). Type +150, Enter. Move the mouse: the triangle, tail and +150 follow it. Press F: it jumps to the other side. Click: one mark is drawn on 25DIMS (triangle, tail) and 25TEXT (value). Undo once removes all three.
2. Type FFL, type U (Unknown), Enter. No value question. Move, click: the text reads Unknown (not 0, not blank).
3. Type FFL, Manual, 150, then Escape during the preview: nothing is drawn (check object count unchanged).
4. Lock 25DIMS, type FFL: one plain line, nothing drawn, no questions.
5. Switch control: set Annotation.FflOffersSourceAndPreview to false, restart: FFL asks "Pick level point:" then side then value and draws at once, no preview.
6. Suggested robot case N-style `Z1_ffl_source`: types FFL, Enter, +150, then a click; check the TEXT is +150. Control `Z1_ffl_unknown`: FFL, Unknown, click; check the TEXT reads Unknown. Switch-off control: the first prompt is "Pick level point:".

## TECHNICAL

1. **Start point:** origin/claude/rel-20261026s 204dfad2 (Structural 1.0.125). Fault re-checked there: RunDirect (LevelMarkCommands.cs) still asked point, side, value and drew at once. Worktree C:\CE_WORK\build\z1, branch claude/z1-ffl-source-preview, removed and cleaned.
2. **Files:** new Core/Symbols/FflSourcePreviewRule.cs (no AutoCAD: source words, value text, flip, drag-result reading, mark layout), new Commands/LevelMarkSourceFlow.cs (prompts, DrawJig preview, placement), 8-line branch at the top of RunDirect after the REFEDIT stop, switch in Models/UserSettings.cs (AnnotationSettings, "Default: on."), label in SettingsService.LoadRecovery.cs, REGRESSION_LOG.md entry, Bug626FflSourcePreviewTests (11 tests).
3. **Design:** the placed mark and the preview use the same layout numbers (triangle 5, tail 10, bar offset 1.25, text gap 2, times DIMSCALE). F is handled in the jig and the drag restarts (same pattern as the BUG-622 note flip). Nothing is written to the drawing until the click; one undo mark and one transaction. No XData, group or tag (REDO-safe). The source choice is not stored with the mark.
4. **For z2 (FFL group):** build on LevelMarkSourceFlow.Run and FflSourcePreviewRule.Layout. Jig is private inside LevelMarkSourceFlow.
5. **Tests:** Bug626FflSourcePreviewTests, Bug1082LevelMarkLockedLayerTests, LabelTextHeightRuleTests, S45NewSwitchDefaultsTests, SettingsLoadRobustnessTests, ColleagueDefaultsStructuralTests: all pass on net10 (22, then 52, then 54 tests; counts not zero). Switch default pinned through DeserializeSettingsTolerant (blank file, old file without the key, typed false stays). There is only the tolerant start-up reader in Structural (no plain DeserializeSettings). net48 compile of CE_STRUC_SUITE: Build succeeded, 0 errors. Full Structural suite NOT run (job rule). One test project per run, with a filter, -m:2, SkipDevBundle.
6. **Shared files and open drafts seen:** gh search "LevelMarkCommands.cs": only #1736 (BUG-1082, old base rel-20261023s; its change is already in the start point). UserSettings.cs: #1918, #1904, #1927, #1842 and others; SettingsService.LoadRecovery.cs: #1908, #1901, #1902, #1918 and others. All of them add their own lines; mine are one property after SectionMarkSkipLetters in AnnotationSettings and one line after Annotation.SectionMarkSkipLetters in the label list, so a textual merge clash on those two lines is possible but I did not edit their lines. CE_SHARED untouched.
7. **Test environment:** CE_STRUC_SUITE_APPDATA_ROOT, CE_LOG_DIR_OVERRIDE, TEMP, TMP set to C:\CE_WORK\scratch\z1\* and printed before every run. Nothing created at the root of C:.
8. **Real-files listings** (names, sizes, times; full lists saved in my scratchpad, 33,446 lines before, 33,450 after). Folders: TIM_CE_CADTOOLS, CE_STRUC_SUITE, CE_CVL_SUITE, CE_CADTOOLS. Before 17:51, after 17:55. AutoCAD (acad.exe) was open and in use, and I did not touch it. Changed or new during the window: TIM_CE_CADTOOLS\CD_Settings.json (15,270 to 15,298 bytes, 17:53:06), CD_RecentValues.json (17:54:55), CE_Admin outbox machines/usage/sessions files, TIM_CE_CADTOOLS\logs\ce_struc_structured_20261031.log, CE_STRUC_SUITE\logs\ce_struc_suite.log (grew 3,775,214 to 3,777,225). The Structural settings file CE_STRUC_SUITE\CS_Settings.json did NOT change (35,613 bytes, 30 Oct 19:54:14). My tests are Structural only with the redirected folders, so these changes come from the live AutoCAD session (heartbeat files and logs), but I cannot prove that for CD_Settings.json, which is Civil's: **flag for CE 01**, I did not open it.
9. **Disk:** C: free 43.02 GB at start, 43.01 GB at end (moved about 0.01 GB). Worktree and scratch removed.
10. **Finished:** Sat 31 Oct 2026 17:57 Melbourne time (the machine clock reads AEST/AEDT as AUSEST 17:56:54 at cleanup).

## NOT tested

1. Anything in AutoCAD (preview drawing, F, click, Escape, Undo, the 25DIMS/25TEXT result, the Unknown text). 2. RL/SSL/NGL/LM flows (not changed, not run). 3. The full Structural suite, Civil, Manager. 4. net48 test run (compile only). 5. Settings page row (does not exist).
