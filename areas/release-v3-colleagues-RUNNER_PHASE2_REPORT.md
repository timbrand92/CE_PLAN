# Test runner phase 2: the case-file runner and the first 10 cases (report, Fri 23 Oct 2026)

Written by the headless job `tester_run` (Team, Sonnet), restart at 18:30 after the first run died at about 18:00. Runs on this PC between 18:42 and 23:30 Melbourne (PC clock), always outside Tim's AutoCAD hours, test copies only. **Built and run by the builder. Not reviewed by Opus as a whole. Not Tim-accepted. Nothing here is "accepted" in the RULES 4.5 sense.**

## ANSWER FIRST

1. **What is built.** A runner that plays a written test case in real AutoCAD with no AI in the loop: `case_runner.ps1 validate | run-case | run-pack`. A case is one text file. It names a drawing master, optional settings, the steps (typed command, LISP-free reads, window dump and press, real mouse click and double-click, CE log read by byte offset), the checks, the expected result, "why a unit test cannot catch this", and an EMPTY `reviewed_against` line. One AutoCAD session per case group, a FAIL is run again once in a fresh session, and the report (Markdown and JSON, in `C:\CE_PLAN\areas\runner-reports\`) lists PASS, FAIL or BLOCKED with the evidence line for every check, the exact installed build read from the DLLs, the run id and the pack SHA-256. The 10 first cases and 2 deliberately broken variants exist and run.
2. **The installed build tested:** Civil 3.0.72+f7f7d551, Structural 1.0.122+e6d597c0, Manager 1.1.72+f7f7d551 (read from the DLLs, AutoCAD 2027). The brief named 3.0.70 / 1.0.121 / 1.1.70; the case compares with the DLLs read live, so R06 passed against 3.0.72 / 1.0.122 / 1.1.72.
3. **The 10 cases, whole pack run twice (two separate AutoCAD sessions per case, same build).**
   1. **R01** PIT and CD keep placing until Esc, Esc keeps what was placed, one U takes the pipe back (daily case D01): run 1 PASS, run 2 PASS.
   2. **R02** a new pipe joins the new pit and the flow-arrow lines are right (D03): PASS, PASS.
   3. **R03** exactly one IL text at each pipe end (D12): PASS, PASS.
   4. **R04** CE never saves the drawing: file hash and time unchanged after CDSYNC and CDRECOVERINVERTS (D18, reduced: no Pit Schedule, no CDREBUILD, see item 6): PASS, PASS.
   5. **R05** a finished CE command writes one "Command outcome: ... completed" line to the CE log: PASS, PASS.
   6. **R06** About CE Suite lists Civil v3.0.72, Structural v1.0.122, Manager v1.1.72, no CONFLICT or Not loaded, closes by Close (a look case): PASS, PASS. The picture and the Codex look note are saved; **no person or Codex has looked yet.**
   7. **R07** the Settings window opens, Cancel closes it, the four settings files keep the same hashes (ACD64E79A33B, 622A246F7D3B, EFE307C4FC74, 2972CE70C514): PASS, PASS.
   8. **R08** REDO after U and a REAL MOUSE pick of pit P3, five times: **FAIL, FAIL.** The control with no pick says "Everything has been redone"; all five picks say "Nothing to redo". BUG-861 is open, so this is reported as a known failure. See item 5.
   9. **R09** double-click on the DP1 downpipe circle must open CE's "Edit source" window (BUG-859): **FAIL, FAIL, as the brief wanted.** AutoCAD's Enhanced Attribute Editor opened both times. It proves the case can fail, and it says the BUG-859 fix is not working on 3.0.72.
   10. **R10** CDCHECKIGNORE with its switch off prints "Ignoring a finding is switched off in CE Settings. Nothing was changed.", asks nothing, and the log says "CDCHECKIGNORE refused": PASS, PASS.
   11. **The two broken variants** (R08_BROKEN, R10_BROKEN) FAIL in both runs, as they must. That is the "red before green" record for R10 (same build) and R08.
4. **Acceptance field.** Every passing case is **PASS-UNREVIEWED**. None is ACCEPTED-READY, because `reviewed_against` is empty on all ten (the runner never fills it; a person or an Opus review must check each case against its card or bug entry). The other conditions are already met for R01 to R05, R07 and R10 (two passing sessions on this build). R06 also needs a look. R08 and R09 are FAIL (known), not pass.
5. **R08 needs a human look.** Control proves REDO works with no pick. A pick made by the driver's typed LISP also gives "Nothing to redo" (probe runs 19:19 and 19:22). A real mouse click on the pit gives the same, 5 of 5, in both pack runs. Plain AutoCAD does not lose REDO on a pick, so this looks like CE (the Inspector refresh after a pick), but the case does not prove the cause. Please tell Tim: "REDO after clicking a pit is lost on 3.0.72, five times out of five, in a repeatable test."
6. **What is missing.** Case R04 does not open or close the Pit Schedule (v2 `ui close` and `ui press` both hit a HARD TIMEOUT on that window, runs p1C2 and p1C5). CDREBUILD is not in R04. The right-click menu is not read. Codex has not looked at the R06 picture. `reviewed_against` is empty everywhere. The scaled 5120 x 1440 screen still does not exist on this PC. The pack has not been run on any build except 3.0.72 (earlier 3.0.71 attempts were blocked, see item 8).
7. **Runtime.** The pack runs as three AutoCAD sessions (the 600 second tool limit forbids one long call). Run 1 took 10 m 47 s + 9 m 57 s + 5 m 08 s = 25 m 52 s of AutoCAD time; run 2 took 4 m 52 s + 10 m 44 s + 12 m 15 s = 27 m 51 s. Waiting for the shared lock added about 90 minutes in total (Codex held AutoCAD for 30 to 40 minutes at a time, three times).

## What I changed in phase 1B files (listed loudly, both forced by CE screen changes)

1. **`acad_driver_v3.allowlist.json`** (SHA-256 now 459D4D9095CA…, pin inside `acad_driver_v3.ps1` re-set to match): three press-list additions. New Pit window: `New pit, Continue placement`. New Pipe window: `New pipe, Start Pipe`. Both Settings entries: `Settings, Cancel`. Reason: the CE windows now name these buttons with a prefix, so the old names no longer exist; v2 refused `New pit, Continue placement` by its whole-word deny list, and v2 `ui press` on the New Pipe button ended in HARD TIMEOUT about half the time because the call blocks until AutoCAD finishes (the v3 press does not block).
2. **`acad_driver_v3.ps1`**: the pin line (one line) and the Settings guard test on line 705, which now accepts `Settings, Cancel` as well as `Cancel` and `Close`. Backups of both files before the edit: `C:\ce_rc_scratch\acad_driver_v3.allowlist.json.bak_before_newpit` and `acad_driver_v3.ps1.bak_before_newpit`. The "Continue placement" never-press pattern is still there; the new name is listed explicitly for the New Pit window only.
3. **Untouched:** v2 (`acad_driver_witness_v2.ps1` 120EE24D15B2) and its allow-list (5B542F2145F4), `acad_driver_v3_session.ps1`, `acad_driver_v3_watchdog.ps1`. Tim's four settings files were restored by hash after every session (checked at 23:29: all four equal).

## Things that went wrong tonight (own them)

1. **A run was killed by the 30 minute background limit while it held the lock.** The f1A call waited 30 minutes for Codex, took the lock at 21:19:31, and the tool then killed the runner. My AutoCAD (pid 15880) and the lock sat there until my own watchdog cleaned up at 21:30 (10 minute pulse timeout): the lock was blocked for Codex for about 11 minutes. After that I only started a run when no lock file existed. The watchdog did its job (settings restored by hash, all four equal).
2. **After the f2A session an AutoCAD process (pid 83100, mine, started 22:59:04) survived as a zombie with no threads.** Settings were intact; the guard backups were kept until I ended it. I ended it by identity at 23:16 and it disappeared; `acad left: 0` in that report was not true when the report was written. Cause not found. The f2A report carries an ALARM; read this paragraph with it.
3. **The f1B report carries an ALARM too, and it is a false one:** Codex took the lock within 3 seconds of my release, so the end-of-session check read "lock held" and could not read the guard. AutoCAD was gone and the four hashes were equal. I changed the runner afterwards so this prints a NOTE, not an ALARM (f1C, f2B).
4. **The ledger holds debug runs.** Runs p1A, p1C and p1C2 (before I fixed the harness) wrote FAIL and BLOCKED entries for R01, R02, R04 and R09 on 3.0.72 into `ledger.json`, and R05, R06 and R10 passes. They are real runs of earlier versions of the case files (each ledger row carries the case file's SHA-256). I did not delete ledger rows. Because `reviewed_against` is empty nothing can be ACCEPTED-READY anyway; a reviewer should read the ledger by case SHA-256.
5. **A first-start failure:** the first AutoCAD start after a session that ended in a HARD TIMEOUT sometimes does not become idle within 240 s (seen twice). The runner now starts the session once more.
6. **Not tested:** nothing on 3.0.70 or 3.0.71 passed (the 3.0.71 attempts from the first run were blocked by the old button names). A real locked screen. Any look at the R06 picture. Anything on Tim's own drawings (never opened).

## What a developer needs to know (short)

1. **Names of real controls on 3.0.72:** New Pit window button `New pit, Continue placement` (id `C2.PlaceCommand`), New Pipe `New pipe, Start Pipe` (id `C2.OkCommand`), Settings `Settings, Cancel` (id `AdvancedSettingsDialog.CancelCommand`), Save `AdvancedSettingsDialog.OkCommand`, tabs `Settings, Settings Tabs, <name>`. A CE pipe is the object `CeCvlPipeObject`. The DP command prints "[CE] Pick the next DP" as a plain message, so v2 `-ExpectPrompt` never sees it; the case does not depend on it.
2. **`v3 deselect` does not work on this AutoCAD** (the SendCommand of two Esc answers "Invalid input"); the runner sends one real Esc key instead and writes a note.
3. **Pointer cases** (R08, R09) calibrate first (largest error 1.7 px raw, 0.6 px corrected in every session) and prove each click with AutoCAD itself. The pit P3 click uses the cross in the middle of the block (`-Part block:5`).

## Files (new or changed tonight; sizes in bytes, full SHA-256)

All under `C:\Lisp Files\_ACAD_DRIVER\`. Runner files as they were at the last run; `case_runner.ps1` was one edit older (the NOTE-not-ALARM change) for f1A and f1B, D82E5F84B7EE.

1. `case_runner.ps1` 43369 D0CEC6607CFD890F16C1626F99087818CCDDBF64AE0CD8B9AFB8E2E8E0105C41
2. `case_runner_lib.ps1` 51988 B74B27DA8BA47A9A99905412F5F9BD9F65D833BF5D0F51ADBFBDC77AD0D0F551
3. `case_selftest_offline.ps1` 7118 88592ABF44F87F7392641A2DFD4FCA487BA5D0DA071AA7617AD606A3F5B2F57D (46 checks, 46 ok; `validate cases` 12 files, 0 invalid)
4. `README_V3.md` 16596 B437D027D4B6105D2B94208A9F39B77E45E96296B4620B398209EE754E56E6B2 (phase 2 sections, including the evening additions)
5. `acad_driver_v3.ps1` 94136 FBD8EB84C32A2CC647A196E674888A0C816131B5D950960E3D85289244C9FB39 (changed, item above)
6. `acad_driver_v3.allowlist.json` 3425 459D4D9095CA32C7F119F4C38FC86E137F2A7AF0001BFD9968AFA5BA9F5A3847 (changed, item above)
7. `cases\README_CASES.md` 5714 037D531C8BE9DE8546EC460EFA97089F238E4A0C526CA6C5F6C2AEE9CD4666C1
8. `cases\_setups\SETUP-P8.setup.txt` 1145 7A241608EB590525E0F1D37AB459F9D7116677D17AD6CD5C4C2D6C97FC496F03
9. `cases\R01_pit_cd_until_esc.case.txt` 2668 B5D037F05F67DA3825D056658784A04FF61FC42B4B962DC5F6568B0B503E6280
10. `cases\R02_pipe_joins_pit.case.txt` 1632 5C427BD8C98BBD350A0B3CB502EAFD7A8C6F2B53BAFC4028B972AD2EDFFD3448
11. `cases\R03_one_il_text_each_end.case.txt` 1092 A3884B9981893526324E8F348F84BAF0FA1E369F4FAFDF856EB7FAB62D0722BE
12. `cases\R04_ce_never_saves.case.txt` 1707 E7168D28488F8E3C034356E363BAAC26E195DA811B583B2E141F49A610F68F0F
13. `cases\R05_outcome_line_completed.case.txt` 1190 BDBDFD1BD95B3C96CDE57F99C492145AC1363734677639031EC1021258D03FA5
14. `cases\R06_about_ce_suite_versions.case.txt` 1865 C783FF31387FB9E7596A0561AB58714433BF5FA14D8D262BB050428DF7DDC9EA
15. `cases\R07_settings_window_cancel.case.txt` 1775 1BC27A975FA980BE7E5C9940104F61698280140B70FE84DC556D2244127A6052
16. `cases\R08_redo_after_pick_x5.case.txt` 3201 C85AD573250CED7EF723CF57939792B70BC7A119ED54E4EFA137FF640C01F4F3
17. `cases\R09_dp1_double_click_edit_source.case.txt` 2377 E08D471171A9353A74C1B2E153CB39A51E9B294990780A61AA5569D1795D4631
18. `cases\R10_cdcheckignore_switch_off.case.txt` 1604 257652544A2D3CDC204FBA667D6051830E7541EF7EB88E254314313D977DB7CE
19. `cases\variants\R08_broken.case.txt` 909 896E6F971315E6CED21F2394AD11C6B820E01AF1AEC41A72BD5F8AE29D4B2CD1
20. `cases\variants\R10_broken.case.txt` 800 65154DAAC404CAA6DCD12006251231948362ED8F56674293D2CD0BE78EDAD416

Pack SHA-256 (all case files plus variants plus the shared setup): C2231AAFB43FF3FD09FF5EF6B7AF6AD2FA79B9150F7CCD262621BDBE863A425B (used by f1A, f1B, f2B); without the variants: 6D4F108BB999545DFFF33DD2EFC3163A1FEDBE5E66783836992AB833CEA68FED (f1C, f2A, f2C).

## Evidence (all in `C:\CE_PLAN\areas\runner-reports\`)

1. **Pack run 1:** `RUN-20261023-2148-C3.0.72-f1A` (R09, R05, R06, R07), `RUN-20261023-2201-C3.0.72-f1B` (R10, R08 and the two broken variants), `RUN-20261023-2248-C3.0.72-f1C` (R02, R03, R01, R04).
2. **Pack run 2:** `RUN-20261023-2254-C3.0.72-f2C`, `RUN-20261023-2258-C3.0.72-f2A`, `RUN-20261023-2317-C3.0.72-f2B`. Each has a `.md` and a `.json`.
3. **Earlier and debug runs kept as evidence:** `...1400...a`, `...1731...a2` (build 3.0.71, blocked by old button names), `p1A` to `p1A4`, `p1B`, `p1B2`, `p1C` to `p1C5`, `probe` to `probe6` (the REDO probes: control works; typed pick fails; real mouse pick fails). `ledger.json` is the acceptance record.
4. **Pictures and the look notes** stay on this PC: `C:\Lisp Files\_TEST_COPIES_20260923\pack_runs\case_RUN-20261023-2148-C3.0.72-f1A\looks\R06.md` and the same under `...2258...f2A`. The About window picture SHA-256 is 07A0C4C8D288CB406AF60B6F33E7CA005D680184E9988D58147DCC13D36DCC68.

## Do next (for the desk)

1. Ask Codex to look at the R06 picture and write the verdict on the look note.
2. Have Opus (or Tim) check each of the ten cases against its card or bug entry and fill `reviewed_against`; then R01 to R05, R07 and R10 become ACCEPTED-READY at once (the other conditions are met).
3. Treat R08 (REDO lost after a click on a pit) as a real BUG-861 reproduction until someone shows otherwise.
4. Decide whether R09's FAIL on 3.0.72 means the BUG-859 fix (PR 1522) is not in this build.

**Summary (under 100 words).** The case-file runner works: 10 cases plus 2 broken variants, whole pack run twice on build 3.0.72 (each about 26 to 28 minutes of AutoCAD). R01 to R07 and R10 passed both times; R08 (REDO lost after a pit click, 5 of 5) and R09 (double-click opens AutoCAD's attribute editor, not Edit source) fail both times, and both broken variants fail as they must. Nothing is ACCEPTED-READY: `reviewed_against` is empty and R06 still needs a Codex look. I changed two phase 1B files (three button names). Two session-end alarms are explained above.
