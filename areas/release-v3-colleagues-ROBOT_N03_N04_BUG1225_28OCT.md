# Robot job: finish N03 and N04, and reproduce BUG-1225 (Wed 28 Oct 2026, 07:08 to 08:28 Melbourne PC clock)

Job "TEST ROBOT: FINISH N03 AND N04, AND PROVE OR CLEAR BUG-1225" (desk plan/03, Team, Sonnet). Real AutoCAD on test copies only, Tim away, `CE_RUNNER_TIM_AWAY=1`, one session at a time, 3 minutes with AutoCAD closed between sessions. Civil build on every run header: **3.0.83+96455f13** (same in all 16 runs; no install between them). No review.txt written, no runner, driver, ledger-by-hand, DESK_LOG or BUG_CARPARK edit.

## ANSWER FIRST

### FOR TIM

1. **My own mistakes first: none that cost anything.** One thing to know: the runner cannot reopen a drawing inside one case, so each reopen test is a pair of cases run together in one AutoCAD (first drawing, then the fresh copy). That is exactly how the two original refusals happened.
2. **BUG-1225 is REAL and reproduces every time the first drawing placed something.** 8 of 8 sessions that placed a downpipe, or an overflow and front overflow, in the first drawing and then reopened a fresh copy: the second DP or OF was REFUSED ("The source landing could not be refreshed. Nothing will be placed here."). Nothing was placed.
3. **Exact steps (what a drafter would do, to be confirmed by hand):**
   1. Open a drawing that holds pipes (the test drawing DRV1_B1, 1034 objects).
   2. Place a downpipe with DP (or an overflow with OF) in empty ground. It places fine.
   3. Close the drawing without saving, and open the same drawing again fresh, in the same AutoCAD.
   4. Run DP (or OF) in empty ground again. **It is refused**; the command line says "[CE] The source landing could not be refreshed. Nothing will be placed here." and nothing is drawn. It took about 14 seconds to give up, against about 29 seconds to place.
4. **What narrows it (all on 3.0.83):**
   1. **Reopen alone does not do it:** first drawing with nothing placed, then reopen, DP places normally (2 of 2 sessions).
   2. **It is not a short timing effect:** waiting 60 seconds after the reopen before typing DP made no difference (2 of 2 still refused).
   3. **It is not only downpipes:** OF behaves the same way (3 of 3 refused), and the first-drawing placement of OF and FO is what sets it up.
   4. **Not shown:** whether a drafter's own close and reopen does the same thing as the runner's reopen, and whether the first-drawing placement has to be a source placement of this kind (a plain pit was not tried). Tim or Codex should do the 4 steps by hand once.
5. **N03 (OF and FO) is ready for the independent reviewer.** The edited case now checks the full tags (OF1 and FO1) and both plan labels (OF and FO). It passed in two separate sessions on 3.0.83, and its broken twin, run alone as the first and only case of its own session, failed for the intended reason: "Front overflow placed. Tag: FO" was missing while OF placed normally.
6. **N04 (downpipe and raingarden) passes again in two separate sessions and its twin fails for the right reason, each as the first case of its own session.** It is ready for the reviewer for what it proves (no pipe nearby). Two things stay open and are not mine to settle: the card asks for an "RG label" that no run has seen, and the DP refusal above means the reviewer should read N04 with BUG-1225 beside it (N04 itself is unaffected because it ran as the first case of its session).
7. **Nothing for you to decide or test now.** After a fix goes in, the robot test for it is N13 and N14.

---

### Run ids and detail (the desk's part)

1. **N03 (hash AADE74748DAF, edited this job; the earlier passes no longer count):**
   1. RUN-20261028-0708-C3.0.83-rn3a: PASS (session 1). RUN-20261028-0714-C3.0.83-rn3b: PASS (session 2, a separate AutoCAD start).
   2. New lines proved: `history has "Overflow placed. Tag: OF1."`, `history has "Front overflow placed. Tag: FO1."`, `matches $new_texts "(^|\| )OF( \||$)"` (matched '| OF |') and the FO one (matched '| FO'). Both runs.
   3. **N03_BROKEN (hash 9B3809FF2506, unchanged), RUN-20261028-0719-C3.0.83-rn3t, first and only case of its session, `-NoRerun`:** FAIL as intended. Failing check 2: `history has "Front overflow placed. Tag: FO"` -> "no command-line line contains 'Front overflow placed. Tag: FO' (16 lines read: Command: | Command: OF | Specify overflow insertion point: 150000,-80000 ...)". Check 1 (OF placed, "Overflow placed. Tag: OF1.") passed, so the red is the FO line missing and not a refused OF. Outcome lines: OF completed 29494 ms, OF completed 32459 ms.
2. **N04 (hash 74CA6C503ADD, unchanged; earlier passes still count) and twin:**
   1. RUN-20261028-0724-C3.0.83-rn4a: PASS. RUN-20261028-0729-C3.0.83-rn4b: PASS. Each the first case of its own session. DP printed "Downpipe placed. Tag: DP1." with the "Nothing nearby" sentence; "Raingarden RG2 placed. 4 vertices, 12.0 m²." (the drawing already holds an RG1); one U echoes CDRG.
   2. **N04_BROKEN (hash DE3C4B2DB50B), RUN-20261028-0734-C3.0.83-rn4t, first and only case of its session:** FAIL as intended on `equals $c3 $c1` (no U, so the raingarden stays). Because DP placed normally in this session, the count it compares is the right one (the n27a4 twin had the downpipe refused).
3. **BUG-1225 reproduction (new cases, all in `C:\Lisp Files\_ACAD_DRIVER\cases\`, each pair run with `run-pack cases -Only "<first>,<second>" -NoRerun`):**
   1. **N13a (DP in first drawing) then N13 (DP after the runner's reopen-copy), 3 fresh sessions:** rn13a (RUN-20261028-0738), rn13b (0743), rn13c (0748). **FAIL x3**, N13a PASS x3. Refusal in the history, "DP cancelled" 13.7 to 14.3 s, count of new downpipes 0, same line in the CE log ("[Source] The pick was refused: ...").
   2. **N14a (OF and FO in first drawing) then N14 (OF after reopen), 3 fresh sessions:** rn14a (RUN-20261028-0753), rn14b (0758), rn14c (0803). **FAIL x3**, N14a PASS x3. Same refusal ("OF cancelled" about 14 s).
   3. **N13b (nothing placed in the first drawing) then N13c (DP after reopen), 2 sessions:** rn13n1 (RUN-20261028-0809), rn13n2 (0820). **PASS x2** (DP1 placed, no refusal). So the reopen alone is not enough.
   4. **N13a then N13d (same as N13 but `sleep 60` after the reopen), 2 sessions:** rn13w1 (RUN-20261028-0814), rn13w2 (0824). **FAIL x2**, same refusal.
   5. **Tally: refusal in 8 of 8 sessions where the first drawing placed a source; 0 of 2 where it placed nothing.**
4. **The full refusal text (CE log, session rn14c at 08:05:53, drawing DRV1_B1):**
   1. `[WARN] [Source] Final landing refresh refused: The complete landing index has missing or unreadable drawing evidence (Source evidence changed during capture: <pipe row handle>:pipe-row [first {...} | then {...}]; ...)` followed by `[INFO] [Source] The pick was refused: The source landing could not be refreshed. Nothing will be placed here. Reason: <the same text>`, then `Command outcome: OF cancelled 13941 ms`.
   2. Rows named in the "changed during capture" list (from that log line): 1091A0, 1091E0, 109359, 109390, 1093C7, 109430, 1094BE, 109500 and more (the line is clipped in the log at about 2500 characters). In each, the first read of the pipe row has no pipe identity key (`spineKey`) and the second read has one (for example 1091A0 first: from AGI, to C1, `toSpineKey` only; then: `spineKey CE-CIV-PIPE-9DF9...` added).
   3. Lines just before it in the same log: "[Spine] pipe row 1135E9 took the identity already on its polyline during source placement", "CDRG index filled pipe 11362F From end key 'CE-CIV-SRC-...' from physical start".
   4. **Reading (a guess, not proven):** on the reopened drawing the capture itself stamps pipe identities onto pipe rows, so the "second read" differs from the "first read" and the safety check refuses. The log line suggests this happens only when the first drawing had already placed a source in this AutoCAD session (some state survives the close). Needs the code owner: `SourcePlacementService.cs` line 282, `LinkService.SourceLanding.cs` line 129 and `LinkService.SourceChanges.cs` line 39 at 96455f13 (as named in the Opus review).
5. **What is not tested (RULES 5.9):** nothing was done by hand in AutoCAD; no picture was looked at; a plain pit or CD pipe as the first-drawing placement was not tried; a real drafter's close and reopen (File > Close without saving, then File > Open) was not tried; whether a CE-level "refresh landing index" is attempted after the refusal was not looked at; the missing "RG label" for D07 was not checked.
6. **Case files written or edited (all in `C:\Lisp Files\_ACAD_DRIVER\cases\`):** edited N03 (the two new tag lines and two label lines); new N13a, N13, N14a, N14, N13b, N13c, N13d. N03_BROKEN, N04, N04_BROKEN untouched. Scratch: `C:\ce-fx\robot_n03n04\` (chain scripts and run logs). Every case hash is in the run JSON.
7. **Ready for the independent reviewer:** N03 and N03_BROKEN (hashes above), N04 and N04_BROKEN (hashes above). N13, N14 and their helper cases are reproduction cases that FAIL today by design of the bug; they should be marked as the guard for BUG-1225 (Test that catches it) and need no review until a fix is installed. Do not mark BUG-1225 FIXED.
8. **Left running:** nothing. No AutoCAD was left open, no background process remains (the chain scripts ended with their last session).

## Summary (under 100 words)

N03 now checks full tags and labels: PASS in two sessions on Civil 3.0.83, and its twin fails for the intended reason (FO line missing, OF placed). N04 passes twice, twin red correctly. BUG-1225 is real: after a first drawing places a downpipe or overflow, then a fresh copy is reopened in the same AutoCAD, DP and OF are refused in 8 of 8 sessions; reopen alone is fine and a 60 s wait does not help. Cases N13, N14 are the guards. N03 and N04 are ready for the independent reviewer.
