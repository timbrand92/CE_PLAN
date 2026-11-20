# Check room queue (CE_ACAD / check / 01)

**What this page is.** Every branch or mock-up waiting for its independent check, being checked, or given a verdict, with clock times (Melbourne). The gate is decision D-346: MERGE or HOLD; a blocker is only a wrong figure that could reach a sheet, an edit that could damage or lose drawing content, a breach of a hard limit, or a ruling built the opposite way. Kept by the check room only. Verdicts are in `VERDICTS\<branch>.md`; non-blockers per part in `FOLLOW_UP\`.

**Words used here.** "Checked on the bench" only. Whether a thing works in AutoCAD is the AutoCAD test room's word, from pictures.

**Opened:** Fri 20 Nov 2026, 11:06 am. Main line of `C:\CE_CIVIL` at 11:10 am: 22993fa.

## 0. Order of work (control room, 11:25 am)

1. The night scripts on main, then the launcher fix the build room is making. Tonight's AutoCAD run does not start without the check room's MERGE on that fix.
2. A1 to A3 (team/acad-windows), then A5 (team/pipe-default), then the doorway's test list, then the Pipe mock-up.

## 1. Being checked now

2. **codex/c11-tests pinned at 11c6041** (tests only for cause C11). Both helpers started 11:33 am: Team opus honest check (`C:\CE_WORK\check\c11-tests_honest`) and Codex astra adversarial pass (`C:\CE_WORK\check\c11-tests_adv`). The question: is the list honest against `design\SUMS_PIPE_AND_PRINT.md` with D-349, D-350 and the D-341 examples.

3. **team\pipe-default at 393b649 (A5), RE-CHECK after its last fix round.** Handed back 11:41 am; main 22993fa is merged into it. Both helpers started 11:44 am: Team opus honest re-check (`C:\CE_WORK\check\pipe-default2_honest`) and Codex astra adversarial re-pass (`C:\CE_WORK\check\pipe-default2_adv`). Checked against the three blockers of `VERDICTS\team-pipe-default.md` and the control room's relayed ruling (an existing pipe shows its drawn width; never 100; if it cannot be read, say so and OK leaves the size alone). Fix rounds used: 2 of 2.

## 2. Waiting

Handed over, not yet started (in the control room's order):
1. **The launcher fix, team/night-launch:** not handed over yet (branch made, no work on it at 11:15 am). No AutoCAD run tonight (D-364 item 10); the first run is when the check room gives MERGE on both halves and the AutoCAD test room says go. Checked against D-364 items 1 to 9 line by line (`VERDICTS
ight-scripts-on-main.md` sections 4 and 5).
3. **Mock-up `zero\pictures\pipe_top_preview_mockup.html`** after its fix 4 (handed over 11:19 am). Against D-313, D-305, all 31 screen rules and the approved style, no scroll at 1200 by 800 in all three states, from a picture the check room takes itself.
4. **team/office-blocks (A4), already on main: adversarial pass only.** Asked by the control room at 11:50 am by its clock. To try in particular: a drawing that already holds a block of the same name with different contents (the drawing's own must not be silently replaced; there may be no ruling, so report what it does); a locked layer; an xref; the shipped file missing or damaged; a drawing in other units.

Still with the build room, mid-fix:
5. **team/acad-pictures** (fe116c9 at 11:15 am): build room's own check HOLD, 5 blockers.
6. **codex/doorway** (725338f, tests only): Codex review HOLD on the list.
7. **codex/tests-a7** (90bbea2) and **codex/tests-a6b**: tests-only; each comes when its report lands. codex/tests-a6 is ignored (old brief).

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

## 5. Look log (the check room's own look at the branches, every 20 minutes)

1. **11:05 am:** first look. Six candidates listed; one merge to main found (night-safety2).
2. **11:10 am:** build room answered. One hand-over (team/pipe-default); main moved to 22993fa (office-blocks merged).
3. **11:15 am:** main unchanged at 22993fa. team/acad-pictures moved to fe116c9; codex/tests-c9 moved to 73134fd; new branches with no work on them yet: team/night-launch (the launcher fix), team/acad-pictures2, codex/tests-a6b. No new hand-over.
4. **11:24 am:** three hand-overs taken (acad-windows, c11-tests, the Pipe mock-up); first verdict given (night scripts, HOLD).
5. **11:35 am:** main unchanged at 22993fa. Moved, none handed over yet: team/pipe-default to ad1ac51 (its second fix round), team/night-launch to c984973 (the launcher fix, in work), codex/doorway to 87c6440, team/acad-pictures to 4384464, codex/tests-a6b to 9446c2b.
6. **11:44 am:** team/pipe-default handed back at 393b649; re-check started.
