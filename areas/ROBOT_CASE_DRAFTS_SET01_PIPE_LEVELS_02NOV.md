# Robot case drafts, set 01: New Pipe and Edit Pipe level wording and warnings (Mon 2 Nov 2026, read-only drafter, Sonnet)

**What this is.** Case drafts for six fix PRs heading for `origin/claude/rel-20261102a`, written as plain text below with the file name each should get. Nothing was run, built, installed or opened in AutoCAD. No case file was created anywhere; this is the only file written. No git write (only `git fetch`, `gh pr view`, `gh pr diff`, read-only).

---

## FOR TIM

1. **Done.** 2 robot tests written on paper, each with a deliberately wrong copy that must fail (4 case texts): W1947 (the one-line note when a typed level is held to the nearest 10 mm) and W1967 (the minimum-grade warning never prints the same figure twice).
2. **Example.** W1947 draws a 10 m pipe, types the upstream level as 10.125 and checks CE prints "Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm)". The wrong copy turns the new switch off before AutoCAD starts and must fail.
3. **Four fixes are Codex-only, not robot:** #1887 (1 mm uphill), #1969 (comma-decimal PC), #1970 (level not saved on the pipe), #1927 (Recall Last). Reasons are in one line each in section 4, with exact Codex steps.
4. **Nothing here needs an Opus review for Undo, REDO, a locked layer or an Xref.** None of the four case texts touches any of them. One safety note for the desk: both cases change the "last used" New Pipe values on this PC, so each ends with a reset pipe that puts them back (same pattern as case N33a).
5. **Another review is still needed before any run:** an Opus reviewer must compare each case with its PR text (the REVIEWED_AGAINST line is empty on purpose).
6. **Not proven, plainly.** Every printed line marked DERIVED was read from the PR text and its tests, not seen on a run. Neither case can run until a build holding #1947 and #1967 is installed (both are open drafts).
7. **None of the six already had a case, so I did not take the replacements.** For the record: #1858 already has N33_grade_mismatch_x and its switch-off twin in `cases\drafts_c78_30oct`; #1919 has none.

---

## 1. How the drafts were written (read before validating)

1. **Format.** README_CASES.md format: header lines, `STEPS`, `ASSERT`. Every `type` chain is a complete command, no `(`, no SAVE-type word. Every twin carries `VARIANT_OF` and `EXPECT-FAIL BROKEN-VARIANT`.
2. **Switch-off twins.** Each twin is the same route and the same route checks with the PR's own switch typed `false` through `SETTING CD_Settings.json` before AutoCAD starts (the style of `variants\R09s_new_switch_off_broken`). Only the check on the new wording is expected to go red. If a twin PASSES, the runner reports "now passes: candidate": the case then cannot tell old from new and goes to Codex.
3. **Route.** The New Pipe window controls (`C2.Diameter`, `C2.CreatePipeText`, `C2.IsGradeCustom`, `C2.CustomGrade`, `C2.AutoCalcSecondInvert`, `C2.IsAutoCalcUpToDown`, `C2.KnownInvert`, `C2.FirstInvert`, `C2.SecondInvert`, `C2.IsGradeDefault`) and the reset-pipe pattern are copied from N33a and R31 (both written from real window dumps). The press is only `New pipe, Start Pipe` (on the v3 press list).
4. **Ground.** Pipes are on the free-end rows y -90000, -92000 and -94000 that R31 already uses (150000 to about 160000 in x). No pits, so no pit-wall shortening of the pipe length.
5. **REVIEWED_AGAINST is empty** in every draft; no review file is written. **Order numbers** 700 to 703 (the 704 to 709 are free). **Fixture** DRV1_B1, **SLOT fresh**.
6. **Validate first, without AutoCAD:** copy each block to its file name in a new drafts folder (suggested `cases\drafts_set01_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`.
7. **Check done again, as the brief asked.** I searched `cases` (every `drafts_*` folder, `variants`, `controls`, `_setups`), every `C:\CE_PLAN\areas\ROBOT_CASE_DRAFTS_*.md`, and `ledger.json` for the six PR numbers, the six bug numbers and the four switch names. No case, no draft. The only hits are N33 (#1858) and the damaged-record setup, which names #1970 as a user but holds no #1970 case.

---

## 2. The case texts

### Case 1 of 2: W1947, a typed level held to the nearest 10 mm says so (PR #1947, B-130, BUG-685; order 700)

**Intended file:** `W1947_typed_level_rounding_note.case.txt`

```
# BUILD PENDING: cannot run until a Civil build holding PR #1947 (origin/claude/b130-bug-685-typed-level-note, base origin/claude/rel-20261102a) is installed.
# W1947 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1947 (B-130, BUG-685), switch pipe.typedLevelRoundingNote, ON by default.
# Tim's ruling 29 Oct 2026 (decision 47, quoted in the PR): keep the 10 mm rule, say it in one line: "Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm)". The grade stays exactly 1 in 100. CD and Edit Pipe ("I know one end - work the other out from the grade") print the line only when the typed level was really rounded.
# Route: CD between two free ends 10 m apart (150000,-90000 to 160000,-90000), 100 mm, text off, Set my own 1 in 100, "I know one end" ON with the upstream known, known level typed 10.125 (the PR's own worked example). A second pipe 2 m south types 10.13, which is already on a 10 mm step: no line must be printed for it. Calculated decimals is the shipped 2 (so the step is 10 mm).
# CD prints the line as '[CE] <text>.' with a full stop added by CdCommand.cs (PR diff). The test below matches the text without the full stop.
# DERIVED, never seen on a run: that the known-level box keeps 10.125 as typed; that no Grade mismatch window opens (the held end is 10.13 and the other 10.03, exactly 1 in 100 over 10 m, per the PR's worked example); the IL text wording 'IL 10.13' (2 or 3 decimals accepted); that the second pipe's CE line count is 0.
# Remembered values: YES. New Pipe saves grade mode, the Set my own value, "I know one end", text on/off and the size to CD_RecentValues.json, which the settings guard does NOT restore. The case ends with a RESET pipe (Standard grade, work-out off, 225, text on, 18.000 / 17.900), as N33a does. If the case is stopped early, put the New Pipe values back by hand.
CASE W1947
TITLE CD with the upstream level typed 10.125 on a 10 m pipe at 1 in 100 prints 'Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm)'; a level typed 10.13 prints nothing
PLAN_ITEM PR #1947 (BUG-685, B-130) PART: the CD route, one rounded level (note printed) and one level already on a step (no note). NOT whole: the Edit Pipe route ("I know one end" in Edit Pipe) is not driven, the downstream-known direction is not driven, and the New Pipe window preview does not show the line (the PR says so: Codex brief)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pipe.typedLevelRoundingNote true
ORDER 700
TIMEOUT 1500
BUG BUG-685
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CD from 150000,-90000 to 160000,-90000, 100 mm, Set my own 1 in 100, "I know one end" ON (upstream known), known level 10.125, Start Pipe: no Grade mismatch window; the command line says 'Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm)'; one new CE pipe; its start IL text reads 10.13. The second pipe (150000,-92000 to 160000,-92000, known level 10.13) adds no 'Typed level' line and its IL text reads 10.13. The whole case holds exactly one 'Typed level 10.' line. A reset pipe follows. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests call the wording rule and read the source; only the live CD Draw path decides whether the typed level was rounded and prints the line.
NOT_AUTOMATED Edit Pipe's own copy of the line (PipeEditCommand.Update.cs) is not driven: its Save is a narrow exception, a rounded level there needs a pipe to edit and a typed box, and no case yet covers it (Codex look K_1947 in section 3).
NOT_AUTOMATED The other worked-out level (10.03) and the pipe label grade are recorded, not judged.
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
  matches $ilt2 "IL 10\.130?(?!\d)"
  copy-unchanged $copy0
  record $np1 "FULL New Pipe window before Start Pipe (known level, grade, length)"
  record $cd1 "FULL CD, first pipe"
  record $ilt1 "the IL texts of the first pipe (the other end should read 10.03)"
  record $ilt2 "the IL texts of the second pipe"
  record $civlog "FULL new Civil CE log lines"
  record $cdR "FULL CD reset pipe (puts the remembered New Pipe values back)"
```

**Twin:** `W1947_typed_level_rounding_note_BROKEN.case.txt`

```
# BUILD PENDING: as W1947.
# W1947_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The PR's own switch-off control: pipe.typedLevelRoundingNote typed false before AutoCAD starts (OFF = no line, as before; the rounding and the grade are unchanged). Same first pipe, same route checks. It must FAIL on 'history has "Typed level 10.125 held as 10.13 ..."' only. If it PASSES the line is printed with the switch off and W1947 proves nothing: say so in the report.
CASE W1947_BROKEN
TITLE BROKEN VARIANT of W1947: the rounding-note switch is OFF, the case still expects the note (must FAIL)
PLAN_ITEM red-before-green proof for W1947 (PR #1947, BUG-685)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pipe.typedLevelRoundingNote false
ORDER 701
TIMEOUT 1200
BUG BUG-685
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1947
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the pipe is drawn as before (IL 10.13 at the typed end) but no 'Typed level' line is printed, so the 'history has' check fails; the pipe count and IL checks pass.
WHY_NOT_UNIT_TEST It exists only to prove W1947's wording check can go red.
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
  count $pipe1 = 1
  matches $ilt1 "IL 10\.130?(?!\d)"
  history has "Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm)"
  record $ilt1 "the IL texts, switch OFF"
```

---

### Case 2 of 2: W1967, the minimum-grade warning never prints the same figure twice (PR #1967, B-119, BUG-1235; order 702)

**Intended file:** `W1967_grade_warning_figures_never_match.case.txt`

```
# BUILD PENDING: cannot run until a Civil build holding PR #1967 (origin/claude/b119-bug-1235-grade-warning-figures, base origin/claude/rel-20261102a) is installed.
# W1967 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1967 (B-119, BUG-1235), switch pipe.gradeWarningFiguresNeverMatch, ON by default. Only words change; REDO-safe; no layer, Xref or REFEDIT involvement (the PR says so).
# The sentence is built in Services/DesignValidationService.cs CheckGradeTooFlat and CD writes every design warning as '[CE] Warning: <message>' on the command line, then opens the 'Design Warnings' window (CdCommand.cs, PipeValidationWarningDialog; read on origin/claude/rel-20261102a). Old sentence: 'Grade 1:200 is shallower than minimum 1:200 - risk of silting'. New: both figures gain the fewest decimals that tell them apart.
# The minimum grade is the shipped designStandards.minimumPipeGrade 200 (UserSettings.cs, default 200.0): no setting is changed for it.
# Arithmetic (this drafter's, not the PR's): free ends 150000,-90000 to 160020,-90000 = 10.020 m; levels 18.000 / 17.950 = 0.050 m fall; 10.020 / 0.050 = 1 in 200.4. Rounded to a whole number that is 200, the same as the minimum, which is the bug. New text: 'Grade 1:200.4 is shallower than minimum 1:200.0' (the PR's own table: 200.4 against 200.0 reads 200.4 and 200.0). Both levels are on 10 mm steps, so no rounding disturbs the fall. Length 10.020 m is exact to the centimetre on purpose, so a CE length rounded to 2 decimals changes nothing.
# Custom grade 1 in 200 is chosen so the typed levels (1 in 200.4) are within 10 per cent of it: no Grade mismatch window (N33d shows that window cannot be answered by the robot, only Cancel is on the press list).
# A second pipe 2 m south is exactly 10.000 m with the same levels = exactly 1 in 200: no minimum-grade warning at all (the PR's 'at exactly the minimum' test).
# DERIVED, never seen on a run: the exact new figures; that CD's length is the picked-point distance (so 10.020 m); that other design warnings (velocity) may also print and open the 'Design Warnings' window on either pipe; the window title ('Design Warnings' per W261, read from PipeValidationWarningDialog).
# Remembered values: YES, as W1947. The case ends with the RESET pipe of N33a.
CASE W1967
TITLE A 10.02 m pipe falling 50 mm (1 in 200.4) against the 1 in 200 minimum prints 'Grade 1:200.4 is shallower than minimum 1:200.0', never 'Grade 1:200 is shallower than minimum 1:200'; a pipe at exactly 1 in 200 prints no such warning
PLAN_ITEM PR #1967 (BUG-1235, B-119) PART: the CD command-line sentence for one hair-flat pipe, plus the exact-minimum control. NOT whole: the same sentence in Edit Pipe, the dashboard and CDRULES-type readers is not driven, the Design Warnings window picture is a Codex look, and figures that already differ ('1:202 ... 1:200') are only pinned by the unit tests
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pipe.gradeWarningFiguresNeverMatch true
ORDER 702
TIMEOUT 1500
BUG BUG-1235
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CD from 150000,-90000 to 160020,-90000, Custom grade 1 in 200, levels 18.000 and 17.950, Start Pipe: one new CE pipe is placed (a warning only) and the command line says '[CE] Warning: Grade 1:200.4 is shallower than minimum 1:200.0 ...'; it never says 'Grade 1:200 is shallower'. The 'Design Warnings' window opens and is closed. The second pipe (150000,-92000 to 160000,-92000, same levels, exactly 1 in 200) is placed and adds no 'is shallower than minimum' line, so the whole case holds exactly one. A reset pipe follows. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests call the validator with made-up pipes; only the live CD pipe, with the length CE really measures, shows which figures the drafter reads.
NOT_AUTOMATED Edit Pipe and the other places that call the same check are not driven. The look of the Design Warnings window is a Codex look (RIGHT_LOOKS_LIKE: the window lists the grade line with two different figures).
NOT_AUTOMATED Whether CD measures 10.020 m exactly is recorded through the New Pipe window dump, not judged.
STEPS
  copy-info -> $copy0
  getvar OSMODE -> $osm0
  v3 setvar OSMODE 0 -> $osm_set
  ms-count -> $c0
  type "CD{NL}150000,-90000{NL}160020,-90000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd1
  ui2-set "New Pipe" "C2.Diameter" "100"
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "200"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.950"
  sleep 2
  ui-dump "^New Pipe" -TimeoutSec 60 -> $np1
  ui-press "New Pipe" "New pipe, Start Pipe" -> $start1
  await-window-gone "^New Pipe" -Secs 120
  sleep 4
  windows-snapshot -> $w1
  ui-dump "Design Warnings" -Optional -TimeoutSec 30 -> $dw1
  close-windows -> $closed1
  esc-prompt -> $esc1
  wait
  ms-new $c0 -> $new1
  select $new1 "object~^CeCvlPipeObject$" -> $pipe1
  ms-count -> $c1
  type "CD{NL}150000,-92000{NL}160000,-92000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd2
  ui2-set "New Pipe" "C2.Diameter" "100"
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "200"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.950"
  sleep 2
  ui-press "New Pipe" "New pipe, Start Pipe" -> $start2
  await-window-gone "^New Pipe" -Secs 120
  sleep 4
  windows-snapshot -> $w2
  close-windows -> $closed2
  esc-prompt -> $esc2
  wait
  ms-new $c1 -> $new2
  select $new2 "object~^CeCvlPipeObject$" -> $pipe2
  log-read civil -> $civlog
  type "CD{NL}150000,-94000{NL}170000,-94000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cdR
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
  count $pipe1 = 1
  count $pipe2 = 1
  history has "Grade 1:200.4 is shallower than minimum 1:200.0"
  history absent "Grade 1:200 is shallower"
  history count "is shallower than minimum" = 1
  copy-unchanged $copy0
  record $np1 "FULL New Pipe window before Start Pipe (length and grade as CE shows them)"
  record $dw1 "FULL the Design Warnings window as text (every warning CD listed)"
  record $w1 "FULL windows open after Start Pipe"
  record $cd1 "FULL CD, first pipe"
  record $civlog "FULL new Civil CE log lines"
  record $cdR "FULL CD reset pipe (puts the remembered New Pipe values back)"
```

**Twin:** `W1967_grade_warning_figures_never_match_BROKEN.case.txt`

```
# BUILD PENDING: as W1967.
# W1967_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The PR's own switch-off control: pipe.gradeWarningFiguresNeverMatch typed false before AutoCAD starts (OFF returns the old whole-number sentence exactly, per the PR). Same first pipe, same route checks. It must FAIL on 'history has "Grade 1:200.4 ..."' (the old sentence reads 'Grade 1:200 is shallower than minimum 1:200'). If it PASSES, W1967 cannot tell old from new: say so.
CASE W1967_BROKEN
TITLE BROKEN VARIANT of W1967: the grade-figures switch is OFF, the case still expects two different figures (must FAIL: the old equal figures return)
PLAN_ITEM red-before-green proof for W1967 (PR #1967, BUG-1235)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pipe.gradeWarningFiguresNeverMatch false
ORDER 703
TIMEOUT 1200
BUG BUG-1235
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1967
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the warning still prints but reads 'Grade 1:200 is shallower than minimum 1:200', so 'history has "Grade 1:200.4 ..."' fails; the pipe count and 'is shallower than minimum' checks pass.
WHY_NOT_UNIT_TEST It exists only to prove W1967's figures check can go red.
STEPS
  copy-info -> $copy0
  getvar OSMODE -> $osm0
  v3 setvar OSMODE 0 -> $osm_set
  ms-count -> $c0
  type "CD{NL}150000,-90000{NL}160020,-90000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd1
  ui2-set "New Pipe" "C2.Diameter" "100"
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "200"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.950"
  sleep 2
  ui-press "New Pipe" "New pipe, Start Pipe" -> $start1
  await-window-gone "^New Pipe" -Secs 120
  sleep 4
  windows-snapshot -> $w1
  ui-dump "Design Warnings" -Optional -TimeoutSec 30 -> $dw1
  close-windows -> $closed1
  esc-prompt -> $esc1
  wait
  ms-new $c0 -> $new1
  select $new1 "object~^CeCvlPipeObject$" -> $pipe1
  type "CD{NL}150000,-94000{NL}170000,-94000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cdR
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
  count $pipe1 = 1
  history has "is shallower than minimum"
  history has "Grade 1:200.4 is shallower than minimum 1:200.0"
  record $dw1 "FULL the Design Warnings window, switch OFF"
```

---

## 3. Codex look notes (the robot cannot prove these; each is a short recipe for a Codex pass in real AutoCAD on a COPY of DRV1_B1)

Evidence for every note: a folder under `C:\CE_WORK\codex\<note id>\` (screenshots with the build's product-version string visible in About CE Suite, plus the command-line text). Never accept or capture a folder the Save or file box opened in; if a box opens, press Cancel and say so.

1. **K_1887, PR #1887 (BUG-1092): a pipe 1 mm uphill reads "flows uphill". BLOCKED-FOR-ROBOT.** Why: near-level typed levels open the Grade mismatch window before the pipe is drawn (W223 note: a level pipe opens it on 3.0.87 and later), and that window's Use and Keep buttons are not on the robot's press list (N33d), so the robot can only Cancel and place nothing. Codex steps:
   1. Open a copy. Type CD, pick 150000,-90000 then 150000,-91000 style two points 1 m apart (or any two empty points 1 m apart), Diameter 225.
   2. Type the first level 10.000 and the second 10.001 (exactly 1 mm uphill; CE counts exactly 1 mm as level, so no direction question). Press Start Pipe. If the Grade mismatch window opens, press the button that keeps your typed levels (the one starting "Keep"), and write which words were on it.
   3. **Right looks like:** the Design Warnings window shows the RED line "Pipe flows uphill ... upstream IL 10.000 is 1mm lower than downstream IL 10.001", not the amber "Pipe is essentially flat".
   4. Control A: first level 10.000, second 10.000 (level): "Pipe is essentially flat". Control B: set `grade.anyUphillFallIsError` to false in `CD_Settings.json` BEFORE AutoCAD starts, then repeat step 2: the amber "essentially flat" returns (the old behaviour).
   5. Not in this note: CDRULES (the fix report `BUGFIX_fx1887_REPORT_31OCT.md` says it does not show there) and the markup route (it keeps its own 1 mm limit).

2. **K_1947, PR #1947 (BUG-685), Edit Pipe half and the window preview.** Codex steps: place a 10 m pipe with open ends (any levels), CDEDIT it, tick "I know one end", Set my own 1 in 100, type the known upstream level 10.125, Save. **Right looks like:** the command line says "Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm)." and the reopened window reads 10.13 and 10.03. The New Pipe window does NOT show the line (the PR says so; do not fail it for that).

3. **K_1969, PR #1969 (BUG-1164): Edit Pipe stores a typed level with a full stop on a comma-decimal PC. BLOCKED-FOR-ROBOT:** the robot cannot change Windows regional settings, and a case that did would change Tim's PC. No route exists. Codex steps (only on a spare Windows user, or with the starting region written down and put back; ask Tim before touching his own account):
   1. Set Region format to a comma-decimal one (for example German, Germany). Restart AutoCAD.
   2. Place a pipe with levels 18.00 and 17.90. CDEDIT it, type the first level as 18,14, Save.
   3. **Right looks like:** the pipe's IL text and the Pit Schedule row read 18.14 (digits kept), CDAUDIT does not report the level as missing or as 1814. Control: `pipe.editPipeStoresLevelsWithDecimalPoint` false before launch: the stored text stays "18,14" as before.
   4. On the normal Australian region the PR says nothing visible changes: check one ordinary save still reads the same.
   5. The PR does NOT repair a drawing that already holds "18,14".

4. **K_1970, PR #1970 (BUG-1157): Edit Pipe says so when it could not write the level onto the pipe itself. BLOCKED-FOR-ROBOT:** the line only appears when the pipe's own saved record is damaged or unreadable. The robot's one record writer (`v3 record-set`) only allows the pit link record and the project record (`V3RecordSetAllow` in `acad_driver_v3.ps1`); the pipe's record is not on the list, and adding it needs a reviewed allow-list change that nobody has asked for. I did not draft it. Codex steps for the half that can be seen now: on an ordinary pipe, CDEDIT, change a level, Save: **right looks like** no line containing "the level was not saved on pipe" (the control that the warning does not fire when nothing is wrong). The damaged-record half stays untested until the allow-list change is reviewed; the damaged pit-link setup `SETUP-DMG-LINKS` names #1970 as a user, but it damages a pit record, not the pipe record this fix writes.

5. **K_1927, PR #1927 (BUG-1267): Recall Last, then a new upstream level, works from the standard grade.** BLOCKED-FOR-ROBOT for now, two reasons. (a) The New Pipe window's `Recall Last` button (`CdDialog.xaml` line 1242) is not on the v3 press list for New Pipe (only Start Pipe, Cancel without saving, Cancel, Close); whether v2 `ui2-press` may press it is unproven and should be tried in a probe first. (b) The PR is stacked on #1919, not on `rel-20261102a`, so nothing can be run until #1919 and #1927 are both in a build. Codex steps:
   1. Two pits 4.1 m apart (as N33: 150000,-70000 and 154550,-70000, cover 19.000). CD pit to pit with Set my own 1 in 100, "I know one end" ON, known 19.45 on an earlier pipe so Recall Last holds a 0.50 m fall (19.45 to 18.95). Exact recalled values are not recorded anywhere I read: write down what the first window shows.
   2. Second CD, 4.1 m pit to pit. Press Recall Last. Type a NEW upstream level 19.45.
   3. **Right looks like:** the downstream level reads 19.40 (1 in 100 over 4.1 m, rounded up to 10 mm). The old behaviour (switch `pipe.recallLastNewUpstreamUsesStandardGrade` false before launch) reads 18.95.
   4. Reset the New Pipe values at the end (draw one Standard-grade pipe, as N33a does).

---

## 4. Fixes skipped and why

1. **#1887 (B-069, BUG-1092):** no robot case. The Grade mismatch window sits in the way and cannot be answered by the robot. Codex look K_1887. Not CDRULES.
2. **#1969 (B-119, BUG-1164):** BLOCKED-FOR-ROBOT, needs a comma-decimal Windows region. Codex look K_1969.
3. **#1970 (B-119, BUG-1157):** BLOCKED-FOR-ROBOT, needs a damaged pipe record the robot's writer is not allowed to make. Codex look K_1970.
4. **#1927 (B-095, BUG-1267):** BLOCKED-FOR-ROBOT for now: Recall Last is not on the press list and the PR is stacked on #1919. Codex look K_1927.
5. **#1919 and #1858 (the reserve pair):** not drafted, because none of the six already had a case. #1858 already has `N33_grade_mismatch_x` and `N33_grade_mismatch_x_off` (`cases\drafts_c78_30oct`, both with reviews). #1919 has no case (it changes the Grade mismatch window into a warning line; a candidate for a later set).
6. **W1947 and W1967 not drafted further:** the Edit Pipe copies of both lines (K_1947 covers the first) and the Design Warnings window picture are Codex looks, not robot.

---

## 5. What was read, built, tested and NOT proven

1. **Read:** `C:\TimOS\RULES.md`; `README_CASES.md`; the finished example `ROBOT_CASE_DRAFTS_TOP12_30OCT.md` (first 830 of 1289 lines, enough for the layout and four cases) and `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md` (all); cases R31, W261, W223 (headers), N33a, N33d (header and steps), `variants\R09s_new_switch_off_broken`, `SETUP-P8`, `SETUP-DMG-LINKS`; `acad_driver_v3.allowlist.json` (the New Pipe press list); the `record-set` allow-list in `acad_driver_v3.ps1`; the PR texts and diffs of #1887, #1947, #1967 and the PR texts of #1969, #1970, #1927, #1919, #1858 (`gh pr view` / `gh pr diff`); `BUGFIX_fx1887_REPORT_31OCT.md`; `CdCommand.cs`, `CdDrawFirstFlowService.cs`, `DesignValidationService.cs` and `UserSettings.cs` on `origin/claude/rel-20261102a` (`git show`, `git grep`); `CdDialog.xaml`. After `git fetch` the line was read as it stood this morning.
2. **Not read in full:** the `BUGFIX_*` reports for #1947, #1967, #1969, #1970, #1927 (none exists in `areas` by PR or bug number; the PR text and its tests were used instead), `REGRESSION_LOG.md` (not opened; the PR texts say they add lines), and `BUG_CARPARK.md` (a search by the six bug numbers returned no line, so I did not use it).
3. **Built:** nothing. **Tested:** nothing. **Installed:** nothing. **Seen in AutoCAD:** nothing.
4. **NOT proven:** every case text is unvalidated (`case_runner.ps1 validate` was not run); the New Pipe ids come from other cases, not from a fresh window dump; the exact new wording and the IL text decimals are DERIVED from the PR text; whether CD measures 10.020 m exactly and whether the 10.125 box keeps its third decimal are unknown; whether `close-windows` is harmless with no window open (W1967's second pipe) is assumed from the earlier drafts; and whether the old build really shows the old wording on this drawing is exactly what each twin is there to prove. Expect one or two fix-ups at the first run.
