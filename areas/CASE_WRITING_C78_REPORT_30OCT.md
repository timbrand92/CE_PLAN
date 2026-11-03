# Case writing for C-78: N33 family, Grade mismatch cancel, Excel, start-up smoke (30 Oct 2026)

Writer: Opus case writer (CE 02 job), brief `C:\CE_PLAN\desk_jobs\CASE_BRIEF_C78_N33_EXCEL_36.txt` plus the CE 00 addition (on-screen versus log/file split). Written Fri 30 Oct 2026, late evening, Melbourne. Nothing was run: no AutoCAD, no driver, no runner except the offline `validate`, no build, no test. No existing case, setup, driver, runner or settings file was edited. Nothing committed, pushed or deleted.

## FOR TIM

1. **Answer:** 21 new robot cases are written and all pass the offline format check (0 invalid). Nobody has run them. The Excel checks could NOT be robot cases, so they are a Codex look (K1) instead.
2. **Grade mismatch window (B-057, the short-pipe nuisance):** 8 cases, N33a to N33h, each with a "must fail" twin, plus the switch-off control N33s. Example: two pits 4.1 m apart, 100 mm pipe, Set my own 1 in 100, type 19.45 upstream, CE fills 19.40, Draw: no window.
3. **Cancel on the Grade mismatch window (#1858):** N33_grade_mismatch_x presses Cancel and checks nothing is drawn and the command line says "Grade mismatch box cancelled". Its control N33_grade_mismatch_x_off checks the old two-button box comes back with the switch off.
4. **Excel export (#1871):** the robot is not allowed to press any "Export" button or drive a Save box, so I wrote the Codex look K1. It saves the Pit Schedule and CDCALC workbooks, opens one in Excel, and (only if the desk drops a go-flag) checks the switch-off failure.
5. **Pit copied onto a pit (#1867):** unchanged. Run the existing cases N70, C70, N71, N72 (and their twins). The "N36/C36" in the finalizer report were working titles; the case called N36 is a different bug.
6. **Start-up smoke:** N91 checks all three CE parts load at the installed version and CDCHECK runs. It cannot read the ribbon tabs or the "Started" log line; K1's start screenshot covers the ribbon.
7. **One thing for the desk to look at (not proven):** reading the code, when New Pipe opens with the last pipe's levels still in it and you pick Set my own, typing a new upstream level carries the OLD fall across instead of using your grade. Example: last levels 19.00 / 18.50, type 19.45, CE fills 18.95, not 19.40. The cases clear the upstream box first to avoid it. It may be a real drafting nuisance.

---

## DETAIL

### 1. Files written

1. **Case folder:** `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_c78_30oct\` (21 new files, next to the 3 existing N90 files).
2. **Codex look:** `C:\Lisp Files\_CODEX_RUNNER\verifyK1_c88_full.txt` and the launcher `C:\Lisp Files\_CODEX_RUNNER\verifyK1_c88.txt` (copied from `verifyJ6_c86.txt` with the ids, the subject, the build and the Excel and save-box rules changed).
3. **This report.**
4. **Validate result:** `pwsh -NoProfile -File "C:\Lisp Files\_ACAD_DRIVER\case_runner.ps1" validate "C:\Lisp Files\_ACAD_DRIVER\cases\drafts_c78_30oct"` printed `24 file(s) checked, 0 invalid` (21 new plus the 3 N90 files).

### 2. Section A: B-057b, PR #1873 (N33a to N33h, N33s)

1. **Build check:** `2b0953fc` (B-057b), `c92db9ad` (#1858), `9a1f4e64` (#1871) and `a6969702` (#1867) are all ancestors of the C-78 GO head `7c6af57b` (`git merge-base --is-ancestor`, read-only).
2. **Shared drawing for every letter:** two CE pits typed with `PIT` at 150000,-70000 and 154100,-70000 (inside the ground the J5 brief records as empty, 148000 to 172000 by -82000 to -58000), cover 19.000 (the remembered value, so the pits do not change `CD_RecentValues.json`), then `CD` typed pit to pit, 100 mm, main pipe text OFF, Set my own grade. The pit steps copy `SETUP-R47v` (typed PIT, New Pit, three `esc-prompt`).
3. **Pointer steps:** NONE. No `v3 pt-click` or `v3 esc-key` in any case. Text is switched off because a 4.1 m pipe puts its label on a leader that needs two mouse clicks (N20); the label grade is therefore not read.
4. **The "I know one end" control id:** `C2.AutoCalcSecondInvert`. Sure: high. `ui_map\w2_edit_pipe.txt` lines 84-85 show the toggle "Work out the other invert from the known end and grade" with the text "I know one end — work the other out from the grade", and K01, K05, GM2 set it by this id on New Pipe. With it ON the cases use `C2.IsAutoCalcUpToDown` and `C2.KnownInvert` (K01's route).
5. **Upstream cleared first (my addition, derived from the code, not run):** `CdViewModel.Settings.cs` lines 191-192 load the remembered levels through the same setter a drafter uses, and `CdViewModel.Inverts.cs` lines 727-731 then mark the downstream as "set by the drafter". `ResolveHasEstablishedFall` (lines 858-870) also counts any chosen Set my own grade as an established fall when both old levels are present. So typing 19.45 straight into a window that opened with old levels would carry the old fall, not give 19.40. Each OFF case therefore sets `C2.FirstInvert` to an empty value first, then 19.45. The dump after the typing asserts `C2.SecondInvert` = 19.40, so a wrong route shows as a clear FAIL. An empty `ui2-set` value has never been used by a case: the runner passes it through `ProcessStartInfo.ArgumentList` and v2 refuses only a null value, so I expect it to work, but it is unproven.
6. **Remembered values:** cases with no window end with K01's reset pipe (Standard, work-out off, 225, text on, 18.000 / 17.900 over 10 m at 160000,-62000). Cases that leave the window open cannot reset: after any session that runs them, run one no-window N33 case later, or put the New Pipe values back by hand.
7. **Brief rule 5:** cases that open the window read nothing in AutoCAD afterwards, run with ORDER 99, and assert on `windows-snapshot` plus a `ui-dump` of the window (a UI read, not an AutoCAD read; `-Optional` so a missing window gives a FAIL, not a BLOCKED). The window's button words come from `GradeMismatchDialog.xaml.cs` lines 25-26 ("Use 1 IN {actual:F0}", "Keep 1 IN {typed:F0}").
8. **Switch pinned:** every letter case sets `pipe.mismatchBoxSkipsOwnSuggestion true` before launch, so it does not depend on Tim's file (the key is absent there today, which also reads ON).

The cases, one line each (steps; derived versus guessed):

1. **N33a_one_end_on_no_box.case.txt** (twin `_BROKEN`): pits, CD, 100 mm, text off, Set my own 100, "I know one end" ON, known 19.45, Start Pipe; no window, one pipe, IL 19.45 and 19.40, reset pipe. Derived: 19.40 from `ApplyCalculatedInvertRule` rounding the fall up (re-check H2). Twin claims the window opens (it passes on 3.0.87, per pre-review H section 5 item 3).
2. **N33b_ce_level_no_box.case.txt** (twin `_BROKEN`): same, "I know one end" OFF, upstream cleared then 19.45, box must read 19.40, Start Pipe; no window, IL 19.45 and 19.40, reset. Derived from `DownstreamAtGradeOrSteeper`. Control: N33s.
3. **N33c_typed_steeper_asks.case.txt** (twin `_BROKEN`): OFF, 19.45 then downstream typed 19.37, Start Pipe; window open, "Use 1 IN 51", "Keep 1 IN 100". Derived (4.1 / 0.08 = 51.25).
4. **N33d_typed_flatter_asks.case.txt** (twin `_BROKEN`): OFF, 19.45 then 19.43; window, "Use 1 IN 205", "Keep 1 IN 100". Derived.
5. **N33e_grade_changed_asks.case.txt** (twin `_BROKEN`), hole 1: OFF, 19.45 (box 19.40), grade box changed to 200 (box still 19.40), Start Pipe; window, "Use 1 IN 82", "Keep 1 IN 200". FAILS on `75e3baab` (no window there), passes on `2b0953fc`. Derived from both Opus reviews.
6. **N33f_held_fall_asks.case.txt** (twin `_BROKEN`), hole 2: OFF, 19.45 (19.40), downstream 19.30, upstream retyped 19.50 (box must read 19.35), Start Pipe; window, "Use 1 IN 27", "Keep 1 IN 100". FAILS on `75e3baab`, passes on `2b0953fc`.
7. **N33g_retyped_upstream_no_box.case.txt** (twin `_BROKEN`): OFF, 19.45 (19.40), upstream retyped 19.60 (box must read 19.55), Start Pipe; no window, IL 19.60 and 19.55, reset. Note: in the real window 19.55 comes from the carried fall, not a fresh suggestion; the number is the same and the Draw check is stateless.
8. **N33h_one_end_on_200_no_box.case.txt** (twin `_BROKEN`): ON, grade 200, known 19.45, Start Pipe; no window, IL 19.45 and 19.42. Derived (0.0205 m rounded up to 0.03 m).
9. **N33s_switch_off_box_returns.case.txt** (control, no twin): `pipe.mismatchBoxSkipsOwnSuggestion false` before launch, N33b's steps; box reads 19.40, window opens, "Use 1 IN 82", "Keep 1 IN 100". The N33a route with the switch off is NOT written (noted in the case).

Guessed or unconfirmed in all of them: that CE measures 4.1 m between the pit centres (if it measures to the pit walls every number shifts; the New Pipe dump is recorded so it can be read); that `ui-dump` can read the Grade mismatch window (its title matches the read list entry "Creative Engineering*", but no case has dumped it before); that `C2.Diameter` takes "100" (100 is in Tim's recent sizes list).

### 3. Section B: #1858, BUG-857 (N33_grade_mismatch_x and _off)

1. **The long name validated**, so the short fallback `N33x_gm_cancel_draws_none` was not needed.
2. **The cancel CAN be driven.** The brief and the GM cases say the window cannot be answered; that is true for "Use" and "Keep", but the box's title matches the v3 list entry "Creative Engineering*", whose press list holds "Cancel" (`acad_driver_v3.allowlist.json`), and the button's text is exactly "Cancel" (`GradeMismatchDialog.xaml` at `7c6af57b`). So no Codex brief was needed for the cancel itself.
3. **N33_grade_mismatch_x.case.txt:** CD 150000,-66000 to 170000,-66000 (20 m, no pits), OFF, Set my own 100, 18.000 / 17.900, Start Pipe; window has "Cancel", "Use 1 IN 200", "Keep 1 IN 100", "places no pipe"; `ui-press "Grade mismatch" "Cancel"`; window gone; command line has "Grade mismatch box cancelled - no pipe placed."; Civil log has "CD: Grade mismatch box cancelled; no pipe placed"; zero new objects; reset pipe. Derived from `CdCommand.cs` lines 590-598 and `GradeMismatchChoiceRule.CancelledLine`. Unproven: that v3 `ui-press` reaches a button of this modal box.
4. **N33_grade_mismatch_x_off.case.txt:** `grade.mismatchBoxCloseCancels false` before launch, same steps; window has "Use 1 IN 200" and "Keep 1 IN 100" and NOT "places no pipe" or "Cancel". ORDER 99 (no pressable button, so nothing is read afterwards). The report's "a pipe at 1 IN 100 is placed after Esc" is NOT driven: Esc to a modal box through `v3 esc-key` is unproven, and it would be a pointer-type step. Left for the Codex look in the finalizer's item (a).
5. **Not driven:** Esc and the X on the ON box (same code path as Cancel: `EscapeCommand` = `CancelCommand`, `WhenDismissed` = Cancel); Enter / Keep; the look of the three buttons.

### 4. Section C: #1867, stolen links (unchanged, run the existing ones)

1. **Unchanged.** The #1867 robot cases were written on 30 Oct at 12:26 against the PR head `a6969702`, which is the head merged into C-78. `git diff a6969702 7c6af57b` of `Rules/CopiedPitEndOwnerGuard.cs` and `Services/LinkService.RepairAudit.Relink.cs` is empty, and the line "sits on pipe ends already joined to" is in the code at `7c6af57b`.
2. **Run these, unchanged:** `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_bug1227_30oct\N70_rotate_scale_copy_on_pit_keeps_pipes.case.txt`, `C70_rotate_scale_copy_on_pit_switch_off.case.txt`, `N71_rotate_copy_onto_loose_pipe_end_joins.case.txt`, `N71_rotate_copy_onto_loose_pipe_end_joins_BROKEN.case.txt`, `N72_rotate_copy_5m_away_changes_nothing.case.txt`, `N72_rotate_copy_5m_away_changes_nothing_BROKEN.case.txt`.
3. **Correction to the brief and the finalizer report:** "N36 / C36" were the working titles of N70 / C70 (N70's own header says so). `cases\N36_dp_time_under_budget.case.txt` (revised 30 Oct 07:50) is BUG-1228 (DP time), and `controls\C36e_cdfw_opening_switch_off.case.txt` is a CDFW control. Neither is #1867. No N36c78 or C36c78 was written.

### 5. Section D: #1871, Excel (no robot case possible; Codex look K1)

1. **Why no N41x_excel_on / N41x_excel_off:** all three exports open a Windows SAVE box (`PitScheduleViewModel.Schedule.cs` line 126, `CalculationsV2ViewModel.cs` line 839, Structural `UtilityCommands.cs` line 98). The driver's `dialog-path` drives only an OPEN box ("a Save dialog is never driven", default button must be Open, Select or Choose), and every button named "*Export*" is on the never-press list of both v2 and v3. So the robot cannot even start the export. Writing the cases would have produced BLOCKED runs only.
2. **K1 covers the rewritten N41c exactly as the reviews correct it:** K1-01 Pit Schedule ON (save box, "Excel export complete ...", sheets "Pit Schedule" and "Checking" read from the file, the `[BUG-1255] Excel part:` log line); K1-02 CDCALC Export to XLSX (file saved, no "CDCALC Export" box); K1-03 the saved workbook opened read-only in Excel; K1-04 switch OFF (only with `K1_OFF_GO.flag`): no file, the old failure, and NO "Excel export could not start" sentence, which belongs to the switch ON (pre-review F item 2.1, re-check F2 section 5).
3. **How Codex checks Excel is present:** the App Paths registry key for excel.exe, then `Test-Path` on that path, and whether EXCEL.EXE is already running (if it is, the Excel look is skipped so Tim's own Excel is never touched). I read the key at about 23:00: `C:\Program Files\Microsoft Office\Root\Office16\EXCEL.EXE`, which exists.
4. **STRUCEXPORTCSV:** not written. It needs a Structural copy drawing with a schedule (brief: S31 needs a Structural fixture), and its save box cannot be driven either. Re-check F2 also puts it in "its own train".
5. **Every PowerShell reading in K1 is a file** in the evidence `tools` folder (the Defender rule in `C:\Lisp Files\CLAUDE.md`).

### 6. Section E: start-up smoke (N91_startup_smoke and _BROKEN)

1. **Steps:** at the start no CE window open; `CE_VERSION`, dump "About CE Suite", Close (accepted case R06's route); `CDCHECK` with Enter, one Esc (R21's route). Checks: Civil, Structural and Manager rows show the installed versions (`$dll_civil`, `$dll_struc`, `$dll_mgr`, the runner's own DLL reading), no "Not loaded" or "CONFLICT", the CDCHECK totals line, "Command outcome: CDCHECK" in the Civil log, no "Unknown command", object count and file unchanged.
2. **Could not be checked:** the ribbon tabs (the AutoCAD main window is on the driver's never-read list) and the line "CE_CVL_SUITE v3.0.88.0 Started" (CE writes it at load, before the runner takes the case's log start byte; `log civil has` reads only bytes written since the case began). The version is recorded from `$dll_civil` instead, which is the same assembly version the Started line prints (`LoggingService.cs` line 109). K1's start rule asks Codex to write the CE ribbon tab names it sees.
3. **Twin:** claims "Not loaded" in the About window and no CDCHECK outcome line.

### 7. On screen versus log or file (the CE 00 split)

1. **Seen on screen, so only a Codex look can accept the picture:** the Grade mismatch window and its buttons (all N33 letter cases, N33s, both N33_grade_mismatch_x cases read it only as text); the downstream box filled by CE (N33b, e, f, g, read as text); the About CE Suite window (N91, as text); the ribbon tabs (not read; K1 start screenshot); the Pit Schedule status line, the save boxes, the CDCALC error box and the workbook in Excel (K1-01 to K1-04).
2. **Read only in the drawing, a log or a file, so Claude-acceptable under the 24 Oct rule:** IL texts, pipe and object counts, the command-line lines, the Civil log lines (N33 letters, N33_grade_mismatch_x, N91); the saved .xlsx size, SHA-256 and sheet names and the `[BUG-1255]` log line (K1, read by Codex from the file and the log, written but not judged as a look).

### 8. What I did NOT do and what is not proven

1. Nothing was run. Every expected number is derived from the code at `7c6af57b` and the two Opus reviews of #1873, not from a run.
2. The remembered-levels finding (section 2 item 5) is read from the code only. If it is real, a drafter on a pit-to-pit pipe with Set my own chosen gets the old fall carried into the new pipe when typing only the upstream level. It is the BUG-076 heuristic that its own comment flags "for Tim to confirm". Not added to BUG_CARPARK by me (my limits allow only these files); the desk should decide.
3. Every REVIEWED_AGAINST line reads "builder-filled: Opus review still needed". No review file was written.
4. Session grouping: the letter cases set the B-057 switch, N33s sets it false, the two #1858 cases set their own switch, and N91 sets nothing, so the runner will start separate AutoCAD sessions for these groups. The letter cases with pits take 2 PIT and 1 or 2 CD placements each (TIMEOUT 1500 s): run at most two per call.
