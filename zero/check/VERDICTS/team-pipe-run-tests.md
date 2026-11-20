# Answer: the pipe-run test list, team/pipe-run at b46bb2e (tests only, from design\PIPE_RUN.md 3d2ddd1)

**Answer: HOLD THE LIST (first round). Both halves hold it.** Written Sat 21 Nov 2026, about 3:47 am.

**How it was checked:** both halves built the whole solution, CeCivil.Acad included, and ran the list and the suite.
- **Honest half:** one Claude helper on Sonnet. Report: `C:\CE_WORK\check\reports\prt_honest_REPORT.md`. It holds on one reason and finds the 44 new cases otherwise sound.
- **Adversarial half:** Codex gpt-6.2-astra. Report: `C:\CE_WORK\check\reports\prt_adv_REPORT.md`, with proofs in `prt_adv_proofs\`. It holds on seven reasons and wrote a one-file wrong build that turns a target green.

## Reasons to hold (each is one restatement or one added case)

1. **B5b expects the old Undo** (honest half). See `Stage1A6LastRoundTests.cs:182-193`.
   - **The case:** three clicks, then U, then two more clicks.
   - **What the test wants:** the run [(0,0), (0,9000), (8000,9000)], so one U takes back two clicks.
   - **What the ruling says:** D-413 item 12 and page section 1.2 say U steps back ONE click, which gives [(0,0), (5000,0), (0,9000), (8000,9000)]. The test passes on main, which proves it pins the old behaviour.
   - **The fix:** restate it to the one-click result.
2. **A pit placed on a pipe is refused** (adversarial half). E1 (`Stage1A6FixRound1Tests.cs:522-532`) wants "not built yet" and no pit. D6 (`Stage1A6LastRoundTests.cs:470-479`) wants two pits from three placements.
   - **What the ruling says:** D-377 item 8, page lines 41 and 75, D-402 and D-436 require the pipe to split. The typed end levels stay with their halves, and the Pit window owns the new pit's levels and its 0.020 m drop.
   - **The fix:** restate both. Give D6 a genuinely protected middle placement so it keeps its retry check.
3. **Two selected pits open no window** (adversarial half). See F2, `Stage1A6FixRound1Tests.cs:559-586`.
   - **What the ruling says:** D-381 item 5 gives same-kind selections one window, with "Varies" where values differ.
   - **The fix:** restate F2 with two pits whose values differ. Keep F3 as the separate refusal for a mixed pit-and-pipe selection.
4. **A guide can lose its bend and still pass** (adversarial half). See `Stage1PipeRunAcceptanceTests.cs:465-490`.
   - **The fault:** the Redo test records whatever the build drew as its expected result. A one-file wrong build removed a 1.500 m offset and shortened the route by 0.440 m, and the test went green.
   - **The fix:** compare the reopened vertices and width with figures worked out independently, after OK and after Redo.
5. **A worked branch level is stored as a typed hold** (adversarial half). See carried D4 (`Stage1A6FixRound1Tests.cs:463`) against the new test at `Stage1PipeRunAcceptanceTests.cs:67-73`.
   - **What the ruling says:** D-413 items 5 and 7 separate "show the invert" from "type a held level".
   - **The fix:** reopen the drawing and change the main's upstream figure. The branch must follow unless a hold was actually typed.
6. **A write to a protected main can be missed** (adversarial half). See `Stage1PipeRunAcceptanceTests.cs:264-285` and `Fake/FakeDrawing.cs:445`.
   - **The fault:** the test only looks for log lines ending "on <handle>". Removal ("from"), geometry changes and erasure are logged in other words. A temporary change that is then rolled back leaves the same final picture. Ruling: D-348.
   - **The fix:** count every attempted operation by object identity and expect zero for the main. Also check its final layer and lock, and exactly one named refusal.
7. **The one-planner route is not tested from each entry** (adversarial half).
   - **The fault:** the cases call a command or apply a planned change straight to the fake drawing. Carried `Stage1A6Round2Tests.cs:57` still calls the old single-pipe planner, so a second planner could survive. Rule: page lines 35-56 and design rule 1.
   - **The fix:** for each entry the page names, check that the proposal shown to the drafter is the same one the doorway checks and saves.
8. **The original crossing-guide fault is not kept** (adversarial half). See `Stage1PipeRunAcceptanceTests.cs:102`.
   - **The fault:** the new guide stays on one side of the centreline. A6's replay ran from +60 to −4,000 mm, then reversed, and erased the guide in both directions.
   - **The fix:** keep the new same-side cases and add the two crossing cases.

## Follow-ups (none holds the list)
1. **The 9.920 m case:** the held-invert case still needs its saved-drawing fixture.
2. **Refusal wording:** tighten it so each refusal names the layer or part. Today's lock patterns match any existing locked-style refusal.
3. **DRAFT rows:** mark the extension row of the typed-length test (line 316) DRAFT. Its "Needs a look" wording and its button label go beyond the page.
4. **The guide Undo case:** it cannot fail on lost width, layer or colour, because the fake drawing restores everything.

**Next:** the writer restates or adds the eight cases above in one round. The check room then reruns them against right and wrong builds.
