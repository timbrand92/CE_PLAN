# Robot weak-check repair: R02bv87 (a new pipe that ends on pit P8)

Drafted Mon 2 Nov 2026 (Melbourne) by Sonnet, read-only, at CE 00's request, for CE 02's weak-check list. Nothing was built, run or tested. No case file was changed: the repaired text below is a DRAFT for CE 05 to place.

---

## FOR TIM

1. **Verdict: REPAIRABLE with the robot alone.** No Codex look is needed for this case.
2. **What the case claims:** a pipe drawn from open ground to the centre of pit P8 joins the pit at its far end. The command line says "Flow: Open end -> P8" once.
3. **Why it was weak:** the old "pipe box y = -80112.5" check passed whether the pipe joined or not (any 225 pipe on that line sits there). On 1 Nov CE 02 deleted it. That left ONE proof of the join: a line of text CE prints.
4. **The repair:** read the pipe's own size from the drawing. When CE joins a pipe to a pit it pulls the pipe's end back to the pit wall, so the pipe's right edge sits at 149775, not at the typed 150000. The 3 runs on 31 Oct, 1 Nov and 2 Nov already recorded 149775; nobody was checking it.
5. **The broken twin gets the same check first,** so a red result proves the new check can fail on its own, not just the old text line.
6. **Counts for PART only:** the join at the second end. NOT proved: the 75 mm catch edge, two pits close together, U undoing the join, the inlet's row in the Pit Schedule. The new check has not been run yet: it needs one robot run, then a fresh independent review (the old review no longer matches the changed case).

---

## What was read

1. **Case:** `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_v387_30oct\R02b_pipe_ends_on_pitv87.case.txt` (as changed by CE 02 on 1 Nov 21:48). Backup of the earlier text: `R02b_pipe_ends_on_pitv87.case.txt.pre_weakfix`.
2. **Twin:** `R02b_brokenv87.case.txt` (same folder). Setup `SETUP-P8v`. Sister case `R02_pipe_joins_pitv87` (pipe that STARTS on a pit) for the format and its box-corner reasoning.
3. **Reports:** RUN-20261031-0932-C3.0.88-aF3v (PASS), RUN-20261031-1217-C3.0.88-bF3v (PASS), RUN-20261031-1602-C3.0.88-tW3 (twin FAILED on check 1, no flow line), RUN-20261101-1933-C3.0.88-pcF3v (PASS), RUN-20261102-0039-C3.0.88-peR2 (PASS, 232 s, CD settings unchanged). Ledger: `ledger.json` shows the twin result FAIL and the case PASS-UNREVIEWED.
4. **Reviews:** `R02b_pipe_ends_on_pitv87.review.txt` (Opus, 1 Nov 08:18, covers the case text with SHA 5966451C...; that SHA is now stale because the case was edited) and `C:\CE_PLAN\areas\C78_REVIEW_C_REPORT.md` case 10, which named this case one of the weakest three.
5. **Not read:** the REGRESSION_LOG entry and PR for UX-PIPE-02 were not opened (the review file already gives the source lines: CdCommand.cs 817 and 823, LinkService.NewPipeEnds.cs 53). The runner's own field list was read in `case_runner_lib.ps1` line 251 only.

---

## What the case claims to prove

UX-PIPE-02, the "pipe ends on a pit" half (Tim: "On (Recommended)": a pipe whose end lands within 75 mm of the one matching pit joins it automatically). In the drawing: after the setup puts pit P8 at 150000,-80000, typing CD from open ground 130000,-80000 to the pit centre 150000,-80000 should make ONE new pipe, joined to P8 at its second end.

## Why the check is weak (exact lines)

1. **Old line 36 of the `.pre_weakfix` file:** `number $b_py = -80112.5 +- 50`. It reads the pipe's lower-left box corner, y only. The pipe is a straight horizontal 225 pipe on the line y = -80000, so y is -80112.5 joined or not. It could not fail on a missing join. CE 02 removed it on 1 Nov (the first line of the current case says so).
2. **What is left in the current case (lines 36 to 38 of the current file):** `history has "Flow: Open end -> P8"`, `history count ... = 1`, `count $b_pipes = 1`. Everything else is `record`, which is written to the report and never judged. So the whole join claim rests on one line of CE's own wording. If CE ever printed that wording without really linking the pit (the BUG-560 style of drift), the case would still pass.
3. **The unused evidence:** the report of every PASS (for example peR2, check 8) shows the pipe object's box: `130000, -80112.5, 149775, -79887.5`. The right edge is 149775, which is the pit wall (150000 minus 225), not the typed 150000. That is CE moving the pipe end to the pit wall on joining. R02 (pipe starts on pit) already relies on the same behaviour at the other end (x = 150225). R02b only recorded `$b_px` (the LEFT edge, 130000), which says nothing about the join end.
4. **Twin weakness (smaller):** the twin ends 2 m short and also has to change the first level (18.090 instead of 18.100) to keep the grade. Its red is real (tW3 failed check 1 with "no command-line line contains 'Flow: Open end -> P8'") but it only ever proves the text check, because the old box check was also red-proof-free.

## Repaired case (replace the whole file)

Header keeps the CE 02 comment lines. REVIEWED_AGAINST is left empty. Whole-or-part claim: PART. DERIVED marks are on every figure that came from a report, not from the source or the card.

```
# CE 02 weak-check repair 1 Nov 2026: DELETED the check number $b_py = -80112.5 +- 50 (it passes with or without a join, since the pipe is drawn the same either way). Backup: R02b_pipe_ends_on_pitv87.case.txt.pre_weakfix
# Repair 2 (Sonnet draft 2 Nov 2026, CE 05 to place): the join is now ALSO read from the drawing. CE pulls a joined pipe's end back to the pit wall, so the pipe box's right edge sits at 149775 (DERIVED: box 130000, -80112.5, 149775, -79887.5 recorded as 'FULL objects the new pipe added' in aF3v, bF3v, pcF3v, peR2). The step field $b_pipes note is the box text the runner already writes for a CE pipe object (case_runner_lib.ps1 line 251).
# 3.0.87 variant of R02b (CE 02 30 Oct 2026, CE 00 ruling 17:50): typed levels at 1 in 100 or steeper because #1841 makes the pipe-size grade 1 in 100, so a flatter typed pipe opens the Grade mismatch window. Mechanical copy: the original case is unchanged; derived figures still need a review.
# R02b = the other half of daily case D03 (UX-PIPE-02): a new pipe whose SECOND end lands on a pit. Added by the batch 3 fixes job of 25 Oct 2026 from the hardening review (RUNNER_CASE_REVIEW_HARDEN_2026-10-25.md item 2.3.2). R02 covers the pipe that STARTS on a pit.
CASE R02bv87
TITLE A new pipe that ends on pit P8 joins it: the flow line says Open end -> P8 and the pipe's end sits on the pit wall
PLAN_ITEM UX-PIPE-02 (daily case D03), the pipe-ends-on-a-pit half
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8v
ORDER 21
TIMEOUT 600
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After the setup (pit P8 at 150000,-80000 and a pipe leaving it), CD from the open point 130000,-80000 to the pit centre 150000,-80000 with levels 18.100 / 17.900 (a 0.2 m fall over 20 m is the default 1 IN 100; other levels open a "Grade mismatch" question that waits for an answer) prints 'Inserted flow arrow. Flow: Open end -> P8' once, makes exactly one new pipe object, and CE pulls the pipe's end back to the pit wall: the pipe box's right edge reads 149775 (the pit centre 150000 minus 225), and its left edge stays at the typed open point 130000. Two independent readings of the join: CE's own line and the pipe's own size in the drawing. A twin that ends the pipe 2 m short of the pit (R02b_BROKEN) must show neither.
WHY_NOT_UNIT_TEST The join is made by the live CD point landing against the real pit in the drawing.
NOT_AUTOMATED This case counts for 'a pipe ended on a pit joins it at its second end' only (PART). Not covered: the 75 mm capture edge (the pit centre is typed), two pits in reach, one U undoing the join, the Pit Schedule row of P8 (read in R02 for the pipe that starts on the pit), the pit's own outline. The pipe's last vertex is not read directly: the pipe box edge is the stand-in.
STEPS
  ms-count -> $nb0
  type "CD{NL}130000,-80000{NL}150000,-80000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 120 -> $b_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.100"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $b_t2
  await-window-gone "^New Pipe" -Secs 120
  windows-snapshot -> $b_w1
  esc-prompt -> $b_e1
  wait
  ms-new $nb0 -> $b_new
  select $b_new object=CeCvlPipeObject -> $b_pipes
  field $b_pipes x -> $b_px
  field $b_pipes y -> $b_py
  field $b_pipes note -> $b_note
ASSERT
  history has "Flow: Open end -> P8"
  history count "Flow: Open end -> P8" = 1
  count $b_pipes = 1
  number $b_px = 130000 +- 50
  matches $b_note "130000(\.0+)?, -80112\.5, 14977[0-9](\.[0-9]+)?, -79887\.5"
  record $b_w1 "windows after Start Pipe"
  record $b_t1 "FULL CD from the open point to the pit"
  record $b_e1 "FULL after Start Pipe"
  record $b_py "pipe box y (lower-left), recorded only: it is the same joined or not"
  record $b_note "FULL pipe box (min x, min y, max x, max y)"
  record $b_new "FULL objects the new pipe added"
```

DERIVED marks (every number that came from a report, not from the card or the source):

1. **DERIVED:** 149775 right edge, from the recorded box in aF3v, bF3v, pcF3v and peR2 (one reading each, same value). The regex accepts 149770 to 149779 so a rounding digit cannot fail it; it still fails at 150000 (not joined) or 148000 (twin).
2. **DERIVED:** -80112.5 and -79887.5 (225 pipe centred on y = -80000), same recorded box.
3. **DERIVED:** 130000 left edge, same box.
4. **NOT checked against the card or the source.** The "end pulled back to the pit wall" behaviour is read from reports and from R02's own comment, not from source code. The independent reviewer must confirm it against `LinkService.NewPipeEnds.cs` and UX-PIPE-02 before this check counts.

## Repaired twin (replace `R02b_brokenv87.case.txt`)

The new box check is put FIRST in the twin's ASSERT, so the recorded red proves the new check can fail on its own. Only the ASSERT block and the note lines change; the steps stay as they ran in tW3.

```
# 3.0.87 variant of R02b_BROKEN (CE 02 30 Oct 2026, CE 00 ruling 17:50): typed levels at 1 in 100 or steeper because #1841 makes the pipe-size grade 1 in 100, so a flatter typed pipe opens the Grade mismatch window. Mechanical copy: the original case is unchanged; derived figures still need a review.
# R02b_BROKEN: a DELIBERATELY BROKEN twin of R02b (batch 3 fixes, 25 Oct 2026) and a true red: the same CD, but the second point is 2 m short of the pit (148000,-80000 instead of 150000,-80000), so the pipe does not end on P8.
# Repair 2 (Sonnet draft 2 Nov 2026): the pipe-box right-edge check is listed FIRST so a red result is caused by the new check alone. The twin must fail BOTH the box check and the flow-line check.
CASE R02b_BROKENv87
TITLE BROKEN VARIANT of R02b: the pipe ends 2 m short of the pit (must FAIL)
PLAN_ITEM red-before-green proof for R02b
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8v
ORDER 93
TIMEOUT 600
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF R02bv87
REVIEWED_AGAINST
EXPECTED This variant is wrong on purpose: the pipe stops 2 m before the pit, so its right edge reads about 148000 (not 149775) and the line 'Flow: Open end -> P8' must not appear. Both of R02b's join checks fail.
WHY_NOT_UNIT_TEST It exists only to prove R02b can fail when the pipe does not land on the pit.
STEPS
  ms-count -> $nb0
  type "CD{NL}130000,-80000{NL}148000,-80000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 120 -> $b_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.090"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $b_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $b_e1
  wait
  ms-new $nb0 -> $b_new
  select $b_new object=CeCvlPipeObject -> $b_pipes
  field $b_pipes note -> $b_note
ASSERT
  matches $b_note "130000(\.0+)?, -80112\.5, 14977[0-9](\.[0-9]+)?, -79887\.5"
  history has "Flow: Open end -> P8"
  count $b_pipes = 1
  record $b_note "FULL pipe box (min x, min y, max x, max y)"
```

Open point on the twin (to be settled by the reviewer, not assumed): the pipe ends 2 m short, so its right edge should read about 148000. That figure is NOT in any report (tW3 did not record the box). The first run of the twin will show it; the twin's pass or fail does not depend on the exact figure, only on it not being 14977x.

## One run, then review

1. **Run (CE 05, in a free window):** R02bv87 and R02b_BROKENv87 together, `-IncludeVariants -Only "R02bv87,R02b_BROKENv87"`. Expect the main case PASS with the box line reading max x 149775 and the twin FAIL on the box check (first_failure names the box, not the flow line).
2. **If the main case reads a right edge other than 14977x:** the "pulled back to the wall" belief is wrong or depends on something (pit size, grade). Stop, do not loosen the regex to make it pass; report the real edge.
3. **Review:** a fresh independent Opus review file for the changed case (new SHA), checking the box claim against `LinkService.NewPipeEnds.cs` and UX-PIPE-02, and recording the 75 mm edge and U-undo as not covered.
4. **Acceptance:** under the 1 Nov pilot, a second AutoCAD session is not needed if the family's first case passed in two sessions (it did: aF3v and bF3v). Still PART only.

## What this does NOT prove (plain)

1. The 75 mm edge: the pit centre is typed, so a pipe 60 mm or 90 mm off the pit is not tried. That belongs to the N23 family.
2. Two pits within reach (CE must refuse to guess): not covered.
3. One U puts the pipe and the join back: not covered here (R11 and N15 style cases).
4. The inlet's row in the Pit Schedule: not covered (read in R02 for the pit that STARTS a pipe).
5. Nothing here has been run. The numbers above are read from earlier reports only.
