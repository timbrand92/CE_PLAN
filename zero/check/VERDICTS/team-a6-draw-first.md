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
