# Runner batch 2 fixes: what the independent review asked, done and re-proved (Sun 25 Oct 2026)

Written Sun 25 Oct 2026 about 08:55 Melbourne (PC clock) by the Team Sonnet job "TEST RUNNER: FIX WHAT THE BATCH 2 REVIEW ASKED, AND RE-PROVE ON THE INSTALLED BUILD". Job ran 07:46 to about 08:55 on a Sunday (free window). Opened real AutoCAD 2027 on test copies only: 13 sessions (3 probes, 9 proof sessions, 1 Pit Schedule probe), about 62 minutes of AutoCAD time, one at a time under the shared lock as `Claude-driverv3`, foreground only. Nothing in `DESK_LOG.md`, `BUG_CARPARK.md`, any `review.txt` or `ledger.json` was edited by hand (the runner wrote the ledger rows). Built and run by me; **not independently reviewed again**.

## ANSWER FIRST

1. **The installed build is NOT 3.0.74.** Read live from the three runtime folders at 07:49 and again in every run header: **Civil 3.0.75+2c805a39 / Manager 1.1.75+2c805a39 / Structural 1.0.123+4af3f37d**. The job text said 3.0.74; the build moved on before this job started. Every run below is on 3.0.75. Nothing was run on 3.0.74. The two-pass count is on 3.0.75, one build, with no FAIL or FLAKY on it.
2. **All asks done. Every case passed in both of its sessions; every broken variant went red.**
   1. **R23 (locked pipe layer, BUG-384): PASS, PASS.** Run ids `b2d1` (RUN-20261025-0758) and `b2d3` (RUN-20261025-0823), Civil 3.0.75. Evidence: the two-pipe refusal is now pinned whole, `[CE] The batch editor was not opened and nothing was changed: layer STORMWATER PIPE is locked (pipe P4 -> P3; pipe AGI -> C1). CE will not unlock it: unlock it, or choose other pipes, then edit again.`, plus `label records do not match` absent. Header now `BUG BUG-384` and `PROVES_BUGS BUG-384`. Red: `R23_BROKEN` (layer not locked) FAILED in `b2d1`: Edit Pipe and Edit 2 Pipes opened. R23_BROKEN now carries the new sentence check too (its text changed, so its red is recorded on the new text). File hash 47044D1E70E6.
   2. **R12 (quick MOVE): PASS, PASS.** `b2d1`, `b2d3`. Evidence: after U the two invert texts are back exactly: `$ret_a = 0`, `$ret_b = 0` (asked 0 +- 0.5 mm); the move itself was 1990.3 and 1988 mm. Red: new variant `R12_NOU_BROKEN` (MOVE with no U) FAILED in `b2d1`: `$ret_a = 1990.3`, `$ret_b = 1988` (expected 0 +- 0.5). File hash 84658F195D14.
   3. **R28 (CDPROFILE start): PASS, PASS.** `b2d2` (RUN-20261025-0804), `b2d3`. **Finding:** the old case's "Select a CE pit block." refusal was the case's own fault, not CE's. The typed pick was made with pit P3 outside the view, so AutoCAD picked nothing (probes `b2probe9` and `b2probe9c`). With a zoom to the pit first, the pick 200 mm right of the pit is accepted and CDPROFILE opens `Creative Engineering | Profiles (CDPROFILE)`. The case now asserts: first prompt, `Select a CE pit block.` absent, the Profiles window opened, no CE window after closing, 1034 objects before and after, file hash unchanged. Retitled "asks for a starting pit, takes pit P3 and opens the Profiles window". Red: `R28_BROKEN` rewritten as a true red (pick on an empty place) FAILED in `b2d2`: "Select a CE pit block." found, Profiles window not found. File hash 3A778E5F30F1.
   4. **R19b (erase pit P3 with six pipes): PASS, PASS.** `b2d2`, `b2d3`. New checks: whole sentence pinned with the number 6 (`[CE Civil] The pit was erased and the schedule is updated. 6 pipes now have ends that are Not connected yet. U restores everything.`), and the object count after U equals the count before (1034 and 1034). **New broken variant `R19b_BROKEN`** (expects 7 pipes) FAILED in `b2d2`: "no command-line line contains '7 pipes now have ends that are Not connected yet'". File hash E1FE2D54B3FA.
   5. **R15 (Recover Inverts): PASS, PASS.** `b2a1` (RUN-20261025-0813), `b2a2` (RUN-20261025-0833). File untouched, hash 6626D75574C6. The runner printed **ACCEPTED-READY** on 3.0.75 in `b2a2` (its review file still matches).
   6. **R16 (Tidy labels names the pipe): PASS, PASS.** `b2b1` (RUN-20261025-0817), `b2b2` (RUN-20261025-0839). File untouched, hash 92E250C4F0FC. Runner printed ACCEPTED-READY in `b2b2`. Tidy labels switched on by the case's own SETTING (OFF in Tim's file).
   7. **R17 (Esc at CD's third point): PASS, PASS.** `b2c1` (RUN-20261025-0807), `b2c2` (RUN-20261025-0827). File untouched, hash E252738D9455. Runner printed ACCEPTED-READY in `b2c2`.
   8. **R20 (CDEDIT keeps the selection): PASS, PASS.** `b2c1`, `b2c2`. File untouched, hash 4CEA23828CEF. Runner printed ACCEPTED-READY in `b2c2`.
3. **Pit Schedule probe: yes, the IL and cover cells CAN be read as text.** The dump of the open Pit Schedule gives every cell as a Text control, and a regular expression over row P3 matched `P3`, `900 x 900`, `P4`, `17.30`, `17.25`, `18.88` (IL inlet, IL outlet, cover). I proved it on 3.0.75 by running **R38** (written in batch 3: it already does exactly this and checks the cells against the IL texts on the plan) once as a probe with `-NoLedger`: PASS (run `b2probeR38`, RUN-20261025-0844; the Close button closed the window; file unchanged). **No new case written:** it would duplicate R38. The probe's limit: the dump is cut at about 4 KB for a `record`, so a case must use `matches`, as R38 does; cells are read-only (no cell edit is possible).
4. **What is ready for the independent reviewer to look at again:**
   1. **New text, needs a fresh review file (the old reviews no longer match their hash):** R12, R23, R28, R19b. Each now has two passes on 3.0.75 and a red on its variant, so the reviewer can look at them for the four-condition rule. R23 is the one that matters most: it would let the desk write BUG-384 "FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026)", for the CDEDIT refusal route only. BUG-797 and BUG-254 stay unproved.
   2. **Nothing for the reviewer to redo:** R15, R16, R17, R20. Their files are unchanged, their existing review files still match, and the runner printed ACCEPTED-READY for each on 3.0.75 after two passes. They now count on the live build (3.0.75), not only on 3.0.73/3.0.74.
5. **No failures, no blocks, no real CE fault found in this job.** Nothing was stopped at three failures. No new bug number needed. (R22's fault is unchanged and was not run here.)

## Evidence per run (all Civil 3.0.75, Manager 1.1.75, Structural 1.0.123)

1. **`b2d1` RUN-20261025-0758** (07:58 to 08:03, one session): R12 PASS (55 s), R12_NOU_BROKEN FAIL (known red), R23 PASS, R23_BROKEN FAIL (known red).
2. **`b2d2` RUN-20261025-0804** (08:04 to 08:07, one session): R19b PASS, R19b_BROKEN FAIL (known red), R28 PASS, R28_BROKEN FAIL (known red).
3. **`b2c1` RUN-20261025-0807** (08:07 to 08:12): R17 PASS (105 s), R20 PASS (177 s).
4. **`b2a1` RUN-20261025-0813** (08:13 to 08:17): R15 PASS (222 s).
5. **`b2b1` RUN-20261025-0817** (08:17 to 08:23): R16 PASS (261 s).
6. **`b2d3` RUN-20261025-0823** (08:23 to 08:27): R12, R23, R19b, R28, all PASS.
7. **`b2c2` RUN-20261025-0827** (08:27 to 08:33): R17 PASS (139 s), R20 PASS (160 s). Runner printed ACCEPTED-READY for both.
8. **`b2a2` RUN-20261025-0833** (08:33 to 08:39): R15 PASS (277 s). ACCEPTED-READY.
9. **`b2b2` RUN-20261025-0839** (08:39 to 08:44): R16 PASS (261 s). ACCEPTED-READY.
10. **Probe runs (not in the ledger, `-NoLedger`):** `b2probe9` (CDPROFILE picks without a zoom: all five refused), `b2probe9b` (BLOCKED: a window opened and the Esc was refused, a tool guard, not a result), `b2probe9c` (zoom first: pick accepted, Profiles window, closed by the runner's close step), `b2probeR38` (Pit Schedule read, above).
11. **Every session:** clean end (AutoCAD left 0, lock none, guard clear), 0 settings fingerprint differences, fixture DRV1_B1 34BBE37C2EA4 (file unchanged on disk), driver files unchanged.

## What I changed, listed loudly

1. **Case files (all under `C:\Lisp Files\_ACAD_DRIVER\cases\`, not a git repository):**
   1. `R23_locked_pipe_layer_cdedit_refuses.case.txt`: 3687 bytes, SHA-256 47044D1E70E6... (header `BUG BUG-384`; two assertions added; one weaker assertion replaced).
   2. `R12_quick_move_opens_no_window.case.txt`: 3955 bytes, 84658F195D14... (four read steps and four lines added after the U block: `$ret_a`, `$ret_b` = 0 +- 0.5).
   3. `R28_cdprofile_start.case.txt`: 2766 bytes, 3A778E5F30F1... (zoom first, accepted pick, window asserted).
   4. `R19b_erase_pit_with_several_pipes.case.txt`: 2314 bytes, E1FE2D54B3FA... (whole sentence with 6; count before and after).
2. **Variants (`cases\variants\`):** `R23_broken` 1782 bytes d24705fb8160 (edited), `R28_broken` 1425 bytes 928917e7af5a (rewritten as a true red), new `R12_nou_broken` 1283 bytes baef9edad42b, new `R19b_broken` 1094 bytes 4729bb887f19. `R12_broken` (the old flipped-word red) is untouched.
3. **Not changed:** R15, R16, R17, R20 (hashes 6626D755, 92E250C4, E252738D, 4CEA2382 as before, so their review files still match); no `review.txt` written or edited; the runner (`case_runner.ps1` 7E3BC77F93F4, `case_runner_lib.ps1` 5AB2CBC1A5A0), driver v2 (120EE24D15B2), v3 (7CADBF80D5AA), v3 session (9A7B8D210C7F) hashes are identical to the start; no allow-list touched.
4. **Scratch (this PC only):** `C:\ce_rc_scratch\b2fix\` (probe cases PRB9, PRB9b, PRB9c, the one-line run helper `runpack.ps1`, a version reader `ver.ps1`, originals of the four cases in `orig\`). Not a build or deploy script.
5. **Tim's four settings files** at the end, read back from disk: CD_Settings.json ACD64E79A33B, TIM_CE_CADTOOLS CS_Settings.json 622A246F7D3B, CE_CVL_SUITE settings.json EFE307C4FC74, Structural CS_Settings.json 2972CE70C514. All equal to the expected values. No acad.exe left, lock free.

## What I did NOT check (RULES 5.9)

1. **Nothing was looked at.** No window picture was judged; R28's Profiles window is asserted by its title only. What the Profiles window lists is not read.
2. **R23 proves the CDEDIT refusal route only.** BUG-797 (CDPROPAGATE cascade on a locked layer) and BUG-254 (pits, text layers, Xrefs) are not covered. That the layer stays locked is shown only by CE's second refusal.
3. **R12 still reads two invert texts, not the pit's name label or cover text** (card C41 step 1 names them).
4. **R19b reads only pipe 10A98D after the erase,** not all six pipes; the Pit Schedule half of D14 is still not covered by R19b (R38 reads the schedule but does not erase anything).
5. **R28 does not press anything in the Profiles window** and draws no long section: none of the Q1 bugs is proved.
6. **Nothing was run on 3.0.74** (not installed any more). The reviews for R12, R23, R28, R19b do not exist yet for the new text.
7. **R16's behaviour depends on the SETTING in the case** (Tidy labels on); Tim's real file has it off. R13, R14, R11 were not part of this job and were not re-run.
8. **I did not touch the two runner gaps the review listed** (a red only demanded for `BUG` cases; text checks ignore capital letters; the build stamp read once at run start). They are the runner owner's, unchanged.

## Summary (under 100 words)

Installed build is Civil 3.0.75 (not 3.0.74). R23 now pins the whole two-pipe refusal ("CE will not unlock it"), R12 measures the invert texts back after U, R28 got a real pit pick (the old refusal was the case's own fault: pit out of view) and R19b a red variant. Each passed in two separate sessions with a red variant. R15, R16, R17, R20 re-passed twice unchanged and the runner printed ACCEPTED-READY. R38 proves Pit Schedule cells read as text. No failures. R12, R23, R28, R19b need fresh independent reviews.
