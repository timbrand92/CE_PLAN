# Desk handoff (plan/03), Fri 16 Oct 2026 about 18:15 Melbourne. Read this first after a compaction or a new desk chat.

NAME THIS CHAT (if starting fresh): CE_ACAD / ideas / plan / 04. Otherwise keep CE_ACAD / ideas / plan / 03.

## 1. Who I am and what the job is
1. I am the desk chat. The controller chat `build + release / 06` has been silent since Tue 13 Oct, so the desk is ACTING CONTROLLER: builders, trains, finalizers, installs, robot tests, Codex hand-offs, usage.
2. Rules: `C:\TimOS\RULES.md` (answer first, plain English, numbered lists with bold labels, NO TABLES, reply split FOR TIM above a line / technical BELOW THE LINE; AutoCAD free windows: before 08:30, 14:00 to 15:00, after 17:30, weekends; never mark FIXED before Tim confirms in AutoCAD). Tim's standing rulings: `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md` INT-073..081 (builders never wait for his answers; build the recommended answer as a DRAFT behind a Settings switch; no blue; usage ceilings).
3. End state Tim wants: everything in the V3 plan/UI/UX built, then FULL testing between Claude and Codex, with batches of questions to Tim while building and testing never stop.

## 2. State at this moment (read the DLLs, never trust this line)
1. Installed: Civil 3.0.50 + Manager 1.1.50 (C-39, d36f9545) and Structural 1.0.117 (S-37, 0dfbd1d6), installed 16 Oct 17:47 and 17:52, verified file by file by the desk; NOT yet driven in AutoCAD.
2. Records already written: `START_HERE.md` state block, `QUEUE.md` entries 267 and 268, `TIM_DESK.md` entry 236, `REMINDERS_FOR_TIM.md` (3 open items), `REVIEWLANE_LOG.md` entries 980-994 (the ten Codex PRs), `areas/release-v3-colleagues-CODEX_BUG_TRIAGE_2026-10-16.md` (fix queues per lane, 11 questions for Tim, shared root-cause fixes).
3. Codex's native campaign (13 to 16 Oct): 762 scoped checks, 592 PASS / 139 FAIL / 7 BLOCKED / 24 UNPROVEN, 81 new bugs BUG-570..650, ten draft PRs #1253..#1262. Desk verified: 1,698 of 1,698 evidence files present, recount equals the index.
4. Review verdicts on the ten PRs: MERGE #1253 #1254 #1255 #1257 #1261 #1262; MERGE-WITH-FIXES #1259 (export must also print Unknown); HOLD (tests only, merge with their fix) #1256 #1258 #1260. Next trains: Civil on top of C-39 (rel-20261010e): #1253 #1255 #1257 then #1259 fixed; Structural on top of S-37 (rel-20261010d): #1254 #1261 #1262.
5. Biggest bug lead: BUG-650 root cause (full refresh at command start blanks stored pit inverts when the cover label has no IL line), see triage file section 1.

## 3. Usage and clocks (all in Melbourne time)
1. Claude main (Max): reset Fri 16 Oct 13:00; this chat and the Opus agents run on it; ceiling 95 percent (Tim, INT-081); keep this chat's turns short.
2. Claude Team: week 100 percent used, resets Sat 17 Oct 14:00; ceiling 100 percent. Read it with `pwsh -NoProfile -File C:\CE_PLAN\desk_jobs\team_usage.ps1` (also inside `desk_tick.ps1`). Opus not Fable on Team (Tim 12 Oct; revisit when Fable is 5.5). Builders/assemblers Sonnet.
3. Codex: week 100 percent used, resets Thu 22 Oct 17:13. Codex wrote a heartbeat to restart its AutoCAD testing at 16:05 on 20 and 27 Oct: coordinate it so two writers never run. Codex model: gpt-6.1-sol (cheaper than astra, as good for AutoCAD control).

## 4. Things running by themselves (check with `desk_tick.ps1`)
1. Lane loops `desk_jobs\lane_loop.ps1 -Lane 02|03|04` (hidden pwsh, 3 processes): run builders back to back on Team Sonnet; sleep until the reset when the weekly or session limit is hit; wait 2 hours after any run under 15 minutes. All three sleep until Sat 17 Oct 14:03. Stop with `STOP_LANES.flag` or `STOP_<lane>.flag` in desk_jobs. Restart a dead loop: `Start-Process pwsh -WindowStyle Hidden -ArgumentList '-NoProfile','-File','C:\CE_PLAN\desk_jobs\lane_loop.ps1','-Lane','04'`.
2. `desk_jobs\team_governor.ps1` (1 hidden pwsh): every 20 min reads Team usage and launches jobs from `governor_queue\` (13 Opus hunts/reviews + 1 Sonnet audit) when the week is behind the pace line that ends at 98 percent; stop flag `STOP_GOVERNOR.flag`.
3. Detached launcher `desk_jobs\launch_tester22_sat1408.ps1`: at Sat 17 Oct 14:08 it starts the Claude robot pass run 22 on the new builds (job `scratchpad\tester_run22.txt`) if no acad.exe is running. Check its report `areas\release-v3-colleagues-CLAUDE_DRIVER_RUN22_CIVIL3050_2026-10-17.md`.
4. Nothing else is running: all Max agents finished; AutoCAD is closed; C: about 30 GB free.

## 5. What to do next, in order
1. Sat 17 Oct 14:03 to 15:00: confirm the lane loops restarted (log `lane_loop_0x.log`), the robot pass started, Team usage reading; read the run 22 report; tell Tim plainly.
2. Assemble the next trains on Team (Sonnet assemblers, Opus finalizers): Civil on C-39 with #1253 #1255 #1257 + #1259 fix + the Civil shared fixes from the triage file; Structural on S-37 with #1254 #1261 #1262 + Structural shared fixes. Payload and install only with a robot pass after (install in a free AutoCAD window; wrappers `run_install6x.ps1` live in the controller 06 scratchpad `%LOCALAPPDATA%\Temp\claude\C--Lisp-Files-CE-ACAD-PLUGIN--claude-worktrees-hopeful-davinci-8f52f7\f53d1da6-3a9e-4088-9a0b-0ae5c7fbb4f1\scratchpad`; its `install1001_verify_tree.ps1` was deleted, so verify installs by comparing every candidate file with the installed file by SHA256 as the desk did on 16 Oct; NEVER delete that scratchpad).
3. Put Tim's 11 triage questions and `REMINDERS_FOR_TIM.md` at the top of the first morning report after 08:30.
4. Fresh recount of the four figures (Team Sonnet job once Team resets): Built / Codex-tested / Installed / Tim-accepted (Tim-accepted is 0).
5. Thu 22 Oct 17:13: Codex resets; the full-testing phase resumes with Sol; the Claude robot covers typed-command checks first (cheaper), Codex the mouse and window checks (tick-list briefs W60..W80 in `C:\Lisp Files\_CODEX_RUNNER`, window builders bj26..bj31).
6. Open decisions for Tim: `REMINDERS_FOR_TIM.md` items 1 to 3 (decompilation chat doing fix work; remove the stale Manager 1.0.0 in `C:\ProgramData\Autodesk\ApplicationPlugins`; switch on two Structural warnings on his PC), the triage questions, Batch 6 Q1 and Q5, Set C Q5, clearance numbers.

## 6. Lessons that must not be repeated
1. Never leave builder lanes idle: loops now run them; check with `desk_tick.ps1` at every tick (it prints workers, AutoCAD, C: free, Team usage, a disk alarm under 25 GB).
2. A runaway background python filled C: (41.6 GB task output) and stopped everything for 11 hours: never run a bare python in a background shell; look for huge `Temp\claude\...\tasks\*.output` files when C: falls.
3. 400 empty "no new work" lane runs burned the Team week: lane runs under 15 minutes now back off for 2 hours.
4. Before any robot run check for Codex window runs as well as acad.exe; Claude robot and Codex must never share AutoCAD. Never use `git pull --rebase` or `origin master` in C:\CE_PLAN (fetch, then merge --ff-only or --no-edit origin/main); add files by name; the plan repo has other chats' uncommitted edits.
5. Always read the installed DLLs and the REAL branch heads; master (650c0c19) is about 1,100 commits behind and must never be audited.
6. Codex builders and Opus agents can hang on whole-assembly Structural test runs (SBEAM cases): kill the testhost after 10 minutes.
7. Tim's old Codex AutoCAD sessions: pid 12844 closed normally, pid 62380 (BUG-595 session) was stopped by the desk on 16 Oct (log `desk_jobs\acad_cleanup_2026-10-16.log`).

## 7. Key files
1. Desk scripts folder: C:\CE_PLAN\desk_jobs
2. Status: desk_tick.ps1 (also prints Team usage through team_usage.ps1)
3. Usage-paced job launcher: team_governor.ps1 with the governor_queue folder
4. Builder loops: lane_loop.ps1 (one hidden process per lane)
5. Single Team job launcher: launch_job.ps1 with the option for the model (sonnet or opus)
6. Installed DLL reader: readdll.ps1
7. Old fix queue: NEXT_FIXES_2026-10-08.md
8. Robot driver: the folder _ACAD_DRIVER under C:\Lisp Files, file acad_driver_witness.ps1 (use only this copy); guide DRIVER_TESTER_GUIDE.md
9. The desk's private memory notes are not stored in this repository; this handoff is the shared copy of what they say.

## 8. Addendum Fri 16 Oct 21:00 (after compaction)
1. Found and fixed: the three lane job files had grown to about 750 KB each (about 290 stale RUN lines), so every Team run re-read about 190k tokens of junk. lane_loop.ps1 now strips old RUN lines; the files are about 6 KB; backups sit beside them as .bak_16oct.
2. The lane loops were restarted with a new -NotBefore gate (Sat 17 Oct 14:03), so they still start by themselves at the Team reset.
3. Tim asked to build on the Max account now (Max week 2 percent used, resets Fri 23 Oct 13:00, ceiling 95 percent, so about 14 points a day). Two Sonnet Max builders are running: lane 03 (Civil, BUG-650 first, then #1259 export fix) and lane 02 (Structural). They take a build lock folder (desk_jobs\build.lock) before each build and log a CLAIM line in their TEAMLANE log before each item so the Team lanes skip claimed items.
4. Slip: an empty python3 heredoc spun a python process (killed within minutes, nothing written). Never run python from the desk shell.

## 9. Addendum Sat 17 Oct 2026 (after Tim's pause ruling)
1. **PAUSE ON NEW ITEMS** (Tim, about 03:20 Sat 17 Oct, decisions/2026-10-17_V3_ALIGNMENT_RESET.md ruling A): fix existing things only. Do not start new plan items, engines, or wiring of built engines. Lane loops were restarted with this text (still gated to Sat 14:03 by -NotBefore); governor queue jobs are bug hunts and reviews, which stay allowed. The PLAN_GAP_AUDIT wiring queues and its first question (Claude building simple windows) are on hold.
2. State at that moment: Max builders produced about 35 draft PRs overnight (Civil C-39 base, Structural S-37 base), Opus reviews are entries 995-1071 in REVIEWLANE_LOG; trains assembled: Structural S-38 = branch claude/rel-20261017s (19 PRs), Civil C-40 = branch claude/rel-20261017c (37 PRs); Opus finalizers were running for both. After a GO from each: a payload builder makes the version commit and the candidate payload (model: desk_jobs/ctl_payload69_job.txt and the brief files named in the controller scratchpad), the Claude robot passes it, then install in a free AutoCAD window with the proven wrappers, then verify file by file. Tell Tim before installing.
3. New bug BUG-651 (CDIMPORTXCIVIL Esc at 'Proceed with import?' writes the import) is in BUG_CARPARK; fix PR #1311.
