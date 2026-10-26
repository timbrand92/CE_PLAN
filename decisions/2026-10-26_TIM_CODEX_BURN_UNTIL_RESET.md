# Tim ruling, Mon 26 Oct 2026 (about 18:40 Melbourne): Codex burn mode until the weekly reset

Tim's words: "another weekly usage reset is coming for codex can you use it on fast mode for anything you need up until it resets and then once weekly usage resets finish what is being used and from there usage goes back to normal, make sure you check weekly usage everytime you start a new task"

1. **Burn mode ON** (until the reset): `C:\Lisp Files\_CODEX_RUNNER\BURN_UNTIL.txt` (line 1 end time, line 2 the weekly resets_at when set). While it exists and neither the end time nor the reset time has changed, `daily_cap.sh` returns 97 (use everything) and the conveyor stops at 97 instead of 90. End time set to Fri 30 Oct 07:00 (the desk's earlier estimate; the real reset time is NOT known: the newest Codex reading says Mon 2 Nov 17:17). Tim to confirm the real time.
2. **Reset detected = burn over.** The first time the end time passes OR Codex shows a new reset time, `daily_cap.sh` renames BURN_UNTIL.txt and CODEX_PLAN_END.txt to .ended, writes BURN_ENDED.txt, and the cap returns to the normal equal daily share of the new week. Running Codex jobs are never stopped: only new starts are held.
3. **Fast mode everywhere.** queue4.sh (fillers, case reviews, builds) already ran with service_tier fast; queue3.sh (the AutoCAD looks, via launch_codex_retry.ps1) now does too (backup queue3.sh.pre_fast).
4. **Usage check at every new task.** The conveyor (before each look) and the supervisor (before each filler) read `codex_usage.sh fresh-pct`, which probes when the reading is over 20 minutes old; the desk reads it before queuing any Codex work.
Backups: daily_cap.sh.pre_burn, codex_conveyor.ps1.pre_burn (desk_jobs), queue3.sh.pre_fast.

## Update 26 Oct 2026 about 19:35
Tim: "theres no confirmed time just use it up until it resets". So the Friday 30 Oct 07:00 end time (the desk's guess) is dropped: BURN_UNTIL.txt now ends at Mon 2 Nov 17:17 (the natural week end in Codex's own reading) and the burn ends EARLIER only when a reset shows: Codex shows a new reset time, OR the used percent falls 8 or more points below the highest reading seen in the burn (line 3 of BURN_UNTIL.txt). No question to Tim about the time is open any more.

## Update 27 Oct 2026 about 08:55
Tim: "not sure when this reset is coming but be on the look out, testing is our priority". The watcher (codex_burn_watch.ps1) re-reads Codex's weekly figures every 5 minutes (a tiny probe when the newest reading is over 20 minutes old), so a reset shows within about 25 minutes by a new reset time or a usage fall of 8 or more points. When it shows: CODEX_MODE goes back to PACE, running jobs finish, and the NEW WEEK's share goes to TESTING first: independent case re-reviews (cx_cr), then the window looks, then reviews and builds (the supervisor's PACE order already does this). The robot keeps first call on AutoCAD; Codex looks queue behind its lock.
