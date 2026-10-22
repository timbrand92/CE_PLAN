# Opus review of the Codex overnight drafts, group A (23 Oct 2026)

Fri 23 Oct about 04:00 to 04:40 (real clock, Melbourne). Opus 5.5 (claude-opus-5-5), read only: git and gh reads, `git merge-tree` dry runs (objects only, no refs), no build, no test run, no AutoCAD, no PR comment or merge. Method as entries 1540 to 1593 of `release-v3-colleagues-REVIEWLANE_LOG.md`. I read every diff myself, not just the Codex reports.

Bases checked against the installed DLLs (product version read just now): Civil `3.0.70+40ee0a36`, Manager `1.1.70+40ee0a36` = `claude/rel-20261022m` @ 40ee0a36 (C-60); Structural `1.0.121+2c9a9694` = `claude/rel-20261022s2` @ 2c9a9694 (S-41). Every PR sits directly on its base head (0 commits behind).

## ANSWER FIRST

1. **#1524 CDCHECKIGNORE Undo (e1a59824):** MERGE. 0 HIGH, 1 MEDIUM (AutoCAD proof owed, not a code fix), 2 LOW.
2. **#1526 CDS Settings rows (f1ab1589):** MERGE-WITH-FIXES. 0 HIGH, 2 MEDIUM, 2 LOW. The tallest tab is now 673 px, over the 670 px limit.
3. **#1527 automation IDs (235e0c33):** MERGE-WITH-FIXES. 0 HIGH, 1 MEDIUM, 3 LOW.
4. **#1528 CE_TEST_STATE (5b2de089):** HOLD. 1 HIGH, 2 MEDIUM, 2 LOW. Codex itself says BLOCKED: never built, never tested.
5. **#1534 wording (a93b1b1e):** HOLD. 2 HIGH, 1 MEDIUM, 2 LOW. The pushed head has garbled characters in Checks text and in 9 command help lines. The repair exists only as unsaved edits in Codex's folder.
6. **#1535 Manager support (96c27b5b):** MERGE-WITH-FIXES. 0 HIGH, 1 MEDIUM, 2 LOW. It ships with one test that fails on purpose.
7. **#1536 guard tests (719aadac):** MERGE-WITH-FIXES. 0 HIGH, 1 MEDIUM, 2 LOW. It goes red as soon as #1524 lands, unless two test lines change.
8. **#1547 Structural outcome lines (c6672ca3):** MERGE-WITH-FIXES. 0 HIGH, 2 MEDIUM, 3 LOW.
9. **#1548 Manager outcome lines (41b326cf):** MERGE-WITH-FIXES. 0 HIGH, 1 MEDIUM, 2 LOW.
10. **Totals:** 9 PRs. 1 MERGE, 6 MERGE-WITH-FIXES, 2 HOLD, 0 REJECT. HIGH 3, MEDIUM 12, LOW 20.
11. **No default changes.** No PR touches `Shared/`, `Installer/`, CE.Host or any csproj that ships. The one csproj change is the Civil test project (#1527).
12. **C-61 order:** #1524, then #1536 (with its fix), #1527, #1526, #1548, #1535. **S-42:** #1547 after its fix. **Must wait:** #1534 and #1528.

---

## 1. #1524 @ e1a59824: MERGE, 0 HIGH, 1 MEDIUM, 2 LOW

1. **What it says:** this fixes AUDIT_C58_C60 item 2. With its switch OFF, CDCHECKIGNORE no longer runs the full drawing set-up (which could save the CE record). A cancelled re-list should no longer add an Undo step.
2. **What the diff does (checked):**
   1. `InitServicesFull` is gone. The switch is checked first.
   2. The record is read with `TryReadProjectWithoutChanging`, a read that changes nothing. CDCHECKIGNORE now has `NoUndoMarker`.
   3. Only a complete Ignore or Un-ignore calls the new hidden command CDCHECKIGNOREAPPLY, through `editor.Command`. That command owns the Undo step.
   4. The hand-over is a gate held per drawing (instance field, not static). It is used once and cleared, even after a failure.
   5. The rule findings now come from the same `ReadRulebookLiveSnapshot(...).Evaluate(GetRulebookValues(...))` route as CDCHECKS. I compared it with `ChecksResultReader.Read`: same evaluation, and only the source of the record differs. The numbering therefore matches the Checks list.
3. **What Tim will see:** with the switch OFF (the default), CDCHECKIGNORE prints the same "switched off ... Nothing was changed" line. It no longer quietly saves the drawing record. With the switch ON, one completed Ignore is one U.
4. **Defaults / Settings:** none changed. `checks.allowIgnoreFinding` stays OFF.
5. **Redo-safe / locked layers / Xrefs:** the list reads the drawing only (open-close read, nothing written). The only drawing write is the existing one-transaction writer. No geometry is touched, so locked layers and Xrefs do not apply.
6. **CE_SHARED:** not touched.
7. **Tests:** 12 tests of the gate logic and 7 source pins. The pins fail on the old code by construction: `InitServicesFull(` was present and the flags differ. Codex reported a red run first. Four older guards were re-pointed to the new signature without weakening them (I read each one).
8. **MEDIUM, AutoCAD proof (checklist, not code):**
   1. Unit tests cannot prove what AutoCAD does when a `NoUndoMarker` command calls a normal command through `editor.Command`.
   2. CE's own start and end handlers (`RedoWindowGuard`, `LinkService.Reactors`) still run for every command, CDCHECKIGNORE included. The #1528 report describes this, so "REDO survives a re-list" may still fail.
   3. The Codex checklist in `CODEX_BUILD_IGNORE_UNDO_22OCT.md` (cases 3 to 8) is the acceptance test. Keep BUG-CDCHECKIGNORE-UNDO-C60 open until it passes.
9. **LOW:** code comments still call this "BUG-866", which is now the engineering bug's number. Rename them at the next touch.
10. **LOW:** checklist case 8 expects the old OFF sentence exactly, but #1534 rewords it. Whichever lands second must update the checklist text.
11. **Clashes:**
    1. #1534 in `CheckIgnoreCommand.cs`: keep `WriteChoice(...)` and take #1534's new message wording.
    2. #1528 in `CrossModuleGuardTests.cs`: both go from 146 to 147, so with both merged the count must be **148**.
    3. #1536: a test-only clash (see entry 7).
12. **Colleague risk on 9 Nov:** low. The switch is OFF, and the OFF route is now strictly safer than C-60.

## 2. #1526 @ f1ab1589: MERGE-WITH-FIXES, 0 HIGH, 2 MEDIUM, 2 LOW

1. **What it says:** adds CDS rows for six existing saved switches that had no row (owed since entry 1559 item 5): `layerChecks.wrongLayerRows`, `layerChecks.layerDiffersRows`, `checks.leaveOutRemovedPits`, `checks.showProgressWhenSlow`, `checks.progressAfterSeconds` and `doubleClick.sourceEditWindow`.
2. **What the diff does (checked):** a new partial view model loads from `SettingsService.Current` and resets from `new UserSettings()`. There is no second set of defaults. Save writes only values that changed. Unreadable seconds text warns and keeps the saved figure, without blocking Save (R-27). It adds search-catalogue entries, tab-dot lists and six controls.
   1. **Fixes tab:** "Drawing checks" (three ticks).
   2. **Display tab:** "DRAWING CHECK PROGRESS".
   3. **Newer tools > Double-click:** the source Edit tick.
3. **What Tim will see:**
   1. **Newer tools > Double-click:** a ticked box, "Double-click a downpipe, inlet or overflow to open Edit".
   2. **Display:** an unticked "Show progress while a drawing check is busy" box and a "Show progress after (seconds)" box reading 1.
   3. **Fixes:** three unticked boxes under "Drawing checks".
   4. I looked at the committed off-screen pictures for Fixes, Display and Newer tools (dark): nothing is cut off or overlapping.
4. **Defaults / Settings:** none changed. Defaults come from the model: ON for sourceEditWindow, OFF for the other four switches, 1 second.
5. **Redo-safe:** Settings window only, with no drawing contact.
6. **CE_SHARED:** not touched.
7. **Tests:** 34 new. Before the change, the first test run gave 6 failures, one for each missing row, so the tests are real. They cover bind, edit, save, read back, reopen, Reset and Cancel-keeps-the-file-bytes, and they use temporary settings files only.
8. **MEDIUM, the 150% fit is over the 670 px limit:**
   1. Codex's own report says the tallest tab now needs **673 px** (C-60: 670 px). The test still passes, because its real limit at 150% on 1080p is about 688 to 690 px. The brief's limit is 670.
   2. From the pictures, the Fixes middle column, where "Drawing checks" was added, is now the longest. Newer tools > Checks list has about 120 px free under its last tick.
   3. **Fix:** move the three "Drawing checks" ticks to the right column of Newer tools, under "Checks list". That is also the right home, because the Fixes tab holds "the old behaviour was a fault" ticks that are ON by default, and these are new checks that are OFF.
   4. Change their three catalogue entries from `FixesTab` to `NewerToolsTab`. Re-run "Settings fits 1920x1080 at 150% (dark)" until the tallest tab is at most 670 px, and re-take the pictures.
9. **MEDIUM, untrue hint:** the progress tooltip and catalogue text say "status-bar line" and "Esc cancels the check". The C-60 feature prints a command-line line and has no Esc cancel (`SlowWorkProgressTicker.cs` line 10: "Esc to cancel is NOT built here"). **Fix (in the XAML tooltip and the `ShowProgressWhenSlow` catalogue entry):** "Shows a line on the command line, about once a second, while CDCHECKCURRENT is still busy. Default: off."
10. **LOW:** the wrong-layer tooltip says objects can be "moved back to their usual layer", but there is no Fix button yet (entry 1542). Drop "and moved back to their usual layer".
11. **LOW:** "List layers with a different colour or linetype" saves a choice that nothing reads yet (the tooltip says so honestly). Consider leaving this row out until the check is connected, so colleagues do not tick a box that does nothing.
12. **Clashes:**
    1. #1534 in `SettingsValueCatalog.cs` (keep both: the six new entries plus #1534's reworded Fixes entries).
    2. #1528 in `AdvancedSettingsViewModel.cs` Reset (keep both `LoadCheckRowValues(new UserSettings())` and `LoadTestStateValue(new UserSettings())`) and in `SettingsValueCatalog.cs` (keep both).
    3. All three PRs also edit `AdvancedSettingsDialog.xaml`. The 150% fit must be re-run on the merged train.
13. **Colleague risk:** low once the fit is back under 670. At 673 it still fits a 1080p screen at 150%, but with less room than agreed.

## 3. #1527 @ 235e0c33: MERGE-WITH-FIXES, 0 HIGH, 1 MEDIUM, 3 LOW

1. **What it says:** fixes CODEX_HUNT_WINDOWS. Every button, box and tab in the key Civil windows gets a fixed name the robot can find: Edit source, Edit pipe, Edit pit, Edit selected pipes, New pit, CDS, Checks, What CE Found, X-Civil import, Help, About.
2. **What the diff does (checked):**
   1. Edit source, Civil Help and About get direct attributes only. The XAML is otherwise identical, which I checked line by line.
   2. A new `CivilAutomation.cs` hooks into `ThemeService` for the named window types. It walks each window and gives every interactive control an ID built from its name or binding path, plus a spoken name. Any ID already set is left alone.
   3. No protected editor file is edited.
3. **What Tim will see:** nothing. The same windows, words, colours and layout.
4. **Defaults / Settings:** none. There is no switch; the IDs are invisible accessibility labels.
5. **Redo-safe:** no drawing contact.
6. **CE_SHARED:**
   1. The shipped bundles are unchanged. The Civil *test* project now builds Manager and copies only `CE_SUITE_MANAGER.dll` (`Private="false"`), so Civil tests now break whenever Manager does not compile.
   2. The About window XAML is a Manager file. **Manager must ship in any train that takes this PR.**
7. **Tests:** 26 new, walking all eleven windows and tabs in both themes. They check that IDs are unique, not blank, the same in both themes and published to UI Automation. They would fail without the change (no IDs). But they call `CivilAutomation.Refresh` directly, so they do not prove the live trigger (LOW 2).
8. **MEDIUM, no safety net in always-on code:**
   1. `State.Loaded` and `State.Apply` run inside a dispatcher callback on every open, plus every drop-down and sub-menu, of the Pipe, Pit and Batch editors, CDS, Checks and What CE Found, for every colleague.
   2. They have no try/catch. An unexpected exception there is an unhandled UI exception inside AutoCAD.
   3. **Fix:** wrap the body of `Apply` (and the queued lambda in `Loaded`) in try/catch that logs one warning and carries on. Add a source guard.
9. **LOW:** `Loaded` is a direct event. Hooking it on the window root only fires for the window itself, not for content that appears later (rows after "Check again", a tab first opened later), so those controls get IDs only at the next drop-down. The code comment "Loaded bubbles" is wrong. Add a throttled pass on `TabControl.SelectionChanged` / `ItemContainerGenerator.StatusChanged`, or accept it and tell the robot lane.
10. **LOW:** the spoken name for the import button binds with `StringFormat = spokenScope + ", {0}"`, where `spokenScope` can hold on-screen text. A `{` or `}` in that text would break the format. Escape the braces (`Replace("{","{{").Replace("}","}}")`).
11. **LOW:** clash with #1534 in `CeVersionWindow.xaml`. When both land, keep #1534's `Title="CE versions"`, keep `AutomationId="AboutCE"` / `"AboutCE.Close"`, and set the two names to "CE versions" and "Close CE versions".
12. **Colleague risk:** low after the try/catch. Without it, a rare layout case could raise an error box inside an editor window.

## 4. #1528 @ 5b2de089: HOLD, 1 HIGH, 2 MEDIUM, 2 LOW

1. **What it says:** a hidden command, CE_TEST_STATE, for the Codex test runner. It prints one line of JSON with DBMOD, UNDOCTL, UNDOMARKS, the selected handles, pit and pipe counts, the last three CE outcomes and installed versions. A new switch, `testing.stateCommand`, default OFF, gets a row on CDS > Advanced.
2. **Status (Codex's own words):** "BLOCKED, not built or tested". There were no builds, no test runs and no pictures.
3. **HIGH, not read-only (Codex's diagnosis, I agree from the code):** typing CE_TEST_STATE still fires CE's own command start and end handlers. `RedoWindowGuard.OnCommandWillStart` closes the REDO hold and releases deferred work. `LinkService.Reactors` can apply pending links, draw order and a waiting record save at command end. The command flags cannot stop those, so the observer can change what it is meant to observe. The fix needs the owners of those protected files.
4. **MEDIUM, never compiled or run, and two reds are likely:**
   1. `SettingsWindowV3Tests`' strict binding list does not get `TestingStateCommand` added (#1526 had to extend the same list).
   2. With #1536 merged, the new `TestingSettings.stateCommand` and `UserSettings.testing` have no `Default:` doc line, so `NewSettingsKeys_NeedADocumentedDefault` fails.
   3. Its own window test asserts each *page* is at most 670 px, at 100%. That is a different, easier measure than the window-height figure the 150% fit uses, so it would not catch a fit problem.
5. **MEDIUM, clashes:**
   1. #1524: `CrossModuleGuardTests` count, both 147, so 148 when merged.
   2. #1526: view-model Reset and the catalogue (keep both).
   3. #1534: `AdvancedSettingsDialog.xaml`. #1534 rewrites the heartbeat tick text right where this row is inserted; keep #1534's text and add this row after it.
6. **LOW:** a test-runner switch on a colleague's Advanced tab, worded with "drawing test command" and "test runner". Plain-English rule: consider hiding the row unless the robot's test profile is active, or word it "For CE testing only. Leave off."
7. **LOW:** the new tick is missing the house pattern (`Foreground="{DynamicResource TextPrimaryBrush}"`, `Tag` on the CheckBox, `TextWrapping="Wrap"`).
8. **What Tim would see:** an unticked "Allow the read-only drawing test command" box on CDS > Advanced. Nothing else.
9. **Defaults:** new switch OFF. When OFF, the command body returns at once, but the handlers in item 3 still run if someone types it.
10. **Must wait:** route the handler exceptions to the protected-file owner. Then build, test and re-review.

## 5. #1534 @ a93b1b1e: HOLD, 2 HIGH, 1 MEDIUM, 2 LOW

1. **What it says:** fixes AUDIT_UI_WORDING findings: 48 corrected and all five HIGH ones. Plain wording in CE_VERSION, Manager Updates, the Ignore messages, Checks, the Settings and Fixes tooltips, the ribbon and Help.
2. **HIGH, garbled characters in the pushed head (checked byte by byte against the base):**
   1. `Modules/Drainage/Rules/RulebookEngine.cs` has 5 lines where "−", "×", "–", "—" and "→" became "âˆ’", "Ã—", "â€“", "â€”" and "â†’". One is the pipe name a finding shows: `return from + "â†’" + to;`, so P1→P2 would read "P1â†’P2" in the Checks rows and in the finding's key.
   2. `Modules/Drainage/Assets/Config/command-registry.json` has 9 help lines with "â€”" and "â€¦" (for example CDSLAB, CDSPOON, CDDELPIT, CDAGI, CDTPZ).
   3. Codex's report item 16 says this was repaired, but **the repair was never pushed**. `C:\cw60` still shows 46 changed, uncommitted files on top of a93b1b1e. The branch has one commit (00:55).
3. **HIGH, no test result at this head:**
   1. Its own REGRESSION_LOG entry says "no build/test pass claimed yet".
   2. The last full net10 run had 3 failures, two of them its own.
   3. Its net48 run had 372 failures still being diagnosed.
4. **MEDIUM, clashes (code conflicts):**
   1. #1524 in `CheckIgnoreCommand.cs`.
   2. #1526 in `SettingsValueCatalog.cs`.
   3. #1527 in `CeVersionWindow.xaml`.
   4. #1528 in `AdvancedSettingsDialog.xaml` and `SettingsValueCatalog.cs`.
   5. The resolutions are listed under each of those PRs.
5. **Checked and fine:** the AutoCAD year list. It maps only known releases and shows "not read" for anything else. AutoCAD 2027 is R26.0, which I read from the installed acad.exe (R26.0.60). The Manager update messages now end "Ask your CE administrator"; no installer is started.
6. **LOW:** the CE_VERSION window already cuts off its bottom lines and its light-theme heading is white on pale (Codex found this, and it predates this PR). Park it as its own window fix.
7. **LOW:** I did not verify the claim that the reworded rule-value phrases keep an ignored finding ignored (item 13 of its report). That claim needs its own test result at the final head.
8. **What Tim would see (once fixed):** for example, CE_VERSION titled "CE versions" showing "AutoCAD 2027"; Checks rows like "P3 is 900 x 900 mm. CE's pit-size table suggests 1050 mm for these pipes and this depth. Check the pipes fit."; the ribbon button "Settings" instead of "CE Settings".
9. **Defaults:** none changed.
10. **Must wait:** Codex must push the repaired head and run the full net10 suite plus focused net48 and the 150% fit at that head. Then re-review.

## 6. #1535 @ 96c27b5b: MERGE-WITH-FIXES, 0 HIGH, 1 MEDIUM, 2 LOW

1. **What it says:** fixes CODEX_HUNT_MANAGER. Open Logs opens the real log folders. CESUPPORT collects the Structural daily logs and command records, the Civil grip and ribbon-click logs, and this PC's latest office diagnostics report. A broken ribbon part or a broken `manager-switches.json` now leaves a line in the CE log and one plain command-line notice, instead of a hidden trace. The palette tile item is NOT fixed (protected file).
2. **What the diff does (checked):**
   1. **Open Logs:** opens `CE_CVL_SUITE\logs`. When Structural is loaded it also opens `CE_STRUC_SUITE\logs` and `TIM_CE_CADTOOLS\logs`.
   2. **Support zip:**
      1. It adds two folders to the allow-list, plus the Structural `RuntimeDiagnostics` folder, and widens the file-name pattern.
      2. It takes only the newest dated report from this PC's own coded folder under the IT admin path.
      3. Everything still goes through the existing scrubber and the 5 MB limit, and the private name book is still refused.
   3. **Failure notices:** once per problem type per session, written when a drawing is open.
3. **What Tim will see:**
   1. **CE Tools > Open Logs:** opens the Civil log folder (before: the CE_CADTOOLS data folder).
   2. **CESUPPORT:** the zip notes list the extra logs.
   3. **When something is broken:** one line such as "[CE Manager] Part of the CE ribbon could not open. The reason is in the CE log. You can still type CE commands."
4. **Defaults / Settings:** none changed. A broken switch file still means every switch is OFF.
5. **Redo-safe:** no drawing contact.
6. **CE_SHARED:** not touched. Codex hashed all three CE_SHARED outputs and found them byte-identical to Civil's.
7. **Tests:** 13 new. The 5 tests run against the unchanged code all failed first (B1 to B4 reproduced). Manager full suite: 865 of 866, the one red being the palette guard.
8. **MEDIUM, a red test ships with it:** `PaletteTile_UsesTheSameCancelFirstPathAsRibbon` fails by design until the palette owner changes `CeBlocksPaletteService`. A train with this PR therefore has a red Manager suite, and the finalizer would stop. **Fix:** mark that one test `[Ignore("BUG-<n>: palette owner change pending, see CODEX_BUILD_MANAGER_SUPPORT_23OCT item 10")]`, as #1536 does for its known defects. Carpark the palette fix.
9. **LOW:** with Structural loaded, one click opens three Explorer windows. Fine for support, slightly noisy. The tooltip calls `TIM_CE_CADTOOLS\logs` a Structural log; confirm which plugin writes there.
10. **LOW:** the new Manager outcome log from #1548 (`%APPDATA%\CE_SUITE_MANAGER\logs\ce_manager_structured_*.log`) is not on the support-zip allow-list or file-name pattern. Add it when both land.
11. **Clashes:** REGRESSION_LOG.md only.
12. **Not checked:** the Civil full suite was stopped by Codex (live-settings hash, see "Also seen"). This PR changes no Civil file and no Shared file, so the C-61 finalizer's Civil run covers it.

## 7. #1536 @ 719aadac: MERGE-WITH-FIXES, 0 HIGH, 1 MEDIUM, 2 LOW

1. **What it says:** tests only, no product change. It adds guards for the C-60 audit defects: a silent empty selection on double-click, Checks and outcome logging staying read-only, the switch checked before any drawing set-up, the Tidy preview, existing layers not restyled, and every new Civil setting needing a documented default. The known defects (BUG-863, BUG-864) are named, ignored contracts.
2. **Tests meaningful?**
   1. **Yes:** the eight missing-key default tests (`Options.CommandOutcomeLines` ON, `DoubleClick.SourceEditWindow` ON, the other six OFF) read a fresh model. Each would fail the day a default flips.
   2. **Yes:** the settings-declaration census, which fails on any new key without `/// ... Default: X` and an initialiser.
   3. **Weaker:** the source pins are regex reads of the code. They are useful early warnings and brittle to renames, as the file itself says.
3. **MEDIUM, clash with #1524:**
   1. `KnownDefectQuarantines_StillIdentifyTheirExactSourceSites` asserts that `CheckIgnoreCommand.IgnoreFinding` still contains `InitServicesFull(`. #1524 removes it, so this test goes **red** once both are in.
   2. **Fix, in the train after #1524:** delete that one assertion, and remove the `Ignore` on `DisabledIgnore_ChecksItsSwitchBeforeDrawingInitialisation`. It then passes, because nothing writes before the gate in #1524's code.
   3. Also, #1528 (and any group-B draft that adds a Civil setting) must add a `Default:` doc line to each new key, or this census fails.
4. **LOW:** the BUG-864 pin reads the old Structural copy inside the Civil branch, not S-41. The comment says so, but the pin proves nothing about S-41.
5. **LOW:** a 468-line frozen key list is now one more file that must change if a legacy key is renamed. Acceptable.
6. **What Tim will see:** nothing.
7. **Defaults / CE_SHARED / Redo:** none touched.

## 8. #1547 @ c6672ca3: MERGE-WITH-FIXES, 0 HIGH, 2 MEDIUM, 3 LOW (Structural)

1. **What it says:** fixes the AUDIT_C58_C60 point that Structural writes no command-outcome lines. Each Structural command now writes one INFO line to the Structural log, "Command outcome: SBEAM completed 812 ms", using cancelled, refused or failed where they apply.
2. **What the diff does (checked):**
   1. Event hooks on each drawing (command start, end, cancelled, failed, and every prompt result).
   2. Explicit completed or refused marks in CEMEMBER, SBEAM, hatch, CEHATCHCHANGE/AUDIT, reo bar, the drawing-safety refusals and the command history.
   3. The list of command names is read once from the plugin's own `[CommandMethod]`s (395).
   4. The switch is Civil's existing `options.commandOutcomeLines`: read live from a loaded Civil, otherwise from `CD_Settings.json`, and if missing, ON.
   5. No drawing name, path or prompt answer is written.
3. **What Tim will see:** drawings behave exactly as before. The Structural log gains one line per Structural command. Unticking CDS > Advanced > "Log one line for each CE command that ends" turns these off too.
4. **Defaults:** no new switch. It reuses the Civil switch (ON). That is acceptable for the same reason as #1507: it writes the log only, never the drawing, and the missing line is the defect.
5. **Redo-safe / locked layers / Xrefs:** hooks and marks only, with no transaction, system variable or command, and every handler catches its own errors. The drawing-safety refusals are only *marked* refused; the existing locked-layer and Xref refusals themselves are unchanged.
6. **CE_SHARED:** not touched (Structural has its own copy).
7. **Tests:** 46 new. The logger semantics use a fake clock, and a coverage test checks all 395 compiled names. They would fail without the code (none of these classes existed).
8. **MEDIUM, the fixed reader was not carried over:** Codex found (report item 12) that `DataContractJsonSerializer` on a plugin type can throw while it inspects AutoCAD attributes. It fixed this **in Manager only** (41b326cf). Structural's `CommandOutcomeSetting.Parse` still uses it, and its catch returns OFF, so when Civil is not loaded Structural lines could silently stop. **Fix:** copy Manager's `JsonReaderWriterFactory` reader and its tests into Structural.
9. **MEDIUM, no full Structural suite:** Codex's full run hung and was stopped. The S-42 finalizer must run the full Structural suite (with the S-41 `SbeamEditAutoCadEvidenceReaderTests` exclusion) before shipping.
10. **LOW:** the name list is built with `Assembly.GetTypes()` inside a `Lazy`. A type-load failure would be cached and silently disable every line. Catch `ReflectionTypeLoadException` and use `ex.Types.Where(t => t != null)`.
11. **LOW:** a mark goes to the newest run in that drawing. If a native command is nested inside a CE command, the CE mark is dropped (the outcome then defaults to cancelled or completed). Rare.
12. **LOW:** there is no Structural Settings row. The only off switch is in Civil's CDS, so a Structural-only PC can turn it off only in the settings file.
13. **Clashes:** none in Structural against S-41 except REGRESSION_LOG.md.

## 9. #1548 @ 41b326cf: MERGE-WITH-FIXES, 0 HIGH, 1 MEDIUM, 2 LOW (Manager)

1. **What it says:** the same as #1547, for Manager commands (CE_VERSION, CEMANAGER, CEHEALTH, CEBLOCKINSERT, the admin refusals and so on). The lines go to a new `%APPDATA%\CE_SUITE_MANAGER\logs\ce_manager_structured_YYYYMMDD.log`.
2. **What the diff does (checked):** the same hooks and logger as Structural, with the safer JSON reader. Marks happen only on the AutoCAD thread. The CEBLOCKINSERT refusals (locked layer and so on) are marked refused, and their behaviour is unchanged.
3. **What Tim will see:** nothing in drawings or windows. A new Manager log file each day.
4. **Defaults:** reuses the Civil switch (ON). No new switch.
5. **Redo-safe:** hooks only. The log write is a small file append on the AutoCAD thread (LOW 2).
6. **CE_SHARED:** not touched.
7. **Tests:** 48 new. Codex reran Manager in full: 901 of 901.
8. **MEDIUM, CEBLOCKS is counted twice:**
   1. Civil's outcome logger (#1507) already writes a line for CEBLOCKS, because CEBLOCKS is in Civil's command registry.
   2. CEBLOCKS is a Manager `[CommandMethod]`, so this PR writes a second line in the Manager log, and the desk watcher would count one command twice.
   3. **Fix:** in Manager's `CommandOutcomeRegistry`, skip CEBLOCKS while `CE_CVL_SUITE` is loaded, with a test. The alternative is to have the desk reader drop Manager's CEBLOCKS line.
9. **LOW:** the support zip does not collect this new log (see #1535, LOW 2).
10. **LOW:** `File.AppendAllText` on the AutoCAD thread for each Manager command. It is tiny, but Civil queues its log writes in the background, and this could do the same later.
11. **Clashes:** REGRESSION_LOG.md only.

---

## Clash map (every pair that clashes beyond REGRESSION_LOG.md)

Checked with `git merge-tree` pairwise and as one chain on C-60 (objects only). Every PR also clashes with every other in REGRESSION_LOG.md: keep every entry.

1. **#1524 x #1534:** `CheckIgnoreCommand.cs` (keep `WriteChoice`, take the new Ignored wording).
2. **#1524 x #1528:** `CrossModuleGuardTests.cs` (count 148).
3. **#1524 x #1536:** no text conflict, but a test goes red (see entry 7, MEDIUM).
4. **#1526 x #1534:** `SettingsValueCatalog.cs` (keep both). Both also edit `AdvancedSettingsDialog.xaml` and `SettingsWindowV3Tests.cs`, which merge cleanly; re-run the 150% fit.
5. **#1526 x #1528:** `AdvancedSettingsViewModel.cs` (keep both Reset lines) and `SettingsValueCatalog.cs` (keep both).
6. **#1527 x #1534:** `CeVersionWindow.xaml` (Title from #1534, IDs from #1527, names follow the title).
7. **#1528 x #1534:** `AdvancedSettingsDialog.xaml` (keep #1534's heartbeat text, add the test row after it) and `SettingsValueCatalog.cs` (keep both).
8. **#1528 x #1536:** no text conflict, but the settings census goes red until `Default:` doc lines are added.
9. **#1547:** Structural only, no clash.
10. **#1548 and #1535:** no file overlap with each other or with the Civil PRs.

## Recommended merge order

1. **C-61, Civil + Manager, base `claude/rel-20261022m` @ 40ee0a36:**
   1. #1524 e1a59824 (plain MERGE).
   2. #1536 719aadac, then the two-line test change in entry 7 item 3. The assembler or finalizer can make it, or Codex can push it to a branch that contains #1524.
   3. #1527 after its try/catch fix.
   4. #1526 after the move to Newer tools and the hint wording. Then the 150% fit must show at most 670 px on the merged train.
   5. #1548 after the CEBLOCKS fix.
   6. #1535 after the palette test is marked Ignore.
   7. With my dry-run order, only REGRESSION_LOG.md clashed (the chain was clean in code for these six).
2. **Manager must ship in C-61** if #1527, #1535 or #1548 is taken. No PR changes Shared, so CE_SHARED stays byte-identical between Civil and Manager.
3. **S-42, Structural, base `claude/rel-20261022s2` @ 2c9a9694:** #1547 after the reader fix, plus a full Structural suite run.
4. **Must wait:**
   1. **#1534:** push the repaired head and test it, re-review, then resolve the clashes listed above. It also changes Manager files.
   2. **#1528:** handler exceptions from the protected-file owners, then build, test and re-review.
5. **If the fixes are not back in time for C-61:** #1524 alone can go as a plain MERGE. #1536 can go with it only together with its two-line test change.

## Also seen (for the desk, not a PR item)

1. **Tim's live `TIM_CE_CADTOOLS\CD_Settings.json` changed overnight, writer unknown.**
   1. Three Codex reports (settings rows, test state, guard tests) and the Manager support report saw it change between `2d23331f` and `acd64e79` during the night. The change came while AutoCAD sessions started through Explorer were running (00:18, 00:20, 01:46).
   2. It reads `acd64e79` now (04:36), the same value recorded in the 20 to 22 Oct reviews.
   3. None of these PRs writes it (their tests use temporary settings). It looks like a robot settings-swap and restore, but that is not proven. Worth one writer trace.
2. **Not checked by me:** no build, no test run, no AutoCAD. I did not look at the light-theme pictures or the 150% previews, and I did not run any merged-lane test. Built and unit-tested by Codex where stated; nothing is installed; nobody has opened any of it in AutoCAD.
