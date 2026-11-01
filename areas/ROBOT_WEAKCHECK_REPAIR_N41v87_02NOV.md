# Robot weak-check repair: N41v87 (BUG-372, CDCHECK wording after a MOVE and a STRETCH)

Drafted by Sonnet (Team, read-only drafting) for CE 05 at CE 00's request, Mon 2 Nov 2026, Melbourne time. Nothing was run, built, installed or pushed. No case file was changed; the repaired text below is a draft for CE 05 to place and validate.

## FOR TIM

1. **What the case claims:** after a pit is moved and a new pipe's open end is stretched 2000 mm, the CDCHECK report still talks in words ("Pipe 450") and never shows a raw code like "handle 109359" or "CE-CIV-PIPE-...".
2. **Verdict: PART-strong, not whole.** The "no handle, no CE-CIV code" half is already proven properly: the switch-off twin goes red on exactly those two lines (run GaQ3, 31 Oct). The other half is weak.
3. **The weak line:** `history has "is not connected"` (check 5). It passes on a pipe end that belongs to the drawing's own fixture ("Pipe end 1. Pipe 450 ..."), so it says nothing about the pipe that was stretched. The same drawing prints 22 or more such lines.
4. **Second gap, already patched 1 Nov 21:48 by CE 02 but never run:** the original BUG-372 wording ("pipe 11C807 start invert text") has a bare code with no word "handle", so `history absent "handle "` could never catch it. The new `matches $h_all` line covers it. Nothing can make that line go red on purpose: the switch does not control that wording, so it has no red twin. It stays a guard only.
5. **The repair:** read the stretched pipe's own code while the robot runs, then check that code appears nowhere on the command line, and that every "Pipe end" line reads in words. The twin gets the same lines and must go red on them. This is a PART claim: it does not prove the "Drawing Border" wording (that is recorded only), the Checks window or the CSV.
6. **Not proven yet (I did not run anything):** whether the robot can put the pipe's code into a check (marked DERIVED below, CE 05 must validate it offline first); if it cannot, use the Codex look steps at the end for that one line.

---

## Below the line: detail for CE 05 and the desk

### 1. What was read

1. **Case files:** `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_v387_30oct\N41_cdcheck_words_after_stretch_and_movev87.case.txt` (current, with CE 02's 1 Nov bare-handle line), its `.pre_weakfix` backup, the twin `N41_cdcheck_words_after_stretch_and_move_BROKENv87.case.txt` and the review file `N41_..._movev87.review.txt` (Opus-Team-C78rev-B, 1 Nov 08:15).
2. **Setup:** `_setups\SETUP-R47v.setup.txt` (pit P3 moved up 2000 mm, new pit P8 at 150000,-80000, new pipe to the open end 170000,-80000, levels 18.000 and 17.800).
3. **Format:** `cases\README_CASES.md`. **Reports:** `runner-reports\RUN-20261031-1832-C3.0.88-GaQ3` (s1 PASS, s2 the twin FAIL as meant) and `RUN-20261031-2329-C3.0.88-GbQ3` (PASS). **Review:** `C78_REVIEW_B_REPORT.md` case 10 (ACCEPT PART; "check 5 is met by the fixture's own open ends").
4. **Not read:** `REGRESSION_LOG` / PR 1835 text itself (the case header and review quote it; I did not open the PR). I did not run `git fetch` results through to a diff of rel-20261102a, so I have not confirmed the wording is unchanged on that branch.

### 2. What the case proves today (from the recorded runs)

1. GaQ3 s1 (3.0.88+3fbb9da5) PASS: STRETCH found, end level text near the stretched end, one new pipe, "[CE] CDCHECK:" summary, and no "handle ", "CE-CIV-PIPE-", "CE-CIV-PIT-", "U+2192", "\U+" in the lines read.
2. GaQ3 s2 twin FAIL for the right reason: checks 6 and 7 went red on "Pipe 450 (handle 109359)" and "CE-CIV-PIPE-6A33...". The controls (STRETCH, IL text, one pipe, summary, "is not connected") passed.

### 3. The exact weak lines

1. **`history has "is not connected"` (check 5).** The recorded evidence line is `[CE] Pipe end 1. Pipe 450: one end is not connected (the start).` That is a fixture pipe, not the new pipe (new pipe handle 11C651 in GbQ3). The report also lists "Pipe end 20. Pipe 150 ..." and "Pipe end 21. Pipe 100: both ends are not connected". So the check passes whether or not the stretched pipe's line is worded. The case title and EXPECTED promise the stretched pipe's line; the check does not deliver it.
2. **`history absent "handle "` (check 6)** cannot see a bare code (original BUG-372 shape). CE 02 added `matches $h_all "(?s)^(?!.*pipe (?=[0-9A-F]{3,6}\b)(?=[0-9]*[A-F]|[0-9]{5,6}\b))"` on 1 Nov; it has not been run and has no red twin (the switch checks.cdcheckLinesShowNoInternalIds governs the CDCHECK lines, not the tidy "no clear spot" line; PR 1835 fix report detail 10.3 says that wording is untouched).
3. **Not a weakness but a limit:** the stretch does not change which end is open (the new pipe's end is open before and after). So "is not connected" cannot prove the stretch either way; only the wording can be proved.

### 4. Repaired case (PART claim)

Changes from the current file: header comment line added; `BUG` unchanged; `PROVES_BUGS` still empty (desk decides); `NOT_AUTOMATED` adds the stretched-pipe limit; step `field $pipes handle -> $hnd` added after `select ... $pipes`; check 5 replaced by two checks (a worded pipe-end line, and the stretched pipe's own code absent). All other lines are as in the current file. **DERIVED marks:** the `field` read of the handle (README lists `field $list <name>`), and the `{$hnd}` use inside `history absent` (README shows `{$name}` only for `ent-read`, `set` and the `set "{$a} || {$b}"` join, not inside an ASSERT line). Neither has been seen to work. CE 05: run `validate` first; if `{$hnd}` is refused in ASSERT, use the `set` form shown in the fallback below.

```
# CE 05 draft 2 Nov 2026 (Sonnet, weak-check repair, NOT RUN, NOT VALIDATED): check 5 "is not connected" was met by a fixture pipe (Pipe end 1. Pipe 450). Replaced by (a) every "Pipe end" line in the last 200 lines is worded (no "(handle " after the pipe size) and at least one such line exists, and (b) the stretched pipe's own code, read from the drawing after the stretch, appears on no command-line line. Claim is PART: wording after MOVE and STRETCH in CDCHECK; the Drawing Border wording and the Checks window are not judged. The 1 Nov bare-handle line is kept unchanged.
CASE N41v87
TITLE After pit P3 is moved and a new pipe's open end is stretched, CDCHECK still names everything in words: no raw handle, no CE-CIV id, no code for the stretched pipe, and every pipe end line reads in words
PLAN_ITEM BUG-372 the STRETCH and MOVE part (PR 1835, switch checks.cdcheckLinesShowNoInternalIds); the part R22 leaves out
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-R47v
ORDER 410
TIMEOUT 1200
BUG BUG-372
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After SETUP-R47v the open end is stretched 2000 mm east with a crossing window round 170000,-80000. The IL 17.78 text then sits within 800 mm of 172000,-80000. CDCHECK prints its '[CE] CDCHECK:' summary and at least one 'Pipe end N. Pipe SIZE: ... not connected' line, and no such line carries '(handle'. The code of the stretched pipe (read from the drawing) appears on no command-line line since the case began. No line holds 'handle ', 'CE-CIV-PIPE-', 'CE-CIV-PIT-' or a '\U+' escape code.
WHY_NOT_UNIT_TEST The lines are worded from the real drawing after live MOVE and STRETCH edits, and are only seen on the live command line.
NOT_AUTOMATED The 'no clear spot ... (on the block Drawing Border)' wording after a MOVE is not part of PR 1835 and is only recorded (FULL history tail), not judged.
NOT_AUTOMATED The Csv answer of CDCHECK, the Checks palette (BUG-753, BUG-814) and the schedule footer (BUG-360) are not read. A grip-stretch with the mouse is not driven; only the typed STRETCH.
NOT_AUTOMATED The stretched pipe's own 'Pipe end' line is not isolated (its size is not recorded, so a line cannot be tied to it); the check is that its code is absent everywhere and that no pipe end line anywhere shows a code. A stretch cannot change which end is open, so 'is not connected' alone proves nothing about the stretch.
NOT_AUTOMATED DERIVED, not yet seen on a run: that 'field $pipes handle' returns the new pipe's handle, and that {$hnd} is accepted inside a 'history absent' line.
STEPS
  type "_.ZOOM{NL}_W{NL}166000,-84000{NL}174000,-76000" -Force -> $zoom
  wait
  type "_.STRETCH{NL}_C{NL}169400,-80600{NL}170600,-79400{NL}{NL}0,0{NL}2000,0" -Force -> $stretch
  wait
  ms-new $n0 -> $after
  select $after "text~^IL 17\.78$" -> $il_end
  dist $il_end "172000,-80000" -> $il_to_new_end
  select $after object=CeCvlPipeObject -> $pipes
  field $pipes handle -> $hnd
  type "CDCHECK{NL}" -Force -> $all1
  esc-prompt -> $all_e
  wait
  history-tail -Index 200 -> $h_all
ASSERT
  history has "found"
  number $il_to_new_end <= 800
  count $pipes = 1
  history has "[CE] CDCHECK:"
  matches $h_all "Pipe end \d+\. Pipe \d+: (one end|both ends) (is|are) not connected"
  matches $h_all "(?s)^(?!.*Pipe end \d+\. Pipe \d+ \(handle)"
  history absent "{$hnd}"
  history absent "handle "
  matches $h_all "(?s)^(?!.*pipe (?=[0-9A-F]{3,6}\b)(?=[0-9]*[A-F]|[0-9]{5,6}\b))"
  history absent "CE-CIV-PIPE-"
  history absent "CE-CIV-PIT-"
  history absent "U+2192"
  history absent "\U+"
  record $stretch "what STRETCH printed"
  record $setup_move "what the MOVE of P3 printed"
  record $pipes "the new pipe after the stretch (bounding box)"
  record $hnd "the stretched pipe's code read from the drawing"
  record $h_all "FULL the last 200 command-line lines (the Drawing Border wording is read here by eye, not judged)"
```

**Fallback if `{$hnd}` is refused in an ASSERT line:** add a step `set $pat "(?s)^(?!.*{$hnd})"` after the `field` step and replace the `history absent "{$hnd}"` line with `matches $h_all $pat`. If `matches` also refuses a variable as its pattern, the stretched-pipe tie is BLOCKED-FOR-ROBOT: drop that one line, keep the rest, and use the Codex steps in section 6.

### 5. Repaired twin (same steps and checks, switch off; must FAIL)

```
# CE 05 draft 2 Nov 2026 (Sonnet, NOT RUN, NOT VALIDATED): same steps and checks as the repaired N41v87, switch checks.cdcheckLinesShowNoInternalIds false. Expected red: 'Pipe end ... (handle' check, 'history absent "{$hnd}"' (DERIVED: the new pipe's open end should print its handle with the switch off, as the fixture pipe did: 'Pipe 450 (handle 109359)'), 'history absent "handle "' and 'history absent "CE-CIV-PIPE-"'. Controls that must PASS: STRETCH found, IL text near the stretched end, one pipe, summary, a worded-or-coded 'Pipe end' line exists (the first matches line is relaxed here, see below). The bare-handle line is expected to PASS in the twin (the switch does not govern that wording), so it is a guard, not a red proof.
CASE N41_BROKENv87
TITLE BROKEN VARIANT of N41: CDCHECK's words switch OFF, so the handle and the CE-CIV-PIPE id come back after the stretch and move (must FAIL)
PLAN_ITEM red-before-green proof for N41 (BUG-372, a real switch)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json checks.cdcheckLinesShowNoInternalIds false
SETUP SETUP-R47v
ORDER 411
TIMEOUT 1200
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N41v87
REVIEWED_AGAINST
EXPECTED This variant is wrong on purpose: with the switch off CDCHECK prints 'handle ' and 'CE-CIV-PIPE-' again and the pipe end lines carry '(handle', so the 'Pipe end ... (handle' check and the two absence checks fail; every route and control check passes.
WHY_NOT_UNIT_TEST It exists only to prove N41's wording checks go red when the switch is off.
STEPS
  type "_.ZOOM{NL}_W{NL}166000,-84000{NL}174000,-76000" -Force -> $zoom
  wait
  type "_.STRETCH{NL}_C{NL}169400,-80600{NL}170600,-79400{NL}{NL}0,0{NL}2000,0" -Force -> $stretch
  wait
  ms-new $n0 -> $after
  select $after "text~^IL 17\.78$" -> $il_end
  dist $il_end "172000,-80000" -> $il_to_new_end
  select $after object=CeCvlPipeObject -> $pipes
  field $pipes handle -> $hnd
  type "CDCHECK{NL}" -Force -> $all1
  esc-prompt -> $all_e
  wait
  history-tail -Index 200 -> $h_all
ASSERT
  history has "found"
  number $il_to_new_end <= 800
  count $pipes = 1
  history has "[CE] CDCHECK:"
  matches $h_all "Pipe end \d+\. Pipe \d+( \(handle [0-9A-F]+\))?: (one end|both ends) (is|are) not connected"
  matches $h_all "(?s)^(?!.*Pipe end \d+\. Pipe \d+ \(handle)"
  history absent "{$hnd}"
  history absent "handle "
  matches $h_all "(?s)^(?!.*pipe (?=[0-9A-F]{3,6}\b)(?=[0-9]*[A-F]|[0-9]{5,6}\b))"
  history absent "CE-CIV-PIPE-"
  history absent "CE-CIV-PIT-"
  history absent "U+2192"
  history absent "\U+"
  record $stretch "what STRETCH printed"
  record $setup_move "what the MOVE of P3 printed"
  record $pipes "the new pipe after the stretch (bounding box)"
  record $hnd "the stretched pipe's code read from the drawing"
```

Note on the twin's control line: the recorded switch-off line is `Pipe end 1. Pipe 450 (handle 109359): one end is not connected (the start).` (GaQ3 s2 check 5), so the twin's positive control allows the optional `(handle XXXX)` part and still passes; the twin's red comes from the line after it.

### 6. What this does and does not prove

1. **Proves (if validated and passed):** after a MOVE and a STRETCH, no CDCHECK pipe end line shows a code, the stretched pipe's own code is on no command-line line, and the old bare-code shape is absent. The twin shows the same lines go red with the switch off.
2. **Does not prove:** the 'Drawing Border' wording (recorded only), the Checks palette, the CSV, a whole-feature BUG-372 (BUG-753 and BUG-814 stay separate). Claim: PART.
3. **Build and acceptance status:** the repaired text is drafted only. It has not been validated, run, or reviewed. Any change to the case text voids the existing review file (it is tied to the case's SHA-256, `A8C6D092...`), so a new independent review is needed once per batch, and the case needs a fresh PASS before it counts as Claude-accepted again. Whole-feature acceptance rules (RULES.md 24 Oct and 1 Nov amendments) are unchanged.
4. **Open risk:** the DERIVED `{$hnd}` use. If the stretched pipe's code does not appear in the twin's output, that line is a control that never turns red, and this repair is no better than today for the tie to the stretched pipe. The twin run must show it red before it is credited.

### 7. Codex look steps (only if the stretched-pipe tie is BLOCKED-FOR-ROBOT)

Copies only, no saving, screenshots and exact text recorded.

1. **Open** a copy of the DRV1_B1 drawing in AutoCAD with the installed Civil build.
2. **Move** pit P3 up 2000 mm (MOVE, base 0,0, second point 0,2000). **Place** a new pit P8 at 150000,-80000 and a new pipe from it to 170000,-80000 (levels 18.000 and 17.800).
3. **Zoom** to the window 166000,-84000 to 174000,-76000. **Stretch** the open end east 2000 mm (STRETCH, crossing window round 170000,-80000, base 0,0, second point 2000,0).
4. **Click** the new pipe once and note its code from Properties (the handle). **Type CDCHECK** and scroll the command line to read every "Pipe end" line.
5. **Pass:** every "Pipe end" line reads like "Pipe 450: one end is not connected (the start)", with no code in brackets, and the pipe's code from step 4 appears on no line. **Fail:** any "(handle ...)", "CE-CIV-PIPE-..." or the pipe's code on a line. Screenshot the lines.
