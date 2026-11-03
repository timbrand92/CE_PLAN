# BUGFIX w888 (B-202) — BUG-888 installer interruption and uninstall — 4 Nov 2026

**Result: STOPPED. No PR opened. No code changed. Nothing built or tested.**

## FOR TIM

1. **The fault is real.** If the installer is killed at the wrong instant during a Manager or Civil update, the old CE folder has already been moved aside (named `...bundle.retiring-<stamp>`) and the new one is not yet in place. AutoCAD then starts with no CE at all. Nothing puts it back by itself on the next start.
2. **Why I stopped:** the fix is not one small change. It needs three things, and one of them is your call.
3. **Your call (one question):** should CE put the old folder back automatically the next time the installer or Manager runs (my recommendation), or only through a command a colleague types, "CE restore"? Automatic is safer for a colleague who does not know the folder names. Example: a colleague's PC loses power mid-update. With automatic recovery CE is back after the next launch. With a command, they ring you first.
4. **The Settings switch problem.** The installer is a separate program and has no way to read CE's Settings. A "ships ON, OFF restores old behaviour" switch needs a new small settings file the installer reads, or a switch in Manager. That is a design choice, not a quick edit.
5. **A complete pair.** The recovery must restore Manager and Civil together, otherwise you get two different CE_SHARED copies (the BUG-887 situation). That means a pair check, which is more than moving one folder back.
6. **Mistakes of my own:** none. I did not build, test or deploy anything.
7. **Not proven:** that a kill at that instant really leaves AutoCAD without CE. The Opus check in the carpark says it is recoverable by hand; I confirmed it by reading the code only.

## TECHNICAL

1. **Base:** origin/claude/rel-20261102a. The carpark path `Installer/SafeBundleInstaller.cs` is at the repo root, not under Modules/Drainage.
2. **Fault confirmed** in `Installer/SafeBundleInstaller.cs`: `Directory.Move(expectedTarget, retiring)` (about line 334), then the fault point `AfterLiveRetirement`, then `Directory.Move(incoming, expectedTarget)` (about line 340). The `catch` block at about line 351 restores `retiring` only while the process is alive. A hard kill between the two moves leaves `expectedTarget` absent and `<target>.retiring-<operationId>` on disk. No start-up scan exists for these folders: the only `.retiring-` uses are the cleanup in `DeleteGeneratedDirectory` and the failure handler. The roll-back copy is made earlier (about lines 314-318) in `rollbackRoot`, so a verified copy of the old bundle exists too.
3. **Documented uninstall:** a search of `*.md` outside REGRESSION_LOG and docs/design found none. `docs/CLEAN_SLATE_REBUILD.md:957` only plans "Keep settings or Remove everything".
4. **Why no small change:**
   1. A recovery step (target missing and exactly one `.retiring-*` sibling means move it back) is small in itself.
   2. It also needs an entry point: an installer command or Manager start-up call, and for the pair, both bundles checked together.
   3. The Settings switch rule cannot be met inside the installer. It has no reference to UserSettings (grep found none).
   4. An uninstall document needs Tim's wording on whether settings are kept.
5. **Suggested split when Tim answers:** (a) installer: `RecoverInterruptedInstall` run at the start of every install and from Manager start-up, with an Installer.Tests case that simulates the kill via the existing fault point (kill after `AfterLiveRetirement`, assert target restored and no `.retiring-` left); (b) a switch in the Manager's settings file, default on; (c) docs page "Uninstall and restore CE".
6. **Robot case (proposed, not built):** `bug888_retiring_recover`. Types nothing in AutoCAD. Rename the live Civil bundle folder to `*.retiring-test` on a copy, start AutoCAD, check the CE log line "recovered interrupted install" and that the folder name is back. Switch-off control: same rename with the switch off, the log line is absent and the folder stays renamed.
7. **Isolation listings:** not taken. No test or build ran, and no AutoCAD, Codex or accoreconsole was started. No worktree or scratch folder was created, so there was nothing to clean (C: free about 58 GB before and after).
8. **Files touched:** this report only. BUG_CARPARK.md and DESK_LOG.md untouched.
