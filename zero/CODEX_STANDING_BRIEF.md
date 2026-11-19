# Standing brief for Codex (goes at the top of EVERY Codex job on this project, unchanged)

**Why this exists.** Tim, 19 Nov 2026: "make sure codex abides by our rules and decisions". A Codex run that breaks any line below is thrown away, whatever it produced. The build chat pastes this whole page into every Codex prompt, checks the result against it before merging, and records beside each result which model ran.

## 1. Hard limits (never broken, whatever the task says)

1. **AutoCAD's profile and licence (rule 1.9, in full):** no chat, helper or robot may, without Tim's yes in words in that conversation: make, copy, rename, delete or switch an AutoCAD profile; start AutoCAD under another profile; force-close AutoCAD or its headless engine (if it is stuck, leave it, stop, tell Tim); touch Autodesk licensing or sign-in in any way; or change a saved AutoCAD setting or the registry. If a licence or sign-in window appears: do nothing to it, stop, report. The one exception: a robot may close (normal close first, then force) a TEST AutoCAD that it started itself that night on a test copy, when it jams or crashes. Never an AutoCAD of Tim's, never one it did not start.
2. **You do not start AutoCAD, drive the mouse, or run with full machine access.** You work in your own workspace copy only. The build chat runs any AutoCAD test, on test copies, outside Tim's hours (not 8:30 am to 5:30 pm on weekdays).
3. **Nothing is installed into AutoCAD.** Do not touch the installed old plug-in, its bundle folder, or any file under Tim's AutoCAD or Autodesk folders. Never type or script the commands PIT, PP or CD. No function keys or keyboard shortcuts.
4. **Client data:** no client names, job addresses or job numbers in any file, name, note, message or test. Never open the office Projects folder. Keys and passwords live only in Tim's keys file and are never read, printed or copied.
5. **Files:** work only in the folder you are given. Delete nothing except files you created yourself in this run, inside a folder you created in this run. No bulk find-and-replace across files. Do not rewrite git history; do not push; do not merge; commit only on your own branch.
6. **Stop and report** instead of guessing when a ruling is missing, two rulings disagree, or a limit above would have to bend.

## 1A. What is being built, and only this (Tim, 19 Nov 2026, D-337, D-338, rule R-72)

1. **One release for one detention job.** The whole scope and the order of work are in `C:\CE_PLAN\zero\stage6\ONE_JOB_RELEASE.md`. Anything not on that page is paused: do not build it, fix it or tidy it. If your task is not on that page, stop and report "OFF THE PLAN".
2. **Your report starts with four lines:** Release; "Part N of 9: name" and the step; the four counts Built, Checked, Installed, Accepted as given in `C:\CE_PLAN\BOARD.json` (read it, do not edit it); and what your run moved.

## 2. Where the rules and decisions are (read before changing anything they cover)

1. **What is decided now, by subject:** `C:\CE_PLAN\zero\rulings\INDEX.md` and the page for the subject in hand (26 pages, to D-297).
2. **Newer decisions:** the end of `C:\CE_PLAN\zero\DECISIONS.md`, D-298 onward. Tim's words in quotes are the ruling; a line marked "planning chat's call" is a draft he may overturn.
3. **Screens:** `C:\CE_PLAN\zero\design\SCREEN_RULES_18NOV.md` (his 31 rules) and `design\STYLE_APPROVED_18NOV.md` (the approved style; Detention has its preview across the top, D-299 to D-305).
4. **How the thing is built:** `C:\CE_PLAN\zero\design\FOUNDATION.md`; the gate every tool must pass: `stage6\OBSTACLE_COURSE.md`; speed limits: `stage6\PERFORMANCE.md`.
5. **The repository's own notes:** the top of `BUILD_LOG.md` in the code repository.

## 3. How work is done

1. **A failing test first,** then the fix; the test stays as a permanent check.
2. **Never change a sum, a check, a limit or a printed wording to make a test pass.** If a test and a ruling disagree, the ruling wins and you say so.
3. **Figures:** a check on a level or a cover passes within the job's tolerance, a setting in the Job window that opens at 5 mm (D-318, D-321); outside it the check says how short. A grade passes when it meets the required figure at two decimal places. Rounding for display never decides "Suits" by itself; the one rounding inside a sum is Boyd's inflow, to two places, as the office sheet does. A missing value reads exactly "Not known" on a window and "TBC" on the sheet: never 0, never a guess. A bad input reads Wrong and what depends on it reads "Cannot check yet".
4. **Nothing pretends to work:** no button or box that does nothing; no confident figure from a refused input.
5. **Drawing safety:** test the layer lock, xref and reference-edit before any edit and say so in words; one undo per command; a grip click never returns the failure value; a copy by any route gets its own identity and, for a pit, the next free number.
6. **Words:** plain English a drafter would use, Australian spelling, metric; no build wording on any screen.
7. **Honest report at the end:** what you changed, the tests run and their counts, what you did not do, anything you were unsure of, and which ruling each change follows. "Built", "tested", "installed" and "accepted" are four separate facts; never call something done on a green build.
