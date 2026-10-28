# Plan recount 5: the 548-item plan, the 390-item 9 Nov scope and the 40 daily tools (Opus desk assistant, Wed 28 Oct 2026, about 17:40 to 18:30 Melbourne)

**What this is.** The fifth recount, the first since recount 4 (`V3_RECOUNT_2026-10-24.md`, Sat 24 Oct about 02:00). Same list of 548 items, same 390 for 9 Nov. Read-only: nothing built, run, installed or opened in AutoCAD; no Codex job started. The only file written is this one.

**What is installed, read by me from the nine DLLs at about 17:50 tonight:** Civil 3.0.84 and Manager 1.1.84, build 94f521cc (train C-74, all three lanes); Structural 1.0.125, build 204dfad2 (train S-45, all three lanes). Both builds descend from the builds recount 4 counted (f7f7d551 and e6d597c0) and from the 18 Oct count (70a4e24f and 9a8e5d4e), checked by git ancestry, so nothing counted then has been lost.

---

## FOR TIM

1. **The 548-item plan: Built 55% / Tested 2.2%.**
   1. **Built** (in the plugin on your PC): 300 of 548. Another 112 are written but sit in unshipped drafts, so 412 of 548 (75%) counting those.
   2. **Tested** (passed a reviewed robot test in AutoCAD for the whole item): 12 of 548. Another 14 are tested for part of the item only. Counting the parts, 26 of 548 (4.7%).
   3. **Accepted by you:** 0 of 548. Four of the 12 also have a Codex look that passed.

2. **The 9 Nov scope (390 items, Civil + Manager + shared rules): Built 47% / Tested 3.1%.**
   1. **Built:** 184 of 390 in the plugin (290, or 74%, counting the unshipped drafts).
   2. **Tested:** 12 of 390 whole, 26 of 390 (6.7%) counting parts. Every tested item is in this scope. Structural has none.

3. **The 40 daily tools (kept separate, never added to the above): Built 90% / Tested 35%.**
   1. **Built:** 36 of 40. One is half built (office layers), one is not built (existing and demolished layers), two slots on the list were never named.
   2. **Tested:** 14 of 40, robot-accepted. That figure is unchanged since this morning's review (ledger item 19).
   3. **One more may count:** the CDTWL freeboard check has a whole reviewed pass, but the ledger never added it. The desk should rule whether it makes 15.

4. **Why "Built" looks lower than the 75% you heard on 24 Oct.** Nothing was lost. The 24 Oct figure counted unshipped drafts as built. Tonight's rule counts only what is in the plugin on your PC. On the old rule it is still 75%.

5. **What moved since 24 Oct.**
   1. **Built: no change.** Fourteen installs went in (11 Civil and Manager, 3 Structural), all bug fixes. No whole plan item was added.
   2. **Tested: 5 to 12 whole, plus 14 part.** On 24 Oct, 3 items were tested whole and 2 in part.
   3. **Codex look as well: 1 to 4.** The four are Esc at CD's third point, OF and FO, EXPLODE a pit, and the CDSYNC/CDREBUILD warnings.
   4. **Daily tools: 1 of 40 to 14 of 40.**

6. **The 12 plan items now tested whole:**
   1. PIT and CD keep placing until Esc.
   2. A new pipe joins the pit it starts or ends on.
   3. Esc at CD's third point cancels cleanly.
   4. OF and FO share one symbol with their own tag.
   5. One IL text at each pipe end.
   6. ERASE a pit keeps its pipes, and one U brings it back.
   7. COPY a pit makes a renumbered CE copy.
   8. EXPLODE a pit says what left the schedule.
   9. CDEDIT keeps your selection.
   10. CE never saves the drawing.
   11. Undo steps have plain names.
   12. CDSYNC and CDREBUILD warn before they run.

7. **The cheapest wins for the tested number, biggest first.**
   1. **Finish the 14 part-tested items.** Each already has a reviewed robot test. Most need one more check, for example "read the pit labels after CDRENUMBER" or "the 100 mm catch line for a pipe end near a pit". About 8 of them could become whole this week. Three cannot, for these reasons:
      1. **Office layers:** the "never recolour a layer" half is not built.
      2. **CDFEEDBACK Send report:** needs the spare Windows login.
      3. **The raingarden label:** waits on your Monday question 15.
   2. **The 7 daily-tool items with written test cards and no pass yet.** They are the New Pipe recent values, Hide grade, the mid-pipe label, the hand-placed label stays, the schedule onto a next sheet, CDCHECKDWG's summary and the ribbon tab jump. The last two have real faults that Codex saw.
   3. **About 158 built items in the 9 Nov scope with no test at all.** The biggest blocks are about 100 Civil items (16 of them switched off), about 55 shared rules, and Manager's 9.
   4. **Structural: 108 built, 0 tested.** It is outside 9 Nov, and the robot has no Structural cases yet.

8. **Confidence and limits.**
   1. **Tested: high.** I read every robot review file, the robot's results log and every Codex look report since 24 Oct.
   2. **Built: medium.** No recount has ever saved an item-by-item installed list. The 300 is the 18 Oct count, and I confirmed that no whole item has shipped since.
   3. **Whole versus part is the reviewer's word.** For 3 of the 12, the robot test covers the daily card but not every word of the plan line: COPY with pipes or paste, "never saves" for every command, and Undo names for every command. Read strictly, that is 9 whole.
   4. **Builds behind the figures.** The 12 passed twice on 3.0.83. On 3.0.84 (installed 12:59 today) all 12 have passed once so far, and the second pass is running now.
   5. **Codex has not looked at anything since Tue 27 Oct 09:07.** Every Codex pass counted here is on 3.0.72 to 3.0.80.

---

## 1. Method

1. **The list (denominator).** The same 548 as recounts 1 to 4: 526 UX IDs from `04_REFERENCE\ux-plan\V3_UX_PLAN.md` plus the 25 Sep rulings, and 22 build-queue items. The split is Civil 212, Manager 25, Shared 153, Structural 158. The 390 is Civil + Manager + Shared. Bugs are not in it, and the 40 daily tools are kept apart.
2. **BUILT, as the brief defines it, means merged into the installed line.** That equals recount 4's "installed" figure (300 / 184). Recount 4's "built" (412 / 290) also counted code on open draft PRs. I give both, so the drop from 75% to 55% is a change of definition, not a loss.
   1. **How I checked that no whole item shipped since 24 Oct.**
      1. **Commit subjects:** read on f7f7d551..94f521cc (397 commits) and e6d597c0..204dfad2 (109 commits). The only plan ID named is UX-QA-05, through #985, a privacy fix to the existing CDASK feature.
      2. **Train files:** the PR list and finalizer report of every train, C-63 to C-74 and S-43 to S-45.
      3. **New PRs:** the titles of all 86 PRs opened since 24 Oct (#1745 to #1830). All are bug fixes, diagnostics or test guards.
   2. **The only plan-work PR in a train list was #1000 (UX-SEL-01).** It was held at WAITING in C-64 to C-68 and was never installed.
3. **TESTED means a whole plan item with one of these:**
   1. **A runner case** with an independent CLAUDE-ACCEPTED-READY review whose verdict covers the item's whole card, or two such cases together. The review must still match the case hash, and the case must have two passes on one installed build.
   2. **A Codex PASS look** that covers the whole item.
   3. **Parts.** Where the review says "PART" or the Codex look covers only some assertions, the item is counted as part-tested and kept separate.
   4. **Matching to plan items.** I took the item from each case's own PLAN_ITEM line. A case whose line names only a bug, a triage group or a regression card (C37 to C42) is not a plan item.
4. **ACCEPTED** means Tim confirmed, as the brief defines it. I also give "Codex look as well": a whole runner acceptance plus a Codex PASS look of the same behaviour. That is the nearest thing to recount 4's "accepted 1".
5. **Daily tools.** I took the ledger's figure (`ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md`, items 19 and 20) as instructed. I did not re-derive it, except for one reconciliation note (section 4, item 3).

---

## 2. Built (in the installed line)

1. **548:** 300 (55%) in the plugin, 412 (75%) counting open drafts. Recount 4 said the same.
2. **390:** 184 (47%) in the plugin, 290 (74%) counting open drafts. Recount 4 said the same.
3. **By area (installed, from the 18 Oct count, unchanged):**
   1. **Civil:** 110.
   2. **Manager:** 9.
   3. **Shared:** 73, of which 65 are on the Civil/Manager build.
   4. **Structural:** 108.
4. **Installs since recount 4 (QUEUE.md items 296 to 309, 14 installs):**
   1. **Civil and Manager:**
      1. **C-63 to C-65 (3.0.73 to 3.0.75):** C-63 brought 28 PRs, C-64 about 40 and C-65 a set of bug fixes.
      2. **C-67 (3.0.77):** C-66 folded into it.
      3. **C-68 (3.0.78):** the REDO first-click fix, which does not work.
      4. **C-69 (3.0.79):** 11 round-2 fixes.
      5. **C-70 (3.0.80):** REDO diagnostics, all switched off.
      6. **C-71 (3.0.81):** 6 Codex follow-ups.
      7. **C-72 (3.0.82):** 5 PRs.
      8. **C-73 (3.0.83):** REDO diagnostics 2.
      9. **C-74 (3.0.84):** #1830, the BUG-1225 reopened-drawing record fix.
   2. **Structural:**
      1. **S-43 (1.0.123):** 5 PRs.
      2. **S-44 (1.0.124):** 32 PRs.
      3. **S-45 (1.0.125):** 5 PRs.
   3. **Plan effect:** none on whole items. All are bug fixes, diagnostics, wording or guards.
5. **Still not built in the 390:** 100 items (390 minus 290), most paused by Tim's 17 Oct ruling A. That has not changed since 18 Oct.

---

## 3. Tested

### 3a. Whole items (12, all Civil or Shared, all inside the 390)

1. **UX-STD-01b, PIT and CD carry on until Esc:** R01 (card D01).
2. **UX-PIPE-02, a new pipe joins its pit:** R02 for the start half and R02b for the end half (card D03).
3. **UX-PIPE-03, Esc at CD's third point:** R17 (card D04).
   1. **Codex as well:** D1-04 PASS on 3.0.72, Esc and the Enter half.
4. **UX-SRC-01, OF and FO share one symbol:** N03 (card D08).
   1. **Codex as well:** D7-02 PASS on 3.0.78.
5. **UX-CPLAN-26, one IL text per pipe end:** R03 (card D12).
6. **UX-EDIT-01, ERASE a pit:** R19 for one pipe and R19b for six pipes (card D14).
7. **UX-EDIT-02, COPY a pit:** N16 (card D15, a pit copied on its own). R34a and N12 add parts on 3.0.84.
8. **UX-EDIT-04, EXPLODE a pit:** N02, with N22 for the no-pipe wording (card D16).
   1. **Codex as well:** D3-05 PASS on 3.0.75.
9. **UX-STD-06, editing never changes the selection:** R20 (card D17).
10. **UX-STD-03, CE never saves:** R04 with N01 for the CDREBUILD half (card D18).
11. **UX-UNDO-01, plain Undo names:** N17 for Tim's switches, N18 and N07 for switches on (card D19).
12. **UX-REP-01, CDSYNC and CDREBUILD warn first:** R13 with N01 (card D27).
    1. **Codex as well:** D4-01 and D4-02 PASS on 3.0.78.

**Builds:** every case above passed twice in separate AutoCAD starts on Civil 3.0.83 with its review hash matching (ledger items 16 to 19). On 3.0.84 each has one PASS so far, in tester_run73 between 14:30 and 18:05 today. The second pass is running.

**Read strictly (RULES acceptance amendment, point 4):** three are narrower than the plan wording.

1. **UX-EDIT-02:** no COPY with pipes, and no paste.
2. **UX-STD-03:** only CDSYNC, CDRECOVERINVERTS, PITSCHEDULE and CDREBUILD are driven.
3. **UX-UNDO-01:** only the CD, PIT and MOVE echoes are checked.

Strictly, that is 9 whole and 3 more as parts.

### 3b. Part-tested items (14), with what is missing

1. **UX-CPLAN-18 and UX-CPLAN-19, CDRENUMBER (N08, N15):** the pit label blocks on the plan are not read one by one.
2. **UX-PIT-02, pit catch (N19):** the exact 100 mm line is not tested.
3. **UX-CPLAN-21, pit label (N05):** the label position and cover-text corner need a Codex look.
4. **UX-CPLAN-24, short-pipe leader (N20):** the leader wording and arrow position need a Codex look.
5. **UX-SCHED-06, natural order (N09):** newly placed pits and the switch-on refinement are not covered.
6. **UX-SRC-05, DP and CDRG (N04):** the RG1 label is not drawn (Monday question 15), and neither the exact DP1 tag nor DP after a reopen is tested.
7. **UX-LYR-01, office layers (N06):** the "never recolour" half is not built, so this cannot become whole yet.
8. **UX-WORD-03, CDFEEDBACK (N21 and Codex E6-03 PASS):** only Cancel is tested. Send report needs the spare login.
9. **UX-LBL-02, labels re-tidy in an edit (R11, N11):** the STUB warning and the Recalculate box body are not covered.
10. **UX-LBL-03, Tidy labels (R16, and Codex X4-01/X4-03 on 3.0.71):** tested with the switch ON only. It is OFF in Tim's file.
11. **UX-DI-03, CDCHECKIGNORE (R10):** the switch-off half only.
12. **UX-SURV-03, CDSL (R35, and Codex D5-02 PASS):** the typed-level half only. The survey-level half needs a drawing with a stored survey.
13. **UX-SCHED-02, Excel export with a Checking sheet (Codex D5-03 PASS on 3.0.77):** card D23 assertions 1 to 3 are seen. Assertion 4 (every pit on sheet 1, DBMOD unchanged) and the plain-words FIELD column are not.

### 3c. Reviewed and passing, but not plan items (not counted in the 548)

1. **Regression checks:**
   1. **R14 with R14h ×3, CDTWL freeboard:** C39, whole.
   2. **R15, Recover Inverts:** C38.
   3. **R16, Tidy labels names the pipe:** C37.
   4. **R12 and Codex D3-02, quick MOVE:** C41, part.
2. **Other passing cases:**
   1. **R05:** the outcome line.
   2. **R07:** Settings Cancel.
   3. **R21:** CDCHECK totals.
   4. **R23 and R33:** locked layers.
   5. **R26:** CDSURVEY refusal.
   6. **R28:** CDPROFILE start.
   7. **R31:** the CD direction wording.
   8. **R36:** CDFW.
   9. **R37 and R37b:** the perimeter drain.
   10. **R38:** the P3 schedule row.
   11. **R39 and R39b:** CD Existing line.
3. **Codex passes on bugs, not plan items:**
   1. **E6-02:** BUG-219, the versions agree.
   2. **F4-01:** the LandXML file window.
4. **Why none of these counts:** each case's PLAN_ITEM line names a bug, a triage group or a regression card, not a UX ID.

### 3d. Codex looks since 24 Oct (D1 to D8, E1 to E12, F1 to F10)

1. **PASS: 12 distinct results.** D1-04, D3-02, D3-05, D4-01, D4-02, D5-02, D5-03, D7-02, D8-05, E6-02, E6-03, F4-01 (F4-01 passed in two reports).
2. **FAIL:** About CE Suite still cuts off its lower rows (BUG-090: D8-01, E6-01, F10-01). Esc returns to Plug-ins, not the CE tab (D8-04). Pit numbers are missing (F7-01). E11-01 failed on BUG-173 and BUG-073.
3. **Most other lines are BLOCKED or NOT TESTED.** The brief's selection or zoom expressions printed nil, or there was no screen access.
4. **No Codex look on 3.0.81 to 3.0.84.** The last look is F10, Tue 27 Oct 09:07, on 3.0.80.

### 3e. Accepted

1. **By Tim:** 0 of 548. No plan item has Tim's word.
2. **Runner whole plus a Codex PASS look:** 4 items, UX-PIPE-03, UX-SRC-01, UX-EDIT-04 and UX-REP-01.
   1. **Caveats:** the Codex looks are on 3.0.72 to 3.0.78, older than the runner passes. Team Opus stood in for Codex as the independent case reviewer while Codex was at its cap.
3. **Recount 4's one accepted item** ("CDSYNC keeps the Pit Schedule") was a regression line, not a UX ID. It now sits inside UX-REP-01.

---

## 4. The 40 daily tools (separate list, gap plan section 3 item 7)

1. **Built: 36 of 40 (90%).**
   1. **The list:** the gap plan's 30 cards (D01 to D30) plus 8 named regressions: PIT, CD, the Edit Pipe cascade, quick MOVE, CDSYNC keeps the schedule, CDTWL freeboard, Recover Inverts and Tidy labels names the pipe. That is 38 names. The reviewer of 25 Oct noted that the list never reaches 40.
   2. **Of the 30 cards** (`DAILY_TOOLS_TEST_CASES_2026-10-23.md`): 28 are installed, UX-LYR-01 is part built and UX-LYR-04 is not built.
   3. **The 8 regressions** are installed. Tidy labels is installed but switched OFF in Tim's file.
2. **Tested: 14 of 40 (35%), Claude-accepted, from ledger item 19 and unchanged by item 20.**
   1. **The 14:** D01, D03, D04, D08, D12, D14, D15, D16, D17, D18, D19, D27, Recover Inverts, and Tidy labels names the pipe (switch ON only).
   2. **Builds:** whole on 3.0.83. All have one PASS on 3.0.84 so far.
3. **Reconciliation (recount 4 left this open; ledger item 5 asked for it):**
   1. **CDTWL freeboard looks like a 15th.** It is on the gap plan's list, and R14 is CLAUDE-ACCEPTED-READY for C39 whole. Ledger item 14 calls it "one named check newly whole" but leaves the count at 8. **The desk should rule whether it makes 15 of 40.**
   2. **These three are not whole, so the 14 stands for them:**
      1. **CDSYNC keeps the schedule:** R13 covers C42 assertions 1 and 2. The header record is not proved.
      2. **Edit Pipe cascade:** R11 and N11 leave the STUB warning and the Recalculate box uncovered.
      3. **Quick MOVE:** R12 is part, though Codex D3-02 passed.
4. **Moved since 24 Oct:** 1 of 40 to 14 of 40.

---

## 5. What moved since recount 4 (24 Oct), plainly

1. **Built:** no change (300 / 184 installed; 412 / 290 counting drafts). Fourteen installs went in, all bug fixes and diagnostics.
2. **Tested, whole:** 3 to 12. Recount 4 had 5, but 2 of those were parts.
   1. **New whole:** UX-PIPE-03, UX-SRC-01, UX-EDIT-01, UX-EDIT-02, UX-EDIT-04, UX-STD-06, UX-STD-03 (was part), UX-UNDO-01 and UX-REP-01.
   2. **Held whole:** UX-STD-01b, UX-PIPE-02 and UX-CPLAN-26.
3. **Tested, part:** 2 to 14. UX-DI-03 was already part. UX-STD-03 moved to whole.
4. **Codex look as well:** 1 to 4.
5. **Tim-accepted:** 0 to 0.
6. **Daily tools:** 1 of 40 to 14 of 40.
7. **Not plan work, but worth knowing:**
   1. **REDO after a pit pick still fails** (BUG-861).
   2. **The DP1 double-click still opens AutoCAD's attribute editor** (BUG-859).
   3. **CDCHECK words** fail in R22 (BUG-372).
   4. **ROTATE Copy, Edit Pipe arrow and floor waste** are real faults on 3.0.84 (BUG-665, BUG-1222, BUG-1223). C-75 fix jobs started at 18:05.

---

## 6. Cheapest wins for the tested number (detail)

1. **Part to whole, one assertion each (about 8, this week, robot only):**
   1. **UX-CPLAN-18 and 19:** read the plan labels after CDRENUMBER.
   2. **UX-PIT-02:** add the 100 mm line.
   3. **UX-SCHED-06:** place three new pits.
   4. **UX-LBL-02:** the STUB warning and the Recalculate box.
   5. **UX-SCHED-02:** a runner case that reads the xlsx sheet 1 and DBMOD.
   6. **UX-DI-03:** the switch-on half.
   7. **UX-SURV-03:** needs a stored-survey drawing.
2. **Part to whole, needing a Codex look:**
   1. **UX-CPLAN-21:** the label spot.
   2. **UX-CPLAN-24:** the leader wording and arrow.
   3. **When:** Codex resets Fri 30 Oct 04:09.
3. **Cannot become whole yet:**
   1. **UX-LYR-01:** half unbuilt.
   2. **UX-WORD-03 Send report:** needs the spare login.
   3. **UX-SRC-05:** the RG1 label waits on Tim.
   4. **UX-LBL-03:** whole for a colleague only once Tim's switch is ON.
4. **Daily-tool cards written, no pass yet (7):**
   1. **D05 UX-PIPE-04 and D06 UX-PIPE-05:** cards written, no pass.
   2. **D10 UX-CPLAN-23:** R18 needs a stronger assertion.
   3. **D13 UX-LBL-01:** switch OFF.
   4. **D22 UX-SCHED-04:** needs a look.
   5. **D28 UX-IMP-02:** Codex DIFFERENT.
   6. **D30 UX-RIBBON-01:** Codex FAIL, a real fault.
5. **Built, no case at all (estimates from the 18 Oct per-area counts minus what is tested):**
   1. **In the 390:** about 158 items.
   2. **Civil, about 100:** 16 of them are switched off (Tidy labels, the Checks extras, sizing, late survey), and about 21 are engines with nothing calling them. Those 21 cannot be tested from a drafter's route.
   3. **Shared, about 55:** the section 1 rules, such as UX-STD-02, 05 and 08, the windows and the command line.
   4. **Manager:** 9.
   5. **Outside the 390:** Structural, 108 built and 0 tested. There is no Structural runner case.

---

## 7. What I did NOT do or check (RULES 5.9)

1. **Not run or opened.** Nothing was run in AutoCAD, and no screenshot or picture was opened. I took each result from its review file, `runner-reports\ledger.json` and the Codex report text.
2. **No item-by-item installed list.** The 300 / 184 are still the 18 Oct counts, carried through recounts 2 to 5. I checked only that no whole item shipped since 24 Oct. Some of the 300 may be part-installed, and some open-PR items in the 412 may be stale.
3. **No case judged.** I did not re-review any case against its card. Whole or part is the independent reviewer's verdict. Where a case's PLAN_ITEM line names a bug or regression card, I did not map it to a UX ID by guesswork.
4. **No pass recounted by hand.** I did not count two-session passes for every case myself. I took ledger items 16 to 20 for 3.0.83, and counted one PASS per case on 3.0.84 from ledger.json (accepted cases, hash equal to the review).
5. **Not recounted here:** bugs, open PRs, switch defaults in Tim's files, and the PERCENTAGES block meters.
6. **Area split.** Shared versus Civil follows recount 4's rule: section 1 IDs are Shared. Both sit inside the 390, so the 390 figures do not depend on it. I gave no separate Civil + Manager (237) figure.
7. **Tools used.** No helper agents. No worktree edits. AutoCAD, Codex and builds were untouched.

---

## Summary (under 100 words)

Installed tonight: Civil 3.0.84 / Manager 1.1.84, Structural 1.0.125.

1. **548-item plan:** built 300 (55%) in the plugin, 412 (75%) counting unshipped drafts. Tested whole 12 (2.2%), and 26 (4.7%) with parts. Tim-accepted 0.
2. **390 scope:** built 184 (47%). Tested 12 (3.1%), and 26 (6.7%) with parts.
3. **Daily tools:** built 36 of 40 (90%), tested 14 of 40 (35%). CDTWL freeboard may make 15.
4. **Since 24 Oct:** built unchanged (14 installs, all bug fixes), tested whole up from 3 to 12.
5. **Cheapest wins:** finish about 8 part-tested items, then the 7 written daily-tool cards.
