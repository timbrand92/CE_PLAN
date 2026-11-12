# Status board check (lane trust-review, twelfth run)

**Checked:** Fri 13 Nov 2026, 06:22 PC clock. Read only. **Board checked:** `areas\trust-run\STATUS_BOARD.md` as rebuilt 05:56 by lane trust-struc-mgr-plan. **Against:** `areas\trust-run\trust-review.md` (the latest line per pull request), the review files in `reviews\`, the evidence files, `PENDING_TESTS.md`, and GitHub (`git fetch`, `gh pr list`) at 06:10. **Rows checked one by one:** 1 (2040), 2 (2041), 3 (2038), 4 (2043), 5 (2039), 8 (2053), 15 (2062), 17 (2064), 19 (2066), 21 (2073), 24 (2047), 26 (2068), plus FOR TIM items 1 and 2.

---

## FOR TIM

1. The board left out three trial changes that already existed when it was rebuilt (2071 and 2072, the bracing table sync, and 2074, CLEAN), so "34 trial changes" should have been 37. All three are reviewed now; 2075 (CDAGI's grade check in metre drawings) appeared at 06:12 and is not reviewed.
2. Several rows promise less than the reviews owe: 2041's robot cases wait on three disagreements the controller has to settle, 2073 owes its core-console check first, 2047 still has to show on screen what it left out before you are asked, and 2064 no longer carries the cross-drawing cure (2073 does).
3. Four rows show a head that had already moved on GitHub before the rebuild (2040, 2062, 2066, 2068); 2062 is re-reviewed now (GO), the other three are not.

**Verdict on the board: FIX FIRST** (rows listed below). This is a check of the record, not of any plugin change.

---

## Rows that are wrong against the review record

1. **FOR TIM item 1** ("Trial changes built as drafts: 34 (pull requests 2038 to 2073)"): at 05:56 the trust drafts were 2038 to 2074, 37 in all; 2071 (opened 05:35), 2072 (05:38) and 2074 (05:45) have no row, although the 05:43 review line already named 2071 and 2072 as seen and not reviewed. Item 2's "30 fit ... 4 to fix first" should have said "3 not yet reviewed". After this run: 2071 FIX FIRST, 2072 GO, 2074 FIX FIRST; 2075 new and not reviewed.
2. **Heads left out where the review line states one.** The board's own rule is "a head is shown only where that line states one", but lines of the form "re-reviewed at <head>" state one and get none: row 1 (2040, `d93ebdc0`), row 2 (2041, `31f426ab`), row 3 (2038, `b4c46bd3`), row 4 (2043, `d9600322`), row 5 (2039, `fd9bcce5`). The same pattern shows in rows 6, 7, 9, 10, 12, 25 and 29 to 34 (not checked one by one).
3. **Row 2 (2041), owed:** the GO says the three case-file disagreements (O18, O20, the word "record") must be settled by the controller before the robot runs those cases, and that a "-" pipe end is linked in step 1 but "no owner" in step 5 (`reviews\claude-trust-01-open-line-rereview.md`). The board's "Owed: the robot on copies" leaves that out. I found no record that the controller has settled them (`trust-foundations.md` line 26 still lists them).
4. **Row 17 (2064), title and owed:** the title still says 2064 stops one drawing's record being written into another (BUG-1456). Since 05:53 the review record says PR 2073 replaces 2064's BUG-1456 half, and 2064's other four FIX FIRST items stand (head `d64e9a72`, unchanged at 06:10). The row should name 2064 as "a cancelled command writes nothing" with four items owed.
5. **Row 21 (2073), owed:** the GO is "for the core-console check and the robot on copies" (`reviews\claude-bug-1456-record-own-drawing.md`); `PENDING_TESTS.md` makes the core-console proof `CEPROOFCROSSDRAWING` step 1. The board owes only the robot. Also not carried: the controller item that a tool changing the record in a drawing it never attached still changes the other drawing's record in memory.
6. **Row 24 (2047), owed:** the GO said that before Tim is asked the panel should say what it left out. Still owed: since `f6b2ea12` the sums carry the count, but no window shows it (`reviews\claude-trust04-s-b499-trusses-out-rereview.md`).
7. **Row 1 (2040), owed and evidence:** the GO carried one small fix (an LPD-only copy turns "no CE record / unreadable" into "format not stated") and a caution (the 2500 mm pipe-end level reach is fitted to a made-up drawing whose layout was a guess); neither is on the board. The evidence line "changes nothing, same answer twice" overstates `EVIDENCE_READER.md`, which saw the drawing's change counter and the files untouched but did NOT compare CE's stored record before and after.
8. **Rows 3 (2038) and 4 (2043), owed at 05:56:** each GO carried small fixes (tooltip words before Codex; the kept-copy order before the window). Both are fixed at the new heads (`8da2ec4b`, `a57b9e7e`, re-reviewed this run, GO holds), so going forward the generic "owed" is right; the heads need updating.

## Rows stale against GitHub (right against the review log, which had not caught up)

1. **Row 1 (2040):** head moved to `ebf7a21a` (committed 05:48, hidden command CETRUSTREAD and more); not re-reviewed.
2. **Row 15 (2062):** head moved to `620fe976` (pushed about 05:50); re-reviewed this run: **GO** (MR and CR get only the read-only and REFEDIT checks).
3. **Row 19 (2066):** head moved from `1ff10de2` to `d846f1ed` (committed 05:35); not re-reviewed, and no review line has noticed it.
4. **Row 26 (2068):** head moved from `9c457445` to `e22522d3` (committed 05:55); not re-reviewed.
5. **Row 28 (2070):** moved to `db23f026` at 05:58, after the rebuild; re-reviewed this run: **GO**.

## Rows checked and right

1. **Row 5 (2039):** GO 01:28; the GO's condition (robot steps corrected) is now met: `PENDING_TESTS.md` row 2 has no switch-off step and has the everyday unnumbered case, and the PR description says "squash merge only" and that the switch was removed. Only the head is missing (item 2 above).
2. **Row 8 (2053):** FIX FIRST, head `9ffbeccb`, owed "fix the review list": right; head unchanged at 06:10.
3. **Row 15 (2062):** verdict and head right against the log at 05:56 (stale only, above).
4. **Row 21 (2073)** and **row 17 (2064)** evidence: "6 in 11 tries" matches `EVIDENCE_CROSS_DRAWING.md`. Part 2 of that file (written 05:40 to 06:10: a saved mixed-up drawing reopens with no warning, its Pit Schedule lists the other job's pits, and one U straight after Help restores the drawing's own record) is newer than the board and belongs on 2073's row.

## What I did not check

1. Rows 6, 7, 9 to 14, 16, 18, 20, 22, 23, 25, 27 and 29 to 34 one by one (only the head pattern was seen in them).
2. The plain names of the rows against each PR's own title.
3. No client name, street, suburb or job number is written here.
