# Robot case drafts, set 05: detention, rainfall note, speed table, roof C, STORM note (Mon 2 Nov 2026, Melbourne, read-only drafter, Sonnet)

**What this is.** Robot case drafts for five fix PRs heading for `origin/claude/rel-20261102a`. Nothing was built, tested, installed or opened in AutoCAD. No case file was created anywhere; this is the only file written. No git write.

**Sources read:** `C:\TimOS\RULES.md`; `README_CASES.md` (full, including the refused-button rules); `ROBOT_CASE_DRAFTS_TOP12_30OCT.md` (the finished example) and the header of `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md`; `variants\R09s_new_switch_off_broken.case.txt` (the switch-off twin style); `gh pr view` and `gh pr diff` for #1950, #1948, #1960, #1965 and #1984; the installed source of `origin/claude/rel-20261102a` (read with `git show` and `git grep` only) for `CivilDesignCommand.cs`, `RainfallCurveCommand.cs`, `RainfallCurveReport.cs`, `RainfallWindow.xaml`.

**NOT read, for time (the three-minute limit on window-only fixes):** the `BUGFIX_*_REPORT_*.md` files, the carpark entries and the repo `REGRESSION_LOG.md` entries beyond the text shown in each PR diff. The desk should check those before the case is reviewed.

---

## ANSWER FIRST

1. **1 case drafted with its failing twin (2 case texts):** W1948 and W1948_BROKEN, orders 740 and 741.
2. **4 fixes are Codex-only or blocked for the robot:** #1950, #1960, #1965 and #1984. Each has a numbered Codex look in section 3.
3. **Opus review before any run:** #1950 only (BUG-1152). It rewrites a pipe's main line and puts it back, so it touches Undo and the protection rules. I wrote no case for it, so there is nothing to run yet. The W1948 case writes nothing to the drawing and needs no Opus review for Undo, REDO, a locked layer or an Xref.
4. **No case existed for any of the five.** A search of the cases folder (including every `drafts_*` and `variants` folder), the other drafts files and `ledger.json` found the five numbers only as unrelated text.
5. **What I could not verify:** every printed line in W1948 is DERIVED (read from the source, never seen on a run). I do not know that the fixture drawing has no rainfall curve of its own, and I do not know that the Close button on the rainfall window ends without saving.

---

## FOR TIM

1. **Done.** One robot test written on paper, with a deliberately wrong copy that must fail. Nothing for you to test or decide.
2. **Example.** Test W1948 types CDRAINFALL on a drawing with no rainfall curve of its own and closes the window. It then checks the command line says the office curve "may be high or low by up to about 8 per cent", never "reads about 7 to 9 per cent high". The wrong copy turns the fix switch off, so the old sentence comes back and the test must fail.
3. **What it covers honestly.** Only the sentence on the command line. The same sentence on the computations sheet and in the Design window is not checked (Codex look).
4. **The other four fixes cannot be proved by the robot:**
   1. **#1950, twin detention pipe upgrade:** needs an older twin pipe and a refused upgrade. The robot cannot build one. Codex-only, and Opus reviews it first.
   2. **#1960, speed table:** the answer is in the Edit Pipe grade strip, a window.
   3. **#1965, roof C:** the answer is in the CDCALC Pump system and Rational tabs, windows.
   4. **#1984, STORM note:** needs a STORM report file placed in the job folder next to the drawing. The robot may not add files there.
5. **Nothing for you to decide.**

---

## 1. How the drafts are written

1. **Format.** The README format: header lines, `STEPS`, `ASSERT`. The `type` chain is a complete command, no `(`, no SAVE-type word.
2. **Switch-off twin.** W1948_BROKEN is the same route and checks with the PR's own switch (`detention.rainfallNoteHighOrLow`) set to false before AutoCAD starts, in the style of `R09s_new_switch_off_broken`. The setting is passed with `SETTING CD_Settings.json <key> <value>`; Tim's real settings file is never read or written by this drafter, and the runner's guard restores it by hash. Do not use `hashes-unchanged` in either case.
3. **REVIEWED_AGAINST is empty.** No review file is written.
4. **Fixture** DRV1_B1, **SLOT fresh**, orders 740 and 741.
5. **DERIVED** marks a printed line or window word taken from the PR or the source and not seen on a run. Expect a fix-up or two at first run.
6. **Validate first, without AutoCAD:** copy each block to its file name in a new folder (suggested `cases\drafts_set05_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`. Run in Tim's free hours only.

---

## 2. The case texts

### Case 1 of 1: W1948, the rainfall note says high or low (PR #1948, BUG-866, order 740)

**Intended file:** `W1948_rainfall_note_high_or_low.case.txt`

```
# W1948 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). Fix PR #1948 (B-130, BUG-866), switch detention.rainfallNoteHighOrLow, ON by default. Wording only; no curve number changes.
# Route: CDRAINFALL opens the Job rainfall / IFD window (RainfallWindow.xaml: Title "Creative Engineering | Job rainfall / IFD"); close-windows ends it without saving; CE then prints RainfallCurveReport.Describe, whose first line is the curve sentence (RainfallCurveCommand.cs, Say()). The sentence is the CurveInUse text for a job with no curve of its own.
# DERIVED, never seen on a run: (a) the new sentence "may be high or low by up to about 8 per cent, and the storage moves about 2.5 times as much" (RainfallCurve.cs in the PR diff); (b) the old sentence "reads about 7 to 9 per cent high"; (c) that DRV1_B1 has no rainfall curve of its own, so the sentence is the office-curve one; (d) that close-windows ends the window without saving; (e) that the line is written to the command line AFTER the window closes, so it is read with history, not from the type result.
# If (c) is wrong the case FAILS on the first check with the job's own-curve sentence in the evidence; say so in the report, do not loosen the check.
# Remembered values: NO. The window is closed, never saved.
CASE W1948
TITLE CDRAINFALL on a job with no rainfall curve of its own says the office curve may be high or low by up to about 8 per cent, never that it reads 7 to 9 per cent high
PLAN_ITEM PR #1948 (BUG-866) PART: the CDRAINFALL command-line sentence only. NOT whole: the same sentence on the computations sheet and in the CDDESIGN and CDCALC windows is a Codex look (K5_02), and the Glen Eira check of the curve itself is the desk's part, not this case
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 740
TIMEOUT 600
BUG BUG-866
PROVES_BUGS
REVIEWED_AGAINST
SETTING CD_Settings.json detention.rainfallNoteHighOrLow true
EXPECTED CDRAINFALL opens the Job rainfall window; closing it prints "This job has no rainfall curve of its own, so CE is using the office ... curve. Check that is right for this site" followed by "against the issued CE sheets checked it may be high or low by up to about 8 per cent, and the storage moves about 2.5 times as much." The old words "reads about 7 to 9 per cent high" never appear. The object count and the drawing file on disk do not change, and no CE window is left open.
WHY_NOT_UNIT_TEST Unit tests pin the sentence text; only the live command shows that CDRAINFALL really prints it, from the installed settings read at AutoCAD start.
NOT_AUTOMATED The same sentence on the computations sheet and in the Design and CDCALC windows (Codex look K5_02).
NOT_AUTOMATED Whether "about 8 per cent" and "2.5 times" are the right numbers is Tim's engineering call (decision 16: he did not separately approve this wording).
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDRAINFALL" -Force -TimeoutSec 120 -> $t_rain
  close-windows -> $w_rain
  wait
  esc-prompt -> $e_rain
  ms-count -> $c1
  windows-snapshot -> $win_end
ASSERT
  history has "This job has no rainfall curve of its own"
  history has "may be high or low by up to about 8 per cent"
  history has "the storage moves about 2.5 times as much"
  history absent "reads about 7 to 9 per cent high"
  equals $c1 $c0
  not-contains $win_end "Job rainfall"
  copy-unchanged $copy0
  record $t_rain "FULL what CDRAINFALL printed (first run: the exact sentence)"
  record $e_rain "what the command line ended on"
```

**Twin:** `W1948_rainfall_note_high_or_low_BROKEN.case.txt`

```
# W1948_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The switch-off control of W1948: detention.rainfallNoteHighOrLow false before AutoCAD starts. The old sentence returns exactly ("reads about 7 to 9 per cent high"), so the checks that want the new sentence and the absence of the old one MUST fail. Same route as W1948; no check removed.
# It proves the 'history has' and 'history absent' checks can go red. If this twin PASSES, the switch does nothing in the live session, or the sentence is not from the office curve: say so, do not accept W1948.
CASE W1948_BROKEN
TITLE BROKEN VARIANT of W1948: the rainfall note switch OFF, so CDRAINFALL still says the office curve reads about 7 to 9 per cent high (must FAIL)
PLAN_ITEM red-before-green proof for W1948 (BUG-866)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 741
TIMEOUT 600
BUG BUG-866
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1948
SETTING CD_Settings.json detention.rainfallNoteHighOrLow false
REVIEWED_AGAINST
EXPECTED With the switch off CDRAINFALL prints the old sentence, so "may be high or low by up to about 8 per cent" is absent and "reads about 7 to 9 per cent high" is present: two checks fail. The object count, the drawing file and the open-window checks still pass.
WHY_NOT_UNIT_TEST It exists only to prove W1948's sentence checks can go red against the old behaviour in the live session.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDRAINFALL" -Force -TimeoutSec 120 -> $t_rain
  close-windows -> $w_rain
  wait
  esc-prompt -> $e_rain
  ms-count -> $c1
  windows-snapshot -> $win_end
ASSERT
  history has "This job has no rainfall curve of its own"
  history has "may be high or low by up to about 8 per cent"
  history has "the storage moves about 2.5 times as much"
  history absent "reads about 7 to 9 per cent high"
  equals $c1 $c0
  not-contains $win_end "Job rainfall"
  copy-unchanged $copy0
  record $t_rain "FULL what CDRAINFALL printed with the switch off"
```

---

## 3. Codex look notes (the four fixes the robot cannot prove)

All evidence goes under `C:\CE_WORK\codex\<note id>\`. Work on a COPY of a drawing, never Tim's job. Never accept or capture a folder the Save or Open box opened in. Settings are read when AutoCAD starts: to test OFF, set the switch before launch.

### K5_01: #1950, BUG-1152, twin detention pipe upgrade refused (BLOCKED-FOR-ROBOT, Opus review first)

**Why blocked:** it needs an older twin detention pipe (barrels drawn as a pair) AND an upgrade that gets refused. The fixture has no twin pipe and the robot cannot make one without typed LISP. The fix rewrites and then restores a pipe's main line, so Opus reviews the Undo and protection paths before Codex runs it.

1. **Setup.** Use a copy of an old job that holds a twin detention pipe from before 3.0.72. If none exists, record that and stop: do not draw one by hand and call it proof.
2. **Safe refusal route.** Put the pipe on a LOCKED layer in the copy (the layer is locked by the copy, not by CE). The upgrade's locked-layer pre-check should refuse before touching the line. Do NOT unlock anything to make it go. If the refusal can only be forced another way, stop and ask the desk.
3. **Open the copy** in AutoCAD with the install ON (default). Let the open-a-job upgrade run. Read the CE log for a `[BUG-1152]` line.
4. **Right looks like:** the twin pipe still shows both barrels where they were drawn, the main line is unchanged, a `[BUG-1152]` line is in the CE log, nothing was blocked, and the layer is still locked.
5. **Wrong looks like:** the barrels move or collapse onto one line at the next redraw.
6. **Undo check.** After the open, press U once and REDO once; the pipe must look the same as before U.
7. **OFF control.** Repeat with `linking.twinUpgradeRestoresRouteOnRefusal` set false before launch; the old fault should show.
8. **Evidence.** Before and after screenshots, the CE log lines, a note of the layer lock state.

### K5_02: #1948, BUG-866, the same note on the sheet and in the windows (PART the robot does not reach)

1. **Open the Design window** (CDDESIGN) on a job with no rainfall curve of its own. Find the rainfall line. **Right:** it says the office curve may be high or low by up to about 8 per cent, never "reads about 7 to 9 per cent high".
2. **Produce the computations sheet** by the normal CDCALC route on a copy; do not use an Export button in a robot run (Codex may press it). **Right:** the Basis of Design paragraph holds the same new sentence.
3. **Evidence.** Screenshots of the window and the sheet page, saved under `C:\CE_WORK\codex\K5_02\`.

### K5_03: #1960, BUG-80, one maximum-speed table (window-only)

1. **Settings.** Open Settings, Design standards. **Right:** the speed table reads uPVC 3.0, concrete 6.0, metal 4.0, unknown 6.0 m/s (R-01 house rule; the C-79b2 register entry).
2. **Edit Pipe grade strip.** On a copy, open Edit Pipe for a DN150 uPVC pipe, 10 m long, with a fall of about 1.54 m (about 4 m/s full bore). **Right with the switch ON:** the grade strip flags the speed as high (a warning, nothing blocked). **With `pipeSpeedChecks.sizingReadsMaterialTable` false before launch:** no flag (the old 6.0 m/s).
3. **Connection pipe.** Run the Design connection-pipe auto-sizing for uPVC. **Right:** it holds the pipe to 3.0 m/s, the same as Edit Pipe. Do NOT press Save in Edit Pipe unless the case needs it; if it does, use the copy.
4. **Evidence.** Screenshots of the Settings table, the strip ON, the strip OFF.

### K5_04: #1965, BUG-539, one roof-and-paved C (window-only)

1. **Settings.** Note `hardGroundRunoffC`, shipped 0.9. Do not change it for step 2.
2. **CDCALC, Pump system tab.** On a copy, enter a small site (suggest the Boyd's sample: 414 m2 roof and paved, 332 m2 soft at 0.30). **Right:** the weighted C matches the Rational tab's roof-and-paved row (both read 0.9, so nothing moves at the shipped value).
3. **Move the figure.** Set it to 0.8 BEFORE launch, restart AutoCAD, repeat. **Right:** the pump weighted C reads 0.60 (was 0.66); the Rational tab row reads 0.8.
4. **OFF control.** `detention.pumpAndRationalUseHardGroundC` false before launch with the figure at 0.8: the fixed 0.9 returns.
5. **Not changed:** Detention Design (0.85), WSUD (0.85), the Charged system. These must not move.
6. **Evidence.** Screenshots of both tabs for each of the three runs.

### K5_05: #1984, BUG-1120 part (a), STORM note for area marked None (needs a file in the job folder)

**Why blocked:** CDDESIGN reads a STORM report file from the job folder next to the drawing, and only asks when site and roof areas are not already recorded. The robot may not add a file there.

1. **Setup.** On a copy of a job drawing in its own folder, put a copy of a real STORM report (area marked "None" for some roof area) in the usual STORM report folder. Use a copy of a report, never the original.
2. **Run CDDESIGN.** Answer Yes to "Look through this job's folders for its rating report". Do not accept any figures that Tim has already entered; use a drawing without recorded areas.
3. **Right looks like:** a line starting "Of that," says the area marked None "has no water-quality treatment", that this does not mean it skips detention, and that CE counts only the part reaching the tank as detained, so check where it drains. The areas and the split are the same as with the switch off. It never says "goes straight out".
4. **OFF control.** `detention.stormNoneNoteWording` false before launch: the old "goes straight out" sentence returns exactly, with the same figures.
5. **Evidence.** The command-line text (copy the CE log lines) and a screenshot, saved under `C:\CE_WORK\codex\K5_05\`.

---

## 4. Fixes skipped and why

1. **#1950:** no case written. Needs a twin pipe and a refused upgrade the fixture cannot give; Opus first (K5_01).
2. **#1960:** window-only (Edit Pipe grade strip, Settings table). The command-line route for the connection pipe is the Design window. No robot route (K5_03).
3. **#1965:** window-only (CDCALC tabs). K5_04.
4. **#1984:** needs a STORM file in the job folder, which the robot may not place. K5_05.

## 5. Plain statement: what was done and what is NOT proven

1. **Read:** the files named at the top, and the diffs of the five PRs. **Built:** nothing. **Tested:** nothing. **Installed:** nothing. **Tim-accepted:** nothing.
2. **NOT proven:** that the fixture has no job rainfall curve; that `close-windows` closes the rainfall window without saving; that CDRAINFALL prints the sentence on the installed build; that the old build prints the old sentence on this drawing (the twin proves this on its first run). Every printed line in W1948 is DERIVED.
3. **Not checked, for time:** the carpark entries, the BUGFIX reports and the repo REGRESSION_LOG entries beyond what each PR diff showed. The switch names and defaults in this file come from the PR diffs: #1950 ON, #1948 ON, #1960 ON, #1965 ON, #1984 ON.
