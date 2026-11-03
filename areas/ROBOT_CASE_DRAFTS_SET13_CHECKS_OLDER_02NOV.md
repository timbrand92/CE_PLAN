# Robot case drafts, set 13: CDRULES checks from older trains (Mon 2 Nov 2026, read-only drafter, Sonnet)

**What this is.** Case drafts for six older fix PRs (#1771, #1841, #1848, #1850, #1851, #1856). Nothing was run, built, installed or opened in AutoCAD. No case file was created anywhere. This is the only file written. No git write was run (only `git fetch`, `git show`, `git log`, `git merge-base`, `gh pr view`, `gh pr diff`, all read-only).

---

## FOR TIM

1. **Done.** Three robot tests written on paper, each with a deliberately wrong twin that must fail (6 case texts): W1771, W1841, W1848. Orders 820 to 825.
2. **Example.** Test W1841 types CDRULES Values on a Darebin job and a Kingston job and checks the list says the flattest fall for a 300 pipe is now 1 in 100 (it was 1 in 250), that Darebin lets detention pipes be 1 in 200, and that Kingston does not.
3. **Codex only (no robot test possible):** #1856 (CDCALC Boyd's tab is a window the robot may not read), #1850 (needs a surface picked in the New Pit window, and its row falls past the 80-row limit), #1851 (R-34 rows print last, past the 80-row limit). Numbered Codex looks K13_01 to K13_03 are below.
4. **Needs an Opus review before it runs because of Undo, REDO, a locked layer or an Xref:** none. No case here uses U, REDO, a locked layer or an Xref.
5. **A correction to the brief.** #1771 (BUG-1090) is NOT merged into any train. `gh` says OPEN, and its commit f3f38c24 sits only on the branch `fb/pc4-bug1090-hgl-not-checked`, not on rel-20261102a or any other release branch I checked. So W1771 cannot run until that PR is built into a train. The other five are merged into rel-20261102a (git log lines: #1848 96f82f9c, #1850 df0704aa, #1851 e24746c6, #1841 f495fcc5, #1856 98e46187).
6. **Every case is a PART claim** (said in each PLAN_ITEM line). W1848 has a real risk: CDRULES prints only the first 80 rows on the command line and the test drawing has many rows, so the cover row for the new pipe may fall past row 80. If the first run shows "... N more in the saved list" and no cover row, that is a tool limit, not a fix failure: use Codex look K13_04.
7. **What I could not verify.** Every printed line marked DERIVED comes from the PR text and the source on rel-20261102a, not from a run. I do not know the pipe material the New Pipe window starts with, so W1848 accepts either answer (wall 20 mm, or "wall Unknown"). I did not read Tim's real settings, so I do not know whether the robot's AutoCAD still holds the old ladder (the old ladder is moved to 1 in 100 only if it was exactly the shipped one).
8. **Skipped:** none because a case already existed. I re-checked: no case, no draft and no ledger entry for any of the six (details at the end).

---

## 1. How the drafts were written (read before validating)

1. **What I read:** `C:\TimOS\RULES.md`; `README_CASES.md` in full (refused-button list and `acad_driver_v3.allowlist.json` included); the finished example `ROBOT_CASE_DRAFTS_TOP12_30OCT.md`; sets 2 and 4 of today's drafts (for the typed council route and the switch-off twin); cases R14, R21, R22, R36, the setup SETUP-P8 and `variants\R09s_new_switch_off_broken.case.txt`; the six PR texts; `gh pr diff 1841`; `RulesCommand.cs`, `RulebookEngine.cs` and `PipeCoverToOutsideRule.cs` on `origin/claude/rel-20261102a` (3fbb9da5), read with `git show`.
2. **Built: nothing. Tested: nothing.** No AutoCAD, no robot, no git write.
3. **The key finding that shaped the set.** `CDRULES Values` prints every value with no row limit, so the ladder (#1841) can be proved from it. `CDRULES Problems` and `All` print only the first 80 rows, but the closing "not evaluated here" list (#1771) is printed after those rows with no limit, so that line is safe too.
4. **Council route.** Typed, as set 4 reads it from `RulebookCommand.cs`: `CDRULEBOOK`, keyword `Council`, then the council id (`darebin`, `kingston`; ids checked in `council-profiles.json`). It writes into the open copy only; the runner never saves.
5. **Twins.** W1848_BROKEN sets the PR's own switch `cover.measuredToPipeOutside` to `false` before AutoCAD starts (settings are read at launch), through the `SETTING` guard; no real settings file is read or written by hand. #1771 and #1841 have no switch (the PR texts say so), so their twins expect the old behaviour and must FAIL on the fixed build. A twin that PASSES means the case cannot tell old from new, and the fix goes to Codex.
6. **REVIEWED_AGAINST is empty** in every draft. No review file written. Fixture DRV1_B1, `SLOT fresh`. Every `type` chain is a complete command, with no `(` and no SAVE-type word.
7. **Empty ground used.** W1848 places one pit and one pipe from 150000,-80000 to 170000,-80000, the same empty ground SETUP-P8 uses. If a first run shows an object there, move y by the same amount in both W1848 texts.
8. **Validate first, without AutoCAD:** copy each block to its file name in a new folder (suggested `cases\drafts_set13_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`.
9. **Run alone, outside Tim's hours.** W1848 places things: give it its own call.

---

## 2. The case texts

### Case 1 of 3: W1771, CDRULES ends with the hydraulic grade line "not evaluated" line (#1771, BUG-1090; orders 820 and 821)

**Intended file:** `W1771_cdrules_hgl_not_evaluated_line.case.txt`

```
# BUILD PENDING: cannot run until PR #1771 (BUG-1090, commit f3f38c24) is merged into a train and installed. It is on no release branch today (2 Nov 2026).
# W1771 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1771 (BUG-1090), no switch (a true sentence added to a printed list).
# Route: CDRULES with its default answer. The 'not evaluated here' list is printed AFTER the capped finding rows (RulesCommand.cs, loop over RulebookEngine.NotEvaluatedHere), so the 80-row limit does not hide it.
# DERIVED, never seen on a run: the line text. The PR says the list ends with 'an "HGL Hydraulic grade line and pit losses" line'; the printed form follows the existing pattern '    <id> <title>: not evaluated here (needs <what>).'. Only the part up to 'not evaluated here' is asserted.
# Remembered values: NO (nothing is placed).
CASE W1771
TITLE CDRULES lists the hydraulic grade line and pit losses among the checks it does not make, and changes nothing
PLAN_ITEM PR #1771 (BUG-1090) PART: the CDRULES command-line line only. NOT whole: the line on the CDCALC computations sheet (BASIS OF DESIGN block) is not read here (K13 look below), and the PR's own open half (warn where the council asks for a hydraulic grade line) is not built
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 820
TIMEOUT 600
BUG BUG-1090
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CDRULES (Problems, the default) prints, after the finding rows, a line starting 'HGL Hydraulic grade line and pit losses: not evaluated here'; the earlier 'not evaluated here' lines are still printed; 'Full list saved' is printed; the number of objects in the drawing and the file on disk do not change; no CE window is left open.
WHY_NOT_UNIT_TEST The list is printed on the live command line by the installed command, from the drawing's own rule run.
NOT_AUTOMATED The same sentence on the CDCALC computations sheet ("Hydraulic grade line and pit losses: not calculated by CE...") is not read: the sheet is a drawing output made from a window.
NOT_AUTOMATED The warning for a council that asks for a hydraulic grade line (Frankston, Banyule, Whitehorse) is not built in the PR (needs council data, R-00).
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDRULES{NL}Problems" -Force -TimeoutSec 180 -> $r
  wait
  history-tail -Index 40 -> $tail
  ms-count -> $c1
  windows-snapshot -> $win_end
  getvar CMDACTIVE -> $ca
ASSERT
  history has "HGL Hydraulic grade line and pit losses: not evaluated here"
  history has "not evaluated here (needs"
  history has "Full list saved"
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  equals $c1 $c0
  copy-unchanged $copy0
  record $tail "FULL the last 40 lines CDRULES printed (the HGL line should be near the end)"
```

**Twin:** `W1771_BROKEN_hgl_line_absent.case.txt`

```
# BUILD PENDING: cannot run until PR #1771 is merged into a train and installed.
# W1771_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Same route and same route checks as W1771, with ONE check reversed: it expects the HGL line to be ABSENT, as on a build without the fix. On the fixed build the line is printed, so the reversed check MUST FAIL and the route checks must still PASS. No switch exists for this fix, so this is the only way to show the case can go red.
CASE W1771_BROKEN
TITLE BROKEN VARIANT of W1771: expects NO hydraulic grade line line on a build that has it (must FAIL)
PLAN_ITEM red-before-green proof for W1771 (PR #1771, BUG-1090)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 821
TIMEOUT 600
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1771
REVIEWED_AGAINST
EXPECTED Wrong on purpose: 'history absent "HGL Hydraulic grade line"' fails on a build with the fix; Full list saved, the object count and the file stay as W1771.
WHY_NOT_UNIT_TEST It exists only to prove W1771's HGL check can go red.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDRULES{NL}Problems" -Force -TimeoutSec 180 -> $r
  wait
  history-tail -Index 40 -> $tail
  ms-count -> $c1
  windows-snapshot -> $win_end
  getvar CMDACTIVE -> $ca
ASSERT
  history absent "HGL Hydraulic grade line"
  history has "not evaluated here (needs"
  history has "Full list saved"
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  equals $c1 $c0
  copy-unchanged $copy0
  record $tail "FULL the last 40 lines CDRULES printed"
```

---

### Case 2 of 3: W1841, CDRULES Values shows the flattest fall 1 in 100 and the detention rows (#1841, B-042, GB-01 slice 1; orders 822 and 823)

**Intended file:** `W1841_cdrules_values_falls_1_in_100.case.txt`

```
# BUILD PENDING: cannot run until the Civil build with PR #1841 (merged at f495fcc5 on origin/claude/rel-20261102a, train C-77/C-78) is installed.
# W1841 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1841 (B-042 = B-019, GB-01 slice 1). No switch (Tim retired it, decision 26 point 4).
# Route: no drawing content needed. CDRULEBOOK Council darebin, then CDRULES Values; then kingston, then CDRULES Values. CDRULES Values prints every value with no row limit (RulesCommand.cs DescribeValues).
# Lines read from RulesCommand.cs on rel-20261102a (DERIVED, never seen on a run): 'R-03 minimum grade ladder: DN225 1:100, DN300 1:100, DN375 1:100 ...; drafting warning ...; no minimum fall set for gravity pipes of 450 mm and larger (not warned)'; Darebin 'R-32 detention pipe grade (Design Guidebook figure for this council): no flatter than <figure with 200> from <figure with 225>'; Kingston 'R-32 detention pipe grade: this council has no flatter detention figure, so detention pipes of <225> and larger are held to the ordinary 1 in 100 rule (R-03)'.
# Caution: the ladder is moved to 1 in 100 only if the settings file holds exactly the old shipped ladder (the PR's one-time move). A hand-edited ladder in the robot's AutoCAD profile would be left alone and this case would FAIL for that reason. Say so in the report; do not loosen the check.
# Remembered values: NO (nothing is placed).
CASE W1841
TITLE CDRULES Values: a 300 pipe's flattest fall is 1 in 100, pipes of 450 and over have their own blank row, Darebin allows detention pipes 1 in 200 and Kingston holds them to 1 in 100, and nothing is changed
PLAN_ITEM PR #1841 (B-042) PART: the values list for the ladder, the 450 and over blank row, and the detention row for two councils. NOT whole: the warnings themselves (Edit Pipe strip "flatter than 1:100", Civil Design, auto-design, CDRULES R-03 and R-32 rows on a real pipe) are not driven here, and the four councils Banyule, Manningham and Maroondah are not read
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 822
TIMEOUT 600
BUG BUG-1091
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After CDRULEBOOK Council darebin, CDRULES Values shows an R-03 ladder with DN225, DN300 and DN375 each at 1:100, says there is no minimum fall set for gravity pipes of 450 mm and larger, and shows an R-32 detention line with 1:200 from 225 mm; after kingston it shows the same ladder and an R-32 line saying Kingston has no flatter detention figure and holds detention pipes of 225 mm and larger to the ordinary 1 in 100 rule; each Values answer ends 'Nothing was changed.'; the object count and the file on disk do not change; no CE window is left open.
WHY_NOT_UNIT_TEST The ladder is read through the live settings load and the council set into the open drawing, so the moved ladder and the council row are only seen in a real AutoCAD start.
NOT_AUTOMATED The warnings on a real pipe (a 300 pipe at 1 in 200 says "flatter than 1 in 100"; a 450 detention pipe at 1 in 200 in Kingston warns) are not driven: no robot pipe has a known size, grade and council together on the command line within the first 80 CDRULES rows (see the cap note in section 1).
NOT_AUTOMATED The one-time move of a saved ladder (one CE log line, the "ladder confirmed" tick cleared) is not read; Tim's real settings file is never read.
NOT_AUTOMATED Banyule, Manningham and Maroondah (detention 1 in 200) are not typed here. The first run's recorded Darebin line shows the form for them.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDRULEBOOK{NL}Council{NL}darebin" -Force -> $set_d
  wait
  type "CDRULES{NL}Values" -Force -> $val_d
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
  contains $val_d "Council: Darebin"
  matches $val_d "R-03 minimum grade ladder: .*DN225 1:100"
  matches $val_d "R-03 minimum grade ladder: .*DN300 1:100"
  matches $val_d "R-03 minimum grade ladder: .*DN375 1:100"
  contains $val_d "no minimum fall set for gravity pipes of 450 mm and larger (not warned)"
  matches $val_d "R-32 detention pipe grade \(Design Guidebook figure for this council\): no flatter than .*200.* from .*225"
  contains $val_k "Council: Kingston"
  matches $val_k "R-03 minimum grade ladder: .*DN300 1:100"
  matches $val_k "R-32 detention pipe grade: this council has no flatter detention figure, so detention pipes of .*225.* and larger are held to the ordinary 1 in 100 rule \(R-03\)"
  history count "Nothing was changed." = 2
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  equals $c1 $c0
  copy-unchanged $copy0
  record $val_d "FULL the Darebin values list"
  record $val_k "FULL the Kingston values list"
```

**Twin:** `W1841_BROKEN_old_ladder_expected.case.txt`

```
# BUILD PENDING: cannot run until the Civil build with PR #1841 is installed.
# W1841_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Same route and route checks as W1841, with ONE group of checks reversed to the OLD figures: it expects the DN300 ladder step at 1:250 (the old shipped ladder) and no 'gravity pipes of 450 mm and larger' sentence. On the fixed build the ladder reads 1:100, so these checks MUST FAIL; the Council lines, 'Nothing was changed.', the object count and the file must still PASS. No switch exists for this fix.
CASE W1841_BROKEN
TITLE BROKEN VARIANT of W1841: expects the OLD ladder (DN300 at 1 in 250) on a build that moved it to 1 in 100 (must FAIL)
PLAN_ITEM red-before-green proof for W1841 (PR #1841, B-042)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 823
TIMEOUT 600
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1841
REVIEWED_AGAINST
EXPECTED Wrong on purpose: the DN300 1:250 check and the 'not contains' check on the 450 and over sentence both fail on the fixed build.
WHY_NOT_UNIT_TEST It exists only to prove W1841's ladder checks can go red.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDRULEBOOK{NL}Council{NL}darebin" -Force -> $set_d
  wait
  type "CDRULES{NL}Values" -Force -> $val_d
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
  contains $val_d "Council: Darebin"
  matches $val_d "R-03 minimum grade ladder: .*DN300 1:250"
  not-contains $val_d "no minimum fall set for gravity pipes of 450 mm and larger"
  contains $val_k "Council: Kingston"
  matches $val_k "R-03 minimum grade ladder: .*DN300 1:250"
  history count "Nothing was changed." = 2
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  equals $c1 $c0
  copy-unchanged $copy0
  record $val_d "FULL the Darebin values list"
```

---

### Case 3 of 3: W1848, CDRULES minimum cover is measured to the outside top of the pipe (#1848, B-012, BUG-901; orders 824 and 825)

**Intended file:** `W1848_cdrules_cover_to_pipe_outside.case.txt`

```
# BUILD PENDING: cannot run until the Civil build with PR #1848 (merged at 96f82f9c on origin/claude/rel-20261102a) is installed.
# W1848 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1848 (B-012, BUG-901), switch cover.measuredToPipeOutside, ON by default.
# Route (the SETUP-P8 route, with the pipe's own size and levels): PIT at 150000,-80000 with lid 19.000, three Esc; CD from 150000,-80000 to 170000,-80000 with first invert 18.600 and second invert 18.500, size 225; then CDRULES Problems.
# Arithmetic: lid 19.000 less invert 18.600 = 400 mm to the invert; less the 225 pipe = 175 mm to the inside top (the old measure, and the OFF twin). With the wall 20 mm (UPVC 225, the PR's shipped table) it reads 155 mm to the outside top. Both are below the office 300 mm, so the row is a Warn and shows in Problems.
# DERIVED, never seen on a run: 'cover 155 mm to the outside top at <pit> (pipe wall 20 mm, Settings UPVC 225, Assumed) is below 300 mm' (PR text and PipeCoverToOutsideRule.cs MeasuredTo / WallNote); if the New Pipe window starts with a material that is not UPVC, the row reads 'cover 175 mm to obvert at <pit> ... Pipe wall Unknown (...), so cover is measured to the inside top as before.' The check accepts either, because the switch is proved by one of those two being present and neither appearing with the switch OFF.
# Cap risk: CDRULES prints the first 80 rows only. If this run shows '... N more in the saved list' and no cover row for the new pit, the case is BLOCKED in effect (tool limit): use the Codex look K13_04, do not loosen the check.
# Pre-existing rows of the fixture could print the same words for other pipes; the exact numbers 155 and 175 are used to keep the check on this pipe, but a first run must confirm the row is the new pit's.
# Remembered values: NO for the pit lid (19.000 typed); the New Pipe window values are typed each time.
CASE W1848
TITLE A new 225 pipe leaving a pit 400 mm below its lid: CDRULES says the cover is measured to the outside top of the pipe (or says the wall is Unknown), not just the inside top as before
PLAN_ITEM PR #1848 (B-012, BUG-901) PART: the wording and figure of one CDRULES R-04 row for one new pipe, switch ON. NOT whole: the Settings table of walls, the "lower the pipe" fix measuring the same way, the Edit Pipe strip, Civil Design and the pit editor (not changed by this PR, B-022) are not read
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 824
TIMEOUT 900
BUG BUG-901
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After the new pit (lid 19.000) and the new 225 pipe (first invert 18.600) are placed, CDRULES prints a cover row for that pipe that reads either 'cover 155 mm to the outside top at <pit> (pipe wall 20 mm, Settings UPVC 225, Assumed) is below 300 mm' or 'cover 175 mm to obvert at <pit> ... Pipe wall Unknown (...), so cover is measured to the inside top as before'; it changes no object; no CE window is left open.
WHY_NOT_UNIT_TEST The row is built from the real pit lid level, the real invert and the pipe's own size and material as AutoCAD holds them, and is only seen on the live command line.
NOT_AUTOMATED The wall figures themselves are not Tim-approved beyond his two examples (20 mm UPVC 225, 45 mm concrete 375): the case reads that the row is measured to the outside top, never that 20 mm is right.
NOT_AUTOMATED The OFF behaviour and the Unknown-wall fallback for UPVC 100 and 150 are not driven here except as the twin's wording.
NOT_AUTOMATED The row may be past the 80-row limit (see the cap risk above); then nothing is proved and Codex look K13_04 applies.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "PIT{NL}150000,-80000" -Force -ExpectWindow "New Pit" -> $pit_t1
  ui2-set "New Pit" "C2.CoverLevel" "19.000"
  ui-press "New Pit" "New pit, Continue placement" -> $pit_t2
  await-window-gone "^New Pit" -Secs 120
  esc-prompt -> $pit_e1
  esc-prompt -> $pit_e2
  esc-prompt -> $pit_e3
  type "CD{NL}150000,-80000{NL}170000,-80000{NL}" -Force -ExpectWindow "New Pipe" -> $pipe_t1
  ui2-set "New Pipe" "C2.Diameter" "225"
  ui2-set "New Pipe" "C2.FirstInvert" "18.600"
  ui2-set "New Pipe" "C2.SecondInvert" "18.500"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $pipe_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $pipe_e1
  wait
  type "CDRULES{NL}Problems" -Force -TimeoutSec 180 -> $r
  wait
  history-tail -Index 120 -> $tail
  windows-snapshot -> $win_end
  getvar CMDACTIVE -> $ca
ASSERT
  history has "[CE] CDRULES:"
  history matches "cover (155 mm to the outside top at \S+ \(pipe wall 20 mm, Settings UPVC 225|175 mm to obvert at \S+.*Pipe wall Unknown)"
  history has "below 300 mm"
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  record $tail "FULL the last 120 lines (look for the cover row, or for '... N more in the saved list')"
  record $r "FULL what CDRULES printed"
```

**Twin:** `W1848_BROKEN_cover_switch_off.case.txt`

```
# BUILD PENDING: cannot run until the Civil build with PR #1848 is installed.
# W1848_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Same route as W1848 with the PR's own switch cover.measuredToPipeOutside typed false before AutoCAD starts (settings are read at launch). With it OFF CDRULES gives exactly the old words and figure: 'cover 175 mm to obvert at <pit> is below 300 mm', with no wall note and no 'Pipe wall Unknown' sentence. So the check that expects the new wall wording MUST FAIL, while the route checks and the CDRULES line must still PASS. If the cover row is past row 80 this twin also cannot see it: then the failure is a tool limit and the report must say so.
CASE W1848_BROKEN
TITLE BROKEN VARIANT of W1848: the cover switch is OFF, yet the case still expects the outside-top wording (must FAIL)
PLAN_ITEM red-before-green proof for W1848 (PR #1848, BUG-901)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json cover.measuredToPipeOutside false
ORDER 825
TIMEOUT 900
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1848
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the row reads 'cover 175 mm to obvert ... is below 300 mm' with no wall note, so the check for the outside-top wording fails; the CDRULES line still appears.
WHY_NOT_UNIT_TEST It exists only to prove W1848's wording check can go red on the old behaviour.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "PIT{NL}150000,-80000" -Force -ExpectWindow "New Pit" -> $pit_t1
  ui2-set "New Pit" "C2.CoverLevel" "19.000"
  ui-press "New Pit" "New pit, Continue placement" -> $pit_t2
  await-window-gone "^New Pit" -Secs 120
  esc-prompt -> $pit_e1
  esc-prompt -> $pit_e2
  esc-prompt -> $pit_e3
  type "CD{NL}150000,-80000{NL}170000,-80000{NL}" -Force -ExpectWindow "New Pipe" -> $pipe_t1
  ui2-set "New Pipe" "C2.Diameter" "225"
  ui2-set "New Pipe" "C2.FirstInvert" "18.600"
  ui2-set "New Pipe" "C2.SecondInvert" "18.500"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $pipe_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $pipe_e1
  wait
  type "CDRULES{NL}Problems" -Force -TimeoutSec 180 -> $r
  wait
  history-tail -Index 120 -> $tail
  windows-snapshot -> $win_end
  getvar CMDACTIVE -> $ca
ASSERT
  history has "[CE] CDRULES:"
  history matches "cover (155 mm to the outside top at \S+ \(pipe wall 20 mm, Settings UPVC 225|175 mm to obvert at \S+.*Pipe wall Unknown)"
  not-contains $win_end "Creative Engineering"
  equals $ca 0
  record $tail "FULL the last 120 lines with the switch OFF (look for 'cover 175 mm to obvert')"
```

---

## 3. Codex look notes (the fixes with no robot route)

Evidence folder for every look: `C:\CE_WORK\codex\set13_<look id>\`. Never accept or capture a folder the box opened in. Run on a copy of the drawing, never Tim's job drawing.

### K13_01: #1856 (B-033, BUG-905), CDCALC Boyd's runoff 0.9 (BLOCKED-FOR-ROBOT: window-only)

**Why blocked:** the Boyd's tab is a window; no listed window or press name covers it in `acad_driver_v3.allowlist.json`, and the result is a number in the window, not a command-line line.

**Look:**
1. Open the CDCALC window and go to the Boyd's tab.
2. Type a site of 746 m2 with roof and paved 414 m2 and soft ground 332 m2 at 0.30 (the PR's worked example).
3. **Right looks like:** effective area 472.2 m2, overall C 0.633, storage 2.08 m3 on the default rows (before the PR: 513.6 m2, 0.688, 2.56 m3).
4. Open CDDESIGN's Boyd's result for the same inputs. **Right:** the same 0.633.
5. Screenshot both to the evidence folder (`set13_K13_01`).
6. Switch twin (a person, before AutoCAD starts): set `detention.boydsUsesHardGroundC` false in the settings; the window should give back 513.6 m2.

### K13_02: #1850 (GB-01 slice 2), minimum cover follows the pit surface (BLOCKED-FOR-ROBOT)

**Why blocked:** the New Pit window's surface pick has no known control name in the case folder (no case sets one), and the finding row prints in the pit/pipe block of CDRULES, which falls past the 80-row limit on the test drawing.

**Look:**
1. Place four pits, each with its lid 19.000 and a 225 pipe leaving at invert 18.300, in the New Pit window picking Garden, Footpath, Driveway (larger vehicles) and Road in turn (cover to the outside top: 475 mm less the wall for the size).
2. Run `CDRULES{NL}All` and open the saved file named on the "Full list saved" line (path under `%APPDATA%\CE_CVL_SUITE\logs\`). Read the R-04 rows.
3. **Right looks like:** each row ends with the surface and "office cover table" ("Garden surface, office cover table"), and the minimum compared is 300 (Garden), 100 (Footpath), 450 (Driveway, larger vehicles) and 600 (Road); Road warns, Garden and Footpath pass, Driveway (larger vehicles) warns at 475 less the wall below 450 only if the wall takes it under 450.
4. With the council set to Frankston the figure is 250 for every surface (council beats the table).
5. Evidence: the saved text file and a screenshot to `set13_K13_02`.

### K13_03: #1851 (GB-01 slice 3), R-34 minimum pit depth (BLOCKED-FOR-ROBOT: row prints last)

**Why blocked:** R-34 rows are made after every pipe row, so on the test drawing they fall past the 80-row command-line limit; the robot cannot read the saved file.

**Look:**
1. On a copy, place one pit with lid 19.000 and a 225 pipe leaving with invert 18.600 (depth 400 mm).
2. Run `CDRULES{NL}All`, open the saved file, find the R-34 row for that pit.
3. **Right looks like:** a Warn row naming the pipe that governs; least depth = minimum cover + 225 inside diameter + wall (for UPVC 225, 20 mm); the book's StormPro list (150 = 459, 225 = about 545 with a 20 mm wall and 300 cover, ... 900 = 1236) is the proof the PR used, as a test only.
4. A pit with no cover level or no invert reads "Unknown", never a pass.
5. Evidence: the saved file to `set13_K13_03`.

### K13_04: #1848 fallback if W1848's row falls past row 80

1. Same placing as W1848 (lid 19.000, 225 pipe, first invert 18.600).
2. Run `CDRULES{NL}All`, open the saved file, find the R-04 row for the new pit.
3. **Right looks like:** 'cover 155 mm to the outside top at <pit> (pipe wall 20 mm, Settings UPVC 225, Assumed) is below 300 mm' if the pipe is UPVC; otherwise the Unknown-wall sentence with 175 mm.
4. Evidence: the saved file to `set13_K13_04`.

---

## 4. Fixes skipped and why

1. **None skipped because a case already existed.** Checked again, not trusted from the filler: no file in `cases\`, `cases\variants\`, `cases\_setups\` or any `cases\drafts_*` folder mentions 1090, 901, 905, 1091, `measuredToPipeOutside`, `boydsUsesHardGroundC`, R-34 or a hydraulic grade line (the only hits are W780 and N65, an unrelated pipe-grade fix and a one-grade-only fix; W216 review text mentions HGL in passing). No `ROBOT_CASE_DRAFTS_*.md` (sets 1 to 12, WAVE1, TOP12) names any of the six PR numbers. `ledger.json` holds no W1771, W1841, W1848, W1850, W1851 or W1856.
2. **#1850, #1851 and #1856 got no robot case** (K13_02, K13_03, K13_01 above). I stayed inside the three-minute limit for each window-only fix.
3. **#1771 has a case but cannot run** until it is built into a train (not merged).

---

## 5. What was read, built, tested and NOT proven

1. **Read:** the files listed in section 1 item 1 and the six PRs. **Built:** nothing. **Tested:** nothing. **Not opened:** AutoCAD, the robot, Tim's settings files.
2. **NOT proven:** every printed line marked DERIVED; that the CDRULES rows for W1848 are inside the first 80; the pipe material the New Pipe window starts with; whether the robot's AutoCAD profile holds the old (unmoved) ladder; that W1771's line is spelled as asserted; that any council figure or wall thickness is right (Tim's call).
3. **Plain statement of the claim:** these are tests that, if they pass after a first-run fix-up, would show CDRULES prints the new words. They do not show the cover or fall maths is right for a job, and they do not replace Tim's check in AutoCAD.
