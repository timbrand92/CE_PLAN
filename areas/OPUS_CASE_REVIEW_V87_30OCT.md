# Opus case review: the 3.0.87 level variants (v87), Fri 30 Oct 2026

Reviewer: Opus (read-only background review for CE 02, brief `C:\CE_PLAN\desk_jobs\REVIEW_BRIEF_V87.txt`).
Reviewed 19:10 to 19:25 Melbourne (PC clock). Build under test: Civil 3.0.87+f5dd72a0 (read from the run reports' DLL lines).
Run reports read: aW1 (17:13), aW2 (17:39), aW3 (18:02). Checked again at 19:20: no aW4 or bW pack exists yet.
Nothing was edited, run or built. No review slip was written (none qualifies; see item 1).

---

## ANSWER FIRST

1. **Qualify now: 0 of 59.** No v87 case has a pass b yet, and no v87 twin has run at all. So no `.review.txt` slip was written.

2. **Clean on paper, waiting for pass b and a twin red: 11.** R02v87, R03v87, R04v87, R14h_dstd_200v87, R14h_both_200v87, R14h_pipekey_200v87, R15v87, R17v87, R11v87, R19v87, R16v87.
   - Each passed once in pass a. Each run used the case text now on disk (hash matched).
   - Every check that depends on a level works out correctly for the new levels (shown per case below).
   - The three R14h cases also need R14v87 to pass. R14v87 is their red: the same steps at 150 mm print "(150 mm is wanted)". R14v87 was BLOCKED in aW2 by a session start fault.

3. **The twelfth passing case, R02bv87, has a false sentence.** Its checks are sound. But its EXPECTED line now says "a 0.1 m fall over 20 m is the default 1 IN 100". The fall is 0.2 m (18.100 to 17.900).
   - The script swapped the label words but not the fall figure.
   - My advice: fix that sentence before pass b, then run the case again in both passes. Fixing it changes the file's hash.

4. **WRONG: 1 case. CORRECT-ONLY-BY-ACCIDENT: 0.**
   - **R39v87, assertion line** `matches $lab_text "AT 1 IN 10[01]$"`.
   - The new levels give 10.099 m ÷ 0.200 m = 1 in 50.5, so CE's label will read "1 IN 50". The check expects 1 IN 100 or 101, so it fails on a correct build.
   - The EXPECTED line was not re-derived either. It still says "1 IN 101 (10.1 m long, 0.1 m fall)".
   - R39 has not run on 3.0.87 yet, so nothing has wrongly passed.

5. **A twin the copy script missed: N20_BROKENv87.** It still types a **20 m** pipe at 18.000 / 17.900 = **1 in 200**.
   - The script used N20's 2 m map (17.990 to 17.980) on the twin. But the twin draws the 20 m SETUP-P8 pipe on purpose.
   - On 3.0.87 this opens the Grade mismatch window, so the twin will BLOCK instead of giving its red.
   - Fix: change line 22 to `ui2-set "New Pipe" "C2.SecondInvert" "17.800"`.

6. **Correction to the brief's premise.** The window does not open for "any pipe flatter than 1 in 100". The installed code (CdCommand.Grade.cs lines 233 to 260 at f5dd72a0) works like this:
   - **When it can ask:** only when New Pipe is on "Set my own" grade. Typing the first level puts it there, with the table's 1 in 100.
   - **The rule:** it asks when the typed grade is MORE than 10 % away from that figure, in either direction.
   - **What that means:** 1 in 101 to 1 in 110 never asks. By the code alone, anything steeper than about 1 in 91 would ask too.
   - **What the runs show:** no steeper pipe has asked in any run so far. On 3.0.86 these all went through with no question:
     - R01's second pipe, about 1 in 46;
     - R32's second pipe, 1 in 40;
     - R39, 1 in 101 against the 1 in 200 table.
   - Why steeper pipes have not asked is not established.
   - Either way the risk is a BLOCKED run, never a false PASS: a modal window stops the next robot call.

7. **Steep pipes to watch in their first run** (all steeper than 1 in 91):
   - R39v87, 1 in 50.5.
   - R39bv87, about 1 in 52 and 1 in 55.
   - R39_SECOND_BROKENv87 and R39b_BROKENv87, about 1 in 50 to 52.
   - R32v87, second pipe 0.50 / 0.00 over 20 m = 1 in 40. This one is unchanged from the original.
   - R01v87, second pipe placed by mouse. It was about 4.6 m on 3.0.86 (label 1 IN 46), so about 1 in 23 now.
   - R02_BROKENv87, 18 m at 0.2 m = 1 in 90.0. That is 9.9999999999997 % off, inside the line only by rounding.

8. **Simplest fix for R39: run the ORIGINAL R39 and its twins on 3.0.87.**
   - The original levels (18.000 / 17.900 over 10.1 m = 1 in 101) are only 1 % from 1 in 100, so they never ask.
   - Its label check "1 IN 10[01]" stays true.
   - For R39b, 1 in 100 levels would be:
     - arc line (10.385 m between corners): 18.000 / 17.896;
     - closed line (11.000 m): 18.000 / 17.890.
   - R39b's original closed-line pipe was 1 in 110, exactly on the 10 % line (9.99999999999984 %).

9. **GM1 is a fair record, but the title over-claims.**
   - The case types 20 m at 18.000 / 17.900 = 1 in 200, which is 100 % off. The twin at exactly 1 in 100 fails its "window is open" check, which is a real check.
   - **Title problem:** the title still says "draws nothing until it is answered", and nothing checks that. The object count was rightly removed after the BUSY block.
   - **Where it runs:** it should be the last case in its AutoCAD session (see GM1 below).
   - **Not run yet:** its text changed after the aW1 run (hash 91820C24FF8905F8 then, 4ECCB55EBC3B9C6B now), so it has no run on the current text.

10. **Brief count check.**
    - The brief says 29 mains and 31 twins plus the GM1 pair (62 files).
    - The folder holds 59: 27 v87 mains, 30 v87 twins, GM1_flatter_than_1in100 and GM1_broken.
    - Nothing appears to be missing against the list in item (e) of the brief.

---

## What I checked, and how

1. **Diffs.** I compared every v87 file with its original as plain text, all 57 copies.
   - **Changes found:** the new first comment line, the CASE line, the SETUP line, the VARIANT_OF line, and level literals in commands, regexes, EXPECTED, NOT_AUTOMATED and comment text. "1 IN 200" became "1 IN 100" in R32b and its twin. Nothing else changed in any step or assertion.
   - **One extra change not on the allowed list:** every v87 file and all three new setups end with one added empty line. It is harmless. Line endings are still CRLF, and there is no byte-order mark.
2. **Setups.** SETUP-P8v, SETUP-P8x2v and SETUP-R47v differ from their originals only in the comment, the SETUP line and the levels. P8v and R47v pipe: 20 m at 18.000 / 17.800 = 1 in 100. P8x2v pipe 1: 20 m at 18.000 / 17.800. Pipe 2: 17.700 / 17.500, placed by mouse clicks, length not fixed.
3. **Every typed pipe's grade** was worked out from its typed points and levels (script in my scratchpad, read-only). Results are in each case paragraph.
4. **Run evidence.** I read the aW1, aW2 and aW3 reports and json. Each passing case's file_sha256 in the json equals the file on disk now.
5. **Code.** I read the Grade mismatch rule from the installed commit f5dd72a0 (`git show`, read only): CdCommand.Grade.cs `TryDetectCustomGradeMismatch`, CdCommand.cs line 586, CdViewModel.Inverts.cs lines 770 to 830, and UserSettings.cs `MinGradeByDiameter` (225 = 1 in 100).

---

## The 12 variants with a passing run

1. **R02v87** (6147D7F067E8964F). PASS in aW1-s1, one start.
   - **(a) Diff:** allowed only, plus the trailing empty line.
   - **(b) Level checks:** the Pit Schedule P8 row must hold `18\.0+`. That is the outlet invert, the pipe's FIRST level, unchanged at 18.000, and the run shows "18.000". CORRECT-BY-DERIVATION.
   - **Geometry:** the box x 150225 and y -80112.5 come from the pit wall and the 225 pipe (half of 225 = 112.5), not from the levels. The run read them exactly.
   - **(c) Same proof?** Yes: a pipe started on a pit joins it.
   - **(d) Twin:** R02_BROKENv87 still breaks only the start point (2 m off). Not yet run. Watch item 7: its 18 m route at 0.2 m sits on the 10 % line.

2. **R02bv87** (B740485DA906F3DA). PASS in aW1-s1, one start.
   - **(a) Diff:** allowed literals only. But the EXPECTED text is now false: "a 0.1 m fall over 20 m is the default 1 IN 100". The fall is 0.2 m.
   - **(b) Level checks:** the flow line, the pipe count and the box y (-80112.5) do not depend on levels. CORRECT-BY-DERIVATION.
     - The new label read "225 DIA. UPVC PIPE AT 1 IN 100": 20 m ÷ 0.2 m = 100.
     - CE's command-line lines match 3.0.86 word for word, apart from the levels.
   - **(c) Same proof?** Yes. The "default grade, no question" point still holds: 20 m at 0.2 m is exactly 1 in 100, the new table figure.
   - **A drafting change nobody checks:** the incoming pipe now reaches P8 at 17.900, 100 mm BELOW the outgoing pipe's 18.000. In the original both were 18.000. CE printed nothing new about it.
     - Using 18.200 / 18.000 would keep the original shape, with inlet equal to outlet.
   - **(d) Twin:** R02b_BROKENv87 still breaks only the end point (2 m short). It types 18.090 / 17.900 over 18 m = 1 in 94.7, which is safe. Not yet run.

3. **R03v87** (7C2A9D2228228673). PASS in aW1-s1, one start.
   - **(a) Diff:** allowed.
   - **(b) Level checks:**
     - `^IL 17\.800$` and `^IL 18\.000$` are exact texts, matching the setup's typed levels: CORRECT-BY-DERIVATION.
     - The distances (462.5 mm and 270.8 mm) equal the accepted run's figures. The texts are the same length, so their placement does not change.
   - **(c) Same proof?** Yes.
   - **(d) Twin:** R03_BROKENv87 still hides both texts. Its regex was updated in step with the main case. Not yet run.

4. **R04v87** (E487F1C2AFDCE5F1). PASS in aW1-s1, one start.
   - **(a) Diff:** allowed.
   - **(b) Level checks:** none; the checks are about the file on disk. The relink and recover lines printed 12/50 and 26/24 as before.
   - **(c) Same proof?** Yes.
   - **(d) Twin:** R04_SAVE_BROKENv87 is the same as before. Not yet run.

5. **R14h_dstd_200v87** (C79FE4941A1DCBF2). PASS in aW2-s2, one start.
   - **(a) Diff:** allowed.
   - **(b) Level checks:** CORRECT-BY-DERIVATION.
     - The freeboard lines come from the detention system above C1: "8 pits, 7 pipes", from the run.
     - The new P8 and its pipe are not part of that system, so the changed level cannot reach them.
     - C1: lid 18.74 (the run's own option 3) minus 18.70 = 40 mm. P1 and P7 are fixture lids at 110 mm.
   - **(c) Same proof?** Yes.
   - **(d) Twin:** it has no twin of its own. Its red is R14v87 printing "(150 mm is wanted)" on the same steps. Not yet passed: BLOCKED in aW2.

6. **R14h_both_200v87** (43418DED1871D215). PASS in aW2-s3, one start. Same as item 5.

7. **R14h_pipekey_200v87** (B82EE0B727521582). PASS in aW2-s4, one start. Same as item 5.

8. **R15v87** (4E4D8CF8189ED1FF). PASS in aW3-s1, one start.
   - **(a) Diff:** allowed.
   - **(b) Level checks:** CORRECT-BY-DERIVATION. The totals (50 / 26 / 24 / 5) count pipes with both levels stored. The P8 pipe still has both levels, so the totals do not change. The run shows the same lines.
   - **(c) Same proof?** Yes.
   - **(d) Twin:** R15_BROKENv87 still expects 27 (a flipped number). Not yet run.

9. **R17v87** (FB91F0AE7B61208B). PASS in aW3-s1, one start.
   - **(a) Diff:** allowed.
   - **(b) Level checks:** none; the counts are 1034 and exactly 1 pipe. The contrast pipe is 20 m at 0.2 m = 1 in 100, which is why it no longer asks.
   - **(c) Same proof?** Yes.
   - **(d) Twin:** R17_BROKENv87 is unchanged in substance. Not yet run.

10. **R11v87** (3039E9BCBA5A9083). PASS in aW3-s1, one start.
    - **(a) Diff:** allowed.
    - **(b) Level checks:** CORRECT-BY-DERIVATION.
      - The pinned invert-text string now ends "IL 18.000 | IL 17.800 | IL 17.60 | IL 17.50". 18.000 / 17.800 are the setup's own texts.
      - The cascade (from P3, 4 pipes and 3 pits, min grade 1:16) is in the fixture area, nowhere near P8. The run matched the whole string exactly before the edit, after the cascade, after U and after REDO.
    - **(c) Same proof?** Yes.
    - **(d) Twin:** R11_BROKENv87 still adds only the CIRCLE between U and REDO. Not yet run.

11. **R19v87** (34EC7FD6ACA12CAD). PASS in aW3-s1, one start.
    - **(a) Diff:** allowed.
    - **(b) Level checks:** none; the counts are 1039 and 1040. The CDCHECK totals (218 / 189 / 184) count links, not levels, and the run shows the same line as the accepted run.
    - **(c) Same proof?** Yes.
    - **(d) Twins:** R19_BROKENv87 (flipped wording) and R19_NOU_BROKENv87 (no U) each still break one thing. Not yet run.

12. **R16v87** (8082D57813DCCCD1). PASS in aW3-s2, one start.
    - **(a) Diff:** allowed.
    - **(b) Level checks:** CORRECT-BY-DERIVATION.
      - "start invert text would move 275 mm" is about IL 18.000, which is unchanged.
      - The clash comes from the moved SPOT LEVEL block and the plan position, not from the level values.
      - The label words "1 IN 100" and "1 IN 200" are the same length. The run printed 275 mm, as accepted.
    - **(c) Same proof?** Yes.
    - **(d) Twins:** R16_BROKENv87 (P9 flip) and R16_OFF_BROKENv87 (switch off) still break one thing each. Not yet run.

---

## GM1_flatter_than_1in100 and GM1_broken (new cases)

1. **Fair record?** Yes, for what a colleague now sees.
   - A 20 m pipe typed 18.000 / 17.900 (1 in 200) is 100 % off the table's 1 in 100, so the Grade mismatch window opens. This matches the code and the many 3.0.87 BLOCKED runs of the 1 in 200 originals (aF1 to aF4).
   - The twin types 18.000 / 17.800, exactly 1 in 100. No window opens, so `contains $w1 "Grade mismatch"` fails on a real check.
2. **Title over-claims.** "draws nothing until it is answered" is not checked by anything. Reword the title, or add a NOT_AUTOMATED line. The EXPECTED line already says this honestly.
3. **Pressing no button and ending with the window open: acceptable for a RECORD case**, on two conditions.
   - **Run it last in its AutoCAD session**, or alone. Today it is ORDER 26, in the middle of the R02 to R04 orders. Any robot call stays refused while the window is open. That is exactly how aW1 blocked.
   - **Know what the closing Esc does.** In aW1 the runner's tidy-up Esc closed it and the next cases ran on a re-opened copy.
     - By the code, any answer other than "Use" goes on to DRAW the pipe.
     - CE may then remember 18.000 / 17.900 as the last pipe's levels. The guard does not restore that remembered-values file.
     - Running GM1 last in the session avoids this.
4. **Not yet run on the current text.** Its REVIEWED_AGAINST is builder-filled. Whether the question SHOULD appear is still open with CE 04 and Tim. So this records the current behaviour; it is not an acceptance of it.

---

## Variants without a passing run (paper only: a and b, and what to watch)

1. **R13v87** (6C5B0CFA46EC459F).
   - **Diff:** allowed.
   - **Level checks:** none. The relink counts 12 / 50 already showed with the P8v setup in R04v87. The schedule rows are compared before and after, not against fixed levels.
   - **Watch:** the session start fault seen in aW2.
   - **Twins:** R13_BROKENv87 (11 / 49 flip) and R13_ROWS_BROKENv87 (P8 erased) are fine on paper.

2. **R14v87** (92F00F6BF77D7A37).
   - **Diff:** allowed.
   - **Level checks:** the 40 / 110 / 110 mm lines at 150 mm are CORRECT-BY-DERIVATION, as for R14h. P5 at exactly 150 mm is correctly not an "Only" line.
   - **Watch:** a clean session start.
   - **Twins:** R14_BROKENv87 (41 mm flip), R14_DSTD_BROKENv87 and R14_PIPEKEY_BROKENv87 (100 mm, real switches) are fine.

3. **R32v87** (5EEFD2BFDA73E57B).
   - **Diff:** allowed.
   - **Level checks:** CORRECT-BY-DERIVATION. The IL texts "IL 17.800 | IL 18.000" after reversing, and the left/right positions (x below or above 160000), follow the typed levels.
   - **Watch:** the second pipe is 0.50 / 0.00 over 20 m = 1 in 40 (unchanged), 60 % off 1 in 100. It did not ask on 3.0.86 when it was 80 % off 1 in 200.
   - **Twin:** R32_BROKENv87 (no reversal) is fine.

4. **R32bv87** (2622870E59412E57).
   - **Diff:** allowed. "1 IN 200" became "1 IN 100".
   - **Level checks:** the label check "150 DIA. UPVC PIPE AT 1 IN 100" twice is CORRECT-BY-DERIVATION: 20 m ÷ 0.2 m = 100.
   - **Note:** the 150 table grade is also 100 now, so the grade words can no longer tell the measured grade from the table grade. The case's point is the 150 DIA. words, which still separate the twin.
   - **Twin:** R32b_BROKENv87 (pipe B not edited, keeps 225) is fine.

5. **R39v87** (D7DFF3497B47C088). **WRONG.** See answer item 4. Run the original R39 instead, or change the regex to `AT 1 IN 5[01]$` and the EXPECTED to "1 IN 50 (10.1 m, 0.2 m fall)".
   - **Watch:** a Grade mismatch window (answer item 6).
   - **Twins:**
     - R39_BROKENv87 never reaches New Pipe, so the levels do not matter.
     - R39_SECOND_BROKENv87 places the same 1 in 50 pipe. It is fine if no window opens.

6. **R39bv87** (5CE2ACC01118D466).
   - **Diff:** allowed.
   - **Level checks:** none.
   - **Watch:** both pipes are now steep (about 1 in 52 and 1 in 55). See answer item 8 for exact 1 in 100 levels.
   - **Twin:** R39b_BROKENv87 (plain line) is fine on its checks. It is also steep (about 1 in 52).

7. **N06v87** (B90209B70F9784F9).
   - **Diff:** allowed.
   - **Level checks:** none (layers only).
   - **Twin:** N06_BROKENv87 (CLAYER set to 0) is fine.

8. **N17v87** (59049F807A3601AF).
   - **Diff:** allowed.
   - **Level checks:** none (U echoes and the P3 move only).
   - **Twin:** N17_BROKENv87 (COPY in place of MOVE) is fine.

9. **N18v87** (B2DD57F462F4FB30).
   - **Diff:** allowed.
   - **Level checks:** 10 m at 0.1 m = 1 in 100. `^IL (18\.000|17\.900)$` with count 2 is CORRECT-BY-DERIVATION.
   - **(c)** It still proves the same thing: the typed grade equals the table grade, so no question.
   - **Twin:** N18_BROKENv87 (no U) is fine.

10. **N19v87** (B8ED36CF78CA6FB4).
    - **Diff:** allowed.
    - **Grades:** near pipe 9.95 m = 1 in 99.5, far pipe 10.00 m = 1 in 100. Both are within 1 %.
    - **Level checks:** the derived "50 mm short", x 150225 and x 150375 are plan geometry, not levels, so they are unchanged.
    - **(c)** It still proves the catch rule.
    - **Twin:** N19_BROKENv87 (end 150 mm out) is fine.

11. **N20v87** (E565BB361CD42844).
    - **Diff:** allowed.
    - **Grade:** 2 m at 0.02 m = 1 in 100. The label is the same length, so it still needs a leader.
    - **Level checks:** no level is asserted.
    - **Twin: N20_BROKENv87 is NOT converted** (answer item 5). It will BLOCK, not fail on its check.

12. **N23v87** (498F5396E52DD266).
    - **Diff:** allowed.
    - **Grades:** 9.91 m = 1 in 99.1, and 10.00 m.
    - **Level checks:** the derived figures are plan geometry, unchanged.
    - **Twin:** N23_BROKENv87 (end 110 mm out) is fine.

13. **N27v87** (E45BF044EF46A839).
    - **Diff:** allowed.
    - **Level checks:** it moves the IL 18.000 text, which is unchanged. The 275 mm clash is the R16 clash, unchanged.
    - **Twin:** N27_BROKENv87 (switch off) is fine.

14. **N28v87** (8EBB8DFAC9228BF4).
    - **Diff:** allowed.
    - **Grade:** 20 m at 1 in 100.
    - **Level checks:** CLAYER checks only.
    - **Twin:** N28_BROKENv87 is fine.

15. **R01v87** (D9B7122FCC80F493).
    - **Diff:** allowed.
    - **Level checks:** the IL regexes (18.000 or 17.800, and 17.700 or 17.500, two each) and all the counts are CORRECT-BY-DERIVATION.
    - **Watch:** the mouse-placed second pipe at about 1 in 23 (answer item 7).
    - **Twin:** R01_BROKENv87 (one pit, one pipe) is fine.

---

## What was NOT done

1. No AutoCAD run, no case or setting edit, and no slip. Nothing here is Tim-accepted or Claude-accepted.
2. I did not prove why steeper pipes have not asked in runs. The code reading says they could. Only a run will show what 3.0.87 does with R39v87, R39bv87, R32v87's second pipe and R01v87's second pipe.
3. The remembered-values file is not restored between cases. So the New Pipe window's starting grade mode can depend on the previous case. I did not trace how far that reaches.
