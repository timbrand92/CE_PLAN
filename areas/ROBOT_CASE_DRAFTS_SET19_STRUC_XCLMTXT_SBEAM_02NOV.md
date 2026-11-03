# Robot case drafts, SET 19: Structural XCLMTXT, SBEAM and CEMEMBER (Mon 2 Nov 2026, Melbourne, read-only drafter, Sonnet)

**What this is.** Two robot cases, each with a broken twin, drafted on paper for fix PRs #1900 and #1932 (both heading for `origin/claude/rel-20261026s`). The other four PRs (#1902, #1903, #1904, #1905) cannot be driven by the robot, so they are marked BLOCKED-FOR-ROBOT with a Codex look each. Nothing was built, run, installed or opened in AutoCAD. No case file was created in the cases folder: the only file written is this one. No git write.

---

## FOR TIM

1. **2 robot cases drafted, each with a broken twin (4 case texts).** W1900 (CEMEMBER: typing 114.3x6 says "no section called" instead of picking the 6.4 wall) and W1932 (CEMEMBER takes the supplier name 310UB32.0 and 410UB59.7).
2. **Codex-only (BLOCKED-FOR-ROBOT, 4 fixes).** #1902 (SBEAM window figures and length in mm), #1903 and #1904 (XCLMTXT spelling and PLATE) and #1905 (SBEAM search box). The SBEAM section window is not on the robot's read list and XCLMTXT needs an Excel table. Codex looks are in part 3.
3. **Needs an Opus review BEFORE it is run because of Undo, REDO, a locked layer or an Xref:** none. Every case only types a command, answers its prompts and presses Esc. Nothing is drawn, so no U, OOPS or REDO is used and no layer or Xref is touched.
4. **A catch for the desk, found while drafting.** Once #1900 and #1932 are BOTH in, typing `310UB32` (the name most drafters use) at CEMEMBER may say "no section called". #1932 renames the list entry to 310UB32.0, and #1900 stops a short name matching a longer name at a decimal point. #1932 says typing an old name at CEMEMBER is "not covered". W1932 records what happens (a printed line, no pass or fail) so the first run shows it. This is read from the two diffs, not seen on a run.
5. **Example of what W1900 checks.** Type CEMEMBER, accept the view, type 114.3x6. Right looks like: CEMEMBER says there is no section called 114.3x6. The twin switches the fix off and must fail, because the old code picks 114.3x6.4CHS.
6. **Could NOT verify:** that the Structural plugin with these PRs is installed in the robot's AutoCAD (the installed one, 1.0.125, has neither fix: W1900 and W1932 should FAIL on it, which is the "red before green" proof); that the robot accepts a Structural settings path in a SETTING line (nobody has run one); the exact lines CEMEMBER prints after "Pick point 1".
7. **Nothing for you to test or decide now.** These wait for the desk and an Opus review. All the bug entries stay OPEN.

---

## 1. How the drafts were written

1. **What I read.** `C:\TimOS\RULES.md`; `README_CASES.md` in full, including the refused-button list; `acad_driver_v3.allowlist.json`; the finished example `ROBOT_CASE_DRAFTS_TOP12_30OCT.md`; `ROBOT_CASE_DRAFTS_SET18_STRUC_FOOTINGS_02NOV.md` (the Structural switch-off style); `CASE_WRITING_STRUC_REPORT_30OCT.md`; `R09s_new_switch_off_broken`; the six PR texts and the diffs of #1900 and #1932 (`gh pr view`, `gh pr diff`, read only); the carpark entries BUG-1121, 1122, 1123, 1126, 1128, 1131 and 1132; and the Structural source on `origin/claude/rel-20261026s` (`CeMemberCommands.cs`, `ExcelMTextCommands.cs`, `section-catalogue.json`, `SettingsService.cs`) with `git show` only.
2. **Is there already a case?** No, checked again. No file in `cases\` or any `drafts_*` folder names CEMEMBER, SBEAM or XCLMTXT. No `ROBOT_CASE_DRAFTS_*.md` names #1900, #1902, #1903, #1904, #1905 or #1932 (three set files mention a four-digit number like 1900 in other contexts; none is these PRs). `ledger.json` holds no CEMEMBER, SBEAM or XCLMTXT entry. I did not find a `BUGFIX_*_REPORT` for them beyond `BUGFIX_s5_REPORT_31OCT.md`, `s6` and `s7` (not read in full; the PR texts carry the same facts).
3. **Why only two are robot cases.** The driver's read list (`acad_driver_v3.allowlist.json`) holds no SBEAM or section-picker window, and the README says a window not on the list cannot be read. So the SBEAM figures, the SBEAM search box and the length box are out. XCLMTXT takes its cells from an Excel table; the robot cannot open a table or press an Export or Save button. CEMEMBER is different: it is all typed prompts on the command line, and the robot reads the command line.
4. **The switch-off twin.** Both twins set the PR's own switch OFF before launch with a SETTING line, as `R09s_new_switch_off_broken` does. Structural reads `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json` (`SettingsService.cs` line 68), and a bare `CS_Settings.json` would be read as the Civil folder, so the lines use the FULL path (it is on the driver's `settings_files` list). UNPROVEN: nobody has run a SETTING line with this path and the key may not exist in the file yet. If the runner refuses it, the twin comes back BLOCKED, not red. Fallback twin: a "claims the old fault" twin (the S467 style), which needs no setting: keep the steps, and in ASSERT change `history count "CEMEMBER: no section called" = 4` to `= 0` for W1900, and `contains $t_new "Pick point 1 of 310UB32.0"` to `not-contains` for W1932.
5. **Fixture.** DRV2_S1 (millimetres, the Structural drawing the 30 Oct Structural cases and robot run 2 used). CEMEMBER holds itself in a metre, centimetre or inch drawing (Day 1 units line), so the drawing must be millimetres or unset. DRV1_B1 would also do. No drawing contents are needed: nothing is drawn.
6. **Order numbers** 880 to 883. **SLOT fresh.** `REVIEWED_AGAINST` is left empty. Every `type` chain is a complete command, no `(`, no SAVE-type word. No case unlocks a layer, touches an Xref or goes round any AutoCAD protection.
7. **The CEMEMBER route, read from the source (DERIVED, not seen on a run).** After CEMEMBER the prompts in order are: the view question "View [SIde/Top/SEction/Reset] <Side>:" (Enter takes the default), then "Section name, for example 310UB32 or 380PFC (Escape to cancel):". A name with no match prints `CEMEMBER: no section called "<name>" in the section list. Type the full name.` and asks the name again. A match goes on (UB and CHS sections ask no orientation) to "Points sit on [Centreline/Top/Bottom]", then "Break lines at [Both/Start/End/None(closed)]", then "Pick point 1 of <name> (Side) or press Escape to finish:". Esc at the name prompt prints "CEMEMBER cancelled. Nothing changed."
8. **Chain shape.** `CEMEMBER{NL}{NL}<name>`: the first Enter ends the command word, the second takes the view default, then the name, and `type` adds the last Enter. For a name that matches, `{NL}{NL}` after it takes the two defaults, and the chain's own last Enter takes the second one; the "Pick point 1" line is then the open prompt, which `esc-prompt` ends. The quote marks inside CEMEMBER's "no section called" line cannot be written in a case (README batch 3 item 9), so the checks use the words before them and the count.
9. **To validate offline:** copy each block to its file name in a new folder (suggested `cases\drafts_struc_set19_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`. I did not run this.
10. **Not proven by any of this:** that a first run behaves as DERIVED above; the catalogue on the installed build; Escape after "Pick point 1" printing no extra prompt.

---

## 2. The case texts

### Case 1 of 2: W1900, CEMEMBER does not take 114.3x6.4CHS for a typed 114.3x6 (#1900, B-081, BUG-1121)

**Intended file:** `W1900_cemember_incomplete_number_no_match.case.txt`

```
# W1900 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1900 (B-081, BUG-1121), switch CeMember.SectionNamePrefixStopsAtDecimalPoint, default ON, on origin/claude/rel-20261026s. On the installed 1.0.125 this case should FAIL (old behaviour): that is the red-before-green proof.
# Route (DERIVED from CeMemberCommands.cs on rel-20261026s, not seen on a run): CEMEMBER, Enter takes the View default, the name is typed. No match prints 'CEMEMBER: no section called "<name>" in the section list. Type the full name.' and asks again; Esc then prints 'CEMEMBER cancelled. Nothing changed.'. A match runs on to Points-sit-on and Break-lines-at (two Enters) and then 'Pick point 1 of <name> (Side) or press Escape to finish:', ended by Esc.
# Names (DERIVED from the PR tests and section-catalogue.json): 114.3x6.4CHS, 168.3x6.4CHS, 60.3x4.5CHS, 89x89x3.5SHS and 310UB32 are in the list; no 6.0, 4.0 or 3.0 wall is. 310UB3 is the front of 310UB32 only.
# Nothing is placed (no point is ever picked). settings-arm is used because CEMEMBER may save its remembered view.
CASE W1900
TITLE CEMEMBER at Section name: 114.3x6, 168.3x6, 60.3x4 and 89x89x3 each say there is no such section; 114.3x6.4 finds 114.3x6.4CHS and 310UB3 finds 310UB32; nothing is drawn
PLAN_ITEM BUG-1121 (B-081, PR #1900) PART: the typed Section name prompt of CEMEMBER with the switch ON. NOT whole: the same short-name rule inside any other list (SBEAM search is a different file, PR #1905) and the switch OFF route (that is the twin)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 880
TIMEOUT 600
BUG BUG-1121
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED Four incomplete numbers each print 'CEMEMBER: no section called' (four times in the case); the prompt 'Pick point 1 of 114.3x6.4CHS' appears once only (for the full name 114.3x6.4); 'Pick point 1 of 310UB32' appears once; 'Pick point 1 of 168.3x6.4CHS', '60.3x4.5CHS' and '89x89x3.5SHS' never appear; the number of objects in the drawing and the file on disk do not change.
WHY_NOT_UNIT_TEST The unit tests pin the matching rule; only the live command shows what the drafter is told at the prompt and that the live section list holds no 6.0 wall.
NOT_AUTOMATED The same rule at other typed-name prompts, and how the "no section called" line looks on screen (recorded, not judged).
NOT_AUTOMATED Placing a member (Pick point 1 and 2), the Section view route and the drawing it makes are not driven.
STEPS
  settings-arm
  copy-info -> $copy0
  ms-count -> $c0
  type "CEMEMBER{NL}{NL}114.3x6" -Force -TimeoutSec 90 -> $t_a
  esc-prompt -> $e_a
  type "CEMEMBER{NL}{NL}168.3x6" -Force -TimeoutSec 90 -> $t_b
  esc-prompt -> $e_b
  type "CEMEMBER{NL}{NL}60.3x4" -Force -TimeoutSec 90 -> $t_c
  esc-prompt -> $e_c
  type "CEMEMBER{NL}{NL}89x89x3" -Force -TimeoutSec 90 -> $t_d
  esc-prompt -> $e_d
  type "CEMEMBER{NL}{NL}114.3x6.4{NL}{NL}" -Force -TimeoutSec 90 -> $t_full
  esc-prompt -> $e_full
  type "CEMEMBER{NL}{NL}310UB3{NL}{NL}" -Force -TimeoutSec 90 -> $t_ub
  esc-prompt -> $e_ub
  wait
  ms-count -> $c1
ASSERT
  history count "CEMEMBER: no section called" = 4
  history count "Pick point 1 of 114.3x6.4CHS" = 1
  history count "Pick point 1 of 310UB32" = 1
  history absent "Pick point 1 of 168.3x6.4CHS"
  history absent "Pick point 1 of 60.3x4.5CHS"
  history absent "Pick point 1 of 89x89x3.5SHS"
  history absent "Unknown command"
  equals $c1 $c0
  copy-unchanged $copy0
  record $t_a "FULL what 114.3x6 printed"
  record $t_full "FULL what 114.3x6.4 printed"
  record $e_ub "FULL what Esc printed after 310UB3"
```

**Twin:** `W1900_BROKEN_switch_off.case.txt`

```
# W1900_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). DELIBERATELY BROKEN copy of W1900: the PR's own switch CeMember.SectionNamePrefixStopsAtDecimalPoint is OFF before AutoCAD starts, so CEMEMBER matches by the front of the name exactly as 1.0.125 did. Same steps and checks as W1900. Expected red: 'history count "CEMEMBER: no section called" = 4' (it is 0, because 114.3x6 and the other three pick the 6.4, 6.4, 4.5 and 3.5 walls), 'history count "Pick point 1 of 114.3x6.4CHS" = 1' (it is 2) and the three 'history absent' lines.
# UNPROVEN: the SETTING line uses the FULL path (a bare CS_Settings.json expands to the Civil folder). If the runner refuses the path or the key, this comes back BLOCKED, not red. Fallback: the 'claims the old fault' twin in part 1 item 4. Do NOT add hashes-unchanged (the settings file differs while the guard holds it).
CASE W1900_BROKEN
TITLE BROKEN VARIANT of W1900: the switch is OFF, so 114.3x6 takes 114.3x6.4CHS as on 1.0.125, and the case still claims 'no such section' (must FAIL)
PLAN_ITEM red-before-green proof for W1900 (BUG-1121, PR #1900)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 881
TIMEOUT 600
BUG BUG-1121
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1900
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json CeMember.SectionNamePrefixStopsAtDecimalPoint false
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF, 114.3x6 is taken for 114.3x6.4CHS, so no 'no section called' line appears four times and 'Pick point 1 of 114.3x6.4CHS' appears twice.
WHY_NOT_UNIT_TEST It exists only to prove W1900's checks can go red.
STEPS
  settings-arm
  copy-info -> $copy0
  ms-count -> $c0
  type "CEMEMBER{NL}{NL}114.3x6" -Force -TimeoutSec 90 -> $t_a
  esc-prompt -> $e_a
  type "CEMEMBER{NL}{NL}168.3x6" -Force -TimeoutSec 90 -> $t_b
  esc-prompt -> $e_b
  type "CEMEMBER{NL}{NL}60.3x4" -Force -TimeoutSec 90 -> $t_c
  esc-prompt -> $e_c
  type "CEMEMBER{NL}{NL}89x89x3" -Force -TimeoutSec 90 -> $t_d
  esc-prompt -> $e_d
  type "CEMEMBER{NL}{NL}114.3x6.4{NL}{NL}" -Force -TimeoutSec 90 -> $t_full
  esc-prompt -> $e_full
  type "CEMEMBER{NL}{NL}310UB3{NL}{NL}" -Force -TimeoutSec 90 -> $t_ub
  esc-prompt -> $e_ub
  wait
  ms-count -> $c1
ASSERT
  history count "CEMEMBER: no section called" = 4
  history count "Pick point 1 of 114.3x6.4CHS" = 1
  history count "Pick point 1 of 310UB32" = 1
  history absent "Pick point 1 of 168.3x6.4CHS"
  history absent "Pick point 1 of 60.3x4.5CHS"
  history absent "Pick point 1 of 89x89x3.5SHS"
  history absent "Unknown command"
  equals $c1 $c0
  record $t_a "FULL what 114.3x6 printed with the switch OFF"
```

---

### Case 2 of 2: W1932, CEMEMBER finds a section by its supplier name (#1932, B-106, BUG-1132, BUG-818 names only)

**Intended file:** `W1932_cemember_supplier_names.case.txt`

```
# W1932 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1932 (B-106, BUG-1132, BUG-818 names only), switch CeMember.SectionListUsesSupplierNames, default ON, branch claude/b106-cemember-section-rename off origin/claude/rel-20261026s. On the installed 1.0.125 and on rel-20261026s without #1932 the list has 310UB32 and 410UB60, not 310UB32.0 and 410UB59.7, so this case should FAIL there.
# Names (DERIVED from the PR text: 'ON: 34 UB and UC rows carry the supplier's name: 310UB32 is now 310UB32.0, 410UB60 is 410UB59.7, 530UB92 is 530UB92.4'). Route as W1900 item 7 (DERIVED, not seen).
# Not covered: the old-beam redraw (BUG-1132 proper). The PR itself says nothing in the Structural line calls the CEMEMBER redraw yet, so it is proven by unit tests only; a Codex look cannot reach it either until a caller exists.
# The last step types the OLD name 310UB32 and only RECORDS what comes back (no pass or fail): with #1900 also in, the decimal-point rule may refuse it (see FOR TIM item 4). Read it on the first run.
CASE W1932
TITLE CEMEMBER at Section name: 310UB32.0, 410UB59.7 and 530UB92.4 are each found by their supplier name; the old name 310UB32 is recorded; nothing is drawn
PLAN_ITEM BUG-1132 and BUG-818 (names only) (B-106, PR #1932) PART: the typed CEMEMBER name route with the switch ON, three of the 34 renamed rows. NOT whole: the SBEAM section window list (Codex look D), the other 31 renamed rows, the old-beam redraw, and BUG-818's size and mass corrections (not in this PR)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 882
TIMEOUT 600
BUG BUG-1132
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED Typing 310UB32.0, 410UB59.7 and 530UB92.4 each reaches 'Pick point 1 of <that name>' once, no 'no section called' line appears for them, nothing is drawn, and the file on disk is unchanged. What 310UB32 prints is recorded, not judged.
WHY_NOT_UNIT_TEST The unit tests read the catalogue file; only the live CEMEMBER shows the name a drafter can type and that the installed list was renamed at start-up through the switch.
NOT_AUTOMATED The SBEAM window list and its search (window not on the robot's read list; Codex look D).
NOT_AUTOMATED Placing a beam saved under an old name and redrawing it: nothing in the Structural line calls the redraw (PR text), so the unit tests are the only proof for now.
STEPS
  settings-arm
  copy-info -> $copy0
  ms-count -> $c0
  type "CEMEMBER{NL}{NL}310UB32.0{NL}{NL}" -Force -TimeoutSec 90 -> $t_a
  esc-prompt -> $e_a
  type "CEMEMBER{NL}{NL}410UB59.7{NL}{NL}" -Force -TimeoutSec 90 -> $t_b
  esc-prompt -> $e_b
  type "CEMEMBER{NL}{NL}530UB92.4{NL}{NL}" -Force -TimeoutSec 90 -> $t_c
  esc-prompt -> $e_c
  type "CEMEMBER{NL}{NL}310UB32" -Force -TimeoutSec 90 -> $t_old
  esc-prompt -> $e_old
  wait
  ms-count -> $c1
ASSERT
  history count "Pick point 1 of 310UB32.0" = 1
  history count "Pick point 1 of 410UB59.7" = 1
  history count "Pick point 1 of 530UB92.4" = 1
  history absent "Unknown command"
  equals $c1 $c0
  copy-unchanged $copy0
  record $t_old "FULL what the OLD name 310UB32 printed (first run: is it found, or 'no section called'?)"
  record $e_old "FULL what Esc printed after the old name"
```

**Twin:** `W1932_BROKEN_switch_off.case.txt`

```
# W1932_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). DELIBERATELY BROKEN copy of W1932: the PR's own switch CeMember.SectionListUsesSupplierNames is OFF before AutoCAD starts, so the list is the 1.0.125 list (310UB32, 410UB60, 530UB92). Same steps and the three supplier-name checks as W1932. Expected red: all three 'history count ... = 1' lines (the supplier names are not in the list, so 'no section called' prints instead).
# UNPROVEN: the SETTING line uses the FULL path and the key may not be in the file yet; if the runner refuses it this is BLOCKED, not red. Fallback twin: part 1 item 4. Do NOT add hashes-unchanged.
CASE W1932_BROKEN
TITLE BROKEN VARIANT of W1932: the supplier-names switch is OFF, so the list keeps the old names and the case still expects 310UB32.0, 410UB59.7 and 530UB92.4 (must FAIL)
PLAN_ITEM red-before-green proof for W1932 (BUG-1132, PR #1932)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 883
TIMEOUT 600
BUG BUG-1132
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1932
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json CeMember.SectionListUsesSupplierNames false
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the three supplier names are not in the list, so no 'Pick point 1 of 310UB32.0' (and the other two) appears.
WHY_NOT_UNIT_TEST It exists only to prove W1932's checks can go red.
STEPS
  settings-arm
  copy-info -> $copy0
  ms-count -> $c0
  type "CEMEMBER{NL}{NL}310UB32.0{NL}{NL}" -Force -TimeoutSec 90 -> $t_a
  esc-prompt -> $e_a
  type "CEMEMBER{NL}{NL}410UB59.7{NL}{NL}" -Force -TimeoutSec 90 -> $t_b
  esc-prompt -> $e_b
  type "CEMEMBER{NL}{NL}530UB92.4{NL}{NL}" -Force -TimeoutSec 90 -> $t_c
  esc-prompt -> $e_c
  wait
  ms-count -> $c1
ASSERT
  history count "Pick point 1 of 310UB32.0" = 1
  history count "Pick point 1 of 410UB59.7" = 1
  history count "Pick point 1 of 530UB92.4" = 1
  equals $c1 $c0
  record $t_a "FULL what 310UB32.0 printed with the switch OFF"
```

---

## 3. Codex look notes (BLOCKED-FOR-ROBOT)

Common rules for every look: use a COPY of a drawing, never Tim's job drawing; AutoCAD must have the Structural build that holds the PR (the installed 1.0.125 has none of these fixes); take the screenshots yourself and save them under `C:\CE_WORK\codex\<look name>\` (one folder per look); never accept or capture a folder a file box opened in. If a look needs the switch OFF, set it by hand in the Structural settings before AutoCAD starts and put the file back afterwards. Every window word below marked DERIVED comes from the PR text, not from a run.

### Look A: #1902 (B-082, BUG-1126, BUG-1131), SBEAM window figures and length in millimetres. BLOCKED-FOR-ROBOT

1. **Why the robot cannot.** The SBEAM section window is not on the driver's read list, so the robot cannot read it, and the length box is a typed field. (Not a refused button, but a window that is not listed.)
2. **Steps.** Evidence folder `C:\CE_WORK\codex\look_1902`. Type SBEAM. In the list pick 40 x 40 x 3 EA. Screenshot the properties.
3. **Right looks like (DERIVED from the PR text).** Ix reads 0.04 (the old build showed 0). Pick 75 PFC: Iy reads 0.14. Pick the angle with 1.12 kg/m: it reads 1.12. A figure of 10 or more keeps one decimal.
4. **Length.** Pick 310UB32. In "Optional member length" type 6000. Right looks like: the weight reads about 192 kg and the weight line says "(length read as 6000 mm)". Then type 6 (metres): about 192 kg again, and no "read as mm" wording. Type 100: read as metres (the threshold is "over 100").
5. **Switch off.** Set `Options.SbeamPickerThreeSignificantFigures` and `Options.SbeamLengthOverThresholdIsMillimetres` to false, restart AutoCAD, repeat: Ix reads 0 and 6000 gives 192000 kg (the old behaviour).

### Look B: #1903 (B-083, BUG-1123), XCLMTXT applies an office spelling for a UB or UC size. BLOCKED-FOR-ROBOT

1. **Why the robot cannot.** XCLMTXT takes its cells from an Excel table and needs a MEMBERS.csv office file, and the robot cannot open a table, choose a file or press an export or save button. UNKNOWN: exactly how XCLMTXT is fed; I saw only that the command exists (`ExcelMTextCommands.cs` line 81) and did not read the service in full.
2. **Steps.** Evidence folder `C:\CE_WORK\codex\look_1903`. Use a TEST copy of the office MEMBERS.csv, never the real one (how to point CE at a copy is not known; the desk must say, or Codex stops and asks). Add the row `250UB26` to `250 UB 25.7` to the copy. Make a one-cell Excel table holding `250UB26` and run XCLMTXT on it.
3. **Right looks like (DERIVED from the PR text).** The text in the drawing reads `250 UB 25.7`. On the old build it read `250 UB 26`. A cell `250UB26.5` is left alone.
4. **Switch off.** Set `Excel.OfficeSpellingBeforeSizeLock` to false before AutoCAD starts: `250 UB 26` (old behaviour).

### Look C: #1904 (B-083, BUG-1128), XCLMTXT writes PLATE for the word PL anywhere in a cell. BLOCKED-FOR-ROBOT

1. **Why the robot cannot.** Same as Look B (an Excel table is the input).
2. **Steps.** Evidence folder `C:\CE_WORK\codex\look_1904`. Run XCLMTXT on a table with four cells: `TOP PL & BOT PL`, `250 x 16 PL`, `PL1` and `SPLICE`.
3. **Right looks like (DERIVED from the PR text).** `TOP PLATE & BOT PLATE`, `250 x 16 PLATE`, `PL1` unchanged, `SPLICE` unchanged. The old build printed `TOP PLATE & BOT PL` and left the end-of-cell PL alone.
4. **Switch off.** `Excel.PlateWordEverywhere` false before AutoCAD starts: the old rule returns.

### Look D: #1905 (B-083, BUG-1122), SBEAM search finds a section by its XCLMTXT mass spelling; also the SBEAM list half of #1932. BLOCKED-FOR-ROBOT

1. **Why the robot cannot.** The SBEAM section window is not on the driver's read list, and the search box is typed text.
2. **Steps.** Evidence folder `C:\CE_WORK\codex\look_1905`. Type SBEAM and type 410UB59 in the search box, then 410UB60 and 410UB59.7, then 460UB75, 250UB25, then 410UB57 and 410UB59.2.
3. **Right looks like (DERIVED from the PR text).** The first three each list the 410UB60 section (real mass 59.7 kg/m, shown as 410UB59.7 if #1932 is also in); 460UB75 lists 460UB74; 250UB25 lists 250UB26. 410UB57 and 410UB59.2 list nothing, as before.
4. **For #1932 on the same window.** With #1932 in, the list shows 310UB32.0 where it showed 310UB32 (34 UB and UC rows renamed; 250UC73 is NOT renamed, held for Tim). Sizes and masses are unchanged. Search 310UB32 and record what the list shows (see FOR TIM item 4).
5. **Switch off.** `SbeamPicker.MatchMassSpelling` false before AutoCAD starts: 410UB59 lists nothing.

---

## 4. Fixes skipped and why

1. **None skipped as "already has a case".** No case or draft exists for any of the six.
2. **#1902, #1903, #1904, #1905:** BLOCKED-FOR-ROBOT, Codex looks above. #1902 and #1905 need the SBEAM window (not on the read list). #1903 and #1904 need an Excel table (and #1903 an office file).
3. **#1932 in part.** Drafted for the CEMEMBER typed-name route only. The old-beam redraw is not reachable by anyone until something calls it (the PR says so). The SBEAM list half is Look D.
4. **I did not use** a mid-case settings change, a second drawing, a typed table cell, a right-click menu item or any refused press.

---

## 5. What was read, built, tested, and what is NOT proven

1. **Read:** the files and PRs in part 1 item 1, and the cases folders and drafts for existing cases (part 1 item 2). Nothing in Tim's real settings files was opened. The Keys folder, `C:\CE_DrawingIntelligence` and AutoCAD were not touched.
2. **Built:** nothing. **Tested:** nothing. **Installed:** nothing. **Tim-accepted:** nothing.
3. **NOT proven:** that either case validates offline; that any prompt or printed line is exactly as DERIVED (first runs will need one or two fix-ups); that the Structural plugin with these PRs is installed in the robot's AutoCAD; that the runner accepts the Structural settings path in a SETTING line; that `310UB32` behaves as FOR TIM item 4 says; and everything in Looks A to D (window words are from the PR text only).
