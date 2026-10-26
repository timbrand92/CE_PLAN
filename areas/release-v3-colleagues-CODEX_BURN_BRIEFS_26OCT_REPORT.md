# Codex burn briefs, Mon 26 Oct 2026 evening (written about 19:35 Melbourne by the Team desk, Sonnet)

## FOR TIM

1. **Sixteen new Codex briefs are written and queued: ten looks (F1 to F10) and six small bug fixes (cx_bd15 to cx_bd20).** Nothing was run. No AutoCAD, no Codex, no build, no install, none of your settings files touched.
2. **The looks aim at the testing number.** Each one is a window or a picture that Codex's own case reviews (cx_cr01 to cx_cr22) said still needs a Codex look before the robot case or the bug can be accepted. A Codex PASS lets the desk write the visible half as Codex-accepted next to the robot's numbers.
3. **Every look runs on whatever is installed (Civil 3.0.79 / Manager 1.1.79 now).** If a 3.0.80 build gets installed during a look, the brief tells Codex to read the version at the start and again at the end and mark the whole look void if it changed. A void look costs its 3 points and has to be queued again.
4. **Cost against the burn.** Looks are 3 each (30 for the ten). Builds are 8 each (48 for the six). Total 78. Codex is at about 23 percent, the cap is 97, so 23 + 78 = 101: the last build or two will be skipped by the queue's own cap check unless the weekly reset lands first. That is fine; nothing breaks, they just wait.
5. **What I need from you: nothing.** No engineering value is chosen in any brief. The one soft spot is that three of the six fixes are wording or a missing warning rather than a wrong number (see "Why these six", item 4, below).

---

## THE LOOKS (conveyor queue, cap 97, cost 3, model gpt-6.1-sol, medium)

Each brief is a short launcher plus a full brief in `C:\Lisp Files\_CODEX_RUNNER\` (verifyFn_cur.txt and verifyFn_cur_full.txt), built from the same rule block as the E-series looks. Each names the exact robot case file hash and the card or bug it unlocks.

1. **verifyF1_cur: the pipe label as a drafter sees it.** Robot case R18 (hash 0D40A7012C73), card D10 / UX-CPLAN-23. Codex looks at the one label on a new 20 m pipe: reads along the pipe, sits above it near the middle, nothing on top of it, and the same size and material as the New Pipe window said before Start Pipe.
2. **verifyF2_cur: the Pit Schedule window.** Robot case R25 (2DB8A06D260F), cards D21 and D23 window half. Header fields Source, Rows, Changes, Placement; column headings; a P3 row; the Close button; nothing cut off. Opened twice to see it opens the same. No export, no cell edits.
3. **verifyF3_cur: the CDDESIGN window.** Robot case R27 (FF8E8F549086), triage D1. Is the Start tab visibly selected, are the job fields and source rows readable. Cancel only, no design number judged.
4. **verifyF4_cur: the LandXML import window.** Robot case R29 (6978F830B59B), triage X1. Is the file control and the Close button visible and readable. No file chosen, nothing imported.
5. **verifyF5_cur: the Drawing Standards Manager (CDMANAGER).** Robot case R30 (47F342FDCE52). Headings, buttons, clipping, and the builder's lead of doubled Draw Order layer rows. This is the Drawing Standards window, not the Suite Manager update window and not any administrator item (parked by you).
6. **verifyF6_cur: the perimeter drain tag PD1.** Robot case R37 (60891583BAAC), BUG-217. Codex looks at the PD1 text on the plan, then reads the Civil log line "Registered surface drain PD1 handle=" and checks the handle matches the drawn drain. One U takes it all back.
7. **verifyF7_cur: pit and pipe labels, both ends joined, no overlaps.** Robot cases R01 (99BC70E23675), R02 (807FCF12EFBA) and R02b (2EF087A67698), cards D01 and D03. Two pits, a pipe between them, a second row, one U. Every point is typed, so the "1 in 54" click-point problem cannot appear.
8. **verifyF8_cur: every page of the Settings window.** Robot case R07 (7D08DB109F80), card C13, plus R10 (AB3377887B1D) card C16. Per page: control count (the card says more than 30), one saved picture, no clipping; the PC's screen size and Windows scale; the saved-status words; and where the check-ignore switch sits (read only, never clicked).
9. **verifyF9_cur: double-click on a new downpipe.** Robot case R09 (8763A665A9C3), card C04, BUG-859. This is the first look that may ever see CE's Edit source window. If AutoCAD's own attribute editor opens first (the old fault), Codex records which window came first and how many seconds before the other appeared.
10. **verifyF10_cur: About CE Suite on 3.0.79.** Robot case R06 (6D94611EC40B), BUG-090 (last look FAILED: clipped rows) and BUG-1087. Every row, the Close button and the heading contrast, measured.

## THE BUILDS (filler queue, cap 97, cost 8, model gpt-6.1-sol, high)

All six branch from `origin/claude/rel-20261026u` (head 270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1 when read; the installed 3.0.79 is `rel-20261026t`), each in its own worktree under `C:\ce-cx`, each with a test that fails first, a REGRESSION_LOG entry, a draft PR (never merged), a bug-fix switch that starts ON, CE_SHARED untouched, and a stop if C: has under 8 GB.

11. **cx_bd15: BUG-1089.** CDCALC Pipe Flows warns at fixed 0.5 and 3.0 m/s; CDRULES uses your Settings minimum and each material's cap, so the two disagree on the same pipe. The fix reads the Settings values; no number is chosen.
12. **cx_bd16: BUG-1093.** The redesign cover check is skipped when a pit lid is exactly RL 0.000 (zero is treated as "not typed"). A pit with no cover typed stays skipped as today.
13. **cx_bd17: BUG-1115.** CDWT on the command line: a typed 0 for detention is replaced by the library tank's figure. Enter alone still takes the library figure; a typed 0 stays 0.
14. **cx_bd18: BUG-1182.** Manager View History can show another module's release notes (Civil showing Manager's). The brief says to read the real file names first and stop with BLOCKED if the names carry no module word.
15. **cx_bd19: BUG-1178.** A shared-file mismatch tells a colleague to "run the CE installer again" when they have none. A non-administrator is told to ask the CE administrator.
16. **cx_bd20: BUG-1174.** CDWT silently skips its tank-picture window when the Standard Details folder is missing; the fix adds one plain line saying why.

## WHY THESE SIX, AND WHAT WAS LEFT OUT (plain)

1. **The strong wrong-answer and data-loss bugs are used up.** I checked all 1,000 newest PRs and every cx_bd01 to cx_bd14 brief by bug number, branch and file name. Most pilot-critical ones already have a draft PR. Of the rest: BUG-1088, BUG-1091, BUG-901, BUG-907 and BUG-866 need your ruling on a number; BUG-1148, 1141, 1161, 1157, 1164 and 1197 sit in protected files; BUG-1052 and 1054 are in PR #1716 and #1727; BUG-1192 and 1193 sit in the long-section file that eight IJK PRs already edit.
2. **BUG-1092 (uphill pipe called "essentially flat") was dropped.** The 5 mm figure is a named Settings value (ReverseFallToleranceMm), so changing it is probably your call.
3. **BUG-1155 and BUG-651 were dropped.** BUG-1155's files are in PR #1767, and BUG-651 is already PR #1311.
4. **Three of the six (BUG-1174, 1178, 1182) are about wording or which notes show, not a wrong number.** They are real faults a colleague meets in week one, but they are not data-loss. BUG-1089, 1093 and 1115 are the wrong-answer ones.
5. **Two builds touch the same file as an open PR, and the briefs say so:** BUG-1089 and PR #1561 (PipeFlowCalcViewModel.cs), BUG-1093 and PRs #1669/#1555 (NetworkDesignService.cs), BUG-1182 and PR #1445. BUG-1115 and BUG-1174 both edit WaterTankCommand.cs (different lines). Expect a small merge for the desk.

## WHAT I DID NOT CHECK (RULES 5.9)

1. **No brief was run or dry-run.** Every typed route in a look comes from the robot cases, the earlier D and E briefs, or the case reviews; where a route is not proven the brief tells Codex to write the exact words and mark BLOCKED, not to invent one. The weakest routes: F6 (the answers at the CDPERIMETER prompts, from the robot's typed string), F7 (Enter at the pit label prompts), and F9 (finding the downpipe's outer circle on a screenshot).
2. **Settings page appearance (BUG-863 / BUG-862).** Those two numbers are about the check-ignore switch and the outcome words, not a page layout. I read your line as "the Settings pages and the ignore switch" and built F8 that way. The outcome-line half of BUG-862 is a log wording and needs no look.
3. **E6 and E7 overlap F10 and F8.** E6 also re-looks at About CE Suite and E7 at the Settings tabs. F10 and F8 are narrower and add what the case reviews asked for (3.0.79 row measurements; control counts, pictures, scale). If E6 and E7 run first and PASS, F10 and F8 are cheap confirmations.
4. **The build causes were read from the code at the base head, never compiled.** BUG-1093 needs a "cover known" flag on the network node: if that cannot be added without a protected file, the brief says BLOCKED.
5. **The PR scan covered the newest 1,000 PRs only.**

## FILES

1. **Briefs:** `C:\Lisp Files\_CODEX_RUNNER\verifyF1_cur.txt` to `verifyF10_cur.txt` with `_full.txt` beside each, and `cx_bd15.txt` to `cx_bd20.txt`.
2. **Queue lines:** appended to `C:\CE_PLAN\desk_jobs\CONVEYOR_QUEUE.txt` (ten) and `C:\CE_PLAN\desk_jobs\FILLER_QUEUE.txt` (six), after each brief file existed.
3. **Scratch (throwaway, not a build script):** `C:\ce-fx\burn26_briefs\`.
