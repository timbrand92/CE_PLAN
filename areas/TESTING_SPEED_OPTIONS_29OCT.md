# Testing speed options: how to raise the testing number faster, without Tim, without touching his work PC (29 Oct 2026)

Job `CE_ACAD / robot / plan / 10` (CE 02 Robot and Codex Testing, Team, Opus). Research and design only. Written Thu 29 Oct 2026, 10:33 to about 11:15 Melbourne (PC clock). Nothing was started in AutoCAD, the core console, the runner, the driver, the settings guard or the lock. Nothing was installed and no Windows setting was changed. Scratch work: `C:\ce-fx\speed\`.

## ANSWER FIRST

1. **Robot hours are not the main limit any more.** From today the robot keeps about 128 free hours a week on your PC. At its measured pace that is roughly 800 robot sessions a week. What holds the count at 19 of 40 is mainly the checks that do not exist yet, and the full re-test after every install.
2. **The cheapest gain is cutting dead time.** A third of the robot's clock goes on a fixed 3-minute wait with AutoCAD closed. Shortening that safely gives about 40 percent more sessions an hour (estimate).
3. **The biggest gain is the spare work PC you already offered on 17 Oct.** It is set up from a prompt that is already written. One open question decides it: can that PC's AutoCAD sign in without signing you out?
4. **A hidden "no screen" robot, or one that waits until you leave your desk, does not help on your PC.** AutoCAD will not start a second, hidden copy while yours is open. The robot also refuses to run beside your AutoCAD, so it cannot share it.

## FOR TIM

1. **What I recommend, in order: cheap and safe first.**

2. **Step 1: shorten the robot's wait between sessions.** Half a day of work, nothing needed from you.
   - **Now:** after each session the robot sits for 3 minutes with AutoCAD closed, every time. That is 18 of the last 56 hours.
   - **After:** it waits about 30 seconds once it has proved its own AutoCAD has gone and your settings files are back as they were. It keeps the full 3 minutes only when an install is queued.
   - **Example:** last night's leftover 12 cases (the pit and pipe basics, the freeboard checks) need about 2 hours as things are. After the change, about 1 hour 25 minutes (estimate).

3. **Step 2: stop the robot lining up the mouse so often.** Half a day, nothing needed from you.
   - **Now:** about one session in five spends 4 extra minutes lining up the mouse with the screen before it starts. That cost about 5 hours over three days.
   - **After:** all the mouse-click checks go into fewer AutoCAD starts, so it lines up once per start instead of once per check.
   - **Example:** the pit-move check and the pipe-label-on-a-leader check share one start, saving one 4-minute line-up.

4. **Step 3: after an install, re-test only what the fix touched.** One to two days, plus **one yes or no from you or CE 00**.
   - **Now:** every install re-runs all 65 accepted checks twice. That takes 6 to 8 hours, and there were six installs in 56 hours.
   - **After:** a fix to the pit schedule re-runs only the schedule checks, about 1 hour (estimate). A fix to something everything uses, like settings or labels, still re-runs the lot. A full re-test still runs every weekend and before any release to Max.
   - **Your call:** today a tool counts as accepted only when its checks passed on the build that is installed. This step means a tool the fix never touched keeps its earlier pass until the weekend re-test. Recommended: yes, with the weekend full re-test as the safety net.

5. **Step 4: switch on the spare work PC as the test PC.** One to two days of set-up, about 30 minutes of your time.
   - **What you do:** switch it on and log in. Then paste the prompt `C:\CE_PLAN\04_REFERENCE\TEST_PC_START_PROMPT.md` into Claude on it, and sign in to GitHub and Codex yourself when asked.
   - **The one check:** in AutoCAD on that PC, look at the name at the top right. If it is your own Autodesk login, the robot there might sign you out of your own AutoCAD while you draft. Ask the office admin whether that PC has its own licence.
   - **Effect:** the robot runs all day and all night there, about 168 hours a week. If the robot moves there for good (the 17 Oct plan), that is 30 percent more robot hours than the 128 left on your PC. If both PCs run, it is more than double (estimate).
   - **Example:** a fix installed at 10 am gets its two-start proof by lunch on the test PC, instead of waiting for 5:30 pm on yours.

6. **Step 5 (only if step 4 fails on the licence): a virtual PC inside your PC.** Two to three days, and three things from you.
   - **What you would do:** let the office admin turn on Windows' built-in virtual-machine feature, which needs a restart. Supply a second Windows licence. Confirm a second AutoCAD licence.
   - **Problem:** the virtual PC has no proper graphics card, so AutoCAD in it will be slow and may look different. Mouse-click and picture checks may not match your screen.

7. **What I do NOT recommend now.**
   - **A hidden "no screen" AutoCAD robot:** AutoCAD refuses to start one while yours is open, so it cannot run in your hours on your PC. Only 9 of the 85 checks could use it anyway.
   - **Running the robot when you step away from your desk:** your AutoCAD stays open all day (today it started at 9:14), and the robot cannot share it. It would add very little and could grab the mouse just as you sit back down.
   - **Cloud PCs and Autodesk's cloud runner:** they cost money per hour and still need a licence. The cloud runner cannot open CE's windows. Worth looking at later for testing older AutoCAD years, not for the count.

8. **The honest bit about the number.** Robot speed alone will not take 19 of 40 to 40 of 40.
   - About ten everyday tools are waiting on a check that cannot be written yet. Examples: selecting a tab in the New Pipe window, reading which way a label faces, the "More..." button, a drawing with a stored survey, and some of your Monday questions.
   - Steps 1 to 4 make each new check land in hours instead of a day. The next count rises come from writing those checks and the small robot additions they need.

9. **What you need to do today:** nothing. Two things wait for your Monday list: the yes or no in step 3, and switching on the spare PC in step 4.

---

## Technical detail

### 1. Throughput audit (27 Oct 00:05 to 29 Oct 08:14)

Sources: 301 run reports `C:\CE_PLAN\areas\runner-reports\RUN-20261027-0005` to `RUN-20261029-0802` (.json), `ledger.json` (753 rows for these days), `release-v3-colleagues-RUNNER_C75_FIXES_REGRADE_REPORT.md`, `C:\ce-fx\c75regrade3\chain3.ps1`, `C:\CE_PLAN\desk_jobs\chain_robot_standing.ps1`, `case_runner.ps1`, `acad_driver_v3_session.ps1`. A Sonnet helper did the parsing; its tables are in `C:\ce-fx\speed\audit\` (all.tsv, sess2.tsv, gaps.tsv, audit.md). Measured unless marked ESTIMATE.

1. **Totals:** 301 runs, 340 sessions (4 BLOCKED), 797 case results: 505 PASS, 271 FAIL, 21 BLOCKED. Ledger: 506 PASS, 247 FAIL. 245 of the 247 ledger FAIL rows are failing twins failing as designed (from_check); 2 are real failures.
2. **Wall clock per session (start of session to finish, non-blocked):**
   - single-case sessions n=145: min 58 s, median 227 s, p90 523 s, max 646 s (median 203 s without calibration, 492 s with);
   - pack sessions n=191: min 99 s, median 317 s, p90 695 s, max 1181 s (304 s without calibration, 571 s with);
   - cases per pack: median 3, p90 5, max 22; a case's own time: median 74 s, p90 205 s.
3. **Split of a session (medians):**
   - **AutoCAD start + CE load + fixture copy opened + settings guard set:** recorded only as one lump, 33 s (n=262, p90 40 s). The parts are NOT recorded separately (the v2 launch returns launch_seconds but the report drops it). ESTIMATE, no data behind it: guard set a few seconds, launch to ready about 25 s.
   - **Pixel calibration** (only sessions holding a pointer case): the lump becomes about 275 s (72 of 336 sessions, 21 percent). ESTIMATE 240 s each, about 4.8 h in total.
   - **Opening the fixture copy:** inside the lump; between cases in one session the runner reopens a fresh copy (`Invoke-CaseFreshDrawing`), inside the case overhead below.
   - **The steps:** 93.3 percent of case time (72,318 of 77,507 s). Biggest verbs: CE window button presses 25 percent, typed text 22 percent, Esc at a prompt 9 percent, Settings-window sets 9 percent, sleeps 7 percent, waits 5 percent.
   - **Per-case overhead outside the steps (fresh copy, checks):** median 8 s.
   - **Settings guard restore + quit + clean-end checks:** one lump, median 21 s (p90 47 s, max 342 s).
   - **Report writing:** 0 to 3 s (file times). Negligible.
   - **The 3-minute gap:** chain3 waits for no acad.exe (up to 5 min) then sleeps 180 s; the standing chain needs six 30 s polls with AutoCAD absent. Measured finish-to-next-start: median 196 s (p25 182, p90 214, n=300). 300 gaps = 18.4 h of the 56.2 h span (33 percent); 15.0 h is the bare 180 s.
   - **Chain and launcher overhead:** median 16 s above the 180 s (ESTIMATE: gap minus 180), plus four stalls over 20 minutes (3141, 1724, 1364, 1340 s) and 19 waits for AutoCAD or the lock over 60 s (251 min, max 3613 s). The standing chain also starts a fresh `claude -p` (Sonnet) job per robot job; the 29 Oct regrade lost its robot at 05:29 when the Team login expired.
4. **Where the 56 h went:** steps about 20 h (36 percent); gap 18.4 h (33 percent); startup 8.3 h (of which calibration about 4.8 h ESTIMATE); waiting to start 4.2 h; quit and clean-end 2.6 h.
5. **Sessions per hour now:** 6.3 per active clock hour (median per day 5, 6 and 7; best hours 11 and 12). Ceiling from a typical pack cycle (33 + 240 + 21 + 196 s, about 490 s): about 7 per hour. Windows: Tue 27 overnight-partial 4.6, Tue day 5.5, Tue night 7.3, Wed day 6.9, Wed night 5.8. Cases per hour range from 9 to 24 depending on pack size.
6. **Robot time lost from today:** Ruling E (17 Oct) let the robot run in Tim's hours until 29 Oct. Of the 340 sessions, 105 (31 percent) ran in the two daytime windows (W2 and W4). From today RULES 1.8 applies again: 168 - 40 = 128 free hours a week.
7. **Sessions to Claude-accept one case:** on the accepting build, 36 of 43 case families with a review used exactly 2 sessions (the failing twin rides in the same pack start); 6 used 3 or 4. From a case's first ever run to its second PASS on one build: median 3 starts (2 for 17 families, 3 for 18, 4 for 4, 5 for 2, 11 for 1). Controls are separate single-case starts.
8. **Regrades:** six builds in 56 h (3.0.80 to 3.0.85). The 3.0.84 full regrade took 7.6 h (28 Oct 15:31 to 23:08, 33 runs). The 3.0.85 regrade ran 3.7 h and reached 53 of 65 counted cases; the report puts a full set at about 6 h, the remaining 12 at about 2 h.

**What can be cut safely, and what cannot:**

1. **Gap: SAFE TO SHORTEN, with conditions.** The session already proves a clean end before it finishes: its own AutoCAD gone, lock free or stale, settings guard clear, settings fingerprints equal, profile variables restored (`Stop-V3Session`, `end.clean`). The 180 s on top exists so installs and payload tests can find AutoCAD closed (standing chain comment). Proposal for the runner and chain owners:
   - start the next session after `end.clean = true` plus a 30 s settle, with acad.exe and accoreconsole.exe absent at two readings 10 s apart (the REL-09 "twice" habit);
   - keep the full 3 minutes (or longer) only when an install job or `HOLD_ROBOT.flag` is pending, so installs ask for the gap rather than every session paying for it;
   - if `end.clean` is false, keep today's behaviour.
   Effect: cycle about 490 s to about 340 s, ceiling 7 to about 10.6 per hour; achieved 6.3 to about 9 (ESTIMATE, assumes the same stall rate).
2. **Calibration: SAFE TO AMORTISE.** The runner calibrates only when a session holds a pointer case (`$needsPointer`). Group pointer cases into fewer, larger starts (they already share fixture DRV1_B1 and mostly no SETTING line). Up to about 4.8 h per 56 h back (ESTIMATE). Reusing a stored calibration across starts is NOT recommended: a moved or rescaled window would put a click in the wrong place, and the driver already refuses a reading that belongs to another AutoCAD.
3. **More cases per start where SETTING lines are identical: ALREADY DONE, could go further.** The runner already groups by fixture + slot + SETTING (`Invoke-CasePack`, line 379). All 19 class (a)+(b) main cases use DRV1_B1 with no SETTING (two starts today: slot launch and slot fresh). Larger packs cut starts, but one crash then voids more cases, and CE's "last values used" file and in-memory state carry between cases in one start. Keep the two-fault stop and cap packs at about 8.
4. **Targeted re-runs after an install: WORTH IT, MEDIUM RISK.** Mapping rule proposed:
   - **Map:** each case lists the commands it types. Each command maps to the source files that hold its `CommandMethod` and the services it calls, built once by reading the code and kept in one file beside the cases. Today 148 `CommandMethod` entries sit in 84 files on `claude/rel-20261029a`.
   - **Rule:** a fix PR re-runs every case whose map holds a changed file. It runs ALL accepted cases when the PR touches the shared list: settings load and save, the label and text service, project data, Undo and transaction handling, the loader and start-up, the CE log, any `Shared` or `CE_SHARED` file, or more than about 10 non-test files.
   - **Safety net:** a full two-start regrade every weekend and before any colleague release. A tool keeps "accepted on build X" until the weekend regrade.
   - **Risk:** recent fixes mostly touch `Models`, `Services` and `Rules` (sampled: PR 1820 to 1837 change 2 to 11 files each). A file-level map will miss calls through shared helpers, so a regression in an "untouched" tool could stay hidden until the weekend. That is why the shared list forces a full regrade.
   - **Ruling needed:** this changes how the count carries across builds (Tim's 24 Oct rule says two passes "on the same installed build"; ledger item 26 already counts "each tool on its latest passing build"). A CE 00 or Tim ruling is needed before the count uses it.
5. **What cannot be cut:** the two separate AutoCAD starts per case, the failing twin and the independent review (Tim's 24 Oct rule); the clean-end checks and settings restore; the fresh drawing copy per case; the in-hours stop.

**After all four:** about 9 sessions an hour (ESTIMATE) and a typical regrade after a local fix of about 1 hour instead of 6 to 8. A night (17:30 to 08:30, about 14.5 usable hours) goes from about 90 sessions to about 130 (ESTIMATE). **Accepted cases per night** is then limited by case supply, not robot time: 7 drafts are waiting (N10, N30 to N35) plus their 7 twins, about 5 to 6 starts with packing. With the gap cut they would all have two-start results in one night with room to spare, and the reviews are the next queue.

### 2. GUI-free subset (case classification)

Method: a Sonnet helper parsed every case's STEPS, ASSERT and SETUP lines (text matching, nothing run); I spot-checked the verbs in `acad_driver_witness_v2.ps1`. Full list: `C:\ce-fx\speed\classification.md`.

**Verb physics:** `type` = COM SendCommand, no keyboard. Every read (getvar, ent-read, history-tail, log-read, ms-count and so on) = COM or file, no input. `ui2-*` and `ui-*` = Windows UI Automation on CE windows, no mouse. `esc-prompt` and `esc-key` = ONE REAL Esc key (keybd_event) after bringing AutoCAD to the front. `pt-click`, `pt-dblclick`, `pt-drag` and `pt-hover` = real mouse (SendInput). `capture` = window picture for a Codex look. The v2 "answer" route can send real digit keys, but no case uses it.

**Main cases (85 in `cases\`):**

1. **(a) typed command line + reads only: 9.** N01 (D18, D27), N12 (D15), N13b (BUG-1225 control, no review), N16 (D15), N24 (D20), R10 (C16), R12 (C41), R19b (D14), R23 (BUG-384).
2. **(b) CE window by UI Automation, no mouse: 10.** N02 (D16), N08 (D20), N09 (D21), N11 (C40), N15 (D20), N21 (D29), N26 (D27/C42), R07 (C14), R20 (D17), R38 (D21, D23).
3. **(c) real key or mouse: 60.**
   - real mouse (6): N05 (D09), N20 (D11), N25 (D09), R01 (D01), R08, R09;
   - only a real Esc, no window (21): N03 (D08), N04 (D07), N13, N13a, N13c, N13d, N14, N14a, R05, R21 (D28), R22, R26 (D26), R34, R34s, R34sn, R34so (D15), R35 (D26), R36, R36e, R37, R37b (D07);
   - real Esc plus windows (33): N06, N07, N17, N18, N19, N22, N23, N27, N28, N29, R02, R02b, R03, R04, R11, R13, R14, R14h x3, R15, R16, R17, R18, R19, R24, R28, R31, R32, R32b, R33, R39, R39b.
4. **(d) picture or Codex look: 6.** R06 (C12), R25 (D21, D23), R27, R29, R30, R40 (D28).
5. **Drafts:** 7 new cases in the draft folders (N10, N30 to N35), all class (c), plus 7 failing twins.
6. **controls\ (61):** all class (c). **variants\ (99):** 20 (a), 14 (b), 65 (c).
7. **Reviews:** 64 of the 85 main cases hold a CLAUDE-ACCEPTED-READY review (a 8 of 9, b 10 of 10, c 46 of 60, d 0 of 6).

**Accepted cases in class (a):** N01, N12, N16, N24 (part), R10, R12 (part), R19b, R23. The everyday tools resting wholly on class (a) are D14 (R19b) and D15 (N16, with R34a). D18, D27 and D20 also need a class (b) or (c) partner.

**Key finding:** 54 of the 60 class (c) cases are there only because of ONE real Esc key. If the driver sent that Esc without the real keyboard (for example a cancel through COM, which `deselect` already does with ^C^C and falls back from), those 54 would need no keyboard and no mouse. That is a driver change for its owner (not made here), and it matters most for idle mode (section 4). It does not make them core-console cases: 33 of them drive CE windows.

### 3. Headless runner (core console) for class (a)

1. **What exists:** `tools\headless-proof\Run-HeadlessProof.ps1` (+ `Modules\Drainage.HeadlessProof`) runs CE Civil's real services in accoreconsole 2027 with `/isolate`, sets CE's unified-host switch so start-up does not touch the live log, settings or telemetry (memory `accoreconsole-plugin-probe`, correction 23 Sep), and refuses to run if acad.exe is open. `C:\Tools\AcadProbe\run-probe.ps1` also refuses while acad.exe runs. The TH-01 harness (`Tests\CE.TestHarness*`) records SKIPPED when AutoCAD is open.
2. **The blocker, SEEN and recorded:** `docs\SMOKE_TEST_HARNESS_isolation_investigation.md` (19 to 22 May 2026). With Tim's AutoCAD 2027 open, accoreconsole fails with "Configuration file may be locked by another process" / "FATAL ERROR: Unable to Process Configuration File!", even with `/isolate`, `/useisolate` and `/autoisolate`. The cause traced was a machine-wide Autodesk named mutex. The 9 Oct options research repeats it. **So on Tim's PC the core console cannot run in his working hours while his AutoCAD is open.** I did not re-test this (forbidden today), and it is five months old; an AutoCAD update could have changed it. Unknown.
3. **Licence:** NOT established. The core console started under this PC's licence set-up when AutoCAD was closed (probe runs 10 Oct). The licensing files read today show a network-licence pointer to this same PC (`licpath.lic`: `SERVER localhost`, `ADSKFLEX_LICENSE_FILE 27080@localhost`, connection error -15 in `nlm-server-info.json`) and many "SSO returns invalid User login status" lines. I could not tell from the files which licence AutoCAD actually uses. Whether the core console takes a licence seat, and of which kind, is internal to Autodesk (RULES 12.5).
4. **What it would need:** a script per case (SECURELOAD 0, NETLOAD the Modern net10 CE DLL or the HeadlessProof assembly, the case's typed lines, QUIT Y); `/isolate` with a profile holding `TempDirectory` (it went missing twice before); the unified-host switch; reading results from the console text, a CE log in the run folder and the drawing (the TH-01 harness reads output DWGs with ACadSharp); a translator from case STEPS to a .scr.
5. **What breaks:** no CE windows, ribbon or WPF (class b to d out); no Idle event, so CE's deferred linking and anything done on Idle never runs (memory, 26 Sep; the B5 Undo fault class is invisible); interactive prompts behave differently from the editor; Undo and REDO as a drafter uses them are not proven. Whether a core-console PASS counts towards "Claude-accepted" (the rule says "two separate AutoCAD sessions") needs a ruling.
6. **Cost:** measured per-test wall from the 10 Oct probe file times: 34 to 49 s per accoreconsole process including the fresh copy (6 runs, 2 to 24 tests each). The isolated-profile step alone took 24 s and 129 s on two runs (23 Sep). That is no faster than the GUI robot's 33 s start plus 74 s per case. CPU and memory: not measured; ESTIMATE one core and well under the 1.06 GB that Tim's full AutoCAD uses this morning.
7. **Effort:** ESTIMATE 3 to 5 days for a case-to-script translator plus result reader. **First proof (3 cases):** N16 (COPY of a pit), R19b (erase a pit with several pipes), R23 (CDEDIT refuses on a locked pipe layer). All three are class (a), accepted, and have failing twins, so the core-console answer can be compared with a known robot answer.
8. **Verdict:** park it. On this PC it shares the robot's closed-AutoCAD hours and is not faster. Only 9 main cases (21 at most, if Esc moves to a script cancel) fit, and it cannot prove Idle-time behaviour. It is worth reviving on the spare test PC, or for AutoCAD 2022 to 2026 through Design Automation.

### 4. Idle mode (robot runs only when Tim has not touched the PC for N minutes)

**Design:**
1. A small watcher reads `GetLastInputInfo` every 5 s. **Trap:** the robot's own Esc keys and mouse clicks reset that same timer. The watcher must instead use a low-level keyboard and mouse hook and ignore events flagged as injected (`LLKHF_INJECTED`, `LLMHF_INJECTED`), or pause its timer around each robot input.
2. **Start condition:** no human input for N minutes, AND no acad.exe or accoreconsole.exe running, AND lock free, AND the screen not locked and not a remote-desktop session (the robot's real Esc and clicks fail on a locked or disconnected desktop).
3. **Stop:** human input seen, so within 2 s: kill only the robot's own AutoCAD (by the PID in the lock, never another acad.exe, as `Stop-V3Session` already does), throw away the test copy, release the lock, restore settings through the guard (restore by hash, after AutoCAD is gone), and mark the run VOID. A VOID run never writes a ledger PASS or FAIL. Its report says "stopped: Tim came back".
4. **N:** 15 minutes (recommended). 5 minutes catches reading a long email or a phone call at the desk; 30 minutes misses most short absences.

**Risks:**
1. **Half-written settings file:** a kill during CE's own settings write. The guard restores by hash only after the robot's AutoCAD is gone, and refuses to start the next session if the guard is not clear. Keep that, and never kill during the guard's own write.
2. **Focus stolen mid-click:** Tim moves the mouse just as the robot brings AutoCAD forward for an Esc. That Esc could land in Tim's window. The driver checks the foreground window belongs to its AutoCAD (`not_foreground`), but the gap between check and key press cannot be closed fully. Making Esc keyboard-free (section 2) removes most of it; the 6 mouse cases should never run in idle mode.
3. **Lunch window:** RULES 1.8 already makes 2:00 to 3:00 pm free (60 minutes, not 20; the brief's "20-minute lunch window" is not in RULES). The runner already refuses to start when the free time left is shorter than the session needs.
4. **Screen lock and remote desktop:** both stop real input. The watcher must not start then and must VOID if it happens mid-run.
5. **A void run that looks like a CE fault:** a killed AutoCAD can leave a recovery file or a "drawing not closed" line in the CE log. Every VOID must say so in its report, and the next session's checks must not read the previous session's log lines.
6. **The real blocker on this PC:** the runner waits until NO acad.exe runs, and the driver attaches to "the" running AutoCAD through COM (`GetActiveObject`), which would be Tim's if his is open. Tim's AutoCAD has been open since 9:14 this morning. So idle mode only helps when Tim has closed AutoCAD and walked away.

**Extra robot hours:** In-use hours are 40 a week (RULES 1.8: 5.5 h + 2.5 h a day). Idle mode gains only the part of those 40 hours where Tim is away for 15 minutes or more WITH AutoCAD closed. ESTIMATE 0 to 5 hours a week. The ledger cannot measure this; nothing records Tim's input or his AutoCAD hours. A one-week read-only log of idle minutes and acad.exe presence would settle it, but that is a new script and needs Tim's approval (RULES 10.5). **Recommendation:** do not build idle mode now.

### 5. A second desktop

**Read-only facts about this PC (29 Oct 10:35):** Windows 11 Business 10.0.26200; i7-12700F (12 cores, 20 threads); 63.8 GB RAM; C: 82.2 GB free of 930.5 GB; GTX 1050 Ti 4 GB. Hypervisor present: True (Virtual Machine Platform is enabled, InstallState 1). Hyper-V itself is available but disabled (`Microsoft-Hyper-V-All` and its parts InstallState 2). The processor's "virtualisation in firmware" reads False, which is how Windows normally reports it while a hypervisor is already running. My reading: virtualisation is on. Tim's AutoCAD working set this morning: 1,064 MB.

1. **(a) Hyper-V virtual machine on this PC (4 threads, 16 GB, low priority).**
   - **Needs:** Hyper-V switched on by an administrator (a Windows feature change plus a restart: not done, not allowed here); a Windows 11 licence for the guest; AutoCAD installed in the guest; a licence that lets AutoCAD run there while Tim's runs.
   - **Graphics:** a Hyper-V guest on Windows 11 gets a basic display adapter; GPU sharing to a client guest is not a supported, simple set-up (not verified on this PC). AutoCAD would run on software graphics: slower and possibly different-looking.
   - **Effect on Tim:** 4 of 20 threads and 16 of 64 GB. ESTIMATE: little effect on drafting, but disk and memory pressure during his big drawings are untested.
   - **Effort:** 2 to 3 days. **Same-results risk:** pointer and picture cases would need their own calibration at the guest's resolution; class (a)/(b) results should match.
   - A "Tim's VM" Test Station ran Codex passes on 24 Sep (`TEST_STATION_RESULTS.md`), but those files do not say which machine hosted it. It was not Hyper-V on this PC (the feature is disabled).
2. **(b) The spare work PC: RECOMMENDED.** Already ruled (D5, 17 Oct): *"i have a spare pc with autocad on it already , happy with the rest"*. Set-up prompt ready: `04_REFERENCE\TEST_PC_START_PROMPT.md` (step 3 stops if it is signed in with Tim's own account). Waiting only on Tim being at work (he returned 29 Oct).
   - **Needs from Tim:** switch on, log in, paste the prompt, sign in to GitHub and Codex, and answer the licence question.
   - **Effort:** 1 to 2 days, mostly unattended.
   - **Effect:** the robot no longer competes with Tim at all, and gets 168 hours a week instead of 128, with Tim's PC still usable for extra overnight runs. ESTIMATE about 30 percent more sessions a week from the extra hours. More important: same-day proofs of a fix during Tim's hours.
   - **Same-results risk:** different screen size and display scale change the 6 mouse cases and the pictures (recalibrate; pictures approved per machine). Different AutoCAD updates, profile and support paths could change behaviour: install the same CE payload by the REL-09 steps and compare the build string before every run.
3. **(c) A cloud desktop.** I looked up public price listings (devzero.io, Azure Australia East, on-demand Windows, USD per hour), not Microsoft's own calculator: NV4ads V710 v5 about USD 0.48, NV8ads V710 v5 about USD 0.97, NV12ads V710 v5 about USD 1.45.
   - ESTIMATE in AUD at about 1.55 AUD per USD: about AUD 0.75 to 2.25 per hour, plus disk and network. 40 hours a week would be about AUD 30 to 90 a week.
   - Still needs an AutoCAD licence for that machine. Test drawings would leave the office: fixtures must be confirmed free of client data first (RULES 11; not checked here).
   - Effort 2 to 4 days. Same-results risk as (a) and (b), plus a remote-desktop disconnect stops real input.
4. **(d) Autodesk's own options.**
   - **Core console on a second machine:** same as section 3, free with that machine's AutoCAD.
   - **Design Automation for AutoCAD:** the core console in Autodesk's cloud. Charged at 2 Flex tokens per processing hour (APS documents). I did not find the Australian price of a Flex token: check autodesk.com/au/buying/flex. It needs an Autodesk Platform Services developer account, and only made-up drawings may go to it. It cannot open CE windows and never fires Idle.
   - Its real use is running CE on AutoCAD 2022 to 2026, which are not installed here, rather than raising the count. Effort: medium to large. Already listed as Tim's decision in the 9 Oct research.

**Licence (all options):** Autodesk's public answer for a named-user subscription is: install on up to three devices, use on one device at a time. A sign-in on a second machine while Tim draws may sign him out or be refused. Before anything is installed, the office admin should look in Autodesk Account (manage.autodesk.com, Products and Services, and User Management) at:
- the licence type: user (named), network or standalone;
- how many seats the office holds and who is assigned;
- whether a spare seat can be given to a test login.

This PC's own licence type could not be read from its files (section 3, item 3).

### 6. Recommendation (order, effort, what it needs from Tim, effect on the testing number)

1. **Gap cut (runner and chain owners, then an Opus review):** 0.5 day; nothing from Tim. ESTIMATE +40 percent sessions an hour.
2. **Calibration grouping:** 0.5 day; nothing from Tim. ESTIMATE +5 to 8 percent.
3. **Targeted regrade map and rule:** 1 to 2 days; one ruling (CE 00 or Tim) on carrying a tool's pass across builds until the weekend full regrade. ESTIMATE 4 to 6 h of a night freed after each install.
4. **Spare test PC:** 1 to 2 days; Tim 30 minutes plus the licence answer. ESTIMATE 168 instead of 128 robot hours a week (+30 percent) if the robot moves there; about 2.3 times if both PCs run; and fixes proved in his working hours.
5. **Keyboard-free Esc in the driver:** about 1 day; nothing from Tim. Makes 54 cases independent of the real keyboard. A safety gain, not a speed gain.
6. **Hyper-V VM:** only if step 4 fails on the licence; 2 to 3 days; admin feature switch, a Windows licence, a second AutoCAD licence.
7. **Not now:** headless runner, idle mode, cloud desktop, Design Automation (reasons above).

**Effect on the weekly number (honest):** today about 800 sessions a week are possible (128 h x 6.3). Steps 1 to 3 make that about 1,150 (128 h x 9). With step 4, about 1,500 on the spare PC alone (168 h x 9), or about 2,650 if both PCs run (all ESTIMATES). Every waiting draft would then get its two-start result the night it is written. The count of everyday tools (19 of 40) rises only as fast as new cases are written, reviewed and given the robot additions they need. The known needs:
- a "select tab" verb (D05, D06);
- reading a text's rotation (D10);
- reading a multileader (D11);
- the "More..." allow-list (D05, D06);
- a survey fixture (D26);
- card questions (D07, D22, D28);
- Tim's yes or the spare login (D29).

ESTIMATE: with steps 1 to 4, 2 to 4 more tools a week, if case writing keeps pace. Without them, about the same number of tools, but each landing a day later.

### 7. What I did NOT verify (RULES 5.9)

1. Nothing was run in AutoCAD, the core console, the runner or the driver. Every speed figure "after" is an ESTIMATE from the measured split.
2. Whether the core console still refuses to start beside an open AutoCAD 2027 on the current update (last SEEN May 2026).
3. The licence type on this PC, on the spare PC, and whether the core console uses a seat.
4. Hyper-V's real state (`Get-WindowsOptionalFeature` needs elevation, so the WMI feature list was read instead); GPU support for a guest; the power and screen-lock settings (powercfg is not on the tool PATH).
5. The individual times of AutoCAD launch, CE load, fixture open, guard set and restore, and quit (the reports do not keep them).
6. Cloud prices from Microsoft's own calculator; the AUD Flex token price; the exchange rate (1.55 assumed).
7. Whether the test fixtures (DRV1_B1, DRV15_METRE) hold any client data (matters only for cloud options).
8. Tim's real away-from-desk pattern in working hours (nothing records it).
9. The case classification is by text matching (a `type` that opens a window without `-ExpectWindow` would be misclassed; none was seen in class (a)).
10. **For the desk (RULES 6.2):** the brief's "20-minute lunch window" is not in RULES 1.8, which gives 2:00 to 3:00 pm free. AGENTS.md in the plugin repo gives Tim's day as 8:40 am to 5:30 pm "Australia/Sydney". RULES says 8:30 Melbourne, and RULES wins.

## Summary

The robot's own hours are not the bottleneck: about 128 free hours a week remain. A third of its clock is a fixed 3-minute wait, and each install triggers a 6 to 8 hour full regrade. Recommended order: (1) cut the gap; (2) group the mouse line-ups; (3) re-test only what a fix touched, which needs a ruling; (4) switch on the spare work PC, which needs a licence check. A hidden core-console robot and idle mode cannot run beside Tim's open AutoCAD, so neither helps on this PC. The count rises as new checks are written.
