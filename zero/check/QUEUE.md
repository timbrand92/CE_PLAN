# Check room queue (CE_ACAD / check / 01)

**What this page is.** Every branch or mock-up waiting for its independent check, being checked, or given a verdict, with clock times (Melbourne). The gate is decision D-346: MERGE or HOLD; a blocker is only a wrong figure that could reach a sheet, an edit that could damage or lose drawing content, a breach of a hard limit, or a ruling built the opposite way. Kept by the check room only. Verdicts are in `VERDICTS\<branch>.md`; non-blockers per part in `FOLLOW_UP\`.

**Words used here.** "Checked on the bench" only. Whether a thing works in AutoCAD is the AutoCAD test room's word, from pictures.

**Opened:** Fri 20 Nov 2026, 11:06 am. Main line of `C:\CE_CIVIL` at 11:10 am: 22993fa.

## 0. Order of work (control room, 11:25 am)

1. The night scripts on main, then the launcher fix the build room is making. Tonight's AutoCAD run does not start without the check room's MERGE on that fix.
2. A1 to A3 (team/acad-windows), then A5 (team/pipe-default), then the doorway's test list, then the Pipe mock-up.

## 1. Being checked now

1. **team/held-depth at 6c9bc07:** checked on the OLD tip only (honest half: no blocker; adversarial half still running). The build room is adding two more fixes to the branch (the stale cover level on the plan; the metre refusal), so no verdict is written until the new tip is handed over and checked, both halves.
3. **design\PIPE_SIZE.md, corrected, design/pipe-size at 95f65aa:** the one more read, Team opus, started 1:35 pm.
4. **Pipe mock-up after its fix 5:** new pictures taken by the check room at 1:34 pm (`C:\CE_WORK\check\reports\pipe-mockup_pics\fix5`); Team opus re-check started 1:35 pm.

## 2. Waiting

Handed over, to start as helpers come free:
1. **team/acad-pictures2 at b876264** (the picture route for the night run). Both halves BY READING ONLY (D-388): it holds night scripts. The AutoCAD test room is told the outcome.
2. **codex/tests-five at b23d46f** (tests only, the five smaller Stage 1 cases).

Not handed over yet:
3. **team/night-launch, next round** (after the HOLD of 1:35 pm): both halves by reading only, against D-364 and D-388.
4. **team/a6-draw-first, codex/doorway, codex/tests-a7b, codex/tests-a6b;** the C11 build on codex/c11-tests (the list is held).

**Standing orders from the control room:** nothing reaches main on one check alone; both halves of D-346 every time; if the build room merges on one, tell the control room at once. No checker or builder runs any script of team/night-launch (D-388). The look is hourly; turns only when a report lands or a branch is handed over (Tim's usage order).

## 3. Not for the check room (merged before it opened, on the build room's own check)

1. **team/night-safety2** (f24fc2d), merged 10:57 am. Build room's Team opus check said MERGE: `C:\CE_WORK\scratch\team\check_ns2_REPORT.md` (seen by the check room: the file exists and says MERGE, no blockers).
2. **team/office-blocks** (2487bcf), merged 11:07 am. Build room's Team opus check said MERGE: `C:\CE_WORK\scratch\team\check_a4_REPORT.md` (seen: exists, says MERGE; it names a missing blocks file as an install blocker).
3. **Each of these two had one independent check only.** The control room has ordered the second half for both: the night scripts check in section 1, and office-blocks in section 2 item 7.

## 4. Verdicts given

1. **The night scripts on main (22993fa): HOLD, 11:24 am; both halves done by 11:30 am.** Seven blockers: nothing reads the clock, the stop flag or Tim's switch file; the launcher adopts an AutoCAD by start time and title; a damaged record passes "is it ours"; the unsaved close knows the test drawing by short name only; quit and force take every drawing open. `VERDICTS
ight-scripts-on-main.md`; 19 follow-ups in `FOLLOW_UP
ight-scripts.md`. Ruled by the control room as D-364 items 1 to 10: the fix (team/night-launch) is checked against items 1 to 9 line by line, and there is NO AutoCAD run tonight (item 10).

2. **team/pipe-default at 741f0f2 (A5): HOLD, 11:32 am.** Three blockers: the Pipe tool's own window never sees the pipes arriving at the start pit (opens and draws at 100 under a 225); editing an older pipe can shrink it to 100 and its cover can read "Suits" when short; the last size typed carries into the next unrelated pipe (D-263 the opposite way). One fix round left. `VERDICTS	eam-pipe-default.md`; follow-ups in `FOLLOW_UP\part2-pit-and-pipe.md`.

3. **team/acad-windows at 53442d4 (A1 to A3): HOLD, 11:50 am.** Two blockers: neither window can open in AutoCAD (`src/CeCivil.Window/WindowHost.cs:101`); the pictures still draw pits, pipes and a pit name that are not on the drawing. To fix in the same round by the control room's ruling: nothing cut off at 1920 by 1080 and above. Last fix round. `VERDICTS\team-acad-windows.md`; follow-ups 16 to 33 in `FOLLOW_UP\part2-pit-and-pipe.md`.

4. **The C11 test list, codex/c11-tests at 11c6041: HOLD THE LIST, about 12:06 pm.** Counts true (70 targets fail, 25 controls pass, 1,850 older pass), but all 95 can be turned green on a wrong product. Eight things the Stage 1 list must have first; the list is split into Stage 1 and Stage 2 by the control room. `VERDICTS\codex-c11-tests.md`; `FOLLOW_UP\part3-cover-and-grade.md`.
5. **team/pipe-default at 393b649 (A5), last fix round: HOLD, and HELD, about 12:07 pm.** Both halves agree. Closed: the last typed size no longer carries; a single pipe off a pit; a readable older width kept. Open: a run draws 375, 100, 100, 100; an arriving pipe read from its note not the drawing; a note that disagrees with the drawn pipe wins and OK redraws it; an unreadable width becomes 100; a read-off size recorded as typed. No third patch (D-372): design page, then one build. `VERDICTS\team-pipe-default_HELD.md`.
6. **Mock-up `zero\pictures\pipe_top_preview_mockup.html`: FAIL, about 12:08 pm.** It fits and every sum adds up, but: "short by 45 mm, Short" where the rulings give 50 mm and "Wrong"; a worked-out figure in a box in step 1; the pipe not drawn the office way; the flow arrow inside the pipe (D-369). `VERDICTS\mockup-pipe-top-preview.md`.

7. **Design page `design\PIPE_SIZE.md` at 7c8d90c: FIX THE PAGE FIRST, about 1:05 pm.** The core is right and closes every A5 finding, but it goes against rulings made since it was saved (D-373, D-374, D-375, D-379, D-380, D-382, D-344) and leaves ordinary cases undefined. `VERDICTS\design-pipe-size.md`.
8. **Correction, 1:05 pm:** the Pipe mock-up's second reason to fail (the dashed box in step 1) is withdrawn: it is ruled by D-319. The mock-up still FAILS on three.

9. **team/office-blocks (A4), on main at 22993fa, the adversarial half: WOULD HAVE BEEN HOLD, about 1:30 pm.** The office tag is never used; a blocks file holding definitions only cannot supply the first pit on a blank drawing; the file is not in the build. Faults on main exposed: the plan can keep an old cover level (6.50 in the window, CL 5.75 on the drawing); a metre drawing is not refused. Not a reason to pull it off main. `VERDICTS\team-office-blocks_on-main.md`.

10. **team/night-launch at a092bf7 (the night-script safety fix): HOLD, about 1:35 pm.** By reading (adversarial half; the honest half was stopped on the control room's safety order). The wrapper deletes the stop flag; a test can start a real AutoCAD; a force goes ahead when the open-drawing count cannot be read; nothing owns the 8:00 am deadline; failed checks finish green. Closed: the launcher now creates the process itself; the weekday clock is right. `VERDICTS\team-night-launch.md`.

11. **team/acad-windows at b645b43 (A1 to A3), last fix round: HOLD, and HELD, about 1:45 pm.** Closed: the windows open; most pictures show only what is drawn; Inspect is back. Open: one Pit picture still draws pipe stubs on a pit with none, and the Pipe answer names pits that do not exist; the four-fifths cap cuts off the foot of the Pipe window at 1920 by 1080; and D-386 has replaced the size rule the branch was built to. `VERDICTS\team-acad-windows_HELD.md`.

## 5. Look log (the check room's own look at the branches, every 20 minutes)

1. **11:05 am:** first look. Six candidates listed; one merge to main found (night-safety2).
2. **11:10 am:** build room answered. One hand-over (team/pipe-default); main moved to 22993fa (office-blocks merged).
3. **11:15 am:** main unchanged at 22993fa. team/acad-pictures moved to fe116c9; codex/tests-c9 moved to 73134fd; new branches with no work on them yet: team/night-launch (the launcher fix), team/acad-pictures2, codex/tests-a6b. No new hand-over.
4. **11:24 am:** three hand-overs taken (acad-windows, c11-tests, the Pipe mock-up); first verdict given (night scripts, HOLD).
5. **11:35 am:** main unchanged at 22993fa. Moved, none handed over yet: team/pipe-default to ad1ac51 (its second fix round), team/night-launch to c984973 (the launcher fix, in work), codex/doorway to 87c6440, team/acad-pictures to 4384464, codex/tests-a6b to 9446c2b.
6. **11:44 am:** team/pipe-default handed back at 393b649; re-check started.
7. **11:55 am:** main unchanged at 22993fa. Moved or new, none handed over: team/night-launch to 534f96a (the launcher fix, in work); design/pipe-size at 3a41fd0 (new: the design page for the pipe size, D-372); team/held-depth (new, no work yet). Verdicts given since the last look: team/acad-windows HOLD. team/pipe-default at 393b649: honest half says still HOLD; by the control room (D-372) no third patch, a design page first; the held page is written when the adversarial half lands.
8. **12:04 pm:** two more jobs started. (a) DESIGN PAGE check asked by the build room at 12:01 pm: `design\PIPE_SIZE.md` on branch design/pipe-size at 7c8d90c, read against D-372, D-263 and D-349 before any build: Team opus honest read and Codex astra adversarial read. (b) The Pipe mock-up: the check room took its own pictures of the three states at 11:57 am (`C:\CE_WORK\check\reports\pipe-mockup_pics`) and a Team opus helper is checking it rule by rule. Still running: adversarial passes on the C11 test list and on team/pipe-default at 393b649. Coming next from the build room: team/held-depth and the last team/acad-windows round.
9. **12:08 pm:** three verdicts written (C11 list, pipe-default held page, Pipe mock-up). Six verdicts given today, none MERGE.
10. **12:15 to 1:02 pm:** no turns taken, by the control room's order (the Claude weekly allowance was at 97 per cent until its reset at 1:00 pm). Looks at 12:15, 12:35 and 12:55 pm skipped.
11. **1:05 pm:** back from the pause. Main unchanged at 22993fa. The answer on the design page given (fix the page first). The adversarial pass on team/office-blocks (A4, on main) started: Codex gpt-6.2-astra, worktree `C:\CE_WORK\check\office-blocks_adv`. Moved while paused, none handed over yet: team/night-launch a092bf7 (the launcher fix), team/acad-windows b645b43, team/held-depth 6c9bc07, team/a6-draw-first 5ebb23b, codex/c11-tests 75e8645 (the build carries on; the list check stays pinned at 11c6041), codex/tests-a6b d706c0c, codex/tests-a7b ed09bcb, codex/tests-five b23d46f, team/acad-pictures2 b876264.
12. **1:08 pm:** four hand-overs taken; night-launch and acad-windows started (four helpers), office-blocks running (one). held-depth and acad-pictures2 wait for a free helper.
13. **1:09 pm:** one more hand-over, waiting for a free helper: **codex/tests-five at b23d46f** (tests only: failing targets for the five smaller Stage 1 Pit and Pipe cases; 6 fake-drawing targets fail and 8 controls pass, 2 window targets fail and 1 control passes; report `C:\CE_WORK\cw_tests-five\TESTS_REPORT.md`; one case has no ruling: a second "P1 to P2" join). Order of the waiting checks: team/held-depth, team/acad-pictures2, codex/tests-five, then the corrected design page and the Pipe mock-up after its fix 5.
14. **1:20 pm:** team/held-depth at 6c9bc07 started, both halves (Team opus honest check, Codex astra adversarial pass), seven helpers now running. New rulings that bear on the checks in hand: D-385 (a flag is a small amber marker on the plan that never plots: replaces D-384 item 3); D-386 (Tim approved the Stage 1 Pit window from a picture: two set sizes, 1000 by 620 and 1240 by 780, the plan panel about 40 per cent of the width, Inspect kept: this replaces every earlier size call and is NOT what team/acad-windows was built to); D-387 (a held depth and a new cover: the invert stays, the depth is worked out again; how far the downstream offer reaches; a typed size is held on a copy; size never carries). Main unchanged at 22993fa; design/pipe-size moved to 95f65aa (the page is being corrected).
15. **1:30 pm:** by Tim's usage order through the control room, the look is now once an hour; turns are taken only when a report lands or a branch is handed over. The adversarial half on team/night-launch landed at 1:22 pm: it will be HOLD; a safety word went to all three rooms (one of its tests can start a real AutoCAD; its wrapper deletes the stop flag). The stop flag, the night drawing, the master copy and Tim's switch file were checked untouched at 1:24 and 1:25 pm.
16. **1:35 pm:** SAFETY, for the record. The check room's own honest helper on team/night-launch ran that branch's guard-deletion tests in Tim's hours from 1:15 pm. The build room flagged it at about 1:25 pm; the check room wrongly left it running under watch; the control room ordered it stopped at 1:30 pm. Stopped at 1:30 pm, and an orphaned runner it left at 1:31 pm. Nothing real was touched: the stop flag (19 Nov 9:02:20 pm, 114 bytes), the night drawing, the master copy, Tim's switch file and the results folder are unchanged, and no AutoCAD was running. Ruled as D-388.
