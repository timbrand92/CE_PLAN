# Robot case drafts, set 4: CDRULES and council rows (Mon 2 Nov 2026, read-only drafter, Sonnet)

**What this is.** Case drafts for six B-132 fix PRs (#1963, #1964, #1966, #1968, #1971, #1973) heading for `origin/claude/rel-20261102a`. Nothing was run, built, installed or opened in AutoCAD. No case file was created anywhere. This is the only file written. No git write was run (only `git fetch`, `gh pr view`, `gh pr diff`).

---

## FOR TIM

1. **Done.** Four robot tests written on paper, each with a deliberately wrong copy that must fail: W1971, W1963, W1966 and W1968 (8 case texts). The wrong copy turns the fix's own switch OFF before AutoCAD starts, so it behaves like the old build.
2. **Example.** Test W1963 sets the drawing to Maroondah, draws one 150 mm pipe at 1 in 100, runs CDRULES, and checks the line says the pipe is "flatter than the council minimum 1:80". The wrong copy turns the switch off and must not say it.
3. **Codex only (no robot test possible):** #1964 (Darebin 30 m between pits, shown in the Design Check window) and #1973 (the lot-size note, shown in the CDDESIGN window). Numbered Codex looks K4_01 and K4_02 are below.
4. **Needs an Opus review before it runs because of Undo, REDO, a locked layer or an Xref:** none. No case here uses U, REDO, a locked layer or an Xref. One thing is worth knowing: typing a council into CDRULEBOOK writes into the drawing's CE record inside AutoCAD's memory only (the runner never saves, and reopens a fresh copy for every case).
5. **Every case is a PART claim.** Each says in its PLAN_ITEM line what it covers and what it leaves out. None can say the whole fix is proved, because the test lines the council figures were checked against (council documents) were not re-read by the PRs themselves, and Tim's word on council values is still needed (RULES 4.5).
6. **What I could not verify.** (a) Every printed line marked DERIVED comes from the PR text and code, not from a run. (b) CDRULES prints at most 80 rows on the command line. The fixture has hundreds of "unknown" rows, so the one council row may fall past row 80. If a first run shows "... N more in the saved list" and no council row, the answer is in the saved file, which the robot cannot read. W1971 (the values list) does not have this problem. (c) The pipe material the New Pipe window starts with is not known; W1966's exact speed number depends on it.
7. **Skipped:** #1964 and #1973 (Codex only, above). Nothing was skipped because it already had a case.

---

## 1. How the drafts were written (read before validating)

1. **What I read:** `C:\TimOS\RULES.md`; `README_CASES.md` (all of it, including the batch 1 to 3 notes on refused buttons); the finished example `ROBOT_CASE_DRAFTS_TOP12_30OCT.md`; the switch-off twin style in `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md` and `variants\R09s_new_switch_off_broken.case.txt`; the case R21, R14 and the draft N33_grade_mismatch_x (for the New Pipe window chain); the setup SETUP-R47v; the SET02 draft W1890 (for the typed CDRULEBOOK route); the six PR texts and diffs (`gh pr view`, `gh pr diff`); `RulesCommand.cs` and `RulebookCommand.cs` on `origin/claude/rel-20261102a` (read with `git show`); and the robot transcripts of CDRULES runs on 19 and 20 Oct (to see what the fixture says).
2. **Checked again that no case exists.** I looked in `cases\` and every `drafts_*` folder under it, in every `ROBOT_CASE_DRAFTS_*.md` (including sets 1 to 3), and in `runner-reports\ledger.json` by case id and by BUG number. No case or draft exists for any of the six. The earlier search was right.
3. **How the council is chosen.** The fixture drawing DRV1_B1 has no council (transcripts: "no council profile set (CDRULEBOOK > Council)"). The route used is the typed one in `RulebookCommand.cs`: `CDRULEBOOK`, keyword `Council`, then the council id typed at the prompt (`maroondah`, `banyule`, `frankston`, `manningham`, `kingston`; the ids are in `council-profiles.json`). No settings file is touched for this; Tim's real settings are never read or written. The only settings written are the PR's own switch, through the `SETTING` guard, before AutoCAD starts.
4. **Switch-off twins.** Each twin has the same route and the same route checks, with the PR's own switch set to `false` before launch. Only the checks on the new wording go red. If a twin PASSES, the runner reports "now passes: candidate": that means the case cannot tell old from new on this drawing, and the fix goes to Codex.
5. **The originals do not name their switch** (the shipped default is ON). Each twin names it as `false`. If Opus prefers both to name it, add `SETTING CD_Settings.json <key> true` to the original.
6. **REVIEWED_AGAINST is empty** in every draft. No review file is written. Order numbers 730 to 737. Fixture DRV1_B1, SLOT fresh. Every `type` chain is a complete command with no `(` and no SAVE-type word.
7. **Reading the answer.** CDRULES prints findings on the command line; `history has` reads the whole log from the case start, not just the last 20 lines. The cap is the command's own 80 printed rows (see FOR TIM item 6). The case also records the project record with `v3 record-set ... -To READ` (a `record` line only, not judged) so the first run shows whether the council row is kept there.
8. **Empty ground used.** The two pipe cases draw from 150000,-90000 to 170000,-90000. This is inside the area the earlier cases (SETUP-P8, R36, R37, N04) use as empty ground. If a first run shows an object there, move the y by the same amount in all four texts.
9. **Validate first, without AutoCAD:** copy each block to its file name in a new folder (suggested `cases\drafts_set04_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`.
10. **Run alone, outside Tim's hours.** W1968 names SETUP-R47 (3 to 6 minutes). Keep it to one other case per call.
11. **BUILD PENDING.** These cannot run until the Civil build that contains #1963, #1966, #1968 and #1971 is installed. Nothing else is needed from Tim.

---

## 2. The case texts

### Case 1 of 4: W1971, CDRULES Values lists the R-22 tank orifice minimum (PR #1971, BUG-1104; orders 730 and 731)

**Intended file:** `W1971_cdrules_values_r22_tank_orifice.case.txt`

```
# BUILD PENDING: cannot run until the Civil build containing PR #1971 (B-132) is installed (origin/claude/rel-20261102a).
# W1971 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1971 (B-132, BUG-1104), switch checks.councilTankOrificeMinimum, ON by default.
# Route: no drawing content is needed. CDRULEBOOK Council is typed with the council id, then CDRULES Values is typed; three councils in one drawing: manningham (25 mm), maroondah (20 mm), kingston (no figure: 'not checked').
# DERIVED from the PR tests, never seen on a run: the three R-22 lines, 'R-22 tank orifice minimum: 25 mm (Manningham; source: Manningham City Council, On-Site Stormwater Detention Guidelines', '... 20 mm (Maroondah; source: Maroondah City Council', '... not checked. Kingston has no tank orifice minimum in CE's records', 'no tank orifice size is recorded in the drawing'. The line CDRULES Values ends with ('Nothing was changed.') is read from RulesCommand.cs on the release branch.
# The values are not Tim-approved council figures: the case reads that the list shows what the PR stores, never that 25 or 20 mm is right.
# Remembered values: NO (nothing is placed).
CASE W1971
TITLE With the job set to Manningham, Maroondah and Kingston in turn, CDRULES Values lists the R-22 tank orifice minimum 25 mm, 20 mm and 'not checked', and changes nothing
PLAN_ITEM PR #1971 (BUG-1104) PART: the CDRULES Values line for three councils. NOT whole: the warning itself (a 15 mm tank orifice on a Manningham job warns against 25 mm) cannot be driven because CE records no tank orifice size in any drawing (PR item 2); the tank flows against the permitted discharge check is not built
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 730
TIMEOUT 600
BUG BUG-1104
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After CDRULEBOOK Council manningham, CDRULES Values prints 'R-22 tank orifice minimum: 25 mm (Manningham; source: Manningham City Council, On-Site Stormwater Detention Guidelines ...' and says no tank orifice size is recorded in the drawing; after maroondah it prints '... 20 mm (Maroondah; source: Maroondah City Council ...'; after kingston it prints 'R-22 tank orifice minimum: not checked. Kingston has no tank orifice minimum in CE's records'; each Values answer ends 'Nothing was changed.'; the number of objects in the drawing and the file on disk do not change; no CE window is left open.
WHY_NOT_UNIT_TEST The council comes from what CDRULEBOOK writes into the live drawing's record, and the line is only seen on the live command line.
NOT_AUTOMATED The warning for a tank orifice below the council figure: no tank orifice size exists in a drawing, so no command can raise it (PR item 2). It is covered by the unit test only.
NOT_AUTOMATED The 'tank orifice flows add up to no more than the permitted discharge' check: not built, and no council source exists in CE's notes (question for Tim).
NOT_AUTOMATED Whether 25 mm and 20 mm are right: council values stay Tim's call; the PR did not re-read the council PDFs.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDRULEBOOK{NL}Council{NL}manningham" -Force -> $set_m
  wait
  type "CDRULES{NL}Values" -Force -> $val_m
  wait
  type "CDRULEBOOK{NL}Council{NL}maroondah" -Force -> $set_mar
  wait
  type "CDRULES{NL}Values" -Force -> $val_mar
  wait
  type "CDRULEBOOK{NL}Council{NL}kingston" -Force -> $set_k
  wait
  type "CDRULES{NL}Values" -Force -> $val_k
  wait
  esc-prompt -> $e_end
  ms-count -> $c1
  windows-snapshot -> $win_end
  getvar CMDACTIVE -> $ca
ASSERT
  contains $val_m "Council: Manningham"
  contains $val_m "R-22 tank orifice minimum: 25 mm (Manningham; source: Manningham City Council, On-Site Stormwater Detention Guidelines"
  contains $val_m "no tank orifice size is recorded in the drawing"
  contains $val_mar "R-22 tank orifice minimum: 20 mm (Maroondah; source: Maroondah City Council"
  contains $val_k "R-22 tank orifice minimum: not checked. Kingston has no tank orifice minimum in CE's records"
  history count "R-22 tank orifice minimum:" = 3
  history count "Nothing was changed." = 3
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  equals $c1 $c0
  copy-unchanged $copy0
  record $set_m "FULL what CDRULEBOOK Council manningham printed"
  record $val_m "FULL the Manningham values list"
  record $val_mar "FULL the Maroondah values list"
  record $val_k "FULL the Kingston values list"
```

**Twin:** `W1971_BROKEN_tank_orifice_switch_off.case.txt`

```
# BUILD PENDING: cannot run until the Civil build containing PR #1971 (B-132) is installed.
# W1971_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Same route and same route checks as W1971 with the PR's own switch checks.councilTankOrificeMinimum typed false before AutoCAD starts (settings are read at launch). With it OFF the values list is exactly as before the PR: no R-22 line at all (PR item 4). So the four R-22 checks FAIL; the Council line, 'Nothing was changed.', the object count and the file stay as W1971 and must PASS. That proves the case watches the new R-22 line and nothing else.
CASE W1971_BROKEN
TITLE BROKEN VARIANT of W1971: the R-22 switch is OFF, yet the case still expects the R-22 tank orifice line (must FAIL)
PLAN_ITEM red-before-green proof for W1971 (PR #1971, BUG-1104)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json checks.councilTankOrificeMinimum false
ORDER 731
TIMEOUT 600
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1971
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the three Values lists carry no R-22 line, so every 'R-22 tank orifice minimum' check fails. The Council line and 'Nothing was changed.' still appear.
WHY_NOT_UNIT_TEST It exists only to prove W1971's R-22 checks can go red on the old behaviour.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDRULEBOOK{NL}Council{NL}manningham" -Force -> $set_m
  wait
  type "CDRULES{NL}Values" -Force -> $val_m
  wait
  type "CDRULEBOOK{NL}Council{NL}maroondah" -Force -> $set_mar
  wait
  type "CDRULES{NL}Values" -Force -> $val_mar
  wait
  type "CDRULEBOOK{NL}Council{NL}kingston" -Force -> $set_k
  wait
  type "CDRULES{NL}Values" -Force -> $val_k
  wait
  esc-prompt -> $e_end
  ms-count -> $c1
  windows-snapshot -> $win_end
  getvar CMDACTIVE -> $ca
ASSERT
  contains $val_m "Council: Manningham"
  contains $val_m "R-22 tank orifice minimum: 25 mm (Manningham; source: Manningham City Council, On-Site Stormwater Detention Guidelines"
  contains $val_m "no tank orifice size is recorded in the drawing"
  contains $val_mar "R-22 tank orifice minimum: 20 mm (Maroondah; source: Maroondah City Council"
  contains $val_k "R-22 tank orifice minimum: not checked. Kingston has no tank orifice minimum in CE's records"
  history count "R-22 tank orifice minimum:" = 3
  history count "Nothing was changed." = 3
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  equals $c1 $c0
  copy-unchanged $copy0
  record $val_m "FULL the Manningham values list with the switch OFF"
```

---

### Case 2 of 4: W1963, CDRULES R-03 holds a DN150 drain to Maroondah's 1 in 80 (PR #1963, BUG-1059; orders 732 and 733)

**Intended file:** `W1963_cdrules_r03_maroondah_dn150_1_in_80.case.txt`

```
# BUILD PENDING: cannot run until the Civil build containing PR #1963 (B-132) is installed (origin/claude/rel-20261102a).
# W1963 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED; the PR touches the protected rulebook, so the PR itself needs an Opus review). PR #1963 (B-132, BUG-1059), switch checks.councilMinGradeBySize, ON by default.
# Route: CDRULEBOOK Council maroondah; one ordinary pipe is drawn with the New Pipe window: diameter 150, my own grade 1 in 100, first invert 18.000, second invert 17.800 over 20 m (200 mm fall in 20000 mm is exactly 1 in 100; the same chain as the accepted cases, with CustomGrade 100 so no Grade mismatch window opens). CDRULES All is typed.
# What changes: the office ladder for DN150 is 1 in 100 (seen in the 20 Oct transcripts: 'DN150 1:100'), so the old build PASSES this pipe. Maroondah's own figure is 1 in 80, so the new build WARNS.
# DERIVED, never seen on a run: 'actual 1:100 is flatter than the council minimum 1:80' and ', office ladder 1:100' inside the finding (RulebookEngine.cs MinGradeRule, CouncilGradeBySize.BothFigures); that the pipe is judged ordinary (not stormwater, not detention) with the window's defaults; that the council's name prints as 'council Maroondah' (CDRULES summary line); that CommandLineText.Plain keeps the '1:80' wording.
# RISK, said plainly: CDRULES prints at most 80 rows and the fixture has hundreds of 'unknown' rows. If the R-03 row for the new pipe is past row 80 this case FAILS for that reason, and the first run's record lines show it ('... N more in the saved list'). Then the answer is in the saved file or the Codex look, not in the case.
# Remembered values: YES (New Pipe saves the grade mode, the Set my own value and the pipe size to the remembered values; the fresh drawing and the settings guard keep it away from Tim's work).
CASE W1963
TITLE With the job set to Maroondah, CDRULES R-03 warns that a 150 mm drain at 1 in 100 is flatter than the council minimum 1 in 80 and shows the office 1 in 100 beside it
PLAN_ITEM PR #1963 (BUG-1059) PART: Maroondah DN150 at 1 in 100 warns in CDRULES All. NOT whole: exactly 1 in 80 passes, another council or another size reads as before, detention pipes are not held to it (all unit-tested only); the fix planner and the New Pipe grade prefill still read the office ladder (PR item 5, not changed); the saved list rows past 80
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 732
TIMEOUT 900
BUG BUG-1059
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CDRULEBOOK Council maroondah is accepted; one DN150 pipe, 20 m long, inverts 18.000 and 17.800, is drawn; CDRULES All prints its summary naming council Maroondah and an R-03 row saying 'actual 1:100 is flatter than the council minimum 1:80' with 'office ladder 1:100' beside the council figure and the Maroondah source; the drawing's object count does not change during CDRULES; no CE window is left open.
WHY_NOT_UNIT_TEST The pipe's size and levels come from a real pipe drawn through the real New Pipe window, the council from the drawing's record, and the row from the live CDRULES run.
NOT_AUTOMATED Exactly 1 in 80 passes, and Kingston gives the old wording (needs a second pipe and a second council; unit-tested). Raise the upstream invert to 18.050 for 1 in 80: a Codex look if Tim wants it.
NOT_AUTOMATED The saved list is not read (the robot has no file-read verb). If the R-03 row is past row 80 the result cannot be judged here.
NOT_AUTOMATED Whether Maroondah's 1 in 80 applies to every ordinary DN150 drain is engineering judgement (Tim, decision 176); the case reads only that CDRULES now says so.
STEPS
  copy-info -> $copy0
  type "CDRULEBOOK{NL}Council{NL}maroondah" -Force -> $set_c
  wait
  ms-count -> $c0
  type "CD{NL}150000,-90000{NL}170000,-90000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "100"
  ui2-set "New Pipe" "C2.Diameter" "150"
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.800"
  ui-dump "^New Pipe" -TimeoutSec 60 -> $np1
  ui-press "New Pipe" "New pipe, Start Pipe" -> $start
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $esc_pipe
  wait
  ms-new $c0 -> $new
  select $new "object~^CeCvlPipeObject$" -> $pipes
  ms-count -> $c_before_rules
  type "CDRULES{NL}All" -Force -> $rules
  wait
  esc-prompt -> $rules_e
  wait
  ms-count -> $c_after_rules
  v3 record-set nod -Part CE_CVL_SUITE_PROJECT/PROJECT_DATA -To READ -> $rec_after
  windows-snapshot -> $win_end
  getvar CMDACTIVE -> $ca
ASSERT
  count $pipes = 1
  control-text $np1 has "150"
  history has "[CE] CDRULES:"
  history has "council Maroondah"
  history has "is flatter than the council minimum 1:80"
  history has "office ladder 1:100"
  equals $c_after_rules $c_before_rules
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  copy-unchanged $copy0
  record $set_c "FULL what CDRULEBOOK Council maroondah printed"
  record $rules "FULL what CDRULES All printed (look for the R-03 row and for '... N more in the saved list')"
  record $rec_after "FULL the project record after CDRULES (does it keep the findings?)"
```

**Twin:** `W1963_BROKEN_min_grade_switch_off.case.txt`

```
# BUILD PENDING: cannot run until the Civil build containing PR #1963 (B-132) is installed.
# W1963_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Same route and same route checks as W1963 with the PR's own switch checks.councilMinGradeBySize typed false before AutoCAD starts. With it OFF R-03 returns exactly as before (PR item 3): the DN150 pipe at 1 in 100 meets the office ladder 1 in 100 and PASSES, so the two wording checks FAIL. The pipe checks, the council name, the object count and the clean file must PASS, so this proves the case watches the wording and not the drawing.
CASE W1963_BROKEN
TITLE BROKEN VARIANT of W1963: the council minimum grade switch is OFF, yet the case still expects the council 1 in 80 warning (must FAIL)
PLAN_ITEM red-before-green proof for W1963 (PR #1963, BUG-1059)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json checks.councilMinGradeBySize false
ORDER 733
TIMEOUT 900
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1963
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the DN150 pipe at 1 in 100 passes R-03 against the office ladder, so 'is flatter than the council minimum 1:80' and 'office ladder 1:100' are absent and those two checks fail.
WHY_NOT_UNIT_TEST It exists only to prove W1963's wording checks can go red on the old behaviour.
STEPS
  copy-info -> $copy0
  type "CDRULEBOOK{NL}Council{NL}maroondah" -Force -> $set_c
  wait
  ms-count -> $c0
  type "CD{NL}150000,-90000{NL}170000,-90000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "100"
  ui2-set "New Pipe" "C2.Diameter" "150"
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.800"
  ui-dump "^New Pipe" -TimeoutSec 60 -> $np1
  ui-press "New Pipe" "New pipe, Start Pipe" -> $start
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $esc_pipe
  wait
  ms-new $c0 -> $new
  select $new "object~^CeCvlPipeObject$" -> $pipes
  ms-count -> $c_before_rules
  type "CDRULES{NL}All" -Force -> $rules
  wait
  esc-prompt -> $rules_e
  wait
  ms-count -> $c_after_rules
  windows-snapshot -> $win_end
  getvar CMDACTIVE -> $ca
ASSERT
  count $pipes = 1
  control-text $np1 has "150"
  history has "[CE] CDRULES:"
  history has "council Maroondah"
  history has "is flatter than the council minimum 1:80"
  history has "office ladder 1:100"
  equals $c_after_rules $c_before_rules
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  copy-unchanged $copy0
  record $rules "FULL what CDRULES All printed with the switch OFF"
```

---

### Case 3 of 4: W1966, CDRULES minimum-speed row uses Banyule's own band (PR #1966, BUG-1057; orders 734 and 735)

**Intended file:** `W1966_cdrules_r02_banyule_min_speed_1_0.case.txt`

```
# BUILD PENDING: cannot run until the Civil build containing PR #1966 (B-132) is installed (origin/claude/rel-20261102a).
# W1966 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED; the PR touches the protected rulebook, so the PR itself needs an Opus review). PR #1966 (B-132, BUG-1057), switch checks.councilSpeedBands, ON by default.
# Route: CDRULEBOOK Council banyule; one pipe: diameter 225, default grade, first invert 18.000, second invert 17.900 over 20 m (100 mm in 20000 mm is 1 in 200, which is the office ladder for 225: no Grade mismatch window; the same chain as the accepted cases). CDRULES All is typed.
# What changes: the office minimum speed is 0.6 m/s. A DN225 at 1 in 200 runs about 0.8 m/s full bore on concrete (the PR's worked case), so the old build PASSES R-02; Banyule's published minimum is 1.0 m/s, so the new build WARNS.
# DERIVED, never seen on a run: 'is below the Banyule minimum 1.0 m/s' (CouncilSpeedBand wording in the PR) and 'Stormwater Drainage Requirements' (the source name in the Banyule provenance note). The exact speed printed ('0.80') is NOT asserted: it depends on the pipe material the New Pipe window starts with, which this drafter did not find. On uPVC (a smoother pipe) the speed is higher, about 0.94 m/s, still below 1.0, so the warning is expected on either; if the material makes it 1.0 or more, the case FAILS and the record line says why.
# RISK, same as W1963: CDRULES prints at most 80 rows; R-02 rows come after the R-01 rows, so the R-02 row for the new pipe is expected inside the 80, but that is not known.
# Remembered values: YES (see W1963).
CASE W1966
TITLE With the job set to Banyule, CDRULES warns that a 225 mm drain at 1 in 200 runs below Banyule's minimum speed of 1.0 m/s, naming Banyule's own document
PLAN_ITEM PR #1966 (BUG-1057) PART: Banyule's minimum speed row (R-02) in CDRULES All. NOT whole: the Maroondah 5.0 m/s maximum on a DN600 RCP (a second pipe, 17 m, fall 1.000 m, the PR's worked case, not driven), Frankston, the 'less than half full' figures (shown beside, never tested), and the pipe size review rows that still use the office speeds (PR item 6)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 734
TIMEOUT 900
BUG BUG-1057
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After CDRULEBOOK Council banyule and one DN225 pipe at 1 in 200 over 20 m, CDRULES All prints its summary naming council Banyule and an R-02 row warning that the full-bore speed is below the Banyule minimum 1.0 m/s, naming 'Stormwater Drainage Requirements'; the object count does not change during CDRULES; no CE window is left open.
WHY_NOT_UNIT_TEST The speed comes from the real pipe's size, levels and material read out of the live drawing; only CDRULES on the live command line shows the words.
NOT_AUTOMATED The maximum-speed row for Maroondah (5.0 m/s on DN600 RCP at 5.27 m/s) and Frankston; the 'less than half full' figure; whether Banyule's 1.0 m/s minimum applies to every flow condition (the council document states none): all Tim's call (decision 176).
NOT_AUTOMATED The exact full-bore speed number: not asserted because the pipe material the New Pipe window starts with is not known to this case.
STEPS
  copy-info -> $copy0
  type "CDRULEBOOK{NL}Council{NL}banyule" -Force -> $set_c
  wait
  ms-count -> $c0
  type "CD{NL}150000,-90000{NL}170000,-90000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.Diameter" "225"
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-dump "^New Pipe" -TimeoutSec 60 -> $np1
  ui-press "New Pipe" "New pipe, Start Pipe" -> $start
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $esc_pipe
  wait
  ms-new $c0 -> $new
  select $new "object~^CeCvlPipeObject$" -> $pipes
  ms-count -> $c_before_rules
  type "CDRULES{NL}All" -Force -> $rules
  wait
  esc-prompt -> $rules_e
  wait
  ms-count -> $c_after_rules
  v3 record-set nod -Part CE_CVL_SUITE_PROJECT/PROJECT_DATA -To READ -> $rec_after
  windows-snapshot -> $win_end
  getvar CMDACTIVE -> $ca
ASSERT
  count $pipes = 1
  control-text $np1 has "225"
  history has "[CE] CDRULES:"
  history has "council Banyule"
  history has "is below the Banyule minimum 1.0 m/s"
  history has "Stormwater Drainage Requirements"
  equals $c_after_rules $c_before_rules
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  copy-unchanged $copy0
  record $rules "FULL what CDRULES All printed (look for the R-02 row, its speed number and any '... N more in the saved list')"
  record $rec_after "FULL the project record after CDRULES"
```

**Twin:** `W1966_BROKEN_speed_bands_switch_off.case.txt`

```
# BUILD PENDING: cannot run until the Civil build containing PR #1966 (B-132) is installed.
# W1966_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Same route and same route checks as W1966 with the PR's own switch checks.councilSpeedBands typed false before AutoCAD starts. With it OFF R-01 and R-02 are exactly as before (PR item 5): the pipe's 0.8 m/s is above the office 0.6 m/s and passes, so 'is below the Banyule minimum 1.0 m/s' and the Banyule document name are absent and those two checks FAIL. The pipe, the council name, the object count and the clean file must PASS.
CASE W1966_BROKEN
TITLE BROKEN VARIANT of W1966: the council speed bands switch is OFF, yet the case still expects Banyule's 1.0 m/s minimum (must FAIL)
PLAN_ITEM red-before-green proof for W1966 (PR #1966, BUG-1057)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json checks.councilSpeedBands false
ORDER 735
TIMEOUT 900
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1966
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the 225 mm pipe at about 0.8 m/s passes the office minimum 0.6 m/s, so 'is below the Banyule minimum 1.0 m/s' and 'Stormwater Drainage Requirements' are absent and those two checks fail.
WHY_NOT_UNIT_TEST It exists only to prove W1966's wording checks can go red on the old behaviour.
STEPS
  copy-info -> $copy0
  type "CDRULEBOOK{NL}Council{NL}banyule" -Force -> $set_c
  wait
  ms-count -> $c0
  type "CD{NL}150000,-90000{NL}170000,-90000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.Diameter" "225"
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-dump "^New Pipe" -TimeoutSec 60 -> $np1
  ui-press "New Pipe" "New pipe, Start Pipe" -> $start
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $esc_pipe
  wait
  ms-new $c0 -> $new
  select $new "object~^CeCvlPipeObject$" -> $pipes
  ms-count -> $c_before_rules
  type "CDRULES{NL}All" -Force -> $rules
  wait
  esc-prompt -> $rules_e
  wait
  ms-count -> $c_after_rules
  windows-snapshot -> $win_end
  getvar CMDACTIVE -> $ca
ASSERT
  count $pipes = 1
  control-text $np1 has "225"
  history has "[CE] CDRULES:"
  history has "council Banyule"
  history has "is below the Banyule minimum 1.0 m/s"
  history has "Stormwater Drainage Requirements"
  equals $c_after_rules $c_before_rules
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  copy-unchanged $copy0
  record $rules "FULL what CDRULES All printed with the switch OFF"
```

---

### Case 4 of 4: W1968, CDTWL says what clearance a Frankston job wants to a habitable floor and that it was not checked (PR #1968, BUG-1056; orders 736 and 737)

**Intended file:** `W1968_cdtwl_habitable_floor_not_checked_frankston.case.txt`

```
# BUILD PENDING: cannot run until the Civil build containing PR #1968 (B-132) is installed (origin/claude/rel-20261102a).
# W1968 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED; the PR touches DetentionTwlService.Describe next to the protected TWL solver, so the PR itself needs an Opus review). PR #1968 (B-132, BUG-1056), switch checks.councilHabitableFloorFreeboard, ON by default.
# Route: exactly R14's accepted route on SETUP-R47 (CDTWL with the two answers 10 and 18.70), after CDRULEBOOK Council frankston is typed. The PR adds one line after 'That is enough.' (or 'That is NOT enough'). R14's own lines are the 150 mm lid freeboard, which the PR says is separate and unchanged.
# DERIVED, never seen on a run: 'Habitable-floor freeboard not checked: no habitable floor level is recorded for this drawing. Frankston wants the water at least 300 mm below a habitable floor (...). Check it by hand.' (read from the PR text, item 1); that Frankston as the council does not change R14's own 40 mm and 110 mm lines (PR item 1 says the lid freeboard is unchanged; R14 ran with no council). If those two route checks fail on a first run, drop them and keep the new-line checks: the case is about the new line.
# The 300 mm is the PR's stored Frankston figure (OSD guidelines, September 2021, page 4); the case reads that CDTWL says it, never that 300 mm is right.
# Remembered values: YES (SETUP-R47 types PIT and CD; the fresh drawing keeps them off Tim's work).
CASE W1968
TITLE With the job set to Frankston, CDTWL adds a line saying the water must be at least 300 mm below a habitable floor and that this was NOT checked, naming the Frankston guidelines
PLAN_ITEM PR #1968 (BUG-1056) PART: the Frankston line after CDTWL's answer. NOT whole: Manningham, Banyule and Darebin lines; the clearance given a floor level (no floor source exists in a drawing, PR item 3: the comparison waits for it, unit-tested only); no line for a council with no figure (needs a second council); the separate 150 mm lid freeboard, left as R14
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-R47
ORDER 736
TIMEOUT 1500
BUG BUG-1056
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After CDRULEBOOK Council frankston, CDTWL with 10 and 18.70 prints R14's 40 mm and 110 mm lid lines, then one line beginning 'Habitable-floor freeboard not checked: no habitable floor level is recorded for this drawing. Frankston wants the water at least 300 mm below a habitable floor' and ending 'Check it by hand.', and asks nothing more; no CE window is left open; the Civil log holds one 'Command outcome: CDTWL completed'.
WHY_NOT_UNIT_TEST The words come from the live pit covers and the council in the drawing's record; the line is only seen on the live command line.
NOT_AUTOMATED The comparison with a real habitable floor level (water 100 mm below a floor at 10.200 reads 'Only 100 mm ...; Frankston wants 300 mm'): there is no way to record a floor level in a drawing yet (PR item 3, needs Tim's word on the floor source).
NOT_AUTOMATED Whether 300 mm is right for Frankston, and the Manningham, Banyule and Darebin figures: Tim's call (decision 176).
STEPS
  copy-info -> $copy0
  type "CDRULEBOOK{NL}Council{NL}frankston" -Force -> $set_c
  wait
  type "CDTWL{NL}10{NL}18.70" -Force -> $twl
  wait
  sleep 2
  windows-snapshot -> $win_end
  getvar CMDACTIVE -> $ca
  log-read civil -> $civlog
ASSERT
  history has "Only 40 mm between the water and the lid of pit C1 (150 mm is wanted)."
  history has "Habitable-floor freeboard not checked: no habitable floor level is recorded for this drawing."
  history has "Frankston wants the water at least 300 mm below a habitable floor"
  history has "Check it by hand."
  history count "Habitable-floor freeboard not checked" = 1
  not-contains $win_end "New "
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  log civil count "Command outcome: CDTWL completed" = 1
  copy-unchanged $copy0
  record $set_c "FULL what CDRULEBOOK Council frankston printed"
  record $twl "FULL what CDTWL printed (the new line and its place after 'That is enough')"
```

**Twin:** `W1968_BROKEN_habitable_floor_switch_off.case.txt`

```
# BUILD PENDING: cannot run until the Civil build containing PR #1968 (B-132) is installed.
# W1968_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Same route and same route checks as W1968 with the PR's own switch checks.councilHabitableFloorFreeboard typed false before AutoCAD starts. With it OFF CDTWL's lines are exactly as before (PR item 4): the habitable-floor line is absent, so its four checks FAIL. R14's 40 mm line, the window and Civil-log checks must PASS.
CASE W1968_BROKEN
TITLE BROKEN VARIANT of W1968: the habitable-floor switch is OFF, yet the case still expects the 'not checked' line (must FAIL)
PLAN_ITEM red-before-green proof for W1968 (PR #1968, BUG-1056)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-R47
SETTING CD_Settings.json checks.councilHabitableFloorFreeboard false
ORDER 737
TIMEOUT 1500
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1968
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF CDTWL prints no habitable-floor line, so the four checks on that line fail.
WHY_NOT_UNIT_TEST It exists only to prove W1968's wording checks can go red on the old behaviour.
STEPS
  copy-info -> $copy0
  type "CDRULEBOOK{NL}Council{NL}frankston" -Force -> $set_c
  wait
  type "CDTWL{NL}10{NL}18.70" -Force -> $twl
  wait
  sleep 2
  windows-snapshot -> $win_end
  getvar CMDACTIVE -> $ca
  log-read civil -> $civlog
ASSERT
  history has "Only 40 mm between the water and the lid of pit C1 (150 mm is wanted)."
  history has "Habitable-floor freeboard not checked: no habitable floor level is recorded for this drawing."
  history has "Frankston wants the water at least 300 mm below a habitable floor"
  history has "Check it by hand."
  history count "Habitable-floor freeboard not checked" = 1
  not-contains $win_end "New "
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  log civil count "Command outcome: CDTWL completed" = 1
  copy-unchanged $copy0
  record $twl "FULL what CDTWL printed with the switch OFF"
```

---

## 3. Codex look notes (the two fixes with no robot route)

### BLOCKED-FOR-ROBOT: #1964 (BUG-1058), Darebin 30 m between pits in the Design Check window

**Why one line:** the new row shows only in the Design Check (CDDASHBOARD) window, whose title, row words and Clear-filters button the robot has never driven; the window wording is only in the PR text.

**K4_01, Codex look.** Evidence folder `C:\CE_WORK\codex\K4_01_1964_darebin_pit_spacing\` (make it first; save every screenshot there, never accept or capture a folder AutoCAD or Windows opened a box in).

1. **Prepare (a copy, never Tim's drawing).** Open a copy of the test drawing in millimetres. Place two pits 40000 mm apart (PIT at 0,0 and at 40000,0, cover level 19.000 each), then CD between them, 225 mm, first invert 18.000, second invert 17.800, text on. Write down the pipe's length from the pipe label.
2. **Set the council.** Type CDRULEBOOK, Enter, type Council, Enter, type darebin, Enter. Screenshot the command line (it should say the council was set to Darebin).
3. **Open the window.** Type CDDASHBOARD, Enter. If a row filter hides rows, press its clear-filters button. Screenshot the whole window.
4. **Right looks like (DERIVED from the PR text, not seen on a run):** a row naming the pipe by its two pits, its length 40.0 m, the council figure 30 m, the document name (Darebin, Legal Point of Discharge Guidelines, June 2025) and the advice to add an intermediate pit or ask the council for an exception. Wrong looks like: no run-length row for the 40 m pipe.
5. **Two more pipes.** Draw one 29 m and one exactly 30 m between new pit pairs and re-run CDDASHBOARD: neither is flagged. Draw one 81 m: two rows, and the office one says "CE office limit, not a council figure".
6. **Council change.** CDRULEBOOK, Council, kingston, CDDASHBOARD again: the 40 m pipe shows no run-length row.
7. **Switch-off look.** Close AutoCAD, set `checks.councilMaxPitSpacing` to false in the settings the test copy uses (a test profile only, never Tim's real file), start AutoCAD, repeat steps 2 and 3: no Darebin row. Screenshot it.
8. **Not covered:** CDCHECKDWG, the Xcivil import QA and the CE Assistant review (PR item 4: they still read the office limit alone). Darebin's 30 m is the PR's stored figure; whether it applies to private drainage is Tim's call.

### BLOCKED-FOR-ROBOT: #1973 (BUG-1116), lots of 1000 m2 and over on the short office Tc get one note

**Why one line:** the note shows in the CDDESIGN / permitted-discharge window, and CDDESIGN results reach no command line, log or file (memory: CDCALC and CDDESIGN results are window-only).

**K4_02, Codex look.** Evidence folder `C:\CE_WORK\codex\K4_02_1973_large_lot_tc_note\`.

1. **Prepare.** Open a copy of the test drawing. Set the council to none (CDRULEBOOK, Council, None) so no council gives the permitted discharge and no council sets Tc by site case (Kingston commercial keeps its own warning and gets no second note).
2. **Open CDDESIGN** and enter a residential lot of 2500 m2 with the office's short Tc (5 min). Do not give a permitted discharge: the sizing must work it out itself. Screenshot the design notes.
3. **Right looks like (DERIVED from the PR text):** one sentence like "Tc 5 min used for this 2500 m2 lot, but the office rule for a short Tc covers lots under 1000 m2: confirm the time of concentration for a lot this size. A longer Tc gives a lower rainfall intensity, so the permitted discharge and the storage depend on it." Exactly one such sentence, not two. The Tc used, the flows, the permitted discharge and the storage are the same as with the note switch off.
4. **Under 1000 m2.** Enter a 600 m2 lot: no such note. Enter exactly 1000 m2: the note appears (the PR says "1000 m2 or more"; check the boundary and write down what happened).
5. **Council gives the discharge.** Set a council that gives the permitted discharge and re-run the 2500 m2 lot: no note.
6. **Switch-off look.** Close AutoCAD, set `checks.largeLotTcNote` to false in the test profile, start AutoCAD, repeat step 2: no note and every number identical to step 2. Screenshot both and compare the numbers by eye.
7. **Not covered:** whether the office rule is right for a 2500 m2 lot is Tim's call (PR item 2); the 1000 m2 limit is a number in the code, not a Settings row.

---

## 4. Fixes skipped and why

1. **#1964 (BUG-1058):** Codex only, K4_01. Window-only; not drafted as a case.
2. **#1973 (BUG-1116):** Codex only, K4_02. Window-only; not drafted as a case.
3. **None skipped for having a case or a draft already.** The search (steps above) found none for any of the six.

---

## 5. What was read, built, tested and NOT proven

1. **Read:** the files listed in section 1 item 1, the six PR bodies and diffs, and the two command source files on `origin/claude/rel-20261102a`. A scratch folder `C:\CE_WORK\scratch\cs04\` holds the PR diffs I saved for reading; it is not a case folder and can be deleted.
2. **Built:** nothing. **Tested:** nothing. No AutoCAD was opened, no robot was run, no case file was created, no settings file was read or written.
3. **NOT proven:** that any of the four cases validates or runs; every wording marked DERIVED; that the council row lands inside CDRULES' 80 printed rows (W1963, W1966); the pipe material the New Pipe window starts with (W1966); that the Frankston council leaves R14's own lines unchanged (W1968); that a twin goes red on the old behaviour (that is what its first run is for). No fix here is Tim-accepted or Codex-accepted, and council values stay Tim's call.
