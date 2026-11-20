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

---

# Second answer: dbc49cf (fix round 1 of 2)

**Answer: HOLD THE LIST. Both halves hold it. The next round is the last.** Written Sat 21 Nov 2026, about 5:14 am. Both halves ran on Codex under D-440, each in its own folder:
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\prt2_honest_REPORT.md`. It holds on four reasons.
- **Adversarial half:** gpt-6.2-astra. Report: `prt2_adv_REPORT.md`, with proofs in `prt2_adv_proofs\`. It holds on three.

The `src` and `bench` diff against main is still empty. **Closed:** the one-click Undo, two pits in one window, the guide's bend and width (both archived faulty builds are now caught), the worked branch level against a typed hold, protected-main writes counted by identity, and the crossing guides.

## Reasons to hold (five; each is one restatement or one added case)

1. **The split test stops in set-up** (both halves). E1 (`Stage1A6FixRound1Tests.cs:569`) looks for one "cover" row. The Pit window defines two (`pit.csv` lines 60 and 68) and shows one at a time, so the test throws before it tries the split.
   - **The fix:** read the visible row. Then check the Keep-the-levels or Keep-the-grade choice, and both halves after reopening (D-377 item 8, D-402 item 7, D-436).
2. **The Run command has no test of its own** (both halves). The "Run window" row (`Stage1PipeRunEntryTests.cs:100`) clicks three times and opens Pipe. An entry counter saw one Pipe call and no Run call.
   - **The fix:** seed a joined run and enter it through the Run command (`RunCommand.cs`). Pick one length, return to the whole run, reverse the flow, and edit one length. Check its neighbour and one Undo (D-395, D-413, D-439, page section 1).
3. **The one-planner test is wrong in both directions** (honest half; the adversarial half also leaves it open).
   - **It can reject a right build:** six preview rows demand a public `PlanPicture` property of one shape, plus an extra read under PlanRun. A correct planner working from a read-only snapshot could fail them.
   - **It can pass a wrong one:** a throwaway read could satisfy the trace while a second route makes the proposal. The trace cannot name the proposal that is finally saved.
   - **The fix:** observe the whole proposal handed to the preview and to the protection check, and compare it with the saved edit (D-348).
4. **The pit in the inner-wall fixture has two sizes** (honest half). `SeedPit` stamps a 450 by 450 mm note but leaves the block's own distances at 350 mm.
   - **The effect:** the rows for the two-visit case, the turned pit, EXTEND and STRETCH expect walls at 4,775 and 5,225 mm. A build that follows the drawn wall gives 4,825 and 5,175 mm, and fails.
   - **The fix:** set and read back both distances, or place the 450 mm pit through the Pit tool (D-228, D-410 items 6 and 7).
5. **A second guide on the same layer can disappear** (adversarial half; new). A wrong build that erased every polyline on the chosen guide's layer gave exactly the same 238 results as a right one.
   - **The fix:** add a second guide on that layer, (0,4000) to (10000,4000) mm, 55 mm wide. Require its identity, path and look after OK, Undo and Redo (D-348, D-356, page section 2.7).

## Follow-ups (none holds the list)
1. **The held level:** the 9.920 m held-level fixture is still missing.
2. **B2b:** tie its text check to the branch's own text, since the main's far end also prints 9.90.
3. **The two meetings:** prove the two saved meeting stations are different.
4. **DRAFT label:** mark the extension half of the typed-length test DRAFT.

**Next:** the writer restates or adds these five in the LAST round. After that comes the D-346 hold, or the bounded edit for a list.

---

# Third answer: dcd8c02 (the LAST round)

**Answer: HOLD THE LIST, final. Under the standing rule it gets ONE bounded edit on the five items below. The check room reads it back alone, then ACCEPTS.** Written Sat 21 Nov 2026, about 5:59 am. Both halves ran on Codex under D-440, each in its own folder:
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\prt3_honest_REPORT.md`. It holds on three.
- **Adversarial half:** gpt-6.2-astra. Report: `prt3_adv_REPORT.md`, with proofs in `prt3_adv_proofs\`. It holds on three.

The test diff to `src` and `bench` is still empty. **Closed:** all five items of the second answer (E1 now reaches the split; the Run command on a joined run; the 450 mm pit; the second guide; the planner route through PlanRun) and the six closed before. The three archived faulty builds now fail. Every open item is a fault in the list itself.

## The bounded edit (five restatements)

1. **Watch the proposal at the real hand-offs** (both halves). Read the proposal shown in the open window BEFORE OK, and compare it with the one the doorway checks and saves.
   - **Why:** a click test passed while the window showed 1.00 m for a 10.44 m route, because every observation came after OK.
   - **Also:** do not demand a named diagnostic feed or a replay of the edit on a pretend drawing. A correct planner working from a read-only snapshot must pass. Files: `Fake/PipeRunObservations.cs:34-113`, `Stage1PipeRunEntryTests.cs:69`.
2. **Project a native edit from the drawing as it was before the command** (adversarial half). Count the follow-up writes only from the end of the command.
   - **Why:** a correct 1,000 mm MOVE saved its band at y = 1,000. The observer started after the move and wrongly expected y = 2,000. Files: `Fake/CommandHostCompatibility.cs:136-149`, `Stage1PipeRunEntryTests.cs:260`.
3. **Drive the real grip route** (honest half). The Grip row must invoke the pipe's grip action and check its result, its proposal and one Undo. Today it inserts the 1,200 mm bend itself and sends a made-up "Grip" command-end. The native look stays owed in AutoCAD. Rulings: D-402 item 5, D-407, D-408. Lines: `Stage1PipeRunEntryTests.cs:241-338`.
4. **Pick the branch's join-invert tick by its role** (honest half). Today the selector wants exactly one visible tick captioned "invert", so a branch window that also shows the ordinary invert ticks fails before it checks a level. Select the branch or join tick specifically, as the accepted labels list does. Rulings: D-377 item 6, D-413 item 5. Lines: `Stage1PipeRunAcceptanceTests.cs:703-709`.
5. **The converted band stays open after OK and Redo** (adversarial half). Closing it added a 10 m return segment, and all 239 results still matched the right build. Require it open. Rulings: D-356, D-410. Line: `Stage1PipeRunAcceptanceTests.cs:550`.

**If the read-back fails, the list goes to the control room.**
