# Weak checks still unrepaired in robot case sets 01 to 04 (drafted Mon 2 Nov 2026, Melbourne; Sonnet, read-only)

Output path note: the order said `C:\CE_PLANreas\...`. That folder does not exist, so I read it as `C:\CE_PLAN\areas\` (the usual place) and wrote here.

---

## FOR TIM

1. **Answer: 7 robot cases still have a weak check and no repair file.** W1963, W1966, W1890, W1947, W1967, W1880 and W1949. Each has a replacement block below for CE 02 to paste in. Nothing is for you to decide or test.
2. **Worst two: W1963 and W1966.** They look for a warning sentence anywhere in the CDRULES output. The drawing already holds many other pipes, so the same sentence can be printed for an old pipe and the case would pass without the new pipe doing anything. The repair runs CDRULES once before the new pipe is drawn and demands the sentence is absent then.
3. **W1966 also "checks" the pipe size by looking for "225" in the New Pipe window.** 225 is the window's starting size, so that check passes without anyone typing it. The repair reads the pipe's own outline from the drawing instead.
4. **W1890 compares two CDRULEBOOK Show answers.** Two empty answers are equal, so it could pass with CDRULEBOOK doing nothing. The repair also requires CE's real "Nothing changed." line on both, and the old success tail to be absent.
5. **Which build can run each case (checked by searching the source, not by reading the installed program):** W1947, W1949 and W1890 are in Civil 3.0.89 (commit 61fd6fbc). W1880 and W1958 first appear in the next candidate (3.0.90, rel-20261108a). W1967 first appears in rel-20261110a. W1963, W1966, W1968 and W1971 are in none of the four lines (not found in any of them).
6. **Left alone, with the reason:** W1958, W1968 and W1971 (checks are sound, or can only be guards). The 32 problems in the look-brief re-check are Codex looks, not robot cases, so none are repaired here.
7. **Nothing was built, run or installed.** Every new line is a draft that needs the validator, one AutoCAD run in a free window (after 5:30 pm) and an Opus review before it counts. Section 8 lists what is NOT proven.

---

## 1. Fetch and build authority (done first, as ordered)

1. **`git fetch origin` run at the start.** Heads read: rel-20261102a = 3fbb9da5, rel-20261106a = 61fd6fbc (this is Civil 3.0.89, the installed authority), rel-20261108a = cf059dcf (b1, Civil 3.0.90), rel-20261110a = d4ce878e (b2). 61fd6fbc is an ancestor of both rel-20261108a and rel-20261110a (checked with `git merge-base --is-ancestor`).
2. **The PR-head ancestor test could not be run.** `gh` is not on this shell's path, so I could not get each PR's head commit. Instead I searched each fix's own switch name in the source of the four branches. That shows the fix is in the source of a line. It does not show it is installed: I did not read the installed DLL.
3. **Result of the switch-name search (source files containing the name):**
   - **typedLevelRoundingNote (W1947):** not in 3fbb9da5; in rel-20261106a (3.0.89), 108a and 110a.
   - **pitDropWarnsOutletTopAboveInletTop (W1949) and saveSkippedSaysNotSaved (W1890):** not in 3fbb9da5; in 3.0.89, 108a and 110a.
   - **inspectorReadsSavedRecordWhenNotLoaded (W1880) and inspectorUnreadableRecordLoggedOnce (W1958):** not in 3.0.89; in 108a and 110a.
   - **gradeWarningFiguresNeverMatch (W1967):** only in 110a.
   - **councilMinGradeBySize (W1963), councilSpeedBands (W1966), councilHabitableFloorFreeboard (W1968), councilTankOrificeMinimum (W1971):** in none of the four lines (also searched with no file-type limit on 110a).
4. **What this means for the drafts:** the SET01 and SET02 headers say "cannot run until a build holding the PR is installed". That is now true only for W1967 (needs 110a or later) and the four council cases (not in any line). W1947, W1949 and W1890 can run on the installed 3.0.89 once validated.
5. **Wording facts I confirmed in the 3.0.89 source** (read with `git show 61fd6fbc:...`, not run):
   - **W1949:** the new row is built in `PitObvertRule.cs` as "outlet pipe top is N mm above the inlet pipe top (X against Y): the pipe gets bigger, so the outlet invert needs to be lower", and `RulebookEngine.cs` raises it as a Warn under the rule title "Pit invert drop".
   - **W1890:** the new line is `Not saved: the CE data in this drawing could not be read, so CE has left it exactly as it is and has not saved this. The pit invert drop is still <x>. Nothing was changed.` The old success line was `[CE] Pit invert drop set to <x>. Run CDRULES to re-check.` CDRULEBOOK Show ends with `[CE] Nothing changed.`
   - **W1967 (read on 110a):** the rule's own test pins 200.4 against 200.0 as "200.4" and "200.0", and the old text as "200" and "200". That matches the draft.

---

## 2. W1963 (Maroondah DN150 at 1 in 80, PR #1963): wrong-object check. REPAIR

**Weak lines (SET04, case W1963):**

1. **`history has "is flatter than the council minimum 1:80"` and `history has "office ladder 1:100"`.** `history` reads the whole log from the start of the case. DRV1_B1 holds many other pipes. Any one of them that is a 150 mm drain flatter than 1 in 80 prints the same sentence under Maroondah. The case would then pass with the new pipe's row missing. The twin cannot show this, because with the switch off no pipe prints it.
2. **`control-text $np1 has "150"`.** It passes if "150" appears anywhere in the New Pipe window dump. It does not read the Diameter box and says nothing about the pipe in the drawing.

**Repair:** a baseline CDRULES run before the pipe, sentence checks read from that run's own text (`contains $rules`, not `history`), the Diameter box read by name, and the pipe's own outline read from the drawing. If the baseline already holds the sentence, the case now FAILS with a named reason. That is the honest outcome: it cannot tell the new pipe's row from an old one, and the answer then goes to Codex.

**Replacement block (replace everything from `STEPS` to the end of the file; keep the header lines as they are, and change the EXPECTED line as shown below):**

```
STEPS
  copy-info -> $copy0
  type "CDRULEBOOK{NL}Council{NL}maroondah" -Force -> $set_c
  wait
  type "CDRULES{NL}All" -Force -> $rules0
  wait
  esc-prompt -> $rules0_e
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
  field $pipes note -> $pnote
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
  not-contains $rules0 "more in the saved list"
  not-contains $rules0 "is flatter than the council minimum 1:80"
  not-contains $rules0 "office ladder 1:100"
  count $pipes = 1
  control $np1 "C2.Diameter" value "150"
  matches $pnote "150000(\.0+)?, -90075(\.0+)?, 170000(\.0+)?, -89925(\.0+)?"
  contains $rules "[CE] CDRULES:"
  contains $rules "council Maroondah"
  contains $rules "is flatter than the council minimum 1:80"
  contains $rules "office ladder 1:100"
  equals $c_after_rules $c_before_rules
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  copy-unchanged $copy0
  record $set_c "FULL what CDRULEBOOK Council maroondah printed"
  record $rules0 "FULL baseline CDRULES All BEFORE the new pipe (the sentence must not be here)"
  record $rules "FULL what CDRULES All printed after the new pipe (look for the R-03 row)"
  record $pnote "FULL pipe box (min x, min y, max x, max y) of the new pipe"
  record $rec_after "FULL the project record after CDRULES (does it keep the findings?)"
```

**EXPECTED line, replace with:** `CDRULEBOOK Council maroondah is accepted. A first CDRULES All, before any new pipe, does NOT contain 'is flatter than the council minimum 1:80'. One DN150 pipe, 20 m long, inverts 18.000 and 17.800, is drawn: the drawing holds one new CE pipe whose outline is 150000 to 170000 along and 150 mm wide (y -90075 to -89925). A second CDRULES All prints its summary naming council Maroondah and a row saying 'actual 1:100 is flatter than the council minimum 1:80' with 'office ladder 1:100'. The object count does not change during CDRULES; no CE window is left open.`

**Twin (`W1963_BROKEN_min_grade_switch_off.case.txt`):** keep its header with `SETTING CD_Settings.json checks.councilMinGradeBySize false`, and use the same `STEPS` and `ASSERT` block as above (drop only the `v3 record-set` step and the two `record $rec_after` / `$rules0` lines if you want it shorter). It must FAIL on `contains $rules "is flatter than the council minimum 1:80"` and `contains $rules "office ladder 1:100"` only. The baseline checks, the pipe-box check and the Diameter check must PASS in the twin: that shows the case reads the new pipe's own row.

**DERIVED marks:**

1. **DERIVED:** the pipe-outline numbers (-90075 and -89925: a 150 mm pipe centred on y = -90000). The same method was used for a 225 pipe in the R02bv87 repair (-80112.5 and -79887.5, five runs). A 150 pipe has not been read this way. If the first run shows a different box, change only the numbers and keep the check.
2. **DERIVED:** `field $pipes note` returns the pipe box (min x, min y, max x, max y). Taken from the R02bv87 repair, not from the README verb list.
3. **DERIVED:** "more in the saved list" is the phrase CDRULES prints when it cuts the list (quoted in the SET04 notes). If the baseline is cut (likely on this fixture, which has hundreds of rows) the case fails on the first line: the honest result is "cannot tell", and it goes to the Codex look or to reading the saved list.
4. **NOT proven:** that the PR's own row lands inside the 80 printed rows, and that DRV1_B1 holds no flat DN150 pipe. The baseline step is what finds out.

---

## 3. W1966 (Banyule minimum speed 1.0 m/s, PR #1966): wrong-object check and a check that passes by default. REPAIR

**Weak lines (SET04, case W1966):**

1. **`history has "is below the Banyule minimum 1.0 m/s"`.** Same fault as W1963, and likelier: many fixture pipes run below 1.0 m/s, so Banyule rows may already be printed for old pipes.
2. **`control-text $np1 has "225"`.** 225 is the New Pipe window's starting size on this PC (SET02 W1949 note: "225 on this PC per R18"). So the check passes even if the case's own typing of the size did nothing, and it never looks at the drawing.
3. **`history has "Stormwater Drainage Requirements"`.** The document name may be printed in the council summary as provenance whatever the pipe does. It cannot prove the new pipe's row, so the repair keeps it labelled as provenance only.

**Replacement block (replace everything from `STEPS` to the end of the file):**

```
STEPS
  copy-info -> $copy0
  type "CDRULEBOOK{NL}Council{NL}banyule" -Force -> $set_c
  wait
  type "CDRULES{NL}All" -Force -> $rules0
  wait
  esc-prompt -> $rules0_e
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
  field $pipes note -> $pnote
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
  not-contains $rules0 "more in the saved list"
  not-contains $rules0 "is below the Banyule minimum 1.0 m/s"
  count $pipes = 1
  control $np1 "C2.Diameter" value "225"
  matches $pnote "150000(\.0+)?, -90112\.5, 170000(\.0+)?, -89887\.5"
  contains $rules "[CE] CDRULES:"
  contains $rules "council Banyule"
  contains $rules "is below the Banyule minimum 1.0 m/s"
  contains $rules "Stormwater Drainage Requirements"
  equals $c_after_rules $c_before_rules
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  copy-unchanged $copy0
  record $rules0 "FULL baseline CDRULES All BEFORE the new pipe (the Banyule speed sentence must not be here)"
  record $rules "FULL what CDRULES All printed after the new pipe (look for the R-02 row, its speed number and any '... N more in the saved list')"
  record $pnote "FULL pipe box (min x, min y, max x, max y) of the new pipe: the real size in the drawing"
  record $rec_after "FULL the project record after CDRULES"
```

**EXPECTED line, replace with:** `After CDRULEBOOK Council banyule, a first CDRULES All (before any new pipe) does NOT contain 'is below the Banyule minimum 1.0 m/s'. One DN225 pipe at 1 in 200 over 20 m is drawn: the drawing holds one new CE pipe whose outline is 225 mm wide (y -90112.5 to -89887.5). A second CDRULES All prints its summary naming council Banyule and an R-02 row saying the full-bore speed is below the Banyule minimum 1.0 m/s, and names 'Stormwater Drainage Requirements' (provenance only: it may also appear for other rows). The object count does not change during CDRULES; no CE window is left open.`

**Twin (`W1966_BROKEN_speed_bands_switch_off.case.txt`):** keep its header (`SETTING CD_Settings.json checks.councilSpeedBands false`), use the same `STEPS` and `ASSERT`. It must FAIL on `contains $rules "is below the Banyule minimum 1.0 m/s"` only. Its baseline checks, pipe box and Diameter checks must PASS. The `Stormwater Drainage Requirements` check may pass in the twin: if it does, that proves it is provenance only (as labelled).

**DERIVED marks and limits:**

1. **DERIVED:** pipe outline y -90112.5 and -89887.5 (225 pipe centred on -90000), from the five R02bv87 runs.
2. **Still NOT proven:** the R-02 row lands inside the 80 printed rows; the exact speed printed (0.8 m/s depends on the starting material, not read); that the baseline is not cut off (first assert fails if it is).
3. **If the baseline already holds the Banyule sentence** (assert 2 fails): the case cannot tell the new row from an old one. Do not weaken the assert. Use the count form instead: record how many times the sentence occurs in `$rules0` (N), then assert `matches $rules "(?s)(is below the Banyule minimum 1\.0 m/s.*){N+1}"`. That is a new draft needing its own review, so I did not pre-write it.

---

## 4. W1890 (CDRULEBOOK says "Not saved", PR #1890): empty-equals check. REPAIR

**Weak lines (SET02, case W1890):**

1. **`equals $show_after $show_before`.** If both Show answers are empty or both are the same error line, they are equal. The check then passes with CDRULEBOOK Show doing nothing, and it is meant to prove "the drop was not changed to 50".
2. **Only one old-behaviour check.** `history absent "Pit invert drop set to"` is the only proof the old success line is gone. The old line has a second, fixed tail ("Run CDRULES to re-check", confirmed in the 3.0.89 source).

**Replacement block (replace everything from `STEPS` to the end of the file; the twin takes the same STEPS and the same ASSERT as shown here):**

```
STEPS
  type "CDRULEBOOK{NL}Show" -Force -> $show_before
  wait
  esc-prompt -> $show_before_e
  wait
  type "_.LINE{NL}190000,-95000{NL}191000,-95000{NL}" -Force -> $line_a
  wait
  type "U" -Force -> $u_a
  wait
  sleep 3
  type "CDRULEBOOK{NL}50" -Force -> $rb50
  wait
  sleep 2
  esc-prompt -> $rb50_e
  wait
  type "CDRULEBOOK{NL}Show" -Force -> $show_after
  wait
  esc-prompt -> $show_after_e
  wait
  v3 record-set nod -Part CE_CVL_SUITE_PROJECT/PROJECT_DATA -To READ -> $rec_after
  wait
  getvar CMDACTIVE -> $ca
  log-read civil -> $civlog
ASSERT
  contains $dmg_pitlist_after "DMGBROKEN2A4"
  log civil has "[ProjectData] The CE record in this drawing exists but could not be read"
  contains $show_before "[CE] Nothing changed."
  contains $show_after "[CE] Nothing changed."
  equals $show_after $show_before
  contains $rec_after "DMGBROKEN2A4"
  history has "Not saved: the CE data in this drawing could not be read, so CE has left it exactly as it is and has not saved this."
  history has "The pit invert drop is still "
  history has "Nothing was changed."
  history absent "Pit invert drop set to"
  history absent "Run CDRULES to re-check"
  equals $ca 0
  record $show_before "FULL CDRULEBOOK Show before (the current drop, council and cover)"
  record $rb50 "FULL what CDRULEBOOK 50 printed (the BUG-971 line then the new line)"
  record $show_after "FULL CDRULEBOOK Show after"
  record $u_a "FULL what U showed"
  record $civlog "FULL civil log lines since the case began"
```

**Twin (`W1890_BROKEN_not_saved_switch_off.case.txt`):** header unchanged (`linking.saveSkippedSaysNotSaved false`, `keepUnreadableDrawingRecord true`), same STEPS, and the same ASSERT as above. It must FAIL on three lines: `history has "Not saved: ..."`, `history absent "Pit invert drop set to"` and `history absent "Run CDRULES to re-check"`. It must PASS on the damage word, the Civil-log guard, both `Nothing changed.` lines, the Show comparison and the record read-back. That shows the case watches the wording and not the data.

**DERIVED marks:**

1. **Read in the 3.0.89 source, not run:** `[CE] Nothing changed.` is the last line of CDRULEBOOK Show (`RulebookCommand.cs`, Show branch). `Run CDRULES to re-check.` ends the old success line.
2. **Not proven:** that the route (one LINE, then U) really makes CE hold the record as unreadable. The Civil-log guard line is the proof; if it fails, the route changes, not the checks.
3. **Still PART:** CDCHECKIGNORE and the other CDRULEBOOK saves are not covered (Codex look K_1890 stays).
4. **Header fix:** this case can run on 3.0.89 (the switch is in that source). The header does not need "build pending".

---

## 5. W1947 (typed level held to 10 mm, PR #1947): wrong-end check, one half with no twin. REPAIR

**Weak lines (SET01, case W1947):**

1. **`matches $ilt1 "IL 10\.130?(?!\d)"`.** `$ilt1` holds both IL texts of the pipe. The check passes if EITHER end reads 10.13. The case claims the typed end is held at 10.13 and the other end follows at exactly 1 in 100 (10.03). The 10.03 end is only recorded. A build that held both ends at 10.13 would pass.
2. **"A level typed 10.13 prints nothing" has no twin.** The one `history count "Typed level 10." = 1` carries that half, and nothing shows it can go red.

**Replacement block (replace everything from `STEPS` to the end of the file):**

```
STEPS
  copy-info -> $copy0
  getvar OSMODE -> $osm0
  v3 setvar OSMODE 0 -> $osm_set
  ms-count -> $c0
  type "CD{NL}150000,-90000{NL}160000,-90000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd1
  ui2-set "New Pipe" "C2.Diameter" "100"
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "100"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "on"
  ui2-set "New Pipe" "C2.IsAutoCalcUpToDown" "on"
  ui2-set "New Pipe" "C2.KnownInvert" "10.125"
  sleep 2
  ui-dump "^New Pipe" -TimeoutSec 60 -> $np1
  ui-press "New Pipe" "New pipe, Start Pipe" -> $start1
  await-window-gone "^New Pipe" -Secs 120
  sleep 4
  windows-snapshot -> $w1
  esc-prompt -> $esc1
  wait
  ms-new $c0 -> $new1
  select $new1 "object~^CeCvlPipeObject$" -> $pipe1
  select $new1 "text~^IL " -> $ils1
  field $ils1 text -All -> $ilt1
  ms-count -> $c1
  type "CD{NL}150000,-92000{NL}160000,-92000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd2
  ui2-set "New Pipe" "C2.Diameter" "100"
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "100"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "on"
  ui2-set "New Pipe" "C2.IsAutoCalcUpToDown" "on"
  ui2-set "New Pipe" "C2.KnownInvert" "10.13"
  sleep 2
  ui-press "New Pipe" "New pipe, Start Pipe" -> $start2
  await-window-gone "^New Pipe" -Secs 120
  sleep 4
  windows-snapshot -> $w2
  esc-prompt -> $esc2
  wait
  ms-new $c1 -> $new2
  select $new2 "object~^CeCvlPipeObject$" -> $pipe2
  select $new2 "text~^IL " -> $ils2
  field $ils2 text -All -> $ilt2
  log-read civil -> $civlog
  type "CD{NL}150000,-94000{NL}170000,-94000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cdR
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.Diameter" "225"
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $startR
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $escR
  wait
ASSERT
  not-contains $w1 "Grade mismatch"
  not-contains $w2 "Grade mismatch"
  count $pipe1 = 1
  count $pipe2 = 1
  history has "Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm)"
  history count "Typed level 10." = 1
  matches $ilt1 "IL 10\.130?(?!\d)"
  matches $ilt1 "IL 10\.030?(?!\d)"
  matches $ilt2 "IL 10\.130?(?!\d)"
  matches $ilt2 "IL 10\.030?(?!\d)"
  copy-unchanged $copy0
  record $np1 "FULL New Pipe window before Start Pipe (known level, grade, length)"
  record $cd1 "FULL CD, first pipe"
  record $ilt1 "the IL texts of the first pipe (should read 10.13 and 10.03)"
  record $ilt2 "the IL texts of the second pipe (should read 10.13 and 10.03)"
  record $civlog "FULL new Civil CE log lines"
  record $cdR "FULL CD reset pipe (puts the remembered New Pipe values back)"
```

The only differences from the draft are the two new `matches ... 10\.03` lines. The `...10.03` end for the second pipe is the same arithmetic (10 m at 1 in 100 is 100 mm).

**Twin W1947_BROKEN (switch off):** unchanged in steps. Add the same `matches $ilt1 "IL 10\.030?(?!\d)"` line to its ASSERT, after the `matches ... 10.13` line. Result: it still fails only on `history has "Typed level 10.125 ..."`, and now also shows the 10.03 end reads right with the switch off (rounding and grade unchanged, as the PR says).

**New twin D (for the "10.13 prints nothing" half):** new file `W1947_TWIN_D_second_pipe_also_rounded.case.txt`.

1. **Copy the repaired W1947 whole** (STEPS and ASSERT above) and change only the header and one line.
2. **Header:** `CASE W1947_TWIN_D`, `TITLE BROKEN VARIANT of W1947: the second pipe is typed 10.125 as well, so a second note prints and the exactly-one check must FAIL`, `ORDER 704`, `EXPECT-FAIL BROKEN-VARIANT`, `VARIANT_OF W1947`, `SETTING CD_Settings.json pipe.typedLevelRoundingNote true`, `EXPECTED Wrong on purpose: both pipes round a typed 10.125, so the note prints twice and 'history count "Typed level 10." = 1' fails. Everything else passes.`
3. **The one changed line:** in the second pipe's block, change `ui2-set "New Pipe" "C2.KnownInvert" "10.13"` to `ui2-set "New Pipe" "C2.KnownInvert" "10.125"`.
4. **Expected result:** FAIL on `history count "Typed level 10." = 1` only (the count reads 2). If it PASSES, the count check cannot see a second note and the "prints nothing for 10.13" half is not proven.

**DERIVED marks:** the 10.03 end is the PR's own worked example (10.125 rounds to 10.13, 1 in 100 over 10 m gives 10.03), not seen on a run. If the first run shows only one IL text per pipe (pipe text is off), replace the two `10\.03` lines with whatever the run printed and say so; do not delete them. The ILs are read from the first case run's `$ilt1`.

---

## 6. W1967 (grade warning figures, PR #1967): checks with no red twin, window claim not asserted. REPAIR

**Weak lines (SET01, case W1967):**

1. **`history absent "Grade 1:200 is shallower"`.** It is the check that the OLD sentence is gone. The twin does not carry it, so nothing shows it can go red.
2. **`history count "is shallower than minimum" = 1`.** It carries the "exactly 1 in 200 gives no warning" control. No twin shows it can see a second warning.
3. **EXPECTED claims "The 'Design Warnings' window opens and is closed".** The ASSERT never checks it. The window is only dumped and recorded.

**Replacement block, main case:** replace the ASSERT block only (STEPS stay as drafted; no step changes):

```
ASSERT
  not-contains $w1 "Grade mismatch"
  count $pipe1 = 1
  count $pipe2 = 1
  history has "Grade 1:200.4 is shallower than minimum 1:200.0"
  history absent "Grade 1:200 is shallower"
  history count "is shallower than minimum" = 1
  contains $w1 "Design Warnings"
  copy-unchanged $copy0
  record $np1 "FULL New Pipe window before Start Pipe (length and grade as CE shows them)"
  record $dw1 "FULL the Design Warnings window as text (every warning CD listed)"
  record $w1 "FULL windows open after Start Pipe"
  record $cd1 "FULL CD, first pipe"
  record $civlog "FULL new Civil CE log lines"
  record $cdR "FULL CD reset pipe (puts the remembered New Pipe values back)"
```

**Replacement block, twin `W1967_BROKEN` (switch off):** replace its ASSERT with:

```
ASSERT
  not-contains $w1 "Grade mismatch"
  count $pipe1 = 1
  history has "is shallower than minimum"
  history has "Grade 1:200.4 is shallower than minimum 1:200.0"
  history absent "Grade 1:200 is shallower"
  contains $w1 "Design Warnings"
  record $dw1 "FULL the Design Warnings window, switch OFF"
```

It must FAIL on `history has "Grade 1:200.4 ..."` AND on `history absent "Grade 1:200 is shallower"` (the old sentence is printed). The `contains $w1 "Design Warnings"` line must PASS in the twin: the window still opens with the old words, so that check proves the window is there and nothing more.

**New twin B (for the "exact minimum prints nothing" control):** new file `W1967_TWIN_B_second_pipe_also_flat.case.txt`.

1. **Copy the main W1967 whole** (STEPS plus the ASSERT above) and change only the header and one line.
2. **Header:** `CASE W1967_TWIN_B`, `TITLE BROKEN VARIANT of W1967: the second pipe is also 10.02 m long (1 in 200.4), so a second warning prints and the exactly-one check must FAIL`, `ORDER 705`, `EXPECT-FAIL BROKEN-VARIANT`, `VARIANT_OF W1967`, `SETTING CD_Settings.json pipe.gradeWarningFiguresNeverMatch true`.
3. **The one changed line:** in the second pipe's `type` line, change `160000,-92000` to `160020,-92000`.
4. **Expected result:** FAIL on `history count "is shallower than minimum" = 1` only (the count reads 2). All other checks pass. If it PASSES, the control cannot see a second warning.

**DERIVED marks:**

1. **DERIVED:** the window title "Design Warnings" (from the SET01 header's own note, read from `PipeValidationWarningDialog`). If the first run shows another title, change the word, not the check. `windows-snapshot` lists open windows; I did not confirm it lists this one by that title.
2. **Fixed fact:** the 200.4 against 200.0 figures match the rule's own test cases on rel-20261110a (checked, not run).
3. **Build:** the fix is only in rel-20261110a (b2) or later. The case cannot run on 3.0.89 or 3.0.90.

---

## 7. W1880 (Inspector reads the saved list, PR #1880): the line may not come from the pick. ADD A CONTROL

**Weak point (SET03, case W1880):** the check `log civil has "[Inspector] The pit and pipe list saved ... could not be read ..."` passes if the line was written for any reason between the start of the case and the end. The pick is meant to be the cause. Nothing shows the line is absent when nothing is picked. If the line also comes from the drawing opening, the case passes whatever the pick or the switch does, and the switch-off twin is then the only thing that can tell: it would PASS too and the runner would report "now passes: candidate". A control makes that visible before the twin is run.

**New control (must PASS; it is not an EXPECT-FAIL twin):** new file `W1880_CONTROL_no_pick.case.txt`.

```
# W1880 CONTROL (drafted by Sonnet 2 Nov 2026 for CE 02; NOT RUN). Same setup and switch as W1880 but NO pick. The Inspector must write no 'could not be read' line. If this control FAILS (the line is there with no pick), W1880 proves nothing about the pick: send #1880 to Codex.
CASE W1880_CONTROL
TITLE CONTROL for W1880: with the saved list damaged and nothing picked, the Inspector writes no 'could not be read' line
PLAN_ITEM control for W1880 (PR #1880, BUG-1240): shows the log line comes from the pick
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-DMG-PITLIST
ORDER 724
TIMEOUT 900
BUG
VARIANT_OF W1880
SETTING CD_Settings.json linking.inspectorReadsSavedRecordWhenNotLoaded true
REVIEWED_AGAINST
EXPECTED With the saved list damaged and the switch ON, nothing picked and the same waiting time as W1880 (about 20 seconds), CE's Civil log holds no '[Inspector] The pit and pipe list saved in this drawing could not be read' line. The damage word DMGBROKEN2A4 still reads back.
WHY_NOT_UNIT_TEST It exists only to show W1880's log line needs the pick.
STEPS
  windows-snapshot -> $win0
  sleep 20
  log-read civil -> $civlog
ASSERT
  contains $dmg_pitlist_after "DMGBROKEN2A4"
  log civil absent "[Inspector] The pit and pipe list saved in this drawing could not be read; values show as Unknown."
  record $civlog "FULL civil log lines since the case began"
```

**W1880 main case and twin:** no text change. Add one line to the main case's `NOT_AUTOMATED` list: `The log line is only tied to the pick by the control case W1880_CONTROL. If that control fails, W1880 cannot be accepted.`

**DERIVED marks:** the 20 second wait copies the main case (6 + 4 + 4 + 6 = about 20 seconds of waiting). The first run decides whether the Inspector writes the line on its own timer; that is exactly what the control is for.

**Not proven even after this:** that `pick-first` makes the Inspector refresh at all (taken from UI_MAP_2026-10-03 item 64, as the SET03 header says). If the main case shows zero lines, the real-mouse fallback in its NOT_AUTOMATED note applies.

---

## 8. W1949 (outlet pipe top above inlet pipe top, PR #1949): one misleading EXPECTED line. WORDING REPAIR ONLY

**What is wrong (SET02, case W1949):** the EXPECTED line says CDRULES prints the row "in the pit-drop rule's wording, with no 'Pit invert drop' failure block". The 3.0.89 source (`RulebookEngine.cs`) raises the new row as a Warn under the rule title "Pit invert drop". So the new row is itself a Pit invert drop row, and the claim "no Pit invert drop failure block" cannot be asserted and could be read as the case checking something it does not.

**The checks themselves are strong:** `history has "outlet pipe top is 45 mm above the inlet pipe top (18.225 against 18.180)"` carries numbers that belong to this one pit, so an old pit's row cannot satisfy it. The shorter lines are covered by it. I found no weak ASSERT line here, so I am not rewriting the ASSERT.

**Replace the EXPECTED line with:** `With the 150 inlet placed (one new CE pipe object), CDRULES Problems prints its summary line and a Warn row under the 'Pit invert drop' rule containing 'outlet pipe top is 45 mm above the inlet pipe top (18.225 against 18.180)'. The 30 mm invert drop at that pit passes; that is NOT asserted. The reset pipe (diameter 225) is then placed.`

**Header fix:** the switch is in 3.0.89, so this case can run on the installed build. Remove any "build pending" wording.

**One limit I could not remove:** `not-contains $win_rules "Creative Engineering"` is a title match. It passes when any window is open that does not carry that title. It is a guard, not proof that no window is open. Same pattern as the accepted cases, so I left it.

---

## 9. Checked and left alone (no repair needed)

1. **W1958 (log line once, PR #1958).** `log civil count ... = 1` plus `log civil has ...` is a sound pair. If the picks never refresh the Inspector, the main case fails on the zero count, and the twin (count = 1) would PASS and be reported as "now passes: candidate". Both outcomes are visible. One note for CE 02: if the twin shows exactly one line, treat W1958 as void and send #1958 to Codex.
2. **W1968 (Frankston habitable floor line, PR #1968).** The four new-line checks read one CDTWL run, and `history count ... = 1` guards a double print. Nothing to repair. It is built in none of the four lines, so it cannot run yet.
3. **W1971 (R-22 tank orifice list, PR #1971).** The three `contains` checks read each Values answer on its own, which is the right shape. Two lines are guards only, and cannot go red on their own: `copy-unchanged $copy0` (the runner never saves, so it is always unchanged) and `not-contains $win_end "Creative Engineering"` (a title match). The case never claims more than the list. Built in none of the four lines.
4. **SET01 K_1887, K_1969, K_1970, K_1927, SET02 K_1882, K_1897_1920, K_1962, K_1889, SET03 Look A to C, SET04 K4_01, K4_02.** These are Codex looks, not robot cases. Not touched.
5. **The 32 problems in `CARPARK_RECHECK_LOOKBRIEFS_02NOV.md`.** They are about Codex looks (HUBC, C78S, B1, B3, EDTC, W234, LB, EX1 and wave-1 summaries), not robot cases. The desk owns them. Not touched.
6. **Cases already repaired by their own file:** N06v87, N17, N41v87, N61 and R02bv87. None of them is in sets 01 to 04, so there was nothing to skip; they are not repeated.

---

## 10. Said plainly: read, built, tested, NOT proven

1. **Read:** `C:\TimOS\RULES.md`; `CARPARK_RECHECK_LOOKBRIEFS_02NOV.md` (all); `ROBOT_WEAKCHECK_REPAIR_N06v87_02NOV.md` (all) and the first 14 lines of N17, N41v87, N61 and R02bv87, plus the R02bv87 case lines that read the pipe box; `ROBOT_CASE_DRAFTS_SET01` to `SET04` (all); the README_CASES.md verb line; the 3.0.89 (61fd6fbc) source of `RulebookCommand.cs`, `SaveSkippedWordsRule.cs`, `RulebookEngine.cs` (pit drop section), `PitObvertRule.cs` and the call sites of the rounding-note rule; the rel-20261110a test file for the grade-figures rule and the Inspector warning line.
2. **Built:** nothing. **Tested:** nothing. **Installed:** nothing. No AutoCAD opened, no robot run, no validator run, no settings file read or written, no agent spawned. Only this file was written. Git use was read-only (`fetch`, `rev-parse`, `merge-base`, `show`, `grep`).
3. **NOT proven:**
   - That any replacement block validates or runs. Every new line is an unvalidated draft.
   - That `field $pipes note` returns the pipe box the way the R02bv87 repair says, and that a 150 mm pipe's box is -90075 to -89925 (W1963).
   - That `control $np1 "C2.Diameter" value "..."` reads the box as written (the README lists the verb; no accepted case I read uses it for this box).
   - That the baseline CDRULES run in W1963 and W1966 is not cut at 80 rows. On this fixture it likely is: the first assert will then fail by design.
   - That "Nothing changed." and "Run CDRULES to re-check" print exactly as the 3.0.89 source reads. Source read only.
   - That the PR heads sit where the switch search suggests. The ancestor test per PR could not be run (no `gh` on this shell).
   - That W1880, W1958 and the four council cases can run on any installed build today: the first two are not in 3.0.89, the council four are in no line.
4. **Process still needed for every block above:** the case validator (`case_runner.ps1 validate`), then one AutoCAD run of the case and its twins in a free window (after 5:30 pm), then an independent Opus review that writes a fresh `reviewed_against` line, because every changed case has a new text.
5. **None of this is Tim-accepted or Codex-accepted.** Council figures (W1963, W1966, W1968, W1971) and the grade-warning figures stay Tim's call.
