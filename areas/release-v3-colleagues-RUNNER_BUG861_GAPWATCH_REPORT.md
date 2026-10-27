# BUG-861 gap watch and U-end switches on Civil 3.0.83 (Wed 28 Oct 2026)

Written Wed 28 Oct 2026 about 07:15 Melbourne (PC clock) by the Team Sonnet job "TEST ROBOT: NAME THE CULPRIT OF THE LOST REDO (BUG-861) WITH THE GAP WATCH AND THE U-END SWITCHES ON CIVIL 3.0.83". Real AutoCAD 2027 on test copies, one session at a time under the shared lock as `Claude-driverv3`, `CE_RUNNER_TIM_AWAY=1`. Run by me; **not independently reviewed**. BUG-861 is **not** marked FIXED. I did not edit `DESK_LOG.md`, `BUG_CARPARK.md`, any review.txt or `ledger.json`.

## ANSWER FIRST — FOR TIM

1. **Culprit: not found, but the gap now shows one clear difference.** On the first click after U, and only then, AutoCAD drops and retakes the drawing's write lock twice within 3 milliseconds. It does not do it on the second or third click, and it does not do it before REDO in the rounds that keep REDO. The log says no CE code was on the stack for those lock changes, so it was AutoCAD itself, a non-CE add-in or LISP. The log cannot say which one. This was in all 4 gap-watch sessions.
2. **Exact lines (first gap-watch session, pit click, round 1; `U` at 05:41:00.8, `REDO` at 05:41:18.2):**
   1. `05:41:04.962 gap: document lock changed: from Write to NotLocked, for command '', 4.16 s after U ended; no CE code on the stack (AutoCAD itself, a native add-in or LISP)`
   2. `05:41:04.963 gap: document lock changed: from NotLocked to Write, for command '#', 4.16 s after U ended; no CE code on the stack (AutoCAD itself, a native add-in or LISP)`
   3. `05:41:04.965 gap: document lock changed: from Write to NotLocked, for command '', 4.16 s after U ended; no CE code on the stack (AutoCAD itself, a native add-in or LISP)`
   4. `05:41:04.965 gap: document lock changed: from NotLocked to Write, for command '#', 4.16 s after U ended; no CE code on the stack (AutoCAD itself, a native add-in or LISP)`
   5. These four sit at the moment of the click. Round 2 (`U` 05:41:37.6, `REDO` 05:41:54.2) has only the lock take at U (`for command '#U'`) and the lock release at REDO. The same four-line pair appears in round 1 of the other three sessions (4.27 s, 2.76 s and 2.60 s after U).
3. **No system setting changed and no command ran in round 1's gap** in any session. Only the lock lines above and the REDO command start itself.
4. **Civil's work at the end of U is cleared.** With all of it switched off (`disableUndoEndWork`), REDO was still lost in round 1: 4 of 4 sessions (2 pit, 2 plain line). The log shows the skip line at every U and no "Project data reloaded after Undo/Redo" line, so the switch really worked. So I did not split it into the project-reload and cache-rebuild switches.
5. **The baseline fails on 3.0.83 like 3.0.81 and 3.0.82:** 4 of 4 sessions lost REDO in round 1 (2 pit, 2 plain line); rounds 2 and 3 kept it.
6. **Exact next step (needs your yes, because it moves installed add-ins):** run the same two cases with the Structural and Manager add-ins not loaded, then with all CE add-ins off. If REDO is kept, whichever add-in was off is the culprit. If it is still lost with every CE add-in off, the lock cycle on the first click is AutoCAD's own, and the case should be re-aimed to test REDO after the second click. Nothing in CE would need a fix.
7. **Nothing else for you to test or decide.** No AutoCAD is left running, no lock file, all four settings files are back to their expected hashes.

---

## Technical detail

1. **Builds read live, every run header start and end, Legacy, Modern and Net8 identical:** Civil 3.0.83+96455f13, Manager 1.1.83+96455f13, Structural 1.0.125+204dfad2. No install happened during the job, so no run is voided. Chain scripts stop if the Civil version changes; none stopped.
2. **Run ids (all `-NoRerun -NoLedger`, one case per fresh session, 3 minute or longer gap with AutoCAD closed).** Full runner reports are in `C:\CE_PLAN\areas\runner-reports\`.
   1. **Baseline, all diag keys off:** `RUN-20261028-0450-C3.0.83-g01a` (R08x_1_exact) FAIL, `RUN-20261028-0501-C3.0.83-g05a` (R08x_5_plain_line_first) FAIL, `RUN-20261028-0513-C3.0.83-g01b` FAIL, `RUN-20261028-0524-C3.0.83-g05b` FAIL. Each: round 1 REDO lost, rounds 2 and 3 pass, no `[REDO-DIAG]` lines, Inspector deferral line 7 times.
   2. **watchUndoGap = true alone:** `RUN-20261028-0535-C3.0.83-g11a` (R08x_diag_watchUndoGap), `RUN-20261028-0546-C3.0.83-g15a` (R08x_L_watchUndoGap), `RUN-20261028-0558-C3.0.83-g11b`, `RUN-20261028-0610-C3.0.83-g15b`. All FAIL in the same way as baseline (REDO lost in round 1 only), as expected. The start line `[REDO-DIAG] gap watch on (diag.redo.watchUndoGap)` is in each log.
   3. **disableUndoEndWork = true alone:** `RUN-20261028-0621-C3.0.83-g21a` (R08x_diag_disableUndoEndWork), `RUN-20261028-0632-C3.0.83-g25a` (R08x_L_disableUndoEndWork), `RUN-20261028-0643-C3.0.83-g21b`, `RUN-20261028-0654-C3.0.83-g25b`. All FAIL, round 1 REDO lost. In each CE log slice: 9 lines `skipped UndoEndWork ... (U end)`, 0 lines `Project data reloaded after Undo/Redo`, 0 undo/redo cache rebuild lines. (For comparison, a gap-watch session has 9 reload lines.)
3. **How I cut the gap lines.** The case runs a control round, then rounds 1, 2 and 3, then a final U. Round 1 is the second U in the log. Per session I took every `gap:` line from each U to the matching REDO. Lines per round, all four gap-watch sessions alike:
   1. **Control round and rounds 2 and 3:** `lock NotLocked to Write for command '#U'` right after U; `lock Write to NotLocked for command 'REDO'`; `command start: REDO`; then `#REDO` lock and `LINE` lock and command start.
   2. **Round 1:** the same, plus the four-line lock cycle quoted above at the click time. Nothing else.
   3. **Final U (after round 3):** `ProtectedAutoWrite to NotLocked`, `LOGFILEMODE`, `RIBBONSTATE`, `AutoWrite` lines at 24 to 28 s. These come from the case's end (Esc and view read), not from the click, and appear in every session.
   4. Full gap text for all 12 sessions: `C:\ce_rc_scratch\bisect861\log_g1_*.txt` (gap-watch) and `log_g0_*`, `log_g2_*`.
4. **What this does and does not show (rule 12.4/12.5).**
   1. The log shows: a write-lock release and retake pair, twice, at the first click only, with no CE frame on the stack.
   2. I have **not** shown that this lock cycle is what removes REDO. It is the only difference the gap watch sees between the failing round and the passing ones, so it is the lead, nothing more.
   3. "No CE code on the stack" is read from the managed stack at the moment of the lock event. It cannot tell AutoCAD from a native add-in or LISP, and I cannot say what AutoCAD does inside itself. The old limit still holds: no notification shows a transaction, so a transaction without a lock change would be invisible.
   4. Command text `''` and `'#'` is what AutoCAD reports for the lock owner at those events; I do not know what it means.
5. **Settings guard.** Each key run used `SETTING CD_Settings.json diag.redo.<key> true` applied before AutoCAD started and restored by hash. Read after the last session: CD_Settings.json **ACD64E79A33B**, CS_Settings.json (TIM_CE_CADTOOLS) **622A246F7D3B**, CE_CVL_SUITE settings.json **EFE307C4FC74**, CE_STRUC_SUITE CS_Settings.json **B3B5A004B929** (all as expected). AutoCAD running: 0. Lock file: absent.

## What I changed, listed loudly

1. **New case files, 8, all in `C:\Lisp Files\_ACAD_DRIVER\cases\controls\` (untracked, outside the repo):** `R08x_diag_watchUndoGap`, `R08x_L_watchUndoGap`, `R08x_diag_disableUndoEndWork`, `R08x_L_disableUndoEndWork`, `R08x_diag_disableUndoProjectReload`, `R08x_L_disableUndoProjectReload`, `R08x_diag_disableUndoCacheRebuild`, `R08x_L_disableUndoCacheRebuild` (each `.case.txt`). **Only the four watchUndoGap and disableUndoEndWork ones were run;** the ProjectReload and CacheRebuild ones were never run (not needed, see answer 4) and are ready.
2. **Source cases untouched.** Runner and driver files untouched. Installed bundles untouched.
3. **Scratch, this PC only:** `C:\ce_rc_scratch\bisect861\` (reused the 27 Oct scripts; I raised the log-line cut in `runone.ps1` from 260 to 900 characters so gap lines are not clipped; new lists `list_base.txt`, `list_watch.txt`, `list_end.txt`, chain logs `chain_gbase.log`, `chain_gwatch.log`, `chain_gend.log`, per-run `out_`, `hdr_`, `log_` for tags `g0_*`, `g1_*`, `g2_*`).

## Mistakes and caveats

1. I started the first chain through a hidden detached process and watched its log, instead of a harness-tracked background task. It finished on its own and nothing was left running (checked: no acad.exe, no lock file). I started no `tail -f`.
2. Step 3 of section 6 (add-ins moved aside) was not run, by the brief.
3. I looked at no screen. All results are runner command-line text, the case's own checks and CE log lines.
4. Counting rule: every key result is 4 of 4 (2 of 2 per case), so the "2 of 2 per case" standard is met for "REDO still lost"; nothing "kept REDO", so no repeat was needed.

## Summary (under 100 words)

Culprit not named, but the gap watch found one difference. On Civil 3.0.83 the first click after U makes the drawing's write lock drop and retake twice in 3 ms, with no CE code on the stack (AutoCAD or a non-CE add-in). Later clicks do not. Seen 4 of 4 sessions. Baseline lost REDO 4 of 4; disableUndoEndWork also lost it 4 of 4, so Civil's U-end work is cleared. Next, needing Tim's yes: Structural and Manager add-ins off, then all CE off. Eight variant case files added.
