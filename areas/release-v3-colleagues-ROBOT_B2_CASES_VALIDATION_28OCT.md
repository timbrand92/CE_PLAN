# Robot batch-2 draft cases N15 to N22: validation on the installed build (run Wed 28 Oct 2026, 08:56 to 11:52 Melbourne)

Job: desk plan/03, Team robot (Sonnet). Tim was away until Thursday 29 Oct. Every runner call had CE_RUNNER_TIM_AWAY=1. One AutoCAD session at a time, AutoCAD closed for at least 185 seconds between sessions (the wait is built into my scratch script, `C:\ce-fx\b2val\chain.ps1`, which only calls the existing runner). 26 runner calls in all (25 plus one clean N15 re-run, n28f1), tags n28a1 to n28a8, n28c1 to n28c6, n28d1 to n28d5, n28e1 to n28e6 (there is no n28b: the second pass of the unchanged case, N21, is n28d3). The settings guard and hash restore were the runner's own; no case carries a SETTING line. Nothing was pushed to Tim's AutoCAD, nothing installed, no bundle touched.

## ANSWER FIRST

### FOR TIM

1. **Result:** all 8 new robot checks PASS twice on the installed build, and each deliberately wrong twin fails for its intended reason. All 8 are moved into `cases\` (twins into `cases\variants\`) and are ready for the independent reviewer. Nothing is accepted yet: these are PASS-UNREVIEWED until a reviewer writes a review file.
2. **Installed build, read live at the start and again at the end:** Civil 3.0.83 (Legacy, Modern and Net8 all 3.0.83+96455f13), Manager 1.1.83, Structural 1.0.125. The header of all 25 runs reads the same build. No install landed, so no run is void.
3. **Per case (run ids are `RUN-20261028-<time>-C3.0.83-` plus the tag):**
   1. **N15 CDRENUMBER, the whole tool: PASS.** Passes n28c1 (0954) and n28d4 (1058). Twin FAILS as intended (n28a1, 0856): answering Yes makes the schedule differ from the schedule before. One text fix (item 4).
   2. **N16 COPY of a pit: PASS.** Passes n28c2 (1001) and n28d5 (1105). Twin FAILS as intended (n28a2, 0904): it expects the original to read P8 and it reads P3. One text fix (item 4).
   3. **N17 Undo names on Tim's own switches: PASS.** Passes n28c3 (1005) and n28e2 (1120). Twin FAILS as intended (n28c3): U after COPY echoes COPY, so the MOVE check fails. One text fix (item 4).
   4. **N18 Undo names with the switches on: PASS.** Passes n28c4 (1012) and n28e3 (1127). Twin FAILS as intended (n28a4, 0917): with no U the pipe stays (count 5, not 0). One text fix (item 4). The route the planner marked UNCONFIRMED ("U" then Enter in one typed chain) worked.
   5. **N19 pit catch, outline plus 100 mm: PASS after one route fix.** Passes n28c5 (1017) and n28e4 (1132). Twin FAILS as intended (n28a5, 0925): at 150 mm outside, "Flow: Open end -> P8" is absent. First attempt n28a5 was BLOCKED (item 5, fix 2).
   6. **N20 short pipe label on a leader: PASS after one route fix.** Passes n28e1 (1110) and n28e6 (1145). Twin FAILS as intended (n28c6, 1024): a 20 m pipe gets no leader (count 0, expected 1). Three earlier BLOCKED attempts (item 5, fix 3). Only the part the robot can read is claimed: the arrow's position on the pipe, and the leader's look and wording, still need a Codex look.
   7. **N21 CDFEEDBACK Cancel: PASS, no change to the text.** Passes n28a7 (0944) and n28d3 (1053). Twin FAILS as intended (n28a7): it expects a "sent" line that never appears. Send report was never pressed.
   8. **N22 EXPLODE a pit with no pipes: PASS after one text fix.** Passes n28d2 (1046) and n28e5 (1140). Twin FAILS as intended (n28a8 and n28d2): with no U the pit's handle stays gone. One text fix (item 4).
4. **Text fixes (before and after in the technical part):** the Undo-echo checks in N15, N16, N17 (and its twin), N18 and N22 now allow a trailing space after the command name. N19's near pipe now starts 50 mm further in. N20's two mouse clicks moved 700 mm along the pipe. No check was weakened or deleted.
5. **Values the planner worked out from the code (marked DERIVED), now seen in a run:** all CONFIRMED, none different. N19's "(was 50 mm short of the wall)" sentence, its three "End is free" lines, its two pipe positions (150225 and 150375). N22's sentence "P8 is now plain linework and has left the schedule. U restores it." with no pipe part. Details below.
6. **Findings for the desk (none is a bug number yet; exact steps below):**
   1. **A caught pipe end can open the "Grade mismatch" question** that the robot cannot answer (its buttons are not on the driver's press list). It happened on N19's first attempt.
   2. **N20's mouse click was refused twice at one spot on the screen** by the driver's own safety check (another window of AutoCAD over the drawing). Cause not identified; a click 700 mm away worked.
7. **One thing to know:** five of these cases place pits or pipes, so Tim's remembered-values file `CD_RecentValues.json` was rewritten and was not restored (hashes below).
8. **What you need to do:** nothing. Next is the independent Opus review of the 8 cases.

---

## Technical detail

### A. Method as run

1. **Format check first:** `case_runner.ps1 validate` on `drafts_opus_28oct_b2`: "16 file(s) checked, 0 invalid". It was not re-run after the fixes (run-pack parses each file itself; every run parsed).
2. **First pass:** `run-pack -Only "<case>,<twin>" -Tag n28a<k> -NoRerun`, a case with its twin per call, in the spec's order (n28a1 N15, a2 N16, a3 N17, a4 N18, a5 N19, a6 N20, a7 N21, a8 N22).
3. **After each fix** the case ran twice more on its new hash (the earlier runs on the old hash do not count): fixed cases N15 to N20 and N22 each have two passes on their final hash, in two different calls, so two different AutoCAD sessions. N21 was never edited: n28a7 and n28d3 are its two passes.
4. **Final hashes (first 12 of SHA-256, checked before and after the move):** N15 A78CC824FFF3, N16 068633409A51, N17 D464882B6CC6, N18 3C39E3F9B3BB, N19 7E4978253751, N20 AA6B716294DF, N21 073A45629633, N22 A3E5B86CDFA0. A script (`C:\ce-fx\b2val\check_and_move.ps1`) read `file_sha256` from every run JSON and confirmed two PASS runs on exactly that hash before moving each case.
5. **No case places a downpipe or overflow** (grep of the 16 files), so BUG-1225 was not in play and none needed its own session. The second case of each pair ran after the runner's reopen of a fresh copy; no "source landing could not be refreshed" refusal appeared in any of the 25 runs.
6. **Safety:** foreground or one background command per chain with plain reads (a `sleep` loop checking a progress file, no `tail -f`); no acad.exe left at the end (0 running); the lock was released by the runner after every session (every report says "AutoCAD left 0, lock none"). Three of my own shell look-ups (a repo-wide `find` and `grep`) ran long and finished on their own before I ended. No helper of mine is running now.
7. **Gap rule, one slip (my mistake, stated plainly):** every gap was 185 seconds or more EXCEPT one. I started the third chain without its first wait, so RUN-20261028-0954-C3.0.83-n28c1 (N15) began about a minute after the previous session closed (n28a8 finished 09:53:46). No install or payload test was involved and the run passed, but to be clean I ran N15 once more after a proper 185-second gap: RUN-20261028-1157-C3.0.83-n28f1, PASS on the same hash A78CC824FFF3. So N15 has three passes on its final hash: n28c1 (short gap), n28d4 and n28f1 (both after a full gap); the two that fully follow the rule are d4 and f1, in two separate AutoCAD sessions. All other runs kept the full gap. 26 runner calls in all.

### B. Text fixes (before and after)

1. **Fix 1, five cases: the Undo-echo checks (first failures n28a1, a2, a3, a4, a8).**
   1. **Before:** `matches $u12 "(^|\| )PITSCHEDULE( \||$)"` (and the same shape for CDRENUMBER in N15; `COPY` in N16; `CD`, `PIT`, `MOVE` in N17 and `COPY`, `MOVE` in N17's twin; `CD` in N18; `EXPLODE` in N22).
   2. **After:** the same with `\s*(\||$)` in place of `( \||$)`, e.g. `matches $u12 "(^|\| )PITSCHEDULE\s*(\||$)"`. 10 lines in 6 files (N15 two, N16 one, N17 three, N17_BROKEN two, N18 one, N22 one). Hashes: N15 4F64A0E760C9 to A78CC824FFF3, N16 51839AF35FA1 to 068633409A51, N17 EE04252A853B to D464882B6CC6, N17_BROKEN 75576473A323 to DCA03BBCC9EF, N18 1D3E1EB58CC8 to 3C39E3F9B3BB, N22 054BB774D168 to A3E5B86CDFA0.
   3. **Why:** the runner showed "no match" on lines that read, in the report, `Command: U | PITSCHEDULE | ...` and `... | Command: U | CD | SETTINGS GUARD ACTIVE ...`. The check wants the command name followed by exactly one space and a bar, or the end of the text. In N18 the name `CD` was followed by a bar mid-string and still did not match, so something other than a single space follows the name. I did not read the raw bytes (the report squeezes spaces), so "AutoCAD's echo has trailing whitespace" is my inference. The new pattern still reads the whole name: `CDEDIT` or `PITSCHEDULE2` cannot match `CD` or `PITSCHEDULE`, and a bare `U` with a different command (COPY after U) still fails (N17's twin proves it).
   4. **Not a CE fault.** Only the U-echo checks failed on those runs; every other check of those cases passed on the first attempt.
2. **Fix 2, N19: the near pipe's start point (first failure n28a5, BLOCKED at step 22).**
   1. **Before:** `type "CD{NL}160275,-79850{NL}150275,-79850{NL}" ...` (a 10.000 m pipe; hash 386E494E085F). **After:** `type "CD{NL}160225,-79850{NL}150275,-79850{NL}" ...` (the EXPECTED line also names the new start and why; hash 7E4978253751).
   2. **Why:** after Start Pipe on the near pipe, `esc-prompt` was REFUSED: "the AutoCAD main window is disabled: a window is open in front of it". The twin, whose end is 150 mm out and not caught, passed the same step. So the window only opens when the end is caught and moved 50 mm onto the wall: the pipe becomes 10.050 m long and the typed levels 18.000 / 17.950 stop being 1 in 200. I did not see the window (the runner's tidy-up sent one Esc); that it is the "Creative Engineering | Grade mismatch" question is my reading from R02b's own note and from `GradeMismatchDialog.xaml` (buttons "Use 1 IN n" and "Keep 1 IN n"), which are not on the driver's press list. Starting the pipe at 160225 makes it exactly 10.000 m once the end is caught, so the typed levels stay 1 in 200. The caught-end check, "50 mm short" sentence and box position are unchanged; the check "Pipe end moved to the inside wall of P8 (was 50 mm short of the wall)." still passed (so the 50 mm is measured from the typed end point, not from the start).
3. **Fix 3, N20: the two click points (first failures n28c6 and n28d1, BLOCKED at step 11).**
   1. **Before:** `v3 pt-click "151000,-80000" -Blind` then `v3 pt-click "151000,-78500" -Blind` (hash BFE535DC7B95). **After:** `150300,-80000` and `150300,-78500` (hash AA6B716294DF).
   2. **Why:** the driver refused twice, at the identical pixel: "the window under the target pixel 2728,753 is not the drawing area (other_window_under_point): a palette, a CE window or another program is in the way. Nothing was clicked." The refusal is the driver's own guard (a window of AutoCAD's own process, not the drawing canvas, lies over that pixel, which is the middle of the drawing area, right after Start Pipe). I could not see what the window is (no picture). With the clicks 700 mm to the left (pixels 2661,753 and 2661,611) both clicks were accepted in both sessions and CE placed the leader. This is a route problem, not a CE result, as the spec said. The pipe is still the same 2 m pipe and both points still lie on its line or above it.
   3. **First attempt n28a6 (0935) was a different, environment problem:** both N20 and its twin BLOCKED with "the watchdog did not start within 20 s" before any step ran (24 seconds, a driver start-up problem). Not counted either way; the next call started normally.

### C. Findings (CE behaviour or tool limits; none changes a check)

No existing bug entry covers these (I grepped `C:\CE_PLAN\BUG_CARPARK.md` for "grade mismatch", "callout", "leader", "watchdog" and "other_window"; the BUG-1225 entry is about DP and OF after a reopen and did not occur here).

1. **A caught pipe end can raise the Grade mismatch question (possible desk entry, observation only).**
   1. **Steps:** open a drawing with a pit P8 (450 x 450) at 150000,-80000. Type CD, pick 160275,-79850 then 150275,-79850 (an end 50 mm outside the pit opening), then Enter. In the New Pipe window set the first invert 18.000 and the second 17.950 (1 in 200 over the 10 m typed) and press Start Pipe.
   2. **What happened:** a window stayed open in front of AutoCAD (the runner refused the next Esc because the main window was disabled). With a start point of 160225 (10.000 m after the catch) nothing opened. So CE re-checks the grade after it moves the caught end, which is reasonable; it is only a note for the desk that a drafter who draws a pipe to a pit and has CE pull the end onto the wall may be asked about a 1-in-200 versus 1-in-201 difference of 5 mm in length. The robot cannot answer this question (the driver's press list for that window does not allow "Use 1 IN" or "Keep 1 IN").
   3. **Not established:** the window's title and the tolerance at which it opens.
   4. **Evidence:** n28a5, step 22 REFUSED; n28c5 and n28e4 PASS with the 160225 start.
2. **The driver refused a click over the drawing's middle (tool limit).** Steps: open a copy of the fixture, zoom `_C 151000,-79500 6000`, `v3 view-read`, place the 2 m pipe from 150000,-80000 to 152000,-80000 (levels 18.000 / 17.990), press Start Pipe, wait 3 s, `v3 pt-click "151000,-80000" -Blind`. Refused twice (n28c6 1024, n28d1 1036). Not CE; but if a drafter has a window in that place while CE asks "Snap callout arrow to pipe:", the same window could cover the drawing. It may be a tooltip or a CE overlay: I did not look at a picture.
3. **The planner's UNCONFIRMED items:** all confirmed. N18's "U" then Enter in one typed chain placed a two-point pipe; N20's clicks answered both the anchor and the text prompt, and the leader's object name is AcDbMLeader (types added by the pipe: CeCvlPipeObject, AcDbMLeader, AcDbMText, AcDbMText, AcDbBlockReference; leader layer 25TEXT; IL texts on 20TEXT, e.g. "IL 18.000" at y -80457.5).
4. **N15's DBMOD note:** DBMOD before the first CDRENUMBER (No) read 1 and after it read 1 (recorded, not judged). The Pit Schedule read after No equals the schedule before, cell for cell (the main case passes it; the twin fails it).

### D. The values marked DERIVED: confirmed or different

1. **N19, all four CONFIRMED (n28c5 and n28e4):**
   1. **The sentence:** `[CE] Pipe end moved to the inside wall of P8 (was 50 mm short of the wall).` (seen with the "[CE] " prefix; the check is a substring).
   2. **The count:** three "End is free: open end flagged, connect it later." lines.
   3. **Near pipe box x:** 150225 exactly. **Far pipe box x:** 150375 exactly.
   4. **Pit size:** the near end was caught at 50 mm out and the far end at 150 mm was not, and the box x values match, which is what a 450 mm opening predicts; the size itself is not typed or read by the case and still depends on the remembered New Pit values (the recorded pit block box is 149050 to 150950, the whole block with its drawn parts).
   5. "Flow: Open end -> P8" once and "Flow: Open end -> Open end" once, as the card and R02 predicted.
2. **N22, CONFIRMED:** `P8 is now plain linework and has left the schedule. U restores it.` with no pipe clause, the absence of both pipe-clause phrases ("now have ends not connected yet", "now has an end not connected yet"), the block's handle gone after EXPLODE, and U echoing EXPLODE with the same handle back on STORMWATER PIT.
3. **Nothing was different.** No DERIVED line was edited.

### E. Why each twin's failure is the right one (from the run reports)

1. **N15_BROKEN (n28a1):** Yes answered, so `equals $rowsN $rows0` fails (the Yes sentence check before it passed).
2. **N16_BROKEN (n28a2):** expects the original's label to read P8; the first check fails (it reads P3).
3. **N17_BROKEN (n28c3, on the fixed text):** the COPY check passes (U echoes COPY) and the MOVE check fails (`no match for MOVE in: Command: U | COPY`).
4. **N18_BROKEN (n28a4):** no U at the third point, so the count after the U is 5, not 0. Its only failing check.
5. **N19_BROKEN (n28a5):** the near end 150 mm out: "Flow: Open end -> P8" is absent. Its pit placed; the pipe step ran through.
6. **N20_BROKEN (n28c6):** a 20 m pipe: `count $leaders = 1` fails with 0. The pipe-placed check passed.
7. **N21_BROKEN (n28a7):** "Report sent to the office feedback folder" is absent (the window was cancelled).
8. **N22_BROKEN (n28a8 and n28d2):** no U, so the count of the pit's handle after is 0, not 1.

### F. Moved into cases\ (hash checked before and after each move)

1. `cases\N15_cdrenumber_whole_no_changes_nothing_u_restores_all.case.txt` (A78CC824FFF3), twin `cases\variants\N15_broken.case.txt` (7E47B6358A4A).
2. `N16_copy_pit_whole_original_keeps_p3` (068633409A51), twin N16_broken (0298D5FF40CB).
3. `N17_undo_names_tims_switches_cd_pit_move` (D464882B6CC6), twin N17_broken (DCA03BBCC9EF).
4. `N18_undo_names_switch_on_route_undo_then_pipe_u` (3C39E3F9B3BB), twin N18_broken (1FC38DCCB348).
5. `N19_pit_catch_outline_plus_100` (7E4978253751), twin N19_broken (FB0BB08AD03E).
6. `N20_short_pipe_label_on_leader` (AA6B716294DF), twin N20_broken (8BA604AEC3DA).
7. `N21_cdfeedback_cancel_prints_one_line` (073A45629633), twin N21_broken (14B7AF8F31B5).
8. `N22_explode_lone_pit_no_pipe_wording` (A3E5B86CDFA0), twin N22_broken (127B07E4DB5D).
9. The CASE lines are unchanged. The drafts folder `drafts_opus_28oct_b2` is now empty. The case folder `C:\Lisp Files\_ACAD_DRIVER\cases` is not a git repository (it is local to this PC): the moves are on disk only. The header comments in the moved files still say "NOT RUN YET"; I left them (an edit changes the hash and voids the passes), as the earlier report did. No `.review.txt`, ledger.json (by hand), existing R or N case, runner or driver file, DESK_LOG.md or BUG_CARPARK.md was written.

### G. CD_RecentValues.json (not touched, not restored)

1. **SHA-256:** at the start (08:56) 798C42F07D11BC2313C23AE12824E0F35DFD8027C446A62FCCA027ECEE8ECBCA; seen at 09:54 as A58FBDCD9702FD2D758116CA3DA4786E626BE8D508C852EE895B5454DCEB89D5 (after chains A and B); at the end (11:52) 82A8B247F368A5E34113B722FB2118468CBC55064D45CC3678267461B71F1436. I did not read its contents.
2. **Cases that wrote it (they type PIT or CD):** N17, N18, N19, N20, N22, and the twins of those five. N15 (closes the Pit Schedule four times) may also have rewritten its filter fields; N16 (COPY) and N21 (CDFEEDBACK Cancel) are not known to write it. The desk decides about restoring it.

### H. What was NOT done or tested (RULES 5.9)

1. **No picture was looked at.** The cases read the command line, stored values, object counts, layers, schedule cells and file hashes. Not judged: the leader's arrow position, look and wording (N20); the pit and pipe label positions; the Feedback window's look; the drawn schedule over two sheets; the Inspector's Check-levels flag; whether the numbering rule in CDRENUMBER is right (Tim's word).
2. **CDFEEDBACK "Send report" was never pressed** (N21 covers Cancel only).
3. **The exact 100 mm boundary of the pit catch** is not tested (only 50 mm caught and 150 mm free).
4. **PASS-UNREVIEWED only.** No independent review has happened; nothing is Claude-accepted yet (RULES.md, 24 Oct amendment).
5. **Not tested:** other builds, Tim's own AutoCAD session, Codex looks, DP and OF after a reopen (BUG-1225, no batch-2 case places them).
6. **My inference, not a reading:** that the Undo-echo line carries trailing whitespace, and that the window in N19's first attempt was the Grade mismatch question. The runs prove the fixed text passes; they do not prove the cause.

### I. Files

1. This report. Runner reports and run JSON for the 25 runs (`areas\runner-reports\RUN-20261028-*-n28*.md` and `.json`) and the runner's own `ledger.json` rows.
2. Case files moved as listed. Scratch on this PC only: `C:\ce-fx\b2val\` (`chain.ps1`, `fix1.ps1`, `check_and_move.ps1`, run logs, before and after hash lists). Undo for the text fixes: the before hashes are in section B; the original draft text is the 16 files as the planner wrote them (the planner's report names them).

## Summary

All 8 batch-2 draft cases (N15 to N22) pass twice on Civil 3.0.83 and each twin fails as intended; all 8 plus twins are in cases and variants, ready for the independent reviewer. Fixes: U-echo patterns (5 cases), N19 near-pipe start (a Grade mismatch window the robot cannot answer), N20 click points (the driver refused a click at screen centre). DERIVED values in N19 and N22 confirmed. Two findings for the desk; no bug number. CD_RecentValues.json was rewritten, not restored. Nothing accepted yet.
