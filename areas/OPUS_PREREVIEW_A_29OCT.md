# Opus code-read pre-review, group A (Thu 29 Oct 2026, build number B-043a)

Read-only. PRs #1838 (B-005, BUG-1229), #1839 (B-006, BUG-1226), #1846 (B-046) and #1847 (B-008). I read each diff in full (`gh pr diff`), the B line in the build register, each build report, the Sonnet pre-review section, and the surrounding source on each PR branch. No build, no test, no AutoCAD, nothing posted on GitHub, no PR touched. No PR numbered 1851 or higher has a B-009 to B-014 title (1850 and 1851 are GB-01 slices 2 and 3), so there were four PRs to review.

Heads read: #1838 `1f8e7d4a`, #1839 `5092bbf9`, #1846 `23e63061`, #1847 `66fc0e84`. All four sit on the tip of `claude/rel-20261026z`.

---

## FOR TIM

1. **Answer:** two of the four need a small fix before they go in a train: **#1838** (pipe grade) and **#1847** (Tidy labels ON). **#1839** (Recent level buttons) and **#1846** (one-piece pipe for everyone) can go in as they are, with notes.

2. **#1838, the pipe grade fix (HIGH).** It fixes your exact example (19.45 on a 9.2 m pipe now gives 19.35 and the grade box keeps 100). But its tests start the New Pipe window in a state the real window is never in.
   - **The cause:** the real window always thinks "the drafter typed a downstream level". It gets that from the last level it remembers, even when the boxes look blank.
   - **What goes wrong, with "I know both ends":** a drafter has Set my own 1 in 100 on a 9.2 m pipe. They type 19.45 and get 19.35. They change the grade to 1 in 60 and type 19.40 for the upstream. The window shows 19.30 and the grade box still says 60.
   - **The result:** the pipe is drawn at 1 in 92, flatter than the 1 in 60 in the box. Today's build at least changes the box to 92, so you can see it. With this fix the box hides it.
   - **With "I know one end":** the drawing is right (19.24), but the window showed 19.30, so the window is 60 mm out.
   - **The fix** is two lines (below the line). Your own example still works after it.

3. **#1847, Tidy labels ON (MEDIUM, Sonnet was right).** CE writes every setting into the settings file each time it saves, OFF ones included. So anyone who has drawn a pipe on a build since 17 Oct already has "Tidy labels off" written in their file, and they will stay OFF after the update.
   - Your own file has no Tidy labels line, so on your PC it will look as if the change worked.
   - **The fix:** give the setting a new name inside the file. Every old "off" is then ignored and everyone starts ON. Nobody's file is edited.

4. **#1839, Recent level buttons (keep, two notes).**
   - **Wrong wording in the test steps:** the steps say a Recent button "fills the level box you are in". It doesn't. It always fills the upstream box (or the known-level box in "I know one end"), and the downstream level is then worked out again. That is how the old tab behaved too.
   - **Why it matters now:** the row sits under both boxes, so a drafter will expect the box they clicked in. The robot case and your test steps should check the upstream box.
   - **The buttons may look plain grey:** they may not get the house button style. A Codex look will show it.

5. **#1846, one-piece pipe for every login (keep, one question for later).** The code does what you ruled. What I could not answer: if anyone in the office still runs AutoCAD 2024, then a job opened and saved on a 2027 PC has its pipes turned into one-piece pipes. The 2024 PC then cannot edit those pipes with CE. If everyone is on 2027 there is nothing to do.

6. **Mistakes of my own:** none that cost anything. My first reading of #1838 said only "both levels typed" was affected (Sonnet's wording). Reading how the window opens showed it is the normal state of the window, so I raised it to HIGH.

7. **Not proven:** I built and ran nothing, and nothing was seen in AutoCAD. The #1838 finding is from reading the code that opens the window and the code Start Pipe runs. The robot case below would prove it either way.

---

## #1838 (B-005, BUG-1229): New Pipe downstream level never flatter than the chosen grade, switch `pipe.suggestedLevelNeverFlatterThanGrade`

**Checks**

1. **Switch OFF returns the old behaviour exactly:** yes. With `gradeIsMinimum` false, `ResolveHasEstablishedFall` skips the new test, `keepsChosenGrade` stays false, the format is `"0.00"`, and `SuggestDownstream` takes `SuggestFromStandardGrade`. Line for line the same as base.
2. **Default ON through both start-up reads:** yes, in its own fixture (`{}` and a pipe group without the key, `DeserializeSettings` and `DeserializeSettingsTolerant`, typed false and true). It is not added to `C75NewSwitchDefaultsTests` (LOW, the job text asked for that; the own-fixture pin is equivalent).
3. **Tests drive the claimed behaviour:** the arithmetic tests do. The window tests do NOT drive the real window state (finding 1).
4. **REDO safety:** no finding. View-model arithmetic only; no transaction, system variable, command, regen, lock, event or Idle handler added.
5. **Locked layer, Xref, REFEDIT:** not touched.
6. **R-00:** the step comes from Settings "Calculated decimals". No new engineering value. **R-27:** nothing blocks.
7. **REGRESSION_LOG:** present. Item 3 says "levels typed on both ends are held exactly as before". That is not true for the grade box (finding 1).

**Findings**

1. **HIGH, `Modules/Drainage/ViewModels/CdViewModel.Inverts.cs:785-793` with `:823`, and the test helper `Bug1229SuggestedLevelNeverFlatterTests.cs` `BlankTheLevelBoxes` (diff line 179).**
   - **Why the flag is always set in the real window:** the New Pipe view model is built with `LoadSettings()` (`CdViewModel.cs:73`). That sets `SecondInvert = settings.Inverts.SecondValue` (`CdViewModel.Settings.cs:192`; default `"1.20"`, otherwise the last pipe's downstream text, saved on every OK at `:338`). The `SecondInvert` setter (`CdViewModel.Inverts.cs:730`) then sets `_secondInvertUserSet = true`, and nothing in the product ever resets it. Draw-first then blanks the boxes (`CdViewModel.DrawFirst.cs:130-131`), but the flag stays true.
   - **The test hides this:** the PR's test comment says so itself ("putting 1.20 in the second box counts as the drafter typed a downstream"). It then clears the private flag by reflection, so every window test runs in a state the real window never has.
   - **In the real window:** `ResolveHasEstablishedFall` returns true at `:863` before the new BUG-1229 check at `:869` is reached. Every keystroke after the first takes the held-fall branch. `keepsChosenGrade` is true whenever "Set my own" holds a number, so the grade box is no longer rewritten from the held fall.
   - **Worked example A ("I know both ends", 9.2 m pipe):** Set my own 100. Type upstream 19.45: the window gives 19.35. Change the grade box to 60, then type upstream 19.40. The held 0.10 m fall gives downstream 19.30, and the grade box still reads 60. Start Pipe draws 19.40 to 19.30, which is **1 in 92, flatter than the 1 in 60 in the box**. The label honestly says 1 IN 92, but the window said 60. With the switch OFF the box changes to 92, so the drafter can see it.
   - **Worked example B, same steps with "I know one end":** Start Pipe works the end out from the grade box (`CdCommand.cs:504-555`): 9.2 / 60 = 0.153, rounded up to 0.16, gives 19.24. The window showed 19.30, so it is 60 mm out.
   - **Worked example C (draw-first off, boxes open with the last pipe's 19.45 and 19.35):** a 20 m pipe at Set my own 100, upstream 18.20 typed. The held 0.10 m fall gives 18.10, and the grade box still reads 100. "I know both ends" draws **1 in 200** under a box that says 100. (OFF: the box says 200.)
   - **Tim's own example still comes out right** (19.35, box 100) only because the first keystroke "1" makes a rounded-down 0.10 m fall, which is then held. That is luck of the arithmetic, not the designed path.
   - **Fix (two lines):** (a) in `ResolveHasEstablishedFall`, move the `gradeIsMinimum && DownstreamBoxStillHoldsSuggestedLevel()` test ABOVE the `_secondInvertUserSet` test. A box still holding CE's own text was not typed by the drafter. (b) set `keepsChosenGrade` only when `!hasEstablishedFall`, so a genuinely held fall writes its grade back as before.
   - **Test fix:** add a window test that builds the view model the way CD does, with `SecondValue` "1.20" and the boxes then blanked, and no reflection. Run examples A and C through it.
2. **LOW, disclosed in the log, item 5:** the window's suggestion and Start Pipe still differ in two cases.
   - **Short pipes:** a 0.5 m pipe from 19.45 at 1 in 100 shows 19.44 in the window. Start Pipe applies the 20 mm minimum drop from Settings and draws 19.43.
   - **"Calculated decimals" set to 3:** the window shows 19.358. Start Pipe rounds the drop at a fixed 0.01 m and draws 19.350.
   - **Fix:** make the suggestion call `RulebookCalculations.WorkOutInvertsFromGrade`, the one path the preview (`TryPreviewCalculatedInvert`) and Start Pipe already use (design rule 1). Not needed for C-77.
3. **LOW:** the grade read is inconsistent. `TryGetChosenCustomGradeRun` uses `MathHelper.TryParseGrade`, which accepts "1:80" and "1 in 80". `ResolveHasEstablishedFall` uses `TryParseInvariantDouble`, which does not. No wrong answer found; worth one parser.

**Robot case:** N32_cd_grade_never_flatter (the build's own case) proves Tim's example, but it would pass even with finding 1. Add **N32b_cd_grade_changed_then_upstream**:
- **Steps:** a new drawing copy, CD between two pits about 9.2 m apart, 100 mm UPVC, "I know both ends", Set my own, type `100`. Type `19.45` in the upstream box one key at a time. Then type `60` in the grade box and type `19.40` in the upstream box.
- **Right (fixed):** the downstream box reads `19.24` and the grade box `60`. After Start Pipe the drawn downstream level reads 19.24.
- **Wrong (this PR as it is):** the downstream box reads 19.30 under a grade box of 60.
- **Control N32b_off,** switch typed false: 19.30 and a grade box of `92`.

**Verdict: FIX-FIRST** (two lines plus one test; Tim's example keeps working).

---

## #1839 (B-006, BUG-1226): "Recent:" invert buttons on the one-page New Pipe and Edit Pipe window, switch `pipe.recentInvertButtonsOnMainPage`

**Checks**

1. **OFF returns the old window exactly:** yes. `MoveRecentLevels` runs only when `RecentButtonsOn` (`PipeOnePageLayout.cs:81`). OFF leaves the row on the tab that is thrown away, as today.
2. **Default ON through both reads:** yes. There are four file shapes in its own fixture plus three in `C75NewSwitchDefaultsTests`, and typed false works through both reads.
3. **Tests drive the behaviour:** yes for presence, order, automation name, right-edge fit and the window height. Not for the button style or for which box a press fills.
4. **REDO safety:** layout only; no finding.
5. **Locked layer, Xref, REFEDIT:** not touched.
6. **R-00 and R-27:** pixel sizes are layout, not engineering; nothing blocks.
7. **REGRESSION_LOG:** honest about the too-tall first attempt. One wrong instruction (finding 1).

**Findings**

1. **MEDIUM, `REGRESSION_LOG.md` item 6 and the switch comment (`UserSettings.cs`, "pressing one fills the level box you are in"):** `ExecuteUseRecentInvert` (`CdViewModel.Commands.cs:171-189`) fills `KnownInvert` in "I know one end". Otherwise it fills `FirstInvert` whenever the first box is enabled. It never fills "the box you are in". In New Pipe, filling the upstream box also re-runs the downstream suggestion.
   - **Drafter consequence:** the row now sits directly under both boxes. A drafter who clicks into the downstream box and presses 18.190 gets 18.190 in the UPSTREAM box and a new worked-out downstream level. That is easy to miss.
   - **The behaviour is old** (the tab did the same), but the test steps, the robot case N30 and Tim's checklist will check the wrong box.
   - **Fix:** correct the wording to "fills the upstream box (the known box in I know one end)" and make N30 read the upstream box.
2. **LOW, `PipeOnePageLayout.cs:367` (confirms Sonnet's LOW):** `list.TryFindResource("CeShellEvidenceButtonStyle")` runs after the row has been removed from its parent (`:204`).
   - **Why the lookup fails:** that style lives in `Themes/CivilEditorShellTheme.xaml`, merged into the WINDOW's own resources (`ThemeService.MergeEditorShellResources`, called from `PipeEditWorkshopDialog.xaml.cs:44`), not into the application resources. A detached row cannot reach it, so `baseStyle` is very likely null.
   - **Result:** the slim buttons draw as plain Windows buttons. The tests do not check the style.
   - **Fix:** look the style up before `oldParent.Children.Remove(row)` (or use `tabs.TryFindResource`).
3. **LOW, disclosed:** at 150% display scaling there is about 0.2 px to spare. Any later row on this page will overflow (B-043 slices must re-run the 17 fit tests).

**Verdict: KEEP-WITH-NOTE** (fix the log wording and N30's check; the style fix can ride along).

---

## #1846 (B-046): one-piece pipe object on for every Windows login, switch `options.pipeObjectAutomaticIsOnForEveryone`

**Checks**

1. **OFF returns the 26 Sep rule exactly:** yes. The two-argument `Resolve` is now `Resolve(mode, sid, false)`, and `automaticIsOnForEveryone || IsTestBedAccount(sid)` with false is the old expression. A test compares the two for seven words and five sign-ins.
2. **Default ON through both reads:** yes. Four file shapes and typed false through both reads; an unreadable Options group reads ON.
3. **Tests drive the behaviour:** yes, through the pure rule and through `IsUpgradeAllowed` with a test sign-in (a 40-row grid), plus the Settings-page sentence and the log line.
4. **REDO safety:** the gate only decides. The PR adds no write, transaction, system variable, event or Idle handler.
   - **What it does widen:** existing paths that write on every login. The open-a-job pass (`PipeObjectUpgradeOnOpenService`: `DocumentCreated` and `Idle`, already subscribed) converts pipes under `LockDocument`, and `ProxyGraphicsGuard.EnsureOn` runs. That is the feature Tim ruled for, not new code.
5. **Locked layer, Xref, REFEDIT:** the upgrade refuses pipes on locked layers (`LinkService.PipeObjectUpgrade.cs:125-129`, `:243-270`), unchanged.
6. **R-00 and R-27:** the switch carries Tim's ruling, nothing blocks, and a drafter can still choose Off on the Settings page.
7. **REGRESSION_LOG:** honest.

**Findings**

1. **MEDIUM, a question rather than a code fault (agrees with Sonnet's MEDIUM, `PipeObjectUpgradeGate.cs:81`):** from this build every colleague's AutoCAD 2027 converts the pipes of every job it opens. It also takes one dated backup the first time.
   - **The open question:** if any colleague still opens jobs in AutoCAD 2024 (the net48 lane), those pipes then arrive as proxy objects. They are visible, because the proxy graphics guard is kept, but CE on 2024 cannot edit them. The Settings hint already says "edit in AutoCAD 2027".
   - **Not checked:** what CE's 2024 build reads from a proxy pipe (schedules, CDRULES). The report says only "2022 to 2024 PCs keep ordinary pipes", which is about what they draw, not what they open.
   - **Fix:** none in code. Before C-77 installs, record which AutoCAD each pilot login runs. If any runs 2024, CE 02 should run one robot case that opens a 2027-converted job on the 2024 lane.
2. **LOW:** opening a job now marks it changed on every colleague's PC, the first time it is opened. AutoCAD then asks to save on close even if they only looked. That is expected from the C7 ruling; worth one line in the colleague notes.

**Verdict: KEEP-WITH-NOTE.**

---

## #1847 (B-008): Tidy labels switch ON by default, `linking.tidyLabelsEnabled`

**Checks**

1. **OFF returns the old behaviour:** yes. A file that says false keeps false, and `TidyLabelsGateRule.IsEnabled()` answers off exactly as before.
2. **Default ON through both reads:** yes, for an empty file, a linking group without the key and a file without a linking group.
3. **Tests drive the behaviour:** the default and the gate, yes. The "Default: on." texts are a source check, which is fine for wording.
4. **REDO safety:** a default and text only; no finding.
5. **Locked layer, Xref, REFEDIT:** CDTIDYLABELS untouched.
6. **R-00 and R-27:** the switch is on the Settings page; nothing blocks.
7. **REGRESSION_LOG:** item 1 says "a colleague typing CDTIDYLABELS ... now the command just runs". That is not true for most existing colleague files (finding 1). There is also no blank line before the next heading (cosmetic).

**Findings**

1. **MEDIUM, `Modules/Drainage/Models/UserSettings.cs` (the default, diff line 155), confirming Sonnet's MEDIUM by code:**
   - **The cause:** `SettingsService.cs:720` saves with `JsonConvert.SerializeObject(settings, Formatting.Indented)` and no default-skipping. The key has existed since commit `f577f42d` (17 Oct). CD saves settings on every OK (`CdViewModel.Commands.cs`, `SaveSettings()`), so any login that has drawn one pipe on a build since 17 Oct has `"tidyLabelsEnabled": false` in its file.
   - **Drafter consequence:** after C-77 those colleagues still get "Tidy labels is switched off". Tim's file has no line, so Tim sees ON. Tim's ruling was ON for colleagues.
   - **Fix (one line, nobody's file edited):** rename the stored key, for example `[JsonProperty("tidyLabelsOn")]`. Every old false is then ignored and reads ON, and the tolerant read already skips unknown keys. Keep the test that a file saying the NEW key false keeps false.
   - **What is lost:** a drafter who switched it off on purpose has to switch it off again. Nobody could have chosen OFF on purpose while OFF was the default, unless they unticked it after ticking it.
2. **LOW, `Rules/TidyLabelsGateRule.cs:16`:** with no settings loaded at all, the gate answers OFF (`?? false`) while the default is now ON. This is only reachable in a broken start-up. Make it `?? true` to match the other ON switches (R-27).
3. **LOW, stale comments:** `Commands/TidyLabelsCommand.cs:22` and `Services/CeCvlRibbonContributor.cs:112` still say "OFF until Codex passes it". Comments only.

**Robot case:** N32_tidy_default_on, with control N32c_tidy_default_off (the build's own pair).
- **Add N32d_tidy_old_false_file:** start AutoCAD with a settings file that has `"tidyLabelsEnabled": false` and no other Tidy key, then type `CDTIDYLABELS`.
- **Right after the fix:** it asks for pipes.
- **This PR as it is:** it prints that Tidy labels is switched off.

**Verdict: FIX-FIRST** (one line; otherwise the ruling does not reach the colleagues it was for).

---

## For the C-77 and C-78 finalizers, in order

1. **#1838:** apply the two-line fix and the no-reflection window test before it goes in a train. The other findings are later work.
2. **#1847:** rename the key (or Tim accepts that existing colleagues stay OFF), and fix the REGRESSION_LOG wording.
3. **#1839:** correct the "box you are in" wording in the log and the switch comment, and the N30 check. Move the style lookup above the row removal.
4. **#1846:** no code change. Record which AutoCAD each pilot login runs before the install.
5. **Merge clashes (Sonnet's dry run, not re-run by me):** #1838 and #1839 insert at the same line of `UserSettings.cs` (after `EditPipeReverseArrowReadsDrawnEnds`). Every PR inserts at the top of `REGRESSION_LOG.md`. Keep both sides.

Not done: no build, no test run, nothing seen in AutoCAD, no colleague settings file read, the robot case files not read.
