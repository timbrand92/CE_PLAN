# Opus re-check J2: PR #1875 (B-025b, BUG-816), the label tidy after an AutoCAD edit gets its own Settings row

Read-only re-check, Fri 30 Oct 2026, 20:00 Melbourne. Reviewer: Opus (Max). New head `1a6c332b` (was `1c270c45`) on `fb/bug816-tidy-setting-row`, base `claude/rel-20261026z` (`09126560`, Civil 3.0.85 / C-75). Nothing built, nothing run, no AutoCAD. Trial merges used `git merge-tree` only (no branch or working copy changed). Earlier review: `areas/OPUS_PREREVIEW_J_1875_B025_30OCT.md` (KEEP-WITH-NOTE).

Honest deviation: besides the allowed fetch of the PR branch, I also fetched `claude/rel-20261102a` and `claude/rel-20261030a`. That only refreshed the local copies of those branches. No branch was changed or pushed.

## FOR TIM

1. **The main problem from the first review is fixed.** Unticking the box now stops the label slide only after AutoCAD's own edit commands: MOVE, STRETCH, ROTATE, SCALE, TRIM, JOIN and grip edits. Drawing a pipe with CD, saving Edit Pipe, changing a pit size in Edit Pit and splitting a pipe with a source still slide labels clear. The same is true of Tidy labels. I checked every place in the code that starts the slide, and it does what it says. Built and unit-tested only. Nobody has opened it in AutoCAD.
2. **One small wording gap.** The switch also covers BREAK, MIRROR, COPY, OFFSET, ARRAY, EXPLODE and paste when they change an existing CE pipe or pit, because AutoCAD runs those through the same step. The row says "or other AutoCAD edit", so the row itself is true. The pop-up help only names MOVE, STRETCH, ROTATE, SCALE, TRIM, JOIN and grips. The fix is one extra phrase in the help, and it does not need to hold the PR.
3. **The default is right.** The box is ticked unless a drafter unticks it. When it is ticked, CE behaves exactly as it does today. The test that wrongly said "Tidy labels is OFF by default" now accepts whichever default the build has, so it passes on the C-77 and C-78 trains, where Tidy labels is ON (your 29 Oct ruling).
4. **The Settings page still fits.** A new test measures the Drafting tab at 606 px against the 670 px limit. The window is the same width at 100, 125 and 150 per cent, so the figure holds at all three. I could not re-run the test myself. The Survey tab already sits exactly on the 670 limit, but that is not caused by this change.
5. **It merges cleanly** with the C-78 train and with PRs #1868, #1871, #1873 and #1874. The only clash is the change-log file: keep both entries.
6. **Verdict: RE-CHECK OK WITH NOTE.** It joins the train after C-78, on top of `claude/rel-20261102a`. The note: add "or another AutoCAD edit such as BREAK, MIRROR, COPY or paste" to the pop-up help and the catalog, and update the PR description, which still describes the first version. BUG-816 stays open until the robot run below passes.

---

## DETAIL

### 1. Which edits the switch now covers (traced at `1a6c332b`)

1. **The rule:** `Modules/Drainage/Rules/TextClashTidyUpRule.cs` line 117 `IsNativeEditRoute(route)` is true only for `atomic-attachment-move`, `atomic-straight-pipe`, `established` and `established-after-typed-edit` (ordinal match). Line 127 to 128 `SkipsAfterMove(isTidyLabelsCommand, route, switchOn)` = not Tidy labels AND one of those four routes AND switch OFF.
2. **The gate:** `Modules/Drainage/Services/LinkService.TextClashTidyUp.cs` line 118 works out `skipAfterEdit` once. Lines 119 to 123: with no placed-by-hand handles it writes "[TidyUp] route=... skipped: Linking.TidyTextAfterMove is OFF" and returns. Lines 200 and 208 pass it to `TidyOnePipe`. Line 278 returns after the placed-by-hand mark (line 270) and before any planning. `TidyMainOfNewBranch` (line 951) calls `TidyOnePipe` without it (default false), and is only reached when a drawn-pipe handle is passed, which only the draw route does.
3. **Every caller of `TidyTextClashesAfterNativeMove`** (`git grep` at the head; no others outside tests):
   1. **Draw a pipe (CD), route "draw":** `Services/PipeCreationService.cs` line 575. Not a native route, so it always tidies, including the BUG-197 branch-onto-main tidy. Right.
   2. **Edit Pipe save, route "edit-pipe":** `Commands/PipeEditCommand.cs` line 529. Always tidies. Right.
   3. **Edit Pit size change, route "pit-boundary":** `Services/LinkService.PitMoves.cs` line 536, reached through `ReSnapLinkedPipesToPitBoundary` from `PitEditCommand.cs` line 422, `PitEditCommand.Resize.cs` line 149 and `PitEditCommand.Batch.cs` line 720. Always tidies. Right. The same route also serves the pit move inside CD (`LinkService.cs` line 288, `MovePitToPosition`, called only from `CdCommand.cs` line 1390) and the XCIVIL import (`LinkService.RepairAudit.Linking.cs` line 51, called from `XcivilImportService.cs` lines 1282 and 1376). Both are CE's own commands, so always tidying is consistent with the row. They are not named in the help, which is a cosmetic gap only.
   4. **Source split, route "split":** `Services/SourcePlacementService.cs` line 1216. Always tidies. Right.
   5. **Tidy labels (CDTIDYLABELS), routes "cdtidylabels-count" and "cdtidylabels-apply":** `Commands/TidyLabelsCommand.cs` lines 56 and 89. These are not native routes and they also pass an outcome, so they are never skipped (two independent reasons). Right.
   6. **AutoCAD edits:** `Services/LinkService.Reactors.cs` line 751 ("established"), 736 ("established-after-typed-edit"), 1295 ("atomic-attachment-move", the label moved by hand) and 1386 ("atomic-straight-pipe"). All four are skipped with the box unticked. Right.
4. **Which AutoCAD commands reach those four routes:** every command CE tracks in `Services/ExternalMutationCommandPolicy.cs`, lines 15 to 25 (MOVE, -MOVE, GRIP_STRETCH, GRIP_MOVE, GRIP_ROTATE, GRIP_SCALE, GRIP_MIRROR, STRETCH, ROTATE, ROTATE3D, MR/MOVEROT, ALIGN, SCALE, TRIM, EXTEND, LENGTHEN, FILLET, CHAMFER, JOIN, PEDIT), **plus the copy-type list at lines 35 to 46** (COPY, COPYM, COPYBASE, BREAK, MIRROR, MIRROR3D, ARRAY, ARRAYRECT, ARRAYPATH, ARRAYPOLAR, -ARRAY, MINSERT, OFFSET, EXPLODE, BURST, PASTECLIP, PASTEORIG, PASTEBLOCK, INSERT, -INSERT, COPYMULTI, CR, COPYROT). Tracking starts at `LinkService.Reactors.cs` line 1739 (`ShouldStartTracking` = in a CE drawing AND `IsTracked`, which is either list). At command end, `NativeEditCommandEndRoutingPolicy.Classify` gives `ExistingLegacy` for anything that is not an atomic shape, and that falls to the `else` branch at `LinkService.Reactors.cs` lines 745 to 751, which is the "established" tidy. The pipes it tidies (`TidyUpPipesForEstablishedRoute`, lines 1050 to 1058) are the CE pipes AutoCAD changed, the pipes CE re-linked for a pit move, and the owners of moved labels.
   1. **Effect:** with the box unticked, a BREAK of a CE pipe (the original pipe is shortened), a MIRROR with the original erased, or a COPY or paste that makes CE re-link an existing pipe also does not slide labels. This is the same as in the first version, so it is not a new behaviour. The row ("or other AutoCAD edit") covers it. The tooltip and the catalog (`ViewModels/SettingsValueCatalog.cs` line 124) list only "MOVE, STRETCH, ROTATE, SCALE, TRIM, JOIN or a grip edit", and the REGRESSION_LOG item 3 adds ALIGN, EXTEND, LENGTHEN, FILLET, CHAMFER, PEDIT but omits the copy-type list. This is a wording gap, not a code fault. If Tim ever wants BREAK and MIRROR to keep tidying, that would need a command-name check, which is a separate decision. I recommend leaving it as it is.
   2. **ERASE:** not tracked. Nothing tidies after it, ticked or not.
   3. **Undo and redo (U, UNDO, REDO, MREDO):** never tidy. `LinkService.Reactors.cs` lines 628 to 634 drop any waiting tracked work at their end, and line 1726 only suspends. Ticked or unticked makes no difference.
   4. **A pit moving with its label (typed MOVE of a pit):** the pit move is not an attachment-only or straight-pipe shape, so it is "established", and it is skipped when unticked. The pit's own label still follows the pit, because that is a separate follow step and not this slide. That is what BUG-816 asks for.
   5. **A label moved by hand ("atomic-attachment-move"):** with the box unticked the pass still runs because placed-by-hand handles are present. It writes the placed-by-hand mark (D13), then every pipe returns at line 278. No label moves and nothing is printed. The CE log shows "[TidyUp] route=atomic-attachment-move pipes=N userMoved=N reports=0", not the "skipped" line. The robot must not expect "skipped" on this route (same as the first review, item 3.4).
5. **Nothing missed and nothing wrongly included.** Every automatic slide is classified, and every CE command route is outside the switch. The route names in the rule are plain strings. If someone adds a new AutoCAD-edit route later, it will tidy (the safe, ticked behaviour) until it is added to the list. The source-guard test `Bug816TidyAfterMoveSwitchTests.cs` line 112 pins the current caller strings, and I confirmed all four CE-command strings and all four reactor strings are present in the merged C-78 tree as well.
6. **Limit the author also states:** the tests prove the rule and the route names. None of them drives `TidyTextClashesAfterNativeMove` in a drawing. Only AutoCAD proves the result on screen.

### 2. Wording and where the row sits

1. **Row (both views):** "After a MOVE, STRETCH or other AutoCAD edit, CE slides its labels off other text, and says so on the command line" (`Dialogs/AdvancedSettingsDialog.xaml` line 471, `Dialogs/CivilSettingsView.xaml` line 118). It is plain English and true. "Slides" avoids the earlier mix-up with the Tidy labels command name. One small point: CE also slides labels off pits and pipes (PLACE-01), not only off text. That was already true before this PR and does not need changing.
2. **Tooltip (both views, lines 470 and 117) and catalog (`SettingsValueCatalog.cs` line 124):** these say "Off = after those edits nothing is moved and no line is printed. Drawing a pipe, Edit Pipe, Edit Pit and splitting a pipe with a source always tidy; the Tidy labels command is not affected. Default: on." All of that is true. The one gap is the command list (item 1.4.1).
3. **Main Settings window position:** Drafting tab, under the existing "KEEPING LABELS CLEAR" heading (line 436). It comes after the slide-step hint (lines 468 to 469) and before "FLOW ARROW" (line 473). The REGRESSION_LOG entry now says this correctly. The Civil settings view has its own group, renamed "AFTER AN EDIT COMMAND" (line 115).
4. **REGRESSION_LOG (`REGRESSION_LOG.md` lines 1 to 13):** rewritten in place. It records the narrowing and gives Opus pre-review J as the reason. The words are true, apart from the command-list gap.
5. **CE log line:** "[TidyUp] route=<route> skipped: Linking.TidyTextAfterMove is OFF" (line 122). It is for the robot, not for drafters, and it is accurate.
6. **Left stale (not shown to drafters):** the code comment on the setting itself (`Models/UserSettings.cs` lines 1165 to 1170) still says "after a MOVE" and "(needs Opus review)". The author's report says so. **The PR description is stale.** It still says "after a MOVE" and "full suite 3 failed". It should be updated before the PR is marked ready.

### 3. Default, ticked behaviour, and the Tidy labels test

1. **Default ON:** `Models/UserSettings.cs` line 1172 `= true`. A missing key or group reads ON through both start-up reads (`TextClashTidyUpRule.cs` line 111; tests at lines 38, 43 and 74).
2. **Ticked = today:** with the switch ON, `SkipsAfterMove` is false for every route, so `skipAfterEdit` is false. The entry gate never fires, and `TidyOnePipe` runs exactly as it does today. The only code difference is one extra true/false value passed along. The planner does not read the switch (test line 132). Verified by reading only.
3. **Tidy labels default test:** `Bug816TidyAfterMoveSwitchTests.cs` line 62 now asserts `TidyLabelsEnabled` equals `new LinkingSettings().TidyLabelsEnabled`. On this base that is OFF (`UserSettings.cs` line 1148 `= false` at `09126560`). On `rel-20261030a` (line 1249) and `rel-20261102a` (line 1267) it is `= true`, and no load-time migration of that key exists in `Services/`. So the test passes on the base and on both trains, and it no longer contradicts Tim's 29 Oct ruling. It does not itself pin ON. The trains' own `C76TidyLabelsDefaultOnTests` does that. This is acceptable.
4. **Could not reconcile one line of the author's report:** it says the line-62 test failed once "on this base" before the fix. The old assertion `Is.False` matches the base default, so I would have expected it to pass there. This does not affect the verdict, because the new assertion is the same whatever the base, but I have not verified the author's account.

### 4. Drafting tab height

1. **The measure is in a test:** `Modules/Drainage.Tests/Dialogs/SettingsWindowV3Tests.cs` line 206, `DraftingTab_WithTheTidyAfterEditRow_MeasuresUnderTheAgreedHeight`. It runs once, at a 1920x1032 room (100 per cent), and asserts the Drafting tab is at most 670 px. The author reports Drafting 606 px, Survey 670 px (the tallest), Fixes 669 px and Newer tools 668 px. **Not verified by me** (no build allowed).
2. **At 125 and 150 per cent (estimate):** the window has a fixed design width of 1100 (`AdvancedSettingsDialog.xaml` line 5). That is narrower than the usable width at every office scaling: 1264 at 150 per cent on 1920x1080. `WindowSizingService.TryFitTabbedEditor` (lines 144 to 180) therefore keeps 1100 at every scaling, so the row wraps the same way and the Drafting tab measures the same 606 px at 100, 125 and 150 per cent. At 150 per cent on 1920x1080 the usable height is 672 px. 670 + 32 = 702 is more than 672, so the whole tab bank is shrunk by about 4 per cent (factor about 0.957). That is the existing behaviour.
3. **150 per cent is covered by the existing test:** `EveryTab_FitsTheScreen_AtOneFixedHeight` (line 254, screens at line 244) checks at 1920x1080 at 100, 125 and 150 per cent (dark), at 2560x1440 at 150 per cent, and at 100 per cent (light). It asserts the tallest tab is at most 670 and that no tab is cut off. The author says these passed in the same run. Not verified by me.
4. **Headroom note (not this PR):** Survey at 670, Fixes at 669 and Newer tools at 668 leave almost no room. The C-78 train rewords lines 1194, 1207 and 1239 of the same window, and those are not on the Drafting tab. Only a run on the merged train proves those tabs still fit.

### 5. Trial merges (`git merge-tree --write-tree`, read-only)

1. **Tips:** `claude/rel-20261102a` `91963bd0` (C-78); #1868 `38c3f825` (base `claude/gb01-slice1-falls`); #1871 `9a1f4e64` and #1873 `2b0953fc` (base `claude/rel-20261030a`); #1874 `1b8b4af1` (base `claude/rel-20261026z`). The merge base with this PR is `09126560` in every case.
2. **Text clashes:** each of the five clashes ONLY in `REGRESSION_LOG.md`, at the top of the file. This PR's lines 1 to 13 clash with the other side's new top entries: to line 534 for C-78, 48 for #1868, 499 for #1871, 508 for #1873 and 41 for #1874. Keep both sides.
3. **Files both sides change, merged cleanly:** C-78, #1871 and #1873 also change `AdvancedSettingsDialog.xaml` (lines 1194, 1207 and 1239, not the Drafting tab), `CivilSettingsView.xaml`, `SettingsValueCatalog.cs`, `SettingsWindowV3Tests.cs` (a 2-line B-046 addition at line 426) and `SourcePlacementService.cs`. In the merged C-78 tree, the split call is at line 1278 and still carries `Array.Empty<string>(), "split");`, so the source-guard test at `Bug816TidyAfterMoveSwitchTests.cs` line 112 still finds it. `LinkService.TextClashTidyUp.cs`, `TextClashTidyUpRule.cs`, `LinkService.Reactors.cs`, `PipeCreationService.cs`, `PipeEditCommand.cs` and `LinkService.PitMoves.cs` are not changed by any of the five.
4. **Hidden clash from the first review (the Tidy labels default):** cleared (section 3.3).
5. **Other hidden clashes looked for:** I searched the C-78 tests for any check that counts catalog entries or lists every Linking key by reflection, and found none. The C-78 tests that read `LinkService.TextClashTidyUp.cs` (for example `BranchHostLabelTidyRuleTests`, `HandPlacedLabelMarkTests`, `Bug141SheetFrameTests`) already exist on this base and pass in the author's full run. Not proven on the merged tree. Only a build there proves it.
6. **Author's claim about #1871 and #1873 checked:** neither branch has `Bug816TidyAfterMoveSwitchTests.cs` or the `tidyTextAfterMove` key (their changes do not touch them), so they carry no wrong Tidy labels expectation. Confirmed.

### 6. What is NOT proven, and the AutoCAD scenario

1. **Not proven:** anything in AutoCAD. Also not proven:
   - that the switch is read back from the settings file AutoCAD actually reads after Apply
   - the Drafting tab height and the full-suite result (author's figures, not re-run by me)
   - the row's look in light and dark at 100 and 150 per cent
   - the merged-train build and full suite
   - BREAK, MIRROR and COPY behaviour with the box unticked
2. **Robot case A, unticked MOVE (twin sessions, on a copy):** before AutoCAD starts, set `"linking": { "tidyTextAfterMove": false }` in the copy's settings file. Open the run-33 drawing. Type `MOVE`, pick pit P3 with its label, base point `0,0`, second point `0,2000`. **Right:**
   - the command line has no "[CE Civil] pipe P3 -> P2 label: ..." line ("moved" or "no clear spot")
   - the CE log has "[TidyUp] route=established skipped: Linking.TidyTextAfterMove is OFF"
   - the pit label and pipe labels still travel with the pit and pipe end (BUG-1252 is separate)
   
   Compare positions with case B, not with before the MOVE.
3. **Robot case B, ticked MOVE (control):** the same copy with the key true or absent, and the same MOVE. **Right:** the "pipe P3 -> P2 label ..." lines print as in run 33, and the CE log has "[TidyUp] route=established pipes=N ... reports=N" with N above 0.
4. **Robot case C, unticked draw:** key false. Run `CD` and draw a new pipe starting at a pit, so that its start invert text lands on the pit or on a nearby label. **Right:**
   - the text still slides clear
   - a "[CE Civil] ..." line prints
   - the CE log has "[TidyUp] route=draw ..." and NO "skipped" line
   
   The same drawing with the key true gives the same result, and that equality is the proof.
5. **Optional robot case D, label moved by hand:** key false. `MOVE` one invert text by hand onto another label. **Right:**
   - nothing else moves
   - no "[CE Civil]" line prints
   - the CE log has "[TidyUp] route=atomic-attachment-move ... reports=0" (no "skipped" line on this route)
   - the label keeps its placed-by-hand mark, so a later Tidy labels leaves it alone
6. **Optional robot case E, Edit Pit:** key false. Open Edit Pit on a pit whose pipe invert text sits near the wall, change 450 to 900, and OK. **Right:** the text slides clear and the CE log shows "route=pit-boundary" with no "skipped" line.
7. **Codex look (the drafter sees the row):** Settings, Drafting tab, under KEEPING LABELS CLEAR, at 100 and 150 per cent on 1920x1080, in light and dark. **Right:**
   - the tick box is fully visible and its two lines are not cut off
   - there is no scrollbar
   - the changed mark shows when the box is toggled
   - the tooltip reads as quoted in 2.2
8. **Acceptance:** cases A to C each pass in two separate AutoCAD sessions on the installed build. Case A must also fail on a build without the row, or with the key true. Then BUG-816 can be written "FIXED (Claude-accepted, build, date)". The row itself needs the Codex look.

### 7. Verdict

1. **RE-CHECK OK WITH NOTE.**
2. **Fixed since the first review:** (a) the switch is limited to AutoCAD edit commands, and draw, Edit Pipe, Edit Pit, split and Tidy labels always tidy; (b) the Tidy labels default test no longer contradicts the trains; (c) the REGRESSION_LOG now gives the row's position correctly; (d) the author reports a full Release run of 20,805 passed and 0 failed, with net48 at 0 errors (not re-run by me).
3. **Note (does not block the train):**
   - add the copy-type AutoCAD commands to the tooltip and catalog, for example "... or another AutoCAD edit such as BREAK, MIRROR, COPY or paste", and to the REGRESSION_LOG list
   - update the stale PR description
   - optionally correct the `UserSettings.cs` comment
4. **Train:** after C-78. Rebase on `claude/rel-20261102a`, keep both REGRESSION_LOG entries, and re-run the Settings window page-height tests and the full Civil suite on the merged branch. BUG-816 stays OPEN until robot cases A to C pass. BUG-1232 (sheet border counted as a clash) is not addressed here.
