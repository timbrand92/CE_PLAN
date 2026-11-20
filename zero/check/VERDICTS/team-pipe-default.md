# Verdict: team/pipe-default at 741f0f2 (Stage 1 item A5, the size a pipe opens at)

**Verdict: HOLD. Three blockers.** Written Fri 20 Nov 2026, 11:32 am, by the check room. Checked on the bench only; nothing here says anything works in AutoCAD. This was the branch's first check here after one fix round in the build room, so **one fix round is left** (D-346: at most two, then held with a one-page open list).

**The claim.** A pipe always opens with a size: the size of what it joins, else the office default 100 dia. (a setting); "Not known" is never the opening size; with several pipes arriving, the largest (D-263, never smaller downstream).

**Who checked.** Honest check: Team helper, Claude Opus 5.5, `C:\CE_WORK\check\reports\pipe-default_honest_REPORT.md`. Adversarial pass: Codex gpt-6.2-astra, `C:\CE_WORK\check\reports\pipe-default_adv_REPORT.md`, proofs in `pipe-default_adv_tests\` and `pipe-default_honest_probes\`. Two different helpers, each in its own fresh worktree. The check room read both reports, the proof logs for blockers 1 and 3, and the named lines for blocker 1.

## 1. Suite counts seen

1. **At the branch tip (741f0f2):** brain 758, bench 442, hands 653, saved-drawing reader 9: 1,862 passed, 0 failed, 0 skipped. Log `C:\CE_WORK\check\reports\pipe-default_honest_test1.log`.
2. **Merged with main (22993fa), not committed:** one conflict, in `BUILD_LOG.md` only. Brain 758 passed; hands 673 passed; reader 19 passed, 2 skipped (main's own, waiting on the office blocks file); bench 441 passed, 1 failed once (an on-screen Pit list test, not touched by this branch; passed 3 of 3 on re-run while other test runs shared the screen). Log `pipe-default_honest_test2.log`.
3. **The acceptance list is honest as far as it goes:** no test was weakened, and the tests bite (with the fix undone they fail). But every test builds the pipes by hand or uses the bench's made-up job. None opens the tool's own window on a drawing. That is why the suite is green with blocker 1 standing.

## 2. Blockers

1. **The Pipe tool's own window never sees the pipes arriving at the start pit, so "what it joins" is never used on a drawing.** Found by both helpers independently.
   - **Kind:** a ruling built the opposite way (D-263, never smaller downstream), and a wrong figure that could reach a sheet (the label and the drawn width).
   - **Where:** `bench/CeCivil.Bench.Core/PipeToolWindow.cs:36-40` builds the window from the upstream pit, the pipe and the downstream pit only; `src/CeCivil.Hands/Pipe/PipeTool.cs:56` (the context) has nowhere to carry arriving pipes; `src/CeCivil.Acad/PipeCommand.cs:89-98` opens that window.
   - **On a job:** a 225 runs P5 to P6. Type CD, click P6 to P7. The window opens at 100 and OK draws a pipe 100 wide labelled "100 DIA. UPVC PIPE AT 1 IN 100". The same with a 375, with two equal 225s, and with 150, 225 and 375 arriving. On main the same clicks refused and drew nothing; the branch turns a refusal into a confident wrong size.
   - **Proof:** test H1 in `pipe-default_honest_probes\ZzCheckProbeHandsTests.cs` (logs `probe_hands_tip.log`, `probe_hands_main.log`); `pipe-default_adv_tests\DrawingSizeReview.cs` lines 44 and 65.
2. **Editing an older pipe can shrink it to 100, and its cover can read "Suits" when it is short.**
   - **Kind:** an edit that could damage drawing content, and a wrong figure.
   - **Where:** `src/CeCivil.Hands/Pipe/PipeTool.cs:201` and `:483`, `bench/CeCivil.Bench.Core/PipeToolWindow.cs:52`. The opening size is worked out afresh each time and is not kept with the pipe (the pipe's note holds only the grade).
   - **On a job:** a pipe drawn 375 wide whose note holds no size (an older pipe, or one drawn while the job's default was 375). Open its window: the drawing still shows 375 but the window offers 100. Change only which side the label sits and press OK: the pipe and its label become 100. Before OK, with ground at 10.00 and invert at 9.50, the window says cover 0.40 m, "Suits"; the pipe on the drawing has 0.125 m, 175 mm short. D-349 says the drawn pipe supplies the figure.
   - **Proof:** `pipe-default_adv_tests\DrawingSizeReview.cs` lines 129, 171 and 190; log `pipe-default_adv_drawing.log` ("drawn width=375 mm; size in window=100; Suits: Cover 0.40 at P4, needs 0.30").
3. **The last size typed carries into the next unrelated pipe.**
   - **Kind:** a ruling built the opposite way. D-263, Tim's own example: "IF I DRAW ONE SINGULAR 375 DIA. AND THE REST IS STILL 100 DIA. THEN I THINK IT WOULD BE EASIER TO START FROM THE DEFAUL EACH TIME"; ruled: a pipe starting from nothing opens on the office default; last used is for pits, inlets and tanks.
   - **Where:** `src/CeCivil.Acad/PipeCommand.cs:87` passes the last pipe to `src/CeCivil.Hands/Pipe/PipeTool.cs:205`, which keeps its diameter. An existing test guards the old behaviour (`tests/CeCivil.Hands.Tests/PipeWindowFromDrawingTests.cs:282`).
   - **On a job:** draw one 375. Start a separate run 5 m away: it opens, draws and labels at 375, and records the size as typed, though nobody typed it.
   - **Note:** this was on main before the branch. It is counted here because it makes this branch's claim ("else the office default 100") untrue after the first typed pipe, and it is the exact case Tim described.
   - **Proof:** `pipe-default_adv_tests\DrawingSizeReview.cs` line 55; honest report section 7 item 2.

## 3. What the one remaining fix round must show (failing tests first)

1. The tool's own window, opened on a drawing where a 225 arrives at the start pit, opens at 225; with 150 and 225 arriving, 225; draws and labels to match.
2. A pipe keeps the size it was drawn at: opening and pressing OK on any existing pipe without touching the size never changes its width or label, whatever the job's default is now; the window's size and cover are those of the drawn pipe.
3. After a typed 375, a new pipe from nothing opens at 100; a pipe off a pit follows what arrives.
4. The whole suite green at the tip and merged with main.

## 4. Not blockers for this branch

Kept in `FOLLOW_UP\part2-pit-and-pipe.md`. In short: a zero or negative default-size setting still gives cover and storage figures (narrow: it needs a bad setting, and the Job window that would set it is Stage 2); a blank or text setting stops the whole data library opening; clearing the size box keeps the old size; no line compares a typed smaller size with what arrives. Faults the adversarial pass found that are on main already and belong to other items, passed to the control room rather than held against A5: the label drops "MIN." when an invert is not entered (D-238, D-312); a run cannot start on a pipe and a run clicked first-to-last misses the pit between; a plain polyline cannot be picked as the run (D-355, D-356: item A6); the Pipe window still holds the words "Bench preview" (item A3, team/acad-windows).

## 5. The engine change

The change in `src/CeCivil.Brain/Sums/Sum.cs:225-232` reaches one other sum only, the site's underground storage (`sums.csv:178`). Both helpers ran main against the branch: for a site with no tank, 40 m of 225 detention pipe, main gave "Not known" and the branch gives 1.59 m³, which is right; the council check still reads "Cannot check yet" unless a tank figure of zero is given outright. No figure that could reach a sheet is wrong from this change. No test covers it yet (follow-up).

## 6. Owed in AutoCAD (for the AutoCAD test room, after the fix; test copy from the office template, outside Tim's hours)

1. **From nothing:** type CD, click from a fresh pit to a point. Right: opens at 100; OK draws a pipe 100 wide labelled "100 DIA. ... AT 1 IN 100 MIN.".
2. **One arriving:** draw P1 to P2 at 225; CD from P2 to P3. Right: opens at 225, drawn 225 wide, labelled "225 DIA.".
3. **Several arriving:** bring 150, 225 and 375 to one pit; CD from that pit. Right: opens at 375.
4. **A typed size stands:** type 150 over the 225, OK. Right: drawn 150 wide, labelled "150 DIA.".
5. **Last used:** straight after item 4, CD from a fresh pit with nothing arriving. Right: 100, not 150.
6. **An older pipe keeps its size:** on a pipe drawn at 375, open its window, change only the label side, OK. Right: width and label still 375. Also record whether opening the drawing or REGEN alone changes any width or label (not proven either way on the bench).
7. **Upstream change:** type a new size on an upstream pipe; record every pipe below it, width and label, before and after. No ruling yet on what should happen (U-048).
