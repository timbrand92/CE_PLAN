# Robot draft cases N01 to N12: validation on the installed build (run Wed 28 Oct 2026, 02:16 to 04:45 Melbourne)

Job: desk plan/03, Team robot (Sonnet). Tim was away until Thursday 29 Oct. Every runner call had CE_RUNNER_TIM_AWAY=1. One AutoCAD session at a time, AutoCAD closed for at least 3 minutes between sessions (one exception, item 7 below). Settings guard and hash restore were the runner's own; no setting line was used by any of the 11 cases run.

## ANSWER FIRST

### FOR TIM

1. **Result:** 11 of the 12 new robot checks PASS twice on the installed build, and each deliberately wrong twin fails as intended. The 12th (N10, hide grade) was not run, as the desk instructed.
2. **Installed build, read live at the start and unchanged at the end:** Civil 3.0.83 (Legacy, Modern and Net8 all 3.0.83+96455f13), Manager 1.1.83, Structural 1.0.125. No new install landed, so no run is void.
3. **Per case (run ids are tag n27 plus a or b):**
   1. **N01 CDREBUILD warns and never saves: PASS.** a1 (RUN-20261028-0216-C3.0.83-n27a1), b1 (RUN-20261028-0358-C3.0.83-n27b1). Twin FAILS as intended (file changed on disk): a14 (RUN-20261028-0347-C3.0.83-n27a14). The 270-character warning was NOT split by AutoCAD's log; check 1 passed on the exact wording.
   2. **N02 EXPLODE a pit: PASS.** a1, a2 (RUN-20261028-0224-C3.0.83-n27a2), b2 (RUN-20261028-0407-C3.0.83-n27b2). Twin FAILS as intended: a2.
   3. **N03 OF and FO: PASS.** a3 (RUN-20261028-0231-C3.0.83-n27a3), b2. Twin FAILS as intended: a3. One BLOCKED in between (b1, see finding 3), not a CE result.
   4. **N04 downpipe and raingarden with no pipe: PASS.** a4 (RUN-20261028-0237-C3.0.83-n27a4), b3 (RUN-20261028-0415-C3.0.83-n27b3). The typed raingarden corners worked and the area read 12.0 m². Twin FAILS as intended: a4.
   5. **N05 pit label and cover level: PASS after one text fix.** a6 (RUN-20261028-0253-C3.0.83-n27a6), b4 (RUN-20261028-0421-C3.0.83-n27b4). The mouse click for the cover text worked. Twin FAILS as intended: a6. First attempt a5 failed at a step, fixed (fix 1).
   6. **N06 office layers: PASS.** a7 (RUN-20261028-0303-C3.0.83-n27a7), b3. Twin FAILS as intended: a7. (Counts in part only: "never recolour a layer" is not built.)
   7. **N07 Undo names: PASS.** a15 (RUN-20261028-0351-C3.0.83-n27a15), b4, and an earlier a8 (RUN-20261028-0308-C3.0.83-n27a8, see item 7 below). Twin FAILS as intended: a8, a15.
   8. **N08 CDRENUMBER: PASS after one text fix.** a10 (RUN-20261028-0318-C3.0.83-n27a10), b5 (RUN-20261028-0433-C3.0.83-n27b5). Twin FAILS as intended: a9, a10. First attempt a9 failed at one check, fixed (fix 2).
   9. **N09 Pit Schedule order: PASS.** a11 (RUN-20261028-0326-C3.0.83-n27a11), b5. Twin FAILS as intended: a11.
   10. **N10 hide grade: NOT RUN.** Marked DO NOT RUN by the pre-flight (its setting is overridden by CD_RecentValues.json, which the guard cannot restore). Skipped with its twin, as the desk addendum said. It still needs a new route.
   11. **N11 Edit Pipe cascade, stored levels: PASS.** a12 (RUN-20261028-0331-C3.0.83-n27a12), b6 (RUN-20261028-0440-C3.0.83-n27b6). The after-cascade schedule cells the planner worked out from the code were right. Twin FAILS as intended: a12.
   12. **N12 COPY of a pit: PASS.** a13 (RUN-20261028-0342-C3.0.83-n27a13), b6. Twin FAILS as intended: a13.
4. **Moved into cases\ and ready for the independent reviewer (11):** N01, N02, N03, N04, N05, N06, N07, N08, N09, N11, N12. Twins are in cases\variants\ as N01_broken to N12_broken (no N10). Each file's SHA-256 matches the hash recorded in its passing runs, so the passes still count.
5. **Text fixes (2 cases, 1 line each):** N05 (block name) and N08 (doubled keyword in AutoCAD's log). Neither weakened a check. Details below.
6. **Findings (CE behaviour that differs from a card):** none. Nothing needed a BUG number. Three robot or route notes are below.
7. **What you need to do:** nothing. The independent Opus review of these 11 comes next. Nothing here is Tim-accepted; these are PASS-UNREVIEWED until the reviewer writes a review file.

---

## Technical detail

### A. Method as run

1. **Format check:** `case_runner.ps1 validate` on the draft folder: 24 file(s) checked, 0 invalid (26 files in the folder; the two `.pre_preflight` copies are not read as cases).
2. **First pass:** `run-pack -Only "<N>,<twin>" -Tag n27a<k> -NoRerun`, a case with its twin per call (N01's twin alone and last in the first pass, a14). **Second pass:** every main case in a new call, tag n27b<k>, so a different AutoCAD session. N07 additionally has a clean repeat (a15).
3. **Settings:** the runner's own guard and hash restore were used; none of the 11 cases carries a SETTING line that I touched.
4. **Safety:** foreground calls with the 600000 ms timeout (the longer N05/N11 calls ran as one background command each, read by plain file reads, no `tail -f`). No acad.exe, accoreconsole or helper process of mine remained at the end. Lock released by the runner after each session.
5. **Scratch:** `C:\ce-fx\n27val\` (my own job folder only): `pair.ps1` (waits 185 s, refuses to start if acad.exe runs, then calls the runner) and `sum.ps1` (reads the run JSON). No new build or deploy script. Removed at the end.

### B. Text fixes (before and after)

1. **N05 and N05_BROKEN, the label select (first failure: RUN-20261028-0242-C3.0.83-n27a5, step 21 "ent-read needs a handle").**
   Before: `select $new "name=PIT LABEL" -> $labels`
   After: `select $new "name~^PIT LABEL" -> $labels`
   Why: the run showed the new label block is named "PIT LABEL 2" (3 new objects: pit block, `PIT LABEL 2` on STORMWATER PIT LABEL, MText `CL 19.000` on 25TEXT), so the exact-name select found 0 and the handle was empty. The layer, attribute, count and cover-text checks are unchanged; the twin still fails at "count of $labels = 0 (expected = 1)". N12 already used the same `name~^PIT LABEL` form.
2. **N08 (the "Apply?" prompt count; first failure: RUN-20261028-0311-C3.0.83-n27a9, check 5).**
   Before: `history count "2 pit(s) will be renumbered. Apply? [Yes/No] <No>" = 2`
   After: `history count "2 pit(s) will be renumbered. Apply? [Yes/No]" = 2`
   Why: AutoCAD's log echoes the keyword list twice on this prompt ("Apply? [Yes/No] [Yes/No] <No>: No"), the same doubling the case already saw on the outlet prompt ("[C1/X1] <C1> [C1/X1] <C1>: C1"). The wording CE prints, the two answers (No, Yes) and the count of 2 are all still asserted. The N08 twin has no such line, so it did not change.
3. After each fix the case ran twice more on the new hash: N05 a6 and b4 (hash 4C28CE66), N08 a10 and b5 (hash 35C4E2C9). The older failing runs a5 and a9 do not count.

### C. Findings and robot notes (none is a CE fault)

1. **No CE behaviour differed from its card.** Every wording, count and cell the planner derived from source (N04 12.0 m², N08 rows after Yes and after U, N11 after-cascade cells, N01 270-character sentence) read back exactly. No BUG number needed.
2. **Block name:** the pit label block placed by PIT is named `PIT LABEL 2` in the drawing, not `PIT LABEL`. Not a fault as far as the cases show (I did not check why it carries the "2"); any later case that selects by exact name must use the start-of-name pattern.
3. **A HARD TIMEOUT (BLOCKED, not a result):** RUN-20261028-0358-C3.0.83-n27b1, case N03: "v2 HARD TIMEOUT: AutoCAD did not answer in time" on the very first typed command (`OF` at 150000,-80000), with N01 having just passed in the same session. No acad.exe remained. N03 was run again unchanged in the next session (b2) and passed, and it had passed in a3. I take it as the known driver hang, not an OF fault. It is not counted as a pass or a fail.
4. **Draft header comments** still read "NOT RUN YET" in the moved files. I left them untouched (a comment edit would change the file hash and void the passes); the reviewer or desk may tidy them.

### D. Moved into cases\ (hash checked before and after each move)

1. `cases\N01_cdrebuild_warns_never_saves.case.txt` (hash DD27359C), twin `cases\variants\N01_broken.case.txt` (A145CF62).
2. `N02_explode_pit_leaves_schedule_u_restores` (7428272C), twin 43765D5C.
3. `N03_of_fo_same_symbol_own_tags` (7A7AEF23), twin 9B3809FF.
4. `N04_dp_and_raingarden_without_pipe` (74CA6C50), twin DE3C4B2D.
5. `N05_pit_label_number_and_cover_level` (4C28CE66), twin 156C2147.
6. `N06_office_layers_current_layer_kept` (4A402A8F), twin 998DE94B.
7. `N07_undo_names_and_route_undo_sentence` (57A7624D), twin 725670DD.
8. `N08_cdrenumber_no_then_yes_then_u` (35C4E2C9), twin 488FF001.
9. `N09_pit_schedule_natural_order` (6597D8D5), twin 9CF0A375.
10. `N11_cascade_schedule_levels_u_redo` (C13A2B8D), twin F81A419C.
11. `N12_copy_pit_new_number_check_levels` (9E2E8556), twin 3C55D48C.
12. The CASE lines are unchanged. N10 and its twin (and the two `.pre_preflight` copies) stay in `cases\drafts_opus_27oct\`. No `.review.txt`, ledger.json, existing R case, runner or driver file, DESK_LOG.md or BUG_CARPARK.md was written.

### E. Why each twin's failure is the right one (from the run JSON)

1. **N01_BROKEN:** file on disk changed after CDREBUILD (SHA-256 differs).
2. **N02_BROKEN:** no U, so the restore check fails (value '' where '109D56' is expected).
3. **N03_BROKEN:** OF typed twice, so "Overflow placed. Tag: OF..." for FO is missing.
4. **N04_BROKEN:** no U, object count 1036 where 1034 is expected.
5. **N05_BROKEN:** Esc at both prompts, so label count 0 (expected 1) and cover count 0 (expected 1).
6. **N06_BROKEN:** current layer set to 0, so it reads 0 where BLOCKS is expected.
7. **N07_BROKEN:** say-what-was-undone off, so "Undid: point 3 of the pipe route." is absent.
8. **N08_BROKEN:** answered No, so 'Pit P10=' is still in the schedule.
9. **N09_BROKEN:** flipped order, no match for /Pit P10=.*Pit P2=/.
10. **N11_BROKEN:** no U, schedule rows differ from the expected rows.
11. **N12_BROKEN:** label expected to read P3, no match for the P3 attribute.

### F. CD_RecentValues.json (not touched, not restored)

1. The file `%APPDATA%\TIM_CE_CADTOOLS\CD_RecentValues.json` was last written 04:44 this morning, during these runs, so it holds robot test values.
2. Cases that typed PIT or CD and so likely wrote it: N05 (PIT, cover level 19.000), N06 (PIT and CD through SETUP-P8), N07 (PIT and CD), and the twins of those three. N04 (CDRG) wrote it only if CDRG remembers values (not checked). The other cases only open the Pit Schedule or run CDREBUILD, CDRENUMBER, EXPLODE, OF/FO and COPY and are not known to write it. I did not read its contents before or after.

### G. What was NOT done or tested (RULES 5.9)

1. **N10 and its twin were not run** (desk instruction). Nothing is claimed about hide grade.
2. **No picture was looked at.** These cases read the command line, stored attributes, object counts, layers, schedule cells and file hashes. Linework look (N02), label position and cover text corner (N05), numbering rule correctness (N08) and the rebuilt records themselves (N01) are not judged, as each case's NOT_AUTOMATED lines say.
3. **PASS-UNREVIEWED only.** No independent review has happened; nothing is Claude-accepted yet (rule in RULES.md, 24 Oct amendment: needs the reviewer's review file).
4. **Gap deviation (my mistake, stated plainly):** AutoCAD closed for under 3 minutes (about 4 seconds) before RUN-20261028-0308-C3.0.83-n27a8 (N07 pair) and RUN-20261028-0311-C3.0.83-n27a9 (N08 pair). My first attempt at the gap (a sleep inside a shell call) was refused by the tool and I did not catch it before sending the next run. No install or payload test was involved and no run failed for this reason, but those two runs are the ones where the rule was broken. N07 was therefore run again cleanly (a15) and N07's passes that count are a15 and b4; a9 failed before the N08 fix anyway and does not count. From a10 on, a 185-second gap was built into the run script.
5. **Not tested here:** Codex looks, Tim's AutoCAD, other builds. Both passes of every case are on 3.0.83 only.

## Summary

11 of 12 draft cases (N01 to N09, N11, N12) pass twice on Civil 3.0.83 and each twin fails as intended; N10 skipped as instructed. Two one-line text fixes (N05 block-name pattern, N08 doubled keyword); no CE findings. One driver HARD TIMEOUT (N03 b1) rerun clean. All 11 plus twins moved into cases and variants. One gap-rule slip on two runs, disclosed. Ready for the independent reviewer; nothing accepted yet.
