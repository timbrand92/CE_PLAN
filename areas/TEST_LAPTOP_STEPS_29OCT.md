# Test laptop with AutoCAD 2026: click-by-click bring-up steps (for CE 07)

Written Thu 29 Oct 2026 by `CE_ACAD / robot / plan / 17` (CE 02). Research only: nothing here has been done yet.
The reasons and the detail are in `areas\TESTING_SPEED_OPTIONS_29OCT.md`, section "ADDENDUM: A LAPTOP WITH AUTOCAD 2026".
The install half is the same as `areas\RELEASE_HANDOVER_PLAN_29OCT.md` section 3 (rehearsal R1). Questions to Tim go through CE 04 only (its item 33).

## ANSWER FIRST

1. **About 3 working days elapsed, about 45 minutes of Tim's time.** Earliest ready: Tue 3 Nov, if Tim answers the laptop questions on Fri 30 Oct.
2. **Stop at step 1 if the licence check fails.** A robot signing Tim out of his own AutoCAD costs more than the laptop gains.
3. **The laptop tests AutoCAD 2026 (CE's Net8 folder), never 2027.** Every result is labelled that way (step 15).

---

## Stage 0: before anything (Tim's answers, about 10 minutes of his time)

1. **Licence check.** Needs: Tim, 5 minutes.
   - On the laptop, open AutoCAD 2026 and look at the name at the top right.
   - If it is Tim's own Autodesk login: the office admin opens manage.autodesk.com, then Products and Services (licence type) and User Management (seats, who holds them).
   - **Stop if** the licence is per person and no other seat can be given to the laptop. Example of the harm: Tim is signed out of his 2027 mid-drawing at 10 am.
2. **Tim's word to install CE on the laptop.** Needs: Tim, one line ("yes, install on the laptop"). The 29 Oct decision says nothing is installed on another PC without it.
3. **Max's AutoCAD year, if known** (QUESTIONS_FOR_MONDAY item 22). It decides stage 4: a full run if Max is on 2025 or 2026, rehearsals only otherwise.

## Stage 1: on Tim's PC, no AutoCAD needed (about 1 day, desk builder plus Opus review)

4. **One reviewed robot change, for the laptop copy only.** Needs: nothing from Tim. Owner: CE 02 runner owner, Opus review.
   - Allow AutoCAD version 25 only when a laptop machine setting says so (v2 line 43, v3 line 56). Tim's PC keeps refusing anything but 2027.
   - A "test machine" switch for the in-use hours (v3 line 503, runner line 58), separate from `CE_RUNNER_TIM_AWAY`. Needs a desk or Tim ruling that RULES 1.8 protects Tim's PC only.
   - Add `machine`, `acad` (year and ACADVER) and `lane` (the DLL acad.exe loaded) to every ledger row and the lane to the build key.
   - Point reports to a laptop folder, for example `C:\CE_PLAN\areas\runner-reports-laptop2026`, so two machines never push the same ledger file.
   - The laptop's own four settings fingerprints (v3 line 71) and new pins (v3 lines 42 to 45).
   - The standing chain's two `C:\Users\TimothyBrand\...` paths, in the laptop copy only.
   - Proof: the offline self-test only (`case_selftest_offline.ps1`). No AutoCAD starts.
5. **Make the USB pack.** Needs: a USB stick from Tim or the office.
   - From `C:\Lisp Files\_ACAD_DRIVER`: the `.ps1` scripts, both allow-lists, `cases\` (all subfolders) and the READMEs. Leave out `transcripts\`, `state.json` and `calls_v2.json`.
   - From `C:\ce_rc_drv`: only `DRV1_B1.dwg` and `DRV15_METRE.dwg`. They count as client content (an attached reference drawing named like a real job): never OneDrive, never a repository, never a synced folder.
   - A text file of every file's SHA-256 next to them.

## Stage 2: on the laptop (about 1 day, mostly unattended; Tim about 30 minutes)

6. **Office admin, on the laptop's administrator account (about 20 minutes).** Needs: the admin.
   - Create a standard Windows login, for example "CE Test". Not Tim's account, not an administrator. (Tim's own work account would switch CE's pipe upgrade on with no add-on to back it.)
   - Settings, System, Power: screen and sleep "Never" when plugged in. Control Panel, Power Options, "Choose what closing the lid does": "Do nothing".
   - No screen lock, no screen saver, automatic sign-in to "CE Test". These are security settings: the admin sets them, never a chat.
   - Install for all users: Git for Windows, GitHub CLI, PowerShell 7, Node.js LTS. (A standard login may not be able to install them itself; not verified.)
7. **Sign in as "CE Test" and look at AutoCAD once (5 minutes).** Needs: the person at the laptop.
   - Start AutoCAD 2026. Type `ABOUT`: write down the year and update. Type `ACADVER`: write down the value (expected to start 25.1; not verified).
   - Top right: write down the signed-in name (stage 0 step 1 must already be clear).
   - Close AutoCAD. Task Manager, Details: no `acad.exe`.
8. **Claude Code and Codex.** Needs: the person at the laptop, 5 minutes.
   - In a terminal: `npm install -g @anthropic-ai/claude-code` and `npm install -g @openai/codex`. If a standard login cannot install them, the admin does it in step 6.
9. **Tim signs in himself (about 10 minutes).** Needs: Tim. Nobody types his passwords.
   - `gh auth login` as `timbrand92`.
   - `claude`, then `/login` with the Team account.
   - Codex sign-in.
10. **Clone the plans.** Needs: nothing from Tim.
    - `git clone https://github.com/timbrand92/TimOS C:\TimOS` and `git clone https://github.com/timbrand92/CE_PLAN C:\CE_PLAN`.
11. **Copy the USB pack and check it.** Needs: the USB stick.
    - Create `C:\Lisp Files\_ACAD_DRIVER`, `C:\ce_rc_drv`, `C:\ce_rc_scratch`, `C:\Lisp Files\_TEST_COPIES_20260923\pack_runs` and `...\robot_shots`.
    - Copy the robot files and the two drawings in. Compare every SHA-256 with the list. Any difference: copy again.
    - Delete the two drawings from the USB stick.
12. **Install CE the colleague way (rehearsal R1, 10 to 20 minutes).** Needs: Tim's word from step 2.
    - Follow `areas\RELEASE_HANDOVER_PLAN_29OCT.md` section 3, steps 2 to 11, on the "CE Test" login: copy the Civil and Manager folders together into `%APPDATA%\Autodesk\ApplicationPlugins`, read back the SHA-256, start AutoCAD, `CEHEALTH`, `CE_VERSION`.
    - Write down any "Load / Always Load" question word for word, and any blank window.
    - Never the developer build. Never Tim's settings file.

## Stage 3: the first proof (half a day)

13. **Run three checks, each in two separate AutoCAD sessions.** Needs: nothing from Tim.
    - **R10 (CDCHECKIGNORE with the switch off):** typed command only, no pipes. **A match** (same one-line answer, nothing saved) means the robot itself works on 2026: launch, settings guard, reading the command line, clean end. **A failure** here is a robot problem, not a CE one; stop and fix the robot first.
    - **N01 (CDREBUILD):** on Tim's PC it says "11 pits, 49 pipes", the file stays unchanged and one U undoes it. **A match** means CE's Net8 lane rebuilds the job record the same way even though the pipes stay ordinary polylines on the laptop. That is direct evidence for colleagues on 2025 and 2026.
    - **N12 (COPY of pit P3):** on Tim's PC the copy becomes P8 with its own label and the line "Check levels". **A match** means colleague COPY works on 2025 and 2026 without the 2027 copy helper: good news for the pilot. **A mismatch** (the copy keeps P3, no label) means BUG-1137's hole reaches 2025 and 2026 too: CE 01 files it as pilot-critical if Max is on those years.
14. **Compare.** Put the laptop rows next to Tim's PC rows for the same build (`runner-reports\ledger.json`). Same words and counts = match; anything else = a named difference, never a quiet pass.
15. **Label.** Every laptop row and report says "robot-accepted on 2026 (Net8 lane)" or "FAIL on 2026 (Net8 lane)". It never enters the 19 of 40. How it counts is Tim's call (CE 04).

## Stage 4: after the proof

16. **Max on 2025 or 2026:** run all 85 main cases on the laptop. Expect the 20 pipe-object checks to read differently and write 2026 variants for them.
17. **Max on 2027 or 2022 to 2024:** keep the laptop for rehearsals R2 and R3 (Tue 3 Nov, then Sat 7 or Sun 8 Nov on the freeze candidate).

## Risks

1. **Licence:** a second sign-in signs Tim out or is refused (stage 0 step 1 stops it).
2. **A sleeping or locked laptop:** the Esc keys and mouse clicks fail with no message (step 6 settings; the robot already refuses a locked screen).
3. **A 2026 result read as a 2027 one:** the build check today cannot tell the lanes apart (step 4 fixes it before any run).
4. **Two machines writing one ledger:** merge clashes (step 4, own report folder).
5. **Test drawings leaking:** a drawing put in OneDrive or a repository (step 5 and 11 rules).
6. **The robot change leaking onto Tim's PC:** the version-25 setting is per machine; Tim's PC copy keeps refusing anything but 2027.
7. **The Team Claude login expiring overnight** (it did on 29 Oct at 05:29): a nightly job then stops; Tim logs in again.

## What this file does not cover

1. Building CE on the laptop (never needed; builds stay on Tim's PC).
2. Structural (not in the colleague package).
3. Anything not yet seen on a real laptop: every time and result above is an estimate.
