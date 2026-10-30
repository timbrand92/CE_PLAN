# BUG-1227 Part A proof cases and the BUG-857 Codex brief: draft (CE_ACAD / robot / draft / 39)

Fri 30 Oct 2026, 12:22 to about 12:35 Melbourne time (PC clock). Drafting only: no AutoCAD started, no runner run, no driver call, no build. One offline `validate`, after reading the runner's validate code.

## FOR TIM

1. **Answer first: the robot proof for the pit copy fix and the Codex look for the new Cancel button are written and ready for tonight's C-77b build.** Nothing has been run yet.
2. **What the main robot case does (N70).** It copies pit P3 with ROTATE then Copy, and SCALE then Copy, so the copies land on top of P3. It checks that P3 keeps all five pipes and that CE says "P11 sits on pipe ends already joined to P3; they stay joined to P3."
3. **Why it uses a rounded base point.** With an exact snap, the broken build can already leave P3 its pipes. The case would then pass and prove nothing. The rounded point puts the copy 0.1 mm off P3, which is what stole the pipes on 3.0.86.
4. **The control (C70) turns the fix off.** It must show the old theft: pipe 10A901 (from WT9) ending at the copy P11 instead of P3.
5. **Two safety cases.** N71: a copy dropped on the loose end of a pipe still joins it. N72: a copy placed 5 m away changes nothing. Each has a deliberately wrong twin that must fail.
6. **The Codex look (J8).** It draws a pipe whose levels do not match its grade, so the Grade mismatch box opens. It checks the three buttons fit and can be read. It then backs out with the X, then Esc, then Cancel: no pipe each time. Last, Enter keeps the typed grade.
7. **What must be installed tonight.** A Civil build that holds BOTH the pit copy fix (#1867) and the Grade mismatch fix (#1858). C-77 (Civil 3.0.87) holds neither. On C-77 the robot pair proves nothing and the Codex look stops as NOT TESTED.
8. **Nothing for you to do.**

---

## 1. What I made

1. **Robot cases**, folder `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_bug1227_30oct\` (numbers N70 to N72 and C70 were free; the highest in use was N67):
   1. `N70_rotate_scale_copy_on_pit_keeps_pipes`: the proof.
   2. `C70_rotate_scale_copy_on_pit_switch_off`: the control (`VARIANT_OF N70`, `EXPECT-FAIL BUG-1227`).
   3. `N71_rotate_copy_onto_loose_pipe_end_joins` and its `_BROKEN` twin.
   4. `N72_rotate_copy_5m_away_changes_nothing` and its `_BROKEN` twin.
2. **Offline validate:** `case_runner.ps1 validate <folder>`: 6 files checked, 0 invalid (N70 and C70 36 steps and 30 checks each; N71 pair 17 steps, 16 checks, setup SETUP-R47; N72 pair 17 steps, 19 checks).
3. **Run spec:** `C:\ce-fx\retest\spec_bug1227_30oct.txt`, three a lines then two b lines, five files or fewer per line, file basenames in the only column. One line per settings group (N70 alone, C70 alone because its switch differs, then the four guard files).
4. **Codex brief:** `C:\Lisp Files\_CODEX_RUNNER\verifyJ8_c87.txt` (short launcher) and `verifyJ8_c87_full.txt` (90 lines). Rules N1 to N17 are copied from `verifyG3_c84_full.txt` lines 7 to 24 and checked identical with `diff`. The driver rules D1 to D12, changes (a) to (i), standard parts, setup and clean end are taken from the newest brief, `verifyH9_c86_full.txt`, with the look id changed to J8. The word "follow" appears 0 times in either file.

## 2. Reasons for the main choices

1. **Switch name, read exactly:** `linking.pitCopyKeepsOriginalPipeEnds` (fix report FOR TIM item 4, and the PR head `a6969702`, `Models/UserSettings.cs` line 875, `[JsonProperty("pitCopyKeepsOriginalPipeEnds")]`, default on). Not DERIVED. The diagnosis's earlier name `pitCopyKeepsOriginalsPipes` is superseded.
2. **The line Tim's job text called "present".** The job said N70 should show "10A901 from=WT9 to=P11" present. That line is the THEFT (the pipe from WT9 ending at the copy). Pre-review E item 3.4.4 and the fix report both put it as ABSENT with the fix on and PRESENT in the control. I followed them: N70 checks it is absent, C70 fails because it is present.
3. **The COPY first, as R34 does.** The 3.0.86 theft lines name P11 and P12, which only happens after a plain COPY has taken P8. Without that COPY the copies would be P8 and P11, and the exact log lines could not be checked.
4. **The checks in N70:**
   1. The command line has "P11 sits on pipe ends already joined to P3; they stay joined to P3." and the P12 line, each exactly once. Wording read from the PR code (`CopiedPitEndOwnerGuard.Lines`, written to the command line as `[CE] ...` and to the CE log as `[PitRelink] ...`).
   2. No "Pit schedule cell for P3" line.
   3. The CE log has none of the five stolen-end lines: `10A901 from=WT9 to=P11`, `10A98D from=P4 to=P11`, `110136 from=WT4 to=P11`, `109E23 from=P12 to=P2`, `110179 from=WT3 to=P12`.
   4. Two anchors so an empty log cannot pass: at least one new CE log line, and the `[PitRelink] P11 sits on ...` log line.
   5. The copies' labels read P11 and P12, and P3's own label 109E08 still reads P3.
5. **Why each case fails on a check.** C70: the stolen-end lines appear and the "sits on" lines do not. N71_BROKEN: the copy lands 5 m from the loose end, so the join line and the position checks fail. N72_BROKEN: the copy lands on P3, so the "sits on" line appears (fixed build) or P8 takes P3's pipe ends (old build).
6. **N71's loose end.** SETUP-R47 (as R19 uses) draws a new pipe from a new pit P8 to empty ground at 170000,-80000. A half turn of P3 about the midpoint (111888.85,-51784.95) lands the copy on that end. It stays on the ROTATE Copy route the fix changed.
7. **U twice is recorded, not judged, in N70.** Pre-review E check 5 asks for it. I kept it out of the pass or fail so a red N70 can only mean BUG-1227, not a U question.
8. **The Codex look draws its pipes in the brief's proven empty ground** (150000,-70000 to 170000,-70000, the H4b route) with inverts 18.000 and 17.800. That is 1 in 100 against the 1 in 200 default, so the box must open. Button and sentence wording read from the PR head `c92db9ad` (`GradeMismatchDialog.xaml` and `.xaml.cs`).
9. **N10 is copied word for word,** and it says "Keep, never the X". This brief needs the X, so its FIXTURE line says the J8-01 answers win over N10 for this run only.

## 3. What must be installed for tonight's runs

1. **Robot (N70 to N72, C70):** a Civil build containing PR #1867 (head `a6969702`). Read the installed DLL's product version and commit before the run. On C-77 (3.0.87) or older the switch does not exist, so N70 and C70 both fail and prove nothing.
2. **Codex J8:** a Civil build containing PR #1858 (head `c92db9ad`). The brief's build gate stops before AutoCAD on 3.0.87 or lower. The box itself is the final check (two buttons = NOT TESTED).
3. **Pre-review E's merge order** puts #1867 and #1858 together in C-77b, so one C-77b install covers both.

## 4. What I did NOT verify

1. **Nothing was run.** No case, no Codex look, no AutoCAD. Every expected line is read from code, reports or earlier runs.
2. **DERIVED items (named in the case files):**
   1. P11 and P12 (N70), P11 (N71) and P8 (N72) are the first free numbers on DRV1_B1, not guaranteed by a card.
   2. The five pipe ids come from the 3.0.86 log, not from a fresh read of this copy.
   3. N71's join line `from=P8 to=P11` assumes the pipe's From is P8 because CD started there.
   4. N72 assumes nothing in DRV1_B1 has a pipe end 5 m east of P3. A `from=P8` or `to=P8` red there must be looked at before it is called a fault.
3. **P3 keeping all five pipes is proven by absence**, not by reading P3's pipe list: the robot's pipe read shows only handle, object and layer (R19 run B5).
4. **The pre-review's twin on the OLD build** (N70 run on C-77 before the fix) is not in tonight's spec. Only one build is installed at a time. If the desk wants it, run N70 once on 3.0.87 BEFORE the C-77b install; it must fail.
5. **Not drafted:** the copy-then-erase-the-original case (pre-review E item 3.2.3), an exact-snap case, and the BUG-857 robot pair N33_grade_mismatch_x / _off (named in the fix report, not in this job).
6. **The J8 box at 150 percent scaling** is judged only at whatever scale this PC uses. The brief asks Codex to write the scale and the box size.
7. **PROVES_BUGS and REVIEWED_AGAINST are empty** in every case file, for the Opus review to fill.
8. **One acad.exe was already running** when I validated. Validate starts no AutoCAD (library mode, file reads only), so it was not mine. I did not look at whose it was.
9. **Not touched:** existing cases, briefs, CONVEYOR_QUEUE.txt, the runner, the ledger, the carpark, the desk log.
