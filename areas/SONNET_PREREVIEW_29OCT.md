# Sonnet code-read pre-review of the open draft PRs (Thu 29 Oct 2026)

Read-only. I read each diff in full from GitHub (`gh pr diff`), plus the build report named on its B line, plus the surrounding source on the PR branch where I needed context. I ran no build, no test, no AutoCAD, and I posted nothing on GitHub. No new PR numbers above 1849 were open when I got there.

---

## FOR TIM

1. **Answer:** 6 of the 11 PRs have a MEDIUM finding and none has a HIGH. The 6 are #1838, #1841, #1846, #1847, #1848 and #1849. The other 5 (#1839, #1842, #1843, #1844, #1845) have LOW findings only.
2. **Nothing I found can crash AutoCAD or block a drafter.** None of the 11 adds a new transaction, a regen, a system variable, a command send, an idle handler, an event subscription or a layer unlock (I searched every added line). The six ON/OFF switch PRs (#1838, #1839, #1845, #1846, #1847, #1848) all give the old behaviour back when switched OFF, and all ship ON through both start-up reads.
3. **#1838 (grade 1 in 100):** if the drafter types BOTH levels themselves and the grade box already holds a number, the box is no longer updated to match. The levels could say 1 in 61 while the box still says 1 in 100. The build report says this is "held as before", and in the code it is not.
4. **#1841 (falls 1 in 100):** two things. A junk build file (`CE_CVL_SUITE_0gaop2hs_wpftmp.csproj`, 735 lines, with a path from another work folder) was committed by accident. And if someone has edited their own pipe-fall list, any 450 mm and larger entries they typed are now silently ignored, and there is no box on the Settings page to type the new 450 mm and larger figure into.
5. **#1846 (one-piece pipe on for everyone):** the build report only says "2022 to 2024 PCs keep ordinary pipes". It does not say what happens when a 2027 colleague saves a job and a 2022 to 2024 colleague then opens that drawing. That was the reason the hold was put there. I have not checked how those older AutoCAD versions treat the one-piece pipe. Worth a deliberate look before 9 Nov.
6. **#1847 (Tidy labels on):** CE saves every setting when it saves the file, including switches left at their default. So a colleague whose settings file was saved since mid-October probably already has `"tidyLabelsEnabled": false` written in it, and will stay OFF after the update. Your own file has no line, so you will see ON and think it worked everywhere. I have not read a colleague's file.
7. **#1848 (cover to outside of pipe):** saved CDRULES results do NOT turn "Stale" after this change, even though R-04 now gives different answers. After the update, an old saved run can still show a cover as OK that a fresh run would flag.
8. **#1849 (pipes under garages):** nothing is set out of the box, so every job's CDRULES will show two new "Unknown" rows, and the layer names can only be typed into the settings file (no Settings page box). The net48 build was not run.
9. **Clashes when these merge (real, from a dry-run merge on the branches):** #1838 and #1839 clash in UserSettings.cs. #1841 clashes with the garage stack (#1842, #1843, #1849) in RulebookEngine.cs, RulebookValues.cs and SettingsService.cs. #1848 clashes with #1842 and #1849 in RulebookValues.cs. REGRESSION_LOG.md clashes between every pair (all insert at the top). Merge order matters; none of these is hard to fix by hand.
10. **Rule R-00 (Settings owns every value):** #1841, #1842, #1843, #1848 and #1849 each add engineering values that exist only in the settings file, with no Settings page row. Every one of them says so in its own log. I list it per PR but I count it as MEDIUM only where the feature cannot work without typing into the file (#1841 and #1849).
11. **What I did NOT check:** I did not build or run anything. Nothing was seen in AutoCAD. I did not read any colleague's settings file. I did not read the robot case files.

---

## Pattern notes (apply to several PRs)

1. **REGRESSION_LOG.md:** every one of the 11 PRs inserts its entry at the very top, so every pair conflicts there. Mechanical.
2. **Switch-less PRs:** #1841, #1842, #1843 and #1849 have no ON/OFF switch. For #1841 and #1843 this is Tim's ruling (old ladder retired; driveway B). For #1842 no answer changes. For #1849 the feature is dormant until layers are named. Checks 1 and 2 are therefore "not applicable" for those four, and I say so in each section.
3. **Settings page rows:** see item 10 above.

---

## #1838 BUG-1229 grade never flatter (B-005)

1. **OFF returns old behaviour:** yes. With the switch OFF, `hasEstablishedFall` ignores the new test, the chosen-grade override is skipped, the level is written with `0.00`, and the old nearest-step rule runs. A window test pins 19.36 and 1 in 102 for OFF.
2. **Default ON through both reads:** yes, pinned for `{}` and a pipe group without the key, both reads, and typed false/true.
3. **Tests drive the behaviour:** yes. They use the real `CdViewModel`, typed one key at a time and pasted, plus a 54-case arithmetic grid. Strong.
4. **REDO safety:** no finding. Arithmetic on text boxes only; a source guard bans the AutoCAD words in the rule file.
5. **Locked layer / Xref / REFEDIT:** no finding (no drawing access).
6. **Settings / R-00 / R-27:** no finding. The step comes from Settings "Calculated decimals". The switch is in the settings file only (no Settings page row), as the report says.
7. **REGRESSION_LOG.md:** present and honest, except for one claim covered by the finding below.
8. **Shared files:** `UserSettings.cs` (real merge clash with #1839, same insertion point after `EditPipeReverseArrowReadsDrawnEnds`); `REGRESSION_LOG.md`. `CdViewModel.Inverts.cs` is touched by no other PR in this list (B-041/BUG-1233 will touch it later).

**Findings**

1. **MEDIUM, `Modules/Drainage/ViewModels/CdViewModel.Inverts.cs` lines 787-792 and 823:** `keepsChosenGrade` is set whenever "Set my own" holds a valid grade, even when the drafter has typed BOTH levels (the held-fall branch). With the switch ON the grade box is then not rewritten from the levels, as it used to be. Drafter consequence: type upstream 19.45 and downstream 19.30 on a 9.2 m pipe with "Set my own 100" selected, and the levels say about 1 in 61 while the box still says 100. I did not check which of the two Start Pipe uses. The log (item 3) and report say "levels typed on both ends held as before, including the grade it writes back"; the test `LevelsTheDrafterTypedOnBothEnds_StayHeld_AsBefore` only checks the downstream box, never the grade box.

---

## #1839 BUG-1226 Recent invert buttons (B-006)

1. **OFF returns old behaviour:** yes. `MoveRecentLevels` is only called when the switch is ON; OFF leaves the row on the removed tab, so no row, exactly as today. A window test checks no buttons and no "Recent:" caption.
2. **Default ON through both reads:** yes. Four file shapes plus three more in `C75NewSwitchDefaultsTests`, both reads, typed false through both.
3. **Tests drive the behaviour:** yes. They open the real window under STA, walk the visual tree, check order, button text, right-edge fit, and that the window still fits its fixed height.
4. **REDO safety:** no finding. Layout only.
5. **Locked layer / Xref / REFEDIT:** no finding.
6. **Settings / R-00 / R-27:** no finding. Pixel sizes are layout, not engineering.
7. **REGRESSION_LOG.md:** present and honest (it states the first version was too tall and what was done).
8. **Shared files:** `UserSettings.cs` (real merge clash with #1838); `REGRESSION_LOG.md`. B-040/B-043a will build on this same file later.

**Findings**

1. **LOW, `Modules/Drainage/Dialogs/PipeOnePageLayout.cs` line 367:** `list.TryFindResource("CeShellEvidenceButtonStyle")` is called after the row has been removed from its old parent, so a lookup that depends on the window's own resources can come back empty. If the style is in the window's resources (I did not confirm; it is also merged by `ThemeService`), the slim buttons would lose the house button look and draw as plain grey Windows buttons. The unit tests would not notice. Drafter consequence: the Recent row could look different from every other button in the window. The build report already asks for a Codex look.
2. **LOW (already disclosed by the report):** at 150% display scale the fit is 620 of 620.2 px, so any later row added to this window will push the page over the fixed height.

---

## #1841 GB-01 slice 1, falls (B-042) (no switch, by Tim's ruling)

1. **OFF returns old behaviour:** not applicable. Tim ruled the old ladder and the every-council detention rule retired (decision 26 point 4). The one-time move of a saved old ladder cannot be switched off; the log says so.
2. **Default ON through both reads:** not applicable (no switch).
3. **Tests drive the behaviour:** yes for the rules (25 new cases against the real `RulebookEngine`, settings and the four council profiles). Existing tests were re-pinned on purpose and the log lists them (12 test files, one snapshot re-accepted). No test covers the finding below about edited ladders.
4. **REDO safety:** no finding. No drawing access in any changed file.
5. **Locked layer / Xref / REFEDIT:** no finding.
6. **Settings / R-00 / R-27:** see findings 2 and 3. Warnings never block.
7. **REGRESSION_LOG.md:** present and honest. It states the Edit Pipe strip does not know about detention pipes and the Settings window has no row for the three new values.
8. **Shared files:** `UserSettings.cs`; `RulebookValues.cs` (clashes with #1842/#1849 insertion at the same point, and #1849 in RulebookEngine.cs); `RulebookEngine.cs` (clashes with #1849: both add a new method right after `DetentionGuideGradeRules`); `SettingsService.cs` (clashes with #1843: both add a block at the same point after the steepest-grade move; also touched by #1844 but that auto-merged); `PipeSizeNetworkReviewService.cs` (also #1849, auto-merged).

**Findings**

1. **MEDIUM, file `Modules/Drainage/CE_CVL_SUITE_0gaop2hs_wpftmp.csproj` (whole file, 735 lines):** a temporary WPF build file got committed. It carries a path from another work folder (`...worktrees\ce-acad-tim-desk-d44f6a\...`). No other branch in this list has one, and `.gitignore` has no rule for it. Drafter consequence: none directly. Risk: a second project file next to the real one breaks any `dotnet build` run from that folder ("more than one project file"), and it puts a local path into the repo. Solution builds name the project, so I expect them to be unaffected, but I did not build. Remove the file before this merges.
2. **MEDIUM, `Modules/Drainage/Models/UserSettings.cs` line 2348 (`EffectiveMinGradeLadder`):** every ladder entry for 450 mm and up is skipped, so only the blank new row can speak for those sizes. Anyone who edited their own ladder (so it is "left as typed") and typed their own 450 to 750 figures keeps those figures in the file but they stop counting, and CDRULES says "no minimum fall set for this size" without warning. Drafter consequence: a pipe the office used to be warned about at its own 1 in 150 is now silently not checked. The log says an edited ladder "is never changed"; the entries are not changed but they are ignored. Not covered by a test.
3. **MEDIUM (R-00), `Modules/Drainage/Models/UserSettings.cs` line 2312 (`largeGravityMinGradeN`):** this is the row the whole 450 mm and larger rule hangs on, and it can only be typed into the settings file. There is no Settings page box. Until there is, the "own figure for bigger pipes" Tim ruled cannot be entered by a drafter. The log discloses this.
4. **LOW, `Modules/Drainage/Rules/RulebookEngine.cs` line 374:** on a detention pipe 450 mm and up in a council with no flatter figure, the comment and log say the ordinary 1 in 100 applies at every size. That is only true while the large-pipe row is blank; once a figure is typed there, a detention pipe at 450+ reads the large-pipe figure instead (`minimum.IsSet`). Edge case.
5. **LOW (disclosed):** the Edit Pipe strip does not know a pipe is a detention pipe, so in Darebin, Banyule, Manningham and Maroondah a detention pipe laid at 1 in 200 passes CDRULES but still warns "flatter than 1:100" on the strip.
6. **LOW (consequence, not a fault):** Civil Design and auto-design now take 1 in 100 as the least fall at DN225 to DN375, so auto-designed pipes at those sizes come out steeper and deeper (the design snapshot was re-accepted for this). It is Tim's ruling, and the log says so; I list it because it changes every auto-design job.

---

## #1842 GB-01 slice 5, pit size table (B-044) (no switch; answers do not move)

1. **OFF returns old behaviour:** not applicable. A blank table is the shipped Guidebook table. I compared old and new `PitSelector` side by side: governing size (now by plan area), the "Pipe-fit governs / Depth governs / agree" notes, step irons, and the not-positive-depth guard all give the old result for the shipped table.
2. **Default ON through both reads:** not applicable. The key is `NullValueHandling.Ignore` and defaults to null; the test pins "not written when blank".
3. **Tests drive the behaviour:** yes. Ten depth edges, pipe-fit governing, a Settings table changing the answer on the next call, four kinds of unusable table, fingerprint.
4. **REDO safety:** no finding.
5. **Locked layer / Xref / REFEDIT:** no finding.
6. **Settings / R-00 / R-27:** see findings. An unusable table falls back to the shipped one with a plain note, never a block.
7. **REGRESSION_LOG.md:** present and honest.
8. **Shared files:** `UserSettings.cs`; `RulebookValues.cs` (adds its fingerprint tail at the end of `Resolve`, the same spot #1848 and #1849 use: real clash with #1848); `PitSelector.cs` (also #1843, which is stacked on this one, so fine).

**Findings**

1. **LOW (R-00, disclosed):** no Settings page row for `pit.pitSizeByDepth`. A drafter cannot change the table from the Settings page yet.
2. **LOW, `Modules/Drainage/Services/PitSelector.cs` line 169:** the step-iron start is still "plan area at least 600 x 900", fixed in code. If someone saves a table with different sizes, step irons follow area, not the depth rule R-29 uses. The pipe-fit table is also still in code (the log says so).

---

## #1843 GB-01 slice 4, lid class (B-045) (stacked on #1842; no switch)

1. **OFF returns old behaviour:** not applicable, by Tim's ruling (driveway B, larger vehicles C). The log names the one existing test changed on purpose.
2. **Default ON through both reads:** not applicable. Both new keys are null by default and not written.
3. **Tests drive the behaviour:** yes. The shipped chart, quick-pick names, Settings changing both the Pit window suggestion and the pit advice, the one-time table move, an edited table left alone.
4. **REDO safety:** no finding.
5. **Locked layer / Xref / REFEDIT:** no finding.
6. **Settings / R-00 / R-27:** see findings. Warn-only; an unusable chart falls back with a note.
7. **REGRESSION_LOG.md:** present and honest, including that two vocabularies (words chart and surface table) still exist.
8. **Shared files:** `UserSettings.cs`; `PitSelector.cs` (with #1842, stacked); `SettingsService.cs` (real clash with #1841, same insertion point).

**Findings**

1. **LOW, `Modules/Drainage/Services/LidClassChart.cs` line 79:** the old rule took the first match in a fixed order (landscaped, then pedestrian/residential, else C). The new rule takes the heaviest matching class. Two different answers for a use that contains words from two rows: for example "landscaped pedestrian path" was Class A and is now Class B; "trafficable residential" was Class B and is now Class C. The log describes "heaviest wins" but does not say old answers can change for mixed-word uses.
2. **LOW (R-00, disclosed):** no Settings page row for `pit.lidClassByUse` or `pit.lidClassWhenUseUnknown`. The Pit window's Surface table (`lidClassBySurface`) is already editable elsewhere; the words chart is not.
3. **LOW (consequence):** any saved settings file holding exactly the old four-row table is moved to the new one at load (Driveway C becomes B). It is logged and does not touch an edited table. No way to switch it off; Tim ruled it.

---

## #1844 F-023 colleague defaults (B-035) (DRAFT, waiting on Tim)

1. **OFF returns old behaviour:** yes. The switch sits in the shipped file's own `settings` group (a fresh PC has no file of its own). OFF returns a plain `new UserSettings()` with the same fresh-profile flag. A whole-object comparison test pins it.
2. **Default ON through both reads:** yes, but see finding 1: that property is not what actually gates the feature.
3. **Tests drive the behaviour:** yes. They point at the real shipped file, check every key in it reads back, check every other key equals the built-in value, check existing, empty and damaged settings files are never touched, and check no path-like value survives.
4. **REDO safety:** no finding.
5. **Locked layer / Xref / REFEDIT:** no finding.
6. **Settings / R-00 / R-27:** values live in a shipped data file, not code. Failures fall back with one log line and never block. The list of values is the desk's export and Tim has not approved it (the log says so).
7. **REGRESSION_LOG.md:** present and honest.
8. **Shared files:** `UserSettings.cs` (auto-merges with the others), `SettingsService.cs` (auto-merges with #1841/#1843/#1849). It and #1846 both aim at the one-piece pipe being On for colleagues; they do not conflict, but they overlap in purpose.

**Findings**

1. **LOW, `Modules/Drainage/Models/UserSettings.cs` line 202 (`Settings` group):** the loader reads the switch straight from the shipped JSON text and never looks at the `UserSettings.Settings` object. The new group will be written into every user's own settings file, where setting it to false does nothing. A drafter who finds `firstStartUsesColleagueDefaults` in their file and turns it off would be misled.
2. **LOW, `Modules/Drainage/Services/ColleagueDefaultsService.cs` line 38:** the fresh-profile path is skipped whenever the environment variable `CE_LOG_DIR_OVERRIDE` is set. The log says AutoCAD never has it set. Any robot or Codex run that sets it for log redirection would silently get the built-in values and could not prove this PR. Keep it unset for the F-023 proof on a clean login.
3. **LOW (consequence):** the shipped file carries Tim's personal choices (dark theme, snap mode 1151, "Class A Grate", three remembered tank captions) for every colleague. That matches the standing rule "colleagues get your exact setup", and the report says Tim has not yet approved the list.

---

## #1845 Raingarden label RG1, RG2 (B-007)

1. **OFF returns old behaviour:** yes. `AppendRaingardenLabel` returns before touching anything when the switch is OFF. The refactor of `EnsureTagLabel` into `AppendLabelText` keeps the same order (append, add to transaction, store the id) and left-aligned text for DP, OF and WT.
2. **Default ON through both reads:** yes (empty and older file, both reads; false only when typed).
3. **Tests drive the behaviour:** partly. The numbering (RG1, RG2, never reused), the switch and the two sentences are real tests. Whether the text is actually drawn, where, and removed by one Undo is proved only by source-text guards. Nothing runs a drawing. The robot case C31 is the real proof.
4. **REDO safety:** no new StartTransaction (it uses the placement's own transaction). See finding 1 about the baseline file.
5. **Locked layer / Xref / REFEDIT:** no finding. It reads the layer record first and leaves the label out if `IsLocked` or `IsDependent`. Nothing unlocks a layer.
6. **Settings / R-00 / R-27:** the layer is the fixed GUIDELINES layer DP and OF use (one code path). The raingarden is never blocked. No Settings page row (disclosed).
7. **REGRESSION_LOG.md:** present and honest, including that the full suite was not re-run after the baseline edit.
8. **Shared files:** `UserSettings.cs` only (auto-merges). `SourcePlacementService.cs` and `SourceTagService.cs` are touched by no other PR in this list.

**Findings**

1. **LOW, `Modules/Drainage.Tests/Services/RedoSafeReviewedHooks.baseline.txt` line 341 (and two more copies):** the PR adds 24 lines to a REDO-safety baseline by hand. The report's reasoning is that the between-commands hooks already reach the same writes through `EnsureTagLabel`, so only the method name moved. That fits what I read, but the baseline now also lists `DBText.set_Justify` and `DBText.set_AlignmentPoint` under those hooks, which were not listed before. They only run for the centred raingarden label, never from a hook. An Opus finalizer should confirm that independently, because this is a safety list.
2. **LOW, `Modules/Drainage/Services/SourcePlacementService.cs` line 955:** the label sits at `plan.Centroid`. For an L-shaped or curved raingarden outline the centroid can land outside the outline. Drafter consequence: "RG1" floating beside the garden on an odd shape.
3. **LOW, same file, the `catch` in `AppendRaingardenLabel`:** if the text is appended and a later step throws, the command line says the label "could not be drawn" while a text entity may already be in the drawing.

---

## #1846 Pipe object on for every login (B-046)

1. **OFF returns old behaviour:** yes. The two-argument `Resolve` is kept and returns the 26 Sep rule exactly. A test compares the OFF answer with the old rule for every word and sign-in.
2. **Default ON through both reads:** yes. Four file shapes, both reads, typed false through both; also "a settings file that cannot be read reads ON".
3. **Tests drive the behaviour:** yes. A 40-row grid of five words by four sign-ins by switch ON and OFF, once through the pure rule and once through the real gate, plus a source guard that the gate holds no version rule.
4. **REDO safety:** no finding. The gate only decides.
5. **Locked layer / Xref / REFEDIT:** no finding in this PR. The upgrade paths it opens for more logins are the existing ones with their own protection; I did not re-read them.
6. **Settings / R-00 / R-27:** switch in `options`, ships ON because it carries Tim's ruling. No block.
7. **REGRESSION_LOG.md:** present and honest.
8. **Shared files:** `UserSettings.cs` (auto-merges); `AdvancedSettingsDialog.xaml` (with #1847, auto-merged). Two existing tests were edited to set the switch OFF so they keep pinning the 26 Sep wording; that is correct.

**Findings**

1. **MEDIUM, `Modules/Drainage/Services/NativeObjects/PipeObjectUpgradeGate.cs` line 81:** Automatic now means On for every login. The "2022 to 2024 PCs keep ordinary pipes" claim covers what those PCs draw. It does not cover a drawing already upgraded on a 2027 PC being opened on a 2022 to 2024 PC. The old gate was held "until it is proven on AutoCAD 2022-2024", and the new Settings hint itself says upgraded pipes "show and edit in AutoCAD 2027". Drafter consequence, if I am reading this right: a job saved by a 2027 colleague may show those pipes wrongly or not at all for a colleague on 2022 to 2024. I have not verified how those versions treat the object, and the report does not say. Also, the open-a-job pass upgrades existing drawings in place, so every colleague's job drawings are changed on open from now on.
2. **LOW (disclosed):** the report says any held-back Codex look that assumed "non-Tim login gets ordinary pipes" now gets one-piece pipes; CE 02 owns that queue.

---

## #1847 Tidy labels default ON (B-008)

1. **OFF returns old behaviour:** yes. A settings file that says false keeps false, and the gate then answers OFF exactly as before (the command only says it is switched off and offers to switch on).
2. **Default ON through both reads:** yes. Empty file, older file with no key, file with no linking group, through both reads; false stays false and changes only itself.
3. **Tests drive the behaviour:** the default and the gate answer are real tests. The text-says-"Default: on." test is a source-text check, which is fine for wording. No test runs the command itself (unchanged by this PR).
4. **REDO safety:** no finding. A default, three tooltips and a comment.
5. **Locked layer / Xref / REFEDIT:** no finding in this PR (CDTIDYLABELS itself is untouched).
6. **Settings / R-00 / R-27:** the switch is already on the Settings page (the tooltips are updated). Nothing blocks.
7. **REGRESSION_LOG.md:** present and honest, but its entry has no blank line before the next heading (cosmetic).
8. **Shared files:** `UserSettings.cs` (auto-merges); `AdvancedSettingsDialog.xaml` (with #1846, auto-merged). Existing `TidyLabelsGateTests` was changed on purpose to expect ON.

**Findings**

1. **MEDIUM, `Modules/Drainage/Models/UserSettings.cs` line 1149:** the default changes, but `SettingsService` serialises with no default-skipping (`JsonSerializerSettings` has only `ObjectCreationHandling.Replace`), so every settings file CE has saved since this key existed holds `"tidyLabelsEnabled": false`. Those files keep false. Drafter consequence: a colleague who has saved their settings since about mid-October (when the key arrived) still gets "Tidy labels is switched off" after the update. Tim's own file (last saved 11 Mar) has no line, so Tim sees ON and the PR looks fully delivered. I have not read any colleague's file, so I cannot say how many are affected. The ruling was "ON for colleagues".
2. **LOW, `Modules/Drainage/Rules/TidyLabelsGateRule.cs` line 16:** when no settings are loaded at all, the gate still answers OFF while the property default now answers ON. Only reachable in a broken start-up; mismatch noted.

---

## #1848 BUG-901 cover to outside top of pipe (B-012)

1. **OFF returns old behaviour:** yes. `Measure` returns the old inside-top figure, `MeasuredTo` is "obvert", the wall note is empty, the evidence text is the old text, and the fix planner's "why" string is word-for-word the old one. A test grid (6 sizes x 6 materials x 5 levels) pins OFF equals the old words, outcome and basis.
2. **Default ON through both reads:** yes. Empty file, no group, empty group and a null group, both reads.
3. **Tests drive the behaviour:** yes. The report's two pipes ON and OFF, wall lookup including uPVC, SN8, RCP/RRJ and Concrete, Unknown walls, the fix planner, every other rule unchanged.
4. **REDO safety:** no finding. A reading only.
5. **Locked layer / Xref / REFEDIT:** no finding in this PR. The "lower the pipe" fix goes through the existing Apply path, which I did not re-read.
6. **Settings / R-00 / R-27:** the wall table is in Settings (file only). An unknown wall keeps the old measure and says so, and never blocks. See finding 2.
7. **REGRESSION_LOG.md:** present and honest, including that saved runs are not flagged.
8. **Shared files:** `UserSettings.cs` (auto-merges); `RulebookEngine.cs` (auto-merges with #1841; also in #1849 with a different region); `RulebookValues.cs` (real clash with #1842 and #1849: all three add lines at the end of `Resolve` after `FingerprintSettings`); `RuleFixPlanner.cs` (touched by no other PR). CE 10 slices 2 and 3 wait on this.

**Findings**

1. **MEDIUM, `Modules/Drainage/Rules/RulebookValues.cs` line 332:** the new `cover` group is deliberately left out of the CDRULES criteria fingerprint, so no saved run turns Stale. But the default flips to ON, so R-04 really answers differently on every job from the day of the update. Drafter consequence: an old saved CDRULES run can still show "cover 320 mm to obvert ... OK" for a pipe that a fresh run would warn on, with nothing marking the old run as out of date. The log states the cost ("re-run CDRULES after editing the table"); it does not say that the ordinary default flip has the same effect. #1841 takes the opposite choice for its own change (Stale once, on purpose).
2. **LOW (R-00, disclosed), `Modules/Drainage/Models/UserSettings.cs` line 313:** the wall table has no Settings page row, so a drafter cannot add UPVC 100/150 or other sizes without editing the file. Until then most small UPVC pipes will read "Pipe wall Unknown".
3. **LOW:** "Pipe wall Unknown ..." is appended to Pass rows as well as Warn rows, so many OK rows get a trailing sentence. Noise, not a wrong answer.
4. **LOW (not verified):** the shipped figures (UPVC 225 = 20 mm, concrete 375 = 45 mm) are Tim's two examples, shown as Assumed. I did not check them against a pipe maker's table.

---

## #1849 GB-01 slice 4, garages, R-33 (B-048) (stacked on #1843; no switch)

1. **OFF returns old behaviour:** not applicable (no switch). With nothing set in Settings, nothing is read from the drawing and no pipe is judged; the only visible change is two Unknown rows per job.
2. **Default ON through both reads:** not applicable. The `draftingChecks` group is blank by default and not written while blank (test pins `{}`).
3. **Tests drive the behaviour:** the geometry and the rule are well tested (crossing, inside, beside, L-shaped notch, detention under garage and dwelling, 150 UPVC SN8 pass and four wrong ones, both Unknown rows). The reader that finds the outlines in a real drawing and the pipe-route reader were never run on a real drawing (the log says so).
4. **REDO safety:** no finding. `BuildingOutlineReader.Read` opens objects `ForRead` inside the transaction it is handed; no new transaction or write.
5. **Locked layer / Xref / REFEDIT:** no finding (read only). It does not read outlines inside blocks or Xrefs, which the log states.
6. **Settings / R-00 / R-27:** layer names, drain size and material words are Settings values. Warn only. See finding 1.
7. **REGRESSION_LOG.md:** present and honest, but the new entry sits in the middle of the previous follow-up entry's list, directly under item 6 with no blank line before the heading (cosmetic).
8. **Shared files:** `RulebookEngine.cs` and `RulebookValues.cs` (real clashes with #1841, and `RulebookValues.cs` with #1848); `PipeSizeNetworkReviewService.cs` (also #1841, auto-merged); `SettingsService.cs` (via the #1843 chain, clashes with #1841); `UserSettings.cs` (auto-merges).

**Findings**

1. **MEDIUM (R-00 and "unusable until set"), `Modules/Drainage/Models/UserSettings.cs` line 115:** the feature needs the dwelling and garage layer names, and those can only be typed into the settings file. No Settings page box. Until the office does that, CDRULES shows two "not checked" Unknown rows on every job and no pipe is ever judged. The log says the Settings window has no rows.
2. **MEDIUM (process), build:** the log says the net48 build was not run ("a PC-wide build pause was asked for"). The file uses value-tuple deconstruction and `Polyline` in new files. Net48 users are in scope for every batch. It needs a net48 compile before it goes into a train.
3. **LOW, `Modules/Drainage/Rules/RulebookEngine.cs` line 691:** the allowed-under-a-garage test needs the pipe's material text to contain both "UPVC" and "SN8". If a pipe's material field says only "UPVC" and the stiffness class is held somewhere else, a correct 150 UPVC SN8 pipe warns. I did not check how CE records the stiffness class on a pipe.
4. **LOW, `Modules/Drainage/Services/BuildingOutlineReader.cs` line 81 and `PipeBuildingOverlap.cs`:** only closed lightweight polylines on those exact layer names count (case-insensitive); an outline drawn as a hatch, 3D polyline or block is ignored, and a pipe that only touches a wall corner or runs exactly along a wall is not "under". Drafter consequence: some real garages are missed and the row stays Unknown or silent.
5. **LOW (consequence):** reading every model-space entity for outlines happens on each CDRULES run once layers are named. I did not measure it on a large drawing.

---

## Shared-file summary (check 8)

1. **Real conflicts from a dry-run merge of the branch heads (only content conflicts, not REGRESSION_LOG.md):**
   1. #1838 and #1839: `UserSettings.cs`.
   2. #1841 and the garage stack (#1842, #1843, #1849): `RulebookEngine.cs`, `RulebookValues.cs`, `SettingsService.cs`.
   3. #1848 and #1842/#1849: `RulebookValues.cs`.
2. **`REGRESSION_LOG.md`:** every pair conflicts (all insert at the top).
3. **Overlap in purpose, no conflict:** #1844 and #1846 both make the one-piece pipe On for colleagues.
4. **Stacks:** #1849 on #1843 on #1842; merge #1842 first. #1841 and the stack both change `RulebookValues.Resolve` and the R-03/R-32 area, so whichever merges second needs a hand merge.
