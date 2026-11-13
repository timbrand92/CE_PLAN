# Trial installs on Tim's PC, Friday 13 Nov 2026 only: the runbook

**Owner: lane trust-acad-evidence (one owner, nobody else installs).** Controller: chat CE_ACAD / trust plan / plan / 01.

## 1. Tim's words and choices (Fri 13 Nov, about 08:50 to 09:15 PC clock)

1. Typed: "howd you go i forgot to mention im not at my desk all day so you can go hard do whatever you need to do".
2. Asked through the question interface: "May the robot install trial builds on YOUR PC today, to see the fixes working in real AutoCAD on test copies?" He chose: "Yes, today only (Recommended)". The option read: "The robot backs up what is installed, installs a trial build, tests on copies, and can put back exactly what was there (Civil 3.0.90, Manager 1.1.89, Structural 1.0.126), checked file by file. Risk: if a put-back went wrong you would find out tonight or Monday."
3. Asked: "If the fix for the job mix-up ... proves out in real AutoCAD today, what should be on your PC when you next sit down?" He chose: "Mix-up fix only (Recommended)". The option read: "Today's version plus only the three mix-up changes. It removes a fault that can put another job's pits in a schedule, and changes nothing else you use. One action puts the old version back."

INTERPRETATION: installs on Tim's PC are allowed on Friday 13 Nov only. Nothing to colleagues, no pilot folder change, no merge into the lines that ship. The permission ends at midnight; the end state below must be reached and checked by 9:00pm.

## 2. What may be on Tim's PC at the end of today (only these two states)

1. **State A, "mix-up fix only":** exactly Civil 3.0.90 (commit cf059dcf) plus the mix-up changes that have passed in real AutoCAD today: pull request 2073, plus 2083 only if its corrected check and its real-AutoCAD run both pass. Nothing else: not the opening line (2041), not 2078 (it sits on 2041), no safety fix, no ribbon, no settings change. Manager and Structural exactly as they were, unless the mix-up change touches the shared part, in which case Manager is rebuilt from the same commit so the two stay identical, and that is said plainly in the report.
2. **State B, "exactly what was there":** Civil 3.0.90, Manager 1.1.89, Structural 1.0.126, every file identical to the backup, proven file by file.
3. If State A cannot be proven completely, the end state is State B. There is no third state.

## 3. Before anything is installed

1. Read `C:\TimOS\skills\deploy\` and `C:\TimOS\skills\release-train\` (both triggers have fired) and the "Deploy hazard" section of the plugin's `AGENTS.md`. Use the existing build, payload and install process only. Do not write a new build or install script; a throwaway check script in your scratchpad is fine.
2. No `acad.exe` running (check twice, a minute apart). Re-read `C:\Users\TimothyBrand\.timos\autocad.json`.
3. **Backup:** the existing process's own backup of the three bundle folders under `%APPDATA%\Autodesk\ApplicationPlugins` (CE_CVL_SUITE.bundle, CE_SUITE_MANAGER.bundle, CE_STRUC_SUITE.bundle), PLUS your own full copy of those three folders to `C:\CE_WORK\scratch\trust_install\BEFORE_13NOV\`, PLUS a list of every file in them with its SHA-256 (`BEFORE_13NOV_manifest.txt`). Check the copy against the list before going on.
4. Hash Tim's settings files (the four you hashed last night). They must be identical at the end.
5. Free space on C: over 25 GB.

## 4. Trial A: the mix-up fix

1. Assemble a trial branch from the installed commit plus pull request 2073 only (merge, never force-push; branch name `claude/trust-trial-a-bug1456`). The foundations lane owns 2073 and answers questions by message.
2. Build it with the existing process. Its version text must be different from 3.0.90 so it can be told apart, and must name its commit.
3. Install it. Read the installed files back: every installed file's SHA-256 equals the built one. A mismatch means stop and restore.
4. **Prove it, in real AutoCAD, on copies only:** every sequence in `areas\trust-run\EVIDENCE_CROSS_DRAWING.md` that showed the mix-up on 3.0.90 (sequence 1, R1, 2, R2, R3, C3 and the tab switch R5), each run twice, plus the controls. Pass = the second drawing's stored CE record and its changed counter are exactly as before, every time. Then CDFEEDBACK first in a second drawing if it does not hang.
5. **Nothing that worked is disturbed:** on a copy, PIT, CD, CDEDIT, PITSCHEDULE (open, close), CDCHECKCURRENT, CDHELP, CDS, CDSYNC behave as on 3.0.90; CE's stored record after each equals the 3.0.90 result for the same steps (you have last night's readings). One accepted change still saves: place a pit, save the copy, reopen, the pit is in the record.
6. If pull request 2083's corrected check passes in the core console, add it to the trial branch, rebuild, reinstall, repeat steps 3 to 5, and add its own cases.
7. **Result:** all pass, twice, with nothing disturbed: Trial A stays, as State A. Anything fails or cannot be run: restore State B at once.

## 5. Other trial builds today (to SEE the other fixes; none of them stays)

Tim allowed trial builds today so the fixes can be seen in real AutoCAD. After Trial A is settled, and only if there is time before 6:00pm:

1. **Trial B:** State A plus the opening line (2041) and the mixed-up-drawing line (2078): the opening line's cases in `areas\trust-run\cases\UX-OPEN-01.md`, starting from the two saved mixed-up copies.
2. **Trial C:** State A plus step 5 (2045) and "a cancelled command writes nothing" (2064): the line after Edit Pit, PIT and CD; what one U does.
3. **Trial D:** State A plus the core ribbon (2038) with its switch turned on in a COPY of the settings file restored byte for byte afterwards: a look at both tabs.
4. Each trial: install, verify hashes, test on copies, write what was seen, then go back to the end state for the day (State A if it was proven, otherwise State B) and verify file by file. One trial at a time. Never leave a B, C or D build installed between trials longer than its own tests.
5. Structural trial builds are NOT part of today unless the controller adds them here in writing.

## 6. End of day, by 9:00pm, no exceptions

1. The PC holds State A or State B, proven: every installed file's SHA-256 listed and compared (against the Trial A build for State A; against `BEFORE_13NOV_manifest.txt` for State B, and for Manager and Structural in both states).
2. Tim's settings files are byte-identical to this morning.
3. AutoCAD starts, the CE tabs load, CDHELP opens and closes, on a copy. Then AutoCAD is closed.
4. `BEFORE_13NOV` is kept, not deleted.
5. Written for Tim, FOR TIM first, in `areas\trust-run\INSTALL_TRIAL_RESULT_13NOV.md`: what is on his PC now, in one line; what was seen working and what was not; and the ONE action that puts the old version back (name it exactly). Plus a row in `PENDING_TESTS.md` and the deploy register as the existing process requires.

## 7. Stop rules

1. An install whose files do not match the build: restore State B, verify, write it up.
2. A restore whose files do not match the backup: stop everything, write URGENT at the top of your status file with exactly what differs, and message the controller at once. Do not try a second method.
3. AutoCAD will not start or the CE tabs do not load after an install: restore State B.
4. Any doubt about which state the PC is in: restore State B.
5. Nothing here allows: a change to the colleague pilot folder; a merge into a line that ships; a message to anyone; a change to any AutoCAD or Windows setting; touching a client drawing.

## 8. Log (the owner adds dated lines, PC clock, newest last)

- 2026-11-13 09:20: runbook written by the controller. Nothing installed yet.
- 2026-11-13 11:33 (trust-acad-evidence, now on Opus): read the runbook, `C:\TimOS\skills\deploy` and `release-train`, AGENTS.md deploy hazard, the C-79b1 install script `desk_jobs\scripts\desk_install_c79b1.ps1` and payload method (`payload116_c79b1_job.txt`, `PAYLOAD_C1076_REPORT.md`, `C:\CE_WORK\scratch\p116_scripts`). Installed line read from the DLLs: Civil 3.0.90+cf059dcf, Manager 1.1.89+cf059dcf, Structural 1.0.126+8de95c34 (all three lanes). No acad.exe at 11:30:31 and 11:31:31. autocad.json mode auto (Tim's away word of today, run file 3c, applies). C: 48.6 GB free.
- 2026-11-13 11:33: BACKUP DONE AND CHECKED: `C:\CE_WORK\scratch\trust_install\BEFORE_13NOV\` (APPDATA CE_CVL_SUITE 832 files, CE_SUITE_MANAGER 75, CE_STRUC_SUITE 2007, plus PROGRAMDATA CE_SUITE_MANAGER 8), manifest `BEFORE_13NOV_manifest.txt` 2,922 lines with SHA-256; copy verified 2,922 ok, 0 bad. Extra cross-check: the live Civil and Manager bundles equal candidate `C:\ce_rc_scratch\c1076` file for file (832 and 75, bad 0). Settings hashed to `SETTINGS_13NOV_morning.txt` (CD_Settings ACD64E79, TIM CS_Settings 622A246F, Structural CS_Settings 50AA0990, CE_CVL_SUITE settings EFE307C4; manager-switches.json absent). The install step itself will also make the usual `_PRE_cf059dcf_<time>.backup` folders.
- 2026-11-13 11:35 (trust-foundations, code owner; written here at the controller's request): THE ONE TRIAL BRANCH is `claude/trust-trial-a-bug1456`, pushed. **Step one (runbook 4.1 to 4.5) = commit `9573b97a`**: the installed commit `cf059dcf` plus pull request 2073 only (its file tree is identical to 2073's head `1a28c3b3`; whole Civil test run at that tree 22,222 ran, 0 failed; core console `CEPROOFCROSSDRAWING` PASS). **Step two (runbook 4.6) = head `9714ffdd`**: adds pull request 2083 (file tree identical to `8a6decef`; core console `CEPROOFCROSSCHANGE` and `CEPROOFCROSSDRAWING` PASS at that tree; the whole test run on this exact head is running now and its result is added below). Made by two merges, no force-push; no pull request is opened for it and it is never merged into a shipping line. Nothing under `Shared`, `Modules\Manager` or `Modules\Structural` is touched by either step, so Manager is NOT rebuilt; only the Civil plugin DLL differs from 3.0.90. The branch carries no version change: the version text is the install owner's build step. I built no payload and installed nothing.
- 2026-11-13 11:36: found a LOCAL branch named `claude/trust-trial-a-bug1456` (9714ffdd = cf059dcf + 2073 + 2083, made 11:31) in worktree `C:\CE_WORK\scratch\tf_trial_a`, with the foundations lane's build lock and dotnet running. Not mine; not touched; asked foundations by message what it is. To keep clear, Trial A is on `claude/trust-trial-a1-bug1456` (note the a1) in worktree `C:\CE_WORK\build\wtA13` (subst R:): cf059dcf + merge of 2073 (1a28c3b3) as 8d9ce9b3 + version commit 8ff19d36 "Version: Civil 3.0.90.1" (two Civil places only). 13 files differ from cf059dcf, none outside Civil, its tests, the proof tool and REGRESSION_LOG. Natives unchanged by 2073 (installed bytes will be used, as payload 116 did).
- 2026-11-13 11:36: Trial A payload build started (build_installer.ps1 in R:, then the official Manager build with the new Civil CE_SHARED approved, candidate `C:\ce_rc_scratch\t13a`). Manager code is unchanged; its bundle is re-stamped only because CE_SHARED carries the build head (same as c1076). Nothing installed.
- 2026-11-13 11:40: CORRECTION to my 11:36 lines, on the controller's ruling (one trial branch only): my own branch `claude/trust-trial-a1-bug1456` is DELETED (it was local only, never pushed, never built). Trial A is now built from **`0f6caa40`** on a LOCAL build branch `trial-a-build-13nov` (never pushed) in `C:\CE_WORK\build\wtA13` (subst R:): parent = the foundations step-one commit **`9573b97a`**, plus my one version commit "Version: Civil 3.0.90.1". `git diff --stat 9573b97a 0f6caa40` = `Installer/PackageContents.xml` and `Modules/Drainage/CE_CVL_SUITE.csproj`, 2 insertions, 2 deletions (the version text only). Tree of 9573b97a = tree of 1a28c3b3 (7ee076ba).
- 2026-11-13 11:40: MANAGER: NOT rebuilt and NOT installed (foundations confirmed 2073 touches nothing under Shared, Manager or Structural). The build stamps its head into CE_SHARED.dll and CE.AI.Core.dll; so the Civil trial bundle will carry the INSTALLED bytes of those two (the same way payload 116 carried the installed native files), after a byte check that the new ones differ only in stamp bytes. Then Civil and Manager keep one identical CE_SHARED and Manager and Structural are untouched. Build restarted 11:39 (waits for the build lock).
- 2026-11-13 11:40: baseline run on the installed 3.0.90 started 11:38 (all seen sequences once, plus the nothing-disturbed list), so Trial A's results can be compared step by step with the same steps on 3.0.90.
- 2026-11-13 11:44 (trust-foundations): whole Civil test run on the trial branch head `9714ffdd` (step two, 2073 plus 2083), Release, net10: **22,234 ran, 22,202 passed, 32 skipped, 0 failed**; net48 and net10 build 0 errors; headless proof project 0 errors. Honest note on the count: the same plugin code gave 22,233 at 07:15. One more test case is being counted on this PC since about 09:30 (my 09:41 run of another branch was also one higher than its parts add up to), so it comes from something on the PC that a test lists, not from this branch; I have not identified which test. Nothing failed in either run. Also checked: the install owner's build commit `0f6caa40` has one parent, `9573b97a`, and differs from it by exactly the two version lines (3.0.90 to 3.0.90.1).
- 2026-11-13 11:53: review `reviews\trial-a-branch-check.md` first line YES for 0f6caa40 (relayed by the controller). Install waits for: the build (my runner has waited for the shared build lock since 11:39; foundations then safety-fixes held it) and my own baseline AutoCAD on 3.0.90 to finish (launched 11:38). Baseline so far, on 3.0.90 as expected: S1 CDHELP and CDS in the second job's drawing FAIL (mix-up), S2 blank drawing FAIL, S3 back in A PASS. Restore script `C:\CE_WORK\scratch\trust_install\restore_stateB.ps1` and file-by-file check `verify_before.ps1` written; dry run of the check at 11:41: all four bundles equal the backup.
