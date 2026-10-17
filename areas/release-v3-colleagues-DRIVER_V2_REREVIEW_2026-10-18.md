# Opus re-review of the Claude test robot driver v2 FIXES (Sun 18 Oct 2026)

**Answer first.**

1. **`settings-temp set` on Tim's REAL settings files: GO-WITH-CONDITIONS.** The 15 findings of the first review are really fixed in the code (checked line by line, below). Every failure I walked through ends with the backup and the manifest KEPT and a loud line, never with a silent overwrite. What is still missing is a safety net that works when no driver call comes: the driver only repairs things at its NEXT call, and the other things on this PC that start AutoCAD (Codex passes, the old drivers, installs, Tim) never look at the guard. The conditions list in section 3 closes that gap by procedure until the code fixes in HIGH 1 and HIGH 2 land. Without those conditions it is NO-GO.
2. **`click-canvas`: GO-WITH-CONDITIONS (last resort only).** The click now needs the window under the pointer to BE the drawing area found at calibration (or a child of it), checked twice, the second time with the pointer already on the point. A floating CE window, a palette or another program over the point is refused. Conditions in section 3.

Reviewed by reading the code: `acad_driver_witness_v2.ps1` (sha256 D3669ADC2925..., 4259 lines), `acad_driver_witness_v2.allowlist.json` (sha256 A6109A4DA670..., equal to the pin at line 2359), `driver_v2_selftest.ps1`, `DRIVER_TESTER_GUIDE.md` section 9, my first review and the builder's fix report. Only read-only commands were run (hashes, text search, git). I did not run the driver, AutoCAD or accoreconsole, and I did not edit any driver file.

## 0. Checks that came out right

1. **The old drivers are untouched.** `acad_driver.ps1` sha256 C9BA503D463610D0F370... and `acad_driver_witness.ps1` 0B1116C64249BF18759C..., as before.
2. **Nothing is left behind now.** No `settings_guard.json`, `settings_guard.abandoned` or `settings_baseline.json` in the driver folder; the backup folder `C:\ce_rc_scratch\settings_guard` is empty; no lock file; no AutoCAD running.
3. **Tim's 4 real settings files still hash** ACD64E79A33B (CD_Settings.json), 622A246F7D3B (TIM_CE_CADTOOLS CS_Settings.json), 24D8E5F7D87B (CE_STRUC_SUITE CS_Settings.json), EFE307C4FC74 (CE_CVL_SUITE settings.json): the same values as before the fix pass.
4. **The self-test count is real.** `C:\ce_rc_scratch\v2_selftest\results_final.jsonl` holds 339 lines: 338 PASS, 1 NOTE, 0 FAIL.
5. **The allow-list pin matches** and the never-press list is now "contains" patterns (`*Delete*`, `*Remove*`, `*Overwrite*` ...).

## 1. The 15 findings of the first review: fixed or not (read in the code, not taken from the report)

1. **HIGH 1, click-canvas target: FIXED.** `ClassifyPoint` (2715-2733) refuses unless the window under the point is the calibrated drawing area or its child (2731), and checks the drawing area belongs to the same AutoCAD, sits inside its frame and is visible. `ClickAt` (2768-2784) runs that check, puts the pointer on the point, checks again, checks the frame is still in front, then clicks once. `Invoke-V2ClickCanvas` also refuses if the drawing area's window handle changed since calibration (3175). The related part (the click decision used constants) is also fixed: it reads the real command-line lines since the driver's last send (3164-3167) and needs the last finished line to talk about a point or objects (3091-3103). That last rule is loose (LOW 12 below).
2. **HIGH 2a, Tim's own AutoCAD: FIXED.** `set`, `arm` and `snapshot` refuse while any acad.exe runs that the driver did not launch, or more than one (3619-3622, rule at 3369-3375).
3. **HIGH 2b, restore while AutoCAD runs: FIXED.** The file is put back but the entry and backup are kept, marked `restored_while_running` (3472-3475); `quit` restores again only after AutoCAD has ended (4030) and only then deletes the backup (3481).
4. **HIGH 2c, no recovery without quit: FIXED, with one gap.** The restore hook is a `finally` (4227-4244), so Ctrl-C and an unexpected error restore. The hard-timeout watchdog writes `settings_guard.abandoned` before it ends the process (639-651, armed at 4206). Every driver call except `settings-restore` and `help` runs the recovery first (4213, 3500-3511). `lock release` restores first or refuses (1483, 3518-3525). `launch` refuses on an unresolved restore (3898, 3513-3516). **Gap:** all of this needs a later driver call; see HIGH 2.
5. **HIGH 2d, blind overwrite: FIXED.** The guard records the hash it wrote (3656). A file that is neither the original nor that is a conflict: a copy is made, nothing is overwritten, the entry is kept, a `!!!!` line is printed (3387-3398, 3444-3448, 3488). Side effects in MEDIUM 4 and MEDIUM 5.
6. **HIGH 2e, caps blocking the safety verbs: FIXED.** `quit`, `lock`, `status`, `help`, `settings-restore` and `settings-temp status` are never capped (2479-2484, used at 4214). The 60-minute stop does not apply to `settings-restore` or `quit` (they never call `Assert-V2LockHeld`).
7. **HIGH 2f, guard files location: FIXED.** The manifest, the abandoned mark and the baseline live in the script's own folder (50, 3228-3231), whatever `ACAD_DRIVER_HOME` says; v2 write verbs refuse while that variable is set (4212); every restore re-checks each entry's name, folder, links and backup folder (3432-3437).
8. **HIGH 2g, arm and missing files: FIXED.** `arm` records all four watch files, a missing one as `existed = false` (3578-3589, 3280); the restore removes a created file (3458-3460); the Settings gate counts as armed only when all four have an entry (2496-2505).
9. **MEDIUM 3, the lock: FIXED.** Held-by-me check at 1761 (ui press, ui set), 2798, 2937, 3112, 3616, 3715, 3764; esc-prompt through its decision (2836-2838).
10. **MEDIUM 4, Settings gate by title: FIXED.** Any title with "settings" is gated and an unlisted one is refused (2507-2517). The four files are hashed at `lock acquire` / `launch` and compared at `quit` / `lock release` (3528-3575, called at 1478, 3912, 4031, 1485).
11. **MEDIUM 5, hard timeout: FIXED.** `save-copy` and `reopen-copy` default to 120 s (47-49) and their watchdog follows (4178-4180). I saw the "about to click" start line for click-canvas (3195); I did not read the save-copy start line itself.
12. **MEDIUM 6, never list: FIXED.** Contains-patterns in the JSON, and the old whole-word deny list now applies to `ui set` always and to `ui press` except named exceptions, which never excuse a hit on the control id (2396-2411).
13. **LOW 7 (driver-started record): FIXED** in the refusal text (2840) and the guide.
14. **LOW 8 (soft caps): FIXED.** The counter is keyed to the lock's start time (2417-2420).
15. **LOW 9 (audit gaps): FIXED.** One `call_end` line after every v2 call (4246-4248); a failed audit write is reported (2436, 4249).
16. **LOW 10 (60-minute stop): FIXED** (2464-2471).
17. **LOW 11 (wording): FIXED** in guide 9.2.1.
18. **LOW 12 (old CLD copies): FIXED.** Session copy list in state (407-408), checked at 3682 / 3698, filled at launch, open and SaveAs (3950, 4128, 3732).
19. **LOW 13 (screen copy): FIXED.** The screen copy is taken only when this window is on top at four corners and the centre (3043-3053).
20. **LOW 14 (dialog-path): FIXED.** `DRV*`, `_PRE_`, `.bak`, the guard backup folder and linked paths are refused (2921-2927).
21. **LOW 15 (path guard): FIXED.** A junction or link anywhere on a test path is refused (202-203, 208-218); the `*_VERIFY*` rule is C: only (199).

## 2. Failure stories: what the code does at each step

### (a) The driver (pwsh) is killed with taskkill while a setting is changed

1. **Killed between calls:** nothing is running, so nothing is lost. This is story (b).
2. **Killed during `settings-temp set`, before the write (3651):** the backup and the manifest entry already exist (3644, written at 3296); the file is unchanged. The next restore finds the file equal to the original (`already_original`, 3390). Correct.
3. **Killed after the write (3651) but before the manifest records the written hash (3657):** the file holds the test value, the manifest has `written_sha256 = ''`. The next restore sees a file that is neither the original nor a recorded write and calls it a CONFLICT (3397). Safe and loud, but it is a false conflict that teaches the robot to use `-Force`. MEDIUM 6.
4. **Killed during a restore's write (3454):** the file may be half written; the manifest was not yet updated, so the entry and backup survive; the next restore calls it a conflict (or restores it, if it was already restored once while AutoCAD ran). Loud, recoverable with `-Force`.
5. **Killed between deleting the backups (3481) and writing the manifest (3484):** the file is already verified original, but the manifest now points at deleted backups. Every later restore fails with "the backup file is missing" (3437) before it can look at `-Force`, and `launch` is refused for good (3477 marks it unresolved). Safe but wedged; it needs a hand edit. LOW 8.
6. **No `finally` and no abandoned mark** run after taskkill /F (only Ctrl-C, an error and the watchdog leave them). Recovery then waits for the lock to go stale: 90 minutes after the last call (140, 1363), sooner only if `-HolderPid` named a process that has died (1364-1365) or the AutoCAD in the lock has ended (1366-1367).

### (b) The robot job ends (limit hit, crash) without quit while a setting is changed

1. **At that moment:** the real file holds the test value; the driver's AutoCAD is usually still running; the lock is still "held" (not expired, AutoCAD alive). Nothing runs: there is no timer, task or watchdog outside a driver call (the guide says so at 9.3.9).
2. **Next driver call by anyone, while the lock is still held by the same pass:** recovery is skipped on purpose (3381-3383). The result carries "SETTINGS GUARD ACTIVE" (4236-4240), but nothing is put back.
3. **Next driver call after the lock has gone stale:** recovery runs first (3505-3509). With the old AutoCAD still running the file is restored and the backup kept (`restored_kept`). When that AutoCAD is later closed (by a `quit` from the next job, which counts it as owned through the launch record in state.json, 1433) the file is re-hashed and restored again if CE rewrote it on closing (3395).
4. **Durable record:** the manifest, the backups, `v2_audit.jsonl` and `settings_baseline.json` survive. **Loud:** only to whoever runs the driver next. **Automatic net independent of the chat: none.** This is HIGH 2.

### (c) Tim opens his own AutoCAD while a setting is changed

1. **Started from the Start menu or a shortcut (a second acad.exe):** further `set`, `arm` and `snapshot` refuse (3373). `ui press` and `ui set` refuse (1341-1342). The robot's `quit` refuses too, because it needs exactly one acad.exe (3999), so the robot cannot close its own AutoCAD; `lock release` refuses while AutoCAD runs (3521).
2. **What Tim's CE sees:** whatever is in the file when his AutoCAD starts, which during a pass is the TEST value. Nothing in the driver notices his AutoCAD or puts the file back early: the setting stays changed until the robot's pass ends (`quit`, `settings-restore`, or the stale-lock recovery). MEDIUM 3.
3. **If his CE writes the file when he closes AutoCAD:** if the guard's entry is still there marked `restored_while_running`, the next restore copies his file aside and puts the original back WITHOUT a conflict (3395). His genuine changes from that session are then undone, kept only as a `...CHANGED_BY_SOMEONE_ELSE` copy in the scratch folder. If the entry was never restored while running, it is a loud conflict instead. MEDIUM 3.
4. **Double-clicking a drawing in File Explorer while the robot's AutoCAD runs** may open his real drawing INSIDE the robot's AutoCAD (normal AutoCAD behaviour; I have not verified it on this PC). The driver's test-copy checks then refuse to act on it, but he would be working with the test value and a robot attached. Covered by the timing conditions below.
5. **The record exists** (end-of-pass hash comparison 3561-3575, audit lines), but Tim is never told directly.

### (d) CE writes the settings file during the test (BUG-429 pattern: new default rows at the first start after an install)

1. **What the code does:** with `set` before `launch`, CE's added rows make the file neither the original nor what the guard wrote, so the restore at `quit` is a CONFLICT (3397): the file is kept, a copy is made, `launch` is refused until `settings-restore -Force` (3513-3516).
2. **Is restoring the original bytes correct? Yes.** Tim's rule (desk handoff, 18 Oct) is "a testing agent can change settings as long as it places it back to the original setting after testing". The exact original is what the hash proves. BUG-429 rows are defaults that CE adds again at its next start, so putting the old bytes back is harmless. A merge would leave a file that is not the original and cannot be proven by hash: do not merge.
3. **Where it goes wrong:** `-Force` cannot tell CE's own harmless write from a change Tim made himself. If the robot learns to use `-Force` on every conflict, the conflict protection is gone. MEDIUM 4.
4. **Evidence on this PC:** the builder's live stages launched AutoCAD with CE loaded several times and the four real files hashed the same at the start and the end, so the installed versions did not rewrite unchanged files on start or close. An install during a pass would, which is why installs are a condition below.

### (e) Two robot jobs in a row

1. **Job 1 ended with `quit`:** everything is restored and verified, the manifest and the baseline are deleted, the lock is released (4030-4032). Job 2 starts clean. Correct.
2. **Job 1 ended without `quit`, job 2 uses the same name and starts within 90 minutes:** the lock is still "held" by "Claude" with the same start time, so job 2's `lock acquire` just refreshes it (1396) and job 2 IS job 1's pass for the driver: no recovery, job 1's 60-minute clock still runs, job 2 sees the guard warning. Job 2's `launch` refuses (AutoCAD already running, 3900). If job 2 runs `quit`, everything is restored. Safe, but job 2 may hit the 60-minute stop at once.
3. **Job 1 ended without `quit`, the lock went stale, job 2 takes over:** job 2's first call recovers (restored while job 1's AutoCAD runs, backups kept). **If job 2 then runs `settings-temp set` before that old entry is cleared,** the manifest still names job 1's pass as its owner (set only when a manifest is created, 3304). From then on, the start of EVERY job 2 call decides that "the pass that made these backups is over" (3381-3384) and puts the original back. Job 2's own test value is silently undone before each command, so job 2 tests the wrong setting and may report a false PASS or FAIL. Safe for Tim's file, harmful for the evidence. MEDIUM 5.

## 3. Is it safe to use `settings-temp set` on Tim's real files now? Yes, under ALL of these conditions

1. **Free window and Tim away.** Only while Tim is away (until 29 Oct) and only in the free windows of RULES 1.8 (after 5:30 pm, before 8:30 am, weekends, 2:00 to 3:00 pm Melbourne time). Stop all `settings-temp` passes by the evening of Wed 28 Oct, or at once if Tim is seen using the PC.
2. **No other AutoCAD user during the pass.** No Codex AutoCAD pass, no old driver (`acad_driver.ps1`, `acad_driver_witness.ps1`), no install or deploy, and no Codex runner job may start while `settings-temp status` shows any entry. The desk checks `settings-temp status` shows 0 entries before starting any of those.
3. **The lock carries the job's life.** The job launcher passes the robot's own claude process id (for example in an environment variable). The robot runs `lock acquire "Claude-<job>" -HolderPid <that id> -TimeoutSec 0`, and repeats `-HolderPid` on any later `lock acquire` (a refresh without it drops the link, 1396). Then the lock goes stale the moment the job dies, and the next call recovers at once instead of after 90 minutes.
4. **A unique name per job** (`Claude-<job id>`), never the bare "Claude", so a second job can never silently continue the first job's pass.
5. **A desk safety net.** On every desk tick, the desk runs `D2 settings-temp status -Text` (it is never capped, and it runs the recovery first). It reports any entry, `unresolved`, `restored_kept_until_autocad_ends` or `abandoned_mark` loudly, and writes them to the area file the same tick.
6. **The pass shape.** Clean start (`settings-temp status` shows 0 entries, `Get-Process acad` empty, the four hashes recorded) → `lock acquire` → `settings-temp set ...` → `launch` → test → `quit` → `settings-temp status` shows 0 entries → read the four real files' hashes and compare with the start. One setting change per pass where possible; keep the pass under 60 minutes; never leave a pass open between jobs.
7. **Never `-Force` by the robot alone.** On any CONFLICT the robot stops and reports the conflict, the paths, and a key-by-key comparison of the `...CHANGED_BY_SOMEONE_ELSE` copy against the backup (a read-only JSON comparison). The desk may approve `settings-restore -Force` only when (a) no other acad.exe was seen during the pass and (b) the only differences are the robot's own keys plus keys that are new in the file (none removed, no existing value changed). Anything else waits for Tim.
8. **Only the four allow-listed files and only plain values.** No `arm` and no Settings window pressing yet (the Settings window itself has never been opened by the driver). `settings-temp set` only.
9. **Report every pass** with the `settings_files_pass_start` / `settings_files_pass_end` lines and any `!!!!` or `>>>>` line, copied verbatim.
10. **Never `-RestoreOnExit` as the main restore.** It restores after every call, which would undo the test value before the next command. Use it only on the last call of a pass, as a belt-and-braces with `quit`.

**What remains unsafe even with these conditions:**

1. A job that dies leaves the test value in the real file until the next desk tick or driver call (minutes, not hours, with conditions 3 and 5).
2. If Tim does start his own AutoCAD during a pass, his CE runs with the test value and nothing tells him (MEDIUM 3).
3. Codex, the old drivers and installs are kept away only by procedure (HIGH 1).
4. The Settings window, `arm`, `quit -Kill` with a live guard, a real taskkill and a real hard timeout with a hung AutoCAD are still unproven in AutoCAD.

**click-canvas conditions:**

1. Last resort only: use `answer "x,y"` whenever a typed point would do.
2. Only after a `type` that leaves a command waiting for a point or selection, on a test copy, in the driver's own AutoCAD.
3. Calibrate right before (plan view, Model tab) and click within 5 minutes; never after a zoom or pan.
4. In the free windows only: the real mouse pointer moves, so nobody may be using the PC (including remotely).
5. Read the command line and LASTPOINT after every click; object snap may move the point.

## 4. Findings

### HIGH

1. **HIGH 1: the guard's safety net exists only inside the v2 driver.**
   1. **Where:** the recovery runs at 4213 of the v2 driver only. Codex AutoCAD passes, `acad_driver.ps1`, `acad_driver_witness.ps1`, the release chat's install route, and Tim's own AutoCAD never read `settings_guard.json`.
   2. **Why it matters:** after a dead robot job, a Codex pass or an install can start AutoCAD on the test value. Codex's evidence is then taken on the wrong setting, and an install's first start (BUG-429) rewrites the file, turning the restore into a conflict.
   3. **Fix:** a pre-flight in the Codex runner briefs and in the install route that runs `D2 settings-temp status` (which also recovers) and refuses to start if any entry remains. Editing existing runner briefs is not a new script, but follow the no-new-scripts rule. Until then: conditions 2 and 5.
2. **HIGH 2: no automatic net when no driver call comes, and the recovery waits for a stale lock.**
   1. **Where:** recovery only at a driver call (4213) and only when the lock is no longer held by the same pass (3381-3383). A lock stays held for 90 minutes after the last call (140, 1363) unless `-HolderPid` was given (1364-1365) or the AutoCAD in the lock has ended.
   2. **Fix:** (a) `settings-temp set`, `arm` and `snapshot` refuse unless the lock names a live holder process (`-HolderPid` given and alive), so a dead job makes the lock stale at once; (b) a lock refresh through `lock acquire` keeps the old holder pid when none is given (1396); (c) the desk tick of condition 5. A scheduled Windows task would be the real watchdog, but it is standing configuration on Tim's PC and needs his explicit yes (put it on his question list for 29 Oct).

### MEDIUM

3. **MEDIUM 3: a foreign AutoCAD that appears mid-pass is not acted on, and Tim's own later changes can be undone quietly.**
   1. **Where:** a second acad.exe only blocks new writes (3373); nothing puts the file back early or marks the entry. Later, an entry marked `restored_while_running` is restored over any change without a conflict (3395).
   2. **Fix:** at the start of every call (and in `settings-temp status`), if the manifest has entries and an acad.exe runs that the driver did not launch: restore now (kept while running), mark every entry `foreign_acad_seen`, print `!!!!`, and refuse further write verbs. In `Get-V2EntryRestorePlan`, an entry with `foreign_acad_seen` never takes the silent `restore_aside` route: it is a conflict for the desk or Tim.
4. **MEDIUM 4: a harmless CE write is a conflict every time, which trains `-Force`.**
   1. **Where:** `Get-V2EntryRestorePlan` (3387-3397) has no case for "only CE's own new default rows".
   2. **Fix:** when the current file differs from the original only by the guard's own keys plus keys that did not exist in the original (use `Get-V2JsonDiff`, 3344-3350, and check none was removed or changed), and no foreign AutoCAD was seen, take `restore_aside` automatically with the note "CE added default rows". Everything else stays a conflict.
5. **MEDIUM 5: a new pass that inherits an old manifest has its own test value undone at the start of each call.**
   1. **Where:** the owner (`owner_who`, `owner_since`) is set only when the manifest is created (3304); `Get-V2RecoveryDecision` (3377-3385) then sees "a pass that is over" on every call of the new pass and restores (3507).
   2. **Fix:** `settings-temp set`, `arm` and `snapshot` refuse while the manifest's owner is a different pass ("finish the earlier pass first: quit, then settings-temp status"). Or, after a recovery that leaves every entry at the original, hand the manifest to the current pass.
6. **MEDIUM 6: a kill between the write and the manifest update gives a false conflict.**
   1. **Where:** the file is written at 3651; the hash of what was written is recorded only at 3655-3657.
   2. **Fix:** compute the SHA-256 of the new text before writing, save it in the manifest as `pending_sha256`, then write; the restore plan treats a file equal to `pending_sha256` like `written_sha256`.

### LOW

7. **LOW 7: `quit` releases the lock even when its restore failed** (4030-4032; `Invoke-LockReleaseAfterQuit` does not check), unlike `lock release` (3518-3525). It stays loud (every later call retries), but the "lock is kept" promise is broken. Fix: skip the release when `settings_restore_failed` is set.
8. **LOW 8: backups are deleted before the manifest is rewritten** (3481 before 3484). A kill in between wedges the guard: "backup file is missing" for ever, `-Force` cannot help, `launch` refused. Fix: write the manifest first, then delete the backups.
9. **LOW 9: the writes are not atomic** (3651 for `set`, 3454 for the restore) while the driver's AutoCAD may read the file; CE could read half a file. Fix: write a temporary file in the same folder, then `File.Replace`.
10. **LOW 10: every failed restore makes another `...CHANGED_BY_SOMEONE_ELSE` copy** (3400-3409, 3445), and the recovery retries at every call, so copies pile up. Small files, harmless. Fix: skip the copy when one with the same hash exists.
11. **LOW 11: `status`, `lock status` and `settings-temp status` are no longer read-only.** They can write Tim's real files through the recovery (4213). This is intended, and it is the safety net of condition 5, but the guide should say so plainly in 9.0.
12. **LOW 12: the click "point prompt" test is loose.** `Test-V2PointPrompt` (2489-2493) accepts any line with "select", "objects", "specify", "point" and similar words, and with COM busy the click goes ahead. The drawing-area check still keeps the click on the test copy's drawing area, so the worst case is a stray selection click. Fix: require the line to start with a prompt shape such as "Specify ..." or "Select objects" and end in a colon followed by the answer.

### Regressions in verbs that were fine

1. **None found that break an old verb.** The new link check in `Test-AllowedPath` (202-203) applies to every old verb; no test folder is a link today, and the live stages ran through it.
2. **The changed meaning of the status verbs** (LOW 11) is the only behaviour change to a verb that used to be read-only.

## 5. What I did not do

1. I did not run the driver, AutoCAD or accoreconsole, and I did not edit any driver file.
2. Every failure story above comes from reading the code; none was reproduced.
3. I did not verify that a File Explorer double-click opens a drawing inside an AutoCAD that is already running on this PC (story c, step 4).
4. I did not read the Codex runner briefs (a search of the runner folder timed out); HIGH 1 rests on the old drivers having no guard code, and on the runner scripts not mentioning the driver or the lock.

**Built, tested, installed, accepted:** the fixes are built and self-tested by the builder (338 PASS); re-reviewed here by reading; not installed anywhere (it is a tool); not Tim-accepted.
