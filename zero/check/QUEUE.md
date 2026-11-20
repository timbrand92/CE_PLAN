# Check room queue (CE_ACAD / check / 01)

**What this page is.** Every branch or mock-up waiting for its independent check, being checked, or given a verdict, with clock times (Melbourne). The gate is decision D-346: MERGE or HOLD; a blocker is only a wrong figure that could reach a sheet, an edit that could damage or lose drawing content, a breach of a hard limit, or a ruling built the opposite way. Kept by the check room only. Verdicts are in `VERDICTS\<branch>.md`; non-blockers per part in `FOLLOW_UP\`.

**Words used here.** "Checked on the bench" only. Whether a thing works in AutoCAD is the AutoCAD test room's word, from pictures.

**Opened:** Fri 20 Nov 2026, 11:06 am. Main line of `C:\CE_CIVIL` at 11:10 am: 22993fa.

## 0. Order of work (control room, 11:25 am)

1. The night scripts on main, then the launcher fix the build room is making. Tonight's AutoCAD run does not start without the check room's MERGE on that fix.
2. A1 to A3 (team/acad-windows), then A5 (team/pipe-default), then the doorway's test list, then the Pipe mock-up.

## 1. Being checked now

1. **team/acad-windows at 53442d4** (Stage 1 items A1 to A3: approved-style Pit and Pipe windows in AutoCAD, sized to content, the true preview). Handed over 11:19 am as a re-check after the build room's own HOLD (`C:\CE_WORK\scratch	eam\check_aw_REPORT_last.md`). 5 commits behind main, so the suite is also run merged. Fix rounds used: 1 of 2.
   - **Honest check:** Team helper (opus), `C:\CE_WORK\checkcad-windows_honest`, started 11:21 am.
   - **Adversarial pass:** Codex gpt-6.2-astra (xhigh), `C:\CE_WORK\checkcad-windows_adv`, started 11:21 am.
2. **team/pipe-default at 741f0f2** (Stage 1 item A5). Honest check finished 11:20 am: HOLD, one blocker (early word sent to the build room 11:22 am). Adversarial pass (Codex astra, started 11:10 am) still running; the written verdict follows it. Fix rounds used: 1 of 2.
3. **The night scripts on main:** honest check finished, verdict HOLD given (section 4). Adversarial pass (Codex astra, started 11:13 am) still running; its findings are added to the verdict page.

## 2. Waiting

Handed over, not yet started (in the control room's order):
1. **The launcher fix, team/night-launch:** not handed over yet (branch made, no work on it at 11:15 am). Tonight's AutoCAD run does not start without the check room's MERGE on it. It is checked against the ten-point list in `VERDICTS
ight-scripts-on-main.md` section 4.
2. **codex/c11-tests, pinned at 11c6041** (tests only for cause C11; handed over 11:19 am). Claim: 70 target tests failing, 25 controls passing, all 1,850 existing pass. To check: is the list honest against `design\SUMS_PIPE_AND_PRINT.md` with D-349, D-350 and the D-341 examples. The C11 build carries on the same branch, so the check stays on 11c6041.
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

1. **The night scripts on main (22993fa): HOLD, 11:24 am.** Four blockers, all breaches of a hard limit: nothing reads the clock, the stop flag or Tim's switch file; the launcher adopts an AutoCAD by start time and title rather than by having created it. `VERDICTS
ight-scripts-on-main.md`; follow-ups in `FOLLOW_UP
ight-scripts.md`.

## 5. Look log (the check room's own look at the branches, every 20 minutes)

1. **11:05 am:** first look. Six candidates listed; one merge to main found (night-safety2).
2. **11:10 am:** build room answered. One hand-over (team/pipe-default); main moved to 22993fa (office-blocks merged).
3. **11:15 am:** main unchanged at 22993fa. team/acad-pictures moved to fe116c9; codex/tests-c9 moved to 73134fd; new branches with no work on them yet: team/night-launch (the launcher fix), team/acad-pictures2, codex/tests-a6b. No new hand-over.
4. **11:24 am:** three hand-overs taken (acad-windows, c11-tests, the Pipe mock-up); first verdict given (night scripts, HOLD).
