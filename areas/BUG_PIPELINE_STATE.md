# Bug pipeline state (latest state only; CE 01 rewrites this file, it keeps no history)

Approved by CE 00 Fri 30 Oct 2026 for Tim's ruling "try to complete everything in the bug document" (decisions\2026-10-30_TIM_COMPLETE_ALL_BUGS.md). Any new CE 01 session resumes from this file.

1. **Last launch:** Fri 30 Oct 19:05 PC clock, job q1 (refresh of the whole-file triage and the ordered build queue), chain_fix_g46.ps1 pid 77036, Team Sonnet, read-only. Output: a section appended to areas\BUG_REGISTER_TRIAGE_2026-10-24.md.
2. **Queue:** empty until q1 writes the ordered build queue. Then the check-in launches the next item. Already in flight before the pipeline: c87a (B-011), c87b (BUG-1091), c92a (#1871), c93a (#1873), c95a (#1875), Max agent B-029b (#1874).
3. **Guards, checked at every launch (read C:\CE_PLAN\desk_jobs\team_usage.ps1, exact; USAGE.json is hourly and can be stale):**
   1. Until Sat 31 Oct 14:00: Team 7-day under 99 and Team 5-hour under 85.
   2. After the reset: Team 7-day at most 15 points per calendar day (about 100 by the next Saturday) and Team 5-hour under 85.
   3. Builder work runs on Team first. Max Sonnet only when Team is over a guard, and at most ONE Max builder while a CE 00 or CE 02 review runs (15-minute notice).
   4. Two build slots in total; at most 4 job launches an hour; C: free space over 8 GB; no desk_jobs\STOP_CHAIN.flag.
4. **Rules that never change:** DRAFT PRs behind Settings switches ON; no PR enters a train without CE 00's Opus pre-review and the finalizer; CE 05 is the only writer of BUG_CARPARK.md; nothing marked fixed until confirmed or accepted; installs only through the install chains with the undo stated; Rule 14 area-plus-smoke re-test.
5. **How a launch is made:** copy desk_jobs\chain_fix_g46.ps1 to the next chain_fix_gNN.ps1 with the job key replaced, job text in desk_jobs\team_fix_<key>.txt, started through WMI Win32_Process Create. No new script type.
6. **CE 00 backstop:** CE 00 checks at each hourly check that the last launch above is under 90 minutes old and wakes CE 01 if not.
7. **Updated:** Fri 30 Oct 19:05 PC clock.
