# Opus review of the Claude test robot driver v2 (Sun 18 Oct 2026)

**Answer first: GO-WITH-FIXES.** Real robot passes may start now with most v2 verbs, but **two verbs stay off until fixed: `click-canvas` (the real mouse click) and the settings guard's write side (`settings-temp set / arm / snapshot`, and any press or set in a Settings window).** Both are HIGH findings below. Everything else is MEDIUM or LOW and can be fixed in the next driver edit.

Reviewed by reading the code line by line: `acad_driver_witness_v2.ps1` (sha 4320F68A4489, 3852 lines; the v2 block is lines 2320 to 3437 plus small edits at 45, 137-138, 1029-1030, 1729, 1760, 1779, 1796-1797, 3450-3459, 3522-3524, 3661, 3804-3842), the allow-list JSON (sha FD13DBA3932D, equal to the pin at line 2327), `driver_v2_selftest.ps1`, `DRIVER_TESTER_GUIDE.md` section 9 and the builder's report. I ran only read-only commands. I did not run the driver, AutoCAD or accoreconsole.

## What may be used meanwhile (until HIGH 1 and HIGH 2 are fixed)

1. **Usable now:** every old verb as reviewed before, plus `ui press`, `ui set` (not in a Settings window), `pick-first`, `esc-prompt`, `dialog-path`, `shot`, `save-copy`, `reopen-copy`, `settings-temp status`, `settings-restore`.
2. **Conditions the brief must state, because the driver does not enforce them yet:** take the lock first (MEDIUM 3); give `reopen-copy` and `save-copy` `-TimeoutSec 120` so the hard timeout does not cut them off (MEDIUM 5); read the four settings-file hashes at the start and end of every pass and report any change (MEDIUM 4).
3. **Not usable:** `click-canvas "x,y"` (calibrate alone is harmless but pointless). Give points with `answer "x,y"` instead. `settings-temp set`, `settings-temp arm`, `settings-temp snapshot`, and `ui press` / `ui set` / `ui click` / `ui type` in any Settings window.

## Checks I made that came out right

1. **The old driver is untouched.** `acad_driver.ps1` sha C9BA503D463610D0... (last written 3 Oct). `acad_driver_witness.ps1` sha 0B1116C6..., as the report says.
2. **Nothing was left behind.** The four real settings files still hash ACD64E79A33B, 622A246F7D3B, 24D8E5F7D87B and EFE307C4FC74, the values in the report. No `settings_guard.json` manifest is left. No AutoCAD is running. `v2_audit.jsonl` has 132 lines, as reported.
3. **The self-test numbers are real.** `C:\ce_rc_scratch\v2_selftest\results.jsonl` holds 178 lines: 177 PASS, 1 NOTE, 0 FAIL. 98 of the 177 are offline function checks (stage 0). 79 ran in AutoCAD.
4. **The allow-list pin really is checked.** The JSON path is fixed to the script's own folder (line 2325), not the `ACAD_DRIVER_HOME` folder. The hash is checked on first use in every call (2335-2347). No parameter or environment variable switches it off: `$script:V2AllowListTestOverride` can only be set by dot-sourcing the script. A failed check refuses the call.
5. **The press-time drawing check is real.** `ui press` and `ui set` run `Assert-UiWrite` (one acad.exe, the one this driver launched or the lock names, active drawing is a test copy) just before the Invoke (2512-2513, 2559-2560), not only at launch.
6. **save-copy and reopen-copy guard by file name.** Only `CLD*` names pass. `DRV*`, `*_PRE_*`, `.bak` and `.dwt` are refused (allow-list lines 100-101, 3322-3333). SaveAs refuses an existing target (3369). Both verbs need an idle, owned AutoCAD and a writable test copy. Neither can save over DRV1_B1 or DRV2_S1.
7. **The settings restore is careful.** The backup's hash is checked on write (3135-3136) and again before any byte goes back (3197-3199). The file's hash is checked after the restore (3206-3207). A failed restore keeps the backup and the manifest and prints a loud `!!!!` line (3215-3224). Paths with `..`, wildcards, a link on the path, a wrong file name or folder, or a file over 4 MB are refused (3097-3118).
8. **Defender and secrets are clean.** There is no inline `pwsh -Command`, no `Reflection.Assembly LoadFrom`, no network call and no key or token anywhere in the three files. The self-test calls the driver with `-File`. The run-time `Add-Type` C# block (mouse, foreground and PrintWindow calls, 2596-2685) lives inside the `.ps1` file, which is acceptable. If Defender ever flags it, follow the false-positive steps in the root CLAUDE.md.

## Findings

### HIGH

1. **HIGH 1: `click-canvas` can click any AutoCAD-process window that floats over the drawing area, including windows the allow-list forbids.**
   1. **Where:** `AcadV2Native.ClickAt` (lines 2661-2680) only checks that the window under the pointer belongs to acad.exe (`up != pid`). `Invoke-V2ClickCanvas` (3040-3049) only checks that the point is inside the calibrated drawing-area rectangle. Neither checks that the window under the pointer IS the drawing area.
   2. **Why it matters:** floating palettes and modeless CE windows are acad.exe windows, and none of them disables the AutoCAD frame. That covers CE Inspector, CE Assistant (its Send / Ask AI buttons are read-only for `ui`), Command search, a floating Pit Schedule, the CE Suite Manager windows (Roll Back Approved Release) and a modeless Settings window. If one of them sits over the target point, the real click lands on its button. That skips the never list, the read-only list and the Settings gate. A Manager or Settings button acts outside the test copy: on the release channel or on Tim's real settings files. The report's own guard description ("window under the pointer belongs to AutoCAD") is exactly this weak check. Nothing in the self-test covers it.
   3. **Fix:** in `ClickAt`, refuse unless `WindowFromPoint(pt)` equals the calibrated drawing-area handle (`cal.canvas_hwnd`), or is a child of it (`IsChild(canvas, under)`). Also refuse if `Find-V2Canvas` now returns a different handle from `cal.canvas_hwnd` (today only left and top are compared, 3041). Add a live self-test: float a CE window (Command search) over the drawing area, click-canvas a point under it, and expect a refusal.
   4. **Related (folded in from LOW):** `Get-V2ClickDecision` passes `LinesSinceStarter = 1` and `LastLineIsIdle = $false` as constants (2969). So a click is allowed whenever COM is "busy", even when no command is waiting for a point. The Pit review hang in the report is such a state. A click queued then lands later at an idle `Command:` as a selection. Use the same command-line evidence `esc-prompt` reads, and require the last line to be a point or selection prompt.

2. **HIGH 2: the settings guard changes Tim's REAL settings files, but nothing guarantees they are put back, or that Tim's own changes survive.**
   1. **No AutoCAD check before writing.** `Invoke-V2SettingsTemp` (3247-3313) checks only the lock. It never runs `Test-OwnedAcad`. `settings-temp set` and `arm` therefore work while Tim's own AutoCAD (not launched by the driver) is open. His live CE session can then pick up the test value and draw real work with it. Fix: refuse `set`, `arm` and `snapshot` unless no acad.exe is running, or exactly one is running and it is the owned one.
   2. **A restore while AutoCAD runs throws the safety net away.** On success, `Invoke-V2SettingsRestoreAll` deletes the backups and the manifest (3218-3221) whether or not AutoCAD is still running. If CE writes its settings again when AutoCAD closes, the test value comes back and nothing notices. The note at 3242 says "restore again after AutoCAD has closed", but by then there is nothing left to restore from. The same happens with `-RestoreOnExit` on any mid-session call. Fix: while acad.exe runs, restore but KEEP the backups and the manifest, marked `restored_while_running`. Let `quit` check the hashes again after AutoCAD has ended, restore again if needed, and only then delete them.
   3. **No recovery if the session ends without `quit`.** The hard-timeout watchdog ends the process with `Environment.Exit(2)` (line 619). The `-RestoreOnExit` block (3831-3842) is not in a `finally`, so a Ctrl-C or a watchdog exit skips it. A chat that simply ends skips it too. After any of these, `lock release`, `launch` and `status` neither restore nor refuse. Tim's next own AutoCAD session would then run on the test values without a word. Fix: `launch` and `lock release` refuse while the manifest has entries (or restore first, if no AutoCAD is running). Make `status` show the warning in its plain-English output. Move the restore hook into a `finally`.
   4. **The restore overwrites without looking.** `Invoke-V2SettingsRestoreAll` never compares the current file with what the guard wrote. A change Tim (or an unrelated CE save) made in between is overwritten, and the result reads "restored; SHA-256 equals the original". Fix: record the hash after each `set`. At restore time, if the current hash is neither that value nor the original, copy the current file aside next to the backup and report it LOUDLY before restoring.
   5. **The restore can be capped away.** `settings-restore` has a verb cap of 12 (line 2331). The cap check at 3827 applies to every verb, but the comments at 3804 and 3828 say settings-restore "always works". A restore that keeps failing on a locked file is therefore itself refused from the 13th try on. Fix: exempt `settings-restore` and `quit` from the verb cap.
   6. **The manifest can be hidden.** `settings_guard.json` lives under `$script:DriverRoot`, which `ACAD_DRIVER_HOME` moves (lines 173, 3075). A call with that variable set writes Tim's real file but keeps its manifest somewhere a normal call never looks. Fix: fixed manifest path (`$PSScriptRoot`). On restore, re-check every manifest entry with `Resolve-V2SettingsFile`, and check that its backup sits under `backup_root`.
   7. **arm misses missing files.** `arm` records only watch files that exist (3268). A file the Settings window creates is never removed. Fix: record missing watch files as `existed = false`, which `Add-V2GuardBackup` already supports.

### MEDIUM

3. **MEDIUM 3: the lock is not required for `ui press`, `ui set`, `pick-first`, `dialog-path`, `save-copy` and `reopen-copy`.** `Assert-LockOk` lets a call through when NO lock exists (line 1427). The comment at 2013 says other sub-commands only refuse when somebody ELSE holds the lock. The report and section 9.2 of the guide say the lock is needed. Only `esc-prompt`, `click-canvas` and `settings-temp` really demand it (2731-2733, 2985, 3261). Fix: use the same held-by-me test (`Get-V2LockInfo`) at the top of every v2 verb that changes something, and add a self-test call without the lock for each.

4. **MEDIUM 4: the Settings-window gate depends on the window title and may miss.**
   1. **Where:** `Assert-V2SettingsGate` (2432-2440). It acts only when the title contains "Settings", and then uses the FIRST matching allow-list entry. A title such as "Pit Schedule settings" matches `*Pit Schedule*` first and passes ungated, with Apply allowed. A Settings-titled window that has no v2 entry at all returns early, so the old `ui click` / `ui type` route (old allow patterns `Drawing sheets*`, `Foundations manager*`, `Creative Engineering*`) is ungated.
   2. **Also:** any CE window may save remembered choices into the four files without "Settings" in its title.
   3. **Fix:** gate if ANY matching entry has `requires_settings_guard`. Refuse a Settings-titled window that has no entry. Most useful of all: `launch` records the SHA-256 of the four watch files automatically, and `quit` compares them after AutoCAD ends and reports loudly any change made outside the guard. That turns the builder's manual end-of-run hash check into a built-in one.

5. **MEDIUM 5: the hard timeout cuts the long verbs off.** The watchdog for every v2 verb is `TimeoutSec + 15` = 30 s by default (line 3816). `reopen-copy` can legitimately wait 60 s for the drawing and then 30 s more for idle (3416, 3423). `save-copy` waits 1.2 s plus up to 20 s. A cut-off call leaves no result line in the audit log, no drawing record and no cleared start record, and skips `-RestoreOnExit`. Fix: per-verb watchdog times (reopen-copy 150 s, save-copy 90 s), and an audit "start" line written before acting. Until then, pass `-TimeoutSec 120` on these two verbs.

6. **MEDIUM 6: the never list is weaker than the old deny list it partly replaces.** `Test-V2ButtonAllowed` (2362-2372) checks only the JSON never list, as prefix patterns (`Delete*`, `Remove*`, `Overwrite*`). The old whole-word deny list (`$script:UiControlDenyWords`, line 113) is not applied to `ui press` or `ui set` at all. Eight windows allow `set: ["*"]` (toggle buttons, radio buttons, any value), and some press names are wildcards (`Choose DWG*`). So a toggle or radio named "Confirm delete", "Yes, overwrite" or "Pit remove" would pass. Fix: write the never patterns as `*Delete*`, `*Remove*`, `*Overwrite*` and so on, or run `Test-UiControlDenied` for `ui set` always, and for `ui press` with only the named per-window exceptions (Update, Continue placement, Save pit and close).

### LOW

7. **LOW 7: "a command the driver started" is a weak record.** `v2_state.json` is written by ANY typed text (3525) and kept across `ui press` (2403-2408). `pick-first` writes nothing, despite the message at 2735. The tester can edit the file (the builder did once). The real boundary is `Test-OwnedAcad` (the AutoCAD the driver launched), which is sound. Fix: say so in the guide rather than claim ownership of the command.

8. **LOW 8: the caps are soft.** `restore` (or anything that ends the driver session) gives a new session id, which resets `calls_v2.json` (2379, 3846). `ACAD_DRIVER_HOME` moves the counter, the lock file (1323), `state.json` and the start record. Fix: refuse v2 verbs when `ACAD_DRIVER_HOME` is set outside the offline self-test, and key the counter to the lock's `since` time.

9. **LOW 9: not every refusal reaches the audit log.** These refusals are counted but never written to `v2_audit.jsonl`:
   1. the lock refusal in `Invoke-Sub` (3441);
   2. the cap refusals (3827-3828);
   3. argument refusals raised before each function's `try`, at lines 2478, 2542-2543, 2748, 2885-2886, 2981, 3237 and 3397;
   4. the `ui` refusals before dispatch (1729).

   `settings-temp status` is never logged. `Write-V2Audit` swallows its own errors (2395). Fix: one audit write in `Invoke-Main` after every v2 call (ok / refused / failed), keeping the detailed lines as they are.

10. **LOW 10: there is no 60-minute stop in the driver.** A search of the driver folder found no session time limit. The only clock is the lock, which expires after 90 minutes without a call (line 136). If the desk wants a hard 60-minute stop, add a refusal of v2 write verbs when the lock's `since` is more than 3600 s old. `quit`, `lock` and `settings-restore` would still work.

11. **LOW 11: the report overstates what a changed allow-list stops.** It says "every v2 verb refuses". In fact `esc-prompt`, `click-canvas`, `pick-first`, `shot` and `settings-restore` never read the list. That is correct for them (restore must keep working), but correct the wording.

12. **LOW 12: save-copy accepts every old `CLD*` copy.** It accepts any `CLD*` in the test folders, including the hundred-plus older CLD copies in `C:\ce_rc_drv` from earlier runs (evidence). Fix: save only the copy this session launched or opened (record it in state at launch and open, and check it in `Get-V2SaveCopyProblem`).

13. **LOW 13: the `shot` screen fallback can capture another program.** The `CopyFromScreen` fallback (2928-2933) takes whatever covers the window, which could be Tim's email or a client document, and `BringToFront` takes the keyboard focus. The file stays in the local test folder. Fix: for a named CE window, use the fallback only if the window under the four corners and the centre is that window.

14. **LOW 14: dialog-path accepts pristine fixtures and guard backups.** It types a pristine fixture path (`DRV*`) or a settings backup (`C:\ce_rc_scratch` is a dialog root and `.json` is allowed) into any Windows Open dialog. That is harmless for a read-type dialog such as X-Civil Choose DWG. Fix: refuse `DRV*` names and the `settings_guard` folder.

15. **LOW 15: the path guard (inherited, already reviewed once) has two gaps.** `Test-AllowedPath` (178-196) does not resolve junctions or links. Rule 3 (`*_VERIFY*` folders) accepts any drive letter, including a mapped network drive. I checked: no `C:\ce_rc_*` or `_TEST_COPIES*` folder is a junction today. Short 8.3 names, UNC, `\\?\`, `..`, relative paths and case are handled: they normalise or refuse. Fix: walk the path for reparse points, as `Resolve-V2SettingsFile` already does, and limit rule 3 to C:.

## The self-test: what it proves and which refusals it never tried

1. **Proven in AutoCAD:** 9 live refusals:
   1. More... and Export CSV refused;
   2. SaveAs over an existing file;
   3. a name that is not CLD;
   4. reopen with unsaved changes;
   5. save-copy and reopen-copy on DRV2_S1;
   6. click-canvas while idle;
   7. esc-prompt while idle.

   The happy paths of every verb were also driven.
2. **Proven offline only:** the allow-list pin, the window and button lists, the esc-prompt and click-canvas decision tables, the dialog-path and save-copy name rules, the settings gate, the JSON edit, and the damaged-backup drill (on a scratch file).
3. **Untested refusal paths:**
   1. **click-canvas:** another window under the point (HIGH 1); not in front; lost the front; calibration too old; another drawing; drawing area moved; point outside the area; an AutoCAD the driver does not own.
   2. **ui press / ui set:** active drawing not a test copy; a window not on the list; a Manager window; a never-list toggle through `ui set`; a password field; the Settings gate live, on all four routes (press, set, old click, old type).
   3. **dialog-path:** a Save dialog (default button Save); a never-touch title; two dialogs open; no dialog open.
   4. **esc-prompt:** a dialog open (bit 8); main window disabled; an AutoCAD the driver does not own.
   5. **save-copy:** a read-only drawing (DRV2_S1 was refused by its name first, so the read-only check itself never fired); AutoCAD busy.
   6. **reopen-copy:** `-Force`.
   7. **settings-temp:** no lock; `..`; a link on the path; a missing file; a file over 4 MB; `arm` from the command line; a restore onto a locked file; a restore by `quit -Kill`; `-RestoreOnExit` after a refused call; a watchdog exit while armed.
   8. **caps:** the total cap (`ACAD_DRIVER_CALL_CAP`).
4. **Verdict on the evidence:** credible for the happy paths and the name rules. It is not yet evidence that the riskiest refusals work: the click target, the settings guard against a live AutoCAD, and the lock. The fixes above should each come with a live refusal test.

## What I did not do

I did not run the driver, AutoCAD or accoreconsole, and I did not edit the driver or the allow-list. Every finding comes from reading the code; none has been reproduced in AutoCAD.
