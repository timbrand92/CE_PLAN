# Check room queue (CE_ACAD / check / 01)

**What this page is.** Every branch or mock-up waiting for its independent check, being checked, or given a verdict, with clock times (Melbourne). The gate is decision D-346: MERGE or HOLD; a blocker is only a wrong figure that could reach a sheet, an edit that could damage or lose drawing content, a breach of a hard limit, or a ruling built the opposite way. Kept by the check room only. Verdicts are in `VERDICTS\<branch>.md`; non-blockers per part in `FOLLOW_UP\`.

**Words used here.** "Checked on the bench" only. Whether a thing works in AutoCAD is the AutoCAD test room's word, from pictures.

**Opened:** Fri 20 Nov 2026, 11:06 am. Main line of `C:\CE_CIVIL` at 11:10 am: 22993fa.

## 0. Order of work (control room, 11:25 am)

1. The night scripts on main, then the launcher fix the build room is making. Tonight's AutoCAD run does not start without the check room's MERGE on that fix.
2. A1 to A3 (team/acad-windows), then A5 (team/pipe-default), then the doorway's test list, then the Pipe mock-up.

## 1. Being checked now

1. **DESIGN PAGE `design\PIPE_SIZE.md`, branch design/pipe-size at 7c8d90c** (the size a pipe holds and where it is kept; D-372). Asked by the build room at 12:01 pm: read against D-372, D-263 and D-349 before any build. Team opus honest read and Codex astra adversarial read, both started 12:04 pm. Answer will be BUILD FROM IT or FIX THE PAGE FIRST.

## 2. Waiting

In the control room's order:
1. **The launcher fix, team/night-launch** (534f96a at 11:55 am, still in work): not handed over. No AutoCAD run until the check room gives MERGE on both halves and the AutoCAD test room says go (D-364 item 10). Checked against D-364 items 1 to 9 line by line.
2. **team/acad-windows, last fix round:** in work at the build room.
3. **team/held-depth** (a typed depth lost on OK and reopen): in work at the build room.
4. **team/office-blocks (A4), already on main: adversarial pass only** (control room, 11:50 am by its clock): a block of the same name already in the drawing; a locked layer; an xref; the shipped file missing or damaged; other units. Not started.
5. **Still with the build room:** team/acad-pictures (4384464), codex/doorway (87c6440, tests only), codex/tests-a7, codex/tests-a6b.

**Standing order from the control room:** nothing reaches main on one check alone; both halves of D-346 every time. If the build room merges on one, the check room tells the control room at once.

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
