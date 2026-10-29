# Independent review of the staged case edits before they go live (Thu 29 Oct 2026)

Written Thu 29 Oct 2026, about 16:26 to 16:45 Melbourne (clock read with `date`), by the Team Opus job CE_ACAD / robot / review / 27. No AutoCAD started, no runner run, no lock, no settings guard. No live case, review slip, ledger, DESK_LOG, ACCEPTANCE_LEDGER or BUG_CARPARK touched. One staged copy edited (C33m), with a backup.

## ANSWER FIRST

### FOR TIM

1. **Answer: the staged edits are sound. One small gap is fixed, and none of this needs anything from you.**
   - 17 of the 18 files do exactly what the reviews asked, and nothing was weakened.
   - The only checks that changed meaning are the four floor-waste ones, and they now follow your "no" ruling.
2. **The fix I made, in drawing terms:** take the test where you COPY a pit with layer 25TEXT locked.
   - The main test now checks CE says "no cover text". The "switch-off" copy of that test (the one that must fail) did not have that check, so nobody could prove the new check can ever go red.
   - I added the same one line to the switch-off copy. Codex's second review asked for exactly this.
3. **The numbers the robot will expect are right.**
   - The test drawing's pit labels are P1 to P7, P9, P10, C1 and X1, so the first copy takes the gap P8.
   - The next copy takes P11 and the one after that P12. In both of this morning's runs the COPY read P8 and the SCALE Copy read P12, with the ROTATE Copy in between. So P11 is the only number the ROTATE Copy can sensibly get.
4. **Floor waste on an inspection opening:** the four checks now expect CE's refusal with nothing placed. The wording matches what CE printed at each opening, for example "IO2 is already at this point, and a new source cannot sit on top of it."
5. **Mistakes:** none of mine cost anything. Two small slips in the staging report are corrected for the robot below the line.
6. **What you need to do:** nothing. The robot applies these after 5:30 pm and runs each one twice.

---

## Detail (for the desk and tester_run78)

### How I checked

1. **Read first:** `C:\TimOS\RULES.md`; the staged report `ROBOT_FIXUPS_STAGED_29OCT.md` (both parts); Opus B8 in full; Opus B7 item 2 (N24); Codex `cx_cr24` (N24 part) and `cx_cr26` (R32, R33m, R34sn parts); BUG-460, 665, 672, 1222 and 1223 in `BUG_CARPARK.md`; Tim's ruling item 4 in `decisions\2026-10-29_TIM_ANSWERS.md`; the tester job `desk_jobs\tester_run78_apply_staged_and_run.txt`.
2. **Runner code read (not edited):** `case_runner.ps1`. This covers `Resolve-CaseAcceptance` (lines 266 to 284), the ledger row's `from_check` (line 406), `Get-PackFiles` and the `validate` branch. I also read `case_runner_lib.ps1` (the `matches` check is .NET `[regex]::Match` with no options, and `ConvertTo-CaseText`).
3. **Hashes:** every staged file, its `_orig` copy and the live file were hashed with SHA-256.
   - All 17 live files still equal `_orig` (re-checked at 16:36). `variants\R34so_off_broken.case.txt` is not live yet.
   - Every staged "after" hash equals the one in the staged report, except the two named below.
4. **Diffs:** each staged file was diffed against `_orig`, header and body. I diffed the STEPS and ASSERT sections separately, so a changed check cannot hide among the header wording. The R36e family files were also diffed against each other.
5. **Run records read (3.0.85):** c1a1, c1a2, c1b1 and c1b2 (the IO sentence for each point); c1a4 and c1b4 (COPY P8, SCALE Copy P12); c1k1 (C34), c1k2 (C33m) and c1k4 (C36e) for the switch-off controls; n3d4 (N24's label reads).
6. **Source (read only, `git grep` at `09126560`):** `SourcePickPipeRecordRule.cs:54` builds "<tag> is already at this point, and a new source cannot sit on top of it. Move clear of <tag> and pick again." `CloneCleanupMessages.cs:170` builds "copied pit(s) got their own number but no " plus the missing words.

### Gate facts that decide whether a red counts (read from the code)

1. **A twin's red counts only if:**
   - its ledger row says `variant_of` = the main case id;
   - its result is FAIL;
   - `from_check` is true, which means the first failure is not a step (text that does not start with "step ").
   - Its own hash and build do not matter.
2. **A main case's own earlier FAIL rows count only with the same case hash.** So every edited bug case needs a twin red under `VARIANT_OF`.
3. **The four C-controls had no `VARIANT_OF` line,** so their c1k1 to c1k4 FAIL rows (variant_of empty) do not count. Each needs one fresh run after the apply.

### Verdict per file

1. **cases\N24 (7F2B7FA6380D): SOUND.**
   - The three added lines are word for word B7 item 2.5. EXPECTED now adds X1 and the every-label sentence.
   - I re-tested the three patterns in .NET against n3d4's recorded label reads (`C:\ce-fx\stagedreview29\n24_regex_test.ps1`). The every-label line matches an unchanged read and refuses both the after-Yes read and a read with one label changed. The X1 line matches the after-Yes read and refuses a changed X1.
   - N24 has an empty `BUG` line, so no red is required by the gate. N24_BROKEN does not carry the three new lines (see desk item 4).
2. **cases\R32 (4D0E972B30A0): SOUND.**
   - Only `BUG` + `EXPECT-FAIL BUG-1222` became `BUG BUG-1222`, as B8 item 9.5 asked.
   - Red: R32_BROKEN (VARIANT_OF R32) already has check-level FAIL rows on 3.0.85. C32 adds the second-Save red after one run.
   - Its EXPECTED still ends "On Civil 3.0.75 that last check is expected to FAIL". That is wording only and harmless (desk item 5).
3. **cases\R32b (376E1339DCDE): SOUND.** It got the same retag. Red: R32b_BROKEN (VARIANT_OF R32b).
4. **cases\R34 (501FA33440EC): SOUND.**
   - The six step lines and three `matches` lines are word for word B8 item 1.4, placed where B8 said. The retag and PLAN_ITEM follow item 1.5.
   - The derived numbers are right for this drawing; see "The numbers" below.
   - Red: C34 (VARIANT_OF R34, both switches off) fails checks 5, 6, 8, 10 and 11 as count checks in c1k1. Its steps hold no label read, so it cannot stop at a step. R34_NOCOPY_BROKEN (VARIANT_OF R34) is a second red.
5. **cases\R34s (0E3BFB86FD9F): SOUND.**
   - It gains the ROTATE label read and the P11 and P12 lines from B8 item 2.4. `EXPECT-FAIL` is deleted and EXPECTED is shortened.
   - No old check was removed; the `P(?!3)` SCALE line stays. Red: R34s_OFF_BROKEN (item 10).
6. **cases\R34sn (1D4831A6928F): text SOUND, but DO NOT APPLY.** I agree it is rightly skipped.
   - It is wording only: the same 9 checks and 30 steps.
   - Applying it would change the hash. That would withdraw the B8 slip for live F8A2788F0DEC and cost two fresh runs and a new review, for no new check.
   - The tester job already records this desk decision.
7. **cases\R34so (EE23DE4B4C4A): SOUND.**
   - It gains the label read and the `P8` line from B8 item 3.3, and `EXPECT-FAIL` is deleted.
   - P8 is right because the ROTATE Copy is the first copy on a fresh drawing (`SLOT fresh`).
8. **cases\R36e (DDA649CC47A0): SOUND.**
   - "Floor waste placed." became the IO1 sentence, and `count = 1` became `count = 0` twice. The three not-contains lines are kept, as B8 item 11.5 and Tim's ruling ask.
   - The `BUG` line is now `BUG BUG-1223` and `EXPECT-FAIL` is gone.
9. **variants\R33m (EC896953A560): SOUND.**
   - It gains the one line from B8 item 8.5. `EXPECT-FAIL` and the "Expected to FAIL" sentence are deleted.
   - The 3.0.85 line "[CE] 1 copied pit(s) got their own number but no cover text: layer 25TEXT is locked ..." contains the new text. The switch-off line "... no label or cover text ..." does not, so the check can go red.
10. **variants\R34s_OFF_BROKEN (80C7395910B5): SOUND.**
    - The one SETTING line is added, as B8 item 4.3 asked. The stray second VARIANT_OF line is gone; only `VARIANT_OF R34s` remains.
    - Its steps read only the COPY label, which still exists with both switches off. So it reaches the checks and fails `count $ro_label = 1` (check 5) as a check, just as C34 fails it.
    - It cannot show the new P11 and P12 lines going red (desk item 4).
11. **variants\R34so_OFF_BROKEN (NEW, 457D71F074C4): SOUND.**
    - It has both SETTING lines, `EXPECT-FAIL BROKEN-VARIANT` and `VARIANT_OF R34so`, as B8 item 3.5 asked.
    - First failing check: check 1, the "numbered as new" line. That is a check, not a step.
    - The P8 check reads every plan label with `v3 ent-find` and wants a `PIT_LABEL=P8` somewhere. This is a deliberate change from the main case's label read: copying the main case's read would stop at a step and not count. I agree with that choice. With both switches off nothing is numbered, and the fixture has no P8, so it fails.
12. **variants\R36e_p2, R36e_p3 and R36e_p4 (323BEA524023, 730C33D23AA9, 04C4E78F8A34): text SOUND; gate gap, no line fix.**
    - Each differs from R36e only in the typed point, the IO number, the title, the comment and ORDER 98.
    - The IO numbers match the recorded runs in both sessions: 51777.389,-30233.425 gives IO2; 55879.087,-30233.481 gives IO3; 80936.111,-30304.267 gives IO4.
    - **Gate gap:** before the edit their `BUG` line was empty. Now it is `BUG BUG-1223`, so they are bug cases and need a red. Their old FAIL rows carry the old hash, and no file has `VARIANT_OF R36e_p2` (or p3, p4). After two passes each they will read PASS-UNREVIEWED with "has no recorded FAIL", not ACCEPTED-READY.
    - This does not block R36e itself (C36e is its red). The fix is a new file, not a line, so it is desk item 3.
13. **controls\C32 (51EB04625BB9): SOUND.** It adds one line, `VARIANT_OF R32`, and CRLF is kept. c1k3 shows it fails checks 13 and 14 as checks (arrow rotation 0).
14. **controls\C33m: NEEDS FIX, now FIXED in the staged copy.**
    - **Exact line added** (after `not-contains $cp1 "no label"`): `contains $cp1 "got their own number but no cover text"`.
    - **Why:** Codex `cx_cr26` (R33m, staged control gap) found that staged C33m got `VARIANT_OF R33m` but not R33m's new positive check, so no red ever exercises that check.
    - With the switch off, CE prints "no label or cover text", which does not contain the new words. So C33m will now fail check 11 and the new check, both as checks.
    - Details and hashes are in the next section.
15. **controls\C34 (9167D25FDB10): SOUND.**
    - It adds one line, `VARIANT_OF R34`. It already carries both switch-off SETTING lines.
    - It is a partial pair: it proves the line, label and cover checks go red, not the new P8, P11 and P12 lines (desk item 4).
16. **controls\C36e (FC5C7C905431): SOUND.**
    - It has `VARIANT_OF R36e`, and its checks mirror the rewritten R36e under the switch-off SETTING. Going beyond the one-line ask is right: the control now differs from R36e only in the switch.
    - c1k4 shows that with the switch off CE prints the false "A nearby pipe's Civil record changed while you picked." and places nothing.
    - So the mirrored C36e will **fail checks 1 AND 2**: the IO1 sentence is missing and the false sentence is present. The first failure is check 1, which is still a check.
    - Checks 5 and 6 (nothing placed) pass under the switch off too, so the "nothing placed" lines have no red of their own. No CE setting places a floor waste there.

### The C33m edit (the only file I changed)

1. **File:** `C:\ce-fx\c75fixups_staged\controls\C33m_copy_message_switch_off.case.txt`.
2. **Backup:** `...\controls\C33m_copy_message_switch_off.case.txt.pre_review`, SHA-256 `9DF1A38740AC1BB7C7BE501C7D1FD2093E154A35D6F83626A4C1A87467FE4E1A`.
   - The `.pre_review` name does not end in `.case.txt`, so `Get-PackFiles` and the apply list ignore it.
3. **Before:** `9DF1A38740AC1BB7C7BE501C7D1FD2093E154A35D6F83626A4C1A87467FE4E1A`. **After:** `5D112376D563DC56F36F684B22BBB76F62E14FD8EE0B8D1AFE1AB7C5289AF72B`.
4. **Line endings and encoding:** CRLF kept (59 CR for 59 lines), with no byte-order mark, as in the original. Script: `C:\ce-fx\stagedreview29\fix_c33m.ps1`.
5. **Unified diff:**

```diff
--- C33m_copy_message_switch_off.case.txt.pre_review
+++ C33m_copy_message_switch_off.case.txt
@@ -53,6 +53,7 @@
   not-contains $win_end "Creative Engineering"
   copy-unchanged $copy0
   not-contains $cp1 "no label"
+  contains $cp1 "got their own number but no cover text"
   record $cp1 "FULL COPY with 25TEXT locked"
   record $cpl "FULL the copied pit's label"
   record $u1 "FULL what U echoed"
```

### The numbers (P8, P11, P12; IO1 to IO4)

1. **Fixture label read, not taken on trust:** n3c4's `ent-find` (3.0.85, untouched copy of DRV1_B1) lists 11 blocks on STORMWATER PIT LABEL.
   - They are C1 1090F6, X1 10933E, P1 1096B3, P2 10981A, P3 109E08, P6 10A18D, P7 10A56D, P5 10A68C, P4 10A7AB, P10 119F9A and P9 11A09A.
   - The P sequence has exactly one gap, P8. X1 and C1 are other prefixes.
   - The staged notes say "P1 to P7, P9, P10 and C1" and leave out X1. That is harmless for the P numbers.
2. **The order is observed, not only derived:**
   - c1a4 and c1b4 (R34s on 3.0.85: COPY, then ROTATE Copy, then SCALE Copy) read COPY = P8 and SCALE Copy = P12.
   - P9 and P10 are taken, so the ROTATE Copy in between took P11, if it took a number at all. That is what R34 and R34s now assert.
   - R34so's single ROTATE Copy on a fresh drawing therefore takes P8.
3. **IO1 to IO4:** each typed point gave the same IO number in the a and b sessions (c1a1/c1b1 for IO1, c1a2/c1b2 for IO2 to IO4). The sentence in each case is a substring of the line CE printed.

### Offline validate (after the C33m edit)

1. **Read first:** `validate` calls `Get-PackFiles`, `Read-CaseFile` and `Test-CaseFile` only.
   - `acad_driver_v3.ps1` is loaded with `-Library`, which "defines the functions and runs nothing" (its line 10; `Invoke-V3Main` is skipped at line 1154).
   - It takes no lock and writes no ledger.
2. **Result:**
   - `cases`: 8 file(s) checked, 0 invalid.
   - `variants`: 6 file(s) checked, 0 invalid.
   - `controls`: 4 file(s) checked, 0 invalid. C33m now shows 23 steps and 15 checks (it had 14).
3. **acad.exe count during the job: 1.** That is Tim's own AutoCAD; I started none.

### For the desk and tester_run78 (no decision needed from Tim)

1. **C33m's "after" hash is now `5D112376D563`,** not the `9DF1A38740AC` in the staged report. Compare the live file after copying with the staged file's own hash. A note saying so is in `C:\ce-fx\c75fixups_staged\_REVIEW_29OCT_READ_FIRST.txt`.
2. **C36e's "after" hash is `FC5C7C905431`** (the R36e section), not `895539A2D84B` (the first section's list). Apply the two lists as one, as the report says. C36e will fail checks 1 and 2, not only check 2: both are expected.
3. **R36e_p2, p3 and p4 cannot reach ACCEPTED-READY on the gate** (verdict item 12). Two choices:
   - **Recommended:** three switch-off controls, one per opening. Each would be C36e with the point, the IO number, its CASE id and `VARIANT_OF R36e_p2` (or p3, p4) changed, run once each.
   - **Otherwise:** accept that these three stay "PASS, no red" as supporting evidence for R36e.
   - I did not create them; new files were outside this job.
4. **New checks with no red of their own (the gate does not require one; recommended for the review that follows):**
   - **R34:** P8, P11 and P12.
   - **R34s:** P11 and P12.
   - **N24:** the three map lines. Adding the same three lines to N24_BROKEN, which has no U, would make the U line go red.
   - A flipped twin for R34 that expects P3 for the ROTATE Copy would be the cheapest red for the number lines.
5. **Stale wording, no check affected:** R32's and R32b's EXPECTED still describe the 3.0.75 failure. Fix them only at their next real edit, because every edit costs two runs.

### What I did NOT verify (RULES 5.9)

1. **Nothing was run in AutoCAD.** Validate proves the files parse, nothing about results.
2. **P11 has still never been read in a run.** It is supported by P8 and P12 on either side, not seen.
3. **The N24 tests** used the recorded `FULL` text of lab0 and lab1. lab0 was used as a stand-in for the after-No and after-U reads, which are not recorded. The patterns were not passed through the runner's own `matches` call. I used the same .NET `[regex]::Match`.
4. **R34so_OFF_BROKEN's `ent-find` read** has never run in this case. The same call passes in N24.
5. **That an empty handle stops `ent-read` as a step** was not re-read by me in the driver. I relied on the staged report's line reference, and avoided depending on it.
6. **Whether a newer Civil build (3.0.86) installs before the runs:** the tester job handles that. Nothing here depends on the build except the IO sentence and the C-75 switches.
7. **Live files can still change before the apply.** All 17 matched `_orig` at 16:36.

## Summary (under 100 words)

I reviewed all 18 staged case files against B8, B7, Codex cr24/cr26, the five bugs and Tim's floor-waste ruling. Seventeen are sound. They add exactly the asked lines and weaken nothing beyond the ruled R36e change. The P8/P11/P12 numbers fit the fixture's labels and the recorded P8/P12 runs, and IO1 to IO4 match both sessions. I fixed one gap, in the staged copy only: C33m now carries R33m's "no cover text" check. Its hash is now 5D112376D563, with a backup kept. R34sn is rightly skipped. R36e_p2 to p4 can never get a gate red without new controls. Validate: 18 files, 0 invalid.
