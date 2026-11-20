# Verdict: team/a6-draw-first at 73be1d0 (Stage 1 item A6: draw first, window second)

**Verdict: HOLD. Four blockers.** Written Fri 20 Nov 2026, about 2:50 pm, by the check room. Checked on the bench only; the real click, the real Undo and real layer locks are owed in AutoCAD. This is the branch's first verdict here.

**Who checked.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\a6_honest_REPORT.md` (ruling by ruling; it broke the built code six ways and the tests caught each). Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\a6_adv_REPORT.md`, 71 independent checks through the command host, proofs in `a6_adv_tests\`. The adversarial pass listed twelve blockers; graded again here under D-346.

## 1. Suite seen

Brain 750, hands 710 passed and 1 skipped, bench 438, saved-drawing reader 19 passed and 2 skipped: 1,917 passed, 0 failed. The one skip is honest: a four-case test of the 100 dia. opening size, waiting for the pipe-size build (with the skip taken off it fails on exactly that). The other two are main's own.

## 2. What holds up on the bench

1. **Click first, window second,** for pits and pipes (D-354, D-355): the window opens after the clicks; each pit in its own window; nothing is put on the drawing while a window is open (D-382, the feed only: the panel that shows it is another branch).
2. **A run from anywhere to anywhere with bends;** a run clicked at its two ends through pits in line splits into one pipe per length.
3. **A picked plain polyline is replaced by pipes and erased last;** one with an arc, a closed one, one on a locked layer and one in an xref are each refused with the reason (D-375). Cancel leaves it untouched.
4. **The three faults the check room found on main here are closed** (a run could not start on a pipe; a first-to-last click missed the pit between; a polyline could not be picked).
5. **No layer is unlocked, thawed or switched on. The commands never ask an angle.**

## 3. Blockers

1. **One Undo after several pits takes back all of them** (a ruling built the opposite way; more than one Undo's worth of drawing lost). `src/CeCivil.Acad/PitCommand.cs:63-97` draws every pit of one PT inside one command with no Undo step between them. D-377 item 7 and Tim's own pick: P4, P5, P6 placed, one Ctrl+Z, "Just P6: one pit per Undo". On main PT placed one pit and ended, so the ruling held. Traced in the code; the bench cannot run AutoCAD's Undo. The same in the Pipe command's own Undo option: after clicking the two ends of a run through three pits it takes back both lengths, not the last (`PipeCommand.cs:98, 200`; `src/CeCivil.Hands/Pipe/PipeRun.cs:138`).
2. **Parts on locked, off or frozen layers are changed, because the check comes after the write or not at all** (a hard limit; standing brief 3.5, D-348, D-320). Placing a pit on the end of a pipe that sits on a locked layer moved that pipe's end 225 mm and renamed it (`src/CeCivil.Hands/Pit/PitTool.cs:328, 666, 684`: the pipe is found after the pit is written). A picked polyline on an off or frozen layer was erased; one locked after it was picked, before OK, was still erased; a run across a pit marked locked, in an xref or under reference editing was joined to it with no refusal (`EditGuard.cs:31, 40`; `PipeSplit.cs:93`; `PipeTool.cs:570`; `PipeRun.cs:228`). On the pretend drawing; what AutoCAD's own locks then stop is owed.
3. **A picked polyline is erased while its replacement takes a different path** (drawing content changed; D-356: "pipes take its exact path"). A straight guide passing 150 mm off a pit's centre: the two pipes are aimed at the pit's centre and meet its walls 8 mm from the centre line, not on the guide's line; the guide is erased and the message says the exact path was followed (`PipeSplit.cs:66`; `PipeTool.cs:295, 303`). Also: a bend 0.8 mm long vanishes with the guide (the meeting distance is 1 mm where D-341 says a tenth), and a guide that clips only the corner of a pit is not cut there.
4. **"A run starts or ends on a pipe" (D-374) is claimed, but nothing is joined.** The branch draws the new pipe and leaves the old pipe one, as ruled, but neither pipe records the other, the command itself says "nothing joins the two yet", and the level at the junction opens "Not known" (a 10 m main at 1 in 100 from IL 10.00: the branch at its middle should read 9.95). D-340: every join is written on both parts. Even a pit-wall join is written on the pipe only (`PipeTool.cs:228, 269, 544, 566`; `JoinStore.cs:62`).

## 4. To fix in the same round (not blockers alone)

1. **A pit placed part way along a pipe is drawn on top of it, joined to nothing** (the mid-pipe split is declared not built): until it is built, refuse in words rather than draw it.
2. **Several parts picked before the command** start a fresh placement instead of opening one window or nothing (D-381 item 5).
3. **The hold point:** pick a corner, then change the pit's size in the window: the corner ends 75 mm from the click (D-383 item 2) (`PitCommand.cs:94, 111, 116`).
4. **A write that fails on the last pipe** leaves the new layers behind; with the clean-up also failing it leaves a pipe and says all were removed.
5. **Words:** "free end" where the ruled wording is "not joined yet"; "hidden note"; "1 pipe(s)"; "HandsException" on a fault.

## 5. Not this branch's

A level typed on the first pipe of a run does not reach the second (levels along a run: the label job, A7); the size a pipe opens at (the pipe-size build); the preview panel and the Turn button (the window job); CDEDIT (the doorway).

## 6. Tests

The pick-first route is never run by any test: the test host always answers "nothing selected"; it also clears "last used" around every run and does nothing at the end of a command. Two guards were lost when the six preview tests were rewritten for D-382 (the first pipe frame is captured but never asserted; nothing now checks for something left behind on the drawing after exit). One test accepts the pipes of a split run in either flow order.

## 7. Owed in AutoCAD (for the AutoCAD test room, when a build of this is merged)

The honest report's section 7, in exact steps: PT, three pits, Enter, then U once (right: only the last pit goes); CD from open ground with two bends; CD through three pits clicking the ends; a picked polyline replaced and one U bringing back the same polyline; each refused polyline; Cancel and Escape at each point; every command with the pit, tag, cover and pipe layers locked, off and frozen in turn; Redo after each Undo.


---

# Second verdict: team/a6-draw-first at 75290d9 (fix round 1)

**Verdict: HOLD. Five blockers: one new, four where a first-round blocker is only partly closed.** Written Fri 20 Nov 2026, about 4:35 pm, by the check room. Checked on the bench only. One fix round is left (D-346); after that the branch is held with a one-page open list.

**Who checked.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\a6r_honest_REPORT.md` (it took each fix out and the tests failed). Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\a6r_adv_REPORT.md`, 112 independent cases, proofs in `a6r_adv_tests\`. The adversarial pass listed eleven blockers; graded again here.

## A. Suite seen

Brain 750, hands 762 passed and 2 skipped, bench 438, saved-drawing reader 19 passed and 2 skipped: 1,969 passed, 0 failed. Brain by itself 750 of 750 in both helpers' runs: the builder's one timing failure did not come back. The two hands skips are honest (the 100 dia. opening size and the first pipe picture, both waiting for the pipe-size build: with the skip off they fail on exactly that). **But `dotnet build` of the whole solution FAILS: see blocker 1.**

## B. What the fix round closed (each test fails when its fix is taken out)

1. **One Undo per pit in PT,** and one for a finished run (the real Undo is owed in AutoCAD).
2. **Parts on locked, off or frozen layers are checked before a write** for: a pit on a loose pipe end, a resized pit, a run to a pit, a guide locked after it was picked, a guide that is off or frozen.
3. **A picked guide passing a pit off its centre, or clipping a pit corner, is refused and kept;** a 0.8 mm bend is kept.
4. **A run onto a pipe is written on both pipes, by hidden identity,** and the level at the junction is worked out (9.95 at the middle of a 10 m main at 1 in 100 from 10.00).
5. **Same round:** a pit dropped on a pipe's centre line is refused in words; several CE parts picked first open nothing; the held corner stays at the click after a size change; the two lost guards are back. D-390: the size holds within one PT and a fresh PT opens at 450; Cancel or Escape drops one pit; a layout sheet and a read-only drawing are refused before the first click.

## C. Blockers

1. **NEW: the AutoCAD plug-in does not compile at 75290d9** (`src/CeCivil.Acad/PitCommand.cs:72`, `src/CeCivil.Acad/PipeCommand.cs:59`: error CS0411 on `implied.Value.Any(...)`; AutoCAD's selection set is not a plain list, the test host's stand-in is). It built at 9418a6c. Nothing on this branch can be built into AutoCAD, and merging it would break the main line's build. The builder's suite log has no build of the plug-in project. Fix the two lines, build the WHOLE solution, and say so.
2. **A wrong junction level can reach the plan** (blocker 4, partly open). A 10.490 m main from IL 10.000 at 1 in 100, a branch starting 9.8606 m along: the level is 9.901 (plan 9.90); the branch stores 9.906 (plan 9.91). The sum reads the main window's ROUNDED end figures before working along it (`bench/CeCivil.Bench.Core/PipeToolWindow.cs:90-99`). D-350: sums on exact figures.
3. **Changing only a pit's cover moves and renames a pipe on a locked layer** (blocker 2, partly open). P1 with a loose pipe end at its centre (an older drawing), the pipe's layer locked: open P1, type a cover, OK: the pipe's end moved 225 mm and its name changed (`src/CeCivil.Hands/Pit/PitTool.cs:352-355, 728-751`: the check gathers the moves of a size change; the write also gathers new joins). Gather the whole edit before anything is written.
4. **A picked guide is erased and its pipes drawn on another line** (blocker 3, partly open). A guide starting 60 mm off the centre line of a 150 main: OK erased it and moved its first point onto the centre line (`src/CeCivil.Hands/Pipe/PipeSplit.cs:101-114`; `PipeTool.cs:283-297, 383-385`). D-356: the exact path, or refused and kept.
5. **The Pipe command's Undo throws away the whole run when its ends are on open ground** (blocker 1, partly open). Pits at 0, 5 and 10 m; click from 5 m before the first to 5 m past the last; Undo; finish: three lengths should remain, none was drawn (`src/CeCivil.Hands/Pipe/PipeRun.cs:66-78, 120-128, 155-165`). D-324: the last length only.

## D. To fix in the same round (not blockers alone)

1. **New parts go onto an off or frozen layer** with no word and no offer (`src/CeCivil.Hands/EditGuard.cs:40-46` tests only the lock on the layer a new part goes to). D-320: an offer first; the round's own interim was a refusal in words.
2. **A pit whose centre is 240 or 280 mm off a 150 pipe's centre line is still drawn over the pipe band, joined to nothing** (`PitTool.cs:374-396`: the refusal looks at the centre line against the INNER wall; D-270 counts the outer wall line).
3. **A failed last write:** the two new layers stay behind while the words say every pipe was erased; and when the failing pipe's own erase fails, a pipe survives under the same words (`PipeRun.cs:241-271`; `PipeTool.cs:698-709`).
4. **Junction records:** nothing reads them back. Erase the branch and the main still says a branch starts on it; erase the main and the branch still reports a junction; a branch that leaves a main and returns to it keeps one record, not two; opening a sound branch and pressing OK renamed it "free end to free end (2)". The self-check reads only the older join records (`SelfCheck.cs:149`); the comment at `PipeRun.cs:270` is untrue; test D2 does not guard it. The record also keeps the other pipe's NAME (D-397).
5. **The four wordings are all still on screen:** "free end" (ruled: "not joined yet"), "hidden note" (`PipeTool.cs:288, 414`; `PipeCommand.cs:89`), "{noun}(s)" (`tools.csv:406`), "HandsException" (`PitCommand.cs:118, 230`; `PipeCommand.cs:165, 247`).
6. **A refusal inside PT ends the whole PT,** so the held size is lost. Two plain guides picked first are ignored and an unrelated pipe is placed.
7. **Tests:** H2 passes with the new layers left behind; B6, C4, D6 and D7 pass with or without the fix; Enter, Space and right-click are one pretend answer; the bench Undo is a stand-in for `src/CeCivil.Acad/UndoStep.cs`, which never runs.

## E. Not this branch's (routed, not held against it)

1. **A typed pit number already in use is accepted** ("P1", " p1 "): D-390 item 3, D-401. With the flag marker job, whose list tests it.
2. **A second pipe between the same two pits is refused because the name is in use:** D-397, D-398 (every pipe its own running number). A job of its own.
3. **Pit and Pipe still draw in metre, inch and feet drawings:** the units job (D-403).
4. **A fresh placement during reference editing has no check before it** (`AcadDrawing.cs:398-411`): owed in AutoCAD; with the drawing-safety work.
5. **A guide changed, bent or erased between the pick and OK is still replaced from the first read:** proven only by changing it from inside the test; whether AutoCAD allows it while a window is open is owed.

## F. Owed in AutoCAD

Section 7 of the first verdict stands, with sections 8 of the honest report and 4 of the adversarial report: U and Redo once after three pits; the Pipe command's Undo from a pit and from open ground; a guide with its own linetype and widths replaced, then one U bringing the same guide back; the locked-end cover edit; the 10.490 m main and its branch level after save and reopen; erasing a main with a branch on it; Enter, Space and right-click each ending PT; every command during reference editing with nothing picked; nothing may run before the plug-in compiles.

## G. Ruled since (D-410, Tim, about 4:48 pm): the last fix round is built and checked against these

1. **A run through a pit meets the walls where the line crosses them;** a run ended inside a pit meets the middle of the facing wall. So a guide passing a pit off its centre is no longer refused: the pipes keep the guide's own line (first verdict blocker 3 and second verdict blocker 4 are read with this: the exact path is kept, never pulled to a centre).
2. **A join onto a pipe with no pit gets NO invert level by default;** if he gives one it is the same as the main's, with no drop. Second verdict blocker 2 is read with this: no figure is put there by the tool unless he asks; when it is, it is worked from the main's exact figures.
3. **A run started from the loose end of a pipe EXTENDS that pipe** (one pipe, not two).
4. **A click always starts a pipe; P picks a polyline.** A picked polyline's width, layer and colour are ignored; the band is as wide as the pipe size.
5. **A pipe's length MAY be typed** (the "length used" is the typed one if given, else the drawn one). Nothing in this branch may assume a length is only ever measured.
6. **The window offers to bump smaller lengths before OK** (pipe size; not this branch's).


---

# Final verdict: team/a6-draw-first at 5d83df2 (its LAST fix round)

**Verdict: HOLD, with the one-page open list below. This was A6's last round (D-346): the branch is HELD and the control room decides what happens next.** Written Sat 21 Nov 2026, about 1:31 am. Checked on the bench only. This tip does NOT contain the rounding branch (D-432), checked.

**Who checked.** Honest: one Claude helper on Sonnet: `C:\CE_WORK\check\reports\a6l_honest_REPORT.md`: HOLD on one blocker. Adversarial: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\a6l_adv_REPORT.md`, proofs in `a6l_adv_proofs\`: HOLD on six. **Closed:** the plug-in compiles (both selection casts; the old CS0411 errors reproduced at 75290d9 and gone here); a cover-only edit refuses a locked pipe; one Undo on an open-ground run; off and frozen destination layers refused. The whole solution builds; the builder's suite is green apart from timing tests.

## 8. The open list

1. **A branch saves an invert level nobody asked for** (both halves): a branch started or ended on a pipe with no pit gets an invert worked out and written into its note (`up_invert=9.95`; and 9.901 for 9.8946 on another case, rounded to three places before it is stored: `bench/CeCivil.Bench.Core/PipeToolWindow.cs:63-64, 90-99`). D-410 item 4: no invert level is written by default there. The round's own tests B2a and B2b (`Stage1A6LastRoundTests.cs:46-65`) assert the opposite and change with the fix.
2. **Converting a guide can lose drawing:** a guide started 60 mm to one side of a 150 mm main and drawn perpendicular through it is converted into a pipe that starts ON the main, 60 mm short, and the original guide is gone; reversed, the other end is lost (`PipeSplit.cs:167-168` accepts "somewhere on the path"). The guide is followed exactly or refused and kept (D-410).
3. **A failed conversion can lose an existing label:** extend a labelled pipe from its loose end with the label turned off in the window; make the final guide erase fail: the guide survives, the pipe goes back to two vertices, and its original label is gone. All or nothing, one Undo (D-348).
4. **Protected content changed:** erasing a branch whose main is locked (or in an xref, or outside the reference-edit set) removes a stored junction record from that main (D-348).
5. **The length used cannot be typed:** the Length row has no input box and the page says it cannot be typed (`windows/pipe.csv:45, 51, 56`; `PipeToolWindow.cs:68`): D-410 item 1 lets a length be typed, and D-413 item 4 shows "typed 6.50 m, drawn 6.20 m".
6. **Two pipes between the same pits are refused** ("already drawn"); a branch that leaves its main and comes back keeps one meeting for two ends; a pipe meeting a pit writes the wall join on the pipe alone (`PipeTool.cs:52`). D-398 item 2 (two pipes, each its own number; also binding probe 1 of the accepted pipe-size list).

## 9. Also found (same family, for whoever owns the fix)

A 450 mm pit at 450 mm offset over a 375 mm pipe still places (the pit-over-pipe test uses the wrong clearance for that size); the D-320 offer for a hidden destination layer is still outstanding.

## 10. For the control room

A6 is the drawing spine Pit and Pipe stand on. Items 1, 5 and 6 are rulings built the wrong way; 2, 3 and 4 lose or change drawing content. Recommended, as for held-depth and the night route: a short design page for the pipe run's edit route (guides, extension, branches, joins and the typed length) before a fresh build, with the round's tests carried over; A6's part B (the D-414 prompt and click budgets) is sound and can be kept.
