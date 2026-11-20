# Verdict: the night scripts as they stand on main (22993fa)

**Verdict: HOLD. Not safe to run tonight as they stand. Seven blockers (four from the honest check, three more from the adversarial pass, section 8).** Written Fri 20 Nov 2026, 11:24 am, by the check room; added to at 11:30 am. Checked on the bench, by reading; nothing here says anything works in AutoCAD.

**What was checked.** Everything in `acad\night_scripts` on the main line of `C:\CE_CIVIL` at 22993fa, against rule 1.9 in full, the D-160 exception, Tim's hours, the stop flag and his switch file. Asked by the control room after the AutoCAD test room found gaps.

**Who checked.** Honest check: Team helper, Claude Opus 5.5, in `C:\CE_WORK\check\night-main_honest`; full report `C:\CE_WORK\check\reports\night-main_honest_REPORT.md`. Adversarial pass: Codex gpt-6.2-astra, still running at the time of writing; its findings are added at the bottom when it lands. The verdict cannot improve on HOLD whatever it finds.

**Seen by the check room itself.** A search of the eight scripts for the stop flag's name, the switch file's name, and any hour or weekday test finds nothing at all; the launcher's lines 1 to 23 read as described below.

## 1. Tests seen

1. **`test_safety.ps1`:** 123 of 123 passed. **`test_pass_runner.ps1`:** 4 of 4 passed. Run by the helper at 11:17 am after it showed, line by line, that both use made-up processes only. Log: `C:\CE_WORK\check\reports\night-main_honest_tests.log`. Tim's own AutoCAD was running before and after, untouched.
2. **What those tests do not cover:** the launcher (no test at all), hours, the stop flag, the switch file, and the real reading of processes and windows. Several guards can be deleted with every test still passing (the launcher's "already running" refusal; the real "another AutoCAD is running" line; the real keyboard-and-mouse idle check).

## 2. Blockers (all are breaches of a hard limit: rule 1.9, Tim's hours, his switch)

1. **Nothing reads the clock.** `acad/night_scripts/ce_launch.ps1:5-8`, and no other script either. On a weekday in Tim's hours, with his own AutoCAD closed for a moment, the launcher starts a test AutoCAD and the pass sends commands to it. A pass started at 8:25 am keeps going into his hours.
2. **Nothing reads `C:\CE_WORK\civil_tests\STOP_ACAD.flag`.** The flag is on disk now and stops nothing; only people obeying it keep it in force.
3. **Nothing reads Tim's switch file** (`C:\Users\TimothyBrand\.timos\autocad.json`), so "in-use" is ignored and a missing or unreadable file is not treated as IN USE.
4. **The launcher decides which AutoCAD is "ours" by start time and window title, not by having created it.** `ce_launch.ps1:8` hands the drawing to Windows and never learns the id of what it started; lines 11 to 23 then adopt whichever AutoCAD started after that moment and shows the test drawing's name. If Tim starts his AutoCAD in those minutes and Windows hands the test drawing to it, his AutoCAD is recorded as ours: the test plug-in is loaded into it, commands are sent to it, and a jam could end in a forced close of it (`ce_safety.ps1:335`). Narrow, and it rests on behaviour of Windows and AutoCAD nobody has observed; counted because any such route is a blocker by the control room's instruction.

## 3. What is sound

Once a process is recorded, the close-and-force ladder re-checks the recorded id, start time and name, the exact window title, and licence and sign-in windows straight before every act. No route was found by which a recorded-and-checked close or force goes ahead while a licence or sign-in window that the window list can see is showing. Nothing in the scripts clicks or sends keys. No night script changes a profile, a saved setting or the registry.

## 4. What the launcher fix must show before it gets MERGE (the list the check room will use)

1. **Hours (as ruled by D-364):** a test sets "now" to a given Melbourne time and PC time zone. No start on a weekday from 8:30 am to 5:30 pm (the 2:00 to 3:00 pm gap is NOT open to a start under D-364); a pass is finished and its test AutoCAD closed by 8:00 am; evenings after 5:30 pm, before 8:00 am and weekends pass; another PC time zone gives the same answers; a time that cannot be worked out refuses.
2. **Stop flag:** while it exists the launcher, the pass, the command sender and the NETLOAD sender all refuse, each checking straight before it acts.
3. **Switch file:** missing, empty, damaged, unknown mode or "in-use" refuse; "free" with a past "freeUntil" falls back to hours; the snapshot lines in the file are never trusted.
4. **Checked again, not once:** hours, flag and switch are read before each step, send, close and force. A test changes the clock or the flag mid-pass and nothing further is sent.
5. **Ours means created by us:** the recorded id is that of the process the script itself created. Another AutoCAD appearing during the launch makes it refuse and record nothing.
6. **Beside Tim's:** with any AutoCAD running nothing is started; a test AutoCAD is never left running unrecorded.
7. **Licence or sign-in window during launch:** nothing is touched, a note for Tim is written, the launch stops.
8. **Test mode starts nothing real.**
9. **Every new guard has a test that fails when the guard is removed** (shown on a scratch copy).
10. **Nothing loosened:** the 123 and 4 existing checks pass unchanged.

## 5. Ruled by the control room at about 11:35 am: D-364 (the fix is checked against it line by line)

1. **Ours:** the launcher counts an AutoCAD as its own only if it created that process itself and recorded its process number at the moment of creation; never by title or start time.
2. **No start:** between 8:30 am and 5:30 pm on weekdays; while the stop flag exists; unless Tim's switch file can be read and does not say in use (missing or unreadable means IN USE); while any AutoCAD is already running.
3. **Finished by 8:00 am:** a night pass is finished and its test AutoCAD closed by then.
4. **Flag goes up or 8:00 am arrives mid-pass:** stop sending at once; ONE normal close without saving of its own test AutoCAD, and only if no licence, sign-in or unknown window is showing; NEVER force in that situation; if it does not close, leave it open with a note for Tim.
5. **D-160's force** applies only at night, before 8:00 am, with no stop flag up.
6. **Required by the control room:** deleting any guard makes a test fail.

## 6. Follow-ups

Kept in `FOLLOW_UP\night-scripts.md` (11 items). The one that matters most for Stage 1: the plug-in's own Pit and Pipe windows are not on the list of known window titles, so any night test that opens one halts the pass. That fails safe, but no Pit or Pipe test can finish until it is dealt with, and the answer must not be "any window of our process is fine".

## 7. About the earlier MERGE of team/night-safety2

That check read the round-2 changes only and its verdict on those changes stands. It was not a check that the scripts as a whole are safe to run, and the four blockers sit in lines that change did not touch.

## 8. Adversarial pass (Codex gpt-6.2-astra, by reading; landed 11:26 am)

Full report: `C:\CE_WORK\check\reports\night-main_adv_REPORT.md` (12 items it calls blockers, 12 follow-ups). It ran none of the scripts; one proof file of 31 text-and-number comparisons, 31 as expected. It confirms blockers 1 to 4 above. Graded by the check room under D-346 and the control room's instruction, THREE MORE ARE BLOCKERS, so the count is seven:

5. **A damaged record can pass the "is it ours" check.** `ce_safety.ps1:112, 116`: if the record file is readable but its process number or start time is not a number, the comparison errors and the refusal on that line is skipped; the check carries on to "ours". Shown in the proof file for Windows PowerShell. Also: the record's place can be pointed elsewhere by a setting (`:32`), and nothing ties a record to the run that wrote it. Kind: breach of a hard limit (acting on an AutoCAD not shown to be ours). The fix must check every field before trusting any, and refuse on any error.
6. **The close-without-saving knows the test drawing by its short name only.** `ce_safety.ps1:184-190`: any active drawing called `open_me.dwg`, from any folder, with unsaved work, is closed with saving switched off; so is the real test copy if a person has edited it. `ce_launch.ps1:3, 8` accepts any drawing path. Kind: an edit that could lose drawing content. The fix must know the full path of the test copy before opening and again before any send or close.
7. **Quit and force take every drawing open in that AutoCAD.** `ce_safety.ps1:301-308, 320-335`: only the active drawing's title is looked at; the quit helper skips the drawing check altogether (`:183-191`). A second drawing opened in the test AutoCAD (a double-click at night lands there) is lost unsaved. Kind: an edit that could lose drawing content. The fix must count the open drawings and refuse an application-wide close, quit or force when any drawing other than the test copy is open.

**Graded follow-up, not blocker (added to `FOLLOW_UP\night-scripts.md` as items 12 to 19):** a licence or sign-in page inside a window with an ordinary title is not seen; a window can appear between the last check and the act; "still running" is treated as "jammed" (a busy PC or lost foreground can end in a force on a healthy test AutoCAD, which D-160 allows only for a jam or crash); no list of allowed commands; record, note and log paths are not confined to the test folders; the shared helpers can be called with fewer checks than the top scripts; a command error is reported as success; a stopped step can leave its sender alive.

**Tests:** the adversarial pass also shows the existing tests can stay green with guards missing, including one assertion that accepts incomplete text (`test_safety.ps1:272`).
