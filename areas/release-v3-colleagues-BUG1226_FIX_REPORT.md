# BUG-1226 fix report: "Recent:" invert buttons back on the New Pipe window (29 Oct 2026)

## FOR TIM

1. **Answer:** draft PR **#1839** puts the "Recent:" level buttons back under the two level boxes in the one-page New Pipe window (the one CD opens), and in Edit Pipe too. **It is NOT built and NOT tested.** I could not run the build: another job (chain_c76) kept the PC busy for more than two hours and my rule is one build at a time. So this is code written and read, nothing more.
2. **My mistake first:** my waiting script also matched my own session by accident, so it could never see a free PC for the first 80 minutes. I fixed that at 11:45, but chain_c76 then kept running builds until my two-hour limit ended (12:23). About two hours lost, nothing built.
3. **What a drafter will see:** type CD, pick two points. Under the two level boxes there is a line "Recent:" with a button for each recent level, the last pipe's levels first (for example 18.190 then 18.240). Press one and it fills the level box you are in. If there are no recent levels the line is not shown, so the window keeps its one fixed height and does not scroll. Edit Pipe shows the same line.
4. **Edit Pipe:** it had lost them too. It uses the same one-page layout.
5. **Why they vanished:** when the one-page window was built, the old tabs were thrown away and the "Recent levels" row (on the old Levels and Flow tab) was never copied across. They were not dropped on purpose, matching your ruling.
6. **Switch:** `pipe.recentInvertButtonsOnMainPage`, ships ON. Off gives today's window with no row.
7. **What is NOT proven:** that it builds, that the tests pass, that the row fits at the fixed window height with ten buttons (my test checks this but has not run), and what it looks like. Nobody has opened it in AutoCAD.
8. **Robot case:** N30 `N30_recent_invert_buttons_follow_last_pipe` is the guard and needs no change. Switch-off control: the existing twin `N30_..._BROKEN`, plus a run with `pipe.recentInvertButtonsOnMainPage` set false (set before AutoCAD starts) which must FAIL the "Use recent invert 18.19" line.

---

## Technical detail

1. **Branch / PR:** `fb/bug1226-recent-buttons`, commit 07eebe49, base `claude/rel-20261026z` (Civil 3.0.85), draft PR #1839. Worktree `C:\ce-fx\b1226`.
2. **Cause (file and line):** `Modules/Drainage/Dialogs/PipeOnePageLayout.cs` constructor moves rows by binding key (MoveRow lists) then does `tabs.Items.Remove`/`parent.Children.Remove(tabs)`. The `RecentInverts` ItemsControl sits in `PipeEditWorkshopDialog.xaml` lines about 255 to 270 (Levels and Flow tab, "Recent levels:" DockPanel), not on those lists. CD swaps CdDialog for this window in `DialogService.cs` line 42 via `WorkshopPipeCreation.Select`. Edit Pipe: `PipeEditWorkshopDialog.xaml.cs` line 95 builds the same layout. `CdDialog.xaml` lines 956 to 980 still has a "Recent:" row, but that window is replaced when the workshop route applies.
3. **Change:** `UserSettings.cs` new `PipeSettings.RecentInvertButtonsOnMainPage` (`recentInvertButtonsOnMainPage`, default true). `PipeOnePageLayout.MoveRecentLevels` (called after `PairRows(FirstInvert, SecondInvert)` when `RecentButtonsOn`) moves the same DockPanel into the Engineering column after the second-level row, sets the caption to "Recent:", and collapses the row when `HasItems` is false. Same buttons, same `UseRecentInvertCommand`, same automation names ("Use recent invert {0} m AHD"), so N30's text checks and the existing `C2EditorKeyboardTests` naming are unchanged.
4. **REDO safety:** layout only; no new write, command, regen, view or system variable; nothing touches locked layers, Xrefs or REFEDIT. CE_SHARED unchanged.
5. **Tests written (not run):** `Modules/Drainage.Tests/Dialogs/Bug1226RecentButtonsTests.cs`: default ON through `DeserializeSettings` and `DeserializeSettingsTolerant` for four file shapes; typed false turns off only itself; New and Edit windows show ten buttons newest first, none past the right edge, `PipeWindowLayout.Apply` still true at 1920x1032; no row with empty list; switch OFF shows no row. `REGRESSION_LOG.md` entry added (states not built).
6. **Known gaps in my own work:** not added to `C75NewSwitchDefaultsTests` or the Settings page (no row; BUG-1222's switch has none either). The test uses `Descendants` on the unshown window, same as the existing one-page tests, but is unrun, so a compile or assertion fault is possible. Row height with ten buttons in the half-width column may take two lines: the fit assertion will say.
7. **To do before trusting it:** run, one at a time, `dotnet test Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj -c Release -f net10.0-windows --filter "FullyQualifiedName~Bug1226RecentButtons|FullyQualifiedName~PipeOnePageLayout|FullyQualifiedName~C75NewSwitch"` with `-p:SkipDevBundle=true -nr:false --disable-build-servers`, AutoCAD 2027 on PATH (check the test count is not 0), then the full suite and the net48 compile. A 0-byte placeholder `Modules/Shared.Transform.Native2027/bin/x64/Release/CE_TRANSFORM_2027.arx` is already in the worktree (untracked).
8. **N30 note:** its header comment still says the buttons are on the Levels and Flow tab; after this change they are on the main page. The checks need no change. N30 reads the window dump text, so it should see "Use recent invert 18.190 m AHD" before "18.240".
9. **Hygiene:** nothing closed, retargeted or merged; no branch deleted; bug not marked FIXED; BUG_CARPARK.md and DESK_LOG.md not edited. bin/obj were never built, so no clean-up needed. Scratch in `C:\ce-fx\b1226j`.

---

## VERIFIED (second job, 29 Oct 2026, 1:50 pm Melbourne)

### FOR TIM

1. **Answer:** draft PR **#1839** is now built and unit-tested. Nobody has opened it in AutoCAD.
2. **My first version was wrong:** with the Recent row added, the one-page window needed 622 to 636 px at 150% display scaling and only 620 are allowed, so the window would not have fitted for a Charged or Detention pipe with a connected pit. I made the buttons slimmer (smaller text, no extra padding, tucked into the gap above). Now it fits and the window height is unchanged.
3. **What you will see:** same as before: "Recent:" under the two level boxes, last pipe's levels first. The buttons are a little smaller than the old tab's buttons.
4. **Not proven:** how it looks. Slim buttons at 150% may look cramped; the row sits directly under the level boxes with no gap. A Codex look is needed.
5. **Robot case N30 (comment only, do not edit the case):** line 4 says "on the Levels & Flow tab (line 155)" and line 21 says "whose Levels & Flow tab shows a button"; both should say "on the main one-page window under the two level boxes" (line 2 is a long line that also needs checking). Case file: `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_28oct_b3\N30_recent_invert_buttons_follow_last_pipe.case.txt`. Its checks need no change. Switch-off control: set `pipe.recentInvertButtonsOnMainPage` false before AutoCAD starts; the "Use recent invert 18.190" line must then be missing.

### Technical detail

1. **Commit:** 5092bbf9 on `fb/bug1226-recent-buttons` (normal push, on top of 07eebe49).
2. **Faults found and fixed:** (a) tests looked for the buttons in the logical tree, but template buttons exist only in the visual tree (the first test failed twice); fixed with a visual-tree walk. (b) 17 existing `OnePageFitsTheAgreedOwnerArea` cases at 150% failed because the 26 px tall buttons added about 16 to 30 px (default settings carry three recent levels). Without my row the tightest case needs 606 px; the limit is 620. Fix in `PipeOnePageLayout.CompactRecentButtons`: slim button style (MinHeight 0, padding 5,0, font 10), a replacement item template with the same bindings, command and automation name, row margin -2 top, caption margin 0. Tightest case now 620 of 620.2.
3. **Switch test:** `C75NewSwitchDefaultsTests.RecentInvertButtonsSwitch_LoadsOn_ThroughBothStartUpReads` (3 file shapes through `DeserializeSettings` and `DeserializeSettingsTolerant`, plus typed false through both). `Bug1226RecentButtonsTests` already covers four more shapes and the switch-off window.
4. **What ran:** net10 focused (Bug1226RecentButtons, PipeOnePageLayout, C75NewSwitch): 331 total, 331 passed. Full Civil net10 suite: 20,816 total, 20,784 passed, 0 failed, 32 skipped (14 min). net48 build of CE_CVL_SUITE: 0 errors. Test counts were never 0. AutoCAD 2027 on PATH, placeholder arx, SkipDevBundle, two-lane slot check, below-normal priority.
5. **Not run:** the Manager and Structural suites (not touched); no AutoCAD; no screenshot of the window.
6. **Hygiene:** nothing closed, merged or deleted; bug not marked FIXED; CE_SHARED untouched; temporary diagnostics removed before commit; bin/obj cleaned with `git clean -fdXq` in `C:\ce-fx\b1226` only.
