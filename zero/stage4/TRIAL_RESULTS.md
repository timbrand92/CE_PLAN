# Stage 4 trial results (zero plan)

**Run by:** the trial chat, from Mon 16 Nov 2026 20:46 Melbourne. **Brief:** `TRIALS_BRIEF.md`. **Code and evidence:** `C:\CE_WORK\trials\zero\` (nothing in this repository except this file).
**Rule for this file:** it is updated after each trial, so a stopped run still leaves a true record. A trial that has not been run says NOT TESTED.

## Where it stands

1. **Trial 11, any direction:** PASS (pure code, no AutoCAD).
2. **Trial 10, headless predicts full:** NOT TESTED yet.
3. **Trial 1, joins:** NOT TESTED yet.
4. **Trial 3, no plugin:** NOT TESTED yet.
5. **Trial 2, grips:** NOT TESTED yet.
6. **Trial 4, speed:** NOT TESTED yet.
7. **Trial 5, Properties:** NOT TESTED yet.
8. **Trial 6, window, live preview and Inspect:** NOT TESTED yet.
9. **Trial 7, ribbon tab, tips and typed names:** NOT TESTED yet.
10. **Trial 8, double-click:** NOT TESTED yet.
11. **Trial 9, update and rollback:** NOT TESTED yet.

---

## Trial 11. Any direction ("hold what is fixed, the rest is worked out")

**Verdict: PASS.** Pure code. No AutoCAD was started. Run Mon 16 Nov 2026 about 20:50 to 21:10.

1. **What was done.** A small solver written as plain C# on .NET 10 with no AutoCAD in it (`C:\CE_WORK\trials\zero\t11\`, files `Brain.cs` and `Program.cs`). Every level is a whole millimetre; a grade is a whole number "1 in N". A fact has a value, a source (given, chosen, worked out, standard) and a hold flag. A sum can be turned round for any one of its facts. The solver starts from the held facts, works out any sum that has exactly one fact missing, records which sum and which facts each worked-out fact came from, and repeats until nothing new appears. Then it checks every sum that has all its facts known.
2. **What was reproduced from the three mock-ups (all matched, to the figure).**
   1. **Pipe window (8.0 m long):** hold upstream 5.23 and grade 1 in 100, downstream comes out 5.15. Hold downstream 5.15 and grade, upstream 5.23. Hold both inverts, grade 1 in 100. Hold 5.23 and 5.14, grade 1 in 89. Flat pipe: grade stays unknown and the solver says the sum cannot be turned round.
   2. **Pit window:** hold cover 5.75 (outlet 5.13), depth 0.62. Hold depth 0.62, cover 5.75. Hold cover and depth, outlet 5.13.
   3. **Run window (four pits P4 to P1 and the connection):** uphill from the connection 4.95 with all grades 1 in 100 gives inverts 5.28, 5.18, 5.08, 5.00 and cover 0.40 at P4 (the mock-up's figure). Downhill from the top 5.30 arrives at 4.97. Holding one end (P3 outlet 5.22) releases that pipe's grade to 1 in 67 and lifts P4 to 5.32. Holding both top 5.30 and connection 4.95 with all grades held is reported as out by 0.02.
   4. **The drop across a pit is a standard that can be typed over.** Left alone it fills in 0.02. With both sides of a pit held (5.10 in, 5.07 out) it is worked out as 0.03, no error, and a check can compare it with the standard (the mock-up's "Needs a look: drop is 0.03, standard is 0.02").
3. **The branched case (20 pits, 19 pipes, 3 branches into a main run of 8).**
   1. **(a) Hold the outlet invert and every grade:** all 20 pit levels match a separate hand calculation (plain recursion, no shared code) to 1 mm. Same answer in 200 shuffled orders of the sums.
   2. **(b) Hold the outlet invert and the upstream invert at every dead end** (grades held except the one beside each dead end): all 20 levels match (a) and the hand calculation; the four released grades come back as grades that give the same fall as (a). Same answer in 200 shuffled orders.
   3. **(c) A deliberately conflicting set** (dead end A1 held 60 mm too low): one conflict, 60 mm. It names the held facts behind it: the outlet, the dead end, the grades and drops of every pipe on the path between, and nothing from the other two branches or the rest of the main run. Same amount and same list in 100 shuffled orders.
   4. **(d) A set missing one fact:** the solver stalls and says exactly one more fact must be held, and lists the 16 facts (of 77) any one of which would do. Holding each of the 16 in turn was tried: every one finishes the job with the right levels.
   5. **(e) Loops:** two sums that need each other (a + b = 10, a − b = 2) and a flow-depends-on-depth-depends-on-flow pair are both reported as "cannot be worked out here" in 2 steps; they do not hang. Hold one of the facts and the loop breaks. A parallel pair of pipes (a looped pair of branches) balances when consistent and is flagged with the amount (80 mm) when not.
   6. **One-way sums:** a "lowest incoming level minus 20 mm" rule works forwards (outlet 4.98) and is NOT turned round: hold the outlet and the incoming levels stay unknown, and the solver says two facts must be held.
4. **Time for 200 pits.** 200 pits, 199 pipes, 398 sums, a random branched tree and one straight run of 200, uphill and from the dead ends: median 0.16 ms, slowest 2.1 ms over 200 runs each. About 800 steps. That is roughly 500 times faster than the one-second line. Measured in a console program on the owner's PC; inside AutoCAD it will be the same code.
5. **Things found that the plan did not say (these matter).**
   1. **A bug in my first version** hid the true cause of a conflict (a held fact kept a stale "worked out by" note from an earlier run). Fixed; the test that caught it stays. The lesson for the build: a held fact must carry no worked-out history, and the conflict report needs its own test.
   2. **Whole-number grades are not unique.** Falls round to 10 mm in the mock-ups, so a grade worked out from two inverts can be 1 in 59 where the designer typed 1 in 60. Both give the same fall. The plan must say whether grades are held as typed (and shown as typed) or recomputed. This is a design question for Tim, not a fault.
   3. **The sum a conflict is blamed on depends on where the two routes meet.** The amount (60 mm) and the list of held facts were the same in every order; the name of the sum varied across 4 different sums over 100 orders, all on the same path. The report should say "somewhere along P4 to P1", not name one pipe.
   4. **When several standards could give way, the last one filled absorbs the whole difference.** With top, connection and all grades held and the three drops left to the standard, the first two drops stayed 0.02 and the third became 0.04. Which standard gives way is a choice the plan has not made (nearest the held end, shared out evenly, or ask). I made the solver fill in list order only to prove it can; that rule is not a recommendation.
   5. **Inequality checks (cover, minimum grade, velocity) were not part of the solver**, as designed. The cover figure was computed afterwards as a check.
6. **What it was NOT:** not run inside AutoCAD, not reading real drawing objects, not tested on a loop of real pipes (a ring of pipes where flow depends on depth), no flow or velocity sums. The sums used are the ones in the mock-ups and the pit and pipe window text only.
7. **Evidence:** `C:\CE_WORK\trials\zero\evidence\t11_any_direction_results.txt` (every check, PASS or FAIL, with the figures). Re-run: `dotnet run` in `C:\CE_WORK\trials\zero\t11`.
8. **What it means for the build approach.** "Hold what is fixed, the rest is worked out" is buildable as plain code with no AutoCAD in it, it is far faster than needed, and over-held, under-held and looped sets can each be reported in plain words with the facts and the amount. The foundation block "sum" stands. The three open choices above (grade held as typed, which standard gives way, how to name a conflict on a path) go to the build design.

---

## What must change in the build approach

*(to be completed when the trials are done; so far nothing has had to change from trial 11)*

## What was not tested and why

*(to be completed when the trials are done)*
