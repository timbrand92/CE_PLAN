# Stage 4: the build trials (brief for the trial chat)

**Purpose.** Prove, in real AutoCAD 2027, that the foundation can be built on ordinary AutoCAD objects before any tool is built. A trial is throwaway: its code is NOT the start of the plugin. If a trial fails, the build approach changes before anything else happens.

**Read first, in this order:** `design\FOUNDATION.md`, `design\UI_PLAN.md`, `design\BUILD_APPROACH_DRAFT.md`, `reference\research\R-002_HOW_TO_BUILD_IT.md` (each trial is described there under its letter, with what "pass" looks like), `stage5\HOW_WE_WORK.md`, and D-015, D-031 to D-037, D-094 in `DECISIONS.md`.

## Limits (Tim's rules; no exceptions)

1. **Where the code lives:** a new folder `C:\CE_WORK\trials\zero\` only. Not in the plugin repository, not in `C:\CE_PLAN`. No branches, no pull requests, nothing committed anywhere except the results file named below.
2. **Nothing installed.** The trial plugin is loaded by hand into a trial AutoCAD (NETLOAD or a script) and never copied into any ApplicationPlugins folder, except trial 9, which uses a per-user bundle named `CE_TRIAL_ZERO.bundle` and removes it afterwards. The installed CE plugins are never touched, replaced or rebuilt. Never build the existing plugin solution.
3. **AutoCAD hours (D-092, D-093):** 5:30 pm to 8:30 am on weekdays and all weekend. Inside those hours a trial may start its own AutoCAD whatever the switch file says, provided none of Tim's AutoCAD windows is open. If one is open: leave it alone, never close it, wait, and say so. Outside those hours do pure-code work only (trial 11) or stop.
4. **Test copies only.** Drawings are made up by the trial, or copies under `C:\CE_WORK\trials\zero\dwg\`. Never open a job folder. No client names, addresses or job numbers in any file.
5. **PowerShell** longer than two or three lines goes in a .ps1 file. Existing helpers: the headless engine notes in memory "accoreconsole plugin probe"; the driver at `C:\Lisp Files\_ACAD_DRIVER` for typing commands into a real AutoCAD; Autodesk skills `acad-dotnet` and `autocad-net-api`.
6. **Honesty.** Each trial ends PASS, FAIL, BLOCKED or NOT TESTED with what was actually seen. A trial run only in the headless engine says so; it is not a pass for the full program unless trial 10 has shown the two agree.

## The trials, in running order

1. **Trial 11, any direction (no AutoCAD; start here).** Facts with value, source and hold; sums as relations; a branched run of pits and pipes. Hold different sets and work out the rest, uphill and downhill; over-held sets reported with which facts and by how much; time for a run of 200 pipes. Pass: every case in the three mock-ups (`pictures\pipe_window_full_size.html`, `pit_window_full_size.html`, `run_levels_window_full_size.html`) reproduces, plus a branched case, predictably and in well under a second.
2. **Trial 10, headless predicts full.** Do the events and overrules the other trials rely on fire for scripted commands in the headless engine. Decides how much of the rest can run unattended.
3. **Trial 1, joins.** Ordinary block, polyline and text carrying a hidden note of their facts and joins. Move, copy, mirror, rotate, stretch, erase, undo and redo, save and reopen, copy between drawings, EXPLODE, BLOCK, WBLOCK, clipboard copy and paste, INSERT, Xref bind, PURGE, AUDIT. Compare the three ways of storing a join and the two ways of moving joined ends named in R-002 A and B. Pass: joins survive or are cleanly reported broken; moving a pit moves its pipe ends as ONE undo step.
4. **Trial 3, no plugin (D-015, D-094).** A sheet made by the trial plugin, opened in an AutoCAD with nothing loaded: looks identical, plots identical (compare PDFs), every object selectable and editable with plain commands, nothing needs exploding. Then edit it there (move a pit, change a text), save, reopen with the trial plugin: it reports what changed. Includes the position stamp from R-002. Tim's live drawing (P-04) is a case only if he supplies a copy. AutoCAD LT: NOT TESTED unless a copy exists.
5. **Trial 2, grips.** A label, a level text and an arrow on ordinary objects given slide-along, push-off and flip, with a grip menu; what a grip-drag copy carries.
6. **Trial 4, speed.** A made-up sheet of several hundred elements; dragging a pit with joined pipes stays smooth; measure, do not guess.
7. **Trial 5, Properties.** Do the plugin's facts appear, editable, in AutoCAD's own Properties palette for an ordinary object by the .NET route. If FAIL, say plainly what the fallbacks are (own side palette; a small C++ helper) and do not build either.
8. **Trial 6, window, live preview and Inspect.** A window taking 80% of the screen at 1920 x 1080 and 2560 x 1440 with a live preview of real drawing geometry that keeps up while a value changes; Inspect hides it, the drawing can be panned and zoomed, and it returns with its state.
9. **Trial 7, ribbon tab on selection, tips and typed names.** The tab appears and goes; a button tip shows the short name; a clash with a user's alias is detected at start-up.
10. **Trial 8, double-click** opens the trial window for a trial object and leaves every other object's double-click alone.
11. **Trial 9, update and rollback** with no administrator rights, using the trial bundle only, removed afterwards.

## What to hand back

One file, `C:\CE_PLAN\zero\stage4\TRIAL_RESULTS.md`, committed by file name and pushed (`git add -- zero/stage4/TRIAL_RESULTS.md`, nothing else staged; other sessions have uncommitted files in that repository). For each trial: what was done, what was seen, the verdict word, evidence (file names of screenshots, PDFs or logs under `C:\CE_WORK\trials\zero\evidence\`), and what it means for the build approach. Numbered lists with bold labels, no tables, plain words first. End with "What must change in the build approach" and "What was not tested and why". Update the file after each trial, so a stopped run still leaves a true record.
