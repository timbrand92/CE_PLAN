# Robot weak-check repair: N17v87 (drafted Mon 2 Nov 2026, Melbourne; Sonnet, read-only drafting)

## FOR TIM

1. **Verdict: REPAIRABLE with the robot alone, for PART of the card.** No Codex look is needed. The part that cannot be proven by a robot (that your own Undo switches are OFF) is dropped from the claim instead of faked.
2. **What the case claims:** with the Undo switches as shipped, you place a pit and a pipe, press U and the command line says CD and the pipe goes (the pit stays). Press U again: it says PIT and the pit goes. Move pit P3 up 2 m, press U: it says MOVE and P3 drops back.
3. **Why it was weak:** the line "no Undid: sentence is printed" could never go red, because only CD's own [Undo] route prints that sentence and this case never uses it. The "broken twin" only shows the MOVE name check can fail. Nothing shows the CD check, the PIT check or the "pipe is gone" check can fail.
4. **The repair:** add a before-U check that the pipe and the pit were really there, judge the exact U line after PIT and MOVE as well as CD, and add a second twin that slips a harmless POINT in before U, so the CD check and the "pipe is gone" check must go red.
5. **Not proven even after the repair:** that the switches are OFF in your file (the case never reads them), REDO after U, and the switch-on wording (that is N07 and N18).
6. **Nothing was built, run or installed for this.** The CE 02 fix of 2 Nov 00:49 (separator-tolerant echo check) has not been run yet either. Both need one robot run in a free window, then an independent review.

---

## 1. What the case claims (plain English)

1. **Case:** `N17v87`, file `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_v387_30oct\N17_undo_names_tims_switches_cd_pit_movev87.case.txt`. Plan item UX-UNDO-01, profile A (daily card D19, step 1), on Civil 3.0.88.
2. **Claim:** after the shared setup (one pit at 150000,-80000 and one pipe to 170000,-80000), the first U names CD and removes the pipe only; the second U names PIT and leaves nothing new; MOVE of pit P3 (handle 109D56) by 0,2000 reads Y -23569.8 and one U names MOVE and returns it to Y -25569.8.
3. **Whole or part:** PART. It does not cover profile B (switches on, N07 and N18), REDO (BUG-861 family) or the check that your own switches are off.
4. **Source read (not run):** `origin/claude/rel-20261102a` (3fbb9da5, Civil 3.0.88): `CdCommand.CommandLineSpec.cs` lines 23 and 24 (the "Undid:" sentence is only used when `sayWhatWasUndone` is true, and it is false by default), `REGRESSION_LOG.md` line 15270 onward (UX-UNDO-01: "Undid:" appears after CD's [Undo] only; both switches OFF by default).

## 2. Why the check is weak (exact lines)

Read: the case and its review file, its twin `N17_brokenv87.case.txt` (and the old `variants\N17_broken.case.txt`), `SETUP-P8v`, N07 for the switch-on case, README_CASES.md, the ledger rows for N17, N17v87, N17_BROKEN and N17_BROKENv87, the report `RUN-20261102-0031-C3.0.88-peR1`, and the Opus review report `C78_REVIEW_A_REPORT.md` (named in the review file).

1. **Weak line A (original): `history absent "Undid:"`.** It cannot fail. Only CD's [Undo] prompt keyword prints "Undid:", and that keyword only exists with the switch-on prompt style. The case never uses CD's [Undo], so the line passes on a broken build too. The Opus review of 1 Nov already says this. CE 02 replaced it on 1 Nov (backup `.pre_weakfix`).
2. **Weak line B (CE 02 fix, 1 Nov): the exact-echo check on the CD line only.** It failed in `peR1` (2 Nov 00:31) on its own text, not on a CE fault. Checks 1 to 11 passed and check 12 read "Command: | Command: U | CD" and still did not match `^\s*Command: \| Command: U \| CD\s*$`. I did not find out why (likely a line break or a different space in the raw text; the shown line is joined for the report). CE 02 then loosened it at 00:49 (`.pre_sepfix` is the backup) to accept spaces, bars and line breaks between the words. **That text has not been run yet.** The ledger's last N17v87 row is still the peR1 FAIL.
3. **Weak line C: the exact-echo check covers only the U after CD.** The U after PIT and the U after MOVE are still read with the loose whole-word match, so an extra line there would pass.
4. **Weak line D: `count $pipes_u1 = 0` and `count $after_u2 = 0` have no "was there before" check.** If the setup placed no pipe (or no pit), the counts would still read 0 after U. Only two `history has` lines stand in for that, and a log line does not prove the object stayed in the drawing.
5. **Weak line E (the twin): `matches $u_mv "(^|\| )MOVE\s*(\||$)"` in `N17_brokenv87`.** The twin COPIES P3 and then demands both COPY and MOVE in one U line, so it fails on any build. It has no setup, so it never touches the CD line, the PIT line or the pipe count. Ledger: `N17_BROKENv87` FAIL, `tW1` 31 Oct, from a check, on the old twin text (sha 07E66958...). It proves one check out of about twelve can go red.
6. **Not weak, said plainly:** the P3 move and return reads (Y -23569.8 then Y -25569.8) are real drawing readings and passed in 12 recorded runs from 3.0.83 to 3.0.88 (before the 2 Nov text changes).
7. **Cannot be made strong by any robot case:** "Tim's own switches are OFF". With the switches off or on, the U echo is the same line; the only difference is the CD [Undo] sentence, and with the switch off that keyword does not exist, so the robot has nothing to press. The honest fix is to drop the claim from EXPECTED (done below). I did not read your settings file (not allowed in this job).

## 3. REPAIRED case (replace the case file; README format)

Changes from the file on disk: the `history absent "Undid:"` wording is removed from EXPECTED (it was never checked); two selects and four counts added before the first U; the exact-echo regex applied to all three U lines; the title now says what is checked.

```
# N17v87 REPAIR 2 (drafted by Sonnet 2 Nov 2026 for CE 02; NOT RUN). Builds on CE 02's 1 Nov exact-echo fix and 00:49 separator fix (both still unrun). Adds a before-U check so the pipe and pit counts cannot pass on an empty drawing, and the exact echo on the PIT and MOVE lines.
# DERIVED: the before-U counts (one pipe, one pit on layer STORMWATER PIT among the new objects) come from the after-U counts of the passing runs plus SETUP-P8v placing one pipe and one pit; not seen as a reading. If the first run reads a different number, change it to the number the report shows and have it reviewed.
# DERIVED: the exact echo lines 'Command: | Command: U | PIT' and '... | U | MOVE' are recorded in peR1 (check 14 and 15) and in N07 (n27a15, n27b4). The separators are accepted in any mix of space, bar, tab and line break because peR1 showed the plain-text version did not match the CD line.
# Daily card D19 (UX-UNDO-01), profile A, PART: the U echoes and what each U takes back. The switch-off claim is NOT checked (see the repair file, 2.7).
CASE N17v87
TITLE With the Undo switches as shipped, U after CD echoes CD and takes the pipe, U after PIT echoes PIT and takes the pit, and U after MOVE of pit P3 echoes MOVE and puts it back
PLAN_ITEM UX-UNDO-01 profile A, the U echoes only (daily card D19 step 1; PART)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8v
ORDER 170
TIMEOUT 1200
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After SETUP-P8v (pit P8 and one pipe, both present), one U prints exactly 'Command: | Command: U | CD' and the pipe is gone while the pit stays; a second U prints exactly 'Command: | Command: U | PIT' and nothing new is left; MOVE of pit P3 by 0,2000 says '1 found' and moves it to Y -23569.8; one U prints exactly 'Command: | Command: U | MOVE' and puts it back at Y -25569.8.
WHY_NOT_UNIT_TEST AutoCAD's own undo echo and what one U takes back are only visible in a running session on the real drawing.
NOT_AUTOMATED That the Undo switches are off in Tim's settings file (the U echo is the same either way; only CD's own [Undo] sentence differs and that keyword does not exist with the switch off).
NOT_AUTOMATED REDO after each U is not driven (BUG-861 family; R08).
NOT_AUTOMATED The switch-on half of the card is N07 plus N18.
STEPS
  select $new_all object=CeCvlPipeObject -> $pipes_before
  select $new_all object=AcDbBlockReference "layer=STORMWATER PIT" -> $pits_before
  type "U" -> $u_cd
  wait
  ms-new $n0 -> $after_u1
  select $after_u1 object=CeCvlPipeObject -> $pipes_u1
  select $after_u1 object=AcDbBlockReference "layer=STORMWATER PIT" -> $pits_u1
  type "U" -> $u_pit
  wait
  ms-new $n0 -> $after_u2
  pick-first "109D56"
  type "_.MOVE{NL}0,0{NL}0,2000" -Force -> $mv
  wait
  ent-read 109D56 -> $p3_moved
  type "U" -> $u_mv
  wait
  ent-read 109D56 -> $p3_back
ASSERT
  history has "[CE] Pipe placed."
  history has "Pit placed successfully."
  count $pipes_before = 1
  count $pits_before = 1
  matches $u_cd "(^|\| )CD\s*(\||$)"
  matches $u_cd "^\s*Command:[ \t|\r\n]*Command: U[ \t|\r\n]*CD\s*$"
  count $pipes_u1 = 0
  count $pits_u1 = 1
  matches $u_pit "(^|\| )PIT\s*(\||$)"
  matches $u_pit "^\s*Command:[ \t|\r\n]*Command: U[ \t|\r\n]*PIT\s*$"
  count $after_u2 = 0
  contains $mv "1 found"
  matches $p3_moved "insertion\W+53777\.7\d*,-23569\.8"
  matches $u_mv "(^|\| )MOVE\s*(\||$)"
  matches $u_mv "^\s*Command:[ \t|\r\n]*Command: U[ \t|\r\n]*MOVE\s*$"
  matches $p3_back "insertion\W+53777\.7\d*,-25569\.8"
  record $u_cd "FULL what U printed after the CD run"
  record $u_pit "FULL what U printed after the PIT run"
  record $u_mv "FULL what U printed after MOVE"
```

## 4. REPAIRED twins (both must FAIL, each on its own check)

**Twin A: replace `N17_brokenv87.case.txt`.** Changes: the MOVE check is now the exact-echo form, so the twin proves the check the real case relies on; the COPY precondition stays (it must pass). It still has no setup, so it proves the MOVE echo check only. Twin B covers the CD side.

```
# N17_BROKENv87 REPAIR 2 (drafted by Sonnet 2 Nov 2026 for CE 02; NOT RUN). Same COPY-for-MOVE fault as before; the MOVE check is now the exact-echo regex of N17v87 so the twin proves the check the real case uses.
# DERIVED: U after COPY prints 'Command: | Command: U | COPY' (the same shape as the CD, PIT and MOVE lines in peR1; the COPY whole-word line itself passed in tW1 on 31 Oct).
CASE N17_BROKENv87
TITLE BROKEN VARIANT of N17v87: pit P3 is copied, not moved, so U echoes COPY and the exact check for MOVE fails (must FAIL)
PLAN_ITEM red-before-green proof for N17v87, the MOVE echo check (UX-UNDO-01 profile A, daily card D19)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 171
TIMEOUT 600
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N17v87
REVIEWED_AGAINST
EXPECTED This variant is wrong on purpose: the last command before U is COPY, so U echoes COPY and the exact check 'U echoes MOVE' fails. The COPY check must pass, so the only red is the MOVE name.
WHY_NOT_UNIT_TEST It exists only to prove N17v87's MOVE echo check can go red.
STEPS
  pick-first "109D56"
  type "_.COPY{NL}0,0{NL}0,-5000{NL}{NL}" -Force -> $cp
  wait
  sleep 4
  type "U" -> $u_mv
  wait
ASSERT
  matches $u_mv "^\s*Command:[ \t|\r\n]*Command: U[ \t|\r\n]*COPY\s*$"
  matches $u_mv "^\s*Command:[ \t|\r\n]*Command: U[ \t|\r\n]*MOVE\s*$"
```

**Twin B: new file `N17_broken_b_v87.case.txt` (cases\variants once validated).** Same setup as the real case. A harmless AutoCAD POINT is drawn after the pipe, so the first U takes back the POINT, not the pipe. The pipe stays, so the CD echo check and the "pipe is gone" check must both go red; the POINT precondition must pass.

```
# N17_BROKEN_Bv87 DRAFT (Sonnet 2 Nov 2026 for CE 02; NOT RUN). A true red for the CD side of N17v87: one extra POINT sits between the CD run and U, so U takes back the POINT, echoes POINT, and the pipe stays.
# DERIVED: U after POINT echoes the whole word POINT (the same shape as COPY in tW1). If AutoCAD names it differently, the first precondition goes red and the twin must be re-read, not trusted.
# DERIVED: the pipe count after U reads 1 (the pipe was not undone); from SETUP-P8v placing one pipe. A POINT left in the drawing is on the open copy only; CE never saves.
CASE N17_BROKEN_Bv87
TITLE BROKEN VARIANT of N17v87: a POINT is drawn after the pipe, so U echoes POINT and the pipe stays; the CD echo check and the pipe-is-gone check fail (must FAIL)
PLAN_ITEM red-before-green proof for N17v87, the CD echo and the pipe-removed checks (UX-UNDO-01 profile A, daily card D19)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8v
ORDER 172
TIMEOUT 1200
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N17v87
REVIEWED_AGAINST
EXPECTED This variant is wrong on purpose: the last command before U is POINT, so U echoes POINT, the pipe is still in the drawing and the pit is still there. The POINT check passes; the CD echo check and the 'pipe is gone' count fail.
WHY_NOT_UNIT_TEST It exists only to prove N17v87's CD echo check and pipe-removed check can go red.
STEPS
  type "_.POINT{NL}150000,-82000" -Force -> $pt
  wait
  type "U" -> $u_cd
  wait
  ms-new $n0 -> $after_u1
  select $after_u1 object=CeCvlPipeObject -> $pipes_u1
  select $after_u1 object=AcDbBlockReference "layer=STORMWATER PIT" -> $pits_u1
ASSERT
  matches $u_cd "(^|\| )POINT\s*(\||$)"
  count $pits_u1 = 1
  matches $u_cd "(^|\| )CD\s*(\||$)"
  count $pipes_u1 = 0
```

## 5. What was read, built, tested and NOT proven

1. **Read:** the files named in section 2, the source and REGRESSION_LOG lines in section 1.4, and the ledger. `git fetch` was run (read-only); the Civil/Manager line is `claude/rel-20261102a` at 3fbb9da5 (Civil 3.0.88). I did not read the Structural line (not relevant to this case).
2. **Built / tested:** nothing. No case file was changed, no run, no validate, no AutoCAD.
3. **NOT proven:** that the repaired text validates and passes; that the two POINT and select assumptions behave (the DERIVED marks); why peR1's CD-line regex failed (the raw text was not read, only the report's joined line); that Tim's own switches are off; REDO after U.
4. **One caution for the desk:** the review file's SHA (59049F80...) no longer matches the case on disk (CE 02 has already edited it twice), so the old CLAUDE-ACCEPTED-READY does not count. Any text from this file needs a new independent review, and both twins need to be run (the old twin text last ran on 31 Oct).
5. **Order of work:** validate, run N17v87 with both twins in one free window (after 5:30 pm), read the raw U text in the report, then ask for the independent review.
