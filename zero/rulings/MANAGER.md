# Current rulings: Manager (updates, health, office lists, job link)

Current rulings as of 20 Nov 2026 (Melbourne), from decisions D-001 to D-383 (D-230 to D-297 were read and none bears on the Manager; of D-298 to D-383 only D-337 bears on it). If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### What the Manager does

1. **Four jobs:** updates and version, health and fault report, office lists, job link; no drawing tools (D-204, TA-011, TA-012).
2. **One admin page that only Tim sees:** each PC's version, faults this week, and one "approve this update for everyone" button; no canary rollout or policy pages (D-204, TA-013).
3. **Updates:** a new version is offered when AutoCAD starts and installs with one click, with no administrator rights; going back is one click (D-028).
4. **Statistics, wider admin control and "a better overall system" are future ideas,** not first release (D-205).
5. **In the first release as a small Manager** (THE_PLAN section 3 change note of 18 Nov, the planning chat's reading of D-204; D-204 itself does not say "first release"). **Paused by D-337 (19 Nov):** "lets focus on a release for everything needed for one job, pause the rest for now and table it under future planning or the carpark and make sure we get back to it later"; the Manager is not among the nine parts of the one-job release (D-338) and waits in `PARKING_LOT.md` P-09.

### Job tracking

6. **Job tracking belongs in the office's Job Manager program,** not in a second tracker inside the AutoCAD plug-in; the plug-in hands it what only the drawing knows (stage reached, what was issued and when, time on the drawing, assumed values still open) and shows it back in the Manager window (D-071).
7. **What job tracking covers:** where each job is up to, what was issued and when, time spent on each job, and what each job is waiting on (D-045, answering D-044).
8. **Time on a job is counted automatically,** and the person can check and correct it (D-072).
9. **Who sees hours:** everyone sees job totals; only Tim sees who (D-073).
10. **Waiting on something that is not a value in the drawing:** a short note on the job in the Manager; assumed values in the drawing still flag themselves (D-074).

## Changed along the way

1. **Job tracking as a Manager feature inside the plug-in (D-044, D-045, 16 Nov) became a hand-over to the Job Manager program (D-071, 16 Nov evening).** Not marked superseded; the later answer is read as governing where tracking lives.
2. **"Manager changes" were not in the first release (THE_PLAN section 3, 16 Nov); a small Manager is now in (THE_PLAN change note, 18 Nov, after D-204).**
3. **The tab "CE TOOLS&MANAGER" (D-200) was named "CE Tools" (D-208, 18 Nov).**
4. **The small Manager in the first release was paused by D-337 and D-338 (19 Nov).**

## Still open on this subject

1. **How the plug-in and the Job Manager program join:** not designed, and the Job Manager's own plan has not been read by the planning chat (D-071; THE_PLAN section 7 item 6). Waits on: the planning chat.
2. **Whether the Job Manager hand-over later feeds council, permitted discharge and letter date** (INPUT_AUDIT section 3). Waits on: Tim.
3. **The Manager's typed name** (FUNCTION_MAP section 4). Waits on: Tim.
4. **Where the Manager button sits:** "one button at the end of the middle tab", now CE Tools (interview section 5); not ruled. Waits on: Tim.
5. **Whether the small Manager is in the first release in Tim's own words:** the plan says so after D-204; D-214 confirmed "all 18" shared tools but did not name the Manager. Waits on: Tim.
6. **What a fault report may carry** (OBSTACLE_COURSE OQ-08, OC-25). Waits on: Tim.
7. **Keep writing usage, machine and failure records or not:** recommendation keep failures plus anonymous counts (FM-173). Waits on: Tim.
8. **Open-logs button folded into the fault-report window** (FM-163). Waits on: Tim.
9. **Private-text scrub (MG-02) "worth keeping", the office-lists administrator page (MG-03) does not exist, hand-over contents (MG-04) rest on D-071 to D-073** (interview MG-01 to MG-06). Waits on: Tim.
10. **Dropped Manager pages (FM-156, FM-161) listed so Tim sees them go** (FUNCTION_MAP section 4A). Waits on: Tim.
11. **AutoCAD side of update and rollback not proven** (trial 9: file mechanics PASS, AutoCAD side BLOCKED by the registry) (THE_PLAN section 6a). Waits on: a test.
12. **Future ideas FI-01 to FI-04 (statistics, admin, joint-label learning) to be filed in the ideas file with their own numbers** (interview). Waits on: the planning chat.

## Where the detail lives

1. `DECISIONS.md` D-028, D-044, D-045, D-071 to D-074, D-204, D-205; added 20 Nov: D-337, D-338; `PARKING_LOT.md` P-09.
2. `design\TOOLS_AND_MANAGER_INTERVIEW.md` (A-11 to A-13, MG-01 to MG-06); `design\FUNCTION_MAP.md` FM-156 to FM-173.
3. The Job Manager project per `C:\TimOS\ROUTER.md` (not read).
