# Test runner phase 3, batch 2 of 3: runner fixes, case fixes R11 to R20, new daily-tool cases R21 to R30 (Sat 24 Oct 2026)

Written Sat 24 Oct 2026 about 18:10 Melbourne (PC clock) by the Team Sonnet job "TEST RUNNER PHASE 3, BATCH 2 OF 3". Job ran 11:42 to about 18:10. Opened real AutoCAD 2027 on test copies only: 59 AutoCAD sessions, 335 minutes of AutoCAD time (probes and proof runs included), one session at a time under the shared lock as `Claude-driverv3`. Nothing in `DESK_LOG.md` or `BUG_CARPARK.md` was edited. Nothing is Tim-accepted. Built and run by me; **not independently reviewed** (see "Acceptance" below).

## ANSWER FIRST

1. **Runner fixes done, both proved.** (a) The runner no longer prints ACCEPTED-READY on a builder-filled review: it needs a `<case>_*.review.txt` from the independent reviewer that says `VERDICT CLAUDE-ACCEPTED-READY` for the exact case text. (b) Every case after the first in a session now starts on a fresh copy of the drawing and has its own command-line log start, so no case can pass on another case's leftovers. Proof: a case that passes only on leftovers PASSED with the old shared behaviour and FAILED both of its checks with the fix (runs `p3b2isoLEGACY2`, `p3b2isoFIXED`, `iso`).
2. **Case fixes R11 to R20 done and re-run twice in separate sessions.** R11, R12, R14, R18 have the stronger checks the review listed; R16 and R20 have broken variants; R13, R17, R19 are extended (R17 now counts exactly one pipe after the Enter contrast; R19 asserts the whole sentence and exactly 1039 objects; new R19b erases the pit P3 that has six pipes). R15 was not touched. Every changed case has two passes on one installed build and a recorded FAIL on a broken variant (R19b has no broken variant yet).
3. **New daily-tool cases R21 to R30 written and run twice.** Three of the ten groups cannot be fully proved on this PC yet; one is a real CE fault.
   1. **R21 CDCHECK totals (triage C1, D28 neighbour): PASS, PASS** (Civil 3.0.73, runs n1 and n4). Evidence: both answers printed `[CE] CDCHECK: 212 objects, 184 connections: 179 Connected, 1 Possible, 4 Unresolved, 0 Not Connected`; 1034 objects before and after; file hash 34BBE37C2EA4 unchanged. Bug claimed: none. Red: R21_broken FAIL.
   2. **R22 CDCHECK words (triage W9): FAIL, FAIL (real CE fault, known).** Evidence: `[CE] Pipe end 1. Pipe 450 (handle 109359): one end is not connected (the start).`, `1. CE-CIV-PIPE-20707BD7-D950-495C-BCBB-F3CF8515534F flows from TG1: Unresolved (not confirmed from the other side)` and `8. CE-CIV-PIT-1773A76E-0F91-4329-8B40-3F68DB663CC7 flows from CE-CIV-PIPE-3EC51633-...`. Bugs: BUG-372, BUG-814 (item 3), BUG-360 (internal ids). The raw `U+2192` escape of BUG-389 was NOT seen in these 97 lines (not proof it is fixed: the drawing may hold no old pipe names).
   3. **R23 locked pipe layer (triage L2): PASS, PASS** (n1, n4). Evidence: one pipe: `[CE] Pipe not opened for editing: layer STORMWATER PIPE is locked, and CE will not unlock it. Nothing was changed.`; two pipes: `[CE] The batch editor was not opened and nothing was changed: layer STORMWATER PIPE is locked (pipe P4 -> P3; pipe AGI -> C1). CE will not unlock it: ...`; no editor window; every 'IL ' text unchanged. **Proves BUG-384** (pending the independent review). Red: R23_broken FAIL (layer not locked: a real switch).
   4. **R24 metre drawing (triage T1): FAIL, FAIL, after one earlier failed discovery run: stopped after 3 failures.** Evidence: with INSUNITS set to 6 the new pit is read with `"xscale":1.0` (1900 units wide, not 1.9), and CD from 150,-80 to 170,-80 then says "Both ends are on the same pit" and disables Start Pipe. What blocked it: **no drawing authored in metres exists on this PC** (the three `DRV*_METRE` masters read INSUNITS 4, pits at x 100000, 141 identical objects). The FAIL may only be the effect of switching units after CE loaded. Not filed as a bug. Needs a real metre fixture.
   5. **R25 Pit Schedule (triage S1 S2 S3, D21/D23, read only): PASS, PASS** (w1, w2, Civil 3.0.74). Evidence: `Will be placed: 27 rows`; pit P3 listed; Close pressed through v3 and the window closed; file unchanged. Window case: picture and look note saved (below). Cell edits are NOT driven.
   6. **R26 CDSURVEY (triage V1, D26 survey half): PASS, PASS** (n1, n4). Evidence: `[CE] Please click directly on the survey XREF block.` after a pick of the pit, then `[CE] CDSURVEY cancelled - nothing stored.`; a second CDSURVEY still says `Survey: not loaded`. Only "a refusal stores nothing". No survey Xref exists, so BUG-699 to BUG-709 are not proved.
   7. **R27 CDDESIGN window (triage D1, start of route): PASS, PASS** (w1, w2, Civil 3.0.74). Evidence: `[CE] 2 of 6 things this design needs are set.`, five tabs, `Land use not set.`, file unchanged. Window case: picture and note saved. No design number is proved.
   8. **R28 CDPROFILE (triage Q1, start of route): PASS, PASS** (n2, n5). Evidence: `Select starting CE pit for profile review:`; the typed point on pit P3 was answered `Select a CE pit block.` (the pick did not take a pit, so the route past the first prompt is NOT driven).
   9. **R29 CDIMPORTLANDXML (triage X1, start of route): PASS, PASS** (w1, w2, 3.0.74). Evidence: window `Creative Engineering | LandXML import`; `CDIMPORTLANDXML cancelled. Nothing was drawn.`; 1034 objects and file unchanged. Window case. The import itself is NOT driven (no LandXML file, a case cannot drive the file chooser).
   10. **R30 CDMANAGER (triage MG1, start of route): PASS, PASS** (w1, w2, 3.0.74). Evidence: window `Creative Engineering | Drawing Standards Manager` opens and closes, file unchanged. Window case. This is the Drawing Standards Manager, not the CE Manager update window. Support zip, click log, update window are NOT driven.
4. **Acceptance by the rule.** **ACCEPTED-READY: 1 (R15)**, printed by the runner in run `r15b` on Civil 3.0.73 because its independent review file matches its text (SHA-256 6626D755...) and it passed in two sessions. **Everything else is PASS-UNREVIEWED** (the runner says "no independent review ..."): R11, R12, R13, R14, R16, R17, R18, R19, R19b, R20, R21, R23, R25, R26, R27, R28, R29, R30. The older review files of R11 to R14 and R16 to R20 no longer count: their cases changed, and their verdicts were not "ready" anyway. R22 and R24 FAIL.
5. **Bugs the desk may write as FIXED (Claude-accepted, build, date): none yet.** The only bug a case proves is **BUG-384** (R23, two passes on Civil 3.0.73, red on R23_broken), and it still needs the independent review (condition four). Every other case has an empty `PROVES_BUGS` line on purpose.
6. **Three things the desk should know first.**
   1. **The installed build moved three times during the job:** Civil 3.0.72 to 3.0.73 before 11:45, Structural 1.0.122 to 1.0.123 about 13:08, Civil/Manager 3.0.74 / 1.1.74 about 17:30. The runner counts passes per build, so each case is reported on the build where it has two passes (listed below). Nothing was re-run on 3.0.74 except R19b, R20, R25, R27, R29, R30 and the isolation proof.
   2. **R22 is a real fault on the command line:** CDCHECK still prints raw handles and `CE-CIV-PIPE-` / `CE-CIV-PIT-` ids on 3.0.73.
   3. **CDTWL's freeboard has two keys and either one changes it** (R14 variants, below): a Settings-first question.
7. **Runtime.** Sessions ran 2 to 15 minutes. A case with SETUP-R47 (new pit, new pipe) takes 4 to 7 minutes now because each case runs the setup again in its own fresh drawing. All case TIMEOUTs of those cases are 900 s.
8. **What is missing (see the last section for the full list).** A real metre drawing (T1), a survey Xref (V1), a LandXML file and a way to drive the file chooser (X1), Pit Schedule cell edits (S1), the long section itself (Q1), the CDDESIGN numbers (D1), the Manager zip and click log (MG1), a words sweep wider than CDCHECK (W9), the independent reviews, and Codex looks at four window pictures and at R18's label direction.

## Acceptance, build by build (the rule: two passes on one installed build, no FAIL or FLAKY on it, an independent review for this exact text, and for a bug case a FAIL on a broken variant)

1. **Civil 3.0.73, Structural 1.0.123, Manager 1.1.73 (two passes each):** R11 (f1, f6), R12 (f1, h1), R13 (f2, h2), R14 (f2, h2), R15 (r15a, r15b; untouched file), R16 (f5, f7), R17 (f4, f6), R18 (S2b, g1), R19 (S2b, f3), R21 (n1, n4), R23 (n1, n4), R26 (n1, n4), R28 (n2, n5).
2. **Civil 3.0.74, Structural 1.0.123, Manager 1.1.74 (two passes each):** R19b (h3, t1), R20 (h3, t1), R25 (w1, w2), R27 (w1, w2), R29 (w1, w2), R30 (w1, w2).
3. **FAIL on both runs:** R22 (n1, n4, known), R24 (n3 and its re-run, after a failed discovery run).
4. **Red before green (a FAIL on a deliberately broken variant, all on the same text as the case):** R11_broken, R12_broken, R13_broken, R14_broken, R14_dstd_broken, R14_pipekey_broken, R15_broken (3.0.72), R16_broken, R16_off_broken, R17_broken (3.0.72), R18_broken, R19_broken, R20_broken, R21_broken, R23_broken, R25_broken to R30_broken (R25_broken and R29_broken on both 3.0.73 and 3.0.74; R27_broken and R30_broken on 3.0.74; R26_broken and R28_broken on 3.0.73). R19b has none yet; R22 and R24 fail for real.
5. **Old FAIL and FLAKY on record (different build or text, listed so nobody is surprised):** R19 FAIL then FLAKY on 24 Oct 12:42 (Structural 1.0.122, a log-start fault of the runner, fixed the same day; both later passes are on 1.0.123); R12 FAIL twice on an earlier text of the check (stale list read in my own draft); R27 FAIL twice on an earlier text (it pinned `[CE] The job: already set.`, which is not always printed).

## The runner fixes, listed loudly (additive; v2, v3 and both allow-lists untouched)

Driver files at the first and the last run were identical: v2 120EE24D15B2, v2 allow-list 5B542F2145F4, v3 7CADBF80D5AA, v3 session 9A7B8D210C7F, v3 allow-list B8B495131283, v3 watchdog 20EB2449248E. Backups of the files I changed (before this job) are in `C:\ce_rc_scratch\p3b2\` (`case_runner.ps1.bak_before_p3b2`, `case_runner_lib.ps1.bak_before_p3b2`, `SETUP-R47.orig`, `R11.orig`).

1. **`case_runner.ps1`: review gate.** New function `Get-CaseIndependentReview`; `Resolve-CaseAcceptance` now reads it. A `REVIEWED_AGAINST` line in the case, builder-filled or not, never counts. The review file must sit next to the case (`<id>_*.review.txt`), hold `VERDICT CLAUDE-ACCEPTED-READY`, a `CASE_SHA256_REVIEWED` equal to the SHA-256 of the case text being run, and a `REVIEWER` line that is not the builder. Seen working: R15 printed ACCEPTED-READY; R11 printed "no independent review: the independent review (R11_edit_pipe_cascade_u_redo.review.txt) does not say CLAUDE-ACCEPTED-READY".
2. **`case_runner.ps1`: fresh drawing and own log start.** New function `Invoke-CaseFreshDrawing`, called at the start of every case after the first in a session: v2 `reopen-copy -Force` (CE never saves, so the copy on disk is still the master copy; the runner stops with BLOCKED if the file hash changed), then one v2 `history 1` call, then the case's log start byte is taken. A case that names a SETUP runs it again in its own drawing. `CASE_RUNNER_LEGACY_SHARED=1` switches the whole thing off (used only for the proof).
3. **The log-file finding that made item 2 work:** after a reopen, AutoCAD writes the command line to a NEW log file (for example `CLDV31351381_B1_1e37157f2.log`). My first version took the start byte from the old file; case R19 then read only 4 lines and failed. The `history 1` call makes v2 re-read the log name; the case report now says "the command-line log moved to a new file".
4. **`case_runner.ps1` and `case_runner_lib.ps1`: `PROVES_BUGS` header** (optional; printed in the report as `PROVES_BUGS ...`), and the result record carries it.
5. **`case_runner_lib.ps1`: a failed `history has` check now prints the first three lines it read, the log file name and the start byte.**
6. **`cases\_setups\SETUP-R47.setup.txt`: one added read-only step** (`ui-dump "New Pipe" -> $np_win` before Start Pipe) so R18 can compare the label with what the window held. **New `SETUP-ISO1`** for the isolation proof.
7. **`cases\README_CASES.md`: a new section** describing 1 to 5 and the chaining rule (typed text is refused while a CE command waits at a prompt).
8. **Proof, step by step.** `variants\ISO1_leaves` draws a circle and prints a marker line (`ID 7771,8882`); `variants\ISO1_probe_broken` passes only if it can see them (drawing holds 1035 objects, command line holds `7771.000`), both with SETUP-ISO1.
   1. Old behaviour (`CASE_RUNNER_LEGACY_SHARED=1`, run `p3b2isoLEGACY2`): **both PASS** (the probe passed on the earlier case's leftovers).
   2. New behaviour (run `p3b2isoFIXED`, and again as run `iso` on Civil 3.0.74 after the log fix): the probe **FAILS both checks** (`$n_seen = 1034 (expected = 1035)` and `no command-line line contains '7771.000' (0 lines read)`).
9. **Not changed, still true:** `case_selftest_offline.ps1` still fails its old check "ten real cases exist" (there are now far more); it ran 62 ok, 1 failed.

## The case fixes R11 to R20 (what the review asked, what was done, what the runs showed)

1. **R11 Edit Pipe cascade with U and REDO (C40).** Added `IL 17.60`, `IL 17.50` and the exact after-cascade string of 46 texts; first check now pins P3's two levels and the four downstream pipes. **PASS, PASS** (3.0.73: f1, f6). Evidence: `[CDEDIT-CASCADE] Updated 4 pipes and 3 pits from P3 (IL 17.50). Min grade: 1:16.`; after U the whole set equals the set before; after REDO `Everything has been redone` and the set equals the after-cascade set. Red: R11_broken puts a CIRCLE between U and REDO (the review's truer red) and FAILS `Everything has been redone`. Still part only: stored project data, the STUB warning and the Recalculate box wording are not read.
2. **R12 quick MOVE (C41).** The window check is now exact (`equals $win1 $win0`, `equals $win2 $win0`; only the AutoCAD window is open throughout) and the labels are read. **PASS, PASS** (3.0.73, f1 and h1). Evidence: pit P3 moves to y -23569.8 and back; six invert texts within 4000 mm of the pit are the SAME six objects before the move, after it and after U; text 1101B8 moved 1990.3 mm and text 116BB6 moved 1988 mm (2000 +- 150 asked). Finding: **the invert texts DO follow the pit** (moves 1892 to 1990 mm in the probe), so the review's "leaves its labels behind" fear did not happen on this pit. Red: R12_broken FAIL twice. BUG-816's line (`[CE Civil] pipe P3 -> P2 label: no clear spot among its usual positions ...`) still prints on a MOVE with Tidy labels off (3.0.73).
3. **R13 CDSYNC (D27 half).** Whole warning sentence asserted (`[CE] CDSYNC will re-link every pit and pipe in this drawing to CE's records, from what is currently drawn. One U undoes it.`). **PASS, PASS** (f2, h2). Red: R13_broken expects the untouched copy's `Pits relinked: 11, Pipes relinked: 49` and FAILS. **Stays part only, on purpose:** the Pit Schedule figures (C42) are not compared, and CDREBUILD (second half of D27) has never been driven (its prompts are unknown).
4. **R14 CDTWL freeboard (C39).** Added the two named 110 mm lines (pits P1 and P7), "asks nothing more" (`CMDACTIVE` = 0). **PASS, PASS** (f2, h2). Reds: R14_broken (41 mm) FAIL; **R14_dstd_broken** (`designStandards.detentionFreeboardMm` = 100) FAIL; **R14_pipekey_broken** (`pipe.detentionFreeboardMm` = 100) FAIL. **Finding: changing EITHER key to 100 changes what CDTWL says** (no 110 mm lines, the 40 mm line no longer says "150 mm is wanted"), so CE reads both or one overwrites the other. Tim's file holds the value twice. This is the Settings-first question the review raised; no bug entry exists, steps to file: set one key to 100 with the settings guard, run CDTWL with answers 10 and 18.70 on DRV1_B1 after the P8 setup, read the wording.
5. **R15 Recover Inverts.** File untouched (SHA-256 6626D755...). Re-run on the new build: **PASS, PASS** (r15a, r15b), runner printed **ACCEPTED-READY** (review file matches).
6. **R16 Tidy labels names the pipe (C37, BUG-856 regression guard).** Added `Placed by hand (left alone) 0`, `No clear spot found 1`, `No clear spot found: pipe P3 -> P2 label.`, and `SPOT LEVEL` for block 10EC5D. **PASS, PASS** (f5, f7). Reds: R16_broken (expects pipe P9) FAIL; **R16_off_broken** (the true red: Tidy labels OFF as in Tim's real file) FAIL, and CE said `[CE] Tidy labels is switched off. Nothing in the drawing was changed.` and asked `Switch Tidy labels on for this computer now? [Yes/No] <No>:` (the case typed `All`, which is an invalid keyword, so nothing was switched on). Remains "works when switched on".
7. **R17 Esc at CD's third point (D04).** The Enter contrast now places the pipe (levels 18.000 and 17.900) and counts exactly one new pipe; "nothing left" now means zero new objects. TIMEOUT 900. **PASS, PASS** (f4, f6). Evidence: `[CE] CD command cancelled.`, `count $left = 0`, `count $pipe_new = 1`. Red: R17_broken (3.0.72, unchanged). Now full D04.
8. **R18 pipe label (D10).** The New Pipe window is read before Start Pipe; the label must equal it. **PASS, PASS** (S2b, g1). Evidence: label `225 DIA. UPVC PIPE AT 1 IN 200`, window shows `225 mm` and `UPVC`, label 262.8 mm from the pipe middle, insertion point y -79762.5 (above the pipe line at -80000). Red: R18_broken FAIL. **Still a Codex look:** that the label reads left to right on the Above side. **Still unknown:** where 225 comes from (Tim's Settings file holds pipe.diameter 100); the case is tied to what the window shows on this PC.
9. **R19 erase a pit (D14).** Whole sentence asserted and exactly 1039 objects after the erase. **PASS, PASS** (S2b, f3). Red: R19_broken (expects "2 pipes now have ends") FAIL. **New R19b** (the several-pipe branch, pit P3): **PASS, PASS** (3.0.74: h3, t1). Evidence: `The pit was erased and the schedule is updated. 6 pipes now have ends that are Not connected yet. U restores everything.`; pipe 10A98D still there; U brings P3 back. R19b has no broken variant yet.
10. **R20 CDEDIT keeps the selection (D17).** Added `not-contains $win1 "Edit Pipe"`. **PASS, PASS** (3.0.74: h3, t1). Red: **R20_broken** (selection cleared after Save with `v3 deselect`) FAILS: `pick-first set: 0 object(s)`. Closest to ready of the daily tools, as the review said.

## The new cases R21 to R30 (design, route, what is NOT proved)

1. **How the ten were chosen.** From triage section A1, the next ten groups that no existing case covers: **V1, W9, X1, MG1, Q1, T1, C1, L2, S1, D1** (106 bugs). Each was probed first (probe cases in `C:\ce_rc_scratch\p3b2\probes\`, not in the pack), then written. A group that could not be driven past its first prompt still got a case that proves its start, with `NOT_AUTOMATED` naming every bug it does not prove.
2. **R21** `cases\R21_cdcheck_totals_add_up.case.txt`, route: `CDCHECK{NL}` (Enter takes All) and `CDCHECK{NL}Problems`. Prompt read on 3.0.73: `CE check: show all connections, problems only, or save as CSV [All/Problems/Csv] <All>:`. Not proved: the "Nothing in the drawing was changed." sentence (BUG-461) and the palette counts (BUG-809 item 1). Observation: both runs logged `Command outcome: CDCHECK cancelled` although the report printed in full (the Esc at the action prompt ends it); BUG-862 family.
3. **R22** `cases\R22_cdcheck_words_no_internal_ids.case.txt`, header `EXPECT-FAIL BUG-372`. It checks only the CDCHECK command line. Palette rows (BUG-753) and the Pit Schedule footer (BUG-360) are not read.
4. **R23** `cases\R23_locked_pipe_layer_cdedit_refuses.case.txt`, `PROVES_BUGS BUG-384`. Lock is AutoCAD's own `-LAYER Lock STORMWATER PIPE`. Not claimed: BUG-797 (CDEDIT refuses before any cascade can start; CDPROPAGATE is not driven), BUG-254 family, pits and Xrefs. That the layer stays locked is shown only by CE's second refusal.
5. **R24** `cases\R24_metre_drawing_pit_size.case.txt`. See answer item 3.4. Its broken variant was BLOCKED once (`REFUSED: no key was sent (not_foreground)`, a tool problem) and not tried again after the case's third failure.
6. **R25** read only: `PITSCHEDULE`, `ui-dump`, `ui-press "Pit Schedule" "Close"`, `await-window-gone`. **v2 `ui2-close` on this window still ends in HARD TIMEOUT (3.0.73, probe PRB4); the v3 Close button works.** The title word "natural" is not asserted (row order is not read).
7. **R26** `CDSURVEY{NL}53777.7,-25569.8` in one string (typed text is refused while a CE command waits at a prompt: found in the first draft).
8. **R27, R29, R30** window cases, see "Window cases". R27 note: the count in `[CE] <n> of 6 things this design needs are set.` was **2 in a freshly started AutoCAD and 1 in a reopened copy of the same drawing** (probe and two n2 runs); the case therefore does not pin n. Possible fault (state lost on reopen) for the desk to judge; no bug entry exists. Steps to file: launch AutoCAD with DRV1_B1 (copy), run CDDESIGN, read the count, close the window; reopen the same copy (`reopen-copy -Force`), run CDDESIGN again, read the count.
9. **R28** note: the typed point at pit P3 was refused with `Select a CE pit block.` (probably another object lies on top there); picking a pit another way is the next step to try.
10. **Window cases (R25, R27, R29, R30): picture, SHA-256 and a look note for Codex** (notes are 1.1 to 1.3 KB, under 3 KB; pictures and notes stay on this PC under `C:\Lisp Files\_TEST_COPIES_20260923\pack_runs\case_RUN-20261024-1745-C3.0.74-w1\` and `...-1754-C3.0.74-w2\`). These four are KIND look: they stay PASS-UNREVIEWED until a Codex look is recorded (RULES 5.7).
    1. R25 `pictures\R25_pit_schedule.png`, 1440 x 800, SHA-256 6687359C179084363F6E8A97EB0EE5E624266AD5585DFF5FDA8EFA924668DF2F (same in both runs).
    2. R27 `pictures\R27_design.png`, 1280 x 800, SHA-256 4EC2E9EF... (w1) and 652C3187... (w2); not blank, not duplicate.
    3. R29 `pictures\R29_landxml.png`, 1160 x 760, SHA-256 62BA90D9FDD2C9C2A04ED071AE92723A40FEAE145287AFE4AB384F042F16CC07 (both).
    4. R30 `pictures\R30_standards_manager.png`, 1100 x 740, SHA-256 7AD5000A80C9AD24F70E1134059FFF0A5E2BFFAB9A0D8D983A5C08BD19ABC40A (both).
    5. **I looked at R25 and R30 myself (not an acceptance):** R25 reads cleanly. **In R30 the Draw Order list shows every layer twice** (20TEXT, 20TEXT, 25DIMS, 25DIMS, 25TEXT, 25TEXT, AGI DRAIN, AGI DRAIN ...). Possible duplicate-row fault: Codex to judge; no bug entry exists.

## Things that blocked a run and what I did (honest list)

1. **R13 and R13_broken BLOCKED "case time limit (300 s)"** in the first try: with the fresh-drawing fix each case runs its own 3 to 6 minute setup. Fixed by TIMEOUT 900 on the cases that name SETUP-R47 (R13, R14, R18, R19 and their variants). R15 keeps its 300 s (it is the file I was told not to touch) and still passed because it ran first in its session.
2. **R18 BLOCKED once (v2 HARD TIMEOUT while typing CD)** in run f3, a tool problem not a result; it passed in S2b and g1.
3. **R26 BLOCKED in the first draft:** typed text refused while CDSURVEY waited at a prompt; chained the answer in one string.
4. **PRB5 (probe) was refused an Esc while the CDDESIGN window was open;** windows are closed first in the cases.
5. **A desk install (`Desk-install-s43`) held the lock at the end of session S1;** the runner's end check printed a NOTE, not an alarm (AutoCAD gone, four settings files equal to the start).
6. **Settings:** Tim's four settings files are back at their expected fingerprints at the end: CD_Settings.json ACD64E79A33B, TIM_CE_CADTOOLS CS_Settings.json 622A246F7D3B, CE_CVL_SUITE settings.json EFE307C4FC74, Structural CS_Settings.json 2972CE70C514. The settings guard restored them after the R14 and R16 setting variants. No acad.exe is left and the lock is free.

## What is missing, what was NOT checked (RULES 5.9)

1. **No independent review of any case in this batch.** Every `REVIEWED_AGAINST` line is marked "builder-filled: Opus review still needed". The runner now ignores them.
2. **No real metre drawing (T1), no survey Xref (V1), no LandXML file and no way to drive the file chooser (X1), no Pit Schedule cell edit (S1), no placed long section (Q1), no CDDESIGN design numbers (D1), no Manager zip or click log (MG1), no words sweep beyond CDCHECK (W9).** None of those groups' bugs is proved except as stated for BUG-384.
3. **R13:** the Pit Schedule figures and CDREBUILD. **R18:** left-to-right reading of the label. **R19b:** no broken variant. **R11:** stored project data.
4. **Nothing was looked at by a person except my glance at two pictures.** No window was accepted by a machine.
5. **R22 was run on the CDCHECK command line only;** the Csv answer was not run (it writes a file beside the drawing) although it printed `CE-CIV-PIPE-` ids in the probe.
6. **Passes are on the builds named above.** A fix that arrives in a later build needs its own two passes.
7. **I did not check the code of the installed build against the cases** (no `git merge-base` of which commits are inside 3.0.73 or 3.0.74).
8. **The tool changes of batch 1 (msgbox-answer, the Edit pipe Save exception) were not reviewed by me;** the review of R11 to R20 already lists them.

## The file list (sizes and SHA-256; all under `C:\Lisp Files\_ACAD_DRIVER\`, which is not a git repository)


**RUNNER AND DOCS**

1. `case_runner.ps1`: 48803 bytes, SHA-256 7E3BC77F93F4FFC6D797E2FF19AE8775882C164646206FC75C4398BD9756603F
2. `case_runner_lib.ps1`: 53962 bytes, SHA-256 5AB2CBC1A5A0D54096BD4028F000D17C96B7C4E41430C3C0C11710F316C6EC63
3. `cases\README_CASES.md`: 10414 bytes, SHA-256 B2354B02441E282D1A6F1E6008DB81C565D8C27DB84D99C830368F4494A659B0
4. `cases\_setups\SETUP-R47.setup.txt`: 1537 bytes, SHA-256 0CB83BDF78538F247ADEF2B37DF755B2370A2830F368C1D01E90BB211FD71C07
5. `cases\_setups\SETUP-ISO1.setup.txt`: 230 bytes, SHA-256 3F5233FDD5DF1698DA68EF0CE570A8B63A73D89477933D0A051152B41B126E20

**CASES**

1. `cases\R11_edit_pipe_cascade_u_redo.case.txt`: 5577 bytes, SHA-256 BECE7698469D7151716F8C2FE350E85F241A58566AEC8EF2CE2502EC578C3DC6
2. `cases\R12_quick_move_opens_no_window.case.txt`: 3573 bytes, SHA-256 BE0C1289AA620BEE0A601FC7AF7D4549A259DF7C061183B0798E4B557CA39F09
3. `cases\R13_cdsync_warns_then_relinks.case.txt`: 2413 bytes, SHA-256 9C67E0C3E882D777CC39BB90D5853140CB0867184618582ABBFD6DA09AAD2369
4. `cases\R14_cdtwl_freeboard_150.case.txt`: 2233 bytes, SHA-256 0A5ED5AD8028A909574832C36A6FCFBB118F54D76D1462F0FBE6CEE01C929F5F
5. `cases\R15_recover_inverts_totals.case.txt`: 1609 bytes, SHA-256 6626D75574C6B81E6147C1962A618154B354412D9C11E85E343B766480DE9B9D
6. `cases\R16_tidy_labels_names_the_pipe.case.txt`: 3434 bytes, SHA-256 92E250C4F0FC2FA67B2142966ED845B2C62CFABB7E2483B30B46D3EA0A935218
7. `cases\R17_cd_esc_at_third_point.case.txt`: 2450 bytes, SHA-256 E252738D9455E7E90F0D12E8A301A92841D72532E1D6C024AEE67F0DE6F62F87
8. `cases\R18_pipe_label_text_and_place.case.txt`: 2672 bytes, SHA-256 0D40A7012C730F4A669DF409A6DAA1FD746F917626493E3E42AC709CA0A5760C
9. `cases\R19_erase_pit_keeps_pipes_u_restores.case.txt`: 2763 bytes, SHA-256 2F504E120147427C33ABB4AC951FA3381825B40BB02761815DDEEFD63ADEC4BA
10. `cases\R19b_erase_pit_with_several_pipes.case.txt`: 2113 bytes, SHA-256 E1C8E842CBCBA0E2F59472EB693744064913354D80CEDFF6C2B9BCB38A6E8DCF
11. `cases\R20_cdedit_keeps_selection.case.txt`: 2731 bytes, SHA-256 4CEA23828CEF576507C0B33CC7349C0AC4B277A4465A4EF04F98CDB1DF376CDE
12. `cases\R21_cdcheck_totals_add_up.case.txt`: 2348 bytes, SHA-256 89B64B53A3FDE72E6CC6EFA30F202B8C6C65CA17C57296BD5877409D039D4691
13. `cases\R22_cdcheck_words_no_internal_ids.case.txt`: 1881 bytes, SHA-256 BF70B18C4F7E3540FE0635797A78998CCE3A64A519C5A269FA66A8A3D9D69A50
14. `cases\R23_locked_pipe_layer_cdedit_refuses.case.txt`: 3474 bytes, SHA-256 4B41231B02F784A732E6F212A0EB863714757D197C1C9C0E7607C7301D7B3F01
15. `cases\R24_metre_drawing_pit_size.case.txt`: 2850 bytes, SHA-256 1BECEC091BED9D1AC0A99509DA615B541FE096A186F81811854EBC5BD3587231
16. `cases\R25_pit_schedule_reads_and_closes.case.txt`: 2624 bytes, SHA-256 2DB8A06D260F73E46BAEC306CC6C652A77EB190D5C27E528D9C4DE433B39640D
17. `cases\R26_cdsurvey_refusal_stores_nothing.case.txt`: 2231 bytes, SHA-256 03C9AE48C09787CDC5C3FEBE6FA266CD23A07A9E1EEB17BABDFBBF2440BA8581
18. `cases\R27_cddesign_window_opens.case.txt`: 2710 bytes, SHA-256 FF8E8F549086A44B13393622577C2F0B55A9DB22C87D0261741271CC439C6EBC
19. `cases\R28_cdprofile_start.case.txt`: 1689 bytes, SHA-256 0F760B331F7FC2F38B78B788221FA2113E3F73C07A4E6F4BC282683BF196250B
20. `cases\R29_landxml_import_window_cancel.case.txt`: 2292 bytes, SHA-256 6978F830B59BB80E259771586FD8255D0A6F203947761781F42A28872653356F
21. `cases\R30_manager_window_opens.case.txt`: 2111 bytes, SHA-256 47F342FDCE52BF058C1C2175E077DC6AEC3C46B0279FEAF6FADBC0B94F6A33F6

**VARIANTS**

1. `cases\variants\ISO1_leaves.case.txt`: 966 bytes, SHA-256 8B815CF98C4EAAB624E43ACC0767A5E174FBC2DBBC054CA87373B87DE1DA8BCF
2. `cases\variants\ISO1_probe_broken.case.txt`: 1017 bytes, SHA-256 C241BD5616FC1500C7B24BEBAC83AB9A8D29AD75C6A089684487AA917FD93822
3. `cases\variants\R11_broken.case.txt`: 5064 bytes, SHA-256 E1D11D8B41E6D383198900FA382A01F11689AD66FC1507BB7159B12928564914
4. `cases\variants\R12_broken.case.txt`: 811 bytes, SHA-256 BE0D5C18E2A4F303A082494E1EA44DEA88D61F6CA7E14E198735DB5FBA085072
5. `cases\variants\R13_broken.case.txt`: 2243 bytes, SHA-256 6E4E2CF98D341E2D02430F6BB57E04DC5E08339E0DAA059F33A778573B7AD990
6. `cases\variants\R14_broken.case.txt`: 770 bytes, SHA-256 0A1D406FC38A89BF361B377F7F37E32A82464665DBDA80D9982D75FCCAE681C6
7. `cases\variants\R14_dstd_broken.case.txt`: 2716 bytes, SHA-256 7A3DDB43627D26333E61A6408EDCDFA5DA08CC66257DB3176FABD8F829F84E53
8. `cases\variants\R14_pipekey_broken.case.txt`: 2689 bytes, SHA-256 2A7B5814A3ECF4116DDED1B934BF60FD8A193DBC647F7862790310228669B40C
9. `cases\variants\R15_broken.case.txt`: 726 bytes, SHA-256 C287A88ED7BF72E3251384E872797A624307A3B580C3A3ED1371EF1F9CDF2AA5
10. `cases\variants\R16_broken.case.txt`: 3010 bytes, SHA-256 04DA332F3DB48EE01CBA2D335CD8741B0E9E67FE281407B1B4C74E4BDEFAD134
11. `cases\variants\R16_off_broken.case.txt`: 3060 bytes, SHA-256 54B33C7AD833B85A5E51279763FEBDA4D1A666D35D7D485506ADD19DB278D651
12. `cases\variants\R17_broken.case.txt`: 820 bytes, SHA-256 0E7EB3448105B27A8172E8ECB5E8D697BD87AA4CF640C505D278379E0E97AFA3
13. `cases\variants\R18_broken.case.txt`: 786 bytes, SHA-256 4C7A96505BF45EF36727A298F697DF269D35C1FCAB206A6E3B265E744B703439
14. `cases\variants\R19_broken.case.txt`: 2425 bytes, SHA-256 89A64694C251AD4B99CC4F19854756E014085A19CEE3565FF9E3F7237501C8AB
15. `cases\variants\R20_broken.case.txt`: 1013 bytes, SHA-256 3F7D66A63C6B77F022A7162955BC9375B969AC6F788B9156AA10E6F468EF43E8
16. `cases\variants\R21_broken.case.txt`: 1499 bytes, SHA-256 EAC859981A7DF167D2C1C4A1D80098306F62FB912BBA62866DF595E3D2B7E64C
17. `cases\variants\R23_broken.case.txt`: 1531 bytes, SHA-256 CEEFFE54D5F38929473D4B24F595C0DFAEB7BEB1480874FA3DD6CDBBB7020A8D
18. `cases\variants\R24_broken.case.txt`: 1495 bytes, SHA-256 2AB1EF563FC9F164FDAABE3EFABF08DBFEE9FEA5FEBBB0784DD5BDF445FE7E30
19. `cases\variants\R25_broken.case.txt`: 1370 bytes, SHA-256 9D5315C4F21C1903D881C3AFF9AAC32D1F868B4D73B8109BD009AEB5B0C8D66C
20. `cases\variants\R26_broken.case.txt`: 1436 bytes, SHA-256 11AC232E63E68598E6489BD4697B14EA7F3DBCD5B9421F00541510100A16C90F
21. `cases\variants\R27_broken.case.txt`: 1632 bytes, SHA-256 B1D6221A7232F0F435934204945955F88C256D7E88C7FE76EBE22653B091023D
22. `cases\variants\R28_broken.case.txt`: 1179 bytes, SHA-256 9CC70A0B373F5C1479FEC0B7FA0C01ACDFCC5A7403E5EB0E013A45C279A13B93
23. `cases\variants\R29_broken.case.txt`: 1244 bytes, SHA-256 4A78C845348AA509E9E497EDD8026B1B179C7A1429263AB8CAA66DF215DF54FD
24. `cases\variants\R30_broken.case.txt`: 1130 bytes, SHA-256 8D21BECD0AAE940E0C1A22B83971D122737C5A1183B03BA2FF57D2F43D239561

**UNCHANGED DRIVER FILES (hash start = end)**

1. `acad_driver_witness_v2.ps1`: 373204 bytes, SHA-256 120EE24D15B25DA9D60288FD88881A49FB5945DBE22F55B1DE00305FB154A8B9
2. `acad_driver_witness_v2.allowlist.json`: 7260 bytes, SHA-256 5B542F2145F48936BFE11463933DA60FF9539927AB9AA0EAFEFB0169A1AADDB3
3. `acad_driver_v3.ps1`: 94981 bytes, SHA-256 7CADBF80D5AAF459273021E34A4ACF88AC27CF4611D2F1F20E879B8B2A1B907B
4. `acad_driver_v3_session.ps1`: 51941 bytes, SHA-256 9A7B8D210C7F93B73486726D8925E1DF8675CBBF88D47D583CEF7BB77EA9D31E
5. `acad_driver_v3.allowlist.json`: 3487 bytes, SHA-256 B8B4951312839CF54E14E8AF8A12E9354FE4AB0D55BCCCEBB7CF1B58FFE9662C

**Run evidence (in the repository, `areas\runner-reports\`):** 51 runs of this job, `RUN-20261024-1145-...p3b2isoLEGACY` to `RUN-20261024-1754-...w2` (.json and .md each), and `ledger.json` (the acceptance record; it also holds the rows of other jobs' runs). Tags: `p3b2iso*` (isolation proof), `p3b2fix*`, `p3b2disc*`, `p3b2prb*` (probes and discovery, not in the ledger), `f1` to `f13`, `g1`, `n1` to `n5`, `h1` to `h4`, `t1`, `r15a`, `r15b`, `iso`, `w1`, `w2`.

**Scratch (this PC only, not in the pack):** `C:\ce_rc_scratch\p3b2\` holds the probe cases (`probes\PRB1` to `PRB8`), the chain scripts and status files (`chain.ps1`, `chain\*.status.txt`), the generators (`mkvariants.ps1`, `to_look.ps1`, `fill_review.ps1`) and the summaries I read the ledger with (`ledger_final.ps1`, `sessions_summary.ps1`, `evidence.ps1`). Pictures and look notes: `C:\Lisp Files\_TEST_COPIES_20260923\pack_runs\case_RUN-...-w1` and `-w2`.

## Summary (under 100 words)

Both runner fixes are in and proved: the runner no longer accepts a builder-filled review, and every case now starts on a fresh drawing with its own log start. R11 to R20 are strengthened and re-run twice with broken variants; R15 alone is ACCEPTED-READY. Ten new cases R21 to R30 ran twice: eight pass (R23 proves BUG-384), R22 fails for a real fault (raw handles and CE-CIV ids in CDCHECK), R24 is blocked for lack of a metre drawing. The installed build moved to Civil 3.0.74 mid-job. Every other case still needs an independent review.
