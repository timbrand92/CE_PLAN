# Bug pipeline state (latest state only; CE 01 rewrites this file, it keeps no history)

**OWNER CHANGE, Fri 30 Oct ~20:00 PC clock: CE 05 (Carpark, bug intake and bug pipeline) now owns this pipeline** (intake, ordered queue, launching fixes), as set by CE 00 for Tim's ruling. CE 01 stopped its 17/37/57 launch check. Job q1 (chain_fix_g46, pid 77036) keeps running for CE 05 to adopt. CE 01 keeps the in-flight items until their PRs land (c87a, c87b, c92a, c93a, c95a, Max agents B-029b and B-028), plus trains, finalizers, payload, installs and the B-number register (CE 05 sends a B-number request per new fix PR). CE 05 should take over this file.

Approved by CE 00 Fri 30 Oct 2026 for Tim's ruling "try to complete everything in the bug document" (decisions\2026-10-30_TIM_COMPLETE_ALL_BUGS.md). Any new CE 01 session resumes from this file.

1. **Last launch:** Sat 31 Oct 00:55 PC clock: s2 (Structural batch S-2: BUG-1146, 1147, 1159; chain_fix_g81) on Team, CE 00 allowed ONE now; a second only if Team week is at or under 95 at the next reading, stop at 97. Done: v1 read-only check (36 of 40 still real, 3 already fixed, 1 cannot tell), s1 (all three already fixed, no PR). Next: s3.. in tier order; Max from about 09:30; p18 (g74) after the Team reset 14:00. Team 5h 40 / week 92 at 00:41.
2. **Queue:** empty until q1 writes the ordered build queue. Then the check-in launches the next item. Already in flight before the pipeline: c87a (B-011), c87b (BUG-1091), c92a (#1871), c93a (#1873), c95a (#1875), Max Sonnet agents B-029b (#1874, worktree c79f) and B-028 (BUG-587, worktree c79e, started 19:55).
3. **Guards, checked at every launch (read C:\CE_PLAN\desk_jobs\team_usage.ps1, exact; USAGE.json is hourly and can be stale):**
   1. Until Sat 31 Oct 14:00: Team 7-day under 99 and Team 5-hour under 85.
   2. After the reset: Team 7-day at most 15 points per calendar day (about 100 by the next Saturday) and Team 5-hour under 85.
   3. Builder work runs on Team first. RULE 19 (Tim 30 Oct 19:45, "using max subscription is perfectly fine, the single rule is to manage weekly usage, i want it to keep moving"): NO cap on concurrent Max agents, no reserved Max slot. Max pace: week at or under about 6 percent plus 14 points a day (about 20 Sat evening, 34 Sun, 48 Mon, 62 Tue, 76 Wed, 90 Thu, 100 at the Fri 6 Nov 13:00 reset) and Max 5-hour under 90 (read mcp__ccd_session_mgmt__get_usage). Max read Fri 30 Oct ~19:50: 5-hour 7, week 6.
   4. The bug pipeline moves to CE 05 (intake and queue) when CE 05 messages CE 01; CE 01 keeps trains, finalizers, payload and installs.
   5. Two build slots in total; at most 4 job launches an hour; C: free space over 8 GB; no desk_jobs\STOP_CHAIN.flag.
4. **Rules that never change:** DRAFT PRs behind Settings switches ON; no PR enters a train without CE 00's Opus pre-review and the finalizer; CE 05 is the only writer of BUG_CARPARK.md; nothing marked fixed until confirmed or accepted; installs only through the install chains with the undo stated; Rule 14 area-plus-smoke re-test.
5. **How a launch is made:** copy desk_jobs\chain_fix_g46.ps1 to the next chain_fix_gNN.ps1 with the job key replaced, job text in desk_jobs\team_fix_<key>.txt, started through WMI Win32_Process Create. No new script type.
6. **CE 00 backstop:** CE 00 checks at each hourly check that the last launch above is under 90 minutes old and wakes CE 01 if not.
7. **Updated:** Fri 30 Oct 19:05 PC clock.

## ONE bug count (CE 05, Fri 30 Oct 2026 ~19:50 PC clock, 1,205 entries, counted by the last Status line of each entry)

Classes, each defined once. Installed is never fixed.
1. **Confirmed or accepted: 34** (2.8%). Status says Tim-confirmed (6, plus BUG-168) or FIXED (Codex-accepted or Claude-accepted) (27).
2. **Fixed in source or fixed long ago, not confirmed by the new rules: 49** (4.1%). Status starts FIXED with no acceptance word (47), plus BUG-096 and BUG-097 (locally corrected). These are NOT counted as accepted.
3. **Fix installed, waiting to be confirmed: 359** (29.8%). Status says the fix is installed (357, with "not installed" statuses excluded), plus BUG-402 (awaiting Tim confirm) and BUG-476 (seen by Codex).
4. **Fix drafted or built, not installed: 47** (3.9%).
5. **In progress: 48** (4.0%).
6. **Open, no fix: 664** (55.1%). Includes 2 on hold and BUG-788, 418, 409, 401, 392, 361, 620.
7. **Closed, not a fix: 4** (0.3%): BUG-359 (driver), BUG-040 (retired), BUG-163 (not reproduced), one won't fix.
Total 34+49+359+47+48+664+4 = 1,205.

Why this differs from the two earlier counts: CE 01 (about 19:30) used 336 installed, 32 drafted, 698 no fix; job q1 (19:24) used 345 installed, 72 built or drafted, 692 no fix. Mine matches the Status text with one rule everywhere; differences are mostly entries whose Status line mentions "installed" or "PR" later in the sentence. Entries that had no `**Status:**` line at the start of a line (about 53, mostly BUG-3xx/4xx written with the Status inline) are now read from the inline Status. Method script (throwaway): scratchpad count.py; limits: keyword rules, the 13 free-text statuses were classified by hand (above), no entry was changed.

## Standing launch rules added by CE 05 (Fri 30 Oct 2026 ~22:55 PC clock)
1. **Build priority (CE 00 ruling, via CE 01, commit e782659c):** every build wave runs at BelowNormal priority with -m:2. Every NEW job text carries -m:2 on each dotnet build and dotnet test; every NEW lane script copies the Start-Process line from chain_fix_g70.ps1 (PassThru, PriorityClass BelowNormal, WaitForExit).
2. **Lane script names:** mine are chain_fix_g47 to g59 and g70 upward; CE 01 uses g60 to g69. Check the name is free before writing.
3. **Every job:** isolation variables (CE_STRUC_SUITE_APPDATA_ROOT, CE_LOG_DIR_OVERRIDE, TEMP, TMP on C:\ce-scratch\<key>), 12 GB free-space check, before and after listing of the real settings files including %APPDATA%\TIM_CE_CADTOOLS, no Manager tests until B-062 (#1884) lands, Structural jobs start from origin/claude/rel-20261026s.
4. **Robot writes:** a robot case with a SETTING line legitimately changes CD_Settings.json for a few minutes; the guard restores the contents (the date may read wrong: told CE 00).

## Structural batches, READY but NOT launched (CE 05, Sat 31 Oct 2026 ~00:15 PC clock)
Source: areas\STRUCTURAL_BATCHES_30OCT.md (Haiku keyword sort: 16 buildable batches of 43 entries, 20 NOT-A-BUILD). Job texts desk_jobs\team_fix_s1.txt to team_fix_s16.txt (keys s1..s16), lane scripts chain_fix_g80 (s1) to chain_fix_g95 (s16), all isolated (C:\ce-scratch\sN), -m:2, BelowNormal, 12 GB check, base origin/claude/rel-20261026s. B numbers: ask CE 01 before launching each batch.
1. **Launch plan (CE 00 ruling 30 Oct):** Max once the Max line catches up (about 08:00 Sat), Team after the reset Sat 14:00; a single job earlier only if Team shows room. At most 2 Max builders at once.
2. **Order:** s1 first (tier 2, FoundationService.cs), then batches that do not share a file with a running one. Shared files: FoundationService.cs (s1, s13, s14: run s1 first), UserSettings.cs (s13, s14, s16), CeTextService.cs/FstMemoryService.cs (s2, s8), ExcelMTextService.cs (s7, s14), ReoBarService.cs (s12, s15), TimberSubfloorService.cs (s8, s15), SupportBlockCommands.cs (s3, s15), CeMemberPrompts.cs (s5, s7), SbeamSelectionPlanner.cs (s6, s7), CeSettingsDialog.xaml (s13, s16). Also p18 (Structural twins of #1893/#1894) is ready (chain_fix_g74), launch after the Team reset.
3. **Pending decisions that change the queue:** CE 04 questions on BUG-1262, BUG-1267, BUG-822, the bracing UCS switch; CE 01's B-062 test isolation (#1884) before any Manager test.
