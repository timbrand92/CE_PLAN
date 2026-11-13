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
