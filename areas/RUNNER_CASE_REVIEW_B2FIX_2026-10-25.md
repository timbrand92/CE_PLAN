# Runner case review, batch 2 fixes: R12, R23, R28, R19b re-checked, R15 to R20 confirmed on Civil 3.0.75 (Opus independent review, Sun 25 Oct 2026)

Written Sun 25 Oct 2026, about 08:50 to 09:20 Melbourne (PC clock), by an independent Opus reviewer. Read-only: nothing run in AutoCAD, no runner, case, variant, settings, lock, run report or ledger file edited, no bug status changed, `BUG_CARPARK.md` and `DESK_LOG.md` not touched, nothing committed or pushed. The only files written are this one and one `.review.txt` file (listed at the end). Rule applied: the RULES.md acceptance amendment of 24 Oct ("Claude-accepted") and `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`. Contract: the asks of `RUNNER_CASE_REVIEW_B2_2026-10-24.md`. Method and shape: `RUNNER_CASE_REVIEW_HARDEN_2026-10-25.md` and `RUNNER_CASE_REVIEW_B3_2026-10-25.md`.

## FOR TIM

1. **1 more case is ready to count as Claude-accepted, on today's build (Civil 3.0.75):** with the pipe layer locked, CDEDIT says plainly "the layer is locked, CE will not unlock it, nothing was changed" for one pipe and for two pipes (R23).
2. **1 bug may now be written "FIXED (Claude-accepted)":** BUG-384 (the batch editor blamed "label records" instead of the locked layer).
3. **Everyday tools accepted on today's build: 4 of 40** (Esc at CD's third point, CDEDIT keeps your selection, Recover Inverts, Tidy labels names the pipe). They were re-run twice on 3.0.75 and still pass. Two more (PIT and CD keep placing, one IL text at each pipe end) are accepted on yesterday's build only, so 6 of 40 in all.
4. **Not ready yet, with the reason:** the quick MOVE check (R12) does not read the pit's name label or cover level text; the erase-a-pit check (R19b) reads only 1 of the 6 pipes; the long-section start (R28) does not read which pit the Profiles window took. Exact lines are below the line.
5. **Nothing for you to decide.**

---

**What I read:** the builder's report `release-v3-colleagues-RUNNER_B2_FIXES_REPORT.md` (all of it); the batch 2 review (all of it, its asks are the contract); the harden and batch 3 reviews (method and shape); RULES.md and the Claude-accepted decision; the four changed case files R12, R23, R28, R19b and the variants R12_BROKEN, R12_NOU_BROKEN, R23_BROKEN, R28_BROKEN, R19b_BROKEN; the existing review files of R12, R15, R16, R17, R20; `runner-reports\ledger.json` (285 rows) joined row by row to today's file hashes, which I took myself (sha256sum); the run reports b2d1, b2d2, b2d3, the acceptance lines of b2a2, b2b2, b2c2, the probes b2probe9, b2probe9c and b2probeR38, and the three probe case files PRB9, PRB9b, PRB9c in `C:\ce_rc_scratch\b2fix\probes`; the `dist`, `contains`, `matches` and `control` code in `case_runner_lib.ps1`; cards C41, C42 (`TEST_CASES_DRAFT_22OCT.md`) and D14 (`DAILY_TOOLS_TEST_CASES_2026-10-23.md`); BUG-384 and BUG-862 in `BUG_CARPARK.md`; BUG-384's origin, item C6 of `C:\Lisp Files\_TEST_COPIES_20260923\DRIVER_RUN20_2026-10-04.md`, and its fix note in the Team lane 2 log; the gap plan's 40 checks (section 3 item 7) and section 2; the product version of every installed Civil DLL and the creation time of the live bundle folders.

## ANSWER FIRST

1. **Counts (one main verdict per case, 8 cases: 4 changed, 4 confirmed unchanged):**
   1. **CLAUDE-ACCEPTED-READY: 5.** R23 (BUG-384, new). R15 (Recover Inverts), R16 (Tidy labels names the pipe), R17 (D04), R20 (D17): unchanged texts, their existing review files still match, and they now have two passes on **Civil 3.0.75**.
   2. **NEEDS BROKEN VARIANT: 0.** R19b's red now exists.
   3. **NEEDS STRONGER ASSERTION: 2.** R19b (5 of its 6 pipes are not read; title says "keeps every pipe"), R28 (title says "takes pit P3"; which pit was taken is not read).
   4. **PARTIAL (part only): 1.** R12 (pit and two invert texts move and come back; the pit's name label and cover text, which card C41 names, are not read).
   5. **NEEDS CODEX LOOK: 0.**
   6. **FAIL = real fault: 0.**
2. **Build and ledger checks: all true.**
   1. **Build:** the live Civil and Manager bundle folders were created at **03:33:02**; all three Civil DLLs (Legacy, Modern, Net8) read **3.0.75+2c805a39** now. Every run of this job is 07:50 to 08:47, so no run straddled an install. The report is right that 3.0.74 was no longer installed.
   2. **Hashes:** every case and variant hash in the report equals today's file hash (R23 47044D1E70E6, R12 84658F195D14, R28 3A778E5F30F1, R19b E1FE2D54B3FA; variants d24705fb8160, baef9edad42b, 928917e7af5a, 4729bb887f19). R15 6626D755, R16 92E250C4, R17 E252738D, R20 4CEA2382 equal the hash named in their review files.
   3. **Two separate sessions, current text, Civil 3.0.75:** R12, R23 in b2d1 and b2d3; R19b, R28 in b2d2 and b2d3; R15 in b2a1 and b2a2; R16 in b2b1 and b2b2; R17, R20 in b2c1 and b2c2. No FAIL, FLAKY or BLOCKED row on 3.0.75 for any of the eight.
   4. **Reds on the current variant text:** R23_BROKEN, R12_NOU_BROKEN, R19b_BROKEN, R28_BROKEN each FAILED once on 3.0.75. The older reds of R15, R16, R17, R20 still match their variants' current hashes (R15_BROKEN C287A88E, R16_OFF_BROKEN 54B33C7A, R17_BROKEN 0E7EB344, R20_BROKEN 3F7D66A6).
   5. **The runner printed ACCEPTED-READY** for R15 (b2a2), R16 (b2b2), R17 and R20 (b2c2). I confirmed each line in the run reports.
3. **Daily tools (D-numbers) and gap-plan checks accepted ON CIVIL 3.0.75: 4 of 40.**
   1. **D04** (Esc at CD's third point cancels the pipe): R17, passes b2c1 and b2c2.
   2. **D17** (CDEDIT leaves your selection as it was): R20, passes b2c1 and b2c2.
   3. **Recover Inverts** (named check, spec C38): R15, passes b2a1 and b2a2.
   4. **Tidy labels names the pipe** (named check, spec C37): R16, passes b2b1 and b2b2. Only with Tidy labels switched on, which the case does itself; it is OFF in Tim's file, so OFF for Max on 9 Nov.
   5. **Accepted, but not on 3.0.75:** D01 (R01) and D12 (R03), on 3.0.74 only. The ledger has no row of R01 or R03 on 3.0.75.
   6. **Added by this job: none.** R12 is part of "quick MOVE"; R19b is part of D14; R23 and R28 are not among the 40.
4. **Bugs that may be written "FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026)": 1.**
   1. **BUG-384**, for exactly its own route: CDEDIT with one pipe and with two pipes on the locked layer STORMWATER PIPE. I read the origin (driver run 20, item C6, 4 Oct): lock the pipe layer, CDEDIT on two pipes, refusal at open blaming "label records". R23 is that route. Every part of the bug's expected line is pinned word for word. Suggested wording: "FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026): R23 b2d1 + b2d3, red R23_BROKEN b2d1; CDEDIT one and two pipes on a locked pipe layer. Mixed selections (some pipes on an unlocked layer) not run. BUG-797 and BUG-254 not covered." Never close or delete the entry (D6).
   2. **Not BUG-797, not BUG-254:** not driven (the report says so; I agree).
   3. **BUG-856:** already "FIXED (Codex-accepted, Civil 3.0.67)". R16 is now its regression guard on 3.0.75 too. Nothing to change in the entry.
5. **Clean current count for the desk, and how I counted:**
   1. **Everyday tools accepted on Civil 3.0.75: 4 of 40** (D04, D17, Recover Inverts, Tidy labels names the pipe). **On any build: 6 of 40** (those 4, plus D01 and D12 on 3.0.74).
   2. **Rule used:** one per gap-plan item. An item counts only when its case (or cases) covers the whole card, has two PASS rows in separate sessions on Civil 3.0.75 with today's file hash, no FAIL on 3.0.75, a red on the current variant text, and a review file naming today's hash. PIT and CD are not counted apart from D01 (no card defines them apart; same as the harden review).
   3. **Denominator, for the desk to settle:** the gap plan's line names 8 checks plus "the 30 in section 2" (section 2 has 30 numbered items), which is **38**, but it says 40. I report against 40, as the earlier reviews did.
   4. **Other Claude-accepted-ready cases on 3.0.75, not among the 40 (do not add them to the 40):** R23 (BUG-384), R31 (BUG-205 wording half), R35 (BUG-711), R37 (BUG-217 without the look), R39b (BUG-684). R05 (#1507) and R08 (spec C32) are ready on 3.0.74 only.
6. **Things the desk should know first:**
   1. **BUG-862 is still there for CDEDIT on 3.0.75.** Both R23 runs (b2d1, b2d3) logged "Command outcome: CDEDIT completed" for each of the two refusals ("Nothing was changed"). BUG-862's expected says a refusal is logged "refused". So BUG-862's refused half is not fixed for CDEDIT, whatever R10 shows for CDCHECKIGNORE. Attach this to BUG-862; not judged by any case.
   2. **The report's "cells are read-only (no cell edit is possible)" is wrong (RULES 6.2).** The b2probeR38 dump shows each P3 cell with `"readonly":false`, and driver run 20 (4 Oct) changed P3's cover from 18.88 to 18.89 in this window. It does not change any verdict, but no case should be built on "the cells cannot be edited".
   3. **The R28 explanation holds.** PRB9 and PRB9c are the same pick at the same point; the only difference is the ZOOM. Without it all five picks inside the pit's 950 mm circle were refused; with it the pick was taken and the Profiles window opened. "Pit outside the view" is the builder's reading: the view in PRB9 was never read, so what is proven is "the view, not CE". I state nothing about how AutoCAD picks inside itself.
   4. **Seen in passing, not judged:** CDPROFILE closed with nothing done logs "Command outcome: CDPROFILE completed" (b2d2, b2d3). Whether a window closed without action should read "cancelled" is the BUG-862 family; not judged.

## How I applied the four conditions

1. **Nothing seen on screen.** Met for every check of R12, R19b, R23 and R28: positions, counts, command-line lines, window titles in the window list, file hash. R28's window is asserted by its title only; what it lists is not judged (it is not a look, but it is not read either: see R28).
2. **Two passes in separate AutoCAD sessions on one build.** Item 2.3 of ANSWER FIRST, from the ledger, current hashes only. b2d1, b2d2 and b2d3 are three separate AutoCADs; each held two to four cases with a fresh drawing per case.
3. **Red before green.** Every variant FAILED on its current text, from a check, for the intended reason (I read each first failure):
   1. **R23_BROKEN** (b2d1): a true red. No lock, so "This pipe was drawn with an older version of CE ..." is asked, Edit Pipe and Edit 2 Pipes open, and both refusal sentences are missing (checks 1, 2, 3, 5 failed).
   2. **R12_NOU_BROKEN** (b2d1): a true red. No U, so the two texts read 1990.3 and 1988 mm from their old places.
   3. **R19b_BROKEN** (b2d2): a flipped red (expects 7). The rule accepts it.
   4. **R28_BROKEN** (b2d2): a true red. The pick on an empty place is refused ("Select a CE pit block."), no Profiles window.
4. **Compared with the card or bug, and full coverage.** Line by line below.

## The cases

1. **R23: locked pipe layer, CDEDIT refuses (triage L2; BUG-384).** Verdict: **CLAUDE-ACCEPTED-READY** for BUG-384 as written, on Civil 3.0.75. Review file written.
   1. **Asks met, all three:** the two-pipe sentence pinned whole ("[CE] The batch editor was not opened and nothing was changed: layer STORMWATER PIPE is locked (pipe P4 -> P3; pipe AGI -> C1). CE will not unlock it: unlock it, or choose other pipes, then edit again."); `not-contains $ed2 "label records do not match"`; `BUG BUG-384` in the header, so the runner demands its red.
   2. **The one-pipe route too:** "[CE] Pipe not opened for editing: layer STORMWATER PIPE is locked, and CE will not unlock it. Nothing was changed." No Edit Pipe, no Edit 2 Pipes, no CE window; every IL text reads as before (chunk 0 holds no IL text, so the 500 and 1000 chunks are the whole plan; R38's list confirms it).
   3. **Against the bug:** BUG-384's expected asks for three things (layer locked, nothing changed, CE will not unlock it). All three are in both sentences. The route is the bug's own (run 20 item C6: refusal at open of the batch editor).
   4. **Limits, not blockers:** text checks ignore capital letters (runner gap, still open); the layer's lock flag is not read (the second refusal shows it is still locked); a mixed selection is not run (the fix note covers it, the bug does not).
2. **R12: quick MOVE (C41; gap-plan check "quick MOVE").** Verdict: **PARTIAL.** It counts for "MOVE of pit P3 opens no CE window, two of its invert texts follow it about 2 m, and one U puts the pit and both texts back exactly".
   1. **Asks met, all five:** `$back_a`, `$ret_a`, `$back_b`, `$ret_b` read after U; `number $ret_a = 0 +- 0.5` and `number $ret_b = 0 +- 0.5`; both read 0 in b2d1 and b2d3. A true red (R12_NOU_BROKEN). An empty select cannot pass quietly: `dist` throws on an empty list (`case_runner_lib.ps1` line 325).
   2. **Still not covered by C41, as the batch 2 review said:** the pit's name label and its cover text (C41 step 1 and assertion 3, "all monitored positions"). **Lines to add (probe once first, record only, to learn the handles and old places):**
      1. Before the MOVE: `select $a0 "name~^PIT LABEL" "near=53777.7,-25569.8,3000" -> $lab0` and `select $a0 "text~^CL" "near=53777.7,-25569.8,3000" -> $cl0` (repeat on `$b0` and on `ms-new 0` if the probe finds them in another chunk), then `field $lab0 handle -> $hlab`, `field $cl0 handle -> $hcl`, `record` both with their x,y.
      2. After the MOVE: `select $a1 "handle=<label handle>" -> $lab1`, `dist $lab1 "<old x,y>" -> $mv_lab`; the same for the cover text. ASSERT `number $mv_lab = 2000 +- 150` and `number $mv_cl = 2000 +- 150`.
      3. After U: the same two `dist` reads into `$ret_lab`, `$ret_cl`. ASSERT `number $ret_lab = 0 +- 0.5` and `number $ret_cl = 0 +- 0.5`.
   3. **An open question the case hides (Unknown, file nothing):** pit P3 has six pipe ends with invert texts (run 20: 17.30, 17.25, 18.10, 18.10, 18.24, 18.24), and the case's own six texts within 4000 mm match that. Only two are measured, and they are the two that "follow the pit". Whether the other four should follow is not written anywhere (C41 says the placement rules must be supplied with the handles). **Line, record only:** after the MOVE, `dist` each of 1155B6, 116A0E, 116A3C and 116BE4 from its old place and `record` it, so the desk sees which texts followed and which stayed 2 m from their pit.
   4. **Optional:** C41 asks U back "within 0.001"; `dist` rounds to 0.1 mm, so `0 +- 0.5` is the tightest honest check. Leave it.
3. **R28: CDPROFILE start (triage Q1).** Verdict: **NEEDS STRONGER ASSERTION**, one line. It counts for nothing either way (special item a).
   1. **Asks met:** `not-contains $p1 "Select a CE pit block."`; the Profiles window `contains $win_p "Profiles (CDPROFILE)"`; nothing left open; object count 1034 before and after; file hash unchanged. R28_BROKEN is a true red.
   2. **Does it prove CDPROFILE takes a pit and opens the Profiles window?** Yes, for "a CE pit block was taken" (CE refuses anything else, as the red shows) and "the Profiles window opened" (title in the window list, two sessions).
   3. **What it does not prove: that the pit was P3.** The title says "takes pit P3". The pick is 200 mm inside P3's outline, so P3 is by far the likeliest, but the case never reads it. The probe PRB9c dump shows the window lists the start pit right under its instruction line ("Choose a start pit and route. ..." then a text "P3"). **Lines to add:** after `windows-snapshot -> $win_p`, `ui-dump "Profiles" -> $pd`; ASSERT `matches $pd "name.:.Choose a start pit and route\. Preview before placing or updating the profile\..[^{]*\},\{.type.:.Text.,.name.:.P3."`. R28_BROKEN then fails that line too (no window). Two passes on 3.0.75 after the edit.
   4. **Then:** ready for its narrow claim only. No Q1 bug, no long-section value, no D-number and none of the 40 is proved. Keep it as the first step of the long-section route.
4. **R19b: erase pit P3 with six pipes (D14 plural branch).** Verdict: **NEEDS STRONGER ASSERTION.**
   1. **Asks met, all three:** the red exists (R19b_BROKEN, flipped, failed); the whole sentence with 6 is pinned; `ms-count` before and after U are equal (1034 and 1034, both sessions).
   2. **Is 6 right?** Yes, from outside the case: driver run 20 (4 Oct) read P3's Pit Schedule rows as the main inlet from P4, the outlet, and four small pipes WT10, WT9, WT4, WT3. Six ends.
   3. **The gap, D14 assertion 2 ("all N pipes still exist after the ERASE"):** only 10A98D is read. The count check cannot cover it: an ERASE that also took pipes would be put back by U, and the count after U would still equal. The title says "keeps every pipe". **Lines to add:**
      1. **Probe once** (record only): `ms-new 0 -> $q0`, `ms-new 500 -> $q5`, `ms-new 1000 -> $q10`; on each, `select <chunk> "layer~^STORMWATER PIPE$" "near=53777.7,-25569.8,3000" -> <set>` and `field <set> handle -All` plus `record`, to list the six pipe handles that end at P3. Also `ms-count -> $e1` straight after the ERASE and `record $e1`.
      2. **In R19b, after `sleep 2`:** `ent-read <handle> -> $pK` for each of the six, ASSERT `contains $pK "STORMWATER PIPE"` for each; and `ms-count -> $e1` with ASSERT `number $e1 = <the probe's value>`, so the ERASE removed only the pit and its own parts.
   4. **Then:** with R19b whole on 3.0.75, **D14 can count**. The card's "N from the Pit Schedule" is a method; the figure 6 is already independently backed (item 4.2). R19 (the one-pipe wording) is a separate branch and is not needed for D14 as the card names pit P3.
   5. **Cosmetic, at that edit:** the header and NOT_AUTOMATED line still say the Pit Schedule cannot be closed; it can (R25, R38).
5. **R15, R16, R17, R20: unchanged, confirmed on 3.0.75.** Verdict: **CLAUDE-ACCEPTED-READY** stands for each, now on Civil 3.0.75.
   1. **R15** (Recover Inverts, C38): b2a1, b2a2; review file hash 6626D755... matches.
   2. **R16** (Tidy labels names the pipe, C37; BUG-856 guard): b2b1, b2b2; 92E250C4... matches. Switch on in the case only.
   3. **R17** (D04): b2c1, b2c2; E252738D... matches.
   4. **R20** (D17): b2c1, b2c2; 4CEA2382... matches.
   5. **Their review files say "on Civil 3.0.73" or "3.0.74"** in the verdict line. That wording is history, not a fault: the runner keys on the hash. I did not edit them (the hashes did not change).

## The Pit Schedule probe (special item d)

1. **What it proves:** on Civil 3.0.75, with R38's text run once outside the ledger (b2probeR38), the runner can open PITSCHEDULE, dump its grid, find the row "Pit P3" by name, read its cells in order (P3, 900 x 900, P4, 17.30, 17.25, 18.88), and close the window with its Close button; the copy on disk is unchanged. The row was marked off-screen yet was in the dump, so on this drawing the grid gives every row.
2. **What it does not prove:**
   1. **It is not a pass of R38** (no ledger row). R38 itself is still NEEDS STRONGER ASSERTION from the batch 3 review.
   2. **A second open after another command** in the same case has never been driven.
   3. **A whole-schedule compare:** the dump carries bounds, off-screen and selected flags that depend on layout and scrolling. `equals` on two whole dumps would fail for reasons that are not figures. The runner has no step that lists only the cell texts.
   4. **Larger schedules:** whether rows far off-screen still appear is not known.
3. **Does it open the way for a CDSYNC-schedule case (C42, "CDSYNC keeps the schedule")?** Yes, for a reduced form; not yet for C42 whole.
   1. **Reduced form, possible now:** fresh DRV1_B1 copy (C42's ROUTE note allows a fresh-drawing baseline). PITSCHEDULE, dump, pin three or four rows by `matches` in R38's form (P3 and its neighbours), Close; CDSYNC; PITSCHEDULE again, the same `matches` lines, Close. Probe the second open first. Record, never fail on, the data-issues header count (BUG-855). A flipped red (one figure changed) meets the rule.
   2. **C42 whole needs:** "every schedule row and cell equals baseline". That needs a runner step that turns a grid dump into a plain list of cell texts (for the runner owner), and C42's recorded setup (C37 steps 1 to 6 and the cascade).
   3. **Counting:** the reduced form counts for part of "CDSYNC keeps the schedule" only.

## For the runner owner (not case faults, listed so they are not lost)

1. **A grid-to-text step** (item 3.2 above), so a schedule can be compared whole before and after a command.
2. **Still open from earlier reviews:** a red only for `BUG` cases (R12, R19b, R28 carry an empty `BUG` line, so the runner would not demand their reds); case-blind text checks; the build stamp read before the lock wait; the cut close-windows record; `folder-new-only` passes when nothing appears.
3. **Review files name a build in their verdict line.** When a case is re-proved on a new build with the same text, the file still says the old build. Consider printing the build of the two passes beside ACCEPTED-READY in the report, so nobody reads the file's build as current.

## What I did NOT check

1. **I ran nothing.** No AutoCAD, no runner. Every result is read from the ledger and the run reports.
2. **I looked at no picture.** No window's look is judged here.
3. **Installed code:** not read. I did not check which commit fixed BUG-384 inside 3.0.75; the case result is the proof.
4. **Tim's four settings files:** I relied on each run's end-of-session fingerprints (all equal, 0 differences in every session I read).
5. **The full text of b2a1, b2b1, b2c1 and b2c2:** I read the ledger rows and the acceptance lines, not every check line of the unchanged cases (their texts and reviews are unchanged).
6. **Not re-reviewed:** R01 to R11, R13, R14, R18, R21, R22, R24 to R27, R29 to R40.

## Files written

1. `C:\CE_PLAN\areas\RUNNER_CASE_REVIEW_B2FIX_2026-10-25.md` (this file).
2. `C:\Lisp Files\_ACAD_DRIVER\cases\R23_locked_pipe_layer_cdedit_refuses.review.txt` (new; case hash 47044D1E70E6...).

No review file for R12, R19b or R28. R12's old review file still names its old text (BD224816...), so the runner will not count it. R15, R16, R17 and R20 review files untouched (their hashes did not change).

## Summary

R23 is Claude-accepted-ready on Civil 3.0.75, so BUG-384 may be written "FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026)" for CDEDIT on a locked pipe layer. R15, R16, R17 and R20 are unchanged and passed twice on 3.0.75: 4 of 40 everyday checks accepted on today's build (6 of 40 on any build). R12 is part only (label and cover text not read). R19b reads 1 of 6 pipes and R28 never reads which pit it took: exact lines given. The Pit Schedule probe opens the way to a reduced CDSYNC-schedule case. CDEDIT refusals still log "completed" (BUG-862).
