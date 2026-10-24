# Runner case review, batch 2: runner fixes, R11 to R20 re-checked, new R19b and R21 to R30 (Opus independent review, Sat 24 Oct 2026)

Written Sat 24 Oct 2026, about 18:05 to 18:35 Melbourne (PC clock), by an independent Opus reviewer. Read-only: nothing run in AutoCAD, no runner, case, settings or ledger file edited, no bug status changed, `BUG_CARPARK.md` and `DESK_LOG.md` not touched. The only files written are this one and three `.review.txt` files (listed at the end). Rule applied: the RULES.md acceptance amendment of 24 Oct ("Claude-accepted") and `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`. Standard followed: `RUNNER_CASE_REVIEW_2026-10-24.md` and `RUNNER_CASE_REVIEW_R11_R20_2026-10-24.md`.

**What I read:** the builder's report `release-v3-colleagues-RUNNER_PHASE3_BATCH2_REPORT.md` (all of it); the 21 case files R11 to R30 and R19b, `SETUP-R47`, and every broken variant named in the report (R11, R12, R13, R14, R14_dstd, R16_off, R17, R18, R20, R21, R23, R26); `case_runner.ps1` (the two new functions and the acceptance function), the text checks in `case_runner_lib.ps1`, `Close-V3OpenWindows` in `acad_driver_v3_session.ps1`; `runner-reports\ledger.json` (184 rows) joined row by row to today's case hashes, which I took myself with Get-FileHash; the run reports p3b2isoLEGACY, p3b2isoLEGACY2, p3b2isoFIXED, iso, p3b2fixA2, p3b2fixS2, p3b2fixS2b, f1 to f13, g1, n1 to n5, r15a, r15b, h1 to h4, t1, w1, w2; cards C37 to C41 (`TEST_CASES_DRAFT_22OCT.md`), D04, D10, D14, D17, D21, D23, D26, D27, D28 (`DAILY_TOOLS_TEST_CASES_2026-10-23.md`); triage groups V1, W9, X1, MG1, Q1, T1, C1, L2, S1 to S3, D1 (`BUG_REGISTER_TRIAGE_2026-10-24.md`); BUG-360, BUG-372, BUG-384, BUG-389, BUG-461, BUG-809, BUG-814 in `BUG_CARPARK.md`; the gap plan's 40 daily checks (item 3.7); and the product version of the installed Civil DLL (read today: **3.0.74+a15b414c** in all three runtime folders).

## ANSWER FIRST

1. **Counts (one main verdict per case; 20 cases changed or new in this batch; R15 was not touched and stays ready):**
   1. **CLAUDE-ACCEPTED-READY: 3.** R16 (Tidy labels names the pipe, C37), R17 (Esc at CD's third point, D04), R20 (CDEDIT keeps the selection, D17).
   2. **NEEDS BROKEN VARIANT: 1.** R19b.
   3. **NEEDS STRONGER ASSERTION: 3.** R12, R23, R28.
   4. **PARTIAL (part only): 6.** R11, R13, R14, R19, R21, R26.
   5. **NEEDS CODEX LOOK: 5.** R18 (label reads left to right), R25, R27, R29, R30 (window cases).
   6. **FAIL = real fault: 1.** R22 (CDCHECK prints raw handles and CE-CIV internal ids).
   7. **Not a valid test yet: 1.** R24 (no drawing authored in metres exists; its FAIL proves nothing either way).
2. **The two runner fixes: both work as described.** I read the code and the proof runs.
   1. **Review gate:** works. Two gaps the desk should know (item 1 of "The runner fixes"). The biggest: the runner only demands a red run for a case with a `BUG` header. So for every other case, the reviewer's file is the only guard against a case with no red.
   2. **Fresh drawing per case:** works for the drawing, the undo list and the command line. The old shared mode let a probe pass on an earlier case's leftovers (run p3b2isoLEGACY2); the fixed runner made the same probe text fail both checks (runs p3b2isoFIXED and iso).
   3. **Limit:** it is a fresh drawing, not a fresh AutoCAD. CE's memory survives the reopen. R27 shows it: CDDESIGN said "2 of 6 things" in a freshly started AutoCAD and "1 of 6" after a reopen of the same file.
3. **Daily tools (D-numbers) that may now be counted Claude-accepted: 2.**
   1. **D04** (Esc at CD's third point cancels the pipe), from R17, on **Civil 3.0.73**.
   2. **D17** (CDEDIT leaves your selection as it was), from R20, on **Civil 3.0.74**.
   3. **Not yet:** D10 needs a Codex look; D14 and D27 are part only; D21, D23, D26 and D28 are not exercised by any case in this batch (the cases that name them test something else; see R21, R25 and R26).
4. **Gap-plan checks that are not D-numbers (the 40 of item 3.7):**
   1. **Ready now:** "Tidy labels names the pipe" (R16, Civil 3.0.73). It works with Tidy labels switched on; the switch is OFF in Tim's file, so it is OFF for Max on 9 Nov.
   2. **Already ready from the last review:** "Recover Inverts" (R15). The ledger shows its two new passes (r15a, r15b) on Civil 3.0.73 with the same file text, and the runner printed ACCEPTED-READY. Its review file still matches.
   3. **Not ready:** "Edit Pipe cascade with U and REDO" (R11, part only), "quick MOVE" (R12), "CDTWL freeboard" (R14, see item 5.1), "CDSYNC keeps the schedule" (R13 does not test it).
   4. **Recount effect:** the 40-check count may rise by **3** (D04, D17, Tidy labels names the pipe), on top of Recover Inverts.
5. **Bugs that may be written "FIXED (Claude-accepted, build, date)": none.**
   1. **BUG-384 (R23):** one line short. The two-pipe refusal is checked only for the words "locked" and "nothing was changed". The bug's expected sentence also says CE will not unlock the layer. Add the lines in item 14 of "The cases", run it twice on 3.0.74, then it can be written.
   2. **BUG-856:** already "FIXED (Codex-accepted, Civil 3.0.67)". R16 is its regression guard on 3.0.73. Nothing to change in the entry.
6. **Things the desk should know first:**
   1. **Run h2 is labelled Civil 3.0.73 but ran on 3.0.74.** The runner read the DLL versions at 17:18:37. The 3.0.74 files landed at 17:19:58 (the live bundle's `Contents` folder creation time). AutoCAD for that run started at 17:20:18. Proof in the drawing words: in run f2 (true 3.0.73) CDTWL printed "- -810 mm below the lowest lid" and "pipe pipe 10B03B"; in run h2 it printed "810 mm ABOVE the lowest lid (water would come out)" and "P6 -> P5". So R13's and R14's second "3.0.73" pass is really a 3.0.74 pass. The ledger rows of run h2 (R13, R14 at 17:30) carry the wrong build. The desk owns the ledger: mark them 3.0.74 or set them aside.
   2. **The installed build is now Civil 3.0.74.** R16 and R17 are Claude-accepted on 3.0.73, and R15 too. To stay current on the live build, each needs two passes on 3.0.74.
   3. **The Pit Schedule can now be opened, read and closed by the runner** (R25, through the v3 Close button, on 3.0.73 and 3.0.74). R13's and R19b's notes still say it cannot. This opens the way to C42 (CDSYNC keeps the schedule), D14's schedule half and R11's stored levels. Each needs a short probe first: can the IL and cover cells be read as text?
   4. **R22's fault belongs mainly to BUG-814 item 3 and BUG-360,** not BUG-372 alone. On 3.0.73, CDCHECK printed "Pipe 450 (handle 109359)", which is a handle on screen (BUG-814 item 3 and the BUG-372 family). It also printed "CE-CIV-PIPE-20707BD7-..." and "CE-CIV-PIT-1773A76E-...", internal ids, which is BUG-360's 14 Oct extension. R22 has not been run on 3.0.74.
   5. **Seen in passing, not judged by any case:**
      1. **The CDTIDYLABELS prompt prints its options twice:** "Tidy labels on [All pipes/Select pipes] <All> [All/Select] <All>:" (runs f5, f7 on 3.0.73). It is the same kind of fault as BUG-388 (FDELETE). A text search of BUG_CARPARK.md for the prompt words found no entry.
      2. **CDCHECK logs "Command outcome: CDCHECK cancelled"** after printing its whole report, because the case ends it with Esc at the action prompt (BUG-862 family, builder's note, both runs).
      3. **R30's Drawing Standards Manager shows every layer twice** in its Draw Order list (the builder's look at the picture). Codex to judge; no bug entry exists.
      4. **CDDESIGN's count of things set changes after a reopen** (2 of 6, then 1 of 6, plus "[CE] The job: already set."). Possible lost or changed state on reopen; the builder's steps to file it are in the report, item 8 of "The new cases".

## How I applied the four conditions

1. **Nothing seen on screen.** Met for the drawing values, command-line lines, log lines, counts, selections and window titles. Not met for the window pictures (R25, R27, R29, R30) or the label's reading direction (R18). Those need a Codex look.
2. **Two passes in separate AutoCAD sessions on one build.** I joined every ledger row to today's file hash myself. Every PASS the report lists is in the ledger on the current text, with two exceptions:
   1. **Run h2 is on the wrong build** (item 6.1 above). R13 and R14 therefore have one pass on 3.0.73 under the runner's own build key (f2), plus one earlier pass on Civil 3.0.73 with Structural 1.0.122 (p3b2fixS1), plus one on 3.0.74 (h2).
   2. **R19's FAIL and FLAKY at 12:41 (run p3b2fixS2)** are on the same Civil 3.0.73 and the same case text, under Structural 1.0.122. The failure reads "no command-line line contains 'The pit was erased' (4 lines read)". That is the log-file move the builder found and fixed in the runner, so I do not count it against R19. But the runner hid it only because Structural changed. A Structural reinstall should not wipe a Civil case's FAIL history (see "For the runner owner", item 3).
3. **Red before green.** Every broken variant in the report FAILED in the ledger on its current text, and for the intended reason (I read each first failure). The true reds (a real switch, not a flipped word) are: R11_broken (a CIRCLE between U and REDO: "Nothing to redo"), R14_dstd_broken and R14_pipekey_broken (freeboard 100 in Settings), R16_off_broken (Tidy labels off), R20_broken (selection cleared: "pick-first set: 0 object(s)"), R23_broken (layer not locked: Edit Pipe opens). The rest are flipped expectations, which the rule accepts.
4. **Compared with the card or bug, and full coverage.** Judged line by line below.

## The cases

1. **R11: Edit Pipe cascade with U and REDO (C40; gap-plan check "Edit Pipe cascade with U and REDO").** Verdict: **PARTIAL.** It counts for the invert texts only.
   1. **Asks met:** IL 17.60 and IL 17.50 are pinned, and the whole after-cascade string is pinned. The truer red was built: R11_broken FAILED with "Nothing to redo" (run f8).
   2. **Two passes:** f1 and f6 on 3.0.73.
   3. **Still not covered by C40:**
      1. **The STUB warning:** C40 assertion 1 says the "missing-level STUB -> X1" warning is kept. It never prints in R11's runs, because R11 runs without the card's P8 setup. **Line to add:** `SETUP SETUP-R47` in the header (C40's own fixture). Run one probe to read the STUB line's exact words, then add `history has "<that line>"`. The pinned string and "Updated 4 pipes and 3 pits" may change with the setup; re-pin them from the probe.
      2. **The Recalculate box wording ("17.30 -> 17.50", C40 step 3):** msgbox-answer records only the title ("CE - Recalculate downstream inverts?"). Reading the box text needs a tool change.
      3. **Stored levels (C40 assertion 2, "database values"):** not read. The Pit Schedule route of R25 may allow it after U and after REDO; probe whether P3's IL cells read as text.
2. **R12: quick MOVE (C41; gap-plan check "quick MOVE").** Verdict: **NEEDS STRONGER ASSERTION.**
   1. **Asks met:** the window check is now exact (`equals $win1 $win0`, `equals $win2 $win0`). Two invert texts are measured moving 1990 and 1988 mm with the pit.
   2. **Two passes:** f1 and h1 on 3.0.73 (h1 ended 17:18:36, before the 3.0.74 install). Red: R12_broken (flipped).
   3. **Gap: the after-U checks cannot fail.** `equals $ha2 $ha0` picks texts within 4000 mm of the old pit position. A text 2000 mm away (one that did NOT come back) is still inside that circle, and so is a text that never moved, for `$ha1`. Only the two `dist` checks prove anything, and nothing measures the texts after U. C41 assertion 3 asks that U puts every monitored position back. **Lines to add after the U block:**
      1. `select $a2 "handle=1101B8" -> $back_a`
      2. `dist $back_a "54327.72,-25217.56" -> $ret_a`
      3. `select $b2 "handle=116BB6" -> $back_b`
      4. `dist $back_b "53922.50,-25007.06" -> $ret_b`
      5. ASSERT `number $ret_a = 0 +- 0.5` and `number $ret_b = 0 +- 0.5`.
   4. **Still part only after that:** the pit's name label and cover text are not read (C41 step 1 names them).
3. **R13: CDSYNC warns, relinks, one U (D27 CDSYNC half; C42 reduced).** Verdict: **PARTIAL.**
   1. **Asks met:** the whole warning sentence is asserted, and R13_broken FAILED on the untouched-copy numbers (run f9).
   2. **Passes:** f2 (3.0.73) and h2, which is really 3.0.74 (item 6.1). There is one more 3.0.73 pass under Structural 1.0.122 (p3b2fixS1). It needs one more clean pass on one build.
   3. **Not covered:** D27's CDREBUILD half (never driven: probe its prompts first); C42 (the schedule figures). Its note "the Pit Schedule cannot be read or closed" is out of date (R25).
4. **R14: CDTWL freeboard (C39; gap-plan check "CDTWL freeboard").** Verdict: **PARTIAL.** The checks are now right for C39, but two things are open.
   1. **Asks met:** P1 and P7 are named; `CMDACTIVE` is 0. Three reds, two of them real Settings switches.
   2. **Open 1, passes:** one pass on 3.0.73 under the runner's key (f2); h2 was 3.0.74. Run it twice on 3.0.74. It already passed once there, and the BUG-1032 wording fix did not disturb its lines.
   3. **Open 2, does a higher freeboard take effect?** The variants show that lowering EITHER key (`pipe.detentionFreeboardMm` or `designStandards.detentionFreeboardMm`) to 100 changes CDTWL. If CE takes the smaller of the two, raising the freeboard on one key alone would be ignored. On a job, the office asks for 300 mm and CE still checks against 150. **Lines to add:** two variants, each a separate session, each expected to PASS:
      1. `SETTING CD_Settings.json designStandards.detentionFreeboardMm 200` with ASSERT `history has "Only 40 mm between the water and the lid of pit C1 (200 mm is wanted)."`
      2. The same with `pipe.detentionFreeboardMm 200`.

      If either still says 150 mm, that is a real fault: file it. Either way, two keys for one value is a Settings-first (R-00) question for the desk.
   4. **Engineering:** 150 mm is Tim's own Settings value. The case guards the wording, not the figure.
5. **R15: Recover Inverts (C38).** Not changed in this batch. **CLAUDE-ACCEPTED-READY** stands (the last review). Two passes r15a and r15b on 3.0.73 with the same text (SHA-256 6626D755...); its review file matches. Not counted in the 20 above.
6. **R16: Tidy labels names the pipe (C37; BUG-856 regression guard; gap-plan check "Tidy labels names the pipe").** Verdict: **CLAUDE-ACCEPTED-READY** for C37 as written, on Civil 3.0.73, with Tidy labels switched on.
   1. **Asks met:** Placed by hand 0, No clear spot found 1, the "pipe P3 -> P2 label" line, and 10EC5D read as a SPOT LEVEL block.
   2. **Passes:** f5 and f7 on 3.0.73 (no FAIL on that build).
   3. **Reds:** R16_broken (flipped pipe name, f5) and R16_off_broken (the true red: with Tidy labels off CE says "[CE] Tidy labels is switched off. Nothing in the drawing was changed.", f12).
   4. **Card:** all three C37 assertions are covered, and the exact P8 line guards BUG-856's old unnamed wording.
   5. **Cosmetic, at the next edit only (it changes the hash):** two NOT_AUTOMATED lines are stale. They say the SPOT LEVEL check and the no-clear-spot line are not asserted; both now are.
   6. **For Max:** the switch is OFF in Tim's file, so Max gets nothing from this on 9 Nov unless Tim switches it on.
7. **R17: Esc at CD's third point (D04; UX-PIPE-03).** Verdict: **CLAUDE-ACCEPTED-READY** for D04, on Civil 3.0.73.
   1. **Asks met exactly:** the Enter contrast now places the pipe (18.000, 17.900), `count $pipe_new = 1`, `count $left = 0`, TIMEOUT 900.
   2. **Passes:** f4 and f6 on 3.0.73, each the first case of its session. **Red:** R17_broken FAILED twice on 3.0.72; its text is unchanged (0E7EB344).
   3. **Card:** assertions 1 and 2 in full. Assertion 3, "exactly one pipe": yes. "With two vertices" is not read, because a pipe gives only its handle, object and layer. The route gives CD only two points, so a third vertex cannot arise.
   4. **Optional at the next edit:** a cheap proxy for "straight, 20 m": `select $after_c "text~ DIA\. .* AT 1 IN 200$" -> $lab_c` with `count $lab_c = 1`.
8. **R18: pipe label (D10).** Verdict: **NEEDS CODEX LOOK.**
   1. **Asks met:** the window is read before Start Pipe; the label must equal "225 DIA. UPVC PIPE AT 1 IN 200"; the label sits above the pipe line (y -79762.5 above -80000).
   2. **Passes:** S2b and g1 on 3.0.73. Red: R18_broken.
   3. **Still a look:** D10 assertion 2 (rotation 0, reads left to right) cannot be read by the runner.
   4. **Weak spot (optional):** `contains $np_win "225 mm"` matched the header text "Stormwater pipe · 225 mm · UPVC". The window record is cut at about 4 KB, so I cannot rule out that "225 mm" also appears in a size list. Tighter: `matches $np_win "Stormwater pipe . 225 mm . UPVC"` (a dot instead of the "·", which once came back garbled).
   5. **Still unknown:** why the window offers 225 when Tim's Settings say `pipe.diameter` 100. Do not change D10's card until someone finds out.
9. **R19: erase a pit with one pipe (D14).** Verdict: **PARTIAL.** It is the one-pipe branch, fully proven.
   1. **Asks met:** whole sentence; `number $e1 = 1039`.
   2. **Passes:** S2b and f3 on 3.0.73 (Structural 1.0.123). Red: R19_broken (f9).
   3. **For D14 whole:** D14 counts N from the Pit Schedule and checks all N pipes. With R19b, that is still not done. The schedule is now readable (item 6.3).
   4. **Cosmetic:** its first NOT_AUTOMATED line is stale (it says the sentence is asserted only in parts).
10. **R19b: erase pit P3 with six pipes (D14 plural branch).** Verdict: **NEEDS BROKEN VARIANT.**
    1. **Passes:** h3 and t1 on 3.0.74 (also fixA1, fixA2, h1 on 3.0.73). Both 3.0.74 runs printed exactly "...6 pipes now have ends that are Not connected yet. U restores everything."
    2. **Broken variant (exact):** `variants\R19b_broken.case.txt` with `VARIANT_OF R19b`, `EXPECT-FAIL BROKEN-VARIANT`, FIXTURE DRV1_B1, SLOT fresh, ORDER 47, the same steps. ASSERT `history has "7 pipes now have ends that are Not connected yet"`. It must FAIL.
    3. **Stronger, same edit:**
       1. **Pin the sentence:** `history has "[CE Civil] The pit was erased and the schedule is updated. 6 pipes now have ends that are Not connected yet. U restores everything."`
       2. **Count back after U:** `ms-count -> $e0` before the ERASE and `ms-count -> $e2` after U, then `equals $e2 $e0`.
    4. **Not covered:** that all six pipes survive (only 10A98D is read). Read P3's six pipe handles once, then `ent-read` each after the ERASE.
11. **R20: CDEDIT keeps the selection (D17; UX-STD-06).** Verdict: **CLAUDE-ACCEPTED-READY** for D17, on Civil 3.0.74.
    1. **Asks met:** `not-contains $win1 "Edit Pipe"`, plus the true red R20_broken. With the selection cleared it FAILED with "pick-first set: 0 object(s)" (run p3b2fixA2).
    2. **Passes:** h3 and t1 on 3.0.74, both clean.
    3. **Card, all three assertions:**
       1. **One pipe:** exactly "1 object(s) 10A98D".
       2. **Two pipes:** exactly 2 objects, 10A98D and 1091A0.
       3. **No CE window left:** the batch editor's title is "Creative Engineering | Edit 2 Pipes", so `not-contains $win3 "Creative Engineering"` does catch it.
    4. **How the editor closed:** I read `Close-V3OpenWindows`. It presses only "Cancel without saving", "Cancel" or "Close", so the editor was closed by Cancel or Close, as D17 step 3 asks. The record is cut before it names which one.
    5. **Not reviewed by me:** the v3 allow-list exception that lets the runner press "Edit pipe, Save" (batch 1 tool change). Pressing Save with nothing changed is the card's own step.
12. **R21: CDCHECK totals (triage C1; "daily neighbour D28").** Verdict: **PARTIAL**, and nothing to count.
    1. **Passes:** n1 and n4 on 3.0.73. Red: R21_broken (180 instead of 179).
    2. **What it proves:** All and Problems print the same totals line, and the drawing and file are unchanged.
    3. **Why it counts for nothing:** none of C1's bugs is proved (BUG-461's untrue "Nothing was changed", BUG-809 item 1's palette counts). D28 is CDCHECKDWG, a different command. Keep it as a regression baseline.
13. **R22: CDCHECK words (triage W9).** Verdict: **FAIL = real fault** (known, expected).
    1. **Both runs (n1, n4, 3.0.73):** "[CE] Pipe end 1. Pipe 450 (handle 109359): one end is not connected (the start)." and CE-CIV-PIPE- and CE-CIV-PIT- ids on the command line.
    2. **Owners:** BUG-814 item 3 and the BUG-372 family (handles), BUG-360's 14 Oct extension (internal ids). Retag `EXPECT-FAIL` at the next edit if the desk wants the owner exact.
    3. **The U+2192 check is the right form:** BUG-389's garble is the literal text `\U+2192`, which contains "U+2192". It was not seen, but that is not proof of a fix (the drawing may hold no old pipe names).
    4. **Next:** run on 3.0.74. When a fix lands, two passes on that build; its FAIL on 3.0.73 is its red.
14. **R23: locked pipe layer (triage L2; claims BUG-384).** Verdict: **NEEDS STRONGER ASSERTION.**
    1. **Passes:** n1 and n4 on 3.0.73. Red: R23_broken, a true red (no lock, so the editor opens).
    2. **Gap:** BUG-384's expected sentence says three things: the layer is locked, nothing was changed, and CE will not unlock it. For two pipes (the bug's own batch route) the case checks only "locked" and "Nothing was changed". The runner ignores capital letters, so that check matched the lower-case "nothing was changed". A batch line that dropped "CE will not unlock it" would still pass. **Lines to add:**
       1. `contains $ed2 "[CE] The batch editor was not opened and nothing was changed: layer STORMWATER PIPE is locked (pipe P4 -> P3; pipe AGI -> C1). CE will not unlock it: unlock it, or choose other pipes, then edit again."` (printed exactly so in n4)
       2. `not-contains $ed2 "label records do not match"` (the bug's old wording)
       3. In the header, `BUG BUG-384` as well as `PROVES_BUGS BUG-384`. The runner demands a red only for a `BUG` case.
    3. **Then:** two passes on 3.0.74. The desk may write BUG-384 "FIXED (Claude-accepted, Civil 3.0.74, <date>)", for the CDEDIT refusal route only. BUG-797 and BUG-254 stay unproved.
15. **R24: metre drawing (triage T1).** Verdict: **not a valid test yet.**
    1. **What happened:** the layer setting was switched to metres (`INSUNITS 6`) on a millimetre master after CE had loaded. The FAIL ("xscale 1.0", 1900 units wide) may be that artefact.
    2. **What it needs:** a real metre drawing. File no bug from it.
16. **R25: Pit Schedule read and close (claims S1 to S3, D21, D23).** Verdict: **NEEDS CODEX LOOK**, and nothing to count.
    1. **Passes:** w1 and w2 on 3.0.74. Red: R25_broken.
    2. **Why it counts for nothing:** D21 (number order P2 before P10) is not read; D23 (Excel export) is not pressed; no S1 to S3 bug is touched. Its plan item claims more than it tests.
    3. **Its real value:** it proves the runner can open, read and close the schedule (item 6.3).
17. **R26: CDSURVEY refusal (claims V1 and "D26 survey half").** Verdict: **PARTIAL**, and nothing to count.
    1. **Passes:** n1 and n4 on 3.0.73. Red: R26_broken.
    2. **Gap:** the refusal of the wrong pick is not asserted. **Line to add:** `contains $s1 "[CE] Please click directly on the survey XREF block."`
    3. **Card mismatch:** D26 is CDSL (spot level), not CDSURVEY. No V1 bug is proved.
18. **R27: CDDESIGN window (triage D1, start of route).** Verdict: **NEEDS CODEX LOOK**, and nothing to count. Passes w1 and w2 on 3.0.74. No design number is touched. The 2-versus-1 count is in item 6.5.4.
19. **R28: CDPROFILE start (triage Q1).** Verdict: **NEEDS STRONGER ASSERTION.**
    1. **Gap:** the title and EXPECTED say the pick of pit P3 is accepted. Both runs say "Select a CE pit block." (refused). The case proves only the first prompt.
    2. **Line to add:** probe a pick point inside the pit outline, clear of its texts (for example 300 mm off the insertion point). Then add `not-contains $p1 "Select a CE pit block."` and the next prompt's words.
    3. **Until then:** retitle it "CDPROFILE asks for a starting pit".
20. **R29: LandXML import window (triage X1, start of route).** Verdict: **NEEDS CODEX LOOK**, and nothing to count. Passes w1 and w2 on 3.0.74. The import itself is not driven.
21. **R30: CDMANAGER window (triage MG1).** Verdict: **NEEDS CODEX LOOK**, and nothing to count.
    1. **Plan item is wrong:** "gap plan Manager update window" is not one of the 40, and the update button is cut from 9 Nov.
    2. **EXPECTED overstated:** it says the window "names the installed versions"; nothing asserts that.
    3. **For the look:** the duplicate layer rows (item 6.5.3).

## The runner fixes

1. **Review gate (`Get-CaseIndependentReview`, `Resolve-CaseAcceptance`).** Verdict: **works as described.**
   1. **Seen working:** a builder-filled REVIEWED_AGAINST line no longer counts. The review file must sit beside the case, say `VERDICT CLAUDE-ACCEPTED-READY`, name this exact case hash and have a REVIEWER line. R11 was refused on its old review; R15 was accepted on its matching one. The name match `R19_*` does not pick up R19b's files.
   2. **Gaps (none blocks this review, all for the owner):**
      1. **Red only for `BUG` cases.** `PROVES_BUGS` is ignored (R23), and a plain case needs no red at all. The rule needs a red for every case.
      2. **Self-declared reviewer.** The REVIEWER line passes any text that does not start with "builder".
      3. **Hash check can be skipped.** It is skipped if the case's hash is empty, and ledger rows with no hash count as matching.
      4. **Stale reds count.** A variant's FAIL counts even if the variant's text has changed since.
2. **Fresh drawing per case (`Invoke-CaseFreshDrawing`).** Verdict: **works as described**, for the drawing, the undo list and the command line.
   1. **The proof:** the same two texts (ISO1_leaves 8B815CF9, ISO1_probe_broken C241BD56). Legacy mode: the probe PASSED on leftovers (p3b2isoLEGACY2). Fixed mode: it FAILED both checks, "1034 (expected 1035)" and "0 lines read" (p3b2isoFIXED, and iso on 3.0.74).
   2. **The log fix:** one v2 `history 1` call after the reopen picks up AutoCAD's new log file. Since then every later case reads its own lines (R19's 4-line failure is gone).
   3. **Limits:**
      1. **Same AutoCAD process:** CE's memory and session settings carry over (R27's count).
      2. **A missing "file unchanged" answer passes:** if v2 does not report `file_unchanged_by_reopen`, the check passes.
      3. **Longer cases:** every SETUP case now costs 3 to 6 minutes more.

## For the runner owner (not case faults, listed so they are not lost)

1. **Read the build again when AutoCAD starts.** The build stamp is taken at run start, before the lock wait. A desk install that held the lock swapped Civil 3.0.73 for 3.0.74 inside run h2. Re-read the three DLL versions after AutoCAD is up (and at the end). If they differ from the header, mark the session BLOCKED.
2. **Demand a red for every case.** Treat `PROVES_BUGS` like `BUG`, and require a FAIL of a variant whose current text hash is on record.
3. **Key Civil cases on the Civil build.** The build key joins Civil, Structural and Manager. A Structural-only reinstall resets a Civil case's FAIL history (R19, 12:41). Key Civil cases on Civil and Manager, Structural cases on Structural.
4. **Text checks ignore capital letters** (`contains`, `history has`). A wording case cannot catch "nothing" against "Nothing". Offer a case-exact form for wording bugs.
5. **The close-windows record is still cut short,** so which button closed a window is not on record (R20).
6. **Stale notes in case files** (cosmetic; fix at their next edit): R13 and R19b say the Pit Schedule cannot be closed; R16 and R19 understate what they assert.

## What I did NOT check

1. **I ran nothing.** No AutoCAD, no runner. Every result is read from the ledger and the run reports.
2. **I looked at no picture.** R25, R27, R29 and R30 are untouched by me.
3. **The batch 1 tool changes are not reviewed:** msgbox-answer, the "Edit pipe, Save" exception, HARD TIMEOUT as BLOCKED.
4. **Code against cases:** I did not check which commits are inside 3.0.73 or 3.0.74.
5. **Settings fingerprints:** I did not re-read each session's end-of-session values. I relied on the report for Tim's four settings files.
6. **Not re-reviewed:** R01 to R10, and R15's text (unchanged; I only confirmed its ledger rows).
7. **Not settled:** the CDTWL figures, and where the 225 pipe size comes from.

**Summary.** Both runner fixes work. Of the 20 changed or new cases, three are Claude-accepted-ready: R16 (Tidy labels names the pipe, 3.0.73), R17 (D04, 3.0.73) and R20 (D17, 3.0.74). R19b needs a broken variant. R12, R23 and R28 need stronger checks (exact lines given). R11, R13, R14, R19, R21 and R26 are part only. R18 and the four window cases need a Codex look. R22 fails for a real fault. R24 needs a real metre drawing. Run h2 was stamped 3.0.73 but ran on 3.0.74. No bug may be written FIXED yet; BUG-384 is one line away.
