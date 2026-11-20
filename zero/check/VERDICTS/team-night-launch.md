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
