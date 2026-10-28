# Opus independent case review B2: the 8 batch-2 cases (N15 to N22) on Civil 3.0.83 (Wed 28 Oct 2026)

Written Wed 28 Oct 2026, about 12:10 to 12:40 Melbourne (PC clock), by the Team Opus job "INDEPENDENT CASE REVIEW OF THE 8 BATCH-2 CASES (N15 TO N22) ON CIVIL 3.0.83" (desk plan/03), standing in for Codex (at its weekly cap). Read-only on the product: no AutoCAD, no runner, no case, variant, runner, driver, ledger, settings, DESK_LOG.md or BUG_CARPARK.md edit. Files written: this report and eight `.review.txt` files. Rule applied: the RULES.md acceptance amendment of 24 Oct ("Claude-accepted") and `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`. Shape: the N27 and N03/N04 reviews.

## ANSWER FIRST

### FOR TIM

1. **My own mistakes first: none that cost anything.** One of my look-ups used a tool this PC's shell does not have; I re-ran it another way.
2. **Result:** all 8 robot checks passed twice on the installed Civil 3.0.83, and every deliberately wrong copy failed for the right reason. **4 are ready as whole tools, 4 are ready for part of their tool.** None is a fault in CE.
3. **Ready, whole (4):**
   1. **COPY of a pit (N16):** the copy becomes P8, the original still says P3, one U takes the copy away.
   2. **Undo names on your own switches (N17):** U after CD says CD, after PIT says PIT, after MOVE says MOVE.
   3. **Undo names with the switches on (N18):** [Undo] takes back point 3, the pipe finishes on two points, one U says CD and removes it.
   4. **EXPLODE a pit with no pipes (N22):** "P8 is now plain linework and has left the schedule. U restores it." and U brings it back.
4. **Ready for part only (4):**
   1. **CDRENUMBER (N15):** everything is checked through the Pit Schedule. Missing: the pit labels on the plan are never read one by one, which is what the card asks.
   2. **Pit catch (N19):** a pipe ending 50 mm outside the pit is pulled onto the wall; one 150 mm out stays free. Missing: the exact 100 mm line (the card's 90 mm in, 110 mm out).
   3. **Short pipe label on a leader (N20):** a 2 m pipe gets one leader and no label squeezed along it. Missing: what the leader says and where its arrow lands. That needs a Codex look.
   4. **CDFEEDBACK Cancel (N21):** Cancel closes the window and prints one "CDFEEDBACK cancelled." line. Send report was never pressed.
5. **Everyday tools you may now write "FIXED (Claude-accepted, Civil 3.0.83, 28 Oct 2026)", whole:**
   1. **D15 COPY of a pit** (a pit copied on its own).
   2. **D19 Undo names** (N07, N17 and N18 together).
   3. **D16 EXPLODE** was already whole; it now covers the "no pipes" wording as well.
6. **For part only:** D20 CDRENUMBER, D02 pit catch, D11 short pipe leader, D29 CDFEEDBACK Cancel.
7. **The two odd things the robot saw are not CE faults as far as anyone can tell:**
   1. **The window that opened in N19's first try is probably NOT "Grade mismatch".** CE only asks that when the grade is more than 10 per cent off; here it was half a per cent. So which window opened is unknown.
   2. **The refused click in N20** was the robot's own safety check. A drafter clicking with a real mouse is not affected.
8. **Nothing for you to decide or test.**

---

### Counts and the named tools (the desk's detail)

1. **Counts (one verdict per case):**
   1. **CLAUDE-ACCEPTED-READY, whole claim: 4.** N16, N17, N18, N22.
   2. **PARTIAL, ready for the exact part named: 4.** N15, N19, N20 (the rest needs a Codex look), N21.
   3. **NEEDS STRONGER ASSERTION, NEEDS BROKEN VARIANT, NEEDS RUNS, FAIL = real fault: 0** for what the cases claim. What would make each partial case whole is listed below (N15: label reads; N19: a 90/110 pair; N20: a Codex look; N21: a folder listing and Part B).
   4. **Review files written: 8,** each naming the exact current SHA-256; the four partial ones name their part in the VERDICT line. A copy of the gate's three checks (`case_runner.ps1` lines 116-126) passes for all eight: one candidate file each, verdict line, hash equal to the case file now, reviewer not starting with builder.
2. **Named tools, which may now be written "FIXED (Claude-accepted, Civil 3.0.83, 28 Oct 2026)" and for which part:**
   1. **D15 COPY: whole for a pit copied on its own** (N16). Not driven: the "1 pit and N pipes copied ..." wording; the Inspector's Check levels mark is a Codex look.
   2. **D19 Undo names: whole** with N07 (switch on: the "Undid:" sentence, Esc cancels, nothing drawn), N17 (Tim's own switches: CD, PIT, MOVE echoes and what each U takes) and N18 (switch on: a placed CD pipe, U echoes CD). REDO is not in the card.
   3. **D16 EXPLODE: whole, both branches** (N02 with pipes and the schedule; N22 the no-pipe wording).
   4. **D20 CDRENUMBER: part** (N15, which supersedes N08's part). Covered: preview twice, No changes nothing in the Pit Schedule, Yes renumbers P9 and P10 only, the non-P rows stay, U puts every schedule cell back. Missing: the plan's PIT LABEL blocks read one by one (the card's M0, M0b, M1, M2), DBMOD unchanged after No (recorded 1 and 1, not asserted; it was already 1, so it proves little here), a TG mark, the numbering rule (Tim's word).
   5. **D02 pit catch: part** (N19). Covered: the catch is measured from the pit opening, not the drawn block, and its reach lies between 50 and 150 mm; a caught end goes to the inside wall with the "was 50 mm short" sentence. Missing: the 100 mm line itself (90 mm caught, 110 mm free), the far end within 1 mm (asserted within 10, read exact), the pit size read from the schedule.
   6. **D11 short pipe leader: part** (N20). Covered: the callout prompt, exactly one multileader, no along-pipe label, no cancel. Missing, a Codex look: the leader text holds " DIA." and the grade, the arrow within 50 mm of the pipe, the look.
   7. **D29 CDFEEDBACK: Part A, Cancel** (N21). Covered: the window and its two buttons, one "CDFEEDBACK cancelled." line, no result line, no window left, drawing unchanged. Missing: the feedback folder listed before and after (rests on the source: Cancel returns before the only code that writes a file), Part B Send report, the look.
   8. **Unchanged from the earlier reviews:** D08 whole, D07, D09, D21, D24 and the cascade part only; D18 and D27 whole.
3. **The count:** if the desk's recount agrees, D15 and D19 become whole, so the figure should rise by two. I did not recount ledger item 17 myself.
4. **Bugs:** none newly FIXED. No batch-2 case has a PROVES_BUGS line.

## Findings for the desk (RULES 6.2)

1. **The robot's guess about N19's first try does not match the source.** It took the blocked window to be the "Grade mismatch" question. `CdCommand.Grade.cs` `TryDetectCustomGradeMismatch` (lines 232-262 at 96455f13) asks only when the actual grade differs from the custom grade by more than the tolerance, `AchievedGradeNoteTolerancePercent`, default 10. Tim's `CD_Settings.json` has no such key (read only), so 10 applies. A 10.000 m pipe pulled 50 mm to 10.050 m goes from 1 in 200 to 1 in 201: 0.5 per cent. By the source the question should not open. **What the window was is unknown.** The robot did not see it and no snapshot was taken. The fix the robot made (a start 50 mm further in) is harmless to the claim: the caught end, the sentence and the wall position are unchanged. **Not a CE fault as far as is known.** To find out, run the old route once (start 160275,-79850) with a `windows-snapshot` step after Start Pipe. That one run reads the title.
2. **N20's refused click is a tool limit, not CE.** The driver refused because a window of AutoCAD's own process sat under that one pixel (2728,753) just after Start Pipe. While the arrow point is asked, CE uses a plain point prompt (`TextService.cs` line 401); the moving words start only at the second step (line 433). So it may be AutoCAD's own tooltip or Dynamic Input near the cursor. That is my guess only. A drafter's real mouse click is not blocked by a tooltip. **Does not look like a CE fault.**
3. **The trailing-space allowance is real and safe.** The runs show the echo carries trailing whitespace ('| PITSCHEDULE  |', '| CD  |' with two spaces). The robot's guess about the cause is confirmed. `\s*` allows only whitespace between the whole name and a bar or the end. So CDEDIT, PITSCHEDULE2 or a different command cannot pass, and N17's twin proves a wrong name fails.
4. **N19's caught pipe also prints "[CE] Pipe kept. One or more ends have no proven connection. ..."** That is not new: the same line is in the accepted R02 and R02b runs (a pipe with one end on a pit and one free end). It is only a note. Next to "Flow: Open end -> P8" it may read oddly to a drafter; the desk may want to show Tim the wording.
5. **The case headers still say "NOT RUN YET".** Leave them: any edit changes the hash and voids these passes and reviews.

## The cases

1. **N15: CDRENUMBER (D20). Verdict: PARTIAL, ready for the schedule part. Hash A78CC824FFF3.**
   1. **Hash and runs:** the file hashes A78CC824FFF3 now, the same as the three PASS ledger rows (n28c1-s1 09:54, n28d4-s1 10:58, n28f1-s1 11:57). I count d4 and f1: c1 began about a minute after the previous session closed (the robot's own disclosure). The earlier n28a1 FAIL is on the old hash 4F64A0E760C9 (old U-echo pattern only).
   2. **Twin:** N15_BROKEN (7E47B6358A4A, unchanged) in n28a1: the Yes sentence passed, `equals $rowsN $rows0` failed. The right reason.
   3. **Against the source:** No returns at `PitRenumberCommand.cs` line 112, before `PitRenumberApplyService.Apply` (line 116), so nothing is written on No. The Apply service's own comment says labels, the schedule and records share one code path. That is why I trust the schedule as a stand-in, but it is not a read of the labels.
   4. **Values:** the rows are this fixture's own (P9 and P10 unconnected 450 x 450), the same as N08's two runs; right for a fixed fixture.
   5. **Lines to make D20 whole, then two new runs:** read the plan's P9 and P10 PIT LABEL blocks (find their handles once from the fixture, as 109E08 is known for P3) before, after No, after Yes and after the two U, and assert the PIT_LABEL text pinned between quote marks each time ("P9" then "P9" then "P8" then "P9"; "P10" then "P10" then "P9" then "P10"). DBMOD: an `equals $m1 $m0` line would add little, because DBMOD is already 1 before No.
2. **N16: COPY of a pit (D15). Verdict: CLAUDE-ACCEPTED-READY, whole claim. Hash 068633409A51.**
   1. **Runs:** PASS n28c2-s1 and n28d5-s1 on this hash, both first case of their session. Twin N16_BROKEN (0298D5FF40CB) in n28a2: the copy's P8 check passed, the "original reads P8" check failed (it reads P3). A flipped red, the shape reviewers accepted for N12 and N09.
   2. **The N27 ask is met:** `matches $p3_label1 "PIT_LABEL.,.text.:.P3.,.insertion"`, read before and after.
   3. **Small gap accepted:** the card compares handle sets after U; the case compares the count (1034 = 1034). A U that left a stray copy behind and removed something else would be needed to fool it; I accept the count.
3. **N17: Undo names, Tim's own switches (D19 profile A). Verdict: CLAUDE-ACCEPTED-READY, whole claim. Hash D464882B6CC6.**
   1. **Runs:** PASS n28c3-s1 and n28e2-s1; echoes recorded "Command: U | CD", "U | PIT", "U | MOVE"; MOVE to -23569.8 and back to -25569.8; no "Undid:" in 40 lines.
   2. **Twin:** N17_BROKEN on its fixed text DCA03BBCC9EF (n28c3): COPY echo passed, MOVE echo failed. It proves the echo check is not "any echo". The CD and PIT echo lines have no red of their own; they share the exact pattern, so I accept them (as for N03's label lines).
4. **N18: Undo names, switches on, placed pipe (D19 profile B). Verdict: CLAUDE-ACCEPTED-READY, whole claim. Hash 3C39E3F9B3BB.**
   1. **Runs:** PASS n28c4-s1 and n28e3-s1, both with the two SETTING lines through the guard; settings differences 0 at the end. The planner's UNCONFIRMED route ("U" then Enter in one chain) worked.
   2. **What proves point 3 is gone:** the pipe box bottom reads -85112.5 (the pipe width below the -85000 line), not near -87000; x reads 150000 exactly.
   3. **Twin:** N18_BROKEN (1FC38DCCB348, unchanged) in n28a4: 5 objects left, not 0. Its only failing check.
5. **N19: pit catch (D02). Verdict: PARTIAL, ready for the bracket. Hash 7E4978253751.**
   1. **Hash history:** the first text 386E494E085F was BLOCKED in n28a5 (finding 1); both counted passes, n28c5-s1 and n28e4-s1, are on 7E4978253751.
   2. **DERIVED values, all seen exactly, and why they hold:** the sentence comes from `PipeEndWallSnap.cs` with the typed end 50 mm from a 450 mm opening; 150225 is the inside wall; 150375 is the untouched end; three free-end lines are one per free end. All of them hang on the pit being 450 wide. That is the remembered New Pit size, an accident of this PC, but a different size makes the case fail, never pass. The near pipe start move (160275 to 160225) changes only its length, not the end being tested.
   3. **Twin:** N19_BROKEN (FB0BB08AD03E, unchanged) in n28a5: its pipe printed two "End is free" lines and "Flow: Open end -> Open end", so the "-> P8" check failed for the right reason (I read its step evidence; the report's "27 lines read" shows only the first lines).
   4. **To make D02 whole:** a twin pair at 90 mm and 110 mm (ends at x 150315 and 150335 on this pit). The planner feared running object snaps near the drawn wall at 150325. Typed coordinates normally beat running snaps (AutoCAD's OSNAPCOORD); I have not checked this PC's value, so that run is the test. Also tighten `number $far_px = 150375 +- 1`.
6. **N20: short pipe label on a leader (D11). Verdict: PARTIAL, ready for the readable part; needs a Codex look for the rest. Hash AA6B716294DF.**
   1. **Hash history:** BFE535DC7B95 was BLOCKED twice (n28c6, n28d1: the refused click) and once by a watchdog start (n28a6); both counted passes, n28e1-s1 and n28e6-s1, are on AA6B716294DF.
   2. **The "no plain label" check is meaningful:** an along-pipe label reads like '225 DIA. UPVC PIPE AT 1 IN 200' in earlier runs, which `text~ DIA\. ` catches; with the callout, `TextService.cs` line 95 returns before the along-pipe text is made.
   3. **The clicks moved 700 mm** to 150300: the arrow click is still on the pipe line (NEAREST is the only running snap), and the text click is 1.5 m above it. Fine for what is claimed.
   4. **Twin:** N20_BROKEN (8BA604AEC3DA, unchanged) in n28c6: a 20 m pipe placed, `count $leaders = 1` failed with 0.
   5. **Codex look, exactly:** after the N20 route, zoom to the pipe: the leader text reads "<size> DIA. ... AT 1 IN <n>"; the arrowhead sits on the pipe line within 50 mm; the text is clear of the pipe and the IL texts.
7. **N21: CDFEEDBACK Cancel (D29 Part A). Verdict: PARTIAL, ready for Part A Cancel. Hash 073A45629633.**
   1. **Runs:** PASS n28a7-s1 and n28d3-s1 (never edited). The window title reads "Creative Engineering | Feedback (CDFEEDBACK)", which the `contains` check rightly allows. The command line read is exactly "Command: CDFEEDBACK" then "CDFEEDBACK cancelled.".
   2. **Twin:** N21_BROKEN (14B7AF8F31B5) in n28a7: the cancelled line passed, the sent line failed. A flipped red; the "sent" line can only appear after Send report, which was never pressed.
   3. **"Nothing saved" rests on the source:** in `FeedbackCommand.cs` the cancel branch returns before `FeedbackService.SaveFeedback`. That is the only Feedback code that writes a file (I searched the Feedback dialog, view model and service). The card's F1 = F0 folder listing was not observed.
8. **N22: EXPLODE a pit with no pipes (D16 second branch). Verdict: CLAUDE-ACCEPTED-READY, whole claim. Hash A3E5B86CDFA0.**
   1. **The DERIVED sentence is guaranteed by the source:** `ExplodeLeftScheduleMessagePolicy.Describe` with one name and 0 freed ends gives exactly that sentence; a pipe clause would sit before ". U restores it." and break the match, and both clause phrases are asserted absent. P8 is this fixture's lowest free number (as N05, N16).
   2. **Runs:** PASS n28d2-s1 and n28e5-s1 on this hash (the n28a8 FAIL was the old U-echo pattern on 054BB774D168).
   3. **Twin:** N22_BROKEN (127B07E4DB5D, unchanged) in n28a8 and n28d2: the pit placed, `count $back = 1` failed with 0.

## Build and run checks (read myself)

1. **Installed now (12:25):** Civil `3.0.83+96455f13fa2df1e63f8bc7cf9d48bd7dc2c14737` in the Legacy, Modern and Net8 folders, written 27 Oct 18:56 to 19:01. Every n28 run header reads civil 3.0.83+96455f13. First n28 run 08:56, last 12:02 on 28 Oct: no install between, so no run straddles one. No AutoCAD was running when I checked.
2. **Hashes:** all 8 cases and all 8 twins hash today exactly as in the validation report section F and in the ledger rows of their passing and failing runs (ledger.json working copy, 12:15).
3. **Sessions:** every counted pair is two different run calls, each its own AutoCAD start, each case first in its session; clean end in each (AutoCAD left 0, lock none, settings differences 0).
4. **Source:** commit 96455f13 is on origin/claude/rel-20261026x (checked with `git merge-base`); read by `git show` and `git grep` only.

## What I read

1. `C:\TimOS\RULES.md` in full with amendments; `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`; the validation report and the B2 spec in full; the N27 and N03/N04 Opus reviews in full; the R16 and N05 review files; `case_runner.ps1` lines 100-140.
2. Cards D02, D11, D15, D16, D19, D20 and D29 in full.
3. All 8 case files and their twins (full text and a line-by-line comparison); the run reports and run JSON for every counted pass and every twin red (n28a1, a2, a4, a5, a7, a8, c2 to c6, d2 to d5, e1 to e6, f1); ledger rows for N15 to N22.
4. Source at 96455f13: `PitRenumberCommand.cs`, `PitRenumberApplyService.cs`, `ExplodeLeftScheduleMessagePolicy.cs`, `FeedbackCommand.cs` and the Feedback service, dialog and view model, `TextService.cs`, `CdCommand.cs`, `CdCommand.Grade.cs`, `PipeEndpointConnectionReviewService.cs`.
5. Read only: Tim's `CD_Settings.json` (grade block; no tolerance key).

## What I did NOT check (RULES 5.9)

1. Nothing in AutoCAD and no picture was looked at; I did not run the runner.
2. Which window opened in N19's first try (finding 1); this PC's OSNAPCOORD value.
3. The CE log text behind the runs (I relied on the run reports and run JSON, which clip long values).
4. SETUP-P8 bytes at run time (N17 uses it; the gate binds only the case hash).
5. Whether CDRENUMBER's order is right as engineering: Tim's word.
6. The 3-minute gaps between sessions, beyond the robot's own disclosure; the gap is not one of the four acceptance conditions.
7. CD_RecentValues.json was rewritten by the robot's runs and not restored; not mine to judge.

## Files written

1. This report.
2. Eight review files beside the cases in `C:\Lisp Files\_ACAD_DRIVER\cases\`: `N15_cdrenumber_whole_no_changes_nothing_u_restores_all.review.txt`, `N16_copy_pit_whole_original_keeps_p3.review.txt`, `N17_undo_names_tims_switches_cd_pit_move.review.txt`, `N18_undo_names_switch_on_route_undo_then_pipe_u.review.txt`, `N19_pit_catch_outline_plus_100.review.txt`, `N20_short_pipe_label_on_leader.review.txt`, `N21_cdfeedback_cancel_prints_one_line.review.txt`, `N22_explode_lone_pit_no_pipe_wording.review.txt`. Copies of the same eight, byte for byte, in `areas\runner-reports\reviews\`.
3. Scratch on this PC only: `C:\ce-fx\opus_b2rev\dump.ps1`. Undo: delete the eight review files and revert this commit.

## Summary (under 100 words)

All 8 batch-2 cases passed twice on Civil 3.0.83 with no install between, and each twin failed for the right reason. Ready whole: N16 COPY, N17 and N18 Undo names, N22 EXPLODE with no pipes. Ready for part: N15 CDRENUMBER (labels not read), N19 pit catch (50/150 mm, not the 100 mm line), N20 leader (wording and arrow need Codex), N21 CDFEEDBACK Cancel. D15 and D19 become whole; D16 now covers both branches. The N19 window was probably not "Grade mismatch" (0.5 per cent against a 10 per cent rule). Neither robot finding looks like a CE fault.
