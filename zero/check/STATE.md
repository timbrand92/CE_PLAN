# Check room state (CE_ACAD / check / 01): read this first after a compaction or a restart

**Saved:** Fri 20 Nov 2026, about 14:36 (24-hour clock) by the check room, at the control room's request (D-391: save the queue and state when the chat is over two thirds full). The live list is `QUEUE.md` beside this page; verdicts are in `VERDICTS\`; non-blockers in `FOLLOW_UP\`.

## 1. What the check room is

The gate between a finished piece of work and the main line of `C:\CE_CIVIL` (decision D-346; `C:\CE_PLAN\zero\ROOMS.md` section 0). It never builds, fixes, merges, pushes to `C:\CE_CIVIL`, starts AutoCAD or installs anything. It commits only its own files under `C:\CE_PLAN\zero\check\`, by file name, pull before push, never `git add -A`, never force. Every reply and message starts with the two R-72 lines, counts read from `C:\CE_PLAN\BOARD.json`.

## 2. How a check is run

1. **Two different helpers, each in its own fresh worktree under `C:\CE_WORK\check\`** (`git -C C:\CE_CIVIL worktree add --detach C:\CE_WORK\check\<name> <commit>`), removed when the verdict is written.
   - **Honest check:** Team account, opus (never fable): `powershell -NoProfile -ExecutionPolicy Bypass -File C:\CE_WORK\check\briefs\run_team_check.ps1 -workdir <worktree> -brief <brief.md> -out <out.txt> -addDir <dirs>`. It pastes `CODEX_STANDING_BRIEF.md` on top.
   - **Read-only variant** (no shell at all; for night-script branches and design pages): `run_team_read.ps1`, same arguments. Save the diff to a text file first and name it in the brief.
   - **Adversarial pass:** Codex gpt-6.2-astra, xhigh: `powershell -NoProfile -ExecutionPolicy Bypass -File C:\CE_WORK\codex_run.ps1 -model gpt-6.2-astra -workdir <worktree> -brief <brief.md> -out <out.txt> -addDir C:\CE_WORK\check\reports`. It can write only to the workdir and the added folder.
2. **Briefs** are in `C:\CE_WORK\check\briefs\` (one pair per check; reuse them as patterns). Reports, logs, proofs and pictures land in `C:\CE_WORK\check\reports\`.
3. **Mock-ups and windows** are checked from pictures the check room takes itself: headless Edge, ONE call at a time (a loop of calls hangs), each with a time limit.
4. **Verdict:** MERGE or HOLD (for a test list: ACCEPT or HOLD THE LIST; for a design page: BUILD FROM IT or FIX THE PAGE FIRST; for a mock-up: PASS or FAIL). A blocker is only a wrong figure that could reach a sheet, an edit that could damage or lose drawing content, a breach of a hard limit, or a ruling built the opposite way. Helpers over-grade: the check room grades again. At most two fix rounds, then held with a one-page open list. One message to the build room, one line to the control room, the owed-in-AutoCAD list to the AutoCAD test room.

## 3. Standing orders (control room)

1. **Nothing reaches main on one check alone;** both halves every time; if the build room merges on one, tell the control room at once.
2. **D-388: no checker or builder runs any script or test of a night-script branch** (team/night-launch, team/acad-pictures2). Both halves by reading only. No script may delete or rewrite `C:\CE_WORK\civil_tests\STOP_ACAD.flag`.
3. **D-364 item 10: no AutoCAD run** until the launcher and the picture route each have the check room's MERGE on both halves and the AutoCAD test room says go.
4. **D-391 (2:40 pm by the control room's clock):** act at once when a report lands or a branch is handed over; a 15-minute look; as many checks side by side as there are hand-overs; no acknowledgements or repeated summaries; one line to the control room per verdict, safety matter or question.

## 4. Lessons of 20 Nov (do not repeat)

1. **A helper was allowed to run a night-script branch's guard-deletion tests in Tim's hours.** The build room flagged it; the check room left it running under watch; the control room ordered it stopped. Nothing real was touched. Rule since: reading only, with the read-only launcher; stop first, judge after.
2. **Time stamps:** read the clock (`date`) before writing any time; several were written minutes ahead and had to be corrected.
3. **Python in a shell heredoc garbles backslashes** (`\C`, `\r`, `\a`): write paths with `chr(92)` or use the Write tool.
4. **A killed helper can leave an orphaned runner behind:** after stopping one, search processes by the helper's scratch folder and by script name, and check twice.

## 5. Where things stood at 2:33 pm (the queue has the detail)

1. **Main line:** 22993fa since 11:07 am. Nothing has been given MERGE today.
2. **Passed:** `design\PIPE_SIZE.md` at d94a9e3: BUILD FROM IT (a pass of the page; the build comes back for both halves, after the amber marker job).
3. **Held or failed, with their pages in `VERDICTS\`:** the night scripts on main; team/night-launch; team/acad-pictures2; team/pipe-default (held, replaced by the design page); team/acad-windows (held; one build of the Pit window to D-386 replaces it: team/a3b-pit-window, still building); the office blocks on main (would have been HOLD); the C11 test list (held at 11c6041); codex/tests-five (held); the Pipe mock-up (three one-line faults from passing; when it passes, the page and pictures go straight to Tim's room, one line to the control room).
4. **Running (eight helpers):** team/held-depth cea5567 (honest half: HOLD on two points; adversarial running); team/a6-draw-first 73be1d0 (honest half: HOLD on one point, one pit per Undo; adversarial running); codex/c11-tests ad01f9d (both halves); codex/tests-a7b 893e54c (both halves).
5. **Expected from the build room:** the Pipe mock-up's next round; team/a3b-pit-window; the next rounds of team/night-launch and team/acad-pictures2 (reading only); codex/tests-five after its fixes; the amber marker job; the pipe-size build.
