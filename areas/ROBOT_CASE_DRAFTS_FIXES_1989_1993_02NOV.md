# Robot case drafts: fix PRs #1989 to #1993 (Mon 2 Nov 2026, evening Melbourne, read-only drafter, Sonnet)

**What this is.** Case drafts as plain text, each under the file name it should get. Nothing was built, tested, installed or opened in AutoCAD. No case file was created anywhere. This is the only file written.

---

## FOR TIM

1. **Seven robot case texts drafted, three of them twins that must fail.** BUG-1270 CDSYNC level text (W1270 and its twin), BUG-1092 shallow-fall wording (W1092D, its twin, and one guard for a level pipe), BUG-1269 Cascade Preview warnings (W1269 and its twin). Order numbers 760 to 766. Nothing has been run.
2. **Two items are Codex only: BUG-1271 (the clipped word "Downstre") and BUG-1092 red row (colour).** The robot reads a window's words and its buttons, not colour, and not whether a word fits its box. Exact Codex steps are K3_01 and K3_02 below.
3. **A clash between two of these fixes, found while reading them.** Fix #1992 (shallow-fall wording) and fix #1993 (red error row) each add a new Settings group with the same file name, `validation`, but as two different pieces of code. They cannot both go into the same build as they stand. One of them has to be changed so both switches sit in one `validation` group. This is for CE 05 and the release desk, not for you. I read both branches; I built nothing.
4. **BUG-1270 already has its "red" on record.** The robot read `IL 17.90` after CDSYNC on Civil 3.0.89 twice (runs of 2 Nov 1106 and 1219). So W1270 should FAIL on the build now installed and PASS only once the fix is in.
5. **BUG-1269 route:** it reuses the W655 junction drawing that already passed twice, and reads the Cascade Preview window's words before Apply. It presses Cancel, never Apply.
6. **Not verified:** every line marked DERIVED was read from reports and code, not seen on a run. The three new settings keys have not been tried through the robot's settings guard. CDRULES is not driven (see section 4 item 3). The robot's AutoCAD may not be on a build that contains these fixes.
7. **Nothing for you to test or decide.**

---

## 1. Facts checked, and where each came from

1. **PRs read with `gh pr view`:** #1990 (B-162, BUG-1270), #1992 (B-164, BUG-1092 wording), #1989 (B-161, BUG-1269), #1991 (B-163, BUG-1271), #1993 (B-165, BUG-1092 red row). All OPEN drafts, base `claude/rel-20261102a`. Reports read in full: `BUGFIX_w1270`, `w1092d`, `w655`, `w1271`, `w1092c` (all `_REPORT_02NOV.md`). Carpark entries BUG-1269 to BUG-1271 and the 2 Nov notes read.
2. **Switch names and files, read from each PR's `UserSettings.cs` diff** (all in `CD_Settings.json`, all default ON):
   1. `cdsync.keepsLevelTextFormat` (group `cdsync`, new).
   2. `validation.shallowFallStatesFigure` (group `validation`, new, class `ValidationSettings`).
   3. `preview.showsPlanWarnings` (group `preview`, new).
   4. `pipe.editCaptionsKeepFullWidth` (existing `pipe` group).
   5. `validation.errorRowsShowRed` (group `validation`, new, class `ValidationDisplaySettings`).
3. **The clash.** `git diff origin/claude/rel-20261102a...` for #1992 and #1993 both add `[JsonProperty("validation")] public ... Validation { get; set; }` to `UserSettings.cs`, with different classes. Two members of the same name will not compile together, and one JSON name cannot map to two classes. Nobody built the two together.
4. **The robot's route facts (read in `README_CASES.md`, the v2 and v3 allow-lists and earlier cases):**
   1. v3 `ui-dump` can read only windows named in `acad_driver_v3.allowlist.json`. "Cascade Preview" is on it (press Cancel or Close only). **"Design Warnings" is not on it** (it is only on the older v2 list, press OK, Close, Cancel). "Edit Pipe" is on it.
   2. A dump holds, per control: type, name, id, class, depth, enabled, offscreen and bounds. **No colour and no brush.** Read from the dump text in run `RUN-20261102-0458-C3.0.88-pjW05` (Cascade Preview record).
   3. The Cascade Preview dump of W655 on Civil 3.0.88 held "1 pipes, 2 pits — ready to apply" and NO control carrying the junction sentence (grep of `RUN-20261101-0935-C3.0.88-bW04`). The sentence shows only on the command line after Apply. That is the same fault Codex saw (S5-03).
   5. W655's drawing and levels: copied from the accepted case `W655_junction_outlet_follows_lowest_pipe` (PASS in `RUN-20261101-0935-C3.0.88-bW04` and `-1628-C3.0.88-cW05`, review VERDICT CLAUDE-ACCEPTED-READY for its part). The junction line there reads "Pit P83: pipe P82 -> P83 arrives at 17.90, lower than the 18.15 this change brings, so the pipe leaving the pit follows the lower level."
   6. W1270's route: copied from `PROBE-CDSYNC-BA` (it reproduced `IL 18.100 | IL 17.900` becoming `IL 18.100 | IL 17.90` twice on 3.0.89, carpark note 2 Nov 11:50 and 12:40).
   7. W1092D's route: the 2 m pipe from `PROBE-FLAT4` (150000,-80000 to 152000,-80000, levels 10.000 and 9.996). The line Codex saw on 3.0.89 after Start Pipe was "[CE] Warning: Pipe is essentially flat - no measurable fall". PROBE-FLAT4 was queued; I found no run report for it, so the exact history line the build prints on a clean route is not seen by me.
5. **Settings.** Main cases set nothing and prove the shipped default (ON), as Codex will. Twins set the one key to false through `SETTING CD_Settings.json <key> false` (settings are read at AutoCAD start). None of the three groups (`cdsync`, `validation`, `preview`) exists in today's settings file; the earlier twins used keys in groups that already existed. Whether the guard accepts a brand-new group is NOT verified. If it refuses, the twin is BLOCKED, not FAIL.

---

## 2. Case texts

**How these are written.** README_CASES.md format. Every `type` chain is a complete command with no `(` and no SAVE-type word. Fixture DRV1_B1, SLOT fresh. REVIEWED_AGAINST is empty. Run alone, outside Tim's hours. Validate first without AutoCAD: copy each block to its file in a new folder (suggested `cases\drafts_fixes_1989_1993_02nov\`, with the setup in `_setups`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`. No case unlocks a layer, detaches an Xref or bypasses a protection. Nothing is ever saved; every case reads `copy-unchanged`.

### Case 1 of 4: W1270 and W1270_BROKEN (#1990, BUG-1270 decimals half)

**Intended file:** `W1270_cdsync_keeps_three_decimal_levels.case.txt`

```
# W1270 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1990, B-162, BUG-1270 DECIMALS HALF (the P8 pit-depth half stays OPEN and is not touched). Switch cdsync.keepsLevelTextFormat, ON by default (this case sets nothing: it proves the shipped default).
# Route: PROBE-CDSYNC-BA unchanged (the 2 Nov probe that reproduced the fault twice on Civil 3.0.89, RUN-20261102-1106 and -1219): SETUP-P8v, then a pipe INTO P8 from 130000,-80000 to 150000,-80000 with levels 18.100 and 17.900, then CDSYNC as the ONLY command.
# Recorded fault on 3.0.89 (carpark, CE 05 11:50): 'IL 18.100 | IL 17.900' became 'IL 18.100 | IL 17.90'. So on the installed 3.0.89 this case must FAIL on the 'after' check; with the fix installed it must PASS.
# DERIVED, never read by a run: that the read joins the two texts in that order with ' | ' and holds only those two (it is the form the carpark note quotes); that CDSYNC creates no new object (the probe's second read used the same range).
CASE W1270
TITLE After CDSYNC alone, a pipe drawn with levels 18.100 and 17.900 still reads IL 18.100 and IL 17.900 (the third decimal is kept)
PLAN_ITEM PR #1990 (B-162, BUG-1270) PART: the level text format after CDSYNC alone. NOT whole: the P8 pit depth (1.00 to 1.10 m) is a separate open fault and is not read; the grade text (1 IN 100 against 1 IN 99) is not read
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8v
ORDER 760
TIMEOUT 1800
BUG BUG-1270
PROVES_BUGS BUG-1270 (the decimals half only)
REVIEWED_AGAINST
EXPECTED After the P8 setup and a new pipe into P8 with levels 18.100 and 17.900, its two level texts read IL 18.100 and IL 17.900. After CDSYNC alone they read exactly the same. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests prove the rule in isolation; only a live CDSYNC on a real linked pipe shows which text the drawing ends up with.
NOT_AUTOMATED The pit P8 depth cell and the check banner count (BUG-1270's other half). The grade text on the pipe label. A pit move (a real change must still be written: unit-tested only).
STEPS
  ms-count -> $n0
  type "CD{NL}130000,-80000{NL}150000,-80000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 120 -> $b_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.100"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $b_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $b_e1
  wait
  ms-new $n0 -> $new0
  select $new0 "text~^IL " -> $il0
  field $il0 text -All -> $il0_text
  type "CDSYNC" -Force -> $sync
  wait
  sleep 3
  ms-new $n0 -> $new1
  select $new1 "text~^IL " -> $il1
  field $il1 text -All -> $il1_text
  log-read civil -> $civlog
ASSERT
  equals $il0_text "IL 18.100 | IL 17.900"
  equals $il1_text "IL 18.100 | IL 17.900"
  equals $il1_text $il0_text
  copy-unchanged $copy0
  record $sync "FULL what CDSYNC printed"
  record $il0_text "ALL IL texts of the new pipe BEFORE CDSYNC"
  record $il1_text "ALL IL texts of the new pipe AFTER CDSYNC"
  record $civlog "FULL Civil log lines of this case"
```

**Twin:** `W1270_BROKEN_cdsync_keeps_three_decimal_levels.case.txt`

```
# W1270_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The switch-off twin: cdsync.keepsLevelTextFormat false before AutoCAD starts, so CDSYNC rewrites the lower level at two decimals as before. Same route, same checks as W1270. It must FAIL on 'equals $il1_text ...' and 'equals $il1_text $il0_text': the recorded old result is 'IL 18.100 | IL 17.90'. The 'before' check must still pass.
# If it PASSES, the switch did not reach the build (settings group refused or not read) or the fix is not what changes the text: stop and say so. If the settings guard refuses the new key cdsync.keepsLevelTextFormat, the case is BLOCKED, not FAIL.
CASE W1270_BROKEN
TITLE BROKEN VARIANT of W1270: the CDSYNC switch is OFF, so the level text loses its third decimal (must FAIL)
PLAN_ITEM red-before-green proof for W1270 (PR #1990, B-162, BUG-1270)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8v
SETTING CD_Settings.json cdsync.keepsLevelTextFormat false
ORDER 761
TIMEOUT 1800
BUG BUG-1270
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1270
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the text after CDSYNC reads IL 17.90, so the two 'after' checks fail; the 'before' check and the unchanged-file check pass.
WHY_NOT_UNIT_TEST It exists only to prove W1270's checks can go red.
STEPS
  ms-count -> $n0
  type "CD{NL}130000,-80000{NL}150000,-80000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 120 -> $b_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.100"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $b_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $b_e1
  wait
  ms-new $n0 -> $new0
  select $new0 "text~^IL " -> $il0
  field $il0 text -All -> $il0_text
  type "CDSYNC" -Force -> $sync
  wait
  sleep 3
  ms-new $n0 -> $new1
  select $new1 "text~^IL " -> $il1
  field $il1 text -All -> $il1_text
ASSERT
  equals $il0_text "IL 18.100 | IL 17.900"
  equals $il1_text "IL 18.100 | IL 17.900"
  equals $il1_text $il0_text
  copy-unchanged $copy0
  record $il0_text "ALL IL texts of the new pipe BEFORE CDSYNC, switch OFF"
  record $il1_text "ALL IL texts of the new pipe AFTER CDSYNC, switch OFF (expected IL 17.90 at the lower end)"
```

### Case 2 of 4: W1092D, W1092D_BROKEN and W1092D_LEVEL (#1992, BUG-1092 downhill wording)

**Intended file:** `W1092D_shallow_fall_states_its_figure.case.txt`

```
# W1092D DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1992, B-164, BUG-1092 DOWNHILL WORDING HALF (wording only; BUG-1092 stays open; the uphill rule is PR #1887 and is not touched). Switch validation.shallowFallStatesFigure, ON by default (this case sets nothing).
# Route: the 2 m pipe of PROBE-FLAT4 (150000,-80000 to 152000,-80000), but with 'Set my own' grade 1 in 500 and the pipe label OFF (so the 'Snap callout arrow to pipe' prompt that spoilt Codex's B1-06c run does not appear and the typed 4 mm fall agrees with the typed grade). Levels 10.000 then 9.996 (4 mm over 2.0 m = 1 in 500).
# The line is read from the command line after Start Pipe (that is where Codex saw '[CE] Warning: Pipe is essentially flat - no measurable fall' on 3.0.89). DRIVEN BY CDRULES? NO: see the PLAN_ITEM line. DERIVED, never read by a run: that the new sentence prints at Start Pipe on this route and in this form after '[CE] Warning: ', and that history-tail holds it.
# DERIVED: control ids C2.IsGradeCustom and C2.CustomGrade are the ones W1888 (Codex-proven route) used.
CASE W1092D
TITLE A 2 m pipe with levels 10.000 and 9.996 says 'Very shallow fall: 4 mm over 2.0 m, 1 in 500' and no longer says 'no measurable fall'
PLAN_ITEM PR #1992 (B-164, BUG-1092 downhill half) PART: the sentence printed when the pipe is made. NOT whole: CDRULES is not driven, so whether that command prints the same sentence is not checked; the Design Warnings window is not read (it is not on the robot's read list); the 5 mm band and whether a downhill fall inside it should warn at all is Tim's open engineering question
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 762
TIMEOUT 1200
BUG BUG-1092
PROVES_BUGS BUG-1092 (the downhill wording half only)
REVIEWED_AGAINST
EXPECTED CD from 150000,-80000 to 152000,-80000, New Pipe with Set my own 1 in 500, levels 10.000 and 9.996, pipe label off, Start Pipe. The command line carries 'Very shallow fall: 4 mm over 2.0 m, 1 in 500' and does NOT carry 'no measurable fall'. No Grade mismatch window is left open. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests pin the sentence from the checker; only a live pipe shows what the drafter's command line prints.
NOT_AUTOMATED CDRULES and the Design Warnings window. A truly level pipe (W1092D_LEVEL). A fall under 0.5 mm. An uphill pipe (PR #1887).
STEPS
  copy-info -> $copy0
  type "CD{NL}150000,-80000{NL}152000,-80000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 120 -> $a1
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "500"
  ui2-set "New Pipe" "C2.FirstInvert" "10.000"
  ui2-set "New Pipe" "C2.SecondInvert" "9.996"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $a2
  await-window-gone "^New Pipe" -Secs 120
  sleep 3
  windows-snapshot -> $w1
  history-tail -> $h1
  esc-prompt -> $e1
  wait
ASSERT
  contains $h1 "Very shallow fall: 4 mm over 2.0 m, 1 in 500"
  not-contains $h1 "no measurable fall"
  history has "Very shallow fall: 4 mm over 2.0 m, 1 in 500"
  not-contains $w1 "Grade mismatch"
  copy-unchanged $copy0
  record $h1 "FULL command history after Start Pipe"
  record $w1 "FULL windows after Start Pipe"
```

**Twin:** `W1092D_BROKEN_shallow_fall_states_its_figure.case.txt`

```
# W1092D_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The switch-off twin: validation.shallowFallStatesFigure false before AutoCAD starts, so the old words return. Same route, same checks as W1092D. It must FAIL on the two checks that need the new sentence; the PR says OFF gives the old text exactly ('Pipe is essentially flat - no measurable fall').
# If it PASSES, the sentence is not coming from this switch: stop and say so. If the settings guard refuses the new group validation, the case is BLOCKED, not FAIL. NOTE: #1993 adds a second class under the same JSON name validation (see FOR TIM item 3); the twin as written only works once that is resolved.
CASE W1092D_BROKEN
TITLE BROKEN VARIANT of W1092D: the wording switch is OFF, the old 'no measurable fall' returns (must FAIL)
PLAN_ITEM red-before-green proof for W1092D (PR #1992, B-164, BUG-1092)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json validation.shallowFallStatesFigure false
ORDER 763
TIMEOUT 1200
BUG BUG-1092
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1092D
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the line reads 'Pipe is essentially flat - no measurable fall', so the new-sentence checks and the 'no measurable fall' absence check fail; the unchanged-file check passes.
WHY_NOT_UNIT_TEST It exists only to prove W1092D's checks can go red.
STEPS
  copy-info -> $copy0
  type "CD{NL}150000,-80000{NL}152000,-80000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 120 -> $a1
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "500"
  ui2-set "New Pipe" "C2.FirstInvert" "10.000"
  ui2-set "New Pipe" "C2.SecondInvert" "9.996"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $a2
  await-window-gone "^New Pipe" -Secs 120
  sleep 3
  windows-snapshot -> $w1
  history-tail -> $h1
  esc-prompt -> $e1
  wait
ASSERT
  contains $h1 "Very shallow fall: 4 mm over 2.0 m, 1 in 500"
  not-contains $h1 "no measurable fall"
  history has "Very shallow fall: 4 mm over 2.0 m, 1 in 500"
  copy-unchanged $copy0
  record $h1 "FULL command history after Start Pipe, switch OFF (expected the old words)"
```

**Guard (no twin: it passes with the switch on or off):** `W1092D_LEVEL_level_pipe_keeps_old_words.case.txt`

```
# W1092D_LEVEL DRAFT (Mon 2 Nov 2026; NOT RUN). A guard, not a proof of the fix: a pipe drawn with equal levels 10.000 and 10.000 keeps the old words 'essentially flat' (PR #1992 item 2: a level pipe keeps them). It passes with the switch ON and OFF, so it needs no twin and proves nothing about the fix.
# RISK, not known: an equal-level typed pipe may open a Grade mismatch window (grade 1 in 500 against a fall of zero), or print a different flat-pipe line (BUG-1040 FlatPipeIsWarningOnly). I never saw this route run. The windows read is recorded so the desk can see; if a window blocks the Start Pipe wait, the case is BLOCKED.
CASE W1092D_LEVEL
TITLE A level 2 m pipe (levels 10.000 and 10.000) keeps the words 'essentially flat' and never says 'Very shallow fall'
PLAN_ITEM PR #1992 (B-164, BUG-1092) PART: the unchanged side of the wording. Guard only
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 764
TIMEOUT 1200
BUG BUG-1092
REVIEWED_AGAINST
EXPECTED CD from 150000,-84000 to 152000,-84000 with Set my own 1 in 500 and equal levels 10.000: the command line carries 'essentially flat' and not 'Very shallow fall'. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST Reads the live command line.
NOT_AUTOMATED A fall under 0.5 mm and a small uphill inside the band (both keep the old words per the PR; unit-tested only).
STEPS
  copy-info -> $copy0
  type "CD{NL}150000,-84000{NL}152000,-84000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 120 -> $a1
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "500"
  ui2-set "New Pipe" "C2.FirstInvert" "10.000"
  ui2-set "New Pipe" "C2.SecondInvert" "10.000"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $a2
  sleep 5
  windows-snapshot -> $w1
  history-tail -> $h1
  esc-prompt -> $e1
  wait
ASSERT
  contains $h1 "essentially flat"
  not-contains $h1 "Very shallow fall"
  copy-unchanged $copy0
  record $h1 "FULL command history after Start Pipe (level pipe)"
  record $w1 "FULL windows after Start Pipe (a Grade mismatch window here would explain a red)"
```

### Case 3 of 4: W1269 and W1269_BROKEN (#1989, BUG-1269 Cascade Preview)

**Intended setup file** (`cases\_setups\SETUP-W655J.setup.txt`): the W655 drawing of the accepted case, steps copied unchanged, so the two cases below share one build of it.

```
# SETUP-W655J (Mon 2 Nov 2026; NOT RUN). The drawing of the accepted case W655, copied unchanged (PASS in RUN-20261101-0935-C3.0.88-bW04 and -1628-C3.0.88-cW05): four made-up pits P81 to P84 (cover 19.000) and three 100 mm pipes with typed levels: P81 -> P83 18.050 / 17.950, P82 -> P83 18.000 / 17.900, P83 -> P84 17.880 / 17.780. Two pipes arrive at P83, so a raise of P81 -> P83 meets a lower arriving pipe at the junction. Sets $copy0, $c0 and $hAC (the handle of the pipe P81 -> P83).
SETUP SETUP-W655J
STEPS
  copy-info -> $copy0
  type "_.ZOOM _W 146000,-78000 174000,-56000" -Force
  wait
  ms-count -> $c0
  type "PIT{NL}150000,-64000" -Force -ExpectWindow "New Pit" -TimeoutSec 120 -> $a_t1
  ui2-set "New Pit" "C2.PitNumber" "P81"
  ui2-set "New Pit" "C2.CoverLevel" "19.000"
  ui-press "New Pit" "New pit, Continue placement" -> $a_t2
  await-window-gone "^New Pit" -Secs 120
  esc-prompt -> $a_e1
  esc-prompt -> $a_e2
  esc-prompt -> $a_e3
  wait
  type "PIT{NL}160450,-74450" -Force -ExpectWindow "New Pit" -TimeoutSec 120 -> $b_t1
  ui2-set "New Pit" "C2.PitNumber" "P82"
  ui2-set "New Pit" "C2.CoverLevel" "19.000"
  ui-press "New Pit" "New pit, Continue placement" -> $b_t2
  await-window-gone "^New Pit" -Secs 120
  esc-prompt -> $b_e1
  esc-prompt -> $b_e2
  esc-prompt -> $b_e3
  wait
  type "PIT{NL}160450,-64000" -Force -ExpectWindow "New Pit" -TimeoutSec 120 -> $c_t1
  ui2-set "New Pit" "C2.PitNumber" "P83"
  ui2-set "New Pit" "C2.CoverLevel" "19.000"
  ui-press "New Pit" "New pit, Continue placement" -> $c_t2
  await-window-gone "^New Pit" -Secs 120
  esc-prompt -> $c_e1
  esc-prompt -> $c_e2
  esc-prompt -> $c_e3
  wait
  type "PIT{NL}170900,-64000" -Force -ExpectWindow "New Pit" -TimeoutSec 120 -> $d_t1
  ui2-set "New Pit" "C2.PitNumber" "P84"
  ui2-set "New Pit" "C2.CoverLevel" "19.000"
  ui-press "New Pit" "New pit, Continue placement" -> $d_t2
  await-window-gone "^New Pit" -Secs 120
  esc-prompt -> $d_e1
  esc-prompt -> $d_e2
  esc-prompt -> $d_e3
  wait
  ms-count -> $cAC
  type "CD{NL}150000,-64000{NL}160450,-64000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd1
  ui2-set "New Pipe" "C2.Diameter" "100"
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.FirstInvert" "18.050"
  ui2-set "New Pipe" "C2.SecondInvert" "17.950"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $st1
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $cd1_e
  wait
  ms-new $cAC -> $newAC
  select $newAC "object~^CeCvlPipeObject$" -> $pAC
  field $pAC handle -> $hAC
  type "CD{NL}160450,-74450{NL}160450,-64000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd2
  ui2-set "New Pipe" "C2.Diameter" "100"
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $st2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $cd2_e
  wait
  type "CD{NL}160450,-64000{NL}170900,-64000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd3
  ui2-set "New Pipe" "C2.Diameter" "100"
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.FirstInvert" "17.880"
  ui2-set "New Pipe" "C2.SecondInvert" "17.780"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $st3
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $cd3_e
  wait
  windows-snapshot -> $win_built
```

**Intended file:** `W1269_cascade_preview_lists_plan_warnings.case.txt`

```
# W1269 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1989, B-161, BUG-1269 (carpark stays OPEN). Switch preview.showsPlanWarnings, ON by default (this case sets nothing: it proves the shipped default).
# Route: Codex S5-03 (W655, which saw NO warning in the preview on 3.0.88/3.0.89). Same drawing and edit as the accepted W655: Edit Pipe on P81 -> P83, levels 18.25 and 18.15, Save, answer Yes to the Recalculate box, and the Cascade Preview opens. THIS CASE READS THE PREVIEW AND THEN PRESSES CANCEL. It never presses Apply, so the cascade is not applied.
# What is read: the window's own words (v3 ui-dump of 'Cascade Preview'). On 3.0.88 that dump held '1 pipes, 2 pits — ready to apply' and NO control carrying the junction sentence (run bW04). With the fix the sentence is one line in a list under the tables.
# DERIVED, never read by a run: that the new list's text shows as a control in the dump named by the sentence (WPF text blocks appear that way elsewhere in the same dump); that the arrow in 'P82 -> P83' may be a different character in the window than on the command line (the regex allows any non-space characters there); that a collapsed list (switch OFF) is not in the dump; that the Apply button is named 'Apply' in the dump (the v2 press list and R11 use that name) and is enabled; that one extra control keeps the dump under its size limit (the W655 dump was 121 controls, not truncated).
# NOT read: the colour of the line, whether any label is hidden, and the scroll on a long list. Those are Codex look K3_03.
CASE W1269
TITLE The Cascade Preview window lists the junction warning (pipe P82 arrives lower than the 18.15 this change brings) before Apply, and Apply stays available
PLAN_ITEM PR #1989 (B-161, BUG-1269) PART: the warning sentence is in the preview window's own words and Apply is still enabled. NOT whole: the colour, a hidden label, the scroll box and a window with several warnings are Codex look K3_03; Apply is not pressed
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-W655J
SETTING CD_Settings.json linking.cascadeKeepsPitDrop true
SETTING CD_Settings.json linking.cascadeRelinksOnlyPlanPipes true
ORDER 765
TIMEOUT 2400
BUG BUG-1269
PROVES_BUGS BUG-1269 (the sentence appears in the window; the colour half is Codex)
REVIEWED_AGAINST
EXPECTED With the W655 drawing built, CDEDIT on pipe P81 -> P83 with levels 18.25 and 18.15, Edit pipe, Save, the Recalculate box answered Yes, the Cascade Preview opens and its words include 'Pit P83: pipe P82 -> P83 arrives at 17.90, lower than the 18.15 this change brings, so the pipe leaving the pit follows the lower level.' as well as the summary line 'ready to apply'. The Apply button exists and is enabled. Cancel closes the window; no Cascade Preview, Edit Pipe or Design Warnings window is left open. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests read the window's source text and the list in the view model; only a live window shows that the sentence is really drawn.
NOT_AUTOMATED Colour and look (K3_03). Apply (the cascade result is W655's and is not repeated). A plan with two or more warnings, a long list and its own scroll.
STEPS
  pick-first "{$hAC}"
  type "CDEDIT" -Force -ExpectWindow "Edit Pipe" -TimeoutSec 120 -> $ed
  ui2-set "Edit Pipe" "C2.FirstInvert" "18.25"
  ui2-set "Edit Pipe" "C2.SecondInvert" "18.15"
  ui-press "Edit Pipe" "Edit pipe, Save" -> $save
  sleep 4
  msgbox-answer "*Recalculate*" Yes
  sleep 3
  ui-dump "Cascade Preview" -TimeoutSec 60 -> $cp
  ui-press "Cascade Preview" "Cancel"
  await-window-gone "Cascade Preview" -Secs 60
  wait
  windows-snapshot -> $win_end
ASSERT
  not-contains $win_built "Grade mismatch"
  matches $cp "Pit P83: pipe P82 \S+ P83 arrives at 17\.90, lower than the 18\.15 this change brings, so the pipe leaving the pit follows the lower level\."
  matches $cp "ready to apply"
  control $cp "Apply" enabled
  not-contains $win_end "Cascade"
  not-contains $win_end "Edit Pipe"
  not-contains $win_end "Design Warnings"
  copy-unchanged $copy0
  record $cp "FULL Cascade Preview before Cancel"
  record $win_end "FULL windows at the end"
```

**Twin:** `W1269_BROKEN_cascade_preview_lists_plan_warnings.case.txt`

```
# W1269_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The switch-off twin: preview.showsPlanWarnings false before AutoCAD starts, so the list is collapsed and the window is as before the fix. Same route, same checks as W1269. It must FAIL on the sentence check ONLY; the summary line, the Apply button and the closing checks must still pass (the PR says OFF leaves the window exactly as it was, Apply included).
# If it PASSES, the sentence is in the window with the switch off (the switch is not what hides it) or the dump reads a hidden control: stop and say so. If the settings guard refuses the new group preview, the case is BLOCKED, not FAIL.
CASE W1269_BROKEN
TITLE BROKEN VARIANT of W1269: the preview-warnings switch is OFF, the junction sentence is not in the window (must FAIL)
PLAN_ITEM red-before-green proof for W1269 (PR #1989, B-161, BUG-1269)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-W655J
SETTING CD_Settings.json linking.cascadeKeepsPitDrop true
SETTING CD_Settings.json linking.cascadeRelinksOnlyPlanPipes true
SETTING CD_Settings.json preview.showsPlanWarnings false
ORDER 766
TIMEOUT 2400
BUG BUG-1269
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1269
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the window shows the tables and 'ready to apply' only, so the junction sentence check fails; the summary, Apply-enabled, window-closed and unchanged-file checks pass.
WHY_NOT_UNIT_TEST It exists only to prove W1269's sentence check can go red.
STEPS
  pick-first "{$hAC}"
  type "CDEDIT" -Force -ExpectWindow "Edit Pipe" -TimeoutSec 120 -> $ed
  ui2-set "Edit Pipe" "C2.FirstInvert" "18.25"
  ui2-set "Edit Pipe" "C2.SecondInvert" "18.15"
  ui-press "Edit Pipe" "Edit pipe, Save" -> $save
  sleep 4
  msgbox-answer "*Recalculate*" Yes
  sleep 3
  ui-dump "Cascade Preview" -TimeoutSec 60 -> $cp
  ui-press "Cascade Preview" "Cancel"
  await-window-gone "Cascade Preview" -Secs 60
  wait
  windows-snapshot -> $win_end
ASSERT
  matches $cp "Pit P83: pipe P82 \S+ P83 arrives at 17\.90, lower than the 18\.15 this change brings, so the pipe leaving the pit follows the lower level\."
  matches $cp "ready to apply"
  control $cp "Apply" enabled
  not-contains $win_end "Cascade"
  not-contains $win_end "Edit Pipe"
  copy-unchanged $copy0
  record $cp "FULL Cascade Preview before Cancel, switch OFF"
```

### Case 4 of 4: #1991 and #1993 (no robot case: BLOCKED-FOR-ROBOT)

**No case text is written for these two.** The reasons are in section 4 and the Codex look notes are in section 3. Order numbers 767 to 769 are left free.

---

## 3. Codex look notes (the robot cannot prove these; each is a short recipe for a Codex pass in real AutoCAD on a copy)

1. **K3_01, BUG-1271 (PR #1991): the first caption beside the level box shows "Downstream" in full.**
   1. Open a copy of a drawing with one CE pipe (a new empty-ground copy and one pipe made by `CD` is enough). Select the pipe, type `CDEDIT`. If AutoCAD asks the older-version question, answer Y.
   2. Do not touch the window. Wait 10 seconds with the window at normal size (do not maximise, do not resize). This is the moment the clip was seen (S8-03-R2z).
   3. Look at the "Invert levels" rows: the word beside the first level box. Expect "Downstream" (or "Upstream", whichever the flow wording is) with every letter visible, not "Downstre".
   4. Take a picture of that row. Close the window with Cancel without saving.
   5. Do the same with `CD` and two points (the New Pipe window uses the same layout).
   6. Control (optional, ask the desk): `pipe.editCaptionsKeepFullWidth` false before launch; the caption may read "Downstre" again.
   7. Not claimed: the other clipped word in the carpark (UX finding 50, "Staff ente...") is a different text and is not part of this fix.
2. **K3_02, BUG-1092 (PR #1993): the uphill ERROR row in Design Warnings is red; a plain warning row stays amber.**
   1. Open a copy of a drawing on Civil 3.0.89 or later. Type `CD`, two points 2 m apart (for example 150000,-80000 and 152000,-80000). In New Pipe type levels 10.000 and 10.006 (6 mm uphill, outside the 5 mm band, which is an Error on this line), pipe text off. Press Start Pipe. Esc once.
   2. If the Design Warnings window opens (Codex saw it in B1c), look: the row "Pipe flows uphill ..." has a RED bullet and RED words.
   3. Make a second pipe that only warns (levels 10.000 and 9.996, "Set my own" grade 500). In its Design Warnings window the row stays amber with white words.
   4. Look at the footer. It still reads "Warnings are informational - the pipe has been saved." under a red row. That sentence is wrong for an error row (a question for Tim, not changed by this fix; just record what is seen).
   5. Close with OK or Close. Do not save.
   6. Control: `validation.errorRowsShowRed` false before launch; the uphill row is amber again. Note: a build that holds both #1992 and #1993 needs the settings clash in FOR TIM item 3 resolved first.
3. **K3_03, BUG-1269 (PR #1989): the new warning line in Cascade Preview reads as a warning.**
   1. Build the W655 drawing (SETUP-W655J) on a copy, or use a copy where it exists. Select pipe P81 -> P83, type `CDEDIT`, set levels 18.25 and 18.15, Save, answer Yes.
   2. Look at the Cascade Preview: under the pipe and pit tables there is a line in the warning colour (orange-yellow): "Pit P83: pipe P82 ... arrives at 17.90, lower than the 18.15 this change brings, so the pipe leaving the pit follows the lower level." Nothing is hidden or cut off (Codex saw the P82 end text hidden in the DRAWING in S5-03; check whether it is the drawing or the window). Apply is still pressable.
   3. Take a picture. Press Cancel (not Apply) if the cascade result is not needed.
   4. Control: `preview.showsPlanWarnings` false before launch; no list under the tables.

---

## 4. Skipped items and why

1. **#1991 BUG-1271 (caption clipped): BLOCKED-FOR-ROBOT.**
   1. The robot's window read gives each control's words and its size in the dump, but no step compares one control's width with the width its text needs, so it cannot say "clipped".
   2. A regex over the dump's text could read a width, but the window holds at least four captions with the words "Downstream" and "Upstream" (the DRAFTING "IL labels" captions use the same words, as the w1271 report found), so a text match cannot tell the caption beside the level box from the others.
   3. The fault appeared only in the first layout, 10 seconds after open. A robot read of a settled window would not show that moment, and I did not find a way for it to reproduce the first layout.
   4. I did not invent a verb. A record-only probe (dump Edit Pipe and record the size of every control named "Downstream") would let the desk judge whether a size rule is possible. Not drafted: it would judge nothing.
2. **#1993 BUG-1092 red row: BLOCKED-FOR-ROBOT.** The dump carries no colour. "Design Warnings" is also not on the v3 read list (only the older v2 list, press OK or Close). The window would open but could not be dumped. Reading "flows uphill" in it would test #1887's wording, not #1993's colour.
3. **CDRULES for #1992.** Your brief names CDRULES; I did not drive it. The line Codex saw on 3.0.89 printed at Start Pipe, and the PR report says "then the design check (CDRULES)" without a quoted CDRULES line. I did not read the code to confirm that CDRULES prints the same sentence, and `CDRULES All` saves its findings to a text file the robot has no verb to read (memory note, 20 Oct). If CE 02 shows that CDRULES prints the sentence on the command line, add one `type "CDRULES" -Force` step and a `history has` check after Start Pipe.
4. **Grade text for #1990.** The report says the grade text could move from 1 IN 100 to 1 IN 99. W1270 does not read it: the probe route draws no pipe label, and turning the label on adds the "Snap callout arrow to pipe" prompt that spoilt Codex's B1-06c run. Left as NOT_AUTOMATED.
5. **A real "Apply" in W1269.** Left out on purpose: the cascade result is W655's job and is already accepted. Cancel keeps the case short and keeps the drawing nearer to its start.
6. **Level-pipe and small-uphill controls for #1992** beyond W1092D_LEVEL: the small-uphill and sub-0.5 mm lines are unit-tested only and I did not draft routes for them.

---

## 5. What was read, built, tested, and what is NOT proven

1. **Read:** `C:\TimOS\RULES.md`; `README_CASES.md` in full; `ROBOT_CASE_DRAFTS_BUG1195_UCS_02NOV.md` (latest style); the five `BUGFIX_*_REPORT_02NOV.md` reports; `gh pr view` for #1989 to #1993; the `UserSettings.cs` diff of each of the five PR branches; the carpark entries BUG-1269, BUG-1270, BUG-1271 and the notes of 2 Nov; the v2 and v3 allow-lists; the cases `PROBE-CDSYNC-BA`, `PROBE-FLAT4`, `W655`, `W655_BROKEN`, `W658`, `R11`, `N50`; the runner reports `bW04` and `pjW05` for the Cascade Preview dump; DESK_LOG lines on B1-06c and S5-03. **Not read in full:** `ROBOT_CASE_DRAFTS_TOP12_30OCT.md` (the latest-style file was used instead); the C# code behind each fix (read through the PR text and reports only); the runner code for how `matches` or `control` treat a dump.
2. **Built:** nothing. **Tested:** nothing. No case was validated with `case_runner.ps1 validate`; first runs may need small fix-ups. No AutoCAD, no robot, no settings file touched, no git write (only `git fetch` and `git diff`). I added the GitHub CLI folder to my own shell's PATH to run `gh`; nothing else changed.
3. **NOT proven:**
   1. Every line marked DERIVED.
   2. That the new sentence in #1992 prints at Start Pipe on this route, and the wording of the history line around it.
   3. That the Cascade Preview dump shows the new list as a named control, and that "Apply" is the button's name there.
   4. That the settings guard accepts the three new groups `cdsync`, `validation` and `preview`.
   5. That DRV1_B1 has clear ground at 150000..152000 by -84000..-80000 and at 130000,-80000 (it holds 1034 objects; the probes used the same points on it and ran).
   6. That the robot's AutoCAD runs a build with these fixes: the installed Civil 3.0.89 does NOT contain them (all five PRs are open drafts), so the main cases are expected to FAIL there and the twins to behave like the old build.
   7. That W1269's Cancel leaves the drawing clean (an earlier case always pressed Apply); the `not-contains $win_end "Cascade"` check and `copy-unchanged` are the guards.
4. **A mismatch to know about:** the clash between #1992 and #1993 (FOR TIM item 3). I read both diffs but did not merge them to see whether Git reports a conflict or a silent duplicate member; either way the two do not stand together.
