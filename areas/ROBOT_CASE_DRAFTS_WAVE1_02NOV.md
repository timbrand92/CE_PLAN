# Robot case drafts, wave 1 and the C-79c train (Mon 2 Nov 2026, about 02:00 Melbourne, read-only drafter, Sonnet)

**What this is.** Case drafts for the fix PRs that have no robot case yet, written as plain text below with the file name each should get. Nothing was run, built, installed or opened in AutoCAD. No case file was created anywhere; this is the only file written. No git write (only `gh pr diff` and `gh pr list`, read-only).

**Sources read:** `C:\TimOS\RULES.md`; `README_CASES.md`; the cases R16, R33, N15, N27 draft shapes, W784, W741 and the shared setups SETUP-R47v and SETUP-DMG-PITLIST; the example `ROBOT_CASE_DRAFTS_TOP12_30OCT.md`; the carpark entries for BUG-246, 312, 573, 779, 783, 785, 786, 744, 746, 1253, 1034, 1268; the regression-log text of PRs #658, #807, #503, #1283, #1410, #1412, #1402, #1422, #1343, #1372, #1941, #1942, #1881, #1975 to #1980 and #1983 (read with `gh pr diff`); the earlier wave-1 reports `WAVE1_WRITING_S1/S2/S3/T2_REPORT.md` and `WAVE1_REVIEW_RS_REPORT.md`; the probe reports `RUN-20261102-0001-...-pPS` and `RUN-20261102-0050-...-pPSd`; the C-79c assembly report and the Opus pre-review AF.

---

## ANSWER FIRST

1. **3 cases drafted, each with a failing twin (6 case texts).** Pilot-critical first: W1034 (order 600, Tidy labels keeps an invert text off its own pipe, PR #1975), W873 (order 602, Tidy labels writes nothing until you type Yes, PR #1977), W246 (order 604, the Pit Schedule window says drawn cells were kept as drawn by a locked layer, PRs #658 and #807).
2. **Every case is a PART claim, not a whole claim.** Each says in its PLAN_ITEM line what it covers and what it leaves to a Codex look.
3. **Two things you were told are not quite right, and I checked them.**
   1. **C-79c does not contain the nine wave-1 bugs.** The register (item 259 to 262) lists C-79c as #1941, #1942, #1881, #1975, #1976, #1977, #1978, #1979 and #1980. The wave-1 fixes are older PRs (#658 and #807, #503, #1283, #1410, #1412, #1402, #1422, #1343, #1372) that the carpark says were installed in Civil 3.0.70. I drafted for both lists.
   2. **Seven of the nine wave-1 bugs still cannot be proved by the robot.** The earlier wave-1 writers (S1, S2, S3, T2) said so and I agree after reading the probe results: the robot cannot place a drawn Pit Schedule (the button "Continue to Place / update" is disabled, probe run 0001), cannot type into a cell, cannot press a right-click menu item, and cannot read the hidden records or reopen the drawing mid-case. They get Codex look notes K1_01 to K1_08 below (the rest of K1_01 to K1_16 cover the C-79c PRs and the leftovers of my own three cases).
4. **BUG-1268 (CDCALC XLSX, draft #1983) is Codex only, as you said:** note K1_02b.
5. **Not drafted at all:** BUG-744, BUG-746 (no robot route, K1_07 and K1_08), PRs #1976, #1978, #1979 (need a prepared drawing the robot cannot build, K1_12 to K1_14), #1980 (the speed fix; R16 already guards that the answer is the same), and #1941, #1942, #1881 (file-picker windows or a drawn schedule: K1_09 to K1_11).
6. **What I could not verify, plainly.** (a) Every window wording marked DERIVED was read from the PR text, not seen on a run. (b) I do not know if DBMOD (AutoCAD's "drawing changed" counter) really moves on the old build in W873; if its twin passes, the case proves nothing and moves to a Codex look. (c) The fixture DRV1_B1 has a drawn schedule whose cells are already stale (S2 report), so W246's window may already say "out of date" before the copy; the case reads the window both before and after to catch that. (d) The other open PRs on rel-20261102a (61 were open at 02:00, several of them the C-79c ones) were not examined one by one (section 5).
7. **Housekeeping.** `gh` would not run until Git's folder was added to the PATH for my own shell; I saved the PR texts to a scratch folder under `C:\CE_WORK\scratch\cs1` and deleted it at the end.

---

## FOR TIM

1. **Done.** Three robot tests written on paper, each with a deliberately wrong copy that must fail (that proves the test can catch the fault). Nothing for you to test or decide.
2. **Example.** Test W1034 moves a CE invert text with Tidy labels and checks it lands clear of its own pipe, not lying on the blue pipe fill. The wrong copy turns the new fix switch off and must fail.
3. **What they cover honestly.** Each covers part of its item. The rest (what the label looks like, a drawn Pit Schedule, a window opened from a file picker) needs a Codex look: seventeen short notes (K1_01 to K1_16 and K1_02b) are written below.
4. **Seven wave-1 bugs have no robot route** (BUG-312, 573, 779, 783, 785, 786, 744/746). They stay with Codex. The one change that would open the most of them is letting the robot press "Place schedule" and type a cell, which needs a reviewed change to the robot's press list and your word. I have not asked for it.

---

## 1. How the drafts are written (read before validating)

1. **Format.** README_CASES.md format: header lines, `STEPS`, `ASSERT`. Every `type` chain is a complete command, no `(`, no SAVE-type word. Every twin carries `VARIANT_OF` and `EXPECT-FAIL BROKEN-VARIANT`.
2. **Switch-off twins, not made-up errors.** For W1034 and W873 the twin is the same route and the same checks with the PR's own switch set to false before launch (the style of `R09s_new_switch_off_broken`). Its recorded FAIL is the "red before green" proof only if the old behaviour really shows on this drawing. If a twin PASSES, the runner reports "now passes: candidate": that means the case does not tell old from new here, and it must go to Codex instead.
3. **REVIEWED_AGAINST is empty** in every draft. No review file is written.
4. **Order numbers** 600 to 605. **Fixture** DRV1_B1 for all. **SLOT fresh** for all.
5. **DERIVED** marks a printed line or a window word read from the PR text or the code, never seen on a run. Expect one or two fix-ups at first run.
6. **Validate first, without AutoCAD:** copy each block to its file name in a new drafts folder (suggested `cases\drafts_wave1b_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`.
7. **Run alone, outside Tim's hours.** W1034 needs SETUP-R47v (4 to 8 minutes under load): keep it with at most one other case per call.

---

## 2. The three cases

### Case 1 of 3: W1034, Tidy labels keeps an invert text off its own pipe (PR #1975, BUG-1034 route; order 600)

**Intended file:** `W1034_tidy_invert_text_off_own_pipe.case.txt`

```
# W1034 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). Fix PR #1975 (B-124, BUG-1253 and BUG-1034), switch linking.tidyKeepsLabelsOffOwnPipeStrip, ON by default (CE_PLAN BUILD REGISTER item 241; in train C-79c).
# Route: exactly R16's accepted route on SETUP-R47v: the SPOT LEVEL block 10EC5D is moved by 81839,-53713 so it sits next to the new pit P8 and blocks the invert text's usual spot; CDTIDYLABELS answers All, then Yes (R16 always answered Esc; the Yes route is N50's DERIVED route and carpark BUG-1034 run 35: the text moved 'in from the pipe end' onto its own pipe).
# What is judged: the new pipe from SETUP-R47v is horizontal at y = -80000 (150000,-80000 to 170000,-80000). After Yes the start invert text IL 18.000 must NOT have its anchor point inside the pipe's strip: its vertical distance from the pipe line must be more than half the pipe width. The strip half-width is half the pipe diameter; the diameter comes from the New Pipe window on this PC (R18 note: 225), so the limit is 112.5 mm (the SETUP records the New Pipe window as $np_win for the reviewer to confirm the 225).
# DERIVED, never seen on a run: that Yes is answered by the chained 'Yes'; that IL 18.000 is still found near 150000,-80000 after the move; that the dist step accepts {$x1} inside the quoted text (N50's draft uses the same form); that the old build puts the anchor inside the strip on this drawing (the twin proves it or it does not).
# Remembered values: YES (SETUP-R47v types PIT and CD). The guard restores CD_Settings.json only.
CASE W1034
TITLE After Tidy labels answers Yes, the start invert text IL 18.000 at the new pit P8 lies clear of its own pipe line, not across the blue pipe fill
PLAN_ITEM PR #1975 (BUG-1034) PART: the Tidy labels Apply half, one text, anchor point against the pipe line. NOT whole: that the label BODY is clear of the strip is a Codex picture; the BUG-1253 half (pit P3 MOVE by 2000, upper-left IL 18.24) is not driven because the P3 pipe strips are not known to the case (Codex look K1_15)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json linking.tidyLabelsEnabled true
SETTING CD_Settings.json linking.tidyKeepsLabelsOffOwnPipeStrip true
SETUP SETUP-R47v
ORDER 600
TIMEOUT 1500
BUG BUG-1034
PROVES_BUGS BUG-1034 (Tidy labels Apply half only; the text body against the strip and BUG-1253 are not proved)
REVIEWED_AGAINST
EXPECTED With the SPOT LEVEL block moved next to P8, CDTIDYLABELS with All previews the move, asks 'Move this label now?' once and Yes applies it; afterwards the text IL 18.000 that belongs to the P8 pipe has its anchor point more than 112.5 mm from the pipe line y = -80000. No CE window is left open.
WHY_NOT_UNIT_TEST The spot the text lands on comes from the live search over the real labels, pit and pipe in the drawing; the unit tests only pin the rule.
NOT_AUTOMATED Whether the text body (not just its anchor) is clear of the blue strip: a Codex picture (RIGHT_LOOKS_LIKE: the red IL text sits beside the blue pipe band, not across it).
NOT_AUTOMATED BUG-1253: MOVE of pit P3 by 0,2000 and the upper-left IL text of P3 (the geometry of P3's pipe strips is not known to this case).
NOT_AUTOMATED One U after Apply and REDO (Codex W4-01 to W4-05; REDO route is BUG-861 territory).
STEPS
  select $new_all "text~^IL 18\.000$" "near=150000,-80000,1500" -> $il0
  field $il0 handle -> $ilh
  pick-first "10EC5D"
  type "_.MOVE{NL}0,0{NL}81839,-53713" -Force -> $spot_move
  wait
  type "_.ZOOM{NL}_W{NL}148500,-81500{NL}152500,-78500" -Force
  wait
  type "CDTIDYLABELS{NL}All{NL}Yes" -Force -> $tidy
  wait
  sleep 2
  esc-prompt -> $tidy_esc
  wait
  ms-new $n0 -> $after_tidy
  select $after_tidy "handle={$ilh}" -> $il1
  field $il1 x -> $x1
  field $il1 y -> $y1
  dist $il1 "{$x1},-80000" -> $dy
  ent-read {$ilh} -> $ilread
  windows-snapshot -> $win_end
ASSERT
  count $il0 = 1
  count $il1 = 1
  history has "Move this label now?"
  number $dy > 112.5
  not-contains $win_end "Edit Pipe"
  record $tidy "FULL CDTIDYLABELS with All and Yes"
  record $tidy_esc "what the closing Esc printed"
  record $dy "vertical distance of the IL 18.000 anchor from the pipe line y -80000 (mm)"
  record $ilread "FULL the IL 18.000 text after Tidy (insertion point and bounding box)"
  record $np_win "FULL New Pipe window before Start Pipe (confirm the diameter, 225 assumed)"
```

**Twin:** `W1034_tidy_invert_text_off_own_pipe_BROKEN.case.txt`

```
# W1034_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The switch-off control of W1034 (the PR's own control, n10 report item 8): linking.tidyKeepsLabelsOffOwnPipeStrip false before AutoCAD starts, so the old behaviour returns (no own strip is a keep-clear area). Same route, same checks. It must FAIL on 'number $dy > 112.5'. If it PASSES, the old build also lands clear on this drawing and W1034 does not tell old from new: say so in the report and send the item to Codex look K1_15.
CASE W1034_BROKEN
TITLE BROKEN VARIANT of W1034: the own-strip switch is OFF, the old behaviour returns, the case still expects the text clear of the pipe (must FAIL)
PLAN_ITEM red-before-green proof for W1034 (PR #1975, BUG-1034)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json linking.tidyLabelsEnabled true
SETTING CD_Settings.json linking.tidyKeepsLabelsOffOwnPipeStrip false
SETUP SETUP-R47v
ORDER 601
TIMEOUT 1500
BUG BUG-1034
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1034
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the text can land on its own pipe, so the distance check fails; the Move this label now question still appears.
WHY_NOT_UNIT_TEST It exists only to prove W1034's distance check can go red.
STEPS
  select $new_all "text~^IL 18\.000$" "near=150000,-80000,1500" -> $il0
  field $il0 handle -> $ilh
  pick-first "10EC5D"
  type "_.MOVE{NL}0,0{NL}81839,-53713" -Force -> $spot_move
  wait
  type "_.ZOOM{NL}_W{NL}148500,-81500{NL}152500,-78500" -Force
  wait
  type "CDTIDYLABELS{NL}All{NL}Yes" -Force -> $tidy
  wait
  sleep 2
  esc-prompt -> $tidy_esc
  wait
  ms-new $n0 -> $after_tidy
  select $after_tidy "handle={$ilh}" -> $il1
  field $il1 x -> $x1
  dist $il1 "{$x1},-80000" -> $dy
ASSERT
  count $il0 = 1
  count $il1 = 1
  history has "Move this label now?"
  number $dy > 112.5
  record $dy "vertical distance of the IL 18.000 anchor from the pipe line (mm), switch OFF"
```

---

### Case 2 of 3: W873, Tidy labels writes nothing until you type Yes (PR #1977, BUG-873; order 602)

**Intended file:** `W873_tidy_writes_nothing_until_yes.case.txt`

```
# W873 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). Fix PR #1977 (B-125, BUG-873), switch linking.tidyLabelsWritesNothingUntilYes, ON by default; stacked on #1975 (in train C-79c).
# Carpark and the n11 report: run CDTIDYLABELS on a copy that has never had Tidy labels run, answer No or press Esc: the drawing must not be marked changed (before the fix the start-up stamped the drawing as a CE drainage drawing and could save CE's project record into it, costing a REDO).
# Route: NO setup (a setup would run PIT and CD first, and those already stamp the drawing, so the old build would also show no change and the case would prove nothing). A fresh DRV1_B1: read DBMOD, type CDTIDYLABELS and answer All, then press Esc at whatever question comes (the Move this label now? question, or nothing if there is nothing to move: both end with nothing written, by the PR), read DBMOD again. The switch linking.tidyLabelsEnabled is set true (R16 does the same).
# DERIVED, never seen on a run: that DBMOD is the same after the Esc with the fix; that the old build moves it (the twin proves it or it does not); the exact prompts in a drawing with nothing to move. The n11 report says the preview pass still opens a normal transaction that commits no change; whether that alone bumps DBMOD is NOT known. If W873 FAILS with the fix on, that transaction is the next suspect, a separate change.
# NO window is opened before the check (opening PITSCHEDULE leaves its own undo step, BUG-817).
# Remembered values: NO.
CASE W873
TITLE On a fresh drawing, CDTIDYLABELS answered All then Esc leaves the drawing's change counter DBMOD exactly as it was
PLAN_ITEM PR #1977 (BUG-873) PART: the drawing-changed counter after Esc. NOT whole: the CE project record stamp and the 'Project data switched to' save line are not read (the exact CE log words are not known); the No answer and the Yes then move path are not driven here (R16 drives the preview and Esc; Codex W4 drives Apply)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json linking.tidyLabelsEnabled true
SETTING CD_Settings.json linking.tidyLabelsWritesNothingUntilYes true
ORDER 602
TIMEOUT 900
BUG BUG-873
PROVES_BUGS BUG-873 (the DBMOD half only)
REVIEWED_AGAINST
EXPECTED DBMOD read on the freshly opened copy equals DBMOD read after CDTIDYLABELS, All and Esc; the Civil log holds one Command outcome line for CDTIDYLABELS; no CE window is left open; the drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST Whether the command marks the real open drawing changed comes from AutoCAD's own change counter after the live command; the unit tests only pin the order of calls.
NOT_AUTOMATED The CE project record stamp on the drawing and the CE log's save line (words not known). The Yes then move path (the writes must happen once, after Yes).
STEPS
  copy-info -> $copy0
  getvar DBMOD -> $m0
  type "CDTIDYLABELS{NL}All" -Force -> $tidy
  esc-prompt -> $tidy_e1
  esc-prompt -> $tidy_e2
  wait
  sleep 2
  getvar DBMOD -> $m1
  windows-snapshot -> $win_end
ASSERT
  equals $m1 $m0
  log civil has "Command outcome: CDTIDYLABELS"
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $m0 "DBMOD before CDTIDYLABELS"
  record $m1 "DBMOD after CDTIDYLABELS and Esc"
  record $tidy "FULL what CDTIDYLABELS printed"
```

**Twin:** `W873_tidy_writes_nothing_until_yes_BROKEN.case.txt`

```
# W873_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The PR's own switch-off control (n11 report item 1): linking.tidyLabelsWritesNothingUntilYes false before AutoCAD starts, so the old start-up (stamp and record save at the start) returns. Same route, same checks. It must FAIL on 'equals $m1 $m0'. If it PASSES, DBMOD does not show the old stamp on this drawing and W873 does not tell old from new: say so and send the item to a Codex look.
CASE W873_BROKEN
TITLE BROKEN VARIANT of W873: the new switch is OFF, the old start-up returns, the case still expects DBMOD unchanged (must FAIL)
PLAN_ITEM red-before-green proof for W873 (PR #1977, BUG-873)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json linking.tidyLabelsEnabled true
SETTING CD_Settings.json linking.tidyLabelsWritesNothingUntilYes false
ORDER 603
TIMEOUT 900
BUG BUG-873
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W873
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the command stamps the drawing at its start, so DBMOD changes and the equals check fails; the Command outcome line still appears.
WHY_NOT_UNIT_TEST It exists only to prove W873's DBMOD check can go red.
STEPS
  getvar DBMOD -> $m0
  type "CDTIDYLABELS{NL}All" -Force -> $tidy
  esc-prompt -> $tidy_e1
  esc-prompt -> $tidy_e2
  wait
  sleep 2
  getvar DBMOD -> $m1
ASSERT
  log civil has "Command outcome: CDTIDYLABELS"
  equals $m1 $m0
  record $m0 "DBMOD before, switch OFF"
  record $m1 "DBMOD after, switch OFF"
```

---

### Case 3 of 3: W246, the Pit Schedule window says drawn cells were kept as drawn by a locked layer (PRs #658 and #807, BUG-246; order 604)

**Intended file:** `W246_schedule_window_says_cells_kept_by_lock.case.txt`

```
# W246 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). BUG-246, fix PRs #658 (the window badge and status line) and #807 (the Xref tick), installed per the carpark in Civil 3.0.70. No Settings switch (the log says so), so there is no switch twin.
# Route: R33's accepted route. Lock the cover-text layer 25TEXT with AutoCAD's own -LAYER, pick-first pit P3 (109D56), COPY it 0,-5000. R33 reads CE's reply 'The drawn pit schedule still shows the old values. Unlock the layer or finish the reference edit, then run PITEDIT on the pit or Update existing schedule in PITSCHEDULE.' (the stale cell is P3's lid and remarks cell, left as drawn because 25TEXT is locked). THEN, with 25TEXT still locked, open PITSCHEDULE and read the window with ui-dump (the same read N02, N15 and N26 use).
# What is judged (DERIVED from the #658 log text, never seen on a run): the window's status line for a locked skip reads '... drawn Pit Schedule cells are out of date: they were left as drawn because their layer is locked ...' and the badge reads OUT OF DATE.
# THE RISK, said first: S2's report says the drawn table on DRV1_B1 is stale for every copy (CE prints 'Pit schedule cell ... not updated: the pit or pipe it was placed for no longer matches' 242 times in the reports). The window may therefore already say OUT OF DATE before this case does anything. The case reads the window once BEFORE the lock and the copy, and asserts the words 'because their layer is locked' are ABSENT then: if the fixture already carries those words, the case FAILS at that check and says why (it cannot tell the lock from the old stale state).
# U is not used: CE never saves, and opening PITSCHEDULE leaves its own undo step (BUG-817).
# Remembered values: NO.
CASE W246
TITLE With the cover-text layer locked, copying pit P3 leaves a drawn cell as drawn, and the Pit Schedule window then says drawn cells were left as drawn because their layer is locked
PLAN_ITEM BUG-246 (PRs #658 and #807) PART: the window words after a locked skip, read from a real drawn schedule. NOT whole: that Refresh then brings the cell up to date and clears the badge (needs Unlock, Refresh and a read; Codex), the Xref tick of #807 (no Xref in the fixture), and the close and reopen route are not driven (Codex look K1_16)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 604
TIMEOUT 1200
BUG BUG-246
PROVES_BUGS BUG-246 (the window words half only)
REVIEWED_AGAINST
EXPECTED Before anything: PITSCHEDULE opens and its text does not contain 'because their layer is locked'. After -LAYER Lock 25TEXT and COPY of P3 by 0,-5000: CE says '1 pit copied and numbered as new.' and 'The drawn pit schedule still shows the old values.'; PITSCHEDULE then opens with the words 'because their layer is locked' and OUT OF DATE in its text; Close ends it. 25TEXT is unlocked at the end. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The words come from the live window reading the real drawn cells of the real schedule and the real layer lock.
NOT_AUTOMATED Refresh after Unlock (cells updated, badge back to CURRENT, one U undoes it), the Xref sources tick (#807), the close and reopen of the drawing: Codex look K1_16.
NOT_AUTOMATED The look of the badge and the status line (RIGHT_LOOKS_LIKE: a red or amber OUT OF DATE badge naming the pit and layer): a Codex look.
STEPS
  copy-info -> $copy0
  type "PITSCHEDULE" -Force -ExpectWindow "Pit Schedule" -TimeoutSec 120 -> $ps0
  sleep 5
  ui-dump "Pit Schedule" -> $sd0
  ui-press "Pit Schedule" "Close" -> $close0
  await-window-gone "Pit Schedule" -Secs 120
  wait
  type "_.-LAYER{NL}_LOCK{NL}25TEXT{NL}{NL}" -Force -> $lk
  wait
  pick-first "109D56"
  type "_.COPY{NL}0,0{NL}0,-5000{NL}{NL}" -Force -> $cp1
  wait
  esc-prompt -> $cp1e
  wait
  sleep 3
  type "PITSCHEDULE" -Force -ExpectWindow "Pit Schedule" -TimeoutSec 120 -> $ps1
  sleep 5
  ui-dump "Pit Schedule" -> $sd1
  ui-press "Pit Schedule" "Close" -> $close1
  await-window-gone "Pit Schedule" -Secs 120
  wait
  type "_.-LAYER{NL}_UNLOCK{NL}25TEXT{NL}{NL}" -Force -> $ul
  wait
  windows-snapshot -> $win_end
ASSERT
  control-text $sd0 absent "because their layer is locked"
  contains $cp1 "1 pit copied and numbered as new."
  contains $cp1 "The drawn pit schedule still shows the old values."
  control-text $sd1 has "because their layer is locked"
  control-text $sd1 has "OUT OF DATE"
  window-closed $close1
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $cp1 "FULL COPY with 25TEXT locked"
  record $sd0 "FULL Pit Schedule window BEFORE the lock and copy (is the fixture already out of date?)"
  record $sd1 "FULL Pit Schedule window AFTER the locked copy"
```

**Twin:** `W246_schedule_window_says_cells_kept_by_lock_BROKEN.case.txt`

```
# W246_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). No lock and no copy, so no cell is kept as drawn by a lock; the case still expects the window to carry the locked-layer words. It must FAIL on that check. If it PASSES, the fixture's window already says 'because their layer is locked' with no lock, and W246 cannot tell the fix from the old state.
CASE W246_BROKEN
TITLE BROKEN VARIANT of W246: nothing is locked or copied, the window is still expected to say a layer is locked (must FAIL)
PLAN_ITEM red-before-green proof for W246 (BUG-246)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 605
TIMEOUT 600
BUG BUG-246
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W246
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with no locked layer the window has no locked-layer words, so the has check fails; the window opens and closes cleanly.
WHY_NOT_UNIT_TEST It exists only to prove W246's words check can go red.
STEPS
  copy-info -> $copy0
  type "PITSCHEDULE" -Force -ExpectWindow "Pit Schedule" -TimeoutSec 120 -> $ps1
  sleep 5
  ui-dump "Pit Schedule" -> $sd1
  ui-press "Pit Schedule" "Close" -> $close1
  await-window-gone "Pit Schedule" -Secs 120
  wait
ASSERT
  window-closed $close1
  copy-unchanged $copy0
  control-text $sd1 has "because their layer is locked"
  record $sd1 "FULL Pit Schedule window with nothing locked"
```

---

## 3. Codex look notes (the robot cannot prove these; each is a short recipe for a Codex pass in real AutoCAD on a copy)

1. **K1_01, BUG-312 (PR #503): held-back plan labels survive a close and reopen.** BLOCKED-FOR-ROBOT: the case needs a close and reopen in the middle, which one case cannot do (S1 report), and CDRENUMBER does not hold a label back (it refuses first). Codex: lock the plan label layer, move a pit so its label is held back (the Civil log says `[BUG-312] pit <handle> kept in the drawing's held-back plan label list (1 left)`), save, close, reopen, unlock the layer, press Refresh in PITSCHEDULE: the label is brought up to date and the log says `taken off ... (0 left)`.
2. **K1_02, BUG-573 (PR #1283): no false "changes" from trailing zeros.** BLOCKED-FOR-ROBOT: needs "Place schedule" (disabled for the robot; probe pPS) and a fresh placement. Codex: two pits, covers 21.000 and 20.800, joined by a pipe, save, reopen, place the linked schedule, open PITSCHEDULE straight away: Changes is empty. Change P1's cover to 21.010: Changes lists exactly that cover. Undo: empty again. (The other half of BUG-573, the stale snapshot, is not fixed by #1283 and stays open whatever this shows.)
3. **K1_02b, BUG-1268 (draft #1983, CDCALC Export to XLSX): Codex only.** Needs the Save As window and a file on disk, which the robot refuses (Export and Save buttons are on its never list). Codex: open CDCALC on a copy, choose Print, Sections and export, Preview package, Export to XLSX; the Save As window should open in the job's Civil folder (or the drawing's folder). Type a new file name and Save: the window status line reads "XLSX saved: <name> in <folder>", the file exists, is not empty and opens as a workbook, and the CE log has `CDCALC: XLSX saved <name> (<bytes> bytes)`. Then Cancel at the Save As window: the log has `CDCALC: XLSX export cancelled at the Save As window`. If Windows again returns "not saved" after a Save click, the box "The XLSX file was not created in <folder>. Nothing was saved." must appear (the cause is still not proved). Control: Pit Schedule Export Excel in the same session.
4. **K1_03, BUG-779 (PR #1410): moving the drawn schedule changes no record.** BLOCKED-FOR-ROBOT: needs a typed override in the window, a live drawn table the robot can place, and the drawn cells on DRV1_B1 are stale so a MOVE proves nothing there (S2 report). Codex: P3 cover overridden to 21.50 (real 21.00) and an inlet to 375 (real 300), place, close, MOVE the whole table: PITSCHEDULE still shows 21.00 and 300 as the real values and the plan label for P3 is unchanged. Type 21.40 into a cover cell that is not overridden: the real cover becomes 21.40. Type 21.40 into the overridden cell: it goes back to 21.50 with the command-line line "This Pit Schedule cell (...) shows a figure typed in the Pit Schedule window...".
5. **K1_04, BUG-783 (PR #1412): a Delete cell stays blank.** BLOCKED-FOR-ROBOT: "Delete cell" is a right-click menu item, and Codex W2-03 found the menu has no such item on this build (BUG-1031). The desk must decide first whether the item was removed on purpose; until then this look cannot be run.
6. **K1_05, BUG-785 (PR #1402): the depth on the drawn schedule uses one rule.** BLOCKED-FOR-ROBOT: needs a drawn table and an edit, and a pump station pit or one between 0.9 and 1.2 m deep, none known on DRV1_B1 (S3 report). Codex: an SPS with cover 10.50, gravity inlet 9.00, rising main outlet 10.00: placed depth 1.50, still 1.50 after PITEDIT; then set the step-iron depth to 1200 mm and refresh a 1.00 m pit: no "With Step Irons".
7. **K1_06, BUG-786 (PR #1422): a new inlet stays with its pit.** BLOCKED-FOR-ROBOT: needs a saved row order, and every way to save one is outside the robot's reach (S3 report). Codex: a schedule of 10 or more pits placed and applied; add a second inlet pipe to P5; reopen PITSCHEDULE: P5's new row sits directly under P5, above P6. Drag P10 to the top, Apply, reopen: it stays at the top.
8. **K1_07, BUG-744 (PR #1343): CDFIXTAGS keeps each source's label state.** BLOCKED-FOR-ROBOT: no typed route makes two ordinary source blocks share a tag (every rename on DRV1_B1 is refused, BUG-813). Codex: place DP twice; set `linking.cdTagRefusesUsedNumberedName` false; insert a plain DOWNPIPE DYNAMIC WITH MASK block; CDTAG it by mouse as DP1, answering No to "Show the tag label on the drawing?"; run CDFIXTAGS and answer Yes: the block with no label gets no new label, the labelled one shows its new name. Repeat with layer GUIDELINES purged: the rename must not be refused.
9. **K1_08, BUG-746 (PR #1372): removing a tag erases its stored records.** BLOCKED-FOR-ROBOT: the records are hidden and `ent-read` cannot list an extension dictionary (T2 report). Best proof is a headless test on a real drawing database. Codex look if wanted: read the tag record handles of a tagged downpipe, run CDTAG Remove ("[CE] CDTAG removed. Source and pipe changes saved together."), then each record handle must come back empty; U brings the tag and its records back, REDO removes them again, save and reopen shows no error.
10. **K1_09, PR #1881 (BUG-587): a long Lid or Remarks note makes a two-row-thick row.** BLOCKED-FOR-ROBOT: needs a placed schedule (Place is not pressable) and a look at the picture. Codex: P1 (Class C Grated Lid, With Step Irons), P2 (lid note "CODEX CHECK With Step Irons"), P3; place, then Update placed schedule: P2's row is 1500 high with its text inside and no line through the middle, P3 one row lower, P1 and P3 rows 750 as before. Save, reopen, Update: nothing moves. One U takes the strips and cells together. Then `linking.scheduleRowGrowsForLongRemark` false and place fresh: the old fixed rows return.
11. **K1_10, PR #1941 (BUG-898): the import results page lists what was really drawn.** BLOCKED-FOR-ROBOT: CDIMPORTXCIVIL starts from a file picker and a results window; Codex owns windows. Codex: lock layer STORMWATER PIT, run CDIMPORTXCIVIL on a package with 3 pits, accept: the page says "Import finished, but 3 of N pits and pipes were NOT drawn", the pit rows read Check with "Not drawn - layer "STORMWATER PIT" is locked". Unlock, run again: every row Recorded and "Import complete. Check the listed drawing items."
12. **K1_11, PR #1942 (BUG-1256): the cancelled import says "CDIMPORTXCIVIL cancelled. Nothing was drawn."** BLOCKED-FOR-ROBOT: same file picker. Codex: run CDIMPORTXCIVIL, choose a drawing, let the schedule page open, press Close: the last command-line line is that sentence and no results window opens. Switch `xcivilImport.cancelLineIsPlainEnglish` false: the old "Import aborted at pre-flight gate" line.
13. **K1_12, PR #1976 (BUG-1161): "APPROX." stays when a pipe label is moved or flipped.** BLOCKED-FOR-ROBOT: needs the label's grip (pointer) and the saved record, which the robot cannot read. Codex: give a pipe label the wording "APPROX.", flip it with the label grip, move it with CDTEXTSEG: "APPROX." is still there. Control: `linking.movedLabelKeepsKeptWording` false. The Opus pre-review says the visible effect may be nil if CE already re-reads the wording.
14. **K1_13, PR #1978 (BUG-890): leader-out never puts a callout on a plain label that stays.** BLOCKED-FOR-ROBOT: needs `linking.tidyLeaderOut` true and a crowded pit group with one callout and one plain text half under a fixed text; the geometry is not known. Codex: CDTIDYLABELS All Yes: no overlap. Control: `linking.tidyLeaderOutKeepsPlainLabelsPut` false puts the callout on the plain text.
15. **K1_14, PR #1979 (BUG-891): a pipe drawn in a layout is checked against that layout's text.** BLOCKED-FOR-ROBOT: needs a layout with a pipe and a model-space text at the same coordinates as one of its invert texts. Codex: CDTIDYLABELS in the layout, All, Yes: the invert text is not moved for the model text. Control: `linking.tidyScanCoversOwnSpaceAndFullReach` false moves it.
16. **K1_15, PR #1975 (BUG-1253, and the picture half of BUG-1034): the label body is clear of the blue strip.** Codex picture: MOVE pit P3 by 0,2000 on a copy of DRV1_B1; zoom to the pit; the upper-left IL text (IL 18.24 in the G5 look) sits beside the blue strip, not across it, and the number circle, cover text and the other four invert texts are clear. Then CDTIDYLABELS All Yes after a hand MOVE of a label: the moved text is clear of the pit and of its own pipe. Control: `linking.tidyKeepsLabelsOffOwnPipeStrip` false gives the old overlap. Also check that labels already beside a pipe do not move.
17. **K1_16, BUG-246 rest (PRs #658, #807): Refresh clears the badge.** Codex: after W246's lock and copy, open PITSCHEDULE (badge OUT OF DATE naming pit, column and layer), tick Xref sources (badge goes back to its normal status), untick, unlock 25TEXT, press Refresh: "1 drawn schedule cell brought up to date", badge CURRENT; one U puts the cell back; close and reopen with the layer locked: the window works the check out again.

---

## 4. Re-run guards, not new cases

1. **R16 and N27 must be re-run on the C-79c build.** #1975 changes where Tidy labels puts texts and runs after every pit MOVE. R16 (preview: P8 line, "Will move 1", Esc moves nothing) and N27 (a hand-placed label is left alone) already pin the answer for the cases the Opus pre-review asks the robot to check; if either fails after C-79c, #1975 is the first suspect.
2. **#1980 (BUG-962, Tidy labels starts faster) needs no new case.** It gives the same answer found faster. R16's preview line is the same-answer guard; the speed (the `[PERF] CDTIDYLABELS count: N ms` log line) needs a drawing with thousands of texts that the robot does not have, and the time saved has not been measured.

---

## 5. Bugs and PRs skipped, and why

1. **BUG-312, 573, 779, 783, 785, 786, 744, 746:** no robot case (reasons in K1_01, K1_02, K1_03 to K1_08). A Codex look is written for each.
2. **BUG-1268:** Codex only (K1_02b), as the brief said.
3. **PRs #1941, #1942, #1881:** Codex looks (K1_09 to K1_11).
4. **PRs #1976, #1978, #1979:** Codex looks (K1_12 to K1_14). **#1980:** covered by R16 (section 4).
5. **BUG-1253 (the pit MOVE half of #1975):** the geometry of P3's pipe strips is not known to a case; picture look K1_15.
6. **The other open PRs on `claude/rel-20261102a` (61 were open at 02:00; the C-79c ones are stacked on other bases, so the exact remainder is not counted) were NOT examined one by one.** Several already have drafts in `drafts_c79b1_01nov` (W1246, W1892, W1952, W658) or are in an earlier train; many are council-value or wording-only changes. If the desk wants them drafted, the next job should take them in batches of about 10, starting with those that touch pit MOVE, COPY, ERASE or CD (the common drafting path): #1887, #1888, #1889, #1891, #1892, #1944, #1946, #1969, #1970, #1972.

---

## 6. What was NOT checked

1. **Nothing was run.** No case was validated with `case_runner.ps1 validate`; the drafts may need first-run fix-ups.
2. **Every window word and printed line marked DERIVED** was read from PR text or earlier cases, not seen on a run.
3. **The installed build was not read.** I did not read the product version of the installed DLLs; the carpark says the wave-1 fixes were installed in Civil 3.0.70 and the probe reports say 3.0.88 is installed. Whether C-79c is installed is not recorded in the files I read.
4. **Whether `dist` accepts `{$x1}` inside quotes, and whether `getvar DBMOD` returns a plain number,** are taken from N15 (DBMOD) and the N50 draft (the quoted form); neither was checked against the runner code.
