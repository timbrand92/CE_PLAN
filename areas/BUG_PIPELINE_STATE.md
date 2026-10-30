# Bug pipeline state (latest state only; CE 01 rewrites this file, it keeps no history)

**OWNER CHANGE, Fri 30 Oct ~20:00 PC clock: CE 05 (Carpark, bug intake and bug pipeline) now owns this pipeline** (intake, ordered queue, launching fixes), as set by CE 00 for Tim's ruling. CE 01 stopped its 17/37/57 launch check. Job q1 (chain_fix_g46, pid 77036) keeps running for CE 05 to adopt. CE 01 keeps the in-flight items until their PRs land (c87a, c87b, c92a, c93a, c95a, Max agents B-029b and B-028), plus trains, finalizers, payload, installs and the B-number register (CE 05 sends a B-number request per new fix PR). CE 05 should take over this file.

Approved by CE 00 Fri 30 Oct 2026 for Tim's ruling "try to complete everything in the bug document" (decisions\2026-10-30_TIM_COMPLETE_ALL_BUGS.md). Any new CE 01 session resumes from this file.

1. **Last launch:** Fri 30 Oct 19:05 PC clock, job q1 (chain_fix_g46 pid 77036, Team Sonnet, read-only) still running at the CE 05 check of 19:22; it has written its FOR TIM section (134 bugs ready to build: 61 Civil or Manager, 73 Structural) but not yet the full ordered queue. CE 05 launched nothing at 19:22 (queue not written). Guards at 19:22: Team 5-hour 29, Team 7-day 87; Max 5-hour 10, week 7; C: 52 GB free; no STOP_CHAIN.flag.
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
