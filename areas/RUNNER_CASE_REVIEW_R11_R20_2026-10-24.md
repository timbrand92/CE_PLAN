# Runner case review: R11 to R20 against their cards (Opus independent review, Sat 24 Oct 2026)

Written Sat 24 Oct 2026, about 09:20 to 10:00 Melbourne (PC clock), by an independent Opus reviewer. Read-only: nothing run in AutoCAD, no runner, case or settings file edited, no bug status changed, BUG_CARPARK.md not touched. Rule applied: the RULES.md acceptance amendment of 24 Oct ("Claude-accepted") and `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`. Standard followed: `RUNNER_CASE_REVIEW_2026-10-24.md` (R01 to R10).

**What I read:** the ten case files R11 to R20, the shared setup `SETUP-R47`, the five broken variants (R12, R14, R15, R17, R18) in `C:\Lisp Files\_ACAD_DRIVER\cases`; the builder's report `release-v3-colleagues-RUNNER_PHASE3_BATCH1_REPORT.md`; `runner-reports\ledger.json` and the run 1 to run 4 reports (`p3b1run1A` to `p3b1run4F`); specs C37 to C42 in `TEST_CASES_DRAFT_22OCT.md`; daily cards D04, D10, D14, D17 and D27 in `DAILY_TOOLS_TEST_CASES_2026-10-23.md`; BUG-856, BUG-855, BUG-698, BUG-777, BUG-789, BUG-797, BUG-782, BUG-816, BUG-820, BUG-862, BUG-871 and BUG-1032 in `BUG_CARPARK.md`; the gap plan item 3.7 list of 40 daily-tool checks; the runner code that decides which command-line and log lines a case reads (`case_runner.ps1`, `case_runner_lib.ps1`, `acad_driver_v3_session.ps1`); and, read-only, the freeboard and pipe-size keys in Tim's `CD_Settings.json` (hash ACD64E79A33B, unchanged).

## ANSWER FIRST

1. **Counts (one main verdict per case, 10 cases):**
   1. **CLAUDE-ACCEPTED-READY: 1** (R15, Recover Inverts totals, card C38). Only the paperwork is left: the independent review line (item 10 of "For the runner owner").
   2. **NEEDS BROKEN VARIANT: 2** (R16, R20). Their checks are sound; neither has a red run.
   3. **NEEDS STRONGER ASSERTION: 4** (R11, R12, R14, R18). Each could pass while part of its card is broken. The exact lines to add are in each item.
   4. **PARTIAL (part only): 3** (R13, R17, R19). Each fully proves one half of its card and leaves the other half untested.
   5. **NEEDS CODEX LOOK: 0 as a main verdict.** R18's label position (Above side, reads left to right) needs one: RULES says a label position is a look.
   6. **FAIL = real fault: 0.** All ten passed in runs 3 and 4 with today's file hashes.
2. **Daily tools (D-numbers) now Claude-accepted-ready: none.** The desk should NOT raise the daily-tools count for a D-number yet.
   1. **D17 (CDEDIT keeps the selection, R20):** one broken variant away. Its checks are exact.
   2. **D04 (Esc at CD's third point, R17):** the Esc half is ready (all four conditions met for that half). The "Enter gives the straight pipe" half stops at the window opening. One small edit, then two runs.
   3. **D10 (pipe label, R18), D14 (erase a pit, R19), D27 (CDSYNC warning, R13):** part only.
3. **Gap-plan checks (the 40 of item 3.7) that are not D-numbers:**
   1. **Ready:** "Recover Inverts" (C38, R15).
   2. **Not ready:** "Edit Pipe cascade with U and REDO" (R11), "quick MOVE" (R12), "CDTWL freeboard" (R14), "Tidy labels names the pipe" (R16).
   3. **Not proved by R13:** "CDSYNC keeps the schedule" (C42). The recount already counts it as accepted from Codex W1-03 (BUG-698). R13 adds nothing to that.
   4. **Recount effect:** the 40-check count may rise by 1 (Recover Inverts), once the review line is recorded.
4. **Bugs that may be written "FIXED (Claude-accepted, build, date)": none.**
   1. **No case has a PROVES_BUGS line.** The builder wrote that no bug number applies, and I agree.
   2. **BUG-856** (Tidy labels names the pipe) is already "FIXED (Codex-accepted, Civil 3.0.67, 21 Oct 2026)". R16 is a regression guard for it on 3.0.72. It changes nothing in the entry.
   3. **BUG-820** (Recover Inverts totals) is already FIXED (Codex-accepted, 3.0.64) for the totals half. R15 does not assert the figure that fix changed ("21 already had invert text"), so it is not a guard for it yet (optional edit in item 5).
5. **Three things the desk should know first:**
   1. **The runner's "ACCEPTED-READY" lines for R11 to R20 are wrong.** The runner counts the builder's own "builder-filled: Opus review still needed" text as a filled review. Only R15 is ready, on this review.
   2. **Cases sharing SETUP-R47 read the command line and the CE log from the start of the setup, not from their own start.** So R18, R14, R13 and R19 also see the lines of every case that ran before them in the same drawing (code: `case_runner.ps1`, the shared-setup branch copies the setup's log offsets). The README says the opposite. I checked every check in today's order: none was satisfied by another case's text. But reordering, or adding a variant that runs CDSYNC or CDTWL before R13 or R14, would break their "count = 1" checks, or let them pass on another case's words. Order any new variant AFTER the case it copies.
   3. **Four things were seen in passing on 3.0.72.** No case judges them, but they bear on open bugs:
      1. **BUG-816 still prints.** R12's MOVE (Tidy labels off, Tim's real setting) printed "[CE Civil] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is (on "SC")." Both runs.
      2. **BUG-1032 still prints.** R14's record shows "the top of the highest detention pipe pipe 10B03B" and "19.55 ... - -810 mm below the lowest lid".
      3. **Possible BUG-862 leftover (not proven).** CD logged "Command outcome: CD completed" for R17's contrast run, where New Pipe was closed by "Cancel without saving" and CD then ended by Esc. CDEDIT logged "completed" after R20's "Edit 2 Pipes" was closed by Cancel. BUG-862's expected rule is "cancelled only when nothing was done". Nothing counted the objects after those two closes, so whether anything was placed or changed is not known.
      4. **Where the 225 pipe size comes from is not known.** R18's label reads 225 DIA. Tim's file has `pipe.diameter` "100". `pipe.lastChoiceByJob` holds 225 only for `c:\lisp files\_test_copies_20260923`, not for the runner's copy folder `C:\ce_rc_drv`. So "the window's last-used value" (the builder's reading) is not established. Do not change the D10 card to 225 until someone finds where 225 comes from.

## How I applied the four conditions

1. **Nothing seen on screen.** Met for all ten, with one exception. Every check reads a drawing value, a command-line line, a CE log line, a selection or a window title. The exception is R18: its card also asks for the label's Above side and that it reads left to right. RULES lists a label position as a look, so that part needs Codex.
2. **Two passes in separate AutoCAD sessions on one build.** Met for all ten. The ledger rows of run 3 (`0806` A, `0812` C, `0819` E, `0825` F) and run 4 (`0832` A, `0838` C, `0845` E, `0853` F) are PASS on Civil 3.0.72+f7f7d551. Their case SHA-256 values equal today's files, which I re-hashed. Runs 1 and 2 were older case texts (different hashes) and do not count. Each session ended clean, with settings fingerprint differences 0.
3. **Red before green.** The five variants each FAILED in runs 1 and 2, with today's variant hashes, and each for the intended reason:
   1. **R12_BROKEN:** the pit was not where it was expected.
   2. **R14_BROKEN:** "Only 41 mm" was not found.
   3. **R15_BROKEN:** "27 pipes recovered" was not found.
   4. **R17_BROKEN:** no New Pipe window opened.
   5. **R18_BROKEN:** the label did not end "AT 1 IN 150".

   All five are flipped expectations. As in the R01 to R10 review, a flipped variant proves the check can go red, not that the case catches a broken feature. The rule accepts it, so I count it. Where a real switch exists, I name the better red.
4. **Compared with the card, and full coverage.** Judged on the case text, line by line, in the items below.

## The cases

1. **R11: Edit Pipe cascade with U and REDO (spec C40; plan UX-LBL-02; gap-plan check "Edit Pipe cascade with U and REDO").** Verdict: **NEEDS STRONGER ASSERTION**, then **NEEDS BROKEN VARIANT**. Part only.
   1. **Conditions:**
      1. **Nothing seen:** met.
      2. **Two passes:** met (run3F, run4F, SHA BCDD8B10).
      3. **Red:** none.
      4. **Card:** partly met.
   2. **Strong part.** Four exact checks:
      1. **After U:** the whole set of 'IL ' texts equals the set before the edit (`equals $all2 $all0`).
      2. **After REDO:** it equals the set after the cascade (`equals $all3 $all1`).
      3. **Echoes:** U echoes CDEDIT, and REDO says "Everything has been redone".
      4. **Outcome:** one "CDEDIT completed" log line.

      This closes C40's open point that the texts after U were never read.
   3. **Weak part: the cascade result itself is not checked.** `not-contains $all1 $all0` only proves that the texts changed somehow. A cascade that wrote wrong levels would still pass, as long as the history line printed right. C40 assertion 2 asks for P3's values to equal 17.60 and 17.50. The after-cascade set was identical in run3F and run4F, so it can be pinned. Add:
      1. `contains $all1 "IL 17.60"`
      2. `contains $all1 "IL 17.50"`
      3. `equals $all1 "IL 17.67 | IL 17.58 | IL 17.53 | IL 17.45 | IL 17.45 | IL 17.33 | IL 18.20 | IL 18.00 | IL 17.28 | IL 17.18 | IL 18.50 | IL 18.10 | IL 17.13 | IL 17.07 | IL 17.02 | IL 16.81 | IL 17.65 | IL 17.58 | IL 17.98 | IL 18.60 | IL 18.00 | IL 18.60 | IL 18.00 | IL 18.40 | IL 18.15 | IL 18.40 | IL 18.15 | IL 18.40 | IL 18.10 | IL 18.40 | IL 18.10 | IL 18.40 | IL 18.19 | IL 18.40 | IL 18.14 | IL 18.60 | IL 18.34 | IL 18.60 | IL 18.28 | IL 18.60 | IL 18.24 || IL 18.60 | IL 18.24 | IL 17.60 | IL 17.50"` (the exact string recorded in both runs).

      In drawing words, the pinned string says: P3's texts now read 17.60 and 17.50, and the four downstream pipes each rose 0.20 m.
   4. **Not covered (count the case for "the texts" only):**
      1. **Project data:** the stored invert values (C40 assertion 2, "database values") are not read.
      2. **STUB warning:** whether the "missing-level STUB -> X1" warning is kept (C40 assertion 1) is not asserted or recorded.
      3. **The Recalculate box:** its "17.30 -> 17.50" wording (C40 step 3) is not read.
   5. **Broken variant (exact change):** copy R11 as `variants\R11_broken.case.txt` with `VARIANT_OF R11`, `EXPECT-FAIL BROKEN-VARIANT`, `ORDER 41`. Replace `equals $all2 $all0` with `equals $all2 $all1`, so it expects U to leave the cascade levels in place. It must FAIL on that check.

      A truer red, if one session can be spared, puts one plain command between U and REDO: `type "_.CIRCLE{NL}60000,-25000{NL}100" -Force`. Then "Everything has been redone" must FAIL. That proves the REDO check can catch a lost REDO.

2. **R12: quick MOVE of a pit opens no CE window and one U puts it back (spec C41; backlog W1-02; gap-plan check "quick MOVE").** Verdict: **NEEDS STRONGER ASSERTION.** Part only.
   1. **Conditions:**
      1. **Nothing seen:** met.
      2. **Two passes:** met (run3A, run4A).
      3. **Red:** met (R12_BROKEN failed twice).
      4. **Card:** partly met.
   2. **Strong part:**
      1. **The move:** "1 found", and the pit's insertion point moves exactly 2000 mm up with X unchanged.
      2. **The U:** one U (echo MOVE) puts it back.
   3. **Gap 1: the window check names only five windows.** C41 assertion 2 also names "Design Warnings" and "CE message" windows. Both runs show the window list after MOVE is only the AutoCAD main window, so make the check exact:
      1. `equals $win1 $win0`
      2. `equals $win2 $win0`
   4. **Gap 2: nothing linked to the pit is checked.** C41 is about CE's live links following a native MOVE ("leaves its labels behind" is its FAIL MEANS). The case reads only the pit block. The route is unproven, so probe it first. Read the 'IL ' texts near P3 before and after:
      1. **Before the move:** `ms-new 500 -> $m`, then `select $m "text~^IL " near=53777.7,-25569.8,1500 -> $il0`.
      2. **After the move:** the same select at `near=53777.7,-23569.8,1500 -> $il1`.
      3. **After U:** at the old point again -> `$il2`.
      4. **Checks:** `count $il1` equals the count of `$il0`, and `count $il2` equals it too.

      The pipe ends that should follow the pit are not readable through `ent-read` (a pipe returns only handle, object and layer), so say so in NOT_AUTOMATED.
   5. **Observation (recorded, not judged):** the MOVE printed the BUG-816 line, "pipe P3 -> P2 label: no clear spot ... (on "SC")", with Tidy labels off, in both runs.

3. **R13: CDSYNC warns first, relinks, one U takes it back (daily card D27, CDSYNC half; spec C42 reduced; plan UX-REP-01).** Verdict: **PARTIAL.** It also needs a stronger wording check and a broken variant.
   1. **Conditions:**
      1. **Nothing seen:** met.
      2. **Two passes:** met (run3C, run4C).
      3. **Red:** none.
      4. **Card:** half of D27; none of C42's real point.
   2. **What it proves:**
      1. **The order:** the warning comes before "CDSYNC complete".
      2. **The counts:** "Pits relinked: 12, Pipes relinked: 50".
      3. **No objects added or lost.**
      4. **The U:** one U echoes CDSYNC.
      5. **The outcome:** one "CDSYNC completed" log line.
   3. **What it does NOT prove:**
      1. **C42 (CDSYNC keeps the Pit Schedule figures):** the case says so honestly, because the driver cannot read or close the Pit Schedule on 3.0.72. Do not count "CDSYNC keeps the schedule" from R13. It is already counted from Codex W1-03 under BUG-698.
      2. **D27's CDREBUILD half (assertions 2 and 3):** never driven. Its prompts are unknown, so probe it first.
      3. **That U really undid anything:** only the echo is read. Nothing measurable is restored.
   4. **Stronger wording (D27 assertion 1 names the whole sentence, including "One U undoes it.").** Add:
      1. `history has "[CE] CDSYNC will re-link every pit and pipe in this drawing to CE's records, from what is currently drawn. One U undoes it."`

      Both runs printed exactly this.
   5. **Broken variant (exact change):** `variants\R13_broken.case.txt`. Use the same FIXTURE, SLOT, SETUP SETUP-R47, and `ORDER 42` (after R13; never before it, see "Three things", item 2).
      1. **Steps:** `type "CDSYNC" -Force -> $s2`, then `wait`, then `type "U"`, then `wait`.
      2. **Assert:** `contains $s2 "Pits relinked: 11, Pipes relinked: 49"`. These are the untouched-copy numbers, so it must FAIL in the R47 context.
   6. **Counts for:** the CDSYNC half of D27 only, after the two edits and a red.

4. **R14: CDTWL freeboard (spec C39; gap-plan check "CDTWL freeboard").** Verdict: **NEEDS STRONGER ASSERTION** (small).
   1. **Conditions:**
      1. **Nothing seen:** met.
      2. **Two passes:** met (run3C, run4C).
      3. **Red:** met (R14_BROKEN failed twice).
      4. **Card:** partly met.
   2. **Gap 1: the two 110 mm pits are not named.** C39 assertion 2 says the 110 mm lines are for P1 and P7, each naming 150 mm. The case only counts two lines containing "Only 110 mm", so CDTWL naming the wrong pits would still pass. Both runs printed these lines; add them:
      1. `history has "[CE] Only 110 mm between the water and the lid of pit P1 (150 mm is wanted)."`
      2. `history has "[CE] Only 110 mm between the water and the lid of pit P7 (150 mm is wanted)."`
   3. **Gap 2: "asks nothing more" is not checked.** `not-contains $win_end "New "` is about windows, not prompts. After the `sleep 2`, add:
      1. `getvar CMDACTIVE -> $ca`
      2. `equals $ca 0`
   4. **A true red, better than the flipped 41 mm.** The freeboard comes from Settings, and Tim's file holds it TWICE, both 150: `pipe.detentionFreeboardMm` and `designStandards.detentionFreeboardMm`.
      1. **The variant:** a session with `SETTING CD_Settings.json designStandards.detentionFreeboardMm 100` must FAIL R14, because the C1 line would say "(100 mm is wanted)" and P1 and P7 would pass.
      2. **The second key:** a second variant with `pipe.detentionFreeboardMm 100` tells the desk which key CDTWL really reads.
      3. **Why it matters:** two keys for one value is a Settings-first (R-00) question for the desk.
   5. **Engineering note:** 150 mm is Tim's own Settings value, so the case is a regression guard on the wording, not an approval of the figure.
   6. **Observation (recorded, not judged):** the BUG-1032 wording is still on 3.0.72: "pipe pipe 10B03B" and "- -810 mm below the lowest lid".

5. **R15: Recover Inverts reports 26 recovered, 24 skipped and the one-end-only warning (spec C38; gap-plan check "Recover Inverts").** Verdict: **CLAUDE-ACCEPTED-READY** for C38 as written.
   1. **Conditions:**
      1. **Nothing seen:** met.
      2. **Two passes:** met (run3C, run4C, SHA 6626D755).
      3. **Red:** met (R15_BROKEN failed twice).
      4. **Card:** met, all three C38 assertions:
         1. **The found line:** "Found 50 pipes in project data, 26 with stored invert values." is exact.
         2. **The totals:** "26 pipes recovered", "24 skipped" and "5 pipes have only one of their two invert texts" are all present, and nothing claims text was drawn.
         3. **The outcome:** exactly one "CDRECOVERINVERTS completed" log line.
   2. **R15 is the first case in its session, so the scope issue does not touch it.**
   3. **What C38 does not cover (keep it separate, do not hold R15 for it):** whether a missing IL text is redrawn (BUG-789, fix installed, not accepted). Both runs said "0 invert texts written", because no text was missing. A future R15b should erase both IL texts of the new pipe and expect "2 invert texts written".
   4. **Optional, at the next edit only, because it changes the hash:** this guards BUG-820's totals fix (26 - 5 = 21):
      1. `history has "26 pipes recovered, 0 invert texts written, 21 already had invert text, 24 skipped"`

6. **R16: Tidy labels names the pipe (spec C37; BUG-856; gap-plan check "Tidy labels names the pipe").** Verdict: **NEEDS BROKEN VARIANT** (plus three small additions).
   1. **Conditions:**
      1. **Nothing seen:** met.
      2. **Two passes:** met (run3E, run4E).
      3. **Red:** none.
      4. **Card:** mostly met.
   2. **The heart is sound.** `history has "pipe P8 -> open end start invert text would move 275 mm (further out)."` matches the whole line, so the old unnamed wording of BUG-856 would fail it. "Nothing was moved." and one "CDTIDYLABELS cancelled" log line cover C37 assertion 3.
   3. **Weak but harmless:** `matches $tidy "pipe P\d+ -> .*would move \d+ mm"` matched across two lines ("pipe P3 -> P2 label ... | pipe P8 ... would move 275 mm"). It would pass even if the "would move" line named no pipe. The exact line above is what really guards the bug.
   4. **Add (C37 assertion 2 and step 5):**
      1. `history has "Placed by hand (left alone) 0"`
      2. `history has "No clear spot found 1"`
      3. `history has "No clear spot found: pipe P3 -> P2 label."`
      4. `contains $spot0 "SPOT LEVEL"`. The builder is right that 10EC5D is a pre-existing fixture SPOT LEVEL block (layer 20TEXT, attribute P18.998), not a newly placed one. The C37 card wording is wrong there.

      Avoid the "·" separator in assertions, because it came back as a replacement character in one record.
   5. **The switch:** the case needs `linking.tidyLabelsEnabled` true through the settings guard (restored by hash; fingerprint differences 0 in both sessions). This is fine for a regression guard. But Tidy labels is OFF in Tim's real file, so it is OFF for Max on 9 Nov; count it as "works when switched on".
   6. **Broken variant (exact change):** `variants\R16_broken.case.txt`. It carries the SAME `SETTING` line and `SETUP SETUP-R47`, so it shares R16's session, with `ORDER 31`.
      1. **Steps:** `type "CDTIDYLABELS{NL}All" -Force -> $t2`, then `esc-prompt`, then `wait`.
      2. **Assert:** `contains $t2 "pipe P9 -> open end start invert text would move 275 mm"`. It must FAIL.

      A true red is the same case WITHOUT the SETTING line (Tidy labels off), which must fail "Will move 1". It needs its own session (about 8 minutes).
   7. **Bug:** BUG-856 is already FIXED (Codex-accepted, 3.0.67). R16 is its regression guard on 3.0.72; nothing to change in the entry.

7. **R17: Esc at CD's third point cancels the pipe (daily card D04; plan UX-PIPE-03; Tim's 25 Sep ruling "Keep CE's rule").** Verdict: **PARTIAL.** The Esc half is ready; the Enter half needs one edit.
   1. **Conditions:**
      1. **Nothing seen:** met.
      2. **Two passes:** met (run3A, run4A).
      3. **Red:** met (R17_BROKEN failed twice).
      4. **Card:** assertions 1 and 2 met; assertion 3 half met.
   2. **The Esc half is sound:**
      1. **The cancel line:** "[CE] CD command cancelled."
      2. **No window:** no New Pipe window opened.
      3. **Nothing left:** the object count is unchanged at 1034.
      4. **The outcome:** exactly one "CD cancelled" log line.
   3. **Gap: D04 assertion 3 ("exactly one pipe" after the Enter contrast) is not checked.** The case only sees New Pipe open and then cancels it. Replace the contrast steps after `windows-snapshot -> $win_b` with:
      1. `ui2-set "New Pipe" "C2.FirstInvert" "18.000"`
      2. `ui2-set "New Pipe" "C2.SecondInvert" "17.900"`
      3. `ui-press "New Pipe" "New pipe, Start Pipe" -> $pipe_c`
      4. `await-window-gone "^New Pipe" -Secs 120`
      5. `esc-prompt -> $cd_esc2`
      6. `wait`
      7. `ms-new $cnt_b -> $after_c`
      8. `select $after_c "object~^CeCvlPipeObject$" -> $pipe_new`

      Then assert `count $pipe_new = 1`. Raise TIMEOUT to 900, because placing a pipe took up to 4 minutes under load. R20, later in the same session, reads only objects 0 to 499, so it is not affected.
   4. **Tighter "nothing left" (optional):** `ms-new $cnt_a -> $left` with `count $left = 0` is closer to D04's "H1 = H0" than a count.
   5. **Observation:** the contrast run, closed by "Cancel without saving" and ended by Esc, logged "CD completed". See "Three things", item 3.3. The edit above makes this moot for the case, but someone should check it for BUG-862.

8. **R18: the pipe label reads "<size> DIA. <material> PIPE AT 1 IN 200" near the middle (daily card D10; plan UX-CPLAN-23).** Verdict: **NEEDS STRONGER ASSERTION**; the position part **NEEDS CODEX LOOK**.
   1. **Conditions:**
      1. **Nothing seen:** met for the wording and the count, not for the position.
      2. **Two passes:** met (run3C, run4C).
      3. **Red:** met (R18_BROKEN failed twice).
      4. **Card:** partly met.
   2. **Gap 1: the size and material are not compared with anything.** D10 assertion 1 is that the label equals the New Pipe window's size and material. The regex `^\d+ DIA\. \S+ PIPE AT 1 IN 200$` accepts any size, so a label that printed 100 while the window held 225 would pass. Fix it one of two ways:
      1. **Read the window:** in SETUP-R47, read the New Pipe window before "Start Pipe" (`ui-dump "New Pipe" -> $np_win`). In R18, assert that its diameter and material controls hold the values the label shows. That changes the setup hash, so all six SETUP-R47 cases need two fresh runs.
      2. **Pin the label:** `equals $label_text "225 DIA. UPVC PIPE AT 1 IN 200"`, after someone finds where 225 comes from ("Three things", item 3.4). If it comes from the drawing or a lookup that can change, the pin will break.
   3. **Gap 2: the grade is pinned to 200 by text, not worked out from the pipe.** That is acceptable here, because the setup always draws the same 20 m pipe falling 100 mm.
   4. **Position:** 262.8 mm from the middle in both runs; the card allows 2000 mm. The insertion point (160112.5, -79762.5) is above the pipe line at y -80000. A numeric guard is cheap: `field $label y -> $ly` with `number $ly > -80000`. But the Above side and the left-to-right reading are a label position, so they need a Codex look before D10 counts whole.
   5. **Card:** D10's title "100 DIA." does not match 3.0.72. Do not edit it until the source of 225 is known.

9. **R19: erase a pit, its pipe stays, one U restores (daily card D14; plan UX-EDIT-01).** Verdict: **PARTIAL** (a one-pipe pit only); it also needs a broken variant.
   1. **Conditions:**
      1. **Nothing seen:** met.
      2. **Two passes:** met (run3C, run4C).
      3. **Red:** none.
      4. **Card:** met for a pit with ONE pipe.
   2. **Strong part:**
      1. **The message:** "1 pipe now has an end that is Not connected yet".
      2. **The pipe stays:** it can still be read after the ERASE.
      3. **The U:** it echoes ERASE, the count returns to 1040, and the pit is back on STORMWATER PIT at 150000,-80000.
   3. **Stronger lines (cheap):**
      1. **The whole line:** assert it exactly, since both runs printed exactly the card's sentence: `history has "[CE Civil] The pit was erased and the schedule is updated. 1 pipe now has an end that is Not connected yet. U restores everything."`
      2. **The count:** replace `number $e1 < $e0` with `number $e1 = 1039`. "Fewer" would also pass if CE erased the pipe's texts along with the pit.
   4. **Not covered:**
      1. **More than one pipe:** the card's own pit P3 has several pipes, and the plural wording "N pipes now have ends that are Not connected yet" is a separate branch of the message.
      2. **The links coming back:** that U reconnects the pipe end is not read.

      Proposed R19b, in the fresh no-setup session after R20:
      1. **Steps:** `pick-first "109D56"`, then `type "_.ERASE" -Force -> $er3`, then `wait`, then `ent-read 10A98D -> $pp`, then `type "U" -> $u3`, then `wait`, then `ent-read 109D56 -> $p3`.
      2. **Assert:** `matches $er3 "The pit was erased and the schedule is updated\. \d+ pipes now have ends that are Not connected yet\. U restores everything\."`, `contains $pp "CeCvlPipeObject"`, `contains $u3 "ERASE"` and `contains $p3 "STORMWATER PIT"`.
   5. **Broken variant (exact change):** `variants\R19_broken.case.txt`, same group as R19 (FIXTURE, SLOT fresh, SETUP SETUP-R47), with `ORDER 46` (after R19's U has restored P8).
      1. **Steps:** the same as R19's.
      2. **Assert:** `history has "2 pipes now have ends that are Not connected yet"`. It must FAIL.

10. **R20: CDEDIT keeps the selection (daily card D17; plan UX-STD-06).** Verdict: **NEEDS BROKEN VARIANT.** After that, ready for D17 whole.
    1. **Conditions:**
       1. **Nothing seen:** met.
       2. **Two passes:** met (run3A, run4A).
       3. **Red:** none.
       4. **Card:** met.
    2. **The checks are exact:**
       1. **After Edit Pipe Save:** the selection is exactly "1 object(s) 10A98D".
       2. **After the "Edit 2 Pipes" editor:** it is exactly 2 objects, both handles named (10A98D, 1091A0).
       3. **At the end:** no CE window is left.
    3. **Small tightening (optional):**
       1. **The first window:** `$win1` is captured but never checked. Add `not-contains $win1 "Edit Pipe"`.
       2. **Which button closed the editor:** the evidence is cut at 260 characters, so it is not known. The first try, "Cancel without saving", was not on the list, and a later "Cancel" or "Close" worked. Use `ui-press "Edit 2 Pipes" "Cancel" -> $c2` with `window-closed $c2` instead of `close-windows`, so the record shows the route D17 step 3 asks for.
    4. **Broken variant (exact change):** `variants\R20_broken.case.txt`, same group (FIXTURE DRV1_B1, SLOT fresh, no setup), with `ORDER 36`. This is a true red for "CE lost the selection", not just a flipped word.
       1. **Steps:** `pick-first "10A98D"`, then `type "CDEDIT{NL}Y" -Force -ExpectWindow "Edit Pipe" -TimeoutSec 120`, then `ui-press "Edit Pipe" "Edit pipe, Save"`, then `wait`, then `v3 deselect`, then `v3 pick-read -> $s`.
       2. **Assert:** `contains $s "pick-first set: 1 object(s) 10A98D"`. It must FAIL.
    5. **Note:** pressing "Edit pipe, Save" relies on a v3 allow-list exception the builder added on 24 Oct. I did not review that tool change (see "What I did NOT check").
    6. **Observation:** CDEDIT logged "completed" after Edit 2 Pipes was closed by Cancel. See "Three things", item 3.3.

## For the runner owner (not case faults, listed so they are not lost)

1. **ACCEPTED-READY must ignore a builder-filled review line.** It printed ACCEPTED-READY for all ten on the strength of "builder-filled: Opus review still needed". The runner should treat any REVIEWED_AGAINST line beginning "builder-filled" as empty.
2. **Scope of the history and log checks for shared-setup cases.** `Invoke-OneCase` copies the setup's starting log offsets into every later case that names the same setup. So `history has`, `history count` and `log civil count` read from the setup start, across earlier cases. The README says "read by offset from where the case began". Either fix the code (start at the case, but keep the setup's own lines for the first case), or change the README and tell case writers to order variants after the cases they copy.
3. **The close-windows evidence is cut at 260 characters,** which hides which button closed a window. Keep the full log in the JSON.
4. **Recording this review in the cases.** Each of R11 to R20 now has a `<case>.review.txt` beside it, holding the card and bug IDs compared, my verdict and the case SHA-256 I reviewed. I did not touch the REVIEWED_AGAINST lines, as instructed.
   1. **Copying into the case file:** if the owner copies a line in, the case's SHA-256 changes, and runs 3 and 4 stop counting. Two fresh sessions are then needed (about 27 minutes for all ten; about 7 minutes for R15's session alone, which also holds R13, R14, R18 and R19).
   2. **The better way:** let the runner read the `.review.txt` sidecar when its CASE_SHA256_REVIEWED equals the case file's hash. Then R15 counts now, with no re-run.
5. **`case_selftest_offline.ps1` now fails its "ten real cases exist" check** (20 exist), as the builder reported. Fix the count at the next pack review.

## What I did NOT check

1. **I ran nothing.** No AutoCAD, no runner, no self-test. Every result above is read from the run reports and the ledger.
2. **The builder's tool changes are not reviewed:**
   1. `case_runner.ps1`: the bare settings name.
   2. `case_runner_lib.ps1`: `msgbox-answer`, and HARD TIMEOUT counted as BLOCKED.
   3. `acad_driver_v3.ps1` and its allow-list: the "Edit pipe, Save" exception and the re-set pin.

   Someone who owns the driver should read them. The "Save" exception touches the never-press rule.
3. **Code is not checked against the installed build.** I did not check by `git merge-base` which Civil commits are inside 3.0.72 for these behaviours. No case here is a bug case, so it does not change a verdict.
4. **The tool incident is not re-checked.** I did not re-check the run 1 session D incident (the AutoCAD left running, `acad_pid 0`) beyond the builder's account. The report carries an ALARM.
5. **Runs 3 and 4 are not compared value by value.** I compared them in full only for R11's invert-text set (identical). For the others I relied on the same exact-text checks passing in both.
6. **The CDTWL engineering figures (150 mm, the 18.70 level, the volumes) are not checked.** They are Tim's to judge. Nor is the BUG-777 default level.
7. **Where the New Pipe window gets 225 from is not known.** I only read Tim's settings file, read-only.
8. **R01 to R10 are not re-reviewed.** They are covered by `RUNNER_CASE_REVIEW_2026-10-24.md`.

**Summary.** I checked R11 to R20 against cards C37 to C41, D04, D10, D14, D17, D27 and BUG-856. All ten passed twice on 3.0.72 with today's hashes. Only R15 (Recover Inverts totals) is Claude-accepted-ready. R16 and R20 need a broken variant. R11, R12, R14 and R18 need stronger checks; the exact lines are given. R13, R17 and R19 cover half their card. No daily tool (D-number) is ready yet; D17 is closest. No bug can be marked FIXED from these cases. The runner shows a builder-filled review as ready, and lets shared-setup cases read earlier cases' lines.
