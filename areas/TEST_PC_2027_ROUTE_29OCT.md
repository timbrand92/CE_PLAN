# The 2027 test PC route (29 Oct 2026)

Job `CE_ACAD / robot / plan / 18` (CE 02 Robot and Codex Testing, Team, Opus). Research and documents only. Written Thu 29 Oct 2026 from 12:11 Melbourne (PC clock). Nothing was started in AutoCAD, the runner, the driver, the settings guard or the lock. Nothing was installed or changed. The 2026 laptop addendum (`areas\TESTING_SPEED_OPTIONS_29OCT.md`) and `areas\TEST_LAPTOP_STEPS_29OCT.md` are left as the 2026 record; this file replaces them as the plan.

Decisions read: `decisions\2026-10-29_TIM_ANSWERS.md` items 24 to 34, `decisions\2026-10-29_TIM_NO_PAID_TOOLS.md`, `decisions\2026-10-29_TIM_RELEASE_FREEZE.md`.

## ANSWER FIRST

1. **A second PC with AutoCAD 2027 is the easy route.** The robot was built for 2027, so it needs about half a day of small reviewed changes, not the full day the 2026 laptop needed. No change to the robot's AutoCAD year check at all.
2. **Its results count as normal passes.** Same AutoCAD, same CE folder ("Modern"), same build. Each run header and ledger row just carries the PC's name.
3. **About 3 working days from Tim's "which PC" answer, and about 45 minutes of Tim's time.** If Tim names the PC by Fri 30 Oct, the first proof runs Wed 4 Nov and the PC joins the pre-pilot full re-test on Sat 7 and Sun 8 Nov.
4. **One CE switch must be set on purpose.** CE turns pipes into the one-piece CE pipe object only on Tim's own Windows account. On the test PC's own login, pipes stay ordinary unless CE's pipe upgrade switch is set to On there. Recommended: On for normal runs (matches Tim's PC), and one full pass with it on Automatic (exactly what Max gets).
5. **Two things need Tim's word:** that the "Tim is drafting" hours do not apply on a PC Tim never uses, and whether a Codex look on the test PC counts as "Codex-accepted" (today's rule says "on Tim's PC").

## FOR TIM

1. **Which PC.** Any office PC that can stay switched on and that nobody drafts on. Tell me its name (Start, Settings, System, About, "Device name").
   - Example: "the spare PC by the printer, CE-SPARE-01, free every night and weekend".

2. **The licence check, first (5 minutes, with the office admin).** This stops the robot signing you out of your own AutoCAD.
   1. **The admin assigns a spare seat** to a new test login on that PC (not to you). You said "we have spare autocad licenses"; we need one that covers 2027.
   2. **On the test PC, start AutoCAD 2027** and look at the **name at the top right**. It must be the test login's name, not yours.
   3. **Why it matters:** with your own seat, starting AutoCAD on two PCs can sign one of them out. Example: half-way through a pit schedule at 10 am, your AutoCAD asks you to sign in again. A seat of its own means the robot can never do that.
   4. **Stop** if the only seat is yours. Tell me, and nothing goes further.

3. **What you switch on and sign in to (about 40 minutes in total).**
   1. **The admin (20 minutes):** creates a standard Windows login, for example "CE Test" (not you, not an administrator); sets the PC to never sleep, never lock, no screen saver, sign in automatically. Those are security settings, so the admin sets them, never a chat.
   2. **The admin installs, for all users:** AutoCAD 2027 (if not there), Git for Windows, GitHub CLI, PowerShell 7, Node.js. All free.
   3. **You (10 minutes), at the test PC:** sign in to GitHub, to Claude (the Team account) and to Codex when the screen asks. You type your own passwords; nobody else does.
   4. **You (one line):** "yes, install CE on the test PC". I install nothing on any other PC without it.
   5. **You (one line):** a USB stick for the robot files and the two test drawings.

4. **How long: about 3 working days, mostly unattended.**
   1. **Day 1, on your PC, no AutoCAD needed:** the small robot changes, reviewed by Opus; the USB pack made.
   2. **Day 2, on the test PC:** set-up, then CE installed the way a colleague gets it (this is also the install rehearsal).
   3. **Day 3, half a day:** the first proof (item 6).

5. **What the test PC can then do.**
   1. **Run the robot day and night, weekdays included,** without waiting for your free windows. Example: a re-test that takes 6 h 40 min on a Saturday on your PC can run on a Tuesday at 10 am there.
   2. **Run the Codex looks** (Codex looks at the real window and takes a screenshot), at any hour.
   3. **The install rehearsal,** on an ordinary login with no administrator rights, exactly like Max's PC. Example: copy the two CE folders, start AutoCAD, the CE tab appears and CEHEALTH shows every line OK.
   4. **A "Max-like" run** for free: no extra test add-ins and pipe upgrade on Automatic.

6. **What it cannot prove, and the first small proof.**
   1. **It has a different graphics card and screen scale.** A window can look fine there and cramped on your screen. So a window that matters is still looked at on your PC once.
   2. **The first proof runs three checks there and compares them with your PC's results on the same build:**
      - **R10 (CDCHECKIGNORE with the switch off), typed only.** Same answer means the robot itself works on that PC.
      - **N01 (CDREBUILD).** On your PC it says "11 pits, 49 pipes" and one U undoes it. Same answer means CE behaves the same there.
      - **N25 (pit label lands on the picked point), real mouse clicks.** Same result means the robot's mouse aim works on that screen and graphics card. This is the one most likely to differ.
   3. **All three match:** the test PC's passes count like yours from then on. **Any mismatch:** we find out why before anything counts.

7. **Two calls for you (CE 04 will ask; no rush before the PC exists).**
   1. **The drafting hours on the test PC.** Recommended: your 8:30 am to 2:00 pm and 3:00 to 5:30 pm protection applies only to your own PC. The robot still stops if a person touches that PC's mouse or keyboard.
   2. **Codex looks on the test PC.** Recommended: they count as "Codex-accepted", with the PC's name written beside them; windows that matter still get one look on your screen.

8. **My recommendation: yes. Name the PC and do the licence check this week.** The robot changes can be written now, before the PC exists, so nothing waits on day 1.

---

## Technical detail

### 1. What carries over from the 2026 laptop work, and what drops

1. **Drops (2026 only):** allowing AutoCAD version 25 (v2 line 43, v3 line 56); the Net8 lane; the "robot-accepted on 2026" label and its separate scoreboard line; the 20 pipe-object cases needing 2026 variants; the missing 2027 add-ins (`CE_CVL_OBJECTS_2027.dbx`, `CE_TRANSFORM_2027.arx`, the grip module), which all load on a 2027 test PC; the BUG-1209 and BUG-1210 holes (they do not apply on 2027).
2. **Carries over:** the hours switch, the standing chain's `C:\Users\TimothyBrand` paths, the settings fingerprints, recreating the fixed folders, the USB copy with a SHA-256 list, the colleague install as rehearsal R1, a separate login, Tim's own sign-ins, the four admin power and lock settings (and `04_REFERENCE\TEST_PC_START_PROMPT.md` step 4b: dummy display plug if no monitor, `tscon` before leaving a remote session), own report folder.
3. **New for 2027:** the pipe upgrade switch on a non-Tim login (section 3); counting as the same lane (section 6); the Codex rule wording (FOR TIM item 7.2).
4. **The start prompt `04_REFERENCE\TEST_PC_START_PROMPT.md` (17 Oct) is out of date for this route:** its step 2 installs the .NET SDK, Visual Studio Build Tools and ObjectARX and step 5 builds the plugin. The test PC never builds (builds and payloads stay on Tim's PC), so skip those. Its step 3 licence stop and step 4b stay. A new short start prompt should be written from section 8 below when Tim names the PC.

### 2. Reviewed changes so the robot can run on a second PC

Files read: `C:\Lisp Files\_ACAD_DRIVER\acad_driver_v3.ps1` (95 KB), `acad_driver_witness_v2.ps1` (373 KB, not changed), `case_runner.ps1` (49 KB), `case_runner_lib.ps1` (58 KB), the v3 allow-list; `C:\CE_PLAN\desk_jobs\chain_robot_standing.ps1`, `acad_janitor.ps1`, `codex_conveyor.ps1`, `launch_codex_retry.ps1`, `chain_codex_*.ps1`.

**One reviewed diff, about 30 lines in total, written on Tim's PC and proved with the offline self-test only (`case_selftest_offline.ps1`, `v3_selftest.ps1`). No AutoCAD starts.**

1. **Test-machine hours switch (about 10 lines, the only real logic).** `Test-V3InUseHours` (v3 line 503) and the runner's free-minutes function (runner line 58) stop the robot weekdays 8:30 to 14:00 and 15:00 to 17:30 on ANY PC. Do not reuse `CE_RUNNER_TIM_AWAY`: it means "the desk has told Tim is away", and it would blur. Proposed: a marker file `C:\ce_rc_drv\TEST_MACHINE.txt` holding that PC's own name; both functions return "free" only when the file exists AND its text equals `$env:COMPUTERNAME`. A copy that reaches Tim's PC by accident does nothing (wrong name). The person-at-the-PC check (`HumanQuietSec` 120 s, v3 line 59) and the locked-screen check (`Get-V3ScreenState`) stay on. Needs Tim's ruling (FOR TIM 7.1).
2. **Machine name in the run header (one-liner).** Runner line 372 writes "Melbourne time at start ..."; add `machine: $env:COMPUTERNAME` on the same header.
3. **Machine name in each ledger row (about 3 lines).** Add a `machine` field to the row the runner appends (today: run, session, case, build, result, variant_of, at, case_sha256, from_check). Rows without it are Tim's PC (all 1,385 so far).
4. **Own report folder (zero code).** The runner already reads `CASE_RUNNER_REPORT_DIR`. The test PC's run command sets it to `C:\CE_PLAN\areas\runner-reports-testpc`, so two PCs never push the same `ledger.json`. The desk merges rows into the main ledger (a small merge step; who owns it is a desk decision).
5. **Settings fingerprints (one-liner, test PC copy only).** v3 line 71 holds four 12-hex fingerprints of Tim's settings files. On the test PC they all differ, so every report carries `hash_unexpected_at_start` lines (recorded, not a stop). Give the test PC its own four values once its fresh settings are made, or reports are noisy.
6. **Standing chain paths (one-liner, safe on both PCs).** `chain_robot_standing.ps1` line 31 hard-codes `C:\Users\TimothyBrand\.claude-team` and `...\AppData\Roaming\npm`. Use `$env:USERPROFILE` and `$env:APPDATA` instead; on Tim's PC the result is identical. The same two strings sit in every `chain_*.ps1` launcher that starts a Team job (for example `chain_codex_burn_briefs2.ps1`); fix only the ones the test PC runs.
7. **No change needed (checked):**
   - **AutoCAD year:** v2 and v3 expect release 26 (AutoCAD 2027). Unchanged, so the v2 fingerprint pins (v3 lines 42 to 45) stay as they are. Editing v3 itself does not trip any pin; editing v2 would.
   - **AutoCAD path:** v2 line 333 `C:\Program Files\Autodesk\AutoCAD 2027\acad.exe`, used only by the `-Env` launch. Fine if 2027 is installed in the default place (check at set-up). The normal launch opens the drawing through Windows, so `.dwg` must open in 2027 on that PC: check if it also has an older AutoCAD.
   - **Window titles:** the allow-lists match `Autodesk AutoCAD*`, no year, no PC name.
   - **AutoCAD profile:** nothing selects a profile by name; no "Tim" profile is used. The driver uses the current profile and puts back the variables it changed.
   - **Pointer calibration:** per session, reads the drawing-area scale, refuses a scale error over 0.5 percent. A different screen is handled in principle; N25 in the first proof shows it.
   - **The build check:** `Get-CaseBuild` reads `%APPDATA%\Autodesk\ApplicationPlugins` (per login, `case_runner_lib.ps1` line 11) and takes the `Modern` DLL first, which is the 2027 lane. Correct on a 2027 PC with no change.
   - **The lock:** `C:\ce_rc_drv\ACAD_LOCK.json` plus the mutex `Global\CE_ACAD_DRIVER_LOCK` are per PC. Each PC has its own lock; nothing is shared, nothing collides.
   - **The janitor:** `acad_janitor.ps1` (3 KB) uses only `C:\ce_rc_drv`, `C:\ce_rc_scratch` and the settings guard path; copy and run it on the test PC unchanged.
   - **The Codex runner:** `codex_conveyor.ps1` and `launch_codex_retry.ps1` use `C:\ce_rc_drv`, `C:\ce_rc_scratch`, `C:\CE_PLAN\desk_jobs` and `C:\Lisp Files\_CODEX_RUNNER` (recreated on the test PC) and have no hours check of their own. `C:\Lisp Files\_CODEX_RUNNER` is NOT a git repository either (checked); copy its scripts and the queued briefs only, not its logs or evidence.

### 3. The pipe upgrade switch (the one CE behaviour that changes with the login)

1. **Source:** `Modules/Drainage/Services/NativeObjects/PipeObjectUpgradeGate.cs` on `claude/rel-20261029a`. The setting `options.pipeObjectUpgrade` is Automatic (default), On or Off. Automatic means on only for Tim's Windows identifier (`AzureAD\TimothyBrand`, a fixed SID). Any other login reads as a colleague.
2. **Effect on a 2027 test PC with a "CE Test" login:** on Automatic, pipes stay ordinary polylines (what Max gets). The 20 cases that name the pipe object (N06, N17 to N20, N23, N28, R01, R02, R02b, R17, R19, R19b, R20, R23, R31, R32, R32b, R39, R39b) would read differently from Tim's PC. No case sets this switch (checked: no case mentions `pipeObjectUpgrade`).
3. **Recommended:** set it to On in the test PC's own CE settings at set-up (through CE's Settings page or the settings guard; never a copy of Tim's settings file, BUG-1167). Then the test PC behaves like Tim's PC and its passes compare one for one. The 2027 pipe-object add-on is in the Modern folder, so On works there.
4. **The Max-like pass:** set it back to Automatic for one full pass on Sat 7 or Sun 8 Nov. That pass is closer to Max than the planned Max-like pass on Tim's PC, which still runs on Tim's own account.
5. **Do not sign the test PC in with Tim's own Windows account:** it would switch the upgrade on silently and blur which login ran what.

### 4. Getting the robot, cases and drawings there

1. **`C:\Lisp Files\_ACAD_DRIVER` is not a git repository** (checked again today). 32 MB, mostly transcripts. Copy by USB: the `.ps1` scripts, both allow-lists, `cases\` (85 case files), `v3_cases\`, `journeys\`, the READMEs. Leave out `transcripts\`, `state.json`, `calls_v2.json` (Tim's PC's running state).
2. **SHA-256 list:** made on Tim's PC with `Get-FileHash` (one command, no new script), copied with the files, compared on the test PC. Any difference: copy again.
3. **Apply the section 2 diff once,** as the same reviewed change on both PCs where it is safe (items 1 to 3 and 6), so the two copies never drift. Item 5 is the test PC copy only.
4. **The two test drawings:** only `C:\ce_rc_drv\DRV1_B1.dwg` and `DRV15_METRE.dwg`. Do NOT copy the rest of `C:\ce_rc_drv` (session copies) or `_TEST_COPIES_20260923`. `DRV1_B1` carries an attached reference drawing named like a real job number, so both count as client content: USB only, into `C:\ce_rc_drv` on the test PC, never OneDrive, SharePoint, a synced folder or any repository. Wipe them off the USB stick afterwards. Check that the test login's OneDrive backup does not cover `C:\ce_rc_drv` (it normally covers only Desktop, Documents and Pictures).
5. **Screenshots** stay in `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots` on the test PC, as on Tim's PC (not in a repository).
6. **Each new CE candidate** has to reach the test PC too. The candidate folders are built on Tim's PC (`C:\ce_rc_scratch\c10xx`). Recommended: USB with its SHA-256 manifest, the same as Max's install, so every test PC install is also an install rehearsal. A private release download would be quicker later; that is a structure decision for the desk, not made here.
7. **Later, cleaner:** a private repository for the robot folder (scripts and cases only, no drawings, no transcripts). Desk decision, not made here.

### 5. What a Claude session on the test PC needs

1. **Repositories:** `timbrand92/TimOS` to `C:\TimOS`, `timbrand92/CE_PLAN` to `C:\CE_PLAN` (holds `desk_jobs\` and `areas\runner-reports`, both tracked). The plugin repository only if the session reads source; it never builds.
2. **Logins typed by Tim:** `gh auth login` as `timbrand92`; `claude` then `/login` (Team account); Codex sign-in. The Team login can expire overnight (it did on 29 Oct at 05:29); the nightly queue then stops until Tim logs in again.
3. **Keys:** none of the driver, runner, janitor or chain scripts read a key file (searched for `keys.txt` and `\Keys\`: no match). If a key is ever needed there, it goes in a Keys drawer on that PC outside every repository, typed in by Tim; never in a repo, a commit or a message.
4. **Its own queue:** a separate `desk_jobs\ROBOT_QUEUE_TESTPC.txt` read by that PC's standing chain, so the two PCs never pick the same job. The desk on Tim's PC appends lines and pushes; the test PC pulls.
5. **Its own CLAUDE_CONFIG_DIR** under the test login (section 2 item 6 makes the chain find it).

### 6. How the ledger labels results from that PC

1. **Same 2027 lane, so a normal pass.** Build key unchanged (`civil 3.0.xx+commit / struc ... / mgr ...`), read from that PC's own installed bundle.
2. **The machine name** goes in the run header and each ledger row (section 2 items 2 and 3).
3. **The 24 Oct counting rules apply unchanged:** two separate AutoCAD sessions on the same installed build, a failing twin, the review. Two sessions on two different PCs on the same build: recommended to count as the two sessions (it is a stronger proof). Desk ruling; not decided here.
4. **Codex looks:** recorded as "Codex-accepted (test PC <name>)" once Tim agrees (FOR TIM 7.2). Windows that the 22 Oct look list marks as Tim-visible still get one look on Tim's screen (RULES 5.7).
5. **Before the first proof passes,** test PC rows are labelled "trial" and count for nothing.

### 7. How it joins the schedule (CE 07)

1. **Sat 7 and Sun 8 Nov pre-pilot full re-test on the frozen build** (`areas\RELEASE_SCOREBOARD.md` item 8): run on both PCs. Tim's PC does the normal two-start pass; the test PC does one pass with the pipe upgrade On (a third independent session) and the Max-like pass on Automatic. That frees Tim's PC from the Max-like run.
2. **Rehearsals R2 and R3** (`areas\RELEASE_HANDOVER_PLAN_29OCT.md` section 5) on the freeze candidate run on the test PC's standard login, as the real colleague route.
3. **Weekdays 3 to 6 Nov:** area re-tests after each install can run on the test PC during Tim's drafting hours (once FOR TIM 7.1 is ruled), so nothing waits for 17:30.
4. **Nightly Thu 12 and Fri 13 Nov and the last full pass Sat 14 Nov:** either PC; the test PC first, so Tim's PC stays free.

### 8. What to do first (effort in days)

1. **Now, no PC needed (CE 04, 10 minutes):** ask Tim which PC, when, and the licence check (FOR TIM 1 and 2); the two rulings (FOR TIM 7).
2. **Day 1 (0.5 day, Tim's PC, no AutoCAD):** the section 2 diff, Opus review, offline self-tests; the USB pack and its SHA-256 list. Can start before the PC exists.
3. **Day 2 (1 day elapsed, about 2 hours of hands-on, Tim about 40 minutes):** admin login and settings; tools; Tim's sign-ins; clones; USB copy checked; marker file with the PC name; CE installed by the colleague hand install (rehearsal R1, `RELEASE_HANDOVER_PLAN_29OCT.md` section 3 steps 2 to 11); pipe upgrade set to On; the test PC's settings fingerprints taken.
4. **Day 3 (0.5 day):** the first proof: R10, N01, N25, each in two separate AutoCAD sessions, compared with Tim's PC rows on the same build.
5. **Then (0.5 day):** a full pass of the accepted checks on the test PC to confirm the match across all tools, then it takes its share of the queue.
6. **Total:** about 2.5 days of work across 3 working days. Earliest: Tim names the PC Fri 30 Oct; day 1 Fri 30 Oct or Mon 2 Nov; day 2 Mon 2 Nov or Wed 4 Nov (Tue 3 Nov is Cup Day); proof Wed 4 or Thu 5 Nov; in time for Sat 7 Nov.

### 9. Risks

1. **Licence:** a shared seat signs Tim out (stopped by FOR TIM 2).
2. **A sleeping or locked PC:** the Esc keys and clicks fail silently (admin settings; the robot already refuses a locked screen).
3. **Two PCs, one ledger:** clashes (own report folder, own queue).
4. **The hours marker reaching Tim's PC:** does nothing, because it must hold that PC's name.
5. **Pipe switch left on Automatic by mistake:** 20 checks fail as a group with ordinary pipes. Easy to spot; the run header should print the switch value (a one-line addition worth making in the same diff).
6. **Drawings leaking:** USB only, never synced (section 4 item 4).
7. **The two robot copies drifting:** one reviewed diff applied to both; SHA-256 list compared after every change.

### 10. What I did NOT verify (RULES 5.9)

1. Nothing was run on any other PC or in any AutoCAD. Every "should match" is from reading code and case files.
2. Which PC, its graphics card, screen size and scale, whether it has an older AutoCAD that owns `.dwg`, and where AutoCAD 2027 would be installed.
3. Whether the office's spare seats cover 2027 and whether they can be assigned to a test login (Autodesk Account, User Management; the admin's job).
4. The exact Settings page wording for the pipe upgrade switch, and which settings file holds `options.pipeObjectUpgrade` on a fresh install.
5. Whether a standard login can install PowerShell 7, Node.js, Claude Code and Codex itself (plan for the admin).
6. Whether any accepted check depends on the two extra test add-ins on Tim's PC (`CE.Transform.Trial.2027`, `CE.AutoCADLink.2027`); the test PC will not have them. The full pass in section 8 item 5 shows it.
7. The size of `C:\Lisp Files\_CODEX_RUNNER` (a read-only scan did not finish in two minutes; it is large) and exactly which of its files a Codex look needs.
8. That the session-scale calibration handles a screen scale other than Tim's in practice (N25 tests it).
9. Every day estimate above is an estimate; nothing here has been tried on a real second PC.

## Summary

A second PC with AutoCAD 2027 is the easy route: the robot needs about 30 lines of reviewed change (a test-machine hours marker tied to that PC's name, the machine name in reports and ledger rows, its own report folder and queue, two path fixes) and no year change. Its passes count as normal 2027 passes. Set CE's pipe upgrade switch to On there, Automatic for one Max-like pass. About 3 working days and 45 minutes of Tim's time; it can join the Sat 7 and Sun 8 Nov re-test.
