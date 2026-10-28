# Robot next cases, batch 3: 8 new draft checks (28 Oct 2026)

Written Wed 28 Oct 2026, about 13:40 to 15:00 Melbourne, by an Opus planner (desk plan/03; read and write documents only). Nothing was run in AutoCAD, nothing built or installed; the only runs were the robot's offline format check and an offline test of the new text patterns. Installed build when written: **Civil 3.0.84** (commit 94f521cc, branch claude/rel-20261026y, files written 28 Oct 12:14 to 12:20); every source line below was read from that commit with `git show`.

## ANSWER FIRST

### FOR TIM

1. **Where we are:** 14 of the 40 everyday tools are Claude-accepted (ledger item 19).
2. **What I did:** wrote 8 new robot checks, each with a "deliberately wrong" twin that must fail. They sit in a side folder, so the robot ignores them until a Team robot job tries them.
3. **Four of them aim to finish a tool, so the count can rise:**
   1. **Pit catch, the exact 100 mm line (D02):** a pipe ending 90 mm outside a pit joins it; one ending 110 mm outside stays free.
   2. **CDRENUMBER on the plan (D20):** the robot reads every pit label on the drawing. No changes none; Yes turns the P9 label into P8 and P10 into P9, and leaves P1 to P7 and C1 alone; one U puts them back.
   3. **Pit label lands where you click (D09):** the label goes within 1 mm of the point picked (the old check missed by 8 mm only because the robot's view was zoomed right out).
   4. **CDSYNC keeps the schedule after a cascade:** after an Edit Pipe cascade with U and REDO, CDSYNC changes no Pit Schedule figure.
4. **Four cover part of a tool nobody had tested by robot:**
   1. **Hand-placed label (D13), with its switch on:** a pipe text you moved by hand is left alone by Tidy labels, even when you answer Yes.
   2. **Office layers (D24):** your current layer stays the same however you end PIT or CD (Cancel, Esc at any point).
   3. **Pit Schedule order (D21):** a pit placed today slots in at its number (P7, P8, P9, P10), not at the bottom.
   4. **Recent buttons (D05):** after you place a pipe, the next pipe window offers its two invert levels as the first two "recent" buttons.
5. **What it could mean:** if all pass twice and the reviewer agrees, 14 rises to about 18 of 40.
6. **Possibly 15 already:** CDTWL freeboard was accepted whole on 27 Oct but is not in the list of 14. I have asked the desk to check (finding 1 below).
7. **What stays with Codex or you:**
   1. **Codex look:** which way the pipe label reads (D10), the short-pipe leader's words (D11), the windows (D28, D30), the drawn schedule (D22).
   2. **Needs a robot change first:** hide grade (D06) and the pipe size buttons (D05 in full). Both sit on a window tab the robot cannot open.
   3. **Your word or a decision:** the raingarden label (D07, Monday question 15), and whether a hand-placed label should stay put when you move its pit (D13).
8. **Something to know:** seven checks place pits or pipes, so they rewrite your "last values used" file. One of them (D05) puts two test levels, 18.240 and 18.190, at the front of your recent invert buttons. The robot records the file before and after; the desk decides whether to put it back.
9. **What you need to do:** nothing.

---

## Technical detail

### A. The 8 drafts (folder `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_28oct_b3\`, 16 files)

1. **N23 `N23_pit_catch_boundary_90_caught_110_free` (card D02; with N19 the whole card). Hash 58FBD1B465E0; twin B41A66C01A42.**
   1. **Proves:** the card's own pair. A new pit P8, then two 10 m pipes from the east. The end 90 mm outside the 450 mm opening is pulled to the inside wall (box x 150225 within 1 mm) with "Flow: Open end -> P8". The end 110 mm outside stays at x 150335 within 1 mm with "Flow: Open end -> Open end". Exactly two "Flow: " lines, so no other pit is named.
   2. **Rests on:** `PitOutline.Touches` (`u <= maxU + margin`, inclusive, margin 100) and `PipeEndWallSnap.Words` at 94f521cc; N19's route and its exact x 150225 (passes n28c5, n28e4); the review's ask (x 150315 and 150335, far end within 1 mm).
   3. **Snaps:** the drawn wall line is only 10 mm from both ends and Tim's OSMODE is 5375 (Codex D4). The case turns running snaps off with `v3 setvar OSMODE 0` (a profile variable on the v3 list; v3 writes the old value to its restore file first and puts it back when the session ends) and zooms to a 250 mm window.
   4. **DERIVED:** "Pipe end moved to the inside wall of P8 (was 90 mm short of the wall).", both box x values, the "Flow: " count 2, the "End is free" count 3.
   5. **Cannot prove:** behaviour with Tim's snaps on (a click near the wall can be pulled onto it); the pit size is the remembered 450 x 450, recorded, not set.
   6. **Twin:** the near end at 110 mm; "Flow: Open end -> P8" must be absent.
2. **N24 `N24_cdrenumber_plan_labels_one_by_one` (card D20; with N15 the whole card). Hash 323E733AB1AC; twin F4B89D4BCC01.**
   1. **Proves:** the card's M0, M0b, M1 and M2 on the plan itself. Every block on STORMWATER PIT LABEL is read four times with `v3 ent-find AcDbBlockReference -Part "STORMWATER PIT LABEL"` (handle plus `PIT_LABEL=...`). A pattern with a back-reference ties each number to its own block: after No, the P9 and P10 blocks still read P9 and P10 and no label reads P8; after Yes, the block that read P9 reads P8, the P10 block reads P9, no label reads P10 or a temporary id, and the blocks reading P1 to P7 and C1 are unchanged (109E08 still P3). One U echoes CDRENUMBER and the two blocks read P9 and P10 again.
   2. **Why one U:** no Pit Schedule is opened in between, so U takes back CDRENUMBER itself (the card's "M2 = M0 after one U").
   3. **Rests on:** N15's route (passes n28d4, n28f1); `PitRenumberApplyService` at 94f521cc (one write path for labels and schedule; temporary "CDRENUMBER-TEMP-" ids during the swap).
   4. **UNCONFIRMED:** `ent-find` has never run inside a case (it is on the case verb list and read-only). I tested the patterns offline on text built exactly as the runner builds it (section D). That P1 to P7 and C1 each have a plan label (11 labels for 10 pits on this fixture).
   5. **Cannot prove:** a TG mark (not in the fixture); the numbering rule (Tim's word). DBMOD is recorded only (already 1 at open).
   6. **Twin:** no U; "P9 block reads P9 again" must fail.
3. **N25 `N25_pit_label_lands_on_the_picked_point` (card D09, the whole card on its own). Hash 9806DCDBD32D; twin 3E505B860B71.**
   1. **Proves:** N05's checks (one label reading P8 on STORMWATER PIT LABEL, cover text exactly "CL 19.000", one U removes all three) plus the missing line: the label's insertion point within 1 mm of the point clicked.
   2. **Why it can work now:** N05 missed by 8.3 mm in both runs. That is one screen pixel of its 8000 mm high view (8000 / 8.3 is about 960 pixels), so the miss was the pixel, not CE. N25 zooms to a 100 mm high view (about 0.1 mm a pixel), turns snaps off as N23, and clicks straight above the pit, so ORTHO cannot move the point.
   3. **Rests on:** `PitCommand.cs` line 479 (the label goes to the point given, no offset added); N05's click route (passes n27a6, n27b4).
   4. **UNCONFIRMED:** that the click lands within 1 mm at this zoom on this screen. The distance is recorded too.
   5. **Cannot prove:** a typed label point (the card's wording); the robot cannot type at that prompt, so a click at high zoom stands in. Needs an unlocked screen.
   6. **Twin:** the label clicked 5 mm away; "within 1 mm" must fail.
4. **N26 `N26_cdsync_keeps_schedule_after_cascade` (named check "CDSYNC keeps the schedule", card C42; with R13 the whole check). Hash 2E6AC04D844F; twin FACB359D32E4.**
   1. **Proves:** card C42 with its cascade preparation, the part the Opus B5 review found missing. N11's cascade (17.60 / 17.50 from P3, Recalculate Yes, Apply, U, 12 s, REDO), then the schedule shows P3 at 17.50 / 17.45; CDSYNC warns first and relinks; the object count is unchanged; one "Command outcome: CDSYNC completed"; the schedule after CDSYNC equals the one before, row for row and cell for cell.
   2. **Rests on:** N11 (passes n27a12, n27b6; the P3 row after REDO seen exactly); R13 (warning sentence); Codex D4-01 (11 / 49 on an untouched copy).
   3. **DERIVED:** "CDSYNC complete. Pits relinked: 11, Pipes relinked: 49" after a cascade (seen only without one). Card C42's 12 / 50 belong to the SETUP-R47 drawing; its route note allows a fresh drawing with its own counts.
   4. **Cannot prove:** the schedule header count (BUG-855, not recorded); U after CDSYNC (R13 does it).
   5. **Twin:** pit P3 erased after CDSYNC; "rows equal" must fail. The cascade is left out of the twin to keep it short; the comparison step is the same.
5. **N27 `N27_hand_placed_label_left_alone_by_tidy` (card D13 profile B, switch ON; part). Hash D86FA0A8F939; twin 4AEA9A01ACE2.**
   1. **Proves:** with `linking.tidyLabelsEnabled` and `linking.handPlacedLabelsStay` on (two SETTING lines through the guard), the new pipe's start invert text is moved by hand 5 mm, R16's spot level is moved onto it (R16's proven clash), and CDTIDYLABELS All answered Yes counts "Placed by hand (left alone) 1", lists no "start invert text would move" line, and leaves the text exactly where the hand put it.
   2. **Design:** the batch-2 trap is met. "Placed by hand" counts only a marked text that would otherwise move (`LinkService.TextClashTidyUp.cs`, "Opus run 137"), so the case needs R16's clash.
   3. **Rests on:** `NativeEditCommandEndRoutingPolicy` (a MOVE of one pipe text alone takes the atomic route) and `ApplyAtomicAttachmentMoveAfterExternalCommand` (marks it when the switch is on); `TidyLabelsCommand.cs` (the Yes question only when something would move; otherwise "No CE label needs to move.").
   4. **DERIVED:** the count line, the absent move line, the text not moved.
   5. **Cannot prove (so D13 stays part):** card step 3, "move pit P8 500 mm and the label stays". In the installed source only Tidy labels reads the mark (`HandPlacedLabelRule` is used only in `TextClashTidyUp.cs`), so whether a pit move keeps a hand-placed label is for the desk and the card (finding 3). The card says "pipe label"; this case moves the start invert text, the one with a proven clash. The rule marks any pipe text moved on its own.
   6. **Twin (also the card's profile A):** the same steps with `handPlacedLabelsStay` false; the count must read 0 and the Yes answer moves the text, so two checks fail.
6. **N28 `N28_current_layer_kept_on_every_esc_path` (card D24 assertion 1; D24 stays part). Hash C7EFA22D70C4; twin 249965280AC8.**
   1. **Proves:** CLAYER reads BLOCKS at the start and after five endings: New Pit "Cancel without saving"; Esc at CD's third point (R17's line "[CE] CD command cancelled.", nothing drawn); New Pipe "Cancel without saving"; a pit ended with three Esc; a pipe ended with one Esc. Nothing new is on layer 0 or BLOCKS; one pit and one pipe exist.
   2. **Cannot prove:** "never recolour a layer" (not built); CLAYER while CE waits at a prompt (AutoCAD is busy then). What each Cancel printed and the counts after the two window Cancels are recorded, not judged.
   3. **Twin:** sets CLAYER to 0 in the middle (N06_BROKEN's accepted shape).
7. **N29 `N29_new_pit_takes_its_number_place_in_schedule` (card D21 steps 1 to 5; part). Hash 87FAE114D808; twin 26D68459ECD6.**
   1. **Proves:** a new pit P8 is listed P1 ... P7, P8, P9, P10, then C1, and never after P10 (the card's own route; N09 only read the pits already there).
   2. **Cannot prove:** the LPD, OG and CP groups (not in this drawing) and the P1A / SPS refinement (switch off). New pits cannot be given those names: the pit number box is on the New Pit "Pit" tab, which the robot cannot open.
   3. **Twin:** a flipped order (P8 after P10), N09's accepted shape.
8. **N30 `N30_recent_invert_buttons_follow_last_pipe` (card D05; part). Hash DF06428BDFFA; twin 1FDFB44C249F.**
   1. **Proves:** after a pipe placed with 18.240 / 18.190, the next New Pipe window shows "Use recent invert 18.190 m AHD" as the first recent invert button and 18.240 after it.
   2. **Rests on:** `PipeEditWorkshopDialog.xaml` line 266 (button names, Levels & Flow tab, the tab the window opens on); `CdViewModel.Commands.cs` (Start Pipe adds first then second invert; Cancel adds nothing); `SettingsService.AddRecentInvert` (newest at the front, 10 kept).
   3. **DERIVED:** the names and their order (the checks accept "18.19" or "18.190").
   4. **Cannot prove:** the card's diameter and material buttons (on the Pipe tab), a press of a recent button (not on the press list), the look.
   5. **Side effect:** Tim's recent invert list gains 18.240 and 18.190 at the front.
   6. **Twin:** the first window cancelled with 18.260 / 18.210; "18.210 first" must fail.

### B. Not drafted, and why

1. **D06 hide grade and D05 diameters / materials: need a driver change.** Their controls are on the New Pipe "Drawing" and "Pipe" tabs. WPF builds only the open tab's controls, the window opens on "Levels & Flow", and neither v2 `ui set` (no tab pattern) nor any press list (no tab names) can select a tab. A reviewed "select tab" verb is the fix.
2. **D10 pipe label reading direction: needs Codex or a runner change.** The label is MText (`TextService.cs`, BottomCenter); `ent-read` gives a text only its words and insertion point, no rotation. R18 already pins the words to the window and the side; it waits for an independent review.
3. **D11 leader words and arrow point: Codex.** `ent-read` of a multileader returns only handle, object and layer.
4. **D07 raingarden: card question first** (no RG label exists; Monday question 15). DP after a reopen is the desk's BUG-1225 proof (N13, N14 on 3.0.84).
5. **D22 drawn schedule:** "Continue to Place / update" is enabled only when there are output rows and no blocking differences (`PitScheduleWorkflowState.CanPlaceOrUpdate`); Codex saw it disabled. Worth a short probe that reads the button and its tooltip before a case is written. The card also needs a look.
6. **D28 CDCHECKDWG:** Codex D8-02 found the title and report folder differ from the card; the desk should settle the card first.
7. **D26 survey half:** needs a drawing with a stored CDSURVEY survey (no survey Xref exists).
8. **D23, D25, D29 Send, D30:** a Save dialog, not built, the spare login and Tim's yes, a ribbon look.
9. **quick MOVE and Edit Pipe cascade:** R12 was strengthened today (batch 6) and needs an independent review, not a new case. The cascade's missing parts (the STUB to X1 warning, the Recalculate box text) cannot be read: the warning has never appeared and `msgbox-answer` does not return the box text.

### C. Instruction for the Team robot job (copy as is)

1. **When:** a free AutoCAD window (weekday 2:00 to 3:00 pm or after 5:30 pm, or the weekend), or Tim's weekday hours only with `CE_RUNNER_TIM_AWAY=1` set on every runner call.
   1. **Build:** read the installed Civil DLL version first (Civil 3.0.84+94f521cc when written); all passes for one case must be on that same build. If a new build installs during the job, stop, note it, and restart both passes on the new build.
   2. **Gap:** keep AutoCAD closed for at least 3 minutes between sessions (build the wait into your own script; a refused sleep must not be missed).
   3. **Screen:** N25 and its twin click with the real mouse: the screen must be unlocked.
2. **Remembered values:** before the first run, copy `%APPDATA%\TIM_CE_CADTOOLS\CD_RecentValues.json` to your own scratch folder and record its SHA-256. Record it again at the end. Do not restore it; the desk decides. N23, N25, N26, N27, N28, N29 and N30 type PIT, CD or Edit Pipe and rewrite it; N30 puts 18.240 and 18.190 at the front of the recent inverts on purpose.
3. **Format check:** `pwsh -NoProfile -File "C:\Lisp Files\_ACAD_DRIVER\case_runner.ps1" validate "C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_28oct_b3"` must say 16 checked, 0 invalid.
4. **First pass:** run each draft with its twin, two cases per call, with `run-pack "C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_28oct_b3" -Only "<pair>" -Tag n3a<k> -NoRerun`. The pairs:
   1. `N23,N23_pit_catch_boundary_90_caught_110_free_BROKEN`
   2. `N24,N24_cdrenumber_plan_labels_one_by_one_BROKEN`
   3. `N25,N25_pit_label_lands_on_the_picked_point_BROKEN` (needs an unlocked screen: mouse clicks)
   4. `N26,N26_cdsync_keeps_schedule_after_cascade_BROKEN` (N26 takes about 15 minutes under load)
   5. `N27,N27_hand_placed_label_left_alone_by_tidy_BROKEN` (each carries two SETTING lines with a different value, so they run in two guarded sessions)
   6. `N28,N28_current_layer_kept_on_every_esc_path_BROKEN`
   7. `N29,N29_new_pit_takes_its_number_place_in_schedule_BROKEN`
   8. `N30,N30_recent_invert_buttons_follow_last_pipe_BROKEN`
5. **Second pass:** repeat every main case in a NEW call (a new AutoCAD session), tag n3b<k>. Run each twin once only.
6. **Fix only mistakes in the draft text** that the runner shows: a wrong prompt word, a BLOCKED step, a wrong variable, a window or button name, a doubled keyword in AutoCAD's log.
   1. **Never weaken or delete a check** because CE behaves differently from its card: that is a finding. Write it in the report for the desk to file.
   2. **DERIVED lines:** if one fails (N23's sentence, its two x values and its two counts; N26's 11 / 49; N27's count line, the absent move line and the 0 mm; N30's button names and order), do NOT edit it. Report the exact text or value CE gave, as a finding for the desk.
   3. **One narrow exception (N24):** if a "stays" line for P1 to P7 or C1 fails ONLY because that number never appears in the first label read (the evidence shows no `PIT_LABEL=P<n>` in `$lab0`), the draft assumed a label this drawing does not have. Remove that one line, say so in the report with before and after, and rerun twice.
   4. **N24 route:** if `v3 ent-find` is refused or BLOCKED, report it; do not replace it with another route.
7. **After any fix,** run that case twice again (its hash changed, so earlier passes no longer count).
8. **Move when ready:**
   1. **Which cases:** a main case that passed twice, with its twin failing for the intended reason (read the twin's failing check), moves to `cases\`; its twin moves to `cases\variants\`.
   2. **Names:** rename on the move to `N<nn>_<words>.case.txt` and `variants\N<nn>_broken.case.txt`, keeping the CASE line unchanged.
   3. **Hashes:** check each file's SHA-256 before and after the move.
9. **Never:**
   1. **Write or edit** any `.review.txt`, existing R or N cases, the runner or driver files, `ledger.json` by hand, DESK_LOG.md or BUG_CARPARK.md.
   2. **Press** Send report, or any "Use recent ..." button.
10. **Report:** write `C:\CE_PLAN\areas\release-v3-colleagues-ROBOT_N_CASES_B3_VALIDATION_<date>.md`. Give per case PASS, FAIL or BLOCKED with run ids, every text fix (before and after), every finding, which cases moved, and the CD_RecentValues.json hashes. Then the desk starts the independent Opus review.

### D. Checks made on the drafts

1. **Format check:** `case_runner.ps1 validate` on the draft folder printed "16 file(s) checked, 0 invalid" (run twice, the second after a comment edit in N27). It only reads files; no AutoCAD was started. An AutoCAD (pid 64292, started 13:29, a robot run) was open while I worked; I did not touch it.
2. **Patterns tested offline:** a scratch script built text exactly as the runner does (`New-V3Result` shape, `ConvertTo-Json -Compress -Depth 4`, `[regex]::Match`) and ran every new pattern. N24: P9 to P8 and P10 to P9 found; P1 stays found; "P9 again" not found without U; swapped blocks not found. N29: the right order found, P8 at the bottom not found. N30: 18.190 first found, 18.210 first not found. All as intended.
3. **Re-read against the source and the passing runs:**
   1. **Button names:** "New pit, Continue placement", "New pipe, Start Pipe", "Cancel without saving" (id C2.CancelCommand; seen in robot reports and `ui_map\s7\newpit_tree.txt`), Pit Schedule "Close".
   2. **Typed chains:** each ends as R17, N19 and R16 do. `type` adds one Enter at the end.
   3. **Whole-token checks:** U echoes use separator-anchored patterns; labels pin the tag and value; schedule rows pin "Pit P8= | P8=P8 |".
   4. **v3 verbs used:** `setvar` (OSMODE, CLAYER), `view-read`, `pt-click -Blind`, `esc-key`, `ent-find`: all on the case list in `case_runner_lib.ps1`.
4. **Non-ASCII:** none left in the 16 files.
5. **BUG_CARPARK.md (read only):** no open entry says these tools behave differently from their cards. No batch-3 case places a downpipe, overflow or raingarden, so BUG-1225 does not apply.

### E. Findings for the desk (RULES 6.2)

1. **CDTWL freeboard may be missing from the count.** Ledger item 14 (27 Oct) says R14 with R14h x3 is CLAUDE-ACCEPTED-READY for the whole claim and "one named check newly whole: CDTWL freeboard", and item 16 says it holds on 3.0.83. The list of 14 in item 19 has Recover Inverts and Tidy labels (named checks) but not CDTWL. Either the count is 15 or there is a reason I could not find. I did not recount.
2. **Civil 3.0.84 is installed (28 Oct 12:14 to 12:20).** Every acceptance in ledger items 17 to 19 is on 3.0.83 and needs the two-pass regrade on 3.0.84 (the desk's commit f2cf699d says it is queued). Batch 3 must run on 3.0.84.
3. **Card D13 step 3 may not match the product.** The card expects a hand-moved label to stay put when its pit is moved 500 mm ("a pit move re-tidies its pipe's labels"). In the source the hand-placed mark is read only by Tidy labels. Whether a pit move should keep it is a question for Tim's card, not a check.
4. **One driver gap blocks four tools.** The New Pit "Pit" tab hides the size boxes (N19) and the pit number (N29); the New Pipe "Pipe" and "Drawing" tabs hide the size and material buttons (D05) and the grade switch (D06). A reviewed "select tab" driver verb would open D05, D06, the pit size behind D02 and the D21 groups at once.

### F. What this document did not do (RULES 5.9)

1. Nothing was run in AutoCAD; no picture was looked at; no case was run by the runner.
2. No review.txt, ledger, carpark, DESK_LOG, existing case, variant, runner or driver file was touched. Only the 16 new draft files, this spec and one scratch script (`regex_check.ps1` in this session's scratchpad) were written.
3. The 14-of-40 count is ledger item 19's; I did not re-count it. Whether N23, N24, N25 and N26 make their tools whole is the reviewer's call.
4. Unverified on this PC: the click accuracy at 100 mm zoom (N25), `ent-find` inside a case (N24), the hand-placed mark on an invert text (N27), and the order of the recent buttons in the window dump (N30).
5. The drafts folder under `_ACAD_DRIVER` is not in CE_PLAN and is not committed anywhere.

## Summary

Eight new robot drafts with failing twins (16 files, format check clean) for Civil 3.0.84. Four aim to finish a tool: pit catch at 90 / 110 mm (D02), CDRENUMBER read label by label on the plan (D20), pit label within 1 mm of the click (D09), and CDSYNC keeps the schedule after a cascade. Four cover parts of untested tools: hand-placed labels with the switch on (D13), current layer on every Esc path (D24), a new pit's schedule place (D21) and recent invert buttons (D05). If all pass twice and are reviewed, 14 could become about 18 of 40; CDTWL may already make it 15.
