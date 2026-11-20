# Verdict: the picture route, branch team/acad-pictures2 at b876264

**Verdict: HOLD. Nobody uses this route, and nobody runs its tests in Tim's hours.** Written Fri 20 Nov 2026, about 1:58 pm, by the check room. Checked by reading only, both halves (D-388): nothing on the branch was run, built or started.

**Who checked.** Honest check: Team helper, Claude Opus 5.5, given no command tool at all: `C:\CE_WORK\check\reports\acad-pictures2_honest_REPORT.md` (the eight conditions of `C:\CE_PLAN\zero\acad_test\PICTURE_ROUTE.md` each judged; nine blockers). Adversarial pass: Codex gpt-6.2-astra, by reading: `C:\CE_WORK\check\reports\acad-pictures2_adv_REPORT.md` (14 blockers; 28 pure-logic comparisons as predicted, in `acad-pictures2_adv_proofs\`). They agree on the main faults. The builder's test counts (160, 131, 4, 58) were not re-run and are not the check room's.

## 1. What is sound (the part inside the plug-in)

The night switch lives in memory only and arms only on the test drawing's exact full path; a drafter's build leaves the route out and a test builds it both ways to show so; the window driver works from inside the plug-in on the plug-in's own window through each control's own "invoke", with no mouse and no keys; PIT, PP and CD cannot be sent (a whole-line list of allowed text, checked in three places); a window is expected by its handle and step, not its title; it lets go after 20 seconds; a missing picture is NOT RUN, never PASS. Seven of the route page's eight conditions are met as written.

## 2. Blockers (each a breach of rule 1.9, D-364 or D-388)

1. **The runner would drive the test AutoCAD in Tim's day.** Its clock refuses only 8:30 am to 2:00 pm and 3:00 to 5:30 pm, so it runs 2:00 to 3:00 pm on weekdays and up to 8:30 am; a test locks 2:30 pm in as allowed; nothing owns the 8:00 am deadline; a clock that cannot be worked out falls back to the PC's own time (`acad/night_scripts/ce_pics_common.ps1:77-87`; `test_pics.ps1:264`; `acad/PICTURE_ROUTE_BUILD.md:13`). D-364 items 2 to 4.
2. **The stop flag is read once, at the start; Tim's switch file is never read** (`ce_pics_run.ps1:38-39, 44-57, 73-94`). A flag raised mid-run stops nothing.
3. **A refusal can itself delete or write into the stop flag, or into the office master copy.** The paths for the "step in hand" file, the log and the pictures folder can be set from outside in a real run and are not confined; the first refusal clears the step file and appends to the log before any check (`ce_safety.ps1:134-142`; `ce_pics_run.ps1:22-39`). D-388 item 1.
4. **The sending helper can be run on its own, past every check but the list of allowed text** (`ce_pics_send.ps1:12-20`): with Tim's AutoCAD the only one running and its active drawing called `open_me.dwg` from any folder, it would be sent PT. And "ours" still rests on main's launcher, which records an AutoCAD by start time and title: the route cannot be run until a launcher has MERGE on both halves.
5. **A picture can show another program.** When the first two picture methods fail, the last one copies the screen where the window should be: whatever is on top there is saved (another window, a sign-in page, a file path, another drawing), and the file is written before it is judged (`src/CeCivil.Night/Pictures.cs:175-187`; `WindowDriver.cs:142-159`; `NightRoute.cs:184-201`). The route page allows a screen copy last; the check room holds it because the picture is kept and counted. Save only what the checked window itself supplies; otherwise the picture is missing.
6. **The tests reach the real desktop, and can take Tim's keyboard focus.** The window-driver tests show a real window (placed far off screen) and fill it; filling a box makes the window ask Windows to come to the front (`tests/CeCivil.Night.Tests/WindowThread.cs:27-34`, `WindowDriverTests.cs:24-45`; `src/CeCivil.Window/WindowHost.cs:132-137`). Two tests pass a made-up window number to the real Windows calls; with a pretend setting left out, `test_pics.ps1` looks at the real desktop's windows and can remove the real step file or write to the real note. D-388 item 2.
7. **A damaged marker lets every window of the test AutoCAD through as "expected"** (`ce_safety.ps1:152, 162-165`): text where a number belongs skips the refusal, the same fault as the damaged record. A save prompt or a sign-in page with an ordinary title would then be passed over.
8. **A stop does not stop work already on its way:** the inner sender and the window driver carry on after the runner halts; the driver fills, pictures and presses with no fresh check of clock, flag, switch or drawing (`ce_pics_run.ps1:64-97`; `WindowDriver.cs:94-160`). A step is tied to a window by process, step name and time only, so a different CE window opening then would be filled and answered.
9. **False green.** A command is counted once it is sent; the arming command is never confirmed; the run ends as a pass after a failed switch-off; results and pictures are read from the day's folder by "the latest", so an earlier run's or another build's can stand in for tonight's; the one passing test makes its pictures before the runner starts (`ce_safety.ps1:237-248`; `ce_pics_run.ps1:94-157`; `ce_pics_common.ps1:92-124`; `test_pics.ps1:49-70, 204-215`). D-364 item 9, D-388.
10. **The night build has the same file name as the drafter's** (`CeCivil.Acad.dll`) and is copied by hand into the shared folder the test plug-in is loaded from; the "release leaves it out" test looks only at two files it has just built. Nothing stops a night build being handed to a drafter.
11. **Guards with no test that fails when the guard is removed:** the hours check inside the run, the test-copy check, the allowed-text check in two places, the damaged marker.

## 3. What the next round must meet

D-364 items 1 to 9 and D-388 line by line, as for the launcher; every path fixed and confined in a real run; the sender refusing on its own; a picture only from the checked window; tests that cannot open, raise or look at a real window, file or process, even with a setting left out; a result tied to this run, this build and this step; the night build told apart from the drafter's by name and refused by the deploy. Both halves by reading only.

## 4. For the AutoCAD test room

Do not use the route or run its tests. When it does pass: night one is one PT in Cancel mode only; every picture is looked at by a person before it leaves the PC (a copy of AutoCAD's own window shows file tabs and the command line of Tim's profile); what only AutoCAD can show is in the honest report, section 7 (nine items, among them whether the driver's timer runs inside a modal window and whether the Size list's pop-up trips the two-second rule).

## 5. Follow-ups

The honest report's section 6 (14 items) and `FOLLOW_UP\night-scripts.md`. The step limit is 120 seconds plus 60 where the run rule says 60; the full night (the Undo-join step, EXPLODE) is not built yet: only night one's single step exists.

## Ruled by the control room, about 2:15 pm by its clock

1. **HOLD agreed.**
2. **The screen copy is dropped.** A missing picture is simply NOT RUN; pictures come only from the plug-in's own window render and AutoCAD's own view picture. The AutoCAD test room strikes the screen copy from condition 8 of `acad_test\PICTURE_ROUTE.md`.
3. **No test in this branch may show a real window or take focus;** nobody runs its tests until that is so (D-388 item 2).


---

# Second verdict: team/acad-pictures2 at 8804441 (the picture route, round 2)

**Verdict: HOLD. Besides the night launcher's seven blockers, which this branch carries (the launcher at 957383a is merged into it), the picture route's OWN part has nine blockers by reading.** Written Fri 20 Nov 2026, about 7:15 pm. Checked BY READING ONLY (D-388, D-420): nothing of this branch was run by the check room or its readers. Both worked from a plain-text copy (every file renamed with `.txt` added): a Team helper with no shell (Claude Opus 5.5): `C:\CE_WORK\check\reports\pic2_honest_REPORT.md`; a Codex reader (gpt-6.2-astra): `C:\CE_WORK\check\reports\pic2_adv_REPORT.md`. The real stop flag was looked at before and after: 114 bytes, 19 Nov 9:02 pm, unchanged. Line numbers below are in the `.txt` copies.

Under D-420 no reading can open the gate: AutoCAD testing stays stopped until the guard-removal proof is made away from Tim's PC. This verdict says what is left to fix by building and reading.

## A. What is sound now

The screen copy and the copy by window handle are gone: code, dead code and tests. Every place the runner reads or writes is fixed in a real run; each run has its own folder. The runner reads the stop flag, Tim's switch, the hours and the deadline before every step, before every send and every half second; the hours have one owner and no 2 to 3 pm window. The switch on and off are confirmed from the run's own log. The night build has its own name and is left out of the released plug-in. The C# tests never show a window. The step file and the runner's log refuse a link.

## B. Blockers in the picture route's own part

1. **A picture can hold real content.** The checks identify the FILE (the test copy by its full path), not what is visible in it. If the test copy shows an external reference, a nested reference, a layout viewport or an attached image, or holds unsaved content, the route centres the view, takes AutoCAD's own view picture and saves it; a centring fault is logged and the picture is taken anyway (`NightSwitch.cs:38-49`; `NightRoute.cs:200-232, 237-251`; `ce_safety.ps1:489-497, 1053-1075`). A fingerprint of the master at launch proves nothing about what it references. What the office master copy really holds is NOT PROVEN BY READING. Hard limit: nothing of a real drawing is ever copied into a file. Require a made-up drawing that is checked to stand alone (no references, no images), and a checked view, before any picture is written.
2. **A Pit or Pipe window is let through by its title alone.** `ce_safety.ps1:431` passes a window by its marker OR by its class and title (`:30-43, 187-191`): no marker, no step in hand. A window left open after a timed-out step passes the end-of-step and the close checks, and the runner goes on typing. Even the marker arm accepts a step with no run number, writer or deadline. The tests miss it: every pretend CE window has an empty class (`test_pics.ps1:37`), and a launcher test expects the opposite answer (`test_launch_guards.ps1:299-305`). In a picture run only a live, matching run, step and owned window counts.
3. **Writes that are not safe from links** (D-420 item 5; D-388 item 1). The window marker is written by a fixed name with no link check (`WindowMarker.cs:25-37`); the C# path check compares spelling and never looks at links in the folder chain (`TestFolder.cs:17-31, 46-50`); picture bytes go through a fixed partial name before the image is checked (`Pictures.cs:22-41, 95-99`; `NightRoute.cs:224-231`); the scripts' link helper answers "clear" for a missing entry and looks only at the last name (`ce_safety.ps1:323-332, 341-387, 516-529`); the note writer checks nothing (`:462-468`).
4. **The new C# test wrapper writes over any file its caller names, and reports PASSED whatever happened** (`run_night_cs_tests.ps1:7-23`): the launcher's blockers 2 and 3 again, in a file this branch adds. Its own scan also contradicts one of its tests (`NoRealDesktopTests.cs:14-17, 85-96`).
5. **A picture test whose sandbox fails to load reaches the real world** (`test_pics.ps1:12-20`): the launcher's blocker 1 again. In real mode the marker tests list the real desktop's windows, and the runner tests start the real runner, which can clear the real step file and write to the real runner log. D-420 item 4: such a test must STOP.
6. **Copies with guards removed can be run from the temporary folder** (`test_guard_mutations.ps1:45-49, 60-75`), and no picture script refuses to run from there (D-420 item 5).
7. **Who may send.** The sending helper accepts a parent whose command line merely CONTAINS the runner's name (`ce_pics_send.ps1:14-36`), and a test expects a different program of that name to be allowed (`test_pics.ps1:501-529`); the inner send does not compare the AutoCAD it reaches with the recorded one. The picture sender also skips the busy-desk check the ordinary sender makes (`ce_cmd.ps1:25-35` against `ce_pics_run.ps1:62-75, 104-124`), and the real plug-in window calls Show and Activate when a recipe changes a field (`WindowHost.cs:65-67, 110-144`): it can ask for the front. Whether Windows grants that is NOT PROVEN BY READING.
8. **A stop does not reach work already inside AutoCAD, and nothing closes the test AutoCAD.** After the runner halts, the plug-in's own driver keeps its recipe and deadline and can still fill, take pictures and press OK (`WindowDriver.cs:151-163, 195-251`; `NightGuard.cs:40-75`); a "Fatal Error" box is only an unknown window. No part of this route makes the one normal close of D-364 item 4, and the night wrapper never calls the picture runner: a flag raised at 7:55 am leaves a test AutoCAD running into Tim's morning with only a note (`ce_pics_run.ps1:49-54, 91-96, 147-211`).
9. **One run can remove another run's hand-over.** There is one shared step file; clearing it never checks whose it is (`ce_safety.ps1:335-362`; `ce_pics_run.ps1:145-182`); the marker is deleted on finish even by a driver that never wrote it (`WindowMarker.cs:25-37`).

## C. The proof that is owed

None of the 21 picture guards has been run with the guard removed, and D-420 item 2 keeps that proof off Tim's PC. By reading, three would not be proven even then: `send_parent` and `step_file_confined` would survive removal, and `marker_strict` is caught only because removing it breaks the good case. The link refusals, the sender's own allowed-text check and the test-copy-by-title check have no tag and no test.

## D. The launcher's seven in this branch

Blockers 1 to 3 (the fail-open sandbox; a log written over any file; PASSED on failure) have SPREAD into new files here; 4 to 6 are unchanged; 7 (unproven guards) has grown by 21.

## E. For the control room

1. **A made-up test drawing for pictures.** The route photographs whatever the test copy shows, and the test copy today is a copy of the office master. Should the picture route be allowed to run ONLY on a drawing made by the tool itself for the night (pits and pipes drawn by the tests, no references), never on a copy of an office drawing?
2. **Who closes the test AutoCAD after a picture run or a stop:** the picture runner itself, through the one safe-close owner, inside the run?
3. **What AutoCAD's own view picture shows when a window sits over the drawing,** and whether the plug-in's window timers run while its window is open: both NOT PROVEN BY READING; for the AutoCAD test room's first night, after the gate.

## F. Ruled since (control room, 7:15 pm, D-423)

1. **Tim's security rule, not a draft:** pictures ONLY of a drawing the tool itself made for that night (blank start, pits and pipes drawn by the tests, office set-up from the plug-in's own scanned shipped copies). Never a copy of an office drawing, master or template. Before EVERY picture the route proves no xref, no attached image or PDF, no pasted object and no layout viewport of anything else; otherwise no picture, the run stops and says why. The next round is held to this.
2. **The picture runner closes its own test AutoCAD** after a run or a stop, through the launcher's ONE safe-close owner, by 8:00 am; a late stop flag must not leave it running.
3. **The two AutoCAD-only questions** go on the AutoCAD test room's list for after the gate.
4. **Fixed by building and reading only;** run by no one on this PC (D-420).
