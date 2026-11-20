# Verdict: the night-script safety fix, branch team/night-launch at a092bf7

**Verdict: HOLD. No AutoCAD run. Nobody runs this branch's tests or its wrapper.** Written Fri 20 Nov 2026, about 1:35 pm, by the check room. Checked by reading only. It goes back to the build room to be rebuilt against D-364 items 1 to 9 and D-388, and the next round is checked line by line, both halves, by reading.

**Who checked.** Adversarial pass: Codex gpt-6.2-astra, by reading, nothing run: `C:\CE_WORK\check\reports\night-launch_adv_REPORT.md` (13 findings; the clock and path logic proved on 65 of 65 made-up cases in `night-launch_adv_proofs\`). **The honest half did not finish:** the check room stopped its own helper at 1:30 pm on the control room's safety order, because it was running this branch's guard-deletion tests in Tim's hours (see section 4). The verdict cannot be better than HOLD on the adversarial half alone, so the honest half was not run again on a commit that is going back.

## 1. The seven blockers of the first verdict

1. **Nothing reads the clock: STILL OPEN.** The weekday clock is now right at every boundary tried, including daylight saving and another time zone. But nothing in a run owns the 8:00 am deadline: a launch at 7:59 am carries on past it; a Friday night pass can run through Saturday; the wrapper allows 8,700 seconds for a pass with no time kept for closing (`ce_safety.ps1:582-610`, `ce_launch.ps1:26-68`, `ce_pass.ps1:23-30, 51-71`).
2. **Nothing reads the stop flag: STILL OPEN, and worse.** The single scripts now look for it. The new wrapper skips it, DELETES it, and writes its own back at the end (`night_run.ps1:62-70, 128-131`); the tests require that (`test_launch_guards.ps1:124-132, 566-568`).
3. **Nothing reads Tim's switch: STILL OPEN.** A start is refused for missing, broken or in-use; but a switch-only refusal still goes on to close a recorded AutoCAD, and some odd-shaped values pass (`ce_safety.ps1:503-522, 613-625`).
4. **"Ours" by start time and title: CLOSED.** The launcher now starts the program itself, keeps the number it is given, and refuses a hand-over to a second process.
5. **A damaged record passes: STILL OPEN in part.** Text where a number belongs is now refused. A record with an impossible order of times, or written long after creation, still passes; some shared helpers read the record without the age and identity checks (`ce_safety.ps1:138-147, 168-203, 344-359, 408-428`). The record is written up to six minutes after the start: a launcher killed in between leaves a test AutoCAD nobody owns.
6. **The unsaved close knew the drawing by short name: CLOSED** for a same-named drawing in another folder.
7. **Quit and force with another drawing open: STILL OPEN.** The drawings are now counted by asking AutoCAD. But when the count cannot be read at the force step, the force goes ahead (`ce_safety.ps1:541-549`), and a test expects it (`test_launch_guards.ps1:489-491`).

## 2. D-364 items 1 to 9

Item 1 partly; 2 partly (the wrapper removes the stop); 3 not met (no deadline owned); 4 not met (the reason for stopping is lost on the way to the close; two callers can each make the "one" close); 5 partly; 6 partly (the full path is compared, but the night drawing is copied over whatever is there before the second check); 7 not met; 8 not met ("three minutes" is 90 samples of a Windows flag, not three minutes of silence from AutoCAD; a busy PC or lost front window can still end in a force); 9 not met (FAIL and BLOCKED counts are printed and the pass still ends green, `ce_cmd.ps1:43-46`, `ce_pass.ps1:72-76, 96`; an answer can belong to an earlier command; the plug-in file NETLOAD names reports another build, 2ce8070).

## 3. New blockers in this round

1. **The tests can start a real AutoCAD and write to real files.** `test_launch_guards.ps1:237-243` clears test mode and calls the real launcher: the pretend clock, flag, switch, program and drawing are all ignored. On a permitted evening with the flag down and no AutoCAD running, running the TESTS copies over the real night drawing, clears the real record and starts acad.exe. `test_guard_mutations.ps1` runs that group again with one guard deleted at a time. In test mode any path a test leaves out falls back to the REAL record, note, flag, switch, master copy and night drawing; one test makes and deletes a folder under the real user profile (`test_launch_guards.ps1:353-359`).
2. **A pass log can be pointed at any file under the test folder, including the office master copy,** and is written to before any check (`ce_pass.ps1:13, 18-19, 41`).
3. **The night drawing is force-copied over whatever is there** before the launch's second check, whoever left it.
4. **A licence or unknown window can be missed before an act:** the launcher first looks for windows after starting AutoCAD; the plug-in's own windows are now allowed by a title beginning "Pit" or "Pipe" from our process, with any ending; up to 260 seconds can pass between the last check and a send.

## 4. What happened in this check (for the record)

1. The check room briefed its honest helper (Team account) that it might run the pretend-process tests after proving them safe. From 1:15 pm it ran this branch's guard-deletion script from its own scratch copy. The build room saw it at about 1:25 pm and said so; the check room left it running under watch, judging the stop flag and Tim's hours enough. That was wrong: a guard-deletion run removes exactly those guards. The control room ordered it stopped at 1:30 pm.
2. Stopped at 1:30 pm (the helper's own process tree) and 1:31 pm (an orphaned runner it had left, four test runs at a time). None restarted.
3. **Nothing real was touched,** checked at 1:24, 1:25, 1:30 and 1:32 pm: `STOP_ACAD.flag` present, 114 bytes, dated 19 Nov 9:02:20 pm; `open_me.dwg` and `office_master_copy.dwg` unchanged; Tim's switch file unchanged; the results folder last changed 19 Nov 6:43 pm; no new folder in the user profile; no acad.exe or accoreconsole running.
4. **From now (D-388):** no checker or builder runs any script of this branch; both halves of the next round are by reading only.

## 5. What the next round must meet

D-364 items 1 to 9 and D-388 (end of `DECISIONS.md`), line by line: no script deletes, moves or rewrites `STOP_ACAD.flag`; no test can ever reach the real launcher, a real AutoCAD or a real test drawing, even with a path left out, a damaged fixture or a guard deleted; a force only inside the hours a run is allowed, after three minutes of silence from AutoCAD itself, never when the open-drawing count cannot be read, and never for a jam that began before the close started; one named part owns the 8:00 am deadline; a failed check never finishes green. And from section 3: logs and results confined to their own files; the night drawing replaced only when it is known to be the disposable copy; the plug-in's windows recognised exactly; the build that NETLOAD loads shown to be the one under test.

## 6. Follow-ups and what held up

Follow-ups stay in `FOLLOW_UP\night-scripts.md` (items 1 to 19; the report's section 4 says which this round touched). Held up: the weekday clock at every boundary; a second process is never adopted; the unsaved close uses the checked drawing with saving off; PIT, PP, CD, function keys, setting changes, saves and loads are refused by the ordinary send route; no keyboard or mouse is driven; no profile, saved setting or registry write.


---

# Third verdict: team/night-launch at 957383a (the round after the HOLD and D-388)

**Verdict: HOLD. Seven blockers. Checked BY READING ONLY: nothing of this branch was run by the check room or its helpers.** Written Fri 20 Nov 2026, about 6:20 pm. Both readers worked from a plain-text copy of the 15 files (every file renamed with `.txt` added, so nothing in it could be run): a Team helper with no shell at all (Claude Opus 5.5): `C:\CE_WORK\check\reports\nl2_honest_REPORT.md`; and a Codex reader (gpt-6.2-astra): `C:\CE_WORK\check\reports\nl2_adv_REPORT.md`. The check room looked at the real stop flag before and after: 114 bytes, 19 Nov 9:02 pm, unchanged. No changed script copies were found in the temporary folder.

D-364 item 10 stands whatever is written here: no AutoCAD run until the launcher AND the picture route each have the check room's MERGE on both halves and the AutoCAD test room says go.

## 7. What this round fixed (by reading)

No night script deletes, moves or rewrites the stop flag: the wrapper refuses and ends when it finds it. The deadline has one owner; a launch needs 20 minutes before 8:00 am. A refusal by Tim's switch alone closes nothing. "Ours" comes only from the process the launcher itself started. The record's fields are all checked before any is trusted. The unsaved close compares the full path. The drawings are counted before the close and again before a force, and an unreadable count means no close and no force. The pass log and the night drawing are confined, and links to them refused. A licence or sign-in window already showing stops the launch before anything is copied or started. No script touches a profile, licensing, sign-in, a saved setting, the registry, the mouse or the keys.

## 8. Blockers (line numbers are in the `.ps1.txt` copies)

1. **A test that cannot load its sandbox drives the night scripts for real.** `ce_safety.ps1:58`: if the one setting `CE_FAKE_WORLD` is missing, every script runs in REAL mode; the other ten settings fail closed with exit 99, this one fails open. Each test file loads the sandbox with a plain dot-source (`test_launch_guards.ps1:7`, `test_safety.ps1:5`, `test_pass_runner.ps1:7`, `test_guard_mutations.ps1:6`) and never checks that it loaded; a failed load ends only that line. The test then calls the REAL launcher (`test_launch_guards.ps1:59`, `test_safety.ps1:375`), which with the flag down, at night, would copy over the real night drawing and start AutoCAD; in a guard-deletion copy, with a guard missing. D-388 item 2. Both readers. Fix by design: real mode needs a positive token; a missing switch never means real; each test stops if the test world is not on.
2. **The test runner can write over any file, the stop flag included.** `test_all.ps1:7-10, 14-15, 22` takes a log destination from its caller, replaces that file at once and appends to it, before the scan, with no check of folder, name, link or ownership. D-388 item 1: no script may rewrite the flag.
3. **The test runner can report PASSED when every suite failed.** `test_all.ps1:11-28`: its helper returns several things and the caller treats that as true; the scan's refusal at line 23 is skipped. D-388 item 6: a failed check never finishes green. Also: a hard-link or junction case that cannot be set up is counted as a PASS (`test_launch_guards.ps1:884, 889`; `test_safety.ps1:413, 417`), and a guard-deletion run counts ANY failure in a group as proof of the removed guard (`test_guard_mutations.ps1:36-55`).
4. **The launcher writes down the AutoCAD it started only minutes later, and the wrapper can kill it in between.** The process is created at `ce_launch.ps1:33`; the record is written at `:77`, after up to about 365 seconds of waiting; the wrapper gives the launcher 420 seconds and on a time-out kills only that PowerShell (`night_run.ps1:57, 83`). Then there is no record, no leftover note, a test AutoCAD nobody owns left running into Tim's day, and the wrapper prints "No AutoCAD of ours is running" (`:89`). D-364 item 1: recorded at the moment of creation. Both readers. Write the leftover record the moment the start returns.
5. **A force can follow an answer from AutoCAD.** `ce_safety.ps1:677-709`: at the last look the count of open drawings is read by asking AutoCAD, and AutoCAD ANSWERS; the code then forces on the three minutes of silence measured before that answer. D-388 item 4, D-364 item 8: three minutes of silence from AutoCAD itself. The silence clock also starts before the close and quit calls and is not reset when one of them is answered (`:659-687`).
6. **A busy PC, a lost front window or a stop can lose its "never force".** A sender can wait 120 seconds for quiet, plus two checks of 20 seconds, plus its send: about 420 seconds; the pass gives a step 60 by default and the wrapper 300 (`ce_pass.ps1:17, 85-89, 113-116`; `night_run.ps1:26`). When the parent times out first, the busy reason is never reported, the step is called a jam, and the close may force. The Undo steps drop the reason the same way (`night_run.ps1:113-150`). D-364 item 8.
7. **Fifty-six of the 89 guards have never been proven by taking them out.** The builder's own warning. The force set and the record, switch, licence and send-sequence guards are among them. By reading, a test that would fail exists for 55 of them (several only on the wording of the reason, because a second guard still refuses); reading is not proof. The first HOLD made this a requirement. How the proof can be got safely is question 1.

## 9. Also found (to fix in the same round; several would be blockers if a night ever ran)

1. **Green on the wrong evidence:** any fresh non-blank text counts as the answer for the ownership command and both Undo commands (`ce_safety.ps1:462-502`): a report saying the WRONG plug-in owns the command passes; only the first summary line of an answer is read; nothing shows which plug-in or which build answered (the old plug-in loads beside the build under test: D-351); the fingerprint is of a file on disk, not of the code that answered; a zero exit from the load step is taken as loaded (`ce_pass.ps1:69-79`); the wrapper calls a crash between the last read and the close "AutoCAD closed without saving ... everything is proven" (`night_run.ps1:143-159`).
2. **Writes that could land elsewhere:** only the pass log and the night drawing are checked for links; the record, close-state, note, leftover file and the latest-log copy are not (a link planted under one of those names would be written through, the flag included); the check and the write use different forms of the path; the wrapper writes its log before it looks for the flag and then says "nothing was created".
3. **The deadline:** the close can keep asking AutoCAD questions for up to 15 minutes from its start, to about 8:05 am; margins of 70, 40, 30 and 900 seconds are spread over four files; a manual `acad_close.ps1` between 8:30 and 9:00 am would close the test AutoCAD in Tim's hours.
4. **Windows:** before the start only licence and sign-in windows stop it, not an unknown one; a "Fatal Error" box has no rule of its own (it stops only as an unknown window of our own process); a failed listing of windows, of processes, or an unreadable flag reads as "nothing there" on the start and send path; the Pit and Pipe title list expects "Pipe · P1 to P2", which D-398 has changed.
5. **A killed step can leave its sender running,** which could still send after the pass has stopped.
6. **A rehearsal can look like a real night:** the same success words are used in the test world.
7. **The static scan is a tripwire, not a proof:** it matches names only (a variable, a wildcard, a parent-folder delete, a redirection or a link gets past), skips the test driver and itself, and always passes its sandbox-order check.
8. **The scripts will run from anywhere,** the temporary folder included, where stopped deletion runs left copies with guards removed (none found there now).

## 10. For the control room

1. **Who gets the deletion proof for the 56 guards, where and when?** D-388 bars the rooms. Recommended: after blocker 1 is fixed, on a throwaway Windows machine or sandbox with NO AutoCAD installed, no `C:\CE_WORK\civil_tests` and no `.timos` folder, a fresh temporary folder; run by the build room or a runner you name, at a time written on the board; the log and summary handed to the check room with the commit it ran on. Never on Tim's PC.
2. **Did the builder's runs break the HOLD?** The HOLD said no builder runs any script of this branch; D-388 item 3 as filed bars runs after 5:30 pm and at weekends. The builder ran the suites and four guard-deletion runs in Tim's hours on 20 Nov and stopped at 5:29 pm; its before-and-after lists show the four real files unchanged. Which reading stands from now?
3. **Should every file the scripts write refuse a link, and every script refuse to run from the temporary folder?** (Recommended: yes to both.)
4. **What does AutoCAD itself write to Tim's profile and registry when a test AutoCAD starts and quits** (recent files, window places)? Rule 1.9 forbids changing a saved setting; nobody has looked. Is that for the AutoCAD test room to answer before the first night?
5. **May the close keep asking AutoCAD questions after 8:00 am, and may a manual close run between 8:30 and 9:00 am?** (Recommended: no to both.)

## 11. What reading could not settle

How long one launch tick takes on Tim's PC; whether a loaded plug-in shows in the process's module list; the real title and owner of a "Fatal Error" box; whether a jammed AutoCAD times out or fails at once; the real answer files' format; whether the 56 guards' tests truly fail without them. All but the last can only be seen in a test AutoCAD after MERGE and the test room's go.

## 12. Ruled since (control room, about 6:27 pm, D-420; adds to D-364 and D-388)

1. **From now NO ONE runs any script, test or wrapper of a night-script branch on Tim's PC, at ANY hour, weekend included.** The Friday runs in his hours are recorded as an incident, no harm found.
2. **The deletion proof of the 56 guards is NOT run on Tim's PC.** It needs a throwaway Windows place with no AutoCAD, no `C:\CE_WORK\civil_tests` and no `.timos` folder; none exists today; making one is Tim's choice, listed for Monday.
3. **AutoCAD testing stays STOPPED all weekend:** the gate cannot be met without that proof.
4. **Meanwhile the seven blockers are fixed and checked BY READING ONLY:** a test that cannot load its sandbox STOPS (fails closed); the test runner writes only inside its own sandbox folder, never a path its caller names, and never reports PASSED when a suite failed; the launcher records its AutoCAD BEFORE starting it; no force after AutoCAD has answered; "never force" cannot be lost on a busy PC.
5. **Every file the scripts write refuses a link; every script refuses to run from the temporary folder.**
6. **The close asks AutoCAD nothing after 8:00 am; no manual close runs between 8:30 and 9:00 am on a weekday.**
7. **What AutoCAD itself writes to Tim's profile and the registry on start and quit** is answered by the AutoCAD test room, by reading and research only, before any first night; it is part of the gate.
