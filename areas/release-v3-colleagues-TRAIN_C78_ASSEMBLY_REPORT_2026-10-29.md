# Train C-78 assembly report (restart run, 30 Oct 2026, 16:00 to 16:40 Melbourne)

Built and unit-tested only. Nobody has opened any of this in AutoCAD. No PR had an independent read before this assembly.

## ANSWER FIRST

1. **Branch `claude/rel-20261102a`, head `636d4a4dce9d9273e73750f7a0b6acff75b59586`, pushed.** Two PRs merged, both by the first run at 14:28 and 14:29 (it died at 15:47 on the Team session limit AFTER pushing both merges; the restart note said no branch existed at 15:56, but it does exist on the remote at the first run's head, so I checked its merges and kept them). I did not re-merge anything and I did not create a second branch.
2. **Base tip used: `f5dd72a0652c7f749ab52228cea0f9675047b9cb`, the C-77 version commit "Version: Civil 3.0.87 / Manager 1.1.87 (C-77)"**, and it is the live tip of `claude/rel-20261030a` (read with git ls-remote). It sits directly above the C-77 finalizer's signed head `02681d9f` (GO at that head, first line of the C-77 finalizer report). The four version places on my branch still read 3.0.87 / 1.1.87. No version bump by me.
3. **Merged (2 of the 2 PROMOTED items):**
   1. **#1867 (B-049a BUG-1227 Part A, pit copy keeps the original's pipe ends)**: live head `a6969702797d1a077a2709139a99d74c0ab499f0` (gh, `refs/pull/1867/head` and the branch all agree), equal to the list's reference head, did not move. Merge `3c75396c`. Second parent equals the head.
   2. **#1858 (B-023 BUG-857, Grade mismatch box: Esc and the X cancel)**: live head `c92db9ad76855ab683c22c0ba8fd573708a82b87`, equal to the reference, did not move. Merge `636d4a4d`. Second parent equals the head.
   3. Both PRs are still OPEN drafts. Their stated bases (`rel-20261029a`, `rel-20261026z`) are older lines; both merged onto the C-77 tip with only `REGRESSION_LOG.md` clashing.
4. **Skipped, as the list says NOT PROMOTED (or as told): B-016, B-018, B-021, B-022, B-026, B-009, B-010, B-011, B-013, B-014, B-017, B-020, B-033, B-034, section 4 items 15 and 16, and #1863, #1868, #1857, #1854, #1855, #1869.** The list file was unchanged when I finished (last commit `8f65d2b0`, 12:24 on 30 Oct): only items 17 and 18 are PROMOTED. BUG-1255 and the plain RG label were not in the list when I reached the end of my merges, so they are NOT in this train.
5. **Touches Shared, Installer or Manager: NONE.** `git diff --stat f5dd72a0..HEAD -- Shared Installer Installer.Tests Modules/Manager/Installer Modules/Manager Modules/Manager.Tests Modules/Arch.Tests Modules/Arch.Tests.Structural` is empty. CE_SHARED is unchanged. **Manager code is not changed, so Manager 1.1.88 is a re-stamp.**
6. **Settings:** two keys added, no key changed or removed. `UserSettings.cs`: +20 lines, 0 removed (pure additions). `DiagSettings.cs` and `DoubleClickSettings.cs`: empty diff.
   1. `linking.pitCopyKeepsOriginalPipeEnds` (#1867): default ON. Guards a fix.
   2. `grade.mismatchBoxCloseCancels` (#1858): default ON. Guards a fix.
7. **Build:** whole solution Release, `-m:8`, 0 errors, 273 warnings. net48, net8.0-windows and net10.0-windows all built (Civil, Manager, CE_SHARED). `Tests\CE.TestHarness.Tests`, `Installer` and `Installer.Tests` compiled, not run.
8. **Tests, all green except the known net48 reference-only reds:**
   1. Civil net10 Release full: **21,528 total, 21,496 passed, 32 skipped, 0 failed.** Floor was the C-77 finalizer's 21,505; the 23 extra are the new tests (14 in Bug1227PitCopyKeepsPipeEndsTests, 9 in Bug857GradeMismatchBoxTests).
   2. Manager net10 full: **1,085 total, 1,084 passed, 1 skipped, 0 failed** (equals the C-77 finalizer's 1,085).
   3. Civil net48 focused (193 class-name filters): **4,813 total, 4,558 passed, 141 skipped, 114 failed.** The 114 are exactly the C-77 finalizer's 114 names (compared by name against the assembler's C-77 trx: nothing new; the only difference is `NewSettingsKeys_NeedADocumentedDefault`, which the finalizer fixed and which passes). All 114 are `InvalidProgramException` from the reference-only AutoCAD DLL.
   4. Manager net48: built, 0 errors.
   5. Arch Civil half: **14 of 14.** Structural half KNOWN RED 3 of 4, not run.
9. **Anything for the finalizer:** (a) the guard in `LinkService.Geometry.cs` is in the pit-to-pipe link walk (REDO and copy cases); N36 with control C36 is the proof. (b) `GradeMismatchDialog.xaml` changed (a window): needs a Codex look. (c) One existing test line was edited by #1867 (`Bug285To298C5Tests.cs`, one line): a source-text pin that now expects the call to carry a fifth argument; the finalizer should read it, it is the only changed existing line in any test file.
10. **Not run by me:** the PDF page test, Bug960 and the 300-pipe timing test all passed in the full run (no re-run needed).

## MISTAKES AND CAVEATS (first)

1. **The first run's whole-solution build ended `EXIT -1` after 5,141 s** (log `C:\ce-asm\logs78\sln_build.txt`, died with its session). I re-ran the same build (normal priority, ran in 261 s because most outputs were current) and it passed with 0 errors. The Drainage net48 build was among the outputs finished in the rerun.
2. **AutoCAD (acad.exe) was OPEN during every one of my test runs** (CE 02's robot pass; the count was 1 each time). I never touched it.
3. **`CD_Settings.json` changed during my window:** hash before (16:07) `ACD64E79...3140`, after (16:34) `3C6CB8E0...0E0B`, last-write 16:33:47. My Civil net10 run was running at that time with TEMP and log folder under `C:\ce-asm\t78_civil10`, but a robot AutoCAD pass was also running and rewrites this file; I cannot say which wrote it, and I did not touch it. The other three settings files are unchanged. `%APPDATA%\CE_SUITE\manager-switches.json` does not exist (before and after).
4. **Ran one top-level dotnet command at a time**; the slot count at the start of each was 1 or less (it read 1 for the Manager, net48 and Civil net10 steps), so I always had a slot. The build lock was taken for every test step (my PIDs, removed after each; none left behind).

## WHAT IS INSTALLED (read from the six DLLs, read-only)

Civil Legacy, Net8 and Modern: **3.0.87+f5dd72a0652c7f749ab52228cea0f9675047b9cb**. Manager Legacy, Net8 and Modern: **1.1.87+f5dd72a0652c7f749ab52228cea0f9675047b9cb**. So C-77 is installed. (At 14:31 the first run read 3.0.86 / 1.1.86.) Structural not read; not part of this train.

## MERGE RECORD

1. **#1867** at `a6969702797d1a077a2709139a99d74c0ab499f0`, merge `3c75396c`. Clash: `REGRESSION_LOG.md` only (both sides add an entry at the top). Resolved keep-both by the first run; the log's numstat for the merge is +14 -0, equal to the PR's own +14 -0. Whole merge numstat equals the PR's own diff file by file (12 files, listed below). No conflict markers.
2. **#1858** at `c92db9ad76855ab683c22c0ba8fd573708a82b87`, merge `636d4a4d`. `REGRESSION_LOG.md` +14 -0, equal to the PR's own. Whole merge numstat equals the PR's own diff (7 files). No conflict markers (`git grep` for markers is empty).
3. Dry run today with `git merge-tree`: the two heads against each other clash only in `REGRESSION_LOG.md` (both add at the top); each against the C-77 tip merges clean apart from the log; `UserSettings.cs` auto-merges (both add at different places).
4. Blank line before headings: headings with no blank line before them are 209 on the base and 209 on the merged head (equal). Top of the log now reads: BUG-857, then BUG-1227 Part A, then the C-77 entries.
5. Per-file numstat of the merges (same as PR's own): Bug1227PitCopyKeepsPipeEndsTests +241; Bug285To298C5Tests +1 -1; UserSettings +10 (each PR); CopiedPitEndOwnerGuard +114 (new); LinkService.Cache +1; LinkService.Geometry +43 -17; LinkService.PitRelinks +16 -1; LinkService.RepairAudit.Relink +29 -1; LinkService.State +2; LinkService.Utilities +5; ScopePitClaimEvidence +7; Bug857GradeMismatchBoxTests +146; CdCommand +11 -3; GradeMismatchDialog.xaml +6 -1; GradeMismatchDialog.xaml.cs +28 -8; GradeMismatchChoiceRule +35 (new); REGRESSION_LOG +14 +14.
6. **Total diff against the base: 17 files, +733 -32.** Drainage product files (non-test): `Commands/CdCommand.cs`, `Dialogs/GradeMismatchDialog.xaml`, `Dialogs/GradeMismatchDialog.xaml.cs`, `Models/UserSettings.cs`, `Rules/CopiedPitEndOwnerGuard.cs` (new), `Rules/GradeMismatchChoiceRule.cs` (new), `Services/LinkService.Cache.cs`, `.Geometry.cs`, `.PitRelinks.cs`, `.RepairAudit.Relink.cs`, `.State.cs`, `.Utilities.cs`, `Services/ScopePitClaimEvidence.cs`. This matches the list's numstats.

## SETTINGS FACTS (read from the merged code)

1. Added in `UserSettings.cs` (group `linking`, line ~949): `pitCopyKeepsOriginalPipeEnds` = true, with a doc comment saying it fixes a data fault, not a block (R-27). Added at line ~1684 (group `grade`): `mismatchBoxCloseCancels` = true, doc comment says what OFF does. Both are pure additions; nothing was changed.
2. Switches next to these, read, unchanged: `options.compoundBehaviorEnabled` = `CompoundBehaviorDefaults.Enabled`; `doubleClick.sourceEditWindow` = `SourceEditWindowDefault`; `options.pipeObjectUpgrade` = `PipeObjectUpgradeGate.DefaultMode`; `options.pipeObjectAutomaticIsOnForEveryone` true; `pipeSpeedChecks.useMaterialLimit` false; `sharedValues.pitDropFollowsBox` false; `linking.pasteLineForDrawingWithNoRecord` true; `linking.inspectorPickWaitsAfterUndo` true; `linking.cleanUpGripRotateScaleCopies` false; `linking.reopenedDrawingLoadsItsOwnRecord` true; `detention.orificeUsesRuledGravity` true; `detention.detentionTabUsesCouncilOrificeCo` true. The C61 to C77 switch tests all pass (below), which pin the rest (the 19 `diag.redo` keys, the C-75/C-76/C-77 keys, `surface.slabMinimumFalls`).
3. The new default tests: neither PR added a `C78NewSwitchDefaultsTests`; the finalizer pins them there (list section 5).
4. Manager switches `drainPluginOutbox` OFF and `aboutWindowFitsItsRows` ON: pinned by the Manager tests that pass (C76ManagerSwitchDefaultsTests 11 of 11).

## NEW RULE FILES IN FULL

1. `Rules/GradeMismatchChoiceRule.cs` (35 lines): an enum (UseActual, KeepTyped, Cancel), `IsOn(GradeSettings)` that reads `MismatchBoxCloseCancels ?? true`, `WhenDismissed(bool)` returning Cancel when ON else KeepTyped, and the one command-line line "[CE] Grade mismatch box cancelled - no pipe placed. Run CD again to place it (nothing was changed)." (read in full from the merged branch).
2. `Rules/CopiedPitEndOwnerGuard.cs` (114 lines): headless guard with `IsOn(LinkingSettings)`, `Active`, and `Decide(list of (PitHandle, Touches, WasLinked))` returning which pits are offered to the picker. I saved the full text of the merged file at `C:\ce-asm\logs78\CopiedPitEndOwnerGuard_full.txt` (the file is in git at `3c75396c`). **I did not read this file line by line; I read only its public shape from the PR's log entry and the call sites. The finalizer must read it.** I rewrote nothing.
3. XAML change (`GradeMismatchDialog.xaml`): Esc key binding now runs `EscapeCommand` instead of `KeepTypedCommand`; the Keep button gets a right margin; a new Cancel button bound to `CancelCommand` with `CancelVisibility`. No other XAML changed.

## SCOPE CHECK

1. Shared, Installer, Installer.Tests, Modules/Manager/Installer, Modules/Manager, Modules/Manager.Tests, Modules/Arch.Tests, Modules/Arch.Tests.Structural: all EMPTY.
2. `command-registry.json`, `ce_toolbar_layout.json`, `ce-tool-register.json`, `council-profiles.json`, any PackageContents.xml: none changed. Nothing under `Modules/Drainage/Assets` changed or was added, so the Civil bundle file count stays at the C-77 count (the C-77 finalizer measured 832, not 829) and no pinned count moves. The Manager bundle guard stays 75.
3. No `sign`, `Signing`, `Release` authority or deploy-script file, no `.csproj`, `.props`, `.targets`, `.ps1`, `.slnx` or `.github` file changed. One `.xaml` changed (above).
4. REDO baseline file `RedoSafeReviewedHooks.baseline.txt`: unchanged; `RedoSafeCallGraphTests` 27 total, 25 passed, 2 skipped (net10 and net48 alike).
5. Fingerprint and count pins: no re-pin needed; I made no commit of my own on the branch.
6. Hits of the SCOPE CHECK 9 search over the added product lines (the search matches substrings, so `try` also hits words like "entry"; listed unjudged):
   1. `Dialogs/GradeMismatchDialog.xaml.cs:68` (#1858): `try { DialogResult = choice != GradeMismatchChoice.Cancel; } catch { /* ignore if not shown modally */ }`.
   2. `Services/LinkService.PitRelinks.cs:100-101` (#1867): `try { on = CopiedPitEndOwnerGuard.IsOn(SettingsService.Current?.Linking); } catch { on = true; }` (settings unavailable reads ON).
   3. `Services/LinkService.RepairAudit.Relink.cs:1107` `try` and `:1111` `catch (System.Exception ex)` (#1867).
   4. `Services/LinkService.Geometry.cs` (#1867): lines 231-232, 1027-1037, 1064-1080, 1117-1133, 1223-1228, 1271-1352 matched mostly on the substring "try" (for example in `copyGuard`-carrying signatures, `existingLink...`, "entry") in the new `copyGuard` parameter chain and the held-back picker list; no event subscription, no `StartTransaction`, no system variable, no file write, no `+=`.
   5. Every other listed term (`SetSystemVariable`, `GetSystemVariable`, `SendStringToExecute`, `Regen`, `UpdateScreen`, `LockDocument`, `IsLocked`, `LayerLocked`, `UpgradeOpen`, `Unlock`, `Veto`, `REFEDITNAME`, `File.*`, `Idle`, `CommandWillStart`, `CommandEnded`, `DocumentActivated`, `DocumentToBeDestroyed`, `HttpClient`, `Environment.UserName`, `UserDomainName`, `throw`): NO hit.

## TEST EVIDENCE

1. **Solution build**: first try ended EXIT -1 after 5,141 s (above); rerun `-m:8 --no-restore` 16:00 to 16:05, exit 0, 0 errors, 273 warnings, no file-lock or collision error. The restores were done one by one by the first run at 14:30 (logs in `C:\ce-asm\logs78\restore_*.txt`); the Arch project was restored alone (about 16:09, 3 s, exit 0).
2. **Civil net10 Release full** (16:25 to 16:34, 9 m 25 s test time): 21,528 total, 21,496 passed, 32 skipped, 0 failed. By name on net10: Bug1227PitCopyKeepsPipeEndsTests 14 of 14; Bug857GradeMismatchBoxTests 9 of 9; Bug861RedoFirstClickTests 4; Bug861DiagSwitchesTests 36; Bug861Diag2SwitchesTests 25; Bug1225ReopenedDrawingRecordTests 17; OvernightLabelDoubleClickAndCopyTests 5; PickHandlerProbeTests 7; InspectorPalette (Render 22, ServiceHint 13, Wording 5); RedoSafeCallGraphTests 27 (25 pass, 2 skipped); CivilAutomationTests 28; SettingsWindowV3Tests 34 of 34 (the five `Settings fits ...` cases pass and print tallest tab 670 px on every tab and theme); `NewSettingsKeys_NeedADocumentedDefault` passed; C70 25, C71 6, C72 7, C73 11, C74 11, C75 30, C76 33, C77 60: all green. `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`, `Bug960PaletteThemeTests` (4) and the 300-pipe timing test passed in the full run. The Glen Eira back-tests passed.
3. **Manager net10 full** (16:08, 47 s): 1,085 total, 1,084 passed, 1 skipped, 0 failed. By name: C76ManagerSwitchDefaultsTests 11, Bug090AboutWindowRowsTests 15, TestHygieneAppDataGuardTests 10, CeAdminPluginOutboxDrainTests 19, ManagerSwitchFileTests 49, C69ManagerSwitchDefaultsTests 9, CeRunningVersionTests 2, all passed. TEMP was `C:\ce-asm\t78_mgr10` (backslash form, long names).
4. **Civil net48 focused** (16:10 to 16:23, 773 s): 4,813 total, 4,558 passed, 141 skipped, 114 failed, all `InvalidProgramException`, names identical to the C-77 baseline. Green on net48 by name: Bug1227PitCopyKeepsPipeEndsTests 14, Bug857GradeMismatchBoxTests 9, Bug861RedoFirstClickTests 4, Bug861DiagSwitchesTests 36, Bug861Diag2SwitchesTests 25, Bug1225ReopenedDrawingRecordTests 17, OvernightLabelDoubleClickAndCopyTests 5, PickHandlerProbeTests 7, RedoSafeCallGraphTests 25 (+2 skipped), SettingsWindowV3Tests 34, C60AuditSourcePinGuardTests 39 (3 skipped, includes `NewSettingsKeys_NeedADocumentedDefault`), C61 to C69 3/3/3/3/3/3/3/3/5, C70 25, C71 6, C72 7, C73 11, C74 11, C75 30, C76 33, C77 60. Counts of the older switch tests did not move.
5. **Arch (Civil half)**: 14 of 14 (16:09, 34 s).
6. **Settings files**: CD_Settings.json changed (see caveat 3); the others unchanged; `manager-switches.json` missing before and after. Hashes saved at `C:\ce-asm\logs78\hashes_before.txt` and `hashes_after.txt`.
7. **Free space** 54.2 GB at 16:07, 52.9 GB at 16:35.

## WHAT I DID NOT TEST

1. Nothing was run in AutoCAD. Only a robot or Codex run can show: a pit copied on a pit (ROTATE Copy and SCALE Copy with the base point on the pit) leaving the original's pipes joined (robot N36 with the ROUNDED base point 53777.7,-25569.9 and control C36 with the switch off; plus a copy onto a loose pipe end still joins, and a copy 5 m away changes nothing); the Grade mismatch box showing three buttons, Esc and the X placing no pipe, Enter keeping the typed grade (a window: needs a Codex look).
2. The Installer tests (compiled only), the Structural Arch half (known red 3 of 4), a deploy, the bundle build.
3. #1867 does not repair drawings that already lost pipes.

## RULE 14

1. **(a) Changed files** (against the previous installed commit `f5dd72a0`; also in `C:\CE_PLAN\areas\TRAIN_C78_CHANGED_FILES.txt`, 17 files):
   1. Modules/Drainage.Tests/Commands/Bug857GradeMismatchBoxTests.cs
   2. Modules/Drainage.Tests/Rules/Bug285To298C5Tests.cs
   3. Modules/Drainage.Tests/Services/Bug1227PitCopyKeepsPipeEndsTests.cs
   4. Modules/Drainage/Commands/CdCommand.cs
   5. Modules/Drainage/Dialogs/GradeMismatchDialog.xaml
   6. Modules/Drainage/Dialogs/GradeMismatchDialog.xaml.cs
   7. Modules/Drainage/Models/UserSettings.cs
   8. Modules/Drainage/Rules/CopiedPitEndOwnerGuard.cs
   9. Modules/Drainage/Rules/GradeMismatchChoiceRule.cs
   10. Modules/Drainage/Services/LinkService.Cache.cs
   11. Modules/Drainage/Services/LinkService.Geometry.cs
   12. Modules/Drainage/Services/LinkService.PitRelinks.cs
   13. Modules/Drainage/Services/LinkService.RepairAudit.Relink.cs
   14. Modules/Drainage/Services/LinkService.State.cs
   15. Modules/Drainage/Services/LinkService.Utilities.cs
   16. Modules/Drainage/Services/ScopePitClaimEvidence.cs
   17. REGRESSION_LOG.md
2. **(b) Areas touched:** (1) copying or rotating or scaling a pit, and the pit-to-pipe relink after it (core linking); (2) the New Pipe Grade mismatch box (a window, plus the CD command that opens it).
3. **(c) Shared files touched:** `UserSettings.cs` (two added switches) and `REGRESSION_LOG.md` (two entries). CE_SHARED, the ribbon, the Settings loader, `SettingsService`, the rulebook and the installer are untouched.
4. **(d) Edits or removals of an existing setting, default or saved-data format: NONE.** Both settings are brand-new additive switches, both ON. The only changed existing source lines are code in the link walk (`LinkService.*`, 19 lines removed, replaced by the guarded version), the `CdCommand` mismatch branch (3 lines) and the Escape binding in the dialog. The one existing test line (`Bug285To298C5Tests`) is a source-text pin.
5. **Suggested re-test size:** the pit-copy and relink cases (N36 and C36, plus a plain copy and a plain relink as smoke) and the Grade mismatch box looked at once. Not a full re-test. The class the finalizer states is theirs; by my read the register's expectation of AREA holds for this train (no default, answer, loader or shared path edited).

## SUMMARY

Train C-78 is assembled: branch `claude/rel-20261102a` at `636d4a4d`, on the C-77 version commit `f5dd72a0` (installed). Only two PRs were promoted (#1867 BUG-1227 pit copy, #1858 BUG-857 Grade mismatch box) and both are merged with only the log clashing. Whole solution builds (0 errors, all three frameworks). Civil net10 21,528 tests, 0 failed; Manager 1,085, 0 failed; net48 focused equals the C-77 baseline of 114 reference-only reds; Arch 14 of 14. Shared, Manager and Installer untouched. Nothing run in AutoCAD.
