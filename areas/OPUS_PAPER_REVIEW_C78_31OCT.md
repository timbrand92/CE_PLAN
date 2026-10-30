# Opus paper review of the C-78 case files (Sat 31 Oct 2026, 07:10 PC clock)

Read-only paper review for CE 02, brief `C:\CE_PLAN\desk_jobs\REVIEW_BRIEF_C78_PAPER.txt`. Nothing was run in AutoCAD; no case, setup, spec or settings file was changed; no `.review.txt` slip was written; nothing committed.

## ANSWER FIRST

1. **Counts:** 30 case files reviewed: 10 READY TO RUN, 20 FIX FIRST, 0 NOT RUNNABLE.
2. **Main fault (17 files: N33a to N33h, their 8 twins, N33s):** CE moves each pipe end from the pit centre to the pit's inside wall (225 mm per end), so the "4.1 m" pit-to-pit pipe is really 3.65 m.
3. **What 3.65 m breaks:** the pipe is then only 8.75 per cent steeper than 1 in 100, under the 10 per cent trigger, so the "no window" cases pass even without the C-78 fix, N33s can never see its window, and most level and "Use 1 IN" figures in the cases are wrong.
4. **One fix for all 17:** move the second pit from 154100,-70000 to 154550,-70000 (its PIT line and the CD line). The pipe is then exactly 4.1 m wall to wall and every figure already written in the cases comes out right.
5. **Second fault (N90, N90_BROKEN, N90x):** the test drawing already holds RG1, so CDRG names the new raingardens RG2 and RG3 (seen on two earlier runs), and `ent-read {$l1}` hands the driver a whole object instead of a handle, which the driver refuses (BLOCKED).
6. **Ready now:** N33_grade_mismatch_x, N33_grade_mismatch_x_off, N91 and its twin, N41, N67, N71 and their three twins.
7. **Riskiest 1, N33s:** as written it cannot pass on a correct C-78 (no window opens at 3.65 m); it is also the only proof that the B-057 switch works.
8. **Riskiest 2, N33b (the real C-77 route):** expects 19.40 but CE will fill 19.41 at 3.65 m, and it would pass even on 3.0.87, so it proves nothing until the pit moves.
9. **Riskiest 3, N90x:** two separate faults (wrong RG numbers, refused ent-read); it would stop BLOCKED, not fail a check.
10. **Brief correction:** the Grade mismatch window does not need a pit. It needs Set my own grade chosen; GM2 (rerun 23:57) opened it on empty ground. A pit at the first point only matters because CE then pre-selects Set my own 1 in 100.
11. **New fact:** on this PC "Recall last settings" is OFF (CD_Settings.json rememberCdSettings false), so every New Pipe opens on Standard (default minimum) grade, 100 mm, "I know one end" off, levels 1.10 / 1.20. The "remembered values" warnings and reset pipes in the N33 cases are harmless but not needed.
12. **Control ids:** check_ids.ps1 says every control id in both folders is known; I checked the button names in every ui-press by hand against the allow-list (all allowed). Offline validate: 0 invalid in both folders.
13. **Codex look, not robot:** the look of the Grade mismatch box (three buttons, not clipped), Esc and the X on that box, and where the RG label sits on the plan.
14. **Not checked:** nothing was run in AutoCAD; the pit size (450 internal), fixture space at the new pit point, and the N71 log line are read from earlier runs or the code, not seen on C-78.
15. **Commit read:** origin/claude/rel-20261102a head 3fbb9da5 (the C-78 version commit, one commit on top of GO head 7c6af57b).

---

## 1. Source pinned

1. **Branch and commit:** `origin/claude/rel-20261102a`, head `3fbb9da5` "Version: Civil 3.0.88 / Manager 1.1.88 (C-78)", parent `7c6af57b` (the GO head). Checked with `git merge-base --is-ancestor 7c6af57b origin/claude/rel-20261102a`. Source extracted read-only with `git archive 3fbb9da5 Modules/Drainage` into the session scratchpad. Not master.
2. **Expected-behaviour documents read:** `OPUS_RECHECK_H2_1873_B057_30OCT.md` (section 5 robot cases), the case headers, and the runner reports of 30 and 31 Oct on 3.0.87.

## 2. Facts that apply to many cases

1. **Pipe ends move to the pit's inside wall.** Draw-first CD snaps both picked ends before the New Pipe window opens (`CdCommand.cs` 109-112, `LinkService.NewPipeEnds.cs` 170-218). Seen on 3.0.87: `RUN-20261031-0534-...-aN41v2` printed "[CE] Pipe end moved to the inside wall of P8 (was 225 mm inside the pit)." and the pipe's box starts at x 150225. Words from `PipeEndWallSnap.cs` 71-79. New Pit opens on its defaults on this PC (rememberPitSettings false), so the 225 mm is stable. Two pits 4.1 m apart centre to centre give a 3.65 m pipe; 4.55 m apart gives 4.1 m.
2. **New Pipe does not recall the last pipe on this PC.** `CD_Settings.json` line 162 `"rememberCdSettings": false` (default false, `UserSettings.cs` 1781-1782), so `LoadSettings` calls `ApplyDefaults` (`CdViewModel.Settings.cs` 15-26; `CdViewModel.Commands.cs` 66-115): Diameter 100 (line 69), Standard grade (line 73), work-out off (105), levels 1.10 / 1.20 (106-107). Only the job's last pipe size carries over (UX-RESUME-01, `ApplyLastJobChoice`).
3. **Why the N33 cases clear the upstream box first (correct, keep it).** The window's own "1.20" goes through the downstream setter, which marks it as typed by the drafter (`CdViewModel.Inverts.cs` 730-731). Typing an upstream level next would carry the old fall (held-fall branch, `Inverts.cs` 858-875, `UpstreamDownstreamSuggest.cs` 64-65, 102-110). Clearing the upstream first leaves no old pair, so CE suggests its own level (`Inverts.cs` 780-818; `SuggestedLevelGradeRule.cs` 24-31, rounded DOWN to 10 mm).
4. **An empty value reaches the driver.** Offline probe (scratchpad, not the driver): `ProcessStartInfo.ArgumentList` with `""` into `pwsh -File` gave `count=4 last=[]`, so v2 `ui set` receives an empty value and calls `SetValue("")` (`acad_driver_witness_v2.ps1` 2632-2657). Not yet seen on the real box.
5. **The window rule at C-78** (`CdCommand.Grade.cs` 234-275, called at `CdCommand.cs` 586-604): Set my own grade only (line 244), both levels (245), skipped when the second level is CE's own AND the pipe is as steep or steeper (258-266, `MismatchBoxOwnSuggestionRule.cs` 25-45), else more than 10 per cent off either way (270-274). Words: `GradeMismatchDialog.xaml.cs` 25-31 ("Use 1 IN {actual}", "Keep 1 IN {typed}", "Cancel (or Esc, or the X) places no pipe."); Cancel button `GradeMismatchDialog.xaml` 59-62, shown only with the switch on (`xaml.cs` 41); cancelled line `GradeMismatchChoiceRule.cs` 32-33 printed at `CdCommand.cs` 596; log line `CdCommand.cs` 597 (Info). The figure shown is `MathHelper.ActualGradeDenominator` (`MathHelper.cs` 55-61, rounded half away from zero).
6. **Level arithmetic used below.** Work-out ON: fall = length / grade rounded UP to 10 mm, at least 20 mm (`MathHelper.cs` 220-231 and 296-334). Work-out OFF suggestion: downstream = upstream minus length / grade, rounded DOWN to 10 mm (`SuggestedLevelGradeRule.cs` 24-31).
7. **Brief ground truth 1 corrected.** GM1 (empty ground, window left on its defaults = Standard grade) did not open; GM2 rerun `RUN-20261030-2357-...-gm2r` (empty ground, Set my own 100 and work-out off set by the case) DID open ("Creative Engineering | Grade mismatch"). With a pit at the first point CE pre-selects Set my own 1 in 100 (SETUP-R47v's label read "1 IN 100" on a 19.775 m pipe whose actual grade is 1 in 99, which only the Set-my-own label does). Every N33 case sets Set my own explicitly, so none needs a pit for the window.
8. **Settings keys are right.** `grade.mismatchBoxCloseCancels` (`UserSettings.cs` 1721, GradeSettings), `pipe.mismatchBoxSkipsOwnSuggestion` (1487, PipeSettings), `linking.raingardenLabelWithoutNumber` (743), `linking.cleanUpGripRotateScaleCopies` (942), `linking.pitCopyKeepsOriginalPipeEnds` (971). None is in Tim's file today, so the guard adds the key and puts the file back by hash.
9. **The reset pipes are harmless.** Each reset opens a fresh New Pipe on Standard grade; typing 18.000 over the default 1.10 / 1.20 gives a rising held fall, so the suggestion does NOT switch the grade to Set my own (`Inverts.cs` 821-830 needs a positive grade); Standard grade never asks (`Grade.cs` 244). Their "Standard grade" comment is loose: `IsGradeDefault` is the default-minimum grade (saved as `defaultMin`, `CdViewModel.Settings.cs` 277-281).
10. **State a case leaves behind.** N33c, N33d, N33e, N33f, N33s and their twins draw at 100 mm and end with the window open (no reset), so the job's last size becomes 100 mm; the next New Pipe in `C:\ce_rc_drv` that does not set a size opens at 100 mm (SETUP-R47v relies on 225). In spec order the later N33 resets put 225 back; a re-run or the pointer half could see 100. Not a fault in these cases; worth knowing.
11. **Runner behaviour that matters.** `ui-press` uses UI Automation and works while a CE window is open; `esc-prompt`, `wait`, `ms-*`, `getvar` use AutoCAD and stall while the Grade mismatch window is open (brief rule 5). A step failure ends the case as FAIL or BLOCKED at that step, not on a check.

## 3. The shared N33 geometry fault in numbers

Pit A at 150000,-70000; pit B at 154100,-70000 as written (3.65 m pipe) or 154550,-70000 after the fix (4.1 m pipe).

1. **N33a ("I know one end" ON, 19.45, 1 in 100):** 4.1 m: fall 0.041 up to 0.05, IL 19.40, 1 in 82, skipped by B-057; without B-057 it is 18 per cent off and the window opens, so the case proves the fix. 3.65 m: fall 0.0365 up to 0.04, IL 19.41 (case expects 19.40), 1 in 91, 8.75 per cent off: no window with or without the fix.
2. **N33b (OFF, CE's own level):** 4.1 m: floor(19.409) = 19.40, 1 in 82, skipped. 3.65 m: floor(19.4135) = 19.41 (case expects 19.40 twice), no window either way.
3. **N33c (typed 19.37):** 4.1 m: 0.08 fall, 51.25, "Use 1 IN 51". 3.65 m: 45.6, "Use 1 IN 46". Opens either way.
4. **N33d (typed 19.43):** 4.1 m: 0.02 fall, 205.0, "Use 1 IN 205". 3.65 m: 182.5, a half: "Use 1 IN 183" or 182 depending on floating-point noise. Opens either way.
5. **N33e (grade changed to 200):** 4.1 m: box 19.40, CE's own at 200 = floor(19.4295) = 19.42, not equal, 1 in 82, "Use 1 IN 82" / "Keep 1 IN 200". 3.65 m: box 19.41 (case expects 19.40 twice), "Use 1 IN 91".
6. **N33f (held fall):** 4.1 m: 19.40, typed 19.30, upstream 19.50 carries 0.15 to 19.35, CE's own from 19.50 = 19.45, not equal, 27.3, "Use 1 IN 27". 3.65 m: first box 19.41 (case expects 19.40), "Use 1 IN 24".
7. **N33g (re-typed upstream 19.60):** 4.1 m: 19.40, then held fall 0.05 gives 19.55 = CE's own floor(19.559), skipped; IL 19.60 / 19.55. 3.65 m: 19.41 then 19.56 (case expects 19.40 and 19.55), and no window with or without the fix.
8. **N33h (ON, 1 in 200):** 4.1 m: 0.0205 up to 0.03, IL 19.42, 1 in 137, skipped; without B-057 31.7 per cent off, window. 3.65 m: 0.01825 up to 0.02 (the 20 mm minimum), IL 19.43 (case expects 19.42), 1 in 182.5, no window either way.
9. **N33s (switch OFF, N33b route):** 4.1 m: 19.40, 18 per cent off, window opens with "Use 1 IN 82". 3.65 m: 19.41, 8.75 per cent: NO window, so `contains $w1 "Grade mismatch"` fails on a correct build.

**Exact fix for all 17 files (two lines each, nothing else changes):**

1. Replace `  type "PIT{NL}154100,-70000" -Force -ExpectWindow "New Pit" -TimeoutSec 120 -> $pitB` with `  type "PIT{NL}154550,-70000" -Force -ExpectWindow "New Pit" -TimeoutSec 120 -> $pitB`.
2. Replace `  type "CD{NL}150000,-70000{NL}154100,-70000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd` with `  type "CD{NL}150000,-70000{NL}154550,-70000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd`.
3. Line numbers: N33a 36, 45; N33a_BROKEN 34, 43; N33b 37, 46; N33b_BROKEN 33, 42; N33c 36, 45; N33c_BROKEN 33, 42; N33d 36, 45; N33d_BROKEN 33, 42; N33e 37, 46; N33e_BROKEN 33, 42; N33f 37, 46; N33f_BROKEN 33, 42; N33g 36, 45; N33g_BROKEN 33, 42; N33h 35, 44; N33h_BROKEN 33, 42; N33s 35, 44. The EXPECTED lines of N33a (18) and N33b (19) also name 154100; change the text to 154550 there too.
4. **Recommended with it (guards, not required):** in each main letter case and N33s add the check `  history has "was 225 mm inside the pit"` under ASSERT, so a different pit size shows up as a plain red line instead of wrong levels. In N33a, N33b, N33g, N33h and their twins add `  ui-press "Grade mismatch" "Cancel" -Optional -> $gm_guard` straight after `  windows-snapshot -> $w1`, so an unexpected window is closed and shows as a failed check instead of stalling the next `esc-prompt`.

## 4. Case by case

### 4.1 N33_grade_mismatch_x

1. **(a) Keys while a window is open:** after Start Pipe the box opens; only `windows-snapshot`, `ui-dump` and `ui-press "Grade mismatch" "Cancel"` follow (UI Automation). Cancel is on the press list of "Creative Engineering*". `wait` comes after `await-window-gone`. The reset pipe opens no box (Standard grade).
2. **(b) Words and figures:** "Use 1 IN 200" (`xaml.cs` 25; 20 / 0.1 = 200, no pits so no wall move); "Keep 1 IN 100" (26); "places no pipe" (31); Cancel button (`xaml` 59-62); cancelled line (`GradeMismatchChoiceRule.cs` 33 via `CdCommand.cs` 596); log line (`CdCommand.cs` 597). Trigger: 100 per cent off; B-057: CE's own from 18.000 over 20 m at 1 in 100 is 17.80, not 17.90, so not skipped. No object is made before the check (`CdCommand.cs` 404-599), so 0 new objects is right.
3. **(c) Setup:** Set my own 100 and work-out off set by the case; no pit needed (gm2r); switch pinned true.
4. **(d) Ids:** known.
5. **(e) READY TO RUN.** Risks: first-ever press of Cancel in this box; free space at the reset route 160000,-62000 to 170000,-62000 not checked.

### 4.2 N33_grade_mismatch_x_off

1. **(a):** box opens and stays open; only UI Automation steps follow; ORDER 99 in its own pack. At the end the clean-up finds no Cancel, presses Close; with the switch off Close means Keep (`xaml.cs` 57), so CE draws the pipe in the unsaved copy before QUIT. Harmless, but expect "pipe placed" lines after the case.
2. **(b):** same sources; without the switch the body has no "places no pipe" line (`xaml.cs` 31) and Cancel is collapsed (41).
3. **(c):** switch typed false before launch; correct key.
4. **(e) READY TO RUN.** UNCONFIRMED: `control-text $gm absent "Cancel"` (line 44) assumes a collapsed WPF button is left out of the window dump. If the dump still lists it (off screen), this one check goes red although the box is right: read the recorded `$gm` before calling it a product fault.

### 4.3 N33a_one_end_on_no_box and N33a_BROKEN

1. **(a):** no window expected; `esc-prompt` follows Start Pipe, so an unexpected window would stall (guard in section 3 item 4).
2. **(b):** IL 19.40 (line 84) and the skip are right only at 4.1 m (section 3 item 1). IL words: typed level as typed, worked-out level F2 (`CdCommand.cs` 551-553).
3. **(c):** Set my own 100, work-out ON, known 19.45 set by the case; Set my own is set before the level, so the window keeps 100 (`Inverts.cs` 788-793, 823). Twin changes only the window claim; it fails on its first check on C-78.
4. **(e) FIX FIRST** (both files): section 3 fix.

### 4.4 N33b_ce_level_no_box and N33b_BROKEN

1. **(b):** `control $np1 "C2.SecondInvert" value "19.40"` (line 82) and IL 19.40 (line 88) are right only at 4.1 m. "19.40" text format: F2 (`Inverts.cs` 816-818). CustomGrade stays "100" (no rewrite with Set my own chosen).
2. **(c):** clear-then-type is needed and correct (section 2 item 3).
3. **(e) FIX FIRST** (both): section 3 fix. Riskiest 2.

### 4.5 N33c_typed_steeper_asks and N33c_BROKEN

1. **(a):** window left open, UI Automation only afterwards, ORDER 99, own pack; clean-up presses Cancel (switch on), no pipe.
2. **(b):** "Use 1 IN 51" (line 66) right only at 4.1 m; "Keep 1 IN 100" right; `C2.SecondInvert` 19.37 right.
3. **(e) FIX FIRST** (both). The twin fails on its check on any build where the window opens.

### 4.6 N33d_typed_flatter_asks and N33d_BROKEN

1. **(b):** "Use 1 IN 205" (line 66) right only at 4.1 m; at 3.65 m it lands on a half (182.5).
2. **(e) FIX FIRST** (both).

### 4.7 N33e_grade_changed_asks and N33e_BROKEN

1. **(b):** 19.40 twice (lines 66-67) and "Use 1 IN 82" (line 71) right only at 4.1 m; "Keep 1 IN 200" right; the grade box does not rewrite the level (H2 section 1 item 2).
2. **Note:** "fails on 75e3baab" cannot be shown (that build was never installed); on 3.0.87 it also passes.
3. **(e) FIX FIRST** (both).

### 4.8 N33f_held_fall_asks and N33f_BROKEN

1. **(b):** 19.40 (line 68) and "Use 1 IN 27" (line 73) right only at 4.1 m; 19.35 and CustomGrade 100 right either way.
2. **(e) FIX FIRST** (both).

### 4.9 N33g_retyped_upstream_no_box and N33g_BROKEN

1. **(b):** at 4.1 m the held fall (the default "1.20" already counts as typed) gives 19.55, the same as CE's own, so it is skipped; 19.40 (line 82), 19.55 (line 84), IL 19.60 / 19.55 (lines 88-89) right only at 4.1 m.
2. **(a):** as N33a (esc-prompt after Start Pipe).
3. **(e) FIX FIRST** (both).

### 4.10 N33h_one_end_on_200_no_box and N33h_BROKEN

1. **(b):** IL 19.42 (line 84) right only at 4.1 m; CustomGrade "200" (line 78) right.
2. **(e) FIX FIRST** (both).

### 4.11 N33s_switch_off_box_returns

1. **(b):** 19.40 (line 60) and "Use 1 IN 82" (line 62) right only at 4.1 m; at 3.65 m the window does not open at all.
2. **(c):** switch typed false; Cancel is still there (BUG-857 switch on), so the clean-up places no pipe.
3. **(e) FIX FIRST.** Riskiest 1.

### 4.12 N91_startup_smoke and N91_BROKEN

1. **(a):** About CE Suite is closed by its listed Close press before any AutoCAD read; CDCHECK is ended with one Esc (R21's route).
2. **(b):** About rows by accepted case R06's route against the DLL versions the runner reads; "[CE] CDCHECK: n objects, m connections" seen on 3.0.87 (aN41v2); "Command outcome: CDCHECK" from `CommandOutcomeLogService.cs` 120 (Info), seen on 3.0.87 as "Command outcome: CDCHECK cancelled 7206 ms".
3. **(c):** ORDER 1, own pack. Twin breaks two claims but both are checks, so it fails on a check.
4. **(e) READY TO RUN** (both). Risk: if the first start after the install shows a CE notice window, `not-contains $w0 "Creative Engineering"` goes red for a reason that is not the product; read `$w0`.

### 4.13 N90_plain_rg_label_on_guidelines, N90_BROKEN and N90x_plain_rg_switch_off

1. **(a):** no CE window; CDRG answers by typed words (C for Close, Skip at "Add a GIO source to this raingarden? [Place/Skip] <Skip>:", `SourceBlockInsertCommands.cs` 527-533), as accepted case N04.
2. **(b) Words:** label text `RaingardenLabelRule.cs` 28-39 ("RG2" gives "RG" with the switch on, "RG2" with it off); one DBText, Middle-Centre, on GUIDELINES (`SourcePlacementService.cs` 924-967 and `SourceTagService.AppendLabelText`); "Raingarden RGn placed." (`SourceBlockInsertCommands.cs` 617). Centroid 162000,-78500 and 172000,-78500 right; the 500 mm tolerance is fine for a 250-high "RG".
3. **Fault 1, numbering:** on this fixture the first CDRG prints "Raingarden RG2 placed" (`RUN-20261030-1506-...-aF1`, `RUN-20261030-0107-...-b80F1`), so the two new ones are RG2 and RG3. "Raingarden RG1" never prints.
4. **Fault 2, ent-read:** `ent-read {$l1}` puts the whole selected object (as text) where a handle must go; v3 refuses anything that is not hex (`acad_driver_v3.ps1` 781-784), so the case stops BLOCKED. Other cases first read the handle with `field ... handle`.
5. **Exact fixes, N90:** line 33 `  ent-read {$l1} -> $e1` becomes two lines `  field $l1 handle -> $h1` and `  ent-read {$h1} -> $e1`; line 39 `  history has "Raingarden RG2"`; line 40 `  history has "Raingarden RG3"`.
6. **Exact fixes, N90_BROKEN:** line 35 as N90 line 33; lines 41-42 as N90 lines 39-40; line 46 `  matches $t1 "^RG2$"`; line 47 `  matches $t2 "^RG3$"` (then the twin differs from N90 only in the label words).
7. **Exact fixes, N90x:** line 34 as N90 line 33; lines 40-41 as N90 lines 39-40; line 45 `  matches $t1 "^RG2$"`; line 46 `  matches $t2 "^RG3$"`.
8. **(e) FIX FIRST** (all three). Riskiest 3 is N90x. The look of the label is a Codex look.

### 4.14 N41_cdcheck_words_after_stretch_and_movev87 and _BROKENv87

1. **Evidence:** these exact texts ran on 3.0.87: main PASS (`RUN-20261031-0534-...-aN41v2`), twin expected FAIL on its check (`RUN-20261031-0442-...-aN41t`).
2. **(b):** IL 17.78: pipe from the P8 wall (150225) to 170000 = 19.775 m, stretched to 21.775 m, end 18.000 - 0.2 x 21.775 / 19.775 = 17.7798, shown 17.78. SETUP-R47v levels are 1 in 98.9 against Set my own 100, 1.1 per cent off, so no window on C-78 either.
3. **(e) READY TO RUN** (both). Note: spec pack GaQ3 holds both; the last pair run (04:08, older text) was BLOCKED; only single runs since.

### 4.15 N67_tidy_labels_apply_uv87 and _BROKENv87

1. **Evidence:** both ran together in pack BaN8 on 3.0.87 with these texts (05:37): PASS and expected FAIL on the check.
2. **(e) READY TO RUN** (both). Risk: "would move 275 mm (further out)" depends on label positions; C-78 changes LinkService files, so a few millimetres' change would turn this line red without a fault.

### 4.16 N71_rotate_copy_onto_loose_pipe_end_joinsv87 and _BROKENv87

1. **(b):** pivot 111888.85,-51784.95 is the midpoint of P3 (53777.7,-23569.9) and the loose end (170000,-80000); a half turn lands the copy on 170000,-80000; the twin's pivot lands it on 170000,-85000. Words: "pit copied and numbered as new" (`CopiedLevelsRule.cs` 28), "sits on pipe ends already joined" (`CopiedPitEndOwnerGuard.cs` 109), "Pipe endpoints updated: ... from=P8 to=P11" (`ProjectDataService.Mutations.cs` 1490 and 1587, Info). PIT LABEL blocks with attributes are read in earlier runs, so `matches $rol "text.:.P11.,.insertion"` fits the ent-read output.
2. **DERIVED, not seen:** that the copy is P11 (an earlier record "P8 (COPY), P11 (ROTATE Copy)" supports P9 and P10 being taken) and that the loose-end join writes that log line.
3. **(e) READY TO RUN** (both, never run). Pack aQ3 holds both (brief note 6).

## 5. Things not checked

1. Nothing was run in AutoCAD; every verdict is from the case text, the C-78 source and earlier 3.0.87 runs.
2. Free space in DRV1_B1 at 154550,-70000 and on the reset route at y -62000.
3. That the pit default stays 450 internal on C-78 (seen on 3.0.87 only).
4. Whether WPF leaves the collapsed Cancel button out of the window dump (N33_off).
5. The PRB probe cases in the same folder (not in the brief).
