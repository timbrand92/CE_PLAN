# CE 02 Robot and Codex Testing: session state (last saved Thu 29 Oct 2026 17:19 Melbourne PC clock)

Latest state only; older detail is in the DESK_LOG lines headed "CE 02" (from 09:34 on Thu 29 Oct). Read first after a compaction: this file, then C:\CE_PLAN\areas\CE_SESSIONS_MAP_29OCT.md, then C:\Users\TimothyBrand\AppData\Roaming\Claude\side-session-notes\local_5d4f0680-b6d5-4ef2-a12f-5e59f42c4037\CE02_STATE_29OCT_1705.md.

## 1. Numbers (two figures each, never merged)

1. **Everyday tools Claude-accepted: 19 of 40** (CE 00 ruling, ledger item 28; PIT and CD are D01 and D12, not counted twice; the plan names only 36 distinct). CDTWL freeboard becomes the 20th when R14h x3 pass in two separate starts on the installed build (first in the full re-test lines). Tim-confirmed by hand: recorded by CE 03 (H1 onward).
2. **Pilot-critical bugs closed: 0 of 60** (list: areas\PILOT_CRITICAL_TEST_LIST_29OCT.md). The robot can prove 2 now (P01 BUG-1194, P02 BUG-1140, drafts in cases\drafts_pilot_29oct); the engineering fixes (BUG-905, 1097, 1095, 1091, 1088) are proved by Codex looks H1, H7, H8, not the robot.
3. **Carpark in-progress 47:** none fixable today (areas\CARPARK_RETEST_TRIAGE_29OCT.md; 8 K-series tests drafted in cases\drafts_carpark_29oct; results go to CE 05 to record).

## 2. Live things and who owns them

1. **Gate:** HOLD_ROBOT.flag is IN PLACE (I own lifting it, only after CE 01 confirms Civil 3.0.86 / Manager 1.1.86 installed and DLLs re-read). STOP_CHAIN.flag is CE 01's (removed by CE 01 when the C-76 payload report lands, before chain_install_c76). No AutoCAD was running at 17:11 (Tim closed it). Payload 112 (Team job, started 12:49, waits for no AutoCAD) is finishing; then chain_install_c76 (CE 01).
2. **Lanes:** disk_guard.ps1 alive (pid 35468, started 16:52 by the lanes task; it has been killed from outside twice, cause not proven); chain_robot_standing down because of STOP_CHAIN.flag; Codex supervisor correctly off. Windows task "CE desk lanes at logon" (logon trigger plus a 30-minute time trigger, Tim's account, runs desk_jobs\start_lanes.ps1; undo: schtasks /delete /tn "CE desk lanes at logon" /f). start_lanes.ps1 never starts the Codex supervisor while acad.exe runs, HOLD_ROBOT.flag exists, a robot job runs, or ROBOT_QUEUE has an undone job.
3. **Monitor** bzq3y65gp (30 minutes, re-arm) watches chain_install_c76.log and the payload report. **Cron** 0255b561 (19 and 49 past each hour, session-only): the 30-minute check; delete it when no test job is pending (Tim's rule 11).
4. **Running Team jobs of mine:** none at 17:19 (all five 16:26 Opus jobs finished). **Team meter** 5-hour 72 percent (resets 20:00), 7-day 61 percent (resets Sat 14:00): NO new Team jobs until the payload report or 20:00; keep the 5-hour window under about 85 percent. Max weekly 90 percent: no new Opus Agents above 92.
5. **Robot queue file** (desk_jobs\ROBOT_QUEUE.txt, in order): tester_run77 (redundant after the C-76 full pass: mark done at queueing time), tester_run79 (P01 P02), tester_run78 (apply staged edits and run, then batch-4 drafts). NOT yet in the queue: tester_run80_c76_proofs (the C-76 proofs then the FULL 66-case pass on 3.0.86, about 49 starts, about 8h15, spec C:\ce-fx\c75regrade3\spec_c76.txt, N32 and N33 reordered early), tester_run81_full_retest (reusable full pass for Sat 31 Oct on C-77, Tue 3 Nov on C-78, Sat 7/8 Nov, Sat 14/15 Nov), tester_run82_lunch_helper_test. Each job reads the INSTALLED build at its start (chain3.ps1 resumes after a restart, aborts if the build changes).
6. **Codex conveyor notes** (desk_jobs\CONVEYOR_QUEUE.txt): all looks are '#HOLD ' lines (G3 G7 G4 H1 to H6 G6 G5, A1 C1 C3 C6 for 3.0.86; H7 H8 wait for the fixes); order note written at 16:00: robot first, Codex after the queue is empty and outside Tim's hours; Codex weekly about 13 percent, cap 30 Thu from 17:53, 44 Fri, 58 Sat.
7. **Lunch helper** (Tim's instruction: at 14:00 and 17:30, if AutoCAD is open and the PC idle 5 minutes, save everything, close it; reopen at 15:00 and 08:30 next working day): desk_jobs\lunch_window.ps1 written, 76 of 76 offline checks, NOT registered; the four weekday tasks are registered only after tester_run82 passes. Reopen time after 17:30 is my assumption, asked as QUESTIONS item 55.

## 3. Next steps in order

0. (17:41 addition) Cup Day fallback: Tue 3 Nov full re-test on C-78 only if C-78 is installed by Mon 2 Nov 21:00, else on C-77; C-77 install Fri 30 Oct evening is about 70 percent; C-76 payload report expected 17:50 to 18:15.

1. When CE 01 messages "3.0.86 installed and DLLs re-read" (or the Monitor shows INSTALL VERIFIED): read the DLL ProductVersion yourself (Civil 3.0.86, Manager 1.1.86), mark tester_run77 done (write tester_run77_regrade_part3_cdtwl_first.txt.done), put tester_run80 FIRST in ROBOT_QUEUE.txt (edit with PowerShell, not printf), remove HOLD_ROBOT.flag, make sure STOP_CHAIN.flag is gone (CE 01's) and that chain_robot_standing is running (run start_lanes.ps1), set CE_RUNNER_TIM_AWAY only if Tim's absence is confirmed (the runner refuses AutoCAD before 17:30 and in his weekday hours otherwise). Tell CE 00 and CE 07 when the pass starts and each hour what it reached (CE 00 asked for hourly progress).
2. Read each run's report as it lands; a regression is reported first. Send results to CE 05 for the carpark. Opus case reviews of each finished run (Team, after 20:00 for headroom).
3. After the pass: run79, run78, run82; then Codex looks when the queue is empty; register the four lunch tasks only if run82 passes.
4. Pending reviews not yet started: independent Opus review of areas\PILOT_RUNNER_CHANGES_AND_DRAWINGS_29OCT.md; the 'More...' allow-list change (reviewed GO) is applied to the live driver only after 17:30 with AutoCAD closed, with .pre backups (unapplied).
5. Waiting on Tim via CE 04: QUESTIONS items 55 (reopen time), spare 2027 PC and licence seat, BUG-1088 sizing rule, D13 hand-placed label (item 19).

## 4. My mistakes this stretch (each fixed)

1. Guessed times in the desk log several times (corrected; I now read the clock).
2. Used printf with backslashes in a queue file (tabs in paths; fixed with PowerShell).
3. start_lanes.ps1 counted the 14:00 to 15:00 lunch window as free while Tim's AutoCAD was open (fixed: never while acad.exe runs, the hold exists, or the robot queue has work).
4. Put the 30-minute repeat only on the log-on trigger, so it never repeated (fixed with a time trigger).
5. Started a Team job on scope that Tim's answer had just removed (stopped by its own pids and restarted narrower).
6. Not my mistake but a lesson: C:\CE_PLAN is one shared checkout, so my push carried CE 01's unpushed commit whose log line named the drawing Tim had open; the leak-scan stopped it, the four unpushed commits were squashed (tree identical, nothing leaked). Never write the name of a drawing or job Tim has open into a file or message.
