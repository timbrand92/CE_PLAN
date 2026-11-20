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
