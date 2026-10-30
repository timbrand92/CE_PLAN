# Opus re-check M2: PR #1857 (B-011, the two #1788 extras), head 718ec21c (was 09a6d1b8), Fri 30 Oct 2026, 21:26 Melbourne

Independent read-only re-check. Brief: `C:\CE_PLAN\desk_jobs\RECHECK_BRIEF_1857.txt`. Earlier review: `areas\OPUS_PREREVIEW_M_1857_B011_30OCT.md`.
I built nothing, ran no test, opened no AutoCAD, and read or wrote no real settings file. Only read-only fetches and `git merge-tree` trial merges.

## FOR TIM

1. **Verdict: RE-CHECK OK WITH NOTE. It goes in train C-79.** All five items on the fix list are done, and done correctly.
2. **What you will see in Settings:** Pipes & Pits tab, under "WHEN YOU DRAW A PIPE (CD)", a new tick box: "A figure typed with a comma in the pipe window (such as 630,5) waits until you fix that box". Design tab, under "PIPE CHECKS", a new tick box: "A material with no speed limit set is still checked in CDRULES, against the office Maximum pipe velocity". Both start ticked, including on a PC whose settings file was saved before these switches existed.
3. **What CDRULES now says:** a UPVC pipe with no UPVC speed set in Settings reads "full-bore 6.89 m/s exceeds the office Maximum pipe velocity of 6.0 m/s; UPVC has no speed limit set in Settings, so the office figure is used". It no longer calls 6.0 "the UPVC cap". If UPVC has its own 3.0 limit, it still reads "exceeds the UPVC cap 3.0 m/s".
4. **Three small leftovers, none of which hold up the train:** (a) your Settings box is labelled "Maximum velocity", while the CDRULES line says "Maximum pipe velocity"; (b) the CDRULES fix suggestion still says "above the material's scour cap"; (c) one code note still says the speed fallback shows "no new message". Project Review > Proposals > Pipe sizes still disagrees with CDRULES. That stays parked as BUG-1258 (B-064).
5. **Not proven:** I did not run the author's tests. Their report is 457 focused tests passed and 21,568 of 21,600 in the full Civil suite (0 failed). Nobody has opened it in AutoCAD. Nobody has looked at the two new tick boxes on screen.
6. **Robot test after the C-79 install:** N40 (comma) with its switch-off control and an Edit Pipe leg. N41 (speed), whose expected line changes to "exceeds the office Maximum pipe velocity of 6.0 m/s". Full steps are in DETAIL 6. A Codex look is also needed for the two tick boxes.

---

## DETAIL

### 1. Fix list, item by item

1. **Settings row, comma switch: present and correct.**
   - **Where it is:** `Dialogs/AdvancedSettingsDialog.xaml:625-626`, on the "Pipes and Pits" tab (`TabItem` at `:511`), in the right-hand column under "WHEN YOU DRAW A PIPE (CD)" (`:607`). It is the fourth tick, after "Zoom to the pipe while placing its labels".
   - **Wiring:** bound to `BoxRefusesCommaFigure`, which loads from `settings.Pipe.BoxRefusesCommaFigure` (`ViewModels/AdvancedSettingsViewModel.DraftingFixes.cs:69`). It saves to the same key only when changed (`:156-160`). It is tracked on `PipesPitsTab` (`AdvancedSettingsViewModel.cs:717`), has a value lookup (`:962`) and a search entry (`SettingsValueCatalog.cs:100`).
   - **Key:** `pipe.boxRefusesCommaFigure` (`Models/UserSettings.cs:1463-1464`, `= true`).
2. **Settings row, speed switch: present and correct.**
   - **Where it is:** `AdvancedSettingsDialog.xaml:790-791`, on the "Design" tab (`:687`), left column under "PIPE CHECKS" (`:711`). It comes straight after the Detention row.
   - **Wiring:** loads from `settings.PipeSpeedChecks.UnsetMaterialUsesOfficeFigure` (`DraftingFixes.cs:70`) and saves only when changed (`:161-165`). It is tracked on `DesignTab` (`AdvancedSettingsViewModel.cs:721`), has a value lookup (`:961`) and a search entry (`SettingsValueCatalog.cs:99`).
   - **Key:** `pipeSpeedChecks.unsetMaterialUsesOfficeFigure` (`Models/PipeSpeedChecksSettings.cs:25-26`, `= true`).
3. **Also on the Civil settings page (the Manager page):** the comma row is at `Dialogs/CivilSettingsView.xaml:202-203` under "CD DIALOG". The speed row is in its own "Pipe speed" box at `:216-218`. That page already scrolls (`:3`), so the 670 px rule does not apply to it.
4. **Ticked by default, plain English:** both labels are plain drafting words. The only command name used is CDRULES. Both tooltips say "Default: on." and contain no setting-file names, and `B011bSettingsRowsTests.cs:41-57` checks this. Reset puts both back to ON: Reset loads from `new UserSettings()` (`AdvancedSettingsViewModel.cs:1170`), and the test at `B011bSettingsRowsTests.cs:99-100` checks it.
5. **Old settings file without the key: shows ticked (from reading the code).**
   - **How it works:** Json.NET leaves a missing key at its built-in value, `true`. The window loads from `SettingsService.Current` (`AdvancedSettingsViewModel.cs:1317-1321`). If the whole group is missing, `?? new PipeSettings()` / `?? new PipeSpeedChecksSettings()` (`DraftingFixes.cs:51-52`) also gives ON.
   - **Tests on the settings model:** "the key loads ON through both start-up reads, for `{}` and for a group without the key". For the comma key this is `TypedFigureCommaTests.cs:118-131`; the speed key has the matching test in `UnsetMaterialSpeedFallbackTests.cs`.
   - **What the window test does not cover:** the window test (`B011bSettingsRowsTests.cs:77-103`, via `Bj34SettingsPersistenceTests.WithCopy`) starts from a fully saved temporary file in which the key is present, not absent. So "absent key shows a tick" rests on the code reading plus the model test, not a window test.
   - **Colleague defaults:** `colleague-defaults.json` does not list either key, so a fresh colleague install is ON too.
   - **Tim's files:** the window test writes only to a fresh temporary folder (`Bj34SettingsPersistenceTests.cs:104-119`). Nothing touches `%APPDATA%`.
6. **670 px page height: within the limit (my estimate; I did not run the test).**
   - **The rule:** only the tallest tab counts, and it must be 670 logical pixels or less. That is the same figure at 100, 125 and 150 percent, because the window is laid out in logical pixels. The guard is `Drainage.Tests/Dialogs/SettingsWindowV3Tests.cs:235`, run for 1920x1080 at 100, 125 and 150 percent (dark), 2560x1440 at 150 percent, and 1920x1080 at 100 percent (light), at `:209-214`.
   - **Pipes & Pits:** the comma row wraps to two lines in a column about 490 px wide, adding about 40 px. I put that tab's right column at about 440 px with the row in.
   - **Design:** the speed row wraps to about three lines in a column about 316 px wide, adding about 55 px. I put that column at about 450 px.
   - **Result:** both are well under 670 px and neither row is likely to become the tallest tab. The author reports the page-height tests pass on the merged head. I did not run them.
7. **CDRULES wording: done.** See section 2.
8. **BUG-1222 change-log line: restored.** See section 4.
9. **PR title and body: updated.** The title now reads "B-011 #1788 extras: comma figure refused, unset material speed takes the office figure (Settings rows added, built and tested, not tried in AutoCAD)". "NOT YET COMPILED" is gone. The PR is still a draft, with base `claude/rel-20261026z`.

### 2. The new CDRULES wording

1. **Exact text in the code** (`Rules/RulebookEngine.cs:497-513`):
   - **Warn:** `"{velocityText} exceeds the office Maximum pipe velocity of {OfficeMaximumVelocityText(scour.Value)}; {pipe.Material ?? "this pipe"} has no speed limit set in Settings, so the office figure is used"` (`:508`).
   - **Pass:** `"{velocityText} within the office Maximum pipe velocity of …; … has no speed limit set in Settings, so the office figure is used"` (`:512`).
   - **Number format:** `OfficeMaximumVelocityText` is `0.0#` plus " m/s" (`:987-988`), so it prints 6.0, 5.5 or 6.25.
   - **When the office wording is used:** only when `officeFigureStandsIn` is true (`:501`). That means the switch is ON, a figure was found, and the material's own figure is not set.
2. **Each case, from the code:**
   - **Unset material (its figure is 0 or blank), switch ON, office figure set:** new office wording, printing the Settings figure. Tests: `UnsetMaterialSpeedFallbackTests` Warn (6.0), 5.5 from Settings, and Pass.
   - **Material with its own limit:** `ScourVelocityFor` is set, so the line keeps `exceeds the UPVC cap 3.0 m/s — <source>` from `PipeSpeedLimitSources.MaxText`. The text after "3.0 m/s" is the existing source wording, for example "unconfirmed, no standard found". Tested.
   - **Office figure blank or 0:** `ScourVelocityDefaultMs` is not set (`RulebookValues.cs:284-286`). `ScourVelocityForCheck` then returns the "not set" value (`:522-523`), and CDRULES says Unknown, "no scour cap in the rulebook" (`RulebookEngine.cs:504-505`). Unknown stays Unknown.
   - **Switch OFF:** the same "no scour cap in the rulebook" as before. Tested.
   - **Material not in the table at all** (for example "Clay" when the office has no Clay row): `ScourVelocityFor` already gave the office figure before this PR, so `officeFigureStandsIn` is false. The line still reads "exceeds the Clay cap 6.0 m/s — …". That is older wording that the PR deliberately leaves alone, and the change-log entry says so ("an unknown material keeps its wording"). It is the same kind of misnaming, but not this PR's.
   - **Blank or empty material:** this resolves to the office figure through the unknown-material path. The "this pipe" text is never reached. No harm.
3. **The figure really is the office Settings figure:** `ScourVelocityDefaultMs` comes from `DesignStandards.MaximumPipeVelocity` (`RulebookValues.cs:284`, `UserSettings.cs:2331`, 6.0 as shipped). That is the Design tab "Maximum velocity" box (`AdvancedSettingsDialog.xaml:735-741`). It comes from the office settings, never from a council profile.
4. **Other places with "cap" wording:**
   - **Search:** the only remaining "… cap …" scour lines are `RulebookEngine.cs:509` (Warn) and `:513` (Pass), which are the own-limit and unknown-material cases.
   - **Fix suggestion:** the CDRULES fix advice still reads "Full-bore velocity is above the material's scour cap." for every scour Warn (`Rules/RuleFixAdvisor.cs:81`), including the office-figure case. Low.
   - **Label mismatch:** the CDRULES line and the new tick box say "Maximum pipe velocity", but the Settings label reads "Maximum velocity" (`AdvancedSettingsDialog.xaml:735`; its screen-reader name is "Maximum pipe velocity", `:741`). A drafter can still find it. Low.
5. **Stale notes:** `Models/PipeSpeedChecksSettings.cs:21` still says the fallback runs "silently with no new message". The older change-log entry, item 4 (`REGRESSION_LOG.md:24`), says the same. Both are now untrue, because the line names the office figure. The B-011b entry above them explains the change, so the record is recoverable. The code comment should be corrected the next time someone works in that file. Low.
6. **Decision record:** Tim's ruling was "agreed to two small extras". The "no new message" reading of it was already flagged GUESS (`decisions/2026-10-29_TIM_ANSWERS.md:34`). Naming the office figure in plain words follows "say when it is assumed" (R-12), and the review asked for it. It does not need a new question to Tim.

### 3. The merge of `claude/rel-20261102a` (merge commit 8ee76acb)

1. **Ordinary merge, no history rewrite:** 8ee76acb has the parents 09a6d1b8 and 91963bd0. 91963bd0 is an ancestor of 718ec21c.
2. **The PR's own work came through unchanged:**
   - **Code:** the line-by-line change of 09126560 to 09a6d1b8 (the PR's own work on its old base) is identical to the change of 91963bd0 to 8ee76acb, for every file except `REGRESSION_LOG.md`. I compared the added and removed lines; the result was "IDENTICAL_CODE_CHANGES".
   - **Change log:** the only difference there is the dropped stray edit.
3. **`UserSettings.cs` after the merge:**
   - `boxRefusesCommaFigure` appears once (`:1463-1464`, `= true`), with "Default: on." in its comment (`:1457-1462`). It sits after `editPipeReverseArrowReadsDrawnEnds` (`:1454-1455`) and before the release's BUG-1229 switch. The release's BUG-1229, BUG-1226 and declutter switches are all kept.
   - **Counts:** `JsonProperty(` goes from 539 on the release to 540 on the head, which is +1 (the comma key). The list of repeated property names is the same on both, so they are pre-existing repeats in different classes, not merge damage.
   - **Speed switch:** `unsetMaterialUsesOfficeFigure` lives only in `PipeSpeedChecksSettings.cs:25-26` (`= true`, "Default: on." at `:23`). It appears once in the whole module.
4. **No behaviour change from the release line:** between 09126560 and 91963bd0 the release did not change `PipeStartReadiness.cs`, `CdViewModel.cs`, `PipeSpeedLimitSources.cs`, `MaterialVelocityLimits.cs` or `PipeSpeedChecksSettings.cs`. It also did not touch any scour or velocity line in `RulebookEngine.cs` / `RulebookValues.cs`.
   - **Start-up reads:** the release's `SettingsService.cs` changes are the ladder and lid-class tidy-ups plus F-023 colleague defaults on a fresh profile. They touch neither key.
   - **Double switches:** none left unresolved.

### 4. REGRESSION_LOG

1. **BUG-1222 line equals the base wording:**
   - **Was wrong:** on 09a6d1b8 the BUG-1222 entry (`:44`) had item 9 as "set either switch to false" (`:56`).
   - **Now right:** on 718ec21c the entry starts at `:580` and item 9 at `:592` reads "revert this commit, or set the switch to false". That is identical to `claude/rel-20261102a` `:561` and to the PR base `claude/rel-20261026z` `:41`.
   - **Check:** the head's change log against the release is additions only, one block of 31 lines at the top.
2. **New entry (`REGRESSION_LOG.md:1-15`): accurate.** Items 1 to 3 (rows, tabs, keys, Civil page), 4 (wording, N41 change), 5 (BUG-1222), 6 (merge), 7 (files) and 9 (left alone) all match the code above.
   - **One small imprecision:** item 3 says the tests run "at 100, 125 and 150 percent, dark and light". Light is run at 100 percent only.
   - **Not checked:** I cannot confirm the test counts in item 8 (457 passed).

### 5. Clashes (read-only `git merge-tree` of head 718ec21c, fetched 30 Oct about 21:15)

1. **`claude/rel-20261102a` (91963bd0):** clean, because the head already contains it.
2. **#1868 BUG-1091 (38c3f825):**
   - **`Models/UserSettings.cs`, merged lines 1458-1509:** the release-line comma, BUG-1229, BUG-1226 and declutter switches against `largePipeRedesignReadsMinFall`. Both sides are pure additions, so keep both.
   - **`REGRESSION_LOG.md` lines 1-372:** keep all top entries.
3. **#1871 BUG-1255 (0b8698eb):** `REGRESSION_LOG.md` lines 1-95 only.
4. **#1873 B-057 (ba299320):** `REGRESSION_LOG.md` lines 1-100 only. It changes none of #1857's behaviour files. The only overlap is `UserSettings.cs`, which merges automatically.
5. **#1874 B-029 (1b8b4af1):** `UserSettings.cs` lines 3041-3065, where the release's GB-01 "RETIRED" note on the detention grade meets #1874's `rainwaterReuseBoxes`. That comes from #1874's old base, not from #1857's own work. Keep both. `REGRESSION_LOG.md` lines 1-580.
6. **#1875 B-025 BUG-816 (107a6a74):** `Drainage.Tests/Dialogs/SettingsWindowV3Tests.cs` lines 391-397. Both PRs append names to the same "tracked values" list: keep all three names (`TidyTextAfterMove`, `UnsetMaterialUsesOfficeFigure`, `BoxRefusesCommaFigure`). `REGRESSION_LOG.md` lines 1-574.
   - **Page height:** #1875 adds its row on the Drafting tab (its `AdvancedSettingsDialog.xaml:467`), not on Pipes & Pits or Design. The combined page height is unaffected, but only a run of the page-height test after that merge proves it.
7. **#1876 B-058 (d30041c4), #1877 B-061 (b9842f28), #1878 B-063 (f0500eda):** `REGRESSION_LOG.md` only, lines 1-58, 1-45 and 1-42.
8. **C-78 addendum:** no addendum branch exists on GitHub yet. The newest release branch is `claude/rel-20261102a`. So I trial-merged #1871 and #1873 separately against #1857, as items 3 and 4 above: change-log clashes only. Neither touches the readiness answer or the speed rule. I did not build a chained trial merge of all three, because that would mean writing a commit.

### 6. What is NOT proven, and the AutoCAD scenario

1. **Not proven:**
   - (a) any build or test by me;
   - (b) the author's results: 457 focused passed and 0 failed; the full Civil net10 suite at 21,568 passed, 0 failed, 32 skipped of 21,600; net48 compiled with 0 errors;
   - (c) the 670 px test result, which is estimated above, not run;
   - (d) anything in AutoCAD;
   - (e) how the two tick boxes look on screen. That needs a Codex look; a machine cannot accept a window (rule 5.7);
   - (f) the merged train after #1875 or the C-78 addendum. Rebuild and re-run the page-height and tracked-values tests there.
2. **Robot case N40_comma_refused** (can be Claude-accepted: the readout line and the button state are readable):
   - **Step 1:** on a copy drawing, run CD and type `630,5` in Diameter. Right result: the line under the window reads exactly `Diameter box: 630,5 has a comma: type 630.5`, and Start Pipe is disabled.
   - **Step 2:** type `630.5`. The comma line goes and Start Pipe enables (with the other start values filled).
   - **Step 3:** with levels in use, type `18,250` in the first invert level box. Right result: `First invert level box: 18,250 has a comma: type 18250 (no comma) or 18.250 (decimal point)`.
   - **CDEDIT leg:** run CDEDIT on an existing pipe and type `1,5` in Diameter. Save is disabled and the line reads `Diameter box: 1,5 has a comma: type 1.5`.
   - **Control N40_comma_refused_off:** set `pipe.boxRefusesCommaFigure` to false through the robot's usual settings back-up, change and restore step before AutoCAD starts, never by hand on Tim's own file. The same typing shows no comma sentence.
3. **Robot case N41_unset_speed:**
   - **Set-up:** before AutoCAD starts, set the UPVC figure in `scourVelocityByMaterial` to 0, the same way (back up, change, restore).
   - **Pipe:** draw one 300 mm UPVC pipe 10 m long with a 1.5 m fall. With the shipped Manning n of 0.010 that runs about 6.9 m/s full bore. Use a 2.0 m fall (about 7.9 m/s) if you want more margin over 6.0.
   - **Right result:** run CDRULES. The "Maximum (scour) velocity" row is Warn and reads `full-bore … m/s exceeds the office Maximum pipe velocity of 6.0 m/s; UPVC has no speed limit set in Settings, so the office figure is used`. The value-used column contains "office figure from Settings". The row must NOT contain "UPVC cap".
   - **Control N41_unset_speed_off:** set `pipeSpeedChecks.unsetMaterialUsesOfficeFigure` to false. The row is Unknown and reads "no scour cap in the rulebook".
   - **Extra leg:** put UPVC back to 3.0. The row reads `exceeds the UPVC cap 3.0 m/s`. Restore the settings file afterwards.
   - **Update the queue:** change the N41 expected line in the robot queue from the old "exceeds the UPVC cap 6.0 m/s".
4. **Codex look (one screenshot each):** Settings, Pipes & Pits tab, comma tick present and ticked. Design tab, speed tick present and ticked. Untick one, Save, reopen: it stays unticked. Reset brings it back.

### 7. Verdict

**RE-CHECK OK WITH NOTE. Train C-79.** Notes for the build register:

1. **Hand-merges in C-79:** keep both sides for each `UserSettings.cs` clash (#1868, #1874), the `SettingsWindowV3Tests.cs` tracked list (#1875), and the top-of-file change-log entries.
2. **Re-run on the C-79 head:** the focused set (count not 0) and the Settings page-height tests, with `-p:SkipDevBundle=true -nr:false --disable-build-servers`.
3. **Low follow-ups, not blocking:**
   - the "Maximum velocity" vs "Maximum pipe velocity" naming;
   - the `RuleFixAdvisor.cs:81` "material's scour cap" advice;
   - the stale "silently with no new message" comment at `PipeSpeedChecksSettings.cs:21`;
   - the older unknown-material "Clay cap" wording;
   - the speed switch still not part of the CDRULES stale check;
   - BUG-1258 / B-064 (Proposals parity), which stays parked.
4. **Acceptance:** nothing is FIXED or accepted until N40 and N41 pass after install, plus the Codex look at the two tick boxes.

### What I did not do

1. **No build, test, deploy or AutoCAD.** No settings file was read or written.
2. **Git, read-only only:** I fetched the PR branch, `claude/rel-20261102a`, `claude/rel-20261026z`, `claude/rel-20261030a` and the eight PR branches #1868, #1871, #1873 to #1878 into their `origin/...` remote-tracking refs. `git merge-tree --write-tree` wrote only unreferenced tree objects. No branch, working tree or remote changed.
3. **Scratch files only:** I read the head's files through `git show` into my scratch folder. No repository file was changed.
