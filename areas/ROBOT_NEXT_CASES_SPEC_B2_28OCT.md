# Robot next cases, batch 2: 8 new draft checks (28 Oct 2026)

Written Wed 28 Oct 2026, Melbourne, by an Opus planner (read and write documents only). Nothing was run in AutoCAD, nothing built or installed; the only run was the robot's offline format check. Installed build when written: Civil 3.0.83 (commit 96455f13, branch claude/rel-20261026x); every source line below was read from that commit with `git show`.

## ANSWER FIRST

### FOR TIM

1. **Where we are:** 11 of the 40 everyday tools are Claude-accepted on Civil 3.0.83 (ledger item 17).
2. **What I did:** wrote 8 new robot checks, each with a "deliberately wrong" twin that must fail. They sit in a side folder, so the robot ignores them until a Team robot job tries them.
3. **Tools batch 2 covers:**
   1. **CDRENUMBER, the whole tool:** No changes nothing, Yes renumbers only P9 and P10, one U puts every schedule cell back.
   2. **COPY of a pit, the whole tool:** the copy is P8 and the original still reads P3.
   3. **Undo names on your own switches:** U after CD says CD, after PIT says PIT, after MOVE says MOVE.
   4. **Undo names with the switches on:** after [Undo] at the third point, the pipe finishes on two points and one U removes it.
   5. **Pit catch distance:** a pipe ending 50 mm outside a pit's opening joins the pit; one ending 150 mm outside stays free.
   6. **Short pipe label on a leader:** a 2 m pipe gets its label on a leader, not squeezed along the pipe.
   7. **CDFEEDBACK Cancel:** the window opens, Cancel prints "CDFEEDBACK cancelled." and nothing is sent.
   8. **EXPLODE a pit with no pipes:** the plain sentence without the pipe part, and U brings it back.
4. **What it could mean:** if they pass twice and the reviewer agrees, CDRENUMBER, COPY and Undo names become whole: 11 rises to about 14 of 40. The pit catch could make 15. The leader and CDFEEDBACK count only in part.
5. **What stays with Codex or you:**
   1. **Codex look:** the recent-value buttons, where the pit and pipe labels sit, the leader's arrow on the pipe, the drawn schedule over two sheets, the CDCHECKDWG window, the ribbon tab.
   2. **Needs a robot change first:** "hide grade". Its switch is on a window tab the robot cannot open yet.
   3. **Needs your word or a fixture:** CDFEEDBACK "Send report" (the spare login and your yes), the survey half of spot levels, the existing and demolished layers (not built).
6. **Something to know:** five of the checks place pits or pipes. That rewrites your "last values used" file. The robot's safety net does not put that file back.
7. **What you need to do:** nothing.

---

## Technical detail

### A. The 8 drafts (folder `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_28oct_b2\`, 16 files)

1. **N15 `N15_cdrenumber_whole_no_changes_nothing_u_restores_all` (card D20, whole).**
   1. **Proves:** both previews twice; the No sentence; the schedule after No equals the schedule before, cell for cell. After Yes, P8 and P9 (both 450 x 450) and C1 are listed, with no P10. The AGI, WT10, WT11 and WT12 sub-rows stay. U echoes PITSCHEDULE then CDRENUMBER, and every cell equals the start.
   2. **Rests on:** N08's two passes (n27a10, n27b5) and the lines the Opus N27 review asked for.
   3. **Cannot prove:** the PIT LABEL blocks one by one, a TG mark (not in the recorded rows), whether the numbering rule is right (Tim's word). DBMOD after No is recorded only.
   4. **Twin:** answers Yes where N15 answers No; only the "No changed nothing" comparison fails.
2. **N16 `N16_copy_pit_whole_original_keeps_p3` (card D15 plain COPY, whole).**
   1. **Proves:** N12's route plus the missing line. The original label 109E08 reads exactly PIT_LABEL P3 before and after the COPY (tag and value pinned between quote marks).
   2. **Cannot prove:** the Inspector's Check-levels flag (Codex), or a COPY that takes pipes with it.
   3. **Twin:** a flipped check: it expects the original to read P8.
3. **N17 `N17_undo_names_tims_switches_cd_pit_move` (card D19 profile A, Tim's own switches).**
   1. **Proves:** after SETUP-P8, U echoes exactly CD and takes only the pipe; U echoes PIT and takes the pit. MOVE of P3 echoes MOVE on U and puts P3 back. No "Undid:" sentence (switch off).
   2. **Whole-word checks:** `(^|\| )CD( \||$)`, so CDEDIT or PITSCHEDULE cannot pass.
   3. **Cannot prove:** REDO after each U (BUG-861 family).
   4. **Twin:** COPY instead of MOVE; U echoes COPY and the MOVE check fails.
4. **N18 `N18_undo_names_switch_on_route_undo_then_pipe_u` (card D19 profile B, the missing half).**
   1. **Proves:** both switches on through the guard. "Undid: point 3 of the pipe route.", then Enter finishes a two-point pipe. Its box starts at x 150000 and stays above y -86000, so the taken-back point is not in it. Two IL texts, then U echoes CD and leaves nothing new.
   2. **UNCONFIRMED route:** "U" then Enter in one typed chain.
   3. **Twin:** no U; the pipe stays.
5. **N19 `N19_pit_catch_outline_plus_100` (card D02).**
   1. **Proves:** a new pit P8 and two 10 m pipes from the east.
      1. **The near pipe, 50 mm outside the 450 mm opening, is caught:** "Pipe end moved to the inside wall of P8 (was 50 mm short of the wall).", "Flow: Open end -> P8", and its box starts at x 150225.
      2. **The far pipe, 150 mm outside, stays free:** "Flow: Open end -> Open end", box at x 150375. Three "End is free" lines in all.
   2. **DERIVED (from `PitOutline.cs` and `PipeEndWallSnap.cs` with the typed points, never seen):** the "50 mm short" sentence, the count of 3, and both box x values.
   3. **Why 50 and 150 mm, not the card's 90 and 110:** the drawn wall line sits at 100 mm. Ends 50 mm clear of every drawn line keep running object snaps out of the result.
   4. **Cannot prove:** the exact 100 mm boundary.
   5. **Pit size is not typed:** the size boxes are on the Pit tab, which the robot cannot select. It is the remembered 450 x 450 that R02 reads every run, and it is recorded.
   6. **Twin:** the near end moved to 150 mm; "Flow: Open end -> P8" must be absent.
6. **N20 `N20_short_pipe_label_on_leader` (card D11).**
   1. **Proves:** a 2 m pipe, then "Snap callout arrow to pipe:". Two mouse clicks (the N05 and SETUP-P8x2 route) give exactly one multileader and no plain " DIA. " text, and "Pipe text callout cancelled." is never printed.
   2. **UNCONFIRMED:** clicks answering the anchor prompt and the text drag (never driven), and the object name AcDbMLeader.
   3. **Cannot prove:** the arrow point lying on the pipe, the leader's look and its wording. These are recorded only and need a Codex look, so D11 counts in part.
   4. **Twin:** a 20 m pipe; no leader, so the leader count fails.
7. **N21 `N21_cdfeedback_cancel_prints_one_line` (card D29 Part A only).**
   1. **Proves:** the window "Creative Engineering | Feedback" has "Send report" and "Cancel". Cancel closes it and prints exactly one "CDFEEDBACK cancelled.", with no sent or saved line. No window is left and the drawing file is unchanged.
   2. **Cannot prove:**
      1. **Part B:** never pressed (spare login and Tim's yes).
      2. **The feedback folder:** no runner verb lists it.
      3. **The window's look:** Codex.
   3. **Twin:** a flipped check: it expects the "sent" line.
8. **N22 `N22_explode_lone_pit_no_pipe_wording` (card D16, the no-pipe branch N02 does not drive).**
   1. **Proves:** a new pit P8 with no pipe. EXPLODE prints "P8 is now plain linework and has left the schedule. U restores it." (DERIVED from `ExplodeLeftScheduleMessagePolicy.Describe`) with no pipe clause. The block's handle is gone; U echoes EXPLODE and the same handle is back on STORMWATER PIT.
   2. **Why a new pit:** the fixture's lone P9 and P10 have no handle on record.
   3. **Twin:** no U.

### B. Not drafted, and why (for the desk)

1. **D06 hide grade (N10 replacement): needs a driver change.** The toggle "Show grade in pipe text" (id `C2.ShowGradeInText`, `PipeEditWorkshopDialog.xaml`) sits on the New Pipe **Drawing** tab. The window opens on Levels & Flow, and WPF shows the controls of the selected tab only. Neither v2 `ui set` nor v3 `ui-press` can select a tab. The setting route stays blocked by CD_RecentValues.json (pre-flight). Two ways forward:
   1. **A reviewed driver verb:** a "select tab" verb added to the allow-list.
   2. **A Codex click.** Either way, the toggle writes `pipe.nonExistingPipeShowGrade` false into Tim's CD_RecentValues.json, so the case must place a second pipe with the toggle back on.
2. **D13 hand-placed label: needs a route probe.** Its switch is off for Max. The Tidy summary counts "Placed by hand (left alone)" only for marked labels that would otherwise clash (`LinkService.TextClashTidyUp.cs` line 341). A label simply moved 1000 mm up gives 0 even with the switch on, so a clash must be designed first.
3. **D21 group order beyond P and C1, and the P1A/SPS refinement:** needs a fixture with LPD, OG, CP, P1A and SPS pits, and its switch is off.
4. **Edit Pipe cascade, last part:** the Recalculate box body cannot be read (a native box). The "STUB to X1" warning never appeared in a run (R11 notes), so no exact text exists.
5. **D07 raingarden label:** the card asks for an RG label that no run or source shows (Opus N27 finding 3). The desk should settle the card first.
6. **D08 and D07:** with the separate Opus N03/N04 review (not batch 2).
7. **Look items and the rest:** see the Codex/Tim list in FOR TIM item 5; D25 is not built. D22 has its placement button disabled (Codex D6-03), which is worth a bug check. D23 is behind a Save dialog and an Export button the robot may never press.
8. **quick MOVE (R12):** needs a 3.0.83 run and an independent review, not a new case.

### C. Instruction for the Team robot job (copy as is)

1. **When:** a free AutoCAD window, or Tim's weekday hours (8:30 am to 5:30 pm Melbourne) only with `CE_RUNNER_TIM_AWAY=1` set on every runner call.
   1. **Build:** read the installed Civil DLL version first; all passes for one case must be on that same build.
   2. **Gap:** keep AutoCAD closed for at least 3 minutes between sessions (build the wait into your own script; a refused sleep must not be missed).
2. **Remembered values:** before the first run, copy `%APPDATA%\TIM_CE_CADTOOLS\CD_RecentValues.json` to your own scratch folder and record its SHA-256. Record it again at the end. Do not restore it; the desk decides. N17, N18, N19, N20 and N22 type PIT or CD and rewrite it. N15 closes the Pit Schedule four times and may rewrite its filter fields.
3. **Format check:** `pwsh -NoProfile -File "C:\Lisp Files\_ACAD_DRIVER\case_runner.ps1" validate "C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_28oct_b2"` must say 16 checked, 0 invalid.
4. **First pass:** run each draft with its twin, two cases per call, with `run-pack "C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_28oct_b2" -Only "<pair>" -Tag n28a<k> -NoRerun`. The pairs:
   1. `N15,N15_cdrenumber_whole_no_changes_nothing_u_restores_all_BROKEN`
   2. `N16,N16_copy_pit_whole_original_keeps_p3_BROKEN`
   3. `N17,N17_undo_names_tims_switches_cd_pit_move_BROKEN`
   4. `N18,N18_undo_names_switch_on_route_undo_then_pipe_u_BROKEN` (both carry the two SETTING lines, so they share one guarded session)
   5. `N19,N19_pit_catch_outline_plus_100_BROKEN`
   6. `N20,N20_short_pipe_label_on_leader_BROKEN` (needs an unlocked screen: mouse clicks)
   7. `N21,N21_cdfeedback_cancel_prints_one_line_BROKEN`
   8. `N22,N22_explode_lone_pit_no_pipe_wording_BROKEN`
5. **Second pass:** repeat every main case in a NEW call (a new AutoCAD session), tag n28b<k>. Run each twin once only.
6. **Fix only mistakes in the draft text** that the runner shows: a wrong prompt word, a BLOCKED step, a wrong variable, a window or button name, a doubled keyword in AutoCAD's log.
   1. **Never weaken or delete a check** because CE behaves differently from its card: that is a finding. Write it in the report for the desk to file.
   2. **DERIVED lines:** if one fails (N19's "50 mm short" sentence, its count of 3 and its two box x values; N22's sentence), do NOT edit it. Report the exact text or value CE gave, as a finding for the desk.
7. **After any fix,** run that case twice again (its hash changed, so earlier passes no longer count).
8. **Move when ready:**
   1. **Which cases:** a main case that passed twice, with its twin failing for the intended reason (read the twin's failing check), moves to `cases\`; its twin moves to `cases\variants\`.
   2. **Names:** rename on the move to `N<nn>_<words>.case.txt` and `variants\N<nn>_broken.case.txt`, keeping the CASE line unchanged.
   3. **Hashes:** check each file's SHA-256 before and after the move.
9. **Never:**
   1. **Write or edit** any `.review.txt`, existing R or N cases, the runner or driver files, `ledger.json` by hand, DESK_LOG.md or BUG_CARPARK.md.
   2. **Press** Send report.
10. **Report:** write `C:\CE_PLAN\areas\release-v3-colleagues-ROBOT_N_CASES_B2_VALIDATION_<date>.md`. Give per case PASS, FAIL or BLOCKED with run ids, every text fix (before and after), every finding, which cases moved, and the CD_RecentValues.json hashes. Then the desk starts the independent Opus review.

### D. Checks made on the drafts

1. **Format check:** `case_runner.ps1 validate` on the draft folder printed "16 file(s) checked, 0 invalid". The validate branch only reads files (`Invoke-CaseRunnerMain`, lines 422 to 425); no AutoCAD was started.
2. **Re-read against the source and the passing runs, for the pre-flight's usual mistakes:**
   1. **Button names:** "New pit, Continue placement" and "New pipe, Start Pipe", as SETUP-P8. "Cancel" is on the v3 list for "Creative Engineering*".
   2. **Typed chains:** each ends as SETUP-P8 and N07 do. The automatic final Enter finishes a CD route; "U{NL}" plus that Enter answers [Undo] and finishes.
   3. **Ending a run:** mouse-clicked runs end with `v3 esc-key`, typed runs with `esc-prompt`.
   4. **Sentences:** every one is copied from a passing run or from the 96455f13 source line named in the case header. The two not yet seen in a run are marked DERIVED.
   5. **Whole-token checks:** every check reads the full token. U echoes use separator-anchored regexes, labels pin the tag and value between quote marks, and schedule rows pin "Pit P8= | P8=P8 |".
3. **BUG_CARPARK.md:**
   1. **No open entry** says any of these tools behaves differently from its card.
   2. **Help text:** BUG-1215 (Help text for CDFEEDBACK) does not touch the Cancel path.
   3. **Clicks:** BUG-560 is about clicks on pit bodies; N19 types its points.
   4. **Not used by batch 2:** BUG-1225 (DP and OF after a reopen). No batch-2 case places a downpipe, overflow or raingarden.

### E. What this document did not do (RULES 5.9)

1. Nothing was run in AutoCAD; no picture was looked at.
2. No review.txt, ledger, carpark, DESK_LOG, existing case, variant, runner or driver file was touched. Only the 16 new draft files and this report were written.
3. The 11-of-40 count is ledger item 17's; I did not re-count it. Whether N19 makes D02 whole (the 50/150 bracket instead of the card's 90/110) is the reviewer's call.
4. The pit size behind N19's numbers (450 x 450) comes from the remembered New Pit values, which robot runs can change. It is recorded in the case, not set.

## Summary

Eight new robot drafts with failing twins (16 files, format check clean) cover CDRENUMBER whole, COPY whole, Undo names on Tim's switches and with them on, pit catch distance, short-pipe leader, CDFEEDBACK Cancel and EXPLODE of a lone pit. If all pass twice and are reviewed, everyday tools could rise from 11 to about 14 or 15 of 40. Hide grade needs a tab-select driver verb. Hand-placed labels need a designed clash. Looks, Send report and unbuilt items stay with Codex or Tim.
