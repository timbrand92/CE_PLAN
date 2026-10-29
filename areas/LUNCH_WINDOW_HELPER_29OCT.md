# Lunch-window helper — save and close Tim's AutoCAD at 14:00, reopen it at 15:00

CE_ACAD / robot / build / 23 · written Thu 29 Oct 2026, 15:04 Melbourne time · Team, Opus

**ANSWER FIRST:** the helper is written and its decision logic passes 52 of 52 offline checks against a pretend AutoCAD.
**It has NOT been run on a real AutoCAD yet** and nothing is switched on: no scheduled task is registered.
The first real test can be tonight after 17:30 on throw-away copies (steps below). The earliest it can run at lunch is **Fri 30 Oct**, and only if that test passes and the desk then registers the two tasks.

Tim's instruction (Thu 29 Oct 2026): *"if autocad is open at 2pm you need to save everything and close it during lunch then reopen everything at 3pm as it was"*.

## FOR TIM

1. **At 14:00 on a weekday:** if your AutoCAD is open and the robot has a test waiting, it saves every drawing (the same as QSAVE) and checks each one really saved. Then it closes AutoCAD the normal way, as if you clicked the X.
2. **At 15:00:** AutoCAD starts with your profile ("Tim"). Your drawings open as tabs in the same order. The drawing you were on comes to the front, and the window is maximised again if it was before.
3. **Each drawing comes back at the view it was saved with**, because the save at 14:00 keeps the current view and layout tab inside the drawing itself.
4. **It will NOT close AutoCAD when:**
   1. **A new drawing was never saved** (a Drawing1 with work in it). It never guesses where to save your work.
   2. **A command is still running**, or a dialog box is open, or you have used the mouse or keyboard in the last 2 minutes. It tries again every 30 seconds for 10 minutes, then gives up and leaves everything open.
   3. **A save fails**, or a read-only drawing has changes that cannot be saved.
   4. **The robot has nothing to test.** No point closing your work for nothing.
5. **It never force-kills AutoCAD.** If AutoCAD does not close within 3 minutes, it leaves it running and writes that down.
6. **At 15:00 it will not start a second AutoCAD.** If you have already opened AutoCAD yourself, it does nothing.
7. **If the robot or Codex is still in AutoCAD at 15:00**, it waits up to 10 minutes. If they are still busy after that, it leaves AutoCAD closed so the two don't collide. Your drawings are all saved; open them as usual.
8. **A drawing deleted, moved or opened by someone else over lunch** is skipped. The rest still open, and the log says "could not reopen 1 drawing".
9. **Private data stays on this PC.** Your drawing names and folders are written only to a local folder (`C:\ce_rc_scratch\lunch`), never to the plan, a repo or a report. The shared log only says things like "closed 4 drawings".
10. **Today it would do nothing:** the robot is on hold (the hold flag is set), so it would leave your AutoCAD open. Three robot jobs are waiting; the desk lifts the hold when it wants the lunch hour used.
11. **Undo:** the desk deletes the two scheduled tasks (one line each, below). Nothing in AutoCAD or your drawings needs undoing.
12. **Tested so far:** only the decisions, against a pretend AutoCAD and fake files. **Not yet tested:** a real save, close and reopen in AutoCAD. That is tonight's test, on copies.

---

## Detail

### Files

1. **The helper:** `C:\CE_PLAN\desk_jobs\lunch_window.ps1` with `-Action Close | Reopen | Status`, `-DryRun` (decides and reports, touches nothing), and `-IgnoreClock` (for the night test and a by-hand reopen).
2. **State, local only:** `C:\ce_rc_scratch\lunch\lunch_state.json`. This folder is outside OneDrive and outside every git repo; I checked with `git rev-parse` (not a repository). The helper re-checks this every run and refuses to write if the folder sits under OneDrive, `C:\CE_PLAN`, `C:\Lisp Files`, `C:\TimOS` or any `.git` folder.
3. **Detail log, local only:** `C:\ce_rc_scratch\lunch\lunch_detail.log`. It names missing or failed drawings.
4. **Repo log, counts only:** `C:\CE_PLAN\desk_jobs\lunch_window.log`. Any line that looks like a drive path, a UNC path or a `.dwg/.dxf/.dwt/.bak` name is replaced with "line withheld" before it is written.
5. **Offline tests, local:** `C:\ce_rc_scratch\lunch\tests\lunch_window_tests.ps1`. It is not in the repo because it builds fake job-style folder names.

### How Close decides (in order)

1. **Clock:** it must be a weekday between 13:55 and 14:20, unless `-IgnoreClock` is set.
2. **AutoCAD running:** no acad.exe means "nothing to do". More than one acad.exe means "left open".
3. **The robot wants the window:** `LUNCH_CLOSE.flag` exists, OR (`HOLD_ROBOT.flag` is absent AND `ROBOT_QUEUE.txt` has a job with no `.done` file). This uses the same queue rule as `chain_robot_standing.ps1`.
4. **Attach** to the running AutoCAD the same way the driver does (`AutoCAD.Application.26`, then `AutoCAD.Application`), through GetActiveObject. It never starts AutoCAD to do this.
5. **Busy check, every 30 s for 10 minutes:** CMDACTIVE is non-zero in any drawing, or a COM call is refused (a modal dialog), or the PC has had keyboard or mouse input in the last 2 minutes. That last check is my addition: it stops the helper closing AutoCAD under Tim's hands if he works through lunch.
6. **Snapshot:** for each document in order it records path, read-only, active, titled (FullName and DWGTITLED), modified (Saved and DBMOD) and model-space item count.
7. **Refuse** if an untitled drawing is modified or has content, if a read-only drawing is modified, or if no titled drawing is open. An empty, unchanged Drawing1 does not block and is not recorded.
8. **Save** each titled, writable drawing (`Document.Save`, the same as QSAVE), then require `Saved = true` on every titled drawing. Any failure leaves AutoCAD open.
9. **Write the state, then Quit:** state status goes `saved`, then `Application.Quit()`, then it waits up to 180 s for that acad.exe PID to go. Success means status `closed`. Failure means `quit-pending` and "NOT killed".
10. **Recorded with each close:** exe path, full launch command line (today: `/product ACAD /language "en-US"`, read from the running process), profile from `HKCU\Software\Autodesk\AutoCAD\R26.0\ACAD-A101:409\Profiles` (today: `Tim`), and the window state number.

### How Reopen decides

1. **Clock:** it must be a weekday between 14:55 and 15:30, unless `-IgnoreClock` is set.
2. **Today's state:** the state must say `closed` and be captured today, otherwise nothing is done.
3. **Wait for the robot, Codex and the driver, up to 10 minutes:** the driver lock `C:\ce_rc_drv\ACAD_LOCK.json` is live (same rule as the driver: not expired, holder PID alive), or a process command line matches `codex … exec`, `tester_run<n>`, `chain_runner_run`, `case_runner.ps1`, `acad_driver_v3`, `acad_driver_witness` or `desk_install_c/s<n>`. If still busy after 10 minutes, it leaves AutoCAD closed and keeps the state, so the desk can run `-Action Reopen -IgnoreClock` later.
4. **AutoCAD already running:** status becomes `skipped-acad-running` and nothing opens.
5. **Missing or locked files:** each drawing is checked for being missing or locked (an exclusive open test). Those are skipped and counted.
6. **Start and open:** it starts acad.exe with the recorded arguments plus `/p "<profile>"` (if `/p` was not already given), waits up to 300 s for COM, then runs `Documents.Open(path, readOnly)` in the recorded order (12 retries each). It closes a blank, unchanged Drawing1 that AutoCAD opened at start, activates the recorded active drawing and sets WindowState.

### The trigger (designed, NOT registered)

Both tasks run as Tim, only while he is logged on, not elevated. That is required so the helper can see his AutoCAD and so AutoCAD reopens on his screen. "Start when available" is off, so a missed 14:00 never fires late; the clock check would refuse it anyway.

```powershell
$pw = 'C:\Program Files\PowerShell\7\pwsh.exe'
$p  = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType Interactive -RunLevel Limited
$s  = New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Minutes 30) -MultipleInstances IgnoreNew
$d  = 'Monday','Tuesday','Wednesday','Thursday','Friday'
Register-ScheduledTask -TaskName 'CE Lunch Close'  -Principal $p -Settings $s -Trigger (New-ScheduledTaskTrigger -Weekly -DaysOfWeek $d -At 14:00) -Action (New-ScheduledTaskAction -Execute $pw -Argument '-NoProfile -WindowStyle Hidden -File "C:\CE_PLAN\desk_jobs\lunch_window.ps1" -Action Close')
Register-ScheduledTask -TaskName 'CE Lunch Reopen' -Principal $p -Settings $s -Trigger (New-ScheduledTaskTrigger -Weekly -DaysOfWeek $d -At 15:00) -Action (New-ScheduledTaskAction -Execute $pw -Argument '-NoProfile -WindowStyle Hidden -File "C:\CE_PLAN\desk_jobs\lunch_window.ps1" -Action Reopen')
```

Undo, one line each:

```powershell
Unregister-ScheduledTask -TaskName 'CE Lunch Close'  -Confirm:$false
Unregister-ScheduledTask -TaskName 'CE Lunch Reopen' -Confirm:$false
```

Per the Defender note in `C:\Lisp Files\CLAUDE.md`, the desk should put these lines in a scratch `.ps1` file and run that file, rather than pasting them inline.

### So the robot actually uses the window

1. **The robot must want the hour.** `HOLD_ROBOT.flag` must be removed (or `LUNCH_CLOSE.flag` created) and `ROBOT_QUEUE.txt` must have a job with no `.done` file. Right now (15:04) the hold flag is set. Three jobs have no `.done`: run77, run79 and run78.
2. **The standing robot loop must be running.** `chain_robot_standing.ps1` needs AutoCAD absent for 3 minutes before it starts a job. A close at 14:00 to 14:13 lets it start at about 14:03 to 14:16. Robot jobs stop starting at 14:50 (`ROBOT_STOP_BY.txt` if it exists, otherwise the 14:30 and 14:50 rule written into each tester job).
3. **Codex's own queue is not counted by the guard.** If Codex alone should use the hour, the desk creates `LUNCH_CLOSE.flag` for that day.
4. **Nothing runs just to run.** With no pending job and no `LUNCH_CLOSE.flag`, the 14:00 task logs "left open" and does nothing else.

### Offline test output (pwsh, Thu 29 Oct 2026 ~15:02)

```
--- 1. all drawings saveable -> saves and closes
Thu 29 Oct 14:00 close: closed 3 drawing(s), active one recorded, AutoCAD gone
PASS  writable drawings saved once each, read-only one not saved
PASS  Quit asked exactly once (no kill)
PASS  state status closed, 3 drawings in order
PASS  active drawing recorded as the 2nd
PASS  read-only flag recorded
PASS  command line, profile and window state recorded
PASS  state file holds the real paths
PASS  state file is in a local-only folder
PASS  repo log says closed 3 drawing(s)
PASS  repo log has no path, no drawing name, no job folder
--- 2. one never-saved drawing with work -> refuses, touches nothing
Thu 29 Oct 14:00 close: left open: 1 never-saved drawing(s) hold work (no save location is ever invented)
PASS  nothing saved
PASS  Quit not called
PASS  no state file written
PASS  repo log says left open, never-saved
--- 2b. an empty unchanged Drawing1 does not block; it is not recorded
PASS  closed, 1 drawing recorded, 1 empty untitled skipped
--- 3. a command running the whole time -> retries for 10 minutes, then leaves AutoCAD open
Thu 29 Oct 14:10 close: left open: AutoCAD busy (a command is running) for 10 minutes, nothing touched
PASS  retried 20 times (every 30 s for 10 min)
PASS  nothing saved, Quit not called, no state
PASS  repo log says left open: AutoCAD busy
--- 3b. command finishes after 1 minute -> then saves and closes
PASS  waited 2 steps then closed
--- 3c. AutoCAD not answering (dialog) -> busy, left open
PASS  left open, not answering
--- 3d. keyboard used in the last 2 minutes the whole time -> left open
PASS  left open because someone is at the keyboard
--- 4. one save fails -> AutoCAD not closed
Thu 29 Oct 14:00 close: left open: 1 save(s) failed, 1 drawing(s) not reading saved; AutoCAD not closed
PASS  Quit not called, state not marked closed
PASS  repo log: 1 save(s) failed
--- 5. read-only drawing with changes -> refuses
PASS  left open: read-only with changes
--- 6. HOLD_ROBOT.flag set, no LUNCH_CLOSE.flag -> AutoCAD left open
PASS  left open: no robot job / hold flag
--- 6b. LUNCH_CLOSE.flag present -> closes even with the hold flag
PASS  closed with LUNCH_CLOSE.flag
--- 6c. every queued job done -> left open (nothing runs just to run)
PASS  left open: queue empty
--- 7. AutoCAD does not go after Quit -> waits 3 minutes, never kills
Thu 29 Oct 14:03 close: saved 1 drawing(s) and asked AutoCAD to quit, but it is still running after 180 s; NOT killed
PASS  status quit-pending, AutoCAD still alive
--- 8. dry run -> reports, touches nothing
PASS  dry run: no save, no quit, no state
--- 8b. Saturday -> nothing
PASS  Saturday: nothing done
--- 9. reopen: 1 file missing, 1 locked -> opens the other 2 in order, active restored
Thu 29 Oct 15:00 reopen: reopened 2 drawing(s); could not reopen 2 drawing(s) (1 missing, 1 locked, 0 failed)
PASS  AutoCAD started once with the recorded command line plus the profile
PASS  opened 2 drawings in the recorded order
PASS  recorded active drawing activated
PASS  blank Drawing1 closed
PASS  window state restored (maximised)
PASS  repo log: could not reopen 2 drawing(s)
PASS  repo log has no path, no drawing name
PASS  detail log (local) names the missing one
--- 10. AutoCAD already running at 15:00 -> nothing opened
PASS  nothing started, status skipped-acad-running
--- 11. robot lock live the whole time -> waits 10 minutes, leaves AutoCAD closed
Thu 29 Oct 15:10 reopen: left closed: the AutoCAD lock is held after 10 minutes (state kept; run -Action Reopen -IgnoreClock to reopen by hand)
PASS  waited 20 steps, nothing started, state kept closed
PASS  repo log: left closed: the AutoCAD lock is held
--- 11b. a codex exec finishes after 90 s -> then reopens
PASS  waited 3 steps then started AutoCAD and opened 1
--- 11c. a stale lock (its holder process is gone) does not block
PASS  stale lock ignored, reopened
--- 12. state from yesterday -> nothing reopened
Fri 30 Oct 15:00 reopen: nothing was closed today, nothing to do
PASS  nothing started
--- 13. private-data guards
PASS  C:\CE_PLAN\desk_jobs is NOT local-only
PASS  a repo working copy is NOT local-only
PASS  OneDrive is NOT local-only
PASS  C:\ce_rc_scratch\lunch IS local-only
PASS  repo log withholds lines that look like paths or drawing names
PASS  state folder inside CE_PLAN is refused (no folder made)
PASS  relaunch args keep an existing /p
PASS  the real repo log was never written by these tests

RESULT: 52 passed, 0 failed, 52 checks
```

I also ran `-Action Status` for real (read-only). It printed `lunch window: no state recorded`. The real repo log was not created.

### What can NOT be tested without a real AutoCAD

1. Whether `GetActiveObject` reaches Tim's AutoCAD from a scheduled task. It needs the same user, the same session and the same (non-elevated) level.
2. Whether `Document.Save` on a drawing that is not the active one behaves like QSAVE. That includes the save format, which follows Tim's Options "Save as" setting, the same as his own QSAVE.
3. Whether `Saved` and `DBMOD` read as expected after the save, on network drives and on drawings with xrefs.
4. Whether CMDACTIVE or a refused COM call catches every busy state. Examples: REFEDIT, an open palette or editor, a transparent command, a CE window.
5. Whether `Quit` closes with no prompt once everything is saved (for example, no "save changes to Drawing1?" prompt, and no CE add-in holding it open).
6. Whether `Documents.Open` works while AutoCAD is still starting up (the retries are a guess), and whether startup opens a Drawing1 or the Start tab.
7. Whether the view, layout tab and window state come back as expected. The WindowState number is stored and written back as-is; that 3 means maximised is from Autodesk's documentation, not checked.
8. Whether the exclusive-open "locked" test detects a drawing another person has open on the server.
9. Whether the "keyboard used in the last 2 minutes" check works the same in a task as in a console.

### Real test tonight, after 17:30 (the desk runs it; Tim's AutoCAD must be closed; throw-away copies only)

1. **Check the PC is clear:** run `Get-Process acad` (nothing). `C:\ce_rc_drv\ACAD_LOCK.json` must not be live. No tester_run, Codex exec or driver process may be running. Keep `HOLD_ROBOT.flag` in place for the whole test so the robot cannot start.
2. **Make the copies:** copy three test drawings (for example from `C:\ce_rc_drv\`) to `C:\ce_rc_scratch\lunch\realtest\` as `A.dwg`, `B.dwg` and `C.dwg`. Never use a live job drawing.
3. **Set up AutoCAD:** start AutoCAD 2027 from its normal shortcut, open A, B and C, and maximise the window.
   1. In A, draw one line and do not save.
   2. In C, zoom to one corner.
   3. Click the B tab so B is the active drawing.
4. **Make the flag:** create `C:\CE_PLAN\desk_jobs\LUNCH_CLOSE.flag`, because the hold flag would otherwise make the helper refuse.
5. **Dry run:** run `pwsh -NoProfile -File C:\CE_PLAN\desk_jobs\lunch_window.ps1 -Action Close -IgnoreClock -DryRun`. Expected: `would save and close 3 drawing(s)`, and AutoCAD is untouched.
6. **Real close:** do not touch the mouse or keyboard for 2 minutes (start the command with `Start-Sleep 150;` in front), then run the same command without `-DryRun`.
   - Expected: `closed 3 drawing(s)`, and acad.exe gone within 3 minutes.
   - In `lunch_state.json`: status `closed`, three paths in order, B marked active, `window_state` recorded.
7. **Reopen:** run `-Action Reopen -IgnoreClock`. Expected:
   1. AutoCAD starts with profile Tim and is maximised.
   2. The tabs read A, B, C, and B is in front.
   3. A shows the line, and C shows the zoomed corner.
   4. The log says `reopened 3 drawing(s)`.
8. **Refusal test, never-saved drawing:** start a new drawing, draw a circle and leave it unsaved, then run Close again. Expected: `left open: 1 never-saved`, and nothing is saved or closed. Discard that drawing.
9. **Refusal test, busy command:** start the LINE command and leave it waiting at "Specify next point", then run Close. Expected: retries for 10 minutes, then `left open: AutoCAD busy`. Repeat with the OPTIONS dialog open; expected: `not answering`.
10. **Missing-file test:** close cleanly (step 6), rename `C.dwg`, then run Reopen. Expected: A and B open, and the log says `could not reopen 1 drawing(s) (1 missing…)`.
11. **Already-running test:** with AutoCAD already open and a `closed` state from earlier today, run Reopen. Expected: `already running: nothing opened`.
12. **Clean up:**
    1. Delete `LUNCH_CLOSE.flag` and the `realtest` folder.
    2. Delete `lunch_state.json`.
    3. Delete the night-test lines in `desk_jobs\lunch_window.log`.
    4. Close AutoCAD.
13. **Check the repo log:** `C:\CE_PLAN\desk_jobs\lunch_window.log` must contain counts only, with no path, drawing name or folder name.

### What I did NOT verify

1. **Nothing ran against a real AutoCAD.** Tim's AutoCAD (PID 30056, `/product ACAD /language "en-US"`) was open and was not touched. I only read its process command line and the registry profile name.
2. **No scheduled task is registered**, and none was test-registered.
3. **REFEDIT, CE plugin windows and Sheet Set Manager** were not checked as busy states.
4. **Public holidays** (for example Melbourne Cup Day, Tue 3 Nov) are not handled by the clock. On those days the robot guard and "is AutoCAD open" decide.
5. **`lunch_window.log` is not in any ignore list.** It holds counts only, so committing it is safe, but the desk should decide whether to track it.
