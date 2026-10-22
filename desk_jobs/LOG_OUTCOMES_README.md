# CE log outcome watcher (desk tool, built 21 Oct 2026)

1. **Structural and Manager outcome lines (23 Oct build):** reads `TIM_CE_CADTOOLS\logs\ce_struc_structured_*.log` and `CE_SUITE_MANAGER\logs\ce_manager_structured_*.log` at INFO level, using Civil's exact `Command outcome: <CMD> completed|cancelled|refused|failed N ms` format. The existing `Options.CommandOutcomeLines` switch remains ON by default; both modules read Civil's already-loaded value or saved `TIM_CE_CADTOOLS\CD_Settings.json` without initialising or writing settings.
2. **Counts:** an explicit Structural outcome replaces its older runtime/step mirror within that run's recorded time interval. Two explicit runs remain two runs, even within the same second. Manager has its own section and version; it never borrows Structural's version. Version read from an installed file is labelled "installed now", not proof of the version that produced a historical line.

**What it is:** a desk tool that reads the CE plugin logs and says, in plain English, whether each command worked, was refused, was cancelled, gave a warning or failed. Tim's own use of CE in the office becomes extra evidence for the desk with no work from him (decisions 2026-10-20 item 17, "all checking and testing is done by AI").

**What it never does:** it changes no plugin code, no Tim setting, no drawing. It starts no AutoCAD. It opens every log read-only (shared, so a running AutoCAD is never disturbed) and never writes to a CE log folder. It does not push to git.

**Use evidence, not acceptance.** WORKED means the command ran to its end with no error, refusal or warning line in the log. It does not prove the drawing came out right. Under RULES 4.5 Tim's use does not replace a Codex pass unless the desk decides otherwise.

## 1. Files

1. **`desk_jobs\log_outcomes.ps1`**: one report for any period. Options: `-Since 'yyyy-MM-dd HH:mm'` (default: start of today), `-Until`, `-Out <file>`, `-MinWorked N` (default 2), `-NoState` (dry run), `-CandidateFile <file>` (append failure candidates).
2. **`desk_jobs\log_outcomes_loop.ps1`**: the 30-minute loop. Weekdays 08:00 to 18:30 Melbourne time, plus once at 19:00. Runs the report when AutoCAD is running or a CE log changed. Writes `areas\LOG_OUTCOMES_<date>.md` (day so far on top, one block per run below, newest first), one line per run to `desk_jobs\log_outcomes.log`, and failure candidates to `areas\LOG_FAILURE_CANDIDATES.md`.
3. **`desk_jobs\STOP_LOGWATCH.flag`**: create this file to stop the loop. The loop is not started by anything; the desk starts it.
4. **`desk_jobs\log_outcomes_seen.json`** and **`log_outcomes.log`**: machine state and run log. Not committed (they change every run).

## 2. How to run

1. **One report now (read the console):** `pwsh -NoProfile -File C:\CE_PLAN\desk_jobs\log_outcomes.ps1 -Since '2026-10-20 00:00' -Until '2026-10-20 23:59' -NoState`
2. **Start the loop (hidden):** `Start-Process pwsh -WindowStyle Hidden -ArgumentList '-NoProfile','-File','C:\CE_PLAN\desk_jobs\log_outcomes_loop.ps1'`
3. **One loop tick now, or a past day:** `pwsh -NoProfile -File C:\CE_PLAN\desk_jobs\log_outcomes_loop.ps1 -Once -ForDate 2026-10-20`
4. **Stop it:** create `STOP_LOGWATCH.flag` in `desk_jobs`. Delete the flag before the next start.
5. **Commit:** the desk commits the day report and the candidates file by name. The loop never runs git.

## 3. What the outcomes mean

1. **WORKED:** the command ended (or logged its own completion line) with no failure, refusal or warning after that. A repeating command (CD, PIT) that Tim ends with Esc or Enter is logged as "cancelled" by the guard; if it also logged its completion line it counts as WORKED.
2. **REFUSED:** CE said no in plain words and left something alone ("edit refused", "not renamed", "no clear spot ... left where it is", a message ending in a reason code such as [OtherKindOfObject]). Not damage. A refusal followed later in the same run by the command's own completion line counts as WORKED (CDEDIT on an older pipe logs "edit refused", asks the question, then logs the cascade).
3. **CANCELLED:** the guard logged "cancelled" and the run had no completion line.
4. **WARNED:** a warning line, or a plain-sentence problem ("could not", "failed") that is not an error: "Redo was not available", a locked layer.
5. **FAILED:** an [ERR] line, an exception with no reason code, a stack trace, "unhandled".
6. **UNKNOWN:** the log shows the command started and shows no outcome line.
7. **Background sync steps** are counted apart: with debug logging off the log only shows that a project-data sync ran, not which command ran it.

## 4. Where the command markers come from

1. **Debug logging ON:** `UcsGuardService ... 'CMD' starting / ended / cancelled` lines bracket every guarded command (CD, CDEDIT, CDSYNC, CDRECOVERINVERTS, CDRULES, CDCHECKS, CDINSPECTOR, CDTIDYLABELS, CDTWL, PIT, PITSCHEDULE). These are DEBUG lines, from about build 3.0.60. Tim's normal setting is debug OFF, so in normal use they do not exist.
2. **Debug logging OFF:** a few INFO lines are used as fingerprints: `CD command started` and `CD command completed successfully`; `[C8] CDEDIT older pipe` and `CDEDIT-CASCADE:`; `[TWL] Detention system` (CDTWL); `[TidyUp] route=cdtidylabels-count/apply` (CDTIDYLABELS); `Pit added:` (PIT); `CDRECOVERINVERTS: pipe ... invert text written`; lines that start with a command name (`CDFIXTAGS could not rename`, `CDTAG failed`). Saved files: `cdrules-<drawing>-<time>.txt` (CDRULES with All) and `cdcheck-<drawing>-<time>.txt` (CDCHECKDWG).
3. **From the build that carries the command-outcome change (draft PR, Settings switch `Options.CommandOutcomeLines`, ON by default):** CE writes ONE INFO line when any CE command in its command registry ends, debug logging on or off: `Command outcome: CDSYNC completed 250 ms` (`completed`, `cancelled`, `refused` or `failed`; `(time unknown)` instead of the milliseconds if the start was not seen). Name, outcome and milliseconds only, never a drawing name or path. The reader treats it as the run's end marker: a refusal or warning line logged earlier in the same run still decides REFUSED or WARNED, `failed` gives FAILED, `cancelled` gives CANCELLED unless the run logged its own completion line. With debug ON the guard's own lines close the run and the outcome line adds nothing (no double count). Builds before that change still need the fingerprints in item 2. Tested 21 Oct on a made-up log (8 runs, all classified as expected). Civil only: Manager has no command log, Structural keeps its own records.
4. **Structural** writes real command records (name, completed or cancelled, time) to `RuntimeDiagnostics\runtime_<date>.jsonl` and, until 18 Oct, `StructuralCommands\struct_commands_<date>.log` (cmd, step, ERROR rows). Both are used; a command in both is counted once.
5. **Build number:** Civil from the `CE_CVL_SUITE vX Started` lines in the plain CE log (not the structured one). Structural logs carry none, so the installed plugin file's version is shown ("installed now").
6. **New messages:** any [ERR]/[WRN] text first seen on the report day (digits and handles ignored). The state file remembers the first day each was seen.

## 5. Cross-check against the robot reports (21 Oct, 18 to 20 Oct logs)

1. **CDEDIT, Edit Pipe cascade:** 11 runs on 20 Oct. The nine inside robot windows (runs 34 to 42) each logged `CDEDIT-CASCADE: anchor=P3 IL=17.50 pipes=4 pits=3`, the numbers the reports quote ("Updated 4 pipes and 3 pits from P3 (IL 17.50)", quoted in six of them). All WORKED. First pass called all 11 REFUSED (the "edit refused" line comes first, then the cascade). Fixed.
2. **CDTIDYLABELS, run 41:** six runs at 20:06:53, 20:09:58, 20:10:23, 20:12:35, 20:22:53, 20:23:05, the same times the report quotes. All REFUSED for one label ("pipe P3 -> P2 label: no clear spot", the expected "No clear spot found 1"). The automatic tidy after a MOVE or a draw (`route=established`, `route=draw`) is correctly not counted as a command.
3. **CDTWL:** runs 39 (three: two typed, one in the second session), 40, 41 and 42 each logged the `[TWL]` summary; all WORKED.
4. **CDRULES:** the saved findings files (run 41 at 20:13, run 42 at 21:59) match the file names the reports quote (the file name carries UTC). WORKED.
5. **CDRECOVERINVERTS:** runs 38 and 42 (debug ON) WORKED; 19 Oct run 32 WORKED by its "invert text written" line (the report says 2 texts written). Runs 39 to 41 ran it with debug OFF and it left no line (see gaps).
6. **CDSYNC:** runs 36, 37, 38 and 42 WORKED. Runs 39 to 41 are not visible (debug OFF).
7. **CD and PIT:** one CD and one PIT per run, all WORKED (first pass called the CD runs CANCELLED or UNKNOWN and the PIT runs CANCELLED; the guard logs Esc-to-finish as "cancelled"). Fixed by the completion line.
8. **CDFIXTAGS FAILED, 20 Oct 05:41 and 10:28 (runs 34 and 35):** "A source child does not have exactly one matching claim". Run 34 item 11: "the rename itself still does not apply" (BUG-813). A real failure, correctly FAILED.
9. **CDTAG REFUSED, 20 Oct 05:42:** the log line ends `[OtherKindOfObject]`; the user saw "Nothing was changed" (run 34 item 10). First pass called it FAILED because the log writes it at [ERR]. Fixed with the reason-code rule.
10. **CDTAG FAILED, 18 Oct 17:31:** "The requested source tag is not unique in the drawing". Run 31 saw "CDTAG stopped before its tag transaction committed. See the CE log" for the same case. Correctly FAILED.
11. **PITSCHEDULE WARNED, runs 36 to 38:** "Redo was not available in that gap" is a real warning line in the log.
12. **Numbers:** 103 of the 122 command runs on 20 Oct fall inside robot windows (runs 34 to 42); the other 19 are outside them (for example the debug-on session at 19:12 to 19:25). First pass: 32 of 89 runs (36 percent) were wrongly labelled (CDEDIT 11, CD 14, PIT 5, CDTAG 2). After the four fixes, every one of the 35 non-WORKED runs on 20 Oct (29 refused, 4 warned, 2 failed) matches its report, so 0 false positives among the runs I could check. Not checked: runs outside robot windows, and Structural (the only Structural commands in the window are 18 and 19 Oct, with no robot report to match).
13. **False negatives (commands that ran and left nothing):** CDSYNC in 3 of 7 robot runs, CDRECOVERINVERTS in 3 of 5, CDRULES Values in every run with debug OFF.

## 6. Log gaps and proposed diagnostic additions (for the desk to queue; nothing was built)

1. **Biggest and cheapest:** write the `UcsGuardService` start / ended / cancelled lines at INFO, not DEBUG. One place, covers every guarded command, and gives start and end in normal use.
2. **(Built 21 Oct as a draft PR, not yet in an installed build: the `Command outcome:` line above, name, outcome and time only; the plain sentence the user sees is not added.)** One result line per command from the shared command exit path, INFO level: `[CE] <COMMAND> result: worked | refused | cancelled | failed` plus the same sentence the user sees on the command line ("Nothing was changed." and the like).
3. **Deliberate refusals at WRN, not ERR.** Today a clean refusal (CDTAG on a pit block) logs at [ERR] with an exception name, so [ERR] cannot be trusted to mean a crash.
4. **CDSYNC:** log `CDSYNC complete. Pits relinked: N, Pipes relinked: N` (command line only today).
5. **CDRECOVERINVERTS:** log the totals line ("26 pipes recovered, 0 invert texts written, 21 already had invert text, 24 skipped"). Today it logs only when it writes text, so a run that writes nothing leaves no line.
6. **CDRULES:** log `CDRULES: N finding(s) across 12 rules ...` for All and for Values (Values leaves nothing with debug OFF).
7. **CDCHECKS and CDCHECK:** log the result count and the "CE could not check" path.
8. **CDINSPECTOR, PITSCHEDULE:** log "opened" and "drawn / updated N rows".
9. **CDTIDYLABELS:** log the Apply result (moved N labels), Undo, Redo and cancel.
10. **CDEDIT on a normal pipe:** only the older-pipe cascade leaves a completion line; log "pipe updated".
11. **CD and PIT:** log "cancelled" at INFO (CD logs started and completed only).
12. **CDTAG and CDFIXTAGS:** log the success line ("CDTAG applied: tag=...", "CDFIXTAGS renamed N blocks"); only failures are logged today.
13. **U and REDO:** "Everything has been redone" and "Nothing to redo" are command-line only.
14. **Manager:** no per-command log at all (its telemetry file was last written in July). **Structural:** command records exist but no build number, and `struct_commands` has not been written since 18 Oct. **ribbon-clicks.log** has not been written since 14 Oct. **native_grip_2027.log** records grip decisions, not outcomes.

## 7. Privacy

1. Reports show command names, counts and messages only. Drive paths become `<path>`, drawing names `<dwg>`, job numbers `<job>`, the Windows user name `<user>`. A message that still looks like it names a project or an address is replaced by "message withheld". The saved findings files are counted by time only; their names are never printed.
2. A final sweep replaces any output line that still holds a drive path, a drawing name or the user name.
3. The scripts carry no personal term (the user name is built from two halves). Run the leak-scan before any push; never use `--no-verify`.

## 8. Known limits

1. **Debug-OFF blindness** (section 4 and 6). The report says so in section 7 of every day file.
2. **A command run is a guess from lines** when the build writes no markers: lines within 2 minutes (5 minutes for CD and CDEDIT) of the same command are one run.
3. **Time:** log times are the PC clock, which is Melbourne time here. The loop schedules on Melbourne time and reads the logs on PC time.
4. **Not tested:** the loop's real 30-minute cycling and its 19:00 closing run (only `-Once` was run); Manager (no log); Structural matched to a report.
